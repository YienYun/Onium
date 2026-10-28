-- Script path: ReplicatedStorage.Shared.Modules.TokenBucket
-- Decompile time: 2.90 ms

local v1 = {}

local function accrualsFor(a1, a2) -- Line: 36 -- types: a1: table, a2: userdata
    local v1 = a1.accruals[a2]
    if v1 then
        return v1
    end
    v1 = {}
    for i, v in ipairs(a1.accrualTemplate) do
        table.insert(v1, {credit = 0, tokens = v.tokens, interval = v.interval})
    end
    a1.accruals[a2] = v1
    return v1
end

local function harvest(a1, a2, a3) -- Line: 52 -- types: a1: table, a2: table, a3: number
    local v1, v2, v3
    local v4 = 0
    for i, v in ipairs(a2) do
        v3 = a1.maxTokens / (v.tokens / v.interval)
        v1 = math.min(v.credit + a3, v3)
        v3 = math.floor(v1 / v.interval)
        if not (v3 <= 0) then
            v4 = v4 + v3 * v.tokens
            v2 = v3 * v.interval
            v.credit = math.fmod(v1, v2)
        else
            v.credit = v1
        end
    end
    return v4
end

function v1.Build(a1, a2) -- Line: 71 -- types: a1: string, a2: table
    assert(a2.MaximumTokens, (("endpoint %* has no MaximumTokens"):format(a1)))
    if a2.InitialTokens then
        assert(a2.InitialTokens <= a2.MaximumTokens, (("endpoint %* starts above its own ceiling"):format(a1)))
    end
    local v1 = {}
    local v2 = ipairs
    local Refresh = a2.Refresh or {}
    for i, v in v2(Refresh) do
        assert(0 < v.Tokens, (("a refresh rule on %* grants no tokens"):format(a1)))
        assert(0 < v.Interval, (("a refresh rule on %* has no interval"):format(a1)))
        table.insert(v1, {tokens = v.Tokens, interval = v.Interval})
    end
    table.freeze(v1)
    v2 = {name = a1, maxTokens = a2.MaximumTokens}
    local InitialTokens = a2.InitialTokens or a2.MaximumTokens
    v2.initialTokens = InitialTokens
    v2.causesBan = a2.Ban == true
    v2.accrualTemplate = v1
    v2.tokens = {}
    v2.stamps = {}
    v2.accruals = {}
    return v2
end

function v1.Spend(a1, a2) -- Line: 101 -- upvalues: accrualsFor (val), harvest (val) -- types: a1: table, a2: userdata
    local ServerTimeNow = workspace:GetServerTimeNow()
    if not a1.stamps[a2] then
        a1.stamps[a2] = ServerTimeNow
    end
    if not a1.tokens[a2] then
        a1.tokens[a2] = a1.initialTokens
    end
    local v1 = accrualsFor(a1, a2)
    local v2 = a1.tokens[a2]
    local v3 = harvest(a1, v1, (math.max(ServerTimeNow - a1.stamps[a2], 0)))
    v1 = 1 <= v2 + v3
    v2 = math.min(v2 + v3, a1.maxTokens)
    if v1 then
        v2 = v2 - 1
    end
    a1.tokens[a2] = (math.clamp(v2, -1, a1.maxTokens))
    a1.stamps[a2] = ServerTimeNow
    return v1
end

function v1.Forget(a1, a2) -- Line: 127 -- types: a1: table, a2: userdata
    a1.stamps[a2] = nil
    a1.tokens[a2] = nil
    a1.accruals[a2] = nil
end

return v1