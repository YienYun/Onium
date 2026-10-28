-- Script path: ReplicatedStorage.Client.FuseMachineMotion
-- Decompile time: 4.54 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local t = require(ReplicatedStorage.Packages.t)
local u25 = {
    {
        Seconds = 0.22,
        Rise = 2.6,
        Squash = 0.92,
        Stretch = 1.12,
        Pitch = -6,
        Roll = 5,
    },
    {
        Seconds = 0.18,
        Rise = 1.65,
        Squash = 0.96,
        Stretch = 1.08,
        Pitch = 4,
        Roll = -3,
    },
    {
        Seconds = 0.15,
        Rise = 0.9,
        Squash = 0.985,
        Stretch = 1.04,
        Pitch = -2,
        Roll = 1.5,
    },
}
local u29 = {}
local EasingStyle = Enum.EasingStyle
local EasingDirection = Enum.EasingDirection

local function backOut(a1) -- Line: 41
    -- upvalues: TweenService (val), EasingStyle (val), EasingDirection (val)
    return TweenService:GetValue(a1, EasingStyle.Back, EasingDirection.Out)
end

local function bounceOut(a1) -- Line: 43
    -- upvalues: TweenService (val), EasingStyle (val), EasingDirection (val)
    return TweenService:GetValue(a1, EasingStyle.Bounce, EasingDirection.Out)
end

local function quadIn(a1) -- Line: 45
    -- upvalues: TweenService (val), EasingStyle (val), EasingDirection (val)
    return TweenService:GetValue(a1, EasingStyle.Quad, EasingDirection.In)
end

local function locateEmitter(a1, a2) -- Line: 47 -- types: a1: userdata, a2: userdata
    return a2:FindFirstChild("EmitFuse") or a1:FindFirstChild("EmitFuse")
end

local function poseAt(a1, a2, a3) -- Line: 52
    -- upvalues: TweenService (val), EasingStyle (val), EasingDirection (val)
    local v1, v2
    if a2 < 0.34 then
        v1 = TweenService:GetValue(math.min(a2 / 0.34, 1), EasingStyle.Back, EasingDirection.Out)
        return a1.Rise * v1, a1.Pitch * v1, a1.Roll * v1, a3 + (a1.Stretch - a3) * v1
    end
    v1 = math.max(a2 - 0.34, 0) / 0.66
    local v3 = 1 - TweenService:GetValue(v1, EasingStyle.Bounce, EasingDirection.Out)
    if not (v1 < 0.55) then
        local Value_2 = TweenService:GetValue((v1 - 0.55) / 0.45, EasingStyle.Bounce, EasingDirection.Out)
        v2 = a1.Squash + (a3 - a1.Squash) * Value_2
    else
        local Value = TweenService:GetValue(v1 / 0.55, EasingStyle.Quad, EasingDirection.In)
        v2 = a1.Stretch + (a1.Squash - a1.Stretch) * Value
    end
    return a1.Rise * v3, a1.Pitch * v3, a1.Roll * v3, v2
end

function u29.Bounce(a1, a2) -- Line: 80
    -- upvalues: t (val), u25 (val), RunService (val), poseAt (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.callback)(a2)
    local Pivot = a1:GetPivot()
    local Scale = a1:GetScale()
    for i, v in ipairs(u25) do
        v8 = false
        v1 = 0
        while v1 < v.Seconds do
            v2 = RunService.PreRender:Wait()
            if not v9() then
                v8 = true
                break
            end
            v1 = math.min(v1 + v2, v.Seconds)
            v3 = poseAt
            v5 = v1 / v.Seconds
            v3, v4, v5, v6 = v3(v, v5, Scale)
            v10:ScaleTo(v6)
            v7 = Pivot * CFrame.new(0, v3, 0) * (CFrame.Angles(math.rad(v4), 0, (math.rad(v5))))
            v10:PivotTo(v7)
        end
        v10:ScaleTo(Scale)
        v10:PivotTo(Pivot)
        if v8 then
            return false
        end
    end
    return true
end

function u29.Burst(a1, a2) -- Line: 117 -- upvalues: t (val), EmitTree (val) -- types: a1: userdata, a2: userdata
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    local EmitFuse = a2:FindFirstChild("EmitFuse") or a1:FindFirstChild("EmitFuse")
    if EmitFuse ~= nil then
        EmitTree(EmitFuse)
    end
end

function u29.Run(a1, a2, a3) -- Line: 127
    -- upvalues: t (val), u29 (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    t.strict(t.callback)(a3)
    local v1 = u29.Bounce(a1, a3)
    if v1 then
        u29.Burst(a1, a2)
    end
    return v1
end

return u29