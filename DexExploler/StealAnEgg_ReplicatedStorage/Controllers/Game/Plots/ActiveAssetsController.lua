-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController
-- Decompile time: 21.39 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveAssetIncomePopup = require(script.Parent.Parent.Parent.GUI.ActiveAssetIncomePopup)
local ActiveAssetPerformanceTest = require(script.ActiveAssetPerformanceTest)
local ActiveAssetPerformanceTestConfig = require(script.ActiveAssetPerformanceTestConfig)
local AssetBillboardController = require(script.AssetBillboardController)
local AssetChatBubble = require(ReplicatedStorage.Client.UI.AssetChatBubble)
local AssetComponent = require(script.AssetComponent)
local AssetHoverDataDisplay = require(script.Parent.Parent.Parent.GUI.AssetHoverDataDisplay)
local AssetMovementBatch = require(script.AssetMovementBatch)
local AssetPlacementHints = require(script.AssetPlacementHints)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local ModelCameraOcclusion = require(ReplicatedStorage.Client.ModelCameraOcclusion)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u87 = AssetMovementBatch.new()
local u90 = AssetBillboardController.new()
local u91 = {}
local u92 = {}
local u93 = false
local HideOtherPets = Preferences.IsOn("HideOtherPets")
local HideSelfPets = Preferences.IsOn("HideSelfPets")
local u100 = false
local u101 = {}
local Folder = Instance.new("Folder")
Folder.Name = "ClientRenderedAssets"
Folder.Parent = workspace
local u107 = {}
u107.ItemAdded = Signal.new()
u107.ItemRemoved = Signal.new()
u107.CashCollected = Signal.new()
u107.InitialLoadCompleted = Signal.new()

local function makeKey(a1, a2) -- Line: 62 -- types: a1: number, a2: string
    return (("%*:%*"):format(a1, a2))
end

local function recordForComponent(a1, a2) -- Line: 64 -- upvalues: u92 (val) -- types: a1: string
    if a2.IsFirstPlacement ~= true then
        return a2
    end
    if u92[a1] ~= true then
        u92[a1] = true
        return a2
    end
    local v1 = table.clone(a2)
    local v2 = table.clone(a2.ItemData)
    v2.Mutations = table.clone(a2.ItemData.Mutations)
    v1.ItemData = v2
    v1.IsFirstPlacement = nil
    return v1
end

local function isOwnerHidden(a1) -- Line: 83
    -- upvalues: Players (val), HideSelfPets (ref), HideOtherPets (ref)
    if a1 == Players.LocalPlayer.UserId then
        return HideSelfPets
    end
    return HideOtherPets
end

local function syncHoverEntry(a1) -- Line: 87
    -- upvalues: Players (val), HideSelfPets (ref), HideOtherPets (ref), u101 (val), AssetHoverDataDisplay (val)
    local OwnerUserId = a1:GetOwnerUserId()
    local Uid = a1:GetUid()
    if not (if OwnerUserId ~= Players.LocalPlayer.UserId then HideOtherPets else HideSelfPets)
        and not u101[("%*:%*"):format(OwnerUserId, Uid)] then
        AssetHoverDataDisplay.SetEntry({Record = a1:GetRuntimeRecord(), Model = a1:GetModel()})
        return
    end
    AssetHoverDataDisplay.RemoveEntry(OwnerUserId, Uid)
end

local function applyComponentHiddenState(a1) -- Line: 102
    -- upvalues: u100 (ref), Players (val), HideSelfPets (ref), HideOtherPets (ref), u101 (val)
    -- upvalues: ModelCameraOcclusion (val), u90 (val)
    local v1 = u100 or (if (a1:GetOwnerUserId()) ~= Players.LocalPlayer.UserId then HideOtherPets else HideSelfPets) or u101[("%*:%*"):format(a1:GetOwnerUserId(), (a1:GetUid()))] == true
    if a1:IsHidden() == v1 then
        return
    end
    local Model = a1:GetModel()
    if v1 then
        ModelCameraOcclusion.SetIgnored(Model, true)
        a1:SetHidden(true)
        u90:SetSuppressed(Model, true)
        return
    end
    a1:SetHidden(false)
    u90:SetSuppressed(Model, false)
    ModelCameraOcclusion.SetIgnored(Model, false)
end

function u107.SetAllPetsHidden(a1) -- Line: 158
    -- upvalues: u100 (ref), u91 (val), applyComponentHiddenState (val), syncHoverEntry (val)
    if u100 == a1 then
        return
    end
    u100 = a1
    for k, v in pairs(u91) do
        if v ~= nil then
            applyComponentHiddenState(v)
            syncHoverEntry(v)
        end
    end
end

local function destroyComponent(a1) -- Line: 172
    -- upvalues: u91 (val), u90 (val), AssetHoverDataDisplay (val), u107 (val)
    local v1 = u91[a1]
    if v1 == nil then
        return
    end
    local Model = v1:GetModel()
    u90:Remove(Model)
    AssetHoverDataDisplay.RemoveEntry(v1:GetOwnerUserId(), v1:GetUid())
    v1:Destroy()
    u91[a1] = nil
    u107.ItemRemoved:Fire(Model)
end

local function clearOwner(a1) -- Line: 185 -- upvalues: u91 (val), destroyComponent (val) -- types: a1: number
    for k, v in pairs(u91) do
        if v ~= nil and v:GetOwnerUserId() == a1 then
            destroyComponent(k)
        end
    end
end

local function reconcileOwner(a1, a2) -- Line: 193
    -- upvalues: Players (val), clearOwner (val), AssetRoster (val), recordForComponent (val), u91 (val)
    -- upvalues: destroyComponent (val), AssetPlacementHints (val), AssetComponent (val), Folder (val), u90 (val)
    -- upvalues: u87 (val), u107 (val), applyComponentHiddenState (val), syncHoverEntry (val)
    local v1, v2, v3, v4
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId == nil then
        clearOwner(a1)
        return
    end
    local v5 = AssetRoster.FindPenArea(PlayerByUserId)
    if v5 == nil then
        return
    end
    local v6 = {}
    local v7 = a1
    for k, v in pairs(a2) do
        v1 = ("%*:%*"):format(v7, k)
        v6[v1] = true
        v2 = recordForComponent(v1, v)
        v3 = u91[v1]
        if v3 ~= nil
            and (table.concat(v3:GetRuntimeRecord().ItemData.Mutations, ",")) ~= table.concat(v.ItemData.Mutations, ",") then
            destroyComponent(v1)
            v3 = nil
        end
        if v3 ~= nil then
            if PlayerByUserId == Players.LocalPlayer then
                AssetPlacementHints.ClearFrontPlacement(k)
            end
            v3:SetRuntimeRecord(v2)
            v3:SetAssetArea(v5)
            u90:UpdateMoneyPerSecond(v3:GetModel(), v2.MoneyPerSecond)
        else
            v3 = AssetComponent.new(
                v2,
                PlayerByUserId,
                v5,
                Folder,
                u90,
                u87,
                if PlayerByUserId ~= Players.LocalPlayer then nil else AssetPlacementHints.ConsumeFrontPlacement(k, v5)
            )
            u91[v1] = v3
            v4 = v3
            u90:Add(v4:GetModel(), v2.ItemData, v2.MoneyPerSecond)
            u107.ItemAdded:Fire((v4:GetModel()))
        end
        v2 = v3
        applyComponentHiddenState(v2)
        syncHoverEntry(v2)
    end
    for k2, i in pairs(u91) do
        if i ~= nil and i:GetOwnerUserId() == v7 and v6[k2] ~= true then
            destroyComponent(k2)
        end
    end
end

local function reconcileSnapshot(a1) -- Line: 257 -- upvalues: reconcileOwner (val), u91 (val), destroyComponent (val)
    local v1 = {}
    for i, v in ipairs(a1) do
        v1[v.OwnerUserId] = true
        reconcileOwner(v.OwnerUserId, v.Records)
    end
    for k, i2 in pairs(u91) do
        if i2 ~= nil and v1[i2:GetOwnerUserId()] ~= true then
            destroyComponent(k)
        end
    end
end

function u107.SetMountedPet(a1, a2, a3) -- Line: 274
    -- upvalues: u101 (val), u91 (val), applyComponentHiddenState (val), syncHoverEntry (val)
    local v1 = ("%*:%*"):format(a1, a2)
    u101[v1] = if not a3 then nil else true
    local v2 = u91[v1]
    if v2 then
        applyComponentHiddenState(v2)
        syncHoverEntry(v2)
    end
end

function u107.GetModelByUID(a1) -- Line: 281 -- upvalues: u91 (val) -- types: a1: string
    for k, v in pairs(u91) do
        if v ~= nil and v:GetUid() == a1 then
            return v:GetModel()
        end
    end
    return nil
end

function u107.GetAll() -- Line: 290 -- upvalues: u91 (val)
    local Uid
    local v1 = {}
    for k, v in pairs(u91) do
        if v ~= nil then
            Uid = v:GetUid()
            v1[Uid] = (v:GetModel())
        end
    end
    return v1
end

function u107.GetActiveModels() -- Line: 300 -- upvalues: u107 (val)
    local v1 = {}
    for k, v in pairs(u107.GetAll()) do
        table.insert(v1, v)
    end
    return v1
end

AssetRoster.SnapshotRefreshed:Connect(reconcileSnapshot)
AssetRoster.OwnerRefreshed:Connect(reconcileOwner)
AssetRoster.OwnerCleared:Connect(clearOwner)
u107.ItemAdded:Connect(function(a1) -- Line: 316 -- upvalues: ModelCameraOcclusion (val) -- types: a1: userdata
    ModelCameraOcclusion.Register(a1, 1)
end)
u107.ItemRemoved:Connect(ModelCameraOcclusion.Forget)
Preferences.Observe("HideOtherPets", function(a1) -- Line: 122
    -- upvalues: HideOtherPets (ref), u87 (val), u91 (val), applyComponentHiddenState (val), syncHoverEntry (val)
    if HideOtherPets == a1 then
        return
    end
    HideOtherPets = a1
    if a1 then
        u87:SetForeignPresentationSuppressed(true)
    end
    for k, v in pairs(u91) do
        if v ~= nil then
            applyComponentHiddenState(v)
            syncHoverEntry(v)
        end
    end
    if not a1 then
        u87:SetForeignPresentationSuppressed(false)
    end
end)
Preferences.Observe("HideSelfPets", function(a1) -- Line: 144
    -- upvalues: HideSelfPets (ref), u91 (val), applyComponentHiddenState (val), syncHoverEntry (val)
    if HideSelfPets == a1 then
        return
    end
    HideSelfPets = a1
    for k, v in pairs(u91) do
        if v ~= nil then
            applyComponentHiddenState(v)
            syncHoverEntry(v)
        end
    end
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 321
    -- upvalues: u93 (ref), ModelCameraOcclusion (val), AssetChatBubble (val)
    u93 = a1 ~= nil
    ModelCameraOcclusion.SetEnabled(u93)
    AssetChatBubble.PinAbove(not u93)
end)
AssetRoster.PenAreaChanged:Connect(function(a1) -- Line: 327 -- upvalues: reconcileOwner (val), AssetRoster (val) -- types: a1: userdata
    reconcileOwner(a1.UserId, AssetRoster.ReadOwnerPen(a1.UserId))
end)
Players.PlayerRemoving:Connect(function(a1) -- Line: 329 -- upvalues: clearOwner (val) -- types: a1: userdata
    clearOwner(a1.UserId)
end)
Remotes.PenRoster.CoinsGathered.OnClientEvent:Connect(function(a1) -- Line: 330
    -- upvalues: u107 (val), u100 (ref), u101 (val), Players (val), ActiveAssetIncomePopup (val), u93 (ref)
    local uid
    for i, v in ipairs(a1) do
        uid = v.uid
        if uid ~= nil then
            u107.CashCollected:Fire(uid)
            if not u100 and not u101[("%*:%*"):format(Players.LocalPlayer.UserId, uid)] then
                assert(0 < v.amount, (("Active asset income popup requires positive amount for uid \"%*\""):format(uid)))
                ActiveAssetIncomePopup.Show(
                    assert(u107.GetModelByUID(uid), (("Active asset income popup missing rendered model for uid \"%*\""):format(uid))),
                    v.amount,
                    {alwaysOnTop = not u93}
                )
            end
        end
    end
end)
if ActiveAssetPerformanceTestConfig.Enabled and Constants.IS_STUDIO then
    ActiveAssetPerformanceTest.Start(Folder, u90, u87)
end
u87:SetForeignPresentationSuppressed(HideOtherPets)
reconcileSnapshot(AssetRoster.ReadSnapshot())
u107.InitialLoadCompleted:Fire()
return u107