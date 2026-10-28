-- Script path: ReplicatedStorage.Assets.UI.Npcs.Option_UI.Frame.ImageButton.LocalScript
-- Decompile time: 1.34 ms

local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local Parent = script.Parent.Parent
local UIPadding = Parent.Frame.Text_Element.UIPadding
local ImageLabel = Parent.ImageLabel
local ImageColor3 = ImageLabel.ImageColor3
local u35 = TweenService:Create(UIPadding, v1, {PaddingLeft = UDim.new(0.04, 0)})
local u45 = TweenService:Create(UIPadding, v1, {PaddingLeft = UDim.new(0, 0)})
local u57 = TweenService:Create(ImageLabel, v1, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
local u63 = TweenService:Create(ImageLabel, v1, {ImageColor3 = ImageColor3})
local Hover = SoundService.Hover
script.Parent.MouseEnter:Connect(function() -- Line: 21 -- upvalues: Hover (val), u35 (val), u57 (val)
    Hover.PlaybackSpeed = 1 + math.random(-5, 5) / 100
    Hover.Playing = true
    Hover.TimePosition = 0
    u35:Play()
    u57:Play()
end)
script.Parent.MouseLeave:Connect(function() -- Line: 29 -- upvalues: u45 (val), u63 (val)
    u45:Play()
    u63:Play()
end)