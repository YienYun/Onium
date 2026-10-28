-- Script path: ReplicatedStorage.Client.ClientObservers.TextGlitch
-- Decompile time: 17.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local u17 = Color3.fromRGB(255, 242, 255)
local u23 = Color3.fromRGB(217, 166, 255)
local u28 = Color3.fromRGB(168, 85, 247)
local u29 = {}
u29.Chromatic = {
    BurstIntervalMin = 1.2,
    BurstIntervalMax = 3.5,
    BurstDurationMin = 0.12,
    BurstDurationMax = 0.35,
    TickSeconds = 0.03,
    JitterX = 4,
    JitterY = 3,
    RotationJitter = 2,
    ScrambleChance = 0.65,
    MaxScrambledChars = 2,
    GhostName = "GlitchGhost",
    GhostOffset = 3,
    GhostTransparency = 0.25,
    MinimumZIndex = 2,
    FlickerChance = 0.12,
    StrokeFlashChance = 0.5,
    Tears = false,
    GlitchChars = {"#", "%", "&", "$", "@", "/", "\\", "0", "1", "7", "X", "?", "▓", "▒", "░"},
    GhostColors = {Color3.fromRGB(255, 0, 110), (Color3.fromRGB(0, 225, 255))},
    StrokeFlashColors = {
        Color3.fromRGB(0, 229, 255),
        Color3.fromRGB(255, 238, 0),
        (Color3.fromRGB(255, 0, 128)),
    },
}
u29.Rift = {
    BurstIntervalMin = 1.4,
    BurstIntervalMax = 4,
    BurstDurationMin = 0.14,
    BurstDurationMax = 0.4,
    TickSeconds = 0.03,
    JitterX = 4,
    JitterY = 3,
    RotationJitter = 2,
    ScrambleChance = 0.6,
    MaxScrambledChars = 2,
    GhostName = "RiftGhost",
    GhostOffset = 3,
    GhostTransparency = 0.3,
    MinimumZIndex = 3,
    FlickerChance = 0.1,
    StrokeFlashChance = 0.5,
    Tears = true,
    GlitchChars = {"◢", "◣", "◤", "◥", "▲", "▼", "◆", "▓", "▒", "░", "/", "\\", "X", "#", "%"},
    GhostColors = {Color3.fromRGB(240, 183, 255), (Color3.fromRGB(191, 200, 255))},
    StrokeFlashColors = {u23, u28, u17},
}

local function CloneBareLabel(a1, a2) -- Line: 139 -- types: a1: userdata, a2: string
    local v1 = a1:Clone()
    v1:ClearAllChildren()
    for i, j in v1:GetTags() do
        v1:RemoveTag(j)
    end
    v1.Name = a2
    v1.BackgroundTransparency = 1
    return v1
end

local function SplitCharacters(a1) -- Line: 150 -- types: a1: string
    if a1 == "" then
        return {}
    end
    return string.split(a1, "")
end

local function ScrambleText(a1) -- Line: 157 -- types: a1: table
    local v1
    local BaseCharacters = a1.BaseCharacters
    local v2 = #BaseCharacters
    if v2 == 0 then
        return a1.BaseText
    end
    local v3 = table.clone(BaseCharacters)
    local Style = a1.Style
    local Random = a1.Random
    for i = 1, (Random:NextInteger(1, Style.MaxScrambledChars)) do
        v1 = Random:NextInteger(1, v2)
        if v3[v1] ~= " " then
            v3[v1] = Style.GlitchChars[Random:NextInteger(1, #Style.GlitchChars)]
        end
    end
    return table.concat(v3)
end

local function CreateGhosts(a1, a2) -- Line: 175 -- upvalues: CloneBareLabel (val) -- types: a1: table
    local v1
    local Label = a1.Label
    local Style = a1.Style
    for i, j in Style.GhostColors do
        v1 = CloneBareLabel(Label, Style.GhostName)
        a2:Add(v1)
        v1.TextColor3 = j
        v1.TextTransparency = 1
        v1.ZIndex = Label.ZIndex - 1
        v1.Parent = Label.Parent
        table.insert(a1.Ghosts, v1)
    end
end

local function CreateTear(a1, a2) -- Line: 189
    -- upvalues: CloneBareLabel (val), u28 (val), u17 (val), u23 (val)
    local Frame_2, UICorner
    local Label = a1.Label
    local Parent = Label.Parent
    local ZIndex = Label.ZIndex
    local Frame = Instance.new("Frame")
    a2:Add(Frame)
    Frame.Name = "RiftTearTop"
    Frame.BackgroundTransparency = 1
    Frame.ClipsDescendants = true
    Frame.AnchorPoint = Label.AnchorPoint
    Frame.ZIndex = ZIndex
    Frame.Visible = false
    Frame.Parent = Parent
    local v1 = Frame:Clone()
    a2:Add(v1)
    v1.Name = "RiftTearBottom"
    v1.Parent = Parent
    local Stroke = a1.Stroke
    local v2 = CloneBareLabel(Label, "RiftTearTopText")
    local v3 = CloneBareLabel(Label, "RiftTearBottomText")
    local v4 = {v2, v3}
    local v5 = nil
    local v6 = nil
    local v7 = a2
    for i, j in v4, v5, v6 do
        if Stroke ~= nil then
            Stroke:Clone().Parent = j
        end
        j.AnchorPoint = Vector2.zero
        j.ZIndex = ZIndex
    end
    v2.Position = UDim2.fromScale(0, 0)
    v2.Parent = Frame
    v3.Parent = v1
    local v8 = Instance.new("Frame")
    v7:Add(v8)
    v8.Name = "RiftSeamGlow"
    v8.BorderSizePixel = 0
    v8.BackgroundColor3 = u28
    v8.BackgroundTransparency = 0.72
    v8.AnchorPoint = Vector2.new(0.5, 0.5)
    v8.ZIndex = ZIndex + 1
    v8.Visible = false
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    UIGradient.Parent = v8
    v8.Parent = Parent
    v4 = v8:Clone()
    v7:Add(v4)
    v4.Name = "RiftSeamCore"
    v4.BackgroundColor3 = u17
    v4.BackgroundTransparency = 0.05
    v4.ZIndex = ZIndex + 2
    v4.Parent = Parent
    v5 = table.create(7)
    for k = 1, 7 do
        Frame_2 = Instance.new("Frame")
        v7:Add(Frame_2)
        Frame_2.Name = "RiftShard"
        Frame_2.BorderSizePixel = 0
        Frame_2.BackgroundColor3 = if k % 2 ~= 0 then u17 else u23
        Frame_2.BackgroundTransparency = 1
        Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame_2.ZIndex = ZIndex + 2
        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 1)
        UICorner.Parent = Frame_2
        Frame_2.Parent = Parent
        table.insert(v5, Frame_2)
    end
    return {
        TopClip = Frame,
        BottomClip = v1,
        TopText = v2,
        BottomText = v3,
        SeamGlow = v8,
        SeamCore = v4,
        Shards = v5,
        BottomBase = UDim2.new(),
        SeamPosition = UDim2.new(),
        LabelWidth = UDim.new(),
        GlowColor = u28,
    }
end

local function SetGhostTransparency(a1, a2) -- Line: 282 -- types: a1: table, a2: number
    for i, j in a1.Ghosts do
        j.TextTransparency = a2
    end
end

local function MoveGhosts(a1, a2, a3, a4, a5) -- Line: 288
    -- upvalues: 
    local BasePosition, fromOffset, v1, v2, v3
    local Style = a1.Style
    local v4 = nil
    local v5 = nil
    for i, j in a1.Ghosts, v4, v5 do
        v1 = if i ~= 1 then -1 else 1
        j.Text = v6
        j.Rotation = v7
        BasePosition = v8.BasePosition
        fromOffset = UDim2.fromOffset
        v2 = v9 + v1 * Style.GhostOffset
        v3 = Style.GhostOffset / 2
        j.Position = BasePosition + fromOffset(v2, v10 + v1 * math.ceil(v3))
    end
end

local function PrepareTear(a1, a2, a3) -- Line: 303 -- types: a1: table, a2: table, a3: number
    local Label = a1.Label
    local Size = Label.Size
    local BasePosition = a1.BasePosition
    local v1 = 1 - a3
    local v2 = UDim2.new(0, 0, Size.Y.Scale * a3, Size.Y.Offset * a3)
    local v3 = BasePosition + UDim2.new(Size.X.Scale * 0.5, Size.X.Offset * 0.5, 0, 0) + v2
    a2.TopClip.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * a3, Size.Y.Offset * a3)
    a2.TopText.Size = UDim2.fromScale(1, 1 / a3)
    a2.BottomClip.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * v1, Size.Y.Offset * v1)
    a2.BottomText.Size = UDim2.fromScale(1, 1 / v1)
    a2.BottomText.Position = UDim2.fromScale(0, -a3 / v1)
    a2.BottomBase = BasePosition + v2
    a2.SeamPosition = v3
    a2.LabelWidth = Size.X
    a2.SeamGlow.Position = v3
    a2.SeamGlow.Size = UDim2.new(Size.X.Scale * 1.1, Size.X.Offset * 1.1, 0, 10)
    a2.SeamCore.Position = v3
    Label.TextTransparency = 1
    a2.TopClip.Visible = true
    a2.BottomClip.Visible = true
    a2.SeamGlow.Visible = true
    a2.SeamCore.Visible = true
end

local function MoveTear(a1, a2, a3, a4, a5, a6) -- Line: 333
    -- upvalues: 
    a2.TopClip.Position = a1.BasePosition + UDim2.fromOffset(a3, -a4)
    a2.TopClip.Rotation = a6
    a2.TopText.Text = a5
    a2.BottomClip.Position = a2.BottomBase + UDim2.fromOffset(-a3, a4)
    a2.BottomClip.Rotation = a6
    a2.BottomText.Text = a5
end

local function FlareSeam(a1, a2) -- Line: 342 -- upvalues: u23 (val), u28 (val) -- types: a1: table, a2: number
    local v1 = if not (a2 > 0.5) then u28 else u23
    a1.SeamGlow.BackgroundTransparency = (1 - a2) * 0.25 + 0.6
    if v1 ~= a1.GlowColor then
        a1.GlowColor = v1
        a1.SeamGlow.BackgroundColor3 = v1
    end
    local LabelWidth = a1.LabelWidth
    a1.SeamCore.Size = UDim2.new(LabelWidth.Scale * (a2 * 0.3 + 0.75), LabelWidth.Offset, 0, 2)
end

local function ShowShards(a1, a2, a3) -- Line: 353 -- types: a1: table, a2: table, a3: number
    local fromOffset, v1, v2, v3, v4, v5
    local v6 = nil
    local v7 = nil
    for i, j in a2.Shards, v6, v7 do
        v5 = i * 7919 % 97 / 97
        v1 = if i % 2 ~= 0 then -1 else 1
        v2 = v8.Random:NextInteger(3, 9)
        j.Size = UDim2.fromOffset(v2, v2)
        j.Rotation = v5 * 360 + v9 * 180 * v1
        fromOffset = UDim2.fromOffset
        v3 = (v5 - 0.5) * 2 * 34 * v9
        v4 = v1 * 22 * v9
        j.Position = a2.SeamPosition + fromOffset(v3, v4 * (v5 * 0.6 + 0.4))
        j.BackgroundTransparency = math.clamp(v9, 0, 1)
    end
end

local function HideTear(a1) -- Line: 371 -- types: a1: table
    a1.TopClip.Visible = false
    a1.BottomClip.Visible = false
    a1.SeamGlow.Visible = false
    a1.SeamCore.Visible = false
    for i, j in a1.Shards do
        j.BackgroundTransparency = 1
    end
end

local function RestoreLabel(a1) -- Line: 381 -- types: a1: table
    local Label = a1.Label
    local Stroke = a1.Stroke
    local Gradient = a1.Gradient
    Label.Text = a1.BaseText
    Label.Position = a1.BasePosition
    Label.Rotation = a1.BaseRotation
    Label.TextTransparency = a1.BaseTransparency
    if Stroke ~= nil then
        Stroke.Color = a1.BaseStrokeColor
    end
    if Gradient ~= nil then
        Gradient.Offset = a1.BaseGradientOffset
    end
end

local function AdoptCaption(a1) -- Line: 398 -- types: a1: table
    local Text = a1.Label.Text
    if Text ~= a1.BaseText then
        a1.BaseText = Text
        a1.BaseCharacters = if Text ~= "" then string.split(Text, "") else {}
    end
end

local function RunBurst(a1) -- Line: 406
    -- upvalues: PrepareTear (val), ScrambleText (val), MoveTear (val), FlareSeam (val), MoveGhosts (val)
    -- upvalues: ShowShards (val)
    local BaseStrokeColor, BaseText, v1, v2
    local Label = a1.Label
    local Style = a1.Style
    local Random = a1.Random
    local Tear = a1.Tear
    local Stroke = a1.Stroke
    local Gradient = a1.Gradient
    local v3 = Random:NextNumber(Style.BurstDurationMin, Style.BurstDurationMax)
    local v4 = Random:NextNumber(0.38, 0.62)
    local v5 = 0
    local Text = a1.Label.Text
    if Text ~= a1.BaseText then
        a1.BaseText = Text
        a1.BaseCharacters = if Text ~= "" then string.split(Text, "") else {}
    end
    a1.IsBursting = true
    if Tear ~= nil then
        PrepareTear(a1, Tear, v4)
    end
    local v6 = nil
    for i, j in a1.Ghosts, v6 do
        j.TextTransparency = Style.GhostTransparency
    end
    while v5 < v3 do
        if not a1.IsRunning then
            return
        end
        v4 = math.clamp(v5 / v3, 0, 1)
        v1 = Random:NextInteger(-Style.JitterX, Style.JitterX)
        v2 = Random:NextInteger(-Style.JitterY, Style.JitterY)
        v6 = a1.BaseRotation + Random:NextNumber(-Style.RotationJitter, Style.RotationJitter)
        BaseText = if not ((Random:NextNumber()) < Style.ScrambleChance) then a1.BaseText else ScrambleText(a1)
        Label.Position = a1.BasePosition + UDim2.fromOffset(v1, v2)
        Label.Rotation = v6
        Label.Text = BaseText
        if Tear == nil then
            Label.TextTransparency = if not ((Random:NextNumber()) < Style.FlickerChance) then a1.BaseTransparency else 1
        else
            MoveTear(a1, Tear, Random:NextInteger(3, 12), Random:NextInteger(0, 5), BaseText, v6)
            FlareSeam(Tear, Random:NextNumber())
        end
        if Stroke ~= nil then
            BaseStrokeColor = if not ((Random:NextNumber()) < Style.StrokeFlashChance) then a1.BaseStrokeColor else Style.StrokeFlashColors[Random:NextInteger(1, #Style.StrokeFlashColors)]
            Stroke.Color = BaseStrokeColor
        end
        if Gradient ~= nil then
            Gradient.Offset = Vector2.new(Random:NextNumber(-0.5, 0.5), 0)
        end
        MoveGhosts(a1, v1, v2, BaseText, v6)
        if Tear ~= nil then
            ShowShards(a1, Tear, v4)
        end
        v5 = v5 + task.wait(Style.TickSeconds)
    end
    if a1.IsRunning then
        local Label_2 = a1.Label
        local Stroke_2 = a1.Stroke
        local Gradient_2 = a1.Gradient
        Label_2.Text = a1.BaseText
        Label_2.Position = a1.BasePosition
        Label_2.Rotation = a1.BaseRotation
        Label_2.TextTransparency = a1.BaseTransparency
        if Stroke_2 ~= nil then
            Stroke_2.Color = a1.BaseStrokeColor
        end
        if Gradient_2 ~= nil then
            Gradient_2.Offset = a1.BaseGradientOffset
        end
        for k, n in a1.Ghosts do
            n.TextTransparency = 1
        end
        if Tear ~= nil then
            Tear.TopClip.Visible = false
            Tear.BottomClip.Visible = false
            Tear.SeamGlow.Visible = false
            Tear.SeamCore.Visible = false
            for m, i5 in Tear.Shards do
                i5.BackgroundTransparency = 1
            end
        end
        a1.IsBursting = false
    end
end

local function StartGlitch(a1, a2) -- Line: 474
    -- upvalues: u29 (val), CreateTear (val), CreateGhosts (val), RunBurst (val)
    local Attribute = a1:GetAttribute("GlitchStyle")
    local u14 = u29[if type(Attribute) ~= "string" then "Chromatic" else Attribute]
    if u14 == nil then
        warn((("%* has an unknown GlitchStyle %*"):format(a1:GetFullName(), Attribute)))
        return
    end
    local v1 = a1:FindFirstChildOfClass("UIStroke")
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    local ZIndex = a1.ZIndex
    a1.ZIndex = math.max(ZIndex, u14.MinimumZIndex)
    local u41 = {IsBursting = false, IsRunning = true, Label = a1, Style = u14}
    u41.Random = Random.new()
    u41.BaseText = a1.Text
    local Text = a1.Text
    u41.BaseCharacters = if Text ~= "" then string.split(Text, "") else {}
    u41.BasePosition = a1.Position
    u41.BaseRotation = a1.Rotation
    u41.BaseTransparency = a1.TextTransparency
    u41.Stroke = v1
    local Color = if v1 == nil then Color3.new() else v1.Color
    u41.BaseStrokeColor = Color
    u41.Gradient = UIGradient
    u41.BaseGradientOffset = if UIGradient == nil then Vector2.zero else UIGradient.Offset
    u41.Ghosts = {}
    a2:Add(function() -- Line: 505 -- upvalues: u41 (val), a1 (val), ZIndex (val)
        u41.IsRunning = false
        if u41.IsBursting then
            local v1 = u41
            local Label = v1.Label
            local Stroke = v1.Stroke
            local Gradient = v1.Gradient
            Label.Text = v1.BaseText
            Label.Position = v1.BasePosition
            Label.Rotation = v1.BaseRotation
            Label.TextTransparency = v1.BaseTransparency
            if Stroke ~= nil then
                Stroke.Color = v1.BaseStrokeColor
            end
            if Gradient ~= nil then
                Gradient.Offset = v1.BaseGradientOffset
            end
        end
        a1.ZIndex = ZIndex
    end)
    if u14.Tears then
        u41.Tear = CreateTear(u41, a2)
    end
    CreateGhosts(u41, a2)
    task.spawn(function() -- Line: 518 -- upvalues: u41 (val), u14 (val), RunBurst (upval)
        while u41.IsRunning do
            task.wait(u41.Random:NextNumber(u14.BurstIntervalMin, u14.BurstIntervalMax))
            if not u41.IsRunning then
                break
            end
            RunBurst(u41)
        end
    end)
end

ObserveUITag("TextGlitch", function(a1, a2) -- Line: 529 -- upvalues: StartGlitch (val) -- types: a1: userdata
    if a1:IsA("TextLabel") then
        StartGlitch(a1, a2)
        return
    end
    warn((("TextGlitch tag on %* needs a TextLabel"):format((a1:GetFullName()))))
end)
return nil