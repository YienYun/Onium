-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.LikeController
-- Decompile time: 14.53 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local RecommendationSignals = require(script.Parent.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u79 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))

local function u80(a1) -- Line: 26 -- upvalues: u79 (val)
    local v1 = false
    if typeof(a1) == "Vector2" then
        v1 = u79(a1.X) and u79(a1.Y)
    end
    return v1
end

require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local WarmAssets = require(ReplicatedStorage.Shared.Utils.Preload).WarmAssets
require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
local u106 = {}
u106.__index = u106
u106.__class = "LikeController"
local u113 = Color3.fromRGB(255, 92, 122)
local u115 = Log.new()
task.spawn(function() -- Line: 60 -- upvalues: WarmAssets (val)
    local ImageLabel
    local v1 = {}
    for i, j in {"rbxassetid://90146064998908", "rbxassetid://123761405635833"} do
        ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Image = j
        table.insert(v1, ImageLabel)
    end
    WarmAssets(v1)
    for k, n in v1 do
        n:Destroy()
    end
end)
local u121 = GUI.TreadmillScreenSideButtons()
assert(u121:IsA("SurfaceGui"), "Treadmill like GUI must be a SurfaceGui")
local LikeButton = u121.Frame.Buttons.LikeButton
assert(LikeButton:IsA("ImageButton"), "Treadmill like button must be an ImageButton")
local LikeCount = LikeButton.LikeCount
assert(LikeCount:IsA("TextLabel"), "Treadmill like count label must be a TextLabel")

function u106.new(a1, a2, a3, a4, a5, a6) -- Line: 110
    -- upvalues: t (val), u106 (val), LikeButton (val), LikeCount (val), u121 (val)
    t.strict(t.callback)(a1)
    t.strict(t.callback)(a2)
    t.strict(t.table)(a3)
    t.strict(t.table)(a4)
    t.strict(t.Instance)(a5)
    t.strict(t.instanceIsA("BasePart"))(a6)
    local v1 = setmetatable({}, u106)
    v1._countsByMediaLikeKey = {}
    v1._defaultLikeButtonColor = LikeButton.ImageColor3
    v1._destroyed = false
    v1._getActiveVideoIndex = a1
    v1._lastScreenTapPosition = nil
    v1._lastScreenTapTime = nil
    v1._likeButton = LikeButton
    v1._likeCountLabel = LikeCount
    v1._likeRequestLocks = {}
    v1._likeSurfaceGui = u121
    v1._likedTreadmillMedia = {}
    v1._mediaEntries = a3
    v1._onSingleTap = a2
    v1._pendingSingleTapSerial = 0
    v1._snapshotRequestSerial = 0
    v1._screenTapSuppressUntil = 0
    v1._trove = a4:Extend()
    v1._videoFrame = a5
    v1:_init(a6)
    return v1
end

local function formatLikeCount(a1) -- Line: 152 -- upvalues: Simple (val) -- types: a1: number
    return Simple.FormatCompact(math.max(a1, 0), ".#")
end

local function getSquareHeartSize(a1, a2) -- Line: 156 -- types: a1: userdata, a2: number
    local v1 = math.min(a1.X, a1.Y)
    return UDim2.fromScale(v1 / a1.X * a2, v1 / a1.Y * a2)
end

function u106:_isAlive() -- Line: 164
    return not self._destroyed
end

function u106:_getMediaKey() -- Line: 166 -- upvalues: TreadmillMediaIdentity (val)
    local v1 = self._getActiveVideoIndex()
    local v2 = self._mediaEntries[v1]
    local v3 = ("Missing treadmill media entry for index %*"):format(v1)
    assert(v2 ~= nil, v3)
    return TreadmillMediaIdentity.GetMediaKey(v2)
end

function u106:_setRuntimeLikedState(a2, a3) -- Line: 173 -- types: a2: string, a3: boolean
    if a3 then
        self._likedTreadmillMedia[a2] = true
        return
    end
    self._likedTreadmillMedia[a2] = nil
end

function u106:_applyLocalLikedState(a2, a3) -- Line: 185 -- types: a2: string, a3: boolean
    if self._likedTreadmillMedia[a2] == true == a3 then
        return
    end
    self:_setRuntimeLikedState(a2, a3)
    local v1 = if not a3 then -1 else 1
    self._countsByMediaLikeKey[a2] = (math.max((self._countsByMediaLikeKey[a2] or 0) + v1, 0))
    self:UpdatePresentation()
end

function u106:_reconcileLikedState(a2, a3) -- Line: 202 -- types: a2: string
    self:_setRuntimeLikedState(a2, a3.Liked == true)
    if typeof(a3.Count) == "number" then
        self._countsByMediaLikeKey[a2] = a3.Count
    end
    self:UpdatePresentation()
end

function u106:_requestLikeSnapshot(a2) -- Line: 214
    -- upvalues: TryCall (val), Remotes (val), u115 (val), Schema (val)
    local v1, v2 = TryCall(function() -- Line: 219 -- upvalues: Remotes (upval)
        return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
    end)
    if not v1 then
        (u115:AtError()):Log((("Failed to load treadmill media like snapshot: %*"):format(v2)))
        return
    end
    if not Schema.LikeSnapshot(v2) then
        u115:AtError():Log("Invalid treadmill media like snapshot payload")
        return
    end
    if self:_isAlive() and a2 == self._snapshotRequestSerial then
        self._countsByMediaLikeKey = table.clone(v2.CountsByMediaLikeKey)
        self._likedTreadmillMedia = table.clone(v2.LikedTreadmillMedia)
        self:UpdatePresentation()
        return
    end
end

function u106:_requestLikeSnapshotAsync() -- Line: 242
    self._snapshotRequestSerial = self._snapshotRequestSerial + 1
    local _snapshotRequestSerial = self._snapshotRequestSerial
    task.spawn(function() -- Line: 245 -- upvalues: self (val), _snapshotRequestSerial (val)
        if not self:_isAlive() then
            return
        end
        self:_requestLikeSnapshot(_snapshotRequestSerial)
    end)
end

function u106:_setLikedState(a2) -- Line: 254
    -- upvalues: TryLock (val), TryCall (val), Remotes (val), u115 (val), Schema (val), RecommendationSignals (val)
    local u4 = self:_getMediaKey()
    local v1 = self._likeRequestLocks[u4]
    if v1 == nil then
        v1 = TryLock()
        self._likeRequestLocks[u4] = v1
    end
    v1(function() -- Line: 262
        -- upvalues: self (val), u4 (val), a2 (val), TryCall (upval), Remotes (upval), u115 (upval), Schema (upval)
        -- upvalues: RecommendationSignals (upval)
        local v1 = self
        v1._snapshotRequestSerial = v1._snapshotRequestSerial + 1
        v1 = self._likedTreadmillMedia[u4] == true
        local v2 = self._countsByMediaLikeKey[u4] or 0
        self:_applyLocalLikedState(u4, a2)
        local v3, v4 = TryCall(function() -- Line: 270 -- upvalues: Remotes (upval), u4 (upval), a2 (upval)
            local v1 = a2
            return Remotes.Treadmill.AskClipFavour:InvokeServer(u4, v1)
        end)
        if not v3 then
            if not self:_isAlive() then
                return
            end
            self:_setRuntimeLikedState(u4, v1)
            self._countsByMediaLikeKey[u4] = v2
            self:UpdatePresentation()
            ;(u115:AtError()):Log((("Failed to update treadmill media like state: %*"):format(v4)))
            return
        end
        if not Schema.LikeToggleResult(v4) then
            if not self:_isAlive() then
                return
            end
            self:_setRuntimeLikedState(u4, v1)
            self._countsByMediaLikeKey[u4] = v2
            self:UpdatePresentation()
            u115:AtError():Log("Rejected treadmill media like state update: Invalid like toggle response")
            return
        end
        if v4.Ok ~= true then
            if not self:_isAlive() then
                return
            end
            self:_setRuntimeLikedState(u4, v1)
            self._countsByMediaLikeKey[u4] = v2
            self:UpdatePresentation()
            ;(u115:AtError()):Log((("Rejected treadmill media like state update: %*"):format((tostring(v4.Error)))))
            return
        end
        if not self:_isAlive() then
            return
        end
        self:_reconcileLikedState(u4, v4)
        local NotifyLikeResult = RecommendationSignals.NotifyLikeResult
        local v5 = v4.Liked == true
        NotifyLikeResult(u4, v5)
    end)
end

function u106:_spawnHeartAnimation(a2) -- Line: 321
    -- upvalues: t (val), u80 (val), u113 (val), RunService (val), TweenService (val)
    t.strict(u80)(a2)
    local _videoFrame = self._videoFrame
    local AbsoluteSize = _videoFrame.AbsoluteSize
    local v1 = false
    if 0 < AbsoluteSize.X then
        v1 = 0 < AbsoluteSize.Y
    end
    assert(v1, "Treadmill like animation requires a non-zero video frame size")
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "TreadmillLikeHeart"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://90146064998908"
    ImageLabel.ImageColor3 = u113
    ImageLabel.ImageTransparency = 0
    ImageLabel.Position = UDim2.fromScale(a2.X, a2.Y)
    ImageLabel.Size = UDim2.fromScale(0.15, 0.08)
    ImageLabel.ZIndex = self._likeButton.ZIndex + 10
    ImageLabel.Parent = _videoFrame
    Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
    local v2 = Random.new()
    v1 = v2:NextNumber(-0.08, 0.08)
    local v3 = -v2:NextNumber(0.24, 0.34)
    local u79 = Vector2.new(math.clamp(a2.X + v1, 0.05, 0.95), (math.clamp(a2.Y + v3, 0.05, 0.95)))
    local u95 = Vector2.new(math.clamp(a2.X + v1 * 0.55, 0.05, 0.95), (math.clamp(a2.Y + v3 * 0.45, 0.05, 0.95)))

    local function bezier(a1) -- Line: 375 -- upvalues: a2 (val), u95 (val), u79 (val) -- types: a1: number
        return (a2:Lerp(u95, a1)):Lerp(u95:Lerp(u79, a1), a1)
    end

    local u97 = nil
    local u98 = false
    local u100 = 0
    RunService.PreRender:Connect(function(a1) -- Line: 400
        -- upvalues: self (val), ImageLabel (val), u98 (ref), u97 (ref), u100 (ref), TweenService (upval), a2 (val)
        -- upvalues: u95 (val), u79 (val), AbsoluteSize (val)
        local v1
        if self:_isAlive() and ImageLabel.Parent ~= nil then
            u100 = math.min(u100 + a1, 0.65)
            v1 = u100 / 0.65
            local Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v2 = (a2:Lerp(u95, Value)):Lerp(u95:Lerp(u79, Value), Value)
            local v3 = if not (v1 <= 0.18) then 0.4 + -0.32 * (TweenService:GetValue((v1 - 0.18) / 0.82, Enum.EasingStyle.Quad, Enum.EasingDirection.In)) else 0.6 + -0.19999999999999996 * (TweenService:GetValue(v1 / 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
            ImageLabel.Position = UDim2.fromScale(v2.X, v2.Y)
            local v4 = ImageLabel
            local v5 = AbsoluteSize
            v2 = math.min(v5.X, v5.Y)
            v4.Size = UDim2.fromScale(v2 / v5.X * v3, v2 / v5.Y * v3)
            ImageLabel.ImageTransparency = math.clamp((v1 - 0.35) / 0.65, 0, 1)
            if v1 >= 1 then
                if u98 then
                    return
                end
                u98 = true
                v3 = u97
                u97 = nil
                if v3 ~= nil then
                    v3:Disconnect()
                end
                if ImageLabel.Parent ~= nil then
                    ImageLabel:Destroy()
                end
            end
            return
        end
        if u98 then
            return
        end
        u98 = true
        v1 = u97
        u97 = nil
        if v1 ~= nil then
            v1:Disconnect()
        end
        if ImageLabel.Parent ~= nil then
            ImageLabel:Destroy()
        end
    end)
    self._trove:Add(function() -- Line: 382 -- upvalues: u98 (ref), u97 (ref), ImageLabel (val)
        if u98 then
            return
        end
        u98 = true
        local v1 = u97
        u97 = nil
        if v1 ~= nil then
            v1:Disconnect()
        end
        if ImageLabel.Parent ~= nil then
            ImageLabel:Destroy()
        end
    end)
end

function u106:_handleDoubleTap(a2) -- Line: 439 -- upvalues: t (val), u80 (val) -- types: a2: userdata
    t.strict(u80)(a2)
    self:_spawnHeartAnimation(a2)
    if self._likedTreadmillMedia[(self:_getMediaKey())] == true then
        return
    end
    self:_setLikedState(true)
end

function u106._startRefreshLoop(a1) -- Line: 451
    task.spawn(function() -- Line: 452 -- upvalues: a1 (val)
        while a1:_isAlive() do
            task.wait(180)
            if not a1:_isAlive() then
                break
            end
            a1:_requestLikeSnapshotAsync()
        end
    end)
end

function u106:_init(a2) -- Line: 464 -- upvalues: ButtonFX (val) -- types: a2: userdata
    self._likeSurfaceGui.Adornee = a2
    self._likeSurfaceGui.Enabled = true
    self:UpdatePresentation()
    self._trove:Add((ButtonFX(self._likeButton, nil, function() -- Line: 469 -- upvalues: self (val)
        self:Toggle()
    end)))
    self:_requestLikeSnapshotAsync()
    self:_startRefreshLoop()
end

function u106:UpdatePresentation() -- Line: 479 -- upvalues: u113 (val), Simple (val)
    if not self:_isAlive() then
        return
    end
    local v1 = self:_getMediaKey()
    local v2 = self._likedTreadmillMedia[v1] == true
    local v3 = self._countsByMediaLikeKey[v1] or 0
    self._likeButton.ImageColor3 = if not v2 then Color3.fromRGB(255, 255, 255) else u113
    local v4 = if not v2 then "rbxassetid://123761405635833" else "rbxassetid://90146064998908"
    self._likeButton.Image = v4
    self._likeCountLabel.Text = Simple.FormatCompact(math.max(v3, 0), ".#")
end

function u106:SuppressScreenTap() -- Line: 495
    self._screenTapSuppressUntil = os.clock() + 0.12
end

function u106:Toggle() -- Line: 499
    if not self:_isAlive() then
        return
    end
    self:SuppressScreenTap()
    self:_setLikedState(self._likedTreadmillMedia[(self:_getMediaKey())] ~= true)
end

function u106.HandleScreenTap(a1, a2) -- Line: 509 -- upvalues: t (val), u80 (val) -- types: a2: userdata
    t.strict(u80)(a2)
    if a1:_isAlive() and not (os.clock() < a1._screenTapSuppressUntil) then
        local v1 = os.clock()
        local AbsoluteSize = a1._videoFrame.AbsoluteSize
        local v2 = false
        if 0 < AbsoluteSize.X then
            v2 = 0 < AbsoluteSize.Y
        end
        assert(v2, "Treadmill like tap handling requires a non-zero video frame size")
        if a1._lastScreenTapTime ~= nil
            and a1._lastScreenTapPosition ~= nil
            and v1 - a1._lastScreenTapTime <= 0.25
            and Vector2.new((a2.X - a1._lastScreenTapPosition.X) * AbsoluteSize.X, (a2.Y - a1._lastScreenTapPosition.Y) * AbsoluteSize.Y).Magnitude <= 36 then
            a1._pendingSingleTapSerial = a1._pendingSingleTapSerial + 1
            a1._lastScreenTapTime = nil
            a1._lastScreenTapPosition = nil
            a1:_handleDoubleTap(a2)
            return
        end
        a1._pendingSingleTapSerial = a1._pendingSingleTapSerial + 1
        local _pendingSingleTapSerial = a1._pendingSingleTapSerial
        a1._lastScreenTapTime = v1
        a1._lastScreenTapPosition = a2
        task.delay(0.25, function() -- Line: 545 -- upvalues: a1 (val), _pendingSingleTapSerial (val)
            if a1:_isAlive() and a1._pendingSingleTapSerial == _pendingSingleTapSerial then
                a1._lastScreenTapTime = nil
                a1._lastScreenTapPosition = nil
                a1._onSingleTap()
                return
            end
        end)
        return
    end
end

function u106:Destroy() -- Line: 556
    if self._destroyed then
        return
    end
    self._destroyed = true
    self._pendingSingleTapSerial = self._pendingSingleTapSerial + 1
    self._likeSurfaceGui.Enabled = false
    self._trove:Destroy()
end

return u106