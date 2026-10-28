-- Script path: ReplicatedStorage.Shared.Modules.AfkTreadmillTest
-- Decompile time: 0.68 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests)
local u9 = {TestName = "AfkTreadmillTest", AttributeKey = "AfkTreadmill.Group"}
u9.Groups = table.freeze({Control = "Control", Variant = "Variant"})

function u9.GetGroupAsync(a1) -- Line: 17 -- upvalues: ABTests (val), u9 (val) -- types: a1: userdata
    if (ABTests.GetAttributeAsync(a1, u9.AttributeKey, u9.Groups.Control)) ~= u9.Groups.Variant then
        return u9.Groups.Control
    end
    return u9.Groups.Variant
end

function u9.IsVariantAsync(a1) -- Line: 29 -- upvalues: u9 (val) -- types: a1: userdata
    return (u9.GetGroupAsync(a1)) == u9.Groups.Variant
end

return table.freeze(u9)