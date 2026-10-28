-- Script path: ReplicatedStorage.Packages.FormatNumber.Main
-- Decompile time: 4.72 ms

local _internal = require(script.Parent._internal)
local Notation = require(script.Notation)
local Precision = require(script.Precision)
local IntegerWidth = require(script.IntegerWidth)
local DecimalFormatSymbols = require(script.DecimalFormatSymbols)
local enums = _internal.enums
local v1 = {}
local v2 = {}
local u33 = _internal.class.create_init_function("NumberFormatter", nil, v2, nil, _internal.class.ImmutabilityType.NUMBER_FORMATTER)

function v2.Notation(a1, a2) -- Line: 26 -- upvalues: _internal (val), u33 (val)
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "notation",
        value = _internal.class.try_coerce(2, a2, "Notation"),
        parent = _internal.class.get_data(a1),
    })
end

function v2.Precision(a1, a2) -- Line: 36 -- upvalues: _internal (val), u33 (val)
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "precision",
        value = _internal.class.try_coerce(2, a2, "Precision"),
        parent = _internal.class.get_data(a1),
    })
end

function v2.RoundingMode(a1, a2) -- Line: 46 -- upvalues: _internal (val), enums (val), u33 (val) -- types: a2: number
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "roundingMode",
        value = _internal.class.try_coerce_enum(2, a2, enums.RoundingMode),
        parent = _internal.class.get_data(a1),
    })
end

function v2.Grouping(a1, a2) -- Line: 56 -- upvalues: _internal (val), enums (val), u33 (val) -- types: a2: number
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "grouping",
        value = _internal.class.try_coerce_enum(2, a2, enums.GroupingStrategy),
        parent = _internal.class.get_data(a1),
    })
end

function v2.IntegerWidth(a1, a2) -- Line: 66 -- upvalues: _internal (val), u33 (val)
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "integerWidth",
        value = _internal.class.try_coerce(2, a2, "IntegerWidth"),
        parent = _internal.class.get_data(a1),
    })
end

function v2.Symbols(a1, a2) -- Line: 76 -- upvalues: _internal (val), u33 (val)
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "symbols",
        value = _internal.class.try_coerce(2, a2, "DecimalFormatSymbols"),
        parent = _internal.class.get_data(a1),
    })
end

function v2.Sign(a1, a2) -- Line: 86 -- upvalues: _internal (val), enums (val), u33 (val) -- types: a2: number
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "sign",
        value = _internal.class.try_coerce_enum(2, a2, enums.SignDisplay),
        parent = _internal.class.get_data(a1),
    })
end

function v2.Decimal(a1, a2) -- Line: 96 -- upvalues: _internal (val), enums (val), u33 (val) -- types: a2: number
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    return u33({
        key = "decimal",
        value = _internal.class.try_coerce_enum(2, a2, enums.DecimalSeparatorDisplay),
        parent = _internal.class.get_data(a1),
    })
end

local function resolve_nf_data(a1) -- Line: 107 -- upvalues: _internal (val)
    return _internal.formatter_settings.resolve_settings(_internal.formatter_settings.linked_list_to_dict(a1))
end

function v2.Format(a1, a2) -- Line: 111
    -- upvalues: _internal (val), resolve_nf_data (val), enums (val)
    local v1, v2, v3
    _internal.class.try_coerce(1, a1, "NumberFormatter")
    if type(a2) == "string" then
        error(
            "Argument #2 as a string interpreted as decimal is not currently supported, please cast the argument to a double if you want the string to be interpreted as a double",
            2
        )
    end
    local v4 = _internal.class.try_coerce(2, a2, "number")
    local v5 = _internal.class.get_resolved_data(a1, resolve_nf_data)
    local symbols = v5.symbols
    if v4 ~= v4 then
        v2 = 128 <= (string.byte((string.pack(">d", v4))))
        v3 = true
        v1 = symbols[enums.ENumberFormatSymbols.kNaNSymbol]
    elseif v4 == (1 / 0) then
        v2 = v4 < 0
        v3 = false
        v1 = symbols[enums.ENumberFormatSymbols.kInfinitySymbol]
    elseif v4 ~= (-1 / 0) then
        local v6, v7, v8, v9, v10
        if v4 ~= 0 then
            local v11
            v2 = v4 < 0
            v6, v7, v11 = _internal.decimal_conversion.from_double((math.abs(v4)))
            v8 = v6
            v9 = v7
            v10 = v11
        else
            v2 = (math.atan2(v4, -1)) < 0
            v8 = nil
            v9 = 0
            v10 = 1
        end
        v6, v7 = _internal.format.format_unsigned_finite(v8, v9, v10, v2, v5)
        v1 = v6
        v3 = v7
    else
        v2 = v4 < 0
        v3 = false
        v1 = symbols[enums.ENumberFormatSymbols.kInfinitySymbol]
    end
    return (_internal.format.display_sign(v1, v2, v3, v5.displaySignAt, v5.symbols))
end

function v2.ToSkeleton(a1) -- Line: 168 -- upvalues: _internal (val)
    return _internal.skeleton.settings_to_skeleton(_internal.formatter_settings.linked_list_to_dict((_internal.class.try_coerce(1, a1, "NumberFormatter"))))
end

function v1.with() -- Line: 174 -- upvalues: u33 (val)
    return u33(nil)
end

function v1.forSkeleton(a1) -- Line: 178 -- upvalues: _internal (val), u33 (val) -- types: a1: string
    local v1, v2 = _internal.skeleton.to_option_linked_list((_internal.class.try_coerce(1, a1, "string")))
    local v3 = v1
    local v4 = v2
    v1 = v3
    if v3 then
        return v1, (u33(v4))
    end
    return v1, v4
end

return table.freeze({
    NumberFormatter = table.freeze(v1),
    Notation = Notation,
    Precision = Precision,
    RoundingPriority = enums.RoundingPriority,
    RoundingMode = enums.RoundingMode,
    GroupingStrategy = enums.GroupingStrategy,
    IntegerWidth = IntegerWidth,
    DecimalFormatSymbols = DecimalFormatSymbols,
    ENumberFormatSymbols = enums.ENumberFormatSymbols,
    SignDisplay = enums.SignDisplay,
    DecimalSeparatorDisplay = enums.DecimalSeparatorDisplay,
})