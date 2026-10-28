-- Script path: ReplicatedStorage.Client.ShrineFusionSequence
-- Decompile time: 53.69 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggEnergyOrbField = require(ReplicatedStorage.Shared.Eggs.EggEnergyOrbField)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local Particles = ReplicatedStorage.Assets.Particles
local Eggs = ReplicatedStorage.Assets.Models.Eggs
local RiftTradeIn = ReplicatedStorage.Assets.VFX.RiftTradeIn
local u66 = {}
u66.Light = Color3.fromRGB(255, 209, 74)
u66.Dark = Color3.fromRGB(168, 26, 22)
local u77 = {}
u77.Light = {Color3.fromRGB(255, 250, 214), (Color3.fromRGB(255, 198, 44))}
u77.Dark = {Color3.fromRGB(196, 40, 30), (Color3.fromRGB(84, 6, 12))}
local u104 = Color3.new(1, 1, 1)
local u105 = {}
local u107 = Random.new()
local u108 = nil

local function fuseTrack(a1) -- Line: 121 -- upvalues: Audio (val)
    local success, err = pcall(Audio.Play, "rbxassetid://77717392679794", a1.Center, {Volume = 1})
    if success and typeof(err) == "Instance" then
        a1.Trove:Add(function() -- Line: 126 -- upvalues: err (val)
            err:Stop()
        end)
        return
    end
end

local function debris() -- Line: 131 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("Transient") or Workspace
end

local function bezier(a1, a2, a3, a4) -- Line: 135 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function lerp(a1, a2, a3) -- Line: 140 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

local function backOut(a1) -- Line: 144 -- types: a1: number
    local v1 = a1 - 1
    return v1 * 2.70158 * v1 * v1 + 1 + v1 * 1.70158 * v1
end

local function quadIn(a1) -- Line: 151 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end

local function quadInOut(a1) -- Line: 155 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
end

local function cubicIn(a1) -- Line: 159 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(a1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
end

local function freeze(a1) -- Line: 163 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.Massless = true
            j.LocalTransparencyModifier = 0
        end
    end
end

local function detach(a1) -- Line: 176 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("JointInstance")
            or j:IsA("WeldConstraint")
            or j:IsA("NoCollisionConstraint")
            or j:IsA("Constraint") then
            j:Destroy()
        elseif j:IsA("BillboardGui") or j:IsA("SurfaceGui") or j:IsA("ProximityPrompt") then
            j.Enabled = false
        end
    end
end

local function normalizeProp(a1, a2) -- Line: 193 -- types: a1: userdata, a2: number
    a1.PrimaryPart = nil
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    a1.WorldPivot = BoundingBox
    local v1 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
    if v1 > 0.01 then
        a1:ScaleTo((math.clamp((a1:GetScale()) * (a2 / v1), 0.01, 50)))
    end
end

local u123 = setmetatable({}, {__mode = "k"})
local u127 = setmetatable({}, {__mode = "k"})
local u131 = setmetatable({}, {__mode = "k"})
local u135 = setmetatable({}, {__mode = "k"})

local function switchable(a1) -- Line: 208 -- types: a1: userdata
    return a1:IsA("ParticleEmitter") or a1:IsA("Beam") or a1:IsA("Trail") or a1:IsA("Light") or a1:IsA("Highlight") or a1:IsA("Fire") or a1:IsA("Smoke") or a1:IsA("Sparkles")
end

local function hideItem(a1) -- Line: 219
    -- upvalues: u135 (val), u123 (val), u131 (val), switchable (val), u127 (val)
    if a1:IsA("BasePart") then
        u135[a1] = true
        a1.LocalTransparencyModifier = 1
        return
    end
    if not a1:IsA("BillboardGui") and not a1:IsA("SurfaceGui") then
        if a1:IsA("Decal") then
            if u131[a1] == nil then
                u131[a1] = a1.Transparency
            end
            a1.Transparency = 1
            return
        end
        if switchable(a1) then
            if u127[a1] == nil then
                u127[a1] = a1.Enabled
            end
            a1.Enabled = false
            if a1:IsA("ParticleEmitter") then
                a1:Clear()
            end
        end
        return
    end
    if u123[a1] == nil then
        u123[a1] = a1.Enabled
    end
    a1.Enabled = false
end

local function showItem(a1) -- Line: 245
    -- upvalues: u135 (val), u123 (val), u131 (val), switchable (val), u127 (val)
    local v1
    if a1:IsA("BasePart") then
        u135[a1] = nil
        a1.LocalTransparencyModifier = 0
        return
    end
    if not a1:IsA("BillboardGui") and not a1:IsA("SurfaceGui") then
        if a1:IsA("Decal") then
            v1 = u131[a1]
            a1.Transparency = if v1 == nil then 0 else v1
            u131[a1] = nil
            return
        end
        if switchable(a1) then
            v1 = u127[a1]
            a1.Enabled = if v1 == nil then true else v1
            u127[a1] = nil
        end
        return
    end
    v1 = u123[a1]
    a1.Enabled = if v1 == nil then true else v1
    u123[a1] = nil
end

local function setToolVisibility(a1, a2) -- Line: 265
    -- upvalues: hideItem (val), showItem (val)
    if not a1 then
        return
    end
    for i, j in a1:GetDescendants() do
        if not a2 then
            showItem(j)
        else
            hideItem(j)
        end
    end
end

local function eggTemplate(a1, a2) -- Line: 278 -- upvalues: Eggs (val) -- types: a1: string?, a2: string
    local v1 = a1 or "Fused " .. a2
    local v2 = Eggs:FindFirstChild(v1)
    if v2 and v2:IsA("Model") then
        return v2
    end
    warn("[ShrineFusionSequence] missing fused egg model:", v1)
    return nil
end

local function fallbackProp(a1) -- Line: 288 -- types: a1: CFrame
    local Model = Instance.new("Model")
    local Part = Instance.new("Part")
    Part.Shape = Enum.PartType.Ball
    Part.Material = Enum.Material.Neon
    Part.Color = a1
    Part.Size = Vector3.new(2.5999999046325684, 2.5999999046325684, 2.5999999046325684)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Parent = Model
    Model.WorldPivot = Part.CFrame
    return Model
end

local function tintEmitters(a1, a2, a3) -- Line: 304 -- types: a1: userdata, a2: CFrame, a3: CFrame
    local v1 = ColorSequence.new({
        ColorSequenceKeypoint.new(0, a2),
        ColorSequenceKeypoint.new(0.4, a2:Lerp(a3, 0.65)),
        (ColorSequenceKeypoint.new(1, a3)),
    })
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Trail") then
            j.Color = v1
        end
    end
end

local function chargeHost(a1) -- Line: 317 -- upvalues: Particles (val) -- types: a1: CFrame
    local v1
    local AssetAnimation = Particles:FindFirstChild("AssetAnimation")
    local Part = if not AssetAnimation then nil else AssetAnimation:FindFirstChild("Part")
    if not Part or not Part:IsA("BasePart") then
        v1 = Instance.new("Part")
        v1.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        v1.Transparency = 1
    else
        for i, j in (Part:Clone()):GetDescendants() do
            if j:IsA("ParticleEmitter") then
                j.Color = ColorSequence.new(a1)
            end
        end
    end
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    local v2 = v1:FindFirstChild("Enable")
    if not v2 then
        v2 = Instance.new("Attachment")
        v2.Name = "Enable"
        v2.Parent = v1
    end
    local v3 = v1:FindFirstChild("Emit")
    local v4 = v1
    local v5 = v2
    if v3 and v3:IsA("Attachment") then
        return v4, v5, v3
    end
    return v4, v5, nil
end

local function rootOf(a1) -- Line: 348 -- types: a1: userdata?
    if not a1 then
        return nil
    end
    local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function orbitOffset(a1, a2, a3, a4) -- Line: 356 -- types: a2: number, a3: number, a4: number
    local v1 = (a1.PlaneU * math.cos(a2) + a1.PlaneV * math.sin(a2)) * a3
    if a4 > 0.001 then
        v1 = CFrame.fromAxisAngle(a1.PlaneU, a4) * v1
    end
    return v1
end

local function hideNewTools(a1, a2, a3) -- Line: 364 -- upvalues: hideItem (val) -- types: a3: userdata
    if a3:IsA("Tool") and a3 ~= a2.Tool and not a2.Arrived and not a2.NewTools[a3] then
        if a3 then
            for i, j in a3:GetDescendants() do
                hideItem(j)
            end
        end
        local v1 = a3.DescendantAdded:Connect(function(a1) -- Line: 369 -- upvalues: a2 (val), hideItem (upval)
            if not a2.Arrived then
                hideItem(a1)
            end
        end)
        a2.NewTools[a3] = v1
        a1.Trove:Add(v1)
        return
    end
end

local function sweepTools(a1, a2) -- Line: 378 -- upvalues: hideNewTools (val), hideItem (val)
    local Character = a2.Character
    if Character and not a2.Arrived then
        for i, j in Character:GetChildren() do
            hideNewTools(a1, a2, j)
        end
        local Tool = a2.Tool
        if not Tool then
            return
        end
        for k, n in Tool:GetDescendants() do
            hideItem(n)
        end
        return
    end
end

local function buildSide(a1, a2, a3) -- Line: 389
    -- upvalues: Players (val), u66 (val), hideItem (val), hideNewTools (val), Eggs (val), fallbackProp (val)
    -- upvalues: detach (val), freeze (val), chargeHost (val), u104 (val), EggEnergyOrbField (val), u107 (val)
    local v1, v2, v3, v4
    local Character = if not Players.LocalPlayer then nil else Players.LocalPlayer.Character
    local u9 = {Arrived = false, Name = a2, Character = a3}
    u9.Color = u66[a2]
    u9.NewTools = {}
    local v5 = false
    if a3 ~= nil then
        v5 = true
        if a3 ~= Character then
            v5 = a3 == a1.TrackCharacter
        end
    end
    u9.Mine = v5
    local v6 = a1.Pads[a2]
    v5 = nil
    if a3 then
        local Tool = a3:FindFirstChildOfClass("Tool")
        if Tool then
            u9.Tool = Tool
            v5 = Tool:FindFirstChildOfClass("Model")
            u9.ToolWatch = Tool.DescendantAdded:Connect(function(a1_2) -- Line: 406 -- upvalues: a1 (val), hideItem (upval)
                if not a1.Dead then
                    hideItem(a1_2)
                end
            end)
            a1.Trove:Add(u9.ToolWatch)
        end
        a1.Trove:Connect(a3.ChildAdded, function(a1_2) -- Line: 413 -- upvalues: hideNewTools (upval), a1 (val), u9 (val)
            hideNewTools(a1, u9, a1_2)
        end)
    end
    if not v5 then
        v3 = v6.CFrame * CFrame.new(0, 3, 0)
        local FusedCategory = a1.FusedCategory
        local Tier = a1.Tier
        local v7 = FusedCategory or "Fused " .. Tier
        local v8 = Eggs:FindFirstChild(v7)
        if not v8 or not v8:IsA("Model") then
            warn("[ShrineFusionSequence] missing fused egg model:", v7)
            v4 = nil
        else
            v4 = v8
        end
        v2 = if not v4 then fallbackProp(u9.Color) else v4:Clone()
    else
        v3 = v5:GetPivot()
        v2 = v5:Clone()
    end
    detach(v2)
    freeze(v2)
    v2.PrimaryPart = nil
    local BoundingBox, BoundingBox_2 = v2:GetBoundingBox()
    v2.WorldPivot = BoundingBox
    local v9 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
    if v9 > 0.01 then
        v2:ScaleTo((math.clamp((v2:GetScale()) * (6.2 / v9), 0.01, 50)))
    end
    v2:PivotTo(v3)
    v2.Parent = a1.Container
    u9.Prop = v2
    u9.Origin = v3.Position
    local Tool_2 = u9.Tool
    if Tool_2 then
        for i, j in Tool_2:GetDescendants() do
            hideItem(j)
        end
    end
    v4, v9, v1 = chargeHost(u9.Color)
    v4.CFrame = CFrame.new(v3.Position)
    v4.Parent = a1.Container
    u9.Host = v4
    u9.HostEnable = v9
    u9.HostEmit = v1
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, 3.0999999046325684, 0)
    Attachment.Parent = v4
    v3 = Instance.new("Attachment")
    v3.Position = Vector3.new(0, -3.0999999046325684, 0)
    v3.Parent = v4
    v2 = Instance.new("Trail")
    v2.Attachment0 = Attachment
    v2.Attachment1 = v3
    v2.Color = ColorSequence.new(u9.Color)
    v2.Transparency = NumberSequence.new(0.25, 1)
    v2.WidthScale = NumberSequence.new(1, 0)
    v2.Lifetime = 0.35
    v2.LightEmission = 1
    v2.LightInfluence = 0
    v2.FaceCamera = true
    v2.MinLength = 0
    v2.Parent = v4
    u9.Trail = v2
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = v9
    Beam.Attachment1 = a1.CoreAttachment
    Beam.Color = ColorSequence.new(u9.Color, u104)
    Beam.Transparency = NumberSequence.new(0.5)
    Beam.Width0 = 0.05
    Beam.Width1 = 0.25
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.FaceCamera = true
    Beam.Segments = 12
    Beam.Parent = v4
    u9.Beam = Beam
    u9.BeamSign = if a2 ~= "Light" then -1 else 1
    v1 = EggEnergyOrbField.new(a1.Container, u9.Color)
    a1.Trove:Add(v1)
    u9.Field = v1
    u9.Theta = if a2 ~= "Light" then 3.141592653589793 else 0
    u9.Roll = u107:NextNumber(0, 6.283185307179586)
    u9.BobPhase = if a2 ~= "Light" then 2.199114857512855 else 0
    return u9
end

local function revealSide(a1) -- Line: 488 -- upvalues: showItem (val)
    a1.Arrived = true
    if a1.ToolWatch then
        a1.ToolWatch:Disconnect()
    end
    local Tool = a1.Tool
    if Tool then
        for i, j in Tool:GetDescendants() do
            showItem(j)
        end
    end
    local v1 = nil
    local v2 = nil
    for k, n in a1.NewTools, v1, v2 do
        n:Disconnect()
        if k then
            for m, i5 in k:GetDescendants() do
                showItem(i5)
            end
        end
    end
    table.clear(a1.NewTools)
end

local function finish(a1) -- Line: 501 -- upvalues: u108 (ref), revealSide (val)
    if u108 ~= a1 then
        return
    end
    u108 = nil
    a1.Dead = true
    revealSide(a1.Sides.Light)
    revealSide(a1.Sides.Dark)
    a1.Trove:Clean()
end

local function propPivot(a1, a2, a3, a4) -- Line: 512 -- upvalues: u107 (val) -- types: a3: vector, a4: number
    local v1 = (CFrame.lookAt(a3, (Vector3.new(a1.Center.X, a3.Y, a1.Center.Z)))) * CFrame.Angles(a2.Roll, 0, 0)
    if a4 > 0.001 then
        v1 = v1 * CFrame.new(u107:NextNumber(-1, 1) * 0.5 * a4, u107:NextNumber(-1, 1) * 0.5 * a4, u107:NextNumber(-1, 1) * 0.5 * a4) * CFrame.Angles(math.rad((u107:NextNumber(-1, 1)) * 22 * a4), 0, (math.rad((u107:NextNumber(-1, 1)) * 22 * a4)))
    end
    return v1
end

local function pushImpulse(a1, a2) -- Line: 531 -- upvalues: u107 (val) -- types: a2: number
    local Impulses = a1.Impulses
    if not Impulses then
        return
    end
    local v1 = a1.ImpulseSlot or 1
    local v2 = Impulses[v1]
    if not v2 then
        Impulses[v1] = {}
    end
    v2.At = os.clock()
    v2.Life = 0.34 * u107:NextNumber(0.8, 1.3)
    v2.Power = a2
    v2.Dir = Vector3.new(u107:NextNumber(-1, 1), u107:NextNumber(-1, 1), (u107:NextNumber(-0.4, 0.4)))
    v2.Spin = Vector3.new(u107:NextNumber(-1, 1), u107:NextNumber(-1, 1), (u107:NextNumber(-1, 1)))
    a1.ImpulseSlot = v1 % 8 + 1
end

local function stepSession(a1, a2) -- Line: 550
    -- upvalues: Workspace (val), u105 (val), TweenService (val), pushImpulse (val), u107 (val), Shake (val)
    -- upvalues: propPivot (val), u66 (val), u104 (val)
    if not a1.Dead and not a1.Resolving then
        local Center, Origin, Theta, v1, v2, v3, v4, v5, v6, v7
        if not a1.Shrine:IsDescendantOf(Workspace) then
            u105.Cancel()
            return
        end
        local ServerTimeNow = Workspace:GetServerTimeNow()
        if a1.EndsAt + 6 < ServerTimeNow then
            u105.Cancel()
            return
        end
        local v8 = os.clock()
        local v9 = math.max(a1.EndsAt - a1.StartAt, 0.5)
        local v10 = math.clamp((ServerTimeNow - a1.StartAt) / v9, 0, 1)
        v9 = math.clamp((ServerTimeNow - a1.StartAt) / a1.LiftSeconds, 0, 1)
        local v11 = a1.EndsAt - a1.ShakeLead
        local v12 = math.clamp((ServerTimeNow - a1.StartAt - a1.LiftSeconds) / math.max(v11 - a1.StartAt - a1.LiftSeconds, 0.1), 0, 1)
        local v13 = math.clamp((ServerTimeNow - v11) / a1.ShakeLead, 0, 1)
        v11 = TweenService:GetValue(v13, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
        a1.ShakeIntensity = v11
        a1.CamRumble = v9 * (TweenService:GetValue(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.In) * 0.42000000000000004 + 0.04)
        if not (v11 > 0.02) then
            a1.NextImpulse = v8
        elseif (a1.NextImpulse or 0) <= v8 then
            pushImpulse(a1, v11 * 0.75 + 0.3)
            a1.NextImpulse = v8 + (v11 * -0.265 + 0.34) * u107:NextNumber(0.75, 1.3)
        end
        local v14 = TweenService:GetValue(v12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        a1.Theta = a1.Theta + (v14 * 6.8 + 1.7) * a2
        local v15 = v14 * -3.3 + 5.6
        if v13 > 0 then
            v1 = v15
            local Value = TweenService:GetValue(math.min(v13 / 0.35, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            v15 = v1 + (1.2 - v1) * Value
        end
        local v16 = v14 * 0.24434609527920614
        v14 = TweenService:GetValue(math.max(v12, v13), Enum.EasingStyle.Quad, Enum.EasingDirection.In) * 5.4 + 1.1
        if v13 > 0.12 and not a1.Absorbing then
            a1.Absorbing = true
            if not a1.Participant then
                Shake.Play({
                    Magnitude = 0.8,
                    Seconds = a1.ShakeLead + 0.8,
                    Range = {Near = 24, Far = 90, Center = a1.Center},
                })
            end
            for i, j in {"Light", "Dark"} do
                local Field = a1.Sides[j].Field
                task.spawn(function() -- Line: 612 -- upvalues: Field (val), a1 (val)
                    pcall(function() -- Line: 613 -- upvalues: Field (upval), a1 (upval)
                        Field:Absorb(a1.Center, a1.ShakeLead * 0.8)
                    end)
                end)
            end
        end
        v1 = {}
        v1[1] = "Light"
        v1[2] = "Dark"
        local v17 = nil
        local v18 = nil
        for k, n in v1, v17, v18 do
            v2 = a1.Sides[n]
            Theta = a1.Theta
            v3 = Theta + (if n ~= "Light" then 3.141592653589793 else 0)
            v4 = math.sin(v8 * 2.6 + v2.BobPhase) * 0.55 * (1 - v12 * 0.6) * (1 - v13)
            Center = a1.Center
            v7 = (a1.PlaneU * math.cos(v3) + a1.PlaneV * math.sin(v3)) * v15
            if v16 > 0.001 then
                v7 = CFrame.fromAxisAngle(a1.PlaneU, v16) * v7
            end
            v5 = Center + v7 + Vector3.new(0, v4, 0)
            if not (v9 < 1) then
                v6 = v5
            else
                v4 = TweenService:GetValue(v9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                Origin = v2.Origin
                v7 = v2.Origin + Vector3.new(0, 3.200000047683716, 0)
                v3 = 1 - v4
                v6 = Origin * (v3 * v3) + v7 * (v3 * 2 * v4) + v5 * (v4 * v4)
            end
            v2.Roll = v2.Roll + v14 * v19
            v5 = propPivot(a1, v2, v6, v11)
            v2.Pivot = v5
            if v2.Prop.Parent then
                v2.Prop:PivotTo(v5)
            end
            v2.Host.CFrame = CFrame.new(v6)
            v2.Beam.Width0 = v10 * 0.3 + 0.05
            v2.Beam.Width1 = v10 * 0.6000000000000001 + 0.2
            v2.Beam.CurveSize0 = math.sin(v8 * 1.9 + v2.BobPhase) * 3 * v2.BeamSign
            v2.Beam.CurveSize1 = math.cos(v8 * 1.6 + v2.BobPhase) * 3 * -v2.BeamSign
            if not a1.Absorbing then
                v2.Field:Step(v6, v10, v19)
            end
        end
        v16 = (math.sin(v8 * (v10 * 10 + 6))) * 0.07 + 1
        v15 = (TweenService:GetValue(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.In) * 0.95 + 0.55) * v16 + v11 * 0.4
        a1.Core.Size = Vector3.new(1, 1, 1) * v15
        a1.Core.CFrame = CFrame.new(a1.Center)
        v16 = u66.Light:Lerp(u66.Dark, (math.sin(v8 * 3)) * 0.5 + 0.5)
        a1.Core.Color = v16:Lerp(u104, v10 * 0.14 + v11 * 0.3)
        return
    end
    a1.CamPunch = math.max((a1.CamPunch or 0) - a2 * 3, 0)
    a1.CamRumble = math.max((a1.CamRumble or 0) - a2 * 2, 0)
end

local function flight(a1, a2) -- Line: 656
    -- upvalues: revealSide (val), RunService (val), RiftTradeIn (val), freeze (val), u77 (val), tintEmitters (val)
    -- upvalues: VFX (val)
    local Prop = a2.Prop
    if Prop and Prop.Parent then
        local Character, HumanoidRootPart, Magnitude, v1, v2, v3, v4, v5, v6
        a2.Trail.Enabled = true
        local Position = Prop:GetPivot().Position
        local Scale = Prop:GetScale()
        local v7 = a2.EggScale or Scale
        local v8 = 0
        local v9, v10 = a1, a2
        while v8 < 1.15 do
            v8 = v8 + RunService.RenderStepped:Wait()
            if v9.Dead or not Prop.Parent then
                break
            end
            v4 = math.min(v8 / 1.15, 1)
            v5 = v4 * v4
            Character = v10.Character
            if Character then
                HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                v6 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            else
                v6 = nil
            end
            v6 = (Position + (if not v6 then Position else v6.Position + Vector3.new(0, 1.5, 0))) * 0.5
            Magnitude = ((Position - v1) * Vector3.new(1, 0, 1)).Magnitude
            v3 = Vector3.new(v6.X, (math.max(Position.Y, v1.Y)) + Magnitude * 0.5 + 2.5, v6.Z)
            v6 = 1 - v5
            v2 = Position * (v6 * v6) + v3 * (v6 * 2 * v5) + v1 * (v5 * v5)
            v3 = Vector3.new(v1.X, v2.Y, v1.Z)
            Prop:PivotTo((if not ((v2 - v3).Magnitude < 0.001) then CFrame.lookAt(v2, v3) else CFrame.new(v2)) * (CFrame.Angles(v5 * 2 * 3.141592653589793 * 2, 0, 0)))
            v10.Host.CFrame = CFrame.new(v2)
            v10.FlightAt = v2
            v2 = math.min(v4 / 0.22, 1) - 1
            v3 = v2 * 2.70158 * v2 * v2 + 1 + v2 * 1.70158 * v2
            v1 = Scale + (v7 - Scale) * v3
            v3 = math.clamp((v4 - 0.55) / 0.45, 0, 1)
            Prop:ScaleTo((math.max(v1 * (1 - v3 * v3 * v3), 0.01)))
        end
        v10.Trail.Enabled = false
        v10.FlightAt = nil
        revealSide(v10)
        if v9.Dead then
            return
        end
        local Character_2 = v10.Character
        if Character_2 then
            v7 = Character_2:FindFirstChild("HumanoidRootPart")
            v8 = if not v7 then nil else if not v7:IsA("BasePart") then nil else v7
        else
            v8 = nil
        end
        local v11 = if not v8 then Position else v8.Position + Vector3.new(0, 1, 0)
        local Aura = RiftTradeIn:FindFirstChild("Aura")
        if Aura and Aura:IsA("Model") then
            local v12 = Aura:Clone()
            freeze(v12)
            v12:PivotTo((CFrame.new(v11)))
            local Light = u77[v10.Name] or u77.Light
            tintEmitters(v12, Light[1], Light[2])
            v12.Parent = v9.Container.Parent
            for i, j in v12:GetDescendants() do
                if j:IsA("BasePart") then
                    j.LocalTransparencyModifier = 1
                end
            end
            VFX.EmitTree(v12, true)
            VFX.Discard(v12, 2.5)
        end
        if Prop.Parent then
            Prop:Destroy()
        end
        return
    end
    revealSide(a2)
end

local function resolvePayoff(a1, a2) -- Line: 722
    -- upvalues: sweepTools (val), Flash (val), pushImpulse (val), Shake (val), u104 (val), TweenService (val)
    -- upvalues: VFX (val), Particles (val), Eggs (val), fallbackProp (val), freeze (val), RunService (val)
    -- upvalues: quadInOut (val), propPivot (val), flight (val), u108 (ref), revealSide (val)
    local BoundingBox, BoundingBox_2, Pivot, RollStart, Theta_2, Value, Value_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    sweepTools(a1, a1.Sides.Light)
    sweepTools(a1, a1.Sides.Dark)
    local v13 = {}
    local v14 = {"Light", "Dark"}
    local v15 = nil
    local v16 = nil
    local v17 = a2
    for i, j in v14, v15, v16 do
        v11 = a1.Sides[j]
        Pivot = if not v11.Pivot then CFrame.new(a1.Center + (a1.PlaneU * math.cos(if j ~= "Light" then 3.141592653589793 else 0) + a1.PlaneV * math.sin(v4)) * 1.2) else v11.Pivot
        v13[j] = Pivot
    end
    if a1.Participant then
        pcall(Flash.Play, {Attack = 0.06, Decay = 0.22})
    end
    a1.CamPunch = 1
    pushImpulse(a1, 1.4)
    pushImpulse(a1, 1)
    task.delay(0.08, pushImpulse, a1, 1.15)
    task.delay(0.19, pushImpulse, a1, 0.8)
    task.delay(0.33, pushImpulse, a1, 0.55)
    task.delay(0.52, pushImpulse, a1, 0.35)
    if not a1.Participant then
        Shake.Play({Seconds = 0.7, Magnitude = 1, Range = {Near = 24, Far = 90, Center = a1.Center}})
    end
    local Part = Instance.new("Part")
    Part.Shape = Enum.PartType.Ball
    Part.Material = Enum.Material.Neon
    Part.Color = u104
    Part.Size = Vector3.new(2, 2, 2)
    Part.Transparency = 0.45
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CFrame = CFrame.new(a1.Center)
    Part.Parent = a1.Container.Parent
    TweenService:Create(
        Part,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = Vector3.new(13, 13, 13), Transparency = 1}
    ):Play()
    VFX.Discard(Part, 0.7)
    local Part_2 = Instance.new("Part")
    Part_2.Shape = Enum.PartType.Cylinder
    Part_2.Material = Enum.Material.Neon
    Part_2.Color = u104
    Part_2.Size = Vector3.new(36, 4.199999809265137, 4.199999809265137)
    Part_2.Transparency = 0.3
    Part_2.Anchored = true
    Part_2.CanCollide = false
    Part_2.CanQuery = false
    Part_2.CanTouch = false
    Part_2.CastShadow = false
    Part_2.CFrame = (CFrame.new(a1.Center)) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part_2.Parent = a1.Container.Parent
    TweenService:Create(
        Part_2,
        TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = Vector3.new(36, 0.30000001192092896, 0.30000001192092896), Transparency = 1}
    ):Play()
    VFX.Discard(Part_2, 0.75)
    local BigHitGroundAttach = Particles:FindFirstChild("BigHitGroundAttach")
    if BigHitGroundAttach then
        local Part_3 = Instance.new("Part")
        Part_3.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        Part_3.Transparency = 1
        Part_3.Anchored = true
        Part_3.CanCollide = false
        Part_3.CanQuery = false
        Part_3.CanTouch = false
        Part_3.CFrame = CFrame.new(a1.Center.X, a1.GroundY, a1.Center.Z)
        Part_3.Parent = a1.Container.Parent
        BigHitGroundAttach:Clone().Parent = Part_3
        VFX.EmitTree(Part_3, true)
        VFX.Discard(Part_3, 2)
    end
    TweenService:Create(a1.Core, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806),
        Transparency = 1,
    }):Play()
    local FusedCategory = a1.FusedCategory
    local Tier = a1.Tier
    local v18 = FusedCategory or "Fused " .. Tier
    local v19 = Eggs:FindFirstChild(v18)
    if not v19 or not v19:IsA("Model") then
        warn("[ShrineFusionSequence] missing fused egg model:", v18)
        v14 = nil
    else
        v14 = v19
    end
    v15 = {"Light", "Dark"}
    v16 = nil
    v18 = nil
    for k, n in v15, v16, v18 do
        v12 = a1.Sides[n]
        if v12.Prop.Parent then
            v12.Prop:Destroy()
        end
        freeze(if not v14 then fallbackProp(v12.Color) else v14:Clone())
        v1.PrimaryPart = nil
        BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
        v1.WorldPivot = BoundingBox
        v2 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
        if v2 > 0.01 then
            v1:ScaleTo((math.clamp((v1:GetScale()) * (3.6 / v2), 0.01, 50)))
        end
        v1:PivotTo(v13[n])
        v1.Parent = a1.Container
        v12.Prop = v1
        v12.EggScale = v1:GetScale()
        v1:ScaleTo((math.max(v12.EggScale * 0.12, 0.01)))
        if v12.HostEmit then
            VFX.EmitTree(v12.HostEmit, true)
        end
        for m, i5 in v12.Host:GetDescendants() do
            if i5:IsA("ParticleEmitter") then
                i5.Enabled = false
            end
        end
        v12.Beam.Enabled = false
        v12.Trail.Enabled = true
        v12.RollStart = v12.Roll
    end
    local Theta = a1.Theta
    v13 = math.ceil((Theta + 7.853981633974483) / 6.283185307179586) * 6.283185307179586
    v15 = {}
    v19 = nil
    for i6, i7 in {"Light", "Dark"}, nil, v19 do
        v3 = a1.Sides[i7].Roll / 6.283185307179586
        v15[i7] = math.ceil(v3) * 6.283185307179586
    end
    v16 = a1.Center - Vector3.new(0, 1.399999976158142, 0)
    v18 = 0
    while v18 < 1.8 do
        v18 = v18 + RunService.RenderStepped:Wait()
        if a1.Dead then
            break
        end
        v19 = math.min(v18 / 1.8, 1)
        Value = TweenService:GetValue(v19, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        a1.Theta = Theta + (v13 - Theta) * Value
        v1 = TweenService:GetValue(v19, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 1.4000000000000001 + 1.2
        v12 = 0.24434609527920614 * (1 - Value)
        v2 = a1.Center:Lerp(v16, (quadInOut(v19)))
        v3 = math.clamp(1 - v19 / 0.3, 0, 1)
        a1.ShakeIntensity = v3 * 0.7
        a1.CamRumble = v3 * 0.46
        v6 = math.min(v19 / 0.4, 1) - 1
        v4 = v6 * 2.70158 * v6 * v6 + 1 + v6 * 1.70158 * v6
        v5 = {"Light", "Dark"}
        v6 = nil
        v7 = nil
        for i8, i9 in v5, v6, v7 do
            v19 = a1.Sides[i9]
            Theta_2 = a1.Theta
            v8 = Theta_2 + (if i9 ~= "Light" then 3.141592653589793 else 0)
            v10 = (a1.PlaneU * math.cos(v8) + a1.PlaneV * math.sin(v8)) * v1
            if v12 > 0.001 then
                v10 = CFrame.fromAxisAngle(a1.PlaneU, v12) * v10
            end
            v9 = v2 + v10
            RollStart = v19.RollStart
            v19.Roll = RollStart + (v15[i9] - RollStart) * Value
            v8 = propPivot(a1, v19, v9, v3 * 0.5)
            v19.Pivot = v8
            if v19.Prop.Parent then
                v19.Prop:PivotTo(v8)
                v19.Prop:ScaleTo((math.max(v19.EggScale * (v4 * 0.88 + 0.12), 0.01)))
            end
            v19.Host.CFrame = CFrame.new(v9)
        end
    end
    a1.ShakeIntensity = 0
    a1.CamRumble = 0
    v15 = {}
    v19 = {}
    v19[1] = "Light"
    v19[2] = "Dark"
    v11 = nil
    v12 = nil
    for i10, i11 in v19, v11, v12 do
        v14 = if i11 ~= "Light" then -1 else 1
        v15[i11] = v16 + a1.PlaneU * (v14 * 2.6)
    end
    v18 = 0
    while v18 < 1.9 do
        v18 = v18 + RunService.RenderStepped:Wait()
        if a1.Dead then
            break
        end
        v16 = os.clock()
        Value_2 = TweenService:GetValue(math.clamp((v18 - 1.5) / 0.4, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        v11 = {"Light", "Dark"}
        v12 = nil
        v1 = nil
        for i12, i13 in v11, v12, v1 do
            v13 = a1.Sides[i13]
            v4 = math.sin(v16 * 2.3 + v13.BobPhase) * 0.24 * (1 - Value_2)
            v5 = v15[i13] + Vector3.new(0, v4 - Value_2 * 0.45, 0)
            v4 = (1 - Value_2) * 0.12217304763960307
            v7 = (CFrame.lookAt(v5, (Vector3.new(a1.Center.X, v5.Y, a1.Center.Z)))) * CFrame.Angles(math.sin(v16 * 1.7 + v13.BobPhase) * v4, 0, math.cos(v16 * 1.3 + v13.BobPhase) * v4)
            v13.Pivot = v7
            if v13.Prop.Parent then
                v13.Prop:PivotTo(v7)
                v13.Prop:ScaleTo((math.max(v13.EggScale * (Value_2 * -0.14 + 1), 0.01)))
            end
            v13.Host.CFrame = CFrame.new(v5)
        end
    end
    a1.FlightStartAt = os.clock()
    for i14, i15 in {"Light", "Dark"} do
        local u672 = a1.Sides[i15]
        task.spawn(function() -- Line: 899 -- upvalues: i14 (val), u672 (val), VFX (upval), flight (upval), a1 (val)
            if i14 > 1 then
                task.wait(0.15)
            end
            if u672.HostEmit then
                VFX.EmitTree(u672.HostEmit, true)
            end
            flight(a1, u672)
        end)
    end
    v15 = 0
    while v15 < 2.8 do
        task.wait(0.05)
        v15 = v15 + 0.05
        if a1.Sides.Light.Arrived and a1.Sides.Dark.Arrived then
            break
        end
    end
    if u108 == a1 then
        u108 = nil
        a1.Dead = true
        revealSide(a1.Sides.Light)
        revealSide(a1.Sides.Dark)
        a1.Trove:Clean()
    end
    if v17 then
        task.spawn(v17)
    end
end

function u105.IsPlaying() -- Line: 923 -- upvalues: u108 (ref)
    return u108 ~= nil
end

function u105.ActiveShrine() -- Line: 927 -- upvalues: u108 (ref)
    if u108 then
        return u108.Shrine
    end
    return nil
end

function u105.IsResolving() -- Line: 931 -- upvalues: u108 (ref)
    local v1 = false
    if u108 ~= nil then
        v1 = u108.Resolving == true
    end
    return v1
end

function u105.FlightFocus() -- Line: 935 -- upvalues: u108 (ref)
    local v1 = u108
    if v1 and v1.FlightStartAt then
        local v2 = os.clock() - v1.FlightStartAt
        if v2 < 0.15 then
            return v1.Sides.Light.FlightAt
        end
        if v2 < 0.3 then
            return v1.Sides.Dark.FlightAt or v1.Sides.Light.FlightAt
        end
        return nil
    end
    return nil
end

function u105.Begin(a1) -- Line: 950
    -- upvalues: Workspace (val), u108 (ref), Trove (val), u104 (val), buildSide (val), revealSide (val)
    -- upvalues: RunService (val), stepSession (val), fuseTrack (val)
    local Shrine = a1.Shrine
    if typeof(Shrine) == "Instance" then
        local v1 = Workspace
        if Shrine:IsDescendantOf(v1) then
            local LightPad = Shrine:FindFirstChild("LightPad")
            local DarkPad = Shrine:FindFirstChild("DarkPad")
            if LightPad and LightPad:IsA("BasePart") and DarkPad and DarkPad:IsA("BasePart") then
                if u108 then
                    v1 = u108
                    u108 = nil
                    v1.Dead = true
                    v1.Trove:Clean()
                end
                local u33 = {
                    Theta = 0,
                    ShakeIntensity = 0,
                    CamPunch = 0,
                    CamRumble = 0,
                    ImpulseSlot = 1,
                    NextImpulse = 0,
                    Dead = false,
                    Resolving = false,
                    Absorbing = false,
                }
                u33.Trove = Trove.new()
                u33.Shrine = Shrine
                u33.Tier = a1.Tier
                u33.FusedCategory = a1.FusedCategory
                u33.Participant = a1.Participant == true
                u33.TrackCharacter = a1.TrackCharacter
                u33.StartAt = Workspace:GetServerTimeNow()
                u33.EndsAt = a1.EndsAt
                u33.Pads = {Light = LightPad, Dark = DarkPad}
                u33.Sides = {}
                u33.Impulses = table.create(8)
                local v2 = math.max(u33.EndsAt - u33.StartAt, 1)
                u33.LiftSeconds = math.clamp(v2 * 0.16, 0.35, 1.1)
                u33.ShakeLead = math.clamp(v2 * 0.24, 0.5, 1.3)
                v2 = (LightPad.Position - DarkPad.Position) * Vector3.new(1, 0, 1)
                u33.PlaneU = if not (0.01 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit
                u33.PlaneV = u33.PlaneU:Cross((Vector3.new(0, 1, 0)))
                u33.Center = (LightPad.Position + DarkPad.Position) * 0.5 + Vector3.new(0, 5.5, 0)
                u33.GroundY = math.max(LightPad.Position.Y + LightPad.Size.Y * 0.5, DarkPad.Position.Y + DarkPad.Size.Y * 0.5)
                local v3 = Instance.new("Folder")
                v3.Name = "ShrineFusionSequence"
                local Parent = a1.Parent or Workspace:FindFirstChild("Transient") or Workspace
                v3.Parent = Parent
                u33.Trove:Add(v3)
                u33.Container = v3
                local v4 = Instance.new("Part")
                v4.Shape = Enum.PartType.Ball
                v4.Material = Enum.Material.Neon
                v4.Color = u104
                v4.Size = Vector3.new(0.550000011920929, 0.550000011920929, 0.550000011920929)
                v4.Transparency = 0.3
                v4.Anchored = true
                v4.CanCollide = false
                v4.CanQuery = false
                v4.CanTouch = false
                v4.CastShadow = false
                v4.CFrame = CFrame.new(u33.Center)
                v4.Parent = v3
                u33.Core = v4
                v3 = Instance.new("Attachment")
                v3.Parent = v4
                u33.CoreAttachment = v3
                u33.Sides.Light = buildSide(u33, "Light", a1.LightCharacter)
                u33.Sides.Dark = buildSide(u33, "Dark", a1.DarkCharacter)
                u33.Trove:Add(function() -- Line: 1025 -- upvalues: revealSide (upval), u33 (val)
                    revealSide(u33.Sides.Light)
                    revealSide(u33.Sides.Dark)
                end)
                u108 = u33
                u33.Trove:Connect(RunService.RenderStepped, function(a1) -- Line: 1031 -- upvalues: stepSession (upval), u33 (val)
                    stepSession(u33, a1)
                end)
                fuseTrack(u33)
                return true
            end
            return false
        end
    end
    return false
end

function u105.Payoff(a1) -- Line: 1038
    -- upvalues: u108 (ref), resolvePayoff (val), revealSide (val)
    local u1 = u108
    if u1 and not u1.Resolving and not u1.Dead then
        u1.Resolving = true
        task.spawn(function() -- Line: 1044 -- upvalues: resolvePayoff (upval), u1 (val), a1 (val), u108 (upval), revealSide (upval)
            local success, err = pcall(resolvePayoff, u1, a1)
            if not success then
                warn("ShrineFusionSequence payoff failed:", err)
                local v1 = u1
                if u108 == v1 then
                    u108 = nil
                    v1.Dead = true
                    revealSide(v1.Sides.Light)
                    revealSide(v1.Sides.Dark)
                    v1.Trove:Clean()
                end
                if a1 then
                    task.spawn(a1)
                end
            end
        end)
        return true
    end
    return false
end

function u105.Cancel() -- Line: 1057 -- upvalues: u108 (ref), RunService (val), TweenService (val), revealSide (val)
    local u0 = u108
    if u0 and not u0.Resolving then
        u0.Dead = true
        task.spawn(function() -- Line: 1063
            -- upvalues: u0 (val), RunService (upval), TweenService (upval), u108 (upval), revealSide (upval)
            local Core, v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = 0
            local Scale = u0.Sides.Light.Prop:GetScale()
            local Scale_2 = u0.Sides.Dark.Prop:GetScale()
            while v9 < 0.3 do
                v3 = RunService.RenderStepped:Wait()
                v9 = v9 + v3
                v4 = math.min(v9 / 0.3, 1)
                v5 = math.max(1 - TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 0.01)
                v6 = {"Light", "Dark"}
                v7 = nil
                v8 = nil
                for i, j in v6, v7, v8 do
                    v2 = u0.Sides[j]
                    if v2.Prop.Parent then
                        v2.Prop:ScaleTo((math.max((if j ~= "Light" then Scale_2 else Scale) * v5, 0.01)))
                        v2.Prop:PivotTo((v2.Prop:GetPivot()) * (CFrame.new(0, -v3 * 2, 0)))
                    end
                end
                Core = u0.Core
                v1 = (1 - v4) * 1.5
                Core.Size = Vector3.new(1, 1, 1) * math.max(v1, 0.05)
                u0.ShakeIntensity = 0
                u0.CamRumble = 0
            end
            v3 = u0
            if u108 ~= v3 then
                return
            end
            u108 = nil
            v3.Dead = true
            revealSide(v3.Sides.Light)
            revealSide(v3.Sides.Dark)
            v3.Trove:Clean()
        end)
        return
    end
end

pcall(function() -- Line: 1087 -- upvalues: RunService (val), u135 (val)
    RunService:BindToRenderStep("ShrineFusionSequenceHold", Enum.RenderPriority.Last.Value, function() -- Line: 1088 -- upvalues: u135 (upval)
        for i in u135 do
            if not i.Parent then
                u135[i] = nil
            else
                i.LocalTransparencyModifier = 1
            end
        end
    end)
end)
pcall(function() -- Line: 1100 -- upvalues: RunService (val), u108 (ref), GuiService (val), Workspace (val)
    RunService:BindToRenderStep("ShrineFusionSequenceShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 1101 -- upvalues: u108 (upval), GuiService (upval), Workspace (upval)
        local v1 = u108
        if v1 and v1.Participant and not GuiService.ReducedMotionEnabled then
            local v2 = math.clamp((math.max((v1.ShakeIntensity or 0) * 0.75, (v1.CamRumble or 0) * 0.35)) + (v1.CamPunch or 0), 0, 1.6)
            local v3 = math.clamp(math.max(v1.ShakeIntensity or 0, v1.CamRumble or 0), 0, 1)
            local v4 = Vector3.new(0, 0, 0)
            local v5 = Vector3.new(0, 0, 0)
            local Impulses = v1.Impulses
            if Impulses then
                local v6, v7
                v1 = os.clock()
                for i, j in Impulses do
                    v6 = (v1 - j.At) / j.Life
                    if v6 >= 0 and v6 < 1 then
                        v7 = (1 - v6) * (1 - v6) * math.cos(v6 * 3.141592653589793 * 3)
                        v4 = v4 + j.Dir * (j.Power * v7)
                        v5 = v5 + j.Spin * (j.Power * v7)
                    end
                end
            end
            local v8 = true
            if not (0.001 < v4.Magnitude) then
                v8 = 0.001 < v5.Magnitude
            end
            if v2 <= 0.005 and v3 <= 0.01 and not v8 then
                return
            end
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                local v9 = os.clock() * 9
                local v10 = v2 * 0.15
                local v11 = math.rad(v2 * 1.6)
                CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(math.noise(v9, 0, 37.4) * 2 * v10, math.noise(0, v9, 42.1) * 2 * v10, 0) * CFrame.Angles(math.noise(v9, 46.5, 0) * 2 * v11, math.noise(50.7, 0, v9) * 2 * v11, math.noise(v9 * 0.7, 0, 59) * v11)
                if v3 > 0.01 then
                    v11 = os.clock() * 31
                    v10 = v3 * 0.085
                    v9 = math.rad(v3 * 0.95)
                    CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(math.noise(v11, 40.699999999999996, 0) * 2 * v10, math.noise(0, 45.3, v11) * 2 * v10, 0) * CFrame.Angles(math.noise(v11, 0, 48.599999999999994) * 2 * v9, math.noise(55.2, v11, 0) * 2 * v9, 0)
                end
                if v8 then
                    CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(v4 * 0.44) * CFrame.Angles(math.rad(v5.X * 2.6), math.rad(v5.Y * 2.6), (math.rad(v5.Z * 2.6 * 0.7)))
                end
                return
            end
            return
        end
    end)
end)
return (table.freeze(u105))