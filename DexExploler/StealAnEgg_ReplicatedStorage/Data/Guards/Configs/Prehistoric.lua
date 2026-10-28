-- Script path: ReplicatedStorage.Data.Guards.Configs.Prehistoric
-- Decompile time: 1.21 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 30,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 7,
    HomeImpulseBoostDistanceXZ = 275,
    WalkSpeed = 152,
    _id = "Prehistoric",
    AfterWakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://75664314250862",
        Volume = 5,
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://72819921043071"),
    AttackSound = {
        Looped = false,
        MaxDistance = 300,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://95116072506206",
        Volume = 4,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://86392397661742",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://85804925095766", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Secret,
    SleepAnimation = AnimationAssets.Get("rbxassetid://133422374459463", v1),
    SleepSound = {
        Looped = false,
        MaxDistance = 107.4382553100586,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://129416806869914",
        Volume = 0,
    },
    WakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://96595477884583",
        Volume = 0.30000001192092896,
    },
    WalkAnimation = AnimationAssets.Get("rbxassetid://117274313338090", v1),
})