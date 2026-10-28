-- Script path: ReplicatedStorage.Client.UI.VFX.SellPayout
-- Decompile time: 10.55 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Hud = require(ReplicatedStorage.Client.Hud)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local OverlayRoot = require(script.Parent.OverlayRoot)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local u38 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Quart = Enum.EasingStyle.Quart
local In = Enum.EasingDirection.In
local u45 = TweenInfo.new(0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u50 = TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u58 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.04)
local u63 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u68 = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u73 = Color3.fromRGB(126, 255, 92)
local u78 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v1 = {}
local u81 = Random.new()

local function money(a1) -- Line: 76 -- upvalues: Simple (val), Numbers (val) -- types: a1: number
    if a1 > 99999 then
        return "$" .. Simple.FormatCompact(math.round(a1), ".#")
    end
    return "$" .. Numbers.AddCommas((math.round(a1)))
end

local function namedScale(a1, a2) -- Line: 83 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    if v1 and v1:IsA("UIScale") then
        return v1
    end
    local UIScale = Instance.new("UIScale")
    UIScale.Name = a2
    UIScale.Parent = a1
    return UIScale
end

local function quadBezier(a1, a2, a3, a4) -- Line: 95 -- types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function playTween(a1, a2, a3) -- Line: 100
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, a2, a3)
    v1:Play()
    return v1
end

local function readout() -- Line: 106 -- upvalues: Hud (val)
    local Money = Hud.Find("Money")
    local MoneyIcon = Hud.Find("MoneyIcon")
    local MoneyValue = Hud.Find("MoneyValue")
    if Money ~= nil and MoneyIcon ~= nil and MoneyValue ~= nil then
        return {Plate = Money, Icon = MoneyIcon, Value = MoneyValue}
    end
    return nil
end

local function iconCenter(a1) -- Line: 116 -- types: a1: userdata
    return a1.AbsolutePosition + a1.AbsoluteSize / 2
end

local function punch(a1, a2) -- Line: 120
    -- upvalues: u45 (val), TweenService (val), u50 (val), u58 (val), u73 (val), u63 (val), u68 (val)
    local v1
    local Plate = a1.Plate
    local Icon = a1.Icon
    local Value = a1.Value
    local v2 = if a2 % 2 ~= 0 then -1 else 1
    local PayoutPunch = Icon:FindFirstChild("PayoutPunch")
    if not PayoutPunch or not PayoutPunch:IsA("UIScale") then
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "PayoutPunch"
        UIScale.Parent = Icon
        v1 = UIScale
    else
        v1 = PayoutPunch
    end
    v1.Scale = 1.32
    TweenService:Create(v1, u45, {Scale = 1}):Play()
    local Attribute = Icon:GetAttribute("PayoutRotation")
    if typeof(Attribute) ~= "number" then
        Icon:SetAttribute("PayoutRotation", Icon.Rotation)
    end
    Icon.Rotation = Attribute + v2 * 14
    TweenService:Create(Icon, u50, {Rotation = Attribute}):Play()
    local v3 = Value:FindFirstChild("PayoutPunch")
    if not v3 or not v3:IsA("UIScale") then
        v3 = Instance.new("UIScale")
        v3.Name = "PayoutPunch"
        v3.Parent = Value
    end
    v3.Scale = 1.16
    TweenService:Create(v1, u58, {Scale = 1}):Play()
    local Attribute_2 = Value:GetAttribute("PayoutColor")
    if typeof(Attribute_2) ~= "Color3" then
        Value:SetAttribute("PayoutColor", Value.TextColor3)
    end
    Value.TextColor3 = u73
    TweenService:Create(Value, u63, {TextColor3 = Attribute_2}):Play()
    local v4 = Plate:FindFirstChild("PayoutShake")
    if not v4 or not v4:IsA("UIScale") then
        v4 = Instance.new("UIScale")
        v4.Name = "PayoutShake"
        v4.Parent = Plate
    end
    v4.Scale = 1.05
    TweenService:Create(v1, u68, {Scale = 1}):Play()
end

local function floatTotal(a1, a2) -- Line: 153
    -- upvalues: Simple (val), Numbers (val), u73 (val), OverlayRoot (val), u78 (val), TweenService (val)
    local Plate = a1.Plate
    local Value = a1.Value
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "PayoutFloater"
    TextLabel.BackgroundTransparency = 1
    local v1 = if not (a2 > 99999) then "$" .. Numbers.AddCommas((math.round(a2))) else "$" .. Simple.FormatCompact(math.round(a2), ".#")
    TextLabel.Text = "+" .. v1
    TextLabel.TextColor3 = u73
    TextLabel.FontFace = Value.FontFace
    TextLabel.TextScaled = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Size = UDim2.fromOffset(Plate.AbsoluteSize.X, Plate.AbsoluteSize.Y * 0.8)
    TextLabel.Position = UDim2.fromOffset(Plate.AbsolutePosition.X, Plate.AbsolutePosition.Y)
    TextLabel.Parent = OverlayRoot()
    local v2 = Instance.new("UIStroke")
    v2.Thickness = 2
    v2.Color = Color3.new(0, 0, 0)
    v2.Parent = TextLabel
    TweenService:Create(TextLabel, u78, {
        TextTransparency = 1,
        Position = UDim2.fromOffset(Plate.AbsolutePosition.X, Plate.AbsolutePosition.Y - Plate.AbsoluteSize.Y * 1.6),
    }):Play()
    local v3 = TweenService:Create(v2, u78, {Transparency = 1})
    v3:Play()
    v3.Completed:Once(function() -- Line: 182 -- upvalues: TextLabel (val)
        TextLabel:Destroy()
    end)
end

local function flyCoin(a1, a2, a3, a4, a5, a6) -- Line: 185
    -- upvalues: OverlayRoot (val), u81 (val), u38 (val), TweenService (val), Quart (val), In (val)
    local Icon = a1.Icon
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Coin"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://119640363267627"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Size = UDim2.fromOffset(a3, a3)
    ImageLabel.Position = UDim2.fromOffset(a2.X, a2.Y)
    ImageLabel.ImageTransparency = 1
    ImageLabel.Parent = OverlayRoot()
    local u42 = a2 + Vector2.new(u81:NextNumber(-46, 46), u81:NextNumber(-46, 27.599999999999998))
    local u46 = Icon.AbsolutePosition + Icon.AbsoluteSize / 2
    local u64 = (u42 + u46) / 2 + Vector2.new(u81:NextNumber(-130, 130), -u81:NextNumber(65, 130))
    local u81_2 = (u81:NextNumber(140, 320)) * (if u81:NextInteger(0, 1) ~= 0 then 1 else -1)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Changed:Connect(function(a1) -- Line: 220
        -- upvalues: ImageLabel (val), u42 (val), u64 (val), u46 (val), u81_2 (val), a3 (val)
        if ImageLabel.Parent == nil then
            return
        end
        local v1 = u42
        local v2 = u64
        local v3 = u46
        local v4 = 1 - a1
        local v5 = v1 * (v4 * v4) + v2 * (v4 * 2 * a1) + v3 * (a1 * a1)
        ImageLabel.Position = UDim2.fromOffset(v5.X, v5.Y)
        ImageLabel.Rotation = u81_2 * a1
        v5 = a3 * (1 - a1 * 0.45)
        ImageLabel.Size = UDim2.fromOffset(v5, v5)
    end)
    task.delay(a4, function() -- Line: 231
        -- upvalues: ImageLabel (val), NumberValue (val), u38 (upval), TweenService (upval), u81 (upval), Quart (upval)
        -- upvalues: In (upval), a6 (val), a5 (val)
        if ImageLabel.Parent == nil then
            NumberValue:Destroy()
            return
        end
        TweenService:Create(ImageLabel, u38, {ImageTransparency = 0}):Play()
        local v1 = NumberValue
        local v2 = TweenInfo.new(0.55 + u81:NextNumber(-0.12, 0.12), Quart, In)
        local v3 = TweenService:Create(v1, v2, {Value = 1})
        v3:Play()
        v3.Completed:Once(function() -- Line: 248 -- upvalues: ImageLabel (upval), NumberValue (upval), a6 (upval), a5 (upval)
            ImageLabel:Destroy()
            NumberValue:Destroy()
            a6(a5)
        end)
    end)
end

function v1.Award(a1, a2) -- Line: 260
    -- upvalues: readout (val), punch (val), Audio (val), floatTotal (val), flyCoin (val)
    local Icon, v1
    if a1 <= 0 then
        return
    end
    local u46 = readout()
    if u46 == nil then
        return
    end
    local v2 = a2 or {}
    local u12 = math.clamp(#v2, 5, 14)
    local v3 = math.clamp(u46.Icon.AbsoluteSize.Y * 0.9, 26, 72)
    local u22 = 0

    local function onArrive(a1_2) -- Line: 277
        -- upvalues: u22 (ref), punch (upval), u46 (val), Audio (upval), u12 (val), floatTotal (upval), a1 (val)
        u22 = u22 + 1
        punch(u46, a1_2)
        Audio.Play("rbxassetid://8807960350", script, {Volume = 0.165, PlaybackSpeed = a1_2 / u12 * 0.5 + 0.95})
        if u22 == u12 then
            Audio.Play("rbxassetid://134810204798705", script, {Volume = 0.49500000000000005})
            floatTotal(u46, a1)
        end
    end

    for i = 1, u12 do
        if not (#v2 > 0) then
            Icon = u46.Icon
            v1 = Icon.AbsolutePosition + Icon.AbsoluteSize / 2
        else
            v1 = v2[(i - 1) % #v2 + 1]
        end
        flyCoin(u46, v1, v3, (i - 1) * 0.045, i, onArrive)
    end
end

return table.freeze(v1)