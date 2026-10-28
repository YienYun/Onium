-- Script path: ReplicatedStorage.Shared.Util.ShrinePadZone
-- Decompile time: 2.39 ms

local u0 = {}

function u0.ContainsPoint(a1, a2, a3) -- Line: 4 -- types: a1: userdata, a2: vector, a3: number?
    if a1.Anchored and not (a1.CFrame.UpVector.Y < 0.95) then
        local v1 = a1.CFrame:PointToObjectSpace(a2)
        local v2 = a3 or 0.35
        local v3 = false
        if (math.abs(v1.X)) <= a1.Size.X / 2 + v2 then
            v3 = false
            if (math.abs(v1.Z)) <= a1.Size.Z / 2 + v2 then
                v3 = false
                local Y = v1.Y
                if -a1.Size.Y / 2 - 0.5 <= Y then
                    v3 = v1.Y <= a1.Size.Y / 2 + 12
                end
            end
        end
        return v3
    end
    return false
end

function u0.ContainsCharacter(a1, a2) -- Line: 16 -- upvalues: u0 (val) -- types: a1: userdata, a2: userdata?
    if not a2 then
        return false
    end
    local Humanoid = a2:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart")
    if Humanoid and not (Humanoid.Health <= 0) and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        if not Humanoid.Sit and not Humanoid.PlatformStand and u0.ContainsPoint(a1, HumanoidRootPart.Position) then
            if (math.abs(HumanoidRootPart.AssemblyLinearVelocity.Y)) > 5 then
                return false
            end
            local v1 = Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2
            local v2 = a2:FindFirstChild("Left Leg")
            if v2 and v2:IsA("BasePart") then
                v1 = v1 + v2.Size.Y
            end
            v2 = RaycastParams.new()
            v2.FilterType = Enum.RaycastFilterType.Exclude
            v2.FilterDescendantsInstances = {a2}
            v2.RespectCanCollide = true
            local v3 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -math.min(v1 + 1.5, 12), 0), v2)
            if v3 and not (v3.Normal.Y < 0.5) then
                v1 = a1.CFrame:PointToObjectSpace(v3.Position)
                local v4 = false
                local Y_2 = v1.Y
                if -a1.Size.Y / 2 - 1.5 <= Y_2 then
                    v4 = v1.Y <= a1.Size.Y / 2 + 1.5
                end
                return v4
            end
            return false
        end
        return false
    end
    return false
end

return table.freeze(u0)