-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.AreaNotificationTracker
-- Decompile time: 6.05 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Areas = require(ReplicatedStorage.Data.Areas)
local t = require(ReplicatedStorage.Packages.t)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Player = require(ReplicatedStorage.Shared.Player)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local u55 = {["Cherry Blossom"] = true, [Sakura.AreaDisplay.AreaId] = true}
local LocalPlayer = Players.LocalPlayer
local World = Workspace:WaitForChild("World")
assert(World:IsA("Folder"), "Workspace.World must be a Folder")
local Areas_2 = World.Areas
assert(Areas_2:IsA("Folder"), "Workspace.World.Areas must be a Folder")
local SeparationLine = Areas_2.SeparationLine
assert(SeparationLine:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")
local GuardAreas = Areas_2.GuardAreas
assert(GuardAreas:IsA("Folder"), "Workspace.World.Areas.GuardAreas must be a Folder")
local Build = World:WaitForChild("Build")
local u104 = Areas_2:WaitForChild("CherryBlossom")
assert(u104:IsA("Folder"), "Workspace.World.Areas.CherryBlossom must be a Folder")
local v1 = {}
local u113 = {}
local u114 = nil
local u115 = nil
local u116 = nil

local function rebuildAreaEntries(a1) -- Line: 70
    -- upvalues: u113 (val), GuardAreaGeometry (val), GuardAreas (val), Areas (val), u104 (val), Sakura (val)
    local v1, v2
    table.clear(u113)
    for i, v in ipairs(GuardAreaGeometry.ReadAreaBounds(GuardAreas)) do
        v1 = u113
        v2 = #u113 + 1
        v1[v2] = {
            AreaId = v.AreaId,
            Bounds = v.Bounds,
            Config = Areas.Directory[v.AreaId],
        }
    end
    local Bounds = u104:FindFirstChild("Bounds")
    if Bounds and Bounds:IsA("BasePart") then
        local v3 = u113
        local v4 = #u113 + 1
        v3[v4] = {
            AreaId = Sakura.AreaDisplay.AreaId,
            Bounds = Bounds,
            Config = Sakura.AreaDisplay,
        }
    end
    table.sort(u113, function(a1, a2) -- Line: 90 -- upvalues: Areas (upval) -- types: a1: table, a2: table
        local v1 = Areas.GetProgressionOrder(a1.Config)
        local v2 = Areas.GetProgressionOrder(a2.Config)
        if v1 ~= v2 then
            return v1 < v2
        end
        return a1.AreaId < a2.AreaId
    end)
end

local function isEntryAvailable(a1) -- Line: 102 -- upvalues: u55 (val), Build (val) -- types: a1: table
    if a1.Bounds.Parent and a1.Bounds.Parent:GetAttribute("ZoneHidden") == true then
        return false
    end
    if u55[a1.AreaId] and Build:FindFirstChild("CherryBlossomZone") == nil then
        return false
    end
    return true
end

local function resolveCurrentArea(a1) -- Line: 115
    -- upvalues: t (val), u113 (val), u55 (val), Build (val), GuardAreaGeometry (val)
    t.strict(t.Vector3)(a1)
    for i, v in ipairs(u113) do
        if (if not v.Bounds.Parent then if not u55[v.AreaId] then true else Build:FindFirstChild("CherryBlossomZone") ~= nil else if v.Bounds.Parent:GetAttribute("ZoneHidden") ~= true then if not u55[v.AreaId] then true else Build:FindFirstChild("CherryBlossomZone") ~= nil else false)
            and GuardAreaGeometry.IsWithinFootprint(v.Bounds, a1) then
            return v
        end
    end
    return nil
end

local function isBloomUnlocked() -- Line: 130 -- upvalues: Save (val), SakuraBloomPolicy (val)
    local v1 = Save.IsLoaded()
    return SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
end

local function updateZoneLighting(a1, a2) -- Line: 136
    -- upvalues: u55 (val), Workspace (val), Save (val), SakuraBloomPolicy (val), u116 (ref), LightingController (val)
    local Lighting
    if a2 and u55[a2] then
        if not Workspace:GetAttribute("Event_GreatBloom") then
            a1 = nil
        else
            local v1 = Save.IsLoaded()
            if not SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) then
                a1 = nil
            end
        end
    end
    if (if not a1 then nil else a1.Lighting) == u116 then
        return
    end
    u116 = Lighting
    if Lighting == nil then
        LightingController.ClearLayer("ZoneLighting", 2)
        return
    end
    LightingController.SetLayer("ZoneLighting", Lighting, 25, 2)
end

local function step(a1) -- Line: 160
    -- upvalues: Player (val), LocalPlayer (val), u114 (ref), updateZoneLighting (val), GuardAreaGeometry (val)
    -- upvalues: SeparationLine (val), u115 (ref), resolveCurrentArea (val), Players (val), Areas (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 == nil then
        u114 = nil
        updateZoneLighting(nil)
        return
    end
    assert(v1:IsA("BasePart"), (("%* must be a BasePart"):format((v1:GetFullName()))))
    if not GuardAreaGeometry.IsPastLine(SeparationLine, v1.Position) then
        u114 = nil
        u115 = nil
        updateZoneLighting(nil)
        return
    end
    local v2 = resolveCurrentArea(v1.Position)
    if v2 == nil then
        u114 = nil
        updateZoneLighting(nil)
        return
    end
    Players.LocalPlayer:SetAttribute("AreaId", v2.AreaId)
    updateZoneLighting(v2.Config, v2.AreaId)
    if v2.AreaId == u114 then
        return
    end
    u114 = v2.AreaId
    v1 = Areas.GetProgressionOrder(v2.Config)
    local v3 = u115
    u115 = v1
    if v3 ~= nil and v1 <= v3 then
        return
    end
    a1(v2.Config, v2.AreaId)
end

function v1.Start(a1) -- Line: 206
    -- upvalues: t (val), rebuildAreaEntries (val), GuardAreas (val), RunService (val), step (val)
    t.strict(t.callback)(a1)
    rebuildAreaEntries(nil)
    GuardAreas.ChildAdded:Connect(rebuildAreaEntries)
    GuardAreas.ChildRemoved:Connect(rebuildAreaEntries)
    local u23 = 0
    RunService.Heartbeat:Connect(function(a1_2) -- Line: 214 -- upvalues: u23 (ref), step (upval), a1 (val) -- types: a1_2: number
        u23 = u23 + a1_2
        if u23 < 0.1 then
            return
        end
        u23 = 0
        step(a1)
    end)
end

return v1