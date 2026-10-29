local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local function RequireGameModule(...)
	local pathSegments = { ... }
	local callOk, loadedModule = pcall(function()
		local currentInstance = ReplicatedStorage
		for _, segmentName in ipairs(pathSegments) do
			currentInstance = currentInstance
				and (currentInstance:FindFirstChild(segmentName) or currentInstance:WaitForChild(segmentName, 3))
		end
		return currentInstance and require(currentInstance) or nil
	end)
	if callOk and type(loadedModule) == "table" then
		return loadedModule
	end
	return nil
end

local AreaEggCycleModule = RequireGameModule("Shared", "Util", "AreaEggCycle")

local Modes = {
	UntilAnEggMatches = "Until An Egg Matches",
	StealThenHop = "Steal Then Hop",
	AfterARareSpawns = "After A Rare Spawns",
}

local ModeOptions = { Modes.UntilAnEggMatches, Modes.StealThenHop, Modes.AfterARareSpawns }

local HOP_SERVER_MODE = "Least Players"
local SCAN_GRACE_SEC = 3
local CARRIED_WAIT_SEC = 12
local NIGHT_GUARD_SEC = 20

local EggFinder = {
	Mode = Modes.StealThenHop,
	Link = true,
	Enabled = false,
	Disposed = false,
	MinRarity = 0,
	Areas = {},
	Specific = {},
	MinIncome = 0,
	RareMin = 0,
	RareLabel = "Any",
	HopDelay = 5,
	Window = 0,
	WindowMode = nil,
	CarriedSince = nil,
	Generation = 0,
	LoadedAt = 0,
	DeliverySerial = 0,
	Delivered = false,
	Status = "Idle",
	StatusView = nil,
	Controls = {},
	LinkSignature = "",
	Applying = false,
}

local function HubState()
	local globalEnv = (type(getgenv) == "function" and getgenv()) or _G
	local hubState = type(globalEnv) == "table" and globalEnv.N3Hub_State or nil
	if type(hubState) ~= "table" then
		return nil
	end
	return hubState
end

local function Core()
	local hubState = HubState()
	return hubState and hubState.Hub or nil
end

local function FarmSetup()
	local hubState = HubState()
	return hubState and hubState.FarmConfig or nil
end

local function EngineApi()
	local hub = Core()
	return hub and hub.Engine or nil
end

local function Catalog()
	local hub = Core()
	return hub and hub.Catalogs or nil
end

local function ToNumber(rawValue, fallbackValue)
	local numeric = tonumber(rawValue)
	if numeric and numeric == numeric and numeric ~= math.huge and numeric ~= -math.huge then
		return numeric
	end
	return fallbackValue or 0
end

local function FormatClock(seconds)
	local totalSeconds = math.max(0, math.floor(seconds))
	local minutes = math.floor(totalSeconds / 60)
	if minutes >= 60 then
		return string.format("%dh %02dm", math.floor(minutes / 60), minutes % 60)
	end
	return string.format("%dm %02ds", minutes, totalSeconds % 60)
end

local function SortedKeys(selectionMap)
	local keys = {}
	for keyValue, isSelected in pairs(selectionMap or {}) do
		if isSelected then
			table.insert(keys, tostring(keyValue))
		end
	end
	table.sort(keys)
	return table.concat(keys, ",")
end

local function SetStatus(statusText)
	EggFinder.Status = tostring(statusText)
	if EggFinder.StatusView then
		pcall(EggFinder.StatusView.SetValue, EggFinder.StatusView, EggFinder.Status)
	end
end

local function AutoStealOn()
	local config = FarmSetup()
	return config ~= nil and (config.AutoStealEnabled == true or config.AutoStealAll == true)
end

local function StealBusy()
	local engine = EngineApi()
	if not engine then
		return false
	end
	local carryState = engine.AutoCarry or {}
	return engine.AutoCycle ~= nil or carryState.Carrying == true
end

local function CarriedUid()
	local engine = EngineApi()
	local carryState = engine and engine.AutoCarry or {}
	if carryState.Carrying == true and carryState.CarryUid ~= nil then
		return tostring(carryState.CarryUid)
	end
	return nil
end

local function IsNightOrSealed()
	local engine = EngineApi()
	if not engine then
		return false
	end
	local nightOk, isNight = pcall(engine.IsNight)
	if nightOk and isNight == true then
		return true
	end
	local sealedOk, isSealed = pcall(engine.WallSealed)
	return sealedOk and isSealed == true
end

local function NextNightRemaining()
	if type(AreaEggCycleModule) ~= "table" or type(AreaEggCycleModule.NextNightTime) ~= "function" then
		return nil
	end
	local callOk, nextNightTime = pcall(AreaEggCycleModule.NextNightTime, Workspace:GetServerTimeNow())
	local numericTime = callOk and tonumber(nextNightTime) or nil
	if not numericTime then
		return nil
	end
	return math.max(0, numericTime - Workspace:GetServerTimeNow())
end

local function RarityLabelForRank(rarityRank)
	local catalog = Catalog()
	if not catalog or rarityRank <= 0 then
		return "Any"
	end
	for _, rarityName in ipairs(catalog.Rarities or {}) do
		if ToNumber(catalog.RarityRankByKey[catalog.NormalizeRarityKey(rarityName)], 0) == rarityRank then
			return rarityName
		end
	end
	return "Any"
end

local function RankForRarityLabel(rarityLabel)
	local catalog = Catalog()
	if not catalog or rarityLabel == nil or rarityLabel == "Any" then
		return 0
	end
	return ToNumber(catalog.RarityRankByKey[catalog.NormalizeRarityKey(rarityLabel)], 0)
end

local function AreasFromSelection(selectedValues)
	local areas = {}
	for optionKey, isSelected in pairs(selectedValues or {}) do
		if isSelected then
			areas[tostring(optionKey)] = true
		end
	end
	if next(areas) == nil then
		local catalog = Catalog()
		for _, areaName in ipairs((catalog and catalog.AreaNames) or {}) do
			areas[areaName] = true
		end
	end
	return areas
end

local function SpecificFromSelection(selectedValues)
	local specific = {}
	for optionKey, isSelected in pairs(selectedValues or {}) do
		if isSelected then
			specific[string.lower(tostring(optionKey))] = true
		end
	end
	return specific
end

local function AreasToSelection()
	local catalog = Catalog()
	local selection = {}
	for _, areaName in ipairs((catalog and catalog.AreaNames) or {}) do
		if EggFinder.Areas[areaName] or EggFinder.Areas[string.lower(areaName)] then
			selection[areaName] = true
		end
	end
	return selection
end

local function SpecificToSelection()
	local catalog = Catalog()
	local selection = {}
	for _, eggName in ipairs((catalog and catalog.EggNames) or {}) do
		if EggFinder.Specific[string.lower(eggName)] then
			selection[eggName] = true
		end
	end
	return selection
end

local function StealSignature()
	local config = FarmSetup()
	if not config then
		return ""
	end
	return string.format(
		"%s|%s|%s",
		SortedKeys(config.SelectedRarities),
		SortedKeys(config.SelectedZones),
		SortedKeys(config.SelectedEggs)
	)
end

local function ApplyRarityToStealFilter()
	local hub = Core()
	local dropdowns = hub and hub.UI and hub.UI.Dropdowns
	if not dropdowns or not dropdowns.FarmRarities then
		return
	end
	local rarityLabel = EggFinder.MinRarity > 0 and RarityLabelForRank(EggFinder.MinRarity) or "Any"
	dropdowns.FarmRarities:SetValue(rarityLabel ~= "Any" and { [rarityLabel] = true } or {})
end

local function PushToSteal()
	local hub = Core()
	local dropdowns = hub and hub.UI and hub.UI.Dropdowns
	if not EggFinder.Link or EggFinder.Applying or not dropdowns then
		return
	end
	EggFinder.Applying = true
	if dropdowns.FarmZones then
		dropdowns.FarmZones:SetValue(AreasToSelection())
	end
	if dropdowns.FarmEggs then
		dropdowns.FarmEggs:SetValue(SpecificToSelection())
	end
	ApplyRarityToStealFilter()
	EggFinder.LinkSignature = StealSignature()
	EggFinder.Applying = false
end

local function PullFromSteal()
	local config = FarmSetup()
	local catalog = Catalog()
	if not config or not catalog then
		return
	end
	EggFinder.Applying = true

	local rarityRank = 0
	for rarityKey in pairs(config.SelectedRarities or {}) do
		local rankValue = ToNumber(catalog.RarityRankByKey[catalog.NormalizeRarityKey(rarityKey)], 0)
		if rankValue > 0 and (rarityRank == 0 or rankValue < rarityRank) then
			rarityRank = rankValue
		end
	end
	EggFinder.MinRarity = rarityRank

	local areas = {}
	for areaKey in pairs(config.SelectedZones or {}) do
		areas[tostring(areaKey)] = true
	end
	EggFinder.Areas = next(areas) ~= nil and areas or AreasFromSelection(nil)

	local specific = {}
	for eggKey in pairs(config.SelectedEggs or {}) do
		specific[string.lower(tostring(eggKey))] = true
	end
	EggFinder.Specific = specific

	if EggFinder.Controls.MinRarity then
		EggFinder.Controls.MinRarity:SetValue(rarityRank > 0 and RarityLabelForRank(rarityRank) or "Any")
	end
	if EggFinder.Controls.Areas then
		EggFinder.Controls.Areas:SetValue(AreasToSelection())
	end
	if EggFinder.Controls.Eggs then
		EggFinder.Controls.Eggs:SetValue(SpecificToSelection())
	end

	EggFinder.LinkSignature = StealSignature()
	EggFinder.Applying = false
end

local function PollStealFilters()
	if not EggFinder.Link or EggFinder.Applying then
		return
	end
	if StealSignature() ~= EggFinder.LinkSignature then
		PullFromSteal()
	end
end

local function MatchesFinder(record)
	if next(EggFinder.Areas) ~= nil then
		if not EggFinder.Areas[record.Zone] and not EggFinder.Areas[string.lower(record.Zone)] then
			return false
		end
	end
	if ToNumber(record.Rank, 0) < EggFinder.MinRarity then
		return false
	end
	if next(EggFinder.Specific) ~= nil and not EggFinder.Specific[string.lower(record.Category)] then
		return false
	end
	if EggFinder.MinIncome > 0 and ToNumber(record.Income, 0) < EggFinder.MinIncome then
		return false
	end
	return true
end

local function MatchesStealFilter(record)
	local engine = EngineApi()
	if not engine or type(engine.MatchesStealFilters) ~= "function" then
		return false
	end
	local callOk, isMatch = pcall(engine.MatchesStealFilters, record.Zone, record.Category, record.Rarity)
	return callOk and isMatch == true
end

local function ResetWindow()
	EggFinder.Window = 0
	EggFinder.WindowMode = nil
end

local function SetHopWindow()
	if type(AreaEggCycleModule) ~= "table" or type(AreaEggCycleModule.NextNightTime) ~= "function" then
		return
	end
	local nowTime = Workspace:GetServerTimeNow()
	local callOk, nextNightTime = pcall(AreaEggCycleModule.NextNightTime, nowTime)
	local numericTime = callOk and tonumber(nextNightTime) or nil
	if not numericTime or numericTime <= nowTime then
		return
	end
	if EggFinder.Window == numericTime and EggFinder.WindowMode == EggFinder.Mode then
		return
	end
	EggFinder.Window = numericTime
	EggFinder.WindowMode = EggFinder.Mode
end

local function WindowRemaining()
	if EggFinder.Window <= 0 then
		return 0
	end
	local nowTime = Workspace:GetServerTimeNow()
	if EggFinder.Window <= nowTime then
		ResetWindow()
		return 0
	end
	if EggFinder.WindowMode ~= EggFinder.Mode then
		return 0
	end
	return EggFinder.Window - nowTime
end

local function WithWindow(statusText, remainingSeconds)
	if remainingSeconds <= 0 then
		return statusText
	end
	return string.format("%s  |  hop run %s left", statusText, FormatClock(remainingSeconds))
end

local function SurveyField()
	local engine = EngineApi()
	if not engine or type(engine.SurveyFieldEggs) ~= "function" then
		return nil
	end
	local callOk, records = pcall(engine.SurveyFieldEggs)
	if not callOk or type(records) ~= "table" then
		return nil
	end

	local carryingUid = CarriedUid()
	local survey = {
		Free = 0,
		FreeSteal = 0,
		Carried = 0,
		Mine = false,
		Rare = false,
		Best = nil,
	}

	for _, record in ipairs(records) do
		local eggUid = tostring(record.Uid or "")
		local eggState = tostring(record.State or "")
		local isFree = eggState == "Slot" or eggState == "Dropped"
		local isCarried = eggState == "Carried"
		if eggUid ~= "" and eggState ~= "Claimed" and (isFree or isCarried) then
			if ToNumber(record.Rank, 0) >= EggFinder.RareMin then
				survey.Rare = true
			end
			if MatchesFinder(record) then
				local isMine = carryingUid ~= nil and eggUid == carryingUid
				if isMine then
					survey.Mine = true
				elseif isFree then
					survey.Free += 1
					if MatchesStealFilter(record) then
						survey.FreeSteal += 1
					end
				elseif isCarried then
					survey.Carried += 1
				end
				if not survey.Best or record.Income > survey.Best.Income then
					survey.Best = record
				end
			end
		end
	end

	return survey
end

local function TrackDelivery()
	local engine = EngineApi()
	local deliverySerial = engine and ToNumber(engine.AutoDeliverySerial, 0) or 0
	if deliverySerial > EggFinder.DeliverySerial then
		EggFinder.DeliverySerial = deliverySerial
		EggFinder.Delivered = true
	end
end

local function RequestHop()
	local hub = Core()
	local hopFn = hub and hub.ServerHop
	if type(hopFn) ~= "function" then
		return "missing"
	end
	local callOk, hopResult = pcall(hopFn, HOP_SERVER_MODE)
	if not callOk then
		return "error"
	end
	return tostring(hopResult)
end

local HopMessages = {
	waiting = "Teleport is slow, trying another server",
	empty = "Every listed server is full, searching again",
	fetch = "Server list unavailable, waiting a moment",
	denied = "That server filled up on join, taking the next one",
	busy = "Server hop is still running, trying again",
}

local function IsCurrentRun(generation)
	return EggFinder.Enabled == true and EggFinder.Disposed == false and EggFinder.Generation == generation
end

local function VerifyFieldEmptyBeforeHop(generation)
	if not IsCurrentRun(generation) then
		return
	end
	SetStatus("Checking the field one last time")
	local survey = SurveyField()
	if not IsCurrentRun(generation) then
		return
	end
	if not survey then
		SetStatus("Could not read the eggs, checking again")
		task.wait(1)
		return
	end
	if survey.Free > 0 or survey.Mine or survey.Carried > 0 or StealBusy() then
		SetStatus("A filter egg showed up, hop cancelled")
		return
	end
	if IsNightOrSealed() then
		return
	end

	SetStatus("Joining a less crowded server")
	local hopResult = RequestHop()
	if not IsCurrentRun(generation) then
		return
	end
	SetStatus(HopMessages[hopResult] or "Hop did not land, trying again")
	task.wait(hopResult == "fetch" and 5 or 1.5)
end

local function DecideStayOrHop(survey)
	if os.clock() - EggFinder.LoadedAt < SCAN_GRACE_SEC then
		return "Scanning this server", false
	end

	if survey.Mine or StealBusy() then
		return "Auto Steal is taking an egg, hop waits", false
	end

	local autoStealOn = AutoStealOn()

	if survey.FreeSteal > 0 and autoStealOn then
		local best = survey.Best
		local eggName = best and best.Category or "a filter egg"
		local statusText = survey.FreeSteal == 1
			and string.format("Filter egg here (%s), stealing it first", eggName)
			or string.format("%d filter eggs here, stealing them first", survey.FreeSteal)
		return statusText, false
	end

	if survey.Free > 0 and (EggFinder.Mode == Modes.UntilAnEggMatches or not autoStealOn) then
		local best = survey.Best
		return string.format("Found %s, staying here", best and best.Category or "a filter egg"), false
	end

	if survey.Carried > 0 and (EggFinder.CarriedSince == nil or os.clock() - EggFinder.CarriedSince < CARRIED_WAIT_SEC) then
		EggFinder.CarriedSince = EggFinder.CarriedSince or os.clock()
		return "Someone carries a filter egg, waiting in case it drops", false
	end

	local nextNightRemaining = NextNightRemaining()
	if nextNightRemaining and nextNightRemaining < NIGHT_GUARD_SEC then
		return "Night is close, staying here", false
	end

	local windowRemaining = WindowRemaining()

	if EggFinder.Mode == Modes.UntilAnEggMatches then
		return nil, true
	end

	if EggFinder.Mode == Modes.StealThenHop then
		if windowRemaining > 0 then
			return WithWindow("Waiting for Auto Steal to bring home a filter egg", windowRemaining), false
		end
		if autoStealOn then
			return "Waiting for Auto Steal to bring home a filter egg", false
		end
		return "Turn on Auto Steal, hopping starts after it brings home a filter egg", false
	end

	if windowRemaining > 0 then
		return WithWindow(string.format("Waiting for a %s egg to spawn here", EggFinder.RareLabel), windowRemaining), false
	end
	return string.format("Waiting for a %s egg to spawn here", EggFinder.RareLabel), false
end

local function RunLoop(generation)
	local hopDeadline = nil

	while IsCurrentRun(generation) do
		local stepWait = 0.5

		if IsNightOrSealed() then
			ResetWindow()
			hopDeadline = nil
			if EggFinder.Mode == Modes.UntilAnEggMatches then
				SetStatus("Night, waiting for the egg reset")
			else
				SetStatus("Night, today's hop run is over")
			end
			task.wait(1)
			continue
		end

		local survey = SurveyField()
		if not survey then
			hopDeadline = nil
			SetStatus("Reading the eggs in this server")
			task.wait(1)
			continue
		end

		TrackDelivery()

		if survey.Rare and EggFinder.Mode == Modes.AfterARareSpawns then
			SetHopWindow()
		end
		if EggFinder.Delivered and EggFinder.Mode == Modes.StealThenHop then
			SetHopWindow()
			EggFinder.Delivered = false
		end
		if survey.Carried == 0 then
			EggFinder.CarriedSince = nil
		end

		local statusText, shouldHop = DecideStayOrHop(survey)

		if statusText then
			hopDeadline = nil
			SetStatus(statusText)
			stepWait = 0.4
		elseif shouldHop then
			if not hopDeadline then
				hopDeadline = math.max(os.clock() + 1.5, EggFinder.LoadedAt + EggFinder.HopDelay)
			end
			local remainingSeconds = hopDeadline - os.clock()
			if remainingSeconds > 0 then
				SetStatus(string.format("No filter egg here, hopping in %.1fs", remainingSeconds))
				stepWait = math.min(0.25, remainingSeconds)
			else
				hopDeadline = nil
				VerifyFieldEmptyBeforeHop(generation)
				stepWait = 0
			end
		else
			hopDeadline = nil
		end

		if stepWait > 0 then
			task.wait(stepWait)
		end
	end
end

local function StartLoop()
	EggFinder.Generation += 1
	local generation = EggFinder.Generation
	EggFinder.Enabled = true
	EggFinder.LoadedAt = os.clock()
	ResetWindow()
	SetStatus("Scanning this server")
	task.spawn(function()
		local callOk, loopError = pcall(RunLoop, generation)
		if not callOk and EggFinder.Generation == generation then
			EggFinder.Enabled = false
			SetStatus("Stopped: " .. tostring(loopError))
			print(string.format("[N3 Hub] Egg Finder stopped: %s", tostring(loopError)))
		end
	end)
end

local function StopLoop()
	EggFinder.Generation += 1
	EggFinder.Enabled = false
	EggFinder.CarriedSince = nil
	ResetWindow()
	SetStatus("Idle")
end

function EggFinder.Stop()
	StopLoop()
	EggFinder.Disposed = true
end

function EggFinder.Build(groupbox)
	local hub = Core()
	local catalog = Catalog()
	if not hub or not catalog then
		return
	end

	EggFinder.Applying = true

	local engine = EngineApi()
	EggFinder.DeliverySerial = engine and ToNumber(engine.AutoDeliverySerial, 0) or 0

	EggFinder.RareLabel = "Any"
	for _, rarityName in ipairs(catalog.Rarities or {}) do
		if rarityName == "Cosmic" then
			EggFinder.RareLabel = "Cosmic"
		end
	end
	if EggFinder.RareLabel == "Any" and #catalog.Rarities > 0 then
		EggFinder.RareLabel = catalog.Rarities[#catalog.Rarities]
	end
	EggFinder.RareMin = RankForRarityLabel(EggFinder.RareLabel)
	EggFinder.Areas = AreasFromSelection(nil)
	EggFinder.Specific = {}

	local rarityOptions = {}
	for _, rarityName in ipairs(catalog.Rarities or {}) do
		if rarityName ~= "Any" then
			table.insert(rarityOptions, rarityName)
		end
	end

	local rareDefault = rarityOptions[1] or "Any"
	for _, rarityName in ipairs(rarityOptions) do
		if rarityName == EggFinder.RareLabel then
			rareDefault = rarityName
			break
		end
	end

	EggFinder.Controls.HopMode = groupbox:AddDropdown("Dropdown_EggFinder_HopMode", {
		Text = "Hop Mode",
		Values = ModeOptions,
		Default = EggFinder.Mode,
		Tooltip = "When to move on to the next server",
		Callback = function(selectedMode)
			if type(selectedMode) == "string" and selectedMode ~= "" and selectedMode ~= EggFinder.Mode then
				EggFinder.Mode = selectedMode
			end
		end,
	})

	EggFinder.Controls.RareRarity = groupbox:AddDropdown("Dropdown_EggFinder_RareRarity", {
		Text = "Rarity To Wait For",
		Values = rarityOptions,
		Default = rareDefault,
		Tooltip = "For After A Rare Spawns: this rarity or higher",
		Callback = function(selectedRarity)
			local rankValue = RankForRarityLabel(selectedRarity)
			if rankValue > 0 then
				EggFinder.RareMin = rankValue
				EggFinder.RareLabel = tostring(selectedRarity)
			end
		end,
	})

	EggFinder.Controls.MinRarity = groupbox:AddDropdown("Dropdown_EggFinder_MinRarity", {
		Text = "Min Rarity",
		Values = catalog.MinRarityOptions,
		Default = 1,
		Tooltip = "Find eggs of the chosen rarity and every rarity above it",
		Callback = function(selectedRarity)
			EggFinder.MinRarity = RankForRarityLabel(selectedRarity)
			PushToSteal()
		end,
	})

	EggFinder.Controls.Areas = groupbox:AddDropdown("Dropdown_EggFinder_Areas", {
		Text = "Target Areas",
		Values = catalog.AreaNames,
		Default = catalog.AreaNames,
		Multi = true,
		Searchable = true,
		Tooltip = "Areas to look for eggs in (empty = all areas)",
		Callback = function(selectedValues)
			EggFinder.Areas = AreasFromSelection(selectedValues)
			PushToSteal()
		end,
	})

	EggFinder.Controls.Eggs = groupbox:AddDropdown("Dropdown_EggFinder_Eggs", {
		Text = "Target Specific Eggs",
		Values = catalog.EggNames,
		Default = {},
		Multi = true,
		Searchable = true,
		Tooltip = "Only look for these eggs (empty = all eggs)",
		Callback = function(selectedValues)
			EggFinder.Specific = SpecificFromSelection(selectedValues)
			PushToSteal()
		end,
	})

	EggFinder.Controls.MinValue = groupbox:AddSlider("Slider_EggFinder_MinValue", {
		Text = "Min Value To Find",
		Min = 0,
		Max = 1000,
		Default = math.clamp(math.floor(EggFinder.MinIncome / 1000000), 0, 1000),
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Skip eggs worth less than this (0 = off)",
		Callback = function(sliderValue)
			local numericValue = ToNumber(sliderValue, 0)
			EggFinder.MinIncome = numericValue > 0 and (numericValue * 1000000) or 0
		end,
	})

	EggFinder.Controls.FirstHopDelay = groupbox:AddSlider("Slider_EggFinder_HopDelay", {
		Text = "First Hop Delay",
		Min = 3,
		Max = 10,
		Default = 5,
		Rounding = 1,
		Suffix = "s",
		Tooltip = "Wait after the script loads before the first hop",
		Callback = function(sliderValue)
			local numericValue = math.clamp(ToNumber(sliderValue, 5), 3, 10)
			EggFinder.HopDelay = math.floor(numericValue * 2 + 0.5) / 2
		end,
	})

	EggFinder.Controls.AutoHop = groupbox:AddToggle("Toggle_EggFinder_AutoHop", {
		Text = "Auto Hop",
		Default = false,
		Tooltip = "Joins new servers to find eggs that match the filters above",
		Callback = function(isEnabled)
			if isEnabled then
				StartLoop()
			else
				StopLoop()
			end
		end,
	})

	EggFinder.Controls.Sync = groupbox:AddToggle("Toggle_EggFinder_Sync", {
		Text = "Sync With Auto Steal Filter",
		Default = true,
		Tooltip = "Changing a filter here also changes it in Auto Steal, and back",
		Callback = function(isEnabled)
			EggFinder.Link = isEnabled == true
			if EggFinder.Link then
				PullFromSteal()
			end
		end,
	})

	EggFinder.StatusView = hub.Theme.CreateStatusLabel(groupbox, "Status", "Idle")

	EggFinder.Applying = false
	EggFinder.LinkSignature = StealSignature()
	PullFromSteal()
	hub.Lifecycle.SpawnLoop(1, PollStealFilters)
end

return EggFinder
