-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Components.SlowPad
-- Decompile time: 1.26 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(script.Parent.Parent.RaceCamera)
require(ReplicatedStorage.Packages.Trove)
local u35 = 0
return {
    Bind = function(a1, a2, a3, a4) -- Line: 29
        -- upvalues: u35 (ref), RunService (val), MountRace (val), MountRaceFlags (val)
        local Pad = a2:FindFirstChild("Pad")
        local v1 = false
        if Pad ~= nil then
            v1 = Pad:IsA("BasePart")
        end
        assert(v1, (("%* needs a Pad part"):format((a2:GetFullName()))))
        u35 = u35 + 1
        local u30 = ("SlowPad%*"):format(u35)
        a1:Add(function() -- Line: 39 -- upvalues: a3 (val), u30 (val)
            a3:SetSpeedScale(u30, nil)
        end)
        a1:Connect(RunService.Heartbeat, function() -- Line: 42 -- upvalues: MountRace (upval), Pad (val), a3 (val), u30 (val), a2 (val), MountRaceFlags (upval)
            a3:SetSpeedScale(
                u30,
                if not (MountRace.IsInsidePart(Pad, a3.Rig.Mount.Hitbox.Position, (Vector3.new(0, 4, 0)))) then nil else MountRace.NumberAttribute(a2, "SlowMultiplier", MountRaceFlags.SlowPadMultiplier:Get())
            )
        end)
    end,
}