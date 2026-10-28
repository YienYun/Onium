-- Script path: ReplicatedStorage.CmdrClient.Types.UserInput
-- Decompile time: 1.92 ms

local Util = require(script.Parent.Parent.Shared.Util)
local EnumItems = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
    EnumItems[#EnumItems + 1] = v
end
local u26 = {}

function u26.Transform(a1) -- Line: 10 -- upvalues: Util (val), EnumItems (val)
    return Util.MakeFuzzyFinder(EnumItems)(a1)
end

function u26.Validate(a1) -- Line: 16
    return #a1 > 0
end

function u26.Autocomplete(a1) -- Line: 20 -- upvalues: Util (val)
    return Util.GetNames(a1)
end

function u26.Parse(a1) -- Line: 24
    return a1[1]
end

return function(a1) -- Line: 29 -- upvalues: u26 (val), Util (val)
    a1:RegisterType("userInput", u26)
    a1:RegisterType("userInputs", (Util.MakeListableType(u26)))
end