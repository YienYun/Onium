-- Script path: ReplicatedStorage.Shared.Types.GuardTutorial
-- Decompile time: 1.80 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    TreadmillIntro = "TreadmillIntro",
    ExpandPen = "ExpandPen",
    PlacePet = "PlacePet",
    HatchEgg = "HatchEgg",
    PlaceEgg = "PlaceEgg",
    EquipEgg = "EquipEgg",
    HeadToPen = "HeadToPen",
    StealEgg = "StealEgg",
}
local v2 = {Inactive = "Inactive", ForwardRun = "ForwardRun"}
local v3 = {
    v1.StealEgg,
    v1.HeadToPen,
    v1.EquipEgg,
    v1.PlaceEgg,
    v1.HatchEgg,
    v1.PlacePet,
    v1.ExpandPen,
    v1.TreadmillIntro,
}
local v4 = {v2.Inactive, v2.ForwardRun}

local function anyOf(a1) -- Line: 54 -- upvalues: t (val) -- types: a1: table
    local v1 = table.create(#a1)
    for i, j in a1 do
        v1[i] = (t.literal(j))
    end
    return t.union(table.unpack(v1))
end

local u26 = anyOf(v3)
local u30 = anyOf(v4)
local u38 = t.interface({Completed = t.boolean, CurrentStepId = t.optional(u26)})
v4 = t.interface({Enabled = t.boolean, PausedForAdminAbuse = t.boolean, Revision = t.number})
local u46 = {Completed = false}
local u47 = {StepIds = v1, RunGuidanceStates = v2, DEFAULT_PROGRESS = u46}
u47.SchemaValidation = {
    StepId = u26,
    RunGuidanceState = u30,
    Progress = u38,
    ProgressUpdatePayload = u38,
    RuntimeState = v4,
}

function u47.CopyProgress(a1) -- Line: 92 -- types: a1: table
    return {Completed = a1.Completed == true, CurrentStepId = a1.CurrentStepId}
end

function u47.SanitizeProgress(a1) -- Line: 98 -- upvalues: u38 (val), u47 (val), u46 (val) -- types: a1: table?
    if a1 ~= nil and u38(a1) then
        local v1 = u47.CopyProgress(a1)
        if v1.Completed then
            v1.CurrentStepId = nil
        end
        return v1
    end
    return u47.CopyProgress(u46)
end

function u47.AcceptsStepId(a1) -- Line: 110 -- upvalues: u26 (val) -- types: a1: string
    return u26(a1)
end

function u47.AcceptsGuidanceState(a1) -- Line: 112 -- upvalues: u30 (val) -- types: a1: string
    return u30(a1)
end

return u47