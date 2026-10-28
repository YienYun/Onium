-- Script path: ReplicatedStorage.Shared.Util.ScramblePickupMotion
-- Decompile time: 0.89 ms

local u0 = {FallSeconds = 0.55, BounceSeconds = 0.4, MagnetDelay = 1.02, MagnetSeconds = 0.52}

function u0.GroundPosition(a1, a2, a3) -- Line: 4 -- upvalues: u0 (val) -- types: a1: vector, a2: vector, a3: number
    local v1 = math.clamp(a3 / u0.FallSeconds, 0, 1)
    if v1 < 1 then
        return (a1:Lerp(a2, v1)) + Vector3.new(0, v1 * 4 * (1 - v1) * 2, 0)
    end
    v1 = math.clamp((a3 - u0.FallSeconds) / u0.BounceSeconds, 0, 1)
    return a2 + Vector3.new(0, (math.abs((math.sin(v1 * 3.141592653589793 * 2)))) * (1 - v1) ^ 2 * 1.1, 0)
end

function u0.MagnetPosition(a1, a2, a3) -- Line: 13 -- types: a1: vector, a2: vector, a3: number
    local v1 = math.clamp(a3, 0, 1)
    return (a1:Lerp(a2, v1 * v1)) + Vector3.new(0, math.sin(v1 * 3.141592653589793) ^ 2 * 0.65, 0)
end

return table.freeze(u0)