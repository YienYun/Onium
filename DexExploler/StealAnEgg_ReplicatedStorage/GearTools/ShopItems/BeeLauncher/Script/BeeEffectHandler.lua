-- Script path: ReplicatedStorage.GearTools.ShopItems.BeeLauncher.Script.BeeEffectHandler
-- Decompile time: 0.78 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Parent = script.Parent
if not Parent:IsA("Model") then
    return
end
local BeeLauncher = (require(ReplicatedStorage.Shared.Flags.GameplayBalance)).BeeLauncher
require(ReplicatedStorage.Controllers.Game.BeeEffectController).Apply(Parent, BeeLauncher.EFFECT_DURATION_SECONDS)