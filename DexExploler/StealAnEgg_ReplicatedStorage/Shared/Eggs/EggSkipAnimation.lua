-- Script path: ReplicatedStorage.Shared.Eggs.EggSkipAnimation
-- Decompile time: 1.72 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local t = require(ReplicatedStorage.Packages.t)
local SkipEggEffect = ReplicatedStorage.Assets.Particles["Egg Open"].SkipEggEffect
return {
    Play = function(a1) -- Line: 24
        -- upvalues: t (val), EggRenderer (val), SkipEggEffect (val), RunService (val), TweenService (val)
        -- upvalues: EggActionMovement (val), Debris (val)
        local Value
        t.strict(t.instanceIsA("Model"))(a1)
        EggRenderer.DisableCollisions(a1)
        local Pivot = a1:GetPivot()
        local v1 = 0
        local v2 = SkipEggEffect.Attachment:Clone()
        v2.Parent = workspace.Terrain
        for i, j in v2:GetDescendants() do
            j.Enabled = true
        end
        v2.WorldCFrame = Pivot * CFrame.Angles(0, 0, 3.141592653589793)
        while v1 < 1.2 do
            v1 = v1 + RunService.Heartbeat:Wait()
            Value = TweenService:GetValue(v1 / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            EggActionMovement.SetPivot(
                a1,
                Pivot * CFrame.Angles(0, math.rad(Value * 1080), 0) * CFrame.Angles(0, 0, (math.rad(math.sin(1080 * Value) * 35 * (1 - Value))))
            )
        end
        for k, n in v2:GetDescendants() do
            n.Enabled = false
        end
        Debris:AddItem(v2, 5)
    end,
}