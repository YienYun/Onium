-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardComponent
-- Decompile time: 36.28 ms

local GuardMovement = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).GuardMovement
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local GuardDistance = require(script.Parent.GuardDistance)
local GuardEggRetrievalComponent = require(script.Parent.GuardEggRetrievalComponent)
local GuardReturnHomeDistanceResolver = require(script.Parent.GuardReturnHomeDistanceResolver)
local GuardMovementRecovery = require(script.Parent.GuardMovementRecovery)
local GuardPresentationComponent = require(script.Parent.GuardPresentationComponent)
require(ReplicatedStorage.Data.Guards)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local u92 = {}
u92.__index = u92
u92.__class = "GuardComponent"
u92.ATTACK_MIN_INTERVAL = GuardMovement.ATTACK_MIN_INTERVAL
;(require(ReplicatedStorage.Shared.Flags.BalanceConfig)).Changed:Connect(function() -- Line: 33 -- upvalues: u92 (val), GuardMovement (val)
    u92.ATTACK_MIN_INTERVAL = GuardMovement.ATTACK_MIN_INTERVAL
end)
local u107 = Log.new()

function u92.new(a1, a2, a3, a4, a5, a6, a7) -- Line: 103
    -- upvalues: u92 (val), t (val), WaitFor (val), Constants (val), CollisionGroups (val)
    -- upvalues: GuardEggRetrievalComponent (val), GuardMovementRecovery (val), GuardPresentationComponent (val)
    local v1 = setmetatable({}, u92)
    t.strict(t.string)(a1)
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    t.strict(t.instanceIsA("BasePart"))(a4)
    t.strict(t.table)(a5)
    t.strict(t.callback)(a6)
    t.strict(t.table)(a7)
    t.strict(t.callback)(a7.Attack)
    t.strict(t.boolean)(a7.ServerOwnsPhysics)
    t.strict(t.callback)(a7.Wake)
    local v2, v3 = WaitFor.Descendant(a2, "Humanoid", Constants.STUDIO_YIELD_TIMEOUT):await()
    local v4, v5 = WaitFor.Descendant(a2, "Animator", Constants.STUDIO_YIELD_TIMEOUT):await()
    local HumanoidRootPart = a2:WaitForChild("HumanoidRootPart", Constants.STUDIO_YIELD_TIMEOUT)
    local Collider = a2:WaitForChild("Collider", Constants.STUDIO_YIELD_TIMEOUT)
    local v6, v7 = WaitFor.Descendant(a2, "Head", Constants.STUDIO_YIELD_TIMEOUT):await()
    assert(v2, (("Failed to resolve Humanoid under %*: %*"):format(a2:GetFullName(), (tostring(v3)))))
    assert(v4, (("Failed to resolve Animator under %*: %*"):format(a2:GetFullName(), (tostring(v5)))))
    assert(HumanoidRootPart, (("Failed to resolve HumanoidRootPart under %*: %*"):format(a2:GetFullName(), (tostring(HumanoidRootPart)))))
    assert(Collider, (("Failed to resolve Collider under %*"):format((a2:GetFullName()))))
    assert(v6, (("Failed to resolve Head under %*: %*"):format(a2:GetFullName(), (tostring(v7)))))
    assert(v3:IsA("Humanoid"), (("%*.Humanoid must be a Humanoid"):format((a2:GetFullName()))))
    assert(v5:IsA("Animator"), (("%*.Animator must be an Animator"):format((a2:GetFullName()))))
    assert(HumanoidRootPart:IsA("BasePart"), (("%*.HumanoidRootPart must be a BasePart"):format((a2:GetFullName()))))
    assert(Collider:IsA("BasePart"), (("%*.Collider must be a BasePart"):format((a2:GetFullName()))))
    if Constants.IS_STUDIO and v5.Parent == v3 and not a2:FindFirstChild("Model") then
        error((("Animator has to be parented to the animation controller for %*"):format((a2:GetFullName()))))
    end
    local CurrentPhysicalProperties = Collider.CurrentPhysicalProperties
    Collider.CustomPhysicalProperties = PhysicalProperties.new(
        0.01,
        CurrentPhysicalProperties.Friction,
        CurrentPhysicalProperties.Elasticity,
        CurrentPhysicalProperties.FrictionWeight,
        CurrentPhysicalProperties.ElasticityWeight
    )
    local ServerOwnsPhysics = a7.ServerOwnsPhysics and a2:GetAttribute("Hidden") == true
    local v8, v9, v10, v11, v12, v13, v14 = a1, a7, a3, a5, a2, a4, a6
    for i, j in a2:GetDescendants() do
        if j:IsA("BasePart") then
            if not ServerOwnsPhysics then
                j.Anchored = false
            end
            j.CollisionGroup = CollisionGroups.GUARD_COLLISION_GROUP
        end
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "UprightAttachment"
    Attachment.Axis = Vector3.new(0, 1, 0)
    Attachment.SecondaryAxis = Vector3.new(1, 0, 0)
    v6 = Instance.new("AlignOrientation")
    v6.Mode = Enum.OrientationAlignmentMode.OneAttachment
    v6.AlignType = Enum.AlignType.PrimaryAxisParallel
    v6.PrimaryAxis = Vector3.new(0, 1, 0)
    v6.RigidityEnabled = true
    v6.Attachment0 = Attachment
    v6.Parent = Attachment
    Attachment.Parent = HumanoidRootPart
    v1._areaId = v8
    v1._attackHandler = v9.Attack
    v1._bodyRadius = math.max(Collider.Size.X, Collider.Size.Z) / 2
    v1._bounds = v10
    v1._config = v11
    v1._eggRetrieval = GuardEggRetrievalComponent.new(v12, HumanoidRootPart, HumanoidRootPart.CFrame)
    v1._enabled = true
    v1._currentMoveTo = nil
    v1._creatorPause = nil
    v1._guardModel = v12
    v1._homeCFrame = HumanoidRootPart.CFrame
    v1._humanoid = v3
    v1._lastAttackTime = 0
    v1._lastNetworkOwnerRetry = (-1 / 0)
    v1._lastTargetRefresh = 0
    v1._movementRecovery = GuardMovementRecovery.new(HumanoidRootPart, v13)
    v1._pinnedSince = nil
    v1._attackResumeTime = 0
    v1._ragdollEndTime = 0
    v1._presentation = GuardPresentationComponent.new(HumanoidRootPart, v5, v11)
    v1._root = HumanoidRootPart
    v1._serverOwnsPhysics = v9.ServerOwnsPhysics
    v1._sleepTurnConnection = nil
    v1._sleepTurnFromCFrame = nil
    v1._sleepTurnStartTime = 0
    v1._state = "Sleeping"
    v1._stolenEggUidByPlayer = {}
    v1._stolenPlayerByEggUid = {}
    v1._stolenPriorityByEggUid = {}
    v1._targetPlayer = nil
    v1._targetResolver = v14
    v1._uprightAttachment = Attachment
    v1._wakeHandler = v9.Wake
    v1._wakingStartedAt = 0
    v1._walkResumeTime = 0
    v12:SetAttribute("TargetPlayer", "")
    v12:SetAttribute("Sleeping", false)
    v12:SetAttribute("GuardState", "")
    v12:SetAttribute("AreaId", v8)
    v12:SetAttribute("WakeTargetPlayer", "")
    v3.WalkSpeed = v11.WalkSpeed
    v3:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    v1:_trySetNetworkOwner(os.clock(), true)
    v1:_enterSleepState()
    return v1
end

function u92:_setState(a2) -- Line: 276
    self._state = a2
    if a2 ~= "Chasing" then
        self._pinnedSince = nil
        self._presentation:CancelAfterWake()
    end
end

function u92:_isHitPaused(a2) -- Line: 285 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    return a2 < math.max(self._walkResumeTime, self._attackResumeTime)
end

function u92:_holdIfHitPaused(a2) -- Line: 291 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if not self:_isHitPaused(a2) then
        return false
    end
    self._humanoid.WalkSpeed = 0
    self:_stopMovement()
    self._presentation:StopWalkAnimation()
    self._presentation:EnsureIdleAnimation()
    self._presentation:StopFootstepSound()
    return true
end

function u92:_enterSleepState() -- Line: 307
    self:_setState("Sleeping")
    self._targetPlayer = nil
    self._currentMoveTo = nil
    self._movementRecovery:Reset()
    self:_cancelSleepTurn()
    self._wakingStartedAt = 0
    if not self._serverOwnsPhysics or self._guardModel:GetAttribute("Hidden") ~= true then
        self._root.Anchored = false
    end
    self._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    self._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    self._guardModel:PivotTo(self._homeCFrame * (self._root.CFrame:ToObjectSpace((self._guardModel:GetPivot()))))
    self._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    self._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    self._humanoid.WalkSpeed = 0
    self._humanoid:Move(Vector3.new(0, 0, 0), false)
    self._guardModel:SetAttribute("Sleeping", true)
    self._guardModel:SetAttribute("TargetPlayer", "")
    self._guardModel:SetAttribute("WakeTargetPlayer", "")
    self._guardModel:SetAttribute("GuardState", self._state)
    self._presentation:StopWalkAnimation()
    self._presentation:StopIdleAnimation()
    self._presentation:StopFootstepSound()
    self._presentation:PlaySleep(0.75)
end

function u92:_enterWakingState(a2) -- Line: 337 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if self._state == "Waking" then
        return
    end
    self:_cancelSleepTurn()
    self:_setTarget(nil)
    self:_setState("Waking")
    self._currentMoveTo = nil
    self._movementRecovery:Reset()
    self._wakingStartedAt = a2
    self._guardModel:SetAttribute("TargetPlayer", "")
    self._guardModel:SetAttribute("GuardState", self._state)
    self:_refreshWakeTarget()
end

function u92:_updateWaking(a2) -- Line: 355 -- upvalues: t (val), GuardChasePolicy (val) -- types: a2: number
    t.strict(t.number)(a2)
    if not self:HasStolenEggs() and not self._eggRetrieval:HasPending() then
        self:_enterSleepState()
        return
    end
    self:_refreshWakeTarget()
    if a2 - self._wakingStartedAt < GuardChasePolicy.GetWakingDuration() then
        return
    end
    if self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
        return
    end
    self:_enterChaseState(a2)
    self:_updateChase(a2)
end

function u92:_getChaseWalkSpeed(a2) -- Line: 378 -- upvalues: t (val), GuardChasePolicy (val) -- types: a2: number
    t.strict(t.number)(a2)
    return GuardChasePolicy.ResolveWalkSpeed(self._config.WalkSpeed, self._config.FlatRadius, a2)
end

function u92:_getReturnWalkSpeed() -- Line: 388 -- upvalues: GuardMovement (val)
    return self._config.WalkSpeed * GuardMovement.RETURN_WALK_SPEED_MULTIPLIER
end

function u92:_enterChaseState(a2) -- Line: 392 -- types: a2: number
    local v1 = self._state == "Waking"
    self:_cancelSleepTurn()
    if self._state ~= "Chasing" then
        self._wakingStartedAt = 0
        if not self._serverOwnsPhysics or self._guardModel:GetAttribute("Hidden") ~= true then
            self._root.Anchored = false
        end
        self:_trySetNetworkOwner(a2, true)
        self._humanoid.WalkSpeed = self._config.WalkSpeed
        self._guardModel:SetAttribute("Sleeping", false)
        self._guardModel:SetAttribute("GuardState", "Chasing")
        self._guardModel:SetAttribute("WakeTargetPlayer", "")
        self._presentation:StopSleep(0.4)
        self._wakeHandler(self._guardModel)
    end
    self:_setState("Chasing")
    if v1 then
        self._presentation:ScheduleAfterWake(a2)
    end
    if self._walkResumeTime < a2 then
        self._walkResumeTime = a2
    end
end

function u92:_enterEggRetrievalState(a2) -- Line: 428 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    local v1 = self._state == "Waking"
    self:_cancelSleepTurn()
    self:_setTarget(nil)
    self:_setState("RetrievingEgg")
    self._wakingStartedAt = 0
    if not self._serverOwnsPhysics or self._guardModel:GetAttribute("Hidden") ~= true then
        self._root.Anchored = false
    end
    self:_trySetNetworkOwner(a2, true)
    self._guardModel:SetAttribute("Sleeping", false)
    self._guardModel:SetAttribute("GuardState", self._state)
    self._guardModel:SetAttribute("WakeTargetPlayer", "")
    if v1 then
        self._presentation:StopSleep(0.4)
        self._wakeHandler(self._guardModel)
    end
end

function u92:_updateEggRetrieval(a2) -- Line: 453 -- upvalues: t (val), GuardChasePolicy (val) -- types: a2: number
    t.strict(t.number)(a2)
    if not self._eggRetrieval:HasPending() then
        if not self:HasStolenEggs() then
            self:_enterReturnHomeState(a2)
        else
            self:_enterChaseState(a2)
            self:_updateChase(a2)
        end
        return nil
    end
    local CurrentEggUid = self._eggRetrieval:GetCurrentEggUid()
    local v1 = self._eggRetrieval:TryTransition(self._config.EggPickupDistance or GuardChasePolicy.ResolveHitDistance(self._config.HitDistance))
    if v1 == nil then
        local MoveTarget_2 = self._eggRetrieval:GetMoveTarget()
        assert(MoveTarget_2 ~= nil, "Pending guard retrieval requires a movement target")
        if not self:_holdIfHitPaused(a2) then
            self._humanoid.WalkSpeed = self:_getReturnWalkSpeed()
            self:_ensureWalkAnimation(a2)
            self:_moveTo(MoveTarget_2)
        end
        return nil
    end
    assert(CurrentEggUid ~= nil, "Guard retrieval transition requires an egg UID")
    local v2 = {AreaId = self._areaId, EggUid = CurrentEggUid, Kind = v1}
    if v1 ~= "Deposited" then
        local MoveTarget = self._eggRetrieval:GetMoveTarget()
        assert(MoveTarget ~= nil, "Attached guard retrieval egg requires a home movement target")
        if not self:_holdIfHitPaused(a2) then
            self._humanoid.WalkSpeed = self:_getReturnWalkSpeed()
            self:_ensureWalkAnimation(a2)
            self:_moveTo(MoveTarget)
        end
        return v2
    end
    if self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
        return v2
    end
    if not self:HasStolenEggs() then
        self:_enterReturnHomeState(a2)
        return v2
    end
    self:_enterChaseState(a2)
    self:_updateChase(a2)
    return v2
end

function u92:_enterReturnHomeState(a2) -- Line: 522 -- types: a2: number
    if self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
        return
    end
    self:_setState("ReturningHome")
    self._guardModel:SetAttribute("GuardState", "ReturningHome")
    self:_setTarget(nil)
    self:_cancelSleepTurn()
    if not self._serverOwnsPhysics or self._guardModel:GetAttribute("Hidden") ~= true then
        self._root.Anchored = false
    end
    if not self:_isHitPaused(a2) then
        self._humanoid.WalkSpeed = self:_getReturnWalkSpeed()
        self:_moveTo(self._homeCFrame.Position)
        return
    end
    self._humanoid.WalkSpeed = 0
    self:_stopMovement()
    self._presentation:StopWalkAnimation()
    self._presentation:EnsureIdleAnimation()
    self._presentation:StopFootstepSound()
end

function u92:_isPinnedInReach(a2, a3) -- Line: 551
    -- upvalues: GuardChasePolicy (val), GuardMovement (val)
    local AssemblyLinearVelocity = self._root.AssemblyLinearVelocity
    local v1 = false
    if a3 <= (GuardChasePolicy.ResolveHitDistance(self._config.HitDistance)) + self._bodyRadius then
        v1 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude < self._humanoid.WalkSpeed * GuardMovement.PINNED_SPEED_RATIO
    end
    if not v1 then
        self._pinnedSince = nil
        return false
    end
    v1 = self._pinnedSince or a2
    self._pinnedSince = v1
    return GuardMovement.PINNED_HIT_DELAY <= a2 - v1
end

function u92:_updateChase(a2) -- Line: 569 -- upvalues: GuardDistance (val), GuardChasePolicy (val) -- types: a2: number
    local v1, v2, v3, v4
    if self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
        return
    end
    if not self:HasStolenEggs() then
        self:_enterReturnHomeState(a2)
        return
    end
    local _targetPlayer = self._targetPlayer
    local v5 = nil
    local v6 = nil
    local v7 = nil
    if _targetPlayer ~= nil and self._stolenEggUidByPlayer[_targetPlayer] ~= nil then
        v1, v2 = self:_resolvePlayerTarget(_targetPlayer)
        v5 = v1
        v6 = v2
        v7 = self._stolenEggUidByPlayer[_targetPlayer]
    end
    if v5 == nil or v6 == nil then
        v1, v2, v3, v4 = self:_chooseTargetPlayer()
        _targetPlayer = v1
        v5 = v2
        v6 = v3
        v7 = v4
        self._lastTargetRefresh = a2
    else
        v1 = a2 - self._lastTargetRefresh
        if v1 >= 0.3 then
            v1, v2, v3, v4 = self:_chooseTargetPlayer()
            _targetPlayer = v1
            v5 = v2
            v6 = v3
            v7 = v4
            self._lastTargetRefresh = a2
        end
    end
    if _targetPlayer ~= nil and v5 ~= nil and v6 ~= nil then
        self:_setTarget(_targetPlayer)
        v1 = GuardDistance.XZ(self._root.Position, v5.Position)
        if not (v1 <= GuardChasePolicy.ResolveHitDistance(self._config.HitDistance))
            and not self:_isPinnedInReach(a2, v1) then
            v1 = self:_getChaseWalkSpeed((GuardDistance.XZ(self._root.Position, v5.Position)))
            self._humanoid.WalkSpeed = v1
            self:_ensureWalkAnimation(a2)
            self:_moveThrough(v5.Position)
            return
        end
        self:_attemptAttack(_targetPlayer, v5, v6, v7, a2)
        return
    end
    self:_setTarget(nil)
    self:_enterReturnHomeState(a2)
end

function u92:_updateReturnHome(a2) -- Line: 623 -- upvalues: GuardReturnHomeDistanceResolver (val) -- types: a2: number
    if self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
        return
    end
    if self:HasStolenEggs() then
        self:_enterChaseState(a2)
        return
    end
    if self._sleepTurnConnection ~= nil or self:_updateSleepTurn(a2) then
        return
    end
    if (self._root.Position - self._homeCFrame.Position).Magnitude <= GuardReturnHomeDistanceResolver.Resolve(self._areaId) then
        self:_beginSleepTurn(a2)
        return
    end
    if not self:_isHitPaused(a2) then
        self._humanoid.WalkSpeed = self:_getReturnWalkSpeed()
        self:_ensureWalkAnimation(a2)
        self:_moveTo(self._homeCFrame.Position)
        return
    end
    self._humanoid.WalkSpeed = 0
    self:_stopMovement()
    self._presentation:StopWalkAnimation()
    self._presentation:EnsureIdleAnimation()
    self._presentation:StopFootstepSound()
end

function u92:_beginSleepTurn(a2) -- Line: 664 -- upvalues: t (val), RunService (val) -- types: a2: number
    t.strict(t.number)(a2)
    self._sleepTurnFromCFrame = self._root.CFrame
    self._sleepTurnStartTime = a2
    if self._sleepTurnConnection == nil then
        self._sleepTurnConnection = RunService.Heartbeat:Connect(function() -- Line: 671 -- upvalues: self (val)
            self:_updateSleepTurn((os.clock()))
        end)
    end
    self._humanoid.WalkSpeed = 0
    self:_stopMovement()
    self._presentation:StopWalkAnimation()
    self._presentation:EnsureIdleAnimation()
    self._presentation:StopFootstepSound()
    self:_updateSleepTurn(a2)
end

function u92:_cancelSleepTurn() -- Line: 684
    local _sleepTurnConnection = self._sleepTurnConnection
    if _sleepTurnConnection ~= nil then
        self._sleepTurnConnection = nil
        _sleepTurnConnection:Disconnect()
    end
    self._sleepTurnFromCFrame = nil
    self._sleepTurnStartTime = 0
end

function u92:_updateSleepTurn(a2) -- Line: 696 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    local _sleepTurnFromCFrame = self._sleepTurnFromCFrame
    if _sleepTurnFromCFrame == nil then
        return false
    end
    if not self:HasStolenEggs() and not self._eggRetrieval:HasPending() then
        local v1 = math.clamp((a2 - self._sleepTurnStartTime) / 0.3, 0, 1)
        local v2 = Vector3.new(self._homeCFrame.Position.X, self._root.Position.Y, self._homeCFrame.Position.Z)
        self._guardModel:PivotTo((((CFrame.new(v2)) * _sleepTurnFromCFrame.Rotation):Lerp((CFrame.new(v2)) * self._homeCFrame.Rotation, v1)) * (self._root.CFrame:ToObjectSpace((self._guardModel:GetPivot()))))
        if v1 >= 1 then
            self:_enterSleepState()
        end
        return true
    end
    self:_cancelSleepTurn()
    return false
end

function u92:_updateMovementRecovery(a2) -- Line: 729 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    local v1 = false
    if self._currentMoveTo ~= nil then
        if self._state == "Chasing" or self._state == "ReturningHome" then
            v1 = not self:_isHitPaused(a2)
        else
            v1 = false
            if self._state == "RetrievingEgg" then
                v1 = not self:_isHitPaused(a2)
            end
        end
    end
    local _movementRecovery = self._movementRecovery
    if _movementRecovery:Step(a2, v1, self._state == "ReturningHome") then
        return self:_recoverToHome()
    end
    return nil
end

function u92:_recoverToHome() -- Line: 745
    self:_stopMovement()
    if not self._eggRetrieval:HasPending() then
        self:_enterSleepState()
        return nil
    end
    self._guardModel:PivotTo(self._homeCFrame * (self._root.CFrame:ToObjectSpace((self._guardModel:GetPivot()))))
    self:_enterEggRetrievalState((os.clock()))
    return self:_updateEggRetrieval((os.clock()))
end

function u92:_chooseTargetPlayer() -- Line: 761 -- upvalues: Players (val)
    local Magnitude, v1, v2, v3
    local v4 = nil
    local v5 = nil
    local v6 = nil
    local v7 = nil
    local v8 = (-1 / 0)
    local v9 = (1 / 0)
    local v10 = self
    for k, v in pairs(self._stolenPlayerByEggUid) do
        if v ~= nil and table.find(Players:GetPlayers(), v) then
            v1, v2 = v10:_resolvePlayerTarget(v)
            if v1 ~= nil and v2 ~= nil then
                v3 = v10._stolenPriorityByEggUid[k] or 0
                Magnitude = (v10._root.Position - v1.Position).Magnitude
                if v8 < v3 or v3 == v8 and Magnitude < v9 then
                    v4 = v
                    v5 = v1
                    v6 = v2
                    v7 = k
                end
            end
        end
    end
    return v4, v5, v6, v7
end

function u92:_refreshWakeTarget() -- Line: 802
    local v1 = self:_chooseTargetPlayer()
    local v2 = if v1 == nil then "" else tostring(v1.UserId)
    if self._guardModel:GetAttribute("WakeTargetPlayer") == v2 then
        return
    end
    self._guardModel:SetAttribute("WakeTargetPlayer", v2)
end

function u92:_resolvePlayerTarget(a2) -- Line: 814 -- upvalues: Player (val) -- types: a2: userdata
    if not self._targetResolver(a2) or Player.FindCharacter(a2) == nil then
        return nil, nil
    end
    local v1 = Player.FindRootPart(a2)
    local v2 = Player.FindHumanoid(a2)
    if v1 ~= nil and v2 ~= nil then
        assert(v1:IsA("BasePart"), (("%* must be a BasePart"):format((v1:GetFullName()))))
        if v2.Health <= 0 then
            return nil, nil
        end
        return v1, v2
    end
    return nil, nil
end

function u92:_attemptAttack(a2, a3, a4, a5, a6) -- Line: 844
    -- upvalues: t (val), GuardMovement (val)
    t.strict(t.instanceIsA("Player"))(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    t.strict(t.instanceIsA("Humanoid"))(a4)
    t.strict(t.optional(t.string))(a5)
    t.strict(t.number)(a6)
    if a6 < self._attackResumeTime or a6 < self._ragdollEndTime then
        return
    end
    if a6 - self._lastAttackTime < GuardMovement.ATTACK_MIN_INTERVAL then
        return
    end
    self._lastAttackTime = a6
    self._currentMoveTo = nil
    self._movementRecovery:Reset()
    local v1 = self._presentation:PlayHit()
    local ATTACK_MIN_INTERVAL = GuardMovement.ATTACK_MIN_INTERVAL
    if v1 > 0 then
        ATTACK_MIN_INTERVAL = math.max(ATTACK_MIN_INTERVAL, v1)
    end
    self._walkResumeTime = a6 + ATTACK_MIN_INTERVAL
    self._attackResumeTime = math.max(self._attackResumeTime, a6 + ATTACK_MIN_INTERVAL)
    self._attackHandler({
        AreaId = self._areaId,
        Bounds = self._bounds,
        EggUid = a5,
        GuardHomePosition = self._homeCFrame.Position,
        GuardModel = self._guardModel,
        GuardRoot = self._root,
        GuardWalkSpeed = self._config.WalkSpeed,
        Player = a2,
        PlayerHumanoid = a4,
        PlayerRoot = a3,
    })
end

function u92:_moveTo(a2) -- Line: 897 -- upvalues: t (val) -- types: a2: vector
    t.strict(t.Vector3)(a2)
    local v1 = Vector3.new(a2.X, self._root.Position.Y, a2.Z)
    self._currentMoveTo = v1
    self._humanoid:MoveTo(v1)
end

function u92:_moveThrough(a2) -- Line: 906 -- upvalues: t (val) -- types: a2: vector
    t.strict(t.Vector3)(a2)
    self:_moveTo(a2 + (Vector3.new(a2.X - self._root.Position.X, 0, a2.Z - self._root.Position.Z)).Unit * 100)
end

function u92:_stopMovement() -- Line: 914
    self._currentMoveTo = nil
    self._movementRecovery:Reset()
    self._humanoid:MoveTo(self._root.Position)
    self._humanoid:Move(Vector3.new(0, 0, 0), false)
end

function u92:_setTarget(a2) -- Line: 921 -- types: a2: userdata?
    if self._targetPlayer == a2 then
        return
    end
    self._targetPlayer = a2
    if a2 == nil then
        self._guardModel:SetAttribute("TargetPlayer", "")
        return
    end
    self._guardModel:SetAttribute("TargetPlayer", (tostring(a2.UserId)))
    self._presentation:PlayWake()
end

function u92:_ensureWalkAnimation(a2) -- Line: 937 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if a2 < self._walkResumeTime then
        self._presentation:EnsureIdleAnimation()
        return
    end
    self._presentation:EnsureWalkAnimation(self._humanoid.WalkSpeed)
end

function u92:_trySetNetworkOwner(a2, a3) -- Line: 948 -- upvalues: t (val), u107 (val) -- types: a2: number, a3: boolean
    t.strict(t.number)(a2)
    t.strict(t.boolean)(a3)
    if self._serverOwnsPhysics and not self._root.Anchored then
        if not a3 and a2 - self._lastNetworkOwnerRetry < 5 then
            return
        end
        self._lastNetworkOwnerRetry = a2
        if not self._root:CanSetNetworkOwnership() then
            (u107:AtWarning()):Log((("Guard root network ownership cannot be set yet: %*"):format((self._root:GetFullName()))))
            return
        end
        self._root:SetNetworkOwner(nil)
        return
    end
end

function u92:Destroy() -- Line: 975
    self:_setCreatorPaused(false, (os.clock()))
    self._eggRetrieval:Destroy()
    self:_cancelSleepTurn()
    self:_stopMovement()
    self._presentation:Destroy()
    self._uprightAttachment:Destroy()
    table.clear(self._stolenEggUidByPlayer)
    table.clear(self._stolenPlayerByEggUid)
    table.clear(self._stolenPriorityByEggUid)
end

function u92.RegisterStolenEgg(a1, a2, a3, a4) -- Line: 987
    -- upvalues: t (val)
    t.strict(t.instanceIsA("Player"))(a2)
    t.strict(t.string)(a3)
    t.strict(t.number)(a4)
    local v1 = a1._stolenPlayerByEggUid[a3]
    if v1 == a2 then
        return false
    end
    if v1 ~= nil then
        error((("Stolen egg \"%*\" is already registered to %*"):format(a3, v1.Name)))
    end
    v1 = a1._stolenEggUidByPlayer[a2]
    if v1 ~= nil then
        a1._stolenPlayerByEggUid[v1] = nil
        a1._stolenPriorityByEggUid[v1] = nil
    end
    a1._stolenPlayerByEggUid[a3] = a2
    a1._stolenEggUidByPlayer[a2] = a3
    a1._stolenPriorityByEggUid[a3] = a4
    if not a1._enabled then
        return true
    end
    v1 = os.clock()
    if a1._eggRetrieval:HasPending() then
        if a1._state == "Sleeping" then
            a1:_enterWakingState(v1)
        end
        return true
    end
    if a1._state == "Sleeping" then
        a1:_enterWakingState(v1)
    elseif a1._state ~= "Waking" then
        a1:_enterChaseState(v1)
        a1:_updateChase(v1)
    else
        a1:_enterWakingState(v1)
    end
    return true
end

function u92.RegisterDroppedEgg(a1, a2) -- Line: 1042 -- upvalues: t (val)
    t.strict(t.table)(a2)
    if not a1._eggRetrieval:Register(a2) then
        return false
    end
    if not a1._enabled then
        return true
    end
    local v1 = os.clock()
    if a1._state == "Sleeping" then
        a1:_enterWakingState(v1)
    elseif a1._state ~= "Waking" then
        a1:_enterEggRetrievalState(v1)
    end
    return true
end

function u92.ClearDroppedEgg(a1, a2) -- Line: 1067 -- upvalues: t (val) -- types: a2: string
    t.strict(t.string)(a2)
    if not a1._eggRetrieval:Clear(a2) then
        return false
    end
    if a1._state == "RetrievingEgg" and not a1._eggRetrieval:HasPending() then
        local v1 = os.clock()
        if not a1:HasStolenEggs() then
            a1:_enterReturnHomeState(v1)
        else
            a1:_enterChaseState(v1)
            a1:_updateChase(v1)
        end
    end
    return true
end

function u92.IsDroppedEggAttached(a1, a2) -- Line: 1088 -- types: a2: string
    return a1._eggRetrieval:IsAttached(a2)
end

function u92.ClearStolenEgg(a1, a2) -- Line: 1092 -- upvalues: t (val) -- types: a2: string
    t.strict(t.string)(a2)
    local v1 = a1._stolenPlayerByEggUid[a2]
    if v1 == nil then
        return false
    end
    a1._stolenPlayerByEggUid[a2] = nil
    a1._stolenPriorityByEggUid[a2] = nil
    if a1._stolenEggUidByPlayer[v1] == a2 then
        a1._stolenEggUidByPlayer[v1] = nil
    end
    if a1._targetPlayer == v1 then
        a1:_setTarget(nil)
    end
    if not a1:HasStolenEggs() then
        if a1._eggRetrieval:HasPending() then
            return true
        end
        if a1._state == "Waking" then
            a1:_enterSleepState()
        elseif a1._state ~= "Sleeping" then
            a1:_enterReturnHomeState((os.clock()))
        else
            a1:_enterSleepState()
        end
    end
    return true
end

function u92.ClearPlayer(a1, a2) -- Line: 1125 -- upvalues: t (val) -- types: a2: userdata
    t.strict(t.instanceIsA("Player"))(a2)
    local v1 = a1._stolenEggUidByPlayer[a2]
    if v1 ~= nil then
        a1._stolenEggUidByPlayer[a2] = nil
        a1._stolenPlayerByEggUid[v1] = nil
        a1._stolenPriorityByEggUid[v1] = nil
    end
    if a1._targetPlayer == a2 then
        a1:_setTarget(nil)
    end
    if a1:HasStolenEggs() or a1._eggRetrieval:HasPending() then
        return
    end
    if a1._state ~= "Waking" and a1._state ~= "Sleeping" then
        a1:_enterReturnHomeState((os.clock()))
        return
    end
    a1:_enterSleepState()
end

function u92:HasStolenEggs() -- Line: 1151
    return next(self._stolenPlayerByEggUid) ~= nil
end

function u92.IsEnabled(a1) -- Line: 1155
    return a1._enabled
end

function u92.SetEnabled(a1, a2) -- Line: 1159 -- upvalues: t (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    if a1._enabled == a2 then
        return
    end
    a1._enabled = a2
    if not a2 then
        a1:_setCreatorPaused(false, (os.clock()))
        a1:_enterSleepState()
    end
end

function u92:_setCreatorPaused(a2, a3) -- Line: 1175 -- types: a2: boolean, a3: number
    local _creatorPause = self._creatorPause
    if a2 then
        if not _creatorPause then
            self._creatorPause = {
                StartedAt = a3,
                Anchored = self._root.Anchored,
                AutoRotate = self._humanoid.AutoRotate,
                WalkSpeed = self._humanoid.WalkSpeed,
                Tracks = {},
            }
            self:_cancelSleepTurn()
            self:_stopMovement()
            self._presentation:StopFootstepSound()
            self._guardModel:SetAttribute("CreatorPursuitPaused", true)
        end
        self._root.Anchored = true
        self._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        self._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        self._humanoid.AutoRotate = false
        self._humanoid.WalkSpeed = 0
        local Animator = self._guardModel:FindFirstChildWhichIsA("Animator", true)
        if not Animator then
            return
        end
        for k, n in Animator:GetPlayingAnimationTracks() do
            if _creatorPause.Tracks[n] == nil then
                _creatorPause.Tracks[n] = n.Speed
            end
            n:AdjustSpeed(0)
        end
        return
    end
    if _creatorPause then
        self._creatorPause = nil
        self._guardModel:SetAttribute("CreatorPursuitPaused", nil)
        local _root = self._root
        local Anchored = _creatorPause.Anchored or self._serverOwnsPhysics and self._guardModel:GetAttribute("Hidden") == true
        _root.Anchored = Anchored
        self._humanoid.AutoRotate = _creatorPause.AutoRotate
        self._humanoid.WalkSpeed = _creatorPause.WalkSpeed
        for i, j in _creatorPause.Tracks do
            i:AdjustSpeed(j)
        end
        local v1 = a3 - _creatorPause.StartedAt
        self._wakingStartedAt = self._wakingStartedAt + v1
        self._walkResumeTime = self._walkResumeTime + v1
        self._attackResumeTime = self._attackResumeTime + v1
        self._lastAttackTime = self._lastAttackTime + v1
        self._lastTargetRefresh = a3
        self._movementRecovery:Reset()
        self:_trySetNetworkOwner(a3, true)
    end
end

function u92:Step(a2) -- Line: 1234 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if not self._enabled then
        return nil
    end
    local _targetPlayer = self._targetPlayer
    if _targetPlayer == nil and self:HasStolenEggs() then
        _targetPlayer = self:_chooseTargetPlayer()
    end
    local v1 = false
    if _targetPlayer ~= nil then
        v1 = false
        if self._stolenEggUidByPlayer[_targetPlayer] ~= nil then
            v1 = false
            if self:_resolvePlayerTarget(_targetPlayer) ~= nil then
                v1 = true
                if _targetPlayer:GetAttribute("CreatorPauseGuard_all") ~= true then
                    v1 = _targetPlayer:GetAttribute("CreatorPauseGuard_" .. (string.gsub(self._areaId, "%W", ""))) == true
                end
            end
        end
    end
    self:_setCreatorPaused(v1, a2)
    if v1 then
        return nil
    end
    if self._movementRecovery:ShouldRecoverFromFall() then
        return self:_recoverToHome()
    end
    self:_trySetNetworkOwner(a2, false)
    if self._state ~= "Waking" and self._state ~= "RetrievingEgg" and self._eggRetrieval:HasPending() then
        self:_enterEggRetrievalState(a2)
    end
    v1 = nil
    if self._state ~= "Sleeping" then
        if self._state == "Waking" then
            self:_updateWaking(a2)
        elseif self._state == "Chasing" then
            self:_updateChase(a2)
        elseif self._state == "ReturningHome" then
            self:_updateReturnHome(a2)
        elseif self._state == "RetrievingEgg" then
            v1 = self:_updateEggRetrieval(a2)
        end
    elseif self:HasStolenEggs() then
        self:_enterWakingState(a2)
    end
    self._presentation:UpdateAfterWake(a2, self._state == "Chasing")
    if v1 ~= nil then
        return v1
    end
    return self:_updateMovementRecovery(a2)
end

return u92