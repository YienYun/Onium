-- Script path: ReplicatedStorage.Shared.Utils.Physics
-- Decompile time: 1.46 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {
    {name = "Massless", value = true},
    {name = "CanTouch", value = false},
    {name = "CanCollide", value = false},
}
local v1 = {}

local function eachPart(a1, a2) -- Line: 17 -- types: a1: userdata, a2: function
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            a2(j)
        end
    end
end

function v1.SetAnchored(a1, a2) -- Line: 25 -- upvalues: t (val), eachPart (val) -- types: a1: userdata, a2: boolean
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.boolean)(a2)
    eachPart(a1, function(a1) -- Line: 29 -- upvalues: a2 (val)
        a1.Anchored = a2
    end)
end

function v1.DisableAllPhysics(a1, a2) -- Line: 34
    -- upvalues: t (val), eachPart (val), u9 (val)
    t.strict(t.Instance)(a1)
    t.strict(t.optional(t.boolean))(a2)
    local u20 = a2 == true
    eachPart(a1, function(a1) -- Line: 39 -- upvalues: u9 (upval), u20 (val)
        for i, j in u9 do
            a1[j.name] = j.value
        end
        a1.CanQuery = u20
    end)
end

function v1.SetCollisionGroup(a1, a2) -- Line: 47
    -- upvalues: t (val), eachPart (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.string)(a2)
    eachPart(a1, function(a1) -- Line: 51 -- upvalues: a2 (val)
        a1.CollisionGroup = a2
    end)
end

return table.freeze(v1)