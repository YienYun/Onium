-- Script path: ReplicatedStorage.Controllers.Game.BeeEffectController
-- Decompile time: 5.78 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:WaitForChild("PlayerScripts")
local u43 = require(v1:WaitForChild("PlayerModule")):GetControls()
local u44 = nil
local u45 = false
local u46 = false
local u47 = {}

local function StopEffect(a1) -- Line: 32 -- upvalues: u44 (ref) -- types: a1: table
    if u44 ~= a1 then
        return
    end
    u44 = nil
    a1.Trove:Destroy()
end

function u47.SetTrainCameraActive(a1) -- Line: 41 -- upvalues: u46 (ref), u44 (ref) -- types: a1: boolean
    u46 = a1
    if a1 and u44 then
        local v1 = u44
        if u44 ~= v1 then
            return
        end
        u44 = nil
        v1.Trove:Destroy()
    end
end

function u47.Start() -- Line: 48 -- upvalues: u45 (ref), LocalPlayer (val), u44 (ref)
    if u45 then
        return
    end
    u45 = true
    LocalPlayer.CharacterRemoving:Connect(function(a1) -- Line: 54 -- upvalues: u44 (upval) -- types: a1: userdata
        local v1 = u44
        if v1 and v1.Character == a1 then
            if u44 ~= v1 then
                return
            end
            u44 = nil
            v1.Trove:Destroy()
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 60 -- upvalues: u44 (upval), LocalPlayer (upval)
        local v1 = u44
        if v1 and v1.Character ~= LocalPlayer.Character then
            if u44 ~= v1 then
                return
            end
            u44 = nil
            v1.Trove:Destroy()
        end
    end)
end

function u47.Apply(a1, a2) -- Line: 68
    -- upvalues: u47 (val), u46 (ref), LocalPlayer (val), Workspace (val), u44 (ref), Trove (val), Timer (val)
    -- upvalues: u43 (val), Lighting (val), ReplicatedStorage (val)
    u47.Start()
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    if not u46
        and LocalPlayer:GetAttribute("TrainEventPhase") ~= "Departing"
        and LocalPlayer:GetAttribute("TrainEventPhase") ~= "Returning"
        and a1 == LocalPlayer.Character then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) and Humanoid and not (Humanoid.Health <= 0) and not (a2 <= 0) then
            local v2 = os.clock()
            local v3 = u44
            if v3 and v3.Character == a1 then
                v3.ExpiresAt = math.max(v3.ExpiresAt, v2 + a2)
                v3.Timer:Stop()
                v3.Timer.Interval = v3.ExpiresAt - v2
                v3.Timer:Start()
                return
            end
            if v3 and u44 == v3 then
                u44 = nil
                v3.Trove:Destroy()
            end
            v3 = Trove.new()
            v1 = Timer.new(a2)
            local u64 = {Character = a1}
            u64.ExpiresAt = v2 + a2
            u64.Timer = v1
            u64.Trove = v3
            u44 = u64
            v3:Add(v1)
            v3:Connect(v1.Tick, function() -- Line: 108 -- upvalues: u64 (val), u44 (upval)
                local v1 = os.clock()
                if u64.ExpiresAt <= v1 then
                    v1 = u64
                    if u44 ~= v1 then
                        return
                    end
                    u44 = nil
                    v1.Trove:Destroy()
                end
            end)
            v3:Connect(Humanoid.Died, function() -- Line: 113 -- upvalues: u64 (val), u44 (upval)
                local v1 = u64
                if u44 ~= v1 then
                    return
                end
                u44 = nil
                v1.Trove:Destroy()
            end)
            v3:Connect(a1.Destroying, function() -- Line: 116 -- upvalues: u64 (val), u44 (upval)
                local v1 = u64
                if u44 ~= v1 then
                    return
                end
                u44 = nil
                v1.Trove:Destroy()
            end)
            local moveFunction = u43.moveFunction

            local function invertedMove(a1, a2, a3) -- Line: 121
                -- upvalues: moveFunction (val)
                moveFunction(a1, -a2, a3)
            end

            u43.moveFunction = invertedMove
            v3:Add(function() -- Line: 129 -- upvalues: u43 (upval), invertedMove (val), moveFunction (val)
                if u43.moveFunction == invertedMove then
                    u43.moveFunction = moveFunction
                end
            end)
            local u99 = nil
            local FieldOfView = 0
            v3:Add(function() -- Line: 137 -- upvalues: u99 (ref), FieldOfView (ref)
                if u99 then
                    u99.FieldOfView = FieldOfView
                    u99 = nil
                end
            end)
            v3:Connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), function() -- Line: 143 -- upvalues: u44 (upval), u64 (val), Workspace (upval), u99 (ref), FieldOfView (ref)
                if u44 == u64 and Workspace.CurrentCamera ~= u99 then
                    if u99 then
                        u99.FieldOfView = FieldOfView
                        u99 = nil
                    end
                    local CurrentCamera = Workspace.CurrentCamera
                    u99 = CurrentCamera
                    if CurrentCamera then
                        FieldOfView = CurrentCamera.FieldOfView
                        CurrentCamera.FieldOfView = FieldOfView / 2.4
                    end
                    return
                end
            end)
            if u44 == u64 and Workspace.CurrentCamera ~= u99 then
                if u99 then
                    u99.FieldOfView = FieldOfView
                end
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera then
                    FieldOfView = CurrentCamera.FieldOfView
                    CurrentCamera.FieldOfView = FieldOfView / 2.4
                end
            end
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
            v3:Add(ColorCorrectionEffect)
            ColorCorrectionEffect.Name = "BeeEffect"
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 0)
            ColorCorrectionEffect.Saturation = 0.5
            ColorCorrectionEffect.Parent = Lighting
            local Head = a1:FindFirstChild("Head")
            if Head and Head:IsA("BasePart") then
                local v4 = ReplicatedStorage.Assets.ToolEffects.BeeToolEffect:Clone()
                v3:Add(v4)
                v4.CFrame = Head.CFrame
                local WeldConstraint = Instance.new("WeldConstraint")
                WeldConstraint.Part0 = Head
                WeldConstraint.Part1 = v4
                WeldConstraint.Parent = v4
                v4.Parent = Head
            end
            v1:Start()
            return
        end
    end
end

return (table.freeze(u47))