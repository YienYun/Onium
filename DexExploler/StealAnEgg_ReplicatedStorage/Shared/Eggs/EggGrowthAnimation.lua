-- Script path: ReplicatedStorage.Shared.Eggs.EggGrowthAnimation
-- Decompile time: 3.90 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local EggActionMovement = require(script.Parent.EggActionMovement)
local t = require(ReplicatedStorage.Packages.t)
local u24 = {}
u24.__index = u24
u24.__class = "EggGrowthAnimation"

function u24.new(a1, a2, a3) -- Line: 40
    -- upvalues: t (val), u24 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.CFrame)(a2)
    t.strict(t.number)(a3)
    assert(a3 > 0, "Jump height multiplier must be positive")
    local v1 = setmetatable({}, u24)
    v1._model = a1
    v1._basePivot = a2
    v1._jumpHeightMultiplier = a3
    v1._animation = nil
    v1._destroyed = false
    return v1
end

function u24:_resetVisual() -- Line: 64 -- upvalues: EggActionMovement (val)
    local _model = self._model
    if _model:IsDescendantOf(game) then
        EggActionMovement.SetPivot(_model, self._basePivot)
    end
end

function u24.SetBasePivot(a1, a2) -- Line: 75 -- upvalues: t (val) -- types: a2: userdata
    t.strict(t.CFrame)(a2)
    a1._basePivot = a2
    if not a1:IsPlaying() then
        a1:_resetVisual()
    end
end

function u24:IsPlaying() -- Line: 84
    return self._animation ~= nil
end

function u24.Play(a1) -- Line: 88 -- upvalues: TweenService (val), EggActionMovement (val), RunService (val)
    if not a1._destroyed and not a1:IsPlaying() and a1._model:IsDescendantOf(game) then
        local function step(a1_2) -- Line: 93
            -- upvalues: a1 (val), TweenService (upval), EggActionMovement (upval)
            if not a1._destroyed then
                local _model = a1._model
                local v1 = game
                if _model:IsDescendantOf(v1) then
                    local v2 = math.clamp(a1_2, 0, 1)
                    local Value = if not (v2 < 0.5) then 1 - TweenService:GetValue((v2 - 0.5) * 2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out) else TweenService:GetValue(v2 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    v1 = 1 - (TweenService:GetValue(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                    local v3 = math.sin(v2 * 3.141592653589793 * 2 * 4) * 0.06981317007977318 * v1
                    v1 = 0.85 * a1._jumpHeightMultiplier * Value
                    EggActionMovement.SetPivot(a1._model, a1._basePivot * CFrame.new(0, v1, 0) * CFrame.Angles(0, 0, v3))
                    return a1_2 >= 1
                end
            end
            return true
        end

        local u11 = 0
        local u12 = nil
        u12 = RunService.PreRender:Connect(function(a1_2) -- Line: 122 -- upvalues: u11 (ref), step (val), u12 (ref), a1 (val) -- types: a1_2: number
            u11 = math.min(u11 + a1_2, 0.55)
            if not step(u11 / 0.55) then
                return
            end
            u12:Disconnect()
            if a1._animation ~= u12 then
                return
            end
            a1._animation = nil
            if not a1._destroyed then
                a1:_resetVisual()
            end
        end)
        a1._animation = u12
        return true
    end
    return false
end

function u24:Cancel() -- Line: 143
    local _animation = self._animation
    if _animation == nil then
        return
    end
    self._animation = nil
    _animation:Disconnect()
    if not self._destroyed then
        self:_resetVisual()
    end
end

function u24.Destroy(a1) -- Line: 156
    if a1._destroyed then
        return
    end
    a1:Cancel()
    a1._destroyed = true
end

return u24