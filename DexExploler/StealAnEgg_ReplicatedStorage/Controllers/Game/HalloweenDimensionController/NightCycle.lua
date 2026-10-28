-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.NightCycle
-- Decompile time: 14.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local AreaEggResetCycleController = require(ReplicatedStorage.Controllers.Game.AreaReset.AreaEggResetCycleController)
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
require(ReplicatedStorage.Packages.Trove)
local WallTimer = require(script.Parent.WallTimer)
local LocalPlayer = Players.LocalPlayer
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u64 = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u69 = TweenInfo.new(AreaEggResetWall.CollapseSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v1 = {}

local function isNight(a1) -- Line: 49 -- types: a1: string?
    local v1 = true
    if a1 ~= "Night" then
        v1 = a1 == "NightTransition"
    end
    return v1
end

local function bindSky(a1) -- Line: 53
    -- upvalues: AreaEggResetCycleController (val), LocalPlayer (val), PlayerAttributes (val), LightingController (val)
    -- upvalues: AreaEggResetCycle (val)
    local u3 = AreaEggResetCycleController.GetPhase()

    local function sync(a1) -- Line: 56
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), u3 (ref), LightingController (upval)
        -- upvalues: AreaEggResetCycle (upval)
        local v1 = LocalPlayer
        if v1:GetAttribute(PlayerAttributes.Inside) == true then
            local v2 = u3
            v1 = true
            if v2 ~= "Night" then
                v1 = v2 == "NightTransition"
            end
            if v1 then
                LightingController.SetLayer("HalloweenDimensionNight", AreaEggResetCycle.NightLighting, 155, a1)
                return
            end
        end
        LightingController.ClearLayer("HalloweenDimensionNight", a1)
    end

    a1:Connect(AreaEggResetCycleController.PhaseChanged, function(a1, a2) -- Line: 72
        -- upvalues: u3 (ref), LocalPlayer (upval), PlayerAttributes (upval), LightingController (upval)
        -- upvalues: AreaEggResetCycle (upval)
        local v1 = LocalPlayer
        if v1:GetAttribute(PlayerAttributes.Inside) == true then
            local v2 = a1
            v1 = true
            if v2 ~= "Night" then
                v1 = v2 == "NightTransition"
            end
            if v1 then
                LightingController.SetLayer("HalloweenDimensionNight", AreaEggResetCycle.NightLighting, 155, a2)
                return
            end
        end
        LightingController.ClearLayer("HalloweenDimensionNight", a2)
    end)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Inside), function() -- Line: 77
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), u3 (ref), LightingController (upval)
        -- upvalues: AreaEggResetCycle (upval)
        local v1 = LocalPlayer
        if v1:GetAttribute(PlayerAttributes.Inside) == true then
            local v2 = u3
            v1 = true
            if v2 ~= "Night" then
                v1 = v2 == "NightTransition"
            end
            if v1 then
                LightingController.SetLayer("HalloweenDimensionNight", AreaEggResetCycle.NightLighting, 155, 0.8)
                return
            end
        end
        LightingController.ClearLayer("HalloweenDimensionNight", 0.8)
    end)
    a1:Add(function() -- Line: 80 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("HalloweenDimensionNight", 0)
    end)
    local v1 = LocalPlayer
    if not (v1:GetAttribute(PlayerAttributes.Inside) == true) then
        LightingController.ClearLayer("HalloweenDimensionNight", 0)
    else
        local v2 = u3
        v1 = true
        if v2 ~= "Night" then
            v1 = v2 == "NightTransition"
        end
        if not v1 then
            LightingController.ClearLayer("HalloweenDimensionNight", 0)
        else
            LightingController.SetLayer("HalloweenDimensionNight", AreaEggResetCycle.NightLighting, 155, 0)
        end
    end
end

local function bindWall(a1, a2) -- Line: 86
    -- upvalues: LocalPlayer (val), Workspace (val), RunService (val), TweenService (val), u64 (val), u69 (val)
    -- upvalues: AreaEggResetWall (val), WallTimer (val)
    local u2 = {}
    local u3 = {}
    local u4 = false
    local u10 = a2:Add((Instance.new("NumberValue")))
    local u13 = a2:Extend()
    local u15 = OverlapParams.new()
    u15.FilterType = Enum.RaycastFilterType.Include

    local function hiddenModifier() -- Line: 96 -- upvalues: u10 (val)
        if 0 < u10.Value then
            return 0
        end
        return 1
    end

    local function applyCurtain(a1) -- Line: 100 -- upvalues: u10 (val) -- types: a1: table
        local v1 = math.clamp(a1.Height * u10.Value, 0, a1.Height)
        a1.Part.Size = a1.Footprint + Vector3.new(0, 1, 0) * v1
        a1.Part.CFrame = a1.Floor * CFrame.new(0, v1 * 0.5, 0)
        a1.Part.LocalTransparencyModifier = if not (0 < u10.Value) then 1 else 0
    end

    local function setSolid(a1) -- Line: 117 -- upvalues: u4 (ref), u3 (val) -- types: a1: boolean
        u4 = a1
        for i in u3 do
            i.CanCollide = a1
        end
    end

    local function characterInside() -- Line: 124
        -- upvalues: LocalPlayer (upval), u15 (val), u3 (val), Workspace (upval)
        local v1
        local Character = LocalPlayer.Character
        if Character == nil then
            return false
        end
        u15.FilterDescendantsInstances = {Character}
        for i in u3 do
            v1 = i.Size + Vector3.new(1, 1, 1)
            if #Workspace:GetPartBoundsInBox(i.CFrame, v1, u15) > 0 then
                return true
            end
        end
        return false
    end

    local function solidifyWhenClear() -- Line: 139
        -- upvalues: characterInside (val), u4 (ref), u3 (val), u13 (val), RunService (upval)
        if characterInside() then
            local u13_2 = nil
            u13:Connect(RunService.Heartbeat, function() -- Line: 145 -- upvalues: characterInside (upval), u13_2 (ref), u4 (upval), u3 (upval)
                if characterInside() then
                    return
                end
                u13_2:Disconnect()
                u4 = true
                for i in u3 do
                    i.CanCollide = true
                end
            end)
            return
        end
        u4 = true
        for i in u3 do
            i.CanCollide = true
        end
    end

    local function sweep(a1, a2) -- Line: 154
        -- upvalues: u13 (val), TweenService (upval), u10 (val)
        u13:Add(TweenService:Create(u10, a1, {Value = a2}), "Cancel"):Play()
    end

    local function seal(a1) -- Line: 159
        -- upvalues: u13 (val), u4 (ref), u3 (val), characterInside (val), RunService (upval), u10 (val), u64 (upval)
        -- upvalues: TweenService (upval)
        u13:Clean()
        u4 = false
        for i in u3 do
            i.CanCollide = false
        end
        if characterInside() then
            local u28 = nil
            u13:Connect(RunService.Heartbeat, function() -- Line: 145 -- upvalues: characterInside (upval), u28 (ref), u4 (upval), u3 (upval)
                if characterInside() then
                    return
                end
                u28:Disconnect()
                u4 = true
                for i in u3 do
                    i.CanCollide = true
                end
            end)
        else
            u4 = true
            for j in u3 do
                j.CanCollide = true
            end
        end
        if not a1 then
            u10.Value = 1
            return
        end
        u10.Value = 0
        u13:Add(TweenService:Create(u10, u64, {Value = 1}), "Cancel"):Play()
    end

    local function open(a1) -- Line: 171
        -- upvalues: u13 (val), u4 (ref), u3 (val), u69 (upval), TweenService (upval), u10 (val)
        u13:Clean()
        u4 = false
        for i in u3 do
            i.CanCollide = false
        end
        if a1 then
            u13:Add(TweenService:Create(u10, u69, {Value = 0}), "Cancel"):Play()
            return
        end
        u10.Value = 0
    end

    local function isWallPart(a1_2) -- Line: 181 -- upvalues: a1 (val) -- types: a1_2: userdata
        local Parent = a1_2.Parent
        local v1 = a1_2:IsA("BasePart")
        if v1 then
            v1 = false
            if Parent ~= nil then
                v1 = false
                if Parent.Name == "NightWall" then
                    v1 = Parent.Parent == a1
                end
            end
        end
        return v1
    end

    local function track(a1_2) -- Line: 189
        -- upvalues: a1 (val), u2 (val), applyCurtain (val), u3 (val), u4 (ref), u10 (val)
        local Parent = a1_2.Parent
        local v1 = a1_2:IsA("BasePart")
        if v1 then
            v1 = false
            if Parent ~= nil then
                v1 = false
                if Parent.Name == "NightWall" then
                    v1 = Parent.Parent == a1
                end
            end
        end
        if not v1 then
            return
        end
        if a1_2.Name == "Curtain" and u2[a1_2] == nil then
            local Y = a1_2.Size.Y
            local v2 = {
                Part = a1_2,
                Footprint = a1_2.Size * Vector3.new(1, 0, 1),
                Height = Y,
                Floor = a1_2.CFrame * CFrame.new(0, -Y * 0.5, 0),
            }
            u2[a1_2] = v2
            applyCurtain(v2)
            return
        end
        if a1_2.Name == "Barrier" and u3[a1_2] == nil then
            u3[a1_2] = true
            a1_2.CanCollide = u4
            a1_2.LocalTransparencyModifier = if not (0 < u10.Value) then 1 else 0
        end
    end

    local function timerCurtain() -- Line: 218 -- upvalues: u2 (val)
        local v1 = nil
        local v2 = nil
        local v3 = nil
        for i, j in u2, v2, v3 do
            if v1 == nil or v1.Footprint.X < j.Footprint.X then
                v1 = j
            end
        end
        if v1 ~= nil then
            return v1.Part
        end
        return nil
    end

    for i, j in a1:GetDescendants() do
        track(j)
    end
    a2:Connect(a1.DescendantAdded, track)
    a2:Connect(a1.DescendantRemoving, function(a1) -- Line: 211 -- upvalues: u2 (val), u3 (val) -- types: a1: userdata
        if a1:IsA("BasePart") then
            u2[a1] = nil
            u3[a1] = nil
        end
    end)
    a2:Connect(u10.Changed, function() -- Line: 107 -- upvalues: u2 (val), applyCurtain (val), u10 (val), u3 (val)
        for i, j in u2 do
            applyCurtain(j)
        end
        local v1 = if not (0 < u10.Value) then 1 else 0
        for k in u3 do
            k.LocalTransparencyModifier = v1
        end
    end)
    a2:Connect(AreaEggResetWall.Changed, function(a1) -- Line: 235
        -- upvalues: u13 (val), u4 (ref), u3 (val), characterInside (val), RunService (upval), u10 (val), u64 (upval)
        -- upvalues: TweenService (upval), u69 (upval)
        if not a1 then
            u13:Clean()
            u4 = false
            for i in u3 do
                i.CanCollide = false
            end
            u13:Add(TweenService:Create(u10, u69, {Value = 0}), "Cancel"):Play()
            return
        end
        u13:Clean()
        u4 = false
        for j in u3 do
            j.CanCollide = false
        end
        if characterInside() then
            local u28 = nil
            u13:Connect(RunService.Heartbeat, function() -- Line: 145 -- upvalues: characterInside (upval), u28 (ref), u4 (upval), u3 (upval)
                if characterInside() then
                    return
                end
                u28:Disconnect()
                u4 = true
                for i in u3 do
                    i.CanCollide = true
                end
            end)
        else
            u4 = true
            for k in u3 do
                k.CanCollide = true
            end
        end
        u10.Value = 0
        u13:Add(TweenService:Create(u10, u64, {Value = 1}), "Cancel"):Play()
    end)
    a2:Add(function() -- Line: 242 -- upvalues: u4 (ref), u3 (val)
        u4 = false
        for i in u3 do
            i.CanCollide = false
        end
    end)
    if not AreaEggResetWall.IsSealed() then
        u13:Clean()
        for k in u3 do
            k.CanCollide = false
        end
        u10.Value = 0
    else
        u13:Clean()
        u4 = false
        for n in u3 do
            n.CanCollide = false
        end
        if characterInside() then
            local u108 = nil
            u13:Connect(RunService.Heartbeat, function() -- Line: 145 -- upvalues: characterInside (val), u108 (ref), u4 (ref), u3 (val)
                if characterInside() then
                    return
                end
                u108:Disconnect()
                u4 = true
                for i in u3 do
                    i.CanCollide = true
                end
            end)
        else
            for m in u3 do
                m.CanCollide = true
            end
        end
        u10.Value = 1
    end
    for i5, i6 in u2 do
        applyCurtain(i6)
    end
    local v1 = if not (0 < u10.Value) then 1 else 0
    for i7 in u3 do
        i7.LocalTransparencyModifier = v1
    end
    WallTimer.Bind(a2, timerCurtain)
end

local function bindMaps(a1) -- Line: 256 -- upvalues: bindWall (val), Workspace (val), HalloweenDimension (val)
    local u1 = nil
    local u2 = nil

    local function unbind() -- Line: 260 -- upvalues: u1 (ref), u2 (ref), a1 (val)
        local v1 = u1
        u1 = nil
        u2 = nil
        if v1 ~= nil then
            a1:Remove(v1)
        end
    end

    local function bind(a1_2) -- Line: 269
        -- upvalues: u1 (ref), u2 (ref), a1 (val), bindWall (upval)
        local v1 = u1
        u1 = nil
        u2 = nil
        if v1 ~= nil then
            a1:Remove(v1)
        end
        v1 = a1:Extend()
        u1 = v1
        u2 = a1_2
        bindWall(a1_2, v1)
    end

    a1:Connect(Workspace.ChildAdded, function(a1_2) -- Line: 277
        -- upvalues: HalloweenDimension (upval), u1 (ref), u2 (ref), a1 (val), bindWall (upval)
        if a1_2.Name == HalloweenDimension.MapName and a1_2:IsA("Model") then
            local v1 = u1
            u1 = nil
            u2 = nil
            if v1 ~= nil then
                a1:Remove(v1)
            end
            v1 = a1:Extend()
            u1 = v1
            u2 = a1_2
            bindWall(a1_2, v1)
        end
    end)
    a1:Connect(Workspace.ChildRemoved, function(a1_2) -- Line: 282 -- upvalues: u2 (ref), u1 (ref), a1 (val) -- types: a1_2: userdata
        if a1_2 == u2 then
            local v1 = u1
            u1 = nil
            u2 = nil
            if v1 ~= nil then
                a1:Remove(v1)
            end
        end
    end)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    if v1 ~= nil and v1:IsA("Model") then
        local v2 = u1
        if v2 ~= nil then
            a1:Remove(v2)
        end
        v2 = a1:Extend()
        bindWall(v1, v2)
    end
end

function v1.Start(a1) -- Line: 298 -- upvalues: bindSky (val), bindMaps (val)
    bindSky(a1)
    bindMaps(a1)
end

return v1