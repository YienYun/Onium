-- Script path: ReplicatedStorage.Controllers.Game.PetWheelController
-- Decompile time: 32.54 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PetWheel = require(ReplicatedStorage.Data.PetWheel)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Shake = require(ReplicatedStorage.Client.Shake)
local Spring = require(ReplicatedStorage.Packages.Spring)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u118 = NumberRange.new(4.6, 5.6)
local u123 = Color3.fromRGB(70, 40, 110)
local u128 = Color3.fromRGB(255, 236, 170)
local u133 = Color3.fromRGB(150, 140, 175)
local u134 = {PetWheel = true, OverlayUI = true}
local LocalPlayer = Players.LocalPlayer
local u138 = Random.new()
local u139 = false
local v1 = {}

local function spinCurve(a1) -- Line: 98 -- types: a1: number
    if a1 < 0.06 then
        return (a1 / 0.06) ^ 2 * 0.07
    end
    return (1 - (1 - (a1 - 0.06) / 0.94) ^ 4) * 0.9299999999999999 + 0.07
end

local function petName(a1) -- Line: 108 -- upvalues: Directory (val) -- types: a1: string
    return Directory[a1].DisplayName
end

local function mutationColor(a1) -- Line: 112 -- upvalues: Mutations (val), u133 (val) -- types: a1: string
    if a1 == Mutations.NO_MUTATION then
        return u133
    end
    return assert(Mutations.Get(a1), (("Unknown mutation %*"):format(a1))).Tint
end

local function playSound(a1, a2) -- Line: 119 -- upvalues: Audio (val) -- types: a1: number, a2: number?
    return Audio.Play(a1, script, {Volume = a2 or 0.8})
end

function v1.Start() -- Line: 123
    -- upvalues: Workspace (val), LocalPlayer (val), ReplicatedStorage (val), Spring (val), u128 (val), PetWheel (val)
    -- upvalues: Audio (val), u138 (val), u118 (val), RunService (val), TweenService (val), u123 (val), Debris (val)
    -- upvalues: SwapGradient (val), Mutations (val), u133 (val), ItemDisplay (val), ModelBounds (val), Flash (val)
    -- upvalues: Shake (val), Confetti (val), Rarities (val), Directory (val), u134 (val), Players (val)
    -- upvalues: StarterGui (val), ProximityPromptService (val), u139 (ref), Trove (val), HiddenUIHandler (val)
    -- upvalues: Remotes (val), Toast (val)
    local v1
    local Machines = (Workspace:WaitForChild("World")):WaitForChild("Machines")
    local PetWheel_2 = Machines:FindFirstChild("PetWheel")
    while not PetWheel_2 do
        v1 = Machines.ChildAdded:Wait()
        PetWheel_2 = if v1.Name ~= "PetWheel" then nil else v1
    end
    assert(PetWheel_2:IsA("Model"), "PetWheel must be a Model")
    local v2 = PetWheel_2:WaitForChild("Root")
    local PetSpot = v2:WaitForChild("PetSpot")
    local WideFocus = v2:WaitForChild("WideFocus")
    local Attribute = PetWheel_2:GetAttribute("WideRadius")
    local PetLight = ((PetWheel_2:WaitForChild("Body")):WaitForChild("PedestalTop")):WaitForChild("PetLight")
    local ProximityPrompt = ((PetWheel_2:WaitForChild("Machine")):WaitForChild("Attachment")):WaitForChild("ProximityPrompt")
    local PetWheel_3 = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("PetWheel")
    local Banner = PetWheel_3:WaitForChild("Banner")
    local Heading = Banner:WaitForChild("Heading")
    local Result = Banner:WaitForChild("Result")
    local Detail = Banner:WaitForChild("Detail")
    local Sparkles = ReplicatedStorage.Assets.Particles.Sparkles
    local PlayerModule = require(((LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule")))
    local u114 = -v2.CFrame.LookVector

    local function buildWheel(a1, a2) -- Line: 150
        -- upvalues: PetWheel_2 (ref), Spring (upval), u128 (upval)
        local v1
        local v2 = PetWheel_2:WaitForChild((("%*Wheel"):format(a1)))
        assert((v2:GetAttribute("Segments")) == #a2, (("PetWheel %*Wheel was built for a different segment list; rebuild it"):format(a1)))
        local Hub = v2:WaitForChild("Hub")
        local Pivot = (PetWheel_2:WaitForChild((("%*Pointer"):format(a1)))):WaitForChild("Pivot")
        local v3 = {}
        for i, j in PetWheel_2:WaitForChild((("%*Bulbs"):format(a1))):GetChildren() do
            v3[j:GetAttribute("Index")] = j
        end
        local v4 = 0
        for k, n in a2 do
            v4 = v4 + n.Weight
        end
        local v5 = {}
        local v6 = {}
        local v7 = {}
        local v8 = 0
        for m, i5 in a2 do
            v5[m] = v8
            v6[m] = i5.Weight / v4 * 6.283185307179586
            table.insert(v7, (6.283185307179586 - v8) % 6.283185307179586)
            v8 = v8 + v6[m]
        end
        table.sort(v7)
        v8 = {}
        for i6, i7 in v2:GetDescendants() do
            v4 = i7:GetAttribute("Segment")
            if typeof(v4) == "number" and i7:IsA("BasePart") then
                v1 = v8[v4] or {}
                v8[v4] = v1
                table.insert(v8[v4], i7)
            end
        end
        local v9 = Spring.new(0)
        v9.Speed = 22
        v9.Damper = 0.42
        return {
            Angle = 0,
            Count = 0,
            BulbMode = "Idle",
            LastTick = 0,
            Hub = Hub,
            Rest = Hub.CFrame,
            Pointer = Pivot,
            PointerRest = Pivot.CFrame,
            PointerSpring = v9,
            Bulbs = v3,
            BulbColor = u128,
            Starts = v5,
            Spans = v6,
            Marks = v7,
            Radius = v2:GetAttribute("Radius"),
            Slices = v8,
        }
    end

    local u120 = buildWheel("Rarity", PetWheel.Rarity)
    local u125 = buildWheel("Mutation", PetWheel.Mutation)
    local u126 = {u120, u125}

    local function crossings(a1, a2) -- Line: 210 -- types: a1: table, a2: number
        local v1 = math.floor(a2 / 6.283185307179586)
        local v2 = a2 - v1 * 6.283185307179586
        local v3 = 0
        for i, j in a1.Marks do
            if j <= v2 then
                v3 = v3 + 1
            end
        end
        return v1 * #a1.Marks + v3
    end

    local function render(a1, a2, a3) -- Line: 222
        -- upvalues: Audio (upval)
        a1.Hub.CFrame = a1.Rest * CFrame.Angles(0, 0, -a2)
        local v1 = math.floor(a2 / 6.283185307179586)
        local v2 = a2 - v1 * 6.283185307179586
        local v3 = 0
        for i, j in a1.Marks do
            if j <= v2 then
                v3 = v3 + 1
            end
        end
        local v4 = v1 * #a1.Marks + v3
        if a3 and a1.Count < v4 then
            a1.PointerSpring:Impulse(38 * a1.PointerSpring.Speed)
            v1 = os.clock()
            if 0.035 < v1 - a1.LastTick then
                a1.LastTick = v1
                Audio.Play(137872392480008, script, {Volume = 0.75, PlaybackSpeed = {0.96, 1.06}})
            end
        end
        a1.Count = v4
    end

    local function landingAngle(a1, a2) -- Line: 236 -- upvalues: u138 (upval) -- types: a1: table, a2: number
        local v1 = u138:NextNumber()
        local v2 = if not (v1 < 0.24) then if not (v1 < 0.48) then u138:NextNumber(0.25, 0.75) else u138:NextNumber(0.86, 0.95) else u138:NextNumber(0.05, 0.14)
        return a1.Starts[a2] + a1.Spans[a2] * v2
    end

    local function spin(a1, a2) -- Line: 245
        -- upvalues: landingAngle (val), u138 (upval), u118 (upval), Audio (upval), render (val), RunService (upval)
        -- upvalues: TweenService (upval)
        local Angle = a1.Angle
        local v1 = -(landingAngle(a1, a2)) % 6.283185307179586
        local v2 = Angle - Angle % 6.283185307179586 + v1 + 6.283185307179586 * u138:NextInteger(4, 6)
        v1 = math.rad((u138:NextNumber(1.5, 3.2)))
        local v3 = v2 - v1
        local v4 = u138:NextNumber(u118.Min, u118.Max)
        local v5 = math.floor(Angle / 6.283185307179586)
        local v6 = Angle - v5 * 6.283185307179586
        local v7 = 0
        for i, j in a1.Marks do
            if j <= v6 then
                v7 = v7 + 1
            end
        end
        a1.Count = v5 * #a1.Marks + v7
        a1.BulbMode = "Spin"
        Audio.Play(3755636638, script, {Volume = 0.6})
        local v8 = nil
        v5 = os.clock()
        local v9 = a1
        while true do
            v6 = math.clamp((os.clock() - v5) / v4, 0, 1)
            render(
                v9,
                Angle + (v3 - Angle) * (if not (v6 < 0.06) then (1 - (1 - (v6 - 0.06) / 0.94) ^ 4) * 0.9299999999999999 + 0.07 else (v6 / 0.06) ^ 2 * 0.07),
                true
            )
            if v6 >= 0.5 and v8 == nil then
                v8 = Audio.Play(101937236820642, script, {Volume = 0.45})
            end
            if v6 >= 1 then
                break
            end
            RunService.RenderStepped:Wait()
        end
        task.wait(0.14)
        v5 = os.clock()
        while true do
            v4 = math.clamp((os.clock() - v5) / 0.5, 0, 1)
            render(v9, v3 + v1 * (TweenService:GetValue(v4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)), true)
            if v4 >= 1 then
                break
            end
            RunService.RenderStepped:Wait()
        end
        if v8 then
            v8:Stop()
        end
        v9.Angle = v2 % 6.283185307179586
        local Angle_2 = v9.Angle
        v9.Hub.CFrame = v9.Rest * CFrame.Angles(0, 0, -Angle_2)
        v8 = math.floor(Angle_2 / 6.283185307179586)
        v3 = Angle_2 - v8 * 6.283185307179586
        v2 = 0
        for k, n in v9.Marks do
            if n <= v3 then
                v2 = v2 + 1
            end
        end
        v9.Count = v8 * #v9.Marks + v2
    end

    local function shot(a1, a2, a3) -- Line: 313
        -- upvalues: Workspace (upval), u114 (val)
        local CurrentCamera = Workspace.CurrentCamera
        local ViewportSize = CurrentCamera.ViewportSize
        return CFrame.lookAt(
            a1 + (u114 + (Vector3.new(0, a3, 0))).Unit * (a2 / (math.tan((math.rad(CurrentCamera.FieldOfView / 2))) * math.min(1, if not (0 < ViewportSize.Y) then 1 else ViewportSize.X / ViewportSize.Y)) * 1.06),
            a1
        )
    end

    local function moveCamera(a1, a2) -- Line: 323
        -- upvalues: Workspace (upval), TweenService (upval)
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = TweenService:Create(CurrentCamera, TweenInfo.new(a2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {CFrame = a1})
        v1:Play()
        v1.Completed:Wait()
    end

    local function focusWheel(a1) -- Line: 334
        -- upvalues: moveCamera (val), shot (val), TweenService (upval), Workspace (upval), u118 (upval)
        local v1 = a1.Rest.Position + Vector3.new(0, 0.5, 0)
        moveCamera(shot(v1, a1.Radius * 1.15, 0.03), 0.75)
        TweenService:Create(
            Workspace.CurrentCamera,
            TweenInfo.new(u118.Min, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {CFrame = shot(v1, a1.Radius * 0.92, 0)}
        ):Play()
    end

    local function glowSegment(a1, a2) -- Line: 344 -- types: a1: table, a2: number
        local v1 = a1.Slices[a2]
        local u4 = {}
        for i, j in v1 do
            u4[j] = j.Color
        end
        task.spawn(function() -- Line: 350 -- upvalues: u4 (val)
            local Neon, v1, v2, v3, v4, v5
            for i = 1, 8 do
                v2 = i % 2 == 1
                v3 = nil
                v4 = nil
                for j, k in u4, v3, v4 do
                    Neon = if not v2 then Enum.Material.SmoothPlastic else Enum.Material.Neon
                    j.Material = Neon
                    if not v2 then
                        v5 = k
                    else
                        v1 = Color3.new(1, 1, 1)
                        v5 = k:Lerp(v1, 0.25)
                    end
                    j.Color = v5
                end
                task.wait(0.14)
            end
            for n, m in u4 do
                n.Material = Enum.Material.SmoothPlastic
                n.Color = m
            end
        end)
    end

    local function burst(a1, a2, a3) -- Line: 366
        -- upvalues: Workspace (upval), Sparkles (val), Debris (upval)
        local v1
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Transparency = 1
        Part.Size = Vector3.new(1, 1, 1)
        Part.CFrame = CFrame.new(a1)
        Part.Parent = Workspace
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = Part
        for i, j in Sparkles:GetChildren() do
            if j:IsA("ParticleEmitter") then
                v1 = j:Clone()
                v1.Color = ColorSequence.new(a2, Color3.new(1, 1, 1))
                v1.Enabled = false
                v1.Parent = Attachment
                v1:Emit(a3)
            end
        end
        Debris:AddItem(Part, 4)
    end

    local function setLabel(a1, a2) -- Line: 390 -- upvalues: TweenService (upval) -- types: a1: userdata, a2: string
        a1.Text = a2
        a1.Visible = true
        local Pop = a1:FindFirstChild("Pop")
        Pop.Scale = 0.2
        TweenService:Create(Pop, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end

    local function paintResult(a1, a2) -- Line: 402
        -- upvalues: SwapGradient (upval), Result (val)
        if a2 then
            SwapGradient(Result, a2)
            return
        end
        local UIGradient = Result:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
        UIGradient.Color = a1 or ColorSequence.new(Color3.new(1, 1, 1))
        UIGradient.Transparency = NumberSequence.new(0)
        UIGradient.Rotation = 90
        UIGradient.Offset = Vector2.zero
        UIGradient.Parent = Result
    end

    local function mutationColors(a1) -- Line: 415 -- upvalues: Mutations (upval), u133 (upval) -- types: a1: string
        if a1 == "Rainbow" then
            local v1 = {}
            for i = 0, 6 do
                table.insert(v1, (ColorSequenceKeypoint.new(i / 6, (Color3.fromHSV(i / 6, 0.75, 1)))))
            end
            return ColorSequence.new(v1)
        end
        local Tint = if a1 ~= Mutations.NO_MUTATION then assert(Mutations.Get(a1), (("Unknown mutation %*"):format(a1))).Tint else u133
        return ColorSequence.new(Tint:Lerp(Color3.new(1, 1, 1), 0.45), Tint)
    end

    local function placeDisplay(a1) -- Line: 427 -- upvalues: u114 (val) -- types: a1: table
        local Model = a1.Model
        local v1 = math.sin((os.clock()) * 1.3) * 0.35 + a1.Spin
        local v2 = math.sin((os.clock()) * 2.2) * 0.12
        local v3 = (CFrame.lookAt(Vector3.new(0, 0, 0), u114)) * CFrame.Angles(0, v1, 0)
        Model:PivotTo((CFrame.new(a1.Spot.Position + (Vector3.new(0, a1.Lift * a1.Size + v2, 0)))) * v3)
    end

    local function showPet(a1, a2) -- Line: 436
        -- upvalues: ItemDisplay (upval), u114 (val), ModelBounds (upval), Workspace (upval), PetSpot (val)
        local v1, v2
        local v3 = ItemDisplay.CreateActiveModel(nil, a1, true)
        v3.Name = "PetWheelDisplay"
        for i, j in v3:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
            end
        end
        v3:PivotTo((CFrame.lookAt(Vector3.new(0, 0, 0), u114)))
        _, v1 = ModelBounds(v3)
        local v4 = math.min(4.8 / v1.Y, 5.6 / (math.max(v1.X, v1.Z)))
        v3:ScaleTo((v3:GetScale()) * v4)
        v4, v2 = ModelBounds(v3)
        v1 = v3:GetPivot().Position.Y - (v4.Position.Y - v2.Y / 2)
        local Scale_2 = v3:GetScale()
        v3.Parent = Workspace
        a2:Add(v3)
        v4 = {
            Size = 1,
            Spin = 0,
            Model = v3,
            Spot = PetSpot.WorldCFrame,
            Lift = v1,
        }
        v4.Model:SetAttribute("FullScale", Scale_2)
        return v4
    end

    local function grow(a1, a2, a3, a4, a5) -- Line: 467
        -- upvalues: TweenService (upval), placeDisplay (val), RunService (upval)
        local Value, v1, v2
        local Attribute = a1.Model:GetAttribute("FullScale")
        local v3 = os.clock()
        local v4, v5, v6, v7 = a4, a5, a2, a3
        while true do
            v2 = math.clamp((os.clock() - v3) / v4, 0, 1)
            Value = TweenService:GetValue(v2, v5, if not (v6 < v7) then Enum.EasingDirection.In else Enum.EasingDirection.Out)
            v1 = v6 + (v7 - v6) * Value
            v8.Size = math.max(v1, 0.02)
            v8.Model:ScaleTo(Attribute * v8.Size)
            placeDisplay(v8)
            if v2 >= 1 then
                break
            end
            RunService.RenderStepped:Wait()
        end
    end

    local function swapPet(a1, a2, a3, a4) -- Line: 483
        -- upvalues: placeDisplay (val), RunService (upval), grow (val), burst (val), Flash (upval), Shake (upval)
        -- upvalues: Audio (upval), showPet (val)
        local v1 = os.clock()
        while true do
            if not (os.clock() - v1 < 0.7) then
                break
            end
            a1.Spin = a1.Spin + (os.clock() - v1) / 0.7 * 0.9
            placeDisplay(a1)
            RunService.RenderStepped:Wait()
        end
        grow(a1, a1.Size, 0, 0.16, Enum.EasingStyle.Quad)
        a1.Model:Destroy()
        burst(a1.Spot.Position + Vector3.new(0, 2.4000000953674316, 0), a4, 40)
        Flash.Play({Attack = 0.04, Decay = 0.4, Opacity = 0.6, Tint = a4})
        Shake.Play({Seconds = 0.35})
        Audio.Play(71827381891260, script, {Volume = 0.9})
        v1 = showPet(a2, a3)
        grow(v1, 0, 1, 0.5, Enum.EasingStyle.Back)
        return v1
    end

    local function celebrate(a1, a2, a3, a4) -- Line: 503
        -- upvalues: glowSegment (val), TweenService (upval), PetLight (val), Audio (upval), Flash (upval)
        -- upvalues: Shake (upval), burst (val), Confetti (upval), u128 (upval)
        a1.BulbMode = "Win"
        a1.BulbColor = a3
        glowSegment(a1, a2)
        local v1 = {Brightness = 3, Color = a3}
        TweenService:Create(PetLight, TweenInfo.new(0.4), v1):Play()
        Audio.Play(138533090376585, script, {Volume = 0.7})
        Flash.Play({Attack = 0.03, Decay = 0.35, Opacity = 0.45, Tint = a3})
        Shake.Play({Seconds = 0.3})
        burst(a1.PointerRest.Position, a3, 30)
        if a4 then
            Audio.Play(81538018128209, script, {Volume = 0.9})
            local Burst = Confetti.Burst
            local v2 = {}
            local v3 = {}
            v1 = Color3.new(1, 1, 1)
            v3[1] = a3
            v3[2] = v1
            v3[3] = u128
            v2.Palette = v3
            Burst(v2)
        end
    end

    local function run(a1, a2) -- Line: 518
        -- upvalues: PetWheel (upval), Rarities (upval), Mutations (upval), Workspace (upval), PetSpot (val)
        -- upvalues: PetLight (val), moveCamera (val), shot (val), WideFocus (val), Attribute (val), showPet (val)
        -- upvalues: Audio (upval), burst (val), u128 (upval), grow (val), placeDisplay (val), RunService (upval)
        -- upvalues: Banner (val), Result (val), Detail (val), setLabel (val), Heading (val), focusWheel (val)
        -- upvalues: u120 (val), spin (val), celebrate (val), paintResult (val), swapPet (val), Directory (upval)
        -- upvalues: u125 (val), u133 (upval), mutationColors (val), Confetti (upval)
        local DisplayName_3
        local Before = a1.Before
        local After = a1.After
        local Id = PetWheel.Rarity[a1.Rarity].Id
        local Id_2 = PetWheel.Mutation[a1.Mutation].Id
        local v1 = Rarities[Id]
        local v2 = Id_2 ~= Mutations.NO_MUTATION
        local v3 = table.clone(After)
        v3.Mutations = Before.Mutations
        v3.BaseMutation = Before.BaseMutation
        local CurrentCamera = Workspace.CurrentCamera
        local CameraType = CurrentCamera.CameraType
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        a2:Add(function() -- Line: 531 -- upvalues: CurrentCamera (val), CameraType (val)
            CurrentCamera.CameraType = CameraType
        end)
        local v4 = PetSpot.WorldPosition + Vector3.new(0, 2.1600000858306885, 0)
        local Color = PetLight.Color
        local Brightness = PetLight.Brightness
        a2:Add(function() -- Line: 537 -- upvalues: PetLight (upval), Color (val), Brightness (val)
            local v1 = PetLight
            local v2 = Brightness
            PetLight.Color = Color
            v1.Brightness = v2
        end)
        moveCamera(shot(WideFocus.WorldPosition, Attribute, 0.1), 0.9)
        local u60 = showPet(Before, a2)
        Audio.Play(133204478644023, script, {Volume = 0.9})
        burst(v4, u128, 25)
        grow(u60, 0, 1, 0.45, Enum.EasingStyle.Back)
        local u79 = true
        a2:Add(function() -- Line: 547 -- upvalues: u79 (ref)
            u79 = false
        end)
        task.spawn(function() -- Line: 550 -- upvalues: u79 (ref), u60 (ref), placeDisplay (upval), RunService (upval)
            while u79 do
                if u60.Model.Parent then
                    placeDisplay(u60)
                end
                RunService.RenderStepped:Wait()
            end
        end)
        task.wait(0.5)
        Banner.Visible = true
        local v5 = Detail
        Result.Visible = false
        v5.Visible = false
        setLabel(Heading, "RARITY WHEEL")
        focusWheel(u120)
        spin(u120, a1.Rarity)
        celebrate(u120, a1.Rarity, v1.Color, 8 <= v1.Rank)
        paintResult(nil, v1.RarityGradient)
        setLabel(Result, (("%*!"):format((string.upper(v1.DisplayName)))))
        task.wait(1.2)
        moveCamera(shot(v4, 4.6, 0.18), 0.6)
        u60 = swapPet(u60, v3, a2, v1.Color)
        local v6 = setLabel
        v5 = Detail
        local Category = After.Category
        v6(v5, Directory[Category].DisplayName)
        task.wait(1.3)
        u120.BulbMode = "Idle"
        v5 = Detail
        Result.Visible = false
        v5.Visible = false
        Heading.Visible = false
        focusWheel(u125)
        spin(u125, a1.Mutation)
        local Tint = if Id_2 ~= Mutations.NO_MUTATION then assert(Mutations.Get(Id_2), (("Unknown mutation %*"):format(Id_2))).Tint else u133
        local Mutation = a1.Mutation
        local v7 = true
        if Id_2 ~= "Rainbow" then
            v7 = Id_2 == "Golden"
        end
        celebrate(u125, Mutation, Tint, v7)
        if not v2 then
            Audio.Chime("Failure")
        end
        paintResult(mutationColors(Id_2), nil)
        setLabel(Result, if not v2 then "NO MUTATION" else ("%*!"):format((string.upper((Mutations.LabelOf(Id_2))))))
        task.wait(1.2)
        moveCamera(shot(v4, 4.6, 0.18), 0.6)
        if v2 then
            u60 = swapPet(u60, After, a2, Tint)
            Audio.Play(139860804876890, script, {Volume = 0.9})
        end
        u125.BulbMode = "Idle"
        Audio.Play(119977062667102, script, {Volume = 0.7})
        Confetti.Burst({Palette = {v1.Color, Tint, u128}})
        paintResult(nil, v1.RarityGradient)
        setLabel(Heading, "YOU GOT")
        if not v2 then
            local Category_3 = After.Category
            DisplayName_3 = Directory[Category_3].DisplayName
        else
            DisplayName_3 = ("%* %*"):format(Mutations.LabelOf(Id_2), Directory[After.Category].DisplayName)
        end
        setLabel(Result, DisplayName_3)
        setLabel(Detail, v1.DisplayName)
        task.wait(2.6)
        Banner.Visible = false
        grow(u60, u60.Size, 0, 0.3, Enum.EasingStyle.Back)
    end

    local function hideInterface() -- Line: 607
        -- upvalues: u134 (upval), PetWheel_3 (val), Workspace (upval), LocalPlayer (upval), Players (upval)
        -- upvalues: StarterGui (upval), ProximityPromptService (upval)
        local Character_2
        local u181 = {}
        local u182 = {}

        local function suppress(a1) -- Line: 611 -- upvalues: u181 (val), u182 (val) -- types: a1: userdata
            local Enabled = a1.Enabled
            a1.Enabled = false
            table.insert(u181, ((a1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 614 -- upvalues: a1 (val), Enabled (ref)
                if a1.Enabled then
                    Enabled = true
                    a1.Enabled = false
                end
            end)))
            table.insert(u182, function() -- Line: 620 -- upvalues: a1 (val), Enabled (ref)
                if a1.Parent then
                    a1.Enabled = Enabled
                end
            end)
        end

        local function consider(a1) -- Line: 627 -- upvalues: u134 (upval), suppress (val) -- types: a1: userdata
            if a1:IsA("BillboardGui") or a1:IsA("ScreenGui") and not u134[a1.Name] then
                suppress(a1)
            end
        end

        local v1 = {PetWheel_3.Parent, Workspace}
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            for k, n in j:GetDescendants() do
                if n:IsA("BillboardGui") or n:IsA("ScreenGui") and not u134[n.Name] then
                    suppress(n)
                end
            end
            table.insert(u181, (j.DescendantAdded:Connect(consider)))
        end

        local function hideBody(a1) -- Line: 640 -- upvalues: u182 (val) -- types: a1: userdata
            if not a1:IsA("BasePart") and not a1:IsA("Decal") then
                if a1:IsA("Trail") or a1:IsA("ParticleEmitter") or a1:IsA("Beam") then
                    local Enabled = a1.Enabled
                    a1.Enabled = false
                    table.insert(u182, function() -- Line: 650 -- upvalues: a1 (val), Enabled (val)
                        a1.Enabled = Enabled
                    end)
                end
                return
            end
            local Transparency = a1.Transparency
            a1.Transparency = 1
            table.insert(u182, function() -- Line: 644 -- upvalues: a1 (val), Transparency (val)
                a1.Transparency = Transparency
            end)
        end

        local Character = LocalPlayer.Character
        if Character then
            for m, i5 in Character:GetDescendants() do
                hideBody(i5)
            end
            table.insert(u181, (Character.DescendantAdded:Connect(hideBody)))
        end
        for i6, i7 in Players:GetPlayers() do
            Character_2 = i7.Character
            if not Character_2 then
                u121 = nil
            else
                local u121 = Character_2:FindFirstChildOfClass("Humanoid")
            end
            if u121 then
                local DisplayDistanceType = u121.DisplayDistanceType
                u121.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                table.insert(u182, function() -- Line: 670 -- upvalues: u121 (val), DisplayDistanceType (val)
                    u121.DisplayDistanceType = DisplayDistanceType
                end)
            end
        end
        local u61 = {}
        for i8, i9 in Enum.CoreGuiType:GetEnumItems() do
            if i9 ~= Enum.CoreGuiType.All then
                u61[i9] = (StarterGui:GetCoreGuiEnabled(i9))
            end
        end
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        local v4 = StarterGui
        local success, err = pcall(StarterGui.GetCore, v4, "TopbarEnabled")
        local v5 = StarterGui
        pcall(StarterGui.SetCore, v5, "TopbarEnabled", false)
        local Enabled = ProximityPromptService.Enabled
        ProximityPromptService.Enabled = false
        table.insert(u182, function() -- Line: 687
            -- upvalues: u61 (val), StarterGui (upval), success (val), err (val), ProximityPromptService (upval)
            -- upvalues: Enabled (val)
            for i, j in u61 do
                StarterGui:SetCoreGuiEnabled(i, j)
            end
            local v1 = if not success then true else err
            pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", v1)
            ProximityPromptService.Enabled = Enabled
        end)
        return function() -- Line: 695 -- upvalues: u181 (val), u182 (val)
            for i, j in u181 do
                j:Disconnect()
            end
            for k, n in u182 do
                n()
            end
        end
    end

    local function play(a1) -- Line: 705
        -- upvalues: u139 (upval), ProximityPrompt (val), Trove (upval), HiddenUIHandler (upval), hideInterface (val)
        -- upvalues: PlayerModule (val), run (val), Banner (val), u126 (val), Remotes (upval)
        u139 = true
        ProximityPrompt.Enabled = false
        local v1 = Trove.new()
        v1:Add((HiddenUIHandler.Acquire()))
        v1:Add((hideInterface()))
        local Controls = PlayerModule:GetControls()
        Controls:Disable()
        v1:Add(function() -- Line: 713 -- upvalues: Controls (val)
            Controls:Enable()
        end)
        local success, result = xpcall(run, debug.traceback, a1, v1)
        Banner.Visible = false
        for i, j in u126 do
            j.BulbMode = "Idle"
        end
        v1:Destroy()
        Remotes.PetWheel.Finish:FireServer()
        ProximityPrompt.Enabled = true
        u139 = false
        if not success then
            error(result, 2)
        end
    end

    local function holdingPet() -- Line: 730 -- upvalues: LocalPlayer (upval)
        local Character = LocalPlayer.Character
        local Tool = if not Character then nil else Character:FindFirstChildOfClass("Tool")
        local v1 = false
        if Tool ~= nil then
            v1 = Tool:GetAttribute("ItemType") == "Asset"
        end
        return v1
    end

    local function notifyError(a1) -- Line: 736 -- upvalues: Toast (upval) -- types: a1: string
        Toast.Show({Seconds = 3, Text = a1, Color = Color3.fromRGB(255, 0, 0)})
    end

    ProximityPrompt.ActionText = "Spin Pet"
    ProximityPrompt.ObjectText = "Lucky Wheels"
    ProximityPrompt.Triggered:Connect(function() -- Line: 750 -- upvalues: u139 (upval), LocalPlayer (upval), Toast (upval), Remotes (upval), play (val)
        local v1
        if u139 then
            return
        end
        local Character = LocalPlayer.Character
        local Tool = if not Character then nil else Character:FindFirstChildOfClass("Tool")
        local v2 = false
        if Tool ~= nil then
            v2 = Tool:GetAttribute("ItemType") == "Asset"
        end
        if not v2 then
            Toast.Show({Text = "Hold a pet to spin it!", Seconds = 3, Color = Color3.fromRGB(255, 0, 0)})
            return
        end
        u139 = true
        v2, v1 = Remotes.PetWheel.Spin:InvokeServer()
        if v2 then
            task.spawn(play, v1)
            return
        end
        u139 = false
        local v3 = if typeof(v1) ~= "string" then "The wheels jammed. Try again!" else v1
        Toast.Show({Seconds = 3, Text = v3, Color = Color3.fromRGB(255, 0, 0)})
    end)
    RunService.RenderStepped:Connect(function() -- Line: 288 -- upvalues: u126 (val), u128 (upval), u123 (upval)
        local BulbColor, fromHSV, v1, v2, v3, v4
        local v5 = os.clock()
        local v6 = nil
        local v7 = nil
        for i, j in u126, v6, v7 do
            v2 = #j.Bulbs
            v3 = nil
            v4 = nil
            for k, n in j.Bulbs, v3, v4 do
                if j.BulbMode == "Win" then
                    v1 = v5 * 8
                    BulbColor = if (k + math.floor(v1)) % 2 ~= 0 then u128 else j.BulbColor
                elseif j.BulbMode ~= "Spin" then
                    v1 = v5 * 5
                    BulbColor = if (k + math.floor(v1)) % 4 ~= 0 then u123 else u128
                else
                    v1 = v5 * 22
                    BulbColor = if (k + math.floor(v1)) % 3 ~= 0 then j.BulbColor else u128
                end
                if n.Color ~= BulbColor then
                    n.Color = BulbColor
                end
            end
            if v2 > 0 and j.BulbMode == "Spin" then
                fromHSV = Color3.fromHSV
                v3 = v5 * 0.6 % 1
                j.BulbColor = fromHSV(v3, 0.7, 1)
            end
            v2 = math.clamp(j.PointerSpring.Position, -10, 34)
            j.Pointer.CFrame = j.PointerRest * CFrame.Angles(0, 0, (math.rad(v2)))
        end
    end)
end

return v1