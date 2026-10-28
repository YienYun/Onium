-- Script path: ReplicatedStorage.Data.GhostDogQuest
-- Decompile time: 3.50 ms

local u0 = {}
u0.Stage = table.freeze({
    NotMet = 0,
    Collecting = 1,
    Reunion = 2,
    HasRod = 3,
    Done = 4,
})
u0.DogName = "Echo"
u0.FishermanName = "Ghost Fisherman"
u0.RodName = "Haunted Rod"
u0.TicketName = "Train Pass"
u0.RewardTitle = "TRAIN PASS UNLOCKED!"
u0.RewardSubtitle = "You can now board the Phantom Express whenever it appears."
u0.TicketImage = "rbxassetid://106321524065478"
u0.FolderName = "GhostDogQuest"
u0.MarkersName = "Markers"
u0.RodAttribute = "GhostDogRod"
u0.ChaseAttribute = "GhostDogChase"
u0.PhaseAttribute = "GhostDogPhase"
u0.TalkDistance = 12
u0.PickupDistance = 9
u0.CastDistance = 8
u0.Artifacts = table.freeze({
    table.freeze({
        Id = "Collar",
        DisplayName = "Old Collar",
        Model = "OldCollar_Studs",
        Marker = "Artifact_Collar",
        Hint = "I used to watch the trains at the old station...",
        Found = "My collar! I remember the jingle!",
    }),
    table.freeze({
        Id = "Bone",
        DisplayName = "Chewed Bone",
        Model = "ChewedBone_Studs",
        Marker = "Artifact_Bone",
        Hint = "I buried something in the swampy marsh... probably!",
        Found = "My bone! Still tastes like home.",
    }),
    table.freeze({
        Id = "Toy",
        DisplayName = "Favourite Toy",
        Model = "FavouriteToy_Studs",
        Marker = "Artifact_Toy",
        Hint = "I was playing by the big pumpkin altar... I dropped something there.",
        Found = "Mr. Squeaky! I missed you!",
    }),
    (table.freeze({
        Id = "Photo",
        DisplayName = "Old Photograph",
        Model = "OldPhotograph_Studs",
        Marker = "Artifact_Photo",
        Hint = "Those glowing crystals by the manor gate... something shiny was there.",
        Found = "That's me... and someone with a fishing rod?",
    })),
})
u0.Lines = table.freeze({
    DogFirst = table.freeze({
        "*whimper* Huh? You can see me?",
        "I can't remember anything... not even where my owner went.",
        "My memories got scattered all over this place.",
        "If you find them, maybe I'll remember! Please?",
    }),
    DogWaiting = table.freeze({"You found {found}! Just {left} more to go!"}),
    DogRemembers = table.freeze({
        "My collar... my bone... Mr. Squeaky... the photo!",
        "I remember now! My owner fishes at the old pier!",
        "Follow me! Woof!",
    }),
    DogHappy = table.freeze({"*happy wag* Thank you for bringing me home!"}),
    FisherIdle = table.freeze({
        "Shh... the fish under this pier are restless tonight.",
        "I lost my best friend a long time ago. A little ghost pup named Echo...",
    }),
    FisherReunion = table.freeze({
        "Echo?! Is that really you?!",
        "You brought him home. Thank you, friend!",
        "Here, I conjured you a Haunted Rod of your own. You earned it!",
        "Cast it off the end of the pier, at the glowing ripples.",
        "And hold on tight. Something BIG lives down there!",
    }),
    FisherHint = table.freeze({"Cast at the glowing ripples off the end of the pier.", "And hold on tight!"}),
    FisherAfter = table.freeze({"Keep that pass safe. The Phantom Express could come any night!"}),
    Rescue = table.freeze({
        "Whoa! What's that you found?",
        "A Train Pass?! The ghost train is REAL?!",
        "Take it to the old station when the train comes!",
    }),
})
u0.Captions = table.freeze({
    Rescue = "HOLD ON! I've got you!",
    Ticket = "TRAIN PASS",
    AfterQuest = "Find the Phantom Express at the old station",
})
u0.Objectives = table.freeze({
    Collecting = "Find the dog's lost things",
    Return = "Bring them to Echo!",
    Follow = "Follow Echo!",
    Reunion = "Talk to the Ghost Fisherman",
    Cast = "Cast at the glowing ripples!",
})
u0.Chase = table.freeze({
    Center = Vector3.new(-6000, 1400, -6000),
    Radius = 960,
    SlotCount = 6,
    SlotDepth = 140,
    StartAngle = 3.490658503988659,
    Lanes = 3,
    LaneSpacing = 9,
    WaveHeight = 5,
    WaveLength = 170,
    RiderLift = 0,
})
u0.Sounds = table.freeze({
    Splash = "rbxasset://sounds/impact_water.mp3",
    Swim = "rbxasset://sounds/action_swim.mp3",
    PulledUnder = "rbxassetid://71367247595167",
    Surfaced = "rbxassetid://114905457965260",
    GrowlLong = "rbxassetid://102163247789915",
    GrowlShort = "rbxassetid://99846927830206",
    CountdownTick = "rbxassetid://122458334422848",
    CountdownGo = "rbxassetid://122070283098235",
    UnderwaterDrone = "rbxassetid://88133289595143",
    FishTurn = "rbxassetid://130483295530337",
    LineSnap = "rbxassetid://115396020785351",
    LineTug = table.freeze({"rbxassetid://126878217889318", "rbxassetid://121739776996455", "rbxassetid://70402933991549"}),
    Nibble = table.freeze({"rbxassetid://138369829515190", "rbxassetid://112028362877350"}),
})

function u0.Artifact(a1) -- Line: 186 -- upvalues: u0 (val) -- types: a1: string
    for i, j in u0.Artifacts do
        if j.Id == a1 then
            return j
        end
    end
    return nil
end

function u0.ChaseFrame(a1, a2) -- Line: 195 -- upvalues: u0 (val) -- types: a1: number, a2: number
    local Chase = u0.Chase
    local v1 = Chase.StartAngle + a2 / Chase.Radius
    local v2 = a1 * Chase.SlotDepth
    local v3 = (math.sin(a2 / Chase.WaveLength * 6.283185307179586)) * Chase.WaveHeight
    local v4 = Chase.Center + Vector3.new((math.cos(v1)) * Chase.Radius, v3 - v2, (math.sin(v1)) * Chase.Radius)
    v3 = v1 + 1 / Chase.Radius
    return CFrame.lookAt(v4, Chase.Center + Vector3.new(
        (math.cos(v3)) * Chase.Radius,
        (math.sin((a2 + 1) / Chase.WaveLength * 6.283185307179586)) * Chase.WaveHeight - v2,
        (math.sin(v3)) * Chase.Radius
    ), (Vector3.new(0, 1, 0)))
end

function u0.LaneOffset(a1) -- Line: 212 -- upvalues: u0 (val) -- types: a1: number
    return a1 * u0.Chase.LaneSpacing
end

return table.freeze(u0)