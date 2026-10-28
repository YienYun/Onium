-- Script path: ReplicatedStorage.Client.ToolGameplayGuard
-- Decompile time: 4.63 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local PointInBox = require(ReplicatedStorage.Shared.Utils.PointInBox)
local u58 = Color3.fromRGB(255, 70, 70)
local RodAttribute = GhostDogQuest.RodAttribute
local SAFE_ZONE = Constants.TAGS_MAP.Gameplay.SAFE_ZONE
local Inside = HalloweenDimension.PlayerAttributes.Inside
local LocalPlayer = Players.LocalPlayer
local World = Workspace.World
assert(World:IsA("Folder"), "expected a Folder at Workspace.World")
local Areas = World.Areas
assert(Areas:IsA("Folder"), "expected a Folder at Workspace.World.Areas")
local SeparationLine = Areas.SeparationLine
assert(SeparationLine:IsA("BasePart"), "expected a BasePart at Workspace.World.Areas.SeparationLine")
local u90 = {}

local function footPosition(a1) -- Line: 44 -- upvalues: Player (val) -- types: a1: userdata
    local v1 = Player.FindRootPart(a1)
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1.Position
    end
    return nil
end

local function isGear(a1) -- Line: 51 -- upvalues: RodAttribute (val) -- types: a1: userdata?
    if a1 ~= nil and a1:GetAttribute(RodAttribute) == true then
        return false
    end
    local v1 = true
    if a1 ~= nil then
        v1 = typeof((a1:GetAttribute("GearName"))) == "string"
    end
    return v1
end

local function isObbying(a1) -- Line: 58 -- upvalues: Workspace (val) -- types: a1: userdata
    if not Workspace:GetAttribute("Event_MonsterEvent") then
        return false
    end
    local Character = a1.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return false
    end
    return -268 < HumanoidRootPart.Position.Z
end

local function refuse() -- Line: 72 -- upvalues: Toast (val), u58 (val)
    Toast.Show({Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true, Color = u58})
end

function u90.IsInsideArena(a1) -- Line: 81
    -- upvalues: Player (val), Inside (val), GuardAreaGeometry (val), SeparationLine (val)
    local v1 = Player.FindRootPart(a1)
    local Position = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else v1.Position
    v1 = false
    if Position ~= nil then
        v1 = true
        if a1:GetAttribute(Inside) ~= true then
            v1 = GuardAreaGeometry.IsPastLine(SeparationLine, Position)
        end
    end
    return v1
end

function u90.IsLocalInsideArena() -- Line: 91 -- upvalues: u90 (val), LocalPlayer (val)
    return u90.IsInsideArena(LocalPlayer)
end

function u90.IsInsideSafeZone(a1) -- Line: 95
    -- upvalues: Player (val), CollectionService (val), SAFE_ZONE (val), Workspace (val), PointInBox (val)
    local Position, v1, v2
    local v3 = Player.FindRootPart(a1)
    local Tagged = if (if v3 == nil then nil else if not v3:IsA("BasePart") then nil else v3.Position) ~= nil then CollectionService:GetTagged(SAFE_ZONE) else {}
    local v4 = 1
    while v4 <= #Tagged do
        v1 = Tagged[v4]
        v4 = v4 + 1
        v2 = v1:IsA("BasePart") and v1:IsDescendantOf(Workspace)
        if v2 and PointInBox(v1.CFrame, v1.Size, Position) then
            return true
        end
    end
    return false
end

function u90.AllowsLocalUse(a1) -- Line: 114
    -- upvalues: LocalPlayer (val), RodAttribute (val), u90 (val), Toast (val), u58 (val), Workspace (val)
    if not LocalPlayer:GetAttribute("InBossArena")
        and not LocalPlayer:GetAttribute("InScrambleArena")
        and not LocalPlayer:GetAttribute("InPumpkinArena") then
        local v1
        if a1 == nil or a1:GetAttribute(RodAttribute) ~= true then
            v1 = true
            if a1 ~= nil then
                v1 = typeof((a1:GetAttribute("GearName"))) == "string"
            end
        else
            v1 = false
        end
        local v2 = not v1 or u90.IsLocalInsideArena() and not u90.IsInsideSafeZone(LocalPlayer)
        if not v2 then
            Toast.Show({Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true, Color = u58})
        end
        if Workspace:GetAttribute("Event_MonsterEvent") then
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            v1 = if HumanoidRootPart then -268 < HumanoidRootPart.Position.Z else false
        else
            v1 = false
        end
        if v1 then
            v2 = false
            Toast.Show({Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true, Color = u58})
        end
        return v2
    end
    return true
end

return u90