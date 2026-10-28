-- Script path: ReplicatedStorage.UserGenerated.DataModel.Encode
-- Decompile time: 5.81 ms

local v1 = {}
local u1 = {}
u1.__index = u1

function v1.newWriter(a1) -- Line: 34 -- upvalues: u1 (val) -- types: a1: number?
    local v1 = a1 or 65536
    return (setmetatable({len = 0, buf = buffer.create(v1), cap = v1}, u1))
end

function u1:_ensure(a2) -- Line: 43 -- types: self: table, a2: number
    local v1 = self.len + a2
    if self.cap < v1 then
        local v2 = self.cap * 2
        while v2 < v1 do
            v2 = v2 * 2
        end
        local v3 = buffer.create(v2)
        buffer.copy(v3, 0, self.buf, 0, self.len)
        self.buf = v3
        self.cap = v2
    end
end

function u1:u8(a2) -- Line: 57 -- types: self: table, a2: number
    self:_ensure(1)
    local buf = self.buf
    local len = self.len
    buffer.writeu8(buf, len, a2)
    self.len = self.len + 1
end

function u1.u16(a1, a2) -- Line: 63 -- types: a1: table, a2: number
    a1:_ensure(2)
    local buf = a1.buf
    local len = a1.len
    buffer.writeu16(buf, len, a2)
    a1.len = a1.len + 2
end

function u1.u32(a1, a2) -- Line: 69 -- types: a1: table, a2: number
    a1:_ensure(4)
    local buf = a1.buf
    local len = a1.len
    buffer.writeu32(buf, len, a2)
    a1.len = a1.len + 4
end

function u1:f32(a2) -- Line: 75 -- types: self: table, a2: number
    self:_ensure(4)
    local buf = self.buf
    local len = self.len
    buffer.writef32(buf, len, a2)
    self.len = self.len + 4
end

function u1:f64(a2) -- Line: 81 -- types: self: table, a2: number
    self:_ensure(8)
    local buf = self.buf
    local len = self.len
    buffer.writef64(buf, len, a2)
    self.len = self.len + 8
end

function u1.strU8(a1, a2) -- Line: 88 -- types: a1: table, a2: string
    local v1 = #a2
    a1:_ensure(v1 + 1)
    local buf = a1.buf
    local len = a1.len
    buffer.writeu8(buf, len, v1)
    a1.len = a1.len + 1
    if v1 > 0 then
        buffer.writestring(a1.buf, a1.len, a2)
        a1.len = a1.len + v1
    end
end

function u1.strU16(a1, a2) -- Line: 100 -- types: a1: table, a2: string
    local v1 = #a2
    if v1 > 65535 then
        a2 = string.sub(a2, 1, 65535)
        v1 = 65535
    end
    a1:_ensure(v1 + 2)
    local buf = a1.buf
    local len = a1.len
    buffer.writeu16(buf, len, v1)
    a1.len = a1.len + 2
    if v1 > 0 then
        buffer.writestring(a1.buf, a1.len, a2)
        a1.len = a1.len + v1
    end
end

function u1:str32(a2) -- Line: 116 -- types: self: table, a2: string
    local v1 = #a2
    self:_ensure(v1 + 4)
    local buf = self.buf
    local len = self.len
    buffer.writeu32(buf, len, v1)
    self.len = self.len + 4
    if v1 > 0 then
        buffer.writestring(self.buf, self.len, a2)
        self.len = self.len + v1
    end
end

function u1.patchU16(a1, a2, a3) -- Line: 127 -- types: a1: table, a2: number, a3: number
    local buf = a1.buf
    buffer.writeu16(buf, a2, a3)
end

function u1.finish(a1) -- Line: 131
    local v1 = buffer.create(a1.len)
    buffer.copy(v1, 0, a1.buf, 0, a1.len)
    return v1
end

function v1.writeValue(a1, a2) -- Line: 140
    if a2 == nil then
        a1:u8(0)
        return
    end
    local v1 = typeof(a2)
    if v1 == "boolean" then
        a1:u8(if not a2 then 1 else 2)
        return
    end
    if v1 == "number" then
        a1:u8(3)
        a1:f64(a2)
        return
    end
    if v1 == "string" then
        a1:u8(4)
        a1:str32(a2)
        return
    end
    if v1 == "EnumItem" then
        a1:u8(5)
        a1:str32((tostring(a2)))
        return
    end
    if v1 == "Vector2" then
        a1:u8(6)
        a1:f32(a2.X)
        a1:f32(a2.Y)
        return
    end
    if v1 == "Vector3" then
        a1:u8(7)
        a1:f32(a2.X)
        a1:f32(a2.Y)
        a1:f32(a2.Z)
        return
    end
    if v1 == "Color3" then
        a1:u8(8)
        a1:u8((math.clamp(math.floor(a2.R * 255 + 0.5), 0, 255)))
        a1:u8((math.clamp(math.floor(a2.G * 255 + 0.5), 0, 255)))
        a1:u8((math.clamp(math.floor(a2.B * 255 + 0.5), 0, 255)))
        return
    end
    if v1 ~= "CFrame" then
        a1:u8(10)
        a1:str32((tostring(a2)))
        return
    end
    a1:u8(9)
    local Components_6, Components_7, Components_8, Components_9, Components_10, Components_11, Components_12, Components, Components_2, Components_3, Components_4, Components_5 = a2:GetComponents()
    a1:f32(Components_6)
    a1:f32(Components_7)
    a1:f32(Components_8)
    a1:f32(Components_9)
    a1:f32(Components_10)
    a1:f32(Components_11)
    a1:f32(Components_12)
    a1:f32(Components)
    a1:f32(Components_2)
    a1:f32(Components_3)
    a1:f32(Components_4)
    a1:f32(Components_5)
end

return v1