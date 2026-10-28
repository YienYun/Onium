-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Trampoline
-- Decompile time: 7.19 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local Juice = require(script.Parent.Parent.ScrambleBoss.Juice)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Trampoline = ReplicatedStorage.Assets.BeanstalkEventAssets.Trampoline
local TrampolineJump = ReplicatedStorage.Assets.Sounds.BeanstalkEvent.TrampolineJump
local u62 = Color3.fromRGB(120, 255, 120)

local function stage() -- Line: 44 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return nil
end

local function widenWithSpeed(a1, a2) -- Line: 50
    -- upvalues: Workspace (val), RunService (val)
    local CurrentCamera = Workspace.CurrentCamera
    local FieldOfView = CurrentCamera.FieldOfView
    local Position = a1.Position
    local u7 = os.clock()
    local u8 = nil
    RunService.RenderStepped:Connect(function(a1_2) -- Line: 56
        -- upvalues: a1 (val), Position (ref), u7 (val), a2 (val), FieldOfView (val), CurrentCamera (val), u8 (ref)
        local Position_2 = a1.Position
        local v1 = if not (a1_2 > 0) then 0 else (Position_2 - Position).Magnitude / a1_2
        Position = Position_2
        local v2 = os.clock() - u7
        local v3 = if not (v2 < a2) then FieldOfView else FieldOfView + math.clamp(v1 / 600, 0, 1) * 30
        local v4 = CurrentCamera
        v4.FieldOfView = v4.FieldOfView + (v3 - CurrentCamera.FieldOfView) * math.min(a1_2 * 8, 1)
        if a2 + 0.6 <= v2 or a1.Parent == nil then
            CurrentCamera.FieldOfView = FieldOfView
            v3 = u8
            if v3 ~= nil then
                v3:Disconnect()
            end
        end
    end)
end

local function flingOnStageChange(a1, a2, a3) -- Line: 76
    -- upvalues: LocalPlayer (val), BeanstalkEvent (val), Juice (val), Workspace (val), RunService (val)
    local u3 = nil
    u3 = (LocalPlayer:GetAttributeChangedSignal(BeanstalkEvent.StageAttribute)):Connect(function() -- Line: 78
        -- upvalues: u3 (ref), LocalPlayer (upval), BeanstalkEvent (upval), a2 (val), Juice (upval), a1 (val), a3 (val)
        -- upvalues: Workspace (upval), RunService (upval)
        local v1 = u3
        if v1 ~= nil then
            v1:Disconnect()
        end
        v1 = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
        if (if typeof(v1) ~= "number" then nil else v1) == a2 + 1 then
            Juice.Throw(a1.Root, a1.Humanoid, a3, BeanstalkEvent.LaunchSeconds)
            local Root = a1.Root
            local LaunchSeconds = BeanstalkEvent.LaunchSeconds
            local CurrentCamera = Workspace.CurrentCamera
            local FieldOfView = CurrentCamera.FieldOfView
            local Position = Root.Position
            local u38 = os.clock()
            local u39 = nil
            RunService.RenderStepped:Connect(function(a1) -- Line: 56
                -- upvalues: Root (val), Position (ref), u38 (val), LaunchSeconds (val), FieldOfView (val)
                -- upvalues: CurrentCamera (val), u39 (ref)
                local Position_2 = Root.Position
                local v1 = if not (a1 > 0) then 0 else (Position_2 - Position).Magnitude / a1
                Position = Position_2
                local v2 = os.clock() - u38
                local v3 = if not (v2 < LaunchSeconds) then FieldOfView else FieldOfView + math.clamp(v1 / 600, 0, 1) * 30
                local v4 = CurrentCamera
                v4.FieldOfView = v4.FieldOfView + (v3 - CurrentCamera.FieldOfView) * math.min(a1 * 8, 1)
                if LaunchSeconds + 0.6 <= v2 or Root.Parent == nil then
                    CurrentCamera.FieldOfView = FieldOfView
                    v3 = u39
                    if v3 ~= nil then
                        v3:Disconnect()
                    end
                end
            end)
        end
    end)
    task.delay(2, function() -- Line: 88 -- upvalues: u3 (ref)
        local v1 = u3
        if v1 ~= nil and v1.Connected then
            v1:Disconnect()
        end
    end)
end

return {
    Show = function(a1, a2, a3, a4) -- Line: 100
        -- upvalues: Trampoline (val), TweenService (val), u62 (val), Workspace (val), RunService (val)
        -- upvalues: LocalPlayer (val), BeanstalkEvent (val), SoundService (val), TrampolineJump (val)
        -- upvalues: flingOnStageChange (val), Remotes (val)
        local Transparency, v1, v2
        local v3 = a1:Clone(Trampoline)
        v3:PivotTo(a2.CFrame)
        for i, j in v3:GetDescendants() do
            if j:IsA("BasePart") then
                Transparency = j.Transparency
                j.Transparency = 1
                v1 = TweenService
                v2 = TweenInfo.new(0.8)
                v1:Create(j, v2, {Transparency = Transparency}):Play()
            end
        end
        local Highlight = Instance.new("Highlight")
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillColor = u62
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = u62
        Highlight.Parent = v3
        v3.Parent = Workspace
        local PrimaryPart = v3.PrimaryPart
        local u36 = os.clock() + 0.8
        local u37 = false
        a1:Connect(RunService.Heartbeat, function() -- Line: 122
            -- upvalues: LocalPlayer (upval), BeanstalkEvent (upval), u37 (ref), u36 (val), PrimaryPart (val), a4 (val)
            -- upvalues: SoundService (upval), TrampolineJump (upval), flingOnStageChange (upval), a3 (val)
            -- upvalues: Remotes (upval)
            local Attribute = LocalPlayer:GetAttribute(BeanstalkEvent.StageAttribute)
            local v1 = if typeof(Attribute) ~= "number" then nil else Attribute
            if not u37 and v1 ~= nil and not (os.clock() < u36) then
                local v2 = PrimaryPart.CFrame:PointToObjectSpace(a4.Root.Position)
                local v3 = PrimaryPart.Size * 0.5
                if not (v3.X < (math.abs(v2.X)))
                    and not (v3.Z < (math.abs(v2.Z)))
                    and not (v2.Y < 0)
                    and not (6 < v2.Y) then
                    u37 = true
                    a4.Root.AssemblyLinearVelocity = Vector3.new(0, 60, 0)
                    SoundService:PlayLocalSound(TrampolineJump)
                    flingOnStageChange(a4, v1, a3.Position + Vector3.new(0, 3, 0))
                    Remotes.BeanstalkEvent.AskLaunch:FireServer()
                    task.delay(2, function() -- Line: 138 -- upvalues: u37 (upval)
                        u37 = false
                    end)
                    return
                end
                return
            end
        end)
    end,
}