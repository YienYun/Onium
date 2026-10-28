-- Script path: ReplicatedStorage.Controllers.Game.CameraShakeController
-- Decompile time: 1.08 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShakeRequestData = require(ReplicatedStorage.Client.Types.ShakeRequestData)
return {
    Start = function() -- Line: 11 -- upvalues: CameraShaker (val), CameraShakerDriver (val), Remotes (val), ShakeRequestData (val)
        local u2 = CameraShaker.new()
        CameraShakerDriver.Start(u2, Enum.RenderPriority.Last.Value)
        Remotes.SharedFx.JoltOnce.OnClientEvent:Connect(function(a1) -- Line: 16 -- upvalues: ShakeRequestData (upval), u2 (val)
            assert((ShakeRequestData.SchemaValidation(a1)))
            u2:ShakeOnce(a1.Magnitude or 1, a1.Roughness or 1, a1.FadeInTime or 0, a1.FadeOutTime, a1.PosInfluence, a1.RotInfluence)
        end)
    end,
}