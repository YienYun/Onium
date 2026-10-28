-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController.SoulsHud
-- Decompile time: 15.26 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Hud = require(ReplicatedStorage.Client.Hud)
local u42 = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u47 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u48 = nil
local u49 = {}
local u50 = 0
local u51 = 0
local u52 = false
local u53 = nil
local u54 = 0
local u55 = 0
local u56 = nil
local u58 = Random.new()
local v1 = {}

local function sound(...) -- Line: 75 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    for i, j in {...} do
        Assets = if not Assets then nil else Assets:FindFirstChild(j)
    end
    if Assets and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function child(a1, a2, a3) -- Line: 83 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    if v1 and v1:IsA(a3) then
        return v1
    end
    return nil
end

local function bind() -- Line: 88 -- upvalues: u48 (ref), Hud (val)
    if u48 and u48.Slot.Parent then
        return u48
    end
    local success, err = pcall(Hud.Frame, "Game")
    if not success then
        return nil
    end
    local v1 = err:FindFirstChild("BottomLeft")
    local v2 = v1
    if v2 then
        local Souls = v1:FindFirstChild("Souls")
        v2 = if not Souls then nil else if not Souls:IsA("GuiObject") then nil else Souls
    end
    v1 = v2
    if v1 then
        local Row = v2:FindFirstChild("Row")
        v1 = if not Row then nil else if not Row:IsA("GuiObject") then nil else Row
    end
    local v3 = v1
    if v3 then
        local Icon = v1:FindFirstChild("Icon")
        v3 = if not Icon then nil else if not Icon:IsA("GuiObject") then nil else Icon
    end
    local v4 = v1
    if v4 then
        local Value = v1:FindFirstChild("Value")
        v4 = if not Value then nil else if not Value:IsA("TextLabel") then nil else Value
    end
    local v5 = v2
    if v5 then
        local FlyIcon = v2:FindFirstChild("FlyIcon")
        v5 = if not FlyIcon then nil else if not FlyIcon:IsA("GuiObject") then nil else FlyIcon
    end
    if v2 ~= nil and v1 ~= nil and v3 ~= nil and v4 ~= nil and v5 ~= nil then
        local Pulse = v3:FindFirstChild("Pulse")
        local v6 = if not Pulse then nil else if not Pulse:IsA("UIScale") then nil else Pulse
        if v6 == nil then
            v6 = Instance.new("UIScale")
            v6.Name = "Pulse"
            v6.Parent = v3
        end
        local v7 = {
            Screen = Hud.Screen(),
            Slot = v2,
            Row = v1,
            Icon = v3,
            IconScale = v6,
        }
        local Glow = v1:FindFirstChild("Glow")
        v7.Glow = if not Glow then nil else if not Glow:IsA("ImageLabel") then nil else Glow
        v7.Value = v4
        local Pulse_2 = v4:FindFirstChild("Pulse")
        v7.ValueScale = if not Pulse_2 then nil else if not Pulse_2:IsA("UIScale") then nil else Pulse_2
        v7.FlyIcon = v5
        return v7
    end
    warn("HUD.GameHUD.BottomLeft.Souls needs Row.Icon, Row.Value and FlyIcon")
    return nil
end

local function format(a1) -- Line: 126 -- upvalues: Simple (val) -- types: a1: number
    local v1 = math.max(math.floor(a1 + 0.5), 0)
    if v1 > 99999 then
        return (Simple.FormatCompact(v1))
    end
    return (Simple.Format(v1))
end

local function setting(a1, a2, a3) -- Line: 133 -- types: a1: table, a2: string, a3: number
    local Attribute = a1.Slot:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

local function slide(a1, a2) -- Line: 138
    -- upvalues: u53 (ref), TweenService (val), u52 (ref)
    local v1
    local v2 = u53
    if v2 then
        v2:Cancel()
    end
    local Attribute = a1.Slot:GetAttribute("SlideSeconds")
    v2 = if type(Attribute) ~= "number" then 0.45 else Attribute
    if not a2 then
        local Attribute_3 = a1.Slot:GetAttribute("HiddenX")
        v1 = if type(Attribute_3) ~= "number" then -0.8 else Attribute_3
    else
        local Attribute_2 = a1.Slot:GetAttribute("ShownX")
        v1 = if type(Attribute_2) ~= "number" then 0.5 else Attribute_2
    end
    local Position = a1.Row.Position
    if a2 then
        a1.Slot.Visible = true
    end
    local v3 = TweenService
    local Row = a1.Row
    local v4 = {Position = UDim2.new(v1, 0, Position.Y.Scale, 0)}
    v3 = v3:Create(
        Row,
        if not a2 then TweenInfo.new(v2 * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In) else TweenInfo.new(v2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        v4
    )
    u53 = v3
    v3.Completed:Connect(function(a1_2) -- Line: 156 -- upvalues: a2 (val), u52 (upval), a1 (val)
        if a1_2 == Enum.PlaybackState.Completed and not a2 and not u52 then
            a1.Slot.Visible = false
        end
    end)
    v3:Play()
end

local function show(a1) -- Line: 164
    -- upvalues: u52 (ref), u55 (ref), u51 (ref), u50 (ref), Simple (val), slide (val)
    if u52 then
        return
    end
    u52 = true
    u55 = 0
    u51 = u50
    local Value = a1.Value
    local v1 = math.max(math.floor(u51 + 0.5), 0)
    Value.Text = if not (v1 > 99999) then Simple.Format(v1) else Simple.FormatCompact(v1)
    slide(a1, true)
end

local function hide(a1) -- Line: 175 -- upvalues: u52 (ref), slide (val) -- types: a1: table
    if not u52 then
        return
    end
    u52 = false
    slide(a1, false)
end

local function screenPoint(a1, a2) -- Line: 183 -- upvalues: Workspace (val) -- types: a1: table, a2: vector
    local CurrentCamera = Workspace.CurrentCamera
    local AbsoluteSize = a1.Screen.AbsoluteSize
    if CurrentCamera == nil then
        return AbsoluteSize / 2
    end
    local v1, v2 = CurrentCamera:WorldToViewportPoint(a2)
    local v3 = (Vector2.new(v1.X, v1.Y)) - a1.Screen.AbsolutePosition
    if v1.Z < 0 then
        return (Vector2.new(AbsoluteSize.X - v3.X, AbsoluteSize.Y))
    end
    if not v2 then
        v3 = Vector2.new(math.clamp(v3.X, 0, AbsoluteSize.X), (math.clamp(v3.Y, 0, AbsoluteSize.Y)))
    end
    return v3
end

local function bezier(a1, a2, a3, a4) -- Line: 199 -- types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function pulse(a1) -- Line: 204
    -- upvalues: GuiService (val), TweenService (val), u42 (val), u47 (val)
    if GuiService.ReducedMotionEnabled then
        return
    end
    a1.IconScale.Scale = 1.45
    TweenService:Create(a1.IconScale, u42, {Scale = 1}):Play()
    local ValueScale = a1.ValueScale
    if ValueScale then
        ValueScale.Scale = 1.18
        TweenService:Create(ValueScale, u42, {Scale = 1}):Play()
    end
    local Glow = a1.Glow
    if Glow then
        Glow.ImageTransparency = 0.15
        TweenService:Create(Glow, u47, {ImageTransparency = 1}):Play()
    end
end

local function arrive(a1, a2) -- Line: 222
    -- upvalues: u50 (ref), u54 (ref), u55 (ref), pulse (val), sound (val), Audio (val)
    u50 = u50 + a2.Value
    os.clock()
    u55 = u55 + 1
    pulse(a1)
    local v1 = sound("Sounds", "LightVsDarknessSounds", "CollectNormalRing")
    if v1 then
        Audio.Play(v1, script, {Volume = 0.45, PlaybackSpeed = math.min(u55 * 0.025 + 1, 1.6)})
    end
end

local function step(a1) -- Line: 236
    -- upvalues: u48 (ref), u49 (val), arrive (val), u50 (ref), u51 (ref), Simple (val), u52 (ref), u54 (ref)
    -- upvalues: slide (val)
    local From, Pop, v1, v2, v3, v4, v5, v6, v7
    local v8 = u48
    if v8 == nil then
        return
    end
    local v9 = os.clock()
    local AbsoluteSize = v8.Screen.AbsoluteSize
    local v10 = v8.Icon.AbsolutePosition + v8.Icon.AbsoluteSize / 2 - v8.Screen.AbsolutePosition
    for i = #u49, 1, -1 do
        v6 = u49[i]
        v7 = math.clamp((v9 - v6.Born) / v6.Duration, 0, 1)
        v1 = if not (v7 < 0.5) then 1 - (v7 * -2 + 2) ^ 3 / 2 else v7 ^ 3 * 4
        From = v6.From
        v2 = v10 - From
        v3 = Vector2.new(-v2.Y, v2.X)
        v4 = (From + v10) / 2 + v3 * v6.Bend - Vector2.new(0, v2.Magnitude * 0.2)
        v2 = 1 - v1
        v3 = From * (v2 * v2) + v4 * (v2 * 2 * v1) + v10 * (v1 * v1)
        v6.Icon.Position = UDim2.fromScale(v3.X / AbsoluteSize.X, v3.Y / AbsoluteSize.Y)
        v6.Icon.Rotation = v6.Spin * (1 - v7)
        Pop = v6.Pop
        if Pop then
            v5 = if not (v7 < 0.3) then (v7 - 0.3) / 0.7 * -0.7500000000000001 + 1.35 else v7 / 0.3 * 0.9000000000000001 + 0.45
            Pop.Scale = v5
        end
        if v7 >= 1 then
            v6.Icon:Destroy()
            table.remove(u49, i)
            arrive(v8, v6)
        end
    end
    if 0.01 < (math.abs(u50 - u51)) then
        u51 = u51 + (u50 - u51) * (1 - math.exp(a1 * -14))
        if (math.abs(u50 - u51)) < 0.5 then
            u51 = u50
        end
        local Value = v8.Value
        v10 = math.max(math.floor(u51 + 0.5), 0)
        Value.Text = if not (v10 > 99999) then Simple.Format(v10) else Simple.FormatCompact(v10)
    end
    local Attribute = v8.Slot:GetAttribute("HoldSeconds")
    local v11 = if type(Attribute) ~= "number" then 3 else Attribute
    if u52 and #u49 == 0 and v11 <= v9 - u54 then
        if not u52 then
            return
        end
        u52 = false
        slide(v8, false)
    end
end

local function ensureStepping() -- Line: 282 -- upvalues: u56 (ref), RunService (val), step (val)
    if u56 == nil then
        RunService.RenderStepped:Connect(step)
    end
end

function v1.Prime(a1) -- Line: 292 -- upvalues: u52 (ref), u49 (val), u50 (ref), u51 (ref) -- types: a1: number
    if not u52 and not (#u49 > 0) then
        u50 = math.max(a1, 0)
        u51 = u50
        return
    end
end

function v1.Collect(a1, a2) -- Line: 300
    -- upvalues: bind (val), u56 (ref), RunService (val), step (val), u52 (ref), u55 (ref), u51 (ref), u50 (ref)
    -- upvalues: Simple (val), slide (val), u54 (ref), u49 (val), screenPoint (val), u58 (val), sound (val), Audio (val)
    local v1 = bind()
    if v1 == nil then
        return
    end
    if u56 == nil then
        RunService.RenderStepped:Connect(step)
    end
    if not u52 then
        u52 = true
        u55 = 0
        u51 = u50
        local Value = v1.Value
        local v2 = math.max(math.floor(u51 + 0.5), 0)
        Value.Text = if not (v2 > 99999) then Simple.Format(v2) else Simple.FormatCompact(v2)
        slide(v1, true)
    end
    u54 = os.clock()
    local v3 = u49[#u49]
    if v3 and u54 - v3.Born < 0.05 then
        v3.Value = v3.Value + a2
        return
    end
    v3 = v1.FlyIcon:Clone()
    v3.Name = "SoulFlyIcon"
    v3.Visible = true
    v3.AnchorPoint = Vector2.new(0.5, 0.5)
    local v4 = screenPoint(v1, a1)
    local AbsoluteSize = v1.Screen.AbsoluteSize
    v3.Position = UDim2.fromScale(v4.X / AbsoluteSize.X, v4.Y / AbsoluteSize.Y)
    v3.ZIndex = 50
    v3.Parent = v1.Screen
    local v5 = {Icon = v3}
    local v6 = v3:FindFirstChild("Pop")
    v5.Pop = if not v6 then nil else if not v6:IsA("UIScale") then nil else v6
    v5.From = v4
    v5.Born = os.clock()
    v5.Duration = u58:NextNumber(0.5, 0.78)
    v5.Bend = (u58:NextNumber(0.18, 0.42)) * (if not ((u58:NextNumber()) < 0.5) then 1 else -1)
    v5.Spin = u58:NextNumber(-90, 90)
    v5.Value = a2
    table.insert(u49, v5)
    v4 = sound("ShootingStar", "Sounds", "StarCollect")
    if v4 then
        Audio.Play(v4, script, {Volume = 0.3, PlaybackSpeed = {1.15, 1.35}})
    end
end

function v1.IconViewportPoint() -- Line: 338 -- upvalues: bind (val), GuiService (val)
    local v1 = bind()
    if v1 == nil then
        return nil
    end
    local v2 = v1.Icon.AbsolutePosition + v1.Icon.AbsoluteSize / 2
    if v1.Screen.IgnoreGuiInset then
        return v2
    end
    return v2 + GuiService:GetGuiInset()
end

function v1.Reset() -- Line: 351 -- upvalues: u49 (val), u48 (ref), u52 (ref)
    for i, j in u49 do
        j.Icon:Destroy()
    end
    table.clear(u49)
    local v1 = u48
    if v1 then
        u52 = false
        v1.Slot.Visible = false
        local Row = v1.Row
        local new = UDim2.new
        local Attribute = v1.Slot:GetAttribute("HiddenX")
        Row.Position = new(if type(Attribute) ~= "number" then -0.8 else Attribute, 0, v1.Row.Position.Y.Scale, 0)
    end
end

return v1