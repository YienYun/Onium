-- Script path: ReplicatedStorage.Client.UI.AlertBadge
-- Decompile time: 4.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u23 = UDim2.fromScale(0.994, 0.089)
local u27 = UDim2.fromScale(0.147, 0.501)
local u32 = Color3.fromRGB(255, 0, 0)
local u37 = Color3.fromRGB(56, 0, 14)
local u42 = Color3.fromRGB(255, 255, 255)
local u46 = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold)
local u50 = UDim2.fromScale(0.8, 0.8)
local u57 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local u58 = {}
u58.__index = u58

local function build(a1, a2) -- Line: 60
    -- upvalues: u32 (val), u23 (val), u27 (val), u37 (val), u46 (val), u50 (val), u42 (val)
    local AlertBadge = a1:FindFirstChild("AlertBadge")
    if AlertBadge ~= nil and AlertBadge:IsA("Frame") then
        return AlertBadge
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "AlertBadge"
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = u32
    Frame.BorderSizePixel = 0
    local Position = a2.Position or u23
    Frame.Position = Position
    local Size = a2.Size or u27
    Frame.Size = Size
    Frame.Visible = false
    Frame.ZIndex = a2.ZIndex or 6
    Instance.new("UIAspectRatioConstraint").Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = u37
    UIStroke.Thickness = 1.3
    UIStroke.Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = u46
    TextLabel.Name = "TextLabel"
    TextLabel.Position = UDim2.fromScale(0.5, 0.5)
    TextLabel.Size = u50
    TextLabel.Text = a2.Text or "!"
    TextLabel.TextColor3 = u42
    TextLabel.TextScaled = true
    TextLabel.ZIndex = Frame.ZIndex + 1
    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.Thickness = 1.1
    UIStroke_2.Parent = TextLabel
    TextLabel.Parent = Frame
    Frame.Parent = a1
    return Frame
end

function u58.new(a1, a2) -- Line: 113 -- upvalues: Signal (val), u58 (val), build (val) -- types: a1: table, a2: table?
    local v1 = a2 or {}
    local v2 = {
        _shown = false,
        Dismissed = Signal.new(),
        _badges = {},
        _connections = {},
        _tweens = {},
        _pulse = v1.Pulse ~= false,
    }
    local u19 = setmetatable(v2, u58)
    for i, j in a1 do
        if j:IsA("GuiObject") then
            table.insert(u19._badges, (build(j, v1)))
            if v1.DismissOnActivated ~= false and j:IsA("GuiButton") then
                table.insert(u19._connections, (j.Activated:Connect(function() -- Line: 134 -- upvalues: u19 (val)
                    u19:Dismiss()
                end)))
            end
        end
    end
    return u19
end

function u58.Attach(a1, a2) -- Line: 142 -- upvalues: u58 (val) -- types: a1: userdata?, a2: table?
    return u58.new(if a1 == nil then {} else {a1}, a2)
end

function u58.IsShown(a1) -- Line: 146
    return a1._shown
end

function u58.SetText(a1, a2) -- Line: 150 -- types: a2: string
    local v1 = nil
    local v2 = nil
    for i, j in a1._badges, v1, v2 do
        for k, n in j:GetDescendants() do
            if n:IsA("TextLabel") then
                n.Text = v3
            end
        end
    end
end

function u58.Show(a1) -- Line: 160 -- upvalues: EnsureUIScale (val), TweenService (val), u57 (val)
    local v1, v2
    if a1._shown then
        return
    end
    a1._shown = true
    for i, j in a1._badges do
        j.Visible = true
        v1 = EnsureUIScale(j)
        if a1._pulse then
            v1.Scale = 0.8
            v2 = TweenService:Create(v1, u57, {Scale = 1.2})
            v2:Play()
            table.insert(a1._tweens, v2)
        else
            v1.Scale = 1
        end
    end
end

function u58:Dismiss() -- Line: 181 -- upvalues: EnsureUIScale (val)
    local v1
    if not self._shown then
        return
    end
    self._shown = false
    for i, j in self._tweens do
        j:Cancel()
        j:Destroy()
    end
    table.clear(self._tweens)
    for k, n in self._badges do
        v1 = EnsureUIScale(n)
        v1.Scale = 1
        n.Visible = false
    end
    self.Dismissed:Fire()
end

function u58:Destroy() -- Line: 201
    self:Dismiss()
    for i, j in self._connections do
        j:Disconnect()
    end
    table.clear(self._connections)
    for k, n in self._badges do
        n:Destroy()
    end
    table.clear(self._badges)
    self.Dismissed:Destroy()
end

return u58