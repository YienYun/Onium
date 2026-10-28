-- Script path: ReplicatedStorage.Shared.Util.HalloweenDimension
-- Decompile time: 0.51 ms

return table.freeze({
    MapName = "HalloweenDimension",
    PortalName = "HalloweenDimensionPortal",
    LightingPreset = "HalloweenDimension",
    EggShopTag = "HalloweenDimensionEggShop",
    Zones = table.freeze({
        table.freeze({DisplayName = "Graveyard", Emoji = "⚰️"}),
        table.freeze({DisplayName = "Haunted Swamp", Emoji = "🦇"}),
        (table.freeze({DisplayName = "Abandoned Manor", Emoji = "🎃"})),
    }),
    Ghosts = table.freeze({Folder = "Ghosts", Target = "GhostTarget"}),
    WorldEvents = table.freeze({BloodMoon = "BloodMoon", PumpkinMoon = "PumpkinMoon"}),
    Attributes = table.freeze({
        WorldEvent = "HalloweenWorldEvent",
        WorldEventEndsAt = "HalloweenWorldEventEndsAt",
        WorldEventText = "HalloweenWorldEventText",
        GateOpen = "Open",
    }),
    PlayerAttributes = table.freeze({
        Inside = "InHalloweenDimension",
        Carrying = "HalloweenCarrying",
        CarryZone = "HalloweenCarryZone",
        CarryRarity = "HalloweenCarryRarity",
        CarryColor = "HalloweenCarryColor",
        Delivered = "HalloweenDelivered",
        Lost = "HalloweenLost",
        Knocked = "HalloweenKnocked",
        Seized = "HalloweenSeized",
        Dropped = "HalloweenDropped",
        Transition = "HalloweenTransition",
        PumpkinCarrying = "HalloweenPumpkinCarrying",
        Pumpkins = "HalloweenPumpkins",
        PumpkinsAt = "HalloweenPumpkinsAt",
        PumpkinDepositFrom = "HalloweenPumpkinDepositFrom",
    }),
})