-- Script path: ReplicatedStorage.Data.Guards.Configs.Light Dark Mixed
-- Decompile time: 0.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 28,
    FlatRadius = 20,
    HitDistance = 7,
    HomeImpulseBoostDistanceXZ = 300,
    WalkSpeed = 244.8,
    _id = "Light Dark Mixed",
    AfterWakeSound = {
        Looped = false,
        MaxDistance = 250,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://79235768556063",
        Volume = 5,
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://79728098291967"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://95162478809038",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://133144236442120",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://98979439516885", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.LightDark,
    SleepAnimation = AnimationAssets.Get("rbxassetid://107441624128628", v1),
    SleepSound = {
        Looped = false,
        MaxDistance = 40,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://129416806869914",
        Volume = 0.800000011920929,
    },
    WakeSound = {
        Looped = false,
        MaxDistance = 250,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://96595477884583",
        Volume = 0.30000001192092896,
    },
    WalkAnimation = AnimationAssets.Get("rbxassetid://126775867049371", v1),
})