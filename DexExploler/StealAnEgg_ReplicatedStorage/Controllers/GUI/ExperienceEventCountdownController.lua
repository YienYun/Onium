-- Script path: ReplicatedStorage.Controllers.GUI.ExperienceEventCountdownController
-- Decompile time: 10.90 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local EventBoardView = require(ReplicatedStorage.Shared.Modules.EventBoardView)
local Log = require(ReplicatedStorage.Packages.Log)
local u47 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local u52 = Color3.fromRGB(255, 255, 255)
local u57 = Color3.fromRGB(255, 82, 82)
local u59 = Log.new()
local u62 = Random.new()
local u63 = nil
local u64 = nil
local u65 = nil
local u66 = nil
local u67 = nil

local function now() -- Line: 67 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function remainingSeconds() -- Line: 71 -- upvalues: u65 (ref), Workspace (val)
    local v1 = u65
    if v1 ~= nil then
        return v1.StartsAt - Workspace:GetServerTimeNow()
    end
    return nil
end

local function inShowWindow(a1) -- Line: 76 -- types: a1: number?
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a1 > 0 then
            v1 = a1 <= 3600
        end
    end
    return v1
end

local function nextPollSeconds(a1, a2) -- Line: 80 -- types: a2: number
    if a1 == nil then
        return 3600
    end
    if 3600 < a1.StartsAt - a2 then
        return 1800
    end
    return 300
end

local function formatClock(a1) -- Line: 90 -- types: a1: number
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

local function setText(a1, a2) -- Line: 104 -- types: a1: table, a2: string
    a1.TimeLabel.Text = a2
    if a1.ShadowLabel ~= nil then
        a1.ShadowLabel.Text = a2
    end
end

local function punch(a1, a2) -- Line: 111 -- upvalues: TweenService (val) -- types: a1: table, a2: number
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

local function playTick(a1) -- Line: 131 -- upvalues: Audio (val) -- types: a1: number
    local v1 = 1 - math.clamp(a1 / 10, 0, 1)
    Audio.Play("rbxassetid://125937767292519", script, {Volume = 0.7, PlaybackSpeed = v1 * 0.85 + 0.85})
end

local function fadeOut(a1) -- Line: 139
    -- upvalues: u66 (ref), u67 (ref), TweenService (val), u47 (val)
    local UIStroke
    if u66 ~= a1 then
        return
    end
    u66 = nil
    if u67 ~= nil then
        u67:Disconnect()
        u67 = nil
    end
    local v1 = {a1.TimeLabel, a1.TitleLabel}
    if a1.ShadowLabel ~= nil then
        table.insert(v1, a1.ShadowLabel)
    end
    for i, j in v1 do
        TweenService:Create(j, u47, {TextTransparency = 1}):Play()
        UIStroke = j:FindFirstChildOfClass("UIStroke")
        if UIStroke ~= nil then
            TweenService:Create(UIStroke, u47, {Transparency = 1}):Play()
        end
    end
    task.delay(0.6, function() -- Line: 161 -- upvalues: a1 (val)
        a1.Gui:Destroy()
    end)
end

local function applyShake(a1) -- Line: 166 -- upvalues: Workspace (val), u62 (val) -- types: a1: table
    local Holder = a1.Holder
    if not (os.clock() < a1.ShakeUntil) then
        if Holder.Position ~= a1.BasePosition then
            Holder.Position = a1.BasePosition
        end
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local ViewportSize = CurrentCamera.ViewportSize
    Holder.Position = a1.BasePosition + UDim2.fromScale((u62:NextInteger(-6, 6)) / ViewportSize.X, (u62:NextInteger(-6, 6)) / ViewportSize.Y)
end

local function applyScale(a1, a2, a3) -- Line: 184 -- types: a1: table, a2: number, a3: number
    a1.Scale = a1.Scale + (a2 - a1.Scale) * math.min(a3 * 5, 1)
    local BaseSize = a1.BaseSize
    a1.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * a1.Scale, BaseSize.Y.Scale * a1.Scale)
end

local function step(a1) -- Line: 191
    -- upvalues: u66 (ref), u65 (ref), Workspace (val), fadeOut (val), formatClock (val), Audio (val), u64 (ref)
    -- upvalues: punch (val), applyShake (val)
    local v1 = u66
    if v1 == nil then
        return
    end
    local v2 = u65
    local v3 = if v2 == nil then nil else v2.StartsAt - Workspace:GetServerTimeNow()
    v2 = u65
    local v4 = false
    if v3 ~= nil then
        v4 = false
        if v3 > 0 then
            v4 = v3 <= 3600
        end
    end
    if v4 and v2 ~= nil and v3 ~= nil then
        if v1.TitleLabel.Text ~= v2.Title then
            v1.TitleLabel.Text = v2.Title
        end
        v2 = math.ceil(v3)
        if not (v3 > 10) then
            if not v1.RiserPlayed then
                v1.RiserPlayed = true
                Audio.Play(u64, script)
            end
            v4 = 1 - math.clamp(v3 / 10, 0, 1)
            v1.TimeLabel.TextColor3 = v1.CalmColor:Lerp(v1.UrgentColor, v4)
            local v5 = if not (v3 > 6) then string.format("%.1f", v3) else tostring(v2)
            v1.TimeLabel.Text = v5
            if v1.ShadowLabel ~= nil then
                v1.ShadowLabel.Text = v5
            end
            if v2 ~= v1.LastWholeSecond then
                punch(v1, v1.PunchScale)
                v4 = 1 - math.clamp(v2 / 10, 0, 1)
                Audio.Play("rbxassetid://125937767292519", script, {Volume = 0.7, PlaybackSpeed = v4 * 0.85 + 0.85})
            end
            v1.Scale = v1.Scale + (1 - v1.Scale) * math.min(a1 * 5, 1)
            local BaseSize_2 = v1.BaseSize
            v1.Holder.Size = UDim2.fromScale(BaseSize_2.X.Scale * v1.Scale, BaseSize_2.Y.Scale * v1.Scale)
        else
            v4 = formatClock(v3)
            v1.TimeLabel.Text = v4
            if v1.ShadowLabel ~= nil then
                v1.ShadowLabel.Text = v4
            end
            v1.TimeLabel.TextColor3 = v1.CalmColor
            v1.Scale = v1.Scale + (0.55 - v1.Scale) * math.min(a1 * 5, 1)
            local BaseSize = v1.BaseSize
            v1.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v1.Scale, BaseSize.Y.Scale * v1.Scale)
        end
        v1.LastWholeSecond = v2
        applyShake(v1)
        return
    end
    fadeOut(v1)
end

local function show() -- Line: 237
    -- upvalues: u66 (ref), u63 (ref), u52 (val), u57 (val), Players (val), u67 (ref), RunService (val), step (val)
    if u66 ~= nil then
        return
    end
    local v1 = u63:Clone()
    v1.Name = "EventCountdownGuiActive"
    v1.Enabled = true
    local Holder = v1:FindFirstChild("Holder")
    local v2 = false
    if Holder ~= nil then
        v2 = Holder:IsA("Frame")
    end
    assert(v2, "EventCountdownGui needs a Holder Frame")
    local Time = Holder:FindFirstChild("Time")
    local Title = Holder:FindFirstChild("Title")
    local v3 = false
    if Time ~= nil then
        v3 = Time:IsA("TextLabel")
    end
    assert(v3, "EventCountdownGui.Holder needs a Time TextLabel")
    v3 = false
    if Title ~= nil then
        v3 = Title:IsA("TextLabel")
    end
    assert(v3, "EventCountdownGui.Holder needs a Title TextLabel")
    local Shadow = Holder:FindFirstChild("Shadow")
    local Punch = Holder:FindFirstChild("Punch")
    local Attribute = Holder:GetAttribute("CalmColor")
    local Attribute_2 = Holder:GetAttribute("UrgentColor")
    local v4 = {
        Scale = 0.55,
        ShakeUntil = 0,
        RiserPlayed = false,
        Gui = v1,
        Holder = Holder,
        TimeLabel = Time,
        TitleLabel = Title,
    }
    v4.ShadowLabel = if Shadow == nil then nil else if not Shadow:IsA("TextLabel") then nil else Shadow
    v4.Punch = if Punch == nil then nil else if not Punch:IsA("UIScale") then nil else Punch
    v4.BaseSize = Holder.Size
    v4.BasePosition = Holder.Position
    v4.CalmColor = if typeof(Attribute) ~= "Color3" then u52 else Attribute
    v4.UrgentColor = if typeof(Attribute_2) ~= "Color3" then u57 else Attribute_2
    v4.PunchScale = tonumber((Holder:GetAttribute("PunchScale"))) or 1.3
    v4.TimeLabel.Text = ""
    if v4.ShadowLabel ~= nil then
        v4.ShadowLabel.Text = ""
    end
    v4.TitleLabel.Text = ""
    u66 = v4
    v1.Parent = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if u67 == nil then
        RunService.RenderStepped:Connect(step)
    end
end

local function fetchUpcoming() -- Line: 292
    -- upvalues: SocialService (val), u59 (val), u65 (ref), EventBoardView (val), now (val)
    local success, err = pcall(SocialService.GetUpcomingExperienceEventsAsync, SocialService)
    if not success then
        (u59:AtWarning()):Log((("[ExperienceEventCountdown] failed to fetch experience events: %*"):format(err)))
        return
    end
    EventBoardView.Pick(err, now())
end

return {
    Start = function() -- Line: 304
        -- upvalues: Players (val), u63 (ref), ReplicatedStorage (val), u64 (ref), SocialService (val), u59 (val)
        -- upvalues: u65 (ref), EventBoardView (val), now (val), Workspace (val), u66 (ref), show (val)
        local EventCountdownGui = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("EventCountdownGui")
        assert(EventCountdownGui:IsA("ScreenGui"), "EventCountdownGui must be a ScreenGui")
        u63 = EventCountdownGui
        local CinematicRiser = ReplicatedStorage.Assets.Sounds:FindFirstChild("CinematicRiser")
        local v1 = false
        if CinematicRiser ~= nil then
            v1 = CinematicRiser:IsA("Sound")
        end
        assert(v1, "Missing ReplicatedStorage.Assets.Sounds.CinematicRiser")
        u64 = CinematicRiser
        task.spawn(function() -- Line: 316
            -- upvalues: SocialService (upval), u59 (upval), u65 (upval), EventBoardView (upval), now (upval)
            -- upvalues: Workspace (upval)
            local ServerTimeNow, err, success, v1, wait
            task.wait(Random.new():NextNumber(1, 120))
            while true do
                v1 = SocialService
                success, err = pcall(SocialService.GetUpcomingExperienceEventsAsync, v1)
                if success then
                    u65 = EventBoardView.Pick(err, now())
                else
                    (u59:AtWarning()):Log((("[ExperienceEventCountdown] failed to fetch experience events: %*"):format(err)))
                end
                wait = task.wait
                v1 = u65
                ServerTimeNow = Workspace:GetServerTimeNow()
                wait(if v1 ~= nil then if not (3600 < v1.StartsAt - ServerTimeNow) then 300 else 1800 else 3600)
            end
        end)
        task.spawn(function() -- Line: 324 -- upvalues: u66 (upval), u65 (upval), Workspace (upval), show (upval)
            local v1, v2, v3
            while true do
                if u66 == nil then
                    v3 = u65
                    v2 = if v3 == nil then nil else v3.StartsAt - Workspace:GetServerTimeNow()
                    v1 = false
                    if v2 ~= nil then
                        v1 = false
                        if v2 > 0 then
                            v1 = v2 <= 3600
                        end
                    end
                    if v1 then
                        show()
                    end
                end
                task.wait(1)
            end
        end)
    end,
}