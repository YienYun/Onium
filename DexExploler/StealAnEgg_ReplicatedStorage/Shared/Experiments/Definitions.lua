-- Script path: ReplicatedStorage.Shared.Experiments.Definitions
-- Decompile time: 0.37 ms

require(script.Parent.Types)
local u5 = {
    OnboardingQuestline = {
        ExperimentId = "OnboardingQuestline",
        ConfigKey = "onboarding_questline_variant",
        DefaultVariant = "Control",
        PayloadByVariant = {Control = {QuestlineEnabled = false}, Questline = {QuestlineEnabled = true}},
    },
}
return {
    Ids = {OnboardingQuestline = "OnboardingQuestline"},
    Directory = u5,
    Lookup = function(a1) -- Line: 27 -- upvalues: u5 (val)
        return u5[a1]
    end,
}