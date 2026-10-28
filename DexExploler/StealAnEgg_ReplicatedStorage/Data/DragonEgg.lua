-- Script path: ReplicatedStorage.Data.DragonEgg
-- Decompile time: 2.91 ms

local u0 = {
    EggDisplayName = "Dragon Egg",
    RewardEggDisplayName = "Dragon's Egg",
    MaxCountedReturns = 10,
    BaseAssetScale = 0.3,
    AssetScalePerReturn = 0.42,
    NestBaseScale = 0.3,
    NestScalePerReturn = 0.42,
    DropTable = {
        {"Baby Aurora Dragon", 85, -8.5},
        {"Shadow Dragon", 13.5, 1.25},
        {"Ember Dragon", 1, 6.5},
        {"Void Dragon", 0.5, 0.75},
    },
    RestoreDropTable = {{"Baby Aurora Dragon", 45}, {"Shadow Dragon", 35}, {"Ember Dragon", 15}, {"Void Dragon", 5}},
    RewardCategory = "ScorchedDragon",
    CarryCategory = "Baby Aurora Dragon",
}

function u0.GetCountedReturns(a1) -- Line: 37 -- upvalues: u0 (ref) -- types: a1: number
    return (math.clamp(math.floor(a1), 0, u0.MaxCountedReturns))
end

function u0.GetEntryWeight(a1, a2) -- Line: 41 -- upvalues: u0 (ref) -- types: a1: table, a2: number
    return (math.max(a1[2] + a1[3] * u0.GetCountedReturns(a2), 0))
end

function u0.GetTotalWeight(a1) -- Line: 48 -- upvalues: u0 (ref) -- types: a1: number
    local v1 = 0
    for i, j in u0.DropTable do
        v1 = v1 + u0.GetEntryWeight(j, a1)
    end
    return v1
end

function u0.RollRestore() -- Line: 63 -- upvalues: u0 (ref)
    local v1 = Random.new()
    local v2 = 0
    for i, j in u0.RestoreDropTable do
        v2 = v2 + j[2]
    end
    local v3 = v1:NextNumber() * v2
    v2 = 0
    for k, n in u0.DropTable do
        v2 = v2 + n[2]
        if v3 <= v2 then
            return n[1]
        end
    end
    error((("[%*] Roll out of bounds exception"):format(script.Name)))
end

function u0.Roll(a1, a2) -- Line: 85 -- upvalues: u0 (ref) -- types: a1: number, a2: userdata?
    assert(#u0.DropTable > 0, "DragonEgg.DropTable is empty")
    local v1 = a2 or Random.new()
    local v2 = u0.GetTotalWeight(a1)
    if v2 <= 0 then
        return u0.DropTable[1][1]
    end
    local v3 = v1:NextNumber() * v2
    v2 = 0
    for i, j in u0.DropTable do
        v2 = v2 + u0.GetEntryWeight(j, a1)
        if v3 <= v2 then
            return j[1]
        end
    end
    return u0.DropTable[#u0.DropTable][1]
end

function u0.GetAssetScale(a1) -- Line: 109 -- upvalues: u0 (ref) -- types: a1: number
    return u0.BaseAssetScale + u0.AssetScalePerReturn * u0.GetCountedReturns(a1)
end

function u0.GetNestVisualScale(a1) -- Line: 114 -- upvalues: u0 (ref) -- types: a1: number
    return u0.NestBaseScale + u0.NestScalePerReturn * u0.GetCountedReturns(a1)
end

function u0.IsEventCategory(a1) -- Line: 119 -- upvalues: u0 (ref) -- types: a1: string?
    if a1 == nil then
        return false
    end
    if a1 == u0.RewardCategory then
        return true
    end
    for i, j in u0.DropTable do
        if j[1] == a1 then
            return true
        end
    end
    return false
end

u0 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.DragonEgg", u0, {
    MaxCountedReturns = true,
    BaseAssetScale = true,
    AssetScalePerReturn = true,
    DropTable = true,
    RestoreDropTable = true,
}, false, function(a1) -- Line: 148
    local v1 = false
    if a1.MaxCountedReturns % 1 == 0 then
        v1 = 0 < a1.BaseAssetScale
    end
    assert(v1)
end))
return u0