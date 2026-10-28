-- Script path: ReplicatedStorage.CmdrClient.Types.Vector
-- Decompile time: 1.24 ms

local Util = require(script.Parent.Parent.Shared.Util)

local function validateVector(a1, a2) -- Line: 3
    if a1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(a2)
    end
    return true
end

local u12 = Util.MakeSequenceType({
    Length = 3,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector3.new,
})
local u17 = Util.MakeSequenceType({
    Length = 2,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector2.new,
})
return function(a1) -- Line: 25 -- upvalues: u12 (val), Util (val), u17 (val)
    a1:RegisterType("vector3", u12)
    a1:RegisterType("vector3s", (Util.MakeListableType(u12)))
    a1:RegisterType("vector2", u17)
    a1:RegisterType("vector2s", (Util.MakeListableType(u17)))
end