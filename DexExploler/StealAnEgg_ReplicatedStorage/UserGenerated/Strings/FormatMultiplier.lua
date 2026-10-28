-- Script path: ReplicatedStorage.UserGenerated.Strings.FormatMultiplier
-- Decompile time: 0.74 ms

return function(a1, a2) -- Line: 20 -- types: a1: number, a2: number?
    assert(type(a1) == "number")
    local v1 = true
    if a2 ~= nil then
        v1 = false
        if type(a2) == "number" then
            v1 = false
            if a2 >= 0 then
                v1 = math.floor(a2) == a2
            end
        end
    end
    assert(v1)
    if a1 ~= a1 then
        return "NaN"
    end
    if a1 == (1 / 0) then
        return "Infinity"
    end
    if a1 == (-1 / 0) then
        return "-Infinity"
    end
    local v2 = a2 or 2
    if v2 > 0 then
        return (string.format(("%%0.%*f"):format(v2), a1)):gsub("(%d)%.?0+$", "%1")
    end
    return (tostring((math.round(a1))))
end