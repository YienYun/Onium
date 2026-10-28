-- Script path: ReplicatedStorage.Controllers.Game.Tools.GravityDisruptorVFXController
-- Decompile time: 1.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
return {
    Start = function() -- Line: 12 -- upvalues: ReplicatedStorage (val), VFX (val), Remotes (val)
        local GravityDisruptorVFX = ReplicatedStorage.Assets.Particles.GravityDisruptorVFX

        local function collectEmitters(a1) -- Line: 17 -- types: a1: userdata
            local v1 = {}
            for i, j in a1:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    table.insert(v1, j)
                end
            end
            return v1
        end

        Remotes.GravityDisruptor.Burst.OnClientEvent:Connect(function(a1, a2) -- Line: 27
            -- upvalues: GravityDisruptorVFX (val), VFX (upval), collectEmitters (val)
            if a2 ~= "FadeIn" and a2 ~= "FadeOut" then
                return
            end
            local v1 = GravityDisruptorVFX:FindFirstChild(a2)
            if not v1 then
                return
            end
            VFX.EmitAt(CFrame.new(a1), (collectEmitters(v1)))
        end)
    end,
}