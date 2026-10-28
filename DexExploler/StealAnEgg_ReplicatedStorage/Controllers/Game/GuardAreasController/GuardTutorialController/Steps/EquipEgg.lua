-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.EquipEgg
-- Decompile time: 1.33 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local u21 = {StepId = "EquipEgg"}

function u21.IsSatisfied(a1) -- Line: 21
    return a1:HasEquippedEgg()
end

function u21.Bind(a1, a2) -- Line: 23 -- upvalues: StepUtils (val), u21 (val) -- types: a2: function
    return StepUtils.BindOnAdapterChanged(a1, u21.IsSatisfied, a2)
end

function u21.Present(a1, a2) -- Line: 27 -- upvalues: u21 (val)
    local u2 = false

    local function refreshPresentation() -- Line: 32 -- upvalues: u21 (upval), a2 (val), a1 (val), u2 (ref)
        if u21.IsSatisfied(a2) then
            a1:DropEverything()
            return
        end
        if not u2 then
            u2 = true
            if a2:ForceBestEggIntoHotbar() == nil then
                u2 = false
            end
        end
        local EggHotbarTarget = a2:GetEggHotbarTarget()
        if EggHotbarTarget ~= nil then
            a1:RingButton(EggHotbarTarget)
            return
        end
        a1:DropRing()
    end

    local u8 = a2.Changed:Connect(refreshPresentation)
    refreshPresentation()
    return function() -- Line: 55 -- upvalues: u8 (val), a1 (val)
        u8:Disconnect()
        a1:DropEverything()
    end
end

return u21