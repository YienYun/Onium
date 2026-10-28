-- Script path: ReplicatedStorage.UserGenerated.Roblox.GroupServiceHelper
-- Decompile time: 1.48 ms

local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local u33 = Cache.new({
    MaxAge = (1 / 0),
    Callback = function(a1) -- Line: 38 -- upvalues: GroupService (val)
        return GroupService:GetGroupsAsync(a1)
    end,
    AssertKey = Asserts.Integer,
})
Players.PlayerRemoving:Connect(function(a1) -- Line: 44 -- upvalues: Players (val), u33 (val)
    local UserId = a1.UserId
    task.delay(60, function() -- Line: 47 -- upvalues: Players (upval), UserId (val), u33 (upval)
        if not Players:GetPlayerByUserId(UserId) then
            u33:Delete(UserId)
        end
    end)
end)
if not RunService:IsServer() then
    task.spawn(function() -- Line: 58 -- upvalues: u33 (val), Players (val)
        u33:GetAsync(Players.LocalPlayer.UserId)
    end)
else
    Players.PlayerAdded:Connect(function(a1) -- Line: 54 -- upvalues: u33 (val)
        u33:GetAsync(a1.UserId)
    end)
end
return table.freeze({
    Cache = u33,
    GetGroupsAsync = function(a1, a2) -- Line: 67 -- upvalues: Asserts (val), u33 (val) -- types: a1: number, a2: boolean?
        Asserts.Integer(a1)
        Asserts.Optional(Asserts.Boolean)(a2)
        if a2 then
            return u33:Get(a1)
        end
        return u33:GetAsync(a1)
    end,
})