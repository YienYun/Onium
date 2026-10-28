-- Script path: ReplicatedStorage.Data.HalloweenBossMastery
-- Decompile time: 6.52 ms

local Category, GearId, Reward, v1, v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local Gears = require(ReplicatedStorage.Data.Gears)
local HalloweenTokens = require(ReplicatedStorage.Data.Currency.Configs.HalloweenTokens)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v3 = table.freeze({Kind = "Tokens", Amount = 2250})
local v4 = table.freeze({Kind = "Tokens", Amount = 3000})
local v5 = table.freeze({Kind = "Tokens", Amount = 3500})
local v6 = table.freeze({Kind = "Tokens", Amount = 5000})
local v7 = table.freeze({Kind = "Tokens", Amount = 6500})
local v8 = table.freeze({Kind = "SpeedBoost", Seconds = 600})
local v9 = table.freeze({Kind = "Pet", Category = "Cauldron"})
local v10 = table.freeze({Kind = "Pet", Category = "Coffin Skeleton"})
local v11 = table.freeze({Kind = "Pet", Category = "Bell Ghost"})
local v12 = table.freeze({Kind = "Pet", Category = "Ghost Bird"})
local v13 = table.freeze({Kind = "Pet", Category = "Big Moth"})
local v14 = table.freeze({Kind = "Pet", Category = "Pumpkin Brute"})
local v15 = table.freeze({Kind = "Gear", GearId = "Pumpkin Scythe"})
local u139 = {}
for i, j in {
    v3,
    v3,
    v9,
    v3,
    v6,
    v8,
    v3,
    v3,
    v8,
    v10,
    v3,
    v8,
    v3,
    v3,
    v6,
    v3,
    v11,
    v8,
    v3,
    v6,
    v8,
    v3,
    v3,
    v8,
    v6,
    v3,
    v8,
    v3,
    v3,
    v12,
    v3,
    v3,
    v8,
    v3,
    v6,
    v8,
    v4,
    v4,
    v8,
    v6,
    v4,
    v8,
    v4,
    v4,
    v13,
    v4,
    v4,
    v8,
    v4,
    v7,
    v8,
    v15,
    v5,
    v8,
    v7,
    v5,
    v8,
    v5,
    v5,
    v7,
    v5,
    v5,
    v8,
    v5,
    v14,
} do
    table.insert(u139, (table.freeze({Id = ("PumpkinBoss%*"):format(i), Kills = i, Reward = j})))
end
table.freeze(u139)

local function petConfig(a1) -- Line: 80 -- upvalues: Assets (val) -- types: a1: string
    local v1 = assert(Assets.Directory[a1], (("Unknown Halloween mastery pet %*"):format(a1)))
    local v2 = ("%* has no egg icon"):format(a1)
    assert(type(v1.Egg.Icon) == "string", v2)
    return v1
end

local function gearConfig(a1) -- Line: 86 -- upvalues: Gears (val) -- types: a1: string
    assert((Gears.GearNameExists(a1)))
    return Gears.Directory[a1]
end

v13 = {
    Milestones = u139,
    Presentation = function(a1) -- Line: 97
        -- upvalues: HalloweenTokens (val), Numbers (val), Assets (val), BossMasteryFlags (val), Gears (val)
        -- upvalues: Rarity (val)
        local v1
        if a1.Kind == "Tokens" then
            return {
                Title = HalloweenTokens.DisplayName,
                Icon = HalloweenTokens.Icon,
                Amount = ("x%*"):format((Numbers.AddCommas(a1.Amount))),
            }
        end
        if a1.Kind == "Pet" then
            local Category = a1.Category
            v1 = assert(Assets.Directory[Category], (("Unknown Halloween mastery pet %*"):format(Category)))
            local v2 = ("%* has no egg icon"):format(Category)
            assert(type(v1.Egg.Icon) == "string", v2)
            return {
                Amount = "x1",
                Title = v1.DisplayName,
                Rarity = v1.Rarity.DisplayName,
                Icon = v1.Icon,
            }
        end
        if a1.Kind == "SpeedBoost" then
            v1 = math.max(math.floor(a1.Seconds / 60), 1)
            local v3 = ("%*x Speed"):format((BossMasteryFlags.SpeedBoostMultiplier:Get()))
            return {
                Icon = "rbxassetid://78137530993637",
                Title = v3,
                Amount = ("%*m"):format(v1),
                HoverTitle = string.upper(v3),
                HoverDescription = ("Run faster for %* minutes"):format(v1),
            }
        end
        if a1.Kind ~= "Gear" then
            error((("Unknown Halloween mastery reward %*"):format(a1.Kind)))
            return
        end
        local GearId = a1.GearId
        assert((Gears.GearNameExists(GearId)))
        v1 = Gears.Directory[GearId]
        return {
            Label = "Weapon",
            Amount = "x1",
            HoverDescription = "A permanent Halloween bat",
            Title = v1.DisplayName,
            Rarity = Rarity.Get(v1.Rarity).DisplayName,
            Icon = v1.Icon,
            HoverTitle = string.upper(v1.DisplayName),
        }
    end,
    GetMilestone = function(a1) -- Line: 132 -- upvalues: u139 (val) -- types: a1: string
        for i, j in u139 do
            if j.Id == a1 then
                return j
            end
        end
        return nil
    end,
}
local v16 = nil
local v17 = nil
for k, n in u139, v16, v17 do
    Reward = n.Reward
    if Reward.Kind == "Pet" then
        Category = Reward.Category
        v2 = ("%* has no egg icon"):format(Category)
        assert(type((assert(Assets.Directory[Category], (("Unknown Halloween mastery pet %*"):format(Category)))).Egg.Icon) == "string", v2)
    elseif Reward.Kind == "Gear" then
        GearId = Reward.GearId
        assert((Gears.GearNameExists(GearId)))
        v1 = Gears.Directory[GearId]
    end
end
return table.freeze(v13)