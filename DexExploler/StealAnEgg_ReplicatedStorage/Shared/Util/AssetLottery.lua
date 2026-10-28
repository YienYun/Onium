-- Script path: ReplicatedStorage.Shared.Util.AssetLottery
-- Decompile time: 15.95 ms

local Lottery = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Lottery
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Assets = require(ReplicatedStorage.Data.Assets)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local DrawWeighted = require(ReplicatedStorage.Shared.Utils.Numeric).DrawWeighted
local RollWeighted = require(ReplicatedStorage.Shared.Utils.Numeric).RollWeighted
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local AssetRollScaleWeights = require(script.Parent.AssetRollScaleWeights)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local v2 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1 / 0)))
local NO_MUTATION = Mutations.NO_MUTATION
local u86 = Random.new()
local u88 = Random.new()
local u91 = t.strict(v1)
local u95 = t.strict(v2)
local u99 = t.strict(t.number)
local u102 = t.strict(t.table)
local u103 = {}
local u109 = Log.new():LimitUnderLevel("Warning")
local u110 = {}
local u111 = {}
local u112 = {}
local u113 = ""

local function refreshRollTables() -- Line: 54
    -- upvalues: u110 (val), AssetRollScaleWeights (val), u111 (val), u113 (ref), Assets (val), Rarity (val), u112 (ref)
    -- upvalues: Mutations (val)
    local DropWeight
    table.clear(u110)
    for i, v in ipairs(AssetRollScaleWeights) do
        table.insert(u110, {{v.low, v.high}, v.weight})
    end
    table.clear(u111)
    u113 = ""
    for k, i2 in pairs(Assets.Directory) do
        if u113 == "" then
            u113 = k
        end
        DropWeight = i2.DropWeight
        if DropWeight > 0 and not i2.DontRoll and i2.Rarity ~= Rarity.Rarities.Eternal then
            table.insert(u111, {k, DropWeight})
        end
    end
    assert(#u111 > 0, "Asset catalog yielded nothing rollable")
    Mutations.RollTable()
end

refreshRollTables()
;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 86 -- upvalues: refreshRollTables (val)
    task.defer(refreshRollTables)
end)
local u129 = Mutations.All()

local function shiftedTowardsFlat(a1, a2) -- Line: 94
    -- upvalues: TableUtil (val), Lottery (val), u109 (val)
    local v1, v2, v3
    if a2 <= 0 then
        return TableUtil.Copy(a1, true)
    end
    local v4 = a2 / 100
    local v5 = v4 / (v4 + 1) * Lottery.SHIFT_DAMPING
    v4 = (1 / 0)
    local v6 = 0
    for i, v in ipairs(a1) do
        v1 = v[2]
        if v1 < v4 then
            v4 = v1
        end
        v6 = v6 + v1
    end
    local v7 = {}
    local v8 = 0
    for i2, i3 in ipairs(a1) do
        v2 = i3[2]
        v3 = v2 - (v2 - v4) * v5
        table.insert(v7, {i3[1], v3})
        v8 = v8 + v3
    end
    v4 = if v8 == 0 then 1 else v6 / v8
    for i4, j in ipairs(v7) do
        j[2] = j[2] * v4
    end
    ;(u109:AtTrace()):Log((("weight shift luck=%* pull=%* norm=%*"):format(v9, v5, v4)))
    return v7
end

local function amplifyMutations(a1, a2) -- Line: 138 -- upvalues: NO_MUTATION (val) -- types: a1: table, a2: number
    local v1, v2
    local v3 = {}
    for i, v in ipairs(a1) do
        v1 = v[1]
        v2 = v[2]
        table.insert(v3, {v1, if v1 ~= NO_MUTATION then v2 * a2 else v2})
    end
    return v3
end

local function entriesAtRarity(a1, a2) -- Line: 152 -- upvalues: Assets (val) -- types: a1: string, a2: string
    local DropWeight
    local v1 = Assets.ByRarity[a2]
    local v2 = ("%*: no assets indexed under rarity %*"):format(a1, a2)
    assert(v1 ~= nil, v2)
    local v3 = {}
    for k, v in pairs(v1) do
        DropWeight = v.DropWeight
        if typeof(DropWeight) == "number" and DropWeight > 0 then
            table.insert(v3, {k, DropWeight})
        end
    end
    assert(#v3 > 0, (("%*: rarity %* has no asset with a drop weight"):format(a1, a2)))
    return v3
end

local function usableWeight(a1) -- Line: 174
    if typeof(a1) ~= "number" then
        return false
    end
    local v1 = false
    if a1 > 0 then
        v1 = false
        if a1 == a1 then
            v1 = a1 ~= (1 / 0)
        end
    end
    return v1
end

local function tokenOf(a1) -- Line: 182 -- types: a1: table
    if typeof(a1[1]) == "string" then
        return a1[1]
    end
    return ""
end

local function rarestFirst(a1) -- Line: 188 -- types: a1: table
    local v1 = {}
    for i, v in ipairs(a1) do
        table.insert(v1, v)
    end
    table.sort(v1, function(a1, a2) -- Line: 195
        local v1
        local v2 = a1[2]
        if typeof(v2) == "number" then
            v1 = false
            if v2 > 0 then
                v1 = false
                if v2 == v2 then
                    v1 = v2 ~= (1 / 0)
                end
            end
        else
            v1 = false
        end
        local v3 = a2[2]
        if typeof(v3) == "number" then
            v2 = false
            if v3 > 0 then
                v2 = false
                if v3 == v3 then
                    v2 = v3 ~= (1 / 0)
                end
            end
        else
            v2 = false
        end
        if v1 ~= v2 then
            return v1
        end
        if not v1 then
            return (if typeof(a1[1]) ~= "string" then "" else a1[1]) < (if typeof(a2[1]) ~= "string" then "" else a2[1])
        end
        v2 = a1[2]
        v1 = a2[2]
        if v2 == v1 then
            return (if typeof(a1[1]) ~= "string" then "" else a1[1]) < (if typeof(a2[1]) ~= "string" then "" else a2[1])
        end
        return v2 < v1
    end)
    return v1
end

local function usableWeightSum(a1) -- Line: 220 -- types: a1: table
    local v1, v2
    local v3 = 0
    for i, v in ipairs(a1) do
        v2 = v[2]
        if typeof(v2) == "number" then
            v1 = false
            if v2 > 0 then
                v1 = false
                if v2 == v2 then
                    v1 = v2 ~= (1 / 0)
                end
            end
        else
            v1 = false
        end
        if v1 then
            v3 = v3 + v[2]
        end
    end
    return v3
end

local function cumulativeChance(a1, a2) -- Line: 232 -- upvalues: u91 (val), u95 (val) -- types: a1: number, a2: number
    u91(a1)
    u95(a2)
    if a2 <= 1 then
        return a1
    end
    return 1 - (1 - a1) ^ a2
end

local function drawLuckyToken(a1, a2, a3) -- Line: 243
    -- upvalues: u102 (val), u99 (val), rarestFirst (val), usableWeightSum (val)
    local v1, v2
    u102(a1)
    u99(a2)
    local v3 = true
    if a3 ~= nil then
        v3 = typeof(a3) == "Random"
    end
    assert(v3, "A token draw needs a Random or nil")
    local v4 = rarestFirst(a1)
    v3 = usableWeightSum(v4)
    if v3 <= 0 then
        return nil
    end
    local v5 = (1 - (1 - (a3 or Random.new()):NextNumber()) ^ (1 / math.max(a2, 1))) * v3
    local v6 = nil
    for i, v in ipairs(v4) do
        v2 = v[1]
        if typeof(v2) == "string" then
            v2 = v[2]
            if typeof(v2) == "number" then
                v1 = false
                if v2 > 0 then
                    v1 = false
                    if v2 == v2 then
                        v1 = v2 ~= (1 / 0)
                    end
                end
            else
                v1 = false
            end
            if v1 then
                v3 = v[1]
                v6 = v3
                v5 = v5 - v[2]
                if v5 <= 0 then
                    return v3
                end
            end
        end
    end
    return v6
end

local function bandCeiling(a1) -- Line: 282 -- types: a1: table
    local v1
    local v2 = a1[1]
    if typeof(if typeof(v2) ~= "table" then v2 else v2[#v2]) ~= "number" then
        return nil
    end
    return v1
end

function u103.RollCountFor(a1, a2) -- Line: 294 -- types: a1: number?, a2: number?
    return (math.max(
        (math.max(1 + (if typeof(a1) ~= "number" then 0 else a1) / 100, 0)) + ((if typeof(a2) ~= "number" then 1 else math.max(a2, 1)) - 1),
        1
    ))
end

function u103.TokenChances(a1, a2) -- Line: 304
    -- upvalues: u102 (val), u99 (val), rarestFirst (val), usableWeightSum (val), u91 (val), u95 (val)
    local v1, v2, v3, v4, v5
    u102(a1)
    u99(a2)
    local v6 = rarestFirst(a1)
    local v7 = usableWeightSum(v6)
    if v7 <= 0 then
        return {}
    end
    local v8 = math.max(a2, 1)
    local v9 = {}
    local v10 = 0
    for i, v in ipairs(v6) do
        v2 = v[1]
        if typeof(v2) == "string" then
            v2 = v[2]
            if typeof(v2) == "number" then
                v1 = false
                if v2 > 0 then
                    v1 = false
                    if v2 == v2 then
                        v1 = v2 ~= (1 / 0)
                    end
                end
            else
                v1 = false
            end
            if v1 then
                v1 = v[1]
                v2 = v10 / v7
                v10 = v10 + v[2]
                v5 = v10 / v7
                u91(v5)
                u95(v8)
                v4 = if not (v8 <= 1) then 1 - (1 - v5) ^ v8 else v5
                u91(v2)
                u95(v8)
                v3 = v4 - (if not (v8 <= 1) then 1 - (1 - v2) ^ v8 else v2)
                if v3 > 0 then
                    v9[v1] = (v9[v1] or 0) + v3
                end
            end
        end
    end
    return v9
end

function u103.DrawCategory(a1, a2, a3) -- Line: 339
    -- upvalues: u103 (val), drawLuckyToken (val), u111 (val), u88 (val), u109 (val), u113 (ref)
    local v1 = a3 or u88
    local v2 = drawLuckyToken(u111, u103.RollCountFor(a2 or 0), v1)
    if typeof(v2) == "string" and v2 ~= "" then
        return v2
    end
    ;(u109:AtError()):Log((("category draw came back empty, substituting %*"):format(u113)))
    return u113
end

function u103.DrawCategoryForRarity(a1, a2, a3) -- Line: 352
    -- upvalues: RollWeighted (val), entriesAtRarity (val)
    local v1 = RollWeighted(entriesAtRarity(a1, a2), a3)
    local v2 = false
    if typeof(v1) == "string" then
        v2 = v1 ~= ""
    end
    assert(v2, (("%*: rarity %* produced no asset name"):format(a1, a2)))
    return v1
end

function u103.DrawCategoryFromRarityTable(a1, a2, a3) -- Line: 367
    -- upvalues: RollWeighted (val), u103 (val)
    local v1 = RollWeighted(a2, a3)
    local v2 = false
    if typeof(v1) == "string" then
        v2 = v1 ~= ""
    end
    assert(v2, (("%*: rarity table produced no rarity token"):format(a1)))
    return u103.DrawCategoryForRarity(a1, v1, a3)
end

function u103.DrawCategoryFromTable(a1, a2, a3, a4) -- Line: 382
    -- upvalues: u91 (val), drawLuckyToken (val), RollWeighted (val), Assets (val)
    u91(a3)
    assert(a3 >= 1, "A category draw needs at least one roll")
    local v1 = if not (a3 > 1) then RollWeighted(a2, a4) else drawLuckyToken(a2, a3, a4)
    local v2 = false
    if typeof(v1) == "string" then
        v2 = v1 ~= ""
    end
    assert(v2, (("%*: drop table produced no name"):format(a1)))
    assert(Assets.AssetNameExists(v1), (("%*: drop table named %*, which is not in the catalog"):format(a1, v1)))
    return v1
end

function u103.DrawMutations(a1, a2, a3, a4) -- Line: 405
    -- upvalues: u86 (val), shiftedTowardsFlat (val), u112 (ref), amplifyMutations (val), u109 (val), Lottery (val)
    -- upvalues: RollWeighted (val), NO_MUTATION (val), AdminBoosts (val), u129 (val)
    local v1 = a3 or u86
    local v2 = shiftedTowardsFlat(u112, a2 or 0)
    if a4 ~= nil and a4 > 1 then
        v2 = amplifyMutations(v2, a4)
    end
    ;(u109:AtInfo()):Log((("mutation draw, follow-up odds %*"):format(Lottery.SECOND_MUTATION_ODDS)))
    local v3 = {}
    local v4 = RollWeighted(v2, v1)
    if typeof(v4) == "string" and v4 ~= NO_MUTATION then
        table.insert(v3, v4)
    end
    v4 = Lottery.SECOND_MUTATION_ODDS * AdminBoosts.ReadMultiplier(AdminBoosts.VIDEO_LUCK)
    if #v3 > 0 and v1:NextNumber() < v4 then
        local v5 = RollWeighted(v2, v1)
        if typeof(v5) == "string" and v5 ~= NO_MUTATION and not table.find(v3, v5) then
            table.insert(v3, v5)
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 441 -- upvalues: u129 (upval) -- types: a1: string, a2: string
        return u129[a1].RollWeight < u129[a2].RollWeight
    end)
    return v3
end

function u103.DrawScale(a1, a2, a3, a4) -- Line: 451
    -- upvalues: shiftedTowardsFlat (val), u110 (val), Constants (val), u109 (val), AssetRollScaleWeights (val)
    -- upvalues: u86 (val), Lottery (val), DrawWeighted (val)
    local v1
    local v2 = shiftedTowardsFlat(u110, a2 or 0)
    local v3 = v2
    local v4 = {}
    if a3 and a4 then
        local v5, v6, v7, v8
        local v9 = {}
        v1 = {}
        for i, v in ipairs(v2) do
            v7 = v[1]
            v8 = if typeof(v7) ~= "table" then v7 else v7[#v7]
            v6 = if typeof(v8) == "number" then v8 else nil
            if v6 == nil then
                v7 = ("scale band %* has no numeric ceiling"):format(i)
                if not Constants.IS_STUDIO then
                    u109:AtWarning():Log(v7)
                else
                    error(v7)
                end
            elseif a3 <= v6 * a4 then
                table.insert(v9, v)
                table.insert(v1, i)
            end
        end
        if #v9 == 0 then
            return a3 / a4, #AssetRollScaleWeights
        end
        for i2 = v5, if (if not (u86:NextInteger(1, Lottery.UPGRADE_BAND_ODDS) == 1) then 1 else if not (#v9 > 1) then 1 else 2) ~= 1 then #v9 else 1 do
            table.insert({}, v9[i2])
            table.insert(v4, v1[i2])
        end
    end
    v2 = DrawWeighted(v3)
    local Value = if not v2 then nil else v2.Value
    local Index = if not v2 then 0 else v2.Index
    if not Value then
        u109:AtError():Log("scale draw came back empty, substituting 1x")
        return 1, 1
    end
    v2 = Value
    if typeof(v2) == "table" then
        if not a3 or not a4 then
            v1 = v2[1]
            local v10 = v2[2]
            v2 = if v10 ~= nil then u86:NextNumber(v1, v10) else v1
        else
            v3 = v2[#v2]
            v2 = if not (v3 * a4 <= a3) then u86:NextNumber(a3 / a4, v3) else a3 / a4
        end
    end
    v1 = v4 and v4[Index] or Index
    return if typeof(v2) ~= "number" then 1 else v2, v1
end

return u103