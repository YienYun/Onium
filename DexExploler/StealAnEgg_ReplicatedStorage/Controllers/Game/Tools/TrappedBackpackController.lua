-- Script path: ReplicatedStorage.Controllers.Game.Tools.TrappedBackpackController
-- Decompile time: 3.51 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = require(ReplicatedStorage.Shared.Player)
local TrappedBackpackLock = require(script.Parent.Parent.Parent.GUI.TrappedBackpackLock)
local Trove_2 = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u29 = Trove_2.new()
local u30 = false
return {
    Start = function() -- Line: 22 -- upvalues: Player (val), LocalPlayer (val), u30 (ref), TrappedBackpackLock (val), u29 (val)
        local function unequipLocalTools() -- Line: 27 -- upvalues: Player (upval), LocalPlayer (upval)
            local v1 = Player.FindHumanoid(LocalPlayer)
            if v1 then
                v1:UnequipTools()
            end
        end

        local function setTrapBackpackLocked(a1) -- Line: 34
            -- upvalues: u30 (upval), Player (upval), LocalPlayer (upval), TrappedBackpackLock (upval)
            local v1
            if u30 == a1 then
                if a1 then
                    v1 = Player.FindHumanoid(LocalPlayer)
                    if v1 then
                        v1:UnequipTools()
                    end
                end
                return
            end
            u30 = a1
            if not a1 then
                TrappedBackpackLock.SetLocked(false)
                return
            end
            TrappedBackpackLock.SetLocked(true)
            v1 = Player.FindHumanoid(LocalPlayer)
            if v1 then
                v1:UnequipTools()
            end
        end

        local function refreshCharacterTrapState(a1) -- Line: 53
            -- upvalues: u30 (upval), Player (upval), LocalPlayer (upval), TrappedBackpackLock (upval)
            local v1
            local v2 = a1:GetAttribute("IsTrapped") == true
            if u30 == v2 then
                if v2 then
                    v1 = Player.FindHumanoid(LocalPlayer)
                    if v1 then
                        v1:UnequipTools()
                        return
                    end
                end
                return
            end
            u30 = v2
            if not v2 then
                TrappedBackpackLock.SetLocked(false)
                return
            end
            TrappedBackpackLock.SetLocked(true)
            v1 = Player.FindHumanoid(LocalPlayer)
            if not v1 then
                return
            end
            v1:UnequipTools()
        end

        local function bindCharacter(a1) -- Line: 57
            -- upvalues: u29 (upval), u30 (upval), TrappedBackpackLock (upval), Player (upval), LocalPlayer (upval)
            local v1
            u29:Clean()
            u29:Add(function() -- Line: 60 -- upvalues: u30 (upval), TrappedBackpackLock (upval)
                if u30 == false then
                    return
                end
                u30 = false
                TrappedBackpackLock.SetLocked(false)
            end)
            u29:Connect(a1:GetAttributeChangedSignal("IsTrapped"), function() -- Line: 64
                -- upvalues: a1 (val), u30 (upval), Player (upval), LocalPlayer (upval), TrappedBackpackLock (upval)
                local v1
                local v2 = a1:GetAttribute("IsTrapped") == true
                if u30 == v2 then
                    if v2 then
                        v1 = Player.FindHumanoid(LocalPlayer)
                        if v1 then
                            v1:UnequipTools()
                            return
                        end
                    end
                    return
                end
                u30 = v2
                if not v2 then
                    TrappedBackpackLock.SetLocked(false)
                    return
                end
                TrappedBackpackLock.SetLocked(true)
                v1 = Player.FindHumanoid(LocalPlayer)
                if not v1 then
                    return
                end
                v1:UnequipTools()
            end)
            u29:Connect(a1.ChildAdded, function(a1) -- Line: 67 -- upvalues: u30 (upval), Player (upval), LocalPlayer (upval) -- types: a1: userdata
                if u30 and a1:IsA("Tool") then
                    local v1 = Player.FindHumanoid(LocalPlayer)
                    if v1 then
                        v1:UnequipTools()
                    end
                end
            end)
            local v2 = a1:GetAttribute("IsTrapped") == true
            if u30 == v2 then
                if v2 then
                    v1 = Player.FindHumanoid(LocalPlayer)
                    if v1 then
                        v1:UnequipTools()
                        return
                    end
                end
                return
            end
            u30 = v2
            if not v2 then
                TrappedBackpackLock.SetLocked(false)
                return
            end
            TrappedBackpackLock.SetLocked(true)
            v1 = Player.FindHumanoid(LocalPlayer)
            if not v1 then
                return
            end
            v1:UnequipTools()
        end

        LocalPlayer.CharacterAdded:Connect(bindCharacter)
        local v1 = Player.FindCharacter(LocalPlayer)
        if v1 then
            bindCharacter(v1)
        end
    end,
}