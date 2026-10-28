-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Cinematic
-- Decompile time: 10.31 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Hud = require(script.Parent.Hud)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u43 = {ClockTime = 0.4, Brightness = 1.2, ExposureCompensation = -0.2}
u43.Ambient = Color3.fromRGB(70, 70, 120)
u43.OutdoorAmbient = Color3.fromRGB(55, 62, 120)
u43.ColorShift_Top = Color3.fromRGB(120, 140, 255)
u43.ColorShift_Bottom = Color3.fromRGB(30, 30, 80)
u43.Bloom = {Intensity = 1.4, Threshold = 0.85, Size = 36, Enabled = true}
local LocalPlayer = Players.LocalPlayer
local Controls = require((LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule")):GetControls()
local u79 = {}

local function smooth(a1) -- Line: 66 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function bezier(a1, a2, a3, a4) -- Line: 71 -- types: a1: vector, a2: vector, a3: vector, a4: number
    return (a1:Lerp(a2, a4)):Lerp(a2:Lerp(a3, a4), a4)
end

local function clearPosition(a1, a2, a3) -- Line: 75
    -- upvalues: Workspace (val)
    local v1 = a2 - a1
    if v1.Magnitude < 0.001 then
        return a2
    end
    local v2 = Workspace:Spherecast(a1, 1.5, v1, a3)
    if v2 then
        return a1 + v1.Unit * math.max(v2.Distance - 0.35, 0)
    end
    return a2
end

local function playerFocus() -- Line: 87 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end
    return nil
end

function u79.Seconds() -- Line: 97
    return 4.2
end

function u79.Path(a1) -- Line: 101 -- types: a1: userdata
    local Position = a1.Position
    local RightVector = a1.RightVector
    local v1 = -a1.LookVector
    local v2 = Position + (RightVector * 0.8 + v1 * 0.6).Unit * 620 + Vector3.new(0, 560, 0)
    return v2, (Position:Lerp(v2, 0.45)) + Vector3.new(0, 90, 0), Position + Vector3.new(0, 2, 0)
end

function u79.StarAt(a1, a2) -- Line: 112 -- upvalues: u79 (val), bezier (val) -- types: a1: userdata, a2: number
    local v1, v2, v3 = u79.Path(a1)
    return bezier(v1, v2, v3, a2 ^ 1.7)
end

function u79.Play(a1, a2, a3) -- Line: 117
    -- upvalues: Workspace (val), Trove (val), Fx (val), HiddenUIHandler (val), Controls (val), LightingController (val)
    -- upvalues: u43 (val), Hud (val), LocalPlayer (val), Players (val), u79 (val), RunService (val)
    local Landing = a1.Landing
    local u5 = a1.FallAt + 1
    local LandAt = a1.LandAt
    local Position = Landing.Position
    local CurrentCamera = Workspace.CurrentCamera
    local u12 = Trove.new()
    local u13 = false
    local u14 = false
    local u15 = false
    local u16 = false
    local FieldOfView = CurrentCamera.FieldOfView
    local u20 = Fx.ReducedMotion()
    u12:Add((HiddenUIHandler.Acquire()))
    Controls:Disable()
    u12:Add(function() -- Line: 133 -- upvalues: Controls (upval)
        Controls:Enable()
    end)
    LightingController.SetLayer("ShootingStarCinematic", u43, 250, 0.9)
    u12:Add(function() -- Line: 137 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("ShootingStarCinematic", 2.2)
    end)
    Hud.Bars(true)
    u12:Add(function() -- Line: 141 -- upvalues: Hud (upval)
        Hud.Bars(false)
        Hud.Caption(false)
    end)
    task.spawn(function() -- Line: 145 -- upvalues: LocalPlayer (upval), Position (val)
        pcall(function() -- Line: 146 -- upvalues: LocalPlayer (upval), Position (upval)
            LocalPlayer:RequestStreamAroundAsync(Position, 4)
        end)
    end)
    local Unit = (-Landing.LookVector * Vector3.new(1, 0, 1)).Unit
    local RightVector = Landing.RightVector
    local u66 = Position + Unit * 115 + Vector3.new(0, 18, 0)
    local v1 = RightVector * 8 + Unit * 30
    local u72 = Position + v1 + Vector3.new(0, 9, 0)
    local u77 = math.atan2(v1.Z, v1.X)
    local Magnitude = v1.Magnitude
    local u80 = Position + Vector3.new(0, 4, 0)
    local u82 = RaycastParams.new()
    u82.FilterType = Enum.RaycastFilterType.Exclude
    u82.RespectCanCollide = true
    u82.IgnoreWater = true
    local v2 = {}
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if ShootingStarClient then
        table.insert(v2, ShootingStarClient)
    end
    for i, j in Players:GetPlayers() do
        if j.Character then
            table.insert(v2, j.Character)
        end
    end
    u82.FilterDescendantsInstances = v2
    local u111 = nil
    local u112 = false
    local u119 = u79.StarAt(Landing, 0.15)
    local u121 = LandAt + 4.2
    Fx.Dip(0.28, 0.44800000000000006)
    u12:Connect(RunService.RenderStepped, function(a1_2) -- Line: 182
        -- upvalues: a2 (val), u112 (ref), a1 (val), CurrentCamera (val), u5 (val), LandAt (val), u79 (upval)
        -- upvalues: Landing (val), Position (val), u20 (val), u72 (val), u119 (val), u66 (val), u77 (val)
        -- upvalues: Magnitude (val), u80 (val), u82 (val), Workspace (upval), u111 (ref), u14 (ref), a3 (val)
        -- upvalues: Fx (upval), u16 (ref), Hud (upval), u15 (ref), u13 (ref), u121 (val), FieldOfView (val), u12 (val)
        local v1, v2, v3, v4, v5, v6, v7, v8
        local v9 = a2()
        if not u112 and a1.FallAt + 0.28 <= v9 then
            u112 = true
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
        end
        if not u112 then
            return
        end
        local v10 = math.clamp((v9 - u5) / (LandAt - u5), 0, 1)
        local v11 = u79.StarAt(Landing, v10)
        local v12 = Position + Vector3.new(0, 2.5999999046325684, 0)
        if u20 then
            v4 = u72
            v3 = math.clamp(v10, 0, 1)
            v5 = v11:Lerp(v12, v3 * v3 * (3 - v3 * 2))
            v6 = 62
        elseif v9 < LandAt then
            v8 = math.clamp((v9 - LandAt + 1.8) / 1.8, 0, 1)
            v7 = v8 * v8 * (3 - v8 * 2)
            v8 = u119
            local v13 = math.clamp((v9 - u5 + 0.4) / 1.2, 0, 1)
            v8 = v8:Lerp(v11, v13 * v13 * (3 - v13 * 2))
            v1 = math.clamp((v9 - a1.FallAt) / (LandAt - a1.FallAt), 0, 1)
            v4 = (u66 + Vector3.new(0, -v1 * 6, 0)):Lerp(u72, v7)
            v5 = v8:Lerp(v12, v7)
            local v14 = math.clamp(v1, 0, 1)
            v6 = (68 - v14 * v14 * (3 - v14 * 2) * 18) * (1 - v7) + v7 * 62
        elseif not (v9 < LandAt + 0.45) then
            v8 = math.clamp((v9 - LandAt - 0.45) / 3.75, 0, 1)
            v7 = v8 * v8 * (3 - v8 * 2)
            v8 = u77 + v7 * 0.9599310885968813
            v1 = Magnitude + (18 - Magnitude) * v7
            v2 = v7 * -3 + 9
            v4 = Position + Vector3.new(math.cos(v8) * v1, v2, (math.sin(v8)) * v1)
            v5 = v12
            v6 = 62 - v7 * 10
        else
            v4 = u72
            v5 = v12
            v6 = 62
        end
        v7 = u80
        v8 = v4
        v12 = v8 - v7
        if not (v12.Magnitude < 0.001) then
            v11 = Workspace:Spherecast(v7, 1.5, v12, u82)
            v4 = if not v11 then v8 else v7 + v12.Unit * math.max(v11.Distance - 0.35, 0)
        else
            v4 = v8
        end
        v10 = u111
        if v10 and not u20 then
            v7 = u80
            v8 = v10:Lerp(v4, 1 - (math.exp(a1_2 * -12)))
            v2 = v8 - v7
            if not (v2.Magnitude < 0.001) then
                v3 = Workspace:Spherecast(v7, 1.5, v2, u82)
                v4 = if not v3 then v8 else v7 + v2.Unit * math.max(v3.Distance - 0.35, 0)
            else
                v4 = v8
            end
        end
        u111 = v4
        CurrentCamera.CFrame = CFrame.lookAt(v4, v5)
        CurrentCamera.FieldOfView = v6
        if not u14 and LandAt <= v9 then
            u14 = true
            a3.Land()
            Fx.Flash(Color3.fromRGB(255, 240, 200), 0.8, 0.55)
            Fx.Grade(Color3.fromRGB(255, 200, 90), 1, 0.9)
            v1 = if not u20 then 1.6 else 0.4
            Fx.Shake(0.9, v1, Position)
        end
        if not u16 and LandAt + 0.55 <= v9 then
            u16 = true
            Hud.Caption(true)
        end
        if not u15 and LandAt + 0.55 + 0.3 <= v9 then
            u15 = true
            a3.Rise()
        end
        if not u13 and u121 <= v9 then
            u13 = true
            Fx.Dip(0.28, 0.44800000000000006)
            task.delay(0.28, function() -- Line: 257 -- upvalues: CurrentCamera (upval), FieldOfView (upval), u12 (upval)
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.FieldOfView = FieldOfView
                u12:Destroy()
            end)
        end
    end)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Position_2 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
    if Position_2 then
        CurrentCamera.Focus = CFrame.new(Position_2)
    end
end

return u79