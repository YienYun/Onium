-- Script path: ReplicatedStorage.UserGenerated.Observability.Sequences
-- Decompile time: 6.33 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local ValueType = Observability.ValueType
local Op = Observability.Op
local u16 = {}
u16.Types = table.freeze({[ValueType.ColorSequence] = true, [ValueType.NumberSequence] = true})
local u26 = buffer.create(4)

local function f32(a1) -- Line: 40 -- upvalues: u26 (val) -- types: a1: number
    buffer.writef32(u26, 0, a1)
    return (buffer.readf32(u26, 0))
end

local function u8(a1) -- Line: 45 -- types: a1: number
    return (math.clamp(math.floor(a1 * 255 + 0.5), 0, 255))
end

function u16.keypoints(a1, a2) -- Line: 50 -- upvalues: ValueType (val), u26 (val) -- types: a1: number
    local Value, v1, v2, v3, v4, v5
    local v6 = {}
    if a1 ~= ValueType.ColorSequence then
        if typeof(a2) == "NumberSequence" then
            local v7, v8
            for i, j in a2.Keypoints do
                v8 = {}
                buffer.writef32(u26, 0, j.Time)
                v5 = buffer.readf32(u26, 0)
                buffer.writef32(u26, 0, j.Value)
                v1 = buffer.readf32(u26, 0)
                buffer.writef32(u26, 0, j.Envelope)
                v7 = u26
                v8[1] = v5
                v8[2] = v1
                v8[3] = (buffer.readf32(v7, 0))
                v6[i] = v8
            end
        end
        return v6
    end
    if typeof(a2) ~= "ColorSequence" then
        return v6
    end
    for k, n in a2.Keypoints do
        Value = n.Value
        v5 = {}
        buffer.writef32(u26, 0, n.Time)
        v1 = buffer.readf32(u26, 0)
        v2 = math.clamp(math.floor(Value.R * 255 + 0.5), 0, 255)
        v3 = math.clamp(math.floor(Value.G * 255 + 0.5), 0, 255)
        v4 = math.floor(Value.B * 255 + 0.5)
        v5[1] = v1
        v5[2] = v2
        v5[3] = v3
        v5[4] = (math.clamp(v4, 0, 255))
        v6[k] = v5
    end
    return v6
end

function u16.key(a1) -- Line: 68 -- types: a1: table
    local v1 = if not a1[1] then 0 else #a1[1]
    local v2 = buffer.create(#a1 * v1 * 4)
    v1 = 0
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        for k, n in j do
            buffer.writef32(v2, v1, n)
            v1 = v1 + 4
        end
    end
    return buffer.tostring(v2)
end

function u16.shift(a1, a2, a3, a4) -- Line: 83 -- types: a1: table, a2: number, a3: table, a4: table
    local v1, v2, v3
    local v4 = #a1
    local v5 = a2 / 65536
    local v6 = {}
    local v7 = {}
    local v8 = v4 - 1
    for i = 2, v8 do
        v1 = a1[i]
        v2 = table.clone(v1)
        v3 = v1[1] + v5
        if not (v3 >= 1) then
            v2[1] = v3
            table.insert(v7, v2)
        else
            v2[1] = v3 - 1
            table.insert(v6, v2)
        end
    end
    v5 = table.clone(a3)
    v5[1] = a1[1][1]
    v8 = table.clone(a4)
    v8[1] = a1[v4][1]
    v4 = {v5}
    table.move(v6, 1, #v6, 2, v4)
    table.move(v7, 1, #v7, #v4 + 1, v4)
    table.insert(v4, v8)
    return v4
end

local function near(a1, a2, a3) -- Line: 110 -- upvalues: ValueType (val) -- types: a1: table, a2: table, a3: number
    local v1, v2
    if #a1 ~= #a2 then
        return false
    end
    local v3 = a3 == ValueType.ColorSequence
    local v4 = nil
    local v5 = nil
    for i, j in a1, v4, v5 do
        v2 = a2[i]
        if (math.abs(j[1] - v2[1])) > 0.0005 then
            return false
        end
        v1 = #j
        for k = 2, v1 do
            if if not v3 then 0.0001 < (math.abs(j[k] - v2[k])) else j[k] ~= v2[k] then
                return false
            end
        end
    end
    return true
end

function u16.findShift(a1, a2, a3) -- Line: 131
    -- upvalues: u16 (val), near (val)
    local v1 = #a2
    if not (v1 < 3) and #a1 == v1 then
        local v2, v3
        local v4 = a2[2][1]
        local v5 = v1 - 1
        for i = 2, v5 do
            v2 = math.round((v4 - a1[i][1]) % 1 * 65536) % 65536
            v3 = u16.shift(a1, v2, a2[1], a2[v1])
            if near(v3, a2, a3) then
                return v2, v3
            end
        end
        return nil, nil
    end
    return nil, nil
end

local function writeHeader(a1, a2, a3, a4, a5) -- Line: 147
    -- upvalues: Codec (val)
    a1:u8(a2)
    Codec.varuint(a1, a3)
    Codec.varuint(a1, a4)
    a1:u8(a5)
end

local function writeEnd(a1, a2, a3) -- Line: 154 -- upvalues: ValueType (val) -- types: a2: number, a3: table
    if a2 ~= ValueType.ColorSequence then
        a1:f32(a3[2])
        a1:f32(a3[3])
        return
    end
    a1:u8(a3[2])
    a1:u8(a3[3])
    a1:u8(a3[4])
end

function u16.writeCopy(a1, a2, a3, a4, a5) -- Line: 165
    -- upvalues: Op (val), Codec (val)
    a1:u8(Op.SeqCopy)
    Codec.varuint(a1, a2)
    Codec.varuint(a1, a3)
    a1:u8(a4)
    Codec.varuint(a1, a5)
end

function u16.writeShift(a1, a2, a3, a4, a5, a6, a7) -- Line: 170
    -- upvalues: Op (val), Codec (val), writeEnd (val)
    a1:u8(Op.SeqShift)
    Codec.varuint(a1, a2)
    Codec.varuint(a1, a3)
    a1:u8(a4)
    a1:u16(a6)
    writeEnd(a1, a5, a7[1])
    writeEnd(a1, a5, a7[#a7])
end

return table.freeze(u16)