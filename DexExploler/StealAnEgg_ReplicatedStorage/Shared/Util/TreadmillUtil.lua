-- Script path: ReplicatedStorage.Shared.Util.TreadmillUtil
-- Decompile time: 14.57 ms

local TreadmillProgression = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).TreadmillProgression
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trails = require(ReplicatedStorage.Data.Trails)
local t = require(ReplicatedStorage.Packages.t)
local u46 = {
    DEFAULT_BASE_SPEED_POWER = TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED,
    DEFAULT_BASE_SPEED_POWER_PER_STEP = TreadmillProgression.DEFAULT_BASE_SPEED_POWER_PER_STEP,
    DEFAULT_SPEED_STEP_MULTIPLIER = TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER,
    TREADMILL_SPEED_GAIN_INTERVAL = TreadmillProgression.TREADMILL_SPEED_GAIN_INTERVAL,
    MAX_WALK_SPEED = TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED,
}
u46.MAX_SPEED_BOOST_TIER_INDEX = #TreadmillProgression.SPEED_BOOST_MULTIPLIERS_BY_TIER
require(ReplicatedStorage.Shared.Flags.BalanceConfig).Changed:Connect(function() -- Line: 29 -- upvalues: u46 (val), TreadmillProgression (val)
    u46.DEFAULT_BASE_SPEED_POWER = TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    u46.DEFAULT_BASE_SPEED_POWER_PER_STEP = TreadmillProgression.DEFAULT_BASE_SPEED_POWER_PER_STEP
    u46.DEFAULT_SPEED_STEP_MULTIPLIER = TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
    u46.TREADMILL_SPEED_GAIN_INTERVAL = TreadmillProgression.TREADMILL_SPEED_GAIN_INTERVAL
    u46.MAX_WALK_SPEED = TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED
    u46.MAX_SPEED_BOOST_TIER_INDEX = #TreadmillProgression.SPEED_BOOST_MULTIPLIERS_BY_TIER
end)

local function resolveCurveLevelFromCurveProgress(a1) -- Line: 46
    -- upvalues: TreadmillProgression (val)
    if a1 <= 0 then
        return 0
    end
    local v1 = 1 + (TreadmillProgression.CURVE_XP_GROWTH - 1) * a1 / TreadmillProgression.CURVE_BASE_XP
    if v1 <= 1 then
        return 0
    end
    return (math.log(v1)) / math.log(TreadmillProgression.CURVE_XP_GROWTH)
end

local function resolveReferenceWalkSpeed(a1) -- Line: 60 -- upvalues: TreadmillProgression (val) -- types: a1: number
    if a1 <= 0 then
        return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    end
    return (math.min(
        TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + a1 * TreadmillProgression.CURVE_SPEED_GAIN_PER_LEVEL,
        TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED
    ))
end

local function resolveCurveProgress(a1) -- Line: 72 -- upvalues: TreadmillProgression (val) -- types: a1: number
    return (math.max(a1 - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED, 0))
end

local function resolveWalkSpeed(a1) -- Line: 76 -- upvalues: TreadmillProgression (val) -- types: a1: number
    local v1
    if a1 <= 0 then
        return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    end
    if not (a1 <= 0) then
        local v2 = 1 + (TreadmillProgression.CURVE_XP_GROWTH - 1) * a1 / TreadmillProgression.CURVE_BASE_XP
        v1 = if not (v2 <= 1) then (math.log(v2)) / math.log(TreadmillProgression.CURVE_XP_GROWTH) else 0
    else
        v1 = 0
    end
    if v1 <= 0 then
        return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    end
    return (math.min(
        TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + v1 * TreadmillProgression.CURVE_SPEED_GAIN_PER_LEVEL,
        TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED
    ))
end

local function remapProgressionWalkSpeedToAppliedWalkSpeed(a1) -- Line: 86
    -- upvalues: TreadmillProgression (val), Constants (val)
    return Constants.BASE_WALK_SPEED + (math.clamp(
        (a1 - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED) / (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED),
        0,
        1
    )) * (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - Constants.BASE_WALK_SPEED)
end

local function remapAppliedWalkSpeedToProgressionWalkSpeed(a1) -- Line: 101
    -- upvalues: Constants (val), TreadmillProgression (val)
    return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + (math.clamp((a1 - Constants.BASE_WALK_SPEED) / (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - Constants.BASE_WALK_SPEED), 0, 1)) * (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED)
end

local function formatDurationProductLabel(a1, a2) -- Line: 119 -- upvalues: t (val) -- types: a1: number, a2: boolean
    t.strict(t.number)(a1)
    t.strict(t.boolean)(a2)
    local v1 = math.max(math.floor(a1), 0) // 60
    local v2 = v1
    local v3 = if v1 ~= 1 then "Minutes" else "Minute"
    if v1 >= 60 and v1 % 60 == 0 then
        v2 = v1 // 60
        v3 = if v2 ~= 1 then "Hours" else "Hour"
    end
    return (("%* %*"):format(v2, if not a2 then v3 else string.upper(v3)))
end

function u46.NormalizeSpeedPower(a1) -- Line: 140 -- upvalues: u46 (val), t (val) -- types: a1: number?
    if a1 == nil then
        return u46.DEFAULT_BASE_SPEED_POWER
    end
    t.strict(t.number)(a1)
    return a1
end

function u46.SpeedPowerToWalkSpeed(a1) -- Line: 152
    -- upvalues: u46 (val), TreadmillProgression (val), Constants (val)
    return Constants.BASE_WALK_SPEED + (math.clamp(
        (u46.SpeedPowerToProgressionWalkSpeed(a1) - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED) / (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED),
        0,
        1
    )) * (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - Constants.BASE_WALK_SPEED)
end

function u46.SpeedPowerToProgressionWalkSpeed(a1) -- Line: 158
    -- upvalues: u46 (val), TreadmillProgression (val)
    local v1
    local v2 = math.max(u46.NormalizeSpeedPower(a1) - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED, 0)
    if v2 <= 0 then
        return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    end
    if not (v2 <= 0) then
        local v3 = 1 + (TreadmillProgression.CURVE_XP_GROWTH - 1) * v2 / TreadmillProgression.CURVE_BASE_XP
        v1 = if not (v3 <= 1) then (math.log(v3)) / math.log(TreadmillProgression.CURVE_XP_GROWTH) else 0
    else
        v1 = 0
    end
    if v1 <= 0 then
        return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED
    end
    return (math.min(
        TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + v1 * TreadmillProgression.CURVE_SPEED_GAIN_PER_LEVEL,
        TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED
    ))
end

function u46.WalkSpeedToSpeedPower(a1) -- Line: 165
    -- upvalues: t (val), Constants (val), TreadmillProgression (val)
    t.strict(t.number)(a1)
    return TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + TreadmillProgression.CURVE_BASE_XP * (TreadmillProgression.CURVE_XP_GROWTH ^ ((math.max(
        TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED + (math.clamp(
            (a1 - Constants.BASE_WALK_SPEED) / (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - Constants.BASE_WALK_SPEED),
            0,
            1
        )) * (TreadmillProgression.CURVE_REFERENCE_MAX_WALK_SPEED - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED) - TreadmillProgression.CURVE_REFERENCE_BASE_WALK_SPEED,
        0
    )) / TreadmillProgression.CURVE_SPEED_GAIN_PER_LEVEL) - 1) / (TreadmillProgression.CURVE_XP_GROWTH - 1)
end

function u46.RoundSpeedPowerRequirement(a1) -- Line: 179 -- upvalues: t (val) -- types: a1: number
    local v1
    t.strict(t.number)(a1)
    if a1 <= 0 then
        return 0
    end
    local v2 = 10 ^ math.floor((math.log10(a1)))
    local v3 = a1 / v2
    return math.ceil(v3 / (if not (v3 < 2) then if not (v3 < 5) then 1 else 0.5 else 0.1)) * v1 * v2
end

function u46.FormatSpeedPower(a1) -- Line: 195 -- upvalues: Simple (val), u46 (val) -- types: a1: number?
    return Simple.FormatCompact(u46.NormalizeSpeedPower(a1), ".#")
end

function u46.FormatSpeedPowerPerStep(a1) -- Line: 199 -- upvalues: t (val), Simple (val) -- types: a1: number
    t.strict(t.number)(a1)
    return (("+%*/step"):format((Simple.FormatCompact(a1, ".#"))))
end

function u46.ResolveEquippedTrailSpeedStepMultiplier(a1) -- Line: 205
    -- upvalues: TreadmillProgression (val), Trails (val)
    if a1 == nil then
        return TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
    end
    local EquippedTrail = a1.EquippedTrail
    if EquippedTrail ~= nil and a1.TrailInventory[EquippedTrail] == true then
        if not Trails.TrailNameExists(EquippedTrail) then
            return TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
        end
        return (math.max(Trails.Directory[EquippedTrail].SpeedMultiplier, TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER))
    end
    return TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
end

function u46.ResolveFinalWalkSpeed(a1, a2) -- Line: 228
    -- upvalues: t (val), u46 (val)
    t.strict(t.optional(t.number))(a1)
    t.strict(t.optional(t.number))(a2)
    local v1 = a2 or 1
    local v2 = false
    if v1 > 0 then
        v2 = v1 <= 1
    end
    assert(v2, "Walk speed multiplier must be within (0, 1]")
    return u46.SpeedPowerToWalkSpeed(a1) * v1
end

function u46.ResolveEffectiveSpeedPower(a1, a2) -- Line: 245
    -- upvalues: t (val), u46 (val)
    t.strict(t.optional(t.number))(a2)
    local v1 = u46.NormalizeSpeedPower(a1)
    local v2 = a2 or 1
    local v3 = false
    if v2 > 0 then
        v3 = v2 <= 1
    end
    assert(v3, "Walk speed multiplier must be within (0, 1]")
    if v2 == 1 then
        return v1
    end
    return u46.WalkSpeedToSpeedPower(u46.ResolveFinalWalkSpeed(v1, v2))
end

function u46.FormatSpeedMultiplierValue(a1) -- Line: 268 -- upvalues: t (val), Simple (val) -- types: a1: number
    t.strict(t.number)(a1)
    return (("x%*"):format((Simple.FormatCompact(a1, ".#"))))
end

function u46.FormatSpeedMultiplier(a1) -- Line: 274 -- upvalues: t (val), u46 (val) -- types: a1: number
    t.strict(t.number)(a1)
    return (("%* Speed"):format((u46.FormatSpeedMultiplierValue(a1))))
end

function u46.FormatTemporarySpeedBoostProductDuration(a1) -- Line: 280
    -- upvalues: formatDurationProductLabel (val)
    return (formatDurationProductLabel(a1, true))
end

function u46.FormatTreadmillSpeedEquivalentDuration(a1) -- Line: 284
    -- upvalues: formatDurationProductLabel (val)
    return (formatDurationProductLabel(a1, false))
end

function u46.GetSpeedBoostMultiplierForTierIndex(a1) -- Line: 288
    -- upvalues: t (val), TreadmillProgression (val)
    t.strict(t.number)(a1)
    return TreadmillProgression.SPEED_BOOST_MULTIPLIERS_BY_TIER[a1] or TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
end

function u46.ResolveSpeedBoostTierIndex(a1) -- Line: 295 -- upvalues: u46 (val)
    if a1 == nil then
        return 0
    end
    return (math.clamp(math.floor(a1.SpeedBoostTierIndex), 0, u46.MAX_SPEED_BOOST_TIER_INDEX))
end

function u46.ResolveSpeedBoostSpeedStepMultiplier(a1) -- Line: 307 -- upvalues: u46 (val)
    return u46.GetSpeedBoostMultiplierForTierIndex(u46.ResolveSpeedBoostTierIndex(a1))
end

function u46.ResolveTemporarySpeedBoostRemainingSeconds(a1, a2) -- Line: 313 -- upvalues: t (val) -- types: a2: number?
    t.strict(t.optional(t.number))(a2)
    if a1 == nil then
        return 0
    end
    local v1 = math.max(a1.TemporarySpeedBoostRemainingSeconds, 0)
    local TemporarySpeedBoostActiveStartedAt = a1.TemporarySpeedBoostActiveStartedAt
    if TemporarySpeedBoostActiveStartedAt > 0 then
        v1 = v1 - math.max((if a2 ~= nil then a2 else workspace:GetServerTimeNow()) - TemporarySpeedBoostActiveStartedAt, 0)
    end
    return (math.max(v1, 0))
end

function u46.ResolveTemporarySpeedBoostSpeedStepMultiplier(a1, a2) -- Line: 335
    -- upvalues: u46 (val), TreadmillProgression (val), BossMasteryFlags (val)
    if (u46.ResolveTemporarySpeedBoostRemainingSeconds(a1, a2)) <= 0 then
        return TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
    end
    return BossMasteryFlags.TreadmillBoostMultiplier:Get()
end

function u46.GetTemporarySpeedBoostMultiplier() -- Line: 346 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.TreadmillBoostMultiplier:Get()
end

function u46.ResolveAdditiveSpeedStepMultiplier(a1, a2) -- Line: 350
    -- upvalues: t (val), TreadmillProgression (val)
    t.strict(t.optional(t.number))(a1)
    t.strict(t.optional(t.number))(a2)
    local DEFAULT_SPEED_STEP_MULTIPLIER = if a1 ~= nil then a1 else TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
    local DEFAULT_SPEED_STEP_MULTIPLIER_2 = if a2 ~= nil then a2 else TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER
    local v1 = math.max(DEFAULT_SPEED_STEP_MULTIPLIER - TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER, 0)
    local v2 = math.max(DEFAULT_SPEED_STEP_MULTIPLIER_2 - TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER, 0)
    return TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER + v1 + v2
end

function u46.ResolveTreadmillSpeedPowerDelta(a1, a2, a3, a4) -- Line: 371
    -- upvalues: t (val), u46 (val)
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    t.strict(t.optional(t.number))(a3)
    t.strict(t.optional(t.number))(a4)
    local v1 = if a4 ~= nil then math.max(a4, 0) else 1
    local v2 = u46.ResolveAdditiveSpeedStepMultiplier(a2, a3)
    return math.max(a1, 0) * v2 * v1
end

function u46.ResolveSpeedPowerPerStep(a1, a2, a3, a4) -- Line: 391
    -- upvalues: t (val), u46 (val), TreadmillProgression (val)
    t.strict(t.optional(t.number))(a2)
    t.strict(t.optional(t.number))(a3)
    t.strict(t.optional(t.number))(a4)
    local v1 = u46.ResolveSpeedBoostSpeedStepMultiplier(a1)
    local v2 = u46.ResolveTemporarySpeedBoostSpeedStepMultiplier(a1, a3)
    local v3 = u46.ResolveEquippedTrailSpeedStepMultiplier(a1)
    return (u46.ResolveTreadmillSpeedPowerDelta(
        TreadmillProgression.DEFAULT_BASE_SPEED_POWER_PER_STEP,
        a2 or TreadmillProgression.DEFAULT_SPEED_STEP_MULTIPLIER,
        nil
    )) * u46.ResolveAdditiveSpeedStepMultiplier(u46.ResolveAdditiveSpeedStepMultiplier(u46.ResolveAdditiveSpeedStepMultiplier(v1, v2), v3), a4)
end

function u46.ResolveSpeedPowerPerSecond(a1, a2, a3) -- Line: 426
    -- upvalues: t (val), u46 (val)
    t.strict(t.table)(a1)
    t.strict(t.number)(a2)
    t.strict(t.optional(t.number))(a3)
    return (u46.ResolveSpeedPowerPerStep(a1, a2, a3)) / u46.ResolveWalkSpeedPowerAwardInterval((u46.SpeedPowerToProgressionWalkSpeed(a1.SpeedPower)))
end

function u46.ResolveTreadmillEquivalentSpeedPower(a1, a2, a3, a4) -- Line: 442
    -- upvalues: t (val), u46 (val)
    t.strict(t.table)(a1)
    t.strict(t.number)(a2)
    t.strict(t.number)(a3)
    t.strict(t.optional(t.number))(a4)
    assert(a3 > 0, "Treadmill equivalent duration must be positive")
    return u46.ResolveSpeedPowerPerSecond(a1, a2, a4) * a3
end

function u46.ResolveNextTreadmillSpeedGainAt(a1) -- Line: 457
    -- upvalues: t (val), TreadmillProgression (val)
    t.strict(t.number)(a1)
    return a1 + TreadmillProgression.TREADMILL_SPEED_GAIN_INTERVAL
end

function u46.ResolveElapsedTreadmillSpeedGainTicks(a1, a2) -- Line: 463
    -- upvalues: t (val), TreadmillProgression (val)
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    if a2 < a1 then
        return 0
    end
    return math.floor((a2 - a1) / TreadmillProgression.TREADMILL_SPEED_GAIN_INTERVAL) + 1
end

function u46.ResolveWalkSpeedPowerAwardInterval(a1) -- Line: 477
    -- upvalues: t (val), TreadmillProgression (val)
    t.strict(t.number)(a1)
    return TreadmillProgression.WALK_GAIN_INTERVAL_SLOWEST - (math.clamp(
        (a1 - TreadmillProgression.WALK_GAIN_INTERVAL_MIN_SPEED) / (TreadmillProgression.WALK_GAIN_INTERVAL_MAX_SPEED - TreadmillProgression.WALK_GAIN_INTERVAL_MIN_SPEED),
        0,
        1
    )) * (TreadmillProgression.WALK_GAIN_INTERVAL_SLOWEST - TreadmillProgression.WALK_GAIN_INTERVAL_FASTEST)
end

local function findOptionalPresentationPart(a1, a2) -- Line: 497 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2, true)
    if v1 == nil then
        return nil
    end
    assert(v1:IsA("BasePart"), (("Treadmill \"%*\" %* must be a BasePart"):format(a1.Name, a2)))
    return v1
end

function u46.FindVideoFeedScreenPart(a1) -- Line: 512 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Tool"))(a1)
    local VideoFeedScreen = a1:FindFirstChild("VideoFeedScreen", true)
    if VideoFeedScreen == nil then
        return nil
    end
    assert(VideoFeedScreen:IsA("BasePart"), (("Treadmill \"%*\" VideoFeedScreen must be a BasePart"):format(a1.Name)))
    return VideoFeedScreen
end

function u46.FindVideoPlayerFolder(a1) -- Line: 518 -- upvalues: t (val), u46 (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Tool"))(a1)
    local v1 = u46.FindVideoFeedScreenPart(a1)
    if v1 == nil then
        return nil
    end
    local v2 = v1:FindFirstAncestorOfClass("Folder")
    if v2 ~= nil and v2:IsDescendantOf(a1) then
        return v2
    end
    return nil
end

function u46.FindVideoPresentationParts(a1) -- Line: 535 -- upvalues: t (val), u46 (val) -- types: a1: userdata
    local v1, v2
    t.strict(t.instanceIsA("Tool"))(a1)
    local v3 = u46.FindVideoFeedScreenPart(a1)
    local SwapLeft = a1:FindFirstChild("SwapLeft", true)
    if SwapLeft ~= nil then
        assert(SwapLeft:IsA("BasePart"), (("Treadmill \"%*\" SwapLeft must be a BasePart"):format(a1.Name)))
        v1 = SwapLeft
    else
        v1 = nil
    end
    local SwapRight = a1:FindFirstChild("SwapRight", true)
    if SwapRight ~= nil then
        assert(SwapRight:IsA("BasePart"), (("Treadmill \"%*\" SwapRight must be a BasePart"):format(a1.Name)))
        v2 = SwapRight
    else
        v2 = nil
    end
    if v3 ~= nil and v1 ~= nil and v2 ~= nil then
        return v3, v1, v2
    end
    return nil, nil, nil
end

function u46.ResolveGroundedToolRootCFrameAtLocation(a1, a2) -- Line: 550
    -- upvalues: t (val)
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.instanceIsA("Tool"))(a2)
    local Root = a2.Root
    assert(Root:IsA("BasePart"), (("Treadmill \"%*\" Root must be a BasePart"):format(a2.Name)))
    local BoundingBoxPart = a2.BoundingBoxPart
    assert(BoundingBoxPart:IsA("BasePart"), (("Treadmill \"%*\" BoundingBoxPart must be a BasePart"):format(a2.Name)))
    local v1 = Root.CFrame:PointToObjectSpace(BoundingBoxPart.CFrame.Position)
    local Attribute = a2:GetAttribute("Offset")
    return (CFrame.new(a1.Position + (Vector3.new(0, BoundingBoxPart.Size.Y * 0.5 + (Attribute or 0), 0)))) * a1.CFrame.Rotation * CFrame.new(-v1)
end

return u46