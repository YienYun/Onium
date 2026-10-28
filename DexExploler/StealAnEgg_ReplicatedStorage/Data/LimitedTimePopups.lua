-- Script path: ReplicatedStorage.Data.LimitedTimePopups
-- Decompile time: 0.38 ms

local function FromEDT(a1, a2, a3, a4) -- Line: 10 -- types: a1: number, a2: number, a3: number, a4: number
    return DateTime.fromUniversalTime(a1, a2, a3, a4 + 4).UnixTimestamp
end

return {
    LuminousEgg = {
        Name = "LuminousEgg",
        StartTime = DateTime.fromUniversalTime(2026, 9, 23, 15).UnixTimestamp,
        EndTime = DateTime.fromUniversalTime(2026, 9, 26, 15).UnixTimestamp,
    },
}