-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.FriendLikesController
-- Decompile time: 11.84 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local DisplayName = require(ReplicatedStorage.Shared.Utils.Identity).DisplayName
local Thumbnail = require(ReplicatedStorage.Shared.Utils.Identity).Thumbnail
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u88 = {}
u88.__index = u88
u88.__class = "FriendLikesController"
local u94 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u99 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u104 = TweenInfo.new(2.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local u108 = Vector2.new(0.13, 0.13)
local u110 = Log.new()
local u113 = GUI.TreadmillScreenFriendLikes()
assert(u113:IsA("SurfaceGui"), "Treadmill friend-like GUI must be a SurfaceGui")
local Frame = u113.Frame
local Main = Frame.Main
local Template = Main.Template
assert(Template:IsA("Frame"), "Treadmill friend-like template must be a Frame")
assert(Template.Button:IsA("ImageButton"), "Treadmill friend-like template button must be an ImageButton")
local Profile = Frame.Profile
assert(Profile:IsA("Frame"), "Treadmill friend-like profile must be a Frame")
local Position = Profile.Position
local PlayerIcon = Profile.Main.Icon.PlayerIcon
assert(PlayerIcon:IsA("ImageLabel"), "Treadmill friend-like profile icon must be an ImageLabel")
local TextLabel = Profile.Main.TextLabel
assert(TextLabel:IsA("TextLabel"), "Treadmill friend-like profile label must be a TextLabel")

function u88.new(a1, a2, a3, a4, a5) -- Line: 103
    -- upvalues: t (val), u88 (val), Profile (val), PlayerIcon (val), TextLabel (val), Position (val), Main (val)
    -- upvalues: Trove (val), Template (val), u113 (val)
    t.strict(t.callback)(a1)
    t.strict(t.callback)(a2)
    t.strict(t.table)(a3)
    t.strict(t.table)(a4)
    t.strict(t.instanceIsA("BasePart"))(a5)
    local v1 = setmetatable({}, u88)
    v1._destroyed = false
    v1._friendLikeUserIdsByMediaLikeKey = {}
    v1._getActiveVideoIndex = a1
    v1._interactionCallback = a2
    v1._mediaEntries = a3
    v1._profile = Profile
    v1._profilePlayerIcon = PlayerIcon
    v1._profileTextLabel = TextLabel
    v1._profileTween = nil
    v1._profileVisiblePosition = Position
    v1._rowsContainer = Main
    v1._rowsTrove = Trove.new()
    v1._rowTemplate = Template
    v1._screenTapSuppressUntil = 0
    v1._snapshotRequestSerial = 0
    v1._surfaceGui = u113
    v1._trove = a4:Extend()
    v1:_init(a5)
    return v1
end

local function escapeRichText(a1) -- Line: 142 -- types: a1: string
    return ((((a1:gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;")):gsub("\"", "&quot;")):gsub("'", "&apos;")
end

local function getRandomFloatPosition(a1) -- Line: 151 -- upvalues: u108 (val) -- types: a1: userdata
    return UDim2.fromScale(0.5 + a1:NextNumber(-u108.X, u108.X), 0.5 + a1:NextNumber(-u108.Y, u108.Y))
end

local function startButtonFloat(a1, a2) -- Line: 158 -- upvalues: TweenService (val), u104 (val), u108 (val)
    local playNext
    local u3 = Random.new()
    local u4 = nil
    local u5 = false
    a1.AnchorPoint = Vector2.new(0.5, 0.5)
    a1.Position = UDim2.fromScale(0.5, 0.5)

    function playNext() -- Line: 166
        -- upvalues: u5 (ref), a1 (val), TweenService (upval), u104 (upval), u3 (val), u108 (upval), u4 (ref)
        -- upvalues: playNext (val)
        if not u5 and a1.Parent ~= nil then
            local v1 = TweenService
            local v2 = a1
            local v3 = u104
            local v4 = {}
            local v5 = u3
            v4.Position = UDim2.fromScale(0.5 + v5:NextNumber(-u108.X, u108.X), 0.5 + v5:NextNumber(-u108.Y, u108.Y))
            local u33 = v1:Create(v2, v3, v4)
            u4 = u33
            u33.Completed:Once(function() -- Line: 175 -- upvalues: u4 (upval), u33 (val), playNext (upval)
                if u4 ~= u33 then
                    return
                end
                u4 = nil
                playNext()
            end)
            u33:Play()
            return
        end
    end

    a2:Add(function() -- Line: 186 -- upvalues: u5 (ref), u4 (ref)
        u5 = true
        if u4 ~= nil then
            u4:Cancel()
            u4 = nil
        end
    end)
    playNext()
end

function u88:_isAlive() -- Line: 196
    return not self._destroyed
end

function u88:_getMediaKey() -- Line: 200 -- upvalues: TreadmillMediaIdentity (val)
    local v1 = self._getActiveVideoIndex()
    local v2 = self._mediaEntries[v1]
    local v3 = ("Missing treadmill media entry for index %*"):format(v1)
    assert(v2 ~= nil, v3)
    return TreadmillMediaIdentity.GetMediaKey(v2)
end

function u88:_getProfileHiddenPosition() -- Line: 207
    local _profileVisiblePosition = self._profileVisiblePosition
    return UDim2.new(_profileVisiblePosition.X.Scale, _profileVisiblePosition.X.Offset, 2, _profileVisiblePosition.Y.Offset)
end

function u88:_cancelProfileTween() -- Line: 217
    local _profileTween = self._profileTween
    self._profileTween = nil
    if _profileTween ~= nil then
        _profileTween:Cancel()
    end
end

function u88:_hideProfileImmediate() -- Line: 225
    self:_cancelProfileTween()
    self._profile.Visible = false
    self._profile.Position = self:_getProfileHiddenPosition()
end

function u88:_clearRows() -- Line: 231 -- upvalues: Trove (val)
    self._rowsTrove:Destroy()
    self._rowsTrove = Trove.new()
end

function u88:_getRequestedMediaKeys() -- Line: 236 -- upvalues: TreadmillMediaIdentity (val)
    local v1, v2
    local v3 = {}
    local v4 = {}
    local v5 = self._getActiveVideoIndex()
    for i, v in ipairs({v5, v5 + 1, v5 - 1}) do
        v2 = self._mediaEntries[v]
        if v2 ~= nil then
            v1 = TreadmillMediaIdentity.GetMediaKey(v2)
            if not v4[v1] then
                v4[v1] = true
                table.insert(v3, v1)
            end
        end
    end
    return v3
end

function u88:_requestFriendLikeSnapshot(a2) -- Line: 263
    -- upvalues: TryCall (val), Remotes (val), u110 (val), Schema (val)
    local v1, v2 = TryCall(function() -- Line: 268 -- upvalues: Remotes (upval), self (val)
        return Remotes.Treadmill.AskFriendFavourSnapshot:InvokeServer({MediaKeys = self:_getRequestedMediaKeys()})
    end)
    if not v1 then
        (u110:AtError()):Log((("Failed to load treadmill friend-like snapshot: %*"):format(v2)))
        return
    end
    if not Schema.FriendLikeSnapshot(v2) then
        u110:AtError():Log("Invalid treadmill friend-like snapshot payload")
        return
    end
    if self:_isAlive() and a2 == self._snapshotRequestSerial then
        self._friendLikeUserIdsByMediaLikeKey = table.clone(v2.FriendLikeUserIdsByMediaLikeKey)
        self:UpdatePresentation()
        return
    end
end

function u88:_requestFriendLikeSnapshotAsync() -- Line: 294
    self._snapshotRequestSerial = self._snapshotRequestSerial + 1
    local _snapshotRequestSerial = self._snapshotRequestSerial
    task.spawn(function() -- Line: 297 -- upvalues: self (val), _snapshotRequestSerial (val)
        if not self:_isAlive() then
            return
        end
        self:_requestFriendLikeSnapshot(_snapshotRequestSerial)
    end)
end

function u88._resolveDisplayName(a1, a2) -- Line: 306 -- upvalues: Players (val), DisplayName (val) -- types: a2: number
    local PlayerByUserId = Players:GetPlayerByUserId(a2)
    if PlayerByUserId ~= nil then
        return PlayerByUserId.DisplayName
    end
    return DisplayName(a2)
end

function u88:_showProfilePreview(a2, a3) -- Line: 315
    -- upvalues: Constants (val), escapeRichText (val), Thumbnail (val), TweenService (val), u94 (val)
    self:_cancelProfileTween()
    local v1 = self:_resolveDisplayName(a2)
    if not self:_isAlive() then
        return
    end
    self._profilePlayerIcon.Image = a3
    self._profileTextLabel.RichText = true
    local v2 = if a2 ~= Constants.OWNER_ID then "" else " (OWNER)"
    self._profileTextLabel.Text = ("<b>%*%*</b> liked this video"):format(escapeRichText(v1), v2)
    self._profile.Position = self:_getProfileHiddenPosition()
    self._profile.Visible = true
    if a3 == "" then
        task.spawn(function() -- Line: 335 -- upvalues: Thumbnail (upval), a2 (val), self (val)
            local v1 = Thumbnail(a2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
            local v2 = if v1 ~= nil then v1 else ""
            if self:_isAlive() and self._profile.Visible then
                self._profilePlayerIcon.Image = v2
                return
            end
        end)
    end
    local u51 = TweenService:Create(self._profile, u94, {Position = self._profileVisiblePosition})
    self._profileTween = u51
    u51.Completed:Once(function() -- Line: 355 -- upvalues: self (val), u51 (val)
        if self._profileTween ~= u51 then
            return
        end
        self._profileTween = nil
    end)
    u51:Play()
end

function u88._startRefreshLoop(a1) -- Line: 365
    task.spawn(function() -- Line: 366 -- upvalues: a1 (val)
        while a1:_isAlive() do
            task.wait(180)
            if not a1:_isAlive() then
                break
            end
            a1:_requestFriendLikeSnapshotAsync()
        end
    end)
end

function u88:_init(a2) -- Line: 378 -- types: a2: userdata
    self._surfaceGui.Adornee = a2
    self._surfaceGui.Enabled = true
    self._rowTemplate.Visible = false
    self._profileTextLabel.RichText = true
    self:_hideProfileImmediate()
    self:UpdatePresentation()
    self:_requestFriendLikeSnapshotAsync()
    self:_startRefreshLoop()
end

function u88:UpdatePresentation() -- Line: 393 -- upvalues: startButtonFloat (val), ButtonFX (val), Thumbnail (val)
    if not self:_isAlive() then
        return
    end
    self:_clearRows()
    local v1 = self._friendLikeUserIdsByMediaLikeKey[(self:_getMediaKey())]
    if v1 ~= nil and #v1 ~= 0 then
        local v2
        for i, v in ipairs(v1) do
            local u30 = self._rowTemplate:Clone()
            local Button = u30.Button
            u30.Name = ("FriendLike_%*"):format(v)
            u30.Visible = true
            u30.LayoutOrder = i
            Button.PlayerIcon.Image = ""
            u30.Parent = self._rowsContainer
            v2 = self._rowsTrove:Extend()
            startButtonFloat(Button, v2)
            v2:Add((ButtonFX(Button, nil, function() -- Line: 418 -- upvalues: self (val), v (val), Button (val)
                self:SuppressScreenTap()
                self._interactionCallback()
                self:_showProfilePreview(v, Button.PlayerIcon.Image)
            end)))
            v2:Add(u30)
            task.spawn(function() -- Line: 425 -- upvalues: Thumbnail (upval), v (val), self (val), u30 (val), Button (val)
                local v1 = Thumbnail(v, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
                local v2 = if v1 ~= nil then v1 else ""
                if self:_isAlive() and u30.Parent ~= nil then
                    Button.PlayerIcon.Image = v2
                    return
                end
            end)
        end
        return
    end
end

function u88.HandleScreenTap(a1) -- Line: 442
    if a1:_isAlive() and not (os.clock() < a1._screenTapSuppressUntil) then
        a1:HideProfilePreview()
        return
    end
end

function u88:SuppressScreenTap() -- Line: 450
    self._screenTapSuppressUntil = os.clock() + 0.12
end

function u88.HandleMediaChanged(a1) -- Line: 454
    if not a1:_isAlive() then
        return
    end
    a1:HideProfilePreview()
    a1:UpdatePresentation()
    a1:_requestFriendLikeSnapshotAsync()
end

function u88:HideProfilePreview() -- Line: 464 -- upvalues: TweenService (val), u99 (val)
    if not self:_isAlive() then
        return
    end
    self:_cancelProfileTween()
    if not self._profile.Visible then
        self._profile.Position = self:_getProfileHiddenPosition()
        return
    end
    local u22 = TweenService:Create(self._profile, u99, {Position = self:_getProfileHiddenPosition()})
    self._profileTween = u22
    u22.Completed:Once(function() -- Line: 479 -- upvalues: self (val), u22 (val)
        if self._profileTween ~= u22 then
            return
        end
        self._profileTween = nil
        self._profile.Visible = false
    end)
    u22:Play()
end

function u88:Destroy() -- Line: 490
    if self._destroyed then
        return
    end
    self._destroyed = true
    self:_clearRows()
    self:_hideProfileImmediate()
    self._surfaceGui.Enabled = false
    self._trove:Destroy()
end

return u88