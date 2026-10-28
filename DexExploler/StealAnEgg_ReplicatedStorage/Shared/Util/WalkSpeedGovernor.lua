-- Script path: ReplicatedStorage.Shared.Util.WalkSpeedGovernor
-- Decompile time: 4.43 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local u25 = t.strict((t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))))
local u33 = t.strict(t.optional(t.instanceIsA("Humanoid")))
local u38 = t.strict(t.optional(t.string))
local u41 = t.strict(t.string)
local u42 = {}
u42.__index = u42

local function foldModifiers(a1, a2) -- Line: 63 -- upvalues: u25 (val) -- types: a1: number, a2: table
    u25(a1)
    local v1 = 0
    local v2 = {}
    for i, v in ipairs(a2) do
        if v.type == "positive" then
            v1 = v1 + v.value
        elseif v.type == "malus" then
            table.insert(v2, v.value)
        end
    end
    local v3 = a1 * (v1 + 1)
    for i2, i3 in ipairs(v2) do
        v3 = v3 * (i3 + 1)
    end
    return (math.max(0, v3))
end

local function refold(a1) -- Line: 86 -- upvalues: foldModifiers (val) -- types: a1: table
    local v1 = foldModifiers(a1.baseSpeed, a1.modifiers)
    local value_2 = nil
    for i, j in a1.speedOverrides do
        value_2 = if value_2 ~= nil then math.min(value_2, j.value) else j.value
    end
    if value_2 ~= nil then
        v1 = value_2
    end
    if (math.abs(v1 - a1.appliedSpeed)) < 0.001 then
        return
    end
    a1.appliedSpeed = v1
    if a1.humanoid then
        a1.humanoid.WalkSpeed = v1
    end
end

function u42.new(a1) -- Line: 105 -- upvalues: Constants (val), u25 (val), u42 (val) -- types: a1: number?
    local BASE_WALK_SPEED = a1 or Constants.BASE_WALK_SPEED
    u25(BASE_WALK_SPEED)
    assert(BASE_WALK_SPEED > 0)
    local v1 = setmetatable({}, u42)
    v1.baseSpeed = BASE_WALK_SPEED
    v1.appliedSpeed = BASE_WALK_SPEED
    v1.modifiers = {}
    v1.speedOverrides = {}
    v1.humanoid = nil
    return v1
end

function u42.CurrentSpeed(a1) -- Line: 122 -- types: a1: table
    return a1.appliedSpeed
end

function u42.BaseSpeed(a1) -- Line: 126 -- types: a1: table
    return a1.baseSpeed
end

function u42.Modifiers(a1) -- Line: 130 -- types: a1: table
    return a1.modifiers
end

function u42.Bind(a1, a2) -- Line: 134 -- upvalues: u33 (val) -- types: a1: table, a2: userdata?
    u33(a2)
    if a1.humanoid == a2 then
        return
    end
    a1.humanoid = a2
    if a2 then
        a2.WalkSpeed = a1.appliedSpeed
    end
end

function u42.Rebase(a1, a2) -- Line: 148 -- upvalues: u25 (val), refold (val) -- types: a1: table, a2: number
    u25(a2)
    assert(a2 > 0)
    if a1.baseSpeed == a2 then
        return
    end
    a1.baseSpeed = a2
    refold(a1)
end

function u42.Attach(a1, a2, a3, a4, a5) -- Line: 160
    -- upvalues: u41 (val), u25 (val), u38 (val), refold (val)
    u41(a2)
    local v1 = true
    if a3 ~= "positive" then
        v1 = a3 == "malus"
    end
    assert(v1)
    u25(a4)
    u38(a5)
    for i, v in ipairs(a1.modifiers) do
        if v.id == a2 then
            error((("A modifier called %* is already attached to this stat"):format(a2)))
        end
    end
    table.insert(a1.modifiers, {id = a2, type = a3, value = a4, source = a5})
    refold(a1)
end

function u42.HasModifier(a1, a2) -- Line: 182 -- upvalues: u41 (val) -- types: a1: table, a2: string
    u41(a2)
    for i, v in ipairs(a1.modifiers) do
        if v.id == a2 then
            return true
        end
    end
    return false
end

function u42.Detach(a1, a2) -- Line: 194 -- upvalues: u41 (val), refold (val) -- types: a1: table, a2: string
    u41(a2)
    for i, v in ipairs(a1.modifiers) do
        if v.id == a2 then
            table.remove(a1.modifiers, i)
            refold(a1)
            return
        end
    end
end

function u42.Override(a1, a2, a3, a4) -- Line: 206
    -- upvalues: u41 (val), u38 (val), u25 (val), refold (val)
    u41(a2)
    u38(a4)
    if a3 ~= nil then
        u25(a3)
        assert(a3 >= 0)
    end
    a1.speedOverrides[a2] = if a3 == nil then nil else {value = a3, source = a4}
    refold(a1)
end

function u42.DetachSource(a1, a2) -- Line: 214 -- upvalues: u41 (val), refold (val) -- types: a1: table, a2: string
    u41(a2)
    local v1 = false
    for i = #a1.modifiers, 1, -1 do
        if a1.modifiers[i].source == a2 then
            table.remove(a1.modifiers, i)
            v1 = true
        end
    end
    for j, k in a1.speedOverrides do
        if k.source == a2 then
            a1.speedOverrides[j] = nil
            v1 = true
        end
    end
    if v1 then
        refold(a1)
    end
end

function u42.Destroy(a1) -- Line: 234 -- types: a1: table
    a1.humanoid = nil
end

return u42