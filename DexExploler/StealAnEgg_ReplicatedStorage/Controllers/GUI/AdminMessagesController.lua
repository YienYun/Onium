-- Script path: ReplicatedStorage.Controllers.GUI.AdminMessagesController
-- Decompile time: 0.61 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
return {
    Start = function() -- Line: 10 -- upvalues: Remotes (val), Toast (val)
        Remotes.Broadcasts.RaiseNotice.OnClientEvent:Connect(function(a1, a2) -- Line: 12 -- upvalues: Toast (upval) -- types: a1: string, a2: number?
            Toast.Show({
                Lane = "Banner",
                ShowShadow = true,
                Text = a1,
                Seconds = a2,
                Color = Color3.new(1, 1, 1),
            })
        end)
    end,
}