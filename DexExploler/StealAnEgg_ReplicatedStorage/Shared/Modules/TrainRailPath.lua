-- Script path: ReplicatedStorage.Shared.Modules.TrainRailPath
-- Decompile time: 1.65 ms

return table.freeze({
    Prepare = function(a1) -- Line: 3
        local v1 = {}
        local v2 = 0
        for i, v in ipairs(a1) do
            if i > 1 then
                v2 = v2 + (v - a1[i - 1]).Magnitude
            end
            table.insert(v1, {Position = v, Distance = v2})
        end
        return v1
    end,
    Frame = function(a1, a2) -- Line: 8
        local v1 = 2
        while v1 < #a1 do
            if not (a1[v1].Distance < a2) then
                break
            end
            v1 = v1 + 1
        end
        local v2 = a1[v1 - 1]
        local v3 = a1[v1]
        local v4 = v3.Position - v2.Position
        local Magnitude = v4.Magnitude
        local v5 = (a2 - v2.Distance) / Magnitude
        local v6 = v2.Position + v4 * v5
        return CFrame.lookAt(v6, v6 + ((v3.Position - a1[(math.max(1, v1 - 2))].Position).Unit:Lerp(
            (a1[(math.min(#a1, v1 + 1))].Position - v2.Position).Unit,
            (math.clamp(v5, 0, 1))
        )))
    end,
    DistanceAt = function(a1, a2, a3, a4, a5) -- Line: 21
        if a4 <= 0 then
            return a2
        end
        local v1 = math.clamp((a5 - a3) / a4, 0, 1)
        return a1 + (a2 - a1) * v1 * v1 * (3 - v1 * 2)
    end,
})