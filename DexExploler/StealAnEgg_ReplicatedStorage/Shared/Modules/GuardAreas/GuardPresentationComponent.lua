-- Script path: ReplicatedStorage.Shared.Modules.GuardAreas.GuardPresentationComponent
-- Decompile time: 6.24 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Utils.AnimationAssets)
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Data.Guards)
local t = require(ReplicatedStorage.Packages.t)
local u22 = {}
u22.__index = u22
u22.__class = "GuardPresentationComponent"

function u22.new(a1, a2, a3) -- Line: 46
    -- upvalues: t (val), u22 (val), Audio (val)
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.Instance)(a2)
    t.strict(t.table)(a3)
    local v1 = setmetatable({}, u22)
    v1._afterWakeSoundConfigs = u22.NormalizeAfterWakeSoundConfigs(a3.AfterWakeSound)
    v1._afterWakeSound = if not (#v1._afterWakeSoundConfigs > 0) then nil else Audio.CreateConfigured(a1, u22.CreateSoundFile(v1._afterWakeSoundConfigs[1]), "AfterWakeSound")
    v1._afterWakeSoundAt = nil
    v1._animationBaseWalkSpeed = a3.AnimationBaseWalkSpeed or 7
    assert(0 < v1._animationBaseWalkSpeed, (("Guard %* animation base WalkSpeed must be greater than zero"):format(a3._id)))
    v1._footstepSound = if a3.FootstepSound == nil then nil else Audio.CreateConfigured(a1, u22.CreateSoundFile(a3.FootstepSound), "FootstepSound")
    v1._footstepPlaybackSpeed = if a3.FootstepSound == nil then nil else a3.FootstepSound.PlaybackSpeed or 1
    v1._hitSound = Audio.CreateConfigured(a1, u22.CreateSoundFile(a3.AttackSound), "Hit")
    v1._hitTrack = if a3.AttackAnimation == nil then nil else u22.LoadTrack(a2, a3.AttackAnimation, false)
    local _hitTrack = v1._hitTrack
    if _hitTrack ~= nil then
        _hitTrack.Priority = Enum.AnimationPriority.Action4
    end
    v1._idleTrack = u22.LoadTrack(a2, a3.IdleAnimation, true)
    v1._sleepSound = Audio.CreateConfigured(a1, u22.CreateSoundFile(a3.SleepSound), "SleepSound")
    v1._sleepTrack = u22.LoadTrack(a2, a3.SleepAnimation, true)
    v1._random = Random.new()
    v1._wakeSound = Audio.CreateConfigured(a1, u22.CreateSoundFile(a3.WakeSound), "Detected")
    v1._walkTrack = u22.LoadTrack(a2, a3.WalkAnimation, true)
    return v1
end

function u22.CreateSoundFile(a1) -- Line: 115
    local v1 = {}
    local SoundIds = a1.SoundIds or a1.SoundId
    v1.SoundId = SoundIds
    v1.Data = {
        Speed = a1.PlaybackSpeed,
        Volume = a1.Volume,
        MaxDistance = a1.MaxDistance,
        Looped = a1.Looped,
    }
    return v1
end

function u22.NormalizeAfterWakeSoundConfigs(a1) -- Line: 129
    if a1 == nil then
        return {}
    end
    if typeof(a1) == "table"
        and typeof(a1.SoundId) == "string"
        and typeof(a1.Volume) == "number"
        and typeof(a1.MaxDistance) == "number" then
        return {a1}
    end
    assert(#a1 > 0, "AfterWakeSound config array must not be empty")
    return a1
end

function u22.LoadTrack(a1, a2, a3) -- Line: 149 -- upvalues: t (val) -- types: a1: userdata, a2: userdata, a3: boolean
    t.strict(t.instanceIsA("Animation"))(a2)
    t.strict(t.boolean)(a3)
    local v1 = a1:LoadAnimation(a2)
    v1.Looped = a3
    return v1
end

function u22:Destroy() -- Line: 165
    self._afterWakeSoundAt = nil
    self:StopWalkAnimation()
    self:StopIdleAnimation()
    self:StopFootstepSound()
    self._sleepTrack:Stop(0.1)
    local _hitTrack = self._hitTrack
    if _hitTrack ~= nil then
        _hitTrack:Stop(0.1)
    end
    if self._footstepSound ~= nil then
        self._footstepSound:Destroy()
    end
    if self._afterWakeSound ~= nil then
        self._afterWakeSound:Destroy()
    end
    self._hitSound:Destroy()
    self._sleepSound:Destroy()
    self._wakeSound:Destroy()
end

function u22.PlaySleep(a1, a2) -- Line: 186 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if not a1._sleepTrack.IsPlaying then
        a1._sleepTrack:Play(a2)
    end
    if not a1._sleepSound.IsPlaying then
        a1._sleepSound.Looped = true
        a1._sleepSound.TimePosition = 0
        a1._sleepSound:Play()
    end
end

function u22.StopSleep(a1, a2) -- Line: 201 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    a1._sleepTrack:Stop(a2)
    a1._sleepSound:Stop()
end

function u22.PlayWake(a1) -- Line: 210
    a1._wakeSound.TimePosition = 0
    a1._wakeSound:Play()
end

function u22:PlayAfterWake() -- Line: 215 -- upvalues: Audio (val), u22 (val)
    local _afterWakeSound = self._afterWakeSound
    if _afterWakeSound == nil then
        return
    end
    local v1 = self._afterWakeSoundConfigs[self._random:NextInteger(1, #self._afterWakeSoundConfigs)]
    assert(v1 ~= nil, "AfterWakeSound playback requires a configured sound")
    _afterWakeSound:Stop()
    Audio.Configure(_afterWakeSound, u22.CreateSoundFile(v1))
    _afterWakeSound.TimePosition = 0
    _afterWakeSound:Play()
end

function u22.ScheduleAfterWake(a1, a2) -- Line: 229 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    if a1._afterWakeSound ~= nil then
        a1._afterWakeSoundAt = a2 + 1
    end
end

function u22.CancelAfterWake(a1) -- Line: 239
    a1._afterWakeSoundAt = nil
end

function u22.UpdateAfterWake(a1, a2, a3) -- Line: 243 -- upvalues: t (val) -- types: a2: number, a3: boolean
    t.strict(t.number)(a2)
    t.strict(t.boolean)(a3)
    local _afterWakeSoundAt = a1._afterWakeSoundAt
    if _afterWakeSoundAt ~= nil and not (a2 < _afterWakeSoundAt) then
        a1._afterWakeSoundAt = nil
        if a3 then
            a1:PlayAfterWake()
        end
        return
    end
end

function u22.PlayHit(a1) -- Line: 262
    a1:StopWalkAnimation()
    a1:StopFootstepSound()
    a1:EnsureIdleAnimation()
    local v1 = 0
    local _hitTrack = a1._hitTrack
    if _hitTrack ~= nil then
        _hitTrack.TimePosition = 0
        _hitTrack:Play(0.05)
        local Length = _hitTrack.Length
        local v2 = math.max(Length / 1.5, 1)
        _hitTrack:AdjustSpeed(v2)
        v1 = Length / v2
    end
    a1._hitSound.TimePosition = 0
    a1._hitSound:Play()
    return v1
end

function u22:EnsureFootstepSound(a2) -- Line: 281 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    local _footstepSound = self._footstepSound
    local _footstepPlaybackSpeed = self._footstepPlaybackSpeed
    if _footstepSound ~= nil and _footstepPlaybackSpeed ~= nil then
        _footstepSound.PlaybackSpeed = _footstepPlaybackSpeed * math.max(a2 / self._animationBaseWalkSpeed, 0.01)
        if not _footstepSound.IsPlaying then
            _footstepSound.Looped = true
            _footstepSound.TimePosition = 0
            _footstepSound:Play()
        end
        return
    end
end

function u22:StopFootstepSound() -- Line: 300
    local _footstepSound = self._footstepSound
    if _footstepSound ~= nil and _footstepSound.IsPlaying then
        _footstepSound:Stop()
    end
end

function u22:EnsureIdleAnimation() -- Line: 307
    if not self._idleTrack.IsPlaying then
        self._idleTrack:Play(0.2)
    end
end

function u22:StopIdleAnimation() -- Line: 313
    if self._idleTrack.IsPlaying then
        self._idleTrack:Stop(0.2)
    end
end

function u22.EnsureWalkAnimation(a1, a2) -- Line: 319 -- upvalues: t (val) -- types: a2: number
    t.strict(t.number)(a2)
    a1:StopIdleAnimation()
    a1:EnsureFootstepSound(a2)
    a1._walkTrack:AdjustSpeed((math.max(a2 / a1._animationBaseWalkSpeed, 0.01)))
    if not a1._walkTrack.IsPlaying then
        a1._walkTrack:Play(0.4)
    end
end

function u22:StopWalkAnimation() -- Line: 332
    if self._walkTrack.IsPlaying then
        self._walkTrack:Stop(0.2)
    end
end

return u22