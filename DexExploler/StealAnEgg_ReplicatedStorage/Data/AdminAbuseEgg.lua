-- Script path: ReplicatedStorage.Data.AdminAbuseEgg
-- Decompile time: 1.51 ms

local u0 = {EggDisplayName = "Demonic Egg", DropTable = {{"Demon Imp", 42}}}

function u0.IsEventCategory(a1) -- Line: 12 -- upvalues: u0 (ref) -- types: a1: string?
    if a1 == nil then
        return false
    end
    for i, j in u0.DropTable do
        if j[1] == a1 then
            return true
        end
    end
    return false
end

function u0.GetTotalWeight() -- Line: 26 -- upvalues: u0 (ref)
    local v1 = 0
    for i, j in u0.DropTable do
        v1 = v1 + j[2]
    end
    return v1
end

function u0.Roll(a1) -- Line: 36 -- upvalues: u0 (ref) -- types: a1: userdata?
    local v1 = a1 or Random.new()
    local v2 = u0.GetTotalWeight()
    if v2 <= 0 then
        return u0.DropTable[1][1]
    end
    local v3 = v1:NextNumber() * v2
    v2 = 0
    for i, j in u0.DropTable do
        v2 = v2 + j[2]
        if v3 <= v2 then
            return j[1]
        end
    end
    return u0.DropTable[#u0.DropTable][1]
end

u0 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.AdminAbuseEgg", u0, {DropTable = true}, false, function(a1) -- Line: 63
    local v1 = 0
    for i, j in a1.DropTable do
        v1 = v1 + j[2]
    end
    assert(v1 > 0)
end))
return u0