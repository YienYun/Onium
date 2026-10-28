-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardWakeLookAt
-- Decompile time: 9.64 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Player = require(ReplicatedStorage.Shared.Player)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local u27 = {}
u27.__index = u27
u27.__class = "GuardWakeLookAt"
local u29 = {}
u29.Jungle = {
    AuthoredPitchAxis = Vector3.new(-0, -0, -1),
    BasePitch = 0.7853981633974483,
    MaxPitch = 1.3962634015954636,
    MinPitch = 0.17453292519943295,
    TargetPitchScale = -1,
}

function u27.new(a1) -- Line: 80 -- upvalues: t (val), u27 (val), WaitFor (val), u29 (val) -- types: a1: userdata
    local WorldCFrame, v1, v2
    t.strict(t.instanceIsA("Model"))(a1)
    local v3 = setmetatable({}, u27)
    local v4, v5 = WaitFor.Descendant(a1, "Head"):await()
    local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart")
    local Parent = a1.Parent
    local v6 = ("%* requires a Head descendant for wake look-at"):format((a1:GetFullName()))
    assert(v4 and v5 ~= nil, v6)
    assert(v5:IsA("BasePart"), (("%* must be a BasePart"):format((v5:GetFullName()))))
    assert(HumanoidRootPart:IsA("BasePart"), (("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))))
    local v7 = false
    if Parent ~= nil then
        v7 = Parent:IsA("Model")
    end
    assert(v7, (("%* requires an area Model parent"):format((a1:GetFullName()))))
    local u91 = a1:GetAttribute("HeadLookAtBoneName")
    v4 = nil
    local v8 = nil
    if u91 == nil then
        local v9
        local Attribute = a1:GetAttribute("HeadLookAtMotorName")
        t.strict(t.optional(t.string))(Attribute)
        local u154 = Attribute or "Head"
        v9, v1 = WaitFor.Custom(function() -- Line: 121 -- upvalues: a1 (val), u154 (val)
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("Motor6D") and v.Name == u154 then
                    return v
                end
            end
            return nil
        end):await()
        local v10 = ("%* requires Motor6D \"%*\" for wake look-at"):format(a1:GetFullName(), u154)
        assert(v9 and v1 ~= nil, v10)
        assert(v1:IsA("Motor6D"), (("%* must be a Motor6D"):format((v1:GetFullName()))))
        v8 = v1
    else
        t.strict(t.string)(u91)
        v7, v6 = WaitFor.Custom(function() -- Line: 103 -- upvalues: a1 (val), u91 (val)
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("Bone") and v.Name == u91 then
                    return v
                end
            end
            return nil
        end):await()
        v2 = ("%* requires Bone \"%*\" for HeadLookAtBoneName"):format(a1:GetFullName(), u91)
        assert(v7 and v6 ~= nil, v2)
        assert(v6:IsA("Bone"), (("%* must be a Bone"):format((v6:GetFullName()))))
        v4 = v6
    end
    if v4 == nil then
        v1 = ("%* wake look-at requires a Motor6D or Bone"):format((a1:GetFullName()))
        assert(v8 ~= nil, v1)
        local Part0 = v8.Part0
        v2 = ("%* requires Part0 for wake look-at"):format((v8:GetFullName()))
        assert(Part0 ~= nil, v2)
        WorldCFrame = Part0.CFrame * v8.C0
    else
        WorldCFrame = v4.WorldCFrame
    end
    v6 = u29[Parent.Name]
    local v11 = WorldCFrame.Rotation:ToObjectSpace(HumanoidRootPart.CFrame.Rotation)
    if v6 ~= nil then
        v2 = ("%* area look override requires a Bone"):format((a1:GetFullName()))
        assert(v4 ~= nil, v2)
    end
    v3._areaLookOverride = v6
    v3._appliedOffset = CFrame.identity
    v3._bone = v4
    v3._currentOffset = CFrame.identity
    v3._guardModel = a1
    v3._isWaking = false
    v3._jointToFacingRotation = v11
    v3._motor = v8
    v3._preAnimationConnection = nil
    v3._preSimulationConnection = nil
    v3._root = HumanoidRootPart
    v3._targetPitchReference = nil
    v3._targetUserId = nil
    return v3
end

function u27:_getJointTransform() -- Line: 173
    local _bone = self._bone
    if _bone ~= nil then
        return _bone.Transform
    end
    local _motor = self._motor
    local v1 = ("%* wake look-at requires a Motor6D or Bone"):format((self._guardModel:GetFullName()))
    assert(_motor ~= nil, v1)
    return _motor.Transform
end

function u27:_setJointTransform(a2) -- Line: 184 -- types: a2: userdata
    local _bone = self._bone
    if _bone ~= nil then
        _bone.Transform = a2
        return
    end
    local _motor = self._motor
    local v1 = ("%* wake look-at requires a Motor6D or Bone"):format((self._guardModel:GetFullName()))
    assert(_motor ~= nil, v1)
    _motor.Transform = a2
end

function u27:_getAnimationJointWorldCFrame() -- Line: 196
    local _bone = self._bone
    if _bone ~= nil then
        return _bone.TransformedWorldCFrame * self._appliedOffset:Inverse()
    end
    local _motor = self._motor
    local v1 = ("%* wake look-at requires a Motor6D or Bone"):format((self._guardModel:GetFullName()))
    assert(_motor ~= nil, v1)
    local Part0 = _motor.Part0
    local v2 = ("%* requires Part0 for wake look-at"):format((_motor:GetFullName()))
    assert(Part0 ~= nil, v2)
    local v3 = _motor.Transform * self._appliedOffset:Inverse()
    return Part0.CFrame * _motor.C0 * v3
end

function u27:_getAnimationJointTransform() -- Line: 210
    return (self:_getJointTransform()) * self._appliedOffset:Inverse()
end

function u27:_getTargetOffset() -- Line: 214 -- upvalues: Player (val), Players (val)
    if not self._isWaking then
        return CFrame.identity
    end
    local v1 = Player.FindRootPart(Players.LocalPlayer)
    if v1 ~= nil and not (400 < (v1.Position - self._root.Position).Magnitude) then
        local v2
        local _targetUserId = self._targetUserId
        if _targetUserId == nil then
            return CFrame.identity
        end
        local v3 = tonumber(_targetUserId)
        local v4 = ("%*.WakeTargetPlayer must be a user id"):format((self._guardModel:GetFullName()))
        assert(v3 ~= nil, v4)
        v1 = Players:GetPlayerByUserId(v3)
        if v1 == nil then
            return CFrame.identity
        end
        v3 = Player.FindHead(v1)
        if v3 == nil then
            return CFrame.identity
        end
        v1 = self:_getAnimationJointWorldCFrame()
        local v5 = (CFrame.new(v1.Position)) * self._root.CFrame.Rotation
        local v6 = v3.Position - v5.Position
        if v6.Magnitude <= 0.001 then
            return CFrame.identity
        end
        v3 = v5:VectorToObjectSpace(v6.Unit)
        v6 = math.asin(v3.Y)
        v4 = math.clamp(-math.atan2(v3.X, -v3.Z), -1.0471975511965976, 1.0471975511965976)
        local _areaLookOverride = self._areaLookOverride
        if _areaLookOverride == nil then
            v4 = (v5 * CFrame.Angles(math.clamp(v6, -0.6108652381980153, 0.6108652381980153), v4, 0)).Rotation * self._jointToFacingRotation:Inverse()
            return v1.Rotation:ToObjectSpace(v4)
        end
        local _targetPitchReference = self._targetPitchReference
        if _targetPitchReference ~= nil then
            v2 = _targetPitchReference
        else
            self._targetPitchReference = v6
        end
        local v7 = self:_getAnimationJointTransform()
        local v8 = v1.Rotation * v7.Rotation:Inverse()
        v2 = CFrame.fromAxisAngle(_areaLookOverride.AuthoredPitchAxis, (math.clamp(
            _areaLookOverride.BasePitch + (v6 - v2) * _areaLookOverride.TargetPitchScale,
            _areaLookOverride.MinPitch,
            _areaLookOverride.MaxPitch
        )))
        return v1.Rotation:ToObjectSpace(CFrame.fromAxisAngle(self._root.CFrame.UpVector, v4) * v8 * v2 * v7.Rotation)
    end
    return CFrame.identity
end

function u27:_applyOffset(a2) -- Line: 289 -- types: a2: userdata
    self:_setJointTransform((self:_getJointTransform()) * a2)
    self._appliedOffset = a2
end

function u27:_restoreAppliedOffset() -- Line: 294
    self:_setJointTransform((self:_getJointTransform()) * (self._appliedOffset:Inverse()))
    self._appliedOffset = CFrame.identity
end

function u27:_isOffsetAtRest() -- Line: 299
    local v1, v2, v3 = self._currentOffset:ToOrientation()
    return (math.max(math.abs(v1), math.abs(v2), (math.abs(v3)))) <= 0.001
end

function u27:_step(a2) -- Line: 304 -- types: a2: number
    self._currentOffset = self._currentOffset:Lerp(self:_getTargetOffset(), 1 - math.exp(a2 * -3.5))
    self:_applyOffset(self._currentOffset)
    if not self._isWaking and self:_isOffsetAtRest() then
        self._currentOffset = CFrame.identity
        self:_restoreAppliedOffset()
        return true
    end
    return false
end

function u27:_ensureAnimation() -- Line: 319 -- upvalues: RunService (val)
    if self._preSimulationConnection ~= nil then
        return
    end
    assert(self._preAnimationConnection == nil, "wake look-at frame connections must share a lifecycle")
    self._preAnimationConnection = RunService.PreAnimation:Connect(function() -- Line: 329 -- upvalues: self (val)
        self:_restoreAppliedOffset()
    end)
    self._preSimulationConnection = RunService.PreSimulation:Connect(function(a1) -- Line: 331 -- upvalues: self (val) -- types: a1: number
        if self:_step(a1) then
            self:_disconnectAnimation()
        end
    end)
end

function u27:_disconnectAnimation() -- Line: 338
    local _preAnimationConnection = self._preAnimationConnection
    if _preAnimationConnection ~= nil then
        self._preAnimationConnection = nil
        _preAnimationConnection:Disconnect()
    end
    local _preSimulationConnection = self._preSimulationConnection
    if _preSimulationConnection ~= nil then
        self._preSimulationConnection = nil
        _preSimulationConnection:Disconnect()
    end
end

function u27.SetWaking(a1, a2, a3) -- Line: 356 -- upvalues: t (val) -- types: a2: boolean, a3: string?
    t.strict(t.boolean)(a2)
    t.strict(t.optional(t.string))(a3)
    if not a2 or not a1._isWaking or a3 ~= a1._targetUserId then
        a1._targetPitchReference = nil
    end
    a1._isWaking = a2
    a1._targetUserId = a3
    if a2 or not a1:_isOffsetAtRest() then
        a1:_ensureAnimation()
    end
end

function u27.Destroy(a1) -- Line: 374
    a1._isWaking = false
    a1._targetPitchReference = nil
    a1._targetUserId = nil
    a1._currentOffset = CFrame.identity
    a1:_restoreAppliedOffset()
    a1:_disconnectAnimation()
end

return u27