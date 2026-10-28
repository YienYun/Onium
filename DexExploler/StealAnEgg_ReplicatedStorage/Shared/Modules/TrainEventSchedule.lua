-- Script path: ReplicatedStorage.Shared.Modules.TrainEventSchedule
-- Decompile time: 0.62 ms

return table.freeze({
    FirstArrivalAt = function(a1, a2, a3) -- Line: 4 -- types: a1: number, a2: number, a3: number
        local v1 = false
        if a1 > 0 then
            v1 = a1 < (1 / 0)
        end
        assert(v1, "Invalid train unlock time")
        v1 = false
        if a2 > 0 then
            v1 = a2 < (1 / 0)
        end
        assert(v1, "Invalid train interval")
        v1 = false
        if a3 == a3 then
            v1 = (math.abs(a3)) < (1 / 0)
        end
        assert(v1, "Invalid train offset")
        local v2 = a3 % a2
        return (math.floor((a1 + v2) / a2) + 2) * a2 - v2
    end,
})