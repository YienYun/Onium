-- Script path: ReplicatedStorage.Shared.Util.ScrambleDroneMotion
-- Decompile time: 2.21 ms

local HttpService = game:GetService("HttpService")
local ScrambleMotion = require(script.Parent.ScrambleMotion)
local u10 = {DeathFadeSeconds = 0.6}

function u10.Pose(a1, a2, a3) -- Line: 8 -- upvalues: ScrambleMotion (val) -- types: a3: number
    if not a1 then
        return ScrambleMotion.Pose(a2, a3)
    end
    if a1.Name == "Death" then
        return a1.From
    end
    local v1 = math.clamp((a3 - a1.At) / math.max(a1.Duration, 0.001), 0, 1)
    if a1.Name == "Knockback" then
        v1 = v1 * v1 * (3 - v1 * 2)
    end
    local v2 = a1.From:Lerp(a1.To, v1)
    if a1.Name ~= "Death" then
        v2 = v2 + Vector3.new(0, (math.sin((a3 - a2.StartedAt) * 2.1 + a2.Phase)) * a2.Bob, 0)
    end
    return v2
end

function u10.Encode(a1) -- Line: 25 -- upvalues: HttpService (val)
    return HttpService:JSONEncode({
        a1.Name,
        a1.At,
        a1.Duration,
        {a1.From:GetComponents()},
        {a1.To:GetComponents()},
        a1.AnimationAt,
    })
end

function u10.Decode(a1) -- Line: 35 -- upvalues: HttpService (val)
    if type(a1) ~= "string" then
        return nil
    end
    local success, err = pcall(HttpService.JSONDecode, HttpService, a1)
    if success and type(err) == "table" and #err == 6 then
        return {
            Name = err[1],
            At = err[2],
            Duration = err[3],
            From = CFrame.new(table.unpack(err[4])),
            To = CFrame.new(table.unpack(err[5])),
            AnimationAt = err[6],
        }
    end
    return nil
end

function u10.Read(a1) -- Line: 52 -- upvalues: u10 (val) -- types: a1: userdata
    return u10.Decode(a1:GetAttribute("DroneMotion"))
end

return table.freeze(u10)