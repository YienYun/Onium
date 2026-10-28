-- Script path: ReplicatedStorage.UserGenerated.Strings.Commas
-- Decompile time: 1.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)
return function(a1) -- Line: 35 -- upvalues: TrimmedNumberString (val)
    local v1
    local v2, v3, v4 = string.match(if type(a1) ~= "string" then TrimmedNumberString(a1) else a1, "^(.-)([0-9,]+)(.*)$")
    if not v3 then
        return v1
    end
    v1 = {}
    if v2 then
        table.insert(v1, v2)
    end
    v3 = string.gsub(v3, ",", "")
    v2 = 1
    local v5 = #v3 % 3
    if v5 > 0 then
        table.insert(v1, (string.sub(v3, v2, v2 + v5 - 1)))
        v2 = v2 + v5
    end
    while v2 <= #v3 do
        if v2 > 1 then
            table.insert(v1, ",")
        end
        table.insert(v1, (string.sub(v3, v2, v2 + 2)))
        v2 = v2 + 3
    end
    if v4 then
        table.insert(v1, v4)
    end
    return table.concat(v1)
end