-- Script path: ReplicatedStorage.Data.GuardTutorialSteps
-- Decompile time: 0.87 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.GuardTutorial)
local u20 = table.freeze({"StealEgg", "HeadToPen", "EquipEgg", "PlaceEgg", "HatchEgg", "PlacePet", "ExpandPen", "TreadmillIntro"})
local u21 = {}
for i, v in ipairs(u20) do
    u21[v] = i
end
table.freeze(u21)
local u38 = {}

function u38.GetOrderedStepIds() -- Line: 36 -- upvalues: u20 (val)
    return u20
end

function u38.GetFirstStepId() -- Line: 38 -- upvalues: u20 (val)
    return u20[1]
end

function u38.GetIndex(a1) -- Line: 40 -- upvalues: u21 (val)
    return u21[a1]
end

function u38.GetNextStepId(a1) -- Line: 42 -- upvalues: u38 (val), u20 (val)
    local v1 = u38.GetIndex(a1)
    if v1 == nil then
        return nil
    end
    return u20[v1 + 1]
end

return u38