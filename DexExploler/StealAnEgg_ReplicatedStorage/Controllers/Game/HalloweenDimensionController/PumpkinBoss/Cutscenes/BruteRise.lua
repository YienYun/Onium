-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cutscenes.BruteRise
-- Decompile time: 9.25 ms

local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(ReplicatedStorage.Controllers.Game.AdminAbuseClientController.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Trove = require(ReplicatedStorage.Packages.Trove)
local MoonScene = require(script.Parent.MoonScene)
require(script.Parent.Parent.Scenes)
local Transition = require(script.Parent.Parent.Transition)
local u51 = {
    {0, 10},
    {23, 10.32},
    {49, 11.35},
    {80, 13.28},
    {127, 17.03},
    {181, 21.43},
    {213, 23.49},
    {239, 24.6},
    {262, 24.99},
    {265, 25},
    {266, 15},
    {282, 15.31},
    {301, 16.33},
    {326, 18.41},
    {373, 22.83},
    {394, 24.29},
    {411, 24.92},
    {419, 25},
    {420, 15},
    {930, 15},
}
for i, j in u51 do
    v1 = j[2] * 1.5
    j[2] = (math.clamp(v1, 1, 120))
end
local u126 = u51[#u51][1] / 60

local function fieldOfViewAt(a1) -- Line: 58 -- upvalues: u51 (val) -- types: a1: number
    local v1, v2
    local v3 = u51[1]
    local v4 = #u51
    for i = 2, v4 do
        v1 = u51[i]
        if a1 <= v1[1] then
            v2 = math.clamp((a1 - v3[1]) / (v1[1] - v3[1]), 0, 1)
            return v3[2] + (v1[2] - v3[2]) * v2
        end
        v3 = v1
    end
    return v3[2]
end

local function findAssets() -- Line: 71 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
    return HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
end

return table.freeze({
    Play = function(self) -- Line: 77
        -- upvalues: PumpkinBossState (val), ReplicatedStorage (val), Trove (val), Workspace (val)
        -- upvalues: CutsceneHelperFunctions (val), Transition (val), HiddenUIHandler (val), RunService (val)
        -- upvalues: MoonScene (val), fieldOfViewAt (val), u126 (val)
        local Attribute = self.Arena:GetAttribute(PumpkinBossState.Attributes.Center)
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
        local v1 = HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
        if typeof(Attribute) == "Vector3" and v1 ~= nil then
            local Animation, v2, v3, v4, v5
            local u250 = Trove.new()
            local v6 = u250:Add((Instance.new("Folder")))
            v6.Name = "PumpkinBossBruteRise"
            v6.Parent = Workspace
            local v7 = CFrame.new(Attribute - Vector3.new(-42.83000183105469, 121.88999938964844, 980.7000122070312))
            local LoadAnimationIntoRig = CutsceneHelperFunctions.GetHelperFunctions(u250).LoadAnimationIntoRig
            local u256 = {}
            local u234 = nil
            local u237 = nil
            local v8 = {"IntroCinematic_PumpkinBoss", "IntroCinematic_HumanoidCameraRig"}
            local v9 = nil
            local v10 = nil
            for i, j in v8, v9, v10 do
                v2 = v1:FindFirstChild(j)
                Animation = v2 and v2:FindFirstChildOfClass("Animation")
                if v2 ~= nil and v2:IsA("Model") and Animation ~= nil then
                    v4 = v2:Clone()
                    v4:PivotTo(v7 * (v4:GetPivot()))
                    v4.Parent = v6
                    v2 = LoadAnimationIntoRig(v4, Animation.AnimationId)
                    table.insert(u256, v2)
                    if j == "IntroCinematic_HumanoidCameraRig" then
                        v3 = v4:FindFirstChild("Torso")
                        u234 = if not v3 then nil else if not v3:IsA("BasePart") then nil else v3
                        u237 = v2
                    end
                    continue
                end
                v5 = j
                warn((("[PumpkinBoss] BruteRise needs %* with an Animation child"):format(v5)))
                u250:Destroy()
                return nil
            end
            if u234 ~= nil and u237 ~= nil then
                v7 = self.At + 0.7 - Workspace:GetServerTimeNow()
                local u81 = math.max(-v7, 0)
                local u85 = false
                local u86 = false
                if v7 > 0 then
                    u85 = true
                    u86 = true
                    Transition.Cover(false, 1.7, 0.35)
                end
                local CurrentCamera = Workspace.CurrentCamera
                local FieldOfView = CurrentCamera.FieldOfView
                u250:Add((HiddenUIHandler.Acquire()))
                local u106 = u250:Extend()
                u106:Add(function() -- Line: 135 -- upvalues: RunService (upval), CurrentCamera (val), FieldOfView (val), self (val)
                    RunService:UnbindFromRenderStep("PumpkinBossBruteRise")
                    CurrentCamera.CameraType = Enum.CameraType.Custom
                    CurrentCamera.FieldOfView = FieldOfView
                    local Character = self.Player.Character
                    CurrentCamera.CameraSubject = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
                end)

                local function begin() -- Line: 143
                    -- upvalues: MoonScene (upval), u106 (val), self (val), u81 (val), u256 (val), RunService (upval)
                    -- upvalues: u237 (ref), u234 (ref), CurrentCamera (val), fieldOfViewAt (upval), u86 (ref)
                    -- upvalues: u85 (ref), Transition (upval)
                    MoonScene.HidePlayers(u106, self.Name)
                    local u9 = os.clock() - u81
                    for i, j in u256 do
                        j:Play(0)
                        j.TimePosition = u81
                    end
                    RunService:BindToRenderStep("PumpkinBossBruteRise", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 152
                        -- upvalues: u9 (val), u256 (upval), u237 (upval), u234 (upval), CurrentCamera (upval)
                        -- upvalues: fieldOfViewAt (upval), u86 (upval), u85 (upval), Transition (upval)
                        local v1 = os.clock() - u9
                        for i, j in u256 do
                            if j.IsPlaying and 0 < j.Length and 0.4 < (math.abs(j.TimePosition - v1)) then
                                j.TimePosition = math.min(v1, j.Length)
                            end
                        end
                        if u237.Length <= 0 then
                            return
                        end
                        local CFrame = u234.CFrame
                        CurrentCamera.CameraType = Enum.CameraType.Scriptable
                        CurrentCamera.CFrame = CFrame
                        CurrentCamera.Focus = CFrame
                        CurrentCamera.FieldOfView = fieldOfViewAt(v1 * 60)
                        if u86 then
                            u86 = false
                            u85 = false
                            Transition.Reveal(0.5)
                        end
                    end)
                end

                if not (v7 > 0) then
                    begin()
                else
                    u250:Add((task.delay(v7, begin)))
                end
                local u134 = v7 + u126 - 1.2
                u250:Add((task.delay(math.max(u134, 0), function() -- Line: 182 -- upvalues: u86 (ref), u85 (ref), Transition (upval), u134 (val), self (val), u126 (upval)
                    u86 = false
                    u85 = true
                    local Cover = Transition.Cover
                    local v1 = self.Seconds - 0.7
                    Cover(u134 <= 0, v1 - u126 + 1.2)
                end)))
                u250:Add((task.delay(math.max(v7 + u126, 0), function() -- Line: 187 -- upvalues: u250 (val), u106 (val)
                    u250:Remove(u106)
                end)))
                local u161 = false

                local function stop() -- Line: 192 -- upvalues: u161 (ref), u250 (val), u85 (ref), Transition (upval)
                    if u161 then
                        return
                    end
                    u161 = true
                    u250:Destroy()
                    if u85 then
                        Transition.Reveal()
                    end
                end

                task.delay(math.max(v7 + self.Seconds - 0.7, 0), stop)
                return {Stop = stop}
            end
            warn("[PumpkinBoss] BruteRise camera rig has no Torso")
            u250:Destroy()
            return nil
        end
        warn("[PumpkinBoss] BruteRise can't find the arena centre or Assets.HalloweenDimension.PumpkinBoss")
        return nil
    end,
})