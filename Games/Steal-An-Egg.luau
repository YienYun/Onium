-- ============================================================================
-- N3 HUB - Steal An Egg (Modular Refactored Architecture)
-- ============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local StatsService = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer

local REPO_RAW = "https://raw.githubusercontent.com/YienYun/Onium/refs/heads/arena/476c38f4-onium/"
local CACHE_BUST = "?v=" .. tostring(os.time())

local function RepoFile(relativePath)
	return REPO_RAW .. relativePath .. CACHE_BUST
end

local Hub = {
	Alive = true,
	Icons = {
		-- N3 HUB Custom Brand Logo (Window & Loading Screen ONLY)
		Brand = "rbxassetid://117688744510818",

		-- Official In-Game Asset Icons (Tabs & Feature Groupboxes)
		Farm = "rbxassetid://97499770821177",
		Eggs = "rbxassetid://97499770821177",
		Place = "rbxassetid://72213445673978",
		Pets = "rbxassetid://112223455192501",
		Sell = "rbxassetid://104234329609266",
		SellPets = "rbxassetid://83736894896123",
		SellEggs = "rbxassetid://103094823152347",
		Fuse = "rbxassetid://100380906894735",
		Favorite = "rbxassetid://122201416359766",
		Treadmill = "rbxassetid://116351329433541",
		Progression = "rbxassetid://119640363267627",
		Money = "rbxassetid://119640363267627",
		Speed = "rbxassetid://78137530993637",
		Index = "rbxassetid://72512465543867",
		Mutate = "rbxassetid://74755693699202",
		Essence = "rbxassetid://114750647204247",
		Lab = "rbxassetid://103838374075457",
		Night = "rbxassetid://123238464128459",
		Shop = "rbxassetid://70598530577515",
		Fights = "rbxassetid://135238935953633",
		Star = "rbxassetid://118070800707365",
		Butterfly = "rbxassetid://131116540264095",
		Wisp = "rbxassetid://117266037162644",
		Train = "rbxassetid://83798853441239",
		Event = "rbxassetid://112785428441728",
		Halloween = "rbxassetid://112785428441728",
		PumpkinBoss = "rbxassetid://118229903531977",
		HalloweenMonster = "rbxassetid://95288958121268",
		GhostDogFishing = "rbxassetid://122321649531761",
		TheHollow = "rbxassetid://123501512178420",
		PhantomExpress = "rbxassetid://108054256583165",
		Quest = "rbxassetid://116272961700800",
		AutoButterfly = "rbxassetid://98126365702697",
		ShootingStar = "rbxassetid://79133579432887",
		Player = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", (LocalPlayer and tonumber(LocalPlayer.UserId)) or 1),
		ESP = "rbxassetid://124581147164560",
		Movement = "rbxassetid://78137530993637",
		Character = "rbxassetid://128234882192727",
		Settings = "rbxassetid://101403250204482",
		Admin = "rbxassetid://106326120662451",
		CaptureTheEgg = "rbxassetid://103094823152347",
		InstantSteal = "rbxassetid://137134884810647",
		MinigameEggs = "rbxassetid://124390268104324",
		Predictor = "rbxassetid://96168190157761",
		EggPredictor = "rbxassetid://113114954725357",
		EggFinder = "rbxassetid://116524274262912",
	},
	Theme = {
		PrefixHex = "#D946EF", -- N3 HUB Purple-Pink Accent for label prefixes ("Status:", etc.)
	},
	Lifecycle = {
		Connections = {},
	},
	Features = {},
	UI = {
		Tabs = {},
		Groups = {},
		Dropdowns = {},
	},
}

function Hub.Theme.EscapeRichText(rawValue)
	local textValue = tostring(rawValue == nil and "" or rawValue)
	textValue = string.gsub(textValue, "&", "&amp;")
	textValue = string.gsub(textValue, "<", "&lt;")
	textValue = string.gsub(textValue, ">", "&gt;")
	return textValue
end

function Hub.Theme.FormatPrefix(prefixLabel, answerValue)
	return string.format(
		'<font color="%s"><b>%s:</b></font> %s',
		Hub.Theme.PrefixHex,
		Hub.Theme.EscapeRichText(prefixLabel),
		Hub.Theme.EscapeRichText(answerValue)
	)
end

function Hub.Theme.CreateStatusLabel(groupbox, prefixLabel, initialAnswer)
	local currentAnswer = tostring(initialAnswer or "Idle")
	local labelWidget = groupbox:AddLabel(Hub.Theme.FormatPrefix(prefixLabel, currentAnswer), true)
	local controller = {
		Label = labelWidget,
		Prefix = prefixLabel,
		CurrentValue = currentAnswer,
	}
	function controller:SetValue(nextAnswer)
		local normalizedAnswer = tostring(nextAnswer or "Idle")
		if normalizedAnswer == self.CurrentValue then
			return
		end
		self.CurrentValue = normalizedAnswer
		if self.Label and self.Label.SetText then
			local formattedText = Hub.Theme.FormatPrefix(self.Prefix, normalizedAnswer)
			pcall(self.Label.SetText, self.Label, formattedText)
		end
	end
	return controller
end

function Hub.Lifecycle.TrackConnection(connectionObj)
	if connectionObj then
		table.insert(Hub.Lifecycle.Connections, connectionObj)
	end
	return connectionObj
end

function Hub.Lifecycle.SpawnLoop(intervalSeconds, stepCallback)
	return task.spawn(function()
		while Hub.Alive do
			pcall(stepCallback)
			task.wait(intervalSeconds)
		end
	end)
end

function Hub.Lifecycle.DisposeAll()
	Hub.Alive = false
	for _, connectionObj in ipairs(Hub.Lifecycle.Connections) do
		pcall(connectionObj.Disconnect, connectionObj)
	end
	table.clear(Hub.Lifecycle.Connections)
end

local LibraryLoader = loadstring(game:HttpGet(RepoFile("Library/OniumV4.luau")))()
local PredictionModule = loadstring(game:HttpGet(RepoFile("Games/StealAnEgg/Prediction.luau")))()
local EggFinderModule = loadstring(game:HttpGet(RepoFile("Games/StealAnEgg/EggFinder.luau")))()
if not LibraryLoader then
	return
end

-- Preserve authentic full-color game artwork & Roblox avatar thumbnails on Tab & Groupbox icons
do
	local rawGetCustomIcon = LibraryLoader.GetCustomIcon
	if type(rawGetCustomIcon) == "function" then
		function LibraryLoader:GetCustomIcon(iconName)
			if type(iconName) == "string" then
				local webAssetDigits = string.match(iconName, "roblox%.com/asset/%?id=(%d+)")
				if webAssetDigits then
					iconName = "rbxassetid://" .. webAssetDigits
				end
			end
			local iconData = rawGetCustomIcon(self, iconName)
			if type(iconData) == "table" and type(iconData.Url) == "string" then
				if string.match(iconData.Url, "^rbxassetid://") or string.match(iconData.Url, "^rbxthumb://") then
					iconData.Custom = true
				end
			end
			return iconData
		end
	end
end

local LoadingScreen = LibraryLoader:CreateLoading({
	Title = "N3 HUB",
	Icon = Hub.Icons.Brand,
	TotalSteps = 5,
	CurrentStep = 1,
	ShowSidebar = false,
	AutoResizeHeight = true,
})
LoadingScreen:SetMessage("Load Engine")
LoadingScreen:SetDescription("Preparing services, remotes & runtime core...")

-- ============================================================================
-- 1. GAME MODULES & REMOTES
-- ============================================================================

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

LoadingScreen:SetMessage("Load Data Replica")
LoadingScreen:SetCurrentStep(2)
LoadingScreen:SetDescription("Loading game data replicas: EggState, Areas, Assets & Mutations...")

local EggStateModule = RequireGameModule("Client", "EggState")
local AreaEggResetWallModule = RequireGameModule("Client", "AreaEggResetWall")
local ClientRagdollModule = RequireGameModule("Client", "Ragdoll")
local AreasModule = RequireGameModule("Data", "Areas")
local AssetsModule = RequireGameModule("Data", "Assets")
local MutationsModule = RequireGameModule("Shared", "Modules", "Mutations")
local EggRecordsModule = RequireGameModule("Shared", "Util", "EggRecords")
local AssetItemsModule = RequireGameModule("Shared", "Util", "AssetItems")
local AssetEarningsModule = RequireGameModule("Shared", "Util", "AssetEarnings")
local AreaEggCycleModule = RequireGameModule("Client", "AreaEggCycle") or RequireGameModule("Shared", "Util", "AreaEggCycle")
local AreaEggTypesModule = RequireGameModule("Shared", "Types", "AreaEggs")
local RagdollJointsModule = RequireGameModule("Shared", "Modules", "RagdollJoints") or RequireGameModule("Shared", "Util", "RagdollJoints")
local GuardChasePolicyModule = RequireGameModule("Shared", "Modules", "GuardAreas", "GuardChasePolicy")
local TreadmillUtilModule = RequireGameModule("Shared", "Util", "TreadmillUtil")
local SlotIdentityModule = RequireGameModule("Shared", "Util", "AreaEggSlotIdentity")
local PlotStateModule = RequireGameModule("Client", "PlotState")
local SaveModule = RequireGameModule("Shared", "Save") or RequireGameModule("Client", "Save")
local TrailsModule = RequireGameModule("Data", "Trails")
local BasesModule = RequireGameModule("Data", "Bases")
local TreadmillsModule = RequireGameModule("Data", "Treadmills")
local LimitedEggModule = RequireGameModule("Data", "LimitedEgg")
local BrainrotEggModule = RequireGameModule("Data", "BrainrotEgg")
local MonsterEggModule = RequireGameModule("Data", "MonsterEgg")
local FuseKernelModule = RequireGameModule("Shared", "Util", "FuseKernel")
local GearsModule = RequireGameModule("Data", "Gears")
local GhostDogQuestModule = RequireGameModule("Data", "GhostDogQuest")
local FishingUtilModule = RequireGameModule("Shared", "Util", "Fishing")

LoadingScreen:SetMessage("Load N3 Library")
LoadingScreen:SetCurrentStep(3)
LoadingScreen:SetDescription("N3V3 UI Library, SaveManager & ThemeManager...")

local NetworkFolder = ReplicatedStorage
do
	local searchDeadline = os.clock() + 15
	repeat
		local packagesFolder = ReplicatedStorage:FindFirstChild("Packages")
		NetworkFolder = (packagesFolder and packagesFolder:FindFirstChild("Networking"))
			or ReplicatedStorage:FindFirstChild("Network")
			or ReplicatedStorage
		if NetworkFolder and NetworkFolder:FindFirstChild("RF/EggWorld/AskFieldEggCarry", true) then
			break
		end
		task.wait(0.4)
	until os.clock() > searchDeadline
end

local function FindGameRemote(primaryPath, ...)
	local function locateByName(remoteName)
		if type(remoteName) ~= "string" or remoteName == "" then
			return nil
		end
		return (NetworkFolder and NetworkFolder:FindFirstChild(remoteName, true))
			or ReplicatedStorage:FindFirstChild(remoteName, true)
	end

	local primaryHit = locateByName(primaryPath)
	if primaryHit then
		return primaryHit
	end
	for _, fallbackPath in ipairs({ ... }) do
		local fallbackHit = locateByName(fallbackPath)
		if fallbackHit then
			return fallbackHit
		end
	end
	local leafName = string.match(primaryPath, "[^/]+$")
	return leafName and locateByName(leafName) or nil
end

local Remotes = {
	CarryEgg = FindGameRemote("RF/EggWorld/AskFieldEggCarry", "AskFieldEggCarry"),
	EggSnapshot = FindGameRemote("RF/EggWorld/AskFieldEggSnapshot", "AskFieldEggSnapshot"),
	PlaceEgg = FindGameRemote("RF/EggWorld/AskPlaceEgg", "AskPlaceEgg"),
	PlotState = FindGameRemote("RF/Homestead/AskState", "RF/Plots/AskState", "AskState"),
	TreadmillSnapshot = FindGameRemote("RF/Treadmill/AskRenderSnapshot", "AskRenderSnapshot", "RF/Treadmill/AskSnapshot"),
	TreadmillWear = FindGameRemote("RF/Treadmill/AskWearStill", "AskWearStill"),
	TreadmillDoff = FindGameRemote("RF/Treadmill/AskDoff", "AskDoff"),
	TreadmillSpeedGained = FindGameRemote("RE/Treadmill/SpeedGained", "SpeedGained"),
}

-- ============================================================================
-- 2. CONFIGURATION, STATE & DYNAMIC GAME CATALOGS
-- ============================================================================

local SAFE_BASE_LINE_X = 552
local SAFE_CORRIDOR_Z = -364
local DELIVERY_DROP_CFRAME = CFrame.new(616.749, 71.667, -395.585)

local FarmConfig = {
	AutoStealEnabled = false,
	AutoStealAll = false,
	StealAllMode = false,
	StealMethod = "Fast Tween",
	SafeZoneVisual = false,
	Defense_AntiRagdoll = true,
	TweenSpeed = 600,
	AutoTweenSpeed = 400,
	FastTweenSpeed = 3300,
	CarryVariant = "V2 - Chili Legs",
	SelectedZones = {},
	SelectedEggs = {},
	SelectedRarities = {},
	Progression_AutoBuyTrail = false,
	Progression_AutoUpgradeBase = false,
	Progression_AutoUpgradeTreadmill = false,
	Progression_AutoClaimMoney = false,
	Progression_AutoClaimIndex = false,
	Progression_AutoTreadmill = false,
	Place_AutoPlace = false,
	Place_Rule = "Always",
	Place_Order = "Highest Value",
	Place_MinValue = 0,
	Place_SelectedRarities = {},
	Place_SelectedEggs = {},
	Hatch_AutoHatch = false,
	Hatch_AutoEquip = false,
	Hatch_MinRarityRank = 0,
	Hatch_MinValue = 0,
	Hatch_SelectedEggs = {},
	Sell_AutoPets = false,
	Sell_PetRule = "Rarity Only",
	Sell_PetRarities = {},
	Sell_PetValue = 0,
	Sell_PetBlacklist = {},
	Sell_KeepMutatedPets = true,
	Sell_AutoEggs = false,
	Sell_EggRule = "Rarity Only",
	Sell_EggRarities = {},
	Sell_EggValue = 0,
	Sell_EggBlacklist = {},
	Sell_KeepMutatedEggs = true,
	Mutate_Auto = false,
	Mutate_Use = { Boss = true, Scrambled = true, Enchanted = true, Nitro = true },
	Mutate_MinRarityRank = 0,
	Mutate_MinValue = 0,
	Mutate_Priority = "Highest Value",
	Fuse_Auto = false,
	Fuse_Priority = "Lowest Rarity First",
	Fuse_PetsToUse = "Lowest To Highest",
	Fuse_MaxRarityRank = 6,
	Fuse_SelectedSpecies = {},
	Fuse_SkipMutated = true,
	Fuse_EjectIncomplete = true,
	Fav_AutoPets = false,
	Fav_Rule = "Match All",
	Fav_MinRarityRank = nil,
	Fav_AnyMutation = false,
	Fav_SelectedMutations = {},
	Fav_MinValue = 0,
	Fav_AlwaysSpecies = {},
	Fav_AutoEquipped = false,
	Fav_AutoUnfavEquipped = false,
	PumpkinBoss_Auto = false,
	PumpkinBoss_Weapons = {},
	PumpkinBoss_PickupSpeed = 300,
	PumpkinBoss_AutoDodge = true,
	PumpkinBoss_AutoMastery = false,
	PumpkinBoss_AutoManorKey = false,
	Monster_AutoKill = false,
	Monster_Targets = {},
	Monster_Order = "Closest",
	Monster_WalkSpeed = 300,
	Monster_Weapons = {},
	Monster_Teleport = false,
	Monster_OnlyBloodMoon = false,
	Monster_AllInBloodMoon = false,
	Fishing_AutoQuest = false,
	Fishing_AutoFish = false,
	Fishing_FarmMonsters = false,
	Fishing_CastLuck = "x1.5 Perfect",
	Fishing_CastCharge = 0.875,
	Fishing_Spot = "Default Pond",
	Hollow_AutoRace = false,
	Hollow_RaceSpeed = 300,
	Hollow_AutoPowerUp = false,
	Phantom_AutoRide = false,
	Phantom_VacuumBoss = true,
	Phantom_GhostTarget = "Rarest First",
	Phantom_WalkSpeed = 300,
	Phantom_TeleportGhost = false,
	Phantom_TradeSouls = false,
	Butterfly_Auto = false,
	Butterfly_Mode = "Stand",
	Butterfly_Priority = "Rarest",
	Butterfly_Tiers = { Green = true, Blue = true, Purple = true, Golden = true },
	Butterfly_Speed = 320,
	Butterfly_Trade = false,
	Butterfly_TradeTiers = {},
	Butterfly_Smart = false,
	Butterfly_Craft = false,
	Wisp_Auto = false,
	Banjo_Auto = false,
	Star_Auto = false,
	ESP_MinRarityRank = 0,
	ESP_ShowInfo = { Icon = true, Name = true, Value = true },
	ESP_MinValue = 0,
	ESP_EggSize = 75,
	ESP_InventoryValue = false,
	ESP_Eggs = false,
	ESP_FixedSize = false,
	ESP_OwnBaseEggs = true,
	ESP_OtherBaseEggs = false,
	ESP_Guards = false,
	ESP_GuardSize = 75,
	ESP_Players = false,
	ESP_PlayerInfo = { Name = true, Username = false, Avatar = false, Tool = true },
	ESP_PlayerSize = 75,
	Move_BoostSpeed = 350,
	Move_SpeedBoost = false,
	Move_InfiniteJump = false,
	Char_AntiTrap = true,
	Char_InstantPrompts = true,
	Char_Invisibility = false,
	Admin_Capture = false,
	Admin_CaptureTake = true,
	Admin_CaptureHeight = 45,
	Admin_CaptureKeepAway = 45,
	Admin_AutoTreadmill = false,
	Admin_InstantSteal = false,
	Admin_MinigameEggs = false,
	IslandWars_Auto = false,
	IslandWars_Target = "Enemies And Base",
}

local RuntimeState = {
	SessionId = 0,
	StealCancel = 0,
	IsExecuting = false,
	Unloaded = false,
	PlayerPlot = nil,
	OriginalHumanoid = nil,
	SwapClone = nil,
	SwapLinks = {},
	StealEngine = nil,
}

Hub.Config = FarmConfig
Hub.State = RuntimeState
Hub.Remotes = Remotes

local GlobalHubEnv = (type(getgenv) == "function" and getgenv()) or _G
GlobalHubEnv.N3Hub_State = GlobalHubEnv.N3Hub_State or {}
GlobalHubEnv.N3Hub_State.Hub = Hub
GlobalHubEnv.N3Hub_State.FarmConfig = FarmConfig
GlobalHubEnv.N3Hub_State.RuntimeState = RuntimeState

local function IsStealActive()
	return FarmConfig.AutoStealEnabled or FarmConfig.AutoStealAll
end

local function ToFiniteNumber(rawValue, fallbackValue)
	local numeric = tonumber(rawValue)
	if numeric and numeric == numeric and numeric ~= math.huge and numeric ~= -math.huge then
		return numeric
	end
	return fallbackValue or 0
end

local function NormalizeRarityKey(rawText)
	local cleaned = string.gsub(string.lower(tostring(rawText or "")), "%s+", "")
	if cleaned == "mythical" then
		return "mythic"
	end
	return cleaned
end

local StealPriorityOptions = {
	"Best Rarity",
	"Biggest Weight",
	"Best Mutation",
	"Highest Value",
	"Lowest Value",
}

local StealMethodOptions = {
	"Walk",
	"Fast Tween",
}

local CarryVariants = {
	FastGlide = "V1 - Fast Glide",
	ChiliLegs = "V2 - Chili Legs",
	ChiliSingle = "V3 - Chili Single",
}

local CarryVariantOptions = {
	CarryVariants.FastGlide,
	CarryVariants.ChiliLegs,
	CarryVariants.ChiliSingle,
}

local PlaceRuleOptions = {
	"Always",
	"Steal Idle",
	"After Steal",
	"Night Only",
}

local PlaceOrderOptions = {
	"Biggest Size",
	"Highest Value",
	"Smallest Size",
	"Backpack Order",
}

local PlaceSpecificEggOptions, PlaceEggLabelToCategory = {}, {}
local HatchMinRarityOptions = { "Any" }
local SellRuleOptions = {
	"Rarity Only",
	"Value Only",
	"Rarity And Value",
	"Rarity Or Value",
}
local MutatePriorityOptions = {
	"Highest Value",
	"Best Rarity",
	"Biggest Size",
}
local MutateConsumableSpecs = {
	{ Id = "Boss", Label = "Fractured" },
	{ Id = "Scrambled", Label = "Scrambled" },
	{ Id = "Enchanted", Label = "Enchanted" },
	{ Id = "Nitro", Label = "Nitro" },
}
local MutateConsumableLabels, MutateLabelToId = {}, {}
for _, specItem in ipairs(MutateConsumableSpecs) do
	table.insert(MutateConsumableLabels, specItem.Label)
	MutateLabelToId[specItem.Label] = specItem.Id
	MutateLabelToId[string.lower(specItem.Label)] = specItem.Id
	MutateLabelToId[string.lower(specItem.Id)] = specItem.Id
end

local FusePriorityOptions = {
	"Lowest Rarity First",
	"Highest Rarity First",
	"Most Copies First",
	"Lowest Value First",
}
local FusePetsToUseOptions = {
	"Lowest To Highest",
	"Highest To Lowest",
}
local FavoriteRuleOptions = {
	"Match Any",
	"Match All",
}
local FavoriteRarityOptions = { "Off" }
local FavoriteMutationOptions = { "Any Mutation" }
local FavoriteMutationLabelToId = {}

local MonsterTargetOptions = {
	"Candy Corn (+12 Candy)",
	"Hollow Bat (+12 Candy)",
	"Scarecrow (+28 Candy)",
	"Chest Mimic (+28 Candy)",
	"Pumpkin Golem (+65 Candy)",
	"Soul Phantom (+65 Candy)",
}
local MonsterOrderOptions = {
	"Closest",
	"Most Tokens",
}
local CastLuckOptions = {
	"x1.5 Perfect",
	"x1.2",
	"x1.1",
	"x1.0 Fastest",
}
local CastLuckChargeMap = {
	["x1.5 Perfect"] = 0.875,
	["x1.2"] = 1.0,
	["x1.1"] = 0.5,
	["x1.0 Fastest"] = 0.02,
}
local FishingSpotOptions = {
	"Default Pond",
	"Secret Whirlpool Pond",
	"Saved Spot",
	"Current Position",
}
local WeaponDisplayList, WeaponLabelToGearId, BatGearIds, KnownWeaponGearIds = {}, {}, {}, {}

local AreaNamesList, AreaRankByName, EggHomeZone, LiveZoneXRanges = {}, {}, {}, {}
local EggNamesList, AssetInfoByLowerName = {}, {}
local RaritiesList, RarityRankByKey = {}, {}

do
	-- 1) Load Rarities & Egg Asset Rates dynamically from ReplicatedStorage.Data.Assets
	local rarityNameByRank = {}
	local assetDirectory = AssetsModule and AssetsModule.Directory
	if type(assetDirectory) == "table" then
		for assetKey, assetEntry in pairs(assetDirectory) do
			if type(assetEntry) == "table" then
				local rarityTable = type(assetEntry.Rarity) == "table" and assetEntry.Rarity or nil
				local rankNumber = rarityTable and ToFiniteNumber(rarityTable.RarityNumber or rarityTable.Rank, 0) or 0
				local rarityName = rarityTable and tostring(rarityTable.DisplayName or rarityTable.Name or rarityTable._id or "")
					or (type(assetEntry.Rarity) == "string" and assetEntry.Rarity or "")

				if rankNumber > 0 and rarityName ~= "" and not rarityNameByRank[rankNumber] then
					rarityNameByRank[rankNumber] = rarityName
				end
				if rarityName ~= "" then
					local normKey = NormalizeRarityKey(rarityName)
					RarityRankByKey[normKey] = math.max(RarityRankByKey[normKey] or 0, rankNumber)
				end

				local assetRecord = {
					Rarity = rarityName ~= "" and rarityName or "Common",
					Rank = rankNumber,
					Rate = ToFiniteNumber(assetEntry.EarningRate, 15),
				}
				local aliases = {
					tostring(assetKey),
					tostring(assetEntry._id or ""),
					tostring(assetEntry.DisplayName or ""),
				}
				for _, aliasName in ipairs(aliases) do
					if aliasName ~= "" then
						AssetInfoByLowerName[string.lower(aliasName)] = assetRecord
					end
				end
			end
		end
	end

	local sortedRanks = {}
	for rankNumber in pairs(rarityNameByRank) do
		table.insert(sortedRanks, rankNumber)
	end
	table.sort(sortedRanks, function(rankA, rankB)
		return rankA < rankB
	end)
	for _, rankNumber in ipairs(sortedRanks) do
		table.insert(RaritiesList, rarityNameByRank[rankNumber])
	end
	if #RaritiesList == 0 then
		RaritiesList = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine" }
		for listIndex, rarityName in ipairs(RaritiesList) do
			RarityRankByKey[NormalizeRarityKey(rarityName)] = listIndex
		end
	end
	for _, rarityName in ipairs(RaritiesList) do
		table.insert(HatchMinRarityOptions, rarityName)
		table.insert(FavoriteRarityOptions, rarityName)
	end
	FarmConfig.Fuse_MaxRarityRank = ToFiniteNumber(RarityRankByKey["mythic"], math.min(6, #RaritiesList))

	-- 2) Load Zones & DropTable Eggs dynamically from ReplicatedStorage.Data.Areas
	local seenAreas, seenEggs = {}, {}
	local function registerAreaCatalog(areaNameRaw, areaData, fallbackOrder)
		local areaName = tostring(areaNameRaw or "")
		if areaName == "" then
			return
		end
		local rarityTable = type(areaData) == "table" and type(areaData.Rarity) == "table" and areaData.Rarity or nil
		local rawOrder = (type(areaData) == "table" and (areaData.Order or areaData.Index))
			or (rarityTable and (rarityTable.RarityNumber or rarityTable.Rank))
		local areaOrder = ToFiniteNumber(rawOrder, fallbackOrder or (#AreaNamesList + 1))

		AreaRankByName[areaName] = math.max(AreaRankByName[areaName] or 0, areaOrder)
		if not seenAreas[areaName] then
			seenAreas[areaName] = true
			table.insert(AreaNamesList, areaName)
		end

		local dropTable = type(areaData) == "table" and areaData.DropTable or nil
		if type(dropTable) == "table" then
			for _, dropEntry in pairs(dropTable) do
				local eggName = type(dropEntry) == "table" and tostring(dropEntry[1] or dropEntry.AssetId or "") or ""
				if eggName ~= "" then
					local lowerEgg = string.lower(eggName)
					EggHomeZone[lowerEgg] = EggHomeZone[lowerEgg] or areaName
					if not seenEggs[eggName] then
						seenEggs[eggName] = true
						table.insert(EggNamesList, eggName)
					end
				end
			end
		end
	end

	if AreasModule and type(AreasModule.Directory) == "table" then
		for areaName, areaData in pairs(AreasModule.Directory) do
			registerAreaCatalog(areaName, areaData)
		end
	end

	local dataFolder = ReplicatedStorage:FindFirstChild("Data")
	local areasInstance = dataFolder and dataFolder:FindFirstChild("Areas")
	local areaConfigsFolder = areasInstance and areasInstance:FindFirstChild("Configs")
	if areaConfigsFolder then
		for moduleIndex, moduleScript in ipairs(areaConfigsFolder:GetChildren()) do
			if moduleScript:IsA("ModuleScript") then
				local callOk, configData = pcall(require, moduleScript)
				if callOk and type(configData) == "table" then
					registerAreaCatalog(configData.DisplayName or configData.Name or moduleScript.Name, configData, moduleIndex)
				end
			end
		end
	end

	if EggStateModule and type(EggStateModule.ReadFieldEggs) == "function" then
		local callOk, snapshot = pcall(EggStateModule.ReadFieldEggs)
		local records = callOk and type(snapshot) == "table" and snapshot.Records or nil
		if type(records) == "table" then
			for _, eggRecord in pairs(records) do
				if type(eggRecord) == "table" and type(eggRecord.AreaId) == "string" then
					registerAreaCatalog(eggRecord.AreaId, nil, #AreaNamesList + 1)
				end
			end
		end
	end

	if #AreaNamesList == 0 then
		local defaultZones = {
			"Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano", "Abyss Ocean",
			"Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple", "Light Dark", "Enchanted Forest",
		}
		for zoneIndex, zoneName in ipairs(defaultZones) do
			registerAreaCatalog(zoneName, nil, zoneIndex)
		end
	end

	table.sort(AreaNamesList, function(zoneA, zoneB)
		local rankA = ToFiniteNumber(AreaRankByName[zoneA], 0)
		local rankB = ToFiniteNumber(AreaRankByName[zoneB], 0)
		if rankA ~= rankB then
			return rankA < rankB
		end
		return tostring(zoneA) < tostring(zoneB)
	end)

	if #EggNamesList == 0 then
		for lowerName in pairs(AssetInfoByLowerName) do
			if not seenEggs[lowerName] then
				seenEggs[lowerName] = true
				table.insert(EggNamesList, lowerName)
			end
		end
	end

	table.sort(EggNamesList, function(eggA, eggB)
		local infoA = AssetInfoByLowerName[string.lower(tostring(eggA))]
		local infoB = AssetInfoByLowerName[string.lower(tostring(eggB))]
		local rankA = infoA and ToFiniteNumber(infoA.Rank, 0) or 0
		local rankB = infoB and ToFiniteNumber(infoB.Rank, 0) or 0
		if rankA ~= rankB then
			return rankA > rankB
		end
		return tostring(eggA) < tostring(eggB)
	end)

	-- Build Chilli-formatted "Name [Rarity]" options for Place Specific Eggs
	local placeCatalogEntries = {}
	if type(assetDirectory) == "table" then
		for categoryKey, assetEntry in pairs(assetDirectory) do
			local rarityTbl = type(assetEntry) == "table" and assetEntry.Rarity or nil
			local rarityNum = type(rarityTbl) == "table" and ToFiniteNumber(rarityTbl.RarityNumber or rarityTbl.Rank, 0) or 0
			if rarityNum > 0 then
				table.insert(placeCatalogEntries, {
					Category = tostring(categoryKey),
					Name = tostring(assetEntry.DisplayName or categoryKey),
					Rank = rarityNum,
					RarityName = tostring(rarityTbl.DisplayName or rarityTbl._id or rarityNum),
				})
			end
		end
	end
	table.sort(placeCatalogEntries, function(itemA, itemB)
		if itemA.Rank ~= itemB.Rank then
			return itemA.Rank > itemB.Rank
		end
		if itemA.Name ~= itemB.Name then
			return itemA.Name < itemB.Name
		end
		return itemA.Category < itemB.Category
	end)
	for _, entry in ipairs(placeCatalogEntries) do
		local labelText = string.format("%s [%s]", entry.Name, entry.RarityName)
		if PlaceEggLabelToCategory[labelText] then
			labelText = string.format("%s [%s] (%s)", entry.Name, entry.RarityName, entry.Category)
		end
		table.insert(PlaceSpecificEggOptions, labelText)
		PlaceEggLabelToCategory[labelText] = entry.Category
		PlaceEggLabelToCategory[string.lower(labelText)] = entry.Category
		PlaceEggLabelToCategory[string.lower(entry.Category)] = entry.Category
		PlaceEggLabelToCategory[string.lower(entry.Name)] = entry.Category
	end
	if #PlaceSpecificEggOptions == 0 then
		for _, eggName in ipairs(EggNamesList) do
			table.insert(PlaceSpecificEggOptions, eggName)
			PlaceEggLabelToCategory[eggName] = eggName
			PlaceEggLabelToCategory[string.lower(eggName)] = eggName
		end
	end

	-- Build Favorite Mutation catalog dynamically from Shared.Modules.Mutations
	local DEFAULT_MUTATION_LABELS = {
		Golden = "Golden",
		Silver = "Silver",
		Rainbow = "Rainbow",
		Boss = "Fractured",
		Monstrous = "Parasite",
		Sakura = "Bloom",
		GreatBloom = "Spirit Bloom",
	}
	local seenFavMutIds = {}
	local favMutPairs = {}
	local function addFavMutation(rawMutId, rawDisplay)
		local mutId = tostring(rawMutId or "")
		if mutId == "" or mutId == "Normal" or seenFavMutIds[mutId] then
			return
		end
		seenFavMutIds[mutId] = true
		local displayLabel = tostring(rawDisplay or DEFAULT_MUTATION_LABELS[mutId] or mutId)
		table.insert(favMutPairs, { Id = mutId, Label = displayLabel })
	end
	if type(MutationsModule) == "table" then
		if type(MutationsModule.All) == "function" then
			local callOk, allMuts = pcall(MutationsModule.All)
			if callOk and type(allMuts) == "table" then
				for mutKey, mutInfo in pairs(allMuts) do
					if type(mutInfo) == "table" then
						addFavMutation(mutInfo.Id or mutKey, mutInfo.Label or mutInfo.DisplayName or mutInfo.Name)
					else
						addFavMutation(mutKey, DEFAULT_MUTATION_LABELS[tostring(mutKey)] or tostring(mutInfo))
					end
				end
			end
		end
		if type(MutationsModule.IdSet) == "table" then
			for mutKey in pairs(MutationsModule.IdSet) do
				addFavMutation(mutKey, DEFAULT_MUTATION_LABELS[tostring(mutKey)])
			end
		end
	end
	if #favMutPairs == 0 then
		for _, fallbackId in ipairs({ "Golden", "Silver", "Rainbow", "Boss", "Monstrous", "Sakura", "GreatBloom" }) do
			addFavMutation(fallbackId, DEFAULT_MUTATION_LABELS[fallbackId])
		end
	end
	table.sort(favMutPairs, function(pairA, pairB)
		return pairA.Label < pairB.Label
	end)
	for _, pairItem in ipairs(favMutPairs) do
		table.insert(FavoriteMutationOptions, pairItem.Label)
		FavoriteMutationLabelToId[pairItem.Label] = pairItem.Id
		FavoriteMutationLabelToId[string.lower(pairItem.Label)] = pairItem.Id
		FavoriteMutationLabelToId[string.lower(pairItem.Id)] = pairItem.Id
	end

	-- Load Bat & Slap Weapons dynamically from ReplicatedStorage.Data.Gears
	local gearDirectory = type(GearsModule) == "table" and GearsModule.Directory or nil
	if type(gearDirectory) == "table" then
		for gearKey, gearEntry in pairs(gearDirectory) do
			if type(gearEntry) == "table" and (gearEntry.BatControllerData ~= nil or gearEntry.ToolController == "Slap") then
				local gearId = tostring(gearKey)
				local displayLabel = tostring(gearEntry.DisplayName or gearId)
				table.insert(WeaponDisplayList, displayLabel)
				WeaponLabelToGearId[displayLabel] = gearId
				WeaponLabelToGearId[string.lower(displayLabel)] = gearId
				WeaponLabelToGearId[string.lower(gearId)] = gearId
				KnownWeaponGearIds[gearId] = true
				if gearEntry.BatControllerData ~= nil then
					BatGearIds[gearId] = true
				end
			end
		end
		table.sort(WeaponDisplayList)
	end
end

Hub.Catalogs = {
	AreaNames = AreaNamesList,
	EggNames = EggNamesList,
	Rarities = RaritiesList,
	MinRarityOptions = HatchMinRarityOptions,
	RarityRankByKey = RarityRankByKey,
	NormalizeRarityKey = NormalizeRarityKey,
}

local function ResolveEggRarity(eggRecord)
	local categoryName = tostring(eggRecord.AssetCategory or eggRecord.Category or eggRecord.Name or "")
	local cachedAsset = AssetInfoByLowerName[string.lower(categoryName)]
	if cachedAsset then
		return cachedAsset.Rarity, cachedAsset.Rank
	end

	if AssetItemsModule and type(AssetItemsModule.RarityRankForCategory) == "function" then
		local callOk, rankValue = pcall(AssetItemsModule.RarityRankForCategory, categoryName)
		if callOk and type(rankValue) == "number" and rankValue > 0 then
			return RaritiesList[rankValue] or tostring(eggRecord.Rarity or "Common"), rankValue
		end
	end

	local rawRarity = tostring(eggRecord.Rarity or "Common")
	return rawRarity, RarityRankByKey[NormalizeRarityKey(rawRarity)] or 1
end

local function ResolveEggZone(areaId, worldPos, categoryName)
	if type(areaId) == "string" and areaId ~= "" then
		return areaId
	end
	local homeZone = categoryName and EggHomeZone[string.lower(tostring(categoryName))]
	if homeZone then
		return homeZone
	end
	if typeof(worldPos) == "Vector3" and next(LiveZoneXRanges) ~= nil then
		local bestZone, bestDistance = nil, math.huge
		for zoneName, xBounds in pairs(LiveZoneXRanges) do
			local gap = 0
			if worldPos.X < xBounds[1] then
				gap = xBounds[1] - worldPos.X
			elseif worldPos.X > xBounds[2] then
				gap = worldPos.X - xBounds[2]
			end
			if gap < bestDistance then
				bestDistance, bestZone = gap, zoneName
			end
		end
		if bestZone then
			return bestZone
		end
	end
	return AreaNamesList[1] or "Forest"
end

local function GetEggWeightKg(eggRecord)
	local assetScale = ToFiniteNumber(eggRecord.AssetScale or eggRecord.Scale, 1)
	if EggRecordsModule then
		if type(EggRecordsModule.WeightKgForScale) == "function" then
			local callOk, weightKg = pcall(EggRecordsModule.WeightKgForScale, assetScale, eggRecord.AssetCategory)
			if callOk and type(weightKg) == "number" and weightKg > 0 then
				return weightKg
			end
		end
		if type(EggRecordsModule.WeightKg) == "function" then
			local callOk, weightKg = pcall(EggRecordsModule.WeightKg, eggRecord)
			if callOk and type(weightKg) == "number" and weightKg > 0 then
				return weightKg
			end
		end
	end
	return assetScale * 20
end

local function CalculateEggIncome(eggRecord)
	if not eggRecord then
		return 0
	end
	local categoryName = tostring(eggRecord.AssetCategory or eggRecord.Category or eggRecord.Name or "")
	local assetScale = math.max(ToFiniteNumber(eggRecord.AssetScale or eggRecord.Scale, 1), 0.5)
	local mutations = type(eggRecord.Mutations) == "table" and eggRecord.Mutations or {}

	if AssetEarningsModule and type(AssetEarningsModule.LiveRatePerSecond) == "function" then
		local callOk, liveRate = pcall(
			AssetEarningsModule.LiveRatePerSecond,
			{ Category = categoryName, Scale = assetScale, Mutations = mutations },
			nil,
			nil,
			LocalPlayer
		)
		if callOk and type(liveRate) == "number" and liveRate > 0 then
			return ToFiniteNumber(liveRate, 0)
		end
	end

	local cachedAsset = AssetInfoByLowerName[string.lower(categoryName)]
	local baseRate = cachedAsset and cachedAsset.Rate or 0
	if assetScale <= 0 then
		return 0
	end
	local powerScale = (assetScale > 5)
		and (((assetScale / 5) ^ 1.2) * 19.637875755794113)
		or (assetScale ^ 1.85)
	local mutationMultiplier = 1
	if MutationsModule and type(MutationsModule.EarningsFor) == "function" then
		local callOk, multValue = pcall(MutationsModule.EarningsFor, mutations)
		if callOk and type(multValue) == "number" and multValue > 0 then
			mutationMultiplier = multValue
		end
	end
	return ToFiniteNumber(baseRate * powerScale * mutationMultiplier, 0)
end

local function GetPlayerPlot()
	if RuntimeState.PlayerPlot and RuntimeState.PlayerPlot.Parent then
		return RuntimeState.PlayerPlot
	end
	local worldFolder = Workspace:FindFirstChild("World")
	local plotsFolder = (worldFolder and worldFolder:FindFirstChild("Build") and worldFolder.Build:FindFirstChild("Plots"))
		or Workspace:FindFirstChild("Plots")
	if not plotsFolder then
		return nil
	end

	local assignedName = tostring(LocalPlayer:GetAttribute("AssignedPlotName") or "")
	if assignedName == "" and Remotes.PlotState and Remotes.PlotState:IsA("RemoteFunction") then
		local callOk, plotState = pcall(Remotes.PlotState.InvokeServer, Remotes.PlotState)
		if callOk and type(plotState) == "table" then
			assignedName = tostring(plotState.PlotName or plotState.Id or plotState.PlotId or "")
		end
	end
	if assignedName ~= "" and plotsFolder:FindFirstChild(assignedName) then
		RuntimeState.PlayerPlot = plotsFolder[assignedName]
		return RuntimeState.PlayerPlot
	end

	for _, plotModel in ipairs(plotsFolder:GetChildren()) do
		local ownerUserId = plotModel:GetAttribute("OwnerUserId")
			or plotModel:GetAttribute("OwnerId")
			or plotModel:GetAttribute("UserId")
		if ownerUserId == LocalPlayer.UserId or plotModel:GetAttribute("Owner") == LocalPlayer.Name then
			RuntimeState.PlayerPlot = plotModel
			return plotModel
		end
		local plotSign = plotModel:FindFirstChild("PlotSign")
		local playerSign = plotSign and plotSign:FindFirstChild("PlayerPlotSign")
		local signFrame = playerSign and playerSign:FindFirstChild("Frame")
		local nameLabel = signFrame and signFrame:FindFirstChild("PlayerName")
		if nameLabel and nameLabel:IsA("TextLabel") then
			local signText = string.lower(tostring(nameLabel.Text or ""))
			if signText == string.lower(LocalPlayer.Name) or signText == string.lower(LocalPlayer.DisplayName) then
				RuntimeState.PlayerPlot = plotModel
				return plotModel
			end
		end
	end
	return nil
end

-- ============================================================================
-- 3. HUMANOID SWAP & ANTI-RAGDOLL PROTECTION
-- ============================================================================

local NormalHumanoidStates = {
	Enum.HumanoidStateType.Running,
	Enum.HumanoidStateType.Jumping,
	Enum.HumanoidStateType.Climbing,
	Enum.HumanoidStateType.Freefall,
	Enum.HumanoidStateType.Physics,
	Enum.HumanoidStateType.Ragdoll,
	Enum.HumanoidStateType.FallingDown,
	Enum.HumanoidStateType.GettingUp,
	Enum.HumanoidStateType.PlatformStanding,
	Enum.HumanoidStateType.Seated,
	Enum.HumanoidStateType.Dead,
}

local RagdollStateSet = {
	[Enum.HumanoidStateType.Ragdoll] = true,
	[Enum.HumanoidStateType.FallingDown] = true,
	[Enum.HumanoidStateType.Physics] = true,
	[Enum.HumanoidStateType.GettingUp] = true,
}

local RagdollConstraintNames = {
	BallSocketConstraint = true,
	HingeConstraint = true,
	NoCollisionConstraint = true,
}

local CachedPlayerControls = nil
local function GetPlayerControls()
	if CachedPlayerControls then
		return CachedPlayerControls
	end
	local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
	local playerModuleInstance = playerScripts and playerScripts:FindFirstChild("PlayerModule")
	if playerModuleInstance and playerModuleInstance:IsA("ModuleScript") then
		local callOk, playerModule = pcall(require, playerModuleInstance)
		if callOk and type(playerModule) == "table" and type(playerModule.GetControls) == "function" then
			local okCtrl, controlsObj = pcall(playerModule.GetControls, playerModule)
			if okCtrl and controlsObj then
				CachedPlayerControls = controlsObj
			end
		end
	end
	return CachedPlayerControls
end

local function RepointControls(humanoid)
	local controlsObj = GetPlayerControls()
	if type(controlsObj) == "table" then
		pcall(function()
			controlsObj.humanoid = humanoid
		end)
	end
end

local function RestartAnimateScript(character)
	local animateScript = character and character:FindFirstChild("Animate")
	if animateScript and animateScript:IsA("LocalScript") then
		task.spawn(function()
			pcall(function()
				animateScript.Enabled = false
			end)
			task.wait()
			pcall(function()
				animateScript.Enabled = true
			end)
		end)
	end
end

local function EnableNormalHumanoidStates(humanoid)
	if not humanoid then
		return
	end
	pcall(function()
		for _, stateType in ipairs(NormalHumanoidStates) do
			humanoid:SetStateEnabled(stateType, true)
		end
		humanoid.PlatformStand = false
		humanoid.Sit = false
		humanoid.AutoRotate = true
	end)
end

local function SyncCameraToHumanoid(targetHumanoid)
	local engineRef = RuntimeState.StealEngine
	if engineRef and engineRef.IsSafeZoneVisual and engineRef.IsSafeZoneVisual() then
		return
	end
	local camera = Workspace.CurrentCamera
	if camera and targetHumanoid then
		pcall(function()
			if camera.CameraType == Enum.CameraType.Scriptable then
				camera.CameraType = Enum.CameraType.Custom
			end
			if camera.CameraSubject ~= targetHumanoid then
				camera.CameraSubject = targetHumanoid
			end
		end)
	end
end

local function ClearSwapConnections()
	for _, connection in ipairs(RuntimeState.SwapLinks) do
		pcall(connection.Disconnect, connection)
	end
	table.clear(RuntimeState.SwapLinks)
end

local function PerformHumanoidSwap()
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not character or not humanoid or humanoid.Health <= 0 then
		return false
	end
	if RuntimeState.OriginalHumanoid and RuntimeState.SwapClone and RuntimeState.SwapClone.Parent == character then
		return true
	end

	local currentState = humanoid:GetState()
	local isGrounded = (humanoid.FloorMaterial and humanoid.FloorMaterial ~= Enum.Material.Air)
		or currentState == Enum.HumanoidStateType.Running
		or currentState == Enum.HumanoidStateType.RunningNoPhysics
		or currentState == Enum.HumanoidStateType.Landed
	if not isGrounded then
		return false
	end

	pcall(function()
		ClearSwapConnections()
		humanoid.BreakJointsOnDeath = false
		local clonedHumanoid = humanoid:Clone()
		humanoid.Parent = nil
		clonedHumanoid.Parent = character
		RuntimeState.OriginalHumanoid = humanoid
		RuntimeState.SwapClone = clonedHumanoid
		pcall(function()
			humanoid.RequiresNeck = false
		end)

		clonedHumanoid.WalkSpeed = humanoid.WalkSpeed
		clonedHumanoid.JumpPower = humanoid.JumpPower
		clonedHumanoid.UseJumpPower = humanoid.UseJumpPower
		SyncCameraToHumanoid(clonedHumanoid)

		clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		clonedHumanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
		RepointControls(clonedHumanoid)
		RestartAnimateScript(character)

		for _, propertyName in ipairs({ "WalkSpeed", "JumpPower", "UseJumpPower", "HipHeight" }) do
			local propConn = humanoid:GetPropertyChangedSignal(propertyName):Connect(function()
				pcall(function()
					clonedHumanoid[propertyName] = humanoid[propertyName]
				end)
			end)
			table.insert(RuntimeState.SwapLinks, propConn)
		end
	end)
	return true
end

local function SyncHumanoidSwap()
	local character = LocalPlayer.Character
	local clonedHumanoid = RuntimeState.SwapClone
	local originalHumanoid = RuntimeState.OriginalHumanoid
	if not character or not clonedHumanoid or clonedHumanoid.Parent ~= character or not originalHumanoid or clonedHumanoid == originalHumanoid then
		return
	end
	pcall(function()
		clonedHumanoid.WalkSpeed = originalHumanoid.WalkSpeed
		clonedHumanoid.JumpPower = originalHumanoid.JumpPower
		clonedHumanoid.UseJumpPower = originalHumanoid.UseJumpPower
	end)
end

local function RestoreCharacter()
	local character = LocalPlayer.Character
	if not character then
		return
	end
	local originalHumanoid = RuntimeState.OriginalHumanoid
	local clonedHumanoid = RuntimeState.SwapClone

	if originalHumanoid and originalHumanoid.Parent == nil and clonedHumanoid and clonedHumanoid.Parent == character then
		pcall(function()
			originalHumanoid.Parent = character
			SyncCameraToHumanoid(originalHumanoid)
			if clonedHumanoid ~= originalHumanoid and clonedHumanoid.Parent == character then
				clonedHumanoid:Destroy()
			end
		end)
	end

	for _, targetHumanoid in ipairs({ character:FindFirstChildOfClass("Humanoid"), originalHumanoid }) do
		if targetHumanoid then
			EnableNormalHumanoidStates(targetHumanoid)
			pcall(targetHumanoid.Move, targetHumanoid, Vector3.zero, false)
			pcall(function()
				if targetHumanoid.Health > 0 and (targetHumanoid:FindFirstChild("Neck") ~= nil or targetHumanoid.RigType ~= Enum.HumanoidRigType.R6) then
					targetHumanoid.RequiresNeck = true
					targetHumanoid.BreakJointsOnDeath = true
				end
			end)
			RepointControls(targetHumanoid)
		end
	end

	ClearSwapConnections()
	RuntimeState.OriginalHumanoid = nil
	RuntimeState.SwapClone = nil
	pcall(function()
		LocalPlayer:Move(Vector3.zero, false)
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			rootPart.AssemblyLinearVelocity = Vector3.zero
			rootPart.AssemblyAngularVelocity = Vector3.zero
			rootPart.Anchored = false
		end
	end)
	RestartAnimateScript(character)
end


local AntiRagdollGuard = {
	RecoverUntil = 0,
	BoundCharacter = nil,
	CharConnections = {},
	GlobalConnections = {},
}

local function ClearCharacterRagdollJoints(character)
	if not character then
		return
	end
	if ClientRagdollModule then
		if type(ClientRagdollModule.ClearClientRagdoll) == "function" then
			pcall(ClientRagdollModule.ClearClientRagdoll)
		end
		if type(ClientRagdollModule.Unragdoll) == "function" then
			pcall(ClientRagdollModule.Unragdoll, character)
		end
	end
	if RagdollJointsModule and type(RagdollJointsModule.Release) == "function" then
		pcall(RagdollJointsModule.Release, character)
	end
	for _, descendant in ipairs(character:GetDescendants()) do
		if RagdollConstraintNames[descendant.ClassName] then
			pcall(descendant.Destroy, descendant)
		elseif (descendant:IsA("Motor6D") or descendant:IsA("AnimationConstraint")) and not descendant.Enabled then
			pcall(function()
				descendant.Enabled = true
			end)
		end
	end
end

local function RecoverFromRagdoll(character, humanoid)
	if not character or not humanoid then
		return
	end
	local engineRef = RuntimeState.StealEngine
	if engineRef and (engineRef.AutoCycle or (engineRef.IsInExternalMapOrEvent and engineRef.IsInExternalMapOrEvent())) then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart and not RuntimeState.IsExecuting then
		local currentVelocity = rootPart.AssemblyLinearVelocity
		local horizontalVel = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
		local speedCap = (humanoid.WalkSpeed or 16) + 5
		if horizontalVel.Magnitude > speedCap or currentVelocity.Y > 0 then
			if horizontalVel.Magnitude > speedCap then
				horizontalVel = horizontalVel.Unit * speedCap
			end
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(horizontalVel.X, math.min(currentVelocity.Y, 0), horizontalVel.Z)
			end)
		end
	end

	ClearCharacterRagdollJoints(character)

	if humanoid.Health > 0 then
		if RagdollStateSet[humanoid:GetState()] then
			pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Running)
		end
		if humanoid.PlatformStand then
			humanoid.PlatformStand = false
		end
	end

	local controlsObj = GetPlayerControls()
	if controlsObj and controlsObj.controlsEnabled == false then
		pcall(controlsObj.Enable, controlsObj)
	end
	SyncCameraToHumanoid(humanoid)

	pcall(function()
		character:SetAttribute("RagdollEndTime", 0)
		LocalPlayer:SetAttribute("RagdollEndTime", 0)
	end)
end

local function ApplyAntiRagdoll(character)
	local engineRef = RuntimeState.StealEngine
	if engineRef and (engineRef.AutoCycle or (engineRef.IsInExternalMapOrEvent and engineRef.IsInExternalMapOrEvent())) then
		return
	end
	character = character or LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not character or not humanoid or humanoid.Health <= 0 then
		return
	end

	if AntiRagdollGuard.BoundCharacter ~= character then
		for _, connection in ipairs(AntiRagdollGuard.CharConnections) do
			pcall(connection.Disconnect, connection)
		end
		table.clear(AntiRagdollGuard.CharConnections)
		AntiRagdollGuard.BoundCharacter = character

		local function triggerRecovery()
			if FarmConfig.Defense_AntiRagdoll then
				AntiRagdollGuard.RecoverUntil = os.clock() + 0.5
				local activeHumanoid = character:FindFirstChildOfClass("Humanoid") or humanoid
				RecoverFromRagdoll(character, activeHumanoid)
			end
		end

		table.insert(AntiRagdollGuard.CharConnections, humanoid.StateChanged:Connect(function(_, newState)
			if RagdollStateSet[newState] then
				triggerRecovery()
			end
		end))
		table.insert(AntiRagdollGuard.CharConnections, humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
			if humanoid.PlatformStand then
				triggerRecovery()
			end
		end))
		table.insert(AntiRagdollGuard.CharConnections, character.DescendantAdded:Connect(function(descendant)
			if RagdollConstraintNames[descendant.ClassName] then
				triggerRecovery()
			end
		end))
	end

	if not FarmConfig.Defense_AntiRagdoll then
		return
	end
	local ragdollEndTime = ToFiniteNumber(LocalPlayer:GetAttribute("RagdollEndTime") or character:GetAttribute("RagdollEndTime"), 0)
	local isRagdolled = humanoid.PlatformStand
		or RagdollStateSet[humanoid:GetState()]
		or (ragdollEndTime > Workspace:GetServerTimeNow())
		or (ClientRagdollModule and type(ClientRagdollModule.IsRagdolled) == "function" and select(2, pcall(ClientRagdollModule.IsRagdolled, character)) == true)

	if isRagdolled then
		AntiRagdollGuard.RecoverUntil = os.clock() + 0.5
	end
	if os.clock() <= AntiRagdollGuard.RecoverUntil then
		RecoverFromRagdoll(character, humanoid)
	end
end

do
	local function onRemoteRagdoll()
		if FarmConfig.Defense_AntiRagdoll then
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if character and humanoid then
				AntiRagdollGuard.RecoverUntil = os.clock() + 0.5
				RecoverFromRagdoll(character, humanoid)
			end
		end
	end
	local ragdollRemote = ClientRagdollModule
		and typeof(ClientRagdollModule.ClientRagdollRemote) == "Instance"
		and ClientRagdollModule.ClientRagdollRemote
		or nil
	if ragdollRemote and ragdollRemote:IsA("RemoteEvent") then
		pcall(function()
			table.insert(AntiRagdollGuard.GlobalConnections, ragdollRemote.OnClientEvent:Connect(onRemoteRagdoll))
		end)
	end
	pcall(function()
		table.insert(AntiRagdollGuard.GlobalConnections, LocalPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(onRemoteRagdoll))
	end)
end

local PromptZeroHoldConnection = nil
pcall(function()
	PromptZeroHoldConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(promptInstance, triggerPlayer)
		if triggerPlayer == LocalPlayer and (promptInstance.Name == "CarryAreaEgg" or tostring(promptInstance) == "CarryAreaEgg") then
			promptInstance.HoldDuration = 0
		end
	end)
end)

-- ============================================================================
-- 4. FIELD EGG SCANNER & FLIGHT CONTROLLER (ONIUM CORE)
-- ============================================================================

local Engine = {
	Disposed = false,
	AutoStatus = "Idle",
	AutoTargetText = "None",
	AutoCycle = nil,
	CurrentTarget = nil,
	AutoDeliverySerial = 0,
	AutoHandledDeliverySerial = 0,
	AutoCarry = {
		Carrying = false,
		CarryUid = nil,
		CarryAreaId = nil,
		LastFinishedAt = 0,
	},
	Guard = {
		Enabled = false,
		Busy = false,
		Active = false,
		StealActive = false,
		Disguise = nil,
	},
	Carry = {
		ClimbShare = 0.5,
		RunSpeed = 1.15,
		RunAnimate = true,
		RunStyle = "Velocity",
		CarryStyle = "Velocity",
		CarryReact = 0,
		SpeedJitter = 0.08,
		Wobble = 0,
		LaneOffset = 0,
		PausesPerMinute = 0,
		JumpsPerMinute = 0,
		SlowUntil = 0,
		SlowFactor = 0.3,
		ApproachStop = 3,
		ApproachTime = 30,
		TweenScale = 1,
		GrabLift = 2.5,
		LockCamera = false,
	},
	State = {
		Priority = "Highest Value",
		BlockList = {},
	},
	Movement = {
		Owner = nil,
		PlaceWanted = false,
		StealFirst = false,
	},
	AutoTrace = {},
}
RuntimeState.StealEngine = Engine
Hub.Engine = Engine

function Engine.UpdateAutoCarry(carryData)
	local isCarrying = type(carryData) == "table" and carryData.IsCarrying == true
	local carryState = Engine.AutoCarry
	if carryState.Carrying and not isCarrying then
		carryState.LastFinishedAt = os.clock()
	end
	if isCarrying and type(carryData.Uid) == "string" then
		carryState.CarryUid = carryData.Uid
		carryState.CarryAreaId = carryData.AreaId
	end
	carryState.Carrying = isCarrying
	if Engine.RecordAutoTrace then
		Engine.RecordAutoTrace(isCarrying and "carry-on" or "carry-off", carryState.CarryUid)
	end
	if Engine.AutoWake then
		Engine.AutoWake()
	end
end

local CarryChangedConnection = nil
pcall(function()
	local carrySignal = EggStateModule and EggStateModule.CarryChanged
	if type(carrySignal) == "table" and type(carrySignal.Connect) == "function" then
		CarryChangedConnection = carrySignal:Connect(Engine.UpdateAutoCarry)
	elseif type(carrySignal) == "function" then
		carrySignal(Engine.UpdateAutoCarry)
	end
end)

function Engine.ClaimMovement(ownerName)
	if ownerName ~= "mech" and LocalPlayer:GetAttribute("InScrambleArena") == true then
		return false
	end
	local currentOwner = Engine.Movement.Owner
	if currentOwner == nil or currentOwner == ownerName then
		Engine.Movement.Owner = ownerName
		return true
	end
	if currentOwner == "treadmill" and ownerName ~= "treadmill" then
		Engine.Movement.Owner = ownerName
		return true
	end
	if currentOwner == "scramble" and ownerName == "steal" then
		Engine.Movement.Owner = ownerName
		return true
	end
	return false
end

function Engine.ReleaseMovement(ownerName)
	if Engine.Movement.Owner == ownerName then
		Engine.Movement.Owner = nil
	end
end

function Engine.Root()
	local character = LocalPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart") or nil
end

function Engine.GetWalkSpeed()
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local baseSpeed = humanoid and humanoid.WalkSpeed or 16
	local origHumanoid = RuntimeState.OriginalHumanoid
	if origHumanoid and origHumanoid.Health > 0 then
		baseSpeed = math.min(baseSpeed, origHumanoid.WalkSpeed)
	end
	if TreadmillUtilModule and type(TreadmillUtilModule.SpeedPowerToWalkSpeed) == "function" then
		pcall(function()
			local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
			local speedStat = leaderstats and leaderstats:FindFirstChild("Speed")
			if speedStat then
				local converted = TreadmillUtilModule.SpeedPowerToWalkSpeed(speedStat.Value)
				if tonumber(converted) and converted > 0 then
					baseSpeed = math.min(baseSpeed, converted)
				end
			end
		end)
	end
	return baseSpeed
end

function Engine.Pace()
	local tweenScale = tonumber(Engine.Carry.TweenScale) or 1
	return math.max(Engine.GetWalkSpeed() * (tonumber(Engine.Carry.RunSpeed) or 1) * tweenScale, 16)
end

function Engine.IsGrounded(humanoid)
	if not humanoid then
		return false
	end
	if humanoid.FloorMaterial and humanoid.FloorMaterial ~= Enum.Material.Air then
		return true
	end
	local humState = humanoid:GetState()
	return humState == Enum.HumanoidStateType.Running
		or humState == Enum.HumanoidStateType.RunningNoPhysics
		or humState == Enum.HumanoidStateType.Landed
end

function Engine.SetVelocity(partInstance, velocityVec)
	if partInstance and partInstance.Parent then
		pcall(function()
			partInstance.AssemblyLinearVelocity = velocityVec
			partInstance.AssemblyAngularVelocity = Vector3.zero
		end)
	end
end

function Engine.StopVelocity()
	local rootPart = Engine.Root()
	if rootPart then
		pcall(function()
			rootPart.AssemblyLinearVelocity = Vector3.new(0, math.min(rootPart.AssemblyLinearVelocity.Y, 0), 0)
			rootPart.AssemblyAngularVelocity = Vector3.zero
		end)
	end
end

function Engine.IsInExternalMapOrEvent()
	if LocalPlayer:GetAttribute("InHalloweenDimension") == true
		or LocalPlayer:GetAttribute("InScrambleArena") == true
		or LocalPlayer:GetAttribute("InBossArena") == true
		or LocalPlayer:GetAttribute("InEnchantedTree") == true
		or LocalPlayer:GetAttribute("RaceId") ~= nil
		or LocalPlayer:GetAttribute("TrainEventTravelStage") ~= nil
	then
		return true
	end
	local character = LocalPlayer.Character
	if character and character:GetAttribute("TrainEventInForgottenTown") == true then
		return true
	end
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		local rootPos = rootPart.Position
		if rootPos.Y < -50 or rootPos.Y > 800 or rootPos.X < -200 or rootPos.X > 9500 or rootPos.Z < -2000 or rootPos.Z > 1000 then
			return true
		end
	end
	return false
end

function Engine.IsNight()
	if AreaEggCycleModule and type(AreaEggCycleModule.IsNightPhase) == "function" then
		local callOk, nightActive = pcall(AreaEggCycleModule.IsNightPhase, Workspace:GetServerTimeNow())
		return callOk and nightActive == true
	end
	return false
end

function Engine.WallSealed()
	if AreaEggResetWallModule and type(AreaEggResetWallModule.IsSealed) == "function" then
		local callOk, isSealed = pcall(AreaEggResetWallModule.IsSealed)
		return callOk and isSealed == true
	end
	return false
end

function Engine.GetSeparationX()
	local worldFolder = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
	local areasFolder = worldFolder and worldFolder:FindFirstChild("Areas")
	local sepPart = areasFolder and areasFolder:FindFirstChild("SeparationLine")
	if sepPart and sepPart:IsA("BasePart") then
		return sepPart.Position.X
	end
	return SAFE_BASE_LINE_X
end

function Engine.InsideBase(checkPos)
	if checkPos == nil then
		local rootPart = Engine.Root()
		checkPos = rootPart and rootPart.Position
	end
	if checkPos == nil then
		return false
	end
	return checkPos.X < Engine.GetSeparationX()
end

local function GetTrackStartPosition()
	local worldFolder = Workspace:FindFirstChild("World")
	local mainMap = worldFolder and worldFolder:FindFirstChild("Build") and worldFolder.Build:FindFirstChild("MainMap")
	local trackStart = (mainMap and mainMap:FindFirstChild("TrackStart", true))
		or (worldFolder and worldFolder:FindFirstChild("TrackStart", true))
	if trackStart then
		if trackStart:IsA("BasePart") then
			return trackStart.Position + Vector3.new(0, 3.5, 0)
		elseif trackStart:IsA("Model") then
			return trackStart:GetPivot().Position + Vector3.new(0, 3.5, 0)
		end
	end
	return Vector3.new(SAFE_BASE_LINE_X + 15, 71, SAFE_CORRIDOR_Z)
end

function Engine.FirePrompt(promptInstance)
	if not promptInstance then
		return false
	end
	pcall(function()
		promptInstance.RequiresLineOfSight = false
		promptInstance.HoldDuration = 0
	end)
	if typeof(fireproximityprompt) == "function" then
		pcall(fireproximityprompt, promptInstance)
		return true
	end
	return pcall(function()
		promptInstance:InputHoldBegin()
		task.wait(0.03)
		promptInstance:InputHoldEnd()
	end)
end

function Engine.NewPacer(isCarry)
	local carryCfg = Engine.Carry
	local pacerObj = {
		Clock = 0,
		Factor = 1,
		Target = 1,
		NextShift = 0,
		Phase = math.random() * math.pi * 2,
		Period = 2 + math.random() * 2.5,
		PauseUntil = 0,
		Lane = (math.random() * 2 - 1) * (tonumber(carryCfg.LaneOffset) or 0),
	}
	function pacerObj:Step(deltaTime, humanoid, isGrounded)
		self.Clock = self.Clock + deltaTime
		if self.NextShift <= self.Clock then
			self.NextShift = self.Clock + 0.5 + math.random()
			local jitterAmount = math.max(carryCfg.SpeedJitter, 0)
			if isCarry then
				self.Target = 1 - math.random() * jitterAmount
			else
				self.Target = 1 + (math.random() * 2 - 1) * jitterAmount
			end
		end
		self.Factor = self.Factor + (self.Target - self.Factor) * math.min(deltaTime * 3, 1)
		local wobbleOffset = math.sin(self.Clock * 2 * math.pi / self.Period + self.Phase) * (tonumber(carryCfg.Wobble) or 0)
		if isGrounded and humanoid and (tonumber(carryCfg.JumpsPerMinute) or 0) > 0 then
			if math.random() < (carryCfg.JumpsPerMinute / 60 * deltaTime) then
				pcall(function()
					humanoid.Jump = true
				end)
			end
		end
		local isPaused = false
		if not isCarry then
			if self.Clock < self.PauseUntil then
				isPaused = true
			elseif (tonumber(carryCfg.PausesPerMinute) or 0) > 0 then
				if math.random() < (carryCfg.PausesPerMinute / 60 * deltaTime) then
					self.PauseUntil = self.Clock + 0.3 + math.random() * 0.9
					isPaused = true
				end
			end
		end
		return self.Factor, self.Lane + wobbleOffset, isPaused
	end
	return pacerObj
end

function Engine.Lift(liftHeight, baseHeightY)
	local character = LocalPlayer.Character
	local rootPart = Engine.Root()
	if not character or not rootPart or (tonumber(liftHeight) or 0) <= 0.5 then
		return
	end
	local targetY = (baseHeightY or rootPart.Position.Y) + liftHeight
	if rootPart.Position.Y >= targetY - 2 then
		return
	end
	pcall(function()
		character:PivotTo(CFrame.new(Vector3.new(rootPart.Position.X, targetY, rootPart.Position.Z)) * rootPart.CFrame.Rotation)
		rootPart.AssemblyLinearVelocity = Vector3.zero
		rootPart.AssemblyAngularVelocity = Vector3.zero
	end)
end

function Engine.RunPace(targetPos, options)
	options = options or {}
	local sessionId = options.Session or RuntimeState.SessionId
	local isCarry = options.IsCarry == true
	local travelSpeed = tonumber(options.Speed) or Engine.Pace()
	local arcHeight = tonumber(options.Height) or 0
	local stopDistance = options.StopDist or 2.5
	local timeoutSec = options.Timeout or 20

	local character = LocalPlayer.Character
	local rootPart = Engine.Root()
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not rootPart or not humanoid then
		return false
	end

	local moveStyle = isCarry and (Engine.Carry.CarryStyle or "Velocity") or (Engine.Carry.RunStyle or "Velocity")
	local carryReact = tonumber(Engine.Carry.CarryReact) or 0
	if isCarry and carryReact > 0 then
		task.wait(carryReact * 0.1)
	end

	local pacer = Engine.NewPacer(isCarry)
	local lastClock = os.clock()
	local deadline = lastClock + timeoutSec
	local hasArrived = false
	local cancelToken = options.Cancel or RuntimeState.StealCancel
	local ignoreStealToggle = options.IgnoreStealToggle == true

	Engine.Lift(arcHeight, options.GroundY)
	if isCarry and Engine.Carry.RunAnimate then
		pcall(function()
			humanoid.PlatformStand = false
		end)
	end

	while os.clock() < deadline do
		if (not ignoreStealToggle and not IsStealActive()) or Engine.IsInExternalMapOrEvent() or RuntimeState.SessionId ~= sessionId or RuntimeState.StealCancel ~= cancelToken then
			break
		end
		rootPart = Engine.Root()
		if not rootPart or not rootPart.Parent then
			break
		end
		if Engine.Guard.Busy then
			RunService.Heartbeat:Wait()
			lastClock = os.clock()
			continue
		end

		RunService.Heartbeat:Wait()
		if (not ignoreStealToggle and not IsStealActive()) or Engine.IsInExternalMapOrEvent() or RuntimeState.SessionId ~= sessionId or RuntimeState.StealCancel ~= cancelToken then
			break
		end
		rootPart = Engine.Root()
		if not rootPart or not rootPart.Parent then
			break
		end
		local nowClock = os.clock()
		local deltaTime = math.max(nowClock - lastClock, 1 / 240)
		lastClock = nowClock

		local speedFactor, laneShift, isPaused = pacer:Step(deltaTime, humanoid, Engine.IsGrounded(humanoid))
		local goalPos = targetPos
		if options.LaneMin and options.LaneMax then
			local clampedZ = math.clamp(rootPart.Position.Z + laneShift, options.LaneMin, options.LaneMax)
			goalPos = Vector3.new(targetPos.X, targetPos.Y, clampedZ)
		end
		if options.SwitchX and rootPart.Position.X <= (options.SwitchX + 2) then
			goalPos = options.Final or targetPos
		end

		local planarVec = Vector3.new(goalPos.X - rootPart.Position.X, 0, goalPos.Z - rootPart.Position.Z)
		local planarDist = planarVec.Magnitude
		if planarDist < 2 and not options.RequireHeight then
			hasArrived = true
			break
		end

		local groundY = options.GroundY or goalPos.Y
		local useArc = arcHeight > 0.5
		if useArc and options.ArcField then
			useArc = rootPart.Position.X > (Engine.GetSeparationX() - 2)
		end
		local targetY = groundY
		if useArc then
			local climbShare = math.clamp(Engine.Carry.ClimbShare, 0.1, 0.9)
			local climbSpan = arcHeight * math.sqrt(1 - climbShare * climbShare) / climbShare
			local arcAlpha = math.clamp(planarDist / math.max(climbSpan, 1), 0, 1)
			targetY = groundY + arcHeight * arcAlpha
		end

		local activeSpeed = travelSpeed * speedFactor
		if os.clock() < (Engine.Carry.SlowUntil or 0) then
			activeSpeed = activeSpeed * (Engine.Carry.SlowFactor or 0.3)
		end
		if isPaused then
			activeSpeed = 0
		end

		local unitDir = planarDist > 0.01 and planarVec.Unit or Vector3.zero
		if moveStyle == "CFrame" then
			local stepVec = unitDir * math.min(activeSpeed, planarDist / 0.05)
			pcall(function()
				rootPart.CFrame = CFrame.new(rootPart.Position + stepVec) * rootPart.CFrame.Rotation
				rootPart.AssemblyLinearVelocity = Vector3.new(stepVec.X, 0, stepVec.Z)
				rootPart.AssemblyAngularVelocity = Vector3.zero
			end)
		elseif useArc then
			local climbShare = math.clamp(Engine.Carry.ClimbShare, 0.1, 0.9)
			local verticalVel = math.clamp((targetY - rootPart.Position.Y) / 0.12, -activeSpeed * climbShare, activeSpeed * climbShare)
			local horizSpeed = math.sqrt(math.max(activeSpeed * activeSpeed - verticalVel * verticalVel, 0))
			local stepVec = unitDir * math.min(horizSpeed, planarDist / 0.05)
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(stepVec.X, verticalVel, stepVec.Z)
			end)
		else
			local stepVec = unitDir * math.min(activeSpeed, planarDist / 0.05)
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(stepVec.X, rootPart.AssemblyLinearVelocity.Y, stepVec.Z)
			end)
			if Engine.Carry.RunAnimate and planarDist > 0.01 then
				pcall(humanoid.Move, humanoid, unitDir, false)
			end
		end

		if planarDist > 0.1 then
			pcall(function()
				rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + unitDir)
			end)
		end
		if (nowClock - (options._lastAntiRagAt or 0)) >= 0.15 then
			options._lastAntiRagAt = nowClock
			ApplyAntiRagdoll(character)
		end
	end

	pcall(humanoid.Move, humanoid, Vector3.zero, false)
	Engine.SetVelocity(Engine.Root(), Vector3.zero)
	if hasArrived then
		return true
	end
	if rootPart.Parent ~= nil then
		local remainPlanar = Vector3.new(rootPart.Position.X - targetPos.X, 0, rootPart.Position.Z - targetPos.Z)
		return remainPlanar.Magnitude <= stopDistance
	end
	return false
end

function Engine.FlyToPosition(targetPos, sessionId, stopDistance, maxDuration, speedLimit, ignoreStealToggle)
	local carryCfg = Engine.Carry
	local travelPace = math.min(Engine.Pace(), math.max(speedLimit or FarmConfig.TweenSpeed or 600, 16))
	local elevatedPos = targetPos + Vector3.new(0, math.max((carryCfg.GrabLift or 2.5) - 3, 0) + 3, 0)
	return Engine.RunPace(elevatedPos, {
		Session = sessionId,
		Speed = travelPace,
		Height = 3,
		GroundY = elevatedPos.Y - 3,
		IsCarry = false,
		StopDist = stopDistance or 3,
		Timeout = maxDuration or 30,
		IgnoreStealToggle = ignoreStealToggle == true,
	})
end

local CachedFieldEggs, CachedFieldEggsAt = {}, 0
function Engine.CollectRawFieldEggs(forceRefresh)
	local nowClock = os.clock()
	if not forceRefresh and #CachedFieldEggs > 0 and (nowClock - CachedFieldEggsAt) < 0.5 then
		return CachedFieldEggs
	end

	local collectedList, seenUids = {}, {}
	local function appendEggRecord(recordKey, eggRecord)
		if type(eggRecord) ~= "table" then
			return
		end
		local bottomCF = eggRecord.BottomCFrame or eggRecord.BoundsCFrame or eggRecord.CFrame
		if not bottomCF then
			return
		end
		local eggUid = eggRecord.Uid or tostring(recordKey)
		if seenUids[eggUid] then
			return
		end
		local stateText = tostring(eggRecord.State or "")
		if stateText == "Slot"
			or stateText == "Dropped"
			or stateText == "Carried"
			or eggRecord.State == 1
			or eggRecord.State == 2
			or eggRecord.State == 3
		then
			eggRecord.Uid = eggUid
			eggRecord.BoundsCFrame = bottomCF
			seenUids[eggUid] = true
			if stateText == "Slot" and type(eggRecord.AreaId) == "string" and eggRecord.AreaId ~= "" then
				local posX = bottomCF.Position.X
				local zoneRange = LiveZoneXRanges[eggRecord.AreaId]
				if zoneRange then
					zoneRange[1] = math.min(zoneRange[1], posX)
					zoneRange[2] = math.max(zoneRange[2], posX)
				else
					LiveZoneXRanges[eggRecord.AreaId] = { posX, posX }
				end
			end
			table.insert(collectedList, eggRecord)
		end
	end

	if EggStateModule and type(EggStateModule.ReadFieldEggs) == "function" then
		local callOk, snapshotResult = pcall(EggStateModule.ReadFieldEggs)
		if callOk and type(snapshotResult) == "table" and type(snapshotResult.Records) == "table" then
			for recordKey, eggRecord in pairs(snapshotResult.Records) do
				appendEggRecord(recordKey, eggRecord)
			end
		end
	end

	if #collectedList == 0 and Remotes.EggSnapshot and Remotes.EggSnapshot:IsA("RemoteFunction") then
		local callOk, snapshotResult = pcall(Remotes.EggSnapshot.InvokeServer, Remotes.EggSnapshot)
		if callOk and type(snapshotResult) == "table" then
			for recordKey, eggRecord in pairs(snapshotResult.Records or snapshotResult) do
				appendEggRecord(recordKey, eggRecord)
			end
		end
	end

	local slotsFolder = Workspace:FindFirstChild("AreaEggSlotsClient")
	if slotsFolder then
		for _, eggModel in ipairs(slotsFolder:GetChildren()) do
			if seenUids[eggModel.Name] then
				for _, eggRecord in ipairs(collectedList) do
					if eggRecord.Uid == eggModel.Name then
						eggRecord.PhysicalModel = eggModel
						break
					end
				end
			end
		end
	end

	if #collectedList > 0 or forceRefresh then
		CachedFieldEggs = collectedList
		CachedFieldEggsAt = nowClock
	end
	return collectedList
end

local function MatchesSelectedFilters(zoneName, categoryName, rarityName)
	if next(FarmConfig.SelectedZones) ~= nil and not FarmConfig.SelectedZones[string.lower(zoneName)] then
		return false
	end
	if next(FarmConfig.SelectedEggs) ~= nil and not FarmConfig.SelectedEggs[string.lower(categoryName)] then
		return false
	end
	if next(FarmConfig.SelectedRarities) ~= nil then
		local targetRarityKey = NormalizeRarityKey(rarityName)
		local rarityMatched = false
		for selectedRarity in pairs(FarmConfig.SelectedRarities) do
			if NormalizeRarityKey(selectedRarity) == targetRarityKey then
				rarityMatched = true
				break
			end
		end
		if not rarityMatched then
			return false
		end
	end
	return true
end

function Engine.SurveyFieldEggs()
	local surveyRecords = {}
	for _, eggRecord in ipairs(Engine.CollectRawFieldEggs(false)) do
		local categoryName = tostring(eggRecord.AssetCategory or eggRecord.Category or eggRecord.Name or "")
		if eggRecord.Uid ~= nil and categoryName ~= "" then
			local referenceCFrame = eggRecord.BoundsCFrame or eggRecord.BottomCFrame
			local referencePosition = typeof(referenceCFrame) == "CFrame" and referenceCFrame.Position or nil
			local rarityName, rarityRank = ResolveEggRarity(eggRecord)
			table.insert(surveyRecords, {
				Uid = tostring(eggRecord.Uid),
				Category = categoryName,
				Zone = ResolveEggZone(eggRecord.AreaId, referencePosition, categoryName),
				Rarity = tostring(rarityName or "Common"),
				Rank = ToFiniteNumber(rarityRank, 0),
				State = tostring(eggRecord.State or ""),
				Income = CalculateEggIncome(eggRecord),
			})
		end
	end
	return surveyRecords
end

function Engine.MatchesStealFilters(zoneName, categoryName, rarityName)
	return MatchesSelectedFilters(zoneName, categoryName, rarityName)
end

function Engine.CollectCandidates(includeCarried, isNormalMode)
	local rawEggs = Engine.CollectRawFieldEggs(isNormalMode == true)
	if #rawEggs == 0 then
		return {}
	end
	local rootPart = Engine.Root()
	local playerPos = rootPart and rootPart.Position or Vector3.new(SAFE_BASE_LINE_X, 70, SAFE_CORRIDOR_Z)
	local candidates = {}

	for _, eggRecord in ipairs(rawEggs) do
		local eggUid = tostring(eggRecord.Uid or "")
		if eggUid == "" then
			continue
		end
		local eggCFrame = eggRecord.BoundsCFrame or (eggRecord.PhysicalModel and eggRecord.PhysicalModel:GetPivot())
		if not eggCFrame or eggCFrame.Position.X <= (SAFE_BASE_LINE_X + 10) then
			continue
		end

		local eggPos = eggCFrame.Position
		local lowerState = string.lower(tostring(eggRecord.State or ""))
		local isCarried = lowerState ~= "" and (lowerState:find("carri") ~= nil or lowerState:find("taken") ~= nil)
		if isCarried and not includeCarried then
			continue
		end

		local categoryName = tostring(eggRecord.AssetCategory or eggRecord.Name or "Egg")
		local zoneName = ResolveEggZone(eggRecord.AreaId, eggPos, categoryName)
		local rarityName, rarityRank = ResolveEggRarity(eggRecord)

		if MatchesSelectedFilters(zoneName, categoryName, rarityName) then
			local incomeRate = CalculateEggIncome(eggRecord)
			local weightKg = GetEggWeightKg(eggRecord)
			local distanceStuds = ToFiniteNumber((playerPos - eggPos).Magnitude, 0)

			table.insert(candidates, {
				Uid = eggUid,
				Category = categoryName,
				Zone = zoneName,
				ZoneRank = ToFiniteNumber(AreaRankByName[zoneName], 1),
				Rarity = rarityName,
				RarityRank = ToFiniteNumber(rarityRank, 1),
				WeightBucket = math.floor(weightKg * 100),
				MutationCount = (type(eggRecord.Mutations) == "table" and #eggRecord.Mutations) or 0,
				Income = incomeRate,
				IncomeBucket = math.floor(incomeRate),
				DistanceBucket = math.floor(distanceStuds * 10),
				CFrame = eggCFrame,
				Position = eggPos,
				PhysicalModel = eggRecord.PhysicalModel,
				AreaId = eggRecord.AreaId,
				State = eggRecord.State,
				Raw = eggRecord,
			})
		end
	end

	local priorityMode = Engine.State.Priority
	table.sort(candidates, function(candA, candB)
		if priorityMode == "Best Rarity" and candA.RarityRank ~= candB.RarityRank then
			return candA.RarityRank > candB.RarityRank
		elseif priorityMode == "Biggest Weight" and candA.WeightBucket ~= candB.WeightBucket then
			return candA.WeightBucket > candB.WeightBucket
		elseif priorityMode == "Best Mutation" and candA.MutationCount ~= candB.MutationCount then
			return candA.MutationCount > candB.MutationCount
		elseif priorityMode == "Highest Value" and candA.IncomeBucket ~= candB.IncomeBucket then
			return candA.IncomeBucket > candB.IncomeBucket
		elseif priorityMode == "Lowest Value" and candA.IncomeBucket ~= candB.IncomeBucket then
			return candA.IncomeBucket < candB.IncomeBucket
		end

		if candA.RarityRank ~= candB.RarityRank then
			return candA.RarityRank > candB.RarityRank
		end
		if candA.ZoneRank ~= candB.ZoneRank then
			return candA.ZoneRank > candB.ZoneRank
		end
		if candA.IncomeBucket ~= candB.IncomeBucket then
			return candA.IncomeBucket > candB.IncomeBucket
		end
		if candA.DistanceBucket ~= candB.DistanceBucket then
			return candA.DistanceBucket < candB.DistanceBucket
		end
		return candA.Uid < candB.Uid
	end)

	return candidates
end

-- ============================================================================
-- 5. NORMAL AUTO STEAL & SAFE ZONE VISUAL (EXACT ONIUM SENAV2 ENGINE)
-- ============================================================================

-- 5A. Persistent Humanoid Swap & Clone Health Keeper
do
	local shieldDisposed = false
	local healthHumanoid, healthSaved, healthConnection = nil, nil, nil
	local isHealing, elapsedCheck = false, 0

	function Engine.AutoShieldWanted()
		return not shieldDisposed
			and IsStealActive() == true
			and not Engine.IsInExternalMapOrEvent()
			and (Engine.AutoCycle ~= nil or os.clock() < (Engine.ShieldHoldUntil or 0))
	end

	function Engine.AutoShieldReady()
		local character = LocalPlayer.Character
		local clonedHumanoid = RuntimeState.SwapClone
		local originalHumanoid = RuntimeState.OriginalHumanoid
		return character ~= nil
			and clonedHumanoid ~= nil
			and clonedHumanoid.Parent == character
			and originalHumanoid ~= nil
			and originalHumanoid.Parent == nil
			and character:FindFirstChildOfClass("Humanoid") == clonedHumanoid
	end

	local function ReleaseHealthKeeper()
		if healthConnection then
			healthConnection:Disconnect()
			healthConnection = nil
		end
		if healthHumanoid and healthHumanoid.Parent and healthSaved then
			pcall(function()
				healthHumanoid.BreakJointsOnDeath = healthSaved.BreakJointsOnDeath
				healthHumanoid.RequiresNeck = healthSaved.RequiresNeck
				for stateEnum, wasEnabled in pairs(healthSaved.States) do
					healthHumanoid:SetStateEnabled(stateEnum, wasEnabled)
				end
			end)
		end
		healthHumanoid, healthSaved = nil, nil
	end

	local function MaintainHealthKeeper()
		if not Engine.AutoShieldWanted() then
			ReleaseHealthKeeper()
			return
		end
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		if healthHumanoid ~= humanoid then
			ReleaseHealthKeeper()
			healthHumanoid = humanoid
			healthSaved = {
				BreakJointsOnDeath = humanoid.BreakJointsOnDeath,
				RequiresNeck = humanoid.RequiresNeck,
				States = {},
			}
			for _, stateEnum in ipairs({
				Enum.HumanoidStateType.Dead,
				Enum.HumanoidStateType.FallingDown,
				Enum.HumanoidStateType.Ragdoll,
			}) do
				pcall(function()
					healthSaved.States[stateEnum] = humanoid:GetStateEnabled(stateEnum)
					humanoid:SetStateEnabled(stateEnum, false)
				end)
			end
			humanoid.BreakJointsOnDeath = false
			humanoid.RequiresNeck = false
			healthConnection = humanoid.HealthChanged:Connect(function()
				if humanoid.Health <= 0 and not isHealing and Engine.AutoShieldWanted() then
					isHealing = true
					pcall(function()
						humanoid.Health = math.max(humanoid.MaxHealth, 100)
					end)
					isHealing = false
				end
			end)
		end
		if humanoid.Health <= 0 and not isHealing then
			isHealing = true
			pcall(function()
				humanoid.Health = math.max(humanoid.MaxHealth, 100)
			end)
			isHealing = false
		end
		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end
	end

	function Engine.ReleaseAutoShield(shouldRestore)
		ReleaseHealthKeeper()
		if shouldRestore and Engine.AutoShieldReady() then
			RestoreCharacter()
		end
	end

	function Engine.MaintainAutoShield()
		if not Engine.AutoShieldWanted() then
			return false
		end
		if Engine.IsInExternalMapOrEvent() then
			return false
		end
		if not Engine.AutoShieldReady() then
			PerformHumanoidSwap()
		end
		if not Engine.AutoShieldReady() then
			return false
		end
		MaintainHealthKeeper()
		SyncHumanoidSwap()
		SyncCameraToHumanoid(RuntimeState.SwapClone)
		return Engine.AutoShieldReady()
	end

	local shieldHeartbeatConn = RunService.Heartbeat:Connect(function(deltaTime)
		elapsedCheck = elapsedCheck + deltaTime
		if not Engine.AutoShieldWanted() then
			if healthHumanoid or Engine.AutoShieldReady() then
				Engine.ReleaseAutoShield(true)
			end
			return
		end
		if elapsedCheck < 0.1 then
			return
		end
		elapsedCheck = 0
		local callOk, failureMsg = pcall(Engine.MaintainAutoShield)
		if not callOk then
			warn("[N3 HUB] Normal character preparation: " .. tostring(failureMsg))
		end
	end)

	local shieldCharConn = LocalPlayer.CharacterAdded:Connect(function()
		ReleaseHealthKeeper()
		Engine.AutoCarry.Carrying = false
		Engine.AutoCarry.CarryUid = nil
		Engine.AutoCarry.CarryAreaId = nil
		if Engine.CancelAutoSteal then
			Engine.CancelAutoSteal()
		end
	end)

	pcall(function()
		LibraryLoader:OnUnload(function()
			shieldDisposed = true
			shieldHeartbeatConn:Disconnect()
			shieldCharConn:Disconnect()
			if Engine.CancelAutoSteal then
				Engine.CancelAutoSteal()
			end
			Engine.ReleaseAutoShield(true)
		end)
	end)
end

function Engine.RecordAutoTrace(eventName, eggUid)
	if not Engine.AutoCycle then
		return
	end
	local rootPart = Engine.Root()
	local carryState = Engine.AutoCarry
	local traceRow = string.format(
		"%.3f %s uid=%s carry=%s/%s pos=%s velocity=%s shield=%s",
		os.clock(),
		tostring(eventName),
		tostring(eggUid),
		tostring(carryState.Carrying),
		tostring(carryState.CarryUid),
		tostring(rootPart and rootPart.Position),
		tostring(rootPart and rootPart.AssemblyLinearVelocity),
		tostring(Engine.AutoShieldReady())
	)
	local traceList = Engine.AutoTrace
	if #traceList >= 16 then
		table.remove(traceList, 1)
	end
	traceList[#traceList + 1] = traceRow
end

-- 5B. Normal Auto Steal: SenaV2 Fly + Drop/Regrab + Natural MoveTo Deposit
do
	local senaDisposed, workerRunning, cycleGeneration = false, false, 0
	local senaConnections, liveRecords, skippedEggs, carryTimeouts = {}, {}, {}, {}
	local retryUid, resetBlocked, gateOpenAt = nil, false, 0
	local nextTickClock, wakePending = 0, true

	local safePosition = Vector3.new(544.76, 71.5, -416.48)
	local deliveryDrop = DELIVERY_DROP_CFRAME
	local eggStates = (AreaEggTypesModule and AreaEggTypesModule.States)
		or { Slot = "Slot", Dropped = "Dropped", Carried = "Carried", Claimed = "Claimed" }

	local treadmillRemotes = {
		Snapshot = Remotes.TreadmillSnapshot,
		Wear = Remotes.TreadmillWear,
		Doff = Remotes.TreadmillDoff,
	}

	function Engine.AutoSpeed()
		return math.clamp(tonumber(FarmConfig.AutoTweenSpeed) or 400, 100, 1000)
	end

	local function IsAutoStealEnabled()
		return not senaDisposed and IsStealActive() == true
	end

	local function ConnectSignal(signalObj, callbackFn)
		if signalObj and type(signalObj.Connect) == "function" then
			senaConnections[#senaConnections + 1] = signalObj:Connect(callbackFn)
		end
	end

	local function ReadEgg(eggUid)
		if EggStateModule and type(EggStateModule.ReadFieldEgg) == "function" then
			-- A nil live read must NEVER be replaced with an old carried record!
			local callOk, liveRecord = pcall(EggStateModule.ReadFieldEgg, eggUid)
			if callOk then
				return liveRecord
			end
		end
		return liveRecords[eggUid]
	end

	local function IsEggAvailable(eggRecord)
		return type(eggRecord) == "table" and (eggRecord.State == eggStates.Slot or eggRecord.State == eggStates.Dropped)
	end

	local function IsCarriedByMe(eggUid)
		local eggRecord = ReadEgg(eggUid)
		return eggRecord ~= nil and eggRecord.State == eggStates.Carried and eggRecord.CarrierUserId == LocalPlayer.UserId
	end

	local function IsBankRecordGone(eggUid)
		local eggRecord = ReadEgg(eggUid)
		return eggRecord == nil or eggRecord.State == eggStates.Claimed
	end

	local function ReplaceSnapshot(snapshotData)
		table.clear(liveRecords)
		local recordSource = type(snapshotData) == "table" and (snapshotData.Records or snapshotData) or {}
		for recordKey, eggRecord in pairs(recordSource) do
			if type(eggRecord) == "table" then
				liveRecords[eggRecord.Uid or recordKey] = eggRecord
			end
		end
		wakePending = true
	end

	if EggStateModule and type(EggStateModule.ReadFieldEggs) == "function" then
		local callOk, initialSnapshot = pcall(EggStateModule.ReadFieldEggs)
		if callOk then
			ReplaceSnapshot(initialSnapshot)
		end
	end

	local function IsCycleCurrent(cycle)
		return IsAutoStealEnabled()
			and not Engine.IsInExternalMapOrEvent()
			and Engine.AutoCycle == cycle
			and cycleGeneration == cycle.Generation
			and RuntimeState.SessionId == cycle.Session
			and RuntimeState.StealCancel == cycle.Cancel
			and LocalPlayer.Character == cycle.Character
			and cycle.Root.Parent == cycle.Character
			and (not cycle.ReturnDeadline or os.clock() < cycle.ReturnDeadline)
	end

	local function IsWallOpen()
		if resetBlocked or os.clock() < gateOpenAt or Engine.WallSealed() or Engine.IsNight() then
			return false
		end
		local worldFolder = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
		local areasFolder = worldFolder and worldFolder:FindFirstChild("Areas")
		local startWall = areasFolder and areasFolder:FindFirstChild("WallStartCollision")
		return not (startWall and startWall:IsA("BasePart") and startWall.CanCollide)
	end

	local function SetCycleStatus(cycle, statusText)
		if not cycle or Engine.AutoCycle == cycle then
			Engine.AutoStatus = statusText
		end
	end

	local function GetFeetOffset(cycle)
		local humanoid, rootPart = cycle.Humanoid, cycle.Root
		local hipPart = (humanoid.RigType == Enum.HumanoidRigType.R15 and math.max(humanoid.HipHeight, 0.5) or 2)
		return rootPart.Size.Y * 0.5 + hipPart
	end

	local function GetEggDestination(cycle, eggRecord)
		local bottomCF = eggRecord and (eggRecord.BottomCFrame or eggRecord.BoundsCFrame)
		if typeof(bottomCF) == "CFrame" then
			return CFrame.new(bottomCF.Position + Vector3.new(0, GetFeetOffset(cycle) + 0.15, 0))
		end
		return nil
	end

	local function ProbeGroundY(cycle, posX, posZ)
		local exclusions = { cycle.Character }
		if cycle.HoverPad then
			exclusions[#exclusions + 1] = cycle.HoverPad
		end
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.IgnoreWater = true
		for _ = 1, 10 do
			rayParams.FilterDescendantsInstances = exclusions
			local rayHit = Workspace:Raycast(
				Vector3.new(posX, cycle.Root.Position.Y + 60, posZ),
				Vector3.new(0, -300, 0),
				rayParams
			)
			if not rayHit then
				return nil
			end
			if rayHit.Instance == nil or rayHit.Instance.CanCollide then
				return rayHit.Position.Y
			end
			exclusions[#exclusions + 1] = rayHit.Instance
		end
		return nil
	end

	local function GetSafeDestination(cycle)
		local groundY = ProbeGroundY(cycle, safePosition.X, safePosition.Z)
		local standY = groundY and (groundY + 3.2) or safePosition.Y
		return CFrame.new(safePosition.X, standY, safePosition.Z) * cycle.Root.CFrame.Rotation
	end

	local DROP_GAP = 12
	local CARRY_ROTATION = CFrame.Angles(0, math.pi / 2, 0)

	local function GetDropPoint(cycle)
		local dropX = Engine.GetSeparationX() + DROP_GAP
		local groundY = ProbeGroundY(cycle, dropX, safePosition.Z)
		local standY = groundY and (groundY + 3.2) or deliveryDrop.Position.Y
		return CFrame.new(dropX, standY, safePosition.Z) * CARRY_ROTATION
	end

	local function IsInSafeArea(cycle)
		local deltaVec = cycle.Root.Position - safePosition
		return Vector2.new(deltaVec.X, deltaVec.Z).Magnitude <= 30 and math.abs(deltaVec.Y) <= 18
	end

	local function SyncHoverPad(cycle, worldPos)
		if not cycle.HoverPad then
			local hoverPad = Instance.new("Part")
			hoverPad.Name = "__N3SenaHoverPad"
			hoverPad.Anchored = true
			hoverPad.CanCollide = true
			hoverPad.CanQuery = true
			hoverPad.CanTouch = false
			hoverPad.CastShadow = false
			hoverPad.Transparency = 1
			hoverPad.Size = Vector3.new(8, 1, 8)
			cycle.HoverPad = hoverPad
			hoverPad.Parent = Workspace
		end
		cycle.HoverPad.CFrame = CFrame.new(worldPos.X, worldPos.Y - GetFeetOffset(cycle) - 0.55, worldPos.Z)
	end

	-- Sena ClientCharacter Anticheat Baseline Discovery & Spoofing
	local baselineSearch = { Busy = false, NextAt = 0, Misses = 0, Found = nil }
	local baselineSampleKeys = {
		"LastObservedSample",
		"LastSample",
		"LastGoodSample",
		"LastGameplayTrustedSample",
		"LastValidatedSample",
		"LastValidatedGroundedSample",
		"LastConfirmedGroundSample",
		"CandidateGroundedSample",
	}

	local function MatchesClientBaseline(stateTable, cycle)
		return type(stateTable) == "table"
			and rawget(stateTable, "Player") == LocalPlayer
			and rawget(stateTable, "Character") == cycle.Character
			and rawget(stateTable, "RootPart") == cycle.Root
			and (
				rawget(stateTable, "Humanoid") == cycle.Humanoid
				or (cycle.OriginalHumanoid ~= nil and rawget(stateTable, "Humanoid") == cycle.OriginalHumanoid)
			)
			and type(rawget(stateTable, "SampleHistory")) == "table"
			and type(rawget(stateTable, "Evidence")) == "table"
	end

	local function FindClientBaseline(cycle)
		local foundState = nil
		local function searchUpvalueTree(nodeVal, depthLevel, visitedTables)
			if foundState or type(nodeVal) ~= "table" or depthLevel > 3 or visitedTables[nodeVal] then
				return
			end
			visitedTables[nodeVal] = true
			if MatchesClientBaseline(nodeVal, cycle) then
				foundState = nodeVal
				return
			end
			local scannedCount = 0
			for _, childVal in pairs(nodeVal) do
				scannedCount = scannedCount + 1
				if scannedCount > 128 then
					break
				end
				if type(childVal) == "table" then
					searchUpvalueTree(childVal, depthLevel + 1, visitedTables)
				end
			end
		end

		if type(getcallbackvalue) == "function"
			and type(debug) == "table"
			and type(debug.getupvalue) == "function"
			and type(debug.getinfo) == "function"
		then
			pcall(function()
				local packagesFolder = ReplicatedStorage:FindFirstChild("Packages")
				local signalModuleInst = packagesFolder and packagesFolder:FindFirstChild("Signal")
				local signalLib = signalModuleInst and require(signalModuleInst)
				local invokedBindable = signalLib and signalLib.Invoked("ClientCharacter: GetDebugSnapshot")
				local invokeCallback = invokedBindable and getcallbackvalue(invokedBindable, "OnInvoke")
				if type(invokeCallback) ~= "function" then
					return
				end
				for upvalIdx = 1, debug.getinfo(invokeCallback).nups or 0 do
					searchUpvalueTree(debug.getupvalue(invokeCallback, upvalIdx), 0, {})
					if foundState then
						break
					end
				end
			end)
		end

		if not foundState and type(getgc) == "function" then
			local callOk, gcValues = pcall(getgc, true)
			if callOk and type(gcValues) == "table" then
				for _, gcEntry in ipairs(gcValues) do
					if MatchesClientBaseline(gcEntry, cycle) then
						foundState = gcEntry
						break
					end
				end
			end
		end
		return foundState
	end

	local function UpdateClientBaseline(cycle, travelVelocity)
		local baselineState = baselineSearch.Found
		if not MatchesClientBaseline(baselineState, cycle) then
			if not baselineSearch.Busy and os.clock() >= baselineSearch.NextAt then
				baselineSearch.Busy = true
				task.spawn(function()
					task.wait()
					local callOk, foundState = pcall(FindClientBaseline, cycle)
					if IsCycleCurrent(cycle) then
						baselineSearch.Found = callOk and foundState or nil
						Engine.RecordAutoTrace(
							foundState and "movement-baseline-ready" or "movement-baseline-not-found",
							cycle.Target.Uid
						)
						baselineSearch.Misses = foundState and 0 or (baselineSearch.Misses + 1)
						baselineSearch.NextAt = os.clock() + (foundState and 0.2 or (baselineSearch.Misses >= 5 and 10 or 1))
					end
					baselineSearch.Busy = false
				end)
			end
			return
		end

		local allowedSpeed = math.clamp(Engine.AutoSpeed() * 1.35, 200, 1350)
		local currentCFrame = cycle.Root.CFrame
		local function stampSample(sampleEntry)
			if type(sampleEntry) ~= "table" then
				return
			end
			rawset(sampleEntry, "WalkSpeed", allowedSpeed)
			rawset(sampleEntry, "CFrame", currentCFrame)
			rawset(sampleEntry, "Position", currentCFrame.Position)
			rawset(sampleEntry, "LinearVelocity", travelVelocity or Vector3.zero)
			rawset(sampleEntry, "AngularVelocity", Vector3.zero)
		end

		for _, sampleKey in ipairs(baselineSampleKeys) do
			stampSample(rawget(baselineState, sampleKey))
		end
		for _, sampleEntry in pairs(rawget(baselineState, "SampleHistory") or {}) do
			stampSample(sampleEntry)
		end
		for _, sampleEntry in pairs(rawget(baselineState, "SafeGroundCheckpoints") or {}) do
			stampSample(sampleEntry)
		end

		local evidenceTable = rawget(baselineState, "Evidence")
		if type(evidenceTable) == "table" then
			evidenceTable.Speed = 0
			evidenceTable.Teleport = 0
			evidenceTable.Flight = 0
		end

		local impulseCtx = rawget(baselineState, "ImpulseContext")
		if type(impulseCtx) == "table" then
			impulseCtx.MaxHorizontalSpeed = math.max(tonumber(impulseCtx.MaxHorizontalSpeed) or 0, allowedSpeed)
			impulseCtx.OriginPosition = currentCFrame.Position
			local impulseSpan = math.max((tonumber(impulseCtx.ExpiresAt) or 0) - (tonumber(impulseCtx.StartedAt) or 0), 0.15)
			impulseCtx.MaxHorizontalDistance = math.max(
				tonumber(impulseCtx.MaxHorizontalDistance) or 0,
				impulseCtx.MaxHorizontalSpeed * impulseSpan + 48
			)
			stampSample(impulseCtx.PreMovementSafeSample)
		end

		if rawget(baselineState, "CorrectionContext") == nil then
			rawset(baselineState, "FirstSuspiciousAt", nil)
			if rawget(baselineState, "ThreatLevel") == "Observing" then
				rawset(baselineState, "ThreatLevel", "Trusted")
			end
		end
	end

	local function StartCycleProtection(cycle)
		if GuardChasePolicyModule and type(GuardChasePolicyModule.ResolveHitDistance) == "function" then
			local originalResolver = GuardChasePolicyModule.ResolveHitDistance
			cycle.GuardPolicy = GuardChasePolicyModule
			cycle.SavedGuardDistance = originalResolver
			cycle.GuardDistanceHook = function(...)
				if IsCycleCurrent(cycle) and Engine.Guard.Enabled then
					return -math.huge
				end
				return originalResolver(...)
			end
			GuardChasePolicyModule.ResolveHitDistance = cycle.GuardDistanceHook
		end
		cycle.SavedKillIgnore = cycle.Root:GetAttribute("KillPartIgnore")
		cycle.Root:SetAttribute("KillPartIgnore", true)
		cycle.Protection = RunService.PreSimulation:Connect(function()
			if not IsCycleCurrent(cycle) or Engine.Guard.Busy then
				return
			end
			if cycle.ArrivalHold then
				SyncHoverPad(cycle, cycle.ArrivalHold.Position)
				cycle.Root.CFrame = cycle.ArrivalHold
				cycle.Root.AssemblyLinearVelocity = Vector3.zero
				cycle.Root.AssemblyAngularVelocity = Vector3.zero
			elseif cycle.UseHoverPad then
				SyncHoverPad(cycle, cycle.Root.Position)
			end
			UpdateClientBaseline(cycle, cycle.TravelVelocity)
		end)
	end

	local function StopCycleMotion(cycle)
		cycle.ArrivalHold = nil
		cycle.TravelVelocity = nil
		cycle.UseHoverPad = false
		if cycle.Root.Parent then
			cycle.Root.AssemblyLinearVelocity = Vector3.zero
			cycle.Root.AssemblyAngularVelocity = Vector3.zero
		end
		if cycle.Humanoid.Parent then
			pcall(cycle.Humanoid.MoveTo, cycle.Humanoid, cycle.Root.Position)
			pcall(cycle.Humanoid.Move, cycle.Humanoid, Vector3.zero, false)
		end
	end

	local function CleanupCycle(cycle)
		if cycle.GuardPolicy and cycle.GuardPolicy.ResolveHitDistance == cycle.GuardDistanceHook then
			cycle.GuardPolicy.ResolveHitDistance = cycle.SavedGuardDistance
		end
		if cycle.Protection then
			cycle.Protection:Disconnect()
			cycle.Protection = nil
		end
		if Engine.AutoCycle == cycle then
			StopCycleMotion(cycle)
			Engine.StopVelocity()
			cycle.Root:SetAttribute("KillPartIgnore", cycle.SavedKillIgnore)
			if cycle.Humanoid.Parent then
				cycle.Humanoid.AutoRotate = cycle.SavedAutoRotate
			end
			if cycle.SavedCamera and Workspace.CurrentCamera == cycle.SavedCamera.Camera and not Engine.IsSafeZoneVisual() then
				cycle.SavedCamera.Camera.CameraType = cycle.SavedCamera.Type
			end
		end
		if cycle.HoverPad then
			cycle.HoverPad:Destroy()
			cycle.HoverPad = nil
		end
	end

	local function WaitForGuardClear(cycle)
		while IsCycleCurrent(cycle) and Engine.Guard.Busy do
			RunService.Heartbeat:Wait()
		end
		return IsCycleCurrent(cycle)
	end

	local function ApproachEgg(cycle, eggRecord)
		local bottomCF = eggRecord and (eggRecord.BottomCFrame or eggRecord.BoundsCFrame)
		if typeof(bottomCF) ~= "CFrame" or not WaitForGuardClear(cycle) or not IsWallOpen() then
			return false
		end
		cycle.ArrivalHold = nil
		cycle.UseHoverPad = false
		if cycle.HoverPad then
			cycle.HoverPad:Destroy()
			cycle.HoverPad = nil
		end
		SetCycleStatus(cycle, "Heading to target egg")
		if Engine.InsideBase() and not Engine.InsideBase(bottomCF.Position) then
			local gatePos = GetTrackStartPosition()
			cycle.Character:PivotTo(CFrame.new(gatePos) * cycle.Root.CFrame.Rotation)
			Engine.StopVelocity()
		end
		cycle.ApproachActive = true
		local approachTimeout = math.clamp(
			(cycle.Root.Position - bottomCF.Position).Magnitude
				/ math.max(math.min(Engine.Pace(), Engine.AutoSpeed()), 16)
				* 2 + 8,
			30,
			120
		)
		local arrived = Engine.FlyToPosition(
			bottomCF.Position,
			cycle.Session,
			Engine.Carry.ApproachStop,
			approachTimeout,
			Engine.AutoSpeed()
		)
		cycle.ApproachActive = false
		if not IsCycleCurrent(cycle) or not arrived then
			return false
		end
		Engine.StopVelocity()
		local standDestination = GetEggDestination(cycle, ReadEgg(eggRecord.Uid) or eggRecord)
		if not standDestination then
			return false
		end
		cycle.ArrivalHold = standDestination
		cycle.UseHoverPad = true
		SyncHoverPad(cycle, standDestination.Position)
		cycle.Root.CFrame = standDestination
		Engine.RecordAutoTrace("egg-arrival", eggRecord.Uid)
		return true
	end

	local function Glide(cycle, destinationCF, shouldAbort)
		if not IsCycleCurrent(cycle) then
			return false
		end
		cycle.ArrivalHold = nil
		cycle.UseHoverPad = true
		cycle.Humanoid.AutoRotate = false
		local glideDeadline = os.clock()
			+ math.clamp((destinationCF.Position - cycle.Root.Position).Magnitude / 5000 * 1.6 + 6, 15, 120)

		while IsCycleCurrent(cycle) and os.clock() < glideDeadline do
			if shouldAbort and shouldAbort() then
				return false
			end
			if not WaitForGuardClear(cycle) then
				return false
			end
			local currentPos = cycle.Root.Position
			local deltaVec = destinationCF.Position - currentPos
			if deltaVec.Magnitude <= 1 then
				cycle.Root.CFrame = destinationCF
				cycle.Root.AssemblyLinearVelocity = Vector3.zero
				cycle.Root.AssemblyAngularVelocity = Vector3.zero
				SyncHoverPad(cycle, destinationCF.Position)
				cycle.TravelVelocity = Vector3.zero
				UpdateClientBaseline(cycle, Vector3.zero)
				return true
			end

			local rawDt = RunService.Heartbeat:Wait()
			local deltaTime = math.clamp(tonumber(rawDt) or (1 / 60), 1 / 240, 0.15)
			if not IsCycleCurrent(cycle) then
				return false
			end
			if Engine.Guard.Busy then
				continue
			end

			local nextPosition = currentPos + deltaVec.Unit * math.min(5000 * deltaTime, deltaVec.Magnitude)
			if deltaTime >= 1 / 30 then
				local groundY = ProbeGroundY(cycle, nextPosition.X, nextPosition.Z)
				if groundY then
					nextPosition = Vector3.new(
						nextPosition.X,
						math.max(nextPosition.Y, groundY + GetFeetOffset(cycle)),
						nextPosition.Z
					)
				end
			end
			cycle.Root.CFrame = CFrame.lookAt(nextPosition, nextPosition + deltaVec.Unit)
			cycle.Root.AssemblyLinearVelocity = Vector3.zero
			cycle.Root.AssemblyAngularVelocity = Vector3.zero
			SyncHoverPad(cycle, nextPosition)
			cycle.TravelVelocity = Vector3.zero
			UpdateClientBaseline(cycle, Vector3.zero)
		end
		return false
	end

	-- Natural Humanoid:MoveTo across the final Safe Zone deposit boundary (never teleport/velocity-hack across deposit)
	local function WalkToSafe(cycle, shouldAbort)
		if not IsCycleCurrent(cycle) then
			return false
		end
		cycle.ArrivalHold = nil
		cycle.UseHoverPad = true
		cycle.Humanoid.AutoRotate = true

		local destinationPos = GetSafeDestination(cycle).Position
		local totalDelta = destinationPos - cycle.Root.Position
		local walkDeadline = os.clock()
			+ math.clamp(
				Vector2.new(totalDelta.X, totalDelta.Z).Magnitude / math.max(cycle.Humanoid.WalkSpeed, 1) * 2 + 8,
				12,
				90
			)
		local lastSpeed, lastSampleClock = nil, nil

		while IsCycleCurrent(cycle) and os.clock() < walkDeadline do
			if shouldAbort and shouldAbort() then
				break
			end
			if not WaitForGuardClear(cycle) then
				return false
			end
			local currentPos = cycle.Root.Position
			local currentVel = cycle.Root.AssemblyLinearVelocity
			local flatOffset = Vector3.new(destinationPos.X - currentPos.X, 0, destinationPos.Z - currentPos.Z)
			local remainDist = flatOffset.Magnitude
			local horizontalSpeed = Vector2.new(currentVel.X, currentVel.Z).Magnitude

			if remainDist <= 4 and horizontalSpeed <= 20 then
				cycle.Humanoid:MoveTo(currentPos)
				cycle.Humanoid:Move(Vector3.zero, false)
				Engine.StopVelocity()
				return true
			end

			local towardSpeed = remainDist > 0.001
				and math.max(currentVel.X * flatOffset.X + currentVel.Z * flatOffset.Z, 0) / remainDist
				or horizontalSpeed
			local nowClock = os.clock()
			local moveGoal = currentPos
			local brakeDistance = towardSpeed * towardSpeed / (2 * (cycle.BrakeDecel or 420)) + towardSpeed * 0.06

			if remainDist <= brakeDistance then
				if lastSpeed and lastSampleClock < nowClock and horizontalSpeed > 20 then
					local measuredDecel = (lastSpeed - horizontalSpeed) / (nowClock - lastSampleClock)
					if measuredDecel > 20 and measuredDecel < 5000 then
						cycle.BrakeDecel = (cycle.BrakeDecel or 420) * 0.8 + measuredDecel * 0.93 * 0.2
					end
				end
				lastSpeed, lastSampleClock = horizontalSpeed, nowClock
			else
				lastSpeed = nil
				local strideLength = math.max(cycle.Humanoid.WalkSpeed * 0.5, 12)
				moveGoal = remainDist <= strideLength
					and Vector3.new(destinationPos.X, currentPos.Y, destinationPos.Z)
					or (currentPos + flatOffset.Unit * strideLength)
			end

			cycle.Humanoid:MoveTo(moveGoal)
			RunService.Heartbeat:Wait()
		end

		if IsCycleCurrent(cycle) then
			cycle.Humanoid:MoveTo(cycle.Root.Position)
			cycle.Humanoid:Move(Vector3.zero, false)
			Engine.StopVelocity()
		end
		return false
	end

	local function StartCarryRequest(cycle, eggUid, includeSlotKey)
		if cycle.CarryRequest or not Remotes.CarryEgg then
			return
		end
		local carryAttempt = {}
		cycle.CarryRequest = carryAttempt
		task.spawn(function()
			if not IsCycleCurrent(cycle) then
				return
			end
			local callOk, accepted, rejection = pcall(function()
				local payload = { Uid = eggUid }
				if includeSlotKey
					and SlotIdentityModule
					and type(SlotIdentityModule.LooksLikeFirstAreaUid) == "function"
					and SlotIdentityModule.LooksLikeFirstAreaUid(eggUid)
				then
					local sourceRecord = ReadEgg(eggUid) or cycle.Target.Raw or cycle.Target
					if type(SlotIdentityModule.SlotKey) == "function" and type(sourceRecord) == "table" then
						payload.FirstAreaSlotKey = SlotIdentityModule.SlotKey(sourceRecord.AreaId, sourceRecord.NestId)
					end
				end
				return Remotes.CarryEgg:InvokeServer(payload)
			end)
			if IsCycleCurrent(cycle) and cycle.CarryRequest == carryAttempt then
				cycle.CarryRequest = nil
				local isAccepted = callOk and (accepted == true or (type(accepted) == "table" and accepted.Ok ~= false and accepted.Success ~= false))
				if not isAccepted then
					local rejectReason = (type(accepted) == "table" and (accepted.Reason or accepted.Error))
						or (not callOk and accepted)
						or rejection
						or "Carry refused"
					cycle.LastCarryReject = tostring(rejectReason)
				else
					cycle.LastCarryReject = nil
				end
			end
		end)
	end

	local function GetCarryTimeoutSeconds(eggRecord)
		local areaLower = string.lower(tostring(eggRecord.AreaId or ""))
		local settleSec, minSec = 8, 3.5
		if areaLower:find("enchanted") then
			settleSec, minSec = 18, 12
		elseif areaLower:find("light") or areaLower:find("dark") then
			settleSec, minSec = 16, 10
		elseif areaLower:find("titan") then
			settleSec, minSec = 10, 8
		end
		return math.max(5, math.max(settleSec, minSec) + 3)
	end

	local function RequestTargetCarry(cycle, eggRecord)
		if not IsCycleCurrent(cycle) then
			return false
		end
		local eggUid = eggRecord.Uid
		local carryDeadline = nil
		pcall(cycle.Humanoid.UnequipTools, cycle.Humanoid)

		while IsCycleCurrent(cycle) do
			if IsCarriedByMe(eggUid) then
				carryTimeouts[eggUid], retryUid = nil, nil
				cycle.ArrivalHold = nil
				Engine.RecordAutoTrace("carry-record-confirmed", eggUid)
				return true
			end
			if carryDeadline and os.clock() >= carryDeadline then
				local failureCount = (carryTimeouts[eggUid] or 0) + 1
				if failureCount >= 2 then
					carryTimeouts[eggUid], retryUid, skippedEggs[eggUid] = nil, nil, os.clock() + 45
				else
					carryTimeouts[eggUid], retryUid = failureCount, eggUid
				end
				SetCycleStatus(
					cycle,
					cycle.LastCarryReject and ("Carry refused: " .. cycle.LastCarryReject) or "Carry timeout - retrying"
				)
				cycle.ArrivalHold = nil
				Glide(cycle, GetSafeDestination(cycle))
				return false
			end
			if not IsWallOpen() then
				SetCycleStatus(cycle, "Wall closed before carry")
				return false
			end
			local liveRecord = ReadEgg(eggUid)
			if not IsEggAvailable(liveRecord) then
				SetCycleStatus(cycle, "Target no longer available")
				return false
			end
			local standDestination = GetEggDestination(cycle, liveRecord)
			if not standDestination then
				return false
			end
			if (cycle.Root.Position - standDestination.Position).Magnitude > 10 then
				cycle.ArrivalHold = nil
				if not ApproachEgg(cycle, liveRecord) then
					return false
				end
			end
			if not WaitForGuardClear(cycle) then
				return false
			end
			if not cycle.CarryRequest then
				cycle.Root.AssemblyLinearVelocity = Vector3.zero
				cycle.Root.AssemblyAngularVelocity = Vector3.zero
				local pingMs = 0
				pcall(function()
					local netStats = StatsService.Network
					local pingItem = (netStats.ServerStats and netStats.ServerStats.Ping)
						or (netStats.ServerStatsItem and netStats.ServerStatsItem["Data Ping"])
					if pingItem then
						pingMs = pingItem:GetValue()
					end
				end)
				task.wait(math.max(0.3, (tonumber(pingMs) or 0) * 2.5 / 1000))
				if not IsCycleCurrent(cycle) then
					return false
				end
				StartCarryRequest(cycle, eggUid, true)
				carryDeadline = carryDeadline or (os.clock() + GetCarryTimeoutSeconds(eggRecord))
			end
			SetCycleStatus(
				cycle,
				cycle.LastCarryReject and ("Waiting for carry - " .. cycle.LastCarryReject) or "Waiting for carry confirmation"
			)
			task.wait(0.25)
		end
		return false
	end

	local function RegrabBurst(cycle, eggUid, burstDuration)
		local burstDeadline = os.clock() + burstDuration
		cycle.ArrivalHold = nil

		while IsCycleCurrent(cycle) and os.clock() < burstDeadline do
			if IsCarriedByMe(eggUid) then
				return true
			end
			local liveRecord = ReadEgg(eggUid)
			if not IsEggAvailable(liveRecord) or not WaitForGuardClear(cycle) then
				return false
			end
			if RagdollJointsModule and type(RagdollJointsModule.Release) == "function" then
				pcall(RagdollJointsModule.Release, cycle.Character)
			end
			cycle.Humanoid.PlatformStand = false
			cycle.Humanoid.Sit = false
			if cycle.Humanoid:GetState() ~= Enum.HumanoidStateType.Running then
				pcall(cycle.Humanoid.ChangeState, cycle.Humanoid, Enum.HumanoidStateType.GettingUp)
			end

			local standDestination = GetEggDestination(cycle, liveRecord)
			if not standDestination then
				return false
			end
			cycle.Root.CFrame = standDestination
			cycle.Root.AssemblyLinearVelocity = Vector3.zero
			cycle.Root.AssemblyAngularVelocity = Vector3.zero
			SyncHoverPad(cycle, standDestination.Position)

			StartCarryRequest(cycle, eggUid, false)
			if not cycle.NativeCarryBusy and EggStateModule and type(EggStateModule.CarryFieldEgg) == "function" then
				cycle.NativeCarryBusy = true
				task.spawn(function()
					if IsCycleCurrent(cycle) then
						pcall(EggStateModule.CarryFieldEgg, eggUid)
					end
					cycle.NativeCarryBusy = false
				end)
			end

			local slotsFolder = Workspace:FindFirstChild("AreaEggSlotsClient")
			local slotModel = slotsFolder and slotsFolder:FindFirstChild(tostring(eggUid))
			local promptInst = slotModel and (
				slotModel:FindFirstChild("CarryAreaEgg", true)
				or slotModel:FindFirstChildWhichIsA("ProximityPrompt", true)
			)
			if promptInst and promptInst.Enabled then
				Engine.FirePrompt(promptInst)
			end
			task.wait(0.06)
		end
		return IsCycleCurrent(cycle) and IsCarriedByMe(eggUid)
	end

	local function InvokeTreadmillRemote(cycle, remoteObj)
		if not remoteObj or not IsCycleCurrent(cycle) or cycle.TreadmillBusy then
			return nil
		end
		cycle.TreadmillBusy = true
		local invokeDone, invokeResult = false, nil
		task.spawn(function()
			if not IsCycleCurrent(cycle) then
				cycle.TreadmillBusy = false
				invokeDone = true
				return
			end
			local callOk, response = pcall(function()
				return remoteObj:InvokeServer()
			end)
			if callOk then
				invokeResult = response
			end
			cycle.TreadmillBusy = false
			invokeDone = true
		end)
		local waitDeadline = os.clock() + 2
		while IsCycleCurrent(cycle) and not invokeDone and os.clock() < waitDeadline do
			task.wait(0.02)
		end
		return IsCycleCurrent(cycle) and invokeDone and invokeResult or nil
	end

	local CARRY_LEG_AREAS = {
		["Enchanted Forest"] = true,
		["Light Dark"] = true,
		["Titan Temple"] = true,
	}
	local CARRY_STOP_DISTANCE = 36
	local CARRY_SNAP_DISTANCE = 6
	local CARRY_FRAME_CAP = 250
	local CARRY_Z_EASE = 0.03

	local function CarryLegCount(cycle)
		local areaId = cycle.Target and cycle.Target.AreaId
		if areaId and CARRY_LEG_AREAS[areaId] then
			return 4
		end
		local worldFolder = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
		local areasFolder = worldFolder and worldFolder:FindFirstChild("Areas")
		local guardAreas = areasFolder and areasFolder:FindFirstChild("GuardAreas")
		local guardArea = areaId and guardAreas and guardAreas:FindFirstChild(areaId)
		local escapeSpeeds = guardArea and guardArea:GetAttribute("GuardEscapeSpeeds")
		if typeof(escapeSpeeds) == "Vector2" then
			local walkSpeed = tonumber(cycle.Humanoid.WalkSpeed) or 16
			if walkSpeed * 0.9 < escapeSpeeds.Y * 1.05 then
				return 2
			end
		end
		return 1
	end

	local function CarrySetCFrame(cycle, targetCF)
		cycle.Root.CFrame = targetCF
		cycle.Root.AssemblyLinearVelocity = Vector3.zero
		cycle.Root.AssemblyAngularVelocity = Vector3.zero
		cycle.TravelVelocity = Vector3.zero
		UpdateClientBaseline(cycle, Vector3.zero)
	end

	local CARRY_REGRAB_TRIES = 3

	local function RequestCarry(cycle, eggUid)
		if not EggStateModule or type(EggStateModule.CarryFieldEgg) ~= "function" then
			return
		end
		task.spawn(function()
			if IsCycleCurrent(cycle) then
				pcall(EggStateModule.CarryFieldEgg, eggUid)
			end
		end)
	end

	local function WaitRegrabbed(cycle, eggUid, seconds)
		local grabDeadline = os.clock() + (seconds or 1.5)
		local tries = 0
		while IsCycleCurrent(cycle) and os.clock() < grabDeadline do
			if IsCarriedByMe(eggUid) then
				return true
			end
			if tries < CARRY_REGRAB_TRIES then
				tries += 1
				RequestCarry(cycle, eggUid)
			end
			task.wait(0.03)
		end
		return IsCarriedByMe(eggUid)
	end

	local function SnapToDroppedEgg(cycle, eggUid)
		local eggRecord = ReadEgg(eggUid)
		local bottomCF = eggRecord and (eggRecord.BottomCFrame or eggRecord.BoundsCFrame)
		if not bottomCF then
			return false
		end
		if (bottomCF.Position - cycle.Root.Position).Magnitude <= CARRY_SNAP_DISTANCE then
			return true
		end
		CarrySetCFrame(cycle, CFrame.new(bottomCF.Position + Vector3.new(0, 3, 0)) * CARRY_ROTATION)
		return true
	end

	local function DropAndRegrab(cycle, eggUid)
		if not IsCycleCurrent(cycle) or not IsCarriedByMe(eggUid) then
			return false
		end
		if EggStateModule and type(EggStateModule.DropFieldEgg) == "function" then
			pcall(EggStateModule.DropFieldEgg, "PlayerRequest")
		end

		local snapped, tries = false, 0
		local grabDeadline = os.clock() + 2
		while IsCycleCurrent(cycle) and os.clock() < grabDeadline do
			if IsCarriedByMe(eggUid) then
				return true
			end
			local eggRecord = ReadEgg(eggUid)
			if not snapped and eggRecord and eggRecord.State == eggStates.Dropped then
				snapped = true
				SnapToDroppedEgg(cycle, eggUid)
			end
			if tries < CARRY_REGRAB_TRIES then
				tries += 1
				RequestCarry(cycle, eggUid)
			end
			task.wait(0.03)
		end
		return IsCarriedByMe(eggUid)
	end

	local CARRY_DROP_LIMIT = 4

	local function CarryHome(cycle, eggUid, dropTargetCF, dropPerLeg)
		local startPos = cycle.Root.Position
		local targetPos = dropTargetCF.Position
		local legCount = CarryLegCount(cycle)
		local legPositionsX = {}
		for index = 1, legCount - 1 do
			legPositionsX[index] = startPos.X - ((startPos.X - targetPos.X) * index / legCount)
		end

		local carrySpeed = math.clamp(tonumber(FarmConfig.FastTweenSpeed) or 3300, 800, 8000)
		local carryY = math.max(startPos.Y, targetPos.Y)
		local legIndex = 1
		local carryDeadline = os.clock() + 60

		cycle.ArrivalHold = nil
		cycle.UseHoverPad = false
		if cycle.HoverPad then
			cycle.HoverPad:Destroy()
			cycle.HoverPad = nil
		end
		cycle.Humanoid.AutoRotate = false

		while IsCycleCurrent(cycle) and os.clock() < carryDeadline do
			if not IsCarriedByMe(eggUid) then
				return false
			end
			if not WaitForGuardClear(cycle) then
				return false
			end
			local currentPos = cycle.Root.Position

			if legPositionsX[legIndex] and currentPos.X <= legPositionsX[legIndex] then
				legIndex += 1
				if dropPerLeg and (cycle.CarryDrops or 0) < CARRY_DROP_LIMIT then
					cycle.CarryDrops = (cycle.CarryDrops or 0) + 1
					CarrySetCFrame(cycle, CFrame.new(currentPos.X, carryY, currentPos.Z) * CARRY_ROTATION)
					task.wait(0.1)
					if not DropAndRegrab(cycle, eggUid) then
						return false
					end
				end
				continue
			end

			if currentPos.X - targetPos.X <= CARRY_STOP_DISTANCE then
				CarrySetCFrame(cycle, CFrame.new(targetPos.X, targetPos.Y, targetPos.Z) * CARRY_ROTATION)
				return true
			end

			local rawDt = RunService.Heartbeat:Wait()
			local deltaTime = math.clamp(tonumber(rawDt) or (1 / 60), 1 / 240, 0.15)
			if not IsCycleCurrent(cycle) then
				return false
			end
			if Engine.Guard.Busy then
				continue
			end

			local stepX = math.min(carrySpeed * deltaTime, CARRY_FRAME_CAP, currentPos.X - targetPos.X)
			local nextZ = currentPos.Z + ((targetPos.Z - currentPos.Z) * CARRY_Z_EASE)
			CarrySetCFrame(cycle, CFrame.new(currentPos.X - stepX, carryY, nextZ) * CARRY_ROTATION)
		end

		return false
	end

	local function DeliverSenaEgg(cycle, eggUid)
		cycle.ArrivalHold = nil
		local carryWaitDeadline = os.clock() + 2.5
		while IsCycleCurrent(cycle) and not IsCarriedByMe(eggUid) and not IsBankRecordGone(eggUid) and os.clock() < carryWaitDeadline do
			task.wait(0.1)
		end
		if not IsCycleCurrent(cycle) then
			return false
		end

		if IsCarriedByMe(eggUid) then
			SetCycleStatus(cycle, "Bringing egg home")
			cycle.DeliveryDropUid = eggUid
			local dropTarget = GetDropPoint(cycle)
			if (cycle.Root.Position - dropTarget.Position).Magnitude > CARRY_STOP_DISTANCE then
				local variant = FarmConfig.CarryVariant
				if variant == CarryVariants.ChiliLegs then
					CarryHome(cycle, eggUid, dropTarget, true)
				elseif variant == CarryVariants.ChiliSingle then
					CarryHome(cycle, eggUid, dropTarget, false)
				else
					Glide(cycle, dropTarget, function()
						return not IsCarriedByMe(eggUid)
					end)
				end
				if not IsCycleCurrent(cycle) then
					return false
				end
			end

			local dropConfirmed = false
			for _ = 1, 2 do
				if not IsCycleCurrent(cycle) or not IsCarriedByMe(eggUid) then
					break
				end
				if IsCarriedByMe(eggUid) then
					CarrySetCFrame(cycle, dropTarget)
					task.wait(0.15)
					if not IsCycleCurrent(cycle) then
						return false
					end
					if IsCarriedByMe(eggUid) and EggStateModule and type(EggStateModule.DropFieldEgg) == "function" then
						Engine.RecordAutoTrace("delivery-drop-request", eggUid)
						pcall(EggStateModule.DropFieldEgg, "PlayerRequest")
					end
					local dropWaitUntil = os.clock() + 0.45
					while IsCycleCurrent(cycle) and IsCarriedByMe(eggUid) and os.clock() < dropWaitUntil do
						RunService.Heartbeat:Wait()
					end
				end
				local afterDropRecord = ReadEgg(eggUid)
				if afterDropRecord and afterDropRecord.State == eggStates.Dropped then
					dropConfirmed = true
					retryUid = eggUid
					break
				end
				if not IsCarriedByMe(eggUid) then
					break
				end
			end

			if not IsCycleCurrent(cycle) then
				return false
			end
			if not dropConfirmed then
				cycle.DeliveryDropUid = nil
				SetCycleStatus(cycle, "Drop failed - retrying")
				return false
			end

			local droppedPosition = nil
			local posWaitDeadline = os.clock() + 3
			while IsCycleCurrent(cycle) and os.clock() < posWaitDeadline do
				local liveRecord = ReadEgg(eggUid)
				if liveRecord and liveRecord.State == eggStates.Dropped then
					local bottomCF = liveRecord.BottomCFrame or liveRecord.BoundsCFrame
					droppedPosition = bottomCF and bottomCF.Position
					if droppedPosition then
						break
					end
				elseif liveRecord and liveRecord.State ~= eggStates.Carried then
					break
				end
				task.wait(0.1)
			end
			cycle.DeliveryDropUid = nil
			if not IsCycleCurrent(cycle) then
				return false
			end

			local regrabDestination = droppedPosition and CFrame.new(droppedPosition + Vector3.new(0, 3, 0)) * CARRY_ROTATION
				or dropTarget
			CarrySetCFrame(cycle, regrabDestination)
			if not IsCycleCurrent(cycle) then
				return false
			end

			local regrabbedOk = WaitRegrabbed(cycle, eggUid, 2)
			if not regrabbedOk and not IsCarriedByMe(eggUid) and IsCycleCurrent(cycle) then
				SnapToDroppedEgg(cycle, eggUid)
				regrabbedOk = RegrabBurst(cycle, eggUid, 0.6)
			end

			if not regrabbedOk and not IsCarriedByMe(eggUid) then
				SetCycleStatus(cycle, "Re-grab failed - retrying")
				return IsBankRecordGone(eggUid) and IsInSafeArea(cycle)
			end
		end

		if not IsCycleCurrent(cycle) then
			return false
		end
		if IsCarriedByMe(eggUid) then
			SetCycleStatus(cycle, "Walking egg into safe area")
			WalkToSafe(cycle, function()
				return not IsCarriedByMe(eggUid)
			end)
		end

		SetCycleStatus(cycle, "Waiting for deposit")
		local depositDeadline = os.clock() + 8
		while IsCycleCurrent(cycle) and not IsBankRecordGone(eggUid) and os.clock() < depositDeadline do
			if not IsInSafeArea(cycle) then
				WalkToSafe(cycle, function()
					return IsBankRecordGone(eggUid)
				end)
			end
			task.wait(0.1)
		end

		local isDeposited = IsCycleCurrent(cycle) and IsBankRecordGone(eggUid) and IsInSafeArea(cycle)
		SetCycleStatus(cycle, isDeposited and "Checking deposit" or "Bank not confirmed - retrying")
		return isDeposited
	end

	-- Walk Method: Carry egg back home on foot using the player's own live WalkSpeed (no glide/drop)
	local function DeliverWalkEgg(cycle, eggUid)
		cycle.ArrivalHold = nil
		cycle.UseHoverPad = false
		if cycle.HoverPad then
			cycle.HoverPad:Destroy()
			cycle.HoverPad = nil
		end

		local carryWaitDeadline = os.clock() + 2.5
		while IsCycleCurrent(cycle) and not IsCarriedByMe(eggUid) and not IsBankRecordGone(eggUid) and os.clock() < carryWaitDeadline do
			task.wait(0.1)
		end
		if not IsCycleCurrent(cycle) then
			return false
		end

		if IsCarriedByMe(eggUid) then
			SetCycleStatus(cycle, "Walking egg home")
			retryUid = eggUid
			cycle.Humanoid.AutoRotate = true
			cycle.Humanoid.PlatformStand = false
			cycle.Humanoid.Sit = false
			SyncHumanoidSwap()

			local safeGoalPos = GetSafeDestination(cycle).Position
			local bestRemainDist = (Vector3.new(safeGoalPos.X - cycle.Root.Position.X, 0, safeGoalPos.Z - cycle.Root.Position.Z)).Magnitude
			local stuckSinceClock = nil
			local lastSpeed, lastSampleClock = nil, nil
			cycle.ReturnDeadline = math.max(cycle.ReturnDeadline or 0, os.clock() + 60)

			while IsCycleCurrent(cycle) and IsCarriedByMe(eggUid) do
				-- Allow immediate live switching if user changes Steal Method to Fast Tween mid-walk
				if FarmConfig.StealMethod ~= "Walk" then
					cycle.Humanoid:MoveTo(cycle.Root.Position)
					cycle.Humanoid:Move(Vector3.zero, false)
					return DeliverSenaEgg(cycle, eggUid)
				end
				if not WaitForGuardClear(cycle) then
					return false
				end

				if RagdollJointsModule and type(RagdollJointsModule.Release) == "function" then
					pcall(RagdollJointsModule.Release, cycle.Character)
				end
				cycle.Humanoid.PlatformStand = false
				cycle.Humanoid.Sit = false
				SyncHumanoidSwap()

				safeGoalPos = GetSafeDestination(cycle).Position
				local currentPos = cycle.Root.Position
				local currentVel = cycle.Root.AssemblyLinearVelocity
				local flatToSafe = Vector3.new(safeGoalPos.X - currentPos.X, 0, safeGoalPos.Z - currentPos.Z)
				local remainDist = flatToSafe.Magnitude
				local horizontalSpeed = Vector2.new(currentVel.X, currentVel.Z).Magnitude
				local nowClock = os.clock()

				if remainDist < bestRemainDist - 1.5 then
					bestRemainDist = remainDist
					cycle.ReturnDeadline = math.max(cycle.ReturnDeadline or 0, nowClock + 45)
				end

				if remainDist <= 4 and horizontalSpeed <= 20 then
					cycle.Humanoid:MoveTo(currentPos)
					cycle.Humanoid:Move(Vector3.zero, false)
					Engine.StopVelocity()
					break
				end

				-- Steer inside the open track corridor while far out, then straight into Safe Zone
				local steerTarget = safeGoalPos
				if currentPos.X > 630 then
					local laneZ = math.clamp(currentPos.Z, -416.5, -320)
					steerTarget = Vector3.new(safeGoalPos.X, currentPos.Y, laneZ)
				end
				local steerFlat = Vector3.new(steerTarget.X - currentPos.X, 0, steerTarget.Z - currentPos.Z)
				local steerDist = steerFlat.Magnitude

				local towardSpeed = remainDist > 0.001
					and math.max(currentVel.X * flatToSafe.X + currentVel.Z * flatToSafe.Z, 0) / remainDist
					or horizontalSpeed
				local brakeDistance = towardSpeed * towardSpeed / (2 * (cycle.BrakeDecel or 420)) + towardSpeed * 0.06
				local moveGoal = currentPos

				if remainDist <= brakeDistance then
					if lastSpeed and lastSampleClock < nowClock and horizontalSpeed > 20 then
						local measuredDecel = (lastSpeed - horizontalSpeed) / (nowClock - lastSampleClock)
						if measuredDecel > 20 and measuredDecel < 5000 then
							cycle.BrakeDecel = (cycle.BrakeDecel or 420) * 0.8 + measuredDecel * 0.93 * 0.2
						end
					end
					lastSpeed, lastSampleClock = horizontalSpeed, nowClock
				else
					lastSpeed = nil
					local strideLength = math.max((tonumber(cycle.Humanoid.WalkSpeed) or 16) * 0.6, 14)
					moveGoal = steerDist <= strideLength
						and Vector3.new(steerTarget.X, currentPos.Y, steerTarget.Z)
						or (currentPos + steerFlat.Unit * strideLength)
				end

				if remainDist > 6 and horizontalSpeed < 1.5 then
					stuckSinceClock = stuckSinceClock or nowClock
					if (nowClock - stuckSinceClock) >= 0.5 then
						stuckSinceClock = nowClock
						pcall(function()
							cycle.Humanoid.Jump = true
						end)
					end
				else
					stuckSinceClock = nil
				end

				cycle.Humanoid:MoveTo(moveGoal)
				RunService.Heartbeat:Wait()
			end

			if IsCycleCurrent(cycle) then
				cycle.Humanoid:MoveTo(cycle.Root.Position)
				cycle.Humanoid:Move(Vector3.zero, false)
				Engine.StopVelocity()
			end
		end

		if not IsCycleCurrent(cycle) then
			return false
		end
		if not IsCarriedByMe(eggUid) and not IsBankRecordGone(eggUid) and not IsInSafeArea(cycle) then
			SetCycleStatus(cycle, "Egg dropped during walk - recovering")
			return false
		end

		SetCycleStatus(cycle, "Waiting for deposit")
		local depositDeadline = os.clock() + 8
		while IsCycleCurrent(cycle) and not IsBankRecordGone(eggUid) and os.clock() < depositDeadline do
			if not IsInSafeArea(cycle) then
				WalkToSafe(cycle, function()
					return IsBankRecordGone(eggUid)
				end)
			end
			task.wait(0.1)
		end

		local isDeposited = IsCycleCurrent(cycle) and IsBankRecordGone(eggUid) and IsInSafeArea(cycle)
		SetCycleStatus(cycle, isDeposited and "Checking deposit" or "Bank not confirmed - retrying")
		return isDeposited
	end

	local function RecoverDroppedCarry(cycle, eggUid)
		SetCycleStatus(cycle, "Re-stealing dropped egg")
		local recoverDeadline = os.clock() + 5
		local targetRecord = nil
		while IsCycleCurrent(cycle) and os.clock() < recoverDeadline do
			if IsCarriedByMe(eggUid) then
				return true
			end
			targetRecord = ReadEgg(eggUid)
			if IsEggAvailable(targetRecord) then
				break
			end
			task.wait(0.03)
		end
		if not IsCycleCurrent(cycle) or not IsEggAvailable(targetRecord) or not IsWallOpen() then
			return false
		end
		if RegrabBurst(cycle, eggUid, 3.5) then
			return true
		end
		if not IsCycleCurrent(cycle) then
			return false
		end
		if not ApproachEgg(cycle, targetRecord) then
			return false
		end
		return RequestTargetCarry(cycle, targetRecord)
	end

	local function ChooseTargetCandidate()
		local nowClock = os.clock()
		local captureEventUid = Workspace:GetAttribute("Event_CaptureTheEggUid")
		for skippedUid, expireAt in pairs(skippedEggs) do
			if expireAt <= nowClock then
				skippedEggs[skippedUid] = nil
			end
		end
		local candidates = Engine.CollectCandidates(false, true)
		for _, candidate in ipairs(candidates) do
			local liveRecord = ReadEgg(candidate.Uid) or candidate.Raw
			if IsEggAvailable(liveRecord) and candidate.Uid ~= captureEventUid and not skippedEggs[candidate.Uid] then
				if not retryUid or candidate.Uid == retryUid then
					return candidate
				end
			end
		end
		if retryUid then
			retryUid = nil
			for _, candidate in ipairs(candidates) do
				local liveRecord = ReadEgg(candidate.Uid) or candidate.Raw
				if IsEggAvailable(liveRecord) and candidate.Uid ~= captureEventUid and not skippedEggs[candidate.Uid] then
					return candidate
				end
			end
		end
		return nil
	end

	local function RunSenaCycle(cycle)
		if not IsCycleCurrent(cycle) then
			return false
		end

		local targetCandidate = cycle.Target
		local eggUid = targetCandidate.Uid
		Engine.CurrentTarget = eggUid
		Engine.AutoTargetText = tostring(targetCandidate.Category or targetCandidate.AssetCategory or "Egg")
			.. " - "
			.. tostring(targetCandidate.AreaId or "?")
		Engine.RecordAutoTrace("cycle-start", eggUid)
		StartCycleProtection(cycle)

		if cycle.Root.Anchored then
			SetCycleStatus(cycle, "Leaving treadmill")
			local unanchorDeadline = os.clock() + 8
			while IsCycleCurrent(cycle) and cycle.Root.Anchored and os.clock() < unanchorDeadline do
				InvokeTreadmillRemote(cycle, treadmillRemotes.Doff)
				task.wait(0.3)
				if os.clock() + 7 >= unanchorDeadline then
					cycle.Root.Anchored = false
				end
			end
		end
		if not IsCycleCurrent(cycle) then
			return
		end

		if not IsCarriedByMe(eggUid) then
			local targetRecord = ReadEgg(eggUid) or targetCandidate.Raw
			if not IsEggAvailable(targetRecord) or not ApproachEgg(cycle, targetRecord) or not RequestTargetCarry(cycle, targetRecord) then
				return
			end
		end

		-- Keep recovering and delivering THIS carried/dropped egg until confirmed in inventory
		local walkEstimate = (cycle.Root.Position - safePosition).Magnitude / math.max(tonumber(cycle.Humanoid.WalkSpeed) or 16, 8)
		cycle.ReturnDeadline = os.clock() + ((FarmConfig.StealMethod == "Walk") and math.max(90, walkEstimate * 2.5 + 45) or 60)
		while IsCycleCurrent(cycle) do
			local deliveredOk = (FarmConfig.StealMethod == "Walk")
				and DeliverWalkEgg(cycle, eggUid)
				or DeliverSenaEgg(cycle, eggUid)
			if deliveredOk then
				task.wait(1.5)
				if not IsCycleCurrent(cycle) then
					return
				end
				local verifyRecord = ReadEgg(eggUid)
				if IsEggAvailable(verifyRecord) or (verifyRecord and verifyRecord.State == eggStates.Carried) then
					SetCycleStatus(cycle, "Delivery failed - retrying")
					Engine.RecordAutoTrace("deposit-recheck-failed", eggUid)
					continue
				end
				retryUid = nil
				Engine.AutoCarry.LastFinishedAt = os.clock()
				Engine.AutoDeliverySerial = Engine.AutoDeliverySerial + 1
				Engine.AutoHandledDeliverySerial = Engine.AutoDeliverySerial
				Engine.RecordAutoTrace("deposit-recheck-complete", eggUid)
				SetCycleStatus(cycle, "Delivered")
				if Hub.Progression and Hub.Progression.Wake then
					Hub.Progression.Wake()
				end
				return
			end

			if not IsCycleCurrent(cycle) or not IsWallOpen() then
				return
			end
			if IsCarriedByMe(eggUid) then
				task.wait(0.35)
			elseif not RecoverDroppedCarry(cycle, eggUid) then
				return
			end
		end
	end

	local function SchedulerTick()
		if workerRunning then
			return
		end
		if not IsAutoStealEnabled() then
			Engine.ShieldHoldUntil = 0
			Engine.AutoStatus = "Idle"
			return
		end
		if Engine.IsInExternalMapOrEvent() then
			Engine.ShieldHoldUntil = 0
			Engine.StopSafeZoneVisual()
			Engine.ReleaseAutoShield(true)
			Engine.AutoStatus = "Paused (In Event / Other Map)"
			return
		end
		if RuntimeState.IsExecuting or Engine.Guard.Active or Engine.Guard.Busy or Engine.Movement.PlaceWanted then
			return
		end
		local rootPart = Engine.Root()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not rootPart or not humanoid or humanoid.Health <= 0 then
			return
		end

		local chosenTarget = nil
		-- Priority 1: Always deliver any egg currently carried by LocalPlayer before picking a new field egg
		for recordUid, eggRecord in pairs(liveRecords) do
			if eggRecord.State == eggStates.Carried
				and eggRecord.CarrierUserId == LocalPlayer.UserId
				and IsCarriedByMe(recordUid)
			then
				if recordUid == Workspace:GetAttribute("Event_CaptureTheEggUid") then
					Engine.AutoStatus = "Event egg held - normal steal waiting"
					return
				end
				chosenTarget = {
					Uid = recordUid,
					Raw = eggRecord,
					AreaId = eggRecord.AreaId,
					Category = eggRecord.AssetCategory,
				}
				break
			end
		end

		-- Fallback check via ReadLocalCarryUid if FieldShifted has not populated liveRecords yet
		if not chosenTarget and EggStateModule and type(EggStateModule.ReadLocalCarryUid) == "function" then
			local callOk, carriedUid = pcall(EggStateModule.ReadLocalCarryUid)
			if callOk and type(carriedUid) == "string" and carriedUid ~= "" and IsCarriedByMe(carriedUid) then
				if carriedUid == Workspace:GetAttribute("Event_CaptureTheEggUid") then
					Engine.AutoStatus = "Event egg held - normal steal waiting"
					return
				end
				local carriedRecord = ReadEgg(carriedUid)
				chosenTarget = {
					Uid = carriedUid,
					Raw = carriedRecord,
					AreaId = carriedRecord and carriedRecord.AreaId,
					Category = carriedRecord and carriedRecord.AssetCategory,
				}
			end
		end

		if not chosenTarget and not IsWallOpen() then
			Engine.ShieldHoldUntil = 0
			Engine.AutoStatus = "Waiting for reset wall"
			return
		end

		chosenTarget = chosenTarget or ChooseTargetCandidate()
		if not chosenTarget then
			Engine.ShieldHoldUntil = 0
			Engine.AutoStatus, Engine.AutoTargetText = "No matching eggs", "None"
			return
		end

		Engine.ShieldHoldUntil = os.clock() + 3
		if not Engine.AutoShieldReady() then
			pcall(Engine.MaintainAutoShield)
		end
		if not Engine.AutoShieldReady() then
			Engine.AutoStatus = "Waiting for Humanoid Swap"
			nextTickClock = os.clock() + 0.1
			wakePending = true
			return
		end
		humanoid = character:FindFirstChildOfClass("Humanoid") or humanoid

		if not Engine.ClaimMovement("steal") then
			Engine.AutoStatus = "Waiting for movement"
			return
		end
		Engine.StopVelocity()
		local activeCamera = Workspace.CurrentCamera
		local cycle = {
			Generation = cycleGeneration,
			Session = RuntimeState.SessionId,
			Cancel = RuntimeState.StealCancel,
			Character = character,
			Humanoid = humanoid,
			OriginalHumanoid = RuntimeState.OriginalHumanoid,
			Root = rootPart,
			Target = chosenTarget,
			SavedAutoRotate = humanoid.AutoRotate,
			SavedCamera = activeCamera and { Camera = activeCamera, Type = activeCamera.CameraType },
		}

		workerRunning = true
		RuntimeState.IsExecuting = true
		Engine.Guard.StealActive = true
		Engine.Movement.StealFirst = false
		Engine.AutoCycle = cycle

		task.spawn(function()
			local cycleOk, cycleFailure = pcall(RunSenaCycle, cycle)
			local cleanupOk, cleanupFailure = pcall(CleanupCycle, cycle)
			if not cycleOk then
				warn("[N3 HUB] Sena Auto Steal: " .. tostring(cycleFailure))
				SetCycleStatus(cycle, "Auto steal error")
			end
			if not cleanupOk then
				warn("[N3 HUB] Sena cleanup: " .. tostring(cleanupFailure))
			end
			if Engine.AutoCycle == cycle then
				Engine.RecordAutoTrace("cycle-finished: " .. tostring(Engine.AutoStatus), chosenTarget.Uid)
				Engine.AutoCycle = nil
				Engine.CurrentTarget = nil
				RuntimeState.IsExecuting = false
				Engine.Guard.StealActive = false
				Engine.ReleaseMovement("steal")
			end
			workerRunning = false
			Engine.ShieldHoldUntil = IsAutoStealEnabled() and not Engine.IsInExternalMapOrEvent() and (os.clock() + 2.5) or 0
			wakePending = true
			nextTickClock = os.clock() + 0.35
		end)
	end

	function Engine.AutoWake()
		wakePending = true
	end

	function Engine.CancelAutoSteal()
		cycleGeneration = cycleGeneration + 1
		Engine.ShieldHoldUntil = 0
		local activeCycle = Engine.AutoCycle
		if activeCycle then
			RuntimeState.StealCancel = RuntimeState.StealCancel + 1
			pcall(CleanupCycle, activeCycle)
			activeCycle.Cancelled = true
			if Engine.AutoCycle == activeCycle and not activeCycle.ApproachActive then
				Engine.RecordAutoTrace("cycle-cancelled", activeCycle.Target.Uid)
				Engine.AutoCycle = nil
				Engine.CurrentTarget = nil
				RuntimeState.IsExecuting = false
				Engine.Guard.StealActive = false
				Engine.ReleaseMovement("steal")
			end
		end
		retryUid = nil
		table.clear(carryTimeouts)
		table.clear(skippedEggs)
		wakePending = true
	end

	if EggStateModule then
		ConnectSignal(EggStateModule.FieldRefreshed, ReplaceSnapshot)
		ConnectSignal(EggStateModule.FieldShifted, function(eggRecord)
			if type(eggRecord) == "table" and eggRecord.Uid then
				liveRecords[eggRecord.Uid] = eggRecord
				wakePending = true
			end
		end)
		ConnectSignal(EggStateModule.FieldGone, function(eggUid)
			liveRecords[eggUid] = nil
			wakePending = true
		end)
		local function closeResetGate()
			resetBlocked = true
			gateOpenAt = math.huge
			Engine.CancelAutoSteal()
			Engine.AutoStatus = "Waiting for reset wall"
		end
		ConnectSignal(EggStateModule.ResetCountdown, closeResetGate)
		ConnectSignal(EggStateModule.ResetFade, closeResetGate)
	end

	if AreaEggResetWallModule then
		ConnectSignal(AreaEggResetWallModule.Changed, function(isSealed)
			resetBlocked = (isSealed == true)
			gateOpenAt = os.clock() + (isSealed and 0 or 0.2)
			if isSealed and Engine.AutoCycle then
				Engine.CancelAutoSteal()
			end
			wakePending = true
		end)
	end

	ConnectSignal(RunService.Heartbeat, function()
		if senaDisposed then
			return
		end
		local activeCycle = Engine.AutoCycle
		if activeCycle and not IsCycleCurrent(activeCycle) then
			if activeCycle.ReturnDeadline and os.clock() >= activeCycle.ReturnDeadline then
				SetCycleStatus(activeCycle, "Return timed out - retrying")
				Engine.RecordAutoTrace("return-watchdog-timeout", activeCycle.Target.Uid)
			end
			if not activeCycle.Cancelled then
				activeCycle.Cancelled = true
				Engine.CancelAutoSteal()
			end
			return
		end
		if os.clock() < nextTickClock then
			return
		end
		if not wakePending and workerRunning then
			return
		end
		wakePending = false
		nextTickClock = os.clock() + 0.35
		local tickOk, tickFailure = pcall(SchedulerTick)
		if not tickOk then
			Engine.AutoStatus = "Scheduler error"
			warn("[N3 HUB] Sena scheduler: " .. tostring(tickFailure))
		end
	end)

	pcall(function()
		LibraryLoader:OnUnload(function()
			senaDisposed = true
			Engine.CancelAutoSteal()
			for _, connection in ipairs(senaConnections) do
				connection:Disconnect()
			end
			baselineSearch.Found = nil
		end)
	end)
end

-- 5C. Safe Zone Visual (Exact Onium Decoy + Custom CameraSubject Orbit Presentation)
do
	local activeVisual, nextRetryClock = nil, 0
	local visualBindName = "N3SafeZoneVisual_" .. tostring(math.random(1000000, 9999999))
	local safeDecoyFrame = CFrame.new(544.76, 71.5, -416.48)

	local function IsSafeVisualWanted()
		local moveOwner = Engine.Movement.Owner
		return not RuntimeState.Unloaded
			and not Engine.Disposed
			and FarmConfig.SafeZoneVisual == true
			and IsStealActive() == true
			and not Engine.IsInExternalMapOrEvent()
			and (Engine.AutoCycle ~= nil or os.clock() < (Engine.ShieldHoldUntil or 0))
			and (moveOwner == nil or moveOwner == "steal")
	end

	function Engine.IsSafeZoneVisual()
		return activeVisual ~= nil
	end

	function Engine.StopSafeZoneVisual()
		local visualState = activeVisual
		if not visualState then
			return
		end
		activeVisual = nil
		pcall(RunService.UnbindFromRenderStep, RunService, visualBindName)
		for _, connection in ipairs(visualState.Connections) do
			pcall(connection.Disconnect, connection)
		end
		for targetInst, savedProp in pairs(visualState.Hidden) do
			pcall(function()
				targetInst[savedProp.Property] = savedProp.Value
			end)
		end
		local character = LocalPlayer.Character
		local realHumanoid = character and character:FindFirstChildOfClass("Humanoid")
		for camInst, savedCam in pairs(visualState.Cameras) do
			pcall(function()
				if camInst.CameraSubject == visualState.Humanoid then
					camInst.CameraSubject = realHumanoid or savedCam.Subject
					if camInst.CameraType == Enum.CameraType.Custom then
						camInst.CameraType = savedCam.Type
					end
				end
			end)
		end
		pcall(visualState.Decoy.Destroy, visualState.Decoy)
	end

	local function HideRealCharacterVisual(visualState, targetInst)
		if not targetInst:IsDescendantOf(visualState.Character) then
			return
		end
		local propName, hiddenVal = nil, nil
		if targetInst:IsA("BasePart") then
			propName, hiddenVal = "LocalTransparencyModifier", 1
		elseif targetInst:IsA("Trail") or targetInst:IsA("Beam") or targetInst:IsA("ParticleEmitter") then
			propName, hiddenVal = "Enabled", false
		end
		if propName then
			if not visualState.Hidden[targetInst] then
				visualState.Hidden[targetInst] = {
					Property = propName,
					Value = targetInst[propName],
					Hidden = hiddenVal,
				}
			end
			targetInst[propName] = hiddenVal
		end
	end

	local function HideStealGainPopup(visualState, guiInst)
		if guiInst:IsA("GuiObject") and (guiInst.Name == "SpeedGainPopup" or guiInst.Name == "PlusOne") then
			if not visualState.Hidden[guiInst] then
				visualState.Hidden[guiInst] = {
					Property = "Visible",
					Value = guiInst.Visible,
					Hidden = false,
				}
			end
			guiInst.Visible = false
		end
	end

	local function UpdateSafeZoneVisual()
		local visualState = activeVisual
		if not visualState then
			return
		end
		if not IsSafeVisualWanted()
			or LocalPlayer.Character ~= visualState.Character
			or visualState.Root.Parent ~= visualState.Character
			or visualState.Character:FindFirstChildOfClass("Humanoid") ~= visualState.RealHumanoid
			or visualState.RealHumanoid.Health <= 0
			or not visualState.Decoy.Parent
			or not visualState.Humanoid.Parent
		then
			Engine.StopSafeZoneVisual()
			return
		end

		for targetInst, savedProp in pairs(visualState.Hidden) do
			if not targetInst.Parent then
				visualState.Hidden[targetInst] = nil
			elseif targetInst[savedProp.Property] ~= savedProp.Hidden then
				targetInst[savedProp.Property] = savedProp.Hidden
			end
		end

		local camera = Workspace.CurrentCamera
		if camera then
			if not visualState.Cameras[camera] then
				visualState.Cameras[camera] = { Subject = camera.CameraSubject, Type = camera.CameraType }
			end
			if camera.CameraType ~= Enum.CameraType.Custom then
				camera.CameraType = Enum.CameraType.Custom
			end
			if camera.CameraSubject ~= visualState.Humanoid then
				camera.CameraSubject = visualState.Humanoid
			end
		end
	end

	local function CreateSafeZoneVisual(cycleContext)
		local character = cycleContext.Character
		local prevArchivable = character.Archivable
		character.Archivable = true
		local cloneOk, decoyModel = pcall(character.Clone, character)
		character.Archivable = prevArchivable
		if not cloneOk or not decoyModel then
			return false
		end

		local visualState = {
			Character = character,
			Root = cycleContext.Root,
			RealHumanoid = cycleContext.Humanoid,
			Decoy = decoyModel,
			Connections = {},
			Hidden = setmetatable({}, { __mode = "k" }),
			Cameras = setmetatable({}, { __mode = "k" }),
		}
		activeVisual = visualState
		decoyModel.Name = "__N3SafeZoneVisual"

		for _, descendant in ipairs(decoyModel:GetDescendants()) do
			if descendant:IsA("LuaSourceContainer")
				or descendant:IsA("Sound")
				or descendant:IsA("BillboardGui")
				or descendant:IsA("SurfaceGui")
				or descendant:IsA("Trail")
				or descendant:IsA("Beam")
				or descendant:IsA("ParticleEmitter")
				or descendant:IsA("ProximityPrompt")
				or descendant:IsA("Tool")
				or descendant:IsA("Constraint")
				or descendant:IsA("BodyMover")
			then
				descendant:Destroy()
			elseif descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") then
				local part0, part1 = descendant.Part0, descendant.Part1
				if (part0 and not part0:IsDescendantOf(decoyModel)) or (part1 and not part1:IsDescendantOf(decoyModel)) then
					descendant:Destroy()
				end
			elseif descendant:IsA("BasePart") then
				descendant.LocalTransparencyModifier = 0
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanTouch = false
				descendant.CanQuery = false
			end
		end

		local decoyHumanoid = decoyModel:FindFirstChildOfClass("Humanoid")
		local decoyRoot = decoyModel:FindFirstChild("HumanoidRootPart")
		if not decoyHumanoid or not decoyRoot then
			Engine.StopSafeZoneVisual()
			return false
		end
		visualState.Humanoid = decoyHumanoid
		decoyHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		decoyHumanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
		decoyModel:PivotTo(safeDecoyFrame * cycleContext.Root.CFrame.Rotation)
		decoyModel.Parent = Workspace

		for _, descendant in ipairs(character:GetDescendants()) do
			HideRealCharacterVisual(visualState, descendant)
		end
		visualState.Connections[#visualState.Connections + 1] = character.DescendantAdded:Connect(function(newInst)
			if activeVisual == visualState then
				HideRealCharacterVisual(visualState, newInst)
			end
		end)
		if cycleContext.Humanoid.Died then
			visualState.Connections[#visualState.Connections + 1] = cycleContext.Humanoid.Died:Connect(Engine.StopSafeZoneVisual)
		end

		local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if playerGui then
			for _, guiInst in ipairs(playerGui:GetDescendants()) do
				HideStealGainPopup(visualState, guiInst)
			end
			visualState.Connections[#visualState.Connections + 1] = playerGui.DescendantAdded:Connect(function(newGui)
				if activeVisual == visualState then
					HideStealGainPopup(visualState, newGui)
				end
			end)
		end

		RunService:BindToRenderStep(visualBindName, Enum.RenderPriority.Camera.Value - 1, UpdateSafeZoneVisual)
		UpdateSafeZoneVisual()
		return true
	end

	function Engine.StartSafeZoneVisual(cycleContext)
		if not cycleContext then
			local character = LocalPlayer.Character
			cycleContext = character and {
				Character = character,
				Root = character:FindFirstChild("HumanoidRootPart"),
				Humanoid = character:FindFirstChildOfClass("Humanoid"),
			} or nil
		end
		if not cycleContext or not cycleContext.Root or not cycleContext.Humanoid or cycleContext.Humanoid.Health <= 0 then
			return false
		end
		if not IsSafeVisualWanted() or Engine.Guard.Disguise then
			return false
		end
		if activeVisual and activeVisual.Character == cycleContext.Character and activeVisual.RealHumanoid == cycleContext.Humanoid then
			return true
		end
		Engine.StopSafeZoneVisual()
		if os.clock() < nextRetryClock then
			return false
		end
		local createOk, createResult = pcall(CreateSafeZoneVisual, cycleContext)
		if not createOk or not createResult then
			nextRetryClock = os.clock() + 5
			Engine.StopSafeZoneVisual()
			warn("[N3 HUB] Safe-zone visual unavailable; steal continues: " .. tostring(createResult))
			return false
		end
		nextRetryClock = 0
		return true
	end

	local rawClaimMovement = Engine.ClaimMovement
	function Engine.ClaimMovement(ownerName, ...)
		local accepted = rawClaimMovement(ownerName, ...)
		if accepted and ownerName == "steal" then
			Engine.StartSafeZoneVisual()
		end
		return accepted
	end

	local rawCancelAutoSteal = Engine.CancelAutoSteal
	function Engine.CancelAutoSteal(...)
		Engine.StopSafeZoneVisual()
		return rawCancelAutoSteal(...)
	end

	pcall(function()
		LibraryLoader:OnUnload(Engine.StopSafeZoneVisual)
	end)
end

-- 5D. Progression Automation (100% Chilli Mechanics: Trail, Base, Treadmill, Money, Index)
do
	local Progression = {
		RemoteCache = {},
		Workers = {},
		WakeRequested = true,
		CursorIndex = 0,
	}
	Hub.Progression = Progression

	local REPEAT_GAP_SEC = 0.35
	local WAKE_GAP_SEC = 0.6
	local IDLE_GAP_SEC = 5.0
	local DEFAULT_BACKOFF_SEC = 6.0

	local function ResolveRemote(remotePath)
		local cached = Progression.RemoteCache[remotePath]
		if cached ~= nil then
			return cached or nil
		end
		local resolved = (NetworkFolder and NetworkFolder:FindFirstChild(remotePath)) or FindGameRemote(remotePath)
		Progression.RemoteCache[remotePath] = resolved or false
		return resolved
	end

	local function InvokeProgressionRemote(remotePath, ...)
		local remoteObj = ResolveRemote(remotePath)
		if not remoteObj or not remoteObj:IsA("RemoteFunction") then
			return false, nil
		end
		return pcall(remoteObj.InvokeServer, remoteObj, ...)
	end

	local function FireProgressionRemote(remotePath, ...)
		local remoteObj = ResolveRemote(remotePath)
		if not remoteObj or not remoteObj:IsA("RemoteEvent") then
			return false
		end
		return pcall(remoteObj.FireServer, remoteObj, ...)
	end

	local function ReadSaveData()
		if type(SaveModule) ~= "table" then
			return nil
		end
		local readerFn = (type(SaveModule.Get) == "function" and SaveModule.Get)
			or (type(SaveModule.Peek) == "function" and SaveModule.Peek)
		if not readerFn then
			return nil
		end
		local callOk, saveTable = pcall(readerFn)
		return (callOk and type(saveTable) == "table") and saveTable or nil
	end

	local MONEY_KEYS = { "Money", "Cash", "Coins", "Currency", "Balance" }
	local function ReadPlayerMoney(saveData)
		local activeSave = saveData or ReadSaveData()
		if activeSave then
			for _, keyName in ipairs(MONEY_KEYS) do
				local numericBalance = tonumber(activeSave[keyName])
				if numericBalance then
					return numericBalance
				end
			end
		end
		local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
		if leaderstats then
			for _, keyName in ipairs(MONEY_KEYS) do
				local statObj = leaderstats:FindFirstChild(keyName)
				local statBalance = statObj and tonumber(statObj.Value)
				if statBalance then
					return statBalance
				end
			end
		end
		return 0
	end

	local function AddWorker(workerFn)
		local workerEntry = {
			Run = workerFn,
			Gap = REPEAT_GAP_SEC,
			Idle = IDLE_GAP_SEC,
			Repeat = false,
			Hold = 0,
			Woke = true,
		}
		table.insert(Progression.Workers, workerEntry)
		return workerEntry
	end

	local function BackoffWorker(workerEntry, holdSeconds)
		if workerEntry then
			workerEntry.Hold = tonumber(holdSeconds) or DEFAULT_BACKOFF_SEC
		end
	end

	function Progression.Wake()
		Progression.WakeRequested = true
	end

	-- Subscribe to Save replica signals for immediate zero-lag progression reaction
	if type(SaveModule) == "table" then
		local signalFactory = (type(SaveModule.FieldSignal) == "function" and SaveModule.FieldSignal)
			or (type(SaveModule.Watch) == "function" and SaveModule.Watch)
		if signalFactory then
			for _, watchedField in ipairs({
				"Money",
				"BaseUpgradeLevel",
				"TreadmillUpgradeLevel",
				"TrailInventory",
				"PendingOfflineMoney",
				"Index",
				"IndexClaimedCategories",
				"FusionSlots",
				"FusionLocked",
				"FusionEggReward",
			}) do
				local callOk, fieldSig = pcall(signalFactory, watchedField)
				if callOk and fieldSig and type(fieldSig.Connect) == "function" then
					local connOk, sigConn = pcall(fieldSig.Connect, fieldSig, Progression.Wake)
					if connOk and sigConn then
						Hub.Lifecycle.TrackConnection(sigConn)
					end
				end
			end
		end
	end

	-- 1) Auto Buy Trail (Chilli RF/Trailwear/AskPurchase sorted ascending by price)
	local sortedTrailsCache = nil
	local failedTrailIds = {}

	function Progression.ResetTrailCache()
		table.clear(failedTrailIds)
		sortedTrailsCache = nil
		Progression.Wake()
	end

	local function GetSortedTrails()
		if sortedTrailsCache then
			return sortedTrailsCache
		end
		local directory = type(TrailsModule) == "table" and TrailsModule.Directory or nil
		if type(directory) ~= "table" then
			return {}
		end
		local list = {}
		for trailKey, trailEntry in pairs(directory) do
			if type(trailEntry) == "table" then
				table.insert(list, {
					Id = tostring(trailEntry._id or trailKey),
					Price = ToFiniteNumber(trailEntry.Price, math.huge),
				})
			end
		end
		table.sort(list, function(trailA, trailB)
			if trailA.Price ~= trailB.Price then
				return trailA.Price < trailB.Price
			end
			return trailA.Id < trailB.Id
		end)
		if #list > 0 then
			sortedTrailsCache = list
		end
		return list
	end

	AddWorker(function(workerEntry)
		if not FarmConfig.Progression_AutoBuyTrail then
			return false
		end
		local trailsList = GetSortedTrails()
		local saveData = ReadSaveData()
		if not saveData or #trailsList == 0 then
			return false
		end
		local ownedTrails = type(saveData.TrailInventory) == "table" and saveData.TrailInventory or {}
		local currentMoney = ReadPlayerMoney(saveData)
		for _, trailInfo in ipairs(trailsList) do
			if ownedTrails[trailInfo.Id] ~= true and not failedTrailIds[trailInfo.Id] then
				if trailInfo.Price <= currentMoney then
					local callOk, purchaseRes = InvokeProgressionRemote("RF/Trailwear/AskPurchase", trailInfo.Id)
					if callOk and purchaseRes ~= false then
						return true
					end
					failedTrailIds[trailInfo.Id] = true
					BackoffWorker(workerEntry)
					return false
				end
			end
		end
		return false
	end)

	-- 2) Auto Upgrade Base (Chilli RE/Homestead/AskBaseTierRaise via Data.Bases.BASES)
	AddWorker(function()
		if not FarmConfig.Progression_AutoUpgradeBase then
			return false
		end
		local saveData = ReadSaveData()
		local basesTable = type(BasesModule) == "table" and BasesModule.BASES or nil
		if not saveData or type(basesTable) ~= "table" then
			return false
		end
		local currentLevel = tonumber(saveData.BaseUpgradeLevel) or 0
		if type(BasesModule.GetMaxBaseLevel) == "function" then
			local callOk, maxLevel = pcall(BasesModule.GetMaxBaseLevel)
			local numericMax = callOk and tonumber(maxLevel)
			if numericMax and currentLevel >= numericMax then
				return false
			end
		end
		local nextTier = basesTable[currentLevel + 1]
		local upgradeCost = type(nextTier) == "table" and tonumber(nextTier.Cost)
		if upgradeCost and ReadPlayerMoney(saveData) >= upgradeCost then
			return FireProgressionRemote("RE/Homestead/AskBaseTierRaise")
		end
		return false
	end)

	-- 3) Auto Upgrade Treadmill (Chilli RF/Treadmill/AskTierRaise via Data.Treadmills.GetByUpgradeLevel)
	AddWorker(function()
		if not FarmConfig.Progression_AutoUpgradeTreadmill then
			return false
		end
		local saveData = ReadSaveData()
		if not saveData or type(TreadmillsModule) ~= "table" or type(TreadmillsModule.GetByUpgradeLevel) ~= "function" then
			return false
		end
		local currentLevel = tonumber(saveData.TreadmillUpgradeLevel) or 0
		local callOk, nextTier = pcall(TreadmillsModule.GetByUpgradeLevel, currentLevel + 1)
		if not callOk or type(nextTier) ~= "table" then
			return false
		end
		local tierId = nextTier._id
		local tierPrice = ToFiniteNumber(nextTier.Price, math.huge)
		if type(tierId) == "string" and ReadPlayerMoney(saveData) >= tierPrice then
			local invokeOk, upgradeRes = InvokeProgressionRemote("RF/Treadmill/AskTierRaise", tierId)
			return invokeOk and upgradeRes ~= false
		end
		return false
	end)

	-- 4) Auto Claim Money (Chilli RF/AwayEarnings/PendingCheck + RF/AwayEarnings/AskCollect {Kind="Claim"})
	local nextPendingProbeAt = 0
	function Progression.ResetMoneyClaimTimer()
		nextPendingProbeAt = 0
		Progression.Wake()
	end

	AddWorker(function()
		if not FarmConfig.Progression_AutoClaimMoney then
			return false
		end
		local saveData = ReadSaveData()
		local pendingAmount = saveData and tonumber(saveData.PendingOfflineMoney) or nil
		local nowClock = os.clock()
		if pendingAmount == nil and nowClock >= nextPendingProbeAt then
			nextPendingProbeAt = nowClock + 15
			local checkOk, checkRes = InvokeProgressionRemote("RF/AwayEarnings/PendingCheck")
			pendingAmount = (checkOk and checkRes ~= false and checkRes ~= nil)
				and (tonumber(checkRes) or 1)
				or 0
		end
		if (pendingAmount or 0) > 0 then
			local collectOk, collectRes = InvokeProgressionRemote("RF/AwayEarnings/AskCollect", { Kind = "Claim" })
			return collectOk and collectRes ~= false
		end
		return false
	end)

	-- 5) Auto Claim Index (Chilli RF/Codex/AskRedeemAll + RF/Codex/AskRedeemLimitedEgg for completion gears)
	local SPECIAL_INDEX_SETS = {
		{ Id = "LimitedEgg", Gear = "GravityDisruptor", Module = LimitedEggModule, Lists = { { "Entries" }, { "MechaReroll", "Entries" } } },
		{ Id = "BrainrotEgg", Gear = "BeeLauncher", Module = BrainrotEggModule, Lists = { { "Entries" } } },
		{ Id = "MonsterEgg", Gear = "BeeLauncher", Module = MonsterEggModule, Lists = { { "Entries" }, { "MechaEntries" } } },
	}
	local specialRedeemCooldown = {}
	local nextIndexSweepAt = 0

	function Progression.ResetIndexTimer()
		nextIndexSweepAt = 0
		table.clear(specialRedeemCooldown)
		Progression.Wake()
	end

	local function CollectModuleAssetIds(moduleTable, listPaths)
		local assetIds = {}
		if type(moduleTable) ~= "table" then
			return assetIds
		end
		for _, pathSteps in ipairs(listPaths) do
			local cursor = moduleTable
			for _, stepKey in ipairs(pathSteps) do
				cursor = type(cursor) == "table" and cursor[stepKey] or nil
			end
			if type(cursor) == "table" then
				for _, itemEntry in ipairs(cursor) do
					if type(itemEntry) == "table" and itemEntry.AssetId ~= nil then
						table.insert(assetIds, itemEntry.AssetId)
					end
				end
			end
		end
		return assetIds
	end

	AddWorker(function()
		if not FarmConfig.Progression_AutoClaimIndex then
			return false
		end
		local didClaim = false
		local nowClock = os.clock()
		local saveData = ReadSaveData()
		if saveData then
			local unlockedIndex = type(saveData.Index) == "table" and saveData.Index or {}
			local claimedCategories = type(saveData.IndexClaimedCategories) == "table" and saveData.IndexClaimedCategories or {}
			local hasUnclaimed = false
			for assetKey, isUnlocked in pairs(unlockedIndex) do
				if isUnlocked == true and claimedCategories[assetKey] ~= true then
					hasUnclaimed = true
					break
				end
			end
			if hasUnclaimed or nowClock >= nextIndexSweepAt then
				nextIndexSweepAt = nowClock + 15
				local redeemOk, redeemRes = InvokeProgressionRemote("RF/Codex/AskRedeemAll")
				didClaim = didClaim or (redeemOk and redeemRes ~= false)
			end

			local gearInventory = type(saveData.GearInventory) == "table" and saveData.GearInventory or {}
			for _, setSpec in ipairs(SPECIAL_INDEX_SETS) do
				if (tonumber(gearInventory[setSpec.Gear]) or 0) <= 0 and nowClock >= (specialRedeemCooldown[setSpec.Id] or 0) then
					local requiredAssets = CollectModuleAssetIds(setSpec.Module, setSpec.Lists)
					local allUnlocked = #requiredAssets > 0
					for _, assetId in ipairs(requiredAssets) do
						if unlockedIndex[assetId] ~= true then
							allUnlocked = false
							break
						end
					end
					if allUnlocked then
						specialRedeemCooldown[setSpec.Id] = nowClock + 30
						local limOk, limRes = InvokeProgressionRemote("RF/Codex/AskRedeemLimitedEgg", setSpec.Id)
						didClaim = didClaim or (limOk and limRes ~= false)
					end
				end
			end
		elseif nowClock >= nextIndexSweepAt then
			nextIndexSweepAt = nowClock + 15
			local redeemOk, redeemRes = InvokeProgressionRemote("RF/Codex/AskRedeemAll")
			didClaim = redeemOk and redeemRes ~= false
		end
		return didClaim
	end)

	-- Chilli Round-Robin Heartbeat TaskScheduler (max 3 workers/frame, non-blocking)
	local schedulerBusy = false
	Hub.Lifecycle.TrackConnection(RunService.Heartbeat:Connect(function(deltaTime)
		if not Hub.Alive or Engine.Disposed then
			return
		end
		local workerCount = #Progression.Workers
		if workerCount == 0 then
			return
		end
		local wokeNow = Progression.WakeRequested
		Progression.WakeRequested = false
		for _, workerEntry in ipairs(Progression.Workers) do
			workerEntry.Gap = workerEntry.Gap + deltaTime
			workerEntry.Idle = workerEntry.Idle + deltaTime
			workerEntry.Woke = workerEntry.Woke or wokeNow
			if workerEntry.Hold > 0 then
				workerEntry.Hold = workerEntry.Hold - deltaTime
			end
		end
		if schedulerBusy then
			return
		end
		for _ = 1, workerCount do
			Progression.CursorIndex = (Progression.CursorIndex % workerCount) + 1
			local candidate = Progression.Workers[Progression.CursorIndex]
			local shouldRun = candidate.Hold <= 0 and (
				(candidate.Repeat and candidate.Gap >= REPEAT_GAP_SEC)
				or (candidate.Woke and candidate.Gap >= WAKE_GAP_SEC)
				or (candidate.Idle >= IDLE_GAP_SEC)
			)
			if shouldRun then
				candidate.Gap = 0
				candidate.Idle = 0
				candidate.Woke = false
				schedulerBusy = true
				task.spawn(function()
					local runOk, wantsRepeat = pcall(candidate.Run, candidate)
					candidate.Repeat = runOk and wantsRepeat == true
					schedulerBusy = false
				end)
				break
			end
		end
	end))

	-- 5E. Auto Treadmill & Auto Place Egg (100% Chilli Mechanics, Shared Scheduler)
	local SAFE_RETURN_POINT = Vector3.new(544.76, 71.5, -416.48)
	local hiddenBeltParts = {}
	local beltHoldDepth = 0

	local function IsAutoStealBusy()
		if not IsStealActive() or Engine.IsInExternalMapOrEvent() then
			return false
		end
		if Engine.AutoCycle ~= nil or Engine.AutoCarry.Carrying then
			return true
		end
		local status = tostring(Engine.AutoStatus or "Idle")
		return status ~= "Idle"
			and status ~= "No matching eggs"
			and status ~= "Waiting for reset wall"
			and status ~= "Paused (In Event / Other Map)"
	end

	local function GetTreadmillBeltPart()
		local playerPlot = GetPlayerPlot()
		if not playerPlot then
			return nil
		end
		local directBelt = playerPlot:FindFirstChild("TreadmillBottom")
		if directBelt and directBelt:IsA("BasePart") then
			return directBelt
		end
		local renderFolder = Workspace:FindFirstChild("__ClientTreadmillRenders")
		local plotRender = renderFolder and renderFolder:FindFirstChild("TreadmillRender_" .. playerPlot.Name)
		if plotRender then
			local renderPart = plotRender:FindFirstChild("BoundingBoxPart")
				or (plotRender:IsA("Model") and plotRender.PrimaryPart)
				or plotRender:FindFirstChildWhichIsA("BasePart")
			if renderPart then
				return renderPart
			end
		end
		local upgradeModel = playerPlot:FindFirstChild("TreadmillUpgrade")
		return upgradeModel and upgradeModel:FindFirstChildWhichIsA("BasePart") or nil
	end

	local function CollectPlotBeltParts()
		local playerPlot = GetPlayerPlot()
		if not playerPlot then
			return {}
		end
		local foundParts = {}
		for _, childName in ipairs({ "TreadmillBottom", "TreadmillUpgrade" }) do
			local node = playerPlot:FindFirstChild(childName)
			if node then
				if node:IsA("BasePart") then
					table.insert(foundParts, node)
				else
					for _, desc in ipairs(node:GetDescendants()) do
						if desc:IsA("BasePart") then
							table.insert(foundParts, desc)
						end
					end
				end
			end
		end
		local renderFolder = Workspace:FindFirstChild("__ClientTreadmillRenders")
		local plotRender = renderFolder and renderFolder:FindFirstChild("TreadmillRender_" .. playerPlot.Name)
		if plotRender then
			for _, desc in ipairs(plotRender:GetDescendants()) do
				if desc:IsA("BasePart") then
					table.insert(foundParts, desc)
				end
			end
		end
		return foundParts
	end

	local function HoldTreadmillBelt()
		beltHoldDepth = beltHoldDepth + 1
		for _, partObj in ipairs(CollectPlotBeltParts()) do
			if not hiddenBeltParts[partObj] then
				hiddenBeltParts[partObj] = {
					CFrame = partObj.CFrame,
					CanTouch = partObj.CanTouch,
					CanCollide = partObj.CanCollide,
					Transparency = partObj.Transparency,
				}
				pcall(function()
					partObj.CanTouch = false
					partObj.CanCollide = false
					partObj.Transparency = 1
					partObj.CFrame = partObj.CFrame - Vector3.new(0, 120, 0)
				end)
			end
		end
	end

	local function RestoreHiddenBeltParts()
		for partObj, savedProps in pairs(hiddenBeltParts) do
			if partObj and partObj.Parent then
				pcall(function()
					partObj.CFrame = savedProps.CFrame
					partObj.CanTouch = savedProps.CanTouch
					partObj.CanCollide = savedProps.CanCollide
					partObj.Transparency = savedProps.Transparency
				end)
			end
		end
		table.clear(hiddenBeltParts)
	end

	local function ReleaseTreadmillBelt()
		beltHoldDepth = math.max(0, beltHoldDepth - 1)
		if beltHoldDepth == 0 then
			RestoreHiddenBeltParts()
		end
	end

	local function ResetTreadmillBeltHold()
		beltHoldDepth = 0
		RestoreHiddenBeltParts()
	end

	local function IsPlayerOnBelt()
		local beltPart = GetTreadmillBeltPart()
		local rootPart = Engine.Root()
		if not beltPart or hiddenBeltParts[beltPart] or not rootPart then
			return false
		end
		local localPos = beltPart.CFrame:PointToObjectSpace(rootPart.Position)
		return math.abs(localPos.X) <= (beltPart.Size.X * 0.5 + 2)
			and math.abs(localPos.Z) <= (beltPart.Size.Z * 0.5 + 2)
			and localPos.Y >= -2
			and localPos.Y <= (beltPart.Size.Y * 0.5 + 8)
	end

	local TreadmillState = {
		Riding = false,
		Busy = false,
		Gen = 0,
		NextTryAt = 0,
		NextStayCheckAt = 0,
		LastFailed = false,
		LastSpeedGainedAt = 0,
		NotGroundedHits = 0,
		DidUndoSwap = false,
	}
	Hub.Treadmill = TreadmillState

	if Remotes.TreadmillSpeedGained and Remotes.TreadmillSpeedGained:IsA("RemoteEvent") then
		Hub.Lifecycle.TrackConnection(Remotes.TreadmillSpeedGained.OnClientEvent:Connect(function()
			TreadmillState.LastSpeedGainedAt = os.clock()
		end))
	end

	local function LeaveTreadmillRemote()
		InvokeProgressionRemote("RF/Treadmill/AskDoff")
	end

	local function ExitTreadmillBelt()
		TreadmillState.Riding = false
		LeaveTreadmillRemote()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			pcall(function()
				humanoid.Jump = true
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end)
		end
		task.wait(0.35)
	end
	Engine.ExitTreadmill = ExitTreadmillBelt

	-- Chilli 3-leg smooth +30 arc flight inside base (crosses SeparationLine cleanly first if outside)
	local function StepMoveToTarget(goalPos, shouldAbort)
		local rootPart = Engine.Root()
		if not rootPart then
			return false
		end
		local trackedPos = rootPart.Position
		local travelSpeed = math.clamp(tonumber(FarmConfig.TweenSpeed) or 600, 120, 1000)
		local maxSeconds = (goalPos - trackedPos).Magnitude / math.max(travelSpeed, 1) + 3
		local elapsed = 0
		local doneResult = nil

		local stepConn = RunService.Heartbeat:Connect(function(deltaTime)
			if doneResult ~= nil or Engine.Guard.Busy then
				return
			end
			elapsed = elapsed + deltaTime
			local liveRoot = Engine.Root()
			if not liveRoot or Engine.IsInExternalMapOrEvent() or (shouldAbort and shouldAbort()) or elapsed > maxSeconds then
				doneResult = false
				return
			end
			if (liveRoot.Position - trackedPos).Magnitude > 6 then
				trackedPos = liveRoot.Position
			end
			local remainVec = goalPos - trackedPos
			local stepDist = travelSpeed * deltaTime
			local reached = remainVec.Magnitude <= math.max(stepDist, 0.05)
			trackedPos = reached and goalPos or (trackedPos + remainVec.Unit * stepDist)
			local flatDir = Vector3.new(remainVec.X, 0, remainVec.Z)
			local lookRot = flatDir.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, flatDir.Unit) or liveRoot.CFrame.Rotation
			pcall(function()
				liveRoot.CFrame = CFrame.new(trackedPos) * lookRot
				liveRoot.AssemblyLinearVelocity = Vector3.zero
				liveRoot.AssemblyAngularVelocity = Vector3.zero
			end)
			if reached then
				doneResult = true
			end
		end)

		while doneResult == nil do
			RunService.Heartbeat:Wait()
		end
		stepConn:Disconnect()
		return doneResult == true
	end

	local function FlyInsideBaseTo(targetPos, shouldAbort)
		local rootPart = Engine.Root()
		if not rootPart then
			return false
		end
		local sepX = Engine.GetSeparationX()
		if (rootPart.Position.X < sepX) ~= (targetPos.X < sepX) then
			if (SAFE_RETURN_POINT - targetPos).Magnitude > 12 and (rootPart.Position - SAFE_RETURN_POINT).Magnitude > 12 then
				if not FlyInsideBaseTo(SAFE_RETURN_POINT, shouldAbort) then
					return false
				end
			end
		end
		if shouldAbort and shouldAbort() then
			return false
		end
		rootPart = Engine.Root()
		if not rootPart then
			return false
		end
		local elevatedDest = targetPos + Vector3.new(0, 3, 0)
		local arcTopY = math.max(rootPart.Position.Y, elevatedDest.Y) + 30
		local okArc, arcRes = pcall(function()
			return StepMoveToTarget(Vector3.new(rootPart.Position.X, arcTopY, rootPart.Position.Z), shouldAbort)
				and StepMoveToTarget(Vector3.new(elevatedDest.X, arcTopY, elevatedDest.Z), shouldAbort)
				and StepMoveToTarget(elevatedDest, shouldAbort)
		end)
		return okArc and arcRes == true
	end

	-- Auto Treadmill Worker & Watchdogs (Chilli L23965-24445)
	local function ShouldYieldTreadmill()
		if Engine.IsInExternalMapOrEvent() then
			return true
		end
		if Engine.Movement.PlaceWanted or Engine.Movement.EssenceWanted then
			return true
		end
		if Engine.Movement.Owner ~= nil and Engine.Movement.Owner ~= "treadmill" then
			return true
		end
		return IsAutoStealBusy()
	end

	local function IsGainingBeltSpeed()
		return (os.clock() - TreadmillState.LastSpeedGainedAt) < 6 and IsPlayerOnBelt()
	end

	local function EvaluateWearResponse(callOk, accepted, reasonText)
		if callOk and accepted ~= false then
			TreadmillState.NotGroundedHits = 0
			TreadmillState.DidUndoSwap = false
			return true
		end
		local reasonStr = tostring(reasonText or accepted or "")
		if callOk and reasonStr == "Already using treadmill" then
			TreadmillState.NotGroundedHits = 0
			TreadmillState.DidUndoSwap = false
			return true
		end
		if callOk and reasonStr == "Not grounded" then
			if IsGainingBeltSpeed() then
				TreadmillState.NotGroundedHits = 0
				TreadmillState.DidUndoSwap = false
				return true
			end
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if Engine.IsGrounded(humanoid) then
				TreadmillState.NotGroundedHits = TreadmillState.NotGroundedHits + 1
				if TreadmillState.NotGroundedHits >= 2 then
					TreadmillState.NotGroundedHits = 0
					if not TreadmillState.DidUndoSwap then
						TreadmillState.DidUndoSwap = true
						pcall(RestoreCharacter)
					end
				end
			end
		end
		return false
	end

	local function InvokeWearStill()
		local remoteObj = ResolveRemote("RF/Treadmill/AskWearStill")
		if not remoteObj or not remoteObj:IsA("RemoteFunction") then
			return false, nil, nil
		end
		local callOk, resA, resB = pcall(remoteObj.InvokeServer, remoteObj)
		return callOk, resA, resB
	end

	local function MountTreadmillCycle(expectedGen)
		if ShouldYieldTreadmill() or not Engine.ClaimMovement("treadmill") then
			return false
		end
		TreadmillState.LastSpeedGainedAt = 0
		local function abortMount()
			return expectedGen ~= TreadmillState.Gen
				or not FarmConfig.Progression_AutoTreadmill
				or Engine.Movement.Owner ~= "treadmill"
				or ShouldYieldTreadmill()
		end
		if beltHoldDepth > 0 then
			ResetTreadmillBeltHold()
		end
		local beltPart = GetTreadmillBeltPart()
		local rootPart = Engine.Root()
		if not beltPart or not rootPart then
			return false
		end
		local beltSurfacePos = beltPart.Position + Vector3.new(0, beltPart.Size.Y * 0.5, 0)
		if (rootPart.Position - (beltSurfacePos + Vector3.new(0, 2, 0))).Magnitude > 10 then
			if not FlyInsideBaseTo(beltSurfacePos, abortMount) then
				return false
			end
		end
		if abortMount() then
			return false
		end
		TreadmillState.Riding = EvaluateWearResponse(InvokeWearStill())
		return TreadmillState.Riding
	end

	function TreadmillState.Restart()
		TreadmillState.Gen = TreadmillState.Gen + 1
		TreadmillState.NextTryAt = 0
		Progression.Wake()
	end

	AddWorker(function()
		if not FarmConfig.Progression_AutoTreadmill then
			if TreadmillState.Riding and not TreadmillState.Busy then
				TreadmillState.Busy = true
				task.spawn(function()
					pcall(ExitTreadmillBelt)
					TreadmillState.Busy = false
					Progression.Wake()
				end)
			end
			return false
		end
		if TreadmillState.Busy or ShouldYieldTreadmill() then
			return false
		end
		local nowClock = os.clock()
		if TreadmillState.Riding then
			if IsPlayerOnBelt() then
				if nowClock >= TreadmillState.NextStayCheckAt then
					local character = LocalPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if Engine.IsGrounded(humanoid) and not IsGainingBeltSpeed() then
						TreadmillState.NextStayCheckAt = nowClock + 5
						TreadmillState.Busy = true
						task.spawn(function()
							local okCheck, stillOn = pcall(function()
								return EvaluateWearResponse(InvokeWearStill())
							end)
							TreadmillState.Riding = okCheck and stillOn == true
							if not TreadmillState.Riding then
								TreadmillState.NextTryAt = 0
							end
							TreadmillState.Busy = false
							Progression.Wake()
						end)
					end
				end
				return false
			end
		end
		if nowClock < TreadmillState.NextTryAt then
			return false
		end
		TreadmillState.NextStayCheckAt = 0
		TreadmillState.NextTryAt = nowClock + (TreadmillState.LastFailed and 3 or 4)
		TreadmillState.Busy = true
		local myGen = TreadmillState.Gen
		task.spawn(function()
			local okMount, mounted = pcall(MountTreadmillCycle, myGen)
			TreadmillState.LastFailed = not (okMount and mounted == true)
			Engine.ReleaseMovement("treadmill")
			TreadmillState.Busy = false
			Progression.Wake()
		end)
		return false
	end)

	-- Off-belt detection & manual WASD dismount loop
	do
		local offBeltElapsed = 0
		local manualPushElapsed = 0
		local manualCooldown = 0
		local prevPos = nil
		Hub.Lifecycle.SpawnLoop(0.25, function()
			if Engine.Disposed then
				return
			end
			manualCooldown = math.max(0, manualCooldown - 0.25)
			if FarmConfig.Progression_AutoTreadmill and TreadmillState.Riding and not ShouldYieldTreadmill() then
				if IsPlayerOnBelt() then
					offBeltElapsed = 0
				else
					offBeltElapsed = offBeltElapsed + 0.25
					if offBeltElapsed >= 1.5 then
						offBeltElapsed = 0
						TreadmillState.Riding = false
						TreadmillState.NextTryAt = 0
						Progression.Wake()
					end
				end
			else
				offBeltElapsed = 0
			end

			-- Allow clean manual WASD dismount when Auto Treadmill is OFF
			local rootPart = Engine.Root()
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local autoOwnsBelt = FarmConfig.Progression_AutoTreadmill and TreadmillState.Riding and not ShouldYieldTreadmill()
			if autoOwnsBelt
				or Engine.Movement.Owner ~= nil
				or Engine.Movement.PlaceWanted
				or not rootPart
				or not humanoid
				or humanoid.MoveDirection.Magnitude <= 0.1
				or not IsPlayerOnBelt()
			then
				manualPushElapsed = 0
				prevPos = rootPart and rootPart.Position or nil
			else
				if prevPos and Vector2.new(rootPart.Position.X - prevPos.X, rootPart.Position.Z - prevPos.Z).Magnitude < 0.5 then
					manualPushElapsed = manualPushElapsed + 0.25
				else
					manualPushElapsed = 0
				end
				prevPos = rootPart.Position
				if manualPushElapsed >= 1.0 and manualCooldown <= 0 then
					manualPushElapsed = 0
					manualCooldown = 1.5
					pcall(ExitTreadmillBelt)
				end
			end
		end)
	end

	-- Auto Place Egg Worker (100% Chilli Mechanics L22979-23845)
	local PlaceState = {
		Busy = false,
		Gen = 0,
		CooldownUntil = 0,
		FailedEggCooldowns = {},
		LastPlacedCount = nil,
	}
	Hub.AutoPlace = PlaceState

	local MAX_PLOT_PLACED_EGGS = 30
	local PEN_REACH_DIST = 26
	local GRID_SPACING = 4
	local MIN_EGG_SEPARATION = 3.9
	local PREFERRED_GRID_ANCHOR = Vector2.new(-8, 16)
	local placeRng = Random.new()

	if type(SaveModule) == "table" then
		local signalFactory = (type(SaveModule.FieldSignal) == "function" and SaveModule.FieldSignal)
			or (type(SaveModule.Watch) == "function" and SaveModule.Watch)
		if signalFactory then
			for _, placeField in ipairs({ "EggInventory", "EquippedAssets" }) do
				local callOk, fieldSig = pcall(signalFactory, placeField)
				if callOk and fieldSig and type(fieldSig.Connect) == "function" then
					local connOk, sigConn = pcall(fieldSig.Connect, fieldSig, Progression.Wake)
					if connOk and sigConn then
						Hub.Lifecycle.TrackConnection(sigConn)
					end
				end
			end
		end
	end

	local function GetPlacedEggPositionsWorld()
		local rendersFolder = Workspace:FindFirstChild("PlacedEggRenders")
		local positions = {}
		if not rendersFolder then
			return positions
		end
		local userIdTag = tostring(LocalPlayer.UserId)
		for _, renderModel in ipairs(rendersFolder:GetChildren()) do
			if string.find(renderModel.Name, userIdTag, 1, true) then
				local callOk, pivotCF = pcall(function()
					return renderModel:IsA("Model") and renderModel:GetPivot() or renderModel.CFrame
				end)
				if callOk and pivotCF then
					table.insert(positions, pivotCF.Position)
				end
			end
		end
		return positions
	end

	local function GetPenAnchorPosition()
		local placedWorld = GetPlacedEggPositionsWorld()
		if #placedWorld > 0 then
			local sumVec = Vector3.zero
			for _, posVec in ipairs(placedWorld) do
				sumVec = sumVec + posVec
			end
			return sumVec / #placedWorld
		end
		local playerPlot = GetPlayerPlot()
		if not playerPlot then
			return nil
		end
		local toUpdate = playerPlot:FindFirstChild("ToUpdate")
		local anchorInst = (toUpdate and toUpdate:FindFirstChild("StarterPen"))
			or playerPlot:FindFirstChild("PetArea")
			or playerPlot:FindFirstChild("CenterPoint")
		if not anchorInst then
			return nil
		end
		local callOk, anchorCF = pcall(function()
			return anchorInst:IsA("Model") and anchorInst:GetPivot() or anchorInst.CFrame
		end)
		return callOk and anchorCF and anchorCF.Position or nil
	end

	local function ReadOwnerEggsMap()
		if not EggStateModule or type(EggStateModule.ReadOwnerEggs) ~= "function" then
			return nil
		end
		local callOk, ownerEggs = pcall(EggStateModule.ReadOwnerEggs, LocalPlayer.UserId)
		return (callOk and type(ownerEggs) == "table") and ownerEggs or nil
	end

	local function CountPlacedEggsAndOccupiedGrid()
		local ownerEggs = ReadOwnerEggsMap()
		local placedCount = 0
		local occupiedPoints = {}
		if ownerEggs then
			for _, eggData in pairs(ownerEggs) do
				if type(eggData) == "table" and eggData.Placement ~= nil then
					placedCount = placedCount + 1
					local localCF = type(eggData.Placement) == "table" and eggData.Placement.LocalCFrame or nil
					if typeof(localCF) == "CFrame" then
						table.insert(occupiedPoints, Vector2.new(localCF.Position.X, localCF.Position.Z))
					end
				end
			end
		end
		return placedCount, occupiedPoints
	end

	local function GetBackpackUidOrder()
		local slotMap = {}
		local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
		if not backpack then
			return slotMap
		end
		local orderIdx = 0
		for _, toolInst in ipairs(backpack:GetChildren()) do
			local toolUid = toolInst:GetAttribute("UID")
			if type(toolUid) == "string" then
				orderIdx = orderIdx + 1
				slotMap[toolUid] = orderIdx
			end
		end
		return slotMap
	end

	local function CollectPlaceableBagEggs()
		local ownerEggs = ReadOwnerEggsMap()
		if not ownerEggs then
			return {}
		end
		local backpackSlots = GetBackpackUidOrder()
		local nowClock = os.clock()
		local hasRarityFilter = next(FarmConfig.Place_SelectedRarities) ~= nil
		local hasEggFilter = next(FarmConfig.Place_SelectedEggs) ~= nil
		local minIncome = ToFiniteNumber(FarmConfig.Place_MinValue, 0)
		local candidates = {}

		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table" and eggData.Placement == nil and (PlaceState.FailedEggCooldowns[eggUid] or 0) <= nowClock then
				local categoryName = tostring(eggData.AssetCategory or "")
				local rarityName = select(1, ResolveEggRarity(eggData))
				local eggIncome = CalculateEggIncome(eggData)

				local passRarity = not hasRarityFilter or FarmConfig.Place_SelectedRarities[NormalizeRarityKey(rarityName)] == true
				local passEgg = not hasEggFilter or FarmConfig.Place_SelectedEggs[string.lower(categoryName)] == true
				local passValue = (minIncome <= 0) or (eggIncome >= minIncome)

				if passRarity and passEgg and passValue then
					local scaleVal = ToFiniteNumber(eggData.AssetScale, 0)
					table.insert(candidates, {
						Uid = tostring(eggUid),
						ScaleBucket = math.floor(scaleVal * 1000),
						IncomeBucket = math.floor(eggIncome),
						BackpackSlot = backpackSlots[eggUid] or 999999,
					})
				end
			end
		end

		local orderMode = FarmConfig.Place_Order
		table.sort(candidates, function(candA, candB)
			if orderMode == "Highest Value" and candA.IncomeBucket ~= candB.IncomeBucket then
				return candA.IncomeBucket > candB.IncomeBucket
			elseif orderMode == "Smallest Size" and candA.ScaleBucket ~= candB.ScaleBucket then
				return candA.ScaleBucket < candB.ScaleBucket
			elseif orderMode == "Backpack Order" and candA.BackpackSlot ~= candB.BackpackSlot then
				return candA.BackpackSlot < candB.BackpackSlot
			end
			if candA.ScaleBucket ~= candB.ScaleBucket then
				return candA.ScaleBucket > candB.ScaleBucket
			end
			if candA.IncomeBucket ~= candB.IncomeBucket then
				return candA.IncomeBucket > candB.IncomeBucket
			end
			return candA.Uid < candB.Uid
		end)
		return candidates
	end

	local function CanPlaceByRule(candidateCount)
		if candidateCount <= 0 or not FarmConfig.Place_AutoPlace then
			return false
		end
		local rule = FarmConfig.Place_Rule
		if rule == "Steal Idle" then
			return not IsAutoStealBusy()
		elseif rule == "After Steal" then
			return Engine.AutoCarry.LastFinishedAt > 0 and (os.clock() - Engine.AutoCarry.LastFinishedAt) <= 12
		elseif rule == "Night Only" then
			return Engine.IsNight() == true
		end
		return true
	end

	local function ResolvePlotPlacementBounds()
		local minX, maxX, minZ, maxZ, localY = -24, 8, 4, 30, -0.5
		pcall(function()
			local resolvedPlot = PlotStateModule and type(PlotStateModule.ResolvePlot) == "function" and PlotStateModule.ResolvePlot() or nil
			local playerPlot = not resolvedPlot and GetPlayerPlot() or nil
			local petArea = (resolvedPlot and resolvedPlot.PetArea) or (playerPlot and playerPlot:FindFirstChild("PetArea", true))
			local centerPoint = (resolvedPlot and resolvedPlot.CenterPoint) or (playerPlot and playerPlot:FindFirstChild("CenterPoint", true))
			if not (petArea and centerPoint and petArea:IsA("BasePart") and centerPoint:IsA("BasePart")) then
				return
			end
			local loX, hiX, loZ, hiZ, topY = math.huge, -math.huge, math.huge, -math.huge, nil
			for _, signX in ipairs({ -1, 1 }) do
				for _, signZ in ipairs({ -1, 1 }) do
					local worldCorner = petArea.CFrame * Vector3.new(signX * petArea.Size.X * 0.5, petArea.Size.Y * 0.5, signZ * petArea.Size.Z * 0.5)
					local relPoint = centerPoint.CFrame:PointToObjectSpace(worldCorner)
					loX, hiX = math.min(loX, relPoint.X), math.max(hiX, relPoint.X)
					loZ, hiZ = math.min(loZ, relPoint.Z), math.max(hiZ, relPoint.Z)
					topY = relPoint.Y
				end
			end
			if (hiX - loX) > 5 and (hiZ - loZ) > 5 then
				minX, maxX = loX + 2.5, hiX - 2.5
				minZ, maxZ = loZ + 2.5, hiZ - 2.5
				localY = topY or localY
			end
		end)
		return minX, maxX, minZ, maxZ, localY
	end

	local function BuildFreePlacementGrid(occupiedPoints)
		local minX, maxX, minZ, maxZ, localY = ResolvePlotPlacementBounds()
		local scoredCells = {}
		local startX = math.ceil(minX / GRID_SPACING) * GRID_SPACING
		local startZ = math.ceil(minZ / GRID_SPACING) * GRID_SPACING
		for gridX = startX, maxX, GRID_SPACING do
			for gridZ = startZ, maxZ, GRID_SPACING do
				local cell2D = Vector2.new(gridX, gridZ)
				local isFree = true
				for _, used2D in ipairs(occupiedPoints) do
					if (used2D - cell2D).Magnitude < MIN_EGG_SEPARATION then
						isFree = false
						break
					end
				end
				if isFree then
					table.insert(scoredCells, {
						Frame = CFrame.new(gridX, localY, gridZ),
						Score = (cell2D - PREFERRED_GRID_ANCHOR).Magnitude + placeRng:NextNumber() * 2,
					})
				end
			end
		end
		table.sort(scoredCells, function(cellA, cellB)
			return cellA.Score < cellB.Score
		end)
		local framesOut = {}
		for idx, cellEntry in ipairs(scoredCells) do
			framesOut[idx] = cellEntry.Frame
		end
		return framesOut
	end

	local function EquipEggToolByUid(eggUid)
		if EggStateModule and type(EggStateModule.WearEggTool) == "function" then
			local callOk, wearRes = pcall(EggStateModule.WearEggTool, eggUid)
			if callOk and wearRes == false then
				return false
			end
		end
		local equipDeadline = os.clock() + 2.0
		local triedBackpackFallback = false
		while os.clock() < equipDeadline do
			local character = LocalPlayer.Character
			local heldTool = character and character:FindFirstChildOfClass("Tool")
			if heldTool and heldTool:GetAttribute("UID") == eggUid then
				return true
			end
			if not triedBackpackFallback and os.clock() > (equipDeadline - 1.3) then
				triedBackpackFallback = true
				local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if backpack and humanoid then
					for _, toolInst in ipairs(backpack:GetChildren()) do
						if toolInst:IsA("Tool") and toolInst:GetAttribute("UID") == eggUid then
							pcall(humanoid.EquipTool, humanoid, toolInst)
							break
						end
					end
				end
			end
			task.wait(0.05)
		end
		return false
	end

	local function RunAutoPlacePass(expectedGen)
		if Engine.IsInExternalMapOrEvent() or not EggStateModule then
			return false
		end
		local candidates = CollectPlaceableBagEggs()
		if not CanPlaceByRule(#candidates) then
			return false
		end
		local placedCount, occupiedPoints = CountPlacedEggsAndOccupiedGrid()
		local openSlots = MAX_PLOT_PLACED_EGGS - placedCount
		if openSlots <= 0 then
			return false
		end
		local penAnchor = GetPenAnchorPosition()
		if not penAnchor then
			return false
		end

		Engine.Movement.PlaceWanted = true
		if not Engine.ClaimMovement("place") then
			return "waiting"
		end

		local function shouldAbortPlace()
			if expectedGen ~= PlaceState.Gen or not FarmConfig.Place_AutoPlace or Engine.IsInExternalMapOrEvent() then
				return true
			end
			if FarmConfig.Place_Rule == "Night Only" and not Engine.IsNight() then
				return true
			end
			return false
		end

		if TreadmillState.Riding or IsPlayerOnBelt() then
			ExitTreadmillBelt()
		end

		local function flyToPenProtected()
			HoldTreadmillBelt()
			local flyOk, reached = pcall(FlyInsideBaseTo, penAnchor, shouldAbortPlace)
			ReleaseTreadmillBelt()
			return flyOk and reached == true
		end

		local rootPart = Engine.Root()
		if not rootPart or (rootPart.Position - penAnchor).Magnitude > PEN_REACH_DIST then
			if not flyToPenProtected() then
				LeaveTreadmillRemote()
				PlaceState.CooldownUntil = os.clock() + 6
				return false
			end
		end
		LeaveTreadmillRemote()
		if shouldAbortPlace() then
			return false
		end

		local plantedThisPass = 0
		local consecutiveRejects = 0
		for _, candidate in ipairs(candidates) do
			if plantedThisPass >= openSlots or shouldAbortPlace() then
				break
			end
			local curRoot = Engine.Root()
			if not curRoot or (curRoot.Position - penAnchor).Magnitude > PEN_REACH_DIST then
				if not flyToPenProtected() then
					break
				end
			end

			if EquipEggToolByUid(candidate.Uid) then
				task.wait(0.1)
				local tries = 0
				local plantedOne = false
				for _, slotCFrame in ipairs(BuildFreePlacementGrid(occupiedPoints)) do
					if shouldAbortPlace() or tries >= 8 then
						break
					end
					tries = tries + 1
					local invokeOk, invokeRes = InvokeProgressionRemote("RF/EggWorld/AskPlaceEgg", {
						Uid = candidate.Uid,
						LocalCFrame = slotCFrame,
					})
					if invokeOk and invokeRes ~= false then
						table.insert(occupiedPoints, Vector2.new(slotCFrame.Position.X, slotCFrame.Position.Z))
						plantedThisPass = plantedThisPass + 1
						plantedOne = true
						break
					end
				end
				if plantedOne then
					consecutiveRejects = 0
				else
					PlaceState.FailedEggCooldowns[candidate.Uid] = os.clock() + 60
					consecutiveRejects = consecutiveRejects + 1
					if consecutiveRejects >= 2 then
						break
					end
				end
			else
				PlaceState.FailedEggCooldowns[candidate.Uid] = os.clock() + 20
			end
		end

		if EggStateModule and type(EggStateModule.DoffEggTool) == "function" then
			pcall(EggStateModule.DoffEggTool)
		end
		if plantedThisPass == 0 then
			PlaceState.CooldownUntil = os.clock() + 6
		end
		return plantedThisPass > 0
	end

	function PlaceState.Restart()
		table.clear(PlaceState.FailedEggCooldowns)
		PlaceState.CooldownUntil = 0
		PlaceState.Gen = PlaceState.Gen + 1
		Progression.Wake()
	end

	AddWorker(function()
		local placedNow = select(1, CountPlacedEggsAndOccupiedGrid())
		if PlaceState.LastPlacedCount ~= nil and placedNow < PlaceState.LastPlacedCount then
			table.clear(PlaceState.FailedEggCooldowns)
		end
		PlaceState.LastPlacedCount = placedNow

		if not FarmConfig.Place_AutoPlace then
			Engine.Movement.PlaceWanted = false
			Engine.ReleaseMovement("place")
			return false
		end
		if PlaceState.Busy or Engine.IsInExternalMapOrEvent() then
			return false
		end
		if os.clock() < PlaceState.CooldownUntil then
			Engine.Movement.PlaceWanted = false
			return false
		end

		PlaceState.Busy = true
		local myGen = PlaceState.Gen
		task.spawn(function()
			local passOk, passResult = pcall(RunAutoPlacePass, myGen)
			if not (passOk and passResult == "waiting") then
				Engine.Movement.PlaceWanted = false
			end
			Engine.ReleaseMovement("place")
			PlaceState.Busy = false
			if Engine.AutoWake then
				pcall(Engine.AutoWake)
			end
			Progression.Wake()
		end)
		return false
	end)

	pcall(function()
		LibraryLoader:OnUnload(ResetTreadmillBeltHold)
	end)

	local function HasItemMutation(itemData)
		if type(itemData.Mutations) == "table" and next(itemData.Mutations) ~= nil then
			return true
		end
		return itemData.Mutation ~= nil and tostring(itemData.Mutation) ~= ""
	end

	local function ReadEggMutationSet(eggData)
		local mutSet = {}
		local baseMut = eggData.BaseMutation
		if type(baseMut) == "string" and baseMut ~= "" and baseMut ~= "Normal" then
			mutSet[baseMut] = true
		end
		local rawMuts = eggData.Mutations
		if type(rawMuts) == "table" then
			for mutKey, mutVal in pairs(rawMuts) do
				if type(mutVal) == "string" and mutVal ~= "" then
					mutSet[mutVal] = true
				elseif type(mutVal) == "table" then
					local subId = mutVal.Id or mutVal.Name or mutVal.Label
					if type(subId) == "string" and subId ~= "" then
						mutSet[subId] = true
					end
				elseif type(mutKey) == "string" and mutVal ~= false then
					mutSet[mutKey] = true
				end
			end
		elseif type(rawMuts) == "string" then
			for token in string.gmatch(rawMuts, "[^,]+") do
				local trimmed = string.gsub(string.gsub(token, "^%s+", ""), "%s+$", "")
				if trimmed ~= "" then
					mutSet[trimmed] = true
				end
			end
		end
		mutSet.Normal = nil
		return mutSet
	end

	-- 5F. Auto Hatch & Auto Equip (100% Chilli Mechanics L24446-24914)
	do
	local HatchState = {
		Busy = false,
		Gen = 0,
		FailedEggCooldowns = {},
	}
	Hub.AutoHatch = HatchState

	local MAX_HATCH_PER_PASS = 4
	local HATCH_FAIL_COOLDOWN = 10

	local function PassesHatchFilters(eggData)
		local minRarity = ToFiniteNumber(FarmConfig.Hatch_MinRarityRank, 0)
		if minRarity > 0 then
			local _, eggRarityRank = ResolveEggRarity(eggData)
			if ToFiniteNumber(eggRarityRank, 0) < minRarity then
				return false
			end
		end
		local minIncome = ToFiniteNumber(FarmConfig.Hatch_MinValue, 0)
		if minIncome > 0 and CalculateEggIncome(eggData) < minIncome then
			return false
		end
		if next(FarmConfig.Hatch_SelectedEggs) ~= nil then
			local categoryLower = string.lower(tostring(eggData.AssetCategory or ""))
			if FarmConfig.Hatch_SelectedEggs[categoryLower] ~= true then
				return false
			end
		end
		return true
	end

	local function CollectReadyToHatchUids()
		if not EggStateModule or type(EggStateModule.IsReadyToHatch) ~= "function" then
			return {}
		end
		local ownerEggs = ReadOwnerEggsMap()
		if not ownerEggs then
			return {}
		end
		local nowClock = os.clock()
		local readyUids = {}
		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table" and eggData.Placement ~= nil and (HatchState.FailedEggCooldowns[eggUid] or 0) <= nowClock then
				local readyOk, isReady = pcall(EggStateModule.IsReadyToHatch, eggUid)
				if readyOk and isReady == true and PassesHatchFilters(eggData) then
					table.insert(readyUids, tostring(eggUid))
				end
			end
		end
		table.sort(readyUids)
		return readyUids
	end

	local function RunAutoHatchPass(expectedGen)
		local readyUids = CollectReadyToHatchUids()
		local hatchedCount = 0
		for _, eggUid in ipairs(readyUids) do
			if hatchedCount >= MAX_HATCH_PER_PASS or expectedGen ~= HatchState.Gen or not FarmConfig.Hatch_AutoHatch then
				break
			end
			local hatchOk, hatchRes = InvokeProgressionRemote("RF/EggWorld/AskHatch", eggUid)
			if hatchOk and hatchRes ~= false then
				task.wait(0.35)
				InvokeProgressionRemote("RF/EggWorld/AskFinishHatch", eggUid)
				hatchedCount = hatchedCount + 1
				HatchState.FailedEggCooldowns[eggUid] = nil
			else
				HatchState.FailedEggCooldowns[eggUid] = os.clock() + HATCH_FAIL_COOLDOWN
			end
			task.wait(0.2)
		end
		return hatchedCount > 0
	end

	function HatchState.Restart()
		HatchState.Gen = HatchState.Gen + 1
		table.clear(HatchState.FailedEggCooldowns)
		Progression.Wake()
	end

	AddWorker(function()
		if not FarmConfig.Hatch_AutoHatch or HatchState.Busy then
			return false
		end
		HatchState.Busy = true
		local myGen = HatchState.Gen
		task.spawn(function()
			local runOk, didHatch = pcall(RunAutoHatchPass, myGen)
			HatchState.Busy = false
			if runOk and didHatch then
				Progression.Wake()
			end
		end)
		return false
	end)

	-- Auto Equip Best Pet Worker (Chilli L24716-24914)
	local EquipState = {
		Busy = false,
		Gen = 0,
		ForceCheck = true,
		NextAllowedAt = 0,
		AttemptedUids = {},
		CachedCapacity = nil,
		CapacityFetchedAt = -math.huge,
	}
	Hub.AutoEquip = EquipState

	local EQUIP_COOLDOWN_SEC = 5
	local CAPACITY_CACHE_TTL = 30

	if type(SaveModule) == "table" then
		local signalFactory = (type(SaveModule.FieldSignal) == "function" and SaveModule.FieldSignal)
			or (type(SaveModule.Watch) == "function" and SaveModule.Watch)
		if signalFactory then
			for _, equipField in ipairs({ "Inventory", "EquippedAssets" }) do
				local callOk, fieldSig = pcall(signalFactory, equipField)
				if callOk and fieldSig and type(fieldSig.Connect) == "function" then
					local connOk, sigConn = pcall(fieldSig.Connect, fieldSig, function()
						EquipState.ForceCheck = true
						Progression.Wake()
					end)
					if connOk and sigConn then
						Hub.Lifecycle.TrackConnection(sigConn)
					end
				end
			end
		end
	end

	local function ResolvePetEquipCapacity(saveData)
		if type(BasesModule) == "table" and type(BasesModule.GetAssetEquipCapacity) == "function" then
			local baseLvl = saveData and tonumber(saveData.BaseUpgradeLevel) or 0
			local callOk, capVal = pcall(BasesModule.GetAssetEquipCapacity, baseLvl)
			if callOk and tonumber(capVal) then
				return math.floor(tonumber(capVal))
			end
		end
		if EquipState.CachedCapacity and (os.clock() - EquipState.CapacityFetchedAt) < CAPACITY_CACHE_TTL then
			return EquipState.CachedCapacity
		end
		local invokeOk, remoteLimit = InvokeProgressionRemote("RF/PenRoster/AskWearLimit")
		if invokeOk and tonumber(remoteLimit) then
			EquipState.CachedCapacity = math.floor(tonumber(remoteLimit))
			EquipState.CapacityFetchedAt = os.clock()
			return EquipState.CachedCapacity
		end
		return EquipState.CachedCapacity or 0
	end

	local function CollectSortedOwnedPets()
		local saveData = ReadSaveData()
		if not saveData then
			return nil, nil
		end
		local equippedSet = {}
		for _, petUid in pairs(saveData.EquippedAssets or {}) do
			if type(petUid) == "string" then
				equippedSet[petUid] = true
			end
		end
		local ownedList = {}
		for petUid, petData in pairs(saveData.Inventory or {}) do
			if type(petData) == "table" and petData.InFuse ~= true then
				local incomeVal = CalculateEggIncome(petData)
				table.insert(ownedList, {
					Uid = tostring(petUid),
					IncomeBucket = math.floor(incomeVal * 100),
					Equipped = equippedSet[petUid] == true,
				})
			end
		end
		table.sort(ownedList, function(petA, petB)
			if petA.IncomeBucket ~= petB.IncomeBucket then
				return petA.IncomeBucket > petB.IncomeBucket
			end
			return petA.Uid < petB.Uid
		end)
		return ownedList, saveData
	end

	function EquipState.Restart()
		EquipState.Gen = EquipState.Gen + 1
		table.clear(EquipState.AttemptedUids)
		EquipState.NextAllowedAt = 0
		EquipState.ForceCheck = true
		Progression.Wake()
	end

	AddWorker(function()
		if not FarmConfig.Hatch_AutoEquip or EquipState.Busy then
			return false
		end
		local sortedPets, saveData = CollectSortedOwnedPets()
		if not sortedPets then
			return false
		end
		local equipCapacity = ResolvePetEquipCapacity(saveData)
		local missingBestUids = {}
		local hasFreshCandidate = false
		for idx, petEntry in ipairs(sortedPets) do
			if idx > equipCapacity then
				break
			end
			if not petEntry.Equipped then
				table.insert(missingBestUids, petEntry.Uid)
				if not EquipState.AttemptedUids[petEntry.Uid] then
					hasFreshCandidate = true
				end
			end
		end

		local nowClock = os.clock()
		if (hasFreshCandidate or EquipState.ForceCheck) and nowClock >= EquipState.NextAllowedAt then
			for _, petUid in ipairs(missingBestUids) do
				EquipState.AttemptedUids[petUid] = true
			end
			EquipState.ForceCheck = false
			EquipState.Busy = true
			EquipState.NextAllowedAt = nowClock + EQUIP_COOLDOWN_SEC
			local myGen = EquipState.Gen

			task.spawn(function()
				local statusAllowed = true
				local statusRemote = ResolveRemote("RF/Haul/FetchWearBestStatus")
				if statusRemote and statusRemote:IsA("RemoteFunction") then
					local statusOk, statusRes = pcall(statusRemote.InvokeServer, statusRemote)
					statusAllowed = statusOk and statusRes ~= false and statusRes ~= nil
				end
				if statusAllowed and myGen == EquipState.Gen and FarmConfig.Hatch_AutoEquip then
					InvokeProgressionRemote("RF/Haul/WearBest")
				end
				EquipState.Busy = false
				Progression.Wake()
			end)
		end
		return false
	end)
	end

	-- 5G. Auto Sell Pets & Eggs (Chilli Batch Engine + Custom Multi-Rarity Selection)
	do
	local SellState = {
		Busy = false,
		NextAutoAt = 0,
	}
	Hub.AutoSell = SellState

	local SELL_BATCH_LIMIT = 50
	local SELL_AUTO_COOLDOWN = 3.0

	local function PassesSellRule(ruleMode, rarityMatched, valueMatched)
		if ruleMode == "Value Only" then
			return valueMatched
		elseif ruleMode == "Rarity And Value" then
			return rarityMatched and valueMatched
		elseif ruleMode == "Rarity Or Value" then
			return rarityMatched or valueMatched
		end
		return rarityMatched
	end

	function SellState.CollectSellablePets()
		local saveData = ReadSaveData()
		local matchedUids = {}
		if not saveData then
			return matchedUids
		end
		local equippedSet = {}
		for _, equippedUid in pairs(saveData.EquippedAssets or {}) do
			if type(equippedUid) == "string" then
				equippedSet[equippedUid] = true
			end
		end

		local hasPickedRarities = next(FarmConfig.Sell_PetRarities) ~= nil
		local maxIncomeLimit = ToFiniteNumber(FarmConfig.Sell_PetValue, 0)

		for petUid, petData in pairs(saveData.Inventory or {}) do
			if type(petData) == "table"
				and petData.InFuse ~= true
				and petData.IsFavorite ~= true
				and petData.Favorite ~= true
				and petData.Locked ~= true
				and not equippedSet[petUid]
			then
				local categoryLower = string.lower(tostring(petData.Category or petData.AssetCategory or ""))
				if not FarmConfig.Sell_PetBlacklist[categoryLower] then
					if not (FarmConfig.Sell_KeepMutatedPets and HasItemMutation(petData)) then
						local rarityName = select(1, ResolveEggRarity(petData))
						local rarityMatched = hasPickedRarities
							and FarmConfig.Sell_PetRarities[NormalizeRarityKey(rarityName)] == true
						local valueMatched = (maxIncomeLimit > 0) and (CalculateEggIncome(petData) < maxIncomeLimit)

						if PassesSellRule(FarmConfig.Sell_PetRule, rarityMatched, valueMatched) then
							table.insert(matchedUids, tostring(petUid))
						end
					end
				end
			end
		end
		table.sort(matchedUids)
		return matchedUids
	end

	function SellState.CollectSellableEggs()
		local ownerEggs = ReadOwnerEggsMap()
		local matchedUids = {}
		if not ownerEggs then
			return matchedUids
		end
		local character = LocalPlayer.Character
		local heldTool = character and character:FindFirstChildWhichIsA("Tool")
		local heldToolUid = heldTool and heldTool:GetAttribute("UID") or nil

		local hasPickedRarities = next(FarmConfig.Sell_EggRarities) ~= nil
		local maxIncomeLimit = ToFiniteNumber(FarmConfig.Sell_EggValue, 0)

		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table"
				and eggData.Placement == nil
				and eggUid ~= heldToolUid
				and eggData.EggSkin == nil
				and eggData.IsFavorite ~= true
				and eggData.Locked ~= true
			then
				local categoryLower = string.lower(tostring(eggData.AssetCategory or eggData.Category or ""))
				if not FarmConfig.Sell_EggBlacklist[categoryLower] then
					if not (FarmConfig.Sell_KeepMutatedEggs and HasItemMutation(eggData)) then
						local rarityName = select(1, ResolveEggRarity(eggData))
						local rarityMatched = hasPickedRarities
							and FarmConfig.Sell_EggRarities[NormalizeRarityKey(rarityName)] == true
						local valueMatched = (maxIncomeLimit > 0) and (CalculateEggIncome(eggData) < maxIncomeLimit)

						if PassesSellRule(FarmConfig.Sell_EggRule, rarityMatched, valueMatched) then
							table.insert(matchedUids, tostring(eggUid))
						end
					end
				end
			end
		end
		table.sort(matchedUids)
		return matchedUids
	end

	local function DispatchSellBatches(petUidList, eggUidList)
		local sellRemote = ResolveRemote("RE/PetSatchel/SellSelection")
		if not sellRemote or not sellRemote:IsA("RemoteEvent") then
			return false
		end
		local totalLen = math.max(#petUidList, #eggUidList)
		local cursor = 1
		while cursor <= totalLen do
			local petSlice, eggSlice = {}, {}
			for idx = cursor, cursor + SELL_BATCH_LIMIT - 1 do
				if petUidList[idx] then
					table.insert(petSlice, petUidList[idx])
				end
				if eggUidList[idx] then
					table.insert(eggSlice, eggUidList[idx])
				end
			end
			pcall(sellRemote.FireServer, sellRemote, {
				Eggs = eggSlice,
				Assets = petSlice,
			})
			cursor = cursor + SELL_BATCH_LIMIT
			if cursor <= totalLen then
				task.wait(0.3)
			end
		end
		return true
	end

	function SellState.ExecuteNow(petUidList, eggUidList)
		if SellState.Busy or (#petUidList == 0 and #eggUidList == 0) then
			return
		end
		SellState.Busy = true
		SellState.NextAutoAt = os.clock() + SELL_AUTO_COOLDOWN
		task.spawn(function()
			pcall(DispatchSellBatches, petUidList, eggUidList)
			SellState.Busy = false
			Progression.Wake()
		end)
	end

	function SellState.Wake()
		SellState.NextAutoAt = 0
		Progression.Wake()
	end

	AddWorker(function()
		if SellState.Busy or os.clock() < SellState.NextAutoAt then
			return false
		end
		if not FarmConfig.Sell_AutoPets and not FarmConfig.Sell_AutoEggs then
			return false
		end
		local petsToSell = FarmConfig.Sell_AutoPets and SellState.CollectSellablePets() or {}
		local eggsToSell = FarmConfig.Sell_AutoEggs and SellState.CollectSellableEggs() or {}
		if #petsToSell > 0 or #eggsToSell > 0 then
			SellState.ExecuteNow(petsToSell, eggsToSell)
		end
		return false
	end)
	end

	-- 5H. Auto Mutation / Essence Consumables (100% Chilli Mechanics L28285-28995)
	do
	local MutateState = {
		LoopId = 0,
		Busy = false,
		ManualRunning = false,
		Status = "Off",
		Detail = "",
		CooldownUntil = 0,
		LockedUid = nil,
		RefusedUntil = {},
		ConsecutiveFails = 0,
	}
	Hub.AutoMutate = MutateState

	local MUTATE_REACH_DIST = 6
	local MUTATE_STEP_DELAY = 1.0

	function MutateState.GetDisplayStatus()
		if not FarmConfig.Mutate_Auto and not MutateState.ManualRunning then
			return "Off"
		end
		if MutateState.Detail ~= "" then
			return MutateState.Status .. "  |  " .. MutateState.Detail
		end
		return MutateState.Status
	end

	local function CollectPlacedOwnerEggsList()
		local ownerEggs = ReadOwnerEggsMap()
		local placedList = {}
		if not ownerEggs then
			return placedList
		end
		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table" and eggData.Placement ~= nil then
				eggData.Uid = eggData.Uid or tostring(eggUid)
				table.insert(placedList, eggData)
			end
		end
		return placedList
	end

	local function FindPlacedEggByUid(targetUid)
		for _, eggData in ipairs(CollectPlacedOwnerEggsList()) do
			if eggData.Uid == targetUid then
				return eggData
			end
		end
		return nil
	end

	local function ScanBagMutationConsumables()
		local foundById = {}
		local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
		for _, container in ipairs(containers) do
			if container then
				for _, childInst in ipairs(container:GetChildren()) do
					if childInst:IsA("Tool") and tostring(childInst:GetAttribute("ItemType")) == "MutationConsumable" then
						local mutId = tostring(childInst:GetAttribute("MutationId") or childInst:GetAttribute("MutationTemplate") or "Boss")
						local usesCount = tonumber(childInst:GetAttribute("Uses"))
							or tonumber(string.match(childInst.Name, "%[X(%d+)%]"))
							or 1
						if usesCount > 0 then
							if foundById[mutId] then
								foundById[mutId].Uses = foundById[mutId].Uses + usesCount
							else
								foundById[mutId] = { Tool = childInst, Uses = usesCount }
							end
						end
					end
				end
			end
		end
		return foundById
	end

	local function CountPickedConsumableUses(bagConsumables)
		local totalUses = 0
		for _, specItem in ipairs(MutateConsumableSpecs) do
			if FarmConfig.Mutate_Use[specItem.Id] and bagConsumables[specItem.Id] then
				totalUses = totalUses + bagConsumables[specItem.Id].Uses
			end
		end
		return totalUses
	end

	local function FormatMutateEggSummary(eggData)
		local categoryName = tostring(eggData.AssetCategory or "Egg")
		local cachedInfo = AssetInfoByLowerName[string.lower(categoryName)]
		local displayName = (cachedInfo and cachedInfo.Name) or categoryName
		return string.format("%s %.2f kg", displayName, GetEggWeightKg(eggData))
	end

	local function PickBestEggToMutate(bagConsumables)
		local nowClock = os.clock()
		local minRarity = ToFiniteNumber(FarmConfig.Mutate_MinRarityRank, 0)
		local minIncome = ToFiniteNumber(FarmConfig.Mutate_MinValue, 0)
		local priorityMode = FarmConfig.Mutate_Priority

		local bestScore = -1
		local bestEgg, bestSpec = nil, nil

		for _, eggData in ipairs(CollectPlacedOwnerEggsList()) do
			local _, rarityRank = ResolveEggRarity(eggData)
			local eggIncome = CalculateEggIncome(eggData)
			local passesRarity = (minRarity <= 0) or (ToFiniteNumber(rarityRank, 0) >= minRarity)
			local passesValue = (minIncome <= 0) or (eggIncome >= minIncome)

			if passesRarity and passesValue then
				local existingMuts = ReadEggMutationSet(eggData)
				local chosenSpec = nil
				for _, specItem in ipairs(MutateConsumableSpecs) do
					if FarmConfig.Mutate_Use[specItem.Id]
						and bagConsumables[specItem.Id]
						and existingMuts[specItem.Id] ~= true
						and (MutateState.RefusedUntil[tostring(eggData.Uid) .. ":" .. specItem.Id] or 0) <= nowClock
					then
						chosenSpec = specItem
						break
					end
				end

				if chosenSpec then
					local scaleVal = ToFiniteNumber(eggData.AssetScale, 0)
					local candidateScore = eggIncome
					if priorityMode == "Best Rarity" then
						candidateScore = ToFiniteNumber(rarityRank, 0) * 1000 + scaleVal
					elseif priorityMode == "Biggest Size" then
						candidateScore = scaleVal
					end

					if candidateScore > bestScore or (candidateScore == bestScore and eggData.Uid == MutateState.LockedUid) then
						bestScore = candidateScore
						bestEgg = eggData
						bestSpec = chosenSpec
					end
				end
			end
		end
		return bestEgg, bestSpec
	end

	local function ResolvePlacedEggWorldPos(eggData)
		local eggUid = eggData and eggData.Uid
		if eggUid then
			local slotsFolder = Workspace:FindFirstChild("AreaEggSlotsClient")
			local slotModel = slotsFolder and slotsFolder:FindFirstChild(tostring(eggUid))
			if slotModel then
				local callOk, pivotPos = pcall(function()
					return slotModel:GetPivot().Position
				end)
				if callOk and typeof(pivotPos) == "Vector3" then
					return pivotPos
				end
			end
		end
		local placementTbl = eggData and type(eggData.Placement) == "table" and eggData.Placement or nil
		if placementTbl and typeof(placementTbl.LocalCFrame) == "CFrame" then
			local playerPlot = GetPlayerPlot()
			local centerPoint = playerPlot and playerPlot:FindFirstChild("CenterPoint", true)
			if centerPoint and centerPoint:IsA("BasePart") then
				return centerPoint.CFrame:PointToWorldSpace(placementTbl.LocalCFrame.Position)
			end
		end
		return GetPenAnchorPosition()
	end

	local function GetMutatePriorityBlocker()
		if Engine.IsInExternalMapOrEvent() then
			return "Paused (In Event / Other Map)"
		end
		if Engine.Movement.PlaceWanted then
			return "Auto Place goes first"
		end
		if IsAutoStealBusy() then
			return "Auto Steal goes first"
		end
		return nil
	end

	local function EquipConsumableTool(toolInst)
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not character or not humanoid or not toolInst or toolInst.Parent == nil then
			return false
		end
		if toolInst.Parent ~= character then
			pcall(humanoid.EquipTool, humanoid, toolInst)
			if toolInst.Parent ~= character then
				pcall(function()
					toolInst.Parent = character
				end)
			end
			task.wait(0.3)
		end
		return toolInst.Parent == character
	end

	local function WaitMutateStep(durationSec, shouldStopFn, earlyDoneFn)
		local deadline = os.clock() + math.max(0, tonumber(durationSec) or 0)
		while os.clock() < deadline do
			if shouldStopFn() or (earlyDoneFn and earlyDoneFn()) then
				return
			end
			task.wait(0.1)
		end
	end

	local function ReachPlacedEggForMutate(eggData, shouldStopFn)
		local eggWorldPos = ResolvePlacedEggWorldPos(eggData)
		local rootPart = Engine.Root()
		if not eggWorldPos or not rootPart then
			return eggWorldPos == nil
		end
		if (rootPart.Position - eggWorldPos).Magnitude <= MUTATE_REACH_DIST then
			return true
		end
		if TreadmillState.Riding or IsPlayerOnBelt() then
			ExitTreadmillBelt()
		end
		HoldTreadmillBelt()
		local flyOk, arrived = pcall(FlyInsideBaseTo, eggWorldPos, shouldStopFn)
		ReleaseTreadmillBelt()
		LeaveTreadmillRemote()
		local afterRoot = Engine.Root()
		return flyOk and arrived == true and afterRoot ~= nil and (afterRoot.Position - eggWorldPos).Magnitude <= (MUTATE_REACH_DIST + 6)
	end

	local function ApplyConsumableToPlacedEgg(eggData, specItem, toolInst, shouldStopFn)
		if not EquipConsumableTool(toolInst) then
			MutateState.Status = "Could not hold " .. specItem.Label
			MutateState.CooldownUntil = os.clock() + 2
			return false
		end
		local useRemote = ResolveRemote("RF/BossMastery/AskUseMutationConsumable")
		if not useRemote or not useRemote:IsA("RemoteFunction") then
			MutateState.Status = "Mutation remote is missing"
			MutateState.CooldownUntil = os.clock() + 10
			return false
		end

		MutateState.Status = "Applying"
		local startAt = os.clock()
		local callOk, response = pcall(useRemote.InvokeServer, useRemote, eggData.Uid)
		if not callOk or type(response) ~= "table" then
			MutateState.Status = "No answer from the server"
			MutateState.CooldownUntil = os.clock() + 10
			return false
		end

		MutateState.LockedUid = nil
		if response.Success == true then
			MutateState.ConsecutiveFails = 0
			if response.Mutated == true then
				MutateState.Status = "Applied"
				WaitMutateStep(3.0, shouldStopFn, function()
					local refreshed = FindPlacedEggByUid(eggData.Uid)
					return refreshed == nil or ReadEggMutationSet(refreshed)[specItem.Id] == true
				end)
			else
				MutateState.Status = "Roll failed"
			end
			WaitMutateStep(MUTATE_STEP_DELAY - (os.clock() - startAt), shouldStopFn)
			return true
		end

		local serverMsg = tostring(response.Message or "")
		MutateState.Status = (serverMsg ~= "") and serverMsg or "The server refused it"
		MutateState.RefusedUntil[tostring(eggData.Uid) .. ":" .. specItem.Id] = os.clock() + 120
		MutateState.ConsecutiveFails = MutateState.ConsecutiveFails + 1
		if MutateState.ConsecutiveFails >= 3 then
			MutateState.ConsecutiveFails = 0
			MutateState.CooldownUntil = os.clock() + 15
			return false
		end
		WaitMutateStep(1.0, shouldStopFn)
		return true
	end

	local function RunMutationCycle(expectedLoopId, isManualOnce)
		if not isManualOnce and os.clock() < MutateState.CooldownUntil then
			return
		end
		if next(FarmConfig.Mutate_Use) == nil then
			MutateState.Status = "Pick at least one mutation in Mutation To Use"
			MutateState.Detail = ""
			MutateState.CooldownUntil = os.clock() + 5
			return
		end

		local bagConsumables = ScanBagMutationConsumables()
		local remainingUses = CountPickedConsumableUses(bagConsumables)
		if remainingUses <= 0 then
			MutateState.Status = "No consumables in your bag"
			MutateState.Detail = ""
			MutateState.CooldownUntil = os.clock() + 5
			return
		end

		local firstEgg = PickBestEggToMutate(bagConsumables)
		if not firstEgg or not firstEgg.Uid then
			MutateState.Status = "Waiting"
			MutateState.Detail = "No egg to mutate"
			MutateState.CooldownUntil = os.clock() + 5
			return
		end

		MutateState.Detail = FormatMutateEggSummary(firstEgg)
		local blockerReason = GetMutatePriorityBlocker()
		if blockerReason then
			MutateState.Status = blockerReason
			MutateState.CooldownUntil = os.clock() + 2
			return
		end

		if not Engine.ClaimMovement("essence") then
			MutateState.Status = "Waiting for " .. tostring(Engine.Movement.Owner or "movement")
			MutateState.CooldownUntil = os.clock() + 2
			return
		end
		Engine.Movement.EssenceWanted = true

		local function shouldStopCycle()
			if expectedLoopId ~= MutateState.LoopId then
				return true
			end
			if not isManualOnce and not FarmConfig.Mutate_Auto then
				return true
			end
			return GetMutatePriorityBlocker() ~= nil
		end

		local runOk, runErr = pcall(function()
			while not shouldStopCycle() do
				local liveBag = ScanBagMutationConsumables()
				local liveUses = CountPickedConsumableUses(liveBag)
				local targetEgg, targetSpec = PickBestEggToMutate(liveBag)
				if not targetEgg or not targetEgg.Uid or not targetSpec or not liveBag[targetSpec.Id] then
					MutateState.Status = "Waiting"
					MutateState.Detail = (liveUses > 0) and "No egg to mutate" or "Out of consumables"
					break
				end

				MutateState.LockedUid = targetEgg.Uid
				MutateState.Detail = targetSpec.Label .. " -> " .. FormatMutateEggSummary(targetEgg)

				if not ReachPlacedEggForMutate(targetEgg, shouldStopCycle) then
					MutateState.Status = "Could not reach the egg"
					MutateState.CooldownUntil = os.clock() + 3
					break
				end
				if shouldStopCycle() then
					break
				end
				local appliedContinue = ApplyConsumableToPlacedEgg(targetEgg, targetSpec, liveBag[targetSpec.Id].Tool, shouldStopCycle)
				if isManualOnce or not appliedContinue then
					break
				end
			end
		end)

		if not runOk then
			MutateState.Status = "Stopped: " .. tostring(runErr)
			MutateState.CooldownUntil = os.clock() + 3
		end

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			pcall(humanoid.UnequipTools, humanoid)
		end
		Engine.Movement.EssenceWanted = false
		Engine.ReleaseMovement("essence")
		if Engine.AutoWake then
			pcall(Engine.AutoWake)
		end
		Progression.Wake()
	end

	function MutateState.SetAutoEnabled(isEnabled)
		MutateState.LoopId = MutateState.LoopId + 1
		MutateState.CooldownUntil = 0
		Engine.Movement.EssenceWanted = false
		Engine.ReleaseMovement("essence")
		if not isEnabled then
			MutateState.Status = "Off"
			MutateState.Detail = ""
			return
		end
		local activeLoopId = MutateState.LoopId
		task.spawn(function()
			while Hub.Alive and not Engine.Disposed and activeLoopId == MutateState.LoopId and FarmConfig.Mutate_Auto do
				if not MutateState.Busy then
					MutateState.Busy = true
					pcall(RunMutationCycle, activeLoopId, false)
					MutateState.Busy = false
				end
				task.wait(1.0)
			end
		end)
	end

	function MutateState.RunOnceNow()
		if MutateState.Busy then
			return
		end
		MutateState.LoopId = MutateState.LoopId + 1
		MutateState.CooldownUntil = 0
		local manualLoopId = MutateState.LoopId
		MutateState.Busy = true
		MutateState.ManualRunning = true
		task.spawn(function()
			pcall(RunMutationCycle, manualLoopId, true)
			MutateState.Busy = false
			if FarmConfig.Mutate_Auto then
				MutateState.ManualRunning = false
				MutateState.SetAutoEnabled(true)
			else
				task.delay(2.5, function()
					if not FarmConfig.Mutate_Auto and not MutateState.Busy then
						MutateState.ManualRunning = false
					end
				end)
			end
		end)
	end
	end

	-- 5I. Auto Fuse Machine & Favorite Automation (100% Chilli Mechanics L25559-26393)
	do
	local FuseState = {
		Busy = false,
		Gen = 0,
		NextPassAt = 0,
		NextRevealAt = 0,
		FailedPetCooldowns = {},
		PreviewText = "Fuse status unknown",
	}
	Hub.AutoFuse = FuseState

	local FUSE_PASS_INTERVAL = 2.0
	local FUSE_REVEAL_INTERVAL = 3.0
	local FUSE_SLOT_STEP_WAIT = 0.35
	local FUSE_LOAD_FAIL_COOLDOWN = 20.0

	local COMPACT_UNITS = { "", "K", "M", "B", "T", "Qa", "Qi" }
	local function FormatCompactCash(rawAmount)
		local scaled = tonumber(rawAmount) or 0
		local unitIdx = 1
		while math.abs(scaled) >= 1000 and unitIdx < #COMPACT_UNITS do
			scaled = scaled / 1000
			unitIdx = unitIdx + 1
		end
		local pattern = (unitIdx == 1) and "$%.0f%s" or "$%.2f%s"
		return string.format(pattern, scaled, COMPACT_UNITS[unitIdx])
	end

	local function GetCategoryDisplayName(categoryKey)
		local info = AssetInfoByLowerName[string.lower(tostring(categoryKey or ""))]
		return (info and info.Name) or tostring(categoryKey or "Pet")
	end

	local function ComputeFusePrice(itemList)
		if type(FuseKernelModule) == "table" and type(FuseKernelModule.PriceFor) == "function" then
			local callOk, priceVal = pcall(FuseKernelModule.PriceFor, itemList)
			if callOk and tonumber(priceVal) then
				return tonumber(priceVal)
			end
		end
		return nil
	end

	local function IsPetEligibleForFuse(petUid, petData, equippedSet)
		if type(petData) ~= "table" or petData.IsFavorite == true or petData.Favorite == true or petData.Locked == true or equippedSet[petUid] then
			return false
		end
		local _, rarityRank = ResolveEggRarity(petData)
		if ToFiniteNumber(rarityRank, math.huge) > ToFiniteNumber(FarmConfig.Fuse_MaxRarityRank, 6) then
			return false
		end
		local categoryLower = string.lower(tostring(petData.Category or ""))
		if next(FarmConfig.Fuse_SelectedSpecies) ~= nil and FarmConfig.Fuse_SelectedSpecies[categoryLower] ~= true then
			return false
		end
		if FarmConfig.Fuse_SkipMutated and HasItemMutation(petData) then
			return false
		end
		return (FuseState.FailedPetCooldowns[petUid] or 0) <= os.clock()
	end

	local function SelectFusionPlan(saveData)
		local invMap = type(saveData.Inventory) == "table" and saveData.Inventory or {}
		local equippedSet = {}
		for _, eqUid in pairs(saveData.EquippedAssets or {}) do
			if type(eqUid) == "string" then
				equippedSet[eqUid] = true
			end
		end

		local loadedUids, loadedLookup = {}, {}
		if type(saveData.FusionSlots) == "table" then
			for slotIdx = 1, 3 do
				local slotUid = saveData.FusionSlots[slotIdx]
				if slotUid ~= nil and type(invMap[slotUid]) == "table" then
					table.insert(loadedUids, slotUid)
					loadedLookup[slotUid] = true
				end
			end
		end

		local candidatesByCategory = {}
		for petUid, petData in pairs(invMap) do
			if not loadedLookup[petUid] and type(petData) == "table" and petData.InFuse ~= true then
				if IsPetEligibleForFuse(petUid, petData, equippedSet) then
					local catName = tostring(petData.Category or "")
					if catName ~= "" then
						candidatesByCategory[catName] = candidatesByCategory[catName] or {}
						table.insert(candidatesByCategory[catName], {
							Uid = tostring(petUid),
							Item = petData,
							Income = CalculateEggIncome(petData),
						})
					end
				end
			end
		end

		local function sortSpeciesPool(pool)
			local useHighFirst = (FarmConfig.Fuse_PetsToUse == "Highest To Lowest")
			table.sort(pool, function(petA, petB)
				if petA.Income ~= petB.Income then
					if useHighFirst then
						return petA.Income > petB.Income
					end
					return petA.Income < petB.Income
				end
				return petA.Uid < petB.Uid
			end)
		end

		if #loadedUids > 0 then
			local firstCategory = tostring(invMap[loadedUids[1]].Category or "")
			local allSlotsValid = true
			for _, slotUid in ipairs(loadedUids) do
				local slotPet = invMap[slotUid]
				if tostring(slotPet.Category or "") ~= firstCategory or not IsPetEligibleForFuse(slotUid, slotPet, equippedSet) then
					allSlotsValid = false
					break
				end
			end
			local extraPool = candidatesByCategory[firstCategory] or {}
			if allSlotsValid and (#loadedUids + #extraPool) >= 3 then
				sortSpeciesPool(extraPool)
				local plan = { Category = firstCategory, Load = {}, Items = {} }
				for _, slotUid in ipairs(loadedUids) do
					table.insert(plan.Items, invMap[slotUid])
				end
				for pickIdx = 1, (3 - #loadedUids) do
					table.insert(plan.Load, extraPool[pickIdx].Uid)
					table.insert(plan.Items, extraPool[pickIdx].Item)
				end
				return plan, nil
			end
			if FarmConfig.Fuse_EjectIncomplete then
				return { Category = firstCategory, Eject = loadedUids }, nil
			end
			return nil, "Machine holds pets that cannot finish a fuse"
		end

		local bestScoreTuple, bestCategory = nil, nil
		local priorityMode = FarmConfig.Fuse_Priority
		for catName, pool in pairs(candidatesByCategory) do
			if #pool >= 3 then
				local _, catRank = ResolveEggRarity({ Category = catName })
				local numericRank = ToFiniteNumber(catRank, math.huge)
				local totalIncome = 0
				for _, entry in ipairs(pool) do
					totalIncome = totalIncome + entry.Income
				end

				local scoreTuple
				if priorityMode == "Highest Rarity First" then
					scoreTuple = { -numericRank, -#pool }
				elseif priorityMode == "Most Copies First" then
					scoreTuple = { -#pool, numericRank }
				elseif priorityMode == "Lowest Value First" then
					scoreTuple = { totalIncome / #pool, numericRank }
				else
					scoreTuple = { numericRank, -#pool }
				end

				local isBetter = (bestScoreTuple == nil)
					or (scoreTuple[1] < bestScoreTuple[1])
					or (scoreTuple[1] == bestScoreTuple[1] and scoreTuple[2] < bestScoreTuple[2])
					or (scoreTuple[1] == bestScoreTuple[1] and scoreTuple[2] == bestScoreTuple[2] and catName < bestCategory)
				if isBetter then
					bestScoreTuple = scoreTuple
					bestCategory = catName
				end
			end
		end

		if not bestCategory then
			return nil, "No three matching pets"
		end

		local winningPool = candidatesByCategory[bestCategory]
		sortSpeciesPool(winningPool)
		local finalPlan = { Category = bestCategory, Load = {}, Items = {} }
		for pickIdx = 1, 3 do
			table.insert(finalPlan.Load, winningPool[pickIdx].Uid)
			table.insert(finalPlan.Items, winningPool[pickIdx].Item)
		end
		return finalPlan, nil
	end

	local function BuildFusePreviewText(saveData)
		if not saveData then
			return "Fuse status unknown"
		end
		if saveData.FusionLocked == true then
			return "Machine is fusing, waiting for the egg"
		end
		local plan, reasonText = SelectFusionPlan(saveData)
		if not plan then
			return reasonText or "No three matching pets"
		end
		local speciesLabel = GetCategoryDisplayName(plan.Category)
		if plan.Eject then
			return string.format("Would eject %d %s that cannot finish a fuse", #plan.Eject, speciesLabel)
		end
		local fusePrice = ComputeFusePrice(plan.Items)
		local currentMoney = ReadPlayerMoney(saveData)
		local moneyWarn = (fusePrice and currentMoney < fusePrice) and "  (not enough money)" or ""
		return string.format("Next fuse  -  3 %s for %s%s", speciesLabel, fusePrice and FormatCompactCash(fusePrice) or "?", moneyWarn)
	end

	local function RunAutoFuseStep(expectedGen)
		local saveData = ReadSaveData()
		if not saveData then
			return
		end
		if saveData.FusionLocked == true then
			if type(saveData.FusionEggReward) == "table" and os.clock() >= FuseState.NextRevealAt then
				FuseState.NextRevealAt = os.clock() + FUSE_REVEAL_INTERVAL
				InvokeProgressionRemote("RF/Fusery/FinishReveal")
			end
			return
		end

		local plan = SelectFusionPlan(saveData)
		if not plan then
			return
		end
		if saveData.FusionInfoAcknowledged == false then
			InvokeProgressionRemote("RF/Fusery/ConfirmBriefing")
			task.wait(FUSE_SLOT_STEP_WAIT)
		end

		if plan.Eject then
			for _, ejectUid in ipairs(plan.Eject) do
				if expectedGen ~= FuseState.Gen or not FarmConfig.Fuse_Auto then
					return
				end
				InvokeProgressionRemote("RF/Fusery/EjectPet", ejectUid)
				task.wait(FUSE_SLOT_STEP_WAIT)
			end
			return
		end

		local fusePrice = ComputeFusePrice(plan.Items)
		if fusePrice and ReadPlayerMoney(saveData) < fusePrice then
			return
		end

		for _, loadUid in ipairs(plan.Load) do
			if expectedGen ~= FuseState.Gen or not FarmConfig.Fuse_Auto then
				return
			end
			local loadOk, loadRes = InvokeProgressionRemote("RF/Fusery/LoadPet", loadUid)
			if not loadOk or loadRes == false then
				FuseState.FailedPetCooldowns[loadUid] = os.clock() + FUSE_LOAD_FAIL_COOLDOWN
				return
			end
			task.wait(FUSE_SLOT_STEP_WAIT)
		end

		if expectedGen ~= FuseState.Gen or not FarmConfig.Fuse_Auto then
			return
		end
		local beginOk, beginRes = InvokeProgressionRemote("RF/Fusery/BeginFuse")
		if beginOk and beginRes ~= false then
			FuseState.NextRevealAt = os.clock() + FUSE_REVEAL_INTERVAL
		end
	end

	function FuseState.Restart()
		FuseState.Gen = FuseState.Gen + 1
		pcall(FuseState.RefreshPreview)
		table.clear(FuseState.FailedPetCooldowns)
		FuseState.NextPassAt = 0
		Progression.Wake()
	end

	function FuseState.RefreshPreview()
		FuseState.PreviewText = BuildFusePreviewText(ReadSaveData())
		return FuseState.PreviewText
	end

	AddWorker(function()
		FuseState.RefreshPreview()
		if not FarmConfig.Fuse_Auto or FuseState.Busy or os.clock() < FuseState.NextPassAt then
			return false
		end
		FuseState.Busy = true
		FuseState.NextPassAt = os.clock() + FUSE_PASS_INTERVAL
		local myGen = FuseState.Gen
		task.spawn(function()
			pcall(RunAutoFuseStep, myGen)
			FuseState.Busy = false
			Progression.Wake()
		end)
		return false
	end)

	-- Auto Favorite Engine (Chilli L26011-26393)
	local FavoriteState = {
		Busy = false,
		NextPassAt = 0,
		RecentUidCache = {},
		PreviewText = "0 pets, 0 to mark  |  0 favorited",
	}
	Hub.Favorite = FavoriteState

	local FAV_PASS_COOLDOWN = 2.0
	local FAV_BATCH_MAX = 25
	local FAV_ITEM_GAP = 0.12
	local FAV_UID_DEDUP_TTL = 4.0

	local function DoesPetMatchFavoriteRules(petData)
		local categoryLower = string.lower(tostring(petData.Category or ""))
		if FarmConfig.Fav_AlwaysSpecies[categoryLower] == true then
			return true
		end

		local activeChecks, passedChecks = 0, 0
		local minRarity = FarmConfig.Fav_MinRarityRank
		if minRarity and minRarity > 0 then
			activeChecks = activeChecks + 1
			local _, petRank = ResolveEggRarity(petData)
			if ToFiniteNumber(petRank, 0) >= minRarity then
				passedChecks = passedChecks + 1
			end
		end

		if FarmConfig.Fav_AnyMutation or next(FarmConfig.Fav_SelectedMutations) ~= nil then
			activeChecks = activeChecks + 1
			local petMutSet = ReadEggMutationSet(petData)
			if FarmConfig.Fav_AnyMutation and next(petMutSet) ~= nil then
				passedChecks = passedChecks + 1
			else
				for mutKey in pairs(petMutSet) do
					if FarmConfig.Fav_SelectedMutations[mutKey] or FarmConfig.Fav_SelectedMutations[string.lower(tostring(mutKey))] then
						passedChecks = passedChecks + 1
						break
					end
				end
			end
		end

		local minIncome = ToFiniteNumber(FarmConfig.Fav_MinValue, 0)
		if minIncome > 0 then
			activeChecks = activeChecks + 1
			if CalculateEggIncome(petData) >= minIncome then
				passedChecks = passedChecks + 1
			end
		end

		if activeChecks == 0 then
			return false
		end
		if FarmConfig.Fav_Rule == "Match All" then
			return passedChecks == activeChecks
		end
		return passedChecks > 0
	end

	local function IsFavUidCoolingDown(petUid)
		return (FavoriteState.RecentUidCache[petUid] or 0) > os.clock()
	end

	function FavoriteState.ScanInventoryMatches(saveData)
		local activeSave = saveData or ReadSaveData()
		local toMarkList = {}
		local totalMatched = 0
		local totalFavorited = 0
		if not activeSave then
			return toMarkList, 0, 0
		end
		for petUid, petData in pairs(activeSave.Inventory or {}) do
			if type(petData) == "table" then
				local isFav = (petData.IsFavorite == true or petData.Favorite == true)
				if isFav then
					totalFavorited = totalFavorited + 1
				end
				if DoesPetMatchFavoriteRules(petData) then
					totalMatched = totalMatched + 1
					if not isFav and not IsFavUidCoolingDown(petUid) then
						table.insert(toMarkList, tostring(petUid))
					end
				end
			end
		end
		table.sort(toMarkList)
		return toMarkList, totalMatched, totalFavorited
	end

	function FavoriteState.CollectEquippedTargets(saveData, wantFavorite, respectRulesWhenUnfav)
		local activeSave = saveData or ReadSaveData()
		local targetUids = {}
		if not activeSave then
			return targetUids
		end
		local invMap = activeSave.Inventory or {}
		for _, eqUid in pairs(activeSave.EquippedAssets or {}) do
			local petData = type(eqUid) == "string" and invMap[eqUid] or nil
			if type(petData) == "table" and not IsFavUidCoolingDown(eqUid) then
				local isFav = (petData.IsFavorite == true or petData.Favorite == true)
				if wantFavorite then
					if not isFav then
						table.insert(targetUids, eqUid)
					end
				elseif isFav then
					if not respectRulesWhenUnfav or not DoesPetMatchFavoriteRules(petData) then
						table.insert(targetUids, eqUid)
					end
				end
			end
		end
		table.sort(targetUids)
		return targetUids
	end

	function FavoriteState.WriteBatch(uidList, shouldFavorite)
		if FavoriteState.Busy or #uidList == 0 then
			return false
		end
		local favRemote = ResolveRemote("RE/PetSatchel/WriteFavourite")
		if not favRemote or not favRemote:IsA("RemoteEvent") then
			return false
		end
		FavoriteState.Busy = true
		FavoriteState.NextPassAt = os.clock() + FAV_PASS_COOLDOWN
		task.spawn(function()
			for idx, petUid in ipairs(uidList) do
				if idx > FAV_BATCH_MAX then
					break
				end
				FavoriteState.RecentUidCache[petUid] = os.clock() + FAV_UID_DEDUP_TTL
				pcall(favRemote.FireServer, favRemote, petUid, shouldFavorite)
				task.wait(FAV_ITEM_GAP)
			end
			FavoriteState.Busy = false
			Progression.Wake()
		end)
		return true
	end

	function FavoriteState.Wake(clearDedup)
		pcall(FavoriteState.RefreshPreview)
		if clearDedup then
			table.clear(FavoriteState.RecentUidCache)
		end
		FavoriteState.NextPassAt = 0
		Progression.Wake()
	end

	function FavoriteState.RefreshPreview(saveData)
		local activeSave = saveData or ReadSaveData()
		if not activeSave then
			return FavoriteState.PreviewText, {}
		end
		local toMarkList, matchedCount, favoritedCount = FavoriteState.ScanInventoryMatches(activeSave)
		FavoriteState.PreviewText = string.format(
			"%d pets, %d to mark  |  %d favorited",
			matchedCount,
			#toMarkList,
			favoritedCount
		)
		return FavoriteState.PreviewText, toMarkList
	end

	AddWorker(function()
		local saveData = ReadSaveData()
		if not saveData then
			return false
		end
		local _, toMarkList = FavoriteState.RefreshPreview(saveData)

		if FavoriteState.Busy or os.clock() < FavoriteState.NextPassAt then
			return false
		end
		if FarmConfig.Fav_AutoPets and FavoriteState.WriteBatch(toMarkList, true) then
			return false
		end
		if FarmConfig.Fav_AutoEquipped then
			if FavoriteState.WriteBatch(FavoriteState.CollectEquippedTargets(saveData, true, false), true) then
				return false
			end
		elseif FarmConfig.Fav_AutoUnfavEquipped then
			FavoriteState.WriteBatch(FavoriteState.CollectEquippedTargets(saveData, false, FarmConfig.Fav_AutoPets), false)
		end
		return false
	end)
	end

	-- 5J. Event Automation: Halloween Monsters (100% Chilli Engine) & Pumpkin Boss Ready Controller
	do
	local MonsterState = {
		Gen = 0,
		Busy = false,
		SavedWalkSpeed = nil,
		LastWeaponAt = 0,
		LastWeaponCooldown = 0,
		LastTriggerAt = 0,
		LastSwingAt = 0,
		KillsCount = 0,
		OwnedWeaponLabels = {},
		OwnedWeaponKey = "",
	}
	Hub.HalloweenMonsters = MonsterState

	local PumpkinBossState = {
		Status = "Off",
	}
	Hub.PumpkinBoss = PumpkinBossState

	local MONSTER_TOKEN_WEIGHTS = {
		Small = 12,
		Medium = 28,
		Large = 65,
	}

	function MonsterState.CollectOwnedWeapons()
		local saveData = ReadSaveData()
		local ownedIds = {}
		if saveData and type(saveData.GearInventory) == "table" then
			for gearKey, gearCount in pairs(saveData.GearInventory) do
				if gearCount == true or (tonumber(gearCount) or 0) > 0 then
					ownedIds[tostring(gearKey)] = true
				end
			end
		end
		local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
		for _, container in ipairs(containers) do
			if container then
				for _, toolInst in ipairs(container:GetChildren()) do
					if toolInst:IsA("Tool") then
						local gearId = tostring(toolInst:GetAttribute("GearName") or toolInst.Name)
						ownedIds[gearId] = true
					end
				end
			end
		end
		local ownedLabels = {}
		for _, dispLabel in ipairs(WeaponDisplayList) do
			local gearId = WeaponLabelToGearId[dispLabel]
			if gearId and ownedIds[gearId] then
				table.insert(ownedLabels, dispLabel)
			end
		end
		return ownedLabels
	end

	local function IsInHalloweenDimension()
		return LocalPlayer:GetAttribute("InHalloweenDimension") == true
	end

	local function IsBloodMoonActive()
		local worldEvent = string.lower(tostring(Workspace:GetAttribute("HalloweenWorldEvent") or ""))
		if string.find(worldEvent, "blood", 1, true) ~= nil then
			return true
		end
		return Workspace:GetAttribute("Event_BloodMoon") == true
	end

	local function ResolveInstanceWorldPos(targetObj)
		if not targetObj then
			return nil
		end
		if targetObj:IsA("BasePart") then
			return targetObj.Position
		elseif targetObj:IsA("Attachment") then
			return targetObj.WorldPosition
		elseif targetObj:IsA("Model") then
			local okPivot, pivotCF = pcall(targetObj.GetPivot, targetObj)
			return okPivot and pivotCF and pivotCF.Position or nil
		end
		return targetObj.Parent and ResolveInstanceWorldPos(targetObj.Parent) or nil
	end

	local function FindHalloweenDimensionRoot()
		return Workspace:FindFirstChild("HalloweenDimension")
	end

	local function FindHalloweenZonePart(zoneName)
		local dimRoot = FindHalloweenDimensionRoot()
		local zonesFolder = dimRoot and dimRoot:FindFirstChild("Zones")
		local zonePart = zonesFolder and zonesFolder:FindFirstChild(zoneName)
		return (zonePart and zonePart:IsA("BasePart")) and zonePart or nil
	end

	local function IsPointInsideBoxPart(boxPart, worldPos)
		local localPos = boxPart.CFrame:PointToObjectSpace(worldPos)
		return math.abs(localPos.X) <= (boxPart.Size.X * 0.5)
			and math.abs(localPos.Z) <= (boxPart.Size.Z * 0.5)
	end

	local function FirePartTouch(targetPart)
		local rootPart = Engine.Root()
		if rootPart and targetPart and type(firetouchinterest) == "function" then
			pcall(firetouchinterest, rootPart, targetPart, 0)
			task.wait()
			pcall(firetouchinterest, rootPart, targetPart, 1)
		end
	end

	local function EnterHalloweenPortalIfNeeded(isActiveCheck)
		if IsInHalloweenDimension() then
			return true
		end
		local portalObj = Workspace:FindFirstChild("HalloweenDimensionPortal", true)
		local hitboxPart = portalObj and portalObj:FindFirstChild("Hitbox", true)
		if not hitboxPart or not hitboxPart:IsA("BasePart") then
			return false
		end

		while isActiveCheck() do
			local rootPart = Engine.Root()
			if not rootPart then
				return false
			end
			local blockedByGate = Engine.InsideBase(rootPart.Position)
				and not Engine.InsideBase(hitboxPart.Position)
				and (Engine.IsNight() or Engine.WallSealed())
			if not blockedByGate then
				break
			end
			task.wait(1.0)
		end
		if not isActiveCheck() then
			return false
		end

		if TreadmillState.Riding or IsPlayerOnBelt() then
			ExitTreadmillBelt()
		end
		pcall(function()
			hitboxPart.CanTouch = true
		end)

		for attempt = 1, 3 do
			if not isActiveCheck() then
				return false
			end
			if attempt == 3 then
				FlyInsideBaseTo(hitboxPart.Position, function()
					return not isActiveCheck()
				end)
			end
			local rootPart = Engine.Root()
			if rootPart then
				pcall(function()
					rootPart.Anchored = false
					rootPart.CFrame = CFrame.new(hitboxPart.Position)
					rootPart.AssemblyLinearVelocity = Vector3.zero
					rootPart.AssemblyAngularVelocity = Vector3.zero
				end)
			end
			local portalSnapPos = hitboxPart.Position
			FirePartTouch(hitboxPart)

			local waitDeadline = os.clock() + ((attempt < 3) and 4 or 10)
			while isActiveCheck() and os.clock() < waitDeadline do
				if IsInHalloweenDimension() then
					local shiftDeadline = os.clock() + 6
					while isActiveCheck() and os.clock() < shiftDeadline do
						local curRoot = Engine.Root()
						if curRoot and (curRoot.Position - portalSnapPos).Magnitude > 12 then
							break
						end
						task.wait(0.1)
					end
					pcall(RestoreCharacter)
					task.wait(1.2)
					local saveData = ReadSaveData()
					local hwSave = saveData and saveData.HalloweenDimension
					if type(hwSave) == "table" and hwSave.TutorialSeen ~= true then
						task.spawn(InvokeProgressionRemote, "RF/HalloweenDimension/AskTutorialSeen")
					end
					return true
				end
				task.wait(0.1)
			end
		end
		return IsInHalloweenDimension()
	end

	local function IsCombatBatOrSlapTool(toolInst, allowedMap)
		if not toolInst or not toolInst:IsA("Tool") then
			return false
		end
		local gearId = tostring(toolInst:GetAttribute("GearName") or toolInst.Name)
		if next(allowedMap) ~= nil then
			return allowedMap[gearId] == true or allowedMap[string.lower(gearId)] == true
		end
		if KnownWeaponGearIds[gearId] then
			return true
		end
		if toolInst:GetAttribute("IsBat") == true then
			return true
		end
		local lowerName = string.lower(gearId)
		return string.find(lowerName, "bat", 1, true) ~= nil
			or string.find(lowerName, "slap", 1, true) ~= nil
			or string.find(lowerName, "scythe", 1, true) ~= nil
			or string.find(lowerName, "hammer", 1, true) ~= nil
			or string.find(lowerName, "sword", 1, true) ~= nil
	end

	local function SelectActiveCombatWeapon(allowedWeaponMap)
		local character = LocalPlayer.Character
		local matchingTools = {}
		local containers = { character, LocalPlayer:FindFirstChildOfClass("Backpack") }
		for _, container in ipairs(containers) do
			if container then
				for _, toolInst in ipairs(container:GetChildren()) do
					if IsCombatBatOrSlapTool(toolInst, allowedWeaponMap) then
						table.insert(matchingTools, toolInst)
					end
				end
			end
		end
		if #matchingTools == 0 and next(allowedWeaponMap) ~= nil then
			-- Fallback to any owned combat weapon if selected filter has none in backpack
			return SelectActiveCombatWeapon({})
		end
		if #matchingTools == 0 then
			return nil
		end
		table.sort(matchingTools, function(toolA, toolB)
			return toolA.Name < toolB.Name
		end)

		local function readCooldownEnd(toolInst)
			return tonumber(toolInst:GetAttribute("CooldownEndTime")) or 0
		end

		local heldTool = character and character:FindFirstChildOfClass("Tool")
		local heldIndex = heldTool and table.find(matchingTools, heldTool) or nil
		local chosenTool = matchingTools[1]

		if heldIndex then
			if #matchingTools == 1 then
				return heldTool
			end
			local shouldRotate = (os.clock() - MonsterState.LastWeaponAt) >= 0.5
				or readCooldownEnd(heldTool) ~= MonsterState.LastWeaponCooldown
			if not shouldRotate then
				return heldTool
			end
			local serverNow = Workspace:GetServerTimeNow()
			local bestRemaining = nil
			for offset = 1, (#matchingTools - 1) do
				local idx = ((heldIndex + offset - 1) % #matchingTools) + 1
				local candidate = matchingTools[idx]
				local remain = readCooldownEnd(candidate) - serverNow
				if remain <= 0 then
					chosenTool = candidate
					break
				end
				if not bestRemaining or remain < bestRemaining then
					chosenTool = candidate
					bestRemaining = remain
				end
			end
		end

		MonsterState.LastWeaponAt = os.clock()
		MonsterState.LastWeaponCooldown = readCooldownEnd(chosenTool)
		return chosenTool
	end

	local function SwingCombatWeapon(weaponTool)
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not weaponTool or not character or not humanoid then
			return
		end
		if weaponTool.Parent ~= character then
			pcall(humanoid.EquipTool, humanoid, weaponTool)
		end
		if weaponTool.Parent ~= character then
			return
		end

		local gearId = tostring(weaponTool:GetAttribute("GearName") or weaponTool.Name)
		local nowClock = os.clock()
		if BatGearIds[gearId] or weaponTool:GetAttribute("IsBat") == true then
			if (nowClock - MonsterState.LastSwingAt) >= 0.16 then
				MonsterState.LastSwingAt = nowClock
				pcall(weaponTool.Activate, weaponTool)
				FireProgressionRemote("RE/BatSwing/Trigger")
			end
		else
			local cooldownEnd = tonumber(weaponTool:GetAttribute("CooldownEndTime")) or 0
			if Workspace:GetServerTimeNow() >= cooldownEnd
				and (nowClock - MonsterState.LastTriggerAt) > 0.1
				and (nowClock - MonsterState.LastWeaponAt) > 0.15
			then
				MonsterState.LastTriggerAt = nowClock
				FireProgressionRemote("RE/ToolTrigger/Trigger", weaponTool)
				pcall(weaponTool.Activate, weaponTool)
			end
		end
	end

	local function SnapToHalloweenGround(worldPos)
		local dimRoot = FindHalloweenDimensionRoot()
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = {
			LocalPlayer.Character,
			dimRoot and dimRoot:FindFirstChild("Monsters"),
			dimRoot and dimRoot:FindFirstChild("Ghosts"),
		}
		local rayHit = Workspace:Raycast(worldPos + Vector3.new(0, 25, 0), Vector3.new(0, -80, 0), rayParams)
		return rayHit and Vector3.new(worldPos.X, rayHit.Position.Y + 3, worldPos.Z) or worldPos
	end

	local function StepMonsterWalk(goalPos, walkSpeed)
		local rootPart = Engine.Root()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not rootPart or not humanoid then
			return
		end
		MonsterState.SavedWalkSpeed = MonsterState.SavedWalkSpeed or humanoid.WalkSpeed
		local flatDelta = Vector3.new(goalPos.X - rootPart.Position.X, 0, goalPos.Z - rootPart.Position.Z)
		local diffY = goalPos.Y - rootPart.Position.Y
		local velY = (diffY > 2) and math.min(diffY * 6, 40) or math.min(rootPart.AssemblyLinearVelocity.Y, 8)

		if flatDelta.Magnitude > 2 then
			local aheadParams = RaycastParams.new()
			aheadParams.FilterType = Enum.RaycastFilterType.Exclude
			aheadParams.FilterDescendantsInstances = { character }
			local probeOrigin = rootPart.Position + flatDelta.Unit * math.min(flatDelta.Magnitude, 6) + Vector3.new(0, 5, 0)
			if not Workspace:Raycast(probeOrigin, Vector3.new(0, -40, 0), aheadParams) then
				humanoid:MoveTo(rootPart.Position)
				rootPart.AssemblyLinearVelocity = Vector3.new(0, math.min(rootPart.AssemblyLinearVelocity.Y, 0), 0)
				return
			end
			humanoid.WalkSpeed = walkSpeed
			humanoid:MoveTo(Vector3.new(goalPos.X, rootPart.Position.Y, goalPos.Z))
			local stepHoriz = flatDelta.Unit * math.min(walkSpeed, flatDelta.Magnitude / 0.05)
			rootPart.AssemblyLinearVelocity = Vector3.new(stepHoriz.X, velY, stepHoriz.Z)
		else
			humanoid:MoveTo(rootPart.Position)
			rootPart.AssemblyLinearVelocity = Vector3.new(0, velY, 0)
		end
	end

	local function RestoreMonsterWalkState()
		local rootPart = Engine.Root()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if rootPart then
			rootPart.AssemblyLinearVelocity = Vector3.new(0, math.min(rootPart.AssemblyLinearVelocity.Y, 0), 0)
		end
		if humanoid then
			if rootPart then
				pcall(humanoid.MoveTo, humanoid, rootPart.Position)
				pcall(humanoid.Move, humanoid, Vector3.zero, false)
			end
			if MonsterState.SavedWalkSpeed then
				humanoid.WalkSpeed = MonsterState.SavedWalkSpeed
				MonsterState.SavedWalkSpeed = nil
			end
		end
	end

	local function CollectLiveHalloweenMonsters()
		local seen = {}
		local results = {}
		local okTagged, taggedList = pcall(CollectionService.GetTagged, CollectionService, "HalloweenMonster")
		if okTagged and type(taggedList) == "table" then
			for _, inst in ipairs(taggedList) do
				if inst and inst:IsDescendantOf(Workspace) then
					seen[inst] = true
					table.insert(results, inst)
				end
			end
		end
		local dimRoot = FindHalloweenDimensionRoot()
		local monstersFolder = dimRoot and dimRoot:FindFirstChild("Monsters")
		if monstersFolder then
			for _, child in ipairs(monstersFolder:GetChildren()) do
				if not seen[child] then
					seen[child] = true
					table.insert(results, child)
				end
			end
		end
		return results
	end

	local function RunMonsterFarmStep(expectedGen, externalActiveCheck)
		local function isRunActive()
			if not Hub.Alive or Engine.Disposed then
				return false
			end
			if externalActiveCheck then
				return externalActiveCheck() == true
			end
			if expectedGen ~= MonsterState.Gen or not FarmConfig.Monster_AutoKill then
				return false
			end
			if FarmConfig.Monster_OnlyBloodMoon and not IsBloodMoonActive() then
				return false
			end
			return true
		end

		if not isRunActive() then
			return
		end
		if not EnterHalloweenPortalIfNeeded(isRunActive) then
			return
		end

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local rootPart = Engine.Root()
		if not character or not humanoid or not rootPart or humanoid.Health <= 0 then
			return
		end

		-- Chilli SafeZone retreat when health drops below 40%
		if humanoid.Health < (humanoid.MaxHealth * 0.4) then
			local safeZonePart = FindHalloweenZonePart("SafeZone")
			if safeZonePart then
				local healDeadline = os.clock() + 25
				while isRunActive() and os.clock() < healDeadline do
					local liveHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					if not liveHum or liveHum.Health >= (liveHum.MaxHealth * 0.85) then
						break
					end
					if FarmConfig.Monster_Teleport then
						local liveRoot = Engine.Root()
						if liveRoot then
							liveRoot.CFrame = CFrame.new(safeZonePart.Position + Vector3.new(0, 3, 0))
							liveRoot.AssemblyLinearVelocity = Vector3.zero
						end
					else
						StepMonsterWalk(safeZonePart.Position + Vector3.new(0, 3, 0), FarmConfig.Monster_WalkSpeed)
					end
					RunService.Heartbeat:Wait()
				end
				RestoreMonsterWalkState()
			end
			return
		end

		local activeWeapon = SelectActiveCombatWeapon(FarmConfig.Monster_Weapons)
		if not activeWeapon then
			return
		end

		local safeZonePart = FindHalloweenZonePart("SafeZone")
		local ignoreTargetFilter = FarmConfig.Monster_AllInBloodMoon and IsBloodMoonActive()
		local hasKindFilter = (not ignoreTargetFilter) and (next(FarmConfig.Monster_Targets) ~= nil)

		local bestMonster = nil
		local bestScore = math.huge
		for _, monsterInst in ipairs(CollectLiveHalloweenMonsters()) do
			if monsterInst:GetAttribute("KilledBy") == nil then
				local monsterNameLower = string.lower(tostring(monsterInst.Name or ""))
				if not hasKindFilter or FarmConfig.Monster_Targets[monsterNameLower] == true then
					local monsterPos = ResolveInstanceWorldPos(monsterInst)
					if monsterPos and not (safeZonePart and IsPointInsideBoxPart(safeZonePart, monsterPos)) then
						local dist = (monsterPos - rootPart.Position).Magnitude
						local score = dist
						if FarmConfig.Monster_Order == "Most Tokens" then
							local sizeTag = tostring(monsterInst:GetAttribute("MonsterSize") or "")
							score = dist - (MONSTER_TOKEN_WEIGHTS[sizeTag] or 0) * 1000
						end
						if score < bestScore then
							bestScore = score
							bestMonster = monsterInst
						end
					end
				end
			end
		end

		if not bestMonster then
			return
		end

		local function isTargetStillValid()
			local liveChar = LocalPlayer.Character
			local liveHum = liveChar and liveChar:FindFirstChildOfClass("Humanoid")
			return isRunActive()
				and IsInHalloweenDimension()
				and bestMonster.Parent ~= nil
				and bestMonster:GetAttribute("KilledBy") == nil
				and LocalPlayer:GetAttribute("HalloweenCarrying") ~= true
				and (liveHum ~= nil and liveHum.Health >= liveHum.MaxHealth * 0.4)
		end

		local approachPos = ResolveInstanceWorldPos(bestMonster)
		if approachPos and (approachPos - rootPart.Position).Magnitude > 30 and not FarmConfig.Monster_Teleport then
			local travelDeadline = os.clock() + 25
			while isTargetStillValid() and os.clock() < travelDeadline do
				local liveRoot = Engine.Root()
				local liveMonsterPos = ResolveInstanceWorldPos(bestMonster)
				if not liveRoot or not liveMonsterPos then
					break
				end
				local groundGoal = SnapToHalloweenGround(liveMonsterPos)
				local flat = Vector3.new(groundGoal.X - liveRoot.Position.X, 0, groundGoal.Z - liveRoot.Position.Z)
				if flat.Magnitude < 4 then
					break
				end
				StepMonsterWalk(groundGoal, FarmConfig.Monster_WalkSpeed)
				RunService.Heartbeat:Wait()
			end
			RestoreMonsterWalkState()
		end

		local combatDeadline = os.clock() + 15
		while isTargetStillValid() and os.clock() < combatDeadline do
			local liveRoot = Engine.Root()
			local liveMonsterPos = ResolveInstanceWorldPos(bestMonster)
			if not liveRoot or not liveMonsterPos then
				break
			end
			local awayFlat = Vector3.new(liveRoot.Position.X - liveMonsterPos.X, 0, liveRoot.Position.Z - liveMonsterPos.Z)
			local standOffset = (awayFlat.Magnitude > 0.1 and awayFlat.Unit or Vector3.new(0, 0, 1)) * 4
			local combatStandPos = SnapToHalloweenGround(liveMonsterPos + standOffset)
			local lookTarget = Vector3.new(liveMonsterPos.X, combatStandPos.Y, liveMonsterPos.Z)

			if FarmConfig.Monster_Teleport then
				pcall(function()
					liveRoot.CFrame = CFrame.lookAt(combatStandPos, lookTarget)
					liveRoot.AssemblyLinearVelocity = Vector3.zero
					liveRoot.AssemblyAngularVelocity = Vector3.zero
				end)
			else
				StepMonsterWalk(combatStandPos, FarmConfig.Monster_WalkSpeed)
				local flatFace = Vector3.new(liveMonsterPos.X - liveRoot.Position.X, 0, liveMonsterPos.Z - liveRoot.Position.Z)
				if flatFace.Magnitude > 0.1 then
					pcall(function()
						liveRoot.CFrame = CFrame.lookAt(liveRoot.Position, liveRoot.Position + flatFace.Unit)
					end)
				end
			end

			local chosenWeapon = SelectActiveCombatWeapon(FarmConfig.Monster_Weapons) or activeWeapon
			SwingCombatWeapon(chosenWeapon)
			RunService.Heartbeat:Wait()
		end

		RestoreMonsterWalkState()
		if bestMonster:GetAttribute("KilledBy") == LocalPlayer.UserId then
			MonsterState.KillsCount = MonsterState.KillsCount + 1
		end
		return true
	end

	MonsterState.EnterDimension = EnterHalloweenPortalIfNeeded
	MonsterState.StepWalkTo = StepMonsterWalk
	MonsterState.StopWalk = RestoreMonsterWalkState

	function MonsterState.HasLiveTargetMonster()
		local safeZonePart = FindHalloweenZonePart("SafeZone")
		for _, monsterInst in ipairs(CollectLiveHalloweenMonsters()) do
			if monsterInst:GetAttribute("KilledBy") == nil then
				local monsterPos = ResolveInstanceWorldPos(monsterInst)
				if monsterPos and not (safeZonePart and IsPointInsideBoxPart(safeZonePart, monsterPos)) then
					return true
				end
			end
		end
		return false
	end

	function MonsterState.FightOneMonster(activeCheckFn)
		if MonsterState.Busy then
			return false
		end
		MonsterState.Busy = true
		local callOk, fought = pcall(RunMonsterFarmStep, MonsterState.Gen, activeCheckFn)
		MonsterState.Busy = false
		return callOk and fought == true
	end

	function MonsterState.SetAutoEnabled(isEnabled)
		MonsterState.Gen = MonsterState.Gen + 1
		RestoreMonsterWalkState()
		if not isEnabled then
			return
		end
		local myGen = MonsterState.Gen
		task.spawn(function()
			while Hub.Alive and not Engine.Disposed and myGen == MonsterState.Gen and FarmConfig.Monster_AutoKill do
				if not MonsterState.Busy then
					MonsterState.Busy = true
					pcall(RunMonsterFarmStep, myGen)
					MonsterState.Busy = false
				end
				task.wait(0.25)
			end
		end)
	end

	function PumpkinBossState.RefreshStatus()
		if not FarmConfig.PumpkinBoss_Auto
			and not FarmConfig.PumpkinBoss_AutoMastery
			and not FarmConfig.PumpkinBoss_AutoManorKey
		then
			PumpkinBossState.Status = "Off"
		else
			PumpkinBossState.Status = "Waiting for Part 2 Boss & Manor remotes"
		end
		return PumpkinBossState.Status
	end
	end

	-- 5K. Ghost Dog Quest & Auto Fishing (100% Chilli Mechanics L34280-34765 + Custom Spot & Monster Guard)
	do
	local FishingState = {
		Gen = 0,
		Busy = false,
		Status = "Off",
		QuestRetryAt = 0,
		NextCastAt = 0,
		ChaseActive = false,
		PinCFrame = nil,
		SavedSpot = nil,
		FishCaughtCount = 0,
	}
	Hub.GhostDogFishing = FishingState

	local QUEST_STAGE_LABELS = {
		"Talk to Echo",
		"Collect Echo's Memories",
		"Get Haunted Rod",
		"Cast at Ripples",
		"Done",
	}

	local function SetFishingStatus(statusText)
		FishingState.Status = tostring(statusText or "Off")
	end

	function FishingState.GetDisplayStatus()
		if not FarmConfig.Fishing_AutoQuest and not FarmConfig.Fishing_AutoFish then
			return "Off"
		end
		return FishingState.Status
	end

	-- Keep character pinned steady to the dock while casting/reeling
	Hub.Lifecycle.TrackConnection(RunService.Heartbeat:Connect(function()
		if not FishingState.PinCFrame or not Hub.Alive or Engine.Disposed then
			return
		end
		local rootPart = Engine.Root()
		if rootPart then
			pcall(function()
				rootPart.CFrame = FishingState.PinCFrame
				rootPart.AssemblyLinearVelocity = Vector3.zero
				rootPart.AssemblyAngularVelocity = Vector3.zero
			end)
		end
	end))

	local function FindQuestMarkerPart(markerName)
		local dimRoot = Workspace:FindFirstChild("HalloweenDimension")
		local questFolder = dimRoot and dimRoot:FindFirstChild("GhostDogQuest")
		local markersFolder = questFolder and questFolder:FindFirstChild("Markers")
		local markerPart = markersFolder and markersFolder:FindFirstChild(markerName)
		return (markerPart and markerPart:IsA("BasePart")) and markerPart or nil
	end

	local function ReadGhostDogQuestProgress()
		local saveData = ReadSaveData()
		local questTbl = saveData and saveData.GhostDogQuest
		if type(questTbl) == "table" then
			return tonumber(questTbl.Stage) or 0, questTbl
		end
		return 0, {}
	end

	local function FindOwnedFishingRod(requireQuestRod)
		local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
		for _, container in ipairs(containers) do
			if container then
				for _, toolInst in ipairs(container:GetChildren()) do
					if toolInst:IsA("Tool") then
						if toolInst:GetAttribute("GhostDogRod") == true then
							return toolInst
						end
						if not requireQuestRod then
							local itemType = tostring(toolInst:GetAttribute("ItemType") or "")
							local lowerName = string.lower(tostring(toolInst:GetAttribute("GearName") or toolInst.Name))
							if itemType == "FishingRod" or string.find(lowerName, "rod", 1, true) ~= nil then
								return toolInst
							end
						end
					end
				end
			end
		end
		return nil
	end

	local function ComputeQuestFingerprint()
		local stageNum, questTbl = ReadGhostDogQuestProgress()
		local artifactCount = 0
		if type(questTbl.Artifacts) == "table" then
			for _ in pairs(questTbl.Artifacts) do
				artifactCount = artifactCount + 1
			end
		end
		return stageNum * 10 + artifactCount + (FindOwnedFishingRod(true) and 5 or 0)
	end

	local function EquipRodTool(rodTool)
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if rodTool and character and humanoid and rodTool.Parent ~= character then
			pcall(humanoid.EquipTool, humanoid, rodTool)
			if rodTool.Parent ~= character then
				pcall(function()
					rodTool.Parent = character
				end)
			end
		end
		return rodTool
	end

	local function WaitConditional(seconds, isAliveCheck)
		local deadline = os.clock() + math.max(0, tonumber(seconds) or 0)
		while os.clock() < deadline do
			if isAliveCheck and not isAliveCheck() then
				return false
			end
			RunService.Heartbeat:Wait()
		end
		return true
	end

	local function WaitUntilOrTimeout(predicateFn, maxSeconds, isAliveCheck)
		local deadline = os.clock() + maxSeconds
		while os.clock() < deadline do
			if predicateFn() then
				return true
			end
			if isAliveCheck and not isAliveCheck() then
				return false
			end
			RunService.Heartbeat:Wait()
		end
		return predicateFn() == true
	end

	local function MoveToEventPosition(goalPos, isAliveCheck, moveSpeed)
		local speedVal = tonumber(moveSpeed) or 300
		local deadline = os.clock() + 25
		while isAliveCheck() and os.clock() < deadline do
			local rootPart = Engine.Root()
			if not rootPart then
				break
			end
			local flat = Vector3.new(goalPos.X - rootPart.Position.X, 0, goalPos.Z - rootPart.Position.Z)
			if flat.Magnitude < 3 and (goalPos.Y - rootPart.Position.Y) < 2.5 then
				break
			end
			Hub.HalloweenMonsters.StepWalkTo(goalPos, speedVal)
			RunService.Heartbeat:Wait()
		end
		Hub.HalloweenMonsters.StopWalk()
		return isAliveCheck()
	end

	local function MoveToQuestMarker(markerName, isAliveCheck)
		local markerPart = FindQuestMarkerPart(markerName)
		if not markerPart then
			return false
		end
		return MoveToEventPosition(markerPart.Position + Vector3.new(0, 3, 0), isAliveCheck, 300)
	end

	local function TalkAtQuestMarker(markerName, npcTopic, isAliveCheck)
		local lastOk, lastReply = false, nil
		for _ = 1, 3 do
			local invokeOk, replyVal = InvokeProgressionRemote("RF/GhostDogQuest/Talk", npcTopic)
			lastOk, lastReply = invokeOk, replyVal
			if invokeOk then
				break
			end
			if type(replyVal) == "string" and string.find(string.lower(replyVal), "closer", 1, true) then
				MoveToQuestMarker(markerName, isAliveCheck)
				WaitConditional(0.4, isAliveCheck)
			else
				break
			end
		end
		return lastOk, lastReply
	end

	local function GetFishingControllerSub(subName)
		local callOk, subMod = pcall(function()
			local controllers = ReplicatedStorage:FindFirstChild("Controllers")
			local gameCtrl = controllers and controllers:FindFirstChild("Game")
			local fishCtrl = gameCtrl and gameCtrl:FindFirstChild("FishingController")
			local targetMod = fishCtrl and fishCtrl:FindFirstChild(subName)
			return targetMod and require(targetMod) or nil
		end)
		return callOk and subMod or nil
	end

	local function CastRodTowardWater(waterPos, isAliveCheck)
		local rootPart = Engine.Root()
		if not rootPart then
			return nil, "No root"
		end
		local flatLook = Vector3.new(waterPos.X - rootPart.Position.X, 0, waterPos.Z - rootPart.Position.Z)
		if flatLook.Magnitude > 0.1 then
			pcall(function()
				rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + flatLook.Unit)
			end)
		end

		local chargeRatio = math.clamp(ToFiniteNumber(FarmConfig.Fishing_CastCharge, 0.875), 0.02, 1.0)
		local holdDuration = 1.2 * (chargeRatio ^ 0.7142857142857143)
		local fishUi = GetFishingControllerSub("Ui")

		FireProgressionRemote("RE/Fishing/Hold")
		local holdStart = os.clock()
		local showedBar = false
		while (os.clock() - holdStart) < holdDuration do
			if not isAliveCheck() then
				if fishUi then
					pcall(fishUi.ShowCharge, false)
				end
				return nil, "Cancelled"
			end
			if fishUi and type(FishingUtilModule) == "table" then
				local barAlpha = (os.clock() - holdStart - holdDuration + 0.25) / 0.2
				if barAlpha >= 0 then
					if not showedBar then
						pcall(fishUi.ShowCharge, true, 0.8, 0.95)
						showedBar = true
					end
					pcall(function()
						local chargeVal = FishingUtilModule.ChargeAt(holdDuration) * math.min(barAlpha, 1)
						fishUi.SetCharge(
							chargeVal,
							FishingUtilModule.LuckText(FishingUtilModule.LuckFor(chargeVal)),
							FishingUtilModule.IsPerfect(chargeVal),
							Vector2.new(0.5, 0.4)
						)
					end)
				end
			end
			RunService.Heartbeat:Wait()
		end
		if fishUi then
			pcall(fishUi.ShowCharge, false)
		end

		local castRemote = ResolveRemote("RF/Fishing/Cast")
		if not castRemote or not castRemote:IsA("RemoteFunction") then
			SetFishingStatus("Fishing remote missing")
			return nil, "Missing remote"
		end
		local callOk, castResult, castErr = pcall(castRemote.InvokeServer, castRemote, holdDuration, waterPos)
		if not callOk or type(castResult) ~= "table" then
			local errText = tostring(castErr or castResult or "no answer")
			SetFishingStatus("Fishing: " .. errText)
			return nil, errText
		end
		return castResult, nil
	end

	local function RunUnderwaterDogChase(chaseSeed, chaseDurationSec, isAliveCheck)
		if type(GhostDogQuestModule) ~= "table" or type(GhostDogQuestModule.ChaseFrame) ~= "function" then
			return false
		end
		local function sampleChaseFrame(distAlong)
			local okFrame, cfVal = pcall(GhostDogQuestModule.ChaseFrame, chaseSeed, distAlong)
			return (okFrame and typeof(cfVal) == "CFrame") and cfVal or nil
		end
		if not sampleChaseFrame(0) then
			return false
		end

		FishingState.ChaseActive = true
		SetFishingStatus("Ghost Dog: underwater chase")

		local chaseOk, claimedOk = pcall(function()
			WaitUntilOrTimeout(function()
				local rootPart = Engine.Root()
				local startCF = sampleChaseFrame(0)
				return rootPart ~= nil and startCF ~= nil and (rootPart.Position - startCF.Position).Magnitude < 40
			end, 8, isAliveCheck)

			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local diveTilt = CFrame.Angles(-1.2566, 0, 0)
			if humanoid then
				humanoid.PlatformStand = true
			end

			local alignEnd = os.clock() + 4
			while isAliveCheck() and os.clock() < alignEnd do
				local rootPart = Engine.Root()
				local frameZero = sampleChaseFrame(0)
				if rootPart and frameZero then
					rootPart.CFrame = frameZero * diveTilt
					rootPart.AssemblyLinearVelocity = Vector3.zero
				end
				RunService.Heartbeat:Wait()
			end

			local chaseSpeed = 58
			local totalDist = chaseDurationSec * chaseSpeed
			local startClock = os.clock()
			while isAliveCheck() and LocalPlayer:GetAttribute("GhostDogChase") ~= nil do
				local traveled = math.min((os.clock() - startClock) * chaseSpeed, totalDist)
				local stepCF = sampleChaseFrame(traveled)
				local rootPart = Engine.Root()
				if rootPart and stepCF then
					rootPart.CFrame = stepCF * diveTilt
					rootPart.AssemblyLinearVelocity = Vector3.zero
				end
				if traveled >= totalDist then
					break
				end
				RunService.Heartbeat:Wait()
			end

			local didClaim = false
			for attempt = 1, 8 do
				local claimOk, claimRes = InvokeProgressionRemote("RF/GhostDogQuest/Claim")
				if claimOk and claimRes == true then
					didClaim = true
					break
				end
				if attempt == 4 then
					local holdEnd = os.clock() + 5
					while os.clock() < holdEnd do
						local endCF = sampleChaseFrame(totalDist)
						local rootPart = Engine.Root()
						if rootPart and endCF then
							rootPart.CFrame = endCF * diveTilt
							rootPart.AssemblyLinearVelocity = Vector3.zero
						end
						RunService.Heartbeat:Wait()
					end
				else
					task.wait(0.7)
				end
			end

			task.wait(didClaim and 3.0 or 0.5)
			for _ = 1, 3 do
				local surfOk, surfRes = InvokeProgressionRemote("RF/GhostDogQuest/Surface")
				if surfOk and surfRes == true then
					break
				end
				task.wait(0.5)
			end
			return didClaim
		end)

		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end
		InvokeProgressionRemote("RF/GhostDogQuest/Abort")
		FishingState.ChaseActive = false
		return chaseOk and claimedOk == true
	end

	local function DiveAndChaseGhostTarget(chaseSeed, chaseSeconds, isAliveCheck)
		if not WaitConditional(3.5, isAliveCheck) then
			InvokeProgressionRemote("RF/GhostDogQuest/Abort")
			return false
		end
		InvokeProgressionRemote("RF/GhostDogQuest/Dive")
		return RunUnderwaterDogChase(chaseSeed, chaseSeconds, isAliveCheck)
	end

	local function StepGhostDogQuest(isAliveCheck)
		local stageNum, questTbl = ReadGhostDogQuestProgress()
		if stageNum >= 4 then
			SetFishingStatus("Ghost Dog quest: Done")
			return false
		end
		local beforeFingerprint = ComputeQuestFingerprint()
		local lastMsg = nil
		SetFishingStatus("Ghost Dog quest: " .. (QUEST_STAGE_LABELS[stageNum + 1] or "In Progress"))

		if stageNum == 0 then
			if MoveToQuestMarker("DogSpot", isAliveCheck) then
				_, lastMsg = TalkAtQuestMarker("DogSpot", "Dog", isAliveCheck)
				WaitUntilOrTimeout(function()
					return (ReadGhostDogQuestProgress()) >= 1
				end, 5, isAliveCheck)
			end
		elseif stageNum == 1 then
			local allCollected = true
			local artifactsMap = type(questTbl.Artifacts) == "table" and questTbl.Artifacts or {}
			for _, artifactName in ipairs({ "Collar", "Bone", "Toy", "Photo" }) do
				if not artifactsMap[artifactName] then
					allCollected = false
					if isAliveCheck() and MoveToQuestMarker("Artifact_" .. artifactName, isAliveCheck) then
						WaitConditional(0.3, isAliveCheck)
						local _, collectMsg = InvokeProgressionRemote("RF/GhostDogQuest/Collect", artifactName)
						WaitConditional(0.5, isAliveCheck)
						lastMsg = collectMsg
					end
				end
			end
			if allCollected and MoveToQuestMarker("DogSpot", isAliveCheck) then
				_, lastMsg = TalkAtQuestMarker("DogSpot", "Dog", isAliveCheck)
				WaitUntilOrTimeout(function()
					return (ReadGhostDogQuestProgress()) >= 2
				end, 5, isAliveCheck)
			end
		elseif stageNum == 2 or (stageNum == 3 and not FindOwnedFishingRod(true)) then
			if MoveToQuestMarker("FishermanSpot", isAliveCheck) then
				local _, talkReply = TalkAtQuestMarker("FishermanSpot", "Fisherman", isAliveCheck)
				lastMsg = talkReply
				if talkReply == "FisherReunion" or talkReply == "FisherHint" then
					WaitConditional(2.5, isAliveCheck)
					TalkAtQuestMarker("FishermanSpot", "Rod", isAliveCheck)
					WaitUntilOrTimeout(function()
						return FindOwnedFishingRod(true) ~= nil
					end, 5, isAliveCheck)
				end
			end
		elseif stageNum == 3 then
			local castTarget = FindQuestMarkerPart("CastTarget")
			if castTarget and MoveToQuestMarker("CastSpot", isAliveCheck) then
				EquipRodTool(FindOwnedFishingRod(true))
				WaitConditional(0.5, isAliveCheck)
				local castData = CastRodTowardWater(castTarget.Position, isAliveCheck)
				if castData and castData.Mode == "Quest" then
					WaitConditional((tonumber(castData.Wait) or 3) + 0.45, isAliveCheck)
					FireProgressionRemote("RE/Fishing/Cancel", castData.Id)
					local castOk, chaseSeed = InvokeProgressionRemote("RF/GhostDogQuest/Cast")
					if castOk and type(chaseSeed) == "number" then
						DiveAndChaseGhostTarget(chaseSeed, 50, isAliveCheck)
					end
				elseif castData and castData.Id then
					FireProgressionRemote("RE/Fishing/Cancel", castData.Id)
				end
			end
		end

		if ComputeQuestFingerprint() == beforeFingerprint then
			FishingState.QuestRetryAt = os.clock() + 10
			if type(lastMsg) == "string" and lastMsg ~= "" then
				SetFishingStatus("Ghost Dog: " .. lastMsg)
			end
		end
		return true
	end

	local function ProbeFishingWaterPoint(probeOrigin)
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		local exclusions = { LocalPlayer.Character }
		for _ = 1, 6 do
			rayParams.FilterDescendantsInstances = exclusions
			local rayHit = Workspace:Raycast(probeOrigin + Vector3.new(0, 40, 0), Vector3.new(0, -180, 0), rayParams)
			if not rayHit then
				return nil
			end
			local hitInst = rayHit.Instance
			local hasWaterTag = false
			pcall(function()
				hasWaterTag = CollectionService:HasTag(hitInst, "FishingWater")
			end)
			if rayHit.Material == Enum.Material.Water
				or (hitInst and hitInst:GetAttribute("TerrainRole") == "Basin")
				or (hitInst and hitInst:GetAttribute("FishingWater") == true)
				or hasWaterTag
			then
				return rayHit.Position
			end
			if hitInst and hitInst:IsA("BasePart") and hitInst.Transparency >= 0.95 then
				table.insert(exclusions, hitInst)
			else
				return nil
			end
		end
		return nil
	end

	local function BuildDockPinCFrame(rootPart, waterPos)
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		local excludedChars = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Character then
				table.insert(excludedChars, plr.Character)
			end
		end
		rayParams.FilterDescendantsInstances = excludedChars
		local groundHit = Workspace:Raycast(rootPart.Position + Vector3.new(0, 4, 0), Vector3.new(0, -20, 0), rayParams)
		local standY = groundHit
			and (groundHit.Position.Y + (humanoid and humanoid.HipHeight or 2) + rootPart.Size.Y * 0.5)
			or rootPart.Position.Y
		local standPos = Vector3.new(rootPart.Position.X, standY, rootPart.Position.Z)
		if humanoid then
			pcall(humanoid.Move, humanoid, Vector3.zero, false)
			pcall(humanoid.MoveTo, humanoid, standPos)
		end
		return CFrame.lookAt(standPos, Vector3.new(waterPos.X, standY, waterPos.Z))
	end

	local function ResolveDesiredFishingAnchor()
		local spotMode = FarmConfig.Fishing_Spot
		if spotMode == "Current Position" then
			return nil, nil
		elseif spotMode == "Saved Spot" and FishingState.SavedSpot then
			return FishingState.SavedSpot.Position, FishingState.SavedSpot.LookVector
		elseif spotMode == "Secret Whirlpool Pond" then
			for _, candidateName in ipairs({ "Gus", "GhostFishermanGus", "SecretFishingSpot", "WhirlpoolPond" }) do
				local foundNode = Workspace:FindFirstChild(candidateName, true)
				if foundNode then
					local okPos, nodeCF = pcall(function()
						return foundNode:IsA("Model") and foundNode:GetPivot() or foundNode.CFrame
					end)
					if okPos and nodeCF then
						return nodeCF.Position, nodeCF.LookVector
					end
				end
			end
			if FishingState.SavedSpot then
				return FishingState.SavedSpot.Position, FishingState.SavedSpot.LookVector
			end
			return nil, nil
		end

		local defaultSpot = FindQuestMarkerPart("ReturnSpot")
		if defaultSpot then
			local fisherman = Workspace:FindFirstChild("GhostFisherman")
			local lookDir = (fisherman and fisherman:IsA("Model") and fisherman:GetPivot().LookVector)
				or defaultSpot.CFrame.LookVector
			return defaultSpot.Position, lookDir
		end
		return nil, nil
	end

	local function StepAutoFishingPass(isAliveCheck)
		-- Farm Monster While Fishing: clear live Halloween monsters between casts!
		if FarmConfig.Fishing_FarmMonsters and LocalPlayer:GetAttribute("InHalloweenDimension") == true then
			if Hub.HalloweenMonsters.HasLiveTargetMonster() then
				FishingState.PinCFrame = nil
				SetFishingStatus("Fighting nearby monster before fishing")
				Hub.HalloweenMonsters.FightOneMonster(function()
					return isAliveCheck() and FarmConfig.Fishing_FarmMonsters
				end)
				if not isAliveCheck() then
					return false
				end
			end
		end

		if FarmConfig.Fishing_AutoQuest and (ReadGhostDogQuestProgress()) == 3 then
			SetFishingStatus("Ghost Dog quest Stage 3 - casting at ripples")
			return StepGhostDogQuest(isAliveCheck)
		end

		local rodTool = FindOwnedFishingRod(false)
		if not rodTool then
			SetFishingStatus("No fishing rod found in bag")
			WaitConditional(2.0, isAliveCheck)
			return false
		end

		if os.clock() < FishingState.NextCastAt then
			WaitConditional(FishingState.NextCastAt - os.clock(), isAliveCheck)
			return true
		end

		local rootPart = Engine.Root()
		if not rootPart then
			return false
		end

		local spotPos, preferredLook = ResolveDesiredFishingAnchor()
		if spotPos then
			local flatDist = Vector3.new(spotPos.X - rootPart.Position.X, 0, spotPos.Z - rootPart.Position.Z).Magnitude
			if flatDist > 8 or (spotPos.Y + 1) > rootPart.Position.Y then
				FishingState.PinCFrame = nil
				SetFishingStatus("Going to the fishing spot")
				MoveToEventPosition(spotPos + Vector3.new(0, 3, 0), isAliveCheck, 300)
				return true
			end
		end

		rootPart = Engine.Root()
		if not rootPart then
			return false
		end
		local baseLook = preferredLook or rootPart.CFrame.LookVector
		local baseYaw = math.atan2(baseLook.Z, baseLook.X)
		local chargeRatio = math.clamp(ToFiniteNumber(FarmConfig.Fishing_CastCharge, 0.875), 0.02, 1.0)
		local castReach = 10 + 32 * chargeRatio
		local questCastTarget = FindQuestMarkerPart("CastTarget")

		local waterHitPos = nil
		for fanStep = 0, 12 do
			local signDir = (fanStep % 2 == 0) and 1 or -1
			local yawAngle = baseYaw + signDir * math.ceil(fanStep / 2) * (math.pi / 18)
			local testOrigin = rootPart.Position + Vector3.new(math.cos(yawAngle), 0, math.sin(yawAngle)) * castReach
			local hitWater = ProbeFishingWaterPoint(testOrigin)
			if hitWater then
				local nearQuestRipples = questCastTarget
					and Vector3.new(hitWater.X - questCastTarget.Position.X, 0, hitWater.Z - questCastTarget.Position.Z).Magnitude < 12
				if not nearQuestRipples then
					waterHitPos = hitWater
					break
				end
			end
		end

		if not waterHitPos then
			FishingState.PinCFrame = nil
			SetFishingStatus("Looking for water to fish")
			WaitConditional(1.0, isAliveCheck)
			return true
		end

		FishingState.PinCFrame = BuildDockPinCFrame(rootPart, waterHitPos)
		SetFishingStatus("Casting (" .. tostring(FarmConfig.Fishing_CastLuck or "x1.5 Perfect") .. ")")
		EquipRodTool(rodTool)

		local castData, castErr = CastRodTowardWater(waterHitPos, isAliveCheck)
		FishingState.NextCastAt = os.clock() + 1.2
		if not castData then
			local errLower = string.lower(tostring(castErr or ""))
			FishingState.NextCastAt = os.clock() + (string.find(errLower, "closed", 1, true) and 30 or 3)
			FishingState.PinCFrame = nil
			return true
		end

		local biteWaitSec = tonumber(castData.Wait) or 3.0
		SetFishingStatus("Waiting for a bite")
		if castData.Mode == "GhostFish" then
			if WaitConditional(biteWaitSec + 0.45, isAliveCheck) then
				local castOk, chaseSeed = InvokeProgressionRemote("RF/GhostDogQuest/Cast", castData.Id)
				if castOk and type(chaseSeed) == "number" then
					FishingState.PinCFrame = nil
					DiveAndChaseGhostTarget(chaseSeed, 25, isAliveCheck)
				else
					InvokeProgressionRemote("RF/GhostDogQuest/Abort")
				end
			end
		elseif castData.Mode == "Nothing" or castData.Mode == "Hint" or castData.Mode == "Quest" then
			WaitConditional(biteWaitSec, isAliveCheck)
			FireProgressionRemote("RE/Fishing/Cancel", castData.Id)
		elseif WaitConditional(biteWaitSec, isAliveCheck) then
			SetFishingStatus("Reeling in")
			local fishUi = GetFishingControllerSub("Ui")
			local reelStart = os.clock()
			local reelShown = false
			while (os.clock() - reelStart) < 1.2 and isAliveCheck() do
				local reelAlpha = (os.clock() - reelStart - 1.05) / 0.15
				if fishUi and reelAlpha >= 0 then
					if not reelShown then
						pcall(fishUi.ShowReel, true, "Click Fast!")
						reelShown = true
					end
					local clampedAlpha = math.min(reelAlpha, 1)
					pcall(fishUi.SetReel, clampedAlpha, math.floor(clampedAlpha * 16), "Click Fast!")
					pcall(fishUi.PunchReel)
				end
				RunService.Heartbeat:Wait()
			end
			if fishUi then
				pcall(fishUi.ShowReel, false)
			end

			local reelRemote = ResolveRemote("RF/Fishing/Reel")
			if reelRemote and reelRemote:IsA("RemoteFunction") then
				local callOk, caughtOk, rewardTbl = pcall(reelRemote.InvokeServer, reelRemote, castData.Id, "Caught", 16)
				if callOk and caughtOk and type(rewardTbl) == "table" then
					FishingState.FishCaughtCount = FishingState.FishCaughtCount + 1
					SetFishingStatus("Caught " .. tostring(rewardTbl.DisplayName or "Fish") .. " x" .. tostring(rewardTbl.Amount or 1))
					if fishUi then
						task.spawn(pcall, fishUi.Reveal, rewardTbl, 2.6)
					end
				end
			end
		else
			FireProgressionRemote("RE/Fishing/Cancel", castData.Id)
		end

		FishingState.PinCFrame = nil
		FishingState.NextCastAt = os.clock()
		return true
	end

	local function RunGhostDogAndFishingLoop(expectedGen)
		local function isLoopActive()
			return Hub.Alive
				and not Engine.Disposed
				and expectedGen == FishingState.Gen
				and (FarmConfig.Fishing_AutoQuest or FarmConfig.Fishing_AutoFish)
		end

		while isLoopActive() do
			local character = LocalPlayer.Character
			local inForgottenTown = character and character:GetAttribute("TrainEventInForgottenTown") == true
			local needsHalloweenPortal = FarmConfig.Fishing_AutoQuest
				or (FarmConfig.Fishing_AutoFish and FarmConfig.Fishing_Spot == "Default Pond" and not inForgottenTown)

			if needsHalloweenPortal and LocalPlayer:GetAttribute("InHalloweenDimension") ~= true then
				SetFishingStatus("Entering Halloween Dimension")
				if not Hub.HalloweenMonsters.EnterDimension(isLoopActive) then
					WaitConditional(2.0, isLoopActive)
					continue
				end
			end

			local ranQuest = false
			if FarmConfig.Fishing_AutoQuest and (ReadGhostDogQuestProgress()) < 4 and os.clock() >= FishingState.QuestRetryAt then
				ranQuest = true
				pcall(StepGhostDogQuest, isLoopActive)
			end

			if FarmConfig.Fishing_AutoFish and isLoopActive() then
				local okFish = pcall(StepAutoFishingPass, isLoopActive)
				if not okFish then
					FishingState.PinCFrame = nil
				end
			elseif not ranQuest then
				if FarmConfig.Fishing_AutoQuest and (ReadGhostDogQuestProgress()) >= 4 then
					SetFishingStatus("Ghost Dog quest completed!")
				end
				WaitConditional(1.0, isLoopActive)
			end
			task.wait(0.15)
		end

		FishingState.PinCFrame = nil
		Hub.HalloweenMonsters.StopWalk()
	end

	function FishingState.SaveCurrentSpot()
		local rootPart = Engine.Root()
		if not rootPart then
			SetFishingStatus("Character not ready to save spot")
			return false
		end
		FishingState.SavedSpot = {
			Position = rootPart.Position,
			LookVector = rootPart.CFrame.LookVector,
		}
		FarmConfig.Fishing_Spot = "Saved Spot"
		SetFishingStatus(string.format("Saved spot (%.0f, %.0f, %.0f)", rootPart.Position.X, rootPart.Position.Y, rootPart.Position.Z))
		return true
	end

	function FishingState.Restart()
		FishingState.Gen = FishingState.Gen + 1
		FishingState.PinCFrame = nil
		FishingState.QuestRetryAt = 0
		FishingState.NextCastAt = 0
		Hub.HalloweenMonsters.StopWalk()
		if not FarmConfig.Fishing_AutoQuest and not FarmConfig.Fishing_AutoFish then
			FishingState.Status = "Off"
			return
		end
		local myGen = FishingState.Gen
		task.spawn(RunGhostDogAndFishingLoop, myGen)
	end
	end

	-- 5L. Phantom Express Automation (100% Chilli Mechanics L35275-36025)
	do
		local PhantomState = {
			Gen = 0,
			Busy = false,
			WorldBossBusy = false,
			Status = "Off",
			EventSnap = nil,
			SnapUpdatedAt = 0,
			LastPollAt = 0,
			LastSuckAt = 0,
			DoneDeparture = nil,
			TradedDeparture = nil,
			PromptCache = {},
			PromptMissUntil = {},
			SavedWalkSpeed = nil,
		}
		Hub.PhantomExpress = PhantomState

		local BOARDED_PHASES = {
			Departing = true,
			Transit = true,
			Traveling = true,
			Arriving = true,
			Returning = true,
		}

		local function ConnectTrainEventRemote(remotePath, handlerFn)
			local remoteObj = ResolveRemote(remotePath)
			if remoteObj and remoteObj:IsA("RemoteEvent") then
				Hub.Lifecycle.TrackConnection(remoteObj.OnClientEvent:Connect(handlerFn))
			end
		end

		local function UpdateTrainStateSnapshot(snapshotTbl)
			if type(snapshotTbl) == "table" then
				local prevInvasion = PhantomState.EventSnap and PhantomState.EventSnap.Invasion
				PhantomState.EventSnap = snapshotTbl
				if snapshotTbl.Invasion == nil and prevInvasion ~= nil then
					PhantomState.EventSnap.Invasion = prevInvasion
				end
				PhantomState.SnapUpdatedAt = os.clock()
			end
		end

		ConnectTrainEventRemote("RE/TrainEvent/State", UpdateTrainStateSnapshot)
		ConnectTrainEventRemote("RE/TrainEvent/CaptureState", function(invasionTbl)
			if type(invasionTbl) == "table" then
				PhantomState.EventSnap = PhantomState.EventSnap or {}
				PhantomState.EventSnap.Invasion = invasionTbl
			end
		end)

		local function InvokeTrainAction(...)
			return InvokeProgressionRemote("RF/TrainEvent/Action", ...)
		end

		local function PollTrainStatus()
			local callOk, actionOk, snapTbl = InvokeTrainAction("Status")
			if callOk and actionOk then
				UpdateTrainStateSnapshot(snapTbl)
			end
			return PhantomState.EventSnap
		end

		local function GetCurrentTrainPhase()
			local attrPhase = LocalPlayer:GetAttribute("TrainEventPhase")
			if attrPhase ~= nil then
				return attrPhase
			end
			if PhantomState.EventSnap and (os.clock() - PhantomState.SnapUpdatedAt) < 10 then
				return PhantomState.EventSnap.Phase
			end
			return nil
		end

		local function IsPlayerInForgottenTown()
			local phase = GetCurrentTrainPhase()
			if phase == "Town" then
				return true
			end
			local character = LocalPlayer.Character
			return character ~= nil and character:GetAttribute("TrainEventInForgottenTown") == true
		end

		local function FindTrainPrompt(matchKind, matchValue)
			local cacheKey = tostring(matchKind) .. ":" .. tostring(matchValue)
			local cachedPrompt = PhantomState.PromptCache[cacheKey]
			if cachedPrompt and cachedPrompt.Parent then
				return cachedPrompt
			end
			if os.clock() < (PhantomState.PromptMissUntil[cacheKey] or 0) then
				return nil
			end
			PhantomState.PromptMissUntil[cacheKey] = os.clock() + 5
			local roots = {
				Workspace:FindFirstChild("TrainEventRuntime"),
				Workspace:FindFirstChild("TrainEventAssets"),
				Workspace,
			}
			for _, rootInst in ipairs(roots) do
				if rootInst then
					for _, desc in ipairs(rootInst:GetDescendants()) do
						if desc:IsA("ProximityPrompt") then
							local matched = (matchKind == "Name" and desc.Name == matchValue)
								or (matchKind ~= "Name" and desc:GetAttribute(matchKind) == matchValue)
							if matched then
								PhantomState.PromptCache[cacheKey] = desc
								return desc
							end
						end
					end
				end
			end
			return nil
		end

		local function FindOwnedTrainTool(predicateFn)
			local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
			for _, container in ipairs(containers) do
				if container then
					for _, toolInst in ipairs(container:GetChildren()) do
						if toolInst:IsA("Tool") and predicateFn(toolInst) then
							return toolInst
						end
					end
				end
			end
			return nil
		end

		local function FindConductorTicketTool()
			return FindOwnedTrainTool(function(toolInst)
				return toolInst:GetAttribute("ConductorTicket") == true
			end)
		end

		local function FindGhostVacuumTool(allowBossVacuum)
			return FindOwnedTrainTool(function(toolInst)
				return toolInst:GetAttribute("GhostVacuum") == true
					or (allowBossVacuum and toolInst:GetAttribute("GhostBossVacuum") ~= nil)
			end)
		end

		local function EquipTrainTool(toolInst)
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if toolInst and character and humanoid and toolInst.Parent ~= character then
				pcall(humanoid.EquipTool, humanoid, toolInst)
			end
			return toolInst
		end

		local function FindGhostBossState(realmName)
			local bossNode = ReplicatedStorage:FindFirstChild("GhostBossState")
			local bossPhase = bossNode and bossNode:GetAttribute("Phase")
			if bossNode
				and tostring(bossNode:GetAttribute("BossId") or "") ~= ""
				and (bossPhase == "Alive" or bossPhase == "Spawning")
				and bossNode:GetAttribute("Realm") == realmName
			then
				return bossNode
			end
			return nil
		end

		local function StepVacuumGhoulerBoss(bossNode)
			local groundPos = bossNode:GetAttribute("Ground")
			local rootPart = Engine.Root()
			if typeof(groundPos) ~= "Vector3" or not rootPart then
				return
			end
			local bossVel = bossNode:GetAttribute("Velocity")
			local movedAt = tonumber(bossNode:GetAttribute("MovedAt")) or Workspace:GetServerTimeNow()
			if typeof(bossVel) == "Vector3" then
				groundPos = groundPos + bossVel * math.clamp(Workspace:GetServerTimeNow() - movedAt, 0, 0.3)
			end
			local awayFlat = Vector3.new(rootPart.Position.X - groundPos.X, 0, rootPart.Position.Z - groundPos.Z)
			local standDir = awayFlat.Magnitude > 0.5 and awayFlat.Unit or Vector3.new(1, 0, 0)
			local desiredPos = groundPos + standDir * 42 + Vector3.new(0, 3, 0)
			local moveVec = desiredPos - rootPart.Position
			local nextPos = rootPart.Position + ((moveVec.Magnitude > 2) and (moveVec.Unit * math.min(moveVec.Magnitude, 1.35)) or moveVec)
			pcall(function()
				rootPart.CFrame = CFrame.new(nextPos, Vector3.new(groundPos.X, nextPos.Y, groundPos.Z))
				rootPart.AssemblyLinearVelocity = Vector3.zero
			end)
			if (os.clock() - PhantomState.LastSuckAt) >= 0.25 then
				PhantomState.LastSuckAt = os.clock()
				local aimDir = (groundPos + Vector3.new(0, 8, 0) - rootPart.Position).Unit
				FireProgressionRemote("RE/GhostBoss/Suction", true, aimDir)
			end
		end

		local function MoveToPhantomPoint(goalPos, isAliveCheck)
			if not goalPos then
				return false
			end
			local deadline = os.clock() + 20
			local speedVal = math.clamp(ToFiniteNumber(FarmConfig.Phantom_WalkSpeed, 300), 100, 1000)
			while isAliveCheck() and os.clock() < deadline do
				local rootPart = Engine.Root()
				if not rootPart then
					return false
				end
				local flat = Vector3.new(goalPos.X - rootPart.Position.X, 0, goalPos.Z - rootPart.Position.Z)
				if flat.Magnitude <= 3.5 then
					return true
				end
				Hub.HalloweenMonsters.StepWalkTo(goalPos + Vector3.new(0, 3, 0), speedVal)
				RunService.Heartbeat:Wait()
			end
			Hub.HalloweenMonsters.StopWalk()
			local endRoot = Engine.Root()
			return endRoot ~= nil and (endRoot.Position - goalPos).Magnitude <= 10
		end

		local function TradeAllAvailableSouls(isAliveCheck)
			local shopPrompt = FindTrainPrompt("TrainEventAction", "OpenSoulShop")
			if shopPrompt and shopPrompt.Parent then
				local promptPart = shopPrompt.Parent:IsA("BasePart") and shopPrompt.Parent
					or (shopPrompt.Parent:IsA("Model") and shopPrompt.Parent.PrimaryPart)
				if promptPart and MoveToPhantomPoint(promptPart.Position, isAliveCheck) then
					Engine.FirePrompt(shopPrompt)
					task.wait(0.4)
				end
			end
			local _, _, openData = InvokeTrainAction("OpenSoulShop")
			local soulShop = (type(openData) == "table" and openData.SoulShop)
				or (PhantomState.EventSnap and PhantomState.EventSnap.SoulShop)
			for _ = 1, 150 do
				if not isAliveCheck() or type(soulShop) ~= "table" or not soulShop.CanTrade then
					break
				end
				local curSouls = tonumber(soulShop.Souls) or 0
				local itemCost = tonumber(soulShop.Cost) or math.huge
				if curSouls < itemCost then
					break
				end
				local callOk, tradedOk, tradeReply = InvokeTrainAction("TradeSouls", itemCost)
				if not callOk or not tradedOk then
					break
				end
				local updatedShop = type(tradeReply) == "table" and (tradeReply.SoulShop or (tradeReply.Souls ~= nil and tradeReply)) or nil
				if type(updatedShop) == "table" and updatedShop.Souls ~= nil then
					soulShop = updatedShop
				else
					soulShop.Souls = curSouls - itemCost
				end
				task.wait(0.3)
			end
		end

		local function RunForgottenTownLoop(isAliveCheck)
			local currentGhostTarget = nil
			local function isTownActive()
				return isAliveCheck() and IsPlayerInForgottenTown()
			end

			while isTownActive() do
				local snap = PhantomState.EventSnap
				local invasion = (snap and type(snap.Invasion) == "table") and snap.Invasion or {}
				local townBoss = FarmConfig.Phantom_VacuumBoss and FindGhostBossState("Town") or nil
				local normalVac = FindGhostVacuumTool(false)
				local bossVac = FindGhostVacuumTool(true)

				if not normalVac and not invasion.VacuumOwned then
					local vacPrompt = FindTrainPrompt("TrainEventAction", "PickupVacuum")
					if vacPrompt and vacPrompt.Parent then
						local vacPart = vacPrompt.Parent:IsA("BasePart") and vacPrompt.Parent or nil
						if vacPart and MoveToPhantomPoint(vacPart.Position, isTownActive) then
							Engine.FirePrompt(vacPrompt)
							task.wait(0.8)
						end
					else
						task.wait(0.6)
					end
				elseif townBoss and bossVac then
					EquipTrainTool(bossVac)
					StepVacuumGhoulerBoss(townBoss)
				elseif invasion.Phase == "Active" and normalVac then
					EquipTrainTool(normalVac)
					local visualsFolder = Workspace:FindFirstChild("TrainGhostVisuals")
					local rootPart = Engine.Root()
					if not (currentGhostTarget and currentGhostTarget.Parent) then
						currentGhostTarget = nil
						local bestScore = -math.huge
						for _, ghostInst in ipairs(visualsFolder and visualsFolder:GetChildren() or {}) do
							if ghostInst:GetAttribute("TrainGhost") then
								local okPivot, ghostCF = pcall(function()
									return ghostInst:IsA("Model") and ghostInst:GetPivot() or ghostInst.CFrame
								end)
								local ghostPos = okPivot and ghostCF and ghostCF.Position or nil
								if ghostPos and rootPart then
									local dist = (ghostPos - rootPart.Position).Magnitude
									local tierRank = string.find(ghostInst.Name, "Vengeful", 1, true) and 3
										or (string.find(ghostInst.Name, "Haunted", 1, true) and 2 or 1)
									local score = (FarmConfig.Phantom_GhostTarget == "Closest")
										and (-dist)
										or (tierRank * 100000 - dist)
									if score > bestScore then
										bestScore = score
										currentGhostTarget = ghostInst
									end
								end
							end
						end
					end

					if currentGhostTarget and rootPart then
						local okPivot, ghostCF = pcall(function()
							return currentGhostTarget:IsA("Model") and currentGhostTarget:GetPivot() or currentGhostTarget.CFrame
						end)
						local ghostPos = okPivot and ghostCF and ghostCF.Position or nil
						if ghostPos then
							local capProgress = math.clamp(tonumber(currentGhostTarget:GetAttribute("ServerCaptureProgress")) or 0, 0, 1)
							local ringRadius = (capProgress >= 0.75 and 7) or (capProgress >= 0.5 and 10) or 15
							local awayFlat = Vector3.new(rootPart.Position.X - ghostPos.X, 0, rootPart.Position.Z - ghostPos.Z)
							local standDir = awayFlat.Magnitude > 0.2 and awayFlat.Unit or Vector3.new(1, 0, 0)
							local standPos = Vector3.new(ghostPos.X, rootPart.Position.Y, ghostPos.Z) + standDir * ringRadius

							if FarmConfig.Phantom_TeleportGhost then
								pcall(function()
									rootPart.CFrame = CFrame.new(standPos, Vector3.new(ghostPos.X, standPos.Y, ghostPos.Z))
									rootPart.AssemblyLinearVelocity = Vector3.zero
								end)
							else
								local speedLimit = math.clamp(ToFiniteNumber(FarmConfig.Phantom_WalkSpeed, 300), 100, 1000) * (1 - 0.85 * capProgress)
								Hub.HalloweenMonsters.StepWalkTo(standPos, math.max(12, speedLimit))
								pcall(function()
									rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(ghostPos.X, rootPart.Position.Y, ghostPos.Z))
								end)
							end
						end
					else
						Hub.HalloweenMonsters.StopWalk()
						task.wait(0.25)
					end
				elseif invasion.Phase ~= "Warmup" and invasion.Phase ~= "Active" and snap then
					if FarmConfig.Phantom_TradeSouls and PhantomState.TradedDeparture ~= snap.DepartureAt then
						PhantomState.TradedDeparture = snap.DepartureAt
						TradeAllAvailableSouls(isTownActive)
					end
					if PhantomState.DoneDeparture ~= snap.DepartureAt then
						PhantomState.DoneDeparture = snap.DepartureAt
						local returnPrompt = FindTrainPrompt("Name", "TrainReturn")
						if returnPrompt and returnPrompt.Parent then
							local retPart = returnPrompt.Parent:IsA("BasePart") and returnPrompt.Parent or nil
							if retPart then
								MoveToPhantomPoint(retPart.Position, isTownActive)
							end
						end
						InvokeTrainAction("Return")
					end
					task.wait(0.8)
				else
					task.wait(0.4)
				end
				RunService.Heartbeat:Wait()
			end

			FireProgressionRemote("RE/GhostBoss/Suction", false)
			Hub.HalloweenMonsters.StopWalk()
		end

		local function BoardPhantomExpressTrain(isAliveCheck)
			if LocalPlayer:GetAttribute("InHalloweenDimension") ~= true then
				if not Hub.HalloweenMonsters.EnterDimension(isAliveCheck) then
					return
				end
			end
			local snap = PhantomState.EventSnap
			if snap and not snap.AtStation then
				InvokeTrainAction("Station")
				task.wait(2.5)
				PollTrainStatus()
			end
			local boardPrompt = FindTrainPrompt("Name", "TrainBoard")
			if not boardPrompt or not boardPrompt.Parent then
				return
			end
			local railStart = boardPrompt:GetAttribute("BoardRailStart")
			local boardPos = (typeof(railStart) == "Vector3" and railStart)
				or (boardPrompt.Parent:IsA("BasePart") and boardPrompt.Parent.Position)
			if boardPos and not MoveToPhantomPoint(boardPos, isAliveCheck) then
				return
			end

			local saveData = ReadSaveData()
			local trainSave = saveData and saveData.TrainEvent
			if not (type(trainSave) == "table" and trainSave.AccessUnlocked == true) then
				EquipTrainTool(FindConductorTicketTool())
				task.wait(0.4)
			end
			local callOk, boardedOk = InvokeTrainAction("Board")
			if callOk and boardedOk then
				local waitDeadline = os.clock() + 25
				while isAliveCheck() and os.clock() < waitDeadline do
					local phase = GetCurrentTrainPhase()
					if BOARDED_PHASES[phase] or IsPlayerInForgottenTown() or LocalPlayer:GetAttribute("TrainEventTravelStage") == "Failed" then
						break
					end
					task.wait(0.25)
				end
			end
		end

		local function CanPlayerBoardTrain()
			local saveData = ReadSaveData()
			local trainSave = saveData and saveData.TrainEvent
			if type(trainSave) == "table" and (trainSave.AccessUnlocked == true or (tonumber(trainSave.Tickets) or 0) > 0) then
				return true
			end
			return FindConductorTicketTool() ~= nil
		end

		function PhantomState.Restart()
			PhantomState.Gen = PhantomState.Gen + 1
			FireProgressionRemote("RE/GhostBoss/Suction", false)
			Hub.HalloweenMonsters.StopWalk()
			Progression.Wake()
		end

		AddWorker(function()
			local anyWanted = FarmConfig.Phantom_AutoRide or FarmConfig.Phantom_VacuumBoss or FarmConfig.Phantom_TradeSouls
			if not anyWanted then
				return false
			end
			if (os.clock() - PhantomState.LastPollAt) >= 3.0 then
				PhantomState.LastPollAt = os.clock()
				task.spawn(PollTrainStatus)
			end

			local phase = GetCurrentTrainPhase()
			if BOARDED_PHASES[phase] then
				pcall(RestoreCharacter)
				return false
			end

			-- Overworld Ghouler Boss Vacuuming when not inside Halloween/Town
			if FarmConfig.Phantom_VacuumBoss
				and not PhantomState.WorldBossBusy
				and not IsPlayerInForgottenTown()
				and LocalPlayer:GetAttribute("InHalloweenDimension") ~= true
			then
				local worldBoss = FindGhostBossState("World")
				local bossVac = worldBoss and FindGhostVacuumTool(true) or nil
				if worldBoss and bossVac and not Engine.AutoCarry.Carrying and Engine.ClaimMovement("ghouler") then
					PhantomState.WorldBossBusy = true
					task.spawn(function()
						pcall(function()
							local groundPos = worldBoss:GetAttribute("Ground")
							if typeof(groundPos) == "Vector3" then
								FlyInsideBaseTo(groundPos + Vector3.new(42, 0, 0), function()
									return not FarmConfig.Phantom_VacuumBoss or FindGhostBossState("World") == nil
								end)
							end
							while Hub.Alive and not Engine.Disposed and FarmConfig.Phantom_VacuumBoss and FindGhostBossState("World") ~= nil do
								EquipTrainTool(FindGhostVacuumTool(true))
								StepVacuumGhoulerBoss(worldBoss)
								RunService.Heartbeat:Wait()
							end
						end)
						FireProgressionRemote("RE/GhostBoss/Suction", false)
						Engine.ReleaseMovement("ghouler")
						PhantomState.WorldBossBusy = false
						Progression.Wake()
					end)
					return true
				end
			end

			if PhantomState.Busy or not (FarmConfig.Phantom_AutoRide or FarmConfig.Phantom_TradeSouls) then
				return false
			end

			local inTown = IsPlayerInForgottenTown()
			local snap = PhantomState.EventSnap
			local trainOpen = snap ~= nil
				and snap.ArrivalOpen == true
				and Workspace:GetServerTimeNow() < (tonumber(snap.DepartureAt) or 0)
				and (snap.Phase == "Home" or snap.Phase == nil)

			local modeToRun = nil
			if inTown then
				modeToRun = "town"
			elseif FarmConfig.Phantom_AutoRide and trainOpen and CanPlayerBoardTrain() and PhantomState.DoneDeparture ~= snap.DepartureAt then
				if not Engine.AutoCarry.Carrying then
					modeToRun = "board"
				end
			end

			if not modeToRun or not Engine.ClaimMovement("train") then
				return false
			end

			PhantomState.Busy = true
			local myGen = PhantomState.Gen
			task.spawn(function()
				local function isTrainJobActive()
					return Hub.Alive
						and not Engine.Disposed
						and myGen == PhantomState.Gen
						and (FarmConfig.Phantom_AutoRide or FarmConfig.Phantom_TradeSouls)
						and Engine.Movement.Owner == "train"
				end
				pcall(function()
					if modeToRun == "town" then
						RunForgottenTownLoop(isTrainJobActive)
					else
						BoardPhantomExpressTrain(isTrainJobActive)
					end
				end)
				if not IsPlayerInForgottenTown() then
					Engine.ReleaseMovement("train")
				end
				PhantomState.Busy = false
				Progression.Wake()
			end)
			return true
		end)
	end

	-- 5M. Auto Butterfly Bloom & Workshop (100% Chilli Mechanics)
	do
		local ButterflyState = {
			Gen = 0,
			Busy = false,
			Status = "Off",
			Flights = {},
			Counts = { Green = 0, Blue = 0, Purple = 0, Golden = 0 },
			Essence = 0,
			NetClaimed = false,
			Recipe = { Green = 240, Blue = 115, Purple = 40, Golden = 1 },
			TradeCost = { Green = 10, Blue = 10, Purple = 50 },
			CircleAngle = 0,
			PatrolTravel = 0,
			ChaseLock = nil,
			NextWorkshopAt = 0,
		}
		Hub.AutoButterfly = ButterflyState

		local TIER_ORDER = { "Green", "Blue", "Purple", "Golden" }
		local TIER_LABELS = { Green = "Emerald", Blue = "Sapphire", Purple = "Amethyst", Golden = "Radiant" }
		local TIER_RANK = { Green = 1, Blue = 2, Purple = 3, Golden = 4 }

		local CatalogModule = RequireGameModule("Shared", "Modules", "ButterflyCatalog")
		local SwarmModule = nil
		pcall(function()
			local ctrl = ReplicatedStorage:FindFirstChild("Controllers")
			local gameCtrl = ctrl and ctrl:FindFirstChild("Game")
			local adminCtrl = gameCtrl and gameCtrl:FindFirstChild("AdminAbuseClientController")
			local eventsFolder = adminCtrl and adminCtrl:FindFirstChild("Events")
			local bloomFolder = eventsFolder and eventsFolder:FindFirstChild("ButterflyBloom")
			local swarmScript = bloomFolder and bloomFolder:FindFirstChild("Swarm")
			if swarmScript and swarmScript:IsA("ModuleScript") then
				SwarmModule = require(swarmScript)
			end
		end)

		local function BindButterflyRemote(remotePath, callbackFn)
			local remoteObj = ResolveRemote(remotePath)
			if remoteObj and remoteObj:IsA("RemoteEvent") then
				Hub.Lifecycle.TrackConnection(remoteObj.OnClientEvent:Connect(callbackFn))
			end
		end

		BindButterflyRemote("RE/Butterflies/Spawned", function(flightData)
			if type(flightData) == "table" and flightData.Id ~= nil then
				ButterflyState.Flights[flightData.Id] = flightData
			end
		end)
		BindButterflyRemote("RE/Butterflies/Removed", function(flightId)
			ButterflyState.Flights[flightId] = nil
		end)
		BindButterflyRemote("RE/Butterflies/Escaped", function(argA, argB)
			local flightData = type(argA) == "table" and argA or argB
			if type(flightData) == "table" and flightData.Id ~= nil then
				ButterflyState.Flights[flightData.Id] = flightData
			end
		end)

		local function RefreshButterflySave()
			local saveData = ReadSaveData()
			if not saveData then
				return false
			end
			local record = type(saveData.Butterflies) == "table" and saveData.Butterflies or {}
			local counts = type(record.Counts) == "table" and record.Counts or {}
			for _, tier in ipairs(TIER_ORDER) do
				ButterflyState.Counts[tier] = tonumber(counts[tier]) or 0
			end
			ButterflyState.Essence = tonumber(record.Essence) or 0
			ButterflyState.NetClaimed = (record.NetClaimed == true)
			return true
		end

		local function FindButterflyNetTool()
			local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
			for _, container in ipairs(containers) do
				if container then
					for _, toolInst in ipairs(container:GetChildren()) do
						if toolInst:IsA("Tool") and (
							toolInst:GetAttribute("ButterflyNet") == true
							or tostring(toolInst:GetAttribute("ItemType")) == "ButterflyNet"
							or toolInst.Name == "Butterfly Net"
						) then
							return toolInst
						end
					end
				end
			end
			return nil
		end

		local function FindBloomBoundsPart()
			local world = Workspace:FindFirstChild("World")
			local areas = world and world:FindFirstChild("Areas")
			local bloomArea = areas and areas:FindFirstChild("ButterflyBloom")
			local bounds = bloomArea and bloomArea:FindFirstChild("Bounds")
			return (bounds and bounds:IsA("BasePart")) and bounds or nil
		end

		local function GetBloomCenterPos()
			local bounds = FindBloomBoundsPart()
			return bounds and (bounds.Position + Vector3.new(0, 6, 0)) or Vector3.new(6700, 74, -364)
		end

		local function FindButterflyMachinePos(stationName)
			local world = Workspace:FindFirstChild("World")
			local machines = world and world:FindFirstChild("Machines")
			local stationRoot = machines and machines:FindFirstChild("ButterflyStation")
			local station = stationRoot and stationRoot:FindFirstChild(stationName)
			if not station then
				return nil
			end
			local anchor = station:FindFirstChild("Anchor") or station
			if anchor:IsA("BasePart") then
				return anchor.Position
			elseif anchor:IsA("Model") then
				local okPiv, pivCF = pcall(anchor.GetPivot, anchor)
				return okPiv and pivCF and pivCF.Position or nil
			end
			return nil
		end

		local function CollectLiveButterflies()
			local list, seenIds = {}, {}
			if SwarmModule and type(SwarmModule.Each) == "function" then
				pcall(function()
					for key, member in SwarmModule.Each() do
						if type(member) == "table" then
							local flight = type(member.Flight) == "table" and member.Flight or nil
							local bfId = (flight and flight.Id) or key
							local bodyInst = member.Body
							local bodyPos = nil
							if typeof(bodyInst) == "Instance" then
								if bodyInst:IsA("BasePart") then
									bodyPos = bodyInst.Position
								elseif bodyInst:IsA("Model") then
									local okP, cfP = pcall(bodyInst.GetPivot, bodyInst)
									bodyPos = okP and cfP and cfP.Position or nil
								end
							end
							if bfId ~= nil and bodyPos then
								seenIds[bfId] = true
								table.insert(list, {
									Id = bfId,
									Tier = tostring((flight and flight.Tier) or "Green"),
									Position = bodyPos,
									Flight = flight,
								})
							end
						end
					end
				end)
			end
			if CatalogModule and type(CatalogModule.PositionAt) == "function" then
				local serverNow = Workspace:GetServerTimeNow()
				for bfId, flight in pairs(ButterflyState.Flights) do
					if not seenIds[bfId] then
						local callOk, posVec = pcall(CatalogModule.PositionAt, flight, serverNow)
						if callOk and typeof(posVec) == "Vector3" then
							table.insert(list, {
								Id = bfId,
								Tier = tostring(flight.Tier or "Green"),
								Position = posVec,
								Flight = flight,
							})
						end
					end
				end
			end
			return list
		end

		local function PickTargetButterfly(candidates, originPos)
			local bounds = FindBloomBoundsPart()
			local speedVal = math.max(ToFiniteNumber(FarmConfig.Butterfly_Speed, 320), 60)
			local bestBf, bestScore = nil, nil
			for _, candidate in ipairs(candidates) do
				local insideBounds = true
				if bounds then
					local rel = bounds.CFrame:PointToObjectSpace(candidate.Position)
					insideBounds = math.abs(rel.X) <= (bounds.Size.X * 0.5 + 80)
						and math.abs(rel.Z) <= (bounds.Size.Z * 0.5 + 80)
						and math.abs(rel.Y) <= 120
				end
				if insideBounds and (next(FarmConfig.Butterfly_Tiers) == nil or FarmConfig.Butterfly_Tiers[candidate.Tier]) then
					local score = (candidate.Position - originPos).Magnitude / speedVal
					if FarmConfig.Butterfly_Priority == "Rarest" then
						score = score + (5 - (TIER_RANK[candidate.Tier] or 1)) * 1000
					end
					if not bestScore or score < bestScore then
						bestScore = score
						bestBf = candidate
					end
				end
			end
			return bestBf
		end

		local function ComputeSmartTradePlan(counts)
			local recipe = ButterflyState.Recipe
			local cost = ButterflyState.TradeCost
			for essenceGoal = 60, 1, -1 do
				local purpleTrades = math.max(0, essenceGoal * recipe.Golden - (counts.Golden or 0))
				local blueTrades = math.max(0, essenceGoal * recipe.Purple + cost.Purple * purpleTrades - (counts.Purple or 0))
				local greenTrades = math.max(0, essenceGoal * recipe.Blue + cost.Blue * blueTrades - (counts.Blue or 0))
				if (counts.Green or 0) >= (essenceGoal * recipe.Green + cost.Green * greenTrades) then
					return { Green = greenTrades, Blue = blueTrades, Purple = purpleTrades }
				end
			end
			return nil
		end

		local function CanCraftEssenceNow()
			for _, tier in ipairs(TIER_ORDER) do
				if (ButterflyState.Counts[tier] or 0) < ButterflyState.Recipe[tier] then
					return false
				end
			end
			return true
		end

		local function IsWorkshopWorkNeeded()
			if not RefreshButterflySave() or LocalPlayer:GetAttribute("EnchantedTreeUnlocked") ~= true then
				return false
			end
			if FarmConfig.Butterfly_Trade and FarmConfig.Butterfly_Smart then
				local plan = ComputeSmartTradePlan(ButterflyState.Counts)
				if plan and (FarmConfig.Butterfly_Craft or (plan.Green + plan.Blue + plan.Purple) > 0) then
					return true
				end
			end
			if FarmConfig.Butterfly_Craft and CanCraftEssenceNow() then
				return true
			end
			if FarmConfig.Butterfly_Trade then
				for _, tier in ipairs({ "Green", "Blue", "Purple" }) do
					local reserve = FarmConfig.Butterfly_Craft and ButterflyState.Recipe[tier] or 0
					if FarmConfig.Butterfly_TradeTiers[tier] and (ButterflyState.Counts[tier] - reserve) >= ButterflyState.TradeCost[tier] then
						return true
					end
				end
			end
			return false
		end

		local function EnterEnchantedTreeIfNeeded(isAliveCheck)
			if LocalPlayer:GetAttribute("InEnchantedTree") == true then
				return true
			end
			local world = Workspace:FindFirstChild("World")
			local interior = world and world:FindFirstChild("Build") and world.Build:FindFirstChild("EnchantedTreeInterior")
			local markers = interior and interior:FindFirstChild("Markers")
			local enterTrig = markers and markers:FindFirstChild("EnterTrigger")
			local entrance = enterTrig and enterTrig:FindFirstChild("EnchantedTreeEntrance")
			local promptInst = entrance and entrance:FindFirstChild("EnchantedTreePrompt")
			if not promptInst or not promptInst:IsA("ProximityPrompt") then
				return false
			end
			local promptParent = promptInst.Parent
			local promptPos = (promptParent:IsA("Attachment") and promptParent.WorldPosition)
				or (promptParent:IsA("BasePart") and promptParent.Position)
			if not promptPos then
				return false
			end
			if not Engine.FlyToPosition(promptPos + Vector3.new(0, 3, -6), RuntimeState.SessionId, 5, 45, 500, true) then
				return false
			end
			for _ = 1, 3 do
				if not isAliveCheck() then
					return false
				end
				if LocalPlayer:GetAttribute("InEnchantedTree") == true then
					return true
				end
				local rootPart = Engine.Root()
				if rootPart and (rootPart.Position - promptPos).Magnitude > 6 then
					pcall(function()
						rootPart.CFrame = CFrame.new(promptPos + Vector3.new(0, 3, -2))
					end)
				end
				Engine.FirePrompt(promptInst)
				task.wait(1.0)
			end
			return LocalPlayer:GetAttribute("InEnchantedTree") == true
		end

		local function LeaveEnchantedTree()
			if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
				return
			end
			local world = Workspace:FindFirstChild("World")
			local interior = world and world:FindFirstChild("Build") and world.Build:FindFirstChild("EnchantedTreeInterior")
			local exitMarker = interior and interior:FindFirstChild("Markers") and interior.Markers:FindFirstChild("ExitTrigger")
			if exitMarker and exitMarker:IsA("BasePart") then
				FlyInsideBaseTo(exitMarker.Position, function()
					return LocalPlayer:GetAttribute("InEnchantedTree") ~= true
				end)
				task.wait(0.8)
			end
		end
		ButterflyState.EnterEnchantedTree = EnterEnchantedTreeIfNeeded
		ButterflyState.LeaveEnchantedTree = LeaveEnchantedTree

		local function RunButterflyBloomCatchLoop(isAliveCheck)
			local netTool = FindButterflyNetTool()
			if not netTool and not ButterflyState.NetClaimed then
				for _, stationName in ipairs({ "NetStand", "ButterflyMachine" }) do
					local stationPos = FindButterflyMachinePos(stationName)
					if stationPos and Engine.FlyToPosition(stationPos + Vector3.new(0, 3, 4), RuntimeState.SessionId, 6, 40, 500, true) then
						ButterflyState.Status = "Claiming Butterfly Net"
						InvokeProgressionRemote("RF/Butterflies/AskClaimNet")
						task.wait(1.2)
						RefreshButterflySave()
						netTool = FindButterflyNetTool()
						if netTool then
							break
						end
					end
				end
			end
			netTool = FindButterflyNetTool()
			if not netTool then
				ButterflyState.Status = "Waiting for Butterfly Net tool"
				return
			end

			local centerPos = GetBloomCenterPos()
			local rootPart = Engine.Root()
			if rootPart and (rootPart.Position - centerPos).Magnitude > 120 then
				if Engine.IsNight() or Engine.WallSealed() then
					ButterflyState.Status = "Waiting for daylight / open wall"
					return
				end
				ButterflyState.Status = "Flying to Butterfly Bloom"
				if not Engine.FlyToPosition(centerPos, RuntimeState.SessionId, 8, 50, 500, true) then
					return
				end
			end

			while isAliveCheck() and Workspace:GetAttribute("Event_ButterflyBloom") == true do
				local character = LocalPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local liveRoot = Engine.Root()
				if not character or not humanoid or not liveRoot then
					break
				end
				netTool = FindButterflyNetTool()
				if not netTool then
					break
				end
				if netTool.Parent ~= character then
					pcall(humanoid.EquipTool, humanoid, netTool)
				end

				local deltaTime = math.clamp(tonumber(RunService.Heartbeat:Wait()) or (1 / 60), 1 / 240, 0.1)
				local candidates = CollectLiveButterflies()
				local speedLimit = math.clamp(ToFiniteNumber(FarmConfig.Butterfly_Speed, 320), 100, 600)
				local mode = FarmConfig.Butterfly_Mode

				if mode ~= "Chase" then
					local goalPos = GetBloomCenterPos()
					local bounds = FindBloomBoundsPart()
					if bounds and mode == "Circle" then
						ButterflyState.CircleAngle = (ButterflyState.CircleAngle + (speedLimit / 25) * deltaTime) % (math.pi * 2)
						goalPos = bounds.Position
							+ Vector3.new(math.cos(ButterflyState.CircleAngle) * 25, 6, math.sin(ButterflyState.CircleAngle) * 25)
					elseif bounds and mode == "Patrol" then
						local halfSpan = math.max(20, math.max(bounds.Size.X, bounds.Size.Z) * 0.5 - 30)
						ButterflyState.PatrolTravel = (ButterflyState.PatrolTravel + speedLimit * deltaTime) % (4 * halfSpan)
						local axisOffset = (ButterflyState.PatrolTravel < 2 * halfSpan)
							and (ButterflyState.PatrolTravel - halfSpan)
							or (3 * halfSpan - ButterflyState.PatrolTravel)
						goalPos = bounds.Position + Vector3.new(axisOffset, 6, 0)
					end
					local delta = goalPos - liveRoot.Position
					liveRoot.AssemblyLinearVelocity = (delta.Magnitude > 1.5)
						and (delta.Unit * math.min(speedLimit, delta.Magnitude / deltaTime))
						or Vector3.zero
					ButterflyState.Status = string.format("%s - %d butterflies flying", mode, #candidates)
				else
					local target = nil
					if ButterflyState.ChaseLock and os.clock() < ButterflyState.ChaseLock.UntilAt then
						for _, item in ipairs(candidates) do
							if item.Id == ButterflyState.ChaseLock.Id then
								target = item
								break
							end
						end
					end
					if not target then
						target = PickTargetButterfly(candidates, liveRoot.Position)
						if target then
							ButterflyState.ChaseLock = { Id = target.Id, UntilAt = os.clock() + 1.0 }
						end
					end
					if target then
						local delta = target.Position - liveRoot.Position
						if delta.Magnitude <= 35 then
							pcall(function()
								liveRoot.CFrame = CFrame.new(target.Position) * liveRoot.CFrame.Rotation
								liveRoot.AssemblyLinearVelocity = Vector3.zero
							end)
						else
							liveRoot.AssemblyLinearVelocity = delta.Unit * math.min(speedLimit, delta.Magnitude / deltaTime)
						end
						ButterflyState.Status = string.format(
							"Chasing %s - %d flying",
							TIER_LABELS[target.Tier] or target.Tier,
							#candidates
						)
					else
						ButterflyState.Status = "Waiting for matching butterflies"
						liveRoot.AssemblyLinearVelocity = Vector3.zero
					end
				end
			end
			Engine.StopVelocity()
		end

		local function RunButterflyWorkshopTrip(isAliveCheck)
			ButterflyState.NextWorkshopAt = os.clock() + 45
			if not EnterEnchantedTreeIfNeeded(isAliveCheck) then
				ButterflyState.Status = "Enchanted Tree entry not confirmed"
				return
			end

			if FarmConfig.Butterfly_Trade then
				local smartPlan = FarmConfig.Butterfly_Smart and ComputeSmartTradePlan(ButterflyState.Counts) or nil
				local machinePos = FindButterflyMachinePos("ButterflyMachine")
				if machinePos and FlyInsideBaseTo(machinePos, function() return not isAliveCheck() end) then
					for _, tier in ipairs({ "Green", "Blue", "Purple" }) do
						local maxTrades = smartPlan and smartPlan[tier]
							or ((not FarmConfig.Butterfly_Smart and FarmConfig.Butterfly_TradeTiers[tier]) and 200 or 0)
						for _ = 1, maxTrades do
							if not isAliveCheck() or not RefreshButterflySave() then
								break
							end
							local reserve = (FarmConfig.Butterfly_Craft and not FarmConfig.Butterfly_Smart) and ButterflyState.Recipe[tier] or 0
							if (ButterflyState.Counts[tier] - reserve) < ButterflyState.TradeCost[tier] then
								break
							end
							ButterflyState.Status = "Trading " .. (TIER_LABELS[tier] or tier)
							local callOk, tradeRes = InvokeProgressionRemote("RF/Butterflies/AskTradeUp", tier)
							if not callOk or tradeRes == false then
								break
							end
							task.wait(0.2)
						end
					end
				end
			end

			if FarmConfig.Butterfly_Craft and RefreshButterflySave() and CanCraftEssenceNow() then
				local shrinePos = FindButterflyMachinePos("MutationShrine")
				if shrinePos and FlyInsideBaseTo(shrinePos, function() return not isAliveCheck() end) then
					for _ = 1, 30 do
						if not isAliveCheck() or not RefreshButterflySave() or not CanCraftEssenceNow() then
							break
						end
						ButterflyState.Status = "Crafting Enchanted Essence"
						local callOk, craftRes = InvokeProgressionRemote("RF/Butterflies/AskCraftEssence")
						if not callOk or craftRes == false then
							break
						end
						task.wait(0.3)
					end
				end
			end

			LeaveEnchantedTree()
			ButterflyState.Status = "Workshop pass finished"
		end

		function ButterflyState.Restart()
			ButterflyState.Gen = ButterflyState.Gen + 1
			ButterflyState.NextWorkshopAt = 0
			Progression.Wake()
		end

		AddWorker(function()
			local anyToggle = FarmConfig.Butterfly_Auto or FarmConfig.Butterfly_Trade or FarmConfig.Butterfly_Craft
			if not anyToggle then
				if not FarmConfig.Wisp_Auto and not FarmConfig.Banjo_Auto then
					ButterflyState.Status = "Off"
				end
				return false
			end
			if ButterflyState.Busy or Engine.AutoCarry.Carrying then
				return false
			end

			local bloomLive = FarmConfig.Butterfly_Auto and Workspace:GetAttribute("Event_ButterflyBloom") == true
			local workshopDue = (not bloomLive)
				and os.clock() >= ButterflyState.NextWorkshopAt
				and not Engine.IsNight()
				and not Engine.WallSealed()
				and IsWorkshopWorkNeeded()

			if not bloomLive and not workshopDue then
				if FarmConfig.Butterfly_Auto then
					ButterflyState.Status = "Waiting for Butterfly Bloom event"
				end
				return false
			end
			if not Engine.ClaimMovement("butterfly") then
				return false
			end

			ButterflyState.Busy = true
			local myGen = ButterflyState.Gen
			task.spawn(function()
				local function isBfJobActive()
					return Hub.Alive and not Engine.Disposed and myGen == ButterflyState.Gen and Engine.Movement.Owner == "butterfly"
				end
				if TreadmillState.Riding or IsPlayerOnBelt() then
					ExitTreadmillBelt()
				end
				pcall(RestoreCharacter)
				pcall(function()
					if bloomLive then
						RunButterflyBloomCatchLoop(isBfJobActive)
					else
						RunButterflyWorkshopTrip(isBfJobActive)
					end
				end)
				Engine.StopVelocity()
				Engine.ReleaseMovement("butterfly")
				ButterflyState.Busy = false
				Progression.Wake()
			end)
			return true
		end)
	end

	-- 5N. Auto Wisp & Auto Banjo Cricket (100% Chilli Mechanics)
	do
		local WispBanjoState = {
			WispBusy = false,
			BanjoBusy = false,
			Gen = 0,
			Status = "Off",
			NextWispAt = 0,
			NextBanjoAt = 0,
			Notes = nil,
			ListenUntil = 0,
			PlaybackVer = 0,
			ClearedStages = 0,
			Serial = 0,
			WrongSerial = 0,
			NoteAcks = {},
			LastEffectAt = 0,
			Solved = false,
		}
		Hub.WispBanjo = WispBanjoState

		local WispQuestsModule = RequireGameModule("Data", "WispQuests")
		local BanjoDataModule = RequireGameModule("Data", "BanjoCricket")

		local MUSHROOM_FALLBACKS = {
			Vector3.new(6218.93, 17159.02, 16903.8),
			Vector3.new(6257.93, 17159.02, 16912.8),
			Vector3.new(6270.93, 17159.02, 16903.8),
			Vector3.new(6244.93, 17159.02, 16918.8),
			Vector3.new(6231.93, 17159.02, 16912.8),
		}
		local ROOM_CENTER = Vector3.new(6244.93, 17159.02, 16880)
		local ROOM_SPAWN = Vector3.new(6246.9, 17161, 16887)
		local LEAP_HINT_FALLBACK = Vector3.new(5905.63, 17027.3, 15610.83)
		local NPC_FALLBACK = Vector3.new(6272.46, 17164.04, 16958.18)

		local banjoEffectRemote = ResolveRemote("RE/BanjoCricket/Effect")
		if banjoEffectRemote and banjoEffectRemote:IsA("RemoteEvent") then
			Hub.Lifecycle.TrackConnection(banjoEffectRemote.OnClientEvent:Connect(function(msg)
				if not FarmConfig.Banjo_Auto or Engine.Movement.Owner ~= "banjo" or type(msg) ~= "table" then
					return
				end
				WispBanjoState.Serial = WispBanjoState.Serial + 1
				WispBanjoState.LastEffectAt = os.clock()
				if msg.Kind == "Playback" and type(msg.Notes) == "table" and #msg.Notes > 0 and #msg.Notes <= 256 then
					local parsedNotes = {}
					for _, rawNote in ipairs(msg.Notes) do
						local noteNumber = tonumber(rawNote)
						if not noteNumber or noteNumber % 1 ~= 0 or noteNumber < 1 or noteNumber > 5 then
							return
						end
						table.insert(parsedNotes, noteNumber)
					end
					local pbSec = (#parsedNotes * 0.65 + 0.5)
					if BanjoDataModule and type(BanjoDataModule.PlaybackSeconds) == "function" then
						local okS, sVal = pcall(BanjoDataModule.PlaybackSeconds, #parsedNotes)
						if okS and tonumber(sVal) then
							pbSec = tonumber(sVal)
						end
					end
					WispBanjoState.Notes = parsedNotes
					WispBanjoState.ListenUntil = os.clock() + pbSec
					WispBanjoState.PlaybackVer = WispBanjoState.PlaybackVer + 1
				elseif msg.Kind == "Note" then
					table.insert(WispBanjoState.NoteAcks, {
						Mushroom = tonumber(msg.Mushroom),
						Serial = WispBanjoState.Serial,
					})
					if #WispBanjoState.NoteAcks > 40 then
						table.remove(WispBanjoState.NoteAcks, 1)
					end
				elseif msg.Kind == "Wrong" then
					WispBanjoState.WrongSerial = WispBanjoState.Serial
					WispBanjoState.Notes = nil
					WispBanjoState.PlaybackVer = WispBanjoState.PlaybackVer + 1
				elseif msg.Kind == "StageComplete" then
					WispBanjoState.ClearedStages = tonumber(msg.Cleared) or WispBanjoState.ClearedStages
				elseif msg.Kind == "Reset" then
					WispBanjoState.Notes = nil
					WispBanjoState.ClearedStages = 0
					WispBanjoState.PlaybackVer = WispBanjoState.PlaybackVer + 1
				elseif msg.Kind == "Solved" then
					WispBanjoState.Solved = true
				end
			end))
		end

		local function ResolveWorldNodePos(pathNames)
			local cur = Workspace:FindFirstChild("World")
			for _, seg in ipairs(pathNames) do
				cur = cur and cur:FindFirstChild(seg)
			end
			if not cur then
				return nil
			end
			if cur:IsA("BasePart") then
				return cur.Position
			elseif cur:IsA("Model") then
				local okP, cfP = pcall(cur.GetPivot, cur)
				return okP and cfP and cfP.Position or nil
			end
			return nil
		end

		local function RunWispPass(isAliveCheck)
			local saveData = ReadSaveData()
			local record = saveData and saveData.WispCompanion
			if type(record) ~= "table" or type(WispQuestsModule) ~= "table" then
				WispBanjoState.Status = "Waiting for Wisp quest data"
				return
			end
			if record.Unlocked == true then
				WispBanjoState.Status = "Wisp Done - Enchanted Tree open"
				return
			end

			local requiredPower = tonumber(WispQuestsModule.RequiredSpeedPower) or 50000000000
			local stageCount = tonumber(WispQuestsModule.StageCount) or 4
			if not record.Accepted then
				if (tonumber(saveData.SpeedPower) or 0) < requiredPower then
					WispBanjoState.Status = "Wisp needs more Speed Power"
					return
				end
				local spawnPos = ResolveWorldNodePos({ "Build", "EnchantedForestZone", "WispSpawn" })
				if spawnPos then
					WispBanjoState.Status = "Flying to Wisp Spawn"
					if Engine.FlyToPosition(spawnPos + Vector3.new(0, 3, 0), RuntimeState.SessionId, 6, 55, 500, true) and isAliveCheck() then
						InvokeProgressionRemote("RF/WispCompanion/Request", "Accept")
						WispBanjoState.Status = "Accepted Wisp Quest"
					end
				end
				return
			end

			local stageIdx = tonumber(record.Stage) or 1
			local questDef = type(WispQuestsModule.List) == "table" and WispQuestsModule.List[stageIdx] or nil
			if questDef then
				local prog = type(record.Progress) == "table" and tonumber(record.Progress[questDef.Id]) or 0
				local target = tonumber(questDef.Target) or 1
				local claimed = type(record.Claimed) == "table" and record.Claimed[questDef.Id] == true
				if prog >= target and not claimed then
					InvokeProgressionRemote("RF/WispCompanion/Request", "Claim", questDef.Id)
					WispBanjoState.Status = "Claimed Wisp Stage " .. tostring(stageIdx)
					return
				end
			end

			if stageIdx >= stageCount then
				if not record.Returning then
					InvokeProgressionRemote("RF/WispCompanion/Request", "BeginReturn")
					return
				end
				local anchorPos = ResolveWorldNodePos({ "Build", "EnchantedForestZone", "Zone13Props", "EnchantedTree", "WispAnchor" })
				if anchorPos then
					WispBanjoState.Status = "Returning Wisp to Enchanted Tree"
					if Engine.FlyToPosition(anchorPos + Vector3.new(0, 3, 0), RuntimeState.SessionId, 6, 55, 500, true) and isAliveCheck() then
						InvokeProgressionRemote("RF/WispCompanion/Request", "Return")
					end
				end
				return
			end
			WispBanjoState.Status = "Wisp Stage " .. tostring(stageIdx) .. " in progress"
		end

		local function FindTaggedPos(tagName, mushroomIdx, fallbackPos)
			local okTag, tagged = pcall(CollectionService.GetTagged, CollectionService, tagName)
			if okTag and type(tagged) == "table" then
				for _, inst in ipairs(tagged) do
					if mushroomIdx == nil or tonumber(inst:GetAttribute("MushroomIndex")) == mushroomIdx then
						local hitboxPart = inst:FindFirstChild("Hitbox") or inst:FindFirstChild("Hitbox Part")
						if hitboxPart and hitboxPart:IsA("BasePart") then
							return hitboxPart.Position
						elseif inst:IsA("Model") then
							local okP, cfP = pcall(inst.GetPivot, inst)
							if okP and cfP then
								return cfP.Position
							end
						elseif inst:IsA("BasePart") then
							return inst.Position
						end
					end
				end
			end
			return fallbackPos
		end

		local function FindAnyBatTool()
			local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
			for _, container in ipairs(containers) do
				if container then
					for _, toolInst in ipairs(container:GetChildren()) do
						if toolInst:IsA("Tool") and (toolInst:GetAttribute("IsBat") == true or string.find(string.lower(toolInst.Name), "bat", 1, true)) then
							return toolInst
						end
					end
				end
			end
			return nil
		end

		local function RunBanjoCricketPass(isAliveCheck)
			local saveData = ReadSaveData()
			local banjoSave = saveData and type(saveData.BanjoCricket) == "table" and saveData.BanjoCricket or {}
			if banjoSave.Claimed == true then
				WispBanjoState.Status = "Banjo Cricket already claimed"
				return
			end
			if not Hub.AutoButterfly.EnterEnchantedTree(isAliveCheck) then
				WispBanjoState.Status = "Banjo: waiting for Enchanted Tree entry"
				return
			end

			local function isInSecretRoom()
				local rootPart = Engine.Root()
				return LocalPlayer:GetAttribute("InEnchantedTree") == true
					and rootPart ~= nil
					and (rootPart.Position - ROOM_SPAWN).Magnitude <= 125
			end

			if not isInSecretRoom() then
				local world = Workspace:FindFirstChild("World")
				local interior = world and world:FindFirstChild("Build") and world.Build:FindFirstChild("EnchantedTreeInterior")
				local hintNode = interior and interior:FindFirstChild("SecretLeapHint")
				local streaks = hintNode and hintNode:FindFirstChild("Streaks")
				local leapPos = (streaks and streaks:IsA("BasePart") and streaks.Position) or LEAP_HINT_FALLBACK
				WispBanjoState.Status = "Banjo: flying to Secret Leap"
				FlyInsideBaseTo(leapPos + Vector3.new(0, 18, 0), function()
					return not isAliveCheck() or isInSecretRoom()
				end)
				local fallDeadline = os.clock() + 8
				while isAliveCheck() and not isInSecretRoom() and os.clock() < fallDeadline do
					task.wait(0.1)
				end
			end
			if not isInSecretRoom() then
				return
			end

			local function hitMushroomNote(noteIdx, expectedVer)
				if not isAliveCheck() or (expectedVer ~= nil and WispBanjoState.PlaybackVer ~= expectedVer) then
					return nil
				end
				local targetPos = FindTaggedPos("BanjoCricketMushroom", noteIdx, MUSHROOM_FALLBACKS[noteIdx])
				if not targetPos then
					return nil
				end
				local centerDir = Vector3.new(ROOM_CENTER.X - targetPos.X, 0, ROOM_CENTER.Z - targetPos.Z)
				local standPos = targetPos + ((centerDir.Magnitude > 0.01 and centerDir.Unit or Vector3.new(0, 0, -1)) * 6.5)
				FlyInsideBaseTo(standPos, function()
					return not isAliveCheck() or (expectedVer ~= nil and WispBanjoState.PlaybackVer ~= expectedVer)
				end)
				local batTool = FindAnyBatTool()
				local character = LocalPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local rootPart = Engine.Root()
				if not batTool or not character or not humanoid or not rootPart then
					WispBanjoState.Status = "Banjo: needs a Bat in bag"
					return nil
				end
				if batTool.Parent ~= character then
					pcall(humanoid.EquipTool, humanoid, batTool)
					task.wait(0.25)
				end
				local waitReady = os.clock() + 2.0
				while isAliveCheck() and os.clock() < waitReady do
					if batTool:GetAttribute("CooldownActive") ~= true
						or Workspace:GetServerTimeNow() >= (tonumber(batTool:GetAttribute("CooldownEndTime")) or 0)
					then
						break
					end
					task.wait(0.05)
				end
				pcall(function()
					rootPart.CFrame = CFrame.lookAt(rootPart.Position, Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z))
					rootPart.AssemblyLinearVelocity = Vector3.zero
				end)
				local beforeSerial = WispBanjoState.Serial
				FireProgressionRemote("RE/BanjoCricket/Aim", noteIdx)
				pcall(batTool.Activate, batTool)
				return beforeSerial
			end

			local solveDeadline = os.clock() + 240
			while isAliveCheck() and isInSecretRoom() and os.clock() < solveDeadline do
				local liveSave = ReadSaveData()
				local liveBanjo = liveSave and type(liveSave.BanjoCricket) == "table" and liveSave.BanjoCricket or {}
				if WispBanjoState.Solved or liveBanjo.Solved == true then
					break
				end
				local notes, ver = WispBanjoState.Notes, WispBanjoState.PlaybackVer
				if not notes then
					if (os.clock() - WispBanjoState.LastEffectAt) > 4.0 then
						WispBanjoState.Status = "Banjo: waking mushrooms"
						hitMushroomNote(4, nil)
						WispBanjoState.LastEffectAt = os.clock()
					end
					task.wait(0.1)
				elseif os.clock() < WispBanjoState.ListenUntil then
					WispBanjoState.Status = string.format("Banjo Stage %d/5: listening (%d notes)", WispBanjoState.ClearedStages + 1, #notes)
					task.wait(0.05)
				else
					WispBanjoState.Notes = nil
					for stepIdx, mushIdx in ipairs(notes) do
						if not isAliveCheck() or WispBanjoState.PlaybackVer ~= ver then
							break
						end
						WispBanjoState.Status = string.format("Banjo Stage %d/5: note %d/%d", WispBanjoState.ClearedStages + 1, stepIdx, #notes)
						local sentSerial = hitMushroomNote(mushIdx, ver)
						if not sentSerial then
							break
						end
						local ackDeadline = os.clock() + 1.6
						local confirmed = false
						while isAliveCheck() and os.clock() < ackDeadline do
							if WispBanjoState.WrongSerial > sentSerial then
								break
							end
							for _, ack in ipairs(WispBanjoState.NoteAcks) do
								if ack.Serial > sentSerial and ack.Mushroom == mushIdx then
									ack.Serial = 0
									confirmed = true
									break
								end
							end
							if confirmed then
								break
							end
							task.wait(0.05)
						end
						if not confirmed then
							break
						end
					end
					WispBanjoState.LastEffectAt = os.clock()
				end
			end

			local checkSolved = ReadSaveData()
			local solvedNow = WispBanjoState.Solved or (checkSolved and type(checkSolved.BanjoCricket) == "table" and checkSolved.BanjoCricket.Solved == true)
			if solvedNow and isAliveCheck() then
				local npcPos = FindTaggedPos("BanjoCricketNpc", nil, NPC_FALLBACK)
				WispBanjoState.Status = "Banjo: claiming Cricket's Banjo"
				if FlyInsideBaseTo(npcPos + Vector3.new(0, 0, -5), function() return not isAliveCheck() end) then
					InvokeProgressionRemote("RF/BanjoCricket/AskClaim")
					task.wait(1.0)
				end
			end
			Hub.AutoButterfly.LeaveEnchantedTree()
		end

		function WispBanjoState.Restart()
			WispBanjoState.Gen = WispBanjoState.Gen + 1
			WispBanjoState.NextWispAt = 0
			WispBanjoState.NextBanjoAt = 0
			Progression.Wake()
		end

		AddWorker(function()
			if not FarmConfig.Wisp_Auto and not FarmConfig.Banjo_Auto then
				return false
			end
			if WispBanjoState.WispBusy or WispBanjoState.BanjoBusy or Engine.AutoCarry.Carrying then
				return false
			end
			local nowClock = os.clock()
			if FarmConfig.Wisp_Auto and nowClock >= WispBanjoState.NextWispAt then
				local saveData = ReadSaveData()
				local unlocked = saveData and type(saveData.WispCompanion) == "table" and saveData.WispCompanion.Unlocked == true
				if not unlocked and Engine.ClaimMovement("wisp") then
					WispBanjoState.WispBusy = true
					WispBanjoState.NextWispAt = nowClock + 5
					local myGen = WispBanjoState.Gen
					task.spawn(function()
						pcall(RunWispPass, function()
							return Hub.Alive and not Engine.Disposed and myGen == WispBanjoState.Gen and FarmConfig.Wisp_Auto
						end)
						Engine.ReleaseMovement("wisp")
						WispBanjoState.WispBusy = false
						Progression.Wake()
					end)
					return true
				elseif unlocked then
					WispBanjoState.Status = "Wisp Done - Enchanted Tree open"
				end
			end

			if FarmConfig.Banjo_Auto and nowClock >= WispBanjoState.NextBanjoAt then
				local saveData = ReadSaveData()
				local claimed = saveData and type(saveData.BanjoCricket) == "table" and saveData.BanjoCricket.Claimed == true
				if not claimed and LocalPlayer:GetAttribute("EnchantedTreeUnlocked") == true and Engine.ClaimMovement("banjo") then
					WispBanjoState.BanjoBusy = true
					WispBanjoState.NextBanjoAt = nowClock + 10
					local myGen = WispBanjoState.Gen
					task.spawn(function()
						if TreadmillState.Riding or IsPlayerOnBelt() then
							ExitTreadmillBelt()
						end
						pcall(RestoreCharacter)
						pcall(RunBanjoCricketPass, function()
							return Hub.Alive and not Engine.Disposed and myGen == WispBanjoState.Gen and FarmConfig.Banjo_Auto
						end)
						Engine.ReleaseMovement("banjo")
						WispBanjoState.BanjoBusy = false
						Progression.Wake()
					end)
					return true
				elseif claimed then
					WispBanjoState.Status = "Banjo Cricket already claimed"
				end
			end
			return false
		end)
	end

	-- 5O. Shooting Star Catcher (100% Chilli Mechanics L36235-36745)
	do
		local StarState = {
			Gen = 0,
			Busy = false,
			Payload = nil,
			Status = "Off",
			CaughtCount = 0,
			SlippedCount = 0,
			HoldStartedAt = nil,
			NextAskAt = 0,
		}
		Hub.ShootingStar = StarState

		local function ConnectStarRemote(remotePath, callbackFn)
			local remoteObj = ResolveRemote(remotePath)
			if remoteObj and remoteObj:IsA("RemoteEvent") then
				Hub.Lifecycle.TrackConnection(remoteObj.OnClientEvent:Connect(callbackFn))
			end
		end

		local function SetStarPayload(dataTbl)
			if type(dataTbl) == "table" and dataTbl.Id ~= nil then
				if not StarState.Payload or StarState.Payload.Id ~= dataTbl.Id then
					StarState.SlippedCount = 0
				end
				StarState.Payload = dataTbl
				Progression.Wake()
			end
		end

		ConnectStarRemote("RE/ShootingStar/Fall", SetStarPayload)
		ConnectStarRemote("RE/ShootingStar/Wander", function(starId, legTbl, noticed)
			if StarState.Payload and StarState.Payload.Id == starId and type(legTbl) == "table" then
				StarState.Payload.Leg = legTbl
				StarState.Payload.Noticed = (noticed == true)
			end
		end)
		ConnectStarRemote("RE/ShootingStar/Slipped", function(starId)
			if StarState.Payload and StarState.Payload.Id == starId then
				StarState.SlippedCount = StarState.SlippedCount + 1
				StarState.HoldStartedAt = nil
			end
		end)
		ConnectStarRemote("RE/ShootingStar/Claimed", function(starId)
			if StarState.Payload and StarState.Payload.Id == starId then
				StarState.CaughtCount = StarState.CaughtCount + 1
				StarState.Payload = nil
				StarState.Gen = StarState.Gen + 1
			end
		end)
		ConnectStarRemote("RE/ShootingStar/Expired", function(starId)
			if StarState.Payload and StarState.Payload.Id == starId then
				StarState.Payload = nil
				StarState.Gen = StarState.Gen + 1
			end
		end)

		local function PollStarStateAsync()
			StarState.NextAskAt = os.clock() + 15
			task.spawn(function()
				local callOk, starData = InvokeProgressionRemote("RF/ShootingStar/AskState")
				if callOk then
					SetStarPayload(starData)
				end
			end)
		end

		local function ResolveLiveStarPos(starPayload)
			local clientFolder = Workspace:FindFirstChild("ShootingStarClient")
			local buddy = clientFolder and clientFolder:FindFirstChild("Buddy")
			local buddyPart = buddy and (buddy:FindFirstChild("RootPart") or (buddy:IsA("Model") and buddy.PrimaryPart))
			if buddyPart and buddyPart:IsA("BasePart") then
				return buddyPart.Position, nil
			end
			local serverNow = Workspace:GetServerTimeNow()
			local leg = starPayload.Leg
			if type(leg) == "table" and typeof(leg.From) == "Vector3" and typeof(leg.To) == "Vector3" then
				local startAt = tonumber(leg.StartAt) or serverNow
				local span = (tonumber(leg.ArriveAt) or startAt) - startAt
				local alpha = (span > 0) and math.clamp((serverNow - startAt) / span, 0, 1) or 1
				local moveVec = leg.To - leg.From
				local flatUnit = (alpha < 1 and moveVec.Magnitude > 0.5) and Vector3.new(moveVec.X, 0, moveVec.Z).Unit or nil
				return leg.From:Lerp(leg.To, alpha), flatUnit
			end
			local landing = starPayload.Landing
			if typeof(landing) == "CFrame" then
				return landing.Position, nil
			elseif typeof(landing) == "Vector3" then
				return landing, nil
			end
			return nil, nil
		end

		local function RunCatchStarJob(starPayload, expectedGen)
			local function isStarJobCancelled()
				return not Hub.Alive
					or Engine.Disposed
					or expectedGen ~= StarState.Gen
					or not FarmConfig.Star_Auto
					or StarState.Payload ~= starPayload
			end

			if TreadmillState.Riding or IsPlayerOnBelt() then
				ExitTreadmillBelt()
			end

			local initialPos = ResolveLiveStarPos(starPayload)
			if not initialPos then
				return
			end
			local rootPart = Engine.Root()
			if rootPart and (rootPart.Position - initialPos).Magnitude > 12 then
				if Engine.InsideBase(rootPart.Position) and (Engine.IsNight() or Engine.WallSealed()) then
					StarState.Status = "Star landed - waiting for open wall"
					return
				end
				StarState.Status = "Flying to the shooting star"
				if not Engine.FlyToPosition(initialPos + Vector3.new(0, 3, 3), RuntimeState.SessionId, 6, 45, 550, true) then
					return
				end
			end
			if isStarJobCancelled() then
				return
			end

			local requiredHoldSec = (tonumber(starPayload.HoldSeconds) or 1.6) + 0.3
			StarState.HoldStartedAt = nil
			local lastCatchSentAt = nil
			local tries = 0

			while not isStarJobCancelled() do
				if (tonumber(starPayload.ExpiresAt) or math.huge) <= Workspace:GetServerTimeNow() then
					StarState.Payload = nil
					return
				end
				local starPos, leadUnit = ResolveLiveStarPos(starPayload)
				local liveRoot = Engine.Root()
				if not starPos or not liveRoot then
					break
				end

				local hoverTarget = starPos + Vector3.new(0, 3, 0) + (leadUnit and (leadUnit * 2) or Vector3.new(0, 0, 3))
				local vel = (hoverTarget - liveRoot.Position) * 10
				if vel.Magnitude > 200 then
					vel = vel.Unit * 200
				end
				pcall(function()
					local flatLook = Vector3.new(starPos.X - liveRoot.Position.X, 0, starPos.Z - liveRoot.Position.Z)
					if flatLook.Magnitude > 0.05 then
						liveRoot.CFrame = CFrame.lookAt(liveRoot.Position, liveRoot.Position + flatLook.Unit)
					end
					liveRoot.AssemblyLinearVelocity = vel
					liveRoot.AssemblyAngularVelocity = Vector3.zero
				end)

				if StarState.HoldStartedAt then
					if not lastCatchSentAt and (os.clock() - StarState.HoldStartedAt) >= requiredHoldSec then
						tries = tries + 1
						lastCatchSentAt = os.clock()
						FireProgressionRemote("RE/ShootingStar/Catch", starPayload.Id)
						StarState.Status = "Catching the star (try " .. tostring(tries) .. ")"
					elseif lastCatchSentAt and (os.clock() - lastCatchSentAt) >= 2.0 then
						StarState.HoldStartedAt = nil
						lastCatchSentAt = nil
						FireProgressionRemote("RE/ShootingStar/Hold", starPayload.Id, false)
						if tries % 3 == 0 then
							PollStarStateAsync()
						end
					end
				else
					StarState.HoldStartedAt = os.clock()
					FireProgressionRemote("RE/ShootingStar/Hold", starPayload.Id, true)
					StarState.Status = "Holding the star" .. ((StarState.SlippedCount > 0) and (" (slipped " .. tostring(StarState.SlippedCount) .. ")") or "")
				end
				RunService.Heartbeat:Wait()
			end

			if StarState.Payload == starPayload then
				FireProgressionRemote("RE/ShootingStar/Hold", starPayload.Id, false)
			end
			Engine.StopVelocity()
		end

		function StarState.Restart()
			StarState.Gen = StarState.Gen + 1
			StarState.NextAskAt = 0
			if not FarmConfig.Star_Auto then
				StarState.Status = "Off"
			end
			Progression.Wake()
		end

		AddWorker(function()
			if not FarmConfig.Star_Auto then
				StarState.Status = "Off"
				return false
			end
			if os.clock() >= StarState.NextAskAt then
				PollStarStateAsync()
			end

			local payload = StarState.Payload
			local serverNow = Workspace:GetServerTimeNow()
			if not payload then
				StarState.Status = "Waiting for a shooting star"
					.. ((StarState.CaughtCount > 0) and (" (caught " .. tostring(StarState.CaughtCount) .. ")") or "")
				return false
			end
			if (tonumber(payload.ExpiresAt) or math.huge) <= serverNow then
				StarState.Payload = nil
				return false
			end
			local landAt = tonumber(payload.LandAt) or serverNow
			if serverNow < landAt then
				StarState.Status = "Star falling, lands in " .. tostring(math.ceil(landAt - serverNow)) .. "s"
				return false
			end
			if StarState.Busy or Engine.AutoCarry.Carrying then
				return false
			end
			if not Engine.ClaimMovement("star") then
				StarState.Status = "Star landed, waiting for " .. tostring(Engine.Movement.Owner or "movement")
				return false
			end

			StarState.Busy = true
			local myGen = StarState.Gen
			task.spawn(function()
				HoldTreadmillBelt()
				pcall(RunCatchStarJob, payload, myGen)
				ReleaseTreadmillBelt()
				Engine.StopVelocity()
				Engine.ReleaseMovement("star")
				StarState.Busy = false
				Progression.Wake()
			end)
			return true
		end)
	end

	-- 5P. Player Movement & Character Modifiers (100% Chilli Mechanics L36752-38353)
	do
		local MoveCharState = {
			WasBoosting = false,
			RespawnCooldownUntil = 0,
			ForcedByInvis = false,
			JumpConn = nil,
			TrapPartsBackup = {},
			TrapConns = {},
			PromptDurationBackup = {},
			PromptConns = {},
			InvisLoopBusy = false,
			InvisRespawning = false,
			AutoRotateHum = nil,
		}
		Hub.PlayerModifiers = MoveCharState

		Hub.Lifecycle.TrackConnection(LocalPlayer.CharacterAdded:Connect(function()
			MoveCharState.RespawnCooldownUntil = os.clock() + 2.0
		end))

		local function GetLiveCharacterParts()
			local character = LocalPlayer.Character
			local rootPart = character and character:FindFirstChild("HumanoidRootPart")
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if rootPart and humanoid and humanoid.Health > 0 then
				return character, rootPart, humanoid
			end
			return nil, nil, nil
		end

		local function RestoreNormalWalkVelocity()
			if not MoveCharState.WasBoosting then
				return
			end
			MoveCharState.WasBoosting = false
			local _, rootPart, humanoid = GetLiveCharacterParts()
			if not rootPart or not humanoid then
				return
			end
			local curVel = rootPart.AssemblyLinearVelocity
			local moveDir = Vector3.new(humanoid.MoveDirection.X, 0, humanoid.MoveDirection.Z)
			local normalHoriz = (moveDir.Magnitude > 0.001) and (moveDir.Unit * humanoid.WalkSpeed) or Vector3.zero
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(normalHoriz.X, curVel.Y, normalHoriz.Z)
			end)
		end

		-- Speed Boost Heartbeat (Chilli L36800-36865)
		Hub.Lifecycle.TrackConnection(RunService.Heartbeat:Connect(function()
			if not Hub.Alive or Engine.Disposed then
				return
			end
			local boostWanted = FarmConfig.Move_SpeedBoost or MoveCharState.ForcedByInvis
			if not boostWanted then
				RestoreNormalWalkVelocity()
				return
			end
			if Engine.AutoCycle ~= nil
				or Engine.AutoCarry.Carrying
				or TreadmillState.Riding
				or (Engine.Movement.Owner ~= nil and Engine.Movement.Owner ~= "invisibility")
				or os.clock() < MoveCharState.RespawnCooldownUntil
			then
				MoveCharState.WasBoosting = false
				return
			end

			local _, rootPart, humanoid = GetLiveCharacterParts()
			if not rootPart or not humanoid or humanoid.Sit or humanoid.PlatformStand then
				MoveCharState.WasBoosting = false
				return
			end
			local ragEnd = tonumber(LocalPlayer:GetAttribute("RagdollEndTime")) or 0
			if ragEnd > Workspace:GetServerTimeNow() then
				MoveCharState.WasBoosting = false
				return
			end

			local flatInput = Vector3.new(humanoid.MoveDirection.X, 0, humanoid.MoveDirection.Z)
			if flatInput.Magnitude <= 0.001 then
				RestoreNormalWalkVelocity()
				return
			end
			local targetSpeed = math.clamp(ToFiniteNumber(FarmConfig.Move_BoostSpeed, 350), 20, 1000)
			local horizVel = flatInput.Unit * targetSpeed
			local curVel = rootPart.AssemblyLinearVelocity
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(horizVel.X, curVel.Y, horizVel.Z)
			end)
			MoveCharState.WasBoosting = true
		end))

		-- Infinite Jump (Chilli L37000-37035)
		function MoveCharState.SetInfiniteJump(isEnabled)
			if MoveCharState.JumpConn then
				MoveCharState.JumpConn:Disconnect()
				MoveCharState.JumpConn = nil
			end
			if isEnabled then
				MoveCharState.JumpConn = Hub.Lifecycle.TrackConnection(UserInputService.JumpRequest:Connect(function()
					if not FarmConfig.Move_InfiniteJump then
						return
					end
					local _, _, humanoid = GetLiveCharacterParts()
					if humanoid and not humanoid.Sit and not humanoid.PlatformStand then
						pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Jumping)
					end
				end))
			end
		end

		-- Anti Trap (Chilli L38067-38136)
		local function DisableTrapTouchOnPart(partInst)
			if partInst and partInst:IsA("BasePart") and MoveCharState.TrapPartsBackup[partInst] == nil then
				MoveCharState.TrapPartsBackup[partInst] = partInst.CanTouch
				pcall(function()
					partInst.CanTouch = false
				end)
			end
		end

		local function ProcessTaggedTrap(trapInst)
			if not FarmConfig.Char_AntiTrap or not trapInst or not trapInst.Parent then
				return
			end
			if trapInst:GetAttribute("Owner") == LocalPlayer.Name then
				return
			end
			DisableTrapTouchOnPart(trapInst)
			for _, desc in ipairs(trapInst:GetDescendants()) do
				DisableTrapTouchOnPart(desc)
			end
			local addConn = trapInst.DescendantAdded:Connect(function(newDesc)
				if FarmConfig.Char_AntiTrap then
					DisableTrapTouchOnPart(newDesc)
				end
			end)
			table.insert(MoveCharState.TrapConns, addConn)
			Hub.Lifecycle.TrackConnection(addConn)
		end

		function MoveCharState.ApplyAntiTrap(isEnabled)
			if isEnabled then
				local okTag, taggedTraps = pcall(CollectionService.GetTagged, CollectionService, "PlacedTrap")
				if okTag and type(taggedTraps) == "table" then
					for _, trapInst in ipairs(taggedTraps) do
						ProcessTaggedTrap(trapInst)
					end
				end
			else
				for partInst, origCanTouch in pairs(MoveCharState.TrapPartsBackup) do
					if partInst and partInst.Parent then
						pcall(function()
							partInst.CanTouch = origCanTouch
						end)
					end
				end
				table.clear(MoveCharState.TrapPartsBackup)
			end
		end

		pcall(function()
			local trapAddedSig = CollectionService:GetInstanceAddedSignal("PlacedTrap")
			if trapAddedSig then
				Hub.Lifecycle.TrackConnection(trapAddedSig:Connect(function(newTrap)
					task.defer(ProcessTaggedTrap, newTrap)
				end))
			end
		end)
		MoveCharState.ApplyAntiTrap(FarmConfig.Char_AntiTrap)

		-- Instant Prompts (Chilli L38138-38353)
		local SKIP_INSTANT_PROMPTS = {
			ClaimLostPart = true,
			CatchPrompt = true,
		}

		local function ZeroPromptHoldDuration(promptInst)
			if not promptInst or not promptInst:IsA("ProximityPrompt") or SKIP_INSTANT_PROMPTS[promptInst.Name] then
				return
			end
			if MoveCharState.PromptDurationBackup[promptInst] == nil then
				if promptInst.HoldDuration <= 0 and promptInst.Name ~= "CarryAreaEgg" then
					return
				end
				MoveCharState.PromptDurationBackup[promptInst] = promptInst.HoldDuration
			end
			if promptInst.HoldDuration ~= 0 then
				pcall(function()
					promptInst.HoldDuration = 0
				end)
			end
		end

		function MoveCharState.ApplyInstantPrompts(isEnabled)
			for _, connObj in ipairs(MoveCharState.PromptConns) do
				pcall(connObj.Disconnect, connObj)
			end
			table.clear(MoveCharState.PromptConns)

			if not isEnabled then
				for promptInst, origHold in pairs(MoveCharState.PromptDurationBackup) do
					if promptInst and promptInst.Parent then
						pcall(function()
							promptInst.HoldDuration = origHold
						end)
					end
				end
				table.clear(MoveCharState.PromptDurationBackup)
				return
			end

			if ProximityPromptService.PromptShown then
				local shownConn = ProximityPromptService.PromptShown:Connect(function(shownPrompt)
					if FarmConfig.Char_InstantPrompts then
						ZeroPromptHoldDuration(shownPrompt)
					end
				end)
				table.insert(MoveCharState.PromptConns, shownConn)
				Hub.Lifecycle.TrackConnection(shownConn)
			end

			for _, child in ipairs(Workspace:GetChildren()) do
				if child.Name == "SmartPromptPart" then
					local carryPrompt = child:FindFirstChild("CarryAreaEgg")
					if carryPrompt then
						ZeroPromptHoldDuration(carryPrompt)
					end
				end
			end

			local wsChildConn = Workspace.ChildAdded:Connect(function(newChild)
				if FarmConfig.Char_InstantPrompts and newChild.Name == "SmartPromptPart" then
					task.defer(function()
						local carryPrompt = newChild:FindFirstChild("CarryAreaEgg") or newChild:WaitForChild("CarryAreaEgg", 2)
						if carryPrompt and FarmConfig.Char_InstantPrompts then
							ZeroPromptHoldDuration(carryPrompt)
						end
					end)
				end
			end)
			table.insert(MoveCharState.PromptConns, wsChildConn)
			Hub.Lifecycle.TrackConnection(wsChildConn)
		end
		MoveCharState.ApplyInstantPrompts(FarmConfig.Char_InstantPrompts)

		-- Invisibility (Chilli RigWipe + HipHeight Detach + RightHand Tool Mount L37037-37542)
		local function IsInvisCurrentlyDesired()
			if not FarmConfig.Char_Invisibility then
				return false
			end
			local owner = Engine.Movement.Owner
			if owner == "essence" or owner == "butterfly" or owner == "banjo" or owner == "train" then
				return false
			end
			return true
		end

		local function IsInvisAppliedOnChar(character)
			return character ~= nil and character:GetAttribute("InvisApplied") == true
		end

		local function TriggerCleanRespawn(character)
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not character or not humanoid then
				return false
			end
			local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
			pcall(humanoid.UnequipTools, humanoid)
			if backpack then
				for _, child in ipairs(character:GetChildren()) do
					if child:IsA("Tool") then
						pcall(function()
							child.Parent = backpack
						end)
					end
				end
			end
			for _ = 1, 3 do
				RunService.Heartbeat:Wait()
			end
			InvokeProgressionRemote("RF/Treadmill/AskDoff")
			pcall(function()
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				humanoid.BreakJointsOnDeath = true
				humanoid.RequiresNeck = true
				humanoid.Health = 0
			end)
			pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Dead)
			pcall(character.BreakJoints, character)
			FireProgressionRemote("RE/RigSync/AskRigWipe", character)
			return true
		end

		local function ApplyInvisibleRigOnSpawn(character)
			local waitEnd = os.clock() + 10
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			while Hub.Alive and character.Parent and os.clock() < waitEnd do
				humanoid = humanoid or character:FindFirstChildOfClass("Humanoid")
				if humanoid and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
					break
				end
				task.wait()
			end
			local rootPart = character:FindFirstChild("HumanoidRootPart")
			if not IsInvisCurrentlyDesired() or not humanoid or not rootPart or not character:FindFirstChild("Head") then
				return false
			end
			task.wait(0.05)
			if not IsInvisCurrentlyDesired() or character.Parent == nil then
				return false
			end
			pcall(humanoid.UnequipTools, humanoid)
			if type(replicatesignal) == "function" and humanoid.ServerBreakJoints then
				pcall(replicatesignal, humanoid.ServerBreakJoints)
			end

			local savedHip = humanoid.HipHeight
			pcall(function()
				humanoid.HipHeight = 999
			end)
			for _, partOrAcc in ipairs(character:GetChildren()) do
				if partOrAcc:IsA("Accessory") or (partOrAcc:IsA("BasePart") and partOrAcc ~= rootPart) then
					pcall(function()
						partOrAcc.Parent = nil
					end)
				end
			end
			task.wait(0.12)
			pcall(function()
				humanoid.HipHeight = savedHip
			end)
			if character.Parent == nil then
				return false
			end

			local wristMotor = Instance.new("Motor6D")
			wristMotor.Name = "RightWrist"
			wristMotor.C0 = CFrame.new(1.2, 0, 0)
			wristMotor.C1 = CFrame.new()
			wristMotor.Part0 = rootPart
			wristMotor.Parent = rootPart

			local handPart = Instance.new("Part")
			handPart.Name = "RightHand"
			handPart.Size = Vector3.new(0.2, 0.2, 0.2)
			handPart.Transparency = 1
			handPart.CanCollide = false
			handPart.CanTouch = false
			handPart.CanQuery = false
			handPart.Massless = true
			handPart.CFrame = rootPart.CFrame * wristMotor.C0
			wristMotor.Part1 = handPart
			handPart.Parent = character

			character:SetAttribute("InvisApplied", true)
			return true
		end

		Hub.Lifecycle.TrackConnection(LocalPlayer.CharacterAdded:Connect(function(newChar)
			if not IsInvisCurrentlyDesired() then
				return
			end
			MoveCharState.InvisRespawning = true
			task.spawn(function()
				pcall(ApplyInvisibleRigOnSpawn, newChar)
				MoveCharState.InvisRespawning = false
			end)
		end))

		-- Sync held Tool Handle onto synthetic RightHand & face MoveDirection when Invisible
		Hub.Lifecycle.TrackConnection(RunService.Heartbeat:Connect(function()
			if not Hub.Alive or Engine.Disposed then
				return
			end
			local character, rootPart, humanoid = GetLiveCharacterParts()
			local invisOnChar = IsInvisAppliedOnChar(character)
			MoveCharState.ForcedByInvis = invisOnChar

			if not invisOnChar or not character or not rootPart or not humanoid then
				if MoveCharState.AutoRotateHum and MoveCharState.AutoRotateHum.Parent then
					pcall(function()
						MoveCharState.AutoRotateHum.AutoRotate = true
					end)
				end
				MoveCharState.AutoRotateHum = nil
				return
			end

			local rightHand = character:FindFirstChild("RightHand")
			local equippedTool = character:FindFirstChildWhichIsA("Tool")
			local toolHandle = equippedTool and equippedTool:FindFirstChild("Handle")
			if rightHand and toolHandle and toolHandle:IsA("BasePart") then
				pcall(function()
					toolHandle.CFrame = rightHand.CFrame
					toolHandle.AssemblyLinearVelocity = Vector3.zero
					toolHandle.AssemblyAngularVelocity = Vector3.zero
				end)
			end

			if Engine.AutoCycle == nil and not TreadmillState.Riding and not humanoid.Sit and not humanoid.PlatformStand then
				if humanoid.AutoRotate then
					pcall(function()
						humanoid.AutoRotate = false
					end)
				end
				MoveCharState.AutoRotateHum = humanoid
				local moveFlat = Vector3.new(humanoid.MoveDirection.X, 0, humanoid.MoveDirection.Z)
				if moveFlat.Magnitude > 0.01 then
					pcall(function()
						rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + moveFlat.Unit)
					end)
				end
			end
		end))

		Hub.Lifecycle.SpawnLoop(0.35, function()
			if Engine.Disposed or MoveCharState.InvisLoopBusy or MoveCharState.InvisRespawning then
				return
			end
			local character, _, humanoid = GetLiveCharacterParts()
			if not character or not humanoid then
				return
			end
			local targetInvis = IsInvisCurrentlyDesired()
			if IsInvisAppliedOnChar(character) == targetInvis then
				return
			end
			if Engine.AutoCycle ~= nil or Engine.AutoCarry.Carrying then
				return
			end
			if not Engine.ClaimMovement("invisibility") then
				return
			end

			MoveCharState.InvisLoopBusy = true
			pcall(RestoreCharacter)
			task.wait()
			TriggerCleanRespawn(character)
			local waitChangeEnd = os.clock() + 12
			while Hub.Alive and LocalPlayer.Character == character and os.clock() < waitChangeEnd do
				task.wait(0.1)
			end
			while Hub.Alive and MoveCharState.InvisRespawning do
				task.wait(0.05)
			end
			Engine.ReleaseMovement("invisibility")
			MoveCharState.InvisLoopBusy = false
		end)

		pcall(function()
			LibraryLoader:OnUnload(function()
				RestoreNormalWalkVelocity()
				MoveCharState.ApplyAntiTrap(false)
				MoveCharState.ApplyInstantPrompts(false)
			end)
		end)
	end

	-- 5R. Admin Abuse (Capture The Egg, Admin Treadmill, Instant Steal & Minigame Eggs)
	do
		local Admin = {
			Capture = { Status = "Off" },
			Treadmill = { Status = "Off", Riding = false, NextMountAt = 0 },
			Instant = { Status = "Off", CarryUid = nil },
			Minigame = { Status = "Off" },
		}
		Hub.Admin = Admin

		local CAPTURE_EVENT_ATTR = "Event_CaptureTheEgg"
		local CAPTURE_GAMEPLAY_ATTR = "Event_CaptureTheEggGameplay"
		local CAPTURE_UID_ATTR = "Event_CaptureTheEggUid"
		local MINIGAME_EVENTS = {
			{ Flag = "Event_RedLightGreenLight", Prefix = "RLGL", Name = "Red Light Green Light" },
			{ Flag = "Event_TrexRun", Prefix = "TrexRun", Name = "T-Rex Run" },
		}
		local CAPTURE_OWNER = "capture"
		local TREADMILL_OWNER = "admintreadmill"
		local INSTANT_OWNER = "instantsteal"
		local MINIGAME_OWNER = "minigame"
		local APPROACH_SPEED = 400
		local HOLD_SPEED = 160
		local GRAB_DISTANCE = 14
		local BOUNDS_MARGIN = 40
		local BOUNDS_SPACING = 50

		local function IsCaptureEventActive()
			return Workspace:GetAttribute(CAPTURE_EVENT_ATTR) == true
				or Workspace:GetAttribute(CAPTURE_GAMEPLAY_ATTR) == true
		end

		local function EggBottomPosition(eggRecord)
			if type(eggRecord) ~= "table" then
				return nil
			end
			local bottomCFrame = eggRecord.BottomCFrame or eggRecord.BoundsCFrame
			return typeof(bottomCFrame) == "CFrame" and bottomCFrame.Position or nil
		end

		local function ReadEggRecord(eggUid)
			if EggStateModule and type(EggStateModule.ReadFieldEgg) == "function" then
				local callOk, eggRecord = pcall(EggStateModule.ReadFieldEgg, eggUid)
				if callOk and type(eggRecord) == "table" then
					return eggRecord
				end
			end
			for _, eggRecord in ipairs(Engine.CollectRawFieldEggs()) do
				if eggRecord.Uid == eggUid then
					return eggRecord
				end
			end
			return nil
		end

		local function IsCarriedByMe(eggUid)
			return Engine.AutoCarry.Carrying == true and Engine.AutoCarry.CarryUid == eggUid
		end

		local function FindCarryPrompt(eggPos)
			local bestPrompt, bestDistance = nil, GRAB_DISTANCE
			for _, partInst in ipairs(Workspace:GetChildren()) do
				if partInst.Name == "SmartPromptPart" and partInst:IsA("BasePart") then
					local promptInst = partInst:FindFirstChild("CarryAreaEgg")
					local planarDistance =
						Vector3.new(partInst.Position.X - eggPos.X, 0, partInst.Position.Z - eggPos.Z).Magnitude
					if promptInst and promptInst:IsA("ProximityPrompt") and planarDistance < bestDistance then
						bestPrompt, bestDistance = promptInst, planarDistance
					end
				end
			end
			return bestPrompt
		end

		local function RequestEggCarry(eggUid, eggRecord)
			local eggPos = EggBottomPosition(eggRecord)
			local promptInst = eggPos and FindCarryPrompt(eggPos)
			if promptInst then
				Engine.FirePrompt(promptInst)
				return true
			end
			if EggStateModule and type(EggStateModule.CarryFieldEgg) == "function" then
				pcall(EggStateModule.CarryFieldEgg, eggUid)
				return true
			end
			return false
		end

		local function FindNearestFreeEgg(originPos, maxDistance, fieldOnly)
			local bestRecord, bestDistance, bestPosition = nil, maxDistance, nil
			for _, eggRecord in ipairs(Engine.CollectRawFieldEggs()) do
				local eggPos = EggBottomPosition(eggRecord)
				local carrierId = tonumber(eggRecord.CarrierUserId) or 0
				if eggPos
					and tostring(eggRecord.State or "") ~= "Carried"
					and carrierId <= 0
					and (not fieldOnly or not Engine.InsideBase(eggPos))
				then
					local planarDistance = Vector3.new(eggPos.X - originPos.X, 0, eggPos.Z - originPos.Z).Magnitude
					if planarDistance < bestDistance then
						bestRecord, bestDistance, bestPosition = eggRecord, planarDistance, eggPos
					end
				end
			end
			return bestRecord, bestDistance, bestPosition
		end

		local function SnapToPosition(targetPos)
			local rootPart = Engine.Root()
			if not rootPart or not rootPart.Parent then
				return false
			end
			pcall(function()
				rootPart.CFrame = CFrame.new(targetPos) * rootPart.CFrame.Rotation
				rootPart.AssemblyLinearVelocity = Vector3.zero
				rootPart.AssemblyAngularVelocity = Vector3.zero
			end)
			return true
		end

		local function DriftToPoint(goalPos, speed, shouldAbort, maxSeconds)
			local deadline = os.clock() + (maxSeconds or 3)
			while Hub.Alive and os.clock() < deadline do
				if shouldAbort and shouldAbort() then
					return false
				end
				local rootPart = Engine.Root()
				if not rootPart or not rootPart.Parent then
					return false
				end
				local offsetVec = goalPos - rootPart.Position
				if offsetVec.Magnitude <= 1 then
					return true
				end
				local deltaTime = RunService.Heartbeat:Wait()
				local stepVec = offsetVec.Unit * math.min(speed * deltaTime, offsetVec.Magnitude)
				pcall(function()
					rootPart.CFrame = CFrame.new(rootPart.Position + stepVec) * rootPart.CFrame.Rotation
					rootPart.AssemblyLinearVelocity = Vector3.zero
					rootPart.AssemblyAngularVelocity = Vector3.zero
				end)
			end
			return false
		end

		local function CollectCarryBounds()
			local boundsList = {}
			local worldFolder = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
			local areasFolder = worldFolder and worldFolder:FindFirstChild("Areas")
			local boundsFolder = areasFolder and areasFolder:FindFirstChild("EggCarryBounds")
			if not boundsFolder then
				return boundsList
			end
			for _, boundsPart in ipairs(boundsFolder:GetChildren()) do
				if boundsPart:IsA("BasePart")
					and boundsPart.Name ~= "SafeZone"
					and boundsPart.Position.Y > 0
					and boundsPart.Size.X > 60
					and boundsPart.Size.Z > 60
				then
					local halfSize = boundsPart.Size / 2
					local minX, maxX, minZ, maxZ = math.huge, -math.huge, math.huge, -math.huge
					for _, signX in ipairs({ -1, 1 }) do
						for _, signZ in ipairs({ -1, 1 }) do
							local cornerPos = boundsPart.CFrame:PointToWorldSpace(
								Vector3.new(halfSize.X * signX, 0, halfSize.Z * signZ)
							)
							minX, maxX = math.min(minX, cornerPos.X), math.max(maxX, cornerPos.X)
							minZ, maxZ = math.min(minZ, cornerPos.Z), math.max(maxZ, cornerPos.Z)
						end
					end
					table.insert(boundsList, {
						MinX = minX,
						MaxX = maxX,
						MinZ = minZ,
						MaxZ = maxZ,
						TopY = boundsPart.Position.Y + halfSize.Y,
					})
				end
			end
			return boundsList
		end

		local function CollectAvoidPositions()
			local avoidPositions = {}
			for _, otherPlayer in ipairs(Players:GetPlayers()) do
				if otherPlayer ~= LocalPlayer then
					local otherCharacter = otherPlayer.Character
					local otherRoot = otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart")
					local otherHumanoid = otherCharacter and otherCharacter:FindFirstChildOfClass("Humanoid")
					if otherRoot and otherHumanoid and otherHumanoid.Health > 0 then
						table.insert(avoidPositions, otherRoot.Position)
					end
				end
			end
			local worldFolder = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
			local areasFolder = worldFolder and worldFolder:FindFirstChild("Areas")
			local guardAreas = areasFolder and areasFolder:FindFirstChild("GuardAreas")
			if guardAreas then
				for _, guardArea in ipairs(guardAreas:GetChildren()) do
					local guardModel = guardArea:FindFirstChild("Guard")
					local guardRoot = guardModel and guardModel:FindFirstChild("HumanoidRootPart", true)
					if guardRoot and guardRoot:IsA("BasePart") then
						table.insert(avoidPositions, guardRoot.Position)
					end
				end
			end
			return avoidPositions
		end

		local function FindHoldPoint(originPos)
			local avoidPositions = CollectAvoidPositions()
			local bestPoint, bestCost = nil, math.huge
			local fallbackPoint, fallbackSafety = nil, -math.huge
			for _, bounds in ipairs(CollectCarryBounds()) do
				local centerZ = (bounds.MinZ + bounds.MaxZ) / 2
				local zSpread = math.min(BOUNDS_SPACING, math.max(0, (bounds.MaxZ - bounds.MinZ) / 2 - BOUNDS_MARGIN))
				local cursorX = bounds.MinX + BOUNDS_MARGIN
				while cursorX <= bounds.MaxX - BOUNDS_MARGIN do
					for _, cursorZ in ipairs({ centerZ - zSpread, centerZ, centerZ + zSpread }) do
						local candidatePos = Vector3.new(cursorX, bounds.TopY + FarmConfig.Admin_CaptureHeight, cursorZ)
						local nearestDistance = math.huge
						for _, avoidPos in ipairs(avoidPositions) do
							nearestDistance = math.min(
								nearestDistance,
								Vector3.new(avoidPos.X - candidatePos.X, 0, avoidPos.Z - candidatePos.Z).Magnitude
							)
						end
						local cost = (candidatePos - originPos).Magnitude
						if nearestDistance >= FarmConfig.Admin_CaptureKeepAway and cost < bestCost then
							bestPoint, bestCost = candidatePos, cost
						end
						if nearestDistance > fallbackSafety then
							fallbackPoint, fallbackSafety = candidatePos, nearestDistance
						end
					end
					cursorX = cursorX + BOUNDS_SPACING
				end
			end
			return bestPoint or fallbackPoint
		end

		local function RunAdminFeature(state, ownerName, stepFn)
			if not Engine.ClaimMovement(ownerName) then
				state.Status = "Waiting for " .. tostring(Engine.Movement.Owner or "another feature") .. " to stop"
				return true
			end
			pcall(stepFn)
			Engine.ReleaseMovement(ownerName)
			return true
		end

		local function RunCaptureStep()
			local captureState = Admin.Capture
			local eggUid = Workspace:GetAttribute(CAPTURE_UID_ATTR)
			if type(eggUid) ~= "string" or eggUid == "" then
				captureState.Status = IsCaptureEventActive() and "Event starting, waiting for the egg"
					or "Waiting for Capture The Egg"
				return
			end
			local eggRecord = ReadEggRecord(eggUid)
			if not eggRecord then
				captureState.Status = "Looking for the event egg"
				return
			end
			local rootPart = Engine.Root()
			if not rootPart then
				return
			end
			if IsCarriedByMe(eggUid) then
				local holdPoint = FindHoldPoint(rootPart.Position)
					or (rootPart.Position + Vector3.new(0, FarmConfig.Admin_CaptureHeight, 0))
				captureState.Status = "Holding the event egg"
				DriftToPoint(holdPoint, HOLD_SPEED, function()
					return not FarmConfig.Admin_Capture or Engine.Disposed or not IsCarriedByMe(eggUid)
				end, 3)
				return
			end
			local carrierId = tonumber(eggRecord.CarrierUserId) or 0
			if carrierId > 0 then
				local carrierPlayer = Players:GetPlayerByUserId(carrierId)
				local carrierName = carrierPlayer and (carrierPlayer.DisplayName or carrierPlayer.Name) or "someone"
				captureState.Status = carrierName .. " has the event egg, waiting"
				local carrierRoot = carrierPlayer
					and carrierPlayer.Character
					and carrierPlayer.Character:FindFirstChild("HumanoidRootPart")
				if FarmConfig.Admin_CaptureTake and carrierRoot then
					DriftToPoint(carrierRoot.Position + Vector3.new(0, 25, 0), APPROACH_SPEED, function()
						return not FarmConfig.Admin_Capture or Engine.Disposed
					end, 2)
				end
				return
			end
			local eggPos = EggBottomPosition(eggRecord)
			if not eggPos then
				captureState.Status = "Looking for the event egg"
				return
			end
			local insideBase = Engine.InsideBase(rootPart.Position)
			if insideBase ~= Engine.InsideBase(eggPos) and insideBase then
				if Engine.WallSealed() or Engine.IsNight() then
					captureState.Status = "Field wall is up, waiting to go out"
					return
				end
			end
			local planarDistance = Vector3.new(eggPos.X - rootPart.Position.X, 0, eggPos.Z - rootPart.Position.Z).Magnitude
			if planarDistance <= GRAB_DISTANCE then
				captureState.Status = "Grabbing the event egg"
				SnapToPosition(eggPos + Vector3.new(0, 3, 0))
				RequestEggCarry(eggUid, eggRecord)
				task.wait(0.35)
				return
			end
			captureState.Status = string.format("Going for the event egg  %d studs", math.floor(planarDistance + 0.5))
			DriftToPoint(eggPos + Vector3.new(0, 3, 0), APPROACH_SPEED, function()
				return not FarmConfig.Admin_Capture or Engine.Disposed
			end, 4)
		end

		local function FindAdminTreadmillBelt(adminTool)
			local namedBelt, largestPart, largestArea = nil, nil, 0
			for _, partInst in ipairs(adminTool:GetDescendants()) do
				if partInst:IsA("BasePart") and partInst.CanCollide then
					if not namedBelt and string.find(string.lower(partInst.Name), "belt", 1, true) then
						namedBelt = partInst
					end
					local flatArea = partInst.Size.X * partInst.Size.Z
					if flatArea > largestArea then
						largestPart, largestArea = partInst, flatArea
					end
				end
			end
			return namedBelt or largestPart
		end

		local function RunAdminTreadmillStep()
			local treadmillState = Admin.Treadmill
			local adminTool = Workspace:FindFirstChild("AdminTreadmill")
			if not adminTool then
				treadmillState.Riding = false
				treadmillState.Status = "Waiting for the Admin Treadmill"
				return
			end
			local beltPart = FindAdminTreadmillBelt(adminTool)
			if not beltPart then
				treadmillState.Status = "Looking for the Admin Treadmill belt"
				return
			end
			if TreadmillState.Riding then
				ExitTreadmillBelt()
			end
			local standPos = beltPart.Position + Vector3.new(0, beltPart.Size.Y / 2 + 3, 0)
			local rootPart = Engine.Root()
			if not rootPart then
				return
			end
			if (rootPart.Position - standPos).Magnitude > 6 then
				treadmillState.Status = "Going to the Admin Treadmill"
				DriftToPoint(standPos, APPROACH_SPEED, function()
					return not FarmConfig.Admin_AutoTreadmill or Engine.Disposed or not adminTool.Parent
				end, 4)
				return
			end
			if os.clock() >= treadmillState.NextMountAt then
				treadmillState.NextMountAt = os.clock() + 2.5
				local callOk, accepted, reasonText = InvokeWearStill()
				treadmillState.Riding = callOk and accepted ~= false
				treadmillState.Status = treadmillState.Riding and "Running on the Admin Treadmill"
					or ("Admin Treadmill: " .. tostring(reasonText or accepted or "no response"))
			end
			DriftToPoint(standPos, HOLD_SPEED, function()
				return not FarmConfig.Admin_AutoTreadmill or Engine.Disposed
			end, 1)
		end

		local function RunInstantStealStep()
			local instantState = Admin.Instant
			if Engine.AutoCarry.Carrying then
				if Engine.AutoCarry.CarryUid ~= instantState.CarryUid then
					instantState.Status = "Waiting for the carried egg"
					return
				end
				instantState.Status = "Bringing the stolen egg home"
				DriftToPoint(DELIVERY_DROP_CFRAME.Position + Vector3.new(0, 3, 0), APPROACH_SPEED, function()
					return not FarmConfig.Admin_InstantSteal or not Engine.AutoCarry.Carrying
				end, 8)
				if Engine.AutoCarry.Carrying and EggStateModule and type(EggStateModule.DropFieldEgg) == "function" then
					pcall(EggStateModule.DropFieldEgg, "PlayerRequest")
					task.wait(0.4)
				end
				instantState.CarryUid = nil
				instantState.Status = "Delivered the stolen egg"
				return
			end
			instantState.CarryUid = nil
			local rootPart = Engine.Root()
			if not rootPart then
				return
			end
			local eggRecord, planarDistance, eggPos = FindNearestFreeEgg(rootPart.Position, 2000, true)
			if not eggRecord then
				instantState.Status = "No egg to steal"
				return
			end
			instantState.Status = string.format(
				"Stealing %s  %d studs",
				tostring(eggRecord.Category or "egg"),
				math.floor(planarDistance + 0.5)
			)
			SnapToPosition(eggPos + Vector3.new(0, 3, 0))
			task.wait(0.1)
			instantState.CarryUid = eggRecord.Uid
			RequestEggCarry(eggRecord.Uid, eggRecord)
			task.wait(0.35)
		end

		local function RunMinigameStep()
			local minigameState = Admin.Minigame
			local activeEvent = nil
			for _, eventDef in ipairs(MINIGAME_EVENTS) do
				if Workspace:GetAttribute(eventDef.Flag) == true
					or typeof(Workspace:GetAttribute(eventDef.Prefix .. "_EggPosition")) == "Vector3"
				then
					activeEvent = eventDef
					break
				end
			end
			if not activeEvent then
				minigameState.Status = "Waiting for Red Light Green Light or T-Rex Run"
				return
			end
			local carrierId = tonumber(Workspace:GetAttribute(activeEvent.Prefix .. "_CarrierUserId"))
			if carrierId == LocalPlayer.UserId then
				minigameState.Status = "Carrying the minigame egg"
				return
			end
			if carrierId and carrierId > 0 then
				minigameState.Status = "Another player has the minigame egg"
				return
			end
			local eggPos = Workspace:GetAttribute(activeEvent.Prefix .. "_EggPosition")
			if typeof(eggPos) ~= "Vector3" then
				minigameState.Status = "Waiting for the egg to land"
				return
			end
			local eggRecord, planarDistance, recordPos = FindNearestFreeEgg(eggPos, 40)
			if not eggRecord then
				minigameState.Status = "Egg landed, looking for it"
				return
			end
			if planarDistance > GRAB_DISTANCE then
				minigameState.Status = string.format(
					"Going for the %s egg  %d studs",
					activeEvent.Name,
					math.floor(planarDistance + 0.5)
				)
				DriftToPoint(recordPos + Vector3.new(0, 3, 0), APPROACH_SPEED, function()
					return not FarmConfig.Admin_MinigameEggs or Engine.Disposed
				end, 3)
				return
			end
			minigameState.Status = "Stealing the " .. activeEvent.Name .. " egg"
			RequestEggCarry(eggRecord.Uid, eggRecord)
			task.wait(0.35)
		end

		AddWorker(function()
			if not FarmConfig.Admin_Capture then
				Admin.Capture.Status = "Off"
				return false
			end
			if IsStealActive() then
				Admin.Capture.Status = "Waiting for Auto Steal to stop"
				return false
			end
			return RunAdminFeature(Admin.Capture, CAPTURE_OWNER, RunCaptureStep)
		end)

		AddWorker(function()
			if not FarmConfig.Admin_AutoTreadmill then
				Admin.Treadmill.Status = "Off"
				return false
			end
			if IsStealActive() then
				Admin.Treadmill.Status = "Waiting for Auto Steal to stop"
				return false
			end
			return RunAdminFeature(Admin.Treadmill, TREADMILL_OWNER, RunAdminTreadmillStep)
		end)

		AddWorker(function()
			if not FarmConfig.Admin_InstantSteal then
				Admin.Instant.Status = "Off"
				return false
			end
			if IsStealActive() then
				Admin.Instant.Status = "Waiting for Auto Steal to stop"
				return false
			end
			return RunAdminFeature(Admin.Instant, INSTANT_OWNER, RunInstantStealStep)
		end)

		AddWorker(function()
			if not FarmConfig.Admin_MinigameEggs then
				Admin.Minigame.Status = "Off"
				return false
			end
			if IsStealActive() then
				Admin.Minigame.Status = "Waiting for Auto Steal to stop"
				return false
			end
			return RunAdminFeature(Admin.Minigame, MINIGAME_OWNER, RunMinigameStep)
		end)

		function Admin.Wake()
			Progression.Wake()
		end
	end

	-- 5S. Cursed Island Wars (Chilli Mechanics L36026-36230: bat swings, pumpkin launcher shots & sudden death regroup)
	do
		local IslandWars = {
			Snapshot = nil,
			SnapshotAt = 0,
			NextFetchAt = 0,
			Shot = 0,
			SuddenDeath = false,
			CollapseParts = nil,
			CollapseAt = 0,
			Cooldowns = {},
			KnockBackup = nil,
			Remotes = {},
			ConnectedPaths = {},
		}
		Hub.IslandWars = IslandWars

		local BAT_TOOL_NAME = "Bat"
		local LAUNCHER_TOOL_NAME = "PumpkinLauncher"
		local BAT_REACH = 10
		local ENEMY_SCAN_RADIUS = 25
		local BAT_COOLDOWN_SEC = 0.75
		local LAUNCHER_COOLDOWN_SEC = 1.25
		local LAUNCHER_PROJECTILE_SPEED = 110
		local SNAPSHOT_MAX_AGE_SEC = 30
		local SNAPSHOT_REFRESH_SEC = 5
		local REGROUP_DISTANCE = 18
		local REGROUP_MIN_SPEED = 30
		local COLLAPSE_RAY_LENGTH = 14
		local COLLAPSE_WARN_SEC = 8
		local MOVEMENT_OWNER = "islandwars"
		local ACTIVE_PHASES = { Prep = true, Match = true, SuddenDeath = true }

		local function IslandRemote(remoteName)
			local cached = IslandWars.Remotes[remoteName]
			if cached and cached.Parent then
				return cached
			end
			local remoteObj = FindGameRemote(remoteName)
			IslandWars.Remotes[remoteName] = remoteObj
			return remoteObj
		end

		local function FlatVector(vectorValue)
			return Vector3.new(vectorValue.X, 0, vectorValue.Z)
		end

		local function ReadPosition(instanceRef)
			if typeof(instanceRef) ~= "Instance" then
				return nil
			end
			if instanceRef:IsA("BasePart") then
				return instanceRef.Position
			end
			if instanceRef:IsA("Attachment") then
				return instanceRef.WorldPosition
			end
			if instanceRef:IsA("Model") then
				local callOk, pivotCFrame = pcall(instanceRef.GetPivot, instanceRef)
				return (callOk and typeof(pivotCFrame) == "CFrame") and pivotCFrame.Position or nil
			end
			return instanceRef.Parent and ReadPosition(instanceRef.Parent) or nil
		end

		local function ToggleKnockSuppression(suppress)
			if suppress then
				if IslandWars.KnockBackup then
					return
				end
			elseif not IslandWars.KnockBackup then
				return
			end
			local callOk, inputModule = pcall(
				RequireGameModule,
				"Controllers",
				"Game",
				"AdminAbuseClientController",
				"Events",
				"CursedIslandWars",
				"Input"
			)
			if not callOk or type(inputModule) ~= "table" or type(inputModule.Knock) ~= "function" then
				return
			end
			if suppress then
				IslandWars.KnockBackup = inputModule.Knock
				inputModule.Knock = function() end
			elseif IslandWars.KnockBackup then
				inputModule.Knock = IslandWars.KnockBackup
				IslandWars.KnockBackup = nil
			end
		end

		function IslandWars.RestoreKnock()
			ToggleKnockSuppression(false)
		end

		local function SetSnapshot(snapshot)
			if type(snapshot) ~= "table" then
				return
			end
			IslandWars.Snapshot = snapshot
			IslandWars.SnapshotAt = os.clock()
			Progression.Wake()
		end

		local function RefreshSnapshot()
			local fetchRemote = IslandRemote("RF/IslandWars/Fetch")
			if not fetchRemote or not fetchRemote:IsA("RemoteFunction") then
				return
			end
			local callOk, snapshot = pcall(fetchRemote.InvokeServer, fetchRemote)
			if callOk then
				SetSnapshot(snapshot)
			end
		end

		local function ReadMyEntry(snapshot)
			for _, entry in ipairs(type(snapshot.Entries) == "table" and snapshot.Entries or {}) do
				if type(entry) == "table" and entry.UserId == LocalPlayer.UserId then
					return entry
				end
			end
			return nil
		end

		local function FindNearestEnemyRoot(snapshot, enemyTeam, originPart, maxDistance)
			local bestRoot, bestDistance = nil, maxDistance
			for _, entry in ipairs(type(snapshot.Entries) == "table" and snapshot.Entries or {}) do
				local enemyModel = type(entry) == "table"
					and entry.Team == enemyTeam
					and entry.State == "Alive"
					and entry.Model
				local enemyRoot = typeof(enemyModel) == "Instance" and enemyModel:FindFirstChild("HumanoidRootPart")
				if enemyRoot then
					local distance = (enemyRoot.Position - originPart.Position).Magnitude
					if distance < bestDistance then
						bestRoot, bestDistance = enemyRoot, distance
					end
				end
			end
			return bestRoot, bestDistance
		end

		local function FindStructureAimPoint(snapshot, enemyTeam, placeName, aimChildName)
			local placeGroup = snapshot[placeName]
			local structure = type(placeGroup) == "table" and placeGroup[enemyTeam] or nil
			if type(structure) ~= "table" or (tonumber(structure.Health) or 0) <= 0 then
				return nil
			end
			if typeof(structure.Model) ~= "Instance" then
				return nil
			end
			return ReadPosition(structure.Model:FindFirstChild(aimChildName, true) or structure.Model)
		end

		local function ReadIslandCentre(snapshot)
			if typeof(snapshot.Island) ~= "Instance" then
				return nil
			end
			local centreModel = snapshot.Island:FindFirstChild("Centre")
			return ReadPosition(centreModel and centreModel:FindFirstChild("Top")) or ReadPosition(centreModel)
		end

		local function IsFloorCollapsing(rootPart)
			if type(IslandWars.CollapseParts) ~= "table" or (os.clock() - IslandWars.CollapseAt) >= COLLAPSE_WARN_SEC then
				return false
			end
			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Include
			rayParams.FilterDescendantsInstances = IslandWars.CollapseParts
			return Workspace:Raycast(rootPart.Position, Vector3.new(0, -COLLAPSE_RAY_LENGTH, 0), rayParams) ~= nil
		end

		local function FindIslandTool(toolName)
			local containers = { LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }
			for _, container in ipairs(containers) do
				local tool = container and container:FindFirstChild(toolName)
				if tool and tool:IsA("Tool") then
					return tool
				end
			end
			return nil
		end

		local function EquipIslandTool(tool)
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid and tool.Parent ~= character then
				pcall(humanoid.EquipTool, humanoid, tool)
			end
		end

		local function FacePosition(rootPart, targetPosition)
			local flatDirection = FlatVector(targetPosition - rootPart.Position)
			if flatDirection.Magnitude <= 0.1 then
				return
			end
			pcall(function()
				rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + flatDirection.Unit)
			end)
		end

		local function SwingEnemy(rootPart, enemyRoot)
			local useRemote = IslandRemote("RE/IslandWars/Use")
			local batTool = FindIslandTool(BAT_TOOL_NAME)
			if not useRemote or not useRemote:IsA("RemoteEvent") or not batTool then
				return false
			end
			EquipIslandTool(batTool)
			FacePosition(rootPart, enemyRoot.Position)
			IslandWars.Cooldowns.Bat = math.max(
				IslandWars.Cooldowns.Bat or 0,
				Workspace:GetServerTimeNow() + BAT_COOLDOWN_SEC
			)
			useRemote:FireServer("Swing", enemyRoot)
			return true
		end

		local function ShootTarget(rootPart, aimPosition)
			local useRemote = IslandRemote("RE/IslandWars/Use")
			local launcherTool = FindIslandTool(LAUNCHER_TOOL_NAME)
			if not useRemote or not useRemote:IsA("RemoteEvent") or not launcherTool then
				return false
			end
			local handlePart = launcherTool:FindFirstChild("Handle")
			local muzzleAttachment = handlePart and handlePart:FindFirstChild("Muzzle")
			local muzzlePosition = (
				muzzleAttachment
				and muzzleAttachment:IsA("Attachment")
				and muzzleAttachment.WorldPosition
			) or (rootPart.Position + Vector3.new(0, 1.5, 0))
			local aimDirection = aimPosition - muzzlePosition
			if aimDirection.Magnitude <= 1 then
				return false
			end
			EquipIslandTool(launcherTool)
			FacePosition(rootPart, aimPosition)
			IslandWars.Shot = IslandWars.Shot + 1
			IslandWars.Cooldowns.PumpkinLauncher = math.max(
				IslandWars.Cooldowns.PumpkinLauncher or 0,
				Workspace:GetServerTimeNow() + LAUNCHER_COOLDOWN_SEC
			)
			useRemote:FireServer("Launch", IslandWars.Shot, muzzlePosition, aimDirection.Unit)
			return true
		end

		local function RunIslandAction(snapshot, myEntry)
			local rootPart = Engine.Root()
			if not rootPart then
				return false
			end
			local centrePosition = ReadIslandCentre(snapshot)
			if centrePosition and (IslandWars.SuddenDeath or snapshot.Phase == "SuddenDeath" or IsFloorCollapsing(rootPart)) then
				local flatToCentre = FlatVector(centrePosition - rootPart.Position)
				if flatToCentre.Magnitude > REGROUP_DISTANCE then
					local character = LocalPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					local runSpeed = math.max(humanoid and humanoid.WalkSpeed or 16, REGROUP_MIN_SPEED)
					rootPart.AssemblyLinearVelocity = flatToCentre.Unit * runSpeed
						+ Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0)
					return true
				end
			end
			if snapshot.Phase == "Prep" then
				return false
			end
			local enemyTeam = myEntry.Team == "Red" and "Blue" or "Red"
			local scanRadius = FarmConfig.IslandWars_Target == "Walls And Crystal" and 0 or ENEMY_SCAN_RADIUS
			local enemyRoot, enemyDistance = FindNearestEnemyRoot(snapshot, enemyTeam, rootPart, scanRadius)
			local serverNow = Workspace:GetServerTimeNow()
			if enemyRoot
				and enemyDistance <= BAT_REACH
				and (IslandWars.Cooldowns.Bat or 0) <= serverNow
				and FindIslandTool(BAT_TOOL_NAME)
			then
				return SwingEnemy(rootPart, enemyRoot)
			end
			if (IslandWars.Cooldowns.PumpkinLauncher or 0) > serverNow then
				return true
			end
			local aimPosition = enemyRoot
					and (enemyRoot.Position + enemyRoot.AssemblyLinearVelocity * (enemyDistance / LAUNCHER_PROJECTILE_SPEED))
				or FindStructureAimPoint(snapshot, enemyTeam, "Barriers", "Hitbox")
				or FindStructureAimPoint(snapshot, enemyTeam, "Crystals", "Pivot")
			if not aimPosition then
				return false
			end
			return ShootTarget(rootPart, aimPosition)
		end

		local function ConnectIslandRemote(remotePath, callbackFn)
			if IslandWars.ConnectedPaths[remotePath] then
				return true
			end
			local remoteObj = IslandRemote(remotePath)
			if not remoteObj or not remoteObj:IsA("RemoteEvent") then
				return false
			end
			Hub.Lifecycle.TrackConnection(remoteObj.OnClientEvent:Connect(callbackFn))
			IslandWars.ConnectedPaths[remotePath] = true
			return true
		end

		local function ConnectIslandListeners()
			ConnectIslandRemote("RE/IslandWars/State", SetSnapshot)
			ConnectIslandRemote("RE/IslandWars/Moment", function(momentName, momentValue, momentNumber)
				if momentName == "Cooldown" and type(momentValue) == "string" then
					IslandWars.Cooldowns[momentValue] = tonumber(momentNumber) or 0
				elseif momentName == "SuddenDeath" or momentName == "EarlySuddenDeath" then
					IslandWars.SuddenDeath = true
				elseif momentName == "Warning" and (tonumber(momentValue) or math.huge) <= 15 then
					IslandWars.SuddenDeath = true
				elseif momentName == "CollapseWarn" and type(momentValue) == "table" then
					IslandWars.CollapseParts = momentValue
					IslandWars.CollapseAt = os.clock()
				elseif momentName == "Win" or momentName == "Outro" then
					IslandWars.SuddenDeath = false
				end
			end)
			ConnectIslandRemote("RE/LiveEvents/Began", function(eventName)
				if eventName ~= "CursedIslandWars" then
					return
				end
				IslandWars.Shot = 0
				IslandWars.SuddenDeath = false
				IslandWars.CollapseParts = nil
				task.spawn(RefreshSnapshot)
				Progression.Wake()
			end)
			ConnectIslandRemote("RE/LiveEvents/Ended", function(eventName)
				if eventName ~= "CursedIslandWars" then
					return
				end
				IslandWars.Snapshot = nil
				IslandWars.SuddenDeath = false
				IslandWars.CollapseParts = nil
				IslandWars.RestoreKnock()
			end)
		end
		ConnectIslandListeners()

		task.spawn(function()
			local runningRemote = IslandRemote("RF/LiveEvents/FetchRunning")
			if not runningRemote or not runningRemote:IsA("RemoteFunction") then
				return
			end
			local callOk, runningList = pcall(runningRemote.InvokeServer, runningRemote)
			if callOk and type(runningList) == "table" and runningList.CursedIslandWars then
				RefreshSnapshot()
			end
		end)

		AddWorker(function()
			if not FarmConfig.IslandWars_Auto then
				IslandWars.RestoreKnock()
				return false
			end
			ConnectIslandListeners()
			if os.clock() >= IslandWars.NextFetchAt then
				IslandWars.NextFetchAt = os.clock() + SNAPSHOT_REFRESH_SEC
				RefreshSnapshot()
			end
			local snapshot = IslandWars.Snapshot
			if type(snapshot) ~= "table" or (os.clock() - IslandWars.SnapshotAt) >= SNAPSHOT_MAX_AGE_SEC then
				IslandWars.Snapshot = nil
				return false
			end
			local myEntry = ReadMyEntry(snapshot)
			if not myEntry or not ACTIVE_PHASES[snapshot.Phase] then
				return false
			end
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 or myEntry.State ~= "Alive" then
				return false
			end
			if not Engine.ClaimMovement(MOVEMENT_OWNER) then
				return false
			end
			ToggleKnockSuppression(true)
			local callOk, acted = pcall(RunIslandAction, snapshot, myEntry)
			Engine.ReleaseMovement(MOVEMENT_OWNER)
			return callOk and acted == true
		end)

		function IslandWars.Wake()
			Progression.Wake()
		end
	end
end

-- 5Q. Chilli Gradient ESP Suite (Ultra-Light Event-Driven + 1.5ms Frame-Sliced, Zero FPS Drop)
do
	local CoreGuiService = game:GetService("CoreGui")
	local TextService = game:GetService("TextService")

	local EspState = {
		ScreenGui = nil,
		EggTags = {},
		GuardTags = {},
		PlayerTags = {},
		SlotBadges = {},
		TooltipBackup = {},
		ToolNameBackup = {},
		HeldEggTag = nil,
		EggDirty = true,
		InvDirty = true,
		SettingsRev = 1,
		NextEggSweepAt = 0,
		NextDistTickAt = 0,
		NextSlotDiscoverAt = 0,
		CachedSlotGuis = {},
		ActiveEggHighlights = 0,
	}
	Hub.ESP = EspState

	function EspState.MarkDirty(rescanSlots)
		EspState.SettingsRev = EspState.SettingsRev + 1
		EspState.EggDirty = true
		EspState.InvDirty = true
		if rescanSlots then
			EspState.NextSlotDiscoverAt = 0
		end
	end

	local MAX_EGG_HIGHLIGHTS = 12
	local FRAME_SLICE_BUDGET = 0.0015 -- Max 1.5ms per frame so FPS never stutters

	local function TryCreateFont(familyAsset, fontWeight)
		local callOk, fontObj = pcall(Font.new, familyAsset, fontWeight, Enum.FontStyle.Normal)
		return callOk and fontObj or nil
	end

	local MainEspFont = TryCreateFont("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold)
	local StatusEspFont = TryCreateFont("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular) or MainEspFont
	local RarityEspFont = TryCreateFont("rbxassetid://12187365977", Enum.FontWeight.Bold) or StatusEspFont

	local function BuildSequence(stopsList)
		local keypoints = table.create(#stopsList)
		for idx, pairItem in ipairs(stopsList) do
			keypoints[idx] = ColorSequenceKeypoint.new(pairItem[1], pairItem[2])
		end
		return ColorSequence.new(keypoints)
	end

	local function PaletteFromBaseColor(baseColor)
		local whiteColor = Color3.new(1, 1, 1)
		local blackColor = Color3.new(0, 0, 0)
		return {
			Text = BuildSequence({
				{ 0.0, baseColor:Lerp(whiteColor, 0.5) },
				{ 0.4, baseColor:Lerp(whiteColor, 0.1) },
				{ 1.0, baseColor:Lerp(blackColor, 0.25) },
			}),
			Stroke = BuildSequence({
				{ 0.0, baseColor:Lerp(blackColor, 0.55) },
				{ 0.55, baseColor:Lerp(blackColor, 0.75) },
				{ 1.0, baseColor:Lerp(blackColor, 0.92) },
			}),
			Outline = baseColor:Lerp(whiteColor, 0.25),
			Rotation = 90,
		}
	end

	local Palettes = {
		Gold = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 231, 158) },
				{ 0.4, Color3.fromRGB(255, 196, 66) },
				{ 1.0, Color3.fromRGB(214, 142, 12) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(122, 76, 0) },
				{ 0.55, Color3.fromRGB(62, 38, 0) },
				{ 1.0, Color3.fromRGB(20, 12, 0) },
			}),
			Outline = Color3.fromRGB(255, 232, 152),
			Rotation = 90,
		},
		Orange = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 198, 132) },
				{ 0.4, Color3.fromRGB(255, 146, 40) },
				{ 1.0, Color3.fromRGB(206, 92, 0) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(112, 54, 0) },
				{ 0.55, Color3.fromRGB(56, 27, 0) },
				{ 1.0, Color3.fromRGB(18, 8, 0) },
			}),
			Outline = Color3.fromRGB(255, 194, 112),
			Rotation = 90,
		},
		Red = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 105, 105) },
				{ 0.4, Color3.fromRGB(255, 28, 40) },
				{ 1.0, Color3.fromRGB(184, 0, 18) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(124, 0, 15) },
				{ 0.55, Color3.fromRGB(61, 0, 9) },
				{ 1.0, Color3.fromRGB(18, 0, 3) },
			}),
			Outline = Color3.fromRGB(255, 128, 138),
			Rotation = 90,
		},
		Accent = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(170, 255, 160) },
				{ 0.45, Color3.fromRGB(58, 255, 55) },
				{ 1.0, Color3.fromRGB(20, 109, 0) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(10, 52, 6) },
				{ 1.0, Color3.fromRGB(3, 16, 0) },
			}),
			Outline = Color3.fromRGB(58, 255, 55),
			Rotation = 90,
		},
		Sheen = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 255, 255) },
				{ 0.5, Color3.fromRGB(222, 222, 222) },
				{ 1.0, Color3.fromRGB(255, 255, 255) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(8, 8, 8) },
				{ 1.0, Color3.fromRGB(8, 8, 8) },
			}),
			Outline = Color3.fromRGB(255, 255, 255),
			Rotation = 90,
		},
		NameSheen = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 255, 255) },
				{ 0.5, Color3.fromRGB(222, 238, 255) },
				{ 1.0, Color3.fromRGB(255, 255, 255) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(8, 8, 8) },
				{ 1.0, Color3.fromRGB(8, 8, 8) },
			}),
			Outline = Color3.fromRGB(255, 255, 255),
			Rotation = 90,
		},
		ValueGreen = PaletteFromBaseColor(Color3.fromRGB(77, 255, 122)),
	}

	local SecretMetallicSeq = BuildSequence({
		{ 0.0, Color3.fromRGB(255, 255, 255) },
		{ 0.2, Color3.fromRGB(206, 212, 224) },
		{ 0.42, Color3.fromRGB(74, 80, 94) },
		{ 0.58, Color3.fromRGB(42, 46, 56) },
		{ 0.78, Color3.fromRGB(158, 166, 182) },
		{ 1.0, Color3.fromRGB(250, 252, 255) },
	})

	local MutationPalettes = {
		Golden = Palettes.Gold,
		Silver = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 255, 255) },
				{ 0.45, Color3.fromRGB(214, 222, 32 + 200) },
				{ 1.0, Color3.fromRGB(150, 160, 175) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(60, 66, 78) },
				{ 0.55, Color3.fromRGB(30, 33, 40) },
				{ 1.0, Color3.fromRGB(10, 11, 14) },
			}),
			Outline = Color3.fromRGB(214, 222, 232),
			Rotation = 90,
		},
		Sakura = PaletteFromBaseColor(Color3.fromRGB(255, 158, 216)),
		GreatBloom = PaletteFromBaseColor(Color3.fromRGB(124, 255, 196)),
		Boss = PaletteFromBaseColor(Color3.fromRGB(255, 122, 122)),
		Monstrous = PaletteFromBaseColor(Color3.fromRGB(192, 139, 255)),
		Rainbow = {
			Text = BuildSequence({
				{ 0.0, Color3.fromRGB(255, 107, 107) },
				{ 0.2, Color3.fromRGB(255, 179, 107) },
				{ 0.4, Color3.fromRGB(255, 240, 107) },
				{ 0.6, Color3.fromRGB(107, 255, 138) },
				{ 0.8, Color3.fromRGB(107, 200, 255) },
				{ 1.0, Color3.fromRGB(185, 107, 255) },
			}),
			Stroke = BuildSequence({
				{ 0.0, Color3.fromRGB(20, 20, 30) },
				{ 1.0, Color3.fromRGB(8, 8, 12) },
			}),
			Outline = Color3.fromRGB(255, 255, 255),
			Rotation = 0,
		},
	}
	local DefaultMutationPalette = PaletteFromBaseColor(Color3.fromRGB(143, 227, 255))
	local MUTATION_DISPLAY_ALIASES = {
		Boss = "Fractured",
		GreatBloom = "Spirit Bloom",
		Sakura = "Bloom",
		Monstrous = "Parasite",
	}

	local COMPACT_SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi" }
	local function FormatShortNumber(rawVal)
		local numVal = tonumber(rawVal) or 0
		local idx = 1
		while math.abs(numVal) >= 1000 and idx < #COMPACT_SUFFIXES do
			numVal = numVal / 1000
			idx = idx + 1
		end
		return string.format((idx == 1) and "%.0f%s" or "%.2f%s", numVal, COMPACT_SUFFIXES[idx])
	end

	local function GetEspScreenGui()
		if EspState.ScreenGui and EspState.ScreenGui.Parent then
			return EspState.ScreenGui
		end
		local hostGui = nil
		if typeof(gethui) == "function" then
			local okHui, huiInst = pcall(gethui)
			if okHui and typeof(huiInst) == "Instance" then
				hostGui = huiInst
			end
		end
		hostGui = hostGui or CoreGuiService or LocalPlayer:FindFirstChildOfClass("PlayerGui")
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "__N3Hub_ChilliESP"
		screenGui.Archivable = false
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.DisplayOrder = 48
		screenGui.Parent = hostGui
		EspState.ScreenGui = screenGui
		return screenGui
	end

	local function GetScaledRowHeight(sizeScale)
		local cam = Workspace.CurrentCamera
		local viewY = (cam and cam.ViewportSize.Y > 0) and cam.ViewportSize.Y or 1080
		local baseRow = math.clamp(viewY * 0.014, 13, 19)
		return math.max(6, math.floor(baseRow * (sizeScale or 0.75)))
	end

	local function GetScaledWidth(baseWidth, sizeScale)
		return math.max(30, math.floor(baseWidth * (sizeScale or 0.75)))
	end

	local function CreateBillboardTag(maxDistance)
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "N3EspTag"
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.MaxDistance = maxDistance or 1800
		billboardGui.Parent = GetEspScreenGui()

		local rootFrame = Instance.new("Frame")
		rootFrame.BackgroundTransparency = 1
		rootFrame.BorderSizePixel = 0
		rootFrame.Size = UDim2.fromScale(1, 1)
		rootFrame.Parent = billboardGui

		local listLayout = Instance.new("UIListLayout")
		listLayout.FillDirection = Enum.FillDirection.Vertical
		listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		listLayout.SortOrder = Enum.SortOrder.LayoutOrder
		listLayout.Parent = rootFrame

		return billboardGui, rootFrame
	end

	local function CreateChilliGradientRow(parentFrame, fontObj, orderIdx, heightScale)
		local holder = Instance.new("Frame")
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.Size = UDim2.fromScale(1, heightScale)
		holder.LayoutOrder = orderIdx
		holder.Parent = parentFrame

		local function makeScaledLabel(zIdx)
			local lbl = Instance.new("TextLabel")
			lbl.BackgroundTransparency = 1
			lbl.Size = UDim2.fromScale(1, 1)
			lbl.Text = ""
			lbl.TextScaled = true
			lbl.TextStrokeTransparency = 1
			lbl.TextXAlignment = Enum.TextXAlignment.Center
			lbl.TextYAlignment = Enum.TextYAlignment.Center
			lbl.ZIndex = zIdx
			if fontObj then
				pcall(function()
					lbl.FontFace = fontObj
				end)
			else
				lbl.Font = Enum.Font.GothamBold
			end
			lbl.Parent = holder
			return lbl
		end

		local shadowLabel = makeScaledLabel(2)
		shadowLabel.Position = UDim2.fromOffset(1, 1)
		shadowLabel.TextColor3 = Color3.new(0, 0, 0)
		shadowLabel.TextTransparency = 0.1

		local mainLabel = makeScaledLabel(3)
		mainLabel.TextColor3 = Color3.new(1, 1, 1)

		local strokeInst = Instance.new("UIStroke")
		strokeInst.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		strokeInst.LineJoinMode = Enum.LineJoinMode.Round
		strokeInst.Color = Color3.new(1, 1, 1)
		strokeInst.Transparency = 0.05
		local scaledOk = pcall(function()
			strokeInst.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		end)
		strokeInst.Thickness = scaledOk and 0.05 or 1.2
		strokeInst.Parent = mainLabel

		local strokeGrad = Instance.new("UIGradient")
		strokeGrad.Rotation = 90
		strokeGrad.Parent = strokeInst

		local textGrad = Instance.new("UIGradient")
		textGrad.Rotation = 90
		textGrad.Parent = mainLabel

		return {
			Holder = holder,
			Shadow = shadowLabel,
			Label = mainLabel,
			StrokeGradient = strokeGrad,
			TextGradient = textGrad,
			Palette = nil,
		}
	end

	local function SetChilliRow(rowObj, textValue, paletteObj)
		if rowObj.Label.Text ~= textValue then
			rowObj.Label.Text = textValue
			rowObj.Shadow.Text = textValue
		end
		if paletteObj and rowObj.Palette ~= paletteObj then
			rowObj.Palette = paletteObj
			rowObj.TextGradient.Color = paletteObj.Text
			rowObj.TextGradient.Rotation = paletteObj.Rotation or 90
			rowObj.StrokeGradient.Color = paletteObj.Stroke
		end
	end

	local CachedAssetMeta = {}
	local function ResolveAssetEspMeta(categoryName)
		local key = tostring(categoryName or "")
		if CachedAssetMeta[key] then
			return CachedAssetMeta[key]
		end
		local assetDir = AssetsModule and AssetsModule.Directory
		local assetDef = type(assetDir) == "table" and assetDir[key] or nil
		local rarityTbl = type(assetDef) == "table" and type(assetDef.Rarity) == "table" and assetDef.Rarity or nil
		local baseColor = (rarityTbl and typeof(rarityTbl.Color) == "Color3") and rarityTbl.Color or Color3.new(1, 1, 1)
		local basePalette = PaletteFromBaseColor(baseColor)

		local gradInst = rarityTbl and rarityTbl.RarityGradient
		if rarityTbl and typeof(gradInst) ~= "Instance" then
			local rsAssets = ReplicatedStorage:FindFirstChild("Assets")
			local uiFolder = rsAssets and rsAssets:FindFirstChild("UI")
			local gradFolder = uiFolder and uiFolder:FindFirstChild("RarityGradients")
			local rarityNode = gradFolder and gradFolder:FindFirstChild(tostring(rarityTbl._id or rarityTbl.DisplayName or ""))
			gradInst = rarityNode and rarityNode:FindFirstChild("RarityGradient") or nil
		end
		if typeof(gradInst) == "Instance" and gradInst:IsA("UIGradient") then
			basePalette.Text = gradInst.Color
			basePalette.Rotation = gradInst.Rotation
		end

		local rarityLabel = rarityTbl and tostring(rarityTbl.DisplayName or rarityTbl._id or "") or "Common"
		local rarityPalette = (string.upper(rarityLabel) == "SECRET")
			and { Text = SecretMetallicSeq, Stroke = basePalette.Stroke, Outline = basePalette.Outline, Rotation = 90 }
			or basePalette

		local rawIcon = type(assetDef) == "table" and assetDef.Icon or nil
		local iconAsset = ""
		if rawIcon and tostring(rawIcon) ~= "" then
			local strIcon = tostring(rawIcon)
			iconAsset = string.match(strIcon, "^%d+$") and ("rbxassetid://" .. strIcon) or strIcon
		end

		local meta = {
			Number = (rarityTbl and ToFiniteNumber(rarityTbl.RarityNumber or rarityTbl.Rank, 0)) or 0,
			RarityName = rarityLabel,
			Color = baseColor,
			Palette = basePalette,
			RarityPalette = rarityPalette,
			DisplayName = (type(assetDef) == "table" and tostring(assetDef.DisplayName or key)) or key,
			Icon = iconAsset,
		}
		CachedAssetMeta[key] = meta
		return meta
	end

	local function CollectEspMutationIds(eggRecord)
		local mutSet = {}
		if type(eggRecord.BaseMutation) == "string" and eggRecord.BaseMutation ~= "" and eggRecord.BaseMutation ~= "Normal" then
			mutSet[eggRecord.BaseMutation] = true
		end
		if type(eggRecord.Mutations) == "table" then
			for mutKey, mutVal in pairs(eggRecord.Mutations) do
				if type(mutVal) == "string" and mutVal ~= "" then
					mutSet[mutVal] = true
				elseif type(mutKey) == "string" and mutVal ~= false then
					mutSet[mutKey] = true
				end
			end
		end
		return mutSet
	end

	local function DestroyTagDict(dict, isEggDict)
		for dictKey, item in pairs(dict) do
			if item.Highlight then
				pcall(item.Highlight.Destroy, item.Highlight)
				if isEggDict then
					EspState.ActiveEggHighlights = math.max(0, EspState.ActiveEggHighlights - 1)
				end
			end
			if item.Billboard then
				pcall(item.Billboard.Destroy, item.Billboard)
			end
			if item.RestoreName then
				pcall(item.RestoreName)
			end
			dict[dictKey] = nil
		end
	end

	-- Event-Driven Dirty Triggers (zero polling waste when nothing changes!)
	if EggStateModule then
		for _, sigName in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
			local sig = EggStateModule[sigName]
			if type(sig) == "table" and type(sig.Connect) == "function" then
				local okConn, connObj = pcall(sig.Connect, sig, function()
					EspState.EggDirty = true
				end)
				if okConn and connObj then
					Hub.Lifecycle.TrackConnection(connObj)
				end
			end
		end
	end
	for _, folderName in ipairs({ "AreaEggSlotsClient", "PlacedEggRenders" }) do
		local wsFolder = Workspace:FindFirstChild(folderName)
		if wsFolder then
			Hub.Lifecycle.TrackConnection(wsFolder.ChildAdded:Connect(function()
				EspState.EggDirty = true
			end))
			Hub.Lifecycle.TrackConnection(wsFolder.ChildRemoved:Connect(function()
				EspState.EggDirty = true
			end))
		end
	end
	if type(SaveModule) == "table" then
		local sigFactory = (type(SaveModule.FieldSignal) == "function" and SaveModule.FieldSignal)
			or (type(SaveModule.Watch) == "function" and SaveModule.Watch)
		if sigFactory then
			local okSig, eggInvSig = pcall(sigFactory, "EggInventory")
			if okSig and eggInvSig and type(eggInvSig.Connect) == "function" then
				local okConn, connObj = pcall(eggInvSig.Connect, eggInvSig, function()
					EspState.InvDirty = true
					EspState.EggDirty = true
				end)
				if okConn and connObj then
					Hub.Lifecycle.TrackConnection(connObj)
				end
			end
		end
	end

	-- 5Q-2. Chilli Egg ESP (Event-Driven + Cached Hitbox/Signature + 1.5ms Frame Slicing)
	local EGG_ROW_WEIGHTS = {
		Icon = 3.2,
		Name = 1.35,
		Rarity = 1.2,
		Mutation = 1.0,
		Value = 1.1,
		Extra = 1.0,
	}

	local function SyncEggCardLayout(cardObj, sizeScale, fixedSize)
		local rows = {
			{ cardObj.IconHolder, EGG_ROW_WEIGHTS.Icon, cardObj.ShowIcon },
			{ cardObj.NameRow.Holder, EGG_ROW_WEIGHTS.Name, cardObj.ShowName },
			{ cardObj.RarityRow.Holder, EGG_ROW_WEIGHTS.Rarity, cardObj.ShowRarity },
			{ cardObj.MutationRow.Holder, EGG_ROW_WEIGHTS.Mutation, cardObj.ShowMutation },
			{ cardObj.ValueRow.Holder, EGG_ROW_WEIGHTS.Value, cardObj.ShowValue },
			{ cardObj.ExtraRow.Holder, EGG_ROW_WEIGHTS.Extra, cardObj.ShowExtra },
		}
		local weightSum = 0
		for _, item in ipairs(rows) do
			if item[3] then
				weightSum = weightSum + item[2]
			end
		end
		weightSum = math.max(weightSum, 1)
		for _, item in ipairs(rows) do
			item[1].Visible = item[3]
			item[1].Size = UDim2.fromScale(1, item[3] and (item[2] / weightSum) or 0)
		end

		local pxWidth = GetScaledWidth(120, sizeScale)
		local pxHeight = math.max(1, math.floor(GetScaledRowHeight(sizeScale) * weightSum))
		if fixedSize then
			local studW = 4.5 * sizeScale
			cardObj.Billboard.Size = UDim2.fromScale(studW, studW * (pxHeight / pxWidth))
		else
			cardObj.Billboard.Size = UDim2.fromOffset(pxWidth, pxHeight)
		end
	end

	local function CreateEggEspCard()
		local billboardGui, rootFrame = CreateBillboardTag(1800)
		local iconHolder = Instance.new("Frame")
		iconHolder.BackgroundTransparency = 1
		iconHolder.BorderSizePixel = 0
		iconHolder.LayoutOrder = 0
		iconHolder.Parent = rootFrame

		local iconLabel = Instance.new("ImageLabel")
		iconLabel.AnchorPoint = Vector2.new(0.5, 1)
		iconLabel.BackgroundTransparency = 1
		iconLabel.Position = UDim2.fromScale(0.5, 1)
		iconLabel.Size = UDim2.fromScale(1, 1)
		iconLabel.ScaleType = Enum.ScaleType.Fit
		iconLabel.Parent = iconHolder

		local aspect = Instance.new("UIAspectRatioConstraint")
		aspect.AspectRatio = 1
		aspect.DominantAxis = Enum.DominantAxis.Height
		aspect.Parent = iconLabel

		return {
			Billboard = billboardGui,
			IconHolder = iconHolder,
			Icon = iconLabel,
			NameRow = CreateChilliGradientRow(rootFrame, MainEspFont, 1, 0.25),
			RarityRow = CreateChilliGradientRow(rootFrame, RarityEspFont, 2, 0.2),
			MutationRow = CreateChilliGradientRow(rootFrame, MainEspFont, 3, 0.2),
			ValueRow = CreateChilliGradientRow(rootFrame, MainEspFont, 4, 0.2),
			ExtraRow = CreateChilliGradientRow(rootFrame, MainEspFont, 5, 0.15),
			Highlight = nil,
			CachedModel = nil,
			CachedHitbox = nil,
			LastSig = nil,
			BaseExtraText = "",
			BottomPos = nil,
		}
	end

	local function CollectPlacedEggsForPlayer(targetPlayer, areaLabel, prefixTag)
		local out = {}
		local placedRenders = Workspace:FindFirstChild("PlacedEggRenders")
		if not targetPlayer or not placedRenders or not EggStateModule or type(EggStateModule.ReadOwnerEggs) ~= "function" then
			return out
		end
		local callOk, ownerEggs = pcall(EggStateModule.ReadOwnerEggs, targetPlayer.UserId)
		if not callOk or type(ownerEggs) ~= "table" then
			return out
		end
		local userTag = tostring(targetPlayer.UserId)
		local userModels = {}
		for _, child in ipairs(placedRenders:GetChildren()) do
			if string.find(child.Name, userTag, 1, true) then
				table.insert(userModels, child)
			end
		end
		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table" and eggData.Placement ~= nil and type(eggData.AssetCategory) == "string" then
				local strUid = tostring(eggUid)
				local modelMatch = nil
				for _, candModel in ipairs(userModels) do
					if candModel.Name == strUid
						or string.find(candModel.Name, strUid, 1, true)
						or tostring(candModel:GetAttribute("Uid") or "") == strUid
					then
						modelMatch = candModel
						break
					end
				end
				if modelMatch then
					local okPiv, pivCF = pcall(function()
						return modelMatch:IsA("Model") and modelMatch:GetPivot() or modelMatch.CFrame
					end)
					table.insert(out, {
						Uid = prefixTag .. strUid,
						AssetCategory = eggData.AssetCategory,
						AssetScale = eggData.AssetScale,
						Mutations = type(eggData.Mutations) == "table" and eggData.Mutations or {},
						BaseMutation = eggData.BaseMutation,
						State = "Base",
						AreaId = areaLabel,
						BottomCFrame = okPiv and pivCF or nil,
						PhysicalModel = modelMatch,
					})
				end
			end
		end
		return out
	end

	local function UpdateEggEspPass()
		if not FarmConfig.ESP_Eggs then
			if next(EspState.EggTags) ~= nil then
				DestroyTagDict(EspState.EggTags, true)
			end
			return
		end

		local nowClock = os.clock()
		local infoFlags = FarmConfig.ESP_ShowInfo
		if not EspState.EggDirty and nowClock < EspState.NextEggSweepAt then
			-- Lightweight distance-only update once per second if Distance info is enabled
			if infoFlags.Distance and nowClock >= EspState.NextDistTickAt then
				EspState.NextDistTickAt = nowClock + 1.0
				local myRoot = Engine.Root()
				if myRoot then
					for _, card in pairs(EspState.EggTags) do
						if card.BottomPos and card.ShowExtra then
							local distMeters = string.format("%dm", math.floor((myRoot.Position - card.BottomPos).Magnitude + 0.5))
							local fullExtra = (card.BaseExtraText ~= "") and (card.BaseExtraText .. "  |  " .. distMeters) or distMeters
							SetChilliRow(card.ExtraRow, fullExtra, Palettes.Sheen)
						end
					end
				end
			end
			return
		end

		EspState.EggDirty = false
		EspState.NextEggSweepAt = nowClock + 3.0
		EspState.NextDistTickAt = nowClock + 1.0

		local allRecords = {}
		for _, rec in ipairs(Engine.CollectRawFieldEggs(false)) do
			table.insert(allRecords, rec)
		end
		if FarmConfig.ESP_OwnBaseEggs then
			for _, rec in ipairs(CollectPlacedEggsForPlayer(LocalPlayer, "Your Base", "base:")) do
				table.insert(allRecords, rec)
			end
		end
		if FarmConfig.ESP_OtherBaseEggs then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer then
					local baseTitle = plr.DisplayName .. " Base"
					for _, rec in ipairs(CollectPlacedEggsForPlayer(plr, baseTitle, "base_" .. tostring(plr.UserId) .. ":")) do
						table.insert(allRecords, rec)
					end
				end
			end
		end

		local minRarity = ToFiniteNumber(FarmConfig.ESP_MinRarityRank, 0)
		local minIncome = ToFiniteNumber(FarmConfig.ESP_MinValue, 0)
		local sizeScale = math.clamp(ToFiniteNumber(FarmConfig.ESP_EggSize, 75) / 100, 0.5, 2.0)
		local fixedSize = FarmConfig.ESP_FixedSize == true
		local myRoot = Engine.Root()
		local slotsFolder = Workspace:FindFirstChild("AreaEggSlotsClient")
		local terrainInst = Workspace:FindFirstChildOfClass("Terrain")
		local activeUids = {}
		local sliceClock = os.clock()

		for _, eggRec in ipairs(allRecords) do
			if not FarmConfig.ESP_Eggs then
				return
			end
			local uid = tostring(eggRec.Uid or "")
			if uid ~= "" and tostring(eggRec.State or "") ~= "Claimed" and type(eggRec.AssetCategory) == "string" then
				local meta = ResolveAssetEspMeta(eggRec.AssetCategory)
				local incomeVal = CalculateEggIncome(eggRec)
				if (minRarity <= 0 or meta.Number >= minRarity) and (minIncome <= 0 or incomeVal >= minIncome) then
					local modelInst = eggRec.PhysicalModel or (slotsFolder and slotsFolder:FindFirstChild(uid))
					local card = EspState.EggTags[uid]

					-- Cache Hitbox lookup per Model instance (eliminates recursive GetDescendants lag!)
					local partHitbox = nil
					if modelInst then
						if card and card.CachedModel == modelInst and card.CachedHitbox and card.CachedHitbox.Parent then
							partHitbox = card.CachedHitbox
						else
							partHitbox = modelInst:FindFirstChild("Hitbox") or modelInst:FindFirstChild("Hitbox", true) or modelInst:FindFirstChildWhichIsA("BasePart")
						end
					end

					local bottomCF = eggRec.BottomCFrame or eggRec.BoundsCFrame
					local adorneeTarget = partHitbox or terrainInst
					if adorneeTarget and (partHitbox or typeof(bottomCF) == "CFrame") then
						activeUids[uid] = true
						if not card then
							card = CreateEggEspCard()
							EspState.EggTags[uid] = card
						end
						card.CachedModel = modelInst
						card.CachedHitbox = partHitbox
						card.BottomPos = typeof(bottomCF) == "CFrame" and bottomCF.Position or (partHitbox and partHitbox.Position)

						if card.Billboard.Adornee ~= adorneeTarget or card.LastBottomCF ~= bottomCF then
							card.LastBottomCF = bottomCF
							card.Billboard.Adornee = adorneeTarget
							if typeof(bottomCF) == "CFrame" then
								local liftY = (partHitbox and (partHitbox.Position.Y - bottomCF.Position.Y) or 1.0) + 0.85
								card.Billboard.StudsOffsetWorldSpace = bottomCF.Position - adorneeTarget.Position + Vector3.new(0, liftY, 0)
							else
								card.Billboard.StudsOffsetWorldSpace = Vector3.new(0, 3.2, 0)
							end
						end

						local mutIds = {}
						for mutKey in pairs(CollectEspMutationIds(eggRec)) do
							table.insert(mutIds, mutKey)
						end
						table.sort(mutIds)
						local mutSig = table.concat(mutIds, ",")
						local stateSig = string.format(
							"%s|%.2f|%s|%s|%d",
							eggRec.AssetCategory,
							ToFiniteNumber(eggRec.AssetScale, 1),
							mutSig,
							tostring(eggRec.State or ""),
							EspState.SettingsRev
						)

						if card.LastSig ~= stateSig then
							card.LastSig = stateSig
							local primaryMut = (type(eggRec.BaseMutation) == "string" and eggRec.BaseMutation ~= "" and eggRec.BaseMutation ~= "Normal" and eggRec.BaseMutation)
								or mutIds[1]

							local showIcon = (infoFlags.Icon == true) and (meta.Icon ~= "")
							if showIcon and card.Icon.Image ~= meta.Icon then
								card.Icon.Image = meta.Icon
							end
							local showName = (infoFlags.Name == true)
							if showName then
								SetChilliRow(card.NameRow, meta.DisplayName, Palettes.NameSheen)
							end
							local showRarity = (infoFlags.Rarity == true and meta.RarityName ~= "")
							if showRarity then
								SetChilliRow(card.RarityRow, string.upper(meta.RarityName), meta.RarityPalette)
							end
							local showMut = (infoFlags.Mutation == true and #mutIds > 0)
							if showMut then
								local prettyMuts = {}
								for _, mKey in ipairs(mutIds) do
									table.insert(prettyMuts, string.upper(MUTATION_DISPLAY_ALIASES[mKey] or tostring(mKey)))
								end
								SetChilliRow(card.MutationRow, table.concat(prettyMuts, " + "), MutationPalettes[primaryMut] or DefaultMutationPalette)
							end
							local showVal = (infoFlags.Value == true)
							if showVal then
								SetChilliRow(card.ValueRow, "$" .. FormatShortNumber(incomeVal) .. "/s", Palettes.ValueGreen)
							end

							local baseExtras = {}
							if infoFlags.Weight then
								table.insert(baseExtras, FormatShortNumber(GetEggWeightKg(eggRec)) .. " kg")
							end
							if infoFlags.Size then
								table.insert(baseExtras, string.format("x%.2f", ToFiniteNumber(eggRec.AssetScale, 1)))
							end
							if infoFlags["Sell Price"] and EggRecordsModule and type(EggRecordsModule.SellPrice) == "function" then
								local okSell, sellPrice = pcall(EggRecordsModule.SellPrice, eggRec)
								if okSell and tonumber(sellPrice) then
									table.insert(baseExtras, "$" .. FormatShortNumber(sellPrice))
								end
							end
							if infoFlags.Area and eggRec.AreaId ~= nil then
								table.insert(baseExtras, tostring(eggRec.AreaId))
							end
							if infoFlags.State and eggRec.State ~= nil and eggRec.State ~= "Slot" then
								table.insert(baseExtras, tostring(eggRec.State))
							end
							card.BaseExtraText = table.concat(baseExtras, "  |  ")

							local fullExtra = card.BaseExtraText
							if infoFlags.Distance and myRoot and card.BottomPos then
								local distText = string.format("%dm", math.floor((myRoot.Position - card.BottomPos).Magnitude + 0.5))
								fullExtra = (fullExtra ~= "") and (fullExtra .. "  |  " .. distText) or distText
							end
							local showExtra = (fullExtra ~= "")
							if showExtra then
								SetChilliRow(card.ExtraRow, fullExtra, Palettes.Sheen)
							end

							card.ShowIcon = showIcon
							card.ShowName = showName
							card.ShowRarity = showRarity
							card.ShowMutation = showMut
							card.ShowValue = showVal
							card.ShowExtra = showExtra
							SyncEggCardLayout(card, sizeScale, fixedSize)
						end

						if meta.Number >= 6 and modelInst and modelInst:IsA("Model") then
							if not card.Highlight and EspState.ActiveEggHighlights < MAX_EGG_HIGHLIGHTS then
								local highlightInst = Instance.new("Highlight")
								highlightInst.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								highlightInst.FillTransparency = 0.82
								highlightInst.OutlineTransparency = 0.05
								highlightInst.FillColor = meta.Color
								highlightInst.OutlineColor = meta.Palette.Outline
								highlightInst.Parent = GetEspScreenGui()
								card.Highlight = highlightInst
								EspState.ActiveEggHighlights = EspState.ActiveEggHighlights + 1
							end
							if card.Highlight and card.Highlight.Adornee ~= modelInst then
								card.Highlight.Adornee = modelInst
							end
						elseif card.Highlight then
							card.Highlight:Destroy()
							card.Highlight = nil
							EspState.ActiveEggHighlights = math.max(0, EspState.ActiveEggHighlights - 1)
						end
					end
				end
			end

			if (os.clock() - sliceClock) > FRAME_SLICE_BUDGET then
				RunService.Heartbeat:Wait()
				sliceClock = os.clock()
			end
		end

		for uidKey, card in pairs(EspState.EggTags) do
			if not activeUids[uidKey] then
				if card.Highlight then
					pcall(card.Highlight.Destroy, card.Highlight)
					EspState.ActiveEggHighlights = math.max(0, EspState.ActiveEggHighlights - 1)
				end
				pcall(card.Billboard.Destroy, card.Billboard)
				EspState.EggTags[uidKey] = nil
			end
		end
	end

	-- 5Q-3. Chilli Guard ESP (Signature-Cached so unchanged guards cost 0 GUI writes!)
	local GUARD_PALETTES = {
		Sleeping = Palettes.Accent,
		Waking = Palettes.Gold,
		Chasing = Palettes.Red,
	}

	local function UpdateGuardEspPass()
		if not FarmConfig.ESP_Guards then
			if next(EspState.GuardTags) ~= nil then
				DestroyTagDict(EspState.GuardTags, false)
			end
			return
		end
		local world = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
		local areas = world and world:FindFirstChild("Areas")
		local guardAreas = areas and areas:FindFirstChild("GuardAreas")
		local sizeScale = math.clamp(ToFiniteNumber(FarmConfig.ESP_GuardSize, 75) / 100, 0.5, 2.0)
		local seenGuards = {}

		if guardAreas then
			for _, areaFolder in ipairs(guardAreas:GetChildren()) do
				local guardModel = areaFolder:FindFirstChild("Guard") or areaFolder:FindFirstChild("ForestGuardAuthored")
				if guardModel then
					local tag = EspState.GuardTags[guardModel]
					local guardRoot = (tag and tag.Root and tag.Root.Parent) and tag.Root
						or guardModel:FindFirstChild("HumanoidRootPart")
						or (guardModel:IsA("Model") and guardModel.PrimaryPart)
						or guardModel:FindFirstChildWhichIsA("BasePart")
					if guardRoot then
						seenGuards[guardModel] = true
						if not tag then
							local highlightInst = Instance.new("Highlight")
							highlightInst.Adornee = guardModel
							highlightInst.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							highlightInst.FillTransparency = 0.76
							highlightInst.OutlineTransparency = 0.02
							highlightInst.Parent = GetEspScreenGui()

							local billboardGui, rootFrame = CreateBillboardTag(1800)
							billboardGui.Adornee = guardRoot
							billboardGui.StudsOffsetWorldSpace = Vector3.new(0, 6, 0)

							local titleRow = CreateChilliGradientRow(rootFrame, StatusEspFont, 1, 0.45)
							local stateRow = CreateChilliGradientRow(rootFrame, StatusEspFont, 2, 0.55)
							SetChilliRow(titleRow, tostring(areaFolder.Name) .. " Guard", Palettes.Sheen)

							tag = {
								Root = guardRoot,
								Highlight = highlightInst,
								Billboard = billboardGui,
								TitleRow = titleRow,
								StateRow = stateRow,
								LastSig = nil,
							}
							EspState.GuardTags[guardModel] = tag
						end

						local guardState = tostring(guardModel:GetAttribute("GuardState") or "Awake")
						local targetAttr = tostring(guardModel:GetAttribute("TargetPlayer") or "")
						local guardSig = string.format("%s|%s|%.2f", guardState, targetAttr, sizeScale)
						if tag.LastSig ~= guardSig then
							tag.LastSig = guardSig
							local pal = GUARD_PALETTES[guardState] or Palettes.Orange
							local stateLabel = guardState
							if guardState == "Waking" then
								stateLabel = "Waking Up"
							elseif guardState == "Chasing" then
								if targetAttr == tostring(LocalPlayer.UserId) then
									stateLabel = "Chasing You"
								else
									local chasedPlr = tonumber(targetAttr) and Players:GetPlayerByUserId(tonumber(targetAttr)) or nil
									stateLabel = chasedPlr and ("Chasing " .. chasedPlr.DisplayName) or "Chasing"
								end
							end
							tag.Highlight.FillColor = pal.Outline
							tag.Highlight.OutlineColor = pal.Outline
							SetChilliRow(tag.StateRow, stateLabel, pal)
							tag.Billboard.Size = UDim2.fromOffset(
								GetScaledWidth(115, sizeScale),
								math.floor(GetScaledRowHeight(sizeScale) * 1.6)
							)
						end
					end
				end
			end
		end

		for guardModel, tag in pairs(EspState.GuardTags) do
			if not seenGuards[guardModel] then
				pcall(tag.Highlight.Destroy, tag.Highlight)
				pcall(tag.Billboard.Destroy, tag.Billboard)
				EspState.GuardTags[guardModel] = nil
			end
		end
	end

	-- 5Q-4. Chilli Horizontal Player ESP (Weak-Cached Tool Image + Signature-Cached Layout!)
	local PLAYER_TEXT_SEQ = BuildSequence({
		{ 0.0, Color3.fromRGB(138, 255, 205) },
		{ 0.5, Color3.fromRGB(125, 225, 255) },
		{ 1.0, Color3.fromRGB(210, 135, 255) },
	})
	local PLAYER_STROKE_SEQ = BuildSequence({
		{ 0.0, Color3.fromRGB(7, 73, 66) },
		{ 1.0, Color3.fromRGB(35, 17, 79) },
	})
	local CachedTextWidths = {}
	local CachedToolImages = setmetatable({}, { __mode = "k" })

	local function MeasurePlayerNameWidth(nameStr, fontSizePx)
		local cacheKey = nameStr .. "@" .. tostring(fontSizePx)
		if CachedTextWidths[cacheKey] then
			return CachedTextWidths[cacheKey]
		end
		local measured = nil
		pcall(function()
			local params = Instance.new("GetTextBoundsParams")
			params.Text = nameStr
			if MainEspFont then
				params.Font = MainEspFont
			end
			params.Size = fontSizePx
			params.Width = 1000
			local bounds = TextService:GetTextBoundsAsync(params)
			params:Destroy()
			measured = bounds.X
		end)
		measured = measured or ((utf8.len(nameStr) or #nameStr) * fontSizePx * 0.56)
		CachedTextWidths[cacheKey] = measured
		return measured
	end

	local function ResolveHeldToolImage(toolInst)
		if not toolInst or not toolInst:IsA("Tool") then
			return ""
		end
		if CachedToolImages[toolInst] ~= nil then
			return CachedToolImages[toolInst]
		end
		local function normalizeAsset(rawTex)
			local strTex = tostring(rawTex or "")
			if string.match(strTex, "^%d+$") then
				return "rbxassetid://" .. strTex
			end
			return strTex
		end
		local resolved = normalizeAsset(toolInst.TextureId)
		if resolved == "" then
			for _, attrName in ipairs({ "Icon", "Image", "Thumbnail", "TextureId" }) do
				local attrVal = toolInst:GetAttribute(attrName)
				if type(attrVal) == "string" and normalizeAsset(attrVal) ~= "" then
					resolved = normalizeAsset(attrVal)
					break
				end
			end
		end
		if resolved == "" then
			local gearName = tostring(toolInst:GetAttribute("GearName") or toolInst.Name)
			local gearDir = GearsModule and GearsModule.Directory
			local gearEntry = type(gearDir) == "table" and gearDir[gearName] or nil
			if type(gearEntry) == "table" and gearEntry.Icon and normalizeAsset(gearEntry.Icon) ~= "" then
				resolved = normalizeAsset(gearEntry.Icon)
			else
				local assetMeta = ResolveAssetEspMeta(tostring(toolInst:GetAttribute("AssetCategory") or gearName))
				if assetMeta and assetMeta.Icon ~= "" then
					resolved = assetMeta.Icon
				end
			end
		end
		if resolved == "" then
			for _, desc in ipairs(toolInst:GetDescendants()) do
				local found = (desc:IsA("Decal") and normalizeAsset(desc.Texture))
					or (desc:IsA("Texture") and normalizeAsset(desc.Texture))
					or ((desc:IsA("ImageLabel") or desc:IsA("ImageButton")) and normalizeAsset(desc.Image))
					or ""
				if found ~= "" then
					resolved = found
					break
				end
			end
		end
		CachedToolImages[toolInst] = resolved
		return resolved
	end

	local function CreateChilliPlayerTag(targetPlayer, character, headPart, rootPart)
		local highlightInst = Instance.new("Highlight")
		highlightInst.Name = "N3PlrHighlight"
		highlightInst.Adornee = character
		highlightInst.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlightInst.FillColor = Color3.fromRGB(0, 67, 148)
		highlightInst.FillTransparency = 0.76
		highlightInst.OutlineColor = Color3.fromRGB(72, 207, 255)
		highlightInst.OutlineTransparency = 0.02
		highlightInst.Parent = GetEspScreenGui()

		local anchorPart = rootPart or headPart
		local offsetY = (anchorPart ~= headPart)
			and math.clamp(headPart.Position.Y - anchorPart.Position.Y + 3.1, 3.8, 6.0)
			or 3.1

		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "N3PlrBillboard"
		billboardGui.Adornee = anchorPart
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.MaxDistance = 1800
		billboardGui.Size = UDim2.fromOffset(120, 28)
		billboardGui.StudsOffsetWorldSpace = Vector3.new(0, offsetY, 0)
		billboardGui.Parent = GetEspScreenGui()

		local canvas = Instance.new("Frame")
		canvas.Size = UDim2.fromScale(1, 1)
		canvas.BackgroundTransparency = 1
		canvas.Parent = billboardGui

		local function makeSquareIcon(zIdx)
			local img = Instance.new("ImageLabel")
			img.AnchorPoint = Vector2.new(0, 0.5)
			img.BackgroundTransparency = 1
			img.ScaleType = Enum.ScaleType.Fit
			img.ZIndex = zIdx
			img.Parent = canvas
			local ratio = Instance.new("UIAspectRatioConstraint")
			ratio.AspectRatio = 1
			ratio.Parent = img
			return img
		end

		local avatarImg = makeSquareIcon(2)
		avatarImg.ScaleType = Enum.ScaleType.Crop
		avatarImg.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100", targetPlayer.UserId)
		local avatarCorner = Instance.new("UICorner")
		avatarCorner.CornerRadius = UDim.new(1, 0)
		avatarCorner.Parent = avatarImg

		local function makePlrLabel(zIdx)
			local lbl = Instance.new("TextLabel")
			lbl.AnchorPoint = Vector2.new(0, 0.5)
			lbl.BackgroundTransparency = 1
			lbl.Text = ""
			lbl.TextScaled = true
			lbl.TextStrokeTransparency = 1
			lbl.TextXAlignment = Enum.TextXAlignment.Center
			lbl.TextYAlignment = Enum.TextYAlignment.Center
			lbl.ZIndex = zIdx
			if MainEspFont then
				pcall(function()
					lbl.FontFace = MainEspFont
				end)
			else
				lbl.Font = Enum.Font.GothamBlack
			end
			lbl.Parent = canvas
			return lbl
		end

		local shadowLbl = makePlrLabel(1)
		shadowLbl.TextColor3 = Color3.fromRGB(7, 19, 34)
		shadowLbl.TextTransparency = 0.05

		local nameLbl = makePlrLabel(2)
		nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)

		local nameStroke = Instance.new("UIStroke")
		nameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		nameStroke.LineJoinMode = Enum.LineJoinMode.Round
		nameStroke.Color = Color3.fromRGB(255, 255, 255)
		nameStroke.Transparency = 0
		local okScaled = pcall(function()
			nameStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		end)
		nameStroke.Thickness = okScaled and 0.044 or 1.4
		nameStroke.Parent = nameLbl

		local strokeGrad = Instance.new("UIGradient")
		strokeGrad.Color = PLAYER_STROKE_SEQ
		strokeGrad.Rotation = 90
		strokeGrad.Parent = nameStroke

		local textGrad = Instance.new("UIGradient")
		textGrad.Color = PLAYER_TEXT_SEQ
		textGrad.Rotation = 90
		textGrad.Parent = nameLbl

		local toolShadow = makeSquareIcon(1)
		toolShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		toolShadow.ImageTransparency = 0.35

		local toolIcon = makeSquareIcon(2)

		local hum = character:FindFirstChildOfClass("Humanoid")
		local savedDist = hum and hum.NameDisplayDistance or nil
		if hum then
			pcall(function()
				hum.NameDisplayDistance = 0
			end)
		end

		return {
			Player = targetPlayer,
			Character = character,
			Highlight = highlightInst,
			Billboard = billboardGui,
			Avatar = avatarImg,
			Shadow = shadowLbl,
			Name = nameLbl,
			ToolShadow = toolShadow,
			ToolIcon = toolIcon,
			LastSig = nil,
			RestoreName = function()
				if hum and hum.Parent and savedDist ~= nil then
					pcall(function()
						hum.NameDisplayDistance = savedDist
					end)
				end
			end,
		}
	end

	local function LayoutChilliPlayerTag(tag, sizeScale, pInfo)
		local cam = Workspace.CurrentCamera
		local viewY = (cam and cam.ViewportSize.Y > 0) and cam.ViewportSize.Y or 1080
		local barHeight = math.max(1, math.floor(math.clamp(viewY * 0.024, 26, 35) * sizeScale))

		local showName = (pInfo.Name == true or pInfo.Username == true)
		local showAvatar = (pInfo.Avatar == true)
		local heldTool = (pInfo.Tool == true) and (tag.Character and tag.Character:FindFirstChildOfClass("Tool")) or nil
		local toolImg = heldTool and ResolveHeldToolImage(heldTool) or ""
		local dispStr = (pInfo.Username == true) and tag.Player.Name or tag.Player.DisplayName

		local layoutSig = string.format("%s|%s|%d|%s|%s", dispStr, toolImg, barHeight, tostring(showName), tostring(showAvatar))
		if tag.LastSig == layoutSig then
			return
		end
		tag.LastSig = layoutSig

		tag.ToolIcon.Image = toolImg
		tag.ToolShadow.Image = toolImg
		local showTool = (pInfo.Tool == true and toolImg ~= "")

		local avatarPx = showAvatar and math.floor(barHeight * 0.72) or 0
		local toolPx = showTool and math.floor(barHeight * 0.82) or 0
		local textHeightPx = math.floor(barHeight * 0.70)
		local gapPx = math.max(2, math.floor(barHeight * 0.06))

		tag.Name.Text = dispStr
		tag.Shadow.Text = dispStr

		local textWidthPx = showName and math.floor(math.clamp(MeasurePlayerNameWidth(dispStr, textHeightPx) + 6, textHeightPx, 240)) or 0
		local nameStartX = (avatarPx > 0) and (avatarPx + gapPx) or 0
		local afterNameX = showName and (nameStartX + textWidthPx) or avatarPx
		local toolStartX = (afterNameX > 0) and (afterNameX + gapPx) or 0
		local totalWidth = math.max(showTool and (toolStartX + toolPx) or afterNameX, 1)

		local pxX = 1 / totalWidth
		local pxY = 1 / barHeight
		tag.Billboard.Size = UDim2.fromOffset(totalWidth, barHeight)

		tag.Avatar.Visible = showAvatar
		tag.Name.Visible = showName
		tag.Shadow.Visible = showName
		tag.ToolIcon.Visible = showTool
		tag.ToolShadow.Visible = showTool

		tag.Avatar.Position = UDim2.fromScale(0, 0.5)
		tag.Avatar.Size = UDim2.fromScale(avatarPx / totalWidth, avatarPx / barHeight)

		tag.Name.Position = UDim2.fromScale(nameStartX / totalWidth, 0.5)
		tag.Name.Size = UDim2.fromScale(textWidthPx / totalWidth, textHeightPx / barHeight)
		tag.Shadow.Position = UDim2.fromScale(nameStartX / totalWidth + pxX, 0.5 + pxY)
		tag.Shadow.Size = tag.Name.Size

		tag.ToolIcon.Position = UDim2.fromScale(toolStartX / totalWidth, 0.5)
		tag.ToolIcon.Size = UDim2.fromScale(toolPx / totalWidth, toolPx / barHeight)
		tag.ToolShadow.Position = UDim2.fromScale(toolStartX / totalWidth + pxX, 0.5 + pxY)
		tag.ToolShadow.Size = tag.ToolIcon.Size
	end

	local function UpdatePlayerEspPass()
		if not FarmConfig.ESP_Players then
			if next(EspState.PlayerTags) ~= nil then
				DestroyTagDict(EspState.PlayerTags, false)
			end
			return
		end
		local sizeScale = math.clamp(ToFiniteNumber(FarmConfig.ESP_PlayerSize, 75) / 100, 0.5, 2.0)
		local pInfo = FarmConfig.ESP_PlayerInfo
		local seenPlrs = {}

		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:IsDescendantOf(Workspace) then
				local char = plr.Character
				local head = char:FindFirstChild("Head")
				local root = char:FindFirstChild("HumanoidRootPart")
				if head and head:IsA("BasePart") then
					seenPlrs[plr] = true
					local existing = EspState.PlayerTags[plr]
					if existing and existing.Character ~= char then
						if existing.RestoreName then
							pcall(existing.RestoreName)
						end
						pcall(existing.Highlight.Destroy, existing.Highlight)
						pcall(existing.Billboard.Destroy, existing.Billboard)
						existing = nil
					end
					if not existing then
						existing = CreateChilliPlayerTag(plr, char, head, (root and root:IsA("BasePart")) and root or nil)
						EspState.PlayerTags[plr] = existing
					end
					LayoutChilliPlayerTag(existing, sizeScale, pInfo)
				end
			end
		end

		for plrKey, tag in pairs(EspState.PlayerTags) do
			if not seenPlrs[plrKey] then
				if tag.RestoreName then
					pcall(tag.RestoreName)
				end
				pcall(tag.Highlight.Destroy, tag.Highlight)
				pcall(tag.Billboard.Destroy, tag.Billboard)
				EspState.PlayerTags[plrKey] = nil
			end
		end
	end

	-- 5Q-5. Cached Inventory Egg Slot Value Overlay (Zero GetDescendants Spike!)
	local INV_GUI_KEYWORDS = { "hotbar", "toolbar", "backpack", "satchel", "inventory", "egg" }

	local function IsRelevantInventoryGuiRoot(screenInst)
		local low = string.lower(tostring(screenInst.Name or ""))
		for _, keyword in ipairs(INV_GUI_KEYWORDS) do
			if string.find(low, keyword, 1, true) then
				return true
			end
		end
		return low == "hud" or low == "mainui" or low == "gameui"
	end

	local function DiscoverInventorySlotGuis()
		local discovered = {}
		local roots = {}
		local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if playerGui then
			for _, child in ipairs(playerGui:GetChildren()) do
				if child ~= EspState.ScreenGui and child ~= LibraryLoader.ScreenGui and IsRelevantInventoryGuiRoot(child) then
					table.insert(roots, child)
				end
			end
		end
		pcall(function()
			local rbxGui = CoreGuiService:FindFirstChild("RobloxGui")
			local bpGui = rbxGui and rbxGui:FindFirstChild("Backpack")
			if bpGui then
				table.insert(roots, bpGui)
			end
		end)
		pcall(function()
			for _, coreChild in ipairs(CoreGuiService:GetChildren()) do
				if coreChild ~= EspState.ScreenGui and coreChild ~= LibraryLoader.ScreenGui and IsRelevantInventoryGuiRoot(coreChild) then
					table.insert(roots, coreChild)
				end
			end
		end)

		local sliceAt = os.clock()
		for _, rootGui in ipairs(roots) do
			for _, guiObj in ipairs(rootGui:GetDescendants()) do
				if (guiObj:IsA("ImageButton") or guiObj:IsA("TextButton") or guiObj:IsA("Frame"))
					and guiObj.Name ~= "__N3EggSlotValue"
					and guiObj.AbsoluteSize.X >= 34
					and guiObj.AbsoluteSize.X <= 220
					and guiObj.AbsoluteSize.Y >= 34
					and guiObj.AbsoluteSize.Y <= 220
				then
					local hasSlotClue = (tonumber(guiObj.Name) ~= nil)
						or (guiObj:GetAttribute("UID") ~= nil)
						or (guiObj:GetAttribute("Uid") ~= nil)
						or (guiObj:GetAttribute("EggUid") ~= nil)
						or (guiObj:FindFirstChild("ToolName") ~= nil)
						or (guiObj:FindFirstChild("ItemName") ~= nil)
						or (guiObj:FindFirstChild("Icon") ~= nil)
						or (guiObj:FindFirstChild("ToolIcon") ~= nil)
						or (guiObj:FindFirstChild("SlotNumber") ~= nil)
						or (guiObj:FindFirstChild("Number") ~= nil)
					if hasSlotClue then
						table.insert(discovered, guiObj)
					end
				end
				if (os.clock() - sliceAt) > FRAME_SLICE_BUDGET then
					RunService.Heartbeat:Wait()
					sliceAt = os.clock()
				end
			end
		end
		EspState.CachedSlotGuis = discovered
		EspState.NextSlotDiscoverAt = os.clock() + 8.0
	end

	local function ClearInventoryValueBadges()
		for slotGui, badgeFrame in pairs(EspState.SlotBadges) do
			if badgeFrame then
				pcall(badgeFrame.Destroy, badgeFrame)
			end
			EspState.SlotBadges[slotGui] = nil
		end
		for toolInst, origTip in pairs(EspState.TooltipBackup) do
			if toolInst and toolInst.Parent then
				pcall(function()
					toolInst.ToolTip = origTip
				end)
			end
			EspState.TooltipBackup[toolInst] = nil
		end
		for toolInst, origName in pairs(EspState.ToolNameBackup) do
			if toolInst and toolInst.Parent then
				pcall(function()
					toolInst.Name = origName
				end)
			end
			EspState.ToolNameBackup[toolInst] = nil
		end
		if EspState.HeldEggTag then
			pcall(EspState.HeldEggTag.Billboard.Destroy, EspState.HeldEggTag.Billboard)
			EspState.HeldEggTag = nil
		end
	end

	local function AttachOrUpdateSlotBadge(slotGui, rateText)
		local holder = EspState.SlotBadges[slotGui]
		if not holder or not holder.Parent then
			holder = Instance.new("Frame")
			holder.Name = "__N3EggSlotValue"
			holder.AnchorPoint = Vector2.new(0.5, 1)
			holder.Position = UDim2.new(0.5, 0, 1, -2)
			holder.Size = UDim2.new(1, -2, 0, 15)
			holder.BackgroundTransparency = 1
			holder.ZIndex = math.max((slotGui.ZIndex or 1) + 6, 10)
			holder.Parent = slotGui

			local row = CreateChilliGradientRow(holder, MainEspFont, 1, 1.0)
			row.Shadow.ZIndex = holder.ZIndex
			row.Label.ZIndex = holder.ZIndex + 1
			SetChilliRow(row, rateText, Palettes.ValueGreen)
			holder:SetAttribute("CachedRate", rateText)
			EspState.SlotBadges[slotGui] = holder
		elseif holder:GetAttribute("CachedRate") ~= rateText then
			holder:SetAttribute("CachedRate", rateText)
			for _, child in ipairs(holder:GetDescendants()) do
				if child:IsA("TextLabel") then
					child.Text = rateText
				end
			end
		end
	end

	local function UpdateInventoryValueOverlay()
		if not FarmConfig.ESP_InventoryValue then
			if next(EspState.SlotBadges) ~= nil or EspState.HeldEggTag ~= nil or next(EspState.ToolNameBackup) ~= nil then
				ClearInventoryValueBadges()
			end
			return
		end

		if os.clock() >= EspState.NextSlotDiscoverAt then
			DiscoverInventorySlotGuis()
		end

		local ownerEggs = (EggStateModule and type(EggStateModule.ReadOwnerEggs) == "function")
			and select(2, pcall(EggStateModule.ReadOwnerEggs, LocalPlayer.UserId))
			or nil
		if type(ownerEggs) ~= "table" then
			return
		end

		local rateByUid = {}
		for eggUid, eggData in pairs(ownerEggs) do
			if type(eggData) == "table" and eggData.AssetCategory then
				local strUid = tostring(eggUid)
				local income = CalculateEggIncome(eggData)
				local meta = ResolveAssetEspMeta(eggData.AssetCategory)
				rateByUid[strUid] = {
					RateText = "$" .. FormatShortNumber(income) .. "/s",
					DisplayName = meta.DisplayName,
					Icon = meta.Icon,
				}
			end
		end

		local orderedTools = {}
		local rateByToolName = {}
		local rateByIcon = {}
		local heldEggInfo, heldEggPart = nil, nil

		local character = LocalPlayer.Character
		local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
		if character then
			local eqTool = character:FindFirstChildOfClass("Tool")
			if eqTool then
				table.insert(orderedTools, eqTool)
				local eqUid = tostring(eqTool:GetAttribute("UID") or eqTool:GetAttribute("Uid") or "")
				if rateByUid[eqUid] then
					heldEggInfo = rateByUid[eqUid]
					heldEggPart = eqTool:FindFirstChild("Handle") or eqTool:FindFirstChildWhichIsA("BasePart") or character:FindFirstChild("Head")
				end
			end
		end
		if backpack then
			for _, bpTool in ipairs(backpack:GetChildren()) do
				if bpTool:IsA("Tool") then
					table.insert(orderedTools, bpTool)
				end
			end
		end

		local slotIndexToRate = {}
		for idx, toolInst in ipairs(orderedTools) do
			local uid = tostring(toolInst:GetAttribute("UID") or toolInst:GetAttribute("Uid") or "")
			local info = rateByUid[uid]
			if info then
				slotIndexToRate[idx] = info.RateText
				local baseToolName = EspState.ToolNameBackup[toolInst] or toolInst.Name
				rateByToolName[baseToolName] = info.RateText
				rateByToolName[toolInst.Name] = info.RateText
				local tex = tostring(toolInst.TextureId or "")
				if tex ~= "" then
					rateByIcon[tex] = info.RateText
				end
				if info.Icon ~= "" then
					rateByIcon[info.Icon] = info.RateText
				end
				if EspState.TooltipBackup[toolInst] == nil then
					EspState.TooltipBackup[toolInst] = toolInst.ToolTip
				end
				local richTip = info.DisplayName .. " - " .. info.RateText
				if toolInst.ToolTip ~= richTip then
					pcall(function()
						toolInst.ToolTip = richTip
					end)
				end
			end
		end

		if heldEggInfo and heldEggPart and heldEggPart:IsA("BasePart") then
			if not EspState.HeldEggTag then
				local heldBillboard, rootFrame = CreateBillboardTag(80)
				heldBillboard.Size = UDim2.fromOffset(115, 22)
				heldBillboard.StudsOffsetWorldSpace = Vector3.new(0, 2.2, 0)
				local row = CreateChilliGradientRow(rootFrame, MainEspFont, 1, 1.0)
				EspState.HeldEggTag = { Billboard = heldBillboard, Row = row }
			end
			EspState.HeldEggTag.Billboard.Adornee = heldEggPart
			SetChilliRow(EspState.HeldEggTag.Row, heldEggInfo.RateText, Palettes.ValueGreen)
		elseif EspState.HeldEggTag then
			pcall(EspState.HeldEggTag.Billboard.Destroy, EspState.HeldEggTag.Billboard)
			EspState.HeldEggTag = nil
		end

		local touchedSlots = {}
		for _, guiObj in ipairs(EspState.CachedSlotGuis) do
			if guiObj.Parent and guiObj.Visible then
				local matchedRate = nil
				for _, attrKey in ipairs({ "UID", "Uid", "EggUid", "Id", "ItemId" }) do
					local attrVal = guiObj:GetAttribute(attrKey)
					if attrVal and rateByUid[tostring(attrVal)] then
						matchedRate = rateByUid[tostring(attrVal)].RateText
						break
					end
				end
				if not matchedRate and rateByUid[guiObj.Name] then
					matchedRate = rateByUid[guiObj.Name].RateText
				end
				if not matchedRate and (guiObj:IsA("ImageButton") or guiObj:IsA("TextButton")) then
					local numSlot = tonumber(guiObj.Name)
					if not numSlot then
						local numLbl = guiObj:FindFirstChild("Number") or guiObj:FindFirstChild("SlotNumber") or guiObj:FindFirstChild("Hotkey")
						if numLbl and numLbl:IsA("TextLabel") then
							local rawKey = string.match(numLbl.Text, "^%s*(%d)%s*$")
							numSlot = rawKey and (rawKey == "0" and 10 or tonumber(rawKey)) or nil
						end
					elseif numSlot == 0 then
						numSlot = 10
					end
					if numSlot and slotIndexToRate[numSlot] then
						matchedRate = slotIndexToRate[numSlot]
					end
				end
				if not matchedRate and (guiObj:IsA("ImageButton") or guiObj:IsA("TextButton")) then
					local nameLbl = guiObj:FindFirstChild("ToolName") or guiObj:FindFirstChild("ItemName")
					if nameLbl and nameLbl:IsA("TextLabel") and rateByToolName[nameLbl.Text] then
						matchedRate = rateByToolName[nameLbl.Text]
					else
						local iconChild = guiObj:FindFirstChild("Icon") or guiObj:FindFirstChild("ToolIcon")
						if iconChild and iconChild:IsA("ImageLabel") and iconChild.Image ~= "" and rateByIcon[iconChild.Image] then
							matchedRate = rateByIcon[iconChild.Image]
						end
					end
				end
				if matchedRate then
					touchedSlots[guiObj] = true
					AttachOrUpdateSlotBadge(guiObj, matchedRate)
				end
			end
		end

		for slotGui, badgeFrame in pairs(EspState.SlotBadges) do
			if not touchedSlots[slotGui] or not slotGui.Parent then
				pcall(badgeFrame.Destroy, badgeFrame)
				EspState.SlotBadges[slotGui] = nil
			end
		end

		if next(touchedSlots) == nil then
			for _, toolInst in ipairs(orderedTools) do
				local uid = tostring(toolInst:GetAttribute("UID") or toolInst:GetAttribute("Uid") or "")
				local info = rateByUid[uid]
				if info then
					if EspState.ToolNameBackup[toolInst] == nil then
						EspState.ToolNameBackup[toolInst] = toolInst.Name
					end
					local desiredName = EspState.ToolNameBackup[toolInst] .. "\n" .. info.RateText
					if toolInst.Name ~= desiredName then
						pcall(function()
							toolInst.Name = desiredName
						end)
					end
				end
			end
		elseif next(EspState.ToolNameBackup) ~= nil then
			for toolInst, origName in pairs(EspState.ToolNameBackup) do
				if toolInst and toolInst.Parent then
					pcall(function()
						toolInst.Name = origName
					end)
				end
				EspState.ToolNameBackup[toolInst] = nil
			end
		end
	end

	function EspState.ClearAll()
		DestroyTagDict(EspState.EggTags, true)
		DestroyTagDict(EspState.GuardTags, false)
		DestroyTagDict(EspState.PlayerTags, false)
		ClearInventoryValueBadges()
		table.clear(EspState.CachedSlotGuis)
		if EspState.ScreenGui then
			pcall(EspState.ScreenGui.Destroy, EspState.ScreenGui)
			EspState.ScreenGui = nil
		end
	end

	Hub.Lifecycle.SpawnLoop(0.6, function()
		if Engine.Disposed then
			return
		end
		pcall(UpdateEggEspPass)
		pcall(UpdateInventoryValueOverlay)
		pcall(UpdateGuardEspPass)
		pcall(UpdatePlayerEspPass)
	end)

	pcall(function()
		LibraryLoader:OnUnload(EspState.ClearAll)
	end)
end

-- ============================================================================
-- 6. N3 HUB MODULAR UI BUILDER, TABS & LIFECYCLE
-- ============================================================================

local SaveManager = loadstring(game:HttpGet(RepoFile("Manager/SaveManager.luau")))()
local ThemeManager = loadstring(game:HttpGet(RepoFile("Manager/ThemeManger.luau")))()
local ServerManager = loadstring(game:HttpGet(RepoFile("Manager/ServerManger.luau")))()
local FpsManager = nil
pcall(function()
	local rawFpsSrc = game:HttpGet(RepoFile("Manager/FpsManger.luau"))
	if type(rawFpsSrc) == "string" and #rawFpsSrc > 64 and not string.find(rawFpsSrc, "^404:") then
		local chunkFn = loadstring(rawFpsSrc)
		if type(chunkFn) == "function" then
			FpsManager = chunkFn()
		end
	end
end)
if not FpsManager and type(isfile) == "function" and type(readfile) == "function" then
	pcall(function()
		if isfile("FpsManager.luau") then
			local localFn = loadstring(readfile("FpsManager.luau"))
			if type(localFn) == "function" then
				FpsManager = localFn()
			end
		end
	end)
end

LoadingScreen:SetMessage("Load All Requirements")
LoadingScreen:SetCurrentStep(4)
LoadingScreen:SetDescription("Building the window, tabs & all N3 Hub features...")

local function ApplySelectionTable(targetMap, selectedValues)
	table.clear(targetMap)
	if type(selectedValues) == "table" then
		for optionKey, isSelected in pairs(selectedValues) do
			if isSelected then
				targetMap[string.lower(tostring(optionKey))] = true
			end
		end
	end
end

local function ApplyCatalogSelection(targetMap, selectedValues)
	table.clear(targetMap)
	if type(selectedValues) == "table" then
		for labelKey, isPicked in pairs(selectedValues) do
			if isPicked then
				local resolvedCat = PlaceEggLabelToCategory[labelKey]
					or PlaceEggLabelToCategory[string.lower(tostring(labelKey))]
					or tostring(labelKey)
				targetMap[string.lower(resolvedCat)] = true
			end
		end
	end
end

function Hub.Features.BuildFarmEggs(farmGroup)
	local targetZoneDropdown = farmGroup:AddDropdown("Dropdown_TargetZone", {
		Text = "Zone",
		Values = AreaNamesList,
		Multi = true,
		Searchable = true,
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.SelectedZones, selectedValues)
		end,
	})

	local targetEggDropdown = farmGroup:AddDropdown("Dropdown_TargetEgg", {
		Text = "Egg",
		Values = EggNamesList,
		Multi = true,
		Searchable = true,
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.SelectedEggs, selectedValues)
		end,
	})

	local targetRarityDropdown = farmGroup:AddDropdown("Dropdown_TargetRarity", {
		Text = "Rarity",
		Values = RaritiesList,
		Multi = true,
		Searchable = true,
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.SelectedRarities, selectedValues)
		end,
	})

	Hub.UI.Dropdowns.FarmZones = targetZoneDropdown
	Hub.UI.Dropdowns.FarmEggs = targetEggDropdown
	Hub.UI.Dropdowns.FarmRarities = targetRarityDropdown

	farmGroup:AddDropdown("Dropdown_StealPriority", {
		Text = "Steal Priority",
		Values = StealPriorityOptions,
		Default = 4,
		Callback = function(selectedPriority)
			if type(selectedPriority) == "string" and selectedPriority ~= "" then
				Engine.State.Priority = selectedPriority
			end
		end,
	})

	farmGroup:AddDropdown("Dropdown_StealMethod", {
		Text = "Steal Method",
		Values = StealMethodOptions,
		Default = 2,
		Callback = function(selectedMethod)
			if selectedMethod == "Walk" or selectedMethod == "Fast Tween" then
				FarmConfig.StealMethod = selectedMethod
			end
		end,
	})

	farmGroup:AddDropdown("Dropdown_CarryVariant", {
		Text = "Delivery Logic",
		Values = CarryVariantOptions,
		Default = 2,
		Tooltip = "Fast Tween carry test variants: V1 fast glide, V2 chili legs, V3 chili single drop",
		Callback = function(selectedVariant)
			if type(selectedVariant) == "string" and selectedVariant ~= "" then
				FarmConfig.CarryVariant = selectedVariant
			end
		end,
	})

	farmGroup:AddSlider("Slider_AutoSteal_FastTweenSpeed", {
		Text = "Fast Tween Speed",
		Min = 3000,
		Max = 4500,
		Default = 3300,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.FastTweenSpeed = math.clamp(ToFiniteNumber(sliderVal, 3300), 3000, 4500)
		end,
	})

	-- Purple-Pink (#D946EF) prefix "Status:" + normal UI color answer text
	local stealStatusRow = Hub.Theme.CreateStatusLabel(farmGroup, "Status", "Idle")

	farmGroup:AddToggle("Toggle_AutoStealAll", {
		Text = "Auto Steal",
		Default = false,
		Tooltip = "Automatically steals matching field eggs and delivers them safely into Safe Zone",
		Callback = function(isEnabled)
			FarmConfig.AutoStealEnabled = isEnabled
			FarmConfig.AutoStealAll = isEnabled
			FarmConfig.StealAllMode = isEnabled
			RuntimeState.SessionId = RuntimeState.SessionId + 1
			if isEnabled then
				if Engine.AutoWake then
					pcall(Engine.AutoWake)
				end
			else
				Engine.StopSafeZoneVisual()
				Engine.CancelAutoSteal()
			end
		end,
	})

	farmGroup:AddToggle("Toggle_Farm_SafeZoneVisual", {
		Text = "Safe Zone Visual",
		Default = false,
		Tooltip = "Anchors your visual character & camera in Safe Zone while Auto Steal runs",
		Callback = function(isEnabled)
			FarmConfig.SafeZoneVisual = isEnabled
			if isEnabled and IsStealActive() then
				Engine.StartSafeZoneVisual()
			else
				Engine.StopSafeZoneVisual()
			end
		end,
	})

	-- Live dynamic catalog sync (no hardcoded static egg/zone tables)
	Hub.Lifecycle.SpawnLoop(10, function()
		if Engine.Disposed then
			return
		end
		local rawEggs = Engine.CollectRawFieldEggs(false)
		if #rawEggs == 0 then
			return
		end

		local knownZones, knownEggs = {}, {}
		for _, zoneName in ipairs(AreaNamesList) do
			knownZones[zoneName] = true
		end
		for _, eggName in ipairs(EggNamesList) do
			knownEggs[eggName] = true
		end

		local zonesChanged, eggsChanged = false, false
		for _, eggRecord in ipairs(rawEggs) do
			local areaId = type(eggRecord.AreaId) == "string" and eggRecord.AreaId or nil
			local eggName = type(eggRecord.AssetCategory) == "string" and eggRecord.AssetCategory or nil
			if areaId and areaId ~= "" and not knownZones[areaId] then
				knownZones[areaId] = true
				AreaRankByName[areaId] = AreaRankByName[areaId] or (#AreaNamesList + 1)
				table.insert(AreaNamesList, areaId)
				zonesChanged = true
			end
			if eggName and eggName ~= "" and not knownEggs[eggName] then
				knownEggs[eggName] = true
				table.insert(EggNamesList, eggName)
				eggsChanged = true
			end
		end

		if zonesChanged and targetZoneDropdown and targetZoneDropdown.SetValues then
			pcall(targetZoneDropdown.SetValues, targetZoneDropdown, AreaNamesList)
		end
		if eggsChanged and targetEggDropdown and targetEggDropdown.SetValues then
			table.sort(EggNamesList, function(eggA, eggB)
				local infoA = AssetInfoByLowerName[string.lower(tostring(eggA))]
				local infoB = AssetInfoByLowerName[string.lower(tostring(eggB))]
				local rankA = infoA and ToFiniteNumber(infoA.Rank, 0) or 0
				local rankB = infoB and ToFiniteNumber(infoB.Rank, 0) or 0
				if rankA ~= rankB then
					return rankA > rankB
				end
				return tostring(eggA) < tostring(eggB)
			end)
			pcall(targetEggDropdown.SetValues, targetEggDropdown, EggNamesList)
		end
	end)

	-- Live RichText status updater ("Status:" in #D946EF purple-pink, answer in clean default color)
	Hub.Lifecycle.SpawnLoop(0.2, function()
		if Engine.Disposed then
			return
		end
		local activeStatus = IsStealActive() and tostring(Engine.AutoStatus or "Running") or "Idle"
		stealStatusRow:SetValue(activeStatus)
	end)

	Hub.UI.StealStatus = stealStatusRow
end

function Hub.Features.BuildProgression(progressionGroup)
	progressionGroup:AddToggle("Toggle_Prog_AutoBuyTrail", {
		Text = "Auto Buy Trail",
		Default = false,
		Tooltip = "Automatically buys affordable trails in ascending price order",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoBuyTrail = isEnabled
			Hub.Progression.ResetTrailCache()
		end,
	})

	progressionGroup:AddToggle("Toggle_Prog_AutoUpgradeBase", {
		Text = "Auto Upgrade Base",
		Default = false,
		Tooltip = "Automatically upgrades your base tier when money is sufficient",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoUpgradeBase = isEnabled
			Hub.Progression.Wake()
		end,
	})

	progressionGroup:AddToggle("Toggle_Prog_AutoUpgradeTreadmill", {
		Text = "Auto Upgrade Treadmill",
		Default = false,
		Tooltip = "Automatically upgrades your treadmill tier when money is sufficient",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoUpgradeTreadmill = isEnabled
			Hub.Progression.Wake()
		end,
	})

	progressionGroup:AddToggle("Toggle_Prog_AutoClaimMoney", {
		Text = "Auto Claim Money",
		Default = false,
		Tooltip = "Automatically claims pending offline earnings",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoClaimMoney = isEnabled
			Hub.Progression.ResetMoneyClaimTimer()
		end,
	})

	progressionGroup:AddToggle("Toggle_Prog_AutoClaimIndex", {
		Text = "Auto Claim Index",
		Default = false,
		Tooltip = "Automatically claims unlocked Index rewards and Codex completion gears",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoClaimIndex = isEnabled
			Hub.Progression.ResetIndexTimer()
		end,
	})

	progressionGroup:AddToggle("Toggle_Prog_AutoTreadmill", {
		Text = "Auto Treadmill",
		Default = false,
		Tooltip = "Automatically mounts and stays on your treadmill when idle",
		Callback = function(isEnabled)
			FarmConfig.Progression_AutoTreadmill = isEnabled
			Hub.Treadmill.Restart()
		end,
	})
end

function Hub.Features.BuildAutoPlaceEgg(placeGroup)
	placeGroup:AddDropdown("Dropdown_Place_Rule", {
		Text = "Place Egg Rule",
		Values = PlaceRuleOptions,
		Default = 1,
		Callback = function(selectedRule)
			if type(selectedRule) == "string" and selectedRule ~= "" then
				FarmConfig.Place_Rule = selectedRule
				Hub.AutoPlace.Restart()
			end
		end,
	})

	placeGroup:AddDropdown("Dropdown_Place_Order", {
		Text = "Place Egg Order",
		Values = PlaceOrderOptions,
		Default = 2,
		Callback = function(selectedOrder)
			if type(selectedOrder) == "string" and selectedOrder ~= "" then
				FarmConfig.Place_Order = selectedOrder
				Hub.AutoPlace.Restart()
			end
		end,
	})

	placeGroup:AddDropdown("Dropdown_Place_Rarities", {
		Text = "Place Rarities",
		Values = RaritiesList,
		Multi = true,
		Searchable = true,
		Tooltip = "Only place eggs of the picked rarities (empty = all)",
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.Place_SelectedRarities, selectedValues)
			Hub.AutoPlace.Restart()
		end,
	})

	placeGroup:AddDropdown("Dropdown_Place_SpecificEggs", {
		Text = "Place Specific Eggs",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Only place these specific eggs (empty = all)",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Place_SelectedEggs, selectedValues)
			Hub.AutoPlace.Restart()
		end,
	})

	placeGroup:AddSlider("Slider_Place_MinValue", {
		Text = "Min Place Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Skip eggs worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Place_MinValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.AutoPlace.Restart()
		end,
	})

	placeGroup:AddToggle("Toggle_Place_AutoPlace", {
		Text = "Auto Place Egg",
		Default = false,
		Tooltip = "Automatically places matching bag eggs onto your plot pen",
		Callback = function(isEnabled)
			FarmConfig.Place_AutoPlace = isEnabled
			Hub.AutoPlace.Restart()
		end,
	})
end

function Hub.Features.BuildAutoHatchAndEquip(hatchGroup)
	hatchGroup:AddDropdown("Dropdown_Hatch_MinRarity", {
		Text = "Hatch Min Rarity",
		Values = HatchMinRarityOptions,
		Default = 1,
		Tooltip = "Hatch eggs of the chosen rarity and every rarity above it",
		Callback = function(selectedRarity)
			if type(selectedRarity) ~= "string" or selectedRarity == "" or selectedRarity == "Any" then
				FarmConfig.Hatch_MinRarityRank = 0
			else
				FarmConfig.Hatch_MinRarityRank = ToFiniteNumber(RarityRankByKey[NormalizeRarityKey(selectedRarity)], 0)
			end
			Hub.AutoHatch.Restart()
		end,
	})

	hatchGroup:AddSlider("Slider_Hatch_MinValue", {
		Text = "Min Hatch Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Skip eggs worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Hatch_MinValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.AutoHatch.Restart()
		end,
	})

	hatchGroup:AddDropdown("Dropdown_Hatch_SpecificEggs", {
		Text = "Hatch Specific Egg",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Only hatch these specific eggs (empty = all)",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Hatch_SelectedEggs, selectedValues)
			Hub.AutoHatch.Restart()
		end,
	})

	hatchGroup:AddToggle("Toggle_Hatch_AutoHatch", {
		Text = "Auto Hatch",
		Default = false,
		Tooltip = "Automatically hatches ready placed eggs matching your filters",
		Callback = function(isEnabled)
			FarmConfig.Hatch_AutoHatch = isEnabled
			Hub.AutoHatch.Restart()
		end,
	})

	hatchGroup:AddToggle("Toggle_Hatch_AutoEquip", {
		Text = "Auto Equip",
		Default = false,
		Tooltip = "Automatically equips your highest-earning pets when a better pet appears",
		Callback = function(isEnabled)
			FarmConfig.Hatch_AutoEquip = isEnabled
			Hub.AutoEquip.Restart()
		end,
	})
end

function Hub.Features.BuildAutoSell(sellGroup)
	local sellTabbox = sellGroup:AddTabbox({ Name = "Auto Sell" })
	local petsSubTab = sellTabbox:AddTab("Pets", Hub.Icons.SellPets)
	local eggsSubTab = sellTabbox:AddTab("Eggs", Hub.Icons.SellEggs)
	Hub.UI.SellTabs = {
		Pets = petsSubTab,
		Eggs = eggsSubTab,
	}

	-- Subtab 1: Pets (rbxassetid://83736894896123)
	petsSubTab:AddDropdown("Dropdown_Sell_PetRule", {
		Text = "Sell Pets Rule",
		Values = SellRuleOptions,
		Default = 1,
		Callback = function(selectedRule)
			if type(selectedRule) == "string" and selectedRule ~= "" then
				FarmConfig.Sell_PetRule = selectedRule
				Hub.AutoSell.Wake()
			end
		end,
	})

	petsSubTab:AddDropdown("Dropdown_Sell_PetRarity", {
		Text = "Pet Rarity",
		Values = RaritiesList,
		Multi = true,
		Searchable = true,
		Tooltip = "Select exact rarities to sell (e.g. Common + Mythic sells only Common and Mythic)",
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.Sell_PetRarities, selectedValues)
			Hub.AutoSell.Wake()
		end,
	})

	petsSubTab:AddSlider("Slider_Sell_PetValue", {
		Text = "Pet Sell Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Sell pets worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Sell_PetValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.AutoSell.Wake()
		end,
	})

	petsSubTab:AddDropdown("Dropdown_Sell_PetBlacklist", {
		Text = "Blacklist Sell Pets",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Never sell these selected pets",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Sell_PetBlacklist, selectedValues)
			Hub.AutoSell.Wake()
		end,
	})

	petsSubTab:AddToggle("Toggle_Sell_AutoPets", {
		Text = "Auto Sell Pets",
		Default = false,
		Tooltip = "Automatically sells matching unequipped pets in bag",
		Callback = function(isEnabled)
			FarmConfig.Sell_AutoPets = isEnabled
			Hub.AutoSell.Wake()
		end,
	})

	petsSubTab:AddToggle("Toggle_Sell_KeepMutatedPets", {
		Text = "Keep Mutated Pets",
		Default = true,
		Tooltip = "Never sell mutated pets",
		Callback = function(isEnabled)
			FarmConfig.Sell_KeepMutatedPets = isEnabled
			Hub.AutoSell.Wake()
		end,
	})

	petsSubTab:AddButton("Sell Pets Now", function()
		local sellablePets = Hub.AutoSell.CollectSellablePets()
		if #sellablePets > 0 then
			Hub.AutoSell.ExecuteNow(sellablePets, {})
		end
	end)

	-- Subtab 2: Eggs (rbxassetid://103094823152347)
	eggsSubTab:AddDropdown("Dropdown_Sell_EggRule", {
		Text = "Sell Egg Rule",
		Values = SellRuleOptions,
		Default = 1,
		Callback = function(selectedRule)
			if type(selectedRule) == "string" and selectedRule ~= "" then
				FarmConfig.Sell_EggRule = selectedRule
				Hub.AutoSell.Wake()
			end
		end,
	})

	eggsSubTab:AddDropdown("Dropdown_Sell_EggRarity", {
		Text = "Egg Rarity",
		Values = RaritiesList,
		Multi = true,
		Searchable = true,
		Tooltip = "Select exact egg rarities to sell (e.g. Common + Mythic sells only Common and Mythic)",
		Callback = function(selectedValues)
			ApplySelectionTable(FarmConfig.Sell_EggRarities, selectedValues)
			Hub.AutoSell.Wake()
		end,
	})

	eggsSubTab:AddSlider("Slider_Sell_EggValue", {
		Text = "Egg Sell Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Sell bag eggs worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Sell_EggValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.AutoSell.Wake()
		end,
	})

	eggsSubTab:AddDropdown("Dropdown_Sell_EggBlacklist", {
		Text = "Blacklist Sell Egg",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Never sell these selected eggs",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Sell_EggBlacklist, selectedValues)
			Hub.AutoSell.Wake()
		end,
	})

	eggsSubTab:AddToggle("Toggle_Sell_AutoEggs", {
		Text = "Auto Sell Egg",
		Default = false,
		Tooltip = "Automatically sells matching unplaced eggs in bag",
		Callback = function(isEnabled)
			FarmConfig.Sell_AutoEggs = isEnabled
			Hub.AutoSell.Wake()
		end,
	})

	eggsSubTab:AddToggle("Toggle_Sell_KeepMutatedEggs", {
		Text = "Keep Mutated Eggs",
		Default = true,
		Tooltip = "Never sell mutated eggs",
		Callback = function(isEnabled)
			FarmConfig.Sell_KeepMutatedEggs = isEnabled
			Hub.AutoSell.Wake()
		end,
	})

	eggsSubTab:AddButton("Sell Egg Now", function()
		local sellableEggs = Hub.AutoSell.CollectSellableEggs()
		if #sellableEggs > 0 then
			Hub.AutoSell.ExecuteNow({}, sellableEggs)
		end
	end)
end

function Hub.Features.BuildAutoMutation(mutateGroup)
	-- 1. Status: (Purple-Pink #D946EF "Status:" + Chilli live status text)
	local mutateStatusRow = Hub.Theme.CreateStatusLabel(mutateGroup, "Status", "Off")
	Hub.UI.MutateStatus = mutateStatusRow

	-- 2. Mutation To Use
	mutateGroup:AddDropdown("Dropdown_Mutate_Use", {
		Text = "Mutation To Use",
		Values = MutateConsumableLabels,
		Default = { "Fractured", "Scrambled", "Enchanted", "Nitro" },
		Multi = true,
		Tooltip = "Select which mutation consumables in your bag may be used",
		Callback = function(selectedValues)
			local nextPicked = {}
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					if rawLabel then
						local mappedId = MutateLabelToId[rawLabel] or MutateLabelToId[string.lower(rawLabel)]
						if mappedId then
							nextPicked[mappedId] = true
						end
					end
				end
			end
			FarmConfig.Mutate_Use = nextPicked
			Hub.AutoMutate.CooldownUntil = 0
		end,
	})

	-- 3. Mutation Min Rarity
	mutateGroup:AddDropdown("Dropdown_Mutate_MinRarity", {
		Text = "Mutation Min Rarity",
		Values = HatchMinRarityOptions,
		Default = 1,
		Tooltip = "Only placed eggs of this rarity and above get mutated",
		Callback = function(selectedRarity)
			if type(selectedRarity) ~= "string" or selectedRarity == "" or selectedRarity == "Any" then
				FarmConfig.Mutate_MinRarityRank = 0
			else
				FarmConfig.Mutate_MinRarityRank = ToFiniteNumber(RarityRankByKey[NormalizeRarityKey(selectedRarity)], 0)
			end
			Hub.AutoMutate.CooldownUntil = 0
		end,
	})

	-- 4. Mutation Min Value
	mutateGroup:AddSlider("Slider_Mutate_MinValue", {
		Text = "Mutation Min Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Skip placed eggs worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Mutate_MinValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.AutoMutate.CooldownUntil = 0
		end,
	})

	-- 5. Mutate Priority
	mutateGroup:AddDropdown("Dropdown_Mutate_Priority", {
		Text = "Mutate Priority",
		Values = MutatePriorityOptions,
		Default = 1,
		Tooltip = "Which placed egg gets mutated first",
		Callback = function(selectedPriority)
			if type(selectedPriority) == "string" and selectedPriority ~= "" then
				FarmConfig.Mutate_Priority = selectedPriority
				Hub.AutoMutate.CooldownUntil = 0
			end
		end,
	})

	-- 6. Auto Mutation
	mutateGroup:AddToggle("Toggle_Mutate_Auto", {
		Text = "Auto Mutation",
		Default = false,
		Tooltip = "Automatically applies selected mutation consumables to your placed eggs",
		Callback = function(isEnabled)
			FarmConfig.Mutate_Auto = isEnabled
			Hub.AutoMutate.SetAutoEnabled(isEnabled)
		end,
	})

	-- 7. Mutation Now (Button)
	mutateGroup:AddButton("Mutation Now", function()
		Hub.AutoMutate.RunOnceNow()
	end)

	Hub.Lifecycle.SpawnLoop(0.2, function()
		if Engine.Disposed then
			return
		end
		mutateStatusRow:SetValue(Hub.AutoMutate.GetDisplayStatus())
	end)
end

function Hub.Features.BuildAutoFuse(fuseGroup)
	-- 1. Status: (Purple-Pink #D946EF "Status:" + Chilli live fuse preview)
	local fuseStatusRow = Hub.Theme.CreateStatusLabel(fuseGroup, "Status", "Fuse status unknown")
	Hub.UI.FuseStatus = fuseStatusRow

	-- 2. Fuse Priority Mode
	fuseGroup:AddDropdown("Dropdown_Fuse_Priority", {
		Text = "Fuse Priority Mode",
		Values = FusePriorityOptions,
		Default = 1,
		Callback = function(selectedMode)
			if type(selectedMode) == "string" and selectedMode ~= "" then
				FarmConfig.Fuse_Priority = selectedMode
				Hub.AutoFuse.Restart()
			end
		end,
	})

	-- 3. Pets To Use
	fuseGroup:AddDropdown("Dropdown_Fuse_PetsToUse", {
		Text = "Pets To Use",
		Values = FusePetsToUseOptions,
		Default = 1,
		Callback = function(selectedOrder)
			if type(selectedOrder) == "string" and selectedOrder ~= "" then
				FarmConfig.Fuse_PetsToUse = selectedOrder
				Hub.AutoFuse.Restart()
			end
		end,
	})

	-- 4. Rarity To Fuse
	local defaultFuseRarityIdx = 1
	for idx, rarityName in ipairs(RaritiesList) do
		if NormalizeRarityKey(rarityName) == "mythic" then
			defaultFuseRarityIdx = idx
			break
		end
	end
	fuseGroup:AddDropdown("Dropdown_Fuse_Rarity", {
		Text = "Rarity To Fuse",
		Values = RaritiesList,
		Default = defaultFuseRarityIdx,
		Tooltip = "Fuse pets at or below this rarity",
		Callback = function(selectedRarity)
			if type(selectedRarity) == "string" and selectedRarity ~= "" then
				FarmConfig.Fuse_MaxRarityRank = ToFiniteNumber(
					RarityRankByKey[NormalizeRarityKey(selectedRarity)],
					FarmConfig.Fuse_MaxRarityRank
				)
				Hub.AutoFuse.Restart()
			end
		end,
	})

	-- 5. Specific Species To Fuse
	fuseGroup:AddDropdown("Dropdown_Fuse_Species", {
		Text = "Specific Species To Fuse",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Only fuse these selected species (empty = all)",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Fuse_SelectedSpecies, selectedValues)
			Hub.AutoFuse.Restart()
		end,
	})

	-- 6. Auto Fuse Machine
	fuseGroup:AddToggle("Toggle_Fuse_Auto", {
		Text = "Auto Fuse Machine",
		Default = false,
		Tooltip = "Automatically fuses 3 matching pets into an egg nonstop",
		Callback = function(isEnabled)
			FarmConfig.Fuse_Auto = isEnabled
			Hub.AutoFuse.Restart()
		end,
	})

	-- 7. Skip Mutated Pets
	fuseGroup:AddToggle("Toggle_Fuse_SkipMutated", {
		Text = "Skip Mutated Pets",
		Default = true,
		Tooltip = "Never load mutated pets into the Fuse Machine",
		Callback = function(isEnabled)
			FarmConfig.Fuse_SkipMutated = isEnabled
			Hub.AutoFuse.Restart()
		end,
	})

	-- 8. Eject Incomplete Slot
	fuseGroup:AddToggle("Toggle_Fuse_EjectIncomplete", {
		Text = "Eject Incomplete Slot",
		Default = true,
		Tooltip = "Automatically ejects loaded pets that cannot complete a trio",
		Callback = function(isEnabled)
			FarmConfig.Fuse_EjectIncomplete = isEnabled
			Hub.AutoFuse.Restart()
		end,
	})

	Hub.Lifecycle.SpawnLoop(0.25, function()
		if Engine.Disposed then
			return
		end
		fuseStatusRow:SetValue(Hub.AutoFuse.PreviewText)
	end)
end

function Hub.Features.BuildFavorite(favGroup)
	-- 1. Favorite Matches: (Purple-Pink #D946EF prefix + Chilli live counter)
	local favMatchesRow = Hub.Theme.CreateStatusLabel(favGroup, "Favorite Matches", "0 pets, 0 to mark  |  0 favorited")
	Hub.UI.FavoriteStatus = favMatchesRow

	-- 2. Favorite Rule
	favGroup:AddDropdown("Dropdown_Fav_Rule", {
		Text = "Favorite Rule",
		Values = FavoriteRuleOptions,
		Default = 2,
		Tooltip = "Pass any active check or all active checks",
		Callback = function(selectedRule)
			if type(selectedRule) == "string" and selectedRule ~= "" then
				FarmConfig.Fav_Rule = selectedRule
				Hub.Favorite.Wake(false)
			end
		end,
	})

	-- 3. Favorite Rarity
	favGroup:AddDropdown("Dropdown_Fav_Rarity", {
		Text = "Favorite Rarity",
		Values = FavoriteRarityOptions,
		Default = 1,
		Tooltip = "Favorite pets of this rarity and above (Off = skip rarity check)",
		Callback = function(selectedRarity)
			if type(selectedRarity) ~= "string" or selectedRarity == "" or selectedRarity == "Off" then
				FarmConfig.Fav_MinRarityRank = nil
			else
				FarmConfig.Fav_MinRarityRank = ToFiniteNumber(RarityRankByKey[NormalizeRarityKey(selectedRarity)], nil)
			end
			Hub.Favorite.Wake(false)
		end,
	})

	-- 4. Favorite Mutation
	favGroup:AddDropdown("Dropdown_Fav_Mutation", {
		Text = "Favorite Mutation",
		Values = FavoriteMutationOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Mutation check (empty = skip mutation check)",
		Callback = function(selectedValues)
			local nextMuts = {}
			local pickAny = false
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					if rawLabel == "Any Mutation" then
						pickAny = true
					elseif rawLabel then
						local mappedId = FavoriteMutationLabelToId[rawLabel]
							or FavoriteMutationLabelToId[string.lower(rawLabel)]
							or rawLabel
						nextMuts[mappedId] = true
						nextMuts[string.lower(tostring(mappedId))] = true
					end
				end
			end
			FarmConfig.Fav_AnyMutation = pickAny
			FarmConfig.Fav_SelectedMutations = nextMuts
			Hub.Favorite.Wake(false)
		end,
	})

	-- 5. Min Favorite Value
	favGroup:AddSlider("Slider_Fav_MinValue", {
		Text = "Min Favorite Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Minimum $/s value check (0 = skip value check)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.Fav_MinValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.Favorite.Wake(false)
		end,
	})

	-- 6. Always Favorite Species
	favGroup:AddDropdown("Dropdown_Fav_Species", {
		Text = "Always Favorite Species",
		Values = PlaceSpecificEggOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Always favorite these species regardless of other checks",
		Callback = function(selectedValues)
			ApplyCatalogSelection(FarmConfig.Fav_AlwaysSpecies, selectedValues)
			Hub.Favorite.Wake(false)
		end,
	})

	-- 7. Auto Favorite Pets
	favGroup:AddToggle("Toggle_Fav_AutoPets", {
		Text = "Auto Favorite Pets",
		Default = false,
		Tooltip = "Automatically favorites pets matching the rules above",
		Callback = function(isEnabled)
			FarmConfig.Fav_AutoPets = isEnabled
			Hub.Favorite.Wake(true)
		end,
	})

	-- 8. Auto Favorite Equipped
	favGroup:AddToggle("Toggle_Fav_AutoEquipped", {
		Text = "Auto Favorite Equipped",
		Default = false,
		Tooltip = "Automatically keeps all equipped pets favorited",
		Callback = function(isEnabled)
			FarmConfig.Fav_AutoEquipped = isEnabled
			Hub.Favorite.Wake(false)
		end,
	})

	-- 9. Auto Unfavorite Equipped
	favGroup:AddToggle("Toggle_Fav_AutoUnfavEquipped", {
		Text = "Auto Unfavorite Equipped",
		Default = false,
		Tooltip = "Automatically unfavorites equipped pets not matching your Favorite rules",
		Callback = function(isEnabled)
			FarmConfig.Fav_AutoUnfavEquipped = isEnabled
			Hub.Favorite.Wake(false)
		end,
	})

	-- 10. Favorite Now
	favGroup:AddButton("Favorite Now", function()
		local toMark = Hub.Favorite.ScanInventoryMatches()
		Hub.Favorite.WriteBatch(toMark, true)
	end)

	-- 11. Favorite Equipped Now
	favGroup:AddButton("Favorite Equipped Now", function()
		local equippedToFav = Hub.Favorite.CollectEquippedTargets(nil, true, false)
		Hub.Favorite.WriteBatch(equippedToFav, true)
	end)

	-- 12. Unfavorite Equipped Now
	favGroup:AddButton("Unfavorite Equipped Now", function()
		local equippedToUnfav = Hub.Favorite.CollectEquippedTargets(nil, false, false)
		Hub.Favorite.WriteBatch(equippedToUnfav, false)
	end)

	Hub.Lifecycle.SpawnLoop(0.25, function()
		if Engine.Disposed then
			return
		end
		favMatchesRow:SetValue(Hub.Favorite.PreviewText)
	end)
end

local function ApplyWeaponSelection(targetMap, selectedValues)
	table.clear(targetMap)
	if type(selectedValues) == "table" then
		for keyOrIdx, valOrBool in pairs(selectedValues) do
			local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
				or (type(valOrBool) == "string" and valOrBool)
				or nil
			if rawLabel and rawLabel ~= "No Weapons" then
				local gearId = WeaponLabelToGearId[rawLabel]
					or WeaponLabelToGearId[string.lower(rawLabel)]
					or rawLabel
				targetMap[gearId] = true
				targetMap[string.lower(tostring(gearId))] = true
			end
		end
	end
end

function Hub.Features.BuildPumpkinBoss(bossGroup)
	local initialWeapons = Hub.HalloweenMonsters.CollectOwnedWeapons()
	local weaponChoices = (#initialWeapons > 0) and initialWeapons or (#WeaponDisplayList > 0 and WeaponDisplayList or { "No Weapons" })

	-- 1. Status:
	local bossStatusRow = Hub.Theme.CreateStatusLabel(bossGroup, "Status", "Off")
	Hub.UI.PumpkinBossStatus = bossStatusRow

	-- 2. Use Weapon
	local bossWeaponDropdown = bossGroup:AddDropdown("Dropdown_PumpkinBoss_Weapons", {
		Text = "Use Weapon",
		Values = weaponChoices,
		Multi = true,
		Searchable = true,
		Tooltip = "Select weapons to use against the Pumpkin Boss",
		Callback = function(selectedValues)
			ApplyWeaponSelection(FarmConfig.PumpkinBoss_Weapons, selectedValues)
		end,
	})

	-- 3. Stubs Pickup Speed
	bossGroup:AddSlider("Slider_PumpkinBoss_PickupSpeed", {
		Text = "Stubs Pickup Speed",
		Min = 100,
		Max = 1000,
		Default = 300,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.PumpkinBoss_PickupSpeed = math.clamp(ToFiniteNumber(sliderVal, 300), 100, 1000)
		end,
	})

	-- 4. Auto Pumpkin Boss
	bossGroup:AddToggle("Toggle_PumpkinBoss_Auto", {
		Text = "Auto Pumpkin Boss",
		Default = false,
		Callback = function(isEnabled)
			FarmConfig.PumpkinBoss_Auto = isEnabled
			bossStatusRow:SetValue(Hub.PumpkinBoss.RefreshStatus())
		end,
	})

	-- 5. Auto Dodge Attack
	bossGroup:AddToggle("Toggle_PumpkinBoss_AutoDodge", {
		Text = "Auto Dodge Attack",
		Default = true,
		Callback = function(isEnabled)
			FarmConfig.PumpkinBoss_AutoDodge = isEnabled
		end,
	})

	-- 6. Auto Claim Boss Mastery
	bossGroup:AddToggle("Toggle_PumpkinBoss_AutoMastery", {
		Text = "Auto Claim Boss Mastery",
		Default = false,
		Callback = function(isEnabled)
			FarmConfig.PumpkinBoss_AutoMastery = isEnabled
			bossStatusRow:SetValue(Hub.PumpkinBoss.RefreshStatus())
		end,
	})

	-- 7. Auto Manor Key
	bossGroup:AddToggle("Toggle_PumpkinBoss_AutoManorKey", {
		Text = "Auto Manor Key",
		Default = false,
		Callback = function(isEnabled)
			FarmConfig.PumpkinBoss_AutoManorKey = isEnabled
			bossStatusRow:SetValue(Hub.PumpkinBoss.RefreshStatus())
		end,
	})

	Hub.UI.BossWeaponDropdown = bossWeaponDropdown
end

function Hub.Features.BuildHalloweenMonsters(monsterGroup)
	local initialWeapons = Hub.HalloweenMonsters.CollectOwnedWeapons()
	local weaponChoices = (#initialWeapons > 0) and initialWeapons or (#WeaponDisplayList > 0 and WeaponDisplayList or { "No Weapons" })

	-- 1. Target Monster
	monsterGroup:AddDropdown("Dropdown_Monster_Target", {
		Text = "Target Monster",
		Values = MonsterTargetOptions,
		Multi = true,
		Searchable = true,
		Tooltip = "Select Halloween monsters to farm (empty = all)",
		Callback = function(selectedValues)
			table.clear(FarmConfig.Monster_Targets)
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					if rawLabel then
						local cleanName = string.match(rawLabel, "^(.-) %(") or rawLabel
						FarmConfig.Monster_Targets[string.lower(cleanName)] = true
					end
				end
			end
		end,
	})

	-- 2. Monster Order
	monsterGroup:AddDropdown("Dropdown_Monster_Order", {
		Text = "Monster Order",
		Values = MonsterOrderOptions,
		Default = 1,
		Callback = function(selectedOrder)
			if type(selectedOrder) == "string" and selectedOrder ~= "" then
				FarmConfig.Monster_Order = selectedOrder
			end
		end,
	})

	-- 3. Walk Speed
	monsterGroup:AddSlider("Slider_Monster_WalkSpeed", {
		Text = "Walk Speed",
		Min = 100,
		Max = 1000,
		Default = 300,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.Monster_WalkSpeed = math.clamp(ToFiniteNumber(sliderVal, 300), 100, 1000)
		end,
	})

	-- 4. Use Weapon
	local monsterWeaponDropdown = monsterGroup:AddDropdown("Dropdown_Monster_Weapons", {
		Text = "Use Weapon",
		Values = weaponChoices,
		Multi = true,
		Searchable = true,
		Tooltip = "Select owned bat/slap weapons to fight monsters",
		Callback = function(selectedValues)
			ApplyWeaponSelection(FarmConfig.Monster_Weapons, selectedValues)
		end,
	})

	-- 5. Auto Kill Monster
	monsterGroup:AddToggle("Toggle_Monster_AutoKill", {
		Text = "Auto Kill Monster",
		Default = false,
		Tooltip = "Automatically enters Halloween Dimension and fights matching monsters",
		Callback = function(isEnabled)
			FarmConfig.Monster_AutoKill = isEnabled
			Hub.HalloweenMonsters.SetAutoEnabled(isEnabled)
		end,
	})

	-- 6. Teleport To Monster
	monsterGroup:AddToggle("Toggle_Monster_Teleport", {
		Text = "Teleport To Monster",
		Default = false,
		Tooltip = "Instantly snaps directly beside each target monster instead of walking",
		Callback = function(isEnabled)
			FarmConfig.Monster_Teleport = isEnabled
		end,
	})

	-- 7. Only During Blood Moon
	monsterGroup:AddToggle("Toggle_Monster_OnlyBloodMoon", {
		Text = "Only During Blood Moon",
		Default = false,
		Tooltip = "Only farms Halloween monsters while Blood Moon is active",
		Callback = function(isEnabled)
			FarmConfig.Monster_OnlyBloodMoon = isEnabled
		end,
	})

	-- 8. Farm All Monster In Blood Moon
	monsterGroup:AddToggle("Toggle_Monster_AllInBloodMoon", {
		Text = "Farm All Monster In Blood Moon",
		Default = false,
		Tooltip = "Ignores Target Monster filter and farms every monster during Blood Moon",
		Callback = function(isEnabled)
			FarmConfig.Monster_AllInBloodMoon = isEnabled
		end,
	})

	-- Sync owned weapons dynamically into both Event Use Weapon dropdowns
	Hub.Lifecycle.SpawnLoop(5.0, function()
		if Engine.Disposed then
			return
		end
		local ownedNow = Hub.HalloweenMonsters.CollectOwnedWeapons()
		if #ownedNow == 0 then
			return
		end
		local sigNow = table.concat(ownedNow, "|")
		if sigNow == Hub.HalloweenMonsters.OwnedWeaponKey then
			return
		end
		Hub.HalloweenMonsters.OwnedWeaponLabels = ownedNow
		Hub.HalloweenMonsters.OwnedWeaponKey = sigNow
		if monsterWeaponDropdown and monsterWeaponDropdown.SetValues then
			pcall(monsterWeaponDropdown.SetValues, monsterWeaponDropdown, ownedNow)
		end
		if Hub.UI.BossWeaponDropdown and Hub.UI.BossWeaponDropdown.SetValues then
			pcall(Hub.UI.BossWeaponDropdown.SetValues, Hub.UI.BossWeaponDropdown, ownedNow)
		end
	end)
end

function Hub.Features.BuildGhostDogFishing(fishingGroup)
	-- 1. Status: (Purple-Pink #D946EF "Status:" + Chilli live quest/fishing status)
	local fishingStatusRow = Hub.Theme.CreateStatusLabel(fishingGroup, "Status", "Off")
	Hub.UI.FishingStatus = fishingStatusRow

	-- 2. Cast Luck
	fishingGroup:AddDropdown("Dropdown_Fishing_CastLuck", {
		Text = "Cast Luck",
		Values = CastLuckOptions,
		Default = 1,
		Tooltip = "Select cast charge accuracy & luck multiplier",
		Callback = function(selectedLuck)
			if type(selectedLuck) == "string" and selectedLuck ~= "" then
				FarmConfig.Fishing_CastLuck = selectedLuck
				FarmConfig.Fishing_CastCharge = CastLuckChargeMap[selectedLuck] or 0.875
			end
		end,
	})

	-- 3. Fishing Spot
	local fishingSpotDropdown = fishingGroup:AddDropdown("Dropdown_Fishing_Spot", {
		Text = "Fishing Spot",
		Values = FishingSpotOptions,
		Default = 1,
		Tooltip = "Choose which pond or saved position to fish at",
		Callback = function(selectedSpot)
			if type(selectedSpot) == "string" and selectedSpot ~= "" then
				FarmConfig.Fishing_Spot = selectedSpot
			end
		end,
	})

	-- 4. Auto Ghost Dog Quest
	fishingGroup:AddToggle("Toggle_Fishing_AutoQuest", {
		Text = "Auto Ghost Dog Quest",
		Default = false,
		Tooltip = "Automatically completes all 4 stages of Echo's Ghost Dog Quest",
		Callback = function(isEnabled)
			FarmConfig.Fishing_AutoQuest = isEnabled
			Hub.GhostDogFishing.Restart()
		end,
	})

	-- 5. Auto Fishing
	fishingGroup:AddToggle("Toggle_Fishing_AutoFish", {
		Text = "Auto Fishing",
		Default = false,
		Tooltip = "Automatically casts, reels, and catches fish/keys at your selected spot",
		Callback = function(isEnabled)
			FarmConfig.Fishing_AutoFish = isEnabled
			Hub.GhostDogFishing.Restart()
		end,
	})

	-- 6. Farm Monster While Fishing
	fishingGroup:AddToggle("Toggle_Fishing_FarmMonsters", {
		Text = "Farm Monster While Fishing",
		Default = false,
		Tooltip = "Clears nearby Halloween monsters between casts and returns to your fishing spot",
		Callback = function(isEnabled)
			FarmConfig.Fishing_FarmMonsters = isEnabled
		end,
	})

	-- 7. Save Spot Here
	fishingGroup:AddButton("Save Spot Here", function()
		if Hub.GhostDogFishing.SaveCurrentSpot() then
			if fishingSpotDropdown and fishingSpotDropdown.SetValue then
				pcall(fishingSpotDropdown.SetValue, fishingSpotDropdown, "Saved Spot")
			end
			fishingStatusRow:SetValue(Hub.GhostDogFishing.Status)
		end
	end)

	Hub.Lifecycle.SpawnLoop(0.25, function()
		if Engine.Disposed then
			return
		end
		if FarmConfig.Fishing_AutoQuest or FarmConfig.Fishing_AutoFish then
			fishingStatusRow:SetValue(Hub.GhostDogFishing.GetDisplayStatus())
		elseif Hub.GhostDogFishing.Status == "Off" then
			fishingStatusRow:SetValue("Off")
		end
	end)
end

Hub.TheHollow = {
	Active = false,
}

function Hub.Features.BuildTheHollow(hollowGroup)
	-- 1. Auto Race The Hollow
	hollowGroup:AddToggle("Toggle_Hollow_AutoRace", {
		Text = "Auto Race The Hollow",
		Default = false,
		Tooltip = "Placeholder ready for The Hollow race controller",
		Callback = function(isEnabled)
			FarmConfig.Hollow_AutoRace = isEnabled
			Hub.TheHollow.Active = isEnabled
		end,
	})

	-- 2. Hollow Race Speed
	hollowGroup:AddSlider("Slider_Hollow_RaceSpeed", {
		Text = "Hollow Race Speed",
		Min = 100,
		Max = 1000,
		Default = 300,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.Hollow_RaceSpeed = math.clamp(ToFiniteNumber(sliderVal, 300), 100, 1000)
		end,
	})

	-- 3. Auto Race Power Up
	hollowGroup:AddToggle("Toggle_Hollow_AutoPowerUp", {
		Text = "Auto Race Power Up",
		Default = false,
		Tooltip = "Placeholder ready for The Hollow power-up collector/user",
		Callback = function(isEnabled)
			FarmConfig.Hollow_AutoPowerUp = isEnabled
		end,
	})
end

function Hub.Features.BuildCursedIsland(islandGroup)
	islandGroup:AddDropdown("Dropdown_IslandWars_Target", {
		Text = "Island Wars Target",
		Values = { "Enemies And Base", "Walls And Crystal" },
		Default = "Enemies And Base",
		Tooltip = "Hits enemy players first, or goes straight for the walls and crystal",
		Callback = function(selectedTarget)
			if type(selectedTarget) == "string" and selectedTarget ~= "" then
				FarmConfig.IslandWars_Target = selectedTarget
			end
		end,
	})

	islandGroup:AddToggle("Toggle_IslandWars_Auto", {
		Text = "Auto Play Curset Island Wars",
		Default = false,
		Tooltip = "Swings the Bat at nearby enemies and fires the Pumpkin Launcher at enemies, walls and crystals",
		Callback = function(isEnabled)
			FarmConfig.IslandWars_Auto = isEnabled
			Hub.IslandWars.Wake()
		end,
	})
end

local PhantomGhostTargets = { "Rarest First", "Closest" }
local ButterflyCatchMethods = { "Stand", "Chase", "Circle", "Patrol" }
local ButterflyCatchPriorities = { "Rarest", "Nearest" }
local ButterflyTierOptions = { "Emerald", "Sapphire", "Amethyst", "Radiant" }
local ButterflyLabelToTier = {
	Emerald = "Green",
	Sapphire = "Blue",
	Amethyst = "Purple",
	Radiant = "Golden",
	Green = "Green",
	Blue = "Blue",
	Purple = "Purple",
	Golden = "Golden",
}
local TradeUpTierOptions = {
	"Emerald -> Sapphire",
	"Sapphire -> Amethyst",
	"Amethyst -> Radiant",
}
local TradeUpLabelToTier = {
	["Emerald -> Sapphire"] = "Green",
	["Sapphire -> Amethyst"] = "Blue",
	["Amethyst -> Radiant"] = "Purple",
}

function Hub.Features.BuildPhantomExpress(phantomGroup)
	-- 1. Ghost Target
	phantomGroup:AddDropdown("Dropdown_Phantom_GhostTarget", {
		Text = "Ghost Target",
		Values = PhantomGhostTargets,
		Default = 1,
		Callback = function(selectedTarget)
			if type(selectedTarget) == "string" and selectedTarget ~= "" then
				FarmConfig.Phantom_GhostTarget = selectedTarget
			end
		end,
	})

	-- 2. Walk Speed
	phantomGroup:AddSlider("Slider_Phantom_WalkSpeed", {
		Text = "Walk Speed",
		Min = 100,
		Max = 1000,
		Default = 300,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.Phantom_WalkSpeed = math.clamp(ToFiniteNumber(sliderVal, 300), 100, 1000)
		end,
	})

	-- 3. Auto Phantom Express
	phantomGroup:AddToggle("Toggle_Phantom_AutoRide", {
		Text = "Auto Phantom Express",
		Default = false,
		Tooltip = "Automatically boards the Phantom Express and vacuums ghosts in Forgotten Town",
		Callback = function(isEnabled)
			FarmConfig.Phantom_AutoRide = isEnabled
			Hub.PhantomExpress.Restart()
		end,
	})

	-- 4. Auto Vacuum Ghouler Boss
	phantomGroup:AddToggle("Toggle_Phantom_VacuumBoss", {
		Text = "Auto Vacuum Ghouler Boss",
		Default = true,
		Tooltip = "Automatically vacuums the Ghouler Boss when active in Town or Overworld",
		Callback = function(isEnabled)
			FarmConfig.Phantom_VacuumBoss = isEnabled
			Hub.PhantomExpress.Restart()
		end,
	})

	-- 5. Teleport To Ghost
	phantomGroup:AddToggle("Toggle_Phantom_TeleportGhost", {
		Text = "Teleport To Ghost",
		Default = false,
		Tooltip = "Snaps directly around each ghost instead of walking",
		Callback = function(isEnabled)
			FarmConfig.Phantom_TeleportGhost = isEnabled
		end,
	})

	-- 6. Auto Trade Souls
	phantomGroup:AddToggle("Toggle_Phantom_TradeSouls", {
		Text = "Auto Trade Souls",
		Default = false,
		Tooltip = "Automatically trades collected Souls at the Forgotten Town Soul Shop",
		Callback = function(isEnabled)
			FarmConfig.Phantom_TradeSouls = isEnabled
			Hub.PhantomExpress.Restart()
		end,
	})
end

function Hub.Features.BuildAutoButterfly(butterflyGroup)
	-- 1. Status: (Purple-Pink #D946EF "Status:" + live status)
	local bfStatusRow = Hub.Theme.CreateStatusLabel(butterflyGroup, "Status", "Off")
	Hub.UI.ButterflyStatus = bfStatusRow

	-- 2. Catch Method
	butterflyGroup:AddDropdown("Dropdown_Butterfly_Method", {
		Text = "Catch Method",
		Values = ButterflyCatchMethods,
		Default = 1,
		Callback = function(selectedMethod)
			if type(selectedMethod) == "string" and selectedMethod ~= "" then
				FarmConfig.Butterfly_Mode = selectedMethod
			end
		end,
	})

	-- 3. Catch Priority
	butterflyGroup:AddDropdown("Dropdown_Butterfly_Priority", {
		Text = "Catch Priority",
		Values = ButterflyCatchPriorities,
		Default = 1,
		Tooltip = "Used during Chase mode",
		Callback = function(selectedPriority)
			if type(selectedPriority) == "string" and selectedPriority ~= "" then
				FarmConfig.Butterfly_Priority = selectedPriority
			end
		end,
	})

	-- 4. Catch Butterflies
	butterflyGroup:AddDropdown("Dropdown_Butterfly_Tiers", {
		Text = "Catch Butterflies",
		Values = ButterflyTierOptions,
		Default = { "Emerald", "Sapphire", "Amethyst", "Radiant" },
		Multi = true,
		Callback = function(selectedValues)
			local pickedTiers = {}
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					local tierId = rawLabel and ButterflyLabelToTier[rawLabel] or nil
					if tierId then
						pickedTiers[tierId] = true
					end
				end
			end
			FarmConfig.Butterfly_Tiers = pickedTiers
		end,
	})

	-- 5. Tween Speed
	butterflyGroup:AddSlider("Slider_Butterfly_Speed", {
		Text = "Tween Speed",
		Min = 100,
		Max = 600,
		Default = 320,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.Butterfly_Speed = math.clamp(ToFiniteNumber(sliderVal, 320), 100, 600)
		end,
	})

	-- 6. Auto Butterfly Bloom
	butterflyGroup:AddToggle("Toggle_Butterfly_Auto", {
		Text = "Auto Butterfly Bloom",
		Default = false,
		Tooltip = "Automatically claims Butterfly Net and catches butterflies during Bloom",
		Callback = function(isEnabled)
			FarmConfig.Butterfly_Auto = isEnabled
			Hub.AutoButterfly.Restart()
		end,
	})

	-- 7. Auto Trade Up
	butterflyGroup:AddToggle("Toggle_Butterfly_Trade", {
		Text = "Auto Trade Up",
		Default = false,
		Tooltip = "Automatically trades lower-tier butterflies up inside Enchanted Tree",
		Callback = function(isEnabled)
			FarmConfig.Butterfly_Trade = isEnabled
			Hub.AutoButterfly.Restart()
		end,
	})

	-- 8. Trade Up Tier
	butterflyGroup:AddDropdown("Dropdown_Butterfly_TradeTiers", {
		Text = "Trade Up Tier",
		Values = TradeUpTierOptions,
		Multi = true,
		Callback = function(selectedValues)
			local picked = {}
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					local tierId = rawLabel and TradeUpLabelToTier[rawLabel] or nil
					if tierId then
						picked[tierId] = true
					end
				end
			end
			FarmConfig.Butterfly_TradeTiers = picked
			Hub.AutoButterfly.Restart()
		end,
	})

	-- 9. Smart Trade For Essence
	butterflyGroup:AddToggle("Toggle_Butterfly_Smart", {
		Text = "Smart Trade For Essence",
		Default = false,
		Tooltip = "Reserves full Essence recipes before planning optimal butterfly trades",
		Callback = function(isEnabled)
			FarmConfig.Butterfly_Smart = isEnabled
			Hub.AutoButterfly.Restart()
		end,
	})

	-- 10. Auto Craft Essence
	butterflyGroup:AddToggle("Toggle_Butterfly_Craft", {
		Text = "Auto Craft Essence",
		Default = false,
		Tooltip = "Automatically crafts Enchanted Essence at the Mutation Shrine",
		Callback = function(isEnabled)
			FarmConfig.Butterfly_Craft = isEnabled
			Hub.AutoButterfly.Restart()
		end,
	})

	-- 11. Auto Wisp
	butterflyGroup:AddToggle("Toggle_Wisp_Auto", {
		Text = "Auto Wisp",
		Default = false,
		Tooltip = "Automatically accepts, claims, and completes Wisp Companion stages",
		Callback = function(isEnabled)
			FarmConfig.Wisp_Auto = isEnabled
			Hub.WispBanjo.Restart()
		end,
	})

	-- 12. Auto Banjo Cricket
	butterflyGroup:AddToggle("Toggle_Banjo_Auto", {
		Text = "Auto Banjo Cricket",
		Default = false,
		Tooltip = "Automatically solves the 5-stage mushroom note puzzle and claims Cricket's Banjo",
		Callback = function(isEnabled)
			FarmConfig.Banjo_Auto = isEnabled
			Hub.WispBanjo.Restart()
		end,
	})

	Hub.Lifecycle.SpawnLoop(0.25, function()
		if Engine.Disposed then
			return
		end
		if FarmConfig.Butterfly_Auto or FarmConfig.Butterfly_Trade or FarmConfig.Butterfly_Craft then
			bfStatusRow:SetValue(Hub.AutoButterfly.Status)
		elseif FarmConfig.Wisp_Auto or FarmConfig.Banjo_Auto then
			bfStatusRow:SetValue(Hub.WispBanjo.Status)
		else
			bfStatusRow:SetValue("Off")
		end
	end)
end

function Hub.Features.BuildShootingStar(starGroup)
	-- 1. Status: (Purple-Pink #D946EF "Status:" + Chilli live star status)
	local starStatusRow = Hub.Theme.CreateStatusLabel(starGroup, "Status", "Off")
	Hub.UI.ShootingStarStatus = starStatusRow

	-- 2. Auto Catch Shooting Star
	starGroup:AddToggle("Toggle_Star_Auto", {
		Text = "Auto Catch Shooting Star",
		Default = false,
		Tooltip = "Automatically tracks, holds, and catches falling Shooting Stars",
		Callback = function(isEnabled)
			FarmConfig.Star_Auto = isEnabled
			Hub.ShootingStar.Restart()
		end,
	})

	Hub.Lifecycle.SpawnLoop(0.25, function()
		if Engine.Disposed then
			return
		end
		starStatusRow:SetValue(Hub.ShootingStar.Status)
	end)
end

function Hub.Features.BuildCaptureTheEgg(captureGroup)
	captureGroup:AddToggle("Toggle_Admin_CaptureEvent", {
		Text = "Auto Capture Event",
		Default = false,
		Tooltip = "Automatically grabs the Capture The Egg event egg and holds it above the field",
		Callback = function(isEnabled)
			FarmConfig.Admin_Capture = isEnabled
			Hub.Admin.Wake()
		end,
	})

	captureGroup:AddToggle("Toggle_Admin_CaptureTake", {
		Text = "Take It From The Holder",
		Default = true,
		Tooltip = "Follows the player holding the event egg until the egg becomes available",
		Callback = function(isEnabled)
			FarmConfig.Admin_CaptureTake = isEnabled
		end,
	})

	captureGroup:AddSlider("Slider_Admin_CaptureHeight", {
		Text = "Hold height",
		Min = 20,
		Max = 120,
		Default = 45,
		Rounding = 0,
		Suffix = " studs",
		Callback = function(sliderVal)
			FarmConfig.Admin_CaptureHeight = math.clamp(ToFiniteNumber(sliderVal, 45), 20, 120)
		end,
	})

	captureGroup:AddSlider("Slider_Admin_CaptureKeepAway", {
		Text = "Keep Away Distance",
		Min = 20,
		Max = 150,
		Default = 45,
		Rounding = 0,
		Suffix = " studs",
		Callback = function(sliderVal)
			FarmConfig.Admin_CaptureKeepAway = math.clamp(ToFiniteNumber(sliderVal, 45), 20, 150)
		end,
	})
end

function Hub.Features.BuildAdminTreadmill(treadmillGroup)
	treadmillGroup:AddToggle("Toggle_Admin_AutoTreadmill", {
		Text = "Auto Admin Treadmill",
		Default = false,
		Tooltip = "Rides the Admin Treadmill whenever the server spawns it",
		Callback = function(isEnabled)
			FarmConfig.Admin_AutoTreadmill = isEnabled
			Hub.Admin.Wake()
		end,
	})
end

function Hub.Features.BuildInstantSteal(instantGroup)
	instantGroup:AddToggle("Toggle_Admin_InstantSteal", {
		Text = "Use Instan Steal Abuse",
		Default = false,
		Tooltip = "Teleports to the closest field egg, takes it and drops it inside the base",
		Callback = function(isEnabled)
			FarmConfig.Admin_InstantSteal = isEnabled
			Hub.Admin.Wake()
		end,
	})
end

function Hub.Features.BuildMinigameEggs(minigameGroup)
	minigameGroup:AddToggle("Toggle_Admin_MinigameEggs", {
		Text = "Auto Steal Minigame Eggs",
		Default = false,
		Tooltip = "Takes the Red Light Green Light and T-Rex Run eggs",
		Callback = function(isEnabled)
			FarmConfig.Admin_MinigameEggs = isEnabled
			Hub.Admin.Wake()
		end,
	})
end

local EspShowInfoOptions = {
	"Icon",
	"Name",
	"Rarity",
	"Mutation",
	"Value",
	"Weight",
	"Size",
	"Sell Price",
	"Distance",
	"Area",
	"State",
}
local EspPlayerInfoOptions = {
	"Name",
	"Username",
	"Avatar",
	"Tool",
}

function Hub.Features.BuildPlayerESP(espGroup)
	-- 1. ESP Rarity
	espGroup:AddDropdown("Dropdown_ESP_Rarity", {
		Text = "ESP Rarity",
		Values = HatchMinRarityOptions,
		Default = 1,
		Tooltip = "Show eggs of the chosen rarity and every rarity above it",
		Callback = function(selectedRarity)
			if type(selectedRarity) ~= "string" or selectedRarity == "" or selectedRarity == "Any" then
				FarmConfig.ESP_MinRarityRank = 0
			Hub.ESP.MarkDirty(false)
			else
				FarmConfig.ESP_MinRarityRank = ToFiniteNumber(RarityRankByKey[NormalizeRarityKey(selectedRarity)], 0)
			Hub.ESP.MarkDirty(false)
			end
		end,
	})

	-- 2. ESP Show Info
	espGroup:AddDropdown("Dropdown_ESP_ShowInfo", {
		Text = "ESP Show Info",
		Values = EspShowInfoOptions,
		Default = { "Icon", "Name", "Value" },
		Multi = true,
		Callback = function(selectedValues)
			local nextFlags = {}
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					if rawLabel then
						nextFlags[rawLabel] = true
					end
				end
			end
			FarmConfig.ESP_ShowInfo = nextFlags
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 3. Min ESP Value
	espGroup:AddSlider("Slider_ESP_MinValue", {
		Text = "Min ESP Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		Rounding = 0,
		Suffix = "M/s",
		Tooltip = "Skip eggs worth less than this (0 = off)",
		Callback = function(sliderVal)
			local numericVal = ToFiniteNumber(sliderVal, 0)
			FarmConfig.ESP_MinValue = (numericVal > 0) and (numericVal * 1000000) or 0
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 4. ESP Egg Size
	espGroup:AddSlider("Slider_ESP_EggSize", {
		Text = "ESP Egg Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Rounding = 0,
		Suffix = "%",
		Callback = function(sliderVal)
			FarmConfig.ESP_EggSize = math.clamp(ToFiniteNumber(sliderVal, 75), 50, 200)
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 5. Inventory Value
	espGroup:AddToggle("Toggle_ESP_InventoryValue", {
		Text = "Inventory Value",
		Default = false,
		Tooltip = "Displays total $/s value banners above player bases",
		Callback = function(isEnabled)
			FarmConfig.ESP_InventoryValue = isEnabled
			Hub.ESP.MarkDirty(true)
		end,
	})

	-- 6. ESP Eggs
	espGroup:AddToggle("Toggle_ESP_Eggs", {
		Text = "ESP Eggs",
		Default = false,
		Tooltip = "Highlights and displays live info cards over matching eggs",
		Callback = function(isEnabled)
			FarmConfig.ESP_Eggs = isEnabled
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 7. ESP Fixed Size
	espGroup:AddToggle("Toggle_ESP_FixedSize", {
		Text = "ESP Fixed Size",
		Default = false,
		Tooltip = "Scales Egg ESP billboards in 3D world studs instead of constant screen pixels",
		Callback = function(isEnabled)
			FarmConfig.ESP_FixedSize = isEnabled
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 8. ESP Own Base Eggs
	espGroup:AddToggle("Toggle_ESP_OwnBase", {
		Text = "ESP Own Base Eggs",
		Default = true,
		Tooltip = "Also show eggs placed on your own base",
		Callback = function(isEnabled)
			FarmConfig.ESP_OwnBaseEggs = isEnabled
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 9. ESP Other Base Eggs
	espGroup:AddToggle("Toggle_ESP_OtherBase", {
		Text = "ESP Other Base Eggs",
		Default = false,
		Tooltip = "Also show eggs placed on other players' bases",
		Callback = function(isEnabled)
			FarmConfig.ESP_OtherBaseEggs = isEnabled
			Hub.ESP.MarkDirty(false)
		end,
	})

	-- 10. ESP Guard
	espGroup:AddToggle("Toggle_ESP_Guards", {
		Text = "ESP Guard",
		Default = false,
		Tooltip = "Highlights Zone Guards and displays their live Sleeping/Waking/Chasing state",
		Callback = function(isEnabled)
			FarmConfig.ESP_Guards = isEnabled
		end,
	})

	-- 11. ESP Guard Size
	espGroup:AddSlider("Slider_ESP_GuardSize", {
		Text = "ESP Guard Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Rounding = 0,
		Suffix = "%",
		Callback = function(sliderVal)
			FarmConfig.ESP_GuardSize = math.clamp(ToFiniteNumber(sliderVal, 75), 50, 200)
		end,
	})

	-- 12. ESP Player
	espGroup:AddToggle("Toggle_ESP_Players", {
		Text = "ESP Player",
		Default = false,
		Tooltip = "Highlights other players and displays their name, avatar & equipped tool",
		Callback = function(isEnabled)
			FarmConfig.ESP_Players = isEnabled
		end,
	})

	-- 13. ESP Player Info
	espGroup:AddDropdown("Dropdown_ESP_PlayerInfo", {
		Text = "ESP Player Info",
		Values = EspPlayerInfoOptions,
		Default = { "Name", "Tool" },
		Multi = true,
		Callback = function(selectedValues)
			local nextInfo = { Name = false, Username = false, Avatar = false, Tool = false }
			if type(selectedValues) == "table" then
				for keyOrIdx, valOrBool in pairs(selectedValues) do
					local rawLabel = (valOrBool == true and type(keyOrIdx) == "string" and keyOrIdx)
						or (type(valOrBool) == "string" and valOrBool)
						or nil
					if rawLabel and nextInfo[rawLabel] ~= nil then
						nextInfo[rawLabel] = true
					end
				end
			end
			FarmConfig.ESP_PlayerInfo = nextInfo
		end,
	})

	-- 14. ESP Player Size
	espGroup:AddSlider("Slider_ESP_PlayerSize", {
		Text = "ESP Player Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Rounding = 0,
		Suffix = "%",
		Callback = function(sliderVal)
			FarmConfig.ESP_PlayerSize = math.clamp(ToFiniteNumber(sliderVal, 75), 50, 200)
		end,
	})
end

function Hub.Features.BuildPlayerMovement(moveGroup)
	-- 1. Boost Speed
	moveGroup:AddSlider("Slider_Move_BoostSpeed", {
		Text = "Boost Speed",
		Min = 20,
		Max = 1000,
		Default = 350,
		Rounding = 0,
		Suffix = " st/s",
		Callback = function(sliderVal)
			FarmConfig.Move_BoostSpeed = math.clamp(ToFiniteNumber(sliderVal, 350), 20, 1000)
		end,
	})

	-- 2. Speed Boost
	moveGroup:AddToggle("Toggle_Move_SpeedBoost", {
		Text = "Speed Boost",
		Default = false,
		Tooltip = "Boosts your manual movement speed smoothly along MoveDirection",
		Callback = function(isEnabled)
			FarmConfig.Move_SpeedBoost = isEnabled
		end,
	})

	-- 3. Infinite Jump
	moveGroup:AddToggle("Toggle_Move_InfiniteJump", {
		Text = "Infinite Jump",
		Default = false,
		Tooltip = "Allows jumping repeatedly in midair",
		Callback = function(isEnabled)
			FarmConfig.Move_InfiniteJump = isEnabled
			Hub.PlayerModifiers.SetInfiniteJump(isEnabled)
		end,
	})
end

function Hub.Features.BuildPlayerCharacter(charGroup)
	-- 1. Anti Ragdoll
	charGroup:AddToggle("Toggle_Char_AntiRagdoll", {
		Text = "Anti Ragdoll",
		Default = true,
		Tooltip = "Prevents guards and player bats from ragdolling your character",
		Callback = function(isEnabled)
			FarmConfig.Defense_AntiRagdoll = isEnabled
		end,
	})

	-- 2. Anti Trap
	charGroup:AddToggle("Toggle_Char_AntiTrap", {
		Text = "Anti Trap",
		Default = true,
		Tooltip = "Traps placed by other players cannot catch you",
		Callback = function(isEnabled)
			FarmConfig.Char_AntiTrap = isEnabled
			Hub.PlayerModifiers.ApplyAntiTrap(isEnabled)
		end,
	})

	-- 3. Instant Prompts
	charGroup:AddToggle("Toggle_Char_InstantPrompts", {
		Text = "Instant Prompts",
		Default = true,
		Tooltip = "Removes HoldDuration delay from proximity prompts",
		Callback = function(isEnabled)
			FarmConfig.Char_InstantPrompts = isEnabled
			Hub.PlayerModifiers.ApplyInstantPrompts(isEnabled)
		end,
	})

	-- 4. Invisibility
	charGroup:AddToggle("Toggle_Char_Invisibility", {
		Text = "Invisibility",
		Default = false,
		Tooltip = "Makes your character rig invisible to other players",
		Callback = function(isEnabled)
			FarmConfig.Char_Invisibility = isEnabled
		end,
	})
end

local MainWindow = LibraryLoader:CreateWindow({
	Title = "N3 HUB",
	Footer = "N3 Hub - Steal An Egg",
	Icon = Hub.Icons.Brand,
	AutoShow = true,
})
Hub.UI.Window = MainWindow

local FarmTab = MainWindow:AddTab("Farm", Hub.Icons.Farm, "Main Farm & Lifecycle")
local PetsTab = MainWindow:AddTab("Pets", Hub.Icons.Pets, "Pets & Egg Placement")
local EventTab = MainWindow:AddTab("Event", Hub.Icons.Event, "Halloween & Special Events")
local AdminTab = MainWindow:AddTab("Admin", Hub.Icons.Admin, "Capture The Egg, Admin Treadmill, Instant Steal & Minigame Eggs")
local QuestTab = MainWindow:AddTab("Quest", Hub.Icons.Quest, "Quests, Butterfly Bloom & Shooting Star")
local PlayerTab = MainWindow:AddTab("Player", Hub.Icons.Player, "Movement, Character, Combat & Visuals")
local PredictorTab = MainWindow:AddTab("Predictor", Hub.Icons.Predictor, "Egg Predictor, Fuse Predictor & Growth Preview")
local SettingsTab = MainWindow:AddTab("Settings", Hub.Icons.Settings, "System & Configuration")
Hub.UI.Tabs.Farm = FarmTab
Hub.UI.Tabs.Pets = PetsTab
Hub.UI.Tabs.Event = EventTab
Hub.UI.Tabs.Admin = AdminTab
Hub.UI.Tabs.Quest = QuestTab
Hub.UI.Tabs.Player = PlayerTab
Hub.UI.Tabs.Predictor = PredictorTab
Hub.UI.Tabs.Settings = SettingsTab

local FarmEggGroup = FarmTab:AddLeftGroupbox("Farm Eggs", Hub.Icons.Farm)
local ProgressionGroup = FarmTab:AddRightGroupbox("Progression", Hub.Icons.Progression)
local EggFinderGroup = FarmTab:AddRightGroupbox("Egg Finder", Hub.Icons.EggFinder)
local AutoPlaceGroup = PetsTab:AddLeftGroupbox("Auto Place Egg", Hub.Icons.Place)
local AutoMutateGroup = PetsTab:AddLeftGroupbox("Auto Mutation", Hub.Icons.Mutate)
local AutoFuseGroup = PetsTab:AddLeftGroupbox("Auto Fuse", Hub.Icons.Fuse)
local AutoHatchGroup = PetsTab:AddRightGroupbox("Auto Hatch & Equip", Hub.Icons.Pets)
local AutoSellGroup = PetsTab:AddRightGroupbox("Auto Sell", Hub.Icons.Sell)
local FavoriteGroup = PetsTab:AddRightGroupbox("Favorite", Hub.Icons.Favorite)
local PumpkinBossGroup = EventTab:AddLeftGroupbox("Pumpkin Boss", Hub.Icons.PumpkinBoss)
local GhostDogFishingGroup = EventTab:AddLeftGroupbox("Ghost Dog & Fishing", Hub.Icons.GhostDogFishing)
local PhantomExpressGroup = EventTab:AddRightGroupbox("Phantom Express", Hub.Icons.PhantomExpress)
local HalloweenMonsterGroup = EventTab:AddRightGroupbox("Halloween Monsters", Hub.Icons.HalloweenMonster)
local TheHollowGroup = EventTab:AddLeftGroupbox("The Hollow", Hub.Icons.TheHollow)
local CaptureTheEggGroup = AdminTab:AddLeftGroupbox("Capture The Egg", Hub.Icons.CaptureTheEgg)
local AdminTreadmillGroup = AdminTab:AddRightGroupbox("Admin Treadmill", Hub.Icons.Treadmill)
local InstantStealGroup = AdminTab:AddLeftGroupbox("Instant Steal Abuse", Hub.Icons.InstantSteal)
local CursedIslandGroup = AdminTab:AddLeftGroupbox("Cursed Island Wars", Hub.Icons.Fights)
local MinigameEggsGroup = AdminTab:AddRightGroupbox("Minigame Eggs", Hub.Icons.MinigameEggs)
local AutoButterflyGroup = QuestTab:AddLeftGroupbox("Auto Butterfly", Hub.Icons.AutoButterfly)
local ShootingStarGroup = QuestTab:AddRightGroupbox("Shooting Star", Hub.Icons.ShootingStar)
local PlayerEspGroup = PlayerTab:AddLeftGroupbox("ESP", Hub.Icons.ESP)
local PlayerMoveGroup = PlayerTab:AddRightGroupbox("Movement", Hub.Icons.Movement)
local PlayerCharGroup = PlayerTab:AddRightGroupbox("Character", Hub.Icons.Character)
local DiscordWebhookGroup = PredictorTab:AddLeftGroupbox("Discord Webhook", Hub.Icons.Predictor)
local EggPredictorGroup = PredictorTab:AddLeftGroupbox("Egg Predictor", Hub.Icons.EggPredictor)
local FusePredictorGroup = PredictorTab:AddRightGroupbox("Fuse Predictor", Hub.Icons.Fuse)

Hub.UI.Groups.FarmEggs = FarmEggGroup
Hub.UI.Groups.Progression = ProgressionGroup
Hub.UI.Groups.EggFinder = EggFinderGroup
Hub.UI.Groups.AutoPlaceEgg = AutoPlaceGroup
Hub.UI.Groups.AutoMutation = AutoMutateGroup
Hub.UI.Groups.AutoFuse = AutoFuseGroup
Hub.UI.Groups.AutoHatchEquip = AutoHatchGroup
Hub.UI.Groups.AutoSell = AutoSellGroup
Hub.UI.Groups.Favorite = FavoriteGroup
Hub.UI.Groups.PumpkinBoss = PumpkinBossGroup
Hub.UI.Groups.GhostDogFishing = GhostDogFishingGroup
Hub.UI.Groups.PhantomExpress = PhantomExpressGroup
Hub.UI.Groups.HalloweenMonsters = HalloweenMonsterGroup
Hub.UI.Groups.TheHollow = TheHollowGroup
Hub.UI.Groups.CursedIsland = CursedIslandGroup
Hub.UI.Groups.CaptureTheEgg = CaptureTheEggGroup
Hub.UI.Groups.AdminTreadmill = AdminTreadmillGroup
Hub.UI.Groups.InstantSteal = InstantStealGroup
Hub.UI.Groups.MinigameEggs = MinigameEggsGroup
Hub.UI.Groups.AutoButterfly = AutoButterflyGroup
Hub.UI.Groups.ShootingStar = ShootingStarGroup

Hub.Features.BuildFarmEggs(FarmEggGroup)
Hub.Features.BuildProgression(ProgressionGroup)
Hub.Features.BuildAutoPlaceEgg(AutoPlaceGroup)
Hub.Features.BuildAutoMutation(AutoMutateGroup)
Hub.Features.BuildAutoFuse(AutoFuseGroup)
Hub.Features.BuildAutoHatchAndEquip(AutoHatchGroup)
Hub.Features.BuildAutoSell(AutoSellGroup)
Hub.Features.BuildFavorite(FavoriteGroup)
Hub.Features.BuildPumpkinBoss(PumpkinBossGroup)
Hub.Features.BuildGhostDogFishing(GhostDogFishingGroup)
Hub.Features.BuildPhantomExpress(PhantomExpressGroup)
Hub.Features.BuildHalloweenMonsters(HalloweenMonsterGroup)
Hub.Features.BuildTheHollow(TheHollowGroup)
Hub.Features.BuildCursedIsland(CursedIslandGroup)
Hub.Features.BuildCaptureTheEgg(CaptureTheEggGroup)
Hub.Features.BuildAdminTreadmill(AdminTreadmillGroup)
Hub.Features.BuildInstantSteal(InstantStealGroup)
Hub.Features.BuildMinigameEggs(MinigameEggsGroup)
Hub.UI.Groups.ESP = PlayerEspGroup
Hub.UI.Groups.Movement = PlayerMoveGroup
Hub.UI.Groups.Character = PlayerCharGroup
Hub.UI.Groups.DiscordWebhook = DiscordWebhookGroup
Hub.UI.Groups.EggPredictor = EggPredictorGroup
Hub.UI.Groups.FusePredictor = FusePredictorGroup

Hub.Features.BuildAutoButterfly(AutoButterflyGroup)
Hub.Features.BuildShootingStar(ShootingStarGroup)
Hub.Features.BuildPlayerESP(PlayerEspGroup)
Hub.Features.BuildPlayerMovement(PlayerMoveGroup)
Hub.Features.BuildPlayerCharacter(PlayerCharGroup)
PredictionModule.BuildWebhook(DiscordWebhookGroup)
PredictionModule.Build(EggPredictorGroup, {
	Icons = {
		Size = Hub.Icons.Essence,
		Weight = Hub.Icons.Speed,
		Egg = Hub.Icons.Place,
	},
	OnGoToEgg = function(entry)
		local targetRecord = nil
		for _, fieldEgg in ipairs(Engine.CollectRawFieldEggs(true)) do
			if fieldEgg.Uid == entry.Id then
				targetRecord = fieldEgg
				break
			end
		end
		if not targetRecord or not targetRecord.BoundsCFrame then
			return
		end
		Engine.FlyToPosition(
			targetRecord.BoundsCFrame.Position + Vector3.new(0, 3, 0),
			RuntimeState.SessionId,
			4,
			30,
			500,
			true
		)
	end,
})
PredictionModule.BuildFuse(FusePredictorGroup)

-- Character Respawn & Anti-Ragdoll Guard Loop
Hub.Lifecycle.TrackConnection(LocalPlayer.CharacterAdded:Connect(function()
	ClearSwapConnections()
	RuntimeState.OriginalHumanoid = nil
	RuntimeState.SwapClone = nil
	RuntimeState.IsExecuting = false
end))

Hub.Lifecycle.SpawnLoop(0.25, function()
	if Engine.Disposed then
		return
	end
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if character and humanoid and humanoid.Health > 0 then
		if FarmConfig.Defense_AntiRagdoll and not Engine.AutoCycle and not Engine.IsInExternalMapOrEvent() then
			ApplyAntiRagdoll(character)
		end
	end
end)

-- FpsManager, SaveManager, ThemeManager & ServerManager Setup
if FpsManager then
	FpsManager:SetLibrary(LibraryLoader)
	FpsManager:ApplyToTab(SettingsTab)
	Hub.FpsManager = FpsManager
end
if ServerManager then
	ServerManager:SetLibrary(LibraryLoader)
	ServerManager:SetAutoLoadSource(RepoFile("Games/Steal-An-Egg.luau"))
	ServerManager:ApplyToTab(SettingsTab)
	Hub.ServerManager = ServerManager
	Hub.ServerHop = function(hopMode)
		return ServerManager:Hop(hopMode)
	end
end
if type(EggFinderModule) == "table" then
	Hub.EggFinder = EggFinderModule
	EggFinderModule.Build(EggFinderGroup)
end
if SaveManager and ThemeManager then
	SaveManager:SetLibrary(LibraryLoader)
	ThemeManager:SetLibrary(LibraryLoader)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({ "MenuKeybind", "Input_Server_JobId" })
	ThemeManager:SetFolder("N3Hub")
	SaveManager:SetFolder("N3Hub")
	SaveManager:SetSubFolder("StealAnEgg")
	SaveManager:BuildConfigSection(SettingsTab)
	ThemeManager:ApplyToTab(SettingsTab)
	pcall(SaveManager.LoadAutoloadConfig, SaveManager)
end

-- Clean Unload Handler
LibraryLoader:OnUnload(function()
	Hub.Lifecycle.DisposeAll()
	RuntimeState.Unloaded = true
	Engine.Disposed = true
	FarmConfig.AutoStealEnabled = false
	FarmConfig.AutoStealAll = false
	FarmConfig.StealAllMode = false
	FarmConfig.SafeZoneVisual = false
	FarmConfig.Progression_AutoBuyTrail = false
	FarmConfig.Progression_AutoUpgradeBase = false
	FarmConfig.Progression_AutoUpgradeTreadmill = false
	FarmConfig.Progression_AutoClaimMoney = false
	FarmConfig.Progression_AutoClaimIndex = false
	FarmConfig.Progression_AutoTreadmill = false
	FarmConfig.Place_AutoPlace = false
	FarmConfig.Hatch_AutoHatch = false
	FarmConfig.Hatch_AutoEquip = false
	FarmConfig.Sell_AutoPets = false
	FarmConfig.Sell_AutoEggs = false
	FarmConfig.Mutate_Auto = false
	FarmConfig.Fuse_Auto = false
	FarmConfig.Fav_AutoPets = false
	FarmConfig.Fav_AutoEquipped = false
	FarmConfig.Fav_AutoUnfavEquipped = false
	FarmConfig.PumpkinBoss_Auto = false
	FarmConfig.PumpkinBoss_AutoMastery = false
	FarmConfig.PumpkinBoss_AutoManorKey = false
	FarmConfig.Monster_AutoKill = false
	FarmConfig.Fishing_AutoQuest = false
	FarmConfig.Fishing_AutoFish = false
	FarmConfig.Hollow_AutoRace = false
	FarmConfig.Hollow_AutoPowerUp = false
	FarmConfig.Phantom_AutoRide = false
	FarmConfig.Phantom_VacuumBoss = false
	FarmConfig.Phantom_TradeSouls = false
	FarmConfig.Butterfly_Auto = false
	FarmConfig.Butterfly_Trade = false
	FarmConfig.Butterfly_Craft = false
	FarmConfig.Wisp_Auto = false
	FarmConfig.Banjo_Auto = false
	FarmConfig.Star_Auto = false
	FarmConfig.ESP_Eggs = false
	FarmConfig.ESP_InventoryValue = false
	FarmConfig.ESP_Guards = false
	FarmConfig.ESP_Players = false
	FarmConfig.Move_SpeedBoost = false
	FarmConfig.Move_InfiniteJump = false
	FarmConfig.Char_Invisibility = false
	FarmConfig.Admin_Capture = false
	FarmConfig.Admin_CaptureTake = false
	FarmConfig.Admin_AutoTreadmill = false
	FarmConfig.Admin_InstantSteal = false
	FarmConfig.Admin_MinigameEggs = false
	FarmConfig.IslandWars_Auto = false
	Hub.TheHollow.Active = false
	RuntimeState.SessionId = RuntimeState.SessionId + 1

	pcall(Hub.GhostDogFishing.Restart)
	pcall(Hub.IslandWars.RestoreKnock)
	pcall(PredictionModule.Stop)
	pcall(EggFinderModule.Stop)
	pcall(Hub.HalloweenMonsters.SetAutoEnabled, false)
	pcall(Hub.AutoMutate.SetAutoEnabled, false)
	pcall(Engine.StopSafeZoneVisual)
	pcall(Engine.CancelAutoSteal)
	pcall(RestoreCharacter)

	if CarryChangedConnection then
		pcall(CarryChangedConnection.Disconnect, CarryChangedConnection)
	end
	if PromptZeroHoldConnection then
		pcall(PromptZeroHoldConnection.Disconnect, PromptZeroHoldConnection)
	end
	for _, connection in ipairs(AntiRagdollGuard.CharConnections) do
		pcall(connection.Disconnect, connection)
	end
	for _, connection in ipairs(AntiRagdollGuard.GlobalConnections) do
		pcall(connection.Disconnect, connection)
	end
end)

LoadingScreen:SetMessage("Verifying")
LoadingScreen:SetCurrentStep(5)
LoadingScreen:SetDescription("Verifying the engine, remotes & final configuration...")
task.wait(0.2)
pcall(function()
	LoadingScreen:Destroy()
end)
LibraryLoader:Toggle(true)
