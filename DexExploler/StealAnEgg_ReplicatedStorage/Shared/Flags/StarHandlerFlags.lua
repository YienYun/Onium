-- Script path: ReplicatedStorage.Shared.Flags.StarHandlerFlags
-- Decompile time: 0.73 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local u19 = {}
u19.Open = require(ReplicatedStorage.Shared.Flags.LiveEventFlags).Directory.StarHandlerOpen
u19.ForceRevealed = FastFlags.Replicated("Game.StarHandler.ForceRevealed", Asserts.Boolean, false)
u19.WeeklyLimit = FastFlags.Replicated("Game.StarHandler.WeeklyLimit", Asserts.IntegerRange(0, 100), 5)

function u19.ShouldReveal() -- Line: 19 -- upvalues: u19 (val)
    local v1 = true
    if u19.ForceRevealed:Get() ~= true then
        v1 = u19.Open:Get() == true
    end
    return v1
end

return table.freeze(u19)