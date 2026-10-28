-- Script path: ReplicatedStorage.Client.Notifications.GoldenButterfly
-- Decompile time: 0.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local Lanes = require(script.Parent.Lanes)
local GoldenNotif = ReplicatedStorage.Assets.UI.Notifs.GoldenNotif
return table.freeze({
    Show = function() -- Line: 17 -- upvalues: Lanes (val), GoldenNotif (val), Audio (val), ButterflyCatalog (val)
        Lanes.Schedule({
            Lane = "Banner",
            Seconds = 5,
            UniqueKey = "GoldenButterfly",
            Frame = GoldenNotif:Clone(),
            OnShown = function() -- Line: 23 -- upvalues: Audio (upval), ButterflyCatalog (upval)
                Audio.Play(ButterflyCatalog.Sounds.GoldenAnnounce, script, {Volume = 0.85})
            end,
        })
    end,
})