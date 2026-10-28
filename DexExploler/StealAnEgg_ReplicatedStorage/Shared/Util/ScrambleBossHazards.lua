-- Script path: ReplicatedStorage.Shared.Util.ScrambleBossHazards
-- Decompile time: 8.27 ms

local u0 = {}
u0[1] = (Vector3.new(-0.10000000149011612, 19.899999618530273, -35.099998474121094))
u0[2] = (Vector3.new(-1, 20.399999618530273, -34.29999923706055))
u0[3] = (Vector3.new(-1.7000000476837158, 20, -34.5))
u0[4] = (Vector3.new(-2.200000047683716, 19.5, -34.900001525878906))
u0[5] = (Vector3.new(-2.299999952316284, 19.5, -35.29999923706055))
u0[6] = (Vector3.new(-2.0999999046325684, 20.100000381469727, -35.599998474121094))
u0[7] = (Vector3.new(-1.899999976158142, 20.899999618530273, -35.900001525878906))
u0[8] = (Vector3.new(0.699999988079071, 24, -36.29999923706055))
u0[9] = (Vector3.new(6.099999904632568, 29.5, -35.599998474121094))
u0[10] = (Vector3.new(12.5, 35.20000076293945, -32.599998474121094))
u0[11] = (Vector3.new(18.799999237060547, 40.20000076293945, -26.799999237060547))
u0[12] = (Vector3.new(24.299999237060547, 43.79999923706055, -18.299999237060547))
u0[13] = (Vector3.new(28.200000762939453, 45.79999923706055, -7.199999809265137))
u0[14] = (Vector3.new(29.399999618530273, 45.70000076293945, 5.400000095367432))
u0[15] = (Vector3.new(26.700000762939453, 43.70000076293945, 18.100000381469727))
u0[16] = (Vector3.new(20.100000381469727, 40.79999923706055, 28.700000762939453))
u0[17] = (Vector3.new(10.199999809265137, 37.79999923706055, 35.400001525878906))
u0[18] = (Vector3.new(1.5, 35.599998474121094, 37.79999923706055))
u0[19] = (Vector3.new(-1.100000023841858, 34.5, 37.900001525878906))
u0[20] = (Vector3.new(-0.4000000059604645, 34.5, 37.400001525878906))
u0[21] = (Vector3.new(3.9000000953674316, 37.900001525878906, 35.400001525878906))
u0[22] = (Vector3.new(9.600000381469727, 50.29999923706055, 26.299999237060547))
u0[23] = (Vector3.new(6.300000190734863, 63, 2.5999999046325684))
u0[24] = (Vector3.new(-6.599999904632568, 54.79999923706055, -23.200000762939453))
u0[25] = (Vector3.new(-26.600000381469727, 26.799999237060547, -24.799999237060547))
local u26 = {BodyRadius = 1.6}

local function flat(a1) -- Line: 64 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

function u26.ActiveSeconds(a1) -- Line: 68 -- types: a1: table
    if a1.Kind == "Ring" then
        return (a1.Radius or 0) / math.max(a1.Speed or 1, 1)
    end
    if a1.Kind == "Line" then
        return (a1.Travel or 0) / math.max(a1.Speed or 1, 1)
    end
    return a1.Duration or 0.25
end

function u26.Dodgeable(a1) -- Line: 78 -- types: a1: table
    local v1 = true
    if a1.Kind ~= "Ring" then
        v1 = true
        if a1.Kind ~= "Line" then
            v1 = true
            if a1.Kind ~= "Sweep" then
                v1 = a1.Kind == "Beam"
            end
        end
    end
    return v1
end

function u26.BeamProgress(a1, a2) -- Line: 82 -- types: a1: table, a2: number
    local v1
    local v2 = math.max(a1.Duration or 1, 0.05)
    local v3 = math.clamp(a2, 0, v2)
    if a1.Ramp == nil then
        v1 = v3 / v2
        return v1 * v1 * (3 - v1 * 2)
    end
    v1 = math.clamp(a1.Ramp, 0.01, v2 / 2)
    local v4 = 1 / (v2 - v1)
    if v3 < v1 then
        return v4 * v3 * v3 / (v1 * 2)
    end
    if not (v2 - v1 < v3) then
        return v4 * (v3 - v1 / 2)
    end
    local v5 = v2 - v3
    return 1 - v4 * v5 * v5 / (v1 * 2)
end

function u26.BeamHeading(a1, a2) -- Line: 104 -- upvalues: u26 (val) -- types: a1: table, a2: number
    local v1 = a1.Direction or Vector3.new(0, 0, 1)
    local Unit = (Vector3.new(v1.X, 0, v1.Z)).Unit
    v1 = u26.BeamProgress(a1, a2)
    return CFrame.Angles(0, math.rad(a1.Angle or 0) * v1, 0) * Unit
end

function u26.RingRadius(a1, a2) -- Line: 111 -- types: a1: table, a2: number
    return (math.min((a1.Speed or 0) * math.max(a2, 0), a1.Radius or 0))
end

function u26.LineOffset(a1, a2) -- Line: 115 -- types: a1: table, a2: number
    return (math.min((a1.Speed or 0) * math.max(a2, 0), a1.Travel or 0))
end

function u26.Contains(a1, a2, a3, a4, a5) -- Line: 119
    -- upvalues: u26 (val)
    if not (a2 < 0) and not (u26.ActiveSeconds(a1) < a2) then
        local v1, v2, v3, v4
        if a4 and u26.Dodgeable(a1) then
            return false
        end
        local v5 = a3 - a1.Origin
        local v6 = Vector3.new(v5.X, 0, v5.Z)
        local Magnitude = v6.Magnitude
        local v7 = a5 + 1.6
        if a1.Kind == "Ring" then
            return (math.abs(Magnitude - (u26.RingRadius(a1, a2)))) <= (a1.Width or 2) / 2 + v7
        end
        if a1.Kind == "Line" then
            v4 = a1.Direction or Vector3.new(0, 0, 1)
            local Unit = Vector3.new(v4.X, 0, v4.Z).Unit
            v4 = Unit:Cross((Vector3.new(0, 1, 0)))
            v1 = v6:Dot(Unit)
            v3 = math.abs((v6:Dot(v4)))
            v2 = false
            if (math.abs(v1 - (u26.LineOffset(a1, a2)))) <= (a1.Width or 2) / 2 + v7 then
                v2 = v3 <= (a1.Length or 0) / 2 + v7
            end
            return v2
        end
        if a1.Kind ~= "Strike"
            and a1.Kind ~= "Missile"
            and a1.Kind ~= "Puddle"
            and a1.Kind ~= "Grab"
            and a1.Kind ~= "Sweep"
            and a1.Kind ~= "Blast" then
            if a1.Kind == "Lane" then
                v4 = a1.Direction or Vector3.new(0, 0, 1)
                local Unit_2 = Vector3.new(v4.X, 0, v4.Z).Unit
                v4 = Unit_2:Cross((Vector3.new(0, 1, 0)))
                v1 = v6:Dot(Unit_2)
                v2 = false
                if -v7 <= v1 then
                    v2 = false
                    if v1 <= (a1.Length or 0) + v7 then
                        v2 = (math.abs((v6:Dot(v4)))) <= (a1.Width or 0) / 2 + v7
                    end
                end
                return v2
            end
            if a1.Kind == "Beam" then
                v3 = u26.BeamHeading(a1, a2)
                v4 = v6:Dot(v3)
                v1 = false
                if -v7 <= v4 then
                    v1 = false
                    if v4 <= (a1.Length or 0) + v7 then
                        v1 = (math.abs((v6:Dot((v3:Cross((Vector3.new(0, 1, 0)))))))) <= (a1.Width or 0) / 2 + v7
                    end
                end
                return v1
            end
            if a1.Kind == "Pillars" then
                local v8
                for i, j in a1.Points or {} do
                    v8 = a3 - j
                    if Vector3.new(v8.X, 0, v8.Z).Magnitude <= (a1.Radius or 0) + v7 then
                        return true
                    end
                end
                return false
            end
            if a1.Kind ~= "Cone" or (a1.Radius or 0) + v7 < Magnitude then
                return false
            end
            if Magnitude < 4 then
                return true
            end
            v4 = a1.Direction or Vector3.new(0, 0, 1)
            v4 = math.clamp(v6.Unit:Dot((Vector3.new(v4.X, 0, v4.Z)).Unit), -1, 1)
            v3 = (math.rad((a1.Angle or 60) / 2)) + math.atan2(v7, Magnitude)
            return math.acos(v4) <= v3
        end
        return Magnitude <= (a1.Radius or 0) + v7
    end
    return false
end

function u26.ClawAt(a1) -- Line: 203 -- upvalues: u0 (val) -- types: a1: number
    local v1 = math.clamp((a1 - 0.8125) / 0.0625, 0, #u0 - 1)
    local v2 = math.floor(v1)
    return u0[v2 + 1]:Lerp(u0[(math.min(v2 + 2, #u0))], v1 - v2)
end

function u26.GripCFrame(a1) -- Line: 212 -- types: a1: vector
    local v1 = a1 - Vector3.new(0, 3, 0)
    local v2 = Vector3.new(-v1.X, 0, -v1.Z)
    if v2.Magnitude < 0.001 then
        return CFrame.new(v1)
    end
    return CFrame.lookAt(v1, v1 + v2)
end

function u26.Reach(a1) -- Line: 222 -- types: a1: table
    if a1.Kind == "Line" then
        return (a1.Travel or 0) + (a1.Length or 0) / 2
    end
    if a1.Kind ~= "Lane" and a1.Kind ~= "Beam" then
        if a1.Kind == "Pillars" then
            return 1000
        end
        return a1.Radius or 0
    end
    return (a1.Length or 0) + (a1.Width or 0)
end

return u26