-- Script path: ReplicatedStorage.Packages.FormatNumber.Main.DecimalFormatSymbols
-- Decompile time: 0.92 ms

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local u17 = _internal.class.create_init_function("DecimalFormatSymbols", nil, v2, nil, _internal.class.ImmutabilityType.SYMBOLS)

function v2.GetSymbol(a1, a2) -- Line: 13 -- upvalues: _internal (val) -- types: a1: table, a2: number
    return (_internal.class.try_coerce(1, a1, "DecimalFormatSymbols"))[_internal.class.try_coerce_enum(2, a2, _internal.enums.ENumberFormatSymbols)]
end

function v2.SetSymbol(a1, a2, a3) -- Line: 20 -- upvalues: _internal (val) -- types: a1: table, a2: number, a3: string
    local v1 = _internal.class.try_coerce(1, a1, "DecimalFormatSymbols")
    local v2 = _internal.class.try_coerce_enum(2, a2, _internal.enums.ENumberFormatSymbols)
    v1[v2] = (_internal.class.try_coerce(3, a3, "string"))
end

function v1.createWithLastResortData() -- Line: 28 -- upvalues: u17 (val), _internal (val)
    return u17({
        [_internal.enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = ".",
        [_internal.enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = "",
        [_internal.enums.ENumberFormatSymbols.kMinusSignSymbol] = "-",
        [_internal.enums.ENumberFormatSymbols.kPlusSignSymbol] = "+",
        [_internal.enums.ENumberFormatSymbols.kExponentialSymbol] = "E",
        [_internal.enums.ENumberFormatSymbols.kInfinitySymbol] = "∞",
        [_internal.enums.ENumberFormatSymbols.kNaNSymbol] = "�",
    })
end

return table.freeze(v1)