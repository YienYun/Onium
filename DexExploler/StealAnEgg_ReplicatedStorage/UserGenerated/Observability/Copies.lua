-- Script path: ReplicatedStorage.UserGenerated.Observability.Copies
-- Decompile time: 5.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local TemplateNext = Observability.TemplateNext
local u16 = {}
u16.__index = u16

function u16.new(a1) -- Line: 63 -- upvalues: u16 (val) -- types: a1: number
    return (setmetatable({
        PathCount = 0,
        NextKey = 1,
        TemplateCount = 0,
        LastAddId = 0,
        LastOffset = 0,
        ClassStride = a1 + 1,
        KeyOf = {},
        Paths = {},
        Templates = {},
    }, u16))
end

function u16.refValue(a1, a2) -- Line: 82 -- types: a1: number?, a2: number
    if a1 then
        return a1 - a2
    end
    return false
end

function u16.differs(a1, a2, a3, a4, a5, a6) -- Line: 89 -- types: a1: table?, a2: table?, a3: table?, a4: number
    if a2 then
        local v1 = a2[a4]
        a2[a4] = a6
        if a1 then
            return v1 ~= a6
        end
    end
    return not (a3 and a3[a4] == a5)
end

local function closest(a1, a2) -- Line: 110 -- types: a1: table, a2: table?
    local Values, v1
    local v2 = a1[#a1]
    if not a2 then
        return v2, -1
    end
    local v3 = (1 / 0)
    local v4, v5 = a1, a2
    for i = #a1, 1, -1 do
        Values = v4[i].Values
        v1 = 0
        for j, k in v5 do
            if Values[j] ~= k then
                v1 = v1 + 1
                if v3 <= v1 then
                    break
                end
            end
        end
        if v1 < v3 then
            v2 = v4[i]
            v3 = v1
            if v1 == 0 then
                break
            end
        end
    end
    return v2, v3
end

local function writeDrop(a1, a2) -- Line: 138 -- upvalues: Op (val), Codec (val) -- types: a2: table?
    a1:u8(Op.DropTemplates)
    if not a2 then
        Codec.varuint(a1, 0)
        return
    end
    Codec.varuint(a1, #a2)
    for i, j in a2 do
        Codec.varuint(a1, j.Id)
    end
end

function u16.WriteHead(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 156
    -- upvalues: Op (val), Codec (val), closest (val), TemplateNext (val), writeDrop (val)
    local v1
    local v2 = a1.KeyOf[a4] or -(a4 + 1)
    local v3 = v2 * a1.ClassStride + a5
    v2 = a1.Paths[v3]
    local NextKey = v2 and v2[a6]
    v2 = NextKey ~= nil
    if not NextKey then
        if 65536 <= a1.PathCount then
            if 0 < a1.TemplateCount then
                a2:u8(Op.DropTemplates)
                Codec.varuint(a2, 0)
            end
            table.clear(a1.Paths)
            table.clear(a1.Templates)
            a1.PathCount = 0
            a1.TemplateCount = 0
        end
        v1 = a1.Paths[v3]
        if not v1 then
            a1.Paths[v3] = {}
        end
        NextKey = a1.NextKey
        a1.NextKey = a1.NextKey + 1
        a1.PathCount = a1.PathCount + 1
        v1[a6] = NextKey
    end
    a1.KeyOf[a3] = NextKey
    v3 = if not a7 then nil else if not v2 then nil else a1.Templates[NextKey]
    if v3 and a4 < a3 then
        local v4
        v1, v4 = closest(v3, a8)
        local v5 = false
        if v4 > 0 then
            v5 = false
            if v1.ParentId == a4 then
                v5 = false
                if #v3 < 8 then
                    v5 = a1.TemplateCount < 8192
                end
            end
        end
        if v5 then
            a2:u8(Op.TemplateNext)
            a2:u8(TemplateNext.Keep)
        end
        v4 = a3 - v1.Id
        local v6 = v4 - a1.LastOffset
        a2:u8(Op.Copy)
        Codec.varuint(a2, a3 - a1.LastAddId)
        Codec.varuint(a2, a3 - a4)
        Codec.varuint(a2, if not (v6 >= 0) then -v6 * 2 - 1 else v6 * 2)
        a1.LastOffset = v4
        a1.LastAddId = a3
        if v5 then
            v6 = {Id = a3, ParentId = a4, Values = table.clone(v1.Values)}
            table.insert(v3, v6)
            a1.TemplateCount = a1.TemplateCount + 1
            return v6, v6.Values
        end
        v1.Id = a3
        v1.ParentId = a4
        v5 = table.find(v3, v1)
        if v5 ~= #v3 then
            table.remove(v3, v5)
            table.insert(v3, v1)
        end
        return v1, v1.Values
    end
    v3 = a7 and v2
    if v3 then
        v2 = a1.Templates[NextKey]
        if v2 then
            a1.TemplateCount = a1.TemplateCount - #v2
        end
        if 8192 <= a1.TemplateCount then
            a2:u8(Op.DropTemplates)
            Codec.varuint(a2, 0)
            table.clear(a1.Templates)
            a1.TemplateCount = 0
        elseif v2 then
            writeDrop(a2, v2)
        end
        a2:u8(Op.TemplateNext)
        a2:u8(TemplateNext.Add)
    end
    a2:u8(Op.Add)
    Codec.varuint(a2, a3)
    Codec.varuint(a2, a4)
    Codec.varuint(a2, a5)
    Codec.str(a2, a6)
    a1.LastAddId = a3
    if not v3 then
        return nil, nil
    end
    a1.TemplateCount = a1.TemplateCount + 1
    v3 = {}
    a1.Templates[NextKey] = {{Id = a3, ParentId = a4, Values = v3}}
    return nil, v3
end

function u16.Forget(a1, a2) -- Line: 260 -- types: a1: table, a2: number
    a1.KeyOf[a2] = nil
end

return u16