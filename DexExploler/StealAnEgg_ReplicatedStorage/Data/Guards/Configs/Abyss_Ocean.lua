-- Script path: ReplicatedStorage.Data.Guards.Configs.Abyss Ocean
-- Decompile time: 0.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 17,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 5,
    HomeImpulseBoostDistanceXZ = 250,
    WalkSpeed = 130,
    _id = "Abyss Ocean",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://109513647043767",
            Volume = 5,
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://112789890097920",
            Volume = 5,
        },
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://138307614547337"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://100308696101952",
        Volume = 2,
    },
    FootstepSound = {
        Looped = false,
        MaxDistance = 74.38033294677734,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://89709728610870",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://102403705437382", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Cosmic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://79122874973512", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://128961185865478", v1),
})