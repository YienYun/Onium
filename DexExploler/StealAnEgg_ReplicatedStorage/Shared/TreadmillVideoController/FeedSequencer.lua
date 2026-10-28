-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.FeedSequencer
-- Decompile time: 19.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Checksum = require(ReplicatedStorage.Shared.Utils.Checksum)
local Log = require(ReplicatedStorage.Packages.Log)
local Shuffle = require(ReplicatedStorage.Shared.Utils.Numeric).Shuffle
local TreadmillMediaCatalog = require(ReplicatedStorage.Data.TreadmillMediaCatalog)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
require(script.Parent.Types.Interface)
local u36 = {
    "Funny",
    "Brainrot",
    "Satisfying",
    "Funny",
    "Satisfying",
    "WeirdOrHorror",
    "Funny",
    "Brainrot",
    "Satisfying",
    "Funny",
    "Music",
}
local u48 = #u36
local u50 = Log.new()
local u51 = {}
local PathSeed = Checksum.PathSeed

local function createEmptyBucketIndices() -- Line: 54
    return {
        Brainrot = {},
        Funny = {},
        Satisfying = {},
        WeirdOrHorror = {},
        Music = {},
    }
end

local function normalizeFeedIndex(a1) -- Line: 64 -- types: a1: number
    return (math.max(0, (math.floor(a1))))
end

local function normalizeReleaseVersion(a1) -- Line: 68 -- types: a1: number
    return (math.max(0, (math.floor(a1))))
end

local function normalizeSeed(a1, a2) -- Line: 72 -- upvalues: PathSeed (val) -- types: a1: number, a2: number
    if a1 > 0 then
        return (math.floor(a1))
    end
    return PathSeed("TreadmillMediaFeed", a2)
end

local function bucketForFeedIndex(a1) -- Line: 79 -- upvalues: u48 (val), u36 (val) -- types: a1: number
    return u36[(a1 - 1) % u48 + 1] or u36[1]
end

local function createBucketOrder(a1, a2, a3, a4) -- Line: 84
    -- upvalues: PathSeed (val), Shuffle (val)
    return Shuffle(table.clone(a1), (Random.new(PathSeed(a4, a2, a3))))
end

local function createBucketOrders(a1, a2, a3) -- Line: 95
    -- upvalues: PathSeed (val), Shuffle (val)
    return {
        Brainrot = Shuffle(table.clone(a1.Brainrot), (Random.new(PathSeed(a3, a2, "Brainrot")))),
        Funny = Shuffle(table.clone(a1.Funny), (Random.new(PathSeed(a3, a2, "Funny")))),
        Satisfying = Shuffle(table.clone(a1.Satisfying), (Random.new(PathSeed(a3, a2, "Satisfying")))),
        WeirdOrHorror = Shuffle(table.clone(a1.WeirdOrHorror), (Random.new(PathSeed(a3, a2, "WeirdOrHorror")))),
        Music = Shuffle(table.clone(a1.Music), (Random.new(PathSeed(a3, a2, "Music")))),
    }
end

local function takeNextFromBucket(a1, a2, a3) -- Line: 134 -- types: a1: table, a2: table
    local v1 = a2[a3]
    local v2 = a1[a3][v1]
    if v2 == nil then
        return nil
    end
    a2[a3] = v1 + 1
    return v2
end

local function takeNextFromFallbackBucket(a1, a2, a3, a4) -- Line: 148 -- types: a1: table, a2: table
    if a4 == a3 then
        return nil
    end
    local v1 = a2[a4]
    local v2 = a1[a4][v1]
    if v2 == nil then
        return nil
    end
    a2[a4] = v1 + 1
    return v2
end

local function takeNextPatternMedia(a1, a2, a3) -- Line: 160 -- types: a1: table, a2: table
    local v1
    local v2 = a2[a3]
    local v3 = a1[a3][v2]
    if v3 ~= nil then
        a2[a3] = v2 + 1
        v1 = v3
    else
        v1 = nil
    end
    if not v1 then
        if a3 ~= "Brainrot" then
            local Brainrot = a2.Brainrot
            v3 = a1.Brainrot[Brainrot]
            if v3 ~= nil then
                a2.Brainrot = Brainrot + 1
                v1 = v3
            else
                v1 = nil
            end
        else
            v1 = nil
        end
        if not v1 then
            if a3 ~= "Funny" then
                local Funny = a2.Funny
                v3 = a1.Funny[Funny]
                if v3 ~= nil then
                    a2.Funny = Funny + 1
                    v1 = v3
                else
                    v1 = nil
                end
            else
                v1 = nil
            end
            if not v1 then
                if a3 ~= "Satisfying" then
                    local Satisfying = a2.Satisfying
                    v3 = a1.Satisfying[Satisfying]
                    if v3 ~= nil then
                        a2.Satisfying = Satisfying + 1
                        v1 = v3
                    else
                        v1 = nil
                    end
                else
                    v1 = nil
                end
                if not v1 then
                    if a3 ~= "WeirdOrHorror" then
                        local WeirdOrHorror = a2.WeirdOrHorror
                        v3 = a1.WeirdOrHorror[WeirdOrHorror]
                        if v3 ~= nil then
                            a2.WeirdOrHorror = WeirdOrHorror + 1
                            v1 = v3
                        else
                            v1 = nil
                        end
                    else
                        v1 = nil
                    end
                    if not v1 then
                        if a3 ~= "Music" then
                            local Music = a2.Music
                            v3 = a1.Music[Music]
                            if v3 ~= nil then
                                a2.Music = Music + 1
                                v1 = v3
                            else
                                v1 = nil
                            end
                        else
                            v1 = nil
                        end
                    end
                end
            end
        end
    end
    assert(v1 ~= nil, "Expected unseen treadmill media while sequence is incomplete")
    return v1
end

local function generatePatternOrder(a1, a2, a3, a4, a5) -- Line: 185
    -- upvalues: createBucketOrders (val), u48 (val), u36 (val), takeNextPatternMedia (val)
    local v1
    local v2 = createBucketOrders(a1, a3, a4)
    local v3 = {
        Brainrot = 1,
        Funny = 1,
        Satisfying = 1,
        WeirdOrHorror = 1,
        Music = 1,
    }
    local v4 = table.create(a2)
    for i = 1, a2 do
        v1 = u36[(a5 + i - 1 - 1) % u48 + 1] or u36[1]
        v4[i] = (takeNextPatternMedia(v2, v3, v1))
    end
    return v4
end

local function generateFullPass(a1, a2) -- Line: 209
    -- upvalues: PathSeed (val), generatePatternOrder (val)
    return (generatePatternOrder(
        a1.BucketIndices,
        a1.TotalMediaCount,
        PathSeed("TreadmillMediaPass", a1.Seed, a2),
        "TreadmillMediaPassBucket",
        a2 * a1.TotalMediaCount + 1
    ))
end

local function resolveFullMediaIndex(a1, a2) -- Line: 224
    -- upvalues: PathSeed (val), generatePatternOrder (val)
    local v1 = math.floor((a2 - 1) / a1.TotalMediaCount)
    if a1.CachedPassNumber ~= v1 then
        a1.CachedPassOrder = generatePatternOrder(
            a1.BucketIndices,
            a1.TotalMediaCount,
            PathSeed("TreadmillMediaPass", a1.Seed, v1),
            "TreadmillMediaPassBucket",
            v1 * a1.TotalMediaCount + 1
        )
        a1.CachedPassNumber = v1
    end
    return a1.CachedPassOrder[(a2 - 1) % a1.TotalMediaCount + 1]
end

local function exportState(a1) -- Line: 237
    return {
        AlgorithmVersion = 5,
        Seed = a1.Seed,
        CurrentIndex = a1.CurrentIndex,
        HasSwappedRight = a1.HasSwappedRight,
        ReleaseTrackingInitialized = a1.ReleaseTrackingInitialized,
        FullFeedReleaseVersion = a1.FullFeedReleaseVersion,
        CompletedReleaseVersion = a1.CompletedReleaseVersion,
        PendingReleaseVersion = a1.PendingReleaseVersion,
        PendingCurrentMediaKey = a1.PendingCurrentMediaKey,
        SeenPendingMediaKeys = table.clone(a1.SeenPendingMediaKeys),
    }
end

local function statesEqual(a1, a2) -- Line: 254
    if a1.Seed == a2.Seed
        and a1.CurrentIndex == a2.CurrentIndex
        and a1.AlgorithmVersion == a2.AlgorithmVersion
        and a1.HasSwappedRight == a2.HasSwappedRight
        and a1.ReleaseTrackingInitialized == a2.ReleaseTrackingInitialized
        and a1.FullFeedReleaseVersion == a2.FullFeedReleaseVersion
        and a1.CompletedReleaseVersion == a2.CompletedReleaseVersion
        and a1.PendingReleaseVersion == a2.PendingReleaseVersion
        and a1.PendingCurrentMediaKey == a2.PendingCurrentMediaKey then
        for k, v in pairs(a1.SeenPendingMediaKeys) do
            if v ~= a2.SeenPendingMediaKeys[k] then
                return false
            end
        end
        for k2, i in pairs(a2.SeenPendingMediaKeys) do
            if i ~= a1.SeenPendingMediaKeys[k2] then
                return false
            end
        end
        return true
    end
    return false
end

local function rebuildFullFeedCatalog(a1, a2) -- Line: 285
    -- upvalues: createEmptyBucketIndices (val)
    local v1 = createEmptyBucketIndices()
    local v2 = 0
    for i, v in ipairs(a1.MediaEntries) do
        if v.ReleaseVersion <= a2 then
            table.insert(v1[v.BucketType], i)
            v2 = v2 + 1
        end
    end
    local v3 = ("Treadmill full feed release %* must not be empty"):format(a2)
    assert(v2 > 0, v3)
    a1.BucketIndices = v1
    a1.TotalMediaCount = v2
    a1.CachedPassNumber = nil
    a1.CachedPassOrder = {}
end

local function buildDeltaOrder(a1) -- Line: 304
    -- upvalues: createEmptyBucketIndices (val), TreadmillMediaIdentity (val), PathSeed (val)
    -- upvalues: generatePatternOrder (val)
    local v1 = createEmptyBucketIndices()
    local v2 = {}
    local v3 = 0
    for i, v in ipairs(a1.MediaEntries) do
        if a1.CompletedReleaseVersion < v.ReleaseVersion and v.ReleaseVersion <= a1.PendingReleaseVersion then
            v2[TreadmillMediaIdentity.GetMediaKey(v)] = i
            table.insert(v1[v.BucketType], i)
            v3 = v3 + 1
        end
    end
    a1.DeltaMediaIndexByKey = v2
    a1.DeltaPosition = 0
    a1.DeltaCurrentMediaIndex = nil
    if v3 == 0 then
        a1.DeltaOrder = {}
        return
    end
    a1.DeltaOrder = generatePatternOrder(v1, v3, PathSeed("TreadmillMediaDelta", a1.Seed, a1.PendingReleaseVersion), "TreadmillMediaDeltaBucket", 1)
    local PendingCurrentMediaKey = a1.PendingCurrentMediaKey
    if PendingCurrentMediaKey ~= nil then
        v3 = v2[PendingCurrentMediaKey]
        if v3 ~= nil then
            a1.DeltaCurrentMediaIndex = v3
            for i2, i3 in ipairs(a1.DeltaOrder) do
                if i3 == v3 then
                    a1.DeltaPosition = i2
                    return
                end
            end
            return
        end
        a1.PendingCurrentMediaKey = nil
    end
end

local function completeDelta(a1) -- Line: 348 -- upvalues: rebuildFullFeedCatalog (val)
    a1.CompletedReleaseVersion = a1.PendingReleaseVersion
    a1.PendingReleaseVersion = 0
    a1.PendingCurrentMediaKey = nil
    a1.SeenPendingMediaKeys = {}
    a1.DeltaOrder = {}
    a1.DeltaMediaIndexByKey = {}
    a1.DeltaCurrentMediaIndex = nil
    a1.DeltaPosition = 0
    a1.CurrentIndex = 0
    a1.FullFeedReleaseVersion = a1.CurrentReleaseVersion
    rebuildFullFeedCatalog(a1, a1.FullFeedReleaseVersion)
end

local function takeNextDeltaMedia(a1) -- Line: 362 -- upvalues: TreadmillMediaIdentity (val)
    local v1 = #a1.DeltaOrder
    local v2 = a1.DeltaPosition + 1
    if a1.DeltaCurrentMediaIndex == nil then
        v2 = 0
        for i, v in ipairs(a1.DeltaOrder) do
            if not a1.SeenPendingMediaKeys[(TreadmillMediaIdentity.GetMediaKey(a1.MediaEntries[v]))] then
                v2 = i
                break
            end
        end
    end
    if not (v2 < 1) and not (v1 < v2) then
        v1 = a1.DeltaOrder[v2]
        local v3 = TreadmillMediaIdentity.GetMediaKey(a1.MediaEntries[v1])
        a1.DeltaPosition = v2
        a1.DeltaCurrentMediaIndex = v1
        a1.PendingCurrentMediaKey = v3
        a1.SeenPendingMediaKeys[v3] = true
        return v1
    end
    return nil
end

local function takePreviousDeltaMedia(a1) -- Line: 388 -- upvalues: TreadmillMediaIdentity (val)
    local v1, v2
    for i = a1.DeltaPosition - 1, 1, -1 do
        v1 = a1.DeltaOrder[i]
        v2 = TreadmillMediaIdentity.GetMediaKey(a1.MediaEntries[v1])
        if a1.SeenPendingMediaKeys[v2] then
            a1.DeltaPosition = i
            a1.DeltaCurrentMediaIndex = v1
            a1.PendingCurrentMediaKey = v2
            return v1
        end
    end
    return nil
end

local function startDelta(a1) -- Line: 402
    -- upvalues: buildDeltaOrder (val), takeNextDeltaMedia (val), completeDelta (val)
    a1.PendingReleaseVersion = a1.CurrentReleaseVersion
    a1.PendingCurrentMediaKey = nil
    a1.SeenPendingMediaKeys = {}
    buildDeltaOrder(a1)
    local v1 = takeNextDeltaMedia(a1)
    if v1 == nil then
        completeDelta(a1)
    end
    return v1
end

local function takeNextFullMedia(a1) -- Line: 414 -- upvalues: PathSeed (val), generatePatternOrder (val)
    a1.CurrentIndex = a1.CurrentIndex + 1
    if a1.FullFeedReleaseVersion == a1.CurrentReleaseVersion and a1.TotalMediaCount <= a1.CurrentIndex then
        a1.CompletedReleaseVersion = math.max(a1.CompletedReleaseVersion, a1.FullFeedReleaseVersion)
    end
    local CurrentIndex_2 = a1.CurrentIndex
    local v1 = math.floor((CurrentIndex_2 - 1) / a1.TotalMediaCount)
    if a1.CachedPassNumber ~= v1 then
        a1.CachedPassOrder = generatePatternOrder(
            a1.BucketIndices,
            a1.TotalMediaCount,
            PathSeed("TreadmillMediaPass", a1.Seed, v1),
            "TreadmillMediaPassBucket",
            v1 * a1.TotalMediaCount + 1
        )
        a1.CachedPassNumber = v1
    end
    return a1.CachedPassOrder[(CurrentIndex_2 - 1) % a1.TotalMediaCount + 1]
end

function u51.IsReleaseTrackingStateCurrent(a1) -- Line: 430
    local ReleaseTrackingInitialized = false
    if 0 < a1.Seed then
        ReleaseTrackingInitialized = false
        if a1.AlgorithmVersion == 5 then
            ReleaseTrackingInitialized = false
            if a1.HasSwappedRight ~= nil then
                ReleaseTrackingInitialized = a1.ReleaseTrackingInitialized
            end
        end
    end
    return ReleaseTrackingInitialized
end

function u51.ResolveReleaseTrackingState(a1, a2, a3) -- Line: 439
    -- upvalues: u51 (val), TreadmillMediaCatalog (val), PathSeed (val)
    if u51.IsReleaseTrackingStateCurrent(a1) then
        return a1
    end
    local v1 = math.max(0, (math.floor(a1.CurrentIndex)))
    local v2 = false
    if 0 < a1.Seed then
        v2 = a1.AlgorithmVersion == 5
    end
    local BASELINE_RELEASE_VERSION = if not v2 then 0 else if not (TreadmillMediaCatalog.BASELINE_MEDIA_COUNT <= v1) then 0 else TreadmillMediaCatalog.BASELINE_RELEASE_VERSION
    local v3 = {AlgorithmVersion = 5, ReleaseTrackingInitialized = true, PendingReleaseVersion = 0}
    local Seed = if not v2 then 0 else a1.Seed
    v3.Seed = if not (Seed > 0) then PathSeed("TreadmillMediaFeed", a2) else math.floor(Seed)
    v3.CurrentIndex = if not (BASELINE_RELEASE_VERSION > 0) then 0 else v1
    v3.HasSwappedRight = a3
    local BASELINE_RELEASE_VERSION_2 = if not (BASELINE_RELEASE_VERSION > 0) then TreadmillMediaCatalog.CURRENT_RELEASE_VERSION else TreadmillMediaCatalog.BASELINE_RELEASE_VERSION
    v3.FullFeedReleaseVersion = BASELINE_RELEASE_VERSION_2
    v3.CompletedReleaseVersion = BASELINE_RELEASE_VERSION
    v3.SeenPendingMediaKeys = {}
    return v3
end

function u51.CreateRuntime(a1, a2, a3) -- Line: 472
    -- upvalues: createEmptyBucketIndices (val), TreadmillMediaCatalog (val), TreadmillMediaIdentity (val)
    -- upvalues: PathSeed (val), u50 (val), rebuildFullFeedCatalog (val), buildDeltaOrder (val)
    local v1
    assert(#a1 > 0, "Treadmill media catalog must not be empty")
    local v2 = createEmptyBucketIndices()
    local v3 = {}
    local CURRENT_RELEASE_VERSION = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION
    for i, v in ipairs(a1) do
        CURRENT_RELEASE_VERSION = math.max(CURRENT_RELEASE_VERSION, (TreadmillMediaCatalog.ResolveEntryReleaseVersion(v.ReleaseVersion)))
        v1 = TreadmillMediaIdentity.GetMediaKey(v)
        assert(not v3[v1], (("Duplicate treadmill media key \"%*\""):format(v1)))
        v3[v1] = true
        table.insert(v2[v.BucketType], i)
    end
    v3 = {
        CompletedReleaseVersion = 0,
        CurrentIndex = 0,
        DeltaPosition = 0,
        PendingReleaseVersion = 0,
        ReleaseTrackingInitialized = true,
        BucketIndices = v2,
    }
    v3.CachedPassOrder = {}
    v3.CurrentReleaseVersion = CURRENT_RELEASE_VERSION
    v3.DeltaMediaIndexByKey = {}
    v3.DeltaOrder = {}
    v3.FullFeedReleaseVersion = CURRENT_RELEASE_VERSION
    v3.HasSwappedRight = a2.HasSwappedRight == true
    v3.MediaEntries = a1
    local Seed = a2.Seed
    v3.Seed = if not (Seed > 0) then PathSeed("TreadmillMediaFeed", a3) else math.floor(Seed)
    v3.SeenPendingMediaKeys = {}
    v3.TotalMediaCount = #a1
    if a2.AlgorithmVersion ~= 5 then
        u50:AtTrace():Log("Resetting treadmill media feed state for algorithm version change")
        rebuildFullFeedCatalog(v3, v3.FullFeedReleaseVersion)
        return v3
    end
    v3.CurrentIndex = math.max(0, (math.floor(a2.CurrentIndex)))
    if a2.ReleaseTrackingInitialized then
        v3.FullFeedReleaseVersion = math.max(0, (math.floor(a2.FullFeedReleaseVersion)))
        v3.CompletedReleaseVersion = math.min(math.max(0, (math.floor(a2.CompletedReleaseVersion))), CURRENT_RELEASE_VERSION)
        v3.PendingReleaseVersion = math.max(0, (math.floor(a2.PendingReleaseVersion)))
        v3.PendingCurrentMediaKey = a2.PendingCurrentMediaKey
        v3.SeenPendingMediaKeys = table.clone(a2.SeenPendingMediaKeys)
    end
    if v3.CompletedReleaseVersion == 0 and v3.FullFeedReleaseVersion ~= CURRENT_RELEASE_VERSION then
        v3.CurrentIndex = 0
        v3.FullFeedReleaseVersion = CURRENT_RELEASE_VERSION
        v3.PendingReleaseVersion = 0
        v3.PendingCurrentMediaKey = nil
        v3.SeenPendingMediaKeys = {}
    end
    if 0 < v3.CompletedReleaseVersion and v3.FullFeedReleaseVersion == 0 then
        v3.FullFeedReleaseVersion = v3.CompletedReleaseVersion
    end
    if v3.PendingReleaseVersion <= v3.CompletedReleaseVersion then
        v3.PendingReleaseVersion = 0
        v3.PendingCurrentMediaKey = nil
        v3.SeenPendingMediaKeys = {}
    elseif not (CURRENT_RELEASE_VERSION < v3.PendingReleaseVersion) then
        buildDeltaOrder(v3)
    else
        v3.PendingReleaseVersion = 0
        v3.PendingCurrentMediaKey = nil
        v3.SeenPendingMediaKeys = {}
    end
    rebuildFullFeedCatalog(v3, v3.FullFeedReleaseVersion)
    return v3
end

function u51.Next(a1) -- Line: 558
    -- upvalues: takeNextDeltaMedia (val), exportState (val), completeDelta (val), startDelta (val), PathSeed (val)
    -- upvalues: generatePatternOrder (val)
    local v1
    a1.HasSwappedRight = true
    if a1.CompletedReleaseVersion < a1.PendingReleaseVersion then
        v1 = takeNextDeltaMedia(a1)
        if v1 ~= nil then
            return v1, (exportState(a1))
        end
        completeDelta(a1)
    end
    if 0 < a1.CompletedReleaseVersion and a1.CompletedReleaseVersion < a1.CurrentReleaseVersion then
        v1 = startDelta(a1)
        if v1 ~= nil then
            return v1, (exportState(a1))
        end
    end
    a1.CurrentIndex = a1.CurrentIndex + 1
    if a1.FullFeedReleaseVersion == a1.CurrentReleaseVersion and a1.TotalMediaCount <= a1.CurrentIndex then
        a1.CompletedReleaseVersion = math.max(a1.CompletedReleaseVersion, a1.FullFeedReleaseVersion)
    end
    local CurrentIndex_2 = a1.CurrentIndex
    local v2 = math.floor((CurrentIndex_2 - 1) / a1.TotalMediaCount)
    if a1.CachedPassNumber ~= v2 then
        a1.CachedPassOrder = generatePatternOrder(
            a1.BucketIndices,
            a1.TotalMediaCount,
            PathSeed("TreadmillMediaPass", a1.Seed, v2),
            "TreadmillMediaPassBucket",
            v2 * a1.TotalMediaCount + 1
        )
        a1.CachedPassNumber = v2
    end
    return a1.CachedPassOrder[(CurrentIndex_2 - 1) % a1.TotalMediaCount + 1], (exportState(a1))
end

function u51.Current(a1) -- Line: 583
    -- upvalues: exportState (val), takeNextDeltaMedia (val), completeDelta (val), PathSeed (val)
    -- upvalues: generatePatternOrder (val)
    local v1
    if a1.CompletedReleaseVersion < a1.PendingReleaseVersion then
        local DeltaCurrentMediaIndex = a1.DeltaCurrentMediaIndex
        if DeltaCurrentMediaIndex ~= nil then
            return DeltaCurrentMediaIndex, (exportState(a1))
        end
        v1 = takeNextDeltaMedia(a1)
        if v1 ~= nil then
            return v1, (exportState(a1))
        end
        completeDelta(a1)
    end
    v1 = math.max(a1.CurrentIndex, 1)
    a1.CurrentIndex = v1
    local v2 = math.floor((v1 - 1) / a1.TotalMediaCount)
    if a1.CachedPassNumber ~= v2 then
        a1.CachedPassOrder = generatePatternOrder(
            a1.BucketIndices,
            a1.TotalMediaCount,
            PathSeed("TreadmillMediaPass", a1.Seed, v2),
            "TreadmillMediaPassBucket",
            v2 * a1.TotalMediaCount + 1
        )
        a1.CachedPassNumber = v2
    end
    return a1.CachedPassOrder[(v1 - 1) % a1.TotalMediaCount + 1], (exportState(a1))
end

function u51.Previous(a1) -- Line: 603
    -- upvalues: takePreviousDeltaMedia (val), exportState (val), PathSeed (val), generatePatternOrder (val)
    local v1
    if a1.CompletedReleaseVersion < a1.PendingReleaseVersion then
        local DeltaCurrentMediaIndex = a1.DeltaCurrentMediaIndex
        assert(DeltaCurrentMediaIndex ~= nil, "Pending treadmill media delta must have a current media entry")
        v1 = takePreviousDeltaMedia(a1)
        if v1 == nil then
            return DeltaCurrentMediaIndex, (exportState(a1)), false
        end
        return v1, (exportState(a1)), true
    end
    local v2 = math.max(a1.CurrentIndex - 1, 1)
    v1 = v2 ~= a1.CurrentIndex
    a1.CurrentIndex = v2
    local v3 = math.floor((v2 - 1) / a1.TotalMediaCount)
    if a1.CachedPassNumber ~= v3 then
        a1.CachedPassOrder = generatePatternOrder(
            a1.BucketIndices,
            a1.TotalMediaCount,
            PathSeed("TreadmillMediaPass", a1.Seed, v3),
            "TreadmillMediaPassBucket",
            v3 * a1.TotalMediaCount + 1
        )
        a1.CachedPassNumber = v3
    end
    return a1.CachedPassOrder[(v2 - 1) % a1.TotalMediaCount + 1], (exportState(a1)), v1
end

function u51.ExportState(a1) -- Line: 625 -- upvalues: exportState (val)
    return (exportState(a1))
end

function u51.StatesEqual(a1, a2) -- Line: 631 -- upvalues: statesEqual (val)
    return (statesEqual(a1, a2))
end

function u51.IsLegalTransition(a1, a2, a3, a4) -- Line: 638
    -- upvalues: statesEqual (val), u51 (val)
    local v1, v2, v3, v4
    if statesEqual(a2, a3) then
        return true
    end
    _, v3 = u51.Current((u51.CreateRuntime(a1, a2, a4)))
    if statesEqual(v3, a3) then
        return true
    end
    if a2.CompletedReleaseVersion < a2.PendingReleaseVersion then
        local v5
        _, v5, v4 = u51.Previous((u51.CreateRuntime(a1, a2, a4)))
        if v4 and statesEqual(v5, a3) then
            return true
        end
        _, v2 = u51.Next((u51.CreateRuntime(a1, a2, a4)))
        return (statesEqual(v2, a3))
    end
    local v6 = u51.CreateRuntime(a1, a2, a4)
    if a2.PendingReleaseVersion == 0 and a3.PendingReleaseVersion == 0 and a3.CurrentIndex < a2.CurrentIndex then
        local v7
        v1, v2, v7 = u51.Previous(v6)
        if not v7 then
            return false
        end
        return (statesEqual(v2, a3))
    end
    v4, v1 = u51.Next(v6)
    return (statesEqual(v1, a3))
end

return u51