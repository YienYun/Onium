-- Script path: ReplicatedStorage.Controllers.GUI.GameResetTimerController
-- Decompile time: 9.47 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local EggState = require(ReplicatedStorage.Client.EggState)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local u73 = Color3.fromRGB(255, 64, 64)
return {
    Start = function() -- Line: 31
        -- upvalues: GUI (val), Hud (val), AreaEggCycle (val), Workspace (val), Players (val), u73 (val), Player (val)
        -- upvalues: Save (val), SakuraBloomPolicy (val), Sakura (val), AreaEggResetCycle (val), Elapsed (val)
        -- upvalues: EggState (val), Remotes (val), RunService (val)
        local u2 = GUI.TutorialInstructions()
        assert(u2:IsA("ScreenGui"), "TutorialInstructions must be a ScreenGui")
        local NightTimer = Hud.Every("NightTimer")
        local NightTimerValue = Hud.Get("NightTimerValue")
        local NightTimerIcon = Hud.Get("NightTimerIcon")
        local u26 = Hud.Find("NightTimerValue", "Treadmill")
        local u31 = Hud.Find("NightTimerIcon", "Treadmill")
        local Image = NightTimerIcon.Image
        local Image_2 = if u31 == nil then "" else u31.Image
        local TextColor3 = NightTimerValue.TextColor3
        local u37 = -1
        local u38 = false
        local u45 = AreaEggCycle.PeriodIndexAt(Workspace:GetServerTimeNow())
        local u46 = false
        local u47 = false
        local Enabled = u2.Enabled
        local u52 = AreaEggCycle.IsRunning()
        local u53 = false
        local u54 = false
        local Enabled_2 = u2.Enabled
        local LocalPlayer = Players.LocalPlayer
        local Bounds = (((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("CherryBlossom")):WaitForChild("Bounds")
        assert(Bounds:IsA("BasePart"), "CherryBlossom.Bounds must be a BasePart")

        local function getBlinkColor(a1, a2, a3) -- Line: 68
            -- upvalues: AreaEggCycle (upval), u73 (upval)
            if not a2 and AreaEggCycle.IsInFinalBlink(a1) and AreaEggCycle.IsBlinkOnRedFrame(a1) then
                return u73
            end
            return a3
        end

        local function setNightTimerVisible(a1) -- Line: 80 -- upvalues: NightTimer (val) -- types: a1: boolean
            for i, j in NightTimer do
                j.Visible = a1
            end
        end

        local function setTimer(a1, a2) -- Line: 86
            -- upvalues: NightTimer (val), NightTimerValue (val), u26 (val)
            for i, j in NightTimer do
                j.Visible = true
            end
            NightTimerValue.Text = a1
            NightTimerValue.TextColor3 = a2
            if u26 ~= nil then
                u26.Text = a1
                u26.TextColor3 = a2
            end
        end

        local function setNormalTimer(a1, a2, a3) -- Line: 96
            -- upvalues: TextColor3 (val), AreaEggCycle (upval), u73 (upval), NightTimer (val), NightTimerValue (val)
            -- upvalues: u26 (val)
            local v1 = TextColor3
            local v2 = if a2 then v1 else if not AreaEggCycle.IsInFinalBlink(a1) then v1 else if not AreaEggCycle.IsBlinkOnRedFrame(a1) then v1 else u73
            for i, j in NightTimer do
                j.Visible = true
            end
            NightTimerValue.Text = a3
            NightTimerValue.TextColor3 = v2
            if u26 ~= nil then
                u26.Text = a3
                u26.TextColor3 = v2
            end
        end

        local function setEndingSoonTimer(a1, a2, a3) -- Line: 100
            -- upvalues: u73 (upval), AreaEggCycle (upval), NightTimer (val), NightTimerValue (val), u26 (val)
            local v1 = u73
            local v2 = if a2 then v1 else if not AreaEggCycle.IsInFinalBlink(a1) then v1 else if not AreaEggCycle.IsBlinkOnRedFrame(a1) then v1 else u73
            for i, j in NightTimer do
                j.Visible = true
            end
            NightTimerValue.Text = a3
            NightTimerValue.TextColor3 = v2
            if u26 ~= nil then
                u26.Text = a3
                u26.TextColor3 = v2
            end
        end

        local function isInsideCherryBlossom() -- Line: 104 -- upvalues: Player (upval), LocalPlayer (val), Bounds (val)
            local v1 = Player.FindPrimaryPart(LocalPlayer)
            if v1 == nil then
                return false
            end
            local v2 = Bounds.CFrame:PointToObjectSpace(v1.Position)
            local v3 = false
            if (math.abs(v2.X)) <= Bounds.Size.X / 2 then
                v3 = (math.abs(v2.Z)) <= Bounds.Size.Z / 2
            end
            return v3
        end

        local function isBloomUnlocked() -- Line: 114 -- upvalues: Save (upval), SakuraBloomPolicy (upval)
            local v1 = Save.IsLoaded()
            return SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
        end

        local function refreshTimer(a1) -- Line: 120
            -- upvalues: AreaEggCycle (upval), u52 (ref), NightTimer (val), Workspace (upval), Sakura (upval)
            -- upvalues: Save (upval), SakuraBloomPolicy (upval), isInsideCherryBlossom (val), u37 (ref), u38 (ref)
            -- upvalues: u45 (ref), u53 (ref), u46 (ref), u54 (ref), u47 (ref), Enabled_2 (ref), Enabled (ref)
            -- upvalues: AreaEggResetCycle (upval), Elapsed (upval), NightTimerIcon (val), Image (val), u31 (val)
            -- upvalues: Image_2 (val), u73 (upval), NightTimerValue (val), u26 (val), TextColor3 (val)
            local v1, v2
            local v3 = AreaEggCycle.IsRunning()
            if v3 ~= u52 then
                u52 = v3
                a1 = true
            end
            if not v3 then
                for m, i5 in NightTimer do
                    i5.Visible = false
                end
                return
            end
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local v4 = AreaEggCycle.ActivePeriodIndexAt(ServerTimeNow)
            local v5 = AreaEggCycle.IsNightPhase(ServerTimeNow)
            local v6 = math.ceil((AreaEggCycle.SecondsUntilPhaseEnd(ServerTimeNow)))
            local Attribute = Workspace:GetAttribute(Sakura.Bloom.EndsAtAttribute)
            local v7 = Save.IsLoaded()
            local v8 = if not v7 then nil else Save.Peek()
            local v9 = SakuraBloomPolicy.HasBloomUnlocked(v7, v8)
            if v9 then
                v9 = false
                if typeof(Attribute) == "number" then
                    v9 = false
                    if ServerTimeNow < Attribute then
                        v9 = isInsideCherryBlossom()
                    end
                end
            end
            v7 = if not v9 then v6 else math.ceil(Attribute - ServerTimeNow)
            if not a1
                and v7 == u37
                and v9 == u38
                and v4 == u45
                and u53 == u46
                and u54 == u47
                and Enabled_2 == Enabled then
                return
            end
            u37 = v7
            u38 = v9
            u45 = v4
            u46 = u53
            u47 = u54
            Enabled = Enabled_2
            local SunIcon = if not v5 then Workspace:GetAttribute("NightIconOverride") or AreaEggResetCycle.MoonIcon else AreaEggResetCycle.SunIcon
            v4 = "in " .. Elapsed(v6)
            if v9 then
                SunIcon = "rbxassetid://71612969542341"
                v4 = "ends in " .. Elapsed(v7)
            end
            NightTimerIcon.Image = if SunIcon == "" then Image else SunIcon
            if u31 ~= nil then
                u31.Image = if SunIcon == "" then if Image_2 == "" then Image else Image_2 else SunIcon
            end
            if not v9 and not v5 and AreaEggCycle.IsCloseToReset(v6) and not u53 and not u54 and not Enabled_2 then
                v1 = u73
                v2 = if v5 then v1 else if not AreaEggCycle.IsInFinalBlink(v6) then v1 else if not AreaEggCycle.IsBlinkOnRedFrame(v6) then v1 else u73
                for i, j in NightTimer do
                    j.Visible = true
                end
                NightTimerValue.Text = v4
                NightTimerValue.TextColor3 = v2
                if u26 == nil then
                    return
                end
                u26.Text = v4
                u26.TextColor3 = v2
                return
            end
            v1 = TextColor3
            v2 = if v5 then v1 else if not AreaEggCycle.IsInFinalBlink(v6) then v1 else if not AreaEggCycle.IsBlinkOnRedFrame(v6) then v1 else u73
            for k, n in NightTimer do
                n.Visible = true
            end
            NightTimerValue.Text = v4
            NightTimerValue.TextColor3 = v2
            if u26 ~= nil then
                u26.Text = v4
                u26.TextColor3 = v2
            end
        end

        refreshTimer()
        EggState.CarryChanged:Connect(function(a1) -- Line: 196 -- upvalues: u53 (ref), refreshTimer (val)
            u53 = a1.IsCarrying
            refreshTimer(true)
        end)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 201 -- upvalues: u54 (ref), refreshTimer (val) -- types: a1: string?
            u54 = a1 ~= nil
            refreshTimer(true)
        end)
        ;(u2:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 206 -- upvalues: Enabled_2 (ref), u2 (val), refreshTimer (val)
            Enabled_2 = u2.Enabled
            refreshTimer(true)
        end)
        Save.WatchFields("Sakura", function() -- Line: 211 -- upvalues: refreshTimer (val)
            refreshTimer(true)
        end)
        RunService.Heartbeat:Connect(function(a1) -- Line: 213 -- upvalues: refreshTimer (val) -- types: a1: number
            refreshTimer()
        end)
    end,
}