-- Script path: ReplicatedStorage.Client.Util.ToolSetup
-- Decompile time: 1.51 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolSession = require(ReplicatedStorage.Client.Util.ToolSession)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u33 = t.strict(t.array(t.string))
local v1 = {}
local LocalPlayer = Players.LocalPlayer

function v1.Attach(a1, a2) -- Line: 24 -- upvalues: u33 (val), Trove (val), LocalPlayer (val), ToolSession (val)
    local v1 = if type(a1) ~= "string" then a1 else {a1}
    u33(v1)
    local u12 = {accepts = v1}
    u12.hooks = a2 or {}
    u12.spawns = Trove.new()
    local Character = LocalPlayer.Character
    if Character then
        ToolSession.Follow(u12, Character)
    end
    u12.spawns:Add((LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 37 -- upvalues: ToolSession (upval), u12 (val)
        ToolSession.Follow(u12, a1)
    end)))
    return {
        GetCurrentTool = function() -- Line: 41 -- upvalues: u12 (val)
            return u12.held
        end,
        GetCurrentToolGearName = function() -- Line: 42 -- upvalues: ToolSession (upval), u12 (val)
            return ToolSession.GearNameOf(u12.held)
        end,
        IsActive = function() -- Line: 43 -- upvalues: u12 (val)
            return u12.held ~= nil
        end,
        Cleanup = function() -- Line: 44 -- upvalues: ToolSession (upval), u12 (val)
            ToolSession.Shut(u12)
        end,
    }
end

function v1.ApplyCooldown(a1, a2) -- Line: 48 -- upvalues: ToolCooldown (val) -- types: a1: table, a2: number
    local CurrentTool = a1:GetCurrentTool()
    if CurrentTool and CurrentTool.Parent then
        ToolCooldown.Begin(CurrentTool, a2)
    end
end

return v1