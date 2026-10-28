-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Cine
-- Decompile time: 5.21 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u25 = {DialogueFov = 50}
local u27 = nil

local function flatUnit(a1, a2) -- Line: 33 -- types: a1: vector, a2: vector
    local v1 = a1 * Vector3.new(1, 0, 1)
    if 0.05 < v1.Magnitude then
        return v1.Unit
    end
    return a2
end

function u25.Unclip(a1, a2, a3) -- Line: 38
    -- upvalues: LocalPlayer (val), Workspace (val)
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    local v2 = {}
    if LocalPlayer.Character then
        table.insert(v2, LocalPlayer.Character)
    end
    for i, j in a3 or {} do
        table.insert(v2, j)
    end
    v1.FilterDescendantsInstances = v2
    v2 = a2 - a1
    local v3 = Workspace:Raycast(a1, v2, v1)
    if v3 == nil then
        return a2
    end
    return a1 + v2.Unit * (math.max((v3.Position - a1).Magnitude - 0.6, 1))
end

function u25.OverShoulder(a1, a2, a3) -- Line: 58 -- upvalues: u25 (val) -- types: a1: vector, a2: vector, a3: table?
    local Unit
    local v1 = a3 or {}
    local v2 = (a2 - a1) * Vector3.new(1, 0, 1)
    local v3 = (if not (0.05 < v2.Magnitude) then Vector3.new(0, 0, 1) else v2.Unit):Cross((Vector3.new(0, 1, 0)))
    v2 = a1 - Unit * (v1.Back or 6) + v3 * (v1.Side or 2) + Vector3.new(0, v1.Lift or 0.6, 0)
    v2 = u25.Unclip(a1 + Vector3.new(0, 0.5, 0), v2, v1.Exclude)
    return CFrame.lookAt(v2, a2)
end

function u25.Close(a1, a2, a3, a4, a5, a6) -- Line: 70
    -- upvalues: u25 (val)
    local Unit
    local v1 = (a2 - a1) * Vector3.new(1, 0, 1)
    v1 = a1 + (if not (0.05 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit):Cross((Vector3.new(0, 1, 0))) * a3 + Unit * a4 + Vector3.new(0, a5, 0)
    v1 = u25.Unclip(a1, v1, a6)
    return CFrame.lookAt(v1, a2)
end

function u25.TwoShot(a1, a2, a3, a4, a5, a6) -- Line: 85
    -- upvalues: u25 (val)
    local v1 = (a2 - a1) * Vector3.new(1, 0, 1)
    local v2 = (if not (0.05 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit):Cross((Vector3.new(0, 1, 0)))
    local v3 = (a1 + a2) * 0.5
    return CFrame.lookAt(u25.Unclip(v3, v3 + v2 * a3 * a4 + Vector3.new(0, a5, 0), a6), v3)
end

function u25.Hold() -- Line: 101 -- upvalues: u27 (ref)
    u27 = 70
end

function u25.RestingFov() -- Line: 105 -- upvalues: u27 (ref)
    return u27 or 70
end

function u25.Settle(a1) -- Line: 109 -- upvalues: u27 (ref), Workspace (val), Fx (val) -- types: a1: number
    local v1 = u27
    u27 = nil
    if v1 == nil then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if not (a1 <= 0) and not ((math.abs(CurrentCamera.FieldOfView - v1)) < 0.05) then
        Fx.Tween(CurrentCamera, a1, {FieldOfView = v1}, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        return
    end
    CurrentCamera.FieldOfView = v1
end

function u25.Blend(a1, a2, a3) -- Line: 129
    -- upvalues: Workspace (val), Fx (val)
    local v1, v2
    local CurrentCamera = Workspace.CurrentCamera
    local CFrame = CurrentCamera.CFrame
    local FieldOfView = CurrentCamera.FieldOfView
    local v3 = os.clock()
    while true do
        v1 = math.min((os.clock() - v3) / a2, 1)
        v2 = Fx.Ease(v1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        CurrentCamera.CFrame = CFrame:Lerp(a1, v2)
        CurrentCamera.FieldOfView = FieldOfView + ((a3 or FieldOfView) - FieldOfView) * v2
        if v1 >= 1 then
            break
        end
        task.wait()
    end
end

function u25.Cut(a1, a2) -- Line: 147 -- upvalues: Workspace (val) -- types: a1: userdata, a2: number?
    local CurrentCamera = Workspace.CurrentCamera
    CurrentCamera.CFrame = a1
    if a2 then
        CurrentCamera.FieldOfView = a2
    end
end

function u25.SpeedLens(a1, a2, a3) -- Line: 155 -- types: a1: number, a2: number, a3: number?
    local u3 = nil
    local u4 = 0
    local u5 = a3 or 8
    return function(a1_2, a2_2, a3) -- Line: 163
        -- upvalues: u3 (ref), a1 (val), a2 (val), u4 (ref), u5 (val)
        local v1 = if not u3 then 0 else if not (a2_2 > 0) then 0 else (a1_2 - u3).Magnitude / a2_2
        u3 = a1_2
        local v2 = math.min(v1 * a1, a2)
        u4 = u4 + (v2 - u4) * (1 - math.exp(-math.max(a2_2, 0) * u5))
        return a3 + u4
    end
end

function u25.Take(a1) -- Line: 172 -- upvalues: Workspace (val), u25 (val)
    local CurrentCamera = Workspace.CurrentCamera
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    a1:Add(function() -- Line: 175 -- upvalues: CurrentCamera (val), u25 (upval)
        CurrentCamera.FieldOfView = u25.RestingFov()
    end)
    return CurrentCamera
end

function u25.Release(a1, a2) -- Line: 181 -- upvalues: Workspace (val), u25 (val) -- types: a1: userdata, a2: userdata
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = a2.CFrame.LookVector * Vector3.new(1, 0, 1)
    local v2 = CFrame.lookAt(
        a2.Position - (if not (0.05 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit) * 12 + Vector3.new(0, 4.5, 0),
        a2.Position + Vector3.new(0, 1.5, 0)
    )
    u25.Blend(v2, 0.6, u25.RestingFov())
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = a1
    CurrentCamera.CFrame = v2
end

return (table.freeze(u25))