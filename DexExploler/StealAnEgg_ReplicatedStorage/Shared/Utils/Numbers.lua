-- Script path: ReplicatedStorage.Shared.Utils.Numbers
-- Decompile time: 1.55 ms

local u2 = utf8.char(8734)
local u3 = {
    b = 9,
    k = 3,
    m = 6,
    q = 15,
    t = 12,
}
local v1 = {}

local function groupThousands(a1) -- Line: 18 -- types: a1: string
    local v1
    local v2 = {}
    local v3 = #a1
    while v3 > 0 do
        v1 = math.max(v3 - 2, 1)
        table.insert(v2, 1, (string.sub(a1, v1, v3)))
        v3 = v1 - 1
    end
    return table.concat(v2, ",")
end

function v1.AddCommas(a1) -- Line: 33 -- upvalues: u2 (val), groupThousands (val) -- types: a1: number
    assert(type(a1) == "number", "amount must be a number")
    if a1 ~= a1 then
        return "NaN"
    end
    local v1 = math.round((math.abs(a1)))
    local v2 = if v1 ~= (1 / 0) then groupThousands(string.format("%.0f", v1)) else u2
    if a1 < 0 and v1 > 0 then
        return "-" .. v2
    end
    return v2
end

function v1.Parse(a1) -- Line: 49 -- upvalues: u3 (val) -- types: a1: string
    local v1, v2
    assert(type(a1) == "string", "text must be a string")
    local v3 = string.gsub(string.lower(a1), "[^%w%.%+%-]", "")
    for i, j in u3 do
        v1 = string.match(v3, "^(.+)" .. i .. "$")
        if v1 then
            v2 = tonumber(v1)
            if v2 then
                return v2 * 10 ^ j
            end
            return nil
        end
    end
    return (tonumber(v3))
end

return table.freeze(v1)