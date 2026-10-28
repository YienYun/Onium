-- Script path: ReplicatedStorage.Controllers.Game.FishingController.Ui
-- Decompile time: 24.42 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local u25 = UDim2.fromScale(0.5, 0.5)
local u29 = UDim2.fromScale(0.5, -0.5)
local u33 = UDim2.fromScale(0.5, 1.5)
local u38 = Color3.fromRGB(255, 205, 60)
local u43 = Color3.fromRGB(255, 250, 214)
local u48 = Color3.new(1, 1, 1)
local ffe45a = Color3.fromHex("ffe45a")
local u52 = nil
local u53 = 0
local u54 = 0
local u55 = nil
local u56 = nil
local u57 = -1
local v1 = {}

local function child(a1, a2) -- Line: 92 -- types: a1: userdata, a2: table
    local v1
    local v2 = a1
    local v3 = nil
    local v4 = nil
    for i, j in a2, v3, v4 do
        v1 = v2:FindFirstChild(j)
        if v1 == nil then
            error((("[Fishing] FishingUI is missing %*.%*"):format(v2:GetFullName(), j)))
        end
        v2 = v1
    end
    return v2
end

local function tween(a1, a2, a3, a4) -- Line: 104
    -- upvalues: TweenService (val)
    local new = TweenInfo.new
    TweenService:Create(a1, new(a2, a4 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), a3):Play()
end

local function scaleOf(a1) -- Line: 114 -- types: a1: userdata
    return a1:FindFirstChildOfClass("UIScale")
end

local function punch(a1, a2, a3) -- Line: 118
    -- upvalues: GuiService (val), TweenService (val)
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        return
    end
    if GuiService.ReducedMotionEnabled then
        UIScale.Scale = 1
        return
    end
    UIScale.Scale = a2
    local Back = Enum.EasingStyle.Back
    local new = TweenInfo.new
    TweenService:Create(UIScale, new(a3, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local function number(a1, a2, a3) -- Line: 131 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

local function span(a1) -- Line: 136 -- types: a1: userdata
    local Scale = a1.Size.Y.Scale
    return a1.Position.Y.Scale - a1.AnchorPoint.Y * Scale, Scale
end

local function digits(a1) -- Line: 141 -- upvalues: child (val) -- types: a1: userdata
    local v1
    local v2 = {}
    local v3 = 1
    while true do
        v1 = a1:FindFirstChild((("Digit%*"):format(v3)))
        if v1 == nil then
            break
        end
        table.insert(v2, {
            Current = child(v1, {"Current"}),
            Next = child(v1, {"Next"}),
            Value = child(v1, {"Current"}).Text,
            Tweens = {},
        })
        v3 = v3 + 1
    end
    return v2
end

local function glyphs(a1) -- Line: 160 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("TextLabel") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function bind() -- Line: 170
    -- upvalues: u52 (ref), LocalPlayer (val), child (val), digits (val), glyphs (val), u55 (ref), u56 (ref), u57 (ref)
    local v1 = u52
    if v1 and v1.Gui.Parent ~= nil and v1.VignetteGui.Parent ~= nil then
        return v1
    end
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local FishingUI = PlayerGui and PlayerGui:FindFirstChild("FishingUI")
    if FishingUI ~= nil and FishingUI:IsA("ScreenGui") then
        local FishingVignette = PlayerGui and PlayerGui:FindFirstChild("FishingVignette")
        if FishingVignette ~= nil and FishingVignette:IsA("ScreenGui") then
            v1 = child(FishingUI, {"Charge"})
            local v2 = child(v1, {"Track"})
            local v3 = child(v2, {"Fill"})
            local v4 = child(v2, {"Surface"})
            local v5 = child(v2, {"Band"})
            local Glow = v2:FindFirstChild("Glow")
            local Scale = v2.Size.Y.Scale
            local v6 = v2.Position.Y.Scale - v2.AnchorPoint.Y * Scale
            local v7 = Scale
            local Attribute = v2:GetAttribute("WindowTop")
            local v8 = if type(Attribute) ~= "number" then 0 else Attribute
            local Attribute_2 = v2:GetAttribute("WindowBottom")
            local v9 = if type(Attribute_2) ~= "number" then 1 else Attribute_2
            v2 = child(FishingUI, {"Reel", "Counter"})
            local v10 = {Gui = FishingUI}
            v10.Tooltip = child(FishingUI, {"Tooltip"})
            v10.TooltipLabel = child(FishingUI, {"Tooltip", "Label"})
            v10.Charge = v1
            v10.Fill = v3
            v10.FillGradient = child(v3, {"UIGradient"})
            v10.Surface = v4
            v10.SurfaceGradient = child(v4, {"UIGradient"})
            v10.Band = v5
            v10.BandGradient = child(v5, {"UIGradient"})
            v10.BandGlow = if not Glow then nil else if not Glow:IsA("GuiObject") then nil else Glow
            v10.GlowGradient = if not Glow then nil else Glow:FindFirstChildOfClass("UIGradient")
            v10.WindowLow = 1 - v9
            v10.WindowHigh = 1 - v8
            v10.TagTop = v6 + v7 * v8
            v10.TagSpan = v7 * (v9 - v8)
            v10.Tag = child(FishingUI, {"Charge", "Tag"})
            v10.Luck = child(FishingUI, {"Charge", "Tag", "Pill", "Luck"})
            v10.Perfect = child(FishingUI, {"Perfect"})
            v10.Reel = child(FishingUI, {"Reel"})
            v10.ReelTitle = child(FishingUI, {"Reel", "Title"})
            v10.Counter = v2
            v10.Digits = digits(v2)
            v10.Glyphs = glyphs(v2)
            v10.FillLeft = child(FishingUI, {"Reel", "Bar", "FillLeft"})
            v10.FillRight = child(FishingUI, {"Reel", "Bar", "FillRight"})
            v10.Center = child(FishingUI, {"Reel", "Bar", "Center"})
            v10.Stop = child(FishingUI, {"Reel", "Stop"})
            v10.Reveal = child(FishingUI, {"Reveal"})
            v10.VignetteGui = FishingVignette
            v10.Vignette = child(FishingVignette, {"Vignette"})
            v10.Card = child(FishingUI, {"Reveal", "Card"})
            v10.Shine = child(FishingUI, {"Reveal", "Card", "Shine"})
            v10.Image = child(FishingUI, {"Reveal", "Card", "Image"})
            v10.RewardName = child(FishingUI, {"Reveal", "Card", "RewardName"})
            u52 = v10
            u55 = nil
            u56 = nil
            u57 = -1
            return v10
        end
        return nil
    end
    return nil
end

local function slab(a1, a2, a3) -- Line: 238 -- types: a1: number, a2: number, a3: number
    local v1 = math.clamp(a1, a3 + 0.001, 1 - a3 * 2 - 0.002)
    local v2 = math.clamp(a2, v1 + a3 + 0.001, 0.999)
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(v1 - a3, 1),
        NumberSequenceKeypoint.new(v1, 0),
        NumberSequenceKeypoint.new(v2 - a3, 0),
        NumberSequenceKeypoint.new(v2, 1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
end

local function crest(a1, a2) -- Line: 251 -- types: a1: number, a2: number
    local v1 = math.clamp(a1, a2 + 0.003 + 0.002, 0.999)
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(v1 - a2, 1),
        NumberSequenceKeypoint.new(v1 - 0.003, 0),
        NumberSequenceKeypoint.new(v1, 1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
end

local function paintBand(a1, a2, a3) -- Line: 262
    -- upvalues: u43 (val), u38 (val), slab (val)
    local v1 = math.max(a3 - a2, 0.036000000000000004)
    local v2 = math.clamp(a2, 0.006, 1 - v1 - 0.006)
    local v3 = v2 + v1
    local Attribute = a1.Band:GetAttribute("LineThickness")
    local v4 = v1 * 0.2
    local v5 = math.min(if type(Attribute) ~= "number" then 0.011 else Attribute, v4)
    local v6 = v1 * 0.3
    local Attribute_2 = a1.Band:GetAttribute("EdgeTransparency")
    local Attribute_3 = a1.Band:GetAttribute("CoreTransparency")
    v4 = if type(Attribute_3) ~= "number" then 0.75 else Attribute_3
    a1.BandGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(v2 - 0.003, 1),
        NumberSequenceKeypoint.new(v2, 0),
        NumberSequenceKeypoint.new(v2 + v5, 0),
        NumberSequenceKeypoint.new(v2 + v5 + 0.003, if type(Attribute_2) ~= "number" then 0.45 else Attribute_2),
        NumberSequenceKeypoint.new(v2 + v6, v4),
        NumberSequenceKeypoint.new(v3 - v6, v4),
        NumberSequenceKeypoint.new(v3 - v5 - 0.003, v1),
        NumberSequenceKeypoint.new(v3 - v5, 0),
        NumberSequenceKeypoint.new(v3, 0),
        NumberSequenceKeypoint.new(v3 + 0.003, 1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    a1.BandGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, u43),
        ColorSequenceKeypoint.new(v2 + v5, u43),
        ColorSequenceKeypoint.new(v2 + v5 + 0.003, u38),
        ColorSequenceKeypoint.new(v3 - v5 - 0.003, u38),
        ColorSequenceKeypoint.new(v3 - v5, u43),
        (ColorSequenceKeypoint.new(1, u43)),
    })
    local BandGlow = a1.BandGlow
    local GlowGradient = a1.GlowGradient
    if BandGlow and GlowGradient then
        v1 = BandGlow:GetAttribute("Spread")
        v5 = if type(v1) ~= "number" then 0.035 else v1
        GlowGradient.Transparency = slab(v2, v3 + v5, v5)
    end
end

local function roll(a1, a2, a3) -- Line: 300
    -- upvalues: u25 (val), u33 (val), GuiService (val), TweenService (val), u29 (val)
    local v1 = nil
    local v2 = nil
    for i, j in a1.Tweens, v1, v2 do
        j:Cancel()
    end
    table.clear(a1.Tweens)
    a1.Current.Text = a1.Value
    a1.Current.Position = u25
    a1.Next.Position = u33
    a1.Value = a2
    if not (a3 <= 0) and not GuiService.ReducedMotionEnabled then
        a1.Next.Text = a2
        local v3 = TweenInfo.new(a3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v1 = TweenService:Create(a1.Current, v3, {Position = u29})
        v2 = TweenService:Create(a1.Next, v3, {Position = u25})
        v2.Completed:Once(function(a1_2) -- Line: 317 -- upvalues: a1 (val), a2 (val), u25 (upval), u33 (upval)
            if a1_2 == Enum.PlaybackState.Completed and a1.Value == a2 then
                a1.Current.Text = a2
                a1.Current.Position = u25
                a1.Next.Position = u33
                table.clear(a1.Tweens)
                return
            end
        end)
        table.insert(a1.Tweens, v1)
        table.insert(a1.Tweens, v2)
        v1:Play()
        v2:Play()
        return
    end
    a1.Current.Text = a2
end

local function flashCounter(a1) -- Line: 332 -- upvalues: punch (val), TweenService (val) -- types: a1: table
    local TextColor3, v1
    local Counter = a1.Counter
    local Attribute = Counter:GetAttribute("PunchScale")
    local Attribute_2 = Counter:GetAttribute("PunchSeconds")
    local v2 = if type(Attribute_2) ~= "number" then 0.18 else Attribute_2
    punch(Counter, if type(Attribute) ~= "number" then 1.18 else Attribute, v2)
    local Attribute_3 = Counter:GetAttribute("FlashColor")
    if typeof(Attribute_3) ~= "Color3" then
        return
    end
    local Attribute_4 = Counter:GetAttribute("FlashSeconds")
    local v3 = if type(Attribute_4) ~= "number" then 0.3 else Attribute_4
    v2 = nil
    local v4 = nil
    for i, j in a1.Glyphs, v2, v4 do
        TextColor3 = j:GetAttribute("RestColor")
        if typeof(TextColor3) ~= "Color3" then
            TextColor3 = j.TextColor3
            j:SetAttribute("RestColor", TextColor3)
        end
        j.TextColor3 = Attribute_3
        v1 = TweenInfo.new(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(j, v1, {TextColor3 = TextColor3}):Play()
    end
end

local function showClicks(a1, a2) -- Line: 351
    -- upvalues: u55 (ref), roll (val), flashCounter (val)
    local v1
    local v2 = math.clamp(math.floor(a2), 0, 999)
    if u55 == v2 then
        return
    end
    local v3 = false
    if u55 ~= nil then
        v3 = u55 < v2
    end
    u55 = v2
    local v4 = string.format(("%%0%*d"):format(#a1.Digits), v2)
    if not v3 then
        v2 = 0
    else
        local Attribute = a1.Counter:GetAttribute("RollSeconds")
        v2 = if type(Attribute) ~= "number" then 0.13 else Attribute
    end
    local v5 = nil
    local v6 = nil
    for i, j in a1.Digits, v5, v6 do
        v1 = string.sub(v4, i, i)
        if v1 ~= j.Value or not v3 then
            roll(j, v1, v2)
        end
    end
    if v3 then
        flashCounter(a1)
    end
end

local function layoutTitle(a1) -- Line: 371 -- upvalues: u57 (ref) -- types: a1: table
    local X = a1.Reel.AbsoluteSize.X
    local X_2 = a1.ReelTitle.TextBounds.X
    if not (X <= 0) and not (X_2 <= 0) and X_2 ~= u57 then
        u57 = X_2
        local Counter = a1.Counter
        local v1 = X_2 / X
        local v2 = Counter:GetAttribute("GapX")
        local v3 = if type(v2) ~= "number" then 0.0115 else v2
        local Scale = Counter.Size.X.Scale
        local Attribute = Counter:GetAttribute("GroupCenterX")
        local v4 = (if type(Attribute) ~= "number" then 0.45 else Attribute) - (v1 + v3 + Scale) / 2
        a1.ReelTitle.Position = UDim2.fromScale(v4 + v1, a1.ReelTitle.Position.Y.Scale)
        Counter.Position = UDim2.fromScale(v4 + v1 + v3 + Scale * Counter.AnchorPoint.X, Counter.Position.Y.Scale)
        return
    end
end

local function commas(a1) -- Line: 388 -- types: a1: number
    local v1, v2
    local v3 = tostring((math.floor(a1 + 0.5)))
    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0
    return v3
end

function v1.Ready() -- Line: 401 -- upvalues: bind (val)
    return bind() ~= nil
end

function v1.StopButton() -- Line: 405 -- upvalues: bind (val)
    local v1 = bind()
    return v1 and v1.Stop
end

function v1.Acquire() -- Line: 410 -- upvalues: bind (val), u53 (ref)
    local u1 = bind()
    if u1 == nil then
        return function() end
    end
    u53 = u53 + 1
    u1.Gui.Enabled = true
    local u7 = false
    return function() -- Line: 418 -- upvalues: u7 (ref), u53 (upval), u1 (val)
        if u7 then
            return
        end
        u7 = true
        u53 = u53 - 1
        if u53 <= 0 then
            u53 = 0
            u1.Tooltip.Visible = false
            u1.Charge.Visible = false
            u1.Perfect.Visible = false
            u1.Reel.Visible = false
            u1.Reveal.Visible = false
            u1.VignetteGui.Enabled = false
            u1.Gui.Enabled = false
        end
    end
end

function v1.Tooltip(a1, a2, a3) -- Line: 437 -- upvalues: bind (val) -- types: a1: boolean, a2: string?, a3: userdata?
    local v1 = bind()
    if v1 == nil then
        return
    end
    v1.Tooltip.Visible = a1
    if not a1 then
        return
    end
    if a2 and v1.TooltipLabel.Text ~= a2 then
        v1.TooltipLabel.Text = a2
    end
    if a3 then
        local Attribute = v1.Tooltip:GetAttribute("CursorOffsetX")
        local Attribute_2 = v1.Tooltip:GetAttribute("CursorOffsetY")
        local Tooltip = v1.Tooltip
        local fromScale = UDim2.fromScale
        local X = a3.X
        local Y = a3.Y
        local v2 = if type(Attribute_2) ~= "number" then 0 else Attribute_2
        Tooltip.Position = fromScale(X + (if type(Attribute) ~= "number" then 0.012 else Attribute), Y + v2)
    end
end

function v1.TouchAnchor() -- Line: 459 -- upvalues: bind (val)
    local v1 = bind()
    local Attribute = v1 and v1.Tooltip:GetAttribute("TouchX")
    local Attribute_2 = v1 and v1.Tooltip:GetAttribute("TouchY")
    return Vector2.new(if type(Attribute) ~= "number" then 0.62 else Attribute, if type(Attribute_2) ~= "number" then 0.6 else Attribute_2)
end

function v1.ShowCharge(a1, a2, a3) -- Line: 469
    -- upvalues: bind (val), u56 (ref), paintBand (val)
    local v1 = bind()
    if v1 == nil then
        return
    end
    v1.Charge.Visible = a1
    u56 = nil
    if a1 and a2 and a3 then
        local v2 = math.clamp(math.min(a2, a3), 0, 1)
        local v3 = math.clamp(math.max(a2, a3), 0, 1)
        local v4 = v1.WindowHigh - v1.WindowLow
        paintBand(v1, v1.WindowLow + v4 * v2, v1.WindowLow + v4 * v3)
    end
end

function v1.SetCharge(a1, a2, a3, a4) -- Line: 484
    -- upvalues: bind (val), u56 (ref), slab (val), crest (val), ffe45a (val), u48 (val)
    local v1, v2
    local v3 = bind()
    if v3 == nil then
        return
    end
    local v4 = math.clamp(a1, 0, 1)
    if u56 ~= v4 then
        u56 = v4
        v1 = v3.WindowLow + (v3.WindowHigh - v3.WindowLow) * v4
        local Attribute = v3.Surface:GetAttribute("Depth")
        v2 = math.max(if type(Attribute) ~= "number" then 0.03 else Attribute, 0.006)
        v3.Fill.Visible = v4 > 0.005
        local Surface = v3.Surface
        local v5 = false
        if v4 > 0.005 then
            v5 = v4 < 0.995
        end
        Surface.Visible = v5
        v3.FillGradient.Transparency = slab(0, v1, 0.003)
        v3.SurfaceGradient.Transparency = crest(v1, v2)
        v2 = v3.TagTop + v3.TagSpan * (1 - v4)
        v3.Tag.Position = UDim2.fromScale(v3.Tag.Position.X.Scale, v2)
    end
    v3.Luck.Text = ("%* Luck"):format(a2)
    v2 = if not a3 then u48 else ffe45a
    v3.Luck.TextColor3 = v2
    local BandGlow = v3.BandGlow
    if BandGlow then
        if not a3 then
            local Attribute_3 = BandGlow:GetAttribute("IdleTransparency")
            v1 = if type(Attribute_3) ~= "number" then 0.55 else Attribute_3
        else
            local Attribute_2 = BandGlow:GetAttribute("PerfectTransparency")
            v1 = if type(Attribute_2) ~= "number" then 0.05 else Attribute_2
        end
        if not BandGlow:IsA("ImageLabel") then
            BandGlow.BackgroundTransparency = v1
        else
            BandGlow.ImageTransparency = v1
        end
    end
    if a4 then
        local Attribute_4 = v3.Charge:GetAttribute("ScreenOffsetX")
        local Attribute_5 = v3.Charge:GetAttribute("ScreenOffsetY")
        v3.Charge.Position = UDim2.fromScale(
            math.clamp(a4.X + (if type(Attribute_4) ~= "number" then 0.035 else Attribute_4), 0, 0.85),
            (math.clamp(a4.Y + (if type(Attribute_5) ~= "number" then -0.05 else Attribute_5), 0.2, 0.8))
        )
    end
end

function v1.Perfect(a1) -- Line: 524
    -- upvalues: bind (val), u54 (ref), punch (val), TweenService (val)
    local v1 = bind()
    if v1 == nil then
        return
    end
    u54 = u54 + 1
    local u5 = u54
    local Perfect = v1.Perfect
    if a1 then
        Perfect.Position = UDim2.fromScale(math.clamp(a1.X, 0.15, 0.85), (math.clamp(a1.Y, 0.1, 0.8)))
    end
    Perfect.TextTransparency = 0
    Perfect.Visible = true
    punch(Perfect, 1.8, 0.35)
    task.delay(0.9, function() -- Line: 539 -- upvalues: u54 (upval), u5 (val), Perfect (val), TweenService (upval)
        if u54 ~= u5 then
            return
        end
        local v1 = Perfect
        local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(v1, v2, {TextTransparency = 1}):Play()
        task.delay(0.26, function() -- Line: 544 -- upvalues: u54 (upval), u5 (upval), Perfect (upval)
            if u54 == u5 then
                Perfect.Visible = false
            end
        end)
    end)
end

function v1.ShowReel(a1, a2) -- Line: 552
    -- upvalues: bind (val), u57 (ref), punch (val)
    local v1 = bind()
    if v1 == nil then
        return
    end
    v1.Reel.Visible = a1
    u57 = -1
    if a1 then
        if a2 then
            v1.ReelTitle.Text = a2
        end
        punch(v1.Reel, 0.6, 0.3)
    end
end

function v1.SetReel(a1, a2, a3) -- Line: 567
    -- upvalues: bind (val), showClicks (val), layoutTitle (val)
    local v1 = bind()
    if v1 == nil then
        return
    end
    local v2 = math.clamp(a1, 0, 1) * 0.5
    v1.FillLeft.Size = UDim2.fromScale(v2, v1.FillLeft.Size.Y.Scale)
    v1.FillRight.Size = UDim2.fromScale(v2, v1.FillRight.Size.Y.Scale)
    if v1.ReelTitle.Text ~= a3 then
        v1.ReelTitle.Text = a3
    end
    showClicks(v1, a2)
    layoutTitle(v1)
end

function v1.PunchReel() -- Line: 582 -- upvalues: bind (val), punch (val)
    local v1 = bind()
    if v1 then
        punch(v1.Center, 1.25, 0.15)
    end
end

function v1.Reveal(a1, a2) -- Line: 589
    -- upvalues: bind (val), commas (val), u38 (val), TweenService (val), punch (val), GuiService (val)
    -- upvalues: RunService (val)
    local u3 = bind()
    if u3 == nil then
        return
    end
    local v1 = if not (1 < a1.Amount) or string.find(a1.DisplayName, tostring(a1.Amount), 1, true) then "" else ("%*x "):format((commas(a1.Amount)))
    u3.RewardName.Text = ("%*%*"):format(v1, a1.DisplayName)
    u3.Image.Image = if not a1.Icon then "rbxassetid://122321649531761" else if a1.Icon == "" then "rbxassetid://122321649531761" else a1.Icon
    v1 = a1.Kind == "ManorKey"
    local ImageColor3 = u3.Shine.ImageColor3
    local TextColor3 = u3.RewardName.TextColor3
    if v1 then
        u3.Shine.ImageColor3 = u38
        u3.RewardName.TextColor3 = u38
    end
    local u61 = if not v1 then 40 else 120
    u3.Vignette.GroupTransparency = 1
    u3.VignetteGui.Enabled = true
    u3.Reveal.Visible = true
    TweenService:Create(u3.Vignette, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
    punch(u3.Card, 0.4, 0.4)
    punch(u3.Image, 1.5, 0.5)
    local v2 = nil
    if not GuiService.ReducedMotionEnabled then
        v2 = RunService.RenderStepped:Connect(function(a1) -- Line: 616 -- upvalues: u3 (val), u61 (val) -- types: a1: number
            u3.Shine.Rotation = (u3.Shine.Rotation + a1 * u61) % 360
        end)
    end
    task.wait(if not v1 then a2 else a2 + 1.5)
    TweenService:Create(u3.Vignette, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1}):Play()
    local v3 = u3.Card:FindFirstChildOfClass("UIScale")
    if v3 and not GuiService.ReducedMotionEnabled then
        local Back = Enum.EasingStyle.Back
        local new = TweenInfo.new
        TweenService:Create(v3, new(0.25, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0}):Play()
    end
    task.wait(0.3)
    if v2 then
        v2:Disconnect()
    end
    if v3 then
        v3.Scale = 1
    end
    u3.Shine.ImageColor3 = ImageColor3
    u3.RewardName.TextColor3 = TextColor3
    u3.Reveal.Visible = false
    u3.VignetteGui.Enabled = false
end

return (table.freeze(v1))