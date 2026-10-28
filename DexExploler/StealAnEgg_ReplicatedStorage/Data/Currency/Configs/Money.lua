-- Script path: ReplicatedStorage.Data.Currency.Configs.Money
-- Decompile time: 1.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local InstanceCache = require(ReplicatedStorage.Packages.InstanceCache)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Money = ReplicatedStorage.Assets.Models.Orbs.Money

local function orbSource() -- Line: 11 -- upvalues: Constants (val), Money (val), InstanceCache (val)
    if Constants.IS_SERVER then
        return Money
    end
    return (InstanceCache.new(Money, 1)):SetExpandAmount(1)
end

local freeze = table.freeze
local v1 = {
    DisplayName = "Money",
    Desc = "",
    Icon = "rbxassetid://119640363267627",
    _id = "Money",
    Rarity = Rarity.Rarities.Uncommon,
    Sounds = {Single = {Data = {Volume = 0.5, Speed = {0.95, 1.05}}, Ids = {"rbxassetid://122083641072193"}}},
}
local v2 = if not Constants.IS_SERVER then (InstanceCache.new(Money, 1)):SetExpandAmount(1) else Money
v1.Instance = v2
return freeze(v1)