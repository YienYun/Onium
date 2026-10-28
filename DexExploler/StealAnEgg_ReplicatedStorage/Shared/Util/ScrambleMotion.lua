-- Script path: ReplicatedStorage.Shared.Util.ScrambleMotion
-- Decompile time: 1.45 ms

return table.freeze({
    Pose = function(a1, a2) -- Line: 5 -- types: a2: number
        local v1 = (a2 - a1.StartedAt) * a1.Speed + a1.Phase
        return a1.Home * CFrame.new((Vector3.new((math.cos(v1)) * a1.Radius, (math.sin(v1 * 2.1)) * a1.Bob, (math.sin(v1)) * a1.Radius))) * CFrame.Angles(0, -v1, math.sin(v1) * 0.08)
    end,
    Read = function(a1) -- Line: 14 -- types: a1: userdata
        local Attribute = a1:GetAttribute("FlightHome")
        if typeof(Attribute) ~= "CFrame" then
            return nil
        end
        return {
            Home = Attribute,
            StartedAt = a1:GetAttribute("FlightStartedAt"),
            Phase = a1:GetAttribute("FlightPhase"),
            Radius = a1:GetAttribute("FlightRadius"),
            Speed = a1:GetAttribute("FlightSpeed"),
            Bob = a1:GetAttribute("FlightBob"),
        }
    end,
    Envelope = function(a1, a2, a3, a4, a5, a6) -- Line: 28 -- types: a1: vector, a3: vector, a4: number, a5: number, a6: number?
        local v1 = a1.Magnitude / 2
        local v2 = math.max((a6 or 12) / 2, a2.Radius + v1 + a4)
        local v3 = math.max(a5, a2.Home.Position.Y - a3.Y + v1 + a2.Bob + a4)
        return (CFrame.new(a3 + Vector3.new(0, v3 / 2, 0))), (Vector3.new(v2 * 2, v3, v2 * 2))
    end,
    Hitbox = function(a1, a2, a3, a4) -- Line: 42 -- types: a1: vector, a2: userdata, a3: userdata, a4: number
        return a2 * a3, a1 + Vector3.new(1, 1, 1) * math.min(a4, 1) * 2
    end,
})