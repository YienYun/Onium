-- Script path: ReplicatedStorage.Shared.Utils.Numeric
-- Decompile time: 3.89 ms

local u0 = {}

local function isFinite(a1) -- Line: 15 -- types: a1: number
    return (math.abs(a1)) < (1 / 0)
end

local function isFiniteVector(a1) -- Line: 19 -- types: a1: vector
    return (math.abs((math.abs(a1.X)) + math.abs(a1.Y) + (math.abs(a1.Z)))) < (1 / 0)
end

local function weightAt(a1, a2) -- Line: 23 -- types: a1: table, a2: number
    local v1 = a1[a2][2]
    if type(v1) ~= "number" then
        error((("weighted entry #%* carries a %* where a numeric weight belongs"):format(a2, (typeof(v1)))))
    end
    if v1 > 0 and v1 < (1 / 0) then
        return v1
    end
    return 0
end

local function cumulativeWeights(a1) -- Line: 31 -- types: a1: table
    local v1, v2, v3
    local v4 = table.create(#a1)
    local v5 = 0
    local v6 = #a1
    for i = 1, v6 do
        v2 = a1[i][2]
        if type(v2) ~= "number" then
            v3 = error
            v1 = typeof(v2)
            v3((("weighted entry #%* carries a %* where a numeric weight belongs"):format(i, v1)))
        end
        v5 = v5 + (if not (v2 > 0) then 0 else if not (v2 < (1 / 0)) then 0 else v2)
        v4[i] = v5
    end
    return v4, v5
end

local function positionAbove(a1, a2) -- Line: 41 -- types: a1: table, a2: number
    local v1
    local v2 = 1
    local v3 = #a1
    local v4, v5 = a1, a2
    while v2 < v3 do
        v1 = (v2 + v3) // 2
        if not (v5 < v4[v1]) then
            v2 = v1 + 1
        else
            v3 = v1
        end
    end
    return v2
end

function u0.IsFiniteCFrame(a1) -- Line: 54 -- types: a1: userdata
    local Position = a1.Position
    local v1 = (math.abs((math.abs(Position.X)) + math.abs(Position.Y) + (math.abs(Position.Z)))) < (1 / 0)
    if v1 then
        local XVector = a1.XVector
        v1 = (math.abs((math.abs(XVector.X)) + math.abs(XVector.Y) + (math.abs(XVector.Z)))) < (1 / 0)
        if v1 then
            local YVector = a1.YVector
            v1 = (math.abs((math.abs(YVector.X)) + math.abs(YVector.Y) + (math.abs(YVector.Z)))) < (1 / 0)
            if v1 then
                local ZVector = a1.ZVector
                v1 = (math.abs((math.abs(ZVector.X)) + math.abs(ZVector.Y) + (math.abs(ZVector.Z)))) < (1 / 0)
            end
        end
    end
    return v1
end

function u0.DrawWeighted(a1, a2) -- Line: 61
    -- upvalues: cumulativeWeights (val), positionAbove (val)
    local v1, v2 = cumulativeWeights(a1)
    if v2 <= 0 then
        return nil
    end
    v2 = positionAbove(v1, (a2 or Random.new()):NextNumber() * v2)
    local v3 = {Value = a1[v2][1], Index = v2}
    local v4 = a1[v2][2]
    if type(v4) ~= "number" then
        error((("weighted entry #%* carries a %* where a numeric weight belongs"):format(v2, (typeof(v4)))))
    end
    v3.Weight = if not (v4 > 0) then 0 else if not (v4 < (1 / 0)) then 0 else v4
    return v3
end

function u0.RollWeighted(a1, a2) -- Line: 75 -- upvalues: u0 (val) -- types: a1: table, a2: userdata?
    local v1 = u0.DrawWeighted(a1, a2)
    if v1 ~= nil then
        return v1.Value
    end
    return nil
end

function u0.Shuffle(a1, a2) -- Line: 80 -- types: a1: table, a2: userdata?
    (a2 or Random.new()):Shuffle(a1)
    return a1
end

return table.freeze(u0)