-- Script path: ReplicatedStorage.Client.Modules.ReplicatorClient.Buff
-- Decompile time: 122.01 ms

local v1 = {}
local u1 = {
    Axes = 64,
    BrickColor = 65,
    CFrame = 66,
    Color3 = 67,
    ColorSequenceKeypoint = 68,
    ColorSequence = 69,
    DateTime = 70,
    Faces = 71,
    Font = 72,
    NumberRange = 73,
    NumberSequenceKeypoint = 74,
    NumberSequence = 75,
    PhysicalProperties = 76,
    Ray = 77,
    Rect = 78,
    Region3 = 79,
    Region3int16 = 80,
    TweenInfo = 81,
    UDim = 82,
    UDim2 = 83,
    Vector2 = 84,
    Vector2int16 = 85,
    Vector3 = 86,
    Vector3int16 = 87,
    PathWaypoint = 88,
    FloatCurveKey = 89,
    RotationCurveKey = 90,
    Path2DControlPoint = 91,
    Enum = 14,
    EnumItem = 15,
}
local u4 = buffer.create(256)
local u5 = 0
local u6 = 256

local function grow(a1) -- Line: 142 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + a1
    local v2 = u6
    repeat
        v2 = v2 * 2
    until v1 <= v2
    v1 = buffer.create(v2)
    buffer.copy(v1, 0, u4, 0, u5)
    u4 = v1
    u6 = v2
end

local function reserve(a1) -- Line: 154 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + a1
    if u6 < v1 then
        v1 = u5 + a1
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
end

local function wu8(a1) -- Line: 161 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 1
    if u6 < v1 then
        v1 = u5 + 1
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu8(u4, v3, a1)
    u5 = u5 + 1
end

local function wu16(a1) -- Line: 169 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 2
    if u6 < v1 then
        v1 = u5 + 2
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu16(u4, v3, a1)
    u5 = u5 + 2
end

local function wu32(a1) -- Line: 177 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 4
    if u6 < v1 then
        v1 = u5 + 4
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu32(u4, v3, a1)
    u5 = u5 + 4
end

local function wi8(a1) -- Line: 185 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 1
    if u6 < v1 then
        v1 = u5 + 1
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei8(u4, v3, a1)
    u5 = u5 + 1
end

local function wi16(a1) -- Line: 193 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 2
    if u6 < v1 then
        v1 = u5 + 2
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei16(u4, v3, a1)
    u5 = u5 + 2
end

local function wi32(a1) -- Line: 201 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 4
    if u6 < v1 then
        v1 = u5 + 4
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei32(u4, v3, a1)
    u5 = u5 + 4
end

local function wf32(a1) -- Line: 209 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 4
    if u6 < v1 then
        v1 = u5 + 4
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writef32(u4, v3, a1)
    u5 = u5 + 4
end

local function wf64(a1) -- Line: 217 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: number
    local v1 = u5 + 8
    if u6 < v1 then
        v1 = u5 + 8
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writef64(u4, v3, a1)
    u5 = u5 + 8
end

local function wstr(a1) -- Line: 225 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: string
    local v1 = #a1
    local v2 = u5 + v1
    if u6 < v2 then
        v2 = u5 + v1
        local v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    buffer.writestring(u4, u5, a1)
    u5 = u5 + v1
end

local function wlstr(a1) -- Line: 234 -- upvalues: u5 (ref), u6 (ref), u4 (ref) -- types: a1: string
    local v1
    local v2 = #a1
    local v3 = u5 + 4
    if u6 < v3 then
        v3 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu32(u4, v4, v2)
    u5 = u5 + 4
    if v2 > 0 then
        v3 = #a1
        v1 = u5 + v3
        if u6 < v1 then
            v1 = u5 + v3
            v4 = u6
            repeat
                v4 = v4 * 2
            until v1 <= v4
            v1 = buffer.create(v4)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v4
        end
        buffer.writestring(u4, u5, a1)
        u5 = u5 + v3
    end
end

local u19 = nil
local u20 = nil
local u23 = buffer.create(0)
local u24 = 0

local function rf32() -- Line: 284 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readf32(u23, v1)
    u24 = u24 + 4
    return v2
end

local function rstr(a1) -- Line: 296 -- upvalues: u23 (ref), u24 (ref) -- types: a1: number
    local v1 = buffer.readstring(u23, u24, a1)
    u24 = u24 + a1
    return v1
end

local function rlstr() -- Line: 302 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    if v2 == 0 then
        return ""
    end
    local v3 = buffer.readstring(u23, u24, v2)
    u24 = u24 + v2
    return v3
end

local u35 = nil
local u36 = nil
local u37 = {}
local u38 = {}

u37[0] = function() end

u37[1] = function() end

u37[2] = function() end

u37[3] = function(a1) -- Line: 322 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 1
    if u6 < v1 then
        v1 = u5 + 1
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu8(u4, v3, a1)
    u5 = u5 + 1
end

u37[4] = function(a1) -- Line: 325 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 2
    if u6 < v1 then
        v1 = u5 + 2
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu16(u4, v3, a1)
    u5 = u5 + 2
end

u37[5] = function(a1) -- Line: 328 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 4
    if u6 < v1 then
        v1 = u5 + 4
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu32(u4, v3, a1)
    u5 = u5 + 4
end

u37[6] = function(a1) -- Line: 331 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 1
    if u6 < v1 then
        v1 = u5 + 1
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei8(u4, v3, a1)
    u5 = u5 + 1
end

u37[7] = function(a1) -- Line: 334 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 2
    if u6 < v1 then
        v1 = u5 + 2
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei16(u4, v3, a1)
    u5 = u5 + 2
end

u37[8] = function(a1) -- Line: 337 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 4
    if u6 < v1 then
        v1 = u5 + 4
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writei32(u4, v3, a1)
    u5 = u5 + 4
end

u37[9] = function(a1) -- Line: 340 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 8
    if u6 < v1 then
        v1 = u5 + 8
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writef64(u4, v3, a1)
    u5 = u5 + 8
end

u37[10] = function(a1) -- Line: 344 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = #a1
    local v3 = u5 + 1
    if u6 < v3 then
        v3 = u5 + 1
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu8(u4, v4, v2)
    u5 = u5 + 1
    v2 = #a1
    v3 = u5 + v2
    if u6 < v3 then
        v3 = u5 + v2
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    buffer.writestring(u4, u5, a1)
    u5 = u5 + v2
end

u37[11] = function(a1) -- Line: 350 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = #a1
    local v3 = u5 + 2
    if u6 < v3 then
        v3 = u5 + 2
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu16(u4, v4, v2)
    u5 = u5 + 2
    v2 = #a1
    v3 = u5 + v2
    if u6 < v3 then
        v3 = u5 + v2
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    buffer.writestring(u4, u5, a1)
    u5 = u5 + v2
end

u37[12] = function(a1) -- Line: 356 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = #a1
    local v3 = u5 + 4
    if u6 < v3 then
        v3 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu32(u4, v4, v2)
    u5 = u5 + 4
    v2 = #a1
    v3 = u5 + v2
    if u6 < v3 then
        v3 = u5 + v2
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    buffer.writestring(u4, u5, a1)
    u5 = u5 + v2
end

u37[13] = function(a1) -- Line: 362 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = buffer.len(a1)
    local v3 = u5 + 4
    if u6 < v3 then
        v3 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu32(u4, v4, v2)
    u5 = u5 + 4
    v3 = u5 + v2
    if u6 < v3 then
        v3 = u5 + v2
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    buffer.copy(u4, u5, a1, 0, v2)
    u5 = u5 + v2
end

u38[0] = function() -- Line: 371
    return nil
end

u38[1] = function() -- Line: 374
    return false
end

u38[2] = function() -- Line: 377
    return true
end

u38[3] = function() -- Line: 248 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu8(u23, v1)
    u24 = u24 + 1
    return v2
end

u38[4] = function() -- Line: 254 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu16(u23, v1)
    u24 = u24 + 2
    return v2
end

u38[5] = function() -- Line: 260 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    return v2
end

u38[6] = function() -- Line: 266 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readi8(u23, v1)
    u24 = u24 + 1
    return v2
end

u38[7] = function() -- Line: 272 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readi16(u23, v1)
    u24 = u24 + 2
    return v2
end

u38[8] = function() -- Line: 278 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readi32(u23, v1)
    u24 = u24 + 4
    return v2
end

u38[9] = function() -- Line: 290 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readf64(u23, v1)
    u24 = u24 + 8
    return v2
end

u38[10] = function() -- Line: 388 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu8(u23, v1)
    u24 = u24 + 1
    if v2 == 0 then
        return ""
    end
    local v3 = buffer.readstring(u23, u24, v2)
    u24 = u24 + v2
    return v3
end

u38[11] = function() -- Line: 396 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu16(u23, v1)
    u24 = u24 + 2
    if v2 == 0 then
        return ""
    end
    local v3 = buffer.readstring(u23, u24, v2)
    u24 = u24 + v2
    return v3
end

u38[12] = function() -- Line: 404 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    if v2 == 0 then
        return ""
    end
    local v3 = buffer.readstring(u23, u24, v2)
    u24 = u24 + v2
    return v3
end

u38[13] = function() -- Line: 412 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    local v3 = buffer.create(v2)
    buffer.copy(v3, 0, u23, u24, v2)
    u24 = u24 + v2
    return v3
end

u37[14] = function(a1) -- Line: 421 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = tostring(a1)
    local v3 = #v2
    local v4 = u5 + 4
    if u6 < v4 then
        v4 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v4 <= v1
        v4 = buffer.create(v1)
        buffer.copy(v4, 0, u4, 0, u5)
        u4 = v4
        u6 = v1
    end
    local v5 = u5
    buffer.writeu32(u4, v5, v3)
    u5 = u5 + 4
    if v3 > 0 then
        v4 = #v2
        v1 = u5 + v4
        if u6 < v1 then
            v1 = u5 + v4
            v5 = u6
            repeat
                v5 = v5 * 2
            until v1 <= v5
            v1 = buffer.create(v5)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v5
        end
        buffer.writestring(u4, u5, v2)
        u5 = u5 + v4
    end
end

u37[15] = function(a1) -- Line: 425 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = tostring(a1.EnumType)
    local v3 = #v2
    local v4 = u5 + 4
    if u6 < v4 then
        v4 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v4 <= v1
        v4 = buffer.create(v1)
        buffer.copy(v4, 0, u4, 0, u5)
        u4 = v4
        u6 = v1
    end
    local v5 = u5
    buffer.writeu32(u4, v5, v3)
    u5 = u5 + 4
    if v3 > 0 then
        v4 = #v2
        v1 = u5 + v4
        if u6 < v1 then
            v1 = u5 + v4
            v5 = u6
            repeat
                v5 = v5 * 2
            until v1 <= v5
            v1 = buffer.create(v5)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v5
        end
        buffer.writestring(u4, u5, v2)
        u5 = u5 + v4
    end
    local Value = a1.Value
    v3 = u5 + 4
    if u6 < v3 then
        v3 = u5 + 4
        v4 = u6
        repeat
            v4 = v4 * 2
        until v3 <= v4
        v3 = buffer.create(v4)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v4
    end
    v1 = u5
    buffer.writei32(u4, v1, Value)
    u5 = u5 + 4
end

u38[14] = function() -- Line: 430 -- upvalues: u23 (ref), u24 (ref)
    local v1
    local v2 = Enum
    local v3 = u24
    local v4 = buffer.readu32(u23, v3)
    u24 = u24 + 4
    if v4 ~= 0 then
        v1 = buffer.readstring(u23, u24, v4)
        u24 = u24 + v4
    else
        v1 = ""
    end
    return v2[v1]
end

u38[15] = function() -- Line: 434 -- upvalues: u23 (ref), u24 (ref)
    local v1
    local v2 = Enum
    local v3 = u24
    local v4 = buffer.readu32(u23, v3)
    u24 = u24 + 4
    if v4 ~= 0 then
        v1 = buffer.readstring(u23, u24, v4)
        u24 = u24 + v4
    else
        v1 = ""
    end
    local v5 = v2[v1]
    v3 = u24
    v4 = buffer.readi32(u23, v3)
    u24 = u24 + 4
    return v5:FromValue(v4)
end

u37[92] = function(a1) -- Line: 440 -- upvalues: u19 (ref), u5 (ref), u6 (ref), u4 (ref)
    if not u19 then
        error("Buff: Instance serialization requires enableInstances=true in encode()")
    end
    table.insert(u19, a1)
    local v1 = #u19
    local v2 = u5 + 4
    if u6 < v2 then
        v2 = u5 + 4
        local v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    local v4 = u5
    buffer.writeu32(u4, v4, v1)
    u5 = u5 + 4
end

u38[92] = function() -- Line: 448 -- upvalues: u23 (ref), u24 (ref), u20 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    if not u20 then
        error("Buff: buffer contains Instance refs but no instances array was provided to decode()")
    end
    return u20[v2]
end

u37[64] = function(a1) -- Line: 458 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = 0
    if a1.X then
        v1 = v1 + 1
    end
    if a1.Y then
        v1 = v1 + 2
    end
    if a1.Z then
        v1 = v1 + 4
    end
    local v2 = u5 + 1
    if u6 < v2 then
        v2 = u5 + 1
        local v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    local v4 = u5
    buffer.writeu8(u4, v4, v1)
    u5 = u5 + 1
end

u38[64] = function() -- Line: 472 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu8(u23, v1)
    u24 = u24 + 1
    local v3 = {}
    if bit32.band(v2, 1) ~= 0 then
        table.insert(v3, Enum.Axis.X)
    end
    if bit32.band(v2, 2) ~= 0 then
        table.insert(v3, Enum.Axis.Y)
    end
    if bit32.band(v2, 4) ~= 0 then
        table.insert(v3, Enum.Axis.Z)
    end
    return Axes.new(table.unpack(v3))
end

u37[65] = function(a1) -- Line: 488 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local Number = a1.Number
    local v1 = u5 + 2
    if u6 < v1 then
        v1 = u5 + 2
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writeu16(u4, v3, Number)
    u5 = u5 + 2
end

u38[65] = function() -- Line: 491 -- upvalues: u23 (ref), u24 (ref)
    local new = BrickColor.new
    local v1 = u24
    local v2 = buffer.readu16(u23, v1)
    u24 = u24 + 2
    return new(v2)
end

u37[66] = function(a1) -- Line: 496 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 48
    if u6 < v2 then
        v2 = u5 + 48
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v2 = u5
    v1 = u4
    local Components_7, Components_8, Components_9, Components_10, Components_11, Components_12, Components, Components_2, Components_3, Components_4, Components_5, Components_6 = a1:GetComponents()
    buffer.writef32(v1, v2, Components_7)
    local v3 = v2 + 4
    buffer.writef32(v1, v3, Components_8)
    v3 = v2 + 8
    buffer.writef32(v1, v3, Components_9)
    v3 = v2 + 12
    buffer.writef32(v1, v3, Components_10)
    v3 = v2 + 16
    buffer.writef32(v1, v3, Components_11)
    v3 = v2 + 20
    buffer.writef32(v1, v3, Components_12)
    v3 = v2 + 24
    buffer.writef32(v1, v3, Components)
    v3 = v2 + 28
    buffer.writef32(v1, v3, Components_2)
    v3 = v2 + 32
    buffer.writef32(v1, v3, Components_3)
    v3 = v2 + 36
    buffer.writef32(v1, v3, Components_4)
    v3 = v2 + 40
    buffer.writef32(v1, v3, Components_5)
    v3 = v2 + 44
    buffer.writef32(v1, v3, Components_6)
    u5 = v2 + 48
end

u38[66] = function() -- Line: 516 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = CFrame.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = buffer.readf32(v2, v6)
    local v8 = v1 + 12
    v4 = buffer.readf32(v2, v8)
    local v9 = v1 + 16
    v6 = buffer.readf32(v2, v9)
    local v10 = v1 + 20
    v8 = buffer.readf32(v2, v10)
    local v11 = v1 + 24
    v9 = buffer.readf32(v2, v11)
    local v12 = v1 + 28
    v10 = buffer.readf32(v2, v12)
    local v13 = v1 + 32
    v11 = buffer.readf32(v2, v13)
    local v14 = v1 + 36
    v12 = buffer.readf32(v2, v14)
    local v15 = v1 + 40
    v13 = buffer.readf32(v2, v15)
    local v16 = v1 + 44
    local v17 = new(v3, v5, v7, v4, v6, v8, v9, v10, v11, v12, v13, (buffer.readf32(v2, v16)))
    u24 = v1 + 48
    return v17
end

u37[67] = function(a1) -- Line: 538 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 12
    if u6 < v1 then
        v1 = u5 + 12
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local R = a1.R
    buffer.writef32(v3, v1, R)
    v3 = u4
    local v4 = v1 + 4
    local G = a1.G
    buffer.writef32(v3, v4, G)
    v3 = u4
    v4 = v1 + 8
    local B = a1.B
    buffer.writef32(v3, v4, B)
    u5 = v1 + 12
end

u38[67] = function() -- Line: 547 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local new = Color3.new
    local v2 = u23
    local v3 = buffer.readf32(v2, v1)
    local v4 = u23
    local v5 = v1 + 4
    v2 = buffer.readf32(v4, v5)
    v5 = u23
    local v6 = v1 + 8
    local v7 = new(v3, v2, (buffer.readf32(v5, v6)))
    u24 = v1 + 12
    return v7
end

u37[68] = function(a1) -- Line: 555 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 16
    if u6 < v1 then
        v1 = u5 + 16
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Time = a1.Time
    buffer.writef32(v3, v1, Time)
    v3 = u4
    local v4 = v1 + 4
    local R = a1.Value.R
    buffer.writef32(v3, v4, R)
    v3 = u4
    v4 = v1 + 8
    local G = a1.Value.G
    buffer.writef32(v3, v4, G)
    v3 = u4
    v4 = v1 + 12
    local B = a1.Value.B
    buffer.writef32(v3, v4, B)
    u5 = v1 + 16
end

u38[68] = function() -- Line: 565 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = ColorSequenceKeypoint.new
    local v3 = buffer.readf32(v2, v1)
    local new_2 = Color3.new
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = buffer.readf32(v2, v6)
    local v8 = v1 + 12
    local v9 = new(v3, new_2(v5, v7, (buffer.readf32(v2, v8))))
    u24 = v1 + 16
    return v9
end

u37[69] = function(a1) -- Line: 577 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local B, G, R, Time, v1, v2, v3, v4, v5
    local Keypoints = a1.Keypoints
    local v6 = #Keypoints
    local v7 = u5 + 4
    if u6 < v7 then
        v7 = u5 + 4
        v2 = u6
        repeat
            v2 = v2 * 2
        until v7 <= v2
        v7 = buffer.create(v2)
        buffer.copy(v7, 0, u4, 0, u5)
        u4 = v7
        u6 = v2
    end
    local v8 = u5
    buffer.writeu32(u4, v8, v6)
    u5 = u5 + 4
    v7 = v6 * 16
    v2 = u5 + v7
    if u6 < v2 then
        v2 = u5 + v7
        v8 = u6
        repeat
            v8 = v8 * 2
        until v2 <= v8
        v2 = buffer.create(v8)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v8
    end
    for i = 1, v6 do
        v3 = Keypoints[i]
        v4 = u5
        v5 = u4
        Time = v3.Time
        buffer.writef32(v5, v4, Time)
        v5 = u4
        v1 = v4 + 4
        R = v3.Value.R
        buffer.writef32(v5, v1, R)
        v5 = u4
        v1 = v4 + 8
        G = v3.Value.G
        buffer.writef32(v5, v1, G)
        v5 = u4
        v1 = v4 + 12
        B = v3.Value.B
        buffer.writef32(v5, v1, B)
        u5 = v4 + 16
    end
end

u38[69] = function() -- Line: 593 -- upvalues: u23 (ref), u24 (ref)
    local new, new_2, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = u24
    local v10 = buffer.readu32(u23, v9)
    u24 = u24 + 4
    local v11 = table.create(v10)
    for i = 1, v10 do
        v6 = u24
        v7 = u23
        new = ColorSequenceKeypoint.new
        v8 = buffer.readf32(v7, v6)
        new_2 = Color3.new
        v3 = v6 + 4
        v1 = buffer.readf32(v7, v3)
        v4 = v6 + 8
        v2 = buffer.readf32(v7, v4)
        v5 = v6 + 12
        v11[i] = (new(v8, new_2(v1, v2, (buffer.readf32(v7, v5)))))
        u24 = v6 + 16
    end
    return ColorSequence.new(v11)
end

u37[70] = function(a1) -- Line: 609 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local UnixTimestampMillis = a1.UnixTimestampMillis
    local v1 = u5 + 8
    if u6 < v1 then
        v1 = u5 + 8
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    local v3 = u5
    buffer.writef64(u4, v3, UnixTimestampMillis)
    u5 = u5 + 8
end

u38[70] = function() -- Line: 612 -- upvalues: u23 (ref), u24 (ref)
    local fromUnixTimestampMillis = DateTime.fromUnixTimestampMillis
    local v1 = u24
    local v2 = buffer.readf64(u23, v1)
    u24 = u24 + 8
    return fromUnixTimestampMillis(v2)
end

u37[71] = function(a1) -- Line: 617 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = 0
    if a1.Top then
        v1 = v1 + 1
    end
    if a1.Bottom then
        v1 = v1 + 2
    end
    if a1.Left then
        v1 = v1 + 4
    end
    if a1.Right then
        v1 = v1 + 8
    end
    if a1.Front then
        v1 = v1 + 16
    end
    if a1.Back then
        v1 = v1 + 32
    end
    local v2 = u5 + 1
    if u6 < v2 then
        v2 = u5 + 1
        local v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    local v4 = u5
    buffer.writeu8(u4, v4, v1)
    u5 = u5 + 1
end

u38[71] = function() -- Line: 640 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readu8(u23, v1)
    u24 = u24 + 1
    local v3 = {}
    if bit32.band(v2, 1) ~= 0 then
        table.insert(v3, Enum.NormalId.Top)
    end
    if bit32.band(v2, 2) ~= 0 then
        table.insert(v3, Enum.NormalId.Bottom)
    end
    if bit32.band(v2, 4) ~= 0 then
        table.insert(v3, Enum.NormalId.Left)
    end
    if bit32.band(v2, 8) ~= 0 then
        table.insert(v3, Enum.NormalId.Right)
    end
    if bit32.band(v2, 16) ~= 0 then
        table.insert(v3, Enum.NormalId.Front)
    end
    if bit32.band(v2, 32) ~= 0 then
        table.insert(v3, Enum.NormalId.Back)
    end
    return Faces.new(table.unpack(v3))
end

u37[72] = function(a1) -- Line: 665 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local Family = a1.Family
    local v2 = #Family
    local v3 = u5 + 4
    if u6 < v3 then
        v3 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v3 <= v1
        v3 = buffer.create(v1)
        buffer.copy(v3, 0, u4, 0, u5)
        u4 = v3
        u6 = v1
    end
    local v4 = u5
    buffer.writeu32(u4, v4, v2)
    u5 = u5 + 4
    if v2 > 0 then
        v3 = #Family
        v1 = u5 + v3
        if u6 < v1 then
            v1 = u5 + v3
            v4 = u6
            repeat
                v4 = v4 * 2
            until v1 <= v4
            v1 = buffer.create(v4)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v4
        end
        buffer.writestring(u4, u5, Family)
        u5 = u5 + v3
    end
    local Value = a1.Weight.Value
    v2 = u5 + 4
    if u6 < v2 then
        v2 = u5 + 4
        v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    v1 = u5
    buffer.writeu32(u4, v1, Value)
    u5 = u5 + 4
    local Value_2 = a1.Style.Value
    v2 = u5 + 4
    if u6 < v2 then
        v2 = u5 + 4
        v3 = u6
        repeat
            v3 = v3 * 2
        until v2 <= v3
        v2 = buffer.create(v3)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v3
    end
    v1 = u5
    buffer.writeu32(u4, v1, Value_2)
    u5 = u5 + 4
end

u38[72] = function() -- Line: 671 -- upvalues: u23 (ref), u24 (ref)
    local v1
    local v2 = u24
    local v3 = buffer.readu32(u23, v2)
    u24 = u24 + 4
    if v3 ~= 0 then
        v1 = buffer.readstring(u23, u24, v3)
        u24 = u24 + v3
    else
        v1 = ""
    end
    local FontWeight = Enum.FontWeight
    local v4 = u24
    v2 = buffer.readu32(u23, v4)
    u24 = u24 + 4
    v3 = FontWeight:FromValue(v2)
    local FontStyle = Enum.FontStyle
    local v5 = u24
    local v6 = buffer.readu32(u23, v5)
    u24 = u24 + 4
    return Font.new(v1, v3, (FontStyle:FromValue(v6)))
end

u37[73] = function(a1) -- Line: 679 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 8
    if u6 < v2 then
        v2 = u5 + 8
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v1 = u4
    local v3 = u5
    local Min = a1.Min
    buffer.writef32(v1, v3, Min)
    v1 = u4
    v3 = u5 + 4
    local Max = a1.Max
    buffer.writef32(v1, v3, Max)
    u5 = u5 + 8
end

u38[73] = function() -- Line: 686 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readf32(u23, v1)
    v1 = u23
    local v3 = u24 + 4
    local v4 = buffer.readf32(v1, v3)
    u24 = u24 + 8
    return NumberRange.new(v2, v4)
end

u37[74] = function(a1) -- Line: 694 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 12
    if u6 < v1 then
        v1 = u5 + 12
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Time = a1.Time
    buffer.writef32(v3, v1, Time)
    v3 = u4
    local v4 = v1 + 4
    local Value = a1.Value
    buffer.writef32(v3, v4, Value)
    v3 = u4
    v4 = v1 + 8
    local Envelope = a1.Envelope
    buffer.writef32(v3, v4, Envelope)
    u5 = v1 + 12
end

u38[74] = function() -- Line: 703 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = NumberSequenceKeypoint.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = new(v3, v5, (buffer.readf32(v2, v6)))
    u24 = v1 + 12
    return v7
end

u37[75] = function(a1) -- Line: 712 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local Envelope, Time, Value, v1, v2, v3, v4, v5
    local Keypoints = a1.Keypoints
    local v6 = #Keypoints
    local v7 = u5 + 4
    if u6 < v7 then
        v7 = u5 + 4
        v2 = u6
        repeat
            v2 = v2 * 2
        until v7 <= v2
        v7 = buffer.create(v2)
        buffer.copy(v7, 0, u4, 0, u5)
        u4 = v7
        u6 = v2
    end
    local v8 = u5
    buffer.writeu32(u4, v8, v6)
    u5 = u5 + 4
    v7 = v6 * 12
    v2 = u5 + v7
    if u6 < v2 then
        v2 = u5 + v7
        v8 = u6
        repeat
            v8 = v8 * 2
        until v2 <= v8
        v2 = buffer.create(v8)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v8
    end
    for i = 1, v6 do
        v3 = Keypoints[i]
        v4 = u5
        v5 = u4
        Time = v3.Time
        buffer.writef32(v5, v4, Time)
        v5 = u4
        v1 = v4 + 4
        Value = v3.Value
        buffer.writef32(v5, v1, Value)
        v5 = u4
        v1 = v4 + 8
        Envelope = v3.Envelope
        buffer.writef32(v5, v1, Envelope)
        u5 = v4 + 12
    end
end

u38[75] = function() -- Line: 727 -- upvalues: u23 (ref), u24 (ref)
    local new, v1, v2, v3, v4, v5, v6
    local v7 = u24
    local v8 = buffer.readu32(u23, v7)
    u24 = u24 + 4
    local v9 = table.create(v8)
    for i = 1, v8 do
        v3 = u24
        v4 = u23
        new = NumberSequenceKeypoint.new
        v5 = buffer.readf32(v4, v3)
        v1 = v3 + 4
        v6 = buffer.readf32(v4, v1)
        v2 = v3 + 8
        v9[i] = (new(v5, v6, (buffer.readf32(v4, v2))))
        u24 = v3 + 12
    end
    return NumberSequence.new(v9)
end

u37[76] = function(a1) -- Line: 740 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 20
    if u6 < v1 then
        v1 = u5 + 20
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Density = a1.Density
    buffer.writef32(v3, v1, Density)
    v3 = u4
    local v4 = v1 + 4
    local Friction = a1.Friction
    buffer.writef32(v3, v4, Friction)
    v3 = u4
    v4 = v1 + 8
    local Elasticity = a1.Elasticity
    buffer.writef32(v3, v4, Elasticity)
    v3 = u4
    v4 = v1 + 12
    local FrictionWeight = a1.FrictionWeight
    buffer.writef32(v3, v4, FrictionWeight)
    v3 = u4
    v4 = v1 + 16
    local ElasticityWeight = a1.ElasticityWeight
    buffer.writef32(v3, v4, ElasticityWeight)
    u5 = v1 + 20
end

u38[76] = function() -- Line: 751 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = PhysicalProperties.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = buffer.readf32(v2, v6)
    local v8 = v1 + 12
    v4 = buffer.readf32(v2, v8)
    local v9 = v1 + 16
    local v10 = new(v3, v5, v7, v4, (buffer.readf32(v2, v9)))
    u24 = v1 + 20
    return v10
end

u37[77] = function(a1) -- Line: 766 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 24
    if u6 < v1 then
        v1 = u5 + 24
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local Origin = a1.Origin
    local Direction = a1.Direction
    local v3 = u4
    local X = Origin.X
    buffer.writef32(v3, v1, X)
    v3 = u4
    local v4 = v1 + 4
    local Y = Origin.Y
    buffer.writef32(v3, v4, Y)
    v3 = u4
    v4 = v1 + 8
    local Z = Origin.Z
    buffer.writef32(v3, v4, Z)
    v3 = u4
    v4 = v1 + 12
    local X_2 = Direction.X
    buffer.writef32(v3, v4, X_2)
    v3 = u4
    v4 = v1 + 16
    local Y_2 = Direction.Y
    buffer.writef32(v3, v4, Y_2)
    v3 = u4
    v4 = v1 + 20
    local Z_2 = Direction.Z
    buffer.writef32(v3, v4, Z_2)
    u5 = v1 + 24
end

u38[77] = function() -- Line: 779 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Ray.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = Vector3.new(v3, v5, (buffer.readf32(v2, v6)))
    v4 = v1 + 12
    v5 = buffer.readf32(v2, v4)
    v6 = v1 + 16
    local v8 = buffer.readf32(v2, v6)
    local v9 = v1 + 20
    local v10 = new(v7, (Vector3.new(v5, v8, (buffer.readf32(v2, v9)))))
    u24 = v1 + 24
    return v10
end

u37[78] = function(a1) -- Line: 791 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 16
    if u6 < v1 then
        v1 = u5 + 16
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local X = a1.Min.X
    buffer.writef32(v3, v1, X)
    v3 = u4
    local v4 = v1 + 4
    local Y = a1.Min.Y
    buffer.writef32(v3, v4, Y)
    v3 = u4
    v4 = v1 + 8
    local X_2 = a1.Max.X
    buffer.writef32(v3, v4, X_2)
    v3 = u4
    v4 = v1 + 12
    local Y_2 = a1.Max.Y
    buffer.writef32(v3, v4, Y_2)
    u5 = v1 + 16
end

u38[78] = function() -- Line: 801 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Rect.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = buffer.readf32(v2, v6)
    local v8 = v1 + 12
    local v9 = new(v3, v5, v7, (buffer.readf32(v2, v8)))
    u24 = v1 + 16
    return v9
end

u37[79] = function(a1) -- Line: 811 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 24
    if u6 < v1 then
        v1 = u5 + 24
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local Position = a1.CFrame.Position
    local v3 = a1.Size / 2
    local v4 = Position - v3
    local v5 = Position + v3
    local v6 = u4
    local X = v4.X
    buffer.writef32(v6, v1, X)
    v6 = u4
    local v7 = v1 + 4
    local Y = v4.Y
    buffer.writef32(v6, v7, Y)
    v6 = u4
    v7 = v1 + 8
    local Z = v4.Z
    buffer.writef32(v6, v7, Z)
    v6 = u4
    v7 = v1 + 12
    local X_2 = v5.X
    buffer.writef32(v6, v7, X_2)
    v6 = u4
    v7 = v1 + 16
    local Y_2 = v5.Y
    buffer.writef32(v6, v7, Y_2)
    v6 = u4
    v7 = v1 + 20
    local Z_2 = v5.Z
    buffer.writef32(v6, v7, Z_2)
    u5 = v1 + 24
end

u38[79] = function() -- Line: 826 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Region3.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = Vector3.new(v3, v5, (buffer.readf32(v2, v6)))
    v4 = v1 + 12
    v5 = buffer.readf32(v2, v4)
    v6 = v1 + 16
    local v8 = buffer.readf32(v2, v6)
    local v9 = v1 + 20
    local v10 = new(v7, (Vector3.new(v5, v8, (buffer.readf32(v2, v9)))))
    u24 = v1 + 24
    return v10
end

u37[80] = function(a1) -- Line: 838 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 12
    if u6 < v1 then
        v1 = u5 + 12
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local Min = a1.Min
    local Max = a1.Max
    local v3 = u4
    local X = Min.X
    buffer.writei16(v3, v1, X)
    v3 = u4
    local v4 = v1 + 2
    local Y = Min.Y
    buffer.writei16(v3, v4, Y)
    v3 = u4
    v4 = v1 + 4
    local Z = Min.Z
    buffer.writei16(v3, v4, Z)
    v3 = u4
    v4 = v1 + 6
    local X_2 = Max.X
    buffer.writei16(v3, v4, X_2)
    v3 = u4
    v4 = v1 + 8
    local Y_2 = Max.Y
    buffer.writei16(v3, v4, Y_2)
    v3 = u4
    v4 = v1 + 10
    local Z_2 = Max.Z
    buffer.writei16(v3, v4, Z_2)
    u5 = v1 + 12
end

u38[80] = function() -- Line: 851 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Region3int16.new
    local new_2 = Vector3int16.new
    local v3 = buffer.readi16(v2, v1)
    local v4 = v1 + 2
    local v5 = buffer.readi16(v2, v4)
    local v6 = v1 + 4
    local v7 = new_2(v3, v5, (buffer.readi16(v2, v6)))
    local new_3 = Vector3int16.new
    v4 = v1 + 6
    v5 = buffer.readi16(v2, v4)
    v6 = v1 + 8
    local v8 = buffer.readi16(v2, v6)
    local v9 = v1 + 10
    local v10 = new(v7, new_3(v5, v8, (buffer.readi16(v2, v9))))
    u24 = v1 + 12
    return v10
end

u37[81] = function(a1) -- Line: 863 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 21
    if u6 < v1 then
        v1 = u5 + 21
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Time = a1.Time
    buffer.writef32(v3, v1, Time)
    v3 = u4
    local v4 = v1 + 4
    local Value = a1.EasingStyle.Value
    buffer.writeu32(v3, v4, Value)
    v3 = u4
    v4 = v1 + 8
    local Value_2 = a1.EasingDirection.Value
    buffer.writeu32(v3, v4, Value_2)
    v3 = u4
    v4 = v1 + 12
    local RepeatCount = a1.RepeatCount
    buffer.writei32(v3, v4, RepeatCount)
    v3 = u4
    v4 = v1 + 16
    local v5 = if not a1.Reverses then 0 else 1
    buffer.writeu8(v3, v4, v5)
    v3 = u4
    v4 = v1 + 17
    local DelayTime = a1.DelayTime
    buffer.writef32(v3, v4, DelayTime)
    u5 = v1 + 21
end

u38[81] = function() -- Line: 875 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = TweenInfo.new
    local v3 = buffer.readf32(v2, v1)
    local EasingStyle = Enum.EasingStyle
    local v4 = v1 + 4
    local v5 = EasingStyle:FromValue((buffer.readu32(v2, v4)))
    local EasingDirection = Enum.EasingDirection
    local v6 = v1 + 8
    local v7 = EasingDirection:FromValue((buffer.readu32(v2, v6)))
    v4 = v1 + 12
    local v8 = buffer.readi32(v2, v4)
    local v9 = v1 + 16
    local v10 = buffer.readu8(v2, v9) == 1
    v9 = v1 + 17
    local v11 = new(v3, v5, v7, v8, v10, (buffer.readf32(v2, v9)))
    u24 = v1 + 21
    return v11
end

u37[82] = function(a1) -- Line: 891 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 8
    if u6 < v2 then
        v2 = u5 + 8
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v1 = u4
    local v3 = u5
    local Scale = a1.Scale
    buffer.writef32(v1, v3, Scale)
    v1 = u4
    v3 = u5 + 4
    local Offset = a1.Offset
    buffer.writei32(v1, v3, Offset)
    u5 = u5 + 8
end

u38[82] = function() -- Line: 898 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readf32(u23, v1)
    v1 = u23
    local v3 = u24 + 4
    local v4 = buffer.readi32(v1, v3)
    u24 = u24 + 8
    return UDim.new(v2, v4)
end

u37[83] = function(a1) -- Line: 906 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 16
    if u6 < v1 then
        v1 = u5 + 16
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Scale = a1.X.Scale
    buffer.writef32(v3, v1, Scale)
    v3 = u4
    local v4 = v1 + 4
    local Offset = a1.X.Offset
    buffer.writei32(v3, v4, Offset)
    v3 = u4
    v4 = v1 + 8
    local Scale_2 = a1.Y.Scale
    buffer.writef32(v3, v4, Scale_2)
    v3 = u4
    v4 = v1 + 12
    local Offset_2 = a1.Y.Offset
    buffer.writei32(v3, v4, Offset_2)
    u5 = v1 + 16
end

u38[83] = function() -- Line: 916 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = UDim2.new
    local new_2 = UDim.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = new_2(v3, (buffer.readi32(v2, v4)))
    local new_3 = UDim.new
    v4 = v1 + 8
    local v6 = buffer.readf32(v2, v4)
    local v7 = v1 + 12
    local v8 = new(v5, new_3(v6, (buffer.readi32(v2, v7))))
    u24 = v1 + 16
    return v8
end

u37[84] = function(a1) -- Line: 928 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 8
    if u6 < v2 then
        v2 = u5 + 8
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v1 = u4
    local v3 = u5
    local X = a1.X
    buffer.writef32(v1, v3, X)
    v1 = u4
    v3 = u5 + 4
    local Y = a1.Y
    buffer.writef32(v1, v3, Y)
    u5 = u5 + 8
end

u38[84] = function() -- Line: 935 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readf32(u23, v1)
    v1 = u23
    local v3 = u24 + 4
    local v4 = buffer.readf32(v1, v3)
    u24 = u24 + 8
    return Vector2.new(v2, v4)
end

u37[85] = function(a1) -- Line: 943 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 4
    if u6 < v2 then
        v2 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v1 = u4
    local v3 = u5
    local X = a1.X
    buffer.writei16(v1, v3, X)
    v1 = u4
    v3 = u5 + 2
    local Y = a1.Y
    buffer.writei16(v1, v3, Y)
    u5 = u5 + 4
end

u38[85] = function() -- Line: 950 -- upvalues: u23 (ref), u24 (ref)
    local v1 = u24
    local v2 = buffer.readi16(u23, v1)
    v1 = u23
    local v3 = u24 + 2
    local v4 = buffer.readi16(v1, v3)
    u24 = u24 + 4
    return Vector2int16.new(v2, v4)
end

u37[86] = function(a1) -- Line: 958 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 12
    if u6 < v1 then
        v1 = u5 + 12
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local X = a1.X
    buffer.writef32(v3, v1, X)
    v3 = u4
    local v4 = v1 + 4
    local Y = a1.Y
    buffer.writef32(v3, v4, Y)
    v3 = u4
    v4 = v1 + 8
    local Z = a1.Z
    buffer.writef32(v3, v4, Z)
    u5 = v1 + 12
end

u38[86] = function() -- Line: 967 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = Vector3.new(v3, v5, (buffer.readf32(v2, v6)))
    u24 = v1 + 12
    return v7
end

u37[87] = function(a1) -- Line: 976 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 6
    if u6 < v1 then
        v1 = u5 + 6
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local X = a1.X
    buffer.writei16(v3, v1, X)
    v3 = u4
    local v4 = v1 + 2
    local Y = a1.Y
    buffer.writei16(v3, v4, Y)
    v3 = u4
    v4 = v1 + 4
    local Z = a1.Z
    buffer.writei16(v3, v4, Z)
    u5 = v1 + 6
end

u38[87] = function() -- Line: 985 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Vector3int16.new
    local v3 = buffer.readi16(v2, v1)
    local v4 = v1 + 2
    local v5 = buffer.readi16(v2, v4)
    local v6 = v1 + 4
    local v7 = new(v3, v5, (buffer.readi16(v2, v6)))
    u24 = v1 + 6
    return v7
end

u37[88] = function(a1) -- Line: 994 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 13
    if u6 < v1 then
        v1 = u5 + 13
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local Position = a1.Position
    local v3 = u4
    local X = Position.X
    buffer.writef32(v3, v1, X)
    v3 = u4
    local v4 = v1 + 4
    local Y = Position.Y
    buffer.writef32(v3, v4, Y)
    v3 = u4
    v4 = v1 + 8
    local Z = Position.Z
    buffer.writef32(v3, v4, Z)
    v3 = u4
    v4 = v1 + 12
    local Value = a1.Action.Value
    buffer.writeu8(v3, v4, Value)
    u5 = v1 + 13
end

u38[88] = function() -- Line: 1005 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = PathWaypoint.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local v6 = v1 + 8
    local v7 = Vector3.new(v3, v5, (buffer.readf32(v2, v6)))
    local PathWaypointAction = Enum.PathWaypointAction
    v6 = v1 + 12
    local v8 = new(v7, (PathWaypointAction:FromValue((buffer.readu8(v2, v6)))))
    u24 = v1 + 13
    return v8
end

u37[89] = function(a1) -- Line: 1017 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1 = u5 + 9
    if u6 < v1 then
        v1 = u5 + 9
        local v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v1 = u5
    local v3 = u4
    local Time = a1.Time
    buffer.writef32(v3, v1, Time)
    v3 = u4
    local v4 = v1 + 4
    local Value = a1.Value
    buffer.writef32(v3, v4, Value)
    v3 = u4
    v4 = v1 + 8
    local Value_2 = a1.Interpolation.Value
    buffer.writeu8(v3, v4, Value_2)
    u5 = v1 + 9
end

u38[89] = function() -- Line: 1026 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = FloatCurveKey.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = buffer.readf32(v2, v4)
    local KeyInterpolationMode = Enum.KeyInterpolationMode
    local v6 = v1 + 8
    local v7 = new(v3, v5, (KeyInterpolationMode:FromValue((buffer.readu8(v2, v6)))))
    u24 = v1 + 9
    return v7
end

u37[90] = function(a1) -- Line: 1039 -- upvalues: u5 (ref), u6 (ref), u4 (ref), u37 (val)
    local v1
    local Time = a1.Time
    local v2 = u5 + 4
    if u6 < v2 then
        v2 = u5 + 4
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    local v3 = u5
    buffer.writef32(u4, v3, Time)
    u5 = u5 + 4
    u37[66](a1.Value)
    local Value = a1.Interpolation.Value
    v2 = u5 + 1
    if u6 < v2 then
        v2 = u5 + 1
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v3 = u5
    buffer.writeu8(u4, v3, Value)
    u5 = u5 + 1
end

u38[90] = function() -- Line: 1045 -- upvalues: u23 (ref), u24 (ref), u38 (val)
    local v1 = u24
    local v2 = buffer.readf32(u23, v1)
    u24 = u24 + 4
    local v3 = u38[66]()
    local KeyInterpolationMode = Enum.KeyInterpolationMode
    local v4 = u24
    local v5 = buffer.readu8(u23, v4)
    u24 = u24 + 1
    return RotationCurveKey.new(v2, v3, (KeyInterpolationMode:FromValue(v5)))
end

u37[91] = function(a1) -- Line: 1053 -- upvalues: u5 (ref), u6 (ref), u4 (ref)
    local v1
    local v2 = u5 + 48
    if u6 < v2 then
        v2 = u5 + 48
        v1 = u6
        repeat
            v1 = v1 * 2
        until v2 <= v1
        v2 = buffer.create(v1)
        buffer.copy(v2, 0, u4, 0, u5)
        u4 = v2
        u6 = v1
    end
    v2 = u5
    v1 = u4
    local Position = a1.Position
    local LeftTangent = a1.LeftTangent
    local RightTangent = a1.RightTangent
    local Scale = Position.X.Scale
    buffer.writef32(v1, v2, Scale)
    local v3 = v2 + 4
    local Offset = Position.X.Offset
    buffer.writei32(v1, v3, Offset)
    v3 = v2 + 8
    local Scale_2 = Position.Y.Scale
    buffer.writef32(v1, v3, Scale_2)
    v3 = v2 + 12
    local Offset_2 = Position.Y.Offset
    buffer.writei32(v1, v3, Offset_2)
    v3 = v2 + 16
    local Scale_3 = LeftTangent.X.Scale
    buffer.writef32(v1, v3, Scale_3)
    v3 = v2 + 20
    local Offset_3 = LeftTangent.X.Offset
    buffer.writei32(v1, v3, Offset_3)
    v3 = v2 + 24
    local Scale_4 = LeftTangent.Y.Scale
    buffer.writef32(v1, v3, Scale_4)
    v3 = v2 + 28
    local Offset_4 = LeftTangent.Y.Offset
    buffer.writei32(v1, v3, Offset_4)
    v3 = v2 + 32
    local Scale_5 = RightTangent.X.Scale
    buffer.writef32(v1, v3, Scale_5)
    v3 = v2 + 36
    local Offset_5 = RightTangent.X.Offset
    buffer.writei32(v1, v3, Offset_5)
    v3 = v2 + 40
    local Scale_6 = RightTangent.Y.Scale
    buffer.writef32(v1, v3, Scale_6)
    v3 = v2 + 44
    local Offset_6 = RightTangent.Y.Offset
    buffer.writei32(v1, v3, Offset_6)
    u5 = v2 + 48
end

u38[91] = function() -- Line: 1075 -- upvalues: u24 (ref), u23 (ref)
    local v1 = u24
    local v2 = u23
    local new = Path2DControlPoint.new
    local new_2 = UDim2.new
    local new_3 = UDim.new
    local v3 = buffer.readf32(v2, v1)
    local v4 = v1 + 4
    local v5 = new_3(v3, (buffer.readi32(v2, v4)))
    local new_4 = UDim.new
    v4 = v1 + 8
    local v6 = buffer.readf32(v2, v4)
    local v7 = v1 + 12
    local v8 = new_2(v5, new_4(v6, (buffer.readi32(v2, v7))))
    local new_5 = UDim2.new
    local new_6 = UDim.new
    v4 = v1 + 16
    v6 = buffer.readf32(v2, v4)
    v7 = v1 + 20
    v3 = new_6(v6, (buffer.readi32(v2, v7)))
    local new_7 = UDim.new
    v7 = v1 + 24
    local v9 = buffer.readf32(v2, v7)
    local v10 = v1 + 28
    v5 = new_5(v3, new_7(v9, (buffer.readi32(v2, v10))))
    local new_8 = UDim2.new
    local new_9 = UDim.new
    v7 = v1 + 32
    v9 = buffer.readf32(v2, v7)
    v10 = v1 + 36
    v6 = new_9(v9, (buffer.readi32(v2, v10)))
    local new_10 = UDim.new
    v10 = v1 + 40
    v4 = buffer.readf32(v2, v10)
    local v11 = v1 + 44
    local v12 = new(v8, v5, new_8(v6, new_10(v4, (buffer.readi32(v2, v11)))))
    u24 = v1 + 48
    return v12
end

u38[16] = function() -- Line: 1096
    return {}
end

u38[17] = function() -- Line: 1100 -- upvalues: u23 (ref), u24 (ref), u36 (ref)
    local v1 = u24
    local v2 = buffer.readu32(u23, v1)
    u24 = u24 + 4
    local v3 = table.create(v2)
    for i = 1, v2 do
        v3[i] = (u36())
    end
    return v3
end

u38[21] = function() -- Line: 1109 -- upvalues: u23 (ref), u24 (ref), u36 (ref)
    local v1
    local v2 = {}
    while true do
        v1 = u24
        if buffer.readu8(u23, v1) == 255 then
            break
        end
        v2[u36()] = (u36())
    end
    u24 = u24 + 1
    return v2
end

local function u129(a1) -- Line: 1122
    -- upvalues: u5 (ref), u6 (ref), u4 (ref), u35 (ref), u19 (ref), u1 (val), u37 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = typeof(a1)
    if v10 == "number" then
        v4 = u5 + 9
        if u6 < v4 then
            v4 = u5 + 9
            v5 = u6
            repeat
                v5 = v5 * 2
            until v4 <= v5
            v4 = buffer.create(v5)
            buffer.copy(v4, 0, u4, 0, u5)
            u4 = v4
            u6 = v5
        end
        v6 = u5
        buffer.writeu8(u4, v6, 9)
        v5 = u4
        v6 = u5 + 1
        buffer.writef64(v5, v6, a1)
        u5 = u5 + 9
        return
    end
    if v10 == "string" then
        v4 = #a1
        v5 = u5 + 5 + v4
        if u6 < v5 then
            v5 = v4 + 5
            v6 = u5 + v5
            v7 = u6
            repeat
                v7 = v7 * 2
            until v6 <= v7
            v6 = buffer.create(v7)
            buffer.copy(v6, 0, u4, 0, u5)
            u4 = v6
            u6 = v7
        end
        v7 = u5
        buffer.writeu8(u4, v7, 12)
        v6 = u4
        v7 = u5 + 1
        buffer.writeu32(v6, v7, v4)
        buffer.writestring(u4, u5 + 5, a1)
        u5 = u5 + (v4 + 5)
        return
    end
    if v10 == "boolean" then
        v4 = u5 + 1
        if u6 < v4 then
            v4 = u5 + 1
            v5 = u6
            repeat
                v5 = v5 * 2
            until v4 <= v5
            v4 = buffer.create(v5)
            buffer.copy(v4, 0, u4, 0, u5)
            u4 = v4
            u6 = v5
        end
        v7 = if not a1 then 1 else 2
        buffer.writeu8(u4, u5, v7)
        u5 = u5 + 1
        return
    end
    if v10 ~= "table" then
        if v10 == "buffer" then
            v4 = buffer.len(a1)
            v5 = u5 + 5 + v4
            if u6 < v5 then
                v5 = 5 + v4
                v6 = u5 + v5
                v7 = u6
                repeat
                    v7 = v7 * 2
                until v6 <= v7
                v6 = buffer.create(v7)
                buffer.copy(v6, 0, u4, 0, u5)
                u4 = v6
                u6 = v7
            end
            v7 = u5
            buffer.writeu8(u4, v7, 13)
            v6 = u4
            v7 = u5 + 1
            buffer.writeu32(v6, v7, v4)
            buffer.copy(u4, u5 + 5, a1, 0, v4)
            u5 = u5 + (5 + v4)
            return
        end
        if a1 == nil then
            v4 = u5 + 1
            if u6 < v4 then
                v4 = u5 + 1
                v5 = u6
                repeat
                    v5 = v5 * 2
                until v4 <= v5
                v4 = buffer.create(v5)
                buffer.copy(v4, 0, u4, 0, u5)
                u4 = v4
                u6 = v5
            end
            v6 = u5
            buffer.writeu8(u4, v6, 0)
            u5 = u5 + 1
            return
        end
        if v10 == "Instance" then
            if not u19 then
                error("Buff: Instance serialization requires enableInstances=true in encode()")
            end
            table.insert(u19, a1)
            v4 = u5 + 5
            if u6 < v4 then
                v4 = u5 + 5
                v5 = u6
                repeat
                    v5 = v5 * 2
                until v4 <= v5
                v4 = buffer.create(v5)
                buffer.copy(v4, 0, u4, 0, u5)
                u4 = v4
                u6 = v5
            end
            v6 = u5
            buffer.writeu8(u4, v6, 92)
            v5 = u4
            v6 = u5 + 1
            v7 = #u19
            buffer.writeu32(v5, v6, v7)
            u5 = u5 + 5
            return
        end
        v4 = u1[v10]
        if not v4 then
            error((("Buff: unsupported type \"%*\""):format(v10)))
        end
        v5 = u5 + 1
        if u6 < v5 then
            v5 = u5 + 1
            v6 = u6
            repeat
                v6 = v6 * 2
            until v5 <= v6
            v5 = buffer.create(v6)
            buffer.copy(v5, 0, u4, 0, u5)
            u4 = v5
            u6 = v6
        end
        v7 = u5
        buffer.writeu8(u4, v7, v4)
        u5 = u5 + 1
        u37[v4](a1)
        return
    end
    v4 = #a1
    if v4 > 0 and next(a1, v4) == nil then
        local v11, v12
        v5 = u5 + 5
        if u6 < v5 then
            v5 = u5 + 5
            v6 = u6
            repeat
                v6 = v6 * 2
            until v5 <= v6
            v5 = buffer.create(v6)
            buffer.copy(v5, 0, u4, 0, u5)
            u4 = v5
            u6 = v6
        end
        v7 = u5
        buffer.writeu8(u4, v7, 17)
        v6 = u4
        v7 = u5 + 1
        buffer.writeu32(v6, v7, v4)
        u5 = u5 + 5
        for i = 1, v4 do
            v11 = a1[i]
            v12 = type(v11)
            if v12 == "number" then
                v8 = u5 + 9
                if u6 < v8 then
                    v8 = u5 + 9
                    v9 = u6
                    repeat
                        v9 = v9 * 2
                    until v8 <= v9
                    v8 = buffer.create(v9)
                    buffer.copy(v8, 0, u4, 0, u5)
                    u4 = v8
                    u6 = v9
                end
                v1 = u5
                buffer.writeu8(u4, v1, 9)
                v9 = u4
                v1 = u5 + 1
                buffer.writef64(v9, v1, v11)
                u5 = u5 + 9
            elseif v12 == "string" then
                v8 = #v11
                v9 = u5 + 5 + v8
                if u6 < v9 then
                    v9 = v8 + 5
                    v1 = u5 + v9
                    v2 = u6
                    repeat
                        v2 = v2 * 2
                    until v1 <= v2
                    v1 = buffer.create(v2)
                    buffer.copy(v1, 0, u4, 0, u5)
                    u4 = v1
                    u6 = v2
                end
                v2 = u5
                buffer.writeu8(u4, v2, 12)
                v1 = u4
                v2 = u5 + 1
                buffer.writeu32(v1, v2, v8)
                buffer.writestring(u4, u5 + 5, v11)
                u5 = u5 + (v8 + 5)
            elseif v12 ~= "boolean" then
                u35(v11)
            else
                v8 = u5 + 1
                if u6 < v8 then
                    v8 = u5 + 1
                    v9 = u6
                    repeat
                        v9 = v9 * 2
                    until v8 <= v9
                    v8 = buffer.create(v9)
                    buffer.copy(v8, 0, u4, 0, u5)
                    u4 = v8
                    u6 = v9
                end
                v2 = if not v11 then 1 else 2
                buffer.writeu8(u4, u5, v2)
                u5 = u5 + 1
            end
        end
        return
    end
    if v4 == 0 and next(a1) == nil then
        v5 = u5 + 1
        if u6 < v5 then
            v5 = u5 + 1
            v6 = u6
            repeat
                v6 = v6 * 2
            until v5 <= v6
            v5 = buffer.create(v6)
            buffer.copy(v5, 0, u4, 0, u5)
            u4 = v5
            u6 = v6
        end
        v7 = u5
        buffer.writeu8(u4, v7, 16)
        u5 = u5 + 1
        return
    end
    v5 = u5 + 1
    if u6 < v5 then
        v5 = u5 + 1
        v6 = u6
        repeat
            v6 = v6 * 2
        until v5 <= v6
        v5 = buffer.create(v6)
        buffer.copy(v5, 0, u4, 0, u5)
        u4 = v5
        u6 = v6
    end
    v7 = u5
    buffer.writeu8(u4, v7, 21)
    u5 = u5 + 1
    v6 = nil
    v7 = nil
    for j, k in a1, v6, v7 do
        v8 = type(j)
        if v8 == "number" then
            v9 = u5 + 9
            if u6 < v9 then
                v9 = u5 + 9
                v1 = u6
                repeat
                    v1 = v1 * 2
                until v9 <= v1
                v9 = buffer.create(v1)
                buffer.copy(v9, 0, u4, 0, u5)
                u4 = v9
                u6 = v1
            end
            v2 = u5
            buffer.writeu8(u4, v2, 9)
            v1 = u4
            v2 = u5 + 1
            buffer.writef64(v1, v2, j)
            u5 = u5 + 9
        elseif v8 ~= "string" then
            u35(j)
        else
            v9 = #j
            v1 = u5 + 5 + v9
            if u6 < v1 then
                v1 = v9 + 5
                v2 = u5 + v1
                v3 = u6
                repeat
                    v3 = v3 * 2
                until v2 <= v3
                v2 = buffer.create(v3)
                buffer.copy(v2, 0, u4, 0, u5)
                u4 = v2
                u6 = v3
            end
            v3 = u5
            buffer.writeu8(u4, v3, 12)
            v2 = u4
            v3 = u5 + 1
            buffer.writeu32(v2, v3, v9)
            buffer.writestring(u4, u5 + 5, j)
            u5 = u5 + (v9 + 5)
        end
        v8 = type(k)
        if v8 == "number" then
            v9 = u5 + 9
            if u6 < v9 then
                v9 = u5 + 9
                v1 = u6
                repeat
                    v1 = v1 * 2
                until v9 <= v1
                v9 = buffer.create(v1)
                buffer.copy(v9, 0, u4, 0, u5)
                u4 = v9
                u6 = v1
            end
            v2 = u5
            buffer.writeu8(u4, v2, 9)
            v1 = u4
            v2 = u5 + 1
            buffer.writef64(v1, v2, k)
            u5 = u5 + 9
        elseif v8 == "string" then
            v9 = #k
            v1 = u5 + 5 + v9
            if u6 < v1 then
                v1 = v9 + 5
                v2 = u5 + v1
                v3 = u6
                repeat
                    v3 = v3 * 2
                until v2 <= v3
                v2 = buffer.create(v3)
                buffer.copy(v2, 0, u4, 0, u5)
                u4 = v2
                u6 = v3
            end
            v3 = u5
            buffer.writeu8(u4, v3, 12)
            v2 = u4
            v3 = u5 + 1
            buffer.writeu32(v2, v3, v9)
            buffer.writestring(u4, u5 + 5, k)
            u5 = u5 + (v9 + 5)
        elseif v8 ~= "boolean" then
            u35(k)
        else
            v9 = u5 + 1
            if u6 < v9 then
                v9 = u5 + 1
                v1 = u6
                repeat
                    v1 = v1 * 2
                until v9 <= v1
                v9 = buffer.create(v1)
                buffer.copy(v9, 0, u4, 0, u5)
                u4 = v9
                u6 = v1
            end
            v3 = if not k then 1 else 2
            buffer.writeu8(u4, u5, v3)
            u5 = u5 + 1
        end
    end
    v5 = u5 + 1
    if u6 < v5 then
        v5 = u5 + 1
        v6 = u6
        repeat
            v6 = v6 * 2
        until v5 <= v6
        v5 = buffer.create(v6)
        buffer.copy(v5, 0, u4, 0, u5)
        u4 = v5
        u6 = v6
    end
    v7 = u5
    buffer.writeu8(u4, v7, 255)
    u5 = u5 + 1
end

local function u130(a1) -- Line: 1290
    -- upvalues: u5 (ref), u6 (ref), u4 (ref), u35 (ref), u19 (ref), u1 (val), u37 (val)
    local v1, v2, v3, v4
    local v5 = typeof(a1)
    if v5 == "number" then
        if a1 == a1 and a1 % 1 == 0 then
            if a1 >= 0 then
                if a1 <= 255 then
                    v1 = u5 + 2
                    if u6 < v1 then
                        v1 = u5 + 2
                        v2 = u6
                        repeat
                            v2 = v2 * 2
                        until v1 <= v2
                        v1 = buffer.create(v2)
                        buffer.copy(v1, 0, u4, 0, u5)
                        u4 = v1
                        u6 = v2
                    end
                    v3 = u5
                    buffer.writeu8(u4, v3, 3)
                    v2 = u4
                    v3 = u5 + 1
                    buffer.writeu8(v2, v3, a1)
                    u5 = u5 + 2
                    return
                end
                if a1 <= 65535 then
                    v1 = u5 + 3
                    if u6 < v1 then
                        v1 = u5 + 3
                        v2 = u6
                        repeat
                            v2 = v2 * 2
                        until v1 <= v2
                        v1 = buffer.create(v2)
                        buffer.copy(v1, 0, u4, 0, u5)
                        u4 = v1
                        u6 = v2
                    end
                    v3 = u5
                    buffer.writeu8(u4, v3, 4)
                    v2 = u4
                    v3 = u5 + 1
                    buffer.writeu16(v2, v3, a1)
                    u5 = u5 + 3
                    return
                end
                if a1 <= 4294967295 then
                    v1 = u5 + 5
                    if u6 < v1 then
                        v1 = u5 + 5
                        v2 = u6
                        repeat
                            v2 = v2 * 2
                        until v1 <= v2
                        v1 = buffer.create(v2)
                        buffer.copy(v1, 0, u4, 0, u5)
                        u4 = v1
                        u6 = v2
                    end
                    v3 = u5
                    buffer.writeu8(u4, v3, 5)
                    v2 = u4
                    v3 = u5 + 1
                    buffer.writeu32(v2, v3, a1)
                    u5 = u5 + 5
                    return
                end
                v1 = u5 + 9
                if u6 < v1 then
                    v1 = u5 + 9
                    v2 = u6
                    repeat
                        v2 = v2 * 2
                    until v1 <= v2
                    v1 = buffer.create(v2)
                    buffer.copy(v1, 0, u4, 0, u5)
                    u4 = v1
                    u6 = v2
                end
                v3 = u5
                buffer.writeu8(u4, v3, 9)
                v2 = u4
                v3 = u5 + 1
                buffer.writef64(v2, v3, a1)
                u5 = u5 + 9
                return
            end
            if a1 >= -128 then
                v1 = u5 + 2
                if u6 < v1 then
                    v1 = u5 + 2
                    v2 = u6
                    repeat
                        v2 = v2 * 2
                    until v1 <= v2
                    v1 = buffer.create(v2)
                    buffer.copy(v1, 0, u4, 0, u5)
                    u4 = v1
                    u6 = v2
                end
                v3 = u5
                buffer.writeu8(u4, v3, 6)
                v2 = u4
                v3 = u5 + 1
                buffer.writei8(v2, v3, a1)
                u5 = u5 + 2
                return
            end
            if a1 >= -32768 then
                v1 = u5 + 3
                if u6 < v1 then
                    v1 = u5 + 3
                    v2 = u6
                    repeat
                        v2 = v2 * 2
                    until v1 <= v2
                    v1 = buffer.create(v2)
                    buffer.copy(v1, 0, u4, 0, u5)
                    u4 = v1
                    u6 = v2
                end
                v3 = u5
                buffer.writeu8(u4, v3, 7)
                v2 = u4
                v3 = u5 + 1
                buffer.writei16(v2, v3, a1)
                u5 = u5 + 3
                return
            end
            if a1 >= -2147483648 then
                v1 = u5 + 5
                if u6 < v1 then
                    v1 = u5 + 5
                    v2 = u6
                    repeat
                        v2 = v2 * 2
                    until v1 <= v2
                    v1 = buffer.create(v2)
                    buffer.copy(v1, 0, u4, 0, u5)
                    u4 = v1
                    u6 = v2
                end
                v3 = u5
                buffer.writeu8(u4, v3, 8)
                v2 = u4
                v3 = u5 + 1
                buffer.writei32(v2, v3, a1)
                u5 = u5 + 5
                return
            end
            v1 = u5 + 9
            if u6 < v1 then
                v1 = u5 + 9
                v2 = u6
                repeat
                    v2 = v2 * 2
                until v1 <= v2
                v1 = buffer.create(v2)
                buffer.copy(v1, 0, u4, 0, u5)
                u4 = v1
                u6 = v2
            end
            v3 = u5
            buffer.writeu8(u4, v3, 9)
            v2 = u4
            v3 = u5 + 1
            buffer.writef64(v2, v3, a1)
            u5 = u5 + 9
            return
        end
        v1 = u5 + 9
        if u6 < v1 then
            v1 = u5 + 9
            v2 = u6
            repeat
                v2 = v2 * 2
            until v1 <= v2
            v1 = buffer.create(v2)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v2
        end
        v3 = u5
        buffer.writeu8(u4, v3, 9)
        v2 = u4
        v3 = u5 + 1
        buffer.writef64(v2, v3, a1)
        u5 = u5 + 9
        return
    end
    if v5 == "string" then
        v1 = #a1
        if v1 <= 255 then
            v2 = u5 + 2 + v1
            if u6 < v2 then
                v2 = v1 + 2
                v3 = u5 + v2
                v4 = u6
                repeat
                    v4 = v4 * 2
                until v3 <= v4
                v3 = buffer.create(v4)
                buffer.copy(v3, 0, u4, 0, u5)
                u4 = v3
                u6 = v4
            end
            v4 = u5
            buffer.writeu8(u4, v4, 10)
            v3 = u4
            v4 = u5 + 1
            buffer.writeu8(v3, v4, v1)
            buffer.writestring(u4, u5 + 2, a1)
            u5 = u5 + (v1 + 2)
            return
        end
        if v1 <= 65535 then
            v2 = u5 + 3 + v1
            if u6 < v2 then
                v2 = v1 + 3
                v3 = u5 + v2
                v4 = u6
                repeat
                    v4 = v4 * 2
                until v3 <= v4
                v3 = buffer.create(v4)
                buffer.copy(v3, 0, u4, 0, u5)
                u4 = v3
                u6 = v4
            end
            v4 = u5
            buffer.writeu8(u4, v4, 11)
            v3 = u4
            v4 = u5 + 1
            buffer.writeu16(v3, v4, v1)
            buffer.writestring(u4, u5 + 3, a1)
            u5 = u5 + (v1 + 3)
            return
        end
        v2 = u5 + 5 + v1
        if u6 < v2 then
            v2 = v1 + 5
            v3 = u5 + v2
            v4 = u6
            repeat
                v4 = v4 * 2
            until v3 <= v4
            v3 = buffer.create(v4)
            buffer.copy(v3, 0, u4, 0, u5)
            u4 = v3
            u6 = v4
        end
        v4 = u5
        buffer.writeu8(u4, v4, 12)
        v3 = u4
        v4 = u5 + 1
        buffer.writeu32(v3, v4, v1)
        buffer.writestring(u4, u5 + 5, a1)
        u5 = u5 + (v1 + 5)
        return
    end
    if v5 == "boolean" then
        v1 = u5 + 1
        if u6 < v1 then
            v1 = u5 + 1
            v2 = u6
            repeat
                v2 = v2 * 2
            until v1 <= v2
            v1 = buffer.create(v2)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v2
        end
        v4 = if not a1 then 1 else 2
        buffer.writeu8(u4, u5, v4)
        u5 = u5 + 1
        return
    end
    if v5 == "table" then
        v1 = #a1
        if v1 > 0 and next(a1, v1) == nil then
            v2 = u5 + 5
            if u6 < v2 then
                v2 = u5 + 5
                v3 = u6
                repeat
                    v3 = v3 * 2
                until v2 <= v3
                v2 = buffer.create(v3)
                buffer.copy(v2, 0, u4, 0, u5)
                u4 = v2
                u6 = v3
            end
            v4 = u5
            buffer.writeu8(u4, v4, 17)
            v3 = u4
            v4 = u5 + 1
            buffer.writeu32(v3, v4, v1)
            u5 = u5 + 5
            for i = 1, v1 do
                u35(a1[i])
            end
            return
        end
        if v1 == 0 and next(a1) == nil then
            v2 = u5 + 1
            if u6 < v2 then
                v2 = u5 + 1
                v3 = u6
                repeat
                    v3 = v3 * 2
                until v2 <= v3
                v2 = buffer.create(v3)
                buffer.copy(v2, 0, u4, 0, u5)
                u4 = v2
                u6 = v3
            end
            v4 = u5
            buffer.writeu8(u4, v4, 16)
            u5 = u5 + 1
            return
        end
        v2 = u5 + 1
        if u6 < v2 then
            v2 = u5 + 1
            v3 = u6
            repeat
                v3 = v3 * 2
            until v2 <= v3
            v2 = buffer.create(v3)
            buffer.copy(v2, 0, u4, 0, u5)
            u4 = v2
            u6 = v3
        end
        v4 = u5
        buffer.writeu8(u4, v4, 21)
        u5 = u5 + 1
        v3 = nil
        for j, k in a1, v3 do
            u35(j)
            u35(k)
        end
        v2 = u5 + 1
        if u6 < v2 then
            v2 = u5 + 1
            v3 = u6
            repeat
                v3 = v3 * 2
            until v2 <= v3
            v2 = buffer.create(v3)
            buffer.copy(v2, 0, u4, 0, u5)
            u4 = v2
            u6 = v3
        end
        v4 = u5
        buffer.writeu8(u4, v4, 255)
        u5 = u5 + 1
        return
    end
    if v5 == "buffer" then
        v1 = buffer.len(a1)
        v2 = u5 + 5 + v1
        if u6 < v2 then
            v2 = 5 + v1
            v3 = u5 + v2
            v4 = u6
            repeat
                v4 = v4 * 2
            until v3 <= v4
            v3 = buffer.create(v4)
            buffer.copy(v3, 0, u4, 0, u5)
            u4 = v3
            u6 = v4
        end
        v4 = u5
        buffer.writeu8(u4, v4, 13)
        v3 = u4
        v4 = u5 + 1
        buffer.writeu32(v3, v4, v1)
        buffer.copy(u4, u5 + 5, a1, 0, v1)
        u5 = u5 + (5 + v1)
        return
    end
    if a1 == nil then
        v1 = u5 + 1
        if u6 < v1 then
            v1 = u5 + 1
            v2 = u6
            repeat
                v2 = v2 * 2
            until v1 <= v2
            v1 = buffer.create(v2)
            buffer.copy(v1, 0, u4, 0, u5)
            u4 = v1
            u6 = v2
        end
        v3 = u5
        buffer.writeu8(u4, v3, 0)
        u5 = u5 + 1
        return
    end
    if v5 ~= "Instance" then
        v1 = u1[v5]
        if not v1 then
            error((("Buff: unsupported type \"%*\""):format(v5)))
        end
        v2 = u5 + 1
        if u6 < v2 then
            v2 = u5 + 1
            v3 = u6
            repeat
                v3 = v3 * 2
            until v2 <= v3
            v2 = buffer.create(v3)
            buffer.copy(v2, 0, u4, 0, u5)
            u4 = v2
            u6 = v3
        end
        v4 = u5
        buffer.writeu8(u4, v4, v1)
        u5 = u5 + 1
        u37[v1](a1)
        return
    end
    if not u19 then
        error("Buff: Instance serialization requires enableInstances=true in encode()")
    end
    table.insert(u19, a1)
    v1 = u5 + 5
    if u6 < v1 then
        v1 = u5 + 5
        v2 = u6
        repeat
            v2 = v2 * 2
        until v1 <= v2
        v1 = buffer.create(v2)
        buffer.copy(v1, 0, u4, 0, u5)
        u4 = v1
        u6 = v2
    end
    v3 = u5
    buffer.writeu8(u4, v3, 92)
    v2 = u4
    v3 = u5 + 1
    v4 = #u19
    buffer.writeu32(v2, v3, v4)
    u5 = u5 + 5
end

u35 = u129

function u36() -- Line: 1466 -- upvalues: u23 (ref), u24 (ref), u38 (val)
    local v1 = u24
    local v2 = buffer.readu8(u23, v1)
    u24 = u24 + 1
    local v3 = u38[v2]
    if not v3 then
        error((("Buff: unknown type tag %* at offset %*"):format(v2, u24 - 1)))
    end
    return v3()
end

function v1.encode(a1, a2, a3) -- Line: 1476
    -- upvalues: u5 (ref), u19 (ref), u35 (ref), u130 (ref), u129 (ref), u4 (ref)
    u5 = 0
    u19 = if not a3 then nil else {}
    u35 = if a2 ~= "size" then u129 else u130
    u35(a1)
    local v1 = buffer.create(u5)
    buffer.copy(v1, 0, u4, 0, u5)
    local v2 = u19
    u19 = nil
    local v3 = v1
    if v2 and #v2 > 0 then
        return v3, v2
    end
    return v3, nil
end

function v1.decode(a1, a2) -- Line: 1488
    -- upvalues: u23 (ref), u24 (ref), u20 (ref), u36 (ref)
    u23 = a1
    u24 = 0
    u20 = a2
    local v1 = u36()
    u20 = nil
    return v1
end

function v1.analyze(a1) -- Line: 1497 -- types: a1: buffer
    local walk
    local u1 = 0
    local v1 = buffer.len(a1)
    local u5 = {}
    local u6 = {}

    local function record(a1, a2) -- Line: 1503 -- upvalues: u5 (val), u6 (val) -- types: a1: string, a2: number
        u5[a1] = (u5[a1] or 0) + 1
        u6[a1] = (u6[a1] or 0) + a2
    end

    function walk() -- Line: 1508 -- upvalues: a1 (val), u1 (ref), u5 (val), u6 (val), walk (val)
        local v1 = u1
        local v2 = buffer.readu8(a1, v1)
        u1 = u1 + 1
        if v2 == 0 then
            u5["nil"] = (u5["nil"] or 0) + 1
            u6["nil"] = (u6["nil"] or 0) + 1
            return
        end
        if v2 ~= 1 and v2 ~= 2 then
            local v3, v4
            if v2 == 3 then
                u5["number (u8)"] = (u5["number (u8)"] or 0) + 1
                u6["number (u8)"] = (u6["number (u8)"] or 0) + 2
                u1 = u1 + 1
                return
            end
            if v2 == 4 then
                u5["number (u16)"] = (u5["number (u16)"] or 0) + 1
                u6["number (u16)"] = (u6["number (u16)"] or 0) + 3
                u1 = u1 + 2
                return
            end
            if v2 == 5 then
                u5["number (u32)"] = (u5["number (u32)"] or 0) + 1
                u6["number (u32)"] = (u6["number (u32)"] or 0) + 5
                u1 = u1 + 4
                return
            end
            if v2 == 6 then
                u5["number (i8)"] = (u5["number (i8)"] or 0) + 1
                u6["number (i8)"] = (u6["number (i8)"] or 0) + 2
                u1 = u1 + 1
                return
            end
            if v2 == 7 then
                u5["number (i16)"] = (u5["number (i16)"] or 0) + 1
                u6["number (i16)"] = (u6["number (i16)"] or 0) + 3
                u1 = u1 + 2
                return
            end
            if v2 == 8 then
                u5["number (i32)"] = (u5["number (i32)"] or 0) + 1
                u6["number (i32)"] = (u6["number (i32)"] or 0) + 5
                u1 = u1 + 4
                return
            end
            if v2 == 9 then
                u5["number (f64)"] = (u5["number (f64)"] or 0) + 1
                u6["number (f64)"] = (u6["number (f64)"] or 0) + 9
                u1 = u1 + 8
                return
            end
            if v2 == 10 then
                v4 = u1
                v3 = buffer.readu8(a1, v4)
                u1 = u1 + (v3 + 1)
                v1 = v3 + 2
                u5["string (u8 hdr)"] = (u5["string (u8 hdr)"] or 0) + 1
                u6["string (u8 hdr)"] = (u6["string (u8 hdr)"] or 0) + v1
                return
            end
            if v2 == 11 then
                v4 = u1
                v3 = buffer.readu16(a1, v4)
                u1 = u1 + (v3 + 2)
                v1 = v3 + 3
                u5["string (u16 hdr)"] = (u5["string (u16 hdr)"] or 0) + 1
                u6["string (u16 hdr)"] = (u6["string (u16 hdr)"] or 0) + v1
                return
            end
            if v2 == 12 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 + 4)
                v1 = v3 + 5
                u5["string (u32 hdr)"] = (u5["string (u32 hdr)"] or 0) + 1
                u6["string (u32 hdr)"] = (u6["string (u32 hdr)"] or 0) + v1
                return
            end
            if v2 == 13 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 + 4)
                v1 = v3 + 5
                u5.buffer = (u5.buffer or 0) + 1
                u6.buffer = (u6.buffer or 0) + v1
                return
            end
            if v2 == 14 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 + 4)
                v1 = v3 + 5
                u5.Enum = (u5.Enum or 0) + 1
                u6.Enum = (u6.Enum or 0) + v1
                return
            end
            if v2 == 15 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 + 4 + 4)
                v1 = v3 + 9
                u5.EnumItem = (u5.EnumItem or 0) + 1
                u6.EnumItem = (u6.EnumItem or 0) + v1
                return
            end
            if v2 == 16 then
                u5["table (empty)"] = (u5["table (empty)"] or 0) + 1
                u6["table (empty)"] = (u6["table (empty)"] or 0) + 1
                return
            end
            if v2 == 17 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + 4
                u5["table (array hdr)"] = (u5["table (array hdr)"] or 0) + 1
                u6["table (array hdr)"] = (u6["table (array hdr)"] or 0) + 5
                for i = 1, v3 do
                    walk()
                end
                return
            end
            if v2 == 21 then
                u5["table (dict hdr)"] = (u5["table (dict hdr)"] or 0) + 1
                u6["table (dict hdr)"] = (u6["table (dict hdr)"] or 0) + 1
                while true do
                    v4 = u1
                    if buffer.readu8(a1, v4) == 255 then
                        break
                    end
                    walk()
                    walk()
                end
                u1 = u1 + 1
                u5["table (sentinel)"] = (u5["table (sentinel)"] or 0) + 1
                u6["table (sentinel)"] = (u6["table (sentinel)"] or 0) + 1
                return
            end
            if v2 == 64 then
                u5.Axes = (u5.Axes or 0) + 1
                u6.Axes = (u6.Axes or 0) + 2
                u1 = u1 + 1
                return
            end
            if v2 == 65 then
                u5.BrickColor = (u5.BrickColor or 0) + 1
                u6.BrickColor = (u6.BrickColor or 0) + 3
                u1 = u1 + 2
                return
            end
            if v2 == 66 then
                u5.CFrame = (u5.CFrame or 0) + 1
                u6.CFrame = (u6.CFrame or 0) + 49
                u1 = u1 + 48
                return
            end
            if v2 == 67 then
                u5.Color3 = (u5.Color3 or 0) + 1
                u6.Color3 = (u6.Color3 or 0) + 13
                u1 = u1 + 12
                return
            end
            if v2 == 68 then
                u5.ColorSeqKeypoint = (u5.ColorSeqKeypoint or 0) + 1
                u6.ColorSeqKeypoint = (u6.ColorSeqKeypoint or 0) + 17
                u1 = u1 + 16
                return
            end
            if v2 == 69 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 * 16 + 4)
                v1 = v3 * 16 + 5
                u5.ColorSequence = (u5.ColorSequence or 0) + 1
                u6.ColorSequence = (u6.ColorSequence or 0) + v1
                return
            end
            if v2 == 70 then
                u5.DateTime = (u5.DateTime or 0) + 1
                u6.DateTime = (u6.DateTime or 0) + 9
                u1 = u1 + 8
                return
            end
            if v2 == 71 then
                u5.Faces = (u5.Faces or 0) + 1
                u6.Faces = (u6.Faces or 0) + 2
                u1 = u1 + 1
                return
            end
            if v2 == 72 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 + 4 + 8)
                v1 = v3 + 13
                u5.Font = (u5.Font or 0) + 1
                u6.Font = (u6.Font or 0) + v1
                return
            end
            if v2 == 73 then
                u5.NumberRange = (u5.NumberRange or 0) + 1
                u6.NumberRange = (u6.NumberRange or 0) + 9
                u1 = u1 + 8
                return
            end
            if v2 == 74 then
                u5.NumSeqKeypoint = (u5.NumSeqKeypoint or 0) + 1
                u6.NumSeqKeypoint = (u6.NumSeqKeypoint or 0) + 13
                u1 = u1 + 12
                return
            end
            if v2 == 75 then
                v4 = u1
                v3 = buffer.readu32(a1, v4)
                u1 = u1 + (v3 * 12 + 4)
                v1 = v3 * 12 + 5
                u5.NumberSequence = (u5.NumberSequence or 0) + 1
                u6.NumberSequence = (u6.NumberSequence or 0) + v1
                return
            end
            if v2 == 76 then
                u5.PhysicalProperties = (u5.PhysicalProperties or 0) + 1
                u6.PhysicalProperties = (u6.PhysicalProperties or 0) + 21
                u1 = u1 + 20
                return
            end
            if v2 == 77 then
                u5.Ray = (u5.Ray or 0) + 1
                u6.Ray = (u6.Ray or 0) + 25
                u1 = u1 + 24
                return
            end
            if v2 == 78 then
                u5.Rect = (u5.Rect or 0) + 1
                u6.Rect = (u6.Rect or 0) + 17
                u1 = u1 + 16
                return
            end
            if v2 == 79 then
                u5.Region3 = (u5.Region3 or 0) + 1
                u6.Region3 = (u6.Region3 or 0) + 25
                u1 = u1 + 24
                return
            end
            if v2 == 80 then
                u5.Region3int16 = (u5.Region3int16 or 0) + 1
                u6.Region3int16 = (u6.Region3int16 or 0) + 13
                u1 = u1 + 12
                return
            end
            if v2 == 81 then
                u5.TweenInfo = (u5.TweenInfo or 0) + 1
                u6.TweenInfo = (u6.TweenInfo or 0) + 22
                u1 = u1 + 21
                return
            end
            if v2 == 82 then
                u5.UDim = (u5.UDim or 0) + 1
                u6.UDim = (u6.UDim or 0) + 9
                u1 = u1 + 8
                return
            end
            if v2 == 83 then
                u5.UDim2 = (u5.UDim2 or 0) + 1
                u6.UDim2 = (u6.UDim2 or 0) + 17
                u1 = u1 + 16
                return
            end
            if v2 == 84 then
                u5.Vector2 = (u5.Vector2 or 0) + 1
                u6.Vector2 = (u6.Vector2 or 0) + 9
                u1 = u1 + 8
                return
            end
            if v2 == 85 then
                u5.Vector2int16 = (u5.Vector2int16 or 0) + 1
                u6.Vector2int16 = (u6.Vector2int16 or 0) + 5
                u1 = u1 + 4
                return
            end
            if v2 == 86 then
                u5.Vector3 = (u5.Vector3 or 0) + 1
                u6.Vector3 = (u6.Vector3 or 0) + 13
                u1 = u1 + 12
                return
            end
            if v2 == 87 then
                u5.Vector3int16 = (u5.Vector3int16 or 0) + 1
                u6.Vector3int16 = (u6.Vector3int16 or 0) + 7
                u1 = u1 + 6
                return
            end
            if v2 == 88 then
                u5.PathWaypoint = (u5.PathWaypoint or 0) + 1
                u6.PathWaypoint = (u6.PathWaypoint or 0) + 14
                u1 = u1 + 13
                return
            end
            if v2 == 89 then
                u5.FloatCurveKey = (u5.FloatCurveKey or 0) + 1
                u6.FloatCurveKey = (u6.FloatCurveKey or 0) + 10
                u1 = u1 + 9
                return
            end
            if v2 == 90 then
                u5.RotationCurveKey = (u5.RotationCurveKey or 0) + 1
                u6.RotationCurveKey = (u6.RotationCurveKey or 0) + 54
                u1 = u1 + 53
                return
            end
            if v2 == 91 then
                u5.Path2DControlPoint = (u5.Path2DControlPoint or 0) + 1
                u6.Path2DControlPoint = (u6.Path2DControlPoint or 0) + 49
                u1 = u1 + 48
                return
            end
            if v2 == 92 then
                u5.Instance = (u5.Instance or 0) + 1
                u6.Instance = (u6.Instance or 0) + 5
                u1 = u1 + 4
                return
            end
            v3 = ("unknown(%*)"):format(v2)
            u5[v3] = (u5[v3] or 0) + 1
            u6[v3] = (u6[v3] or 0) + 1
            return
        end
        u5.boolean = (u5.boolean or 0) + 1
        u6.boolean = (u6.boolean or 0) + 1
    end

    walk()
    local v2 = {}
    for i, j in u6 do
        table.insert(v2, {name = i, count = u5[i], bytes = j})
    end
    table.sort(v2, function(a1, a2) -- Line: 1679
        return a2.bytes < a1.bytes
    end)
    local v3 = {string.format("Total: %d bytes\n%-25s %8s %8s %6s", v1, "TYPE", "COUNT", "BYTES", "%")}
    table.insert(v3, (string.rep("-", 51)))
    for k, n in v2 do
        table.insert(v3, (string.format("%-25s %8d %8d %5.1f%%", n.name, n.count, n.bytes, n.bytes / v1 * 100)))
    end
    return (table.concat(v3, "\n"))
end

function v1.reset() -- Line: 1696 -- upvalues: u4 (ref), u6 (ref), u5 (ref)
    buffer.create(256)
    u6 = 256
    u5 = 0
end

return (table.freeze(v1))