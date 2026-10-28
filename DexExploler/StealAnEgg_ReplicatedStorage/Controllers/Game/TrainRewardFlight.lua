-- Script path: ReplicatedStorage.Controllers.Game.TrainRewardFlight
-- Decompile time: 5.21 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u15 = {}

function u15.Point(a1, a2, a3, a4) -- Line: 6
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (2 * v1 * a4) + a3 * (a4 * a4)
end

function u15.Play(a1, a2) -- Line: 10
    -- upvalues: Players (val), ReplicatedStorage (val), RunService (val), u15 (val)
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    local u8 = a1.AbsolutePosition + a1.AbsoluteSize * 0.5
    local AbsoluteSize = a1.AbsoluteSize
    task.spawn(function() -- Line: 15
        -- upvalues: ReplicatedStorage (upval), a2 (val), RunService (upval), LocalPlayer (val), Character (val)
        -- upvalues: AbsoluteSize (val), a1 (val), u8 (val), u15 (upval)
        local Main = require(ReplicatedStorage.Controllers.GUI.BackpackController.Main)
        local MutationRewardTarget = Main:GetMutationRewardTarget(a2)
        local v1 = os.clock() + 0.6
        while true do
            if not MutationRewardTarget then
                if not (os.clock() < v1) then
                    break
                end
            elseif MutationRewardTarget.Name ~= "Hotbar" or not (os.clock() < v1) then
                break
            end
            RunService.Heartbeat:Wait()
            MutationRewardTarget = Main:GetMutationRewardTarget(a2)
        end
        if LocalPlayer.Character == Character
            and MutationRewardTarget
            and MutationRewardTarget.Parent
            and not (AbsoluteSize.X <= 0)
            and not (AbsoluteSize.Y <= 0) then
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "TrainRewardFlight"
            ScreenGui.IgnoreGuiInset = true
            ScreenGui.ResetOnSpawn = false
            ScreenGui.DisplayOrder = 200
            local u142 = a1:Clone()
            for i, j in u142:GetDescendants() do
                if j:IsA("LuaSourceContainer")
                    or j:IsA("UIScale")
                    or j:IsA("UIAspectRatioConstraint")
                    or j:IsA("UISizeConstraint") then
                    j:Destroy()
                end
            end
            u142:SetAttribute("UIEffectsPaused", true)
            u142.AnchorPoint = Vector2.new(0.5, 0.5)
            u142.Position = UDim2.fromOffset(u8.X, u8.Y)
            u142.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
            u142.Visible = true
            u142.Parent = ScreenGui
            ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
            local u97 = false
            local u98 = nil
            local u99 = nil

            local function cleanup() -- Line: 35 -- upvalues: u97 (ref), u98 (ref), u99 (ref), ScreenGui (val)
                if u97 then
                    return
                end
                u97 = true
                if u98 then
                    u98:Disconnect()
                end
                if u99 then
                    u99:Disconnect()
                end
                ScreenGui:Destroy()
            end

            u99 = LocalPlayer.CharacterRemoving:Connect(cleanup)
            local u109 = os.clock()
            RunService.RenderStepped:Connect(function() -- Line: 43
                -- upvalues: MutationRewardTarget (ref), ScreenGui (val), u97 (ref), u98 (ref), u99 (ref), u109 (val)
                -- upvalues: u8 (upval), u15 (upval), AbsoluteSize (upval), u142 (val)
                if MutationRewardTarget.Parent and ScreenGui.Parent then
                    local v1 = math.clamp((os.clock() - u109) / 0.7, 0, 1)
                    local v2 = MutationRewardTarget.AbsolutePosition + MutationRewardTarget.AbsoluteSize * 0.5
                    local v3 = Vector2.new((u8.X + v2.X) * 0.5, math.min(u8.Y, v2.Y) - 130)
                    local v4 = u15.Point(u8, v3, v2, v1)
                    v3 = math.min(MutationRewardTarget.AbsoluteSize.X, MutationRewardTarget.AbsoluteSize.Y, 56)
                    v2 = AbsoluteSize:Lerp(Vector2.new(v3, v3), v1)
                    u142.Position = UDim2.fromOffset(v4.X, v4.Y)
                    u142.Size = UDim2.fromOffset(v2.X, v2.Y)
                    u142.Rotation = math.sin(3.141592653589793 * v1) * -12
                    if v1 >= 1 then
                        if u97 then
                            return
                        end
                        u97 = true
                        if u98 then
                            u98:Disconnect()
                        end
                        if u99 then
                            u99:Disconnect()
                        end
                        ScreenGui:Destroy()
                    end
                    return
                end
                if u97 then
                    return
                end
                u97 = true
                if u98 then
                    u98:Disconnect()
                end
                if u99 then
                    u99:Disconnect()
                end
                ScreenGui:Destroy()
            end)
            task.delay(1.5, cleanup)
            return
        end
    end)
end

return u15