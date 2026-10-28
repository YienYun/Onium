-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatDuration
-- Decompile time: 1.34 ms

local u0 = {0, 2, 2, 2}
return function(a1) -- Line: 22 -- upvalues: u0 (val) -- types: a1: number
    assert(type(a1) == "number")
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 ~= a1 then
        return "NaN"
    end
    local v1 = math.ceil((math.max(0, a1)))
    local v2 = v1 % 60
    v1 = v1 // 60
    local v3 = v1 % 60
    v1 = v1 // 60
    local v4 = v1 % 24
    local v5 = {v1 // 24, v4, v3, v2}
    local v6 = #v5
    for i, v in ipairs(v5) do
        if v > 0 then
            v6 = i
            break
        end
    end
    if v6 == #v5 then
        return (tostring(v2)) .. "s"
    end
    v4 = {(tostring(v5[v6]))}
    local v7 = v6 + 1
    local v8 = #v5
    for i2 = v7, v8 do
        v3 = tostring(v5[i2])
        v2 = u0[i2]
        while #v3 < v2 do
            v3 = "0" .. v3
        end
        table.insert(v4, ":" .. v3)
    end
    return table.concat(v4)
end