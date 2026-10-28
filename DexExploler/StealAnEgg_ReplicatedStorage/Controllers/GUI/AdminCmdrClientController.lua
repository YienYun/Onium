-- Script path: ReplicatedStorage.Controllers.GUI.AdminCmdrClientController
-- Decompile time: 1.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
return {
    Start = function() -- Line: 13 -- upvalues: ReplicatedStorage (val), Players (val)
        local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"))
        local Remotes = require(game:GetService("ReplicatedStorage").Shared.Remotes)
        local TopBarPlus = require(ReplicatedStorage.Packages.TopBarPlus)
        local u21 = false
        local u22 = {[1927880506] = true, [2790707588] = true}

        local function Initialize() -- Line: 31 -- upvalues: u21 (ref), CmdrClient (val), TopBarPlus (val)
            u21 = true
            CmdrClient:SetActivationKeys({Enum.KeyCode.F2})
            local v1 = TopBarPlus.new()
            v1:setName("Cmdr")
            v1:setImage(102459578526748)
            v1:setRight()
            v1.toggled:Connect(function() -- Line: 40 -- upvalues: CmdrClient (upval)
                CmdrClient:Show()
            end)
        end

        Remotes.StaffConsole.StaffVerdict.OnClientEvent:Connect(function(a1) -- Line: 45 -- upvalues: u22 (val), Players (upval), u21 (ref), Initialize (val) -- types: a1: boolean
            if u22[Players.LocalPlayer.UserId] then
                return
            end
            if a1 and not u21 then
                Initialize()
            end
        end)
        Remotes.StaffConsole.ProbeStaffStatus:FireServer()
    end,
}