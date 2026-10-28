-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.AreaEggNearbyPulse
-- Decompile time: 4.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local EggGrowthAnimation = require(ReplicatedStorage.Shared.Eggs.EggGrowthAnimation)
local Player = require(ReplicatedStorage.Shared.Player)
local u18 = {}
u18.__index = u18
u18.__class = "AreaEggNearbyPulse"

function u18.new(a1) -- Line: 48 -- upvalues: t (val), u18 (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Player"))(a1)
    local v1 = setmetatable({}, u18)
    v1._player = a1
    v1._random = Random.new()
    v1._registeredByUid = {}
    v1._nextPulseAt = nil
    return v1
end

function u18:_scheduleNextFor(a2, a3) -- Line: 64 -- types: a2: string, a3: number
    local v1 = assert(self._registeredByUid[a2], (("Area egg %* must be registered before scheduling"):format(a2)))
    local v2 = a3 + self._random:NextNumber(6, 25)
    v1.NextPulseAt = v2
    local _nextPulseAt = self._nextPulseAt
    if _nextPulseAt == nil or v2 < _nextPulseAt then
        self._nextPulseAt = v2
    end
end

function u18:_recomputeNextPulseAt() -- Line: 76
    local NextPulseAt = nil
    for k, v in pairs(self._registeredByUid) do
        if NextPulseAt == nil or v.NextPulseAt < NextPulseAt then
            NextPulseAt = v.NextPulseAt
        end
    end
    self._nextPulseAt = NextPulseAt
end

function u18:_collectClosest(a2) -- Line: 86 -- types: a2: vector
    local v1, v2
    local v3 = {}
    local v4 = {}
    for k, v in pairs(self._registeredByUid) do
        if v.Model.Parent ~= nil and v.Root.Parent ~= nil then
            v2 = v.Root.Position - a2
            v1 = v2:Dot(v2)
            if not (v1 > 122500) then
                v2 = #v3 + 1
                for i, i2 in ipairs(v4) do
                    if v1 < i2 then
                        v2 = i
                        break
                    end
                end
                if v2 <= 8 then
                    table.insert(v3, v2, k)
                    table.insert(v4, v2, v1)
                    if #v3 > 8 then
                        table.remove(v3)
                        table.remove(v4)
                    end
                end
            end
        end
    end
    return v3
end

function u18.Bind(a1, a2, a3, a4) -- Line: 129
    -- upvalues: t (val), EggGrowthAnimation (val)
    t.strict(t.string)(a2)
    t.strict(t.instanceIsA("Model"))(a3)
    t.strict(t.number)(a4)
    a1:Unbind(a2)
    local PrimaryPart = a3.PrimaryPart
    local v1 = ("Rendered area egg %* must have a PrimaryPart"):format(a2)
    assert(PrimaryPart ~= nil, v1)
    local u43 = {NextPulseAt = 0, Model = a3, Root = PrimaryPart}
    u43.Animation = EggGrowthAnimation.new(a3, a3:GetPivot(), 2)
    a1._registeredByUid[a2] = u43
    a1:_scheduleNextFor(a2, a4)
    return function() -- Line: 152 -- upvalues: a1 (val), a2 (val), u43 (val)
        if a1._registeredByUid[a2] == u43 then
            a1:Unbind(a2)
        end
    end
end

function u18:Unbind(a2) -- Line: 159 -- upvalues: t (val) -- types: a2: string
    t.strict(t.string)(a2)
    local v1 = self._registeredByUid[a2]
    if v1 == nil then
        return
    end
    local v2 = v1.NextPulseAt == self._nextPulseAt
    self._registeredByUid[a2] = nil
    v1.Animation:Destroy()
    if v2 then
        self:_recomputeNextPulseAt()
    end
end

function u18.Step(a1, a2) -- Line: 175 -- upvalues: t (val), Player (val) -- types: a2: number
    t.strict(t.number)(a2)
    local _nextPulseAt = a1._nextPulseAt
    if _nextPulseAt ~= nil and not (a2 < _nextPulseAt) then
        local v1 = Player.FindRootPart(a1._player)
        local v2 = {}
        if v1 ~= nil then
            assert(v1:IsA("BasePart"), "Local HumanoidRootPart must be a BasePart")
            for i, v in ipairs(a1:_collectClosest(v1.Position)) do
                v2[v] = true
            end
        end
        a1._nextPulseAt = nil
        for k, i2 in pairs(a1._registeredByUid) do
            if i2.NextPulseAt <= a2 then
                a1:_scheduleNextFor(k, a2)
                if v2[k] then
                    i2.Animation:SetBasePivot((i2.Model:GetPivot()))
                    i2.Animation:Play()
                end
            elseif a1._nextPulseAt == nil or i2.NextPulseAt < a1._nextPulseAt then
                a1._nextPulseAt = i2.NextPulseAt
            end
        end
        return
    end
end

return u18