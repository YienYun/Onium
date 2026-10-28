-- Script path: ReplicatedStorage.Packages.FormatNumber.Main.Precision
-- Decompile time: 3.20 ms

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local u17 = _internal.class.create_init_function("Precision", nil, v2, nil, _internal.class.ImmutabilityType.DEFAULT)
local v3 = {}
local u28 = _internal.class.create_init_function("FractionPrecision", "Precision", v3, v2, _internal.class.ImmutabilityType.DEFAULT)

function v3.WithMinDigits(a1, a2) -- Line: 22 -- upvalues: _internal (val), u17 (val) -- types: a1: table, a2: number
    local v1 = _internal.class.try_coerce(1, a1, "FractionPrecision")
    return u17({
        minSignificantDigits = 1,
        sourcedWithSignificantDigits = false,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = v1.min,
        maxFractionDigits = v1.max,
        maxSignificantDigits = _internal.class.try_coerce_range(2, a2, 1, 999),
        roundingPriority = _internal.enums.RoundingPriority.RELAXED,
    })
end

function v3.WithMaxDigits(a1, a2) -- Line: 37 -- upvalues: _internal (val), u17 (val) -- types: a1: table, a2: number
    local v1 = _internal.class.try_coerce(1, a1, "FractionPrecision")
    return u17({
        minSignificantDigits = 1,
        sourcedWithSignificantDigits = false,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = v1.min,
        maxFractionDigits = v1.max,
        maxSignificantDigits = _internal.class.try_coerce_range(2, a2, 1, 999),
        roundingPriority = _internal.enums.RoundingPriority.STRICT,
    })
end

function v3.WithSignificantDigits(a1, a2, a3, a4) -- Line: 52
    -- upvalues: _internal (val), u17 (val)
    local v1 = _internal.class.try_coerce(1, a1, "FractionPrecision")
    return u17({
        sourcedWithSignificantDigits = true,
        type = _internal.enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
        minFractionDigits = v1.min,
        maxFractionDigits = v1.max,
        minSignificantDigits = _internal.class.try_coerce_range(2, a2, 1, 999),
        maxSignificantDigits = _internal.class.try_coerce_range(3, a3, 1, 999),
        roundingPriority = _internal.class.try_coerce_enum(4, a4, _internal.enums.RoundingPriority),
    })
end

local u42 = _internal.class.create_init_function("SignificantDigitsPrecision", "Precision", {}, v2, _internal.class.ImmutabilityType.DEFAULT)

function v1.unlimited() -- Line: 84 -- upvalues: u17 (val), _internal (val)
    return u17({type = _internal.enums._Internal.PrecisionType.UNLIMITED})
end

function v1.integer() -- Line: 90 -- upvalues: u28 (val), _internal (val)
    return u28({min = 0, max = 0, type = _internal.enums._Internal.PrecisionType.FRACTION})
end

function v1.fixedFraction(a1) -- Line: 98 -- upvalues: _internal (val), u28 (val) -- types: a1: number
    local v1 = _internal.class.try_coerce_range(1, a1, 0, 999)
    return u28({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = v1,
        max = v1,
    })
end

function v1.minFraction(a1) -- Line: 108 -- upvalues: _internal (val), u28 (val) -- types: a1: number
    return u28({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = _internal.class.try_coerce_range(1, a1, 0, 999),
        max = _internal.formatter_settings.MAX_PRECISION,
    })
end

function v1.maxFraction(a1) -- Line: 118 -- upvalues: _internal (val), u28 (val) -- types: a1: number
    return u28({
        min = 0,
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        max = _internal.class.try_coerce_range(1, a1, 0, 999),
    })
end

function v1.minMaxFraction(a1, a2) -- Line: 128 -- upvalues: _internal (val), u28 (val) -- types: a1: number, a2: number
    local v1 = _internal.class.try_coerce_range(1, a1, 0, 999)
    return u28({
        type = _internal.enums._Internal.PrecisionType.FRACTION,
        min = v1,
        max = _internal.class.try_coerce_range(2, a2, v1, 999),
    })
end

function v1.fixedSignificantDigits(a1) -- Line: 139 -- upvalues: _internal (val), u42 (val) -- types: a1: number
    local v1 = _internal.class.try_coerce_range(1, a1, 1, 999)
    return u42({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = v1,
        max = v1,
    })
end

function v1.minSignificantDigits(a1) -- Line: 149 -- upvalues: _internal (val), u42 (val) -- types: a1: number
    return u42({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = _internal.class.try_coerce_range(1, a1, 1, 999),
        max = _internal.formatter_settings.MAX_PRECISION,
    })
end

function v1.maxSignificantDigits(a1) -- Line: 159 -- upvalues: _internal (val), u42 (val) -- types: a1: number
    return u42({
        min = 1,
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        max = _internal.class.try_coerce_range(1, a1, 1, 999),
    })
end

function v1.minMaxSignificantDigits(a1, a2) -- Line: 169
    -- upvalues: _internal (val), u42 (val)
    local v1 = _internal.class.try_coerce_range(1, a1, 1, 999)
    return u42({
        type = _internal.enums._Internal.PrecisionType.SIGNFICANT,
        min = v1,
        max = _internal.class.try_coerce_range(2, a2, v1, 999),
    })
end

return table.freeze(v1)