-- Script path: ReplicatedStorage.UserGenerated.Randoms.Xorshift128
-- Decompile time: 24.67 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Randoms.Base)
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
local u20 = require(script.Theory)
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
local format = string.format
local new = Vector2.new
local new_2 = Vector3.new
assert(true)
local u43 = Random.new()

local function Mul32(a1, a2) -- Line: 42
    -- upvalues: rshift (val), band (val), lshift (val)
    local v1 = rshift(a1, 16)
    local v2 = band(a1, 65535)
    local v3 = rshift(a2, 16)
    local v4 = band(a2, 65535)
    return (lshift(band(v1 * v4 + v2 * v3, 65535), 16)) + v2 * v4
end

local function IsInteger(a1) -- Line: 53 -- upvalues: floor (val) -- types: a1: number
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

local function AssertInteger(a1) -- Line: 57 -- upvalues: floor (val) -- types: a1: number
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
end

local function AssertIntegerNonNegative(a1) -- Line: 64 -- upvalues: floor (val) -- types: a1: number
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

local function Seed(a1, a2) -- Line: 154 -- upvalues: u43 (val), bor (val), rshift (val), band (val), lshift (val)
    local v1, v2, v3
    local v4 = (if a2 == nil then {} else if type(a2) ~= "number" then a2 else {a2})[1]
    local v5 = v2[2]
    local v6 = v2[3]
    local v7 = v2[4]
    if not v4 then
        v4 = u43:NextInteger(0, 4294967295)
    end
    v4 = bor(v4, 0)
    if not v5 then
        v3 = rshift(v4, 16)
        v1 = band(v4, 65535)
        v5 = (lshift(band(v1 * 27655 + v3 * 35173, 65535), 16)) + v1 * 35173 + 1
    end
    v5 = bor(v5, 0)
    if not v6 then
        v3 = rshift(v5, 16)
        v1 = band(v5, 65535)
        v6 = (lshift(band(v1 * 27655 + v3 * 35173, 65535), 16)) + v1 * 35173 + 1
    end
    v6 = bor(v6, 0)
    if not v7 then
        v3 = rshift(v6, 16)
        v1 = band(v6, 65535)
        v7 = (lshift(band(v1 * 27655 + v3 * 35173, 65535), 16)) + v1 * 35173 + 1
    end
    local v8 = bor(v7, 0)
    a1.x = v4
    a1.y = v5
    a1.z = v6
    a1.w = v8
end

local u70 = table.freeze({
    __index = table.freeze({
        NextU32 = function(a1) -- Line: 89 -- upvalues: lshift (val), bxor (val), rshift (val)
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            return v1
        end,
        NextU64 = function(a1) -- Line: 99 -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val)
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            local v3 = ldexp(v1, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v1 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v1, (rshift(v1, 8)))
            v2 = bxor
            v2 = v2(v2, w_2)
            v1 = bxor(v2, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v1
            return v3 + v1
        end,
        NextFloat = function(a1) -- Line: 103 -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val)
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            return (ldexp(v1, -32))
        end,
        NextDouble = function(a1) -- Line: 107 -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val)
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            local v3 = ldexp(v1, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v1 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v1, (rshift(v1, 8)))
            v2 = bxor
            v2 = v2(v2, w_2)
            v1 = bxor(v2, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v1
            return (ldexp(v3 + v1, -64))
        end,
        NextNumber = function(a1, a2, a3) -- Line: 111
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val)
            local v1 = a3 - a2
            local x = a1.x
            local w = a1.w
            local v2 = bxor(x, (lshift(x, 11)))
            bxor(v2, (rshift(v2, 8)))
            local v3 = bxor
            v3 = v3(v3, w)
            v2 = bxor(v3, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v2
            local v4 = ldexp(v2, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v2 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v2, (rshift(v2, 8)))
            v3 = bxor
            v3 = v3(v3, w_2)
            v2 = bxor(v3, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v2
            return a2 + v1 * ldexp(v4 + v2, -64)
        end,
        NextInteger = function(a1, a2, a3) -- Line: 115
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val), floor (val)
            local v1 = a3 - a2 + 1
            local x = a1.x
            local w = a1.w
            local v2 = bxor(x, (lshift(x, 11)))
            bxor(v2, (rshift(v2, 8)))
            local v3 = bxor
            v3 = v3(v3, w)
            v2 = bxor(v3, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v2
            local v4 = ldexp(v2, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v2 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v2, (rshift(v2, 8)))
            v3 = bxor
            v3 = v3(v3, w_2)
            v2 = bxor(v3, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v2
            return (floor(a2 + v1 * (ldexp(v4 + v2, -64))))
        end,
        NextNormal = function(a1, a2, a3) -- Line: 119
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val), max (val), log (val), sqrt (val)
            -- upvalues: cos (val), sin (val)
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            local v3 = ldexp(v1, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v1 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v1, (rshift(v1, 8)))
            v2 = bxor
            v2 = v2(v2, w_2)
            v1 = bxor(v2, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v1
            local v4 = (sqrt((log((max(2.2250738585072014e-308, (ldexp(v3 + v1, -64)))))) * -2)) * (a3 or 0)
            local x_3 = a1.x
            local w_3 = a1.w
            local v5 = bxor(x_3, (lshift(x_3, 11)))
            bxor(v5, (rshift(v5, 8)))
            local v6 = bxor
            v6 = v6(v6, w_3)
            v5 = bxor(v6, (rshift(w_3, 19)))
            local y_3 = a1.y
            local z_3 = a1.z
            a1.x = y_3
            a1.y = z_3
            a1.z = w_3
            a1.w = v5
            local v7 = ldexp(v5, 32)
            local x_4 = a1.x
            local w_4 = a1.w
            v5 = bxor(x_4, (lshift(x_4, 11)))
            bxor(v5, (rshift(v5, 8)))
            v6 = bxor
            v6 = v6(v6, w_4)
            v5 = bxor(v6, (rshift(w_4, 19)))
            local y_4 = a1.y
            local z_4 = a1.z
            a1.x = y_4
            a1.y = z_4
            a1.z = w_4
            a1.w = v5
            local v8 = 6.283185307179586 * ldexp(v7 + v5, -64)
            local v9 = a2 or 0
            return cos(v8) * v4 + v9, sin(v8) * v4 + v9
        end,
        NextBoolean = function(a1, a2) -- Line: 126 -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val) -- types: a2: number?
            local x = a1.x
            local w = a1.w
            local v1 = bxor(x, (lshift(x, 11)))
            bxor(v1, (rshift(v1, 8)))
            local v2 = bxor
            v2 = v2(v2, w)
            v1 = bxor(v2, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v1
            local v3 = ldexp(v1, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v1 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v1, (rshift(v1, 8)))
            v2 = bxor
            v2 = v2(v2, w_2)
            v1 = bxor(v2, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v1
            return (ldexp(v3 + v1, -64)) < (a2 or 0.5)
        end,
        NextVector2 = function(a1, a2) -- Line: 130
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val), new (val), cos (val), sin (val)
            local v1 = a2 or 1
            local x = a1.x
            local w = a1.w
            local v2 = bxor(x, (lshift(x, 11)))
            bxor(v2, (rshift(v2, 8)))
            local v3 = bxor
            v3 = v3(v3, w)
            v2 = bxor(v3, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v2
            local v4 = ldexp(v2, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v2 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v2, (rshift(v2, 8)))
            v3 = bxor
            v3 = v3(v3, w_2)
            v2 = bxor(v3, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v2
            local v5 = 6.283185307179586 * ldexp(v4 + v2, -64)
            return new(cos(v5) * v1, sin(v5) * v1)
        end,
        NextVector3 = function(a1, a2) -- Line: 136
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val), sqrt (val), cos (val), sin (val)
            -- upvalues: new_2 (val)
            local v1 = a2 or 1
            local x = a1.x
            local w = a1.w
            local v2 = bxor(x, (lshift(x, 11)))
            bxor(v2, (rshift(v2, 8)))
            local v3 = bxor
            v3 = v3(v3, w)
            v2 = bxor(v3, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v2
            local v4 = ldexp(v2, 32)
            local x_2 = a1.x
            local w_2 = a1.w
            v2 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v2, (rshift(v2, 8)))
            v3 = bxor
            v3 = v3(v3, w_2)
            v2 = bxor(v3, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v2
            local v5 = 6.283185307179586 * ldexp(v4 + v2, -64)
            local x_3 = a1.x
            local w_3 = a1.w
            local v6 = bxor(x_3, (lshift(x_3, 11)))
            bxor(v6, (rshift(v6, 8)))
            local v7 = bxor
            v7 = v7(v7, w_3)
            v6 = bxor(v7, (rshift(w_3, 19)))
            local y_3 = a1.y
            local z_3 = a1.z
            a1.x = y_3
            a1.y = z_3
            a1.z = w_3
            a1.w = v6
            local v8 = ldexp(v6, 32)
            local x_4 = a1.x
            local w_4 = a1.w
            v6 = bxor(x_4, (lshift(x_4, 11)))
            bxor(v6, (rshift(v6, 8)))
            v7 = bxor
            v7 = v7(v7, w_4)
            v6 = bxor(v7, (rshift(w_4, 19)))
            local y_4 = a1.y
            local z_4 = a1.z
            a1.x = y_4
            a1.y = z_4
            a1.z = w_4
            a1.w = v6
            local v9 = ldexp(v8 + v6, -64) * 2 - 1
            local v10 = sqrt(1 - v9 * v9)
            return (new_2(cos(v5) * v10 * v1, sin(v5) * v10 * v1, v9 * v1))
        end,
        NextUUIDv4 = function(a1) -- Line: 144 -- upvalues: format (val), lshift (val), bxor (val), rshift (val), band (val), bor (val)
            local v1 = format
            local x = a1.x
            local w = a1.w
            local v2 = bxor(x, (lshift(x, 11)))
            bxor(v2, (rshift(v2, 8)))
            local v3 = bxor
            v3 = v3(v3, w)
            v2 = bxor(v3, (rshift(w, 19)))
            local y = a1.y
            local z = a1.z
            a1.x = y
            a1.y = z
            a1.z = w
            a1.w = v2
            local v4 = v2
            local x_2 = a1.x
            local w_2 = a1.w
            local v5 = bxor(x_2, (lshift(x_2, 11)))
            bxor(v5, (rshift(v5, 8)))
            local v6 = bxor
            v6 = v6(v6, w_2)
            v5 = bxor(v6, (rshift(w_2, 19)))
            local y_2 = a1.y
            local z_2 = a1.z
            a1.x = y_2
            a1.y = z_2
            a1.z = w_2
            a1.w = v5
            v2 = bor(band(v5, 4294905855), 16384)
            local x_3 = a1.x
            local w_3 = a1.w
            local v7 = bxor(x_3, (lshift(x_3, 11)))
            bxor(v7, (rshift(v7, 8)))
            local v8 = bxor
            v8 = v8(v8, w_3)
            v7 = bxor(v8, (rshift(w_3, 19)))
            local y_3 = a1.y
            local z_3 = a1.z
            a1.x = y_3
            a1.y = z_3
            a1.z = w_3
            a1.w = v7
            local v9 = bor(band(v7, 1073741823), 2147483648)
            local x_4 = a1.x
            local w_4 = a1.w
            v5 = bxor(x_4, (lshift(x_4, 11)))
            bxor(v5, (rshift(v5, 8)))
            v6 = bxor
            v6 = v6(v6, w_4)
            v5 = bxor(v6, (rshift(w_4, 19)))
            local y_4 = a1.y
            local z_4 = a1.z
            a1.x = y_4
            a1.y = z_4
            a1.z = w_4
            a1.w = v5
            return v1("%08x%08x%08x%08x", v4, v2, v9, v5)
        end,
        Seed = Seed,
        Shuffle = function(a1, a2) -- Line: 185
            -- upvalues: lshift (val), bxor (val), rshift (val), ldexp (val), floor (val)
            local v1, v2, v3, v4, v5, v6, v7, w, w_2, x, x_2, y, y_2, z, z_2
            assert(type(a2) == "table")
            for i = #a2, 2, -1 do
                v7 = i - 1 + 1
                x = a1.x
                w = a1.w
                v2 = bxor(x, (lshift(x, 11)))
                bxor(v2, (rshift(v2, 8)))
                v3 = bxor
                v3 = v3(v3, w)
                v2 = bxor(v3, (rshift(w, 19)))
                y = a1.y
                z = a1.z
                a1.x = y
                a1.y = z
                a1.z = w
                a1.w = v2
                v1 = ldexp(v2, 32)
                x_2 = a1.x
                w_2 = a1.w
                v2 = bxor(x_2, (lshift(x_2, 11)))
                bxor(v2, (rshift(v2, 8)))
                v3 = bxor
                v3 = v3(v3, w_2)
                v2 = bxor(v3, (rshift(w_2, 19)))
                y_2 = a1.y
                z_2 = a1.z
                a1.x = y_2
                a1.y = z_2
                a1.z = w_2
                a1.w = v2
                v4 = floor(v7 * (ldexp(v1 + v2, -64)) + 1)
                v5 = a2[v4]
                v6 = a2[i]
                a2[i] = v5
                a2[v4] = v6
            end
        end,
        Clone = function(a1) -- Line: 193
            return (setmetatable({x = a1.x, y = a1.y, z = a1.z, w = a1.w}, (getmetatable(a1))))
        end,
        GetState = function(a1) -- Line: 203
            return {a1.x, a1.y, a1.z, a1.w}
        end,
        Skip = function(a1, a2) -- Line: 207 -- upvalues: floor (val), u20 (val) -- types: a2: number
            local v1, v2, v3
            local v4 = false
            if type(a2) == "number" then
                v4 = false
                if floor(a2) == a2 then
                    v4 = false
                    if a2 ~= (1 / 0) then
                        v4 = a2 ~= (-1 / 0)
                    end
                end
            end
            if not v4 then
                error("Integer", 2)
            end
            v4, v1, v2, v3 = u20.Transform(a1.x, a1.y, a1.z, a1.w, a2)
            a1.x = v4
            a1.y = v1
            a1.z = v2
            a1.w = v3
        end,
    }),
})
local u71 = {}

function u71.new(a1) -- Line: 234 -- upvalues: Seed (val), u70 (val)
    local v1 = {x = 0, y = 0, z = 0, w = 0}
    Seed(v1, a1)
    return (setmetatable(v1, u70))
end

function u71.Unique(a1) -- Line: 245
    -- upvalues: floor (val), clamp (val), u71 (val), GenerateSeed (val)
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
    return u71.new(GenerateSeed((clamp(a1 or 4, 0, 4))))
end

u71.R = u71.Unique()
return table.freeze(u71)