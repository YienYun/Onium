-- Script path: ReplicatedStorage.Shared.Modules.ButterflyCatalog
-- Decompile time: 16.57 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButterflyFlags = require(ReplicatedStorage.Shared.Flags.ButterflyFlags)
local u14 = NumberRange.new(4, 12)
local u18 = NumberRange.new(30, 90)
local u22 = NumberRange.new(0.6, 1.15)
local u26 = setmetatable({}, {__mode = "k"})
local u27 = {Order = {"Green", "Blue", "Purple", "Golden"}}
u27.Tiers = {
    Green = {
        Id = "Green",
        DisplayName = "Emerald Butterfly",
        Rarity = "Common",
        Order = 1,
        Speed = 1,
        Wander = 0.25,
        Dodge = 0.2,
        FlapSpeed = 13,
        Scale = 2,
        Trail = false,
        Icon = "rbxassetid://107744695034799",
        CatchSound = "rbxassetid://77279854130030",
        Next = "Blue",
        Color = Color3.fromRGB(72, 214, 96),
        StrokeColor = Color3.fromRGB(12, 64, 24),
    },
    Blue = {
        Id = "Blue",
        DisplayName = "Sapphire Butterfly",
        Rarity = "Rare",
        Order = 2,
        Speed = 1.35,
        Wander = 0.4,
        Dodge = 0.35,
        FlapSpeed = 15,
        Scale = 2.1,
        Trail = false,
        Icon = "rbxassetid://89995151383384",
        CatchSound = "rbxassetid://99355023738967",
        Next = "Purple",
        Color = Color3.fromRGB(64, 140, 255),
        StrokeColor = Color3.fromRGB(10, 30, 90),
    },
    Purple = {
        Id = "Purple",
        DisplayName = "Amethyst Butterfly",
        Rarity = "Epic",
        Order = 3,
        Speed = 1.8,
        Wander = 0.6,
        Dodge = 0.5,
        FlapSpeed = 17,
        Scale = 2.25,
        Trail = true,
        Icon = "rbxassetid://121235713836098",
        CatchSound = "rbxassetid://119143297007735",
        Next = "Golden",
        Color = Color3.fromRGB(176, 84, 255),
        StrokeColor = Color3.fromRGB(50, 12, 90),
    },
    Golden = {
        Id = "Golden",
        DisplayName = "Radiant Butterfly",
        Rarity = "Legendary",
        Order = 4,
        Speed = 2.4,
        Wander = 0.85,
        Dodge = 0.65,
        FlapSpeed = 19,
        Scale = 2.6,
        Trail = true,
        Icon = "rbxassetid://98126365702697",
        CatchSound = "rbxassetid://98682676857672",
        Color = Color3.fromRGB(255, 200, 50),
        StrokeColor = Color3.fromRGB(110, 60, 0),
    },
}
u27.Sounds = table.freeze({
    Swing = "rbxassetid://125101827399863",
    Escape = "rbxassetid://114385851460875",
    BloomStart = "rbxassetid://115559600750711",
    GoldenAnnounce = "rbxassetid://100474069377714",
    Ambience = "rbxassetid://91881816112074",
    Craft = "rbxassetid://103410108378357",
    Deny = "rbxassetid://84524242151355",
    Snag = "rbxassetid://110195370309564",
})
u27.Animations = table.freeze({
    Fly = "rbxassetid://116985467947373",
    Glide = "rbxassetid://113268708128253",
    Struggle = "rbxassetid://88700929559177",
})
u27.TierAnimations = table.freeze({
    Green = table.freeze({
        Fly = "rbxassetid://74344390381394",
        Glide = "rbxassetid://71567350079179",
        Struggle = "rbxassetid://74344390381394",
    }),
    Blue = table.freeze({
        Fly = "rbxassetid://84976279698060",
        Glide = "rbxassetid://90226558554634",
        Struggle = "rbxassetid://84976279698060",
    }),
    Purple = table.freeze({
        Fly = "rbxassetid://80602328062595",
        Glide = "rbxassetid://132894038596670",
        Struggle = "rbxassetid://80602328062595",
    }),
    Golden = table.freeze({
        Fly = "rbxassetid://91142398877798",
        Glide = "rbxassetid://71795342824977",
        Struggle = "rbxassetid://91142398877798",
    }),
})
u27.Icons = table.freeze({Net = "rbxassetid://131116540264095", Essence = "rbxassetid://114750647204247"})
u27.EssenceName = "Enchanted Essence"
u27.NetToolName = "Butterfly Net"
u27.NetItemType = "ButterflyNet"
u27.EventName = "ButterflyBloom"
u27.EndsAtAttribute = "ButterflyBloomEndsAt"
u27.FlightHeight = 4.5
u27.SpawnDropHeight = 16
u27.SpawnSeconds = 1.4
u27.EscapeSeconds = 1.35
u27.SnagSeconds = 0.1
u27.DodgeSeconds = 0.45
u27.EscapeLift = 7

function u27.IsTier(a1) -- Line: 212 -- upvalues: u27 (val)
    local v1 = false
    if typeof(a1) == "string" then
        v1 = u27.Tiers[a1] ~= nil
    end
    return v1
end

function u27.Get(a1) -- Line: 216 -- upvalues: u27 (val) -- types: a1: string
    local v1 = u27.Tiers[a1]
    assert(v1, (("unknown butterfly tier %*"):format(a1)))
    return v1
end

function u27.CatchChance(a1) -- Line: 222 -- upvalues: ButterflyFlags (val) -- types: a1: string
    if a1 == "Green" then
        return ButterflyFlags.GreenCatchChance:Get()
    end
    if a1 == "Blue" then
        return ButterflyFlags.BlueCatchChance:Get()
    end
    if a1 == "Purple" then
        return ButterflyFlags.PurpleCatchChance:Get()
    end
    return ButterflyFlags.GoldenCatchChance:Get()
end

function u27.SpawnWeight(a1) -- Line: 233 -- upvalues: ButterflyFlags (val) -- types: a1: string
    if a1 == "Green" then
        return ButterflyFlags.GreenWeight:Get()
    end
    if a1 == "Blue" then
        return ButterflyFlags.BlueWeight:Get()
    end
    if a1 == "Purple" then
        return ButterflyFlags.PurpleWeight:Get()
    end
    return ButterflyFlags.GoldenWeight:Get()
end

function u27.TradeUpCost(a1) -- Line: 244 -- upvalues: ButterflyFlags (val) -- types: a1: string
    if a1 == "Green" then
        return ButterflyFlags.GreenToBlueCost:Get()
    end
    if a1 == "Blue" then
        return ButterflyFlags.BlueToPurpleCost:Get()
    end
    if a1 == "Purple" then
        return ButterflyFlags.PurpleToGoldenCost:Get()
    end
    return nil
end

function u27.CruiseSpeed(a1) -- Line: 255 -- upvalues: ButterflyFlags (val) -- types: a1: string
    if a1 == "Green" then
        return ButterflyFlags.GreenCruiseSpeed:Get()
    end
    if a1 == "Blue" then
        return ButterflyFlags.BlueCruiseSpeed:Get()
    end
    if a1 == "Purple" then
        return ButterflyFlags.PurpleCruiseSpeed:Get()
    end
    return ButterflyFlags.GoldenCruiseSpeed:Get()
end

function u27.EssenceRecipe() -- Line: 266 -- upvalues: ButterflyFlags (val)
    return {
        Green = ButterflyFlags.EssenceGreen:Get(),
        Blue = ButterflyFlags.EssenceBlue:Get(),
        Purple = ButterflyFlags.EssencePurple:Get(),
        Golden = ButterflyFlags.EssenceGolden:Get(),
    }
end

local function phase(a1, a2) -- Line: 275 -- types: a1: number, a2: number
    return a1 * (a2 * 7919 + 104729) % 10007 / 10007 * 6.283185307179586
end

local function multiply32(a1, a2) -- Line: 279 -- types: a1: number, a2: number
    local v1 = bit32.rshift(a1, 16)
    local v2 = bit32.band(a1, 65535)
    return (v1 * a2 % 65536 * 65536 + v2 * a2) % 4294967296
end

local function knotValue(a1, a2, a3) -- Line: 285 -- types: a1: number, a2: number, a3: number
    local v1 = bit32.rshift(a2, 16)
    local v2 = bit32.band(a2, 65535)
    local v3 = (v1 * 2654435769 % 65536 * 65536 + v2 * 2654435769) % 4294967296
    v2 = a3 % 4294967296
    local v4 = bit32.rshift(v2, 16)
    local v5 = bit32.band(v2, 65535)
    local v6 = bit32.bxor(a1, v3, (v4 * 2246822507 % 65536 * 65536 + v5 * 2246822507) % 4294967296)
    local v7 = bit32.bxor(v6, (bit32.rshift(v6, 16)))
    v3 = bit32.rshift(v7, 16)
    v1 = bit32.band(v7, 65535)
    v6 = (v3 * 2146121005 % 65536 * 65536 + v1 * 2146121005) % 4294967296
    v7 = bit32.bxor(v6, (bit32.rshift(v6, 15)))
    v3 = bit32.rshift(v7, 16)
    v1 = bit32.band(v7, 65535)
    v6 = (v3 * 2221713035 % 65536 * 65536 + v1 * 2221713035) % 4294967296
    return bit32.bxor(v6, (bit32.rshift(v6, 16))) / 4294967295 * 2 - 1
end

local function unitValue(a1, a2, a3) -- Line: 294
    -- upvalues: knotValue (val)
    return (knotValue(a1, a2, a3) + 1) / 2
end

local function knotsAt(a1, a2, a3) -- Line: 298 -- upvalues: knotValue (val) -- types: a1: table, a2: number, a3: number
    local Seed = a1.Seed
    local v1 = a1.Noise[a2]
    if v1 == nil then
        v1 = {
            Knot = a3,
            A = knotValue(Seed, a2, a3 - 1),
            B = knotValue(Seed, a2, a3),
            C = knotValue(Seed, a2, a3 + 1),
            D = knotValue(Seed, a2, a3 + 2),
        }
        a1.Noise[a2] = v1
        return v1
    end
    if v1.Knot == a3 - 1 then
        v1.Knot = a3
        v1.A = v1.B
        v1.B = v1.C
        v1.C = v1.D
        v1.D = knotValue(Seed, a2, a3 + 2)
        return v1
    end
    if v1.Knot ~= a3 then
        v1.Knot = a3
        v1.A = knotValue(Seed, a2, a3 - 1)
        v1.B = knotValue(Seed, a2, a3)
        v1.C = knotValue(Seed, a2, a3 + 1)
        v1.D = knotValue(Seed, a2, a3 + 2)
    end
    return v1
end

local function noise(a1, a2, a3) -- Line: 326 -- upvalues: knotsAt (val) -- types: a1: table, a2: number, a3: number
    local v1 = math.floor(a3)
    local v2 = a3 - v1
    local v3 = knotsAt(a1, a2, v1)
    local A = v3.A
    local B = v3.B
    local C = v3.C
    local D = v3.D
    return (B * 2 + (C - A) * v2 + (A * 2 - B * 5 + C * 4 - D) * v2 * v2 + ((B - C) * 3 + D - A) * v2 * v2 * v2) * 0.5
end

local function pick(a1, a2) -- Line: 343 -- types: a1: userdata, a2: number
    return a1.Min + (a1.Max - a1.Min) * a2
end

local function reflect(a1, a2) -- Line: 347 -- types: a1: number, a2: number
    if a2 < a1 then
        a1 = a2 * 2 - a1
    end
    if a1 < -a2 then
        a1 = a2 * -2 - a1
    end
    return (math.clamp(a1, -a2, a2))
end

local function edgeBias(a1) -- Line: 357 -- types: a1: number
    return (math.sign(a1)) * math.abs(a1) ^ 0.45
end

local function easeOut(a1) -- Line: 361 -- types: a1: number
    return 1 - (1 - a1) ^ 3
end

local function jinkSize(a1, a2) -- Line: 365 -- types: a1: table, a2: table
    return (math.min(math.max(a1.Radius, 1), 9)) * (a2.Wander + 0.5)
end

local function buildRoute(a1) -- Line: 369 -- upvalues: u27 (val), knotValue (val) -- types: a1: table
    local v1 = u27.Get(a1.Tier)
    local v2 = math.max(a1.Radius, 1)
    local v3 = math.max(a1.Spread or v2, 1)
    local v4 = (math.min(math.max(a1.Radius, 1), 9)) * (v1.Wander + 0.5) * 0.25
    v1 = math.max(v3 - v4, 1)
    v3 = math.max(v2 - v4, 1)
    local Seed = a1.Seed
    return {
        Times = {0},
        X = {knotValue(Seed, 10, 0) * v1},
        Z = {knotValue(Seed, 11, 0) * v3},
        HalfX = v1,
        HalfZ = v3,
        Speed = math.max(u27.CruiseSpeed(a1.Tier), 1),
        Seed = Seed,
        Noise = {},
    }
end

local function routeOf(a1) -- Line: 389 -- upvalues: u26 (val), buildRoute (val) -- types: a1: table
    local v1 = u26[a1]
    if v1 == nil then
        u26[a1] = (buildRoute(a1))
    end
    return v1
end

local function extendRoute(a1, a2) -- Line: 398
    -- upvalues: knotValue (val), u22 (val), u14 (val), u18 (val)
    local HalfX, HalfZ, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local Times = a1.Times
    local X = a1.X
    local Z = a1.Z
    local Seed = a1.Seed
    local v12, v13 = a2, a1
    while #Times < v12 do
        v8 = #Times
        v9 = X[v8]
        v10 = Z[v8]
        v11 = (knotValue(Seed, 12, v8) + 1) / 2
        v1 = (knotValue(Seed, 13, v8) + 1) / 2 * 6.283185307179586
        v2 = (knotValue(Seed, 14, v8) + 1) / 2
        v4 = u22
        v5 = (knotValue(Seed, 15, v8) + 1) / 2
        v3 = v4.Min + (v4.Max - v4.Min) * v5
        if not (v11 < 0.62) then
            v7 = knotValue(Seed, 16, v8)
            v4 = (math.sign(v7)) * math.abs(v7) ^ 0.45 * v13.HalfX
            v7 = knotValue(Seed, 17, v8)
            v5 = (math.sign(v7)) * math.abs(v7) ^ 0.45 * v13.HalfZ
        else
            v7 = if not (v11 < 0.12) then u18 else u14
            v6 = v7.Min + (v7.Max - v7.Min) * v2
            v7 = v9 + math.cos(v1) * v6
            HalfX = v13.HalfX
            if HalfX < v7 then
                v7 = HalfX * 2 - v7
            end
            if v7 < -HalfX then
                v7 = HalfX * -2 - v7
            end
            v4 = math.clamp(v7, -HalfX, HalfX)
            v7 = v10 + math.sin(v1) * v6
            HalfZ = v13.HalfZ
            if HalfZ < v7 then
                v7 = HalfZ * 2 - v7
            end
            if v7 < -HalfZ then
                v7 = HalfZ * -2 - v7
            end
            v5 = math.clamp(v7, -HalfZ, HalfZ)
            if v11 < 0.12 then
                v3 = 0.3
            end
        end
        v6 = math.max(math.sqrt((v4 - v9) ^ 2 + (v5 - v10) ^ 2) / (v13.Speed * v3), 0.3)
        table.insert(Times, Times[v8] + v6)
        table.insert(X, v4)
        table.insert(Z, v5)
    end
end

local function slope(a1, a2, a3) -- Line: 434 -- types: a1: table, a2: table, a3: number
    if a3 == 1 then
        return (a2[2] - a2[1]) / (a1[2] - a1[1])
    end
    return (a2[a3 + 1] - a2[a3 - 1]) / (a1[a3 + 1] - a1[a3 - 1])
end

local function hermite(a1, a2, a3, a4, a5, a6, a7) -- Line: 441
    -- upvalues: 
    local v1 = a4 * a2[a3]
    local v2 = if a3 ~= 1 then (a2[a3 + 1] - a2[a3 - 1]) / (a1[a3 + 1] - a1[a3 - 1]) else (a2[2] - a2[1]) / (a1[2] - a1[1])
    local v3 = v1 + a5 * v2 + a6 * a2[a3 + 1]
    local v4 = a3 + 1
    v1 = if v4 ~= 1 then (a2[v4 + 1] - a2[v4 - 1]) / (a1[v4 + 1] - a1[v4 - 1]) else (a2[2] - a2[1]) / (a1[2] - a1[1])
    return v3 + a7 * v1
end

local function routeOffset(a1, a2) -- Line: 456 -- upvalues: extendRoute (val) -- types: a1: table, a2: number
    local v1
    local Times = a1.Times
    local v2 = math.max(a2, 0)
    local v3 = a1
    while true do
        if #Times < 3 then
            extendRoute(v3, #Times + 8)
            continue
        end
        if not (Times[#Times] <= v2) then
            break
        end
        extendRoute(v3, #Times + 8)
    end
    local v4 = 1
    local v5 = #Times
    while 1 < v5 - v4 do
        v1 = (v4 + v5) // 2
        if not (Times[v1] <= v2) then
            v5 = v1
        else
            v4 = v1
        end
    end
    extendRoute(v3, v4 + 2)
    v5 = Times[v4 + 1] - Times[v4]
    v1 = (v2 - Times[v4]) / v5
    local v6 = v1 * v1
    local v7 = v6 * v1
    local v8 = v7 * 2 - v6 * 3 + 1
    local v9 = (v7 - v6 * 2 + v1) * v5
    v1 = v7 * -2 + v6 * 3
    local v10 = (v7 - v6) * v5
    local X = v3.X
    local v11 = v8 * X[v4]
    local v12 = if v4 ~= 1 then (X[v4 + 1] - X[v4 - 1]) / (Times[v4 + 1] - Times[v4 - 1]) else (X[2] - X[1]) / (Times[2] - Times[1])
    local v13 = v11 + v9 * v12 + v1 * X[v4 + 1]
    local v14 = v4 + 1
    v11 = if v14 ~= 1 then (X[v14 + 1] - X[v14 - 1]) / (Times[v14 + 1] - Times[v14 - 1]) else (X[2] - X[1]) / (Times[2] - Times[1])
    local v15 = v13 + v10 * v11
    local Z = v3.Z
    v14 = v8 * Z[v4]
    local v16 = if v4 ~= 1 then (Z[v4 + 1] - Z[v4 - 1]) / (Times[v4 + 1] - Times[v4 - 1]) else (Z[2] - Z[1]) / (Times[2] - Times[1])
    local v17 = v14 + v9 * v16 + v1 * Z[v4 + 1]
    v12 = v4 + 1
    v14 = if v12 ~= 1 then (Z[v12 + 1] - Z[v12 - 1]) / (Times[v12 + 1] - Times[v12 - 1]) else (Z[2] - Z[1]) / (Times[2] - Times[1])
    return v15, v17 + v10 * v14
end

local function cruise(a1, a2) -- Line: 485
    -- upvalues: u27 (val), u26 (val), buildRoute (val), routeOffset (val), noise (val)
    local v1 = u27.Get(a1.Tier)
    local v2 = a2 - a1.Born
    local Seed = a1.Seed
    local Speed = v1.Speed
    local Wander = v1.Wander
    local v3 = math.max(a1.Radius, 1)
    local v4 = math.max(a1.Spread or v3, 1)
    local v5 = (math.min(math.max(a1.Radius, 1), 9)) * (v1.Wander + 0.5) * 0.5
    v1 = v2 * 1.1 * Speed
    local v6 = u26[a1]
    if v6 == nil then
        u26[a1] = (buildRoute(a1))
    end
    local v7, v8 = routeOffset(v6, v2)
    local v9 = v7 + noise(v6, 3, v1) * v5 + math.sin(v2 * 2.9 * Speed + Seed * 160162 % 10007 / 10007 * 6.283185307179586) * Wander * 1.6
    v7 = v8 + noise(v6, 5, v1) * v5 + math.cos(v2 * 3.4 * Speed + Seed * 168081 % 10007 / 10007 * 6.283185307179586) * Wander * 1.6
    v8 = noise(v6, 6, v2 / 2.5) * 1.3 + math.sin(v2 * 3.1 * Speed + Seed * 152243 % 10007 / 10007 * 6.283185307179586) * 0.35 * (1 + Wander)
    return a1.Anchor + Vector3.new(math.clamp(v9, -v4, v4), v8, (math.clamp(v7, -v3, v3)))
end

function u27.PositionAt(a1, a2) -- Line: 509 -- upvalues: cruise (val), u27 (val) -- types: a1: table, a2: number
    local v1 = cruise(a1, a2)
    local v2 = a2 - a1.FleeAt
    if not (a1.FleeSeconds <= v2) and not (a1.FleeSeconds <= 0) then
        local v3 = math.clamp(v2 / a1.FleeSeconds, 0, 1)
        v2 = (math.sin(v3 * 3.141592653589793)) * u27.EscapeLift * math.min(1, a1.FleeSeconds / u27.EscapeSeconds)
        return (a1.FleeFrom:Lerp(v1, 1 - (1 - v3) ^ 3)) + Vector3.new(0, v2, 0)
    end
    return v1
end

function u27.VelocityAt(a1, a2) -- Line: 522 -- upvalues: u27 (val) -- types: a1: table, a2: number
    return ((u27.PositionAt(a1, a2 + 0.03333333333333333)) - u27.PositionAt(a1, a2 - 0.03333333333333333)) / 0.06666666666666667
end

return table.freeze(u27)