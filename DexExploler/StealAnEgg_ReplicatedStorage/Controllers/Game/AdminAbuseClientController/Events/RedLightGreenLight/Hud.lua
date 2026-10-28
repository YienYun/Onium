-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight.Hud
-- Decompile time: 10.68 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Giant = require(script.Parent.Giant)
local u23 = UDim2.fromScale(0.5, 0.085)
local u27 = UDim2.fromScale(0.5, -0.45)
local v1 = Color3.fromRGB(80, 255, 120)
local v2 = Color3.fromRGB(255, 60, 70)
local v3 = Color3.fromRGB(255, 214, 89)
local u47 = Color3.fromRGB(255, 60, 80)
local u52 = Color3.fromRGB(70, 70, 82)
local u53 = {Green = {Title = "GREEN LIGHT!", State = "TURNED AWAY", Vignette = 0.55, Color = v1}}
u53.Red = {Title = "RED LIGHT!", State = "WATCHING", Vignette = 0.12, Color = v2}
u53.Rise = {Title = "RED LIGHT, GREEN LIGHT", State = "GET READY", Vignette = 1, Color = v3}
u53.Wait = {Title = "RED LIGHT, GREEN LIGHT", State = "STARTS AT SUNRISE", Vignette = 1, Color = v3}
local u58 = {}

local function tween(a1, a2, a3, a4) -- Line: 86
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

local function cloneGui(a1) -- Line: 103 -- upvalues: Players (val) -- types: a1: string
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v1 = PlayerGui:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("ScreenGui") then
        return v1
    end
    v1 = (game:GetService("StarterGui")):FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("ScreenGui") then
        local v2 = v1:Clone()
        v2.Parent = PlayerGui
        return v2
    end
    warn((("[RedLightGreenLight] StarterGui.%* is missing"):format(a1)))
    return nil
end

local function buildViewportRig(a1, a2) -- Line: 125 -- types: a1: table, a2: userdata
    a2.Archivable = true
    local v1 = a2:Clone()
    local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart", true)
    local Head = v1:FindFirstChild("Head")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and Head ~= nil and Head:IsA("BasePart") then
        local v2
        local v3 = a1
        for i, j in v1:GetDescendants() do
            if j:IsA("BasePart") then
                v2 = j == HumanoidRootPart
                j.Anchored = v2
                v2 = j ~= HumanoidRootPart
                j.Massless = v2
            elseif j:IsA("Script") or j:IsA("LocalScript") or j:IsA("Animator") then
                j:Destroy()
            end
        end
        local Humanoid = v1:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil then
            Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            Humanoid.PlatformStand = true
        end
        v1.PrimaryPart = HumanoidRootPart
        v1:PivotTo((CFrame.new()))
        local WorldModel = v3.Viewport:FindFirstChildOfClass("WorldModel")
        if WorldModel == nil then
            WorldModel = Instance.new("WorldModel")
            WorldModel.Parent = v3.Viewport
        end
        v1.Parent = WorldModel
        local CurrentCamera = v3.Viewport.CurrentCamera or Instance.new("Camera")
        local v4 = Head.Position - Vector3.new(0, Head.Size.Y * 0.55, 0)
        local v5 = Head.Size.Y * 3.6
        CurrentCamera.FieldOfView = 38
        CurrentCamera.CFrame = CFrame.lookAt(v4 + Vector3.new(0, Head.Size.Y * 0.25, -v5), v4)
        CurrentCamera.Parent = v3.Viewport
        v3.Viewport.CurrentCamera = CurrentCamera
        local Neck = Head:FindFirstChild("Neck")
        v3.Rig = v1
        v3.RigRoot = HumanoidRootPart
        v3.RigNeck = if Neck == nil then nil else if not Neck:IsA("Motor6D") then nil else Neck
        return
    end
    v1:Destroy()
end

local function rebuildHearts(a1, a2) -- Line: 185 -- types: a1: table, a2: number
    local v1
    for i, j in a1.HeartLabels do
        j:Destroy()
    end
    table.clear(a1.HeartLabels)
    for k = 1, a2 do
        v1 = a1.HeartTemplate:Clone()
        v1.Name = ("Heart%*"):format(k)
        v1.Visible = true
        v1.LayoutOrder = k
        v1.Parent = a1.Hearts
        table.insert(a1.HeartLabels, v1)
    end
end

function u58.Mount(a1) -- Line: 207
    -- upvalues: cloneGui (val), buildViewportRig (val), u27 (val)
    local RedLightGreenLightUI = cloneGui("RedLightGreenLightUI")
    local RedLightGreenLightOverlay = cloneGui("RedLightGreenLightOverlay")
    local RedLightGreenLightCinematic = cloneGui("RedLightGreenLightCinematic")
    if RedLightGreenLightUI ~= nil and RedLightGreenLightOverlay ~= nil and RedLightGreenLightCinematic ~= nil then
        local Board = RedLightGreenLightUI:FindFirstChild("Board")
        local Portrait = Board:FindFirstChild("Portrait")
        local Hearts = Board:FindFirstChild("Hearts")
        local Heart = Hearts:FindFirstChild("Heart")
        Heart.Visible = false
        local v1 = {
            Light = "Rise",
            Lives = 0,
            Clock = 0,
            Shown = false,
            Gui = RedLightGreenLightUI,
            Overlay = RedLightGreenLightOverlay,
            Cinematic = RedLightGreenLightCinematic,
            Board = Board,
            Title = Board:FindFirstChild("Title"),
            Subtitle = Board:FindFirstChild("Subtitle"),
            Portrait = Portrait,
            PortraitStroke = Portrait:FindFirstChildOfClass("UIStroke"),
            State = Board:FindFirstChild("State"),
            Hearts = Hearts,
            HeartTemplate = Heart,
            HeartLabels = {},
            Viewport = Portrait:FindFirstChild("Viewport"),
            Vignette = RedLightGreenLightOverlay:FindFirstChild("Vignette"),
            Top = RedLightGreenLightCinematic:FindFirstChild("Top"),
            Bottom = RedLightGreenLightCinematic:FindFirstChild("Bottom"),
            Cover = RedLightGreenLightCinematic:FindFirstChild("Cover"),
        }
        if a1 ~= nil then
            buildViewportRig(v1, a1)
        end
        Board.Position = u27
        v1.Vignette.ImageTransparency = 1
        v1.Cover.BackgroundTransparency = 1
        v1.Top.Position = UDim2.fromScale(0, -0.11)
        v1.Bottom.Position = UDim2.fromScale(0, 1)
        RedLightGreenLightUI.Enabled = true
        RedLightGreenLightOverlay.Enabled = true
        RedLightGreenLightCinematic.Enabled = true
        return v1
    end
    return nil
end

function u58.SetBoardShown(a1, a2) -- Line: 266
    -- upvalues: u23 (val), u27 (val), TweenService (val)
    if a1.Shown == a2 then
        return
    end
    a1.Shown = a2
    local Board = a1.Board
    local v1 = {Position = if not a2 then u27 else u23}
    local Back = if not a2 then Enum.EasingStyle.Quad else Enum.EasingStyle.Back
    local new = TweenInfo.new
    TweenService:Create(Board, new(if not a2 then 0.25 else 0.45, Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
end

function u58.SetLight(a1, a2) -- Line: 283
    -- upvalues: u53 (val), TweenService (val), GuiService (val)
    local Rise = u53[a2] or u53.Rise
    a1.Light = a2
    a1.Title.Text = Rise.Title
    a1.State.Text = Rise.State
    local Title = a1.Title
    local v1 = {TextColor3 = Rise.Color}
    TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
    if a1.PortraitStroke ~= nil then
        local PortraitStroke = a1.PortraitStroke
        v1 = {Color = Rise.Color}
        TweenService:Create(PortraitStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
    end
    local Vignette = a1.Vignette
    v1 = {ImageColor3 = Rise.Color, ImageTransparency = Rise.Vignette}
    TweenService:Create(Vignette, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
    local UIScale = a1.Title:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil and not GuiService.ReducedMotionEnabled then
        UIScale.Scale = 1.25
        local Back = Enum.EasingStyle.Back
        local new = TweenInfo.new
        TweenService:Create(UIScale, new(0.35, Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
end

function u58.SetLives(a1, a2, a3) -- Line: 305
    -- upvalues: rebuildHearts (val), u47 (val), u52 (val), GuiService (val), TweenService (val)
    local Back, Elastic, UIScale, new, v1, v2, v3
    if #a1.HeartLabels ~= a3 then
        rebuildHearts(a1, a3)
    end
    local v4 = a2 < a1.Lives
    a1.Lives = a2
    local v5 = nil
    local v6 = nil
    local v7 = a2
    for i, j in a1.HeartLabels, v5, v6 do
        v1 = if not (i <= v7) then u52 else u47
        j.ImageColor3 = v1
        j.ImageTransparency = if not v3 then 0.25 else 0
        UIScale = j:FindFirstChildOfClass("UIScale")
        if v4 and i == v7 + 1 and UIScale ~= nil and not GuiService.ReducedMotionEnabled then
            UIScale.Scale = 1.6
            j.Rotation = 18
            Back = Enum.EasingStyle.Back
            new = TweenInfo.new
            TweenService:Create(UIScale, new(0.5, Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1}):Play()
            Elastic = Enum.EasingStyle.Elastic
            v2 = TweenInfo.new(0.5, Elastic or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            TweenService:Create(j, v2, {Rotation = 0}):Play()
        end
    end
end

function u58.Letterbox(a1, a2) -- Line: 331 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean
    local Top = a1.Top
    local v1 = {}
    local v2 = if not a2 then UDim2.fromScale(0, -0.11) else UDim2.fromScale(0, 0)
    v1.Position = v2
    TweenService:Create(Top, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
    local Bottom = a1.Bottom
    v1 = {}
    v2 = if not a2 then UDim2.fromScale(0, 1) else UDim2.fromScale(0, 0.89)
    v1.Position = v2
    TweenService:Create(Bottom, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
end

function u58.Cover(a1, a2) -- Line: 342 -- upvalues: TweenService (val) -- types: a1: table, a2: number
    local Cover = a1.Cover
    local Quad = Enum.EasingStyle.Quad
    local v1 = TweenService
    local new = TweenInfo.new
    v1:Create(Cover, new(a2, Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    task.delay(a2 + 0.35, function() -- Line: 345 -- upvalues: a1 (val), TweenService (upval)
        if a1.Cover.Parent ~= nil then
            local Cover = a1.Cover
            local Quad = Enum.EasingStyle.Quad
            local v1 = TweenService
            local new = TweenInfo.new
            v1:Create(Cover, new(0.6, Quad or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        end
    end)
end

function u58.Update(a1, a2, a3) -- Line: 352 -- upvalues: GuiService (val), Giant (val) -- types: a1: table, a2: number
    a1.Clock = a1.Clock + a2
    if a1.Light == "Red" and not GuiService.ReducedMotionEnabled then
        local v1 = (math.sin(a1.Clock * 3.141592653589793 * 2 * 1.4) + 1) * 0.5
        a1.Vignette.ImageTransparency = v1 * 0.2 + 0.04
    end
    local RigRoot = a1.RigRoot
    if a3 ~= nil and RigRoot ~= nil then
        RigRoot.CFrame = CFrame.Angles(0, Giant.BodyYaw(a3), 0)
        local RigNeck = a1.RigNeck
        if RigNeck ~= nil then
            RigNeck.Transform = CFrame.Angles(0, (Giant.HeadYaw(a3)) - Giant.BodyYaw(a3), 0)
        end
        return
    end
end

function u58.Unmount(a1) -- Line: 376 -- upvalues: u58 (val), TweenService (val) -- types: a1: table
    u58.SetBoardShown(a1, false)
    TweenService:Create(a1.Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
    u58.Letterbox(a1, false)
    task.delay(0.6, function() -- Line: 381 -- upvalues: a1 (val)
        a1.Gui:Destroy()
        a1.Overlay:Destroy()
        a1.Cinematic:Destroy()
    end)
end

return u58