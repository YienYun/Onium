-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Overlay
-- Decompile time: 2.46 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
return table.freeze({
    Build = function(a1) -- Line: 32 -- upvalues: LocalPlayer (val)
        local v1 = a1:Add((Instance.new("ScreenGui")))
        v1.Name = "ManorDoorOverlay"
        v1.IgnoreGuiInset = true
        v1.ResetOnSpawn = false
        v1.DisplayOrder = 46
        v1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Vignette"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://104574024062008"
        ImageLabel.ImageColor3 = Color3.fromRGB(12, 4, 16)
        ImageLabel.ImageTransparency = 1
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.ZIndex = 1
        ImageLabel.Parent = v1
        local Frame = Instance.new("Frame")
        Frame.Name = "Wash"
        Frame.BorderSizePixel = 0
        Frame.BackgroundColor3 = Color3.new(1, 1, 1)
        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.ZIndex = 3
        Frame.Parent = v1
        local ImageLabel_2 = Instance.new("ImageLabel")
        ImageLabel_2.Name = "Ring"
        ImageLabel_2.BackgroundTransparency = 1
        ImageLabel_2.Image = "rbxassetid://109600784699514"
        ImageLabel_2.ImageColor3 = Color3.fromRGB(255, 236, 210)
        ImageLabel_2.ImageTransparency = 1
        ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel_2.Size = UDim2.fromScale(0.2, 0.2)
        ImageLabel_2.ZIndex = 2
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.AspectRatio = 1
        UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
        UIAspectRatioConstraint.Parent = ImageLabel_2
        ImageLabel_2.Parent = v1
        v1.Parent = LocalPlayer:WaitForChild("PlayerGui")
        return {Gui = v1, Ring = ImageLabel_2, Wash = Frame, Vignette = ImageLabel}
    end,
    Ring = function(a1, a2, a3) -- Line: 80 -- types: a1: table, a2: userdata, a3: number
        local Ring = a1.Ring
        Ring.Position = UDim2.fromScale(a2.X, a2.Y)
        if not (a3 <= 0) and not (a3 >= 1) then
            local v1 = a3 * 1.1 + 0.12
            Ring.Size = UDim2.fromScale(v1, v1)
            Ring.ImageTransparency = a3 * 0.9 + 0.1
            return
        end
        Ring.ImageTransparency = 1
    end,
    Wash = function(a1, a2, a3) -- Line: 92 -- types: a1: table, a2: userdata, a3: number
        a1.Wash.BackgroundColor3 = a2
        a1.Wash.BackgroundTransparency = 1 - math.clamp(a3, 0, 1)
    end,
    Vignette = function(a1, a2) -- Line: 97 -- types: a1: table, a2: number
        a1.Vignette.ImageTransparency = 1 - math.clamp(a2, 0, 1)
    end,
})