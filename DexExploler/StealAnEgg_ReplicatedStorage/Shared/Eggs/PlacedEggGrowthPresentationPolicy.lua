-- Script path: ReplicatedStorage.Shared.Eggs.PlacedEggGrowthPresentationPolicy
-- Decompile time: 5.59 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local u36 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(script.Parent.EggRenderer)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
require(ReplicatedStorage.Shared.Types.Eggs)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local u72 = Log.new()
local u73 = {}

function u73.GetGrowthAlpha(a1, a2) -- Line: 42 -- upvalues: EggRecords (val), ServerClock (val) -- types: a2: number?
    return EggRecords.GrowthAlpha(a1, ServerClock.Now(), a1.GrowthSpeedMultiplier, a2)
end

function u73.GetDirectGrowthTweenRemainingSeconds(a1, a2) -- Line: 54 -- upvalues: EggRecords (val) -- types: a2: number
    local Placement = a1.Placement
    if Placement ~= nil and Placement.ReadyAt == nil then
        if 10 <= (EggRecords.GrowthDuration(a1)) then
            return 0
        end
        return EggRecords.WallSecondsRemaining(a1, a2, a1.GrowthSpeedMultiplier)
    end
    return 0
end

function u73.GetStartScale(a1) -- Line: 70 -- upvalues: EggScaling (val), EggRenderer (val)
    return EggScaling.PlacedStart(EggRenderer.GetAuthoredScale(a1), a1.AssetScale, a1.AssetCategory)
end

function u73.GetTargetScale(a1) -- Line: 78 -- upvalues: EggScaling (val), EggRenderer (val)
    return EggScaling.PlacedTarget(EggRenderer.GetAuthoredScale(a1), a1.AssetScale, a1.AssetCategory)
end

function u73.GetVisualScale(a1, a2, a3) -- Line: 86 -- upvalues: u73 (val) -- types: a2: number, a3: number
    return a2 + (u73.GetGrowthAlpha(a1, nil)) * (a3 - a2)
end

function u73.IsReady(a1, a2) -- Line: 95 -- upvalues: u73 (val) -- types: a2: number?
    return 1 <= (u73.GetGrowthAlpha(a1, a2))
end

function u73.GetRemainingGrowthSeconds(a1, a2) -- Line: 102
    -- upvalues: EggRecords (val), ServerClock (val)
    return EggRecords.GrowthSecondsRemaining(a1, ServerClock.Now(), a1.GrowthSpeedMultiplier, a2)
end

function u73.GetSkipReason(a1) -- Line: 114
    -- upvalues: t (val), Player (val), Players (val), Workspace (val), ModelBounds (val)
    local v1
    t.strict(t.instanceIsA("Model"))(a1)
    local v2 = Player.FindRootPart(Players.LocalPlayer)
    if v2 == nil then
        return "local player root is unavailable"
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return "current camera is unavailable"
    end
    local v3 = ModelBounds(a1)
    local Magnitude = (v2.Position - v3.Position).Magnitude
    if Magnitude > 300 then
        return (("distance %* studs exceeds %*"):format(math.round(Magnitude), 300))
    end
    _, v1 = CurrentCamera:WorldToViewportPoint(v3.Position)
    if not v1 then
        return "visible bounds center is off-screen"
    end
    return nil
end

function u73.GetGrowthScaleDeltaSkipReason(a1, a2) -- Line: 141
    -- upvalues: t (val), u36 (val)
    t.strict(u36)(a1)
    t.strict(u36)(a2)
    local v1 = math.abs(a2 - a1)
    if v1 <= 0.15 then
        return (("scale delta %* does not exceed %* presentation threshold"):format(math.round(v1 * 1000) / 1000, 0.15))
    end
    local v2 = v1 / math.max(math.abs(a1), 0.001)
    if v2 <= 0.03 then
        return (("relative scale delta %*%% does not exceed %*%% presentation threshold"):format(math.round(v2 * 10000) / 100, 3))
    end
    return nil
end

function u73.GetNaturalGrowthSkipReason(a1, a2) -- Line: 163
    -- upvalues: t (val), u36 (val), u73 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(u36)(a2)
    local v1 = u73.GetGrowthScaleDeltaSkipReason(a1:GetScale(), a2)
    if v1 ~= nil then
        return v1
    end
    return u73.GetSkipReason(a1)
end

function u73.LogSkipped(a1, a2, a3) -- Line: 179
    -- upvalues: t (val), u72 (val)
    t.strict(t.string)(a1)
    t.strict(t.string)(a2)
    t.strict(t.string)(a3)
    ;(u72:AtInfo()):Log((("Skipped placed egg %* for %*: %*"):format(a2, a1, a3)))
end

return u73