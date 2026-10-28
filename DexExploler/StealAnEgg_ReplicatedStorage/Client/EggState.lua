-- Script path: ReplicatedStorage.Client.EggState
-- Decompile time: 17.11 ms

local keepAsking
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local Log = require(ReplicatedStorage.Packages.Log)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Promise = require(ReplicatedStorage.Packages.Promise)
local OnboardingTiming = require(ReplicatedStorage.Shared.Util.OnboardingTiming)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local t = require(ReplicatedStorage.Packages.t)
local EggWorld = Remotes.EggWorld
local u65 = {}
u65.SnapshotRefreshed = Signal.new()
u65.OwnerRefreshed = Signal.new()
u65.OwnerCleared = Signal.new()
u65.FieldRefreshed = Signal.new()
u65.FieldShifted = Signal.new()
u65.FieldGone = Signal.new()
u65.CarryChanged = Signal.new()
u65.FieldClaimed = Signal.new()
u65.ResetCountdown = Signal.new()
u65.RarityRevealed = Signal.new()
u65.RarityPresented = Signal.new()
u65.ResetFade = Signal.new()
local u93 = t.strict(t.string)
local u96 = t.strict(t.number)
local u99 = t.strict(t.boolean)
local u104 = t.strict(t.optional(t.string))
local u107 = t.strict(t.CFrame)
local u110 = Log.new()
local LocalPlayer = Players.LocalPlayer
local u112 = {}
local u113 = {}
local u114 = {}
local u115 = {}
local u116 = 0
local u117 = 0
local u118 = nil
local u119 = {}
local u120 = nil
local u121 = false
local u122 = {IsCarrying = false}

local function twin(a1) -- Line: 77 -- upvalues: TableUtil (val)
    return TableUtil.Copy(a1, true)
end

local function stampOwner(a1) -- Line: 79 -- upvalues: u116 (ref), u114 (val) -- types: a1: number
    u116 = u116 + 1
    u114[a1] = u116
end

local function stampField(a1) -- Line: 84 -- upvalues: u117 (ref), u115 (val) -- types: a1: string
    u117 = u117 + 1
    u115[a1] = u117
end

local function ownedRows() -- Line: 89 -- upvalues: u112 (ref), TableUtil (val)
    local v1 = {}
    for i, j in u112 do
        table.insert(v1, {OwnerUserId = i, Records = TableUtil.Copy(j, true)})
    end
    return v1
end

local function fieldRows() -- Line: 97 -- upvalues: u113 (ref), twin (val), Workspace (val)
    local v1 = {}
    for i, j in u113 do
        table.insert(v1, (twin(j)))
    end
    return {Records = v1, ServerTime = Workspace:GetServerTimeNow()}
end

local function tellOwned() -- Line: 105 -- upvalues: u65 (val), ownedRows (val)
    u65.SnapshotRefreshed:Fire((ownedRows()))
end

local function tellField() -- Line: 107 -- upvalues: u65 (val), fieldRows (val)
    u65.FieldRefreshed:Fire((fieldRows()))
end

local function dropOwner(a1) -- Line: 109 -- upvalues: u112 (ref), u65 (val), ownedRows (val) -- types: a1: number
    u112[a1] = nil
    u65.OwnerCleared:Fire(a1)
    u65.SnapshotRefreshed:Fire((ownedRows()))
end

local function adoptOwned(a1, a2) -- Line: 115
    -- upvalues: u112 (ref), u114 (val), TableUtil (val), u65 (val), ownedRows (val)
    local OwnerUserId, v1
    local v2 = {}
    local v3 = u112
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in v3, v4, v5 do
        v1 = if not (v7 < (u114[i] or 0)) then nil else TableUtil.Copy(j, true)
        v2[i] = v1
    end
    for i2, v in ipairs(v6) do
        v1 = (u114[v.OwnerUserId] or 0) <= v7
        OwnerUserId = v.OwnerUserId
        v2[OwnerUserId] = if not v1 then v2[v.OwnerUserId] else TableUtil.Copy(v.Records, true)
    end
    u112 = v2
    u65.SnapshotRefreshed:Fire((ownedRows()))
end

local function adoptField(a1, a2) -- Line: 129
    -- upvalues: u113 (ref), u115 (val), TableUtil (val), u65 (val), fieldRows (val)
    local Uid, v1, v2
    local v3 = {}
    local v4 = u113
    local v5 = nil
    local v6 = nil
    local v7, v8 = a1, a2
    for i, j in v4, v5, v6 do
        v2 = if not (v8 < (u115[i] or 0)) then nil else TableUtil.Copy(j, true)
        v3[i] = v2
    end
    for i2, v in ipairs(v7.Records) do
        v2 = (u115[v.Uid] or 0) <= v8
        Uid = v.Uid
        v1 = if not v2 then v3[v.Uid] else TableUtil.Copy(v, true)
        v3[Uid] = v1
    end
    u113 = v3
    u65.FieldRefreshed:Fire((fieldRows()))
end

function keepAsking(a1, a2) -- Line: 143 -- upvalues: u110 (val), keepAsking (val) -- types: a1: string, a2: function
    local success, err = pcall(a2)
    if success then
        return
    end
    ;(u110:AtError()):Log((("%* never landed, going round again: %*"):format(a1, err)))
    task.delay(5, keepAsking, a1, a2)
end

local function outcome(a1, a2) -- Line: 154
    local v1 = a1 == true
    if typeof(a2) == "string" then
        return v1, a2
    end
    return v1, nil
end

function u65.FetchEggRecord(a1) -- Line: 158
    -- upvalues: u93 (val), EggWorld (val), Eggs (val), twin (val), u110 (val)
    u93(a1)
    local v1 = EggWorld.AskEggRecord:InvokeServer(a1)
    if v1 == nil then
        return nil
    end
    local v2, v3 = Eggs.SchemaValidation.SavedEgg(v1)
    if v2 then
        return twin(v1)
    end
    ;(u110:AtError()):Log((("the egg record for %* came back malformed: %*"):format(a1, v3)))
    return nil
end

function u65.SyncOwnedEggs() -- Line: 175
    -- upvalues: u116 (ref), EggWorld (val), Eggs (val), adoptOwned (val), ownedRows (val)
    local v1 = u116
    local v2 = EggWorld.AskLiveSnapshot:InvokeServer()
    local v3, v4 = Eggs.SchemaValidation.RuntimeEggSnapshot(v2)
    assert(v3, (("the owned egg snapshot failed validation: %*"):format(v4)))
    adoptOwned(v2, v1)
    return (ownedRows())
end

function u65.SyncFieldEggs() -- Line: 185
    -- upvalues: u120 (ref), u117 (ref), Promise (val), EggWorld (val), AreaEggs (val), u121 (ref), adoptField (val)
    -- upvalues: OnboardingTiming (val), fieldRows (val)
    local u14 = u120
    if u14 == nil then
        local u1 = u117
        u14 = (Promise.try(function() -- Line: 189 -- upvalues: EggWorld (upval), AreaEggs (upval)
            local v1 = EggWorld.AskFieldEggSnapshot:InvokeServer()
            local v2, v3 = AreaEggs.SchemaValidation.AreaEggSnapshot(v1)
            assert(v2, (("the field egg snapshot failed validation: %*"):format(v3)))
            return v1
        end):timeout(30)):andThen(function(a1) -- Line: 194 -- upvalues: u121 (upval), adoptField (upval), u1 (val), OnboardingTiming (upval)
            u121 = true
            adoptField(a1, u1)
            OnboardingTiming.Mark("FieldSnapshotReceived")
        end)
        u120 = u14
        ;(u14:finally(function() -- Line: 200 -- upvalues: u120 (upval), u14 (ref)
            if u120 == u14 then
                u120 = nil
            end
        end)):catch(function() end)
    end
    local v1, v2 = u14:await()
    if not v1 then
        error(tostring(v2), 2)
    end
    return (fieldRows())
end

function u65.FetchRarityShows() -- Line: 214 -- upvalues: EggWorld (val), u99 (val), AreaEggResetCycle (val)
    local v1, v2 = EggWorld.AskFieldEggRarityShows:InvokeServer()
    u99(v1)
    if v1 == true and v2 ~= nil then
        local v3, v4 = AreaEggResetCycle.SchemaValidation.RevealPayload(v2)
        assert(v3, (("the rare spawn reveal payload failed validation: %*"):format(v4)))
        return true, v2
    end
    return v1 == true, nil
end

function u65.WearEggTool(a1) -- Line: 226 -- upvalues: u93 (val), outcome (val), EggWorld (val) -- types: a1: string
    u93(a1)
    return outcome(EggWorld.AskWearTool:InvokeServer(a1))
end

function u65.DoffEggTool(a1) -- Line: 231 -- upvalues: u104 (val), outcome (val), EggWorld (val) -- types: a1: string?
    u104(a1)
    return outcome(EggWorld.AskDoffTool:InvokeServer(a1))
end

function u65.CarryFieldEgg(a1, a2) -- Line: 236
    -- upvalues: u93 (val), u104 (val), outcome (val), EggWorld (val)
    u93(a1)
    u104(a2)
    return outcome(EggWorld.AskFieldEggCarry:InvokeServer({Uid = a1, FirstAreaSlotKey = a2}))
end

function u65.DropFieldEgg(a1) -- Line: 244 -- upvalues: AreaEggs (val), outcome (val), EggWorld (val)
    local v1, v2 = AreaEggs.SchemaValidation.DropReason(a1)
    local v3 = true
    if a1 ~= nil then
        v3 = v1
    end
    assert(v3, v2)
    return outcome(EggWorld.AskFieldEggDrop:InvokeServer({Reason = a1}))
end

function u65.PlantEgg(a1, a2) -- Line: 250
    -- upvalues: u93 (val), u107 (val), u119 (val), EggWorld (val)
    u93(a1)
    u107(a2)
    u119[a1] = true
    local v1, v2 = EggWorld.AskPlaceEgg:InvokeServer({Uid = a1, LocalCFrame = a2})
    local v3 = v1 == true
    local v4 = if typeof(v2) ~= "string" then nil else v2
    if not v3 then
        u119[a1] = nil
    end
    return v3, v4
end

function u65.TakePlantCue(a1) -- Line: 267 -- upvalues: u93 (val), u119 (val) -- types: a1: string
    u93(a1)
    local v1 = u119[a1] == true
    u119[a1] = nil
    return v1
end

function u65.BeginSkipGrowth(a1) -- Line: 275
    -- upvalues: u93 (val), EggWorld (val), u118 (ref), u110 (val)
    u93(a1)
    local v1, v2, v3 = EggWorld.AskSkipGrowth:InvokeServer(a1)
    if v1 ~= true then
        return false, if typeof(v2) ~= "string" then nil else v2, nil
    end
    v2 = if typeof(v3) ~= "number" then nil else v3
    if v2 ~= nil then
        u118 = a1
        return true, nil, v2
    end
    u110:AtError():Log("skip-growth was granted but arrived without a product id")
    return false, "Invalid skip growth product", nil
end

function u65.BeginHatch(a1) -- Line: 293 -- upvalues: u93 (val), EggWorld (val) -- types: a1: string
    u93(a1)
    local v1, v2, v3 = EggWorld.AskHatch:InvokeServer(a1)
    local v4 = v1 == true
    local v5 = if typeof(v2) ~= "string" then nil else v2
    if typeof(v3) == "string" then
        return v4, v5, v3
    end
    return v4, v5, nil
end

function u65.FinishHatch(a1) -- Line: 302 -- upvalues: u93 (val), EggWorld (val), u110 (val) -- types: a1: string
    u93(a1)
    local v1, v2, v3 = EggWorld.AskFinishHatch:InvokeServer(a1)
    if v1 ~= true then
        return false, if typeof(v2) ~= "string" then nil else v2, nil
    end
    v2 = if typeof(v3) ~= "string" then nil else v3
    if v2 ~= nil then
        return true, nil, v2
    end
    u110:AtError():Log("the hatch finished but the granted asset uid was not a string")
    return false, "Invalid granted asset UID", nil
end

function u65.ReadChosenSkipUid() -- Line: 319 -- upvalues: u118 (ref)
    return u118
end

function u65.ForgetChosenSkip() -- Line: 321 -- upvalues: u118 (ref)
    u118 = nil
end

function u65.ReadOwnedEggs() -- Line: 323 -- upvalues: ownedRows (val)
    return (ownedRows())
end

function u65.ReadFieldEggs() -- Line: 325 -- upvalues: fieldRows (val)
    return (fieldRows())
end

function u65.HasFieldSnapshot() -- Line: 327 -- upvalues: u121 (ref)
    return u121
end

function u65.ReadCarryState() -- Line: 329 -- upvalues: twin (val), u122 (ref)
    return twin(u122)
end

function u65.ReadOwnerEggs(a1) -- Line: 331 -- upvalues: u96 (val), u112 (ref), TableUtil (val) -- types: a1: number
    u96(a1)
    local v1 = u112[a1]
    if v1 ~= nil then
        return (TableUtil.Copy(v1, true))
    end
    return {}
end

function u65.ReadOwnedEgg(a1, a2) -- Line: 338
    -- upvalues: u96 (val), u93 (val), u112 (ref), TableUtil (val)
    u96(a1)
    u93(a2)
    local v1 = u112[a1]
    local v2 = if v1 == nil then nil else v1[a2]
    if v2 ~= nil then
        return (TableUtil.Copy(v2, true))
    end
    return nil
end

function u65.ReadFieldEgg(a1) -- Line: 347 -- upvalues: u93 (val), u113 (ref), TableUtil (val) -- types: a1: string
    u93(a1)
    local v1 = u113[a1]
    if v1 ~= nil then
        return (TableUtil.Copy(v1, true))
    end
    return nil
end

function u65.IsReadyToHatch(a1) -- Line: 354
    -- upvalues: u93 (val), u65 (val), LocalPlayer (val), Workspace (val), EggRecords (val)
    u93(a1)
    local v1 = u65.ReadOwnedEgg(LocalPlayer.UserId, a1)
    if v1 ~= nil and v1.Placement ~= nil then
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local GrowthSpeedMultiplier = v1.GrowthSpeedMultiplier
        return EggRecords.IsGrown(
            v1,
            ServerTimeNow,
            GrowthSpeedMultiplier,
            EggRecords.CurrentNightCredit(v1, ServerTimeNow, GrowthSpeedMultiplier),
            LocalPlayer
        )
    end
    return false
end

function u65.MayBuyChosenSkip() -- Line: 368 -- upvalues: u118 (ref), u65 (val), LocalPlayer (val)
    local v1 = u118
    if not v1 then
        return false, "No egg selected"
    end
    local v2 = u65.ReadOwnedEgg(LocalPlayer.UserId, v1)
    local v3 = false
    if v2 ~= nil then
        v3 = v2.Placement ~= nil
    end
    if not v3 then
        return false, "Egg not placed"
    end
    if u65.IsReadyToHatch(v1) then
        return false, "Egg is already ready"
    end
    return true
end

function u65.MayBuyGrowAll() -- Line: 386 -- upvalues: u112 (ref), LocalPlayer (val), u65 (val)
    for i, j in u112[LocalPlayer.UserId] or {} do
        if j.Placement ~= nil and not u65.IsReadyToHatch(i) then
            return true
        end
    end
    return false, "You have no growing eggs!"
end

for i, v in ipairs({
    {
        complaint = "an owned egg write turned up malformed",
        feed = EggWorld.OwnerShifted,
        vet = Eggs.SchemaValidation.RuntimeEggOwnerUpdate,
        apply = function(a1) -- Line: 402 -- upvalues: u116 (ref), u114 (val), u112 (ref), TableUtil (val), u65 (val), ownedRows (val)
            local OwnerRefreshed, OwnerUserId, OwnerUserId_2, OwnerUserId_3, OwnerUserId_4, ReadOwnerEggs, Records, SnapshotRefreshed, v1, v2, v3, v4
            OwnerUserId = a1.OwnerUserId
            u116 = u116 + 1
            u114[OwnerUserId] = u116
            u112[a1.OwnerUserId] = (TableUtil.Copy(a1.Records, true))
            u65.OwnerRefreshed:Fire(a1.OwnerUserId, (u65.ReadOwnerEggs(a1.OwnerUserId)))
            u65.SnapshotRefreshed:Fire((ownedRows()))
            return
        end,
    },
    {
        complaint = "an owned egg erase turned up malformed",
        feed = EggWorld.OwnerDropped,
        vet = Eggs.SchemaValidation.RuntimeEggOwnerClear,
        apply = function(a1) -- Line: 413 -- upvalues: u116 (ref), u114 (val), u112 (ref), u65 (val), ownedRows (val)
            local OwnerUserId, OwnerUserId_2, SnapshotRefreshed, v2, v3, v4
            OwnerUserId = a1.OwnerUserId
            u116 = u116 + 1
            u114[OwnerUserId] = u116
            OwnerUserId_2 = a1.OwnerUserId
            u112[OwnerUserId_2] = nil
            u65.OwnerCleared:Fire(OwnerUserId_2)
            u65.SnapshotRefreshed:Fire((ownedRows()))
            return
        end,
    },
    {
        complaint = "a field egg write turned up malformed",
        feed = EggWorld.FieldEggShifted,
        vet = AreaEggs.SchemaValidation.AreaEggRecord,
        apply = function(a1) -- Line: 422 -- upvalues: u117 (ref), u115 (val), u113 (ref), TableUtil (val), u65 (val)
            local FieldShifted, ReadFieldEgg, Uid, Uid_2, v1, v2, v3
            Uid = a1.Uid
            u117 = u117 + 1
            u115[Uid] = u117
            u113[a1.Uid] = (TableUtil.Copy(a1, true))
            u65.FieldShifted:Fire((u65.ReadFieldEgg(a1.Uid)))
            return
        end,
    },
    {
        complaint = "a field egg removal turned up malformed",
        feed = EggWorld.FieldEggGone,
        vet = function(a1) -- Line: 430
            local v1
            return typeof(a1) == "string", "expected a uid string"
        end,
        apply = function(a1) -- Line: 432 -- upvalues: u117 (ref), u115 (val), u113 (ref), u65 (val)
            local v1, v2
            u117 = u117 + 1
            u115[a1] = u117
            u113[a1] = nil
            u65.FieldGone:Fire(a1)
            return
        end,
    },
    {
        complaint = "a field egg batch turned up malformed",
        feed = EggWorld.FieldEggBatchShifted,
        vet = AreaEggs.SchemaValidation.AreaEggBatchUpdate,
        apply = function(a1) -- Line: 442 -- upvalues: u117 (ref), u115 (val), u113 (ref), TableUtil (val), u65 (val), fieldRows (val)
            local FieldRefreshed, Uid, v1, v2, v3, v4, v5
            for i, v in ipairs(a1.RemovedUids) do
                u117 = u117 + 1
                u115[v] = u117
                u113[v] = nil
            end
            for i2, i3 in ipairs(a1.UpdatedRecords) do
                Uid = i3.Uid
                u117 = u117 + 1
                u115[Uid] = u117
                u113[i3.Uid] = (TableUtil.Copy(i3, true))
            end
            u65.FieldRefreshed:Fire((fieldRows()))
            return
        end,
    },
    {
        complaint = "a field egg carry state turned up malformed",
        feed = EggWorld.FieldEggCarry,
        vet = AreaEggs.SchemaValidation.AreaEggCarryState,
        apply = function(a1) -- Line: 458 -- upvalues: u122 (ref), TableUtil (val), u65 (val), twin (val)
            local CarryChanged, v1, v2, v3, v4
            u122 = TableUtil.Copy(a1, true)
            u65.CarryChanged:Fire((twin(u122)))
            return
        end,
    },
    {
        complaint = "a field egg claim verdict turned up malformed",
        feed = EggWorld.FieldEggRedeemVerdict,
        vet = AreaEggs.SchemaValidation.AreaEggClaimFeedback,
        apply = function(a1) -- Line: 467 -- upvalues: u110 (val), LocalPlayer (val), Workspace (val), u65 (val)
            local v1, v2, v4, v5, v6
            ;(u110:AtInfo()):Log("Area egg claim latency trace", {
                Stage = "CLIENT_FEEDBACK_RECEIVED",
                UserId = LocalPlayer.UserId,
                ServerTime = Workspace:GetServerTimeNow(),
                AssetCategory = a1.AssetCategory,
                DisplayName = a1.DisplayName,
            })
            u65.FieldClaimed:Fire(a1)
            return
        end,
    },
    {
        complaint = "a field egg reset sequence turned up malformed",
        feed = EggWorld.FieldEggCycleCountdown,
        vet = AreaEggResetCycle.SchemaValidation.SequencePayload,
        apply = function(a1) -- Line: 482 -- upvalues: u65 (val)
            local v1, v2
            u65.ResetCountdown:Fire(a1)
            return
        end,
    },
    {
        complaint = "a field egg rarity reveal turned up malformed",
        feed = EggWorld.FieldEggRaritiesShown,
        vet = AreaEggResetCycle.SchemaValidation.RevealPayload,
        apply = function(a1) -- Line: 488 -- upvalues: u65 (val)
            local v1, v2
            u65.RarityRevealed:Fire(a1)
            return
        end,
    },
}) do
    v.feed.OnClientEvent:Connect(function(a1) -- Line: 493 -- upvalues: v (val), u110 (val)
        local v1, v2 = v.vet(a1)
        if v1 then
            v.apply(a1)
            return
        end
        ;(u110:AtError()):Log((("%*: %*"):format(v.complaint, v2)))
    end)
end
Players.PlayerRemoving:Connect(function(a1) -- Line: 504
    -- upvalues: u116 (ref), u114 (val), u112 (ref), u65 (val), ownedRows (val)
    local UserId = a1.UserId
    u116 = u116 + 1
    u114[UserId] = u116
    local UserId_2 = a1.UserId
    u112[UserId_2] = nil
    u65.OwnerCleared:Fire(UserId_2)
    u65.SnapshotRefreshed:Fire((ownedRows()))
end)
task.spawn(keepAsking, "the owned egg snapshot", u65.SyncOwnedEggs)
task.spawn(keepAsking, "the field egg snapshot", u65.SyncFieldEggs)
return u65