-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.RecommendationFlags
-- Decompile time: 3.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)

local function typecheckAssertion(a1) -- Line: 8
    return function(a1_2) -- Line: 9 -- upvalues: a1 (val)
        local v1, v2 = a1(a1_2)
        assert(v1, v2)
        return a1_2
    end
end

local function typecheckChecker(a1) -- Line: 15
    return function(a1_2) -- Line: 16 -- upvalues: a1 (val)
        local success, err = pcall(a1, a1_2)
        local v1 = success
        if success then
            return v1, nil
        end
        return v1, (tostring(err))
    end
end

local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local u28 = t.intersection(v1, t.numberMin(0))
local u32 = t.intersection(v1, t.numberPositive)
local u39 = t.intersection(t.integer, t.numberMin(1))

local function typecheckSetAssertion(a1) -- Line: 31 -- upvalues: t (val)
    local u4 = t.valueOf(a1)
    return function(a1) -- Line: 9 -- upvalues: u4 (val)
        local v1, v2 = u4(a1)
        assert(v1, v2)
        return a1
    end
end

local Replicated = FastFlags.Replicated
local boolean = t.boolean
local v2 = Replicated("Game.TreadmillRecommendations.Enabled", function(a1) -- Line: 9 -- upvalues: boolean (val)
    local v1, v2 = boolean(a1)
    assert(v1, v2)
    return a1
end, false)
local Replicated_2 = FastFlags.Replicated
local u58 = t.valueOf({
    "MaximizeEngagement",
    "MaximizeTimespent",
    "MaximizeReactions",
    "RecentlyAdded",
    "TreadmillFeedV1",
    "TreadmillFeedV2",
})
return table.freeze({
    Enabled = v2,
    ConfigName = Replicated_2("Game.TreadmillRecommendations.ConfigName", function(a1) -- Line: 9 -- upvalues: u58 (val)
        local v1, v2 = u58(a1)
        assert(v1, v2)
        return a1
    end, "MaximizeEngagement"),
    PageSize = FastFlags.Replicated("Game.TreadmillRecommendations.PageSize", function(a1) -- Line: 9 -- upvalues: u39 (val)
        local v1, v2 = u39(a1)
        assert(v1, v2)
        return a1
    end, 20),
    PrefetchMargin = FastFlags.Replicated("Game.TreadmillRecommendations.PrefetchMargin", function(a1) -- Line: 9 -- upvalues: u39 (val)
        local v1, v2 = u39(a1)
        assert(v1, v2)
        return a1
    end, 5),
    PrefetchJitterSeconds = FastFlags.Replicated("Game.TreadmillRecommendations.PrefetchJitterSeconds", function(a1) -- Line: 9 -- upvalues: u28 (val)
        local v1, v2 = u28(a1)
        assert(v1, v2)
        return a1
    end, 10),
    ConfigSwapSpreadSeconds = FastFlags.Replicated("Game.TreadmillRecommendations.ConfigSwapSpreadSeconds", function(a1) -- Line: 9 -- upvalues: u28 (val)
        local v1, v2 = u28(a1)
        assert(v1, v2)
        return a1
    end, 60),
    StaleSeconds = FastFlags.Replicated("Game.TreadmillRecommendations.StaleSeconds", function(a1) -- Line: 9 -- upvalues: u32 (val)
        local v1, v2 = u32(a1)
        assert(v1, v2)
        return a1
    end, 900),
    FetchRetryDelaySeconds = FastFlags.Replicated("Game.TreadmillRecommendations.FetchRetryDelaySeconds", function(a1) -- Line: 9 -- upvalues: u32 (val)
        local v1, v2 = u32(a1)
        assert(v1, v2)
        return a1
    end, 5),
    FailureCooldownSeconds = FastFlags.Replicated("Game.TreadmillRecommendations.FailureCooldownSeconds", function(a1) -- Line: 9 -- upvalues: u32 (val)
        local v1, v2 = u32(a1)
        assert(v1, v2)
        return a1
    end, 30),
})