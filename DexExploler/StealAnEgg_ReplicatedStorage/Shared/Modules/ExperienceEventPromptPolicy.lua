-- Script path: ReplicatedStorage.Shared.Modules.ExperienceEventPromptPolicy
-- Decompile time: 2.36 ms

local u0 = {Id = "string", HasStarted = "boolean", HasEnded = "boolean"}

local function coerce(a1) -- Line: 18 -- upvalues: u0 (val)
    local v1
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5 = a1
    for i, j in u0, v3, v4 do
        if type(if type(v5) ~= "table" then nil else v5[i]) ~= j then
            return nil
        end
        v2[i] = v1
    end
    return v2
end

local function countKeys(a1) -- Line: 37 -- types: a1: table
    local v1 = 0
    for i in a1 do
        v1 = v1 + 1
    end
    return v1
end

return table.freeze({
    PromptDelaySeconds = 300,
    RetryDelaySeconds = 30,
    NoEventRecheckSeconds = 60,
    MaxAttempts = 5,
    IsValidEventId = function(a1) -- Line: 33
        local v1 = false
        if type(a1) == "string" then
            v1 = false
            if #a1 > 0 then
                v1 = #a1 <= 128
            end
        end
        return v1
    end,
    IsSafeToPrompt = function(a1, a2, a3) -- Line: 54 -- types: a1: boolean, a2: boolean, a3: boolean
        return a1 and not a2 and not a3
    end,
    IsReturningPlayer = function(a1, a2, a3) -- Line: 60 -- types: a1: number, a2: number, a3: number
        local v1 = false
        if a1 > 1 then
            v1 = false
            if a2 >= 0 then
                v1 = a2 <= a3
            end
        end
        local v2 = v1
        if v2 then
            local v3 = a3 // 86400
            v2 = a2 // 86400 < v3
        end
        return v2
    end,
    GetSoonestUnseenEvent = function(a1, a2) -- Line: 65 -- upvalues: coerce (val) -- types: a2: table
        local v1, v2
        local v3 = if type(a1) ~= "table" then {} else a1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = coerce(j)
            v2 = false
            if v1 ~= nil then
                v2 = not v1.HasStarted and not v1.HasEnded
            end
            if v2 and not v6[v1.Id] then
                return v1
            end
        end
        return nil
    end,
    TryMarkSeen = function(a1, a2, a3) -- Line: 80 -- types: a1: table, a3: number
        local v1 = false
        if type(a2) == "string" then
            v1 = false
            if #a2 > 0 then
                v1 = #a2 <= 128
            end
        end
        if not v1 then
            return false
        end
        assert(type(a2) == "string")
        local v2 = a1[a2] == true
        if not v2 then
            local v3 = 0
            for i in a1 do
                v3 = v3 + 1
            end
            v2 = v3 < a3
        end
        a1[a2] = if not v2 then a1[a2] else true
        return v2
    end,
})