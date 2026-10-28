-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Worker
-- Decompile time: 13.03 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Rig = require(script.Parent.Parent.GhostDogQuestController.Rig)
local Save = require(ReplicatedStorage.Shared.Save)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local Speech = require(script.Parent.Parent.GhostDogQuestController.Speech)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Worker = SewerCave.Worker
local Markers = SewerCave.Markers
local u62 = {"Assets", "SewerCave", "ManorWorker"}
local u66 = {"Assets", "ShootingStar", "Sounds", "BuddyChatter2"}
local u76 = Log.new():LimitUnderLevel("Warning")
local v1 = {}

local function clip(a1, a2, a3) -- Line: 48 -- types: a1: string, a2: number, a3: boolean
    return {Animation = a1, Speed = a2, Looped = a3}
end

local u85 = table.freeze({
    Clips = {
        Idle = {Animation = "Idle", Speed = 1, Looped = true},
        Talk = {Animation = "Idle", Speed = 1, Looped = true},
    },
    Body = function() -- Line: 57
        return CFrame.identity
    end,
})

local function findChild(a1, a2) -- Line: 62 -- types: a1: userdata, a2: table
    local v1 = a1
    for i, j in a2 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    return v1
end

local function template() -- Line: 70 -- upvalues: ReplicatedStorage (val), u62 (val)
    local v1 = ReplicatedStorage
    for i, j in u62 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function voice() -- Line: 75 -- upvalues: ReplicatedStorage (val), u66 (val)
    local v1 = ReplicatedStorage
    for i, j in u66 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    if v1 ~= nil and v1:IsA("Sound") then
        return {v1}
    end
    return {}
end

local function planted(a1, a2) -- Line: 80 -- upvalues: Workspace (val) -- types: a1: userdata, a2: userdata
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = {a1, a2}
    v1.RespectCanCollide = true
    local CFrame_2 = a2.CFrame
    local v2 = Workspace:Raycast(CFrame_2.Position + Vector3.new(0, 6, 0), Vector3.new(0, -36, 0), v1)
    v1 = Vector3.new(CFrame_2.LookVector.X, 0, CFrame_2.LookVector.Z)
    local Unit = if not (0.01 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit
    v2 = Vector3.new(CFrame_2.Position.X, if not v2 then CFrame_2.Position.Y - a2.Size.Y / 2 else v2.Position.Y, CFrame_2.Position.Z)
    return CFrame.lookAt(v2, v2 + Unit)
end

local function headOf(a1) -- Line: 98 -- types: a1: userdata
    local Head = a1:FindFirstChild("Head")
    if Head and Head:IsA("BasePart") then
        return Head
    end
    return a1.PrimaryPart
end

local function hasKey() -- Line: 106 -- upvalues: Save (val)
    local v1
    local v2 = Save.Peek()
    if v2 == nil then
        return false
    end
    local HalloweenDimension = v2.HalloweenDimension
    local Manor = HalloweenDimension and HalloweenDimension.Manor
    local GearInventory = v2.GearInventory
    if Manor == nil then
        v1 = false
        if GearInventory ~= nil then
            v1 = 0 < (GearInventory["Manor Key"] or 0)
        end
    else
        v1 = true
        if Manor.KeyClaimed ~= true then
            v1 = true
            if Manor.GateUnlocked ~= true then
                v1 = false
                if GearInventory ~= nil then
                    v1 = 0 < (GearInventory["Manor Key"] or 0)
                end
            end
        end
    end
    return v1
end

local function turn(a1, a2) -- Line: 118 -- types: a2: userdata
    local Root = a1.Root
    local v1 = os.clock()
    while true do
        if not (os.clock() - v1 < 0.35) then
            break
        end
        a1:SetRoot((Root:Lerp(a2, 1 - (1 - ((os.clock()) - v1) / 0.35) ^ 2)))
        task.wait()
    end
    a1:SetRoot(a2)
end

local function facePlayer(a1) -- Line: 129 -- upvalues: Player (val), LocalPlayer (val), turn (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 == nil then
        return
    end
    local Position = a1.Root.Position
    local v2 = Vector3.new(v1.Position.X, Position.Y, v1.Position.Z)
    if (v2 - Position).Magnitude < 0.5 then
        return
    end
    turn(a1, CFrame.lookAt(Position, v2))
end

function v1.Start(a1) -- Line: 146
    -- upvalues: SewerCave (val), Markers (val), ReplicatedStorage (val), u62 (val), u76 (val), planted (val)
    -- upvalues: Workspace (val), Rig (val), u85 (val), voice (val), Speech (val), Remotes (val), Save (val)
    -- upvalues: Worker (val), facePlayer (val), turn (val), RunService (val)
    local v1 = SewerCave.Marker(Markers.Npc)
    local v2 = ReplicatedStorage
    for i, j in u62 do
        v2 = if not v2 then nil else v2:FindFirstChild(j)
    end
    local v3 = if v2 == nil then nil else if not v2:IsA("Model") then nil else v2
    if v1 ~= nil and v3 ~= nil then
        v2 = a1:Extend()
        local u39 = v2:Clone(v3)
        if u39.PrimaryPart == nil then
            u76:AtWarning():Log("[SewerCave] manor worker template has no PrimaryPart")
            v2:Destroy()
            return
        end
        local u56 = planted(u39, v1)
        u39:PivotTo(u56)
        u39.Parent = Workspace
        local u67 = Rig.new(u39, u85)
        v2:Add(function() -- Line: 164 -- upvalues: u67 (val)
            u67:Destroy()
        end)
        u67:SetRoot(u56)
        local Head = u39:FindFirstChild("Head")
        local PrimaryPart = if not Head then u39.PrimaryPart else if not Head:IsA("BasePart") then u39.PrimaryPart else Head
        local TalkPrompt = u39:FindFirstChild("TalkPrompt", true)
        local QuestMarker = u39:FindFirstChild("QuestMarker", true)
        local PointLight = u39:FindFirstChildWhichIsA("PointLight", true)
        local Brightness = if not PointLight then 0 else PointLight.Brightness
        local u106 = voice()
        local u107 = true
        local u108 = false
        v2:Add(function() -- Line: 177 -- upvalues: u107 (ref), u108 (ref), Speech (upval)
            u107 = false
            if u108 then
                Speech.Stop()
            end
        end)

        local function talk() -- Line: 184
            -- upvalues: u108 (ref), u107 (ref), Remotes (upval), QuestMarker (val), Save (upval), Worker (upval)
            -- upvalues: u67 (val), facePlayer (upval), Speech (upval), u39 (val), PrimaryPart (val), u106 (val)
            -- upvalues: turn (upval), u56 (val)
            if not u108 and u107 then
                local v1
                u108 = true
                Remotes.SewerCave.MetWorker:FireServer()
                if QuestMarker and QuestMarker:IsA("BillboardGui") then
                    QuestMarker.Enabled = false
                end
                local v2 = Save.Peek()
                if v2 ~= nil then
                    local HalloweenDimension = v2.HalloweenDimension
                    local Manor = HalloweenDimension and HalloweenDimension.Manor
                    local GearInventory = v2.GearInventory
                    if Manor == nil then
                        v1 = false
                        if GearInventory ~= nil then
                            v1 = 0 < (GearInventory["Manor Key"] or 0)
                        end
                    else
                        v1 = true
                        if Manor.KeyClaimed ~= true then
                            v1 = true
                            if Manor.GateUnlocked ~= true then
                                v1 = false
                                if GearInventory ~= nil then
                                    v1 = 0 < (GearInventory["Manor Key"] or 0)
                                end
                            end
                        end
                    end
                else
                    v1 = false
                end
                local KeyLines = if not v1 then Worker.Lines else Worker.KeyLines
                u67:SetMood("Talk")
                facePlayer(u67)
                Speech.Say(u39, PrimaryPart, KeyLines, {WalkAway = 40, Voice = u106})
                if not u107 then
                    return
                end
                u67:SetMood("Idle")
                turn(u67, u56)
                u108 = false
                return
            end
        end

        if TalkPrompt and TalkPrompt:IsA("ProximityPrompt") then
            TalkPrompt.ActionText = "Talk"
            TalkPrompt.ObjectText = Worker.Name
            TalkPrompt.Style = Enum.ProximityPromptStyle.Custom
            TalkPrompt.HoldDuration = 0
            TalkPrompt.RequiresLineOfSight = false
            TalkPrompt.MaxActivationDistance = 12
            TalkPrompt.Enabled = true
            v2:Connect(TalkPrompt.Triggered, function() -- Line: 217 -- upvalues: talk (val)
                task.spawn(talk)
            end)
        end
        if QuestMarker and QuestMarker:IsA("BillboardGui") then
            local v4
            local v5 = Save.Peek()
            if v5 ~= nil then
                local HalloweenDimension = v5.HalloweenDimension
                local Manor = HalloweenDimension and HalloweenDimension.Manor
                local GearInventory = v5.GearInventory
                if Manor == nil then
                    v4 = false
                    if GearInventory ~= nil then
                        v4 = 0 < (GearInventory["Manor Key"] or 0)
                    end
                else
                    v4 = true
                    if Manor.KeyClaimed ~= true then
                        v4 = true
                        if Manor.GateUnlocked ~= true then
                            v4 = false
                            if GearInventory ~= nil then
                                v4 = 0 < (GearInventory["Manor Key"] or 0)
                            end
                        end
                    end
                end
            else
                v4 = false
            end
            QuestMarker.Enabled = not v4
        end
        v2:Connect(RunService.RenderStepped, function(a1) -- Line: 225
            -- upvalues: u67 (val), TalkPrompt (val), u108 (ref), PointLight (val), Brightness (val), QuestMarker (val)
            u67:Step(a1)
            if TalkPrompt and TalkPrompt:IsA("ProximityPrompt") then
                TalkPrompt.Enabled = not u108
            end
            if PointLight then
                PointLight.Brightness = Brightness * (1 + math.noise(os.clock() * 6, 0.5) * 0.18)
            end
            if QuestMarker and QuestMarker:IsA("BillboardGui") and QuestMarker.Enabled then
                QuestMarker.StudsOffset = Vector3.new(0, math.sin((os.clock()) * 4) * 0.3 + 3.4, 0)
            end
        end)
        return
    end
    u76:AtWarning():Log("[SewerCave] manor worker template or Npc marker is missing")
end

return table.freeze(v1)