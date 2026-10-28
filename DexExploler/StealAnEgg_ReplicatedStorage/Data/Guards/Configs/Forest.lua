-- Script path: ReplicatedStorage.Data.Guards.Configs.Forest
-- Decompile time: 0.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 4,
    FlatRadius = 20,
    HitDistance = 2.5,
    HomeImpulseBoostDistanceXZ = 70,
    WalkSpeed = 16,
    _id = "Forest",
    AfterWakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://129675339394681",
        Volume = 5,
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://108528350206370"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://119910675891317",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://77569052979374",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://139122582247217", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Common,
    SleepAnimation = AnimationAssets.Get("rbxassetid://130139384582356", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://139560613766322", v1),
})