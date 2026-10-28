-- Script path: ReplicatedStorage.Shared.Eggs.PlacedEggReadyPulse
-- Decompile time: 4.63 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local EggActionMovement = require(script.Parent.EggActionMovement)
local t = require(ReplicatedStorage.Packages.t)
local u24 = {}
u24.__index = u24
u24.__class = "PlacedEggReadyPulse"

function u24.new(a1, a2, a3) -- Line: 47
    -- upvalues: t (val), u24 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.CFrame)(a2)
    t.strict(t.number)(a3)
    local v1 = setmetatable({}, u24)
    v1._model = a1
    v1._highlight = nil
    v1._basePivot = a2
    v1._baseScale = a3
    v1._animation = nil
    v1._destroyed = false
    return v1
end

function u24:_createHighlight() -- Line: 71
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ReadyEggPulseHighlight"
    Highlight.Adornee = self._model
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.Parent = self._model
    self._highlight = Highlight
    return Highlight
end

function u24:_destroyHighlight() -- Line: 85
    local _highlight = self._highlight
    if _highlight == nil then
        return
    end
    self._highlight = nil
    _highlight:Destroy()
end

function u24:_resetVisual() -- Line: 95 -- upvalues: EggActionMovement (val)
    local _model = self._model
    if _model:IsDescendantOf(game) then
        _model:ScaleTo(self._baseScale)
        EggActionMovement.SetPivot(_model, self._basePivot)
    end
    self:_destroyHighlight()
end

function u24.SetTransform(a1, a2, a3) -- Line: 109 -- upvalues: t (val) -- types: a2: userdata, a3: number
    t.strict(t.CFrame)(a2)
    t.strict(t.number)(a3)
    a1._basePivot = a2
    a1._baseScale = a3
end

function u24:IsPlaying() -- Line: 121
    return self._animation ~= nil
end

function u24.Play(a1) -- Line: 125 -- upvalues: TweenService (val), EggActionMovement (val), RunService (val)
    if not a1._destroyed and not a1:IsPlaying() and a1._model:IsDescendantOf(game) then
        a1:_resetVisual()

        local function step(a1_2) -- Line: 132
            -- upvalues: a1 (val), TweenService (upval), EggActionMovement (upval)
            if not a1._destroyed and a1._model:IsDescendantOf(game) then
                local v1, v2, v3
                local v4 = math.clamp(a1_2, 0, 1) * 1.05
                local _model_2 = a1._model
                local _basePivot = a1._basePivot
                local _baseScale = a1._baseScale
                if v4 < 0.25 then
                    v1 = v4 / 0.25
                    v2 = 1 - (TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                    v3 = math.sin(v1 * 3.141592653589793 * 2 * 3) * 0.05235987755982989 * v2
                    _model_2:ScaleTo(_baseScale)
                    EggActionMovement.SetPivot(_model_2, _basePivot * CFrame.Angles(0, 0, v3))
                    return false
                end
                v1 = v4 - 0.25
                if not (v1 < 0.6) then
                    a1:_destroyHighlight()
                    v2 = math.clamp((v1 - 0.6) / 0.2, 0, 1)
                    v2 = 1.2 + -0.19999999999999996 * (TweenService:GetValue(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                    _model_2:ScaleTo(_baseScale * v2)
                    EggActionMovement.SetPivot(_model_2, _basePivot)
                    return a1_2 >= 1
                end
                v4 = v1 / 0.6
                local Value_2 = TweenService:GetValue(v4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
                v3 = math.sin(v4 * 3.141592653589793)
                local _highlight = a1._highlight or a1:_createHighlight()
                _highlight.FillTransparency = 1 - v3 * 0.9
                _model_2:ScaleTo(_baseScale * (1 + 0.19999999999999996 * Value_2))
                EggActionMovement.SetPivot(_model_2, _basePivot)
                return false
            end
            return true
        end

        local u14 = 0
        local u15 = nil
        u15 = RunService.PreRender:Connect(function(a1_2) -- Line: 187 -- upvalues: u14 (ref), step (val), u15 (ref), a1 (val) -- types: a1_2: number
            u14 = math.min(u14 + a1_2, 1.05)
            if not step(u14 / 1.05) then
                return
            end
            u15:Disconnect()
            if a1._animation ~= u15 then
                return
            end
            a1._animation = nil
            if not a1._destroyed then
                a1:_resetVisual()
            end
        end)
        a1._animation = u15
        return true
    end
    return false
end

function u24:Cancel() -- Line: 208
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

function u24:Destroy() -- Line: 221
    if self._destroyed then
        return
    end
    self:Cancel()
    self._destroyed = true
    self:_destroyHighlight()
end

return u24