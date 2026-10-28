-- Script path: ReplicatedStorage.UserGenerated.Lang.Asserts
-- Decompile time: 48.33 ms

local function IsEqual(a1, a2) -- Line: 23
    if rawequal(a1, a2) then
        return true
    end
    if type(a1) == "number" and type(a2) == "number" and a1 ~= a1 and a2 ~= a2 then
        return true
    end
    return false
end

local function IsASCII(a1) -- Line: 37 -- types: a1: string
    local v1
    for i = 1, (string.len(a1)) do
        v1 = string.byte(a1, i)
        if not (v1 < 32) and not (v1 > 126) then
            continue
        end
        return false
    end
    return true
end

local function IsFinite(a1) -- Line: 49 -- types: a1: number
    local v1 = false
    if a1 == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    return v1
end

local function IsInteger(a1) -- Line: 55 -- types: a1: number
    local v1 = false
    if math.floor(a1) == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    return v1
end

local function LuaString(a1) -- Line: 72 -- types: a1: string
    return ((string.format("%q", a1)):gsub("\n", "n"))
end

local function StringRep(a1) -- Line: 77
    if type(a1) == "string" then
        return ((string.format("%q", a1)):gsub("\n", "n"))
    end
    if typeof(a1) == "Instance" then
        return a1:GetFullName()
    end
    return (tostring(a1))
end

local function SafeKeyStringRep(a1) -- Line: 86
    if type(a1) ~= "number" and type(a1) ~= "boolean" then
        local v1, v2
        if type(a1) ~= "string" then
            if typeof(a1) == "Instance" then
                return a1:GetFullName()
            end
            return (("UnknownType(%*)"):format((typeof(a1))))
        end
        local v3 = utf8.len(a1)
        if not v3 then
            return "InvalidUTF8"
        end
        for i = 1, (string.len(a1)) do
            v2 = string.byte(a1, i)
            if v2 < 32 then
                v1 = false
            elseif not (v2 > 126) then
                continue
            else
                v1 = false
            end
            if not v1 then
                return "NonASCII"
            end
            if v3 > 30 then
                return (("%*...%*"):format((string.format("%q", (string.sub(a1, 1, 30)))):gsub("\n", "n"), v3 - 30))
            end
            return ((string.format("%q", a1)):gsub("\n", "n"))
        end
        if false then
            return "NonASCII"
        end
        if v3 > 30 then
            return (("%*...%*"):format((string.format("%q", (string.sub(a1, 1, 30)))):gsub("\n", "n"), v3 - 30))
        end
        return ((string.format("%q", a1)):gsub("\n", "n"))
    end
    return (("%*"):format(a1))
end

local function StripErrorSource(a1) -- Line: 107
    local v1 = tostring(a1)
    local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")
    if v2 and v3 then
        v1 = v3
    end
    return v1
end

local function ParseError(a1) -- Line: 118
    local v1 = tostring(a1)
    local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")
    if v2 and v3 then
        v1 = v3
    end
    v2, v3 = string.match(v1, "^(.+) $(%[.+)$")
    if v2 and v3 then
        v1 = v2
    end
    return v1, v3
end

local function MakeError(a1, a2) -- Line: 130 -- types: a1: string, a2: string
    return (("%* $%*"):format(a1, a2))
end

local u13 = {}

function u13.IsCFrameFinite(a1) -- Line: 59 -- types: a1: Vector2
    local Components_11, Components_12, Components, Components_2, Components_3, Components_4, Components_5, Components_6, Components_7, Components_8, Components_9, Components_10 = a1:GetComponents()
    local v1 = Components_11 + Components_12 + Components + Components_2 + Components_3 + Components_4 + Components_5 + Components_6 + Components_7 + Components_8 + Components_9 + Components_10
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    return v2
end

function u13.IsVector2Finite(a1) -- Line: 64 -- types: a1: userdata
    local v1 = a1.X + a1.Y
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    return v2
end

function u13.IsVector3Finite(a1) -- Line: 68 -- types: a1: vector
    local v1 = a1.X + a1.Y + a1.Z
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    return v2
end

function u13.Array(a1) -- Line: 140 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: function
    u13.Function(a1)
    return function(a1_2) -- Line: 142 -- upvalues: SafeKeyStringRep (upval), a1 (val) -- types: a1_2: table
        local err, success, v1, v2, v3, v4
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v5 = rawlen(a1_2)
        local v6 = 0
        for k, v in pairs(a1_2) do
            v6 = v6 + 1
            if k ~= v6 then
                error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if v5 < v6 then
                error(("IndexOverflow $%*"):format((("[%*]"):format(v6))), 2)
            end
            success, err = pcall(a1, v)
            if not success then
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v2 = v3
                end
                v1 = v2
                v2 = error
                v4 = ("[%*]%*"):format(v6, v4 or "")
                v2(("%* $%*"):format(v1, v4), 2)
            end
        end
        if v5 ~= v6 then
            error("LengthMismatch", 2)
        end
        return v7
    end
end

function u13.ArrayCoerce(a1) -- Line: 172 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: function
    u13.Function(a1)
    return function(a1_2) -- Line: 174 -- upvalues: SafeKeyStringRep (upval), a1 (val) -- types: a1_2: table
        local err, success, v1, v2, v3, v4
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v5 = rawlen(a1_2)
        local v6 = 0
        local v7 = {}
        for k, v in pairs(a1_2) do
            v6 = v6 + 1
            if k ~= v6 then
                error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if v5 < v6 then
                error(("IndexOverflow $%*"):format((("[%*]"):format(v6))), 2)
            end
            success, err = pcall(a1, v)
            if not success then
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v2 = v3
                end
                v1 = v2
                v2 = error
                v4 = ("[%*]%*"):format(v6, v4 or "")
                v2(("%* $%*"):format(v1, v4), 2)
            end
            v7[k] = err
        end
        if v5 ~= v6 then
            error("LengthMismatch", 2)
        end
        return v7
    end
end

function u13.UniqueArray(a1) -- Line: 206 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: function
    u13.Function(a1)
    return function(a1_2) -- Line: 208 -- upvalues: SafeKeyStringRep (upval), a1 (val) -- types: a1_2: table
        local err, success, v1, v2, v3, v4
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v5 = {}
        local v6 = rawlen(a1_2)
        local v7 = 0
        for k, v in pairs(a1_2) do
            v7 = v7 + 1
            if k ~= v7 then
                error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if v6 < v7 then
                error(("IndexOverflow $%*"):format((("[%*]"):format(v7))), 2)
            end
            if v5[v] then
                error(("UniqueArray $%*"):format((("[%*]"):format(v7))), 2)
            end
            v5[v] = true
            if not v5[v] then
                error(("InvalidKey $%*"):format((("[%*]"):format(v7))), 2)
            end
            success, err = pcall(a1, v)
            if not success then
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v2 = v3
                end
                v1 = v2
                v2 = error
                v4 = ("[%*]%*"):format(v7, v4 or "")
                v2(("%* $%*"):format(v1, v4), 2)
            end
        end
        if v6 ~= v7 then
            error("LengthMismatch", 2)
        end
        return v8
    end
end

function u13.UniqueArrayCoerce(a1) -- Line: 246 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: function
    u13.Function(a1)
    return function(a1_2) -- Line: 248 -- upvalues: SafeKeyStringRep (upval), a1 (val) -- types: a1_2: table
        local err, success, v1, v2, v3, v4
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v5 = {}
        local v6 = rawlen(a1_2)
        local v7 = 0
        local v8 = {}
        for k, v in pairs(a1_2) do
            v7 = v7 + 1
            if k ~= v7 then
                error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if v6 < v7 then
                error(("IndexOverflow $%*"):format((("[%*]"):format(v7))), 2)
            end
            if v5[v] then
                error(("UniqueArray $%*"):format((("[%*]"):format(v7))), 2)
            end
            v5[v] = true
            if not v5[v] then
                error(("InvalidKey $%*"):format((("[%*]"):format(v7))), 2)
            end
            success, err = pcall(a1, v)
            if not success then
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v2 = v3
                end
                v1 = v2
                v2 = error
                v4 = ("[%*]%*"):format(v7, v4 or "")
                v2(("%* $%*"):format(v1, v4), 2)
            end
            v8[k] = err
        end
        if v6 ~= v7 then
            error("LengthMismatch", 2)
        end
        return v8
    end
end

function u13.Map(a1, a2, a3) -- Line: 289
    -- upvalues: u13 (val), SafeKeyStringRep (val)
    u13.Function(a1)
    u13.Function(a2)
    u13.Optional(u13.IntegerPositive)(a3)
    local u18 = a3 or (1 / 0)
    return function(a1_2) -- Line: 295 -- upvalues: u18 (val), a1 (val), SafeKeyStringRep (upval), a2 (val)
        local err, err_2, success, success_2, v1, v2, v3, v4, v5, v6
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v7 = 0
        for k, v in pairs(a1_2) do
            v7 = v7 + 1
            if u18 < v7 then
                error(("LengthLimit(%*)"):format(u18), 2)
            end
            success, err = pcall(a1, k)
            if not success then
                v1 = tostring(err)
                v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")
                if v2 and v3 then
                    v1 = v3
                end
                v2, v3 = string.match(v1, "^(.+) $(%[.+)$")
                if v2 and v3 then
                    v1 = v2
                end
                v6 = v1
                v1 = error
                v3 = ("<%*>%*"):format(SafeKeyStringRep(k), v3 or "")
                v1(("%* $%*"):format(v6, v3), 2)
            end
            success_2, err_2 = pcall(a2, v)
            if not success_2 then
                v5 = tostring(err_2)
                v3, v4 = string.match(v5, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v5 = v4
                end
                v3, v4 = string.match(v5, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v5 = v3
                end
                error(("%* $%*"):format(v5, (("[%*]%*"):format(SafeKeyStringRep(k), v4 or ""))), 2)
            end
        end
        return a1_2
    end
end

function u13.MapCoerce(a1, a2, a3) -- Line: 324
    -- upvalues: u13 (val), SafeKeyStringRep (val)
    u13.Function(a1)
    u13.Function(a2)
    u13.Optional(u13.IntegerPositive)(a3)
    local u18 = a3 or (1 / 0)
    return function(a1_2) -- Line: 334 -- upvalues: u18 (val), a1 (val), SafeKeyStringRep (upval), a2 (val)
        local err, err_2, success, success_2, v1, v2, v3, v4, v5, v6
        if type(a1_2) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1_2) ~= nil then
            error("metatable", 2)
        end
        local v7 = 0
        local v8 = {}
        for k, v in pairs(a1_2) do
            v7 = v7 + 1
            if u18 < v7 then
                error(("LengthLimit(%*)"):format(u18), 2)
            end
            success, err = pcall(a1, k)
            if not success then
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
                if v3 and v4 then
                    v2 = v3
                end
                v1 = v2
                v2 = error
                v4 = ("<%*>%*"):format(SafeKeyStringRep(k), v4 or "")
                v2(("%* $%*"):format(v1, v4), 2)
            end
            success_2, err_2 = pcall(a2, v)
            if not success_2 then
                v6 = tostring(err_2)
                v4, v5 = string.match(v6, "^(.*:%d+): (.+)$")
                if v4 and v5 then
                    v6 = v5
                end
                v4, v5 = string.match(v6, "^(.+) $(%[.+)$")
                if v4 and v5 then
                    v6 = v4
                end
                error(("%* $%*"):format(v6, (("[%*]%*"):format(SafeKeyStringRep(k), v5 or ""))), 2)
            end
            v8[err] = err_2
        end
        return v8
    end
end

function u13.Table(a1) -- Line: 365 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: table
    u13.NoMetatable(a1)
    for k, v in pairs(a1) do
        u13.Function(v)
    end
    local u21 = table.clone(a1)
    return function(a1) -- Line: 372 -- upvalues: u21 (ref), SafeKeyStringRep (upval)
        local err, success, v1, v2, v3
        if type(a1) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1) ~= nil then
            error("metatable", 2)
        end
        local v4 = u21
        if (rawlen(v4)) ~= rawlen(a1) then
            error("LengthMismatch", 2)
        end
        for k, v in pairs(a1) do
            if not u21[k] then
                error(("UnknownKey $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
        end
        local v5 = a1
        for k2, i in pairs(u21) do
            v3 = v5[k2]
            success, err = pcall(i, v3)
            if not success then
                v3 = tostring(err)
                v1, v2 = string.match(v3, "^(.*:%d+): (.+)$")
                if v1 and v2 then
                    v3 = v2
                end
                v1, v2 = string.match(v3, "^(.+) $(%[.+)$")
                if v1 and v2 then
                    v3 = v1
                end
                error(("%* $%*"):format(v3, (("[%*]%*"):format(
                    if type(k2) ~= "string" then if typeof(k2) ~= "Instance" then tostring(k2) else k2:GetFullName() else ((string.format("%q", k2)):gsub("\n", "n")),
                    v2 or ""
                ))), 2)
            end
        end
        return v5
    end
end

function u13.TablePermissive(a1) -- Line: 399 -- upvalues: u13 (val) -- types: a1: table
    u13.NoMetatable(a1)
    for k, v in pairs(a1) do
        u13.Function(v)
    end
    local u21 = table.clone(a1)
    return function(a1) -- Line: 406 -- upvalues: u21 (ref)
        local err, success, v1, v2, v3
        if type(a1) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1) ~= nil then
            error("metatable", 2)
        end
        local v4 = u21
        if (rawlen(v4)) ~= rawlen(a1) then
            error("LengthMismatch", 2)
        end
        local v5 = a1
        for k, v in pairs(u21) do
            v3 = v5[k]
            success, err = pcall(v, v3)
            if not success then
                v3 = tostring(err)
                v1, v2 = string.match(v3, "^(.*:%d+): (.+)$")
                if v1 and v2 then
                    v3 = v2
                end
                v1, v2 = string.match(v3, "^(.+) $(%[.+)$")
                if v1 and v2 then
                    v3 = v1
                end
                error(("%* $%*"):format(v3, (("[%*]%*"):format(
                    if type(k) ~= "string" then if typeof(k) ~= "Instance" then tostring(k) else k:GetFullName() else ((string.format("%q", k)):gsub("\n", "n")),
                    v2 or ""
                ))), 2)
            end
        end
        return v5
    end
end

function u13.TableCoerce(a1) -- Line: 434 -- upvalues: u13 (val), SafeKeyStringRep (val) -- types: a1: table
    u13.NoMetatable(a1)
    for k, v in pairs(a1) do
        u13.Function(v)
    end
    local u21 = table.clone(a1)
    return function(a1) -- Line: 441 -- upvalues: u21 (ref), SafeKeyStringRep (upval)
        local err, success, v1, v2, v3
        if type(a1) ~= "table" then
            error("table", 2)
        end
        if getmetatable(a1) ~= nil then
            error("metatable", 2)
        end
        local v4 = u21
        if (rawlen(v4)) ~= rawlen(a1) then
            error("LengthMismatch", 2)
        end
        local v5 = {}
        for k, v in pairs(a1) do
            if not u21[k] then
                error(("UnknownKey $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
        end
        for k2, i in pairs(u21) do
            v3 = a1[k2]
            success, err = pcall(i, v3)
            if not success then
                v3 = tostring(err)
                v1, v2 = string.match(v3, "^(.*:%d+): (.+)$")
                if v1 and v2 then
                    v3 = v2
                end
                v1, v2 = string.match(v3, "^(.+) $(%[.+)$")
                if v1 and v2 then
                    v3 = v1
                end
                error(("%* $%*"):format(v3, (("[%*]%*"):format(
                    if type(k2) ~= "string" then if typeof(k2) ~= "Instance" then tostring(k2) else k2:GetFullName() else ((string.format("%q", k2)):gsub("\n", "n")),
                    v2 or ""
                ))), 2)
            end
            v5[k2] = err
        end
        return v5
    end
end

function u13.IsASCII(a1) -- Line: 470 -- types: a1: string
    local v1 = false
    if type(a1) == "string" then
        local v2
        for i = 1, (string.len(a1)) do
            v2 = string.byte(a1, i)
            if not (v2 < 32) and not (v2 > 126) then
                continue
            end
            return false
        end
        v1 = true
    end
    return v1
end

function u13.IsFinite(a1) -- Line: 473 -- types: a1: number
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = false
            if a1 ~= (1 / 0) then
                v1 = a1 ~= (-1 / 0)
            end
        end
    end
    return v1
end

function u13.IsInteger(a1) -- Line: 476 -- types: a1: number
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if math.floor(a1) == a1 then
            v1 = false
            if a1 ~= (1 / 0) then
                v1 = a1 ~= (-1 / 0)
            end
        end
    end
    return v1
end

function u13.IsCFrameFinite(a1) -- Line: 479 -- types: a1: Vector2
    local v1 = false
    if typeof(a1) == "CFrame" then
        local Components_11, Components_12, Components, Components_2, Components_3, Components_4, Components_5, Components_6, Components_7, Components_8, Components_9, Components_10 = a1:GetComponents()
        local v2 = Components_11 + Components_12 + Components + Components_2 + Components_3 + Components_4 + Components_5 + Components_6 + Components_7 + Components_8 + Components_9 + Components_10
        v1 = false
        if v2 == v2 then
            v1 = false
            if v2 ~= (1 / 0) then
                v1 = v2 ~= (-1 / 0)
            end
        end
    end
    return v1
end

function u13.IsVector2Finite(a1) -- Line: 482 -- types: a1: userdata
    local v1 = false
    if typeof(a1) == "Vector2" then
        local v2 = a1.X + a1.Y
        v1 = false
        if v2 == v2 then
            v1 = false
            if v2 ~= (1 / 0) then
                v1 = v2 ~= (-1 / 0)
            end
        end
    end
    return v1
end

function u13.Optional(a1) -- Line: 486 -- types: a1: function
    if type(a1) ~= "function" then
        error("function", 2)
    end
    return function(a1_2) -- Line: 490 -- upvalues: a1 (val)
        if a1_2 == nil then
            return nil
        end
        local success, err = pcall(a1, a1_2)
        if not success then
            local v1 = error
            local v2 = tostring(err)
            local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
            if v3 and v4 then
                v2 = v4
            end
            v1(v2, 2)
        end
        return err
    end
end

function u13.Default(a1, a2) -- Line: 502 -- types: a1: function
    if type(a1) ~= "function" then
        error("function", 2)
    end
    local u13 = a1(a2)
    return function(a1_2) -- Line: 507 -- upvalues: u13 (val), a1 (val)
        if a1_2 == nil then
            return u13
        end
        local success, err = pcall(a1, a1_2)
        if not success then
            local v1 = error
            local v2 = tostring(err)
            local v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
            if v3 and v4 then
                v2 = v4
            end
            v1(v2, 2)
        end
        return err
    end
end

function u13.AnyOf(...) -- Line: 519
    local u26 = table.pack(...)
    local n = u26.n
    for i = 1, n do
        assert(type(u26[i]) == "function", "function")
    end
    assert(0 < u26.n)
    return function(a1) -- Line: 525 -- upvalues: u26 (val)
        local err, success
        local n = u26.n
        for i = 1, n do
            success, err = pcall(u26[i], a1)
            if success then
                return err
            end
        end
        error("AnyOf", 2)
    end
end

function u13.AllOf(...) -- Line: 536
    local u26 = table.pack(...)
    local n = u26.n
    for i = 1, n do
        assert(type(u26[i]) == "function", "function")
    end
    assert(0 < u26.n)
    return function(a1) -- Line: 542 -- upvalues: u26 (val)
        local err, success, v1, v2, v3, v4
        local n = u26.n
        for i = 1, n do
            success, err = pcall(u26[i], a1)
            if not success then
                v1 = error
                v2 = tostring(err)
                v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
                if v3 and v4 then
                    v2 = v4
                end
                v1(v2, 2)
            end
        end
        return a1
    end
end

function u13.AnyTable(a1) -- Line: 554
    if type(a1) ~= "table" then
        error("table", 2)
    end
    return a1
end

function u13.Number(a1) -- Line: 560 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    return a1
end

function u13.Boolean(a1) -- Line: 566 -- types: a1: boolean
    if type(a1) ~= "boolean" then
        error("boolean", 2)
    end
    return a1
end

function u13.Buffer(a1) -- Line: 572 -- types: a1: buffer
    if type(a1) ~= "buffer" then
        error("buffer", 2)
    end
    return a1
end

function u13.Function(a1) -- Line: 578 -- types: a1: function
    if type(a1) ~= "function" then
        error("function", 2)
    end
    return a1
end

function u13.Thread(a1) -- Line: 584 -- types: a1: thread
    if type(a1) ~= "thread" then
        error("thread", 2)
    end
    return a1
end

function u13.String(a1) -- Line: 591 -- types: a1: string
    if type(a1) ~= "string" then
        error("string", 2)
    end
    if not utf8.len(a1) then
        error("UTF8", 2)
    end
    return a1
end

function u13.RawString(a1) -- Line: 601 -- types: a1: string
    if type(a1) ~= "string" then
        error("string", 2)
    end
    return a1
end

function u13.Any(a1) -- Line: 608
    return a1
end

function u13.Equals(a1) -- Line: 612
    return function(a1_2) -- Line: 613 -- upvalues: a1 (val)
        local v1 = a1
        if not (if not rawequal(a1_2, v1) then if type(a1_2) ~= "number" then false else if type(v1) ~= "number" then false else if a1_2 == a1_2 then false else not (v1 == v1) else true) then
            error("Equals", 2)
        end
        return a1_2
    end
end

function u13.Set(a1) -- Line: 621 -- upvalues: u13 (val) -- types: a1: table
    u13.Array(u13.Any)
    local u26 = {}
    for i, v in ipairs(a1) do
        if v ~= v then
            error("InvalidKeyNaN", 2)
        end
        u26[v] = true
        if not u26[v] then
            error("InvalidKey", 2)
        end
    end
    return function(a1) -- Line: 633 -- upvalues: u26 (val)
        if not u26[a1] then
            error("Set", 2)
        end
        return a1
    end
end

function u13.Pattern(a1) -- Line: 641 -- upvalues: u13 (val) -- types: a1: string
    u13.String(a1)
    return function(a1_2) -- Line: 643 -- upvalues: a1 (val)
        if type(a1_2) ~= "string" then
            error("string", 2)
        end
        if not utf8.len(a1_2) then
            error("UTF8", 2)
        end
        if not string.find(a1_2, a1) then
            error("Pattern", 2)
        end
        return a1_2
    end
end

function u13.NoMetatable(a1) -- Line: 657
    if type(a1) ~= "table" then
        error("table", 2)
    end
    if getmetatable(a1) ~= nil then
        error("metatable", 2)
    end
    return a1
end

function u13.Finite(a1) -- Line: 668 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if a1 == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Finite", 2)
    end
    return a1
end

function u13.FinitePositive(a1) -- Line: 679 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if a1 == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Finite", 2)
    end
    if not (a1 > 0) then
        error("Positive", 2)
    end
    return a1
end

function u13.FiniteNonNegative(a1) -- Line: 693 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if a1 == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Finite", 2)
    end
    if not (a1 >= 0) then
        error("NonNegative", 2)
    end
    return a1
end

function u13.Positive(a1) -- Line: 707 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    if not (a1 > 0) then
        error("Positive", 2)
    end
    return a1
end

function u13.NonNegative(a1) -- Line: 718 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    if not (a1 >= 0) then
        error("NonNegative", 2)
    end
    return a1
end

function u13.Real(a1) -- Line: 729 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    if a1 ~= a1 then
        error("Real", 2)
    end
    return a1
end

function u13.Range(a1, a2) -- Line: 740 -- upvalues: u13 (val) -- types: a1: number, a2: number
    u13.Real(a1)
    u13.Real(a2)
    if not (a1 <= a2) then
        error("a<=b", 2)
    end
    return function(a1_2) -- Line: 746 -- upvalues: a1 (val), a2 (val)
        if type(a1_2) ~= "number" then
            error("number", 2)
        end
        if not (a1 <= a1_2) or not (a1_2 <= a2) then
            error(("Range(%*,%*)"):format(a1, a2), 2)
        end
        return a1_2
    end
end

function u13.Integer(a1) -- Line: 758 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if math.floor(a1) == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Integer", 2)
    end
    return a1
end

function u13.Unsigned32(a1) -- Line: 769 -- types: a1: number
    if bit32.bor(a1, 0) ~= a1 then
        error("Unsigned32", 2)
    end
    return a1
end

function u13.IntegerPositive(a1) -- Line: 778 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if math.floor(a1) == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Integer", 2)
    end
    if not (a1 >= 1) then
        error("Positive", 2)
    end
    return a1
end

function u13.Index(a1) -- Line: 792 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if math.floor(a1) == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Integer", 2)
    end
    if not (a1 >= 1) then
        error("Positive", 2)
    end
    return a1
end

function u13.IntegerNonNegative(a1) -- Line: 806 -- types: a1: number
    if type(a1) ~= "number" then
        error("number", 2)
    end
    local v1 = false
    if math.floor(a1) == a1 then
        v1 = false
        if a1 ~= (1 / 0) then
            v1 = a1 ~= (-1 / 0)
        end
    end
    if not v1 then
        error("Integer", 2)
    end
    if not (a1 >= 0) then
        error("NonNegative", 2)
    end
    return a1
end

function u13.IntegerRange(a1, a2) -- Line: 820 -- upvalues: u13 (val) -- types: a1: number, a2: number
    u13.Integer(a1)
    u13.Integer(a2)
    if not (a1 <= a2) then
        error("a<=b", 2)
    end
    return function(a1_2) -- Line: 826 -- upvalues: a1 (val), a2 (val)
        if type(a1_2) ~= "number" then
            error("number", 2)
        end
        local v1 = false
        if math.floor(a1_2) == a1_2 then
            v1 = false
            if a1_2 ~= (1 / 0) then
                v1 = a1_2 ~= (-1 / 0)
            end
        end
        if not v1 then
            error("Integer", 2)
        end
        if not (a1 <= a1_2) or not (a1_2 <= a2) then
            error(("Range(%*,%*)"):format(a1, a2), 2)
        end
        return a1_2
    end
end

function u13.UInt32() -- Line: 840
    return function(a1) -- Line: 841
        if type(a1) ~= "number" then
            error("number", 2)
        end
        if bit32.bor(a1, 0) ~= a1 then
            error("UInt32", 2)
        end
        return a1
    end
end

function u13.StringRange(a1, a2) -- Line: 853 -- upvalues: u13 (val) -- types: a1: number, a2: number
    u13.Integer(a1)
    u13.Integer(a2)
    if not (a1 <= a2) then
        error("a<=b", 2)
    end
    return function(a1_2) -- Line: 859 -- upvalues: a1 (val), a2 (val)
        if type(a1_2) ~= "string" then
            error("string", 2)
        end
        local v1 = utf8.len(a1_2)
        if not v1 then
            error("UTF8", 2)
        end
        if not (a1 <= v1) or not (v1 <= a2) then
            error(("StringRange(%*,%*)"):format(a1, a2), 2)
        end
        return a1_2
    end
end

function u13.ASCII(a1) -- Line: 874 -- types: a1: string
    local v1
    if type(a1) ~= "string" then
        error("string", 2)
    end
    local v2 = a1
    for i = 1, (string.len(a1)) do
        v1 = string.byte(v2, i)
        if v1 < 32 or v1 > 126 then
            error("ASCII", 2)
        end
    end
    return v2
end

function u13.ASCIIRange(a1, a2) -- Line: 888 -- upvalues: u13 (val) -- types: a1: number, a2: number
    u13.Integer(a1)
    u13.Integer(a2)
    if not (a1 <= a2) then
        error("a<=b", 2)
    end
    return function(a1_2) -- Line: 894 -- upvalues: a1 (val), a2 (val)
        local v1
        if type(a1_2) ~= "string" then
            error("string", 2)
        end
        local v2 = string.len(a1_2)
        if not (a1 <= v2) or not (v2 <= a2) then
            error(("ASCIIRange(%*,%*)"):format(a1, a2), 2)
        end
        local v3 = a1_2
        for i = 1, v2 do
            v1 = string.byte(v3, i)
            if v1 < 32 or v1 > 126 then
                error("ASCII", 2)
            end
        end
        return v3
    end
end

function u13.CFrame(a1) -- Line: 912 -- types: a1: Vector2
    if typeof(a1) ~= "CFrame" then
        error("CFrame", 2)
    end
    return a1
end

function u13.CFrameFinite(a1) -- Line: 918 -- types: a1: Vector2
    if typeof(a1) ~= "CFrame" then
        error("CFrame", 2)
    end
    local Components_11, Components_12, Components, Components_2, Components_3, Components_4, Components_5, Components_6, Components_7, Components_8, Components_9, Components_10 = a1:GetComponents()
    local v1 = Components_11 + Components_12 + Components + Components_2 + Components_3 + Components_4 + Components_5 + Components_6 + Components_7 + Components_8 + Components_9 + Components_10
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("CFrameFinite", 2)
    end
    return a1
end

function u13.Vector2(a1) -- Line: 927 -- types: a1: userdata
    if typeof(a1) ~= "Vector2" then
        error("Vector2", 2)
    end
    return a1
end

function u13.Vector2Finite(a1) -- Line: 933 -- types: a1: userdata
    if typeof(a1) ~= "Vector2" then
        error("Vector2", 2)
    end
    local v1 = a1.X + a1.Y
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("Vector2Finite", 2)
    end
    return a1
end

function u13.Vector2Unit(a1) -- Line: 942 -- types: a1: userdata
    if typeof(a1) ~= "Vector2" then
        error("Vector2", 2)
    end
    local v1 = a1.X + a1.Y
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("Vector2Finite", 2)
    end
    if 1e-06 < (math.abs(a1.Magnitude - 1)) then
        error("Vector2Unit", 2)
    end
    return a1
end

function u13.Vector3(a1) -- Line: 954 -- types: a1: vector
    if typeof(a1) ~= "Vector3" then
        error("Vector3", 2)
    end
    return a1
end

function u13.Vector3Finite(a1) -- Line: 960 -- types: a1: vector
    if typeof(a1) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v1 = a1.X + a1.Y + a1.Z
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("Vector3Finite", 2)
    end
    return a1
end

function u13.Vector3Unit(a1) -- Line: 969 -- types: a1: vector
    if typeof(a1) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v1 = a1.X + a1.Y + a1.Z
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("Vector3Finite", 2)
    end
    if 1e-06 < (math.abs(a1.Magnitude - 1)) then
        error("Vector3Unit", 2)
    end
    return a1
end

function u13.Vector3Positive(a1) -- Line: 981 -- types: a1: vector
    if typeof(a1) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v1 = a1.X + a1.Y + a1.Z
    local v2 = false
    if v1 == v1 then
        v2 = false
        if v1 ~= (1 / 0) then
            v2 = v1 ~= (-1 / 0)
        end
    end
    if not v2 then
        error("Vector3Finite", 2)
    end
    if a1.X <= 0 or a1.Y <= 0 or a1.Z <= 0 then
        error("Vector3Positive")
    end
    return a1
end

function u13.Vector3int16(a1) -- Line: 993 -- types: a1: userdata
    if typeof(a1) ~= "Vector3int16" then
        error("Vector3int16", 2)
    end
    return a1
end

function u13.Vector2int16(a1) -- Line: 999 -- types: a1: userdata
    if typeof(a1) ~= "Vector2int16" then
        error("Vector2int16", 2)
    end
    return a1
end

function u13.Region3(a1) -- Line: 1005 -- types: a1: userdata
    if typeof(a1) ~= "Region3" then
        error("Region3", 2)
    end
    return a1
end

function u13.Region3int16(a1) -- Line: 1011 -- types: a1: userdata
    if typeof(a1) ~= "Region3int16" then
        error("Region3int16", 2)
    end
    return a1
end

function u13.UDim(a1) -- Line: 1017 -- types: a1: UDim2
    if typeof(a1) ~= "UDim" then
        error("UDim", 2)
    end
    return a1
end

function u13.UDim2(a1) -- Line: 1023 -- types: a1: CFrame
    if typeof(a1) ~= "UDim2" then
        error("UDim2", 2)
    end
    return a1
end

function u13.Rect(a1) -- Line: 1029 -- types: a1: UDim
    if typeof(a1) ~= "Rect" then
        error("Rect", 2)
    end
    return a1
end

function u13.PhysicalProperties(a1) -- Line: 1035 -- types: a1: userdata
    if typeof(a1) ~= "PhysicalProperties" then
        error("PhysicalProperties", 2)
    end
    return a1
end

function u13.Storable(a1, a2) -- Line: 1044 -- upvalues: SafeKeyStringRep (val), u13 (val) -- types: a2: table?
    local err, success, v1, v2, v3, v4
    if type(a1) == "boolean" or type(a1) == "number" then
        return a1
    end
    if type(a1) == "string" then
        if utf8.len(a1) then
            return a1
        end
        error("UTF8", 2)
        return a1
    end
    if type(a1) == "buffer" then
        return a1
    end
    if type(a1) ~= "table" then
        error("Storable", 2)
        return a1
    end
    if type(a1) ~= "table" then
        error("table", 2)
    end
    if getmetatable(a1) ~= nil then
        error("metatable", 2)
    end
    local v5 = a2 or {}
    if v5[a1] then
        error("Loop", 2)
    end
    v5[a1] = true
    local v6 = rawlen(a1)
    if not (v6 > 0) then
        local err_2, success_2, v7, v8
        for k, v in pairs(a1) do
            if type(k) ~= "string" then
                error(("KeyString $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if not utf8.len(k) then
                error(("KeyUTF8 $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            success_2, err_2 = pcall(u13.Storable, v, v5)
            if not success_2 then
                v8 = tostring(err_2)
                v2, v3 = string.match(v8, "^(.*:%d+): (.+)$")
                if v2 and v3 then
                    v8 = v3
                end
                v2, v3 = string.match(v8, "^(.+) $(%[.+)$")
                if v2 and v3 then
                    v8 = v2
                end
                v7 = v8
                v8 = error
                v3 = ("[%*]%*"):format(SafeKeyStringRep(k), v3 or "")
                v8(("%* $%*"):format(v7, v3), 2)
            end
        end
        return a1
    end
    local v9 = 0
    for k2, i in pairs(a1) do
        v9 = v9 + 1
        if k2 ~= v9 then
            error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k2))))), 2)
        end
        if v6 < v9 then
            error(("IndexOverflow $%*"):format((("[%*]"):format(v9))), 2)
        end
        success, err = pcall(u13.Storable, i, v5)
        if not success then
            v2 = tostring(err)
            v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
            if v3 and v4 then
                v2 = v4
            end
            v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
            if v3 and v4 then
                v2 = v3
            end
            v1 = v2
            v2 = error
            v4 = ("[%*]%*"):format(v9, v4 or "")
            v2(("%* $%*"):format(v1, v4), 2)
        end
    end
    if v6 == v9 then
        return a1
    end
    error("LengthMismatch", 2)
    return a1
end

local u80 = {
    boolean = true,
    number = true,
    string = true,
    buffer = true,
    Color3 = true,
    Instance = true,
    NumberRange = true,
    Rect = true,
    Region3 = true,
    Region3int16 = true,
    UDim = true,
    UDim2 = true,
    CFrame = true,
    Vector2 = true,
    Vector2int16 = true,
    Vector3 = true,
    Vector3int16 = true,
    EnumItem = true,
}
table.freeze(u80)

function u13.Networkable(a1, a2) -- Line: 1150
    -- upvalues: SafeKeyStringRep (val), u13 (val), u80 (val)
    local err, success, v1, v2, v3, v4
    if type(a1) == "string" then
        if utf8.len(a1) then
            return a1
        end
        error("UTF8", 2)
        return a1
    end
    if type(a1) ~= "table" then
        if not u80[typeof(a1)] then
            error("Networkable", 2)
        end
        return a1
    end
    if type(a1) ~= "table" then
        error("table", 2)
    end
    if getmetatable(a1) ~= nil then
        error("metatable", 2)
    end
    local v5 = a2 or {}
    if v5[a1] then
        error("Loop", 2)
    end
    v5[a1] = true
    local v6 = rawlen(a1)
    if not (v6 > 0) then
        local err_2, success_2, v7, v8
        for k, v in pairs(a1) do
            if type(k) ~= "string" then
                error(("KeyString $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            if not utf8.len(k) then
                error(("KeyUTF8 $%*"):format((("[%*]"):format((SafeKeyStringRep(k))))), 2)
            end
            success_2, err_2 = pcall(u13.Networkable, v, v5)
            if not success_2 then
                v8 = tostring(err_2)
                v2, v3 = string.match(v8, "^(.*:%d+): (.+)$")
                if v2 and v3 then
                    v8 = v3
                end
                v2, v3 = string.match(v8, "^(.+) $(%[.+)$")
                if v2 and v3 then
                    v8 = v2
                end
                v7 = v8
                v8 = error
                v3 = ("[%*]%*"):format(SafeKeyStringRep(k), v3 or "")
                v8(("%* $%*"):format(v7, v3), 2)
            end
        end
        return a1
    end
    local v9 = 0
    for k2, i in pairs(a1) do
        v9 = v9 + 1
        if k2 ~= v9 then
            error(("IndexMismatch $%*"):format((("[%*]"):format((SafeKeyStringRep(k2))))), 2)
        end
        if v6 < v9 then
            error(("IndexOverflow $%*"):format((("[%*]"):format(v9))), 2)
        end
        success, err = pcall(u13.Networkable, i, v5)
        if not success then
            v2 = tostring(err)
            v3, v4 = string.match(v2, "^(.*:%d+): (.+)$")
            if v3 and v4 then
                v2 = v4
            end
            v3, v4 = string.match(v2, "^(.+) $(%[.+)$")
            if v3 and v4 then
                v2 = v3
            end
            v1 = v2
            v2 = error
            v4 = ("[%*]%*"):format(v9, v4 or "")
            v2(("%* $%*"):format(v1, v4), 2)
        end
    end
    if v6 == v9 then
        return a1
    end
    error("LengthMismatch", 2)
    return a1
end

function u13.Enum(a1) -- Line: 1210 -- types: a1: userdata
    if typeof(a1) ~= "Enum" then
        error("Enum", 2)
    end
    return function(a1_2) -- Line: 1214 -- upvalues: a1 (val)
        if typeof(a1_2) ~= "EnumItem" then
            error("EnumItem", 2)
        end
        if a1_2.EnumType ~= a1 then
            error(tostring(a1), 2)
        end
        return a1_2
    end
end

function u13.EnumValue(a1) -- Line: 1225 -- types: a1: userdata
    if typeof(a1) ~= "Enum" then
        error("Enum", 2)
    end
    local u8 = {}
    for i, v in ipairs(a1:GetEnumItems()) do
        u8[v.Value] = v
    end
    return function(a1) -- Line: 1233 -- upvalues: u8 (val)
        if typeof(a1) ~= "number" then
            error("number", 2)
        end
        if not u8[a1] then
            error("EnumValue", 2)
        end
        return a1
    end
end

function u13.Player(a1) -- Line: 1244 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Player") then
        error("Player", 2)
    end
    return a1
end

function u13.BasePart(a1) -- Line: 1250 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("BasePart") then
        error("BasePart", 2)
    end
    return a1
end

function u13.Part(a1) -- Line: 1256 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Part") then
        error("Part", 2)
    end
    return a1
end

function u13.MeshPart(a1) -- Line: 1262 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("MeshPart") then
        error("MeshPart", 2)
    end
    return a1
end

function u13.Model(a1) -- Line: 1268 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Model") then
        error("Model", 2)
    end
    return a1
end

function u13.Animation(a1) -- Line: 1274 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Animation") then
        error("Animation", 2)
    end
    return a1
end

function u13.Humanoid(a1) -- Line: 1280 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Humanoid") then
        error("Humanoid", 2)
    end
    return a1
end

function u13.ParticleEmitter(a1) -- Line: 1286 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("ParticleEmitter") then
        error("ParticleEmitter", 2)
    end
    return a1
end

function u13.Sound(a1) -- Line: 1292 -- types: a1: userdata
    if typeof(a1) ~= "Instance" or not a1:IsA("Sound") then
        error("Sound", 2)
    end
    return a1
end

function u13.Instance(a1) -- Line: 1298 -- types: a1: userdata
    if typeof(a1) ~= "Instance" then
        error("Instance", 2)
    end
    return a1
end

function u13.InstanceOf(a1) -- Line: 1306 -- upvalues: u13 (val) -- types: a1: string
    u13.String(a1)
    return function(a1_2) -- Line: 1308 -- upvalues: a1 (val)
        if typeof(a1_2) ~= "Instance" then
            error("Instance", 2)
        end
        if not a1_2:IsA(a1) then
            error(a1, 2)
        end
        return a1_2
    end
end

function u13.InstanceClass(a1) -- Line: 1319 -- upvalues: u13 (val) -- types: a1: string
    u13.String(a1)
    return function(a1_2) -- Line: 1321 -- upvalues: a1 (val)
        if typeof(a1_2) ~= "Instance" then
            error("Instance", 2)
        end
        if a1_2.ClassName ~= a1 then
            error(a1, 2)
        end
        return a1_2
    end
end

function u13.HexLower(a1) -- Line: 1332 -- types: a1: string
    local v1
    if type(a1) ~= "string" then
        error("string", 2)
    end
    local v2 = a1
    for i = 1, (string.len(a1)) do
        v1 = string.byte(v2, i)
        if not (v1 >= 48) or not (v1 <= 57) then
            if not (v1 >= 97) or not (v1 <= 102) then
                error("HexLower", 2)
            end
        end
    end
    return v2
end

function u13.HexUpper(a1) -- Line: 1346 -- types: a1: string
    local v1
    if type(a1) ~= "string" then
        error("string", 2)
    end
    local v2 = a1
    for i = 1, (string.len(a1)) do
        v1 = string.byte(v2, i)
        if not (v1 >= 48) or not (v1 <= 57) then
            if not (v1 >= 65) or not (v1 <= 70) then
                error("HexUpper", 2)
            end
        end
    end
    return v2
end

function u13.UUIDStripped(a1) -- Line: 1360 -- types: a1: string
    local v1
    if type(a1) ~= "string" then
        error("string", 2)
    end
    local v2 = string.len(a1)
    if v2 ~= 32 then
        error("Length32", 2)
    end
    local v3 = a1
    for i = 1, v2 do
        v1 = string.byte(v3, i)
        if not (v1 >= 48) or not (v1 <= 57) then
            if not (v1 >= 97) or not (v1 <= 102) then
                error("HexLower", 2)
            end
        end
    end
    return v3
end

function u13.UUID(a1) -- Line: 1378 -- types: a1: string
    if type(a1) ~= "string" then
        error("string", 2)
    end
    if string.len(a1) ~= 36 then
        error("Length36", 2)
    end
    if not a1:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2)
    end
    return a1
end

function u13.Base64(a1) -- Line: 1391 -- types: a1: string
    if type(a1) ~= "string" then
        error("string", 2)
    end
    if string.len(a1) % 4 ~= 0 then
        error("Base64Length", 2)
    end
    if not string.match(a1, "^[A-Za-z0-9+/]*=?=?$") or string.match(a1, "[^=]=+[^=]") then
        error("Base64", 2)
    end
    return a1
end

function u13.ToNumber(a1) -- Line: 1404 -- types: a1: function
    return function(a1_2) -- Line: 1405 -- upvalues: a1 (val)
        local v1 = tonumber(a1_2)
        if not v1 then
            error("tonumber", 2)
        end
        local success, err = pcall(a1, v1)
        if not success then
            local v2 = error
            local v3 = tostring(err)
            local v4, v5 = string.match(v3, "^(.*:%d+): (.+)$")
            if v4 and v5 then
                v3 = v5
            end
            v2(v3, 2)
        end
        return err
    end
end

function u13.IsoDate(a1) -- Line: 1418 -- types: a1: string
    if not DateTime.fromIsoDate(a1) then
        error("IsoDate", 2)
    end
    return a1
end

return table.freeze(u13)