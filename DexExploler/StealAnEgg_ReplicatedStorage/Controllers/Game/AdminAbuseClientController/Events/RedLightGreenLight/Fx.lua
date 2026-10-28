-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight.Fx
-- Decompile time: 4.10 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local u20 = {}

function u20.Folder() -- Line: 19 -- upvalues: Workspace (val)
    local RedLightGreenLightFx = Workspace:FindFirstChild("RedLightGreenLightFx")
    if RedLightGreenLightFx ~= nil and RedLightGreenLightFx:IsA("Folder") then
        return RedLightGreenLightFx
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "RedLightGreenLightFx"
    Folder.Parent = Workspace
    return Folder
end

function u20.Resolve(a1) -- Line: 34 -- upvalues: ReplicatedStorage (val) -- types: a1: table
    local Assets = ReplicatedStorage.Assets
    for i, j in a1 do
        if Assets == nil then
            return nil
        end
        Assets = Assets:FindFirstChild(j)
    end
    return Assets
end

function u20.Holder(a1, a2) -- Line: 48 -- upvalues: u20 (val) -- types: a1: vector, a2: string?
    local Part = Instance.new("Part")
    Part.Name = a2 or "Holder"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a1)
    Part.Parent = u20.Folder()
    return Part
end

function u20.Sound(a1, a2, a3, a4, a5) -- Line: 65
    -- upvalues: u20 (val), Debris (val), SoundService (val)
    local v1 = u20.Resolve(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        local v2 = v1:Clone()
        local TimeLength = v2.TimeLength
        v2.Volume = v2.Volume * (a3 or 1)
        v2.PlaybackSpeed = a4 or v2.PlaybackSpeed
        v2.Looped = false
        if typeof(a2) == "Vector3" then
            local v3 = u20.Holder(a2, "Sound")
            v2.RollOffMaxDistance = a5 or 900
            v2.Parent = v3
            Debris:AddItem(v3, (math.max(TimeLength, 2)) + 1)
        else
            if typeof(a2) ~= "Instance" then
                v2.Parent = SoundService
            else
                v2.RollOffMaxDistance = a5 or 900
                v2.Parent = a2
            end
            Debris:AddItem(v2, (math.max(TimeLength, 2)) + 1)
        end
        v2:Play()
        return v2
    end
    return nil
end

function u20.ScaleEmitter(a1, a2) -- Line: 105 -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in a1.Size.Keypoints do
        table.insert(v1, (NumberSequenceKeypoint.new(j.Time, j.Value * a2, j.Envelope * a2)))
    end
    a1.Size = NumberSequence.new(v1)
    a1.Speed = NumberRange.new(a1.Speed.Min * a2, a1.Speed.Max * a2)
    a1.Acceleration = a1.Acceleration * a2
end

function u20.Scale(a1, a2) -- Line: 124 -- upvalues: u20 (val) -- types: a1: userdata, a2: number
    local v1
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            u20.ScaleEmitter(j, a2)
        elseif j:IsA("Beam") then
            j.Width0 = j.Width0 * a2
            j.Width1 = j.Width1 * a2
        elseif j:IsA("PointLight") then
            v1 = j.Range * a2
            j.Range = math.min(v1, 60)
        end
    end
end

function u20.Burst(a1, a2) -- Line: 137 -- types: a1: userdata, a2: number?
    local Attribute, Attribute_2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            Attribute = j:GetAttribute("EmitCount")
            Attribute_2 = j:GetAttribute("EmitDelay")
            local u40 = math.max(math.round((if type(Attribute) ~= "number" then 6 else Attribute) * (a2 or 1)), 1)
            j.Enabled = false
            if type(Attribute_2) ~= "number" or not (Attribute_2 > 0) then
                j:Emit(u40)
            else
                task.delay(Attribute_2, function() -- Line: 153 -- upvalues: j (val), u40 (val)
                    if j.Parent ~= nil then
                        j:Emit(u40)
                    end
                end)
            end
        end
    end
end

function u20.SetEmitting(a1, a2) -- Line: 164 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            j.Enabled = a2
        end
    end
end

function u20.Tint(a1, a2) -- Line: 172 -- types: a1: userdata, a2: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Trail") then
            j.Color = a2
        end
    end
end

return table.freeze(u20)