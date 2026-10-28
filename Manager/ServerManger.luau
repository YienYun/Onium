-- ============================================================================
-- N3 HUB - Server Manager (Server Hop, Job ID & Auto Rejoin)
-- ============================================================================

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local ServerManager = {
	Library = nil,
	Icon = "server",
	Disposed = false,
	AutoLoadSource = nil,
	Config = {
		HopMode = "Least Players",
		RejoinOnDisconnect = true,
	},
}

local HOP_MODES = { "Most Players", "Random", "Least Players" }

local SERVER_PAGE_URL = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100"
local JOB_ID_PATTERN = "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"
local AUTO_LOAD_SETTING_KEY = "OniumAutoLoadScriptEnabled"
local AUTO_LOAD_JOB_FLAG = "__OniumAutoLoadedJob"

local SERVER_CACHE_SEC = 60
local RANDOM_PAGE_SCAN = 3
local SORTED_PAGE_SCAN = 6
local HOP_RETRY_SEC = 10
local FETCH_RETRY_SEC = 0.1
local HOP_SETTLE_SEC = 10
local MANUAL_TELEPORT_LOCK_SEC = 8
local SELF_TELEPORT_GRACE_SEC = 60
local SAME_JOB_REJOIN_TRIES = 2
local HOP_NOTIFY_EVERY = 10

local ServerState = {
	HopRun = 0,
	HopBusy = false,
	HopTarget = nil,
	HopDenied = false,
	AvoidServers = {},
	CachedList = nil,
	CachedMode = nil,
	CachedAt = 0,
	ManualLockUntil = 0,
	Rejoining = false,
	LastSelfTeleportAt = 0,
}

local Connections = {}
local QueuedSource = nil
local AutoLoadToggle = nil

local function TrackConnection(connectionObj)
	if connectionObj then
		table.insert(Connections, connectionObj)
	end
	return connectionObj
end

-- Restricted signals (RobloxScript capability) throw on connect, so the getter stays inside the pcall.
local function TryConnect(getSignal, callback)
	local connectOk, connectionObj = pcall(function()
		local signalObject = getSignal()
		if not signalObject then
			return nil
		end
		return signalObject:Connect(callback)
	end)

	if not connectOk then
		return nil
	end

	return TrackConnection(connectionObj)
end

local function Notify(titleText, bodyText)
	local library = ServerManager.Library
	if library and type(library.Notify) == "function" then
		pcall(library.Notify, library, {
			Title = tostring(titleText),
			Description = tostring(bodyText),
			Time = 4,
		})
	end
end

local function IsAlive()
	local library = ServerManager.Library
	if ServerManager.Disposed then
		return false
	end
	return not (library and library.Unloaded == true)
end

local function TrimText(rawText)
	return (tostring(rawText or ""):match("^%s*(.-)%s*$"))
end

local function NormalizeJobId(rawText)
	local trimmedText = TrimText(rawText)
	return trimmedText:match(JOB_ID_PATTERN) or trimmedText
end

-- ============================================================================
-- 1. AUTO LOAD SCRIPT (QUEUE ON TELEPORT)
-- ============================================================================

local function ResolveQueueOnTeleport()
	if type(queue_on_teleport) == "function" then
		return queue_on_teleport
	end
	if type(queueonteleport) == "function" then
		return queueonteleport
	end
	if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
		return syn.queue_on_teleport
	end
	if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
		return fluxus.queue_on_teleport
	end
	return nil
end

local function BuildAutoLoadScript(sourceUrl)
	return ([[
repeat task.wait() until game:IsLoaded()
local env = (typeof(getgenv) == "function" and getgenv()) or _G
local teleport = game:GetService("TeleportService")
local readOk, enabled = pcall(function()
	return teleport:GetTeleportSetting("%s")
end)
if readOk and enabled == false then
	return
end
if env.%s == game.JobId then
	return
end
env.%s = game.JobId
local fetchOk, body = pcall(function()
	return game:HttpGet("%s")
end)
if not fetchOk or type(body) ~= "string" or #body < 128 then
	return
end
local chunk = loadstring(body)
if type(chunk) == "function" then
	pcall(chunk)
end
]]):format(AUTO_LOAD_SETTING_KEY, AUTO_LOAD_JOB_FLAG, AUTO_LOAD_JOB_FLAG, sourceUrl)
end

local function ApplyAutoLoadSetting(isEnabled)
	pcall(function()
		TeleportService:SetTeleportSetting(AUTO_LOAD_SETTING_KEY, isEnabled == true)
	end)
end

local function QueueAutoLoadScript()
	local sourceUrl = ServerManager.AutoLoadSource
	if type(sourceUrl) ~= "string" or sourceUrl == "" then
		return false
	end

	local queueFn = ResolveQueueOnTeleport()
	if not queueFn then
		return false
	end

	if QueuedSource ~= sourceUrl then
		if not pcall(queueFn, BuildAutoLoadScript(sourceUrl)) then
			return false
		end
		QueuedSource = sourceUrl
	end

	return true
end

local function IsAutoLoadEnabled()
	return AutoLoadToggle ~= nil and AutoLoadToggle.Value == true
end

local function EnsureAutoLoadBeforeTeleport()
	if not IsAutoLoadEnabled() then
		return
	end

	ApplyAutoLoadSetting(true)

	if QueuedSource == nil then
		QueueAutoLoadScript()
	end
end

-- ============================================================================
-- 2. SERVER LIST, FILTER & PICK
-- ============================================================================

local function ReadServerPage(mode, cursor)
	local sortOrder = mode == "Least Players" and "Asc" or "Desc"
	local pageUrl = SERVER_PAGE_URL:format(game.PlaceId, sortOrder)

	if cursor and cursor ~= "" then
		pageUrl = pageUrl .. "&cursor=" .. HttpService:UrlEncode(cursor)
	end

	local fetchOk, body = pcall(function()
		return game:HttpGet(pageUrl)
	end)
	if not fetchOk or type(body) ~= "string" then
		return nil
	end

	local decodeOk, decoded = pcall(HttpService.JSONDecode, HttpService, body)
	if not decodeOk or type(decoded) ~= "table" then
		return nil
	end

	return decoded
end

local function CollectServers(mode)
	local currentJobId = tostring(game.JobId or "")
	local pageScan = mode == "Random" and RANDOM_PAGE_SCAN or SORTED_PAGE_SCAN
	local servers = {}
	local cursor = nil

	for _ = 1, pageScan do
		local page = ReadServerPage(mode, cursor)
		if not page then
			return nil
		end

		for _, entry in ipairs(page.data or {}) do
			local serverId = tostring(entry.id or "")
			local playing = tonumber(entry.playing) or 0
			local maxPlayers = tonumber(entry.maxPlayers) or 0

			if serverId ~= "" and serverId ~= currentJobId and playing < maxPlayers then
				table.insert(servers, {
					Id = serverId,
					Playing = playing,
					FreeSlots = maxPlayers - playing,
				})
			end
		end

		if #servers > 0 and mode ~= "Random" then
			break
		end

		cursor = page.nextPageCursor
		if not cursor or cursor == "" then
			break
		end
	end

	return servers
end

local function GetServerList(mode)
	local cacheFresh = ServerState.CachedList ~= nil
		and ServerState.CachedMode == mode
		and (os.clock() - ServerState.CachedAt) < SERVER_CACHE_SEC

	if cacheFresh then
		return ServerState.CachedList
	end

	local servers = CollectServers(mode)
	if not servers then
		return nil
	end

	ServerState.CachedList = servers
	ServerState.CachedMode = mode
	ServerState.CachedAt = os.clock()

	return servers
end

local function FilterCandidates(servers, minFreeSlots)
	local candidates = {}

	for _, server in ipairs(servers) do
		if not ServerState.AvoidServers[server.Id] and server.FreeSlots >= minFreeSlots then
			table.insert(candidates, server)
		end
	end

	return candidates
end

local function PickCandidate(servers, mode)
	local candidates = FilterCandidates(servers, 2)
	if #candidates == 0 then
		candidates = FilterCandidates(servers, 1)
	end

	if #candidates == 0 and next(ServerState.AvoidServers) ~= nil then
		table.clear(ServerState.AvoidServers)
		candidates = FilterCandidates(servers, 1)
	end

	if #candidates == 0 then
		return nil
	end

	if mode ~= "Random" then
		table.sort(candidates, function(serverA, serverB)
			if mode == "Least Players" then
				return serverA.Playing < serverB.Playing
			end
			return serverA.Playing > serverB.Playing
		end)
	end

	local pickLimit = mode == "Random" and #candidates or math.min(#candidates, 100)
	return candidates[math.random(1, pickLimit)]
end

-- ============================================================================
-- 3. TELEPORT GUARD & FAILURE ROUTING
-- ============================================================================

local function IsTeleportLocked()
	return os.clock() < ServerState.ManualLockUntil
end

local function LockTeleport()
	ServerState.ManualLockUntil = os.clock() + MANUAL_TELEPORT_LOCK_SEC
end

local function UnlockTeleport()
	ServerState.ManualLockUntil = 0
end

local function TeleportToServer(serverId)
	TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, LocalPlayer)
end

local function TeleportToPlace()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

local function HandleTeleportFailure(teleportResult, errorMessage)
	if not IsAlive() then
		return
	end

	local reason = tostring(errorMessage ~= "" and errorMessage or teleportResult)

	if ServerState.HopTarget then
		ServerState.AvoidServers[ServerState.HopTarget] = true
		ServerState.HopTarget = nil
		ServerState.HopDenied = true

		if not ServerState.HopBusy then
			Notify("Server Hop Failed", reason)
		end
		return
	end

	if IsTeleportLocked() then
		UnlockTeleport()
		Notify("Teleport Failed", reason)
	end
end

-- ============================================================================
-- 4. SERVER HOP
-- ============================================================================

local function HopOnce()
	local mode = ServerManager.Config.HopMode
	local servers = GetServerList(mode)
	if not servers then
		return "fetch"
	end

	local candidate = PickCandidate(servers, mode)
	if not candidate then
		ServerState.CachedList = nil
		return "empty"
	end

	ServerState.HopTarget = candidate.Id
	ServerState.HopDenied = false
	EnsureAutoLoadBeforeTeleport()

	if not pcall(TeleportToServer, candidate.Id) then
		ServerState.AvoidServers[candidate.Id] = true
		ServerState.HopTarget = nil
		return "failed"
	end

	local settleDeadline = os.clock() + HOP_SETTLE_SEC
	while os.clock() < settleDeadline do
		if ServerState.HopDenied then
			return "denied"
		end
		task.wait(0.25)
	end

	return "waiting"
end

local function StartServerHop()
	if ServerState.HopBusy then
		return
	end

	ServerState.HopRun += 1
	ServerState.HopBusy = true
	local runId = ServerState.HopRun

	task.spawn(function()
		local attempts = 0

		while IsAlive() and ServerState.HopRun == runId do
			attempts += 1

			local result = HopOnce()
			if result == "waiting" then
				break
			end

			if result == "empty" then
				ServerState.CachedList = nil
				table.clear(ServerState.AvoidServers)
			end

			if attempts % HOP_NOTIFY_EVERY == 0 then
				Notify("Server Hop", string.format("Every server was full so far, %d tries.", attempts))
			end

			task.wait(result == "fetch" and FETCH_RETRY_SEC or HOP_RETRY_SEC)
		end

		if ServerState.HopRun == runId then
			ServerState.HopBusy = false
			ServerState.HopTarget = nil
		end
	end)
end

-- ============================================================================
-- 5. JOB ID (JOIN, COPY) & MANUAL REJOIN
-- ============================================================================

local JobIdInput = nil

local function ReadClipboardJobId()
	local readFn = getclipboard or readclipboard or getrbxclipboard
	if type(readFn) ~= "function" then
		return ""
	end

	local readOk, clipboardText = pcall(readFn)
	if not readOk or type(clipboardText) ~= "string" then
		return ""
	end

	return NormalizeJobId(clipboardText)
end

local function ReadJobIdInput()
	if JobIdInput and type(JobIdInput.Value) == "string" then
		return NormalizeJobId(JobIdInput.Value)
	end

	return ""
end

local function WriteJobIdInput(jobId)
	if JobIdInput and type(JobIdInput.SetValue) == "function" then
		pcall(JobIdInput.SetValue, JobIdInput, jobId)
	end
end

local function JoinJobId()
	if IsTeleportLocked() then
		Notify("Join Job ID Failed", "A teleport is already running, try again shortly.")
		return
	end

	local jobId = ReadJobIdInput()
	if jobId == "" then
		jobId = ReadClipboardJobId()
	end

	if jobId == "" then
		Notify("Join Job ID Failed", "Paste a valid Job ID first.")
		return
	end

	LockTeleport()
	EnsureAutoLoadBeforeTeleport()

	if not pcall(TeleportToServer, jobId) then
		UnlockTeleport()
		Notify("Join Job ID Failed", "Roblox could not join that server.")
	end
end

local function CopyCurrentJobId()
	local jobId = tostring(game.JobId or "")

	WriteJobIdInput(jobId)

	local clipboardFn = setclipboard or toclipboard
	local isCopied = type(clipboardFn) == "function" and pcall(clipboardFn, jobId)

	Notify(isCopied and "Job ID Copied" or "Job ID Shown", jobId)
end

local function RejoinServer()
	if IsTeleportLocked() then
		Notify("Rejoin Failed", "A teleport is already running, try again shortly.")
		return
	end

	LockTeleport()
	EnsureAutoLoadBeforeTeleport()

	local jobId = tostring(game.JobId or "")
	local rejoinOk = pcall(function()
		if jobId ~= "" then
			TeleportToServer(jobId)
		else
			TeleportToPlace()
		end
	end)

	if not rejoinOk then
		UnlockTeleport()
		Notify("Rejoin Failed", "Roblox could not rejoin the server.")
	end
end

-- ============================================================================
-- 6. AUTO REJOIN WHEN DISCONNECT
-- ============================================================================

local function ContainsAny(textValue, patterns)
	for _, pattern in ipairs(patterns) do
		if string.find(textValue, pattern, 1, true) then
			return true
		end
	end
	return false
end

local function HandleDisconnectMessage(rawMessage)
	if not ServerManager.Config.RejoinOnDisconnect or ServerState.Rejoining then
		return
	end

	if ServerState.LastSelfTeleportAt > 0
		and (os.clock() - ServerState.LastSelfTeleportAt) < SELF_TELEPORT_GRACE_SEC
	then
		return
	end

	local messageText = string.lower(tostring(rawMessage or ""))
	if messageText == "" or string.find(messageText, "teleport", 1, true) then
		return
	end

	local errorOk, errorCode = pcall(function()
		return GuiService:GetErrorCode()
	end)
	if errorOk and errorCode == Enum.ConnectionError.DisconnectDuplicatePlayer then
		return
	end

	if ContainsAny(messageText, { "banned", "same account" }) then
		return
	end

	ServerState.Rejoining = true

	local serverClosed = ContainsAny(messageText, { "shut", "no longer", "closed" })
	local jobId = tostring(game.JobId or "")

	EnsureAutoLoadBeforeTeleport()
	Notify("Auto Rejoin", serverClosed and "Server closed, joining another one." or "Disconnected, rejoining now.")

	task.spawn(function()
		local attempt = 0

		while IsAlive() do
			attempt += 1

			local sameJob = not serverClosed and jobId ~= "" and attempt <= SAME_JOB_REJOIN_TRIES
			pcall(function()
				if sameJob then
					TeleportToServer(jobId)
				else
					TeleportToPlace()
				end
			end)

			task.wait(sameJob and 4 or 5)
		end
	end)
end

local function ReadErrorMessage(promptInstance)
	for _, descendant in ipairs(promptInstance:GetDescendants()) do
		if descendant:IsA("TextLabel") and descendant.Name == "ErrorMessage" then
			if descendant.Text ~= "" then
				return descendant.Text
			end
		end
	end

	local errorOk, errorMessage = pcall(function()
		return GuiService:GetErrorMessage()
	end)
	if errorOk and type(errorMessage) == "string" and errorMessage ~= "" then
		return errorMessage
	end

	return "disconnected"
end

local function HasErrorPrompt(promptOverlay)
	return promptOverlay ~= nil and promptOverlay:FindFirstChild("ErrorPrompt") ~= nil
end

local function WatchDisconnectPrompts()
	TryConnect(function()
		return GuiService.ErrorMessageChanged
	end, function()
		task.wait(0.3)
		if not IsAlive() then
			return
		end

		local promptOk, promptGui = pcall(function()
			return CoreGui:FindFirstChild("RobloxPromptGui")
		end)
		local promptOverlay = promptOk and promptGui and promptGui:FindFirstChild("promptOverlay")
		if not HasErrorPrompt(promptOverlay) then
			return
		end

		local errorOk, errorMessage = pcall(function()
			return GuiService:GetErrorMessage()
		end)
		HandleDisconnectMessage(errorOk and errorMessage or "disconnected")
	end)

	task.spawn(function()
		local promptOk, promptGui = pcall(function()
			return CoreGui:WaitForChild("RobloxPromptGui", 30)
		end)
		if not promptOk or not promptGui then
			return
		end

		local overlayOk, promptOverlay = pcall(function()
			return promptGui:WaitForChild("promptOverlay", 30)
		end)
		if not overlayOk or not promptOverlay then
			return
		end

		TryConnect(function()
			return promptOverlay.ChildAdded
		end, function(childInstance)
			if childInstance.Name ~= "ErrorPrompt" then
				return
			end

			task.wait(0.2)
			HandleDisconnectMessage(ReadErrorMessage(childInstance))
		end)
	end)
end

-- ============================================================================
-- 7. UI SECTION
-- ============================================================================

local function ReflectAutoLoadToggle(isEnabled)
	if AutoLoadToggle and type(AutoLoadToggle.SetValue) == "function" then
		pcall(AutoLoadToggle.SetValue, AutoLoadToggle, isEnabled == true)
	end
end

local function DisableAutoLoad()
	ApplyAutoLoadSetting(false)
	ReflectAutoLoadToggle(false)
end

local function EnableAutoLoad()
	ReflectAutoLoadToggle(true)
	ApplyAutoLoadSetting(true)

	if QueueAutoLoadScript() then
		Notify("Auto Load Script Enabled", "This hub will re-run itself after every teleport.")
		return
	end

	DisableAutoLoad()
	Notify("Auto Load Unavailable", "This executor does not support queue on teleport.")
end

local function ShowAutoLoadDialog(targetTab)
	local window = targetTab.Window
	if not window or type(window.AddDialog) ~= "function" then
		return false
	end

	local library = ServerManager.Library
	if library and type(library.Dialogues) == "table" and library.Dialogues["Dialog_Server_AutoLoad"] then
		return true
	end

	return pcall(window.AddDialog, window, "Dialog_Server_AutoLoad", {
		Title = "Enable Auto Load Script",
		Description = "The hub will queue itself and re-run automatically after every teleport. "
			.. "This needs an executor that supports queue on teleport.",
		Icon = "triangle-alert",
		OutsideClickDismiss = false,
		FooterButtons = {
			{ Title = "Cancel", Variant = "Secondary", Order = 1, Callback = function()
				DisableAutoLoad()
			end },
			{ Title = "Accept", Variant = "Primary", Order = 2, Callback = function()
				EnableAutoLoad()
			end },
		},
	})
end

local function OnAutoLoadClicked(targetTab)
	-- Runs after the click has fully released: building the dialog inside the click
	-- event makes it open and get dismissed by the same input.
	task.defer(function()
		if not IsAutoLoadEnabled() then
			ApplyAutoLoadSetting(false)
			return
		end

		if ShowAutoLoadDialog(targetTab) then
			return
		end

		DisableAutoLoad()
		Notify("Auto Load Unavailable", "Could not open the confirmation dialog.")
	end)
end

function ServerManager:BuildServerSection(targetTab, useRightSide)
	if not targetTab then
		return nil
	end

	local addGroupMethod = useRightSide and targetTab.AddRightGroupbox or targetTab.AddLeftGroupbox
	if type(addGroupMethod) ~= "function" then
		return nil
	end

	local serverGroup = addGroupMethod(targetTab, "Server", self.Icon)

	AutoLoadToggle = serverGroup:AddToggle("Toggle_Server_AutoLoadScript", {
		Text = "Auto Load Script",
		Default = false,
		Tooltip = "Queues this hub so it runs again after every teleport (asks for confirmation)",
	})

	-- The toggle has no Callback on purpose: only a real click may ask for confirmation,
	-- so config restore can never pop the dialog.
	TryConnect(function()
		return AutoLoadToggle.Holder.MouseButton1Click
	end, function()
		OnAutoLoadClicked(targetTab)
	end)

	serverGroup:AddDropdown("Dropdown_Server_HopMode", {
		Text = "Server Hop Mode",
		Values = HOP_MODES,
		Default = self.Config.HopMode,
		Tooltip = "Order used when picking the next server",
		Callback = function(selectedMode)
			if type(selectedMode) == "string" and selectedMode ~= "" then
				self.Config.HopMode = selectedMode
			end
		end,
	})

	serverGroup:AddButton({
		Text = "Server Hop",
		Tooltip = "Teleports to another server of this place",
		Func = function()
			StartServerHop()
		end,
	})

	JobIdInput = serverGroup:AddInput("Input_Server_JobId", {
		Text = "Job ID",
		Default = "",
		Placeholder = "Paste a server Job ID...",
		MaxLength = 100,
		AllowEmpty = true,
		Tooltip = "Target Job ID used by Join Job ID",
	})

	serverGroup:AddButton({
		Text = "Join Job ID",
		Tooltip = "Joins the Job ID typed above (falls back to your clipboard)",
		Func = function()
			JoinJobId()
		end,
	})

	serverGroup:AddButton({
		Text = "Copy Current Job ID",
		Tooltip = "Copies this server's Job ID and fills the field above",
		Func = function()
			CopyCurrentJobId()
		end,
	})

	serverGroup:AddButton({
		Text = "Rejoin Server",
		Tooltip = "Rejoins this server immediately",
		Func = function()
			RejoinServer()
		end,
	})

	serverGroup:AddToggle("Toggle_Server_AutoRejoinDisconnect", {
		Text = "Auto Rejoin When Disconnect",
		Default = self.Config.RejoinOnDisconnect,
		Tooltip = "Rejoins automatically when Roblox disconnects or closes the server",
		Callback = function(isEnabled)
			self.Config.RejoinOnDisconnect = isEnabled == true
		end,
	})

	TryConnect(function()
		return LocalPlayer.OnTeleport
	end, function(teleportState)
		ServerState.LastSelfTeleportAt = teleportState == Enum.TeleportState.Failed and 0 or os.clock()
	end)
	TryConnect(function()
		return TeleportService.TeleportInitFailed
	end, function(_player, teleportResult, errorMessage)
		HandleTeleportFailure(teleportResult, errorMessage)
	end)
	WatchDisconnectPrompts()

	return serverGroup
end

function ServerManager:ApplyToTab(targetTab)
	return self:BuildServerSection(targetTab, true)
end

-- ============================================================================
-- 8. PUBLIC API
-- ============================================================================

function ServerManager:Unload()
	if self.Disposed then
		return
	end

	self.Disposed = true
	self.Config.RejoinOnDisconnect = false
	ApplyAutoLoadSetting(false)
	ServerState.HopRun += 1
	ServerState.HopBusy = false
	ServerState.Rejoining = true

	for _, connectionObj in ipairs(Connections) do
		pcall(connectionObj.Disconnect, connectionObj)
	end
	table.clear(Connections)
end

function ServerManager:SetLibrary(libraryInstance)
	self.Library = libraryInstance

	if libraryInstance and type(libraryInstance.OnUnload) == "function" then
		pcall(function()
			libraryInstance:OnUnload(function()
				self:Unload()
			end)
		end)
	end
end

function ServerManager:SetIcon(customIcon)
	if type(customIcon) == "string" and customIcon ~= "" then
		self.Icon = customIcon
	end
end

function ServerManager:SetAutoLoadSource(sourceUrl)
	if type(sourceUrl) == "string" and sourceUrl ~= "" then
		self.AutoLoadSource = sourceUrl
	end
end

return ServerManager
