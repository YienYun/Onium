-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.UISystem
-- Decompile time: 53.72 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightVsDarkness = require(ReplicatedStorage.Data.LightVsDarkness)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local u49 = Color3.fromRGB(255, 245, 190)
local u55 = Color3.fromRGB(255, 150, 150)
local u60 = Color3.fromRGB(85, 85, 85)
local u65 = Color3.fromRGB(71, 255, 0)
local u69 = UDim2.fromScale(1.03563285, 1.58552635)
local u73 = UDim2.fromScale(-0.470256448, 1.16447556)
local u77 = UDim2.fromScale(1.13319373, 1.7348907)
local u81 = UDim2.fromScale(-0.519036949, 1.16447568)
local u86 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u91 = TweenInfo.new(0.34, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u96 = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u103 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u107 = Vector2.new(12, 8)
local Back = Enum.EasingStyle.Back
local In = Enum.EasingDirection.In
local u113 = Vector2.new(14, 10)
local LocalPlayer = Players.LocalPlayer
local u115 = nil
local u116 = nil
local u117 = nil
local u118 = false
local u119 = 0
local u120 = 0
local u121 = 0
local u122 = 0
local u123 = 0
local u124 = -1
local u125 = -1
local u126 = 0
local u127 = ""
local u128 = 0.5
local u129 = 0.5
local u130 = 0
local u131 = 0
local u132 = 0
local u133 = 0.5
local u134 = 0
local u135 = 0
local u136 = {p = 0, v = 0}
local u137 = {p = 0, v = 0}
local u138 = {p = 0, v = 0}
local u139 = 0
local u140 = ""
local u141 = false
local u142 = false
local u143 = nil
local u144 = false
local u145 = {}
local u146 = nil
local u147 = nil
local u149 = Random.new()

local function spring() -- Line: 218
    return {p = 0, v = 0}
end

local function stepSpring(a1, a2) -- Line: 222 -- types: a1: table, a2: number
    a1.v = a1.v + (a1.p * -260 - a1.v * 14) * a2
    a1.p = a1.p + a1.v * a2
end

local function uiChild(a1, a2, a3) -- Line: 227 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    local v2 = ("%*.%* must be a %*"):format(a1:GetFullName(), a2, a3)
    assert(v1 and v1:IsA(a3), v2)
    return v1
end

local function resolveUi() -- Line: 233 -- upvalues: u115 (ref), GUI (val), LightVsDarkness (val)
    local ClaimButton, ClaimedOverlay, CompletedCheckmark, Frame, QuantityLabel, RewardIcon, v1, v2, v3, v4, v5
    local v6 = u115
    if v6 then
        return v6
    end
    v6 = GUI.LightVsDarknessUI()
    assert(v6:IsA("ScreenGui"), "LightVsDarknessUI must be a ScreenGui")
    local ScoreBar = v6:FindFirstChild("ScoreBar")
    local v7 = ("%*.ScoreBar must be a Frame"):format((v6:GetFullName()))
    assert(ScoreBar and ScoreBar:IsA("Frame"), v7)
    local BarHolder = ScoreBar:FindFirstChild("BarHolder")
    local v8 = ("%*.BarHolder must be a Frame"):format((ScoreBar:GetFullName()))
    assert(BarHolder and BarHolder:IsA("Frame"), v8)
    local BarBG = BarHolder:FindFirstChild("BarBG")
    local v9 = ("%*.BarBG must be a GuiObject"):format((BarHolder:GetFullName()))
    assert(BarBG and BarBG:IsA("GuiObject"), v9)
    local LightBar = BarBG:FindFirstChild("LightBar")
    local v10 = ("%*.LightBar must be a Frame"):format((BarBG:GetFullName()))
    assert(LightBar and LightBar:IsA("Frame"), v10)
    local DarkBar = BarBG:FindFirstChild("DarkBar")
    local v11 = ("%*.DarkBar must be a Frame"):format((BarBG:GetFullName()))
    assert(DarkBar and DarkBar:IsA("Frame"), v11)
    local v12 = BarHolder:FindFirstChild("VSIcon")
    v11 = ("%*.VSIcon must be a ImageLabel"):format((BarHolder:GetFullName()))
    assert(v12 and v12:IsA("ImageLabel"), v11)
    local VSText = BarHolder:FindFirstChild("VSText")
    local v13 = ("%*.VSText must be a GuiObject"):format((BarHolder:GetFullName()))
    assert(VSText and VSText:IsA("GuiObject"), v13)
    local LightAmount = ScoreBar:FindFirstChild("LightAmount")
    local v14 = ("%*.LightAmount must be a TextLabel"):format((ScoreBar:GetFullName()))
    assert(LightAmount and LightAmount:IsA("TextLabel"), v14)
    local DarknessAmount = ScoreBar:FindFirstChild("DarknessAmount")
    local v15 = ("%*.DarknessAmount must be a TextLabel"):format((ScoreBar:GetFullName()))
    assert(DarknessAmount and DarknessAmount:IsA("TextLabel"), v15)
    v13 = LightBar.Size.X.Scale + DarkBar.Size.X.Scale
    local PersonalRingMilestone = v6:FindFirstChild("PersonalRingMilestone")
    local v16 = ("%*.PersonalRingMilestone must be a Frame"):format((v6:GetFullName()))
    assert(PersonalRingMilestone and PersonalRingMilestone:IsA("Frame"), v16)
    local ProgressBar = PersonalRingMilestone:FindFirstChild("ProgressBar")
    local v17 = ("%*.ProgressBar must be a Frame"):format((PersonalRingMilestone:GetFullName()))
    assert(ProgressBar and ProgressBar:IsA("Frame"), v17)
    local RingScoreHolder = PersonalRingMilestone:FindFirstChild("RingScoreHolder")
    local v18 = ("%*.RingScoreHolder must be a Frame"):format((PersonalRingMilestone:GetFullName()))
    assert(RingScoreHolder and RingScoreHolder:IsA("Frame"), v18)
    local RingScoreHolder_2 = RingScoreHolder:FindFirstChild("RingScoreHolder")
    local v19 = ("%*.RingScoreHolder must be a Frame"):format((RingScoreHolder:GetFullName()))
    assert(RingScoreHolder_2 and RingScoreHolder_2:IsA("Frame"), v19)
    v17 = {}
    v19 = nil
    local v20 = nil
    for i, j in LightVsDarkness.MILESTONES, v19, v20 do
        Frame = j.Frame
        v1 = ProgressBar:FindFirstChild(Frame)
        v2 = ("%*.%* must be a Frame"):format(ProgressBar:GetFullName(), Frame)
        assert(v1 and v1:IsA("Frame"), v2)
        ClaimButton = v1:FindFirstChild("ClaimButton")
        v2 = ("%*.ClaimButton must be a ImageButton"):format((v1:GetFullName()))
        assert(ClaimButton and ClaimButton:IsA("ImageButton"), v2)
        ClaimedOverlay = ClaimButton:FindFirstChild("ClaimedOverlay")
        v3 = ("%*.ClaimedOverlay must be a ImageLabel"):format((ClaimButton:GetFullName()))
        assert(ClaimedOverlay and ClaimedOverlay:IsA("ImageLabel"), v3)
        CompletedCheckmark = ClaimedOverlay:FindFirstChild("CompletedCheckmark")
        v4 = ("%*.CompletedCheckmark must be a ImageLabel"):format((ClaimedOverlay:GetFullName()))
        assert(CompletedCheckmark and CompletedCheckmark:IsA("ImageLabel"), v4)
        RewardIcon = ClaimButton:FindFirstChild("RewardIcon")
        v5 = ("%*.RewardIcon must be a ImageLabel"):format((ClaimButton:GetFullName()))
        assert(RewardIcon and RewardIcon:IsA("ImageLabel"), v5)
        QuantityLabel = RewardIcon:FindFirstChild("QuantityLabel")
        v4 = {
            FillPoint = 0,
            Index = i,
            Rings = j.Rings,
            Frame = v1,
            BaseSize = v1.Size,
            Button = ClaimButton,
            RewardIcon = RewardIcon,
            AuthoredIcon = RewardIcon.Image,
            Overlay = ClaimedOverlay,
            Checkmark = CompletedCheckmark,
            CheckSize = CompletedCheckmark.Size,
            Quantity = QuantityLabel,
            QuantityText = if not QuantityLabel then "" else QuantityLabel.Text,
            UnlockedDecor = v1:FindFirstChild("UnlockedDecor"),
            LockedDecor = v1:FindFirstChild("NotUnlockedDecor"),
            Tweens = {},
        }
        v17[i] = v4
    end
    v18 = {Gui = v6, ScoreBar = ScoreBar, MilestonePanel = PersonalRingMilestone}
    local TeamSelection = v6:FindFirstChild("TeamSelection")
    local v21 = ("%*.TeamSelection must be a Frame"):format((v6:GetFullName()))
    assert(TeamSelection and TeamSelection:IsA("Frame"), v21)
    v18.TeamPanel = TeamSelection
    v18.Holder = BarHolder
    v18.LightBar = LightBar
    v18.DarkBar = DarkBar
    v18.VsIcon = v12
    v18.VsText = VSText
    local AngelWing = ScoreBar:FindFirstChild("AngelWing")
    v21 = ("%*.AngelWing must be a ImageLabel"):format((ScoreBar:GetFullName()))
    assert(AngelWing and AngelWing:IsA("ImageLabel"), v21)
    v18.AngelWing = AngelWing
    local DemonWing = ScoreBar:FindFirstChild("DemonWing")
    v21 = ("%*.DemonWing must be a ImageLabel"):format((ScoreBar:GetFullName()))
    assert(DemonWing and DemonWing:IsA("ImageLabel"), v21)
    v18.DemonWing = DemonWing
    v18.LightLabel = LightAmount
    v18.DarkLabel = DarknessAmount
    local BossName = ScoreBar:FindFirstChild("BossName")
    v21 = ("%*.BossName must be a TextLabel"):format((ScoreBar:GetFullName()))
    assert(BossName and BossName:IsA("TextLabel"), v21)
    v18.Timer = BossName
    v18.BarSpan = v13
    v18.SeamPad = (1 - v13) * 0.5
    v18.HolderPos = BarHolder.Position
    v18.IconPos = v12.Position
    v18.IconSize = v12.Size
    v18.TextPos = VSText.Position
    v18.TextSize = VSText.Size
    v18.LightLabelSize = LightAmount.Size
    v18.DarkLabelSize = DarknessAmount.Size
    v18.LightLabelColor = LightAmount.TextColor3
    v18.DarkLabelColor = DarknessAmount.TextColor3
    local LightYourTeam = ScoreBar:FindFirstChild("LightYourTeam")
    v21 = ("%*.LightYourTeam must be a TextLabel"):format((ScoreBar:GetFullName()))
    assert(LightYourTeam and LightYourTeam:IsA("TextLabel"), v21)
    v18.LightYourTeam = LightYourTeam
    local DarknessYourTeam = ScoreBar:FindFirstChild("DarknessYourTeam")
    v21 = ("%*.DarknessYourTeam must be a TextLabel"):format((ScoreBar:GetFullName()))
    assert(DarknessYourTeam and DarknessYourTeam:IsA("TextLabel"), v21)
    v18.DarknessYourTeam = DarknessYourTeam
    v18.MilestoneBar = ProgressBar
    local ProgressBar_2 = ProgressBar:FindFirstChild("ProgressBar")
    v21 = ("%*.ProgressBar must be a Frame"):format((ProgressBar:GetFullName()))
    assert(ProgressBar_2 and ProgressBar_2:IsA("Frame"), v21)
    v18.MilestoneFill = ProgressBar_2
    v18.ScoreHolder = RingScoreHolder
    v18.ScoreHolderSize = RingScoreHolder.Size
    v18.ScoreRow = RingScoreHolder_2
    local RingScoreLabel = RingScoreHolder_2:FindFirstChild("RingScoreLabel")
    v21 = ("%*.RingScoreLabel must be a TextLabel"):format((RingScoreHolder_2:GetFullName()))
    assert(RingScoreLabel and RingScoreLabel:IsA("TextLabel"), v21)
    v18.RingScore = RingScoreLabel
    v18.Milestones = v17
    u115 = v18
    return v18
end

local function takeOverSprite(a1) -- Line: 326 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Cells")
    local Attribute_2 = a1:GetAttribute("FPS")
    local v1 = if typeof(Attribute) ~= "Vector2" then Vector2.new(8, 4) else Attribute
    local v2 = if type(Attribute_2) ~= "number" then 24 else Attribute_2
    a1:SetAttribute("UIEffectsPaused", true)
    return {
        frame = 0,
        accum = 0,
        image = a1,
        columns = v1.X,
        frames = v1.X * v1.Y,
        baseFps = v2,
        fps = v2,
        baseSize = a1.Size,
        punch = {p = 0, v = 0},
    }
end

local function releaseSprite(a1) -- Line: 345 -- types: a1: table
    a1.image.Size = a1.baseSize
    a1.image.Rotation = 0
    a1.image:SetAttribute("UIEffectsPaused", nil)
end

local function advanceSprite(a1, a2) -- Line: 351 -- types: a1: table, a2: number
    a1.accum = a1.accum + a2
    local v1 = 1 / a1.fps
    local v2 = false
    while v1 <= a1.accum do
        a1.accum = a1.accum - v1
        a1.frame = (a1.frame + 1) % a1.frames
        v2 = true
    end
    if v2 then
        local ImageRectSize = a1.image.ImageRectSize
        a1.image.ImageRectOffset = Vector2.new(ImageRectSize.X * (a1.frame % a1.columns), ImageRectSize.Y * math.floor(a1.frame / a1.columns))
    end
    local punch = a1.punch
    punch.v = punch.v + (punch.p * -260 - punch.v * 14) * a2
    punch.p = punch.p + punch.v * a2
    v2 = a1.punch.p + 1
    local baseSize = a1.baseSize
    a1.image.Size = UDim2.new(baseSize.X.Scale * v2, baseSize.X.Offset, baseSize.Y.Scale * v2, baseSize.Y.Offset)
    a1.image.Rotation = a1.punch.p * 40
end

local function comma(a1) -- Line: 374 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.floor(a1 + 0.5)))
    repeat
        v1, v2 = v3:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

local function formatTimer(a1) -- Line: 386 -- types: a1: number
    local v1 = math.max(math.ceil(a1), 0)
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function intensity() -- Line: 391 -- upvalues: Workspace (val)
    if Workspace:GetAttribute("LvdFinalClash") == true then
        return 2
    end
    return 1
end

local function ratioOf(a1, a2) -- Line: 395 -- types: a1: number, a2: number
    local v1 = a1 + a2
    if v1 <= 0 then
        return 0.5
    end
    return (math.clamp(a1 / v1, 0.12, 0.88))
end

local function applyRatio(a1, a2) -- Line: 403 -- types: a1: table, a2: number
    a1.LightBar.Size = UDim2.new(a1.BarSpan * a2, 0, 1, 0)
    a1.DarkBar.Size = UDim2.new(a1.BarSpan * (1 - a2), 0, 1, 0)
end

local function clash(a1, a2) -- Line: 408
    -- upvalues: Workspace (val), u134 (ref), u136 (ref), u135 (ref), u116 (ref), u117 (ref)
    local v1
    math.min((if Workspace:GetAttribute("LvdFinalClash") ~= true then 1 else 2) * 7, u134 + a1 * 7 * v1)
    local v2 = u136
    v2.v = v2.v + a1 * 9 * v1
    u135 = u135 + (if not a2 then -1 else 1) * 26 * a1 * v1
    v2 = u116
    local v3 = u117
    if a2 and v2 then
        local punch = v2.punch
        punch.v = punch.v + a1 * 7 * v1
        return
    end
    if v3 then
        local punch_2 = v3.punch
        punch_2.v = punch_2.v + a1 * 7 * v1
    end
end

local function applyScore(a1, a2, a3) -- Line: 424
    -- upvalues: u128 (ref), u120 (ref), u121 (ref), u122 (ref), u123 (ref), u129 (ref), u130 (ref), u132 (ref)
    -- upvalues: u115 (ref), u133 (ref), clash (val)
    local v1
    local v2 = u128
    u120 = a1
    u121 = a2
    local v3 = a1 + a2
    u128 = if not (v3 <= 0) then math.clamp(a1 / v3, 0.12, 0.88) else 0.5
    if not a3 then
        v1 = u128 - v2
        if v1 == 0 then
            return
        end
        v2 = math.clamp(math.abs(v1) / 0.05, 0.15, 1)
        u132 = (if not (v1 > 0) then -1 else 1) * 0.22 * v2
        clash(v2, v3)
        return
    end
    u122 = a1
    u123 = a2
    u129 = u128
    u130 = 0
    u132 = 0
    v1 = u115
    if v1 then
        u133 = v1.BarSpan * u129 + v1.SeamPad
        v3 = u129
        v1.LightBar.Size = UDim2.new(v1.BarSpan * v3, 0, 1, 0)
        v1.DarkBar.Size = UDim2.new(v1.BarSpan * (1 - v3), 0, 1, 0)
    end
end

local function stepLabels(a1, a2) -- Line: 452
    -- upvalues: u122 (ref), u120 (ref), u123 (ref), u121 (ref), u137 (ref), u138 (ref), u126 (ref), u124 (ref)
    -- upvalues: u125 (ref), comma (val), u49 (val), u55 (val)
    local v1
    local v2 = 1 - math.exp(a2 * -6)
    u122 = u122 + (u120 - u122) * v2
    u123 = u123 + (u121 - u123) * v2
    local v3 = u137
    v3.v = v3.v + (v3.p * -260 - v3.v * 14) * a2
    v3.p = v3.p + v3.v * a2
    v3 = u138
    v3.v = v3.v + (v3.p * -260 - v3.v * 14) * a2
    v3.p = v3.p + v3.v * a2
    u126 = u126 + a2
    if u126 >= 0.08333333333333333 then
        local v4
        u126 = 0
        v2 = math.floor(u122 + 0.5)
        v3 = math.floor(u123 + 0.5)
        v1 = math.max(v2 + v3, 1)
        if u124 >= 0 and u124 < v2 then
            v4 = u137
            v4.v = v4.v + math.min((v2 - u124) / v1 * 60, 1) * 5
        end
        if u125 >= 0 and u125 < v3 then
            v4 = u138
            v4.v = v4.v + math.min((v3 - u125) / v1 * 60, 1) * 5
        end
        u124 = v2
        u125 = v3
        v1 = comma(v2)
        v2 = comma(v3)
        if a1.LightLabel.Text ~= v1 then
            a1.LightLabel.Text = v1
        end
        if a1.DarkLabel.Text ~= v2 then
            a1.DarkLabel.Text = v2
        end
    end
    v3 = u137.p * 0.5 + 1
    local LightLabelSize = a1.LightLabelSize
    a1.LightLabel.Size = UDim2.new(LightLabelSize.X.Scale * v3, LightLabelSize.X.Offset, LightLabelSize.Y.Scale * v3, LightLabelSize.Y.Offset)
    a1.LightLabel.TextColor3 = a1.LightLabelColor:Lerp(u49, (math.clamp(u137.p * 4, 0, 1)))
    v1 = u138.p * 0.5 + 1
    local DarkLabelSize = a1.DarkLabelSize
    a1.DarkLabel.Size = UDim2.new(DarkLabelSize.X.Scale * v1, DarkLabelSize.X.Offset, DarkLabelSize.Y.Scale * v1, DarkLabelSize.Y.Offset)
    a1.DarkLabel.TextColor3 = a1.DarkLabelColor:Lerp(u55, (math.clamp(u138.p * 4, 0, 1)))
end

local function cancelTweens(a1) -- Line: 500 -- types: a1: table
    for i, j in a1.Tweens do
        j:Cancel()
        a1.Tweens[i] = nil
    end
end

local function play(a1, a2, a3, a4, a5) -- Line: 508
    -- upvalues: TweenService (val)
    local v1 = a1.Tweens[a2]
    if v1 then
        v1:Cancel()
    end
    v1 = TweenService:Create(a3, a4, a5)
    a1.Tweens[a2] = v1
    v1:Play()
end

local function punch(a1) -- Line: 518 -- upvalues: u107 (val), u91 (val), TweenService (val) -- types: a1: table
    local BaseSize = a1.BaseSize
    a1.Frame.Size = UDim2.new(BaseSize.X.Scale, BaseSize.X.Offset + u107.X, BaseSize.Y.Scale, BaseSize.Y.Offset + u107.Y)
    local Frame_2 = a1.Frame
    local punch = a1.Tweens.punch
    if punch then
        punch:Cancel()
    end
    local v1 = TweenService:Create(Frame_2, u91, {Size = BaseSize})
    a1.Tweens.punch = v1
    v1:Play()
end

local function setMilestoneState(a1, a2, a3) -- Line: 527
    -- upvalues: u86 (val), u65 (val), u60 (val), TweenService (val), u73 (val), u81 (val), u69 (val), u77 (val)
    -- upvalues: punch (val), u103 (val), u96 (val)
    local v1
    if a1.State == a2 then
        return
    end
    a1.State = a2
    local v2 = nil
    for i, j in a1.Tweens, nil, v2 do
        j:Cancel()
        a1.Tweens[i] = nil
    end
    local v3 = a2 ~= "Locked"
    if a1.UnlockedDecor then
        a1.UnlockedDecor.Visible = v3
    end
    if a1.LockedDecor then
        a1.LockedDecor.Visible = not v3
    end
    a1.Frame.Size = a1.BaseSize
    if not a3 then
        v2 = if not v3 then u60 else u65
        a1.Frame.BackgroundColor3 = v2
    else
        local Frame = a1.Frame
        local bg = a1.Tweens.bg
        if bg then
            bg:Cancel()
        end
        v1 = TweenService:Create(Frame, u86, {BackgroundColor3 = if not v3 then u60 else u65})
        a1.Tweens.bg = v1
        v1:Play()
    end
    local Button = a1.Button
    Button.Image = if not v3 then "rbxassetid://111037630886814" else "rbxassetid://73951419137281"
    Button.Position = if not v3 then u81 else u73
    Button.Size = if not v3 then u77 else u69
    Button.Active = a2 == "Ready"
    a1.Overlay.Visible = a2 == "Claimed"
    if a2 ~= "Claimed" then
        if a3 then
            punch(a1)
        end
        if a2 == "Ready" then
            Button.Size = u69
            local v4 = {
                Size = UDim2.fromScale(u69.X.Scale * 1.07, u69.Y.Scale * 1.07),
            }
            local pulse = a1.Tweens.pulse
            if pulse then
                pulse:Cancel()
            end
            v3 = TweenService:Create(Button, u103, v4)
            a1.Tweens.pulse = v3
            v3:Play()
        end
        return
    end
    if not a3 then
        a1.Overlay.ImageTransparency = 0.64
        a1.Checkmark.ImageTransparency = 0
        a1.Checkmark.Size = a1.CheckSize
        return
    end
    a1.Overlay.ImageTransparency = 1
    local Overlay_2 = a1.Overlay
    local overlay = a1.Tweens.overlay
    if overlay then
        overlay:Cancel()
    end
    local v5 = TweenService:Create(Overlay_2, u86, {ImageTransparency = 0.64})
    a1.Tweens.overlay = v5
    v5:Play()
    a1.Checkmark.ImageTransparency = 1
    a1.Checkmark.Size = UDim2.fromScale(a1.CheckSize.X.Scale * 0.2, a1.CheckSize.Y.Scale * 0.2)
    local Checkmark_2 = a1.Checkmark
    v1 = {ImageTransparency = 0, Size = a1.CheckSize}
    local check = a1.Tweens.check
    if check then
        check:Cancel()
    end
    local v6 = TweenService:Create(Checkmark_2, u96, v1)
    a1.Tweens.check = v6
    v6:Play()
    punch(a1)
end

local function measureFillPoints(a1) -- Line: 596 -- types: a1: table
    local v1
    local Y = a1.MilestoneBar.AbsolutePosition.Y
    local Y_2 = a1.MilestoneBar.AbsoluteSize.Y
    if Y_2 <= 0 then
        return false
    end
    for i, j in a1.Milestones do
        v1 = (j.Frame.AbsolutePosition.Y + j.Frame.AbsoluteSize.Y * 0.5 - Y) / Y_2
        j.FillPoint = math.clamp(v1, 0, 1)
    end
    return true
end

local function fillScaleFor(a1, a2) -- Line: 610 -- types: a1: table, a2: number
    local v1, v2
    local Rings = 0
    local FillPoint = 0
    for i, j in a1.Milestones do
        if a2 <= j.Rings then
            v2 = j.Rings - Rings
            v1 = if not (v2 > 0) then 1 else (a2 - Rings) / v2
            return FillPoint + (j.FillPoint - FillPoint) * v1
        end
        Rings = j.Rings
        FillPoint = j.FillPoint
    end
    return FillPoint
end

local function readRings() -- Line: 623 -- upvalues: LocalPlayer (val)
    local Attribute = LocalPlayer:GetAttribute("LvdRingsCollected")
    if type(Attribute) == "number" then
        return Attribute
    end
    return 0
end

local function stepYourTeam(a1) -- Line: 629
    -- upvalues: LocalPlayer (val), u144 (ref), u143 (ref), LightVsDarkness (val)
    local AuthoredIcon, RewardIcon
    local Attribute = LocalPlayer:GetAttribute("LvdTeam")
    a1.LightYourTeam.Visible = Attribute == "Light"
    a1.DarknessYourTeam.Visible = Attribute == "Darkness"
    local v1 = if type(Attribute) ~= "string" then nil else Attribute
    if u144 and u143 == v1 then
        return
    end
    u144 = true
    u143 = v1
    local v2 = nil
    local v3 = nil
    for i, j in a1.Milestones, v2, v3 do
        RewardIcon = j.RewardIcon
        AuthoredIcon = LightVsDarkness.MilestoneIcon(i, v1) or j.AuthoredIcon
        RewardIcon.Image = AuthoredIcon
    end
end

local function isClaimed(a1) -- Line: 646 -- upvalues: LocalPlayer (val), LightVsDarkness (val) -- types: a1: number
    return LocalPlayer:GetAttribute((LightVsDarkness.MilestoneAttribute(a1))) == true
end

local function stepRingCount(a1, a2) -- Line: 651
    -- upvalues: LocalPlayer (val), u139 (ref), comma (val), u140 (ref)
    local Attribute = LocalPlayer:GetAttribute("LvdRingsCollected")
    local v1 = if type(Attribute) ~= "number" then 0 else Attribute
    u139 = u139 + (v1 - u139) * (1 - math.exp(a2 * -6))
    if (math.abs(v1 - u139)) < 0.5 then
        u139 = v1
    end
    v1 = comma((math.floor(u139)))
    if v1 ~= u140 then
        u140 = v1
        a1.RingScore.Text = v1
    end
end

local function stepMilestones(a1, a2) -- Line: 665
    -- upvalues: u141 (ref), measureFillPoints (val), u142 (ref), LocalPlayer (val), fillScaleFor (val), u139 (ref)
    -- upvalues: LightVsDarkness (val), setMilestoneState (val)
    local v1
    if not u141 then
        u141 = measureFillPoints(a1)
        if not u141 then
            return
        end
    end
    local v2 = u142
    u142 = true
    local Attribute = LocalPlayer:GetAttribute("LvdRingsCollected")
    local v3 = if type(Attribute) ~= "number" then 0 else Attribute
    a1.MilestoneFill.Size = UDim2.new(1, 0, fillScaleFor(a1, u139), 0)
    local v4 = nil
    local v5 = nil
    for i, j in a1.Milestones, v4, v5 do
        v1 = if not (LocalPlayer:GetAttribute((LightVsDarkness.MilestoneAttribute(i))) == true) then if not (j.Rings <= v3) then "Locked" else "Ready" else "Claimed"
        setMilestoneState(j, v1, v2)
    end
end

local function flyerLayer(a1) -- Line: 686 -- upvalues: u146 (ref) -- types: a1: table
    local v1 = u146
    if v1 ~= nil and v1.Parent == a1.Gui then
        return v1
    end
    if v1 ~= nil then
        v1:Destroy()
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "RingFlight"
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.ZIndex = 50
    Frame.Parent = a1.Gui
    u146 = Frame
    return Frame
end

local function counterTarget(a1) -- Line: 704 -- types: a1: table
    return a1.ScoreRow.AbsolutePosition + a1.ScoreRow.AbsoluteSize * 0.5 - a1.Gui.AbsolutePosition
end

local function punchCounter(a1) -- Line: 708
    -- upvalues: u113 (val), u147 (ref), TweenService (val), u91 (val)
    local ScoreHolderSize = a1.ScoreHolderSize
    a1.ScoreHolder.Size = UDim2.new(ScoreHolderSize.X.Scale, ScoreHolderSize.X.Offset + u113.X, ScoreHolderSize.Y.Scale, ScoreHolderSize.Y.Offset + u113.Y)
    local v1 = u147
    if v1 ~= nil then
        v1:Cancel()
    end
    v1 = TweenService:Create(a1.ScoreHolder, u91, {Size = ScoreHolderSize})
    u147 = v1
    v1:Play()
end

local function dropFlyer(a1) -- Line: 723 -- upvalues: u145 (val) -- types: a1: number
    local v1 = table.remove(u145, a1)
    if v1 ~= nil then
        v1.Frame:Destroy()
    end
end

local function arriveFlyer(a1, a2) -- Line: 730
    -- upvalues: u145 (val), punchCounter (val)
    local v1 = table.remove(u145, a2)
    if v1 ~= nil then
        v1.Frame:Destroy()
    end
    punchCounter(a1)
end

local function stepFlyers() -- Line: 735
    -- upvalues: u115 (ref), u145 (val), punchCounter (val), TweenService (val), Back (val), In (val)
    local v1 = u115
    if v1 ~= nil and #u145 ~= 0 then
        local Value, v2, v3, v4, v5
        local v6 = os.clock()
        local v7 = v1.ScoreRow.AbsolutePosition + v1.ScoreRow.AbsoluteSize * 0.5 - v1.Gui.AbsolutePosition
        for i = #u145, 1, -1 do
            v2 = u145[i]
            if v2.Frame.Parent ~= nil then
                v3 = (v6 - v2.StartAt) / 0.55
                if not (v3 >= 1) then
                    v2.Frame.Rotation = (v6 * 140 + v2.Phase) % 360
                    if not (v3 < 0) then
                        Value = TweenService:GetValue(v3, Back, In)
                        v3 = 1 - Value
                        v5 = v2.From * v3 * v3 + v2.Control * 2 * v3 * Value + v7 * Value * Value
                        v2.Frame.Position = UDim2.fromOffset(v5.X, v5.Y)
                        v5 = 1 - math.clamp(Value, 0, 1) * 0.4
                        v2.Frame.Size = UDim2.fromOffset(v5 * 46, v5 * 46)
                    end
                else
                    v4 = table.remove(u145, i)
                    if v4 ~= nil then
                        v4.Frame:Destroy()
                    end
                    punchCounter(v1)
                end
            else
                table.remove(u145, i)
            end
        end
        return
    end
end

local function step(a1) -- Line: 823
    -- upvalues: u115 (ref), u116 (ref), u117 (ref), u118 (ref), HiddenUIHandler (val), LocalPlayer (val), u139 (ref)
    -- upvalues: comma (val), u140 (ref), Workspace (val), u132 (ref), u128 (ref), u130 (ref), u129 (ref), u131 (ref)
    -- upvalues: advanceSprite (val), u133 (ref), u136 (ref), u135 (ref), u134 (ref), stepLabels (val)
    -- upvalues: stepMilestones (val), stepYourTeam (val), u119 (ref), u127 (ref)
    local v1 = u115
    local v2 = u116
    local v3 = u117
    if u118 and v1 ~= nil and v2 ~= nil and v3 ~= nil then
        if HiddenUIHandler.IsHidden() then
            v1.Gui.Enabled = false
            return
        end
        v1.Gui.Enabled = true
        local Visible = v1.TeamPanel.Visible
        v1.ScoreBar.Visible = not Visible
        v1.MilestonePanel.Visible = not Visible
        local v4 = math.min(a1, 0.1)
        local Attribute = LocalPlayer:GetAttribute("LvdRingsCollected")
        local v5 = if type(Attribute) ~= "number" then 0 else Attribute
        u139 = u139 + (v5 - u139) * (1 - math.exp(v4 * -6))
        if (math.abs(v5 - u139)) < 0.5 then
            u139 = v5
        end
        v5 = comma((math.floor(u139)))
        if v5 ~= u140 then
            u140 = v5
            v1.RingScore.Text = v5
        end
        if Visible then
            return
        end
        local v6 = math.min(a1, 0.1)
        local v7 = if Workspace:GetAttribute("LvdFinalClash") ~= true then 1 else 2
        u132 = u132 - u132 * math.min(v6 * 1.6, 1)
        v4 = math.clamp(u128 + u132, 0.12, 0.88)
        u130 = u130 + (v4 - u129) * 55 * v6
        u130 = u130 * math.exp(v6 * -7)
        u129 = math.clamp(u129 + u130 * v6, 0.05, 0.95)
        v5 = u129
        v1.LightBar.Size = UDim2.new(v1.BarSpan * v5, 0, 1, 0)
        v1.DarkBar.Size = UDim2.new(v1.BarSpan * (1 - v5), 0, 1, 0)
        u131 = u131 + (u130 - u131) * (1 - math.exp(v6 * -8))
        v4 = math.clamp(u131 / 0.5, -1, 1)
        v2.fps = v2.baseFps + (90 - v2.baseFps) * math.max(v4, 0)
        v3.fps = v3.baseFps + (90 - v3.baseFps) * math.max(-v4, 0)
        advanceSprite(v2, v6)
        advanceSprite(v3, v6)
        v3 = v1.BarSpan * u129 + v1.SeamPad
        u133 = u133 + (v3 - u133) * (1 - math.exp(v6 * -22))
        v5 = u136
        v5.v = v5.v + (v5.p * -260 - v5.v * 14) * v6
        v5.p = v5.p + v5.v * v6
        u135 = u135 - u135 * math.min(v6 * 6, 1)
        v3 = u136.p + 1
        v2 = v4 * 10 * v7 + u135
        v1.VsIcon.Position = UDim2.new(u133, v1.IconPos.X.Offset, v1.IconPos.Y.Scale, v1.IconPos.Y.Offset)
        v1.VsIcon.Size = UDim2.new(v1.IconSize.X.Scale * v3, v1.IconSize.X.Offset, v1.IconSize.Y.Scale * v3, v1.IconSize.Y.Offset)
        v1.VsIcon.Rotation = v2
        v1.VsText.Position = UDim2.new(u133, v1.TextPos.X.Offset, v1.TextPos.Y.Scale, v1.TextPos.Y.Offset)
        v1.VsText.Size = UDim2.new(v1.TextSize.X.Scale * v3, v1.TextSize.X.Offset, v1.TextSize.Y.Scale * v3, v1.TextSize.Y.Offset)
        v1.VsText.Rotation = v2
        u134 = u134 - u134 * math.min(v6 * 6, 1)
        if v7 > 1 then
            u134 = math.max(u134, 1.5)
        end
        local HolderPos = v1.HolderPos
        if u134 > 0.05 then
            v1.Holder.Position = UDim2.new(
                HolderPos.X.Scale,
                HolderPos.X.Offset + (math.random() - 0.5) * 2 * u134,
                HolderPos.Y.Scale,
                HolderPos.Y.Offset + (math.random() - 0.5) * u134
            )
        elseif v1.Holder.Position ~= HolderPos then
            v1.Holder.Position = HolderPos
        end
        stepLabels(v1, v6)
        stepMilestones(v1, v6)
        stepYourTeam(v1)
        v7 = math.max(math.ceil(u119 - (Workspace:GetServerTimeNow())), 0)
        v4 = string.format("%d:%02d", v7 // 60, v7 % 60)
        if v4 ~= u127 then
            u127 = v4
            v1.Timer.Text = v4
        end
        return
    end
end

local function stop() -- Line: 908
    -- upvalues: u118 (ref), u145 (val), u147 (ref), u146 (ref), u115 (ref), u60 (val), u81 (val), u77 (val), u116 (ref)
    -- upvalues: u117 (ref)
    local v1
    if not u118 then
        return
    end
    u118 = false
    for i = #u145, 1, -1 do
        v1 = table.remove(u145, i)
        if v1 ~= nil then
            v1.Frame:Destroy()
        end
    end
    local v2 = u147
    u147 = nil
    if v2 ~= nil then
        v2:Cancel()
    end
    v2 = u146
    u146 = nil
    if v2 ~= nil then
        v2:Destroy()
    end
    v2 = u115
    if v2 then
        local Button, Quantity
        v2.Gui.Enabled = false
        v2.ScoreHolder.Size = v2.ScoreHolderSize
        v2.ScoreBar.Visible = true
        v2.MilestonePanel.Visible = true
        v2.Holder.Position = v2.HolderPos
        v2.VsIcon.Position = v2.IconPos
        v2.VsIcon.Size = v2.IconSize
        v2.VsIcon.Rotation = 0
        v2.VsText.Position = v2.TextPos
        v2.VsText.Size = v2.TextSize
        v2.VsText.Rotation = 0
        v2.LightLabel.Size = v2.LightLabelSize
        v2.DarkLabel.Size = v2.DarkLabelSize
        v2.LightLabel.TextColor3 = v2.LightLabelColor
        v2.DarkLabel.TextColor3 = v2.DarkLabelColor
        v2.LightYourTeam.Visible = false
        v2.DarknessYourTeam.Visible = false
        local v3 = nil
        v1 = nil
        for j, k in v2.Milestones, v3, v1 do
            for n, m in k.Tweens do
                m:Cancel()
                k.Tweens[n] = nil
            end
            k.State = nil
            if k.State ~= "Locked" then
                k.State = "Locked"
                for i5, i6 in k.Tweens do
                    i6:Cancel()
                    k.Tweens[i5] = nil
                end
                if k.UnlockedDecor then
                    k.UnlockedDecor.Visible = false
                end
                if k.LockedDecor then
                    k.LockedDecor.Visible = true
                end
                k.Frame.Size = k.BaseSize
                k.Frame.BackgroundColor3 = u60
                Button = k.Button
                Button.Image = "rbxassetid://111037630886814"
                Button.Position = u81
                Button.Size = u77
                Button.Active = false
                k.Overlay.Visible = false
            end
            k.Frame.Size = k.BaseSize
            k.RewardIcon.Image = k.AuthoredIcon
            Quantity = k.Quantity
            if Quantity then
                Quantity.Visible = true
                Quantity.Text = k.QuantityText
            end
        end
    end
    v2 = u116
    local v4 = u117
    u116 = nil
    u117 = nil
    if v2 then
        v2.image.Size = v2.baseSize
        v2.image.Rotation = 0
        v2.image:SetAttribute("UIEffectsPaused", nil)
    end
    if v4 then
        v4.image.Size = v4.baseSize
        v4.image.Rotation = 0
        v4.image:SetAttribute("UIEffectsPaused", nil)
    end
end

return {
    Start = function(a1, a2) -- Line: 971
        -- upvalues: stop (val), resolveUi (val), u118 (ref), u119 (ref), u120 (ref), u121 (ref), u122 (ref), u123 (ref)
        -- upvalues: u124 (ref), u125 (ref), u126 (ref), u127 (ref), u128 (ref), u129 (ref), u130 (ref), u131 (ref)
        -- upvalues: u132 (ref), u133 (ref), u134 (ref), u135 (ref), u136 (ref), u137 (ref), u138 (ref), u116 (ref)
        -- upvalues: takeOverSprite (val), u117 (ref), u139 (ref), LocalPlayer (val), u140 (ref), u141 (ref), u142 (ref)
        -- upvalues: u144 (ref), LightVsDarkness (val), GUI (val), Remotes (val), stepYourTeam (val), comma (val)
        -- upvalues: stepMilestones (val), clash (val), RunService (val), step (val), stepFlyers (val), u115 (ref)
        local Quantity, ValueHolder, v1
        stop()
        local v2 = resolveUi()
        u118 = true
        u119 = a2
        u120 = 0
        u121 = 0
        u122 = 0
        u123 = 0
        u124 = -1
        u125 = -1
        u126 = 0
        u127 = ""
        u128 = 0.5
        u129 = 0.5
        u130 = 0
        u131 = 0
        u132 = 0
        u133 = v2.BarSpan * 0.5 + v2.SeamPad
        u134 = 0
        u135 = 0
        u136 = {p = 0, v = 0}
        u137 = {p = 0, v = 0}
        u138 = {p = 0, v = 0}
        takeOverSprite(v2.AngelWing)
        takeOverSprite(v2.DemonWing)
        local v3 = u129
        v2.LightBar.Size = UDim2.new(v2.BarSpan * v3, 0, 1, 0)
        v2.DarkBar.Size = UDim2.new(v2.BarSpan * (1 - v3), 0, 1, 0)
        v2.LightLabel.Text = "0"
        v2.DarkLabel.Text = "0"
        local Attribute = LocalPlayer:GetAttribute("LvdRingsCollected")
        u139 = if type(Attribute) ~= "number" then 0 else Attribute
        u140 = ""
        u141 = false
        u142 = false
        u144 = false
        local v4 = nil
        local v5 = nil
        local v6 = a1
        for i, j in v2.Milestones, v4, v5 do
            j.State = nil
            Quantity = j.Quantity
            if Quantity then
                v1 = LightVsDarkness.MilestoneQuantity(i)
                Quantity.Visible = v1 ~= nil
                Quantity.Text = v1 or Quantity.Text
            end
            GUI.OnActivated(j.Button, function() -- Line: 1006 -- upvalues: u118 (upval), j (val), Remotes (upval), i (val)
                if u118 and j.State == "Ready" then
                    Remotes.LightVsDarkness.AskClaimMilestone:FireServer(i)
                end
            end)
            ValueHolder = j.Frame:FindFirstChild("ValueHolder")
            if ValueHolder then
                ValueHolder.Title.Text = ("%*"):format(j.Rings)
            end
        end
        stepYourTeam(v2)
        local Attribute_2 = LocalPlayer:GetAttribute("LvdRingsCollected")
        v3 = if type(Attribute_2) ~= "number" then 0 else Attribute_2
        u139 = u139 + (v3 - u139) * 0.4511883639059736
        if (math.abs(v3 - u139)) < 0.5 then
            u139 = v3
        end
        v3 = comma((math.floor(u139)))
        if v3 ~= u140 then
            u140 = v3
            v2.RingScore.Text = v3
        end
        stepMilestones(v2, 0.1)
        v6:Connect(Remotes.LightVsDarkness.ScoreChanged.OnClientEvent, function(a1, a2) -- Line: 1022
            -- upvalues: u118 (upval), u128 (upval), u120 (upval), u121 (upval), u132 (upval), clash (upval)
            if u118 then
                local v1 = u128
                u120 = a1
                u121 = a2
                local v2 = a1 + a2
                local v3 = (if not (v2 <= 0) then math.clamp(a1 / v2, 0.12, 0.88) else 0.5) - v1
                if v3 == 0 then
                    return
                end
                v1 = math.clamp(math.abs(v3) / 0.05, 0.15, 1)
                u132 = (if not (v3 > 0) then -1 else 1) * 0.22 * v1
                clash(v1, v2)
            end
        end)
        v6:Connect(RunService.PreRender, step)
        v6:Connect(RunService.PreRender, stepFlyers)
        v6:Add(stop)
        v6:Add((task.spawn(function() -- Line: 1032
            -- upvalues: Remotes (upval), u118 (upval), u120 (upval), u121 (upval), u128 (upval), u122 (upval)
            -- upvalues: u123 (upval), u129 (upval), u130 (upval), u132 (upval), u115 (upval), u133 (upval)
            local v1, v2 = Remotes.LightVsDarkness.FetchScore:InvokeServer()
            if u118 and type(v1) == "number" and type(v2) == "number" and u120 == 0 and u121 == 0 then
                u120 = v1
                u121 = v2
                local v3 = v1 + v2
                local v4 = if not (v3 <= 0) then math.clamp(v1 / v3, 0.12, 0.88) else 0.5
                u122 = v1
                u123 = v2
                u129 = v4
                u130 = 0
                u132 = 0
                v4 = u115
                if v4 then
                    u133 = v4.BarSpan * u129 + v4.SeamPad
                    v3 = u129
                    v4.LightBar.Size = UDim2.new(v4.BarSpan * v3, 0, 1, 0)
                    v4.DarkBar.Size = UDim2.new(v4.BarSpan * (1 - v3), 0, 1, 0)
                end
            end
        end)))
    end,
    Stop = stop,
    RingArrived = function(a1, a2) -- Line: 768
        -- upvalues: u115 (ref), u118 (ref), Workspace (val), u149 (val), u145 (val), punchCounter (val)
        -- upvalues: flyerLayer (val)
        local v1 = u115
        if u118 and v1 ~= nil and v1.Gui.Enabled then
            local Icon = v1.ScoreRow:FindFirstChild("Icon")
            if Icon ~= nil and Icon:IsA("ImageLabel") then
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera == nil then
                    return
                end
                local v2, v3 = CurrentCamera:WorldToViewportPoint(a2 + Vector3.new(0, 1.5, 0))
                local ViewportSize = CurrentCamera.ViewportSize
                local v4 = (if not v3 then Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.62) else Vector2.new(v2.X, v2.Y)) + Vector2.new(u149:NextNumber(-70, 70), u149:NextNumber(-70, 70) * 0.7) - v1.Gui.AbsolutePosition
                local v5 = v1.ScoreRow.AbsolutePosition + v1.ScoreRow.AbsoluteSize * 0.5 - v1.Gui.AbsolutePosition
                v3 = v5 - v4
                local Unit = if not (1 < v3.Magnitude) then Vector2.new(0, -1) else Vector2.new(-v3.Y, v3.X).Unit
                local v6 = (v4 + v5) * 0.5 + Unit * u149:NextNumber(-0.3, 0.3) * v3.Magnitude + Vector2.new(0, -u149:NextNumber(10, 60))
                while true do
                    if not (#u145 >= 24) then
                        break
                    end
                    v5 = table.remove(u145, 1)
                    if v5 ~= nil then
                        v5.Frame:Destroy()
                    end
                    punchCounter(v1)
                end
                v3 = Instance.new("ImageLabel")
                v3.Name = "RingFlyer"
                v3.BackgroundTransparency = 1
                v3.AnchorPoint = Vector2.new(0.5, 0.5)
                v3.Size = UDim2.fromOffset(46, 46)
                v3.Position = UDim2.fromOffset(v4.X, v4.Y)
                v3.Image = Icon.Image
                v3.ImageColor3 = Icon.ImageColor3
                v3.ImageRectOffset = Icon.ImageRectOffset
                v3.ImageRectSize = Icon.ImageRectSize
                v3.ScaleType = Enum.ScaleType.Fit
                v3.Parent = flyerLayer(v1)
                table.insert(u145, {
                    Frame = v3,
                    From = v4,
                    Control = v6,
                    StartAt = os.clock() + u149:NextNumber(0, 0.12),
                    Phase = u149:NextNumber(0, 360),
                })
                return
            end
            return
        end
    end,
}