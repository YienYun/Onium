-- Script path: ReplicatedStorage.Packages.FormatNumber._internal.class
-- Decompile time: 5.55 ms

local u0 = {}
local u1 = {}
local u5 = setmetatable({}, {__mode = "k"})

local function proxy_tostring(a1) -- Line: 5 -- upvalues: u5 (val)
    return u5[a1].type_name .. ": " .. u5[a1].as_string
end

local u9 = table.freeze({DEFAULT = 0, NUMBER_FORMATTER = 1, SYMBOLS = 2})
u0.ImmutabilityType = u9

function u0.create_init_function(a1, a2, a3, a4, a5) -- Line: 16
    -- upvalues: u1 (val), u9 (val), proxy_tostring (val), u5 (val)
    local u13
    if not a4 then
        u13 = a3
    else
        local v1 = table.clone(a4)
        local v2 = {__index = a3}
        u13 = setmetatable(v1, v2)
    end
    u1[a1] = a2 or "FormatNumberObject"
    return function(a1_2, a2) -- Line: 33
        -- upvalues: a5 (val), u9 (upval), a1 (val), u13 (ref), proxy_tostring (upval), u5 (upval)
        local v1 = newproxy(true)
        local v2 = getmetatable(v1)
        if a5 ~= u9.SYMBOLS and type(a1_2) == "table" then
            table.freeze(a1_2)
        end
        v2.data = a1_2
        v2.resolved_data = nil
        v2.type_name = a1
        v2.as_string = a2 or string.sub(tostring(v1), 11)
        v2.__index = u13
        v2.__tostring = proxy_tostring
        v2.__metatable = "The metatable is locked"
        if a5 ~= u9.NUMBER_FORMATTER then
            table.freeze(v2)
        end
        u5[v1] = v2
        return v1
    end
end

function u0.is_a(a1, a2) -- Line: 59 -- upvalues: u5 (val), u1 (val)
    local v1 = u5[a1]
    local type_name = v1 and v1.type_name
    v1 = false
    if type_name == a2 then
        return true
    end
    if type_name then
        repeat
            type_name = u1[type_name]
            v1 = type_name == a2
        until not type_name or v1
    end
    return v1
end

function u0.get_data(a1) -- Line: 77 -- upvalues: u5 (val)
    return u5[a1].data
end

function u0.get_resolved_data(a1, a2) -- Line: 81 -- upvalues: u5 (val)
    local v1 = u5[a1]
    local resolved_data = v1.resolved_data
    if not resolved_data then
        resolved_data = a2(v1.data)
        v1.resolved_data = resolved_data
        if resolved_data then
            table.freeze(v1)
        end
    end
    return resolved_data
end

function u0.try_coerce(a1, a2, a3, a4) -- Line: 96 -- upvalues: u0 (val), u5 (val)
    local v1
    local v2 = false
    local data = nil
    if a2 ~= nil then
        if a3 ~= "string" then
            if a3 ~= "number" then
                if string.sub(a3, 1, 1) == "{" then
                    v1 = string.sub(a3, 2, -2)
                    if type(a2) ~= "table" then
                        a3 = "table"
                    else
                        for i, j in (table.move(a2, 1, rawlen(a2), 1, table.create((rawlen(a2))))) do
                            if type(j) ~= v1 then
                                error(string.format("Values inside the table argument must be a %s, index %d got %s", v1, i, (type(j))), 3)
                            end
                        end
                        v2 = true
                    end
                elseif u0.is_a(a2, a3) then
                    data = u5[a2].data
                    v2 = true
                end
            elseif not (tonumber(a2)) then
                v2 = false
                a3 = a3 .. " object"
            else
                v2 = true
            end
        elseif type(a2) == "string" then
            data = a2
            v2 = true
        elseif type(a2) ~= "number" then
            v2 = false
        else
            data = tostring(a2)
            v2 = true
        end
    elseif a4 ~= nil then
        data = a4
        v2 = true
    elseif a3 ~= "string" then
        if a3 ~= "number" then
            if string.sub(a3, 1, 1) == "{" then
                v1 = string.sub(a3, 2, -2)
                if type(a2) ~= "table" then
                    a3 = "table"
                else
                    for k, n in (table.move(a2, 1, rawlen(a2), 1, table.create((rawlen(a2))))) do
                        if type(n) ~= v1 then
                            error(string.format("Values inside the table argument must be a %s, index %d got %s", v1, k, (type(n))), 3)
                        end
                    end
                    v2 = true
                end
            elseif u0.is_a(a2, a3) then
                data = u5[a2].data
                v2 = true
            end
        elseif not (tonumber(a2)) then
            v2 = false
            a3 = a3 .. " object"
        else
            v2 = true
        end
    elseif type(a2) == "string" then
        data = a2
        v2 = true
    elseif type(a2) ~= "number" then
        v2 = false
    else
        data = tostring(a2)
        v2 = true
    end
    if not v2 then
        error(string.format("Argument #%d provided must be a %s", a1, a3), 3)
    end
    return data
end

function u0.try_coerce_range(a1, a2, a3, a4, a5) -- Line: 151 -- upvalues: u0 (val)
    local v1 = nil
    if a2 ~= nil then
        local v2 = tonumber(a2)
        if v2 then
            v2 = u0.double_to_int32(v2)
            if a3 <= v2 and v2 <= a4 then
                v1 = v2
            end
        end
    else
        v1 = a5
    end
    return v1 or error(string.format("Argument #%d provided must be an integer that is in the range of %d to (and including) %d", a1, a3, a4), 3)
end

function u0.try_coerce_enum(a1, a2, a3, a4) -- Line: 179 -- upvalues: u0 (val)
    local v1 = nil
    if a2 == nil then
        v1 = a4
    elseif tonumber(a2) then
        local v2 = u0.double_to_int32(a2)
        for i, j in a3 do
            if v2 == j then
                v1 = j
                break
            end
        end
    end
    return v1 or error(string.format("Argument #%d provided is out of range", a1), 3)
end

function u0.double_to_int32(a1) -- Line: 200 -- types: a1: number
    if a1 > -2147483649 and a1 < 2147483648 then
        if a1 <= -1 then
            return (math.ceil(a1))
        end
        if a1 >= 1 then
            return (math.floor(a1))
        end
        return 0
    end
    return UDim.new(nil, a1).Offset
end

return table.freeze(u0)