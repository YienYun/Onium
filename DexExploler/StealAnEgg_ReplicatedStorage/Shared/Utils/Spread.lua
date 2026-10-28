-- Script path: ReplicatedStorage.Shared.Utils.Spread
-- Decompile time: 0.70 ms

return table.freeze({
    Sample = function(a1, a2, a3) -- Line: 7 -- types: a2: number, a3: userdata
        if type(a1) == "table" then
            assert(#a1 == 2, "a random range needs exactly two bounds")
            return a3:NextNumber(a1[1], a1[2])
        end
        if a1 == nil then
            return a2
        end
        return a1
    end,
    Scale = function(a1, a2) -- Line: 15 -- types: a2: number
        if type(a1) == "number" then
            return a1 * a2
        end
        if type(a1) == "table" then
            return {a1[1] * a2, a1[2] * a2}
        end
        return nil
    end,
    FromRange = function(a1, a2) -- Line: 25 -- types: a1: userdata, a2: number
        return {a1.Min * a2, a1.Max * a2}
    end,
})