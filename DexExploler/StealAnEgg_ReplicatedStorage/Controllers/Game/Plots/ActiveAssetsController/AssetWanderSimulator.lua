-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetWanderSimulator
-- Decompile time: 24.40 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Log = require(ReplicatedStorage.Packages.Log)
require(ReplicatedStorage.Data.Assets)
local t = require(ReplicatedStorage.Packages.t)
local u37 = require(script.Parent.AssetMutationWalkSpeed)
local AssetPersonalityMotion = require(script.Parent.AssetPersonalityMotion)
local AssetRetreatMotion = require(script.Parent.AssetRetreatMotion)
local AssetWanderArea = require(script.Parent.AssetWanderArea)
local AssetWanderMotion = require(script.Parent.AssetWanderMotion)
local u59 = Log.new()
local u60 = {}
u60.__index = u60
u60.__class = "AssetWanderSimulator"

function u60.new(a1, a2, a3, a4, a5, a6, a7) -- Line: 118
    -- upvalues: t (val), AssetItem (val), Players (val), Personalities (val), u60 (val), AssetPersonalityMotion (val)
    -- upvalues: u59 (val)
    t.strict(t.number)(a1)
    t.strict(t.instanceIsA("Player"))(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    assert(AssetItem.AssetItemData(a4), "Invalid asset item data")
    t.strict(t.boolean)(a5)
    t.strict(t.number)(a6)
    t.strict(t.number)(a7)
    local v1 = Random.new(a1)
    local LocalPlayer = Players.LocalPlayer
    assert(LocalPlayer ~= nil, "Asset wander simulator requires a local player")
    local v2 = Personalities.GetConfig(a4.Personality)
    local v3 = setmetatable({}, u60)
    v3._random = v1
    v3._owner = a2
    v3._localPlayer = LocalPlayer
    v3._assetArea = a3
    v3._itemData = a4
    v3._config = v2
    v3._greetingOrbitRadius = math.max(a6, 2.5)
    v3._jumpHeight = math.min(math.max(a7, 1) * 2, 20)
    v3._destination = a3.Position
    v3._idleRemaining = 0
    v3._idleAnchorCFrame = nil
    v3._idleElapsed = 0
    v3._walkSpeed = v3:_rollWalkSpeed()
    v3._mode = "Destination"
    v3._phase = "Normal"
    v3._greetRemaining = 0
    v3._randomOrbitInsideSeconds = 0
    v3._farSeconds = 0
    v3._farRequiredSeconds = v1:NextNumber(105, 180)
    v3._joinGreetingPending = true
    v3._finishJumpsRemaining = 0
    v3._finishJumpCooldown = 0
    v3._returnGreetingHoldRemaining = 0
    v3._returnGreetingJumpsRemaining = 0
    v3._returnGreetingJumpCooldown = 0
    v3._returnGreetingOwnerOffset = nil
    v3._affectionInsideSeconds = 0
    v3._affectionHoldRemaining = 0
    v3._affectionJumpsRemaining = 0
    v3._affectionJumpCooldown = 0
    v3._affectionOwnerOffset = nil
    v3._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(a3, v1, v3._greetingOrbitRadius)
    v3._pendingBubbleText = nil
    v3._jumpRemaining = 0
    v3._jumpElapsed = 0
    v3._spinYaw = 0
    v3._spinAppliedYaw = 0
    v3._curveAngle = v1:NextNumber(-3.141592653589793, 3.141592653589793)
    v3._curveRotationSpeed = v1:NextNumber(-0.8, 0.8)
    v3._nextCurveChangeSeconds = v1:NextNumber(5, 10)
    v3._curveChangeElapsed = 0
    v3._retreatOwnerWasClose = false
    v3._retreatActive = false
    v3._lastOwnerPosition = nil
    v3:_chooseNextDestination()
    if a5 then
        v3:_tryStartFirstPlacementGreeting()
    end
    ;(u59:AtDebug()):Log((("Created asset wander simulator with seed %*"):format(a1)))
    return v3
end

function u60:_rollWalkSpeed() -- Line: 203 -- upvalues: u37 (val)
    local Movement = self._config.Movement
    return (math.max(self._random:NextNumber(Movement.WalkSpeedMin, Movement.WalkSpeedMax), 4.5)) * u37.GetMultiplier(self._itemData)
end

function u60:_ownerRootPosition() -- Line: 210 -- upvalues: AssetPersonalityMotion (val)
    return AssetPersonalityMotion.OwnerRootPosition(self._owner)
end

function u60:_distanceFromLocalPlayerToAreaCenter() -- Line: 214 -- upvalues: AssetPersonalityMotion (val)
    return AssetPersonalityMotion.DistanceFromPlayerToAreaCenter(self._localPlayer, self._assetArea)
end

function u60:_chooseNextDestination() -- Line: 220 -- upvalues: AssetPersonalityMotion (val)
    local v1 = self:_ownerRootPosition()
    local Movement = self._config.Movement
    self._walkSpeed = self:_rollWalkSpeed()
    self._destination = AssetPersonalityMotion.ChooseDestination(self._assetArea, self._random, Movement, v1)
    self._mode = if not (self._random:NextNumber() < Movement.CurvedWanderChance) then "Destination" else "Curve"
end

function u60:_tryRetreatFromOwner(a2, a3) -- Line: 231
    -- upvalues: AssetRetreatMotion (val), AssetPersonalityMotion (val)
    local Retreat = self._config.Movement.Retreat
    if Retreat == nil or not (Vector3.new(a2.X - a3.X, 0, a2.Z - a3.Z).Magnitude <= Retreat.TriggerDistance) then
        self._retreatOwnerWasClose = false
        self._retreatActive = false
        return false
    end
    if self._retreatActive then
        self._destination = AssetRetreatMotion.Destination(self._assetArea, self._random, Retreat, a3, a2)
        self._mode = "Destination"
        self._idleRemaining = 0
        self._idleAnchorCFrame = nil
        return true
    end
    if self._retreatOwnerWasClose then
        return false
    end
    self._retreatOwnerWasClose = true
    if not AssetPersonalityMotion.RollChance(self._random, Retreat.Chance) then
        return false
    end
    self._retreatActive = true
    self._destination = AssetRetreatMotion.Destination(self._assetArea, self._random, Retreat, a3, a2)
    self._mode = "Destination"
    self._idleRemaining = 0
    self._idleAnchorCFrame = nil
    self._walkSpeed = self:_rollWalkSpeed()
    return true
end

function u60:_beginIdle(a2) -- Line: 289 -- types: a2: userdata
    local Movement = self._config.Movement
    self._idleRemaining = self._random:NextNumber(Movement.IdleSecondsMin, Movement.IdleSecondsMax)
    self._idleAnchorCFrame = a2
    self._idleElapsed = 0
end

function u60:_stepIdle(a2) -- Line: 296 -- upvalues: AssetPersonalityMotion (val) -- types: a2: number
    local _idleAnchorCFrame = self._idleAnchorCFrame
    assert(_idleAnchorCFrame ~= nil, "Idle phase requires a stable anchor CFrame")
    local v1, v2, v3, v4 = AssetPersonalityMotion.StepIdle(a2, self._idleRemaining, self._idleElapsed, _idleAnchorCFrame, self._config.Movement.IdleTremble)
    self._idleRemaining = v2
    self._idleElapsed = v3
    if v4 then
        self._idleAnchorCFrame = nil
        self._idleElapsed = 0
    end
    return self:_applyJump(a2, v1)
end

function u60:_tryAmbientJump(a2) -- Line: 316 -- upvalues: AssetPersonalityMotion (val) -- types: a2: number
    local Movement = self._config.Movement
    local ShouldStartAmbientJump = AssetPersonalityMotion.ShouldStartAmbientJump
    local _random = self._random
    local AmbientJumpRatePerSecond = Movement.AmbientJumpRatePerSecond
    if ShouldStartAmbientJump(_random, AmbientJumpRatePerSecond, a2, 0 < self._jumpRemaining) then
        self:_startJump(Movement.AmbientSpinJumpChance)
    end
end

function u60:_startJump(a2) -- Line: 330 -- types: a2: number?
    if 0 < self._jumpRemaining then
        return
    end
    local SpinJumpChance = if a2 == nil then self._config.Greeting.SpinJumpChance else a2
    self._jumpRemaining = 0.45
    self._jumpElapsed = 0
    self._spinAppliedYaw = 0
    local v1 = if not ((self._random:NextNumber()) < 0.5) then 1 else -1
    self._spinYaw = if not (self._random:NextNumber() < SpinJumpChance) then 0 else 6.283185307179586 * v1
end

function u60:_resetGreetingFinish() -- Line: 347
    self._finishJumpsRemaining = 0
    self._finishJumpCooldown = 0
end

function u60:_resetReturnGreeting() -- Line: 352
    self._returnGreetingHoldRemaining = 0
    self._returnGreetingJumpsRemaining = 0
    self._returnGreetingJumpCooldown = 0
    self._returnGreetingOwnerOffset = nil
end

function u60:_resetAffection() -- Line: 359
    self._affectionHoldRemaining = 0
    self._affectionJumpsRemaining = 0
    self._affectionJumpCooldown = 0
    self._affectionOwnerOffset = nil
    self._pendingBubbleText = nil
end

function u60:_popBubbleText() -- Line: 367
    local _pendingBubbleText = self._pendingBubbleText
    self._pendingBubbleText = nil
    return _pendingBubbleText
end

function u60:_beginGreetingFinish() -- Line: 374
    self._phase = "GreetingFinish"
    self._greetRemaining = 1.2
    self._finishJumpsRemaining = 2
    self._finishJumpCooldown = 0
    self._lastOwnerPosition = nil
end

function u60:_beginGreetingOrbit(a2) -- Line: 382
    -- upvalues: t (val), AssetPersonalityMotion (val)
    t.strict(t.boolean)(a2)
    local Greeting = self._config.Greeting
    self._phase = "GreetingOrbit"
    self._greetRemaining = math.min(Greeting.DurationSeconds, 3)
    self._randomOrbitInsideSeconds = 0
    self._idleRemaining = 0
    self._lastOwnerPosition = nil
    self:_resetGreetingFinish()
    self:_resetReturnGreeting()
    self:_resetAffection()
    if a2 then
        self._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(self._random, Greeting.Texts, self._config._id, "greeting")
    end
end

function u60:_tryStartGreetingOrbit(a2, a3) -- Line: 407
    -- upvalues: t (val), AssetPersonalityMotion (val)
    t.strict(t.boolean)(a3)
    local Greeting = self._config.Greeting
    if not (a2 <= 0) and not (Greeting.DurationSeconds <= 0) then
        if not AssetPersonalityMotion.RollChance(self._random, a2) then
            return false
        end
        self:_beginGreetingOrbit(a3)
        return true
    end
    return false
end

function u60:_beginNormalGreeting(a2, a3, a4, a5) -- Line: 424
    -- upvalues: t (val), AssetPersonalityMotion (val), AssetWanderArea (val)
    t.strict(t.boolean)(a5)
    local v1 = AssetPersonalityMotion.RandomOwnerOffset(self._assetArea, self._random, self._greetingOrbitRadius)
    self._phase = "ReturnGreetingApproach"
    self._returnGreetingOwnerOffset = v1
    self._returnGreetingHoldRemaining = math.min(a4, 20)
    self._returnGreetingJumpsRemaining = a3
    self._returnGreetingJumpCooldown = 0
    self._destination = AssetWanderArea.PointNearOwner(self._assetArea, a2, v1)
    self._idleRemaining = 0
    self._walkSpeed = self:_rollWalkSpeed()
    self._lastOwnerPosition = nil
    self:_resetGreetingFinish()
    self:_resetAffection()
    if a5 then
        self._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(self._random, self._config.Greeting.Texts, self._config._id, "greeting")
    end
end

function u60:_tryStartFirstPlacementGreeting() -- Line: 460 -- upvalues: AssetPersonalityMotion (val)
    self._joinGreetingPending = false
    local Greeting = self._config.Greeting
    if self:_tryStartGreetingOrbit(Greeting.FirstPlacementChance, true) then
        return
    end
    local FirstPlacementBubbleChance = Greeting.FirstPlacementBubbleChance
    if FirstPlacementBubbleChance ~= nil
        and FirstPlacementBubbleChance > 0
        and AssetPersonalityMotion.RollChance(self._random, FirstPlacementBubbleChance) then
        self._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(self._random, Greeting.Texts, self._config._id, "greeting")
        return
    end
    local v1 = self:_ownerRootPosition()
    if v1 ~= nil and AssetPersonalityMotion.RollChance(self._random, Greeting.FirstPlacementNormalChance) then
        local FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount
        if FirstPlacementNormalJumpCount <= 0 then
            return
        end
        self:_beginNormalGreeting(v1, FirstPlacementNormalJumpCount, 0.6 * FirstPlacementNormalJumpCount, true)
        return
    end
end

function u60:_tryStartReturnGreeting(a2, a3) -- Line: 501
    -- upvalues: t (val), AssetPersonalityMotion (val)
    t.strict(t.boolean)(a3)
    local Greeting = self._config.Greeting
    if not (Greeting.Chance <= 0) and not (Greeting.DurationSeconds <= 0) then
        if not AssetPersonalityMotion.RollChance(self._random, Greeting.Chance) then
            return
        end
        if a3 and self:_tryStartGreetingOrbit(Greeting.ReturnOrbitChance, false) then
            return
        end
        self:_beginNormalGreeting(a2, Greeting.ReturnNormalJumpCount, math.min(Greeting.DurationSeconds, 20), false)
        return
    end
end

function u60:_beginAffection(a2) -- Line: 526
    -- upvalues: AssetPersonalityMotion (val), AssetWanderArea (val)
    local Affection = self._config.Affection
    local v1 = AssetPersonalityMotion.RandomOwnerOffset(self._assetArea, self._random, self._greetingOrbitRadius)
    self._phase = "AffectionApproach"
    self._affectionOwnerOffset = v1
    self._destination = AssetWanderArea.PointNearOwner(self._assetArea, a2, v1)
    self._idleRemaining = 0
    self._walkSpeed = self:_rollWalkSpeed()
    self._affectionHoldRemaining = Affection.DurationSeconds
    self._affectionJumpsRemaining = Affection.JumpCount
    self._affectionJumpCooldown = 0
    self._pendingBubbleText = nil
    self._lastOwnerPosition = nil
    self:_resetGreetingFinish()
end

function u60:_updateAffectionTrigger(a2, a3) -- Line: 550
    -- upvalues: AssetWanderArea (val), AssetPersonalityMotion (val)
    if self._phase ~= "Normal" then
        return
    end
    local Affection = self._config.Affection
    if Affection.Enabled and not (Affection.IntervalSeconds <= 0) and a3 ~= nil then
        if not AssetWanderArea.IsPositionInside(self._assetArea, a3) then
            self._affectionInsideSeconds = 0
            return
        end
        self._affectionInsideSeconds = self._affectionInsideSeconds + a2
        if self._affectionInsideSeconds < Affection.IntervalSeconds then
            return
        end
        self._affectionInsideSeconds = 0
        if AssetPersonalityMotion.RollChance(self._random, Affection.Chance) then
            self:_beginAffection(a3)
        end
        return
    end
    self._affectionInsideSeconds = 0
end

function u60:_updateOrbitGreetingTrigger(a2, a3) -- Line: 581
    -- upvalues: AssetWanderArea (val)
    if self._phase ~= "Normal" then
        return
    end
    local Greeting = self._config.Greeting
    if not (Greeting.RandomOrbitChance <= 0)
        and not (Greeting.RandomOrbitIntervalSeconds <= 0)
        and not (Greeting.DurationSeconds <= 0)
        and a3 ~= nil then
        if not AssetWanderArea.IsPositionInside(self._assetArea, a3) then
            self._randomOrbitInsideSeconds = 0
            return
        end
        self._randomOrbitInsideSeconds = self._randomOrbitInsideSeconds + a2
        if self._randomOrbitInsideSeconds < Greeting.RandomOrbitIntervalSeconds then
            return
        end
        self._randomOrbitInsideSeconds = 0
        self:_tryStartGreetingOrbit(Greeting.RandomOrbitChance, false)
        return
    end
    self._randomOrbitInsideSeconds = 0
end

function u60:_updateReturnGreeting(a2) -- Line: 615 -- upvalues: AssetWanderArea (val) -- types: a2: number
    local v1
    if self._phase ~= "Normal" then
        return
    end
    if self._joinGreetingPending then
        v1 = self:_ownerRootPosition()
        if v1 == nil then
            return
        end
        self._joinGreetingPending = false
        self._farSeconds = 0
        self._farRequiredSeconds = self._random:NextNumber(105, 180)
        self:_tryStartReturnGreeting(v1, (AssetWanderArea.IsPositionInside(self._assetArea, v1)))
        return
    end
    v1 = self:_distanceFromLocalPlayerToAreaCenter()
    if v1 == nil then
        return
    end
    if v1 >= 200 then
        self._farSeconds = self._farSeconds + a2
        return
    end
    if self._farRequiredSeconds <= self._farSeconds and v1 <= 200 then
        self._farSeconds = 0
        self._farRequiredSeconds = self._random:NextNumber(105, 180)
        local v2 = self:_ownerRootPosition()
        if v2 ~= nil and AssetWanderArea.IsPositionInside(self._assetArea, v2) then
            self:_tryStartReturnGreeting(v2, true)
            return
        end
        return
    end
    self._farSeconds = 0
end

function u60:_updateGreeting(a2) -- Line: 659 -- types: a2: number
    if self._phase ~= "GreetingOrbit" and self._phase ~= "GreetingFinish" then
        return
    end
    local v1 = self:_distanceFromLocalPlayerToAreaCenter()
    if v1 ~= nil and v1 > 300 then
        self._phase = "Normal"
        self._greetRemaining = 0
        self:_resetGreetingFinish()
        self:_resetReturnGreeting()
        self:_resetAffection()
        self:_chooseNextDestination()
        return
    end
    self._greetRemaining = math.max(self._greetRemaining - a2, 0)
    if self._phase == "GreetingOrbit" then
        if self._greetRemaining <= 0 then
            self:_beginGreetingFinish()
            return
        end
        if (self._random:NextNumber()) < self._config.Greeting.JumpChancePerSecond * a2 then
            self:_startJump()
        end
        return
    end
    self._finishJumpCooldown = math.max(self._finishJumpCooldown - a2, 0)
    if 0 < self._finishJumpsRemaining and self._finishJumpCooldown <= 0 then
        self:_startJump(0)
        self._finishJumpsRemaining = self._finishJumpsRemaining - 1
        self._finishJumpCooldown = 0.6
    end
    if self._finishJumpsRemaining <= 0 and self._jumpRemaining <= 0 and self._greetRemaining <= 0 then
        self._phase = "Normal"
        self:_resetGreetingFinish()
        self:_resetReturnGreeting()
        self:_resetAffection()
        self:_chooseNextDestination()
    end
end

function u60:_stepReturnGreeting(a2, a3, a4) -- Line: 703
    -- upvalues: AssetWanderArea (val), AssetWanderMotion (val)
    local v1, v2, v3, v4
    if self._phase ~= "ReturnGreetingApproach" then
        self._returnGreetingHoldRemaining = math.max(self._returnGreetingHoldRemaining - a2, 0)
        self._returnGreetingJumpCooldown = math.max(self._returnGreetingJumpCooldown - a2, 0)
        if 0 < self._returnGreetingJumpsRemaining and self._returnGreetingJumpCooldown <= 0 then
            self:_startJump(0)
            self._returnGreetingJumpsRemaining = self._returnGreetingJumpsRemaining - 1
            self._returnGreetingJumpCooldown = 0.6
        end
        v1, v2 = self:_applyJump(a2, (AssetWanderMotion.FaceOwnerCFrame(a3, a4, a2)))
        if self._returnGreetingHoldRemaining <= 0
            and self._returnGreetingJumpsRemaining <= 0
            and self._jumpRemaining <= 0 then
            self._phase = "Normal"
            self:_resetReturnGreeting()
            self:_chooseNextDestination()
        end
        return v1, 0 < self._jumpRemaining, v2, self._walkSpeed
    end
    local _returnGreetingOwnerOffset = self._returnGreetingOwnerOffset
    assert(_returnGreetingOwnerOffset ~= nil, "Return greeting approach requires a stable owner offset")
    self._destination = AssetWanderArea.PointNearOwner(self._assetArea, a4, _returnGreetingOwnerOffset)
    v1, v2, v3 = AssetWanderMotion.StepMoveToward(a2, a3, self._destination, self._walkSpeed)
    local v5 = self._destination.X - v1.Position.X
    if 2.25 < Vector3.new(v5, 0, self._destination.Z - v1.Position.Z).Magnitude then
        v4, v5 = self:_applyJump(a2, v1)
        return v4, v2 or 0 < self._jumpRemaining, v5, v3
    end
    self._phase = "ReturnGreetingHold"
    self._returnGreetingJumpCooldown = 0
    if 0 < self._returnGreetingJumpsRemaining then
        self:_startJump(0)
        self._returnGreetingJumpsRemaining = self._returnGreetingJumpsRemaining - 1
        self._returnGreetingJumpCooldown = 0.6
    end
    v4, v5 = self:_applyJump(a2, (AssetWanderMotion.FaceOwnerCFrame(v1, a4, a2, true)))
    return v4, v2 or 0 < self._jumpRemaining, v5, v3
end

function u60:_stepAffection(a2, a3, a4) -- Line: 763
    -- upvalues: AssetWanderArea (val), AssetWanderMotion (val), AssetPersonalityMotion (val)
    local v1, v2, v3, v4
    if self._phase ~= "AffectionApproach" then
        self._affectionHoldRemaining = math.max(self._affectionHoldRemaining - a2, 0)
        self._affectionJumpCooldown = math.max(self._affectionJumpCooldown - a2, 0)
        if 0 < self._affectionJumpsRemaining and self._affectionJumpCooldown <= 0 then
            self:_startJump(0)
            self._affectionJumpsRemaining = self._affectionJumpsRemaining - 1
            self._affectionJumpCooldown = 0.6
        end
        v1, v2 = self:_applyJump(a2, (AssetWanderMotion.FaceOwnerCFrame(a3, a4, a2)))
        if self._affectionHoldRemaining <= 0 and self._affectionJumpsRemaining <= 0 and self._jumpRemaining <= 0 then
            self._phase = "Normal"
            self:_resetAffection()
            self:_chooseNextDestination()
        end
        return v1, 0 < self._jumpRemaining, v2, self._walkSpeed
    end
    local _affectionOwnerOffset = self._affectionOwnerOffset
    assert(_affectionOwnerOffset ~= nil, "Affection approach requires a stable owner offset")
    self._destination = AssetWanderArea.PointNearOwner(self._assetArea, a4, _affectionOwnerOffset)
    v1, v2, v3 = AssetWanderMotion.StepMoveToward(a2, a3, self._destination, self._walkSpeed)
    local v5 = self._destination.X - v1.Position.X
    if 2.25 < Vector3.new(v5, 0, self._destination.Z - v1.Position.Z).Magnitude then
        v4, v5 = self:_applyJump(a2, v1)
        return v4, v2 or 0 < self._jumpRemaining, v5, v3
    end
    self._phase = "AffectionHold"
    self._affectionJumpCooldown = 0.6
    self._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(self._random, self._config.Affection.Texts, self._config._id, "affection")
    if 0 < self._affectionJumpsRemaining then
        self:_startJump(0)
        self._affectionJumpsRemaining = self._affectionJumpsRemaining - 1
    end
    v4, v5 = self:_applyJump(a2, (AssetWanderMotion.FaceOwnerCFrame(v1, a4, a2, true)))
    return v4, v2 or 0 < self._jumpRemaining, v5, v3
end

function u60:_updateCurve(a2, a3) -- Line: 826 -- upvalues: AssetWanderArea (val) -- types: a2: number, a3: vector
    self._curveChangeElapsed = self._curveChangeElapsed + a2
    if self._nextCurveChangeSeconds <= self._curveChangeElapsed then
        self._curveChangeElapsed = 0
        self._nextCurveChangeSeconds = self._random:NextNumber(5, 10)
        self._curveAngle = self._random:NextNumber(-3.141592653589793, 3.141592653589793)
        self._curveRotationSpeed = self._random:NextNumber(-0.8, 0.8)
    end
    self._curveAngle = self._curveAngle + self._curveRotationSpeed * a2
    self._destination = AssetWanderArea.ClampedPointToward(self._assetArea, a3 + Vector3.new(math.cos(self._curveAngle), 0, (math.sin(self._curveAngle))) * 9)
end

function u60:_orbitGreetingCFrame(a2, a3, a4) -- Line: 846
    -- upvalues: AssetWanderMotion (val)
    local v1, v2 = AssetWanderMotion.OwnerMoveVector(a2, a4, self._lastOwnerPosition)
    self._lastOwnerPosition = v2
    return AssetWanderMotion.OrbitGreetingCFrame(self._assetArea, a2, a3, a4, v1, self._greetingOrbitRadius, 22, 0.75)
end

function u60:_applyJump(a2, a3) -- Line: 867 -- types: a2: number, a3: userdata
    local v1
    if self._jumpRemaining <= 0 then
        return a3, true
    end
    self._jumpRemaining = math.max(self._jumpRemaining - a2, 0)
    self._jumpElapsed = math.min(self._jumpElapsed + a2, 0.45)
    local v2 = self._jumpElapsed / 0.45
    local v3 = (math.sin(v2 * 3.141592653589793)) * self._jumpHeight
    v2 = (if self._spinYaw == 0 then 0 else self._spinYaw * v2) - self._spinAppliedYaw
    self._spinAppliedYaw = v1
    v1 = (CFrame.new(a3.Position + Vector3.new(0, v3, 0))) * a3.Rotation
    if v2 ~= 0 then
        v1 = v1 * CFrame.Angles(0, v2, 0)
    end
    if self._jumpRemaining <= 0 then
        self._spinAppliedYaw = 0
    end
    return v1, self._jumpRemaining <= 0
end

function u60.SetAssetArea(a1, a2) -- Line: 898 -- upvalues: t (val), AssetPersonalityMotion (val) -- types: a2: userdata
    t.strict(t.instanceIsA("BasePart"))(a2)
    local v1 = a1._assetArea ~= a2
    a1._assetArea = a2
    if v1 then
        a1._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(a2, a1._random, a1._greetingOrbitRadius)
        a1._returnGreetingOwnerOffset = if a1._returnGreetingOwnerOffset == nil then nil else AssetPersonalityMotion.RandomOwnerOffset(a2, a1._random, a1._greetingOrbitRadius)
        a1._affectionOwnerOffset = if a1._affectionOwnerOffset == nil then nil else AssetPersonalityMotion.RandomOwnerOffset(a2, a1._random, a1._greetingOrbitRadius)
    end
    a1:_chooseNextDestination()
end

function u60.SetItemData(a1, a2, a3) -- Line: 927
    -- upvalues: AssetItem (val), t (val), Personalities (val)
    assert(AssetItem.AssetItemData(a2), "Invalid asset item data")
    t.strict(t.boolean)(a3)
    a1._itemData = a2
    a1._config = Personalities.GetConfig(a2.Personality)
    if a3 then
        a1:_tryStartFirstPlacementGreeting()
    end
end

function u60.Step(a1, a2, a3) -- Line: 942
    -- upvalues: t (val), AssetWanderMotion (val), AssetWanderArea (val), u37 (val)
    local _destination, _walkSpeed_3, v1, v2, v3, v4, v5, v6
    t.strict(t.number)(a2)
    t.strict(t.CFrame)(a3)
    a1:_updateReturnGreeting(a2)
    a1:_updateGreeting(a2)
    local Position = a3.Position
    local v7 = a1:_ownerRootPosition()
    if a1._phase ~= "Normal" and v7 == nil then
        a1._phase = "Normal"
        a1._greetRemaining = 0
        a1:_resetGreetingFinish()
        a1:_resetReturnGreeting()
        a1:_resetAffection()
        a1:_chooseNextDestination()
    end
    a1:_updateAffectionTrigger(a2, v7)
    a1:_updateOrbitGreetingTrigger(a2, v7)
    local v8 = false
    if a1._phase == "Normal" and v7 ~= nil then
        v8 = a1:_tryRetreatFromOwner(Position, v7)
    end
    if a1._phase == "Normal" then
        a1:_tryAmbientJump(a2)
    end
    if 0 < a1._idleRemaining and a1._phase == "Normal" then
        v3, v4 = a1:_stepIdle(a2)
        return v3, 0 < a1._jumpRemaining, v4, 0, false, a1:_popBubbleText()
    end
    if a1._phase == "GreetingOrbit" and v7 ~= nil then
        v3, v4, v5 = a1:_orbitGreetingCFrame(a2, a3, v7)
        v6, v1 = a1:_applyJump(a2, v3)
        return v6, v4 or 0 < a1._jumpRemaining, v1, v5, true, a1:_popBubbleText()
    end
    if a1._phase == "GreetingFinish" and v7 ~= nil then
        v4, v5 = a1:_applyJump(a2, (AssetWanderMotion.FaceOwnerCFrame(a3, v7, a2)))
        return v4, 0 < a1._jumpRemaining, v5, a1._walkSpeed, true, a1:_popBubbleText()
    end
    if a1._phase ~= "ReturnGreetingApproach" and a1._phase ~= "ReturnGreetingHold" then
        if a1._phase ~= "AffectionApproach" and a1._phase ~= "AffectionHold" then
            if a1._config.Movement.FollowOwnerInPen
                and v7 ~= nil
                and AssetWanderArea.IsPositionInside(a1._assetArea, v7) then
                v3, v4, v5 = AssetWanderMotion.StepFollowOwner(a1._assetArea, a2, a3, v7, a1._loyalOwnerOffset, a1._walkSpeed, 2.25)
                v6, v1 = a1:_applyJump(a2, v3)
                return v6, v4 or 0 < a1._jumpRemaining, v1, v5, false, a1:_popBubbleText()
            end
            if a1._mode == "Curve" then
                a1:_updateCurve(a2, a3.Position)
            end
            _destination = a1._destination
            v3 = _destination - Position
            if Vector3.new(v3.X, 0, v3.Z).Magnitude <= 0.35 and not v8 then
                a1:_beginIdle(a3)
                a1:_chooseNextDestination()
                v4, v5 = a1:_applyJump(a2, a3)
                return v4, 0 < a1._jumpRemaining, v5, a1._walkSpeed, false, a1:_popBubbleText()
            end
            _walkSpeed_3 = a1._walkSpeed
            if (a1._random:NextNumber()) < a1._config.Movement.BurstChance * a2 then
                _walkSpeed_3 = a1._config.Movement.WalkSpeedMax * 1.25 * u37.GetMultiplier(a1._itemData)
                a1:_startJump()
            end
            v4, v5, v6 = AssetWanderMotion.StepMoveToward(a2, a3, _destination, _walkSpeed_3)
            v1, v2 = a1:_applyJump(a2, v4)
            return v1, v5 or 0 < a1._jumpRemaining, v2, v6, false, a1:_popBubbleText()
        end
        if v7 ~= nil then
            v3, v4, v5, v6 = a1:_stepAffection(a2, a3, v7)
            return v3, v4, v5, v6, false, a1:_popBubbleText()
        end
        if a1._config.Movement.FollowOwnerInPen
            and v7 ~= nil
            and AssetWanderArea.IsPositionInside(a1._assetArea, v7) then
            v3, v4, v5 = AssetWanderMotion.StepFollowOwner(a1._assetArea, a2, a3, v7, a1._loyalOwnerOffset, a1._walkSpeed, 2.25)
            v6, v1 = a1:_applyJump(a2, v3)
            return v6, v4 or 0 < a1._jumpRemaining, v1, v5, false, a1:_popBubbleText()
        end
        if a1._mode == "Curve" then
            a1:_updateCurve(a2, a3.Position)
        end
        _destination = a1._destination
        v3 = _destination - Position
        if Vector3.new(v3.X, 0, v3.Z).Magnitude <= 0.35 and not v8 then
            a1:_beginIdle(a3)
            a1:_chooseNextDestination()
            v4, v5 = a1:_applyJump(a2, a3)
            return v4, 0 < a1._jumpRemaining, v5, a1._walkSpeed, false, a1:_popBubbleText()
        end
        _walkSpeed_3 = a1._walkSpeed
        if (a1._random:NextNumber()) < a1._config.Movement.BurstChance * a2 then
            _walkSpeed_3 = a1._config.Movement.WalkSpeedMax * 1.25 * u37.GetMultiplier(a1._itemData)
            a1:_startJump()
        end
        v4, v5, v6 = AssetWanderMotion.StepMoveToward(a2, a3, _destination, _walkSpeed_3)
        v1, v2 = a1:_applyJump(a2, v4)
        return v1, v5 or 0 < a1._jumpRemaining, v2, v6, false, a1:_popBubbleText()
    end
    if v7 ~= nil then
        v3, v4, v5, v6 = a1:_stepReturnGreeting(a2, a3, v7)
        return v3, v4, v5, v6, false, a1:_popBubbleText()
    end
    if a1._phase ~= "AffectionApproach" and a1._phase ~= "AffectionHold" then
        if a1._config.Movement.FollowOwnerInPen
            and v7 ~= nil
            and AssetWanderArea.IsPositionInside(a1._assetArea, v7) then
            v3, v4, v5 = AssetWanderMotion.StepFollowOwner(a1._assetArea, a2, a3, v7, a1._loyalOwnerOffset, a1._walkSpeed, 2.25)
            v6, v1 = a1:_applyJump(a2, v3)
            return v6, v4 or 0 < a1._jumpRemaining, v1, v5, false, a1:_popBubbleText()
        end
        if a1._mode == "Curve" then
            a1:_updateCurve(a2, a3.Position)
        end
        _destination = a1._destination
        v3 = _destination - Position
        if Vector3.new(v3.X, 0, v3.Z).Magnitude <= 0.35 and not v8 then
            a1:_beginIdle(a3)
            a1:_chooseNextDestination()
            v4, v5 = a1:_applyJump(a2, a3)
            return v4, 0 < a1._jumpRemaining, v5, a1._walkSpeed, false, a1:_popBubbleText()
        end
        _walkSpeed_3 = a1._walkSpeed
        if (a1._random:NextNumber()) < a1._config.Movement.BurstChance * a2 then
            _walkSpeed_3 = a1._config.Movement.WalkSpeedMax * 1.25 * u37.GetMultiplier(a1._itemData)
            a1:_startJump()
        end
        v4, v5, v6 = AssetWanderMotion.StepMoveToward(a2, a3, _destination, _walkSpeed_3)
        v1, v2 = a1:_applyJump(a2, v4)
        return v1, v5 or 0 < a1._jumpRemaining, v2, v6, false, a1:_popBubbleText()
    end
    if v7 ~= nil then
        v3, v4, v5, v6 = a1:_stepAffection(a2, a3, v7)
        return v3, v4, v5, v6, false, a1:_popBubbleText()
    end
    if a1._config.Movement.FollowOwnerInPen and v7 ~= nil and AssetWanderArea.IsPositionInside(a1._assetArea, v7) then
        v3, v4, v5 = AssetWanderMotion.StepFollowOwner(a1._assetArea, a2, a3, v7, a1._loyalOwnerOffset, a1._walkSpeed, 2.25)
        v6, v1 = a1:_applyJump(a2, v3)
        return v6, v4 or 0 < a1._jumpRemaining, v1, v5, false, a1:_popBubbleText()
    end
    if a1._mode == "Curve" then
        a1:_updateCurve(a2, a3.Position)
    end
    _destination = a1._destination
    v3 = _destination - Position
    if Vector3.new(v3.X, 0, v3.Z).Magnitude <= 0.35 and not v8 then
        a1:_beginIdle(a3)
        a1:_chooseNextDestination()
        v4, v5 = a1:_applyJump(a2, a3)
        return v4, 0 < a1._jumpRemaining, v5, a1._walkSpeed, false, a1:_popBubbleText()
    end
    _walkSpeed_3 = a1._walkSpeed
    if (a1._random:NextNumber()) < a1._config.Movement.BurstChance * a2 then
        _walkSpeed_3 = a1._config.Movement.WalkSpeedMax * 1.25 * u37.GetMultiplier(a1._itemData)
        a1:_startJump()
    end
    v4, v5, v6 = AssetWanderMotion.StepMoveToward(a2, a3, _destination, _walkSpeed_3)
    v1, v2 = a1:_applyJump(a2, v4)
    return v1, v5 or 0 < a1._jumpRemaining, v2, v6, false, a1:_popBubbleText()
end

return u60