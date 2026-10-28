-- Script path: ReplicatedStorage.Shared.Modules.EventBoardView
-- Decompile time: 2.16 ms

local u0 = {RefreshSeconds = 60, RetryBackoffSeconds = 30, TimerUpdateSeconds = 1, PromptDistance = 12}

function u0.ToUnix(a1) -- Line: 42 -- types: a1: table?
    if type(a1) ~= "table" then
        return nil
    end
    local success, err = pcall(function() -- Line: 47 -- upvalues: a1 (val)
        return DateTime.fromUniversalTime(a1.Year, a1.Month, a1.Day, a1.Hour, a1.Minute, a1.Second, a1.Millisecond or 0)
    end)
    if success and err then
        return err.UnixTimestamp
    end
    return nil
end

function u0.IsEligible(a1, a2) -- Line: 61 -- upvalues: u0 (val) -- types: a1: table?, a2: number
    if type(a1) == "table" and type(a1.Id) == "string" and a1.Id ~= "" then
        if a1.Status ~= Enum.ExperienceEventStatus.Active then
            return false
        end
        if a1.HasStarted ~= true and a1.HasEnded ~= true then
            local v1 = u0.ToUnix(a1.StartTime)
            local v2 = false
            if v1 ~= nil then
                v2 = a2 < v1
            end
            return v2
        end
        return false
    end
    return false
end

function u0.Pick(a1, a2) -- Line: 76 -- upvalues: u0 (val) -- types: a1: table?, a2: number
    local v1
    if type(a1) ~= "table" then
        return nil
    end
    local v2 = nil
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        if u0.IsEligible(j, a2) then
            v1 = u0.ToUnix(j.StartTime)
            if v2 == nil or v1 < v2.StartsAt then
                v2 = {
                    Id = j.Id,
                    Title = if type(j.Title) ~= "string" then "" else j.Title,
                    StartsAt = v1,
                    Going = j.UserRsvpStatus == Enum.RsvpStatus.Going,
                }
            end
        end
    end
    return v2
end

function u0.ShouldShow(a1) -- Line: 100 -- types: a1: table?
    local v1 = false
    if a1 ~= nil then
        v1 = not a1.Going
    end
    return v1
end

function u0.Countdown(a1) -- Line: 104 -- types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    local v2 = v1 // 86400
    local v3 = v1 % 86400 // 3600
    local v4 = v1 % 3600 // 60
    local v5 = v1 % 60
    if v2 > 0 then
        return string.format("%dd %dh %dm", v2, v3, v4)
    end
    if v3 > 0 then
        return string.format("%dh %dm %ds", v3, v4, v5)
    end
    return string.format("%dm %ds", v4, v5)
end

return table.freeze(u0)