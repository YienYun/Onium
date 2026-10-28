-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.MonsterDeath
-- Decompile time: 11.22 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local LocalPlayer = Players.LocalPlayer
local u54 = ReplicatedStorage.Assets.HalloweenDimension:WaitForChild("MonsterDeath")
local u55 = {Small = 1, Medium = 1.35, Large = 1.8}
local u56 = {SurfaceAppearance = true, SpecialMesh = true, Decal = true, Texture = true}
local u61 = Color3.fromRGB(255, 150, 50)
local u63 = Random.new()
local u64 = {}

local function emitters() -- Line: 70 -- upvalues: u54 (val)
    local v1 = {}
    for i, j in u54:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function popSound() -- Line: 80 -- upvalues: ReplicatedStorage (val)
    local Sounds = ReplicatedStorage.Assets:FindFirstChild("Sounds")
    local ScrambleBoss = if Sounds == nil then nil else Sounds:FindFirstChild("ScrambleBoss")
    local v1 = if ScrambleBoss == nil then nil else ScrambleBoss:FindFirstChild("Pop")
    if v1 ~= nil and v1:IsA("Sound") then
        return v1
    end
    return nil
end

local function randomFlat() -- Line: 87 -- upvalues: u63 (val)
    local v1 = u63:NextNumber(0, 6.283185307179586)
    return (Vector3.new(math.cos(v1), 0, (math.sin(v1))))
end

local function shell(a1) -- Line: 92 -- upvalues: u56 (val) -- types: a1: userdata
    local Archivable = a1.Archivable
    a1.Archivable = true
    local v1 = a1:Clone()
    a1.Archivable = Archivable
    if v1 == nil then
        return nil
    end
    for i, j in v1:GetChildren() do
        if not u56[j.ClassName] then
            j:Destroy()
        end
    end
    v1.Name = "MonsterDeathPiece"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Massless = true
    v1.LocalTransparencyModifier = 0
    return v1
end

local function scatter(a1, a2, a3) -- Line: 117
    -- upvalues: Trove (val), Workspace (val), shell (val), u63 (val), RunService (val), TweenService (val)
    local Unit, v1, v2, v3, v4
    local u134 = {}
    local u146 = Trove.new()
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and not (1 <= j.Transparency) then
            v1 = if not (#u134 < 14) then nil else shell(j)
            j.LocalTransparencyModifier = 1
            if v1 ~= nil then
                v2 = j.Position - a2
                v3 = Vector3.new(v2.X, 0, v2.Z)
                if not (0.1 < v3.Magnitude) then
                    v4 = u63:NextNumber(0, 6.283185307179586)
                    Unit = Vector3.new(math.cos(v4), 0, (math.sin(v4)))
                else
                    Unit = v3.Unit
                end
                v3 = Vector3.new(0, 1, 0) * u63:NextNumber(0.3, 0.9)
                v4 = u63:NextUnitVector()
                table.insert(u134, {
                    Part = v1,
                    Offset = v2,
                    Rotation = j.CFrame.Rotation,
                    Size = j.Size,
                    Travel = (Unit + v3).Unit * u63:NextNumber(5, 10) * a3,
                    Axis = v4,
                    Spin = (u63:NextNumber(2, 5)) * (if not ((u63:NextNumber()) < 0.5) then 1 else -1),
                })
                v1.Parent = Transient
                u146:Add(v1)
            end
        end
    end
    if #u134 == 0 then
        u146:Destroy()
        return
    end
    local u33 = os.clock()
    u146:Connect(RunService.RenderStepped, function() -- Line: 157 -- upvalues: u33 (val), u146 (val), TweenService (upval), u134 (val), a2 (val)
        local v1
        local v2 = os.clock() - u33
        if v2 >= 0.5 then
            u146:Destroy()
            return
        end
        local v3 = 0
        if not (v2 < 0.08) then
            local v4 = (v2 - 0.08) / 0.42
            v3 = TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v1 = 1.15 * (1 - TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
        else
            v1 = 1 + 0.1499999999999999 * (v2 / 0.08)
        end
        for i, j in u134 do
            v2 = a2 + j.Offset * 1.15 + j.Travel * v3
            j.Part.Size = j.Size * math.max(v1, 0.01)
            j.Part.CFrame = (CFrame.new(v2)) * CFrame.fromAxisAngle(j.Axis, j.Spin * v3) * j.Rotation
        end
    end)
end

local function glow(a1, a2) -- Line: 187
    -- upvalues: Workspace (val), u61 (val), TweenService (val), VFX (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "MonsterDeathGlow"
    Attachment.WorldPosition = a1
    Attachment.Parent = Workspace.Terrain
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u61
    PointLight.Brightness = 6
    PointLight.Range = a2 * 14
    PointLight.Shadows = false
    PointLight.Parent = Attachment
    TweenService:Create(PointLight, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {Brightness = 0, Range = PointLight.Range * 0.3}):Play()
    VFX.Discard(Attachment, 0.55)
end

local function burst(a1, a2) -- Line: 206 -- upvalues: VFX (val), emitters (val) -- types: a1: vector, a2: number
    local u4 = math.sqrt(a2)
    VFX.EmitAt(a1, emitters(), function(a1) -- Line: 208 -- upvalues: VFX (upval), a2 (val), u4 (val) -- types: a1: userdata
        VFX.Rescale(a1, a2)
        local Attribute = a1:GetAttribute("EmitCount")
        if type(Attribute) == "number" and Attribute > 2 then
            a1:SetAttribute("EmitCount", Attribute * u4)
        end
    end)
end

function u64.Play(a1, a2, a3) -- Line: 221
    -- upvalues: scatter (val), VFX (val), emitters (val), glow (val), popSound (val), Audio (val)
    if a3 ~= nil then
        scatter(a3, a1, a2)
    end
    local u11 = math.sqrt(a2)
    VFX.EmitAt(a1, emitters(), function(a1) -- Line: 208 -- upvalues: VFX (upval), a2 (val), u11 (val) -- types: a1: userdata
        VFX.Rescale(a1, a2)
        local Attribute = a1:GetAttribute("EmitCount")
        if type(Attribute) == "number" and Attribute > 2 then
            a1:SetAttribute("EmitCount", Attribute * u11)
        end
    end)
    glow(a1, a2)
    local v1 = popSound()
    if v1 ~= nil then
        Audio.Play(v1, a1, {
            Volume = 0.5,
            MaxDistance = 220,
            PlaybackSpeed = math.clamp(1.75 - a2 * 0.45, 0.8, 1.4),
        })
    end
end

function u64.NearestModel(a1, a2, a3) -- Line: 238 -- types: a1: userdata?, a2: vector, a3: number
    local Magnitude
    if a1 == nil then
        return nil
    end
    local v1 = nil
    for i, j in a1:GetChildren() do
        if j:IsA("Model") then
            Magnitude = (j:GetPivot().Position - a2).Magnitude
            if Magnitude <= a3 then
                v1 = j
            end
        end
    end
    return v1
end

function u64.Start(a1) -- Line: 257
    -- upvalues: u55 (val), u64 (val), LocalPlayer (val), Shake (val), CollectionService (val)
    local u1 = {}

    local function watch(a1_2) -- Line: 268
        -- upvalues: u1 (val), a1 (val), u55 (upval), u64 (upval), LocalPlayer (upval), Shake (upval)
        if a1_2:IsA("Model") and u1[a1_2] == nil then
            local v1 = a1:Extend()
            u1[a1_2] = v1
            v1:Connect(a1_2:GetAttributeChangedSignal("KilledBy"), function() -- Line: 276
                -- upvalues: a1_2 (val), u1 (upval), a1 (upval), u55 (upval), u64 (upval), LocalPlayer (upval)
                -- upvalues: Shake (upval)
                local Attribute = a1_2:GetAttribute("KilledBy")
                if type(Attribute) ~= "number" then
                    return
                end
                local v1 = a1_2
                local v2 = u1[v1]
                if v2 ~= nil then
                    u1[v1] = nil
                    a1:Remove(v2)
                end
                local Attribute_2 = a1_2:GetAttribute("MonsterSize")
                v2 = not (type(Attribute_2) ~= "string") and u55[Attribute_2] or 1
                u64.Play(a1_2:GetBoundingBox().Position, v2, a1_2)
                if Attribute == LocalPlayer.UserId then
                    Shake.Play({Seconds = 0.35, Shape = "Fade", Magnitude = 0.3 * v2})
                end
            end)
            return
        end
    end

    a1:Connect(CollectionService:GetInstanceAddedSignal("HalloweenMonster"), watch)
    a1:Connect(CollectionService:GetInstanceRemovedSignal("HalloweenMonster"), function(a1_2) -- Line: 260 -- upvalues: u1 (val), a1 (val) -- types: a1_2: userdata
        local v1 = u1[a1_2]
        if v1 ~= nil then
            u1[a1_2] = nil
            a1:Remove(v1)
        end
    end)
    for i, j in CollectionService:GetTagged("HalloweenMonster") do
        watch(j)
    end
    a1:Add(function() -- Line: 301 -- upvalues: u1 (val)
        table.clear(u1)
    end)
end

return u64