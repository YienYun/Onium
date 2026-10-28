-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.CarryRunBackEffects
-- Decompile time: 10.57 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggState = require(ReplicatedStorage.Client.EggState)
local ScreenEffects = require(script.ScreenEffects)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local World = Workspace.World
assert(World:IsA("Folder"), "Workspace.World must be a Folder")
local Areas = World.Areas
assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
local GuardAreas = Areas.GuardAreas
assert(GuardAreas:IsA("Folder"), "Workspace.World.Areas.GuardAreas must be a Folder")
local u73 = nil
local v1 = {}

local function stopGuardedMusic(a1) -- Line: 55 -- upvalues: MusicDirector (val) -- types: a1: table
    if not a1.GuardedMusicActive then
        return
    end
    a1.GuardedMusicActive = false
    MusicDirector.SetGuardedGameplay(false)
end

local function releaseUiHide(a1) -- Line: 64 -- types: a1: table
    local ReleaseUiHide = a1.ReleaseUiHide
    if ReleaseUiHide == nil then
        return
    end
    a1.ReleaseUiHide = nil
    ReleaseUiHide()
end

local function cancelGuardStateWait(a1) -- Line: 74 -- types: a1: table
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection == nil then
        return
    end
    a1.GuardStateConnection = nil
    GuardStateConnection:Disconnect()
end

local function acquireUiHide() -- Line: 84 -- upvalues: HiddenUIHandler (val)
    return HiddenUIHandler.Acquire()
end

local function stopGuardedMusicForGeneration(a1, a2) -- Line: 86
    -- upvalues: MusicDirector (val)
    if a1.GuardedMusicGeneration ~= a2 or not a1.GuardedMusicActive then
        return
    end
    a1.GuardedMusicActive = false
    MusicDirector.SetGuardedGameplay(false)
end

local function stopRunBackState(a1) -- Line: 94 -- upvalues: MusicDirector (val) -- types: a1: table
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection ~= nil then
        a1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if not a1.Active then
        return
    end
    a1.Active = false
    a1.Effects:Stop()
    if a1.GuardedMusicActive then
        a1.GuardedMusicActive = false
        MusicDirector.SetGuardedGameplay(false)
    end
    MusicDirector.SetCarryingAreaEgg(false)
end

local function startCarryState(a1) -- Line: 106
    -- upvalues: Player (val), LocalPlayer (val), HiddenUIHandler (val)
    if a1.ReleaseUiHide ~= nil then
        return
    end
    local v1 = Player.FindHumanoid(LocalPlayer)
    if v1 ~= nil then
        v1:UnequipTools()
    end
    a1.ReleaseUiHide = HiddenUIHandler.Acquire()
end

local function stopCarryState(a1) -- Line: 119 -- upvalues: MusicDirector (val) -- types: a1: table
    a1.CarryGeneration = a1.CarryGeneration + 1
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection ~= nil then
        a1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if a1.Active then
        a1.Active = false
        a1.Effects:Stop()
        if a1.GuardedMusicActive then
            a1.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end
        MusicDirector.SetCarryingAreaEgg(false)
    end
    local ReleaseUiHide = a1.ReleaseUiHide
    if ReleaseUiHide == nil then
        return
    end
    a1.ReleaseUiHide = nil
    ReleaseUiHide()
end

local function startRunBackState(a1, a2) -- Line: 125
    -- upvalues: MusicDirector (val), Audio (val)
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection ~= nil then
        a1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if a1.Active then
        return
    end
    a1.Active = true
    a1.GuardedMusicGeneration = a1.GuardedMusicGeneration + 1
    local GuardedMusicGeneration = a1.GuardedMusicGeneration
    MusicDirector.SetCarryingAreaEgg(true)
    a1.GuardedMusicActive = true
    MusicDirector.SetGuardedGameplay(true)
    a1.Effects:Start(a2)
    local v1 = Audio.Play("rbxassetid://113113198465358", script, {PlaybackSpeed = 1.07, Volume = 2})
    if v1 ~= nil and v1.SoundId ~= "" then
        a1.Trove:Add((v1.Ended:Once(function() -- Line: 149 -- upvalues: a1 (val), GuardedMusicGeneration (val), MusicDirector (upval)
            local v1 = a1
            if v1.GuardedMusicGeneration ~= GuardedMusicGeneration or not v1.GuardedMusicActive then
                return
            end
            v1.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end)))
        a1.Trove:Add((v1.Stopped:Once(function() -- Line: 154 -- upvalues: a1 (val), GuardedMusicGeneration (val), MusicDirector (upval)
            local v1 = a1
            if v1.GuardedMusicGeneration ~= GuardedMusicGeneration or not v1.GuardedMusicActive then
                return
            end
            v1.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end)))
        return
    end
    if a1.GuardedMusicGeneration ~= GuardedMusicGeneration or not a1.GuardedMusicActive then
        return
    end
    a1.GuardedMusicActive = false
    MusicDirector.SetGuardedGameplay(false)
end

local function startWhenGuardWakeFinishes(a1, a2) -- Line: 159
    -- upvalues: startRunBackState (val), GuardAreas (val)
    a1.CarryGeneration = a1.CarryGeneration + 1
    local CarryGeneration = a1.CarryGeneration
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection ~= nil then
        a1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if a1.Active then
        return
    end
    local u15 = a2.GuardDisabled == true
    if a2.RunBackWakeDelayRequired ~= true then
        startRunBackState(a1, u15)
        return
    end
    local AreaId = a2.AreaId
    assert(AreaId ~= nil, "Carried area egg state must include AreaId")
    local v1 = GuardAreas[AreaId]
    local v2 = ("Workspace.World.Areas.GuardAreas.%* is required"):format(AreaId)
    assert(v1 ~= nil, v2)
    assert(v1:IsA("Model"), (("Workspace.World.Areas.GuardAreas.%* must be a Model"):format(AreaId)))
    local Guard = v1.Guard
    v2 = ("%*.Guard is required"):format((v1:GetFullName()))
    assert(Guard ~= nil, v2)
    assert(Guard:IsA("Model"), (("%*.Guard must be a Model"):format((v1:GetFullName()))))
    if Guard:GetAttribute("GuardState") == "Chasing" then
        startRunBackState(a1, u15)
        return
    end
    a1.GuardStateConnection = (Guard:GetAttributeChangedSignal("GuardState")):Connect(function() -- Line: 195 -- upvalues: a1 (val), CarryGeneration (val), Guard (val), startRunBackState (upval), u15 (val)
        if a1.CarryGeneration ~= CarryGeneration or Guard:GetAttribute("GuardState") ~= "Chasing" then
            return
        end
        startRunBackState(a1, u15)
    end)
end

local function applyCarryState(a1, a2) -- Line: 208
    -- upvalues: Player (val), LocalPlayer (val), HiddenUIHandler (val), startWhenGuardWakeFinishes (val)
    -- upvalues: MusicDirector (val)
    if a2.IsCarrying then
        if a1.ReleaseUiHide == nil then
            local v1 = Player.FindHumanoid(LocalPlayer)
            if v1 ~= nil then
                v1:UnequipTools()
            end
            a1.ReleaseUiHide = HiddenUIHandler.Acquire()
        end
        startWhenGuardWakeFinishes(a1, a2)
        return
    end
    a1.CarryGeneration = a1.CarryGeneration + 1
    local GuardStateConnection = a1.GuardStateConnection
    if GuardStateConnection ~= nil then
        a1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if a1.Active then
        a1.Active = false
        a1.Effects:Stop()
        if a1.GuardedMusicActive then
            a1.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end
        MusicDirector.SetCarryingAreaEgg(false)
    end
    local ReleaseUiHide = a1.ReleaseUiHide
    if ReleaseUiHide == nil then
        return
    end
    a1.ReleaseUiHide = nil
    ReleaseUiHide()
end

local function resolveRuntime() -- Line: 221 -- upvalues: u73 (ref), ScreenEffects (val), Trove (val)
    local v1 = u73
    if v1 ~= nil then
        return v1
    end
    v1 = {
        Active = false,
        CarryGeneration = 0,
        GuardedMusicActive = false,
        GuardedMusicGeneration = 0,
        Started = false,
        Effects = ScreenEffects.new(),
        Trove = Trove.new(),
    }
    u73 = v1
    return v1
end

function v1.Start() -- Line: 246
    -- upvalues: resolveRuntime (val), EggState (val), Player (val), LocalPlayer (val), HiddenUIHandler (val)
    -- upvalues: startWhenGuardWakeFinishes (val), MusicDirector (val)
    local u1 = resolveRuntime()
    if u1.Started then
        return
    end
    u1.Started = true
    u1.Trove:Add((EggState.CarryChanged:Connect(function(a1) -- Line: 255
        -- upvalues: u1 (val), Player (upval), LocalPlayer (upval), HiddenUIHandler (upval)
        -- upvalues: startWhenGuardWakeFinishes (upval), MusicDirector (upval)
        local v1 = u1
        if a1.IsCarrying then
            if v1.ReleaseUiHide == nil then
                local v2 = Player.FindHumanoid(LocalPlayer)
                if v2 ~= nil then
                    v2:UnequipTools()
                end
                v1.ReleaseUiHide = HiddenUIHandler.Acquire()
            end
            startWhenGuardWakeFinishes(v1, a1)
            return
        end
        v1.CarryGeneration = v1.CarryGeneration + 1
        local GuardStateConnection = v1.GuardStateConnection
        if GuardStateConnection ~= nil then
            v1.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v1.Active then
            v1.Active = false
            v1.Effects:Stop()
            if v1.GuardedMusicActive then
                v1.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v1.ReleaseUiHide
        if ReleaseUiHide == nil then
            return
        end
        v1.ReleaseUiHide = nil
        ReleaseUiHide()
    end)))
    u1.Trove:Connect(LocalPlayer.CharacterRemoving, function() -- Line: 262 -- upvalues: u1 (val), MusicDirector (upval)
        local v1 = u1
        v1.CarryGeneration = v1.CarryGeneration + 1
        local GuardStateConnection = v1.GuardStateConnection
        if GuardStateConnection ~= nil then
            v1.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v1.Active then
            v1.Active = false
            v1.Effects:Stop()
            if v1.GuardedMusicActive then
                v1.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v1.ReleaseUiHide
        if ReleaseUiHide == nil then
            return
        end
        v1.ReleaseUiHide = nil
        ReleaseUiHide()
    end)
    u1.Trove:Add(function() -- Line: 264 -- upvalues: u1 (val), MusicDirector (upval)
        local v1 = u1
        v1.CarryGeneration = v1.CarryGeneration + 1
        local GuardStateConnection = v1.GuardStateConnection
        if GuardStateConnection ~= nil then
            v1.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if v1.Active then
            v1.Active = false
            v1.Effects:Stop()
            if v1.GuardedMusicActive then
                v1.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = v1.ReleaseUiHide
        if ReleaseUiHide == nil then
            return
        end
        v1.ReleaseUiHide = nil
        ReleaseUiHide()
    end)
    local v1 = EggState.ReadCarryState()
    if v1.IsCarrying then
        if v1.IsCarrying then
            if u1.ReleaseUiHide == nil then
                local v2 = Player.FindHumanoid(LocalPlayer)
                if v2 ~= nil then
                    v2:UnequipTools()
                end
                u1.ReleaseUiHide = HiddenUIHandler.Acquire()
            end
            startWhenGuardWakeFinishes(u1, v1)
            return
        end
        u1.CarryGeneration = u1.CarryGeneration + 1
        local GuardStateConnection = u1.GuardStateConnection
        if GuardStateConnection ~= nil then
            u1.GuardStateConnection = nil
            GuardStateConnection:Disconnect()
        end
        if u1.Active then
            u1.Active = false
            u1.Effects:Stop()
            if u1.GuardedMusicActive then
                u1.GuardedMusicActive = false
                MusicDirector.SetGuardedGameplay(false)
            end
            MusicDirector.SetCarryingAreaEgg(false)
        end
        local ReleaseUiHide = u1.ReleaseUiHide
        if ReleaseUiHide == nil then
            return
        end
        u1.ReleaseUiHide = nil
        ReleaseUiHide()
    end
end

function v1.ForceStart(a1) -- Line: 273
    -- upvalues: resolveRuntime (val), Player (val), LocalPlayer (val), HiddenUIHandler (val), startRunBackState (val)
    local v1 = resolveRuntime()
    v1.CarryGeneration = v1.CarryGeneration + 1
    if v1.ReleaseUiHide == nil then
        local v2 = Player.FindHumanoid(LocalPlayer)
        if v2 ~= nil then
            v2:UnequipTools()
        end
        v1.ReleaseUiHide = HiddenUIHandler.Acquire()
    end
    startRunBackState(v1, a1 == true)
end

function v1.ForceStop() -- Line: 280 -- upvalues: resolveRuntime (val), MusicDirector (val)
    local v1 = resolveRuntime()
    v1.CarryGeneration = v1.CarryGeneration + 1
    local GuardStateConnection = v1.GuardStateConnection
    if GuardStateConnection ~= nil then
        v1.GuardStateConnection = nil
        GuardStateConnection:Disconnect()
    end
    if v1.Active then
        v1.Active = false
        v1.Effects:Stop()
        if v1.GuardedMusicActive then
            v1.GuardedMusicActive = false
            MusicDirector.SetGuardedGameplay(false)
        end
        MusicDirector.SetCarryingAreaEgg(false)
    end
    local ReleaseUiHide = v1.ReleaseUiHide
    if ReleaseUiHide == nil then
        return
    end
    v1.ReleaseUiHide = nil
    ReleaseUiHide()
end

return v1