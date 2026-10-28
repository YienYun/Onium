-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapeRequirement
-- Decompile time: 2.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local GuardEscape = require(ReplicatedStorage.Shared.Utils.GuardEscape)
local GuardEscapePrediction = require(script.Parent.GuardEscapePrediction)
local Guards = require(ReplicatedStorage.Data.Guards)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local u39 = {SIGN_SPEEDS_ATTRIBUTE = "GuardEscapeSpeeds"}

function u39.BuildPathParameters(a1, a2, a3, a4) -- Line: 21
    -- upvalues: t (val), Areas (val), Guards (val), GuardEscapePrediction (val), GuardChasePolicy (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    local v1 = Areas.Directory[a1.Name]
    local v2 = a4 or Guards.Directory[v1.GuardId]
    v1 = a1:FindFirstChild("Bounds")
    local ClosestExitPoint = a1:FindFirstChild("ClosestExitPoint")
    local v3 = ("%*.Bounds is required"):format((a1:GetFullName()))
    assert(v1 ~= nil, v3)
    v3 = ("%*.ClosestExitPoint is required"):format((a1:GetFullName()))
    assert(ClosestExitPoint ~= nil, v3)
    assert(v1:IsA("BasePart"), (("%*.Bounds must be a BasePart"):format((a1:GetFullName()))))
    assert(ClosestExitPoint:IsA("BasePart"), (("%*.ClosestExitPoint must be a BasePart"):format((a1:GetFullName()))))
    local v4 = -a3.CFrame.LookVector
    return {
        BaseGuardWalkSpeed = v2.WalkSpeed,
        ExitDirection = v4,
        ExitDistance = GuardEscapePrediction.ResolveExitDistance(v1.CFrame, v1.Size, ClosestExitPoint.Position, v4),
        FlatRadius = v2.FlatRadius,
        GuardStartPosition = a2,
        HitDistance = GuardChasePolicy.ResolveHitDistance(v2.HitDistance),
        PlayerStartPosition = ClosestExitPoint.Position,
    }
end

function u39.ResolveSpeedPower(a1, a2, a3) -- Line: 69
    -- upvalues: GuardEscape (val), u39 (val)
    return GuardEscape.RequiredSpeedPower(u39.BuildPathParameters(a1, a2, a3))
end

function u39.PublishSign(a1, a2, a3, a4) -- Line: 84
    -- upvalues: u39 (val), GuardEscape (val), GuardEscapePrediction (val)
    local Position = a4
    if Position == nil then
        local Guard = a1:FindFirstChild("Guard")
        local HumanoidRootPart = if Guard == nil then nil else Guard:FindFirstChild("HumanoidRootPart")
        local v1 = false
        if HumanoidRootPart ~= nil then
            v1 = HumanoidRootPart:IsA("BasePart")
        end
        assert(v1, (("%*.Guard requires a root"):format((a1:GetFullName()))))
        Position = HumanoidRootPart.Position
    end
    local v2 = u39.BuildPathParameters(a1, Position, a2, a3)
    a1:SetAttribute(
        u39.SIGN_SPEEDS_ATTRIBUTE,
        (Vector2.new(GuardEscape.RequiredSpeedPower(v2), (GuardEscapePrediction.ResolvePlayerWalkSpeedRequirement(v2, 1))))
    )
end

return table.freeze(u39)