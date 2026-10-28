-- Script path: ReplicatedStorage.Data.Guards.Configs.Jungle
-- Decompile time: 0.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 14,
    FlatRadius = 20,
    HitDistance = 3,
    HomeImpulseBoostDistanceXZ = 160,
    WalkSpeed = 82,
    _id = "Jungle",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://110971572672011",
            Volume = 5,
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://71105135143267",
            Volume = 5,
        },
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://137152617410120"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://127853591688222",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://95492669493151",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://129822945034773", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Epic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://80254440617270", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://102697421744284", v1),
})