-- Script path: ReplicatedStorage.Packages.FormatNumber.Main.Notation
-- Decompile time: 2.22 ms

local _internal = require(script.Parent.Parent._internal)
local v1 = {}
local v2 = {}
local u17 = _internal.class.create_init_function("Notation", nil, v1, nil, _internal.class.ImmutabilityType.DEFAULT)
local v3 = {}
local u28 = _internal.class.create_init_function("ScientificNotation", "Notation", v3, v2, _internal.class.ImmutabilityType.DEFAULT)

function v3.WithMinExponentDigits(a1, a2) -- Line: 17
    -- upvalues: _internal (val), u28 (val)
    local v1 = _internal.class.try_coerce(1, a1, "ScientificNotation")
    local v2 = _internal.class.try_coerce_range(2, a2, 1, 999)
    v1 = table.clone(v1)
    v1.minExponentDigits = v2
    return u28(v1)
end

function v3.WithExponentSignDisplay(a1, a2) -- Line: 30
    -- upvalues: _internal (val), u28 (val)
    local v1 = _internal.class.try_coerce(1, a1, "ScientificNotation")
    local v2 = _internal.class.try_coerce_enum(2, a2, _internal.enums.SignDisplay)
    v1 = table.clone(v1)
    v1.exponentSignDisplay = v2
    v1.displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(v2)
    return u28(v1)
end

_internal.class.create_init_function("CompactNotation", "Notation", {}, v2, _internal.class.ImmutabilityType.DEFAULT)
_internal.class.create_init_function("SimpleNotation", "Notation", {}, v2, _internal.class.ImmutabilityType.DEFAULT)

function v1.scientific() -- Line: 64 -- upvalues: u28 (val), _internal (val)
    return u28({
        power10Scale = 1,
        minExponentDigits = 1,
        type = _internal.enums._Internal.NotationType.SCIENTIFIC,
        exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
        displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO),
    })
end

function v1.engineering() -- Line: 74 -- upvalues: u28 (val), _internal (val)
    return u28({
        power10Scale = 3,
        minExponentDigits = 1,
        type = _internal.enums._Internal.NotationType.SCIENTIFIC,
        exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
        displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO),
    })
end

function v1.compactWithSuffixThousands(a1) -- Line: 84 -- upvalues: _internal (val), u17 (val) -- types: a1: table
    local v1 = _internal.class.try_coerce(1, a1, "{string}")
    local v2 = table.find(v1, "")
    if v2 then
        error(string.format("Index %d is an empty string, please double check the suffixes", v2), 2)
    elseif #v1 == 0 then
        error("Suffixes is empty", 2)
    end
    return u17({
        power10Scale = 3,
        type = _internal.enums._Internal.NotationType.COMPACT,
        suffixes = v1,
        suffixesLength = #v1,
    })
end

function v1.simple() -- Line: 104 -- upvalues: u17 (val), _internal (val)
    return u17({type = _internal.enums._Internal.NotationType.SIMPLE})
end

return table.freeze(v1)