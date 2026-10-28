-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Hud
-- Decompile time: 14.08 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local u24 = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local u29 = TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u34 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local u36 = nil
local u37 = nil
local u38 = nil
local u39 = nil
local v1 = {}

local function gui() -- Line: 33 -- upvalues: u36 (ref), LocalPlayer (val)
    if u36 and u36.Parent then
        return u36
    end
    local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
    assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
    ShootingStarUI.Enabled = true
    u36 = ShootingStarUI
    return ShootingStarUI
end

local function child(a1) -- Line: 44 -- upvalues: u36 (ref), LocalPlayer (val) -- types: a1: string
    local v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    v1 = v1:FindFirstChild(a1)
    local v2 = ("ShootingStarUI.%* is missing"):format(a1)
    assert(v1 and v1:IsA("GuiObject"), v2)
    return v1
end

local function setText(a1, a2, a3) -- Line: 50 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2, true)
    if v1 and v1:IsA("TextLabel") then
        v1.Text = a3
    end
end

local function clock(a1) -- Line: 57 -- types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function scaleOf(a1) -- Line: 62 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Parent = a1
    return UIScale_2
end

function v1.Bars(a1) -- Line: 76
    -- upvalues: u36 (ref), LocalPlayer (val), TweenService (val), u24 (val)
    local v1, v2
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local TopBar = v1:FindFirstChild("TopBar")
    assert(TopBar and TopBar:IsA("GuiObject"), "ShootingStarUI.TopBar is missing")
    if not u36 or not u36.Parent then
        local ShootingStarUI_2 = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI_2 and ShootingStarUI_2:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI_2.Enabled = true
        u36 = ShootingStarUI_2
        v2 = ShootingStarUI_2
    else
        v2 = u36
    end
    local BottomBar = v2:FindFirstChild("BottomBar")
    assert(BottomBar and BottomBar:IsA("GuiObject"), "ShootingStarUI.BottomBar is missing")
    TopBar.Visible = true
    BottomBar.Visible = true
    local Scale = TopBar.Size.Y.Scale
    TweenService:Create(TopBar, u24, {Position = UDim2.fromScale(0.5, if not a1 then -Scale else 0)}):Play()
    TweenService:Create(BottomBar, u24, {Position = UDim2.fromScale(0.5, if not a1 then 1 + Scale else 1)}):Play()
end

function v1.Caption(a1) -- Line: 90
    -- upvalues: u36 (ref), LocalPlayer (val), TweenService (val), u34 (val), u29 (val)
    local v1, v2
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local Caption = v1:FindFirstChild("Caption")
    local v3 = Caption and Caption:IsA("GuiObject")
    assert(v3, "ShootingStarUI.Caption is missing")
    local UIScale = Caption:FindFirstChildOfClass("UIScale")
    if not UIScale then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = Caption
        v2 = UIScale_2
    else
        v2 = UIScale
    end
    if not a1 then
        v3 = TweenService:Create(Caption, u34, {GroupTransparency = 1})
        v3:Play()
        v3.Completed:Once(function() -- Line: 102 -- upvalues: Caption (val)
            if 1 <= Caption.GroupTransparency then
                Caption.Visible = false
            end
        end)
        return
    end
    Caption.Visible = true
    Caption.GroupTransparency = 1
    v2.Scale = 1.25
    TweenService:Create(Caption, u34, {GroupTransparency = 0}):Play()
    TweenService:Create(v2, u29, {Scale = 1}):Play()
end

function v1.Objective(a1) -- Line: 110
    -- upvalues: u36 (ref), LocalPlayer (val), u38 (ref), TweenService (val), u29 (val), u24 (val)
    local v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local Objective = v1:FindFirstChild("Objective")
    assert(Objective and Objective:IsA("GuiObject"), "ShootingStarUI.Objective is missing")
    if u38 == nil then
        u38 = Objective.Position.Y.Scale
    end
    local Scale = Objective.Position.X.Scale
    if a1 then
        Objective.Visible = true
        Objective.Position = UDim2.fromScale(Scale, -0.25)
        TweenService:Create(Objective, u29, {Position = UDim2.fromScale(Scale, u38)}):Play()
        return
    end
    local v2 = TweenService:Create(Objective, u24, {Position = UDim2.fromScale(Scale, -0.25)})
    v2:Play()
    v2.Completed:Once(function() -- Line: 129 -- upvalues: Objective (val)
        Objective.Visible = false
    end)
end

function v1.Progress(a1, a2, a3) -- Line: 135
    -- upvalues: u36 (ref), LocalPlayer (val), TweenService (val), u29 (val)
    local v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local Objective = v1:FindFirstChild("Objective")
    assert(Objective and Objective:IsA("GuiObject"), "ShootingStarUI.Objective is missing")
    local Bar = Objective:FindFirstChild("Bar", true)
    if Bar and Bar:IsA("GuiObject") then
        TweenService:Create(Bar, u29, {
            Size = UDim2.fromScale(math.clamp(a1, 0.04, 1), Bar.Size.Y.Scale),
        }):Play()
    end
    local v2 = a3
    if not v2 then
        local v3 = math.max(0, (math.floor(a2)))
        v2 = ("FIND THE LITTLE STAR  -  %*"):format((string.format("%d:%02d", v3 // 60, v3 % 60)))
    end
    local Progress = Objective:FindFirstChild("Progress", true)
    if Progress and Progress:IsA("TextLabel") then
        Progress.Text = v2
    end
end

function v1.Border(a1) -- Line: 146 -- upvalues: u36 (ref), LocalPlayer (val), u39 (ref) -- types: a1: number
    local v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local HoldBorder = v1:FindFirstChild("HoldBorder")
    assert(HoldBorder and HoldBorder:IsA("GuiObject"), "ShootingStarUI.HoldBorder is missing")
    if u39 then
        u39:Cancel()
        u39 = nil
    end
    HoldBorder.Visible = a1 > 0.01
    HoldBorder.ImageTransparency = 1 - math.clamp(a1, 0, 1) * 0.35
    local UIGradient = HoldBorder:FindFirstChildOfClass("UIGradient")
    if UIGradient then
        UIGradient.Offset = Vector2.new(math.sin((os.clock()) * 2.2) * 0.12, 0)
    end
end

function v1.BorderFade() -- Line: 160 -- upvalues: u36 (ref), LocalPlayer (val), u39 (ref), TweenService (val)
    local v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local HoldBorder = v1:FindFirstChild("HoldBorder")
    assert(HoldBorder and HoldBorder:IsA("GuiObject"), "ShootingStarUI.HoldBorder is missing")
    if u39 then
        u39:Cancel()
    end
    local v2 = TweenService:Create(HoldBorder, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1})
    u39 = v2
    v2:Play()
    v2.Completed:Once(function(a1) -- Line: 172 -- upvalues: HoldBorder (val), u39 (upval)
        if a1 == Enum.PlaybackState.Completed then
            HoldBorder.Visible = false
            u39 = nil
        end
    end)
end

function v1.Pulse() -- Line: 180 -- upvalues: u36 (ref), LocalPlayer (val), TweenService (val), u29 (val)
    local v1, v2
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v2 = ShootingStarUI
    else
        v2 = u36
    end
    local Objective = v2:FindFirstChild("Objective")
    assert(Objective and Objective:IsA("GuiObject"), "ShootingStarUI.Objective is missing")
    local UIScale = Objective:FindFirstChildOfClass("UIScale")
    if not UIScale then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = Objective
        v1 = UIScale_2
    else
        v1 = UIScale
    end
    v1.Scale = 1.12
    TweenService:Create(v1, u29, {Scale = 1}):Play()
end

function v1.Waypoint(a1) -- Line: 186
    -- upvalues: u37 (ref), u36 (ref), LocalPlayer (val), RunService (val), Workspace (val)
    local v1
    if u37 then
        u37:Disconnect()
        u37 = nil
    end
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local Waypoint = v1:FindFirstChild("Waypoint")
    assert(Waypoint and Waypoint:IsA("GuiObject"), "ShootingStarUI.Waypoint is missing")
    if a1 == nil then
        Waypoint.Visible = false
        return
    end
    local Arrow = Waypoint:FindFirstChild("Arrow")
    RunService.RenderStepped:Connect(function() -- Line: 197 -- upvalues: Workspace (upval), a1 (val), Waypoint (val), Arrow (val), LocalPlayer (upval)
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = a1()
        if v1 ~= nil and CurrentCamera ~= nil and CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            local v2
            local v3 = v1 + Vector3.new(0, 11, 0)
            local ViewportSize = CurrentCamera.ViewportSize
            local v4, v5 = CurrentCamera:WorldToViewportPoint(v3)
            v3 = v4.X / ViewportSize.X
            local v6 = v4.Y / ViewportSize.Y
            local v7 = not v5
            if not v7 then
                v7 = true
                if not (v3 < 0.07) then
                    v7 = true
                    if not (v3 > 0.9299999999999999) then
                        v7 = true
                        if not (v6 < 0.07) then
                            v7 = v6 > 0.9299999999999999
                        end
                    end
                end
            end
            if v7 then
                v5 = Vector2.new(v3 - 0.5, v6 - 0.5)
                if v4.Z < 0 then
                    v5 = -v5
                end
                if v5.Magnitude < 0.001 then
                    v5 = Vector2.new(0, 1)
                end
                v2 = 0.43 / math.max(math.abs(v5.X), (math.abs(v5.Y)))
                v3 = 0.5 + v5.X * v2
                v6 = 0.5 + v5.Y * v2
                if Arrow then
                    Arrow.Visible = true
                    Arrow.Rotation = math.deg((math.atan2(v5.Y, v5.X))) + 90
                end
            elseif Arrow then
                Arrow.Visible = false
            end
            Waypoint.Position = UDim2.fromScale(v3, v6)
            Waypoint.Visible = true
            local Character = LocalPlayer.Character
            v7 = Character and Character:FindFirstChild("HumanoidRootPart")
            if v7 and v7:IsA("BasePart") then
                v2 = Waypoint
                local v8 = ("%*m"):format((math.floor((v7.Position - v1).Magnitude)))
                v4 = v2:FindFirstChild("Distance", true)
                if v4 and v4:IsA("TextLabel") then
                    v4.Text = v8
                end
            end
            return
        end
        Waypoint.Visible = false
    end)
end

function v1.Reward(a1) -- Line: 243
    -- upvalues: u36 (ref), LocalPlayer (val), TweenService (val), RunService (val), u34 (val)
    local u50, v1
    if not u36 or not u36.Parent then
        local ShootingStarUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ShootingStarUI", 30)
        assert(ShootingStarUI and ShootingStarUI:IsA("ScreenGui"), "PlayerGui.ShootingStarUI is missing")
        ShootingStarUI.Enabled = true
        u36 = ShootingStarUI
        v1 = ShootingStarUI
    else
        v1 = u36
    end
    local Reward = v1:FindFirstChild("Reward")
    assert(Reward and Reward:IsA("GuiObject"), "ShootingStarUI.Reward is missing")
    local UIScale = Reward:FindFirstChildOfClass("UIScale")
    if not UIScale then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = Reward
        u50 = UIScale_2
    else
        u50 = UIScale
    end
    local v2 = if a1 ~= 1 then ("+%* STARS"):format(a1) else "+1 STAR"
    local Amount = Reward:FindFirstChild("Amount", true)
    if Amount and Amount:IsA("TextLabel") then
        Amount.Text = v2
    end
    Reward.Visible = true
    Reward.GroupTransparency = 0
    u50.Scale = 0.3
    TweenService:Create(u50, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    local Burst = Reward:FindFirstChild("Burst")
    local u110 = nil
    if Burst and Burst:IsA("GuiObject") then
        u110 = RunService.RenderStepped:Connect(function(a1) -- Line: 258 -- upvalues: Burst (val) -- types: a1: number
            local v1 = Burst
            v1.Rotation = v1.Rotation + a1 * 40
        end)
    end
    task.delay(2.6, function() -- Line: 262 -- upvalues: TweenService (upval), Reward (val), u34 (upval), u50 (val), u110 (ref)
        local v1 = TweenService:Create(Reward, u34, {GroupTransparency = 1})
        TweenService:Create(u50, u34, {Scale = 0.85}):Play()
        v1:Play()
        v1.Completed:Once(function() -- Line: 266 -- upvalues: Reward (upval), u110 (upval)
            Reward.Visible = false
            if u110 then
                u110:Disconnect()
            end
        end)
    end)
end

return v1