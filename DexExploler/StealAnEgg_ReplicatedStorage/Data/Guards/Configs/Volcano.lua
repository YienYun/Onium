-- Script path: ReplicatedStorage.Data.Guards.Configs.Volcano
-- Decompile time: 0.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
return table.freeze({
    AnimationBaseWalkSpeed = 35,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 5,
    HomeImpulseBoostDistanceXZ = 220,
    WalkSpeed = 113,
    _id = "Volcano",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://76753017038067",
            Volume = 5,
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://122381958459272",
            Volume = 5,
        },
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://86276843966778"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://70850087419426",
        Volume = 2,
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://103736662890224",
        Volume = 1.5,
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://128670391346328", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Mythic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://106118773587652", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://102298982391360", v1),
})