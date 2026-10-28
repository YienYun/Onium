-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.ChaseView
-- Decompile time: 6.61 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local RunHit = require(script.Parent.RunHit)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Target = HalloweenDimension.Ghosts.Target
local u50 = Color3.fromRGB(120, 255, 160)
local u51 = {ExposureCompensation = 0}
u51.ColorCorrection = {
    Saturation = -0.3,
    Contrast = 0.12,
    Brightness = 0.03,
    Enabled = true,
    TintColor = Color3.fromRGB(222, 204, 255),
}
u51.Atmosphere = {
    Density = 0.5,
    Haze = 2.6,
    Glare = 0,
    Offset = 0,
    Color = Color3.fromRGB(96, 64, 128),
    Decay = Color3.fromRGB(52, 28, 70),
}
local u69 = {}
u69.__index = u69

local function flatDistance(a1, a2) -- Line: 86 -- types: a1: vector, a2: vector
    return Vector2.new(a1.X - a2.X, a1.Z - a2.Z).Magnitude
end

local function easeOut(a1) -- Line: 90 -- types: a1: number
    return 1 - (1 - a1) ^ 3
end

local function rootPart() -- Line: 94 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function safeDistance(a1, a2) -- Line: 100 -- types: a1: userdata, a2: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size * 0.5
    local v3 = math.max((math.abs(v1.X)) - v2.X, 0)
    local v4 = math.max((math.abs(v1.Z)) - v2.Z, 0)
    return (math.sqrt(v3 * v3 + v4 * v4))
end

local function findGhost(a1) -- Line: 108 -- upvalues: Target (val), LocalPlayer (val) -- types: a1: table
    local Ghost = a1.Ghost
    if Ghost ~= nil and (Ghost:GetAttribute(Target)) == LocalPlayer.UserId then
        return Ghost
    end
    a1.Ghost = nil
    for i, j in a1.Ghosts:GetChildren() do
        if j:IsA("Model") and (j:GetAttribute(Target)) == LocalPlayer.UserId then
            a1.Ghost = j
            return j
        end
    end
    return nil
end

local function update(a1, a2) -- Line: 123
    -- upvalues: LocalPlayer (val), findGhost (val)
    local v1
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if (if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
        return
    end
    local v2 = findGhost(a1)
    local v3 = 0
    if v2 ~= nil then
        local Position = v2:GetPivot().Position
        local Position_2 = v1.Position
        v3 = math.clamp(1 - Vector2.new(Position.X - Position_2.X, Position.Z - Position_2.Z).Magnitude / 90, 0, 1)
    end
    a1.Danger = a1.Danger + (v3 - a1.Danger) * math.min(a2 * 6, 1)
    local Danger_2 = a1.Danger
    local Ui = a1.Ui
    Ui.Vignette.ImageTransparency = 1 - Danger_2 * 0.5
    local Distance = Ui.Distance
    local SafeZone = a1.SafeZone
    local v4 = SafeZone.CFrame:PointToObjectSpace(v1.Position)
    local v5 = SafeZone.Size * 0.5
    local v6 = math.max((math.abs(v4.X)) - v5.X, 0)
    local v7 = math.max((math.abs(v4.Z)) - v5.Z, 0)
    Distance.Text = ("%* studs to safety"):format((math.floor((math.sqrt(v6 * v6 + v7 * v7)))))
    local Near = a1.Near
    if Near ~= nil then
        Near.Volume = (Danger_2 * 0.88 + 0.12) * 0.75
    end
end

function u69.new(a1, a2, a3, a4) -- Line: 150
    -- upvalues: HalloweenDimension (val), Trove (val), LightingController (val), u51 (val), RunHit (val), Audio (val)
    -- upvalues: RunService (val), update (val), u69 (val)
    local Zones = a1:FindFirstChild("Zones")
    local SafeZone = if Zones == nil then nil else Zones:FindFirstChild("SafeZone")
    local v1 = a1:FindFirstChild(HalloweenDimension.Ghosts.Folder)
    local v2 = false
    if SafeZone ~= nil then
        v2 = SafeZone:IsA("BasePart")
    end
    assert(v2, "Halloween map is missing Zones.SafeZone")
    local v3 = ("Halloween map is missing %*"):format(HalloweenDimension.Ghosts.Folder)
    assert(v1 ~= nil, v3)
    local v4 = Trove.new()
    v2 = v4:Extend()
    local u50 = {
        Danger = 0,
        Finished = false,
        SafeZone = SafeZone,
        Ghosts = v1,
        Ui = a2,
        Alert = a3,
        Beacon = a4,
        Trove = v4,
        Live = v2,
    }
    a2.Chase.Visible = true
    if a4 ~= nil then
        a4.Enabled = true
    end
    LightingController.SetLayer("HalloweenGhostChase", u51, 170, 0.35)
    local Parent = a2.Chase.Parent
    RunHit.Play(if Parent == nil then nil else Parent:FindFirstChild("RunHit"), v2, a2.Chase)
    Audio.Play("rbxassetid://92254600060653", script, {Volume = 0.7})
    local v5 = Audio.Play("rbxassetid://113016224604939", script, {Looped = true, Volume = 0})
    if v5 ~= nil then
        u50.Near = v5
        v4:Add(v5)
    end
    v2:Connect(RunService.RenderStepped, function(a1) -- Line: 188 -- upvalues: update (upval), u50 (val) -- types: a1: number
        update(u50, a1)
    end)
    update(u50, 0)
    return (setmetatable(u50, u69))
end

function u69.Finish(a1, a2) -- Line: 196
    -- upvalues: LightingController (val), TweenService (val), u50 (val), Audio (val), RunService (val)
    if a1.Finished then
        return
    end
    a1.Finished = true
    a1.Live:Destroy()
    local Ui = a1.Ui
    Ui.Chase.Visible = false
    if a1.Beacon ~= nil then
        a1.Beacon.Enabled = false
    end
    LightingController.ClearLayer("HalloweenGhostChase", 0.6)
    TweenService:Create(Ui.Vignette, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
    if a2 then
        a1.Alert("EGG SECURED!", u50, 2)
        Audio.Play("rbxassetid://115572591755603", script, {Volume = 0.6})
        Audio.Play("rbxassetid://71759553024274", script, {Volume = 0.45, PlaybackSpeed = 1.1})
    end
    local Near = a1.Near
    local Volume = if Near == nil then 0 else Near.Volume
    local u56 = os.clock()
    a1.Trove:Connect(RunService.RenderStepped, function() -- Line: 220 -- upvalues: u56 (val), Near (val), Volume (val), a1 (val)
        local v1 = math.clamp((os.clock() - u56) / 0.9, 0, 1)
        if Near ~= nil then
            Near.Volume = Volume * (1 - (1 - (1 - v1) ^ 3))
        end
        if v1 >= 1 then
            a1.Trove:Destroy()
        end
    end)
end

function u69:Destroy() -- Line: 231 -- upvalues: LightingController (val) -- types: self: table
    self.Finished = true
    self.Trove:Destroy()
    LightingController.ClearLayer("HalloweenGhostChase", 0.6)
    self.Ui.Chase.Visible = false
    self.Ui.Vignette.ImageTransparency = 1
    if self.Beacon ~= nil then
        self.Beacon.Enabled = false
    end
end

return u69