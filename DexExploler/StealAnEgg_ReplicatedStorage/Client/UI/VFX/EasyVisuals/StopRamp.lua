-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.StopRamp
-- Decompile time: 3.14 ms

local u0 = {}

local function earlierStop(a1, a2) -- Line: 30
    return a1.Time < a2.Time
end

u0.Colour = {
    Blend = function(a1, a2, a3) -- Line: 18 -- types: a1: userdata, a2: userdata, a3: number
        return Color3.new(a1.R + (a2.R - a1.R) * a3, a1.G + (a2.G - a1.G) * a3, a1.B + (a2.B - a1.B) * a3)
    end,
    Stop = function(a1, a2) -- Line: 34 -- types: a1: number
        return ColorSequenceKeypoint.new(a1, a2)
    end,
    Wrap = function(a1, a2) -- Line: 35 -- types: a1: number, a2: number
        return (a1 + a2) % 1
    end,
}
u0.Alpha = {
    Blend = function(a1, a2, a3) -- Line: 26 -- types: a1: number, a2: number, a3: number
        return a1 + (a2 - a1) * a3
    end,
    Stop = function(a1, a2) -- Line: 42 -- types: a1: number
        return NumberSequenceKeypoint.new(a1, a2)
    end,
    Wrap = function(a1, a2) -- Line: 43 -- types: a1: number, a2: number
        local v1 = a1 + a2
        if not (v1 < 0) and not (v1 > 1) then
            return v1
        end
        return v1 % 1
    end,
}

function u0.Sample(a1, a2, a3) -- Line: 54 -- types: a1: table, a2: number, a3: table
    local v1
    local v2 = {}
    local v3 = a2 + 1
    for i = 0, 2 do
        for j, k in a1 do
            v2[#v2 + 1] = {Time = k.Time + i, Value = k.Value}
        end
    end
    for n, m in v2 do
        v1 = v2[n + 1]
        if not v1 then
            break
        end
        if m.Time <= v3 and v3 < v1.Time then
            return a3.Blend(m.Value, v1.Value, (v3 - m.Time) / (v1.Time - m.Time))
        end
    end
    return nil
end

function u0.Drift(a1, a2, a3, a4, a5) -- Line: 82
    -- upvalues: earlierStop (val), u0 (val)
    local v1
    local v2 = {}
    local v3 = a4
    local Time = a5
    for i, j in a1 do
        v1 = a2.Stop(a2.Wrap(j.Time, a3), j.Value)
        if not (v1.Time <= Time) then
            v2[#v2 + 1] = v1
        else
            v3 = v3 - 1
            v2[v3] = v1
            Time = v1.Time
        end
    end
    local v4 = {}
    for k, n in v2 do
        v4[#v4 + 1] = n
    end
    table.sort(v4, earlierStop)
    if v4[1].Time ~= 0 then
        table.insert(v4, 1, (a2.Stop(0, (u0.Sample(v4, 0, a2)))))
    end
    if v4[#v4].Time ~= 1 then
        v4[#v4 + 1] = (a2.Stop(1, u0.Sample(v4, 1, a2)))
    end
    return v4
end

function u0.Restripe(a1, a2, a3, a4) -- Line: 125
    -- upvalues: u0 (val)
    local v1, v2
    local v3 = {}
    local v4 = #a1 == #a2
    local v5 = nil
    local v6 = nil
    local v7, v8, v9 = a2, a4, a3
    for i, j in a1, v5, v6 do
        v1 = u0.Sample(v7, j.Time, v8)
        v2 = if not v4 then v1 else v1:Lerp(j.Value, v9)
        v3[#v3 + 1] = (v8.Stop(j.Time, v2))
    end
    return v3
end

return table.freeze(u0)