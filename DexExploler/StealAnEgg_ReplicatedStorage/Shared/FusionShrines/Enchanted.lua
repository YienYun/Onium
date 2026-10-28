-- Script path: ReplicatedStorage.Shared.FusionShrines.Enchanted
-- Decompile time: 4.09 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local u12 = table.freeze({Whale = "blue Whale pad", Lion = "orange Lion pad"})
local u15 = table.freeze({Whale = "blue", Lion = "orange"})

local function nameOf(a1) -- Line: 9 -- upvalues: Assets (val)
    local v1 = if type(a1) ~= "string" then nil else Assets.Directory[a1]
    if v1 and v1.DisplayName then
        return v1.DisplayName
    end
    return "pet"
end

local function recipeOf(a1) -- Line: 14
    if type(a1) == "table" then
        return a1.Enchanted
    end
    return nil
end

return table.freeze({
    Id = "Enchanted",
    RarityLocked = false,
    Sequence = "EnchantedPond",
    HideHud = true,
    Tiers = table.freeze({"Enchanted"}),
    Sides = table.freeze({"Whale", "Lion"}),
    Pads = table.freeze({Whale = "WhalePad", Lion = "LionPad"}),
    Colors = table.freeze({Whale = Color3.fromRGB(70, 182, 255), Lion = Color3.fromRGB(255, 164, 46)}),
    Placement = table.freeze({
        Players = 2,
        Reach = 16,
        Slots = table.freeze({WhalePad = "Whale", WhalePad2 = "Whale", LionPad = "Lion", LionPad2 = "Lion"}),
        Seats = table.freeze({
            table.freeze({"WhalePad", "LionPad2"}),
            (table.freeze({"WhalePad2", "LionPad"})),
        }),
        Sizes = table.freeze({Whale = 13, Lion = 8}),
        Hover = table.freeze({Whale = 6.5, Lion = 0}),
        StatusHeights = table.freeze({Whale = 19, Lion = 12}),
    }),
    Billboard = table.freeze({
        Template = "FusionShrineBillboard_Enchanted",
        Mode = "Sides",
        PerSide = true,
        Columns = table.freeze({Whale = "WhaleColumn", Lion = "LionColumn"}),
        Styles = table.freeze({READY = "LionColumn", MISSING = "WhaleColumn"}),
    }),
    PadVfx = table.freeze({
        DiscDiameter = 9.8,
        OrbRadius = 5.2,
        OrbSize = 0.55,
        FieldSize = 84,
        ArcCurve = 26,
        ArcWidth = 0,
        StatusHeight = 7.5,
        HintHeight = 15.5,
    }),
    Copy = table.freeze({
        Mismatch = "Both pets must belong to the Enchanted Fusion.",
        Hold = function(a1, a2) -- Line: 65 -- upvalues: Assets (val), u12 (val) -- types: a1: string
            local Enchanted = if type(a2) ~= "table" then nil else a2.Enchanted
            local v1 = Enchanted and Enchanted[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Hold a %* on the %*."):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName, u12[a1]))
        end,
        Stand = function(a1) -- Line: 69 -- upvalues: u12 (val) -- types: a1: string
            return (("Stand on the %* holding your pet."):format(u12[a1]))
        end,
        WrongPad = function(a1) -- Line: 72 -- upvalues: u12 (val) -- types: a1: string
            return (("Move to the %*."):format(u12[a1]))
        end,
        Ready = function(a1, a2) -- Line: 75 -- upvalues: Assets (val), u12 (val) -- types: a1: table
            local v1 = a1[1]
            local v2 = a2[v1]
            local v3 = if type(v2) ~= "string" then nil else Assets.Directory[v2]
            return (("Partner needs a %* on the %*. Both pets will be used up."):format(
                if not v3 then "pet" else if not v3.DisplayName then "pet" else v3.DisplayName,
                u12[v1]
            ))
        end,
        Done = function() -- Line: 79
            return "Enchanted Fusion already done. Once per account."
        end,
        Place = function(a1, a2) -- Line: 83 -- upvalues: Assets (val) -- types: a1: string
            local Enchanted = if type(a2) ~= "table" then nil else a2.Enchanted
            local v1 = Enchanted and Enchanted[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Place %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        PlaceOn = function(a1) -- Line: 87 -- upvalues: u15 (val) -- types: a1: string
            return (("Wrong pad, try %*"):format(u15[a1]))
        end,
        Placed = function() -- Line: 90
            return "Wait for a partner!"
        end,
        AlreadyPlaced = function(a1, a2, a3) -- Line: 93 -- upvalues: Assets (val) -- types: a1: string, a3: string?
            local Enchanted = if type(a2) ~= "table" then nil else a2.Enchanted
            if not a3 then
                return "This is your partner's pad"
            end
            local v1 = Enchanted and Enchanted[a3]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("This is your partner's pad, place your %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        HoldToPlace = function(a1, a2) -- Line: 100 -- upvalues: Assets (val) -- types: a1: string
            local Enchanted = if type(a2) ~= "table" then nil else a2.Enchanted
            local v1 = Enchanted and Enchanted[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Hold a %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        Info = function(a1) -- Line: 104 -- upvalues: Assets (val)
            local Enchanted
            local Whale = ((if type(a1) ~= "table" then nil else a1.Enchanted) or {}).Whale
            local v1 = if type(Whale) ~= "string" then nil else Assets.Directory[Whale]
            local DisplayName = if not v1 then "pet" else if not v1.DisplayName then "pet" else v1.DisplayName
            local Lion = Enchanted.Lion
            local v2 = if type(Lion) ~= "string" then nil else Assets.Directory[Lion]
            return (("2 players, each brings a %* for a blue pad and a %* for an orange pad. Once per account."):format(
                DisplayName,
                if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName
            ))
        end,
    }),
})