-- Script path: ReplicatedStorage.Packages.FormatNumber._internal.skeleton
-- Decompile time: 12.84 ms

local formatter_settings = require(script.Parent.formatter_settings)
local enums = require(script.Parent.enums)
local v1 = {}
local u11 = {
    [enums.SignDisplay.AUTO] = nil,
    [enums.SignDisplay.ALWAYS] = "sign-always",
    [enums.SignDisplay.NEVER] = "sign-never",
    [enums.SignDisplay.EXCEPT_ZERO] = "sign-except-zero",
    [enums.SignDisplay.NEGATIVE] = "sign-negative",
}

local function notation_to_skeleton(a1) -- Line: 14 -- upvalues: enums (val), u11 (val)
    if a1.type ~= enums._Internal.NotationType.SCIENTIFIC then
        if a1.type == enums._Internal.NotationType.SIMPLE then
            return true, nil
        end
        return false, "Compact notation skeleton is not supported for being represented as a skeleton string in this module"
    end
    local v1 = true
    local v2 = if a1.power10Scale ~= 3 then "scientific" else "engineering"
    if a1.minExponentDigits ~= 1 then
        v2 = v2 .. "/*" .. string.rep("e", a1.minExponentDigits)
    end
    if a1.exponentSignDisplay ~= enums.SignDisplay.AUTO then
        return v1, v2 .. "/" .. u11[a1.exponentSignDisplay]
    end
    return v1, v2
end

local function precision_to_skeleton(a1) -- Line: 39 -- upvalues: enums (val), formatter_settings (val)
    local v1 = nil
    local v2 = nil
    local v3 = nil
    local min = nil
    local max = nil
    local min_2 = nil
    local max_2 = nil
    if a1.type == enums._Internal.PrecisionType.FRACTION then
        min = a1.min
        max = a1.max
    elseif a1.type == enums._Internal.PrecisionType.SIGNFICANT then
        min_2 = a1.min
        max_2 = a1.max
    elseif a1.type ~= enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
        v1 = "precision-unlimited"
    else
        min = a1.minFractionDigits
        max = a1.maxFractionDigits
        if a1.sourcedWithSignificantDigits then
            min_2 = a1.minSignificantDigits
            max_2 = a1.maxSignificantDigits
        elseif a1.roundingPriority ~= enums.RoundingPriority.RELAXED then
            min_2 = 1
            max_2 = a1.maxSignificantDigits
        else
            min_2 = a1.maxSignificantDigits
            max_2 = formatter_settings.MAX_PRECISION
        end
    end
    if min then
        if max ~= 0 then
            v2 = "." .. string.rep("0", min)
            v2 = if max ~= formatter_settings.MAX_PRECISION then v2 .. string.rep("#", max - min) else v2 .. "*"
        else
            v2 = "precision-integer"
        end
    end
    if min_2 then
        v3 = string.rep("@", min_2)
        v3 = if max_2 ~= formatter_settings.MAX_PRECISION then v3 .. string.rep("#", max_2 - min_2) else v3 .. "*"
    end
    if not v2 then
        if v3 then
            v1 = v3
        end
        return v1
    end
    v1 = v2
    if v3 then
        v1 = v1 .. "/" .. v3
        if a1.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT and a1.sourcedWithSignificantDigits then
            if a1.roundingPriority == enums.RoundingPriority.RELAXED then
                return v1 .. "r"
            end
            return v1 .. "s"
        end
    end
    return v1
end

local u29 = {
    [enums.RoundingMode.CEILING] = "rounding-mode-ceiling",
    [enums.RoundingMode.FLOOR] = "rounding-mode-floor",
    [enums.RoundingMode.DOWN] = "rounding-mode-down",
    [enums.RoundingMode.UP] = "rounding-mode-up",
    [enums.RoundingMode.HALF_EVEN] = "rounding-mode-half-even",
    [enums.RoundingMode.HALF_DOWN] = "rounding-mode-half-down",
    [enums.RoundingMode.HALF_UP] = "rounding-half-up",
}
local u51 = {
    [enums.GroupingStrategy.OFF] = "group-off",
    [enums.GroupingStrategy.MIN2] = "group-min2",
    [enums.GroupingStrategy.ON_ALIGNED] = "group-on-aligned",
}

local function int_width_to_skeleton(a1) -- Line: 123
    if a1.max == -1 then
        return "integer-width/*" .. string.rep("0", a1.min)
    end
    if a1.max == 0 and a1.min == 0 then
        return "integer-width-trunc"
    end
    return "integer-width/" .. (string.rep("#", a1.max - a1.min)) .. string.rep("0", a1.min)
end

local u62 = {
    [enums.DecimalSeparatorDisplay.AUTO] = nil,
    [enums.DecimalSeparatorDisplay.ALWAYS] = "decimal-always",
}

function v1.settings_to_skeleton(a1) -- Line: 142
    -- upvalues: notation_to_skeleton (val), precision_to_skeleton (val), u29 (val), u51 (val)
    -- upvalues: int_width_to_skeleton (val), u62 (val)
    local v1
    local v2 = {}
    local v3 = nil
    if a1.notation then
        local v4, v5 = notation_to_skeleton(a1.notation)
        local v6 = v5
        if not v4 then
            v3 = v6
        else
            table.insert(v2, v6)
        end
    end
    if true then
        if a1.precision then
            table.insert(v2, (precision_to_skeleton(a1.precision)))
        end
        if a1.roundingMode then
            table.insert(v2, u29[a1.roundingMode])
        end
        if a1.grouping then
            table.insert(v2, u51[a1.grouping])
        end
        if a1.integerWidth then
            table.insert(v2, (int_width_to_skeleton(a1.integerWidth)))
        end
        if a1.decimal then
            table.insert(v2, u62[a1.decimal])
        end
        v3 = table.concat(v2, " ")
    end
    return v1, v3
end

local u70 = {
    ["notation-simple"] = "notation",
    ["precision-unlimited"] = "precision",
    [".+"] = "precision",
    ["rounding-mode-ceiling"] = "roundingMode",
    ["rounding-mode-floor"] = "roundingMode",
    ["rounding-mode-down"] = "roundingMode",
    ["rounding-mode-up"] = "roundingMode",
    ["rounding-mode-half-even"] = "roundingMode",
    ["rounding-mode-half-down"] = "roundingMode",
    ["rounding-mode-half-up"] = "roundingMode",
    ["group-off"] = "grouping",
    ["group-min2"] = "grouping",
    ["group-on-aligned"] = "grouping",
    [",_"] = "grouping",
    [",?"] = "grouping",
    [",!"] = "grouping",
    ["sign-auto"] = "sign",
    ["sign-always"] = "sign",
    ["sign-never"] = "sign",
    ["sign-except-zero"] = "sign",
    ["sign-negative"] = "sign",
    ["+!"] = "sign",
    ["+_"] = "sign",
    ["+?"] = "sign",
    ["+-"] = "sign",
    ["decimal-auto"] = "decimal",
    ["decimal-always"] = "decimal",
}
local u98 = {}
u98["notation-simple"] = table.freeze({type = enums._Internal.NotationType.SIMPLE})
u98["precision-unlimited"] = table.freeze({type = enums._Internal.PrecisionType.UNLIMITED})
u98[".+"] = table.freeze({type = enums._Internal.PrecisionType.UNLIMITED})
u98["rounding-mode-ceiling"] = enums.RoundingMode.CEILING
u98["rounding-mode-floor"] = enums.RoundingMode.FLOOR
u98["rounding-mode-down"] = enums.RoundingMode.DOWN
u98["rounding-mode-up"] = enums.RoundingMode.UP
u98["rounding-mode-half-even"] = enums.RoundingMode.HALF_EVEN
u98["rounding-mode-half-down"] = enums.RoundingMode.HALF_DOWN
u98["rounding-mode-half-up"] = enums.RoundingMode.HALF_UP
u98["group-off"] = enums.GroupingStrategy.OFF
u98["group-min2"] = enums.GroupingStrategy.MIN2
u98["group-on-aligned"] = enums.GroupingStrategy.ON_ALIGNED
u98[",_"] = enums.GroupingStrategy.OFF
u98[",?"] = enums.GroupingStrategy.MIN2
u98[",!"] = enums.GroupingStrategy.ON_ALIGNED
u98["sign-auto"] = enums.SignDisplay.AUTO
u98["sign-always"] = enums.SignDisplay.ALWAYS
u98["sign-never"] = enums.SignDisplay.NEVER
u98["sign-except-zero"] = enums.SignDisplay.EXCEPT_ZERO
u98["sign-negative"] = enums.SignDisplay.NEGATIVE
u98["+!"] = enums.SignDisplay.ALWAYS
u98["+_"] = enums.SignDisplay.NEVER
u98["+?"] = enums.SignDisplay.EXCEPT_ZERO
u98["+-"] = enums.SignDisplay.NEGATIVE
u98["decimal-auto"] = enums.DecimalSeparatorDisplay.AUTO
u98["decimal-always"] = enums.DecimalSeparatorDisplay.ALWAYS

local function skeleton_to_scientific_notation(a1) -- Line: 257
    -- upvalues: enums (val), u98 (val), formatter_settings (val)
    local v1, v2, v3 = string.match(a1, "^(%a+)/?([^/]*)/?([^/]*)$")
    local v4 = 1
    local AUTO = enums.SignDisplay.AUTO
    if v1 ~= "scientific" and v1 ~= "engineering" then
        return nil
    end
    if string.match(v2, "^[%*%+]e+$") then
        v4 = #v2 - 1
        v2 = v3
    elseif string.match(v3, "^[%*%+]e+$") then
        v4 = #v3 - 1
    end
    if v2 ~= "" then
        if string.sub(v2, 1, 5) ~= "sign-" then
            return nil
        end
        AUTO = u98[v2]
    end
    if v4 > 999 then
        return nil
    end
    return table.freeze({
        type = enums._Internal.NotationType.SCIENTIFIC,
        power10Scale = if v1 ~= "engineering" then 1 else 3,
        minExponentDigits = v4,
        exponentSignDisplay = AUTO,
        displayExponentSignAt = formatter_settings.generate_from_sign_enum(AUTO),
    })
end

local function skeleton_to_scientific_notation_concise(a1) -- Line: 295
    -- upvalues: u98 (val), enums (val), formatter_settings (val)
    local AUTO
    local v1, v2 = string.match(a1, "^(EE?)(.+)$")
    local v3 = v1
    local v4 = v2
    if not v3 then
        return nil
    end
    local v5 = v4
    v1, v2 = string.match(v4, "^(%+[!%?])(.+)$")
    local v6 = v1
    v4 = v2
    if not v6 then
        v4 = v5
        AUTO = enums.SignDisplay.AUTO
    else
        AUTO = u98[v6]
    end
    if not string.match(v4, "^0+$") or #v4 > 999 then
        return nil
    end
    return table.freeze({
        type = enums._Internal.NotationType.SCIENTIFIC,
        power10Scale = if v3 ~= "EE" then 1 else 3,
        minExponentDigits = #v4,
        exponentSignDisplay = AUTO,
        displayExponentSignAt = formatter_settings.generate_from_sign_enum(AUTO),
    })
end

local function skeleton_to_precision(a1) -- Line: 334 -- upvalues: formatter_settings (val), enums (val)
    local MAX_PRECISION, v1
    local v2, v3, v4 = string.match(a1, "^%.((0*)#*)(.*)$")
    local v5 = v2
    local v6 = v3
    local v7 = v4
    if not v5 then
        v2, v3 = string.match(a1, "^(precision%-integer)(.*)$")
        v5 = v2
        v7 = v3
    end
    if not v5 then
        v2, v3, v4 = string.match(a1, "^((@+)#*)([%*%+]?)$")
        v1 = v2
        v7 = v4
        if v1 then
            v5 = #v3
            local MAX_PRECISION_2 = #v1
            if v7 ~= "" then
                if v5 ~= MAX_PRECISION_2 then
                    return nil
                end
                MAX_PRECISION_2 = -1
                v2 = string.sub(v7, 2)
            end
            if not (v5 > 999) and not (MAX_PRECISION_2 > 999) then
                if MAX_PRECISION_2 == -1 then
                    MAX_PRECISION_2 = formatter_settings.MAX_PRECISION
                end
                return table.freeze({
                    type = enums._Internal.PrecisionType.SIGNFICANT,
                    min = v5,
                    max = MAX_PRECISION_2,
                })
            end
            return nil
        end
        return nil
    end
    if v5 ~= "precision-integer" then
        v2 = #v6
        MAX_PRECISION = #v5
    else
        v2 = 0
        MAX_PRECISION = 0
    end
    if string.match(v7, "^[%*%+]") and v6 == v5 then
        MAX_PRECISION = -1
        v7 = string.sub(v7, 2)
    end
    if not (v2 > 999) and not (MAX_PRECISION > 999) then
        if MAX_PRECISION == -1 then
            MAX_PRECISION = formatter_settings.MAX_PRECISION
        end
        if string.sub(v7, 1, 1) ~= "/" then
            if v7 ~= "" then
                return nil
            end
            return table.freeze({
                type = enums._Internal.PrecisionType.FRACTION,
                min = v2,
                max = MAX_PRECISION,
            })
        end
        local v8 = false
        local v9, v10, v11 = string.match(v7, "^/((@+)#*)([%*%+rs]?)$")
        v1 = v9
        local v12 = v10
        v4 = v11
        if v1 then
            local RELAXED, freeze, v13, v14
            if v4 == "" and v12 ~= "@" then
                return nil
            end
            if v4 ~= "*" and v4 ~= "+" then
                if v4 == "" then
                    v14 = 1
                    v13 = #v1
                    v4 = "s"
                elseif v4 == "*" then
                    v14 = 1
                    v13 = #v12
                    v4 = "r"
                elseif v4 ~= "+" then
                    v8 = true
                    v14 = #v12
                    v13 = #v1
                else
                    v14 = 1
                    v13 = #v12
                    v4 = "r"
                end
                if not (v14 > 999) and not (v13 > 999) then
                    freeze = table.freeze
                    v10 = {
                        type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
                        minFractionDigits = v2,
                        maxFractionDigits = MAX_PRECISION,
                        minSignificantDigits = v14,
                        maxSignificantDigits = v13,
                    }
                    RELAXED = if v4 ~= "r" then enums.RoundingPriority.STRICT else enums.RoundingPriority.RELAXED
                    v10.roundingPriority = RELAXED
                    v10.sourcedWithSignificantDigits = v8
                    return freeze(v10)
                end
                return nil
            end
            if v12 == v1 then
                if v4 == "" then
                    v14 = 1
                    v13 = #v1
                    v4 = "s"
                elseif v4 == "*" then
                    v14 = 1
                    v13 = #v12
                    v4 = "r"
                elseif v4 ~= "+" then
                    v8 = true
                    v14 = #v12
                    v13 = #v1
                else
                    v14 = 1
                    v13 = #v12
                    v4 = "r"
                end
                if not (v14 > 999) and not (v13 > 999) then
                    freeze = table.freeze
                    v10 = {
                        type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
                        minFractionDigits = v2,
                        maxFractionDigits = MAX_PRECISION,
                        minSignificantDigits = v14,
                        maxSignificantDigits = v13,
                    }
                    RELAXED = if v4 ~= "r" then enums.RoundingPriority.STRICT else enums.RoundingPriority.RELAXED
                    v10.roundingPriority = RELAXED
                    v10.sourcedWithSignificantDigits = v8
                    return freeze(v10)
                end
                return nil
            end
        end
        return nil
    end
    return nil
end

local function skeleton_to_int_width(a1) -- Line: 451
    if a1 == "integer-width-trunc" then
        return table.freeze({min = 0, max = 0})
    end
    local v1 = string.match(a1, "^integer%-width/[%*%+](0*)$")
    if v1 then
        if #v1 > 999 then
            return nil
        end
        return table.freeze({max = -1, min = #v1})
    end
    local v2, v3 = string.match(a1, "^integer%-width/(#*(0*))$")
    local v4 = v2
    v1 = v3
    if v4 and v4 ~= "" and not (#v4 > 999) and not (#v1 > 999) then
        return table.freeze({min = #v1, max = #v4})
    end
    return nil
end

local function skeleton_to_int_width_concise(a1) -- Line: 481
    if string.match(a1, "^0+$") and #a1 < 1000 then
        return (table.freeze({max = -1, min = #a1}))
    end
    return nil
end

function v1.to_option_linked_list(a1) -- Line: 490
    -- upvalues: u70 (val), u98 (val), skeleton_to_scientific_notation (val)
    -- upvalues: skeleton_to_scientific_notation_concise (val), skeleton_to_precision (val), skeleton_to_int_width (val)
    -- upvalues: skeleton_to_int_width_concise (val)
    local v1, v2
    local v3 = nil
    local v4 = {}
    for i, j in string.gmatch(a1, "()(%S+)") do
        v2 = nil
        v1 = u70[j]
        if v1 then
            v2 = u98[j]
        end
        if not v2 and (skeleton_to_scientific_notation(j) or skeleton_to_scientific_notation_concise(j)) then
            v1 = "notation"
        end
        if not v2 and (skeleton_to_precision(j)) then
            v1 = "precision"
        end
        if not v2 and (skeleton_to_int_width(j) or skeleton_to_int_width_concise(j)) then
            v1 = "integerWidth"
        end
        if v1 and not v4[v1] then
            v4[v1] = true
            v3 = {key = v1, value = v2, parent = v3}
            continue
        end
        return false, string.format("number skeleton syntax error near '%*' at position %d", string.gsub(j, "'", "\\'"), i)
    end
    return true, v3
end

return v1