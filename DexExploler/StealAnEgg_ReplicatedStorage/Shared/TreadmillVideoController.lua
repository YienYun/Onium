-- Script path: ReplicatedStorage.Shared.TreadmillVideoController
-- Decompile time: 65.57 ms

local CollectionService = game:GetService("CollectionService")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local CommentsController = require(script.CommentsController)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local FeedSequencer = require(script.FeedSequencer)
local FriendLikesController = require(script.FriendLikesController)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local ImageColorPulse = require(ReplicatedStorage.Client.UI.VFX.ImageColorPulse)
local LikeController = require(script.LikeController)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(script.Media)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local WarmAssets = require(ReplicatedStorage.Shared.Utils.Preload).WarmAssets
local WarmSounds = require(ReplicatedStorage.Shared.Utils.Preload).WarmSounds
local RecommendationFeedSource = require(script.RecommendationFeedSource)
local RecommendationFlags = require(script.RecommendationFlags)
local RecommendationSignals = require(script.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Schema = require(script.Types.Schema)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TouchTapTracker = require(ReplicatedStorage.Client.Input.TouchTapTracker)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local VideoFramePool = require(script.VideoFramePool)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u179 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false)
local Value = Enum.ContextActionPriority.High.Value
local ButtonL2 = Enum.KeyCode.ButtonL2
local ButtonR2 = Enum.KeyCode.ButtonR2
local u188 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u193 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u198 = Color3.fromRGB(255, 0, 0)
local u205 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
local u210 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u215 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u220 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
task.spawn(WarmAssets, "rbxassetid://84371411600743", "rbxassetid://90908618020821")
local LocalPlayer = Players.LocalPlayer
local u229 = Log.new()
local u232 = GUI.TreadmillScreenButtonSwapLeft()
assert(u232:IsA("SurfaceGui"), "Treadmill left swap GUI must be a SurfaceGui")
local u241 = GUI.TreadmillScreenButtonSwapRight()
assert(u241:IsA("SurfaceGui"), "Treadmill right swap GUI must be a SurfaceGui")
local u250 = GUI.TreadmillScreenButtonShare()
assert(u250:IsA("SurfaceGui"), "Treadmill share GUI must be a SurfaceGui")
local u259 = GUI.TreadmillScreenSideButtons()
assert(u259:IsA("SurfaceGui"), "Treadmill side buttons GUI must be a SurfaceGui")
local u268 = GUI.TreadmillVideoSurfaceGui()
assert(u268:IsA("SurfaceGui"), "Treadmill video GUI must be a SurfaceGui")
local ButtonSwapLeft = u232.ButtonSwapLeft
assert(ButtonSwapLeft:IsA("GuiButton"), "Treadmill left swap button must be a GuiButton")
local ButtonSwapRight = u241.ButtonSwapRight
assert(ButtonSwapRight:IsA("ImageButton"), "Treadmill right swap button must be an ImageButton")
local GamepadGlyph = u232.ButtonSwapLeft.GamepadGlyph
assert(GamepadGlyph:IsA("GuiObject"), "Treadmill left swap glyph must be a GuiObject")
assert(GamepadGlyph:GetAttribute("GamepadKey") == "ButtonL1", "Treadmill left swap glyph must use ButtonL1")
local GamepadGlyph_2 = u241.ButtonSwapRight.GamepadGlyph
assert(GamepadGlyph_2:IsA("GuiObject"), "Treadmill right swap glyph must be a GuiObject")
assert(GamepadGlyph_2:GetAttribute("GamepadKey") == "ButtonR1", "Treadmill right swap glyph must use ButtonR1")
local ShareButton = u250.Frame.ShareButton
assert(ShareButton:IsA("GuiButton"), "Treadmill share button must be a GuiButton")
local VideoFrame = u268.VideoFrame
assert(VideoFrame:IsA("Frame"), "Treadmill video frame container must be a Frame")
local MainVideo = VideoFrame.MainVideo
assert(MainVideo:IsA("VideoFrame"), "Treadmill main video must be a VideoFrame")
local StopPlay = VideoFrame.StopPlay
assert(StopPlay:IsA("ImageLabel"), "Treadmill stop-play indicator must be an ImageLabel")
local MusicImage = VideoFrame.MusicImage
assert(MusicImage:IsA("ImageLabel"), "Treadmill music image must be an ImageLabel")
local Loading = VideoFrame.Loading
assert(Loading:IsA("GuiObject"), "Treadmill video loading frame must be a GuiObject")
local Spin = Loading.Spin
assert(Spin:IsA("GuiObject"), "Treadmill video loading spinner must be a GuiObject")
local Bar = VideoFrame.Bar
assert(Bar:IsA("GuiObject"), "Treadmill video bar must be a GuiObject")
local Progress = Bar.Progress
assert(Progress:IsA("GuiObject"), "Treadmill video progress must be a GuiObject")
local GoToNext = VideoFrame.GoToNext
assert(GoToNext:IsA("Frame"), "Treadmill VideoFrame.GoToNext must be a Frame")
local Glow = GoToNext.Glow
assert(Glow:IsA("ImageLabel"), "Treadmill GoToNext.Glow must be an ImageLabel")
local Arrow = GoToNext.Arrow
assert(Arrow:IsA("ImageLabel"), "Treadmill GoToNext.Arrow must be an ImageLabel")
local ArrowShadow = GoToNext.ArrowShadow
assert(ArrowShadow:IsA("ImageLabel"), "Treadmill GoToNext.ArrowShadow must be an ImageLabel")
local Label = GoToNext.Label
assert(Label:IsA("TextLabel"), "Treadmill GoToNext.Label must be a TextLabel")
local LabelShadow = GoToNext.LabelShadow
assert(LabelShadow:IsA("TextLabel"), "Treadmill GoToNext.LabelShadow must be a TextLabel")
local Position = Arrow.Position
local Position_2 = ArrowShadow.Position
local Paused = VideoFrame.Paused
assert(Paused:IsA("Frame"), "Treadmill VideoFrame.Paused must be a Frame")
local Glow_2 = Paused.Glow
assert(Glow_2:IsA("ImageLabel"), "Treadmill Paused.Glow must be an ImageLabel")
local StopPlay_2 = Paused.StopPlay
assert(StopPlay_2:IsA("ImageLabel"), "Treadmill Paused.StopPlay must be an ImageLabel")
local EnjoyFree = StopPlay_2:FindFirstChild("EnjoyFree")
local VideoCounter = VideoFrame:FindFirstChild("VideoCounter")
local u490 = {}
local v1 = {
    Property = "BackgroundTransparency",
    Instance = GoToNext,
    Value = GoToNext.BackgroundTransparency,
}
local v2 = {Property = "ImageTransparency", Instance = Glow, Value = Glow.ImageTransparency}
local v3 = {Property = "ImageTransparency", Instance = Arrow, Value = Arrow.ImageTransparency}
local v4 = {Property = "ImageTransparency", Instance = ArrowShadow, Value = ArrowShadow.ImageTransparency}
local v5 = {Property = "TextTransparency", Instance = Label, Value = Label.TextTransparency}
local v6 = {Property = "TextTransparency", Instance = LabelShadow, Value = LabelShadow.TextTransparency}
u490[1] = v1
u490[2] = v2
u490[3] = v3
u490[4] = v4
u490[5] = v5
u490[6] = v6
local u503 = {}
v1 = {Property = "BackgroundTransparency", Instance = Paused, Value = Paused.BackgroundTransparency}
v2 = {Property = "ImageTransparency", Instance = Glow_2, Value = Glow_2.ImageTransparency}
v3 = {Property = "ImageTransparency", Instance = StopPlay_2, Value = StopPlay_2.ImageTransparency}
u503[1] = v1
u503[2] = v2
u503[3] = v3
if EnjoyFree ~= nil and EnjoyFree:IsA("TextLabel") then
    table.insert(u503, {Property = "TextTransparency", Instance = EnjoyFree, Value = EnjoyFree.TextTransparency})
end
local u519 = 0
local u520 = nil
local u521 = nil
local u528 = table.clone(Media)
if Constants.IS_STUDIO then
    v4, v5 = Schema.TreadmillMediaEntries(u528)
    assert(v4, (("Failed to validate treadmill video media entries: %*"):format(v5)))
end
TreadmillMediaOverlay.ApplyTo(u528)
task.spawn(function() -- Line: 255 -- upvalues: RecommendationFlags (val), RecommendationFeedSource (val), u528 (val)
    RecommendationFlags.Enabled.Loaded:Wait()
    task.wait(math.random() * RecommendationFlags.PrefetchJitterSeconds:Get())
    RecommendationFeedSource.PrefetchFeed(u528)
end)
local u567 = {}
u567.MediaChanged = Signal.new()
u567.Stopped = Signal.new()

local function scaleUDim2(a1, a2) -- Line: 271 -- types: a1: userdata, a2: number
    return UDim2.new(UDim.new(a1.X.Scale * a2, a1.X.Offset * a2), UDim.new(a1.Y.Scale * a2, a1.Y.Offset * a2))
end

local function cancelStopPlayTween(a1) -- Line: 278
    local StopPlayTween = a1.StopPlayTween
    a1.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
end

local function resetStopPlayIndicator(a1) -- Line: 286
    local StopPlayTween = a1.StopPlayTween
    a1.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    a1.StopPlay.ImageTransparency = 0
    a1.StopPlay.Size = a1.StopPlayBaseSize
end

local function animateStopPlayIndicator(a1, a2) -- Line: 292
    -- upvalues: TweenService (val), u188 (val), u193 (val)
    local v1
    local StopPlayTween = a1.StopPlayTween
    a1.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    local StopPlay = a1.StopPlay
    StopPlay.Visible = true
    StopPlay.Image = if not a2 then "rbxassetid://84371411600743" else "rbxassetid://90908618020821"
    StopPlay.ImageTransparency = 0
    local StopPlayBaseSize = a1.StopPlayBaseSize
    StopPlay.Size = UDim2.new(
        UDim.new(StopPlayBaseSize.X.Scale * (if not a2 then 0.76 else 1.24), StopPlayBaseSize.X.Offset * v1),
        UDim.new(StopPlayBaseSize.Y.Scale * v1, StopPlayBaseSize.Y.Offset * v1)
    )
    local u51 = TweenService:Create(StopPlay, u188, {Size = a1.StopPlayBaseSize})
    a1.StopPlayTween = u51
    u51.Completed:Once(function() -- Line: 308 -- upvalues: a1 (val), u51 (val), a2 (val), TweenService (upval), StopPlay (val), u193 (upval)
        if a1.StopPlayTween ~= u51 then
            return
        end
        a1.StopPlayTween = nil
        if not a2 then
            return
        end
        local u12 = TweenService:Create(StopPlay, u193, {ImageTransparency = 1})
        a1.StopPlayTween = u12
        u12.Completed:Once(function() -- Line: 322 -- upvalues: a1 (upval), u12 (val), StopPlay (upval)
            if a1.StopPlayTween ~= u12 then
                return
            end
            a1.StopPlayTween = nil
            StopPlay.Visible = false
            StopPlay.ImageTransparency = 0
        end)
        u12:Play()
    end)
    u51:Play()
end

local function playCardFadeIn(a1, a2, a3) -- Line: 336 -- upvalues: TweenService (val) -- types: a1: table, a3: userdata
    local Instance_2, v1, v2
    for i, j in a1 do
        local Instance = j.Instance
        Instance[j.Property] = 1
        v2 = TweenService
        Instance_2 = j.Instance
        v1 = {}
        v1[j.Property] = j.Value
        local u25 = v2:Create(Instance_2, a3, v1)
        a2:Add(function() -- Line: 343 -- upvalues: u25 (val), Instance (val), j (val)
            u25:Cancel()
            Instance[j.Property] = j.Value
        end)
        u25:Play()
    end
end

local function hidePausedCard(a1) -- Line: 351 -- upvalues: Paused (val)
    local PausedCardTrove = a1.PausedCardTrove
    a1.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if a1.MusicSound ~= nil then
        a1.MusicImage.Visible = true
    end
    local PausedPreviewFrame = a1.PausedPreviewFrame
    local PausedPreviewBaseSize = a1.PausedPreviewBaseSize
    a1.PausedPreviewFrame = nil
    a1.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
end

local function showPausedCard(a1) -- Line: 371
    -- upvalues: Trove (val), playCardFadeIn (val), u503 (val), u220 (val), EnjoyFree (val), Paused (val)
    if a1.PausedCardTrove == nil and a1.EndCardTrove == nil then
        local v1 = Trove.new()
        a1.PausedCardTrove = v1
        playCardFadeIn(u503, v1, u220)
        if EnjoyFree ~= nil and EnjoyFree:IsA("TextLabel") then
            EnjoyFree.Visible = not a1.HasPlayedMedia
        end
        Paused.Visible = true
        a1.MusicImage.Visible = false
        local u27 = a1.VideoFramePool.GetActiveFrame()
        if u27.TimePosition <= 0 and not u27.Playing then
            pcall(function() -- Line: 391 -- upvalues: u27 (val)
                u27:Play()
                u27:Pause()
                u27.TimePosition = 0
            end)
        end
        local Size = u27.Size
        local v2 = math.max(if not (0 < Size.X.Scale) then 1 else 1 / Size.X.Scale, if not (0 < Size.Y.Scale) then 1 else 1 / Size.Y.Scale)
        if v2 > 1 then
            a1.PausedPreviewFrame = u27
            a1.PausedPreviewBaseSize = Size
            u27.Size = UDim2.new(UDim.new(Size.X.Scale * v2, Size.X.Offset * v2), UDim.new(Size.Y.Scale * v2, Size.Y.Offset * v2))
        end
        return
    end
end

local function hideGoToNext(a1) -- Line: 409 -- upvalues: GoToNext (val)
    local EndCardTrove = a1.EndCardTrove
    a1.EndCardTrove = nil
    if EndCardTrove ~= nil then
        EndCardTrove:Destroy()
    end
    GoToNext.Visible = false
end

local function spawnGoToNextPulse(a1) -- Line: 418
    -- upvalues: Arrow (val), GoToNext (val), TweenService (val), u215 (val)
    local u4 = Arrow:Clone()
    u4.Name = "ArrowPulse"
    u4.ZIndex = math.max(Arrow.ZIndex - 1, 0)
    u4.ImageTransparency = 0.35
    u4.Parent = GoToNext
    a1:Add(u4)
    local v1 = TweenService
    local v2 = u215
    local v3 = {ImageTransparency = 1}
    local Size = Arrow.Size
    v3.Size = UDim2.new(UDim.new(Size.X.Scale * 2.2, Size.X.Offset * 2.2), UDim.new(Size.Y.Scale * 2.2, Size.Y.Offset * 2.2))
    v1 = v1:Create(u4, v2, v3)
    v1.Completed:Once(function() -- Line: 430 -- upvalues: u4 (val)
        u4:Destroy()
    end)
    v1:Play()
end

local function showGoToNext(a1) -- Line: 436
    -- upvalues: Paused (val), Trove (val), playCardFadeIn (val), u490 (val), u210 (val), GoToNext (val), Arrow (val)
    -- upvalues: Position (val), ArrowShadow (val), Position_2 (val), spawnGoToNextPulse (val)
    if a1.EndCardTrove ~= nil then
        return
    end
    local PausedCardTrove = a1.PausedCardTrove
    a1.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if a1.MusicSound ~= nil then
        a1.MusicImage.Visible = true
    end
    local PausedPreviewFrame = a1.PausedPreviewFrame
    local PausedPreviewBaseSize = a1.PausedPreviewBaseSize
    a1.PausedPreviewFrame = nil
    a1.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
    local u20 = Trove.new()
    a1.EndCardTrove = u20
    a1.StopPlay.Visible = false
    a1.SideButtonsSurfaceGui.Enabled = false
    a1.ShareSurfaceGui.Enabled = false
    playCardFadeIn(u490, u20, u210)
    GoToNext.Visible = true
    local u40 = GoToNext:GetAttribute("SwaySeconds") or 1.2
    local u46 = GoToNext:GetAttribute("SwayScale") or 0.02
    local u48 = os.clock()
    local u49 = 0
    u20:BindToRenderStep("TreadmillGoToNextCard", Enum.RenderPriority.Last.Value, function() -- Line: 454
        -- upvalues: u48 (val), u40 (val), u46 (val), Arrow (upval), Position (upval), ArrowShadow (upval)
        -- upvalues: Position_2 (upval), u49 (ref), spawnGoToNextPulse (upval), u20 (val)
        local v1 = os.clock() - u48
        local v2 = UDim2.fromScale((math.sin(v1 * 3.141592653589793 * 2 / u40)) * u46, 0)
        Arrow.Position = Position + v2
        ArrowShadow.Position = Position_2 + v2
        v2 = math.floor(v1 / u40 + 0.75)
        if u49 < v2 then
            u49 = v2
            spawnGoToNextPulse(u20)
        end
    end)
    u20:Add(function() -- Line: 468 -- upvalues: Arrow (upval), Position (upval), ArrowShadow (upval), Position_2 (upval)
        Arrow.Position = Position
        ArrowShadow.Position = Position_2
    end)
end

local function setSoundPlaying(a1, a2) -- Line: 474 -- types: a1: userdata, a2: boolean
    if not a2 then
        a1:Pause()
        return
    end
    if 0 < a1.TimePosition then
        a1:Resume()
        return
    end
    a1:Play()
end

local function setMediaPlaying(a1, a2, a3) -- Line: 486
    -- upvalues: Paused (val), showPausedCard (val), animateStopPlayIndicator (val)
    local MusicSound = a1.MusicSound
    if MusicSound == nil then
        if not a2 then
            a1.VideoFramePool.GetActiveFrame():Pause()
            local VideoBackgroundMusicSound_2 = a1.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound_2 ~= nil then
                VideoBackgroundMusicSound_2:Pause()
            end
        else
            a1.VideoFramePool.GetActiveFrame():Play()
            local VideoBackgroundMusicSound = a1.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound ~= nil then
                if not (0 < VideoBackgroundMusicSound.TimePosition) then
                    VideoBackgroundMusicSound:Play()
                else
                    VideoBackgroundMusicSound:Resume()
                end
            end
        end
    elseif not a2 then
        MusicSound:Pause()
    elseif not (0 < MusicSound.TimePosition) then
        MusicSound:Play()
    else
        MusicSound:Resume()
    end
    if not a2 then
        showPausedCard(a1)
    else
        a1.HasPlayedMedia = true
        local PausedCardTrove = a1.PausedCardTrove
        a1.PausedCardTrove = nil
        if PausedCardTrove ~= nil then
            PausedCardTrove:Destroy()
        end
        Paused.Visible = false
        if a1.MusicSound ~= nil then
            a1.MusicImage.Visible = true
        end
        local PausedPreviewFrame = a1.PausedPreviewFrame
        local PausedPreviewBaseSize = a1.PausedPreviewBaseSize
        a1.PausedPreviewFrame = nil
        a1.PausedPreviewBaseSize = nil
        if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
            PausedPreviewFrame.Size = PausedPreviewBaseSize
        end
    end
    if a3 ~= false then
        animateStopPlayIndicator(a1, a2)
        return
    end
    local StopPlayTween = a1.StopPlayTween
    a1.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    a1.StopPlay.ImageTransparency = 0
    a1.StopPlay.Size = a1.StopPlayBaseSize
    a1.StopPlay.Visible = not a2
end

local function getSurfaceHitScale(a1, a2, a3) -- Line: 520 -- types: a1: userdata, a3: vector
    local v1
    local Unit = v1:Cross(if math.abs((if a2 ~= Enum.NormalId.Front then if a2 ~= Enum.NormalId.Back then if a2 ~= Enum.NormalId.Right then if a2 ~= Enum.NormalId.Left then if a2 ~= Enum.NormalId.Top then Vector3.new(0, -1, 0) else Vector3.new(0, 1, 0) else Vector3.new(-1, 0, 0) else Vector3.new(1, 0, 0) else Vector3.new(0, 0, 1) else Vector3.new(0, 0, -1)).Y) ~= 1 then Vector3.new(0, 1, 0) else Vector3.new(0, 0, 1)).Unit
    local Unit_2 = Unit:Cross(v1).Unit
    local v2 = a1.CFrame:PointToObjectSpace(a3)
    local v3 = a1.Size * 0.5
    local v4 = (math.abs(v1.X)) * v3.X + (math.abs(v1.Y)) * v3.Y + (math.abs(v1.Z)) * v3.Z
    local v5 = (math.abs(Unit.X)) * v3.X + (math.abs(Unit.Y)) * v3.Y + (math.abs(Unit.Z)) * v3.Z
    local v6 = (math.abs(Unit_2.X)) * v3.X + (math.abs(Unit_2.Y)) * v3.Y + (math.abs(Unit_2.Z)) * v3.Z
    v4 = v2 - v1 * v4
    return Vector2.new(math.clamp(0.5 - (v4:Dot(Unit)) / (v5 * 2), 0, 1), (math.clamp(0.5 - (v4:Dot(Unit_2)) / (v6 * 2), 0, 1)))
end

local function getVideoScreenTapScale(a1, a2) -- Line: 557
    -- upvalues: Workspace (val), getSurfaceHitScale (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    local v1 = CurrentCamera:ScreenPointToRay(a2.X, a2.Y)
    local v2 = Workspace:Raycast(v1.Origin, v1.Direction * 1000, a1.VideoScreenRaycastParams)
    if v2 ~= nil and v2.Instance == a1.VideoScreenPart then
        return getSurfaceHitScale(a1.VideoScreenPart, a1.VideoSurfaceGui.Face, v2.Position)
    end
    return nil
end

local function toggleMediaPlaying(a1) -- Line: 576 -- upvalues: setMediaPlaying (val)
    local MusicSound = a1.MusicSound
    if MusicSound ~= nil then
        setMediaPlaying(a1, not MusicSound.IsPlaying)
        return
    end
    setMediaPlaying(a1, not a1.VideoFramePool.GetActiveFrame().Playing)
end

local function setVideoProgress(a1, a2) -- Line: 586 -- types: a2: number
    local Size = a1.Progress.Size
    a1.Progress.Size = UDim2.new(math.clamp(a2, 0, 1), 0, Size.Y.Scale, Size.Y.Offset)
end

local function updateMediaProgress(a1) -- Line: 591
    local v1
    local MusicSound = a1.MusicSound
    if MusicSound ~= nil then
        local TimeLength = MusicSound.TimeLength
        if TimeLength <= 0 then
            local Size = a1.Progress.Size
            a1.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
            return
        end
        v1 = MusicSound.TimePosition / TimeLength
        local Size_2 = a1.Progress.Size
        a1.Progress.Size = UDim2.new(math.clamp(v1, 0, 1), 0, Size_2.Y.Scale, Size_2.Y.Offset)
        return
    end
    local v2 = a1.VideoFramePool.GetActiveFrame()
    local TimeLength_2 = v2.TimeLength
    if TimeLength_2 <= 0 then
        local Size_3 = a1.Progress.Size
        a1.Progress.Size = UDim2.new(0, 0, Size_3.Y.Scale, Size_3.Y.Offset)
        return
    end
    v1 = v2.TimePosition / TimeLength_2
    local Size_4 = a1.Progress.Size
    a1.Progress.Size = UDim2.new(math.clamp(v1, 0, 1), 0, Size_4.Y.Scale, Size_4.Y.Offset)
end

local function getWatchedFraction(a1) -- Line: 614
    local MusicSound = a1.MusicSound
    if MusicSound ~= nil then
        local TimeLength = MusicSound.TimeLength
        if TimeLength <= 0 then
            return nil
        end
        return MusicSound.TimePosition / TimeLength
    end
    local v1 = a1.VideoFramePool.GetActiveFrame()
    local TimeLength_2 = v1.TimeLength
    if TimeLength_2 <= 0 then
        return nil
    end
    return v1.TimePosition / TimeLength_2
end

local function hideLoading(a1) -- Line: 632
    local LoadingTween = a1.LoadingTween
    a1.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    a1.Loading.Visible = false
    a1.LoadingSpin.Rotation = 0
end

local function showLoading(a1) -- Line: 643 -- upvalues: TweenService (val), u179 (val)
    local LoadingTween = a1.LoadingTween
    a1.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    a1.Loading.Visible = false
    a1.LoadingSpin.Rotation = 0
    a1.Loading.Visible = true
    a1.ShareSurfaceGui.Enabled = false
    a1.SideButtonsSurfaceGui.Enabled = false
    local v1 = TweenService:Create(a1.LoadingSpin, u179, {Rotation = 360})
    a1.LoadingTween = v1
    v1:Play()
end

local function clearMusicImage(a1) -- Line: 656
    a1.MusicImage.Visible = false
    a1.MusicImage.Image = ""
    local MusicSound = a1.MusicSound
    a1.MusicSound = nil
    if MusicSound == nil then
        return
    end
    MusicSound:Stop()
    MusicSound:Destroy()
end

local function clearVideoBackgroundMusic(a1) -- Line: 670
    local VideoBackgroundMusicSound = a1.VideoBackgroundMusicSound
    a1.VideoBackgroundMusicSound = nil
    if VideoBackgroundMusicSound == nil then
        return
    end
    VideoBackgroundMusicSound:Stop()
    VideoBackgroundMusicSound:Destroy()
end

local function unloadVideo(a1) -- Line: 681 -- upvalues: GoToNext (val), Paused (val)
    a1.VideoTrove:Clean()
    local EndCardTrove = a1.EndCardTrove
    a1.EndCardTrove = nil
    if EndCardTrove ~= nil then
        EndCardTrove:Destroy()
    end
    GoToNext.Visible = false
    local PausedCardTrove = a1.PausedCardTrove
    a1.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if a1.MusicSound ~= nil then
        a1.MusicImage.Visible = true
    end
    local PausedPreviewFrame = a1.PausedPreviewFrame
    local PausedPreviewBaseSize = a1.PausedPreviewBaseSize
    a1.PausedPreviewFrame = nil
    a1.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
    local LoadingTween = a1.LoadingTween
    a1.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    a1.Loading.Visible = false
    a1.LoadingSpin.Rotation = 0
    a1.MusicImage.Visible = false
    a1.MusicImage.Image = ""
    local MusicSound = a1.MusicSound
    a1.MusicSound = nil
    if MusicSound ~= nil then
        MusicSound:Stop()
        MusicSound:Destroy()
    end
    local VideoBackgroundMusicSound = a1.VideoBackgroundMusicSound
    a1.VideoBackgroundMusicSound = nil
    if VideoBackgroundMusicSound ~= nil then
        VideoBackgroundMusicSound:Stop()
        VideoBackgroundMusicSound:Destroy()
    end
    a1.VideoFramePool.ClearActive()
    a1.MainVideo.Size = a1.MainVideoBaseSize
    a1.MainVideo.Volume = 1
    a1.MainVideo.Video = ""
    local StopPlayTween = a1.StopPlayTween
    a1.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    a1.StopPlay.ImageTransparency = 0
    a1.StopPlay.Size = a1.StopPlayBaseSize
    a1.StopPlay.Visible = true
    local Size = a1.Progress.Size
    a1.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
end

local function wrapVideoIndex(a1) -- Line: 697 -- upvalues: u528 (val) -- types: a1: number
    if a1 < 1 then
        return #u528
    end
    if #u528 < a1 then
        return 1
    end
    return a1
end

local function preloadMediaIndices(a1, a2) -- Line: 709
    -- upvalues: u528 (val), WarmAssets (val), WarmSounds (val)
    local Music, v1
    local v2 = {}
    local v3 = {}
    local v4 = {}
    for i, v in ipairs(a2) do
        v1 = u528[v]
        if v1.Kind == "Video" then
            table.insert(v4, {MediaEntry = v1, MediaIndex = v})
            Music = v1.Music
            if Music then
                table.insert(v3, Music.SoundId)
            end
        elseif v1.Kind == "MusicImage" then
            table.insert(v2, v1.Image)
            table.insert(v3, v1.SoundId)
        end
    end
    a1.VideoFramePool.Preload(v4)
    if #v2 > 0 then
        task.spawn(WarmAssets, v2)
    end
    if #v3 > 0 then
        task.spawn(WarmSounds, v3)
    end
end

local function preloadDirectionalAssets(a1, a2, a3) -- Line: 739
    -- upvalues: u528 (val), preloadMediaIndices (val)
    if a3 < 0 then
        return
    end
    local v1 = {}
    local v2 = a2 + a3 * 1
    table.insert(v1, if not (v2 < 1) then if not (#u528 < v2) then v2 else 1 else #u528)
    v2 = a2 + a3 * 2
    table.insert(v1, if not (v2 < 1) then if not (#u528 < v2) then v2 else 1 else #u528)
    v2 = a2 + a3 * 3
    table.insert(v1, if not (v2 < 1) then if not (#u528 < v2) then v2 else 1 else #u528)
    preloadMediaIndices(a1, v1)
end

local function loadVideoBackgroundMusic(a1, a2) -- Line: 751
    local Sound = Instance.new("Sound")
    Sound.Name = "TreadmillVideoBackgroundMusic"
    Sound.SoundId = a2.SoundId
    Sound.Volume = a2.Volume
    Sound.Looped = true
    Sound.Parent = a1.MainVideo
    a1.VideoBackgroundMusicSound = Sound
    a1.VideoTrove:Add(function() -- Line: 762 -- upvalues: a1 (val), Sound (val)
        if a1.VideoBackgroundMusicSound == Sound then
            a1.VideoBackgroundMusicSound = nil
        end
        if Sound.Parent ~= nil then
            Sound:Stop()
            Sound:Destroy()
        end
    end)
end

local function resetVideoBackgroundMusic(a1) -- Line: 774
    local VideoBackgroundMusicSound = a1.VideoBackgroundMusicSound
    if VideoBackgroundMusicSound == nil then
        return
    end
    VideoBackgroundMusicSound:Stop()
    VideoBackgroundMusicSound.TimePosition = 0
end

local function loadVideoMedia(a1, a2, a3) -- Line: 784
    -- upvalues: loadVideoBackgroundMusic (val), u519 (ref), RecommendationSignals (val), showGoToNext (val)
    -- upvalues: setMediaPlaying (val), showLoading (val)
    local v1 = a1.VideoFramePool.Activate(a1.VideoIndex, a2)
    local Size = a2.Size or a1.MainVideoBaseSize
    v1.Size = Size
    local Size_2 = a1.Progress.Size
    a1.Progress.Size = UDim2.new(0, 0, Size_2.Y.Scale, Size_2.Y.Offset)
    local Music = a2.Music
    if Music ~= nil then
        loadVideoBackgroundMusic(a1, Music)
    end
    a1.VideoTrove:Add((v1.Ended:Connect(function() -- Line: 797
        -- upvalues: u519 (upval), a1 (val), a3 (val), RecommendationSignals (upval), showGoToNext (upval)
        if u519 == a1.Token and a1.VideoSerial == a3 then
            RecommendationSignals.MarkEnded()
            local VideoBackgroundMusicSound = a1.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound ~= nil then
                VideoBackgroundMusicSound:Stop()
                VideoBackgroundMusicSound.TimePosition = 0
            end
            showGoToNext(a1)
            return
        end
    end)))
    if not v1.IsLoaded then
        a1.StopPlay.Visible = false
        showLoading(a1)
        local u68 = nil
        u68 = v1.Loaded:Connect(function() -- Line: 818 -- upvalues: u519 (upval), a1 (val), a3 (val), u68 (ref), setMediaPlaying (upval)
            if u519 == a1.Token and a1.VideoSerial == a3 then
                u68:Disconnect()
                local v1 = a1
                local LoadingTween = v1.LoadingTween
                v1.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
                v1.Loading.Visible = false
                v1.LoadingSpin.Rotation = 0
                a1.ShareSurfaceGui.Enabled = true
                a1.SideButtonsSurfaceGui.Enabled = true
                setMediaPlaying(a1, a1.HasPlayedMedia, false)
                return
            end
        end)
        a1.VideoTrove:Add(u68)
        return
    end
    local LoadingTween = a1.LoadingTween
    a1.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    a1.Loading.Visible = false
    a1.LoadingSpin.Rotation = 0
    a1.ShareSurfaceGui.Enabled = true
    a1.SideButtonsSurfaceGui.Enabled = true
    setMediaPlaying(a1, a1.HasPlayedMedia, false)
end

local function loadMusicImageMedia(a1, a2, a3) -- Line: 832
    -- upvalues: u519 (ref), RecommendationSignals (val), showGoToNext (val), setMediaPlaying (val), showLoading (val)
    a1.VideoFramePool.ClearActive()
    a1.MainVideo.Video = ""
    a1.MusicImage.Image = a2.Image
    a1.MusicImage.Visible = true
    local Size = a1.Progress.Size
    a1.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
    local Sound = Instance.new("Sound")
    Sound.Name = "TreadmillMusicImageSound"
    Sound.SoundId = a2.SoundId
    Sound.Volume = a2.Volume
    Sound.Parent = a1.MainVideo
    Sound.Looped = false
    a1.MusicSound = Sound
    a1.VideoTrove:Add(function() -- Line: 850 -- upvalues: a1 (val), Sound (val)
        if a1.MusicSound == Sound then
            a1.MusicSound = nil
        end
        if Sound.Parent ~= nil then
            Sound:Stop()
            Sound:Destroy()
        end
    end)
    a1.VideoTrove:Add((Sound.Ended:Connect(function() -- Line: 861
        -- upvalues: u519 (upval), a1 (val), a3 (val), RecommendationSignals (upval), showGoToNext (upval)
        if u519 == a1.Token and a1.VideoSerial == a3 then
            RecommendationSignals.MarkEnded()
            showGoToNext(a1)
            return
        end
    end)))
    if not Sound.IsLoaded then
        a1.StopPlay.Visible = false
        showLoading(a1)
        local u70 = nil
        u70 = Sound.Loaded:Connect(function() -- Line: 881 -- upvalues: u519 (upval), a1 (val), a3 (val), u70 (ref), setMediaPlaying (upval)
            if u519 == a1.Token and a1.VideoSerial == a3 then
                u70:Disconnect()
                local v1 = a1
                local LoadingTween = v1.LoadingTween
                v1.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
                v1.Loading.Visible = false
                v1.LoadingSpin.Rotation = 0
                a1.ShareSurfaceGui.Enabled = true
                a1.SideButtonsSurfaceGui.Enabled = true
                setMediaPlaying(a1, a1.HasPlayedMedia, false)
                return
            end
        end)
        a1.VideoTrove:Add(u70)
        return
    end
    local LoadingTween = a1.LoadingTween
    a1.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    a1.Loading.Visible = false
    a1.LoadingSpin.Rotation = 0
    a1.ShareSurfaceGui.Enabled = true
    a1.SideButtonsSurfaceGui.Enabled = true
    setMediaPlaying(a1, a1.HasPlayedMedia, false)
end

local function loadVideo(a1, a2, a3, a4, a5) -- Line: 895
    -- upvalues: u528 (val), RecommendationSignals (val), Remotes (val), unloadVideo (val), u567 (val)
    -- upvalues: loadVideoMedia (val), loadMusicImageMedia (val), preloadMediaIndices (val)
    -- upvalues: RecommendationFeedSource (val), preloadDirectionalAssets (val)
    a1.VideoSerial = a1.VideoSerial + 1
    local VideoSerial = a1.VideoSerial
    a1.VideoIndex = if not (a2 < 1) then if not (#u528 < a2) then a2 else 1 else #u528
    if RecommendationSignals.HasActiveView() then
        local v1
        local EndView = RecommendationSignals.EndView
        local MusicSound = a1.MusicSound
        if MusicSound == nil then
            local v2 = a1.VideoFramePool.GetActiveFrame()
            local TimeLength_2 = v2.TimeLength
            v1 = if not (TimeLength_2 <= 0) then v2.TimePosition / TimeLength_2 else nil
        else
            local TimeLength = MusicSound.TimeLength
            v1 = if not (TimeLength <= 0) then MusicSound.TimePosition / TimeLength else nil
        end
        EndView(v1)
    end
    if a5 ~= nil then
        Remotes.Treadmill.SubmitClipView:FireServer(a5.MediaKey)
        RecommendationSignals.BeginView(a5)
    elseif a3 ~= nil then
        Remotes.Treadmill.RefreshClipCursor:FireServer(a3)
    end
    unloadVideo(a1)
    a1.LikeController:UpdatePresentation()
    a1.FriendLikesController:HandleMediaChanged()
    local v3 = u528[a1.VideoIndex]
    u567.MediaChanged:Fire(v3, a1.VideoScreenPart)
    if v3.Kind ~= "Video" then
        loadMusicImageMedia(a1, v3, VideoSerial)
    else
        loadVideoMedia(a1, v3, VideoSerial)
    end
    if a5 ~= nil then
        preloadMediaIndices(a1, RecommendationFeedSource.PeekAhead(3))
        return
    end
    preloadDirectionalAssets(a1, a1.VideoIndex, a4)
end

local function cleanupRuntime() -- Line: 933
    -- upvalues: u519 (ref), u567 (val), u520 (ref), u521 (ref), RecommendationSignals (val), unloadVideo (val)
    u519 = u519 + 1
    u567.Stopped:Fire()
    local v1 = u520
    u520 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
    v1 = u521
    u521 = nil
    if v1 == nil then
        return
    end
    if RecommendationSignals.HasActiveView() then
        local v2
        local EndView = RecommendationSignals.EndView
        local MusicSound = v1.MusicSound
        if MusicSound == nil then
            local v3 = v1.VideoFramePool.GetActiveFrame()
            local TimeLength_2 = v3.TimeLength
            v2 = if not (TimeLength_2 <= 0) then v3.TimePosition / TimeLength_2 else nil
        else
            local TimeLength = MusicSound.TimeLength
            v2 = if not (TimeLength <= 0) then MusicSound.TimePosition / TimeLength else nil
        end
        EndView(v2)
    end
    unloadVideo(v1)
    v1.LikeController:Destroy()
    v1.FriendLikesController:Destroy()
    v1.StopPlay.Visible = true
    v1.LeftSurfaceGui.Enabled = false
    v1.RightSurfaceGui.Enabled = false
    v1.ShareSurfaceGui.Enabled = false
    v1.SideButtonsSurfaceGui.Enabled = false
    v1.VideoSurfaceGui.Enabled = false
    v1.Trove:Destroy()
end

local function projectConsoleSwapMarker(a1, a2) -- Line: 965
    -- upvalues: PlatformController (val), GamepadBindings (val)
    local v1 = PlatformController.IsConsole() and a1:GetAttribute("ManualVisibility") ~= true
    a1.Visible = v1
    if not PlatformController.IsConsole() then
        return
    end
    if a1:IsA("ImageLabel") then
        a1.Image = GamepadBindings.GlyphFor(a2)
        return
    end
    if a1:IsA("ImageButton") then
        a1.Image = GamepadBindings.GlyphFor(a2)
    end
end

local function projectConsoleSwapMarkers() -- Line: 981
    -- upvalues: projectConsoleSwapMarker (val), GamepadGlyph (val), GamepadGlyph_2 (val)
    projectConsoleSwapMarker(GamepadGlyph, "ButtonL1")
    projectConsoleSwapMarker(GamepadGlyph_2, "ButtonR1")
end

local function isExcludedMediaIndex(a1) -- Line: 986
    -- upvalues: u528 (val), TreadmillMediaOverlay (val), TreadmillMediaIdentity (val)
    local v1 = u528[a1]
    local v2 = false
    if v1 ~= nil then
        v2 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v1))
    end
    return v2
end

local function updateVideoCounter() -- Line: 992
    -- upvalues: VideoCounter (val), u528 (val), TreadmillMediaOverlay (val), TreadmillMediaIdentity (val)
    if VideoCounter ~= nil and VideoCounter:IsA("TextLabel") then
        local v1, v2
        local v3 = 0
        local v4 = nil
        local v5 = nil
        for i in u528, v4, v5 do
            v2 = u528[i]
            v1 = false
            if v2 ~= nil then
                v1 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v2))
            end
            if not v1 then
                v3 = v3 + 1
            end
        end
        VideoCounter.Text = ("TOTAL VIDEOS: %*"):format(v3)
        return
    end
end

local function sequencerNextSkippingExcluded(a1) -- Line: 1008
    -- upvalues: FeedSequencer (val), u528 (val), TreadmillMediaOverlay (val), TreadmillMediaIdentity (val)
    -- upvalues: Remotes (val)
    local v1, v2, v3
    local v4, v5 = FeedSequencer.Next(a1.Feed)
    local v6 = #u528
    for i = 1, v6 do
        v3 = u528[v4]
        v1 = false
        if v3 ~= nil then
            v1 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v3))
        end
        if not v1 then
            break
        end
        Remotes.Treadmill.RefreshClipCursor:FireServer(v5)
        v1, v2 = FeedSequencer.Next(v7.Feed)
        v4 = v1
        v5 = v2
    end
    return v4, v5
end

local function sequencerPreviousSkippingExcluded(a1) -- Line: 1020
    -- upvalues: FeedSequencer (val), u528 (val), TreadmillMediaOverlay (val), TreadmillMediaIdentity (val)
    -- upvalues: Remotes (val), sequencerNextSkippingExcluded (val)
    local v1, v2, v3, v4, v5
    local v6, v7, v8 = FeedSequencer.Previous(a1.Feed)
    if not v8 then
        return v6, v7, false
    end
    local v9 = #u528
    for i = 1, v9 do
        v8 = u528[v6]
        v3 = false
        if v8 ~= nil then
            v3 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v8))
        end
        if not v3 then
            return v6, v7, true
        end
        Remotes.Treadmill.RefreshClipCursor:FireServer(v7)
        v3, v4, v5 = FeedSequencer.Previous(v10.Feed)
        if not v5 then
            v1, v2 = sequencerNextSkippingExcluded(v10)
            return v1, v2, true
        end
        v6 = v3
        v7 = v4
    end
    return v6, v7, true
end

local function bindVideoRuntime(a1, a2, a3, a4) -- Line: 1043
    -- upvalues: u519 (ref), TreadmillUtil (val), u229 (val), Trove (val), FeedSequencer (val), u528 (val)
    -- upvalues: LocalPlayer (val), RecommendationFeedSource (val), VideoFramePool (val), MainVideo (val)
    -- upvalues: LikeController (val), setMediaPlaying (val), VideoFrame (val), FriendLikesController (val), u232 (val)
    -- upvalues: Loading (val), Spin (val), MusicImage (val), Progress (val), u241 (val), u250 (val), u259 (val)
    -- upvalues: StopPlay (val), u268 (val), u521 (ref), ImageColorPulse (val), ButtonSwapRight (val), u198 (val)
    -- upvalues: u205 (val), loadVideo (val), sequencerPreviousSkippingExcluded (val)
    -- upvalues: sequencerNextSkippingExcluded (val), ButtonFX (val), ButtonSwapLeft (val)
    -- upvalues: projectConsoleSwapMarker (val), GamepadGlyph (val), GamepadGlyph_2 (val), PlatformController (val)
    -- upvalues: projectConsoleSwapMarkers (val), ContextActionService (val), CommentsController (val), Value (val)
    -- upvalues: ButtonHintStrip (val), ButtonL2 (val), ButtonR2 (val), ShareButton (val), TryCall (val)
    -- upvalues: SocialService (val), RecommendationSignals (val), TouchTapTracker (val), getVideoScreenTapScale (val)
    -- upvalues: UserInputService (val), updateMediaProgress (val), unloadVideo (val), TreadmillMediaOverlay (val)
    -- upvalues: TreadmillMediaIdentity (val), Remotes (val)
    if a4 ~= u519 then
        return
    end
    local v1, v2, v3 = TreadmillUtil.FindVideoPresentationParts(a1)
    if v1 ~= nil and v2 ~= nil and v3 ~= nil then
        if a4 ~= u519 then
            return
        end
        local v4 = Trove.new()
        local v5 = v4:Extend()
        local v6 = RaycastParams.new()
        v6.FilterType = Enum.RaycastFilterType.Include
        v6.FilterDescendantsInstances = {v1}
        local v7 = FeedSequencer.CreateRuntime(u528, a3, LocalPlayer.UserId)
        RecommendationFeedSource.PrefetchFeed(u528)
        local v8 = RecommendationFeedSource.GetReadyItem()
        local v9 = VideoFramePool.new(MainVideo)
        local u41 = nil
        local u50 = LikeController.new(function() -- Line: 1077 -- upvalues: u41 (ref)
            local v1 = u41
            if v1 ~= nil then
                return v1.VideoIndex
            end
            return 1
        end, function() -- Line: 1080 -- upvalues: u41 (ref), setMediaPlaying (upval)
            local v1 = u41
            assert(v1 ~= nil, "Treadmill runtime must exist before handling like single tap")
            local RequestNext = v1.RequestNext
            if v1.EndCardTrove ~= nil and RequestNext ~= nil then
                RequestNext()
                return
            end
            local MusicSound = v1.MusicSound
            if MusicSound ~= nil then
                setMediaPlaying(v1, not MusicSound.IsPlaying)
                return
            end
            setMediaPlaying(v1, not v1.VideoFramePool.GetActiveFrame().Playing)
        end, u528, v4, VideoFrame, v1)
        local u59 = {
            EndCardTrove = nil,
            Feed = v7,
            FriendLikesController = FriendLikesController.new(function() -- Line: 1092 -- upvalues: u41 (ref)
                local v1 = u41
                if v1 ~= nil then
                    return v1.VideoIndex
                end
                return 1
            end, function() -- Line: 1096 -- upvalues: u50 (val)
                u50:SuppressScreenTap()
            end, u528, v4, v1),
            HasPlayedMedia = false,
            LeftSurfaceGui = u232,
            LikeController = u50,
            Loading = Loading,
            LoadingTween = nil,
            PausedCardTrove = nil,
            PausedPreviewBaseSize = nil,
            PausedPreviewFrame = nil,
            RequestNext = nil,
            LoadingSpin = Spin,
            MainVideo = MainVideo,
            MainVideoBaseSize = MainVideo.Size,
            MusicImage = MusicImage,
            MusicSound = nil,
            Progress = Progress,
        }
        u59.RecommendationActive = v8 ~= nil
        u59.RightSurfaceGui = u241
        u59.ShareSurfaceGui = u250
        u59.SideButtonsSurfaceGui = u259
        u59.StopPlay = StopPlay
        u59.StopPlayBaseSize = StopPlay.Size
        u59.StopPlayTween = nil
        u59.Token = a4
        u59.Trove = v4
        u59.VideoBackgroundMusicSound = nil
        u59.VideoFrame = VideoFrame
        u59.VideoIndex = 1
        u59.VideoScreenPart = v1
        u59.VideoScreenRaycastParams = v6
        u59.VideoSerial = 0
        u59.VideoSurfaceGui = u268
        u59.VideoTrove = v5
        u59.VideoFramePool = v9
        v4:Add(v9.Destroy)
        if a4 ~= u519 then
            v4:Destroy()
            return
        end
        u521 = u59
        u232.Adornee = v2
        u241.Adornee = v3
        u250.Adornee = v1
        u259.Adornee = v1
        u268.Adornee = v1
        u232.Enabled = true
        u241.Enabled = true
        u250.Enabled = true
        u259.Enabled = true
        u268.Enabled = true
        VideoFrame.Active = true
        MainVideo.Active = true
        local u137 = nil
        if not u59.Feed.HasSwappedRight then
            u137 = ImageColorPulse.Start(ButtonSwapRight, u198, u205)
            v4:Add(function() -- Line: 1166 -- upvalues: u137 (ref)
                local v1 = u137
                if v1 ~= nil then
                    v1()
                    u137 = nil
                end
            end)
        end

        local function swapLeft() -- Line: 1175
            -- upvalues: u59 (val), RecommendationFeedSource (upval), loadVideo (upval)
            -- upvalues: sequencerPreviousSkippingExcluded (upval)
            local v1, v2, v3
            if u59.RecommendationActive then
                v1, v2 = RecommendationFeedSource.Previous()
                if v1 ~= nil then
                    if v2 then
                        loadVideo(u59, v1.MediaIndex, nil, -1, v1)
                    end
                    return
                end
                u59.RecommendationActive = false
            end
            v1, v2, v3 = sequencerPreviousSkippingExcluded(u59)
            if not v3 then
                return
            end
            loadVideo(u59, v1, v2, -1)
        end

        local function swapRight() -- Line: 1194
            -- upvalues: u137 (ref), u59 (val), RecommendationFeedSource (upval), loadVideo (upval)
            -- upvalues: sequencerNextSkippingExcluded (upval)
            local v1 = u137
            if v1 ~= nil then
                v1()
                u137 = nil
            end
            if u59.RecommendationActive then
                v1 = RecommendationFeedSource.Next()
                if v1 ~= nil then
                    loadVideo(u59, v1.MediaIndex, nil, 1, v1)
                    return
                end
                u59.RecommendationActive = false
            end
            local v2, v3 = sequencerNextSkippingExcluded(u59)
            loadVideo(u59, v2, v3, 1)
        end

        u59.RequestNext = swapRight
        v4:Add((ButtonFX(ButtonSwapLeft, nil, swapLeft)))
        v4:Add((ButtonFX(ButtonSwapRight, nil, swapRight)))
        projectConsoleSwapMarker(GamepadGlyph, "ButtonL1")
        projectConsoleSwapMarker(GamepadGlyph_2, "ButtonR1")
        v4:Add((PlatformController.Changed:Connect(projectConsoleSwapMarkers)))
        local v10 = ContextActionService
        local v11 = Value
        local ButtonL1 = Enum.KeyCode.ButtonL1
        local ButtonR1 = Enum.KeyCode.ButtonR1
        local ButtonL2_2 = Enum.KeyCode.ButtonL2
        local ButtonR2_2 = Enum.KeyCode.ButtonR2
        v10:BindActionAtPriority("TreadmillVideoActions", function(a1, a2, a3) -- Line: 1221
            -- upvalues: swapLeft (val), swapRight (val), u50 (val), CommentsController (upval)
            if a2 == Enum.UserInputState.Begin then
                local KeyCode = a3.KeyCode
                if KeyCode == Enum.KeyCode.ButtonL1 then
                    swapLeft()
                elseif KeyCode == Enum.KeyCode.ButtonR1 then
                    swapRight()
                elseif KeyCode == Enum.KeyCode.ButtonL2 then
                    u50:Toggle()
                elseif KeyCode == Enum.KeyCode.ButtonR2 then
                    CommentsController.Toggle()
                end
            end
            return Enum.ContextActionResult.Sink
        end, false, v11, ButtonL1, ButtonR1, ButtonL2_2, ButtonR2_2)
        v4:Add(function() -- Line: 1248 -- upvalues: ContextActionService (upval)
            ContextActionService:UnbindAction("TreadmillVideoActions")
        end)
        ButtonHintStrip.PinLeft(0.2)
        ButtonHintStrip.Present("TreadmillLike", ButtonL2, "Like")
        if CommentsController.IsAvailable() then
            ButtonHintStrip.Present("TreadmillComments", ButtonR2, "Comments")
        end
        v4:Add(function() -- Line: 1254 -- upvalues: ButtonHintStrip (upval)
            ButtonHintStrip.Retract("TreadmillLike")
            ButtonHintStrip.Retract("TreadmillComments")
            ButtonHintStrip.PinLeft(nil)
        end)
        v4:Add((ButtonFX(ShareButton, nil, function() -- Line: 1259
            -- upvalues: u59 (val), TryCall (upval), SocialService (upval), LocalPlayer (upval)
            -- upvalues: RecommendationSignals (upval)
            u59.LikeController:SuppressScreenTap()
            local v1, v2 = TryCall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer)
            if v1 and v2 then
                SocialService:PromptGameInvite(LocalPlayer)
                RecommendationSignals.NotifyShared()
                return
            end
        end)))
        local u234 = TouchTapTracker.new()

        local function handleVideoScreenTap(a1) -- Line: 1270
            -- upvalues: getVideoScreenTapScale (upval), u59 (val)
            local v1 = getVideoScreenTapScale(u59, Vector2.new(a1.Position.X, a1.Position.Y))
            if v1 == nil then
                return
            end
            u59.FriendLikesController:HandleScreenTap()
            u59.LikeController:HandleScreenTap(v1)
        end

        v4:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 1282
            -- upvalues: u234 (val), UserInputService (upval), getVideoScreenTapScale (upval), u59 (val)
            if a2 then
                return
            end
            if a1.UserInputType == Enum.UserInputType.Touch then
                u234:Begin(a1)
                return
            end
            if a1.UserInputType == Enum.UserInputType.MouseButton1 and not UserInputService.TouchEnabled then
                local v1 = getVideoScreenTapScale(u59, Vector2.new(a1.Position.X, a1.Position.Y))
                if v1 == nil then
                    return
                end
                u59.FriendLikesController:HandleScreenTap()
                u59.LikeController:HandleScreenTap(v1)
            end
        end)
        v4:Connect(UserInputService.InputChanged, function(a1) -- Line: 1299 -- upvalues: u234 (val) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.Touch and u234:IsTrackingInput(a1) then
                u234:Update(a1)
            end
        end)
        v4:Connect(UserInputService.InputEnded, function(a1, a2) -- Line: 1308
            -- upvalues: u234 (val), getVideoScreenTapScale (upval), u59 (val)
            if a1.UserInputType == Enum.UserInputType.Touch
                and u234:IsTrackingInput(a1)
                and u234:Evaluate(a1, a2) then
                local v1 = getVideoScreenTapScale(u59, Vector2.new(a1.Position.X, a1.Position.Y))
                if v1 == nil then
                    return
                end
                u59.FriendLikesController:HandleScreenTap()
                u59.LikeController:HandleScreenTap(v1)
            end
        end)
        v4:Add(function() -- Line: 1318 -- upvalues: u234 (val)
            u234:Reset()
        end)
        v4:BindToRenderStep("TreadmillVideoProgress", Enum.RenderPriority.Last.Value, function() -- Line: 1322 -- upvalues: u519 (upval), u59 (val), updateMediaProgress (upval)
            if u519 == u59.Token then
                updateMediaProgress(u59)
            end
        end)
        v4:Add(function() -- Line: 1328
            -- upvalues: unloadVideo (upval), u59 (val), StopPlay (upval), u232 (upval), u241 (upval), u250 (upval)
            -- upvalues: u259 (upval), u268 (upval)
            unloadVideo(u59)
            u59.LikeController:Destroy()
            u59.FriendLikesController:Destroy()
            StopPlay.Visible = true
            u232.Enabled = false
            u241.Enabled = false
            u250.Enabled = false
            u259.Enabled = false
            u268.Enabled = false
        end)
        if v8 == nil then
            local v12
            v10, v12 = FeedSequencer.Current(u59.Feed)
            v5 = u528[v10]
            local v13 = false
            if v5 ~= nil then
                v13 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v5))
            end
            if v13 then
                local v14
                Remotes.Treadmill.RefreshClipCursor:FireServer(v12)
                v13, v14 = sequencerNextSkippingExcluded(u59)
                v10 = v13
                v12 = v14
            end
            loadVideo(u59, v10, v12, 1)
        else
            loadVideo(u59, v8.MediaIndex, nil, 1, v8)
        end
        v8 = if not u59.RecommendationActive then "sequencer" else "recommendation"
        ;(u229:AtTrace()):Log((("[TreadmillVideoController] Started treadmill video for %* (%* feed)"):format(a2, v8)))
        return
    end
    ;(u229:AtTrace()):Log((("[TreadmillVideoController] Skipped video presentation for %*"):format(a2)))
end

local function findActiveTreadmill(a1) -- Line: 1356 -- upvalues: CollectionService (val) -- types: a1: string
    for i, j in CollectionService:GetTagged("ActiveTreadmill") do
        if j:GetAttribute("ActiveTreadmillId") == a1 then
            return j
        end
    end
    return nil
end

local function bindVideoRuntimeWhenReady(a1, a2, a3) -- Line: 1365
    -- upvalues: Trove (val), u520 (ref), u519 (ref), bindVideoRuntime (val), CollectionService (val)
    -- upvalues: findActiveTreadmill (val)
    local u5 = Trove.new()
    u520 = u5
    local u6 = false

    local function bindIfCurrent(a1_2) -- Line: 1374
        -- upvalues: u6 (ref), a3 (val), u519 (upval), u520 (upval), u5 (val), a1 (val), bindVideoRuntime (upval)
        -- upvalues: a2 (val)
        if not u6 and a1_2 ~= nil and a3 == u519 and u520 == u5 then
            assert(a1_2:IsA("Tool"), (("Runtime treadmill \"%*\" must be a Tool"):format(a1)))
            u6 = true
            u520 = nil
            u5:Destroy()
            bindVideoRuntime(a1_2, a1, a2, a3)
            return
        end
    end

    u5:Add(((CollectionService:GetInstanceAddedSignal("ActiveTreadmill")):Connect(function(a1_2) -- Line: 1393 -- upvalues: a1 (val), bindIfCurrent (val) -- types: a1_2: userdata
        if (a1_2:GetAttribute("ActiveTreadmillId")) == a1 then
            bindIfCurrent(a1_2)
        end
    end)))
    bindIfCurrent((findActiveTreadmill(a1)))
end

function u567.Start(a1, a2) -- Line: 1407
    -- upvalues: cleanupRuntime (val), u519 (ref), bindVideoRuntimeWhenReady (val)
    cleanupRuntime()
    u519 = u519 + 1
    bindVideoRuntimeWhenReady(a1, a2, u519)
end

function u567.GetStoppedIconImage() -- Line: 1415
    return "rbxassetid://84371411600743"
end

function u567.ResolveCoverImage(a1) -- Line: 1417
    if a1.Kind == "Video" then
        return a1.CoverImage or ""
    end
    return a1.Image
end

function u567.GetCurrentMediaEntry(a1) -- Line: 1425 -- upvalues: FeedSequencer (val), LocalPlayer (val), u528 (val)
    return u528[(FeedSequencer.Current((FeedSequencer.CreateRuntime(
        u528,
        FeedSequencer.ResolveReleaseTrackingState(a1, LocalPlayer.UserId, a1.HasSwappedRight == true),
        LocalPlayer.UserId
    ))))]
end

local u842 = nil

function u567.GetMediaEntryByKey(a1) -- Line: 1441
    -- upvalues: u842 (ref), u528 (val), TreadmillMediaIdentity (val)
    local v1 = u842
    if v1 == nil then
        local v2
        v1 = {}
        for i, v in ipairs(u528) do
            v2 = TreadmillMediaIdentity.GetMediaKey(v)
            if v1[v2] == nil then
                v1[v2] = v
            end
        end
        u842 = v1
    end
    return v1[a1]
end

function u567.GetActiveMediaEntry() -- Line: 1456 -- upvalues: u521 (ref), u528 (val)
    local v1 = u521
    if v1 == nil then
        return nil
    end
    return u528[v1.VideoIndex]
end

function u567.Stop() -- Line: 1464 -- upvalues: cleanupRuntime (val)
    cleanupRuntime()
end

function u567.SuppressScreenTap() -- Line: 1466 -- upvalues: u521 (ref)
    local v1 = u521
    if v1 ~= nil then
        v1.LikeController:SuppressScreenTap()
    end
end

function u567.SetShareButtonVisible(a1) -- Line: 1473 -- upvalues: ShareButton (val) -- types: a1: boolean
    ShareButton.Visible = a1
end

TreadmillMediaOverlay.Changed:Connect(function() -- Line: 1477 -- upvalues: TreadmillMediaOverlay (val), u528 (val), u842 (ref), updateVideoCounter (val)
    TreadmillMediaOverlay.ApplyTo(u528)
    u842 = nil
    updateVideoCounter()
end)
updateVideoCounter()

function Remotes.Treadmill.GaugeClipLength.OnClientInvoke(a1) -- Line: 1486
    -- upvalues: LocalPlayer (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TreadmillDurationProbe"
    ScreenGui.ResetOnSpawn = false
    local VideoFrame = Instance.new("VideoFrame")
    VideoFrame.Size = UDim2.fromOffset(1, 1)
    VideoFrame.BackgroundTransparency = 1
    VideoFrame.Volume = 0
    VideoFrame.Video = ("rbxassetid://%*"):format(a1)
    VideoFrame.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v1 = os.clock() + 20
    while os.clock() < v1 do
        if VideoFrame.IsLoaded and 0 < VideoFrame.TimeLength then
            break
        end
        task.wait(0.25)
    end
    local TimeLength = VideoFrame.TimeLength
    ScreenGui:Destroy()
    if TimeLength <= 0 then
        return nil
    end
    return TimeLength
end

CommentsController.Start({
    MediaChanged = u567.MediaChanged,
    SetShareButtonVisible = u567.SetShareButtonVisible,
    Stopped = u567.Stopped,
    SuppressScreenTap = u567.SuppressScreenTap,
})
return u567