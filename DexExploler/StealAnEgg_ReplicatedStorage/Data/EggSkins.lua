-- Script path: ReplicatedStorage.Data.EggSkins
-- Decompile time: 0.84 ms

local u23 = table.freeze({
    Biohazard = table.freeze({ModelName = "Biohazard Egg", Icon = "rbxassetid://103838374075457", DisplayName = "Biohazard Egg"}),
    Experimental = table.freeze({ModelName = "Experiment Egg", Icon = "rbxassetid://77124617553239", DisplayName = "Experiment Egg"}),
    UnstableDNA = table.freeze({ModelName = "Unstable", Icon = "rbxassetid://121178065227483", DisplayName = "Unstable Egg"}),
    LimitedExperiment = table.freeze({ModelName = "LimitedExperimentEgg", Icon = "", DisplayName = "Limited Experiment Egg"}),
    Riftborn = table.freeze({ModelName = "Riftborn Egg", Icon = "rbxassetid://136340085637939", DisplayName = "Riftborn Egg"}),
    Riftbeasts = table.freeze({ModelName = "Riftbeasts Egg", Icon = "rbxassetid://97679329738336", DisplayName = "Riftbeasts Egg"}),
    ShatteredRift = table.freeze({
        ModelName = "Shattered Rift Egg",
        Icon = "rbxassetid://85929412992561",
        DisplayName = "Shattered Rift Egg",
    }),
})
return table.freeze({
    Directory = u23,
    Get = function(a1) -- Line: 48 -- upvalues: u23 (val) -- types: a1: string?
        if a1 ~= nil then
            return u23[a1]
        end
        return nil
    end,
})