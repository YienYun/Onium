-- Script path: ReplicatedStorage.Controllers.GUI.RiftTradeInController.RiftSequence
-- Decompile time: 33.61 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local RiftTradeIn = ReplicatedStorage.Assets.VFX.RiftTradeIn
local Sounds = ReplicatedStorage.Assets.Sounds
local u58 = {-74, 10, 66}
local u62 = {11.2, 10.2, 12}
local u66 = {-3.2, 3.6, 0.2}
local u74 = Color3.fromRGB(214, 168, 255)
local u79 = Color3.fromRGB(196, 130, 255)
local v1 = {}
local u81 = false

local function soundOf(a1) -- Line: 56 -- upvalues: Sounds (val) -- types: a1: string
    local v1 = Sounds:FindFirstChild(a1) or Sounds:FindFirstChild(a1, true)
    if v1 == nil then
        return nil
    end
    if v1:IsA("Sound") then
        return v1
    end
    return v1:FindFirstChildWhichIsA("Sound")
end

local function cue(a1, a2, a3, a4) -- Line: 67
    -- upvalues: Sounds (val), Audio (val)
    local v1 = Sounds:FindFirstChild(a1) or Sounds:FindFirstChild(a1, true)
    local v2 = if v1 ~= nil then if not v1:IsA("Sound") then v1:FindFirstChildWhichIsA("Sound") else v1 else nil
    if v2 then
        Audio.Play(v2, a2, {Volume = a3, PlaybackSpeed = a4})
    end
end

local function debris() -- Line: 74 -- upvalues: Workspace (val)
    return (Workspace:WaitForChild("Transient"))
end

local function driveNumber(a1, a2, a3, a4, a5) -- Line: 78
    -- upvalues: TweenService (val)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = a2
    a1:Add(NumberValue)
    a1:Connect(NumberValue.Changed, a5)
    a5(a2)
    TweenService:Create(NumberValue, a4, {Value = a3}):Play()
    return NumberValue
end

local function isPortalFace(a1) -- Line: 88 -- types: a1: userdata
    local v1 = false
    if a1.Name:find("VoidPortal_Plane", 1, true) ~= nil then
        v1 = a1.Size.Z < a1.Size.Y
    end
    return v1
end

local function heartOf(a1) -- Line: 92 -- types: a1: userdata
    local Y, v1
    local v2 = Vector3.new(0, 0, 0)
    local v3 = 0
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = false
            if j.Name:find("VoidPortal_Plane", 1, true) ~= nil then
                Y = j.Size.Y
                v1 = j.Size.Z < Y
            end
            if v1 then
                v2 = v2 + j.Position
                v3 = v3 + 1
            end
        end
    end
    if v3 > 0 then
        return v2 / v3
    end
    return nil
end

local function flatDiscBottom(a1) -- Line: 107 -- types: a1: userdata
    local Y, v1
    local v2 = nil
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Name:find("VoidPortal_Plane", 1, true) ~= nil then
            v1 = false
            if j.Name:find("VoidPortal_Plane", 1, true) ~= nil then
                Y = j.Size.Y
                v1 = j.Size.Z < Y
            end
            if not v1 then
                v1 = j.Position.Y - j.Size.Y * 0.5
                if v2 == nil or v1 < v2 then
                    v2 = v1
                end
            end
        end
    end
    return v2
end

local function normalizeGhost(a1) -- Line: 120 -- types: a1: userdata
    local BoundingBox_4, v1
    a1.PrimaryPart = nil
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    a1.WorldPivot = BoundingBox
    local v2 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
    a1:ScaleTo(if not (v2 > 0.01) then 1 else math.clamp(6.5 / v2, 0.05, 6))
    _, BoundingBox_4 = a1:GetBoundingBox()
    return v1, BoundingBox_4.Y * 0.5
end

local function freeze(a1) -- Line: 131 -- types: a1: userdata
    if a1:IsA("BasePart") then
        a1.Anchored = true
        a1.CanCollide = false
        a1.CanQuery = false
        a1.CanTouch = false
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
end

local function spawnPhase(a1, a2, a3, a4, a5) -- Line: 148
    -- upvalues: RiftTradeIn (val), freeze (val), heartOf (val), flatDiscBottom (val), Workspace (val)
    local v1 = RiftTradeIn:FindFirstChild(a2):Clone()
    freeze(v1)
    v1:PivotTo(a3)
    local v2 = heartOf(v1)
    if v2 then
        v1:PivotTo((v1:GetPivot()) + (a4 - v2))
    end
    if a5 then
        v2 = flatDiscBottom(v1)
        if v2 then
            local v3 = math.clamp(a5 - v2, -4, 4)
            v1:PivotTo((v1:GetPivot()) + (Vector3.new(0, v3, 0)))
        end
    end
    v1.Parent = Workspace:WaitForChild("Transient")
    a1:Add(v1)
    return v1
end

local function setRiftShown(a1, a2, a3) -- Line: 168 -- types: a1: userdata, a2: boolean, a3: table
    local v1
    local v2, v3 = a2, a3
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.LocalTransparencyModifier = if not v2 then 1 else 0
        elseif j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
            if not v2 then
                j.Enabled = false
            else
                v1 = if v3[j] == nil then true else v3[j]
                j.Enabled = v1
            end
        end
    end
end

local function ghostFor(a1) -- Line: 182 -- upvalues: ItemDisplay (val), u74 (val)
    local success, err = pcall(function() -- Line: 183 -- upvalues: ItemDisplay (upval), a1 (val)
        return ItemDisplay.CreateActiveModel(nil, a1, true)
    end)
    if success and err then
        return err
    end
    local Model = Instance.new("Model")
    local v1 = Instance.new("Part")
    v1.Shape = Enum.PartType.Ball
    v1.Size = Vector3.new(2.4000000953674316, 2.4000000953674316, 2.4000000953674316)
    v1.Material = Enum.Material.Neon
    v1.Color = u74
    v1.Anchored = true
    v1.CanCollide = false
    v1.Parent = Model
    Model.PrimaryPart = v1
    return Model
end

local function neonSurge(a1, a2) -- Line: 202 -- upvalues: TweenService (val), u74 (val) -- types: a2: userdata
    local v1, v2
    for i, j in a2:GetDescendants() do
        if j:IsA("BasePart") and j.Material == Enum.Material.Neon then
            local Color = j.Color
            v2 = TweenService
            v1 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v2:Create(j, v1, {Color = u74}):Play()
            task.delay(0.22, function() -- Line: 207 -- upvalues: j (val), TweenService (upval), Color (val)
                if j.Parent then
                    TweenService:Create(j, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Color}):Play()
                end
            end)
        end
    end
end

local function bezier(a1, a2, a3, a4) -- Line: 216 -- types: a1: vector, a2: vector, a3: vector, a4: number
    return (a1:Lerp(a2, a4)):Lerp(a2:Lerp(a3, a4), a4)
end

local function groundBurst(a1, a2) -- Line: 222
    -- upvalues: ReplicatedStorage (val), Workspace (val), VFX (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Particles = Assets and Assets:FindFirstChild("Particles")
    local v1 = Particles and Particles:FindFirstChild("BigHitGroundAttach")
    if v1 == nil then
        return
    end
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a2)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Parent = Workspace:WaitForChild("Transient")
    a1:Add(Part)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local v2 = v1:Clone()
    for i, j in v2:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            j.Parent = Attachment
        end
    end
    if not v2:IsA("ParticleEmitter") then
        v2:Destroy()
    else
        v2.Parent = Attachment
    end
    VFX.EmitTree(Part, true)
end

function v1.IsPlaying() -- Line: 256 -- upvalues: u81 (ref)
    return u81
end

function v1.Play(a1, a2) -- Line: 260
    -- upvalues: u81 (ref), Trove (val), Workspace (val), heartOf (val), flatDiscBottom (val), setRiftShown (val)
    -- upvalues: spawnPhase (val), VFX (val), Shake (val), Sounds (val), Audio (val), Players (val), u58 (val)
    -- upvalues: u62 (val), u66 (val), ghostFor (val), normalizeGhost (val), Flash (val), u79 (val), RiftTradeIn (val)
    -- upvalues: freeze (val), RunService (val), driveNumber (val), TweenService (val), bezier (val), neonSurge (val)
    -- upvalues: groundBurst (val)
    if u81 then
        a2()
        return
    end
    u81 = true
    task.spawn(function() -- Line: 267
        -- upvalues: a2 (val), Trove (upval), Workspace (upval), u81 (upval), heartOf (upval), flatDiscBottom (upval)
        -- upvalues: setRiftShown (upval), spawnPhase (upval), VFX (upval), Shake (upval), Sounds (upval), Audio (upval)
        -- upvalues: Players (upval), a1 (val), u58 (upval), u62 (upval), u66 (upval), ghostFor (upval)
        -- upvalues: normalizeGhost (upval), Flash (upval), u79 (upval), RiftTradeIn (upval), freeze (upval)
        -- upvalues: RunService (upval), driveNumber (upval), TweenService (upval), bezier (upval), neonSurge (upval)
        -- upvalues: groundBurst (upval)
        local u0 = false

        local function deliver() -- Line: 269 -- upvalues: u0 (ref), a2 (upval)
            if not u0 then
                u0 = true
                task.spawn(a2)
            end
        end

        local u4 = Trove.new()
        local World = Workspace:FindFirstChild("World") and Workspace.World:FindFirstChild("Machines") and (Workspace.World.Machines:FindFirstChild("OldRiftMachine") or Workspace.World.Machines:FindFirstChild("RiftMachine"))
        local Rift = World
        if Rift then
            Rift = World:FindFirstChild("Rift")
        end
        if World and Rift and Rift:IsA("Model") then
            local success, err = pcall(function() -- Line: 287
                -- upvalues: Rift (val), heartOf (upval), flatDiscBottom (upval), setRiftShown (upval), u4 (val)
                -- upvalues: spawnPhase (upval), VFX (upval), Shake (upval), Sounds (upval), Audio (upval)
                -- upvalues: Workspace (upval), Players (upval), a1 (upval), u58 (upval), u62 (upval), u66 (upval)
                -- upvalues: ghostFor (upval), normalizeGhost (upval), Flash (upval), u79 (upval), RiftTradeIn (upval)
                -- upvalues: freeze (upval), RunService (upval), driveNumber (upval), TweenService (upval)
                -- upvalues: bezier (upval), neonSurge (upval), groundBurst (upval), u0 (ref), a2 (upval)
                local Position_2, Y_3, v1, v2, v3, v4, v5, v6, v7, v8, v9
                local Pivot = Rift:GetPivot()
                local u10 = heartOf(Rift)
                if not u10 then
                    u10 = Pivot:PointToWorldSpace((Vector3.new(0, 10.039999961853027, 0)))
                end
                local v10 = flatDiscBottom(Rift)
                local v11 = if not v10 then nil else v10 + 0.04
                v10 = Pivot.LookVector * Vector3.new(1, 0, 1)
                local Unit_2 = if not (0.05 < v10.Magnitude) then Vector3.new(0, 0, 1) else v10.Unit
                local u1485 = {}
                for i, j in Rift:GetDescendants() do
                    if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
                        u1485[j] = j.Enabled
                    end
                end
                setRiftShown(Rift, false, u1485)
                u4:Add(function() -- Line: 302 -- upvalues: setRiftShown (upval), Rift (upval), u1485 (val)
                    setRiftShown(Rift, true, u1485)
                end)
                local v12 = spawnPhase(u4, "Phase1", Pivot, u10, v11)
                VFX.EmitTree(v12, true)
                Shake.Play({Seconds = 0.7, Magnitude = 1.6})
                local ImpactBoom = Sounds:FindFirstChild("ImpactBoom") or Sounds:FindFirstChild("ImpactBoom", true)
                local v13 = if ImpactBoom ~= nil then if not ImpactBoom:IsA("Sound") then ImpactBoom:FindFirstChildWhichIsA("Sound") else ImpactBoom else nil
                if v13 then
                    Audio.Play(v13, u10, {Volume = 0.9, PlaybackSpeed = 0.75})
                end
                local CinematicRiser = Sounds:FindFirstChild("CinematicRiser") or Sounds:FindFirstChild("CinematicRiser", true)
                v13 = if CinematicRiser ~= nil then if not CinematicRiser:IsA("Sound") then CinematicRiser:FindFirstChildWhichIsA("Sound") else CinematicRiser else nil
                if v13 then
                    Audio.Play(v13, u10, {Volume = 0.6})
                end
                v13 = RaycastParams.new()
                v13.FilterType = Enum.RaycastFilterType.Exclude
                local v14 = {Workspace:WaitForChild("Transient"), Rift}
                local Character = Players.LocalPlayer.Character
                if Character then
                    table.insert(v14, Character)
                end
                v13.FilterDescendantsInstances = v14
                local u1444 = {}
                v14 = #a1
                local v15 = nil
                local v16 = nil
                for k, n in a1, v15, v16 do
                    if not (v14 <= #u58) then
                        v1 = (k - 1) * (160 / (v14 - 1)) + -80
                        v2 = k % 3 * 0.7 + 8.4
                        v3 = k * 2 % 5 + -2
                    else
                        v1 = u58[k]
                        v2 = u62[k]
                        v3 = u66[k]
                    end
                    v1 = u10 + CFrame.fromAxisAngle(Vector3.new(0, 1, 0), (math.rad(v1))) * Unit_2 * v2 + Vector3.new(0, v3, 0)
                    v4 = Workspace:Raycast(Vector3.new(v1.X, u10.Y + 14, v1.Z), Vector3.new(0, -80, 0), v13)
                    Y_3 = if not v4 then u10.Y - 6 else v4.Position.Y
                    v4 = ghostFor(n)
                    v5, v6 = normalizeGhost(v4)
                    v2 = Y_3 + v6 + 0.2
                    v6 = CFrame.lookAt(Vector3.new(v1.X, v2, v1.Z), (Vector3.new(u10.X, v2, u10.Z)))
                    v3 = CFrame.lookAt(v1, (Vector3.new(u10.X, v1.Y, u10.Z)))
                    v4:PivotTo(v6)
                    v4.Parent = Workspace:WaitForChild("Transient")
                    u4:Add(v4)
                    table.insert(u1444, {
                        state = "ground",
                        model = v4,
                        hover = v3,
                        bobPhase = k * 2.3,
                        baseScale = v5,
                    })
                end
                task.wait(0.55)
                v14 = spawnPhase(u4, "Phase2", Pivot, u10, v11)
                Flash.Play({Attack = 0.06, Decay = 0.22, Opacity = 0.45, Tint = u79})
                v12:Destroy()
                local u1317 = v14
                VFX.EmitTree(u1317, true)
                v14 = heartOf(u1317) or u10
                local BasePart = u1317:FindFirstChildWhichIsA("BasePart", true)
                v15 = nil
                if BasePart then
                    local Attachment = Instance.new("Attachment")
                    Attachment.Parent = BasePart
                    Attachment.WorldPosition = v14
                    v15 = Attachment
                end
                local v17 = nil
                local v18 = nil
                for m, i5 in u1444, v17, v18 do
                    local u1320 = RiftTradeIn:FindFirstChild("PetFX"):Clone()
                    freeze(u1320)
                    u1320.CFrame = i5.model:GetPivot()
                    u1320.Parent = Workspace:WaitForChild("Transient")
                    u4:Add(u1320)
                    i5.fx = u1320
                    for i6, i7 in u1320:GetDescendants() do
                        if i7:IsA("Beam") then
                            if i7.Attachment1 == nil then
                                v14 = Instance.new("Attachment")
                                v14.Parent = u1320
                                i7.Attachment1 = v14
                            end
                            if v15 then
                                i7.Attachment0 = v15
                            end
                        end
                    end
                    task.delay(m * 0.08, function() -- Line: 386 -- upvalues: u1320 (val), VFX (upval)
                        if u1320.Parent then
                            VFX.EmitTree(u1320, true)
                        end
                    end)
                end
                u4:Connect(RunService.Heartbeat, function() -- Line: 393 -- upvalues: u1444 (val)
                    local v1, v2
                    for i, j in u1444 do
                        if j.state == "hover" and j.model.Parent then
                            v1 = os.clock() * 2.4 + j.bobPhase
                            v2 = j.hover * CFrame.new(math.cos(v1 * 0.7) * 0.18, math.sin(v1) * 0.45, 0)
                            j.model:PivotTo(v2)
                            if j.fx and j.fx.Parent then
                                j.fx.CFrame = v2
                            end
                        end
                    end
                end)
                for i8, i9 in u1444 do
                    task.delay((i8 - 1) * 0.28, function() -- Line: 407 -- upvalues: i9 (val), i8 (val), Sounds (upval), Audio (upval), driveNumber (upval), u4 (upval)
                        local model = i9.model
                        if not model.Parent then
                            return
                        end
                        local Pivot = model:GetPivot()
                        local Position = i9.hover.Position
                        local v1 = i8 * 0.06 + 1.1
                        local MechaShake = Sounds:FindFirstChild("MechaShake") or Sounds:FindFirstChild("MechaShake", true)
                        local v2 = if MechaShake ~= nil then if not MechaShake:IsA("Sound") then MechaShake:FindFirstChildWhichIsA("Sound") else MechaShake else nil
                        if v2 then
                            Audio.Play(v2, Position, {Volume = 0.35, PlaybackSpeed = v1})
                        end
                        driveNumber(u4, 0, 1, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), function(a1) -- Line: 414 -- upvalues: model (val), i9 (upval), Pivot (val)
                            if model.Parent and i9.state == "ground" then
                                local v1 = Pivot:Lerp(i9.hover, a1)
                                model:PivotTo(v1)
                                if i9.fx and i9.fx.Parent then
                                    i9.fx.CFrame = v1
                                end
                            end
                        end)
                        task.delay(0.9, function() -- Line: 423 -- upvalues: i9 (upval)
                            if i9.state == "ground" then
                                i9.state = "hover"
                            end
                        end)
                    end)
                end
                task.wait((#u1444 - 1) * 0.28 + 0.9 + 1.15)
                for i10, i11 in u1444 do
                    task.delay((i10 - 1) * 0.7, function() -- Line: 434
                        -- upvalues: i11 (val), u10 (val), TweenService (upval), driveNumber (upval), u4 (upval)
                        -- upvalues: bezier (upval), i10 (val), Sounds (upval), Audio (upval), u1317 (ref), VFX (upval)
                        local model = i11.model
                        if not model.Parent then
                            return
                        end
                        i11.state = "pulling"
                        local Pivot = model:GetPivot()
                        local u15 = (Pivot.Position:Lerp(u10, 0.45)) + Vector3.new(0, 1.600000023841858, 0)
                        if i11.fx then
                            local v1, v2, v3
                            for i, j in i11.fx:GetDescendants() do
                                if j:IsA("Beam") then
                                    v3 = TweenService
                                    v1 = TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                                    v2 = {
                                        Width0 = j.Width0 * 0.25,
                                        Width1 = j.Width1 * 0.25,
                                    }
                                    v3:Create(j, v1, v2):Play()
                                end
                            end
                        end
                        driveNumber(u4, 0, 1, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), function(a1) -- Line: 449 -- upvalues: model (val), bezier (upval), Pivot (val), u15 (val), u10 (upval), i11 (upval)
                            if model.Parent then
                                local v1 = (CFrame.new(bezier(Pivot.Position, u15, u10, a1))) * Pivot.Rotation
                                model:PivotTo(v1)
                                model:ScaleTo(i11.baseScale * (math.max(1 - a1 * 0.7, 0.3)))
                                if i11.fx and i11.fx.Parent then
                                    i11.fx.CFrame = v1
                                end
                            end
                        end)
                        task.delay(0.85, function() -- Line: 459
                            -- upvalues: u10 (upval), i10 (upval), Sounds (upval), Audio (upval), u1317 (upval)
                            -- upvalues: VFX (upval), i11 (upval), model (val)
                            local v1 = u10
                            local v2 = i10 * 0.12 + 0.9
                            local ImpactBoom = Sounds:FindFirstChild("ImpactBoom") or Sounds:FindFirstChild("ImpactBoom", true)
                            local v3 = if ImpactBoom ~= nil then if not ImpactBoom:IsA("Sound") then ImpactBoom:FindFirstChildWhichIsA("Sound") else ImpactBoom else nil
                            if v3 then
                                Audio.Play(v3, v1, {Volume = 0.7, PlaybackSpeed = v2})
                            end
                            if u1317.Parent then
                                VFX.EmitTree(u1317, 6)
                            end
                            if i11.fx then
                                i11.fx:Destroy()
                            end
                            model:Destroy()
                        end)
                    end)
                end
                task.wait((#u1444 - 1) * 0.7 + 0.85 + 0.35)
                v15 = spawnPhase(u4, "Phase3", Pivot, u10, v11)
                Flash.Play({Attack = 0.08, Decay = 0.3, Opacity = 0.55, Tint = u79})
                u1317:Destroy()
                u1317 = v15
                VFX.EmitTree(u1317, true)
                local CinematicRiser_2 = Sounds:FindFirstChild("CinematicRiser") or Sounds:FindFirstChild("CinematicRiser", true)
                v15 = if CinematicRiser_2 ~= nil then if not CinematicRiser_2:IsA("Sound") then CinematicRiser_2:FindFirstChildWhichIsA("Sound") else CinematicRiser_2 else nil
                if v15 then
                    Audio.Play(v15, u10, {Volume = 0.85, PlaybackSpeed = 1.05})
                end
                Shake.Play({Seconds = 0.4, Magnitude = 2.8})
                driveNumber(u4, 1, 1.12, TweenInfo.new(2.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), function(a1) -- Line: 481 -- upvalues: u1317 (ref)
                    if u1317.Parent then
                        u1317:ScaleTo(a1)
                    end
                end)
                task.delay(1.54, function() -- Line: 486 -- upvalues: u1317 (ref), neonSurge (upval), u4 (upval), VFX (upval)
                    if u1317.Parent then
                        neonSurge(u4, u1317)
                        VFX.EmitTree(u1317, true)
                    end
                end)
                task.wait(2.8)
                Flash.Play({Attack = 0.1, Decay = 0.55, Opacity = 0.9, Tint = Color3.new(1, 1, 1)})
                Shake.Play({Seconds = 1, Magnitude = 2})
                local CinematicBoom = Sounds:FindFirstChild("CinematicBoom") or Sounds:FindFirstChild("CinematicBoom", true)
                v16 = if CinematicBoom ~= nil then if not CinematicBoom:IsA("Sound") then CinematicBoom:FindFirstChildWhichIsA("Sound") else CinematicBoom else nil
                if v16 then
                    Audio.Play(v16, u10, {Volume = 1})
                end
                v16 = spawnPhase(u4, "Phase4", Pivot, u10, v11)
                local u1162 = heartOf(v16) or u10
                local EggSpawn = v16:FindFirstChild("EggSpawn", true)
                v18 = nil
                if EggSpawn then
                    local Part = Instance.new("Part")
                    Part.Size = Vector3.new(1, 1, 1)
                    Part.CFrame = CFrame.new(u1162)
                    Part.Anchored = true
                    Part.CanCollide = false
                    Part.CanQuery = false
                    Part.CanTouch = false
                    Part.CastShadow = false
                    Part.Transparency = 1
                    Part.Parent = Workspace:WaitForChild("Transient")
                    u4:Add(Part)
                    EggSpawn.Parent = Part
                    if EggSpawn:IsA("Attachment") then
                        EggSpawn.CFrame = CFrame.identity
                    end
                    v18 = Part
                end
                VFX.EmitTree(v16, true)
                for i12, i13 in u1485 do
                    if i12:IsA("ParticleEmitter") and i12.Parent then
                        i12.Enabled = i13
                    end
                end
                task.wait(0.3)
                local u1171 = RiftTradeIn:FindFirstChild("Egg"):Clone()
                freeze(u1171)
                u1171.Parent = Workspace:WaitForChild("Transient")
                u4:Add(u1171)
                v1 = nil
                v2 = nil
                for i14, i15 in u1171:GetDescendants() do
                    if i15:IsA("BasePart") and i15.Transparency < 0.95 then
                        v7 = i15.Size * 0.5
                        v1 = if not v1 then i15.Position - v7 else v1:Min(i15.Position - v7)
                        v2 = if not v2 then i15.Position + v7 else v2:Max(i15.Position + v7)
                    end
                end
                v3 = 2.4
                if v1 and v2 then
                    u1171.WorldPivot = CFrame.new((v1 + v2) * 0.5)
                    v3 = (v2.Y - v1.Y) * 0.5
                end
                v1 = Sounds:FindFirstChild("MechaHatch") or Sounds:FindFirstChild("MechaHatch", true)
                v2 = if v1 ~= nil then if not v1:IsA("Sound") then v1:FindFirstChildWhichIsA("Sound") else v1 else nil
                if v2 then
                    Audio.Play(v2, u1162, {Volume = 0.9, PlaybackSpeed = 1.1})
                end
                if v18 then
                    VFX.EmitTree(v18, true)
                end
                u1317:Destroy()
                u1317 = v16
                local Character_2 = Players.LocalPlayer.Character
                v16 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
                v18 = if not v16 then Unit_2 else (v16.Position - u1162) * Vector3.new(1, 0, 1)
                local Unit_3 = if not (0.05 < v18.Magnitude) then Unit_2 else v18.Unit
                v10 = math.clamp(v18.Magnitude * 0.7, 8, 14)
                v18 = Vector3.new(u1162.X + Unit_3.X * v10, u1162.Y + 6, u1162.Z + Unit_3.Z * v10)
                v4 = Workspace:Raycast(v18, Vector3.new(0, -90, 0), v13)
                local u696 = (if not v4 then Vector3.new(v18.X, Pivot.Position.Y + 2.6, v18.Z) else v4.Position) + Vector3.new(0, v3, 0)
                u1171:PivotTo((CFrame.new(u1162)))
                u1171:ScaleTo(0.45)
                v3 = (math.max(u1162.Y, u696.Y)) + 5
                local u742 = Vector3.new(u1162.X + Unit_3.X * v10 * 0.55, v3 * 2 - (u1162.Y + u696.Y) * 0.5, u1162.Z + Unit_3.Z * v10 * 0.55)
                v5 = Vector3.new(0, 1, 0):Cross(Unit_3)
                local Unit = if not (0.001 < v5.Magnitude) then Vector3.new(1, 0, 0) else v5.Unit
                driveNumber(u4, 0, 1, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), function(a1) -- Line: 580 -- upvalues: u1171 (val), bezier (upval), u1162 (val), u742 (val), u696 (val), Unit (ref)
                    if u1171.Parent then
                        local v1 = 1 - (1 - a1) * (1 - a1)
                        u1171:PivotTo((CFrame.new(bezier(u1162, u742, u696, v1))) * (CFrame.fromAxisAngle(Unit, 12.566370614359172 * v1)))
                        u1171:ScaleTo((math.min(0.45 + 0.55 * a1 * 2, 1)))
                    end
                end)
                task.wait(0.9)
                if u1171.Parent then
                    u1171:ScaleTo(1)
                    u1171:PivotTo((CFrame.new(u696)))
                end
                v16 = Sounds:FindFirstChild("ChestLanding") or Sounds:FindFirstChild("ChestLanding", true)
                v3 = if v16 ~= nil then if not v16:IsA("Sound") then v16:FindFirstChildWhichIsA("Sound") else v16 else nil
                if v3 then
                    Audio.Play(v3, u696, {Volume = 1})
                end
                groundBurst(u4, Position_2)
                Shake.Play({Seconds = 1, Magnitude = 0.5})
                Flash.Play({Attack = 0.05, Decay = 0.2, Opacity = 0.4, Tint = u79})
                driveNumber(u4, 0, 1, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), function(a1) -- Line: 598 -- upvalues: u1171 (val), u696 (val)
                    if u1171.Parent then
                        local v1 = 1 - a1
                        local v2 = math.sin(a1 * 3.141592653589793) * v1 * 1.4
                        local v3 = math.sin(a1 * 3.141592653589793 * 4) * v1 * 0.20943951023931956
                        u1171:PivotTo((CFrame.new(u696 + Vector3.new(0, v2, 0))) * (CFrame.Angles(0, 0, v3)))
                    end
                end)
                task.wait(0.4)
                if u1171.Parent then
                    u1171:PivotTo((CFrame.new(u696)))
                end
                task.wait(0.3)
                local Position = u1171:GetPivot().Position
                driveNumber(u4, 0, 1, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), function(a1) -- Line: 613 -- upvalues: u1171 (val), Players (upval), Position (val)
                    local v1
                    if not u1171.Parent then
                        return
                    end
                    local Character = Players.LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    local v2 = (Position + (if not HumanoidRootPart then Position else HumanoidRootPart.Position + Vector3.new(0, 1.5, 0))) * 0.5
                    local Magnitude = ((Position - v1) * Vector3.new(1, 0, 1)).Magnitude
                    local v3 = Vector3.new(v2.X, (math.max(Position.Y, v1.Y)) + Magnitude * 0.5 + 2.5, v2.Z)
                    local v4 = a1 * a1
                    v2 = (Position:Lerp(v3, v4)):Lerp(v3:Lerp(v1, v4), v4)
                    v3 = Vector3.new(v1.X, v2.Y, v1.Z)
                    u1171:PivotTo(if not ((v2 - v3).Magnitude < 0.001) then CFrame.lookAt(v2, v3) else CFrame.new(v2))
                    v3 = math.clamp((a1 - 0.55) / 0.45, 0, 1)
                    u1171:ScaleTo((math.max(1 - v3 * v3 * v3, 0.01)))
                end)
                task.wait(0.6)
                local Character_3 = Players.LocalPlayer.Character
                local v19 = Character_3 and Character_3:FindFirstChild("HumanoidRootPart")
                v10 = if not v19 then Position else v19.Position + Vector3.new(0, 1, 0)
                v19 = RiftTradeIn:FindFirstChild("Aura"):Clone()
                freeze(v19)
                v19:PivotTo((CFrame.new(v10)))
                v19.Parent = Workspace:WaitForChild("Transient")
                u4:Add(v19)
                for i16, i17 in v19:GetDescendants() do
                    if i17:IsA("BasePart") then
                        i17.LocalTransparencyModifier = 1
                    end
                end
                VFX.EmitTree(v19, true)
                local MechaShake = Sounds:FindFirstChild("MechaShake") or Sounds:FindFirstChild("MechaShake", true)
                v6 = if MechaShake ~= nil then if not MechaShake:IsA("Sound") then MechaShake:FindFirstChildWhichIsA("Sound") else MechaShake else nil
                if v6 then
                    Audio.Play(v6, v10, {Volume = 0.5, PlaybackSpeed = 1.35})
                end
                if not u0 then
                    u0 = true
                    task.spawn(a2)
                end
                task.wait(0.9)
                for i18, i19 in u1317:GetDescendants() do
                    if i19:IsA("ParticleEmitter") then
                        i19.Enabled = false
                    elseif i19:IsA("BasePart") then
                        v8 = TweenService
                        v9 = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                        v8:Create(i19, v9, {LocalTransparencyModifier = 1}):Play()
                    end
                end
                for i20, i21 in v19:GetDescendants() do
                    if i21:IsA("ParticleEmitter") then
                        i21.Enabled = false
                    end
                end
                for i22, i23 in Rift:GetDescendants() do
                    if i23:IsA("BasePart") then
                        v8 = TweenService
                        v9 = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                        v8:Create(i23, v9, {LocalTransparencyModifier = 0}):Play()
                    end
                end
                task.delay(0.66, function() -- Line: 669 -- upvalues: u1485 (val)
                    local v1 = nil
                    local v2 = nil
                    for i, j in u1485, v1, v2 do
                        if i:IsA("Beam") then
                            if i.Parent then
                                i.Enabled = j
                            end
                        elseif i:IsA("Light") and i.Parent then
                            i.Enabled = j
                        end
                    end
                end)
                task.wait(2.5)
            end)
            u4:Clean()
            if not success then
                warn((("Rift sequence failed: %*"):format(err)))
            end
            if not u0 then
                task.spawn(a2)
            end
            u81 = false
            return
        end
        if not u0 then
            task.spawn(a2)
        end
        u81 = false
    end)
end

return (table.freeze(v1))