-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Cinema
-- Decompile time: 7.04 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local State = require(script.Parent.State)
local Trove_2 = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u36 = Trove_2.new()
local u37 = 0
local u38 = false
local u39 = false
local u40 = nil
local u41 = {}

function u41.Shake(a1) -- Line: 27 -- upvalues: u37 (ref) -- types: a1: number
    math.min(u37 + a1, 1)
end

function u41.ShakeAt(a1, a2, a3) -- Line: 31
    -- upvalues: Workspace (val), u41 (val)
    local Magnitude = (Workspace.CurrentCamera.CFrame.Position - a1).Magnitude
    if Magnitude < a3 then
        u41.Shake(a2 * (1 - Magnitude / a3))
    end
end

function u41.Kick(a1) -- Line: 39 -- upvalues: Workspace (val), TweenService (val) -- types: a1: number
    local CurrentCamera = Workspace.CurrentCamera
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = FieldOfView + a1
    TweenService:Create(CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {FieldOfView = FieldOfView}):Play()
end

function u41.Reveal(a1) -- Line: 46
    -- upvalues: Workspace (val), LocalPlayer (val), u38 (ref), State (val), TweenService (val)
    local HumanoidRootPart
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    if (if not Character then nil else Character:FindFirstChild("HumanoidRootPart")) == nil then
        return
    end
    u38 = true
    local v1 = State.Island()
    local Y = if not v1 then HumanoidRootPart.Position.Y else v1:GetPivot().Y
    local v2 = Vector3.new(HumanoidRootPart.CFrame.LookVector.X, 0, HumanoidRootPart.CFrame.LookVector.Z)
    local X_2 = HumanoidRootPart.Position.X
    local v3 = math.max(HumanoidRootPart.Position.Y + 8, Y + 45)
    local Unit = v2.Unit
    if v1 then
        local Position_3 = v1:GetPivot().Position
        Unit = Vector3.new(Position_3.X - HumanoidRootPart.Position.X, 0, Position_3.Z - HumanoidRootPart.Position.Z).Unit
    end
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    v1 = TweenService:Create(CurrentCamera, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        CFrame = CFrame.lookAt((Vector3.new(X_2, v3, HumanoidRootPart.Position.Z)) - v2 * 4, a1),
    })
    v1:Play()
    v1.Completed:Wait()
    task.wait(2.6)
    local v4 = HumanoidRootPart.Position + Vector3.new(0, 4, 0) - Unit * 12
    local v5 = TweenService:Create(
        CurrentCamera,
        TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {
            CFrame = CFrame.lookAt(v4, v4 + Unit * 10 - Vector3.new(0, 1.5, 0)),
        }
    )
    v5:Play()
    v5.Completed:Wait()
    CurrentCamera.CameraType = Enum.CameraType.Custom
    u38 = false
end

local function pickSubject() -- Line: 80 -- upvalues: State (val), LocalPlayer (val)
    local Humanoid_2, Model
    local v1 = State.Me()
    local Character = LocalPlayer.Character
    local Humanoid = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
    if v1 and v1.State == "Alive" then
        return Humanoid
    end
    local Snapshot = State.Snapshot
    if Snapshot and v1 and v1.State == "Down" then
        local v2 = Snapshot.Crystals[v1.Team]
        if v2 and 0 < v2.Health then
            return v2.Model.Crystal.Pivot
        end
    end
    local v3 = nil
    for i, j in State.Entries() do
        Model = j.Model
        Humanoid_2 = if not Model then nil else if j.State ~= "Alive" then nil else Model:FindFirstChildOfClass("Humanoid")
        if Humanoid_2 then
            if v1 ~= nil and j.Team ~= v1.Team then
                v3 = v3 or Humanoid_2
                continue
            end
            return Humanoid_2
        end
    end
    return v3 or Humanoid
end

function u41.Start(a1) -- Line: 108
    -- upvalues: u36 (ref), u37 (ref), u38 (ref), u39 (ref), u40 (ref), RunService (val), Workspace (val), State (val)
    -- upvalues: pickSubject (val), LocalPlayer (val)
    u36 = a1:Extend()
    u37 = 0
    u38 = false
    u39 = false
    u40 = nil
    RunService:BindToRenderStep("CursedIslandWarsShake", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 114
        -- upvalues: Workspace (upval), State (upval), u38 (upval), u39 (upval), u40 (upval), pickSubject (upval)
        -- upvalues: u37 (upval)
        local CurrentCamera = Workspace.CurrentCamera
        local v1 = State.Island()
        local v2 = State.Me()
        if not u38 and v1 then
            local v3
            if State.Phase() ~= "SuddenDeath" then
                if u39 then
                    u39 = false
                    u40 = nil
                    CurrentCamera.CameraType = Enum.CameraType.Custom
                end
                v3 = pickSubject()
                if v3 ~= u40 and v3 then
                    u40 = v3
                    CurrentCamera.CameraSubject = v3
                end
            else
                local Position, v4
                if v2 == nil then
                    Position = v1:GetPivot().Position
                    v4 = os.clock() * 0.12
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    CurrentCamera.CFrame = CFrame.lookAt(Position + Vector3.new(math.cos(v4) * 420, 220, (math.sin(v4)) * 420), Position - Vector3.new(0, 10, 0))
                    u39 = true
                elseif v2.State == "Alive" then
                    if u39 then
                        u39 = false
                        u40 = nil
                        CurrentCamera.CameraType = Enum.CameraType.Custom
                    end
                    v3 = pickSubject()
                    if v3 ~= u40 and v3 then
                        u40 = v3
                        CurrentCamera.CameraSubject = v3
                    end
                else
                    Position = v1:GetPivot().Position
                    v4 = os.clock() * 0.12
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    CurrentCamera.CFrame = CFrame.lookAt(Position + Vector3.new(math.cos(v4) * 420, 220, (math.sin(v4)) * 420), Position - Vector3.new(0, 10, 0))
                    u39 = true
                end
            end
        end
        if State.Phase() == "SuddenDeath" then
            u37 = math.max(u37, 0.22)
        end
        if u37 <= 0 then
            return
        end
        v2 = u37 * u37
        v1 = os.clock() * 30
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(
            math.rad((math.noise(v1, 1)) * 3 * v2),
            math.rad((math.noise(v1, 2)) * 3 * v2),
            (math.rad((math.noise(v1, 3)) * 2 * v2))
        )
        math.max(u37 - a1 * 1.6, 0)
    end)
    u36:Add(function() -- Line: 156 -- upvalues: RunService (upval), Workspace (upval), LocalPlayer (upval)
        RunService:UnbindFromRenderStep("CursedIslandWarsShake")
        local CurrentCamera = Workspace.CurrentCamera
        CurrentCamera.CameraType = Enum.CameraType.Custom
        local Character = LocalPlayer.Character
        local Humanoid = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            CurrentCamera.CameraSubject = Humanoid
        end
    end)
end

return u41