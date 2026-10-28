-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardEscapeSignController
-- Decompile time: 2.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
local GuardEscapeRequirement = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapeRequirement)
local RequiredSpeedSign = require(script.Parent.Parent.Parent.GUI.GuardAreas.RequiredSpeedSign)
local u26 = nil
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u40 = {}
u40.__index = u40
u40.__class = "GuardEscapeSignController"

function u40.new(a1) -- Line: 30
    -- upvalues: t (val), u40 (val), RequiredSpeedSign (val), Trove (val), GuardEscapeRequirement (val)
    -- upvalues: ReplicatedStorage (val), u26 (ref)
    t.strict(t.instanceIsA("Model"))(a1)
    local u13 = setmetatable({}, u40)
    u13._areaModel = a1
    u13._destroyed = false
    u13._requiredSpeedSign = RequiredSpeedSign.new(a1)
    u13._trove = Trove.new()
    u13._trove:Add(u13._requiredSpeedSign)
    u13._trove:Add(((a1:GetAttributeChangedSignal(GuardEscapeRequirement.SIGN_SPEEDS_ATTRIBUTE)):Connect(function() -- Line: 46 -- upvalues: u13 (val)
        u13:_render()
    end)))
    task.spawn(function() -- Line: 50 -- upvalues: ReplicatedStorage (upval), u13 (val), u26 (upval)
        local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
        if u13._destroyed then
            return
        end
        u26 = SpeedPowerProjection
        u13._trove:Add((SpeedPowerProjection.Changed:Connect(function() -- Line: 54 -- upvalues: u13 (upval)
            u13:_render()
        end)))
        u13:_render()
    end)
    u13:_render()
    return u13
end

function u40:_render() -- Line: 61
    -- upvalues: GuardEscapeRequirement (val), u26 (ref), GuardEscapePrediction (val), TreadmillUtil (val)
    local Attribute = self._areaModel:GetAttribute(GuardEscapeRequirement.SIGN_SPEEDS_ATTRIBUTE)
    if u26 ~= nil
        and typeof(Attribute) == "Vector2"
        and 0 <= Attribute.X
        and Attribute.X < (1 / 0)
        and 0 <= Attribute.Y
        and Attribute.Y < (1 / 0) then
        self._requiredSpeedSign:SetSpeedPowerRequirement(Attribute.X)
        self._requiredSpeedSign:SetSlowdownTolerance((GuardEscapePrediction.ResolveSlowdownTolerance(Attribute.Y, (TreadmillUtil.SpeedPowerToWalkSpeed((u26.ReadProjected()))))))
        return
    end
    self._requiredSpeedSign:SetLoading()
end

function u40:Destroy() -- Line: 89
    self._destroyed = true
    self._trove:Destroy()
end

return u40