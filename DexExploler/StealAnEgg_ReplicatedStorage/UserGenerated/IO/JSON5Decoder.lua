-- Script path: ReplicatedStorage.UserGenerated.IO.JSON5Decoder
-- Decompile time: 16.18 ms

local u0 = {
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    "　",
    " ",
    "\r\n",
    "\t",
    "\n",
    "\011",
    "\012",
    "\r",
    " ",
}
local u26 = {" ", " ", "\r\n", "\r", "\n"}

local function MAKE_LOOKUP(a1) -- Line: 67 -- types: a1: table
    local v1 = {}
    for i, v in ipairs(a1) do
        v1[v] = true
    end
    return v1
end

local v1 = {}
for i, v in ipairs(u0) do
    v1[v] = true
end
local u46 = {}
for i2, i3 in ipairs(u26) do
    u46[i3] = true
end
local u60 = {
    ["0"] = "\000",
    ["'"] = "'",
    ["\""] = "\"",
    ["\\"] = "\\",
    b = "\008",
    f = "\012",
    n = "\n",
    r = "\r",
    t = "\t",
    v = "\011",
}

local function Q(a1) -- Line: 91
    return (((string.format("%q", a1)):gsub("\r", "\\r")):gsub("\n", "\\n"))
end

local function formatError(a1, a2) -- Line: 97 -- types: a1: string, a2: table
    return string.format("%s at line %d col %d", a1, a2[1], a2[2])
end

local function advanceNewline(a1, a2) -- Line: 103 -- upvalues: u46 (val) -- types: a1: string, a2: table
    if not u46[a1] then
        return false
    end
    a2[1] = a2[1] + 1
    a2[2] = 1
    return true
end

local function getNewline(a1, a2) -- Line: 115 -- upvalues: u26 (val), u46 (val) -- types: a1: string, a2: table
    local v1
    local v2, v3 = a1, a2
    for i, v in ipairs(u26) do
        if v2:sub(1, #v) == v then
            if not u46[v] then
                v1 = false
            else
                v3[1] = v3[1] + 1
                v3[2] = 1
                v1 = true
            end
            if v1 then
                return v
            end
        end
    end
    return nil
end

local function getWhitespace(a1, a2) -- Line: 127 -- upvalues: u0 (val), u46 (val) -- types: a1: string, a2: table
    if #a1 == 0 then
        return nil
    end
    for i, v in ipairs(u0) do
        if a1:sub(1, #v) == v then
            a2[2] = a2[2] + #v
            if not u46[v] then
                return v
            end
            a2[1] = a2[1] + 1
            a2[2] = 1
            return v
        end
    end
    return nil
end

local function stripWhitespace(a1, a2) -- Line: 145 -- upvalues: getWhitespace (val) -- types: a1: string, a2: table
    local v1
    while true do
        v1 = getWhitespace(a1, a2)
        if v1 == nil then
            break
        end
        a1:sub(#v1 + 1)
    end
    return a1
end

local function stripInlineComments(a1, a2) -- Line: 162 -- upvalues: getNewline (val) -- types: a1: string, a2: table
    local v1
    while #a1 ~= 0 do
        v1 = getNewline(a1, a2)
        if v1 then
            return (a1:sub(#v1 + 1))
        end
        a1:sub(2)
        a2[2] = a2[2] + 1
    end
    return a1
end

local function stripBlockComments(a1, a2) -- Line: 186
    -- upvalues: getNewline (val), formatError (val)
    local v1
    while #a1 > 0 do
        if a1:sub(1, 2) == "*/" then
            a2[2] = a2[2] + 2
            return a1:sub(3)
        end
        v1 = getNewline(a1, a2)
        if not v1 then
            a2[2] = a2[2] + 1
            a1:sub(2)
        else
            a1:sub(#v1 + 1)
        end
    end
    error(formatError("missing multiline comment close tag", a2))
    return ""
end

local function codepointToutf8(a1) -- Line: 210 -- types: a1: number
    if a1 <= 127 then
        return (string.char(a1))
    end
    if a1 <= 2047 then
        return (string.char(math.floor(a1 / 64) + 192, a1 % 64 + 128))
    end
    if a1 <= 65535 then
        return (string.char(math.floor(a1 / 4096) + 224, math.floor(a1 % 4096 / 64) + 128, a1 % 64 + 128))
    end
    if a1 <= 1114111 then
        return (string.char(math.floor(a1 / 262144) + 240, math.floor(a1 % 262144 / 4096) + 128, math.floor(a1 % 4096 / 64) + 128, a1 % 64 + 128))
    end
    return nil, string.format("invalid unicode codepoint '%x'", a1)
end

local function parseUnicodeImpl(a1, a2) -- Line: 232 -- upvalues: formatError (val) -- types: a1: string, a2: table
    local v1 = a1:match("^\\u(%x%x%x%x)")
    if not v1 then
        error(formatError("invalid unicode hex escape sequence", a2))
    end
    local v2 = tonumber(v1, 16)
    if not v2 then
        error(formatError("invalid unicode hex escape sequence", a2))
    end
    a2[2] = a2[2] + 6
    return v2, a1:sub(7)
end

local function getSurrogatePair(a1, a2) -- Line: 249 -- types: a1: number, a2: number
    return (a2 - 55296) * 1024 + (a1 - 56320) + 65536
end

local function parseUnicode(a1, a2) -- Line: 255
    -- upvalues: parseUnicodeImpl (val), codepointToutf8 (val), formatError (val)
    local v1 = a2[1]
    local v2 = a2[2]
    local v3, v4 = parseUnicodeImpl(a1, a2)
    local v5 = v3
    local v6 = v4
    if v5 >= 55296 and v5 < 56320 then
        local v7
        v4, v7 = parseUnicodeImpl(v6, a2)
        v3 = v4
        v6 = v7
        if v3 and v3 >= 56320 and v3 <= 57343 then
            v5 = (v5 - 55296) * 1024 + (v3 - 56320) + 65536
        end
    end
    v3, v4 = codepointToutf8(v5)
    if not v3 then
        error(formatError(assert(v4), {v1, v2}))
    end
    return v3, v6
end

local function parseStringImpl(a1, a2, a3, a4) -- Line: 285
    -- upvalues: u60 (val), formatError (val), parseUnicode (val), getNewline (val)
    local v1, v2, v3, v4, v5
    local v6 = {}
    local v7, v8, v9, v10 = a2, a1, a4, a3
    while not v7(v8) do
        v1 = v8:sub(1, 1)
        if v1 == "\\" then
            v2 = v8:sub(2, 2)
            v9[2] = v9[2] + 1
            if u60[v2] then
                v9[2] = v9[2] + 1
                if v10 then
                    error(formatError("escape sequence not allowed", v9))
                end
                v6[#v6 + 1] = u60[v2]
                v8 = v8:sub(3)
            elseif v2 == "u" then
                v4, v5 = parseUnicode(v8, v9)
                v8 = v5
                v6[#v6 + 1] = v4
            elseif v2 ~= "x" then
                if v10 then
                    error(formatError("invalid escape sequence", v9))
                end
                v3 = getNewline(v8:sub(2), v9)
                v4 = 2
                if v3 then
                    v4 = #v3 + 2
                end
                v8 = v8:sub(v4)
            else
                if v10 then
                    error(formatError("hex escape sequence not allowed", v9))
                end
                v9[2] = v9[2] + 2
                v4 = tonumber(v8:sub(2, 3), 16)
                if not v4 then
                    error(formatError("invalid hex escape sequence", v9))
                end
                v6[#v6 + 1] = (string.char(v4))
                v9[2] = v9[2] + 2
                v8 = v8:sub(5)
            end
        elseif not ((v1:byte(1, 1)) < 32) then
            v6[#v6 + 1] = v1
            v8 = v8:sub(2)
            v9[2] = v9[2] + 1
        else
            error(formatError("control character found", v9))
        end
    end
    return (table.concat(v6)), v8
end

local function parseString(a1, a2) -- Line: 364 -- upvalues: parseStringImpl (val) -- types: a1: string, a2: table
    local u7 = a1:sub(1, 1)
    local v1, v2 = parseStringImpl(a1:sub(2), function(a1) -- Line: 369 -- upvalues: u7 (val)
        return (a1:sub(1, 1)) == u7
    end, false, a2)
    a2[2] = a2[2] + 1
    return v1, v2:sub(2)
end

local function parseNumber(a1, a2) -- Line: 382
    -- upvalues: getWhitespace (val), formatError (val)
    local v1
    local v2 = 1
    local v3 = a1:sub(1, 1)
    local v4 = a2[1]
    local v5 = a2[2]
    if v3 == "+" then
        v2 = 1
        a1 = a1:sub(2)
        a2[2] = a2[2] + 1
    elseif v3 == "-" then
        v2 = -1
        a1 = a1:sub(2)
        a2[2] = a2[2] + 1
    end
    if a1:sub(1, 3) == "NaN" then
        a2[2] = a2[2] + 3
        return (0 / 0), a1:sub(4)
    end
    if a1:find("Infinity", 1, true) == 1 then
        a2[2] = a2[2] + 8
        return (1 / 0) * v2, a1:sub(9)
    end
    v3 = 0
    local v6 = a1
    while not getWhitespace(v6, a2) do
        v1 = v6:sub(1, 1)
        if v1 == "" or v1 == "," or v1 == "]" or v1 == "}" then
            break
        end
        v3 = v3 + 1
        v6 = v6:sub(2)
        a2[2] = a2[2] + 1
    end
    v6 = a1:sub(1, v3)
    if (if v6:sub(1, 1) ~= "0" then tonumber(v6) else if not (v6:sub(2)):find("^%d+$") then tonumber(v6) else nil) == nil then
        error(formatError("invalid number sequence " .. ((string.format("%q", v6)):gsub("\r", "\\r")):gsub("\n", "\\n"), {v4, v5}))
    end
    a2[2] = a2[2] + v3
    return v1 * v2, a1:sub(v3 + 1)
end

local function parseBoolean(a1, a2) -- Line: 460 -- upvalues: formatError (val) -- types: a1: string, a2: table
    if a1:sub(1, 4) == "true" then
        a2[2] = a2[2] + 4
        return true, a1:sub(5)
    end
    if a1:sub(1, 5) == "false" then
        a2[2] = a2[2] + 5
        return false, a1:sub(6)
    end
    error(formatError("invalid boolean literal", a2))
end

local function stripComments(a1, a2) -- Line: 474
    -- upvalues: stripInlineComments (val), stripBlockComments (val)
    local v1 = a1:sub(1, 2)
    if v1 == "//" then
        a2[2] = a2[2] + 2
        return (stripInlineComments(a1:sub(3), a2))
    end
    if v1 ~= "/*" then
        return a1
    end
    a2[2] = a2[2] + 2
    return stripBlockComments(a1:sub(3), a2)
end

local function stripWhitespaceAndComments(a1, a2) -- Line: 489
    -- upvalues: stripWhitespace (val), stripComments (val)
    repeat
    until (stripComments(stripWhitespace(a1, a2), a2)) == a1
    return a1
end

local u93 = nil

local function testIdentifier(a1) -- Line: 556 -- types: a1: string
    local v1 = a1:byte(1, 1)
    if v1 >= 48 and v1 <= 57 then
        return false
    end
    local v2 = #a1
    for i = 1, v2 do
        v1 = a1:byte(i, i)
        if v1 < 36 then
            return false
        end
        if v1 >= 37 and v1 <= 47 then
            return false
        end
        if v1 >= 58 and v1 <= 64 then
            return false
        end
        if v1 >= 91 and v1 <= 94 then
            return false
        end
        if v1 == 96 then
            return false
        end
        if v1 >= 123 and v1 <= 128 then
            return false
        end
    end
    return true
end

local function stopIdentifier(a1) -- Line: 593 -- upvalues: getWhitespace (val) -- types: a1: string
    local v1 = true
    if a1:sub(1, 1) ~= ":" then
        v1 = getWhitespace(a1, {0, 0}) ~= nil
    end
    return v1
end

local function parseIdentifier(a1, a2) -- Line: 599
    -- upvalues: parseString (val), parseStringImpl (val), stopIdentifier (val), testIdentifier (val), formatError (val)
    local v1, v2, v3, v4
    local v5 = a1:sub(1, 1)
    if v5 == "'" then
        v3, v4 = parseString(a1, a2)
        v2 = v3
        v1 = v4
    elseif v5 ~= "\"" then
        v3 = a2[1]
        v4 = a2[2]
        local v6, v7 = parseStringImpl(a1, stopIdentifier, true, a2)
        v2 = v6
        v1 = v7
        if not testIdentifier(v2) then
            error(formatError("invalid identifier " .. ((string.format("%q", v2)):gsub("\r", "\\r")):gsub("\n", "\\n"), {v3, v4}))
        end
    else
        v3, v4 = parseString(a1, a2)
        v2 = v3
        v1 = v4
    end
    return v2, v1
end

local u100 = {
    ["-"] = parseNumber,
    ["+"] = parseNumber,
    ["."] = parseNumber,
    ["0"] = parseNumber,
    ["1"] = parseNumber,
    ["2"] = parseNumber,
    ["3"] = parseNumber,
    ["4"] = parseNumber,
    ["5"] = parseNumber,
    ["6"] = parseNumber,
    ["7"] = parseNumber,
    ["8"] = parseNumber,
    ["9"] = parseNumber,
    N = parseNumber,
    I = parseNumber,
}

function u100.n(a1, a2, a3) -- Line: 449 -- upvalues: formatError (val) -- types: a1: string, a2: table
    if a1:sub(1, 4) ~= "null" then
        error(formatError("invalid null literal", a2))
    end
    a2[2] = a2[2] + 1
    return a3, a1:sub(5)
end

u100.t = parseBoolean
u100.f = parseBoolean
u100["'"] = parseString
u100["\""] = parseString

u100["["] = function(a1, a2, a3) -- Line: 514
    -- upvalues: stripWhitespaceAndComments (val), u93 (ref), formatError (val)
    local v1, v2, v3
    local v4 = a1:sub(2)
    a2[2] = a2[2] + 1
    local v5 = {}
    local v6, v7 = a2, a3
    while true do
        v4 = stripWhitespaceAndComments(v4, v6)
        if v4:sub(1, 1) == "]" then
            break
        end
        v2, v3 = u93(v4, v6, v7)
        v4 = stripWhitespaceAndComments(v3, v6)
        v5[#v5 + 1] = v2
        v1 = v4:sub(1, 1)
        v4 = v4:sub(2)
        if v1 ~= "]" then
            if v1 ~= "," then
                error(formatError("expected comma got " .. ((string.format("%q", v1)):gsub("\r", "\\r")):gsub("\n", "\\n"), v6))
            end
            v6[2] = v6[2] + 1
            continue
        else
            v6[2] = v6[2] + 1
        end
        return v5, v4
    end
    v6[2] = v6[2] + 1
    v4 = v4:sub(2)
    return v5, v4
end

u100["{"] = function(a1, a2, a3) -- Line: 624
    -- upvalues: stripWhitespaceAndComments (val), parseIdentifier (val), formatError (val), u93 (ref)
    local v1, v2, v3
    a2[2] = a2[2] + 1
    local v4 = a1:sub(2)
    local v5 = {}
    local v6 = a2
    while true do
        v4 = stripWhitespaceAndComments(v4, v6)
        if v4:sub(1, 1) == "}" then
            break
        end
        v1, v2 = parseIdentifier(v4, v6)
        v4 = stripWhitespaceAndComments(v2, v6)
        if v4:sub(1, 1) ~= ":" then
            error(formatError(
                "expected colon after identifier, got " .. ((string.format("%q", (v4:sub(1, 1)))):gsub("\r", "\\r")):gsub("\n", "\\n"),
                v6
            ))
        end
        v6[2] = v6[2] + 1
        v4 = v4:sub(2)
        v4 = stripWhitespaceAndComments(v4, v6)
        v2, v3 = u93(v4, v6, v7)
        v4 = stripWhitespaceAndComments(v3, v6)
        v5[v1] = v2
        v1 = v4:sub(1, 1)
        v4 = v4:sub(2)
        if v1 ~= "}" then
            if v1 ~= "," then
                error(formatError("expected comma got " .. ((string.format("%q", v1)):gsub("\r", "\\r")):gsub("\n", "\\n"), v6))
            end
            v6[2] = v6[2] + 1
            continue
        else
            v6[2] = v6[2] + 1
        end
        return v5, v4
    end
    v6[2] = v6[2] + 1
    v4 = v4:sub(2)
    return v5, v4
end

u100[""] = function(a1, a2) -- Line: 684 -- upvalues: formatError (val) -- types: a1: string, a2: table
    error(formatError("unexpected eof", a2))
end

function u93(a1, a2, a3) -- Line: 718
    -- upvalues: stripWhitespaceAndComments (val), u100 (val), formatError (val)
    local v1 = stripWhitespaceAndComments(a1, a2)
    local v2 = v1:sub(1, 1)
    local v3 = u100[v2]
    if not v3 then
        error(formatError("invalid value literal " .. ((string.format("%q", v2)):gsub("\r", "\\r")):gsub("\n", "\\n"), a2))
    end
    return v3(v1, a2, a3)
end

return (table.freeze({
    Null = newproxy(false),
    Decode = function(a1, a2) -- Line: 747
        -- upvalues: stripWhitespaceAndComments (val), u93 (ref), formatError (val)
        local v1 = {1, 1}
        local v2 = stripWhitespaceAndComments(a1, v1)
        local v3, v4 = u93(v2, v1, a2)
        if #stripWhitespaceAndComments(v4, v1) > 0 then
            error(formatError("trailing garbage", v1))
        end
        return v3
    end,
}))