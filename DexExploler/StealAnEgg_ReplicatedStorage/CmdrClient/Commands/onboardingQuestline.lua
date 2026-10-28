-- Script path: ReplicatedStorage.CmdrClient.Commands.onboardingQuestline
-- Decompile time: 0.19 ms

return {
    Name = "onboardingQuestline",
    Description = "Drives the onboarding questline A/B feature for testing.",
    Group = "Admin",
    Aliases = {""},
    Args = {
        {Type = "players", Name = "Players", Description = "The players to act on."},
        {
            Type = "string",
            Name = "Action",
            Description = "enroll | reset | fill | completeSet | expire | status",
        },
    },
}