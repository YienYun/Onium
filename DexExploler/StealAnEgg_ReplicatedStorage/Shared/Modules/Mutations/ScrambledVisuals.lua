-- Script path: ReplicatedStorage.Shared.Modules.Mutations.ScrambledVisuals
-- Decompile time: 3.23 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u5 = {}

function u5.Clear(a1) -- Line: 6 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:HasTag("Cleanup_Scrambled") then
            j:Destroy()
        end
    end
end

local function emitter(a1, a2, a3) -- Line: 12 -- types: a1: userdata, a2: userdata, a3: number
    local v1 = a1:Clone()
    local v2 = {}
    for i, j in a1.Size.Keypoints do
        table.insert(v2, (NumberSequenceKeypoint.new(j.Time, j.Value * a3, j.Envelope * a3)))
    end
    v1.Size = NumberSequence.new(v2)
    v1.Speed = NumberRange.new(a1.Speed.Min * a3, a1.Speed.Max * a3)
    v1.Acceleration = a1.Acceleration * a3
    v1:AddTag("Cleanup_Scrambled")
    v1:AddTag("Effect")
    v1.Parent = a2
end

function u5.Apply(a1, a2) -- Line: 26
    -- upvalues: u5 (val), ReplicatedStorage (val), emitter (val)
    u5.Clear(a1)
    local Scrambled = ReplicatedStorage.Mutations:FindFirstChild("Scrambled")
    if Scrambled and a2 then
        local Attachment, Attribute_2
        local Attribute = Scrambled:GetAttribute("ReferenceSize")
        local v1 = if typeof(Attribute) ~= "Vector3" or not (0 < Attribute.Magnitude) then 1 else math.clamp(a2.Size.Magnitude / Attribute.Magnitude, 0.01, 100)
        local v2 = Scrambled:FindFirstChild("Body")
        if v2 then
            for i, j in v2:GetChildren() do
                if j:IsA("ParticleEmitter") then
                    emitter(j, a2, v1)
                end
            end
        end
        v2 = Scrambled:FindFirstChild("Eyes")
        if not v2 then
            return
        end
        local v3 = {}
        for k, n in a1:GetDescendants() do
            if n:IsA("Bone") and n.Name:lower():find("eye", 1, true) and not n.Name:lower():find("brow", 1, true) then
                table.insert(v3, n)
            end
        end
        if #v3 == 0 then
            for m, i5 in a1:GetDescendants() do
                if i5:IsA("BasePart") and i5:GetAttribute("IsEye") == true then
                    table.insert(v3, i5)
                end
            end
        end
        local v4 = nil
        local v5 = nil
        for i6, i7 in v3, v4, v5 do
            if i6 > 8 then
                break
            end
            Attachment = Instance.new("Attachment")
            Attachment.Name = "ScrambledEyeFX"
            Attribute_2 = v2:GetAttribute(i7.Name)
            if typeof(Attribute_2) == "CFrame" then
                Attachment.CFrame = Attribute_2.Rotation + Attribute_2.Position * v1
            end
            Attachment:AddTag("Cleanup_Scrambled")
            Attachment:AddTag("Effect")
            Attachment.Parent = i7
            for i8, i9 in v2:GetChildren() do
                if i9:IsA("ParticleEmitter") then
                    emitter(i9, Attachment, v1)
                end
            end
        end
        return
    end
end

return table.freeze(u5)