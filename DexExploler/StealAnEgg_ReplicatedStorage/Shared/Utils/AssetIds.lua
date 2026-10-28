-- Script path: ReplicatedStorage.Shared.Utils.AssetIds
-- Decompile time: 1.29 ms

local v1 = {}
local u1 = {
    "rbxassetid://",
    "https://assetdelivery.roblox.com/v1/asset/?id=",
    "https://www.roblox.com/asset/?id=",
    "http://www.roblox.com/asset/?id=",
}

local function wholePositive(a1) -- Line: 14 -- types: a1: number
    if a1 > 0 and a1 < (1 / 0) and a1 % 1 == 0 then
        return a1
    end
    return nil
end

local function digitsBehindHead(a1) -- Line: 18 -- upvalues: u1 (val) -- types: a1: string
    local v1
    for i, j in u1 do
        if string.sub(a1, 1, #j) == j then
            v1 = string.sub(a1, #j + 1)
            if string.find(v1, "^%d+$") ~= nil then
                return v1
            end
            return nil
        end
    end
    return nil
end

function v1.Parse(a1) -- Line: 28 -- upvalues: digitsBehindHead (val)
    if type(a1) == "number" then
        if a1 > 0 and a1 < (1 / 0) and a1 % 1 == 0 then
            return a1
        end
        return nil
    end
    local v1 = tonumber(a1)
    if v1 == nil then
        local v2 = digitsBehindHead(a1)
        v1 = if v2 == nil then nil else tonumber(v2)
    end
    if v1 == nil then
        return nil
    end
    if v1 > 0 and v1 < (1 / 0) and v1 % 1 == 0 then
        return v1
    end
    return nil
end

return table.freeze(v1)