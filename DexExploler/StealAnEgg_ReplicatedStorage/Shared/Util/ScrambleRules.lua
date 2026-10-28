-- Script path: ReplicatedStorage.Shared.Util.ScrambleRules
-- Decompile time: 27.81 ms

local ScrambleBossDrop = require(game:GetService("ReplicatedStorage").Shared.Util.ScrambleBossDrop)
local u10 = {MAX_SAMPLES = 9000000000000}
u10.PART_IDS = table.freeze({"LostPart1", "LostPart2", "DronePart1", "DronePart2", "DronePart3"})

function u10.Blank() -- Line: 10
    return {
        DroneParts = 0,
        Discovered = false,
        Completed = false,
        RewardUid = "",
        MutationConsumables = 0,
        ShopSequence = 0,
        LastOperation = "",
        Mastery = 0,
        InfiniteRewardsClaimed = 0,
        Wallets = {},
        LostParts = {},
        ShopPurchases = {},
        Receipts = {},
        ClaimedMilestoneIds = {},
    }
end

function u10.Integer(a1, a2, a3) -- Line: 29 -- types: a2: number, a3: number
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = false
            if a1 % 1 == 0 then
                v1 = false
                if a2 <= a1 then
                    v1 = a1 <= a3
                end
            end
        end
    end
    return v1
end

function u10.Count(a1) -- Line: 37
    local v1 = 0
    for i in a1 do
        v1 = v1 + 1
    end
    return v1
end

function u10.Progress(a1) -- Line: 45
    return (if not a1.LostParts.LostPart1 then 0 else 1) + (if not a1.LostParts.LostPart2 then 0 else 1), a1.DroneParts
end

function u10.NextPart(a1) -- Line: 52
    if not a1.Completed and not (3 <= a1.DroneParts) then
        return "DronePart" .. tostring(a1.DroneParts + 1)
    end
    return nil
end

function u10.Project(a1, a2) -- Line: 58 -- upvalues: u10 (val) -- types: a2: string
    local v1, v2 = u10.Progress(a1)
    return {
        Samples = a1.Wallets[a2] or 0,
        ShopSequence = a1.ShopSequence,
        ShopPurchases = table.clone((a1.ShopPurchases or {})[a2] or {}),
        LostParts = table.clone(a1.LostParts),
        DroneParts = v2,
        TotalParts = v1 + v2,
        Discovered = a1.Discovered,
        Completed = a1.Completed,
        Mastery = a1.Mastery or 0,
        ClaimedMilestoneIds = table.clone(a1.ClaimedMilestoneIds or {}),
        InfiniteRewardsClaimed = a1.InfiniteRewardsClaimed or 0,
    }
end

function u10.Window(a1, a2, a3, a4, a5) -- Line: 76 -- types: a1: number, a2: number, a3: number, a4: number, a5: number
    if not (a2 <= 0) and not (a3 <= a2) and not (a1 < a2) and not (a3 <= a1) then
        local v1 = math.floor(a1 / a4)
        local v2 = v1 * a4
        local v3 = math.min(v2 + a5, a3)
        return {
            Available = true,
            Active = a1 < v3,
            Index = v1,
            StartsAt = v2,
            EndsAt = v3,
            NextAt = math.min(v2 + a4, a3),
        }
    end
    return {
        Available = false,
        Active = false,
        Index = -1,
        EndsAt = a3,
        NextAt = a2,
    }
end

function u10.SplitSamples(a1, a2) -- Line: 100 -- upvalues: u10 (val) -- types: a1: number, a2: number
    local v1
    assert(u10.Integer(a1, 0, u10.MAX_SAMPLES) and u10.Integer(a2, 1, 32))
    local v2 = math.min(a1, a2)
    local v3 = {}
    if v2 == 0 then
        return v3
    end
    local v4 = math.floor(a1 / v2)
    local v5 = a1 % v2
    for i = 1, v2 do
        v1 = if not (i <= v5) then 0 else 1
        v3[i] = v4 + v1
    end
    return v3
end

function u10.Apply(a1, a2, a3, a4) -- Line: 117 -- upvalues: u10 (val), ScrambleBossDrop (val) -- types: a2: string
    local v1, v2, v3, v4
    local Scramble = a1.Scramble
    if a3.OperationId and Scramble.LastOperation == a3.OperationId then
        return false, "AlreadyGranted"
    end
    local u651 = table.clone(Scramble)
    local OperationId = a3.OperationId or Scramble.LastOperation
    u651.LastOperation = OperationId
    local u681 = table.clone(a1)
    u681.Scramble = u651
    local EventId = a3.EventId
    local Rewards_3 = nil

    local function credit(a1) -- Line: 128
        -- upvalues: u10 (upval), Scramble (val), EventId (val), u651 (val)
        if not u10.Integer(a1, 1, u10.MAX_SAMPLES) then
            return false
        end
        local v1 = Scramble.Wallets[EventId] or 0
        if u10.MAX_SAMPLES - a1 < v1 then
            return false
        end
        u651.Wallets = table.clone(Scramble.Wallets)
        u651.Wallets[EventId] = v1 + a1
        return true
    end

    local function addEggs(a1_2, a2, a3) -- Line: 140
        -- upvalues: u10 (upval), a1 (val), a4 (val), u681 (val)
        if type(a1_2) ~= "table" then
            return "MissingReward"
        end
        if not a3 and a4.Eggs < u10.Count(a1.EggInventory) + a2 then
            return "EggInventoryFull"
        end
        if u10.Count(a1_2) ~= a2 then
            return "MissingReward"
        end
        local v1 = table.clone(a1.EggInventory)
        for i, j in a1_2 do
            if type(i) == "string" and i ~= "" and type(j) == "table" then
                if v1[i] then
                    return "DuplicateReward"
                end
                v1[i] = j
                continue
            end
            return "MissingReward"
        end
        u681.EggInventory = v1
        return nil
    end

    if a2 == "Samples" then
        local Amount = a3.Amount
        if u10.Integer(Amount, 1, u10.MAX_SAMPLES) then
            v3 = Scramble.Wallets[EventId] or 0
            if not (u10.MAX_SAMPLES - Amount < v3) then
                u651.Wallets = table.clone(Scramble.Wallets)
                u651.Wallets[EventId] = v3 + Amount
                v1 = true
            else
                v1 = false
            end
        else
            v1 = false
        end
        if not v1 then
            return false, "BalanceLimit"
        end
        return u681, "Granted", Rewards_3
    end
    if a2 == "Consumable" then
        v1 = Scramble.MutationConsumables or 0
        if u10.Integer(a3.Amount, 1, u10.MAX_SAMPLES) and not (u10.MAX_SAMPLES - a3.Amount < v1) then
            u651.MutationConsumables = v1 + a3.Amount
            return u681, "Granted", Rewards_3
        end
        return false, "BalanceLimit"
    end
    if a2 == "Part" then
        if Scramble.Completed then
            return false, "AlreadyComplete"
        end
        if a3.Id ~= "LostPart1" and a3.Id ~= "LostPart2" then
            if a3.Id ~= u10.NextPart(Scramble) then
                return false, "WrongPart"
            end
            u651.DroneParts = u651.DroneParts + 1
            return u681, "Granted", Rewards_3
        end
        if Scramble.LostParts[a3.Id] then
            return false, "AlreadyCollected"
        end
        u651.LostParts = table.clone(Scramble.LostParts)
        u651.LostParts[a3.Id] = true
        return u681, "Granted", Rewards_3
    end
    if a2 == "Discover" then
        if Scramble.Discovered then
            return false, "AlreadyDiscovered"
        end
        u651.Discovered = true
        return u681, "Granted", Rewards_3
    end
    if a2 == "Vault" then
        if Scramble.Completed then
            return false, "AlreadyComplete"
        end
        v1, v2 = u10.Progress(Scramble)
        if Scramble.Discovered and v1 + v2 == 5 then
            if type(a3.Gear) == "string" and a3.Gear ~= "" and u10.Integer(a3.Amount, 1, 100) then
                u681.GearInventory = table.clone(a1.GearInventory)
                u681.GearInventory[a3.Gear] = (math.max(u681.GearInventory[a3.Gear] or 0, a3.Amount))
                v4 = "Gear:" .. a3.Gear
                u651.Completed = true
                u651.RewardUid = v4
                return u681, "Granted", Rewards_3
            end
            return false, "MissingReward"
        end
        return false, "MissingParts"
    end
    if a2 ~= "Shop" then
        if a2 == "Receipt" then
            if Scramble.Receipts[a3.PurchaseId] then
                v1 = Scramble.Receipts[a3.PurchaseId]
                v2 = false
                if v1.ProductId == a3.ProductId then
                    return v2, "AlreadyGranted"
                end
                return v2, "ReceiptMismatch"
            end
            local Amount_3 = a3.Amount
            if u10.Integer(Amount_3, 1, u10.MAX_SAMPLES) then
                v3 = Scramble.Wallets[EventId] or 0
                if not (u10.MAX_SAMPLES - Amount_3 < v3) then
                    u651.Wallets = table.clone(Scramble.Wallets)
                    u651.Wallets[EventId] = v3 + Amount_3
                    v1 = true
                else
                    v1 = false
                end
            else
                v1 = false
            end
            if not v1 then
                return false, "BalanceLimit"
            end
            u651.Receipts = table.clone(Scramble.Receipts)
            u651.Receipts[a3.PurchaseId] = {ProductId = a3.ProductId, EventId = EventId, Amount = a3.Amount}
            u681.MonetizationRobuxSpentTotal = (a1.MonetizationRobuxSpentTotal or 0) + (a3.RobuxSpent or 0)
            return u681, "Granted", Rewards_3
        end
        if a2 == "BossKill" then
            if not u10.Integer(a3.Amount, 0, u10.MAX_SAMPLES) then
                return false, "InvalidAmount"
            end
            if 0 < a3.Amount then
                local Amount_4 = a3.Amount
                if u10.Integer(Amount_4, 1, u10.MAX_SAMPLES) then
                    v3 = Scramble.Wallets[EventId] or 0
                    if not (u10.MAX_SAMPLES - Amount_4 < v3) then
                        u651.Wallets = table.clone(Scramble.Wallets)
                        u651.Wallets[EventId] = v3 + Amount_4
                        v1 = true
                    else
                        v1 = false
                    end
                else
                    v1 = false
                end
                if not v1 then
                    return false, "BalanceLimit"
                end
            end
            u651.Mastery = (Scramble.Mastery or 0) + 1
            u681.MechaScramblerObtained = ScrambleBossDrop.HasObtained(a1)
            if a3.Rewards ~= nil and not u681.MechaScramblerObtained then
                v1 = addEggs(a3.Rewards, 1, true)
                if v1 then
                    return false, v1
                end
                u681.MechaScramblerObtained = true
            end
            return u681, "Granted", Rewards_3
        end
        if a2 == "Milestone" then
            v1 = Scramble.Mastery or 0
            local ClaimedMilestoneIds = Scramble.ClaimedMilestoneIds or {}
            if a3.Infinite then
                if type(a3.FinalMilestoneId) == "string"
                    and u10.Integer(a3.FinalKills, 1, u10.MAX_SAMPLES)
                    and u10.Integer(a3.EveryKills, 1, u10.MAX_SAMPLES) then
                    v3 = Scramble.InfiniteRewardsClaimed or 0
                    if ClaimedMilestoneIds[a3.FinalMilestoneId]
                        and not ((v1 - a3.FinalKills) // a3.EveryKills <= v3) then
                        u651.InfiniteRewardsClaimed = v3 + 1
                        v2 = addEggs(a3.Rewards, 1)
                        if v2 then
                            return false, v2
                        end
                        return u681, "Granted", Rewards_3
                    end
                    return false, "MilestoneLocked"
                end
                return false, "MissingReward"
            end
            if type(a3.MilestoneId) == "string" and u10.Integer(a3.Kills, 1, u10.MAX_SAMPLES) then
                if ClaimedMilestoneIds[a3.MilestoneId] then
                    return false, "MilestoneClaimed"
                end
                if v1 < a3.Kills then
                    return false, "MilestoneLocked"
                end
                u651.ClaimedMilestoneIds = table.clone(ClaimedMilestoneIds)
                u651.ClaimedMilestoneIds[a3.MilestoneId] = true
                v2 = addEggs(a3.Rewards, 1)
                if v2 then
                    return false, v2
                end
                return u681, "Granted", Rewards_3
            end
            return false, "MissingReward"
        end
        return false, "UnknownAction"
    end
    if u10.Integer(a3.Sequence, 0, u10.MAX_SAMPLES - 1) and a3.Sequence == Scramble.ShopSequence then
        if u10.Integer(a3.Price, 1, u10.MAX_SAMPLES)
            and u10.Integer(a3.Quantity, 1, 25)
            and type(a3.Rewards) == "table" then
            local EarningsBoostExpiresAt, v5, v6
            v1 = Scramble.Wallets[EventId] or 0
            if v1 < a3.Price then
                return false, "NotEnoughSamples"
            end
            local ShopPurchases = Scramble.ShopPurchases or {}
            v3 = ShopPurchases[EventId] or {}
            v2 = v3[a3.OfferId]
            local Count = if not v2 then 0 else if v2.Period ~= a3.PurchasePeriod then 0 else v2.Count
            if a3.PurchaseLimit == nil then
                v2 = a3.Kind or "Egg"
                if v2 == "Pet" then
                    if a4.Pets < (u10.Count(a1.Inventory)) + a3.Quantity then
                        return false, "PetInventoryFull"
                    end
                    if (u10.Count(a3.Rewards)) ~= a3.Quantity then
                        return false, "MissingReward"
                    end
                    v4 = table.clone(a1.Inventory)
                    v5 = table.clone(a1.Index)
                    for k, n in a3.Rewards do
                        if type(k) == "string" and k ~= "" and type(n) == "table" then
                            if v4[k] then
                                return false, "DuplicateReward"
                            end
                            v4[k] = n
                            v5[n.Category] = true
                            continue
                        end
                        return false, "MissingReward"
                    end
                    Rewards_3 = a3.Rewards
                    u681.Inventory = v4
                    u681.Index = v5
                    v6 = a3
                    u651.Wallets = table.clone(Scramble.Wallets)
                    u651.Wallets[EventId] = v1 - v6.Price
                    u651.ShopSequence = Scramble.ShopSequence + 1
                    if v6.PurchaseLimit ~= nil then
                        u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                        v2 = table.clone(u651.ShopPurchases[EventId] or {})
                        v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                        u651.ShopPurchases[EventId] = v2
                    end
                    return u681, "Granted", Rewards_3
                end
                if v2 == "Egg" then
                    v4 = addEggs(a3.Rewards, a3.Quantity)
                    if v4 then
                        return false, v4
                    end
                    v6 = a3
                    u651.Wallets = table.clone(Scramble.Wallets)
                    u651.Wallets[EventId] = v1 - v6.Price
                    u651.ShopSequence = Scramble.ShopSequence + 1
                    if v6.PurchaseLimit ~= nil then
                        u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                        v2 = table.clone(u651.ShopPurchases[EventId] or {})
                        v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                        u651.ShopPurchases[EventId] = v2
                    end
                    return u681, "Granted", Rewards_3
                end
                if v2 == "MutationConsumable" then
                    v4 = Scramble.MutationConsumables or 0
                    if not u10.Integer(v4, 0, u10.MAX_SAMPLES - a3.Quantity) then
                        return false, "BalanceLimit"
                    end
                    u651.MutationConsumables = v4 + a3.Quantity
                    v6 = a3
                    u651.Wallets = table.clone(Scramble.Wallets)
                    u651.Wallets[EventId] = v1 - v6.Price
                    u651.ShopSequence = Scramble.ShopSequence + 1
                    if v6.PurchaseLimit ~= nil then
                        u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                        v2 = table.clone(u651.ShopPurchases[EventId] or {})
                        v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                        u651.ShopPurchases[EventId] = v2
                    end
                    return u681, "Granted", Rewards_3
                end
                if v2 ~= "CashBooster" and v2 ~= "SpeedBoost" and v2 ~= "TreadmillBoost" then
                    return false, "MissingReward"
                end
                if a3.Quantity == 1
                    and u10.Integer(a3.DurationSeconds, 1, 86400)
                    and type(a3.Now) == "number"
                    and a3.Now == a3.Now
                    and not (a3.Now <= 0)
                    and not (4000000000 < a3.Now) then
                    EarningsBoostExpiresAt = if v2 ~= "CashBooster" then if v2 ~= "SpeedBoost" then a4.TreadmillRemaining(a1, a3.Now) else a1.BossMastery.SpeedBoostExpiresAt else a1.EarningsBoostExpiresAt
                    if type(EarningsBoostExpiresAt) == "number"
                        and EarningsBoostExpiresAt == EarningsBoostExpiresAt
                        and not (EarningsBoostExpiresAt < 0)
                        and not (4000000000 - a3.DurationSeconds < EarningsBoostExpiresAt) then
                        if v2 == "CashBooster" then
                            u681.EarningsBoostExpiresAt = (math.max(a3.Now, EarningsBoostExpiresAt)) + a3.DurationSeconds
                        elseif v2 ~= "SpeedBoost" then
                            u681.TemporarySpeedBoostRemainingSeconds = EarningsBoostExpiresAt + a3.DurationSeconds
                            u681.TemporarySpeedBoostActiveStartedAt = a3.Now
                        else
                            u681.BossMastery = table.clone(a1.BossMastery)
                            u681.BossMastery.SpeedBoostExpiresAt = (math.max(a3.Now, EarningsBoostExpiresAt)) + a3.DurationSeconds
                        end
                        v6 = a3
                        u651.Wallets = table.clone(Scramble.Wallets)
                        u651.Wallets[EventId] = v1 - v6.Price
                        u651.ShopSequence = Scramble.ShopSequence + 1
                        if v6.PurchaseLimit ~= nil then
                            u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                            v2 = table.clone(u651.ShopPurchases[EventId] or {})
                            v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                            u651.ShopPurchases[EventId] = v2
                        end
                        return u681, "Granted", Rewards_3
                    end
                    return false, "BalanceLimit"
                end
                return false, "MissingReward"
            end
            if type(a3.OfferId) == "string" and type(a3.PurchasePeriod) == "string" then
                v4 = #a3.PurchasePeriod
                if not (v4 > 64)
                    and u10.Integer(a3.PurchaseLimit, 1, 100)
                    and u10.Integer(Count, 0, u10.MAX_SAMPLES) then
                    if a3.PurchaseLimit < Count + a3.Quantity then
                        return false, "PurchaseLimit"
                    end
                    v2 = a3.Kind or "Egg"
                    if v2 == "Pet" then
                        if a4.Pets < (u10.Count(a1.Inventory)) + a3.Quantity then
                            return false, "PetInventoryFull"
                        end
                        if (u10.Count(a3.Rewards)) ~= a3.Quantity then
                            return false, "MissingReward"
                        end
                        v4 = table.clone(a1.Inventory)
                        v5 = table.clone(a1.Index)
                        for i, j in a3.Rewards do
                            if type(i) == "string" and i ~= "" and type(j) == "table" then
                                if v4[i] then
                                    return false, "DuplicateReward"
                                end
                                v4[i] = j
                                v5[j.Category] = true
                                continue
                            end
                            return false, "MissingReward"
                        end
                        Rewards_3 = a3.Rewards
                        u681.Inventory = v4
                        u681.Index = v5
                        v6 = a3
                        u651.Wallets = table.clone(Scramble.Wallets)
                        u651.Wallets[EventId] = v1 - v6.Price
                        u651.ShopSequence = Scramble.ShopSequence + 1
                        if v6.PurchaseLimit ~= nil then
                            u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                            v2 = table.clone(u651.ShopPurchases[EventId] or {})
                            v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                            u651.ShopPurchases[EventId] = v2
                        end
                        return u681, "Granted", Rewards_3
                    end
                    if v2 == "Egg" then
                        v4 = addEggs(a3.Rewards, a3.Quantity)
                        if v4 then
                            return false, v4
                        end
                        v6 = a3
                        u651.Wallets = table.clone(Scramble.Wallets)
                        u651.Wallets[EventId] = v1 - v6.Price
                        u651.ShopSequence = Scramble.ShopSequence + 1
                        if v6.PurchaseLimit ~= nil then
                            u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                            v2 = table.clone(u651.ShopPurchases[EventId] or {})
                            v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                            u651.ShopPurchases[EventId] = v2
                        end
                        return u681, "Granted", Rewards_3
                    end
                    if v2 == "MutationConsumable" then
                        v4 = Scramble.MutationConsumables or 0
                        if not u10.Integer(v4, 0, u10.MAX_SAMPLES - a3.Quantity) then
                            return false, "BalanceLimit"
                        end
                        u651.MutationConsumables = v4 + a3.Quantity
                        v6 = a3
                        u651.Wallets = table.clone(Scramble.Wallets)
                        u651.Wallets[EventId] = v1 - v6.Price
                        u651.ShopSequence = Scramble.ShopSequence + 1
                        if v6.PurchaseLimit ~= nil then
                            u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                            v2 = table.clone(u651.ShopPurchases[EventId] or {})
                            v2[v6.OfferId] = {Period = v6.PurchasePeriod, Count = Count + v6.Quantity}
                            u651.ShopPurchases[EventId] = v2
                        end
                        return u681, "Granted", Rewards_3
                    end
                    if v2 ~= "CashBooster" and v2 ~= "SpeedBoost" and v2 ~= "TreadmillBoost" then
                        return false, "MissingReward"
                    end
                    if a3.Quantity == 1
                        and u10.Integer(a3.DurationSeconds, 1, 86400)
                        and type(a3.Now) == "number"
                        and a3.Now == a3.Now
                        and not (a3.Now <= 0)
                        and not (4000000000 < a3.Now) then
                        EarningsBoostExpiresAt = if v2 ~= "CashBooster" then if v2 ~= "SpeedBoost" then a4.TreadmillRemaining(a1, a3.Now) else a1.BossMastery.SpeedBoostExpiresAt else a1.EarningsBoostExpiresAt
                        if type(EarningsBoostExpiresAt) == "number"
                            and EarningsBoostExpiresAt == EarningsBoostExpiresAt
                            and not (EarningsBoostExpiresAt < 0)
                            and not (4000000000 - a3.DurationSeconds < EarningsBoostExpiresAt) then
                            if v2 == "CashBooster" then
                                u681.EarningsBoostExpiresAt = (math.max(a3.Now, EarningsBoostExpiresAt)) + a3.DurationSeconds
                            elseif v2 ~= "SpeedBoost" then
                                u681.TemporarySpeedBoostRemainingSeconds = EarningsBoostExpiresAt + a3.DurationSeconds
                                u681.TemporarySpeedBoostActiveStartedAt = a3.Now
                            else
                                u681.BossMastery = table.clone(a1.BossMastery)
                                u681.BossMastery.SpeedBoostExpiresAt = (math.max(a3.Now, EarningsBoostExpiresAt)) + a3.DurationSeconds
                            end
                            v6 = a3
                            u651.Wallets = table.clone(Scramble.Wallets)
                            u651.Wallets[EventId] = v1 - v6.Price
                            u651.ShopSequence = Scramble.ShopSequence + 1
                            if v6.PurchaseLimit ~= nil then
                                u651.ShopPurchases = table.clone(Scramble.ShopPurchases or {})
                                v2 = table.clone(u651.ShopPurchases[EventId] or {})
                                v2[v6.OfferId] = {
                                    Period = v6.PurchasePeriod,
                                    Count = Count + v6.Quantity,
                                }
                                u651.ShopPurchases[EventId] = v2
                            end
                            return u681, "Granted", Rewards_3
                        end
                        return false, "BalanceLimit"
                    end
                    return false, "MissingReward"
                end
            end
            return false, "MissingReward"
        end
        return false, "MissingReward"
    end
    return false, "StalePurchase"
end

return table.freeze(u10)