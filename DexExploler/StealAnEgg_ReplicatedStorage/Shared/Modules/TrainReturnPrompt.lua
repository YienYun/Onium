-- Script path: ReplicatedStorage.Shared.Modules.TrainReturnPrompt
-- Decompile time: 0.34 ms

return {
    ClosestPoint = function(a1, a2, a3) -- Line: 4 -- types: a1: vector, a2: vector, a3: vector
        local v1 = a3 - a2
        local v2 = v1:Dot(v1)
        if v2 < 0.0001 then
            return a2
        end
        return a2 + v1 * math.clamp((a1 - a2):Dot(v1) / v2, 0, 1)
    end,
}