-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetComponent
-- Decompile time: 22.54 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.AssetBillboardController)
local AssetChatBubble = require(ReplicatedStorage.Client.UI.AssetChatBubble)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
require(script.Parent.AssetMovementBatch)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local AssetWanderSimulator = require(script.Parent.AssetWanderSimulator)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Rescale = require(ReplicatedStorage.Shared.Utils.VFX).Rescale
local SfxRework = require(ReplicatedStorage.Data.SfxRework)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types)
local u89 = {}
u89.__index = u89
local GreetingRun = SfxRework.Global("GreetingRun")
local GreetingLove = SfxRework.Global("GreetingLove")
local Jump = SfxRework.Global("Jump")
local SmokeTrail = ReplicatedStorage.Assets.Particles.Pets.SmokeTrail
assert(SmokeTrail:IsA("Attachment"), "SmokeTrail pet particle template must be an Attachment")
local Love = ReplicatedStorage.Assets.Particles.Pets.Love
assert(Love:IsA("Attachment"), "Love pet particle template must be an Attachment")

function u89.new(a1, a2, a3, a4, a5, a6, a7) -- Line: 131
    -- upvalues: AssetRuntime (val), t (val), u89 (val), Trove (val), ItemDisplay (val), ModelBounds (val)
    -- upvalues: AssetModels (val), AssetWanderSimulator (val), Assets (val), SfxRework (val), Audio (val)
    -- upvalues: AssetChatBubble (val), Players (val)
    local v1, v2
    assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(a1), "Invalid runtime asset record")
    t.strict(t.instanceIsA("Player"))(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    t.strict(t.Instance)(a4)
    local u43 = setmetatable({}, u89)
    u43._trove = Trove.new()
    u43._record = a1
    u43._owner = a2
    u43._billboards = a5
    u43._movementBatch = a6
    u43._hiddenTransparencySnapshot = nil
    u43._hiddenDecalSnapshot = nil
    u43._hiddenEffectSnapshot = nil
    u43._model = ItemDisplay.CreateWanderingAssetModel(a1.OwnerUserId, a1.UID, a1.ItemData, a4)
    u43._trove:Connect(u43._model.DescendantAdded, function(a1) -- Line: 158 -- upvalues: u43 (val) -- types: a1: userdata
        local _hiddenTransparencySnapshot = u43._hiddenTransparencySnapshot
        if _hiddenTransparencySnapshot ~= nil and a1:IsA("BasePart") and _hiddenTransparencySnapshot[a1] == nil then
            _hiddenTransparencySnapshot[a1] = a1.Transparency
            a1.Transparency = 1
        end
        local _hiddenDecalSnapshot = u43._hiddenDecalSnapshot
        if _hiddenDecalSnapshot ~= nil and a1:IsA("Decal") and _hiddenDecalSnapshot[a1] == nil then
            _hiddenDecalSnapshot[a1] = a1.Transparency
            a1.Transparency = 1
        end
        local _hiddenEffectSnapshot = u43._hiddenEffectSnapshot
        if _hiddenEffectSnapshot == nil then
            return
        end
        if not a1:IsA("ParticleEmitter") and not a1:IsA("Beam") and not a1:IsA("Trail") then
            return
        end
        if _hiddenEffectSnapshot[a1] == nil then
            _hiddenEffectSnapshot[a1] = a1.Enabled
            a1.Enabled = false
        end
    end)
    u43._rootPart = assert(u43._model.PrimaryPart, (("Asset model %* must have a PrimaryPart"):format(u43._model.Name)))
    local v3 = assert(u43._model:FindFirstChild("CENTER"), (("Asset model %* must contain CENTER"):format(u43._model.Name)))
    assert(v3:IsA("BasePart"), (("Asset model %*.CENTER must be a BasePart"):format(u43._model.Name)))
    u43._centerPart = v3
    local v4, v5 = ModelBounds(u43._model)
    v4 = (u43._model:GetPivot()):PointToObjectSpace(v4.Position).Y - v5.Y * 0.5
    v3 = AssetModels.GetVisibleBoundsData(a1.ItemData.Category)
    local v6 = v3.Size / v3.TemplateScale
    local v7 = 2.5 + v5.Z * 0.5 * 0.8
    local v8 = (math.max(v5.Y, 4.5) / 4.5) ^ 0.7
    u43._wanderSimulator = AssetWanderSimulator.new(
        a1.Seed,
        a2,
        a3,
        a1.ItemData,
        a1.IsFirstPlacement == true,
        v7,
        v8 + math.max((math.max(v5.X, v5.Z) - 5.625) / 4.5, 0) ^ 0.65 * 1.15
    )
    v8 = assert(
        assert(u43._model:FindFirstChild("Model"), (("Asset model %* must contain Model"):format(u43._model.Name))):FindFirstChildWhichIsA("AnimationController"),
        (("Asset model %*.Model must contain AnimationController"):format(u43._model.Name))
    )
    local Animator = v8:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")
    Animator.Parent = v8
    v8 = Assets.Directory[a1.ItemData.Category]
    local Idle = v8.Animations.Idle
    local Walk = v8.Animations.Walk
    u43._idleTrack = nil
    u43._walkTrack = nil
    if u43._model:GetAttribute("AnimationsDisabled") ~= true then
        local v9 = ("Missing Idle animation for %*"):format(a1.ItemData.Category)
        assert(Idle ~= nil, v9)
        v9 = ("Missing Walk animation for %*"):format(a1.ItemData.Category)
        assert(Walk ~= nil, v9)
        v1 = Animator:LoadAnimation(Idle)
        v2 = Animator:LoadAnimation(Walk)
        v1.Looped = true
        v2.Looped = true
        u43._idleTrack = v1
        u43._walkTrack = v2
    end
    u43._walkAnimationReferenceSpeed = v8.WalkAnimationReferenceSpeed or 8
    u43._animationTransitionFadeDuration = v8.Animations.TransitionFadeDuration
    u43._walkAnimationAlwaysOn = u43._animationTransitionFadeDuration == 0
    u43._currentTrack = nil
    u43._idleTransitionRemaining = 0
    u43._wasJumping = false
    u43._greetingEffectsActive = false
    u43._greetingEffectScale = math.clamp(((math.max(v5.X, v5.Y, v5.Z)) / 6) ^ 0.5, 0.7, 6)
    u43._greetingSmokeAttachment = nil
    u43._greetingLoveAttachment = nil
    u43._greetingRunLoopSound = nil
    u43._greetingLoveLoopSound = nil
    v7 = math.max((math.max(v5.X, v5.Y, v5.Z)) / 6 - 1, 0) ^ 0.5
    local v10 = math.clamp(v7 + 1, 1, 3)
    v3 = math.clamp(v7 + 1, 1, 2)
    u43._jumpSoundVolume = v10 * 0.75
    u43._jumpSoundMaxDistance = v3 * 50
    u43._jumpSounds = {}
    u43._walkSound = nil
    u43._walkSoundBasePlaybackSpeed = 1
    u43._walkSoundTargetVolume = 0
    u43._walkSoundFadeTween = nil
    u43._walkSoundWasMoving = false
    u43._simulationWasMoving = false
    u43._randomIdleSound = nil
    u43._randomIdleRandom = Random.new(a1.Seed)
    u43._soundsSuppressed = false
    v10 = SfxRework.Resolve(a1.ItemData.Category, "Walk", v8.WalkSound)
    v7 = SfxRework.Resolve(a1.ItemData.Category, "Idle", v8.RandomIdleSound)
    if v10 ~= nil or v7 ~= nil then
        v8 = Instance.new("Part")
        v8.Name = "AssetWalkSoundEmitter"
        v8.Anchored = false
        v8.CanCollide = false
        v8.CanQuery = false
        v8.CanTouch = false
        v8.Massless = true
        v8.Transparency = 1
        v8.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
        v8.CFrame = u43._rootPart.CFrame * CFrame.new(0, -v5.Y * 0.5, 0)
        v8.Parent = u43._model
        v3 = Instance.new("WeldConstraint")
        v3.Name = "AssetWalkSoundEmitterWeld"
        v3.Part0 = v8
        v3.Part1 = u43._rootPart
        v3.Parent = v8
        v1 = math.max((math.max(v5.X, v5.Y, v5.Z)) / 6 - 1, 0) ^ 0.5
        v3 = math.clamp(v1 + 1, 1, 5)
        v2 = math.clamp(v1 + 1, 1, 3)
        if v10 ~= nil then
            v1 = Instance.new("Sound")
            v1.Name = "AssetWalkSound"
            Audio.Configure(v1, v10)
            v1.Looped = true
            u43._walkSoundBasePlaybackSpeed = v1.PlaybackSpeed
            u43._walkSoundTargetVolume = v1.Volume * v3
            v1.RollOffMaxDistance = math.min(v1.RollOffMaxDistance * v2, 120)
            v1.Volume = 0
            v1.Parent = v8
            u43._walkSound = v1
        end
        if v7 ~= nil then
            local Sound = Instance.new("Sound")
            Sound.Name = "AssetRandomIdleSound"
            Audio.Configure(Sound, v7)
            Sound.Volume = Sound.Volume * v3
            Sound.RollOffMaxDistance = Sound.RollOffMaxDistance * v2
            Sound.Parent = v8
            u43._randomIdleSound = Sound
        end
        u43._trove:Add(v8)
    end
    v10 = true
    if not (6.0229997634887695 < v6.X) then
        v10 = true
        if not (4.925000190734863 < v6.Y) then
            v10 = 3.3399999141693115 < v6.Z
        end
    end
    u43._chatBubble = AssetChatBubble.new(u43._model, u43._centerPart, v10)
    u43._bubbleSuppressionActive = false
    v10 = a7 or u89._initialCFrame(a1, a3)
    u43._model:PivotTo(v10)
    u43._movementBatch:Add(u43._model, {u43._rootPart}, v10, v4, a3, a2 == Players.LocalPlayer, function(a1, a2) -- Line: 358 -- upvalues: u43 (val) -- types: a1: number, a2: boolean
        u43:_step(a1, a2)
    end)
    local _walkTrack = if not u43._walkAnimationAlwaysOn then u43._idleTrack else u43._walkTrack
    if _walkTrack ~= nil then
        u43:_play(_walkTrack)
    end
    return u43
end

function u89:_tryPlayRandomIdleSound() -- Line: 367
    local _randomIdleSound = self._randomIdleSound
    if not self._soundsSuppressed and _randomIdleSound ~= nil and self._randomIdleRandom:NextInteger(1, 13) == 1 then
        _randomIdleSound.TimePosition = 0
        _randomIdleSound:Play()
        return
    end
end

function u89._initialCFrame(a1, a2) -- Line: 385 -- types: a2: userdata
    local v1 = Random.new(a1.Seed)
    local v2 = a2.Size * 0.5
    return (CFrame.new((a2.CFrame * (CFrame.new(v1:NextNumber(-v2.X, v2.X), 0, (v1:NextNumber(-v2.Z, v2.Z))))).Position)) * CFrame.Angles(0, v1:NextNumber(0, 6.283185307179586), 0)
end

function u89:_play(a2) -- Line: 399 -- types: a2: userdata
    if self._currentTrack == a2 then
        return
    end
    if self._currentTrack ~= nil then
        self._currentTrack:Stop(self._animationTransitionFadeDuration or 0.35)
    end
    self._currentTrack = a2
    a2:Play(self._animationTransitionFadeDuration or 0.5)
end

function u89:_walkAnimationSpeed(a2) -- Line: 412 -- types: a2: number
    return (math.clamp(a2 / self._walkAnimationReferenceSpeed, 0.3, 5))
end

function u89:_playJumpSound(a2) -- Line: 420
    -- upvalues: t (val), Player (val), Players (val), Audio (val), Jump (val)
    t.strict(t.Vector3)(a2)
    if self._soundsSuppressed then
        return
    end
    local v1 = Player.FindPrimaryPart(Players.LocalPlayer)
    if v1 ~= nil and not (self._jumpSoundMaxDistance < (v1.Position - a2).Magnitude) then
        local u26 = Audio.Play(Jump, a2, {Volume = self._jumpSoundVolume, MaxDistance = self._jumpSoundMaxDistance})
        if u26 ~= nil then
            self._jumpSounds[u26] = true
            u26.Destroying:Once(function() -- Line: 441 -- upvalues: self (val), u26 (val)
                self._jumpSounds[u26] = nil
            end)
        end
        return
    end
end

function u89._setAttachmentEmittersEnabled(a1, a2) -- Line: 445 -- upvalues: t (val) -- types: a1: userdata, a2: boolean
    t.strict(t.Instance)(a1)
    t.strict(t.boolean)(a2)
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = a2
        end
    end
end

function u89._prepareGreetingAttachment(a1, a2, a3) -- Line: 456
    -- upvalues: t (val), Rescale (val)
    t.strict(t.Instance)(a1)
    t.strict(t.string)(a2)
    t.strict(t.number)(a3)
    local v1 = a1:Clone()
    v1.Name = a2
    for i, v in ipairs(v1:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            Rescale(v, a3)
            v.Enabled = false
        end
    end
    return v1
end

function u89:_isLocalPlayerNear(a2) -- Line: 477 -- upvalues: t (val), Player (val), Players (val) -- types: a2: number
    t.strict(t.number)(a2)
    local v1 = Player.FindPrimaryPart(Players.LocalPlayer)
    local v2 = false
    if v1 ~= nil then
        v2 = (v1.Position - self._rootPart.Position).Magnitude <= a2
    end
    return v2
end

function u89:_getGreetingSmokeAttachment() -- Line: 485 -- upvalues: u89 (val), SmokeTrail (val)
    local _greetingSmokeAttachment = self._greetingSmokeAttachment
    if _greetingSmokeAttachment ~= nil then
        return _greetingSmokeAttachment
    end
    local v1 = u89._prepareGreetingAttachment(SmokeTrail, "AssetGreetingSmokeTrail", self._greetingEffectScale)
    v1.Parent = self._rootPart
    self._greetingSmokeAttachment = v1
    return v1
end

function u89:_getGreetingLoveAttachment() -- Line: 502 -- upvalues: u89 (val), Love (val)
    local _greetingLoveAttachment = self._greetingLoveAttachment
    if _greetingLoveAttachment ~= nil then
        return _greetingLoveAttachment
    end
    local v1 = u89._prepareGreetingAttachment(Love, "AssetGreetingLove", self._greetingEffectScale)
    v1.Parent = self._rootPart
    self._greetingLoveAttachment = v1
    return v1
end

function u89:_stopGreetingLoopSounds() -- Line: 519
    local _greetingRunLoopSound = self._greetingRunLoopSound
    if _greetingRunLoopSound ~= nil then
        self._greetingRunLoopSound = nil
        _greetingRunLoopSound:Stop()
        _greetingRunLoopSound:Destroy()
    end
    local _greetingLoveLoopSound = self._greetingLoveLoopSound
    if _greetingLoveLoopSound ~= nil then
        self._greetingLoveLoopSound = nil
        _greetingLoveLoopSound:Stop()
        _greetingLoveLoopSound:Destroy()
    end
end

function u89:_startGreetingLoopSounds() -- Line: 535 -- upvalues: Audio (val), GreetingRun (val), GreetingLove (val)
    if not self._soundsSuppressed and self:_isLocalPlayerNear(80) then
        if self._greetingRunLoopSound == nil then
            self._greetingRunLoopSound = Audio.Play(GreetingRun, self._rootPart, {Volume = 0.75, MaxDistance = 80, Looped = true})
        end
        if self._greetingLoveLoopSound == nil then
            self._greetingLoveLoopSound = Audio.Play(GreetingLove, self._rootPart, {Volume = 0.75, MaxDistance = 80, Looped = true})
        end
        return
    end
end

function u89:_setGreetingEffectsActive(a2) -- Line: 556 -- upvalues: t (val), u89 (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    if a2 then
        if not self._greetingEffectsActive then
            u89._setAttachmentEmittersEnabled(self:_getGreetingSmokeAttachment(), true)
            u89._setAttachmentEmittersEnabled(self:_getGreetingLoveAttachment(), true)
        end
        if not self:_isLocalPlayerNear(80) then
            self:_stopGreetingLoopSounds()
        else
            self:_startGreetingLoopSounds()
        end
    elseif self._greetingEffectsActive then
        local _greetingSmokeAttachment = self._greetingSmokeAttachment
        if _greetingSmokeAttachment ~= nil then
            u89._setAttachmentEmittersEnabled(_greetingSmokeAttachment, false)
        end
        local _greetingLoveAttachment = self._greetingLoveAttachment
        if _greetingLoveAttachment ~= nil then
            u89._setAttachmentEmittersEnabled(_greetingLoveAttachment, false)
        end
        self:_stopGreetingLoopSounds()
    end
    self._greetingEffectsActive = a2
end

function u89:_destroyGreetingEffects() -- Line: 584
    self:_setGreetingEffectsActive(false)
    local _greetingSmokeAttachment = self._greetingSmokeAttachment
    if _greetingSmokeAttachment ~= nil then
        self._greetingSmokeAttachment = nil
        _greetingSmokeAttachment:Destroy()
    end
    local _greetingLoveAttachment = self._greetingLoveAttachment
    if _greetingLoveAttachment ~= nil then
        self._greetingLoveAttachment = nil
        _greetingLoveAttachment:Destroy()
    end
end

function u89:_releaseBubbleSuppression() -- Line: 598
    if not self._bubbleSuppressionActive then
        return
    end
    self._bubbleSuppressionActive = false
    self._billboards:SetSuppressed(self._model, false)
end

function u89:_displayChatBubble(a2) -- Line: 607 -- types: a2: string
    if not self._bubbleSuppressionActive then
        self._bubbleSuppressionActive = true
        self._billboards:SetSuppressed(self._model, true)
    end
    self._chatBubble:Say(a2, function() -- Line: 612 -- upvalues: self (val)
        self:_releaseBubbleSuppression()
    end)
end

function u89:_setWalkSoundMoving(a2, a3) -- Line: 615 -- upvalues: Audio (val) -- types: a2: boolean, a3: number
    if self._soundsSuppressed then
        a2 = false
    end
    local _walkSound = self._walkSound
    if _walkSound == nil then
        return
    end
    if not a2 then
        if not self._walkSoundWasMoving then
            return
        end
        self._walkSoundWasMoving = false
        local _walkSoundFadeTween_2 = self._walkSoundFadeTween
        if _walkSoundFadeTween_2 ~= nil then
            _walkSoundFadeTween_2:Cancel()
        end
        local u62 = Audio.FadeTo(_walkSound, {Volume = 0, Seconds = 0.1})
        self._walkSoundFadeTween = u62
        u62:Play()
        u62.Completed:Once(function() -- Line: 666 -- upvalues: self (val), u62 (val), _walkSound (val)
            if self._walkSoundFadeTween == u62 then
                self._walkSoundFadeTween = nil
                _walkSound:Stop()
            end
        end)
        return
    end
    _walkSound.PlaybackSpeed = self._walkSoundBasePlaybackSpeed * (math.clamp(a3 / 8, 0.3, 5))
    if not self._walkSoundWasMoving then
        local _walkSoundFadeTween = self._walkSoundFadeTween
        if _walkSoundFadeTween ~= nil then
            _walkSoundFadeTween:Cancel()
        end
        _walkSound.Volume = 0
        if _walkSound.IsLoaded and 2 < _walkSound.TimeLength then
            _walkSound.TimePosition = math.random() * (_walkSound.TimeLength - 1)
        end
        _walkSound:Play()
    end
    if not self._walkSoundWasMoving then
        local v1 = Audio.FadeTo(_walkSound, {Seconds = 0.1, Volume = self._walkSoundTargetVolume})
        self._walkSoundFadeTween = v1
        v1:Play()
    end
    self._walkSoundWasMoving = true
end

function u89:_setSoundsSuppressed(a2) -- Line: 674 -- upvalues: t (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    if self._soundsSuppressed == a2 then
        return
    end
    self._soundsSuppressed = a2
    if not a2 then
        return
    end
    self:_stopGreetingLoopSounds()
    for i in self._jumpSounds do
        i:Stop()
    end
    table.clear(self._jumpSounds)
    local _randomIdleSound = self._randomIdleSound
    if _randomIdleSound ~= nil then
        _randomIdleSound:Stop()
    end
    self:_setWalkSoundMoving(false, 0)
end

function u89:_step(a2, a3) -- Line: 697 -- upvalues: MusicDirector (val) -- types: a2: number, a3: boolean
    local v1 = self:IsHidden()
    self:_setSoundsSuppressed(v1 or MusicDirector.HasCustomTreadmill() or a3)
    local SimulationCFrame = self._movementBatch:GetSimulationCFrame(self._model)
    local v2, v3, v4, v5, v6, v7 = self._wanderSimulator:Step(a2, SimulationCFrame)
    if v1 then
        self._simulationWasMoving = v3
        self._wasJumping = not v4
        self._movementBatch:SetGroundingEnabled(self._model, v4)
        self._movementBatch:SetTarget(self._model, v2)
        return
    end
    local _simulationWasMoving = self._simulationWasMoving and not v3
    self._simulationWasMoving = v3
    if v7 ~= nil then
        self:_displayChatBubble(v7)
    end
    self:_setGreetingEffectsActive(v6 and not a3)
    v7 = not v4
    if v7 and not self._wasJumping then
        self:_playJumpSound(SimulationCFrame.Position)
    end
    self._wasJumping = v7
    self._movementBatch:SetGroundingEnabled(self._model, v4)
    self._movementBatch:SetTarget(self._model, v2)
    if _simulationWasMoving then
        self:_tryPlayRandomIdleSound()
    end
    self:_setWalkSoundMoving(v3 and not a3, v5)
    local _idleTrack = self._idleTrack
    local _walkTrack = self._walkTrack
    if _idleTrack ~= nil and _walkTrack ~= nil then
        if self._walkAnimationAlwaysOn then
            self._idleTransitionRemaining = 0
            self:_play(_walkTrack)
            _walkTrack:AdjustSpeed(if not a3 then self:_walkAnimationSpeed(v5) else 0)
            return
        end
        if a3 then
            self._idleTransitionRemaining = 0
            self:_play(_idleTrack)
            _idleTrack:AdjustSpeed(1)
            return
        end
        if v3 then
            self._idleTransitionRemaining = 0.28
            self:_play(_walkTrack)
            _walkTrack:AdjustSpeed((self:_walkAnimationSpeed(v5)))
            return
        end
        if self._currentTrack == _walkTrack and 0 < self._idleTransitionRemaining then
            self._idleTransitionRemaining = math.max(self._idleTransitionRemaining - a2, 0)
            _walkTrack:AdjustSpeed((self:_walkAnimationSpeed(v5)))
            return
        end
        self:_play(_idleTrack)
        return
    end
end

function u89.GetOwnerUserId(a1) -- Line: 763
    return a1._record.OwnerUserId
end

function u89.GetUid(a1) -- Line: 765
    return a1._record.UID
end

function u89.GetModel(a1) -- Line: 767
    return a1._model
end

function u89.GetRuntimeRecord(a1) -- Line: 769
    return a1._record
end

function u89:IsHidden() -- Line: 773
    return self._hiddenTransparencySnapshot ~= nil
end

function u89:SetHidden(a2) -- Line: 777 -- upvalues: t (val) -- types: a2: boolean
    local v1
    t.strict(t.boolean)(a2)
    if self:IsHidden() == a2 then
        return
    end
    self._movementBatch:SetHidden(self._model, a2)
    if not a2 then
        v1 = assert(self._hiddenTransparencySnapshot, "Hidden asset must own a transparency snapshot")
        self._hiddenTransparencySnapshot = nil
        for k, v in pairs(v1) do
            if k.Parent ~= nil then
                k.Transparency = v
            end
        end
        table.clear(v1)
        local _hiddenDecalSnapshot = self._hiddenDecalSnapshot
        self._hiddenDecalSnapshot = nil
        if _hiddenDecalSnapshot ~= nil then
            for k2, i in pairs(_hiddenDecalSnapshot) do
                if k2.Parent ~= nil then
                    k2.Transparency = i
                end
            end
            table.clear(_hiddenDecalSnapshot)
        end
        local _hiddenEffectSnapshot = self._hiddenEffectSnapshot
        self._hiddenEffectSnapshot = nil
        if _hiddenEffectSnapshot ~= nil then
            for k3, j in pairs(_hiddenEffectSnapshot) do
                if k3.Parent ~= nil then
                    k3.Enabled = j
                end
            end
            table.clear(_hiddenEffectSnapshot)
        end
        self._chatBubble:Mute(false)
        return
    end
    self:_setSoundsSuppressed(true)
    self:_setWalkSoundMoving(false, 0)
    if self._idleTrack ~= nil then
        self._idleTrack:Stop(0)
    end
    if self._walkTrack ~= nil then
        self._walkTrack:Stop(0)
    end
    self._currentTrack = nil
    self._idleTransitionRemaining = 0
    self:_setGreetingEffectsActive(false)
    self._chatBubble:Mute(true)
    self:_releaseBubbleSuppression()
    v1 = {}
    local v2 = {}
    local v3 = {}
    self._hiddenTransparencySnapshot = v1
    self._hiddenDecalSnapshot = v2
    self._hiddenEffectSnapshot = v3
    for i2, k4 in ipairs(self._model:GetDescendants()) do
        if k4:IsA("BasePart") then
            v1[k4] = k4.Transparency
            k4.Transparency = 1
        elseif k4:IsA("Decal") then
            v2[k4] = k4.Transparency
            k4.Transparency = 1
        elseif k4:IsA("ParticleEmitter") or k4:IsA("Beam") or k4:IsA("Trail") then
            v3[k4] = k4.Enabled
            k4.Enabled = false
        end
    end
end

function u89.SetRuntimeRecord(a1, a2) -- Line: 854 -- upvalues: AssetRuntime (val)
    assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(a2), "Invalid runtime asset record")
    a1._record = a2
    a1._wanderSimulator:SetItemData(a2.ItemData, a2.IsFirstPlacement == true)
end

function u89:SetAssetArea(a2) -- Line: 863 -- upvalues: t (val) -- types: a2: userdata
    t.strict(t.instanceIsA("BasePart"))(a2)
    self._wanderSimulator:SetAssetArea(a2)
    self._movementBatch:SetAssetArea(self._model, a2)
end

function u89:Destroy() -- Line: 869
    self:_destroyGreetingEffects()
    self._chatBubble:Destroy()
    self._movementBatch:Remove(self._model)
    self._trove:Destroy()
    self._model:Destroy()
end

return u89