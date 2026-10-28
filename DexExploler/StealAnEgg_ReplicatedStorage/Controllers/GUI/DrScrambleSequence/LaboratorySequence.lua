-- Script path: ReplicatedStorage.Controllers.GUI.DrScrambleSequence.LaboratorySequence
-- Decompile time: 15.51 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local RiftTradeIn = ReplicatedStorage.Assets.VFX.RiftTradeIn
local Sounds = ReplicatedStorage.Assets.Sounds
local u54 = Color3.fromRGB(164, 255, 61)
local u59 = Color3.fromRGB(231, 255, 185)
local v1 = {}
local u61 = false

local function machineParts() -- Line: 22 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Machines = World and World:FindFirstChild("Machines")
    local v1 = Machines and Machines:FindFirstChild("RiftMachine")
    local Rift = v1 and v1:FindFirstChild("Rift")
    if Rift and Rift:IsA("Model") then
        v1 = Rift:FindFirstChild("MainScreen")
        local EggSpawn = v1 and v1:FindFirstChild("EggSpawn")
        if v1 and v1:IsA("BasePart") and EggSpawn and EggSpawn:IsA("Attachment") then
            local OfferingSpawn, v2
            local v3 = {}
            for i = 1, 3 do
                v2 = Rift:FindFirstChild("Pad" .. i)
                OfferingSpawn = v2 and v2:FindFirstChild("OfferingSpawn", true)
                if OfferingSpawn and OfferingSpawn:IsA("Attachment") then
                    continue
                end
                return nil, nil, nil, {}
            end
            return Rift, v1, EggSpawn, v3
        end
        return nil, nil, nil, {}
    end
    return nil, nil, nil, {}
end

local function cue(a1, a2, a3) -- Line: 47
    -- upvalues: Sounds (val), Audio (val)
    local v1 = Sounds:FindFirstChild(a1) or Sounds:FindFirstChild(a1, true)
    local Sound = if not v1 then v1 and v1:FindFirstChildWhichIsA("Sound") else if not v1:IsA("Sound") then v1 and v1:FindFirstChildWhichIsA("Sound") else v1
    if Sound then
        Audio.Play(Sound, a2, {Volume = a3})
    end
end

local function freeze(a1) -- Line: 55 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
end

local function centerAndScale(a1, a2) -- Line: 66 -- types: a1: userdata, a2: number
    local BoundingBox_4
    a1.PrimaryPart = nil
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    a1.WorldPivot = BoundingBox
    local v1 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
    a1:ScaleTo(if not (v1 > 0.01) then 1 else math.clamp(a2 / v1, 0.05, 6))
    _, BoundingBox_4 = a1:GetBoundingBox()
    return BoundingBox_4.Y * 0.5
end

local function offeringModel(a1) -- Line: 76 -- upvalues: EggRecords (val), freeze (val), u54 (val)
    local success, err = pcall(function() -- Line: 77 -- upvalues: EggRecords (upval), a1 (val)
        return EggRecords.EggModelTemplate(a1.AssetCategory, a1.Mutations, a1.BaseMutation, a1.EggSkin)
    end)
    if success and err and err:IsA("Model") then
        local v1 = err:Clone()
        freeze(v1)
        return v1
    end
    local Model = Instance.new("Model")
    local v2 = Instance.new("Part")
    v2.Shape = Enum.PartType.Ball
    v2.Size = Vector3.new(2, 2, 2)
    v2.Material = Enum.Material.Neon
    v2.Color = u54
    v2.Parent = Model
    freeze(Model)
    return Model
end

local function tintEffects(a1) -- Line: 96 -- upvalues: u54 (val) -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") then
            j.Color = ColorSequence.new(u54)
        elseif j:IsA("Light") or j:IsA("BasePart") and j.Material == Enum.Material.Neon then
            j.Color = u54
        end
    end
end

local function tweenNumber(a1, a2, a3) -- Line: 108 -- upvalues: TweenService (val) -- types: a1: number, a3: function
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = 0
    local v1 = NumberValue.Changed:Connect(a3)
    local v2 = TweenService:Create(NumberValue, TweenInfo.new(a1, a2), {Value = 1})
    a3(0)
    v2:Play()
    v2.Completed:Wait()
    v1:Disconnect()
    NumberValue:Destroy()
    a3(1)
end

local function bezier(a1, a2, a3, a4) -- Line: 121 -- types: a1: vector, a2: vector, a3: vector, a4: number
    return (a1:Lerp(a2, a4)):Lerp(a2:Lerp(a3, a4), a4)
end

function v1.Available() -- Line: 125 -- upvalues: machineParts (val)
    local v1, v2, v3
    _, v1, v2, v3 = machineParts()
    local v4 = false
    if v1 ~= nil then
        v4 = false
        if v2 ~= nil then
            v4 = #v3 == 3
        end
    end
    return v4
end

function v1.IsPlaying() -- Line: 130 -- upvalues: u61 (ref)
    return u61
end

function v1.Play(a1, a2, a3) -- Line: 134
    -- upvalues: u61 (ref), machineParts (val), Workspace (val), u54 (val), cue (val), Shake (val), offeringModel (val)
    -- upvalues: TweenService (val), u59 (val), tweenNumber (val), bezier (val), Flash (val), RiftTradeIn (val)
    -- upvalues: freeze (val), tintEffects (val), VFX (val), Players (val)
    if u61 then
        task.spawn(a2)
        return
    end
    u61 = true
    task.spawn(function() -- Line: 140
        -- upvalues: a2 (val), machineParts (upval), Workspace (upval), u54 (upval), cue (upval), Shake (upval)
        -- upvalues: a1 (val), offeringModel (upval), TweenService (upval), u59 (upval), tweenNumber (upval)
        -- upvalues: bezier (upval), Flash (upval), a3 (val), RiftTradeIn (upval), freeze (upval), tintEffects (upval)
        -- upvalues: VFX (upval), Players (upval), u61 (upval)
        local u0 = false
        local u1 = {}
        local u2 = {}

        local function deliver() -- Line: 144 -- upvalues: u0 (ref), a2 (upval)
            if not u0 then
                u0 = true
                task.spawn(a2)
            end
        end

        local function keep(a1) -- Line: 150 -- upvalues: u1 (val) -- types: a1: userdata
            table.insert(u1, a1)
            return a1
        end

        local function remember(a1) -- Line: 154 -- upvalues: u2 (val) -- types: a1: userdata
            table.insert(u2, {part = a1, color = a1.Color, material = a1.Material})
        end

        local success, err = pcall(function() -- Line: 157
            -- upvalues: machineParts (upval), Workspace (upval), u2 (val), u1 (val), u54 (upval), cue (upval)
            -- upvalues: Shake (upval), a1 (upval), offeringModel (upval), TweenService (upval), u59 (upval)
            -- upvalues: tweenNumber (upval), bezier (upval), Flash (upval), a3 (upval), RiftTradeIn (upval)
            -- upvalues: freeze (upval), tintEffects (upval), VFX (upval), Players (upval), u0 (ref), a2 (upval)
            local Beam, BoundingBox, BoundingBox_10, BoundingBox_2, BoundingBox_4, BoundingBox_8, Parent, v1, v2, v3, v4, v5
            _, v1, v4, v5 = machineParts()
            assert(v1 and v4 and #v5 == 3, "laboratory reveal anchors missing")
            local WorldPosition = v4.WorldPosition
            local Transient = Workspace:WaitForChild("Transient")
            table.insert(u2, {part = v1, color = v1.Color, material = v1.Material})
            v1.Material = Enum.Material.Neon
            local v6 = {}
            local v7 = nil
            local v8 = nil
            for i, j in v5, v7, v8 do
                Parent = j.Parent
                assert(Parent and Parent:IsA("BasePart"), "offering anchor must be under a pad part")
                table.insert(v6, Parent)
                table.insert(u2, {part = Parent, color = Parent.Color, material = Parent.Material})
                Parent.Material = Enum.Material.Neon
            end
            local PointLight = Instance.new("PointLight")
            table.insert(u1, PointLight)
            PointLight.Color = u54
            PointLight.Brightness = 0
            PointLight.Range = 15
            PointLight.Parent = v1
            v7 = {}
            for k, n in v5 do
                Beam = Instance.new("Beam")
                table.insert(u1, Beam)
                Beam.Attachment0 = n
                Beam.Attachment1 = v4
                Beam.Color = ColorSequence.new(u54)
                Beam.Width0 = 0.18
                Beam.Width1 = 0.32
                Beam.LightEmission = 1
                Beam.FaceCamera = true
                Beam.Enabled = false
                Beam.Parent = n
                table.insert(v7, Beam)
            end
            cue("CinematicRiser", WorldPosition, 0.55)
            Shake.Play({Seconds = 0.45, Magnitude = 0.7})
            v4 = {}
            local v9 = nil
            local v10 = nil
            for m, i5 in a1, v9, v10 do
                v2 = v5[m]
                if not v2 then
                    break
                end
                local u89 = offeringModel(i5)
                table.insert(u1, u89)
                u89.PrimaryPart = nil
                BoundingBox, BoundingBox_2 = u89:GetBoundingBox()
                u89.WorldPivot = BoundingBox
                v3 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
                u89:ScaleTo(if not (v3 > 0.01) then 1 else math.clamp(2.5 / v3, 0.05, 6))
                _, BoundingBox_4 = u89:GetBoundingBox()
                local u130 = v2.WorldPosition + Vector3.new(0, BoundingBox_4.Y * 0.5 + 0.05, 0)
                local u132 = u130 + Vector3.new(0, 2.299999952316284, 0)
                u89:PivotTo((CFrame.new(u130)))
                u89.Parent = Transient
                table.insert(v4, {model = u89, start = u130, hover = u132, scale = u89:GetScale()})
                task.wait(0.12)
                cue("MechaShake", u130, 0.28)
                TweenService:Create(v6[m], TweenInfo.new(0.25), {Color = u59}):Play()
                tweenNumber(0.45, Enum.EasingStyle.Back, function(a1) -- Line: 209 -- upvalues: u89 (val), u130 (val), u132 (val)
                    if u89.Parent then
                        u89:PivotTo((CFrame.new((u130:Lerp(u132, a1)))))
                    end
                end)
            end
            task.wait(0.35)
            for i6, i7 in v4 do
                v7[i6].Enabled = true
                cue("ImpactBoom", i7.hover, 0.38)
                local u526 = (i7.hover:Lerp(WorldPosition, 0.5)) + Vector3.new(0, 1.2000000476837158, 0)
                tweenNumber(0.42, Enum.EasingStyle.Quad, function(a1) -- Line: 220 -- upvalues: i7 (val), bezier (upval), u526 (val), WorldPosition (val)
                    if i7.model.Parent then
                        i7.model:PivotTo((CFrame.new((bezier(i7.hover, u526, WorldPosition, a1)))))
                        i7.model:ScaleTo(i7.scale * (math.max(1 - a1 * 0.85, 0.15)))
                    end
                end)
                i7.model:Destroy()
                task.wait(0.15)
            end
            Flash.Play({Attack = 0.08, Decay = 0.28, Opacity = 0.5, Tint = u54})
            Shake.Play({Seconds = 0.55, Magnitude = 1.1})
            TweenService:Create(v1, TweenInfo.new(0.4), {Color = u54}):Play()
            TweenService:Create(PointLight, TweenInfo.new(0.4), {Brightness = 4}):Play()
            cue("CinematicBoom", WorldPosition, 0.8)
            task.wait(0.6)
            for i8, i9 in v7 do
                i9.Enabled = false
            end
            local u264 = if not a3 then RiftTradeIn.Egg:Clone() else offeringModel(a3)
            table.insert(u1, u264)
            freeze(u264)
            if a3 == nil then
                tintEffects(u264)
            end
            u264.PrimaryPart = nil
            local BoundingBox_5, BoundingBox_6 = u264:GetBoundingBox()
            u264.WorldPivot = BoundingBox_5
            v8 = math.max(BoundingBox_6.X, BoundingBox_6.Y, BoundingBox_6.Z)
            u264:ScaleTo(if not (v8 > 0.01) then 1 else math.clamp(5 / v8, 0.05, 6))
            _, BoundingBox_8 = u264:GetBoundingBox()
            local v11 = BoundingBox_8.Y * 0.5
            u264.Parent = Transient
            local u314 = u264:GetScale()
            _, BoundingBox_10 = u264:GetBoundingBox()
            v8 = BoundingBox_10.Y * 0.5
            u264:ScaleTo(u314 * 0.4)
            u264:PivotTo((CFrame.new(WorldPosition)))
            VFX.EmitTree(u264, true)
            cue("MechaHatch", WorldPosition, 0.9)
            Flash.Play({Attack = 0.06, Decay = 0.4, Opacity = 0.75, Tint = u59})
            local Character = Players.LocalPlayer.Character
            v5 = Character and Character:FindFirstChild("HumanoidRootPart")
            v4 = if not v5 or not v5:IsA("BasePart") then v1.CFrame.LookVector * Vector3.new(1, 0, 1) else (v5.Position - WorldPosition) * Vector3.new(1, 0, 1)
            v4 = WorldPosition + (if not (0.05 < v4.Magnitude) then Vector3.new(-1, 0, 0) else v4.Unit) * math.clamp(v4.Magnitude * 0.65, 8, 13)
            v10 = RaycastParams.new()
            v10.FilterType = Enum.RaycastFilterType.Exclude
            v10.FilterDescendantsInstances = {Transient, Workspace.World.Machines.RiftMachine, Character}
            local v12 = Workspace:Raycast(v4 + Vector3.new(0, 7, 0), Vector3.new(0, -80, 0), v10)
            local u439 = Vector3.new(v4.X, if not v12 then WorldPosition.Y - 2 else v12.Position.Y + v8, v4.Z)
            local u447 = (WorldPosition:Lerp(u439, 0.5)) + Vector3.new(0, 5, 0)
            tweenNumber(0.9, Enum.EasingStyle.Quad, function(a1) -- Line: 267
                -- upvalues: u264 (val), bezier (upval), WorldPosition (val), u447 (val), u439 (val), u314 (val)
                if u264.Parent then
                    u264:PivotTo((CFrame.new(bezier(WorldPosition, u447, u439, a1))) * (CFrame.Angles(0, a1 * 3.141592653589793 * 3, 0)))
                    u264:ScaleTo(u314 * (0.4 + a1 * 0.6))
                end
            end)
            cue("ImpactBoom", u439, 0.7)
            tweenNumber(0.35, Enum.EasingStyle.Quad, function(a1) -- Line: 274 -- upvalues: u264 (val), u439 (val)
                if u264.Parent then
                    u264:PivotTo((CFrame.new(u439 + (Vector3.new(0, math.sin(a1 * 3.141592653589793) * 1.2, 0)))))
                end
            end)
            task.wait(0.25)
            local Character_2 = Players.LocalPlayer.Character
            v5 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
            if v5 and v5:IsA("BasePart") then
                local Position = (u264:GetPivot()).Position
                tweenNumber(0.55, Enum.EasingStyle.Quad, function(a1) -- Line: 284 -- upvalues: u264 (val), Players (upval), Position (val), u314 (val)
                    if u264.Parent then
                        local Character = Players.LocalPlayer.Character
                        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                        u264:PivotTo((CFrame.new((Position:Lerp(
                            if not HumanoidRootPart then Position else if not HumanoidRootPart:IsA("BasePart") then Position else HumanoidRootPart.Position + Vector3.new(0, 1.399999976158142, 0),
                            a1
                        )))))
                        u264:ScaleTo(u314 * (1 - a1 * 0.75))
                    end
                end)
            end
            if not u0 then
                u0 = true
                task.spawn(a2)
            end
            task.wait(0.35)
        end)
        for i, j in u2 do
            if j.part.Parent then
                j.part.Color = j.color
                j.part.Material = j.material
            end
        end
        for k, n in u1 do
            if n.Parent then
                n:Destroy()
            end
        end
        if not success then
            warn("Laboratory sequence failed: " .. tostring(err))
        end
        if not u0 then
            task.spawn(a2)
        end
        u61 = false
    end)
end

return (table.freeze(v1))