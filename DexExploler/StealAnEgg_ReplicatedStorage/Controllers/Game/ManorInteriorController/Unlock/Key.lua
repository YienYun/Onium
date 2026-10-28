-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Key
-- Decompile time: 5.64 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Packages.Trove)
local u18 = Color3.fromRGB(255, 196, 110)
local u23 = Color3.fromRGB(255, 214, 150)
local u28 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v1 = {}

local function template() -- Line: 35 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local ManorInterior = Assets and Assets:FindFirstChild("ManorInterior")
    local v1 = ManorInterior and ManorInterior:FindFirstChild("Key")
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

function v1.Build(a1, a2) -- Line: 46 -- upvalues: ReplicatedStorage (val), u23 (val), u18 (val) -- types: a2: userdata
    local BoundingBox_2, v1
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local ManorInterior = Assets and Assets:FindFirstChild("ManorInterior")
    local v2 = ManorInterior and ManorInterior:FindFirstChild("Key")
    if (if v2 == nil then nil else if not v2:IsA("Model") then nil else v2) == nil then
        return nil
    end
    v2 = a1:Add((v1:Clone()))
    v2.Name = "ManorKeyProp"
    v2.WorldPivot = v2:GetBoundingBox()
    v2:ScaleTo((v1:GetScale()) * 0.58)
    v1 = {}
    local v3 = {}
    local v4 = nil
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
            j.Massless = true
            v3[j] = j.Transparency
            j.Transparency = 1
            table.insert(v1, j)
            if v4 == nil or v4.Size.Magnitude < j.Size.Magnitude then
                v4 = j
            end
        end
    end
    _, BoundingBox_2 = v2:GetBoundingBox()
    local v5 = Instance.new("Attachment")
    v5.Name = "Glint"
    v5.Parent = v4 or v2.PrimaryPart
    v4 = Instance.new("PointLight")
    v4.Color = u23
    v4.Range = 8
    v4.Brightness = 0
    v4.Shadows = false
    v4.Parent = v5
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Sparkle"
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1), u23)
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), (NumberSequenceKeypoint.new(1, 0))})
    ParticleEmitter.Lifetime = NumberRange.new(0.25, 0.45)
    ParticleEmitter.Speed = NumberRange.new(4, 9)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Drag = 6
    ParticleEmitter.Parent = v5
    v5 = Instance.new("Highlight")
    v5.Name = "Rim"
    v5.DepthMode = Enum.HighlightDepthMode.Occluded
    v5.FillColor = u18
    v5.FillTransparency = 0.88
    v5.OutlineColor = u18
    v5.OutlineTransparency = 0.2
    v5.Adornee = v2
    v5.Parent = v2
    v2.Parent = a2
    return {
        Model = v2,
        Length = BoundingBox_2.Y,
        Parts = v1,
        Rest = v3,
        Sparkle = ParticleEmitter,
        Light = v4,
    }
end

function v1.Seat(a1, a2, a3, a4) -- Line: 120 -- types: a1: table, a2: vector, a3: vector, a4: number
    local v1 = -a3
    local v2 = v1 * 1
    return CFrame.fromMatrix(a2 + v1 * (a1.Length / 2 - a1.Length * a4), v2:Cross((Vector3.new(0, 1, 0))), v2, (Vector3.new(0, 1, 0)))
end

function v1.Place(a1, a2) -- Line: 127 -- types: a1: table, a2: userdata
    a1.Model:PivotTo(a2)
end

function v1.Show(a1, a2) -- Line: 131 -- types: a1: table, a2: number
    local v1
    for i, j in a1.Rest do
        v1 = math.clamp(a2, 0, 1)
        i.Transparency = math.lerp(1, j, v1)
    end
    a1.Light.Brightness = math.clamp(a2, 0, 1) * 1.5
end

function v1.Weld(a1, a2) -- Line: 138 -- types: a1: table, a2: userdata
    local WeldConstraint
    for i, j in a1.Parts do
        WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = a2
        WeldConstraint.Part1 = j
        WeldConstraint.Parent = j
        j.Anchored = false
    end
end

function v1.Fade(a1) -- Line: 148 -- upvalues: TweenService (val), u28 (val) -- types: a1: table
    local Rim = a1.Model:FindFirstChild("Rim")
    if Rim ~= nil and Rim:IsA("Highlight") then
        Rim.Enabled = false
    end
    for i, j in a1.Parts do
        TweenService:Create(j, u28, {Transparency = 1}):Play()
    end
    TweenService:Create(a1.Light, u28, {Brightness = 0}):Play()
end

return table.freeze(v1)