-- Script path: ReplicatedStorage.Controllers.Game.Tools.GunToolHandlerController
-- Decompile time: 4.11 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Data.Gears)
require(ReplicatedStorage.Shared.Globals.Constants)
local Gears = require(ReplicatedStorage.Data.Gears)
local GunCatalog = require(ReplicatedStorage.Client.Util.GunCatalog)
local u37 = (require(ReplicatedStorage.Packages.Log)).new()
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local t = require(ReplicatedStorage.Packages.t)
return {
    Start = function() -- Line: 24
        -- upvalues: GunCatalog (val), Players (val), t (val), u37 (val), Remotes (val), Gears (val), Audio (val)
        -- upvalues: ToolSetup (val)
        local v1 = GunCatalog.ListGearNames()
        local LocalPlayer = Players.LocalPlayer
        local CurrentCamera = workspace.CurrentCamera
        local u7 = nil

        local function createWallCheckParams(a1) -- Line: 34 -- types: a1: userdata
            local v1 = RaycastParams.new()
            v1.FilterType = Enum.RaycastFilterType.Exclude
            local v2 = {a1}
            local Tool = a1:FindFirstChildOfClass("Tool")
            if Tool then
                table.insert(v2, Tool)
            end
            v1.FilterDescendantsInstances = v2
            v1.IgnoreWater = true
            return v1
        end

        local function isShootPathBlocked(a1, a2, a3) -- Line: 49
            -- upvalues: createWallCheckParams (val)
            if a3 and a1 then
                local HumanoidRootPart = a3:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                    local v1 = a3:FindFirstChild("Right Arm")
                    if not v1 then
                        return true
                    end
                    local RightShoulderAttachment = v1:FindFirstChild("RightShoulderAttachment")
                    if not RightShoulderAttachment then
                        return true
                    end
                    v1 = a1.WorldPosition - RightShoulderAttachment.WorldPosition
                    local v2 = createWallCheckParams(a3)
                    return workspace:Raycast(RightShoulderAttachment.WorldPosition, v1, v2) ~= nil
                end
                return true
            end
            return true
        end

        local function getArmShootPosition(a1, a2) -- Line: 85
            -- upvalues: LocalPlayer (val), CurrentCamera (val), isShootPathBlocked (val)
            if not a1 then
                return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), true
            end
            local Mouse = LocalPlayer:GetMouse()
            local v1 = CurrentCamera:ScreenPointToRay(Mouse.X, Mouse.Y)
            local Position = v1.Origin + v1.Direction * 1000
            local v2 = RaycastParams.new()
            v2.FilterType = Enum.RaycastFilterType.Exclude
            local v3 = {a2}
            local Tool = a2:FindFirstChildOfClass("Tool")
            if Tool then
                table.insert(v3, Tool)
            end
            v2.FilterDescendantsInstances = v3
            v2.IgnoreWater = true
            local v4 = workspace:Raycast(v1.Origin, v1.Direction * 1000, v2)
            if v4 then
                Position = v4.Position
            end
            local WorldPosition = a1.WorldPosition
            local Unit = (Position - WorldPosition).Unit
            return WorldPosition, Unit, (isShootPathBlocked(a1, Unit, a2))
        end

        ToolSetup.Attach(v1, {
            onActivated = function(a1) -- Line: 124
                -- upvalues: LocalPlayer (val), t (upval), getArmShootPosition (val), u37 (upval), Remotes (upval)
                -- upvalues: u7 (ref)
                local Character = LocalPlayer.Character
                if not Character then
                    return
                end
                local v1 = assert(a1:FindFirstChild("Shoot", true), "Shoot Attachment not found")
                t.strict(t.instanceIsA("Attachment"))(v1)
                local v2, v3, v4 = getArmShootPosition(v1, Character)
                if v4 then
                    u37:AtDebug():Log("Shoot blocked by wall - preventing fire")
                    return
                end
                Remotes.GunGadget.AskDischarge:FireServer(u7:GetCurrentToolGearName(), v2, v3)
            end,
            onEquipped = function() -- Line: 147 -- upvalues: u7 (ref), Gears (upval), Audio (upval)
                local CurrentToolGearName = u7:GetCurrentToolGearName()
                if not CurrentToolGearName then
                    return
                end
                local EQUIP_SFX = Gears.Directory[CurrentToolGearName].EQUIP_SFX
                if not EQUIP_SFX then
                    return
                end
                Audio.PlayFile(EQUIP_SFX, script)
            end,
            onUnequipped = function() -- Line: 162 -- upvalues: Remotes (upval), u7 (ref)
                Remotes.GunGadget.DropCaster:FireServer((u7:GetCurrentToolGearName()))
            end,
        })
    end,
}