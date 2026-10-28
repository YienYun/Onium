-- Script path: ReplicatedStorage.Shared.Types.ScrambleFinalHits
-- Decompile time: 2.27 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)

local function whole(a1) -- Line: 18
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 >= 0 then
            v1 = false
            if a1 <= 9007199254740991 then
                v1 = a1 % 1 == 0
            end
        end
    end
    return v1
end

return table.freeze({
    Blank = function() -- Line: 24
        return {
            Total = 0,
            Scheduled = 0,
            Admin = 0,
            BeforeWeapon = 0,
            AfterWeapon = 0,
            FirstHitAt = 0,
            LastHitAt = 0,
            RecentFightUids = {},
        }
    end,
    Credit = function(a1, a2, a3, a4, a5) -- Line: 37 -- types: a1: table, a2: string, a3: boolean, a4: number, a5: number
        local v1 = false
        if type(a2) == "string" then
            v1 = false
            if #a2 > 0 then
                v1 = #a2 <= 128
            end
        end
        assert(v1)
        v1 = false
        if type(a3) == "boolean" then
            v1 = false
            if type(a4) == "number" then
                v1 = false
                if a4 >= 0 then
                    v1 = false
                    if a4 <= 9007199254740991 then
                        v1 = a4 % 1 == 0
                    end
                end
            end
            if v1 then
                v1 = false
                if type(a5) == "number" then
                    v1 = false
                    if a5 >= 0 then
                        v1 = false
                        if a5 <= 9007199254740991 then
                            v1 = a5 % 1 == 0
                        end
                    end
                end
            end
        end
        assert(v1)
        if table.find(a1.RecentFightUids, a2) then
            return nil, "AlreadyRecorded"
        end
        if 9007199254740991 <= a1.Total then
            return nil, "LimitReached"
        end
        local v2 = table.clone(a1)
        v2.RecentFightUids = table.clone(a1.RecentFightUids)
        table.insert(v2.RecentFightUids, a2)
        if #v2.RecentFightUids > 64 then
            table.remove(v2.RecentFightUids, 1)
        end
        v2.Total = v2.Total + 1
        if not a3 then
            v2.Scheduled = v2.Scheduled + 1
        else
            v2.Admin = v2.Admin + 1
        end
        if not (a5 > 0) or not (a5 <= a4) then
            v2.BeforeWeapon = v2.BeforeWeapon + 1
        else
            v2.AfterWeapon = v2.AfterWeapon + 1
        end
        v2.FirstHitAt = if a1.Total ~= 0 then math.min(a1.FirstHitAt, a4) else a4
        v2.LastHitAt = math.max(a1.LastHitAt, a4)
        return v2, "Recorded"
    end,
    State = t.interface({
        Total = whole,
        Scheduled = whole,
        Admin = whole,
        BeforeWeapon = whole,
        AfterWeapon = whole,
        FirstHitAt = whole,
        LastHitAt = whole,
        RecentFightUids = t.array(t.string),
    }),
})