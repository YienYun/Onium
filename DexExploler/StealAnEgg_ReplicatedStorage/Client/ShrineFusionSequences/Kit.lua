-- Script path: ReplicatedStorage.Client.ShrineFusionSequences.Kit
-- Decompile time: 12.42 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Assets = require(ReplicatedStorage.Data.Assets)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u37 = {}
local u41 = setmetatable({}, {__mode = "k"})
local u45 = setmetatable({}, {__mode = "k"})
local u49 = setmetatable({}, {__mode = "k"})

function u37.Lerp(a1, a2, a3) -- Line: 18 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

function u37.Clamp01(a1) -- Line: 22 -- types: a1: number
    return (math.clamp(a1, 0, 1))
end

function u37.Smooth(a1) -- Line: 26 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

function u37.Window(a1, a2, a3) -- Line: 31 -- types: a1: number, a2: number, a3: number
    return (math.clamp((a1 - a2) / math.max(a3 - a2, 0.001), 0, 1))
end

function u37.BackOut(a1) -- Line: 35 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1) - 1
    return v1 * 2.70158 * v1 * v1 + 1 + v1 * 1.70158 * v1
end

function u37.Ease(a1, a2, a3) -- Line: 42 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2, a3)
end

function u37.Bezier(a1, a2, a3, a4) -- Line: 46 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

function u37.Flat(a1) -- Line: 51 -- types: a1: vector
    local v1 = a1 * Vector3.new(1, 0, 1)
    if 0.001 < v1.Magnitude then
        return v1.Unit
    end
    return (Vector3.new(0, 0, 1))
end

function u37.ReducedMotion() -- Line: 56 -- upvalues: GuiService (val)
    local success, err = pcall(function() -- Line: 57 -- upvalues: GuiService (upval)
        return GuiService.ReducedMotionEnabled
    end)
    return success and err == true
end

function u37.Part(a1) -- Line: 63 -- types: a1: table?
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Locked = true
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    for i, j in a1 or {} do
        Part[i] = j
    end
    return Part
end

function u37.Emitter(a1, a2) -- Line: 79 -- types: a1: userdata, a2: table
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Rate = 0
    ParticleEmitter.Enabled = false
    for i, j in a2 do
        ParticleEmitter[i] = j
    end
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

function u37.Freeze(a1) -- Line: 92 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.Massless = true
        elseif j:IsA("BillboardGui") or j:IsA("SurfaceGui") or j:IsA("ProximityPrompt") then
            j.Enabled = false
        elseif j:IsA("Script") then
            j:Destroy()
        end
    end
end

function u37.Normalize(a1, a2) -- Line: 112 -- types: a1: userdata, a2: number
    local BoundingBox_2
    _, BoundingBox_2 = a1:GetBoundingBox()
    local v1 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
    if v1 > 0.01 then
        a1:ScaleTo((math.clamp((a1:GetScale()) * (a2 / v1), 0.01, 50)))
    end
end

function u37.PetModel(a1, a2, a3) -- Line: 120
    -- upvalues: ReplicatedStorage (val), u37 (val)
    local v1 = a3 or (if not a1 then nil else ReplicatedStorage.AssetModels:FindFirstChild(a1))
    if v1 and v1:IsA("Model") then
        local v2 = v1:Clone()
        u37.Freeze(v2)
        for i, j in v2:GetDescendants() do
            if j:IsA("Beam") then
                j.Enabled = false
            end
        end
        v1 = v2:FindFirstChild("HumanoidRootPart")
        if v1 and v1:IsA("BasePart") then
            v2.PrimaryPart = v1
            v1.Transparency = 1
        end
        u37.Normalize(v2, a2)
        return v2
    end
    return nil
end

local function eggTemplate(a1) -- Line: 142
    -- upvalues: Assets (val), ReplicatedStorage (val), EggRecords (val)
    local v1 = if not a1 then nil else Assets.Directory[a1]
    local ModelName = if not v1 then a1 else if not v1.Egg then a1 else v1.Egg.ModelName
    v1 = if not ModelName then nil else ReplicatedStorage.Assets.Models.Eggs:FindFirstChild(ModelName)
    if v1 then
        return v1
    end
    local success, err = pcall(EggRecords.EggModelTemplate, a1)
    if success and typeof(err) == "Instance" then
        return err
    end
    return nil
end

function u37.EggModel(a1, a2, a3) -- Line: 153
    -- upvalues: eggTemplate (val), u37 (val)
    local v1
    local v2 = eggTemplate(a1)
    if not v2 or not v2:IsA("Model") then
        v1 = Instance.new("Model")
        local Part = u37.Part
        local v3 = {
            Size = Vector3.new(2.5999999046325684, 3.200000047683716, 2.5999999046325684),
            Shape = Enum.PartType.Ball,
            Material = Enum.Material.Neon,
            Color = a3,
        }
        Part(v3).Parent = v1
    else
        v1 = v2:Clone()
    end
    u37.Freeze(v1)
    v1.PrimaryPart = nil
    v1.WorldPivot = v1:GetBoundingBox()
    u37.Normalize(v1, a2)
    return v1
end

function u37.PlayAnimation(a1, a2, a3) -- Line: 176 -- types: a1: userdata, a3: number?
    if typeof(a2) == "Instance" and a2:IsA("Animation") then
        local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
        local Animator = if not AnimationController then nil else AnimationController:FindFirstChildOfClass("Animator")
        if not Animator then
            return nil
        end
        local success, err = pcall(function() -- Line: 185 -- upvalues: Animator (val), a2 (val)
            return Animator:LoadAnimation(a2)
        end)
        if success and err then
            err.Looped = true
            err:Play(0.2, 1, a3 or 1)
            return err
        end
        return nil
    end
    return nil
end

function u37.Sound(a1, a2, a3, a4) -- Line: 196 -- upvalues: Audio (val) -- types: a1: number?, a3: number?, a4: number?
    if not a1 then
        return nil
    end
    local success, err = pcall(Audio.Play, a1, a2, {MaxDistance = 260, Volume = a3 or 1, PlaybackSpeed = a4 or 1})
    if success and typeof(err) == "Instance" then
        return err
    end
    return nil
end

local function switchable(a1) -- Line: 208 -- types: a1: userdata
    return a1:IsA("ParticleEmitter") or a1:IsA("Beam") or a1:IsA("Trail") or a1:IsA("Light") or a1:IsA("Highlight") or a1:IsA("Fire") or a1:IsA("Smoke") or a1:IsA("Sparkles")
end

local function hideItem(a1) -- Line: 219
    -- upvalues: u41 (val), u49 (val), switchable (val), u45 (val)
    if a1:IsA("BasePart") then
        u41[a1] = true
        a1.LocalTransparencyModifier = 1
        return
    end
    if a1:IsA("Decal") then
        if u49[a1] == nil then
            u49[a1] = a1.Transparency
        end
        a1.Transparency = 1
        return
    end
    if switchable(a1) then
        if u45[a1] == nil then
            u45[a1] = a1.Enabled
        end
        a1.Enabled = false
    end
end

local function showItem(a1) -- Line: 236
    -- upvalues: u41 (val), u49 (val), switchable (val), u45 (val)
    local v1
    if a1:IsA("BasePart") then
        if not u41[a1] then
            return
        end
        u41[a1] = nil
        a1.LocalTransparencyModifier = 0
        return
    end
    if a1:IsA("Decal") then
        v1 = u49[a1]
        if v1 == nil then
            return
        end
        a1.Transparency = v1
        u49[a1] = nil
        return
    end
    if switchable(a1) then
        v1 = u45[a1]
        if v1 ~= nil then
            a1.Enabled = v1
            u45[a1] = nil
        end
    end
end

function u37.Hide(a1) -- Line: 257 -- upvalues: hideItem (val) -- types: a1: userdata
    hideItem(a1)
    for i, j in a1:GetDescendants() do
        hideItem(j)
    end
end

function u37.Show(a1) -- Line: 264 -- upvalues: showItem (val) -- types: a1: userdata
    showItem(a1)
    for i, j in a1:GetDescendants() do
        showItem(j)
    end
end

local u73 = {}
u73.__index = u73

function u37.ToolGuard(a1) -- Line: 274
    -- upvalues: Trove (val), u73 (val), u37 (val), hideItem (val)
    local v1 = {Revealed = false, Trove = Trove.new(), Tools = {}}
    local u8 = setmetatable(v1, u73)
    if not a1 then
        return u8
    end

    local function cover(a1) -- Line: 279 -- upvalues: u8 (val), u37 (upval), hideItem (upval) -- types: a1: userdata
        if a1:IsA("Tool") and not u8.Tools[a1] then
            u8.Tools[a1] = true
            u37.Hide(a1)
            u8.Trove:Connect(a1.DescendantAdded, function(a1) -- Line: 285 -- upvalues: u8 (upval), hideItem (upval)
                if not u8.Revealed then
                    hideItem(a1)
                end
            end)
            return
        end
    end

    u8.Held = a1:FindFirstChildOfClass("Tool")
    for i, j in a1:GetChildren() do
        cover(j)
    end
    u8.Trove:Connect(a1.ChildAdded, function(a1) -- Line: 296 -- upvalues: u8 (val), cover (val)
        if not u8.Revealed then
            cover(a1)
        end
    end)
    return u8
end

function u73:Reveal() -- Line: 304 -- upvalues: u37 (val)
    if self.Revealed then
        return
    end
    self.Revealed = true
    self.Trove:Clean()
    for i in self.Tools do
        if i.Parent then
            u37.Show(i)
        end
    end
    table.clear(self.Tools)
end

function u73:Destroy() -- Line: 318
    self:Reveal()
end

local u77 = {}
u77.__index = u77

function u37.Ring(a1, a2, a3, a4) -- Line: 325
    -- upvalues: u37 (val), u77 (val)
    local Attachment, Beam
    local v1 = u37.Part({
        Name = "FusionRing",
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
    })
    local v2 = {}
    for i = 1, 4 do
        Attachment = Instance.new("Attachment")
        Attachment.Parent = v1
        v2[i] = Attachment
    end
    local v3 = {}
    for j = 1, 4 do
        Beam = Instance.new("Beam")
        Beam.Attachment0 = v2[j]
        Beam.Attachment1 = v2[j % 4 + 1]
        Beam.Color = ColorSequence.new(a2)
        Beam.LightEmission = 1
        Beam.LightInfluence = 0
        Beam.FaceCamera = false
        Beam.Segments = a4 or 12
        Beam.Width0 = a3
        Beam.Width1 = a3
        Beam.Parent = v1
        v3[j] = Beam
    end
    v1.Parent = a1
    local v4 = {Host = v1, Points = v2, Beams = v3}
    local v5 = setmetatable(v4, u77)
    v5:Set(CFrame.identity, 1, 1)
    return v5
end

function u77:Set(a2, a3, a4, a5) -- Line: 354 -- types: self: table, a2: userdata, a3: number, a4: number, a5: number?
    local v1, v2, v3
    self.Host.CFrame = a2
    local v4 = a3 * 0.5523
    for i, j in self.Points do
        v1 = (i - 1) * 3.141592653589793 / 2
        v2 = Vector3.new(math.cos(v1), 0, (math.sin(v1)))
        v3 = Vector3.new(-math.sin(v1), 0, (math.cos(v1)))
        j.CFrame = CFrame.fromMatrix(v2 * a3, v3, v2)
    end
    for k, n in self.Beams do
        n.CurveSize0 = v4
        n.CurveSize1 = v4
        n.Transparency = NumberSequence.new((math.clamp(a4, 0, 1)))
        if a5 then
            n.Width0 = a5
            n.Width1 = a5
        end
    end
end

function u77.Style(a1, a2) -- Line: 374 -- types: a1: table, a2: table
    local v1 = nil
    local v2 = nil
    for i, j in a1.Beams, v1, v2 do
        for k, n in a2 do
            j[k] = n
        end
    end
end

function u77.SetColor(a1, a2) -- Line: 382 -- types: a1: table, a2: CFrame
    for i, j in a1.Beams do
        j.Color = ColorSequence.new(a2)
    end
end

function u77:Destroy() -- Line: 388
    self.Host:Destroy()
end

function u37.LocalPlayerCharacter() -- Line: 392 -- upvalues: Players (val)
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer then
        return LocalPlayer.Character
    end
    return nil
end

function u37.RootOf(a1) -- Line: 397 -- types: a1: userdata?
    local HumanoidRootPart = if not a1 then nil else a1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

return table.freeze(u37)