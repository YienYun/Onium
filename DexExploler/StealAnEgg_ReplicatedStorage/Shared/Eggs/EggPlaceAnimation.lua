-- Script path: ReplicatedStorage.Shared.Eggs.EggPlaceAnimation
-- Decompile time: 9.18 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local EggActionMovement = require(script.Parent.EggActionMovement)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u33 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u38 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u43 = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local u48 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u53 = TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local u58 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u63 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u68 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u69 = {}
local v1 = Color3.fromRGB(101, 67, 33)
local v2 = Color3.fromRGB(92, 60, 28)
local v3 = Color3.fromRGB(110, 75, 40)
u69[1] = v1
u69[2] = v2
u69[3] = v3
u69[4] = Color3.fromRGB(85, 55, 25)
local u90 = {}

function u90.CreateDirtChunk(a1, a2, a3) -- Line: 45
    -- upvalues: t (val), u69 (val), TweenService (val), u48 (val), u53 (val), u58 (val), u63 (val), Debris (val)
    t.strict(t.Instance)(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.number)(a3)
    local Part = Instance.new("Part")
    local u32 = math.random(25, 45) / 100 * a3
    Part.Size = Vector3.new(u32, u32 * 0.7, u32)
    Part.Color = u69[math.random(1, #u69)]
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 0
    Part.Position = a2 + Vector3.new(0, 0.05000000074505806, 0)
    Part.Orientation = Vector3.new(math.random(-30, 30), math.random(-180, 180), (math.random(-30, 30)))
    Part.Parent = a1
    local v1 = math.rad((math.random(0, 360)))
    local v2 = math.random(30, 60) / 100 * a3
    local v3 = math.cos(v1) * v2
    local v4 = math.sin(v1) * v2
    v2 = a2 + Vector3.new(v3 * 0.6, math.random(50, 90) / 100 * a3, v4 * 0.6)
    local u102 = a2 + Vector3.new(v3, a3 * 0.02, v4)
    local u108 = u102 + Vector3.new(0, a3 * -0.01, 0)
    v3 = TweenService:Create(Part, u48, {
        Position = v2,
        Orientation = Part.Orientation + Vector3.new(math.random(-45, 45), math.random(-90, 90), (math.random(-45, 45))),
    })
    v3:Play()
    v3.Completed:Once(function() -- Line: 82
        -- upvalues: TweenService (upval), Part (val), u53 (upval), u102 (val), u32 (val), u58 (upval), u108 (val)
        -- upvalues: u63 (upval), Debris (upval)
        local v1 = TweenService:Create(Part, u53, {Position = u102, Size = Vector3.new(u32 * 1.1, u32 * 0.5, u32 * 1.1)})
        v1:Play()
        v1.Completed:Once(function() -- Line: 88
            -- upvalues: TweenService (upval), Part (upval), u58 (upval), u108 (upval), u32 (upval), u63 (upval)
            -- upvalues: Debris (upval)
            local v1 = TweenService:Create(Part, u58, {Position = u108, Size = Vector3.new(u32, u32 * 0.65, u32)})
            v1:Play()
            v1.Completed:Once(function() -- Line: 94 -- upvalues: TweenService (upval), Part (upval), u63 (upval), Debris (upval)
                task.delay(0.15, function() -- Line: 95 -- upvalues: TweenService (upval), Part (upval), u63 (upval), Debris (upval)
                    TweenService:Create(Part, u63, {Transparency = 1}):Play()
                    Debris:AddItem(Part, u63.Time)
                end)
            end)
        end)
    end)
end

function u90.PlaySfx(a1) -- Line: 106 -- upvalues: t (val), Debris (val) -- types: a1: userdata
    t.strict(t.Instance)(a1)
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://74146265484496"
    Sound.PlaybackSpeed = 1 + math.random(-10, 10) / 100
    Sound.Parent = a1
    Sound:Play()
    Sound.Ended:Once(function() -- Line: 114 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
    Debris:AddItem(Sound, 5)
end

function u90.SpawnDirtChunks(a1, a2, a3) -- Line: 118
    -- upvalues: t (val), u90 (val)
    t.strict(t.Instance)(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.number)(a3)
    local v1 = math.random(6, 10)
    u90.CreateDirtChunk(a1, a2, a3)
    for i = 2, v1 do
        task.delay((i - 1) * 0.015, function() -- Line: 132 -- upvalues: u90 (upval), a1 (val), a2 (val), a3 (val)
            u90.CreateDirtChunk(a1, a2, a3)
        end)
    end
end

function u90.CreateDirtDecal(a1, a2, a3) -- Line: 137
    -- upvalues: t (val), TweenService (val), u33 (val), u38 (val), Debris (val)
    t.strict(t.Instance)(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.number)(a3)
    local u24 = a3 * 0.1
    local v1 = a3 * 0.8
    local v2 = a3 * 1.6
    local u27 = a3 * 1.4000000000000001
    local Part = Instance.new("Part")
    Part.Name = "EggPlaceDirtDecal"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(u24, v1, v1)
    Part.Color = Color3.fromRGB(101, 67, 33)
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Position = a2 - Vector3.new(0, 0.009999999776482582, 0)
    Part.Orientation = Vector3.new(0, math.random(-180, 180), 90)
    Part.Parent = a1
    TweenService:Create(Part, u33, {Transparency = 0, Size = Vector3.new(u24, v2, v2)}):Play()
    task.delay(math.random(7, 11), function() -- Line: 167 -- upvalues: TweenService (upval), Part (val), u38 (upval), u24 (val), u27 (val), Debris (upval)
        TweenService:Create(Part, u38, {Transparency = 1, Size = Vector3.new(u24, u27, u27)}):Play()
        Debris:AddItem(Part, u38.Time)
    end)
end

function u90.CreateImpactRing(a1, a2, a3) -- Line: 176
    -- upvalues: t (val), TweenService (val), u68 (val), Debris (val)
    t.strict(t.Instance)(a1)
    t.strict(t.Vector3)(a2)
    t.strict(t.number)(a3)
    local Part = Instance.new("Part")
    Part.Name = "EggPlaceImpactRing"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(a3 * 0.05, a3 * 0.3, a3 * 0.3)
    Part.Color = Color3.fromRGB(139, 90, 43)
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Transparency = 0.3
    Part.Position = a2 + Vector3.new(0, 0.019999999552965164, 0)
    Part.Orientation = Vector3.new(0, 0, 90)
    Part.Parent = a1
    TweenService:Create(Part, u68, {Transparency = 1, Size = Vector3.new(a3 * 0.05, a3 * 1.8, a3 * 1.8)}):Play()
    Debris:AddItem(Part, 0.35)
end

function u90:Play(a2, a3) -- Line: 205
    -- upvalues: t (val), EggActionMovement (val), Trove (val), u90 (val), TweenService (val), u43 (val)
    t.strict(t.instanceIsA("Model"))(self)
    t.strict(t.CFrame)(a2)
    t.strict(t.Instance)(a3)
    local PrimaryPart = self.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local u46 = math.max(math.min(PrimaryPart.Size.X, PrimaryPart.Size.Y, PrimaryPart.Size.Z), 0.1)
    local Position = a2.Position
    local u53 = a2.Position.Y + PrimaryPart.Size.Y * 0.1
    local u54 = false
    local v1 = a2 + Vector3.new(0, PrimaryPart.Size.Y * 2, 0)
    local u66 = Instance.new("CFrameValue")
    u66.Value = v1
    EggActionMovement.SetPivot(self, v1)
    local u74 = Trove.new()
    u74:Add(u66)

    local function startImpactEffects() -- Line: 226
        -- upvalues: u54 (ref), u90 (upval), a3 (val), Position (val), u46 (val)
        if u54 then
            return
        end
        u54 = true
        u90.PlaySfx(a3)
        u90.SpawnDirtChunks(a3, Position, u46)
        u90.CreateDirtDecal(a3, Position, u46)
        u90.CreateImpactRing(a3, Position, u46)
    end

    u74:Add(((u66:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 238
        -- upvalues: EggActionMovement (upval), self (val), u66 (val), u53 (val), startImpactEffects (val)
        EggActionMovement.SetPivot(self, u66.Value)
        if u66.Value.Position.Y <= u53 then
            startImpactEffects()
        end
    end)))
    local v2 = TweenService:Create(u66, u43, {Value = a2})
    v2:Play()
    v2.Completed:Once(function() -- Line: 249
        -- upvalues: EggActionMovement (upval), self (val), a2 (val), startImpactEffects (val), u74 (val)
        EggActionMovement.SetPivot(self, a2)
        startImpactEffects()
        u74:Destroy()
    end)
end

return u90