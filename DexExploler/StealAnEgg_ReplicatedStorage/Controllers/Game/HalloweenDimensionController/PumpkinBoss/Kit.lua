-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Kit
-- Decompile time: 9.95 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local u33 = {"PumpkinBoss", "ScrambleBoss"}
local u36 = {
    Hit = "BatHit",
    Explosion = "Boom",
    CannonFire = "Boom",
    Slam = "HeavyLand",
    Swipe = "Swoosh",
    Land = "HeavyLand",
    Spin = "Swoosh",
}
local u38 = CameraShaker.new()
local u39 = nil
local u40 = {}
CameraShakerDriver.Start(u38, Enum.RenderPriority.Last.Value)
local u46 = {}
u46.Orange = Color3.fromRGB(255, 140, 30)
u46.Red = Color3.fromRGB(255, 50, 50)
u46.Green = Color3.fromRGB(110, 230, 60)
u46.Purple = Color3.fromRGB(150, 60, 255)
u46.StyleColors = table.freeze({
    Default = Color3.fromRGB(255, 50, 50),
    Brute = Color3.fromRGB(255, 50, 50),
    Charge = Color3.fromRGB(255, 50, 50),
    King = Color3.fromRGB(90, 255, 80),
    Goo = Color3.fromRGB(140, 200, 40),
    Fire = Color3.fromRGB(255, 120, 20),
    Bomb = Color3.fromRGB(255, 90, 20),
    Shadow = Color3.fromRGB(255, 50, 50),
    Energy = Color3.fromRGB(190, 110, 255),
    Vine = Color3.fromRGB(90, 255, 80),
})

function u46.StyleColor(a1) -- Line: 68 -- upvalues: u46 (val) -- types: a1: string?
    return u46.StyleColors[a1 or "Default"] or u46.StyleColors.Default
end

function u46.Debris() -- Line: 72 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("Transient") or Workspace
end

function u46.Part(a1) -- Line: 76 -- types: a1: table
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Material = Enum.Material.Neon
    for i, j in a1 do
        Part[i] = j
    end
    return Part
end

function u46.Flat(a1) -- Line: 93 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

function u46.Shake(a1, a2, a3) -- Line: 97 -- upvalues: u38 (val) -- types: a1: number, a2: number?, a3: number?
    u38:ShakeOnce(a1, a2 or 12, 0.05, a3 or 0.8)
end

function u46.ShakeFrom(a1, a2, a3) -- Line: 101
    -- upvalues: Workspace (val), u46 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local v1 = math.clamp(1 - (CurrentCamera.CFrame.Position - a1).Magnitude / a3, 0, 1)
    if v1 > 0.05 then
        u46.Shake(a2 * v1, 14, 0.9)
    end
end

local function findSound(a1) -- Line: 113
    -- upvalues: ReplicatedStorage (val), u36 (val), u33 (val)
    local v1, v2, v3, v4
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Sounds = Assets and Assets:FindFirstChild("Sounds")
    if Sounds == nil then
        return nil
    end
    local v5 = {a1, u36[a1]}
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        v4 = nil
        v2 = nil
        for k, n in u33, v4, v2 do
            v1 = Sounds:FindFirstChild(n)
            v3 = v1 and v1:FindFirstChild(j)
            if v3 and v3:IsA("Sound") then
                return v3
            end
        end
    end
    return nil
end

local function lifetimeOf(a1) -- Line: 133 -- types: a1: userdata
    local v1 = math.max(a1.PlaybackSpeed, 0.05)
    local Attribute = a1:GetAttribute("Seconds")
    local TimeLength = a1.TimeLength
    return math.max((math.max(TimeLength, if type(Attribute) ~= "number" then 0 else Attribute)) / v1, 3) + 1
end

local function soundHost(a1, a2) -- Line: 141 -- upvalues: u46 (val) -- types: a1: vector, a2: userdata
    local v1 = u46.Part({
        Name = "PumpkinSound",
        Transparency = 1,
        Size = Vector3.new(1, 1, 1),
        CFrame = CFrame.new(a1),
    })
    v1.Parent = a2
    return v1
end

function u46.Claim(a1, a2, a3) -- Line: 153 -- upvalues: u40 (val) -- types: a1: string, a2: number, a3: number
    local v1 = os.clock()
    local v2 = {}
    for i, j in u40[a1] or {} do
        if v1 - j < a3 then
            table.insert(v2, j)
        end
    end
    u40[a1] = v2
    if a2 <= #v2 then
        return false
    end
    table.insert(v2, v1)
    return true
end

function u46.Sound(a1, a2, a3, a4) -- Line: 171
    -- upvalues: findSound (val), u46 (val), Debris (val), SoundService (val)
    local v1 = findSound(a1)
    if v1 == nil then
        return nil
    end
    local v2 = v1:Clone()
    v2.Volume = v2.Volume * (a3 or 1)
    v2.PlaybackSpeed = v2.PlaybackSpeed * (a4 or 1)
    local v3 = math.max(v2.PlaybackSpeed, 0.05)
    local Attribute = v2:GetAttribute("Seconds")
    local TimeLength = v2.TimeLength
    v1 = math.max((math.max(TimeLength, if type(Attribute) ~= "number" then 0 else Attribute)) / v3, 3) + 1
    if typeof(a2) == "Vector3" then
        local v4 = u46.Debris()
        v3 = u46.Part({
            Name = "PumpkinSound",
            Transparency = 1,
            Size = Vector3.new(1, 1, 1),
            CFrame = CFrame.new(a2),
        })
        v3.Parent = v4
        Debris:AddItem(v3, v1)
        v2.Parent = v3
    else
        if typeof(a2) ~= "Instance" then
            v2.Parent = SoundService
        else
            v2.Parent = a2
        end
        Debris:AddItem(v2, v1)
    end
    v2:Play()
    return v2
end

function u46.Loop(a1, a2, a3, a4) -- Line: 198
    -- upvalues: findSound (val), u46 (val), TweenService (val)
    local v1 = findSound(a1)
    if v1 == nil then
        return nil
    end
    local v2 = v1:Clone()
    v1 = v2.Volume * (a4 or 1)
    v2.Looped = true
    v2.Volume = 0
    local v3 = u46.Part({
        Name = "PumpkinSound",
        Transparency = 1,
        Size = Vector3.new(1, 1, 1),
        CFrame = CFrame.new(a2),
    })
    v3.Parent = a3
    v2.Parent = v3
    v2:Play()
    TweenService:Create(v2, TweenInfo.new(0.3), {Volume = v1}):Play()
    return v2
end

function u46.FadeOut(a1, a2) -- Line: 215 -- upvalues: TweenService (val) -- types: a1: userdata, a2: number
    local Parent = a1.Parent
    local u10 = false
    if Parent ~= nil then
        u10 = Parent:IsA("BasePart")
        if u10 then
            u10 = Parent.Name == "PumpkinSound"
        end
    end
    local v1 = TweenService:Create(a1, TweenInfo.new(a2), {Volume = 0})
    v1.Completed:Once(function() -- Line: 219 -- upvalues: u10 (val), Parent (val), a1 (val)
        if u10 then
            Parent:Destroy()
            return
        end
        a1:Destroy()
    end)
    v1:Play()
end

function u46.Poof(a1, a2) -- Line: 229
    -- upvalues: u39 (ref), ReplicatedStorage (val), u46 (val), Debris (val)
    local Attribute, new, v1, v2, v3, v4, v5
    local v6 = u39
    if v6 == nil then
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        local Particles = Assets and Assets:FindFirstChild("Particles")
        v4 = Particles and Particles:FindFirstChild("BigHitGroundAttach")
        if v4 == nil then
            return
        end
        v5 = u46.Part({Name = "PumpkinPoof", Transparency = 1, Size = Vector3.new(1, 1, 1)})
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = v5
        for i, j in v4:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                j:Clone().Parent = Attachment
            end
        end
        if v4:IsA("ParticleEmitter") then
            v4:Clone().Parent = Attachment
        end
        u39 = v5
        v6 = v5
    end
    v4 = a2 or 1
    v5 = v6:Clone()
    v5.CFrame = CFrame.new(a1)
    v5.Parent = u46.Debris()
    v6 = 0
    for k, n in v5:GetDescendants() do
        if n:IsA("ParticleEmitter") then
            n.Enabled = false
            if v4 ~= 1 then
                v1 = {}
                for m, i5 in n.Size.Keypoints do
                    table.insert(v1, (NumberSequenceKeypoint.new(i5.Time, i5.Value * v4, i5.Envelope * v4)))
                end
                n.Size = NumberSequence.new(v1)
                new = NumberRange.new
                v2 = n.Speed.Min * v4
                n.Speed = new(v2, n.Speed.Max * v4)
            end
            Attribute = n:GetAttribute("EmitCount")
            v3 = if type(Attribute) ~= "number" then 30 else Attribute
            n:Emit(v3)
            v6 = math.max(v6, n.Lifetime.Max)
        end
    end
    Debris:AddItem(v5, v6 + 0.5)
end

function u46.Burst(a1, a2, a3, a4) -- Line: 287
    -- upvalues: u46 (val), Debris (val)
    local u4 = a4 or 0.45
    local u12 = u46.Part({
        Name = "PumpkinBurst",
        Transparency = 0.3,
        Size = Vector3.new(2, 2, 2),
        Shape = Enum.PartType.Ball,
        Color = a3,
        CFrame = CFrame.new(a1),
    })
    u12.Parent = u46.Debris()
    Debris:AddItem(u12, u4 + 0.1)
    local u23 = os.clock()
    task.spawn(function() -- Line: 301 -- upvalues: u12 (val), u23 (val), u4 (val), a2 (val)
        local v1, v2, v3
        while u12.Parent do
            v1 = math.clamp((os.clock() - u23) / u4, 0, 1)
            v2 = u12
            v3 = a2 * 2 * v1
            v2.Size = Vector3.new(1, 1, 1) * math.max(v3, 2)
            u12.Transparency = v1 * 0.7 + 0.3
            if v1 >= 1 then
                break
            end
            task.wait()
        end
    end)
end

return u46