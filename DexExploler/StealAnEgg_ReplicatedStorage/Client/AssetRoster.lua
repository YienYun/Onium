-- Script path: ReplicatedStorage.Client.AssetRoster
-- Decompile time: 6.80 ms

local pullUntilAnswered
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local PenRoster = Remotes.PenRoster
local u32 = {}
u32.SnapshotRefreshed = Signal.new()
u32.OwnerRefreshed = Signal.new()
u32.OwnerCleared = Signal.new()
u32.PenAreaChanged = Signal.new()
local u42 = Log.new()
local u43 = {}
local u44 = {}
local u45 = 0

local function copyContents(a1) -- Line: 47
    local v1, v2
    local v3 = {}
    for i, j in a1 do
        v1 = table.clone(j.ItemData)
        v1.Mutations = table.clone(j.ItemData.Mutations)
        v2 = {
            OwnerUserId = j.OwnerUserId,
            UID = j.UID,
            ItemData = v1,
            MoneyPerSecond = j.MoneyPerSecond,
            Seed = j.Seed,
            IsFirstPlacement = j.IsFirstPlacement,
        }
        v3[i] = v2
    end
    return v3
end

local function everyPen() -- Line: 64 -- upvalues: u43 (ref), copyContents (val)
    local v1 = {}
    for i, j in u43 do
        table.insert(v1, {OwnerUserId = i, Records = copyContents(j)})
    end
    return v1
end

local function announce() -- Line: 72 -- upvalues: u32 (val), everyPen (val)
    u32.SnapshotRefreshed:Fire((everyPen()))
end

local function adopt(a1, a2) -- Line: 74
    -- upvalues: u43 (ref), u44 (val), copyContents (val), u32 (val), everyPen (val)
    local OwnerUserId, v1, v2, v3
    local v4 = {}
    local v5 = u43
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in v5, v6, v7 do
        v3 = if not (v9 < (u44[i] or 0)) then nil else copyContents(j)
        v4[i] = v3
    end
    for i2, v in ipairs(v8) do
        v2 = (u44[v.OwnerUserId] or 0) <= v9
        OwnerUserId = v.OwnerUserId
        v1 = if not v2 then v4[v.OwnerUserId] else copyContents(v.Records)
        v4[OwnerUserId] = v1
    end
    u43 = v4
    u32.SnapshotRefreshed:Fire((everyPen()))
end

function pullUntilAnswered() -- Line: 89
    -- upvalues: u45 (ref), PenRoster (val), AssetRuntime (val), adopt (val), u42 (val), pullUntilAnswered (val)
    local v1 = u45
    local success, err = pcall(function() -- Line: 91 -- upvalues: PenRoster (upval)
        return PenRoster.AskLiveSnapshot:InvokeServer()
    end)
    local v2 = false
    local v3 = if not success then tostring(err) else nil
    if success then
        local v4, v5 = AssetRuntime.SchemaValidation.RuntimeAssetSnapshot(err)
        v2 = v4
        v3 = v5
    end
    if v2 then
        adopt(err, v1)
        return
    end
    ;(u42:AtError()):Log((("pen roster snapshot never landed, going round again: %*"):format(v3)))
    task.delay(5, pullUntilAnswered)
end

local function outcome(a1, a2) -- Line: 107
    local v1 = a1 == true
    if typeof(a2) == "string" then
        return v1, a2
    end
    return v1, nil
end

local function confirmed(a1) -- Line: 111
    return a1:InvokeServer() == true
end

function u32.WearAsset(a1) -- Line: 113 -- upvalues: PenRoster (val) -- types: a1: string
    local v1, v2, v3 = PenRoster.AskWear:InvokeServer(a1)
    local v4 = v1 == true
    local v5 = if typeof(v2) ~= "string" then nil else v2
    local v6 = v4
    local v7 = v5
    if typeof(v3) == "string" then
        return v6, v7, v3
    end
    return v6, v7, nil
end

function u32.DoffAsset(a1) -- Line: 119 -- upvalues: outcome (val), PenRoster (val) -- types: a1: string
    return outcome(PenRoster.AskDoff:InvokeServer(a1))
end

function u32.ReadWearLimit() -- Line: 123 -- upvalues: PenRoster (val)
    local v1 = PenRoster.AskWearLimit:InvokeServer()
    if typeof(v1) == "number" then
        return v1
    end
    return 0
end

function u32.AckPetsBadge() -- Line: 128 -- upvalues: PenRoster (val)
    return PenRoster.ConfirmPetsBadge:InvokeServer() == true
end

function u32.AckEquipBestBadge() -- Line: 130 -- upvalues: PenRoster (val)
    return PenRoster.ConfirmEquipBestBadge:InvokeServer() == true
end

function u32.ReadSnapshot() -- Line: 132 -- upvalues: everyPen (val)
    return (everyPen())
end

function u32.ReadOwnerPen(a1) -- Line: 134 -- upvalues: u43 (ref), copyContents (val) -- types: a1: number
    local v1 = u43[a1]
    if v1 ~= nil then
        return (copyContents(v1))
    end
    return {}
end

function u32.FindPenArea(a1) -- Line: 139 -- upvalues: PlotState (val) -- types: a1: userdata
    local v1 = PlotState.ResolvePlot(a1)
    if v1 ~= nil then
        return v1.PetArea
    end
    return nil
end

for i, v in ipairs({
    {
        complaint = "pen roster owner write turned away",
        feed = PenRoster.OwnerShifted,
        vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerUpdate,
        apply = function(a1) -- Line: 149 -- upvalues: u43 (ref), copyContents (val), u32 (val)
            local OwnerRefreshed, OwnerUserId, Records, v1, v2, v4
            u43[a1.OwnerUserId] = (copyContents(a1.Records))
            u32.OwnerRefreshed:Fire(a1.OwnerUserId, (copyContents(a1.Records)))
            return
        end,
    },
    {
        complaint = "pen roster owner erase turned away",
        feed = PenRoster.OwnerDropped,
        vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerClear,
        apply = function(a1) -- Line: 158 -- upvalues: u43 (ref), u32 (val)
            local OwnerCleared, OwnerUserId, v1, v2
            u43[a1.OwnerUserId] = nil
            u32.OwnerCleared:Fire(a1.OwnerUserId)
            return
        end,
    },
}) do
    v.feed.OnClientEvent:Connect(function(a1) -- Line: 166 -- upvalues: v (val), u42 (val), u45 (ref), u44 (val), u32 (val), everyPen (val)
        local v1, v2 = v.vet(a1)
        if not v1 then
            (u42:AtError()):Log((("%*: %*"):format(v.complaint, v2)))
            return
        end
        u45 = u45 + 1
        u44[a1.OwnerUserId] = u45
        v.apply(a1)
        u32.SnapshotRefreshed:Fire((everyPen()))
    end)
end
PlotState.PlotChanged:Connect(function(a1, a2) -- Line: 181 -- upvalues: Players (val), u32 (val) -- types: a1: number, a2: number?
    local PlayerByUserId = if a2 == nil then nil else Players:GetPlayerByUserId(a2)
    if PlayerByUserId ~= nil then
        u32.PenAreaChanged:Fire(PlayerByUserId, (u32.FindPenArea(PlayerByUserId)))
    end
end)
task.spawn(pullUntilAnswered)
return u32