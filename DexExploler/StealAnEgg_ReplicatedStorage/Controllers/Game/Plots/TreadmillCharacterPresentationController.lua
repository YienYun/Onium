-- Script path: ReplicatedStorage.Controllers.Game.Plots.TreadmillCharacterPresentationController
-- Decompile time: 18.54 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local Cameras = require(PlayerScripts.PlayerModule):GetCameras()
local u62 = nil
local u63 = nil
local u64 = nil
local u65 = 0
local u66 = {}
local u67 = {}
local u68 = {}

local function restoreSnapshot(a1) -- Line: 69 -- types: a1: table
    for k, v in pairs(a1.PartStates) do
        if k.Parent ~= nil then
            k.Transparency = v
        end
    end
end

local function restoreActiveSnapshot() -- Line: 77 -- upvalues: u63 (ref)
    local v1 = u63
    u63 = nil
    if v1 == nil then
        return
    end
    v1.DescendantTrove:Destroy()
    for k, v in pairs(v1.PartStates) do
        if k.Parent ~= nil then
            k.Transparency = v
        end
    end
end

local function restoreBillboardAlwaysOnTop(a1, a2) -- Line: 89
    -- upvalues: u66 (val)
    if u66[a1] ~= a2 then
        return
    end
    u66[a1] = nil
    if a1.Parent ~= nil and a1.AlwaysOnTop == false then
        a1.AlwaysOnTop = a2
    end
end

local function setBillboardNotAlwaysOnTop(a1) -- Line: 100
    -- upvalues: t (val), u62 (ref), u66 (val)
    t.strict(t.instanceIsA("BillboardGui"))(a1)
    local v1 = u62
    if v1 ~= nil and u66[a1] == nil then
        local AlwaysOnTop = a1.AlwaysOnTop
        u66[a1] = AlwaysOnTop
        a1.AlwaysOnTop = false
        v1:Connect(a1:GetPropertyChangedSignal("AlwaysOnTop"), function() -- Line: 111 -- upvalues: a1 (val), u66 (upval)
            if a1.AlwaysOnTop ~= false then
                u66[a1] = nil
            end
        end)
        v1:Add(function() -- Line: 116 -- upvalues: a1 (val), AlwaysOnTop (val), u66 (upval)
            local v1 = a1
            local v2 = AlwaysOnTop
            if u66[v1] ~= v2 then
                return
            end
            u66[v1] = nil
            if v1.Parent ~= nil and v1.AlwaysOnTop == false then
                v1.AlwaysOnTop = v2
            end
        end)
        return
    end
end

local function restoreHumanoidDisplayDistanceType(a1, a2) -- Line: 119 -- upvalues: u67 (val) -- types: a1: userdata
    if u67[a1] ~= a2 then
        return
    end
    u67[a1] = nil
    if a1.Parent ~= nil and a1.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
        a1.DisplayDistanceType = a2
    end
end

local function hideVisibleHumanoidDisplayDistance(a1) -- Line: 136
    -- upvalues: t (val), u62 (ref), u67 (val)
    t.strict(t.instanceIsA("Humanoid"))(a1)
    local v1 = u62
    if v1 ~= nil and u67[a1] == nil then
        local DisplayDistanceType = a1.DisplayDistanceType
        if DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
            return
        end
        u67[a1] = DisplayDistanceType
        a1.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        v1:Connect(a1:GetPropertyChangedSignal("DisplayDistanceType"), function() -- Line: 151 -- upvalues: a1 (val), u67 (upval)
            if a1.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
                u67[a1] = nil
            end
        end)
        v1:Add(function() -- Line: 157 -- upvalues: a1 (val), DisplayDistanceType (val), u67 (upval)
            local v1 = a1
            local v2 = DisplayDistanceType
            if u67[v1] ~= v2 then
                return
            end
            u67[v1] = nil
            if v1.Parent ~= nil and v1.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
                v1.DisplayDistanceType = v2
            end
        end)
        return
    end
end

local function getCameraTransparency(a1) -- Line: 161 -- types: a1: number
    if a1 <= 5 then
        return 1
    end
    return (math.clamp(1 - (a1 - 5) / 8, 0, 1))
end

local function trackCharacterPart(a1, a2) -- Line: 171 -- types: a1: table, a2: userdata
    if not a2:IsA("BasePart") or a2:FindFirstAncestorWhichIsA("Tool") ~= nil or a1.PartStates[a2] ~= nil then
        return
    end
    a1.PartStates[a2] = a2.Transparency
end

local function bindCharacter(a1) -- Line: 187 -- upvalues: u62 (ref), u63 (ref) -- types: a1: userdata
    local v1 = u62
    if v1 == nil then
        return
    end
    local v2 = u63
    u63 = nil
    if v2 ~= nil then
        v2.DescendantTrove:Destroy()
        for k, v in pairs(v2.PartStates) do
            if k.Parent ~= nil then
                k.Transparency = v
            end
        end
    end
    local u20 = {Character = a1}
    u20.DescendantTrove = v1:Extend()
    u20.PartStates = {}
    u63 = u20
    for i, i2 in ipairs(a1:GetDescendants()) do
        if i2:IsA("BasePart") and i2:FindFirstAncestorWhichIsA("Tool") == nil and u20.PartStates[i2] == nil then
            u20.PartStates[i2] = i2.Transparency
        end
    end
    u20.DescendantTrove:Connect(a1.DescendantAdded, function(a1) -- Line: 208 -- upvalues: u20 (val) -- types: a1: userdata
        local v1 = u20
        if not a1:IsA("BasePart") or a1:FindFirstAncestorWhichIsA("Tool") ~= nil or v1.PartStates[a1] ~= nil then
            return
        end
        v1.PartStates[a1] = a1.Transparency
    end)
end

local function updateCharacterTransparency() -- Line: 212
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), u63 (ref)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = Player.FindHead(LocalPlayer)
    if CurrentCamera ~= nil and v1 ~= nil then
        local v2 = u63
        local Parent = v1.Parent
        if v2 ~= nil and Parent == v2.Character then
            local Magnitude = (CurrentCamera.CFrame.Position - v1.Position).Magnitude
            v1 = if not (Magnitude <= 5) then math.clamp(1 - (Magnitude - 5) / 8, 0, 1) else 1
            for k, v in pairs(v2.PartStates) do
                if k.Parent ~= nil then
                    k.Transparency = math.max(v, v1)
                else
                    v2.PartStates[k] = nil
                end
            end
            return
        end
        return
    end
end

local function resolveCurrentTransparency() -- Line: 237
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), u63 (ref)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = Player.FindHead(LocalPlayer)
    if CurrentCamera ~= nil and v1 ~= nil then
        local v2 = u63
        if v2 ~= nil and v1.Parent == v2.Character then
            local Magnitude = (CurrentCamera.CFrame.Position - v1.Position).Magnitude
            if Magnitude <= 5 then
                return 1
            end
            return (math.clamp(1 - (Magnitude - 5) / 8, 0, 1))
        end
        return nil
    end
    return nil
end

local function restoreAutoCameraState() -- Line: 253 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

local function commitAutoCameraDistance(a1) -- Line: 260 -- upvalues: Cameras (val) -- types: a1: userdata
    Cameras:CommitCameraCFrame(a1, Enum.CameraType.Custom)
end

local function completeAutoCameraState(a1) -- Line: 264
    -- upvalues: u64 (ref), Cameras (val), Workspace (val)
    local v1 = u64
    u64 = nil
    if v1 == nil then
        return
    end
    Cameras:CommitCameraCFrame(a1, Enum.CameraType.Custom)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

local function clearAutoCameraState() -- Line: 275 -- upvalues: u64 (ref), Workspace (val)
    local v1 = u64
    u64 = nil
    if v1 == nil then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

local function resolveAutoCameraFocusPoint(a1, a2) -- Line: 285 -- types: a1: userdata, a2: vector
    return a1.CFrame:PointToWorldSpace(a2)
end

local function resolveAutoCameraTargetCFrame(a1, a2) -- Line: 289 -- types: a1: userdata, a2: vector
    local v1 = a1.Position - a2
    if v1.Magnitude <= 0.001 then
        v1 = -a1.CFrame.LookVector
    end
    v1 = a2 - v1.Unit * 1.8
    return CFrame.lookAt(v1, a1.Position + Vector3.new(0, 0.11999999731779099, 0), (Vector3.new(0, 1, 0)))
end

local function updateAutoCamera() -- Line: 304
    -- upvalues: u64 (ref), Workspace (val), Player (val), LocalPlayer (val), TweenService (val), Cameras (val)
    local v1 = u64
    if v1 == nil then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    local v2 = Player.FindHead(LocalPlayer)
    local v3 = Player.FindRootPart(LocalPlayer)
    local VideoScreenPart = v1.VideoScreenPart
    if CurrentCamera ~= nil and v2 ~= nil and v3 ~= nil then
        if VideoScreenPart == nil then
            return
        end
        if VideoScreenPart.Parent == nil then
            v2 = u64
            u64 = nil
            if v2 == nil then
                return
            end
            local CurrentCamera_2 = Workspace.CurrentCamera
            if CurrentCamera_2 ~= nil and CurrentCamera_2.CameraType == Enum.CameraType.Scriptable then
                CurrentCamera_2.CameraType = Enum.CameraType.Custom
            end
            return
        end
        local v4 = v3.CFrame:PointToWorldSpace(v1.FocusOffset)
        local v5 = VideoScreenPart.Position - v4
        if v5.Magnitude <= 0.001 then
            v5 = -VideoScreenPart.CFrame.LookVector
        end
        v5 = v4 - v5.Unit * 1.8
        v3 = CFrame.lookAt(v5, VideoScreenPart.Position + Vector3.new(0, 0.11999999731779099, 0), (Vector3.new(0, 1, 0)))
        v4 = math.clamp((os.clock() - v1.StartedAt) / 0.35, 0, 1)
        CurrentCamera.CFrame = v1.InitialCameraCFrame:Lerp(v3, (TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))
        if v4 >= 1 then
            local v6 = u64
            u64 = nil
            if v6 == nil then
                return
            end
            Cameras:CommitCameraCFrame(v3, Enum.CameraType.Custom)
            local CurrentCamera_3 = Workspace.CurrentCamera
            if CurrentCamera_3 ~= nil and CurrentCamera_3.CameraType == Enum.CameraType.Scriptable then
                CurrentCamera_3.CameraType = Enum.CameraType.Custom
            end
        end
        return
    end
end

local function findActiveTreadmill(a1) -- Line: 344 -- upvalues: CollectionService (val) -- types: a1: string
    for i, j in CollectionService:GetTagged("ActiveTreadmill") do
        if j:GetAttribute("ActiveTreadmillId") == a1 then
            return j
        end
    end
    return nil
end

local function bindAutoCameraScreen(a1, a2) -- Line: 353
    -- upvalues: findActiveTreadmill (val), u64 (ref), TreadmillUtil (val), Workspace (val)
    local v1 = findActiveTreadmill(a1)
    local v2 = ("No active treadmill is bound for \"%*\""):format(a1)
    assert(v1 ~= nil, v2)
    assert(v1:IsA("Tool"), (("Runtime treadmill \"%*\" must be a Tool"):format(a1)))
    local v3 = u64
    if v3 ~= nil and v3.Token == a2 then
        local v4 = TreadmillUtil.FindVideoFeedScreenPart(v1)
        if v4 ~= nil then
            v3.VideoScreenPart = v4
            return
        end
        v1 = u64
        u64 = nil
        if v1 == nil then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
        return
    end
end

local function bindPlayerDisplayDistance(a1) -- Line: 371
    -- upvalues: t (val), u62 (ref), Player (val), hideVisibleHumanoidDisplayDistance (val)
    t.strict(t.instanceIsA("Player"))(a1)
    local u10 = u62
    if u10 == nil then
        return
    end
    local v1 = Player.FindHumanoid(a1)
    if v1 ~= nil then
        hideVisibleHumanoidDisplayDistance(v1)
    end

    local function bindPlayerCharacterDisplayDistance(a1_2) -- Line: 384
        -- upvalues: t (upval), Player (upval), a1 (val), hideVisibleHumanoidDisplayDistance (upval), u10 (val)
        t.strict(t.instanceIsA("Model"))(a1_2)
        local v1 = Player.FindHumanoid(a1)
        if v1 ~= nil then
            hideVisibleHumanoidDisplayDistance(v1)
        end
        u10:Connect(a1_2.ChildAdded, function(a1) -- Line: 392 -- upvalues: hideVisibleHumanoidDisplayDistance (upval) -- types: a1: userdata
            if a1:IsA("Humanoid") then
                hideVisibleHumanoidDisplayDistance(a1)
            end
        end)
    end

    if a1.Character ~= nil then
        bindPlayerCharacterDisplayDistance(a1.Character)
    end
    u10:Connect(a1.CharacterAdded, bindPlayerCharacterDisplayDistance)
end

local function bindHumanoidDisplayPresentation() -- Line: 405
    -- upvalues: u62 (ref), Players (val), bindPlayerDisplayDistance (val)
    local v1 = u62
    if v1 == nil then
        return
    end
    for i, v in ipairs(Players:GetPlayers()) do
        task.defer(bindPlayerDisplayDistance, v)
    end
    v1:Connect(Players.PlayerAdded, bindPlayerDisplayDistance)
end

local function bindYourBaseBillboardPresentation() -- Line: 417
    -- upvalues: u62 (ref), PlotState (val), setBillboardNotAlwaysOnTop (val)
    local v1 = u62
    if v1 == nil then
        return
    end
    local v2 = PlotState.FindLocalBaseSign()
    if v2 ~= nil then
        setBillboardNotAlwaysOnTop(v2)
    end
    v1:Add((PlotState.LocalPlotChanged:Connect(function() -- Line: 423 -- upvalues: PlotState (upval), setBillboardNotAlwaysOnTop (upval)
        local v1 = PlotState.FindLocalBaseSign()
        if v1 ~= nil then
            setBillboardNotAlwaysOnTop(v1)
        end
    end)))
end

function u68.Stop() -- Line: 438 -- upvalues: u65 (ref), u64 (ref), Workspace (val), u62 (ref), u63 (ref)
    u65 = u65 + 1
    local v1 = u64
    u64 = nil
    if v1 ~= nil then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
    v1 = u62
    u62 = nil
    if v1 ~= nil then
        v1:Destroy()
        return
    end
    local v2 = u63
    u63 = nil
    if v2 == nil then
        return
    end
    v2.DescendantTrove:Destroy()
    for k, v in pairs(v2.PartStates) do
        if k.Parent ~= nil then
            k.Transparency = v
        end
    end
end

function u68.StopCameraTransparency() -- Line: 452 -- upvalues: u68 (val)
    u68.Stop()
end

function u68.Start(a1) -- Line: 456
    -- upvalues: t (val), u68 (val), u65 (ref), Trove (val), u62 (ref), Workspace (val), Player (val), LocalPlayer (val)
    -- upvalues: Cameras (val), TreadmillFlags (val), u64 (ref), bindAutoCameraScreen (val), bindCharacter (val)
    -- upvalues: updateAutoCamera (val), updateCharacterTransparency (val), bindHumanoidDisplayPresentation (val)
    -- upvalues: PlotState (val), setBillboardNotAlwaysOnTop (val), restoreActiveSnapshot (val)
    -- upvalues: clearAutoCameraState (val)
    t.strict(t.string)(a1)
    u68.Stop()
    u65 = u65 + 1
    local v1 = u65
    local v2 = Trove.new()
    local CurrentCamera = Workspace.CurrentCamera
    local v3 = Player.FindRootPart(LocalPlayer)
    local CameraSubjectPosition = Cameras:GetCameraSubjectPosition(Enum.CameraType.Custom)
    if CurrentCamera ~= nil
        and CameraSubjectPosition ~= nil
        and v3 ~= nil
        and not TreadmillFlags.CameraAutoFrameDisabled:Get() then
        u64 = {
            FocusOffset = v3.CFrame:PointToObjectSpace(CameraSubjectPosition),
            InitialCameraCFrame = CurrentCamera.CFrame,
            StartedAt = os.clock(),
            Token = v1,
        }
        task.spawn(bindAutoCameraScreen, a1, v1)
    end
    local Character = LocalPlayer.Character
    if Character ~= nil then
        bindCharacter(Character)
    end
    v2:Connect(LocalPlayer.CharacterAdded, bindCharacter)
    v2:BindToRenderStep("TreadmillCameraAutoFrame", Enum.RenderPriority.Camera.Value + 1, updateAutoCamera)
    v2:BindToRenderStep("TreadmillCameraTransparency", Enum.RenderPriority.Camera.Value + 2, updateCharacterTransparency)
    bindHumanoidDisplayPresentation()
    local v4 = v2
    if v4 ~= nil then
        local v5 = PlotState.FindLocalBaseSign()
        if v5 ~= nil then
            setBillboardNotAlwaysOnTop(v5)
        end
        v4:Add((PlotState.LocalPlotChanged:Connect(function() -- Line: 423 -- upvalues: PlotState (upval), setBillboardNotAlwaysOnTop (upval)
            local v1 = PlotState.FindLocalBaseSign()
            if v1 ~= nil then
                setBillboardNotAlwaysOnTop(v1)
            end
        end)))
    end
    v2:Add(restoreActiveSnapshot)
    v2:Add(clearAutoCameraState)
end

function u68.StartCameraTransparency(a1) -- Line: 507 -- upvalues: u68 (val) -- types: a1: string
    u68.Start(a1)
end

function u68.IsLocalCharacterFullyTransparent() -- Line: 511
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), u63 (ref)
    local v1
    local CurrentCamera = Workspace.CurrentCamera
    local v2 = Player.FindHead(LocalPlayer)
    if CurrentCamera == nil then
        v1 = nil
    elseif v2 ~= nil then
        local v3 = u63
        if v3 == nil then
            v1 = nil
        elseif v2.Parent == v3.Character then
            local Magnitude = (CurrentCamera.CFrame.Position - v2.Position).Magnitude
            v1 = if not (Magnitude <= 5) then math.clamp(1 - (Magnitude - 5) / 8, 0, 1) else 1
        else
            v1 = nil
        end
    else
        v1 = nil
    end
    local v4 = false
    if v1 ~= nil then
        v4 = v1 >= 1
    end
    return v4
end

TreadmillFlags.CameraAutoFrameDisabled.Changed:Connect(function(a1) -- Line: 516 -- upvalues: u64 (ref), Workspace (val) -- types: a1: boolean
    if a1 then
        local v1 = u64
        u64 = nil
        if v1 == nil then
            return
        end
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
end)
return u68