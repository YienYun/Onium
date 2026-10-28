-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.ForestGuardRuntime
-- Decompile time: 14.89 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local EggState = require(ReplicatedStorage.Client.EggState)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
require(ReplicatedStorage.Shared.Types.GuardAreas)
local Guards = require(ReplicatedStorage.Data.Guards)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local GuardComponent = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardComponent)
require(ReplicatedStorage.Shared.Modules.GuardAreas.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u87 = {}
u87.__index = u87
u87.__class = "ForestGuardRuntime"
local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer

local function suppressGuardVisuals(a1) -- Line: 75 -- types: a1: userdata
    local v1
    local u52 = {}
    local u57 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") then
            v1 = {
                CanCollide = v.CanCollide,
                CanQuery = v.CanQuery,
                CanTouch = v.CanTouch,
                LocalTransparencyModifier = v.LocalTransparencyModifier,
            }
            u57[v] = v1
            v.LocalTransparencyModifier = 1
            v.CanCollide = false
            v.CanQuery = false
            v.CanTouch = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") or v:IsA("BillboardGui") then
            local Enabled = v.Enabled
            table.insert(u52, function() -- Line: 106 -- upvalues: v (val), Enabled (val)
                v.Enabled = Enabled
            end)
            v.Enabled = false
        end
    end
    return function() -- Line: 110 -- upvalues: u57 (val), u52 (val)
        for k, v in pairs(u57) do
            k.LocalTransparencyModifier = v.LocalTransparencyModifier
            k.CanCollide = v.CanCollide
            k.CanQuery = v.CanQuery
            k.CanTouch = v.CanTouch
        end
        for i, i2 in ipairs(u52) do
            i2()
        end
    end
end

local function stageGuardForConstruction(a1, a2) -- Line: 123
    -- upvalues: suppressGuardVisuals (val)
    a1.Name = "ForestGuardStaging"
    local v1 = suppressGuardVisuals(a1)
    a1.Parent = a2
    return v1
end

function u87.new(a1) -- Line: 134
    -- upvalues: t (val), Workspace (val), u87 (val), Trove (val), LocalPlayer (val), Remotes (val)
    -- upvalues: suppressGuardVisuals (val), GuardComponent (val), Guards (val), Player (val), GuardAreaGeometry (val)
    t.strict(t.instanceIsA("Model"))(a1)
    assert(a1.Name == "Forest", "ForestGuardRuntime requires area Forest")
    local Guard = a1.Guard
    local Bounds = a1.Bounds
    assert(a1:IsDescendantOf(Workspace), "Forest area must be in Workspace before guard construction")
    assert(Guard.Parent == a1, "Forest authored guard must belong to its area before guard construction")
    local u37 = Guard:Clone()
    local u172 = setmetatable({}, u87)
    u172._areaModel = a1
    u172._authoredGuard = Guard
    u172._clientEggFolder = nil
    u172._droppedModelByUid = {}
    u172._droppedTroveByUid = {}
    u172._guardModel = u37
    u172._hiddenRestore = nil
    u172._registeredDroppedUids = {}
    u172._registeredStolenUids = {}
    u172._trove = Trove.new()
    u172._wake = nil
    local u53 = {ServerOwnsPhysics = false}

    function u53.Attack(a1) -- Line: 164 -- upvalues: LocalPlayer (upval), Remotes (upval)
        if a1.Player == LocalPlayer and a1.EggUid ~= nil then
            local v1 = {EggUid = a1.EggUid, GuardCFrame = a1.GuardRoot.CFrame}
            Remotes.GuardPatrol.ForestStrike:FireServer(v1)
            return
        end
    end

    function u53.Wake(a1) -- Line: 175 -- upvalues: u172 (val) -- types: a1: userdata
        local _wake = u172._wake
        if _wake ~= nil then
            _wake(a1)
        end
    end

    local u56 = nil
    local u57 = nil
    local success, result = xpcall(function() -- Line: 184
        -- upvalues: u56 (ref), u37 (val), a1 (val), suppressGuardVisuals (upval), u57 (ref), GuardComponent (upval)
        -- upvalues: Bounds (val), Workspace (upval), Guards (upval), LocalPlayer (upval), Player (upval)
        -- upvalues: GuardAreaGeometry (upval), u53 (val), Guard (val)
        local v1 = u37
        local v2 = a1
        v1.Name = "ForestGuardStaging"
        local v3 = suppressGuardVisuals(v1)
        v1.Parent = v2
        u56 = v3
        GuardComponent.new("Forest", u37, Bounds, Workspace.World.Areas.Ground, Guards.Directory.Forest, function(a1) -- Line: 192
            -- upvalues: LocalPlayer (upval), Player (upval), GuardAreaGeometry (upval), Workspace (upval)
            if a1 ~= LocalPlayer then
                return false
            end
            local v1 = Player.FindRootPart(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = GuardAreaGeometry.IsPastLine(Workspace.World.Areas.SeparationLine, v1.Position)
            end
            return v2
        end, u53)
        assert(a1:IsDescendantOf(Workspace), "Forest area was removed during guard construction")
        assert(Guard.Parent == a1, "Forest authored guard was removed during guard construction")
    end, function(a1) -- Line: 207
        return debug.traceback(tostring(a1), 2)
    end)
    if not success then
        if u57 ~= nil then
            u57:Destroy()
        end
        u37:Destroy()
        u172._trove:Destroy()
        error(result, 0)
    end
    u172._component = assert(u57, "Forest shared guard component did not initialize")
    local v1 = assert(u56, "Forest guard staging did not initialize")
    u172._trove:Add(u37)
    u172._trove:Add(function() -- Line: 220 -- upvalues: Guard (val)
        if Guard.Parent ~= nil then
            Guard.Name = "Guard"
        end
    end)
    Guard.Name = "ForestGuardAuthored"
    u37.Name = "Guard"
    for i, v in ipairs(Guard:GetDescendants()) do
        if v:IsA("BasePart") then
            local LocalTransparencyModifier = v.LocalTransparencyModifier
            u172._trove:Add(function() -- Line: 231 -- upvalues: v (val), LocalTransparencyModifier (val)
                if v.Parent ~= nil then
                    v.LocalTransparencyModifier = LocalTransparencyModifier
                end
            end)
            v.LocalTransparencyModifier = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") or v:IsA("BillboardGui") then
            local Enabled = v.Enabled
            u172._trove:Add(function() -- Line: 245 -- upvalues: v (val), Enabled (val)
                if v.Parent ~= nil then
                    v.Enabled = Enabled
                end
            end)
            v.Enabled = false
        end
    end
    v1()
    u172._trove:Add(((Guard:GetAttributeChangedSignal("Hidden")):Connect(function() -- Line: 258 -- upvalues: u172 (val)
        u172:_applyHidden()
    end)))
    u172:_applyHidden()
    return u172
end

function u87._isOwnedForestRecord(a1, a2) -- Line: 269 -- upvalues: AreaEggSlotIdentity (val), LocalPlayer (val)
    local v1 = false
    if a2.AreaId == "Forest" then
        v1 = (AreaEggSlotIdentity.FirstAreaOwnerUserId(a2.Uid)) == LocalPlayer.UserId
    end
    return v1
end

function u87:_clearStolen(a2) -- Line: 277 -- types: a2: string
    if self._registeredStolenUids[a2] ~= true then
        return
    end
    self._registeredStolenUids[a2] = nil
    self._component:ClearStolenEgg(a2)
end

function u87:_registerStolen(a2, a3) -- Line: 285
    -- upvalues: LocalPlayer (val), AssetItems (val)
    if self._registeredStolenUids[a2] == true then
        return
    end
    for k in pairs(self._registeredStolenUids) do
        self:_clearStolen(k)
    end
    self._registeredStolenUids[a2] = true
    self._component:RegisterStolenEgg(LocalPlayer, a2, (AssetItems.RarityRankForCategory(a3)))
end

function u87:_clearDropped(a2) -- Line: 304 -- types: a2: string
    local v1 = self._droppedTroveByUid[a2]
    if v1 ~= nil then
        self._droppedTroveByUid[a2] = nil
        v1:Destroy()
    end
    self._droppedModelByUid[a2] = nil
    if self._registeredDroppedUids[a2] ~= true then
        return
    end
    self._registeredDroppedUids[a2] = nil
    self._component:ClearDroppedEgg(a2)
end

function u87:_tryRegisterDropped(a2) -- Line: 318
    -- upvalues: GuardAreaGeometry (val), AreaEggSlotIdentity (val), AssetItems (val), Trove (val), EggState (val)
    -- upvalues: States (val)
    if self._registeredDroppedUids[a2.Uid] == true
        or not GuardAreaGeometry.IsWithinFootprint(self._areaModel.Bounds, a2.BoundsCFrame.Position) then
        return
    end
    local _clientEggFolder = self._clientEggFolder
    if _clientEggFolder == nil then
        return
    end
    local u16 = _clientEggFolder:FindFirstChild(a2.Uid)
    if u16 == nil then
        return
    end
    assert(u16:IsA("Model"), (("%*.%* must be a Model"):format(_clientEggFolder:GetFullName(), a2.Uid)))
    if not self._component:RegisterDroppedEgg({
        EggUid = a2.Uid,
        Model = u16,
        DroppedPosition = a2.BottomCFrame.Position,
        NestBottomCFrame = (AreaEggSlotIdentity.NestFor(self._areaModel, a2.NestId)).EggSpotBottom.CFrame,
        Priority = AssetItems.RarityRankForCategory(a2.AssetCategory),
    }) then
        return
    end
    self._registeredDroppedUids[a2.Uid] = true
    self._droppedModelByUid[a2.Uid] = u16
    local v1 = Trove.new()
    self._droppedTroveByUid[a2.Uid] = v1
    v1:Connect(u16.AncestryChanged, function(a1, a2_2) -- Line: 355
        -- upvalues: self (val), a2 (val), u16 (val), EggState (upval), States (upval)
        if a2_2 == nil then
            local v1 = self._droppedModelByUid[a2.Uid]
            if v1 == u16 then
                self:_clearDropped(a2.Uid)
                v1 = EggState.ReadFieldEgg(a2.Uid)
                if v1 ~= nil and v1.State == States.Dropped then
                    self:_tryRegisterDropped(v1)
                end
                return
            end
        end
    end)
end

function u87:_syncRecord(a2) -- Line: 367 -- upvalues: States (val), LocalPlayer (val)
    if not self:_isOwnedForestRecord(a2) then
        return
    end
    if a2.State == States.Carried and a2.CarrierUserId == LocalPlayer.UserId then
        self:_clearDropped(a2.Uid)
        self:_registerStolen(a2.Uid, a2.AssetCategory)
        return
    end
    self:_clearStolen(a2.Uid)
    if a2.State == States.Dropped then
        self:_tryRegisterDropped(a2)
        return
    end
    self:_clearDropped(a2.Uid)
end

function u87:_syncSnapshot(a2) -- Line: 385
    local v1 = {}
    for i, v in ipairs(a2.Records) do
        if self:_isOwnedForestRecord(v) then
            v1[v.Uid] = true
            self:_syncRecord(v)
        end
    end
    for k in pairs(self._registeredStolenUids) do
        if v1[k] ~= true then
            self:_clearStolen(k)
        end
    end
    for k2 in pairs(self._registeredDroppedUids) do
        if v1[k2] ~= true then
            self:_clearDropped(k2)
        end
    end
end

function u87:_handleRetrievalEvent(a2) -- Line: 408 -- upvalues: Remotes (val)
    local v1
    if a2.Kind == "Attached" then
        v1 = self._droppedModelByUid[a2.EggUid]
        if v1 ~= nil then
            local CarryAreaEgg = v1:FindFirstChild("CarryAreaEgg", true)
            if CarryAreaEgg ~= nil then
                assert(CarryAreaEgg:IsA("ProximityPrompt"), (("%* must be a ProximityPrompt"):format((CarryAreaEgg:GetFullName()))))
                CarryAreaEgg:Destroy()
            end
        end
        Remotes.GuardPatrol.ForestHandoff:FireServer({Kind = "Attached", EggUid = a2.EggUid})
        return
    end
    v1 = {Kind = "Deposited", EggUid = a2.EggUid}
    self._registeredDroppedUids[a2.EggUid] = nil
    self._droppedModelByUid[a2.EggUid] = nil
    local v2 = self._droppedTroveByUid[a2.EggUid]
    if v2 ~= nil then
        self._droppedTroveByUid[a2.EggUid] = nil
        v2:Destroy()
    end
    Remotes.GuardPatrol.ForestHandoff:FireServer(v1)
end

function u87:_applyHidden() -- Line: 445 -- upvalues: suppressGuardVisuals (val)
    local v1
    self._guardModel:SetAttribute("Hidden", self._authoredGuard:GetAttribute("Hidden") == true or nil)
    local _hiddenRestore = self._hiddenRestore
    if v1 then
        if _hiddenRestore == nil then
            self._hiddenRestore = suppressGuardVisuals(self._guardModel)
        end
        return
    end
    if _hiddenRestore ~= nil then
        self._hiddenRestore = nil
        _hiddenRestore()
    end
end

function u87.GetGuardModel(a1) -- Line: 467
    return a1._guardModel
end

function u87.SetWakeHandler(a1, a2) -- Line: 469 -- upvalues: t (val) -- types: a2: function
    t.strict(t.callback)(a2)
    a1._wake = a2
end

function u87:SetEnabled(a2) -- Line: 477 -- upvalues: t (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    self._component:SetEnabled(a2)
end

function u87.Start(a1) -- Line: 482 -- upvalues: EggState (val), Workspace (val), RunService (val)
    a1._trove:Add((EggState.FieldRefreshed:Connect(function(a1_2) -- Line: 485 -- upvalues: a1 (val)
        a1:_syncSnapshot(a1_2)
    end)))
    a1._trove:Add((EggState.FieldShifted:Connect(function(a1_2) -- Line: 489 -- upvalues: a1 (val)
        a1:_syncRecord(a1_2)
    end)))
    a1._trove:Add((EggState.FieldGone:Connect(function(a1_2) -- Line: 491 -- upvalues: a1 (val) -- types: a1_2: string
        a1:_clearStolen(a1_2)
        a1:_clearDropped(a1_2)
    end)))
    a1._trove:Add((EggState.CarryChanged:Connect(function(a1_2) -- Line: 495 -- upvalues: a1 (val)
        if a1_2.IsCarrying and a1_2.Uid ~= nil and a1_2.AssetCategory ~= nil and a1_2.AreaId == "Forest" then
            a1:_registerStolen(a1_2.Uid, a1_2.AssetCategory)
            return
        end
        for k in pairs(a1._registeredStolenUids) do
            a1:_clearStolen(k)
        end
    end)))
    task.spawn(function() -- Line: 510 -- upvalues: Workspace (upval), a1 (val), EggState (upval)
        local AreaEggSlotsClient = Workspace:WaitForChild("AreaEggSlotsClient")
        assert(AreaEggSlotsClient:IsA("Folder"), "Workspace.AreaEggSlotsClient must be a Folder")
        if a1._guardModel.Parent == nil then
            return
        end
        a1._clientEggFolder = AreaEggSlotsClient
        a1._trove:Connect(AreaEggSlotsClient.ChildAdded, function(a1_2) -- Line: 517 -- upvalues: a1 (upval), AreaEggSlotsClient (val), EggState (upval) -- types: a1_2: userdata
            if a1._clientEggFolder == AreaEggSlotsClient and a1_2.Parent == AreaEggSlotsClient then
                local v1 = EggState.ReadFieldEgg(a1_2.Name)
                if v1 ~= nil then
                    a1:_syncRecord(v1)
                end
                return
            end
        end)
        a1:_syncSnapshot((EggState.ReadFieldEggs()))
    end)
    local u44 = 0
    a1._trove:Connect(RunService.Heartbeat, function(a1_2) -- Line: 530 -- upvalues: u44 (ref), a1 (val) -- types: a1_2: number
        u44 = u44 + a1_2
        if u44 < 0.03 then
            return
        end
        u44 = 0
        local v1 = a1._component:Step((os.clock()))
        if v1 ~= nil then
            a1:_handleRetrievalEvent(v1)
        end
    end)
    a1:_syncSnapshot((EggState.ReadFieldEggs()))
end

function u87:Destroy() -- Line: 544
    self._clientEggFolder = nil
    for k in pairs(self._registeredDroppedUids) do
        self:_clearDropped(k)
    end
    for k2, v in pairs(self._droppedTroveByUid) do
        if v ~= nil then
            v:Destroy()
        end
    end
    self._component:Destroy()
    self._trove:Destroy()
    table.clear(self._registeredDroppedUids)
    table.clear(self._registeredStolenUids)
    table.clear(self._droppedModelByUid)
    table.clear(self._droppedTroveByUid)
end

return u87