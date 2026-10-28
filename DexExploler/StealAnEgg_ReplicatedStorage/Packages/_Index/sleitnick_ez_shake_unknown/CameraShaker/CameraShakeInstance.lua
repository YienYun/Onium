-- Script path: ReplicatedStorage.Packages._Index.sleitnick_ez_shake@unknown.CameraShaker.CameraShakeInstance
-- Decompile time: 3.03 ms

local u0 = {}
u0.__index = u0
local new = Vector3.new
local noise = math.noise
u0.CameraShakeState = {FadingIn = 0, FadingOut = 1, Sustained = 2, Inactive = 3}

function u0.new(a1, a2, a3, a4) -- Line: 37
    -- upvalues: new (val), u0 (val)
    local v1 = a3 or 0
    local v2 = a4 or 0
    assert(type(a1) == "number", "Magnitude must be a number")
    assert(type(a2) == "number", "Roughness must be a number")
    assert(type(v1) == "number", "FadeInTime must be a number")
    assert(type(v2) == "number", "FadeOutTime must be a number")
    return (setmetatable({
        DeleteOnInactive = true,
        roughMod = 1,
        magnMod = 1,
        _camShakeInstance = true,
        Magnitude = a1,
        Roughness = a2,
        PositionInfluence = new(),
        RotationInfluence = new(),
        fadeOutDuration = v2,
        fadeInDuration = v1,
        sustain = v1 > 0,
        currentFadeTime = if not (v1 > 0) then 1 else 0,
        tick = Random.new():NextNumber(-100, 100),
    }, u0))
end

function u0.UpdateShake(a1, a2) -- Line: 68 -- upvalues: noise (val), new (val) -- types: a1: table, a2: number
    local tick = a1.tick
    local currentFadeTime = a1.currentFadeTime
    local v1 = new(noise(tick, 0) * 0.5, noise(0, tick) * 0.5, (noise(tick, tick)) * 0.5)
    if 0 < a1.fadeInDuration and a1.sustain then
        if currentFadeTime < 1 then
            currentFadeTime = currentFadeTime + a2 / a1.fadeInDuration
        elseif 0 < a1.fadeOutDuration then
            a1.sustain = false
        end
    end
    if not a1.sustain then
        currentFadeTime = currentFadeTime - a2 / a1.fadeOutDuration
    end
    if not a1.sustain then
        a1.tick = tick + a2 * a1.Roughness * a1.roughMod * currentFadeTime
    else
        a1.tick = tick + a2 * a1.Roughness * a1.roughMod
    end
    a1.currentFadeTime = currentFadeTime
    return v1 * a1.Magnitude * a1.magnMod * currentFadeTime
end

function u0.StartFadeOut(a1, a2) -- Line: 97 -- types: a1: table, a2: number
    if a2 == 0 then
        a1.currentFadeTime = 0
    end
    a1.fadeOutDuration = a2
    a1.fadeInDuration = 0
    a1.sustain = false
end

function u0.StartFadeIn(a1, a2) -- Line: 106 -- types: a1: table, a2: number
    if a2 == 0 then
        a1.currentFadeTime = 1
    end
    a1.fadeInDuration = a2 or a1.fadeInDuration
    a1.fadeOutDuration = 0
    a1.sustain = true
end

function u0.GetScaleRoughness(a1) -- Line: 115
    return a1.roughMod
end

function u0.SetScaleRoughness(a1, a2) -- Line: 119 -- types: a1: table, a2: number
    a1.roughMod = a2
end

function u0.GetScaleMagnitude(a1) -- Line: 123
    return a1.magnMod
end

function u0.SetScaleMagnitude(a1, a2) -- Line: 127 -- types: a1: table, a2: number
    a1.magnMod = a2
end

function u0.GetNormalizedFadeTime(a1) -- Line: 131
    return a1.currentFadeTime
end

function u0:IsShaking() -- Line: 135
    local sustain = true
    if not (0 < self.currentFadeTime) then
        sustain = self.sustain
    end
    return sustain
end

function u0:IsFadingOut() -- Line: 139
    return not self.sustain and 0 < self.currentFadeTime
end

function u0:IsFadingIn() -- Line: 143
    local sustain = false
    if self.currentFadeTime < 1 then
        sustain = self.sustain and 0 < self.fadeInDuration
    end
    return sustain
end

function u0.GetState(a1) -- Line: 147 -- upvalues: u0 (val)
    if a1:IsFadingIn() then
        return u0.CameraShakeState.FadingIn
    end
    if a1:IsFadingOut() then
        return u0.CameraShakeState.FadingOut
    end
    if a1:IsShaking() then
        return u0.CameraShakeState.Sustained
    end
    return u0.CameraShakeState.Inactive
end

return u0