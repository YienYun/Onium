-- Script path: ReplicatedStorage.UserGenerated.Observability.Codec
-- Decompile time: 21.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Encode = require(ReplicatedStorage.UserGenerated.DataModel.Encode)
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local ValueType = Observability.ValueType
local MaxStringBytes = Observability.MaxStringBytes
local u16 = {newWriter = Encode.newWriter}

function u16.varuint(a1, a2) -- Line: 26 -- types: a2: number
    local v1 = math.max(0, (math.floor(a2)))
    while v1 >= 128 do
        a1:u8((bit32.bor(v1 % 128, 128)))
        v1 = v1 // 128
    end
    a1:u8(v1)
end

function u16.i16(a1, a2) -- Line: 35 -- types: a2: number
    a1:_ensure(2)
    local buf = a1.buf
    local len = a1.len
    local v1 = math.clamp(math.round(a2), -32768, 32767)
    buffer.writei16(buf, len, v1)
    a1.len = a1.len + 2
end

function u16.i32(a1, a2) -- Line: 41 -- types: a2: number
    a1:_ensure(4)
    if a2 ~= a2 then
        a2 = 0
    end
    local buf = a1.buf
    local len = a1.len
    local v1 = math.clamp(math.round(a2), -2147483648, 2147483647)
    buffer.writei32(buf, len, v1)
    a1.len = a1.len + 4
end

function u16.str(a1, a2) -- Line: 50 -- upvalues: MaxStringBytes (val), u16 (val) -- types: a2: string
    local v1 = #a2
    if MaxStringBytes < v1 then
        v1 = MaxStringBytes
        while v1 > 0 do
            if bit32.band(string.byte(a2, v1 + 1), 192) ~= 128 then
                break
            end
            v1 = v1 - 1
        end
        a2 = string.sub(a2, 1, v1)
    end
    u16.varuint(a1, v1)
    if v1 > 0 then
        a1:_ensure(v1)
        buffer.writestring(a1.buf, a1.len, a2)
        a1.len = a1.len + v1
    end
end

local function color(a1, a2) -- Line: 68 -- types: a2: Rect
    a1:u8((math.clamp(math.floor(a2.R * 255 + 0.5), 0, 255)))
    a1:u8((math.clamp(math.floor(a2.G * 255 + 0.5), 0, 255)))
    a1:u8((math.clamp(math.floor(a2.B * 255 + 0.5), 0, 255)))
end

local function udim(a1, a2) -- Line: 74 -- upvalues: u16 (val) -- types: a2: UDim2
    a1:f32(a2.Scale)
    u16.i32(a1, a2.Offset)
end

function u16.udim2Mask(a1, a2) -- Line: 81 -- types: a1: CFrame, a2: CFrame
    local X = a1.X
    local Y = a1.Y
    local X_2 = a2.X
    local Y_2 = a2.Y
    local v1 = (if X.Scale == X_2.Scale then 0 else 1) + (if X.Offset == X_2.Offset then 0 else 2)
    local v2 = v1 + (if Y.Scale == Y_2.Scale then 0 else 4)
    return v2 + (if Y.Offset == Y_2.Offset then 0 else 8)
end

function u16.udim2Part(a1, a2, a3) -- Line: 90 -- upvalues: u16 (val) -- types: a2: number, a3: CFrame
    a1:u8(a2)
    if bit32.btest(a2, 1) then
        a1:f32(a3.X.Scale)
    end
    if bit32.btest(a2, 2) then
        u16.i32(a1, a3.X.Offset)
    end
    if bit32.btest(a2, 4) then
        a1:f32(a3.Y.Scale)
    end
    if bit32.btest(a2, 8) then
        u16.i32(a1, a3.Y.Offset)
    end
end

local function finite(a1) -- Line: 106 -- types: a1: number
    if a1 == a1 and a1 > (-1 / 0) and a1 < (1 / 0) then
        return a1
    end
    return 0
end

local function quantize(a1) -- Line: 112 -- types: a1: number
    return (math.clamp(math.round(a1), -32768, 32767))
end

local function quantizeRotation(a1) -- Line: 118 -- types: a1: Vector2
    local Components, Components_12, Components_2, Components_3, Components_4, Components_5, Components_6, Components_7, Components_8, v1, v2, v3, v4, v5
    _, _, _, Components, Components_2, Components_3, Components_4, Components_5, Components_6, Components_7, Components_8, Components_12 = a1:GetComponents()
    if Components == 1 and Components_5 == 1 and Components_12 == 1 then
        return 4, 0, 0, 0
    end
    local v6 = Components + Components_5 + Components_12
    if v6 > 0 then
        local v7 = math.sqrt(1 + v6) * 2
        v4 = v7 * 0.25
        v1 = (Components_8 - Components_6) / v7
        v2 = (Components_3 - Components_7) / v7
        v3 = (Components_4 - Components_2) / v7
    elseif not (Components_5 < Components) then
        if not (Components_12 < Components_5) then
            v5 = math.sqrt(1 + Components_12 - Components - Components_5) * 2
            v4 = (Components_4 - Components_2) / v5
            v1 = (Components_3 + Components_7) / v5
            v2 = (Components_6 + Components_8) / v5
            v3 = v5 * 0.25
        else
            v5 = math.sqrt(1 + Components_5 - Components - Components_12) * 2
            v4 = (Components_3 - Components_7) / v5
            v1 = (Components_2 + Components_4) / v5
            v2 = v5 * 0.25
            v3 = (Components_6 + Components_8) / v5
        end
    elseif Components_12 < Components then
        local v8 = math.sqrt(1 + Components - Components_5 - Components_12) * 2
        v4 = (Components_8 - Components_6) / v8
        v1 = v8 * 0.25
        v2 = (Components_2 + Components_4) / v8
        v3 = (Components_3 + Components_7) / v8
    elseif not (Components_12 < Components_5) then
        v5 = math.sqrt(1 + Components_12 - Components - Components_5) * 2
        v4 = (Components_4 - Components_2) / v5
        v1 = (Components_3 + Components_7) / v5
        v2 = (Components_6 + Components_8) / v5
        v3 = v5 * 0.25
    else
        v5 = math.sqrt(1 + Components_5 - Components - Components_12) * 2
        v4 = (Components_3 - Components_7) / v5
        v1 = (Components_2 + Components_4) / v5
        v2 = v5 * 0.25
        v3 = (Components_6 + Components_8) / v5
    end
    local v9 = {
        if v1 ~= v1 then 0 else if not (v1 > (-1 / 0)) then 0 else if not (v1 < (1 / 0)) then 0 else v1,
        if v2 ~= v2 then 0 else if not (v2 > (-1 / 0)) then 0 else if not (v2 < (1 / 0)) then 0 else v2,
        if v3 ~= v3 then 0 else if not (v3 > (-1 / 0)) then 0 else if not (v3 < (1 / 0)) then 0 else v3,
        if v4 ~= v4 then 0 else if not (v4 > (-1 / 0)) then 0 else if not (v4 < (1 / 0)) then 0 else v4,
    }
    v4 = math.sqrt(v9[1] * v9[1] + v9[2] * v9[2] + v9[3] * v9[3] + v9[4] * v9[4])
    if v4 < 1e-06 then
        return 4, 0, 0, 0
    end
    v3 = 1
    v5 = math.abs(v9[2])
    if math.abs(v9[v3]) < v5 then
        v3 = 2
    end
    v5 = math.abs(v9[3])
    if math.abs(v9[v3]) < v5 then
        v3 = 3
    end
    v5 = math.abs(v9[4])
    if math.abs(v9[v3]) < v5 then
        v3 = 4
    end
    v2 = (if not (v9[v3] < 0) then 46339.53579827921 else -46339.53579827921) / v4
    v5 = 0
    local v10 = 0
    local v11 = 0
    local v12 = 0
    for i = 1, 4 do
        if i ~= v3 then
            v12 = v12 + 1
            v4 = math.clamp(math.round(v9[i] * v2), -32768, 32767)
            if v12 == 1 then
                v5 = v4
            elseif v12 ~= 2 then
                v11 = v4
            else
                v10 = v4
            end
        end
    end
    return v3 - 1, v5, v10, v11
end

u16.quantizeRotation = quantizeRotation

function u16.position(a1, a2) -- Line: 169 -- types: a2: Vector2
    local Position = a2.Position
    local X = Position.X
    a1:f32(if X ~= X then 0 else if not (X > (-1 / 0)) then 0 else if not (X < (1 / 0)) then 0 else X)
    local Y = Position.Y
    a1:f32(if Y ~= Y then 0 else if not (Y > (-1 / 0)) then 0 else if not (Y < (1 / 0)) then 0 else Y)
    local Z = Position.Z
    a1:f32(if Z ~= Z then 0 else if not (Z > (-1 / 0)) then 0 else if not (Z < (1 / 0)) then 0 else Z)
end

function u16.rotation(a1, a2, a3, a4, a5) -- Line: 178
    -- upvalues: u16 (val)
    a1:u8(a2)
    if a2 ~= 4 then
        u16.i16(a1, a3)
        u16.i16(a1, a4)
        u16.i16(a1, a5)
    end
end

function u16.cframe(a1, a2) -- Line: 188 -- upvalues: quantizeRotation (val), u16 (val) -- types: a2: Vector2
    local Position = a2.Position
    local X = Position.X
    a1:f32(if X ~= X then 0 else if not (X > (-1 / 0)) then 0 else if not (X < (1 / 0)) then 0 else X)
    local Y = Position.Y
    a1:f32(if Y ~= Y then 0 else if not (Y > (-1 / 0)) then 0 else if not (Y < (1 / 0)) then 0 else Y)
    local Z = Position.Z
    a1:f32(if Z ~= Z then 0 else if not (Z > (-1 / 0)) then 0 else if not (Z < (1 / 0)) then 0 else Z)
    local v1, v2, v3, v4 = quantizeRotation(a2)
    a1:u8(v1)
    if v1 ~= 4 then
        u16.i16(a1, v2)
        u16.i16(a1, v3)
        u16.i16(a1, v4)
    end
end

function u16.zigzag(a1, a2) -- Line: 194 -- upvalues: u16 (val) -- types: a2: number
    u16.varuint(a1, if not (a2 >= 0) then -a2 * 2 - 1 else a2 * 2)
end

u16.MaxPositionSteps = 2147483648
local u36 = buffer.create(4)

function u16.stepPosition(a1, a2) -- Line: 207 -- upvalues: u36 (val) -- types: a1: number, a2: number
    local v1 = u36
    local v2 = a1 + a2 / 1024
    buffer.writef32(v1, 0, v2)
    return (buffer.readf32(u36, 0))
end

function u16.positionSteps(a1, a2) -- Line: 213 -- types: a1: number, a2: number
    return (math.round((a2 - a1) * 1024))
end

function u16.cframeDelta(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) -- Line: 220
    -- upvalues: u16 (val)
    local v1 = 0
    if a2 ~= 0 or a3 ~= 0 or a4 ~= 0 then
        v1 = 1
    end
    local v2 = false
    if a5 == a9 then
        v2 = false
        if a6 == a10 then
            v2 = false
            if a7 == a11 then
                v2 = a8 == a12
            end
        end
    end
    if not v2 then
        v1 = if a5 ~= a9 or a9 == 4 or not ((math.abs(a10 - a6)) <= 8191) or not ((math.abs(a11 - a7)) <= 8191) then v1 + 2 else if not ((math.abs(a12 - a8)) <= 8191) then v1 + 2 else v1 + 4
    end
    a1:u8(v1)
    if v1 % 2 == 1 then
        u16.zigzag(a1, a2)
        u16.zigzag(a1, a3)
        u16.zigzag(a1, a4)
    end
    if bit32.btest(v1, 4) then
        u16.zigzag(a1, a10 - a6)
        u16.zigzag(a1, a11 - a7)
        u16.zigzag(a1, a12 - a8)
        return
    end
    if bit32.btest(v1, 2) then
        a1:u8(a9)
        if a9 ~= 4 then
            u16.i16(a1, a10)
            u16.i16(a1, a11)
            u16.i16(a1, a12)
        end
    end
end

local function u40() -- Line: 269
    return nil
end

function u16.setRefLookup(a1) -- Line: 273 -- upvalues: u40 (ref) -- types: a1: function
    u40 = a1
end

local u42 = {}

u42[ValueType.Bool] = function(a1, a2) -- Line: 278
    a1:u8(if a2 ~= true then 0 else 1)
end

u42[ValueType.Int32] = function(a1, a2) -- Line: 281 -- upvalues: u16 (val)
    u16.i32(a1, if type(a2) ~= "number" then 0 else a2)
end

u42[ValueType.Float32] = function(a1, a2) -- Line: 284
    a1:f32(if type(a2) ~= "number" then 0 else a2)
end

u42[ValueType.Float64] = function(a1, a2) -- Line: 287
    a1:f64(if type(a2) ~= "number" then 0 else a2)
end

u42[ValueType.Int64] = function(a1, a2) -- Line: 290
    a1:f64(if type(a2) ~= "number" then 0 else a2)
end

u42[ValueType.String] = function(a1, a2) -- Line: 293 -- upvalues: u16 (val)
    u16.str(a1, if type(a2) ~= "string" then "" else a2)
end

u42[ValueType.Enum] = function(a1, a2) -- Line: 296 -- upvalues: u16 (val)
    u16.varuint(a1, if typeof(a2) ~= "EnumItem" then 0 else a2.Value)
end

u42[ValueType.UDim] = function(a1, a2) -- Line: 299 -- upvalues: u16 (val)
    local v1
    a1:f32((if typeof(a2) ~= "UDim" then UDim.new() else a2).Scale)
    u16.i32(a1, v1.Offset)
end

u42[ValueType.UDim2] = function(a1, a2) -- Line: 302 -- upvalues: u16 (val)
    local v1
    local X = (if typeof(a2) ~= "UDim2" then UDim2.new() else a2).X
    a1:f32(X.Scale)
    u16.i32(a1, X.Offset)
    local Y = v1.Y
    a1:f32(Y.Scale)
    u16.i32(a1, Y.Offset)
end

u42[ValueType.Vector2] = function(a1, a2) -- Line: 307
    local zero
    a1:f32((if typeof(a2) ~= "Vector2" then Vector2.zero else a2).X)
    a1:f32(zero.Y)
end

u42[ValueType.Vector3] = function(a1, a2) -- Line: 312
    local v1
    a1:f32((if typeof(a2) ~= "Vector3" then Vector3.new(0, 0, 0) else a2).X)
    a1:f32(v1.Y)
    a1:f32(v1.Z)
end

u42[ValueType.Color3] = function(a1, a2) -- Line: 318 -- upvalues: color (val)
    color(a1, if typeof(a2) ~= "Color3" then Color3.new() else a2)
end

u42[ValueType.Rect] = function(a1, a2) -- Line: 321
    local v1
    a1:f32((if typeof(a2) ~= "Rect" then Rect.new() else a2).Min.X)
    a1:f32(v1.Min.Y)
    a1:f32(v1.Max.X)
    a1:f32(v1.Max.Y)
end

u42[ValueType.Font] = function(a1, a2) -- Line: 328 -- upvalues: u16 (val)
    if typeof(a2) == "Font" then
        u16.str(a1, a2.Family)
        u16.varuint(a1, a2.Weight.Value)
        a1:u8(a2.Style.Value)
        return
    end
    u16.str(a1, "")
    u16.varuint(a1, 400)
    a1:u8(0)
end

u42[ValueType.ColorSequence] = function(a1, a2) -- Line: 339 -- upvalues: u16 (val), color (val)
    local Keypoints
    u16.varuint(a1, #(if typeof(a2) ~= "ColorSequence" then {} else a2.Keypoints))
    for i, j in Keypoints do
        a1:f32(j.Time)
        color(a1, j.Value)
    end
end

u42[ValueType.NumberSequence] = function(a1, a2) -- Line: 347 -- upvalues: u16 (val)
    local Keypoints
    u16.varuint(a1, #(if typeof(a2) ~= "NumberSequence" then {} else a2.Keypoints))
    for i, j in Keypoints do
        a1:f32(j.Time)
        a1:f32(j.Value)
        a1:f32(j.Envelope)
    end
end

u42[ValueType.NumberRange] = function(a1, a2) -- Line: 356
    local v1
    a1:f32((if typeof(a2) ~= "NumberRange" then NumberRange.new(0) else a2).Min)
    a1:f32(v1.Max)
end

u42[ValueType.Content] = function(a1, a2) -- Line: 361 -- upvalues: u16 (val)
    local Uri = if typeof(a2) ~= "Content" then nil else a2.Uri
    u16.str(a1, if type(Uri) ~= "string" then "" else Uri)
end

u42[ValueType.CFrame] = function(a1, a2) -- Line: 365 -- upvalues: quantizeRotation (val), u16 (val)
    local identity
    local Position = (if typeof(a2) ~= "CFrame" then CFrame.identity else a2).Position
    local X = Position.X
    a1:f32(if X ~= X then 0 else if not (X > (-1 / 0)) then 0 else if not (X < (1 / 0)) then 0 else X)
    local Y = Position.Y
    a1:f32(if Y ~= Y then 0 else if not (Y > (-1 / 0)) then 0 else if not (Y < (1 / 0)) then 0 else Y)
    local Z = Position.Z
    a1:f32(if Z ~= Z then 0 else if not (Z > (-1 / 0)) then 0 else if not (Z < (1 / 0)) then 0 else Z)
    local v1, v2, v3, v4 = quantizeRotation(identity)
    a1:u8(v1)
    if v1 ~= 4 then
        u16.i16(a1, v2)
        u16.i16(a1, v3)
        u16.i16(a1, v4)
    end
end

u42[ValueType.Ref] = function(a1, a2) -- Line: 368 -- upvalues: u40 (ref), u16 (val)
    local v1 = if typeof(a2) ~= "Instance" then nil else u40(a2)
    u16.varuint(a1, if not v1 then 0 else v1 + 1)
end

u42[ValueType.Vector2int16] = function(a1, a2) -- Line: 372 -- upvalues: u16 (val)
    local v1
    u16.i16(a1, (if typeof(a2) ~= "Vector2int16" then Vector2int16.new() else a2).X)
    u16.i16(a1, v1.Y)
end

u16.Writers = u42

function u16.writeValue(a1, a2, a3) -- Line: 380 -- upvalues: u42 (val) -- types: a2: number
    u42[a2](a1, a3)
end

u16.EngineTypes = table.freeze({
    bool = ValueType.Bool,
    int = ValueType.Int32,
    int64 = ValueType.Int64,
    float = ValueType.Float32,
    double = ValueType.Float64,
    string = ValueType.String,
    ContentId = ValueType.String,
    Enum = ValueType.Enum,
    UDim = ValueType.UDim,
    UDim2 = ValueType.UDim2,
    Vector2 = ValueType.Vector2,
    Vector3 = ValueType.Vector3,
    Color3 = ValueType.Color3,
    Rect = ValueType.Rect,
    Font = ValueType.Font,
    ColorSequence = ValueType.ColorSequence,
    NumberSequence = ValueType.NumberSequence,
    NumberRange = ValueType.NumberRange,
    Content = ValueType.Content,
    CFrame = ValueType.CFrame,
    Vector2int16 = ValueType.Vector2int16,
})
return (table.freeze(u16))