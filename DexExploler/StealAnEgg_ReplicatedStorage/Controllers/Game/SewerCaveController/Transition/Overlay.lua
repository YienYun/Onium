-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Overlay
-- Decompile time: 11.57 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u25 = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
local u31 = Color3.fromRGB(50, 50, 65)
local u36 = Color3.fromRGB(190, 255, 240)
local u41 = Color3.fromRGB(70, 215, 190)
local v1 = {}

local function fill(a1, a2, a3, a4) -- Line: 56 -- types: a1: string, a2: userdata, a3: userdata, a4: number
    local Frame = Instance.new("Frame")
    Frame.Name = a1
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = a3
    Frame.BackgroundTransparency = a4
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.Parent = a2
    return Frame
end

local function streaks(a1, a2) -- Line: 67 -- types: a1: userdata, a2: userdata
    local Frame, UIGradient
    local v1 = {}
    for i = 1, 10 do
        Frame = Instance.new("Frame")
        Frame.Name = "Streak"
        Frame.BorderSizePixel = 0
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.BackgroundColor3 = Color3.fromRGB(225, 255, 248)
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.fromScale(0.2, 0.0065)
        UIGradient = Instance.new("UIGradient")
        UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.55, 0.35),
            (NumberSequenceKeypoint.new(1, 0.9)),
        })
        UIGradient.Parent = Frame
        Frame.Parent = a1
        table.insert(v1, {
            Frame = Frame,
            Angle = (i - 1) / 10 * 3.141592653589793 * 2 + a2:NextNumber(-0.2, 0.2),
            Phase = a2:NextNumber(),
            Speed = a2:NextNumber(1.6, 2.4),
        })
    end
    return v1
end

local function title(a1, a2, a3, a4) -- Line: 95
    -- upvalues: u25 (val)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = a2
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.FontFace = u25
    TextLabel.Text = a3
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = a4
    TextLabel.Parent = a1
    return TextLabel
end

function v1.Build(a1) -- Line: 112 -- upvalues: LocalPlayer (val), streaks (val)
    local v1, v2
    local v3 = a1:Add((Instance.new("ScreenGui")))
    v3.Name = "SewerDrain"
    v3.IgnoreGuiInset = true
    v3.ResetOnSpawn = false
    v3.DisplayOrder = 45
    v3.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v3.Enabled = true
    local v4 = Random.new()
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Caustic"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://18177147504"
    ImageLabel.ImageColor3 = Color3.fromRGB(160, 245, 230)
    ImageLabel.ImageTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Tile
    ImageLabel.TileSize = UDim2.fromScale(0.25, 0.25)
    ImageLabel.Size = UDim2.fromScale(1, 2)
    ImageLabel.Position = UDim2.fromScale(0, -1)
    ImageLabel.Parent = v3
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Vignette"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Image = "rbxassetid://104574024062008"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(2, 16, 20)
    ImageLabel_2.ImageTransparency = 1
    ImageLabel_2.Size = UDim2.fromScale(1, 1)
    ImageLabel_2.Parent = v3
    local Frame = Instance.new("Frame")
    Frame.Name = "Streaks"
    Frame.BackgroundTransparency = 1
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.fromScale(2.2, 2.2)
    Frame.Visible = false
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.Parent = Frame
    Frame.Parent = v3
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Waterline"
    Frame_2.BorderSizePixel = 0
    Frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame_2.Size = UDim2.fromScale(1, 1.25)
    Frame_2.Position = UDim2.fromScale(0, 1)
    Frame_2.Visible = false
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = 90
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 230, 214)),
        ColorSequenceKeypoint.new(0.12, Color3.fromRGB(14, 96, 92)),
        (ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 18, 22))),
    })
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.6),
        NumberSequenceKeypoint.new(0.04, 0.1),
        (NumberSequenceKeypoint.new(1, 0)),
    })
    UIGradient.Parent = Frame_2
    Frame_2.Parent = v3
    local ImageLabel_3 = Instance.new("ImageLabel")
    ImageLabel_3.Name = "Iris"
    ImageLabel_3.BackgroundTransparency = 1
    ImageLabel_3.Image = "rbxassetid://104574024062008"
    ImageLabel_3.ImageColor3 = Color3.new(0, 0, 0)
    ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_3.Size = UDim2.fromScale(3, 3)
    ImageLabel_3.Visible = false
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint_2.AspectRatio = 1
    UIAspectRatioConstraint_2.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint_2.Parent = ImageLabel_3
    for i, j in {
        {
            Anchor = Vector2.new(0.5, 1),
            Position = UDim2.fromScale(0.5, 0.02),
            Size = UDim2.fromScale(200, 100),
        },
        {
            Anchor = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0.98),
            Size = UDim2.fromScale(200, 100),
        },
        {
            Anchor = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(0.02, 0.5),
            Size = UDim2.fromScale(100, 1),
        },
        {
            Anchor = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.98, 0.5),
            Size = UDim2.fromScale(100, 1),
        },
    } do
        v2 = Color3.new(0, 0, 0)
        v1 = Instance.new("Frame")
        v1.Name = "Cover"
        v1.BorderSizePixel = 0
        v1.BackgroundColor3 = v2
        v1.BackgroundTransparency = 0
        v1.Size = UDim2.fromScale(1, 1)
        v1.Parent = ImageLabel_3
        v1.AnchorPoint = j.Anchor
        v1.Position = j.Position
        v1.Size = j.Size
    end
    ImageLabel_3.Parent = v3
    local v5 = Color3.new(0, 0, 0)
    local v6 = Instance.new("Frame")
    v6.Name = "Black"
    v6.BorderSizePixel = 0
    v6.BackgroundColor3 = v5
    v6.BackgroundTransparency = 0
    v6.Size = UDim2.fromScale(1, 1)
    v6.Parent = v3
    v6.Visible = false
    v3.Parent = LocalPlayer:WaitForChild("PlayerGui")
    return {
        Gui = v3,
        Shell = Frame,
        Streaks = streaks(Frame, v4),
        Caustic = ImageLabel,
        Vignette = ImageLabel_2,
        Water = Frame_2,
        Hole = ImageLabel_3,
        Black = v6,
        Random = v4,
    }
end

function v1.Streaks(a1, a2, a3, a4) -- Line: 230 -- types: a1: table, a2: userdata, a3: number, a4: number
    local Frame, v1, v2, v3
    local Shell = a1.Shell
    Shell.Visible = a3 > 0.01
    if not Shell.Visible then
        return
    end
    Shell.Position = UDim2.fromScale(a2.X, a2.Y)
    for i, j in a1.Streaks do
        v3 = (j.Phase + a4 * j.Speed) % 1
        v1 = v3 * 0.38 + 0.06
        v2 = Vector2.new(math.cos(j.Angle), (math.sin(j.Angle)))
        Frame = j.Frame
        Frame.Position = UDim2.fromScale(0.5 + v2.X * v1, 0.5 + v2.Y * v1)
        Frame.Rotation = math.deg(j.Angle)
        Frame.Size = UDim2.fromScale(v3 * 0.16 + 0.08, 0.0065)
        Frame.BackgroundTransparency = 1 - a3 * (1 - v3 * 0.6) * 0.45
    end
end

function v1.Caustic(a1, a2, a3) -- Line: 249 -- types: a1: table, a2: number, a3: number
    local Caustic = a1.Caustic
    Caustic.ImageTransparency = 1 - a2 * 0.14
    Caustic.Position = UDim2.fromScale(math.sin(a3 * 0.4) * 0.03, a3 * 0.18 % 1 + -1)
end

function v1.Vignette(a1, a2) -- Line: 255 -- types: a1: table, a2: number
    a1.Vignette.ImageTransparency = 1 - math.clamp(a2, 0, 1)
end

function v1.Waterline(a1, a2) -- Line: 259 -- types: a1: table, a2: number
    local Water = a1.Water
    Water.Visible = a2 > 0.001
    Water.Position = UDim2.fromScale(0, 1 - a2 * 1.25)
end

function v1.Iris(a1, a2, a3) -- Line: 265 -- types: a1: table, a2: userdata, a3: number
    local Hole = a1.Hole
    local v1 = a3 <= 0.002
    a1.Black.Visible = v1
    Hole.Visible = not v1 and a3 < 0.999
    Hole.Position = UDim2.fromScale(a2.X, a2.Y)
    Hole.Size = UDim2.fromScale(a3 * 3.2, a3 * 3.2)
end

function v1.Drops(a1, a2, a3) -- Line: 274 -- upvalues: TweenService (val) -- types: a1: table, a3: number
    local ImageLabel, ImageLabel_2, UIAspectRatioConstraint, v1, v2, v3, v4, v5
    local Random = a1.Random
    for i = 1, a3 do
        ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Drop"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://7027357365"
        ImageLabel.ImageColor3 = Color3.fromRGB(215, 255, 250)
        ImageLabel.ImageTransparency = 0.86
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        v4 = Random:NextNumber(0.025, 0.045)
        ImageLabel.Size = UDim2.fromScale(v4, v4)
        UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.AspectRatio = 0.72
        UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
        UIAspectRatioConstraint.Parent = ImageLabel
        ImageLabel_2 = Instance.new("ImageLabel")
        ImageLabel_2.Name = "Shine"
        ImageLabel_2.BackgroundTransparency = 1
        ImageLabel_2.Image = "rbxassetid://11909833350"
        ImageLabel_2.ImageColor3 = Color3.new(1, 1, 1)
        ImageLabel_2.ImageTransparency = 0.25
        ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel_2.Position = UDim2.fromScale(0.36, 0.58)
        ImageLabel_2.Size = UDim2.fromScale(0.5, 0.5)
        ImageLabel_2.Parent = ImageLabel
        v5 = Random:NextNumber(0.08, 0.92)
        v1 = Random:NextNumber(0.05, 0.55)
        ImageLabel.Position = UDim2.fromScale(v5, v1)
        ImageLabel.Parent = a1.Gui
        a2:Add(ImageLabel)
        v2 = Random:NextNumber(0.9, 1.4)
        v3 = TweenService:Create(ImageLabel, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1,
            Position = UDim2.fromScale(v5, v1 + Random:NextNumber(0.25, 0.45)),
        })
        v1 = TweenService:Create(ImageLabel_2, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1})
        v3:Play()
        v1:Play()
    end
end

function v1.Card(a1, a2, a3, a4) -- Line: 324
    -- upvalues: u31 (val), u25 (val), u36 (val), u41 (val), TweenService (val)
    local Frame = Instance.new("Frame")
    Frame.Name = "Discovery"
    Frame.BackgroundTransparency = 1
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.17)
    Frame.Size = UDim2.fromScale(0.62, 0.1)
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 8
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.Parent = Frame
    local UIScale = Instance.new("UIScale")
    UIScale.Scale = 0
    UIScale.Parent = Frame
    local v1 = u31
    local u34 = Instance.new("TextLabel")
    u34.Name = "Shadow"
    u34.BackgroundTransparency = 1
    u34.Size = UDim2.fromScale(1, 1)
    u34.FontFace = u25
    u34.Text = a3
    u34.TextScaled = true
    u34.TextColor3 = v1
    u34.Parent = Frame
    u34.Position = UDim2.fromScale(0, 0.07)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = u31
    UIStroke.Thickness = 5
    UIStroke.Parent = u34
    local v2 = Color3.new(1, 1, 1)
    local u60 = Instance.new("TextLabel")
    u60.Name = "Title"
    u60.BackgroundTransparency = 1
    u60.Size = UDim2.fromScale(1, 1)
    u60.FontFace = u25
    u60.Text = a3
    u60.TextScaled = true
    u60.TextColor3 = v2
    u60.Parent = Frame
    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.Color = Color3.new(0, 0, 0)
    UIStroke_2.Thickness = 3
    UIStroke_2.Parent = u60
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = 90
    UIGradient.Color = ColorSequence.new(u36, u41)
    UIGradient.Parent = u60
    Frame.Parent = a1.Gui
    a2:Add(Frame)
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    a2:Add((task.delay(a4 + 0.25, function() -- Line: 360 -- upvalues: TweenService (upval), u60 (val), u34 (val), UIStroke_2 (val), UIStroke (val)
        local v1 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        TweenService:Create(u60, v1, {TextTransparency = 1}):Play()
        TweenService:Create(u34, v1, {TextTransparency = 1}):Play()
        TweenService:Create(UIStroke_2, v1, {Transparency = 1}):Play()
        TweenService:Create(UIStroke, v1, {Transparency = 1}):Play()
    end)))
end

return table.freeze(v1)