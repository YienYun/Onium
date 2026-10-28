-- Script path: ReplicatedStorage.Client.GuardTutorialPresentation
-- Decompile time: 17.92 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local TutorialHighlightOverlay = require(script.TutorialHighlightOverlay)
local TutorialTapIndicator = require(script.TutorialTapIndicator)
local t = require(ReplicatedStorage.Packages.t)
local u94 = table.freeze({
    CROSSFADE_OUT = TweenInfo.new(0.02),
    CROSSFADE_IN = TweenInfo.new(0.02),
    STROKE_CROSSFADE_OUT = TweenInfo.new(0.02, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
    STROKE_CROSSFADE_IN = TweenInfo.new(0.02, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
    FILL = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    READY_SCALE = TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true),
    READY_FLASH = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true),
    CLICK_PULSE = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true),
})

local function wantsAnchorValue(a1) -- Line: 75
    local v1 = true
    if typeof(a1) ~= "Vector3" then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
end

local u98 = t.strict(t.string)
local u101 = t.strict(t.Color3)
local u104 = t.strict(t.boolean)
local u107 = t.strict(t.number)
local u112 = t.strict(t.optional(t.number))
local u117 = t.strict(t.instanceIsA("GuiButton"))
local u122 = t.strict(t.instanceIsA("GuiObject"))
local u127 = t.strict(t.instanceIsA("BasePart"))
local u130 = t.strict(t.CFrame)
local u135 = t.strict(t.optional(t.boolean))
local u140 = t.strict(t.optional(t.UDim))
local u145 = t.strict(t.optional(t.UDim2))
local u148 = Log.new()
local u149 = {}
u149.__index = u149
u149.__class = "GuardTutorialPresentation"

local function expect(a1, a2, a3) -- Line: 102 -- types: a1: userdata, a2: string, a3: string
    assert(a1:IsA(a2), (("%* is not a %*"):format(a3, a2)))
    return a1
end

local function messageParts(a1) -- Line: 110 -- upvalues: GUI (val), MessageTyper (val)
    local message = a1.message
    if message then
        return message
    end
    local v1 = GUI.TutorialInstructions()
    assert(v1:IsA("ScreenGui"), "TutorialInstructions is not a ScreenGui")
    local Frame = v1.Frame
    assert(Frame:IsA("Frame"), "TutorialInstructions.Frame is not a Frame")
    local TextLabel = Frame.TextLabel
    assert(TextLabel:IsA("TextLabel"), "TutorialInstructions.Frame.TextLabel is not a TextLabel")
    local UIStroke = TextLabel.UIStroke
    assert(UIStroke:IsA("UIStroke"), "the tutorial label stroke is not a UIStroke")
    local UIGradient = TextLabel.UIGradient
    assert(UIGradient:IsA("UIGradient"), "the tutorial label gradient is not a UIGradient")
    local v2 = {
        animator = MessageTyper.new(TextLabel),
        frame = Frame,
        gradient = UIGradient,
        label = TextLabel,
        screen = v1,
        stroke = UIStroke,
    }
    a1.message = v2
    if a1.messageDefaults == nil then
        a1.messageDefaults = {
            framePosition = Frame.Position,
            strokeAlpha = TextLabel.TextStrokeTransparency,
            textAlpha = TextLabel.TextTransparency,
        }
    end
    return v2
end

local function progressParts(a1) -- Line: 144 -- upvalues: messageParts (val)
    local progress = a1.progress
    if progress then
        return progress
    end
    local Progression = messageParts(a1).frame.Progression
    assert(Progression:IsA("GuiObject"), "the progression frame is not a GuiObject")
    local Fill = Progression.Fill
    assert(Fill:IsA("GuiObject"), "the progression fill is not a GuiObject")
    local ReadyLabel = Progression.ReadyLabel
    assert(ReadyLabel:IsA("GuiObject"), "the ready label is not a GuiObject")
    local ReadyLabelWhite = ReadyLabel.ReadyLabelWhite
    assert(ReadyLabelWhite:IsA("TextLabel"), "the ready flash is not a TextLabel")
    local UIScale = ReadyLabel:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = ReadyLabel
        a1.ownsReadyScale = true
        UIScale = UIScale_2
    end
    local v1 = {
        fill = Fill,
        frame = Progression,
        ready = ReadyLabel,
        readyScale = UIScale,
        white = ReadyLabelWhite,
    }
    a1.progress = v1
    return v1
end

local function resetMessageInk(a1) -- Line: 175
    local message = a1.message
    local messageDefaults = a1.messageDefaults
    if message == nil then
        return
    end
    message.label.TextTransparency = if not messageDefaults then 0 else messageDefaults.textAlpha
    message.stroke.Transparency = 0
    message.label.TextStrokeTransparency = if not messageDefaults then 1 else messageDefaults.strokeAlpha
end

local function stopTween(a1) -- Line: 187 -- types: a1: userdata?
    if a1 then
        a1:Cancel()
    end
    return nil
end

local function beginClickPulse(a1) -- Line: 196 -- upvalues: TweenService (val), u94 (val) -- types: a1: userdata
    a1.Scale = 1
    local v1 = TweenService:Create(a1, u94.CLICK_PULSE, {Scale = 1.3})
    v1:Play()
    return v1
end

local function stopProgressPulse(a1) -- Line: 204
    local readyScaleTween = a1.readyScaleTween
    if readyScaleTween then
        readyScaleTween:Cancel()
    end
    a1.readyScaleTween = nil
    local readyWhiteTween = a1.readyWhiteTween
    if readyWhiteTween then
        readyWhiteTween:Cancel()
    end
    a1.readyWhiteTween = nil
end

local function setReadyPulse(a1, a2, a3) -- Line: 211
    -- upvalues: TweenService (val), u94 (val)
    if not a3 then
        local readyScaleTween = a1.readyScaleTween
        if readyScaleTween then
            readyScaleTween:Cancel()
        end
        a1.readyScaleTween = nil
        local readyWhiteTween = a1.readyWhiteTween
        if readyWhiteTween then
            readyWhiteTween:Cancel()
        end
        a1.readyWhiteTween = nil
        a2.ready.Visible = false
        a2.readyScale.Scale = 1
        a2.white.TextTransparency = 1
        return
    end
    if a1.readyScaleTween ~= nil and a1.readyWhiteTween ~= nil then
        return
    end
    a2.ready.Visible = true
    a2.readyScale.Scale = 1
    a2.white.TextTransparency = 1
    local v1 = TweenService:Create(a2.readyScale, u94.READY_SCALE, {Scale = 1.2})
    local v2 = TweenService:Create(a2.white, u94.READY_FLASH, {TextTransparency = 0})
    a1.readyScaleTween = v1
    a1.readyWhiteTween = v2
    v1:Play()
    v2:Play()
end

function u149.new() -- Line: 241 -- upvalues: u149 (val)
    return (setmetatable({ownsReadyScale = false, transition = 0}, u149))
end

function u149.AnnounceTyped(a1, a2, a3) -- Line: 262
    -- upvalues: u98 (val), u101 (val), messageParts (val)
    u98(a2)
    u101(a3)
    local v1 = messageParts(a1)
    a1.transition = a1.transition + 1
    local message = a1.message
    local messageDefaults = a1.messageDefaults
    if message ~= nil then
        message.label.TextTransparency = if not messageDefaults then 0 else messageDefaults.textAlpha
        message.stroke.Transparency = 0
        message.label.TextStrokeTransparency = if not messageDefaults then 1 else messageDefaults.strokeAlpha
    end
    v1.screen.Enabled = true
    v1.animator:Type(a2, a3)
end

function u149.AnnounceNow(a1, a2, a3) -- Line: 277
    -- upvalues: u98 (val), u101 (val), messageParts (val)
    u98(a2)
    u101(a3)
    local v1 = messageParts(a1)
    a1.transition = a1.transition + 1
    local message = a1.message
    local messageDefaults = a1.messageDefaults
    if message ~= nil then
        message.label.TextTransparency = if not messageDefaults then 0 else messageDefaults.textAlpha
        message.stroke.Transparency = 0
        message.label.TextStrokeTransparency = if not messageDefaults then 1 else messageDefaults.strokeAlpha
    end
    v1.screen.Enabled = true
    v1.animator:ShowAll(a2, a3)
end

function u149.CrossfadeTo(a1, a2, a3) -- Line: 292
    -- upvalues: u98 (val), u101 (val), messageParts (val), TweenService (val), u94 (val)
    u98(a2)
    u101(a3)
    local u11 = messageParts(a1)
    a1.transition = a1.transition + 1
    local transition = a1.transition
    u11.screen.Enabled = true
    u11.animator:Halt()

    local function fadeIn() -- Line: 306
        -- upvalues: transition (val), a1 (val), u11 (val), a2 (val), a3 (val), TweenService (upval), u94 (upval)
        if transition ~= a1.transition then
            return
        end
        local messageDefaults = a1.messageDefaults
        u11.label.RichText = true
        u11.label.Text = a2
        u11.label.TextColor3 = a3
        u11.label.MaxVisibleGraphemes = -1
        u11.label.TextTransparency = 1
        u11.label.TextStrokeTransparency = 1
        u11.stroke.Transparency = 1
        TweenService:Create(u11.stroke, u94.STROKE_CROSSFADE_IN, {Transparency = 0}):Play()
        local v1 = TweenService
        local label = u11.label
        local CROSSFADE_IN = u94.CROSSFADE_IN
        v1:Create(label, CROSSFADE_IN, {
            TextTransparency = if not messageDefaults then 0 else messageDefaults.textAlpha,
            TextStrokeTransparency = if not messageDefaults then 1 else messageDefaults.strokeAlpha,
        }):Play()
    end

    if u11.label.Text == "" then
        fadeIn()
        return
    end
    local v1 = TweenService:Create(u11.label, u94.CROSSFADE_OUT, {TextTransparency = 1, TextStrokeTransparency = 1})
    TweenService:Create(u11.stroke, u94.STROKE_CROSSFADE_OUT, {Transparency = 1}):Play()
    v1.Completed:Connect(fadeIn)
    v1:Play()
end

function u149.SetAnnounceGradient(a1, a2) -- Line: 342 -- upvalues: u104 (val), messageParts (val) -- types: a2: boolean
    u104(a2)
    messageParts(a1).gradient.Enabled = a2
end

function u149.SetAnnounceHeight(a1, a2) -- Line: 351 -- upvalues: u112 (val), messageParts (val) -- types: a2: number?
    u112(a2)
    local v1 = messageParts(a1)
    local messageDefaults = a1.messageDefaults
    local framePosition = if not messageDefaults then v1.frame.Position else messageDefaults.framePosition
    v1.frame.Position = if a2 ~= nil then UDim2.new(framePosition.X.Scale, framePosition.X.Offset, a2, framePosition.Y.Offset) else framePosition
end

function u149:DropAnnounce() -- Line: 365
    self.transition = self.transition + 1
    local message = self.message
    if message == nil then
        return
    end
    message.animator:Blank()
    message.label.Text = ""
    local message_2 = self.message
    local messageDefaults = self.messageDefaults
    if message_2 ~= nil then
        message_2.label.TextTransparency = if not messageDefaults then 0 else messageDefaults.textAlpha
        message_2.stroke.Transparency = 0
        message_2.label.TextStrokeTransparency = if not messageDefaults then 1 else messageDefaults.strokeAlpha
    end
    local messageDefaults_2 = self.messageDefaults
    if messageDefaults_2 then
        message.frame.Position = messageDefaults_2.framePosition
    end
    message.gradient.Enabled = false
    message.screen.Enabled = false
end

function u149.TrackSpeedGoal(a1, a2, a3) -- Line: 386
    -- upvalues: u107 (val), u104 (val), progressParts (val), TweenService (val), u94 (val), setReadyPulse (val)
    u107(a2)
    u104(a3)
    local v1 = progressParts(a1)
    v1.frame.Visible = true
    local fillTween = a1.fillTween
    if fillTween then
        fillTween:Cancel()
    end
    local Size = v1.fill.Size
    local v2 = TweenService:Create(v1.fill, u94.FILL, {
        Size = UDim2.new(math.clamp(a2, 0, 1), 0, Size.Y.Scale, Size.Y.Offset),
    })
    a1.fillTween = v2
    v2:Play()
    setReadyPulse(a1, v1, a3)
end

function u149:DropSpeedGoal() -- Line: 407
    local fillTween = self.fillTween
    if fillTween then
        fillTween:Cancel()
    end
    self.fillTween = nil
    local readyScaleTween = self.readyScaleTween
    if readyScaleTween then
        readyScaleTween:Cancel()
    end
    self.readyScaleTween = nil
    local readyWhiteTween = self.readyWhiteTween
    if readyWhiteTween then
        readyWhiteTween:Cancel()
    end
    self.readyWhiteTween = nil
    local progress = self.progress
    if progress == nil then
        return
    end
    local Size = progress.fill.Size
    progress.fill.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
    progress.ready.Visible = false
    progress.readyScale.Scale = 1
    progress.white.TextTransparency = 1
    progress.frame.Visible = false
end

function u149.PointBeamAt(a1, a2) -- Line: 426 -- upvalues: TutorialBeam (val)
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    local beam = a1.beam
    if beam == nil then
        a1.beam = TutorialBeam.Attach(a2)
        return
    end
    TutorialBeam.Retarget(beam, a2)
end

function u149.RetargetBeam(a1, a2) -- Line: 437 -- upvalues: TutorialBeam (val)
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    local beam = a1.beam
    if beam == nil then
        a1.beam = TutorialBeam.Attach(a2)
        return
    end
    TutorialBeam.Retarget(beam, a2)
end

function u149:DropBeam() -- Line: 448 -- upvalues: TutorialBeam (val)
    local beam = self.beam
    if beam ~= nil then
        self.beam = nil
        TutorialBeam.Destroy(beam)
    end
end

function u149.MarkTapTarget(a1, a2, a3, a4, a5) -- Line: 456
    -- upvalues: u117 (val), u135 (val), u140 (val), u145 (val), TutorialTapIndicator (val)
    u117(a2)
    u135(a3)
    u140(a4)
    u145(a5)
    a1:DropTapTarget()
    a1.dropTapLater = TutorialTapIndicator.Attach(a2, a3, a4, a5)
end

function u149.MarkSurfaceTapTarget(a1, a2, a3, a4, a5, a6) -- Line: 474
    -- upvalues: u127 (val), u98 (val), u135 (val), u140 (val), u145 (val), TutorialTapIndicator (val)
    local v1
    u127(a2)
    u98(a3)
    u135(a4)
    u140(a5)
    u145(a6)
    local v2 = nil
    for i, j in a2:GetChildren() do
        if j:IsA("SurfaceGui") then
            v1 = j:FindFirstChild(a3)
            if v1 ~= nil and v1:IsA("GuiButton") then
                v2 = v1
                break
            end
        end
    end
    a1:DropTapTarget()
    if v2 == nil then
        return false
    end
    a1.dropTapLater = TutorialTapIndicator.Attach(v2, a4, a5, a6)
    return true
end

function u149:DropTapTarget() -- Line: 508
    local dropTapLater = self.dropTapLater
    if dropTapLater ~= nil then
        self.dropTapLater = nil
        dropTapLater()
    end
end

function u149.PinWorldClickHint(a1, a2) -- Line: 516
    -- upvalues: u130 (val), ReplicatedStorage (val), TweenService (val), u94 (val)
    u130(a2)
    local clickPart = a1.clickPart
    if clickPart ~= nil then
        clickPart.CFrame = a2
        return
    end
    local BillboardTutorialClick = ReplicatedStorage.Assets.Billboards.BillboardTutorialClick
    assert(BillboardTutorialClick:IsA("BasePart"), "Assets.Billboards.BillboardTutorialClick is not a BasePart")
    local v1 = BillboardTutorialClick:Clone()
    v1.CFrame = a2
    v1.Parent = workspace
    local BillboardGui = v1.BillboardGui
    assert(BillboardGui:IsA("BillboardGui"), "the click-hint billboard is not a BillboardGui")
    local Image = BillboardGui.Image
    assert(Image:IsA("ImageLabel"), "the click-hint image is not a ImageLabel")
    local UIScale = Image.UIScale
    assert(UIScale:IsA("UIScale"), "the click-hint scale is not a UIScale")
    a1.clickPart = v1
    UIScale.Scale = 1
    local v2 = TweenService:Create(UIScale, u94.CLICK_PULSE, {Scale = 1.3})
    v2:Play()
    a1.clickTween = v2
end

function u149:DropWorldClickHint() -- Line: 543
    local clickTween = self.clickTween
    if clickTween then
        clickTween:Cancel()
    end
    self.clickTween = nil
    local clickPart = self.clickPart
    if clickPart ~= nil then
        clickPart:Destroy()
        self.clickPart = nil
    end
end

function u149.SetScreenClickHint(a1, a2) -- Line: 554
    -- upvalues: u104 (val), Players (val), TweenService (val), u94 (val)
    u104(a2)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    assert(PlayerGui:IsA("PlayerGui"), "LocalPlayer.PlayerGui is not a PlayerGui")
    local TutorialClick = PlayerGui:WaitForChild("TutorialClick")
    assert(TutorialClick:IsA("ScreenGui"), "PlayerGui.TutorialClick is not a ScreenGui")
    local Image = TutorialClick.Image
    assert(Image:IsA("ImageLabel"), "TutorialClick.Image is not a ImageLabel")
    local UIScale = Image.UIScale
    assert(UIScale:IsA("UIScale"), "TutorialClick.Image.UIScale is not a UIScale")
    a1.screenClick = TutorialClick
    if not a2 then
        a1:DropScreenClickHint()
        return
    end
    TutorialClick.Enabled = true
    if a1.screenClickTween == nil then
        UIScale.Scale = 1
        local v1 = TweenService:Create(UIScale, u94.CLICK_PULSE, {Scale = 1.3})
        v1:Play()
        a1.screenClickTween = v1
    end
end

function u149:DropScreenClickHint() -- Line: 579
    local screenClickTween = self.screenClickTween
    if screenClickTween then
        screenClickTween:Cancel()
    end
    self.screenClickTween = nil
    local screenClick = self.screenClick
    if screenClick ~= nil then
        screenClick.Enabled = false
    end
end

function u149.RingButton(a1, a2) -- Line: 588
    -- upvalues: u122 (val), TutorialHighlightOverlay (val)
    u122(a2)
    a1:DropRing()
    a1.dropRingLater = TutorialHighlightOverlay.Attach(a2)
end

function u149:DropRing() -- Line: 595
    local dropRingLater = self.dropRingLater
    if dropRingLater ~= nil then
        self.dropRingLater = nil
        dropRingLater()
    end
end

function u149.PointArrowAt(a1, a2, a3, a4) -- Line: 603 -- upvalues: ArrowPointer3D (val)
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    v1 = true
    if typeof(a3) ~= "Vector3" then
        v1 = false
        if typeof(a3) == "Instance" then
            v1 = a3:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    assert((ArrowPointer3D.__types.OptionalConfig(a4)))
    a1:DropArrow()
    v1 = ArrowPointer3D.new(a2, a3, a4)
    v1:Start()
    a1.arrow = v1
end

function u149.RetargetArrow(a1, a2) -- Line: 619
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    assert(a1.arrow, "there is no tutorial arrow to retarget"):PointAt(a2)
end

function u149.RebaseArrow(a1, a2) -- Line: 625
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "a tutorial anchor has to be a BasePart or a Vector3")
    assert(a1.arrow, "there is no tutorial arrow to rebase"):PointFrom(a2)
end

function u149:DropArrow() -- Line: 631
    local arrow = self.arrow
    if arrow ~= nil then
        self.arrow = nil
        arrow:Destroy()
    end
end

function u149:DropEverything() -- Line: 640
    self:DropArrow()
    self:DropBeam()
    self:DropWorldClickHint()
    self:DropRing()
    self:DropTapTarget()
    self:DropScreenClickHint()
    self:DropSpeedGoal()
    self:DropAnnounce()
end

function u149:Destroy() -- Line: 651 -- upvalues: u148 (val)
    u148:AtTrace():Log("Tearing down the guard tutorial presentation layer")
    self:DropEverything()
    local progress = self.progress
    if self.ownsReadyScale and progress ~= nil then
        progress.readyScale:Destroy()
        self.progress = nil
    end
end

return u149