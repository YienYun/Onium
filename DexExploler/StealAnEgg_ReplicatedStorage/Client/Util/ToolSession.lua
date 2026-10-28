-- Script path: ReplicatedStorage.Client.Util.ToolSession
-- Decompile time: 3.66 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}
local LocalPlayer = Players.LocalPlayer

local function accepted(a1, a2) -- Line: 31 -- types: a1: table, a2: userdata
    return a2:IsA("Tool") and table.find(a1.accepts, (a2:GetAttribute("GearName"))) ~= nil
end

local function loosen(a1) -- Line: 36 -- types: a1: table
    local grip = a1.grip
    if grip then
        grip:Clean()
    end
end

local function stow(a1) -- Line: 43 -- types: a1: table
    local grip = a1.grip
    if grip then
        grip:Clean()
    end
    a1.grip = nil
    local onUnequipped = a1.hooks.onUnequipped
    if onUnequipped then
        onUnequipped()
    end
    a1.held = nil
end

local function wield(a1, a2) -- Line: 55
    -- upvalues: Trove (val), ToolCooldown (val), ToolGameplayGuard (val), LocalPlayer (val)
    local grip = a1.grip
    if grip then
        grip:Clean()
    end
    a1.grip = Trove.new()
    a1.held = a2
    ToolCooldown.PrimeTool(a2)
    local onEquipped = a1.hooks.onEquipped
    if onEquipped then
        onEquipped(a2)
    end
    local grip_2 = a1.grip
    if grip_2 then
        if a1.hooks.onActivated then
            grip_2:Add((a2.Activated:Connect(function() -- Line: 71 -- upvalues: a1 (val), ToolGameplayGuard (upval), a2 (val)
                local onActivated = a1.hooks.onActivated
                if onActivated and ToolGameplayGuard.AllowsLocalUse(a2) then
                    onActivated(a2)
                end
            end)))
        end
        grip_2:Add((LocalPlayer.CharacterRemoving:Connect(function() -- Line: 79 -- upvalues: a1 (val)
            local grip = a1.grip
            if grip then
                grip:Clean()
            end
        end)))
    end
end

local function onGearChange(a1, a2, a3) -- Line: 83 -- types: a1: table, a2: userdata, a3: function
    local v1 = a2:IsA("Tool") and table.find(a1.accepts, (a2:GetAttribute("GearName"))) ~= nil
    if v1 then
        a3(a1, a2)
    end
end

function v1.GearNameOf(a1) -- Line: 89 -- types: a1: userdata?
    if a1 then
        return (a1:GetAttribute("GearName"))
    end
    return nil
end

function v1.Follow(a1, a2) -- Line: 95 -- upvalues: wield (val), stow (val) -- types: a1: table, a2: userdata
    a2.ChildAdded:Connect(function(a1_2) -- Line: 96 -- upvalues: a1 (val), wield (upval)
        local v1 = a1
        local v2 = wield
        local v3 = a1_2:IsA("Tool") and table.find(v1.accepts, (a1_2:GetAttribute("GearName"))) ~= nil
        if v3 then
            v2(v1, a1_2)
        end
    end)
    a2.ChildRemoved:Connect(function(a1_2) -- Line: 97 -- upvalues: a1 (val), stow (upval)
        local v1 = a1
        local v2 = a1_2:IsA("Tool") and table.find(v1.accepts, (a1_2:GetAttribute("GearName"))) ~= nil
        if v2 then
            local grip = v1.grip
            if grip then
                grip:Clean()
            end
            v1.grip = nil
            local onUnequipped = v1.hooks.onUnequipped
            if onUnequipped then
                onUnequipped()
            end
            v1.held = nil
        end
    end)
    local Tool = a2:FindFirstChildWhichIsA("Tool")
    if Tool then
        local v1 = Tool:IsA("Tool") and table.find(a1.accepts, (Tool:GetAttribute("GearName"))) ~= nil
        if v1 then
            wield(a1, Tool)
        end
    end
end

function v1.Shut(a1) -- Line: 105 -- types: a1: table
    a1.spawns:Clean()
    local grip = a1.grip
    if grip then
        grip:Clean()
    end
end

return v1