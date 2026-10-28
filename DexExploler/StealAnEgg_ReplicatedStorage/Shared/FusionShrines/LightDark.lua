-- Script path: ReplicatedStorage.Shared.FusionShrines.LightDark
-- Decompile time: 1.02 ms

return table.freeze({
    Id = "LightDark",
    RarityLocked = true,
    Sequence = "Orbit",
    HideHud = false,
    Tiers = table.freeze({"Divine", "Eternal"}),
    Sides = table.freeze({"Light", "Dark"}),
    Pads = table.freeze({Light = "LightPad", Dark = "DarkPad"}),
    Colors = table.freeze({Light = Color3.fromRGB(255, 209, 74), Dark = Color3.fromRGB(198, 42, 32)}),
    Billboard = table.freeze({
        Template = "FusionShrineBillboard",
        Mode = "Tiers",
        Columns = table.freeze({Divine = "DivineColumn", Eternal = "EternalColumn"}),
        Styles = table.freeze({COMPLETED = "DivineColumn", AVAILABLE = "EternalColumn"}),
    }),
    PadVfx = table.freeze({}),
    Copy = table.freeze({
        Mismatch = "Both pets must be Divine, or both Eternal.",
        Hold = function(a1) -- Line: 22 -- types: a1: string
            return (("Hold a %* Divine or Eternal pet."):format(a1))
        end,
        Stand = function(a1) -- Line: 25 -- types: a1: string
            return (("Stand on the %* pad with your pet."):format(a1))
        end,
        WrongPad = function(a1) -- Line: 28 -- types: a1: string
            return (("Move to the %* pad."):format(a1))
        end,
        Ready = function(a1, a2) -- Line: 31 -- types: a1: table
            local v1 = a1[1]
            return (("Partner needs %* on the %* pad. Both pets will be used up."):format(a2[v1], v1))
        end,
        Done = function(a1) -- Line: 35 -- types: a1: string
            return (("%* Fusion already done. Once per account."):format(a1))
        end,
        Info = function() -- Line: 39
            return "2 players. Light + Dark pets, both Divine or both Eternal. Each fusion: once per account."
        end,
    }),
})