-- Script path: ReplicatedStorage.UserGenerated.Randoms.Xorshift128.Theory
-- Decompile time: 9.01 ms

local function MatClone(a1) -- Line: 23 -- types: a1: table
    local v1 = table.clone(a1)
    local v2 = #v1
    for i = 1, v2 do
        v1[i] = (table.clone(v1[i]))
    end
    return v1
end

local function MatZero(a1) -- Line: 31 -- types: a1: number
    local v1 = table.create(a1)
    for i = 1, a1 do
        v1[i] = (table.create(a1, 0))
    end
    return v1
end

local function MatIdent(a1) -- Line: 39 -- upvalues: MatZero (val) -- types: a1: number
    local v1 = MatZero(a1)
    for i = 1, a1 do
        v1[i][i] = 1
    end
    return v1
end

local function MatMul(a1, a2) -- Line: 47 -- types: a1: table, a2: table
    local v1, v2
    local v3 = {}
    local v4 = #a1
    local v5 = #a1[1]
    local v6 = #a2[1]
    local v7, v8 = a1, a2
    for i = 1, v4 do
        v2 = table.create(v6, 0)
        for j = 1, v6 do
            v1 = 0
            for k = 1, v5 do
                v1 = bit32.bxor(v1, (bit32.band(v7[i][k], v8[k][j])))
            end
            v2[j] = v1
        end
        v3[i] = v2
    end
    return v3
end

local function MatMulVec(a1, a2) -- Line: 64 -- types: a1: table, a2: table
    local v1
    local v2 = #a1
    local v3 = #a1[1]
    local v4 = table.create(v2, 0)
    local v5, v6 = a1, a2
    for i = 1, v2 do
        v1 = 0
        for j = 1, v3 do
            v1 = bit32.bxor(v1, (bit32.band(v5[i][j], v6[j])))
        end
        v4[i] = v1
    end
    return v4
end

local function MatSum(a1, a2) -- Line: 77 -- upvalues: MatZero (val) -- types: a1: table, a2: table
    local v1, v2, v3
    local v4 = #a1
    local v5 = #a1[1]
    local v6 = MatZero(v4)
    local v7, v8 = a1, a2
    for i = 1, v4 do
        for j = 1, v5 do
            v1 = v6[i]
            v2 = v7[i][j]
            v3 = v8[i][j]
            v1[j] = (bit32.bxor(v2, v3))
        end
    end
    return v6
end

local function MatInverse(a1) -- Line: 88 -- upvalues: MatClone (val), MatZero (val) -- types: a1: table
    local v1, v2, v3, v4, v5, v6
    local v7 = #a1
    local v8 = MatClone(a1)
    local v9 = MatZero(v7)
    for i = 1, v7 do
        v9[i][i] = 1
    end
    for j = 1, v7 do
        v4 = nil
        for k = j, v7 do
            if v8[k][j] == 1 then
                v4 = k
                break
            end
        end
        assert(v4, "not invertible")
        v5 = v8[v4]
        v6 = v8[j]
        v8[j] = v5
        v8[v4] = v6
        v5 = v9[v4]
        v6 = v9[j]
        v9[j] = v5
        v9[v4] = v6
        for n = 1, v7 do
            if n ~= j and v8[n][j] == 1 then
                for m = 1, v7 do
                    v1 = v8[n]
                    v2 = v8[n][m]
                    v3 = v8[j][m]
                    v1[m] = (bit32.bxor(v2, v3))
                    v1 = v9[n]
                    v2 = v9[n][m]
                    v3 = v9[j][m]
                    v1[m] = (bit32.bxor(v2, v3))
                end
            end
        end
    end
    return v9
end

local function MatPow(a1, a2) -- Line: 115
    -- upvalues: MatZero (val), MatInverse (val), MatClone (val), MatMul (val)
    local v1 = #a1
    local v2 = MatZero(v1)
    for i = 1, v1 do
        v2[i][i] = 1
    end
    v1 = if not (a2 < 0) then MatClone(a1) else MatInverse(a1)
    local v3 = math.abs(a2)
    while v3 > 0 do
        if 0.5 <= (math.fmod(v3, 2)) then
            v2 = MatMul(v2, v1)
        end
        MatMul(v1, v1)
        math.floor(v3 / 2)
    end
    return v2
end

local function L(a1, a2) -- Line: 130 -- upvalues: MatZero (val) -- types: a1: number, a2: number
    local v1 = MatZero(a2)
    local v2 = a2 - a1
    for i = 1, v2 do
        v1[i][i + a1] = 1
    end
    return v1
end

local function R(a1, a2) -- Line: 138 -- upvalues: MatZero (val) -- types: a1: number, a2: number
    local v1 = MatZero(a2)
    for i = a1 + 1, a2 do
        v1[i][i - a1] = 1
    end
    return v1
end

local function Embed(a1, a2, a3, a4) -- Line: 146
    -- upvalues: MatZero (val)
    local v1, v2
    local v3 = MatZero(a2)
    local v4 = #a1
    local v5, v6, v7 = a1, a3, a4
    for i = 1, v4 do
        v2 = #v5[1]
        for j = 1, v2 do
            v1 = v3[v6 + i]
            v1[v7 + j] = v5[i][j]
        end
    end
    return v3
end

local function ToColumnVector128(a1, a2, a3, a4) -- Line: 156 -- types: a1: number, a2: number, a3: number, a4: number
    local v1
    local v2 = table.create(128, 0)
    for i = 0, 31 do
        v1 = 32 - i
        v2[v1] = (bit32.band(bit32.rshift(a1, i), 1))
        v1 = 64 - i
        v2[v1] = (bit32.band(bit32.rshift(a2, i), 1))
        v1 = 96 - i
        v2[v1] = (bit32.band(bit32.rshift(a3, i), 1))
        v1 = 128 - i
        v2[v1] = (bit32.band(bit32.rshift(a4, i), 1))
    end
    return v2
end

local function FromColumnVector128(a1) -- Line: 167 -- types: a1: table
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0
    for i = 0, 31 do
        v1 = bit32.bor(v1, (bit32.lshift(a1[32 - i], i)))
        v2 = bit32.bor(v2, (bit32.lshift(a1[64 - i], i)))
        v3 = bit32.bor(v3, (bit32.lshift(a1[96 - i], i)))
        v4 = bit32.bor(v4, (bit32.lshift(a1[128 - i], i)))
    end
    return v1, v2, v3, v4
end

local u15 = (function() -- Line: 178 -- upvalues: MatIdent (val), L (val), MatMul (val), MatSum (val), Embed (val), R (val)
    local v1 = MatIdent(32)
    local v2 = MatIdent(128)
    local v3 = MatMul(MatSum(v2, (Embed(L(11, 32), 128, 0, 0))), v2)
    v3 = MatMul(MatSum(v2, (Embed(R(8, 32), 128, 0, 0))), v3)
    v3 = MatMul(MatSum(v2, (Embed(v1, 128, 0, 96))), v3)
    v3 = MatMul(MatSum(v2, (Embed(R(19, 32), 128, 0, 96))), v3)
    return (MatMul(MatSum(L(32, 128), (R(96, 128))), v3))
end)()
return table.freeze({
    ToColumnVector128 = ToColumnVector128,
    FromColumnVector128 = FromColumnVector128,
    MatTransform = function() -- Line: 211 -- upvalues: MatClone (val), u15 (val)
        return (MatClone(u15))
    end,
    Transform = function(a1, a2, a3, a4, a5) -- Line: 215
        -- upvalues: ToColumnVector128 (val), MatMulVec (val), MatPow (val), MatClone (val), u15 (val)
        -- upvalues: FromColumnVector128 (val)
        local v1 = ToColumnVector128(a1, a2, a3, a4)
        v1 = MatMulVec(MatPow(MatClone(u15), a5), v1)
        return FromColumnVector128(v1)
    end,
})