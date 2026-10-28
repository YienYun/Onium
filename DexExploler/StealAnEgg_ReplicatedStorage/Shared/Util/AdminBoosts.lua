-- Script path: ReplicatedStorage.Shared.Util.AdminBoosts
-- Decompile time: 1.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local u22 = t.strict(t.string)
local u34 = t.strict(t.optional(t.intersection(t.numberMin(1), t.numberMaxExclusive((1 / 0)))))
local v1 = {
    SPEED = "Speed",
    EARNINGS = "Earnings",
    EGG_SIZE = "EggSize",
    EGG_SPAWN_LUCK = "EggSpawnLuck",
    MUTATION_LUCK = "MutationLuck",
    TREADMILL = "Treadmill",
    VIDEO_LUCK = "VideoLuck",
}
local u36 = {}
for i, j in v1 do
    u36[j] = true
end

local function attributeFor(a1) -- Line: 46 -- upvalues: u22 (val), u36 (val) -- types: a1: string
    u22(a1)
    assert(u36[a1], (("there is no admin boost named \"%*\""):format(a1)))
    return "AdminBoost_" .. a1
end

function v1.ReadMultiplier(a1) -- Line: 59 -- upvalues: Workspace (val), u22 (val), u36 (val) -- types: a1: string
    local v1 = Workspace
    u22(a1)
    assert(u36[a1], (("there is no admin boost named \"%*\""):format(a1)))
    local Attribute = v1:GetAttribute("AdminBoost_" .. a1)
    if type(Attribute) == "number" and Attribute == Attribute then
        return (math.max(Attribute, 1))
    end
    return 1
end

function v1.Observe(a1) -- Line: 68 -- upvalues: Workspace (val), u22 (val), u36 (val) -- types: a1: string
    local v1 = Workspace
    u22(a1)
    assert(u36[a1], (("there is no admin boost named \"%*\""):format(a1)))
    return v1:GetAttributeChangedSignal("AdminBoost_" .. a1)
end

function v1.Assign(a1, a2) -- Line: 74
    -- upvalues: RunService (val), u34 (val), u22 (val), u36 (val), Workspace (val)
    assert(RunService:IsServer(), "admin boosts can only be assigned on the server")
    u34(a2)
    u22(a1)
    assert(u36[a1], (("there is no admin boost named \"%*\""):format(a1)))
    local v1 = "AdminBoost_" .. a1
    if a2 ~= nil and not (a2 <= 1) then
        Workspace:SetAttribute(v1, a2)
        return
    end
    Workspace:SetAttribute(v1, nil)
end

return table.freeze(v1)