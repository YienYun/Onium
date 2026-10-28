-- Script path: ReplicatedStorage.Client.UI.VFX.OverlayRoot
-- Decompile time: 1.86 ms

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local u10 = {displayOrder = 1200, marker = "OverlayRootFallback"}
local LocalPlayer = Players.LocalPlayer
local u12 = nil

local function playerGui() -- Line: 17 -- upvalues: u12 (ref), LocalPlayer (val)
    local v1 = u12
    if v1 and v1.Parent then
        return v1
    end
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    u12 = PlayerGui
    return PlayerGui
end

local function authoredDisplayOrder() -- Line: 27 -- upvalues: StarterGui (val)
    local OverlayUI = StarterGui:FindFirstChild("OverlayUI")
    if OverlayUI and OverlayUI:IsA("ScreenGui") then
        return OverlayUI.DisplayOrder
    end
    return 1200
end

local function buildFallback(a1) -- Line: 32 -- upvalues: StarterGui (val), u10 (val) -- types: a1: userdata
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OverlayUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    local OverlayUI = StarterGui:FindFirstChild("OverlayUI")
    local DisplayOrder = if not OverlayUI then u10.displayOrder else if not OverlayUI:IsA("ScreenGui") then u10.displayOrder else OverlayUI.DisplayOrder
    ScreenGui.DisplayOrder = DisplayOrder
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui:SetAttribute("OverlayRootFallback", true)
    ScreenGui.Parent = a1
    return ScreenGui
end

return function() -- Line: 44 -- upvalues: u12 (ref), LocalPlayer (val), StarterGui (val), u10 (val)
    local v1
    local v2 = u12
    if not v2 or not v2.Parent then
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        u12 = PlayerGui
        v1 = PlayerGui
    else
        v1 = v2
    end
    local OverlayUI = v1:FindFirstChild("OverlayUI") or v1:WaitForChild("OverlayUI", 8)
    if OverlayUI and OverlayUI:IsA("ScreenGui") then
        return OverlayUI
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OverlayUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    v2 = StarterGui:FindFirstChild("OverlayUI")
    local DisplayOrder = if not v2 then u10.displayOrder else if not v2:IsA("ScreenGui") then u10.displayOrder else v2.DisplayOrder
    ScreenGui.DisplayOrder = DisplayOrder
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui:SetAttribute(u10.marker, true)
    ScreenGui.Parent = v1
    return ScreenGui
end