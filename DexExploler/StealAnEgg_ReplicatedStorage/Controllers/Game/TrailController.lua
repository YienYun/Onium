-- Script path: ReplicatedStorage.Controllers.Game.TrailController
-- Decompile time: 4.70 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trails = require(ReplicatedStorage.Data.Trails)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u40 = Log.new()
return {
    Start = function() -- Line: 35
        -- upvalues: ReplicatedStorage (val), Trails (val), Player (val), t (val), Trove (val), Remotes (val)
        -- upvalues: Players (val), u40 (val)
        local Trails_2 = ReplicatedStorage.Assets.Trails
        local u3 = {}

        local function reconcileTrailVisual(a1) -- Line: 46
            -- upvalues: u3 (val), Trails (upval), Player (upval), Trails_2 (val)
            local u9 = assert(u3[a1], (("Missing trail renderer state for %*"):format(a1.Name)))
            u9.RenderRevision = u9.RenderRevision + 1
            local RenderRevision = u9.RenderRevision
            u9.CharacterTrove:Clean()
            local TrailId = u9.TrailId
            local Character = u9.Character
            if TrailId ~= nil and Character ~= nil then
                u9.CharacterTrove:Add((task.defer(function() -- Line: 58
                    -- upvalues: Trails (upval), TrailId (val), Player (upval), a1 (val), u3 (upval), u9 (val)
                    -- upvalues: RenderRevision (val), Character (val), Trails_2 (upval)
                    assert(Trails.TrailNameExists(TrailId), (("Invalid active trail \"%*\""):format(TrailId)))
                    local v1 = Player.WaitForRootPart(a1)
                    local v2 = u3[a1]
                    if v2 == u9
                        and u9.RenderRevision == RenderRevision
                        and u9.Character == Character
                        and u9.TrailId == TrailId
                        and v1.Parent == Character then
                        v2 = Trails_2[TrailId]
                        assert(v2:IsA("BasePart"), (("Trail asset \"%*\" must be a BasePart"):format(TrailId)))
                        local v3 = v2:Clone()
                        u9.CharacterTrove:Add(v3)
                        v3.Anchored = false
                        v3.CanCollide = false
                        v3.CanTouch = false
                        v3.CanQuery = false
                        v3.Massless = true
                        v3.Transparency = 1
                        v3.CFrame = v1.CFrame
                        v3.Parent = v1
                        local MainPartTrailWeldConstraint = v3.MainPartTrailWeldConstraint
                        assert(
                            MainPartTrailWeldConstraint:IsA("WeldConstraint"),
                            (("Trail asset \"%*\" has an invalid weld"):format(TrailId))
                        )
                        MainPartTrailWeldConstraint.Part1 = v1
                        return
                    end
                end)))
                return
            end
        end

        local function applyActiveTrail(a1, a2, a3) -- Line: 93
            -- upvalues: t (upval), u3 (val), reconcileTrailVisual (val)
            t.strict(t.instanceIsA("Player"))(a1)
            t.strict(t.optional(t.string))(a2)
            local v1 = assert(u3[a1], (("Missing trail renderer state for %*"):format(a1.Name)))
            v1.TrailId = a2
            v1.ReceivedLiveUpdate = v1.ReceivedLiveUpdate or a3
            reconcileTrailVisual(a1)
        end

        local function bindPlayer(a1) -- Line: 103
            -- upvalues: u3 (val), Trove (upval), Player (upval), reconcileTrailVisual (val)
            if u3[a1] ~= nil then
                return
            end
            local v1 = Trove.new()
            local v2 = v1:Extend()
            u3[a1] = {
                RenderRevision = 0,
                ReceivedLiveUpdate = false,
                Character = Player.FindCharacter(a1),
                PlayerTrove = v1,
                CharacterTrove = v2,
            }
            local u16 = u3[a1]
            v1:Connect(a1.CharacterAdded, function(a1_2) -- Line: 120 -- upvalues: u16 (val), reconcileTrailVisual (upval), a1 (val) -- types: a1_2: userdata
                u16.Character = a1_2
                reconcileTrailVisual(a1)
            end)
            v1:Connect(a1.CharacterRemoving, function(a1_2) -- Line: 124 -- upvalues: u16 (val), reconcileTrailVisual (upval), a1 (val) -- types: a1_2: userdata
                if u16.Character == a1_2 then
                    u16.Character = nil
                    reconcileTrailVisual(a1)
                end
            end)
            if u16.Character ~= nil then
                reconcileTrailVisual(a1)
            end
        end

        Players.PlayerAdded:Connect(bindPlayer)
        Players.PlayerRemoving:Connect(function(a1) -- Line: 141 -- upvalues: u3 (val) -- types: a1: userdata
            local v1 = assert(u3[a1], (("Missing trail renderer state for %*"):format(a1.Name)))
            u3[a1] = nil
            v1.PlayerTrove:Destroy()
        end)
        for i, v in ipairs(Players:GetPlayers()) do
            task.spawn(bindPlayer, v)
        end
        Remotes.Trailwear.WornTrailShifted.OnClientEvent:Connect(function(a1, a2) -- Line: 136 -- upvalues: bindPlayer (val), applyActiveTrail (val) -- types: a1: userdata, a2: string?
            bindPlayer(a1)
            applyActiveTrail(a1, a2, true)
        end)
        task.defer(function() -- Line: 147
            -- upvalues: Remotes (upval), Players (upval), bindPlayer (val), u3 (val), applyActiveTrail (val)
            -- upvalues: u40 (upval)
            local PlayerByUserId
            for k, v in pairs((Remotes.Trailwear.AskWornSnapshot:InvokeServer())) do
                PlayerByUserId = Players:GetPlayerByUserId(k)
                if PlayerByUserId == nil then
                    (u40:AtDebug()):Log((("Skipped trail snapshot for departed user %*"):format(k)))
                else
                    bindPlayer(PlayerByUserId)
                    if not assert(u3[PlayerByUserId], (("Missing trail renderer state for %*"):format(PlayerByUserId.Name))).ReceivedLiveUpdate then
                        applyActiveTrail(PlayerByUserId, v, false)
                    end
                end
            end
        end)
        return {}
    end,
}