-- Script path: ReplicatedStorage.UserGenerated.Lottie.Easing
-- Decompile time: 9.95 ms

require(script.Parent.Types)

local function SampleCurve(a1, a2, a3, a4) -- Line: 20 -- types: a1: number, a2: number, a3: number, a4: number
    return ((a1 * a4 + a2) * a4 + a3) * a4
end

local function SampleDerivative(a1, a2, a3, a4) -- Line: 24 -- types: a1: number, a2: number, a3: number, a4: number
    return (a1 * 3 * a4 + a2 * 2) * a4 + a3
end

local function SolveCubicBezier(a1, a2, a3, a4, a5) -- Line: 28
    -- upvalues: 
    local v1, v2, v3
    if a5 <= 0 then
        return 0
    end
    if a5 >= 1 then
        return 1
    end
    if a1 == a2 and a3 == a4 then
        return a5
    end
    local v4 = a1 * 3
    local v5 = (a3 - a1) * 3 - v4
    local v6 = 1 - v4 - v5
    local v7 = a2 * 3
    local v8 = (a4 - a2) * 3 - v7
    local v9 = 1 - v7 - v8
    local v10 = a5
    for i = 1, 8 do
        v1 = ((v6 * v10 + v5) * v10 + v4) * v10 - a5
        if (math.abs(v1)) < 1e-07 then
            return ((v9 * v10 + v8) * v10 + v7) * v10
        end
        if (math.abs((v6 * 3 * v10 + v5 * 2) * v10 + v4)) < 1e-07 then
            break
        end
        v10 = v10 - v1 / v2
    end
    local v11 = 0
    local v12 = 1
    v10 = a5
    for j = 1, 16 do
        v3 = ((v6 * v10 + v5) * v10 + v4) * v10 - a5
        if (math.abs(v3)) < 1e-07 then
            break
        end
        if not (v3 > 0) then
            v11 = v10
        else
            v12 = v10
        end
        v10 = (v11 + v12) * 0.5
    end
    return ((v9 * v10 + v8) * v10 + v7) * v10
end

local function NormalizeHandle(a1, a2) -- Line: 80 -- types: a2: number?
    if type(a1) == "number" then
        return a1
    end
    return a1[a2 or 1] or 0
end

local function LerpScalar(a1, a2, a3) -- Line: 90 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

local function LerpArray(a1, a2, a3) -- Line: 94 -- types: a1: table, a2: table, a3: number
    local v1, v2
    local v3 = table.create(#a1)
    local v4 = #a1
    local v5, v6 = a1, a2
    for i = 1, v4 do
        v2 = v5[i]
        v1 = v6[i] or v5[i]
        v3[i] = v2 + (v1 - v5[i]) * v7
    end
    return v3
end

local function LerpBezierShape(a1, a2, a3) -- Line: 102 -- types: a3: number
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = table.create(#a1.v)
    local v9 = table.create(#a1.i)
    local v10 = table.create(#a1.o)
    local v11 = #a1.v
    for i = 1, v11 do
        v7 = a1.v[i]
        v1 = a2.v[i]
        v2 = a1.i[i]
        v3 = a2.i[i]
        v4 = a1.o[i]
        v5 = a2.o[i]
        v6 = {v7[1] + (v1[1] - v7[1]) * a3, v7[2] + (v1[2] - v7[2]) * a3}
        v8[i] = v6
        v6 = {v2[1] + (v3[1] - v2[1]) * a3, v2[2] + (v3[2] - v2[2]) * a3}
        v9[i] = v6
        v6 = {v4[1] + (v5[1] - v4[1]) * a3, v4[2] + (v5[2] - v4[2]) * a3}
        v10[i] = v6
    end
    return {v = v8, i = v9, o = v10, c = a1.c}
end

local function FindKeyframes(a1, a2) -- Line: 119 -- types: a1: table, a2: number
    local v1 = #a1
    if v1 == 0 then
        return nil, nil, 0
    end
    if v1 == 1 then
        return a1[1], nil, 0
    end
    local v2 = a1[1]
    if a2 <= v2.t then
        return v2, nil, 0
    end
    for i = 2, v1 do
        v2 = a1[i]
        if a2 < v2.t then
            return a1[i - 1], v2, i - 1
        end
    end
    return a1[v1], nil, v1
end

local function ExtractValue(a1) -- Line: 145 -- types: a1: table?
    if a1 == nil or #a1 == 0 then
        return nil
    end
    if type(a1[1]) == "table" then
        return a1[1]
    end
    return a1
end

local function Evaluate(a1, a2) -- Line: 161
    -- upvalues: FindKeyframes (val), SolveCubicBezier (val), LerpArray (val), LerpBezierShape (val)
    local a = a1.a
    local k = a1.k
    if a ~= nil and a ~= 0 then
        local v1, v2 = FindKeyframes(k, a2)
        if v1 == nil then
            return nil
        end
        if v2 == nil then
            local s = v1.s
            local v3 = if s == nil then nil else if #s ~= 0 then if type(s[1]) ~= "table" then s else s[1] else nil
            if v3 ~= nil then
                return v3
            end
            local e = v1.e
            if e == nil or #e == 0 then
                return nil
            end
            if type(e[1]) == "table" then
                return e[1]
            end
            return e
        end
        if v1.h == 1 then
            local s_2 = v1.s
            if s_2 == nil or #s_2 == 0 then
                return nil
            end
            if type(s_2[1]) == "table" then
                return s_2[1]
            end
            return s_2
        end
        local t = v1.t
        local v4 = v2.t - t
        if v4 <= 0 then
            local s_3 = v1.s
            if s_3 == nil or #s_3 == 0 then
                return nil
            end
            if type(s_3[1]) == "table" then
                return s_3[1]
            end
            return s_3
        end
        local v5 = math.clamp((a2 - t) / v4, 0, 1)
        local s_4 = v1.s
        v4 = if s_4 == nil then nil else if #s_4 ~= 0 then if type(s_4[1]) ~= "table" then s_4 else s_4[1] else nil
        local s_5 = v2.s
        local v6 = if s_5 == nil then nil else if #s_5 ~= 0 then if type(s_5[1]) ~= "table" then s_5 else s_5[1] else nil
        if not v6 then
            local e_2 = v1.e
            v6 = if e_2 == nil then nil else if #e_2 ~= 0 then if type(e_2[1]) ~= "table" then e_2 else e_2[1] else nil
        end
        if v4 ~= nil and v6 ~= nil then
            local o = v1.o
            local i = v1.i
            if o and i then
                local x = o.x
                local v7 = if type(x) ~= "number" then x[1] or 0 else x
                local y = o.y
                local v8 = if type(y) ~= "number" then y[1] or 0 else y
                local x_2 = i.x
                local v9 = if type(x_2) ~= "number" then x_2[1] or 0 else x_2
                local y_2 = i.y
                v5 = SolveCubicBezier(v7, v8, v9, if type(y_2) ~= "number" then y_2[1] or 0 else y_2, v5)
            end
            if type(v4) == "number" then
                return v4 + (v6 - v4) * v5
            end
            if type(v4) ~= "table" then
                return v4
            end
            if #v4 > 0 and type(v4[1]) == "number" then
                return (LerpArray(v4, v6, v5))
            end
            return (LerpBezierShape(v4, v6, v5))
        end
        return v4 or v6
    end
    if type(k) == "number" then
        return k
    end
    if type(k) ~= "table" then
        return nil
    end
    if #k > 0 and type(k[1]) == "table" then
        return k[1]
    end
    return k
end

return (table.freeze({
    SolveCubicBezier = SolveCubicBezier,
    Evaluate = Evaluate,
    EvaluateScalar = function(a1, a2) -- Line: 242 -- upvalues: Evaluate (val) -- types: a2: number
        if a1 == nil then
            return a2
        end
        local v1 = Evaluate(a1, 0)
        if v1 == nil then
            return a2
        end
        if type(v1) == "number" then
            return v1
        end
        if type(v1) == "table" then
            return v1[1] or a2
        end
        return a2
    end,
    EvaluateScalarAtFrame = function(a1, a2, a3) -- Line: 259 -- upvalues: Evaluate (val) -- types: a2: number, a3: number
        if a1 == nil then
            return a3
        end
        local v1 = Evaluate(a1, a2)
        if v1 == nil then
            return a3
        end
        if type(v1) == "number" then
            return v1
        end
        if type(v1) == "table" then
            return v1[1] or a3
        end
        return a3
    end,
    EvaluateVector = function(a1, a2, a3) -- Line: 276 -- upvalues: Evaluate (val) -- types: a2: number, a3: table
        if a1 == nil then
            return a3
        end
        local v1 = Evaluate(a1, a2)
        if v1 == nil then
            return a3
        end
        if type(v1) == "table" then
            return v1
        end
        if type(v1) == "number" then
            return {v1}
        end
        return a3
    end,
    EvaluateColor = function(a1, a2) -- Line: 293 -- upvalues: Evaluate (val) -- types: a2: number
        if a1 == nil then
            return Color3.new(1, 1, 1)
        end
        local v1 = Evaluate(a1, a2)
        if v1 == nil then
            return Color3.new(1, 1, 1)
        end
        if type(v1) == "table" then
            return Color3.new(v1[1] or 1, v1[2] or 1, v1[3] or 1)
        end
        return Color3.new(1, 1, 1)
    end,
    EvaluateBezierShape = function(a1, a2) -- Line: 308 -- upvalues: Evaluate (val) -- types: a2: number
        if a1 == nil then
            return nil
        end
        local v1 = Evaluate(a1, a2)
        if v1 == nil then
            return nil
        end
        if type(v1) == "table" and #v1 > 0 and type(v1[1]) ~= "number" then
            return v1
        end
        return nil
    end,
    LerpArray = LerpArray,
}))