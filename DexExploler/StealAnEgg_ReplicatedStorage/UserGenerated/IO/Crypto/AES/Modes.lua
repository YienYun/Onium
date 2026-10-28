-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.AES.Modes
-- Decompile time: 21.36 ms

local bxor = bit32.bxor
local copy = buffer.copy
local create = buffer.create
local len = buffer.len
local readu8 = buffer.readu8
local readu32 = buffer.readu32
local tostring = buffer.tostring
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu32 = buffer.writeu32
local floor = math.floor
local random = math.random
local pack = string.pack
local u15 = create(16)

local function addByteCtr(a1, a2, a3, a4, a5) -- Line: 44
    -- upvalues: readu8 (val), writeu8 (val)
    local v1
    if not a5 then
        v1 = readu8(a1, a4) + a2
        writeu8(a1, a4, v1)
        if v1 >= 256 then
            for i = a4 - 1, a3, -1 do
                v1 = readu8(a1, i) + 1
                writeu8(a1, i, v1)
                if v1 < 256 then
                    break
                end
            end
        end
        return
    end
    v1 = readu8(a1, a3) + a2
    writeu8(a1, a3, v1)
    if not (v1 >= 256) then
        return
    end
    for j = a3 + 1, a4 do
        v1 = readu8(a1, j) + 1
        writeu8(a1, j, v1)
        if v1 < 256 then
            return
        end
    end
end

local v1 = {
    ECB = {
        FwdMode = function(a1, a2, a3, a4) -- Line: 81 -- upvalues: len (val)
            local v1 = len(a3) - 16
            assert(v1 % 16 == 0, "Input length must be a multiple of 16 bytes")
            for i = 0, v1, 16 do
                a1(a3, i, a4, i)
            end
        end,
        InvMode = function(a1, a2, a3, a4) -- Line: 88 -- upvalues: len (val)
            local v1 = len(a3) - 16
            assert(v1 % 16 == 0, "Input length must be a multiple of 16 bytes")
            for i = 0, v1, 16 do
                a2(a3, i, a4, i)
            end
        end,
    },
}
table.freeze(v1.ECB)
v1.CBC = {
    FwdMode = function(a1, a2, a3, a4, a5, a6) -- Line: 105
        -- upvalues: len (val), u15 (val), readu32 (val), bxor (val), writeu32 (val)
        local v1
        local v2 = len(a3) - 16
        assert(v2 % 16 == 0, "Input length must be a multiple of 16 bytes")
        local v3 = a6 or u15
        assert(len(v3) == 16, "Initialization vector must be 16 bytes long")
        writeu32(a4, 0, (bxor(readu32(a3, 0), (readu32(v3, 0)))))
        writeu32(a4, 4, (bxor(readu32(a3, 4), (readu32(v3, 4)))))
        writeu32(a4, 8, (bxor(readu32(a3, 8), (readu32(v3, 8)))))
        writeu32(a4, 12, (bxor(readu32(a3, 12), (readu32(v3, 12)))))
        a1(a4, 0, a4, 0)
        for i = 16, v2, 16 do
            v1 = bxor(readu32(a3, i), (readu32(a4, i - 16)))
            writeu32(a4, i, v1)
            writeu32(a4, i + 4, (bxor(readu32(a3, i + 4), (readu32(a4, i - 12)))))
            writeu32(a4, i + 8, (bxor(readu32(a3, i + 8), (readu32(a4, i - 8)))))
            writeu32(a4, i + 12, (bxor(readu32(a3, i + 12), (readu32(a4, i - 4)))))
            a1(a4, i, a4, i)
        end
    end,
    InvMode = function(a1, a2, a3, a4, a5, a6) -- Line: 123
        -- upvalues: len (val), u15 (val), readu32 (val), bxor (val), writeu32 (val)
        local v1
        local v2 = len(a3) - 16
        assert(v2 % 16 == 0, "Input length must be a multiple of 16 bytes")
        local v3 = a6 or u15
        assert(len(v3) == 16, "Initialization vector must be 16 bytes long")
        local v4 = readu32(a3, 0)
        local v5 = readu32(a3, 4)
        local v6 = readu32(a3, 8)
        local v7 = readu32(a3, 12)
        a2(a3, 0, a4, 0)
        writeu32(a4, 0, (bxor(readu32(a4, 0), (readu32(v3, 0)))))
        writeu32(a4, 4, (bxor(readu32(a4, 4), (readu32(v3, 4)))))
        writeu32(a4, 8, (bxor(readu32(a4, 8), (readu32(v3, 8)))))
        writeu32(a4, 12, (bxor(readu32(a4, 12), (readu32(v3, 12)))))
        for i = 16, v2, 16 do
            readu32(a3, i)
            readu32(a3, i + 4)
            readu32(a3, i + 8)
            readu32(a3, i + 12)
            a2(a3, i, a4, i)
            v1 = bxor(readu32(a4, i), v4)
            writeu32(a4, i, v1)
            writeu32(a4, i + 4, (bxor(readu32(a4, i + 4), v5)))
            writeu32(a4, i + 8, (bxor(readu32(a4, i + 8), v6)))
            writeu32(a4, i + 12, (bxor(readu32(a4, i + 12), v7)))
        end
    end,
}
table.freeze(v1.CBC)
v1.PCBC = {
    FwdMode = function(a1, a2, a3, a4, a5, a6) -- Line: 161
        -- upvalues: len (val), u15 (val), readu32 (val), bxor (val), writeu32 (val)
        local v1, v2, v3, v4, v5
        local v6 = len(a3) - 16
        assert(v6 % 16 == 0, "Input length must be a multiple of 16 bytes")
        local v7 = a6 or u15
        assert(len(v7) == 16, "Initialization vector must be 16 bytes long")
        local v8 = readu32(a3, 0)
        local v9 = readu32(a3, 4)
        local v10 = readu32(a3, 8)
        local v11 = readu32(a3, 12)
        writeu32(a4, 0, (bxor(v8, (readu32(v7, 0)))))
        writeu32(a4, 4, (bxor(v9, (readu32(v7, 4)))))
        writeu32(a4, 8, (bxor(v10, (readu32(v7, 8)))))
        writeu32(a4, 12, (bxor(v11, (readu32(v7, 12)))))
        a1(a4, 0, a4, 0)
        for i = 16, v6, 16 do
            v1 = readu32(a3, i)
            v2 = readu32(a3, i + 4)
            v3 = readu32(a3, i + 8)
            v4 = readu32(a3, i + 12)
            v5 = bxor(v8, v1, (readu32(a4, i - 16)))
            writeu32(a4, i, v5)
            writeu32(a4, i + 4, (bxor(v9, v2, (readu32(a4, i - 12)))))
            writeu32(a4, i + 8, (bxor(v10, v3, (readu32(a4, i - 8)))))
            writeu32(a4, i + 12, (bxor(v11, v4, (readu32(a4, i - 4)))))
            a1(a4, i, a4, i)
        end
    end,
    InvMode = function(a1, a2, a3, a4, a5, a6) -- Line: 189
        -- upvalues: len (val), u15 (val), readu32 (val), bxor (val), writeu32 (val)
        local v1 = len(a3) - 16
        assert(v1 % 16 == 0, "Input length must be a multiple of 16 bytes")
        local v2 = a6 or u15
        assert(len(v2) == 16, "Initialization vector must be 16 bytes long")
        local v3 = readu32(a3, 0)
        local v4 = readu32(a3, 4)
        local v5 = readu32(a3, 8)
        local v6 = readu32(a3, 12)
        a2(a3, 0, a4, 0)
        local v7 = bxor(readu32(a4, 0), (readu32(v2, 0)))
        local v8 = bxor(readu32(a4, 4), (readu32(v2, 4)))
        local v9 = bxor(readu32(a4, 8), (readu32(v2, 8)))
        local v10 = bxor(readu32(a4, 12), (readu32(v2, 12)))
        writeu32(a4, 0, v7)
        writeu32(a4, 4, v8)
        writeu32(a4, 8, v9)
        writeu32(a4, 12, v10)
        local v11 = 0
        local v12 = 4
        local v13 = 8
        local v14 = 12
        for i = 16, v1, 16 do
            v11 = v11 + 16
            v12 = v12 + 16
            v13 = v13 + 16
            v14 = v14 + 16
            readu32(a3, v11)
            readu32(a3, v12)
            readu32(a3, v13)
            readu32(a3, v14)
            a2(a3, i, a4, i)
            v7 = bxor(v3, v7, (readu32(a4, v11)))
            v8 = bxor(v4, v8, (readu32(a4, v12)))
            v9 = bxor(v5, v9, (readu32(a4, v13)))
            v10 = bxor(v6, v10, (readu32(a4, v14)))
            writeu32(a4, v11, v7)
            writeu32(a4, v12, v8)
            writeu32(a4, v13, v9)
            writeu32(a4, v14, v10)
        end
    end,
}
table.freeze(v1.PCBC)

local function cfbFwd(a1, a2, a3, a4, a5, a6) -- Line: 243
    -- upvalues: len (val), u15 (val), create (val), readu8 (val), bxor (val), writeu8 (val), copy (val)
    local v1, v2, v3, v4, v5
    local SegmentSize = a5.SegmentSize
    local v6 = len(a3)
    assert(v6 % SegmentSize == 0, "Input length must be a multiple of segment size")
    local v7 = a6 or u15
    assert(len(v7) == 16, "Initialization vector must be 16 bytes long")
    local CommonTemp = a5.CommonTemp or create(31)
    if v6 == SegmentSize then
        a1(v7, 0, CommonTemp, 0)
        v5 = SegmentSize - 1
        for m = 0, v5 do
            v2 = bxor(readu8(a3, m), (readu8(CommonTemp, m)))
            writeu8(a4, m, v2)
        end
        return
    end
    v5 = v6 - SegmentSize
    local v8 = 16 - SegmentSize
    a1(v7, 0, CommonTemp, 0)
    local v9 = SegmentSize - 1
    for i = 0, v9 do
        v3 = bxor(readu8(a3, i), (readu8(CommonTemp, i)))
        writeu8(a4, i, v3)
    end
    copy(CommonTemp, 0, v7, SegmentSize, v8)
    copy(CommonTemp, v8, a4, 0, SegmentSize)
    v9 = v5 - SegmentSize
    local v10, v11, v12 = a1, a3, a4
    for j = SegmentSize, v9, SegmentSize do
        v1 = 0
        copy(CommonTemp, 16, CommonTemp, SegmentSize, v8)
        v10(CommonTemp, 0, CommonTemp, 0)
        v2 = j + SegmentSize - 1
        for k = j, v2 do
            v4 = bxor(readu8(v11, k), (readu8(CommonTemp, v1)))
            writeu8(v12, k, v4)
            v1 = v1 + 1
        end
        copy(CommonTemp, 0, CommonTemp, 16, v8)
        copy(CommonTemp, v8, v12, j, SegmentSize)
    end
    v10(CommonTemp, 0, CommonTemp, 0)
    v1 = 0
    v9 = v6 - 1
    for n = v5, v9 do
        v3 = bxor(readu8(v11, n), (readu8(CommonTemp, v1)))
        writeu8(v12, n, v3)
        v1 = v1 + 1
    end
end

local function cfbInv(a1, a2, a3, a4, a5, a6) -- Line: 284
    -- upvalues: len (val), u15 (val), create (val), readu8 (val), bxor (val), writeu8 (val), copy (val)
    local v1, v2, v3, v4, v5
    local v6 = len(a3)
    local SegmentSize = a5.SegmentSize
    assert(v6 % SegmentSize == 0, "Input length must be a multiple of segment size")
    local v7 = a6 or u15
    assert(len(v7) == 16, "Initialization vector must be 16 bytes long")
    local CommonTemp = a5.CommonTemp or create(31)
    if v6 == SegmentSize then
        a1(v7, 0, CommonTemp, 0)
        v5 = SegmentSize - 1
        for m = 0, v5 do
            v2 = bxor(readu8(a3, m), (readu8(CommonTemp, m)))
            writeu8(a4, m, v2)
        end
        return
    end
    v5 = v6 - SegmentSize
    local v8 = 16 - SegmentSize
    a1(v7, 0, CommonTemp, 0)
    local v9 = SegmentSize - 1
    for i = 0, v9 do
        v3 = bxor(readu8(a3, i), (readu8(CommonTemp, i)))
        writeu8(a4, i, v3)
    end
    copy(CommonTemp, 0, v7, SegmentSize, v8)
    copy(CommonTemp, v8, a3, 0, SegmentSize)
    v9 = v5 - SegmentSize
    local v10, v11, v12 = a1, a3, a4
    for j = SegmentSize, v9, SegmentSize do
        v1 = 0
        copy(CommonTemp, 16, CommonTemp, SegmentSize, v8)
        v10(CommonTemp, 0, CommonTemp, 0)
        v2 = j + SegmentSize - 1
        for k = j, v2 do
            v4 = bxor(readu8(v11, k), (readu8(CommonTemp, v1)))
            writeu8(v12, k, v4)
            v1 = v1 + 1
        end
        copy(CommonTemp, 0, CommonTemp, 16, v8)
        copy(CommonTemp, v8, v11, j, SegmentSize)
    end
    v10(CommonTemp, 0, CommonTemp, 0)
    v1 = 0
    v9 = v6 - 1
    for n = v5, v9 do
        v3 = bxor(readu8(v11, n), (readu8(CommonTemp, v1)))
        writeu8(v12, n, v3)
        v1 = v1 + 1
    end
end

local function ofbMode(a1, a2, a3, a4, a5, a6) -- Line: 334
    -- upvalues: len (val), u15 (val), readu32 (val), bxor (val), writeu32 (val)
    local v1, v2, v3, v4
    local v5 = len(a3) - 16
    assert(v5 % 16 == 0, "Input length must be a multiple of 16 bytes")
    local v6 = a6 or u15
    assert(len(v6) == 16, "Initialization vector must be 16 bytes long")
    local v7 = readu32(a3, 0)
    local v8 = readu32(a3, 4)
    local v9 = readu32(a3, 8)
    local v10 = readu32(a3, 12)
    a1(v6, 0, a4, 0)
    v7 = bxor(v7, (readu32(a4, 0)))
    v8 = bxor(v8, (readu32(a4, 4)))
    v9 = bxor(v9, (readu32(a4, 8)))
    v10 = bxor(v10, (readu32(a4, 12)))
    for i = 16, v5, 16 do
        v1 = readu32(a3, i)
        v2 = readu32(a3, i + 4)
        v3 = readu32(a3, i + 8)
        v4 = readu32(a3, i + 12)
        a1(a4, i - 16, a4, i)
        writeu32(a4, i - 16, v7)
        writeu32(a4, i - 12, v8)
        writeu32(a4, i - 8, v9)
        writeu32(a4, i - 4, v10)
        v7 = bxor(v1, (readu32(a4, i)))
        v8 = bxor(v2, (readu32(a4, i + 4)))
        v9 = bxor(v3, (readu32(a4, i + 8)))
        v10 = bxor(v4, (readu32(a4, i + 12)))
    end
    writeu32(a4, v5, v7)
    writeu32(a4, v5 + 4, v8)
    writeu32(a4, v5 + 8, v9)
    writeu32(a4, v5 + 12, v10)
end

v1.OFB = {FwdMode = ofbMode, InvMode = ofbMode}
table.freeze(v1.OFB)

local function ctrMode(a1, a2, a3, a4, a5) -- Line: 391
    -- upvalues: len (val), writestring (val), readu32 (val), bxor (val), writeu32 (val), addByteCtr (val)
    local v1
    local v2 = len(a3) - 16
    assert(v2 % 16 == 0, "Input length must be a multiple of 16 bytes")
    local CommonTemp = a5.CommonTemp
    local InitValue = a5.InitValue
    local Prefix = a5.Prefix
    local Suffix = a5.Suffix
    local Step = a5.Step
    local LittleEndian = a5.LittleEndian
    local v3 = #Prefix
    local v4 = v3 + #InitValue - 1
    writestring(CommonTemp, 0, Prefix)
    writestring(CommonTemp, v3, InitValue)
    writestring(CommonTemp, v4 + 1, Suffix)
    local v5 = readu32(a3, 0)
    local v6 = readu32(a3, 4)
    local v7 = readu32(a3, 8)
    local v8 = readu32(a3, 12)
    a1(CommonTemp, 0, a4, 0)
    writeu32(a4, 0, (bxor(readu32(a4, 0), v5)))
    writeu32(a4, 4, (bxor(readu32(a4, 4), v6)))
    writeu32(a4, 8, (bxor(readu32(a4, 8), v7)))
    writeu32(a4, 12, (bxor(readu32(a4, 12), v8)))
    for i = 16, v2, 16 do
        v5 = readu32(a3, i)
        v6 = readu32(a3, i + 4)
        v7 = readu32(a3, i + 8)
        v8 = readu32(a3, i + 12)
        addByteCtr(CommonTemp, Step, v3, v4, LittleEndian)
        a1(CommonTemp, 0, a4, i)
        v1 = bxor(v5, (readu32(a4, i)))
        writeu32(a4, i, v1)
        writeu32(a4, i + 4, (bxor(v6, (readu32(a4, i + 4)))))
        writeu32(a4, i + 8, (bxor(v7, (readu32(a4, i + 8)))))
        writeu32(a4, i + 12, (bxor(v8, (readu32(a4, i + 12)))))
    end
end

local v2 = {
    __index = function(a1, a2) -- Line: 442
        -- upvalues: cfbFwd (val), cfbInv (val), create (val), ctrMode (val), pack (val), random (val)
        if a2 == "CFB" then
            return {SegmentSize = 16, FwdMode = cfbFwd, InvMode = cfbInv, CommonTemp = create(31)}
        end
        if a2 == "CTR" then
            return {
                Prefix = "",
                Suffix = "",
                Step = 1,
                LittleEndian = false,
                FwdMode = ctrMode,
                InvMode = ctrMode,
                InitValue = pack(
                    "I2I2I2I2I2I2I2I2",
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535),
                    random(0, 65535)
                ),
                CommonTemp = create(16),
            }
        end
        return nil
    end,
    __newindex = function() end,
}
setmetatable(v1, v2)
v1.CFB = {}
v1.CTR = {}
table.freeze(v1)
v2.__metatable = "This metatable is locked"
return v1