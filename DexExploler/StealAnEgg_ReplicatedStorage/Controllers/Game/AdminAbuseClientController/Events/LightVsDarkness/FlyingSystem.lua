-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.FlyingSystem
-- Decompile time: 7.96 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local u49 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u55 = TweenInfo.new(1.05, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u60 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local u62 = nil
local u65 = CameraShaker.new()
local u66 = 0
local u67 = 0
local u68 = nil
local identity = CFrame.identity
local u70 = nil
local u71 = nil

local function cancelCameraLead() -- Line: 63 -- upvalues: u70 (ref)
    local v1 = u70
    u70 = nil
    if v1 then
        v1:Cancel()
    end
end

local function settleCameraLead(a1, a2) -- Line: 71
    -- upvalues: u70 (ref), TweenService (val)
    local v1 = u70
    u70 = nil
    if v1 then
        v1:Cancel()
    end
    if a1.Parent == nil then
        return
    end
    v1 = TweenService:Create(a1, a2, {CameraOffset = Vector3.new(0, 0, 0)})
    u70 = v1
    v1:Play()
end

local function raiseCameraLead() -- Line: 81
    -- upvalues: Player (val), LocalPlayer (val), u70 (ref), u71 (ref), TweenService (val), u49 (val)
    -- upvalues: settleCameraLead (val), u55 (val)
    local u3 = Player.FindHumanoid(LocalPlayer)
    if u3 == nil then
        return
    end
    local v1 = u70
    u70 = nil
    if v1 then
        v1:Cancel()
    end
    u71 = u3
    local u16 = TweenService:Create(u3, u49, {CameraOffset = Vector3.new(0, 12, 0)})
    u70 = u16
    u16.Completed:Once(function(a1) -- Line: 92 -- upvalues: u70 (upval), u16 (val), settleCameraLead (upval), u3 (val), u55 (upval)
        if u70 == u16 and a1 == Enum.PlaybackState.Completed then
            settleCameraLead(u3, u55)
            return
        end
    end)
    u16:Play()
end

local function setFlyingVisuals(a1) -- Line: 105
    -- upvalues: raiseCameraLead (val), u71 (ref), Player (val), LocalPlayer (val), u70 (ref), settleCameraLead (val)
    -- upvalues: u60 (val)
    if a1 then
        raiseCameraLead()
        return
    end
    local v1 = u71 or Player.FindHumanoid(LocalPlayer)
    u71 = nil
    local v2 = u70
    u70 = nil
    if v2 then
        v2:Cancel()
    end
    if v1 ~= nil and v1.Parent ~= nil and v1.CameraOffset ~= Vector3.new(0, 0, 0) then
        settleCameraLead(v1, u60)
    end
end

local function isFlying() -- Line: 118 -- upvalues: LocalPlayer (val)
    return LocalPlayer:GetAttribute("LvdFlying") == true
end

local function rootJointOf(a1) -- Line: 123 -- types: a1: userdata
    local LowerTorso = a1:FindFirstChild("LowerTorso")
    local Root = if LowerTorso == nil then nil else LowerTorso:FindFirstChild("Root")
    if Root == nil then
        local v1 = a1:FindFirstChild("HumanoidRootPart")
        Root = if v1 == nil then nil else v1:FindFirstChild("RootJoint")
    end
    if Root ~= nil and Root:IsA("Motor6D") then
        return Root
    end
    return nil
end

local function releaseLean() -- Line: 135 -- upvalues: u68 (ref), identity (ref), u66 (ref), u67 (ref)
    local v1 = u68
    u68 = nil
    if v1 ~= nil and v1.Parent ~= nil then
        v1.C0 = identity
    end
    u66 = 0
    u67 = 0
end

local function trackLeanJoint(a1) -- Line: 146
    -- upvalues: u68 (ref), identity (ref), u66 (ref), u67 (ref)
    if u68 == a1 then
        return
    end
    local v1 = u68
    u68 = nil
    if v1 ~= nil and v1.Parent ~= nil then
        v1.C0 = identity
    end
    u66 = 0
    u67 = 0
    u68 = a1
    identity = a1.C0
end

local function stepLean(a1) -- Line: 155
    -- upvalues: Player (val), LocalPlayer (val), rootJointOf (val), u68 (ref), identity (ref), u66 (ref), u67 (ref)
    -- upvalues: LightVsDarknessEventFlags (val)
    local v1 = Player.FindCharacter(LocalPlayer)
    local v2 = Player.FindHumanoid(LocalPlayer)
    local v3 = Player.FindRootPart(LocalPlayer)
    local v4 = if v1 == nil then nil else rootJointOf(v1)
    if v4 ~= nil and v2 ~= nil and v3 ~= nil and v3:IsA("BasePart") then
        local v5
        if u68 ~= v4 then
            v5 = u68
            u68 = nil
            if v5 ~= nil and v5.Parent ~= nil then
                v5.C0 = identity
            end
            u66 = 0
            u67 = 0
            u68 = v4
            identity = v4.C0
        end
        v5 = 0
        local v6 = 0
        local MoveDirection = v2.MoveDirection
        if LocalPlayer:GetAttribute("LvdFlying") == true
            and 0 < v2.Health
            and 0.001 < MoveDirection.Magnitude
            and LightVsDarknessEventFlags.FlyingLeanEnabled:Get() then
            local CFrame_2 = v3.CFrame
            v5 = -0.7853981633974483 * CFrame_2.LookVector:Dot(MoveDirection)
            v6 = -0.2617993877991494 * CFrame_2.RightVector:Dot(MoveDirection)
        end
        local v7 = 1 - math.exp(a1 * -8)
        u66 = u66 + (v5 - u66) * v7
        u67 = u67 + (v6 - u67) * v7
        if (math.abs(u66)) < 0.001 and (math.abs(u67)) < 0.001 then
            u66 = 0
            u67 = 0
            v4.C0 = identity
            return
        end
        v4.C0 = identity * CFrame.Angles(u66, 0, u67)
        return
    end
    v1 = u68
    u68 = nil
    if v1 ~= nil and v1.Parent ~= nil then
        v1.C0 = identity
    end
    u66 = 0
    u67 = 0
end

local function start() -- Line: 195
    -- upvalues: u66 (ref), u67 (ref), u62 (ref), LocalPlayer (val), raiseCameraLead (val), u71 (ref), Player (val)
    -- upvalues: u70 (ref), settleCameraLead (val), u60 (val), RunService (val), stepLean (val), releaseLean (val)
    -- upvalues: Remotes (val), u65 (val)
    u66 = 0
    u67 = 0
    u62.AssetTrove:Connect(LocalPlayer:GetAttributeChangedSignal("LvdFlying"), function() -- Line: 197
        -- upvalues: LocalPlayer (upval), raiseCameraLead (upval), u71 (upval), Player (upval), u70 (upval)
        -- upvalues: settleCameraLead (upval), u60 (upval)
        if LocalPlayer:GetAttribute("LvdFlying") == true then
            raiseCameraLead()
            return
        end
        local v1 = u71 or Player.FindHumanoid(LocalPlayer)
        u71 = nil
        local v2 = u70
        u70 = nil
        if v2 then
            v2:Cancel()
        end
        if v1 ~= nil and v1.Parent ~= nil and v1.CameraOffset ~= Vector3.new(0, 0, 0) then
            settleCameraLead(v1, u60)
        end
    end)
    u62.AssetTrove:Connect(RunService.PreRender, stepLean)
    u62.AssetTrove:Add(releaseLean)
    u62.AssetTrove:Connect(Remotes.LightVsDarkness.Struck.OnClientEvent, function() -- Line: 203 -- upvalues: u65 (upval)
        u65:ShakeOnce(3, 12, 0.1, 0.8)
    end)
    if LocalPlayer:GetAttribute("LvdFlying") == true then
        raiseCameraLead()
        return
    end
    local v1 = u71 or Player.FindHumanoid(LocalPlayer)
    u71 = nil
    local v2 = u70
    u70 = nil
    if v2 then
        v2:Cancel()
    end
    if v1 ~= nil and v1.Parent ~= nil and v1.CameraOffset ~= Vector3.new(0, 0, 0) then
        settleCameraLead(v1, u60)
    end
end

local function stop() -- Line: 209
    -- upvalues: u68 (ref), identity (ref), u66 (ref), u67 (ref), u71 (ref), Player (val), LocalPlayer (val), u70 (ref)
    -- upvalues: settleCameraLead (val), u60 (val)
    local v1 = u68
    u68 = nil
    if v1 ~= nil and v1.Parent ~= nil then
        v1.C0 = identity
    end
    u66 = 0
    u67 = 0
    v1 = u71 or Player.FindHumanoid(LocalPlayer)
    u71 = nil
    local v2 = u70
    u70 = nil
    if v2 then
        v2:Cancel()
    end
    if v1 ~= nil and v1.Parent ~= nil and v1.CameraOffset ~= Vector3.new(0, 0, 0) then
        settleCameraLead(v1, u60)
    end
end

CameraShakerDriver.Start(u65, Enum.RenderPriority.Camera.Value + 2)
return function(a1) -- Line: 218 -- upvalues: u62 (ref), start (val), stop (val) -- types: a1: table
    u62 = a1
    return {Start = start, Stop = stop}
end