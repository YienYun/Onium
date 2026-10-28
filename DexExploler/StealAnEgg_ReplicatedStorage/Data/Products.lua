-- Script path: ReplicatedStorage.Data.Products
-- Decompile time: 21.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local EggProducts = require(ReplicatedStorage.Shared.Flags.GameplayBalance).EggProducts
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local GeneratedProducts = require(script.Internal.GeneratedProducts)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local HalloweenEggSettings = require(ReplicatedStorage.Data.HalloweenEggSettings)
local MarketplaceValidator = require(script.Internal.MarketplaceValidator)
require(script.Internal.ProductTypes)
local RaceRally = require(ReplicatedStorage.Data.RaceRally)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local StarBundles = require(ReplicatedStorage.Data.StarBundles)
local t = require(ReplicatedStorage.Packages.t)
local BillboardReward = require(script.Builders.BillboardReward)
local TreadmillAdEggBoost = require(script.Builders.TreadmillAdEggBoost)
local CashPack = require(script.Builders.CashPack)
local EggSkipGrowth = require(script.Builders.EggSkipGrowth)
local LimitedEgg_2 = require(script.Builders.LimitedEgg)
local Money = require(script.Builders.Money)
local RiftRefresh = require(script.Builders.RiftRefresh)
local SamplePack = require(script.Builders.SamplePack)
local SamplePacks = require(ReplicatedStorage.Data.SamplePacks)
local ServerLuck = require(script.Builders.ServerLuck)
local ServerLuckExtension = require(script.Builders.ServerLuckExtension)
local SpeedBoost = require(script.Builders.SpeedBoost)
local SpeedPower = require(script.Builders.SpeedPower)
local TemporarySpeedBoost = require(script.Builders.TemporarySpeedBoost)
local u1049 = {}
local u1053 = {}

local function enlist(a1) -- Line: 57 -- upvalues: t (val), u1049 (val), u1053 (val)
    local Name = a1.Name
    t.strict(t.string)(Name)
    t.strict(t.number)(a1.ProductId)
    if u1049[Name] ~= nil then
        error((("product \"%*\" is listed twice"):format(Name)))
    end
    local v1 = u1053[a1.ProductId]
    if v1 ~= nil then
        error((("\"%*\" reuses ProductId %* of \"%*\""):format(Name, a1.ProductId, v1.Name)))
    end
    u1049[Name] = a1
    u1053[a1.ProductId] = a1
end

local function requirePlayer(a1) -- Line: 74 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Player"))(a1)
end

local function clientProfileLoaded() -- Line: 78 -- upvalues: ReplicatedStorage (val)
    if require(ReplicatedStorage.Shared.Save).Await() ~= nil then
        return true
    end
    return false, "Data not loaded"
end

local function creditWhenLoaded(a1, a2, a3) -- Line: 86
    -- upvalues: ServerScriptService (val)
    if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
        return "Credit"
    end
    return "Retry"
end

local function retiredDnaProduct(a1, a2) -- Line: 93 -- types: a1: string, a2: number
    local function refuse() -- Line: 94
        return false, "DNA stealing is no longer available."
    end

    return {
        Desc = "DNA stealing is no longer available.",
        Silent = true,
        Name = a1,
        ProductId = a2,
        DisplayName = a1,
        Precheck = refuse,
        Authorize = refuse,
        Grant = refuse,
    }
end

local function growAllEggsProduct(a1) -- Line: 110
    -- upvalues: ServerScriptService (val), t (val), ReplicatedStorage (val), creditWhenLoaded (val)
    local function eggs() -- Line: 111 -- upvalues: ServerScriptService (upval)
        return (require(ServerScriptService.Controllers.Eggs))
    end

    return {
        DisplayName = "Grow All Eggs",
        Desc = "Finish growing all placed eggs.",
        ProductId = 3611613592,
        HoldWhilePending = true,
        Silent = true,
        Name = a1,
        Grant = function(a1) -- Line: 122 -- upvalues: t (upval), ServerScriptService (upval) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.Eggs).PurchaseGrowAll(a1)
        end,
        Precheck = function() -- Line: 126 -- upvalues: ReplicatedStorage (upval)
            return require(ReplicatedStorage.Client.EggState).MayBuyGrowAll()
        end,
        Authorize = function(a1) -- Line: 130 -- upvalues: t (upval), ServerScriptService (upval) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.Eggs).CanPurchaseGrowAll(a1)
        end,
        ResolveFailedReceipt = creditWhenLoaded,
    }
end

local function earningsBoostProduct(a1) -- Line: 138
    -- upvalues: ReplicatedStorage (val), ServerScriptService (val), t (val), clientProfileLoaded (val)
    -- upvalues: creditWhenLoaded (val)
    local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
    local v1 = PlayerEarningsBoost.GetConfiguredMultiplier()
    local v2 = PlayerEarningsBoost.DURATION_SECONDS / 60

    local function boostService() -- Line: 143 -- upvalues: ServerScriptService (upval)
        return require(ServerScriptService.Controllers.EarningsBoostService)
    end

    return {
        ProductId = 3709963353,
        HoldWhilePending = true,
        Name = a1,
        DisplayName = ("x%* Earnings (%*m)"):format(v1, v2),
        Desc = ("Your pets earn %*x cash for %* minutes."):format(v1, v2),
        Grant = function(a1) -- Line: 153 -- upvalues: t (upval), ServerScriptService (upval) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.EarningsBoostService).Activate(a1)
        end,
        Precheck = clientProfileLoaded,
        Authorize = function(a1) -- Line: 158 -- upvalues: t (upval), ServerScriptService (upval) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.EarningsBoostService).CanActivate(a1)
        end,
        ResolveFailedReceipt = creditWhenLoaded,
    }
end

local function sakuraLuckBoostProduct(a1, a2, a3) -- Line: 166
    -- upvalues: GameFlags (val), ServerScriptService (val), Sakura (val), t (val), ReplicatedStorage (val)
    local function bloomActive() -- Line: 167 -- upvalues: GameFlags (upval)
        return GameFlags.GreatBloomEnabled:Get() == true
    end

    local function sakuraService() -- Line: 171 -- upvalues: ServerScriptService (upval)
        return require(ServerScriptService.Controllers.SakuraService)
    end

    return {
        HoldWhilePending = true,
        Name = a1,
        DisplayName = ("Sakura Luck Boost %*"):format(a3),
        Desc = ("%*x Great Bloom odds for the egg inside the incubator (%*/%*)."):format(
            Sakura.GetLuckMultiplier(a3),
            a3,
            Sakura.Incubator.MaxLuckBoosts
        ),
        ProductId = a2,
        Grant = function(a1) -- Line: 181 -- upvalues: t (upval), ServerScriptService (upval), a3 (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            return require(ServerScriptService.Controllers.SakuraService).ActivateLuckBoost(a1, a3)
        end,
        Precheck = function() -- Line: 185 -- upvalues: GameFlags (upval), ReplicatedStorage (upval), Sakura (upval), a3 (val)
            if not (GameFlags.GreatBloomEnabled:Get() == true) then
                return false, "The Great Bloom has ended"
            end
            local v1 = require(ReplicatedStorage.Shared.Save).Await()
            if v1 == nil then
                return false, "Data not loaded"
            end
            return Sakura.CanBuyLuckBoost(v1.Sakura, a3)
        end,
        Authorize = function(a1) -- Line: 196
            -- upvalues: t (upval), GameFlags (upval), ServerScriptService (upval), a3 (val)
            t.strict(t.instanceIsA("Player"))(a1)
            if not (GameFlags.GreatBloomEnabled:Get() == true) then
                return false, "The Great Bloom has ended"
            end
            return require(ServerScriptService.Controllers.SakuraService).CanActivateLuckBoost(a1, a3)
        end,
        ResolveFailedReceipt = function(a1, a2_2, a3) -- Line: 203
            -- upvalues: GameFlags (upval), ServerScriptService (upval), a2 (val)
            if not (GameFlags.GreatBloomEnabled:Get() == true) then
                (require(ServerScriptService.UserGenerated.Analytics)):LogPlayerEvent(
                    a1,
                    "PlayerRetiredProductReceipt",
                    {ProductId = a2, Reason = a3 or "Unknown"}
                )
                return "Satisfied"
            end
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(a1) then
                return "Credit"
            end
            return "Retry"
        end,
    }
end

local function starBundleProduct(a1, a2, a3) -- Line: 221
    -- upvalues: ServerScriptService (val), t (val), ReplicatedStorage (val), StarBundles (val), creditWhenLoaded (val)
    local function starService() -- Line: 222 -- upvalues: ServerScriptService (upval)
        return require(ServerScriptService.Controllers.ShootingStarService)
    end

    return {
        HoldWhilePending = true,
        Silent = true,
        Giftable = false,
        Name = a1,
        DisplayName = if a3 ~= 1 then ("%* Stars"):format(a3) else "1 Star",
        Desc = ("Get %* Star%* from the Star Handler!"):format(a3, if a3 ~= 1 then "s" else ""),
        ProductId = a2,
        Grant = function(a1, a2) -- Line: 234 -- upvalues: t (upval), ServerScriptService (upval), a3 (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            local v1 = require(ServerScriptService.Controllers.ShootingStarService).GrantPurchased(a1, a3, a2)
            local v2 = v1 == true
            if v1 then
                return v2, nil
            end
            return v2, "Star grant failed"
        end,
        Precheck = function() -- Line: 239 -- upvalues: ReplicatedStorage (upval), StarBundles (upval), a3 (val)
            local v1 = require(ReplicatedStorage.Shared.Save).Await()
            if v1 == nil then
                return false, "Data not loaded"
            end
            local v2 = StarBundles.StockRefusal(v1.MountStarStock, a3, workspace:GetServerTimeNow())
            return v2 == nil, v2
        end,
        Authorize = function(a1, a2) -- Line: 252
            -- upvalues: t (upval), ServerScriptService (upval), StarBundles (upval), a3 (val)
            t.strict(t.instanceIsA("Player"))(a1)
            local Database = require(ServerScriptService.Library.Database)
            if not Database.IsPlayerLoaded(a1) then
                return false, "Data not loaded"
            end
            if a2 ~= nil then
                return true
            end
            local success, err = pcall(Database.UnsafeGetProfileAsync, a1)
            if success and typeof(err) == "table" then
                local v1 = StarBundles.StockRefusal(err.MountStarStock, a3, workspace:GetServerTimeNow())
                return v1 == nil, v1
            end
            return false, "Data not loaded"
        end,
        ResolveFailedReceipt = creditWhenLoaded,
    }
end

enlist((growAllEggsProduct("EggGrowAll")))
enlist((earningsBoostProduct("EarningsBoost2x")))
enlist(RiftRefresh("RiftRefresh", 3710888247))
for i, j in SamplePacks.Offers do
    enlist(SamplePack(("SamplePack%*"):format(i), j.ProductId))
end
for k, n in {
    {ProductId = 3611606887, Minutes = 15},
    {ProductId = 3611606895, Minutes = 30},
    {ProductId = 3611606898, Minutes = 60},
    {ProductId = 3611606901, Minutes = 120},
    {ProductId = 3611606906, Minutes = 180},
    {ProductId = 3611606912, Minutes = 240},
    {ProductId = 3611606918, Minutes = 360},
    {ProductId = 3611606926, Minutes = 480},
    {ProductId = 3611606930, Minutes = 600},
    {ProductId = 3611606938, Minutes = 720},
} do
    enlist(EggSkipGrowth(("Instant Hatch (%*)"):format(k), n.ProductId, n.Minutes * 60))
end
local v1 = {
    {Name = "Limited Egg", Count = 1, ProductId = 3712476038, Config = LimitedEgg.Luminous},
    {Name = "Limited Egg x3", Count = 3, ProductId = 3712476039, Config = LimitedEgg.Luminous},
    {Name = "Limited Egg x10", Count = 10, ProductId = 3712476044, Config = LimitedEgg.Luminous},
    {Name = "Limited Egg x50", Count = 50, ProductId = 3712476050, Config = LimitedEgg.Luminous},
    {Name = "Extinction Egg", Count = 1, ProductId = 3714749344, Config = LimitedEgg.Extinction},
    {
        Name = "Extinction Egg x3",
        Count = 3,
        ProductId = 3714749375,
        Config = LimitedEgg.Extinction,
    },
    {
        Name = "Extinction Egg x10",
        Count = 10,
        ProductId = 3714749397,
        Config = LimitedEgg.Extinction,
    },
    {
        Name = "Extinction Egg x50",
        Count = 50,
        ProductId = 3714749414,
        Config = LimitedEgg.Extinction,
    },
}
for m, i5 in v1 do
    enlist(LimitedEgg_2(i5.Name, i5.ProductId, i5.Count, i5.Config))
end
local v2 = {
    {Key = "Single", Count = 1},
    {Key = "Triple", Count = 3},
    {Key = "Ten", Count = 10},
    {Key = "Fifty", Count = 50},
}
local v3 = nil
local v4 = nil
for i6, i7 in v2, v3, v4 do
    v1 = HalloweenEggSettings.ProductIds[i7.Key]
    if v1 > 0 then
        enlist(LimitedEgg_2(if i7.Count ~= 1 then ("Halloween Egg x%*"):format(i7.Count) else "Halloween Egg", v1, i7.Count, LimitedEgg.Halloween))
    end
    v1 = HalloweenEggSettings.GiftProductIds[i7.Key]
    if v1 > 0 then
        enlist(LimitedEgg_2(
            if i7.Count ~= 1 then ("Halloween Egg Gift x%*"):format(i7.Count) else "Halloween Egg Gift",
            v1,
            i7.Count,
            LimitedEgg.Halloween
        ))
    end
end
for i8, i9 in {
    {Amount = 24000, ProductId = 3611606487},
    {Amount = 200000, ProductId = 3611606470},
    {Amount = 800000, ProductId = 3611606501},
    {Amount = 4000000, ProductId = 3611606493},
    {Amount = 8000000, ProductId = 3611606507},
} do
    enlist(Money(("Money_%*"):format(i9.Amount), i9.ProductId))
end
for i10, i11 in CashPacks.Offers do
    enlist(CashPack(i11.Name, i11.ProductId))
end
for i12, i13 in {3709207454, 3709207509, 3709207563} do
    enlist((sakuraLuckBoostProduct(("SakuraLuckBoost%*"):format(i12), i13, i12)))
end
for i14, i15 in {
    {Multiplier = 2, ProductId = 3604958187},
    {Multiplier = 4, ProductId = 3604958083},
    {Multiplier = 8, ProductId = 3604957992},
} do
    enlist(ServerLuck(("ServerLuck_X%*"):format(i15.Multiplier), i15.ProductId, i15.Multiplier))
end
for i16, i17 in {{Minutes = 15, ProductId = 3604958348}, {Minutes = 30, ProductId = 3604958272}} do
    enlist(ServerLuckExtension(("ServerLuck_Extend%*"):format(i17.Minutes), i17.ProductId, i17.Minutes))
end

local function doubleTrophiesProduct(a1, a2) -- Line: 388
    -- upvalues: ServerScriptService (val), RaceRally (val), ReplicatedStorage (val), t (val)
    local u4 = tostring(a2)

    local function database() -- Line: 391 -- upvalues: ServerScriptService (upval)
        return (require(ServerScriptService.Library.Database))
    end

    local function owned(a1) -- Line: 395 -- upvalues: ServerScriptService (upval), u4 (val) -- types: a1: userdata
        local Database = require(ServerScriptService.Library.Database)
        if not Database.IsPlayerLoaded(a1) then
            return nil
        end
        local v1, v2 = Database.UnsafeGetProfileAwait(a1)
        if v1 and type(v2) == "table" then
            local v3 = false
            if type(v2.Products) == "table" then
                v3 = v2.Products[u4] == true
            end
            return v3
        end
        return nil
    end

    return {
        DisplayName = "2x Trophies",
        Desc = "Earn double Trophies from every race. Forever!",
        OneTime = true,
        HoldWhilePending = true,
        Giftable = false,
        Name = a1,
        ProductId = a2,
        Icon = RaceRally.DoubleTrophies.Icon,
        Precheck = function() -- Line: 416 -- upvalues: ReplicatedStorage (upval), u4 (val)
            local v1 = require(ReplicatedStorage.Shared.Save).Await()
            if v1 == nil then
                return false, "Data not loaded"
            end
            if type(v1.Products) == "table" and v1.Products[u4] == true then
                return false, "You already own 2x Trophies!"
            end
            return true
        end,
        Authorize = function(a1, a2) -- Line: 427 -- upvalues: t (upval), owned (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            local v1 = owned(a1)
            if v1 == nil then
                return false, "Data not loaded"
            end
            if v1 and a2 == nil then
                return false, "You already own 2x Trophies!"
            end
            return true
        end,
        Grant = function(a1) -- Line: 438 -- upvalues: t (upval), ServerScriptService (upval), u4 (val) -- types: a1: userdata
            t.strict(t.instanceIsA("Player"))(a1)
            local v1, v2 = (require(ServerScriptService.Library.Database)).UpdateProfileImmutable(a1, function(a1) -- Line: 441 -- upvalues: u4 (upval)
                local v1 = table.clone(a1)
                local v2 = table.clone(a1.Products or {})
                v2[u4] = true
                v1.Products = v2
                return v1
            end):await()
            if v1 and v2 == true then
                return true
            end
            return false, "Couldn't save 2x Trophies"
        end,
        ResolveFailedReceipt = function(a1) -- Line: 454 -- upvalues: owned (val) -- types: a1: userdata
            if owned(a1) == true then
                return "Satisfied"
            end
            return "Retry"
        end,
    }
end

enlist((doubleTrophiesProduct(RaceRally.DoubleTrophies.Key, RaceRally.DoubleTrophies.ProductId)))
enlist((doubleTrophiesProduct(("%*_DEV"):format(RaceRally.DoubleTrophies.Key), RaceRally.DoubleTrophies.DevProductId)))
for i18, i19 in StarBundles.Bundles do
    enlist((starBundleProduct(i19.Key, i19.ProductId, i19.Count)))
    enlist((starBundleProduct(("%*_DEV"):format(i19.Key), i19.DevProductId, i19.Count)))
end
for i20, i21 in {
    3611606570,
    3611606611,
    3611606618,
    3611606628,
    3611606636,
    3611606645,
    3611606648,
    3611606653,
    3611606661,
    3611606588,
    3611606597,
    3611606604,
} do
    enlist(SpeedBoost(("SpeedBoostTier%*"):format(i20), i21, i20, 2 ^ i20))
end
for i22, i23 in {
    {Amount = 150000, ProductId = 3611606545},
    {Amount = 1000000, ProductId = 3611606516},
    {Amount = 10000000, ProductId = 3611606528},
    {Amount = 50000000, ProductId = 3611606552},
    {Amount = 500000000, ProductId = 3611606562},
    {Amount = 1000000000, ProductId = 3611606539},
} do
    enlist(SpeedPower(("SpeedPower_%*"):format(i23.Amount), i23.ProductId))
end
for i24, i25 in {
    {Rarity = "Common", ProductId = 3611606824},
    {Rarity = "Uncommon", ProductId = 3611606832},
    {Rarity = "Rare", ProductId = 3611606840},
    {Rarity = "Epic", ProductId = 3611606843},
    {Rarity = "Legendary", ProductId = 3611606849},
    {Rarity = "Mythic", ProductId = 3611606854},
    {Rarity = "Cosmic", ProductId = 3611606859},
    {Rarity = "Secret", ProductId = 3611606864},
    {Rarity = "Eternal", ProductId = 3611606875},
    {Rarity = "Divine", ProductId = 3611606880},
} do
    enlist((retiredDnaProduct(("Steal%*"):format(i25.Rarity), i25.ProductId)))
end
for i26, i27 in {
    {Label = "10Minutes", Seconds = 600, ProductId = 3608561503},
    {Label = "30Minutes", Seconds = 1800, ProductId = 3608561464},
    {Label = "1Hour", Seconds = 3600, ProductId = 3608561433},
} do
    enlist(TemporarySpeedBoost(("TemporarySpeedBoost_%*"):format(i27.Label), i27.ProductId, i27.Seconds))
end
v2 = {
    {Variant = "Alt1", Control = 3711307995, Double = 3711308134, Quadruple = 3711308259},
    {Variant = "Alt2", Control = 3711039542, Double = 3711036110, Quadruple = 3711036196},
    {Variant = "Default", Control = 3711313393, Double = 3711313465, Quadruple = 3711313519},
}
v3 = nil
v4 = nil
for i28, i29 in v2, v3, v4 do
    for i30, i31 in {Control = i29.Control, ["2x"] = i29.Double, ["4x"] = i29.Quadruple} do
        enlist(BillboardReward(("RVBillboard_%*_%*"):format(i29.Variant, i30), i31))
    end
end
for i32, i33 in {
    {Name = "TreadmillAdEggBoost", ProductId = 3714369091},
    {Name = "TreadmillAdEggBoost_DEV", ProductId = 3714368905},
    {Name = "TreadmillAdEggBoost_DEV2", ProductId = 3590880144},
} do
    enlist(TreadmillAdEggBoost(i33.Name, i33.ProductId))
end
for i34, i35 in GeneratedProducts.Records do
    enlist(i35)
end
if Constants.IS_STUDIO then
    local u459 = {}
    for i36 in u1049 do
        table.insert(u459, i36)
    end
    table.sort(u459)
    task.spawn(function() -- Line: 585 -- upvalues: u459 (val), MarketplaceValidator (val), u1049 (val)
        for i, j in u459 do
            MarketplaceValidator.Validate(j, u1049[j])
        end
    end)
end
table.freeze(u1049)
table.freeze(u1053)

local function ladder(a1) -- Line: 597 -- upvalues: u1049 (val) -- types: a1: function
    local v1 = {}
    for i, j in u1049 do
        if a1(j) ~= nil then
            table.insert(v1, j)
        end
    end
    table.sort(v1, function(a1_2, a2) -- Line: 604 -- upvalues: a1 (val)
        return (a1(a1_2)) < a1(a2)
    end)
    return table.freeze(v1)
end

local u498 = ladder(function(a1) -- Line: 610
    return a1.EggSkipGrowthMaxRemainingSeconds
end)
local u502 = ladder(function(a1) -- Line: 613
    return a1.SpeedPowerReward
end)
return {
    Directory = u1049,
    TreadmillSpeedEquivalentOffers = GeneratedProducts.TreadmillSpeedEquivalentOffers,
    FromProductId = function(a1) -- Line: 622 -- upvalues: u1053 (val) -- types: a1: number
        return u1053[a1]
    end,
    ProductNameExists = function(a1) -- Line: 626 -- upvalues: u1049 (val) -- types: a1: string
        if rawget(u1049, a1) ~= nil then
            return true
        end
        return false, (("no product is registered under \"%*\""):format(a1))
    end,
    GetEggSkipGrowthProduct = function(a1) -- Line: 633 -- upvalues: EggProducts (val), u498 (val) -- types: a1: number
        assert(a1 >= 0, "remaining seconds cannot be negative")
        if a1 <= EggProducts.MIN_SKIP_SECONDS then
            return nil
        end
        for i, j in u498 do
            if a1 <= j.EggSkipGrowthMaxRemainingSeconds then
                return j
            end
        end
        return assert(u498[#u498], "no egg skip-growth product is registered")
    end,
    SmallestSufficientSpeedPowerProduct = function(a1) -- Line: 646 -- upvalues: t (val), u502 (val) -- types: a1: number
        t.strict(t.numberPositive)(a1)
        for i, j in u502 do
            if a1 <= j.SpeedPowerReward then
                return j
            end
        end
        return (assert(u502[#u502], "no speed-power product is registered"))
    end,
}