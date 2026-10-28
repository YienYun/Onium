-- Script path: ReplicatedStorage.Client.VideoComments
-- Decompile time: 9.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
require(ReplicatedStorage.Shared.Globals.Constants)
local TreadmillMediaComments = require(ReplicatedStorage.Shared.Types.TreadmillMediaComments)
local Log = require(ReplicatedStorage.Packages.Log)
local RecommendationSignals = require(ReplicatedStorage.Shared.TreadmillVideoController.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Shared.Modules.TreadmillMediaCommentsConfig)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Schema = TreadmillMediaComments.Schema
require(script.Types.Interface)
local u60 = Log.new()
local u61 = {}
local u62 = {}
local u63 = false
local u64 = false
local u65 = {}
local u66 = {}
u66.CommentCountChanged = Signal.new()

local function getInvokeError(a1) -- Line: 49
    if typeof(a1) == "string" then
        return a1
    end
    return "RequestFailed"
end

local function setCachedCommentCount(a1, a2) -- Line: 57
    -- upvalues: u61 (val), u66 (val)
    local v1 = math.max(0, (math.floor(a2)))
    local v2 = u61[a1]
    if v2 ~= nil then
        v1 = math.max(v2, v1)
    end
    if v2 == v1 then
        return
    end
    u61[a1] = v1
    u66.CommentCountChanged:Fire(a1, v1)
end

local function refreshCommentCountCache() -- Line: 71 -- upvalues: u62 (val), u65 (val), u66 (val), u61 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = nil
    local v8 = nil
    for i, j in u62, v7, v8 do
        v3 = {}
        for k, n in j do
            v3[n] = u65[n] or 0
        end
        v4 = u66.RequestCommentCounts(j)
        if not v4.Ok then
            return "failed"
        end
        if not v4.Loaded then
            return "unloaded"
        end
        v5 = nil
        v6 = nil
        for m, i5 in v4.CountsByMediaKey, v5, v6 do
            v1 = u65[m] or 0
            if v1 == v3[m] then
                v1 = math.max(0, (math.floor(i5)))
                v2 = u61[m]
                if v2 ~= nil then
                    v1 = math.max(v2, v1)
                end
                if v2 ~= v1 then
                    u61[m] = v1
                    u66.CommentCountChanged:Fire(m, v1)
                end
            end
        end
    end
    return "loaded"
end

local function startCommentCountRefreshLoop() -- Line: 100
    -- upvalues: u64 (ref), TreadmillFlags (val), refreshCommentCountCache (val), u63 (ref)
    task.spawn(function() -- Line: 101 -- upvalues: u64 (upval), TreadmillFlags (upval), refreshCommentCountCache (upval), u63 (upval)
        while u64 do
            if not TreadmillFlags.CommentsDisabled:Get() then
                if refreshCommentCountCache() == "loaded" then
                    u63 = true
                end
                task.wait(if u63 then 180 else 2)
            else
                task.wait(5)
            end
        end
    end)
end

function u66.StartCommentCountCache(a1) -- Line: 123
    -- upvalues: t (val), u64 (ref), TreadmillMediaCommentsConfig (val), u62 (val), TreadmillFlags (val)
    -- upvalues: refreshCommentCountCache (val), u63 (ref)
    t.strict(t.table)(a1)
    if u64 then
        return
    end
    u64 = true
    local v1 = {}
    local v2 = {}
    for i, j in a1 do
        t.strict(t.string)(j)
        if not v1[j] then
            v1[j] = true
            table.insert(v2, j)
            if TreadmillMediaCommentsConfig.COMMENT_COUNT_KEYS_PER_REQUEST <= #v2 then
                table.insert(u62, v2)
                v2 = {}
            end
        end
    end
    if #v2 > 0 then
        table.insert(u62, v2)
    end
    task.spawn(function() -- Line: 101 -- upvalues: u64 (upval), TreadmillFlags (upval), refreshCommentCountCache (upval), u63 (upval)
        while u64 do
            if not TreadmillFlags.CommentsDisabled:Get() then
                if refreshCommentCountCache() == "loaded" then
                    u63 = true
                end
                task.wait(if u63 then 180 else 2)
            else
                task.wait(5)
            end
        end
    end)
end

function u66.GetCachedCommentCount(a1) -- Line: 153 -- upvalues: t (val), u61 (val) -- types: a1: string
    t.strict(t.string)(a1)
    return u61[a1]
end

function u66.ReconcileCommentCount(a1, a2) -- Line: 158
    -- upvalues: t (val), u65 (val), u61 (val), u66 (val)
    t.strict(t.string)(a1)
    t.strict(t.number)(a2)
    u65[a1] = (u65[a1] or 0) + 1
    local v1 = math.max(0, (math.floor(a2)))
    local v2 = u61[a1]
    if v2 ~= nil then
        v1 = math.max(v2, v1)
    end
    if v2 == v1 then
        return
    end
    u61[a1] = v1
    u66.CommentCountChanged:Fire(a1, v1)
end

function u66.RequestCommentPage(a1, a2, a3) -- Line: 167
    -- upvalues: TreadmillFlags (val), t (val), TryCall (val), Remotes (val), u60 (val), Schema (val)
    if TreadmillFlags.CommentsDisabled:Get() then
        return {Ok = false, Error = "CommentsDisabled"}
    end
    t.strict(t.string)(a1)
    t.strict(t.optional(t.number))(a2)
    t.strict(t.optional(t.number))(a3)
    local v1, v2 = TryCall(function() -- Line: 180 -- upvalues: Remotes (upval), a1 (val), a2 (val), a3 (val)
        return Remotes.Treadmill.AskReplyPage:InvokeServer({MediaKey = a1, Cursor = a2, PageSize = a3})
    end)
    if not v1 then
        (u60:AtWarning()):Log((("Failed treadmill comment page request: %*"):format(v2)))
        return {Ok = false, Error = if typeof(v2) ~= "string" then "RequestFailed" else v2}
    end
    if not Schema.CommentPageResult(v2) then
        u60:AtWarning():Log("Rejected invalid treadmill comment page response")
        return {Ok = false, Error = "InvalidResponse"}
    end
    if not v2.Ok then
        return {Ok = false, Error = v2.Error or "RequestFailed"}
    end
    local v3 = {Ok = true, TotalCreatedCount = v2.TotalCreatedCount or 0}
    local Comments = v2.Comments or {}
    v3.Comments = Comments
    v3.NextCursor = v2.NextCursor
    return v3
end

function u66.RequestCommentCounts(a1) -- Line: 212
    -- upvalues: TreadmillFlags (val), t (val), TryCall (val), Remotes (val), u60 (val), Schema (val)
    if TreadmillFlags.CommentsDisabled:Get() then
        return {
            Ok = false,
            Error = "CommentsDisabled",
            Loaded = false,
            Stale = true,
            CountsByMediaKey = {},
        }
    end
    t.strict(t.table)(a1)
    local v1, v2 = TryCall(function() -- Line: 219 -- upvalues: Remotes (upval), a1 (val)
        return Remotes.Treadmill.AskReplyCounts:InvokeServer({MediaKeys = a1})
    end)
    if not v1 then
        (u60:AtWarning()):Log((("Failed treadmill comment counts request: %*"):format(v2)))
        return {
            Ok = false,
            Loaded = false,
            Stale = true,
            CountsByMediaKey = {},
            Error = if typeof(v2) ~= "string" then "RequestFailed" else v2,
        }
    end
    if not Schema.CommentCountsResult(v2) then
        u60:AtWarning():Log("Rejected invalid treadmill comment counts response")
        return {
            Ok = false,
            Loaded = false,
            Stale = true,
            Error = "InvalidResponse",
            CountsByMediaKey = {},
        }
    end
    if not v2.Ok then
        return {
            Ok = false,
            CountsByMediaKey = {},
            Loaded = v2.Loaded == true,
            Stale = v2.Stale ~= false,
            Error = v2.Error or "RequestFailed",
        }
    end
    local v3 = {Ok = true}
    local CountsByMediaKey = v2.CountsByMediaKey or {}
    v3.CountsByMediaKey = CountsByMediaKey
    v3.Loaded = v2.Loaded == true
    v3.Stale = v2.Stale == true
    return v3
end

function u66.PostComment(a1, a2, a3) -- Line: 267
    -- upvalues: TreadmillFlags (val), t (val), TryCall (val), Remotes (val), u60 (val), Schema (val)
    -- upvalues: RecommendationSignals (val)
    if TreadmillFlags.CommentsDisabled:Get() then
        return {Ok = false, Error = "CommentsDisabled"}
    end
    t.strict(t.string)(a1)
    t.strict(t.string)(a2)
    t.strict(t.optional(t.number))(a3)
    local v1, v2 = TryCall(function() -- Line: 280 -- upvalues: Remotes (upval), a1 (val), a2 (val), a3 (val)
        return Remotes.Treadmill.AskPostReply:InvokeServer({MediaKey = a1, Message = a2, ImageAssetId = a3})
    end)
    if not v1 then
        (u60:AtWarning()):Log((("Failed treadmill post comment request: %*"):format(v2)))
        return {Ok = false, Error = if typeof(v2) ~= "string" then "RequestFailed" else v2}
    end
    if not Schema.PostCommentResult(v2) then
        u60:AtWarning():Log("Rejected invalid treadmill post comment response")
        return {Ok = false, Error = "InvalidResponse"}
    end
    if v2.Ok and v2.Comment ~= nil then
        RecommendationSignals.NotifyCommentPosted(a1)
        return {Ok = true, Comment = v2.Comment, Pending = v2.Pending == true}
    end
    return {Ok = false, Error = v2.Error or "RequestFailed"}
end

function u66.SetCommentLike(a1, a2, a3) -- Line: 313
    -- upvalues: TreadmillFlags (val), t (val), TryCall (val), Remotes (val), u60 (val), Schema (val)
    if TreadmillFlags.CommentsDisabled:Get() then
        return {Ok = false, Error = "CommentsDisabled", CommentId = a2}
    end
    t.strict(t.string)(a1)
    t.strict(t.string)(a2)
    t.strict(t.boolean)(a3)
    local v1, v2 = TryCall(function() -- Line: 326 -- upvalues: Remotes (upval), a1 (val), a2 (val), a3 (val)
        return Remotes.Treadmill.AskReplyFavour:InvokeServer({MediaKey = a1, CommentId = a2, Liked = a3})
    end)
    if not v1 then
        (u60:AtWarning()):Log((("Failed treadmill comment like request: %*"):format(v2)))
        return {
            Ok = false,
            Error = if typeof(v2) ~= "string" then "RequestFailed" else v2,
            CommentId = a2,
        }
    end
    if not Schema.SetCommentLikeResult(v2) then
        u60:AtWarning():Log("Rejected invalid treadmill comment like response")
        return {Ok = false, Error = "InvalidResponse", CommentId = a2}
    end
    if not v2.Ok then
        return {
            Ok = false,
            Error = v2.Error or "RequestFailed",
            CommentId = v2.CommentId or a2,
            LikeCount = v2.LikeCount,
        }
    end
    return {
        Ok = true,
        CommentId = v2.CommentId or a2,
        Liked = v2.Liked == true,
        Delta = v2.Delta or 0,
        LikeCount = v2.LikeCount or 0,
    }
end

return u66