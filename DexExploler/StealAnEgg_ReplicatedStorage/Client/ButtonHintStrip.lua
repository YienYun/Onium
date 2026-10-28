-- Script path: ReplicatedStorage.Client.ButtonHintStrip
-- Decompile time: 8.09 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local t = require(ReplicatedStorage.Packages.t)
local u29 = Vector2.new(0, 1)
local u33 = Vector2.new(1, 1)
local u37 = UDim2.fromScale(0.335, 0.965)
local v1 = UDim2.fromScale(0.085, 0.15)
local u46 = Color3.fromRGB(255, 255, 255)
local u51 = Color3.fromRGB(15, 15, 20)
local v2 = {}
local u55 = t.strict(t.string)
local u58 = Log.new()
local v3 = GUI.PlayerGui()
local u62 = {}
local u63 = 0
local u64 = 0
local u65 = nil
local u66 = nil

local function build(a1, a2, a3) -- Line: 51 -- types: a1: string, a2: userdata?, a3: table
    local v1 = Instance.new(a1)
    for i, j in a3 do
        v1[i] = j
    end
    v1.Parent = a2
    return v1
end

local v4 = {
    DisplayOrder = 5,
    Name = "ActionPrompts",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}
local u73 = Instance.new("ScreenGui")
for i, j in v4 do
    u73[i] = j
end
u73.Parent = nil
local v5 = {
    BackgroundTransparency = 1,
    Name = "Holder",
    Visible = false,
    AnchorPoint = u29,
    AutomaticSize = Enum.AutomaticSize.X,
    Position = u37,
    Size = UDim2.new(0, 0, v1.Y.Scale, 0),
}
local u101 = Instance.new("Frame")
for k, n in v5 do
    u101[k] = n
end
u101.Parent = u73
v5 = {
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    Padding = UDim.new(0.06, 0),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
}
v1 = Instance.new("UIListLayout")
for m, i5 in v5 do
    v1[m] = i5
end
v1.Parent = u101
u73.Parent = v3

local function paint(a1) -- Line: 87 -- upvalues: InputIconsConfig (val) -- types: a1: table
    local v1 = if not a1.key then nil else InputIconsConfig.Image(a1.key)
    a1.glyph.Image = v1 or ""
    a1.glyph.Visible = v1 ~= nil
    local text = a1.text
    local caption_2 = if not a1.key or v1 then a1.caption else ("%*: %*"):format(if a1.key ~= Enum.KeyCode.ButtonR3 then a1.key.Name else "Press right stick", a1.caption)
    text.Text = caption_2
end

local function republish() -- Line: 96
    -- upvalues: u101 (val), PlatformController (val), u62 (val), u64 (ref), paint (val)
    local v1 = PlatformController.IsConsole()
    if v1 then
        v1 = false
        if next(u62) ~= nil then
            v1 = u64 == 0
        end
    end
    u101.Visible = v1
    for i, j in u62 do
        paint(j)
    end
end

local function reposition() -- Line: 105 -- upvalues: u29 (val), u37 (val), u65 (ref), u66 (ref), u33 (val), u101 (val)
    local v1 = u29
    local v2 = u37
    if u65 ~= nil then
        v2 = UDim2.fromScale(u65, u37.Y.Scale)
    elseif u66 ~= nil then
        v1 = u33
        v2 = UDim2.fromScale(u66, u37.Y.Scale)
    end
    u101.AnchorPoint = v1
    u101.Position = v2
end

local function mint(a1, a2) -- Line: 117 -- upvalues: u63 (ref), u46 (val), u51 (val), u101 (val) -- types: a2: string
    u63 = u63 + 1
    local v1 = {
        BackgroundTransparency = 1,
        Name = "Prompt",
        AutomaticSize = Enum.AutomaticSize.X,
        LayoutOrder = u63,
        Size = UDim2.new(0, 0, 0.26, 0),
    }
    local v2 = Instance.new("Frame")
    for i, j in v1 do
        v2[i] = j
    end
    v2.Parent = nil
    v1 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }
    local UIListLayout = Instance.new("UIListLayout")
    for k, n in v1 do
        UIListLayout[k] = n
    end
    UIListLayout.Parent = v2
    local v3 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Name = "Icon",
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    v1 = Instance.new("ImageLabel")
    for m, i5 in v3 do
        v1[m] = i5
    end
    v1.Parent = v2
    local v4 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Name = "Label",
        TextSize = 18,
        AutomaticSize = Enum.AutomaticSize.X,
        Font = Enum.Font.GothamBold,
        Size = UDim2.new(0, 0, 0.58, 0),
        TextColor3 = u46,
        TextXAlignment = Enum.TextXAlignment.Left,
    }
    v3 = Instance.new("TextLabel")
    for i6, i7 in v4 do
        v3[i6] = i7
    end
    v3.Parent = v2
    v4 = {Thickness = 2.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual, Color = u51}
    local UIStroke = Instance.new("UIStroke")
    for i8, i9 in v4 do
        UIStroke[i8] = i9
    end
    UIStroke.Parent = v3
    v2.Parent = u101
    return {
        key = a1,
        caption = a2,
        row = v2,
        glyph = v1,
        text = v3,
    }
end

function v2.Present(a1, a2, a3) -- Line: 167
    -- upvalues: u55 (val), u62 (val), mint (val), paint (val), republish (val), u58 (val), PlatformController (val)
    u55(a1)
    u55(a3)
    local v1 = ("hint %* was handed a %* where a KeyCode belongs"):format(a1, (typeof(a2)))
    assert(typeof(a2) == "EnumItem", v1)
    local v2 = u62[a1]
    if v2 ~= nil and v2.key == a2 and v2.caption == a3 then
        return
    end
    if v2 ~= nil then
        v2.key = a2
        v2.caption = a3
    else
        u62[a1] = (mint(a2, a3))
    end
    paint(v2)
    republish()
    ;(u58:AtDebug()):Log((("hint %* now reads %* off %*; gamepad %*, glyph %*"):format(a1, a3, a2.Name, PlatformController.IsConsole(), v2.glyph.Image)))
end

function v2.PresentStatus(a1, a2) -- Line: 192
    -- upvalues: u62 (val), mint (val), paint (val), republish (val)
    local v1 = u62[a1]
    if v1 and v1.caption == a2 then
        return
    end
    if v1 then
        v1.caption = a2
    else
        u62[a1] = (mint(nil, a2))
    end
    paint(v1)
    republish()
end

function v2.SetNavigationLayer(a1) -- Line: 205 -- upvalues: u73 (val) -- types: a1: number?
    u73.DisplayOrder = if not a1 then 5 else math.max(5, a1 + 1)
end

function v2.Retract(a1) -- Line: 209 -- upvalues: u55 (val), u62 (val), republish (val) -- types: a1: string
    u55(a1)
    local v1 = u62[a1]
    if v1 == nil then
        return
    end
    u62[a1] = nil
    v1.row:Destroy()
    republish()
end

function v2.IsPresent(a1) -- Line: 222 -- upvalues: u55 (val), u62 (val) -- types: a1: string
    u55(a1)
    return u62[a1] ~= nil
end

function v2.Hide() -- Line: 228 -- upvalues: u64 (ref), republish (val)
    u64 = u64 + 1
    republish()
    local u4 = false
    return function() -- Line: 232 -- upvalues: u4 (ref), u64 (upval), republish (upval)
        if u4 then
            return
        end
        u4 = true
        u64 = u64 - 1
        republish()
    end
end

function v2.PinLeft(a1) -- Line: 242
    -- upvalues: u65 (ref), u29 (val), u37 (val), u66 (ref), u33 (val), u101 (val)
    u65 = a1
    local v1 = u29
    local v2 = u37
    if u65 ~= nil then
        v2 = UDim2.fromScale(u65, u37.Y.Scale)
    elseif u66 ~= nil then
        v1 = u33
        v2 = UDim2.fromScale(u66, u37.Y.Scale)
    end
    u101.AnchorPoint = v1
    u101.Position = v2
end

function v2.PinRight(a1) -- Line: 247
    -- upvalues: u66 (ref), u29 (val), u37 (val), u65 (ref), u33 (val), u101 (val)
    u66 = a1
    local v1 = u29
    local v2 = u37
    if u65 ~= nil then
        v2 = UDim2.fromScale(u65, u37.Y.Scale)
    elseif u66 ~= nil then
        v1 = u33
        v2 = UDim2.fromScale(u66, u37.Y.Scale)
    end
    u101.AnchorPoint = v1
    u101.Position = v2
end

PlatformController.Changed:Connect(republish)
InputIconsConfig.Changed:Connect(republish)
republish()
return v2