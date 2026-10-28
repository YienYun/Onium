-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.PetUpdateSchedule
-- Decompile time: 1.00 ms

return table.freeze({
    GetInterval = function(a1, a2, a3, a4, a5, a6) -- Line: 12
        -- upvalues: 
        if not a6.Enabled then
            return 0
        end
        if a1 then
            return a6.HiddenInterval
        end
        if not a2 and a5 ~= nil then
            local v1 = a3 - a5
            local v2 = a6.DistantDistance + a4
            local v3 = v1:Dot(v1)
            if v2 * v2 < v3 then
                return a6.DistantInterval
            end
            return 0
        end
        return 0
    end,
    TakeStep = function(a1, a2, a3, a4) -- Line: 34 -- types: a1: number, a2: number, a3: number, a4: boolean
        local v1 = a1 + a2
        if a3 > 0 and v1 + 1e-06 < a3 and not a4 then
            return false, 0, v1
        end
        return true, if not (a3 > 0) then v1 else math.min(v1, 0.25), 0
    end,
})