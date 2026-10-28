-- Script path: ReplicatedStorage.UserGenerated.VFX.Emit
-- Decompile time: 0.68 ms

local Emit
local EmitOnce = require(game.ReplicatedStorage.UserGenerated.VFX.EmitOnce)

function Emit(a1) -- Line: 22 -- upvalues: EmitOnce (val), Emit (val) -- types: a1: userdata
    local v1 = 0
    if a1:IsA("ParticleEmitter") then
        v1 = math.max(v1, (EmitOnce(a1)))
    end
    for i, v in ipairs(a1:GetChildren()) do
        v1 = math.max(v1, (Emit(v)))
    end
    return v1
end

return Emit