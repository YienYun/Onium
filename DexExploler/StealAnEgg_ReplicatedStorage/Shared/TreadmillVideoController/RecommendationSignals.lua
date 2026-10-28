-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.RecommendationSignals
-- Decompile time: 4.26 ms

local RecommendationService = game:GetService("RecommendationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
require(script.Parent.RecommendationFeedSource)
local u25 = require(script.Parent.RecommendationFlags)
local u27 = Log.new()
local u28 = nil
local u29 = {}

local function resolveDepartureIntent(a1, a2, a3) -- Line: 30 -- types: a1: table, a2: number, a3: number?
    if not a1.Ended and not a1.Engaged then
        if a3 ~= nil and a3 >= 0.8 then
            return Enum.RecommendationDepartureIntent.Positive
        end
        if a2 < 3 then
            return Enum.RecommendationDepartureIntent.Negative
        end
        if a3 ~= nil and a3 < 0.25 then
            return Enum.RecommendationDepartureIntent.Negative
        end
        return Enum.RecommendationDepartureIntent.Neutral
    end
    return Enum.RecommendationDepartureIntent.Positive
end

local function logAction(a1, a2, a3) -- Line: 50
    -- upvalues: u25 (val), RecommendationService (val), u27 (val)
    if not u25.Enabled:Get() then
        return
    end
    local success, err = pcall(function() -- Line: 60 -- upvalues: RecommendationService (upval), a2 (val), a1 (val), a3 (val)
        RecommendationService:LogActionEvent(a2, a1.ItemId, a1.TracingId, a3)
    end)
    if not success then
        (u27:AtWarning()):Log((("Failed to log treadmill recommendation action: %*"):format(err)))
    end
end

function u29.HasActiveView() -- Line: 69 -- upvalues: u28 (ref)
    return u28 ~= nil
end

function u29.EndView(a1) -- Line: 71
    -- upvalues: u28 (ref), u25 (val), resolveDepartureIntent (val), RecommendationService (val), u27 (val)
    local u1 = u28
    u28 = nil
    if u1 == nil or not u25.Enabled:Get() then
        return
    end
    local u11 = os.clock() - u1.StartedAt
    local u16 = resolveDepartureIntent(u1, u11, a1)
    local success, err = pcall(function() -- Line: 85 -- upvalues: RecommendationService (upval), u1 (val), u11 (val), u16 (val)
        RecommendationService:LogImpressionEvent(Enum.RecommendationImpressionType.View, u1.Item.ItemId, u1.Item.TracingId, {
            Weight = 1,
            Duration = u11,
            ItemPosition = u1.Item.ItemPosition,
            DepartureIntent = u16,
        })
    end)
    if not success then
        (u27:AtWarning()):Log((("Failed to log treadmill recommendation impression: %*"):format(err)))
    end
end

function u29.BeginView(a1) -- Line: 104 -- upvalues: u29 (val), u28 (ref)
    u29.EndView(nil)
    u28 = {Ended = false, Engaged = false, Item = a1, StartedAt = os.clock()}
end

function u29.MarkEnded() -- Line: 114 -- upvalues: u28 (ref)
    local v1 = u28
    if v1 ~= nil then
        v1.Ended = true
    end
end

function u29.NotifyLikeResult(a1, a2) -- Line: 121
    -- upvalues: u28 (ref), logAction (val)
    local v1 = u28
    if v1 ~= nil and v1.Item.MediaKey == a1 then
        if a2 then
            v1.Engaged = true
        end
        logAction(
            v1.Item,
            if not a2 then Enum.RecommendationActionType.RemoveReaction else Enum.RecommendationActionType.AddReaction,
            {ReactionType = "Like"}
        )
        return
    end
end

function u29.NotifyCommentPosted(a1) -- Line: 139 -- upvalues: u28 (ref), logAction (val) -- types: a1: string
    local v1 = u28
    if v1 ~= nil and v1.Item.MediaKey == a1 then
        v1.Engaged = true
        logAction(v1.Item, Enum.RecommendationActionType.Comment, nil)
        return
    end
end

function u29.NotifyShared() -- Line: 149 -- upvalues: u28 (ref), logAction (val)
    local v1 = u28
    if v1 == nil then
        return
    end
    v1.Engaged = true
    logAction(v1.Item, Enum.RecommendationActionType.Share, nil)
end

return u29