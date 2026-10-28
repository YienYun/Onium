-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.MilestoneAdapter
-- Decompile time: 18.28 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Assets = require(ReplicatedStorage.Data.Assets)
local u28 = nil
local EggState = require(ReplicatedStorage.Client.EggState)
local Signal = require(ReplicatedStorage.Packages.Signal)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u58 = {}
u58.__index = u58
u58.__class = "MilestoneAdapter"
local LocalPlayer = Players.LocalPlayer
local u61 = nil

local function getBackpackController(a1) -- Line: 52 -- upvalues: u61 (ref), ReplicatedStorage (val)
    if u61 == nil and not a1._backpackRequested then
        a1._backpackRequested = true
        task.spawn(function() -- Line: 55 -- upvalues: ReplicatedStorage (upval), a1 (val), u61 (upval)
            local Main = require(ReplicatedStorage.Controllers.GUI.BackpackController.Main)
            if a1._destroyed then
                return
            end
            u61 = Main
            a1:_fireChanged()
        end)
    end
    return u61
end

local World = Workspace.World
assert(World:IsA("Folder"), "Workspace.World must be a Folder")
local Areas = World.Areas
assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
local SeparationLine = Areas.SeparationLine
assert(SeparationLine:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")

function u58.new() -- Line: 78 -- upvalues: u58 (val), Signal (val), EggState (val), Trove (val)
    local v1 = setmetatable({}, u58)
    v1.Changed = Signal.new()
    v1._areaEggCarryState = EggState.ReadCarryState()
    v1._destroyed = false
    v1._backpackRequested = false
    v1._hatchedEgg = false
    v1._hadPlacedPet = false
    v1._knownEggCount = nil
    v1._treadmillIntroFinished = false
    v1._trove = Trove.new()
    v1:_bindObservers()
    return v1
end

function u58:_fireChanged() -- Line: 100
    self.Changed:Fire()
end

function u58._getSaveData(a1) -- Line: 102 -- upvalues: Save (val)
    return Save.Peek()
end

function u58._getEquippedTool(a1, a2) -- Line: 104 -- upvalues: LocalPlayer (val) -- types: a2: string
    local Character = LocalPlayer.Character
    if Character == nil then
        return nil
    end
    for i, v in ipairs(Character:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("ItemType") == a2 then
            return v
        end
    end
    return nil
end

local function countUnplacedEggs(a1) -- Line: 117
    if a1 == nil then
        return 0
    end
    local v1 = 0
    for k, v in pairs(a1.EggInventory) do
        if v.Placement == nil then
            v1 = v1 + 1
        end
    end
    return v1
end

local function getPlacedEggCount(a1) -- Line: 131
    if a1 == nil then
        return 0
    end
    local v1 = 0
    for k, v in pairs(a1.EggInventory) do
        if v.Placement ~= nil then
            v1 = v1 + 1
        end
    end
    return v1
end

local function getTotalEggCount(a1) -- Line: 145
    if a1 == nil then
        return 0
    end
    local v1 = 0
    for k in pairs(a1.EggInventory) do
        v1 = v1 + 1
    end
    return v1
end

local function getEggGrowthTime(a1) -- Line: 157 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local v2 = ("Missing asset config for %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1.Egg.GrowthTime
end

function u58:_getLowestHatchTimeEggUid() -- Line: 163 -- upvalues: Assets (val)
    local AssetCategory, GrowthTime, v1, v2
    local v3 = self:_getSaveData()
    if v3 == nil then
        return nil
    end
    local v4 = nil
    local v5 = (1 / 0)
    for k, v in pairs(v3.EggInventory) do
        if v.Placement == nil then
            AssetCategory = v.AssetCategory
            v1 = Assets.Directory[AssetCategory]
            v2 = ("Missing asset config for %*"):format(AssetCategory)
            assert(v1 ~= nil, v2)
            GrowthTime = v1.Egg.GrowthTime
            if GrowthTime < v5 then
                v4 = k
            end
        end
    end
    return v4
end

function u58:_bindCharacterTools(a2) -- Line: 185 -- types: a2: userdata?
    if a2 == nil then
        return
    end
    self._trove:Connect(a2.ChildAdded, function(a1) -- Line: 190 -- upvalues: self (val)
        if a1:IsA("Tool") then
            self:_fireChanged()
        end
    end)
    self._trove:Connect(a2.ChildRemoved, function(a1) -- Line: 195 -- upvalues: self (val)
        if a1:IsA("Tool") then
            self:_fireChanged()
        end
    end)
end

function u58:_bindObservers() -- Line: 202
    -- upvalues: Save (val), PlotState (val), AssetRoster (val), LocalPlayer (val), ReplicatedStorage (val), u28 (ref)
    -- upvalues: EggState (val)
    local function refreshEggCount() -- Line: 203 -- upvalues: self (val)
        local v1 = self:_getSaveData()
        if v1 ~= nil and not self._destroyed then
            local v2
            if v1 ~= nil then
                local v3 = 0
                for k in pairs(v1.EggInventory) do
                    v3 = v3 + 1
                end
                v2 = v3
            else
                v2 = 0
            end
            if self._knownEggCount ~= nil and v2 < self._knownEggCount then
                self._hatchedEgg = true
            end
            self._knownEggCount = v2
            self:_fireChanged()
            return
        end
    end

    self._trove:Add((Save.Loaded:Connect(refreshEggCount)))
    self._trove:Add((Save.Watch("EggInventory"):Connect(refreshEggCount)))
    local v1 = self:_getSaveData()
    if v1 ~= nil and not self._destroyed then
        local v2
        if v1 ~= nil then
            local v3 = 0
            for k in pairs(v1.EggInventory) do
                v3 = v3 + 1
            end
            v2 = v3
        else
            v2 = 0
        end
        if self._knownEggCount ~= nil and v2 < self._knownEggCount then
            self._hatchedEgg = true
        end
        self._knownEggCount = v2
        self:_fireChanged()
    end
    self._trove:Add(((Save.Watch("Inventory")):Connect(function() -- Line: 216 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add(((Save.Watch("Money")):Connect(function() -- Line: 217 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add(((Save.Watch("BaseUpgradeLevel")):Connect(function() -- Line: 218 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add((PlotState.LocalPlotChanged:Connect(function() -- Line: 219 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add((AssetRoster.SnapshotRefreshed:Connect(function() -- Line: 220 -- upvalues: AssetRoster (upval), LocalPlayer (upval), self (val)
        local v1
        if next(AssetRoster.ReadOwnerPen(LocalPlayer.UserId)) ~= nil == self._hadPlacedPet then
            return
        end
        self._hadPlacedPet = v1
        self:_fireChanged()
    end)))
    task.spawn(function() -- Line: 228 -- upvalues: ReplicatedStorage (upval), self (val), u28 (upval)
        local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
        if self._destroyed then
            return
        end
        u28 = BaseUpgrade
        local Transition = BaseUpgrade.Transition
        self._trove:Add((Transition.Completed:Connect(function() -- Line: 233 -- upvalues: self (upval)
            self:_fireChanged()
        end)))
        self:_fireChanged()
    end)
    task.spawn(function() -- Line: 236 -- upvalues: ReplicatedStorage (upval), self (val)
        local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
        if self._destroyed then
            return
        end
        self._trove:Add((PlacedEggRenderer.LocalEggHatchStarted:Connect(function() -- Line: 239 -- upvalues: self (upval)
            self._hatchedEgg = true
            self:_fireChanged()
        end)))
    end)
    self._trove:Add((EggState.OwnerRefreshed:Connect(function(a1) -- Line: 244 -- upvalues: LocalPlayer (upval), self (val) -- types: a1: number
        if a1 == LocalPlayer.UserId then
            self:_fireChanged()
        end
    end)))
    self._trove:Add((EggState.CarryChanged:Connect(function(a1) -- Line: 249 -- upvalues: self (val)
        self._areaEggCarryState = a1
        self:_fireChanged()
    end)))
    self._trove:Add((EggState.FieldRefreshed:Connect(function() -- Line: 253 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add((EggState.FieldShifted:Connect(function() -- Line: 254 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    self._trove:Add((EggState.FieldGone:Connect(function() -- Line: 255 -- upvalues: self (val)
        self:_fireChanged()
    end)))
    local u168 = nil

    local function bindBackpack(a1) -- Line: 257 -- upvalues: u168 (ref), self (val) -- types: a1: userdata
        if a1:IsA("Backpack") and a1 ~= u168 and not self._destroyed then
            u168 = a1
            self._trove:Connect(a1.ChildAdded, function() -- Line: 260 -- upvalues: self (upval)
                self:_fireChanged()
            end)
            self._trove:Connect(a1.ChildRemoved, function() -- Line: 261 -- upvalues: self (upval)
                self:_fireChanged()
            end)
            self:_fireChanged()
            return
        end
    end

    self._trove:Connect(LocalPlayer.ChildAdded, bindBackpack)
    local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if Backpack then
        bindBackpack(Backpack)
    end
    self._trove:Connect(LocalPlayer.CharacterAdded, function(a1) -- Line: 267 -- upvalues: self (val)
        self:_bindCharacterTools(a1)
        self:_fireChanged()
    end)
    self:_bindCharacterTools(LocalPlayer.Character)
    self._hadPlacedPet = next(AssetRoster.ReadOwnerPen(LocalPlayer.UserId)) ~= nil
end

function u58.HasStolenFirstEgg(a1) -- Line: 279
    local v1, v2
    local v3 = true
    local v4 = a1:_getSaveData()
    if v4 ~= nil then
        v2 = 0
        for k, v in pairs(v4.EggInventory) do
            if v.Placement == nil then
                v2 = v2 + 1
            end
        end
        v1 = v2
    else
        v1 = 0
    end
    if not (v1 > 0) then
        v4 = a1:_getSaveData()
        if v4 ~= nil then
            v2 = 0
            for k2, i in pairs(v4.EggInventory) do
                if i.Placement ~= nil then
                    v2 = v2 + 1
                end
            end
            v1 = v2
        else
            v1 = 0
        end
        v3 = v1 > 0
    end
    return v3
end

function u58.IsCarryingAreaEgg(a1) -- Line: 283
    local _areaEggCarryState = a1._areaEggCarryState
    local IsCarrying = false
    if _areaEggCarryState ~= nil then
        IsCarrying = _areaEggCarryState.IsCarrying
    end
    return IsCarrying
end

function u58.HasReturnedToPen(a1) -- Line: 288 -- upvalues: Player (val), PlotState (val)
    local v1 = Player.FindRootPart()
    local v2 = PlotState.ResolvePlot()
    if v1 ~= nil and v2 ~= nil then
        if PlotState.ContainsLocalPoint(v1.Position) then
            return true
        end
        local PetArea = v2.PetArea
        v2 = PetArea.CFrame:PointToObjectSpace(v1.Position)
        local v3 = PetArea.Size * 0.5
        return (v1.Position - (PetArea.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v2.X, -v3.X, v3.X), math.clamp(v2.Y, -v3.Y, v3.Y), (math.clamp(v2.Z, -v3.Z, v3.Z))))))).Magnitude <= 18
    end
    return false
end

function u58.HasEquippedEgg(a1) -- Line: 311
    return a1:_getEquippedTool("AssetEgg") ~= nil
end

function u58.HasPlacedEgg(a1) -- Line: 315
    local v1
    local v2 = a1:_getSaveData()
    if v2 ~= nil then
        local v3 = 0
        for k, v in pairs(v2.EggInventory) do
            if v.Placement ~= nil then
                v3 = v3 + 1
            end
        end
        v1 = v3
    else
        v1 = 0
    end
    return v1 > 0
end

function u58.HasHatchableEgg(a1) -- Line: 319 -- upvalues: EggState (val), LocalPlayer (val)
    for k in pairs(EggState.ReadOwnerEggs(LocalPlayer.UserId)) do
        if EggState.IsReadyToHatch(k) then
            return true
        end
    end
    return false
end

function u58.HasHatchedEgg(a1) -- Line: 328
    return a1._hatchedEgg
end

function u58.HasPlacedPet(a1) -- Line: 330
    return a1._hadPlacedPet
end

function u58.HasPetInInventory(a1) -- Line: 332
    if a1:_getEquippedTool("Asset") ~= nil then
        return true
    end
    local v1 = a1:_getSaveData()
    local v2 = false
    if v1 ~= nil then
        v2 = next(v1.Inventory) ~= nil
    end
    return v2
end

function u58.IsLocalPlayerInGameplay(a1) -- Line: 341
    -- upvalues: Player (val), GuardAreaGeometry (val), SeparationLine (val)
    local v1 = Player.FindRootPart()
    local v2 = false
    if v1 ~= nil then
        v2 = GuardAreaGeometry.IsPastLine(SeparationLine, v1.Position)
    end
    return v2
end

function u58.GetClosestAreaEggTarget(a1) -- Line: 346 -- upvalues: Player (val), EggState (val), AreaEggs (val)
    local Magnitude
    local v1 = Player.FindRootPart()
    local Position = if not v1 then Vector3.new(0, 0, 0) else v1.Position
    local Position_2 = nil
    local v2 = (1 / 0)
    for i, v in ipairs(EggState.ReadFieldEggs().Records) do
        if v.State == AreaEggs.States.Slot and string.find(v.Uid, "FirstAreaEgg_", 1, true) == 1 then
            Magnitude = (v.BottomCFrame.Position - Position).Magnitude
            if Magnitude < v2 then
                Position_2 = v.BottomCFrame.Position
            end
        end
    end
    return Position_2
end

function u58.GetGameplayExitTarget(a1) -- Line: 367 -- upvalues: SeparationLine (val), Player (val)
    local v1 = SeparationLine.Position + Vector3.new(0, 3, 0) - SeparationLine.CFrame.LookVector.Unit * 1
    local v2 = Player.FindRootPart()
    if v2 ~= nil then
        return (Vector3.new(v1.X, v1.Y, v2.Position.Z))
    end
    return v1
end

function u58.GetGameplayEntryTarget(a1) -- Line: 375 -- upvalues: SeparationLine (val)
    return SeparationLine.Position + Vector3.new(0, 3, 0) + SeparationLine.CFrame.LookVector.Unit * 1
end

function u58.GetPlotSpawnTarget(a1) -- Line: 381 -- upvalues: PlotState (val)
    local v1 = PlotState.ResolvePlot()
    if v1 == nil then
        return nil
    end
    local RespawnPointCFrame = v1.RespawnPointCFrame
    if RespawnPointCFrame then
        return RespawnPointCFrame.Position
    end
    return v1.CenterPoint.Position
end

function u58.GetEggPlacementBillboardCFrame(a1) -- Line: 390 -- upvalues: PlotState (val), Player (val)
    local v1 = PlotState.ResolvePlot()
    local v2 = Player.FindRootPart()
    if v1 ~= nil and v2 ~= nil and v1.RespawnPointCFrame ~= nil then
        local PetArea = v1.PetArea
        local RespawnPointCFrame = v1.RespawnPointCFrame
        v1 = PetArea.CFrame:PointToObjectSpace(v2.Position)
        v2 = PetArea.Size * 0.5
        v2 = PetArea.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), v2.Y, (math.clamp(v1.Z, -v2.Z, v2.Z)))))
        local v3 = RespawnPointCFrame + RespawnPointCFrame.LookVector * 13
        return CFrame.new(v3.Position.X, v2.Y, v3.Position.Z)
    end
    return nil
end

function u58.GetNearestHatchableEggTarget(a1) -- Line: 411
    -- upvalues: Player (val), EggState (val), LocalPlayer (val), PlotState (val)
    local Magnitude, Position_2, v1
    local v2 = Player.FindRootPart()
    local Position = if not v2 then Vector3.new(0, 0, 0) else v2.Position
    v2 = nil
    local v3 = (1 / 0)
    for k, v in pairs(EggState.ReadOwnerEggs(LocalPlayer.UserId)) do
        if v.Placement ~= nil and EggState.IsReadyToHatch(k) then
            v1 = PlotState.ResolvePlot()
            if v1 ~= nil then
                Position_2 = (v1.CenterPoint.CFrame * v.Placement.LocalCFrame).Position
                Magnitude = (Position_2 - Position).Magnitude
                if Magnitude < v3 then
                    v2 = Position_2
                end
            end
        end
    end
    return v2
end

function u58.GetEggHotbarTarget(a1) -- Line: 435 -- upvalues: u61 (ref), ReplicatedStorage (val)
    local v1
    local v2 = a1:_getLowestHatchTimeEggUid()
    if not v2 then
        v1 = nil
    else
        if u61 == nil and not a1._backpackRequested then
            a1._backpackRequested = true
            task.spawn(function() -- Line: 55 -- upvalues: ReplicatedStorage (upval), a1 (val), u61 (upval)
                local Main = require(ReplicatedStorage.Controllers.GUI.BackpackController.Main)
                if a1._destroyed then
                    return
                end
                u61 = Main
                a1:_fireChanged()
            end)
        end
        v1 = u61
    end
    if v1 then
        return (v1:GetEggSlotFrame(v2))
    end
    return nil
end

function u58.ForceBestEggIntoHotbar(a1) -- Line: 441 -- upvalues: u61 (ref), ReplicatedStorage (val)
    local v1
    local v2 = a1:_getLowestHatchTimeEggUid()
    if not v2 then
        v1 = nil
    else
        if u61 == nil and not a1._backpackRequested then
            a1._backpackRequested = true
            task.spawn(function() -- Line: 55 -- upvalues: ReplicatedStorage (upval), a1 (val), u61 (upval)
                local Main = require(ReplicatedStorage.Controllers.GUI.BackpackController.Main)
                if a1._destroyed then
                    return
                end
                u61 = Main
                a1:_fireChanged()
            end)
        end
        v1 = u61
    end
    if v1 then
        return (v1:ForceEggIntoTutorialHotbar(v2))
    end
    return nil
end

function u58.HasPetToolEquipped(a1) -- Line: 447
    return a1:_getEquippedTool("Asset") ~= nil
end

function u58.CanAffordFirstBaseExpansion(a1) -- Line: 451 -- upvalues: u28 (ref)
    local v1 = a1:_getSaveData()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if u28 ~= nil then
            v2 = false
            if v1.BaseUpgradeLevel == 0 then
                v2 = u28.IsNextTierAffordable(v1)
            end
        end
    end
    return v2
end

function u58.HasFinishedFirstBaseExpansion(a1) -- Line: 456 -- upvalues: u28 (ref)
    local v1 = a1:_getSaveData()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if 0 < v1.BaseUpgradeLevel then
            v2 = false
            if u28 ~= nil then
                v2 = not u28.Transition.IsPlaying()
            end
        end
    end
    return v2
end

function u58.GetPlotUpgradeSignTarget(a1) -- Line: 464 -- upvalues: PlotState (val)
    local v1 = PlotState.ResolvePlot()
    if v1 == nil then
        return nil
    end
    local PlotUpgrade = v1.PlotFolder:FindFirstChild("PlotUpgrade")
    if PlotUpgrade ~= nil and PlotUpgrade:IsA("Model") then
        v1 = PlotUpgrade:FindFirstChild("Sign")
        if v1 ~= nil and v1:IsA("BasePart") then
            return v1
        end
        return nil
    end
    return nil
end

function u58.HasFinishedTreadmillIntro(a1) -- Line: 478
    return a1._treadmillIntroFinished
end

function u58.MarkTreadmillIntroFinished(a1) -- Line: 482
    if a1._treadmillIntroFinished then
        return
    end
    a1._treadmillIntroFinished = true
    a1:_fireChanged()
end

function u58:Destroy() -- Line: 490
    self._destroyed = true
    self._trove:Destroy()
    self.Changed:Destroy()
end

return u58