-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetMovementBatch
-- Decompile time: 12.72 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(script.Parent.Types)
local PetUpdateSchedule = require(script.Parent.PetUpdateSchedule)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local u53 = Log.new()
local u54 = {}
u54.__index = u54
u54.__class = "AssetMovementBatch"
assert(workspace.Transient:IsA("Folder"), "Workspace.Transient must be a Folder")
local World = workspace.World
assert(World:IsA("Folder"), "Workspace.World must be a Folder")
local Areas = World.Areas
assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
local Ground = Areas.Ground
assert(Ground:IsA("BasePart"), "Workspace.World.Areas.Ground must be a BasePart")

function u54.new() -- Line: 65 -- upvalues: u54 (val), Trove (val), u53 (val)
    local v1 = setmetatable({}, u54)
    v1._trove = Trove.new()
    v1._entries = {}
    v1._orderedModels = {}
    v1._partsBuffer = {}
    v1._cframeBuffer = {}
    v1._foreignEntryCount = 0
    v1._foreignPresentationSuppressed = false
    v1._foreignPresentationForcedSuppressed = false
    v1._scheduleSettings = {Enabled = true, HiddenInterval = 0.1, DistantInterval = 0.1, DistantDistance = 300}
    v1:_init()
    u53:AtDebug():Log("Created asset movement batch")
    return v1
end

function u54._createGroundingRaycastParams(a1) -- Line: 90
    -- upvalues: PlacedEggRenderer (val), Ground (val)
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = {PlacedEggRenderer.GetRenderFolder(), Ground, a1}
    v1.IgnoreWater = true
    return v1
end

function u54._groundCFrame(a1, a2, a3) -- Line: 102 -- types: a1: number, a2: userdata, a3: userdata
    local Position = a2.Position
    local v1 = Position + Vector3.new(0, 64, 0)
    local v2 = workspace:Raycast(v1, Vector3.new(0, -2000, 0), a3)
    if v2 == nil then
        return nil
    end
    return (CFrame.new((Vector3.new(Position.X, v2.Position.Y - a1, Position.Z)))) * a2.Rotation
end

function u54._groundTargetCFrame(a1) -- Line: 120 -- upvalues: u54 (val)
    local v1 = u54._groundCFrame(a1.BottomLocalY, a1.TargetCFrame, a1.GroundingRaycastParams)
    if v1 ~= nil then
        return v1
    end
    local TargetCFrame = a1.TargetCFrame
    local Position = TargetCFrame.Position
    return (CFrame.new(Position.X, a1.SimulationCFrame.Position.Y, Position.Z)) * TargetCFrame.Rotation
end

function u54._movementAlpha(a1) -- Line: 136 -- types: a1: number
    return (math.clamp(a1 * 8, 0, 1))
end

function u54._airborneMovementAlpha(a1) -- Line: 140 -- types: a1: number
    return (math.clamp(a1 * 14, 0, 0.45))
end

function u54._isPresentationEnabled(a1, a2) -- Line: 144 -- types: a2: boolean
    return not a1.PresentationHidden and (a1.IsLocalOwner or not a2)
end

function u54._advanceSuppressedSimulation(a1) -- Line: 151
    local TargetCFrame = a1.TargetCFrame
    local Position = TargetCFrame.Position
    a1.SimulationCFrame = (CFrame.new(Position.X, a1.SimulationCFrame.Position.Y, Position.Z)) * TargetCFrame.Rotation
end

function u54:_forgetEntry(a2) -- Line: 159 -- types: a2: userdata
    local v1 = self._entries[a2]
    if v1 ~= nil then
        if not v1.IsLocalOwner then
            assert(0 < self._foreignEntryCount, "Foreign movement entry count cannot underflow")
            self._foreignEntryCount = self._foreignEntryCount - 1
        end
        self._entries[a2] = nil
    end
end

function u54:_removeMissingModels() -- Line: 170
    local v1
    local v2 = self
    for i = #self._orderedModels, 1, -1 do
        v1 = v2._orderedModels[i]
        if v2._entries[v1] == nil or v1.Parent == nil then
            v2:_forgetEntry(v1)
            table.remove(v2._orderedModels, i)
        end
    end
end

function u54:_flush(a2, a3) -- Line: 182 -- upvalues: u54 (val) -- types: a2: number, a3: boolean
    local CurrentCFrame, SimulationCFrame, TargetCFrame, v1, v2, v3
    table.clear(self._partsBuffer)
    table.clear(self._cframeBuffer)
    local v4, v5, v6 = self, a3, a2
    for i, v in ipairs(self._orderedModels) do
        v2 = v4._entries[v]
        if v2 ~= nil and v.Parent ~= nil and u54._isPresentationEnabled(v2, v5) then
            SimulationCFrame = if not v2.GroundingDue then v2.SimulationCFrame else u54._groundTargetCFrame(v2)
            v2.SimulationCFrame = SimulationCFrame
            TargetCFrame = if not v2.GroundingEnabled then v2.TargetCFrame else SimulationCFrame
            v3 = if not v2.GroundingEnabled then u54._airborneMovementAlpha(v6) else u54._movementAlpha(v6)
            if 0 < v2.CatchUpRemaining then
                v3 = math.clamp(v6 / v2.CatchUpRemaining, 0, 1)
                v2.CatchUpRemaining = math.max(v2.CatchUpRemaining - v6, 0)
            end
            CurrentCFrame = if not v2.PresentationFrozen then v2.CurrentCFrame:Lerp(TargetCFrame, v3) else v2.CurrentCFrame
            v1 = CurrentCFrame * v2.PresentationOffset
            v3 = v:GetPivot()
            v2.CurrentCFrame = CurrentCFrame
            for i2, i3 in ipairs(v2.VisibleParts) do
                if i3.Parent ~= nil then
                    table.insert(v4._partsBuffer, i3)
                    table.insert(v4._cframeBuffer, v1 * (v3:ToObjectSpace(i3.CFrame)))
                end
            end
        end
    end
    if #v4._partsBuffer > 0 then
        workspace:BulkMoveTo(v4._partsBuffer, v4._cframeBuffer, Enum.BulkMoveMode.FireCFrameChanged)
    end
end

function u54:_step(a2) -- Line: 234
    -- upvalues: GameFlags (val), PetUpdateSchedule (val), u54 (val)
    local v1, v2, v3, v4
    self:_removeMissingModels()
    local _scheduleSettings = self._scheduleSettings
    _scheduleSettings.Enabled = GameFlags.PetUpdateSchedulingEnabled:Get()
    _scheduleSettings.HiddenInterval = GameFlags.HiddenPetUpdateInterval:Get()
    _scheduleSettings.DistantInterval = GameFlags.DistantPetUpdateInterval:Get()
    _scheduleSettings.DistantDistance = GameFlags.DistantPetUpdateDistance:Get()
    local CurrentCamera = workspace.CurrentCamera
    local Position = if CurrentCamera == nil then nil else CurrentCamera.CFrame.Position
    local _foreignPresentationForcedSuppressed = self._foreignPresentationForcedSuppressed or 30 <= self._foreignEntryCount
    local v5 = self._foreignPresentationSuppressed ~= _foreignPresentationForcedSuppressed
    local _foreignPresentationSuppressed = self._foreignPresentationSuppressed and not _foreignPresentationForcedSuppressed
    self._foreignPresentationSuppressed = _foreignPresentationForcedSuppressed
    local v6, v7 = a2, self
    for i, v in ipairs(self._orderedModels) do
        v1 = v7._entries[v]
        if v1 ~= nil and v.Parent ~= nil then
            v2, v3, v4 = PetUpdateSchedule.TakeStep(v1.StepElapsed, v6, PetUpdateSchedule.GetInterval(
                v1.PresentationHidden,
                v1.IsLocalOwner,
                v1.CurrentCFrame.Position,
                if v1.PresentationHidden or v1.IsLocalOwner or Position == nil then 0 else v1.VisualRadius * ((v:GetScale()) / v1.InitialScale),
                Position,
                _scheduleSettings
            ), v1.ForceStep or v5)
            v1.StepElapsed = v4
            v1.ForceStep = false
            v1.GroundingDue = v2
            if v2 then
                v1.Step(v3, not v1.IsLocalOwner and _foreignPresentationForcedSuppressed)
            end
            if v1.PresentationHidden then
                u54._advanceSuppressedSimulation(v1)
            elseif v1.IsLocalOwner then
                if not v1.IsLocalOwner and _foreignPresentationSuppressed then
                    v1.CatchUpRemaining = math.max(v1.CatchUpRemaining, 0.25)
                end
            elseif _foreignPresentationForcedSuppressed then
                u54._advanceSuppressedSimulation(v1)
            elseif not v1.IsLocalOwner and _foreignPresentationSuppressed then
                v1.CatchUpRemaining = math.max(v1.CatchUpRemaining, 0.25)
            end
        end
    end
    v7:_flush(v6, _foreignPresentationForcedSuppressed)
end

function u54:Add(a2, a3, a4, a5, a6, a7, a8) -- Line: 283
    -- upvalues: t (val), u54 (val)
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.array(t.instanceIsA("BasePart")))(a3)
    t.strict(t.CFrame)(a4)
    t.strict(t.number)(a5)
    t.strict(t.instanceIsA("BasePart"))(a6)
    t.strict(t.boolean)(a7)
    assert(self._entries[a2] == nil, (("Asset model %* is already registered in the movement batch"):format(a2.Name)))
    local v1 = u54._createGroundingRaycastParams(a6)
    local v2 = u54._groundCFrame(a5, a4, v1) or a4
    local BoundingBox, BoundingBox_2 = a2:GetBoundingBox()
    local v3 = BoundingBox_2.Magnitude * 0.5 + (BoundingBox.Position - a2:GetPivot().Position).Magnitude
    self._entries[a2] = {
        GroundingEnabled = true,
        PresentationFrozen = false,
        CatchUpRemaining = 0,
        PresentationHidden = false,
        StepElapsed = 0,
        ForceStep = true,
        GroundingDue = true,
        Model = a2,
        VisibleParts = a3,
        AssetArea = a6,
        GroundingRaycastParams = v1,
        IsLocalOwner = a7,
        BottomLocalY = a5,
        TargetCFrame = a4,
        CurrentCFrame = a4,
        SimulationCFrame = v2,
        Step = a8,
        PresentationOffset = CFrame.identity,
        VisualRadius = v3,
        InitialScale = a2:GetScale(),
    }
    if not a7 then
        self._foreignEntryCount = self._foreignEntryCount + 1
    end
    table.insert(self._orderedModels, a2)
end

function u54.GetSimulationCFrame(a1, a2) -- Line: 341 -- upvalues: t (val) -- types: a2: userdata
    t.strict(t.instanceIsA("Model"))(a2)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    return v1.SimulationCFrame
end

function u54.ResolveGroundedCFrame(a1, a2) -- Line: 350
    -- upvalues: t (val), ModelBounds (val), PlacedEggRenderer (val), Ground (val), PlotState (val), u54 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.CFrame)(a2)
    local v1, v2 = ModelBounds(a1)
    v1 = (a1:GetPivot()):PointToObjectSpace(v1.Position).Y - v2.Y * 0.5
    local v3 = {PlacedEggRenderer.GetRenderFolder(), Ground}
    v2 = PlotState.ResolvePlot()
    if v2 and v2.PetArea then
        table.insert(v3, v2.PetArea)
    end
    v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Include
    v2.FilterDescendantsInstances = v3
    v2.IgnoreWater = true
    return u54._groundCFrame(v1, a2, v2) or a2
end

function u54.SetAssetArea(a1, a2, a3) -- Line: 373 -- upvalues: t (val), u54 (val) -- types: a2: userdata, a3: userdata
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    if v1.AssetArea == a3 then
        return
    end
    v1.AssetArea = a3
    v1.GroundingRaycastParams = u54._createGroundingRaycastParams(a3)
    v1.ForceStep = true
end

function u54.SetTarget(a1, a2, a3) -- Line: 392 -- upvalues: t (val) -- types: a2: userdata, a3: userdata
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.CFrame)(a3)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    v1.TargetCFrame = a3
end

function u54.SetGroundingEnabled(a1, a2, a3) -- Line: 402 -- upvalues: t (val) -- types: a2: userdata, a3: boolean
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.boolean)(a3)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    v1.GroundingEnabled = a3
end

function u54.SetPresentationFrozen(a1, a2, a3, a4) -- Line: 416
    -- upvalues: t (val)
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.boolean)(a3)
    t.strict(t.optional(t.number))(a4)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    v1.PresentationFrozen = a3
    v1.CatchUpRemaining = if not a3 then math.max(a4 or 0, 0) else 0
end

function u54.SetPresentationOffset(a1, a2, a3) -- Line: 432 -- upvalues: t (val) -- types: a2: userdata, a3: userdata
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.CFrame)(a3)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* is not registered in the movement batch"):format(a2.Name)
    assert(v1 ~= nil, v2)
    v1.PresentationOffset = a3
end

function u54.SetHidden(a1, a2, a3) -- Line: 445 -- types: a2: userdata, a3: boolean
    local v1 = a1._entries[a2]
    assert(v1 ~= nil, "Asset model must be registered before changing visibility")
    if v1.PresentationHidden == a3 then
        return
    end
    v1.PresentationHidden = a3
    v1.ForceStep = true
    if not a3 then
        v1.CatchUpRemaining = math.max(v1.CatchUpRemaining, 0.25)
    end
end

function u54.SetForeignPresentationSuppressed(a1, a2) -- Line: 458 -- upvalues: t (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    a1._foreignPresentationForcedSuppressed = a2
end

function u54.Remove(a1, a2) -- Line: 466 -- upvalues: t (val) -- types: a2: userdata
    t.strict(t.instanceIsA("Model"))(a2)
    a1:_forgetEntry(a2)
    for i = #a1._orderedModels, 1, -1 do
        if a1._orderedModels[i] == a2 then
            table.remove(a1._orderedModels, i)
            return
        end
    end
end

function u54:Destroy() -- Line: 478
    self._trove:Destroy()
    table.clear(self._entries)
    table.clear(self._orderedModels)
    table.clear(self._partsBuffer)
    table.clear(self._cframeBuffer)
    self._foreignEntryCount = 0
    self._foreignPresentationSuppressed = false
    self._foreignPresentationForcedSuppressed = false
end

function u54:_init() -- Line: 493 -- upvalues: RunService (val)
    self._trove:Add((RunService.PreRender:Connect(function(a1) -- Line: 494 -- upvalues: self (val) -- types: a1: number
        self:_step(a1)
    end)))
end

return u54