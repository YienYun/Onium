-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.RecommendationFeedSource
-- Decompile time: 8.51 ms

local RecommendationService = game:GetService("RecommendationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local RecommendationFlags = require(script.Parent.RecommendationFlags)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
require(script.Parent.Types.Interface)
local u43 = Log.new()
local u44 = nil
local u45 = {}
local u46 = {}
local u47 = 0
local u48 = nil
local u49 = 0
local u50 = false
local u51 = 0
local u52 = {}

local function buildMediaIndexMap(a1) -- Line: 41
    -- upvalues: u44 (ref), u45 (ref), TreadmillMediaIdentity (val)
    local v1
    if u44 == a1 then
        return
    end
    u44 = a1
    u45 = {}
    for i, v in ipairs(a1) do
        v1 = TreadmillMediaIdentity.GetMediaKey(v)
        if u45[v1] == nil then
            u45[v1] = i
        end
    end
end

local function appendCurrentPage(a1) -- Line: 56 -- upvalues: u45 (ref), TreadmillMediaOverlay (val), u46 (ref)
    local v1
    for i, v in ipairs((a1:GetCurrentPage())) do
        v1 = u45[v.ReferenceId]
        if v1 ~= nil and not TreadmillMediaOverlay.IsExcluded(v.ReferenceId) then
            table.insert(u46, {
                MediaIndex = v1,
                MediaKey = v.ReferenceId,
                ItemId = v.ItemId,
                TracingId = v.TracingId,
                ItemPosition = #u46 + 1,
            })
        end
    end
end

local function generateListAsync() -- Line: 75
    -- upvalues: Constants (val), RecommendationFlags (val), RecommendationService (val), u46 (ref), u47 (ref)
    -- upvalues: u48 (ref), u49 (ref), appendCurrentPage (val), u43 (val)
    if not Constants.IS_STUDIO and RecommendationFlags.Enabled:Get() then
        local success, err = pcall(function() -- Line: 80
            -- upvalues: RecommendationService (upval), RecommendationFlags (upval), u46 (upval), u47 (upval)
            -- upvalues: u48 (upval), u49 (upval), appendCurrentPage (upval)
            local v1 = RecommendationService:GenerateItemListAsync({
                LocationId = "TreadmillFeed",
                ConfigName = RecommendationFlags.ConfigName:Get(),
                PageSize = RecommendationFlags.PageSize:Get(),
            })
            u46 = {}
            u47 = 0
            u48 = v1
            os.clock()
            appendCurrentPage(v1)
        end)
        if not success then
            (u43:AtWarning()):Log((("Failed to generate treadmill recommendation list: %*"):format(err)))
            return false
        end
        ;(u43:AtTrace()):Log((("Generated treadmill recommendation list: %* items"):format(#u46)))
        return #u46 > 0
    end
    return false
end

local function prefetchNextPageAsync() -- Line: 102
    -- upvalues: Constants (val), RecommendationFlags (val), u50 (ref), u48 (ref), u51 (ref), appendCurrentPage (val)
    -- upvalues: u43 (val)
    if not Constants.IS_STUDIO and RecommendationFlags.Enabled:Get() then
        if not u50 and u48 ~= nil and not u48.IsFinished and not (os.clock() < u51) then
            u50 = true
            task.spawn(function() -- Line: 111
                -- upvalues: u48 (upval), appendCurrentPage (upval), u50 (upval), u51 (upval)
                -- upvalues: RecommendationFlags (upval), u43 (upval)
                local success, err = pcall(function() -- Line: 112 -- upvalues: u48 (upval), appendCurrentPage (upval)
                    u48:AdvanceToNextPageAsync()
                    appendCurrentPage(u48)
                end)
                u50 = false
                if not success then
                    u51 = os.clock() + RecommendationFlags.FailureCooldownSeconds:Get()
                    ;(u43:AtWarning()):Log((("Failed to advance treadmill recommendation page: %*"):format(err)))
                end
            end)
            return
        end
        return
    end
end

local function maybePrefetch() -- Line: 124
    -- upvalues: u46 (ref), u47 (ref), RecommendationFlags (val), prefetchNextPageAsync (val)
    if #u46 - u47 <= RecommendationFlags.PrefetchMargin:Get() then
        prefetchNextPageAsync()
    end
end

local function isSessionUsable() -- Line: 130 -- upvalues: u46 (ref), u49 (ref), RecommendationFlags (val)
    local v1 = false
    if #u46 > 0 then
        v1 = os.clock() - u49 < RecommendationFlags.StaleSeconds:Get()
    end
    return v1
end

function u52.PrefetchFeed(a1) -- Line: 135
    -- upvalues: buildMediaIndexMap (val), Constants (val), RecommendationFlags (val), u46 (ref), u49 (ref), u50 (ref)
    -- upvalues: u51 (ref), generateListAsync (val)
    buildMediaIndexMap(a1)
    if not Constants.IS_STUDIO and RecommendationFlags.Enabled:Get() then
        local v1 = false
        if #u46 > 0 then
            v1 = os.clock() - u49 < RecommendationFlags.StaleSeconds:Get()
        end
        if not v1 and not u50 and not (os.clock() < u51) then
            u50 = true
            task.spawn(function() -- Line: 146 -- upvalues: generateListAsync (upval), RecommendationFlags (upval), u50 (upval), u51 (upval)
                local v1 = generateListAsync()
                if not v1 then
                    task.wait(RecommendationFlags.FetchRetryDelaySeconds:Get())
                    v1 = generateListAsync()
                end
                u50 = false
                if not v1 then
                    u51 = os.clock() + RecommendationFlags.FailureCooldownSeconds:Get()
                end
            end)
            return
        end
        return
    end
end

function u52.GetReadyItem() -- Line: 160
    -- upvalues: Constants (val), RecommendationFlags (val), u46 (ref), u49 (ref), u47 (ref)
    -- upvalues: TreadmillMediaOverlay (val), prefetchNextPageAsync (val)
    if not Constants.IS_STUDIO and RecommendationFlags.Enabled:Get() then
        local v1
        local v2 = false
        if #u46 > 0 then
            v2 = os.clock() - u49 < RecommendationFlags.StaleSeconds:Get()
        end
        if not v2 then
            return nil
        end
        if u47 == 0 then
            u47 = 1
        end
        local v3 = u47
        v2 = #u46
        for i = v3, v2 do
            v1 = u46[i]
            if v1 ~= nil and not TreadmillMediaOverlay.IsExcluded(v1.MediaKey) then
                u47 = i
                if #u46 - u47 <= RecommendationFlags.PrefetchMargin:Get() then
                    prefetchNextPageAsync()
                end
                return v1
            end
        end
        if #u46 - u47 <= RecommendationFlags.PrefetchMargin:Get() then
            prefetchNextPageAsync()
        end
        return nil
    end
    return nil
end

function u52.Next() -- Line: 183
    -- upvalues: u46 (ref), u47 (ref), TreadmillMediaOverlay (val), RecommendationFlags (val)
    -- upvalues: prefetchNextPageAsync (val)
    local v1
    if #u46 == 0 then
        return nil
    end
    local v2 = #u46
    for i = 1, v2 do
        u47 = u47 + 1
        v1 = u47
        if #u46 < v1 then
            u47 = 1
        end
        v1 = u46[u47]
        if v1 ~= nil and not TreadmillMediaOverlay.IsExcluded(v1.MediaKey) then
            if #u46 - u47 <= RecommendationFlags.PrefetchMargin:Get() then
                prefetchNextPageAsync()
            end
            return v1
        end
    end
    if #u46 - u47 <= RecommendationFlags.PrefetchMargin:Get() then
        prefetchNextPageAsync()
    end
    return nil
end

function u52.Previous() -- Line: 204 -- upvalues: u46 (ref), u47 (ref), TreadmillMediaOverlay (val)
    local v1
    if #u46 == 0 then
        return nil, false
    end
    for i = u47 - 1, 1, -1 do
        v1 = u46[i]
        if v1 ~= nil and not TreadmillMediaOverlay.IsExcluded(v1.MediaKey) then
            u47 = i
            return v1, true
        end
    end
    u47 = math.clamp(u47, 1, #u46)
    return u46[u47], false
end

function u52.PeekAhead(a1) -- Line: 221
    -- upvalues: u46 (ref), u47 (ref), TreadmillMediaOverlay (val)
    local v1
    local v2 = {}
    local v3 = 0
    while #v2 < a1 do
        v3 = v3 + 1
        v1 = u46[u47 + v3]
        if v1 == nil then
            break
        end
        if not TreadmillMediaOverlay.IsExcluded(v1.MediaKey) then
            table.insert(v2, v1.MediaIndex)
        end
    end
    return v2
end

TreadmillMediaOverlay.Changed:Connect(function() -- Line: 238 -- upvalues: u44 (ref)
    u44 = nil
end)
RecommendationFlags.Enabled.Changed:Connect(function() -- Line: 241 -- upvalues: RecommendationFlags (val), u46 (ref), u47 (ref), u48 (ref), u49 (ref)
    if RecommendationFlags.Enabled:Get() then
        return
    end
    u46 = {}
    u47 = 0
    u48 = nil
    u49 = 0
end)
RecommendationFlags.ConfigName.Changed:Connect(function() -- Line: 253 -- upvalues: u49 (ref), RecommendationFlags (val), u44 (ref), u52 (val)
    u49 = 0
    task.delay(math.random() * RecommendationFlags.ConfigSwapSpreadSeconds:Get(), function() -- Line: 255 -- upvalues: u44 (upval), u52 (upval)
        local v1 = u44
        if v1 ~= nil then
            u52.PrefetchFeed(v1)
        end
    end)
end)
return u52