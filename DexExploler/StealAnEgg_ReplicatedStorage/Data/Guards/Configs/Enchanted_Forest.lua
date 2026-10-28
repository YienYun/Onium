-- Script path: ReplicatedStorage.Data.Guards.Configs.Enchanted Forest
-- Decompile time: 0.73 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({DropWeight = 1, Looped = true, Play = {0.15}, Stop = {0.5}})
local v2 = table.clone(require(script.Parent["Light Dark Light"]))
v2._id = "Enchanted Forest"
v2.Rarity = require(ReplicatedStorage.Data.Rarity).Rarities.Secret
v2.WalkSpeed = 251.075
v2.AnimationBaseWalkSpeed = 28
v2.IdleAnimation = AnimationAssets.Get("rbxassetid://72895195339070", v1)
v2.SleepAnimation = AnimationAssets.Get("rbxassetid://119496152038377", v1)
v2.WalkAnimation = AnimationAssets.Get("rbxassetid://91808380158987", v1)
v2.AttackAnimation = nil
return table.freeze(v2)