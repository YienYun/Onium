-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Hud
-- Decompile time: 10.79 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local GhostDogQuest = ReplicatedStorage.Assets.GhostDogQuest
local Notification = ReplicatedStorage.Assets.Sounds.ScrambleBoss.Notification
local u37 = {
    Frame = {"BackgroundTransparency"},
    ImageLabel = {"ImageTransparency"},
    TextLabel = {"TextTransparency"},
    UIStroke = {"Transparency"},
}
local u46 = nil
local u47 = nil
local u48 = nil
local u49 = nil
local u50 = nil
local u52 = Trove.new()
local u53 = nil
local u54 = nil
local u55 = false
local u56 = false
local u57 = {}
local u58 = {}

local function objectiveHitArea(a1) -- Line: 49 -- types: a1: userdata
    local PressSurface = a1:FindFirstChild("PressSurface")
    if PressSurface and PressSurface:IsA("GuiObject") then
        return PressSurface
    end
    return nil
end

local function rememberRest(a1) -- Line: 54 -- upvalues: u37 (val), u57 (val) -- types: a1: userdata
    local v1 = u37[a1.ClassName]
    if v1 == nil then
        return
    end
    local v2 = {}
    for i, j in v1 do
        v2[j] = a1[j]
    end
    u57[a1] = v2
end

local function captureObjectiveRest(a1) -- Line: 66 -- upvalues: u57 (val), u37 (val) -- types: a1: userdata
    local v1, v2
    table.clear(u57)
    local v3 = u37[a1.ClassName]
    if v3 ~= nil then
        local v4 = {}
        for i, j in v3 do
            v4[j] = a1[j]
        end
        u57[a1] = v4
    end
    for k, n in a1:GetDescendants() do
        v1 = u37[n.ClassName]
        if v1 ~= nil then
            v2 = {}
            for m, i5 in v1 do
                v2[i5] = n[i5]
            end
            u57[n] = v2
        end
    end
end

local function fadeObjective(a1) -- Line: 74 -- upvalues: u46 (ref), u57 (val), Fx (val) -- types: a1: boolean
    local v1, v2
    local v3 = u46
    if v3 == nil then
        return
    end
    v3.Objective.Interactable = not a1
    local v4 = nil
    local v5 = nil
    for i, j in u57, v4, v5 do
        v3 = {}
        v1 = nil
        v2 = nil
        for k, n in j, v1, v2 do
            v3[k] = if not a1 then n else 1
        end
        Fx.Tween(i, 0.2, v3, Enum.EasingStyle.Sine)
    end
end

local function watchBanner(a1, a2) -- Line: 89
    -- upvalues: u56 (ref), fadeObjective (val), u52 (val)
    local function refresh() -- Line: 90 -- upvalues: a1 (val), a2 (val), u56 (upval), fadeObjective (upval)
        local v1 = false
        if a1.Enabled then
            for i, j in a2:GetChildren() do
                if j:IsA("GuiObject") then
                    v1 = true
                    break
                end
            end
        end
        if v1 == u56 then
            return
        end
        u56 = v1
        fadeObjective(v1)
    end

    u52:Connect(a2.ChildAdded, refresh)
    u52:Connect(a2.ChildRemoved, refresh)
    u52:Connect(a1:GetPropertyChangedSignal("Enabled"), refresh)
    refresh()
end

local function frameModel(a1, a2, a3, a4) -- Line: 112 -- types: a1: userdata, a2: userdata, a3: number?, a4: number?
    a1:ClearAllChildren()
    local v1 = a2:Clone()
    local v2, v3, v4 = a1, a4, a3
    for i, j in v1:GetDescendants() do
        if j:IsA("Script") or j:IsA("LocalScript") then
            j:Destroy()
        end
    end
    local WorldModel = Instance.new("WorldModel")
    WorldModel.Parent = v2
    v1:PivotTo((CFrame.new()))
    v1.Parent = WorldModel
    local BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
    local v5 = Instance.new("Camera")
    v5.FieldOfView = 30
    v1 = BoundingBox_2.Magnitude * (v3 or 1.5)
    local v6 = (CFrame.Angles(0, math.rad(v4 or 30), 0)) * (CFrame.Angles(-0.3141592653589793, 0, 0))
    v5.CFrame = CFrame.new(BoundingBox.Position) * v6 * CFrame.new(0, 0, v1)
    v5.Parent = v2
    v2.CurrentCamera = v5
end

function u58.Frame(a1, a2, a3, a4) -- Line: 134
    -- upvalues: frameModel (val)
    frameModel(a1, a2, a3, a4)
end

function u58.Get() -- Line: 138 -- upvalues: u46 (ref)
    return u46
end

function u58.FadeFrame() -- Line: 142 -- upvalues: u47 (ref)
    return u47
end

function u58.Ticket() -- Line: 146 -- upvalues: u48 (ref)
    return u48
end

function u58.Mount() -- Line: 150
    -- upvalues: u46 (ref), GhostDogQuest (val), u55 (ref), LocalPlayer (val), u47 (ref), u48 (ref), u49 (ref)
    -- upvalues: u50 (ref), u52 (val), SurfaceButton (val), u54 (ref), captureObjectiveRest (val), u56 (ref)
    -- upvalues: watchBanner (val), frameModel (val)
    if u46 and u46.Parent then
        return u46
    end
    local v1 = GhostDogQuest.GhostDogQuestUI:Clone()
    v1.Enabled = not u55
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GhostDogQuestOverlay"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = v1.ResetOnSpawn
    ScreenGui.ZIndexBehavior = v1.ZIndexBehavior
    ScreenGui.DisplayOrder = v1.DisplayOrder + 1
    u47 = v1.Fade
    u48 = v1.Ticket
    u49 = v1.Bubbles
    u50 = ScreenGui
    v1.Bubbles.Parent = ScreenGui
    v1.Ticket.Parent = ScreenGui
    v1.Fade.Parent = ScreenGui
    v1.Parent = PlayerGui
    ScreenGui.Parent = PlayerGui
    u46 = v1
    u52:Add(v1)
    u52:Add(ScreenGui)
    v1.Memories.Visible = false
    u52:Add((SurfaceButton(v1.Objective, nil, function() -- Line: 176 -- upvalues: u54 (upval)
        local v1 = u54
        if v1 then
            v1()
        end
    end)))
    local PressSurface = v1.Objective:FindFirstChild("PressSurface")
    local v2 = if not PressSurface then nil else if not PressSurface:IsA("GuiObject") then nil else PressSurface
    if v2 then
        v2.Visible = u54 ~= nil
    end
    captureObjectiveRest(v1.Objective)
    u56 = false
    u52:Add((task.spawn(function() -- Line: 188 -- upvalues: PlayerGui (val), watchBanner (upval)
        local Notifications = PlayerGui:WaitForChild("Notifications")
        watchBanner(Notifications, Notifications:WaitForChild("Banner"))
    end)))
    frameModel(v1.Chase.Progress.Fish, GhostDogQuest.GhostFish, 90, 1.1)
    frameModel(v1.Chase.Progress.Goal, GhostDogQuest.SunkenChest, 30, 1.3)
    return v1
end

function u58.Unmount() -- Line: 197
    -- upvalues: u52 (val), u46 (ref), u50 (ref), u47 (ref), u48 (ref), u49 (ref), u53 (ref), u54 (ref), u56 (ref)
    -- upvalues: u57 (val)
    u52:Clean()
    u46 = nil
    u50 = nil
    u47 = nil
    u48 = nil
    u49 = nil
    u53 = nil
    u54 = nil
    u56 = false
    table.clear(u57)
end

function u58.SetHidden(a1) -- Line: 210 -- upvalues: u55 (ref), u46 (ref) -- types: a1: boolean
    u55 = a1
    local v1 = u46
    if v1 then
        v1.Enabled = not a1
    end
end

function u58.SetObjective(a1, a2) -- Line: 218
    -- upvalues: u54 (ref), u46 (ref), u53 (ref), Fx (val), Notification (val)
    u54 = if not a1 then nil else a2
    local v1 = u46
    if v1 == nil then
        return
    end
    local Objective = v1.Objective
    local PressSurface = Objective:FindFirstChild("PressSurface")
    v1 = if not PressSurface then nil else if not PressSurface:IsA("GuiObject") then nil else PressSurface
    if v1 then
        v1.Visible = u54 ~= nil
    end
    if a1 == nil then
        Objective.Visible = false
        u53 = nil
        return
    end
    Objective.Visible = true
    if u53 == a1 then
        return
    end
    v1 = u53 == nil
    u53 = a1
    Objective.Text.Text = a1
    local UIScale = Objective:FindFirstChildOfClass("UIScale")
    if UIScale then
        UIScale.Scale = if not v1 then 0.85 else 0.2
        Fx.Tween(UIScale, 0.45, {Scale = 1}, Enum.EasingStyle.Back)
    end
    Fx.Play(Notification, {Volume = 0.35})
end

function u58.Fade(a1, a2) -- Line: 249 -- upvalues: u47 (ref), Fx (val) -- types: a1: number, a2: number
    local v1 = u47
    if v1 == nil then
        return
    end
    local v2 = Fx.Tween(v1, a2, {BackgroundTransparency = 1 - a1}, Enum.EasingStyle.Sine)
    if a2 > 0 then
        v2.Completed:Wait()
    end
end

function u58.Bubbles(a1, a2) -- Line: 261 -- upvalues: u49 (ref), Fx (val) -- types: a1: number, a2: number
    local v1
    local v2 = u49
    if v2 == nil then
        return
    end
    local Bubble = v2.Bubble
    local v3 = Random.new()
    for i = 1, a2 do
        local u14 = Bubble:Clone()
        u14.Visible = true
        v1 = v3:NextNumber(0.025, 0.11)
        u14.Size = UDim2.fromScale(v1, v1)
        u14.Position = UDim2.fromScale(v3:NextNumber(0, 1), 1.1 + v3:NextNumber(0, 0.25))
        u14.Parent = v2
        v1 = a1 * v3:NextNumber(0.6, 1)
        Fx.Tween(u14, v1, {
            BackgroundTransparency = 0.85,
            Position = UDim2.fromScale(u14.Position.X.Scale + v3:NextNumber(-0.08, 0.08), -0.15),
        }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(v1, function() -- Line: 283 -- upvalues: u14 (val)
            u14:Destroy()
        end)
    end
end

function u58.Cinematic(a1) -- Line: 289 -- upvalues: u46 (ref) -- types: a1: boolean
    local v1 = u46
    if v1 == nil then
        return
    end
    if a1 then
        v1.Objective.Visible = false
    end
end

function u58.Caption(a1, a2) -- Line: 299 -- upvalues: u50 (ref), Fx (val), u58 (val) -- types: a1: string?, a2: number?
    local v1 = u50
    if v1 == nil then
        return
    end
    local Caption = v1:FindFirstChild("Caption")
    if Caption == nil then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Caption"
        TextLabel.BackgroundTransparency = 1
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.Position = UDim2.fromScale(0.5, 0.8)
        TextLabel.Size = UDim2.fromScale(0.7, 0.065)
        TextLabel.TextScaled = true
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
        TextLabel.ZIndex = 60
        TextLabel.TextTransparency = 1
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 3
        UIStroke.Transparency = 1
        UIStroke.Parent = TextLabel
        Instance.new("UIScale").Parent = TextLabel
        TextLabel.Parent = v1
        Caption = TextLabel
    end
    local u46 = Caption
    local UIStroke_2 = u46:FindFirstChildOfClass("UIStroke")
    if a1 == nil then
        Fx.Tween(u46, 0.3, {TextTransparency = 1})
        Fx.Tween(UIStroke_2, 0.3, {Transparency = 1})
        return
    end
    u46.Text = a1
    Fx.Tween(u46, 0.25, {TextTransparency = 0})
    Fx.Tween(UIStroke_2, 0.25, {Transparency = 0})
    local UIScale = u46:FindFirstChildOfClass("UIScale")
    if UIScale then
        Fx.Punch(UIScale, 1.25, 0.35)
    end
    if a2 then
        task.delay(a2, function() -- Line: 342 -- upvalues: u46 (val), a1 (val), u58 (upval)
            if u46.Text == a1 then
                u58.Caption(nil)
            end
        end)
    end
end

function u58.WorldToScreen(a1) -- Line: 350 -- upvalues: Workspace (val) -- types: a1: vector
    local v1, v2 = Workspace.CurrentCamera:WorldToViewportPoint(a1)
    if not v2 then
        return nil
    end
    return Vector2.new(v1.X, v1.Y)
end

return (table.freeze(u58))