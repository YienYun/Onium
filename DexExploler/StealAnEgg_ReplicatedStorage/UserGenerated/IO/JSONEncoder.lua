-- Script path: ReplicatedStorage.UserGenerated.IO.JSONEncoder
-- Decompile time: 19.99 ms

local u0 = {
    [0] = -12336,
    -12592,
    -12848,
    -13104,
    -13360,
    -13616,
    -13872,
    -14128,
    25180,
    29788,
    28252,
    -25136,
    26204,
    29276,
    -25904,
    -26160,
    -12337,
    -12593,
    -12849,
    -13105,
    -13361,
    -13617,
    -13873,
    -14129,
    -14385,
    -14641,
    -24881,
    -25137,
    -25393,
    -25649,
    -25905,
    -26161,
}
local u34 = {[36] = true, [95] = true}
local u37 = {[36] = true, [95] = true}
for i = 65, 90 do
    u34[i] = true
    u37[i] = true
end
for j = 97, 122 do
    u34[j] = true
    u37[j] = true
end
u37[48] = true
u37[49] = true
u37[50] = true
u37[51] = true
u37[52] = true
u37[53] = true
u37[54] = true
u37[55] = true
u37[56] = true
u37[57] = true

local function Stream(a1) -- Line: 91 -- types: a1: buffer
    return {
        Pos = 0,
        Indent = 0,
        Pretty = false,
        QuoteChar = 34,
        UnquoteIdent = false,
        Buf = a1,
        Cap = buffer.len(a1),
        Encoders = {},
    }
end

local function ToString(a1) -- Line: 105 -- types: a1: table
    return buffer.readstring(a1.Buf, 0, a1.Pos)
end

local function AllocSize(a1) -- Line: 109 -- types: a1: number
    return (math.max(a1, 2 ^ (math.ceil((math.log(a1, 2))))))
end

local function Reserve(a1, a2) -- Line: 113 -- types: a1: table, a2: number
    local Pos = a1.Pos
    local v1 = Pos + a2
    if a1.Cap < v1 then
        local v2 = math.max(v1, 2 ^ (math.ceil((math.log(v1, 2)))))
        local v3 = buffer.create(v2)
        buffer.copy(v3, 0, a1.Buf, 0, Pos)
        a1.Buf = v3
        a1.Cap = v2
    end
    a1.Pos = v1
    return Pos
end

local function WriteString(a1, a2) -- Line: 126 -- upvalues: Reserve (val) -- types: a1: table, a2: string
    local v1 = string.len(a2)
    local v2 = Reserve(a1, v1)
    buffer.writestring(a1.Buf, v2, a2, v1)
end

local function WriteIndent(a1) -- Line: 132 -- upvalues: Reserve (val) -- types: a1: table
    local v1
    local v2 = a1.Indent * 2
    local v3 = Reserve(a1, v2)
    local Buf = a1.Buf
    local v4 = v2 - 1
    for i = 0, v4 do
        v1 = v3 + i * 2
        buffer.writeu16(Buf, v1, 8224)
    end
end

local function IncrementIndent(a1, a2) -- Line: 141 -- types: a1: table, a2: number
    a1.Indent = a1.Indent + a2
end

local function WriteU8(a1, a2) -- Line: 145 -- upvalues: Reserve (val) -- types: a1: table, a2: number
    local v1 = Reserve(a1, 1)
    local Buf = a1.Buf
    buffer.writeu8(Buf, v1, a2)
end

local function WriteU16(a1, a2) -- Line: 150 -- upvalues: Reserve (val) -- types: a1: table, a2: number
    local v1 = Reserve(a1, 2)
    local Buf = a1.Buf
    buffer.writeu16(Buf, v1, a2)
end

local function WriteU32(a1, a2) -- Line: 155 -- upvalues: Reserve (val) -- types: a1: table, a2: number
    local v1 = Reserve(a1, 4)
    local Buf = a1.Buf
    buffer.writeu32(Buf, v1, a2)
end

local function EncodeNumber(a1, a2) -- Line: 175 -- upvalues: Reserve (val) -- types: a1: table, a2: number
    local v1, v2
    if a2 ~= a2 then
        v1 = Reserve(a1, 3)
        local Buf = a1.Buf
        buffer.writeu16(Buf, v1, 24910)
        v2 = v1 + 2
        buffer.writeu8(Buf, v2, 78)
        return
    end
    if a2 == (1 / 0) then
        v1 = Reserve(a1, 8)
        local Buf_2 = a1.Buf
        buffer.writeu32(Buf_2, v1, 1768320585)
        v2 = v1 + 4
        buffer.writeu32(Buf_2, v2, 2037672302)
        return
    end
    if a2 == (-1 / 0) then
        v1 = Reserve(a1, 9)
        local Buf_3 = a1.Buf
        buffer.writeu8(Buf_3, v1, 45)
        v2 = v1 + 1
        buffer.writeu32(Buf_3, v2, 1768320585)
        v2 = v1 + 5
        buffer.writeu32(Buf_3, v2, 2037672302)
        return
    end
    v1 = tostring(a2)
    local v3 = string.find(v1, "e%+")
    if v3 then
        v1 = (string.sub(v1, 1, v3)) .. string.sub(v1, v3 + 2)
    end
    v3 = string.len(v1)
    local v4 = Reserve(a1, v3)
    buffer.writestring(a1.Buf, v4, v1, v3)
end

local function IsIdentifierName(a1, a2) -- Line: 202 -- upvalues: u34 (val), u37 (val) -- types: a1: table, a2: string
    local v1 = string.len(a2)
    if v1 == 0 or not u34[(string.byte(a2, 1))] then
        return false
    end
    for i = 2, v1 do
        if not u37[string.byte(a2, i)] then
            return false
        end
    end
    return true
end

local function EncodeString(a1, a2, a3) -- Line: 220
    -- upvalues: u34 (val), u37 (val), Reserve (val), u0 (val)
    local Buf, QuoteChar, v1, v2, v3, v4, v5
    if a3 then
        v5 = string.len(a2)
        if v5 == 0 then
            v4 = false
        elseif u34[(string.byte(a2, 1))] then
            for i = 2, v5 do
                if not u37[string.byte(a2, i)] then
                    if true then
                        a3 = false
                    end
                    v4 = string.len(a2)
                    v5 = Reserve(a1, v4 * 6 + 2)
                    Buf = a1.Buf
                    QuoteChar = a1.QuoteChar
                    if not a3 then
                        buffer.writeu8(Buf, v5, QuoteChar)
                        v5 = v5 + 1
                    end
                    for j = 1, v4 do
                        v1 = string.byte(a2, j)
                        if not (v1 > 31) then
                            v2 = u0[v1]
                            if v2 < 0 then
                                v2 = -v2
                                buffer.writeu32(Buf, v5, 808482140)
                                v5 = v5 + 4
                            end
                            buffer.writeu16(Buf, v5, v2)
                            v5 = v5 + 2
                        elseif v1 == QuoteChar or v1 == 92 then
                            v3 = (bit32.lshift(v1, 8)) + 92
                            buffer.writeu16(Buf, v5, v3)
                            v5 = v5 + 2
                        else
                            buffer.writeu8(Buf, v5, v1)
                            v5 = v5 + 1
                        end
                    end
                    if not a3 then
                        buffer.writeu8(Buf, v5, QuoteChar)
                        v5 = v5 + 1
                    end
                    a1.Pos = v5
                    return
                end
            end
            v4 = true
        else
            v4 = false
        end
        if not v4 then
            a3 = false
        end
    end
    v4 = string.len(a2)
    v5 = Reserve(a1, v4 * 6 + 2)
    Buf = a1.Buf
    QuoteChar = a1.QuoteChar
    if not a3 then
        buffer.writeu8(Buf, v5, QuoteChar)
        v5 = v5 + 1
    end
    for k = 1, v4 do
        v1 = string.byte(a2, k)
        if not (v1 > 31) then
            v2 = u0[v1]
            if v2 < 0 then
                v2 = -v2
                buffer.writeu32(Buf, v5, 808482140)
                v5 = v5 + 4
            end
            buffer.writeu16(Buf, v5, v2)
            v5 = v5 + 2
        elseif v1 == QuoteChar or v1 == 92 then
            v3 = (bit32.lshift(v1, 8)) + 92
            buffer.writeu16(Buf, v5, v3)
            v5 = v5 + 2
        else
            buffer.writeu8(Buf, v5, v1)
            v5 = v5 + 1
        end
    end
    if not a3 then
        buffer.writeu8(Buf, v5, QuoteChar)
        v5 = v5 + 1
    end
    a1.Pos = v5
end

local function EncodeAny(a1, a2) -- Line: 304 -- types: a1: table
    if a2 == a1.Null then
        a2 = nil
    end
    a1.Encoders[typeof(a2)](a1, a2)
end

local function EncodeArray(a1, a2) -- Line: 311 -- upvalues: Reserve (val) -- types: a1: table, a2: table
    local Buf_5, Buf_6, Buf_7, v1, v2, v3, v4
    local Pretty = a1.Pretty
    local v5 = Reserve(a1, 1)
    local Buf = a1.Buf
    buffer.writeu8(Buf, v5, 91)
    if Pretty then
        a1.Indent = a1.Indent + 1
    end
    local v6, v7 = a1, a2
    for i, v in ipairs(a2) do
        if i > 1 then
            v3 = Reserve(v6, 1)
            Buf_5 = v6.Buf
            buffer.writeu8(Buf_5, v3, 44)
        end
        if Pretty then
            v3 = Reserve(v6, 1)
            Buf_6 = v6.Buf
            buffer.writeu8(Buf_6, v3, 10)
            v3 = v6.Indent * 2
            v4 = Reserve(v6, v3)
            Buf_7 = v6.Buf
            v1 = v3 - 1
            for i2 = 0, v1 do
                v2 = v4 + i2 * 2
                buffer.writeu16(Buf_7, v2, 8224)
            end
        end
        v3 = v
        if v3 == v6.Null then
            v3 = nil
        end
        v6.Encoders[typeof(v3)](v6, v3)
    end
    if Pretty then
        v6.Indent = v6.Indent + -1
        if #v7 > 0 then
            v5 = Reserve(v6, 1)
            local Buf_2 = v6.Buf
            buffer.writeu8(Buf_2, v5, 10)
            v5 = v6.Indent * 2
            local v8 = Reserve(v6, v5)
            local Buf_3 = v6.Buf
            local v9 = v5 - 1
            for j = 0, v9 do
                v1 = v8 + j * 2
                buffer.writeu16(Buf_3, v1, 8224)
            end
        end
    end
    local v10 = Reserve(v6, 1)
    local Buf_4 = v6.Buf
    buffer.writeu8(Buf_4, v10, 93)
end

local function EncodeMap(a1, a2) -- Line: 338
    -- upvalues: Reserve (val), EncodeString (val)
    local Buf_5, Buf_6, Buf_7, Buf_8, Buf_9, v1, v2, v3, v4
    local v5 = {}
    local v6 = a1
    for k, v in pairs(a2) do
        assert(type(k) == "string")
        table.insert(v5, k)
    end
    table.sort(v5)
    local Pretty = v6.Pretty
    local UnquoteIdent = v6.UnquoteIdent
    local v7 = Reserve(v6, 1)
    local Buf = v6.Buf
    buffer.writeu8(Buf, v7, 123)
    if Pretty then
        v6.Indent = v6.Indent + 1
    end
    for i, i2 in ipairs(v5) do
        if i > 1 then
            v1 = Reserve(v6, 1)
            Buf_5 = v6.Buf
            buffer.writeu8(Buf_5, v1, 44)
        end
        if Pretty then
            v1 = Reserve(v6, 1)
            Buf_6 = v6.Buf
            buffer.writeu8(Buf_6, v1, 10)
            v1 = v6.Indent * 2
            v2 = Reserve(v6, v1)
            Buf_7 = v6.Buf
            v3 = v1 - 1
            for j = 0, v3 do
                v4 = v2 + j * 2
                buffer.writeu16(Buf_7, v4, 8224)
            end
        end
        EncodeString(v6, i2, UnquoteIdent)
        if not Pretty then
            v1 = Reserve(v6, 1)
            Buf_9 = v6.Buf
            buffer.writeu8(Buf_9, v1, 58)
        else
            v1 = Reserve(v6, 2)
            Buf_8 = v6.Buf
            buffer.writeu16(Buf_8, v1, 8250)
        end
        v1 = v8[i2]
        if v1 == v6.Null then
            v1 = nil
        end
        v6.Encoders[typeof(v1)](v6, v1)
    end
    if Pretty then
        v6.Indent = v6.Indent + -1
        if #v5 > 0 then
            local v9 = Reserve(v6, 1)
            local Buf_2 = v6.Buf
            buffer.writeu8(Buf_2, v9, 10)
            v7 = v6.Indent * 2
            local v10 = Reserve(v6, v7)
            local Buf_3 = v6.Buf
            local v11 = v7 - 1
            for k2 = 0, v11 do
                v3 = v10 + k2 * 2
                buffer.writeu16(Buf_3, v3, 8224)
            end
        end
    end
    v7 = Reserve(v6, 1)
    local Buf_4 = v6.Buf
    buffer.writeu8(Buf_4, v7, 125)
end

local v1 = {
    ["nil"] = function(a1, a2) -- Line: 160 -- upvalues: Reserve (val) -- types: a1: table, a2: nil
        local v1 = Reserve(a1, 4)
        local Buf = a1.Buf
        buffer.writeu32(Buf, v1, 1819047278)
    end,
    boolean = function(a1, a2) -- Line: 164 -- upvalues: Reserve (val) -- types: a1: table, a2: boolean
        local v1
        if a2 then
            v1 = Reserve(a1, 4)
            local Buf = a1.Buf
            buffer.writeu32(Buf, v1, 1702195828)
            return
        end
        v1 = Reserve(a1, 5)
        local Buf_2 = a1.Buf
        buffer.writeu32(Buf_2, v1, 1936482662)
        local v2 = v1 + 4
        buffer.writeu8(Buf_2, v2, 101)
    end,
    number = EncodeNumber,
    string = EncodeString,
    buffer = function(a1, a2) -- Line: 266 -- upvalues: Reserve (val), u0 (val) -- types: a1: table, a2: buffer
        local v1, v2, v3
        local v4 = buffer.len(a2)
        local v5 = Reserve(a1, 2 + v4 * 6)
        local Buf = a1.Buf
        local QuoteChar = a1.QuoteChar
        buffer.writeu8(Buf, v5, QuoteChar)
        v5 = v5 + 1
        local v6 = v4 - 1
        for i = 0, v6 do
            v3 = buffer.readu8(a2, i)
            if not (v3 > 31) then
                v1 = u0[v3]
                if v1 < 0 then
                    v1 = -v1
                    buffer.writeu32(Buf, v5, 808482140)
                    v5 = v5 + 4
                end
                buffer.writeu16(Buf, v5, v1)
                v5 = v5 + 2
            elseif v3 == QuoteChar or v3 == 92 then
                v2 = (bit32.lshift(v3, 8)) + 92
                buffer.writeu16(Buf, v5, v2)
                v5 = v5 + 2
            else
                buffer.writeu8(Buf, v5, v3)
                v5 = v5 + 1
            end
        end
        buffer.writeu8(Buf, v5, QuoteChar)
        a1.Pos = v5 + 1
    end,
    table = function(a1, a2) -- Line: 377 -- upvalues: EncodeArray (val), EncodeMap (val) -- types: a1: table
        if not (#a2 > 0) and next(a2) ~= nil then
            EncodeMap(a1, a2)
            return
        end
        EncodeArray(a1, a2)
    end,
}
local v2 = table.clone(v1)

function v2.Vector2(a1, a2) -- Line: 386 -- upvalues: EncodeArray (val) -- types: a1: table, a2: userdata
    EncodeArray(a1, {a2.X, a2.Y})
end

function v2.Vector3(a1, a2) -- Line: 390 -- upvalues: EncodeArray (val) -- types: a1: table, a2: vector
    EncodeArray(a1, {a2.X, a2.Y, a2.Z})
end

function v2.Vector2int16(a1, a2) -- Line: 394 -- upvalues: EncodeArray (val) -- types: a1: table, a2: userdata
    EncodeArray(a1, {a2.X, a2.Y})
end

function v2.Vector3int16(a1, a2) -- Line: 398 -- upvalues: EncodeArray (val) -- types: a1: table, a2: userdata
    EncodeArray(a1, {a2.X, a2.Y, a2.Z})
end

function v2.Region3(a1, a2) -- Line: 402 -- upvalues: EncodeArray (val) -- types: a1: table, a2: userdata
    local v1 = a2.CFrame * (a2.Size * -0.5)
    local v2 = a2.CFrame * (a2.Size * 0.5)
    EncodeArray(a1, {v1.X, v1.Y, v1.Z, v2.X, v2.Y, v2.Z})
end

function v2.Region3int16(a1, a2) -- Line: 408 -- upvalues: EncodeArray (val) -- types: a1: table, a2: userdata
    EncodeArray(a1, {
        a2.Min.X,
        a2.Min.Y,
        a2.Min.Z,
        a2.Max.X,
        a2.Max.Y,
        a2.Max.Z,
    })
end

function v2.UDim(a1, a2) -- Line: 412 -- upvalues: EncodeArray (val) -- types: a1: table, a2: UDim2
    EncodeArray(a1, {a2.Scale, a2.Offset})
end

function v2.UDim2(a1, a2) -- Line: 416 -- upvalues: EncodeArray (val) -- types: a1: table, a2: CFrame
    EncodeArray(a1, {a2.X.Scale, a2.X.Offset, a2.Y.Scale, a2.Y.Offset})
end

function v2.CFrame(a1, a2) -- Line: 420 -- upvalues: EncodeArray (val) -- types: a1: table, a2: Vector2
    EncodeArray(a1, {a2:GetComponents()})
end

function v2.Color3(a1, a2) -- Line: 424 -- upvalues: EncodeArray (val) -- types: a1: table, a2: Rect
    EncodeArray(a1, {
        math.round(a2.R * 255),
        math.round(a2.G * 255),
        (math.round(a2.B * 255)),
    })
end

function v2.NumberRange(a1, a2) -- Line: 432 -- upvalues: EncodeArray (val) -- types: a1: table, a2: Color3
    EncodeArray(a1, {a2.Min, a2.Max})
end

function v2.Rect(a1, a2) -- Line: 436 -- upvalues: EncodeArray (val) -- types: a1: table, a2: UDim
    EncodeArray(a1, {a2.Min.X, a2.Min.Y, a2.Max.X, a2.Max.Y})
end

function v2.EnumItem(a1, a2) -- Line: 440 -- upvalues: EncodeNumber (val) -- types: a1: table, a2: userdata
    EncodeNumber(a1, a2.Value)
end

local v3 = buffer.create(4096)
local u131 = Stream(v3)
u131.Encoders = v1
local u136 = Stream(v3)
u136.Encoders = v1
u136.Pretty = true
local u142 = Stream(v3)
u142.Encoders = v2
local u147 = Stream(v3)
u147.Encoders = v2
u147.Pretty = true
local u153 = Stream(v3)
u153.Encoders = v1
u153.UnquoteIdent = true
u153.QuoteChar = 39
local u160 = Stream(v3)
u160.Encoders = v1
u160.Pretty = true
u160.UnquoteIdent = true
u160.QuoteChar = 39
return table.freeze({
    Compact = function(a1, a2) -- Line: 473 -- upvalues: u131 (val), ToString (val)
        local v1 = u131
        v1.Pos = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
    Pretty = function(a1, a2) -- Line: 484 -- upvalues: u136 (val), ToString (val)
        local v1 = u136
        v1.Pos = 0
        v1.Indent = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
    CompactExt = function(a1, a2) -- Line: 495 -- upvalues: u142 (val), ToString (val)
        local v1 = u142
        v1.Pos = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
    PrettyExt = function(a1, a2) -- Line: 506 -- upvalues: u147 (val), ToString (val)
        local v1 = u147
        v1.Pos = 0
        v1.Indent = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
    Compact5 = function(a1, a2) -- Line: 520 -- upvalues: u153 (val), ToString (val)
        local v1 = u153
        v1.Pos = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
    Pretty5 = function(a1, a2) -- Line: 533 -- upvalues: u160 (val), ToString (val)
        local v1 = u160
        v1.Pos = 0
        v1.Indent = 0
        v1.Null = a2
        local v2 = a1
        if v2 == v1.Null then
            v2 = nil
        end
        v1.Encoders[typeof(v2)](v1, v2)
        return ToString(v1)
    end,
})