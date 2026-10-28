-- Script path: ReplicatedStorage.UserGenerated.Lang.Tests
-- Decompile time: 4.07 ms

local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local DeepEquals = require(game.ReplicatedStorage.UserGenerated.Collections.DeepEquals)

local function StripErrorSource(a1) -- Line: 35
    local v1 = tostring(a1)
    local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")
    if v2 and v3 then
        v1 = v3
    end
    return v1
end

local function ToString(a1) -- Line: 45 -- upvalues: Stringify (val)
    return Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0})
end

return table.freeze({
    IsEqual = function(a1, a2) -- Line: 21
        if rawequal(a1, a2) then
            return true
        end
        if type(a1) == "table" and type(a2) == "table" then
            return false
        end
        if a1 ~= a1 and a2 ~= a2 then
            return true
        end
        return false
    end,
    ErrorUnsafe = function(a1, a2, ...) -- Line: 57 -- types: a2: function
        local u2 = nil
        local pack = table.pack
        local success = xpcall(a2, function(a1) -- Line: 59 -- upvalues: u2 (ref)
            u2 = a1
        end, ...)
        local v1 = pack(success)
        if v1[1] then
            error("ExpectedError", 2)
        end
        if u2 ~= a1 then
            error(("ExpectedError Mismatch: %*"):format((string.format("%q", (tostring(u2))))), 2)
        end
        return (table.unpack(v1, 2))
    end,
    Error = function(a1, a2, ...) -- Line: 72 -- upvalues: Stringify (val) -- types: a2: function
        local u39 = nil
        local pack = table.pack
        local success = xpcall(a2, function(a1) -- Line: 74 -- upvalues: u39 (ref)
            u39 = a1
        end, ...)
        local v1 = pack(success)
        if v1[1] then
            error(("ExpectedError(%*)"):format((Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0}))), 2)
        end
        local v2 = u39
        if type(v2) == "string" then
            local v3
            local v4 = tostring(u39)
            v2, v3 = string.match(v4, "^(.*:%d+): (.+)$")
            if v2 and v3 then
                v4 = v3
            end
            u39 = v4
        end
        if a1 ~= u39 then
            error(("ExpectedError(%*): %*"):format(
                Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0}),
                (Stringify.Pretty(u39, {Pretty = false, IndentChar = "", IndentSize = 0}))
            ), 2)
        end
        return (table.unpack(v1, 2))
    end,
    Equal = function(a1, a2) -- Line: 90 -- upvalues: Stringify (val)
        if not (if not rawequal(a1, a2) then if type(a1) ~= "table" then if a1 == a1 then false else not (a2 == a2) else if type(a2) == "table" then false else if a1 == a1 then false else not (a2 == a2) else true) then
            error(("Equal(%*, %*)"):format(
                Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0}),
                (Stringify.Pretty(a2, {Pretty = false, IndentChar = "", IndentSize = 0}))
            ), 2)
        end
    end,
    DeepEqual = function(a1, a2) -- Line: 96 -- upvalues: DeepEquals (val), Stringify (val)
        if not DeepEquals(a1, a2) then
            error(("DeepEqual(%*, %*)"):format(
                Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0}),
                (Stringify.Pretty(a2, {Pretty = false, IndentChar = "", IndentSize = 0}))
            ), 2)
        end
    end,
    FuzzyEqual = function(a1, a2, a3) -- Line: 102 -- types: a1: number, a2: number, a3: number?
        if (a3 or 0.001) < math.abs(a1 - a2) then
            error(("FuzzyEqual(%*, %*): %*"):format(tostring(a1), tostring(a2), (math.abs(a1 - a2))), 2)
        end
    end,
    ColorEqual = function(a1, a2, a3) -- Line: 109 -- upvalues: Stringify (val) -- types: a1: userdata, a2: userdata, a3: number?
        local v1 = Vector3.new(a1.R, a1.G, a1.B) * 255
        if (a3 or 0.001) < (Vector3.new(a2.R, a2.G, a2.B) * 255 - v1).Magnitude then
            error(("ColorEqual(%*, %*)"):format(
                Stringify.Pretty(a1, {Pretty = false, IndentChar = "", IndentSize = 0}),
                (Stringify.Pretty(a2, {Pretty = false, IndentChar = "", IndentSize = 0}))
            ), 2)
        end
    end,
})