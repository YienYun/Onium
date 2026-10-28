-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardEggRetrievalComponent
-- Decompile time: 6.27 ms

local GuardRetrieval = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardRetrieval
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardDistance = require(script.Parent.GuardDistance)
local Physics = require(ReplicatedStorage.Shared.Utils.Physics)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local u45 = {}
u45.__index = u45
u45.__class = "GuardEggRetrievalComponent"

function u45.new(a1, a2, a3) -- Line: 44
    -- upvalues: t (val), WaitFor (val), Constants (val), u45 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    t.strict(t.CFrame)(a3)
    local v1, v2 = WaitFor.Descendant(a1, "EggPoint", Constants.STUDIO_YIELD_TIMEOUT):await()
    assert(v1, (("Failed to resolve EggPoint under %*: %*"):format(a1:GetFullName(), (tostring(v2)))))
    assert(v2:IsA("BasePart"), (("%*.EggPoint must be a BasePart"):format((a1:GetFullName()))))
    v1 = setmetatable({}, u45)
    v1._byUid = {}
    v1._current = nil
    v1._eggPoint = v2
    v1._homeCFrame = a3
    v1._queue = {}
    v1._root = a2
    v1._stage = nil
    v1._weld = nil
    return v1
end

function u45:_enqueue(a2) -- Line: 82
    local Priority
    for i, v in ipairs(self._queue) do
        Priority = a2.Priority
        if v.Priority < Priority then
            table.insert(self._queue, i, a2)
            return
        end
    end
    table.insert(self._queue, a2)
end

function u45:_selectCurrent() -- Line: 96
    local Model, v1
    if self._current ~= nil then
        return self._current
    end
    local v2 = self
    while true do
        if not (#v2._queue > 0) then
            break
        end
        v1 = table.remove(v2._queue, 1)
        assert(v1 ~= nil, "Non-empty guard retrieval queue must yield a target")
        Model = v1.Model
        if v2._byUid[v1.EggUid] == v1 then
            if Model ~= nil and Model.Parent == nil then
                v2._byUid[v1.EggUid] = nil
                continue
            end
            v2._current = v1
            v2._stage = "Approaching"
            return v1
        end
        v2._byUid[v1.EggUid] = nil
    end
    return nil
end

function u45:_destroyWeld() -- Line: 122
    local _weld = self._weld
    if _weld ~= nil then
        self._weld = nil
        _weld:Destroy()
    end
end

function u45:_removeCurrent() -- Line: 131
    local _current = self._current
    assert(_current ~= nil, "Guard retrieval current target is required")
    self:_destroyWeld()
    self._byUid[_current.EggUid] = nil
    self._current = nil
    self._stage = nil
    return _current
end

function u45.Register(a1, a2) -- Line: 149 -- upvalues: t (val)
    t.strict(t.table)(a2)
    t.strict(t.string)(a2.EggUid)
    t.strict(t.optional(t.instanceIsA("Model")))(a2.Model)
    t.strict(t.Vector3)(a2.DroppedPosition)
    t.strict(t.CFrame)(a2.NestBottomCFrame)
    t.strict(t.number)(a2.Priority)
    if a1._byUid[a2.EggUid] ~= nil then
        return false
    end
    a1._byUid[a2.EggUid] = a2
    a1:_enqueue(a2)
    local _current = a1._current
    if _current ~= nil and a1._stage == "Approaching" and _current.Priority < a2.Priority then
        a1._current = nil
        a1._stage = nil
        a1:_enqueue(_current)
    end
    return true
end

function u45:Clear(a2) -- Line: 179 -- upvalues: t (val) -- types: a2: string
    t.strict(t.string)(a2)
    local v1 = self._byUid[a2]
    if v1 == nil then
        return false
    end
    self._byUid[a2] = nil
    if self._current == v1 then
        self:_destroyWeld()
        self._current = nil
        self._stage = nil
    end
    local v2 = table.find(self._queue, v1)
    if v2 ~= nil then
        table.remove(self._queue, v2)
    end
    return true
end

function u45.HasPending(a1) -- Line: 205
    return next(a1._byUid) ~= nil
end

function u45.IsAttached(a1, a2) -- Line: 209 -- upvalues: t (val) -- types: a2: string
    t.strict(t.string)(a2)
    local v1 = false
    if a1._current ~= nil then
        v1 = false
        if a1._current.EggUid == a2 then
            v1 = a1._stage == "Carrying"
        end
    end
    return v1
end

function u45.GetMoveTarget(a1) -- Line: 218
    local v1 = a1:_selectCurrent()
    if v1 == nil then
        return nil
    end
    if a1._stage == "Carrying" then
        return a1._homeCFrame.Position
    end
    return v1.DroppedPosition
end

function u45.TryTransition(a1, a2) -- Line: 232
    -- upvalues: t (val), GuardDistance (val), Physics (val), GuardRetrieval (val)
    t.strict(t.number)(a2)
    local v1 = a1:_selectCurrent()
    if v1 == nil then
        return nil
    end
    local Model = v1.Model
    if Model ~= nil and Model.Parent == nil then
        a1:Clear(v1.EggUid)
        return nil
    end
    if a1._stage ~= "Approaching" then
        if GuardRetrieval.DEPOSIT_DISTANCE_XZ < (GuardDistance.XZ(a1._root.Position, a1._homeCFrame.Position)) then
            return nil
        end
        a1:_destroyWeld()
        if Model ~= nil then
            Physics.SetAnchored(Model, true)
            Model:PivotTo(v1.NestBottomCFrame)
        end
        a1:_removeCurrent()
        return "Deposited"
    end
    if a2 < GuardDistance.XZ(a1._root.Position, v1.DroppedPosition) then
        return nil
    end
    if Model ~= nil then
        local v2
        local PrimaryPart = Model.PrimaryPart
        local v3 = ("Rendered guard retrieval egg %* must have a PrimaryPart"):format(v1.EggUid)
        assert(PrimaryPart ~= nil, v3)
        Physics.SetAnchored(Model, false)
        Model:PivotTo(a1._eggPoint.CFrame * (CFrame.new(0, 0, -PrimaryPart.Size.Z * 0.5)))
        local _eggPoint_2 = a1._eggPoint
        if not _eggPoint_2.Anchored then
            v2 = Instance.new("WeldConstraint")
        else
            local Motor6D = Instance.new("Motor6D")
            Motor6D.C0 = _eggPoint_2.CFrame:ToObjectSpace(PrimaryPart.CFrame)
            v2 = Motor6D
        end
        v2.Part0 = _eggPoint_2
        v2.Part1 = PrimaryPart
        v2.Parent = _eggPoint_2
        a1._weld = v2
    end
    a1._stage = "Carrying"
    return "Attached"
end

function u45.GetCurrentEggUid(a1) -- Line: 304
    local v1 = a1:_selectCurrent()
    if v1 ~= nil then
        return v1.EggUid
    end
    return nil
end

function u45:Destroy() -- Line: 310
    self:_destroyWeld()
    table.clear(self._byUid)
    table.clear(self._queue)
    self._current = nil
    self._stage = nil
end

return u45