-- Script path: ReplicatedStorage.CmdrClient.Shared.Util
-- Decompile time: 15.89 ms

local TextService = game:GetService("TextService")
local u5 = {}

function u5.MakeDictionary(a1) -- Line: 6
    local v1 = {}
    local v2 = #a1
    for i = 1, v2 do
        v1[a1[i]] = true
    end
    return v1
end

function u5.DictionaryKeys(a1) -- Line: 17
    local v1 = {}
    for k in pairs(a1) do
        table.insert(v1, k)
    end
    return v1
end

local function transformInstanceSet(a1) -- Line: 28
    local v1 = {}
    local v2 = #a1
    for i = 1, v2 do
        v1[i] = a1[i].Name
    end
    return v1, a1
end

function u5.MakeFuzzyFinder(a1) -- Line: 42
    local v1, v2
    local u63 = nil
    local u2 = {}
    if typeof(a1) == "Enum" then
        a1 = a1:GetEnumItems()
    end
    if typeof(a1) == "Instance" then
        local Children = a1:GetChildren()
        v1 = {}
        v2 = #Children
        for n = 1, v2 do
            v1[n] = Children[n].Name
        end
        u63 = v1
        u2 = Children
    elseif typeof(a1) ~= "table" then
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
    elseif typeof(a1[1]) == "Instance" then
        v1 = {}
        v2 = #a1
        for i = 1, v2 do
            v1[i] = a1[i].Name
        end
        u63 = v1
        u2 = a1
    elseif typeof(a1[1]) == "EnumItem" then
        v1 = {}
        v2 = #a1
        for j = 1, v2 do
            v1[j] = a1[j].Name
        end
        u63 = v1
        u2 = a1
    elseif typeof(a1[1]) ~= "table" then
        if type(a1[1]) == "string" then
            u63 = a1
        elseif a1[1] == nil then
            u63 = {}
        else
            error("MakeFuzzyFinder only accepts tables of instances or strings.")
        end
    elseif typeof(a1[1].Name) == "string" then
        v1 = {}
        v2 = #a1
        for k = 1, v2 do
            v1[k] = a1[k].Name
        end
        u63 = v1
        u2 = a1
    elseif type(a1[1]) == "string" then
        u63 = a1
    elseif a1[1] == nil then
        u63 = {}
    else
        error("MakeFuzzyFinder only accepts tables of instances or strings.")
    end
    return function(a1, a2) -- Line: 70 -- upvalues: u63 (ref), u2 (ref)
        local v1
        local v2 = {}
        local v3, v4 = a2, a1
        for k, v in pairs(u63) do
            v1 = u2 and u2[k] or v
            if (v:lower()) == v4:lower() then
                if v3 then
                    return v1
                end
                table.insert(v2, 1, v1)
            elseif (v:lower()):find(v4:lower(), 1, true) then
                v2[#v2 + 1] = v1
            end
        end
        if v3 then
            return v2[1]
        end
        return v2
    end
end

function u5.GetNames(a1) -- Line: 98
    local Name
    local v1 = {}
    local v2 = #a1
    local v3 = a1
    for i = 1, v2 do
        Name = v3[i].Name or tostring(v3[i])
        v1[i] = Name
    end
    return v1
end

function u5.SplitStringSimple(a1, a2) -- Line: 109
    if a2 == nil then
        a2 = "%s"
    end
    local v1 = {}
    local v2 = 1
    for i in string.gmatch(a1, "([^" .. a2 .. "]+)") do
        v1[v2] = i
        v2 = v2 + 1
    end
    return v1
end

local function charCode(a1) -- Line: 122
    return utf8.char((tonumber(a1, 16)))
end

function u5.ParseEscapeSequences(a1) -- Line: 127 -- upvalues: charCode (val)
    return ((a1:gsub("\\(.)", {t = "\t", n = "\n"})):gsub("\\u(%x%x%x%x)", charCode)):gsub("\\x(%x%x)", charCode)
end

function u5.EncodeEscapedOperator(a1, a2) -- Line: 136
    local v1 = a2:sub(1, 1)
    local v2 = a2:gsub(".", "%%%1")
    return a1:gsub("(" .. ("%" .. v1) .. "+)(" .. v2 .. ")", function(a1, a2) -- Line: 141
        return ((a1:sub(1, #a1 - 1)) .. a2):gsub(".", function(a1) -- Line: 142
            return "\\u" .. string.format("%04x", string.byte(a1), 16)
        end)
    end)
end

local u15 = {"&&", "||", ";"}

function u5.EncodeEscapedOperators(a1) -- Line: 149 -- upvalues: u15 (val), u5 (val)
    local v1 = a1
    for i, v in ipairs(u15) do
        v1 = u5.EncodeEscapedOperator(v1, v)
    end
    return v1
end

local function encodeControlChars(a1) -- Line: 157
    return ((((a1:gsub("\\\\", "___!CMDR_ESCAPE!___")):gsub("\\\"", "___!CMDR_QUOTE!___")):gsub("\\'", "___!CMDR_SQUOTE!___")):gsub(
        "\\\n",
        "___!CMDR_NL!___"
    ))
end

local function decodeControlChars(a1) -- Line: 167
    return (((a1:gsub("___!CMDR_ESCAPE!___", "\\")):gsub("___!CMDR_QUOTE!___", "\"")):gsub("___!CMDR_NL!___", "\n"))
end

function u5.SplitString(a1, a2) -- Line: 177 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = a2 or (1 / 0)
    local v8 = {}
    local v9 = nil
    local v10 = nil
    for i in ((((a1:gsub("\\\\", "___!CMDR_ESCAPE!___")):gsub("\\\"", "___!CMDR_QUOTE!___")):gsub("\\'", "___!CMDR_SQUOTE!___")):gsub(
        "\\\n",
        "___!CMDR_NL!___"
    )):gmatch("[^ ]+") do
        v6 = u5.ParseEscapeSequences(i)
        v1 = v6:match("^(['\"])")
        v2 = v6:match("(['\"])$")
        v3 = v6:match("(\\*)['\"]$")
        if not v1 or v10 then
            if not v9 or v2 ~= v10 then
                if v9 then
                    v9 = v9 .. " " .. v6
                end
            elseif #v3 % 2 == 0 then
                v6 = v9 .. " " .. v6
                v9 = nil
            elseif v9 then
                v9 = v9 .. " " .. v6
            end
        elseif not v2 then
            v9 = v6
        elseif not v9 or v2 ~= v10 then
            if v9 then
                v9 = v9 .. " " .. v6
            end
        elseif #v3 % 2 == 0 then
            v6 = v9 .. " " .. v6
            v9 = nil
        elseif v9 then
            v9 = v9 .. " " .. v6
        end
        if not v9 then
            v5 = #v8
            v4 = v5 + (if not (v7 < #v8) then 1 else 0)
            v8[v4] = (((((v6:gsub("^(['\"])", "")):gsub("(['\"])$", "")):gsub("___!CMDR_ESCAPE!___", "\\")):gsub("___!CMDR_QUOTE!___", "\"")):gsub(
                "___!CMDR_NL!___",
                "\n"
            ))
        end
    end
    if v9 then
        local v11 = #v8
        local v12 = v11 + (if not (v7 < #v8) then 1 else 0)
        v8[v12] = (((v9:gsub("___!CMDR_ESCAPE!___", "\\")):gsub("___!CMDR_QUOTE!___", "\"")):gsub("___!CMDR_NL!___", "\n"))
    end
    return v8
end

function u5.MashExcessArguments(a1, a2) -- Line: 209
    local v1 = {}
    local v2 = #a1
    local v3, v4 = a2, a1
    for i = 1, v2 do
        if not (v3 < i) then
            v1[i] = v4[i]
        else
            v1[v3] = (("%s %s"):format(v1[v3] or "", v4[i]))
        end
    end
    return v1
end

function u5.TrimString(a1) -- Line: 222
    local v1
    _, v1 = string.find(a1, "^%s*")
    if v1 == #a1 then
        return ""
    end
    return (string.match(a1, ".*%S", v1 + 1))
end

function u5.GetTextSize(a1, a2, a3) -- Line: 229 -- upvalues: TextService (val)
    local TextSize = a2.TextSize
    local Font = a2.Font
    return TextService:GetTextSize(a1, TextSize, Font, a3 or Vector2.new(a2.AbsoluteSize.X, 0))
end

function u5.MakeEnumType(a1, a2) -- Line: 234 -- upvalues: u5 (val)
    local u5_2 = u5.MakeFuzzyFinder(a2)
    return {
        Validate = function(a1_2) -- Line: 237 -- upvalues: u5_2 (val), a1 (val)
            return u5_2(a1_2, true) ~= nil, ("Value %q is not a valid %s."):format(a1_2, a1)
        end,
        Autocomplete = function(a1) -- Line: 240 -- upvalues: u5_2 (val), u5 (upval)
            local v1 = u5_2(a1)
            return not (type(v1[1]) == "string") and u5.GetNames(v1) or v1
        end,
        Parse = function(a1) -- Line: 244 -- upvalues: u5_2 (val)
            return u5_2(a1, true)
        end,
    }
end

function u5.ParsePrefixedUnionType(a1, a2) -- Line: 251 -- upvalues: u5 (val)
    local v1 = u5.SplitStringSimple(a1)
    local v2 = {}
    local v3 = #v1
    for i = 1, v3, 2 do
        v2[#v2 + 1] = {prefix = v1[i - 1] or "", type = v1[i]}
    end
    table.sort(v2, function(a1, a2) -- Line: 265
        local v1 = #a1.prefix
        return #a2.prefix < v1
    end)
    v3 = #v2
    for j = 1, v3 do
        v1 = v2[j]
        if (a2:sub(1, #v1.prefix)) == v1.prefix then
            return v1.type, (a2:sub(#v1.prefix + 1)), v1.prefix
        end
    end
end

function u5.MakeListableType(a1, a2) -- Line: 280
    local v1 = {
        Listable = true,
        Transform = a1.Transform,
        Validate = a1.Validate,
        ValidateOnce = a1.ValidateOnce,
        Autocomplete = a1.Autocomplete,
        Default = a1.Default,
        ArgumentOperatorAliases = a1.ArgumentOperatorAliases,
        Parse = function(...) -- Line: 289 -- upvalues: a1 (val)
            return {a1.Parse(...)}
        end,
    }
    if a2 then
        for k, v in pairs(a2) do
            v1[k] = v
        end
    end
    return v1
end

local function encodeCommandEscape(a1) -- Line: 303
    return (a1:gsub("\\%$", "___!CMDR_DOLLAR!___"))
end

local function decodeCommandEscape(a1) -- Line: 307
    return (a1:gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.RunCommandString(a1, a2) -- Line: 311 -- upvalues: u5 (val)
    local v1, v2
    local v3 = u5.EncodeEscapedOperators((u5.ParseEscapeSequences(a2))):split("&&")
    local v4 = ""
    local v5 = a1
    for i, v in ipairs(v3) do
        v2 = (v4:gsub("%$", "\\x24")):gsub("%%", "%%%%")
        v1 = v4:find("%s") and ("%q"):format(v2) or v2
        v4 = tostring((v5:EvaluateAndRun((u5.RunEmbeddedCommands(v5, (v:gsub("||", v1)))))))
        if i == #v3 then
            return v4
        end
    end
end

function u5.RunEmbeddedCommands(a1, a2) -- Line: 338 -- upvalues: u5 (val)
    local v1, v2, v3
    local v4 = a2:gsub("\\%$", "___!CMDR_DOLLAR!___")
    local v5 = {}
    for i in v4:gmatch("$(%b{})") do
        v2 = true
        v1 = #i - 1
        v3 = i:sub(2, v1)
        if v3:match("^{.+}$") then
            v2 = false
            v3 = v3:sub(2, #v3 - 1)
        end
        v5[i] = (u5.RunCommandString(v6, v3))
        if v2 then
            if v5[i]:find("%s") or v5[i] == "" then
                v5[i] = (string.format("%q", v5[i]))
            end
        end
    end
    return ((v4:gsub("$(%b{})", v5)):gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.SubstituteArgs(a1, a2) -- Line: 366
    local v1 = a1:gsub("\\%$", "___!CMDR_DOLLAR!___")
    if type(a2) == "table" then
        local v2
        local v3 = #a2
        for i = 1, v3 do
            v2 = tostring(i)
            a2[v2] = a2[i]
            if a2[v2]:find("%s") then
                a2[v2] = (string.format("%q", a2[v2]))
            end
        end
    end
    return (((v1:gsub("($%d+)%b{}", "%1")):gsub("$(%w+)", a2)):gsub("___!CMDR_DOLLAR!___", "$"))
end

function u5.MakeAliasCommand(a1, a2) -- Line: 383 -- upvalues: u5 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = a1:split("|")
    v9, v10 = unpack(v10)
    local v11 = {}
    local u124 = u5.EncodeEscapedOperators(a2)
    local v12 = {}
    for i in u124:gmatch("$(%d+)") do
        if v12[i] == nil then
            v12[i] = true
            v3 = ("$%*(%%b{})"):format(i)
            v1 = u124:match(v3)
            v3 = nil
            v4 = nil
            v5 = nil
            if v1 then
                v7 = v1:sub(2, #v1 - 1):split("|")
                v6, v7, v8 = unpack(v7)
                v3 = v6
                v4 = v7
                v5 = v8
            end
            v2 = v3 and not not v3:match("%?$")
            v3 = if not v3 then "string" else v3:match("^%w+")
            table.insert(v11, {
                Type = v3,
                Name = v4 or ("Argument %*"):format(i),
                Description = v5 or "",
                Optional = v2,
            })
        end
    end
    return {
        Group = "UserAlias",
        Name = v9,
        Aliases = {},
        Description = ("<Alias> %*"):format(v10 or u124),
        Args = v11,
        Run = function(a1) -- Line: 422 -- upvalues: u5 (upval), u124 (ref)
            return u5.RunCommandString(a1.Dispatcher, u5.SubstituteArgs(u124, a1.RawArguments))
        end,
    }
end

function u5.MakeSequenceType(a1) -- Line: 429 -- upvalues: u5 (val)
    local u4 = a1 or {}
    local v1 = true
    if u4.Parse == nil then
        v1 = u4.Constructor ~= nil
    end
    assert(v1, "MakeSequenceType: Must provide one of: Constructor, Parse")
    local TransformEach = u4.TransformEach or function(...) -- Line: 434
        return ...
    end
    u4.TransformEach = TransformEach
    local ValidateEach = u4.ValidateEach or function() -- Line: 438
        return true
    end
    u4.ValidateEach = ValidateEach
    local v2 = {
        Prefixes = u4.Prefixes,
        Transform = function(a1) -- Line: 445 -- upvalues: u5 (upval), u4 (ref)
            return u5.Map(u5.SplitPrioritizedDelimeter(a1, {",", "%s"}), function(a1) -- Line: 446 -- upvalues: u4 (upval)
                return u4.TransformEach(a1)
            end)
        end,
        Validate = function(a1) -- Line: 451 -- upvalues: u4 (ref)
            local v1, v2
            if u4.Length then
                local v3 = #a1
                if u4.Length < v3 then
                    return false, ("Maximum of %d values allowed in sequence"):format(u4.Length)
                end
            end
            local Length_2 = u4.Length or #a1
            for i = 1, Length_2 do
                v1, v2 = u4.ValidateEach(a1[i], i)
                if not v1 then
                    return false, v2
                end
            end
            return true
        end,
    }
    local Parse = u4.Parse or function(a1) -- Line: 467 -- upvalues: u4 (ref)
        return u4.Constructor(unpack(a1))
    end
    v2.Parse = Parse
    return v2
end

function u5.SplitPrioritizedDelimeter(a1, a2) -- Line: 475 -- upvalues: u5 (val)
    for i, v in ipairs(a2) do
        if not a1:find(v) and i ~= #a2 then
            continue
        end
        return u5.SplitStringSimple(a1, v)
    end
end

function u5.Map(a1, a2) -- Line: 484
    local v1 = {}
    for i, v in ipairs(a1) do
        v1[i] = (a2(v, i))
    end
    return v1
end

function u5.Each(a1, ...) -- Line: 495
    local v1 = {}
    for i, v in ipairs({...}) do
        v1[i] = (a1(v))
    end
    return unpack(v1)
end

function u5.EmulateTabstops(a1, a2) -- Line: 504
    local v1, v2
    local v3 = 0
    local v4 = #a1
    local v5 = table.create(v4)
    local v6, v7 = a1, a2
    for i = 1, v4 do
        v1 = string.sub(v6, i, i)
        if v1 ~= "\t" then
            table.insert(v5, v1)
            if v1 ~= "\n" then
                if v1 ~= "\r" then
                    v3 = v3 + 1
                end
            end
        else
            v2 = v7 - v3 % v7
            table.insert(v5, (string.rep(" ", v2)))
            v3 = v3 + v2
        end
    end
    return table.concat(v5)
end

function u5.Mutex() -- Line: 526
    local u0 = {}
    local u1 = false
    return function() -- Line: 530 -- upvalues: u1 (ref), u0 (val)
        if not u1 then
            u1 = true
        else
            table.insert(u0, (coroutine.running()))
            coroutine.yield()
        end
        return function() -- Line: 538 -- upvalues: u0 (upval), u1 (upval)
            if #u0 > 0 then
                coroutine.resume(table.remove(u0, 1))
                return
            end
            u1 = false
        end
    end
end

return u5