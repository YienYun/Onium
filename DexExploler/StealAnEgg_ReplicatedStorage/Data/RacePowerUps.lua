-- Script path: ReplicatedStorage.Data.RacePowerUps
-- Decompile time: 5.46 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local function item(a1, a2, a3, a4, a5, a6, a7) -- Line: 23
    -- upvalues: 
    return table.freeze({
        Id = a1,
        Name = a2,
        Icon = a3,
        Color = a4,
        Uses = a5,
        Seconds = a6,
        Model = a7,
    })
end

local u11 = {SimStep = 0.03333333333333333}
u11.Order = table.freeze({"Shield", "Spike", "Serum", "Skywhale", "Pod", "Drilla", "Egg"})
u11.Items = table.freeze({
    Shield = table.freeze({
        Id = "Shield",
        Name = "Scramble Shield",
        Icon = "",
        Uses = 1,
        Seconds = 7,
        Model = "Shield",
        Color = Color3.fromRGB(80, 205, 255),
    }),
    Spike = table.freeze({
        Id = "Spike",
        Name = "Spike",
        Icon = "rbxassetid://80985497889360",
        Uses = 3,
        Color = Color3.fromRGB(255, 165, 60),
    }),
    Serum = table.freeze({
        Id = "Serum",
        Name = "Scramble Serum",
        Icon = "rbxassetid://98847011195862",
        Uses = 1,
        Seconds = 5,
        Color = Color3.fromRGB(130, 255, 70),
    }),
    Skywhale = table.freeze({
        Id = "Skywhale",
        Name = "Royale Skywhale Express",
        Icon = "rbxassetid://140420688307546",
        Uses = 1,
        Seconds = 4,
        Color = Color3.fromRGB(185, 110, 255),
    }),
    Pod = table.freeze({
        Id = "Pod",
        Name = "Dr Scramble Pod",
        Icon = "rbxassetid://135238935953633",
        Uses = 1,
        Color = Color3.fromRGB(255, 70, 70),
    }),
    Drilla = table.freeze({
        Id = "Drilla",
        Name = "Drilla Ambush",
        Icon = "rbxassetid://85987118042621",
        Uses = 1,
        Color = Color3.fromRGB(255, 200, 60),
    }),
    Egg = table.freeze({
        Id = "Egg",
        Name = "Egg Splatter",
        Icon = "",
        Uses = 1,
        Model = "Splat",
        Color = Color3.fromRGB(255, 215, 40),
    }),
})
u11.Weights = table.freeze({
    Front = table.freeze({Shield = 30, Spike = 30, Egg = 35, Pod = 5}),
    Middle = table.freeze({
        Shield = 14,
        Spike = 20,
        Egg = 14,
        Serum = 14,
        Pod = 18,
        Drilla = 12,
        Skywhale = 8,
    }),
    Back = table.freeze({
        Shield = 4,
        Spike = 8,
        Egg = 4,
        Serum = 26,
        Pod = 16,
        Drilla = 18,
        Skywhale = 24,
    }),
    Bot = table.freeze({
        Shield = 12,
        Serum = 12,
        Skywhale = 8,
        Spike = 24,
        Pod = 18,
        Drilla = 12,
        Egg = 14,
    }),
})
u11.Attributes = table.freeze({
    Enabled = "RacePowerUps",
    Item = "RacePowerUp",
    Uses = "RacePowerUpUses",
    RollEndsAt = "RacePowerUpRollEndsAt",
    Effect = "RacePowerUpEffect",
    EffectEndsAt = "RacePowerUpEffectEndsAt",
    StunEndsAt = "RacePowerUpStunEndsAt",
    BoxReadyAt = "RaceBoxReadyAt",
    BoardPlace = "RaceBoardPlace",
    BotAvatar = "RaceBotAvatar",
})
u11.Tuning = table.freeze({
    RollSeconds = 2.4,
    BoxRespawnSeconds = 2.5,
    BoxReach = 22,
    BoxLeadSeconds = 0.5,
    BoxTrailSeconds = 0.15,
    BoxLeadSpeedCap = 2.5,
    PickupInterval = 0.2,
    UseCooldown = 0.35,
    SerumScale = 1.75,
    SkywhaleScale = 2.25,
    SkywhaleHeight = 7,
    SpikeSpeed = 2.6,
    SpikeSeconds = 2.8,
    SpikeRadius = 9,
    SpikeScale = 1.4,
    SpikeGrace = 0.6,
    SpikeStun = 1.2,
    PodSpeed = 2.4,
    PodRange = 50,
    PodSeconds = 7,
    PodRadius = 6,
    PodHeight = 3.5,
    PodStun = 1.5,
    DrillaSpeed = 3.4,
    DrillaBehind = 40,
    DrillaLead = 0.8,
    DrillaWarnSeconds = 0.8,
    DrillaRadius = 9,
    DrillaStun = 1.7,
    DrillaSeconds = 14,
    EggBehind = 8,
    EggRadius = 5.5,
    EggGrace = 0.8,
    EggSeconds = 45,
    EggStun = 2,
    EggSpinSeconds = 0.8,
})
u11.Assets = ReplicatedStorage.Assets.MountRace.PowerUps

function u11.Pool(a1) -- Line: 150 -- upvalues: u11 (val) -- types: a1: number
    if a1 <= 0.2 then
        return u11.Weights.Front
    end
    if a1 <= 0.6 then
        return u11.Weights.Middle
    end
    return u11.Weights.Back
end

function u11.BoxAttribute(a1) -- Line: 159 -- upvalues: u11 (val) -- types: a1: string?
    if a1 ~= nil then
        return (("%*_%*"):format(u11.Attributes.BoxReadyAt, a1))
    end
    return u11.Attributes.BoxReadyAt
end

function u11.Params(a1) -- Line: 163 -- types: a1: userdata
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = {a1.Track, a1.Map}
    v1.RespectCanCollide = true
    return v1
end

function u11.SpikePath(a1, a2, a3, a4) -- Line: 171
    -- upvalues: u11 (val), Workspace (val)
    local Unit_2, v1, v2
    local v3 = Vector3.new(a2.X, 0, a2.Z)
    local Unit = if not (0.001 < v3.Magnitude) then Vector3.new(0, 0, 1) else v3.Unit
    v3 = a3 * 0.03333333333333333
    local v4 = a1
    local v5 = {a1}
    local v6 = 0
    local v7 = 0
    local v8 = a4
    for i = 1, (math.floor(u11.Tuning.SpikeSeconds / 0.03333333333333333)) do
        v1 = Workspace:Raycast(v4, Unit * (v3 + 1.5), v8)
        if v1 ~= nil and v1.Normal.Y < 0.6 then
            v2 = Vector3.new(v1.Normal.X, 0, v1.Normal.Z)
            if not (v6 >= 2) and not (v2.Magnitude < 0.001) then
                v6 = v6 + 1
                Unit_2 = v2.Unit
                Unit = (Unit - Unit_2 * 2 * Unit:Dot(Unit_2)).Unit
                v1 = v4 + Unit * v3
                v2 = Workspace:Raycast(v1 + Vector3.new(0, 7, 0), Vector3.new(-0, -26, -0), v8)
                if v2 ~= nil then
                    v7 = 0
                    v1 = Vector3.new(v1.X, v2.Position.Y + 1.8, v1.Z)
                    continue
                end
                v7 = v7 + 1
                v1 = v1 - Vector3.new(0, 1, 0) * v3 * 0.6 * v7
                if not (v7 > 8) then
                    continue
                end
                table.insert(v5, v1)
                return v5
            end
            table.insert(v5, v1.Position - Unit * 1.5)
            return v5
        end
        v1 = v4 + Unit * v3
        v2 = Workspace:Raycast(v1 + Vector3.new(0, 7, 0), Vector3.new(-0, -26, -0), v8)
        if v2 ~= nil then
            v1 = Vector3.new(v1.X, v2.Position.Y + 1.8, v1.Z)
        else
            v7 = v7 + 1
            v1 = v1 - Vector3.new(0, 1, 0) * v3 * 0.6 * v7
            if v7 > 8 then
                table.insert(v5, v1)
                return v5
            end
        end
        table.insert(v5, v1)
    end
    return v5
end

function u11.PathAt(a1, a2) -- Line: 210 -- types: a1: table, a2: number
    local v1 = a2 / 0.03333333333333333 + 1
    local v2 = math.floor(v1)
    if #a1 <= v2 then
        return a1[#a1], true
    end
    if v2 < 1 then
        return a1[1], false
    end
    return (a1[v2]:Lerp(a1[v2 + 1], v1 - v2)), false
end

return table.freeze(u11)