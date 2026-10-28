-- Script path: ReplicatedStorage.Controllers.Game.Eggs.EggPlacementController
-- Decompile time: 7.57 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local EggPlacementRaycast = require(ReplicatedStorage.Shared.Eggs.EggPlacementRaycast)
local EggState = require(ReplicatedStorage.Client.EggState)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ButtonR2 = Enum.KeyCode.ButtonR2
local LocalPlayer = Players.LocalPlayer
local u68 = Trove.new()
return {
    Start = function() -- Line: 34
        -- upvalues: Toast (val), EggToolDisplay (val), PlotState (val), EggPlacementRaycast (val), LocalPlayer (val)
        -- upvalues: EggState (val), PlacedEggRenderer (val), PlatformController (val), ButtonHintStrip (val)
        -- upvalues: ButtonR2 (val), u68 (val), RunService (val), Remotes (val), Workspace (val)
        local function showInvalidPlacement() -- Line: 39 -- upvalues: Toast (upval)
            Toast.Show({Text = "Cannot place egg here!", Seconds = 2, Color = Color3.fromRGB(255, 80, 80)})
        end

        local function tryPlace(a1) -- Line: 47
            -- upvalues: EggToolDisplay (upval), Toast (upval), PlotState (upval), EggPlacementRaycast (upval)
            -- upvalues: LocalPlayer (upval), EggState (upval), PlacedEggRenderer (upval)
            local v1 = EggToolDisplay.GetToolUid(a1)
            if v1 == nil then
                Toast.Show({
                    Text = "Cannot place egg here!",
                    Seconds = 2,
                    Color = Color3.fromRGB(255, 80, 80),
                })
                return
            end
            local v2 = PlotState.ResolvePlot()
            if v2 == nil then
                Toast.Show({
                    Text = "Cannot place egg here!",
                    Seconds = 2,
                    Color = Color3.fromRGB(255, 80, 80),
                })
                return
            end
            local PetArea = v2.PetArea
            local v3 = EggPlacementRaycast.Raycast(PetArea, LocalPlayer.UserId)
            if v3 ~= nil and v3.Instance == PetArea then
                local v4 = v2.CenterPoint.CFrame:ToObjectSpace((CFrame.new(v3.Position)))
                local v5, v6 = EggState.PlantEgg(v1, v4)
                if not v5 then
                    Toast.Show({
                        Seconds = 2,
                        Text = v6 or "Cannot place egg here!",
                        Color = Color3.fromRGB(255, 80, 80),
                    })
                    return
                end
                PlacedEggRenderer.Refresh()
                return
            end
            Toast.Show({Text = "Cannot place egg here!", Seconds = 2, Color = Color3.fromRGB(255, 80, 80)})
        end

        local function canPlaceFromHere() -- Line: 81
            -- upvalues: PlatformController (upval), LocalPlayer (upval), PlotState (upval)
            if not PlatformController.IsConsole() then
                return false
            end
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return PlotState.ContainsLocalPoint(HumanoidRootPart.Position)
            end
            return false
        end

        local function refreshPlacePrompt() -- Line: 95
            -- upvalues: PlatformController (upval), LocalPlayer (upval), PlotState (upval), ButtonHintStrip (upval)
            -- upvalues: ButtonR2 (upval)
            local v1
            if PlatformController.IsConsole() then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                v1 = if HumanoidRootPart == nil then false else if HumanoidRootPart:IsA("BasePart") then PlotState.ContainsLocalPoint(HumanoidRootPart.Position) else false
            else
                v1 = false
            end
            if v1 then
                ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
                return
            end
            ButtonHintStrip.Retract("EggPlacement")
        end

        local function bindTool(a1) -- Line: 103
            -- upvalues: u68 (upval), tryPlace (val), RunService (upval), PlatformController (upval)
            -- upvalues: LocalPlayer (upval), PlotState (upval), ButtonHintStrip (upval), ButtonR2 (upval)
            local v1
            u68:Clean()
            u68:Connect(a1.Activated, function() -- Line: 105 -- upvalues: tryPlace (upval), a1 (val)
                tryPlace(a1)
            end)
            local u11 = 0
            u68:Connect(RunService.Heartbeat, function(a1) -- Line: 108
                -- upvalues: u11 (ref), PlatformController (upval), LocalPlayer (upval), PlotState (upval)
                -- upvalues: ButtonHintStrip (upval), ButtonR2 (upval)
                local v1
                u11 = u11 + a1
                if u11 < 0.2 then
                    return
                end
                u11 = 0
                if PlatformController.IsConsole() then
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    v1 = if HumanoidRootPart == nil then false else if HumanoidRootPart:IsA("BasePart") then PlotState.ContainsLocalPoint(HumanoidRootPart.Position) else false
                else
                    v1 = false
                end
                if v1 then
                    ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
                    return
                end
                ButtonHintStrip.Retract("EggPlacement")
            end)
            u68:Add(function() -- Line: 116 -- upvalues: ButtonHintStrip (upval)
                ButtonHintStrip.Retract("EggPlacement")
            end)
            if PlatformController.IsConsole() then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                v1 = if HumanoidRootPart == nil then false else if HumanoidRootPart:IsA("BasePart") then PlotState.ContainsLocalPoint(HumanoidRootPart.Position) else false
            else
                v1 = false
            end
            if not v1 then
                ButtonHintStrip.Retract("EggPlacement")
            else
                ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
            end
        end

        local function refreshCharacter(a1) -- Line: 121
            -- upvalues: u68 (upval), EggToolDisplay (upval), bindTool (val)
            u68:Clean()
            for i, v in ipairs(a1:GetChildren()) do
                if v.ClassName == "Tool" and EggToolDisplay.IsEggTool(v) then
                    bindTool(v)
                    return
                end
            end
        end

        local function bindCharacter(a1) -- Line: 131
            -- upvalues: refreshCharacter (val), EggToolDisplay (upval), bindTool (val), u68 (upval)
            refreshCharacter(a1)
            a1.ChildAdded:Connect(function(a1) -- Line: 133 -- upvalues: EggToolDisplay (upval), bindTool (upval) -- types: a1: userdata
                if a1.ClassName == "Tool" and EggToolDisplay.IsEggTool(a1) then
                    bindTool(a1)
                end
            end)
            a1.ChildRemoved:Connect(function(a1) -- Line: 138 -- upvalues: EggToolDisplay (upval), u68 (upval) -- types: a1: userdata
                if a1.ClassName == "Tool" and EggToolDisplay.IsEggTool(a1) then
                    u68:Clean()
                end
            end)
        end

        LocalPlayer.CharacterAdded:Connect(bindCharacter)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 151 -- upvalues: PlacedEggRenderer (upval) -- types: a1: string?
            PlacedEggRenderer.SetPromptsSuppressed(a1 ~= nil)
        end)
        if LocalPlayer.Character ~= nil then
            bindCharacter(LocalPlayer.Character)
        end
        ;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 157 -- upvalues: LocalPlayer (upval), refreshCharacter (val)
            local Character = LocalPlayer.Character
            if Character ~= nil then
                refreshCharacter(Character)
            end
        end)
    end,
}