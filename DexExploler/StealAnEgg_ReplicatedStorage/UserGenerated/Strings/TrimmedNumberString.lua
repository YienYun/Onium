-- Script path: ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString
-- Decompile time: 0.57 ms

return function(a1) -- Line: 20 -- types: a1: number
    assert(type(a1) == "number")
    if a1 ~= a1 then
        return "NaN"
    end
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 == (-1 / 0) then
        return "-Infinity"
    end
    local v1, v2 = string.match(string.format("%f", a1), "^([^%.]*)%.?(.*)$")
    assert(v1)
    if not v2 then
        return v1
    end
    v2 = string.gsub(v2, "0+$", "")
    if #v2 == 0 then
        return v1
    end
    return (("%*.%*"):format(v1, v2))
end