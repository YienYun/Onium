-- Script path: ReplicatedStorage.Controllers.Game.CustomRespawnController
-- Decompile time: 1.02 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 15 -- upvalues: Remotes (val), LocalPlayer (val)
        local function requestCharacterReset(a1) -- Line: 20 -- upvalues: Remotes (upval) -- types: a1: userdata
            Remotes.RigSync.AskRigWipe:FireServer(a1)
        end

        LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 24 -- upvalues: Remotes (upval) -- types: a1: userdata
            (a1:WaitForChild("Humanoid")).Died:Connect(function() -- Line: 27 -- upvalues: a1 (val), Remotes (upval)
                Remotes.RigSync.AskRigWipe:FireServer(a1)
            end)
        end)
        if LocalPlayer.Character then
            local Character = LocalPlayer.Character
            ;(Character:WaitForChild("Humanoid")).Died:Connect(function() -- Line: 27 -- upvalues: Character (val), Remotes (upval)
                Remotes.RigSync.AskRigWipe:FireServer(Character)
            end)
        end
    end,
}