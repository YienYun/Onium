-- Script path: ReplicatedStorage.UserGenerated.Roblox.LocalizationServiceHelper
-- Decompile time: 1.63 ms

local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Cache = require(ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local u35 = Cache.new({
    Callback = function(a1) -- Line: 29 -- upvalues: Players (val), LocalizationService (val)
        local PlayerByUserId = Players:GetPlayerByUserId(a1)
        assert(PlayerByUserId, "PlayerNotOnline")
        return LocalizationService:GetCountryRegionForPlayerAsync(PlayerByUserId)
    end,
    AssertKey = Asserts.Integer,
})
Players.PlayerRemoving:Connect(function(a1) -- Line: 36 -- upvalues: Players (val), u35 (val)
    local UserId = a1.UserId
    task.delay(60, function() -- Line: 39 -- upvalues: Players (upval), UserId (val), u35 (upval)
        if not Players:GetPlayerByUserId(UserId) then
            u35:Delete(UserId)
        end
    end)
end)
if not RunService:IsServer() then
    task.spawn(function() -- Line: 50 -- upvalues: u35 (val), Players (val)
        u35:GetAsync(Players.LocalPlayer.UserId)
    end)
else
    Players.PlayerAdded:Connect(function(a1) -- Line: 46 -- upvalues: u35 (val)
        u35:GetAsync(a1.UserId)
    end)
end
return table.freeze({
    GetCountryRegionForPlayerAsync = function(self, a2) -- Line: 57 -- upvalues: Asserts (val), u35 (val) -- types: self: userdata, a2: boolean?
        Asserts.Player(self)
        Asserts.Optional(Asserts.Boolean)(a2)
        if a2 then
            return u35:Get(self.UserId)
        end
        return u35:GetAsync(self.UserId)
    end,
})