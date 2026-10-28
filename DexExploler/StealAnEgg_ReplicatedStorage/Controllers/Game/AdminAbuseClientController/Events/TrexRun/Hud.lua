-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.TrexRun.Hud
-- Decompile time: 5.41 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local u24 = Color3.fromRGB(255, 120, 40)
local u29 = Color3.fromRGB(255, 50, 50)
local u30 = {}

local function tween(a1, a2, a3, a4) -- Line: 49
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

local function cloneGui(a1) -- Line: 66 -- upvalues: Players (val), StarterGui (val) -- types: a1: string
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v1 = PlayerGui:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("ScreenGui") then
        return v1
    end
    v1 = StarterGui:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("ScreenGui") then
        local v2 = v1:Clone()
        v2.Parent = PlayerGui
        return v2
    end
    warn((("[TrexRun] StarterGui.%* is missing"):format(a1)))
    return nil
end

local function pop(a1) -- Line: 88 -- upvalues: GuiService (val), TweenService (val) -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil and not GuiService.ReducedMotionEnabled then
        UIScale.Scale = 1.25
        local Back = Enum.EasingStyle.Back
        local new = TweenInfo.new
        TweenService:Create(UIScale, new(0.35, Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
end

function u30.Mount() -- Line: 101 -- upvalues: cloneGui (val)
    local TrexRunUI = cloneGui("TrexRunUI")
    local TrexRunOverlay = cloneGui("TrexRunOverlay")
    local TrexRunCinematic = cloneGui("TrexRunCinematic")
    if TrexRunUI ~= nil and TrexRunOverlay ~= nil and TrexRunCinematic ~= nil then
        local Objective = TrexRunUI:FindFirstChild("Objective")
        local BarHolder = Objective:FindFirstChild("BarHolder")
        local Bar = (BarHolder:FindFirstChild("BarBG")):FindFirstChild("Bar")
        local v1 = {
            BarAlpha = -1,
            BarText = "",
            TitleText = "",
            Shown = false,
            Danger = 0,
            FlashUntil = 0,
            Clock = 0,
            Gui = TrexRunUI,
            Overlay = TrexRunOverlay,
            Cinematic = TrexRunCinematic,
            Card = Objective,
            Title = Objective:FindFirstChild("Title"),
            Bar = Bar,
            BarLabel = BarHolder:FindFirstChild("TextLabel"),
            BarHeight = Bar.Size.Y.Scale,
            Vignette = TrexRunOverlay:FindFirstChild("Vignette"),
            Top = TrexRunCinematic:FindFirstChild("Top"),
            Bottom = TrexRunCinematic:FindFirstChild("Bottom"),
            ShownPosition = Objective.Position,
        }
        Objective.Position = UDim2.fromScale(Objective.Position.X.Scale, -0.2)
        v1.Vignette.ImageTransparency = 1
        v1.Top.Position = UDim2.fromScale(0, -0.11)
        v1.Bottom.Position = UDim2.fromScale(0, 1)
        TrexRunUI.Enabled = true
        TrexRunOverlay.Enabled = true
        TrexRunCinematic.Enabled = true
        return v1
    end
    return nil
end

function u30.SetBoardShown(a1, a2) -- Line: 147 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean
    if a1.Shown == a2 then
        return
    end
    a1.Shown = a2
    local Card = a1.Card
    local v1 = {}
    local ShownPosition = if not a2 then UDim2.fromScale(a1.ShownPosition.X.Scale, -0.2) else a1.ShownPosition
    v1.Position = ShownPosition
    local Back = if not a2 then Enum.EasingStyle.Quad else Enum.EasingStyle.Back
    local new = TweenInfo.new
    TweenService:Create(Card, new(if not a2 then 0.25 else 0.45, Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v1):Play()
end

function u30.SetObjective(a1, a2) -- Line: 161 -- upvalues: pop (val) -- types: a1: table, a2: string
    if a1.TitleText == a2 then
        return
    end
    a1.TitleText = a2
    a1.Title.Text = a2
    pop(a1.Title)
end

function u30.SetProgress(a1, a2, a3) -- Line: 171 -- types: a1: table, a2: number, a3: string
    local v1 = math.clamp(a2, 0, 1)
    if 0.001 < (math.abs(v1 - a1.BarAlpha)) then
        a1.BarAlpha = v1
        a1.Bar.Size = UDim2.fromScale(v1, a1.BarHeight)
    end
    if a3 ~= a1.BarText then
        a1.BarText = a3
        a1.BarLabel.Text = a3
    end
end

function u30.Letterbox(a1, a2) -- Line: 185 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean
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

function u30.Flash(a1) -- Line: 196 -- types: a1: table
    a1.FlashUntil = os.clock() + 0.6
end

function u30.SetDanger(a1, a2) -- Line: 200 -- types: a1: table, a2: number
    a1.Danger = a2
end

function u30.Update(a1, a2) -- Line: 204
    -- upvalues: u29 (val), GuiService (val), u24 (val)
    a1.Clock = a1.Clock + a2
    local v1 = math.clamp((a1.FlashUntil - os.clock()) / 0.6, 0, 1)
    if v1 > 0 then
        a1.Vignette.ImageColor3 = u29
        a1.Vignette.ImageTransparency = 1 - v1 * 0.9
        return
    end
    if a1.Danger <= 0 then
        if a1.Vignette.ImageTransparency ~= 1 then
            a1.Vignette.ImageTransparency = 1
        end
        return
    end
    v1 = if not GuiService.ReducedMotionEnabled then (math.sin(a1.Clock * 3.141592653589793 * 2 * (a1.Danger * 2 + 1.5)) + 1) * 0.5 else 0.5
    a1.Vignette.ImageColor3 = u24
    a1.Vignette.ImageTransparency = 1 - a1.Danger * (v1 * 0.35 + 0.45)
end

function u30.Unmount(a1) -- Line: 231 -- upvalues: u30 (val), TweenService (val) -- types: a1: table
    u30.SetBoardShown(a1, false)
    TweenService:Create(a1.Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
    u30.Letterbox(a1, false)
    task.delay(0.6, function() -- Line: 236 -- upvalues: a1 (val)
        a1.Gui:Destroy()
        a1.Overlay:Destroy()
        a1.Cinematic:Destroy()
    end)
end

return table.freeze(u30)