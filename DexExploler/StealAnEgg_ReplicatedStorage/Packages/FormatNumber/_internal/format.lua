-- Script path: ReplicatedStorage.Packages.FormatNumber._internal.format
-- Decompile time: 7.65 ms

local enums = require(script.Parent.enums)
local formatter_settings = require(script.Parent.formatter_settings)
local u10 = {}

local function internal_get_digits(a1, a2, a3, a4) -- Line: 5 -- types: a1: table, a2: number, a3: number, a4: number
    local v1, v2, v3
    if not (a3 <= 0) then
        v2 = ""
    else
        v2 = string.rep("0", -a3 + 1)
        a3 = 1
    end
    local v4 = a4 - math.max(a2, a3 - 1)
    if not (v4 <= 0) then
        v1 = a2
        v3 = string.rep("0", v4)
    else
        v3 = ""
        v1 = a4
    end
    return v2 .. (if not (a2 < a3) then string.char((table.unpack(a1, a3, v1))) else "") .. v3
end

function u10.strip_trailing_zero(a1, a2) -- Line: 32 -- types: a1: table, a2: number
    if a2 < 0 then
        return 0
    end
    local v1 = a2
    while a1[v1] == 0 do
        v1 = v1 - 1
    end
    return v1
end

function u10.round_sig(a1, a2, a3, a4, a5) -- Line: 43
    -- upvalues: enums (val), u10 (val)
    local v1 = 0
    if a3 < a2 then
        local v2 = nil
        local v3 = if not (a3 < 0) then if not (5 < a1[a3 + 1]) then if a1[a3 + 1] ~= 5 then -1 else if not (a3 + 1 < a2) then 0 else 1 else 1 else -1
        if a5 == enums.RoundingMode.CEILING then
            v2 = if not a4 then -2 else 1
        elseif a5 == enums.RoundingMode.FLOOR then
            v2 = if not a4 then 1 else -2
        elseif a5 == enums.RoundingMode.UP then
            v2 = -2
        elseif a5 == enums.RoundingMode.DOWN then
            v2 = 1
        elseif a5 == enums.RoundingMode.HALF_EVEN then
            v2 = if not (a3 <= 0) then a1[a3] % -2 else 0
        elseif a5 == enums.RoundingMode.HALF_DOWN then
            v2 = 0
        elseif a5 == enums.RoundingMode.HALF_UP then
            v2 = -1
        end
        local v4 = a3
        if v2 < v3 then
            while a1[v4] == 9 do
                if not (v4 > 0) then
                    break
                end
                v4 = v4 - 1
            end
            if not (v4 <= 0) then
                a1[v4] = a1[v4] + 1
            else
                a1[1] = 1
                v1 = 1 - v4
                v4 = 1
            end
        end
        a2 = u10.strip_trailing_zero(a1, v4)
    end
    return a2, v1
end

function u10.resolve_int_frac(a1, a2, a3, a4, a5, a6, a7) -- Line: 108
    -- upvalues: internal_get_digits (val)
    local v1, v2
    local v3 = a2
    for i = 1, v3 do
        a1[i] = a1[i] + 48
    end
    if not (a3 < a4) or not (a5 < a3 + 1) then
        v1 = internal_get_digits(a1, a2, a4, a3)
        v2 = internal_get_digits(a1, a2, a3 + 1, a5)
    else
        v1 = "0"
        v2 = ""
    end
    if a6 and a6 <= a3 - a4 + 1 then
        v3 = if a7 ~= "%" then if not (#a7 > 1) then "%0" .. a7 else "%0" .. string.reverse(a7) else "%0%%"
        v1 = string.reverse((string.gsub(string.reverse(v1), "...", v3, (a3 - a4) / 3)))
    end
    return v1, v2
end

function u10.format_expt(a1, a2, a3, a4) -- Line: 148 -- upvalues: enums (val)
    local v1
    local v2 = ""
    if a1 < 0 then
        v1 = tostring(-a1)
        if a4.negative then
            v2 = a2[enums.ENumberFormatSymbols.kMinusSignSymbol]
        end
    elseif a1 ~= 0 then
        v1 = tostring(a1)
        if a4.positive then
            v2 = a2[enums.ENumberFormatSymbols.kPlusSignSymbol]
        end
    else
        v1 = "0"
        if a4.positiveZero then
            v2 = a2[enums.ENumberFormatSymbols.kPlusSignSymbol]
        end
    end
    v1 = (string.rep("0", a3 - #v1)) .. v1
    return a2[enums.ENumberFormatSymbols.kExponentialSymbol] .. v2 .. v1
end

function u10.resolve_with_notation(a1, a2, a3, a4, a5) -- Line: 173 -- upvalues: enums (val), u10 (val)
    local v1 = nil
    local v2 = nil
    local v3 = nil
    local v4 = a3
    if not (a2 <= 0) then
        if a4.type ~= enums._Internal.NotationType.SIMPLE then
            local power10Scale = a4.power10Scale
            local v5 = v4 + a2 - 1
            local v6 = math.floor(v5 / power10Scale)
            v4 = v5 - v6 * power10Scale + 1
            if a4.type ~= enums._Internal.NotationType.COMPACT then
                v1 = u10.format_expt(v6 * power10Scale, a5, a4.minExponentDigits, a4.displayExponentSignAt)
                v3 = u10.format_expt((v6 + 1) * power10Scale, a5, a4.minExponentDigits, a4.displayExponentSignAt)
                v2 = power10Scale
            else
                local suffixesLength = a4.suffixesLength
                if suffixesLength < v6 then
                    v4 = v4 + (v6 - suffixesLength) * power10Scale
                    v1 = a4.suffixes[suffixesLength]
                elseif v6 < 0 then
                    v4 = v4 + v6 * power10Scale
                elseif v6 ~= 0 then
                    v1 = a4.suffixes[v6]
                end
                if v6 >= 0 and v6 < suffixesLength then
                    v2 = power10Scale
                    v3 = a4.suffixes[v6 + 1]
                end
            end
        else
            v4 = v4 + a2
        end
    elseif a4.type == enums._Internal.NotationType.SCIENTIFIC then
        v1 = u10.format_expt(0, a5, a4.minExponentDigits, a4.displayExponentSignAt)
    end
    return v4, v1, v2, v3
end

function u10.format_unsigned_finite(a1, a2, a3, a4, a5) -- Line: 230
    -- upvalues: u10 (val), formatter_settings (val), enums (val)
    local min = a5.integerWidth.min
    local max = a5.integerWidth.max
    local notation = a5.notation
    local symbols = a5.symbols
    local v1, v2, v3, v4 = u10.resolve_with_notation(a1, a2, a3, notation, symbols)
    local v5, v6 = formatter_settings.resolve_min_max_sig(a5.precision, v1)
    local v7 = v5
    v5, v6 = u10.round_sig(a1, a2, v6, a4, a5.roundingMode)
    local v8 = v5
    local v9 = v6
    local v10 = v8 == 0
    if v9 > 0 then
        if v1 ~= v3 then
            v1 = v1 + v9
        else
            assert(v9 == 1)
            v2 = v4
            v1 = 1
        end
        v5, v6 = formatter_settings.resolve_min_max_sig(a5.precision, v1)
        v7 = v5
    elseif v10 then
        v5, v6 = formatter_settings.resolve_min_max_sig(a5.precision, 1)
        v7 = v5
        v1 = 1
    end
    local v11 = if not (v1 < min) then if max == -1 then v1 else if not (max < v1) then v1 else max else min
    v5, v6 = u10.resolve_int_frac(
        a1,
        v8,
        v1,
        math.max(v1, 0) - v11 + 1,
        math.max(v8, v7),
        a5.minGrouping,
        symbols[enums.ENumberFormatSymbols.kGroupingSeparatorSymbol]
    )
    local v12 = v5
    local v13 = v6
    if a5.alwaysDisplayDecimal or v13 ~= "" then
        v12 = v12 .. symbols[enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] .. v13
    end
    if v2 then
        v12 = v12 .. v2
    end
    return v12, v10
end

function u10.display_sign(a1, a2, a3, a4, a5) -- Line: 298 -- upvalues: enums (val)
    local negativeZero, v1
    if not a2 then
        v1 = a5[enums.ENumberFormatSymbols.kPlusSignSymbol]
        negativeZero = if not a3 then a4.positive else a4.positiveZero
    else
        v1 = a5[enums.ENumberFormatSymbols.kMinusSignSymbol]
        negativeZero = if not a3 then a4.negative else a4.negativeZero
    end
    if negativeZero then
        return v1 .. a1
    end
    return a1
end

return table.freeze(u10)