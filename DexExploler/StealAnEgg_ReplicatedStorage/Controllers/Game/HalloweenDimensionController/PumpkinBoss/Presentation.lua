-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Presentation
-- Decompile time: 44.89 ms

local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local ShrinePadZone = require(ReplicatedStorage.Shared.Util.ShrinePadZone)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local Kit = require(script.Parent.Kit)
local Phases = PumpkinBossState.Phases
local Attributes = PumpkinBossState.Attributes
local TrapAttributes = PumpkinBossState.TrapAttributes
local CannonAttributes = PumpkinBossState.CannonAttributes
local MemberAttribute = PumpkinBossState.MemberAttribute
local u88 = Color3.fromRGB(70, 20, 0)
local u89 = {"Assets", "UI", "HalloweenDimension"}
local u93 = {
    [Phases.KingIntro] = true,
    [Phases.King] = true,
    [Phases.Shield] = true,
    [Phases.Stunned] = true,
    [Phases.Defeated] = true,
}
local u107 = Kit.Orange:ToHex()
local u108 = {"Assets", "UI", "Notifs", "CorruptedPlate"}
local u113 = {BrokenRail = true, BrokenBracket = true}
local u118 = Color3.fromRGB(26, 12, 3)
local u123 = Color3.fromRGB(150, 255, 110)
local u124 = {
    {"BossHPBar", "BossName"},
    {"BossHPBar", "BarHolder", "HealthAmount"},
    {"BossHPBar", "BarHolder", "BarBG", "Bar"},
    {"BossHPBar", "BarHolder", "BarBG", "PhantomBar"},
    {"BossHPBar", "BarHolder", "ShieldBarHolder"},
    {"BossHPBar", "Frame", "Title"},
    {"BossHPBar", "Frame", "TimerLabel"},
    {"BossHPBar", "Countdown", "Plate", "Body"},
    {"Target", "Title"},
    {"Target", "Sub"},
    {"Target", "Countdown"},
    {"Flash"},
}
local LocalPlayer = Players.LocalPlayer
local u171 = false
local u172 = false

local function now() -- Line: 122 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function walk(a1, a2) -- Line: 126 -- types: a1: userdata, a2: table
    local v1 = a1
    local v2 = nil
    local v3 = nil
    for i, j in a2, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    return v1
end

local function label(a1, a2, a3) -- Line: 134 -- types: a1: string, a2: userdata, a3: table
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = a1
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextScaled = true
    TextLabel.TextStrokeTransparency = 0.3
    TextLabel.Text = ""
    for i, j in a3 do
        TextLabel[i] = j
    end
    TextLabel.Parent = a2
    return TextLabel
end

local function frame(a1, a2, a3) -- Line: 150 -- types: a1: string, a2: userdata, a3: table
    local Frame = Instance.new("Frame")
    Frame.Name = a1
    Frame.BorderSizePixel = 0
    for i, j in a3 do
        Frame[i] = j
    end
    Frame.Parent = a2
    return Frame
end

local function buildFallback() -- Line: 162 -- upvalues: label (val), Kit (val)
    local Frame_3
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PumpkinBossUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Enabled = false
    local v1 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.06),
        Size = UDim2.fromScale(0.42, 0.11),
    }
    local v2 = Instance.new("Frame")
    v2.Name = "BossHPBar"
    v2.BorderSizePixel = 0
    for i, j in v1 do
        v2[i] = j
    end
    v2.Parent = ScreenGui
    v1 = Instance.new("UIScale", v2)
    v1.Name = "JuiceScale"
    label("BossName", v2, {Size = UDim2.fromScale(1, 0.35), TextColor3 = Kit.Orange})
    local v3 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 0.38),
        Size = UDim2.fromScale(1, 0.32),
    }
    v1 = Instance.new("Frame")
    v1.Name = "BarHolder"
    v1.BorderSizePixel = 0
    for k, n in v3 do
        v1[k] = n
    end
    v1.Parent = v2
    local v4 = {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(30, 15, 5)}
    v3 = Instance.new("Frame")
    v3.Name = "BarBG"
    v3.BorderSizePixel = 0
    for m, i5 in v4 do
        v3[m] = i5
    end
    v3.Parent = v1
    v4 = {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1)}
    local Frame = Instance.new("Frame")
    Frame.Name = "PhantomBar"
    Frame.BorderSizePixel = 0
    for i6, i7 in v4 do
        Frame[i6] = i7
    end
    Frame.Parent = v3
    v4 = {ZIndex = 2, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Kit.Orange}
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Bar"
    Frame_2.BorderSizePixel = 0
    local v5 = nil
    for i8, i9 in v4, nil, v5 do
        Frame_2[i8] = i9
    end
    Frame_2.Parent = v3
    label("HealthAmount", v1, {ZIndex = 3, Size = UDim2.fromScale(1, 1)})
    v4 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 1.1),
        Size = UDim2.fromScale(1, 0.35),
    }
    v3 = Instance.new("Frame")
    v3.Name = "ShieldBarHolder"
    v3.BorderSizePixel = 0
    local v6 = nil
    for i10, i11 in v4, nil, v6 do
        v3[i10] = i11
    end
    v3.Parent = v1
    v1 = Instance.new("UIListLayout")
    v1.FillDirection = Enum.FillDirection.Horizontal
    v1.Padding = UDim.new(0.01, 0)
    v1.SortOrder = Enum.SortOrder.LayoutOrder
    v1.Parent = v3
    for i12 = 1, 4 do
        v6 = ("Phase%*"):format(i12)
        v5 = {
            LayoutOrder = i12,
            Size = UDim2.fromScale(0.2425, 1),
            BackgroundColor3 = Color3.fromRGB(20, 20, 40),
        }
        v1 = Instance.new("Frame")
        v1.Name = v6
        v1.BorderSizePixel = 0
        for i13, i14 in v5 do
            v1[i13] = i14
        end
        v1.Parent = v3
        v6 = {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Kit.Purple}
        Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Fill"
        Frame_3.BorderSizePixel = 0
        for i15, i16 in v6 do
            Frame_3[i15] = i16
        end
        Frame_3.Parent = v1
    end
    v4 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.78, 0),
        Size = UDim2.fromScale(0.22, 0.35),
    }
    v3 = Instance.new("Frame")
    v3.Name = "Frame"
    v3.BorderSizePixel = 0
    for i17, i18 in v4 do
        v3[i17] = i18
    end
    v3.Parent = v2
    label("Title", v3, {Size = UDim2.fromScale(0.5, 1)})
    label("TimerLabel", v3, {Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1)})
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = "Countdown"
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.Position = UDim2.fromScale(0, 1.1)
    CanvasGroup.Size = UDim2.fromScale(1, 0.4)
    CanvasGroup.Parent = v2
    v4 = {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1)}
    v2 = Instance.new("Frame")
    v2.Name = "Plate"
    v2.BorderSizePixel = 0
    for i19, i20 in v4 do
        v2[i19] = i20
    end
    v2.Parent = CanvasGroup
    label("Body", v2, {RichText = true, Size = UDim2.fromScale(1, 1)})
    v4 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.72),
        Size = UDim2.fromScale(0.4, 0.14),
    }
    v3 = Instance.new("Frame")
    v3.Name = "Target"
    v3.BorderSizePixel = 0
    for i21, i22 in v4 do
        v3[i21] = i22
    end
    v3.Parent = ScreenGui
    label("Title", v3, {Size = UDim2.fromScale(1, 0.45), TextColor3 = Kit.Orange})
    label("Sub", v3, {Position = UDim2.fromScale(0, 0.45), Size = UDim2.fromScale(1, 0.25)})
    label("Countdown", v3, {Position = UDim2.fromScale(0, 0.72), Size = UDim2.fromScale(1, 0.28)})
    v4 = {
        BackgroundTransparency = 1,
        ZIndex = 10,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
    }
    v3 = Instance.new("Frame")
    v3.Name = "Flash"
    v3.BorderSizePixel = 0
    for i23, i24 in v4 do
        v3[i23] = i24
    end
    v3.Parent = ScreenGui
    return ScreenGui
end

local function acquireGui() -- Line: 243
    -- upvalues: LocalPlayer (val), StarterGui (val), ReplicatedStorage (val), u89 (val), u124 (val), u171 (ref)
    -- upvalues: buildFallback (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local PumpkinBossUI = PlayerGui:FindFirstChild("PumpkinBossUI")
    if PumpkinBossUI and PumpkinBossUI:IsA("ScreenGui") then
        return PumpkinBossUI
    end
    local ScrambleBossUI = StarterGui:FindFirstChild("ScrambleBossUI")
    local v1 = nil
    if not ScrambleBossUI then
        if not u171 then
            u171 = true
            warn("[PumpkinBoss] StarterGui.ScrambleBossUI is missing; using fallback HUD")
        end
    elseif ScrambleBossUI:IsA("ScreenGui") then
        local v2, v3, v4
        local v5 = ScrambleBossUI:Clone()
        v5.Name = "PumpkinBossUI"
        v5.ResetOnSpawn = false
        v5.Enabled = false
        local v6 = ReplicatedStorage
        local v7 = nil
        local v8 = nil
        for i, j in u89, v7, v8 do
            v6 = v6 and v6:FindFirstChild(j)
        end
        local PumpkinCountdown = v6 and v6:FindFirstChild("PumpkinCountdown")
        v6 = v5
        v7 = {"BossHPBar", "Countdown"}
        v8 = nil
        local v9 = nil
        for k, n in v7, v8, v9 do
            v6 = v6 and v6:FindFirstChild(n)
        end
        if PumpkinCountdown and PumpkinCountdown:IsA("GuiObject") then
            local v10 = PumpkinCountdown
            v7 = {"Plate", "Body"}
            v8 = nil
            v9 = nil
            for m, i5 in v7, v8, v9 do
                v10 = v10 and v10:FindFirstChild(i5)
            end
            if v10 and v6 then
                v10 = PumpkinCountdown:Clone()
                v10.Name = "Countdown"
                v10.Parent = v6.Parent
                v6:Destroy()
            end
        end
        local v11 = nil
        v7 = nil
        for i6, i7 in u124, v11, v7 do
            v2 = v5
            v3 = nil
            v4 = nil
            for i8, i9 in i7, v3, v4 do
                v2 = v2 and v2:FindFirstChild(i9)
            end
            if v2 == nil then
                warn((("[PumpkinBoss] ScrambleBossUI is missing %*; using fallback HUD"):format((table.concat(i7, ".")))))
                v5:Destroy()
                v5 = nil
                break
            end
        end
        v1 = v5
    elseif not u171 then
        u171 = true
        warn("[PumpkinBoss] StarterGui.ScrambleBossUI is missing; using fallback HUD")
    end
    local v12 = v1 or buildFallback()
    v12.Parent = PlayerGui
    return v12
end

local function textLabel(a1) -- Line: 285 -- types: a1: userdata?
    if a1 ~= nil and a1:IsA("TextLabel") then
        return a1
    end
    return nil
end

local function frameOf(a1) -- Line: 289 -- types: a1: userdata?
    if a1 ~= nil and a1:IsA("Frame") then
        return a1
    end
    return nil
end

local function timerLabels(a1) -- Line: 294 -- types: a1: userdata
    local Title = a1:FindFirstChild("Title")
    local v1 = if Title == nil then nil else if not Title:IsA("TextLabel") then nil else Title
    local TimerLabel = a1:FindFirstChild("TimerLabel")
    local v2 = if TimerLabel == nil then nil else if not TimerLabel:IsA("TextLabel") then nil else TimerLabel
    if v1 ~= nil and v2 ~= nil then
        return v1, v2
    end
    v2 = {}
    for i, j in a1:GetChildren() do
        if j:IsA("TextLabel") then
            table.insert(v2, j)
        end
    end
    if #v2 < 2 then
        return nil, nil
    end
    table.sort(v2, function(a1, a2) -- Line: 309 -- types: a1: userdata, a2: userdata
        if a1.Position.Y.Scale ~= a2.Position.Y.Scale then
            return a1.Position.Y.Scale < a2.Position.Y.Scale
        end
        return a1.Position.Y.Offset < a2.Position.Y.Offset
    end)
    return v2[1], v2[#v2]
end

local function segmentsOf(a1) -- Line: 318 -- types: a1: userdata
    local v1 = {}
    local u2 = {}
    for i, j in a1:GetChildren() do
        if j:IsA("Frame") then
            table.insert(v1, j)
            u2[j] = i
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 327 -- upvalues: u2 (val) -- types: a1: userdata, a2: userdata
        if a1.LayoutOrder ~= a2.LayoutOrder then
            return a1.LayoutOrder < a2.LayoutOrder
        end
        return u2[a1] < u2[a2]
    end)
    for k, n in v1 do
        n.LayoutOrder = k
    end
    return v1
end

local function bindBar(a1, a2) -- Line: 340
    -- upvalues: timerLabels (val), segmentsOf (val)
    local BossHPBar = a1:FindFirstChild("BossHPBar")
    local BarHolder = BossHPBar and BossHPBar:FindFirstChild("BarHolder")
    local BarBG = BarHolder and BarHolder:FindFirstChild("BarBG")
    local BossName = BossHPBar and BossHPBar:FindFirstChild("BossName")
    local v1 = if BossName == nil then nil else if not BossName:IsA("TextLabel") then nil else BossName
    local HealthAmount = BarHolder and (BarHolder:FindFirstChild("HealthAmount") or BarHolder:FindFirstChild("TextLabel"))
    local v2 = if HealthAmount == nil then nil else if not HealthAmount:IsA("TextLabel") then nil else HealthAmount
    local Bar = BarBG and BarBG:FindFirstChild("Bar")
    local v3 = if Bar == nil then nil else if not Bar:IsA("Frame") then nil else Bar
    local PhantomBar = BarBG and BarBG:FindFirstChild("PhantomBar")
    local v4 = if PhantomBar == nil then nil else if not PhantomBar:IsA("Frame") then nil else PhantomBar
    local v5 = BarHolder and BarHolder:FindFirstChild("ShieldBarHolder")
    local v6 = BossHPBar and BossHPBar:FindFirstChild("Frame")
    if BossHPBar ~= nil
        and BossHPBar:IsA("GuiObject")
        and v1 ~= nil
        and v2 ~= nil
        and v3 ~= nil
        and v4 ~= nil
        and v5 ~= nil
        and v5:IsA("GuiObject")
        and v6 ~= nil
        and v6:IsA("GuiObject") then
        local v7, v8 = timerLabels(v6)
        if v7 ~= nil and v8 ~= nil then
            local v9
            local JuiceScale = BossHPBar:FindFirstChild("JuiceScale")
            if JuiceScale == nil or not JuiceScale:IsA("UIScale") then
                v9 = Instance.new("UIScale")
                v9.Name = "JuiceScale"
                v9.Parent = BossHPBar
            else
                v9 = JuiceScale
            end
            return {
                Gui = a1,
                Root = BossHPBar,
                BossName = v1,
                DesignedName = if not a2 then nil else v1.Text,
                HealthText = v2,
                HealthSuffix = if not a2 then "" else " HP",
                Fill = v3,
                Phantom = v4,
                ShieldHolder = v5,
                Segments = segmentsOf(v5),
                Scale = v9,
                TimerFrame = v6,
                TimerTitle = v7,
                TimerLabel = v8,
                TimerColor = v8.TextColor3,
                Top = BossHPBar.Position.Y.Scale,
                NameTop = v1.Position.Y.Scale - v1.AnchorPoint.Y * v1.Size.Y.Scale,
            }
        end
        return nil
    end
    return nil
end

local function acquireBar(a1, a2) -- Line: 401
    -- upvalues: ReplicatedStorage (val), u89 (val), CollectionService (val)
    local v1 = a1:FindFirstChild(a2)
    if v1 and v1:IsA("ScreenGui") then
        return v1
    end
    v1 = ReplicatedStorage
    local v2 = nil
    local v3 = nil
    for i, j in u89, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    local v4 = v1 and v1:FindFirstChild(a2)
    v1 = v4
    if v1 ~= nil and v1:IsA("ScreenGui") then
        v4 = v1:Clone()
        v4.ResetOnSpawn = false
        v4.Enabled = false
        v4.IgnoreGuiInset = true
        v4.ScreenInsets = Enum.ScreenInsets.None
        v1 = v4:FindFirstChild("BossHPBar")
        if v1 then
            CollectionService:AddTag(v1, "TopNotificationBlocker")
        end
        v4.Parent = v5
        return v4
    end
    return nil
end

local function acquirePhaseBars() -- Line: 428
    -- upvalues: LocalPlayer (val), acquireBar (val), bindBar (val), u172 (ref), u89 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local v1 = acquireBar(PlayerGui, "HalloweenBossHPBarP1")
    local v2 = acquireBar(PlayerGui, "HalloweenBossHPBarP2")
    local v3 = v1 and bindBar(v1, true)
    v1 = v2 and bindBar(v2, true)
    if v3 ~= nil and v1 ~= nil then
        return v3, v1
    end
    if not u172 then
        u172 = true
        warn((("[PumpkinBoss] ReplicatedStorage.%*.%* is missing or incomplete; using the old boss bar"):format(
            table.concat(u89, "."),
            if v3 ~= nil then "HalloweenBossHPBarP2" else "HalloweenBossHPBarP1"
        )))
    end
    return nil, nil
end

local function formatClock(a1) -- Line: 446 -- types: a1: number
    local v1 = math.max(math.ceil(a1), 0)
    return string.format("%02d:%02d", v1 // 60, v1 % 60)
end

local function actionHint() -- Line: 451 -- upvalues: UserInputService (val)
    local LastInputType = UserInputService:GetLastInputType()
    if LastInputType == Enum.UserInputType.Touch then
        return "Tap to FIRE!"
    end
    if string.find(LastInputType.Name, "Gamepad") then
        return "Press R2 to FIRE!"
    end
    return "Click to FIRE!"
end

local function attachCountdownPlate(a1, a2, a3) -- Line: 462
    -- upvalues: ReplicatedStorage (val), u108 (val), u118 (val), u113 (val), Kit (val)
    local v1 = ReplicatedStorage
    local v2 = nil
    local v3 = nil
    local v4, v5 = a1, a3
    for i, j in u108, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    if v1 ~= nil and v1:IsA("GuiObject") then
        local u25 = v4:Clone(v1)
        u25.Visible = false
        u25.BackgroundColor3 = u118
        u25.ZIndex = v5.ZIndex - 2
        for k, n in u25:GetChildren() do
            if n:IsA("GuiObject") then
                if not u113[n.Name] then
                    n:Destroy()
                else
                    n.BackgroundColor3 = Kit.Orange
                end
            end
        end
        local Scale = u25.Size.Y.Scale
        local u47 = {}
        for m, i5 in v5:GetChildren() do
            if i5:IsA("TextLabel") then
                table.insert(u47, i5)
            end
        end

        local function fit() -- Line: 490 -- upvalues: a2 (val), u47 (val), u25 (val), Scale (val)
            local X = a2.AbsoluteSize.X
            if X <= 0 then
                return
            end
            local v1 = 0
            for i, j in u47 do
                if j.Visible then
                    v1 = v1 + j.TextBounds.X
                end
            end
            u25.Size = UDim2.fromScale(math.clamp(v1 / X + 0.2, 0.3, 1), Scale)
        end

        for i6, i7 in u47 do
            v4:Connect(i7:GetPropertyChangedSignal("TextBounds"), fit)
            v4:Connect(i7:GetPropertyChangedSignal("Visible"), fit)
        end
        v4:Connect(a2:GetPropertyChangedSignal("AbsoluteSize"), fit)
        u25.Parent = a2
        fit()
        return u25
    end
    return nil
end

local u189 = {}
u189.__index = u189

function u189.new(a1, a2) -- Line: 518
    -- upvalues: acquireGui (val), bindBar (val), acquirePhaseBars (val), u189 (val), attachCountdownPlate (val)
    -- upvalues: LightingController (val), RunService (val)
    local u307 = acquireGui()

    local function get(a1) -- Line: 520 -- upvalues: u307 (val) -- types: a1: table
        local v1 = u307
        local v2 = nil
        local v3 = nil
        for i, j in a1, v2, v3 do
            v1 = v1 and v1:FindFirstChild(j)
        end
        return v1
    end

    local u476 = bindBar(u307, false)
    assert(u476 ~= nil, "PumpkinBossUI is missing its BossHPBar")
    local v1, v2 = acquirePhaseBars()
    local v3 = {
        PlateHeight = -1,
        PlateWidth = -1,
        DisplayedHealth = 1,
        PhantomValue = 1,
        LastHealth = -1,
        Lit = false,
        Trove = a1,
        Arena = a2,
        Gui = u307,
        Legacy = u476,
        BruteBar = v1 or u476,
        KingBar = v2 or u476,
    }
    local v4 = u307
    local v5 = {"BossHPBar", "Countdown"}
    local v6 = nil
    local v7 = nil
    local v8 = a1
    for i, j in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(j)
    end
    v3.Countdown = v4
    v4 = u307
    v5 = {"BossHPBar", "Countdown", "Plate"}
    v6 = nil
    v7 = nil
    for k, n in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(n)
    end
    v3.CountdownPlate = v4
    v4 = u307
    v5 = {"BossHPBar", "Countdown", "Plate", "Body"}
    v6 = nil
    v7 = nil
    for m, i5 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i5)
    end
    v3.CountdownBody = v4
    v4 = u307
    v5 = {"Target"}
    v6 = nil
    v7 = nil
    for i6, i7 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i7)
    end
    v3.Target = v4
    v4 = u307
    v5 = {"Target", "Title"}
    v6 = nil
    v7 = nil
    for i8, i9 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i9)
    end
    v3.TargetTitle = v4
    v4 = u307
    v5 = {"Target", "Sub"}
    v6 = nil
    v7 = nil
    for i10, i11 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i11)
    end
    v3.TargetSub = v4
    v4 = u307
    v5 = {"Target", "Countdown"}
    v6 = nil
    v7 = nil
    for i12, i13 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i13)
    end
    v3.TargetCountdown = v4
    v4 = u307
    v5 = {"Target"}
    v6 = nil
    v7 = nil
    for i14, i15 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i15)
    end
    v3.TargetTop = v4.Position.Y.Scale
    v4 = u307
    v5 = {"Flash"}
    v6 = nil
    v7 = nil
    for i16, i17 in v5, v6, v7 do
        v4 = v4 and v4:FindFirstChild(i17)
    end
    v3.Flash = v4
    v3.Juice = v8:Extend()
    local u309 = setmetatable(v3, u189)
    u476.Root.Visible = v1 == nil
    v8:Add(function() -- Line: 559 -- upvalues: u309 (val), u476 (val), u307 (val)
        u309.Countdown.Parent = u476.Root
        u476.Root.Visible = true
        for i, j in {u309.BruteBar, u309.KingBar} do
            u309:Veil(j, false)
            j.Scale.Scale = 1
            j.Root.Position = UDim2.fromScale(j.Root.Position.X.Scale, j.Top)
            if j.Gui ~= u307 then
                j.Gui.Enabled = false
            end
        end
        u309.Target.Position = UDim2.fromScale(u309.Target.Position.X.Scale, u309.TargetTop)
    end)
    u309:UseBar(u309.BruteBar)
    for i18, i19 in {"Callout", "BarTop", "BarBottom"} do
        v2 = u307:FindFirstChild(i19)
        if v2 and v2:IsA("GuiObject") then
            v2.Visible = false
        end
    end
    v1 = u307
    v4 = {"BossHPBar", "BarHolder", "BoxxIcon"}
    local v9 = nil
    v5 = nil
    for i20, i21 in v4, v9, v5 do
        v1 = v1 and v1:FindFirstChild(i21)
    end
    if v1 and v1:IsA("GuiObject") then
        v1.Visible = false
    end
    u309.CountdownBody.RichText = true
    u309.CountdownBackdrop = attachCountdownPlate(v8, u309.Countdown, u309.CountdownPlate)
    v1 = u309.TargetTitle:FindFirstChildOfClass("UIGradient")
    if v1 then
        v1.Enabled = false
    end
    u309.Target.Visible = false
    u309.Flash.BackgroundTransparency = 1
    u309.Countdown.Visible = false
    for i22, i23 in {u309.BruteBar, u309.KingBar} do
        i23.ShieldHolder.Visible = false
    end
    v8:Add(function() -- Line: 599 -- upvalues: u307 (val), u309 (val), LightingController (upval)
        u307.Enabled = false
        u309:PointBeam(nil)
        if u309.Lit then
            LightingController.ClearLayer("PumpkinBoss", 2)
        end
    end)
    v8:Connect(RunService.RenderStepped, function(a1) -- Line: 606 -- upvalues: u309 (val) -- types: a1: number
        u309:Step(a1)
    end)
    return u309
end

function u189:UseBar(a2) -- Line: 613 -- types: a2: table
    local Active = self.Active
    if Active == a2 then
        return
    end
    if Active ~= nil then
        self:Veil(Active, false)
        Active.Scale.Scale = 1
        if Active.Gui ~= self.Gui then
            Active.Gui.Enabled = false
        end
    end
    self.Juice:Clean()
    self.Active = a2
    self.Countdown.Parent = a2.Root
end

function u189:Veil(a2, a3) -- Line: 632 -- types: a2: table, a3: boolean
    local Veiled = a2.Veiled
    if a3 == (Veiled ~= nil) then
        return
    end
    if Veiled then
        for k, n in Veiled do
            k.Visible = n
        end
        a2.Veiled = nil
        return
    end
    local v1 = {}
    for i, j in a2.Root:GetChildren() do
        if j:IsA("GuiObject") and j ~= a2.TimerFrame and j ~= self.Countdown then
            v1[j] = j.Visible
            j.Visible = false
        end
    end
    a2.Veiled = v1
end

function u189.InArena(a1) -- Line: 656 -- upvalues: LocalPlayer (val), MemberAttribute (val)
    return LocalPlayer:GetAttribute(MemberAttribute) == true
end

function u189.Say(a1, a2, a3, a4) -- Line: 660
    -- upvalues: Notifications (val), Kit (val), u88 (val)
    if string.match(a2, "%S") ~= nil and a1:InArena() then
        local v1 = false
        if a3 ~= nil then
            v1 = a3 ~= ""
        end
        Notifications.Toast.Show({
            Lane = "Banner",
            SingleLine = true,
            Unique = true,
            Text = a2,
            Seconds = a4 or 2.5,
            PreText = if not v1 then nil else {Text = ("%*:"):format(a3), Color = Kit.Orange, StrokeColor = u88},
        })
        return
    end
end

function u189.FlashScreen(a1, a2, a3, a4) -- Line: 676
    -- upvalues: TweenService (val)
    a1.Flash.BackgroundColor3 = a2
    a1.Flash.BackgroundTransparency = a3
    TweenService:Create(a1.Flash, TweenInfo.new(a4), {BackgroundTransparency = 1}):Play()
end

function u189:Punch() -- Line: 682 -- upvalues: GuiService (val), TweenService (val)
    local Scale = self.Active.Scale
    if GuiService.ReducedMotionEnabled then
        return
    end
    self.Juice:Clean()
    Scale.Scale = 1.05
    local v1 = TweenService:Create(Scale, TweenInfo.new(0.18, Enum.EasingStyle.Back), {Scale = 1})
    self.Juice:Add(v1)
    v1:Play()
end

function u189:SetSegments(a2) -- Line: 695 -- types: a2: number?
    local Fill, v1
    local Active = self.Active
    Active.ShieldHolder.Visible = a2 ~= nil
    if a2 == nil then
        return
    end
    local v2 = nil
    local v3 = nil
    for i, j in Active.Segments, v2, v3 do
        Fill = j:FindFirstChild("Fill")
        if Fill then
            v1 = math.clamp(a2 * #Active.Segments - (i - 1), 0, 1)
            Fill.Visible = v1 > 0
            Fill.Size = UDim2.fromScale(v1, 1)
        end
    end
end

local function uiScale(a1) -- Line: 713 -- types: a1: userdata
    local UIScale
    local v1 = 1
    local Parent = a1
    while Parent do
        UIScale = Parent:FindFirstChildOfClass("UIScale")
        if UIScale then
            v1 = v1 * UIScale.Scale
        end
        Parent = Parent.Parent
    end
    return (math.max(v1, 0.01))
end

local function fitText(a1, a2, a3) -- Line: 726 -- types: a1: userdata, a2: number, a3: number
    a1.TextSize = a2
    local X = a1.TextBounds.X
    if not (X <= a3) and not (X <= 0) then
        local v1 = math.max(math.floor(a2 * a3 / X), 1)
        a1.TextSize = v1
        while v1 > 1 do
            if not (a3 < a1.TextBounds.X) then
                break
            end
            v1 = v1 - 1
            a1.TextSize = v1
        end
        return
    end
end

function u189:SetCountdown(a2, a3) -- Line: 742
    -- upvalues: uiScale (val), fitText (val)
    self.Countdown.Visible = a2 ~= nil
    if a2 == nil then
        return
    end
    local CountdownBackdrop = self.CountdownBackdrop
    local v1 = a3 == true
    if CountdownBackdrop and CountdownBackdrop.Visible ~= v1 then
        CountdownBackdrop.Visible = v1
    end
    local CountdownBody = self.CountdownBody
    if CountdownBody.Text ~= a2 then
        CountdownBody.Text = a2
    end
    local Y = self.CountdownPlate.AbsoluteSize.Y
    local X = self.Countdown.AbsoluteSize.X
    if Y > 0 and X > 0 then
        local v2
        if v2 or Y ~= self.PlateHeight or X ~= self.PlateWidth then
            self.PlateHeight = Y
            self.PlateWidth = X
            fitText(CountdownBody, math.clamp(math.floor(Y / (uiScale(CountdownBody)) * 1), 1, 100), X * 0.8)
        end
    end
end

function u189:ClearTopbar(a2) -- Line: 773 -- upvalues: GuiService (val) -- types: a2: table
    local Root = a2.Root
    local AbsoluteSize = a2.Gui.AbsoluteSize
    local v1 = math.max(a2.Scale.Scale, 0.01)
    local v2 = Root.AbsoluteSize.X / v1
    local v3 = Root.AbsoluteSize.Y / v1
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) and not (v2 <= 0) then
        local TopbarInset = GuiService.TopbarInset
        local v4 = AbsoluteSize.X * Root.Position.X.Scale - v2 * Root.AnchorPoint.X
        local v5 = true
        if not (v4 < TopbarInset.Min.X) then
            v5 = TopbarInset.Max.X < v4 + v2
        end
        v4 = AbsoluteSize.Y * a2.Top + v3 * (a2.NameTop - Root.AnchorPoint.Y)
        v5 = a2.Top + (if not v5 then 0 else (math.max(TopbarInset.Max.Y - v4, 0)) / AbsoluteSize.Y)
        if Root.Position.Y.Scale ~= v5 then
            Root.Position = UDim2.fromScale(Root.Position.X.Scale, v5)
        end
        v5 = self.TargetTop + v3
        if self.Target.Position.Y.Scale ~= v5 then
            self.Target.Position = UDim2.fromScale(self.Target.Position.X.Scale, v5)
        end
        return
    end
end

function u189:SetTarget(a2, a3, a4, a5) -- Line: 798 -- types: a2: string?, a3: string?, a4: string?, a5: userdata?
    self.Target.Visible = a2 ~= nil
    if a2 == nil then
        return
    end
    self.TargetTitle.Text = a2
    self.TargetTitle.TextColor3 = a5 or Color3.new(1, 1, 1)
    self.TargetSub.Text = a3 or ""
    self.TargetCountdown.Text = a4 or ""
end

local function myCannon(a1) -- Line: 810
    -- upvalues: PumpkinBossState (val), CannonAttributes (val), LocalPlayer (val)
    local OwnerUserId
    local v1 = a1:FindFirstChild(PumpkinBossState.CannonFolder)
    if v1 == nil then
        return nil
    end
    for i, j in v1:GetChildren() do
        OwnerUserId = CannonAttributes.OwnerUserId
        if (j:GetAttribute(OwnerUserId)) == LocalPlayer.UserId then
            return j
        end
    end
    return nil
end

local function trappedTeammate(a1) -- Line: 824
    -- upvalues: PumpkinBossState (val), LocalPlayer (val), TrapAttributes (val), Players (val)
    local PlayerByUserId, TrapUserId, v1
    local v2 = a1:FindFirstChild(PumpkinBossState.VineFolder)
    if v2 == nil then
        return nil
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v3 = nil
    local v4 = (1 / 0)
    for i, j in v2:GetChildren() do
        TrapUserId = TrapAttributes.TrapUserId
        v1 = j:GetAttribute(TrapUserId)
        PlayerByUserId = if typeof(v1) ~= "number" then nil else Players:GetPlayerByUserId(v1)
        if PlayerByUserId and PlayerByUserId ~= LocalPlayer and j:IsA("BasePart") then
            if (if not HumanoidRootPart then 0 else (j.Position - HumanoidRootPart.Position).Magnitude) < v4 then
                v3 = PlayerByUserId
            end
        end
    end
    return v3
end

function u189:PointBeam(a2) -- Line: 847 -- upvalues: TutorialBeam (val) -- types: a2: userdata?
    if a2 == self.BeamTarget then
        return
    end
    self.BeamTarget = a2
    if a2 == nil then
        if not self.Beam then
            return
        end
        TutorialBeam.Destroy(self.Beam)
        self.Beam = nil
        return
    end
    if self.Beam then
        TutorialBeam.Retarget(self.Beam, a2)
        return
    end
    self.Beam = TutorialBeam.Attach(a2)
end

function u189:UpdateBeam(a2) -- Line: 866
    -- upvalues: Phases (val), myCannon (val), CannonAttributes (val)
    local v1 = if a2 == Phases.Shield then myCannon(self.Arena) else if a2 ~= Phases.Stunned then nil else myCannon(self.Arena)
    local v2 = nil
    if v1 then
        local OperatorZone = v1:FindFirstChild("OperatorZone")
        local PrimaryPart = v1.PrimaryPart or v1:FindFirstChildWhichIsA("BasePart", true)
        v2 = if v1:GetAttribute(CannonAttributes.Ready) ~= true then PrimaryPart else if not OperatorZone then PrimaryPart else if not OperatorZone:IsA("BasePart") then PrimaryPart else OperatorZone
    end
    self:PointBeam(v2)
end

function u189:UpdateTarget(a2, a3) -- Line: 877
    -- upvalues: LocalPlayer (val), TrapAttributes (val), Kit (val), Phases (val), myCannon (val)
    -- upvalues: CannonAttributes (val), u123 (val), ShrinePadZone (val), UserInputService (val), trappedTeammate (val)
    local v1
    local Attribute = LocalPlayer:GetAttribute(TrapAttributes.TrapEnds)
    if typeof(Attribute) == "number" and a3 < Attribute then
        self:SetTarget("ROOTED!", "A teammate can bash you free!", string.format("%.1f", Attribute - a3), Kit.Red)
        return
    end
    if a2 ~= Phases.Shield and a2 ~= Phases.Stunned then
        v1 = trappedTeammate(self.Arena)
        if v1 then
            self:SetTarget(("SAVE %*!"):format((string.upper(v1.DisplayName))), "Smash the vines to free them", nil, u123)
            return
        end
        self:SetTarget(nil)
        return
    end
    local v2 = myCannon(self.Arena)
    if not v2 then
        v1 = trappedTeammate(self.Arena)
        if v1 then
            self:SetTarget(("SAVE %*!"):format((string.upper(v1.DisplayName))), "Smash the vines to free them", nil, u123)
            return
        end
        self:SetTarget(nil)
        return
    end
    if v2:GetAttribute(CannonAttributes.Ready) ~= true then
        self:SetTarget("FREE YOUR CANNON!", "Smash the roots with your bat!", nil, u123)
        return
    end
    local OperatorZone = v2:FindFirstChild("OperatorZone")
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if OperatorZone and HumanoidRootPart and ShrinePadZone.ContainsPoint(OperatorZone, HumanoidRootPart.Position) then
        local v3 = if a2 ~= Phases.Shield then "Fire at the stunned King!" else "Break the King's shield!"
        local LastInputType = UserInputService:GetLastInputType()
        self:SetTarget(
            if LastInputType ~= Enum.UserInputType.Touch then if not string.find(LastInputType.Name, "Gamepad") then "Click to FIRE!" else "Press R2 to FIRE!" else "Tap to FIRE!",
            v3,
            nil,
            Kit.Orange
        )
        return
    end
    self:SetTarget("MAN YOUR CANNON!", "Stand on your cannon's pad", nil, Kit.Orange)
end

function u189:UpdateTimer(a2, a3) -- Line: 916
    -- upvalues: Attributes (val), Phases (val), PumpkinBossFlags (val), Kit (val)
    local v1
    local Active = self.Active
    local Attribute = self.Arena:GetAttribute(Attributes.EndsAt)
    local v2 = false
    if typeof(Attribute) == "number" then
        v2 = Attribute > 0
    end
    local Visible = self.Countdown.Visible
    if not Visible then
        Visible = true
        if self.Arena:GetAttribute(Attributes.Scene) ~= "BruteRise" then
            Visible = false
            if a2 == Phases.Defeated then
                Visible = not v2
            end
        end
    end
    Active.TimerFrame.Visible = not Visible
    if Visible then
        return
    end
    Active.TimerTitle.Text = "Time Left"
    local TimerLabel = Active.TimerLabel
    local v3 = math.max(math.ceil(if not v2 then PumpkinBossFlags.FightSeconds:Get() else math.max(Attribute - a3, 0)), 0)
    TimerLabel.Text = string.format("%02d:%02d", v3 // 60, v3 % 60)
    local TimerLabel_2 = Active.TimerLabel
    local Red = if not v2 then Active.TimerColor else if not (v1 <= 60) then Active.TimerColor else Kit.Red
    TimerLabel_2.TextColor3 = Red
end

function u189:Step(a2) -- Line: 934
    -- upvalues: LightingController (val), Attributes (val), Phases (val), u93 (val), Workspace (val), u107 (val)
    local v1 = self:InArena()
    self.Gui.Enabled = v1
    if v1 ~= self.Lit then
        self.Lit = v1
        if not v1 or not LightingController.Presets.PumpkinBoss then
            LightingController.ClearLayer("PumpkinBoss", 2)
        else
            LightingController.SetLayer("PumpkinBoss", "PumpkinBoss", 170, 2)
        end
    end
    local Arena = self.Arena
    local Attribute = Arena:GetAttribute(Attributes.Phase) or Phases.Waiting
    local v2 = true
    if (Arena:GetAttribute(Attributes.Boss)) ~= "King" then
        v2 = u93[Attribute] == true
    end
    self:UseBar(if not v2 then self.BruteBar else self.KingBar)
    local Active = self.Active
    Active.Gui.Enabled = v1
    if not v1 then
        self:PointBeam(nil)
        return
    end
    self:ClearTopbar(Active)
    local v3 = true
    if Attribute ~= Phases.Waiting then
        v3 = Arena:GetAttribute(Attributes.Scene) ~= nil
    end
    self:Veil(Active, v3)
    v1 = Workspace:GetServerTimeNow()
    local v4 = Arena:GetAttribute(Attributes.Health) or 0
    local v5 = math.max(Arena:GetAttribute(Attributes.MaxHealth) or 1, 1)
    Active.BossName.Text = if Attribute ~= Phases.Waiting then if Active.DesignedName == nil then if not v2 then "PUMPKIN BRUTE" else "PUMPKIN KING" else Active.DesignedName else if Active.DesignedName == nil then "THE PUMPKIN PATCH" else "The Pumpkin Patch"
    v2 = if Attribute == Phases.Waiting then 1 else if Attribute ~= Phases.BruteIntro then math.clamp(v4 / v5, 0, 1) else 1
    if v4 ~= self.LastHealth then
        if 0 <= self.LastHealth and v4 < self.LastHealth then
            self:Punch()
        end
        self.LastHealth = v4
    end
    self.DisplayedHealth = self.DisplayedHealth + (v2 - self.DisplayedHealth) * math.min(a2 * 12, 1)
    local DisplayedHealth_2 = if not (self.PhantomValue < self.DisplayedHealth) then self.PhantomValue + (self.DisplayedHealth - self.PhantomValue) * math.min(a2 * 2.5, 1) else self.DisplayedHealth
    self.PhantomValue = DisplayedHealth_2
    Active.Fill.Size = UDim2.fromScale(self.DisplayedHealth, Active.Fill.Size.Y.Scale)
    Active.Phantom.Size = UDim2.fromScale(self.PhantomValue, Active.Phantom.Size.Y.Scale)
    Active.HealthText.Text = if Attribute ~= Phases.Waiting then ("%* / %*%*"):format(math.ceil(v4), math.ceil(v5), Active.HealthSuffix) else "Waiting for challengers..."
    local Attribute_3 = Arena:GetAttribute(Attributes.ShieldMax)
    if Arena:GetAttribute(Attributes.ShieldActive) ~= true
        or typeof(Attribute_3) ~= "number"
        or not (Attribute_3 > 0) then
        self:SetSegments(nil)
    else
        self:SetSegments((math.clamp((Arena:GetAttribute(Attributes.ShieldHealth) or 0) / Attribute_3, 0, 1)))
    end
    v4 = Arena:GetAttribute(Attributes.SpawnsAt)
    v2 = Arena:GetAttribute(Attributes.StunEnds)
    if Attribute ~= Phases.Waiting or typeof(v4) ~= "number" then
        if Attribute ~= Phases.Stunned or typeof(v2) ~= "number" then
            if Attribute ~= Phases.Shield then
                self:SetCountdown(nil)
            else
                self:SetCountdown((("Shield <b>%*</b> / %* - fire the cannons!"):format((Arena:GetAttribute(Attributes.ShieldHealth)) or 0, Attribute_3 or 0)))
            end
        elseif v1 < v2 then
            self:SetCountdown((("STUNNED! <b>%*</b>s - keep shooting at him!"):format((string.format("%.1f", v2 - v1)))))
        elseif Attribute ~= Phases.Shield then
            self:SetCountdown(nil)
        else
            self:SetCountdown((("Shield <b>%*</b> / %* - fire the cannons!"):format((Arena:GetAttribute(Attributes.ShieldHealth)) or 0, Attribute_3 or 0)))
        end
    elseif v1 < v4 then
        local v6 = math.ceil(v4 - v1)
        self:SetCountdown(
            ("The battle will begin in <font color=\"#%*\">%*</font> %*"):format(u107, v6, if v6 ~= 1 then "seconds" else "second"),
            true
        )
    elseif Attribute ~= Phases.Stunned or typeof(v2) ~= "number" then
        if Attribute ~= Phases.Shield then
            self:SetCountdown(nil)
        else
            self:SetCountdown((("Shield <b>%*</b> / %* - fire the cannons!"):format((Arena:GetAttribute(Attributes.ShieldHealth)) or 0, Attribute_3 or 0)))
        end
    elseif v1 < v2 then
        self:SetCountdown((("STUNNED! <b>%*</b>s - keep shooting at him!"):format((string.format("%.1f", v2 - v1)))))
    elseif Attribute ~= Phases.Shield then
        self:SetCountdown(nil)
    else
        self:SetCountdown((("Shield <b>%*</b> / %* - fire the cannons!"):format((Arena:GetAttribute(Attributes.ShieldHealth)) or 0, Attribute_3 or 0)))
    end
    self:UpdateTimer(Attribute, v1)
    self:UpdateTarget(Attribute, v1)
    self:UpdateBeam(Attribute)
end

return u189