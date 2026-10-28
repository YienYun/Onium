-- Script path: ReplicatedStorage.Data.WispQuests
-- Decompile time: 1.08 ms

local v1
local v2 = {
    EssencePerStage = 1,
    StageCount = 4,
    CompanionHeights = {2.1, 2.55, 3, 3.45},
    RequiredSpeedPower = 50000000000,
    SpawnHoverHeight = 1.5,
    SpawnPromptRadius = 16,
    PromptRadius = 5,
    FollowRadius = 7,
    FollowStartRadius = 20,
    FollowResponse = 4,
    FollowTrailSeconds = 0.1,
    FollowMaxDistance = 40,
}
v2.FollowOffset = CFrame.new(0, 1.8, v2.FollowRadius)
v2.LockedIntro = {
    "I need your help, but you're not powerful enough yet! Reach 50 Billion Speed, then come back to help me regain my power!",
}
v2.Intro = {
    "Hey! You can see me?",
    "I'm a spirit of the Enchanted Tree... but I've lost my power.",
    "There's a seal protecting the entrance. I'm too weak to open it like this.",
    "Help me gather Essence and grow stronger, and I'll open the way for you!",
}
v2.Finished = {"I can feel my power again!", "Take me back to the Enchanted Tree.", "I can break the seal now!"}
v2.List = {
    {
        Id = "forest_eggs",
        Title = "Steal 20 Enchanted Forest eggs",
        Event = "EggSecured",
        Target = 20,
        Reward = 1,
        Icon = "rbxassetid://117266037162644",
        Match = {AreaId = "Enchanted Forest"},
    },
    {
        Id = "forest_fusion",
        Title = "Fuse an Enchanted Forest animal",
        Event = "PetFused",
        Target = 1,
        Reward = 1,
        Icon = "rbxassetid://131076803248042",
        Match = {AreaId = "Enchanted Forest"},
    },
    {
        Id = "eternal_egg",
        Title = "Steal any Eternal",
        Event = "EggSecured",
        Target = 1,
        Reward = 1,
        Icon = "rbxassetid://110096031428391",
        Match = {Rarity = "Eternal"},
    },
}
local v3 = {}
assert(#v2.List == v2.StageCount - 1)
local v4 = nil
local v5 = nil
for i, j in v2.List, v4, v5 do
    assert(not v3[j.Id], "Wisp quest IDs must be unique")
    v1 = false
    if 0 < j.Target then
        v1 = j.Reward == v2.EssencePerStage
    end
    assert(v1)
    v3[j.Id] = true
    table.freeze(j.Match)
    table.freeze(j)
end
table.freeze(v2.List)
return table.freeze(v2)