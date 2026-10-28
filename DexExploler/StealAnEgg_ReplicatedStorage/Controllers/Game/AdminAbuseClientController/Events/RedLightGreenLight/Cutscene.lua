-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight.Cutscene
-- Decompile time: 7.22 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local Fx = require(script.Parent.Fx)
local Giant = require(script.Parent.Giant)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local u47 = require(script.Parent.Hud)
local u48 = {"Particles", "ScrambleBossVFX", "MechBoss", "Slam"}
local v1 = {}

local function easeOutQuint(a1) -- Line: 43 -- types: a1: number
    return 1 - (1 - a1) ^ 5
end

local function easeInOutCubic(a1) -- Line: 47 -- types: a1: number
    if a1 < 0.5 then
        return a1 * 4 * a1 * a1
    end
    return 1 - (a1 * -2 + 2) ^ 3 / 2
end

local function easeOutBack(a1) -- Line: 51 -- types: a1: number
    return (a1 - 1) ^ 3 * 2.2 + 1 + (a1 - 1) ^ 2 * 1.2
end

local function dust(a1) -- Line: 58 -- upvalues: Fx (val), u48 (val)
    local v1 = Fx.Resolve(u48)
    if v1 == nil then
        return
    end
    local u7 = v1:Clone()
    v1 = a1.Height * 0.12
    local v2 = Vector3.new((math.random() - 0.5) * v1, 0, ((math.random()) - 0.5) * v1)
    if u7:IsA("BasePart") then
        u7.Anchored = true
        u7.CanCollide = false
        u7.CanQuery = false
        u7.CanTouch = false
        u7.Transparency = 1
        u7.CFrame = a1.Ground + v2
    end
    Fx.Scale(u7, a1.Height / 60)
    u7.Parent = Fx.Folder()
    Fx.Burst(u7, 0.6)
    task.delay(4, function() -- Line: 81 -- upvalues: u7 (val)
        u7:Destroy()
    end)
end

function v1.Play(a1, a2, a3) -- Line: 90
    -- upvalues: Workspace (val), CameraShaker (val), HiddenUIHandler (val), Giant (val), u47 (val), Fx (val)
    -- upvalues: GuiService (val), RunService (val), dust (val), CameraShakerDriver (val)
    local CurrentCamera = Workspace.CurrentCamera
    local u5 = {
        CFrame = CurrentCamera.CFrame,
        FieldOfView = CurrentCamera.FieldOfView,
        CameraType = CurrentCamera.CameraType,
        CameraSubject = CurrentCamera.CameraSubject,
    }
    local u12 = CameraShaker.new()
    local u15 = HiddenUIHandler.Acquire()
    local u17 = os.clock()
    local LookVector = a1.Ground.LookVector
    local u20 = (-1 / 0)
    local u21 = false
    local u22 = false
    local u23 = false
    local u24 = {Done = false}

    function u24.Stop() end

    a1.Rise = 0
    Giant.Face(a1, true, true)
    Giant.SetEyes(a1, 0, true)
    u47.SetBoardShown(a2, false)
    u47.Letterbox(a2, true)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    Fx.Sound({"Sounds", "CinematicRiser"}, nil, 2.4)
    Fx.Sound({"Sounds", "ScrambleBoss", "Rumble"}, nil, 1.2)
    if not GuiService.ReducedMotionEnabled then
        u12:ShakeSustain(CameraShaker.Presets.Earthquake)
    end

    local function stop() -- Line: 120
        -- upvalues: u24 (val), RunService (upval), u12 (val), a1 (val), CurrentCamera (val), u5 (val), u47 (upval)
        -- upvalues: a2 (val), u15 (val)
        if u24.Done then
            return
        end
        u24.Done = true
        local v1 = RunService
        pcall(RunService.UnbindFromRenderStep, v1, "RedLightGreenLightCutscene")
        u12:StopSustained(0.2)
        a1.Rise = 1
        CurrentCamera.CFrame = u5.CFrame
        CurrentCamera.FieldOfView = u5.FieldOfView
        CurrentCamera.CameraType = u5.CameraType
        if u5.CameraSubject ~= nil and u5.CameraSubject.Parent ~= nil then
            CurrentCamera.CameraSubject = u5.CameraSubject
        end
        u47.Letterbox(a2, false)
        u47.SetBoardShown(a2, true)
        u15()
    end

    u24.Stop = stop
    RunService:BindToRenderStep("RedLightGreenLightCutscene", Enum.RenderPriority.Camera.Value + 1, function(a1_2) -- Line: 147
        -- upvalues: Workspace (upval), a3 (val), u17 (val), a1 (val), u20 (ref), dust (upval), u21 (ref), u12 (val)
        -- upvalues: Fx (upval), u22 (ref), Giant (upval), LookVector (val), u5 (val), u23 (ref), u47 (upval), a2 (val)
        -- upvalues: stop (val), CurrentCamera (val), CameraShakerDriver (upval)
        local success, err = pcall(function() -- Line: 148
            -- upvalues: Workspace (upval), a3 (upval), u17 (upval), a1 (upval), u20 (upval), dust (upval), u21 (upval)
            -- upvalues: u12 (upval), Fx (upval), u22 (upval), Giant (upval), LookVector (upval), u5 (upval)
            -- upvalues: u23 (upval), u47 (upval), a2 (upval), stop (upval), CurrentCamera (upval)
            -- upvalues: CameraShakerDriver (upval), a1_2 (val)
            local v1
            local v2 = (Workspace:GetServerTimeNow()) - a3
            local v3 = os.clock() - u17
            local Height = a1.Height
            local v4 = a1
            local v5 = math.clamp(v2 / 4.6, 0, 1)
            v4.Rise = (v5 - 1) ^ 3 * 2.2 + 1 + (v5 - 1) ^ 2 * 1.2
            if v2 >= 0 and v2 < 4.6 and 0.55 <= v2 - u20 then
                u20 = v2
                dust(a1)
            end
            if v2 >= 4.6 and not u21 then
                u21 = true
                u12:StopSustained(0.6)
                u12:ShakeOnce(6, 10, 0, 1.4)
                Fx.Sound({"Sounds", "ScrambleBoss", "HeavyLand"}, nil, 1.6)
                Fx.Sound({"Sounds", "MonsterParasite", "Roar"}, nil, 0.9, 0.7)
            end
            if v2 >= 5.45 and a1.EyeTarget < 1 and not u22 then
                Giant.SetEyes(a1, 1.6)
                Fx.Sound({"Sounds", "ScrambleBoss", "Charge"}, nil, 1.1)
            end
            if v2 >= 6.1 and not u22 then
                u22 = true
                Giant.Face(a1, false)
                Giant.SetEyes(a1, 0)
                Fx.Sound({"Sounds", "ScrambleBoss", "Swoosh"}, nil, 1.4, 0.8)
                u12:ShakeOnce(2.5, 14, 0, 0.6)
            end
            local Position = a1.Ground.Position
            local v6 = Position + Vector3.new(0, Height * (0.25 + 0.4 * a1.Rise), 0)
            v4 = CFrame.lookAt(
                Position + LookVector * (Height * (2.7 - math.clamp(v2 / 5.2, 0, 1) * 0.35)) + Vector3.new(0, Height * 0.32, 0),
                v6
            )
            v5 = Giant.HeadPosition(a1)
            local v7 = CFrame.lookAt(v5 + LookVector * (Height * 0.42) - Vector3.new(0, Height * 0.06, 0), v5)
            v5 = v4
            v6 = 55
            if v2 >= 5.2 then
                local v8 = math.clamp((v2 - 5.2) / 0.45, 0, 1)
                v5 = v4:Lerp(v7, if not (v8 < 0.5) then 1 - (v8 * -2 + 2) ^ 3 / 2 else v8 * 4 * v8 * v8)
                v6 = v1 * -21 + 55
            end
            v4 = 1 - (1 - math.clamp(v3 / 1, 0, 1)) ^ 5
            v3 = u5.CFrame:Lerp(v5, v4)
            v6 = u5.FieldOfView + (v6 - u5.FieldOfView) * v4
            if v2 >= 7.5 then
                if not u23 then
                    u23 = true
                    u47.Letterbox(a2, false)
                end
                v1 = math.clamp((v2 - 7.5) / 1.2, 0, 1)
                v3 = v7:Lerp(u5.CFrame, if not (v1 < 0.5) then 1 - (v1 * -2 + 2) ^ 3 / 2 else v1 * 4 * v1 * v1)
                v6 = 34 + (u5.FieldOfView - 34) * v5
                if v5 >= 1 then
                    task.defer(stop)
                end
            end
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.FieldOfView = v6
            CurrentCamera.CFrame = v3 * CameraShakerDriver.Advance(u12, a1_2)
        end)
        if not success then
            warn((("[RedLightGreenLight] cutscene frame failed: %*"):format(err)))
            task.defer(stop)
        end
    end)
    return u24
end

return v1