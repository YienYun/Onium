-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.RunHit
-- Decompile time: 15.88 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
require(ReplicatedStorage.Packages.Trove)
local u37 = {"RUN!", "RUN!!", "R UN!", "RU N!", "RUN.", "R_N!", "RUN!"}
local u49 = UDim2.fromScale(0.5, 0.125)
local u53 = UDim2.fromScale(0.55, 0.12)
local u57 = UDim2.fromScale(0.5, 0.5)
local u61 = Vector2.new(0.007, 0.01)
local u65 = Vector2.new(0.05, 0.025)
local u70 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u75 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u80 = Color3.fromRGB(8, 0, 4)
local u85 = Color3.fromRGB(255, 255, 255)
local u90 = Color3.fromRGB(14, 0, 6)
local v1 = {}

local function find(a1, a2, a3) -- Line: 74 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    if v1 ~= nil and v1:IsA(a3) then
        return v1
    end
    return nil
end

local function bind(a1, a2) -- Line: 79 -- upvalues: u49 (val) -- types: a1: userdata?, a2: userdata?
    if a1 ~= nil and a1:IsA("GuiObject") then
        local Text, v1, v2, v3, v4
        local Word = a1:FindFirstChild("Word")
        if (if Word == nil then nil else if not Word:IsA("GuiObject") then nil else Word) == nil then
            return nil
        end
        local Main = v2:FindFirstChild("Main")
        local v5 = if Main == nil then nil else if not Main:IsA("TextLabel") then nil else Main
        local v6 = {}
        for i = 1, 3 do
            v1 = v2:FindFirstChild((("Slice%*"):format(i)))
            v3 = if v1 == nil then nil else if not v1:IsA("GuiObject") then nil else v1
            if v3 == nil then
                v4 = nil
            else
                Text = v3:FindFirstChild("Text")
                v4 = if Text == nil then nil else if not Text:IsA("TextLabel") then nil else Text
            end
            if v3 ~= nil and v4 ~= nil then
                table.insert(v6, {Frame = v3, Text = v4, Stroke = v4:FindFirstChildOfClass("UIStroke")})
            end
        end
        local v7 = {Fit = 1, Root = a1}
        local Flash = a1:FindFirstChild("Flash")
        v7.Flash = if Flash == nil then nil else if not Flash:IsA("GuiObject") then nil else Flash
        local Slam = a1:FindFirstChild("Slam")
        v7.Slam = if Slam == nil then nil else if not Slam:IsA("ImageLabel") then nil else Slam
        v7.Word = v2
        local Punch = v2:FindFirstChild("Punch")
        v7.Punch = if Punch == nil then nil else if not Punch:IsA("UIScale") then nil else Punch
        v7.Main = v5
        v7.MainGradient = if v5 == nil then nil else v5:FindFirstChildOfClass("UIGradient")
        v7.MainStroke = if v5 == nil then nil else v5:FindFirstChildOfClass("UIStroke")
        local GhostRed = v2:FindFirstChild("GhostRed")
        v7.GhostRed = if GhostRed == nil then nil else if not GhostRed:IsA("TextLabel") then nil else GhostRed
        local GhostViolet = v2:FindFirstChild("GhostViolet")
        v7.GhostViolet = if GhostViolet == nil then nil else if not GhostViolet:IsA("TextLabel") then nil else GhostViolet
        v7.Slices = v6
        v7.Anchor = a2
        v7.Home = u49
        if v7.Flash ~= nil
            and v7.Slam ~= nil
            and v7.Punch ~= nil
            and v5 ~= nil
            and v7.GhostRed ~= nil
            and v7.GhostViolet ~= nil then
            return v7
        end
        return nil
    end
    return nil
end

local function easeOut(a1) -- Line: 129 -- types: a1: number
    return 1 - (1 - a1) ^ 3
end

local function easeOutBack(a1) -- Line: 133 -- types: a1: number
    local v1 = a1 - 1
    return v1 ^ 3 * 2.9 + 1 + v1 ^ 2 * 1.9
end

local function spread(a1, a2) -- Line: 139 -- types: a1: userdata, a2: number
    return a1:NextNumber(-a2, a2)
end

local function setWordText(a1, a2) -- Line: 143 -- types: a1: table, a2: string
    a1.Main.Text = a2
    a1.GhostRed.Text = a2
    a1.GhostViolet.Text = a2
    for i, j in a1.Slices do
        j.Text.Text = a2
    end
end

local function hideSlices(a1) -- Line: 152 -- types: a1: table
    for i, j in a1.Slices do
        j.Frame.Visible = false
    end
end

local function showSlices(a1, a2, a3) -- Line: 158 -- types: a1: table, a2: userdata, a3: number
    local v1, v2, v3, v4
    for i, j in a1.Slices do
        v3 = a2:NextNumber(0.1, 0.26)
        v4 = a2:NextNumber(0, 1 - v3)
        v2 = a3 * 0.07 + 0.03
        v1 = a2:NextNumber(-v2, v2)
        j.Frame.Size = UDim2.fromScale(1, v3)
        j.Frame.Position = UDim2.fromScale(v1, v4)
        j.Text.Size = UDim2.fromScale(1, 1 / v3)
        j.Text.Position = UDim2.fromScale(0, -v4 / v3)
        j.Frame.Visible = true
    end
end

local function anchorBox(a1) -- Line: 171 -- upvalues: u49 (val), u53 (val) -- types: a1: table
    local Anchor = a1.Anchor
    local AbsoluteSize = a1.Root.AbsoluteSize
    if Anchor ~= nil and not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
        local v1 = Anchor.AbsolutePosition - a1.Root.AbsolutePosition
        local AbsoluteSize_2 = Anchor.AbsoluteSize
        local v2 = AbsoluteSize_2.Y * 0.7
        return (UDim2.fromScale((v1.X + AbsoluteSize_2.X / 2) / AbsoluteSize.X, (v1.Y + v2 / 2) / AbsoluteSize.Y)), UDim2.fromScale(AbsoluteSize_2.X / AbsoluteSize.X, v2 / AbsoluteSize.Y)
    end
    return u49, u53
end

local function fitWord(a1) -- Line: 188 -- upvalues: anchorBox (val) -- types: a1: table
    local v1, v2 = anchorBox(a1)
    a1.Home = v1
    a1.Word.Position = v1
    a1.Punch.Scale = 1
    a1.Word.Size = v2
    v1 = math.max(a1.Word.AbsoluteSize.Y / 90, 1)
    a1.Fit = v1
    a1.Word.Size = UDim2.fromScale(v2.X.Scale / v1, v2.Y.Scale / v1)
    v2 = math.max(math.floor(a1.Word.AbsoluteSize.Y * 0.95), 1)
    a1.Main.TextSize = v2
    a1.GhostRed.TextSize = v2
    a1.GhostViolet.TextSize = v2
    for i, j in a1.Slices do
        j.Text.TextSize = v2
    end
end

local function applyStrokes(a1) -- Line: 206 -- types: a1: table
    local v1 = math.max(a1.Main.AbsoluteSize.Y * 0.03, 1)
    if a1.MainStroke ~= nil then
        a1.MainStroke.Thickness = v1
    end
    for i, j in a1.Slices do
        if j.Stroke ~= nil then
            j.Stroke.Thickness = v1
        end
    end
end

local function setWordTransparency(a1, a2) -- Line: 218 -- types: a1: table, a2: number
    a1.Main.TextTransparency = a2
    if a1.MainStroke ~= nil then
        a1.MainStroke.Transparency = a2
    end
    a1.GhostRed.TextTransparency = a2 * 0.8 + 0.2
    a1.GhostViolet.TextTransparency = a2 * 0.8 + 0.2
    for i, j in a1.Slices do
        j.Text.TextTransparency = a2
        if j.Stroke ~= nil then
            j.Stroke.Transparency = a2
        end
    end
end

local function impactFrame(a1, a2) -- Line: 233 -- upvalues: u80 (val), u85 (val) -- types: a1: table, a2: boolean
    local v1 = if not a2 then u85 else u80
    a1.Flash.BackgroundColor3 = v1
    a1.Flash.BackgroundTransparency = 0
    v1 = if not a2 then u80 else u85
    a1.Main.TextColor3 = v1
    if a1.MainGradient ~= nil then
        a1.MainGradient.Enabled = false
    end
    if a1.MainStroke ~= nil then
        a1.MainStroke.Transparency = 1
    end
    a1.GhostRed.Visible = false
    a1.GhostViolet.Visible = false
end

local function settleFrame(a1, a2) -- Line: 247 -- upvalues: u85 (val), u90 (val) -- types: a1: table, a2: boolean
    a1.Flash.BackgroundColor3 = u85
    a1.Main.TextColor3 = u85
    if a1.MainGradient ~= nil then
        a1.MainGradient.Enabled = true
    end
    if a1.MainStroke ~= nil then
        a1.MainStroke.Color = u90
        a1.MainStroke.Transparency = 0
    end
    a1.GhostRed.Visible = not a2
    a1.GhostViolet.Visible = not a2
end

local function reset(a1) -- Line: 261
    -- upvalues: u49 (val), u53 (val), u57 (val), setWordTransparency (val), u85 (val), u90 (val)
    a1.Root.Visible = false
    a1.Flash.BackgroundTransparency = 1
    a1.Slam.ImageTransparency = 1
    a1.Punch.Scale = 1
    a1.Fit = 1
    a1.Home = u49
    a1.Word.Size = u53
    a1.Word.Position = u49
    a1.Word.Visible = true
    a1.GhostRed.Position = u57
    a1.GhostViolet.Position = u57
    a1.Main.Text = "RUN!"
    a1.GhostRed.Text = "RUN!"
    a1.GhostViolet.Text = "RUN!"
    for i, j in a1.Slices do
        j.Text.Text = "RUN!"
    end
    setWordTransparency(a1, 0)
    a1.Flash.BackgroundColor3 = u85
    a1.Main.TextColor3 = u85
    if a1.MainGradient ~= nil then
        a1.MainGradient.Enabled = true
    end
    if a1.MainStroke ~= nil then
        a1.MainStroke.Color = u90
        a1.MainStroke.Transparency = 0
    end
    a1.GhostRed.Visible = true
    a1.GhostViolet.Visible = true
    for k, n in a1.Slices do
        n.Frame.Visible = false
    end
end

local function punchCamera(a1, a2) -- Line: 279
    -- upvalues: Workspace (val), TweenService (val), u75 (val), u70 (val), CameraShaker (val), CameraShakerDriver (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Name = "HalloweenRunHit"
    ColorCorrectionEffect.Saturation = -1
    ColorCorrectionEffect.Contrast = if not a2 then 0.9 else 0.3
    ColorCorrectionEffect.Brightness = 0.08
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 205, 205)
    ColorCorrectionEffect.Parent = CurrentCamera
    a1:Add(ColorCorrectionEffect)
    a1:Add((task.delay(0.1, function() -- Line: 293 -- upvalues: TweenService (upval), ColorCorrectionEffect (val), u75 (upval)
        TweenService:Create(ColorCorrectionEffect, u75, {Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1)}):Play()
    end)))
    if a2 then
        return
    end
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = math.max(FieldOfView - 9, 20)
    local u44 = TweenService:Create(CurrentCamera, u70, {FieldOfView = FieldOfView})
    u44:Play()
    a1:Add(function() -- Line: 310 -- upvalues: u44 (val), CurrentCamera (val), FieldOfView (val)
        if u44.PlaybackState == Enum.PlaybackState.Playing then
            u44:Cancel()
            CurrentCamera.FieldOfView = FieldOfView
        end
    end)
    local u54 = CameraShaker.new()
    CameraShakerDriver.Start(u54, Enum.RenderPriority.Last.Value)
    a1:Add(function() -- Line: 319 -- upvalues: CameraShakerDriver (upval), u54 (val)
        CameraShakerDriver.Stop(u54)
    end)
    u54:ShakeOnce(
        6,
        16,
        0,
        0.55,
        Vector3.new(0.3499999940395355, 0.3499999940395355, 0.3499999940395355),
        (Vector3.new(2.5, 1.2000000476837158, 3))
    )
    u54:ShakeOnce(
        1.1,
        22,
        0.05,
        1.6,
        Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612),
        (Vector3.new(0.800000011920929, 0.4000000059604645, 1))
    )
end

function v1.Play(a1, a2, a3) -- Line: 330
    -- upvalues: bind (val), GuiService (val), reset (val), fitWord (val), applyStrokes (val), punchCamera (val)
    -- upvalues: u85 (val), u90 (val), u80 (val), RunService (val), u61 (val), spread (val), u65 (val), u57 (val)
    -- upvalues: showSlices (val), u37 (val)
    local u6 = bind(a1, a3)
    if u6 == nil then
        return false
    end
    local v1 = a2:Extend()
    local ReducedMotionEnabled = GuiService.ReducedMotionEnabled
    local u14 = Random.new()
    reset(u6)
    v1:Add(function() -- Line: 340 -- upvalues: reset (upval), u6 (val)
        reset(u6)
    end)
    u6.Root.Visible = true
    fitWord(u6)
    applyStrokes(u6)
    punchCamera(v1, ReducedMotionEnabled)
    if not ReducedMotionEnabled then
        u6.Flash.BackgroundColor3 = u80
        u6.Flash.BackgroundTransparency = 0
        u6.Main.TextColor3 = u85
        if u6.MainGradient ~= nil then
            u6.MainGradient.Enabled = false
        end
        if u6.MainStroke ~= nil then
            u6.MainStroke.Transparency = 1
        end
        u6.GhostRed.Visible = false
        u6.GhostViolet.Visible = false
    else
        u6.Flash.BackgroundColor3 = u85
        u6.Main.TextColor3 = u85
        if u6.MainGradient ~= nil then
            u6.MainGradient.Enabled = true
        end
        if u6.MainStroke ~= nil then
            u6.MainStroke.Color = u90
            u6.MainStroke.Transparency = 0
        end
        u6.GhostRed.Visible = false
        u6.GhostViolet.Visible = false
        u6.Flash.BackgroundTransparency = 0.6
    end
    local u73 = os.clock()
    local u74 = 0
    local u75 = 0
    local u85_2 = u14:NextNumber(0.2, 0.35)
    local u86 = 0
    v1:Connect(RunService.RenderStepped, function(a1) -- Line: 359
        -- upvalues: u73 (val), ReducedMotionEnabled (val), u86 (ref), u6 (val), u85 (upval), u80 (upval), u90 (upval)
        -- upvalues: u74 (ref), u14 (val), u61 (upval), spread (upval), u65 (upval), u57 (upval), u85_2 (ref), u75 (ref)
        -- upvalues: showSlices (upval), u37 (upval)
        local v1, v2, v3
        local v4 = os.clock() - u73
        if not ReducedMotionEnabled and u86 == 0 and v4 >= 0.05 then
            u86 = 1
            v1 = u6
            v1.Flash.BackgroundColor3 = u85
            v1.Flash.BackgroundTransparency = 0
            v1.Main.TextColor3 = u80
            if v1.MainGradient ~= nil then
                v1.MainGradient.Enabled = false
            end
            if v1.MainStroke ~= nil then
                v1.MainStroke.Transparency = 1
            end
            v1.GhostRed.Visible = false
            v1.GhostViolet.Visible = false
        end
        if u86 < 2 then
            v1 = if not ReducedMotionEnabled then 0.1 else 0
            if v1 <= v4 then
                u86 = 2
                v1 = u6
                v2 = ReducedMotionEnabled
                v1.Flash.BackgroundColor3 = u85
                v1.Main.TextColor3 = u85
                if v1.MainGradient ~= nil then
                    v1.MainGradient.Enabled = true
                end
                if v1.MainStroke ~= nil then
                    v1.MainStroke.Color = u90
                    v1.MainStroke.Transparency = 0
                end
                v1.GhostRed.Visible = not v2
                v1.GhostViolet.Visible = not v2
            end
        end
        v1 = math.max(v4 - 0.1, 0)
        if u86 == 2 then
            v2 = if not ReducedMotionEnabled then 0.45 else 0.6
            v3 = 1 - (1 - (math.clamp(v1 / 0.35, 0, 1))) ^ 3
            u6.Flash.BackgroundTransparency = v2 + (1 - v2) * v3
        end
        u6.Slam.ImageTransparency = 1 - (1 - math.clamp(v1 / 1.1, 0, 1)) ^ 3
        v3 = math.clamp(v1 / 0.18, 0, 1)
        local Punch = u6.Punch
        local Fit = u6.Fit
        local v5 = 1 - (if not ReducedMotionEnabled then 2.3 else 1.15)
        v1 = v3 - 1
        Punch.Scale = Fit * (v2 + v5 * (v1 ^ 3 * 2.9 + 1 + v1 ^ 2 * 1.9))
        if ReducedMotionEnabled then
            return
        end
        u74 = u74 + a1
        if u74 < 0.03333333333333333 then
            return
        end
        u74 = 0
        v3 = (1 - math.clamp(v4 / 1.6, 0, 1)) * 0.65 + 0.35
        local Word = u6.Word
        local Home = u6.Home
        local fromScale = UDim2.fromScale
        v5 = u14
        local v6 = u61.X * v3
        Word.Position = Home + fromScale(v5:NextNumber(-v6, v6), spread(u14, u61.Y * v3))
        v2 = (u14:NextNumber(0.3, 1)) * u65.X * v3
        local v7 = u14
        local v8 = u65.Y * v3
        local v9 = v7:NextNumber(-v8, v8)
        u6.GhostRed.Position = u57 + UDim2.fromScale(-v2, v9)
        u6.GhostViolet.Position = u57 + UDim2.fromScale(v2, -v9)
        if u85_2 <= v4 then
            u75 = v4 + u14:NextNumber(0.06, 0.12)
            u85_2 = u75 + u14:NextNumber(0.14, 0.34)
        end
        if v4 < u75 then
            showSlices(u6, u14, v3)
            v7 = u6
            v8 = u37[u14:NextInteger(1, #u37)]
            v7.Main.Text = v8
            v7.GhostRed.Text = v8
            v7.GhostViolet.Text = v8
            for m, i5 in v7.Slices do
                i5.Text.Text = v8
            end
            u6.Main.TextTransparency = if not ((u14:NextNumber()) < 0.3) then 0 else 0.45
            return
        end
        for i, j in u6.Slices do
            j.Frame.Visible = false
        end
        v7 = u6
        v7.Main.Text = "RUN!"
        v7.GhostRed.Text = "RUN!"
        v7.GhostViolet.Text = "RUN!"
        for k, n in v7.Slices do
            n.Text.Text = "RUN!"
        end
        u6.Main.TextTransparency = 0
    end)
    return true
end

return v1