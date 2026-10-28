-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.VaultSequence
-- Decompile time: 18.59 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local GearToolLookup = require(ReplicatedStorage.Shared.Util.GearToolLookup)
local Gears = require(ReplicatedStorage.Data.Gears)
local ScrambleVaultPresentation = require(ReplicatedStorage.Shared.Util.ScrambleVaultPresentation)
local LocalPlayer = Players.LocalPlayer
local u49 = {}
local u53 = setmetatable({}, {__mode = "k"})
local u54 = nil

local function eased(a1) -- Line: 21 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
end

local function closedDoor(a1) -- Line: 24 -- upvalues: u53 (val) -- types: a1: userdata
    if not u53[a1] then
        u53[a1] = (a1:GetPivot())
    end
    return u53[a1]
end

function u49.IsPlaying() -- Line: 28 -- upvalues: u54 (ref)
    return u54 ~= nil
end

function u49.SetOpen(a1, a2) -- Line: 31
    -- upvalues: u54 (ref), ScrambleVaultPresentation (val), u53 (val)
    if u54 and u54.Vault == a1 then
        return
    end
    local v1 = ScrambleVaultPresentation.Assets(a1)
    if v1 then
        local DoorPose = ScrambleVaultPresentation.DoorPose
        if not u53[v1] then
            u53[v1] = (v1:GetPivot())
        end
        v1:PivotTo((DoorPose(u53[v1], if not a2 then 0 else 1, (a1:GetAttribute("DoorOpenAngleDegrees")))))
    end
end

local function safely(a1) -- Line: 36 -- types: a1: function
    local success, err = pcall(a1)
    if not success then
        warn("[Scramble] Vault cleanup:", err)
    end
end

local function restoreCamera(a1) -- Line: 40 -- upvalues: LocalPlayer (val)
    if not a1.OwnsCamera then
        return
    end
    a1.OwnsCamera = false
    local Camera = a1.Camera
    if (Camera:GetAttribute("ScrambleVaultCameraOwner")) ~= a1.Id then
        return
    end
    Camera:SetAttribute("ScrambleVaultCameraOwner", nil)
    if Camera.CameraType ~= Enum.CameraType.Scriptable then
        return
    end
    Camera.CameraType = a1.CameraType
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character ~= a1.Character or not Camera.CameraSubject or not Camera.CameraSubject.Parent then
        Camera.CameraSubject = Humanoid
    end
    if workspace.CurrentCamera == Camera and Character == a1.Character then
        local v1
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        Camera.CFrame = a1.CameraFrame + (if not HumanoidRootPart then Vector3.new(0, 0, 0) else HumanoidRootPart.Position - a1.Origin)
        Camera.Focus = a1.Focus + v1
    end
end

local function releasePresentation(a1) -- Line: 60 -- upvalues: ContextActionService (val), restoreCamera (val)
    local success, err = pcall(function() -- Line: 61 -- upvalues: ContextActionService (upval)
        ContextActionService:UnbindAction("ScrambleVaultMovement")
    end)
    if not success then
        warn("[Scramble] Vault cleanup:", err)
    end
    local success_2, err_2 = pcall(function() -- Line: 62 -- upvalues: ContextActionService (upval)
        ContextActionService:UnbindAction("ScrambleVaultSkip")
    end)
    if not success_2 then
        warn("[Scramble] Vault cleanup:", err_2)
    end
    local success_3, err_3 = pcall(function() -- Line: 63 -- upvalues: restoreCamera (upval), a1 (val)
        restoreCamera(a1)
    end)
    if not success_3 then
        warn("[Scramble] Vault cleanup:", err_3)
    end
    local ReleaseUI = a1.ReleaseUI
    a1.ReleaseUI = nil
    if ReleaseUI then
        local success_4, err_4 = pcall(ReleaseUI)
        if not success_4 then
            warn("[Scramble] Vault cleanup:", err_4)
        end
    end
end

function u49.Stop(a1) -- Line: 68
    -- upvalues: u54 (ref), RunService (val), releasePresentation (val), ScrambleVaultPresentation (val)
    local u1 = u54
    if not u1 then
        return
    end
    u54 = nil
    local success, err = pcall(function() -- Line: 72 -- upvalues: RunService (upval)
        RunService:UnbindFromRenderStep("ScrambleVaultReward")
    end)
    if not success then
        warn("[Scramble] Vault cleanup:", err)
    end
    releasePresentation(u1)
    if u1.Weapon then
        local success_2, err_2 = pcall(function() -- Line: 74 -- upvalues: u1 (val)
            u1.Weapon:Destroy()
        end)
        if not success_2 then
            warn("[Scramble] Vault cleanup:", err_2)
        end
    end
    local success_3, err_3 = pcall(function() -- Line: 75 -- upvalues: u1 (val), ScrambleVaultPresentation (upval), a1 (val)
        if u1.Door.Parent then
            u1.Door:PivotTo((ScrambleVaultPresentation.DoorPose(u1.Closed, if not a1 then 0 else 1, u1.Angle)))
        end
    end)
    if not success_3 then
        warn("[Scramble] Vault cleanup:", err_3)
    end
end

function u49.Finish(a1, a2) -- Line: 81 -- upvalues: u54 (ref), u49 (val) -- types: a1: string, a2: boolean
    if u54 and u54.Id == a1 then
        u49.Stop(a2)
    end
end

local function weaponModel(a1) -- Line: 84 -- upvalues: Gears (val), GearToolLookup (val) -- types: a1: string
    local v1 = Gears.Directory[a1]
    local v2 = v1 and GearToolLookup(v1.ToolModel or a1)
    if not v2 then
        return nil
    end
    v1 = Instance.new("Model")
    v1.Name = "ScramblerRewardVisual"
    local Handle = v2:FindFirstChild("Handle")
    if Handle and Handle:IsA("BasePart") then
        local v3
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                v3 = j:Clone()
                for k, n in v3:GetDescendants() do
                    if n:IsA("LuaSourceContainer")
                        or n:IsA("JointInstance")
                        or n:IsA("Constraint")
                        or n:IsA("BasePart")
                        or n:IsA("ProximityPrompt")
                        or n:IsA("ClickDetector")
                        or n:IsA("TouchTransmitter")
                        or n:IsA("Tool") then
                        n:Destroy()
                    end
                end
                v3.Anchored = true
                v3.CanCollide = false
                v3.CanTouch = false
                v3.CanQuery = false
                v3.LocalTransparencyModifier = 0
                v3.Parent = v1
            end
        end
        v1.WorldPivot = Handle.CFrame
        return v1
    end
    v1:Destroy()
    return nil
end

function u49.Start(a1, a2) -- Line: 108
    -- upvalues: u54 (ref), ScrambleVaultPresentation (val), LocalPlayer (val), weaponModel (val), u53 (val)
    -- upvalues: HiddenUIHandler (val), GuiService (val), releasePresentation (val), u49 (val)
    -- upvalues: ContextActionService (val), RunService (val), TweenService (val), eased (val)
    if not u54
        and type(a2) == "table"
        and type(a2.Id) == "string"
        and type(a2.Gear) == "string"
        and type(a2.StartedAt) == "number" then
        local u18, v1
        u18, _, v1 = ScrambleVaultPresentation.Assets(a1)
        local Character = LocalPlayer.Character
        local Humanoid = Character
        if Humanoid then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
        end
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local CurrentCamera = workspace.CurrentCamera
        if u18 and v1 and HumanoidRootPart and Humanoid and not (Humanoid.Health <= 0) and CurrentCamera then
            local u49_2 = weaponModel(a2.Gear)
            if not u49_2 then
                return
            end
            if not u53[u18] then
                u53[u18] = (u18:GetPivot())
            end
            local u58 = u53[u18]
            local Position = u18:GetBoundingBox().Position
            local v2 = Vector3.new(Position.X - v1.Position.X, 0, Position.Z - v1.Position.Z)
            local Unit = if not (0.1 < v2.Magnitude) then Vector3.new(0, 0, -1) else v2.Unit
            local u81 = Position + Vector3.new(0, 0.5, 0)
            local v3 = u81 + Unit * 10
            local v4 = Unit
            local v5 = v3 + Vector3.new(0, 1, 0):Cross(v4) * 2.5 + Vector3.new(0, 2, 0)
            local v6 = RaycastParams.new()
            v6.FilterType = Enum.RaycastFilterType.Exclude
            v6.FilterDescendantsInstances = {Character, u18}
            v6.RespectCanCollide = true
            v3 = workspace:Raycast(u81, v5 - u81, v6)
            if v3 then
                v5 = v3.Position + v3.Normal * 0.5
            end
            local u128 = false
            if CurrentCamera.CameraType == Enum.CameraType.Custom then
                u128 = not HiddenUIHandler.IsHidden()
                if u128 then
                    u128 = not GuiService.ReducedMotionEnabled
                end
            end
            local u129 = {Id = a2.Id, Vault = a1, Door = u18, Closed = u58}
            u129.Angle = a1:GetAttribute("DoorOpenAngleDegrees")
            u129.Weapon = u49_2
            u129.Spawn = v1.CFrame
            u129.Outward = Unit
            u129.StartedAt = a2.StartedAt
            u129.Character = Character
            u129.Humanoid = Humanoid
            u129.Origin = HumanoidRootPart.Position
            u129.Camera = CurrentCamera
            u129.CameraFrame = CurrentCamera.CFrame
            u129.CameraType = CurrentCamera.CameraType
            u129.FOV = CurrentCamera.FieldOfView
            u129.Focus = CurrentCamera.Focus
            u129.Subject = CurrentCamera.CameraSubject
            u129.OwnsCamera = u128
            u129.Shot = CFrame.lookAt(v5, u81)
            u54 = u129
            task.delay(ScrambleVaultPresentation.Duration + 0.75, function() -- Line: 141 -- upvalues: u54 (upval), u129 (val), releasePresentation (upval)
                if u54 == u129 then
                    releasePresentation(u129)
                end
            end)
            task.delay(ScrambleVaultPresentation.Duration + 8, function() -- Line: 144 -- upvalues: u54 (upval), u129 (val), u49 (upval)
                if u54 == u129 then
                    u49.Stop(false)
                end
            end)
            local success, result = xpcall(function() -- Line: 147
                -- upvalues: u18 (val), u58 (val), u49_2 (val), ScrambleVaultPresentation (upval), u129 (val)
                -- upvalues: u128 (val), CurrentCamera (val), HiddenUIHandler (upval), ContextActionService (upval)
                -- upvalues: u54 (upval), releasePresentation (upval), RunService (upval), Character (val)
                -- upvalues: LocalPlayer (upval), Humanoid (val), a1 (val), u49 (upval), TweenService (upval)
                -- upvalues: Unit (ref), eased (upval), u81 (val)
                u18:PivotTo(u58)
                u49_2:ScaleTo(ScrambleVaultPresentation.DisplayScale)
                u49_2:PivotTo(u129.Spawn)
                u49_2.Parent = workspace
                if u128 then
                    CurrentCamera:SetAttribute("ScrambleVaultCameraOwner", u129.Id)
                    u129.ReleaseUI = HiddenUIHandler.Acquire()
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    local v1 = ContextActionService
                    local v2 = Enum.ContextActionPriority.High.Value + 100
                    local v3 = table.unpack((Enum.PlayerActions:GetEnumItems()))
                    v1:BindActionAtPriority("ScrambleVaultMovement", function() -- Line: 156
                        return Enum.ContextActionResult.Sink
                    end, false, v2, v3)
                    v1 = ContextActionService
                    v2 = Enum.ContextActionPriority.High.Value + 101
                    local Escape = Enum.KeyCode.Escape
                    local ButtonB = Enum.KeyCode.ButtonB
                    v1:BindActionAtPriority("ScrambleVaultSkip", function(a1, a2) -- Line: 158 -- upvalues: u54 (upval), u129 (upval), releasePresentation (upval)
                        if a2 == Enum.UserInputState.Begin and u54 == u129 then
                            releasePresentation(u129)
                        end
                        return Enum.ContextActionResult.Pass
                    end, false, v2, Escape, ButtonB)
                end
                RunService:BindToRenderStep("ScrambleVaultReward", Enum.RenderPriority.Camera.Value + 2, function() -- Line: 163
                    -- upvalues: u54 (upval), u129 (upval), Character (upval), LocalPlayer (upval), Humanoid (upval)
                    -- upvalues: a1 (upval), u18 (upval), u49 (upval), ScrambleVaultPresentation (upval), u58 (upval)
                    -- upvalues: TweenService (upval), u49_2 (upval), Unit (upval), CurrentCamera (upval)
                    -- upvalues: releasePresentation (upval), eased (upval), u81 (upval)
                    local success, result = xpcall(function() -- Line: 164
                        -- upvalues: u54 (upval), u129 (upval), Character (upval), LocalPlayer (upval), Humanoid (upval)
                        -- upvalues: a1 (upval), u18 (upval), u49 (upval), ScrambleVaultPresentation (upval)
                        -- upvalues: u58 (upval), TweenService (upval), u49_2 (upval), Unit (upval)
                        -- upvalues: CurrentCamera (upval), releasePresentation (upval), eased (upval), u81 (upval)
                        if u54 ~= u129 then
                            return
                        end
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        if LocalPlayer.Character == Character and not (Humanoid.Health <= 0) and HumanoidRootPart then
                            local v1 = a1
                            local v2 = workspace
                            if v1:IsDescendantOf(v2)
                                and u18.Parent
                                and not (35 < (HumanoidRootPart.Position - u129.Origin).Magnitude) then
                                local v3
                                v1 = math.max(0, (workspace:GetServerTimeNow()) - u129.StartedAt)
                                local v4 = u18
                                local DoorPose = ScrambleVaultPresentation.DoorPose
                                local v5 = u58
                                local v6 = (v1 - ScrambleVaultPresentation.DoorStart) / ScrambleVaultPresentation.DoorSeconds
                                v4:PivotTo((DoorPose(
                                    v5,
                                    TweenService:GetValue(math.clamp(v6, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
                                    u129.Angle
                                )))
                                if v1 < ScrambleVaultPresentation.Duration then
                                    u49_2.Parent = workspace
                                    v4 = math.clamp(
                                        (v1 - ScrambleVaultPresentation.FlyAt) / (ScrambleVaultPresentation.Duration - ScrambleVaultPresentation.FlyAt),
                                        0,
                                        1
                                    )
                                    local Position = u129.Spawn.Position
                                    v3 = HumanoidRootPart.Position + Vector3.new(0, 1, 0)
                                    v5 = Position + Unit * 5 + Vector3.new(0, 3, 0)
                                    local Value_2 = TweenService:GetValue(math.clamp(v4, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
                                    u49_2:ScaleTo(ScrambleVaultPresentation.DisplayScale + (1 - ScrambleVaultPresentation.DisplayScale) * Value_2)
                                    v6 = (1 - Value_2) ^ 2 * Position + (1 - Value_2) * 2 * Value_2 * v5 + Value_2 ^ 2 * v3
                                    u49_2:PivotTo((CFrame.new(v6)) * u129.Spawn.Rotation * (CFrame.Angles(0, v4 * 3.141592653589793 * 2, 0)))
                                elseif ScrambleVaultPresentation.Duration <= v1 then
                                    u49_2.Parent = nil
                                end
                                if u129.OwnsCamera then
                                    if workspace.CurrentCamera ~= CurrentCamera
                                        or CurrentCamera.CameraType ~= Enum.CameraType.Scriptable
                                        or CurrentCamera.CameraSubject ~= u129.Subject then
                                        releasePresentation(u129)
                                    elseif (CurrentCamera:GetAttribute("ScrambleVaultCameraOwner")) == u129.Id then
                                        Humanoid:Move((Vector3.new(0, 0, 0)))
                                        v2 = (v1 - ScrambleVaultPresentation.FlyAt) / (ScrambleVaultPresentation.Duration - ScrambleVaultPresentation.FlyAt)
                                        v4 = TweenService:GetValue(math.clamp(v2, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
                                        v2 = u129.CameraFrame + (HumanoidRootPart.Position - u129.Origin)
                                        v3 = u129.CameraFrame:Lerp(u129.Shot, (eased(v1 / ScrambleVaultPresentation.CameraIn)))
                                        CurrentCamera.CFrame = v3:Lerp(v2, v4)
                                        CurrentCamera.Focus = (CFrame.new(u81)):Lerp(u129.Focus + (HumanoidRootPart.Position - u129.Origin), v4)
                                        if ScrambleVaultPresentation.Duration <= v1 then
                                            releasePresentation(u129)
                                        end
                                    else
                                        releasePresentation(u129)
                                    end
                                end
                                if ScrambleVaultPresentation.Duration + 8 < v1 then
                                    u49.Stop(false)
                                end
                                return
                            end
                        end
                        u49.Stop(false)
                    end, debug.traceback)
                    if not success then
                        u49.Stop(false)
                        warn("[Scramble] Vault animation failed:", result)
                    end
                end)
            end, debug.traceback)
            if not success then
                u49.Stop(false)
                warn("[Scramble] Vault animation could not start:", result)
            end
            return
        end
        return
    end
end

return u49