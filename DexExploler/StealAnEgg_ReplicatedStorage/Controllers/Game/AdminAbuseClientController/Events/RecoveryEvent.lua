-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RecoveryEvent
-- Decompile time: 7.69 ms

local Players = game:GetService("Players")
game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local u30 = Players.LocalPlayer:WaitForChild("PlayerGui")
local u31 = nil
local u32 = {}
local u33 = nil

local function fadeSecondsFor(a1) -- Line: 33 -- types: a1: table
    local v1 = a1[1]
    if v1 == nil then
        return 1.2
    end
    return tonumber((v1:GetAttribute("FadeSeconds"))) or 1.2
end

local function show() -- Line: 41
    -- upvalues: u31 (ref), u30 (val), Workspace (val), u32 (ref), TweenService (val), u33 (ref), RunService (val)
    if u31 ~= nil then
        return
    end
    local RecoveryVignette = u30:WaitForChild("RecoveryVignette", 10)
    if RecoveryVignette ~= nil and RecoveryVignette:IsA("ScreenGui") then
        local UIGradient, v1, v2
        if u31 ~= nil or not Workspace:GetAttribute("Event_RecoveryEvent") then
            return
        end
        local v3 = RecoveryVignette:Clone()
        v3.Name = "RecoveryVignetteActive"
        v3.Enabled = true
        local v4 = {}
        local u23 = {}
        for i, j in v3:GetChildren() do
            if j:IsA("ImageLabel") then
                table.insert(v4, j)
                UIGradient = j:FindFirstChildOfClass("UIGradient")
                if UIGradient ~= nil then
                    table.insert(u23, UIGradient)
                end
            end
        end
        if #v4 == 0 then
            warn("[RecoveryEvent] RecoveryVignette needs at least one ImageLabel; the vignette is skipped")
            v3:Destroy()
            return
        end
        local v5 = v4[1]
        local v6 = v5 ~= nil and tonumber((v5:GetAttribute("FadeSeconds"))) or 1.2
        local u62 = tonumber((v4[1]:GetAttribute("SpinDegreesPerSecond"))) or 45
        for k, n in v4 do
            n.ImageTransparency = 1
        end
        u31 = v3
        u32 = v4
        v3.Parent = u30
        for m, i5 in v4 do
            v3 = tonumber((i5:GetAttribute("RestTransparency"))) or 0.25
            v1 = TweenService
            v2 = TweenInfo.new(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            v1:Create(i5, v2, {ImageTransparency = v3}):Play()
        end
        if #u23 > 0 then
            local Rotation = u23[1].Rotation
            RunService.Heartbeat:Connect(function(a1) -- Line: 103 -- upvalues: Rotation (ref), u62 (val), u23 (val) -- types: a1: number
                Rotation = (Rotation + u62 * a1) % 360
                for i, j in u23 do
                    j.Rotation = Rotation
                end
            end)
        end
        return
    end
    warn("[RecoveryEvent] Missing StarterGui.RecoveryVignette; the vignette is skipped")
end

local function hide() -- Line: 112 -- upvalues: u31 (ref), u32 (ref), TweenService (val), u33 (ref)
    local u0 = u31
    local v1 = u32
    u31 = nil
    u32 = {}
    if u0 == nil then
        return
    end
    local v2 = v1[1]
    local v3 = v2 ~= nil and tonumber((v2:GetAttribute("FadeSeconds"))) or 1.2
    if #v1 > 0 then
        local v4, v5
        for i, j in v1 do
            v5 = TweenService
            v4 = TweenInfo.new(v3, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
            v5:Create(j, v4, {ImageTransparency = 1}):Play()
        end
    end
    local u42 = u33
    u33 = nil
    task.delay(v3, function() -- Line: 131 -- upvalues: u42 (val), u0 (val)
        if u42 ~= nil then
            u42:Disconnect()
        end
        u0:Destroy()
    end)
end

local v1 = {
    StartEvent = function(a1, a2, a3) -- Line: 151 -- upvalues: show (val) -- types: a1: table, a2: number
        show()
    end,
    StopEvent = function(a1) -- Line: 155 -- upvalues: hide (val)
        hide()
    end,
}
;(Workspace:GetAttributeChangedSignal("Event_RecoveryEvent")):Connect(function() -- Line: 139 -- upvalues: Workspace (val), show (val), hide (val)
    if Workspace:GetAttribute("Event_RecoveryEvent") then
        show()
        return
    end
    hide()
end)
if not Workspace:GetAttribute("Event_RecoveryEvent") then
    hide()
else
    show()
end
return v1