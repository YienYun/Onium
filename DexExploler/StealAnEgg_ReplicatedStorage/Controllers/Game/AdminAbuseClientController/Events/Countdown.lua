-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.Countdown
-- Decompile time: 14.67 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Shake = require(ReplicatedStorage.Client.Shake)
local u37 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local u42 = Color3.fromRGB(255, 255, 255)
local u47 = Color3.fromRGB(255, 82, 82)
local u53 = Players.LocalPlayer:WaitForChild("PlayerGui")
local u55 = Random.new()
local u56 = nil
local u57 = nil
local u58 = nil

local function playNamedSound(a1) -- Line: 85 -- upvalues: ReplicatedStorage (val), Audio (val) -- types: a1: string
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Sounds = Assets and Assets:FindFirstChild("Sounds")
    local v1 = Sounds and Sounds:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        Audio.Play(v1, script)
        return
    end
    warn((("[Countdown] Missing ReplicatedStorage.Assets.Sounds.%*; the countdown continues without it"):format(a1)))
end

local function resolveNotificationLane() -- Line: 96 -- upvalues: u53 (val)
    local Notifications = u53:FindFirstChild("Notifications")
    local Banner = if Notifications == nil then nil else Notifications:FindFirstChild("Banner")
    if Banner ~= nil and Banner:IsA("Frame") then
        return Banner
    end
    return nil
end

local function resolveEndsAt() -- Line: 102 -- upvalues: Workspace (val), u58 (ref)
    local Attribute = Workspace:GetAttribute("AdminAbuseCountdownEndsAt")
    if type(Attribute) == "number" then
        return Attribute
    end
    return u58
end

local function formatClock(a1) -- Line: 110 -- types: a1: number
    local v1 = math.ceil(a1)
    local v2 = v1 // 3600
    local v3 = v1 % 3600 // 60
    local v4 = v1 % 60
    if v2 > 0 then
        return string.format("%d:%02d:%02d", v2, v3, v4)
    end
    if v1 < 60 then
        return (tostring(v1))
    end
    return string.format("%02d:%02d", v3, v4)
end

local function setText(a1, a2) -- Line: 124 -- types: a1: table, a2: string
    a1.TimeLabel.Text = a2
    if a1.ShadowLabel ~= nil then
        a1.ShadowLabel.Text = a2
    end
end

local function syncTitle(a1) -- Line: 132 -- upvalues: Workspace (val) -- types: a1: table
    local Attribute = Workspace:GetAttribute("AdminAbuseCountdownTitle")
    if type(Attribute) == "string" and a1.TitleLabel.Text ~= Attribute then
        a1.TitleLabel.Text = Attribute
    end
end

local function punch(a1, a2) -- Line: 139 -- upvalues: TweenService (val) -- types: a1: table, a2: number
    local Punch = a1.Punch
    if Punch == nil then
        return
    end
    if a1.PunchTween ~= nil then
        a1.PunchTween:Cancel()
    end
    Punch.Scale = a2
    local v1 = TweenService:Create(Punch, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    a1.PunchTween = v1
    v1:Play()
    a1.ShakeUntil = os.clock() + 0.18
end

local function playTick(a1) -- Line: 155 -- upvalues: Audio (val) -- types: a1: number
    local v1 = 1 - math.clamp(a1 / 10, 0, 1)
    Audio.Play("rbxassetid://125937767292519", script, {Volume = 0.7, PlaybackSpeed = v1 * 0.85 + 0.85})
end

local function teardown() -- Line: 163 -- upvalues: u57 (ref), u56 (ref)
    if u57 ~= nil then
        u57:Disconnect()
        u57 = nil
    end
    local v1 = u56
    u56 = nil
    if v1 ~= nil then
        v1.Gui:Destroy()
    end
end

local function fadeOut(a1) -- Line: 176
    -- upvalues: u56 (ref), u57 (ref), TweenService (val), u37 (val)
    local UIStroke
    if u56 ~= a1 then
        return
    end
    u56 = nil
    if u57 ~= nil then
        u57:Disconnect()
        u57 = nil
    end
    for i, j in {a1.TimeLabel, a1.TitleLabel} do
        TweenService:Create(j, u37, {TextTransparency = 1}):Play()
        UIStroke = j:FindFirstChildOfClass("UIStroke")
        if UIStroke ~= nil then
            TweenService:Create(UIStroke, u37, {Transparency = 1}):Play()
        end
    end
    if a1.ShadowLabel ~= nil then
        TweenService:Create(a1.ShadowLabel, u37, {TextTransparency = 1}):Play()
    end
    task.delay(0.6, function() -- Line: 197 -- upvalues: a1 (val)
        a1.Gui:Destroy()
    end)
end

local function applyPosition(a1, a2) -- Line: 203 -- types: a1: table, a2: number
    local v1
    local Lane = a1.Lane
    if Lane == nil then
        a1.BasePosition = a1.LoweredPosition
        return
    end
    local Y = Lane.AbsolutePosition.Y
    local v2 = Y
    local v3 = false
    for i, j in Lane:GetChildren() do
        if j:IsA("GuiObject") and j.Visible then
            v3 = true
            v1 = j.AbsolutePosition.Y + j.AbsoluteSize.Y
            if v2 < v1 then
                v2 = v1
            end
        end
    end
    local v4 = if not v3 then Y else v2 + a1.LaneGap
    local RestY = a1.RestY
    if RestY ~= nil then
        v2 = if not (RestY < v4) then 5 else 18
        v3 = RestY + (v4 - RestY) * math.min(a2 * v2, 1)
    else
        v3 = v4
    end
    a1.RestY = v3
    local LoweredPosition = a1.LoweredPosition
    a1.BasePosition = UDim2.new(LoweredPosition.X.Scale, LoweredPosition.X.Offset, 0, v3 - a1.Gui.AbsolutePosition.Y)
end

local function applyShake(a1) -- Line: 241 -- upvalues: u55 (val) -- types: a1: table
    local Holder = a1.Holder
    if os.clock() < a1.ShakeUntil then
        Holder.Position = a1.BasePosition + UDim2.fromOffset(u55:NextInteger(-6, 6), u55:NextInteger(-6, 6))
        return
    end
    if Holder.Position ~= a1.BasePosition then
        Holder.Position = a1.BasePosition
    end
end

local function applyScale(a1, a2, a3) -- Line: 254 -- types: a1: table, a2: number, a3: number
    a1.Scale = a1.Scale + (a2 - a1.Scale) * math.min(a3 * 5, 1)
    local BaseSize = a1.BaseSize
    a1.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * a1.Scale, BaseSize.Y.Scale * a1.Scale)
end

local function startFinale(a1) -- Line: 260
    -- upvalues: punch (val), playNamedSound (val), Shake (val), fadeOut (val)
    a1.FinaleAt = os.clock()
    a1.TimeLabel.Text = "0"
    if a1.ShadowLabel ~= nil then
        a1.ShadowLabel.Text = "0"
    end
    a1.TimeLabel.TextColor3 = a1.UrgentColor
    punch(a1, 1.45)
    playNamedSound("CinematicBoom")
    Shake.Play({Seconds = 0.35, Magnitude = 0.35})
    task.delay(1.4, function() -- Line: 267 -- upvalues: fadeOut (upval), a1 (val)
        fadeOut(a1)
    end)
end

local function step(a1) -- Line: 270
    -- upvalues: u56 (ref), u57 (ref), Workspace (val), applyPosition (val), applyShake (val), u58 (ref), fadeOut (val)
    -- upvalues: startFinale (val), formatClock (val), playNamedSound (val), punch (val), Audio (val)
    local v1, v2
    local v3 = u56
    if v3 == nil then
        return
    end
    if v3.Gui.Parent == nil then
        if u57 ~= nil then
            u57:Disconnect()
            u57 = nil
        end
        v1 = u56
        u56 = nil
        if v1 ~= nil then
            v1.Gui:Destroy()
        end
        return
    end
    local Attribute = Workspace:GetAttribute("AdminAbuseCountdownTitle")
    if type(Attribute) == "string" and v3.TitleLabel.Text ~= Attribute then
        v3.TitleLabel.Text = Attribute
    end
    if v3.FinaleAt ~= nil then
        v3.Scale = v3.Scale + (1 - v3.Scale) * math.min(a1 * 5, 1)
        local BaseSize = v3.BaseSize
        v3.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v3.Scale, BaseSize.Y.Scale * v3.Scale)
        applyPosition(v3, a1)
        applyShake(v3)
        return
    end
    local Attribute_2 = Workspace:GetAttribute("AdminAbuseCountdownEndsAt")
    if (if type(Attribute_2) ~= "number" then u58 else Attribute_2) == nil then
        fadeOut(v3)
        return
    end
    local v4 = v1 - Workspace:GetServerTimeNow()
    if v4 <= 0 then
        startFinale(v3)
        return
    end
    v1 = math.ceil(v4)
    if not (v4 > 10) then
        if not v3.RiserPlayed then
            v3.RiserPlayed = true
            playNamedSound("CinematicRiser")
        end
        v2 = 1 - math.clamp(v4 / 10, 0, 1)
        v3.TimeLabel.TextColor3 = v3.CalmColor:Lerp(v3.UrgentColor, v2)
        local v5 = if not (v4 > 6) then string.format("%.1f", v4) else tostring(v1)
        v3.TimeLabel.Text = v5
        if v3.ShadowLabel ~= nil then
            v3.ShadowLabel.Text = v5
        end
        if v1 ~= v3.LastWholeSecond then
            punch(v3, v3.PunchScale)
            v2 = 1 - math.clamp(v1 / 10, 0, 1)
            Audio.Play("rbxassetid://125937767292519", script, {Volume = 0.7, PlaybackSpeed = v2 * 0.85 + 0.85})
        end
        v3.Scale = v3.Scale + (1 - v3.Scale) * math.min(a1 * 5, 1)
        local BaseSize_3 = v3.BaseSize
        v3.Holder.Size = UDim2.fromScale(BaseSize_3.X.Scale * v3.Scale, BaseSize_3.Y.Scale * v3.Scale)
    else
        v2 = formatClock(v4)
        v3.TimeLabel.Text = v2
        if v3.ShadowLabel ~= nil then
            v3.ShadowLabel.Text = v2
        end
        v3.TimeLabel.TextColor3 = v3.CalmColor
        v3.Scale = v3.Scale + (0.55 - v3.Scale) * math.min(a1 * 5, 1)
        local BaseSize_2 = v3.BaseSize
        v3.Holder.Size = UDim2.fromScale(BaseSize_2.X.Scale * v3.Scale, BaseSize_2.Y.Scale * v3.Scale)
    end
    v3.LastWholeSecond = v1
    applyPosition(v3, a1)
    applyShake(v3)
end

local function show() -- Line: 330
    -- upvalues: u56 (ref), u53 (val), u42 (val), u47 (val), Workspace (val), u57 (ref), RunService (val), step (val)
    if u56 ~= nil then
        return
    end
    local CountdownGui = u53:WaitForChild("CountdownGui", 10)
    if CountdownGui ~= nil and CountdownGui:IsA("ScreenGui") then
        if u56 ~= nil then
            return
        end
        local v1 = CountdownGui:Clone()
        v1.Name = "CountdownGuiActive"
        v1.Enabled = true
        local v2 = v1:FindFirstChild("Holder")
        local Time = if v2 == nil then nil else v2:FindFirstChild("Time")
        if v2 ~= nil and v2:IsA("Frame") and Time ~= nil and Time:IsA("TextLabel") then
            local Title = v2:FindFirstChild("Title")
            local v3 = false
            if Title ~= nil then
                v3 = Title:IsA("TextLabel")
            end
            assert(v3, "CountdownGui.Holder needs a Title TextLabel")
            local Shadow = v2:FindFirstChild("Shadow")
            local Punch = v2:FindFirstChild("Punch")
            local Attribute = v2:GetAttribute("CalmColor")
            local Attribute_2 = v2:GetAttribute("UrgentColor")
            local v4 = {
                Scale = 0.55,
                ShakeUntil = 0,
                RiserPlayed = false,
                Gui = v1,
                Holder = v2,
                TimeLabel = Time,
                TitleLabel = Title,
            }
            v4.ShadowLabel = if Shadow == nil then nil else if not Shadow:IsA("TextLabel") then nil else Shadow
            v4.Punch = if Punch == nil then nil else if not Punch:IsA("UIScale") then nil else Punch
            v4.BaseSize = v2.Size
            v4.BasePosition = v2.Position
            v4.LoweredPosition = v2.Position
            v4.LaneGap = tonumber((v2:GetAttribute("LaneGapPixels"))) or 8
            local Notifications = u53:FindFirstChild("Notifications")
            local Banner = if Notifications == nil then nil else Notifications:FindFirstChild("Banner")
            v4.Lane = if Banner == nil then nil else if not Banner:IsA("Frame") then nil else Banner
            v4.CalmColor = if typeof(Attribute) ~= "Color3" then u42 else Attribute
            v4.UrgentColor = if typeof(Attribute_2) ~= "Color3" then u47 else Attribute_2
            v4.PunchScale = tonumber((v2:GetAttribute("PunchScale"))) or 1.3
            v4.TimeLabel.Text = ""
            if v4.ShadowLabel ~= nil then
                v4.ShadowLabel.Text = ""
            end
            v4.TitleLabel.Text = ""
            local v5 = Workspace:GetAttribute("AdminAbuseCountdownTitle")
            if type(v5) == "string" and v4.TitleLabel.Text ~= v5 then
                v4.TitleLabel.Text = v5
            end
            u56 = v4
            v1.Parent = u53
            if u57 == nil then
                RunService.RenderStepped:Connect(step)
            end
            return
        end
        warn("[Countdown] CountdownGui needs Holder and Holder.Time; the countdown has no display")
        v1:Destroy()
        return
    end
    warn("[Countdown] Missing StarterGui.CountdownGui; the countdown has no display")
end

local v1 = {
    StartEvent = function(a1, a2, a3) -- Line: 399 -- upvalues: u58 (ref), Workspace (val), show (val) -- types: a1: table, a2: number
        u58 = Workspace:GetServerTimeNow() + a2
        show()
    end,
    StopEvent = function(a1) -- Line: 404 -- upvalues: u58 (ref), u56 (ref), fadeOut (val)
        u58 = nil
        local v1 = u56
        if v1 ~= nil and v1.FinaleAt == nil then
            fadeOut(v1)
        end
    end,
}
;(Workspace:GetAttributeChangedSignal("AdminAbuseCountdownEndsAt")):Connect(function() -- Line: 412 -- upvalues: Workspace (val), show (val), u56 (ref), fadeOut (val)
    if type((Workspace:GetAttribute("AdminAbuseCountdownEndsAt"))) == "number" then
        show()
        return
    end
    local v1 = u56
    if v1 ~= nil and v1.FinaleAt == nil then
        fadeOut(v1)
    end
end)
if type((Workspace:GetAttribute("AdminAbuseCountdownEndsAt"))) ~= "number" then
    local v2 = u56
    if v2 ~= nil and v2.FinaleAt == nil then
        fadeOut(v2)
    end
else
    show()
end
return v1