-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.UISystem
-- Decompile time: 8.05 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
require(ReplicatedStorage.Packages.Trove)
local u50 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u51 = nil
local u52 = nil
local u53 = false

local function gui() -- Line: 41 -- upvalues: u51 (ref), GUI (val)
    local v1 = u51
    if v1 then
        return v1
    end
    v1 = GUI.BeanstalkEventUI()
    u51 = v1
    return v1
end

local function formatElapsed(a1) -- Line: 51 -- types: a1: number
    local v1 = math.max(math.floor(a1), 0)
    local v2 = v1 // 3600
    local v3 = v1 // 60 % 60
    if v2 > 0 then
        return string.format("%d:%02d:%02d", v2, v3, v1 % 60)
    end
    return string.format("%d:%02d", v3, v1 % 60)
end

local function placeTimer(a1) -- Line: 61 -- upvalues: u52 (ref)
    local Visible, v1
    local Y = a1.AbsoluteSize.Y
    local Y_2 = a1.AbsolutePosition.Y
    local v2 = Y * 0.01
    local Hearts = a1.WhaleProgress.Hearts
    local v3 = {
        a1.CurrentTask,
        a1.CatchFireFlies,
        a1.WaterBeanstalk,
        a1.WhaleProgress,
        Hearts,
        a1.Prompt,
    }
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in v3, v4, v5 do
        v1 = j:IsA("TextLabel") and j.Text == ""
        Visible = j.Visible
        if Visible then
            Visible = true
            if j == Hearts then
                Visible = v6.WhaleProgress.Visible
            end
        end
        if Visible and not v1 then
            v2 = math.max(v2, j.AbsolutePosition.Y + j.AbsoluteSize.Y - Y_2 + Y * 0.01)
        end
    end
    local v7 = u52
    if v7 and v7.Parent and v7.Visible then
        local v8 = math.clamp(Y * 0.045, 30, 44)
        v7.Size = UDim2.fromOffset(v8 * 2 + 8, v8)
        v7.Position = UDim2.new(0.5, 0, 0, v2)
        v7.Hearts.Heart.Size = UDim2.new(0, v8, 1, 0)
        for k, n in v7.Hearts:GetChildren() do
            if n:IsA("ImageLabel") then
                n.Size = UDim2.new(0, v8, 1, 0)
            end
        end
        v2 = v2 + (v8 + Y * 0.01)
    end
    v7 = UDim2.new(0.5, 0, 0, v2)
    if v6.Timer.Position ~= v7 then
        v6.Timer.Position = v7
    end
end

local function showTimer(a1) -- Line: 104
    -- upvalues: Players (val), BeanstalkEvent (val), u53 (ref), placeTimer (val), Workspace (val)
    local Attribute = Players.LocalPlayer:GetAttribute(BeanstalkEvent.StartedAtAttribute)
    local Timer = a1.Timer
    local v1 = false
    if typeof(Attribute) == "number" then
        v1 = not u53
    end
    Timer.Visible = v1
    if typeof(Attribute) == "number" and not u53 then
        placeTimer(a1)
        local Attribute_2 = Players.LocalPlayer:GetAttribute(BeanstalkEvent.FinishedAtAttribute)
        local v2 = math.max(math.floor((if typeof(Attribute_2) ~= "number" then Workspace:GetServerTimeNow() else Attribute_2) - Attribute), 0)
        local v3 = v2 // 3600
        local v4 = v2 // 60 % 60
        local v5 = if not (v3 > 0) then string.format("%d:%02d", v4, v2 % 60) else string.format("%d:%02d:%02d", v3, v4, v2 % 60)
        if a1.Timer.Text ~= v5 then
            a1.Timer.Text = v5
        end
        return
    end
end

local function hideCards(a1) -- Line: 119
    a1.CatchFireFlies.Visible = false
    a1.WaterBeanstalk.Visible = false
    a1.WhaleProgress.Visible = false
end

return {
    Start = function(a1) -- Line: 129
        -- upvalues: u51 (ref), GUI (val), HiddenUIHandler (val), RunService (val), showTimer (val), u53 (ref)
        local u6
        local v1 = u51
        if not v1 then
            GUI.BeanstalkEventUI()
        end
        v1.Enabled = not HiddenUIHandler.IsHidden()
        a1:Connect(HiddenUIHandler.Changed, function() -- Line: 131 -- upvalues: u6 (val), HiddenUIHandler (upval)
            u6.Enabled = not HiddenUIHandler.IsHidden()
        end)
        a1:Connect(RunService.Heartbeat, function() -- Line: 136 -- upvalues: showTimer (upval), u6 (val)
            showTimer(u6)
        end)
        a1:Add(function() -- Line: 139 -- upvalues: u53 (upval), u6 (val)
            u53 = false
            u6.Enabled = false
            u6.Timer.Visible = false
            u6.CurrentTask.Text = ""
            u6.CurrentTask.Visible = true
            local v1 = u6
            v1.CatchFireFlies.Visible = false
            v1.WaterBeanstalk.Visible = false
            v1.WhaleProgress.Visible = false
            u6.Prompt.Visible = false
        end)
    end,
    Finish = function() -- Line: 151 -- upvalues: u51 (ref), GUI (val), u53 (ref)
        local v1
        local v2 = u51
        if not v2 then
            GUI.BeanstalkEventUI()
        end
        u53 = true
        v2.CurrentTask.Visible = false
        v1.Timer.Visible = false
    end,
    SetTask = function(a1) -- Line: 159 -- upvalues: u51 (ref), GUI (val) -- types: a1: string
        local v1
        local v2 = u51
        if not v2 then
            GUI.BeanstalkEventUI()
        end
        v2.CatchFireFlies.Visible = false
        v1.WaterBeanstalk.Visible = false
        v1.WhaleProgress.Visible = false
        v1.CurrentTask.Visible = true
        v1.CurrentTask.Text = a1
    end,
    SetProgress = function(a1, a2, a3) -- Line: 167
        -- upvalues: u51 (ref), GUI (val), TweenService (val), u50 (val)
        local v1 = u51
        if not v1 then
            GUI.BeanstalkEventUI()
        end
        local v2 = v1
        local CatchFireFlies = if a1 ~= "CatchFireFlies" then v2.WaterBeanstalk else v2.CatchFireFlies
        v2.CurrentTask.Visible = false
        v2.CatchFireFlies.Visible = false
        v2.WaterBeanstalk.Visible = false
        v2.WhaleProgress.Visible = false
        CatchFireFlies.Visible = true
        CatchFireFlies.BarHolder.TextLabel.Text = ("%*/%*"):format(a2, a3)
        local Bar = CatchFireFlies.BarHolder.BarBG.Bar
        local Y = Bar.Size.Y
        TweenService:Create(Bar, u50, {Size = UDim2.new(a2 / a3, 0, Y.Scale, Y.Offset)}):Play()
    end,
    SetFlightProgress = function(a1) -- Line: 184 -- upvalues: u51 (ref), GUI (val) -- types: a1: number
        local v1
        local v2 = u51
        if not v2 then
            GUI.BeanstalkEventUI()
        end
        local WhaleProgress = v2.WhaleProgress
        v1.CurrentTask.Visible = false
        v1.CatchFireFlies.Visible = false
        v1.WaterBeanstalk.Visible = false
        v1.WhaleProgress.Visible = false
        WhaleProgress.Visible = true
        v1 = math.clamp(a1, 0, 1)
        local BarBG = WhaleProgress.BarHolder.BarBG
        local Bar = BarBG.Bar
        Bar.Size = UDim2.new(v1, 0, Bar.Size.Y.Scale, Bar.Size.Y.Offset)
        local X = WhaleProgress.AbsoluteSize.X
        if X > 0 then
            local v3 = BarBG.AbsolutePosition.X + BarBG.AbsoluteSize.X * v1
            local Whale = WhaleProgress.Whale
            Whale.Position = UDim2.new((v3 - WhaleProgress.AbsolutePosition.X) / X, 0, Whale.Position.Y.Scale, Whale.Position.Y.Offset)
        end
    end,
    ShowSlideHearts = function(a1) -- Line: 207 -- upvalues: u51 (ref), GUI (val), u52 (ref), placeTimer (val)
        local v1, v2
        local v3 = u51
        if not v3 then
            GUI.BeanstalkEventUI()
        end
        local u13 = a1:Add((Instance.new("Frame")))
        u13.Name = "SlideHearts"
        u13.BackgroundTransparency = 1
        u13.AnchorPoint = Vector2.new(0.5, 0)
        u13.Size = UDim2.fromOffset(88, 40)
        u13.Position = UDim2.new(0.5, 0, 0.2, 0)
        for i, j in {"Hearts", "HeartsFx"} do
            v2 = v3.WhaleProgress[j]:Clone()
            v2.AnchorPoint = Vector2.zero
            v2.Position = UDim2.fromScale(0, 0)
            v2.Size = UDim2.fromScale(1, 1)
            v2.Parent = u13
        end
        u13.Hearts.UIListLayout.Padding = UDim.new(0, 8)
        u13.Hearts.Heart.Size = UDim2.new(0, 40, 1, 0)
        u13.Parent = v1
        u52 = u13
        a1:Add(function() -- Line: 226 -- upvalues: u52 (upval), u13 (val)
            if u52 == u13 then
                u52 = nil
            end
        end)
        placeTimer(v1)
        return u13
    end,
    SetPrompt = function(a1) -- Line: 235 -- upvalues: u51 (ref), GUI (val) -- types: a1: string?
        local v1 = u51
        if not v1 then
            GUI.BeanstalkEventUI()
        end
        local Prompt = v1.Prompt
        Prompt.Visible = a1 ~= nil
        Prompt.Text = a1 or ""
    end,
}