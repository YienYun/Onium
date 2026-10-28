-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController
-- Decompile time: 23.84 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggNearbyPulse = require(script.AreaEggNearbyPulse)
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local EggState = require(ReplicatedStorage.Client.EggState)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HoverHighlight = require(script.HoverHighlight)
local Log = require(ReplicatedStorage.Packages.Log)
local OnboardingTiming = require(ReplicatedStorage.Shared.Util.OnboardingTiming)
local NestResolver = require(script.NestResolver)
local Player = require(ReplicatedStorage.Shared.Player)
local RareEggHighlight = require(script.RareEggHighlight)
local SafeZoneBarriers = require(ReplicatedStorage.Shared.Util.SafeZoneBarriers)
local SmartProximityPrompt = require(ReplicatedStorage.Client.SmartProximityPrompt)
local Trove = require(ReplicatedStorage.Packages.Trove)
local WorkspaceEggVisibility = require(script.WorkspaceEggVisibility)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer
local u99 = Log.new()

local function newRenderQueue(a1) -- Line: 71 -- types: a1: number
    return {Pumping = false, Jobs = {}, Order = {}, PerFrame = a1}
end

local function discardRender(a1, a2) -- Line: 75 -- types: a1: table, a2: string
    a1.Jobs[a2] = nil
end

local function drainRenderQueue(a1) -- Line: 79 -- upvalues: u99 (val) -- types: a1: table
    local err, success, v1, v2, v3, v4
    while true do
        if not (#a1.Order > 0) then
            break
        end
        v2 = 0
        v1 = a1
        while v2 < v1.PerFrame do
            v3 = table.remove(v1.Order, 1)
            if v3 == nil then
                break
            end
            v4 = v1.Jobs[v3]
            if v4 ~= nil then
                v1.Jobs[v3] = nil
                v2 = v2 + 1
                success, err = pcall(v4)
                if not success then
                    (u99:AtError()):Log((("Area egg render for %* failed: %*"):format(v3, err)))
                end
            end
        end
        task.wait()
    end
    a1.Pumping = false
end

local function enqueueRender(a1, a2, a3) -- Line: 102
    -- upvalues: drainRenderQueue (val)
    if a1.Jobs[a2] == nil then
        table.insert(a1.Order, a2)
    end
    a1.Jobs[a2] = a3
    if not a1.Pumping then
        a1.Pumping = true
        task.defer(drainRenderQueue, a1)
    end
end

return {
    Start = function() -- Line: 115
        -- upvalues: AreaEggNearbyPulse (val), LocalPlayer (val), newRenderQueue (val), Workspace (val), EggState (val)
        -- upvalues: Player (val), GuardAreaGeometry (val), SafeZoneBarriers (val), TryCall (val), NestResolver (val)
        -- upvalues: EggRenderer (val), RareEggHighlight (val), SmartProximityPrompt (val), Trove (val), States (val)
        -- upvalues: HoverHighlight (val), ReplicatedStorage (val), AreaEggSlotIdentity (val)
        -- upvalues: WorkspaceEggVisibility (val), u99 (val), OnboardingTiming (val), drainRenderQueue (val)
        -- upvalues: RunService (val)
        local u3 = AreaEggNearbyPulse.new(LocalPlayer)
        local u6 = newRenderQueue(1)
        local u9 = newRenderQueue(8)
        local World = Workspace.World
        assert(World:IsA("Folder"), "Workspace.World must be a Folder")
        local Areas = World.Areas
        assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
        local SeparationLine = Areas.SeparationLine
        assert(SeparationLine:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")
        local u38 = Instance.new("Folder")
        u38.Name = "AreaEggSlotsClient"
        u38.Parent = Workspace
        local u41 = {}
        local u42 = {}
        local u45 = EggState.ReadCarryState()
        local u48 = EggState.HasFieldSnapshot()
        local u49 = 0

        local function isLocalPlayerInGameplay() -- Line: 142
            -- upvalues: Player (upval), LocalPlayer (upval), GuardAreaGeometry (upval), SeparationLine (val)
            local v1 = Player.FindRootPart(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = GuardAreaGeometry.IsPastLine(SeparationLine, v1.Position)
            end
            return v2
        end

        local function isLocalPlayerTrapLocked() -- Line: 147 -- upvalues: Player (upval), LocalPlayer (upval)
            local v1 = Player.FindCharacter(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = v1:GetAttribute("IsTrapped") == true
            end
            return v2
        end

        local u52 = 8

        local function riderPromptReach() -- Line: 154 -- upvalues: Player (upval), LocalPlayer (upval)
            local v1 = Player.FindCharacter(LocalPlayer)
            local PetMountSession = if v1 == nil then nil else v1:FindFirstChild("PetMountSession")
            v1 = if PetMountSession == nil then nil else PetMountSession:GetAttribute("HeightIncrease")
            if typeof(v1) == "number" and not (v1 <= 0) then
                return (math.sqrt(64 + v1 * v1))
            end
            return 8
        end

        local function isEggReachable(a1) -- Line: 172
            -- upvalues: Player (upval), LocalPlayer (upval), u52 (ref), SafeZoneBarriers (upval)
            local v1 = Player.FindRootPart(LocalPlayer)
            if v1 == nil then
                return false
            end
            local Position = a1.Record.BoundsCFrame.Position
            local Magnitude = (Position - v1.Position).Magnitude
            if u52 + 4 < Magnitude then
                return true
            end
            return not SafeZoneBarriers.Separates(v1.Position, Position, SafeZoneBarriers.IsFencedUid(a1.Record.Uid))
        end

        local function updatePromptEnabled(a1) -- Line: 189
            -- upvalues: Player (upval), LocalPlayer (upval), GuardAreaGeometry (upval), SeparationLine (val)
            -- upvalues: isEggReachable (val)
            local Prompt = a1.Prompt
            local v1 = Player.FindRootPart(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = GuardAreaGeometry.IsPastLine(SeparationLine, v1.Position)
            end
            if v2 then
                local v3 = Player.FindCharacter(LocalPlayer)
                v1 = false
                if v3 ~= nil then
                    v1 = v3:GetAttribute("IsTrapped") == true
                end
                v2 = not v1 and isEggReachable(a1)
            end
            Prompt.Enabled = v2
        end

        local function cleanupRendered(a1) -- Line: 195
            -- upvalues: u42 (val), u6 (val), u9 (val), u41 (val), TryCall (upval)
            u42[a1] = nil
            u6.Jobs[a1] = nil
            u9.Jobs[a1] = nil
            local v1 = u41[a1]
            if v1 == nil then
                return
            end
            u41[a1] = nil
            v1.Trove:Destroy()
            if v1.OwnsModel and v1.Model.Parent ~= nil then
                TryCall(v1.Model.Destroy, v1.Model)
            end
        end

        local function scaleNestForRecord(a1) -- Line: 210 -- upvalues: NestResolver (upval)
            local v1 = NestResolver.Resolve(a1)
            v1:ScaleTo(a1.NestScale)
            return v1
        end

        local function renderClientEgg(a1) -- Line: 216 -- upvalues: EggRenderer (upval), u38 (val)
            local Model = EggRenderer.RenderVisual({
                OwnerUserId = 0,
                ScaleAlpha = 1,
                UID = a1.Uid,
                ModelName = a1.Uid,
                Record = {
                    AssetCategory = a1.AssetCategory,
                    AssetScale = a1.AssetScale,
                    AssetEyeColor = a1.AssetEyeColor,
                    AssetColorSeed = a1.AssetColorSeed,
                    AssetColorIndex = a1.AssetColorIndex,
                    Mutations = table.clone(a1.Mutations),
                    BaseMutation = a1.BaseMutation,
                    HasParasite = a1.HasParasite,
                },
            }, u38, false).Model
            Model:PivotTo(a1.BottomCFrame)
            return Model
        end

        local function bindPrompt(a1, a2, a3) -- Line: 238
            -- upvalues: RareEggHighlight (upval), Workspace (upval), SmartProximityPrompt (upval), Trove (upval)
            -- upvalues: u41 (val), States (upval), u3 (val), HoverHighlight (upval), LocalPlayer (upval), u49 (ref)
            -- upvalues: ReplicatedStorage (upval), AreaEggSlotIdentity (upval), EggState (upval), cleanupRendered (val)
            -- upvalues: WorkspaceEggVisibility (upval), u99 (upval), Player (upval), GuardAreaGeometry (upval)
            -- upvalues: SeparationLine (val), isEggReachable (val)
            RareEggHighlight.BindRenderedModel(a1, a2)
            local ProximityPrompt = Instance.new("ProximityPrompt")
            ProximityPrompt.Name = "CarryAreaEgg"
            ProximityPrompt.ActionText = "Steal"
            ProximityPrompt.ObjectText = "Egg"
            ProximityPrompt.MaxActivationDistance = 8
            ProximityPrompt.HoldDuration = if not Workspace:GetAttribute("FastEggPickupTime") then 1.2 else 0.25
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
            local v1 = SmartProximityPrompt.AttachToModel(ProximityPrompt, a2, {MaxActivationDistance = 8, TrackDistance = 8, SurfaceOffset = 0.75})
            local v2 = Trove.new()
            v2:Add(v1)
            v1 = {
                Record = a1,
                Model = a2,
                OwnsModel = a3,
                Prompt = ProximityPrompt,
                Trove = v2,
            }
            u41[a1.Uid] = v1
            if a1.State == States.Slot then
                v2:Add((u3:Bind(a1.Uid, a2, (Workspace:GetServerTimeNow()))))
            end
            HoverHighlight.Bind(a2, ProximityPrompt, v2)
            v2:Connect(ProximityPrompt.Triggered, function(a1_2) -- Line: 269
                -- upvalues: LocalPlayer (upval), u49 (upval), ReplicatedStorage (upval), AreaEggSlotIdentity (upval)
                -- upvalues: a1 (val), EggState (upval), cleanupRendered (upval), WorkspaceEggVisibility (upval)
                -- upvalues: u99 (upval)
                if a1_2 ~= LocalPlayer then
                    return
                end
                local Character = LocalPlayer.Character
                if Character then
                    local v1
                    for i, j in Character:GetChildren() do
                        if j:IsA("Tool") and j:GetAttribute("ItemType") == "MutationConsumable" then
                            v1 = os.clock()
                            if u49 <= v1 then
                                u49 = v1 + 2.5
                                ;(require(ReplicatedStorage.Client.Notifications.Toast)).Show({
                                    Text = "can only be used on your own eggs",
                                    Seconds = 2.5,
                                    SingleLine = true,
                                    Color = Color3.fromRGB(255, 100, 100),
                                })
                            end
                            return
                        end
                    end
                end
                local v2 = if not AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then nil else AreaEggSlotIdentity.SlotKey(a1.AreaId, a1.NestId)
                local v3, v4 = EggState.CarryFieldEgg(a1.Uid, v2)
                if v3 and v2 ~= nil then
                    cleanupRendered(a1.Uid)
                    WorkspaceEggVisibility.SetHidden(a1.Uid, false)
                end
                if not v3 and v4 ~= nil then
                    (u99:AtDebug()):Log((("Area egg carry denied for %*: %*"):format(a1.Uid, v4)))
                end
            end)
            local Prompt = v1.Prompt
            v2 = Player.FindRootPart(LocalPlayer)
            local v3 = false
            if v2 ~= nil then
                v3 = GuardAreaGeometry.IsPastLine(SeparationLine, v2.Position)
            end
            if v3 then
                local v4 = Player.FindCharacter(LocalPlayer)
                local v5 = false
                if v4 ~= nil then
                    v5 = v4:GetAttribute("IsTrapped") == true
                end
                v3 = not v5 and isEggReachable(v1)
            end
            Prompt.Enabled = v3
        end

        local function renderSlot(a1) -- Line: 306
            -- upvalues: cleanupRendered (val), AreaEggSlotIdentity (upval), NestResolver (upval)
            -- upvalues: WorkspaceEggVisibility (upval), bindPrompt (val), renderClientEgg (val)
            -- upvalues: OnboardingTiming (upval)
            local v1
            cleanupRendered(a1.Uid)
            if not AreaEggSlotIdentity.LooksLikeEventNestId(a1.NestId) then
                v1 = NestResolver.Resolve(a1)
                v1:ScaleTo(a1.NestScale)
                v1:PivotTo((v1:GetPivot()))
            end
            if AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then
                WorkspaceEggVisibility.SetHidden(a1.Uid, true)
                bindPrompt(a1, renderClientEgg(a1), true)
                if AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then
                    OnboardingTiming.Mark("FirstForestEggRendered")
                end
                return
            end
            v1 = WorkspaceEggVisibility.ResolveModel(a1.Uid)
            if v1 ~= nil then
                WorkspaceEggVisibility.SetHidden(a1.Uid, false)
                bindPrompt(a1, v1, false)
                return
            end
            bindPrompt(a1, renderClientEgg(a1), true)
            if AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then
                OnboardingTiming.Mark("FirstForestEggRendered")
            end
        end

        local function renderDropped(a1) -- Line: 330
            -- upvalues: cleanupRendered (val), AreaEggSlotIdentity (upval), WorkspaceEggVisibility (upval)
            -- upvalues: bindPrompt (val), renderClientEgg (val), u99 (upval)
            cleanupRendered(a1.Uid)
            if AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then
                WorkspaceEggVisibility.SetHidden(a1.Uid, true)
                bindPrompt(a1, renderClientEgg(a1), true)
                return
            end
            WorkspaceEggVisibility.SetHidden(a1.Uid, false)
            local v1 = WorkspaceEggVisibility.ResolveModel(a1.Uid)
            if v1 == nil then
                (u99:AtDebug()):Log((("Dropped area egg %* skipped because its Workspace model is not parented"):format(a1.Uid)))
                return
            end
            bindPrompt(a1, v1, false)
        end

        local function applyRecordNow(a1) -- Line: 347
            -- upvalues: WorkspaceEggVisibility (upval), States (upval), renderDropped (val), cleanupRendered (val)
            -- upvalues: renderSlot (val)
            WorkspaceEggVisibility.SetHidden(a1.Uid, false)
            if a1.State == States.Dropped then
                renderDropped(a1)
                return
            end
            if a1.State ~= States.Slot then
                cleanupRendered(a1.Uid)
                return
            end
            renderSlot(a1)
        end

        local function shouldQueueRender(a1) -- Line: 360 -- upvalues: u42 (val), u41 (val)
            if u42[a1.Uid] == a1.Version then
                return false
            end
            local v1 = u41[a1.Uid]
            local v2 = true
            if v1 ~= nil then
                v2 = true
                if v1.Record.Version == a1.Version then
                    v2 = v1.Record.State ~= a1.State
                end
            end
            return v2
        end

        local function queueApplyRecord(a1, a2) -- Line: 371
            -- upvalues: u42 (val), u41 (val), EggState (upval), WorkspaceEggVisibility (upval), States (upval)
            -- upvalues: renderDropped (val), cleanupRendered (val), renderSlot (val), drainRenderQueue (upval)
            local v1
            local v2 = u42[a1.Uid]
            if v2 ~= a1.Version then
                v2 = u41[a1.Uid]
                v1 = true
                if v2 ~= nil then
                    v1 = true
                    if v2.Record.Version == a1.Version then
                        v1 = v2.Record.State ~= a1.State
                    end
                end
            else
                v1 = false
            end
            if not v1 then
                return
            end
            u42[a1.Uid] = a1.Version
            local Uid = a1.Uid
            if a2.Jobs[Uid] == nil then
                table.insert(a2.Order, Uid)
            end

            a2.Jobs[Uid] = function() -- Line: 377
                -- upvalues: EggState (upval), a1 (val), u42 (upval), WorkspaceEggVisibility (upval), States (upval)
                -- upvalues: renderDropped (upval), cleanupRendered (upval), renderSlot (upval)
                local v1 = EggState.ReadFieldEgg(a1.Uid)
                if v1 ~= nil and v1.Version == a1.Version then
                    u42[a1.Uid] = nil
                    WorkspaceEggVisibility.SetHidden(v1.Uid, false)
                    if v1.State == States.Dropped then
                        renderDropped(v1)
                        return
                    end
                    if v1.State ~= States.Slot then
                        cleanupRendered(v1.Uid)
                        return
                    end
                    renderSlot(v1)
                    return
                end
            end

            if not a2.Pumping then
                a2.Pumping = true
                task.defer(drainRenderQueue, a2)
            end
        end

        local function applySnapshot(a1, a2) -- Line: 387
            -- upvalues: WorkspaceEggVisibility (upval), States (upval), u41 (val), cleanupRendered (val), u42 (val)
            -- upvalues: EggState (upval), renderDropped (val), renderSlot (val), drainRenderQueue (upval)
            local Uid, v1
            local v2 = {}
            local v3 = {}
            local v4 = a2
            for i, v in ipairs(a1.Records) do
                v2[v.Uid] = true
                WorkspaceEggVisibility.SetHidden(v.Uid, false)
                if v.State == States.Slot or v.State == States.Dropped then
                    table.insert(v3, v)
                end
            end
            for k in pairs(u41) do
                if not v2[k] then
                    cleanupRendered(k)
                end
            end
            for i2, i3 in ipairs(v3) do
                v2 = u42[i3.Uid]
                if v2 ~= i3.Version then
                    v2 = u41[i3.Uid]
                    v1 = true
                    if v2 ~= nil then
                        v1 = true
                        if v2.Record.Version == i3.Version then
                            v1 = v2.Record.State ~= i3.State
                        end
                    end
                else
                    v1 = false
                end
                if v1 then
                    u42[i3.Uid] = i3.Version
                    Uid = i3.Uid
                    if v4.Jobs[Uid] == nil then
                        table.insert(v4.Order, Uid)
                    end

                    v4.Jobs[Uid] = function() -- Line: 377
                        -- upvalues: EggState (upval), i3 (val), u42 (upval), WorkspaceEggVisibility (upval)
                        -- upvalues: States (upval), renderDropped (upval), cleanupRendered (upval), renderSlot (upval)
                        local v1 = EggState.ReadFieldEgg(i3.Uid)
                        if v1 ~= nil and v1.Version == i3.Version then
                            u42[i3.Uid] = nil
                            WorkspaceEggVisibility.SetHidden(v1.Uid, false)
                            if v1.State == States.Dropped then
                                renderDropped(v1)
                                return
                            end
                            if v1.State ~= States.Slot then
                                cleanupRendered(v1.Uid)
                                return
                            end
                            renderSlot(v1)
                            return
                        end
                    end

                    if not v4.Pumping then
                        v4.Pumping = true
                        task.defer(drainRenderQueue, v4)
                    end
                end
            end
        end

        local function applyInitialSnapshot(a1) -- Line: 410
            -- upvalues: WorkspaceEggVisibility (upval), States (upval), AreaEggSlotIdentity (upval), u41 (val)
            -- upvalues: cleanupRendered (val), u42 (val), renderDropped (val), renderSlot (val), u9 (val)
            -- upvalues: EggState (upval), drainRenderQueue (upval)
            local Uid, v1, v2
            local v3 = {}
            local v4 = {}
            local v5 = {}
            for i, v in ipairs(a1.Records) do
                v3[v.Uid] = true
                WorkspaceEggVisibility.SetHidden(v.Uid, false)
                if v.State == States.Slot or v.State == States.Dropped then
                    if not AreaEggSlotIdentity.LooksLikeFirstAreaUid(v.Uid) then
                        table.insert(v5, v)
                    else
                        table.insert(v4, v)
                    end
                end
            end
            for k in pairs(u41) do
                if not v3[k] then
                    cleanupRendered(k)
                end
            end
            for i2, i3 in ipairs(v4) do
                u42[i3.Uid] = nil
                WorkspaceEggVisibility.SetHidden(i3.Uid, false)
                if i3.State == States.Dropped then
                    renderDropped(i3)
                elseif i3.State == States.Slot then
                    renderSlot(i3)
                else
                    cleanupRendered(i3.Uid)
                end
            end
            for i4, j in ipairs(v5) do
                v2 = u9
                v4 = u42[j.Uid]
                if v4 ~= j.Version then
                    v4 = u41[j.Uid]
                    v1 = true
                    if v4 ~= nil then
                        v1 = true
                        if v4.Record.Version == j.Version then
                            v1 = v4.Record.State ~= j.State
                        end
                    end
                else
                    v1 = false
                end
                if v1 then
                    u42[j.Uid] = j.Version
                    Uid = j.Uid
                    if v2.Jobs[Uid] == nil then
                        table.insert(v2.Order, Uid)
                    end

                    v2.Jobs[Uid] = function() -- Line: 377
                        -- upvalues: EggState (upval), j (val), u42 (upval), WorkspaceEggVisibility (upval)
                        -- upvalues: States (upval), renderDropped (upval), cleanupRendered (upval), renderSlot (upval)
                        local v1 = EggState.ReadFieldEgg(j.Uid)
                        if v1 ~= nil and v1.Version == j.Version then
                            u42[j.Uid] = nil
                            WorkspaceEggVisibility.SetHidden(v1.Uid, false)
                            if v1.State == States.Dropped then
                                renderDropped(v1)
                                return
                            end
                            if v1.State ~= States.Slot then
                                cleanupRendered(v1.Uid)
                                return
                            end
                            renderSlot(v1)
                            return
                        end
                    end

                    if not v2.Pumping then
                        v2.Pumping = true
                        task.defer(drainRenderQueue, v2)
                    end
                end
            end
        end

        EggState.FieldClaimed:Connect(function(a1) -- Line: 443 -- upvalues: ReplicatedStorage (upval)
            require(ReplicatedStorage.Client.UI.VFX.RewardScreenTransition)()
            ;(require(ReplicatedStorage.Client.Notifications.Toast)).Show({
                Seconds = 2.5,
                Text = ("You stole an <font color=\"#%*\">EGG</font>!"):format((a1.Color:ToHex())),
                Color = Color3.new(1, 1, 1),
            })
        end)
        EggState.FieldRefreshed:Connect(function(a1) -- Line: 452 -- upvalues: u48 (ref), applyInitialSnapshot (val), applySnapshot (val), u6 (val)
            if u48 then
                applySnapshot(a1, u6)
                return
            end
            u48 = true
            applyInitialSnapshot(a1)
        end)
        EggState.FieldShifted:Connect(function(a1) -- Line: 460
            -- upvalues: WorkspaceEggVisibility (upval), States (upval), cleanupRendered (val), u6 (val), u9 (val)
            -- upvalues: u42 (val), u41 (val), EggState (upval), renderDropped (val), renderSlot (val)
            -- upvalues: drainRenderQueue (upval)
            local v1
            WorkspaceEggVisibility.SetHidden(a1.Uid, false)
            if a1.State ~= States.Slot and a1.State ~= States.Dropped then
                cleanupRendered(a1.Uid)
                return
            end
            local v2 = u6
            local Uid = a1.Uid
            v2.Jobs[Uid] = nil
            v2 = u9
            local Uid_2 = a1.Uid
            v2.Jobs[Uid_2] = nil
            u42[a1.Uid] = nil
            v2 = u6
            local v3 = u42[a1.Uid]
            if v3 ~= a1.Version then
                v3 = u41[a1.Uid]
                v1 = true
                if v3 ~= nil then
                    v1 = true
                    if v3.Record.Version == a1.Version then
                        v1 = v3.Record.State ~= a1.State
                    end
                end
            else
                v1 = false
            end
            if not v1 then
                return
            end
            u42[a1.Uid] = a1.Version
            local Uid_3 = a1.Uid
            if v2.Jobs[Uid_3] == nil then
                table.insert(v2.Order, Uid_3)
            end

            v2.Jobs[Uid_3] = function() -- Line: 377
                -- upvalues: EggState (upval), a1 (val), u42 (upval), WorkspaceEggVisibility (upval), States (upval)
                -- upvalues: renderDropped (upval), cleanupRendered (upval), renderSlot (upval)
                local v1 = EggState.ReadFieldEgg(a1.Uid)
                if v1 ~= nil and v1.Version == a1.Version then
                    u42[a1.Uid] = nil
                    WorkspaceEggVisibility.SetHidden(v1.Uid, false)
                    if v1.State == States.Dropped then
                        renderDropped(v1)
                        return
                    end
                    if v1.State ~= States.Slot then
                        cleanupRendered(v1.Uid)
                        return
                    end
                    renderSlot(v1)
                    return
                end
            end

            if not v2.Pumping then
                v2.Pumping = true
                task.defer(drainRenderQueue, v2)
            end
        end)
        EggState.CarryChanged:Connect(function(a1) -- Line: 471
            -- upvalues: u45 (ref), AreaEggSlotIdentity (upval), cleanupRendered (val), WorkspaceEggVisibility (upval)
            u45 = a1
            if a1.IsCarrying and a1.Uid ~= nil then
                if AreaEggSlotIdentity.LooksLikeFirstAreaUid(a1.Uid) then
                    cleanupRendered(a1.Uid)
                    WorkspaceEggVisibility.SetHidden(a1.Uid, false)
                    return
                end
                WorkspaceEggVisibility.SetHidden(a1.Uid, false)
            end
        end)
        EggState.FieldGone:Connect(function(a1) -- Line: 482
            -- upvalues: cleanupRendered (val), u45 (ref), WorkspaceEggVisibility (upval)
            cleanupRendered(a1)
            local v1 = u45
            local SetHidden = WorkspaceEggVisibility.SetHidden
            local IsCarrying = false
            if v1 ~= nil then
                IsCarrying = v1.IsCarrying and v1.Uid == a1
            end
            SetHidden(a1, not IsCarrying)
        end)
        WorkspaceEggVisibility.ModelAdded:Connect(function(a1) -- Line: 490
            -- upvalues: EggState (upval), States (upval), AreaEggSlotIdentity (upval), u6 (val), u42 (val), u41 (val)
            -- upvalues: WorkspaceEggVisibility (upval), renderDropped (val), cleanupRendered (val), renderSlot (val)
            -- upvalues: drainRenderQueue (upval)
            local u4 = EggState.ReadFieldEgg(a1.Name)
            if u4 ~= nil and u4.State == States.Dropped and not AreaEggSlotIdentity.LooksLikeFirstAreaUid(u4.Uid) then
                local v1
                local v2 = u6
                local v3 = u42[u4.Uid]
                if v3 ~= u4.Version then
                    v3 = u41[u4.Uid]
                    v1 = true
                    if v3 ~= nil then
                        v1 = true
                        if v3.Record.Version == u4.Version then
                            v1 = v3.Record.State ~= u4.State
                        end
                    end
                else
                    v1 = false
                end
                if not v1 then
                    return
                end
                u42[u4.Uid] = u4.Version
                local Uid = u4.Uid
                if v2.Jobs[Uid] == nil then
                    table.insert(v2.Order, Uid)
                end

                v2.Jobs[Uid] = function() -- Line: 377
                    -- upvalues: EggState (upval), u4 (val), u42 (upval), WorkspaceEggVisibility (upval), States (upval)
                    -- upvalues: renderDropped (upval), cleanupRendered (upval), renderSlot (upval)
                    local v1 = EggState.ReadFieldEgg(u4.Uid)
                    if v1 ~= nil and v1.Version == u4.Version then
                        u42[u4.Uid] = nil
                        WorkspaceEggVisibility.SetHidden(v1.Uid, false)
                        if v1.State == States.Dropped then
                            renderDropped(v1)
                            return
                        end
                        if v1.State ~= States.Slot then
                            cleanupRendered(v1.Uid)
                            return
                        end
                        renderSlot(v1)
                        return
                    end
                end

                if not v2.Pumping then
                    v2.Pumping = true
                    task.defer(drainRenderQueue, v2)
                end
            end
        end)
        task.spawn(function() -- Line: 500
            require(script.CarryRunBackEffects).Start()
        end)
        WorkspaceEggVisibility.Start()
        RareEggHighlight.Start()
        RunService.Heartbeat:Connect(function() -- Line: 504
            -- upvalues: u3 (val), Workspace (upval), u52 (ref), riderPromptReach (val), u41 (val), Player (upval)
            -- upvalues: LocalPlayer (upval), GuardAreaGeometry (upval), SeparationLine (val), isEggReachable (val)
            local Prompt, v1, v2, v3
            u3:Step((Workspace:GetServerTimeNow()))
            u52 = riderPromptReach()
            for k, v in pairs(u41) do
                if v.Prompt.MaxActivationDistance ~= u52 then
                    v.Prompt.MaxActivationDistance = u52
                end
                Prompt = v.Prompt
                v2 = Player.FindRootPart(LocalPlayer)
                v1 = false
                if v2 ~= nil then
                    v1 = GuardAreaGeometry.IsPastLine(SeparationLine, v2.Position)
                end
                if v1 then
                    v3 = Player.FindCharacter(LocalPlayer)
                    v2 = false
                    if v3 ~= nil then
                        v2 = v3:GetAttribute("IsTrapped") == true
                    end
                    v1 = not v2 and isEggReachable(v)
                end
                Prompt.Enabled = v1
            end
        end)
        applyInitialSnapshot((EggState.ReadFieldEggs()))
    end,
}