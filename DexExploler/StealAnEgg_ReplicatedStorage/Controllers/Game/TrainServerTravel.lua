-- Script path: ReplicatedStorage.Controllers.Game.TrainServerTravel
-- Decompile time: 5.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TrainEvent = (require(ReplicatedStorage.Shared.Remotes)).TrainEvent
local v1 = {}
local u26 = false
local u27 = nil
local u28 = nil

local function restoreJump() -- Line: 11 -- upvalues: u28 (ref)
    local v1 = u28
    u28 = nil
    if v1 and v1.Humanoid.Parent then
        v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, v1.Enabled)
    end
end

function v1.Start() -- Line: 17
    -- upvalues: u26 (ref), Players (val), TrainEvent (val), u27 (ref), u28 (ref), RunService (val), Workspace (val)
    if u26 then
        return
    end
    u26 = true
    local LocalPlayer = Players.LocalPlayer
    TrainEvent.Travel.OnClientEvent:Connect(function(a1, a2) -- Line: 21
        -- upvalues: u27 (upval), u28 (upval), LocalPlayer (val), RunService (upval), Players (upval), Workspace (upval)
        -- upvalues: TrainEvent (upval)
        local v1
        if a1 == "ServerTravelEnd" then
            if typeof(a2) == "table" and u27 and u27.Id == a2.Id then
                u27 = nil
                v1 = u28
                u28 = nil
                if v1 and v1.Humanoid.Parent then
                    v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, v1.Enabled)
                end
            end
            return
        end
        if a1 == "ServerTravel" and typeof(a2) == "table" and typeof(a2.Id) == "string" then
            if a2.Stage ~= "Prepare" and a2.Stage ~= "Authorized" then
                return
            end
            if typeof(a2.Target) == "CFrame"
                and typeof(a2.FloorPath) == "table"
                and typeof(a2.Timeout) == "number"
                and LocalPlayer.Character == a2.Character then
                local Character_2, HumanoidRootPart, Humanoid_2, v2, v3, v4
                v1 = (os.clock()) + math.clamp(a2.Timeout, 1, 12)
                local v5 = nil
                local v6 = a2
                while true do
                    RunService.PostSimulation:Wait()
                    if a2 ~= v6 or LocalPlayer.Character ~= v6.Character then
                        break
                    end
                    Character_2 = v6.Character
                    HumanoidRootPart = Character_2:FindFirstChild("HumanoidRootPart")
                    Humanoid_2 = Character_2:FindFirstChildOfClass("Humanoid")
                    if HumanoidRootPart and Humanoid_2 and not (Humanoid_2.Health <= 0) then
                        v3 = RaycastParams.new()
                        v3.FilterType = Enum.RaycastFilterType.Exclude
                        v4 = {}
                        for i, j in Players:GetPlayers() do
                            if j.Character then
                                table.insert(v4, j.Character)
                            end
                        end
                        v3.FilterDescendantsInstances = v4
                        v3.RespectCanCollide = true
                        v4 = Workspace:Raycast(v6.Target.Position + Vector3.new(0, 3, 0), Vector3.new(0, -32, 0), v3)
                        if not u28 then
                            u28 = {
                                Humanoid = Humanoid_2,
                                Enabled = Humanoid_2:GetStateEnabled(Enum.HumanoidStateType.Jumping),
                            }
                            Humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                            Humanoid_2.Jump = false
                        end
                        v3 = false
                        if Character_2:FindFirstChild("TrainTravelWeld", true) == nil then
                            v3 = Humanoid_2.WalkSpeed == 0
                        end
                        v2 = v4
                        if v2 then
                            v2 = false
                            if typeof(v6.FloorPosition) == "Vector3" then
                                v2 = (v4.Position - v6.FloorPosition).Magnitude <= 4
                            end
                        end
                        v4 = true
                        if v6.Stage ~= "Prepare" then
                            v4 = (HumanoidRootPart.Position - v6.Target.Position).Magnitude <= 12
                        end
                        if v3 and v2 and v4 then
                            v5 = v5 or os.clock()
                            if 0.1 <= os.clock() - v5 then
                                TrainEvent.TravelReady:FireServer(v6.Id, v6.Stage, Character_2)
                                return
                            end
                            if not (v1 <= os.clock()) then
                                continue
                            end
                            return
                        end
                        if not (v1 <= os.clock()) then
                            continue
                        end
                        return
                    end
                    return
                end
                return
            end
        end
    end)
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 68 -- upvalues: u27 (upval), u28 (upval)
        u27 = nil
        local v1 = u28
        u28 = nil
        if v1 and v1.Humanoid.Parent then
            v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, v1.Enabled)
        end
    end)
end

return v1