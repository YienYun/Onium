-- Script path: ReplicatedStorage.Client.ClientObservers.EasyVisuals
-- Decompile time: 2.12 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EasyVisuals = require(ReplicatedStorage.Client.UI.VFX.EasyVisuals)
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local u19 = {}

local function GetTintGradient(a1) -- Line: 20 -- types: a1: userdata
    local Gradient = a1:FindFirstChild("Gradient")
    if Gradient ~= nil and Gradient:IsA("UIGradient") then
        return Gradient
    end
    return nil
end

local function StartEffect(a1, a2) -- Line: 29 -- upvalues: u19 (val), EasyVisuals (val) -- types: a1: userdata
    if u19[a1] then
        return
    end
    local Attribute = a1:GetAttribute("EasyVisualsPreset")
    if type(Attribute) ~= "string" then
        warn((("%* needs an EasyVisualsPreset attribute"):format((a1:GetFullName()))))
        return
    end
    u19[a1] = true
    local Attribute_2 = a1:GetAttribute("EasyVisualsDrift")
    local Gradient = a1:FindFirstChild("Gradient")
    local v1 = if Gradient == nil then nil else if not Gradient:IsA("UIGradient") then nil else Gradient
    local new = EasyVisuals.new
    local Color = if v1 == nil then nil else v1.Color
    local u68 = new(a1, Attribute, if type(Attribute_2) ~= "number" then nil else Attribute_2, nil, nil, Color)
    if v1 ~= nil then
        local Rotation, Rotation_2
        for i, j in u68.EffectObjects do
            if j.__class == "Gradient" then
                Rotation = v1.Rotation
                Rotation_2 = v1.Rotation
                j:SetRotation(Rotation, Rotation_2)
            end
        end
    end
    a2:Add(function() -- Line: 56 -- upvalues: u19 (upval), a1 (val), u68 (val)
        u19[a1] = nil
        u68:Destroy()
    end)
end

ObserveUITag("EasyVisuals", function(a1, a2, a3) -- Line: 62 -- upvalues: StartEffect (val) -- types: a1: userdata
    if a1:IsA("GuiObject") then
        StartEffect(a1, a3)
        return
    end
    warn((("EasyVisuals tag on %* needs a GuiObject"):format((a1:GetFullName()))))
end)
return nil