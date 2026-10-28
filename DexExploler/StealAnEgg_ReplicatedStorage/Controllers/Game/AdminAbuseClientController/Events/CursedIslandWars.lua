-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars
-- Decompile time: 26.78 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Cinema = require(script.Cinema)
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local Fx = require(script.Fx)
local Hud = require(script.Hud)
local Input = require(script.Input)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local State = require(script.State)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u103 = require((LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule")):GetControls()
local Sounds = ReplicatedStorage.Assets.Sounds
local Music = CursedIslandWars.Assets.Music
local SuddenDeathMusic = CursedIslandWars.Assets.SuddenDeathMusic
local u114 = Color3.fromRGB(255, 60, 60)
local u119 = Color3.fromRGB(255, 140, 30)
local u124 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u126 = Trove.new()
local u127 = nil
local u128 = 0
local u129 = 0
task.spawn(function() -- Line: 46
    -- upvalues: CursedIslandWars (val), Workspace (val), RunService (val), LocalPlayer (val), Preload (val)
    local ShowAt = CursedIslandWars.ShowAt
    local ServerTimeNow = Workspace:GetServerTimeNow()
    if ShowAt + 3600 < ServerTimeNow then
        return
    end
    if not RunService:IsStudio() then
        local v1
        local v2 = Random.new(LocalPlayer.UserId + ShowAt)
        local v3 = ShowAt - 3600
        if ServerTimeNow < v3 then
            task.wait(v3 - ServerTimeNow)
        end
        task.wait(v2:NextNumber(0, if not v1 then 60 else 600))
    end
    Preload.WarmAtWorkspace(script.Name, {CursedIslandWars.Assets})
end)

local function teamOf(a1) -- Line: 67 -- upvalues: State (val) -- types: a1: string?
    local v1 = State.Entry(a1)
    if v1 then
        return v1.Team
    end
    return "Red"
end

local function eyesPosition() -- Line: 72 -- upvalues: State (val)
    local v1 = State.Island()
    local Pieces = if not v1 then nil else if not v1.Parent then nil else v1.Parent:FindFirstChild("Pieces")
    v1 = if not Pieces then nil else Pieces:FindFirstChild("SkyEyes")
    if v1 then
        return v1:GetPivot().Position
    end
    return nil
end

local function safeZone(a1) -- Line: 79 -- upvalues: State (val), Fx (val), Hud (val) -- types: a1: boolean
    local v1 = State.Island()
    Fx.SafeZone(a1)
    Hud.SafeZone(if not a1 then nil else if not v1 then nil else v1.Centre.Top)
end

local function playOutro() -- Line: 85 -- upvalues: Hud (val), u126 (val), Remotes (val)
    Hud.Hide()
    xpcall((require(script.Cutscenes.OutroCutscene)(u126)).Run, warn)
    Remotes.IslandWars.OutroFinished:FireServer()
end

local function onCrystal(a1, a2, a3) -- Line: 92
    -- upvalues: State (val), CursedIslandWars (val), Fx (val), u129 (ref), Hud (val), u114 (val), Cinema (val)
    local v1 = State.Me()
    local v2 = false
    if v1 ~= nil then
        v2 = v1.Team == a2
    end
    v1 = CursedIslandWars.Teams[a2]
    if a1 ~= "CrystalHit" then
        if a1 == "CrystalStage" then
            Fx.CrystalStage(a2, a3)
            Cinema.Shake(0.2)
            return
        end
        if a1 == "CrystalShattered" then
            Fx.CrystalShattered(a2)
            Fx.Eyes("Flare")
            Cinema.Shake(0.8)
            if a3 then
                Hud.Banner(("%* shattered the %* CRYSTAL!"):format(a3, v1.Name), ("%* can no longer respawn."):format(v1.Name), v1.Color, 4)
                task.delay(1.5, function() -- Line: 118 -- upvalues: State (upval), Fx (upval)
                    if State.Phase() == "Match" then
                        Fx.Eyes("Open")
                    end
                end)
            end
        end
        return
    end
    local Snapshot = State.Snapshot
    local v3 = if not Snapshot then nil else Snapshot.Crystals[a2]
    local v4 = if not v3 then 1 else a3 / v3.MaxHealth
    Fx.CrystalHit(a2, v4)
    if v2 and 6 < os.clock() - u129 then
        os.clock()
        Hud.Banner("YOUR CRYSTAL IS UNDER ATTACK!", nil, u114, 2)
        Hud.Hurt()
    end
    if not (v4 <= 0.25) then
        return
    end
    Fx.Eyes("Narrow")
end

local function onBarrier(a1, a2, a3, a4) -- Line: 127
    -- upvalues: State (val), CursedIslandWars (val), Fx (val), u129 (ref), Hud (val), u114 (val), Cinema (val)
    local v1 = State.Me()
    local v2 = false
    if v1 ~= nil then
        v2 = v1.Team == a2
    end
    v1 = CursedIslandWars.Teams[a2]
    if a1 == "BarrierHit" then
        local Snapshot = State.Snapshot
        local v3 = if not Snapshot then nil else Snapshot.Barriers[a2]
        Fx.BarrierHit(a2, if not v3 then 1 else a3 / v3.MaxHealth, a4)
        if v2 and 6 < os.clock() - u129 then
            os.clock()
            Hud.Banner("YOUR WALL IS UNDER ATTACK!", nil, u114, 2)
            return
        end
        return
    end
    if a1 == "BarrierStage" then
        Fx.BarrierStage(a2, a3)
        Cinema.Shake(0.15)
        return
    end
    if a1 == "BarrierBroken" then
        Fx.BarrierBroken(a2)
        Cinema.Shake(0.5)
        Hud.Banner(
            if not a3 then ("The %* WALL is down!"):format(v1.Name) else ("%* broke the %* WALL!"):format(a3, v1.Name),
            ("The %* CRYSTAL can now be destroyed."):format(v1.Name),
            v1.Color,
            4
        )
    end
end

local function onMoment(a1, ...) -- Line: 150
    -- upvalues: State (val), Fx (val), Cinema (val), Hud (val), u114 (val), u119 (val), onCrystal (val)
    -- upvalues: onBarrier (val), Sounds (val), Audio (val), Workspace (val), u127 (ref), u126 (val), LocalPlayer (val)
    -- upvalues: playOutro (val), Input (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = State.Me()
    local Id = if not v7 then nil else v7.Id
    if a1 == "Launch" then
        local v8
        v1, v2, v3, v4, v8 = ...
        if v1 == Id then
            return
        end
        local Launch = Fx.Launch
        v6 = ("%*:%*"):format(v1, v2)
        v7 = State.Entry(v1)
        Launch(v6, v3, v4, v8, if not v7 then "Red" else v7.Team)
        return
    end
    if a1 == "Lock" then
        v1, v2, v3, v4 = ...
        Fx.Lock(("%*:%*"):format(v1, v2), v3, State.Root(State.Entry(v4)))
        return
    end
    if a1 == "Impact" then
        v1, v2 = ...
        Fx.Land((("%*:%*"):format(v1, v2)))
        return
    end
    if a1 == "Explode" then
        v1, v2 = ...
        Fx.Explode(v1, v2)
        v6 = if not v3 then 35 else 70
        Cinema.ShakeAt(v2, if not (v1 == "Mine") then 0.3 else 0.7, v6)
        return
    end
    if a1 == "Mine" then
        v1, v2 = ...
        local Mine = Fx.Mine
        v5 = State.Entry(v1)
        Mine(v2, if not v5 then "Red" else v5.Team)
        return
    end
    if a1 == "MineTrigger" then
        Fx.MineTrigger(...)
        return
    end
    if a1 == "Built" then
        v1, v2 = ...
        Fx.Built(v1, v2)
        return
    end
    if a1 == "Bricks" then
        Fx.Bricks(...)
        return
    end
    if a1 == "Pad" then
        v1, v2 = ...
        local Pad = Fx.Pad
        v5 = State.Entry(v1)
        Pad(v2, if not v5 then "Red" else v5.Team)
        return
    end
    if a1 == "PadLaunch" then
        v1, v2 = ...
        v3 = State.Entry(v2)
        if v2 ~= Id and v3 then
            Fx.PadLaunch(v1, v3.Model, v3.Team)
            return
        end
        return
    end
    if a1 == "Hit" then
        v1, v2, v3 = ...
        v4 = State.Entry(v1)
        Fx.Hit(if not v4 then nil else v4.Model)
        if v1 == Id then
            Hud.Hurt()
            Cinema.Shake(0.25)
            return
        end
        if v3 ~= nil and v3 == Id then
            Hud.HitMarker(if not v4 then nil else v4.Model, v2)
            return
        end
        return
    end
    if a1 == "Knockout" then
        v1, v2, v3, v4 = ...
        Fx.Knockout(v2)
        Hud.Knockout(v1, v3, v4)
        if v1 == Id then
            Cinema.Shake(0.5)
            Hud.Banner(if not v4 then "KNOCKED OUT" else "ELIMINATED", nil, u114, 2)
            return
        end
        if v3 ~= nil and v3 == Id then
            Hud.Banner("KNOCKOUT!", nil, u119, 1.2)
            return
        end
        return
    end
    if a1 == "Respawn" then
        v1, v2 = ...
        v3 = State.Entry(v1)
        local Respawn = Fx.Respawn
        local Model_3 = if not v3 then nil else v3.Model
        local v9 = State.Entry(v1)
        Respawn(v1, v2, Model_3, if not v9 then "Red" else v9.Team)
        return
    end
    if a1 == "ShieldEnded" then
        Fx.EndShield(...)
        return
    end
    if a1 ~= "CrystalHit" and a1 ~= "CrystalStage" and a1 ~= "CrystalShattered" then
        if a1 ~= "BarrierHit" and a1 ~= "BarrierStage" and a1 ~= "BarrierBroken" then
            if a1 == "PickupDrop" then
                v1, v2 = ...
                Fx.PickupDrop(v1, v2)
                return
            end
            if a1 == "PickupTaken" then
                v1, v2, v3 = ...
                Fx.PickupTaken(v1, v2)
                if v3 ~= Id then
                    return
                end
                Fx.Ui(Sounds.MountRace.CountdownGo, 1.3, 0.8)
                return
            end
            if a1 == "WallsOpen" then
                Fx.WallsOpen(...)
                Hud.WallsOpen()
                Fx.Eyes("Open")
                Fx.Ui(Sounds.MountRace.CountdownGo, 1, 1.2)
                Cinema.Shake(0.4)
                return
            end
            if a1 == "Warning" then
                v1 = ...
                local Snapshot = State.Snapshot
                v3 = 0
                for i, j in if not Snapshot then {} else Snapshot.Crystals do
                    if 0 < j.Health then
                        v3 = v3 + 1
                    end
                end
                if not (v1 <= 15) then
                    Hud.Banner(
                        "THE ISLAND IS CRUMBLING...",
                        if not (v3 > 1) then ("The last crystal breaks in %* seconds!"):format(v1) else ("The crystals break in %* seconds!"):format(v1),
                        u119,
                        3
                    )
                else
                    Hud.Banner(("SUDDEN DEATH IN %*!"):format(v1), "The island falls from the edges in. Head for the centre!", u114, 4)
                    v2 = State.Island()
                    Fx.SafeZone(true)
                    Hud.SafeZone(if not v2 then nil else v2.Centre.Top)
                end
                Fx.Eyes("Narrow")
                return
            end
            if a1 == "EarlySuddenDeath" then
                Hud.Banner(
                    "BOTH CRYSTALS SHATTERED!",
                    ("Sudden Death in %*! The island falls from the edges in. Head for the centre!"):format((...)),
                    u114,
                    4
                )
                v1 = State.Island()
                Fx.SafeZone(true)
                Hud.SafeZone(if not v1 then nil else v1.Centre.Top)
                Fx.Eyes("Narrow")
                return
            end
            if a1 == "SuddenDeath" then
                v1 = State.Island()
                Fx.SafeZone(true)
                Hud.SafeZone(if not v1 then nil else v1.Centre.Top)
                Hud.Banner("SUDDEN DEATH", "No more respawns. Get to the centre!", u114, 4)
                Fx.Eyes("Flare")
                Fx.SuddenDeath()
                Cinema.Shake(0.6)
                v1 = Audio.Play(Sounds.ScrambleBoss.Rumble, Workspace.CurrentCamera, {Looped = true, Volume = 1.2})
                if not v1 then
                    return
                end
                u127 = v1
                u126:Add(v1)
                return
            end
            if a1 == "CollapseWarn" then
                v1, v2 = ...
                Fx.CollapseWarn(v1, v2)
                Hud.Alarm(v1, State.Now() + v2)
                Cinema.Shake(0.25)
                return
            end
            if a1 == "CollapseDrop" then
                v1, v2, v3 = ...
                Fx.CollapseDrop(v1, v2, v3)
                Cinema.Shake(0.5)
                return
            end
            if a1 ~= "Win" then
                if a1 == "Outro" then
                    task.spawn(playOutro)
                    return
                end
                if a1 == "Knock" then
                    Input.Knock(...)
                    return
                end
                if a1 == "Cooldown" then
                    v1, v2 = ...
                    Input.SetCooldown(v1, v2)
                end
                return
            end
            v1, v2 = ...
            v3 = u127
            u127 = nil
            if v3 then
                v3:Destroy()
            end
            State.Island()
            Fx.SafeZone(false)
            Hud.SafeZone(nil)
            Hud.Win(v1, v2)
            Fx.Eyes("Closed")
            local Character = LocalPlayer.Character
            v1 = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
            Fx.Victory(if not v1 then Workspace.CurrentCamera.CFrame else v1.CFrame)
            return
        end
        v1, v2, v3 = ...
        onBarrier(a1, v1, v2, v3)
        return
    end
    v1, v2 = ...
    onCrystal(a1, v1, v2)
end

local function matchMusic(a1) -- Line: 300
    -- upvalues: Music (val), SuddenDeathMusic (val), SoundService (val), TweenService (val), u124 (val)
    -- upvalues: Preferences (val), MusicDirector (val), Debris (val)
    local v1, v2
    local u1 = {}
    for i, j in {Music, SuddenDeathMusic} do
        v1 = j:Clone()
        v2 = {Sound = v1, Volume = v1.Volume}
        u1[j] = v2
        v1.Volume = 0
        v1.Parent = SoundService
    end
    local u14 = nil
    local u15 = true

    local function apply() -- Line: 310 -- upvalues: u1 (val), u15 (ref), u14 (ref), TweenService (upval), u124 (upval)
        local v1, v2
        local v3 = nil
        local v4 = nil
        for i, j in u1, v3, v4 do
            v1 = u15 and i == u14
            if v1 and not j.Sound.IsPlaying then
                j.Sound:Play()
            end
            v2 = u124
            TweenService:Create(j.Sound, v2, {Volume = if not v1 then 0 else j.Volume}):Play()
        end
    end

    a1:Add((Preferences.Observe("Music", function(a1) -- Line: 319 -- upvalues: u15 (ref), apply (val) -- types: a1: boolean?
        u15 = a1 ~= false
        apply()
    end)))
    a1:Add(function() -- Line: 323
        -- upvalues: u14 (ref), MusicDirector (upval), u1 (val), TweenService (upval), u124 (upval), Debris (upval)
        if u14 then
            MusicDirector.SetEventMusic(false)
        end
        for i, j in u1 do
            TweenService:Create(j.Sound, u124, {Volume = 0}):Play()
            Debris:AddItem(j.Sound, u124.Time)
        end
    end)
    return function(a1) -- Line: 332 -- upvalues: u14 (ref), MusicDirector (upval), apply (val) -- types: a1: userdata?
        if u14 ~= a1 then
            if u14 == nil ~= (a1 == nil) then
                MusicDirector.SetEventMusic(a1 ~= nil)
            end
            u14 = a1
            apply()
        end
    end
end

local function watchPhases(a1) -- Line: 343
    -- upvalues: matchMusic (val), LightingController (val), u103 (val), State (val), SuddenDeathMusic (val)
    -- upvalues: Music (val), Hud (val), eyesPosition (val), Fx (val), Cinema (val), RunService (val), Sounds (val)
    local u3 = matchMusic(a1)
    local u4 = nil
    local u5 = nil
    local u6 = 0
    local u7 = false
    a1:Add(function() -- Line: 349 -- upvalues: LightingController (upval), u7 (ref), u103 (upval)
        LightingController.ClearLayer("CursedIslandWars", 2)
        if u7 then
            u103:Enable()
        end
    end)
    a1:Add((State.Changed:Connect(function(a1) -- Line: 355
        -- upvalues: u5 (ref), u7 (ref), u103 (upval), u4 (ref), SuddenDeathMusic (upval), Music (upval), u3 (val)
        -- upvalues: LightingController (upval), State (upval), Hud (upval), eyesPosition (upval), Fx (upval)
        -- upvalues: Cinema (upval)
        local Phase
        if (if not a1 then nil else a1.Phase) == u5 then
            return
        end
        u5 = Phase
        local v1 = true
        if Phase ~= "Intro" then
            v1 = Phase == "Reveal"
        end
        if v1 ~= u7 then
            u7 = v1
            if not v1 then
                u103:Enable()
            else
                u103:Disable()
            end
        end
        v1 = false
        if Phase ~= nil then
            v1 = false
            if Phase ~= "Intro" then
                v1 = Phase ~= "Outro"
            end
        end
        u4 = if v1 then if Phase ~= "SuddenDeath" then not (Phase ~= "Win") and u4 or Music else SuddenDeathMusic else nil
        u3(u4)
        if not v1 then
            LightingController.ClearLayer("CursedIslandWars", 2)
        else
            LightingController.SetLayer("CursedIslandWars", "CursedIslandWars", 25, 2)
        end
        if Phase == "Reveal" then
            v1 = State.Me()
            if v1 then
                Hud.TeamCard(v1.Team)
            end
            task.delay(2.6, function() -- Line: 389 -- upvalues: eyesPosition (upval), State (upval), Fx (upval), Cinema (upval)
                local v1 = eyesPosition()
                if v1 and State.Phase() == "Reveal" then
                    Fx.Eyes("Open")
                    Cinema.Reveal(v1)
                end
                Fx.Pillars(true)
            end)
            return
        end
        if Phase == "Prep" or Phase == "Match" or Phase == "SuddenDeath" then
            Fx.Pillars(true)
        end
    end)))
    a1:Add((RunService.Heartbeat:Connect(function() -- Line: 401 -- upvalues: State (upval), u6 (ref), Fx (upval), Sounds (upval)
        local Snapshot = State.Snapshot
        if Snapshot ~= nil and Snapshot.Phase == "Prep" then
            local v1 = math.ceil(Snapshot.PhaseEndsAt - (State.Now()))
            if v1 <= 5 and v1 >= 1 and v1 ~= u6 then
                u6 = v1
                Fx.Ui(Sounds.MountRace.CountdownTick, (5 - v1) * 0.08 + 1, 1)
            end
            return
        end
    end)))
end

return {
    StartEvent = function(a1, a2, a3) -- Line: 416
        -- upvalues: u126 (val), u129 (ref), State (val), Remotes (val), onMoment (val), Fx (val), Cinema (val)
        -- upvalues: Input (val), watchPhases (val), u128 (ref), Hud (val)
        u126:Clean()
        u129 = 0
        local v1 = a3 or {}
        local v2 = u126:Extend()
        State.Set(nil)
        v2:Add(function() -- Line: 422 -- upvalues: State (upval)
            State.Set(nil)
        end)
        v2:Add((Remotes.IslandWars.State.OnClientEvent:Connect(State.Set)))
        v2:Add((Remotes.IslandWars.Moment.OnClientEvent:Connect(onMoment)))
        Fx.Start(v2)
        Cinema.Start(v2)
        Input.Start(v2)
        watchPhases(v2)
        task.spawn(function() -- Line: 431 -- upvalues: Remotes (upval), State (upval)
            local v1 = Remotes.IslandWars.Fetch:InvokeServer()
            if State.Snapshot == nil and v1 ~= nil then
                State.Set(v1)
            end
        end)
        u128 = u128 + 1
        local v3 = u128
        if not v1.SkipCutscenes and not v1.WasInProgress then
            xpcall((require(script.Cutscenes.IntroCutscene)(v2)).Run, warn)
        end
        if u128 == v3 then
            Hud.Start(v2)
        end
    end,
    StopEvent = function(a1) -- Line: 448 -- upvalues: u128 (ref), u126 (val)
        u128 = u128 + 1
        u126:Clean()
    end,
}