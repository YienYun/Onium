-- Script path: ReplicatedStorage.Data.MountRace
-- Decompile time: 3.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MountRace = ReplicatedStorage.Assets.MountRace
local u7 = {
    TrackTag = "RaceTrack",
    MountTag = "RaceMount",
    MountName = "RaceMount",
    HeatsFolder = "RaceHeats",
    HeatWaitSeconds = 10,
    RaceNameAttribute = "RaceName",
    CutsceneAttribute = "RaceCutscenePlaying",
    OutroAttribute = "RaceEventOutro",
    RandomColorAttribute = "RandomColor",
}
u7.AmbientEvents = table.freeze({
    AdminAbuse = true,
    AdminTreadmill = true,
    ButterflyBloom = true,
    Countdown = true,
    EarningsBoost = true,
    EggLuckBoost = true,
    EggSizeBoost = true,
    GreatBloom = true,
    MutationBoost = true,
    RaceRally = true,
    RecoveryEvent = true,
    RiftOpen = true,
    SpeedBoost = true,
    TrainEvent = true,
})
u7.Phase = table.freeze({Joining = "Joining", Countdown = "Countdown", Racing = "Racing", Results = "Results"})
u7.TrackAttributes = table.freeze({
    Phase = "RacePhase",
    JoinEndsAt = "RaceJoinEndsAt",
    GoAt = "RaceGoAt",
    EndsAt = "RaceEndsAt",
    Laps = "RaceLaps",
    WaitForOthers = "RaceWaitForOthers",
})
u7.PlayerAttributes = table.freeze({
    RaceId = "RaceId",
    Heat = "RaceHeat",
    GridFrame = "RaceGridFrame",
    Place = "RacePlace",
    Lap = "RaceLap",
    FinishPlace = "RaceFinishPlace",
    FinishTime = "RaceFinishTime",
})
u7.ComponentTags = table.freeze({
    BoostPad = "RaceBoostPad",
    SlowPad = "RaceSlowPad",
    Jump = "RaceJump",
    LoopTheLoop = "RaceLoop",
    PowerUpSpawn = "RacePowerUpSpawn",
})
u7.RandomColors = table.freeze({
    Color3.fromRGB(196, 76, 65),
    Color3.fromRGB(51, 88, 130),
    Color3.fromRGB(213, 91, 34),
    Color3.fromRGB(123, 0, 123),
    Color3.fromRGB(52, 142, 64),
    Color3.fromRGB(255, 176, 0),
    Color3.fromRGB(255, 102, 204),
    (Color3.fromRGB(99, 226, 255)),
})
u7.RiderAnimations = table.freeze({Ride = "rbxassetid://77661864641148", Jump = "rbxassetid://74199050307163"})
u7.Mounts = MountRace.Mounts
u7.Effects = MountRace.Effects
u7.Sounds = ReplicatedStorage.Assets.Sounds.MountRace

function u7.RiderFrame(a1, a2) -- Line: 168 -- types: a2: userdata
    local HumanoidRootPart = a1.HumanoidRootPart
    return a2 * CFrame.new(0, 0.5 - ((HumanoidRootPart.CFrame:ToObjectSpace(a1.Hitbox.CFrame)).Y - a1.Hitbox.Size.Y / 2), 0) * HumanoidRootPart.Seat.CFrame
end

function u7.IsInsidePart(a1, a2, a3) -- Line: 176 -- types: a1: userdata, a2: vector, a3: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size / 2 + a3
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = false
        if (math.abs(v1.Y)) <= v2.Y then
            v3 = (math.abs(v1.Z)) <= v2.Z
        end
    end
    return v3
end

function u7.NumberAttribute(a1, a2, a3) -- Line: 183 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

function u7.StateOf(a1, a2) -- Line: 188 -- upvalues: u7 (val) -- types: a1: userdata, a2: string?
    if a2 == nil then
        return a1
    end
    local v1 = a1:WaitForChild(u7.HeatsFolder, u7.HeatWaitSeconds)
    if v1 ~= nil then
        return (v1:WaitForChild(a2, u7.HeatWaitSeconds))
    end
    return nil
end

function u7.HeatOf(a1) -- Line: 196 -- upvalues: u7 (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(u7.PlayerAttributes.Heat)
    if type(Attribute) == "string" then
        return Attribute
    end
    return nil
end

function u7.InOtherHeat(a1, a2, a3) -- Line: 201 -- upvalues: u7 (val) -- types: a1: userdata, a2: string, a3: string?
    if a1:GetAttribute(u7.PlayerAttributes.RaceId) ~= a2 then
        return false
    end
    return u7.HeatOf(a1) ~= a3
end

function u7.FormatPlace(a1) -- Line: 208 -- types: a1: number
    local v1 = a1 % 100
    return (("%*%*"):format(
        a1,
        if not (v1 >= 11) then if a1 % 10 ~= 1 then if a1 % 10 ~= 2 then if a1 % 10 ~= 3 then "th" else "rd" else "nd" else "st" else if not (v1 <= 13) then if a1 % 10 ~= 1 then if a1 % 10 ~= 2 then if a1 % 10 ~= 3 then "th" else "rd" else "nd" else "st" else "th"
    ))
end

function u7.FormatTime(a1) -- Line: 218 -- types: a1: number
    return string.format("%d:%04.1f", a1 // 60, a1 % 60)
end

return table.freeze(u7)