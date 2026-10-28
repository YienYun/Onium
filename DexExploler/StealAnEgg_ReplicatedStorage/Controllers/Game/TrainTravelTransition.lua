-- Script path: ReplicatedStorage.Controllers.Game.TrainTravelTransition
-- Decompile time: 6.83 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Transition = require(script.Parent.HalloweenDimensionController.Transition)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u34 = require(script.Parent.TrainRideCamera)
local TrainTownLighting = require(script.Parent.TrainTownLighting)
local TrainVisuals = require(script.Parent.TrainVisuals)
local u45 = {}
u45.Core = Color3.fromRGB(5, 122, 98)
u45.Edge = Color3.fromRGB(4, 38, 31)
u45.Shade = Color3.fromRGB(69, 242, 195)
u45.Embers = {
    Color3.fromRGB(125, 255, 210),
    Color3.fromRGB(69, 242, 195),
    (Color3.fromRGB(205, 255, 238)),
}
u45.Veil = Color3.fromRGB(4, 38, 31)
u45.VeilTint = ColorSequence.new(Color3.fromRGB(14, 163, 131), Color3.new(1, 1, 1))
u45.PuffTint = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(140, 170, 160))
local LocalPlayer = Players.LocalPlayer
local u107 = 0
local u108 = nil
local u109 = false
local u110 = false
local u111 = {}

local function rootPosition() -- Line: 53 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 then
        return v1.Position
    end
    return nil
end

local function cameraModule() -- Line: 58 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        return require(PlayerModule):GetCameras()
    end
    return nil
end

local function faceForward() -- Line: 67
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
        v2 = CFrame.lookAt(v4 - (v2.Unit * 0.9781476007338057 + Vector3.new(-0, -0.2079116851091385, -0)) * v1, v4)
        CurrentCamera.CFrame = v2
        if v3 then
            v3:CommitCameraCFrame(v2, Enum.CameraType.Custom)
        end
        return
    end
end

function u111.Cover(a1) -- Line: 98
    -- upvalues: u107 (ref), u108 (ref), Player (val), LocalPlayer (val), u109 (ref), Transition (val), u45 (val)
    u107 = u107 + 1
    local v1 = Player.FindRootPart(LocalPlayer)
    u108 = if not v1 then nil else v1.Position
    u109 = true
    Transition.Cover(u45, a1)
end

function u111.Reveal() -- Line: 105 -- upvalues: u109 (ref), Transition (val)
    u109 = false
    Transition.Reveal()
end

function u111.RevealAfterMove(a1, a2, a3) -- Line: 110
    -- upvalues: u107 (ref), u108 (ref), Transition (val), Player (val), LocalPlayer (val), faceForward (val)
    -- upvalues: u111 (val)
    local u3 = u107
    local u4 = u108
    local u6 = os.clock()
    task.spawn(function() -- Line: 114
        -- upvalues: a1 (val), u6 (val), u107 (upval), u3 (val), Transition (upval), Player (upval), LocalPlayer (upval)
        -- upvalues: a2 (val), a3 (val), faceForward (upval), u111 (upval), u4 (val)
        local Character, Humanoid, Position, v1, v2
        if not a1 then
            local Position_2, v3
            while true do
                if not (os.clock() - u6 < 1) then
                    break
                end
                if u107 ~= u3 then
                    return
                end
                v3 = Player.FindRootPart(LocalPlayer)
                Position_2 = if not v3 then nil else v3.Position
                if u4 == nil then
                    break
                end
                if Position_2 and 12 < (Position_2 - u4).Magnitude then
                    break
                end
                task.wait()
            end
            task.wait(0.12)
            if u107 == u3 then
                faceForward()
                u111.Reveal()
            end
            return
        end
        local v4 = nil
        while true do
            if not (os.clock() - u6 < 20) then
                break
            end
            if u107 == u3 and Transition.IsCovering() then
                v1 = Player.FindRootPart(LocalPlayer)
                Position = if not v1 then nil else v1.Position
                Character = LocalPlayer.Character
                Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                v2 = false
                if Character == a2 then
                    v2 = false
                    if Humanoid ~= nil then
                        v2 = false
                        if 0 < Humanoid.Health then
                            v2 = false
                            if Position ~= nil then
                                v2 = (Position - a1).Magnitude <= 24
                            end
                        end
                    end
                end
                if not v2 then
                    v4 = nil
                    task.wait()
                    continue
                end
                v4 = v4 or os.clock()
                if not ((a3 or 0.12) <= os.clock() - v4) then
                    task.wait()
                    continue
                end
                faceForward()
                u111.Reveal()
                return
            end
            return
        end
    end)
end

function u111.Start() -- Line: 165
    -- upvalues: u110 (ref), u34 (val), TrainTownLighting (val), TrainVisuals (val), LocalPlayer (val), u107 (ref)
    -- upvalues: u111 (val), u109 (ref), Remotes (val)
    if u110 then
        return
    end
    u110 = true
    u34.Start()
    TrainTownLighting.Start()
    TrainVisuals.Start()
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 173 -- upvalues: u107 (upval), LocalPlayer (upval), u111 (upval), u109 (upval)
        u107 = u107 + 1
        if LocalPlayer:GetAttribute("TrainEventPhase") == "Respawning" then
            u111.Cover(20)
            return
        end
        if u109 then
            u111.Reveal()
        end
    end)
    Remotes.TrainEvent.Travel.OnClientEvent:Connect(function(a1, a2) -- Line: 181 -- upvalues: u34 (upval), u111 (upval)
        if typeof(a2) ~= "table" then
            a2 = nil
        end
        if a1 == "RideStart" then
            u34.Begin(a2)
            return
        end
        if a1 == "RideEnd" then
            u34.Stop(a2 and a2.Id)
            return
        end
        if a1 == "Cover" then
            u111.Cover(a2 and a2.TimeoutSeconds)
            return
        end
        if a1 == "Reveal" then
            u111.RevealAfterMove(a2 and a2.Destination, a2 and a2.Character, a2 and a2.HoldSeconds)
        end
    end)
end

return u111