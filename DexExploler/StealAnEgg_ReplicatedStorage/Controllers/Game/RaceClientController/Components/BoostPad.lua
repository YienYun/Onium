-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Components.BoostPad
-- Decompile time: 1.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(script.Parent.Parent.RaceCamera)
local RaceEffects = require(script.Parent.Parent.RaceEffects)
require(ReplicatedStorage.Packages.Trove)
return {
    Bind = function(a1, a2, a3, a4) -- Line: 27
        -- upvalues: RunService (val), MountRace (val), MountRaceFlags (val), RaceEffects (val)
        local Pad = a2:FindFirstChild("Pad")
        local v1 = false
        if Pad ~= nil then
            v1 = Pad:IsA("BasePart")
        end
        assert(v1, (("%* needs a Pad part"):format((a2:GetFullName()))))
        local u24 = false
        a1:Connect(RunService.Heartbeat, function() -- Line: 36
            -- upvalues: MountRace (upval), Pad (val), a3 (val), u24 (ref), a2 (val), MountRaceFlags (upval)
            -- upvalues: RaceEffects (upval), a4 (val)
            local v1 = MountRace.IsInsidePart(Pad, a3.Rig.Mount.Hitbox.Position, (Vector3.new(0, 4, 0)))
            if v1 and not u24 then
                a3:ApplyBoost(
                    MountRace.NumberAttribute(a2, "BoostMultiplier", MountRaceFlags.BoostPadMultiplier:Get()),
                    (MountRace.NumberAttribute(a2, "BoostSeconds", (MountRaceFlags.BoostPadSeconds:Get())))
                )
                RaceEffects.Boost(a3, a4)
            end
            u24 = v1
        end)
    end,
}