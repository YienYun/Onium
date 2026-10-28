-- Script path: ReplicatedStorage.Shared.Util.ShrineFusionRules
-- Decompile time: 10.93 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FusionShrines = require(ReplicatedStorage.Shared.FusionShrines)
local u9 = {Tiers = FusionShrines.Tiers}
local u17 = table.freeze({
    ["Light 8"] = "ArchAngel",
    ["Dark 8"] = "World Burner",
    ["Light 7"] = "Pegasus",
    ["Dark 7"] = "Skeleton Horse",
})

local function matchesInput(a1, a2) -- Line: 16 -- upvalues: u17 (val) -- types: a1: string, a2: string
    local v1 = true
    if a1 ~= a2 then
        v1 = u17[a1] == a2
    end
    return v1
end

function u9.Same(a1, a2) -- Line: 20 -- upvalues: u9 (val)
    if type(a1) == "table" and type(a2) == "table" then
        for i, j in a1 do
            if not u9.Same(j, a2[i]) then
                return false
            end
        end
        for k in a2 do
            if a1[k] == nil then
                return false
            end
        end
        return true
    end
    return a1 == a2
end

function u9.Completed(a1, a2) -- Line: 37 -- types: a2: string
    return type(a1.ShrineFusion[a2]) == "table"
end

function u9.ResolveRecipes(a1, a2) -- Line: 41 -- upvalues: FusionShrines (val)
    local Id, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local v12 = {}
    local v13 = {}
    local v14 = {}
    local v15 = nil
    local v16 = nil
    for i, j in FusionShrines.Tiers, v15, v16 do
        v2 = FusionShrines.KindOfTier(j)
        v3 = a1[j]
        v4 = type(v3) == "table"
        v5 = {}
        v6 = table.clone(v2.Sides)
        table.insert(v6, "Fused")
        v7 = v6
        v8 = nil
        v9 = nil
        for k, n in v7, v8, v9 do
            v10 = if not v4 then nil else v3[n]
            v11 = if type(v10) ~= "string" then nil else v1[v10]
            if not v11 or v10 == "" or v5[v10] then
                v4 = false
            elseif not v2.RarityLocked or v11.Rarity._id == j then
                v5[v10] = true
            else
                v4 = false
            end
        end
        if not v4 then
            v7 = if not v2.RarityLocked then "Configure distinct, registered animals for every pad and the reward" else "Configure three distinct, registered animals with the correct rarity"
            v13[j] = v7
        else
            v12[j] = (table.clone(v3))
            Id = v2.Id
            v8 = v14[v2.Id] or {}
            v14[Id] = v8
            v8 = nil
            v9 = nil
            for m in v5, v8, v9 do
                v6 = v14[v2.Id][m]
                if v6 then
                    v13[j] = "Ambiguous recipe"
                    v13[v6] = "Ambiguous recipe"
                end
                v14[v2.Id][m] = j
            end
        end
    end
    for i5 in v13 do
        v12[i5] = nil
    end
    return v12, v13
end

function u9.EggCount(a1) -- Line: 87
    local v1 = 0
    for i in a1.EggInventory do
        v1 = v1 + 1
    end
    if type(a1.FusionEggReward) == "table" then
        v1 = v1 + 1
    end
    if a1.Rift and type(a1.Rift.PendingReward) == "table" then
        v1 = v1 + 1
    end
    return v1
end

function u9.CheckInput(a1, a2, a3, a4, a5, a6) -- Line: 102
    -- upvalues: u17 (val), u9 (val), FusionShrines (val)
    if a1 and type(a1.ShrineFusion) == "table" then
        local Category, v1, v2, v3, v4, v5, v6
        if not (if not a2 then nil else a1.Inventory[a2]) then
            return nil, "HOLD_PET", a6.Copy.Hold(a3, a4)
        end
        local v7 = nil
        local v8 = nil
        local Tiers = a6.Tiers
        local v9 = nil
        local v10 = nil
        local v11, v12, v13, v14, v15, v16 = a6, a3, a4, a1, a2, a5
        for i, j in Tiers, v9, v10 do
            v1 = v13[j]
            if v1 then
                v2 = nil
                v3 = nil
                for k, n in v11.Sides, v2, v3 do
                    Category = v6.Category
                    v5 = v1[n]
                    v4 = true
                    if Category ~= v5 then
                        v4 = u17[Category] == v5
                    end
                    if v4 then
                        v7 = j
                        v8 = n
                    end
                end
            end
        end
        if not v7 then
            return nil, "WRONG_ANIMAL", v11.Copy.Hold(v12, v13)
        end
        if u9.Completed(v14, v7) then
            return nil, "COMPLETED", v11.Copy.Done(v7)
        end
        if v8 ~= v12 then
            return nil, "WRONG_PAD", v11.Copy.WrongPad(v8)
        end
        if v6.IsFavorite then
            return nil, "FAVORITE", "Unfavorite this pet first. It will be used up."
        end
        if not v6.InFuse then
            local find = table.find
            local FusionSlots = v14.FusionSlots or {}
            if not find(FusionSlots, v15) then
                local find_2 = table.find
                local VIPFusionSlots = v14.VIPFusionSlots or {}
                if not find_2(VIPFusionSlots, v15) then
                    local find_3 = table.find
                    local PrivateFusionSlots = v14.PrivateFusionSlots or {}
                    if not find_3(PrivateFusionSlots, v15) then
                        local find_4 = table.find
                        local EquippedAssets = v14.EquippedAssets or {}
                        if find_4(EquippedAssets, v15) then
                            return nil, "IN_PEN", "Remove this pet from your pen, then hold it."
                        end
                        if not v6.SpecialLuckyBlockColumn and not v6.PendingEggName then
                            if v6.IsStolenDNA and not v16.AllowStolenDNA then
                                return nil, "STOLEN_DNA", "Use a pet that isn't Stolen DNA."
                            end
                            if type(v6.Scale) == "number"
                                and v6.Scale == v6.Scale
                                and not (v6.Scale <= 0)
                                and v6.Scale ~= (1 / 0) then
                                if v16.EggLimit <= (u9.EggCount(v14)) then
                                    return nil, "EGG_FULL", "Your egg inventory is full. Make room first."
                                end
                                return v7, "READY", v11.Copy.Ready(FusionShrines.Others(v11, v12), v13[v7])
                            end
                            return nil, "INVALID_PET", "Pet error. Rejoin and try again."
                        end
                        return nil, "RESERVED", "This pet is busy. Use another pet."
                    end
                end
            end
        end
        return nil, "RESERVED", "Take this pet out of the other fuse machine."
    end
    return nil, "DATA_LOADING", "Loading your data. Please wait."
end

function u9.BuildPatches(a1, a2, a3) -- Line: 173 -- upvalues: u9 (val)
    local Sides = a3.Kind.Sides
    local Placement = a3.Kind.Placement
    local Players = if not Placement then #Sides else Placement.Players
    local v1 = {}
    for i, j in a2 do
        v1[j] = true
    end
    local v2 = 0
    local v3 = nil
    local v4 = nil
    for k in v1, v3, v4 do
        v2 = v2 + 1
    end
    if #a2 == Players and v2 == Players then
        local Pets, v5, v6, v7, v8, v9, v10, v11, v12
        local u182 = {}
        local v13 = {}
        v3 = nil
        v4 = nil
        local v14, v15 = a2, a1
        for n, m in a2, v3, v4 do
            v1 = a3.Inputs[n]
            v5 = v15[m]
            Pets = v1.Pets or {[Sides[n]] = v1}
            v13[n] = {}
            v7 = nil
            v8 = nil
            for i5, i6 in Pets, v7, v8 do
                v9, v10, v11 = u9.CheckInput(v5, i6.Uid, i5, a3.Recipes, a3.Options, a3.Kind)
                if not v9 then
                    return false, v10, v11
                end
                if v9 ~= a3.Tier then
                    return false, "MISMATCH", a3.Kind.Copy.Mismatch
                end
                if not u9.Same(v5.Inventory[i6.Uid], i6.Snapshot) then
                    return false, "PET_CHANGED", "Pet changed. Hold it and try again."
                end
                v11 = v5.Inventory[i6.Uid]
                v12 = false
                if v11 ~= nil then
                    v12 = true
                    if v11.CreatorTemporary ~= true then
                        v12 = v5.CreatorProfile ~= nil
                    end
                end
                table.insert(u182, v12)
                v13[n][i6.Uid] = true
            end
            v6 = a3.Grants[n]
            if not v5.EggInventory[v6.Uid] and v6.Record.AssetCategory == a3.Recipes[a3.Tier].Fused then
                continue
            end
            return false, "INVALID_REWARD", "Reward check failed."
        end
        if table.find(u182, not u182[1]) then
            return false, "TEMPORARY_MISMATCH", "Both pets must be temporary creator pets, or neither."
        end
        local v16 = {}
        v3 = nil
        v4 = nil
        for i7, i8 in v14, v3, v4 do
            local u72 = a3.Grants[i7]
            if u182[1] then
                u72.Record.CreatorTemporary = true
            end
            v6 = {
                Remove = v13[i7],
                MutateStore = function(a1) -- Line: 242 -- upvalues: u72 (val), u182 (val), a3 (val)
                    local v1 = table.clone(a1.EggInventory)
                    v1[u72.Uid] = u72.Record
                    a1.EggInventory = v1
                    if u182[1] and a3.MarkTemporary then
                        a3.MarkTemporary(a1)
                    end
                    v1 = table.clone(a1.ShrineFusion)
                    v1[a3.Tier] = {
                        TransactionId = a3.Id,
                        EggUid = u72.Uid,
                        CompletedAt = a3.CompletedAt,
                    }
                    a1.ShrineFusion = v1
                end,
            }
            v16[i8] = v6
        end
        return v16
    end
    return false, "TWO_PLAYERS", "One player on each pad."
end

return table.freeze(u9)