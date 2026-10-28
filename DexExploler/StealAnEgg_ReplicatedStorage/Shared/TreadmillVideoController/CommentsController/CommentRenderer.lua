-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.CommentsController.CommentRenderer
-- Decompile time: 5.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local DisplayName = require(ReplicatedStorage.Shared.Utils.Identity).DisplayName
local Thumbnail = require(ReplicatedStorage.Shared.Utils.Identity).Thumbnail
local Log = require(ReplicatedStorage.Packages.Log)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
require(ReplicatedStorage.Client.VideoComments.Types.Interface)
local u62 = Color3.fromRGB(232, 68, 86)
local u68 = Color3.fromRGB(255, 255, 255)
local u70 = Log.new()
local v1 = {}

local function formatPostedAt(a1) -- Line: 39 -- types: a1: number
    local v1 = math.max(0, (os.time()) - a1)
    if v1 < 60 then
        return "just now"
    end
    if v1 < 3600 then
        return (("%*m ago"):format((math.floor(v1 / 60))))
    end
    if v1 < 86400 then
        return (("%*h ago"):format((math.floor(v1 / 3600))))
    end
    return (("%*d ago"):format((math.floor(v1 / 86400))))
end

local function fitDisplayName(a1, a2) -- Line: 56 -- upvalues: TextService (val) -- types: a1: userdata, a2: string
    a1.Text = a2
    a1.AutomaticSize = Enum.AutomaticSize.X
    a1.TextTruncate = Enum.TextTruncate.AtEnd
    a1.Size = UDim2.new(
        0,
        math.min(math.ceil((TextService:GetTextSize(a2, a1.TextSize, a1.Font, (Vector2.new((1 / 0), a1.AbsoluteSize.Y)))).X) + 2, 140),
        a1.Size.Y.Scale,
        a1.Size.Y.Offset
    )
end

local function configureDynamicLayout(a1) -- Line: 72
    a1.AutomaticSize = Enum.AutomaticSize.Y
    a1.Size = UDim2.fromScale(1, 0)
    a1.Content.AutomaticSize = Enum.AutomaticSize.Y
    a1.Content.Size = UDim2.new(a1.Content.Size.X.Scale, a1.Content.Size.X.Offset, 0, 0)
    a1.Content.Comment.AutomaticSize = Enum.AutomaticSize.Y
    a1.Content.Comment.Size = UDim2.fromScale(1, 0)
    a1.Content.Comment.TextWrapped = true
end

local function configureOwnerPresentation(a1, a2, a3) -- Line: 82
    -- upvalues: u68 (val)
    local DisplayName = a1.Content.User.DisplayName
    a1.Content.User.OwnerTag.Visible = a2
    DisplayName.OwnerGradient.Enabled = a2
    DisplayName.OwnerStroke.Enabled = a2
    DisplayName.TextColor3 = if not a2 then a3 else u68
end

local function loadUserPresentation(a1, a2) -- Line: 96
    -- upvalues: fitDisplayName (val), DisplayName (val), Constants (val), u70 (val), Thumbnail (val)
    fitDisplayName(a1.Content.User.DisplayName, "Loading...")
    task.spawn(function() -- Line: 98
        -- upvalues: DisplayName (upval), a2 (val), a1 (val), Constants (upval), fitDisplayName (upval), u70 (upval)
        local success, err = pcall(DisplayName, a2)
        if a1.Parent == nil then
            return
        end
        if not success then
            (u70:AtTrace()):Log((("Failed to resolve comment display name for user %*"):format(a2)))
            return
        end
        local v1 = if a2 ~= Constants.OWNER_ID then err else ("%*"):format(err)
        fitDisplayName(a1.Content.User.DisplayName, v1)
    end)
    task.spawn(function() -- Line: 112 -- upvalues: Thumbnail (upval), a2 (val), a1 (val), u70 (upval)
        local success, err = pcall(Thumbnail, a2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if a1.Parent == nil then
            return
        end
        if success and err ~= nil then
            a1.Avatar.Image = err
            return
        end
        ;(u70:AtTrace()):Log((("Failed to resolve comment avatar for user %*"):format(a2)))
    end)
end

function v1.Create(a1, a2, a3, a4, a5) -- Line: 135
    -- upvalues: Trove (val), formatPostedAt (val), configureDynamicLayout (val), Constants (val), u68 (val), u62 (val)
    -- upvalues: Simple (val), loadUserPresentation (val), ButtonFX (val)
    local v1 = a1:Clone()
    v1.Name = ("Comment_%*"):format(a3.Id)
    v1.LayoutOrder = a4
    v1.Visible = true
    v1.Parent = a2
    local Content = v1.Content
    local PostedAt = Content.Actions.Left.PostedAt
    local Like = Content.Actions.Right.Like
    local Icon = Like.Icon
    local TextColor3 = Icon.TextColor3
    local FontFace = Icon.FontFace
    local TextColor3_2 = Content.User.DisplayName.TextColor3
    local u29 = Trove.new()
    PostedAt.LayoutOrder = Content.User.DisplayName.LayoutOrder + 1
    Content.Comment.Text = a3.Message
    PostedAt.Text = formatPostedAt(a3.CreatedAt)
    configureDynamicLayout(v1)
    local v2 = a3.UserId == Constants.OWNER_ID
    local DisplayName = v1.Content.User.DisplayName
    v1.Content.User.OwnerTag.Visible = v2
    DisplayName.OwnerGradient.Enabled = v2
    DisplayName.OwnerStroke.Enabled = v2
    DisplayName.TextColor3 = if not v2 then TextColor3_2 else u68
    if a3.ImageAssetId == nil then
        Content.Photo.Visible = false
    else
        Content.Photo.Visible = true
        Content.Photo.Container.Image.Image = ("rbxassetid://%*"):format(a3.ImageAssetId)
        Content.Photo.Container.Image.ScaleType = Enum.ScaleType.Crop
    end
    local LikedByViewer = a3.LikedByViewer
    local LikeCount = a3.LikeCount
    Icon.TextColor3 = if not LikedByViewer then TextColor3 else u62
    local v3 = if not LikedByViewer then FontFace else Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style)
    Icon.FontFace = v3
    Like.Label.Text = Simple.FormatCompact(math.max(0, LikeCount), ".#")
    loadUserPresentation(v1, a3.UserId)
    u29:Add((ButtonFX(Like, nil, function() -- Line: 181 -- upvalues: a5 (val), a3 (val)
        a5(a3.Id)
    end)))
    u29:Add(v1)
    return {
        Row = v1,
        UpdateLike = function(a1, a2) -- Line: 171
            -- upvalues: Icon (val), u62 (upval), TextColor3 (val), FontFace (val), Like (val), Simple (upval)
            Icon.TextColor3 = if not a1 then TextColor3 else u62
            Icon.FontFace = if not a1 then FontFace else Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style)
            Like.Label.Text = Simple.FormatCompact(math.max(0, a2), ".#")
        end,
        Destroy = function() -- Line: 187 -- upvalues: u29 (val)
            u29:Destroy()
        end,
    }
end

return v1