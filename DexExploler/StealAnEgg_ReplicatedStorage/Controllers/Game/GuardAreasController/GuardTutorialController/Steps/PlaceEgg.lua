-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.PlaceEgg
-- Decompile time: 1.34 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local u26 = Color3.fromRGB(255, 255, 255)
local u27 = {StepId = "PlaceEgg"}

function u27.IsSatisfied(a1) -- Line: 24
    return a1:HasPlacedEgg()
end

function u27.Bind(a1, a2) -- Line: 26 -- upvalues: StepUtils (val), u27 (val) -- types: a2: function
    return StepUtils.BindOnAdapterChanged(a1, u27.IsSatisfied, a2)
end

function u27.Present(a1, a2) -- Line: 30 -- upvalues: u27 (val), u26 (val)
    local u7 = a2.Changed:Connect(function() -- Line: 34 -- upvalues: u27 (upval), a2 (val), a1 (val), u26 (upval)
        if u27.IsSatisfied(a2) then
            a1:DropEverything()
            return
        end
        a1:AnnounceTyped("Place your Egg!", u26)
        local EggPlacementBillboardCFrame = a2:GetEggPlacementBillboardCFrame()
        if EggPlacementBillboardCFrame ~= nil then
            a1:PinWorldClickHint(EggPlacementBillboardCFrame)
        end
    end)
    if not u27.IsSatisfied(a2) then
        a1:AnnounceTyped("Place your Egg!", u26)
        local EggPlacementBillboardCFrame = a2:GetEggPlacementBillboardCFrame()
        if EggPlacementBillboardCFrame ~= nil then
            a1:PinWorldClickHint(EggPlacementBillboardCFrame)
        end
    else
        a1:DropEverything()
    end
    return function() -- Line: 50 -- upvalues: u7 (val), a1 (val)
        u7:Disconnect()
        a1:DropEverything()
    end
end

return u27