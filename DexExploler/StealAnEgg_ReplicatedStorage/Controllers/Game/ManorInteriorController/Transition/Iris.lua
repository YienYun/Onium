-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Transition.Iris
-- Decompile time: 10.75 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u40 = Color3.fromRGB(10, 4, 14)
local u44 = Vector2.new(0.5, 0.4)
local u49 = Color3.fromRGB(255, 214, 170)
local u92 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(186, 92, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 120, 60)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 190, 90)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(150, 70, 255)),
    (ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 92, 255))),
})
local u93 = nil
local v1 = {}

local function edge(a1, a2) -- Line: 71 -- upvalues: u40 (val) -- types: a1: userdata, a2: string
    local Frame = Instance.new("Frame")
    Frame.Name = a2
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = u40
    Frame.Size = UDim2.fromScale(0, 0)
    Frame.ZIndex = 1
    Frame.Parent = a1
    return Frame
end

local function aspect() -- Line: 82 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    local ViewportSize = if CurrentCamera == nil then Vector2.new(16, 9) else CurrentCamera.ViewportSize
    if 0 < ViewportSize.Y then
        return ViewportSize.X / ViewportSize.Y
    end
    return 1.7777777777777777
end

local function openHeight(a1) -- Line: 88 -- types: a1: number
    return math.sqrt(a1 * a1 + 1) * 0.54 / 0.15
end

local function sweepHud(a1, a2) -- Line: 92 -- upvalues: LocalPlayer (val) -- types: a1: table, a2: table
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui == nil then
        return
    end
    for i, j in PlayerGui:GetChildren() do
        if j:IsA("ScreenGui") and j ~= a1.Gui and j.Enabled then
            j.Enabled = false
            table.insert(a2, j)
        end
    end
end

local function hideHud(a1) -- Line: 105 -- upvalues: sweepHud (val) -- types: a1: table
    local u1 = {}
    a1.Hidden = u1
    sweepHud(a1, u1)
    a1.Trove:Add(function() -- Line: 109 -- upvalues: u1 (val)
        for i, j in u1 do
            if j.Parent ~= nil then
                j.Enabled = true
            end
        end
    end)
end

local function layout(a1) -- Line: 118
    -- upvalues: sweepHud (val), hideHud (val), Workspace (val), u44 (val), u49 (val)
    local v1
    local Value = a1.Value
    local Hidden = a1.Hidden
    if Hidden ~= nil then
        sweepHud(a1, Hidden)
    elseif Value < 0.999 then
        hideHud(a1)
    end
    local CurrentCamera = Workspace.CurrentCamera
    local ViewportSize = if CurrentCamera == nil then Vector2.new(16, 9) else CurrentCamera.ViewportSize
    local v2 = if not (0 < ViewportSize.Y) then 1.7777777777777777 else ViewportSize.X / ViewportSize.Y
    local v3 = 0
    if Value > 0 then
        v3 = (math.sqrt(v2 * v2 + 1) * 0.54 / 0.15 / 0.035) ^ Value * 0.035
        if Value < 0.06 then
            v3 = v3 * (Value / 0.06)
        end
    end
    local v4 = v3 / v2
    v2 = 0.5 - v4 * u44.X
    local v5 = 0.5 - v3 * u44.Y
    local v6 = {a1.Mask, a1.Glow}
    local v7 = nil
    local v8 = nil
    local v9 = a1
    for i, j in v6, v7, v8 do
        j.Size = UDim2.fromScale(v4, v3)
        v1 = v3 > 0
        j.Visible = v1
    end
    local Edges = v9.Edges
    v6 = math.clamp(v2 + 0.002, 0, 1)
    v2 = math.clamp(v2 + v4 - 0.002, 0, 1)
    local v10 = math.clamp(v5 + 0.002, 0, 1)
    v5 = math.clamp(v5 + v3 - 0.002, 0, 1)
    if v3 <= 0 then
        v6 = 0.5
        v2 = 0.5
        v10 = 0.5
        v5 = 0.5
    end
    Edges[1].Position = UDim2.fromScale(0, 0)
    Edges[1].Size = UDim2.fromScale(v6, 1)
    Edges[2].Position = UDim2.fromScale(v2, 0)
    Edges[2].Size = UDim2.fromScale(1 - v2, 1)
    Edges[3].Position = UDim2.fromScale(v6, 0)
    Edges[3].Size = UDim2.fromScale(v2 - v6, v10)
    Edges[4].Position = UDim2.fromScale(v6, v5)
    Edges[4].Size = UDim2.fromScale(v2 - v6, 1 - v5)
    v6 = 1 - Value
    local v11 = 0.85 + math.noise(v9.Clock * 9, 0.4) * 0.3
    v10 = math.clamp(v6 * 1.6, 0, 1) * v11
    v9.Glow.ImageTransparency = 1 - math.clamp(v10, 0, 1)
    v9.Gradient.Rotation = if not v9.Calm then v9.Spin else 0
    v11 = math.clamp(v6 * 1.4, 0, 1)
    v9.Grade.TintColor = (Color3.new(1, 1, 1)):Lerp(u49, v11)
    v9.Grade.Brightness = v11 * 0.06
    v9.Grade.Contrast = v11 * 0.1
    v9.Bloom.Intensity = v11 * 0.8
end

local function destroy(a1) -- Line: 172 -- upvalues: u93 (ref) -- types: a1: table
    if u93 == a1 then
        u93 = nil
    end
    a1.Trove:Destroy()
end

local function build() -- Line: 179
    -- upvalues: Trove (val), u44 (val), u92 (val), u40 (val), Workspace (val), GuiService (val), RunService (val)
    -- upvalues: TweenService (val), layout (val), u93 (ref), LocalPlayer (val)
    local v1 = Trove.new()
    local v2 = v1:Add((Instance.new("ScreenGui")))
    v2.Name = "ManorIris"
    v2.IgnoreGuiInset = true
    v2.ResetOnSpawn = false
    v2.DisplayOrder = 1100
    v2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Mask"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://79612262551499"
    ImageLabel.AnchorPoint = u44
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel.ZIndex = 2
    ImageLabel.Parent = v2
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Glow"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Image = "rbxassetid://122134504251595"
    ImageLabel_2.AnchorPoint = u44
    ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel_2.ImageTransparency = 1
    ImageLabel_2.ZIndex = 3
    ImageLabel_2.Parent = v2
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = u92
    UIGradient.Parent = ImageLabel_2
    local v3 = {}
    local Frame = Instance.new("Frame")
    Frame.Name = "Left"
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = u40
    Frame.Size = UDim2.fromScale(0, 0)
    Frame.ZIndex = 1
    Frame.Parent = v2
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Right"
    Frame_2.BorderSizePixel = 0
    Frame_2.BackgroundColor3 = u40
    Frame_2.Size = UDim2.fromScale(0, 0)
    Frame_2.ZIndex = 1
    Frame_2.Parent = v2
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "Top"
    Frame_3.BorderSizePixel = 0
    Frame_3.BackgroundColor3 = u40
    Frame_3.Size = UDim2.fromScale(0, 0)
    Frame_3.ZIndex = 1
    Frame_3.Parent = v2
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "Bottom"
    Frame_4.BorderSizePixel = 0
    Frame_4.BackgroundColor3 = u40
    Frame_4.Size = UDim2.fromScale(0, 0)
    Frame_4.ZIndex = 1
    Frame_4.Parent = v2
    v3[1] = Frame
    v3[2] = Frame_2
    v3[3] = Frame_3
    v3[4] = Frame_4
    local CurrentCamera = Workspace.CurrentCamera
    local v4 = v1:Add((Instance.new("ColorCorrectionEffect")))
    v4.Name = "ManorIris"
    v4.Parent = CurrentCamera
    local v5 = v1:Add((Instance.new("BloomEffect")))
    v5.Name = "ManorIris"
    v5.Intensity = 0
    v5.Size = 36
    v5.Threshold = 0.85
    v5.Parent = CurrentCamera
    local u107 = {
        From = 1,
        To = 1,
        Value = 1,
        Elapsed = 0,
        Seconds = 0,
        Spin = 0,
        Clock = 0,
        Trove = v1,
        Gui = v2,
        Mask = ImageLabel,
        Glow = ImageLabel_2,
        Gradient = UIGradient,
        Edges = v3,
        Grade = v4,
        Bloom = v5,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.Out,
        Calm = GuiService.ReducedMotionEnabled,
    }
    v1:Connect(RunService.RenderStepped, function(a1) -- Line: 243
        -- upvalues: u107 (val), TweenService (upval), layout (upval), u93 (upval)
        local v1 = u107
        v1.Clock = v1.Clock + a1
        v1 = u107
        v1.Elapsed = v1.Elapsed + a1
        u107.Spin = (u107.Spin + a1 * 160) % 360
        v1 = if not (0 < u107.Seconds) then 1 else math.clamp(u107.Elapsed / u107.Seconds, 0, 1)
        local Value = TweenService:GetValue(v1, u107.Style, u107.Direction)
        u107.Value = u107.From + (u107.To - u107.From) * Value
        layout(u107)
        if v1 >= 1 and 1 <= u107.To then
            local v2 = u107
            if u93 == v2 then
                u93 = nil
            end
            v2.Trove:Destroy()
        end
    end)
    layout(u107)
    v2.Parent = LocalPlayer:WaitForChild("PlayerGui")
    return u107
end

local function move(a1, a2, a3, a4) -- Line: 262 -- upvalues: u93 (ref), build (val) -- types: a1: number, a2: number
    local v1 = u93
    if v1 == nil then
        if a1 >= 1 then
            return
        end
        build()
    end
    local v2 = v1
    v2.From = v2.Value
    v2.To = a1
    v2.Elapsed = 0
    v2.Seconds = a2
    v2.Style = a3
    v2.Direction = a4
end

function v1.Close(a1) -- Line: 289 -- upvalues: u93 (ref), build (val) -- types: a1: number
    local Quad = Enum.EasingStyle.Quad
    local In = Enum.EasingDirection.In
    local v1 = u93
    if v1 == nil then
        build()
    end
    local v2 = v1
    v2.From = v2.Value
    v2.To = 0
    v2.Elapsed = 0
    v2.Seconds = a1
    v2.Style = Quad
    v2.Direction = In
end

function v1.Open(a1) -- Line: 293 -- upvalues: u93 (ref) -- types: a1: number
    local Quad = Enum.EasingStyle.Quad
    local Out = Enum.EasingDirection.Out
    local v1 = u93
    if v1 == nil then
        return
    end
    local v2 = v1
    v2.From = v2.Value
    v2.To = 1
    v2.Elapsed = 0
    v2.Seconds = a1
    v2.Style = Quad
    v2.Direction = Out
end

function v1.Shut() -- Line: 297 -- upvalues: u93 (ref), build (val)
    local Linear = Enum.EasingStyle.Linear
    local Out = Enum.EasingDirection.Out
    local v1 = u93
    if v1 == nil then
        build()
    end
    local v2 = v1
    v2.From = v2.Value
    v2.To = 0
    v2.Elapsed = 0
    v2.Seconds = 0
    v2.Style = Linear
    v2.Direction = Out
end

function v1.Clear() -- Line: 301 -- upvalues: u93 (ref)
    local v1 = u93
    if v1 ~= nil then
        if u93 == v1 then
            u93 = nil
        end
        v1.Trove:Destroy()
    end
end

function v1.Closed() -- Line: 308 -- upvalues: u93 (ref)
    local v1 = u93
    local v2 = false
    if v1 ~= nil then
        v2 = v1.Value <= 0
    end
    return v2
end

return (table.freeze(v1))