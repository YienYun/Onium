-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.AES.Pads
-- Decompile time: 9.06 ms

local copy = buffer.copy
local create = buffer.create
local fill = buffer.fill
local len = buffer.len
local readu8 = buffer.readu8
local writeu8 = buffer.writeu8
local random = math.random
local v1 = {}

local function nonPad(a1) -- Line: 26
    return a1
end

v1.None = table.freeze({Overwrite = false, Pad = nonPad, Unpad = nonPad})

local function anxPad(a1, a2, a3) -- Line: 41
    -- upvalues: len (val), copy (val), fill (val), writeu8 (val), create (val)
    local v1
    local v2 = len(a1)
    local v3 = v2 - v2 % a3
    if not a2 then
        v3 = v3 + a3
        v1 = create(v3)
        copy(v1, 0, a1, 0, v2)
        writeu8(v1, v3 - 1, a3 - v2 % a3)
        return v1
    end
    local v4 = len(a2)
    assert(v2 + a3 <= v4, "Output buffer out of bounds")
    v1 = a3 - v2 % a3
    copy(a2, 0, a1, 0, v2)
    fill(a2, v2, 0, v1 - 1)
    writeu8(a2, v3 + a3 - 1, v1)
    return a2
end

local function anxUnpad(a1, a2, a3) -- Line: 59
    -- upvalues: len (val), readu8 (val), create (val), copy (val)
    local v1
    local v2 = len(a1)
    local v3 = readu8(a1, v2 - 1)
    local v4 = v2 - v3
    local v5 = false
    if v3 > 0 then
        v5 = v3 <= a3
    end
    assert(v5, "Got unexpected padding")
    local v6 = v2 - 2
    local v7 = a1
    for i = v4, v6 do
        if readu8(v7, i) ~= 0 then
            error("Got unexpected padding")
        end
    end
    if not v1 then
        v1 = create(v4)
    else
        assert(v4 <= len(v1), "Output buffer out of bounds")
    end
    copy(v1, 0, v7, 0, v4)
    return v1
end

local function i10Pad(a1, a2, a3) -- Line: 82
    -- upvalues: len (val), create (val), copy (val), random (val), writeu8 (val)
    local v1, v2
    local v3 = len(a1)
    local v4 = v3 - v3 % a3
    if not a2 then
        v1 = create(v4 + a3)
    else
        local v5 = len(a2)
        assert(v3 + a3 <= v5, "Output buffer out of bounds")
        v1 = a2
    end
    copy(v1, 0, a1, 0, v3)
    local v6 = v4 + a3 - 2
    for i = v3, v6 do
        v2 = random(0, 255)
        writeu8(v1, i, v2)
    end
    writeu8(v1, v4 + a3 - 1, a3 - v3 % a3)
    return v1
end

local function i10Unpad(a1, a2, a3) -- Line: 97
    -- upvalues: len (val), readu8 (val), create (val), copy (val)
    local v1
    local v2 = len(a1)
    local v3 = readu8(a1, v2 - 1)
    local v4 = v2 - v3
    local v5 = false
    if v3 > 0 then
        v5 = v3 <= a3
    end
    assert(v5, "Got unexpected padding")
    if not a2 then
        v1 = create(v4)
    else
        assert(v4 <= len(a2), "Output buffer out of bounds")
        v1 = a2
    end
    copy(v1, 0, a1, 0, v4)
    return v1
end

local function pksPad(a1, a2, a3) -- Line: 115
    -- upvalues: len (val), create (val), copy (val), fill (val)
    local v1
    local v2 = len(a1)
    local v3 = v2 - v2 % a3
    if not a2 then
        v1 = create(v3 + a3)
    else
        local v4 = len(a2)
        assert(v2 + a3 <= v4, "Output buffer out of bounds")
        v1 = a2
    end
    v3 = a3 - v2 % a3
    copy(v1, 0, a1, 0, v2)
    fill(v1, v2, v3, v3)
    return v1
end

local function pksUnpad(a1, a2, a3) -- Line: 128
    -- upvalues: len (val), readu8 (val), create (val), copy (val)
    local v1
    local v2 = len(a1)
    local v3 = readu8(a1, v2 - 1)
    local v4 = v2 - v3
    local v5 = false
    if v3 > 0 then
        v5 = v3 <= a3
    end
    assert(v5, "Got unexpected padding")
    local v6 = v2 - 2
    local v7 = a1
    for i = v4, v6 do
        if readu8(v7, i) ~= v3 then
            error("Got unexpected padding")
        end
    end
    if not v1 then
        v1 = create(v4)
    else
        assert(v4 <= len(v1), "Output buffer out of bounds")
    end
    copy(v1, 0, v7, 0, v4)
    return v1
end

local function ii7Pad(a1, a2, a3) -- Line: 151
    -- upvalues: len (val), fill (val), create (val), copy (val), writeu8 (val)
    local v1
    local v2 = len(a1)
    if not a2 then
        v1 = create(v2 + a3 - v2 % a3)
    else
        local v3 = len(a2)
        assert(v2 + a3 <= v3, "Output buffer out of bounds")
        fill(a2, v2 + 1, 0, a3 - v2 % a3 - 1)
        v1 = a2
    end
    copy(v1, 0, a1, 0, v2)
    writeu8(v1, v2, 128)
    return v1
end

local function ii7Unpad(a1, a2, a3) -- Line: 163
    -- upvalues: len (val), readu8 (val), create (val), copy (val)
    local v1
    local v2 = len(a1) - 1
    local v3 = v2 - a3
    local v4, v5 = a1, a2
    for i = v2, v3, -1 do
        v1 = readu8(v4, i)
        if v1 == 128 then
            if not v5 then
                v5 = create(i)
            else
                assert(i <= len(v5), "Output buffer out of bounds")
            end
            copy(v5, 0, v4, 0, i)
            return v5
        end
        assert(v1 == 0, "Got unexpected padding")
    end
    error("Got unexpected padding")
    return create(0)
end

local function zroPad(a1, a2, a3) -- Line: 188
    -- upvalues: len (val), fill (val), create (val), copy (val)
    local v1
    local v2 = len(a1)
    if not a2 then
        v1 = create(v2 + a3 - v2 % a3)
    else
        local v3 = len(a2)
        assert(v2 + a3 <= v3, "Output buffer out of bounds")
        fill(a2, v2, 0, a3 - v2 % a3)
        v1 = a2
    end
    copy(v1, 0, a1, 0, v2)
    return v1
end

local function zroUnpad(a1, a2, a3) -- Line: 199
    -- upvalues: len (val), readu8 (val), create (val), copy (val)
    local v1
    local v2 = len(a1) - 1
    local v3 = v2 - a3
    for i = v2, v3, -1 do
        v1 = i
        if readu8(a1, v1) == 0 then
            v1 = v1 + 1
            if not a2 then
                a2 = create(v1)
            else
                assert(v1 <= len(a2), "Output buffer out of bounds")
            end
            copy(a2, 0, a1, 0, v1)
            return a2
        end
    end
    copy(a2, 0, a1, 0, v2 - a3 - 1)
    return a2
end

local v2 = {
    __index = function(a1, a2) -- Line: 220
        -- upvalues: anxPad (val), i10Pad (val), i10Unpad (val), pksPad (val), pksUnpad (val), ii7Pad (val)
        -- upvalues: ii7Unpad (val), zroPad (val), zroUnpad (val)
        if a2 == "AnsiX923" then
            return {Pad = anxPad, Unpad = anxPad}
        end
        if a2 == "Iso10126" then
            return {Pad = i10Pad, Unpad = i10Unpad}
        end
        if a2 == "Pkcs7" then
            return {Pad = pksPad, Unpad = pksUnpad}
        end
        if a2 == "Iso7816_4" then
            return {Pad = ii7Pad, Unpad = ii7Unpad}
        end
        if a2 == "Zero" then
            return {Pad = zroPad, Unpad = zroUnpad}
        end
        return nil
    end,
    __newindex = function() end,
}
setmetatable(v1, v2)
v1.AnsiX923 = {}
v1.Iso10126 = {}
v1.Pkcs7 = {}
v1.Iso7816_4 = {}
v1.Zero = {}
table.freeze(v1)
v2.__metatable = "This metatable is locked"
return v1