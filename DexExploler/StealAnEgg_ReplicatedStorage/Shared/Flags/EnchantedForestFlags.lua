-- Script path: ReplicatedStorage.Shared.Flags.EnchantedForestFlags
-- Decompile time: 0.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local u15 = {}
u15.Open = require(ReplicatedStorage.Shared.Flags.LiveEventFlags).Directory.EnchantedForestOpen

function u15.ShouldReveal() -- Line: 10 -- upvalues: Environment (val), u15 (val)
    local v1
    local v2 = Environment.GetEnvironmentName()
    if v2 == "dev" or v2 == "test" then
        v1 = u15.Open:Get() == true
    else
        v1 = false
        if v2 == "prod" then
            v1 = u15.Open:Get() == true
        end
    end
    return v1
end

return table.freeze(u15)