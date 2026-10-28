-- Script path: ReplicatedStorage.Packages.FormatNumber._internal.decimal_conversion
-- Decompile time: 0.78 ms

local v1 = {}
local u13 = table.freeze({
    ["0"] = "\000",
    ["1"] = "\001",
    ["2"] = "\002",
    ["3"] = "\003",
    ["4"] = "\004",
    ["5"] = "\005",
    ["6"] = "\006",
    ["7"] = "\007",
    ["8"] = "\008",
    ["9"] = "\t",
})

function v1.from_double(a1) -- Line: 15 -- upvalues: u13 (val) -- types: a1: number
    local v1, v2, v3 = string.match(tostring(a1), "^(%d+)%.?(%d*)e?([+-]?%d*)$")
    local v4, v5 = string.match(v1 .. v2, "^0*(%d-)(0*)$")
    local v6 = {(string.byte(string.gsub(v4, ".", u13), 1, -1))}
    return v6, #v6, (tonumber(v3) or 0) - #v2 + #v5
end

return table.freeze(v1)