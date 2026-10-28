-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.TrexRun.Cutscene
-- Decompile time: 8.66 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local Fx = require(script.Parent.Fx)
local Herd = require(script.Parent.Herd)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Hud = require(script.Parent.Hud)
local TrexRunHerd = require(ReplicatedStorage.Shared.Modules.TrexRunHerd)
local v1 = {}

local function easeInOutCubic(a1) -- Line: 44 -- types: a1: number
    if a1 < 0.5 then
        return a1 * 4 * a1 * a1
    end
    return 1 - (a1 * -2 + 2) ^ 3 / 2
end

local function easeOutQuint(a1) -- Line: 48 -- types: a1: number
    return 1 - (1 - a1) ^ 5
end

local function phase(a1, a2, a3) -- Line: 52 -- types: a1: number, a2: number, a3: number
    return (math.clamp((a1 - a2) / (a3 - a2), 0, 1))
end

function v1.Play(a1, a2, a3, a4) -- Line: 60
    -- upvalues: Workspace (val), TrexRunHerd (val), CameraShaker (val), HiddenUIHandler (val), Herd (val), Hud (val)
    -- upvalues: Fx (val), GuiService (val), RunService (val), CameraShakerDriver (val)
    local CurrentCamera = Workspace.CurrentCamera
    local Course = a1.Course
    local u10 = TrexRunHerd.Forward(Course)
    local u14 = TrexRunHerd.Across(Course)
    local u15 = {
        CFrame = CurrentCamera.CFrame,
        FieldOfView = CurrentCamera.FieldOfView,
        CameraType = CurrentCamera.CameraType,
        CameraSubject = CurrentCamera.CameraSubject,
    }
    local u22 = CameraShaker.new()
    local u25 = HiddenUIHandler.Acquire()
    local u27 = os.clock()
    local v1 = TrexRunHerd.Locate(Course, a4)
    local u34 = Course.Near + 40
    local u38 = math.max(v1 - 140, u34 + 200)
    local u41 = a1.Size.Y * 1.25
    local u43 = Course.LaneWidth * 0.5
    local u53 = Herd.AlphaHead(a1)
    if not u53 then
        u53 = TrexRunHerd.Point(Course, Course.Far, 0)
    end
    local u54 = false
    local u55 = false
    local u56 = false
    local u57 = false
    local u58 = {Done = false}

    function u58.Stop() end

    Hud.SetBoardShown(a2, false)
    Hud.Letterbox(a2, true)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    Fx.Sound({"Sounds", "CinematicRiser"}, nil, 2.2)
    Fx.Sound({"Sounds", "ScrambleBoss", "Rumble"}, nil, 1.4, 0.8)
    if not GuiService.ReducedMotionEnabled then
        u22:ShakeSustain(CameraShaker.Presets.Earthquake)
    end

    local function stop() -- Line: 101
        -- upvalues: u58 (val), RunService (upval), u22 (val), CurrentCamera (val), u15 (val), Hud (upval), a2 (val)
        -- upvalues: u25 (val)
        if u58.Done then
            return
        end
        u58.Done = true
        local v1 = RunService
        pcall(RunService.UnbindFromRenderStep, v1, "TrexRunCutscene")
        u22:StopSustained(0.2)
        CurrentCamera.CFrame = u15.CFrame
        CurrentCamera.FieldOfView = u15.FieldOfView
        CurrentCamera.CameraType = u15.CameraType
        if u15.CameraSubject ~= nil and u15.CameraSubject.Parent ~= nil then
            CurrentCamera.CameraSubject = u15.CameraSubject
        end
        Hud.Letterbox(a2, false)
        Hud.SetBoardShown(a2, true)
        u25()
    end

    u58.Stop = stop

    local function flyShot(a1_2) -- Line: 124
        -- upvalues: u34 (val), u38 (val), Course (val), TrexRunHerd (upval), u43 (val), u41 (val), a1 (val)
        local v1 = math.clamp((a1_2 - 0) / 3.6, 0, 1)
        local v2 = if not (v1 < 0.5) then 1 - (v1 * -2 + 2) ^ 3 / 2 else v1 * 4 * v1 * v1
        v1 = u34 + (u38 - u34) * v2
        v2 = (math.sin(a1_2 * 1.7)) * Course.LaneWidth * 0.35
        return (CFrame.lookAt(
            (TrexRunHerd.Point(Course, v1, u43 + v2)) + Vector3.new(0, u41, 0),
            (TrexRunHerd.Point(Course, v1 + 260, u43 * 0.3)) + Vector3.new(0, a1.Size.Y * 0.35, 0)
        )), 68
    end

    local function eggShot(a1) -- Line: 135 -- upvalues: u10 (val), u14 (val), a4 (val) -- types: a1: number
        local v1 = math.clamp((a1 - 3.6) / 1.6, 0, 1)
        local v2 = math.rad(v1 * 50 + -35)
        local v3 = 46 - v1 * 12
        return (CFrame.lookAt(a4 + (u10 * -math.cos(v2) + u14 * (math.sin(v2))) * v3 + Vector3.new(0, 14 - v1 * 4, 0), a4 + Vector3.new(0, 3, 0))), 42
    end

    local function alphaShot(a1_2) -- Line: 145
        -- upvalues: a1 (val), u53 (val), u10 (val), u14 (val)
        local v1 = math.clamp((a1_2 - 5.2) / 1.8999999999999995, 0, 1)
        return (CFrame.lookAt(
            u53 - u10 * (a1.Size.Z * (4.2 - v1 * 0.9)) - Vector3.new(0, a1.Size.Y * (1.1 - v1 * 0.2), 0) + u14 * (a1.Size.X * 0.8),
            u53
        )), 50
    end

    RunService:BindToRenderStep("TrexRunCutscene", Enum.RenderPriority.Camera.Value + 1, function(a1_2) -- Line: 159
        -- upvalues: Workspace (upval), a3 (val), flyShot (val), eggShot (val), alphaShot (val), u55 (ref), u22 (val)
        -- upvalues: u54 (ref), Herd (upval), a1 (val), Fx (upval), u56 (ref), Hud (upval), a2 (val), u27 (val)
        -- upvalues: u15 (val), u57 (ref), stop (val), CurrentCamera (val), CameraShakerDriver (upval)
        local success, err = pcall(function() -- Line: 160
            -- upvalues: Workspace (upval), a3 (upval), flyShot (upval), eggShot (upval), alphaShot (upval), u55 (upval)
            -- upvalues: u22 (upval), u54 (upval), Herd (upval), a1 (upval), Fx (upval), u56 (upval), Hud (upval)
            -- upvalues: a2 (upval), u27 (upval), u15 (upval), u57 (upval), stop (upval), CurrentCamera (upval)
            -- upvalues: CameraShakerDriver (upval), a1_2 (val)
            local v1, v2, v3, v4, v5
            local v6 = (Workspace:GetServerTimeNow()) - a3
            if v6 < 3.6 then
                v3, v4 = flyShot(v6)
                v1 = v3
                v2 = v4
            elseif not (v6 < 5.2) then
                v3, v4 = alphaShot(v6)
                v1 = v3
                v2 = v4
                v3 = math.clamp((v6 - 5.2) / 0.34999999999999964, 0, 1)
                if v3 < 1 then
                    v4, v5 = eggShot(5.2)
                    v1 = v4:Lerp(v1, 1 - (1 - v3) ^ 5)
                    v2 = v5 + (v2 - v5) * v3
                end
            else
                v3, v4 = eggShot(v6)
                v1 = v3
                v2 = v4
                v3 = math.clamp((v6 - 3.6) / 0.3500000000000001, 0, 1)
                if v3 < 1 then
                    v4, v5 = flyShot(3.6)
                    v1 = v4:Lerp(v1, 1 - (1 - v3) ^ 5)
                    v2 = v5 + (v2 - v5) * v3
                end
            end
            if v6 >= 3.6 and not u55 then
                u55 = true
                u22:StopSustained(0.5)
            end
            if v6 >= 5.75 and not u54 then
                u54 = true
                Herd.Roar(a1, 1.4)
                u22:ShakeOnce(7, 12, 0, 1.6)
                Fx.Sound({"Sounds", "ScrambleBoss", "HeavyLand"}, nil, 1.4)
            end
            if v6 >= 7.1 and not u56 then
                u56 = true
                Hud.SetBoardShown(a2, true)
                Fx.Sound({"Sounds", "ScrambleBoss", "Swoosh"}, nil, 1.4, 0.8)
            end
            v3 = 1 - (1 - math.clamp((os.clock() - u27) / 0.9, 0, 1)) ^ 5
            v4 = u15.CFrame:Lerp(v1, v3)
            v2 = u15.FieldOfView + (v2 - u15.FieldOfView) * v3
            if v6 >= 7.1 then
                local v7
                if not u57 then
                    u57 = true
                    Hud.Letterbox(a2, false)
                end
                v5 = math.clamp((v6 - 7.1) / 1.3000000000000007, 0, 1)
                v3 = if not (v5 < 0.5) then 1 - (v5 * -2 + 2) ^ 3 / 2 else v5 * 4 * v5 * v5
                v5, v7 = alphaShot(7.1)
                v4 = v5:Lerp(u15.CFrame, v3)
                v2 = v7 + (u15.FieldOfView - v7) * v3
                if v3 >= 1 then
                    task.defer(stop)
                end
            end
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.FieldOfView = v2
            CurrentCamera.CFrame = v4 * CameraShakerDriver.Advance(u22, a1_2)
        end)
        if not success then
            warn((("[TrexRun] cutscene frame failed: %*"):format(err)))
            task.defer(stop)
        end
    end)
    return u58
end

return table.freeze(v1)