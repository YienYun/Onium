-- Script path: ReplicatedStorage.Data.Guards.Configs.Lake
-- Decompile time: 0.95 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    FlatRadius = 20,
    HitDistance = 3,
    HomeImpulseBoostDistanceXZ = 100,
    WalkSpeed = 35,
    _id = "Lake",
    AttackAnimation = AnimationAssets.Get("rbxassetid://106848729969940"),
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
        SoundId = "rbxassetid://84639143672331",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://113947385873952", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Uncommon,
    SleepAnimation = AnimationAssets.Get("rbxassetid://119006758941979", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://136832792656489", v1),
})