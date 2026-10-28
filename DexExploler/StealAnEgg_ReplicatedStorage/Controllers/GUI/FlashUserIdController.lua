-- Script path: ReplicatedStorage.Controllers.GUI.FlashUserIdController
-- Decompile time: 3.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u14 = {}
u14.top = {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.12)}
u14.center = {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
u14.left = {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.03, 0.3)}
u14.right = {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(0.97, 0.3)}
local LocalPlayer = Players.LocalPlayer
local u56 = LocalPlayer:WaitForChild("PlayerGui")
local v1 = {}
local u58 = 0

local function findHotbar() -- Line: 35 -- upvalues: u56 (val)
    local BackpackGui = u56:FindFirstChild("BackpackGui")
    local Backpack = BackpackGui and BackpackGui:FindFirstChild("Backpack")
    local v1 = Backpack and Backpack:FindFirstChild("Hotbar")
    if v1 and v1:IsA("GuiObject") and 0 < v1.AbsoluteSize.Y then
        return v1
    end
    return nil
end

local function placeAboveHotbar(a1, a2) -- Line: 45 -- upvalues: findHotbar (val) -- types: a1: userdata, a2: userdata
    a2.AnchorPoint = Vector2.new(0.5, 1)
    local AbsoluteSize = a1.AbsoluteSize
    local v1 = findHotbar()
    if v1 ~= nil and not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
        local v2 = a1:GetAttribute("Gap") or 0.01
        local AbsolutePosition = a1.AbsolutePosition
        local v3 = v1.AbsolutePosition.X + v1.AbsoluteSize.X / 2 - AbsolutePosition.X
        local v4 = v1.AbsolutePosition.Y - AbsolutePosition.Y
        a2.Position = UDim2.fromScale(v3 / AbsoluteSize.X, v4 / AbsoluteSize.Y - v2)
        return
    end
    a2.Position = UDim2.fromScale(0.5, 0.86)
end

local function place(a1, a2, a3) -- Line: 62
    -- upvalues: u14 (val), placeAboveHotbar (val)
    local v1
    if (if not a3 then nil else u14[a3]) == nil then
        placeAboveHotbar(a1, a2)
        return
    end
    a2.AnchorPoint = v1.AnchorPoint
    a2.Position = v1.Position
end

local function flash(a1) -- Line: 73
    -- upvalues: u56 (val), u58 (ref), LocalPlayer (val), u14 (val), placeAboveHotbar (val)
    local FlashUserId = u56:FindFirstChild("FlashUserId")
    local UserId = FlashUserId and FlashUserId:FindFirstChild("UserId")
    if FlashUserId ~= nil and FlashUserId:IsA("ScreenGui") and UserId ~= nil and UserId:IsA("TextLabel") then
        u58 = u58 + 1
        local u23 = u58
        UserId.Text = tostring(LocalPlayer.UserId)
        local v1 = if not a1 then nil else u14[a1]
        if v1 ~= nil then
            UserId.AnchorPoint = v1.AnchorPoint
            UserId.Position = v1.Position
        else
            placeAboveHotbar(FlashUserId, UserId)
        end
        FlashUserId.Enabled = true
        task.delay(FlashUserId:GetAttribute("Seconds") or 0.7, function() -- Line: 92 -- upvalues: u58 (upval), u23 (val), FlashUserId (val)
            if u58 == u23 then
                FlashUserId.Enabled = false
            end
        end)
        return
    end
    warn("[FlashUserId] PlayerGui.FlashUserId.UserId is missing")
end

function v1.Start() -- Line: 99 -- upvalues: Remotes (val), flash (val)
    Remotes.Broadcasts.FlashUserId.OnClientEvent:Connect(flash)
end

return v1