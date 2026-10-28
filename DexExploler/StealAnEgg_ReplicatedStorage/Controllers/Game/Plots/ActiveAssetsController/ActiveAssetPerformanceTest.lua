-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.ActiveAssetPerformanceTest
-- Decompile time: 5.96 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.AssetBillboardController)
local AssetComponent = require(script.Parent.AssetComponent)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
require(script.Parent.AssetMovementBatch)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Assets = require(ReplicatedStorage.Data.Assets)
local ActiveAssetPerformanceTestConfig = require(script.Parent.ActiveAssetPerformanceTestConfig)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local u64 = Log.new()
local u67 = Random.new()
local u68 = {}
local u69 = {}
local u70 = nil
local u71 = nil
local u72 = nil
for k in pairs(Assets.Directory) do
    if k ~= "Frigo Camelo" then
        table.insert(u68, k)
    end
end
table.sort(u68)
assert(#u68 > 0, "Active asset performance test requires at least one eligible category")
local v1 = {}

local function buildRuntimeRecord(a1, a2) -- Line: 56
    -- upvalues: u68 (val), u67 (val), EggRecords (val), AssetGender (val), Players (val), AssetEarnings (val)
    -- upvalues: AssetRuntime (val)
    local v1 = u68[u67:NextInteger(1, #u68)]
    local v2 = EggRecords.NewEgg(v1, u67)
    v2.AssetGender = AssetGender.Settle(v1, nil, u67)
    v1 = EggRecords.ToAssetItemData(v2)
    v1.HasBeenFirstPlaced = true
    local v3 = {
        OwnerUserId = Players.LocalPlayer.UserId,
        UID = ("PERFORMANCE_TEST_%*_%*"):format(a1, a2),
        ItemData = v1,
        MoneyPerSecond = AssetEarnings.LiveRatePerSecond(v1),
        Seed = u67:NextInteger(1, 2147483647),
    }
    assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(v3), "Invalid performance-test asset record")
    return v3
end

local function destroySlot(a1) -- Line: 77 -- upvalues: u69 (val), u70 (ref) -- types: a1: number
    local v1 = u69[a1]
    if v1 == nil then
        return
    end
    u69[a1] = nil
    for i, v in ipairs(v1.Components) do
        u70:Remove((v:GetModel()))
        v:Destroy()
    end
    v1.Container:Destroy()
end

local function activateSlot(a1, a2) -- Line: 90
    -- upvalues: u72 (ref), ActiveAssetPerformanceTestConfig (val), buildRuntimeRecord (val), AssetComponent (val)
    -- upvalues: Players (val), u70 (ref), u71 (ref), u69 (val), u64 (val)
    local v1, v2
    local Folder = Instance.new("Folder")
    Folder.Name = ("Plot%*"):format(a1)
    Folder.Parent = u72
    local v3 = {}
    local PetsPerPlot = ActiveAssetPerformanceTestConfig.PetsPerPlot
    for i = 1, PetsPerPlot do
        v1 = buildRuntimeRecord(a1, i)
        v2 = AssetComponent.new(v1, Players.LocalPlayer, a2, Folder, u70, u71, nil)
        u70:Add(v2:GetModel(), v1.ItemData, v1.MoneyPerSecond)
        table.insert(v3, v2)
    end
    u69[a1] = {Area = a2, Components = v3, Container = Folder}
    ;(u64:AtInfo()):Log((("Created %* performance-test pets for plot %*"):format(ActiveAssetPerformanceTestConfig.PetsPerPlot, a1)))
end

local function syncSlot(a1) -- Line: 117
    -- upvalues: PlotState (val), u69 (val), destroySlot (val), activateSlot (val)
    local v1 = nil
    local v2 = false
    local v3 = PlotState.ResolveFolder()
    if v3 ~= nil then
        local v4 = v3:FindFirstChild((tostring(a1)))
        v2 = v4 ~= nil
        local ToUpdate = if v4 == nil then nil else v4:FindFirstChild("ToUpdate")
        v4 = if ToUpdate == nil then nil else if not ToUpdate:IsA("Model") then nil else ToUpdate:FindFirstChild("PetArea")
        if v4 ~= nil and v4:IsA("BasePart") then
            v1 = v4
        end
    end
    v3 = u69[a1]
    if not v2 then
        destroySlot(a1)
        return
    end
    if v1 == nil then
        return
    end
    if v3 == nil then
        activateSlot(a1, v1)
        return
    end
    if v3.Area == v1 then
        return
    end
    v3.Area = v1
    for i, v in ipairs(v3.Components) do
        v:SetAssetArea(v1)
    end
end

local function syncAllSlots() -- Line: 153 -- upvalues: PlotState (val), syncSlot (val), u69 (val), destroySlot (val)
    local v1 = PlotState.ResolveFolder()
    local v2 = {}
    if v1 ~= nil then
        local v3
        for i, v in ipairs(v1:GetChildren()) do
            v3 = tonumber(v.Name)
            if v3 ~= nil then
                v2[v3] = true
                syncSlot(v3)
            end
        end
    end
    for k in pairs(u69) do
        if v2[k] ~= true then
            destroySlot(k)
        end
    end
end

function v1.Start(a1, a2, a3) -- Line: 176
    -- upvalues: ActiveAssetPerformanceTestConfig (val), u70 (ref), u71 (ref), u72 (ref), PlotState (val)
    -- upvalues: syncSlot (val), syncAllSlots (val)
    local v1 = false
    if 0 < ActiveAssetPerformanceTestConfig.PetsPerPlot then
        v1 = ActiveAssetPerformanceTestConfig.PetsPerPlot % 1 == 0
    end
    assert(v1, "PetsPerPlot must be a positive integer")
    u70 = a2
    u71 = a3
    u72 = Instance.new("Folder")
    u72.Name = "PerformanceTestAssets"
    u72.Parent = a1
    PlotState.PlotChanged:Connect(syncSlot)
    PlotState.FolderChanged:Connect(syncAllSlots)
    syncAllSlots()
end

return v1