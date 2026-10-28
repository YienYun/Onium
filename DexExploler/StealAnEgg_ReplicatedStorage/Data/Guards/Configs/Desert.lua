-- Script path: ReplicatedStorage.Data.Guards.Configs.Desert
-- Decompile time: 0.85 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    FlatRadius = 20,
    HitDistance = 4,
    HomeImpulseBoostDistanceXZ = 130,
    WalkSpeed = 62,
    _id = "Desert",
    AttackAnimation = AnimationAssets.Get("rbxassetid://132047161476745"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://76766635785020",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://137682861871003",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://85777917853482", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Rare,
    SleepAnimation = AnimationAssets.Get("rbxassetid://91477377508559", v1),
    SleepSound = {
        Looped = false,
        MaxDistance = 40,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://129416806869914",
        Volume = 0.800000011920929,
    },
    WakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://96595477884583",
        Volume = 0.30000001192092896,
    },
    WalkAnimation = AnimationAssets.Get("rbxassetid://73290619201848", v1),
})