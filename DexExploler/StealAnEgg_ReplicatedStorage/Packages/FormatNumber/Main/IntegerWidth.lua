-- Script path: ReplicatedStorage.Packages.FormatNumber.Main.IntegerWidth
-- Decompile time: 0.78 ms

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local u17 = _internal.class.create_init_function("IntegerWidth", nil, v2, nil, _internal.class.ImmutabilityType.DEFAULT)

function v2.TruncateAt(a1, a2) -- Line: 13 -- upvalues: _internal (val), u17 (val) -- types: a1: table, a2: number
    local v1 = _internal.class.try_coerce(1, a1, "IntegerWidth")
    return u17({
        min = v1.min,
        max = if not tonumber(a2) then _internal.class.try_coerce_range(1, a2, v1.min, 999) else if math.ceil(a2) ~= -1 then _internal.class.try_coerce_range(1, a2, v1.min, 999) else -1,
    })
end

function v1.zeroFillTo(a1) -- Line: 29 -- upvalues: _internal (val), u17 (val) -- types: a1: number
    return u17({max = -1, min = _internal.class.try_coerce_range(1, a1, 0, 999)})
end

return table.freeze(v1)