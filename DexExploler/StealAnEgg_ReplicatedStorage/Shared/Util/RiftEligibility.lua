-- Script path: ReplicatedStorage.Shared.Util.RiftEligibility
-- Decompile time: 1.12 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LiveEventFlags = require(ReplicatedStorage.Shared.Flags.LiveEventFlags)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local RiftMachineSchedule = require(ReplicatedStorage.Shared.Util.RiftMachineSchedule)
local u22 = {
    CutsceneSeenAttribute = "RiftCutscene2Seen",
    OpenAttribute = LiveEventFlags.Directory.RiftOpen.AttributeName,
}

function u22.IsFeatureLive() -- Line: 20 -- upvalues: RiftMachineSchedule (val), RiftFlags (val)
    return not RiftMachineSchedule.IsLaboratoryTime() and not RiftFlags.Retired:Get()
end

function u22.IsEligible(a1) -- Line: 24 -- upvalues: RiftFlags (val) -- types: a1: number
    return RiftFlags.SpeedPowerRequirement:Get() <= a1
end

function u22.HasSeenReveal(a1) -- Line: 28 -- types: a1: userdata
    return a1:GetAttribute("RiftCutscene2Seen") == true
end

function u22.IsRevealed(a1, a2, a3) -- Line: 32
    -- upvalues: u22 (val), RiftFlags (val)
    if not u22.IsFeatureLive() then
        return false
    end
    local v1 = true
    if not (RiftFlags.SpeedPowerRequirement:Get() <= a2) then
        v1 = true
        if a3 == 0 then
            v1 = u22.HasSeenReveal(a1)
        end
    end
    return v1
end

return table.freeze(u22)