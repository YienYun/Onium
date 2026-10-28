-- Script path: ReplicatedStorage.Controllers.Game.FishingController.KeyCatch
-- Decompile time: 17.22 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GearToolLookup = require(ReplicatedStorage.Shared.Util.GearToolLookup)
local HalloweenManor = require(ReplicatedStorage.Data.HalloweenManor)
local Line = require(script.Parent.Line)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u58 = Color3.fromRGB(255, 205, 60)
local u63 = Color3.fromRGB(255, 240, 170)
local u68 = CFrame.Angles(0, 1.5707963267948966, -0.3490658503988659)
local v1 = {}

local function reducedMotion() -- Line: 74 -- upvalues: GuiService (val)
    return GuiService.ReducedMotionEnabled
end

local function sound(a1) -- Line: 78 -- upvalues: ReplicatedStorage (val) -- types: a1: table
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v1 = nil
    local v2 = nil
    for i, j in a1, v1, v2 do
        Assets = Assets and Assets:FindFirstChild(j)
    end
    if Assets ~= nil and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function play(a1, a2, a3) -- Line: 86
    -- upvalues: sound (val), Audio (val), SoundService (val)
    local v1 = sound(a1)
    if v1 == nil then
        return
    end
    local v2 = table.clone(a3 or {})
    v2.SoundGroup = v2.SoundGroup or "SFX"
    if a2 ~= nil then
        v2.MaxDistance = v2.MaxDistance or 250
    end
    pcall(Audio.Play, v1, a2 or SoundService, v2)
end

local function effect(a1, a2, ...) -- Line: 99 -- types: a2: string
    if a1 ~= nil and type(a1[a2]) == "function" then
        pcall(a1[a2], ...)
    end
end

local function screen() -- Line: 105 -- upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local GenericRewardScreen2 = PlayerGui and PlayerGui:FindFirstChild("GenericRewardScreen2")
    local v1 = GenericRewardScreen2 and GenericRewardScreen2:FindFirstChild("ShowReward")
    if GenericRewardScreen2 ~= nil
        and GenericRewardScreen2:IsA("ScreenGui")
        and v1 ~= nil
        and v1:IsA("BindableEvent") then
        return GenericRewardScreen2, v1
    end
    return nil, nil
end

local function overlay(a1, a2) -- Line: 115 -- upvalues: LocalPlayer (val) -- types: a2: boolean
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui == nil then
        return nil
    end
    local v1 = a1:Add((Instance.new("ScreenGui")))
    v1.Name = "ManorKeyCatch"
    v1.DisplayOrder = 30
    v1.IgnoreGuiInset = a2
    v1.ResetOnSpawn = false
    v1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v1.Parent = PlayerGui
    return v1
end

local function shield(a1) -- Line: 130 -- types: a1: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "Shield"
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
    TextButton.Position = UDim2.fromScale(0.5, 0.5)
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.AutoButtonColor = false
    TextButton.Selectable = false
    TextButton.Text = ""
    TextButton.Parent = a1
    return TextButton
end

local function keyModel(a1, a2) -- Line: 144
    -- upvalues: GearToolLookup (val), HalloweenManor (val), u58 (val), u63 (val), Workspace (val)
    local v1
    local v2 = GearToolLookup(HalloweenManor.GearId)
    if v2 == nil then
        return nil
    end
    local v3 = a1:Add((Instance.new("Model")))
    v3.Name = "ManorKeyCatch"
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            v1 = j:Clone()
            for k, n in v1:GetChildren() do
                if n:IsA("JointInstance") or n:IsA("WeldConstraint") then
                    n:Destroy()
                end
            end
            v1.Anchored = true
            v1.CanCollide = false
            v1.CanQuery = false
            v1.CanTouch = false
            v1.CastShadow = false
            v1.Parent = v3
        end
    end
    if #v3:GetChildren() == 0 then
        v3:Destroy()
        return nil
    end
    local BoundingBox, BoundingBox_2 = v3:GetBoundingBox()
    v2 = Instance.new("Part")
    v2.Name = "Core"
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Transparency = 1
    v2.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v2.CFrame = CFrame.new(BoundingBox.Position)
    v2.Parent = v3
    v3.PrimaryPart = v2
    v3:ScaleTo(3.4 / (math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z, 0.01)))
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u58
    PointLight.Brightness = 4
    PointLight.Range = 16
    PointLight.Parent = v2
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Trail"
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Color = ColorSequence.new(u63, u58)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Rate = 80
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.7)
    ParticleEmitter.Speed = NumberRange.new(0.5, 2.5)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Drag = 3
    ParticleEmitter.Size = NumberSequence.new(0.7, 0)
    ParticleEmitter.Transparency = NumberSequence.new(0, 1)
    ParticleEmitter.Parent = v2
    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = v3
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = u58
    Highlight.FillTransparency = 0.75
    Highlight.OutlineColor = u63
    Highlight.OutlineTransparency = 0
    Highlight.Parent = v3
    v3:PivotTo((CFrame.new(a2)))
    v3.Parent = Workspace
    return v3
end

local function ease(a1, a2, a3) -- Line: 216 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2, a3)
end

local function yank(a1, a2, a3) -- Line: 220 -- upvalues: Line (val) -- types: a2: userdata?, a3: userdata?
    if a2 == nil then
        return
    end
    a1:Add(a2)
    a1:Add((task.spawn(function() -- Line: 225 -- upvalues: Line (upval), a2 (val), a3 (val)
        Line.Return(a2, a3, 0.25)
        a2:Destroy()
    end)))
end

local function lens(a1) -- Line: 231 -- upvalues: Workspace (val), GuiService (val), TweenService (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and not GuiService.ReducedMotionEnabled then
        local FieldOfView = CurrentCamera.FieldOfView
        local u6 = nil

        local function swap(a1) -- Line: 238 -- upvalues: u6 (ref) -- types: a1: userdata
            if u6 then
                u6:Cancel()
            end
            u6 = a1
            a1:Play()
        end

        a1:Add(function() -- Line: 245 -- upvalues: u6 (ref), CurrentCamera (val), FieldOfView (val)
            if u6 then
                u6:Cancel()
            end
            CurrentCamera.FieldOfView = FieldOfView
        end)
        return function() -- Line: 251 -- upvalues: TweenService (upval), CurrentCamera (val), FieldOfView (val), u6 (ref)
            local v1 = TweenService:Create(
                CurrentCamera,
                TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {FieldOfView = FieldOfView - 7}
            )
            if u6 then
                u6:Cancel()
            end
            u6 = v1
            v1:Play()
        end, function() -- Line: 260 -- upvalues: CurrentCamera (val), FieldOfView (val), TweenService (upval), u6 (ref)
            CurrentCamera.FieldOfView = FieldOfView + 9
            local v1 = TweenService:Create(
                CurrentCamera,
                TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {FieldOfView = FieldOfView}
            )
            if u6 then
                u6:Cancel()
            end
            u6 = v1
            v1:Play()
        end
    end
    return function() end, function() end
end

local function fly(a1, a2) -- Line: 273
    -- upvalues: Workspace (val), GuiService (val), TweenService (val), u68 (val)
    local CFrame_3, Cubic, Out, Position_3, Position_4, v1, v2, v3, v4
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end

    local function target() -- Line: 278 -- upvalues: CurrentCamera (val)
        local CFrame_2 = CurrentCamera.CFrame
        return (CFrame_2 * CFrame.new(0, 0.35, -6.5)).Position, CFrame_2.Position
    end

    local CFrame_2 = CurrentCamera.CFrame
    local Position = (CFrame_2 * (CFrame.new(0, 0.35, -6.5))).Position
    local Position_2 = CFrame_2.Position
    local v5 = (a2:Lerp(Position, 0.5)) + Vector3.new(0, 9, 0)
    local v6 = if not GuiService.ReducedMotionEnabled then 3 else 0
    local v7 = os.clock()
    while a1.Parent ~= nil do
        v2 = math.min((os.clock() - v7) / 0.9, 1)
        Cubic = Enum.EasingStyle.Cubic
        Out = Enum.EasingDirection.Out
        v3 = TweenService:GetValue(math.clamp(v2, 0, 1), Cubic, Out)
        CFrame_3 = CurrentCamera.CFrame
        Position_3 = (CFrame_3 * (CFrame.new(0, 0.35, -6.5))).Position
        Position_4 = CFrame_3.Position
        v4 = (a2:Lerp(v5, v3)):Lerp(v5:Lerp(Position_3, v3), v3)
        v1 = (1 - (1 - v2) ^ 3) * v6 * 2 * 3.141592653589793
        a1:PivotTo((CFrame.lookAt(v4, Position_4)) * CFrame.Angles(0, v1, 0) * u68)
        if v2 >= 1 then
            break
        end
        task.wait()
    end
end

local function arrive(a1) -- Line: 302 -- upvalues: TweenService (val) -- types: a1: userdata
    local Back, Out, v1
    local Scale = a1:GetScale()
    local v2 = os.clock()
    while a1.Parent ~= nil do
        v1 = math.min((os.clock() - v2) / 0.14, 1)
        Back = Enum.EasingStyle.Back
        Out = Enum.EasingDirection.Out
        a1:ScaleTo(Scale * ((TweenService:GetValue(math.clamp(v1, 0, 1), Back, Out)) * 0.25 + 1))
        if v1 >= 1 then
            break
        end
        task.wait()
    end
end

local function waitClosed(a1) -- Line: 316 -- types: a1: userdata
    local v1 = os.clock()
    while not a1.Enabled do
        if a1.Parent == nil or not (os.clock() - v1 < 1) then
            break
        end
        task.wait()
    end
    v1 = os.clock()
    while a1.Enabled do
        if a1.Parent == nil or not (os.clock() - v1 < 15) then
            break
        end
        task.wait(0.1)
    end
end

local function shown(a1) -- Line: 327 -- types: a1: userdata
    local Parent = a1
    while Parent ~= nil do
        if Parent:IsA("LayerCollector") then
            break
        end
        if Parent:IsA("GuiObject") and not Parent.Visible then
            return false
        end
        Parent = Parent.Parent
    end
    local Enabled = false
    if Parent ~= nil then
        Enabled = Parent.Enabled and 0 < v1.AbsoluteSize.X
    end
    return Enabled
end

local function findSlot(a1) -- Line: 338 -- upvalues: LocalPlayer (val), shown (val) -- types: a1: string
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local BackpackGui = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")
    if BackpackGui == nil then
        return nil
    end
    for i, j in BackpackGui:GetDescendants() do
        if j:IsA("ImageLabel") and j.Name == "Icon" and j.Image == a1 and shown(j) then
            return j
        end
    end
    return nil
end

local function stow(a1) -- Line: 357
    -- upvalues: findSlot (val), Trove (val), LocalPlayer (val), GuiService (val), TweenService (val), play (val)
    -- upvalues: u58 (val)
    local v1, v2
    local v3 = nil
    local v4 = os.clock()
    local v5 = a1
    while v3 == nil do
        if not (os.clock() - v4 < 1) then
            break
        end
        v3 = findSlot(v5)
        if v3 == nil then
            task.wait(0.1)
        end
    end
    v4 = v3
    if v4 == nil then
        return
    end
    v3 = v4:FindFirstAncestorWhichIsA("LayerCollector")
    local IgnoreGuiInset = false
    if v3 ~= nil then
        IgnoreGuiInset = v3:IsA("ScreenGui") and v3.IgnoreGuiInset
    end
    v3 = Trove.new()
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui ~= nil then
        v2 = v3:Add((Instance.new("ScreenGui")))
        v2.Name = "ManorKeyCatch"
        v2.DisplayOrder = 30
        v2.IgnoreGuiInset = IgnoreGuiInset
        v2.ResetOnSpawn = false
        v2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        v2.Parent = PlayerGui
        v1 = v2
    else
        v1 = nil
    end
    if v1 == nil then
        v3:Destroy()
        return
    end
    local v6 = Instance.new("ImageLabel")
    v6.Name = "Key"
    v6.AnchorPoint = Vector2.new(0.5, 0.5)
    v6.Position = UDim2.fromScale(0.5, 0.5)
    v6.Size = UDim2.fromScale(0.16, 0.16)
    v6.BackgroundTransparency = 1
    v6.Image = v5
    v6.ZIndex = 2
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.Parent = v6
    v6.Parent = v1
    task.wait()
    local AbsoluteSize = v1.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
        v2 = v4.AbsolutePosition + v4.AbsoluteSize / 2
        local v7 = UDim2.fromScale(v2.X / AbsoluteSize.X, v2.Y / AbsoluteSize.Y)
        v2 = v4.AbsoluteSize.X / AbsoluteSize.X
        local v8 = if not GuiService.ReducedMotionEnabled then 0.55 else 0.275
        v4 = TweenService:Create(
            v6,
            TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Rotation = 0, Position = v7, Size = UDim2.fromScale(v2, v2)}
        )
        v6.Rotation = if not GuiService.ReducedMotionEnabled then -25 else 0
        v4:Play()
        v4.Completed:Wait()
        play({"Sounds", "ScrambleBoss", "Pop"}, nil, {Volume = 0.8, PlaybackSpeed = 1.15})
        v6.Visible = false
        v8 = Instance.new("ImageLabel")
        v8.Name = "Ring"
        v8.AnchorPoint = Vector2.new(0.5, 0.5)
        v8.Position = v7
        v8.Size = UDim2.fromScale(v2, v2)
        v8.BackgroundTransparency = 1
        v8.Image = "rbxassetid://123171646849062"
        v8.ImageColor3 = u58
        local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint_2.AspectRatio = 1
        UIAspectRatioConstraint_2.Parent = v8
        v8.Parent = v1
        v7 = TweenService:Create(
            v8,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageTransparency = 1, Size = UDim2.fromScale(v2 * 2.6, v2 * 2.6)}
        )
        v7:Play()
        v7.Completed:Wait()
        v3:Destroy()
        return
    end
    v3:Destroy()
end

local function run(a1, a2, a3, a4) -- Line: 435
    -- upvalues: LocalPlayer (val), shield (val), Line (val), lens (val), play (val), effect (val), u58 (val)
    -- upvalues: keyModel (val), fly (val), arrive (val), u63 (val), HalloweenManor (val), waitClosed (val)
    local v1, v2
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui ~= nil then
        v2 = a1:Add((Instance.new("ScreenGui")))
        v2.Name = "ManorKeyCatch"
        v2.DisplayOrder = 30
        v2.IgnoreGuiInset = true
        v2.ResetOnSpawn = false
        v2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        v2.Parent = PlayerGui
        v1 = v2
    else
        v1 = nil
    end
    local u26 = if v1 == nil then nil else shield(v1)
    local Fx = a2.Fx
    local Landing = a2.Landing
    local v3 = Landing - Vector3.new(0, 0.5, 0)
    local Bobber = a2.Bobber
    local Tip = a2.Tip
    if Bobber ~= nil then
        a1:Add(Bobber)
        a1:Add((task.spawn(function() -- Line: 225 -- upvalues: Line (upval), Bobber (val), Tip (val)
            Line.Return(Bobber, Tip, 0.25)
            Bobber:Destroy()
        end)))
    end
    local v4, v5 = lens(a1)
    play({"Fishing", "Sounds", "Splash"}, Landing, {Volume = 0.9})
    play({"Sounds", "ScrambleBoss", "Swoosh"}, nil, {Volume = 0.9, PlaybackSpeed = 0.8})
    effect(Fx, "Splash", Landing + Vector3.new(0, 0.30000001192092896, 0), 1.4)
    effect(Fx, "Ring", CFrame.new(Landing + Vector3.new(0, 0.20000000298023224, 0)), u58, 2, 16, 0.6)
    effect(Fx, "Burst", Landing + Vector3.new(0, 1, 0), u58, 40, 24, 0.9)
    effect(Fx, "Shake", 0.35, 0.3)
    v2 = keyModel(a1, v3)
    v4()
    if not v2 then
        task.wait(0.9)
    else
        fly(v2, v3)
        arrive(v2)
        v2:Destroy()
    end
    play({"Sounds", "LightVsDarknessSounds", "CollectSecretRing"}, nil, {Volume = 0.8})
    effect(Fx, "Flash", u63, 0.6, 0.03, 0.45)
    v5()
    local Reward = a2.Reward
    a4:Fire({
        title = HalloweenManor.RewardTitle,
        item = Reward.DisplayName,
        rarity = Reward.Rarity,
        image = Reward.Icon,
    })
    if u26 then
        a1:Add((task.delay(0.7, function() -- Line: 469 -- upvalues: u26 (val)
            u26:Destroy()
        end)))
    end
    waitClosed(a3)
end

function v1.Play(a1) -- Line: 480 -- upvalues: screen (val), Trove (val), run (val) -- types: a1: table
    local v1, v2 = screen()
    if v1 ~= nil and v2 ~= nil then
        local v3 = Trove.new()
        local success, err = pcall(run, v3, a1, v1, v2)
        v3:Destroy()
        if not success then
            warn((("[Fishing] Manor Key catch stopped early: %*"):format(err)))
        end
        return true
    end
    return false
end

function v1.Stow(a1) -- Line: 494 -- upvalues: stow (val) -- types: a1: string?
    if type(a1) == "string" and a1 ~= "" then
        task.spawn(stow, a1)
        return
    end
end

return table.freeze(v1)