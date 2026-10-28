-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock.Shot
-- Decompile time: 6.30 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Kit = require(script.Parent.Parent.Parent.SewerCaveController.Transition.Kit)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Color3.new(1, 1, 1)
local u40 = nil
local u41 = {}
u41.Looks = table.freeze({
    Clear = Kit.Looks.Clear,
    Keyhole = table.freeze({
        Brightness = 0.04,
        Contrast = 0.12,
        Saturation = 0.15,
        Bloom = 1.2,
        Blur = 0,
        Tint = Color3.fromRGB(255, 228, 200),
    }),
    Spill = table.freeze({
        Brightness = -0.04,
        Contrast = 0.16,
        Saturation = 0.1,
        Bloom = 1,
        Blur = 0,
        Tint = Color3.fromRGB(255, 232, 205),
    }),
})
u41.White = v1

local function cameraModule() -- Line: 66 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        local success, err = pcall(require, PlayerModule)
        if success then
            return (err:GetCameras())
        end
        return nil
    end
    return nil
end

local function hideHud() -- Line: 76 -- upvalues: LocalPlayer (val)
    local v1 = {}
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui == nil then
        return v1
    end
    for i, j in PlayerGui:GetChildren() do
        if j:IsA("ScreenGui") and j.Enabled then
            j.Enabled = false
            table.insert(v1, j)
        end
    end
    return v1
end

local function restore(a1) -- Line: 91 -- upvalues: u40 (ref), cameraModule (val) -- types: a1: table
    a1.Done = true
    if u40 == a1 then
        u40 = nil
    end
    for i, j in a1.Hidden do
        if j.Parent ~= nil then
            j.Enabled = true
        end
    end
    table.clear(a1.Hidden)
    if not a1.Owns then
        return
    end
    local Camera = a1.Camera
    Camera.FieldOfView = a1.FieldOfView
    local HandBack = a1.HandBack
    if HandBack ~= nil then
        Camera.CFrame = HandBack
    end
    local u26 = a1.Commit or HandBack
    local u28 = cameraModule()
    if u26 ~= nil and u28 ~= nil then
        pcall(function() -- Line: 114 -- upvalues: u28 (val), u26 (val)
            u28:CommitCameraCFrame(u26, Enum.CameraType.Custom)
        end)
    end
end

function u41.Take() -- Line: 124
    -- upvalues: u41 (val), Workspace (val), Trove (val), GuiService (val), Kit (val), hideHud (val), restore (val)
    -- upvalues: u40 (ref)
    u41.Drop()
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    local v1 = Trove.new()
    local u9 = {
        Done = false,
        Trove = v1,
        Camera = CurrentCamera,
        FieldOfView = CurrentCamera.FieldOfView,
    }
    u9.Owns = CurrentCamera.CameraType == Enum.CameraType.Custom
    u9.Calm = GuiService.ReducedMotionEnabled
    u9.Low = Kit.LowQuality()
    u9.Grade = Kit.Grade(v1, CurrentCamera)
    u9.Hidden = hideHud()
    v1:Add(function() -- Line: 144 -- upvalues: restore (upval), u9 (val)
        restore(u9)
    end)
    u40 = u9
    return u9
end

function u41.Release(a1, a2, a3) -- Line: 151 -- types: a1: table, a2: userdata?, a3: userdata?
    if a1.Done then
        return
    end
    if a2 ~= nil then
        a1.HandBack = a2
    end
    if a3 ~= nil then
        a1.Commit = a3
    end
    a1.Trove:Destroy()
end

function u41.Drop() -- Line: 164 -- upvalues: u40 (ref), u41 (val)
    local v1 = u40
    u40 = nil
    if v1 ~= nil then
        u41.Release(v1, nil)
    end
end

function u41.Look(a1, a2, a3, a4, a5) -- Line: 172 -- upvalues: Kit (val) -- types: a1: table, a4: number, a5: number?
    Kit.Mix(a1.Grade.Look, a2, a3, a4)
    Kit.Apply(a1.Grade, a5 or 0)
end

function u41.Place(a1, a2, a3) -- Line: 177 -- types: a1: table, a2: userdata, a3: number?
    if a1.Owns and not a1.Done then
        a1.Camera.CFrame = a2
        if a3 ~= nil then
            a1.Camera.FieldOfView = a3
        end
        return
    end
end

function u41.Reach() -- Line: 187 -- upvalues: cameraModule (val), Workspace (val)
    local v1 = cameraModule()
    local CameraToSubjectDistance = if v1 == nil then nil else v1:GetCameraToSubjectDistance()
    if CameraToSubjectDistance ~= nil then
        return (math.max(CameraToSubjectDistance, 4))
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        return (math.max((CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude, 4))
    end
    return 12
end

function u41.Pose(a1, a2, a3) -- Line: 199
    -- upvalues: cameraModule (val)
    local v1 = cameraModule()
    v1 = (if v1 == nil then nil else v1:GetCameraSubjectPosition()) or a1.Position + Vector3.new(0, 1.5, 0)
    return CFrame.lookAt(v1 - a2.Unit * a3, v1)
end

function u41.Face(a1, a2) -- Line: 206
    -- upvalues: Workspace (val), Kit (val), cameraModule (val), u41 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Custom then
        local v1 = Kit.FlatUnit(a2, a1.CFrame.LookVector)
        local v2 = cameraModule()
        local v3 = (if v2 == nil then nil else v2:GetCameraSubjectPosition()) or a1.Position + Vector3.new(0, 1.5, 0)
        local v4 = u41.Reach()
        v1 = CFrame.lookAt(v3 - (v1 * 0.9781476007338057 + Vector3.new(-0, -0.2079116851091385, -0)) * v4, v3)
        CurrentCamera.CFrame = v1
        if v2 ~= nil then
            v2:CommitCameraCFrame(v1, Enum.CameraType.Custom)
        end
        return
    end
end

return (table.freeze(u41))