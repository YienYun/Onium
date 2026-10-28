-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Aim
-- Decompile time: 6.96 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BanjoCricketFlags = require(ReplicatedStorage.Shared.Flags.BanjoCricketFlags)
local Gears = require(ReplicatedStorage.Data.Gears)
local Mushrooms = require(script.Parent.Mushrooms)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u47 = nil
local u48 = nil
local u49 = 0
local v1 = {}

local function distanceToBox(a1, a2) -- Line: 41 -- types: a1: userdata, a2: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size / 2
    return (v1 - (v1:Max(-v2)):Min(v2)).Magnitude
end

local function canHit(a1) -- Line: 47 -- upvalues: Gears (val) -- types: a1: userdata
    if a1:GetAttribute("IsBat") == true then
        return true
    end
    local Attribute = a1:GetAttribute("GearName")
    local v1 = if typeof(Attribute) ~= "string" then nil else Gears.Directory[Attribute]
    local v2 = false
    if v1 ~= nil then
        v2 = v1.ToolController == "Slap"
    end
    return v2
end

local function pick(a1) -- Line: 58 -- upvalues: Mushrooms (val), u47 (ref) -- types: a1: userdata
    local Anchor, Magnitude, v1, v2, v3, v4
    local v5 = a1.CFrame.LookVector * Vector3.new(1, 0, 1)
    if v5.Magnitude < 0.001 then
        return nil
    end
    local Index = nil
    local v6 = (1 / 0)
    local v7 = a1
    for i, j in Mushrooms.Targets() do
        Anchor = j.Anchor
        v3 = Anchor.CFrame:PointToObjectSpace(v7.Position)
        v4 = Anchor.Size / 2
        Magnitude = (v3 - (v3:Max(-v4)):Min(v4)).Magnitude
        if not (Magnitude > 13) then
            v1 = (j.Anchor.Position - v7.Position) * Vector3.new(1, 0, 1)
            v2 = if not (0.001 < v1.Magnitude) then 1 else v5.Unit:Dot(v1.Unit)
            if not (v2 < 0.1) or not (Magnitude > 4) then
                v1 = if j.Index ~= u47 then 0 else 1
                v3 = Magnitude - v2 * 3 - v1
                if v3 < v6 then
                    Index = j.Index
                end
            end
        end
    end
    return Index
end

local function nominate(a1) -- Line: 89 -- upvalues: u47 (ref), Mushrooms (val), Remotes (val) -- types: a1: number?
    if a1 == u47 then
        return
    end
    u47 = a1
    Mushrooms.ShowAim(a1)
    Remotes.BanjoCricket.Aim:FireServer(a1 or 0)
end

local function update() -- Line: 98
    -- upvalues: u48 (ref), LocalPlayer (val), BanjoCricketFlags (val), u47 (ref), Mushrooms (val), Remotes (val)
    -- upvalues: pick (val)
    local v1 = u48
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if v1 ~= nil
        and v1.Parent == Character
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and BanjoCricketFlags.Enabled:Get() then
        local v2 = pick(HumanoidRootPart)
        if v2 == u47 then
            return
        end
        u47 = v2
        Mushrooms.ShowAim(v2)
        Remotes.BanjoCricket.Aim:FireServer(v2 or 0)
        return
    end
    if u47 == nil then
        return
    end
    u47 = nil
    Mushrooms.ShowAim(nil)
    Remotes.BanjoCricket.Aim:FireServer(0)
end

local function isRagdolled() -- Line: 115 -- upvalues: LocalPlayer (val), Workspace (val)
    local Attribute = LocalPlayer:GetAttribute("RagdollEndTime")
    local v1 = false
    if typeof(Attribute) == "number" then
        v1 = Workspace:GetServerTimeNow() < Attribute
    end
    return v1
end

local function isCoolingDown(a1) -- Line: 120 -- upvalues: Workspace (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute("CooldownEndTime")
    local v1 = false
    if a1:GetAttribute("CooldownActive") == true then
        v1 = false
        if typeof(Attribute) == "number" then
            v1 = Workspace:GetServerTimeNow() < Attribute
        end
    end
    return v1
end

local function watchCharacter(a1, a2, a3) -- Line: 127
    -- upvalues: Gears (val), u48 (ref), u49 (ref), Workspace (val), LocalPlayer (val), ToolGameplayGuard (val)
    -- upvalues: u47 (ref)
    local u5 = a2:Extend()

    local function equip(a1) -- Line: 133
        -- upvalues: Gears (upval), u5 (val), u48 (upval), u49 (upval), Workspace (upval), LocalPlayer (upval)
        -- upvalues: ToolGameplayGuard (upval), u47 (upval), a3 (val)
        if a1:IsA("Tool") then
            local v1
            if a1:GetAttribute("IsBat") ~= true then
                local Attribute = a1:GetAttribute("GearName")
                local v2 = if typeof(Attribute) ~= "string" then nil else Gears.Directory[Attribute]
                v1 = false
                if v2 ~= nil then
                    v1 = v2.ToolController == "Slap"
                end
            else
                v1 = true
            end
            if v1 then
                u5:Clean()
                u48 = a1
                u5:Connect(a1.Activated, function() -- Line: 140
                    -- upvalues: u49 (upval), a1 (val), Workspace (upval), LocalPlayer (upval)
                    -- upvalues: ToolGameplayGuard (upval), u47 (upval), a3 (upval)
                    local v1 = os.clock()
                    local v2 = v1 - u49
                    if not (v2 < 0.7) then
                        local v3 = a1
                        local Attribute = v3:GetAttribute("CooldownEndTime")
                        v2 = false
                        if v3:GetAttribute("CooldownActive") == true then
                            v2 = false
                            if typeof(Attribute) == "number" then
                                v2 = Workspace:GetServerTimeNow() < Attribute
                            end
                        end
                        if not v2 then
                            local Attribute_2 = LocalPlayer:GetAttribute("RagdollEndTime")
                            v2 = false
                            if typeof(Attribute_2) == "number" then
                                v2 = Workspace:GetServerTimeNow() < Attribute_2
                            end
                            if not v2
                                and ToolGameplayGuard.AllowsLocalUse(a1)
                                and a1:GetAttribute("BanjoBridgePlaying") ~= true then
                                u49 = v1
                                v1 = u47
                                if v1 then
                                    a3(v1)
                                end
                                return
                            end
                        end
                    end
                end)
                return
            end
        end
    end

    a2:Connect(a1.ChildAdded, equip)
    a2:Connect(a1.ChildRemoved, function(a1) -- Line: 159 -- upvalues: u48 (upval), u5 (val) -- types: a1: userdata
        if a1 == u48 then
            u48 = nil
            u5:Clean()
        end
    end)
    for i, j in a1:GetChildren() do
        equip(j)
    end
end

function v1.Start(a1) -- Line: 170
    -- upvalues: Trove (val), u48 (ref), watchCharacter (val), LocalPlayer (val), RunService (val), update (val)
    local u3 = Trove.new()
    LocalPlayer.CharacterAdded:Connect(function(a1_2) -- Line: 172
        -- upvalues: u3 (val), u48 (upval), watchCharacter (upval), a1 (val)
        u3:Clean()
        u48 = nil
        watchCharacter(a1_2, u3, a1)
    end)
    local Character = LocalPlayer.Character
    if Character then
        u3:Clean()
        u48 = nil
        watchCharacter(Character, u3, a1)
    end
    RunService.PreRender:Connect(update)
end

return (table.freeze(v1))