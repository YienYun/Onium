-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController
-- Decompile time: 9.43 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Aim = require(script.Aim)
local Band = require(script.Band)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local BanjoCricketFlags = require(ReplicatedStorage.Shared.Flags.BanjoCricketFlags)
local Bridge = require(script.Bridge)
local Dream = require(script.Dream)
local Mushrooms = require(script.Mushrooms)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Reveal = require(script.Reveal)
local Save = require(ReplicatedStorage.Shared.Save)
local Sounds = require(script.Sounds)
local Spores = require(script.Spores)
local Talk = require(script.Talk)
local Timer = require(ReplicatedStorage.Packages.Timer)
return {
    Start = function() -- Line: 44
        -- upvalues: Players (val), Mushrooms (val), BanjoCricket (val), Sounds (val), Spores (val), Reveal (val)
        -- upvalues: BanjoCricketFlags (val), Save (val), Talk (val), Band (val), Bridge (val), Dream (val), Aim (val)
        -- upvalues: Remotes (val), Timer (val)
        local LocalPlayer = Players.LocalPlayer
        local u3 = Random.new()
        local u4 = "Idle"
        local u5 = 0
        local u6 = 0
        local u7 = nil
        local u8 = 0
        local u9 = 0

        local function sing(a1) -- Line: 54
            -- upvalues: Mushrooms (upval), BanjoCricket (upval), Sounds (upval), Spores (upval)
            Mushrooms.Flash(a1, BanjoCricket.Timing.Note)
            Mushrooms.Move(a1, "Bounce")
            Sounds.Note(a1)
            Spores.Puff(a1)
        end

        local function mute(a1) -- Line: 61 -- upvalues: Mushrooms (upval), Sounds (upval) -- types: a1: number
            Mushrooms.Move(a1, "Squish")
            Sounds.Muted(a1)
        end

        local function wasPredicted(a1, a2) -- Line: 80 -- upvalues: u7 (ref) -- types: a1: string, a2: number
            local v1 = u7
            if v1 ~= nil and v1.Kind == a1 and v1.Mushroom == a2 and not (1.2 < os.clock() - v1.At) then
                u7 = nil
                return true
            end
            return false
        end

        local function playback(a1) -- Line: 94
            -- upvalues: u5 (ref), u4 (ref), Mushrooms (upval), u6 (ref), BanjoCricket (upval), Sounds (upval)
            -- upvalues: Spores (upval)
            u5 = u5 + 1
            local u3 = u5
            u4 = "Showing"
            Mushrooms.Darken()
            Mushrooms.SetProgress(u6, true)
            local Timing = BanjoCricket.Timing
            local v1 = BanjoCricket.PlaybackSeconds(#a1)
            Sounds.Duck(v1 + 0.5)
            for i, j in a1 do
                task.delay((i - 1) * (Timing.Note + Timing.NoteGap), function() -- Line: 105
                    -- upvalues: u5 (upval), u3 (val), j (val), Mushrooms (upval), BanjoCricket (upval), Sounds (upval)
                    -- upvalues: Spores (upval)
                    if u5 == u3 then
                        local v1 = j
                        Mushrooms.Flash(v1, BanjoCricket.Timing.Note)
                        Mushrooms.Move(v1, "Bounce")
                        Sounds.Note(v1)
                        Spores.Puff(v1)
                    end
                end)
            end
            task.delay(v1, function() -- Line: 111 -- upvalues: u5 (upval), u3 (val), u4 (upval), Mushrooms (upval)
                if u5 == u3 then
                    u4 = "Listening"
                    Mushrooms.Pulse()
                end
            end)
        end

        local function undimBefore(a1, a2) -- Line: 119
            -- upvalues: u5 (ref), Mushrooms (upval)
            task.delay(math.max(a1 - 0.3, 0), function() -- Line: 120 -- upvalues: u5 (upval), a2 (val), Mushrooms (upval)
                if u5 == a2 then
                    Mushrooms.Darken()
                end
            end)
        end

        local function fail(a1) -- Line: 127
            -- upvalues: u5 (ref), u4 (ref), u7 (ref), u6 (ref), Mushrooms (upval), Sounds (upval), Spores (upval)
            -- upvalues: BanjoCricket (upval)
            u5 = u5 + 1
            local u3 = u5
            u4 = "Busy"
            u7 = nil
            u6 = 0
            Mushrooms.Dim()
            Mushrooms.MoveAll("Shake")
            Sounds.Fail(a1)
            Spores.Wilt()
            Mushrooms.SetProgress(u6, true)
            task.delay(math.max(BanjoCricket.Timing.WrongPause - 0.3, 0), function() -- Line: 120 -- upvalues: u5 (upval), u3 (val), Mushrooms (upval)
                if u5 == u3 then
                    Mushrooms.Darken()
                end
            end)
        end

        local function clearStage(a1) -- Line: 141
            -- upvalues: u5 (ref), u4 (ref), u6 (ref), Mushrooms (upval), Sounds (upval), Spores (upval), Reveal (upval)
            -- upvalues: BanjoCricketFlags (upval), BanjoCricket (upval)
            u5 = u5 + 1
            local u3 = u5
            u4 = "Busy"
            Mushrooms.SetProgress(a1, true)
            Sounds.Run()
            Spores.Spiral()
            Reveal.Strain(a1 / BanjoCricketFlags.Stages:Get())
            task.delay(0.35, function() -- Line: 150 -- upvalues: u5 (upval), u3 (val), Mushrooms (upval)
                if u5 == u3 then
                    Mushrooms.Dim()
                end
            end)
            task.delay(math.max(BanjoCricket.Timing.StagePause - 0.3, 0), function() -- Line: 120 -- upvalues: u5 (upval), u3 (val), Mushrooms (upval)
                if u5 == u3 then
                    Mushrooms.Darken()
                end
            end)
        end

        local function applySaved() -- Line: 230
            -- upvalues: Save (upval), u4 (ref), u6 (ref), BanjoCricketFlags (upval), Mushrooms (upval), Reveal (upval)
            -- upvalues: Talk (upval)
            local v1 = Save.Peek()
            if v1 == nil then
                return
            end
            local BanjoCricket = v1.BanjoCricket
            if not BanjoCricket.Solved then
                if not BanjoCricket.Solved and u4 == "Solved" then
                    u4 = "Idle"
                    u6 = 0
                    Mushrooms.SetProgress(u6, false)
                end
            elseif u4 ~= "Solved" then
                u4 = "Solved"
                u6 = BanjoCricketFlags.Stages:Get()
                Mushrooms.SetProgress(u6, true)
                Reveal.Open()
            elseif not BanjoCricket.Solved and u4 == "Solved" then
                u4 = "Idle"
                u6 = 0
                Mushrooms.SetProgress(u6, false)
            end
            Talk.Sync(BanjoCricket.Solved, BanjoCricket.Claimed)
        end

        Mushrooms.Start(function(a1) -- Line: 192 -- upvalues: u4 (ref), u8 (ref), Mushrooms (upval), Sounds (upval) -- types: a1: number
            if u4 ~= "Idle" and u4 ~= "Solved" then
                return
            end
            os.clock()
            Mushrooms.Move(a1, "Squish")
            Sounds.Soft(a1)
        end)
        Reveal.Start()
        Talk.Start()
        Band.Start()
        Bridge.Start()
        Dream.Start()
        Aim.Start(function(a1) -- Line: 68
            -- upvalues: u8 (ref), u4 (ref), Mushrooms (upval), Sounds (upval), u7 (ref), BanjoCricket (upval)
            -- upvalues: Spores (upval)
            local v1 = os.clock()
            u8 = v1
            if u4 ~= "Busy" and u4 ~= "Showing" then
                Mushrooms.Flash(a1, BanjoCricket.Timing.Note)
                Mushrooms.Move(a1, "Bounce")
                Sounds.Note(a1)
                Spores.Puff(a1)
                u7 = {Kind = "Note", Mushroom = a1, At = v1}
                return
            end
            Mushrooms.Move(a1, "Squish")
            Sounds.Muted(a1)
            u7 = {Kind = "Muted", Mushroom = a1, At = v1}
        end)
        Save.WatchFields({"BanjoCricket"}, applySaved)
        if not Save.IsLoaded() then
            Save.Loaded:Connect(applySaved)
        else
            applySaved()
        end
        Remotes.BanjoCricket.Effect.OnClientEvent:Connect(function(a1) -- Line: 158
            -- upvalues: u7 (ref), Mushrooms (upval), BanjoCricket (upval), Sounds (upval), Spores (upval), u4 (ref)
            -- upvalues: fail (val), playback (val), clearStage (val), u5 (ref), u6 (ref), BanjoCricketFlags (upval)
            -- upvalues: Reveal (upval)
            local v1, v2
            if a1.Kind == "Note" then
                v2 = u7
                if v2 == nil or v2.Kind ~= "Note" or v2.Mushroom ~= a1.Mushroom then
                    v1 = false
                elseif not (1.2 < os.clock() - v2.At) then
                    u7 = nil
                    v1 = true
                else
                    v1 = false
                end
                if not v1 then
                    local Mushroom_2 = a1.Mushroom
                    Mushrooms.Flash(Mushroom_2, BanjoCricket.Timing.Note)
                    Mushrooms.Move(Mushroom_2, "Bounce")
                    Sounds.Note(Mushroom_2)
                    Spores.Puff(Mushroom_2)
                end
                if u4 ~= "Idle" then
                    return
                end
                u4 = "Busy"
                return
            end
            if a1.Kind == "Muted" then
                v2 = u7
                if v2 == nil or v2.Kind ~= "Muted" or v2.Mushroom ~= a1.Mushroom then
                    v1 = false
                elseif not (1.2 < os.clock() - v2.At) then
                    u7 = nil
                    v1 = true
                else
                    v1 = false
                end
                if v1 then
                    return
                end
                local Mushroom_4 = a1.Mushroom
                Mushrooms.Move(Mushroom_4, "Squish")
                Sounds.Muted(Mushroom_4)
                return
            end
            if a1.Kind == "Wrong" then
                fail(a1.Mushroom)
                return
            end
            if a1.Kind == "Playback" then
                playback(a1.Notes)
                return
            end
            if a1.Kind == "StageComplete" then
                clearStage(a1.Cleared)
                return
            end
            if a1.Kind == "Reset" then
                u5 = u5 + 1
                u4 = "Idle"
                u7 = nil
                u6 = 0
                Mushrooms.Darken()
                Mushrooms.SetProgress(u6, false)
                return
            end
            if a1.Kind == "Solved" then
                u5 = u5 + 1
                u4 = "Solved"
                u6 = BanjoCricketFlags.Stages:Get()
                Mushrooms.SetProgress(u6, true)
                Reveal.Play()
            end
        end)
        Remotes.BanjoCricket.Squish.OnClientEvent:Connect(function(a1) -- Line: 265 -- upvalues: Mushrooms (upval) -- types: a1: number
            Mushrooms.Squish(a1)
        end)
        Timer.Simple(0.5, function() -- Line: 202
            -- upvalues: u4 (ref), u9 (ref), u8 (ref), BanjoCricketFlags (upval), LocalPlayer (val), Mushrooms (upval)
            -- upvalues: u3 (val), Sounds (upval)
            local v1 = os.clock()
            if u4 == "Idle" and not (v1 < u9) and not (v1 - u8 < 6) and BanjoCricketFlags.Enabled:Get() then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart ~= nil
                    and HumanoidRootPart:IsA("BasePart")
                    and not (35 < (Mushrooms.DistanceFrom(HumanoidRootPart.Position))) then
                    local v2 = Mushrooms.RandomIndex(u3)
                    if v2 == nil then
                        return
                    end
                    u9 = v1 + u3:NextNumber(4, 7)
                    Mushrooms.Move(v2, "Hop")
                    Sounds.Soft(v2, -1)
                    return
                end
                return
            end
        end)
    end,
}