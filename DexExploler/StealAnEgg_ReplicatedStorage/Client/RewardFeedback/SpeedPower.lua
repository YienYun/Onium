-- Script path: ReplicatedStorage.Client.RewardFeedback.SpeedPower
-- Decompile time: 0.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Reward = require(ReplicatedStorage.Client.Notifications.Reward)
local Rain = require(ReplicatedStorage.Client.UI.VFX.Rain)
local u16 = {0.9, 1.1}
local u23 = table.freeze(((function() -- Line: 15 -- upvalues: u16 (val)
    return {
        Seconds = 1,
        Ambience = {Volume = 1.3, PlaybackSpeed = u16, Sounds = {"rbxassetid://78590382571227"}},
        Sheets = {{SizeMultiplier = 3, Texture = "rbxassetid://78137530993637"}},
    }
end)()))
return {
    Announce = function(a1) -- Line: 36 -- upvalues: Rain (val), u23 (val), Reward (val) -- types: a1: number
        local v1 = false
        if type(a1) == "number" then
            v1 = a1 > 0
        end
        assert(v1, "a speed power announcement needs a positive amount")
        Rain.Fall(u23)
        Reward.Show({Item = {Kind = "SpeedPower", Amount = math.round(a1)}})
    end,
}