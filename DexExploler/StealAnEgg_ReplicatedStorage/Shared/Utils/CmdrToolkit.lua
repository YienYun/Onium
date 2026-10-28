-- Script path: ReplicatedStorage.Shared.Utils.CmdrToolkit
-- Decompile time: 6.79 ms

local u0 = {}
local u1 = {}
u1.__index = u1

function u0.Arg(a1, a2, a3, a4) -- Line: 29 -- types: a2: string, a3: string?, a4: boolean?
    return {Type = a1, Name = a2, Description = a3 or "", Optional = a4}
end

function u0.Manifest() -- Line: 34 -- upvalues: u1 (val)
    local u4 = setmetatable({_actions = {}}, u1)
    return u4, function(...) -- Line: 36 -- upvalues: u4 (val)
        return u4:Define(...)
    end
end

function u1:Define(a2, a3, a4, a5) -- Line: 41 -- types: self: table, a2: string, a3: string
    local v1
    local v2 = false
    if type(a2) == "string" then
        v2 = a2 ~= ""
    end
    assert(v2, "[CmdrToolkit] action name must be a non-empty string")
    assert(self._actions[a2] == nil, (("[CmdrToolkit] duplicate action '%*'"):format(a2)))
    local v3 = ("[CmdrToolkit] action '%*' needs a Run function"):format(a2)
    assert(type(a5) == "function", v3)
    local v4 = a4 or {}
    local v5, v6, v7, v8 = self, a2, a3, a5
    for i, v in ipairs(v4) do
        v1 = false
        if type(v) == "table" then
            if type(v.Type) == "string" then
                v1 = type(v.Name) == "string"
            else
                v1 = false
                if type(v.Type) == "table" then
                    v1 = type(v.Name) == "string"
                end
            end
        end
        assert(v1, (("[CmdrToolkit] action '%*' argument #%* needs a Type and a Name"):format(v6, i)))
    end
    v5._actions[v6] = {Name = v6, Description = v7 or "", Args = v4, Run = v8}
    return v5
end

function u1:Get(a2) -- Line: 58 -- types: self: table, a2: string
    return self._actions[a2]
end

function u1:Names() -- Line: 62
    local v1 = {}
    for i in self._actions do
        table.insert(v1, i)
    end
    table.sort(v1)
    return v1
end

function u1:MaxArgs() -- Line: 72
    local v1 = 0
    for i, j in self._actions do
        v1 = math.max(v1, #j.Args)
    end
    return v1
end

function u0.Enum(a1, a2, a3) -- Line: 83 -- types: a1: string, a3: string?
    local function names() -- Line: 84 -- upvalues: a2 (val)
        local v1 = table.clone(if type(a2) ~= "function" then a2 else a2())
        table.sort(v1)
        return v1
    end

    return {
        Name = a1,
        DisplayName = a1,
        Transform = function(a1) -- Line: 90 -- upvalues: a2 (val) -- types: a1: string
            local v1 = a1:lower()
            local v2 = {}
            local v3 = nil
            local v4 = table.clone(if type(a2) ~= "function" then a2 else a2())
            table.sort(v4)
            local v5 = nil
            local v6 = nil
            for i, j in v4, v5, v6 do
                if j:lower() == v1 then
                    v3 = j
                end
                if (j:lower()):sub(1, #v1) == v1 then
                    table.insert(v2, j)
                end
            end
            if v3 then
                return {v3}
            end
            return v2
        end,
        Validate = function(a1) -- Line: 111 -- upvalues: a3 (val)
            if #a1 == 1 then
                return true
            end
            if #a1 == 0 then
                return false, (("No %* by that name."):format(a3 or "value"))
            end
            return false, (("Ambiguous - matches %*: %*"):format(#a1, (table.concat(a1, ", "))))
        end,
        Autocomplete = function(a1) -- Line: 122
            return a1
        end,
        Parse = function(a1) -- Line: 125
            return a1[1]
        end,
    }
end

local function trailingArg(a1, a2, a3) -- Line: 133 -- types: a2: number, a3: number
    return function(a1_2) -- Line: 134 -- upvalues: a2 (val), a1 (val), a3 (val)
        local success, err = pcall(function() -- Line: 135 -- upvalues: a1_2 (val), a2 (upval)
            local Argument = a1_2:GetArgument(a2)
            return Argument and Argument:GetValue()
        end)
        local v1 = success and err and a1:Get(err)
        local v2 = v1 and v1.Args[a3]
        if v2 then
            return {
                Type = v2.Type,
                Name = v2.Name,
                Description = v2.Description,
                Optional = v2.Optional,
            }
        end
        return {
            Type = "string",
            Name = "unused",
            Description = "(this action takes no further arguments)",
            Optional = true,
        }
    end
end

function u0.Command(a1, a2) -- Line: 155 -- upvalues: u0 (val)
    assert(type(a2) == "table", "[CmdrToolkit] Command needs an options table")
    assert(type(a2.Name) == "string", "[CmdrToolkit] Command needs a Name")
    local v1 = {}
    if a2.Scoped then
        table.insert(v1, {
            Type = "scope",
            Name = "scope",
            Description = a2.ScopeDescription or "global (all servers) or local (this one)",
        })
    end
    if a2.Subject then
        table.insert(v1, a2.Subject)
    end
    local u39 = #v1 + 1
    table.insert(v1, {
        Name = "action",
        Type = u0.Enum(("%*Action"):format(a2.Name), function() -- Line: 173 -- upvalues: a1 (val)
            return a1:Names()
        end, "action"),
        Description = a2.ActionDescription or "The action to run",
    })
    for i = 1, (a1:MaxArgs()) do
        table.insert(v1, function(a1_2) -- Line: 134 -- upvalues: u39 (val), a1 (val), i (val)
            local success, err = pcall(function() -- Line: 135 -- upvalues: a1_2 (val), u39 (upval)
                local Argument = a1_2:GetArgument(u39)
                return Argument and Argument:GetValue()
            end)
            local v1 = success and err and a1:Get(err)
            local v2 = v1 and v1.Args[i]
            if v2 then
                return {
                    Type = v2.Type,
                    Name = v2.Name,
                    Description = v2.Description,
                    Optional = v2.Optional,
                }
            end
            return {
                Type = "string",
                Name = "unused",
                Description = "(this action takes no further arguments)",
                Optional = true,
            }
        end)
    end
    return {
        Name = a2.Name,
        Aliases = a2.Aliases,
        Description = a2.Description,
        Group = a2.Group or "DefaultAdmin",
        Args = v1,
    }
end

function u0.Executor(a1, a2) -- Line: 195
    assert(type(a2) == "table", "[CmdrToolkit] Executor needs an options table")
    assert(type(a2.Context) == "function", "[CmdrToolkit] Executor needs a Context builder")
    local u24 = a2.Scoped == true
    local u28 = a2.Subject == true
    return function(a1_2, ...) -- Line: 202 -- upvalues: u24 (val), u28 (val), a1 (val), a2 (val)
        local v1 = table.pack(...)
        local v2 = 1
        local v3 = nil
        if u24 then
            v3 = v1[v2]
            v2 = v2 + 1
        end
        local v4 = nil
        if u28 then
            v4 = v1[v2]
            v2 = v2 + 1
        end
        local v5 = v1[v2]
        v2 = v2 + 1
        local v6 = a1:Get(v5)
        if not v6 then
            return (("Unknown action '%*'"):format((tostring(v5))))
        end
        local v7, v8 = a2.Context(a1_2, v4)
        if not v7 then
            return v8 or "Command context unavailable"
        end
        if u24 then
            v7.scope = v3
        end
        local v9 = {v7}
        local v10 = 1
        if u28 then
            v10 = v10 + 1
            v9[v10] = v4
        end
        local v11 = #v6.Args
        for i = 1, v11 do
            v10 = v10 + 1
            v9[v10] = v1[v2 + i - 1]
        end
        local success, err = pcall(v6.Run, (table.unpack(v9, 1, v10)))
        if not success then
            return (("%* failed: %*"):format(v5, err))
        end
        return err
    end
end

return u0