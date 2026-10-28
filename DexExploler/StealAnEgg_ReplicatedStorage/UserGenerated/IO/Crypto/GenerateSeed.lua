-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed
-- Decompile time: 2.42 ms

local HttpService = game:GetService("HttpService")

local function GenerateEntropy() -- Line: 22 -- upvalues: HttpService (val)
    local v1 = HttpService:GenerateGUID(false)
    return (tonumber(string.sub(v1, 1, 8), 16)), (tonumber((string.sub(v1, 10, 13)) .. string.sub(v1, 25, 28), 16)), (tonumber(string.sub(v1, 29, 36), 16))
end

return function(a1) -- Line: 29 -- upvalues: HttpService (val) -- types: a1: number
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = table.create(a1, 0)
    local v10 = a1 // 3
    local v11 = v10 - 1
    for i = 0, v11 do
        v5 = i * 3 + 1
        v6 = i * 3 + 2
        v7 = i * 3 + 3
        v2 = HttpService:GenerateGUID(false)
        v8 = tonumber(string.sub(v2, 1, 8), 16)
        v1 = tonumber((string.sub(v2, 10, 13)) .. string.sub(v2, 25, 28), 16)
        v3 = tonumber(string.sub(v2, 29, 36), 16)
        v9[v5] = v8
        v9[v6] = v1
        v9[v7] = v3
    end
    v11 = a1 - v10 * 3
    if v11 == 1 then
        v10 = HttpService:GenerateGUID(false)
        v4 = tonumber(string.sub(v10, 1, 8), 16)
        tonumber((string.sub(v10, 10, 13)) .. string.sub(v10, 25, 28), 16)
        tonumber(string.sub(v10, 29, 36), 16)
        v9[a1] = v4
        return v9
    end
    if v11 == 2 then
        v4 = a1 - 1
        v6 = HttpService:GenerateGUID(false)
        local v12 = tonumber(string.sub(v6, 1, 8), 16)
        v5 = tonumber((string.sub(v6, 10, 13)) .. string.sub(v6, 25, 28), 16)
        tonumber(string.sub(v6, 29, 36), 16)
        v9[v4] = v12
        v9[a1] = v5
    end
    return v9
end