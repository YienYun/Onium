-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.WrongWay
-- Decompile time: 11.36 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
require(script.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u54 = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic)
local u60 = Color3.fromRGB(255, 70, 40)
local u65 = Color3.fromRGB(255, 170, 40)
local u70 = Color3.fromRGB(255, 130, 30)
local v1 = {}

local function stroke(a1, a2) -- Line: 45 -- types: a1: userdata, a2: number
    local UIStroke = Instance.new("UIStroke")
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke.Thickness = a2
    UIStroke.Color = Color3.new(0, 0, 0)
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke.Parent = a1
end

local function label(a1, a2, a3, a4, a5) -- Line: 54
    -- upvalues: u54 (val)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = a1
    TextLabel.BackgroundTransparency = 1
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.Size = a3
    TextLabel.Position = a4
    TextLabel.FontFace = u54
    TextLabel.Text = a2
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.Parent = a5
    return TextLabel
end

local function buildGui() -- Line: 69 -- upvalues: u60 (val), u65 (val), label (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RaceWrongWay"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 7
    ScreenGui.Enabled = false
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Vignette"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://104574024062008"
    ImageLabel.ImageColor3 = u60
    ImageLabel.ImageTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = ScreenGui
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = "Banner"
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0.5)
    CanvasGroup.Position = UDim2.fromScale(0.5, 0.27)
    CanvasGroup.Size = UDim2.fromScale(0.62, 0.2)
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Parent = ScreenGui
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 3.6
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.Parent = CanvasGroup
    local UIScale = Instance.new("UIScale")
    UIScale.Parent = CanvasGroup
    local Frame = Instance.new("Frame")
    Frame.Name = "Plate"
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.42)
    Frame.Size = UDim2.fromScale(0.94, 0.62)
    Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame.Parent = CanvasGroup
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.22, 0)
    UICorner.Parent = Frame
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new(u60, u65)
    UIGradient.Rotation = 90
    UIGradient.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke.Thickness = 0.03
    UIStroke.Color = Color3.fromRGB(80, 10, 0)
    UIStroke.Parent = Frame
    local v1 = label("Title", "WRONG WAY!", UDim2.fromScale(0.86, 0.72), UDim2.fromScale(0.5, 0.5), Frame)
    local v2 = Instance.new("UIStroke")
    v2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    v2.Thickness = 0.09
    v2.Color = Color3.new(0, 0, 0)
    v2.LineJoinMode = Enum.LineJoinMode.Round
    v2.Parent = v1
    v1 = label("Hint", "TURN AROUND", UDim2.fromScale(0.6, 0.3), UDim2.fromScale(0.5, 0.88), CanvasGroup)
    v1.TextColor3 = Color3.fromRGB(255, 236, 200)
    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    UIStroke_2.Thickness = 0.12
    UIStroke_2.Color = Color3.new(0, 0, 0)
    UIStroke_2.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke_2.Parent = v1
    return ScreenGui, ImageLabel, CanvasGroup, UIScale
end

local function buildArrow() -- Line: 137 -- upvalues: u70 (val), u65 (val)
    local Part
    local Model = Instance.new("Model")
    Model.Name = "RaceWrongWayArrow"
    local v1 = {}
    for i = 1, 3 do
        for j, k in {-1, 1} do
            Part = Instance.new("Part")
            Part.Name = ("Chevron%*"):format(i)
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            Part.Material = Enum.Material.Neon
            Part.Color = u70
            Part.Size = Vector3.new(0.75, 0.44999998807907104, 2.5999999046325684)
            Part:SetAttribute("Index", i)
            Part:SetAttribute("Side", k)
            Part.Parent = Model
            table.insert(v1, Part)
        end
    end
    local Highlight = Instance.new("Highlight")
    Highlight.FillTransparency = 0.6
    Highlight.FillColor = u65
    Highlight.OutlineColor = Color3.new(1, 1, 1)
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Parent = Model
    return Model, v1
end

local function flat(a1, a2) -- Line: 168 -- types: a1: vector, a2: vector
    local v1 = a1 - a2 * a1:Dot(a2)
    if 0.001 < v1.Magnitude then
        return v1.Unit
    end
    return nil
end

function v1.Run(a1, a2, a3, a4) -- Line: 173
    -- upvalues: buildGui (val), LocalPlayer (val), buildArrow (val), Workspace (val), GuiService (val)
    -- upvalues: SoundService (val), MountRace (val), RunService (val)
    local u5, u6, u7, u8 = buildGui()
    a1:Add(u5)
    u5.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local u19, u20 = buildArrow()
    a1:Add(u19)
    u19.Parent = nil
    local u33 = a4:Project(a3.Root.Position, 0, a4.Length, a4.Length)
    local u34 = 0
    local u35 = 0
    local u36 = 0
    local u37 = false
    local u38 = 0
    local u39 = nil
    local u40 = 0

    local function show(a1) -- Line: 194
        -- upvalues: u37 (ref), u5 (val), u19 (val), Workspace (upval), u8 (val), GuiService (upval)
        -- upvalues: SoundService (upval), MountRace (upval)
        if a1 == u37 then
            return
        end
        u37 = a1
        if a1 then
            u5.Enabled = true
            u19.Parent = Workspace.CurrentCamera
            u8.Scale = if not GuiService.ReducedMotionEnabled then 1.35 else 1
            SoundService:PlayLocalSound(MountRace.Sounds.CountdownTick)
        end
    end

    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 207
        -- upvalues: a3 (val), u33 (ref), a4 (val), a2 (val), u40 (ref), LocalPlayer (upval), MountRace (upval)
        -- upvalues: u34 (ref), u35 (ref), u36 (ref), u37 (ref), u5 (val), u19 (val), Workspace (upval), u8 (val)
        -- upvalues: GuiService (upval), SoundService (upval), u38 (ref), u39 (ref), u6 (val), u7 (val), u20 (val)
        local v1, v2, v3
        local Root = a3.Root
        u33 = a4:Project(Root.Position, u33, 30, 80)
        local Up = a2.Up
        local LookVector = a4:FrameAt(u33 + 25).LookVector
        local v4 = LookVector - Up * LookVector:Dot(Up)
        local Unit = if not (0.001 < v4.Magnitude) then nil else v4.Unit
        if a2.StickMinRatio ~= nil then
            u40 = os.clock() + 1
        end
        local v5 = false
        if Unit ~= nil then
            v5 = false
            v4 = os.clock()
            if u40 <= v4 then
                v5 = not a2:IsHeld() and LocalPlayer:GetAttribute(MountRace.PlayerAttributes.FinishPlace) == nil
            end
        end
        v4 = false
        local v6 = false
        if v5 and Unit ~= nil then
            local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
            local v7 = AssemblyLinearVelocity - Up * AssemblyLinearVelocity:Dot(Up)
            local Unit_2 = if not (0.001 < v7.Magnitude) then nil else v7.Unit
            local Magnitude = Root.AssemblyLinearVelocity.Magnitude
            v7 = false
            if Unit_2 ~= nil then
                v7 = false
                if Magnitude > 12 then
                    v7 = (Unit_2:Dot(Unit)) < -0.3
                end
            end
            v4 = v7
            local Heading = a2.Heading
            local v8 = Heading - Up * Heading:Dot(Up)
            local Unit_3 = if not (0.001 < v8.Magnitude) then nil else v8.Unit
            v7 = false
            if Unit_3 ~= nil then
                v7 = false
                if Magnitude <= 12 then
                    v7 = (Unit_3:Dot(Unit)) < -0.5
                end
            end
            v6 = v7
        end
        u34 = if not v4 then 0 else u34 + a1
        u35 = if not v6 then 0 else u35 + a1
        u36 = if v4 then 0 else if not v6 then u36 + a1 else 0
        if v5 then
            if u34 >= 0.7 then
                if u37 ~= true then
                    u37 = true
                    u5.Enabled = true
                    u19.Parent = Workspace.CurrentCamera
                    u8.Scale = if not GuiService.ReducedMotionEnabled then 1.35 else 1
                    SoundService:PlayLocalSound(MountRace.Sounds.CountdownTick)
                end
            elseif not (u35 >= 1.5) then
                if u36 >= 0.4 and u37 ~= false then
                    u37 = false
                end
            elseif u37 ~= true then
                u37 = true
                u5.Enabled = true
                u19.Parent = Workspace.CurrentCamera
                u8.Scale = if not GuiService.ReducedMotionEnabled then 1.35 else 1
                SoundService:PlayLocalSound(MountRace.Sounds.CountdownTick)
            end
        elseif u37 ~= false then
            u37 = false
        end
        u38 = u38 + ((if not u37 then 0 else 1) - u38) * math.min(1, a1 * 8)
        if u38 < 0.01 and not u37 then
            u38 = 0
            u5.Enabled = false
            u19.Parent = nil
            u39 = nil
            return
        end
        v6 = os.clock()
        local ReducedMotionEnabled = GuiService.ReducedMotionEnabled
        v5 = if not ReducedMotionEnabled then (math.sin(v6 * 6) + 1) / 2 else 0.5
        u6.ImageTransparency = 1 - u38 * (v5 * 0.35 + 0.55)
        u7.GroupTransparency = 1 - u38
        local v9 = u8
        local Scale = v9.Scale
        v9.Scale = Scale + ((if not ReducedMotionEnabled then v5 * 0.04 else 0) + 1 - u8.Scale) * math.min(1, a1 * 10)
        if Unit == nil then
            return
        end
        v9 = (u39 or Unit):Lerp(Unit, (math.min(1, a1 * 7)))
        u39 = if not (0.001 < v9.Magnitude) then Unit else v9.Unit
        v5 = Root.Position + Up * ((if not ReducedMotionEnabled then math.sin(v6 * 3) * 0.5 else 0) + 6)
        v9 = (CFrame.lookAt(v5, v5 + u39, Up)) * CFrame.Angles(0.4886921905584123, 0, 0)
        v5 = if not ReducedMotionEnabled then v6 * 1.6 % 1 else 0
        v6 = u38 * 0.65 + 0.35
        for i, j in u20 do
            v4 = j:GetAttribute("Index")
            v3 = j:GetAttribute("Side")
            v2 = (v4 - 1 + v5) % 3
            v4 = (v2 - 1) * 2.4
            v1 = math.sin(3.141592653589793 * (math.clamp(v2 / 2.5, 0, 1)))
            v2 = Vector3.new(0, 0, -v4)
            v4 = Vector3.new(v3 * 0.6691306063588582, 0, 0.7431448254773942)
            v3 = v2 + v4 * 2.6 * v6 / 2
            j.Size = Vector3.new(0.75, 0.44999998807907104, 2.5999999046325684) * v6
            j.CFrame = v9 * CFrame.lookAt(v3, v3 + v4)
            j.Transparency = 1 - u38 * (v1 * 0.75 + 0.25)
        end
    end)
end

return v1