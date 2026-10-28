-- Script path: ReplicatedStorage.Controllers.GUI.PetListController.PetPenCapacityGuidanceController
-- Decompile time: 4.62 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Save = require(ReplicatedStorage.Shared.Save)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u48 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local LocalPlayer = Players.LocalPlayer
local v1 = GUI.ActivePets()
local v2 = Hud.Find("PetsButton")
local EquipBest = v1.Frame.EquipBest
local Badge = if v2 == nil then nil else v2:FindFirstChild("Badge")
local u69 = EquipBest:FindFirstChild("Badge")
local u70 = nil
local u71 = nil
assert(v1:IsA("ScreenGui"), "PlayerGui.ActivePets must be a ScreenGui")
assert(EquipBest:IsA("GuiButton"), "ActivePets.Frame.EquipBest must be a GuiButton")
local v3 = {}

local function stopBadgePulse(a1, a2) -- Line: 55
    -- upvalues: EnsureUIScale (val)
    if a2 ~= nil then
        a2:Cancel()
        a2:Destroy()
    end
    if a1 == nil then
        return nil
    end
    local v1 = EnsureUIScale(a1)
    v1.Scale = 1
    a1.Visible = false
    return nil
end

local function startBadgePulse(a1, a2) -- Line: 68
    -- upvalues: EnsureUIScale (val), TweenService (val), u48 (val)
    if a1 == nil then
        return nil
    end
    a1.Visible = true
    if a2 ~= nil then
        return a2
    end
    local v1 = EnsureUIScale(a1)
    v1.Scale = 0.8
    local v2 = TweenService:Create(v1, u48, {Scale = 1.2})
    v2:Play()
    return v2
end

local function refresh() -- Line: 84
    -- upvalues: Save (val), LocalPlayer (val), u70 (ref), startBadgePulse (val), Badge (val), EnsureUIScale (val)
    -- upvalues: u71 (ref), u69 (val)
    local v1, v2, v3
    local v4 = Save.Await(LocalPlayer)
    local PetPenCapacityGuidance = if v4 == nil then nil else v4.PetPenCapacityGuidance
    local Triggered = false
    if PetPenCapacityGuidance ~= nil then
        Triggered = PetPenCapacityGuidance.Triggered and not PetPenCapacityGuidance.PetsTabAcknowledged
    end
    local Triggered_2 = false
    if PetPenCapacityGuidance ~= nil then
        Triggered_2 = PetPenCapacityGuidance.Triggered and not PetPenCapacityGuidance.EquipBestAcknowledged
    end
    if not Triggered then
        v1 = Badge
        v2 = u70
        if v2 ~= nil then
            v2:Cancel()
            v2:Destroy()
        end
        if v1 ~= nil then
            v3 = EnsureUIScale(v1)
            v3.Scale = 1
            v1.Visible = false
        end
        u70 = nil
    else
        startBadgePulse(Badge, u70)
    end
    if Triggered_2 then
        u71 = startBadgePulse(u69, u71)
        return
    end
    v1 = u69
    v2 = u71
    if v2 ~= nil then
        v2:Cancel()
        v2:Destroy()
    end
    if v1 ~= nil then
        v3 = EnsureUIScale(v1)
        v3.Scale = 1
        v1.Visible = false
    end
    u71 = nil
end

function v3.AcknowledgePetsBadge() -- Line: 108
    -- upvalues: Badge (val), u70 (ref), EnsureUIScale (val), TryCall (val), AssetRoster (val), refresh (val)
    if Badge ~= nil and Badge.Visible then
        local v1 = Badge
        local v2 = u70
        if v2 ~= nil then
            v2:Cancel()
            v2:Destroy()
        end
        if v1 ~= nil then
            local v3 = EnsureUIScale(v1)
            v3.Scale = 1
            v1.Visible = false
        end
        u70 = nil
        task.spawn(function() -- Line: 113 -- upvalues: TryCall (upval), AssetRoster (upval), refresh (upval)
            local v1, v2 = TryCall(AssetRoster.AckPetsBadge)
            if not v1 or v2 ~= true then
                refresh()
            end
        end)
        return
    end
end

function v3.AcknowledgeEquipBestBadge() -- Line: 121
    -- upvalues: u69 (val), u71 (ref), EnsureUIScale (val), TryCall (val), AssetRoster (val), refresh (val)
    if u69 ~= nil and u69.Visible then
        local v1 = u69
        local v2 = u71
        if v2 ~= nil then
            v2:Cancel()
            v2:Destroy()
        end
        if v1 ~= nil then
            local v3 = EnsureUIScale(v1)
            v3.Scale = 1
            v1.Visible = false
        end
        u71 = nil
        task.spawn(function() -- Line: 126 -- upvalues: TryCall (upval), AssetRoster (upval), refresh (upval)
            local v1, v2 = TryCall(AssetRoster.AckEquipBestBadge)
            if not v1 or v2 ~= true then
                refresh()
            end
        end)
        return
    end
end

function v3.Initialize() -- Line: 134 -- upvalues: Save (val), refresh (val)
    (Save.Watch("PetPenCapacityGuidance")):Connect(refresh)
    task.spawn(refresh)
end

return v3