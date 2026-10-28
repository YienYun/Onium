-- Script path: ReplicatedStorage.Controllers.Game.AreaArrowPointerClientController
-- Decompile time: 7.98 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local LocalPlayer = Players.LocalPlayer
local AnchorForZone = (require(ReplicatedStorage.Shared.Remotes)).ZoneProbe.AnchorForZone
local u33 = nil
local u34 = nil
local u35 = 0
local u36 = nil
local u37 = nil
return {
    Start = function() -- Line: 25
        -- upvalues: CollectionService (val), Workspace (val), LocalPlayer (val), u36 (ref), u37 (ref)
        -- upvalues: ArrowPointer3D (val), u33 (ref), u34 (ref), u35 (ref), AnchorForZone (val)
        local function resolveTargetPart(a1) -- Line: 26 -- types: a1: userdata
            if a1:IsA("BasePart") then
                return a1
            end
            if not a1:IsA("Model") then
                return nil
            end
            if a1.PrimaryPart ~= nil then
                return a1.PrimaryPart
            end
            return a1:FindFirstChildWhichIsA("BasePart", true)
        end

        local function findTaggedTargetPart(a1) -- Line: 39
            -- upvalues: CollectionService (upval), Workspace (upval)
            local PrimaryPart
            for i, v in ipairs(CollectionService:GetTagged(a1)) do
                if v:IsDescendantOf(Workspace) then
                    PrimaryPart = if not v:IsA("BasePart") then if not v:IsA("Model") then nil else if v.PrimaryPart == nil then v:FindFirstChildWhichIsA("BasePart", true) else v.PrimaryPart else v
                    if PrimaryPart ~= nil then
                        return PrimaryPart
                    end
                end
            end
            return nil
        end

        local function getCharacterRoot() -- Line: 51 -- upvalues: LocalPlayer (upval)
            local Character = LocalPlayer.Character
            if Character == nil then
                return nil
            end
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end

        local function destroyArrow() -- Line: 63 -- upvalues: u36 (upval), u37 (upval)
            if u36 ~= nil then
                u36:Destroy()
                u36 = nil
            end
            u37 = nil
        end

        local function pointArrowAt(a1) -- Line: 71
            -- upvalues: LocalPlayer (upval), u36 (upval), u37 (upval), ArrowPointer3D (upval)
            local v1
            local Character = LocalPlayer.Character
            if Character ~= nil then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                v1 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            else
                v1 = nil
            end
            if v1 == nil then
                return
            end
            if u36 ~= nil and u37 == a1 then
                u36:PointFrom(v1)
                return
            end
            if u36 ~= nil then
                u36:Destroy()
                u36 = nil
            end
            u37 = nil
            local v2 = ArrowPointer3D.new(a1, v1)
            v2:Start()
            u36 = v2
            u37 = a1
        end

        local function isPlayerInZone(a1) -- Line: 89 -- upvalues: LocalPlayer (upval) -- types: a1: string
            return LocalPlayer:GetAttribute("AreaId") == a1
        end

        local function runZoneLoop(a1, a2, a3) -- Line: 93
            -- upvalues: u33 (upval), u34 (upval), u35 (upval), LocalPlayer (upval), findTaggedTargetPart (val)
            -- upvalues: pointArrowAt (val), u36 (upval), u37 (upval)
            local Character, HumanoidRootPart, v1, v2
            while u33 == a1 do
                if u34 ~= a2 or u35 ~= a3 then
                    break
                end
                v1 = LocalPlayer:GetAttribute("AreaId") == a1
                if not v1 then
                    if u36 ~= nil then
                        u36:Destroy()
                        u36 = nil
                    end
                    u37 = nil
                else
                    v1 = findTaggedTargetPart(a2)
                    Character = LocalPlayer.Character
                    if Character ~= nil then
                        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        v2 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                    else
                        v2 = nil
                    end
                    if v1 ~= nil and v2 ~= nil and (v2.Position - v1.Position).Magnitude <= 25 then
                        break
                    end
                    if v1 == nil then
                        if u36 ~= nil then
                            u36:Destroy()
                            u36 = nil
                        end
                        u37 = nil
                    else
                        pointArrowAt(v1)
                    end
                end
                task.wait(0.25)
            end
            if u36 ~= nil then
                u36:Destroy()
                u36 = nil
            end
            u37 = nil
            if u35 == a3 then
                u33 = nil
                u34 = nil
            end
        end

        local function setZone(a1, a2) -- Line: 122
            -- upvalues: u35 (upval), u33 (upval), u34 (upval), u36 (upval), u37 (upval), runZoneLoop (val)
            u35 = u35 + 1
            u33 = a1
            u34 = a2
            if u36 ~= nil then
                u36:Destroy()
                u36 = nil
            end
            u37 = nil
            if a1 ~= nil and a2 ~= nil then
                task.spawn(runZoneLoop, a1, a2, u35)
                return
            end
        end

        AnchorForZone.OnClientEvent:Connect(function(a1, a2) -- Line: 135
            -- upvalues: u35 (upval), u33 (upval), u34 (upval), u36 (upval), u37 (upval), runZoneLoop (val)
            if a1 ~= nil and typeof(a1) ~= "string" then
                return
            end
            if a2 ~= nil and typeof(a2) ~= "string" then
                return
            end
            u35 = u35 + 1
            u33 = a1
            u34 = a2
            if u36 ~= nil then
                u36:Destroy()
                u36 = nil
            end
            u37 = nil
            if a1 ~= nil then
                if a2 == nil then
                    return
                end
                task.spawn(runZoneLoop, a1, a2, u35)
            end
        end)
    end,
}