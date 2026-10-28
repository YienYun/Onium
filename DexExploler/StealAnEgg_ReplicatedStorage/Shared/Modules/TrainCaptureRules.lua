-- Script path: ReplicatedStorage.Shared.Modules.TrainCaptureRules
-- Decompile time: 1.64 ms

local u0 = {}

function u0.InCone(a1, a2, a3, a4, a5) -- Line: 4 -- types: a1: vector, a2: vector, a3: vector, a4: number, a5: number
    local v1 = a3 - a1
    local Magnitude = v1.Magnitude
    if not (a4 < Magnitude) and not (a2.Magnitude < 0.001) then
        local v2 = true
        if not (Magnitude < 0.001) then
            local v3 = a2.Unit:Dot(v1.Unit)
            v2 = math.cos((math.rad(a5 / 2))) <= v3
        end
        return v2
    end
    return false
end

function u0.InCaptureCone(a1, a2, a3, a4, a5, a6, a7) -- Line: 11
    -- upvalues: u0 (val)
    local v1 = a3 - a1
    if not (a4 < v1.Magnitude) and not (a7 < math.abs(v1.Y)) then
        local v2 = Vector3.new(v1.X, 0, v1.Z)
        if v2.Magnitude < 0.001 then
            return true
        end
        return u0.InCone(Vector3.new(0, 0, 0), Vector3.new(a2.X, 0, a2.Z), v2, a4, a5)
    end
    return false
end

function u0.Advance(a1, a2, a3, a4) -- Line: 19 -- types: a1: number, a2: number, a3: number, a4: boolean
    return (math.clamp(a1 + (if not a4 then 0 else math.clamp(a2, 0, 0.2)), 0, a3))
end

function u0.Reward(a1, a2, a3, a4) -- Line: 24 -- types: a1: number, a2: number, a3: number, a4: number
    local v1
    return a3 + (if not (a1 + 1 == a2) then 0 else a4), v1
end

function u0.Recover(a1, a2, a3, a4) -- Line: 29 -- types: a1: number, a2: number, a3: number, a4: number
    return (math.max(0, a1 - (math.max(0, a2)) * a3 / a4))
end

return table.freeze(u0)