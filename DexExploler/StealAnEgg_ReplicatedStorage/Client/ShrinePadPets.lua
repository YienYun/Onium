-- Script path: ReplicatedStorage.Client.ShrinePadPets
-- Decompile time: 19.31 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local FusionShrines = require(ReplicatedStorage.Shared.FusionShrines)
local Kit = require(ReplicatedStorage.Client.ShrineFusionSequences.Kit)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u34 = table.freeze({Toss = 115818434760382, Land = 140086252907114})
local u37 = table.freeze({
    Sparkle = "rbxasset://textures/particles/sparkles_main.dds",
    Shockwave = "rbxassetid://109600784699514",
    Energy = "rbxassetid://85003420967228",
})
local u42 = Color3.new(1, 1, 1)
local LocalPlayer = Players.LocalPlayer
local u44 = {}
u44.__index = u44

local function rigTemplate(a1) -- Line: 42 -- upvalues: ReplicatedStorage (val) -- types: a1: string?
    local FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
    if FusionShrineRigs and a1 then
        return (FusionShrineRigs:FindFirstChild(a1))
    end
    return nil
end

local function padTop(a1) -- Line: 47 -- types: a1: userdata
    return a1.Position + Vector3.new(0, 1, 0) * (a1.Size.Y / 2)
end

local function footOf(a1) -- Line: 51 -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return a1:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
end

local function rootNear(a1, a2) -- Line: 56 -- upvalues: Players (val), Kit (val) -- types: a2: vector
    local PlayerByUserId = if type(a1) ~= "number" then nil else Players:GetPlayerByUserId(a1)
    local v1 = Kit.RootOf(if not PlayerByUserId then nil else PlayerByUserId.Character)
    if v1 and (v1.Position - a2).Magnitude <= 90 then
        return v1
    end
    return nil
end

function u44.Size(a1, a2) -- Line: 65 -- types: a2: string
    local Placement = a1.Placement
    if Placement then
        return Placement.Sizes[a2] or 8
    end
    return 8
end

function u44.Home(a1, a2, a3, a4) -- Line: 70 -- upvalues: Kit (val) -- types: a2: string, a3: userdata, a4: vector
    local Placement = a1.Placement
    local v1 = Placement and Placement.Hover[a2] or 0
    local v2 = a3.Position + Vector3.new(0, 1, 0) * (a3.Size.Y / 2) + Vector3.new(0, 1, 0) * v1
    local LookVector = Kit.Flat(a4 - v2)
    if LookVector.Magnitude < 0.001 then
        LookVector = a3.CFrame.LookVector
    end
    return CFrame.lookAt(v2, v2 + LookVector)
end

function u44.Template(a1) -- Line: 86 -- upvalues: ReplicatedStorage (val) -- types: a1: string?
    local FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
    if FusionShrineRigs and a1 then
        return (FusionShrineRigs:FindFirstChild(a1))
    end
    return nil
end

local function emitter(a1, a2) -- Line: 90 -- upvalues: Kit (val) -- types: a1: userdata, a2: table
    local v1 = Kit.Emitter(a1, a2)
    v1.Enabled = false
    return v1
end

local function buildHost(a1, a2, a3, a4) -- Line: 96
    -- upvalues: Kit (val), u37 (val), u42 (val)
    local Part = Kit.Part
    local v1 = {
        Transparency = 1,
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        Name = "PadPetHost_" .. a1.Name,
    }
    local new = CFrame.new
    local Pad = a1.Pad
    v1.CFrame = new(Pad.Position + Vector3.new(0, 1, 0) * (Pad.Size.Y / 2) + Vector3.new(0, 0.15000000596046448, 0))
    local v2 = Part(v1)
    v2.Parent = a3
    a4:Add(v2)
    v1 = Kit.Emitter(v2, {
        LightEmission = 1,
        LightInfluence = 0,
        ZOffset = 2,
        Texture = u37.Shockwave,
        Color = ColorSequence.new(a2),
        Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(0.01),
        Lifetime = NumberRange.new(0.55),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), (NumberSequenceKeypoint.new(1, 15))}),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.6, 0.35),
            (NumberSequenceKeypoint.new(1, 1)),
        }),
    })
    v1.Enabled = false
    local v3 = Kit.Emitter(v2, {
        Drag = 3.5,
        Acceleration = Vector3.new(0, -6, 0),
        LightEmission = 1,
        LightInfluence = 0,
        ZOffset = 1,
        Texture = u37.Sparkle,
        Color = ColorSequence.new(u42, a2),
        SpreadAngle = Vector2.new(70, 70),
        EmissionDirection = Enum.NormalId.Top,
        Speed = NumberRange.new(7, 17),
        Lifetime = NumberRange.new(0.6, 1.2),
        Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), (NumberSequenceKeypoint.new(1, 0))}),
    })
    v3.Enabled = false
    local PointLight = Instance.new("PointLight")
    PointLight.Color = a2
    PointLight.Range = 14
    PointLight.Brightness = 0
    PointLight.Shadows = false
    PointLight.Parent = v2
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "TetherBase"
    Attachment.Parent = v2
    return {
        Part = v2,
        Wave = v1,
        Sparkles = v3,
        Light = PointLight,
        Base = Attachment,
    }
end

function u44.new(a1, a2, a3, a4) -- Line: 154
    -- upvalues: Trove (val), Workspace (val), u44 (val), u42 (val), buildHost (val)
    local v1
    local v2 = Trove.new()
    local Folder = Instance.new("Folder")
    Folder.Name = "ShrinePadPets"
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    Folder.Parent = Transient
    v2:Add(Folder)
    local v3 = {
        Hidden = false,
        Model = a1,
        Kind = a2,
        Center = a4,
        Trove = v2,
        Folder = Folder,
        Slots = {},
        Leaving = {},
    }
    local u92 = setmetatable(v3, u44)
    local v4 = nil
    local v5 = nil
    for i, j in a3, v4, v5 do
        v1 = a2.Colors[j.Side] or u42
        local u50 = {Flash = 0, Slot = j}
        u50.Name = j.Name
        u50.Side = j.Side
        u50.Pad = j.Pad
        u50.Color = v1
        u50.Host = buildHost(j, v1, Folder, v2)
        u50.Prompt = j.Pad:FindFirstChild("PlacePrompt", true)
        table.insert(u92.Slots, u50)
        for k, n in {"PlacedCategory", "PlacedUserId", "PlacedAt"} do
            v2:Connect(j.Pad:GetAttributeChangedSignal(n), function() -- Line: 189 -- upvalues: u50 (val), u92 (val)
                if not u50.Queued then
                    u50.Queued = true
                    task.defer(function() -- Line: 192 -- upvalues: u50 (upval), u92 (upval)
                        u50.Queued = false
                        u92:Sync(u50)
                    end)
                end
            end)
        end
        u92:Sync(u50)
    end
    return u92
end

function u44:Silent() -- Line: 204
    local Attribute = self.Model:GetAttribute("FusionPhase")
    local Hidden = self.Hidden
    if not Hidden then
        Hidden = true
        if Attribute ~= "Ritual" then
            Hidden = Attribute == "Committing"
        end
    end
    return Hidden
end

function u44:Spawn(a2, a3, a4, a5) -- Line: 209
    -- upvalues: Assets (val), u44 (val), Kit (val), ReplicatedStorage (val), Workspace (val), Players (val), u37 (val)
    -- upvalues: u42 (val), u34 (val)
    local v1
    local v2 = Assets.Directory[a3] or {}
    local v3 = u44.Size(self.Kind, a2.Side)
    local PetModel = Kit.PetModel
    local v4 = v3
    local FusionShrineRigs = ReplicatedStorage.Assets.Models:FindFirstChild("FusionShrineRigs")
    local v5 = PetModel(a3, v4, if not FusionShrineRigs then nil else if not a3 then nil else FusionShrineRigs:FindFirstChild(a3))
    if not v5 then
        return
    end
    v3 = u44.Home(self.Kind, a2.Side, a2.Pad, self.Center)
    local BoundingBox, BoundingBox_2 = v5:GetBoundingBox()
    local v6 = v5:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
    local Scale = v5:GetScale()
    local Animations = v2.Animations or {}
    v2 = false
    if type(a5) == "number" then
        v2 = Workspace:GetServerTimeNow() - a5 < 2
    end
    if not v2 then
        v1 = nil
    else
        local Position = v3.Position
        local PlayerByUserId = if type(a4) ~= "number" then nil else Players:GetPlayerByUserId(a4)
        local v7 = Kit.RootOf(if not PlayerByUserId then nil else PlayerByUserId.Character)
        v1 = if not v7 then nil else if not ((v7.Position - Position).Magnitude <= 90) then nil else v7
    end
    v2 = {}
    v2.Model = v5
    v2.Full = Scale
    v2.Foot = v6
    v2.Home = v3
    v2.Category = a3
    v2.UserId = a4
    v2.Started = os.clock()
    v2.Mode = if not v1 then "Pop" else "Fly"
    local Position_2 = if not v1 then v3.Position else (v1.CFrame * CFrame.new(1, 0.6, -1.6)).Position
    v2.From = Position_2
    v2.Spin = if a2.Side ~= "Whale" then -1 else 1
    v5:ScaleTo(Scale * 0.2)
    v5:PivotTo(v3)
    v5.Parent = self.Folder
    v2.Track = Kit.PlayAnimation(v5, Animations.Idle or Animations.Walk, 1)
    if a2.Side == "Whale" then
        local PrimaryPart = v5.PrimaryPart or v5:FindFirstChildWhichIsA("BasePart", true)
        if PrimaryPart then
            v4 = Instance.new("Attachment")
            v4.Name = "TetherTip"
            v4.Parent = PrimaryPart
            v6 = Instance.new("Beam")
            v6.Attachment0 = a2.Host.Base
            v6.Attachment1 = v4
            v6.Texture = u37.Energy
            v6.TextureMode = Enum.TextureMode.Stretch
            v6.TextureSpeed = 1.4
            v6.Color = ColorSequence.new(a2.Color, u42)
            v6.LightEmission = 1
            v6.LightInfluence = 0
            v6.FaceCamera = true
            v6.Segments = 12
            v6.Width0 = 2.4
            v6.Width1 = 0.5
            v6.Transparency = NumberSequence.new(1)
            v6.Parent = a2.Host.Part
            v2.Beam = v6
        end
    end
    if self.Hidden then
        Kit.Hide(v5)
    end
    a2.Pet = v2
    if not self.Hidden then
        Kit.Sound(u34.Toss, if not v1 then a2.Host.Part else v1, 0.45, 1.15)
    end
end

function u44:Release(a2, a3) -- Line: 271
    -- upvalues: Players (val), Kit (val), u34 (val)
    local Pet = a2.Pet
    if not Pet then
        return
    end
    a2.Pet = nil
    if Pet.Beam then
        Pet.Beam:Destroy()
    end
    if not a3 and not self.Hidden then
        local UserId = Pet.UserId
        local Position = Pet.Model:GetPivot().Position
        local PlayerByUserId = if type(UserId) ~= "number" then nil else Players:GetPlayerByUserId(UserId)
        local v1 = Kit.RootOf(if not PlayerByUserId then nil else PlayerByUserId.Character)
        local v2 = if not v1 then nil else if not ((v1.Position - Position).Magnitude <= 90) then nil else v1
        Pet.Mode = "Leave"
        Pet.Started = os.clock()
        Pet.From = Pet.Model:GetPivot().Position
        local v3 = if not v2 then Pet.From + Vector3.new(0, 9, 0) else v2.Position + Vector3.new(0, 1.5, 0)
        Pet.To = v3
        Pet.Rotation = Pet.Model:GetPivot().Rotation
        Pet.Size = Pet.Model:GetScale()
        a2.Host.Sparkles:Emit(10)
        table.insert(self.Leaving, Pet)
        Kit.Sound(u34.Toss, a2.Host.Part, 0.35, 0.9)
        return
    end
    Pet.Model:Destroy()
end

function u44:Sync(a2) -- Line: 296
    local Pad = a2.Pad
    local Attribute = Pad:GetAttribute("PlacedCategory")
    local Attribute_2 = Pad:GetAttribute("PlacedUserId")
    local Attribute_3 = Pad:GetAttribute("PlacedAt")
    local Pet = a2.Pet
    if Pet then
        if Pet.Category ~= Attribute or Pet.UserId ~= Attribute_2 or Pet.At ~= Attribute_3 then
            self:Release(a2, (self:Silent()))
            Pet = nil
        end
    end
    if not Pet and type(Attribute) == "string" then
        self:Spawn(a2, Attribute, Attribute_2, Attribute_3)
        if a2.Pet then
            a2.Pet.At = Attribute_3
        end
    end
end

function u44.SetHidden(a1, a2) -- Line: 314 -- upvalues: Kit (val) -- types: a1: table, a2: boolean
    local Pet
    if a1.Hidden == a2 then
        return
    end
    a1.Hidden = a2
    local v1 = nil
    local v2 = nil
    local v3 = a2
    for i, j in a1.Slots, v1, v2 do
        Pet = j.Pet
        if Pet then
            if not v3 then
                Kit.Show(Pet.Model)
            else
                Kit.Hide(Pet.Model)
            end
            if Pet.Beam then
                Pet.Beam.Enabled = not v3
            end
        end
        j.Host.Light.Enabled = not v3
    end
end

local function landed(a1) -- Line: 335 -- upvalues: Kit (val), u34 (val)
    a1.Host.Wave:Emit(1)
    a1.Host.Sparkles:Emit(26)
    a1.Flash = 1
    Kit.Sound(u34.Land, a1.Host.Part, 0.6, 1)
end

function u44:StepPet(a2, a3, a4) -- Line: 342
    -- upvalues: Kit (val), u34 (val)
    local v1, v2
    local Pet = a2.Pet
    if not Pet then
        return
    end
    local Home = Pet.Home
    local v3 = Kit.ReducedMotion()
    local v4 = a4 - Pet.Started
    local v5 = 1
    local v6 = Home
    if Pet.Mode == "Fly" or Pet.Mode == "Pop" then
        v2 = Kit.Clamp01(v4 / (if Pet.Mode ~= "Fly" then 0.38 else if v3 then 0.38 else 0.62))
        if Pet.Mode ~= "Fly" or v3 then
            v5 = Kit.Lerp(0.2, 1, Kit.BackOut(v2))
            v6 = Home + Vector3.new(0, 1, 0) * ((1 - v2) * 1.5)
        else
            v1 = Kit.Ease(v2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local Magnitude = (Home.Position - Pet.From).Magnitude
            local v7 = Kit.Bezier(Pet.From, (Pet.From + Home.Position) / 2 + Vector3.new(0, 1, 0) * (5 + Magnitude * 0.3), Home.Position, v1)
            local v8 = (1 - Kit.Ease(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)) * 3.141592653589793 * 2 * Pet.Spin
            v6 = (CFrame.new(v7)) * Home.Rotation * CFrame.Angles(0, v8, 0)
            v5 = Kit.Lerp(0.2, 1, Kit.BackOut(v2))
        end
        if v2 >= 1 then
            Pet.Mode = "Settle"
            Pet.Started = a4
            if not self.Hidden then
                a2.Host.Wave:Emit(1)
                a2.Host.Sparkles:Emit(26)
                a2.Flash = 1
                Kit.Sound(u34.Land, a2.Host.Part, 0.6, 1)
            end
        end
    elseif Pet.Mode == "Settle" then
        v1 = Kit.Clamp01(v4 / 0.45)
        v2 = (math.sin(v1 * 3.141592653589793)) * (1 - v1)
        v5 = 1 + 0.14 * v2
        v6 = Home - Vector3.new(0, 1, 0) * (0.45 * v2)
        if v1 >= 1 then
            Pet.Mode = "Idle"
            Pet.Started = a4
        end
    end
    if Pet.Mode == "Idle" or Pet.Mode == "Settle" then
        local v9 = if Pet.Mode ~= "Idle" then 0 else Kit.Smooth(Kit.Clamp01(v4 / 1.2))
        if a2.Side == "Whale" and not v3 then
            v1 = math.sin(a3 * 1.7) * 0.6 * v9
            v2 = math.sin(a3 * 0.55) * 0.12 * v9
            v6 = v6 * CFrame.new(0, v1, 0) * CFrame.Angles(0, v2, 0)
        end
    end
    if Pet.Beam then
        v4 = if Pet.Mode == "Fly" then 0 else if Pet.Mode ~= "Pop" then 1 else 0
        Pet.BeamT = Kit.Lerp(Pet.BeamT or 0, v4, 0.12)
        v4 = 1 - Pet.BeamT * 0.55
        Pet.Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, v4), (NumberSequenceKeypoint.new(1, 1))})
    end
    v3 = Pet.Full * math.max(v5, 0.05)
    if 0.0001 < (math.abs(v3 - (Pet.Model:GetScale()))) then
        Pet.Model:ScaleTo(v3)
    end
    local Model = Pet.Model
    local v10 = Pet.Foot * v5
    Model:PivotTo(v6 + Vector3.new(0, 1, 0) * v10)
end

function u44.Step(a1, a2, a3) -- Line: 411 -- upvalues: Kit (val) -- types: a1: table, a2: number, a3: number
    local v1, v2, v3, v4, v5
    local v6 = os.clock()
    local Slots = a1.Slots
    local v7 = nil
    local v8 = nil
    local v9, v10, v11 = a1, a2, a3
    for i, j in Slots, v7, v8 do
        v9:StepPet(j, v10, v6)
        v1 = j.Flash - v11 * 2.4
        j.Flash = math.max(v1, 0)
        v5 = if not j.Pet then 0 else if v9.Hidden then 0 else 1.1
        j.Host.Light.Brightness = v5 + 7 * j.Flash * j.Flash
    end
    for k = #v9.Leaving, 1, -1 do
        v3 = v9.Leaving[k]
        v4 = Kit.Clamp01((v6 - v3.Started) / 0.45)
        v5 = Kit.Ease(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v2 = Kit.Bezier(v3.From, (v3.From + v3.To) / 2 + Vector3.new(0, 6, 0), v3.To, v5)
        v3.Model:ScaleTo((math.max(v3.Size * (1 - 0.85 * v5), 0.01)))
        v3.Model:PivotTo((CFrame.new(v2)) * v3.Rotation * (CFrame.Angles(0, v5 * 3.141592653589793, 0)))
        if v4 >= 1 or v9.Hidden then
            v3.Model:Destroy()
            table.remove(v9.Leaving, k)
        end
    end
end

function u44.UpdatePrompts(a1, a2, a3) -- Line: 434
    -- upvalues: LocalPlayer (val), FusionShrines (val)
    local Attribute, Prompt, v1
    local v2 = a1.Kind.Tiers[1]
    local Recipes = if not a2.Ready then nil else a2.Recipes
    local Ready = a2.Ready and a2.Status and a2.Status[v2] == "COMPLETED"
    local Copy = a1.Kind.Copy
    local v3 = {}
    local v4 = {}
    for i, j in a1.Slots do
        v4[j.Name] = j.Side
        v3[j.Name] = (j.Pad:GetAttribute("PlacedUserId"))
    end
    local Slots_2 = a1.Slots
    local v5 = nil
    local v6 = nil
    local v7, v8 = a3, a1
    for k, n in Slots_2, v5, v6 do
        Prompt = n.Prompt
        if Prompt and Prompt:IsA("ProximityPrompt") then
            Attribute = n.Pad:GetAttribute("PlacedUserId")
            Prompt.ObjectText = ("%* Pad"):format(n.Side)
            if v7 then
                Prompt.Enabled = false
            elseif Attribute == LocalPlayer.UserId then
                Prompt.ActionText = "Take Back"
                Prompt.Enabled = true
            elseif Attribute == nil then
                v1 = FusionShrines.Claim(v8.Kind, v3, v4, LocalPlayer.UserId, n.Name)
                Prompt.ActionText = if Ready then "Already Fused" else if v1 ~= "Open" then "Partner's Pad" else if not Recipes then ("Place %*"):format(n.Side) else Copy.Place(n.Side, Recipes)
                Prompt.Enabled = true
            else
                Prompt.Enabled = false
            end
        end
    end
end

function u44:Destroy() -- Line: 471
    for i, j in self.Slots do
        if j.Pet then
            j.Pet.Model:Destroy()
            j.Pet = nil
        end
    end
    for k, n in self.Leaving do
        n.Model:Destroy()
    end
    table.clear(self.Leaving)
    self.Trove:Destroy()
end

return table.freeze(u44)