-- Script path: ReplicatedStorage.Packages.FormatNumber.Simple
-- Decompile time: 1.46 ms

local u0 = {
    "K",
    "M",
    "B",
    "T",
    "Qa",
    "Qi",
    "Sx",
    "Sp",
    "Oc",
    "No",
    "Dc",
    "Ud",
    "Dd",
    "Td",
    "Qad",
    "Qid",
    "Sxd",
    "Spd",
    "Ocd",
    "Nod",
    "Vg",
    "Uvg",
    "Dvg",
    "Tvg",
    "Qavg",
    "Qivg",
    "Sxvg",
    "Spvg",
    "Ocvg",
    "Novg",
    "Tg",
}
local Main = require(script.Parent.Main)
local v1 = {}
local u38 = {}
local u39 = {}

function v1.Format(a1, a2) -- Line: 45 -- upvalues: u38 (val), Main (val) -- types: a1: number, a2: string?
    assert(type(a1) == "number", "Value provided must be a number")
    local v1 = if a2 ~= nil then a2 else ""
    assert(type(v1) == "string", "Skeleton provided must be a string")
    local v2 = u38[v1]
    if not v2 then
        local v3, v4 = Main.NumberFormatter.forSkeleton(v1)
        v2 = v4
        assert(v3, v2)
        u38[v1] = v2
    end
    return v2:Format(a1)
end

function v1.FormatCompact(a1, a2) -- Line: 72
    -- upvalues: u39 (val), Main (val), u0 (val)
    assert(type(a1) == "number", "Value provided must be a number")
    local v1 = if a2 ~= nil then a2 else ""
    assert(type(v1) == "string", "Skeleton provided must be a string")
    local v2 = u39[v1]
    if not v2 then
        local v3, v4 = Main.NumberFormatter.forSkeleton(v1)
        v2 = v4
        assert(v3, v2)
        v2 = v2:Notation((Main.Notation.compactWithSuffixThousands(u0)))
        u39[v1] = v2
    end
    assert(#u0 ~= 0, "Please provide the suffix abbreviations for FormatCompact at the top of the Simple ModuleScript")
    return v2:Format(a1)
end

return table.freeze(v1)