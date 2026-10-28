-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Music
-- Decompile time: 4.04 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Music = (ReplicatedStorage.Assets.Sounds:WaitForChild("ScrambleBoss")):WaitForChild("Music")
local u48 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u53 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v1 = {}

local function trackFor(a1) -- Line: 25 -- types: a1: userdata
    local v1 = a1:GetAttribute("Phase") or "Waiting"
    if v1 == "Defeated" then
        return nil
    end
    if v1 ~= "Ball" and v1 ~= "Human" and v1 ~= "Final" then
        if a1:GetAttribute("PhaseTwo") then
            return "PhaseTwo"
        end
        return "PhaseOne"
    end
    return "PhaseThree"
end

function v1.new(a1, a2, a3) -- Line: 38
    -- upvalues: Music (val), SoundService (val), TweenService (val), MusicDirector (val), u48 (val), u53 (val)
    -- upvalues: Preferences (val), RunService (val), Debris (val)
    local v1
    local u3 = {}
    local u4 = {}
    local u5 = {}
    local u6 = nil
    local u7 = false
    local u8 = false
    for i, j in Music:GetChildren() do
        if j:IsA("Sound") then
            v1 = j:Clone()
            u4[v1.Name] = v1.Volume
            v1.Volume = 0
            v1.Parent = SoundService
            u3[v1.Name] = v1
        end
    end

    local function fade(a1, a2, a3) -- Line: 56
        -- upvalues: u5 (val), TweenService (upval)
        local v1 = u5[a1]
        if v1 then
            v1:Cancel()
        end
        if a2 > 0 and not a1.IsPlaying then
            a1.TimePosition = 0
            a1:Play()
        end
        local u26 = TweenService:Create(a1, a3, {Volume = a2})
        u5[a1] = u26
        u26.Completed:Once(function(a1_2) -- Line: 69 -- upvalues: u5 (upval), a1 (val), u26 (val), a2 (val)
            if u5[a1] == u26 then
                u5[a1] = nil
            end
            if a1_2 == Enum.PlaybackState.Completed and a2 <= 0 then
                a1:Stop()
            end
        end)
        u26:Play()
    end

    local function apply() -- Line: 80
        -- upvalues: a3 (val), u7 (ref), MusicDirector (upval), u8 (ref), a2 (val), u6 (ref), u3 (val), fade (val)
        -- upvalues: u4 (val), u48 (upval), u53 (upval)
        local v1, v2, v3, v4
        local v5 = a3:InArena()
        if v5 ~= u7 then
            MusicDirector.SetEventMusic(v5)
        end
        if not u8 or not u7 then
            v5 = nil
        else
            v1 = a2
            v3 = v1:GetAttribute("Phase") or "Waiting"
            v5 = if v3 ~= "Defeated" then if v3 == "Ball" then "PhaseThree" else if v3 == "Human" then "PhaseThree" else if v3 ~= "Final" then if not v1:GetAttribute("PhaseTwo") then "PhaseOne" else "PhaseTwo" else "PhaseThree" else nil
        end
        if v5 == u6 then
            return
        end
        v1 = u6
        u6 = v5
        v3 = a2:GetAttribute("Phase") == "Defeated"
        local v6 = nil
        local v7 = nil
        for i, j in u3, v6, v7 do
            if i == v5 then
                v4 = fade
                v2 = u4[i]
                v4(j, v2, u48)
            elseif i == v1 then
                fade(j, 0, if not v3 then u48 else u53)
            end
        end
    end

    a1:Add((Preferences.Observe("Music", function(a1) -- Line: 104 -- upvalues: u8 (ref), apply (val) -- types: a1: boolean?
        u8 = a1 ~= false
        apply()
    end)))
    a1:Connect(RunService.Heartbeat, apply)
    a1:Add(function() -- Line: 111
        -- upvalues: u3 (val), u5 (val), TweenService (upval), u48 (upval), Debris (upval), u7 (ref)
        -- upvalues: MusicDirector (upval)
        local Time, v1, v2
        local v3 = nil
        local v4 = nil
        for i, j in u3, v3, v4 do
            v1 = u5[j]
            if v1 then
                v1:Cancel()
            end
            TweenService:Create(j, u48, {Volume = 0}):Play()
            v2 = Debris
            Time = u48.Time
            v2:AddItem(j, Time)
        end
        if u7 then
            MusicDirector.SetEventMusic(false)
        end
    end)
    apply()
end

return v1