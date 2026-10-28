-- Script path: ReplicatedStorage.UserGenerated.Randoms.ISAAC
-- Decompile time: 17.23 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Randoms.Base)
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
local bxor = bit32.bxor
local bor = bit32.bor
local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local floor = math.floor
local ldexp = math.ldexp
local sqrt = math.sqrt
local log = math.log
local max = math.max
local sin = math.sin
local cos = math.cos
local clamp = math.clamp
local create = table.create
local clone = table.clone
local format = string.format
local new = Vector2.new
local new_2 = Vector3.new
assert(true)
local u40 = Random.new()

local function IsInteger(a1) -- Line: 43 -- upvalues: floor (val) -- types: a1: number
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if floor(a1) == a1 then
            v1 = false
            if a1 ~= (1 / 0) then
                v1 = a1 ~= (-1 / 0)
            end
        end
    end
    return v1
end

local function AssertIntegerNonNegative(a1) -- Line: 48 -- upvalues: floor (val) -- types: a1: number
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if floor(a1) == a1 then
            v1 = false
            if a1 ~= (1 / 0) then
                v1 = a1 ~= (-1 / 0)
            end
        end
    end
    if not v1 then
        error("Integer", 2)
    end
    if not (a1 >= 0) then
        error("NonNegative", 2)
    end
end

local function IsaacMix(a1) -- Line: 76
    -- upvalues: lshift (val), bxor (val), bor (val), rshift (val)
    local v1 = a1[1]
    local v2 = a1[2]
    local v3 = a1[3]
    local v4 = a1[4]
    local v5 = a1[5]
    local v6 = a1[6]
    local v7 = a1[7]
    local v8 = a1[8]
    v1 = bxor(v1, (lshift(v2, 11)))
    v4 = bor(v4 + v1, 0)
    v2 = bxor(bor(v2 + v3, 0), (rshift(v3, 2)))
    v5 = bor(v5 + v2, 0)
    v3 = bxor(bor(v3 + v4, 0), (lshift(v4, 8)))
    v6 = bor(v6 + v3, 0)
    v4 = bxor(bor(v4 + v5, 0), (rshift(v5, 16)))
    v7 = bor(v7 + v4, 0)
    v5 = bxor(bor(v5 + v6, 0), (lshift(v6, 10)))
    v8 = bor(v8 + v5, 0)
    v6 = bxor(bor(v6 + v7, 0), (rshift(v7, 4)))
    v1 = bor(v1 + v6, 0)
    v7 = bxor(bor(v7 + v8, 0), (lshift(v8, 8)))
    v2 = bor(v2 + v7, 0)
    v8 = bxor(bor(v8 + v1, 0), (rshift(v1, 9)))
    v3 = bor(v3 + v8, 0)
    a1[1] = (bor(v1 + v2, 0))
    a1[2] = v2
    a1[3] = v3
    a1[4] = v4
    a1[5] = v5
    a1[6] = v6
    a1[7] = v7
    a1[8] = v8
end

local function Isaac(a1) -- Line: 105 -- upvalues: bor (val), band (val), rshift (val), bxor (val), lshift (val)
    local v1, v2, v3
    local AA = a1.AA
    local BB = a1.BB
    local CC = a1.CC
    local MM = a1.MM
    local RSL = a1.RSL
    local v4 = bor(CC + 1, 0)
    local v5 = bor(BB + v4, 0)
    for i = 1, 256 do
        v3 = MM[i]
        v2 = band(i, 3)
        if v2 == 0 then
            AA = bxor(AA, (rshift(AA, 16)))
        elseif v2 == 1 then
            AA = bxor(AA, (lshift(AA, 13)))
        elseif v2 == 2 then
            AA = bxor(AA, (rshift(AA, 6)))
        elseif v2 == 3 then
            AA = bxor(AA, (lshift(AA, 2)))
        end
        AA = bor(MM[band(i + 127, 255) + 1] + AA, 0)
        v1 = bor(MM[band(rshift(v3, 2), 255) + 1] + AA + v5, 0)
        MM[i] = v1
        v5 = bor(MM[band(rshift(v1, 10), 255) + 1] + v3, 0)
        RSL[i] = v5
    end
    a1.AA = AA
    a1.BB = v5
    a1.CC = v4
end

local function IsaacInit(a1, a2) -- Line: 132 -- upvalues: create (val), IsaacMix (val), bor (val) -- types: a2: boolean
    local v1
    a1.AA = 0
    a1.BB = 0
    a1.CC = 0
    a1.Count = 256
    local MM = a1.MM
    local RSL = a1.RSL
    local v2 = create(8, 2654435769)
    IsaacMix(v2)
    IsaacMix(v2)
    IsaacMix(v2)
    IsaacMix(v2)
    for i = 0, 255, 8 do
        if a2 then
            for j = 1, 8 do
                v1 = v2[j] + RSL[i + j]
                v2[j] = (bor(v1, 0))
            end
        end
        IsaacMix(v2)
        MM[i + 1] = v2[1]
        MM[i + 2] = v2[2]
        MM[i + 3] = v2[3]
        MM[i + 4] = v2[4]
        MM[i + 5] = v2[5]
        MM[i + 6] = v2[6]
        MM[i + 7] = v2[7]
        MM[i + 8] = v2[8]
    end
    if a2 then
        for k = 0, 255, 8 do
            for n = 1, 8 do
                v1 = v2[n] + MM[k + n]
                v2[n] = (bor(v1, 0))
            end
            IsaacMix(v2)
            MM[k + 1] = v2[1]
            MM[k + 2] = v2[2]
            MM[k + 3] = v2[3]
            MM[k + 4] = v2[4]
            MM[k + 5] = v2[5]
            MM[k + 6] = v2[6]
            MM[k + 7] = v2[7]
            MM[k + 8] = v2[8]
        end
    end
end

local function Seed(a1, a2, a3) -- Line: 234 -- upvalues: u40 (val), bor (val), IsaacInit (val) -- types: a3: boolean?
    local v1, v2
    if a2 == nil then
        v2 = {u40:NextInteger(0, 4294967295)}
    elseif type(a2) ~= "number" then
        assert(type(a2) == "table")
        v2 = a2
    else
        v2 = {a2}
    end
    local v3 = true
    if a3 ~= nil then
        assert(type(a3) == "boolean")
        v3 = a3
    end
    local v4 = math.min(256, #v2)
    local MM = a1.MM
    local RSL = a1.RSL
    for i = 1, 256 do
        MM[i] = 0
        RSL[i] = 0
    end
    for j = 1, v4 do
        v1 = v2[j]
        RSL[j] = (bor(v1, 0))
    end
    IsaacInit(a1, v3)
end

local u66 = table.freeze({
    __index = table.freeze({
        NextU32 = function(a1) -- Line: 169 -- upvalues: Isaac (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            return a1.RSL[v1]
        end,
        NextU64 = function(a1) -- Line: 179 -- upvalues: Isaac (val), ldexp (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v2 = ldexp(a1.RSL[v1], 32)
            v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            return v2 + a1.RSL[v1]
        end,
        NextFloat = function(a1) -- Line: 183 -- upvalues: Isaac (val), ldexp (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            return (ldexp(a1.RSL[v1], -32))
        end,
        NextDouble = function(a1) -- Line: 187 -- upvalues: Isaac (val), ldexp (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v2 = ldexp(a1.RSL[v1], 32)
            v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            return (ldexp(v2 + a1.RSL[v1], -64))
        end,
        NextNumber = function(a1, a2, a3) -- Line: 191 -- upvalues: Isaac (val), ldexp (val) -- types: a2: number, a3: number
            local v1 = a3 - a2
            local v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v3 = ldexp(a1.RSL[v2], 32)
            v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            return a2 + v1 * ldexp(v3 + a1.RSL[v2], -64)
        end,
        NextInteger = function(a1, a2, a3) -- Line: 195 -- upvalues: Isaac (val), ldexp (val), floor (val) -- types: a2: number, a3: number
            local v1 = a3 - a2 + 1
            local v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v3 = ldexp(a1.RSL[v2], 32)
            v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            return (floor(a2 + v1 * (ldexp(v3 + a1.RSL[v2], -64))))
        end,
        NextNormal = function(a1, a2, a3) -- Line: 199
            -- upvalues: Isaac (val), ldexp (val), max (val), log (val), sqrt (val), cos (val), sin (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v2 = ldexp(a1.RSL[v1], 32)
            v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v3 = (sqrt((log((max(2.2250738585072014e-308, (ldexp(v2 + a1.RSL[v1], -64)))))) * -2)) * (a3 or 0)
            local v4 = a1.Count + 1
            if v4 > 256 then
                v4 = 1
                Isaac(a1)
            end
            a1.Count = v4
            local v5 = ldexp(a1.RSL[v4], 32)
            v4 = a1.Count + 1
            if v4 > 256 then
                v4 = 1
                Isaac(a1)
            end
            a1.Count = v4
            local v6 = 6.283185307179586 * ldexp(v5 + a1.RSL[v4], -64)
            local v7 = a2 or 0
            return cos(v6) * v3 + v7, sin(v6) * v3 + v7
        end,
        NextBoolean = function(a1, a2) -- Line: 206 -- upvalues: Isaac (val), ldexp (val) -- types: a2: number?
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v2 = ldexp(a1.RSL[v1], 32)
            v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            return (ldexp(v2 + a1.RSL[v1], -64)) < (a2 or 0.5)
        end,
        NextVector2 = function(a1, a2) -- Line: 210
            -- upvalues: Isaac (val), ldexp (val), new (val), cos (val), sin (val)
            local v1 = a2 or 1
            local v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v3 = ldexp(a1.RSL[v2], 32)
            v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v4 = 6.283185307179586 * ldexp(v3 + a1.RSL[v2], -64)
            return new(cos(v4) * v1, sin(v4) * v1)
        end,
        NextVector3 = function(a1, a2) -- Line: 216
            -- upvalues: Isaac (val), ldexp (val), sqrt (val), cos (val), sin (val), new_2 (val)
            local v1 = a2 or 1
            local v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v3 = ldexp(a1.RSL[v2], 32)
            v2 = a1.Count + 1
            if v2 > 256 then
                v2 = 1
                Isaac(a1)
            end
            a1.Count = v2
            local v4 = 6.283185307179586 * ldexp(v3 + a1.RSL[v2], -64)
            local v5 = a1.Count + 1
            if v5 > 256 then
                v5 = 1
                Isaac(a1)
            end
            a1.Count = v5
            local v6 = ldexp(a1.RSL[v5], 32)
            v5 = a1.Count + 1
            if v5 > 256 then
                v5 = 1
                Isaac(a1)
            end
            a1.Count = v5
            local v7 = ldexp(v6 + a1.RSL[v5], -64) * 2 - 1
            local v8 = sqrt(1 - v7 * v7)
            return (new_2(cos(v4) * v8 * v1, sin(v4) * v8 * v1, v7 * v1))
        end,
        NextUUIDv4 = function(a1) -- Line: 224 -- upvalues: format (val), Isaac (val), band (val), bor (val)
            local v1 = a1.Count + 1
            if v1 > 256 then
                v1 = 1
                Isaac(a1)
            end
            a1.Count = v1
            local v2 = a1.RSL[v1]
            local v3 = a1.Count + 1
            if v3 > 256 then
                v3 = 1
                Isaac(a1)
            end
            a1.Count = v3
            v1 = bor(band(a1.RSL[v3], 4294905855), 16384)
            local v4 = a1.Count + 1
            if v4 > 256 then
                v4 = 1
                Isaac(a1)
            end
            a1.Count = v4
            local v5 = bor(band(a1.RSL[v4], 1073741823), 2147483648)
            v3 = a1.Count + 1
            if v3 > 256 then
                v3 = 1
                Isaac(a1)
            end
            a1.Count = v3
            return format("%08x%08x%08x%08x", v2, v1, v5, a1.RSL[v3])
        end,
        Seed = Seed,
        Shuffle = function(a1, a2) -- Line: 261 -- upvalues: Isaac (val), ldexp (val), floor (val) -- types: a2: table
            local v1, v2, v3, v4, v5
            assert(type(a2) == "table")
            local v6 = a1
            for i = #a2, 2, -1 do
                v2 = v6.Count + 1
                if v2 > 256 then
                    v2 = 1
                    Isaac(v6)
                end
                v6.Count = v2
                v1 = ldexp(v6.RSL[v2], 32)
                v2 = v6.Count + 1
                if v2 > 256 then
                    v2 = 1
                    Isaac(v6)
                end
                v6.Count = v2
                v3 = floor((i - 1 + 1) * (ldexp(v1 + v6.RSL[v2], -64)) + 1)
                v4 = v7[v3]
                v5 = v7[i]
                v7[i] = v4
                v7[v3] = v5
            end
        end,
        Clone = function(a1) -- Line: 269 -- upvalues: clone (val)
            return (setmetatable({
                RSL = clone(a1.RSL),
                Count = a1.Count,
                MM = clone(a1.MM),
                AA = a1.AA,
                BB = a1.BB,
                CC = a1.CC,
            }, (getmetatable(a1))))
        end,
    }),
})
local u67 = {}

function u67.new(a1, a2) -- Line: 301 -- upvalues: create (val), Seed (val), u66 (val) -- types: a2: boolean?
    local v1 = {
        Count = 0,
        AA = 0,
        BB = 0,
        CC = 0,
        RSL = create(256, 0),
        MM = create(256, 0),
    }
    Seed(v1, a1, a2)
    return (setmetatable(v1, u66))
end

function u67.Unique(a1) -- Line: 314
    -- upvalues: floor (val), clamp (val), u67 (val), GenerateSeed (val)
    if a1 ~= nil then
        local v1 = false
        if type(a1) == "number" then
            v1 = false
            if floor(a1) == a1 then
                v1 = false
                if a1 ~= (1 / 0) then
                    v1 = a1 ~= (-1 / 0)
                end
            end
        end
        if not v1 then
            error("Integer", 2)
        end
        if not (a1 >= 0) then
            error("NonNegative", 2)
        end
    end
    return u67.new(GenerateSeed((clamp(a1 or 32, 0, 256))), true)
end

u67.R = u67.Unique()
return table.freeze(u67)