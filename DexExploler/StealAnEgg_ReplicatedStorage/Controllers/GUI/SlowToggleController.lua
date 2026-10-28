-- Script path: ReplicatedStorage.Controllers.GUI.SlowToggleController
-- Decompile time: 8.88 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local u37 = Color3.fromRGB(0, 255, 0)
local u42 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 26
        -- upvalues: Hud (val), Constants (val), u37 (val), TweenService (val), u42 (val), Remotes (val), Save (val)
        -- upvalues: LocalPlayer (val)
        local v1, v2
        local SlowToggle = Hud.Get("SlowToggle")
        local SlowToggleKnob = Hud.Get("SlowToggleKnob")
        local SlowToggleHitbox = Hud.Get("SlowToggleHitbox")
        local BackgroundColor3 = SlowToggle.BackgroundColor3
        local Y = SlowToggleKnob.Position.Y
        local u15 = false
        local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
        local u18 = nil
        local u19 = nil
        local u20 = nil

        local function setToggleVisuals(a1) -- Line: 47
            -- upvalues: SlowToggle (val), u37 (upval), BackgroundColor3 (val), TweenService (upval)
            -- upvalues: SlowToggleKnob (val), u42 (upval), Y (val)
            SlowToggle.BackgroundColor3 = if not a1 then BackgroundColor3 else u37
            local v1 = u42
            TweenService:Create(SlowToggleKnob, v1, {
                Position = UDim2.new(if not a1 then 0.05 else 0.615, 0, Y.Scale, Y.Offset),
            }):Play()
        end

        local function reconcileSlowToggleState(a1) -- Line: 59
            -- upvalues: u15 (ref), setToggleVisuals (val)
            u15 = a1
            setToggleVisuals(a1)
        end

        local function updateSlowToggleVisibility(a1) -- Line: 64
            -- upvalues: u18 (ref), u15 (ref), SlowToggle (val)
            local v1 = false
            if u18 == nil then
                v1 = u15 or a1 > 50
            end
            SlowToggle.Visible = v1
            return v1
        end

        local function resolveVisibleWalkSpeed() -- Line: 70 -- upvalues: u19 (ref), BASE_WALK_SPEED (ref)
            local v1 = u19
            if v1 ~= nil and v1.Parent ~= nil and 0 < v1.Health then
                return v1.WalkSpeed
            end
            return BASE_WALK_SPEED
        end

        local function refreshVisibilityFromCurrentWalkSpeed() -- Line: 79
            -- upvalues: u19 (ref), BASE_WALK_SPEED (ref), u18 (ref), u15 (ref), SlowToggle (val)
            local v1 = u19
            local WalkSpeed = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
            v1 = false
            if u18 == nil then
                v1 = u15 or WalkSpeed > 50
            end
            SlowToggle.Visible = v1
        end

        local function applyServerSlowToggleState(a1, a2) -- Line: 83
            -- upvalues: BASE_WALK_SPEED (ref), u15 (ref), setToggleVisuals (val), u19 (ref), u18 (ref)
            -- upvalues: SlowToggle (val)
            BASE_WALK_SPEED = a2
            setToggleVisuals(a1)
            local v1 = u19
            local WalkSpeed = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
            v1 = false
            if u18 == nil then
                v1 = a1 or WalkSpeed > 50
            end
            SlowToggle.Visible = v1
        end

        local function setSlowToggleEnabled(a1) -- Line: 99
            -- upvalues: Remotes (upval), BASE_WALK_SPEED (ref), u15 (ref), setToggleVisuals (val), u19 (ref), u18 (ref)
            -- upvalues: SlowToggle (val)
            local v1, v2 = Remotes.Treadmill.AskSlowToggleSet:InvokeServer(a1)
            assert(typeof(v1) == "boolean", "Expected slow-toggle enabled state from server")
            assert(typeof(v2) == "number", "Expected slow-toggle restored walk speed from server")
            BASE_WALK_SPEED = v2
            setToggleVisuals(v1)
            local v3 = u19
            local WalkSpeed = if v3 == nil then BASE_WALK_SPEED else if v3.Parent == nil then BASE_WALK_SPEED else if not (0 < v3.Health) then BASE_WALK_SPEED else v3.WalkSpeed
            v3 = false
            if u18 == nil then
                v3 = v1 or WalkSpeed > 50
            end
            SlowToggle.Visible = v3
        end

        local function bindHumanoid(a1) -- Line: 109
            -- upvalues: u20 (ref), u19 (ref), BASE_WALK_SPEED (ref), u18 (ref), u15 (ref), SlowToggle (val)
            if u20 ~= nil then
                u20:Disconnect()
                u20 = nil
            end
            u19 = a1
            ;(a1:GetPropertyChangedSignal("WalkSpeed")):Connect(function() -- Line: 117 -- upvalues: u19 (upval), BASE_WALK_SPEED (upval), u18 (upval), u15 (upval), SlowToggle (upval)
                local v1 = u19
                local WalkSpeed = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
                v1 = false
                if u18 == nil then
                    v1 = u15 or WalkSpeed > 50
                end
                SlowToggle.Visible = v1
            end)
            local v1 = u19
            local WalkSpeed = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
            v1 = false
            if u18 == nil then
                v1 = u15 or WalkSpeed > 50
            end
            SlowToggle.Visible = v1
        end

        local function connectCharacter(a1) -- Line: 122
            -- upvalues: bindHumanoid (val), Remotes (upval), BASE_WALK_SPEED (ref), u15 (ref), setToggleVisuals (val)
            -- upvalues: u19 (ref), u18 (ref), SlowToggle (val)
            bindHumanoid((a1:WaitForChild("Humanoid")))
            local v1, v2 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
            assert(typeof(v1) == "boolean", "Expected slow-toggle enabled state from server")
            assert(typeof(v2) == "number", "Expected slow-toggle restored walk speed from server")
            BASE_WALK_SPEED = v2
            setToggleVisuals(v1)
            local v3 = u19
            local WalkSpeed = if v3 == nil then BASE_WALK_SPEED else if v3.Parent == nil then BASE_WALK_SPEED else if not (0 < v3.Health) then BASE_WALK_SPEED else v3.WalkSpeed
            local v4 = false
            if u18 == nil then
                v4 = v1 or WalkSpeed > 50
            end
            SlowToggle.Visible = v4
        end

        SlowToggleHitbox.Activated:Connect(function() -- Line: 132
            -- upvalues: u15 (ref), Remotes (upval), BASE_WALK_SPEED (ref), setToggleVisuals (val), u19 (ref), u18 (ref)
            -- upvalues: SlowToggle (val)
            local v1 = not u15
            local v2, v3 = Remotes.Treadmill.AskSlowToggleSet:InvokeServer(v1)
            assert(typeof(v2) == "boolean", "Expected slow-toggle enabled state from server")
            assert(typeof(v3) == "number", "Expected slow-toggle restored walk speed from server")
            BASE_WALK_SPEED = v3
            setToggleVisuals(v2)
            local v4 = u19
            local WalkSpeed = if v4 == nil then BASE_WALK_SPEED else if v4.Parent == nil then BASE_WALK_SPEED else if not (0 < v4.Health) then BASE_WALK_SPEED else v4.WalkSpeed
            v4 = false
            if u18 == nil then
                v4 = v2 or WalkSpeed > 50
            end
            SlowToggle.Visible = v4
        end)
        if not Save.IsLoaded() then
            Save.Loaded:Connect(function() -- Line: 89
                -- upvalues: Remotes (upval), BASE_WALK_SPEED (ref), u15 (ref), setToggleVisuals (val), u19 (ref)
                -- upvalues: u18 (ref), SlowToggle (val)
                local v1, v2 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
                assert(typeof(v1) == "boolean", "Expected slow-toggle enabled state from server")
                assert(typeof(v2) == "number", "Expected slow-toggle restored walk speed from server")
                BASE_WALK_SPEED = v2
                setToggleVisuals(v1)
                local v3 = u19
                local WalkSpeed = if v3 == nil then BASE_WALK_SPEED else if v3.Parent == nil then BASE_WALK_SPEED else if not (0 < v3.Health) then BASE_WALK_SPEED else v3.WalkSpeed
                v3 = false
                if u18 == nil then
                    v3 = v1 or WalkSpeed > 50
                end
                SlowToggle.Visible = v3
            end)
        else
            local v3
            v3, v1 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
            assert(typeof(v3) == "boolean", "Expected slow-toggle enabled state from server")
            assert(typeof(v1) == "number", "Expected slow-toggle restored walk speed from server")
            BASE_WALK_SPEED = v1
            setToggleVisuals(v3)
            local v4 = u19
            local WalkSpeed = if v4 == nil then BASE_WALK_SPEED else if v4.Parent == nil then BASE_WALK_SPEED else if not (0 < v4.Health) then BASE_WALK_SPEED else v4.WalkSpeed
            v2 = false
            if u18 == nil then
                v2 = v3 or WalkSpeed > 50
            end
            SlowToggle.Visible = v2
        end
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 146
            -- upvalues: u18 (ref), u19 (ref), BASE_WALK_SPEED (ref), u15 (ref), SlowToggle (val)
            local v1 = u19
            local WalkSpeed = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
            v1 = false
            if a1 == nil then
                v1 = u15 or WalkSpeed > 50
            end
            SlowToggle.Visible = v1
        end)
        if LocalPlayer.Character ~= nil then
            local v5
            bindHumanoid((LocalPlayer.Character:WaitForChild("Humanoid")))
            v5, v2 = Remotes.Treadmill.AskSlowToggle:InvokeServer()
            assert(typeof(v5) == "boolean", "Expected slow-toggle enabled state from server")
            assert(typeof(v2) == "number", "Expected slow-toggle restored walk speed from server")
            BASE_WALK_SPEED = v2
            setToggleVisuals(v5)
            v1 = u19
            local WalkSpeed_2 = if v1 == nil then BASE_WALK_SPEED else if v1.Parent == nil then BASE_WALK_SPEED else if not (0 < v1.Health) then BASE_WALK_SPEED else v1.WalkSpeed
            local v6 = false
            if u18 == nil then
                v6 = v5 or WalkSpeed_2 > 50
            end
            SlowToggle.Visible = v6
        end
        LocalPlayer.CharacterAdded:Connect(connectCharacter)
    end,
}