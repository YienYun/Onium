-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.RaceEffects
-- Decompile time: 2.64 ms

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
require(script.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(script.Parent.RaceCamera)
local u49 = NumberRange.new(20, 35)
local u51 = Random.new()

local function burst(a1, a2) -- Line: 40
    -- upvalues: Workspace (val), EmitOnce (val)
    local v1 = a1:Clone()
    v1.CFrame = a2
    v1.Parent = Workspace
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            EmitOnce(j)
        end
    end
    task.delay(3, v1.Destroy, v1)
end

local function flash() -- Line: 52 -- upvalues: Lighting (val), TweenService (val)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Parent = Lighting
    local v1 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.15), {Brightness = 0.35, Saturation = 0.3})
    v1:Play()
    v1.Completed:Wait()
    v1 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {Brightness = 0, Saturation = 0})
    v1:Play()
    v1.Completed:Wait()
    ColorCorrectionEffect:Destroy()
end

return {
    Finish = function(a1, a2) -- Line: 68
        -- upvalues: SoundService (val), MountRace (val), flash (val), u51 (val), u49 (val), burst (val)
        SoundService:PlayLocalSound(MountRace.Sounds.Finish)
        a2:PunchFov(20)
        task.spawn(flash)
        local CFrame = a1.FinishLine.CFrame
        task.spawn(function() -- Line: 73
            -- upvalues: u51 (upval), u49 (upval), burst (upval), MountRace (upval), CFrame (val), SoundService (upval)
            local v1
            for i = 1, 4 do
                v1 = Vector3.new(u51:NextNumber(-25, 25), u51:NextNumber(u49.Min, u49.Max), 0)
                burst(MountRace.Effects.Fireworks, CFrame * CFrame.new(v1))
                SoundService:PlayLocalSound(MountRace.Sounds.Firework)
                task.wait(0.35)
            end
        end)
    end,
    Boost = function(a1, a2) -- Line: 87 -- upvalues: SoundService (val), MountRace (val), burst (val)
        SoundService:PlayLocalSound(MountRace.Sounds.Boost)
        a2:PunchFov(12)
        local Hitbox = a1.Rig.Mount.Hitbox
        burst(MountRace.Effects.BoostBurst, Hitbox.CFrame * CFrame.new(0, 0, Hitbox.Size.Z / 2))
    end,
}