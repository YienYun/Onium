-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.StealingSystem
-- Decompile time: 5.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CarryRunBackEffects = require(script.Parent.Parent.Parent.Parent.AreaEggsController.CarryRunBackEffects)
local Player = require(ReplicatedStorage.Shared.Player)
require(ReplicatedStorage.Packages.Trove)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local LocalPlayer = Players.LocalPlayer
local u38 = nil
local u39 = false

local function raidMap() -- Line: 42 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("SammyEventMap")
end

local function returnPoint() -- Line: 46 -- upvalues: Workspace (val)
    local SammyEventMap = Workspace:FindFirstChild("SammyEventMap")
    local LaserGun = if not SammyEventMap then nil else SammyEventMap:FindFirstChild("LaserGun")
    local v1 = if not LaserGun then nil else LaserGun:FindFirstChild("ReturnZone")
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function nearestSteal() -- Line: 54 -- upvalues: Workspace (val), Player (val), LocalPlayer (val)
    local SammyEventMap = Workspace:FindFirstChild("SammyEventMap")
    local v1 = Player.FindRootPart(LocalPlayer)
    if SammyEventMap ~= nil and v1 ~= nil and v1:IsA("BasePart") then
        local Magnitude, Parent, StealBrainrot
        local v2 = nil
        local v3 = (1 / 0)
        for i, j in SammyEventMap:GetChildren() do
            if j:IsA("Model") then
                StealBrainrot = j:FindFirstChild("StealBrainrot", true)
                Parent = if StealBrainrot == nil then nil else StealBrainrot.Parent
                if Parent ~= nil and Parent:IsA("BasePart") then
                    Magnitude = (Parent.Position - v1.Position).Magnitude
                    if Magnitude < v3 then
                        v2 = Parent
                    end
                end
            end
        end
        return v2
    end
    return nil
end

local function cageTarget() -- Line: 82 -- upvalues: Workspace (val)
    local SammyEventMap = Workspace:FindFirstChild("SammyEventMap")
    local CagedBen = if not SammyEventMap then nil else SammyEventMap:FindFirstChild("CagedBen")
    local v1 = if not CagedBen then nil else CagedBen:FindFirstChild("Hitbox")
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function dropBeam() -- Line: 89 -- upvalues: u38 (ref), TutorialBeam (val)
    local v1 = u38
    if v1 ~= nil then
        u38 = nil
        TutorialBeam.Destroy(v1)
    end
end

local function refresh() -- Line: 97
    -- upvalues: LocalPlayer (val), Workspace (val), nearestSteal (val), u38 (ref), TutorialBeam (val)
    local v1, v2
    if LocalPlayer:GetAttribute("SammyCarrying") == nil then
        v1 = nearestSteal()
        if not v1 then
            local SammyEventMap_2 = Workspace:FindFirstChild("SammyEventMap")
            local CagedBen = if not SammyEventMap_2 then nil else SammyEventMap_2:FindFirstChild("CagedBen")
            v2 = if not CagedBen then nil else CagedBen:FindFirstChild("Hitbox")
            v1 = if v2 == nil then nil else if not v2:IsA("BasePart") then nil else v2
        end
    else
        local SammyEventMap = Workspace:FindFirstChild("SammyEventMap")
        local LaserGun = if not SammyEventMap then nil else SammyEventMap:FindFirstChild("LaserGun")
        v2 = if not LaserGun then nil else LaserGun:FindFirstChild("ReturnZone")
        v1 = if v2 == nil then nil else if not v2:IsA("BasePart") then nil else v2
    end
    if v1 == nil then
        v2 = u38
        if v2 ~= nil then
            u38 = nil
            TutorialBeam.Destroy(v2)
        end
        return
    end
    v2 = u38
    if v2 ~= nil then
        TutorialBeam.Retarget(v2, v1)
        return
    end
    TutorialBeam.Attach(v1, {BeamName = "SammyReturnBeam"})
end

local function stopRunBack() -- Line: 115 -- upvalues: u39 (ref), CarryRunBackEffects (val)
    if u39 then
        u39 = false
        CarryRunBackEffects.ForceStop()
    end
end

local function syncRunBack() -- Line: 124 -- upvalues: LocalPlayer (val), u39 (ref), CarryRunBackEffects (val)
    if LocalPlayer:GetAttribute("SammyCarrying") == nil then
        if u39 then
            u39 = false
            CarryRunBackEffects.ForceStop()
        end
        return
    end
    if not u39 then
        u39 = true
        CarryRunBackEffects.ForceStart()
    end
end

local function stop() -- Line: 135 -- upvalues: u38 (ref), TutorialBeam (val), u39 (ref), CarryRunBackEffects (val)
    local v1 = u38
    if v1 ~= nil then
        u38 = nil
        TutorialBeam.Destroy(v1)
    end
    if u39 then
        u39 = false
        CarryRunBackEffects.ForceStop()
    end
end

return {
    Start = function(a1) -- Line: 140
        -- upvalues: u38 (ref), TutorialBeam (val), u39 (ref), CarryRunBackEffects (val), LocalPlayer (val)
        -- upvalues: refresh (val), stop (val), Workspace (val)
        local v1 = u38
        if v1 ~= nil then
            u38 = nil
            TutorialBeam.Destroy(v1)
        end
        if u39 then
            u39 = false
            CarryRunBackEffects.ForceStop()
        end
        a1:Connect(LocalPlayer:GetAttributeChangedSignal("SammyCarrying"), function() -- Line: 142 -- upvalues: refresh (upval), LocalPlayer (upval), u39 (upval), CarryRunBackEffects (upval)
            refresh()
            if LocalPlayer:GetAttribute("SammyCarrying") ~= nil then
                if not u39 then
                    u39 = true
                    CarryRunBackEffects.ForceStart()
                end
                return
            end
            if not u39 then
                return
            end
            u39 = false
            CarryRunBackEffects.ForceStop()
        end)
        a1:Add(stop)
        a1:Add((task.spawn(function() -- Line: 149 -- upvalues: Workspace (upval), refresh (upval)
            Workspace:WaitForChild("SammyEventMap", 10)
            while true do
                refresh()
                task.wait(0.25)
            end
        end)))
    end,
    Stop = stop,
}