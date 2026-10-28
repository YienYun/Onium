-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Stages.Fireflies
-- Decompile time: 45.29 ms

local Debris = game:GetService("Debris")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local BeanstalkEventFlags = require(ReplicatedStorage.Shared.Flags.BeanstalkEventFlags)
local BeanstalkGrowth = require(script.Parent.Parent.BeanstalkGrowth)
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Juice = require(script.Parent.Parent.Parent.ScrambleBoss.Juice)
local RailRide = require(script.Parent.Parent.RailRide)
local Trampoline = require(script.Parent.Parent.Trampoline)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Shake = require(ReplicatedStorage.Client.Shake)
require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.Parent.Parent.UISystem)
local LocalPlayer = Players.LocalPlayer
local Firefly = ReplicatedStorage.Assets.BeanstalkEventAssets.Firefly
local CollectFirefly = ReplicatedStorage.Assets.Sounds.BeanstalkEvent.CollectFirefly
local FireflyPickup = ReplicatedStorage.Assets.BeanstalkEventAssets.FireflyPickup
local FireflyPopup = ReplicatedStorage.Assets.BeanstalkEventAssets.FireflyPopup
local Stage = BeanstalkEvent.Stage
local u137 = Color3.fromRGB(255, 253, 199)
local u142 = Color3.fromRGB(255, 214, 80)
local u147 = Color3.fromRGB(110, 62, 0)
local u152 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u157 = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u162 = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u167 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Spider = ReplicatedStorage.AssetModels.Spider
local Idle = Assets.Directory.Spider.Animations.Idle
local Walk = Assets.Directory.Spider.Animations.Walk
local u183 = Color3.fromRGB(255, 40, 40)
local u190 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u195 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u198 = TweenInfo.new(0.2)
local u203 = Color3.fromRGB(235, 235, 235)
local u208 = Color3.fromRGB(255, 40, 40)
local u213 = Color3.fromRGB(120, 0, 0)
local u218 = Color3.fromRGB(255, 140, 140)
local u225 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u227 = Random.new()
local CurrentCamera = Workspace.CurrentCamera
local u229 = nil
local u230 = nil

local function floorTop(a1) -- Line: 171 -- types: a1: userdata
    return a1.Position.Y + a1.Size.Y * 0.5
end

local function clampToArea(a1, a2) -- Line: 176 -- upvalues: BeanstalkGrowth (val) -- types: a1: vector, a2: userdata
    local v1 = BeanstalkGrowth.Axis(a1.Y)
    local v2 = (a1 - v1) * Vector3.new(1, 0, 1)
    local v3 = math.clamp(v2.Magnitude, 60, 105)
    v2 = v1 + (if not (0.01 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit) * v3
    local v4 = a2.Size * 0.5
    v3 = a2.CFrame:PointToObjectSpace(v2)
    return a2.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v3.X, -v4.X + 5, v4.X - 5), v3.Y, (math.clamp(v3.Z, -v4.Z + 5, v4.Z - 5)))))
end

local function hoverSpot(a1, a2) -- Line: 193 -- upvalues: Workspace (val), u227 (val) -- types: a1: table, a2: vector
    local Floor = a1.Floor
    local v1 = Floor.Position.Y + Floor.Size.Y * 0.5
    local v2 = Vector3.new(a2.X, v1 + 60, a2.Z)
    local v3 = Workspace
    local Ground = a1.Ground
    v3 = v3:Raycast(v2, Vector3.new(0, -120, 0), Ground)
    if v3 ~= nil and not (4 < (math.abs(v3.Position.Y - v1))) then
        return (Vector3.new(a2.X, v3.Position.Y + u227:NextNumber(3, 7), a2.Z))
    end
    return nil
end

local function randomSpot(a1) -- Line: 207
    -- upvalues: u227 (val), BeanstalkGrowth (val), hoverSpot (val), clampToArea (val)
    local v1, v2
    for i = 1, 40 do
        v1 = u227:NextNumber(0, 6.283185307179586)
        v2 = u227:NextNumber(60, 105)
        v2 = hoverSpot(a1, clampToArea((BeanstalkGrowth.Axis(0)) + Vector3.new(math.cos(v1), 0, (math.sin(v1))) * v2, a1.Floor))
        if v2 ~= nil then
            return v2
        end
    end
    error((("No open ground for fireflies in %* tries around the stalk"):format(40)))
end

local function spawnFirefly(a1, a2, a3) -- Line: 221
    -- upvalues: randomSpot (val), Firefly (val), TweenService (val), u167 (val), u227 (val)
    local Brightness, Transparency
    local v1 = randomSpot(a3)
    local v2 = a1:Clone(Firefly)
    v2:PivotTo((CFrame.new(v1)))
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            Transparency = j.Transparency
            j.Transparency = 1
            TweenService:Create(j, u167, {Transparency = Transparency}):Play()
        elseif j:IsA("Light") then
            Brightness = j.Brightness
            j.Brightness = 0
            TweenService:Create(j, u167, {Brightness = Brightness}):Play()
        end
    end
    v2.Parent = a2
    return {
        FleeStartedAt = 0,
        TiredUntil = 0,
        Model = v2,
        Rest = v1,
        Position = v1,
        Phase = u227:NextNumber(0, 6.283185307179586),
    }
end

local function beginFlee(a1, a2, a3) -- Line: 250
    -- upvalues: u227 (val), hoverSpot (val), clampToArea (val)
    local v1 = (a1.Position - a2) * Vector3.new(1, 0, 1)
    local Unit = if not (0.01 < v1.Magnitude) then Vector3.new(1, 0, 0) else v1.Unit
    v1 = hoverSpot(a3, clampToArea(
        a1.Position + ((CFrame.Angles(0, u227:NextNumber(-0.6981317007977318, 0.6981317007977318), 0)):VectorToWorldSpace(Unit)) * 20,
        a3.Floor
    ))
    if v1 == nil then
        a1.TiredUntil = os.clock() + 0.3
        return
    end
    a1.FleeFrom = a1.Position
    a1.FleeTo = v1
    a1.FleeStartedAt = os.clock()
end

local function stepFirefly(a1, a2, a3, a4, a5) -- Line: 267
    -- upvalues: beginFlee (val)
    local v1 = os.clock()
    local FleeTo = a1.FleeTo
    if FleeTo ~= nil then
        local v2 = FleeTo - a1.Position
        local v3 = a3 * 0.85 * a5
        if v2.Magnitude <= v3 then
            a1.FleeTo = nil
            a1.Rest = a1.Position
            a1.TiredUntil = v1 + 1.5
        elseif not (1.6 <= v1 - a1.FleeStartedAt) then
            a1.Position = a1.Position + v2.Unit * v3
        else
            a1.FleeTo = nil
            a1.Rest = a1.Position
            a1.TiredUntil = v1 + 1.5
        end
    elseif a1.TiredUntil <= v1 and ((a1.Position - a2.Position) * Vector3.new(1, 0, 1)).Magnitude < 22 then
        beginFlee(a1, a2.Position, a4)
    end
    a1.Model:PivotTo((CFrame.new(a1.Position + (Vector3.new(0, math.sin(v1 * 0.6 * 2 * 3.141592653589793 + a1.Phase) * 0.8, 0)))))
end

local function flyIntoStalk(a1, a2) -- Line: 297
    -- upvalues: BeanstalkGrowth (val), TweenService (val)
    local PrimaryPart = a1.PrimaryPart
    local Trail = PrimaryPart:FindFirstChild("Trail")
    Trail.Enabled = true
    local v1 = BeanstalkGrowth.Axis(PrimaryPart.Position.Y + 6)
    TweenService:Create(
        PrimaryPart,
        TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {CFrame = CFrame.new(v1), Size = PrimaryPart.Size * 0.4}
    ):Play()
    task.delay(1.2, a2)
    task.delay(1.2 + Trail.Lifetime, function() -- Line: 313 -- upvalues: a1 (val)
        a1:Destroy()
    end)
end

local function reducedMotion() -- Line: 318 -- upvalues: GuiService (val)
    return GuiService.ReducedMotionEnabled
end

local function impactFrame(a1, a2) -- Line: 322
    -- upvalues: u137 (val), u142 (val), TweenService (val), Flash (val)
    a1.Brightness = if not a2 then 0.18 else 0.28
    a1.Contrast = if not a2 then 0.45 else 0.7
    a1.Saturation = -0.35
    a1.TintColor = u137:Lerp(u142, 0.35)
    TweenService:Create(
        a1,
        TweenInfo.new(if not a2 then 0.22 else 0.4, Enum.EasingStyle.Quad),
        {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)}
    ):Play()
    Flash.Play({
        Attack = 0.02,
        Decay = if not a2 then 0.25 else 0.45,
        Tint = u142,
        Opacity = if not a2 then 0.22 else 0.4,
    })
end

local function restoreFov() -- Line: 340 -- upvalues: u229 (ref), CurrentCamera (val), u230 (ref)
    local v1 = u229
    if v1 == nil then
        return
    end
    u229 = nil
    v1:Cancel()
    if CurrentCamera and u230 then
        CurrentCamera.FieldOfView = u230
    end
    u230 = nil
end

local function fovPulse(a1) -- Line: 353
    -- upvalues: GuiService (val), CurrentCamera (val), u229 (ref), u230 (ref), TweenService (val), u152 (val)
    -- upvalues: u162 (val), u157 (val)
    if not GuiService.ReducedMotionEnabled and CurrentCamera ~= nil then
        local u4 = CurrentCamera
        if u229 ~= nil then
            u229:Cancel()
        else
            u230 = u4.FieldOfView
        end
        local FieldOfView = u230
        if not FieldOfView then
            FieldOfView = u4.FieldOfView
        end
        local u33 = TweenService:Create(u4, u152, {FieldOfView = FieldOfView - (if not a1 then 7 else 12)})
        u229 = u33
        u33:Play()
        u33.Completed:Once(function(a1_2) -- Line: 369
            -- upvalues: u229 (upval), u33 (val), TweenService (upval), u4 (val), a1 (val), u162 (upval), u157 (upval)
            -- upvalues: FieldOfView (val), u230 (upval)
            if a1_2 == Enum.PlaybackState.Completed and u229 == u33 then
                local u16 = TweenService:Create(u4, if not a1 then u157 else u162, {FieldOfView = FieldOfView})
                u229 = u16
                u16:Play()
                u16.Completed:Once(function() -- Line: 378 -- upvalues: u229 (upval), u16 (val), u230 (upval)
                    if u229 == u16 then
                        u229 = nil
                        u230 = nil
                    end
                end)
                return
            end
        end)
        return
    end
end

local function hitFlash(a1) -- Line: 387 -- upvalues: TweenService (val), Debris (val) -- types: a1: userdata
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "HitFlash"
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 0.1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = a1
    Highlight.Parent = a1
    TweenService:Create(Highlight, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {FillTransparency = 1}):Play()
    Debris:AddItem(Highlight, 0.16999999999999998)
end

local function popup(a1, a2, a3) -- Line: 402
    -- upvalues: FireflyPopup (val), u142 (val), TweenService (val), u147 (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "FireflyPopup"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.CFrame = CFrame.new(a2)
    Part.Parent = a1
    local v1 = FireflyPopup:Clone()
    v1.Adornee = Part
    v1.Parent = Part
    local v2 = TweenInfo.new(0.36000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.54)
    local Label = v1:FindFirstChild("Label", true)
    if Label and Label:IsA("TextLabel") then
        Label.Text = a3
        Label.TextColor3 = u142
        Label.TextTransparency = 0
        TweenService:Create(Label, v2, {TextTransparency = 1}):Play()
        local UIStroke = Label:FindFirstChildOfClass("UIStroke")
        if UIStroke then
            UIStroke.Color = u147
            TweenService:Create(UIStroke, v2, {Transparency = 1}):Play()
        end
    end
    local UIScale = v1:FindFirstChildOfClass("UIScale")
    if UIScale then
        UIScale.Scale = 0.4
        TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
    TweenService:Create(
        Part,
        TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {CFrame = CFrame.new(a2 + Vector3.new(0, 3.5, 0))}
    ):Play()
    Debris:AddItem(Part, 1)
end

local function catchJuice(a1, a2) -- Line: 453
    -- upvalues: impactFrame (val), fovPulse (val), GuiService (val), Shake (val)
    impactFrame(a1, a2)
    fovPulse(a2)
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({
            Shape = "Fade",
            Seconds = if not a2 then 0.22 else 0.45,
            Magnitude = if not a2 then 0.35 else 0.9,
        })
    end
end

local function burstAt(a1, a2) -- Line: 466
    -- upvalues: FireflyPickup (val), EmitOnce (val), Debris (val)
    local v1 = FireflyPickup:Clone()
    v1.Position = a2
    v1.Parent = a1
    local v2 = 0
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v2 = math.max(v2, (EmitOnce(j)))
        end
    end
    Debris:AddItem(v1, v2)
end

local function flat(a1) -- Line: 479 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function nearestAngle(a1, a2) -- Line: 484 -- types: a1: number, a2: number
    return a1 + (a2 - a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end

local function groundAt(a1, a2) -- Line: 489 -- upvalues: Workspace (val) -- types: a1: table, a2: vector
    local Floor = a1.Floor
    local v1 = Floor.Position.Y + Floor.Size.Y * 0.5
    local v2 = Vector3.new(a2.X, v1 + 60, a2.Z)
    local v3 = Workspace
    local Ground = a1.Ground
    v3 = v3:Raycast(v2, Vector3.new(0, -120, 0), Ground)
    if v3 then
        return v3.Position
    end
    return (Vector3.new(a2.X, v1, a2.Z))
end

local function clampToFloor(a1, a2) -- Line: 497 -- upvalues: BeanstalkGrowth (val) -- types: a1: vector, a2: userdata
    local v1 = BeanstalkGrowth.Axis(a1.Y)
    local v2 = a1 - v1
    local v3 = Vector3.new(v2.X, 0, v2.Z)
    if v3.Magnitude < 50 then
        a1 = v1 + (if not (0.01 < v3.Magnitude) then Vector3.new(1, 0, 0) else v3.Unit) * 50
    end
    v3 = a2.Size * 0.5
    v1 = a2.CFrame:PointToObjectSpace(a1)
    return a2.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v3.X + 5, v3.X - 5), v1.Y, (math.clamp(v1.Z, -v3.Z + 5, v3.Z - 5)))))
end

local function strikeMarker(a1) -- Line: 514
    -- upvalues: u208 (val), TweenService (val), u225 (val), u213 (val), u218 (val)
    local Part = Instance.new("Part")
    Part.Name = "SpiderStrike"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(0.20000000298023224, 40, 40)
    Part.CFrame = (CFrame.new(a1 + Vector3.new(0, 0.15000000596046448, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = u208
    TweenService:Create(Part, u225, {Color = u213}):Play()
    local Highlight = Instance.new("Highlight")
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = u218
    Highlight.OutlineColor = u218
    Highlight.FillTransparency = 0.85
    Highlight.Adornee = Part
    Highlight.Parent = Part
    TweenService:Create(Highlight, u225, {FillTransparency = 0.35}):Play()
    return Part
end

local function serverCount() -- Line: 539 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return 0
end

return {
    Run = function(a1, a2, a3) -- Line: 548
        -- upvalues: BeanstalkEventFlags (val), Workspace (val), Lighting (val), restoreFov (val), hoverSpot (val)
        -- upvalues: clampToArea (val), randomSpot (val), Juice (val), RailRide (val), u227 (val), Spider (val)
        -- upvalues: u203 (val), TweenService (val), RunService (val), Idle (val), u195 (val), u183 (val), u190 (val)
        -- upvalues: Walk (val), clampToFloor (val), strikeMarker (val), u198 (val), LocalPlayer (val)
        -- upvalues: BeanstalkEvent (val), BeanstalkGrowth (val), Stage (val), UISystem (val), Trampoline (val)
        -- upvalues: TutorialBeam (val), spawnFirefly (val), stepFirefly (val), Remotes (val), catchJuice (val)
        -- upvalues: SoundService (val), CollectFirefly (val), burstAt (val), hitFlash (val), popup (val)
        -- upvalues: flyIntoStalk (val)
        local v1 = RaycastParams.new()
        v1.FilterType = Enum.RaycastFilterType.Include
        v1.FilterDescendantsInstances = {a2.Sections.Stage1}
        v1.RespectCanCollide = true
        local u10 = {Floor = a2.Sections.Stage1.Floor, Ground = v1}
        local u19 = BeanstalkEventFlags.FirefliesRequired:Get()
        local u25 = a1:Add((Instance.new("Folder")))
        u25.Name = "BeanstalkFireflies"
        u25.Parent = Workspace
        local u28 = {}
        local u34 = a1:Add((Instance.new("Highlight")))
        u34.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        u34.FillTransparency = 0.4
        u34.OutlineColor = Color3.fromRGB(255, 240, 120)
        u34.Parent = u25
        local u47 = a1:Add((Instance.new("ColorCorrectionEffect")))
        u47.Name = "FireflyImpact"
        u47.Parent = Lighting
        a1:Add(restoreFov)
        local u54 = (-1 / 0)
        local u55 = 0
        local u56 = false
        local u57 = true
        a1:Add(function() -- Line: 573 -- upvalues: u57 (ref)
            u57 = false
        end)
        local u64 = a1:Extend()
        local u65 = 0
        local u66 = {}
        local u67 = {}
        local u68 = 0

        local function fling(a1) -- Line: 588
            -- upvalues: a3 (val), hoverSpot (upval), u10 (val), clampToArea (upval), randomSpot (upval), u68 (ref)
            -- upvalues: Juice (upval), RailRide (upval)
            local v1 = a3.Root.Position - a1
            local v2 = Vector3.new(v1.X, 0, v1.Z)
            local Unit = if not (0.1 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit
            v2 = hoverSpot(u10, clampToArea(a3.Root.Position + Unit * 30, u10.Floor)) or randomSpot(u10)
            u68 = os.clock() + 1.5
            Juice.Throw(a3.Root, a3.Humanoid, v2, 1.5)
            RailRide.Shake(5)
        end

        local function strike(a1) -- Line: 598 -- upvalues: a3 (val), u68 (ref), fling (val) -- types: a1: vector
            local v1 = a3.Root.Position - a1
            local v2 = os.clock()
            if u68 <= v2 and Vector3.new(v1.X, 0, v1.Z).Magnitude <= 20 and v1.Y <= 12 then
                fling(a1)
            end
        end

        local function chooseSpot(a1) -- Line: 610
            -- upvalues: u28 (val), u67 (val), u227 (upval), u10 (val), Workspace (upval), randomSpot (upval)
            local v1, v2, v3
            local v4 = #u28
            if v4 >= 3 then
                v4 = {}
                v1 = u28
                v2 = nil
                for i, j in v1, nil, v2 do
                    if j ~= a1 and not u67[j] then
                        table.insert(v4, j)
                    end
                end
                if #v4 > 0 then
                    v1 = v4[u227:NextInteger(1, #v4)]
                    v2 = u10
                    local Position = v1.Position
                    local Floor = v2.Floor
                    v3 = Floor.Position.Y + Floor.Size.Y * 0.5
                    local v5 = Vector3.new(Position.X, v3 + 60, Position.Z)
                    local v6 = Workspace
                    local Ground = v2.Ground
                    v6 = v6:Raycast(v5, Vector3.new(0, -120, 0), Ground)
                    return if not v6 then Vector3.new(Position.X, v3, Position.Z) else v6.Position, v1
                end
            end
            v1 = u10
            local v7 = randomSpot(u10)
            local Floor_2 = v1.Floor
            v2 = Floor_2.Position.Y + Floor_2.Size.Y * 0.5
            local v8 = Vector3.new(v7.X, v2 + 60, v7.Z)
            v3 = Workspace
            local Ground_2 = v1.Ground
            v3 = v3:Raycast(v8, Vector3.new(0, -120, 0), Ground_2)
            return if not v3 then Vector3.new(v7.X, v2, v7.Z) else v3.Position, nil
        end

        local function spawnSpider(a1) -- Line: 628
            -- upvalues: u64 (val), Spider (upval), u203 (upval), TweenService (upval), RunService (upval), u10 (val)
            -- upvalues: randomSpot (upval), Workspace (upval), u227 (upval), u25 (val), Idle (upval), u195 (upval)
            -- upvalues: RailRide (upval), u183 (upval), u190 (upval), Walk (upval), a3 (val), clampToFloor (upval)
            -- upvalues: u68 (ref), fling (val), chooseSpot (val), u67 (val), strikeMarker (upval), clampToArea (upval)
            -- upvalues: u66 (val), u198 (upval)
            local u5 = u64:Clone(Spider)
            for i, j in u5:GetDescendants() do
                if j:IsA("BasePart") then
                    j.CanCollide = false
                    j.CanQuery = false
                    j.CanTouch = false
                end
            end
            u5.PrimaryPart.Anchored = true
            local BoundingBox, BoundingBox_2 = u5:GetBoundingBox()
            local u38 = (BoundingBox * (CFrame.new(0, -BoundingBox_2.Y * 0.5, 0))):ToObjectSpace((u5:GetPivot()))
            local u46 = u5:GetPivot():ToObjectSpace(BoundingBox)
            local u54 = u64:Add((Instance.new("Part")))
            u54.Name = "SpiderSilk"
            u54.Size = Vector3.new(0.25, 1000, 0.25)
            u54.Color = u203
            u54.Material = Enum.Material.SmoothPlastic
            u54.Anchored = true
            u54.CanCollide = false
            u54.CanQuery = false
            u54.CanTouch = false
            u54.CastShadow = false
            local u64_2 = 0
            local u65 = nil
            local u66_2 = true

            local function pose(a1, a2) -- Line: 658
                -- upvalues: u65 (ref), u66_2 (ref), u64_2 (ref), u38 (val), u5 (val), u54 (val), u46 (val)
                local v1 = u65
                if v1 ~= nil and u66_2 then
                    local v2 = u64_2
                    local v3 = a1 - v1
                    u64_2 = v2 + Vector3.new(v3.X, 0, v3.Z).Magnitude * 0.15
                end
                u65 = a1
                v1 = (CFrame.new(a1)) * CFrame.Angles(0, a2 + u64_2, 0) * u38
                u5:PivotTo(v1)
                if u66_2 then
                    u54.CFrame = CFrame.new((v1 * u46).Position + Vector3.new(0, 500, 0))
                end
            end

            local function glide(a1, a2, a3, a4, a5, a6, a7) -- Line: 670
                -- upvalues: TweenService (upval), pose (val), RunService (upval)
                local Value, v1
                local v2 = os.clock()
                while true do
                    v1 = math.min((os.clock() - v2) / a3, 1)
                    Value = TweenService:GetValue(v1, a6, a7)
                    pose(a1:Lerp(a2, Value), a4 + (a5 - a4) * Value)
                    if v1 >= 1 then
                        break
                    end
                    RunService.Heartbeat:Wait()
                end
            end

            local v1 = u10
            local v2 = randomSpot(u10)
            local Floor = v1.Floor
            local v3 = Floor.Position.Y + Floor.Size.Y * 0.5
            local v4 = Vector3.new(v2.X, v3 + 60, v2.Z)
            local v5 = Workspace
            local Ground = v1.Ground
            v5 = v5:Raycast(v4, Vector3.new(0, -120, 0), Ground)
            local u101 = (if not v5 then Vector3.new(v2.X, v3, v2.Z) else v5.Position) + Vector3.new(0, 22, 0)
            local u103 = u101 + Vector3.new(0, 120, 0)
            local u109 = u227:NextNumber(0, 6.283185307179586)
            pose(u103, u109)
            u5.Parent = u25
            u54.Parent = u25
            local Animator = u5:FindFirstChildWhichIsA("Animator", true)
            local u127 = Animator:LoadAnimation(Idle)
            u127.Looped = true
            u127:Play()
            local u132 = nil
            local u133 = nil
            local u134 = nil

            local function chase() -- Line: 708
                -- upvalues: u66_2 (ref), TweenService (upval), u54 (val), u195 (upval), u10 (upval), u101 (ref)
                -- upvalues: Workspace (upval), glide (val), u109 (ref), RailRide (upval), u183 (upval), u5 (val)
                -- upvalues: u190 (upval), u133 (ref), Animator (val), Walk (upval), u134 (ref), u127 (val)
                -- upvalues: RunService (upval), pose (val), a3 (upval), clampToFloor (upval), u68 (upval)
                -- upvalues: fling (upval)
                local Floor_2, Ground_2, v1, v2, v3, v4, v5, v6
                u66_2 = false
                TweenService:Create(u54, u195, {Transparency = 1}):Play()
                local v7 = u10
                local v8 = u101
                local Floor = v7.Floor
                local v9 = Floor.Position.Y + Floor.Size.Y * 0.5
                local v10 = Vector3.new(v8.X, v9 + 60, v8.Z)
                local v11 = Workspace
                local Ground = v7.Ground
                v11 = v11:Raycast(v10, Vector3.new(0, -120, 0), Ground)
                local Position = if not v11 then Vector3.new(v8.X, v9, v8.Z) else v11.Position
                glide(u101, Position, 0.45, u109, u109, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                RailRide.Shake(2)
                local Highlight = Instance.new("Highlight")
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.FillColor = u183
                Highlight.OutlineColor = u183
                Highlight.FillTransparency = 0.75
                Highlight.Adornee = u5
                Highlight.Parent = u5
                TweenService:Create(Highlight, u190, {FillTransparency = 0.2}):Play()
                u133 = Highlight
                v7 = Animator:LoadAnimation(Walk)
                v7.Looped = true
                u134 = v7
                u127:Stop()
                v7:Play()
                v8 = 0
                while true do
                    v9 = RunService.Heartbeat:Wait()
                    v10 = os.clock()
                    if not (v10 < v8) then
                        if not v7.IsPlaying then
                            u127:Stop()
                            v7:Play()
                        end
                        v3 = a3.Root.Position - Position
                        v11 = Vector3.new(v3.X, 0, v3.Z)
                        if 0.1 < v11.Magnitude then
                            v3 = math.min(30 * v9, v11.Magnitude)
                            v4 = u10
                            v5 = clampToFloor(Position + v11.Unit * v3, u10.Floor)
                            Floor_2 = v4.Floor
                            v6 = Floor_2.Position.Y + Floor_2.Size.Y * 0.5
                            v1 = Vector3.new(v5.X, v6 + 60, v5.Z)
                            v2 = Workspace
                            Ground_2 = v4.Ground
                            v2 = v2:Raycast(v1, Vector3.new(0, -120, 0), Ground_2)
                            Position = if not v2 then Vector3.new(v5.X, v6, v5.Z) else v2.Position
                            v4 = u109
                            v3 = v4 + ((math.atan2(-v11.X, -v11.Z)) - v4 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                            u109 = u109 + (v3 - u109) * math.min(8 * v9, 1)
                        end
                        pose(Position, u109)
                        v11 = a3.Root.Position - Position
                        if u68 <= v10 and Vector3.new(v11.X, 0, v11.Z).Magnitude <= 6 and v11.Y <= 8 then
                            fling(Position)
                            v8 = v10 + 3
                            v7:Stop()
                            u127:Play()
                        end
                    else
                        u109 = u109 + 6.283185307179586 * v9
                        pose(Position, u109)
                    end
                end
            end

            local u146 = u64:Add((task.spawn(function() -- Line: 764
                -- upvalues: glide (val), u103 (val), u101 (ref), u109 (ref), a1 (val), chase (val), chooseSpot (upval)
                -- upvalues: u67 (upval), u64 (upval), strikeMarker (upval), u25 (upval), u132 (ref), a3 (upval)
                -- upvalues: u68 (upval), fling (upval), u227 (upval), u10 (upval), clampToArea (upval)
                -- upvalues: Workspace (upval)
                local Floor, Ground, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
                glide(u103, u101, 1.5, u109, u109, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                if a1 then
                    chase()
                    return
                end
                local v13 = nil
                while true do
                    v1, v5 = chooseSpot(v13)
                    if v5 ~= nil then
                        u67[v5] = true
                    end
                    v6 = v1 + Vector3.new(0, 22, 0)
                    v8 = v6 - u101
                    v7 = Vector3.new(v8.X, 0, v8.Z)
                    if not (0.1 < v7.Magnitude) then
                        v8 = u109
                    else
                        v9 = u109
                        v8 = v9 + (math.atan2(-v7.X, -v7.Z) - v9 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                    end
                    v9 = math.max(v7.Magnitude / 35, 0.2)
                    glide(u101, v6, v9, u109, v8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    u109 = v8
                    v9 = u64:Add((strikeMarker(v1)))
                    v9.Parent = u25
                    u132 = v9
                    task.wait(1)
                    glide(v6, v1, 0.15, u109, u109, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    v8 = a3.Root.Position - v1
                    v10 = os.clock()
                    if u68 <= v10 and Vector3.new(v8.X, 0, v8.Z).Magnitude <= 20 and v8.Y <= 12 then
                        fling(v1)
                    end
                    glide(v1, v1, 0.5, u109, u109 + 12.566370614359172, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    u64:Remove(v9)
                    u132 = nil
                    glide(v1, v6, 0.6, u109, u109, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    if v5 ~= nil then
                        u67[v5] = nil
                    end
                    v9 = u227:NextNumber(1.25, 2.5)
                    v7 = u227:NextNumber(0, 6.283185307179586)
                    v5 = (Vector3.new(math.cos(v7), 0, (math.sin(v7)))) * 8 * v9
                    v11 = u10
                    v12 = clampToArea(v1 + v5, u10.Floor)
                    Floor = v11.Floor
                    v2 = Floor.Position.Y + Floor.Size.Y * 0.5
                    v3 = Vector3.new(v12.X, v2 + 60, v12.Z)
                    v4 = Workspace
                    Ground = v11.Ground
                    v4 = v4:Raycast(v3, Vector3.new(0, -120, 0), Ground)
                    v7 = (if not v4 then Vector3.new(v12.X, v2, v12.Z) else v4.Position) + Vector3.new(0, 22, 0)
                    v10 = v7 - v6
                    v5 = Vector3.new(v10.X, 0, v10.Z)
                    if not (0.1 < v5.Magnitude) then
                        v1 = u109
                    else
                        v10 = u109
                        v1 = v10 + (math.atan2(-v5.X, -v5.Z) - v10 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                    end
                    glide(v6, v7, v9, u109, v1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    u109 = v1
                    u101 = v7
                end
            end)))
            table.insert(u66, function() -- Line: 819
                -- upvalues: u146 (val), u132 (ref), u133 (ref), u134 (ref), u127 (val), u66_2 (ref)
                -- upvalues: TweenService (upval), u54 (val), u198 (upval), u65 (ref), u101 (ref), glide (val)
                -- upvalues: u109 (ref), u5 (val)
                task.cancel(u146)
                local v1 = u132
                if v1 ~= nil then
                    v1:Destroy()
                end
                v1 = u133
                if v1 ~= nil then
                    v1:Destroy()
                end
                v1 = u134
                if v1 ~= nil then
                    v1:Stop()
                    u127:Play()
                end
                u66_2 = true
                TweenService:Create(u54, u198, {Transparency = 0}):Play()
                v1 = u65 or u101
                glide(v1, v1 + Vector3.new(0, 300, 0), 1.5, u109, u109, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                u5:Destroy()
                u54:Destroy()
            end)
        end

        local function addSpiders() -- Line: 844
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u19 (val), u56 (ref), u65 (ref), spawnSpider (val)
            local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            local v1 = math.floor((math.min(if typeof(Attribute) ~= "number" then 0 else Attribute, u19)) / 4)
            while not u56 do
                if not (u65 < v1) then
                    break
                end
                u65 = u65 + 1
                spawnSpider(u65 >= 4)
            end
        end

        local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
        local u89 = math.min(if typeof(Attribute) ~= "number" then 0 else Attribute, u19)
        local u90 = 0
        local u91 = u89
        BeanstalkGrowth.SetBaseGrowth(u89 / u19)

        local function refreshGrowth() -- Line: 858
            -- upvalues: u89 (val), u90 (ref), LocalPlayer (upval), BeanstalkEvent (upval), u19 (val), u91 (ref)
            -- upvalues: BeanstalkGrowth (upval), u56 (ref), u66 (val), a1 (val), u67 (val), u28 (val), u34 (val)
            -- upvalues: RailRide (upval), Stage (upval), BeanstalkEventFlags (upval), UISystem (upval), a2 (val)
            -- upvalues: Trampoline (upval), a3 (val), TutorialBeam (upval)
            local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            local v1 = if typeof(Attribute) ~= "number" then 0 else Attribute
            local v2 = math.min(u89 + u90, v1, u19)
            if u91 < v2 then
                u91 = v2
                BeanstalkGrowth.SetBaseGrowth(v2 / u19, 1.2)
            end
            if not u56 and not (v2 < u19) then
                u56 = true
                for i, j in u66 do
                    a1:Add((task.spawn(j)))
                end
                table.clear(u66)
                table.clear(u67)
                for k, n in u28 do
                    n.Model:Destroy()
                end
                table.clear(u28)
                u34.Adornee = nil
                RailRide.Shake(3)
                BeanstalkGrowth.GrowTo(BeanstalkGrowth.HeightFor(Stage.Watering), BeanstalkEventFlags.GrowSeconds:Get())
                UISystem.SetTask("Bounce on the trampoline!")
                local Trampoline_2 = a2.Sections.Stage1.Trampoline
                Trampoline.Show(a1, Trampoline_2, a2.Sections.Stage2.SpawnLocation, a3)
                local u99 = TutorialBeam.Attach(Trampoline_2)
                a1:Add(function() -- Line: 889 -- upvalues: TutorialBeam (upval), u99 (val)
                    TutorialBeam.Destroy(u99)
                end)
                return
            end
        end

        local function onArrived() -- Line: 894 -- upvalues: u57 (ref), u90 (ref), refreshGrowth (val)
            if not u57 then
                return
            end
            u90 = u90 + 1
            refreshGrowth()
        end

        local function topUp(a1_2) -- Line: 913
            -- upvalues: u56 (ref), u55 (ref), u54 (ref), BeanstalkEventFlags (upval), u19 (val), LocalPlayer (upval)
            -- upvalues: BeanstalkEvent (upval), u28 (val), spawnFirefly (upval), a1 (val), u25 (val), u10 (val)
            if not u56 then
                local v1 = a1_2 - u55
                if not (v1 < 1) then
                    v1 = a1_2 - u54
                    if not (v1 < 1) then
                        u55 = a1_2
                        local v2 = BeanstalkEventFlags.MaxVisibleFireflies:Get()
                        local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
                        v1 = math.min(v2, u19 - (if typeof(Attribute) ~= "number" then 0 else Attribute))
                        while #u28 < v1 do
                            table.insert(u28, (spawnFirefly(a1, u25, u10)))
                        end
                        return
                    end
                end
            end
        end

        a1:Connect(LocalPlayer:GetAttributeChangedSignal(BeanstalkEvent.ProgressAttribute), function() -- Line: 903
            -- upvalues: u56 (ref), UISystem (upval), LocalPlayer (upval), BeanstalkEvent (upval), u19 (val)
            -- upvalues: refreshGrowth (val), addSpiders (val)
            if not u56 then
                local SetProgress = UISystem.SetProgress
                local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
                SetProgress("CatchFireFlies", math.min(if typeof(Attribute) ~= "number" then 0 else Attribute, u19), u19)
            end
            refreshGrowth()
            addSpiders()
        end)
        if not u56 then
            local SetProgress = UISystem.SetProgress
            local Attribute_2 = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
            SetProgress("CatchFireFlies", math.min(if typeof(Attribute_2) ~= "number" then 0 else Attribute_2, u19), u19)
        end
        refreshGrowth()
        addSpiders()
        topUp(os.clock())
        a1:Connect(RunService.Heartbeat, function(a1) -- Line: 935
            -- upvalues: u56 (ref), u28 (val), stepFirefly (upval), a3 (val), u10 (val), u54 (ref), u68 (ref)
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u19 (val), Remotes (upval), catchJuice (upval)
            -- upvalues: u47 (val), SoundService (upval), CollectFirefly (upval), burstAt (upval), u25 (val)
            -- upvalues: hitFlash (upval), popup (upval), flyIntoStalk (upval), onArrived (val), u34 (val), topUp (val)
            local Attribute, Magnitude, v1
            if u56 then
                return
            end
            local v2 = os.clock()
            local v3 = nil
            local v4 = (1 / 0)
            for i = #u28, 1, -1 do
                local u14 = u28[i]
                stepFirefly(u14, a3.Root, a3.Humanoid.WalkSpeed, u10, a1)
                Magnitude = (u14.Position - a3.Root.Position).Magnitude
                if Magnitude <= 4 then
                    v1 = v2 - u54
                    if not (v1 >= 0.5) then
                        if Magnitude < v4 then
                            v3 = u14
                        end
                    elseif u68 <= v2 then
                        u54 = v2
                        table.remove(u28, i)
                        Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.ProgressAttribute)
                        v1 = u19 <= (if typeof(Attribute) ~= "number" then 0 else Attribute) + 1
                        Remotes.BeanstalkEvent.AskCatchFirefly:FireServer()
                        catchJuice(u47, v1)
                        SoundService:PlayLocalSound(CollectFirefly)
                        burstAt(u25, u14.Position)
                        hitFlash(u14.Model)
                        popup(u25, u14.Position + Vector3.new(0, 1.2000000476837158, 0), "+1 Firefly")
                        task.delay(if not v1 then 0.07 else 0.16, function() -- Line: 960 -- upvalues: u14 (val), flyIntoStalk (upval), onArrived (upval)
                            if u14.Model.Parent then
                                flyIntoStalk(u14.Model, onArrived)
                            end
                        end)
                    elseif Magnitude < v4 then
                        v3 = u14
                    end
                elseif Magnitude < v4 then
                    v3 = u14
                end
            end
            u34.Adornee = if not v3 then nil else v3.Model
            topUp(v2)
        end)
    end,
}