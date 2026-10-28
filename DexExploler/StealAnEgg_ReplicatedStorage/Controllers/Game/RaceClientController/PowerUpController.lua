-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.PowerUpController
-- Decompile time: 65.84 ms

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
require(script.Parent.MountController)
require(ReplicatedStorage.Data.MountRace)
local PowerUpVisuals = require(script.Parent.PowerUpVisuals)
require(script.Parent.RaceCamera)
local RacePowerUps = require(ReplicatedStorage.Data.RacePowerUps)
require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Attributes = RacePowerUps.Attributes
local Tuning = RacePowerUps.Tuning
local Items = RacePowerUps.Items
local u92 = UDim2.fromScale(0.5, 0.4)
local u96 = UDim2.fromScale(0.915, 0.6)
local u100 = Vector2.new(0.86, 0.16)
local u105 = Color3.fromRGB(120, 120, 135)
local u106 = {}
u106.Spike = {"BONK!", Color3.fromRGB(255, 170, 70)}
u106.Pod = {"KABOOM!", Color3.fromRGB(255, 80, 70)}
u106.Drilla = {"AMBUSHED!", Color3.fromRGB(255, 205, 70)}
u106.Egg = {"SPLAT!", Color3.fromRGB(255, 225, 60)}
u106.Kraken = {"SMASHED!", Color3.fromRGB(255, 80, 70)}
local v1 = {}

local function now() -- Line: 47 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function tween(a1, a2, a3, a4, a5) -- Line: 51
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quad, a5 or Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

local function flatten(a1, a2) -- Line: 67 -- types: a1: vector, a2: vector
    local v1 = a1 - a2 * a1:Dot(a2)
    if 0.001 < v1.Magnitude then
        return v1.Unit
    end
    return (Vector3.new(0, 0, 1))
end

local function bezier(a1, a2, a3, a4) -- Line: 72 -- types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local v1 = 1 - a4
    return a1 * v1 * v1 + a2 * 2 * v1 * a4 + a3 * a4 * a4
end

local function shuffled() -- Line: 77 -- upvalues: RacePowerUps (val)
    local v1, v2, v3
    local v4 = table.clone(RacePowerUps.Order)
    for i = #v4, 2, -1 do
        v1 = math.random(1, i)
        v2 = v4[v1]
        v3 = v4[i]
        v4[i] = v2
        v4[v1] = v3
    end
    return v4
end

function v1.Run(a1, a2, a3, a4, a5) -- Line: 86
    -- upvalues: LocalPlayer (val), PowerUpVisuals (val), Workspace (val), GuiService (val), UserInputService (val)
    -- upvalues: Attributes (val), TweenService (val), RacePowerUps (val), InputIconsConfig (val), Items (val)
    -- upvalues: u92 (val), u96 (val), u100 (val), RunService (val), shuffled (val), Remotes (val)
    -- upvalues: ContextActionService (val), MountRaceFlags (val), Tuning (val), u106 (val), u105 (val)
    local RacePowerUpUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("RacePowerUpUI")
    local v1 = PowerUpVisuals.Run(a1, a2, a5)
    local Root = a3.Rig.Root
    local Vignette = RacePowerUpUI.Vignette
    local Tint = RacePowerUpUI.Tint
    local Flash = RacePowerUpUI.Flash

    local function coverScreen() -- Line: 102
        -- upvalues: Workspace (upval), RacePowerUpUI (val), GuiService (upval), Vignette (val), Tint (val), Flash (val)
        local CurrentCamera = Workspace.CurrentCamera
        local AbsoluteSize = RacePowerUpUI.AbsoluteSize
        if CurrentCamera ~= nil and not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
            local fromScale, fromScale_2, v1, v2
            local ViewportSize = CurrentCamera.ViewportSize
            local AbsolutePosition = RacePowerUpUI.AbsolutePosition
            local GuiInset = GuiService:GetGuiInset()
            for i, j in {Vignette, Tint, Flash} do
                j.AnchorPoint = Vector2.zero
                fromScale = UDim2.fromScale
                v1 = (-GuiInset.X - AbsolutePosition.X) / AbsoluteSize.X
                v2 = -GuiInset.Y - AbsolutePosition.Y
                j.Position = fromScale(v1, v2 / AbsoluteSize.Y)
                fromScale_2 = UDim2.fromScale
                v1 = ViewportSize.X / AbsoluteSize.X
                j.Size = fromScale_2(v1, ViewportSize.Y / AbsoluteSize.Y)
            end
            return
        end
    end

    coverScreen()
    a1:Connect(RacePowerUpUI:GetPropertyChangedSignal("AbsoluteSize"), coverScreen)
    a1:Connect(RacePowerUpUI:GetPropertyChangedSignal("AbsolutePosition"), coverScreen)
    local Roll = RacePowerUpUI.Roll
    local Pop = Roll.Pop
    local Rays = Roll.Rays
    local Ring = Roll.Ring
    local Sparkle = Roll.Sparkle
    local Title = Roll.Title
    local UIStroke = Title:FindFirstChildOfClass("UIStroke")
    local Icon = Roll.Window.Icon
    local Next = Roll.Window.Next
    local Slot = RacePowerUpUI.Slot
    local Pop_2 = Slot.Pop
    local Glow = Slot.Glow
    local Icon_2 = Slot.Icon
    local Count = Slot.Count
    local KeyHint = Slot.KeyHint
    local Key = Slot.KeyHint.Key
    local UIStroke_2 = Slot.KeyHint.UIStroke
    local ConsoleIcon = Slot.KeyHint.ConsoleIcon
    local Tap = Slot.Tap
    local Effect = RacePowerUpUI.Effect
    local Pop_3 = Effect.Pop
    local Icon_3 = Effect.Icon
    local Fill = Effect.Bar.Fill
    local Time = Effect.Time
    local Fly = RacePowerUpUI.Fly
    local Trail = Fly.Trail
    local Banner = RacePowerUpUI.Banner
    local Pop_4 = Banner.Pop
    local UIStroke_3 = Banner:FindFirstChildOfClass("UIStroke")
    Vignette.GroupTransparency = 1
    Tint.GroupTransparency = 1
    Flash.BackgroundTransparency = 1
    Roll.Visible = false
    Slot.Visible = false
    Effect.Visible = false
    Fly.Visible = false
    Banner.TextTransparency = 1
    UIStroke_3.Transparency = 1
    a1:Add(function() -- Line: 154
        -- upvalues: Vignette (val), Tint (val), Flash (val), Roll (val), Slot (val), Effect (val), Fly (val)
        -- upvalues: Banner (val), UIStroke_3 (val)
        Vignette.GroupTransparency = 1
        Tint.GroupTransparency = 1
        Flash.BackgroundTransparency = 1
        Roll.Visible = false
        Slot.Visible = false
        Effect.Visible = false
        Fly.Visible = false
        Banner.TextTransparency = 1
        UIStroke_3.Transparency = 1
    end)
    local u99 = {
        RollToken = 0,
        RollKey = "",
        Rolling = false,
        Rainbow = false,
        Flying = false,
        EffectEndsAt = 0,
        EffectSeconds = 1,
        Stunned = false,
        TintFloor = 1,
        Warning = 0,
        BannerToken = 0,
    }
    u99.Gamepad = UserInputService:GetLastInputType().Name:find("Gamepad") ~= nil

    local function effectActive() -- Line: 185 -- upvalues: LocalPlayer (upval), Attributes (upval), Workspace (upval)
        local Attribute = LocalPlayer:GetAttribute(Attributes.Effect)
        local Attribute_2 = LocalPlayer:GetAttribute(Attributes.EffectEndsAt)
        if type(Attribute) == "string"
            and type(Attribute_2) == "number"
            and Workspace:GetServerTimeNow() < Attribute_2 then
            return Attribute
        end
        return nil
    end

    local function rolling() -- Line: 194
        -- upvalues: LocalPlayer (upval), Attributes (upval), u99 (val), Workspace (upval)
        local Attribute = LocalPlayer:GetAttribute(Attributes.RollEndsAt)
        local Rolling = u99.Rolling
        if not Rolling then
            Rolling = u99.Flying
            if not Rolling then
                Rolling = false
                if type(Attribute) == "number" then
                    Rolling = Workspace:GetServerTimeNow() < Attribute
                end
            end
        end
        return Rolling
    end

    local function showBanner(a1, a2, a3) -- Line: 199
        -- upvalues: u99 (val), Banner (val), UIStroke_3 (val), Pop_4 (val), TweenService (upval)
        local v1 = u99
        v1.BannerToken = v1.BannerToken + 1
        local BannerToken = u99.BannerToken
        Banner.Text = a1
        Banner.TextColor3 = a2
        Banner.TextTransparency = 0
        UIStroke_3.Transparency = 0
        Pop_4.Scale = 1.7
        local v2 = Pop_4
        local Back = Enum.EasingStyle.Back
        local v3 = TweenService
        local new = TweenInfo.new
        v3:Create(v2, new(0.35, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        task.delay(a3, function() -- Line: 208
            -- upvalues: BannerToken (val), u99 (upval), Banner (upval), TweenService (upval), UIStroke_3 (upval)
            if BannerToken == u99.BannerToken then
                TweenService:Create(Banner, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                TweenService:Create(UIStroke_3, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
            end
        end)
    end

    local function flashScreen(a1, a2) -- Line: 216
        -- upvalues: Flash (val), TweenService (upval)
        Flash.BackgroundTransparency = 1 - a1
        TweenService:Create(Flash, TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    end

    local function pulseTint(a1, a2, a3) -- Line: 221
        -- upvalues: Tint (val), u99 (val), TweenService (upval)
        Tint.GroupColor3 = a1
        Tint.GroupTransparency = 1 - a2
        local v1 = Tint
        local v2 = {GroupTransparency = u99.TintFloor}
        TweenService:Create(v1, TweenInfo.new(a3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v2):Play()
    end

    local u123 = {}

    local function setIcon(a1, a2) -- Line: 228 -- upvalues: u123 (val), RacePowerUps (upval) -- types: a1: userdata
        local Model = a1:FindFirstChild("Model")
        local Model_2 = a2.Model
        if Model_2 ~= nil and Model ~= nil then
            a1.Image = ""
            Model.Visible = true
            if u123[Model] == Model_2 then
                return
            end
            u123[Model] = Model_2
            local WorldModel = Model:FindFirstChildOfClass("WorldModel")
            WorldModel:ClearAllChildren()
            local v1 = RacePowerUps.Assets.Icons[Model_2]:Clone()
            v1:PivotTo(CFrame.identity)
            v1.Parent = WorldModel
            local BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
            v1 = BoundingBox_2.Magnitude * 0.5
            local Camera = Model:FindFirstChildOfClass("Camera")
            if Camera == nil then
                Camera = Instance.new("Camera")
                Camera.FieldOfView = 30
                Camera.Parent = Model
            end
            Model.CurrentCamera = Camera
            Camera.CFrame = CFrame.lookAt(
                BoundingBox.Position + Vector3.new(0.550000011920929, 0.6000000238418579, 1).Unit * v1 * 3.6,
                BoundingBox.Position
            )
            return
        end
        a1.Image = a2.Icon
        if Model ~= nil then
            Model.Visible = false
        end
    end

    local function refreshKey() -- Line: 262
        -- upvalues: UserInputService (upval), KeyHint (val), Tap (val), u99 (val), InputIconsConfig (upval)
        -- upvalues: ConsoleIcon (val), Key (val), UIStroke_2 (val)
        local v1
        local TouchEnabled = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        KeyHint.Visible = not TouchEnabled
        Tap.Visible = TouchEnabled
        ConsoleIcon.Image = (if not u99.Gamepad then nil else InputIconsConfig.Image(Enum.KeyCode.ButtonX)) or ""
        ConsoleIcon.Visible = v1 ~= nil
        Key.Visible = v1 == nil
        UIStroke_2.Enabled = v1 == nil
        Key.Text = if not u99.Gamepad then "E" else "X"
    end

    local function refreshSlot(a1) -- Line: 275
        -- upvalues: LocalPlayer (upval), Attributes (upval), Items (upval), u99 (val), Workspace (upval), Slot (val)
        -- upvalues: Pop_2 (val), TweenService (upval), setIcon (val), Icon_2 (val), Glow (val), Count (val)
        -- upvalues: refreshKey (val)
        local v1
        local Attribute = LocalPlayer:GetAttribute(Attributes.Item)
        local v2 = if type(Attribute) ~= "string" then nil else Items[Attribute]
        if v2 ~= nil then
            local v3 = LocalPlayer:GetAttribute(Attributes.RollEndsAt)
            local Rolling = u99.Rolling
            if not Rolling then
                Rolling = u99.Flying
                if not Rolling then
                    Rolling = false
                    if type(v3) == "number" then
                        Rolling = Workspace:GetServerTimeNow() < v3
                    end
                end
            end
            if not Rolling then
                local Attribute_2 = LocalPlayer:GetAttribute(Attributes.Uses)
                setIcon(Icon_2, v2)
                Glow.ImageColor3 = v2.Color
                local v4 = false
                if type(Attribute_2) == "number" then
                    v4 = 1 < v2.Uses
                end
                Count.Visible = v4
                Count.Text = ("x%*"):format(if type(Attribute_2) ~= "number" then 1 else Attribute_2)
                refreshKey()
                if a1 or not Slot.Visible then
                    Slot.Visible = true
                    Pop_2.Scale = 1.45
                    v1 = Pop_2
                    local Back = Enum.EasingStyle.Back
                    local v5 = TweenService
                    local new = TweenInfo.new
                    v5:Create(v1, new(0.4, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                end
                return
            end
        end
        if v2 == nil and Slot.Visible then
            v1 = Pop_2
            local Back_2 = Enum.EasingStyle.Back
            local In = Enum.EasingDirection.In
            local v6 = TweenService:Create(v1, TweenInfo.new(0.18, Back_2 or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out), {Scale = 0})
            v6:Play()
            v6.Completed:Once(function() -- Line: 281 -- upvalues: LocalPlayer (upval), Attributes (upval), Slot (upval)
                if LocalPlayer:GetAttribute(Attributes.Item) == nil then
                    Slot.Visible = false
                end
            end)
        end
    end

    local function setReel(a1, a2, a3) -- Line: 303
        -- upvalues: setIcon (val), Next (val), Icon (val), TweenService (upval)
        setIcon(Next, a1)
        Next.Position = UDim2.fromScale(0.5, -0.55)
        Icon.Position = UDim2.fromScale(0.5, 0.5)
        local v1 = a3 + 0.9
        Next.Size = UDim2.fromScale(0.9, v1)
        Icon.Size = UDim2.fromScale(0.9, v1)
        local v2 = Icon
        local v3 = {Position = UDim2.fromScale(0.5, 1.55)}
        local Quad = Enum.EasingStyle.Quad
        local In = Enum.EasingDirection.In
        local v4 = TweenService
        local new = TweenInfo.new
        v4:Create(v2, new(a2, Quad or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out), v3):Play()
        v3 = Next
        local v5 = {Position = UDim2.fromScale(0.5, 0.5)}
        local Quad_3 = Enum.EasingStyle.Quad
        local Out_2 = Enum.EasingDirection.Out
        v2 = TweenService:Create(v3, TweenInfo.new(a2, Quad_3 or Enum.EasingStyle.Quad, Out_2 or Enum.EasingDirection.Out), v5)
        v2:Play()
        v2.Completed:Once(function() -- Line: 323 -- upvalues: setIcon (upval), Icon (upval), a1 (val), Next (upval)
            setIcon(Icon, a1)
            Icon.Position = UDim2.fromScale(0.5, 0.5)
            Icon.Size = UDim2.fromScale(0.9, 0.9)
            Next.Position = UDim2.fromScale(0.5, -0.55)
        end)
    end

    local function flyToSlot(a1, a2) -- Line: 331
        -- upvalues: u99 (val), setIcon (val), Fly (val), Trail (val), u92 (upval), Roll (val), u96 (upval)
        -- upvalues: TweenService (upval), u100 (upval), RunService (upval), PowerUpVisuals (upval), refreshSlot (val)
        -- upvalues: Glow (val)
        local Value, v1, v2, v3, v4
        u99.Flying = true
        setIcon(Fly, a1)
        Trail.ImageColor3 = a1.Color
        Fly.Position = u92
        Fly.Size = UDim2.fromScale(0.22, 0.22)
        Fly.Rotation = 0
        Fly.Visible = true
        Roll.Visible = false
        local v5 = Vector2.new(u92.X.Scale, u92.Y.Scale)
        local v6 = Vector2.new(u96.X.Scale, u96.Y.Scale)
        local v7 = os.clock()
        while a2 == u99.RollToken do
            v1 = math.min((os.clock() - v7) / 0.42, 1)
            Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            v3 = u100
            v4 = 1 - Value
            v2 = v5 * v4 * v4 + v3 * 2 * v4 * Value + v6 * Value * Value
            Fly.Position = UDim2.fromScale(v2.X, v2.Y)
            v2 = 0.22 + -0.11 * Value
            Fly.Size = UDim2.fromScale(v2, v2)
            Fly.Rotation = math.sin(v1 * 3.141592653589793) * -22
            Trail.ImageTransparency = v1 * 0.5 + 0.35
            if v1 >= 1 then
                break
            end
            RunService.RenderStepped:Wait()
        end
        Fly.Visible = false
        u99.Flying = false
        if a2 ~= u99.RollToken then
            return
        end
        PowerUpVisuals.Sound("Ready", nil)
        refreshSlot(true)
        Glow.ImageTransparency = 0
        TweenService:Create(Glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.5}):Play()
    end

    local function land(a1, a2) -- Line: 368
        -- upvalues: setIcon (val), Icon (val), Next (val), Pop (val), TweenService (upval), Ring (val), Rays (val)
        -- upvalues: Sparkle (val), u99 (val), Vignette (val), Flash (val), Title (val), UIStroke (val)
        -- upvalues: PowerUpVisuals (upval), a4 (val), flyToSlot (val)
        setIcon(Icon, a1)
        Icon.Position = UDim2.fromScale(0.5, 0.5)
        Icon.Size = UDim2.fromScale(0.9, 0.9)
        Next.Position = UDim2.fromScale(0.5, -0.55)
        Pop.Scale = 1.55
        local v1 = Pop
        local Elastic = Enum.EasingStyle.Elastic
        local v2 = TweenService
        local new = TweenInfo.new
        v2:Create(v1, new(0.55, Elastic or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        Ring.ImageColor3 = a1.Color
        Ring.Size = UDim2.fromScale(1, 1)
        Ring.ImageTransparency = 0
        v1 = Ring
        local v3 = {ImageTransparency = 1, Size = UDim2.fromScale(2.8, 2.8)}
        TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v3):Play()
        Rays.ImageColor3 = a1.Color
        Rays.ImageTransparency = 0.05
        TweenService:Create(Rays, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.65}):Play()
        Sparkle.ImageTransparency = 0
        Sparkle.Size = UDim2.fromScale(0.9, 0.9)
        v1 = Sparkle
        v3 = {ImageTransparency = 1, Size = UDim2.fromScale(0.3, 0.3)}
        TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v3):Play()
        u99.Rainbow = false
        for i, j in Vignette:GetChildren() do
            if j:IsA("Frame") then
                j.BackgroundColor3 = a1.Color
            end
        end
        Vignette.GroupTransparency = 0
        TweenService:Create(Vignette, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1}):Play()
        Flash.BackgroundTransparency = 0.55
        TweenService:Create(Flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        Title.Text = string.upper(a1.Name)
        Title.TextColor3 = Color3.new(1, 1, 1)
        Title.TextTransparency = 0
        UIStroke.Transparency = 0
        Title.Position = UDim2.fromScale(0.5, 1.22)
        v1 = Title
        v3 = {Position = UDim2.fromScale(0.5, 1.1)}
        local Back = Enum.EasingStyle.Back
        v2 = TweenService
        local new_2 = TweenInfo.new
        v2:Create(v1, new_2(0.35, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v3):Play()
        PowerUpVisuals.Sound("Land", nil)
        a4:PunchFov(24)
        a4:Shake(1.6)
        task.wait(0.55)
        if a2 ~= u99.RollToken then
            return
        end
        TweenService:Create(Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        TweenService:Create(UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
        u99.Rolling = false
        flyToSlot(a1, a2)
    end

    local function startRoll(a1, a2) -- Line: 413
        -- upvalues: u99 (val), Items (upval), Slot (val), Roll (val), Pop (val), TweenService (upval), Title (val)
        -- upvalues: UIStroke (val), Ring (val), Sparkle (val), Rays (val), Vignette (val), shuffled (upval)
        -- upvalues: Workspace (upval), setIcon (val), Icon (val), setReel (val), PowerUpVisuals (upval), land (val)
        local v1 = u99
        v1.RollToken = v1.RollToken + 1
        local RollToken = u99.RollToken
        u99.Rolling = true
        local u10 = Items[a1]
        Slot.Visible = false
        Roll.Visible = true
        Pop.Scale = 0.2
        local v2 = Pop
        local Back = Enum.EasingStyle.Back
        local v3 = TweenService
        local new = TweenInfo.new
        v3:Create(v2, new(0.3, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        Title.TextTransparency = 1
        UIStroke.Transparency = 1
        Ring.ImageTransparency = 1
        Sparkle.ImageTransparency = 1
        Rays.ImageColor3 = Color3.new(1, 1, 1)
        Rays.ImageTransparency = 0.8
        u99.Rainbow = true
        Vignette.GroupTransparency = 1
        TweenService:Create(Vignette, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0.1}):Play()
        local u78 = shuffled()
        local u79 = 1
        local u88 = math.max(a2 - Workspace:GetServerTimeNow(), 0.4)
        setIcon(Icon, Items[u78[1]])
        task.spawn(function() -- Line: 435
            -- upvalues: RollToken (val), u99 (upval), a2 (val), Workspace (upval), u88 (val), u79 (ref), u78 (val)
            -- upvalues: a1 (val), u10 (val), Items (upval), setReel (upval), PowerUpVisuals (upval), Pop (upval)
            -- upvalues: TweenService (upval), land (upval)
            local v1, v2, v3, v4
            while RollToken == u99.RollToken do
                v1 = a2 - Workspace:GetServerTimeNow()
                v2 = math.clamp(1 - v1 / u88, 0, 1)
                v3 = v2 ^ 2.2 * 0.27 + 0.045
                if v1 <= v3 * 0.6 then
                    break
                end
                u79 = u79 % #u78 + 1
                if u78[u79] == a1 and v3 * 2.5 < v1 then
                    u79 = u79 % #u78 + 1
                end
                v4 = if not (v1 <= v3 * 1.6) then Items[u78[u79]] else u10
                setReel(v4, math.min(v3 * 0.85, 0.14), (1 - v2) * 0.3)
                PowerUpVisuals.Sound("Tick", nil, v2 * 0.6 + 0.85)
                Pop.Scale = 1.08
                TweenService:Create(Pop, TweenInfo.new(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                task.wait(v3)
            end
            if RollToken == u99.RollToken then
                land(u10, RollToken)
            end
        end)
    end

    local function refreshItem() -- Line: 460
        -- upvalues: LocalPlayer (upval), Attributes (upval), Items (upval), Workspace (upval), u99 (val)
        -- upvalues: startRoll (val), Roll (val), refreshSlot (val)
        local v1
        local Attribute = LocalPlayer:GetAttribute(Attributes.Item)
        local Attribute_2 = LocalPlayer:GetAttribute(Attributes.RollEndsAt)
        if type(Attribute) == "string"
            and Items[Attribute] ~= nil
            and type(Attribute_2) == "number"
            and Workspace:GetServerTimeNow() < Attribute_2 then
            v1 = ("%*@%*"):format(Attribute, Attribute_2)
            if not u99.Rolling or u99.RollKey ~= v1 then
                u99.RollKey = v1
                startRoll(Attribute, Attribute_2)
            end
            return
        end
        if Attribute == nil then
            v1 = u99
            v1.RollToken = v1.RollToken + 1
            u99.Rolling = false
            Roll.Visible = false
        end
        if not u99.Rolling and not u99.Flying then
            refreshSlot(false)
        end
    end

    local function deny() -- Line: 481 -- upvalues: PowerUpVisuals (upval), Slot (val), RunService (upval)
        PowerUpVisuals.Sound("Deny", nil)
        local u6 = os.clock()
        task.spawn(function() -- Line: 484 -- upvalues: u6 (val), Slot (upval), RunService (upval)
            while true do
                if not (os.clock() - u6 < 0.3) then
                    break
                end
                Slot.Rotation = math.sin(((os.clock()) - u6) * 60) * 10 * (1 - (os.clock() - u6) / 0.3)
                RunService.RenderStepped:Wait()
            end
            Slot.Rotation = 0
        end)
    end

    local function use() -- Line: 493
        -- upvalues: LocalPlayer (upval), Attributes (upval), u99 (val), Workspace (upval), PowerUpVisuals (upval)
        -- upvalues: Slot (val), RunService (upval), Pop_2 (val), TweenService (upval), a4 (val), Remotes (upval)
        -- upvalues: Root (val), a3 (val)
        local v1 = LocalPlayer
        if type((v1:GetAttribute(Attributes.Item))) == "string" then
            local Attribute_2 = LocalPlayer:GetAttribute(Attributes.RollEndsAt)
            local Rolling = u99.Rolling
            if not Rolling then
                Rolling = u99.Flying
                if not Rolling then
                    Rolling = false
                    if type(Attribute_2) == "number" then
                        Rolling = Workspace:GetServerTimeNow() < Attribute_2
                    end
                end
            end
            if not Rolling then
                v1 = LocalPlayer:GetAttribute(Attributes.Effect)
                local Attribute_3 = LocalPlayer:GetAttribute(Attributes.EffectEndsAt)
                local v2 = if type(v1) ~= "string" then nil else if type(Attribute_3) ~= "number" then nil else if not (Workspace:GetServerTimeNow() < Attribute_3) then nil else v1
                if v2 == nil and not u99.Stunned then
                    Pop_2.Scale = 0.75
                    v2 = Pop_2
                    local Back = Enum.EasingStyle.Back
                    local v3 = TweenService
                    local new = TweenInfo.new
                    v3:Create(v2, new(0.3, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                    a4:PunchFov(6)
                    Remotes.MountRace.PowerUp:FireServer("Use", Root.Position, a3.Heading)
                    return
                end
                PowerUpVisuals.Sound("Deny", nil)
                local u106 = os.clock()
                task.spawn(function() -- Line: 484 -- upvalues: u106 (val), Slot (upval), RunService (upval)
                    while true do
                        if not (os.clock() - u106 < 0.3) then
                            break
                        end
                        Slot.Rotation = math.sin(((os.clock()) - u106) * 60) * 10 * (1 - (os.clock() - u106) / 0.3)
                        RunService.RenderStepped:Wait()
                    end
                    Slot.Rotation = 0
                end)
                return
            end
        end
    end

    local v2 = ContextActionService
    local Value = Enum.ContextActionPriority.High.Value
    local E = Enum.KeyCode.E
    local ButtonX = Enum.KeyCode.ButtonX
    v2:BindActionAtPriority("RacePowerUpUse", function(a1, a2, a3) -- Line: 508 -- upvalues: u99 (val), use (val) -- types: a3: userdata
        if a2 == Enum.UserInputState.Begin then
            u99.Gamepad = a3.KeyCode == Enum.KeyCode.ButtonX
            use()
        end
        return Enum.ContextActionResult.Sink
    end, false, Value, E, ButtonX)
    a1:Add(function() -- Line: 515 -- upvalues: ContextActionService (upval)
        ContextActionService:UnbindAction("RacePowerUpUse")
    end)
    a1:Connect(Slot.Activated, use)
    a1:Connect(UserInputService.LastInputTypeChanged, function(a1) -- Line: 519 -- upvalues: u99 (val), refreshKey (val)
        u99.Gamepad = a1.Name:find("Gamepad") ~= nil
        refreshKey()
    end)
    a1:Connect(InputIconsConfig.Changed, refreshKey)
    local u192 = nil

    local function endWhale() -- Line: 527
        -- upvalues: a3 (val), u192 (ref), a5 (val), Root (val), MountRaceFlags (upval), a4 (val)
        if a3.Override == nil then
            return
        end
        a3.Override = nil
        local v1 = u192
        u192 = nil
        local CFrame_2 = if v1 == nil then Root.CFrame else a5:FrameAt(v1)
        local UpVector = CFrame_2.UpVector
        local v2 = CFrame_2.LookVector - UpVector * CFrame_2.LookVector:Dot(UpVector)
        local Unit = if not (0.001 < v2.Magnitude) then a3.Heading else v2.Unit
        local v3 = MountRaceFlags.TopSpeed:Get()
        Root.AssemblyLinearVelocity = Unit * v3
        Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        Root.CFrame = CFrame.lookAt(Root.Position, Root.Position + Unit, UpVector)
        a3.Align.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), Unit, UpVector)
        a3.Push.Force = Vector3.new(0, 0, 0)
        a3.Up = UpVector
        a3.Heading = Unit
        a3.TravelDirection = Unit
        a3.Speed = v3
        a3.Grounded = false
        a3.Launched = false
        a3.IgnoreGroundUntil = 0
        a4:PunchFov(8)
    end

    local function startWhale(a1) -- Line: 554
        -- upvalues: MountRaceFlags (upval), a5 (val), Root (val), Tuning (upval), u192 (ref), a4 (val), Flash (val)
        -- upvalues: TweenService (upval), a3 (val), Workspace (upval), LocalPlayer (upval), Attributes (upval)
        -- upvalues: endWhale (val)
        local u5 = MountRaceFlags.TopSpeed:Get()
        local u16 = a5:Project(Root.Position, 0, a5.Length, a5.Length)
        local v1 = a5:FrameAt(u16)
        local X = v1:PointToObjectSpace(Root.Position).X
        local u29 = os.clock()
        local u30 = 0
        local LookVector = v1.LookVector
        local LookVector_2 = Root.CFrame.LookVector
        local u47 = math.clamp((Root.Position - v1.Position):Dot(v1.UpVector), 0, Tuning.SkywhaleHeight)
        u192 = u16
        a4:PunchFov(30)
        a4:Shake(2)
        Flash.BackgroundTransparency = 0.4
        TweenService:Create(Flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()

        function a3.Override(a1_2, a2) -- Line: 568
            -- upvalues: u29 (val), a1 (val), Workspace (upval), u5 (val), Tuning (upval), u16 (ref), u192 (upval)
            -- upvalues: a5 (upval), X (val), u47 (val), Root (upval), LookVector_2 (ref), LookVector (ref), u30 (ref)
            -- upvalues: a4 (upval)
            local v1 = os.clock() - u29
            local v2 = math.clamp((a1 - Workspace:GetServerTimeNow()) / 0.7, 0, 1)
            local v3 = 1 - v2 * v2 * (3 - v2 * 2)
            v2 = u5 * Tuning.SkywhaleScale * math.min(1, 0.45 + v1 * 1.2)
            v2 = v2 + (u5 - v2) * v3
            u16 = u16 + v2 * a2
            u192 = u16
            local v4 = a5:FrameAt(u16)
            local v5 = a5:FrameAt(u16 + 20)
            local UpVector = v4.UpVector
            local v6 = X * math.max(0, 1 - v1 / 0.9)
            local v7 = Tuning.SkywhaleHeight * math.min(1, v1 / 0.45) + math.sin(v1 * 3.2) * 0.7
            v7 = v7 + (u47 - v7) * v3
            v3 = v4.Position + v4.RightVector * v6 + UpVector * v7
            v6 = v5.Position + UpVector * v7 - v3
            local Unit = if not (0.001 < v6.Magnitude) then v4.LookVector else v6.Unit
            v7 = Unit * v2 + (v3 - Root.Position) * 9
            Root.AssemblyLinearVelocity = v7
            v5 = v7 - UpVector * v7:Dot(UpVector) * 0.85
            local Unit_2 = if not (0.001 < v5.Magnitude) then Unit else v5.Unit
            LookVector_2 = LookVector_2:Lerp(Unit_2, (math.min(1, a2 * 14)))
            LookVector_2 = if not (0.001 < LookVector_2.Magnitude) then Unit else LookVector_2.Unit
            v6 = LookVector_2
            Root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            a1_2.Drive.Enabled = false
            a1_2.Push.Force = Vector3.new(0, 1, 0) * Root.AssemblyMass * Workspace.Gravity
            v7 = ((LookVector:Cross(v6)):Dot(UpVector)) / math.max(a2, 0.001)
            LookVector = v6
            u30 = u30 + ((math.clamp(-v7 * 0.35, -0.55, 0.55)) - u30) * math.min(1, a2 * 5)
            a1_2.Align.CFrame = (CFrame.lookAt(Vector3.new(0, 0, 0), v6, UpVector)) * CFrame.Angles(math.sin(v1 * 2.4) * 0.05, 0, u30)
            Root.CFrame = (CFrame.new(Root.Position)) * a1_2.Align.CFrame
            a1_2.Up = a1_2.Up:Lerp(UpVector, (math.min(1, a2 * 6))).Unit
            a1_2.Heading = v6
            a1_2.TravelDirection = v6
            a1_2.Speed = v2
            a1_2.Grounded = false
            a1_2.AirSeconds = 0
            a1_2.Launched = true
            a4:PunchFov(10)
        end

        task.delay(math.max(a1 - Workspace:GetServerTimeNow(), 0), function() -- Line: 610 -- upvalues: a3 (upval), LocalPlayer (upval), Attributes (upval), endWhale (upval)
            if a3.Override ~= nil and LocalPlayer:GetAttribute(Attributes.Effect) ~= "Skywhale" then
                endWhale()
            end
        end)
    end

    local function startStun(a1, a2) -- Line: 617
        -- upvalues: a3 (val), u99 (val), refreshSlot (val), Tuning (upval), Root (val), u106 (upval), showBanner (val)
        -- upvalues: Flash (val), TweenService (upval), Tint (val), a4 (val), Workspace (upval), LocalPlayer (upval)
        -- upvalues: Attributes (upval), MountRaceFlags (upval)
        if a3.Override ~= nil then
            return
        end
        u99.Stunned = true
        refreshSlot(false)
        local u10 = os.clock()
        local Heading = a3.Heading
        local TravelDirection = a3.TravelDirection
        local u19 = math.max(a3.Speed, 0)
        local u21 = if a1 ~= "Drilla" then 1 else 2
        local EggSpinSeconds = if a1 ~= "Egg" then 0.75 else Tuning.EggSpinSeconds
        local v1 = if a1 ~= "Drilla" then if a1 ~= "Pod" then if a1 ~= "Spike" then 0 else 24 else 42 else 62
        if v1 > 0 then
            a3:Launch(Root.AssemblyLinearVelocity * 0.3 + a3.Up * v1)
        end
        v1 = u106[a1]
        if v1 ~= nil then
            showBanner(v1[1], v1[2], 0.9)
        end
        Flash.BackgroundTransparency = 1 - (if a1 ~= "Egg" then 0.55 else 0.35)
        TweenService:Create(Flash, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        local v2 = if a1 ~= "Egg" then Color3.fromRGB(255, 50, 40) else Color3.fromRGB(255, 210, 40)
        Tint.GroupColor3 = v2
        Tint.GroupTransparency = 0.15000000000000002
        local v3 = Tint
        local v4 = {GroupTransparency = u99.TintFloor}
        TweenService:Create(v3, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v4):Play()
        a4:Shake(if a1 ~= "Drilla" then if a1 ~= "Pod" then 4 else 6 else 7)

        function a3.Override(a1_2, a2) -- Line: 640
            -- upvalues: u10 (val), Heading (val), u19 (val), TravelDirection (val), Root (upval), Workspace (upval)
            -- upvalues: EggSpinSeconds (val), TweenService (upval), u21 (val), a1 (val)
            local Unit, v1
            local v2 = os.clock() - u10
            local v3 = false
            local Up = a1_2.Up
            local v4 = os.clock()
            if a1_2.IgnoreGroundUntil <= v4 then
                v4, v1 = a1_2:ProbeGround()
                v3 = v4
                Up = v1
            end
            if v3 and not a1_2.Grounded then
                a1_2.Landed:Fire()
            end
            a1_2.Grounded = v3
            a1_2.AirSeconds = if not v3 then a1_2.AirSeconds + a2 else 0
            a1_2.Launched = not v3
            local Up_2 = a1_2.Up
            a1_2.Up = Up_2:Lerp(if not v3 then Vector3.new(0, 1, 0) else Up, (math.min(1, a2 * 10))).Unit
            local Up_3 = a1_2.Up
            v1 = Heading
            local v5 = v1 - Up_3 * v1:Dot(Up_3)
            v1 = (if not (0.001 < v5.Magnitude) then Vector3.new(0, 0, 1) else v5.Unit):Cross(Up_3)
            v5 = u19 * math.max(0, 1 - v2 / 0.5) ^ 2
            local v6 = TravelDirection
            local v7 = v6 - Up_3 * v6:Dot(Up_3)
            local v8 = (if not (0.001 < v7.Magnitude) then Vector3.new(0, 0, 1) else v7.Unit) * v5
            a1_2.Drive.Enabled = v3
            a1_2.Drive.PrimaryTangentAxis = Unit
            a1_2.Drive.SecondaryTangentAxis = v1
            a1_2.Drive.PlaneVelocity = Vector2.new(v8:Dot(Unit), v8:Dot(v1))
            a1_2.Push.Force = if not v3 then Vector3.new(0, 0, 0) else -Up_3 * Root.AssemblyMass * Workspace.Gravity * 0.4
            v8 = math.min(v2 / EggSpinSeconds, 1)
            v1 = TweenService:GetValue(v8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) * 3.141592653589793 * 2 * u21
            v3 = if not (v8 >= 1) then 0 else math.sin(v2 * 10) * 0.14 * math.max(0, 1 - (v2 - EggSpinSeconds) / 1.2)
            v2 = if a1 == "Egg" then 0 else math.sin(v8 * 3.141592653589793) * 0.5
            a1_2.Align.CFrame = (CFrame.lookAt(Vector3.new(0, 0, 0), Unit, Up_3)) * CFrame.Angles(0, v1 + v3, v2)
            a1_2.Speed = v5
        end

        local u179 = os.clock() + a2
        task.spawn(function() -- Line: 674
            -- upvalues: u179 (ref), LocalPlayer (upval), Attributes (upval), Workspace (upval), a3 (upval), u99 (upval)
            -- upvalues: Heading (val), MountRaceFlags (upval), refreshSlot (upval)
            local Attribute
            while os.clock() < u179 do
                Attribute = LocalPlayer:GetAttribute(Attributes.StunEndsAt)
                if type(Attribute) == "number" then
                    math.max(u179, (os.clock()) + (Attribute - (Workspace:GetServerTimeNow())))
                end
                task.wait(0.05)
            end
            if a3.Override ~= nil and u99.Stunned then
                a3.Override = nil
                a3.Heading = Heading
                a3.TravelDirection = Heading
                a3.Speed = MountRaceFlags.TopSpeed:Get() * 0.2
            end
            u99.Stunned = false
            refreshSlot(false)
        end)
    end

    local function refreshEffect() -- Line: 693
        -- upvalues: LocalPlayer (upval), Attributes (upval), Workspace (upval), u99 (val), a3 (val), endWhale (val)
        -- upvalues: Tint (val), TweenService (upval), Pop_3 (val), Effect (val), refreshSlot (val), Items (upval)
        -- upvalues: setIcon (val), Icon_3 (val), Fill (val), Tuning (upval), MountRaceFlags (upval), a4 (val)
        -- upvalues: Flash (val), startWhale (val)
        local v1, v2
        local Attribute = LocalPlayer:GetAttribute(Attributes.Effect)
        local Attribute_2 = LocalPlayer:GetAttribute(Attributes.EffectEndsAt)
        local v3 = if type(Attribute) ~= "string" then nil else if type(Attribute_2) ~= "number" then nil else if not (Workspace:GetServerTimeNow() < Attribute_2) then nil else Attribute
        local Attribute_3 = LocalPlayer:GetAttribute(Attributes.EffectEndsAt)
        local Effect_3 = u99.Effect
        if v3 == Effect_3 then
            return
        end
        u99.Effect = v3
        if Effect_3 == "Serum" then
            a3:SetSpeedScale("RacePowerUpSerum", nil)
        elseif Effect_3 == "Skywhale" then
            endWhale()
        end
        if v3 == nil then
            u99.TintFloor = 1
            TweenService:Create(Tint, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1}):Play()
            v2 = Pop_3
            local Back = Enum.EasingStyle.Back
            local In = Enum.EasingDirection.In
            v1 = TweenService:Create(v2, TweenInfo.new(0.2, Back or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out), {Scale = 0})
            v1:Play()
            v1.Completed:Once(function() -- Line: 710 -- upvalues: u99 (upval), Effect (upval)
                if u99.Effect == nil then
                    Effect.Visible = false
                end
            end)
            refreshSlot(false)
            return
        end
        v1 = Items[v3]
        u99.EffectEndsAt = Attribute_3
        u99.EffectSeconds = v1.Seconds or 1
        setIcon(Icon_3, v1)
        Fill.BackgroundColor3 = v1.Color
        Effect.Visible = true
        Pop_3.Scale = 0.2
        v2 = Pop_3
        local Back_2 = Enum.EasingStyle.Back
        local v4 = TweenService
        local new_2 = TweenInfo.new
        v4:Create(v2, new_2(0.35, Back_2 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        u99.TintColor = v1.Color
        u99.TintFloor = 0.72
        Tint.GroupColor3 = v1.Color
        Tint.GroupTransparency = 0.4
        local v5 = Tint
        local v6 = {GroupTransparency = u99.TintFloor}
        TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v6):Play()
        if v3 == "Serum" then
            a3:SetSpeedScale("RacePowerUpSerum", Tuning.SerumScale)
            if -1 < a3.Speed then
                a3.Speed = math.max(a3.Speed, (MountRaceFlags.TopSpeed:Get()) * 1.85)
            end
            a4:PunchFov(26)
            a4:Shake(1.4)
            Flash.BackgroundTransparency = 0.65
            TweenService:Create(Flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        elseif v3 == "Shield" then
            a4:PunchFov(12)
            Flash.BackgroundTransparency = 0.7
            TweenService:Create(Flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        elseif v3 == "Skywhale" then
            startWhale(Attribute_3)
        end
        refreshSlot(false)
    end

    a1:Add(function() -- Line: 747 -- upvalues: a3 (val)
        a3:SetSpeedScale("RacePowerUpSerum", nil)
        a3.Override = nil
    end)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Attributes.Item), refreshItem)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Attributes.RollEndsAt), refreshItem)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Attributes.Uses), function() -- Line: 754 -- upvalues: Slot (val), refreshSlot (val), Count (val), TweenService (upval)
        if Slot.Visible then
            refreshSlot(false)
            Count.TextColor3 = Color3.fromRGB(255, 230, 90)
            local v1 = Count
            local v2 = {TextColor3 = Color3.new(1, 1, 1)}
            TweenService:Create(v1, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v2):Play()
        end
    end)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Attributes.Effect), refreshEffect)
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Attributes.EffectEndsAt), refreshEffect)
    refreshItem()
    refreshEffect()
    a1:Connect(Remotes.MountRace.PowerUpMoment.OnClientEvent, function(a1, ...) -- Line: 766
        -- upvalues: LocalPlayer (upval), startStun (val), showBanner (val), Flash (val), TweenService (upval)
        -- upvalues: Tint (val), u99 (val), a4 (val)
        local v1, v2
        local v3 = {...}
        if a1 == "Hit" and v3[1] == LocalPlayer then
            startStun(v3[2], v3[3])
            return
        end
        if a1 == "Blocked" and v3[1] == LocalPlayer then
            showBanner("BLOCKED!", Color3.fromRGB(110, 225, 255), 0.8)
            Flash.BackgroundTransparency = 0.65
            TweenService:Create(Flash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            Tint.GroupColor3 = (Color3.fromRGB(90, 210, 255))
            Tint.GroupTransparency = 0.30000000000000004
            v1 = Tint
            v2 = {GroupTransparency = u99.TintFloor}
            TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v2):Play()
            a4:Shake(2)
            return
        end
        if a1 == "PodLock" and v3[2] == LocalPlayer then
            showBanner("INCOMING!", Color3.fromRGB(255, 70, 60), 1.4)
            Tint.GroupColor3 = (Color3.fromRGB(255, 40, 40))
            Tint.GroupTransparency = 0.25
            v1 = Tint
            v2 = {GroupTransparency = u99.TintFloor}
            TweenService:Create(v1, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v2):Play()
            return
        end
        if a1 == "Drilla" and v3[5] == LocalPlayer then
            showBanner("DRILLA INCOMING!", Color3.fromRGB(255, 200, 60), 1.2)
            return
        end
        if a1 == "DrillaWarn" and v3[2] == LocalPlayer then
            showBanner("MOVE!", Color3.fromRGB(255, 70, 60), 0.8)
            Tint.GroupColor3 = (Color3.fromRGB(255, 40, 40))
            Tint.GroupTransparency = 0.15000000000000002
            v1 = Tint
            v2 = {GroupTransparency = u99.TintFloor}
            TweenService:Create(v1, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v2):Play()
            a4:Shake(3)
            return
        end
        if a1 == "Use" and v3[1] == LocalPlayer then
            local v4 = v3[2]
            if v4 == "Spike" or v4 == "Egg" or v4 == "Pod" or v4 == "Drilla" then
                a4:Shake(0.8)
            end
        end
    end)
    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 792
        -- upvalues: u99 (val), Vignette (val), Rays (val), Roll (val), Slot (val), LocalPlayer (upval)
        -- upvalues: Attributes (upval), Workspace (upval), Icon_2 (val), u105 (upval), KeyHint (val), ConsoleIcon (val)
        -- upvalues: Key (val), Glow (val), Tap (val), Effect (val), Fill (val), Time (val), Tint (val), a4 (val)
        local v1
        if u99.Rolling then
            if u99.Rainbow then
                local fromHSV, v2
                for i, j in Vignette:GetChildren() do
                    if j:IsA("Frame") then
                        fromHSV = Color3.fromHSV
                        v2 = (os.clock() * 0.9 + i * 0.25) % 1
                        j.BackgroundColor3 = fromHSV(v2, 0.75, 1)
                    end
                end
            end
            Rays.Rotation = (Rays.Rotation + a1 * 90) % 360
        elseif Roll.Visible then
            Rays.Rotation = (Rays.Rotation + a1 * 40) % 360
        end
        if Slot.Visible then
            v1 = os.clock()
            local Stunned = true
            local Attribute = LocalPlayer:GetAttribute(Attributes.Effect)
            local Attribute_2 = LocalPlayer:GetAttribute(Attributes.EffectEndsAt)
            if (if type(Attribute) ~= "string" then nil else if type(Attribute_2) ~= "number" then nil else if not (Workspace:GetServerTimeNow() < Attribute_2) then nil else Attribute) == nil then
                Stunned = u99.Stunned
            end
            Icon_2.ImageColor3 = if not Stunned then Color3.new(1, 1, 1) else u105
            local Model = Icon_2:FindFirstChild("Model")
            if Model ~= nil and Model:IsA("ViewportFrame") then
                Model.ImageColor3 = Icon_2.ImageColor3
            end
            KeyHint.BackgroundTransparency = if not ConsoleIcon.Visible then if not Stunned then 0 else 0.5 else 1
            Key.TextTransparency = if not Stunned then 0 else 0.5
            ConsoleIcon.ImageTransparency = if not Stunned then 0 else 0.5
            Glow.ImageTransparency = if not Stunned then math.sin(v1 * 4) * 0.15 + 0.5 else 0.9
            Glow.Rotation = v1 * 30 % 360
            Icon_2.Rotation = if not Stunned then math.sin(v1 * 2.2) * 4 else 0
            Tap.TextTransparency = if not Stunned then math.sin(v1 * 6) * 0.15 + 0.15 else 0.6
        end
        if Effect.Visible and u99.Effect ~= nil then
            v1 = math.max(u99.EffectEndsAt - Workspace:GetServerTimeNow(), 0)
            Fill.Size = UDim2.fromScale(math.clamp(v1 / u99.EffectSeconds, 0, 1), 1)
            Time.Text = string.format("%.1f", v1)
            if u99.TintColor ~= nil then
                local GroupTransparency = Tint.GroupTransparency
                if u99.TintFloor - 0.01 <= GroupTransparency then
                    Tint.GroupColor3 = u99.TintColor
                    Tint.GroupTransparency = u99.TintFloor + math.sin((os.clock()) * 5) * 0.06
                end
            end
            if u99.Effect == "Serum" then
                a4:PunchFov(12)
            end
        end
    end)
    return v1
end

return v1