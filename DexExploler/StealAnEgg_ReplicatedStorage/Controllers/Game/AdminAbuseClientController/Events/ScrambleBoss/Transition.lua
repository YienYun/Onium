-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Transition
-- Decompile time: 18.91 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Kit = require(script.Parent.Kit)
local u51 = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u56 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u61 = Color3.fromRGB(225, 255, 225)
local u66 = Color3.new(0, 0, 0)
local LocalPlayer = Players.LocalPlayer
local u70 = Random.new()
local u72 = Trove.new()
local u75 = u72:Extend()
local u76 = nil
local u77 = nil
local u78 = nil
local u79 = nil
local u80 = {}
local u81 = 0
local u82 = 0
local u83 = 1
local zero = Vector2.zero
local u85 = "clear"
local u86 = nil
local u87 = false
local u88 = false
local u89 = 0
local u90 = 0
local u91 = 0
local u92 = nil
local u93 = false

local function viewport() -- Line: 94 -- upvalues: u76 (ref), Workspace (val)
    local AbsoluteSize = if not u76 then Vector2.zero else u76.AbsoluteSize
    if 1 <= AbsoluteSize.X and 1 <= AbsoluteSize.Y then
        return AbsoluteSize
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.ViewportSize
    end
    return (Vector2.new(1280, 720))
end

local function ensureGui() -- Line: 105
    -- upvalues: u76 (ref), ReplicatedStorage (val), u72 (val), u75 (ref), u87 (ref), u80 (ref), zero (ref), u85 (ref)
    -- upvalues: u86 (ref), u88 (ref), LocalPlayer (val), u77 (ref), u78 (ref), u79 (ref)
    if u76 and u76.Parent then
        return true
    end
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v1 = Assets and Assets:FindFirstChild("UI")
    v1 = v1 and v1:FindFirstChild("ScrambleBoss")
    local BinaryTransition = v1 and v1:FindFirstChild("BinaryTransition")
    if BinaryTransition ~= nil and BinaryTransition:IsA("ScreenGui") then
        u72:Clean()
        u72:Extend()
        u87 = false
        u80 = {}
        zero = Vector2.zero
        u85 = "clear"
        u86 = nil
        u88 = false
        v1 = u72:Clone(BinaryTransition)
        local Grid = v1:WaitForChild("Grid")
        local Cell = Grid:WaitForChild("Cell")
        local Fade = v1:WaitForChild("Fade")
        v1.Enabled = false
        Cell.Visible = false
        Fade.Visible = false
        v1.Parent = LocalPlayer:WaitForChild("PlayerGui")
        u76 = v1
        u77 = Grid
        u78 = Cell
        u79 = Fade
        return true
    end
    return false
end

local function paint(a1, a2) -- Line: 144 -- upvalues: u61 (val) -- types: a1: table, a2: number
    if a1.Glow == a2 then
        return
    end
    a1.Glow = a2
    a1.Digit.TextColor3 = a1.Tone:Lerp(u61, a2)
end

local function apply(a1, a2) -- Line: 153 -- upvalues: u81 (ref), u82 (ref) -- types: a1: table, a2: number
    local v1 = math.max(a2, 0)
    if a1.Value == v1 then
        return
    end
    a1.Value = v1
    a1.Frame.Size = UDim2.fromScale(u81 * v1, u82 * v1)
end

local function rebuild() -- Line: 163
    -- upvalues: u76 (ref), Workspace (val), zero (ref), u80 (ref), u83 (ref), u81 (ref), u82 (ref), u85 (ref)
    -- upvalues: u78 (ref), u70 (val), Kit (val), u66 (val), u77 (ref)
    local Digit, ViewportSize, v1, v2
    local AbsoluteSize = if not u76 then Vector2.zero else u76.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    if ViewportSize == zero and #u80 > 0 then
        return
    end
    zero = ViewportSize
    for i, j in u80 do
        j.Frame:Destroy()
    end
    table.clear(u80)
    local v3 = math.max(ViewportSize.X, ViewportSize.Y) / 22
    local v4 = math.ceil(ViewportSize.X / v3)
    local v5 = math.ceil(ViewportSize.Y / v3)
    u83 = v5
    local v6 = v3 / ViewportSize.X
    local v7 = v3 / ViewportSize.Y
    u81 = v6 * 1.04
    u82 = v7 * 1.04
    local v8 = math.max(math.floor(v3 * 0.72), 8)
    v3 = if u85 ~= "covered" then 0 else 1
    for k = 1, v4 do
        for n = 1, v5 do
            v1 = u78:Clone()
            v1.Name = ("%*_%*"):format(k, n)
            v1.Position = UDim2.fromScale((k - 0.5) * v6, (n - 0.5) * v7)
            v1.Size = UDim2.fromScale(u81 * v3, u82 * v3)
            v1.Visible = true
            Digit = v1:WaitForChild("Digit")
            Digit.TextSize = v8
            Digit.Text = if not ((u70:NextNumber()) < 0.5) then "1" else "0"
            v2 = Kit.Green:Lerp(u66, 1 - (u70:NextNumber(0.3, 1)))
            Digit.TextColor3 = v2
            v1.Parent = u77
            table.insert(u80, {
                Glow = 0,
                Frame = v1,
                Digit = Digit,
                Column = k,
                Row = n,
                Value = v3,
                Tone = v2,
            })
        end
    end
end

local function delays() -- Line: 217 -- upvalues: u80 (ref), u70 (val), u83 (ref)
    local v1, v2
    local v3 = {}
    local v4 = table.create(#u80, 0)
    local v5 = nil
    local v6 = nil
    for i, j in u80, v5, v6 do
        if v3[j.Column] == nil then
            v3[j.Column] = (u70:NextNumber(0, 0.16))
        end
        v1 = if not (u83 > 1) then 0 else (j.Row - 1) / (u83 - 1)
        v2 = v3[j.Column]
        v4[i] = v2 + v1 * 0.26
    end
    return v4
end

local function setFade(a1) -- Line: 232 -- upvalues: u89 (ref), u79 (ref) -- types: a1: number
    u89 = math.clamp(a1, 0, 1)
    local v1 = u79
    v1.BackgroundTransparency = 1 - u89
    v1.Visible = u89 > 0
end

local function flicker(a1) -- Line: 239 -- upvalues: u90 (ref), u80 (ref), u70 (val) -- types: a1: number
    u90 = u90 + a1
    if u90 < 0.06 then
        return
    end
    u90 = 0
    local v1 = nil
    local v2 = nil
    for i, j in u80, v1, v2 do
        if 0 < j.Value and (u70:NextNumber()) < 0.14 then
            j.Digit.Text = if j.Digit.Text ~= "0" then "0" else "1"
        end
    end
end

local u102 = nil

local function finish(a1) -- Line: 255
    -- upvalues: u86 (ref), u85 (ref), u88 (ref), u102 (ref), u75 (ref), u87 (ref), u80 (ref), u81 (ref), u82 (ref)
    -- upvalues: u61 (val), u89 (ref), u79 (ref), u76 (ref)
    local v1
    u86 = nil
    if a1.Target == 1 then
        u85 = "covered"
        if u88 then
            u88 = false
            u102(0)
        end
        return
    end
    u85 = "clear"
    u75:Clean()
    u87 = false
    local v2 = nil
    local v3 = nil
    for i, j in u80, v2, v3 do
        v1 = math.max(0, 0)
        if j.Value ~= v1 then
            j.Value = v1
            j.Frame.Size = UDim2.fromScale(u81 * v1, u82 * v1)
        end
        if j.Glow ~= 0 then
            j.Glow = 0
            j.Digit.TextColor3 = j.Tone:Lerp(u61, 0)
        end
    end
    u89 = 0
    local v4 = u79
    v4.BackgroundTransparency = 1 - u89
    v4.Visible = u89 > 0
    if u76 then
        u76.Enabled = false
    end
end

local function step(a1) -- Line: 280
    -- upvalues: flicker (val), u86 (ref), u89 (ref), u79 (ref), finish (val), u80 (ref), TweenService (val), u81 (ref)
    -- upvalues: u82 (ref), u61 (val)
    local Target_2, Value, v1, v2, v3, v4, v5
    flicker(a1)
    local v6 = u86
    if v6 == nil then
        return
    end
    local v7 = os.clock() - v6.Start
    if v6.Fade then
        v5 = math.clamp(v7 / 0.15, 0, 1)
        u89 = math.clamp(v6.FadeFrom + (v6.Target - v6.FadeFrom) * v5, 0, 1)
        local v8 = u79
        v8.BackgroundTransparency = 1 - u89
        v8.Visible = u89 > 0
        if v5 >= 1 then
            finish(v6)
        end
        return
    end
    v5 = math.max(v6.Info.Time, 0.001)
    local v9 = true
    local v10 = nil
    local v11 = nil
    for i, j in u80, v10, v11 do
        v1 = v6.From[i] or 1 - v6.Target
        v2 = (v7 - (v6.Delays[i] or 0)) / v5
        Target_2 = v6.Target
        v3 = 0
        if v1 ~= v6.Target and v2 < 1 then
            v9 = false
            if not (v2 <= 0) then
                Value = TweenService:GetValue(v2, v6.Info.EasingStyle, v6.Info.EasingDirection)
                Target_2 = v1 + (v6.Target - v1) * Value
                v3 = 1 - v2
            else
                Target_2 = v1
            end
        end
        v4 = math.max(Target_2, 0)
        if j.Value ~= v4 then
            j.Value = v4
            j.Frame.Size = UDim2.fromScale(u81 * v4, u82 * v4)
        end
        if j.Glow ~= v3 then
            j.Glow = v3
            j.Digit.TextColor3 = j.Tone:Lerp(u61, v3)
        end
    end
    if v9 then
        finish(v6)
    end
end

function u102(a1) -- Line: 327
    -- upvalues: u76 (ref), GuiService (val), u89 (ref), u80 (ref), u81 (ref), u82 (ref), u61 (val), u79 (ref)
    -- upvalues: rebuild (val), u86 (ref), u51 (val), u56 (val), delays (val), u85 (ref), Kit (val), u87 (ref)
    -- upvalues: u75 (ref), RunService (val), step (val)
    local v1
    local v2 = u76
    local ReducedMotionEnabled = GuiService.ReducedMotionEnabled
    if not ReducedMotionEnabled then
        rebuild()
        if u89 > 0 then
            local v3
            for i, j in u80 do
                v3 = math.max(u89, 0)
                if j.Value ~= v3 then
                    j.Value = v3
                    j.Frame.Size = UDim2.fromScale(u81 * v3, u82 * v3)
                end
            end
            u89 = 0
            v1 = u79
            v1.BackgroundTransparency = 1 - u89
            v1.Visible = u89 > 0
        end
    else
        local v4
        v1 = u89
        local v5 = nil
        local v6 = nil
        for k, n in u80, v5, v6 do
            v1 = math.max(v1, n.Value)
            v4 = math.max(0, 0)
            if n.Value ~= v4 then
                n.Value = v4
                n.Frame.Size = UDim2.fromScale(u81 * v4, u82 * v4)
            end
            if n.Glow ~= 0 then
                n.Glow = 0
                n.Digit.TextColor3 = n.Tone:Lerp(u61, 0)
            end
        end
        u89 = math.clamp(math.min(v1, 1), 0, 1)
        v5 = u79
        v5.BackgroundTransparency = 1 - u89
        v5.Visible = u89 > 0
    end
    v1 = table.create(#u80, 0)
    for m, i5 in u80 do
        v1[m] = i5.Value
    end
    u86 = {
        Target = a1,
        Start = os.clock(),
        Info = if a1 ~= 1 then u56 else u51,
        From = v1,
        Delays = if not ReducedMotionEnabled then delays() else {},
        Fade = ReducedMotionEnabled,
        FadeFrom = u89,
    }
    u85 = if a1 ~= 1 then "revealing" else "covering"
    v2.Enabled = true
    if a1 ~= 1 then
        Kit.Sound("Zap", nil, 0.25, 1.6)
    else
        Kit.Sound("Swoosh", nil, 0.5, 1.35)
    end
    if not u87 then
        u87 = true
        u75:Connect(RunService.RenderStepped, step)
    end
end

local function rootPosition() -- Line: 377 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 then
        return v1.Position
    end
    return nil
end

local function cameraModule() -- Line: 383 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        return require(PlayerModule):GetCameras()
    end
    return nil
end

local function faceCharacter() -- Line: 393
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), cameraModule (val)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = Player.FindRootPart(LocalPlayer)
    if CurrentCamera ~= nil and v1 ~= nil and CurrentCamera.CameraType == Enum.CameraType.Custom then
        local LookVector = v1.CFrame.LookVector
        local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
        if v2.Magnitude < 0.01 then
            return
        end
        local v3 = cameraModule()
        local v4 = (if not v3 then nil else v3:GetCameraSubjectPosition()) or v1.Position + Vector3.new(0, 1.5, 0)
        v1 = math.max(
            (if not v3 then nil else v3:GetCameraToSubjectDistance()) or (CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude,
            0.5
        )
        local v5 = math.clamp(math.asin((math.clamp(CurrentCamera.CFrame.LookVector.Y, -1, 1))), -0.6981317007977318, -0.13962634015954636)
        v5 = CFrame.lookAt(v4 - (v2.Unit * math.cos(v5) + Vector3.new(0, 1, 0) * math.sin(v5)) * v1, v4)
        CurrentCamera.CFrame = v5
        if v3 then
            v3:CommitCameraCFrame(v5, Enum.CameraType.Custom)
        end
        return
    end
end

local u109 = {}

function u109.Cover(a1, a2) -- Line: 430
    -- upvalues: ensureGui (val), u91 (ref), u92 (ref), Player (val), LocalPlayer (val), u88 (ref), u85 (ref)
    -- upvalues: u109 (val), u102 (ref), u86 (ref)
    if not ensureGui() then
        return
    end
    u91 = u91 + 1
    local u6 = u91
    local v1 = Player.FindRootPart(LocalPlayer)
    u92 = if not v1 then nil else v1.Position
    u88 = false
    task.delay(math.max(a2 or 0, 5), function() -- Line: 440 -- upvalues: u91 (upval), u6 (val), u85 (upval), u109 (upval)
        if u91 == u6 and u85 ~= "clear" and u85 ~= "revealing" then
            u109.Reveal()
        end
    end)
    if u85 ~= "covered" and u85 ~= "covering" then
        u102(1)
        if a1 and u86 then
            local v2 = u86
            v2.Start = v2.Start - 10
        end
        return
    end
end

function u109.Reveal() -- Line: 457 -- upvalues: u76 (ref), u85 (ref), u88 (ref), u102 (ref)
    if u76 ~= nil and u85 ~= "clear" and u85 ~= "revealing" then
        if u85 == "covering" then
            u88 = true
            return
        end
        u102(0)
        return
    end
end

function u109.RevealAfterMove() -- Line: 470
    -- upvalues: u91 (ref), u92 (ref), Player (val), LocalPlayer (val), faceCharacter (val), u109 (val)
    local u0 = u91
    local u1 = u92
    local u3 = os.clock()
    task.spawn(function() -- Line: 475
        -- upvalues: u3 (val), u91 (upval), u0 (val), Player (upval), LocalPlayer (upval), u1 (val)
        -- upvalues: faceCharacter (upval), u109 (upval)
        local Position, v1
        while true do
            if not (os.clock() - u3 < 0.75) then
                break
            end
            if u91 ~= u0 then
                return
            end
            v1 = Player.FindRootPart(LocalPlayer)
            Position = if not v1 then nil else v1.Position
            if u1 == nil then
                break
            end
            if Position and 12 < (Position - u1).Magnitude then
                break
            end
            task.wait()
        end
        task.wait(0.08)
        if u91 == u0 then
            faceCharacter()
            u109.Reveal()
        end
    end)
end

function u109.Listen() -- Line: 497 -- upvalues: u93 (ref), Remotes (val), u109 (val)
    if u93 then
        return
    end
    u93 = true
    Remotes.ScrambleBoss.Transition.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 504 -- upvalues: u109 (upval)
        if a1 ~= "Cover" then
            if a1 == "Reveal" then
                u109.RevealAfterMove()
            end
            return
        end
        local Cover = u109.Cover
        local v1 = if type(a3) ~= "number" then nil else a3
        Cover(a2 == true, v1)
    end)
end

return u109