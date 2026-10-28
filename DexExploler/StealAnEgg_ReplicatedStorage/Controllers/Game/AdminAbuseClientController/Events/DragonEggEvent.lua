-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.DragonEggEvent
-- Decompile time: 33.62 ms

local u129, v1
local CollectionService = game:GetService("CollectionService")
game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Game = ReplicatedStorage.Controllers:FindFirstChild("Game")
local Plots = Game and Game:FindFirstChild("Plots")
local v2 = Plots and Plots:FindFirstChild("ActiveAssetsController")
if v2 ~= nil then
    local success, err = pcall(require, v2)
    u129 = if not success then nil else err
else
    u129 = nil
end
local u130 = {}
local u131 = {Cutscene1 = true, Cutscene2 = true, ZoneReveal = true}
local u395 = {Cutscene1 = true, Tutorial = true, Steal = true}
local u133 = {}
local u134 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local LocalPlayer = Players.LocalPlayer
local u149 = Trove.new()
local u397 = false
local u151 = nil
local u153 = Trove.new()
local u154 = nil
local u394 = (Workspace:WaitForChild("World")):WaitForChild("Build")
local u398 = GUI.TutorialInstructions()
assert(u398:IsA("ScreenGui"), "TutorialInstructions must be a ScreenGui")
local u399 = false
local u400 = false
local Enabled = u398.Enabled
local u187 = CameraShaker.new()
local u188 = false
local u189 = nil
local u190 = nil
local u191 = nil
local u192 = nil

local function resolveMarker() -- Line: 143 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("AdminAbuseEggSpawn")
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function resolveWall() -- Line: 154 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("WallStartVisual")
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function resolveShot(a1, a2, a3) -- Line: 165 -- types: a1: vector, a2: number, a3: number?
    local v1 = Vector3.new(-1, 0, 0)
    if v1.Magnitude <= 0 then
        v1 = Vector3.new(-1, 0, 0)
    end
    return CFrame.lookAt(
        a1 + (v1.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * (math.max(a2 / 0.8, a3 or 70) * 0.5 / 0.3152987888789835),
        a1
    )
end

local function resolveModelSubject(a1) -- Line: 185 -- upvalues: Workspace (val) -- types: a1: string
    local v1 = Workspace:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Model") then
        local BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
        return BoundingBox.Position, BoundingBox_2.Y
    end
    return nil, nil
end

local u197 = {}

local function resolveSubject(a1) -- Line: 199 -- upvalues: Workspace (val), u197 (val) -- types: a1: userdata
    local BoundingBox_3, BoundingBox_4, Position_2, Y_2
    local Attribute = Workspace:GetAttribute("DragonEventCutsceneBeat")
    local v1 = if type(Attribute) ~= "string" then nil else u197[Attribute]
    if v1 ~= nil then
        local Position, Y
        local v2 = Workspace:FindFirstChild(v1.Name)
        if v2 == nil or not v2:IsA("Model") then
            Position = nil
            Y = nil
        else
            local BoundingBox, BoundingBox_2 = v2:GetBoundingBox()
            Position = BoundingBox.Position
            Y = BoundingBox_2.Y
        end
        if Position ~= nil and Y ~= nil then
            return Position + Vector3.new(0, v1.FocusLift or 0, 0), Y, v1.MinFramedHeight
        end
    end
    local v3 = {"DragonCutscene", "DragonModel"}
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = Workspace:FindFirstChild(j)
        if v1 == nil or not v1:IsA("Model") then
            Position_2 = nil
            Y_2 = nil
        else
            BoundingBox_3, BoundingBox_4 = v1:GetBoundingBox()
            Position_2 = BoundingBox_3.Position
            Y_2 = BoundingBox_4.Y
        end
        if Position_2 ~= nil and Y_2 ~= nil then
            return Position_2, Y_2
        end
    end
    return a1.Position, 70
end

local function restoreCamera() -- Line: 221 -- upvalues: Workspace (val), LocalPlayer (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.FieldOfView = 70
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Humanoid ~= nil then
        CurrentCamera.CameraSubject = Humanoid
    end
end

local function ensureOverlay() -- Line: 237 -- upvalues: u189 (ref), LocalPlayer (val)
    local v1 = u189
    if v1 ~= nil and v1.Gui.Parent ~= nil then
        return v1
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DragonCinematic"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 50
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Vignette"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://104574024062008"
    ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
    ImageLabel.ImageTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.ZIndex = 1
    ImageLabel.Parent = ScreenGui

    local function bar(a1, a2) -- Line: 260 -- upvalues: ScreenGui (val) -- types: a1: string, a2: CFrame
        local Frame = Instance.new("Frame")
        Frame.Name = a1
        Frame.BackgroundColor3 = Color3.new(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.fromScale(1, 0.11)
        Frame.Position = a2
        Frame.ZIndex = 2
        Frame.Parent = ScreenGui
        return Frame
    end

    local v2 = bar("Top", UDim2.fromScale(0, -0.11))
    local v3 = bar("Bottom", UDim2.fromScale(0, 1))
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v4 = {Gui = ScreenGui, Top = v2, Bottom = v3, Vignette = ImageLabel}
    u189 = v4
    return v4
end

local function setOverlayShown(a1) -- Line: 280
    -- upvalues: ensureOverlay (val), TweenService (val)
    local v1 = ensureOverlay()
    local v2 = TweenInfo.new(0.9, Enum.EasingStyle.Quint, if not a1 then Enum.EasingDirection.In else Enum.EasingDirection.Out)
    local Top = v1.Top
    local v3 = {}
    local v4 = if not a1 then UDim2.fromScale(0, -0.11) else UDim2.fromScale(0, 0)
    v3.Position = v4
    TweenService:Create(Top, v2, v3):Play()
    local Bottom = v1.Bottom
    v3 = {}
    v4 = if not a1 then UDim2.fromScale(0, 1) else UDim2.fromScale(0, 0.89)
    v3.Position = v4
    TweenService:Create(Bottom, v2, v3):Play()
    local Vignette = v1.Vignette
    TweenService:Create(Vignette, v2, {ImageTransparency = if not a1 then 1 else 0.3}):Play()
end

local function hideAllUi() -- Line: 305
    -- upvalues: u190 (ref), u191 (ref), Tabs (val), LocalPlayer (val), u134 (val), StarterGui (val), u192 (ref)
    if u190 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "DragonCinematic" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u190 = v1
    pcall(function() -- Line: 320 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u134 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u192 = v1
end

local function restoreAllUi() -- Line: 330
    -- upvalues: u190 (ref), u191 (ref), LocalPlayer (val), u192 (ref), StarterGui (val)
    local v1 = u190
    local v2 = u191
    u190 = nil
    u191 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 343 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u192
    u192 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 355 -- upvalues: u151 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u151 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 362 -- upvalues: restoreAllUi (val), u151 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u151
    u151 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function easeInOutCubic(a1) -- Line: 374 -- types: a1: number
    if a1 < 0.5 then
        return a1 * 4 * a1 * a1
    end
    return 1 - (a1 * -2 + 2) ^ 3 / 2
end

local function handheldNoise(a1, a2) -- Line: 379 -- types: a1: number, a2: number
    return ((math.noise(a1 * 0.22, a2 * 7.31, 0.5)) + math.noise(a1 * 1.1, a2 * 7.31 + 3.17, 9.5) * 0.22) / 1.22 * 2
end

local function handheldOffset(a1, a2) -- Line: 386 -- types: a1: number, a2: number
    local v1 = ((math.noise(a1 * 0.22, 7.31, 0.5)) + math.noise(a1 * 1.1, 10.48, 9.5) * 0.22) / 1.22 * 2 * 0.038397243543875255 * a2
    local v2 = ((math.noise(a1 * 0.22, 14.62, 0.5)) + math.noise(a1 * 1.1, 17.79, 9.5) * 0.22) / 1.22 * 2 * 0.026179938779914945 * a2
    local v3 = ((math.noise(a1 * 0.22, 21.93, 0.5)) + math.noise(a1 * 1.1, 25.1, 9.5) * 0.22) / 1.22 * 2 * 0.010471975511965976 * a2
    return (CFrame.new((Vector3.new(
        ((math.noise(a1 * 0.22, 29.24, 0.5)) + math.noise(a1 * 1.1, 32.41, 9.5) * 0.22) / 1.22 * 2 * 0.25,
        ((math.noise(a1 * 0.22, 36.55, 0.5)) + math.noise(a1 * 1.1, 39.72, 9.5) * 0.22) / 1.22 * 2 * 0.20000000298023224,
        ((math.noise(a1 * 0.22, 43.86, 0.5)) + (math.noise(a1 * 1.1, 47.03, 9.5)) * 0.22) / 1.22 * 2 * 0.10000000149011612
    )) * a2)) * CFrame.Angles(0, v1, 0) * CFrame.Angles(v2, 0, v3)
end

local function stopCutscene() -- Line: 398
    -- upvalues: u397 (ref), RunService (val), setOverlayShown (val), Workspace (val), LocalPlayer (val)
    -- upvalues: restoreAllUi (val), u151 (ref), Tabs (val)
    if not u397 then
        return
    end
    u397 = false
    RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
    setOverlayShown(false)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            CurrentCamera.CameraSubject = Humanoid
        end
    end
    local v1 = restoreAllUi()
    local v2 = u151
    u151 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function resolveZoneBounds() -- Line: 410 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("CherryBlossom")
    local Bounds = v1 and v1:FindFirstChild("Bounds")
    if Bounds ~= nil and Bounds:IsA("BasePart") then
        return Bounds
    end
    return nil
end

local function startZoneRevealCutscene() -- Line: 422
    -- upvalues: resolveZoneBounds (val), Workspace (val), u397 (ref), u151 (ref), HiddenUIHandler (val)
    -- upvalues: hideAllUi (val), setOverlayShown (val), RunService (val), handheldOffset (val)
    -- upvalues: CameraShakerDriver (val), u187 (val)
    local v1 = resolveZoneBounds()
    local CurrentCamera = Workspace.CurrentCamera
    if v1 ~= nil and CurrentCamera ~= nil then
        u397 = true
        if u151 == nil then
            HiddenUIHandler.Acquire()
        end
        hideAllUi()
        setOverlayShown(true)
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.FieldOfView = 60
        local Position = v1.Position
        v1 = Position + Vector3.new(120, 10, 0)
        local u25 = CFrame.lookAt(Position + Vector3.new(-400, 28, 0), v1)
        local u30 = CFrame.lookAt(Position + Vector3.new(-240, 18, 0), v1)
        local u33 = os.clock()
        RunService:BindToRenderStep("DragonEventCutsceneCamera", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 444
            -- upvalues: u397 (upval), CurrentCamera (val), u33 (val), u25 (val), u30 (val), handheldOffset (upval)
            -- upvalues: CameraShakerDriver (upval), u187 (upval)
            if not u397 then
                return
            end
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v1 = os.clock() - u33
            local v2 = math.clamp(v1 / 9, 0, 1)
            local v3 = if not (v2 < 0.5) then 1 - (v2 * -2 + 2) ^ 3 / 2 else v2 * 4 * v2 * v2
            v2 = math.clamp(v1 / 1.5, 0, 1)
            CurrentCamera.CFrame = (u25:Lerp(u30, v3)) * handheldOffset(v1, v2) * CameraShakerDriver.Advance(u187, a1)
        end)
        return
    end
end

local function startCutscene(a1) -- Line: 460
    -- upvalues: u397 (ref), startZoneRevealCutscene (val), u151 (ref), HiddenUIHandler (val), hideAllUi (val)
    -- upvalues: u149 (val), restoreAllUi (val), Tabs (val), Workspace (val), setOverlayShown (val), RunService (val)
    -- upvalues: resolveSubject (val), u133 (val), handheldOffset (val), CameraShakerDriver (val), u187 (val)
    if u397 then
        return
    end
    if a1 == "ZoneReveal" then
        startZoneRevealCutscene()
        return
    end
    if a1 == "Cutscene1" then
        if u151 == nil then
            u151 = HiddenUIHandler.Acquire()
        end
        hideAllUi()
        local u15 = require(script.CutscenePart1)(u149)
        task.spawn(function() -- Line: 473 -- upvalues: u15 (val), u397 (upval), restoreAllUi (upval), u151 (upval), Tabs (upval)
            u15.Run()
            if not u397 then
                local v1 = restoreAllUi()
                local v2 = u151
                u151 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
            end
        end)
        return
    end
    if a1 == "Cutscene2" then
        if u151 == nil then
            u151 = HiddenUIHandler.Acquire()
        end
        hideAllUi()
        local u30 = require(script.CutscenePart2)(u149)
        task.spawn(function() -- Line: 485 -- upvalues: u30 (val), u397 (upval), restoreAllUi (upval), u151 (upval), Tabs (upval)
            u30.Run()
            if not u397 then
                local v1 = restoreAllUi()
                local v2 = u151
                u151 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
            end
        end)
        return
    end
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("AdminAbuseEggSpawn")
    local u57 = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1
    local CurrentCamera = Workspace.CurrentCamera
    if u57 ~= nil and CurrentCamera ~= nil then
        u397 = true
        if u151 == nil then
            HiddenUIHandler.Acquire()
        end
        hideAllUi()
        setOverlayShown(true)
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.FieldOfView = 80
        local Position = u57.Position
        local v2 = Vector3.new(-1, 0, 0)
        if v2.Magnitude <= 0 then
            v2 = Vector3.new(-1, 0, 0)
        end
        local u91 = CFrame.lookAt(Position + (v2.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * 138.75727260339056, Position)
        CurrentCamera.CFrame = u91
        local u93 = u91
        local u94 = 80
        local u96 = os.clock()
        local Attribute = Workspace:GetAttribute("DragonEventCutsceneBeat")
        local u103 = os.clock()
        local u104 = nil
        RunService:BindToRenderStep("DragonEventCutsceneCamera", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 523
            -- upvalues: u397 (upval), CurrentCamera (val), Workspace (upval), Attribute (ref), u93 (ref), u91 (ref)
            -- upvalues: u94 (ref), u96 (ref), u104 (ref), resolveSubject (upval), u57 (val), u133 (upval), u103 (val)
            -- upvalues: handheldOffset (upval), CameraShakerDriver (upval), u187 (upval)
            if not u397 then
                return
            end
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local Attribute_2 = Workspace:GetAttribute("DragonEventCutsceneBeat")
            if Attribute_2 ~= Attribute then
                Attribute = Attribute_2
                u93 = u91
                u94 = CurrentCamera.FieldOfView
                u96 = os.clock()
                u104 = nil
            end
            local v1, v2, v3 = resolveSubject(u57)
            local v4 = u104
            v4 = if v4 ~= nil then v4:Lerp(v1, 1 - (math.exp(-a1 / 0.18))) else v1
            u104 = v4
            local v5 = Vector3.new(-1, 0, 0)
            if v5.Magnitude <= 0 then
                v5 = Vector3.new(-1, 0, 0)
            end
            local Unit = v5.Unit
            local v6 = math.max(v2 / 0.8, v3 or 70) * 0.5 / 0.3152987888789835
            v1 = CFrame.lookAt(v4 + (Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * v6, v4)
            v4 = if type(Attribute_2) ~= "string" then 1.6 else if u133[Attribute_2] == nil then 1.6 else u133[Attribute_2]
            local v7 = math.clamp((os.clock() - u96) / v4, 0, 1)
            v3 = if not (v7 < 0.5) then 1 - (v7 * -2 + 2) ^ 3 / 2 else v7 * 4 * v7 * v7
            u91 = u93:Lerp(v1, v3)
            v4 = os.clock() - u103
            v2 = math.clamp(v4 / 1.5, 0, 1)
            CurrentCamera.CFrame = u91 * handheldOffset(v4, v2) * CameraShakerDriver.Advance(u187, a1)
            CurrentCamera.FieldOfView = u94 + (35 - u94) * v3
        end)
        return
    end
end

local function preloadCutsceneAssets() -- Line: 566 -- upvalues: u188 (ref)
    if u188 then
        return
    end
    u188 = true
end

local function setNightGuiHidden(a1) -- Line: 573 -- upvalues: LocalPlayer (val) -- types: a1: boolean
    local PlayerGui = LocalPlayer.PlayerGui
    local ResetStartTimer = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if ResetStartTimer ~= nil and ResetStartTimer:IsA("SurfaceGui") then
        ResetStartTimer.Enabled = not a1
    end
end

local function destroyTutorial() -- Line: 581 -- upvalues: u154 (ref), u153 (val)
    u154 = nil
    u153:Clean()
end

local function showTutorial() -- Line: 586
    -- upvalues: u154 (ref), Workspace (val), u153 (val), RunService (val), AreaEggCycle (val), LocalPlayer (val)
    if u154 ~= nil then
        return
    end
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("WallStartVisual")
    if (if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1) == nil then
        return
    end
    local v2 = script.WallStartVisual:Clone()
    u153:Add(v2)
    v2.Parent = Workspace
    u154 = v2
    local Main = v2.SurfaceGui.Main
    local Title = Main.Title
    local TimerLabel = Main.TimerLabel
    local u41 = nil
    u153:Add((RunService.Heartbeat:Connect(function() -- Line: 607
        -- upvalues: Workspace (upval), AreaEggCycle (upval), Title (val), u41 (ref), TimerLabel (val)
        -- upvalues: LocalPlayer (upval)
        local ServerTimeNow = Workspace:GetServerTimeNow()
        Title.Text = if not (AreaEggCycle.IsNightPhase(ServerTimeNow)) then "Time Remaining" else "Starting in"
        local v1 = AreaEggCycle.SecondsUntilPhaseEnd(ServerTimeNow)
        local v2 = math.floor(v1 / 60)
        local v3 = math.floor(v1 % 60)
        if v1 < 1 then
            u41 = ServerTimeNow
        end
        if not u41 then
            TimerLabel.Text = string.format("%d:%02d", v2, v3)
        else
            TimerLabel.Text = "GET READY!!!"
            if 7 < ServerTimeNow - u41 then
                u41 = nil
            end
        end
        local PlayerGui = LocalPlayer.PlayerGui
        v2 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
        if v2 ~= nil and v2:IsA("SurfaceGui") then
            v2.Enabled = false
        end
    end)))
    u153:Add(function() -- Line: 631 -- upvalues: LocalPlayer (upval)
        local PlayerGui = LocalPlayer.PlayerGui
        local ResetStartTimer = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
        if ResetStartTimer ~= nil and ResetStartTimer:IsA("SurfaceGui") then
            ResetStartTimer.Enabled = true
        end
    end)
end

local function setPetsHidden(a1) -- Line: 634 -- upvalues: u129 (val) -- types: a1: boolean
    local v1 = u129
    if v1 == nil then
        return
    end
    pcall(v1.SetAllPetsHidden, a1)
end

local function isInsideCherryBlossom() -- Line: 647
    -- upvalues: resolveZoneBounds (val), Player (val), LocalPlayer (val)
    local v1 = resolveZoneBounds()
    if v1 == nil then
        return false
    end
    local v2 = Player.FindPrimaryPart(LocalPlayer)
    if v2 == nil then
        return false
    end
    local v3 = v1.CFrame:PointToObjectSpace(v2.Position)
    local v4 = false
    if (math.abs(v3.X)) <= v1.Size.X / 2 then
        v4 = (math.abs(v3.Z)) <= v1.Size.Z / 2
    end
    return v4
end

local function isInBloom(a1) -- Line: 661
    -- upvalues: Save (val), SakuraBloomPolicy (val), Workspace (val), Sakura (val), isInsideCherryBlossom (val)
    local v1 = Save.IsLoaded()
    if not SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) then
        return false
    end
    local Attribute = Workspace:GetAttribute(Sakura.Bloom.EndsAtAttribute)
    local v2 = false
    if typeof(Attribute) == "number" then
        v2 = false
        if a1 < Attribute then
            v2 = isInsideCherryBlossom()
        end
    end
    return v2
end

local function onPhaseChanged() -- Line: 672
    -- upvalues: Workspace (val), u131 (val), startCutscene (val), u397 (ref), RunService (val), setOverlayShown (val)
    -- upvalues: LocalPlayer (val), restoreAllUi (val), u151 (ref), Tabs (val), showTutorial (val), u154 (ref)
    -- upvalues: u153 (val), isInBloom (val), AreaEggCycle (val), u399 (ref), u400 (ref), Enabled (ref), u395 (val)
    -- upvalues: u129 (val), PlacedEggRenderer (val)
    local Character, CurrentCamera, Humanoid, v1, v2
    local Attribute = Workspace:GetAttribute("DragonEventPhase")
    if Attribute == nil then
        if u397 then
            u397 = false
            RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
            setOverlayShown(false)
            CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil then
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.FieldOfView = 70
                Character = LocalPlayer.Character
                Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Humanoid ~= nil then
                    CurrentCamera.CameraSubject = Humanoid
                end
            end
            v1 = restoreAllUi()
            v2 = u151
            u151 = nil
            if v2 ~= nil then
                v2()
            end
            if v1 ~= nil then
                Tabs.Activate(v1, {instant = true})
            end
        end
    elseif u131[Attribute] then
        startCutscene(Attribute)
    elseif u397 then
        u397 = false
        RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
        setOverlayShown(false)
        CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            Character = LocalPlayer.Character
            Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid ~= nil then
                CurrentCamera.CameraSubject = Humanoid
            end
        end
        v1 = restoreAllUi()
        v2 = u151
        u151 = nil
        if v2 ~= nil then
            v2()
        end
        if v1 ~= nil then
            Tabs.Activate(v1, {instant = true})
        end
    end
    v1 = true
    if Attribute ~= "Tutorial" then
        v1 = Attribute == "Steal"
    end
    if not v1 then
        u154 = nil
        u153:Clean()
    else
        showTutorial()
    end
    pcall(function() -- Line: 688
        -- upvalues: LocalPlayer (upval), Attribute (val), Workspace (upval), isInBloom (upval), AreaEggCycle (upval)
        -- upvalues: u399 (upval), u400 (upval), Enabled (upval)
        LocalPlayer.PlayerGui.DragonEggEventUI.Enabled = Attribute == "Steal"
        task.spawn(function() -- Line: 691
            -- upvalues: Attribute (upval), LocalPlayer (upval), Workspace (upval), isInBloom (upval)
            -- upvalues: AreaEggCycle (upval), u399 (upval), u400 (upval), Enabled (upval)
            if Attribute == "Steal" then
                local ServerTimeNow
                while LocalPlayer.PlayerGui.DragonEggEventUI.Enabled do
                    task.wait(1)
                    ServerTimeNow = Workspace:GetServerTimeNow()
                    if not isInBloom(ServerTimeNow)
                        and not AreaEggCycle.IsNightPhase(ServerTimeNow)
                        and AreaEggCycle.IsCloseToReset(AreaEggCycle.SecondsUntilPhaseEnd(ServerTimeNow))
                        and not u399
                        and not u400
                        and not Enabled then
                        LocalPlayer.PlayerGui.DragonEggEventUI.Enabled = false
                    end
                end
            end
        end)
    end)
    v1 = false
    if Attribute ~= nil then
        v1 = u395[Attribute] == true
    end
    local PlayerGui = LocalPlayer.PlayerGui
    local ResetStartTimer = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if ResetStartTimer ~= nil and ResetStartTimer:IsA("SurfaceGui") then
        ResetStartTimer.Enabled = not v1
    end
    v2 = u129
    if v2 ~= nil then
        pcall(v2.SetAllPetsHidden, v1)
    end
    PlacedEggRenderer.SetAllHidden(v1)
end

local v3 = {
    StartEvent = function(a1, a2, a3) end,
    StopEvent = function(a1) -- Line: 747
        -- upvalues: u397 (ref), RunService (val), setOverlayShown (val), Workspace (val), LocalPlayer (val)
        -- upvalues: restoreAllUi (val), u151 (ref), Tabs (val), u154 (ref), u153 (val), u129 (val)
        -- upvalues: PlacedEggRenderer (val)
        local v1, v2
        if u397 then
            u397 = false
            RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
            setOverlayShown(false)
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil then
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.FieldOfView = 70
                local Character = LocalPlayer.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Humanoid ~= nil then
                    CurrentCamera.CameraSubject = Humanoid
                end
            end
            v1 = restoreAllUi()
            v2 = u151
            u151 = nil
            if v2 ~= nil then
                v2()
            end
            if v1 ~= nil then
                Tabs.Activate(v1, {instant = true})
            end
        end
        u154 = nil
        u153:Clean()
        local PlayerGui = LocalPlayer.PlayerGui
        local ResetStartTimer = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
        if ResetStartTimer ~= nil and ResetStartTimer:IsA("SurfaceGui") then
            ResetStartTimer.Enabled = true
        end
        v1 = u129
        if v1 ~= nil then
            pcall(v1.SetAllPetsHidden, false)
        end
        PlacedEggRenderer.SetAllHidden(false)
        v1 = restoreAllUi()
        v2 = u151
        u151 = nil
        if v2 ~= nil then
            v2()
        end
        if v1 ~= nil then
            Tabs.Activate(v1, {instant = true})
        end
    end,
}
;(Workspace:GetAttributeChangedSignal("DragonEventPhase")):Connect(onPhaseChanged)
;(Workspace:GetAttributeChangedSignal("DragonEventCutsceneBeat")):Connect(function() -- Line: 716 -- upvalues: Workspace (val), u130 (val), u397 (ref), u187 (val)
    local Attribute = Workspace:GetAttribute("DragonEventCutsceneBeat")
    local v1 = if type(Attribute) ~= "string" then nil else u130[Attribute]
    if v1 ~= nil and u397 then
        u187:ShakeOnce(v1.Magnitude, v1.Roughness, v1.FadeIn, v1.FadeOut)
    end
end)
;(u394:GetAttributeChangedSignal("DragonEventMap")):Connect(function() -- Line: 724 -- upvalues: u394 (val), LightingController (val)
    if u394:GetAttribute("DragonEventMap") == true then
        LightingController.SetLayer("DragonEvent", "DragonEvent", 50, 2)
        return
    end
    LightingController.ClearLayer("DragonEvent", 2)
end)
;(CollectionService:GetInstanceAddedSignal("DragonNestGuideBeam")):Connect(function(a1) -- Line: 735 -- upvalues: LocalPlayer (val) -- types: a1: userdata
    if a1:IsA("Beam") then
        a1.Enabled = (a1:GetAttribute("Owner")) == LocalPlayer.UserId
    end
end)
for i, j in CollectionService:GetTagged("DragonNestGuideBeam") do
    if j:IsA("Beam") then
        v1 = (j:GetAttribute("Owner")) == LocalPlayer.UserId
        j.Enabled = v1
    end
end
EggState.CarryChanged:Connect(function(a1) -- Line: 764 -- upvalues: u399 (ref)
    u399 = a1.IsCarrying
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 766 -- upvalues: u400 (ref) -- types: a1: string?
    u400 = a1 ~= nil
end)
;(u398:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 769 -- upvalues: Enabled (ref), u398 (val)
    Enabled = u398.Enabled
end)
LocalPlayer.CharacterAdded:Connect(function() -- Line: 771 -- upvalues: u397 (ref), Workspace (val), LocalPlayer (val), u395 (val)
    if not u397 then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid ~= nil then
                CurrentCamera.CameraSubject = Humanoid
            end
        end
    end
    local Attribute = Workspace:GetAttribute("DragonEventPhase")
    local v1 = false
    if Attribute ~= nil then
        v1 = u395[Attribute] == true
    end
    local PlayerGui = LocalPlayer.PlayerGui
    local ResetStartTimer = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if ResetStartTimer ~= nil and ResetStartTimer:IsA("SurfaceGui") then
        ResetStartTimer.Enabled = not v1
    end
end)
onPhaseChanged()
if u394:GetAttribute("DragonEventMap") ~= true then
    LightingController.ClearLayer("DragonEvent", 2)
else
    LightingController.SetLayer("DragonEvent", "DragonEvent", 50, 2)
end
return v3