-- Script path: ReplicatedStorage.Data.CaptureTheEgg
-- Decompile time: 0.49 ms

return (require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.CaptureTheEgg", {
    EventDisplayName = "Capture The Egg Event",
    EggDisplayName = "Event Egg",
    CarryCategory = "Baby Aurora Dragon",
    RewardCategory = "Baby Aurora Dragon",
    EggScale = 2,
    RewardScale = 1,
    CutsceneFallSeconds = 4,
    LandingSinkStuds = 0.35,
    LandingRotationDegrees = Vector3.new(-5, 28, 4),
    StarterRigName = "CaptureTheEggStarterRig",
    EggUidAttribute = "Event_CaptureTheEggUid",
    EggHighlightColor = Color3.fromRGB(255, 214, 89),
    BroadcastIconImage = "rbxassetid://116524274262912",
    SpawnMarkerName = "CaptureTheEggSpawn",
    FallbackMarkerName = "AdminAbuseEggSpawn",
    DanceAnimationId = "rbxassetid://507771019",
    R6DanceAnimationId = "rbxassetid://182435998",
    ScoreboardVisibleRows = 3,
}, {EggScale = true, RewardScale = true}, false, function(a1) -- Line: 39
    local v1 = false
    if 0 < a1.EggScale then
        v1 = 0 < a1.RewardScale
    end
    assert(v1)
end))