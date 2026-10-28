-- Script path: ReplicatedStorage.Data.Guards.Configs.Cosmic
-- Decompile time: 1.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 28,
    FlatRadius = 20,
    HitDistance = 4,
    HomeImpulseBoostDistanceXZ = 300,
    WalkSpeed = 200,
    _id = "Cosmic",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://135419634519147",
            Volume = 5,
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://136805444765117",
            Volume = 5,
        },
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://136277931348535"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://103435959847699",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://85892053481113",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://117753870137871", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Eternal,
    SleepAnimation = AnimationAssets.Get("rbxassetid://90923212952863", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://126661107235272", v1),
})