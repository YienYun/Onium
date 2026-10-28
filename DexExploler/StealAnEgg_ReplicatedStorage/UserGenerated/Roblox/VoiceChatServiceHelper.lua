-- Script path: ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper
-- Decompile time: 1.84 ms

local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local u28 = Cache.new({
    MaxAge = (1 / 0),
    Callback = function(a1) -- Line: 27 -- upvalues: VoiceChatService (val)
        return VoiceChatService:IsVoiceEnabledForUserIdAsync(a1)
    end,
    AssertKey = Asserts.Integer,
})
Players.PlayerRemoving:Connect(function(a1) -- Line: 34 -- upvalues: Players (val), u28 (val)
    local UserId = a1.UserId
    task.delay(60, function() -- Line: 37 -- upvalues: Players (upval), UserId (val), u28 (upval)
        if not Players:GetPlayerByUserId(UserId) then
            u28:Delete(UserId)
        end
    end)
end)
task.spawn(function() -- Line: 43 -- upvalues: u28 (val), Players (val)
    u28:GetAsync(Players.LocalPlayer.UserId)
end)
return table.freeze({
    IsVoiceEnabledForUserIdAsync = function(a1, a2) -- Line: 49 -- upvalues: Asserts (val), u28 (val) -- types: a1: number, a2: boolean?
        Asserts.Integer(a1)
        Asserts.Optional(Asserts.Boolean)(a2)
        if a2 then
            return u28:Get(a1)
        end
        return u28:GetAsync(a1)
    end,
})