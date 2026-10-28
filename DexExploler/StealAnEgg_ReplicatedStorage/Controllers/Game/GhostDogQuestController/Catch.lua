-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Catch
-- Decompile time: 32.58 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Cast = require(script.Parent.Cast)
local Cine = require(script.Parent.Cine)
local GhostDogQuestFlags = require(ReplicatedStorage.Shared.Flags.GhostDogQuestFlags)
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Hud = require(script.Parent.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Swim = require(script.Parent.Swim)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local GhostDogQuest_2 = ReplicatedStorage.Assets.GhostDogQuest
local Sounds = ReplicatedStorage.Assets.Sounds
local u67 = CFrame.new(0, 0.25, -2.2)
local u78 = (CFrame.Angles(0, 1.5707963267948966, 0)) * CFrame.Angles(0, 0, -0.20943951023931956)
local u79 = {"MouthCore", "MouthGlow", "EyeGlow"}
local u87 = Color3.fromRGB(255, 214, 120)
local u92 = Color3.fromRGB(220, 255, 250)
local u97 = Color3.fromRGB(170, 235, 245)
local Swoosh = Sounds.ScrambleBoss.Swoosh
local Pop = Sounds.ScrambleBoss.Pop
local HeavyLand = Sounds.ScrambleBoss.HeavyLand
local CollectSecretRing = Sounds.LightVsDarknessSounds.CollectSecretRing
local SlideLoop = Sounds.BeanstalkEvent.SlideLoop
local SlideHit = Sounds.BeanstalkEvent.SlideHit
local v1 = {}

local function run(a1, a2) -- Line: 72 -- types: a1: number, a2: function
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

local function puppet(a1, a2, a3) -- Line: 87 -- types: a2: userdata, a3: string
    local CFrame = a2.CFrame
    local u4 = true
    a1:BindToRenderStep(a3, Enum.RenderPriority.Character.Value, function() -- Line: 90 -- upvalues: u4 (ref), a2 (val), CFrame (ref)
        if u4 then
            a2.CFrame = CFrame
            a2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            a2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end)
    a1:Add(function() -- Line: 97 -- upvalues: u4 (ref)
        u4 = false
    end)
    return {
        Set = function(a1) -- Line: 101 -- upvalues: CFrame (ref), u4 (ref), a2 (val) -- types: a1: userdata
            CFrame = a1
            if u4 then
                a2.CFrame = a1
            end
        end,
        Get = function() -- Line: 107 -- upvalues: CFrame (ref)
            return CFrame
        end,
        Stop = function() -- Line: 110 -- upvalues: u4 (ref)
            u4 = false
        end,
    }
end

local function hold(a1, a2, a3, a4) -- Line: 116
    -- upvalues: u67 (val), u78 (val)
    local u4 = {Holding = false, Fish = a3}
    u4.Center = ((a3:GetPivot()):PointToObjectSpace((a3:GetBoundingBox()).Position)) / a3:GetScale()
    u4.Scale = a3:GetScale()
    a1:BindToRenderStep(a4, Enum.RenderPriority.Character.Value + 1, function() -- Line: 124 -- upvalues: u4 (val), a3 (val), a2 (val), u67 (upval), u78 (upval)
        if u4.Holding and a3.Parent ~= nil then
            a3:PivotTo(a2.CFrame * u67 * u78 * (CFrame.new(-u4.Center * u4.Scale)))
        end
    end)
    return u4
end

local function fishTracks(a1) -- Line: 134 -- types: a1: userdata
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    if Animator == nil then
        return {}
    end
    return Animator:GetPlayingAnimationTracks()
end

local function playFish(a1, a2, a3, a4) -- Line: 143 -- types: a1: userdata, a2: string, a3: boolean, a4: number?
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
    local v1 = a1:FindFirstChild("Animations")
    local v2 = v1 and v1:FindFirstChild(a2)
    if Animator ~= nil and v2 ~= nil and v2:IsA("Animation") then
        v1 = Animator:LoadAnimation(v2)
        v1.Looped = a3
        v1:Play(0.15, 1, a4 or 1)
        return v1
    end
    return nil
end

local function glowParts(a1) -- Line: 157 -- upvalues: u79 (val) -- types: a1: userdata
    local v1
    local v2 = {}
    for i, j in u79 do
        v1 = a1:FindFirstChild(j, true)
        if v1 and v1:IsA("BasePart") then
            v2[v1] = v1.Transparency
        end
    end
    return v2
end

local function flicker(a1, a2) -- Line: 168 -- types: a1: table, a2: number
    local v1, v2
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        v1 = if not (math.random() < a2) then 0 else 0.55 + math.random() * 0.4
        v2 = j + v1
        i.Transparency = math.clamp(v2, 0, 1)
    end
end

local function exclaim(a1, a2) -- Line: 175 -- upvalues: LocalPlayer (val), Fx (val) -- types: a2: userdata
    local Head = a2:FindFirstChild("Head")
    if Head ~= nil and Head:IsA("BasePart") then
        local u15 = a1:Add((Instance.new("BillboardGui")))
        u15.Size = UDim2.fromScale(3, 3)
        u15.StudsOffsetWorldSpace = Vector3.new(0, 3.200000047683716, 0)
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
        task.delay(0.9, function() -- Line: 200 -- upvalues: u15 (val)
            if u15.Parent ~= nil then
                u15:Destroy()
            end
        end)
        return
    end
end

local function banner(a1, a2, a3, a4) -- Line: 207 -- upvalues: Fx (val) -- types: a2: string, a3: string?, a4: number
    local Banner = a1.Chase.Banner
    Banner.Text = a2
    Banner.TextTransparency = 0
    local UIStroke = Banner:FindFirstChildOfClass("UIStroke")
    if UIStroke then
        UIStroke.Transparency = 0
    end
    local UIScale = Banner:FindFirstChildOfClass("UIScale")
    if UIScale then
        Fx.Punch(UIScale, 1.6, 0.35)
    end
    a1.Chase.Sub.Text = a3 or ""
    task.delay(a4, function() -- Line: 220 -- upvalues: Banner (val), a2 (val), Fx (upval), UIStroke (val), a1 (val)
        if Banner.Text == a2 then
            Fx.Tween(Banner, 0.3, {TextTransparency = 1})
            if UIStroke then
                Fx.Tween(UIStroke, 0.3, {Transparency = 1})
            end
            a1.Chase.Sub.Text = ""
        end
    end)
end

local function invoke(a1, a2) -- Line: 231 -- types: a2: number
    local err, success
    for i = 1, a2 do
        success, err = pcall(function() -- Line: 233 -- upvalues: a1 (val)
            return a1:InvokeServer()
        end)
        if success and err == true then
            return true
        end
        task.wait(0.6)
    end
    return false
end

local function flat(a1, a2) -- Line: 244 -- types: a1: vector, a2: vector
    local v1 = a1 * Vector3.new(1, 0, 1)
    if 0.05 < v1.Magnitude then
        return v1.Unit
    end
    return a2
end

function v1:Play(a2, a3, a4, a5) -- Line: 249
    -- upvalues: LocalPlayer (val), Hud (val), puppet (val), hold (val), Cine (val), GhostDogQuestFlags (val)
    -- upvalues: GhostDogQuest (val), glowParts (val), fishTracks (val), Fx (val), run (val), flicker (val), u92 (val)
    -- upvalues: banner (val), playFish (val), exclaim (val), Swoosh (val), u67 (val), Pop (val)
    -- upvalues: CollectSecretRing (val), invoke (val), Remotes (val), Workspace (val), SlideLoop (val), u97 (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local u14 = Hud.Get()
    if Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and u14 ~= nil then
        local v1 = self:Extend()
        local u29 = puppet(v1, HumanoidRootPart, "GhostFishCatchPuppet")
        local u36 = hold(v1, HumanoidRootPart, a3, "GhostFishCatchHold")
        local u40 = Cine.Take(v1)
        local Progress = u14.Chase.Progress
        Progress.Visible = false
        v1:Add(function() -- Line: 268 -- upvalues: Progress (val)
            Progress.Visible = true
        end)
        local u58 = (GhostDogQuestFlags.FishChaseSeconds:Get()) * GhostDogQuestFlags.ChaseSpeed:Get()
        local v2 = u29.Get()
        local X = (GhostDogQuest.ChaseFrame(a2, u58)):ToObjectSpace(v2).Position.X
        local v3 = a3:GetPivot()
        local X_2 = (GhostDogQuest.ChaseFrame(a2, u58 + 30)):ToObjectSpace(v3).Position.X
        local u91 = glowParts(a3)
        for i, j in fishTracks(a3) do
            j:AdjustSpeed(0.9)
        end
        Fx.Play(GhostDogQuest.Sounds.GrowlLong, {Volume = 0.55, PlaybackSpeed = 0.7})
        local CFrame_2 = u40.CFrame
        local FieldOfView = u40.FieldOfView
        local u116 = Cine.RestingFov()
        local u117 = 0
        local u118 = false
        local u120 = v2
        local u122 = v3
        run(1.6, function(a1) -- Line: 290
            -- upvalues: Fx (upval), GhostDogQuest (upval), a2 (val), u58 (val), u120 (ref), X (val), u29 (val)
            -- upvalues: X_2 (val), u122 (ref), a3 (val), flicker (upval), u91 (val), fishTracks (upval), a4 (val)
            -- upvalues: u117 (ref), u92 (upval), u118 (ref), banner (upval), u14 (val), u40 (val), CFrame_2 (val)
            -- upvalues: FieldOfView (val), u116 (val)
            local v1
            local v2 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v3 = os.clock()
            local v4 = GhostDogQuest.ChaseFrame(a2, u58 + 26 * v2)
            local v5 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            u120 = v4 * CFrame.new(X, math.sin(v3 * 2.4) * 0.3, 0) * CFrame.Angles(-1.2566370614359172 * (1 - v5), 0, 0)
            u29.Set(u120)
            local v6 = GhostDogQuest.ChaseFrame(a2, u58 + 30 + 17 * v2)
            v2 = X_2 + (X - X_2) * v5
            v5 = (math.sin(v3 * 7)) * 0.28 * a1
            u122 = v6 * CFrame.new(v2, (math.sin(v3 * 3)) * (a1 + 0.6) + -8.5, 0) * CFrame.Angles(math.sin(v3 * 4.5) * 0.08 * a1, 0, v5)
            a3:PivotTo(u122)
            flicker(u91, a1 * 0.45 + 0.15)
            for i, j in fishTracks(a3) do
                v1 = 1.4 - a1 * 1.05
                j:AdjustSpeed(v1)
            end
            if a4 then
                a4.CurveSize0 = a1 * 3 + 0.5
                a4.CurveSize1 = -(a1 * 2 + 0.5)
            end
            if u117 <= v3 then
                u117 = v3 + 0.3
                local MouthGlow = a3:FindFirstChild("MouthGlow", true)
                if MouthGlow and MouthGlow:IsA("BasePart") then
                    Fx.Burst(MouthGlow.Position, u92, 5, 6, 0.45)
                end
            end
            if not u118 and a1 >= 0.45 then
                u118 = true
                banner(u14, "IT'S WORN OUT!", "Grab it!", 1.6)
            end
            v5 = u120.Position:Lerp((u122 * (CFrame.new(0, 8.5, 0))).Position, 0.5)
            v2 = v5 + v4.RightVector * 17 + v4.UpVector * 4 - v4.LookVector * 3
            v4 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            u40.CFrame = CFrame_2:Lerp(CFrame.lookAt(v2, v5), v4)
            u40.FieldOfView = FieldOfView + (u116 - FieldOfView) * v4
        end)
        if not a5() then
            return false
        end
        local Position = (u122 * CFrame.new(u36.Center * u36.Scale)).Position
        local v4 = u120.Position - Position
        local v5 = -u120.LookVector
        local v6 = v4 * Vector3.new(1, 0, 1)
        local Unit_2 = if not (0.05 < v6.Magnitude) then v5 else v6.Unit
        local Rotation = u122.Rotation
        local Rotation_2 = CFrame.lookAt(Position, Position + Unit_2).Rotation
        local u176 = CFrame.lookAt(u120.Position, (Vector3.new(Position.X, u120.Position.Y, Position.Z)))
        local u177 = u120
        local u186 = u176.Position - u176.LookVector * 7 + u176.RightVector * 3 + Vector3.new(0, 2.5, 0)
        local CFrame_3 = u40.CFrame
        Fx.Play(GhostDogQuest.Sounds.FishTurn, {Volume = 0.8, PlaybackSpeed = 0.85})
        playFish(a3, "GhostFish_Idle", true, 0.5)
        run(0.75, function(a1) -- Line: 349
            -- upvalues: Fx (upval), a3 (val), Position (val), Rotation (val), Rotation_2 (val), u36 (val)
            -- upvalues: flicker (upval), u91 (val), u29 (val), u177 (val), u176 (val), u40 (val), CFrame_3 (val)
            -- upvalues: u186 (val)
            local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local v2 = os.clock()
            a3:PivotTo((CFrame.new(Position + Vector3.new(0, math.sin(v2 * 3) * 0.6, 0))) * Rotation:Lerp(Rotation_2, v1) * CFrame.Angles(0, 0, math.sin(v2 * 7) * 0.2) * (CFrame.new(-u36.Center * u36.Scale)))
            flicker(u91, 0.55)
            u29.Set(u177:Lerp(u176, v1))
            u40.CFrame = CFrame_3:Lerp(CFrame.lookAt(u186, Position), (Fx.Ease(a1, Enum.EasingStyle.Sine)))
        end)
        exclaim(v1, Character)
        Fx.Play(GhostDogQuest.Sounds.GrowlShort, {Volume = 0.6, PlaybackSpeed = 0.8})
        Fx.Shake(0.8, 0.2)
        task.wait(0.3)
        if not a5() then
            return false
        end
        local v7 = Position + Unit_2 * 2.6
        local u247 = CFrame.lookAt(v7, (Vector3.new(Position.X, v7.Y, Position.Z)))
        local CFrame_4 = u40.CFrame
        local u256 = v7 - u176.LookVector * 6 + u176.RightVector * 2.2 + Vector3.new(0, 1.600000023841858, 0)
        local Scale = u36.Scale
        Fx.Play(Swoosh, {Volume = 0.9, PlaybackSpeed = 1.1})
        Fx.Shake(1.2, 0.3)
        run(0.45, function(a1) -- Line: 382
            -- upvalues: Fx (upval), u29 (val), u176 (val), u247 (val), Scale (val), a3 (val), u36 (val), Position (val)
            -- upvalues: Rotation_2 (val), u40 (val), CFrame_4 (val), u256 (val), u116 (val)
            local v1 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v2 = math.sin(a1 * 3.141592653589793)
            u29.Set((u176:Lerp(u247, v1)) * CFrame.Angles(v2 * -0.4886921905584123, 0, 0))
            v2 = Fx.Ease(math.clamp((a1 - 0.35) / 0.65, 0, 1), Enum.EasingStyle.Back)
            local v3 = Scale + (0.22 - Scale) * v2
            if 0.001 < (math.abs((a3:GetScale()) - v3)) then
                a3:ScaleTo((math.max(v3, 0.05)))
            end
            u36.Scale = a3:GetScale()
            a3:PivotTo((CFrame.new(Position)) * Rotation_2 * (CFrame.new(-u36.Center * u36.Scale)))
            u40.CFrame = CFrame_4:Lerp(CFrame.lookAt(u256, Position), v1)
            u40.FieldOfView = u116 - 18 * v1
        end)
        a3:ScaleTo(0.22)
        u36.Scale = a3:GetScale()
        u36.Holding = true
        u29.Set(u247)
        for k in u91 do
            k.Transparency = u91[k]
        end
        local Position_4 = (HumanoidRootPart.CFrame * u67).Position
        Fx.Flash(Color3.new(1, 1, 1), 0.7, 0.02, 0.45)
        Fx.Burst(Position_4, u92, 40, 26, 1.3)
        Fx.Burst(Position_4, Fx.Ghost, 28, 18, 1)
        Fx.Ring((CFrame.new(Position_4)) * CFrame.Angles(0, 0, 1.5707963267948966), Fx.Ghost, 2, 18, 0.45)
        Fx.Shake(2.4, 0.4)
        Fx.Play(Pop, {Volume = 1})
        Fx.Play(CollectSecretRing, {Volume = 0.8})
        Hud.Bubbles(1, 40)
        playFish(a3, "GhostFish_Thrash", false, 1.6)
        banner(u14, "CAUGHT!", "Ghost Fish", 1.4)
        local u377 = false
        local u380 = task.spawn(function() -- Line: 415 -- upvalues: u377 (ref), invoke (upval), Remotes (upval)
            invoke(Remotes.GhostDogQuest.Claim, 4)
        end)
        v1:Add(function() -- Line: 418 -- upvalues: u380 (val)
            if coroutine.status(u380) == "suspended" then
                task.cancel(u380)
            end
        end)
        Cine.Blend(CFrame.lookAt(
            u247.Position + u247.LookVector * 6.5 + u247.RightVector * 2 + Vector3.new(0, 1.399999976158142, 0),
            Position_4 + Vector3.new(0, 0.6000000238418579, 0)
        ), 0.25, u116 - 14)
        task.wait(0.8)
        if not a5() then
            return false
        end
        local Attachment0 = if not a4 then nil else a4.Attachment0
        local u424 = v1:Add((Instance.new("Part")))
        u424.Name = "GhostFishHaulAnchor"
        u424.Anchored = true
        u424.CanCollide = false
        u424.CanQuery = false
        u424.CanTouch = false
        u424.Transparency = 1
        u424.Size = Vector3.new(1, 1, 1)
        u424.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 140, 0))
        u424.Parent = Workspace
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = u424
        if a4 and Attachment0 then
            a4.Attachment1 = Attachment
            a4.CurveSize0 = 0
            a4.CurveSize1 = 0
            a4.Width0 = 0.2
            a4.Width1 = 0.2
            a4.Color = ColorSequence.new(Color3.new(1, 1, 1), Fx.Ghost)
        end
        local LineTug = GhostDogQuest.Sounds.LineTug
        Fx.Play(LineTug[#LineTug], {Volume = 0.9})
        Fx.Shake(1.6, 0.25)
        local v8 = v1:Add((Instance.new("Attachment")))
        v8.Parent = HumanoidRootPart
        local v9 = Instance.new("ParticleEmitter")
        v9.Texture = Fx.Sparkle
        v9.Color = ColorSequence.new(u92)
        v9.LightEmission = 0.5
        v9.Size = NumberSequence.new(0.5, 0.1)
        v9.Lifetime = NumberRange.new(0.5, 1)
        v9.Speed = NumberRange.new(2, 6)
        v9.SpreadAngle = Vector2.new(60, 60)
        v9.EmissionDirection = Enum.NormalId.Bottom
        v9.Rate = 70
        v9.Parent = v8
        v8 = Fx.Play(SlideLoop, {Volume = 0.7, Looped = true, PlaybackSpeed = 1.8})
        if v8 then
            v1:Add(v8)
        end
        Fx.Play(GhostDogQuest.Sounds.Surfaced, {Volume = 0.6})
        Hud.Bubbles(1.5, 80)
        local u531 = Hud.FadeFrame()
        if u531 then
            u531.BackgroundColor3 = u97
            u531.BackgroundTransparency = 1
        end
        local v10 = u247.LookVector * Vector3.new(1, 0, 1)
        local Unit = if not (0.05 < v10.Magnitude) then Vector3.new(0, 0, 1) else v10.Unit
        local u549 = Unit:Cross((Vector3.new(0, 1, 0)))
        local u554 = Cine.SpeedLens(0.2, 26)
        local CFrame_5 = u40.CFrame
        run(1.5, function(a1, a2) -- Line: 485
            -- upvalues: Fx (upval), u247 (val), u29 (val), Unit (val), u424 (val), u549 (val), u40 (val)
            -- upvalues: CFrame_5 (val), u554 (val), u116 (val), u531 (val)
            local v1 = Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local v2 = os.clock()
            local v3 = u247.Position + Vector3.new(0, 75 * v1, 0)
            u29.Set((CFrame.lookAt(v3, v3 + Unit)) * CFrame.Angles(0.17453292519943295 * v1, 0, math.sin(v2 * 9) * 0.08 * (1 - v1)))
            u424.CFrame = CFrame.new(v3 + Vector3.new(0, 140, 0))
            v2 = v3 - Vector3.new(0, 9 + 4 * v1, 0) + u549 * 7 - Unit * 5
            u40.CFrame = CFrame_5:Lerp(CFrame.lookAt(v2, v3 + Vector3.new(0, 3, 0)), (math.min(a1 * 3, 1)))
            u40.FieldOfView = u554(v2, a2, u116 - 6)
            if u531 then
                u531.BackgroundTransparency = 1 - Fx.Ease(math.clamp((a1 - 0.6) / 0.4, 0, 1), Enum.EasingStyle.Sine)
            end
        end)
        if u531 then
            u531.BackgroundTransparency = 0
        end
        v9.Rate = 0
        if v8 then
            v8:Destroy()
        end
        u36.Holding = false
        u29.Stop()
        while coroutine.status(u380) ~= "dead" do
            if not a5() then
                break
            end
            task.wait()
        end
        if u377 and a5() then
            return (invoke(Remotes.GhostDogQuest.Surface, 3))
        end
        return false
    end
    return false
end

function v1.Breach(a1, a2, a3, a4) -- Line: 523
    -- upvalues: LocalPlayer (val), Hud (val), Cast (val), Cine (val), puppet (val), GhostDogQuest_2 (val)
    -- upvalues: Workspace (val), hold (val), playFish (val), Swim (val), Fx (val), SlideLoop (val), run (val)
    -- upvalues: u92 (val), GhostDogQuest (val), Swoosh (val), SlideHit (val), HeavyLand (val), u67 (val), u87 (val)
    -- upvalues: CollectSecretRing (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local v1 = Hud.FadeFrame()
    if Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and Humanoid ~= nil then
        local v2 = os.clock()
        while 25 < (HumanoidRootPart.Position - a3.Position).Magnitude do
            if not (os.clock() - v2 < 6) or not a4() then
                break
            end
            task.wait()
        end
        if not (25 < (HumanoidRootPart.Position - a3.Position).Magnitude) and a4() then
            v2 = a1:Extend()
            Cast.LockControls(v2)
            local u75 = Cine.Take(a1)
            a1:Add(function() -- Line: 545 -- upvalues: u75 (val), LocalPlayer (upval)
                if u75.CameraType == Enum.CameraType.Scriptable then
                    local Character = LocalPlayer.Character
                    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                    u75.CameraType = Enum.CameraType.Custom
                    if Humanoid then
                        u75.CameraSubject = Humanoid
                    end
                end
            end)
            Humanoid.PlatformStand = true
            a1:Add(function() -- Line: 556 -- upvalues: Humanoid (val)
                Humanoid.PlatformStand = false
            end)
            local u89 = Cine.RestingFov()
            local u100 = Vector3.new(a2.X, a2.Y + 0.3, a2.Z)
            local v3 = a3.Position - u100
            local v4 = -a3.LookVector
            local v5 = v3 * Vector3.new(1, 0, 1)
            local Unit = if not (0.05 < v5.Magnitude) then v4 else v5.Unit
            local Unit_2 = Vector3.new(0, 1, 0):Cross(Unit).Unit
            local u125 = CFrame.lookAt(u100 - Vector3.new(0, 7, 0), u100 - Vector3.new(0, 7, 0) + Unit)
            local u127 = u125 + Vector3.new(0, 5.400000095367432, 0)
            local u134 = puppet(a1, HumanoidRootPart, "GhostFishBreachPuppet")
            u134.Set(u125)
            local v6 = a1:Clone(GhostDogQuest_2.GhostFish)
            v6:ScaleTo(0.22)
            v6.Parent = Workspace
            local v7 = hold(a1, HumanoidRootPart, v6, "GhostFishBreachHold")
            v7.Holding = true
            playFish(v6, "GhostFish_Idle", true, 0.8)
            local v8 = Swim.Start(a1, Character, "Swim")
            local v9 = Cine.Unclip((u100:Lerp(a3.Position, 0.5)) + Vector3.new(0, 2, 0), u100 - Unit * 9 + Unit_2 * 9 + Vector3.new(0, 6, 0))
            local u193 = u100 - Unit * 6 + Unit_2 * 4 + Vector3.new(0, 3.5, 0)
            Cine.Cut(CFrame.lookAt(u193, u100), u89)
            if v1 then
                Fx.Tween(v1, 0.35, {BackgroundTransparency = 1})
            end
            v3 = Fx.Play(SlideLoop, {Volume = 0.6, Looped = true, PlaybackSpeed = 2})
            if v3 then
                a1:Add(v3)
            end
            run(0.55, function(a1) -- Line: 590
                -- upvalues: Fx (upval), u134 (val), u125 (val), u127 (val), u100 (val), u75 (val), u193 (val)
                u134.Set((u125:Lerp(u127, (Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))) * CFrame.Angles(0, 0, math.sin(a1 * 30) * 0.1))
                if math.random() < 0.35 then
                    Fx.Ripple(u100, a1 + 0.6)
                end
                u75.CFrame = (CFrame.lookAt(u193, u100)) * CFrame.Angles(0, 0, math.noise(os.clock() * 12, 3) * 0.02)
            end)
            if v3 then
                v3:Destroy()
            end
            Fx.Splash(u100, 2.6)
            Fx.Burst(u100 + Vector3.new(0, 1, 0), u92, 30, 22, 0.9)
            Fx.Play(GhostDogQuest.Sounds.Splash, {Volume = 1, PlaybackSpeed = 0.9})
            Fx.Play(Swoosh, {Volume = 0.8, PlaybackSpeed = 0.95})
            Fx.Shake(1.8, 0.35)
            if v8 then
                v8.Set("Swim", 2)
            end
            local u285 = u100 + Vector3.new(0, 1, 0)
            local Position = a3.Position
            local u298 = math.clamp((Position - u285).Magnitude * 0.3, 5, 11)
            local u310 = v9 + Unit * 2 + Vector3.new(0, 1.5, 0)
            local u316 = Cine.SpeedLens(0.3, 20)
            run(1, function(a1, a2) -- Line: 615
                -- upvalues: Fx (upval), u285 (val), Position (val), u298 (val), u134 (val), u127 (val), a3 (val)
                -- upvalues: u193 (val), u310 (val), u75 (val), u100 (val), u316 (val), u89 (val)
                local v1 = Fx.Ease(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                local v2 = (u285:Lerp(Position, v1)) + Vector3.new(0, (math.sin(a1 * 3.141592653589793)) * u298, 0)
                local v3 = CFrame.Angles(0, 6.283185307179586 * Fx.Ease(a1, Enum.EasingStyle.Quad), 0)
                u134.Set((CFrame.new(v2)) * u127.Rotation:Lerp(a3.Rotation, v1) * v3)
                v3 = u193:Lerp(u310, (Fx.Ease(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
                u75.CFrame = CFrame.lookAt(v3, u100:Lerp(v2, 0.7))
                u75.FieldOfView = u316(v3, a2, u89)
            end)
            u134.Set(a3)
            Swim.Stop()
            local v10 = Humanoid.HipHeight + HumanoidRootPart.Size.Y * 0.5
            Fx.Play(SlideHit, {Volume = 0.6})
            Fx.Play(HeavyLand, {Volume = 0.3, PlaybackSpeed = 1.3})
            Fx.Shake(0.8, 0.25)
            Fx.Burst(Position - Vector3.new(0, v10, 0), u92, 14, 8, 0.6)
            local Position_3 = (a3 * u67).Position
            Cine.Blend(CFrame.lookAt(
                Cine.Unclip(Position_3, a3.Position + a3.LookVector * 8 + a3.RightVector * 2.5 + Vector3.new(0, 1.7999999523162842, 0)),
                Position_3 + Vector3.new(0, 0.800000011920929, 0)
            ), 0.4, u89 - 10)
            playFish(v6, "GhostFish_Thrash", false, 1.4)
            task.wait(0.6)
            v7.Holding = false
            Fx.Burst(Position_3, Fx.Ghost, 30, 16, 1.1)
            Fx.Burst(Position_3, u87, 18, 12, 0.8)
            Fx.Play(CollectSecretRing, {Volume = 0.7, PlaybackSpeed = 1.1})
            v6:Destroy()
            u134.Stop()
            HumanoidRootPart.CFrame = a3
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            Humanoid.PlatformStand = false
            if not a4() then
                return
            end
            Cine.Release(Humanoid, HumanoidRootPart)
            v2:Clean()
            return
        end
        return
    end
end

return table.freeze(v1)