-- Script path: ReplicatedStorage.Shared.Remotes
-- Decompile time: 20.17 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.Packages.Networking)

local function scope(a1, a2) -- Line: 88 -- upvalues: Networking (val) -- types: a1: string, a2: function
    Networking.namespace({env = "all", name = a1})
    return a2()
end

local v1 = {}

local function v2() -- Line: 94 -- upvalues: Networking (val)
    return {DeviceType = Networking.remoteEvent("DeviceType")}
end

Networking.namespace({name = "UserGenerated", env = "all"})
v1.UserGenerated = {DeviceType = Networking.remoteEvent("DeviceType")}

function v2() -- Line: 99 -- upvalues: Networking (val)
    return {
        Action = Networking.remoteFunction("Action"),
        Suction = Networking.remoteEvent("Suction"),
        CaptureState = Networking.remoteEvent("CaptureState"),
        Ghosts = Networking.remoteEvent("Ghosts"),
        Travel = Networking.remoteEvent("Travel"),
        TravelReady = Networking.remoteEvent("TravelReady"),
        State = Networking.remoteEvent("State"),
    }
end

Networking.namespace({name = "TrainEvent", env = "all"})
v1.TrainEvent = v2()

function v2() -- Line: 110 -- upvalues: Networking (val)
    return {
        Suction = Networking.remoteEvent("Suction"),
        Defeated = Networking.remoteEvent("Defeated"),
    }
end

Networking.namespace({name = "GhostBoss", env = "all"})
v1.GhostBoss = {
    Suction = Networking.remoteEvent("Suction"),
    Defeated = Networking.remoteEvent("Defeated"),
}

function v2() -- Line: 116 -- upvalues: Networking (val)
    return {
        Drones = Networking.remoteEvent("Drones"),
        Request = Networking.remoteFunction("Request"),
        Collect = Networking.remoteEvent("Collect"),
        State = Networking.remoteEvent("State"),
        Drops = Networking.remoteEvent("Drops"),
        RemoveDrops = Networking.remoteEvent("RemoveDrops"),
        Effect = Networking.remoteEvent("Effect"),
    }
end

Networking.namespace({name = "Scramble", env = "all"})
v1.Scramble = v2()

function v2() -- Line: 127 -- upvalues: Networking (val)
    return {
        AskDoff = Networking.remoteFunction("AskDoff"),
        AskLiveSnapshot = Networking.remoteFunction("AskLiveSnapshot"),
        AskSale = Networking.remoteFunction("AskSale"),
        AskWear = Networking.remoteFunction("AskWear"),
        AskWearLimit = Networking.remoteFunction("AskWearLimit"),
        CoinsGathered = Networking.remoteEvent("CoinsGathered"),
        ConfirmEquipBestBadge = Networking.remoteFunction("ConfirmEquipBestBadge"),
        ConfirmPetsBadge = Networking.remoteFunction("ConfirmPetsBadge"),
        OwnerDropped = Networking.remoteEvent("OwnerDropped"),
        OwnerShifted = Networking.remoteEvent("OwnerShifted"),
    }
end

Networking.namespace({name = "PenRoster", env = "all"})
v1.PenRoster = v2()

function v2() -- Line: 141 -- upvalues: Networking (val)
    return {
        Began = Networking.remoteEvent("Began"),
        Ended = Networking.remoteEvent("Ended"),
        FetchCatalogue = Networking.remoteFunction("FetchCatalogue"),
        FetchRecurringEta = Networking.remoteFunction("FetchRecurringEta"),
        FetchRunning = Networking.remoteFunction("FetchRunning"),
        FetchScheduled = Networking.remoteFunction("FetchScheduled"),
    }
end

Networking.namespace({name = "LiveEvents", env = "all"})
v1.LiveEvents = v2()

function v2() -- Line: 151 -- upvalues: Networking (val)
    return {
        AskClaimMilestone = Networking.remoteEvent("AskClaimMilestone"),
        AskCollectPowerUp = Networking.remoteEvent("AskCollectPowerUp"),
        AskCollectRing = Networking.remoteEvent("AskCollectRing"),
        AskSelectTeam = Networking.remoteEvent("AskSelectTeam"),
        FetchPowerUps = Networking.remoteFunction("FetchPowerUps"),
        FetchRings = Networking.remoteFunction("FetchRings"),
        FetchScore = Networking.remoteFunction("FetchScore"),
        PowerUpCollected = Networking.remoteEvent("PowerUpCollected"),
        PowerUpsCleared = Networking.remoteEvent("PowerUpsCleared"),
        PowerUpsDropped = Networking.remoteEvent("PowerUpsDropped"),
        PowerUpsSky = Networking.remoteEvent("PowerUpsSky"),
        RingCollected = Networking.remoteEvent("RingCollected"),
        RingRespawned = Networking.remoteEvent("RingRespawned"),
        RingsCleared = Networking.remoteEvent("RingsCleared"),
        RingsSpawned = Networking.remoteEvent("RingsSpawned"),
        ScoreChanged = Networking.remoteEvent("ScoreChanged"),
        Struck = Networking.remoteEvent("Struck"),
    }
end

Networking.namespace({name = "LightVsDarkness", env = "all"})
v1.LightVsDarkness = v2()

function v2() -- Line: 172 -- upvalues: Networking (val)
    return {
        AskCollectPickup = Networking.remoteEvent("AskCollectPickup"),
        FetchPickups = Networking.remoteFunction("FetchPickups"),
        PickupCollected = Networking.remoteEvent("PickupCollected"),
        PickupRespawned = Networking.remoteEvent("PickupRespawned"),
        PickupsCleared = Networking.remoteEvent("PickupsCleared"),
        PickupsSpawned = Networking.remoteEvent("PickupsSpawned"),
        BomberRow = Networking.remoteEvent("BomberRow"),
        ElephantCharge = Networking.remoteEvent("ElephantCharge"),
    }
end

Networking.namespace({name = "SammyEvent", env = "all"})
v1.SammyEvent = v2()

function v2() -- Line: 184 -- upvalues: Networking (val)
    return {
        AskCatchFirefly = Networking.remoteEvent("AskCatchFirefly"),
        AskPour = Networking.remoteEvent("AskPour"),
        AskFinishFlight = Networking.remoteEvent("AskFinishFlight"),
        AskStealEgg = Networking.remoteEvent("AskStealEgg"),
        AskFinishEscape = Networking.remoteEvent("AskFinishEscape"),
        AskSlideCrash = Networking.remoteEvent("AskSlideCrash"),
        AskClaimReward = Networking.remoteEvent("AskClaimReward"),
        AskLaunch = Networking.remoteEvent("AskLaunch"),
        AskStartTimer = Networking.remoteEvent("AskStartTimer"),
    }
end

Networking.namespace({name = "BeanstalkEvent", env = "all"})
v1.BeanstalkEvent = v2()

function v2() -- Line: 198 -- upvalues: Networking (val)
    return {
        AskLeave = Networking.remoteEvent("AskLeave"),
        OutroFinished = Networking.remoteEvent("OutroFinished"),
        PowerUp = Networking.remoteEvent("PowerUp"),
        PowerUpMoment = Networking.remoteEvent("PowerUpMoment"),
    }
end

Networking.namespace({name = "MountRace", env = "all"})
v1.MountRace = v2()

function v2() -- Line: 208 -- upvalues: Networking (val)
    return {
        AskBuyEgg = Networking.remoteFunction("AskBuyEgg"),
        AskDropEgg = Networking.remoteFunction("AskDropEgg"),
        AskCarryEgg = Networking.remoteFunction("AskCarryEgg"),
        AskTutorialSeen = Networking.remoteFunction("AskTutorialSeen"),
        AskClaimMastery = Networking.remoteFunction("AskClaimMastery"),
        MonsterHit = Networking.remoteEvent("MonsterHit"),
    }
end

Networking.namespace({name = "HalloweenDimension", env = "all"})
v1.HalloweenDimension = v2()

function v2() -- Line: 220 -- upvalues: Networking (val)
    return {
        FlashUserId = Networking.remoteEvent("FlashUserId"),
        RaiseNotice = Networking.remoteEvent("RaiseNotice"),
    }
end

Networking.namespace({name = "Broadcasts", env = "all"})
v1.Broadcasts = {
    FlashUserId = Networking.remoteEvent("FlashUserId"),
    RaiseNotice = Networking.remoteEvent("RaiseNotice"),
}

function v2() -- Line: 226 -- upvalues: Networking (val)
    return {
        GrantSelfEgg = Networking.remoteEvent("GrantSelfEgg"),
        GrantSelfPet = Networking.remoteEvent("GrantSelfPet"),
        GrantVerdict = Networking.remoteEvent("GrantVerdict"),
        ProbeStaffStatus = Networking.remoteEvent("ProbeStaffStatus"),
        SpeedPowerVerdict = Networking.remoteEvent("SpeedPowerVerdict"),
        StaffVerdict = Networking.remoteEvent("StaffVerdict"),
        WipeSelfProfile = Networking.remoteEvent("WipeSelfProfile"),
        WipeVerdict = Networking.remoteEvent("WipeVerdict"),
        WriteSpeedPower = Networking.remoteEvent("WriteSpeedPower"),
        WriteWalkSpeed = Networking.remoteEvent("WriteWalkSpeed"),
    }
end

Networking.namespace({name = "StaffConsole", env = "all"})
v1.StaffConsole = v2()
Networking.namespace({name = "Telemetry", env = "all"})
v1.Telemetry = (function() -- Line: 240 -- upvalues: Networking (val)
    return {
        AskIdleHopFlush = Networking.remoteFunction("AskIdleHopFlush"),
        SubmitIdleHop = Networking.remoteFunction("SubmitIdleHop"),
        SubmitIdleState = Networking.remoteEvent("SubmitIdleState"),
    }
end)()

function v2() -- Line: 247 -- upvalues: Networking (val)
    return {
        SellEveryPet = Networking.remoteEvent("SellEveryPet"),
        SellSelection = Networking.remoteEvent("SellSelection"),
        SellPet = Networking.remoteEvent("SellPet"),
        WriteFavourite = Networking.remoteEvent("WriteFavourite"),
    }
end

Networking.namespace({name = "PetSatchel", env = "all"})
v1.PetSatchel = v2()

function v2() -- Line: 255 -- upvalues: Networking (val)
    return {EmitSound = Networking.remoteEvent("EmitSound")}
end

Networking.namespace({name = "SoundBus", env = "all"})
v1.SoundBus = {EmitSound = Networking.remoteEvent("EmitSound")}

function v2() -- Line: 260 -- upvalues: Networking (val)
    return {
        FetchAutoSell = Networking.remoteFunction("FetchAutoSell"),
        FetchWearBestStatus = Networking.remoteFunction("FetchWearBestStatus"),
        OfferFullSatchelSale = Networking.remoteFunction("OfferFullSatchelSale"),
        WearBest = Networking.remoteFunction("WearBest"),
        WriteAutoSell = Networking.remoteFunction("WriteAutoSell"),
    }
end

Networking.namespace({name = "Haul", env = "all"})
v1.Haul = v2()

function v2() -- Line: 269 -- upvalues: Networking (val)
    return {Trigger = Networking.remoteEvent("Trigger")}
end

Networking.namespace({name = "BatSwing", env = "all"})
v1.BatSwing = {Trigger = Networking.remoteEvent("Trigger")}
Networking.namespace({name = "SwapGadget", env = "all"})
v1.SwapGadget = (function() -- Line: 274 -- upvalues: Networking (val)
    return {
        AskSwap = Networking.remoteEvent("AskSwap"),
        EmitFx = Networking.remoteEvent("EmitFx"),
        EmitSfx = Networking.remoteEvent("EmitSfx"),
    }
end)()

function v2() -- Line: 281 -- upvalues: Networking (val)
    return {
        AskDance = Networking.remoteEvent("AskDance"),
        AttachEffect = Networking.remoteEvent("AttachEffect"),
        DetachEffect = Networking.remoteEvent("DetachEffect"),
        EmitSfx = Networking.remoteEvent("EmitSfx"),
    }
end

Networking.namespace({name = "DanceGadget", env = "all"})
v1.DanceGadget = v2()

function v2() -- Line: 289 -- upvalues: Networking (val)
    return {Post = Networking.remoteEvent("Post")}
end

Networking.namespace({name = "ChatFeed", env = "all"})
v1.ChatFeed = {Post = Networking.remoteEvent("Post")}

function v2() -- Line: 294 -- upvalues: Networking (val)
    return {
        AskRigWipe = Networking.remoteEvent("AskRigWipe"),
        CorrectionBegan = Networking.remoteEvent("CorrectionBegan"),
        Primed = Networking.remoteEvent("Primed"),
        ProbeSatchel = Networking.remoteEvent("ProbeSatchel"),
        Reconcile = Networking.remoteFunction("Reconcile"),
        Refresh = Networking.remoteEvent("Refresh"),
        SeedSatchel = Networking.remoteEvent("SeedSatchel"),
    }
end

Networking.namespace({name = "RigSync", env = "all"})
v1.RigSync = v2()

function v2() -- Line: 305 -- upvalues: Networking (val)
    return {Line = Networking.remoteEvent("Line")}
end

Networking.namespace({name = "Toasts", env = "all"})
v1.Toasts = {Line = Networking.remoteEvent("Line")}

function v2() -- Line: 310 -- upvalues: Networking (val)
    return {Shower = Networking.remoteEvent("Shower")}
end

Networking.namespace({name = "Payouts", env = "all"})
v1.Payouts = {Shower = Networking.remoteEvent("Shower")}

function v2() -- Line: 315 -- upvalues: Networking (val)
    return {
        AskDoffTool = Networking.remoteFunction("AskDoffTool"),
        AskEggRecord = Networking.remoteFunction("AskEggRecord"),
        AskFieldEggCarry = Networking.remoteFunction("AskFieldEggCarry"),
        AskFieldEggDrop = Networking.remoteFunction("AskFieldEggDrop"),
        AskFieldEggRarityShows = Networking.remoteFunction("AskFieldEggRarityShows"),
        AskFieldEggSnapshot = Networking.remoteFunction("AskFieldEggSnapshot"),
        AskFinishHatch = Networking.remoteFunction("AskFinishHatch"),
        AskHatch = Networking.remoteFunction("AskHatch"),
        AskLiveSnapshot = Networking.remoteFunction("AskLiveSnapshot"),
        AskPlaceEgg = Networking.remoteFunction("AskPlaceEgg"),
        AskSkipGrowth = Networking.remoteFunction("AskSkipGrowth"),
        AskWearTool = Networking.remoteFunction("AskWearTool"),
        FieldEggBatchShifted = Networking.remoteEvent("FieldEggBatchShifted"),
        FieldEggCarry = Networking.remoteEvent("FieldEggCarry"),
        FieldEggCycleCountdown = Networking.remoteEvent("FieldEggCycleCountdown"),
        FieldEggGone = Networking.remoteEvent("FieldEggGone"),
        FieldEggRaritiesShown = Networking.remoteEvent("FieldEggRaritiesShown"),
        FieldEggRedeemVerdict = Networking.remoteEvent("FieldEggRedeemVerdict"),
        FieldEggShifted = Networking.remoteEvent("FieldEggShifted"),
        OwnerDropped = Networking.remoteEvent("OwnerDropped"),
        OwnerShifted = Networking.remoteEvent("OwnerShifted"),
    }
end

Networking.namespace({name = "EggWorld", env = "all"})
v1.EggWorld = v2()

function v2() -- Line: 340 -- upvalues: Networking (val)
    return {
        CutsceneBegan = Networking.remoteEvent("CutsceneBegan"),
        StandingsRefreshed = Networking.remoteEvent("StandingsRefreshed"),
    }
end

Networking.namespace({name = "EggCapture", env = "all"})
v1.EggCapture = {
    CutsceneBegan = Networking.remoteEvent("CutsceneBegan"),
    StandingsRefreshed = Networking.remoteEvent("StandingsRefreshed"),
}

function v2() -- Line: 346 -- upvalues: Networking (val)
    return {
        Caught = Networking.remoteEvent("Caught"),
        Cover = Networking.remoteEvent("Cover"),
    }
end

Networking.namespace({name = "RedLightGreenLight", env = "all"})
v1.RedLightGreenLight = {Caught = Networking.remoteEvent("Caught"), Cover = Networking.remoteEvent("Cover")}

function v2() -- Line: 352 -- upvalues: Networking (val)
    return {
        FetchHerd = Networking.remoteFunction("FetchHerd"),
        Herd = Networking.remoteEvent("Herd"),
        Trampled = Networking.remoteEvent("Trampled"),
        Wave = Networking.remoteEvent("Wave"),
    }
end

Networking.namespace({name = "TrexRun", env = "all"})
v1.TrexRun = v2()

function v2() -- Line: 360 -- upvalues: Networking (val)
    return {
        AskRescueHop = Networking.remoteEvent("AskRescueHop"),
        SubmitIdleFlag = Networking.remoteEvent("SubmitIdleFlag"),
    }
end

Networking.namespace({name = "IdleRescue", env = "all"})
v1.IdleRescue = {
    AskRescueHop = Networking.remoteEvent("AskRescueHop"),
    SubmitIdleFlag = Networking.remoteEvent("SubmitIdleFlag"),
}

function v2() -- Line: 366 -- upvalues: Networking (val)
    return {
        AskChestClaim = Networking.remoteFunction("AskChestClaim"),
        AskChestRevealComplete = Networking.remoteFunction("AskChestRevealComplete"),
        AskChestTake = Networking.remoteFunction("AskChestTake"),
        AskFeed = Networking.remoteFunction("AskFeed"),
        AskFullChargeReset = Networking.remoteEvent("AskFullChargeReset"),
        AskGrowthSwap = Networking.remoteEvent("AskGrowthSwap"),
        AskSnapshot = Networking.remoteFunction("AskSnapshot"),
        ChestOpened = Networking.remoteEvent("ChestOpened"),
        EventStateShifted = Networking.remoteEvent("EventStateShifted"),
        FeedSettled = Networking.remoteEvent("FeedSettled"),
        StateShifted = Networking.remoteEvent("StateShifted"),
    }
end

Networking.namespace({name = "MonsterParasite", env = "all"})
v1.MonsterParasite = v2()

function v2() -- Line: 381 -- upvalues: Networking (val)
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        FlagSeen = Networking.remoteFunction("FlagSeen"),
    }
end

Networking.namespace({name = "SeasonBanner", env = "all"})
v1.SeasonBanner = {
    FetchState = Networking.remoteFunction("FetchState"),
    FlagSeen = Networking.remoteFunction("FlagSeen"),
}

function v2() -- Line: 387 -- upvalues: Networking (val)
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        FlagSeen = Networking.remoteFunction("FlagSeen"),
    }
end

Networking.namespace({name = "ShopCta", env = "all"})
v1.ShopCta = {
    FetchState = Networking.remoteFunction("FetchState"),
    FlagSeen = Networking.remoteFunction("FlagSeen"),
}

function v2() -- Line: 393 -- upvalues: Networking (val)
    return {
        Fetch = Networking.remoteFunction("Fetch"),
        Refresh = Networking.remoteEvent("Refresh"),
    }
end

Networking.namespace({name = "Trials", env = "all"})
v1.Trials = {
    Fetch = Networking.remoteFunction("Fetch"),
    Refresh = Networking.remoteEvent("Refresh"),
}

function v2() -- Line: 399 -- upvalues: Networking (val)
    return {PortalTransition = Networking.remoteEvent("PortalTransition")}
end

Networking.namespace({name = "FuseBiome", env = "all"})
v1.FuseBiome = {PortalTransition = Networking.remoteEvent("PortalTransition")}

function v2() -- Line: 404 -- upvalues: Networking (val)
    return {
        BeginFuse = Networking.remoteFunction("BeginFuse"),
        ConfirmBriefing = Networking.remoteFunction("ConfirmBriefing"),
        EjectPet = Networking.remoteFunction("EjectPet"),
        FinishReveal = Networking.remoteFunction("FinishReveal"),
        LoadPet = Networking.remoteFunction("LoadPet"),
    }
end

Networking.namespace({name = "Fusery", env = "all"})
v1.Fusery = v2()

function v2() -- Line: 413 -- upvalues: Networking (val)
    return {Awarded = Networking.remoteEvent("Awarded")}
end

Networking.namespace({name = "PassGrants", env = "all"})
v1.PassGrants = {Awarded = Networking.remoteEvent("Awarded")}

function v2() -- Line: 418 -- upvalues: Networking (val)
    return {Gained = Networking.remoteEvent("Gained"), Lost = Networking.remoteEvent("Lost")}
end

Networking.namespace({name = "GearSatchel", env = "all"})
v1.GearSatchel = {Gained = Networking.remoteEvent("Gained"), Lost = Networking.remoteEvent("Lost")}

function v2() -- Line: 424 -- upvalues: Networking (val)
    return {RedeemPerk = Networking.remoteFunction("RedeemPerk")}
end

Networking.namespace({name = "GroupPerk", env = "all"})
v1.GroupPerk = {RedeemPerk = Networking.remoteFunction("RedeemPerk")}
Networking.namespace({name = "GuardOnboarding", env = "all"})
v1.GuardOnboarding = (function() -- Line: 429 -- upvalues: Networking (val)
    return {
        AskLiveState = Networking.remoteFunction("AskLiveState"),
        AskProgressSync = Networking.remoteFunction("AskProgressSync"),
        LiveStateShifted = Networking.remoteEvent("LiveStateShifted"),
    }
end)()

function v2() -- Line: 436 -- upvalues: Networking (val)
    return {
        AskEnabled = Networking.remoteFunction("AskEnabled"),
        EnabledShifted = Networking.remoteEvent("EnabledShifted"),
        ForestHandoff = Networking.remoteEvent("ForestHandoff"),
        ForestStrike = Networking.remoteEvent("ForestStrike"),
        Rouse = Networking.remoteEvent("Rouse"),
        SpeedTollOffer = Networking.remoteEvent("SpeedTollOffer"),
        SpeedTollWarning = Networking.remoteEvent("SpeedTollWarning"),
    }
end

Networking.namespace({name = "GuardPatrol", env = "all"})
v1.GuardPatrol = v2()

function v2() -- Line: 447 -- upvalues: Networking (val)
    return {
        AskDischarge = Networking.remoteEvent("AskDischarge"),
        DropCaster = Networking.remoteEvent("DropCaster"),
    }
end

Networking.namespace({name = "GunGadget", env = "all"})
v1.GunGadget = {
    AskDischarge = Networking.remoteEvent("AskDischarge"),
    DropCaster = Networking.remoteEvent("DropCaster"),
}

function v2() -- Line: 453 -- upvalues: Networking (val)
    return {
        AskRedeem = Networking.remoteFunction("AskRedeem"),
        AskRedeemAll = Networking.remoteFunction("AskRedeemAll"),
        AskRedeemLimitedEgg = Networking.remoteFunction("AskRedeemLimitedEgg"),
        AskWearFieldBat = Networking.remoteFunction("AskWearFieldBat"),
    }
end

Networking.namespace({name = "Codex", env = "all"})
v1.Codex = v2()

function v2() -- Line: 461 -- upvalues: Networking (val)
    return {InviteLanded = Networking.remoteEvent("InviteLanded")}
end

Networking.namespace({name = "Referrals", env = "all"})
v1.Referrals = {InviteLanded = Networking.remoteEvent("InviteLanded")}
Networking.namespace({name = "LaserGadget", env = "all"})
v1.LaserGadget = (function() -- Line: 466 -- upvalues: Networking (val)
    return {
        AskDischarge = Networking.remoteEvent("AskDischarge"),
        EmitBeam = Networking.remoteEvent("EmitBeam"),
        EmitSfx = Networking.remoteEvent("EmitSfx"),
    }
end)()

function v2() -- Line: 473 -- upvalues: Networking (val)
    return {
        AskTug = Networking.remoteEvent("AskTug"),
        EmitBeam = Networking.remoteEvent("EmitBeam"),
        EmitTargetFx = Networking.remoteEvent("EmitTargetFx"),
        HaltBeam = Networking.remoteEvent("HaltBeam"),
        HaltTargetFx = Networking.remoteEvent("HaltTargetFx"),
    }
end

Networking.namespace({name = "MagnetGadget", env = "all"})
v1.MagnetGadget = v2()

function v2() -- Line: 482 -- upvalues: Networking (val)
    return {
        CloseEffectWindow = Networking.remoteEvent("CloseEffectWindow"),
        EmitFx = Networking.remoteEvent("EmitFx"),
        EmitSfx = Networking.remoteEvent("EmitSfx"),
        OpenEffectWindow = Networking.remoteEvent("OpenEffectWindow"),
        Rouse = Networking.remoteEvent("Rouse"),
    }
end

Networking.namespace({name = "MegaphoneGadget", env = "all"})
v1.MegaphoneGadget = v2()

function v2() -- Line: 491 -- upvalues: Networking (val)
    return {RoundShifted = Networking.remoteEvent("RoundShifted")}
end

Networking.namespace({name = "Whodunnit", env = "all"})
v1.Whodunnit = {RoundShifted = Networking.remoteEvent("RoundShifted")}

function v2() -- Line: 496 -- upvalues: Networking (val)
    return {Raise = Networking.remoteEvent("Raise")}
end

Networking.namespace({name = "Alerts", env = "all"})
v1.Alerts = {Raise = Networking.remoteEvent("Raise")}

function v2() -- Line: 501 -- upvalues: Networking (val)
    return {ShowNotice = Networking.remoteEvent("ShowNotice")}
end

Networking.namespace({name = "RollbackRewards", env = "all"})
v1.RollbackRewards = {ShowNotice = Networking.remoteEvent("ShowNotice")}

function v2() -- Line: 506 -- upvalues: Networking (val)
    return {
        AskCollect = Networking.remoteFunction("AskCollect"),
        FetchSummary = Networking.remoteFunction("FetchSummary"),
        PendingCheck = Networking.remoteFunction("PendingCheck"),
        Redeemed = Networking.remoteEvent("Redeemed"),
        SummaryRefreshed = Networking.remoteEvent("SummaryRefreshed"),
    }
end

Networking.namespace({name = "AwayEarnings", env = "all"})
v1.AwayEarnings = v2()

function v2() -- Line: 515 -- upvalues: Networking (val)
    return {
        AskBaseTierRaise = Networking.remoteEvent("AskBaseTierRaise"),
        AskLobbyHop = Networking.remoteEvent("AskLobbyHop"),
        AskNearbyPurchase = Networking.remoteEvent("AskNearbyPurchase"),
        AskState = Networking.remoteFunction("AskState"),
        BaseTierRaised = Networking.remoteEvent("BaseTierRaised"),
        DimBaseOutline = Networking.remoteEvent("DimBaseOutline"),
        LitBaseOutline = Networking.remoteEvent("LitBaseOutline"),
        StateShifted = Networking.remoteEvent("StateShifted"),
    }
end

Networking.namespace({name = "Homestead", env = "all"})
v1.Homestead = v2()

function v2() -- Line: 527 -- upvalues: Networking (val)
    return {
        Received = Networking.remoteEvent("Received"),
        PromptFinished = Networking.remoteEvent("PromptFinished"),
        AskGift = Networking.remoteFunction("AskGift"),
        Completed = Networking.remoteEvent("Completed"),
    }
end

Networking.namespace({name = "Gifting", env = "all"})
v1.Gifting = v2()

function v2() -- Line: 535 -- upvalues: Networking (val)
    return {
        AllowPurchase = Networking.remoteFunction("AllowPurchase"),
        AskPurchaseOffer = Networking.remoteFunction("AskPurchaseOffer"),
        AskServerProbe = Networking.remoteFunction("AskServerProbe"),
        Awarded = Networking.remoteEvent("Awarded"),
        PurchaseRejected = Networking.remoteEvent("PurchaseRejected"),
        PurchaseSettled = Networking.remoteEvent("PurchaseSettled"),
        ReceiptCleared = Networking.remoteEvent("ReceiptCleared"),
    }
end

Networking.namespace({name = "Storefront", env = "all"})
v1.Storefront = v2()

function v2() -- Line: 546 -- upvalues: Networking (val)
    return {WriteLimpness = Networking.remoteEvent("WriteLimpness")}
end

Networking.namespace({name = "Limpness", env = "all"})
v1.Limpness = {WriteLimpness = Networking.remoteEvent("WriteLimpness")}

function v2() -- Line: 551 -- upvalues: Networking (val)
    return {
        FetchProfile = Networking.remoteFunction("FetchProfile"),
        ProfileDelta = Networking.remoteEvent("ProfileDelta"),
    }
end

Networking.namespace({name = "ProfileMirror", env = "all"})
v1.ProfileMirror = {
    FetchProfile = Networking.remoteFunction("FetchProfile"),
    ProfileDelta = Networking.remoteEvent("ProfileDelta"),
}

function v2() -- Line: 557 -- upvalues: Networking (val)
    return {JoltOnce = Networking.remoteEvent("JoltOnce")}
end

Networking.namespace({name = "SharedFx", env = "all"})
v1.SharedFx = {JoltOnce = Networking.remoteEvent("JoltOnce")}

function v2() -- Line: 562 -- upvalues: Networking (val)
    return {
        AskBriefingConfirm = Networking.remoteFunction("AskBriefingConfirm"),
        AskCraneReturn = Networking.remoteFunction("AskCraneReturn"),
        AskEjectEgg = Networking.remoteFunction("AskEjectEgg"),
        AskGatherPetal = Networking.remoteFunction("AskGatherPetal"),
        AskHandoff = Networking.remoteFunction("AskHandoff"),
        AskLoadEgg = Networking.remoteFunction("AskLoadEgg"),
        AskMutate = Networking.remoteFunction("AskMutate"),
        AskStrikeTree = Networking.remoteEvent("AskStrikeTree"),
        CutsceneOpened = Networking.remoteEvent("CutsceneOpened"),
        PetalsGathered = Networking.remoteEvent("PetalsGathered"),
    }
end

Networking.namespace({name = "Bloomery", env = "all"})
v1.Bloomery = v2()

function v2() -- Line: 576 -- upvalues: Networking (val)
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        StateRefreshed = Networking.remoteEvent("StateRefreshed"),
    }
end

Networking.namespace({name = "LuckWindow", env = "all"})
v1.LuckWindow = {
    FetchState = Networking.remoteFunction("FetchState"),
    StateRefreshed = Networking.remoteEvent("StateRefreshed"),
}

function v2() -- Line: 582 -- upvalues: Networking (val)
    return {
        AskWrite = Networking.remoteFunction("AskWrite"),
        PreferenceShifted = Networking.remoteEvent("PreferenceShifted"),
    }
end

Networking.namespace({name = "Preferences", env = "all"})
v1.Preferences = {
    AskWrite = Networking.remoteFunction("AskWrite"),
    PreferenceShifted = Networking.remoteEvent("PreferenceShifted"),
}
Networking.namespace({name = "MineTrap", env = "all"})
v1.MineTrap = (function() -- Line: 588 -- upvalues: Networking (val)
    return {
        AskPlace = Networking.remoteEvent("AskPlace"),
        AttachOutline = Networking.remoteEvent("AttachOutline"),
        TrapSet = Networking.remoteEvent("TrapSet"),
    }
end)()

function v2() -- Line: 595 -- upvalues: Networking (val)
    return {BeginShutdown = Networking.remoteEvent("BeginShutdown")}
end

Networking.namespace({name = "Lifecycle", env = "all"})
v1.Lifecycle = {BeginShutdown = Networking.remoteEvent("BeginShutdown")}

function v2() -- Line: 600 -- upvalues: Networking (val)
    return {Trigger = Networking.remoteEvent("Trigger")}
end

Networking.namespace({name = "ToolTrigger", env = "all"})
v1.ToolTrigger = {Trigger = Networking.remoteEvent("Trigger")}

function v2() -- Line: 605 -- upvalues: Networking (val)
    return {
        AskChoose = Networking.remoteFunction("AskChoose"),
        AskDoff = Networking.remoteFunction("AskDoff"),
        AskPurchase = Networking.remoteFunction("AskPurchase"),
        AskWornSnapshot = Networking.remoteFunction("AskWornSnapshot"),
        WornTrailShifted = Networking.remoteEvent("WornTrailShifted"),
    }
end

Networking.namespace({name = "Trailwear", env = "all"})
v1.Trailwear = v2()

function v2() -- Line: 614 -- upvalues: Networking (val)
    return {AskPlace = Networking.remoteEvent("AskPlace")}
end

Networking.namespace({name = "TrapPlacement", env = "all"})
v1.TrapPlacement = {AskPlace = Networking.remoteEvent("AskPlace")}

function v2() -- Line: 619 -- upvalues: Networking (val)
    return {
        AskPlace = Networking.remoteEvent("AskPlace"),
        Burst = Networking.remoteEvent("Burst"),
    }
end

Networking.namespace({name = "GravityDisruptor", env = "all"})
v1.GravityDisruptor = {
    AskPlace = Networking.remoteEvent("AskPlace"),
    Burst = Networking.remoteEvent("Burst"),
}

function v2() -- Line: 625 -- upvalues: Networking (val)
    return {
        AskClipFavour = Networking.remoteFunction("AskClipFavour"),
        AskDoff = Networking.remoteFunction("AskDoff"),
        AskFavourSnapshot = Networking.remoteFunction("AskFavourSnapshot"),
        AskFriendFavourSnapshot = Networking.remoteFunction("AskFriendFavourSnapshot"),
        AskPostReply = Networking.remoteFunction("AskPostReply"),
        AskRenderSnapshot = Networking.remoteFunction("AskRenderSnapshot"),
        AskReplyCounts = Networking.remoteFunction("AskReplyCounts"),
        AskReplyFavour = Networking.remoteFunction("AskReplyFavour"),
        AskReplyPage = Networking.remoteFunction("AskReplyPage"),
        AskSlowToggle = Networking.remoteFunction("AskSlowToggle"),
        AskSlowToggleSet = Networking.remoteFunction("AskSlowToggleSet"),
        AskTierRaise = Networking.remoteFunction("AskTierRaise"),
        AskWearStill = Networking.remoteFunction("AskWearStill"),
        AssignedBeltShifted = Networking.remoteEvent("AssignedBeltShifted"),
        GaugeClipLength = Networking.remoteFunction("GaugeClipLength"),
        OverlaySnapshot = Networking.remoteEvent("OverlaySnapshot"),
        RefreshClipCursor = Networking.remoteEvent("RefreshClipCursor"),
        RenderStateShifted = Networking.remoteEvent("RenderStateShifted"),
        SpeedGained = Networking.remoteEvent("SpeedGained"),
        SubmitClipView = Networking.remoteEvent("SubmitClipView"),
        ViewStateShifted = Networking.remoteEvent("ViewStateShifted"),
    }
end

Networking.namespace({name = "Treadmill", env = "all"})
v1.Treadmill = v2()

function v2() -- Line: 650 -- upvalues: Networking (val)
    return {AnchorForZone = Networking.remoteEvent("AnchorForZone")}
end

Networking.namespace({name = "ZoneProbe", env = "all"})
v1.ZoneProbe = {AnchorForZone = Networking.remoteEvent("AnchorForZone")}

function v2() -- Line: 655 -- upvalues: Networking (val)
    return {
        GetWins = Networking.remoteFunction("GetWins"),
        WinsUpdated = Networking.remoteEvent("WinsUpdated"),
        GetWinParts = Networking.remoteFunction("GetWinParts"),
        WinPartsUpdated = Networking.remoteEvent("WinPartsUpdated"),
        RequestTeleport = Networking.remoteFunction("RequestTeleport"),
        PlaySFX = Networking.remoteEvent("PlaySFX"),
    }
end

Networking.namespace({name = "MonsterEvent", env = "all"})
v1.MonsterEvent = v2()

function v2() -- Line: 665 -- upvalues: Networking (val)
    return {
        AskState = Networking.remoteFunction("AskState"),
        AskSubmit = Networking.remoteFunction("AskSubmit"),
        Feedback = Networking.remoteEvent("Feedback"),
        StateChanged = Networking.remoteEvent("StateChanged"),
        Ritual = Networking.remoteEvent("Ritual"),
    }
end

Networking.namespace({name = "ShrineFusion", env = "all"})
v1.ShrineFusion = v2()

function v2() -- Line: 674 -- upvalues: Networking (val)
    return {
        AskClaim = Networking.remoteFunction("AskClaim"),
        Aim = Networking.remoteEvent("Aim"),
        BridgeFormed = Networking.remoteEvent("BridgeFormed"),
        Effect = Networking.remoteEvent("Effect"),
        Squish = Networking.remoteEvent("Squish"),
    }
end

Networking.namespace({name = "BanjoCricket", env = "all"})
v1.BanjoCricket = v2()

function v2() -- Line: 683 -- upvalues: Networking (val)
    return {
        AskState = Networking.remoteFunction("AskState"),
        AskTradeIn = Networking.remoteFunction("AskTradeIn"),
        AskRefresh = Networking.remoteFunction("AskRefresh"),
        AskFinishReveal = Networking.remoteFunction("AskFinishReveal"),
        BannerRotated = Networking.remoteEvent("BannerRotated"),
    }
end

Networking.namespace({name = "Rift", env = "all"})
v1.Rift = v2()

function v2() -- Line: 692 -- upvalues: Networking (val)
    return {
        AskState = Networking.remoteFunction("AskState"),
        AskTradeIn = Networking.remoteFunction("AskTradeIn"),
        AskRefresh = Networking.remoteFunction("AskRefresh"),
        AskFinishReveal = Networking.remoteFunction("AskFinishReveal"),
        BannerRotated = Networking.remoteEvent("BannerRotated"),
    }
end

Networking.namespace({name = "ScrambleTradeIn", env = "all"})
v1.ScrambleTradeIn = v2()

function v2() -- Line: 701 -- upvalues: Networking (val)
    return {Show = Networking.remoteEvent("Show")}
end

Networking.namespace({name = "RewardScreen", env = "all"})
v1.RewardScreen = {Show = Networking.remoteEvent("Show")}

function v2() -- Line: 706 -- upvalues: Networking (val)
    return {
        AskAcknowledge = Networking.remoteFunction("AskAcknowledge"),
        AskClaim = Networking.remoteFunction("AskClaim"),
    }
end

Networking.namespace({name = "OnboardingQuestline", env = "all"})
v1.OnboardingQuestline = {
    AskAcknowledge = Networking.remoteFunction("AskAcknowledge"),
    AskClaim = Networking.remoteFunction("AskClaim"),
}

function v2() -- Line: 712 -- upvalues: Networking (val)
    return {
        AskEnter = Networking.remoteFunction("AskEnter"),
        AskSnapshot = Networking.remoteFunction("AskSnapshot"),
        BlackHoleHit = Networking.remoteEvent("BlackHoleHit"),
        BossDamaged = Networking.remoteEvent("BossDamaged"),
        HazardHit = Networking.remoteEvent("HazardHit"),
        HealthShifted = Networking.remoteEvent("HealthShifted"),
        StateShifted = Networking.remoteEvent("StateShifted"),
        Vfx = Networking.remoteEvent("Vfx"),
    }
end

Networking.namespace({name = "BossEvent", env = "all"})
v1.BossEvent = v2()

function v2() -- Line: 726 -- upvalues: Networking (val)
    return {
        EnterArena = Networking.remoteFunction("EnterArena"),
        Fx = Networking.remoteEvent("Fx"),
        Hazard = Networking.remoteEvent("Hazard"),
        HazardHit = Networking.remoteEvent("HazardHit"),
        Transition = Networking.remoteEvent("Transition"),
    }
end

Networking.namespace({name = "ScrambleBoss", env = "all"})
v1.ScrambleBoss = v2()

function v2() -- Line: 735 -- upvalues: Networking (val)
    return {
        Fx = Networking.remoteEvent("Fx"),
        Hazard = Networking.remoteEvent("Hazard"),
        HazardHit = Networking.remoteEvent("HazardHit"),
        Transition = Networking.remoteEvent("Transition"),
        CannonFire = Networking.remoteEvent("CannonFire"),
        Drops = Networking.remoteEvent("Drops"),
        Collect = Networking.remoteEvent("Collect"),
        RemoveDrops = Networking.remoteEvent("RemoveDrops"),
    }
end

Networking.namespace({name = "PumpkinBoss", env = "all"})
v1.PumpkinBoss = v2()

function v2() -- Line: 747 -- upvalues: Networking (val)
    return {
        Talk = Networking.remoteFunction("Talk"),
        Collect = Networking.remoteFunction("Collect"),
        Cast = Networking.remoteFunction("Cast"),
        Dive = Networking.remoteFunction("Dive"),
        Restart = Networking.remoteFunction("Restart"),
        Claim = Networking.remoteFunction("Claim"),
        Surface = Networking.remoteFunction("Surface"),
        Abort = Networking.remoteFunction("Abort"),
    }
end

Networking.namespace({name = "GhostDogQuest", env = "all"})
v1.GhostDogQuest = v2()

function v2() -- Line: 759 -- upvalues: Networking (val)
    return {
        Hold = Networking.remoteEvent("Hold"),
        Cast = Networking.remoteFunction("Cast"),
        Reel = Networking.remoteFunction("Reel"),
        Cancel = Networking.remoteEvent("Cancel"),
    }
end

Networking.namespace({name = "Fishing", env = "all"})
v1.Fishing = v2()
Networking.namespace({name = "BossMastery", env = "all"})
v1.BossMastery = (function() -- Line: 767 -- upvalues: Networking (val)
    return {
        AskBuyShopItem = Networking.remoteFunction("AskBuyShopItem"),
        AskClaimMilestone = Networking.remoteFunction("AskClaimMilestone"),
        AskUseMutationConsumable = Networking.remoteFunction("AskUseMutationConsumable"),
    }
end)()

function v2() -- Line: 774 -- upvalues: Networking (val)
    return {
        Fetch = Networking.remoteFunction("Fetch"),
        Updated = Networking.remoteEvent("Updated"),
    }
end

Networking.namespace({name = "Leaderboards", env = "all"})
v1.Leaderboards = {
    Fetch = Networking.remoteFunction("Fetch"),
    Updated = Networking.remoteEvent("Updated"),
}

function v2() -- Line: 780 -- upvalues: Networking (val)
    return {Vote = Networking.remoteEvent("Vote")}
end

Networking.namespace({name = "Voting", env = "all"})
v1.Voting = {Vote = Networking.remoteEvent("Vote")}

function v2() -- Line: 785 -- upvalues: Networking (val)
    return {ShowLimitedTimePopup = Networking.remoteEvent("ShowLimitedTimePopup")}
end

Networking.namespace({name = "LimitedTimePopups", env = "all"})
v1.LimitedTimePopups = {ShowLimitedTimePopup = Networking.remoteEvent("ShowLimitedTimePopup")}

function v2() -- Line: 790 -- upvalues: Networking (val)
    return {Request = Networking.remoteFunction("Request")}
end

Networking.namespace({name = "PetMount", env = "all"})
v1.PetMount = {Request = Networking.remoteFunction("Request")}

function v2() -- Line: 793 -- upvalues: Networking (val)
    return {Request = Networking.remoteFunction("Request")}
end

Networking.namespace({name = "WispCompanion", env = "all"})
v1.WispCompanion = {Request = Networking.remoteFunction("Request")}

function v2() -- Line: 796 -- upvalues: Networking (val)
    return {
        AskState = Networking.remoteFunction("AskState"),
        Fall = Networking.remoteEvent("Fall"),
        Wander = Networking.remoteEvent("Wander"),
        Hold = Networking.remoteEvent("Hold"),
        Catch = Networking.remoteEvent("Catch"),
        Slipped = Networking.remoteEvent("Slipped"),
        Claimed = Networking.remoteEvent("Claimed"),
        Celebrate = Networking.remoteEvent("Celebrate"),
        Expired = Networking.remoteEvent("Expired"),
        AskFeed = Networking.remoteFunction("AskFeed"),
        Fed = Networking.remoteEvent("Fed"),
    }
end

Networking.namespace({name = "ShootingStar", env = "all"})
v1.ShootingStar = v2()

function v2() -- Line: 811 -- upvalues: Networking (val)
    return {
        AskSwarm = Networking.remoteFunction("AskSwarm"),
        AskSwing = Networking.remoteFunction("AskSwing"),
        AskClaimNet = Networking.remoteFunction("AskClaimNet"),
        AskTradeUp = Networking.remoteFunction("AskTradeUp"),
        AskCraftEssence = Networking.remoteFunction("AskCraftEssence"),
        Spawned = Networking.remoteEvent("Spawned"),
        Escaped = Networking.remoteEvent("Escaped"),
        Removed = Networking.remoteEvent("Removed"),
        Announce = Networking.remoteEvent("Announce"),
        NetClaimed = Networking.remoteEvent("NetClaimed"),
    }
end

Networking.namespace({name = "Butterflies", env = "all"})
v1.Butterflies = v2()

function v2() -- Line: 825 -- upvalues: Networking (val)
    return {Transition = Networking.remoteEvent("Transition")}
end

Networking.namespace({name = "EnchantedTree", env = "all"})
v1.EnchantedTree = {Transition = Networking.remoteEvent("Transition")}

function v2() -- Line: 830 -- upvalues: Networking (val)
    return {
        Travel = Networking.remoteEvent("Travel"),
        Arrive = Networking.remoteFunction("Arrive"),
        Leave = Networking.remoteFunction("Leave"),
        MetWorker = Networking.remoteEvent("MetWorker"),
    }
end

Networking.namespace({name = "SewerCave", env = "all"})
v1.SewerCave = v2()

function v2() -- Line: 838 -- upvalues: Networking (val)
    return {
        Travel = Networking.remoteEvent("Travel"),
        Request = Networking.remoteFunction("Request"),
        Arrive = Networking.remoteFunction("Arrive"),
        Leave = Networking.remoteFunction("Leave"),
    }
end

Networking.namespace({name = "ManorInterior", env = "all"})
v1.ManorInterior = v2()

function v2() -- Line: 846 -- upvalues: Networking (val)
    return {
        Spin = Networking.remoteFunction("Spin"),
        Finish = Networking.remoteEvent("Finish"),
    }
end

Networking.namespace({name = "PetWheel", env = "all"})
v1.PetWheel = {Spin = Networking.remoteFunction("Spin"), Finish = Networking.remoteEvent("Finish")}
Networking.namespace({name = "RaceRally", env = "all"})
v1.RaceRally = (function() -- Line: 852 -- upvalues: Networking (val)
    return {
        AskBuy = Networking.remoteFunction("AskBuy"),
        AskClaimMilestone = Networking.remoteFunction("AskClaimMilestone"),
        AskEquipRacer = Networking.remoteFunction("AskEquipRacer"),
    }
end)()

function v2() -- Line: 859 -- upvalues: Networking (val)
    return {AskEnter = Networking.remoteFunction("AskEnter")}
end

Networking.namespace({name = "TheHollow", env = "all"})
v1.TheHollow = {AskEnter = Networking.remoteFunction("AskEnter")}

function v2() -- Line: 864 -- upvalues: Networking (val)
    return {
        Fetch = Networking.remoteFunction("Fetch"),
        State = Networking.remoteEvent("State"),
        Moment = Networking.remoteEvent("Moment"),
        Use = Networking.remoteEvent("Use"),
        OutroFinished = Networking.remoteEvent("OutroFinished"),
    }
end

Networking.namespace({name = "IslandWars", env = "all"})
v1.IslandWars = v2()
Networking.close()
return v1