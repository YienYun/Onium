-- Script path: ReplicatedStorage.Data.ScrambleMastery
-- Decompile time: 12.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local ScrambleTradeIn = require(ReplicatedStorage.Data.ScrambleTradeIn)
local v1 = table.freeze({Category = "Mecha Scrambler", Scale = 1})
local v2 = table.freeze({Kind = "Banner", BannerId = "Biohazard", Mutated = false})
local v3 = table.freeze({Kind = "Banner", BannerId = "Biohazard", Mutated = true})
local v4 = table.freeze({Kind = "Banner", BannerId = "Experimental", Mutated = false})
local v5 = table.freeze({Kind = "Banner", BannerId = "Experimental", Mutated = true})
local v6 = table.freeze({Kind = "Banner", BannerId = "UnstableDNA", Mutated = false})
local v7 = table.freeze({Kind = "Banner", BannerId = "UnstableDNA", Mutated = true})
local v8 = table.freeze({Kind = "RandomBanner", Mutated = true})
local v9 = table.freeze({Kind = "Pet", Category = "Eye Bat", Scale = 1})
local v10 = table.freeze({Kind = "Pet", Category = "Citadel Snail", Scale = 1})
local v11 = table.freeze({Kind = "Pet", Category = "Uncoiled Armadillo", Scale = 1})
local v12 = table.freeze({Kind = "Pet", Category = "Mecha Chompa", Scale = 1})
local v13 = table.freeze({Kind = "Pet", Category = "Pink Dragon Experiment", Scale = 1})
local u125 = table.freeze({
    table.freeze({Id = "Scramble1", Kills = 1, Reward = v2}),
    table.freeze({Id = "Scramble3", Kills = 3, Reward = v4}),
    table.freeze({Id = "Scramble5", Kills = 5, Reward = v3}),
    table.freeze({Id = "Scramble7", Kills = 7, Reward = v6}),
    table.freeze({Id = "Scramble10", Kills = 10, Reward = v9}),
    table.freeze({Id = "Scramble13", Kills = 13, Reward = v2}),
    table.freeze({Id = "Scramble15", Kills = 15, Reward = v3}),
    table.freeze({Id = "Scramble18", Kills = 18, Reward = v5}),
    table.freeze({Id = "Scramble21", Kills = 21, Reward = v6}),
    table.freeze({Id = "Scramble25", Kills = 25, Reward = v10}),
    table.freeze({Id = "Scramble30", Kills = 30, Reward = v2}),
    table.freeze({Id = "Scramble35", Kills = 35, Reward = v3}),
    table.freeze({Id = "Scramble40", Kills = 40, Reward = v7}),
    table.freeze({Id = "Scramble45", Kills = 45, Reward = v3}),
    table.freeze({Id = "Scramble50", Kills = 50, Reward = v11}),
    table.freeze({Id = "Scramble57", Kills = 57, Reward = v5}),
    table.freeze({Id = "Scramble64", Kills = 64, Reward = v5}),
    table.freeze({Id = "Scramble70", Kills = 70, Reward = v6}),
    table.freeze({Id = "Scramble75", Kills = 75, Reward = v12}),
    table.freeze({Id = "Scramble82", Kills = 82, Reward = v3}),
    table.freeze({Id = "Scramble90", Kills = 90, Reward = v7}),
    (table.freeze({Id = "Scramble100", Kills = 100, Reward = v13})),
})

local function petConfig(a1) -- Line: 85 -- upvalues: Assets (val) -- types: a1: string
    local v1 = assert(Assets.Directory[a1], (("Unknown Scramble mastery egg %*"):format(a1)))
    local v2 = ("%* has no egg icon"):format(a1)
    assert(type(v1.Egg.Icon) == "string", v2)
    v2 = ("%* has no egg name"):format(a1)
    assert(type(v1.Egg.DisplayName) == "string", v2)
    return v1
end

local function bannerSkin(a1) -- Line: 92 -- upvalues: ScrambleTradeIn (val), EggSkins (val) -- types: a1: string
    return assert(
        EggSkins.Get((assert(ScrambleTradeIn.GetBannerEggSkin(a1), (("Unknown Scramble banner %*"):format(a1))))),
        (("Scramble banner %* has no egg skin"):format(a1))
    )
end

local function validate(a1) -- Line: 97
    -- upvalues: Assets (val), ScrambleTradeIn (val), EggSkins (val)
    if a1.Kind == "Pet" then
        local Category = a1.Category
        local v1 = assert(Assets.Directory[Category], (("Unknown Scramble mastery egg %*"):format(Category)))
        local v2 = ("%* has no egg icon"):format(Category)
        assert(type(v1.Egg.Icon) == "string", v2)
        v2 = ("%* has no egg name"):format(Category)
        assert(type(v1.Egg.DisplayName) == "string", v2)
        return
    end
    if a1.Kind == "Banner" then
        local BannerId = a1.BannerId
        assert(
            EggSkins.Get((assert(ScrambleTradeIn.GetBannerEggSkin(BannerId), (("Unknown Scramble banner %*"):format(BannerId))))),
            (("Scramble banner %* has no egg skin"):format(BannerId))
        )
        return
    end
    for i, j in ScrambleTradeIn.BannerIds() do
        assert(
            EggSkins.Get((assert(ScrambleTradeIn.GetBannerEggSkin(j), (("Unknown Scramble banner %*"):format(j))))),
            (("Scramble banner %* has no egg skin"):format(j))
        )
    end
end

local function rollBannerId(a1) -- Line: 110 -- upvalues: ScrambleTradeIn (val) -- types: a1: userdata
    local v1
    local v2 = 0
    for i, j in ScrambleTradeIn.BannerIds() do
        v2 = v2 + math.max(ScrambleTradeIn.GetBannerWeight(j), 0)
    end
    assert(v2 > 0, "Scramble banners have no weight")
    local v3 = a1:NextNumber() * v2
    v2 = ""
    for k, n in ScrambleTradeIn.BannerIds() do
        v1 = ScrambleTradeIn.GetBannerWeight(n)
        if v1 > 0 then
            v3 = v3 - v1
            v2 = n
            if v3 <= 0 then
                return n
            end
        end
    end
    return v2
end

local u130 = {
    Milestones = u125,
    InfiniteMilestoneId = "ScrambleInfinite",
    InfiniteEveryKills = 10,
    InfiniteReward = v8,
    BossDropEgg = v1,
}

function u130.Roll(a1, a2) -- Line: 143
    -- upvalues: rollBannerId (val), ScrambleTradeIn (val)
    local BannerId
    if a1.Kind == "Pet" then
        return {Category = a1.Category, Scale = a1.Scale}
    end
    return {
        Category = assert(
            ScrambleTradeIn.RollPet(if a1.Kind ~= "Banner" then rollBannerId(a2) else a1.BannerId, a2),
            (("Scramble banner %* has no pets"):format(BannerId))
        ),
        Mutation = if not a1.Mutated then nil else "Scrambled",
        EggSkin = ScrambleTradeIn.GetBannerEggSkin(BannerId),
    }
end

function u130.GetMilestone(a1) -- Line: 156 -- upvalues: u125 (val) -- types: a1: string
    for i, j in u125 do
        if j.Id == a1 then
            return j
        end
    end
    return nil
end

function u130.FinalMilestone() -- Line: 165 -- upvalues: u125 (val)
    return u125[#u125]
end

function u130.ClaimableInfiniteCount(a1) -- Line: 169 -- upvalues: u130 (val) -- types: a1: table
    local v1 = u130.FinalMilestone()
    if not a1.ClaimedMilestoneIds[v1.Id] then
        return 0
    end
    return (math.max(math.max((a1.Mastery - v1.Kills) // 10, 0) - a1.InfiniteRewardsClaimed, 0))
end

function u130.Presentation(a1) -- Line: 178
    -- upvalues: Assets (val), ScrambleTradeIn (val), EggSkins (val)
    local v1
    if a1.Kind == "Pet" then
        local Category = a1.Category
        v1 = assert(Assets.Directory[Category], (("Unknown Scramble mastery egg %*"):format(Category)))
        local v2 = ("%* has no egg icon"):format(Category)
        assert(type(v1.Egg.Icon) == "string", v2)
        v2 = ("%* has no egg name"):format(Category)
        assert(type(v1.Egg.DisplayName) == "string", v2)
        return {
            Amount = "x1",
            Title = v1.DisplayName,
            Rarity = v1.Rarity.DisplayName,
            Icon = v1.Icon,
        }
    end
    if a1.Kind ~= "Banner" then
        v1 = {}
        for i, j in ScrambleTradeIn.BannerIds() do
            table.insert(v1, (assert(
                EggSkins.Get((assert(ScrambleTradeIn.GetBannerEggSkin(j), (("Unknown Scramble banner %*"):format(j))))),
                (("Scramble banner %* has no egg skin"):format(j))
            )).Icon)
        end
        local v3 = if not a1.Mutated then "Random Egg" else "Random Scrambled Egg"
        return {
            Amount = "x1",
            Title = v3,
            Icon = v1[1],
            CycleIcons = v1,
            HoverTitle = string.upper(v3),
            HoverDescription = if not a1.Mutated then "Awards a random lab egg" else "Awards a random lab egg with the Scrambled mutation",
        }
    end
    local BannerId = a1.BannerId
    v1 = assert(
        EggSkins.Get((assert(ScrambleTradeIn.GetBannerEggSkin(BannerId), (("Unknown Scramble banner %*"):format(BannerId))))),
        (("Scramble banner %* has no egg skin"):format(BannerId))
    )
    local DisplayName_3 = if not a1.Mutated then v1.DisplayName else ("Scrambled %*"):format(v1.DisplayName)
    local v4 = {
        Amount = "x1",
        Title = DisplayName_3,
        Icon = v1.Icon,
        HoverTitle = string.upper(DisplayName_3),
    }
    local v5 = if not a1.Mutated then ("Awards a random %* pet"):format(v1.DisplayName) else ("Awards a random %* pet with the Scrambled mutation"):format(v1.DisplayName)
    v4.HoverDescription = v5
    return v4
end

for i, j in u125 do
    validate(j.Reward)
end
validate(u130.InfiniteReward)
local Category = u130.BossDropEgg.Category
v11 = assert(Assets.Directory[Category], (("Unknown Scramble mastery egg %*"):format(Category)))
local v14 = ("%* has no egg icon"):format(Category)
assert(type(v11.Egg.Icon) == "string", v14)
v14 = ("%* has no egg name"):format(Category)
assert(type(v11.Egg.DisplayName) == "string", v14)
return table.freeze(u130)