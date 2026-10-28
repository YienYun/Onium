-- Script path: ReplicatedStorage.UserGenerated.Roblox.PolicyServiceHelper
-- Decompile time: 1.86 ms

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local u29 = {
    Discord = 0,
    Facebook = 1,
    Twitch = 2,
    YouTube = 3,
    X = 4,
    GitHub = 5,
    Guilded = 6,
}
table.freeze(u29)
local u44 = Cache.new({
    Callback = function(a1) -- Line: 50 -- upvalues: Players (val), PolicyService (val)
        local PlayerByUserId = Players:GetPlayerByUserId(a1)
        assert(PlayerByUserId, "PlayerNotOnline")
        return PolicyService:GetPolicyInfoForPlayerAsync(PlayerByUserId)
    end,
    AssertKey = Asserts.Integer,
})
Players.PlayerRemoving:Connect(function(a1) -- Line: 57 -- upvalues: Players (val), u44 (val)
    local UserId = a1.UserId
    task.delay(60, function() -- Line: 60 -- upvalues: Players (upval), UserId (val), u44 (upval)
        if not Players:GetPlayerByUserId(UserId) then
            u44:Delete(UserId)
        end
    end)
end)
if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(a1) -- Line: 67 -- upvalues: u44 (val)
        u44:GetAsync(a1.UserId)
    end)
end
return table.freeze({
    ExternalLinkReference = u29,
    ExternalLinkReferencesToInts = function(a1) -- Line: 76 -- upvalues: u29 (val) -- types: a1: table
        local v1
        local v2 = {}
        for i, v in ipairs(a1) do
            v1 = u29[v]
            if v1 then
                table.insert(v2, v1)
            end
        end
        return v2
    end,
    GetPolicyInfoForPlayerAsync = function(self, a2) -- Line: 87 -- upvalues: Asserts (val), u44 (val) -- types: self: userdata, a2: boolean?
        Asserts.Player(self)
        Asserts.Optional(Asserts.Boolean)(a2)
        if a2 then
            return u44:Get(self.UserId)
        end
        return u44:GetAsync(self.UserId)
    end,
})