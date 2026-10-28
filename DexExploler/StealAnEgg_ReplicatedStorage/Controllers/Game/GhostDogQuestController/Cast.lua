-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Cast
-- Decompile time: 22.61 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Cine = require(script.Parent.Cine)
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Hud = require(script.Parent.Hud)
local Swim = require(script.Parent.Swim)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Sounds = ReplicatedStorage.Assets.Sounds
local Bobber = ReplicatedStorage.Assets.GhostDogQuest.Bobber
local Swoosh = Sounds.ScrambleBoss.Swoosh
local Ghost = Fx.Ghost
local u61 = Color3.fromRGB(14, 52, 64)
local u62 = {}

local function controls() -- Line: 50 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule == nil then
        return nil
    end
    local success, err = pcall(require, PlayerModule)
    if not success then
        return nil
    end
    return err:GetControls()
end

function u62.LockControls(a1) -- Line: 63 -- upvalues: LocalPlayer (val)
    local u22
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil then
        local success, err = pcall(require, PlayerModule)
        u22 = if success then err:GetControls() else nil
    else
        u22 = nil
    end
    if u22 then
        u22:Disable()
        a1:Add(function() -- Line: 67 -- upvalues: u22 (val)
            u22:Enable()
        end)
    end
end

local function rodTip(a1) -- Line: 73 -- upvalues: GhostDogQuest (val) -- types: a1: userdata
    local RodAttribute, RodTip
    for i, j in a1:GetChildren() do
        if j:IsA("Tool") then
            RodAttribute = GhostDogQuest.RodAttribute
            if j:GetAttribute(RodAttribute) == true then
                RodTip = j:FindFirstChild("RodTip", true)
                if RodTip and RodTip:IsA("Attachment") then
                    return RodTip
                end
            end
        end
    end
    return nil
end

function u62.EquipRod(a1) -- Line: 85
    -- upvalues: LocalPlayer (val), GhostDogQuest (val), rodTip (val)
    local v1
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if Humanoid and Backpack then
        local RodAttribute
        for i, j in Backpack:GetChildren() do
            if j:IsA("Tool") then
                RodAttribute = GhostDogQuest.RodAttribute
                if j:GetAttribute(RodAttribute) == true then
                    Humanoid:EquipTool(j)
                    break
                end
            end
        end
    end
    local v2 = os.clock()
    while true do
        if not (os.clock() - v2 < 1) then
            break
        end
        v1 = rodTip(a1)
        if v1 then
            return v1
        end
        task.wait()
    end
    return (rodTip(a1))
end

local function hide(a1) -- Line: 107 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Transparency = 1
        elseif j:IsA("ParticleEmitter") then
            j.Enabled = false
        end
    end
end

local function exclaim(a1, a2) -- Line: 117 -- upvalues: LocalPlayer (val), Fx (val) -- types: a2: userdata
    local v1 = a1:Add((Instance.new("BillboardGui")))
    v1.Size = UDim2.fromScale(3, 3)
    v1.StudsOffsetWorldSpace = Vector3.new(0, 3.200000047683716, 0)
    v1.AlwaysOnTop = true
    v1.Adornee = a2
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.Text = "!"
    TextLabel.TextScaled = true
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
    TextLabel.TextColor3 = Color3.fromRGB(255, 225, 90)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 4
    UIStroke.Parent = TextLabel
    local UIScale = Instance.new("UIScale")
    UIScale.Parent = TextLabel
    TextLabel.Parent = v1
    v1.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    Fx.Punch(UIScale, 2.2, 0.35)
end

local function throw(a1, a2, a3, a4, a5, a6) -- Line: 140
    -- upvalues: Workspace (val), Bobber (val), Ghost (val), Fx (val), Swoosh (val), GhostDogQuest (val)
    local WorldPosition, new_5, v1, v2, v3, v4
    local CurrentCamera = Workspace.CurrentCamera
    local v5 = a1:Add((Bobber:Clone()))
    local Line = v5:FindFirstChild("Line", true)
    v5:PivotTo((CFrame.new(if not a2 then a3.Position + Vector3.new(0, 4, 0) else a2.WorldPosition)))
    v5.Parent = Workspace
    if a2 then
        v1 = a1:Add((Instance.new("Beam")))
        v1.Attachment0 = a2
        v1.Attachment1 = Line
        v1.Width0 = 0.08
        v1.Width1 = 0.08
        v1.LightEmission = 1
        v1.FaceCamera = true
        v1.Color = ColorSequence.new(Ghost)
        v1.CurveSize0 = 2
        v1.Parent = v5
    end
    Fx.Play(Swoosh, {Volume = 0.6, PlaybackSpeed = 0.8})
    v1 = os.clock()
    while true do
        v1 = math.min((os.clock() - v1) / 0.85, 1)
        v5:PivotTo((CFrame.new((WorldPosition:Lerp(a4, v1)) + (Vector3.new(0, (math.sin(v1 * 3.141592653589793)) * 9, 0)))))
        CurrentCamera.CFrame = CFrame.lookAt(a5, a6:Lerp((v5:GetPivot()).Position, 0.35))
        if v1 >= 1 then
            break
        end
        task.wait()
    end
    Fx.Splash(a4 + Vector3.new(0, 0.30000001192092896, 0), 0.5)
    Fx.Play(GhostDogQuest.Sounds.Splash, {Volume = 0.5})
    for i = 1, 2 do
        v3 = os.clock()
        while true do
            if not (os.clock() - v3 < 0.8) then
                break
            end
            v4 = (os.clock()) - v3
            new_5 = CFrame.new
            v2 = Vector3.new(0, math.sin(v4 * 6) * 0.15 + 0.3, 0)
            v5:PivotTo((new_5(v6 + v2)))
            task.wait()
        end
        v5:PivotTo((CFrame.new(v6 + Vector3.new(0, -0.30000001192092896, 0))))
        Fx.Ripple(v6 + Vector3.new(0, 0.30000001192092896, 0), i * 0.15 + 0.4)
        Fx.Play(GhostDogQuest.Sounds.Nibble[i], {Volume = i * 0.15 + 0.55})
        Fx.Shake(i * 0.4, 0.2)
        task.wait(0.15)
    end
    return v5
end

function u62.Play(a1, a2, a3) -- Line: 197
    -- upvalues: LocalPlayer (val), u62 (val), Workspace (val), Cine (val), throw (val), exclaim (val), Fx (val)
    -- upvalues: GhostDogQuest (val), hide (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local Head = Character and Character:FindFirstChild("Head")
    if Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and Humanoid ~= nil then
        local Target, v1, v2
        if not a3 then
            local CFrame_2 = a2:FindFirstChild("CastSpot").CFrame
            Target = a2:FindFirstChild("CastTarget").Position
            v2 = CFrame.lookAt(CFrame_2.Position + Vector3.new(0, 3, 0), (Vector3.new(Target.X, CFrame_2.Position.Y + 3, Target.Z)))
        else
            Target = a3.Target
            v2 = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Target.X, HumanoidRootPart.Position.Y, Target.Z)))
        end
        u62.LockControls(a1)
        HumanoidRootPart.CFrame = v2
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        local v3 = u62.EquipRod(Character)
        local CurrentCamera = Workspace.CurrentCamera
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        a1:Add(function() -- Line: 225 -- upvalues: CurrentCamera (val), Humanoid (val)
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.CameraSubject = Humanoid
        end)
        local RightVector = v2.RightVector
        local v4 = Cine.Unclip(v2.Position + Vector3.new(0, 2, 0), v2.Position - v2.LookVector * 10 - RightVector * 6 + Vector3.new(0, 6, 0))
        local v5 = v2.Position:Lerp(Target, 0.45)
        CurrentCamera.CFrame = CFrame.lookAt(v4, v5)
        if Head and Head:IsA("BasePart") then
            exclaim(a1, Head)
        end
        Fx.Play(GhostDogQuest.Sounds.GrowlShort, {Volume = 0.9})
        Fx.Flash(Color3.new(1, 1, 1), 0.45, 0.02, 0.4)
        Fx.Shake(2.6, 0.6)
        Fx.Splash(Target + Vector3.new(0, 0.30000001192092896, 0), 1.6)
        hide(if not a3 then throw(a1, v3, HumanoidRootPart, Target, v4, v5) else a1:Add(a3.Bobber))
        u62.Tug(a1, HumanoidRootPart, v1, v2, Target, v4)
        Fx.Play(GhostDogQuest.Sounds.PulledUnder, {Volume = 1})
        u62.Plunge(a1, HumanoidRootPart, Humanoid, Target)
        return true
    end
    return false
end

function u62.Tug(a1, a2, a3, a4, a5, a6) -- Line: 257
    -- upvalues: Workspace (val), Fx (val)
    local v1, v2, v3, v4, v5
    local CurrentCamera = Workspace.CurrentCamera
    local Beam = a3:FindFirstChildWhichIsA("Beam", true)
    local v6 = a5 - Vector3.new(0, 3.5, 0)
    local v7 = a4.Position:Lerp(a5, 0.45)
    local v8 = a6:Lerp(a4.Position + Vector3.new(0, 1.5, 0), 0.35)
    local Unit = (a5 - a4.Position).Unit
    local v9, v10, v11, v12, v13 = a5, a2, a3, a4, a6
    for i = 1, 3 do
        v1 = i / 3
        Fx.Shake(v1 * 1.6 + 0.8, 0.22)
        Fx.Ripple(v9 + Vector3.new(0, 0.30000001192092896, 0), v1 + 0.5)
        v2 = os.clock()
        while true do
            v3 = math.min((os.clock() - v2) / 0.36, 1)
            v4 = (i - 1 + Fx.Ease(v3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)) / 3
            v5 = (math.sin((math.min(v3 / 0.35, 1)) * 3.141592653589793 * 0.5)) * (1 - Fx.Ease(math.max(v3 - 0.35, 0) / 0.65, Enum.EasingStyle.Quad)) * (v1 * 0.6 + 0.6)
            v11:PivotTo((CFrame.new(v6 - (Vector3.new(0, v5 * 1.5, 0)))))
            if Beam then
                Beam.CurveSize0 = 0
                Beam.CurveSize1 = 0
                Beam.Width0 = 0.08 + v5 * 0.1
                Beam.Width1 = Beam.Width0
            end
            v10.CFrame = v12 * CFrame.new(0, 0, v4 * 0.8 - v5 * 1.1) * CFrame.Angles(math.rad(14 * v4 - 16 * v5), 0, (math.rad(v5 * 4)))
            v10.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            CurrentCamera.CFrame = CFrame.lookAt((v13:Lerp(v8, v4)) + Unit * v5 * 0.6, v7:Lerp(v9, v4 * 0.3))
            if math.random() < 0.3 then
                Fx.Ripple(v9 + Vector3.new(0, 0.30000001192092896, 0), v1 + 0.4)
            end
            if v3 >= 1 then
                break
            end
            task.wait()
        end
        if i < 3 then
            v2 = os.clock()
            while true do
                if not (os.clock() - v2 < 0.2) then
                    break
                end
                v11:PivotTo((CFrame.new(v6 + (Vector3.new(math.sin(((os.clock()) - v2) * 30) * 0.15, 0, 0)))))
                task.wait()
            end
        end
    end
end

local function bezier(a1, a2, a3, a4, a5) -- Line: 317
    -- upvalues: 
    local v1 = 1 - a5
    return a1 * (v1 * v1 * v1) + a2 * (v1 * 3 * v1 * a5) + a3 * (v1 * 3 * a5 * a5) + a4 * (a5 * a5 * a5)
end

function u62.Plunge(a1, a2, a3, a4) -- Line: 322
    -- upvalues: Workspace (val), Lighting (val), Cine (val), Hud (val), u61 (val), Fx (val), GhostDogQuest (val)
    -- upvalues: Swim (val)
    local Angles, Unit, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local CurrentCamera = Workspace.CurrentCamera
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local v12 = a4.Y + 0.3
    local v13 = Vector3.new(a4.X, v12, a4.Z)
    local Position = a2.Position
    local v14 = Vector3.new(a4.X - Position.X, 0, a4.Z - Position.Z)
    v14 = a4 + (if not (0.1 < v14.Magnitude) then Vector3.new(-1, 0, 0) else v14.Unit) * 10 - Vector3.new(0, 16, 0)
    a3.PlatformStand = true
    a1:Add(function() -- Line: 332 -- upvalues: a3 (val)
        a3.PlatformStand = false
    end)
    local v15 = a1:Add((Instance.new("ColorCorrectionEffect")))
    v15.Name = "GhostDogPlunge"
    v15.Parent = Lighting
    local v16 = a1:Add((Instance.new("BlurEffect")))
    v16.Name = "GhostDogPlungeBlur"
    v16.Size = 0
    v16.Parent = Lighting
    local u555 = Cine.RestingFov()
    a1:Add(function() -- Line: 343 -- upvalues: CurrentCamera (val), u555 (val)
        CurrentCamera.FieldOfView = u555
    end)
    local v17 = Hud.FadeFrame()
    if v17 then
        v17.BackgroundColor3 = u61
        v17.BackgroundTransparency = 1
    end
    local v18 = Cine.SpeedLens(0.3, 30)
    local Position_2 = CurrentCamera.CFrame.Position
    local v19 = Position_2 + CurrentCamera.CFrame.LookVector * 14
    local v20 = v13 - Unit * 5 + Vector3.new(0, 22, 0)
    local v21 = Position_2 + Vector3.new(0, 9.899999618530273, 0) - Unit * 2
    local v22 = v20 - Unit * 7 + Vector3.new(0, 2, 0)
    local v23 = v20 - Vector3.new(0, 0.5, 0)
    local v24 = v13 + Vector3.new(0, 1.399999976158142, 0) - Unit * 0.6
    local Parent = a2.Parent
    local v25 = a1:Add((Instance.new("Attachment")))
    v25.Parent = a2
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = Fx.Sparkle
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(220, 255, 250))
    ParticleEmitter.LightEmission = 0.5
    ParticleEmitter.Size = NumberSequence.new(0.5, 0.15)
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.1)
    ParticleEmitter.Speed = NumberRange.new(4, 9)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.SpreadAngle = Vector2.new(40, 40)
    ParticleEmitter.Acceleration = Vector3.new(0, 12, 0)
    ParticleEmitter.Rate = 0
    ParticleEmitter.Parent = v25
    v25 = os.clock()
    local v26 = false
    local v27 = false
    local v28 = a4
    while true do
        v1 = os.clock()
        v2 = math.min(v1 - v25, 1.7)
        v3 = v1 - v25
        v1 = math.min(v2 / 1, 1)
        v4 = Fx.Ease(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        if not (v1 < 0.6) then
            v5 = v28:Lerp(v14, (Fx.Ease((v1 - 0.6) / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
        else
            v6 = v1 / 0.6
            v5 = (Position:Lerp(v28, (Fx.Ease(v6, Enum.EasingStyle.Back, Enum.EasingDirection.In)))) + Vector3.new(0, math.sin(v6 * 3.141592653589793) * 4, 0)
        end
        v7 = CFrame.lookAt(v5, v5 + Unit)
        Angles = CFrame.Angles
        v9 = math.rad(-80 * v4)
        v11 = v2 * 15
        v29.CFrame = v7 * Angles(v9, 0, math.sin(v11) * 0.15)
        v29.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        if not v26 and v1 >= 0.6 then
            Fx.Splash(v13, 2.2)
            Fx.Play(GhostDogQuest.Sounds.Splash, {Volume = 1, PlaybackSpeed = 0.75})
            Fx.Shake(1.4, 0.35)
            ParticleEmitter.Rate = 60
            ParticleEmitter:Emit(40)
            Swim.Start(v30, Parent, "Swim")
        end
        v4 = 0
        v1 = 0
        if v2 < 1.05 then
            v8 = v2 / 1.05
            v9 = Fx.Ease(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v10 = 1 - v9
            v6 = Position_2 * (v10 * v10 * v10) + v21 * (v10 * 3 * v10 * v9) + v22 * (v10 * 3 * v9 * v9) + v20 * (v9 * v9 * v9)
            v9 = Fx.Ease(math.min(v8 / 0.3, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v10 = Fx.Ease(math.clamp((v8 - 0.35) / 0.65, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v7 = (v19:Lerp(v5, v9)):Lerp(v13, v10)
        elseif not (v2 < 1.2) then
            v8 = math.min((v2 - 1.05 - 0.15) / 0.5, 1)
            v9 = Fx.Ease(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v6 = v23:Lerp(v24, v9)
            v7 = v13:Lerp(v13 - Vector3.new(0, 2, 0), v9)
            v4 = v9 * 0.14
            v1 = Fx.Ease(math.clamp((v8 - 0.35) / 0.55, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v16.Size = v9 * 10
            v15.TintColor = (Color3.new(1, 1, 1)):Lerp(Color3.fromRGB(120, 210, 255), v1)
        else
            v6 = v20:Lerp(v23, (Fx.Ease((v2 - 1.05) / 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In)))
            v7 = v13
        end
        v6 = Vector3.new(v6.X, math.max(v6.Y, v12 + 1.4), v6.Z)
        CurrentCamera.CFrame = (CFrame.lookAt(v6, v7)) * CFrame.Angles(0, 0, v4)
        CurrentCamera.FieldOfView = v18(v6, v3, u555)
        if v17 then
            v17.BackgroundTransparency = 1 - v1
        end
        if not v27 and v1 >= 0.7 then
            Hud.Bubbles(1.2, 70)
        end
        if v2 >= 1.7 then
            break
        end
        task.wait()
    end
    if v17 then
        v17.BackgroundTransparency = 0
    end
    v2 = CFrame.lookAt(v14, v14 + Unit)
    v29.CFrame = v2 * CFrame.Angles(-1.3962634015954636, 0, 0)
    v29.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
end

return table.freeze(u62)