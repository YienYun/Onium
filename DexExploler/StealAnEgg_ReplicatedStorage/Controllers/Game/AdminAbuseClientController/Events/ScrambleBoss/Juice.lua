-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Juice
-- Decompile time: 2.17 ms

local RunService = game:GetService("RunService")
local Kit = require(script.Parent.Kit)
return {
    Throw = function(a1, a2, a3, a4) -- Line: 14
        -- upvalues: Kit (val), RunService (val)
        local u38
        local Position = a1.Position
        local v1 = (math.max(Position.Y, a3.Y)) + 55
        local u25 = Vector3.new((Position.X + a3.X) / 2, v1 * 2 - (Position.Y + a3.Y) / 2, (Position.Z + a3.Z) / 2)
        local v2 = Kit.Flat(a3 - Position)
        if not (0.1 < v2.Magnitude) then
            u38 = Vector3.new(1, 0, 0)
        else
            local Unit = v2.Unit
            u38 = Vector3.new(0, 1, 0):Cross(Unit)
        end
        local Rotation = a1.CFrame.Rotation
        local u43 = os.clock()
        a2.PlatformStand = true
        local u46 = nil
        RunService.RenderStepped:Connect(function() -- Line: 28
            -- upvalues: u43 (val), a4 (val), Position (val), u25 (val), a3 (val), a1 (val), u38 (ref), Rotation (val)
            -- upvalues: a2 (val), u46 (ref)
            local v1 = math.clamp((os.clock() - u43) / a4, 0, 1)
            local v2 = 1 - v1
            local v3 = Position * (v2 * v2) + u25 * (v2 * 2 * v1) + a3 * (v1 * v1)
            a1.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            a1.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            a1.CFrame = (CFrame.new(v3)) * CFrame.fromAxisAngle(u38, v1 * 3.141592653589793 * 4) * Rotation
            if v1 >= 1 or a1.Parent == nil or a2.Health <= 0 then
                if u46 then
                    u46:Disconnect()
                end
                a1.CFrame = (CFrame.new(a3)) * Rotation
                a1.AssemblyLinearVelocity = Vector3.new(0, -20, 0)
                a2.PlatformStand = false
            end
        end)
    end,
}