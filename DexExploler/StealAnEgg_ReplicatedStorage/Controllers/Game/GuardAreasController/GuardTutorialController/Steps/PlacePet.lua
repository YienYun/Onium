-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.PlacePet
-- Decompile time: 1.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local u26 = Color3.fromRGB(255, 255, 255)
local u27 = {StepId = "PlacePet"}

function u27.IsSatisfied(a1) -- Line: 24
    return a1:HasPlacedPet()
end

function u27.Bind(a1, a2) -- Line: 26 -- upvalues: StepUtils (val), u27 (val) -- types: a2: function
    return StepUtils.BindOnAdapterChanged(a1, u27.IsSatisfied, a2)
end

function u27.Present(a1, a2) -- Line: 30 -- upvalues: u27 (val), u26 (val)
    local function refreshPresentation() -- Line: 34 -- upvalues: u27 (upval), a2 (val), a1 (val), u26 (upval)
        if not u27.IsSatisfied(a2) and a2:HasPetInInventory() then
            a1:AnnounceTyped("Place your Pet!", u26)
            a1:SetScreenClickHint((a2:HasPetToolEquipped()))
            return
        end
        a1:DropEverything()
    end

    local u7 = a2.Changed:Connect(refreshPresentation)
    refreshPresentation()
    return function() -- Line: 47 -- upvalues: u7 (val), a1 (val)
        u7:Disconnect()
        a1:DropEverything()
    end
end

return u27