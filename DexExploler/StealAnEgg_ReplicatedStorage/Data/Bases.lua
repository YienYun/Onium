-- Script path: ReplicatedStorage.Data.Bases
-- Decompile time: 7.68 ms

local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local u540 = {}
local v2 = {
    1000,
    1000000,
    75000000,
    500000000,
    1000000000,
    50000000000,
    500000000000,
    1000000000000,
    25000000000000,
    100000000000000,
    500000000000000,
    5e+15,
}

local function getBaseModelIfServer(a1) -- Line: 43
    -- upvalues: t (val), Constants (val), ServerStorage (val)
    t.strict(t.string)(a1)
    if Constants.IS_SERVER then
        return ServerStorage.Assets.Models.Bases.Main[a1]
    end
    return nil
end

local v3 = {}
local v4 = {MaxAssets = 7, Cost = 0}
t.strict(t.string)("1")
v4.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["1"]
v3[0] = v4
local v5 = {MaxAssets = 7}
t.strict(t.string)("1")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["1"]
v5.Cost = v2[1]
v3[1] = v5
v5 = {MaxAssets = 9}
t.strict(t.string)("2")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["2"]
v5.Cost = v2[2]
v3[2] = v5
v5 = {MaxAssets = 10}
t.strict(t.string)("3")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["3"]
v5.Cost = v2[3]
v3[3] = v5
v5 = {MaxAssets = 11}
t.strict(t.string)("4")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["4"]
v5.Cost = v2[4]
v3[4] = v5
v5 = {MaxAssets = 12}
t.strict(t.string)("5")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["5"]
v5.Cost = v2[5]
v3[5] = v5
v5 = {MaxAssets = 13}
t.strict(t.string)("6")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["6"]
v5.Cost = v2[6]
v3[6] = v5
v5 = {MaxAssets = 14}
t.strict(t.string)("7")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["7"]
v5.Cost = v2[7]
v3[7] = v5
v5 = {MaxAssets = 15}
t.strict(t.string)("8")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["8"]
v5.Cost = v2[8]
v3[8] = v5
v5 = {MaxAssets = 16}
t.strict(t.string)("9")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["9"]
v5.Cost = v2[9]
v3[9] = v5
v5 = {MaxAssets = 17}
t.strict(t.string)("10")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["10"]
v5.Cost = v2[10]
v3[10] = v5
v5 = {MaxAssets = 18}
t.strict(t.string)("11")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["11"]
v5.Cost = v2[11]
v3[11] = v5
v5 = {MaxAssets = 19}
t.strict(t.string)("12")
v5.Model = if not Constants.IS_SERVER then nil else ServerStorage.Assets.Models.Bases.Main["12"]
v5.Cost = v2[12]
v3[12] = v5
u540.BASES = v3
u540.SKINS = {}
u540.MIN_ASSET_EQUIP_CAPACITY = u540.BASES[0].MaxAssets
u540.MAX_ASSET_EQUIP_CAPACITY = u540.BASES[#u540.BASES].MaxAssets

function u540.GetMaxBaseLevel() -- Line: 127 -- upvalues: u540 (val)
    local v1 = 0
    for k in pairs(u540.BASES) do
        if v1 < k then
            v1 = k
        end
    end
    return v1
end

function u540.GetBaseConfigFor(a1, a2) -- Line: 139 -- upvalues: t (val), u540 (val) -- types: a1: number, a2: string?
    t.strict(t.number)(a1)
    t.strict(t.optional(t.string))(a2)
    local v1 = math.max(0, (math.floor(a1)))
    local v2 = nil
    local v3 = a2
    for k in pairs(u540.BASES) do
        if k <= v1 then
            if not v2 or v2 < k then
                v2 = k
            end
        end
    end
    if v2 and v3 then
        return u540.BASES[v2], u540.SKINS[v3]
    end
    if v2 then
        return u540.BASES[v2]
    end
    return nil
end

function u540.GetAssetEquipCapacity(a1) -- Line: 166 -- upvalues: u540 (val) -- types: a1: number?
    local v1 = u540.GetBaseConfigFor(a1 or 0)
    return v1 and v1.MaxAssets or u540.MIN_ASSET_EQUIP_CAPACITY
end

if Constants.IS_STUDIO then
    local Model, PrimaryPart_2, ToUpdate
    v4 = #v2
    assert(#u540.BASES <= v4, "Not enough costs for the number of bases")
    for k, v in pairs(u540.BASES) do
        v1 = true
        if v.Cost ~= v2[k] then
            v1 = false
            if k == 0 then
                v1 = v.Cost == 0
            end
        end
        assert(v1, (("Cost for base index %* does not match expected cost from COSTS table"):format(k)))
        if Constants.IS_SERVER then
            Model = v.Model
            v1 = false
            if typeof(Model) == "Instance" then
                v1 = Model:IsA("Model")
            end
            assert(v1, (("Model for base index %* is not a valid Model instance"):format(k)))
            assert(
                Model.PrimaryPart and Model.PrimaryPart.Name == "CenterPoint",
                (("Model for base index %* must have a PrimaryPart named \"CenterPoint\""):format(k))
            )
            ToUpdate = Model:FindFirstChild("ToUpdate")
            PrimaryPart_2 = ToUpdate
            if PrimaryPart_2 then
                PrimaryPart_2 = ToUpdate:IsA("Model")
                if PrimaryPart_2 then
                    PrimaryPart_2 = ToUpdate.PrimaryPart
                    if PrimaryPart_2 then
                        PrimaryPart_2 = false
                        if ToUpdate.PrimaryPart.Name == "CenterPoint" then
                            PrimaryPart_2 = ToUpdate:FindFirstChild("PetArea")
                        end
                    end
                end
            end
            assert(
                PrimaryPart_2,
                (("Model for base index %* must have a child Model named \"ToUpdate\" with a PrimaryPart named \"CenterPoint\""):format(k))
            )
        end
        v1 = false
        if typeof(v.MaxAssets) == "number" then
            v1 = v.MaxAssets == u540.GetAssetEquipCapacity(k)
        end
        assert(v1, (("MaxAssets for base index %* must match asset equip capacity"):format(k)))
    end
end
if Constants.IS_STUDIO and Constants.IS_SERVER then
    for k2, i in pairs(u540.SKINS) do
        v1 = false
        if typeof(i.FirstFloor) == "Instance" then
            v1 = i.FirstFloor:IsA("Model")
        end
        assert(v1, (("Model for base skin index %* is not a valid Model instance"):format(k2)))
    end
end
local u537 = {}
for j, k3 in u540.BASES do
    u537[j] = k3.MaxAssets
end
u540.BASES = (require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.Bases", u540.BASES, {Cost = true, MaxAssets = true}, true, function(a1) -- Line: 232 -- upvalues: u537 (val)
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = false
        if j.MaxAssets % 1 == 0 then
            v1 = false
            if 1 <= j.MaxAssets then
                v1 = j.MaxAssets <= u537[i]
            end
        end
        assert(v1)
    end
end)
u540.MIN_ASSET_EQUIP_CAPACITY = u540.BASES[0].MaxAssets
u540.MAX_ASSET_EQUIP_CAPACITY = u540.BASES[u540.GetMaxBaseLevel()].MaxAssets
require(ReplicatedStorage.Shared.Flags.BalanceConfig).Changed:Connect(function() -- Line: 243 -- upvalues: u540 (val)
    u540.MIN_ASSET_EQUIP_CAPACITY = u540.BASES[0].MaxAssets
    u540.MAX_ASSET_EQUIP_CAPACITY = u540.BASES[u540.GetMaxBaseLevel()].MaxAssets
end)
return u540