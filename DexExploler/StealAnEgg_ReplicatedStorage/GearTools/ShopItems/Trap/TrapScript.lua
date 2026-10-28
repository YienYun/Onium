-- Script path: ReplicatedStorage.GearTools.ShopItems.Trap.TrapScript
-- Decompile time: 2.00 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local u26 = 0
Parent.Activated:Connect(function() -- Line: 14 -- upvalues: ToolGameplayGuard (val), Parent (val), u26 (ref), LocalPlayer (val), Remotes (val)
    if not ToolGameplayGuard.AllowsLocalUse(Parent) then
        return
    end
    local v1 = tick()
    if v1 - u26 < 1 then
        return
    end
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        u26 = v1
        local Character = LocalPlayer.Character
        local PrimaryPart = Character.PrimaryPart
        local LookVector = PrimaryPart.CFrame.LookVector
        local v2 = PrimaryPart.Position + LookVector * 4
        local v3 = RaycastParams.new()
        v3.FilterType = Enum.RaycastFilterType.Exclude
        v3.FilterDescendantsInstances = {Character}
        if workspace:Raycast(PrimaryPart.Position, LookVector * 4, v3) then
            return
        end
        local v4 = Vector3.new(v2.X, v2.Y + 5, v2.Z)
        local v5 = workspace:Raycast(v4, Vector3.new(0, -100, 0), v3)
        local Position_2 = if not v5 then v2 else v5.Position
        local Name = Parent:GetAttribute("GearName")
        if typeof(Name) ~= "string" then
            Name = Parent.Name
        end
        Remotes.TrapPlacement.AskPlace:FireServer(Name, Position_2)
        return
    end
end)