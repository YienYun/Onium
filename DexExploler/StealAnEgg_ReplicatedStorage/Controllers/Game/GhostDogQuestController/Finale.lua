-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Finale
-- Decompile time: 100.16 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Cast = require(script.Parent.Cast)
local Cine = require(script.Parent.Cine)
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Hud = require(script.Parent.Hud)
local Npcs = require(script.Parent.Npcs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Speech = require(script.Parent.Speech)
local Swim = require(script.Parent.Swim)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local GhostDogQuest_2 = ReplicatedStorage.Assets.GhostDogQuest
local Sounds = ReplicatedStorage.Assets.Sounds
local ChestOpen = Sounds.MonsterParasite.ChestOpen
local Chomp = Sounds.MonsterParasite.Chomp
local Rumble = Sounds.ScrambleBoss.Rumble
local Pop = Sounds.ScrambleBoss.Pop
local Swoosh = Sounds.ScrambleBoss.Swoosh
local HeavyLand = Sounds.ScrambleBoss.HeavyLand
local Legendary = Sounds.PrizeSounds.Legendary
local CollectSecretRing = Sounds.LightVsDarknessSounds.CollectSecretRing
local SlideLoop = Sounds.BeanstalkEvent.SlideLoop
local SlideHit = Sounds.BeanstalkEvent.SlideHit
local u107 = Color3.fromRGB(255, 214, 120)
local u112 = Color3.fromRGB(14, 52, 64)
local v1 = {}

local function bezier(a1, a2, a3, a4, a5) -- Line: 79
    -- upvalues: 
    local v1 = 1 - a5
    return a1 * (v1 * v1 * v1) + a2 * (v1 * 3 * v1 * a5) + a3 * (v1 * 3 * a5 * a5) + a4 * (a5 * a5 * a5)
end

local function run(a1, a2) -- Line: 84 -- types: a1: number, a2: function
    local v1, v2
    local v3 = os.clock()
    while true do
        v1 = os.clock()
        v2 = math.min((v1 - v3) / a1, 1)
        a2(v2, v1 - v3)
        if v2 >= 1 then
            break
        end
        task.wait()
    end
end

local function puppet(a1, a2, a3) -- Line: 99 -- types: a2: userdata, a3: string
    local CFrame = a2.CFrame
    local u4 = true
    a1:BindToRenderStep(a3, Enum.RenderPriority.Character.Value, function() -- Line: 102 -- upvalues: u4 (ref), a2 (val), CFrame (ref)
        if u4 then
            a2.CFrame = CFrame
            a2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            a2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end)
    return {
        Set = function(a1) -- Line: 110 -- upvalues: CFrame (ref), u4 (ref), a2 (val) -- types: a1: userdata
            CFrame = a1
            if u4 then
                a2.CFrame = a1
            end
        end,
        Get = function() -- Line: 116 -- upvalues: CFrame (ref)
            return CFrame
        end,
        Stop = function() -- Line: 119 -- upvalues: u4 (ref)
            u4 = false
        end,
    }
end

local function fishLevel(a1, a2) -- Line: 125 -- upvalues: Workspace (val) -- types: a1: vector, a2: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a2
    local v2 = Workspace:Raycast(a1 + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v1)
    return (Vector3.new(a1.X, math.max(a1.Y, (if not v2 then a1.Y - 3 else v2.Position.Y) + 10), a1.Z))
end

local function flatUnit(a1, a2) -- Line: 134 -- types: a1: vector, a2: vector
    local v1 = a1 * Vector3.new(1, 0, 1)
    if 0.05 < v1.Magnitude then
        return v1.Unit
    end
    return a2
end

local function chaseAlong(a1) -- Line: 139 -- upvalues: GhostDogQuest (val) -- types: a1: vector
    local Chase = GhostDogQuest.Chase
    local v1 = a1 - Chase.Center
    return (math.atan2(v1.Z, v1.X) - Chase.StartAngle) % 6.283185307179586 * Chase.Radius
end

local function fishFacing(a1, a2) -- Line: 146 -- types: a1: vector, a2: vector
    return (CFrame.lookAt(a1, (Vector3.new(a2.X, a1.Y, a2.Z)))) * CFrame.new(0, -8, 0)
end

local function exclaim(a1, a2) -- Line: 150 -- upvalues: LocalPlayer (val), Fx (val), Pop (val) -- types: a2: userdata
    local Head = a2:FindFirstChild("Head")
    if Head ~= nil and Head:IsA("BasePart") then
        local u15 = a1:Add((Instance.new("BillboardGui")))
        u15.Size = UDim2.fromScale(3, 3)
        u15.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
        u15.AlwaysOnTop = true
        u15.Adornee = Head
        local v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Size = UDim2.fromScale(1, 1)
        v1.Text = "!"
        v1.TextScaled = true
        v1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
        v1.TextColor3 = Color3.fromRGB(255, 225, 90)
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 4
        UIStroke.Parent = v1
        local UIScale = Instance.new("UIScale")
        UIScale.Parent = v1
        v1.Parent = u15
        u15.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        Fx.Punch(UIScale, 2.2, 0.35)
        Fx.Play(Pop, {Volume = 0.7, PlaybackSpeed = 1.5})
        task.delay(1.4, function() -- Line: 176 -- upvalues: u15 (val)
            u15:Destroy()
        end)
        return
    end
end

local function partsOf(a1) -- Line: 181 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function playAnimation(a1, a2, a3, a4) -- Line: 191 -- types: a1: userdata, a2: string, a3: boolean, a4: number?
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    local v1 = a1:FindFirstChild("Animations")
    local v2 = v1 and v1:FindFirstChild(a2)
    if Animator and v2 and v2:IsA("Animation") then
        v1 = Animator:LoadAnimation(v2)
        v1.Looped = a3
        v1:Play(0.1, 1, a4 or 1)
        return v1
    end
    return nil
end

local function swimTrack(a1, a2) -- Line: 210 -- upvalues: playAnimation (val) -- types: a1: userdata, a2: number
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    if Animator then
        for i, j in Animator:GetPlayingAnimationTracks() do
            if j.Animation and j.Animation.Name == "GhostFish_Swim" then
                j:AdjustSpeed(a2)
                return j
            end
        end
    end
    return (playAnimation(a1, "GhostFish_Swim", true, a2))
end

local function lidParts(a1) -- Line: 224 -- types: a1: userdata
    local Lid = a1:FindFirstChild("Lid")
    local Attribute = Lid:GetAttribute("Pivot")
    local CFrame_3 = a1.PrimaryPart and a1.PrimaryPart.CFrame or a1:GetPivot()
    local v1 = CFrame_3 * CFrame.new(if typeof(Attribute) ~= "Vector3" then Vector3.new(0, 0, 0) else Attribute - Vector3.new(0, 0.5, 0))
    local v2 = {}
    local v3 = {}
    for i, j in Lid:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v2, j)
            table.insert(v3, (v1:ToObjectSpace(j.CFrame)))
        end
    end
    return v2, v3, v1
end

local function poseLid(a1, a2, a3, a4) -- Line: 243
    -- upvalues: Workspace (val)
    local v1 = a3 * CFrame.Angles(math.rad(a4), 0, 0)
    local v2 = table.create(#a1)
    for i, j in a2 do
        v2[i] = v1 * j
    end
    Workspace:BulkMoveTo(a1, v2, Enum.BulkMoveMode.FireCFrameChanged)
end

local function shaft(a1, a2, a3, a4, a5) -- Line: 252
    -- upvalues: Workspace (val)
    local v1 = a1:Add((Instance.new("Part")))
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.Transparency = 1
    v1.Size = Vector3.new(1, 1, 1)
    v1.CFrame = CFrame.new(a2)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = v1
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, a3, 0)
    Attachment_2.Parent = v1
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.Width0 = a5
    Beam.Width1 = a5 * 2.2
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Color = ColorSequence.new(a4)
    Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), (NumberSequenceKeypoint.new(1, 1))})
    Beam.Parent = v1
    v1.Parent = Workspace
    return Beam
end

local function setBeamAlpha(a1, a2, a3) -- Line: 289 -- types: a1: userdata, a2: number, a3: number
    a1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, a2), (NumberSequenceKeypoint.new(1, a3))})
end

local function ticketModel(a1, a2) -- Line: 296 -- upvalues: GhostDogQuest_2 (val), Workspace (val) -- types: a2: vector
    local v1 = a1:Add((GhostDogQuest_2.Ticket:Clone()))
    v1.Name = "GhostDogTicket"
    v1:PivotTo((CFrame.new(a2)))
    v1.Parent = Workspace
    return v1
end

local function sizeTicket(a1, a2) -- Line: 304 -- types: a1: userdata, a2: number
    a1:ScaleTo((math.max(a2 * 1.4, 0.01)))
end

local function textAlpha(a1, a2, a3) -- Line: 308 -- upvalues: Fx (val) -- types: a1: userdata, a2: number, a3: number
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")
    if a2 <= 0 then
        a1.TextTransparency = a3
        if UIStroke then
            UIStroke.Transparency = a3
        end
        return
    end
    Fx.Tween(a1, a2, {TextTransparency = a3})
    if UIStroke then
        Fx.Tween(UIStroke, a2, {Transparency = a3})
    end
end

local function stageTicketView(a1) -- Line: 323 -- upvalues: GhostDogQuest_2 (val) -- types: a1: userdata
    local v1 = a1
    for i, j in a1:GetChildren() do
        if j:IsA("Model") or j:IsA("Camera") then
            j:Destroy()
        end
    end
    local v2 = GhostDogQuest_2.Ticket:Clone()
    v2:PivotTo(CFrame.identity)
    local BoundingBox, BoundingBox_2 = v2:GetBoundingBox()
    local v3 = CFrame.new(-BoundingBox.Position)
    v2:PivotTo(v3)
    v2.Parent = v1
    local v4 = Instance.new("Camera")
    v4.FieldOfView = 30
    local UIAspectRatioConstraint = v1:FindFirstChildOfClass("UIAspectRatioConstraint")
    local AspectRatio = if not UIAspectRatioConstraint then 2.2 else UIAspectRatioConstraint.AspectRatio
    local v5 = math.tan((math.rad(v4.FieldOfView / 2)))
    v5 = math.max(BoundingBox_2.X * 0.5 / (v5 * AspectRatio), BoundingBox_2.Y * 0.5 / v5) * 1.12 + BoundingBox_2.Z * 0.5
    v4.CFrame = CFrame.lookAt(Vector3.new(0, 0, -v5), (Vector3.new(0, 0, 0)))
    v4.Parent = v1
    v1.CurrentCamera = v4
    return v2, v3
end

local function revealTicket() -- Line: 349
    -- upvalues: Hud (val), stageTicketView (val), Fx (val), Legendary (val), CollectSecretRing (val), textAlpha (val)
    -- upvalues: UserInputService (val)
    local u2 = Hud.Ticket()
    if u2 == nil then
        return
    end
    local View = u2:FindFirstChild("View")
    if View ~= nil and View:IsA("ViewportFrame") then
        local Title = u2.Title
        u2.Card.Visible = false
        local UIScale = View:FindFirstChildOfClass("UIScale")
        if UIScale == nil then
            UIScale = Instance.new("UIScale")
            UIScale.Parent = View
        end
        local u25, u26 = stageTicketView(View)
        local Position = View.Position
        u2.Visible = true
        View.Visible = true
        u2.Dim.BackgroundTransparency = 1
        local Tap = u2.Tap
        local UIStroke = Tap:FindFirstChildOfClass("UIStroke")
        Tap.TextTransparency = 1
        if UIStroke then
            UIStroke.Transparency = 1
        end
        local UIStroke_2 = Title:FindFirstChildOfClass("UIStroke")
        Title.TextTransparency = 1
        if UIStroke_2 then
            UIStroke_2.Transparency = 1
        end
        local Sub = u2.Sub
        local UIStroke_3 = Sub:FindFirstChildOfClass("UIStroke")
        Sub.TextTransparency = 1
        if UIStroke_3 then
            UIStroke_3.Transparency = 1
        end
        u2.Rays.ImageTransparency = 1
        Fx.Tween(u2.Dim, 0.3, {BackgroundTransparency = 0.35})
        View.Position = UDim2.fromScale(Position.X.Scale, -0.4)
        View.Rotation = -25
        UIScale.Scale = 1
        local u84 = os.clock()
        task.spawn(function() -- Line: 380 -- upvalues: u2 (val), u25 (val), u84 (val), u26 (val)
            local v1, v2
            while u2.Visible do
                if not u25.Parent then
                    break
                end
                v1 = os.clock() - u84
                v2 = math.max(0, 1 - v1 / 0.9)
                u25:PivotTo((CFrame.Angles(
                    math.sin(v1 * 1.3) * 0.10471975511965978,
                    v2 * v2 * 3.141592653589793 * 4 + math.sin(v1 * 0.9) * 0.3141592653589793,
                    0
                )) * u26 + (Vector3.new(0, math.sin(v1 * 2) * 0.04, 0)))
                task.wait()
            end
        end)
        Fx.Tween(View, 0.55, {Rotation = 4, Position = Position}, Enum.EasingStyle.Back)
        Fx.Play(Legendary, {Volume = 0.6})
        task.wait(0.5)
        Fx.Tween(View, 0.3, {Rotation = 0}, Enum.EasingStyle.Sine)
        Fx.Tween(u2.Rays, 0.5, {ImageTransparency = 0.25})
        task.spawn(function() -- Line: 401 -- upvalues: u2 (val)
            local Rays
            while u2.Visible do
                Rays = u2.Rays
                Rays.Rotation = Rays.Rotation + 0.6
                task.wait()
            end
        end)
        task.wait(0.4)
        Fx.Play(CollectSecretRing, {Volume = 0.6})
        Fx.Punch(UIScale, 1.08, 0.3)
        local v1 = Title:FindFirstChildOfClass("UIScale")
        local UIStroke_4 = Title:FindFirstChildOfClass("UIStroke")
        Title.TextTransparency = 0
        if UIStroke_4 then
            UIStroke_4.Transparency = 0
        end
        if v1 then
            Fx.Punch(v1, 1.5, 0.4)
        end
        textAlpha(u2.Sub, 0.4, 0)
        task.wait(0.6)
        textAlpha(u2.Tap, 0.4, 0.45)
        local u174 = false
        v1 = u2.Catch.Activated:Connect(function() -- Line: 419 -- upvalues: u174 (ref)
            u174 = true
        end)
        local v2 = UserInputService.InputBegan:Connect(function(a1) -- Line: 422 -- upvalues: u174 (ref) -- types: a1: userdata
            if a1.KeyCode == Enum.KeyCode.E
                or a1.KeyCode == Enum.KeyCode.ButtonA
                or a1.KeyCode == Enum.KeyCode.Space then
                u174 = true
            end
        end)
        local v3 = os.clock()
        while not u174 do
            if not (os.clock() - v3 < 2.6) then
                break
            end
            task.wait()
        end
        v1:Disconnect()
        v2:Disconnect()
        Fx.Tween(
            View,
            0.35,
            {Rotation = 15, Position = UDim2.fromScale(Position.X.Scale, 1.4)},
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        )
        Fx.Tween(u2.Dim, 0.35, {BackgroundTransparency = 1})
        textAlpha(Title, 0.3, 1)
        textAlpha(u2.Sub, 0.3, 1)
        textAlpha(u2.Tap, 0.3, 1)
        Fx.Tween(u2.Rays, 0.3, {ImageTransparency = 1})
        task.wait(0.4)
        u2.Visible = false
        View.Position = Position
        View.Rotation = 0
        u25:Destroy()
        return
    end
    warn("GhostDogQuest: Ticket.View ViewportFrame is missing from GhostDogQuestUI")
end

local function claim() -- Line: 456 -- upvalues: Remotes (val)
    local err, success
    for i = 1, 4 do
        success, err = pcall(function() -- Line: 458 -- upvalues: Remotes (upval)
            return Remotes.GhostDogQuest.Claim:InvokeServer()
        end)
        if success and err == true then
            return true
        end
        task.wait(0.7)
    end
    return false
end

function v1:Play(a2, a3, a4, a5, a6) -- Line: 469
    -- upvalues: Hud (val), LocalPlayer (val), Workspace (val), Cine (val), puppet (val), Swim (val), claim (val)
    -- upvalues: swimTrack (val), GhostDogQuest_2 (val), fishLevel (val), playAnimation (val), GhostDogQuest (val)
    -- upvalues: RunService (val), shaft (val), run (val), Fx (val), setBeamAlpha (val), lidParts (val), Rumble (val)
    -- upvalues: partsOf (val), poseLid (val), u107 (val), Pop (val), ChestOpen (val), Legendary (val), Lighting (val)
    -- upvalues: CollectSecretRing (val), Swoosh (val), exclaim (val), Chomp (val), SlideLoop (val), u112 (val)
    -- upvalues: Remotes (val)
    local function stillAlive() -- Line: 477 -- upvalues: a5 (val)
        local v1 = true
        if a5 ~= nil then
            v1 = a5()
        end
        return v1
    end

    local v1 = Hud.Get()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if v1 ~= nil
        and Character ~= nil
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and Humanoid ~= nil then
        local Position, Unit, u148, u168, u169, u196, v2, v3, v4
        local CurrentCamera = Workspace.CurrentCamera
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local u38 = Cine.RestingFov()
        local FieldOfView = CurrentCamera.FieldOfView
        local u46 = puppet(self, HumanoidRootPart, "GhostDogFinalePuppet")
        local v5 = Swim.Start(self, Character, "Swim")
        local u53 = nil
        task.spawn(function() -- Line: 500 -- upvalues: u53 (ref), claim (upval)
            claim()
        end)
        local Pivot = a3:GetPivot()
        local LookVector = Pivot.LookVector
        local v6 = Humanoid.HipHeight + HumanoidRootPart.Size.Y * 0.5
        local v7 = Pivot.Position + LookVector * 7.5 + Vector3.new(0, v6, 0)
        local u84 = CFrame.lookAt(v7, (Vector3.new(Pivot.X, v7.Y, Pivot.Z)))
        local RightVector = u84.RightVector
        local u92 = Pivot.Position + LookVector * 13 + RightVector * 8 + Vector3.new(0, 4.5, 0)
        local u95 = Pivot.Position + Vector3.new(0, 2, 0)
        local v8 = u84.LookVector * Vector3.new(1, 0, 1)
        local Unit_4 = if not (0.05 < v8.Magnitude) then Vector3.new(0, 0, 1) else v8.Unit
        if not a6 or not a6.Parent then
            u148 = self:Clone(GhostDogQuest_2.GhostFish)
            Position = fishLevel(Pivot.Position + Unit_4 * 30 + RightVector * 6, {Character, u148})
            u168 = 16
            u169 = 4.5
            v3 = Position
            local v9 = Position + Unit_4
            v2 = (CFrame.lookAt(v3, (Vector3.new(v9.X, v3.Y, v9.Z)))) * (CFrame.new(0, -8, 0))
            u148:PivotTo(v2)
            u148.Parent = Workspace
            u196 = playAnimation(u148, "GhostFish_Swim", true, 0.6)
        else
            u148 = a6
            local Pivot_4 = u148:GetPivot()
            v2 = Pivot_4.LookVector * Vector3.new(1, 0, 1)
            Unit = if not (0.05 < v2.Magnitude) then Unit_4 else v2.Unit
            Position = (Pivot_4 * CFrame.new(0, 8, 0)).Position
            u168 = 16
            u169 = 16
            u196 = swimTrack(u148, 0.6)
        end
        local v10 = {Character, u148}
        local u203 = true

        function v2(a1) -- Line: 543 -- upvalues: GhostDogQuest (upval), a2 (val) -- types: a1: vector
            local ChaseFrame = GhostDogQuest.ChaseFrame
            local v1 = a2
            local Chase = GhostDogQuest.Chase
            local v2 = a1 - Chase.Center
            return ChaseFrame(v1, (math.atan2(v2.Z, v2.X) - Chase.StartAngle) % 6.283185307179586 * Chase.Radius).Y
        end

        function v3() -- Line: 546 -- upvalues: Position (ref), u84 (val)
            return ((Position - u84.Position) * Vector3.new(1, 0, 1)).Magnitude
        end

        local v11 = Position.Y
        local v12 = Position
        local v13 = GhostDogQuest.ChaseFrame
        local v14 = GhostDogQuest.Chase
        local v15 = v12 - v14.Center
        local u238 = v11 - v13(a2, (math.atan2(v15.Z, v15.X) - v14.StartAngle) % 6.283185307179586 * v14.Radius).Y
        for i, j in u148:GetDescendants() do
            if j:IsA("BasePart") and j.Name == "EyeGlow" and j:FindFirstChildOfClass("PointLight") == nil then
                j.Color = Color3.fromRGB(255, 60, 70)
                v4 = Instance.new("PointLight")
                v4.Color = Color3.fromRGB(255, 50, 60)
                v4.Range = 12
                v4.Brightness = 4
                v4.Parent = j
            end
        end
        local Highlight = Instance.new("Highlight")
        Highlight.FillColor = Color3.fromRGB(255, 40, 60)
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = Color3.fromRGB(255, 70, 80)
        Highlight.OutlineTransparency = 1
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Parent = u148
        self:Connect(RunService.RenderStepped, function(a1) -- Line: 571
            -- upvalues: u203 (ref), Position (ref), u84 (val), GhostDogQuest (upval), a2 (val), Unit (ref), u169 (ref)
            -- upvalues: u168 (ref), u238 (val), u196 (ref), u148 (ref)
            if not u203 then
                return
            end
            local v1 = math.clamp((210 - ((Position - u84.Position) * Vector3.new(1, 0, 1)).Magnitude) / 60, 0.3, 1)
            local ChaseFrame = GhostDogQuest.ChaseFrame
            local v2 = a2
            local v3 = Position
            local Chase = GhostDogQuest.Chase
            local v4 = v3 - Chase.Center
            local LookVector = (ChaseFrame(v2, (math.atan2(v4.Z, v4.X) - Chase.StartAngle) % 6.283185307179586 * Chase.Radius)).LookVector
            v2 = Unit
            local v5 = LookVector * Vector3.new(1, 0, 1)
            local Unit_2 = if not (0.05 < v5.Magnitude) then v2 else v5.Unit
            if 0 < (Unit_2:Dot(Unit)) then
                Unit = Unit:Lerp(Unit_2, (math.min(a1 * 1.5, 1))).Unit
            end
            u169 = u169 + (u168 * v1 - u169) * math.min(a1 * 2, 1)
            Position = Position + Unit * u169 * a1
            v2 = Position
            local ChaseFrame_2 = GhostDogQuest.ChaseFrame
            v3 = a2
            local Chase_2 = GhostDogQuest.Chase
            v4 = v2 - Chase_2.Center
            local v6 = ChaseFrame_2(v3, (math.atan2(v4.Z, v4.X) - Chase_2.StartAngle) % 6.283185307179586 * Chase_2.Radius).Y + u238
            Position = Vector3.new(Position.X, Position.Y + (v6 - Position.Y) * math.min(a1 * 3, 1), Position.Z)
            if u196 then
                u196:AdjustSpeed(u169 * 0.09 + 0.35)
            end
            local v7 = u148
            local v8 = Position
            v4 = Position + Unit
            v7:PivotTo((CFrame.lookAt(v8, (Vector3.new(v4.X, v8.Y, v4.Z)))) * CFrame.new(0, -8, 0) * (CFrame.Angles(0, 0, (math.sin((os.clock()) * 2.2)) * 0.06)))
        end)
        local u297 = shaft(self, Pivot.Position + Vector3.new(0, 1, 0), 60, Color3.fromRGB(170, 230, 255), 6)
        local Glow = a3:FindFirstChild("Glow", true)
        local Light = a3:FindFirstChild("Light", true)
        local v16 = a3:FindFirstChild("Burst", true)
        local Sparkle = v16
        if Sparkle then
            Sparkle = v16:FindFirstChild("Sparkle")
        end
        local u323 = u46.Get()
        local Position_2 = CurrentCamera.CFrame.Position
        local u331 = Position_2 + CurrentCamera.CFrame.LookVector * 20
        local u333 = Position_2 + Vector3.new(0, 6, 0)
        local u341 = u92 + LookVector * 6 + Vector3.new(0, 4, 0)
        run(2.1, function(a1) -- Line: 618
            -- upvalues: Fx (upval), u46 (val), u323 (val), u84 (val), CurrentCamera (val), Position_2 (val), u333 (val)
            -- upvalues: u341 (val), u92 (val), u331 (val), u95 (val), FieldOfView (val), u38 (val)
            -- upvalues: setBeamAlpha (upval), u297 (val)
            local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local v2 = (math.sin(a1 * 18)) * (1 - a1) * 0.12
            u46.Set((u323:Lerp(u84, v1)) * CFrame.Angles(math.sin(a1 * 3.141592653589793) * -0.6108652381980153 + v2, 0, 0))
            local v3 = CurrentCamera
            local lookAt = CFrame.lookAt
            local v4 = Position_2
            local v5 = u333
            local v6 = u341
            local v7 = u92
            v2 = 1 - v1
            v3.CFrame = lookAt(v4 * (v2 * v2 * v2) + v5 * (v2 * 3 * v2 * v1) + v6 * (v2 * 3 * v1 * v1) + v7 * (v1 * v1 * v1), u331:Lerp(u95, v1))
            CurrentCamera.FieldOfView = FieldOfView + (u38 - FieldOfView) * v1
            setBeamAlpha(u297, 1 - v1 * 0.6, 1)
        end)
        if v5 then
            v5.Set("Idle")
        end
        local v17 = os.clock()
        while u53 == nil do
            if not (os.clock() - v17 < 6) then
                break
            end
            task.wait()
        end
        if u53 == true then
            local v18 = true
            if a5 ~= nil then
                v18 = a5()
            end
            if v18 then
                local v19, v20
                if a3:FindFirstChild("Lid") == nil then
                    u46.Stop()
                    return false
                end
                local u400, u401, u402 = lidParts(a3)
                local u408 = Fx.Play(Rumble, {Volume = 0.7, Looped = true, PlaybackSpeed = 0.8})
                if u408 then
                    self:Add(u408)
                end
                local u421 = partsOf(a3)
                local u422 = {}
                for k, n in u421 do
                    u422[k] = (Pivot:ToObjectSpace(n.CFrame))
                end
                local Lock = a3:FindFirstChild("Lock", true)
                local u439 = false
                local u446 = u92:Lerp(u95, 0.35)
                run(2.4, function(a1) -- Line: 662
                    -- upvalues: u421 (val), u422 (val), Pivot (val), Workspace (upval), poseLid (upval), u400 (val)
                    -- upvalues: u401 (val), u402 (val), Glow (val), u107 (upval), Light (val), Sparkle (val)
                    -- upvalues: u408 (val), Fx (upval), CurrentCamera (val), u92 (val), u446 (val), u95 (val)
                    -- upvalues: u38 (val), u439 (ref), Lock (val), Pop (upval), LookVector (val), run (upval)
                    local v1 = a1 * a1 * 0.35
                    local v2 = (CFrame.new(
                        math.noise(os.clock() * 25, 1) * v1,
                        math.abs((math.noise(os.clock() * 30, 2))) * v1,
                        math.noise(os.clock() * 25, 3) * v1
                    )) * CFrame.Angles(0, 0, math.noise(os.clock() * 20, 4) * v1 * 0.2)
                    v1 = table.create(#u421)
                    for i, j in u422 do
                        v1[i] = Pivot * v2 * j
                    end
                    Workspace:BulkMoveTo(u421, v1, Enum.BulkMoveMode.FireCFrameChanged)
                    poseLid(u400, u401, Pivot * v2 * Pivot:ToObjectSpace(u402), math.max(0, (math.sin((os.clock()) * 40))) * a1 * 6)
                    if Glow then
                        Glow.Color = u107:Lerp(Color3.new(1, 1, 1), a1 * 0.5)
                    end
                    if Light then
                        Light.Brightness = a1 * 4
                        Light.Range = a1 * 14 + 10
                    end
                    if Sparkle then
                        Sparkle.Rate = a1 * 30
                    end
                    if u408 then
                        u408.Volume = a1 * 0.6 + 0.3
                    end
                    v2 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    CurrentCamera.CFrame = (CFrame.lookAt(u92:Lerp(u446, v2), u95)) * CFrame.Angles(0, 0, math.noise(os.clock() * 12, 9) * a1 * 0.02)
                    CurrentCamera.FieldOfView = u38 - v2 * 16
                    if not u439 and a1 >= 0.72 and Lock then
                        u439 = true
                        v2 = table.find(u421, Lock)
                        if v2 then
                            table.remove(u421, v2)
                            table.remove(u422, v2)
                        end
                        Fx.Play(Pop, {Volume = 0.8, PlaybackSpeed = 0.7})
                        Fx.Burst(Lock.Position, u107, 16, 14, 0.6)
                        local CFrame_2 = Lock.CFrame
                        local u185 = LookVector * 6 + Vector3.new(0, 7, 0)
                        task.spawn(function() -- Line: 708 -- upvalues: run (upval), Lock (upval), CFrame_2 (val), u185 (val)
                            run(0.7, function(a1) -- Line: 709 -- upvalues: Lock (upval), CFrame_2 (upval), u185 (upval) -- types: a1: number
                                Lock.CFrame = (CFrame_2 + u185 * a1 - Vector3.new(0, a1 * 14 * a1, 0)) * CFrame.Angles(a1 * 9, a1 * 5, 0)
                                Lock.Transparency = math.max(0, a1 - 0.6) / 0.4
                            end)
                        end)
                    end
                end)
                if u408 then
                    u408:Destroy()
                end
                local v21 = table.create(#u421)
                for m, i5 in u422 do
                    v21[m] = Pivot * i5
                end
                Workspace:BulkMoveTo(u421, v21, Enum.BulkMoveMode.FireCFrameChanged)
                Fx.Play(ChestOpen, {Volume = 1})
                Fx.Play(Legendary, {Volume = 0.7})
                Fx.Flash(u107, 0.7, 0.02, 0.6)
                Fx.Shake(2.2, 0.45)
                if Sparkle then
                    Sparkle.Rate = 0
                    Sparkle:Emit(90)
                end
                Fx.Burst(Pivot.Position + Vector3.new(0, 3.5, 0), u107, 50, 26, 1.1)
                local u541 = shaft(self, Pivot.Position + Vector3.new(0, 3, 0), 22, u107, 2.5)
                setBeamAlpha(u541, 0.05, 1)
                task.spawn(function() -- Line: 736 -- upvalues: run (upval), setBeamAlpha (upval), u541 (val), u297 (val)
                    run(0.7, function(a1) -- Line: 737 -- upvalues: setBeamAlpha (upval), u541 (upval), u297 (upval) -- types: a1: number
                        setBeamAlpha(u541, a1 * 0.95 + 0.05, 1)
                        setBeamAlpha(u297, a1 * 0.6 + 0.4, 1)
                    end)
                end)
                local FieldOfView_2 = CurrentCamera.FieldOfView
                run(0.55, function(a1) -- Line: 743
                    -- upvalues: Fx (upval), poseLid (upval), u400 (val), u401 (val), u402 (val), CurrentCamera (val)
                    -- upvalues: FieldOfView_2 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    poseLid(u400, u401, u402, v1 * 108)
                    CurrentCamera.FieldOfView = FieldOfView_2 + math.sin(a1 * 3.141592653589793) * 10 + a1 * 6
                end)
                if Glow then
                    Fx.Tween(Glow, 0.6, {Color = u107})
                end
                local v22 = Pivot.Position + Vector3.new(0, 3, 0)
                local u587 = self:Add((GhostDogQuest_2.Ticket:Clone()))
                u587.Name = "GhostDogTicket"
                u587:PivotTo((CFrame.new(v22)))
                u587.Parent = Workspace
                u587:ScaleTo(0.27999999999999997)
                local u607 = Pivot.Position + LookVector * 2.5 + Vector3.new(0, 7.5, 0)
                local u610 = Pivot.Position + Vector3.new(0, 3, 0)
                local u619 = u607 + LookVector * 6.5 + RightVector * 1.2 + Vector3.new(0, 0.4000000059604645, 0)
                local v23 = Lighting:FindFirstChild("GhostDogUnderwaterBlur")
                if v23 and v23:IsA("BlurEffect") then
                    Fx.Tween(v23, 0.4, {Size = 0})
                end
                v23 = Lighting:FindFirstChild("GhostDogUnderwater")
                if v23 and v23:IsA("ColorCorrectionEffect") then
                    Fx.Tween(v23, 0.4, {Contrast = 0.05, TintColor = Color3.fromRGB(215, 240, 255)})
                end
                local Position_3 = CurrentCamera.CFrame.Position
                local FieldOfView_3 = CurrentCamera.FieldOfView
                run(1.4, function(a1) -- Line: 771
                    -- upvalues: Fx (upval), u610 (val), u607 (val), u587 (val), CurrentCamera (val), Position_3 (val)
                    -- upvalues: u619 (val), u95 (val), FieldOfView_3 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    local v2 = u610:Lerp(u607, v1)
                    u587:ScaleTo((math.max((0.2 + v1 * 0.8) * 1.4, 0.01)))
                    u587:PivotTo((CFrame.lookAt(v2, CurrentCamera.CFrame.Position)) * (CFrame.Angles(0, (1 - v1) * 3.141592653589793 * 6, 0)))
                    CurrentCamera.CFrame = CFrame.lookAt(Position_3:Lerp(u619, v1), u95:Lerp(u607, v1))
                    CurrentCamera.FieldOfView = FieldOfView_3 + (50 - FieldOfView_3) * v1
                end)
                Fx.Play(CollectSecretRing, {Volume = 0.7})
                Fx.Burst(u607, Color3.fromRGB(150, 255, 190), 30, 12, 0.7)
                Hud.Caption(GhostDogQuest.Captions.Ticket)
                local CFrame_2 = CurrentCamera.CFrame
                run(2.2, function(a1) -- Line: 786
                    -- upvalues: u587 (val), u607 (val), CFrame_2 (val), CurrentCamera (val), Fx (upval)
                    u587:PivotTo((CFrame.lookAt(u607 + Vector3.new(0, math.sin(a1 * 3.141592653589793 * 2) * 0.25, 0), CFrame_2.Position)) * (CFrame.Angles(
                        0,
                        math.sin(a1 * 3.141592653589793 * 2) * 0.17453292519943295,
                        (math.sin(a1 * 3.141592653589793 * 3)) * 0.04
                    )))
                    CurrentCamera.CFrame = CFrame_2 * CFrame.new(0, 0, -a1 * 0.8)
                    if math.random() < 0.05 then
                        Fx.Burst(
                            u607 + Vector3.new(math.random() * 4 - 2, math.random() * 2 - 1, 0),
                            Color3.fromRGB(255, 245, 200),
                            3,
                            4,
                            0.35
                        )
                    end
                end)
                Hud.Caption(nil)
                local Pivot_2 = u587:GetPivot()
                local CFrame_3 = CurrentCamera.CFrame
                local FieldOfView_4 = CurrentCamera.FieldOfView
                local u735 = CFrame.lookAt(u84.Position + RightVector * 6 + LookVector * 2.5 + Vector3.new(0, 2, 0), (u607 + u84.Position) * 0.5)
                run(0.4, function(a1) -- Line: 817
                    -- upvalues: Fx (upval), CurrentCamera (val), CFrame_3 (val), u735 (val), FieldOfView_4 (val)
                    -- upvalues: u38 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    CurrentCamera.CFrame = CFrame_3:Lerp(u735, v1)
                    CurrentCamera.FieldOfView = FieldOfView_4 + (u38 - FieldOfView_4) * v1
                end)

                local function v24() -- Line: 822 -- upvalues: HumanoidRootPart (val)
                    return HumanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0) + HumanoidRootPart.CFrame.LookVector * 0.6
                end

                local u762 = (Pivot_2.Position + (HumanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0) + HumanoidRootPart.CFrame.LookVector * 0.6)) * 0.5 + Vector3.new(0, 3, 0)
                Fx.Play(Swoosh, {Volume = 0.6, PlaybackSpeed = 1.2})
                run(0.55, function(a1) -- Line: 827
                    -- upvalues: Fx (upval), HumanoidRootPart (val), Pivot_2 (val), u762 (val), u587 (val)
                    -- upvalues: CurrentCamera (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v2 = HumanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0) + HumanoidRootPart.CFrame.LookVector * 0.6
                    local v3 = 1 - v1
                    u587:PivotTo((CFrame.lookAt(Pivot_2.Position * (v3 * v3) + u762 * (2 * v3 * v1) + v2 * (v1 * v1), CurrentCamera.CFrame.Position)) * (CFrame.Angles(0, v1 * 3.141592653589793 * 4, 0)))
                    u587:ScaleTo((math.max((1 - v1 * 0.85) * 1.4, 0.01)))
                end)
                u587:Destroy()
                Fx.Play(Pop, {Volume = 0.9, PlaybackSpeed = 1.3})
                Fx.Burst(
                    HumanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0) + HumanoidRootPart.CFrame.LookVector * 0.6,
                    Color3.fromRGB(150, 255, 190),
                    34,
                    16,
                    0.8
                )
                Fx.Flash(Color3.fromRGB(190, 255, 215), 0.3, 0.02, 0.3)
                Fx.Shake(0.8, 0.2)
                local v25 = true
                if a5 ~= nil then
                    v25 = a5()
                end
                if not v25 then
                    u46.Stop()
                    return false
                end
                v25 = (game:GetService("SoundService")):FindFirstChild("GhostDogChaseMusic")
                local u846 = if v25 == nil then nil else if not v25:IsA("Sound") then nil else v25
                local Volume = if not u846 then 0 else u846.Volume
                if u846 then
                    Fx.Tween(u846, 0.6, {Volume = 0})
                    self:Add(function() -- Line: 854 -- upvalues: u846 (val), Volume (val)
                        if u846.Parent then
                            u846.Volume = Volume
                        end
                    end)
                end
                local u874 = self:Add((Instance.new("ColorCorrectionEffect")))
                u874.Parent = Lighting
                local u882 = Fx.Play(GhostDogQuest.Sounds.GrowlLong, {Volume = 0.3})
                if u882 then
                    self:Add(u882)
                end
                local v26 = (Position - u84.Position) * Vector3.new(1, 0, 1)
                local Unit_2 = if not (0.05 < v26.Magnitude) then Unit_4 else v26.Unit

                local function v27() -- Line: 867
                    -- upvalues: u84 (val), Unit_2 (val), RightVector (val), Position (ref)
                    return CFrame.lookAt(u84.Position - Unit_2 * 6 + RightVector * 3.5 + Vector3.new(0, 2.5, 0), Position:Lerp(u84.Position, 0.2))
                end

                local function v28() -- Line: 871 -- upvalues: Fx (upval), Position (ref), u84 (val)
                    return Fx.Ease(
                        math.clamp((((Position - u84.Position) * Vector3.new(1, 0, 1)).Magnitude - 42) / 168, 0, 1),
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.InOut
                    )
                end

                local CFrame_4 = CurrentCamera.CFrame
                local FieldOfView_5 = CurrentCamera.FieldOfView
                run(1.3, function(a1) -- Line: 880
                    -- upvalues: Fx (upval), Position (ref), u84 (val), CurrentCamera (val), CFrame_4 (val)
                    -- upvalues: Unit_2 (val), RightVector (val), FieldOfView_5 (val), u38 (val), u874 (val)
                    -- upvalues: Highlight (val), u882 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    local v2 = Fx.Ease(
                        math.clamp((((Position - u84.Position) * Vector3.new(1, 0, 1)).Magnitude - 42) / 168, 0, 1),
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.InOut
                    ) * v1
                    CurrentCamera.CFrame = CFrame_4:Lerp(CFrame.lookAt(
                        u84.Position - Unit_2 * 6 + RightVector * 3.5 + Vector3.new(0, 2.5, 0),
                        (Position:Lerp(u84.Position, 0.2))
                    ), v1)
                    CurrentCamera.FieldOfView = FieldOfView_5 + (u38 - 8 - FieldOfView_5) * v1 - v2 * 14
                    u874.Brightness = -0.06 * v1
                    u874.Saturation = -0.12 * v1
                    Highlight.OutlineTransparency = 1 - v2 * 0.4
                    if u882 then
                        u882.Volume = 0.3 + v2 * 0.3
                    end
                end)
                run(0.45, function(a1) -- Line: 892
                    -- upvalues: Fx (upval), Position (ref), u84 (val), CurrentCamera (val), Unit_2 (val)
                    -- upvalues: RightVector (val), u38 (val), Highlight (val), u882 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v2 = Fx.Ease(
                        math.clamp((((Position - u84.Position) * Vector3.new(1, 0, 1)).Magnitude - 42) / 168, 0, 1),
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.InOut
                    )
                    CurrentCamera.CFrame = (CFrame.lookAt(u84.Position - Unit_2 * 6 + RightVector * 3.5 + Vector3.new(0, 2.5, 0), Position:Lerp(u84.Position, 0.2))) * CFrame.new(0, 0, -v1 * 1.2)
                    CurrentCamera.FieldOfView = u38 - 8 - v2 * 14
                    Highlight.OutlineTransparency = 1 - v2 * 0.4
                    if u882 then
                        u882.Volume = v2 * 0.3 + 0.3
                    end
                end)
                local v29 = true
                if a5 ~= nil then
                    v29 = a5()
                end
                if not v29 then
                    u46.Stop()
                    return false
                end
                local u1018 = fishLevel(u84.Position + Unit_2 * 11, v10)
                v29 = (u1018 - Position) * Vector3.new(1, 0, 1)
                local Unit_3 = if not (0.1 < v29.Magnitude) then -Unit else v29.Unit
                local u1052 = math.acos((math.clamp(Unit:Dot(Unit_3), -1, 1)))
                local v30 = Unit_3
                local u1060 = if not (0 <= Unit:Cross(v30).Y) then -1 else 1
                local u1064 = u46.Get()
                local u1066 = Unit
                local u1082 = u169
                local u1083 = false
                local OutlineTransparency = Highlight.OutlineTransparency
                Fx.Play(GhostDogQuest.Sounds.FishTurn, {Volume = 0.8})
                run(0.5, function(a1, a2) -- Line: 918
                    -- upvalues: Fx (upval), u1066 (ref), u1052 (val), u1060 (val), Unit (ref), Position (ref)
                    -- upvalues: u1082 (val), u148 (ref), u196 (ref), Highlight (val), OutlineTransparency (val)
                    -- upvalues: u874 (val), u882 (val), u1083 (ref), exclaim (upval), self (val), Character (val)
                    -- upvalues: u46 (val), u1064 (val), CurrentCamera (val), u84 (val), Unit_2 (val), RightVector (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    u1066 = (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), u1052 * u1060 * v1)):VectorToWorldSpace(Unit)
                    Position = Position + u1066 * (u1082 * (1 - v1) + 12 * v1) * a2
                    local v2 = u148
                    local v3 = Position
                    local v4 = Position + u1066
                    v2:PivotTo((CFrame.lookAt(v3, (Vector3.new(v4.X, v3.Y, v4.Z)))) * CFrame.new(0, -8, 0) * (CFrame.Angles(0, 0, -u1060 * (math.sin(a1 * 3.141592653589793)) * 0.45)))
                    if u196 then
                        u196:AdjustSpeed(1.1 + v1 * 0.9)
                    end
                    Highlight.FillTransparency = 1 - 0.15 * v1
                    Highlight.OutlineTransparency = OutlineTransparency + (0.3 - OutlineTransparency) * v1
                    u874.Brightness = -0.06 - 0.12 * v1
                    u874.Saturation = -0.12 - 0.23 * v1
                    u874.TintColor = (Color3.new(1, 1, 1)):Lerp(Color3.fromRGB(255, 200, 200), v1)
                    if u882 then
                        u882.Volume = 0.6 + v1 * 0.4
                    end
                    v2 = Fx.Ease((math.clamp((a1 - 0.3) / 0.5, 0, 1)))
                    if a1 > 0.4 and not u1083 then
                        u1083 = true
                        exclaim(self, Character)
                    end
                    u46.Set(u1064 * CFrame.new(0, 0, 0.6 * v2) * CFrame.Angles(0.17453292519943295 * v2, 0, 0))
                    CurrentCamera.CFrame = (CFrame.lookAt(u84.Position - Unit_2 * 6 + RightVector * 3.5 + Vector3.new(0, 2.5, 0), Position:Lerp(u84.Position, 0.2))) * CFrame.new(0, 0, -1.2) * CFrame.Angles(0, 0, math.noise(os.clock() * 6, 11) * v1 * 0.02)
                end)
                if u882 then
                    Fx.Tween(u882, 0.35, {Volume = 0})
                end
                Fx.Play(GhostDogQuest.Sounds.GrowlShort, {Volume = 1})
                Fx.Shake(1.6, 0.5)
                playAnimation(u148, "GhostFish_Bite", false, 0.9)
                if u196 then
                    u196:AdjustSpeed(2.4)
                end
                local u1211 = u84.Position + RightVector * 14 + Unit_2 * 10 + Vector3.new(0, 4, 0)
                local u1214 = Position
                local CFrame_5 = CurrentCamera.CFrame
                local FieldOfView_6 = CurrentCamera.FieldOfView
                local v31 = math.clamp((u1018 - u1214).Magnitude / 90, 0.5, 3)
                local v32 = u1214.Y
                local v33 = GhostDogQuest.ChaseFrame
                local v34 = GhostDogQuest.Chase
                local v35 = u1214 - v34.Center
                local u1266 = v32 - v33(a2, (math.atan2(v35.Z, v35.X) - v34.StartAngle) % 6.283185307179586 * v34.Radius).Y
                v33 = u1018.Y
                local v36 = GhostDogQuest.ChaseFrame
                v35 = GhostDogQuest.Chase
                local v37 = u1018 - v35.Center
                local u1286 = v33 - v36(a2, (math.atan2(v37.Z, v37.X) - v35.StartAngle) % 6.283185307179586 * v35.Radius).Y
                run(v31, function(a1) -- Line: 967
                    -- upvalues: u1214 (val), u1018 (val), GhostDogQuest (upval), a2 (val), u1266 (val), u1286 (val)
                    -- upvalues: u148 (ref), Unit_3 (ref), Fx (upval), CurrentCamera (val), CFrame_5 (val), u1211 (val)
                    -- upvalues: u84 (val), FieldOfView_6 (val), u38 (val)
                    local v1 = a1 * 0.25 + a1 * a1 * 0.75
                    local v2 = u1214:Lerp(u1018, v1)
                    local X = v2.X
                    local ChaseFrame = GhostDogQuest.ChaseFrame
                    local v3 = a2
                    local Chase = GhostDogQuest.Chase
                    local v4 = v2 - Chase.Center
                    local v5 = Vector3.new(
                        X,
                        ChaseFrame(v3, (math.atan2(v4.Z, v4.X) - Chase.StartAngle) % 6.283185307179586 * Chase.Radius).Y + u1266 + (u1286 - u1266) * v1,
                        v2.Z
                    )
                    local v6 = u148
                    local v7 = v5 + Unit_3
                    v6:PivotTo((CFrame.lookAt(v5, (Vector3.new(v7.X, v5.Y, v7.Z)))) * (CFrame.new(0, -8, 0)))
                    v2 = Fx.Ease(math.min(a1 / 0.55, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    CurrentCamera.CFrame = (CFrame_5:Lerp(CFrame.lookAt(u1211, v5:Lerp(u84.Position, 0.35)), v2)) * CFrame.Angles(0, 0, math.noise(os.clock() * 16, 5) * a1 * 0.03)
                    CurrentCamera.FieldOfView = FieldOfView_6 + (u38 - 16 - FieldOfView_6) * a1
                    if a1 > 0.7 and math.random() < 0.12 then
                        Fx.Shake(a1 + 0.5, 0.12)
                    end
                end)
                Fx.Play(Chomp, {Volume = 1})
                Fx.Play(GhostDogQuest.Sounds.PulledUnder, {Volume = 1})
                Fx.Flash(Color3.fromRGB(160, 255, 225), 0.6, 0.02, 0.4)
                Fx.Shake(3.5, 0.6)
                v31 = u148:FindFirstChild("MouthGlow", true)
                if v31 then
                    v33 = Instance.new("Attachment")
                    v33.Parent = v31
                    v36 = self:Add((Instance.new("Attachment")))
                    v36.Parent = HumanoidRootPart
                    local v38 = Instance.new("Beam")
                    v38.Attachment0 = v33
                    v38.Attachment1 = v36
                    v38.Width0 = 0.35
                    v38.Width1 = 0.35
                    v38.LightEmission = 1
                    v38.FaceCamera = true
                    v38.Color = ColorSequence.new(Fx.Ghost)
                    v38.Parent = v31
                end
                task.wait(0.25)
                local u1378 = self:Add((Instance.new("BlurEffect")))
                u1378.Size = 0
                u1378.Parent = Lighting
                local u1385 = u46.Get()
                local Pivot_3 = u148:GetPivot()
                local u1395 = u1385.Position + Unit_3 * 40 + Vector3.new(0, 55, 0)
                v34 = Fx.Play(SlideLoop, {Volume = 0.7, Looped = true, PlaybackSpeed = 1.6})
                if v34 then
                    self:Add(v34)
                end
                Hud.Bubbles(1.6, 70)
                if v5 then
                    v5.Set("Swim", 1.8)
                end
                local u1436 = Hud.FadeFrame()
                if u1436 then
                    u1436.BackgroundColor3 = u112
                end
                run(2, function(a1) -- Line: 1027
                    -- upvalues: Fx (upval), u1385 (val), u1395 (val), u46 (val), u148 (ref), Pivot_3 (val)
                    -- upvalues: Unit_3 (ref), CurrentCamera (val), u1211 (val), u38 (val), u1378 (val), u874 (val)
                    -- upvalues: u1436 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v2 = u1385.Position:Lerp(u1395, v1)
                    u46.Set((CFrame.lookAt(v2, v2 + (u1395 - u1385.Position).Unit)) * CFrame.Angles(-1.3962634015954636, 0, a1 * 9))
                    u148:PivotTo(Pivot_3 + (v2 - u1385.Position) * 1.08 + Unit_3 * 4 * v1)
                    CurrentCamera.CFrame = CFrame.lookAt(u1211:Lerp(v2 - Vector3.new(0, 6, 0) - Unit_3 * 8, v1 * 0.6), v2)
                    CurrentCamera.FieldOfView = u38 + v1 * 30
                    u1378.Size = v1 * 18
                    u874.Brightness = -0.18 * (1 - v1)
                    if u1436 then
                        u1436.BackgroundTransparency = 1 - math.clamp((a1 - 0.8) / 0.2, 0, 1)
                    end
                end)
                if v34 then
                    v34:Destroy()
                end
                u46.Stop()
                v34 = false
                for i6 = 1, 3 do
                    v19, v20 = pcall(function() -- Line: 1052 -- upvalues: Remotes (upval)
                        return Remotes.GhostDogQuest.Surface:InvokeServer()
                    end)
                    if v19 and v20 == true then
                        v34 = true
                        break
                    end
                    task.wait(0.5)
                end
                return v34
            end
        end
        u46.Stop()
        return false
    end
    return false
end

function v1.Rescue(a1, a2, a3) -- Line: 1064
    -- upvalues: Hud (val), LocalPlayer (val), Cast (val), Cine (val), Npcs (val), u112 (val), GhostDogQuest (val)
    -- upvalues: Fx (val), puppet (val), Swim (val), Workspace (val), SlideLoop (val), Swoosh (val), run (val)
    -- upvalues: SlideHit (val), HeavyLand (val), Speech (val), revealTicket (val)
    local v1 = Hud.Get()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local ReturnSpot = a2:FindFirstChild("ReturnSpot")
    local CastTarget = a2:FindFirstChild("CastTarget")
    if v1 ~= nil
        and Character ~= nil
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and Humanoid ~= nil
        and ReturnSpot ~= nil
        and ReturnSpot:IsA("BasePart")
        and CastTarget ~= nil
        and CastTarget:IsA("BasePart") then
        local function stillAlive() -- Line: 1084 -- upvalues: a3 (val)
            local v1 = true
            if a3 ~= nil then
                v1 = a3()
            end
            return v1
        end

        local v2 = a1:Extend()
        Cast.LockControls(v2)
        local u62 = Cine.Take(a1)
        a1:Add(function() -- Line: 1090 -- upvalues: u62 (val), LocalPlayer (upval)
            if u62.CameraType == Enum.CameraType.Scriptable then
                local Character = LocalPlayer.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                u62.CameraType = Enum.CameraType.Custom
                if Humanoid then
                    u62.CameraSubject = Humanoid
                end
            end
        end)
        u62.FieldOfView = Cine.RestingFov()
        local CFrame_2 = ReturnSpot.CFrame
        local Position = CastTarget.Position
        local u792 = Npcs.Fisherman()
        local u78 = Npcs.Dog()
        Npcs.SetRodVisible(true)
        local u85 = Hud.FadeFrame()
        if u85 == nil then
            return
        end
        u85.BackgroundColor3 = u112
        u85.BackgroundTransparency = 0
        Hud.Caption(GhostDogQuest.Captions.Rescue)
        local v3 = os.clock()
        while 25 < (HumanoidRootPart.Position - CFrame_2.Position).Magnitude do
            if not (os.clock() - v3 < 6) then
                break
            end
            task.wait()
        end
        if not (25 < (HumanoidRootPart.Position - CFrame_2.Position).Magnitude) then
            local v4 = true
            if a3 ~= nil then
                v4 = a3()
            end
            if v4 then
                local v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
                Humanoid.PlatformStand = true
                a1:Add(function() -- Line: 1123 -- upvalues: Humanoid (val), u85 (val), Hud (upval)
                    Humanoid.PlatformStand = false
                    u85.BackgroundColor3 = Color3.new(0, 0, 0)
                    Hud.Caption(nil)
                end)
                local u820 = puppet(a1, HumanoidRootPart, "GhostDogRescuePuppet")
                v4 = Swim.Start(a1, Character, "Idle")
                local v15 = Position.Y + 0.3
                local v16 = (CFrame.new(Position - Vector3.new(0, 6, 0))) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v17 = (CFrame.new(Position - Vector3.new(0, 1.600000023841858, 0))) * CFrame.Angles(-1.5707963267948966, 0, 0)
                u820.Set(v16)
                local Position_2 = CFrame_2.Position
                local v18 = (Position - Position_2) * Vector3.new(1, 0, 1)
                local Unit_2 = if not (0.1 < v18.Magnitude) then -CFrame_2.LookVector else v18.Unit
                local Unit_3 = Vector3.new(0, 1, 0):Cross(Unit_2).Unit
                local Position_3 = if not u792 then Position_2 - Unit_2 * 4 else u792.Rig.Root.Position
                local v19 = {}
                if u792 then
                    table.insert(v19, u792.Model)
                end
                if u78 then
                    table.insert(v19, u78.Model)
                end
                local v20 = Humanoid.HipHeight + HumanoidRootPart.Size.Y * 0.5
                local v21 = RaycastParams.new()
                v21.FilterType = Enum.RaycastFilterType.Exclude
                local v22 = {Character}
                for i, j in v19 do
                    table.insert(v22, j)
                end
                v21.FilterDescendantsInstances = v22
                v21.RespectCanCollide = true
                local u263 = Position_2 + Vector3.new(0, 3, 0)
                v22 = if not ((Position - (Position_3 + Unit_3)).Magnitude < (Position - (Position_3 - Unit_3)).Magnitude) then -Unit_3 else Unit_3
                for k, n in {v22, -v22, -Unit_2} do
                    v5 = Workspace:Raycast(Position_3 + n * 4.5 + Vector3.new(0, 6, 0), Vector3.new(0, -16, 0), v21)
                    if v5 and v5.Material ~= Enum.Material.Water then
                        u263 = v5.Position + Vector3.new(0, v20, 0)
                        break
                    end
                end
                v22 = (Position_3 - u263) * Vector3.new(1, 0, 1)
                local Unit_4 = if not (0.1 < v22.Magnitude) then CFrame_2.LookVector else v22.Unit
                local u340 = CFrame.lookAt(u263, u263 + Unit_4)
                local u855 = Vector3.new(Position.X, v15, Position.Z)
                local v23 = u263 - u855
                local v24 = -Unit_2
                local v25 = v23 * Vector3.new(1, 0, 1)
                local Unit = if not (0.05 < v25.Magnitude) then v24 else v25.Unit
                local Unit_5 = Vector3.new(0, 1, 0):Cross(Unit).Unit
                v23 = u855 + Vector3.new(0, 6, 0)
                v24 = u855 + Vector3.new(0, 11, 0)
                local u870 = (u855:Lerp(u263, 0.6)) + Vector3.new(0, 2, 0)
                local u875 = Cine.Unclip(u870, u855 - Unit * 7 + Unit_5 * 5 + Vector3.new(0, 4.5, 0), v19)
                local v26 = v24 - Unit * 2 + Vector3.new(0, 1.5, 0)
                local v27 = u875 + Vector3.new(0, 4, 0) + Unit_5 * 1.5
                local u418 = Cine.SpeedLens(0.3, 22)
                local u890 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -0.3141592653589793)

                local function topDown(a1, a2) -- Line: 1189
                    -- upvalues: u890 (val), Unit (val), u855 (val)
                    return CFrame.lookAt(a1, u855, ((u890:Lerp(CFrame.identity, a2)):VectorToWorldSpace(Unit)))
                end

                Cine.Cut(CFrame.lookAt(v23, u855, ((u890:Lerp(CFrame.identity, 0)):VectorToWorldSpace(Unit))), 60)
                local v28 = nil
                local v29 = nil
                local v30 = nil
                if u792 then
                    local Root = u792.Rig.Root
                    v7 = Vector3.new(u855.X, Root.Y, u855.Z)
                    if 0.5 < (v7 - Root.Position).Magnitude then
                        v29 = Root
                        v30 = CFrame.lookAt(Root.Position, v7)
                    end
                    u792.Rig:SetMood("Reel")
                    local RodTip = u792.Model:FindFirstChild("RodTip", true)
                    if RodTip and RodTip:IsA("Attachment") then
                        v6 = a1:Add((Instance.new("Attachment")))
                        v6.Parent = HumanoidRootPart
                        local v31 = a1:Add((Instance.new("Beam")))
                        v31.Attachment0 = RodTip
                        v31.Attachment1 = v6
                        v31.Width0 = 0.14
                        v31.Width1 = 0.14
                        v31.LightEmission = 1
                        v31.FaceCamera = true
                        v31.Color = ColorSequence.new(Fx.Ghost)
                        v31.Parent = Workspace
                        v28 = v31
                    end
                end
                if u78 then
                    u78.Rig:SetMood("Happy")
                end
                v6 = Fx.Play(SlideLoop, {Volume = 0.6, Looped = true, PlaybackSpeed = 1.9})
                if v6 then
                    a1:Add(v6)
                end
                Fx.Tween(u85, 0.45, {BackgroundTransparency = 1})
                v7 = os.clock()
                while true do
                    v8 = os.clock()
                    v9 = math.min(v8 - v7, 2.1500000000000004)
                    v10 = v9 / 2.1500000000000004
                    if u792 and v29 and v30 then
                        u792.Rig:SetRoot((v29:Lerp(v30, (Fx.Ease((math.min(v9 / 0.4, 1)))))))
                    end
                    u820.Set((v16:Lerp(v17, v10 * v10)) * CFrame.Angles(0, 0, math.sin(v10 * 25) * 0.15))
                    if math.random() < 0.15 then
                        Fx.Ripple(u855, v10 + 0.5)
                    end
                    if v28 then
                        v28.CurveSize0 = (math.sin(v8 * 30)) * (1 - v10) * 1.5
                    end
                    if not (v9 < 1.1) then
                        v12 = (v9 - 1.1) / 1.05
                        v13 = Fx.Ease(v12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        v14 = 1 - v13
                        v12 = v24 * (v14 * v14 * v14) + v26 * (v14 * 3 * v14 * v13) + v27 * (v14 * 3 * v13 * v13) + u875 * (v13 * v13 * v13)
                        v14 = Unit:Lerp(Vector3.new(0, 1, 0), v13)
                        v11 = CFrame.lookAt(v12, u855:Lerp(u870, v13), v14.Unit)
                    else
                        v12 = v9 / 1.1
                        v13 = Fx.Ease(v12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        v11 = CFrame.lookAt(v23:Lerp(v24, v13), u855, ((u890:Lerp(CFrame.identity, v13)):VectorToWorldSpace(Unit)))
                    end
                    u62.CFrame = v11 * CFrame.Angles(0, 0, math.noise(v8 * 10, 7) * v10 * 0.01)
                    u62.FieldOfView = u418(v11.Position, v8 - v7, 60)
                    if v9 >= 2.1500000000000004 then
                        break
                    end
                    task.wait()
                end
                Hud.Caption(nil)
                if v6 then
                    v6:Destroy()
                end
                Fx.Splash(u855, 2)
                Fx.Play(GhostDogQuest.Sounds.Splash, {Volume = 1})
                Fx.Play(Swoosh, {Volume = 0.8, PlaybackSpeed = 0.9})
                Fx.Shake(1.6, 0.3)
                if v4 then
                    v4.Set("Swim", 2)
                end
                if u792 then
                    u792.Rig:SetMood("Reel")
                end
                local u1014 = Vector3.new(Position.X, v15 + 1, Position.Z)
                local u1034 = math.clamp((u263 - u1014).Magnitude * 0.15, 2.5, 5)
                local Rotation = v17.Rotation
                local u1048 = u875 + Unit * 2.5 + Vector3.new(0, 1, 0)
                run(0.85, function(a1, a2) -- Line: 1290
                    -- upvalues: Fx (upval), u1014 (val), u263 (ref), u1034 (val), u820 (val), Rotation (val)
                    -- upvalues: u340 (val), u875 (val), u1048 (val), u62 (val), u870 (val), u418 (val)
                    local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    local v2 = (u1014:Lerp(u263, v1)) + Vector3.new(0, (math.sin(a1 * 3.141592653589793)) * u1034, 0)
                    u820.Set((CFrame.new(v2)) * Rotation:Lerp(u340.Rotation, v1))
                    v1 = u875:Lerp(u1048, (Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
                    u62.CFrame = CFrame.lookAt(v1, u870:Lerp(v2, 0.55))
                    u62.FieldOfView = u418(v1, a2, 60 - math.sin(a1 * 3.141592653589793) * 4)
                end)
                u820.Set(u340)
                Swim.Stop()
                if v28 then
                    v28:Destroy()
                end
                Fx.Play(SlideHit, {Volume = 0.6})
                Fx.Play(HeavyLand, {Volume = 0.3, PlaybackSpeed = 1.3})
                Fx.Shake(0.8, 0.25)
                Fx.Burst(u263 - Vector3.new(0, v20, 0), Color3.fromRGB(200, 255, 240), 14, 8, 0.6)
                if u792 then
                    u792.Rig:SetMood("Pet")
                end
                if u78 then
                    u78.Rig:SetMood("Spin")
                end
                v29 = Position_3 + Vector3.new(0, 5.800000190734863, 0)
                Cine.Blend(Cine.TwoShot(u263, v29, 1, 11, 3, v19), 0.6, 55)
                task.wait(0.5)
                if u78 then
                    u78.Rig:SetMood("Happy")
                end
                u820.Stop()
                HumanoidRootPart.CFrame = u340
                Humanoid.PlatformStand = false
                v8 = true
                if a3 ~= nil then
                    v8 = a3()
                end
                if not v8 then
                    return
                end
                Cine.Release(Humanoid, HumanoidRootPart)
                v2:Clean()
                if u792 then
                    Npcs.FacePlayer(u792)
                    u792.Rig:SetMood("Talk")
                    task.wait(0.35)
                    Speech.Say(u792.Model, u792.Head, GhostDogQuest.Lines.Rescue, {
                        WalkAway = 40,
                        Voice = u792.Voice,
                        OnLine = function(a1) -- Line: 1338 -- upvalues: u78 (val) -- types: a1: number
                            if u78 and a1 == 3 then
                                u78.Rig:SetMood("Happy")
                            end
                        end,
                    })
                    u792.Rig:SetMood("Idle")
                end
                revealTicket()
                if u792 then
                    u792.Rig:SetMood("Cheer")
                    task.delay(2.5, function() -- Line: 1349 -- upvalues: u792 (val)
                        if u792.Model.Parent then
                            u792.Rig:SetMood("Idle")
                        end
                    end)
                end
                if u78 then
                    u78.Rig:SetMood("Happy")
                end
                return
            end
        end
        Hud.Caption(nil)
        Fx.Tween(u85, 0.4, {BackgroundTransparency = 1})
        return
    end
end

return table.freeze(v1)