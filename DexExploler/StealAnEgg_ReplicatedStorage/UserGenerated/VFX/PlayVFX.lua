-- Script path: ReplicatedStorage.UserGenerated.VFX.PlayVFX
-- Decompile time: 0.85 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)
return function(a1, a2, a3) -- Line: 25
    -- upvalues: Debris (val), Emit (val)
    local Attachment = Instance.new("Attachment")
    Attachment.CFrame = a1.CFrame:ToObjectSpace(a2)
    for i, v in ipairs(a3:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Parent = Attachment
        end
    end
    if not a3:IsA("ParticleEmitter") then
        a3:Destroy()
    else
        a3.Parent = Attachment
    end
    Attachment.Parent = a1
    Debris:AddItem(Attachment, (Emit(Attachment)))
end