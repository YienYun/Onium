-- Script path: ReplicatedStorage.CmdrClient.Types.Color3
-- Decompile time: 1.35 ms

local Util = require(script.Parent.Parent.Shared.Util)
local u12 = Util.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3",
    Length = 3,
    ValidateEach = function(a1, a2) -- Line: 5
        if a1 == nil then
            return false, ("Invalid or missing number at position %d in Color3 type."):format(a2)
        end
        if not (a1 < 0) and not (a1 > 255) then
            if a1 % 1 ~= 0 then
                return false, ("Number is not an integer at position %d in Color3 type."):format(a2)
            end
            return true
        end
        return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(a2)
    end,
    TransformEach = tonumber,
    Constructor = Color3.fromRGB,
})

local function parseHexDigit(a1) -- Line: 21
    if #a1 == 1 then
        a1 = a1 .. a1
    end
    return (tonumber(a1, 16))
end

local u14 = {}

function u14.Transform(a1) -- Line: 30 -- upvalues: Util (val), parseHexDigit (val)
    local v1, v2, v3 = a1:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
    return Util.Each(parseHexDigit, v1, v2, v3)
end

function u14.Validate(a1, a2, a3) -- Line: 35
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a2 ~= nil then
            v1 = a3 ~= nil
        end
    end
    return v1, "Invalid hex color"
end

function u14.Parse(...) -- Line: 39
    return Color3.fromRGB(...)
end

return function(a1) -- Line: 44 -- upvalues: u12 (val), Util (val), u14 (val)
    a1:RegisterType("color3", u12)
    a1:RegisterType("color3s", (Util.MakeListableType(u12, {Prefixes = "# hexColor3s ! brickColor3s"})))
    a1:RegisterType("hexColor3", u14)
    a1:RegisterType("hexColor3s", (Util.MakeListableType(u14)))
end