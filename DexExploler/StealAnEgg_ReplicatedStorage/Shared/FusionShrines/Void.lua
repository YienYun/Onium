-- Script path: ReplicatedStorage.Shared.FusionShrines.Void
-- Decompile time: 4.72 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local u12 = table.freeze({Fish = "fish pedestal", Pumpkin = "pumpkin pedestal"})

local function nameOf(a1) -- Line: 8 -- upvalues: Assets (val)
    local v1 = if type(a1) ~= "string" then nil else Assets.Directory[a1]
    if v1 and v1.DisplayName then
        return v1.DisplayName
    end
    return "pet"
end

local function recipeOf(a1) -- Line: 13
    if type(a1) == "table" then
        return a1.Void
    end
    return nil
end

return table.freeze({
    Id = "Void",
    RarityLocked = false,
    Sequence = "VoidRitual",
    HideHud = true,
    Tiers = table.freeze({"Void"}),
    Sides = table.freeze({"Fish", "Pumpkin"}),
    Pads = table.freeze({Fish = "FishPad", Pumpkin = "PumpkinPad"}),
    Colors = table.freeze({Fish = Color3.fromRGB(120, 230, 255), Pumpkin = Color3.fromRGB(176, 76, 255)}),
    Placement = table.freeze({
        Players = 2,
        Reach = 16,
        Slots = table.freeze({FishPad = "Fish", FishPad2 = "Fish", PumpkinPad = "Pumpkin", PumpkinPad2 = "Pumpkin"}),
        Seats = table.freeze({
            table.freeze({"FishPad", "PumpkinPad"}),
            (table.freeze({"FishPad2", "PumpkinPad2"})),
        }),
        Sizes = table.freeze({Fish = 6.5, Pumpkin = 6}),
        Hover = table.freeze({Fish = 0.6, Pumpkin = 0}),
        StatusHeights = table.freeze({Fish = 10.5, Pumpkin = 10.5}),
    }),
    Billboard = table.freeze({
        Template = "FusionShrineBillboard_Void",
        Mode = "Sides",
        PerSide = true,
        Columns = table.freeze({Fish = "FishColumn", Pumpkin = "PumpkinColumn"}),
        Styles = table.freeze({READY = "PumpkinColumn", MISSING = "FishColumn"}),
    }),
    PadVfx = table.freeze({
        DiscDiameter = 7,
        OrbRadius = 4.4,
        OrbSize = 0.45,
        OrbHeight = 1.6,
        FieldSize = 50,
        ArcCurve = 0,
        ArcWidth = 0,
        StatusHeight = 10.5,
        HintHeight = 14,
    }),
    Copy = table.freeze({
        Mismatch = "Both pets must belong to the Void Fusion.",
        Hold = function(a1, a2) -- Line: 65 -- upvalues: Assets (val), u12 (val) -- types: a1: string
            local Void = if type(a2) ~= "table" then nil else a2.Void
            local v1 = Void and Void[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Hold a %* at the %*."):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName, u12[a1]))
        end,
        Stand = function(a1) -- Line: 69 -- upvalues: u12 (val) -- types: a1: string
            return (("Stand by the %* holding your pet."):format(u12[a1]))
        end,
        WrongPad = function(a1) -- Line: 72 -- upvalues: u12 (val) -- types: a1: string
            return (("Use the %*."):format(u12[a1]))
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
            return "Void Fusion already done. Once per account."
        end,
        Place = function(a1, a2) -- Line: 83 -- upvalues: Assets (val) -- types: a1: string
            local Void = if type(a2) ~= "table" then nil else a2.Void
            local v1 = Void and Void[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Place %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        PlaceOn = function(a1) -- Line: 87 -- types: a1: string
            return (("Wrong pedestal, try the %* one"):format((string.lower(a1))))
        end,
        Placed = function() -- Line: 90
            return "Wait for a partner!"
        end,
        AlreadyPlaced = function(a1, a2, a3) -- Line: 93 -- upvalues: Assets (val) -- types: a1: string, a3: string?
            local Void = if type(a2) ~= "table" then nil else a2.Void
            if not a3 then
                return "This is your partner's pedestal"
            end
            local v1 = Void and Void[a3]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("This is your partner's pedestal, place your %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        HoldToPlace = function(a1, a2) -- Line: 102 -- upvalues: Assets (val) -- types: a1: string
            local Void = if type(a2) ~= "table" then nil else a2.Void
            local v1 = Void and Void[a1]
            local v2 = if type(v1) ~= "string" then nil else Assets.Directory[v1]
            return (("Hold a %*"):format(if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName))
        end,
        Unpaired = function(a1) -- Line: 106 -- upvalues: Assets (val)
            local Void
            local Fish = ((if type(a1) ~= "table" then nil else a1.Void) or {}).Fish
            local v1 = if type(Fish) ~= "string" then nil else Assets.Directory[Fish]
            local DisplayName = if not v1 then "pet" else if not v1.DisplayName then "pet" else v1.DisplayName
            local Pumpkin = Void.Pumpkin
            local v2 = if type(Pumpkin) ~= "string" then nil else Assets.Directory[Pumpkin]
            return (("Each player needs a %* and a %*"):format(
                DisplayName,
                if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName
            ))
        end,
        Info = function(a1) -- Line: 110 -- upvalues: Assets (val)
            local Void
            local Fish = ((if type(a1) ~= "table" then nil else a1.Void) or {}).Fish
            local v1 = if type(Fish) ~= "string" then nil else Assets.Directory[Fish]
            local DisplayName = if not v1 then "pet" else if not v1.DisplayName then "pet" else v1.DisplayName
            local Pumpkin = Void.Pumpkin
            local v2 = if type(Pumpkin) ~= "string" then nil else Assets.Directory[Pumpkin]
            return (("2 players, each brings a %* and a %*. Once per account."):format(
                DisplayName,
                if not v2 then "pet" else if not v2.DisplayName then "pet" else v2.DisplayName
            ))
        end,
    }),
})