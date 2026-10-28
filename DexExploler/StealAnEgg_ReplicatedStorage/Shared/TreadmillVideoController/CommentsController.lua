-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.CommentsController
-- Decompile time: 27.19 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CommentRenderer = require(script.CommentRenderer)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(script.Parent.Media)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PhotoInputController = require(script.PhotoInputController)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Shared.Modules.TreadmillMediaCommentsConfig)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
require(ReplicatedStorage.Client.VideoComments.Types.Interface)
local VideoComments = require(ReplicatedStorage.Client.VideoComments)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u107 = Color3.fromRGB(232, 158, 158)
local u112 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u116 = UDim2.fromScale(0.98, 0.65)
local u118 = Log.new()
local u119 = {}
local u120 = nil
local u121 = nil
local u122 = nil
local u123 = false
local u124 = {}
local u125 = nil
local u126 = nil
local u127 = false
local u128 = false
local u129 = false
local u130 = ""
local u131 = nil
local u132 = 1
local u133 = 0
local u134 = nil
local u135 = {}
local u136 = nil
local u137 = {}
local u138 = 0
local u139 = nil

local function u140(a1) end

local u141 = nil
local u142 = nil
local u143 = 0
local u144 = nil

local function u145() end

local u146 = {}

local function trim(a1) -- Line: 80 -- types: a1: string
    return a1:match("^%s*(.-)%s*$") or ""
end

local function characterCount(a1) -- Line: 82 -- types: a1: string
    local v1 = utf8.len(a1)
    assert(v1 ~= nil, "Comment text must contain valid UTF-8")
    return v1
end

local function showTooLongNotification() -- Line: 88 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Your message is too long, please make it shorter!",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showAlreadyCommentedNotification() -- Line: 98 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "You already commented this video.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showInvalidImageNotification() -- Line: 108 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Invalid image, please upload another image.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showImageLookupFailedNotification() -- Line: 118 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Something went wrong, please try again later.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showPostRateLimitNotification() -- Line: 128 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "You're doing this too fast, please wait a bit.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showFilteredCommentNotification() -- Line: 138 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Your comment was filtered, please try another message!",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function isRateLimitError(a1) -- Line: 148 -- types: a1: string?
    local v1 = true
    if a1 ~= "You're doing that too fast!" then
        v1 = a1 == "You're on cooldown. Please try again later."
    end
    return v1
end

local function formatCommentsTitle(a1) -- Line: 152 -- upvalues: Simple (val) -- types: a1: number
    if a1 == 1 then
        return "1 comment"
    end
    return (("%* comments"):format((Simple.FormatCompact(a1, ".#"))))
end

local function projectCount(a1) -- Line: 158
    -- upvalues: u143 (ref), u141 (ref), Simple (val), u142 (ref)
    u143 = math.max(0, a1)
    u141.Text = Simple.FormatCompact(u143, ".#")
    local Title = u142.Sheet.Header.Content.SubContent.Title
    local v1 = u143
    Title.Text = if v1 ~= 1 then ("%* comments"):format((Simple.FormatCompact(v1, ".#"))) else "1 comment"
end

local function updateEmptyState() -- Line: 164 -- upvalues: u137 (val), u128 (ref), u121 (ref), u134 (ref)
    local v1 = false
    if next(u137) == nil then
        v1 = not u128
    end
    u121.Visible = not v1
    u134.Visible = v1
end

local function clearRows() -- Line: 170
    -- upvalues: u137 (val), u119 (val), u135 (val), u132 (ref), u133 (ref), u121 (ref)
    for i, j in u137 do
        j.Destroy()
        u137[i] = nil
    end
    table.clear(u119)
    table.clear(u135)
    u132 = 1
    u133 = 0
    u121.CanvasPosition = Vector2.zero
end

local function renderComment(a1, a2) -- Line: 183
    -- upvalues: u137 (val), u119 (val), CommentRenderer (val), u139 (ref), u121 (ref), u146 (val)
    if u137[a1.Id] ~= nil then
        return
    end
    u119[a1.Id] = a1
    u137[a1.Id] = (CommentRenderer.Create(u139, u121, a1, a2, u146.ToggleLike))
end

local function requestPage() -- Line: 198
    -- upvalues: u127 (ref), u128 (ref), u123 (ref), u131 (ref), u130 (ref), u137 (val), u121 (ref), u134 (ref)
    -- upvalues: u138 (ref), VideoComments (val), TreadmillMediaCommentsConfig (val), u118 (val), u132 (ref), u119 (val)
    -- upvalues: CommentRenderer (val), u139 (ref), u146 (val)
    if u127 and not u128 and u123 and u131 ~= nil and u130 ~= "" then
        u128 = true
        local v1 = false
        if next(u137) == nil then
            v1 = not u128
        end
        u121.Visible = not v1
        u134.Visible = v1
        local u16 = u131
        local u17 = u138
        local u18 = u130
        task.spawn(function() -- Line: 208
            -- upvalues: VideoComments (upval), u18 (val), u16 (val), TreadmillMediaCommentsConfig (upval), u127 (upval)
            -- upvalues: u17 (val), u138 (upval), u128 (upval), u123 (upval), u131 (upval), u137 (upval), u121 (upval)
            -- upvalues: u134 (upval), u118 (upval), u132 (upval), u119 (upval), CommentRenderer (upval), u139 (upval)
            -- upvalues: u146 (upval)
            local v1 = VideoComments.RequestCommentPage(u18, u16, TreadmillMediaCommentsConfig.COMMENT_PAGE_SIZE)
            if u127 and u17 == u138 then
                local v2
                u128 = false
                if not v1.Ok then
                    u123 = false
                    u131 = nil
                    local v3 = false
                    if next(u137) == nil then
                        v3 = not u128
                    end
                    u121.Visible = not v3
                    u134.Visible = v3
                    ;(u118:AtTrace()):Log((("Unable to load treadmill comments: %*"):format(v1.Error)))
                    return
                end
                VideoComments.ReconcileCommentCount(u18, v1.TotalCreatedCount)
                local v4 = nil
                local v5 = nil
                for i, j in v1.Comments, v4, v5 do
                    v2 = u132
                    if u137[j.Id] == nil then
                        u119[j.Id] = j
                        u137[j.Id] = (CommentRenderer.Create(u139, u121, j, v2, u146.ToggleLike))
                    end
                    u132 = u132 + 1
                end
                u131 = v1.NextCursor
                u123 = v1.NextCursor ~= nil
                v1 = false
                if next(u137) == nil then
                    v1 = not u128
                end
                u121.Visible = not v1
                u134.Visible = v1
                return
            end
        end)
        return
    end
end

local function requestInitialPage() -- Line: 239
    -- upvalues: u138 (ref), u131 (ref), u123 (ref), u128 (ref), requestPage (val)
    u138 = u138 + 1
    u131 = 0
    u123 = true
    u128 = false
    requestPage()
end

local function updateInputLimitPresentation() -- Line: 247
    -- upvalues: u125 (ref), TreadmillMediaCommentsConfig (val), u107 (val), u122 (ref), u126 (ref), TweenService (val)
    -- upvalues: u112 (val)
    local Text = u125.Text
    local v1 = utf8.len(Text)
    assert(v1 ~= nil, "Comment text must contain valid UTF-8")
    local v2 = if not (TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS <= v1) then u122 else u107
    if u126 ~= nil then
        u126:Cancel()
    end
    v1 = TweenService:Create(u125, u112, {BackgroundColor3 = v2})
    u126 = v1
    v1:Play()
end

local function postComment() -- Line: 262
    -- upvalues: u129 (ref), u130 (ref), u124 (val), Toast (val), u145 (ref), u125 (ref)
    -- upvalues: TreadmillMediaCommentsConfig (val), u136 (ref), u138 (ref), VideoComments (val), u118 (val), u133 (ref)
    -- upvalues: u137 (val), u119 (val), CommentRenderer (val), u139 (ref), u121 (ref), u146 (val), u143 (ref)
    -- upvalues: u128 (ref), u134 (ref)
    if not u129 and u130 ~= "" then
        if u124[u130] then
            Toast.Show({
                Lane = "Banner",
                Text = "You already commented this video.",
                Seconds = 3,
                ShowShadow = true,
                Color = Color3.new(1, 1, 1),
            })
            return
        end
        u145()
        local Text = u125.Text
        local v1 = utf8.len(Text)
        assert(v1 ~= nil, "Comment text must contain valid UTF-8")
        if TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS < v1 then
            Toast.Show({
                Lane = "Banner",
                Text = "Your message is too long, please make it shorter!",
                Seconds = 3,
                ShowShadow = true,
                Color = Color3.new(1, 1, 1),
            })
            return
        end
        local u44 = Text:match("^%s*(.-)%s*$") or ""
        local u49 = u136:GetImageAssetId()
        if u44 == "" and u49 == nil then
            return
        end
        u129 = true
        local u51 = u138
        local u52 = u130
        task.spawn(function() -- Line: 288
            -- upvalues: VideoComments (upval), u52 (val), u44 (val), u49 (val), u51 (val), u138 (upval), u129 (upval)
            -- upvalues: u124 (upval), Toast (upval), u118 (upval), u125 (upval), u136 (upval), u133 (upval)
            -- upvalues: u137 (upval), u119 (upval), CommentRenderer (upval), u139 (upval), u121 (upval), u146 (upval)
            -- upvalues: u143 (upval), u128 (upval), u134 (upval)
            local v1 = VideoComments.PostComment(u52, u44, u49)
            if u51 ~= u138 then
                return
            end
            u129 = false
            if not v1.Ok then
                if v1.Error == "AlreadyCommented" then
                    u124[u52] = true
                    Toast.Show({
                        Lane = "Banner",
                        Text = "You already commented this video.",
                        Seconds = 3,
                        ShowShadow = true,
                        Color = Color3.new(1, 1, 1),
                    })
                elseif v1.Error == "MessageFiltered" then
                    Toast.Show({
                        Lane = "Banner",
                        Text = "Your comment was filtered, please try another message!",
                        Seconds = 3,
                        ShowShadow = true,
                        Color = Color3.new(1, 1, 1),
                    })
                elseif v1.Error == "InvalidImageAssetId" then
                    Toast.Show({
                        Lane = "Banner",
                        Text = "Invalid image, please upload another image.",
                        Seconds = 3,
                        ShowShadow = true,
                        Color = Color3.new(1, 1, 1),
                    })
                elseif v1.Error ~= "ImageAssetLookupFailed" then
                    local Error = v1.Error
                    local v2 = true
                    if Error ~= "You're doing that too fast!" then
                        v2 = Error == "You're on cooldown. Please try again later."
                    end
                    if v2 then
                        Toast.Show({
                            Lane = "Banner",
                            Text = "You're doing this too fast, please wait a bit.",
                            Seconds = 3,
                            ShowShadow = true,
                            Color = Color3.new(1, 1, 1),
                        })
                    end
                else
                    Toast.Show({
                        Lane = "Banner",
                        Text = "Something went wrong, please try again later.",
                        Seconds = 3,
                        ShowShadow = true,
                        Color = Color3.new(1, 1, 1),
                    })
                end
                ;(u118:AtTrace()):Log((("Unable to post treadmill comment: %*"):format(v1.Error)))
                return
            end
            u124[u52] = true
            u125.Text = ""
            u136:Reset()
            u133 = u133 - 1
            local Comment = v1.Comment
            local v3 = u133
            if u137[Comment.Id] == nil then
                u119[Comment.Id] = Comment
                u137[Comment.Id] = (CommentRenderer.Create(u139, u121, Comment, v3, u146.ToggleLike))
            end
            VideoComments.ReconcileCommentCount(u52, u143 + 1)
            v1 = false
            if next(u137) == nil then
                v1 = not u128
            end
            u121.Visible = not v1
            u134.Visible = v1
            u121.CanvasPosition = Vector2.zero
        end)
        return
    end
end

local function open() -- Line: 324
    -- upvalues: u127 (ref), u130 (ref), TreadmillFlags (val), u145 (ref), u142 (ref), u140 (ref), clearRows (val)
    -- upvalues: u137 (val), u128 (ref), u121 (ref), u134 (ref), u138 (ref), u131 (ref), u123 (ref), requestPage (val)
    if not u127 and u130 ~= "" and not TreadmillFlags.CommentsDisabled:Get() then
        u145()
        u127 = true
        u142.Visible = true
        u140(false)
        clearRows()
        local v1 = false
        if next(u137) == nil then
            v1 = not u128
        end
        u121.Visible = not v1
        u134.Visible = v1
        u138 = u138 + 1
        u131 = 0
        u123 = true
        u128 = false
        requestPage()
        return
    end
end

local function handleScroll() -- Line: 338 -- upvalues: u127 (ref), u123 (ref), u121 (ref), requestPage (val)
    if u127 and u123 then
        if u121.AbsoluteCanvasSize.Y - u121.CanvasPosition.Y - u121.AbsoluteWindowSize.Y <= 64 then
            requestPage()
        end
        return
    end
end

local function handleMediaChanged(a1, a2) -- Line: 351
    -- upvalues: TreadmillMediaIdentity (val), u146 (val), u120 (ref), TreadmillFlags (val), u130 (ref)
    -- upvalues: VideoComments (val), u143 (ref), u141 (ref), Simple (val), u142 (ref)
    local v1 = TreadmillMediaIdentity.GetMediaKey(a1)
    u146.Close()
    u120.Adornee = a2
    u120.Enabled = not TreadmillFlags.CommentsDisabled:Get()
    u130 = v1
    u143 = math.max(0, (VideoComments.GetCachedCommentCount(v1)) or 0)
    u141.Text = Simple.FormatCompact(u143, ".#")
    local Title = u142.Sheet.Header.Content.SubContent.Title
    local v2 = u143
    Title.Text = if v2 ~= 1 then ("%* comments"):format((Simple.FormatCompact(v2, ".#"))) else "1 comment"
end

function u146.ToggleLike(a1) -- Line: 367
    -- upvalues: u135 (val), u119 (val), u137 (val), u145 (ref), u138 (ref), u130 (ref), VideoComments (val)
    if u135[a1] then
        return
    end
    local v1 = u119[a1]
    local v2 = u137[a1]
    local v3 = false
    if v1 ~= nil then
        v3 = v2 ~= nil
    end
    assert(v3, (("Missing rendered comment %*"):format(a1)))
    u145()
    u135[a1] = true
    local LikedByViewer = v1.LikedByViewer
    local LikeCount = v1.LikeCount
    local u26 = not LikedByViewer
    v1.LikedByViewer = u26
    v1.LikeCount = math.max(0, LikeCount + (if not u26 then -1 else 1))
    v2.UpdateLike(v1.LikedByViewer, v1.LikeCount)
    local u43 = u138
    local u44 = u130
    task.spawn(function() -- Line: 387
        -- upvalues: VideoComments (upval), u44 (val), a1 (val), u26 (val), u43 (val), u138 (upval), u135 (upval)
        -- upvalues: u119 (upval), u137 (upval), LikedByViewer (val), LikeCount (val)
        local v1 = VideoComments.SetCommentLike(u44, a1, u26)
        if u43 ~= u138 then
            return
        end
        u135[a1] = nil
        local v2 = u119[a1]
        local v3 = u137[a1]
        if v2 ~= nil and v3 ~= nil then
            if not v1.Ok then
                v2.LikedByViewer = LikedByViewer
                v2.LikeCount = LikeCount
            else
                v2.LikedByViewer = v1.Liked
                v2.LikeCount = math.max(0, v1.LikeCount)
            end
            v3.UpdateLike(v2.LikedByViewer, v2.LikeCount)
            return
        end
    end)
end

function u146.Close() -- Line: 411
    -- upvalues: u138 (ref), u127 (ref), u128 (ref), u129 (ref), u123 (ref), u131 (ref), u142 (ref), u140 (ref)
    -- upvalues: u125 (ref), u136 (ref), clearRows (val), u137 (val), u121 (ref), u134 (ref)
    u138 = u138 + 1
    u127 = false
    u128 = false
    u129 = false
    u123 = false
    u131 = nil
    u142.Visible = false
    u140(true)
    u125.Text = ""
    u136:Reset()
    clearRows()
    local v1 = false
    if next(u137) == nil then
        v1 = not u128
    end
    u121.Visible = not v1
    u134.Visible = v1
end

function u146.IsAvailable() -- Line: 426 -- upvalues: u144 (ref), TreadmillFlags (val)
    local v1 = false
    if u144 ~= nil then
        v1 = not TreadmillFlags.CommentsDisabled:Get()
    end
    return v1
end

function u146.Toggle() -- Line: 430
    -- upvalues: u144 (ref), u127 (ref), u130 (ref), TreadmillFlags (val), u145 (ref), u142 (ref), u140 (ref)
    -- upvalues: clearRows (val), u137 (val), u128 (ref), u121 (ref), u134 (ref), u138 (ref), u131 (ref), u123 (ref)
    -- upvalues: requestPage (val), u146 (val)
    if u144 == nil then
        return
    end
    if u127 then
        u145()
        u146.Close()
        return
    end
    if not u127 and u130 ~= "" then
        if TreadmillFlags.CommentsDisabled:Get() then
            return
        end
        u145()
        u127 = true
        u142.Visible = true
        u140(false)
        clearRows()
        local v1 = false
        if next(u137) == nil then
            v1 = not u128
        end
        u121.Visible = not v1
        u134.Visible = v1
        u138 = u138 + 1
        u131 = 0
        u123 = true
        u128 = false
        requestPage()
    end
end

function u146.Deactivate() -- Line: 444
    -- upvalues: u146 (val), u130 (ref), u120 (ref), u143 (ref), u141 (ref), Simple (val), u142 (ref)
    u146.Close()
    u130 = ""
    u120.Enabled = false
    u143 = 0
    u141.Text = Simple.FormatCompact(u143, ".#")
    local Title = u142.Sheet.Header.Content.SubContent.Title
    local v1 = u143
    Title.Text = if v1 ~= 1 then ("%* comments"):format((Simple.FormatCompact(v1, ".#"))) else "1 comment"
end

function u146.Start(a1) -- Line: 451
    -- upvalues: u144 (ref), GUI (val), TryCall (val), TextChatService (val), Players (val), u116 (val), u140 (ref)
    -- upvalues: u145 (ref), u120 (ref), u142 (ref), u121 (ref), u139 (ref), u125 (ref), u122 (ref), u134 (ref)
    -- upvalues: u136 (ref), PhotoInputController (val), u141 (ref), Trove (val), ButtonFX (val), open (val), u146 (val)
    -- upvalues: postComment (val), updateInputLimitPresentation (val), handleScroll (val), handleMediaChanged (val)
    -- upvalues: VideoComments (val), u130 (ref), u143 (ref), Simple (val), TreadmillFlags (val)
    -- upvalues: TreadmillMediaIdentity (val), Media (val), u137 (val), u128 (ref)
    assert(u144 == nil, "Treadmill comments controller must only start once")
    local CommentsButton = GUI.TreadmillScreenSideButtons().Frame.Buttons.CommentsButton
    local v1 = GUI.TreadmillScreenButtonShare()
    assert(v1:IsA("SurfaceGui"), "Treadmill share GUI must be a SurfaceGui")
    local ShareButton = v1.Frame.ShareButton
    assert(CommentsButton:IsA("GuiButton"), "Treadmill comments button must be a GuiButton")
    assert(ShareButton:IsA("GuiButton"), "Treadmill share button must be a GuiButton")
    local v2, v3 = TryCall(TextChatService.CanUserChatAsync, TextChatService, Players.LocalPlayer.UserId)
    CommentsButton.Visible = v2 and v3 == true
    if not CommentsButton.Visible then
        ShareButton.Position = u116
        return
    end
    u140 = a1.SetShareButtonVisible
    u145 = a1.SuppressScreenTap
    u120 = GUI.TreadmillScreenComments()
    u142 = u120.Frame.CommentsTemplate
    u121 = u142.Sheet.Content
    u139 = u121.Comment_01
    u125 = u142.Sheet.Actions.Content.TextInputWrapper.TextInput
    assert(u120:IsA("SurfaceGui"), "Treadmill comments GUI must be a SurfaceGui")
    assert(u121:IsA("ScrollingFrame"), "Treadmill comments content must be a ScrollingFrame")
    assert(u139:IsA("Frame"), "Treadmill comments row template must be a Frame")
    assert(CommentsButton.CommentsCount:IsA("TextLabel"), "Treadmill comments count must be a TextLabel")
    u122 = u125.BackgroundColor3
    u134 = u142.Sheet.NoComments
    PhotoInputController.new(u142, u145)
    u141 = CommentsButton.CommentsCount
    u144 = Trove.new()
    for i, j in u121:GetChildren() do
        if j:IsA("Frame") and j.Name:match("^Comment_%d+$") then
            if j.Name ~= "Comment_01" then
                j:Destroy()
            else
                j.Visible = false
            end
        end
    end
    u121.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u120.Enabled = false
    u142.Visible = false
    u142.Overlay.Active = true
    u142.AddPhoto.Visible = false
    v3 = u144
    assert(v3 ~= nil, "Treadmill comments trove must exist after startup")
    v3:Add((ButtonFX(CommentsButton, nil, open)))
    v3:Add((ButtonFX(u142.Sheet.Header.Content.Close, nil, function() -- Line: 510 -- upvalues: u145 (upval), u146 (upval)
        u145()
        u146.Close()
    end)))
    v3:Connect(u142.Overlay.InputBegan, function(a1) -- Line: 514 -- upvalues: u142 (upval), u145 (upval), u146 (upval) -- types: a1: userdata
        if a1.UserInputType == Enum.UserInputType.MouseButton1 then
            if a1.Position.Y < u142.Sheet.AbsolutePosition.Y then
                u145()
                u146.Close()
            end
        elseif a1.UserInputType == Enum.UserInputType.Touch and a1.Position.Y < u142.Sheet.AbsolutePosition.Y then
            u145()
            u146.Close()
        end
    end)
    v3:Add((ButtonFX(u142.Sheet.Actions.Content.Send, nil, postComment)))
    v3:Connect(u125:GetPropertyChangedSignal("Text"), updateInputLimitPresentation)
    v3:Connect(u121:GetPropertyChangedSignal("CanvasPosition"), handleScroll)
    v3:Add((a1.MediaChanged:Connect(handleMediaChanged)))
    v3:Add((a1.Stopped:Connect(u146.Deactivate)))
    v3:Add((VideoComments.CommentCountChanged:Connect(function(a1, a2) -- Line: 530
        -- upvalues: u130 (upval), u143 (upval), u141 (upval), Simple (upval), u142 (upval)
        if a1 == u130 then
            u143 = math.max(0, a2)
            u141.Text = Simple.FormatCompact(u143, ".#")
            local Title = u142.Sheet.Header.Content.SubContent.Title
            local v1 = u143
            Title.Text = if v1 ~= 1 then ("%* comments"):format((Simple.FormatCompact(v1, ".#"))) else "1 comment"
        end
    end)))
    local Position = ShareButton.Position
    v3:Add((TreadmillFlags.CommentsDisabled.Changed:Connect(function() -- Line: 537
        -- upvalues: TreadmillFlags (upval), CommentsButton (val), ShareButton (val), u116 (upval), Position (val)
        -- upvalues: u146 (upval), u120 (upval), u130 (upval)
        local v1 = TreadmillFlags.CommentsDisabled:Get()
        CommentsButton.Visible = not v1
        ShareButton.Position = if not v1 then Position else u116
        if v1 then
            u146.Close()
            u120.Enabled = false
            return
        end
        if u130 ~= "" then
            u120.Enabled = true
        end
    end)))
    v3 = TreadmillFlags.CommentsDisabled:Get()
    CommentsButton.Visible = not v3
    ShareButton.Position = if not v3 then Position else u116
    if v3 then
        u146.Close()
        u120.Enabled = false
    elseif u130 ~= "" then
        u120.Enabled = true
    end
    VideoComments.StartCommentCountCache((TreadmillMediaIdentity.BuildMediaKeys(Media)))
    u143 = 0
    u141.Text = Simple.FormatCompact(u143, ".#")
    local Title = u142.Sheet.Header.Content.SubContent.Title
    local v4 = u143
    Title.Text = if v4 ~= 1 then ("%* comments"):format((Simple.FormatCompact(v4, ".#"))) else "1 comment"
    v1 = false
    if next(u137) == nil then
        v1 = not u128
    end
    u121.Visible = not v1
    u134.Visible = v1
end

return u146