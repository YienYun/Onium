-- ============================================================================
-- N3 HUB - Universal Multi-Game FPS & Performance Manager (Chilli Engine)
-- Repository Target: https://raw.githubusercontent.com/ZedFu3/N3-Hub/refs/heads/main/Manager/FpsManager.luau
-- ============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local StatsService = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local FpsManager = {
	Library = nil,
	Icon = "wifi", -- Lucide name, resolved by the hub library into a wifi/signal icon
	Disposed = false,
	Config = {
		FpsCap = 240,
		Optimizer = false,
		ShowWatermark = true,
		WatermarkSize = 100,
		Disable3DRender = false,
		AntiAfk = true,
	},
}

local Connections = {}
local function TrackConnection(connObj)
	if connObj then
		table.insert(Connections, connObj)
	end
	return connObj
end

local function ResolveSafeGuiParent()
	if typeof(gethui) == "function" then
		local callOk, huiRoot = pcall(gethui)
		if callOk and typeof(huiRoot) == "Instance" then
			return huiRoot
		end
	end
	local coreOk = pcall(function()
		return CoreGui.Name
	end)
	if coreOk then
		return CoreGui
	end
	return LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui") or nil
end

local function NotifySafe(titleText, bodyText)
	if FpsManager.Library and type(FpsManager.Library.Notify) == "function" then
		pcall(function()
			FpsManager.Library:Notify({
				Title = tostring(titleText),
				Description = tostring(bodyText),
				Time = 4,
			})
		end)
	end
end

-- ============================================================================
-- 1. FPS CAP & DISABLE 3D RENDER CONTROLLER
-- ============================================================================

local RenderState = {
	Generation = 0,
	SavedQuality = nil,
	BackdropGui = nil,
	WarnedNoFpsCap = false,
}

local function ApplyEffectiveFpsCap()
	local targetCap = math.clamp(math.floor(tonumber(FpsManager.Config.FpsCap) or 240), 30, 1000)
	if FpsManager.Config.Disable3DRender then
		targetCap = math.min(targetCap, 40)
	end
	if type(setfpscap) == "function" then
		local callOk = pcall(setfpscap, targetCap)
		if callOk then
			RenderState.WarnedNoFpsCap = false
			return
		end
	end
	if not RenderState.WarnedNoFpsCap then
		RenderState.WarnedNoFpsCap = true
		NotifySafe("FPS Cap Unavailable", "Your executor does not support setfpscap.")
	end
end

local function SetBackdropVisible(showBackdrop)
	if RenderState.BackdropGui then
		pcall(RenderState.BackdropGui.Destroy, RenderState.BackdropGui)
		RenderState.BackdropGui = nil
	end
	if not showBackdrop then
		return
	end
	local playerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not playerGui then
		return
	end
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "__N3FpsRenderBackdrop"
	screenGui.DisplayOrder = -1000
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false

	local bgFrame = Instance.new("Frame")
	bgFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	bgFrame.BorderSizePixel = 0
	bgFrame.Size = UDim2.fromScale(1, 1)
	bgFrame.Parent = screenGui

	screenGui.Parent = playerGui
	RenderState.BackdropGui = screenGui
end

local function Set3DRenderDisabled(disableRender)
	RenderState.Generation = RenderState.Generation + 1
	local myGen = RenderState.Generation

	pcall(SetBackdropVisible, disableRender)
	pcall(function()
		local renderSettings = settings().Rendering
		if disableRender then
			if RenderState.SavedQuality == nil then
				RenderState.SavedQuality = renderSettings.QualityLevel
			end
			renderSettings.QualityLevel = Enum.QualityLevel.Level01
		elseif RenderState.SavedQuality ~= nil then
			renderSettings.QualityLevel = RenderState.SavedQuality
			RenderState.SavedQuality = nil
		end
	end)
	pcall(function()
		RunService:Set3dRenderingEnabled(not disableRender)
	end)
	ApplyEffectiveFpsCap()

	-- Chilli 180s brief 2s render pulse to prevent texture/physics memory buildup during long AFK
	if disableRender then
		task.spawn(function()
			while not FpsManager.Disposed and RenderState.Generation == myGen and FpsManager.Config.Disable3DRender do
				task.wait(180)
				if FpsManager.Disposed or RenderState.Generation ~= myGen or not FpsManager.Config.Disable3DRender then
					return
				end
				pcall(function()
					RunService:Set3dRenderingEnabled(true)
				end)
				task.wait(2)
				if FpsManager.Disposed or RenderState.Generation ~= myGen or not FpsManager.Config.Disable3DRender then
					return
				end
				pcall(function()
					RunService:Set3dRenderingEnabled(false)
				end)
			end
		end)
	end
end

-- ============================================================================
-- 2. REVERSIBLE POTATO GRAPHICS OPTIMIZER (3ms Frame-Budgeted)
-- ============================================================================

local OptimizerState = {
	Active = false,
	Generation = 0,
	SavedGlobalSetters = {},
	SavedInstanceProps = setmetatable({}, { __mode = "k" }),
	PendingQueue = {},
	Listeners = {},
	QueueHeartbeat = nil,
	ScanThread = nil,
}

local OPTIMIZER_SLICE_BUDGET = 0.003

local function SaveAndSetGlobalProp(getterFn, setterFn, newVal)
	local callOk, oldVal = pcall(getterFn)
	if not callOk then
		return
	end
	table.insert(OptimizerState.SavedGlobalSetters, { Setter = setterFn, Value = oldVal })
	pcall(setterFn, newVal)
end

local function SaveAndSetInstanceProp(targetInst, propName, newVal)
	local propTable = OptimizerState.SavedInstanceProps[targetInst]
	if not propTable then
		propTable = {}
		OptimizerState.SavedInstanceProps[targetInst] = propTable
	end
	if propTable[propName] == nil then
		local readOk, origVal = pcall(function()
			return targetInst[propName]
		end)
		if not readOk then
			return
		end
		propTable[propName] = { Value = origVal }
	end
	pcall(function()
		targetInst[propName] = newVal
	end)
end

local function OptimizeSingleInstance(instObj)
	if not OptimizerState.Active or not instObj or not instObj.Parent then
		return
	end
	if instObj:IsA("ParticleEmitter") then
		SaveAndSetInstanceProp(instObj, "Enabled", false)
		SaveAndSetInstanceProp(instObj, "Rate", 0)
	elseif instObj:IsA("Trail") or instObj:IsA("Beam") or instObj:IsA("Fire") or instObj:IsA("Smoke") or instObj:IsA("Sparkles") or instObj:IsA("PostEffect") then
		SaveAndSetInstanceProp(instObj, "Enabled", false)
	elseif instObj:IsA("PointLight") or instObj:IsA("SpotLight") or instObj:IsA("SurfaceLight") then
		SaveAndSetInstanceProp(instObj, "Enabled", false)
		SaveAndSetInstanceProp(instObj, "Brightness", 0)
	elseif instObj:IsA("Explosion") then
		SaveAndSetInstanceProp(instObj, "Visible", false)
	elseif instObj:IsA("SpecialMesh") then
		SaveAndSetInstanceProp(instObj, "TextureId", "")
	elseif instObj:IsA("Decal") or instObj:IsA("Texture") then
		local isCharacterFace = (instObj.Name == "face" and instObj.Parent and instObj.Parent.Name == "Head")
		if not isCharacterFace then
			SaveAndSetInstanceProp(instObj, "Transparency", 1)
		end
	elseif instObj:IsA("MeshPart") then
		SaveAndSetInstanceProp(instObj, "RenderFidelity", Enum.RenderFidelity.Performance)
		SaveAndSetInstanceProp(instObj, "TextureID", "")
		SaveAndSetInstanceProp(instObj, "CastShadow", false)
		SaveAndSetInstanceProp(instObj, "Reflectance", 0)
		SaveAndSetInstanceProp(instObj, "Material", Enum.Material.SmoothPlastic)
	elseif instObj:IsA("BasePart") then
		SaveAndSetInstanceProp(instObj, "CastShadow", false)
		SaveAndSetInstanceProp(instObj, "Reflectance", 0)
		SaveAndSetInstanceProp(instObj, "Material", Enum.Material.SmoothPlastic)
	elseif instObj:IsA("Clouds") then
		SaveAndSetInstanceProp(instObj, "Cover", 0)
		SaveAndSetInstanceProp(instObj, "Density", 0)
	elseif instObj:IsA("Atmosphere") then
		SaveAndSetInstanceProp(instObj, "Density", 0)
		SaveAndSetInstanceProp(instObj, "Haze", 0)
		SaveAndSetInstanceProp(instObj, "Glare", 0)
	end
end

local function DisconnectOptimizerListeners()
	for _, connObj in ipairs(OptimizerState.Listeners) do
		pcall(connObj.Disconnect, connObj)
	end
	table.clear(OptimizerState.Listeners)
	if OptimizerState.QueueHeartbeat then
		pcall(OptimizerState.QueueHeartbeat.Disconnect, OptimizerState.QueueHeartbeat)
		OptimizerState.QueueHeartbeat = nil
	end
end

local function SetOptimizerEnabled(enableOpt)
	if enableOpt then
		if OptimizerState.Active then
			return
		end
		OptimizerState.Active = true
		OptimizerState.Generation = OptimizerState.Generation + 1
		local myGen = OptimizerState.Generation

		local rendering = nil
		pcall(function()
			rendering = settings().Rendering
		end)
		local terrain = Workspace:FindFirstChildOfClass("Terrain")

		local function applyTableProp(tblObj, propKey, targetVal)
			if not tblObj then
				return
			end
			SaveAndSetGlobalProp(
				function()
					return tblObj[propKey]
				end,
				function(restoredVal)
					tblObj[propKey] = restoredVal
				end,
				targetVal
			)
		end

		applyTableProp(rendering, "QualityLevel", Enum.QualityLevel.Level01)
		applyTableProp(rendering, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level01)
		applyTableProp(rendering, "EditQualityLevel", Enum.QualityLevel.Level01)
		pcall(function()
			local userGameSettings = UserSettings():GetService("UserGameSettings")
			applyTableProp(userGameSettings, "SavedQualityLevel", Enum.SavedQualitySetting.QualityLevel1)
		end)

		applyTableProp(Lighting, "GlobalShadows", false)
		applyTableProp(Lighting, "ShadowSoftness", 0)
		applyTableProp(Lighting, "FogEnd", 9000000000)
		applyTableProp(Lighting, "Technology", Enum.Technology.Legacy)
		applyTableProp(Lighting, "EnvironmentDiffuseScale", 0)
		applyTableProp(Lighting, "EnvironmentSpecularScale", 0)

		applyTableProp(terrain, "Decoration", false)
		applyTableProp(terrain, "WaterWaveSize", 0)
		applyTableProp(terrain, "WaterWaveSpeed", 0)
		applyTableProp(terrain, "WaterReflectance", 0)
		applyTableProp(terrain, "WaterTransparency", 1)

		for _, rootContainer in ipairs({ Workspace, Lighting }) do
			table.insert(OptimizerState.Listeners, rootContainer.DescendantAdded:Connect(function(newInst)
				if OptimizerState.Active and OptimizerState.Generation == myGen then
					table.insert(OptimizerState.PendingQueue, newInst)
				end
			end))
		end

		OptimizerState.QueueHeartbeat = RunService.Heartbeat:Connect(function()
			if not OptimizerState.Active or #OptimizerState.PendingQueue == 0 then
				return
			end
			local sliceStart = os.clock()
			while #OptimizerState.PendingQueue > 0 do
				OptimizeSingleInstance(table.remove(OptimizerState.PendingQueue))
				if (os.clock() - sliceStart) > OPTIMIZER_SLICE_BUDGET then
					break
				end
			end
		end)

		OptimizerState.ScanThread = task.spawn(function()
			for _, rootContainer in ipairs({ Workspace, Lighting }) do
				local sliceStart = os.clock()
				for _, desc in ipairs(rootContainer:GetDescendants()) do
					if not OptimizerState.Active or OptimizerState.Generation ~= myGen then
						return
					end
					OptimizeSingleInstance(desc)
					if (os.clock() - sliceStart) > OPTIMIZER_SLICE_BUDGET then
						RunService.Heartbeat:Wait()
						sliceStart = os.clock()
					end
				end
			end
		end)
	else
		if not OptimizerState.Active then
			return
		end
		OptimizerState.Active = false
		OptimizerState.Generation = OptimizerState.Generation + 1
		DisconnectOptimizerListeners()
		table.clear(OptimizerState.PendingQueue)
		if OptimizerState.ScanThread then
			pcall(task.cancel, OptimizerState.ScanThread)
			OptimizerState.ScanThread = nil
		end

		task.spawn(function()
			local sliceStart = os.clock()
			for instObj, savedMap in pairs(OptimizerState.SavedInstanceProps) do
				if instObj and instObj.Parent then
					for propKey, entry in pairs(savedMap) do
						pcall(function()
							instObj[propKey] = entry.Value
						end)
					end
				end
				OptimizerState.SavedInstanceProps[instObj] = nil
				if (os.clock() - sliceStart) > OPTIMIZER_SLICE_BUDGET then
					RunService.Heartbeat:Wait()
					sliceStart = os.clock()
				end
			end
			for idx = #OptimizerState.SavedGlobalSetters, 1, -1 do
				local item = OptimizerState.SavedGlobalSetters[idx]
				pcall(item.Setter, item.Value)
			end
			table.clear(OptimizerState.SavedGlobalSetters)
		end)
	end
end

-- ============================================================================
-- 3. DRAGGABLE CHILLI FPS & PING FLOATING PILL WATERMARK
-- ============================================================================

local WatermarkState = {
	ScreenGui = nil,
	PillFrame = nil,
	UiScale = nil,
	FpsValueLabel = nil,
	PingValueLabel = nil,
	Connections = {},
	SavedPosition = UDim2.fromOffset(16, 16),
	SizeMultiplier = 1.0,
	SmoothedFps = 0,
	NextTextTickAt = 0,
	LastFpsStr = "",
	LastPingStr = "",
}

local COLOR_GOOD = Color3.fromRGB(58, 255, 55)
local COLOR_WARN = Color3.fromRGB(255, 214, 84)
local COLOR_BAD = Color3.fromRGB(255, 96, 96)
local COLOR_MUTED = Color3.fromRGB(150, 150, 158)

local PillFontFace = nil
pcall(function()
	PillFontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
end)

local function GetFpsStatusColor(fpsNum)
	if fpsNum >= 100 then
		return COLOR_GOOD
	elseif fpsNum >= 50 then
		return COLOR_WARN
	end
	return COLOR_BAD
end

local function GetPingStatusColor(pingMs)
	if pingMs <= 90 then
		return COLOR_GOOD
	elseif pingMs <= 180 then
		return COLOR_WARN
	end
	return COLOR_BAD
end

local function UpdateWatermarkScale()
	if not WatermarkState.UiScale then
		return
	end
	local cam = Workspace.CurrentCamera
	local viewport = (cam and cam.ViewportSize.X > 1) and cam.ViewportSize or Vector2.new(1280, 720)
	local baseScale = math.clamp((viewport.X * 0.085) / 132, 0.7, 1.4)
	WatermarkState.UiScale.Scale = baseScale * WatermarkState.SizeMultiplier
end

local function DestroyWatermarkGui()
	for _, connObj in ipairs(WatermarkState.Connections) do
		pcall(connObj.Disconnect, connObj)
	end
	table.clear(WatermarkState.Connections)
	if WatermarkState.ScreenGui then
		pcall(WatermarkState.ScreenGui.Destroy, WatermarkState.ScreenGui)
	end
	WatermarkState.ScreenGui = nil
	WatermarkState.PillFrame = nil
	WatermarkState.UiScale = nil
	WatermarkState.FpsValueLabel = nil
	WatermarkState.PingValueLabel = nil
	WatermarkState.LastFpsStr = ""
	WatermarkState.LastPingStr = ""
	WatermarkState.SmoothedFps = 0
end

local function CreatePillTextLabel(parentFrame, offsetX, widthPx, textColor)
	local lbl = Instance.new("TextLabel")
	lbl.BackgroundTransparency = 1
	lbl.Position = UDim2.fromOffset(offsetX, 9)
	lbl.Size = UDim2.fromOffset(widthPx, 16)
	lbl.Text = ""
	lbl.TextColor3 = textColor
	lbl.TextScaled = true
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	if PillFontFace then
		pcall(function()
			lbl.FontFace = PillFontFace
		end)
	else
		lbl.Font = Enum.Font.GothamBold
	end
	lbl.Parent = parentFrame
	return lbl
end

local function BuildWatermarkGui()
	DestroyWatermarkGui()
	local hostParent = ResolveSafeGuiParent()
	if not hostParent then
		return
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "__N3FpsPingWatermark"
	screenGui.Archivable = false
	screenGui.DisplayOrder = 58
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local pillFrame = Instance.new("Frame")
	pillFrame.Name = "Pill"
	pillFrame.Active = true
	pillFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	pillFrame.BackgroundTransparency = 0.28
	pillFrame.BorderSizePixel = 0
	pillFrame.Position = WatermarkState.SavedPosition
	pillFrame.Size = UDim2.fromOffset(132, 34)
	pillFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = pillFrame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1
	stroke.Transparency = 0.9
	stroke.Parent = pillFrame

	local uiScale = Instance.new("UIScale")
	uiScale.Parent = pillFrame

	WatermarkState.ScreenGui = screenGui
	WatermarkState.PillFrame = pillFrame
	WatermarkState.UiScale = uiScale
	UpdateWatermarkScale()

	WatermarkState.FpsValueLabel = CreatePillTextLabel(pillFrame, 12, 34, COLOR_GOOD)
	CreatePillTextLabel(pillFrame, 48, 22, COLOR_MUTED).Text = "FPS"

	local divider = Instance.new("Frame")
	divider.AnchorPoint = Vector2.new(0.5, 0.5)
	divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider.BackgroundTransparency = 0.85
	divider.BorderSizePixel = 0
	divider.Position = UDim2.new(0, 74, 0.5, 0)
	divider.Size = UDim2.fromOffset(1, 14)
	divider.Parent = pillFrame

	WatermarkState.PingValueLabel = CreatePillTextLabel(pillFrame, 82, 30, COLOR_GOOD)
	CreatePillTextLabel(pillFrame, 113, 14, COLOR_MUTED).Text = "ms"

	screenGui.Parent = hostParent

	local cam = Workspace.CurrentCamera
	if cam then
		table.insert(WatermarkState.Connections, cam:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateWatermarkScale))
	end

	-- Mouse & Touch Dragging
	local dragging = false
	local dragTouchInput = nil
	local dragStartMouse = Vector2.zero
	local dragStartPos = pillFrame.Position

	table.insert(WatermarkState.Connections, pillFrame.InputBegan:Connect(function(inputObj)
		if dragging or inputObj.UserInputState ~= Enum.UserInputState.Begin then
			return
		end
		local isMouse = (inputObj.UserInputType == Enum.UserInputType.MouseButton1)
		local isTouch = (inputObj.UserInputType == Enum.UserInputType.Touch)
		if not isMouse and not isTouch then
			return
		end
		dragging = true
		dragTouchInput = isTouch and inputObj or nil
		dragStartMouse = Vector2.new(inputObj.Position.X, inputObj.Position.Y)
		dragStartPos = pillFrame.Position
	end))

	table.insert(WatermarkState.Connections, UserInputService.InputChanged:Connect(function(inputObj)
		if not dragging or not WatermarkState.PillFrame then
			return
		end
		if dragTouchInput and inputObj ~= dragTouchInput then
			return
		elseif not dragTouchInput and inputObj.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end
		local delta = Vector2.new(inputObj.Position.X, inputObj.Position.Y) - dragStartMouse
		pillFrame.Position = UDim2.new(
			dragStartPos.X.Scale,
			dragStartPos.X.Offset + delta.X,
			dragStartPos.Y.Scale,
			dragStartPos.Y.Offset + delta.Y
		)
	end))

	table.insert(WatermarkState.Connections, UserInputService.InputEnded:Connect(function(inputObj)
		if not dragging then
			return
		end
		local endedDrag = (dragTouchInput and inputObj == dragTouchInput)
			or (not dragTouchInput and inputObj.UserInputType == Enum.UserInputType.MouseButton1)
		if endedDrag then
			dragging = false
			dragTouchInput = nil
			if WatermarkState.PillFrame then
				WatermarkState.SavedPosition = WatermarkState.PillFrame.Position
			end
		end
	end))

	-- Lightweight EMA FPS & Ping Updater (text updated only 5x/sec)
	table.insert(WatermarkState.Connections, RunService.RenderStepped:Connect(function(deltaTime)
		if not FpsManager.Config.ShowWatermark or not WatermarkState.FpsValueLabel then
			return
		end
		local clampedDt = math.clamp(tonumber(deltaTime) or (1 / 60), 0.001, 1.0)
		local instantFps = 1 / clampedDt
		if WatermarkState.SmoothedFps <= 0 then
			WatermarkState.SmoothedFps = instantFps
		else
			WatermarkState.SmoothedFps = WatermarkState.SmoothedFps
				+ (instantFps - WatermarkState.SmoothedFps) * (1 - math.exp(-clampedDt * 8))
		end

		local nowClock = os.clock()
		if nowClock < WatermarkState.NextTextTickAt then
			return
		end
		WatermarkState.NextTextTickAt = nowClock + 0.2

		local roundedFps = math.floor(WatermarkState.SmoothedFps + 0.5)
		local fpsText = tostring(roundedFps)
		if fpsText ~= WatermarkState.LastFpsStr then
			WatermarkState.LastFpsStr = fpsText
			WatermarkState.FpsValueLabel.Text = fpsText
			WatermarkState.FpsValueLabel.TextColor3 = GetFpsStatusColor(roundedFps)
		end

		local rawPing = 0
		pcall(function()
			local net = StatsService.Network
			local item = (net.ServerStatsItem and net.ServerStatsItem["Data Ping"])
				or (net.ServerStats and net.ServerStats.Ping)
			if item then
				rawPing = item:GetValue()
			end
		end)
		local roundedPing = math.floor((tonumber(rawPing) or 0) + 0.5)
		local pingText = tostring(roundedPing)
		if pingText ~= WatermarkState.LastPingStr then
			WatermarkState.LastPingStr = pingText
			WatermarkState.PingValueLabel.Text = pingText
			WatermarkState.PingValueLabel.TextColor3 = GetPingStatusColor(roundedPing)
		end
	end))
end

local function SetWatermarkEnabled(enableWm)
	FpsManager.Config.ShowWatermark = (enableWm == true)
	if FpsManager.Config.ShowWatermark then
		BuildWatermarkGui()
	else
		DestroyWatermarkGui()
	end
end

-- ============================================================================
-- 4. MULTI-GAME ANTI-AFK ENGINE (Idled Disable + VirtualUser + Custom AFK Stub)
-- ============================================================================

local AfkState = {
	SilencedConnections = {},
	PatchedUpvalues = {},
	IdledFallbackConn = nil,
}

local NoOpTeleportStub = setmetatable({}, {
	__index = function()
		return function() end
	end,
})

local function ApplyAntiAfkProtection()
	if not FpsManager.Config.AntiAfk or not LocalPlayer then
		return
	end
	if type(getconnections) == "function" then
		local callOk, idledList = pcall(getconnections, LocalPlayer.Idled)
		if callOk and type(idledList) == "table" then
			for _, connItem in ipairs(idledList) do
				if pcall(function()
					connItem:Disable()
				end) then
					table.insert(AfkState.SilencedConnections, connItem)
				end
			end
		end
	end

	-- Patch custom game AntiAFK TeleportService kick upvalues if present
	if #AfkState.PatchedUpvalues == 0
		and type(getgc) == "function"
		and type(islclosure) == "function"
		and type(debug) == "table"
		and type(debug.getupvalues) == "function"
		and type(debug.setupvalue) == "function"
	then
		pcall(function()
			local gcFunctions = getgc(false)
			if type(gcFunctions) ~= "table" then
				return
			end
			for _, fnObj in ipairs(gcFunctions) do
				if type(fnObj) == "function" and islclosure(fnObj) then
					local infoOk, srcName = pcall(debug.info, fnObj, "s")
					if infoOk and type(srcName) == "string" and string.find(srcName, "AntiAFK", 1, true) then
						local upOk, upvals = pcall(debug.getupvalues, fnObj)
						if upOk and type(upvals) == "table" then
							for upIdx, upVal in pairs(upvals) do
								if typeof(upVal) == "Instance" and upVal.ClassName == "TeleportService" then
									if pcall(debug.setupvalue, fnObj, upIdx, NoOpTeleportStub) then
										table.insert(AfkState.PatchedUpvalues, {
											Fn = fnObj,
											Index = upIdx,
											Original = upVal,
										})
									end
								end
							end
						end
					end
				end
			end
		end)
	end

	-- Universal VirtualUser fallback for executors without getconnections
	if not AfkState.IdledFallbackConn and LocalPlayer.Idled then
		AfkState.IdledFallbackConn = TrackConnection(LocalPlayer.Idled:Connect(function()
			if not FpsManager.Config.AntiAfk then
				return
			end
			pcall(function()
				local virtualUser = game:GetService("VirtualUser")
				virtualUser:CaptureController()
				virtualUser:ClickButton2(Vector2.zero)
			end)
		end))
	end
end

local function RestoreAntiAfkProtection()
	for _, connItem in ipairs(AfkState.SilencedConnections) do
		pcall(function()
			connItem:Enable()
		end)
	end
	table.clear(AfkState.SilencedConnections)

	for _, patchEntry in ipairs(AfkState.PatchedUpvalues) do
		pcall(debug.setupvalue, patchEntry.Fn, patchEntry.Index, patchEntry.Original)
	end
	table.clear(AfkState.PatchedUpvalues)
end

local function SetAntiAfkEnabled(enableAfk)
	FpsManager.Config.AntiAfk = (enableAfk ~= false)
	if FpsManager.Config.AntiAfk then
		ApplyAntiAfkProtection()
	else
		RestoreAntiAfkProtection()
	end
end

if LocalPlayer and LocalPlayer.CharacterAdded then
	TrackConnection(LocalPlayer.CharacterAdded:Connect(function()
		task.delay(1.0, function()
			if not FpsManager.Disposed and FpsManager.Config.AntiAfk then
				table.clear(AfkState.SilencedConnections)
				pcall(ApplyAntiAfkProtection)
			end
		end)
	end))
end

task.spawn(function()
	while not FpsManager.Disposed do
		if FpsManager.Config.AntiAfk then
			pcall(ApplyAntiAfkProtection)
		end
		task.wait(600)
	end
end)

-- ============================================================================
-- 5. N3 HUB MANAGER PUBLIC API (SetLibrary, SetIcon, BuildPerformanceSection, ApplyToTab)
-- ============================================================================

function FpsManager:Unload()
	if self.Disposed then
		return
	end
	self.Disposed = true
	self.Config.ShowWatermark = false
	self.Config.Optimizer = false
	self.Config.Disable3DRender = false
	self.Config.AntiAfk = false

	pcall(DestroyWatermarkGui)
	pcall(SetOptimizerEnabled, false)
	pcall(Set3DRenderDisabled, false)
	pcall(RestoreAntiAfkProtection)

	for _, connObj in ipairs(Connections) do
		pcall(connObj.Disconnect, connObj)
	end
	table.clear(Connections)
end

function FpsManager:SetLibrary(libraryInstance)
	self.Library = libraryInstance
	if libraryInstance and type(libraryInstance.OnUnload) == "function" then
		pcall(function()
			libraryInstance:OnUnload(function()
				self:Unload()
			end)
		end)
	end
end

function FpsManager:SetIcon(customIcon)
	if type(customIcon) == "string" and customIcon ~= "" then
		self.Icon = customIcon
	end
end

function FpsManager:BuildPerformanceSection(targetTab, useRightSide)
	if not targetTab then
		return nil
	end
	local addGroupMethod = useRightSide and targetTab.AddRightGroupbox or targetTab.AddLeftGroupbox
	if type(addGroupMethod) ~= "function" then
		return nil
	end

	local perfGroup = addGroupMethod(targetTab, "Performance", self.Icon)

	-- 1. FPS Cap
	perfGroup:AddSlider("FpsManager_FpsCap", {
		Text = "FPS Cap",
		Min = 30,
		Max = 1000,
		Default = self.Config.FpsCap,
		Rounding = 0,
		Suffix = " FPS",
		Tooltip = "Limits maximum frame rate (requires setfpscap support)",
		Callback = function(sliderVal)
			self.Config.FpsCap = math.clamp(math.floor(tonumber(sliderVal) or 240), 30, 1000)
			ApplyEffectiveFpsCap()
		end,
	})

	-- 2. Optimizer
	perfGroup:AddToggle("FpsManager_Optimizer", {
		Text = "Optimizer",
		Default = self.Config.Optimizer,
		Tooltip = "Strips shadows, textures and heavy effects for maximum FPS",
		Callback = function(isEnabled)
			self.Config.Optimizer = (isEnabled == true)
			SetOptimizerEnabled(self.Config.Optimizer)
		end,
	})

	-- 3. FPS And Ping
	perfGroup:AddToggle("FpsManager_FpsAndPing", {
		Text = "FPS And Ping",
		Default = self.Config.ShowWatermark,
		Tooltip = "Displays a draggable live FPS & Ping ms counter pill",
		Callback = function(isEnabled)
			SetWatermarkEnabled(isEnabled == true)
		end,
	})

	-- 4. FPS And Ping Size
	perfGroup:AddSlider("FpsManager_FpsAndPingSize", {
		Text = "FPS And Ping Size",
		Min = 60,
		Max = 160,
		Default = self.Config.WatermarkSize,
		Rounding = 0,
		Suffix = "%",
		Tooltip = "Adjusts the size of the floating FPS & Ping counter",
		Callback = function(sliderVal)
			local pct = math.clamp(tonumber(sliderVal) or 100, 60, 160)
			self.Config.WatermarkSize = pct
			WatermarkState.SizeMultiplier = pct / 100
			UpdateWatermarkScale()
		end,
	})

	-- 5. Disable 3D Render
	perfGroup:AddToggle("FpsManager_Disable3DRender", {
		Text = "Disable 3D Render",
		Default = self.Config.Disable3DRender,
		Tooltip = "Turns off 3D rendering for ultra-low CPU/GPU AFK farming",
		Callback = function(isEnabled)
			self.Config.Disable3DRender = (isEnabled == true)
			Set3DRenderDisabled(self.Config.Disable3DRender)
		end,
	})

	-- 6. Anti AFK
	perfGroup:AddToggle("FpsManager_AntiAfk", {
		Text = "Anti AFK",
		Default = self.Config.AntiAfk,
		Tooltip = "Prevents Roblox's 20-minute idle disconnect across any game",
		Callback = function(isEnabled)
			SetAntiAfkEnabled(isEnabled == true)
		end,
	})

	-- Initialize default active features cleanly
	SetWatermarkEnabled(self.Config.ShowWatermark)
	SetAntiAfkEnabled(self.Config.AntiAfk)

	return perfGroup
end

function FpsManager:ApplyToTab(targetTab)
	return self:BuildPerformanceSection(targetTab, false)
end

return FpsManager
