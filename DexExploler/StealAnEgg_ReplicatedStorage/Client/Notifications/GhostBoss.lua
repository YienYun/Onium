-- Script path: ReplicatedStorage.Client.Notifications.GhostBoss
-- Decompile time: 1.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Lanes = require(script.Parent.Lanes)
local GhostBossNotif = ReplicatedStorage.Assets.UI.Notifs.GhostBossNotif
local v1 = {}

local function announceSound() -- Line: 16 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Sounds = Assets and Assets:FindFirstChild("Sounds")
    local v1 = Sounds and Sounds:FindFirstChild("BossEventSounds")
    local v2 = v1 and v1:FindFirstChild("Blackhole Spawn")
    if v2 and v2:IsA("Sound") then
        return v2
    end
    return nil
end

function v1.Show() -- Line: 24 -- upvalues: Lanes (val), GhostBossNotif (val), announceSound (val), Audio (val)
    Lanes.Schedule({
        Lane = "Banner",
        Seconds = 5,
        UniqueKey = "GhostBoss",
        Frame = GhostBossNotif:Clone(),
        OnShown = function() -- Line: 30 -- upvalues: announceSound (upval), Audio (upval)
            local v1 = announceSound()
            if v1 then
                Audio.Play(v1, script, {Volume = 0.7, PlaybackSpeed = 1.15})
            end
        end,
    })
end

return table.freeze(v1)