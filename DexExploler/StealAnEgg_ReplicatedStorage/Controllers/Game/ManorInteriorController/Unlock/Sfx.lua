-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Sfx
-- Decompile time: 2.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
local u22 = table.freeze({
    KeyTurn = "rbxassetid://116122774582166",
    Ratchet = "rbxassetid://79199310694455",
    KeyThunk = "rbxassetid://93471936378241",
    ChainSnap = "rbxassetid://94606155495585",
    LinkClink = "rbxassetid://89384724133841",
    DoorSlam = "rbxassetid://107387051232862",
    Draft = "rbxassetid://99449925503203",
    ChainRattle = "rbxassetid://96614250520996",
    PadlockClunk = "rbxassetid://116406137162867",
    Creak = "rbxassetid://120769059226866",
    Shimmer = "rbxassetid://124699703411879",
    Boom = "rbxassetid://119977062667102",
})
local v1 = {Ids = u22}

local function group() -- Line: 37 -- upvalues: SoundService (val)
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    if Gameplay ~= nil and Gameplay:IsA("SoundGroup") then
        return Gameplay
    end
    return nil
end

function v1.Warm() -- Line: 46 -- upvalues: u22 (val), Preload (val)
    local v1 = {}
    for i, j in u22 do
        table.insert(v1, j)
    end
    task.spawn(Preload.WarmSounds, v1)
end

function v1.Play(a1, a2, a3, a4) -- Line: 54
    -- upvalues: u22 (val), Audio (val), SoundService (val)
    local v1 = u22[a1]
    if v1 == nil then
        return nil
    end
    local Play = Audio.Play
    local v2 = script
    local v3 = {}
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    v3.SoundGroup = if Gameplay == nil then nil else if not Gameplay:IsA("SoundGroup") then nil else Gameplay
    v3.Volume = a2
    v3.PlaybackSpeed = a3 or 1
    v3.TimePosition = a4
    return Play(v1, v2, v3)
end

function v1.At(a1, a2, a3, a4) -- Line: 67
    -- upvalues: u22 (val), Audio (val), SoundService (val)
    local v1 = u22[a1]
    if v1 == nil then
        return nil
    end
    local Play = Audio.Play
    local v2 = {MaxDistance = 260}
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    v2.SoundGroup = if Gameplay == nil then nil else if not Gameplay:IsA("SoundGroup") then nil else Gameplay
    v2.Volume = a3
    v2.PlaybackSpeed = a4 or 1
    return Play(v1, a2, v2)
end

return table.freeze(v1)