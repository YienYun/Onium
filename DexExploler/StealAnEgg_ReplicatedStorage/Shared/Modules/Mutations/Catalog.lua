-- Script path: ReplicatedStorage.Shared.Modules.Mutations.Catalog
-- Decompile time: 3.90 ms

require(script.Parent.Types)
local Visuals = require(script.Parent.Visuals)
local ScrambledVisuals = require(script.Parent.ScrambledVisuals)
local v1 = {
    Silver = {
        Id = "Silver",
        Label = "Silver",
        EarningsScalar = 1.2,
        RollWeight = 6,
        IconAssetId = 108639493197858,
        Tint = Color3.fromRGB(192, 192, 192),
        Apply = function(a1, a2, a3) -- Line: 43 -- upvalues: Visuals (val)
            Visuals.ApplySilver(a2, a3)
        end,
        Clear = function(a1, a2, a3) -- Line: 46 -- upvalues: Visuals (val)
            Visuals.ClearSilver(a2, a3)
        end,
    },
    Golden = {
        Id = "Golden",
        Label = "Golden",
        EarningsScalar = 2.5,
        RollWeight = 4,
        IconAssetId = 134818382291054,
        Tint = Color3.fromRGB(251, 255, 0),
        Apply = function(a1, a2, a3) -- Line: 58 -- upvalues: Visuals (val)
            Visuals.ApplyGolden(a2, a3)
        end,
        Clear = function(a1, a2, a3) -- Line: 61 -- upvalues: Visuals (val)
            Visuals.ClearGolden(a2, a3)
        end,
    },
    Rainbow = {
        Id = "Rainbow",
        Label = "Rainbow",
        EarningsScalar = 3.5,
        RollWeight = 1,
        IconAssetId = 85288683002868,
        Tint = Color3.fromRGB(255, 0, 255),
        Apply = function(a1, a2, a3) -- Line: 73 -- upvalues: Visuals (val)
            Visuals.ApplyRainbow(a2, a3)
        end,
        Clear = function(a1, a2, a3) -- Line: 76 -- upvalues: Visuals (val)
            Visuals.ClearRainbow(a2, a3)
        end,
    },
    Monstrous = {
        Id = "Monstrous",
        Label = "Parasite",
        EarningsScalar = 3,
        RollWeight = 0,
        EggModelName = "Monstrous Egg",
        EggDisplayName = "Parasite Egg",
        EggIcon = "rbxassetid://121553987798547",
        Tint = Color3.fromRGB(65, 21, 138),
        Apply = function(a1, a2, a3) -- Line: 91 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(a2, a3, "Monstrous", "Cleanup_Monstrous", a1.Tint, 0.5)
        end,
        Clear = function(a1, a2, a3) -- Line: 101 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_Monstrous")
        end,
    },
    Boss = {
        Id = "Boss",
        Label = "Fractured",
        EarningsScalar = 2.75,
        RollWeight = 0,
        EggDisplayName = "Boss Egg",
        EggIcon = "rbxassetid://112428238095917",
        Tint = Color3.fromRGB(8, 8, 8),
        Apply = function(a1, a2, a3) -- Line: 116 -- upvalues: Visuals (val)
            Visuals.ApplyBlack(a2, a3, "Boss", "Cleanup_Fractured")
        end,
        Clear = function(a1, a2, a3) -- Line: 119 -- upvalues: Visuals (val)
            Visuals.ClearBlack(a2, a3)
        end,
    },
    Scrambled = {
        Id = "Scrambled",
        Label = "Scrambled",
        EarningsScalar = 2.75,
        RollWeight = 0,
        IconAssetId = 134710848063255,
        EggIcon = "rbxassetid://125721810079991",
        Tint = Color3.fromRGB(96, 220, 82),
        Apply = function(a1, a2, a3) -- Line: 132 -- upvalues: Visuals (val), ScrambledVisuals (val)
            Visuals.ApplyTint(a2, a1.Tint, 0.65)
            ScrambledVisuals.Apply(a2, a3)
        end,
        Clear = function(a1, a2, a3) -- Line: 136 -- upvalues: Visuals (val), ScrambledVisuals (val)
            Visuals.ClearTint(a2)
            ScrambledVisuals.Clear(a2)
        end,
    },
    Enchanted = {
        Id = "Enchanted",
        Label = "Enchanted",
        EarningsScalar = 2.85,
        RollWeight = 0,
        IconAssetId = 73528861998418,
        Tint = Color3.fromRGB(0, 235, 255),
        Apply = function(a1, a2, a3) -- Line: 149 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(a2, a3, "Enchanted", "Cleanup_Enchanted", a1.Tint, 0.55, 0.1)
        end,
        Clear = function(a1, a2, a3) -- Line: 160 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_Enchanted")
        end,
    },
    Nitro = {
        Id = "Nitro",
        Label = "Nitro",
        EarningsScalar = 2.75,
        RollWeight = 0,
        IconAssetId = 134287739122547,
        Tint = Color3.fromRGB(255, 249, 83),
        Apply = function(a1, a2, a3) -- Line: 173 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(
                a2,
                a3,
                "Nitro",
                "Cleanup_Nitro",
                a1.Tint,
                0.55,
                if not a3 then nil else math.clamp(math.max(a3.Size.X, a3.Size.Y, a3.Size.Z) / 21.4, 0.1, 1.5)
            )
        end,
        Clear = function(a1, a2, a3) -- Line: 179 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_Nitro")
        end,
    },
    Spectral = {
        Id = "Spectral",
        Label = "Spectral",
        EarningsScalar = 2.75,
        RollWeight = 0,
        IconAssetId = 108054256583165,
        Tint = Color3.fromRGB(38, 109, 83),
        Apply = function(a1, a2, a3) -- Line: 191 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(
                a2,
                a3,
                "Spectral",
                "Cleanup_Spectral",
                a1.Tint,
                0.65,
                if not a3 then nil else math.clamp(math.max(a3.Size.X, a3.Size.Y, a3.Size.Z) / 78.6, 0.1, 1.5)
            )
        end,
        Clear = function(a1, a2, a3) -- Line: 197 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_Spectral")
        end,
    },
    Sakura = {
        Id = "Sakura",
        Label = "Bloom",
        EarningsScalar = 1.25,
        RollWeight = 0,
        IconAssetId = 71612969542341,
        Tint = Color3.fromRGB(255, 196, 222),
        Apply = function(a1, a2, a3) -- Line: 209 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(a2, a3, "Sakura", "Cleanup_Sakura", a1.Tint)
        end,
        Clear = function(a1, a2, a3) -- Line: 212 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_Sakura")
        end,
    },
    GreatBloom = {
        Id = "GreatBloom",
        Label = "Spirit Bloom",
        EarningsScalar = 2.5,
        RollWeight = 0,
        IconAssetId = 70859376044018,
        Tint = Color3.fromRGB(60, 255, 140),
        Apply = function(a1, a2, a3) -- Line: 224 -- upvalues: Visuals (val)
            Visuals.ApplyBloom(a2, a3, "GreatBloom", "Cleanup_GreatBloom", a1.Tint)
        end,
        Clear = function(a1, a2, a3) -- Line: 227 -- upvalues: Visuals (val)
            Visuals.ClearBloom(a2, a3, "Cleanup_GreatBloom")
        end,
    },
}
for i, j in v1 do
    table.freeze(j)
end
return require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Mutations", v1, {EarningsScalar = true, RollWeight = true}, true, function(a1) -- Line: 242
    local v1 = 0
    for i, j in a1 do
        v1 = v1 + j.RollWeight
    end
    assert(v1 < 100)
end)