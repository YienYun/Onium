-- Script path: ReplicatedStorage.Data.Assets.PersonalityCatalog
-- Decompile time: 7.99 ms

local Affection, Greeting_2, IdleTremble, Movement, Retreat, Texts, Texts_2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Types)
local RollWeighted = require(ReplicatedStorage.Shared.Utils.Numeric).RollWeighted
local u448 = table.freeze({
    Normal = "Normal",
    Lazy = "Lazy",
    Loyal = "Loyal",
    Energetic = "Energetic",
    InvertedModel = "InvertedModel",
    Shy = "Shy",
    Scared = "Scared",
    ExtremelyEnergetic = "ExtremelyEnergetic",
    UltraLoyal = "UltraLoyal",
    JumpCrazy = "JumpCrazy",
})
local v1 = {
    RollWeight = 12,
    _id = u448.Energetic,
    Movement = {
        WalkSpeedMin = 9,
        WalkSpeedMax = 20,
        IdleSecondsMin = 0.1,
        IdleSecondsMax = 0.75,
        NearOwnerPreference = 0.2,
        IsolationPreference = 0,
        CurvedWanderChance = 0.62,
        BurstChance = 0.42,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 4,
        ReturnOrbitChance = 0.6,
        ReturnNormalJumpCount = 3,
        RandomOrbitChance = 0.2,
        RandomOrbitIntervalSeconds = 45,
        DurationSeconds = 6,
        JumpChancePerSecond = 0.85,
        SpinJumpChance = 0.3,
        Texts = {"😊", "😄", "🥰"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.125,
        IntervalSeconds = 5,
        DurationSeconds = 4.5,
        JumpCount = 5,
        Texts = {"😆", "😄", "😁", "😃", "🤪", "😝", "😜", "😋", "😹", "🙀", "😎"},
    },
}
local Greeting = v1.Greeting
local v2 = {
    RollWeight = 1.5,
    _id = u448.InvertedModel,
    Movement = v1.Movement,
    Greeting = {
        Chance = Greeting.Chance,
        FirstPlacementChance = Greeting.FirstPlacementChance,
        FirstPlacementNormalChance = Greeting.FirstPlacementNormalChance,
        FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount,
        ReturnOrbitChance = Greeting.ReturnOrbitChance,
        ReturnNormalJumpCount = Greeting.ReturnNormalJumpCount,
        RandomOrbitChance = Greeting.RandomOrbitChance,
        RandomOrbitIntervalSeconds = Greeting.RandomOrbitIntervalSeconds,
        DurationSeconds = Greeting.DurationSeconds,
        JumpChancePerSecond = Greeting.JumpChancePerSecond,
        SpinJumpChance = Greeting.SpinJumpChance,
        Texts = {
            "//ERRsORijwoR//",
            "0x?#!@NLL",
            "01011010???",
            "▓▒░???░▒▓",
            "M4M4.EXE???",
            "##!%$@//",
            "<???:'aWsFE>",
            "1010_=249_0101",
            "??//V//#",
        },
    },
    Affection = v1.Affection,
}
local u462 = {}
u462.Normal = {
    RollWeight = 37,
    _id = u448.Normal,
    Movement = {
        WalkSpeedMin = 6.5,
        WalkSpeedMax = 12,
        IdleSecondsMin = 1.2,
        IdleSecondsMax = 3.2,
        NearOwnerPreference = 0.14,
        IsolationPreference = 0,
        CurvedWanderChance = 0.16,
        BurstChance = 0.035,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 0,
        FirstPlacementNormalChance = 1,
        FirstPlacementNormalJumpCount = 3,
        ReturnOrbitChance = 0,
        ReturnNormalJumpCount = 2,
        RandomOrbitChance = 0,
        RandomOrbitIntervalSeconds = 45,
        DurationSeconds = 6,
        JumpChancePerSecond = 0.8,
        SpinJumpChance = 0.08,
        Texts = {"😊", "😄", "🥰"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.16666666666666666,
        IntervalSeconds = 5,
        DurationSeconds = 4,
        JumpCount = 2,
        Texts = {"😊", "😄", "🙂", "☺️", "🥰", "😃", "😁", "🤗"},
    },
}
u462.Lazy = {
    RollWeight = 15,
    _id = u448.Lazy,
    Movement = {
        WalkSpeedMin = 2.5,
        WalkSpeedMax = 3.75,
        IdleSecondsMin = 6,
        IdleSecondsMax = 15,
        NearOwnerPreference = 0.025,
        IsolationPreference = 0.08,
        CurvedWanderChance = 0.025,
        BurstChance = 0,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
    },
    Greeting = {
        Chance = 0,
        FirstPlacementChance = 0,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 0,
        ReturnOrbitChance = 0,
        ReturnNormalJumpCount = 1,
        RandomOrbitChance = 0,
        RandomOrbitIntervalSeconds = 60,
        DurationSeconds = 3.5,
        JumpChancePerSecond = 0.08,
        SpinJumpChance = 0,
        Texts = {"😊", "😄", "🥰"},
    },
    Affection = {
        Enabled = false,
        Chance = 0,
        IntervalSeconds = 80,
        DurationSeconds = 0,
        JumpCount = 0,
        Texts = {"😴", "🥱", "😪", "😌", "😐", "😑", "😶", "🙃"},
    },
}
u462.Loyal = {
    RollWeight = 10,
    _id = u448.Loyal,
    Movement = {
        WalkSpeedMin = 7.5,
        WalkSpeedMax = 10,
        IdleSecondsMin = 0.35,
        IdleSecondsMax = 1.25,
        NearOwnerPreference = 0.9,
        IsolationPreference = 0,
        CurvedWanderChance = 0.08,
        BurstChance = 0.055,
        FollowOwnerInPen = true,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 3,
        ReturnOrbitChance = 0.45,
        ReturnNormalJumpCount = 2,
        RandomOrbitChance = 0.08,
        RandomOrbitIntervalSeconds = 45,
        DurationSeconds = 6.5,
        JumpChancePerSecond = 0.55,
        SpinJumpChance = 0.06,
        Texts = {"Mama"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.002976190476190476,
        IntervalSeconds = 5,
        DurationSeconds = 5,
        JumpCount = 2,
        Texts = {"🥰", "😍", "😊", "☺️", "🤗", "😚"},
    },
}
u462.Energetic = v1
u462.InvertedModel = v2
u462.Shy = {
    RollWeight = 10,
    _id = u448.Shy,
    Movement = {
        WalkSpeedMin = 3,
        WalkSpeedMax = 5,
        IdleSecondsMin = 5.5,
        IdleSecondsMax = 14,
        NearOwnerPreference = 0,
        IsolationPreference = 0.95,
        CurvedWanderChance = 0.035,
        BurstChance = 0,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
        Retreat = {TriggerDistance = 22, Chance = 0.85, MaxTravelDistance = 16},
    },
    Greeting = {
        Chance = 0,
        FirstPlacementChance = 0,
        FirstPlacementBubbleChance = 0,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 0,
        ReturnOrbitChance = 0,
        ReturnNormalJumpCount = 0,
        RandomOrbitChance = 0,
        RandomOrbitIntervalSeconds = 30,
        DurationSeconds = 0,
        JumpChancePerSecond = 0,
        SpinJumpChance = 0,
        Texts = {"😊"},
    },
    Affection = {
        Enabled = false,
        Chance = 0,
        IntervalSeconds = 50,
        DurationSeconds = 0,
        JumpCount = 0,
        Texts = {"😊", "😄", "🥰"},
    },
}
u462.Scared = {
    RollWeight = 5,
    _id = u448.Scared,
    Movement = {
        WalkSpeedMin = 20,
        WalkSpeedMax = 40,
        IdleSecondsMin = 0.8,
        IdleSecondsMax = 4,
        NearOwnerPreference = 0,
        IsolationPreference = 1,
        CurvedWanderChance = 0.03,
        BurstChance = 0,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0,
        Retreat = {TriggerDistance = 20, Chance = 1},
        IdleTremble = {Amplitude = 0.1, CyclesPerSecond = 3},
    },
    Greeting = {
        Chance = 0,
        FirstPlacementChance = 0,
        FirstPlacementBubbleChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 0,
        ReturnOrbitChance = 0,
        ReturnNormalJumpCount = 0,
        RandomOrbitChance = 0,
        RandomOrbitIntervalSeconds = 30,
        DurationSeconds = 0,
        JumpChancePerSecond = 0,
        SpinJumpChance = 0,
        Texts = {"Where is MAMA 😰?"},
    },
    Affection = {
        Enabled = false,
        Chance = 0,
        IntervalSeconds = 50,
        DurationSeconds = 0,
        JumpCount = 0,
        Texts = {"😨", "😰"},
    },
}
u462.ExtremelyEnergetic = {
    RollWeight = 3.5,
    _id = u448.ExtremelyEnergetic,
    Movement = {
        WalkSpeedMin = 30,
        WalkSpeedMax = 70,
        IdleSecondsMin = 0.05,
        IdleSecondsMax = 0.2,
        NearOwnerPreference = 0.2,
        IsolationPreference = 0,
        CurvedWanderChance = 0.8,
        BurstChance = 0.7,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 3.5,
        AmbientSpinJumpChance = 0.35,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 5,
        ReturnOrbitChance = 0.75,
        ReturnNormalJumpCount = 5,
        RandomOrbitChance = 0.35,
        RandomOrbitIntervalSeconds = 30,
        DurationSeconds = 6,
        JumpChancePerSecond = 1.8,
        SpinJumpChance = 0.4,
        Texts = {"🤩", "🤪"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.1,
        IntervalSeconds = 5,
        DurationSeconds = 4.5,
        JumpCount = 7,
        Texts = {"🤩", "😆", "🤪"},
    },
}
u462.UltraLoyal = {
    RollWeight = 2.5,
    _id = u448.UltraLoyal,
    Movement = {
        WalkSpeedMin = 10,
        WalkSpeedMax = 16,
        IdleSecondsMin = 0.1,
        IdleSecondsMax = 0.5,
        NearOwnerPreference = 0.98,
        IsolationPreference = 0,
        CurvedWanderChance = 0.12,
        BurstChance = 0.1,
        FollowOwnerInPen = true,
        AmbientJumpRatePerSecond = 0.35,
        AmbientSpinJumpChance = 0.1,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 4,
        ReturnOrbitChance = 0.9,
        ReturnNormalJumpCount = 3,
        RandomOrbitChance = 0.9,
        RandomOrbitIntervalSeconds = 5,
        DurationSeconds = 6.5,
        JumpChancePerSecond = 0.8,
        SpinJumpChance = 0.1,
        Texts = {"Mama 🤗", "Mama 🥰"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.15151515151515152,
        IntervalSeconds = 5,
        DurationSeconds = 5,
        JumpCount = 3,
        Texts = {"🥰", "🤗"},
    },
}
u462.JumpCrazy = {
    RollWeight = 3.5,
    _id = u448.JumpCrazy,
    Movement = {
        WalkSpeedMin = 10,
        WalkSpeedMax = 18,
        IdleSecondsMin = 0.05,
        IdleSecondsMax = 0.3,
        NearOwnerPreference = 0.2,
        IsolationPreference = 0,
        CurvedWanderChance = 0.25,
        BurstChance = 0.1,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 12,
        AmbientSpinJumpChance = 0.5,
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 0,
        FirstPlacementNormalChance = 1,
        FirstPlacementNormalJumpCount = 8,
        ReturnOrbitChance = 0,
        ReturnNormalJumpCount = 7,
        RandomOrbitChance = 0,
        RandomOrbitIntervalSeconds = 30,
        DurationSeconds = 6,
        JumpChancePerSecond = 2,
        SpinJumpChance = 0.5,
        Texts = {"😆", "😄", "😁", "😃", "🤪", "😝", "😜", "😋", "😹", "🙀", "😎"},
    },
    Affection = {
        Enabled = true,
        Chance = 0.1,
        IntervalSeconds = 5,
        DurationSeconds = 4,
        JumpCount = 8,
        Texts = {"😆", "😄", "😁", "😃", "🤪", "😝", "😜", "😋", "😹", "🙀", "😎"},
    },
}

local function freezeTable(a1) -- Line: 479
    if a1 ~= nil and not table.isfrozen(a1) then
        table.freeze(a1)
    end
end

local v3 = nil
local v4 = nil
for i, j in u462, v3, v4 do
    Retreat = j.Movement.Retreat
    if Retreat ~= nil and not table.isfrozen(Retreat) then
        table.freeze(Retreat)
    end
    IdleTremble = j.Movement.IdleTremble
    if IdleTremble ~= nil and not table.isfrozen(IdleTremble) then
        table.freeze(IdleTremble)
    end
    Movement = j.Movement
    if Movement ~= nil and not table.isfrozen(Movement) then
        table.freeze(Movement)
    end
    Texts = j.Greeting.Texts
    if Texts ~= nil and not table.isfrozen(Texts) then
        table.freeze(Texts)
    end
    Greeting_2 = j.Greeting
    if Greeting_2 ~= nil and not table.isfrozen(Greeting_2) then
        table.freeze(Greeting_2)
    end
    Texts_2 = j.Affection.Texts
    if Texts_2 ~= nil and not table.isfrozen(Texts_2) then
        table.freeze(Texts_2)
    end
    Affection = j.Affection
    if Affection ~= nil and not table.isfrozen(Affection) then
        table.freeze(Affection)
    end
    if j ~= nil and not table.isfrozen(j) then
        table.freeze(j)
    end
end
if u462 ~= nil and not table.isfrozen(u462) then
    table.freeze(u462)
end
v1 = table.freeze({
    {Personality = u448.Normal, Weight = u462[u448.Normal].RollWeight},
    {Personality = u448.Lazy, Weight = u462[u448.Lazy].RollWeight},
    {Personality = u448.Loyal, Weight = u462[u448.Loyal].RollWeight},
    {Personality = u448.Energetic, Weight = u462[u448.Energetic].RollWeight},
    {
        Personality = u448.InvertedModel,
        Weight = u462[u448.InvertedModel].RollWeight,
    },
    {Personality = u448.Shy, Weight = u462[u448.Shy].RollWeight},
    {Personality = u448.Scared, Weight = u462[u448.Scared].RollWeight},
    {
        Personality = u448.ExtremelyEnergetic,
        Weight = u462[u448.ExtremelyEnergetic].RollWeight,
    },
    {Personality = u448.UltraLoyal, Weight = u462[u448.UltraLoyal].RollWeight},
    {Personality = u448.JumpCrazy, Weight = u462[u448.JumpCrazy].RollWeight},
})
local u322 = table.freeze({
    {u448.Normal, u462[u448.Normal].RollWeight},
    {u448.Lazy, u462[u448.Lazy].RollWeight},
    {u448.Loyal, u462[u448.Loyal].RollWeight},
    {u448.Energetic, u462[u448.Energetic].RollWeight},
    {u448.InvertedModel, u462[u448.InvertedModel].RollWeight},
    {u448.Shy, u462[u448.Shy].RollWeight},
    {u448.Scared, u462[u448.Scared].RollWeight},
    {u448.ExtremelyEnergetic, u462[u448.ExtremelyEnergetic].RollWeight},
    {u448.UltraLoyal, u462[u448.UltraLoyal].RollWeight},
    {u448.JumpCrazy, u462[u448.JumpCrazy].RollWeight},
})
for k, n in v1 do
    if n ~= nil and not table.isfrozen(n) then
        table.freeze(n)
    end
end
for m, i5 in u322 do
    if i5 ~= nil and not table.isfrozen(i5) then
        table.freeze(i5)
    end
end
local u344 = {Personalities = u448, Configs = u462, RollTable = v1}

function u344.IsPersonality(a1) -- Line: 549 -- upvalues: u462 (val)
    local v1 = false
    if typeof(a1) == "string" then
        v1 = u462[a1] ~= nil
    end
    return v1
end

function u344.GetConfig(a1) -- Line: 553 -- upvalues: u462 (val), u448 (val) -- types: a1: string?
    return u462[a1] or u462[u448.Normal]
end

function u344.Roll(a1) -- Line: 557 -- upvalues: RollWeighted (val), u322 (val), u344 (val) -- types: a1: userdata?
    local v1 = RollWeighted(u322, a1)
    local v2 = false
    if typeof(v1) == "string" then
        v2 = u344.IsPersonality(v1)
    end
    assert(v2, "Asset personality roll failed")
    return v1
end

function u344.CreateNewItemData(a1) -- Line: 563 -- upvalues: u344 (val)
    local v1 = table.clone(a1)
    v1.Mutations = table.clone(a1.Mutations)
    if not u344.IsPersonality(v1.Personality) then
        v1.Personality = u344.Roll()
    end
    v1.HasBeenFirstPlaced = false
    return v1
end

function u344.ResetFirstPlacementForTransfer(a1) -- Line: 573
    local v1 = table.clone(a1)
    v1.Mutations = table.clone(a1.Mutations)
    v1.HasBeenFirstPlaced = false
    return v1
end

return table.freeze(u344)