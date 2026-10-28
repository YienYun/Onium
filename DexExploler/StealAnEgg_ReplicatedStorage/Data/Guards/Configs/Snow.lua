-- Script path: ReplicatedStorage.Data.Guards.Configs.Snow
-- Decompile time: 1.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 30,
    FlatRadius = 20,
    HitDistance = 3,
    HomeImpulseBoostDistanceXZ = 190,
    WalkSpeed = 98,
    _id = "Snow",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://93143455867850",
            Volume = 5,
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://84067036540604",
            Volume = 5,
        },
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://75143394559594"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://101185499321117",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://86923272173832",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://82636665685816", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Legendary,
    SleepAnimation = AnimationAssets.Get("rbxassetid://122748978345484", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://121460485550564", v1),
})