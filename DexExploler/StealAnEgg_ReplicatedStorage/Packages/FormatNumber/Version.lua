-- Script path: ReplicatedStorage.Packages.FormatNumber.Version
-- Decompile time: 1.48 ms

local v1 = {}

local function version_tostring(a1) -- Line: 35
    return string.format("%d.%d", a1.Major, a1.Minor)
end

local function version_lt(a1, a2) -- Line: 39
    if a1.Major == a2.Major then
        return a1.Minor < a2.Minor
    end
    return a1.Major < a2.Major
end

local function version_eq(a1, a2) -- Line: 43
    local v1 = false
    if a1.Major == a2.Major then
        v1 = a1.Minor == a2.Minor
    end
    return v1
end

local function double_to_int32(a1) -- Line: 47 -- types: a1: number
    if math.clamp(tonumber(a1) or 0, -2147483648, 2147483647) ~= a1 then
        return UDim.new(nil, a1).Offset
    end
    if a1 <= -1 then
        return (math.ceil(a1))
    end
    if a1 >= 1 then
        return (math.floor(a1))
    end
    return 0
end

function v1.new(a1, a2) -- Line: 61
    -- upvalues: version_tostring (val), version_lt (val), version_eq (val)
    local v1 = newproxy(true)
    local v2 = getmetatable(v1)
    v2.__index = {
        Major = if math.clamp(tonumber(a1) or 0, -2147483648, 2147483647) == a1 then if not (a1 <= -1) then if not (a1 >= 1) then 0 else math.floor(a1) else math.ceil(a1) else UDim.new(nil, a1).Offset,
        Minor = if math.clamp(tonumber(a2) or 0, -2147483648, 2147483647) == a2 then if not (a2 <= -1) then if not (a2 >= 1) then 0 else math.floor(a2) else math.ceil(a2) else UDim.new(nil, a2).Offset,
    }
    v2.__metatable = "The metatable is locked"
    v2.__tostring = version_tostring
    v2.__lt = version_lt
    v2.__eq = version_eq
    table.freeze(v2)
    return v1
end

v1.current = v1.new(31, 1)
return table.freeze(v1)