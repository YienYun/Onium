-- Script path: ReplicatedStorage.Packages.FormatNumber._internal.formatter_settings
-- Decompile time: 4.03 ms

local enums = require(script.Parent.enums)
local u5 = {MAX_PRECISION = 2147483647}

function u5.resolve_min_max_sig(a1, a2) -- Line: 5 -- upvalues: enums (val), u5 (val)
    local v1 = nil
    local MAX_PRECISION = nil
    if a1.type == enums._Internal.PrecisionType.SIGNFICANT then
        return a1.min, a1.max
    end
    if a1.type == enums._Internal.PrecisionType.FRACTION then
        return a2 + a1.min, a2 + a1.max
    end
    if a1.type ~= enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
        if a1.type == enums._Internal.PrecisionType.UNLIMITED then
            v1 = 1
            MAX_PRECISION = u5.MAX_PRECISION
        end
        return v1, MAX_PRECISION
    end
    local v2 = a2 + a1.minFractionDigits
    local v3 = a2 + a1.maxFractionDigits
    local minSignificantDigits = a1.minSignificantDigits
    local maxSignificantDigits = a1.maxSignificantDigits
    if a1.roundingPriority ~= enums.RoundingPriority.RELAXED then
        v1 = math.min(v2, minSignificantDigits)
        MAX_PRECISION = math.min(v3, maxSignificantDigits)
    else
        v1 = math.max(v2, minSignificantDigits)
        MAX_PRECISION = math.max(v3, maxSignificantDigits)
    end
    if not a1.sourcedWithSignificantDigits then
        return v2, MAX_PRECISION
    end
    return v1, MAX_PRECISION
end

local u31 = table.freeze({
    [enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = ".",
    [enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = ",",
    [enums.ENumberFormatSymbols.kMinusSignSymbol] = "-",
    [enums.ENumberFormatSymbols.kPlusSignSymbol] = "+",
    [enums.ENumberFormatSymbols.kExponentialSymbol] = "E",
    [enums.ENumberFormatSymbols.kInfinitySymbol] = "∞",
    [enums.ENumberFormatSymbols.kNaNSymbol] = "NaN",
})

function u5.generate_from_sign_enum(a1) -- Line: 49 -- upvalues: enums (val)
    local v1 = nil
    local v2 = nil
    local v3 = nil
    local v4 = nil
    if a1 == enums.SignDisplay.AUTO then
        v1 = true
        v2 = true
        v4 = false
        v3 = false
    elseif a1 == enums.SignDisplay.ALWAYS then
        v1 = true
        v2 = true
        v4 = true
        v3 = true
    elseif a1 == enums.SignDisplay.NEVER then
        v1 = false
        v2 = false
        v4 = false
        v3 = false
    elseif a1 == enums.SignDisplay.NEGATIVE then
        v1 = true
        v2 = false
        v4 = false
        v3 = false
    elseif a1 == enums.SignDisplay.EXCEPT_ZERO then
        v1 = true
        v2 = false
        v4 = true
        v3 = false
    end
    return table.freeze({negative = v1, negativeZero = v2, positiveZero = v3, positive = v4})
end

function u5.linked_list_to_dict(a1) -- Line: 77
    local v1 = {}
    local parent = a1
    while parent do
        if not v1[parent.key] then
            v1[parent.key] = parent.value
        end
        parent = parent.parent
    end
    return table.freeze(v1)
end

function u5.resolve_settings(a1) -- Line: 90 -- upvalues: enums (val), u31 (val), u5 (val)
    local v1 = {}
    local notation = a1.notation or table.freeze({type = enums._Internal.NotationType.SIMPLE})
    v1.notation = notation
    local v2 = v1.notation.type == enums._Internal.NotationType.COMPACT
    if not a1.precision then
        local v3 = if not v2 then table.freeze({min = 0, max = 6, type = enums._Internal.PrecisionType.FRACTION}) else table.freeze({
            minFractionDigits = 0,
            maxFractionDigits = 0,
            minSignificantDigits = 1,
            maxSignificantDigits = 2,
            type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
            roundingPriority = enums.RoundingPriority.RELAXED,
        })
        v1.precision = v3
    else
        v1.precision = a1.precision
    end
    if not a1.roundingMode then
        local HALF_EVEN = if v2 then enums.RoundingMode.DOWN else if v1.notation.type ~= enums._Internal.NotationType.SCIENTIFIC then enums.RoundingMode.HALF_EVEN else enums.RoundingMode.DOWN
        v1.roundingMode = HALF_EVEN
    else
        v1.roundingMode = a1.roundingMode
    end
    if not a1.grouping then
        v1.minGrouping = if not v2 then 4 else 5
    else
        local grouping = a1.grouping
        v1.minGrouping = if grouping ~= enums.GroupingStrategy.MIN2 then if grouping ~= enums.GroupingStrategy.ON_ALIGNED then nil else 4 else 5
    end
    local integerWidth = a1.integerWidth or table.freeze({min = 1, max = -1})
    v1.integerWidth = integerWidth
    local symbols = a1.symbols or u31
    v1.symbols = symbols
    if not a1.sign then
        v1.displaySignAt = u5.generate_from_sign_enum(enums.SignDisplay.AUTO)
    else
        v1.displaySignAt = u5.generate_from_sign_enum(a1.sign)
    end
    v1.alwaysDisplayDecimal = a1.decimal == enums.DecimalSeparatorDisplay.ALWAYS
    return table.freeze(v1)
end

return table.freeze(u5)