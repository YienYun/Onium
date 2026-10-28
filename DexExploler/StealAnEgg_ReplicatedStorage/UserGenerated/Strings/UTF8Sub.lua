-- Script path: ReplicatedStorage.UserGenerated.Strings.UTF8Sub
-- Decompile time: 0.77 ms

return function(a1, a2, a3) -- Line: 20 -- types: a1: string, a2: number, a3: number?
    local v1
    local v2 = a3 or -1
    local v3 = utf8.offset(a1, a2)
    if v3 then
        local v4 = v3
        if v2 ~= -1 then
            v3 = utf8.offset(a1, v2 + 1)
            v1 = if not v3 then if not (v2 < 0) then #a1 else 0 else v3 - 1
        else
            v1 = #a1
        end
        return (string.sub(a1, v4, v1))
    end
    if a2 > 0 then
        return ""
    end
    if v2 ~= -1 then
        v3 = utf8.offset(a1, v2 + 1)
        v1 = if not v3 then if not (v2 < 0) then #a1 else 0 else v3 - 1
    else
        v1 = #a1
    end
    return (string.sub(a1, 1, v1))
end