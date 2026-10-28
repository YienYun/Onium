-- Script path: ReplicatedStorage.Shared.Modules.Log
-- Decompile time: 3.16 ms

local RunService = game:GetService("RunService")
local u5 = {"fatal", "error", "warn", "info", "debug", "trace"}
local u12 = {error = true, fatal = true}
local v1 = {}
local u15 = nil

local function discard() end

local function merged(a1, a2) -- Line: 41 -- types: a1: table, a2: table?
    local v1 = table.clone(a1)
    for i, j in a2 or {} do
        v1[i] = j
    end
    return v1
end

local function describe(a1) -- Line: 51
    if typeof(a1) == "Instance" then
        local Parent = a1.Parent
        return (("%*/%*"):format(Parent and Parent.Name or "?", a1.Name))
    end
    if typeof(a1) == "string" then
        return a1
    end
    return "UNKNOWN"
end

local function escalate(a1, a2) -- Line: 62 -- upvalues: u12 (val) -- types: a1: table, a2: string?
    local v1 = u12[a1.level]
    if v1 then
        warn(debug.traceback(a2 or "a record was escalated without a headline"))
    end
    return v1
end

u15 = {
    __index = {
        log = function(a1, a2, a3, a4) -- Line: 72 -- upvalues: u5 (val) -- types: a1: table, a2: string, a3: string, a4: table?
            local v1 = table.find(u5, a2)
            if table.find(u5, a1.threshold) < v1 then
                return
            end
            local v2 = {level = a2, message = a3}
            local v3 = table.clone(a1.bindings)
            for i, j in a4 or {} do
                v3[i] = j
            end
            v2.context = v3
            local success, err = pcall(a1.emit, v2)
            if not success then
                warn((("the log sink raised while taking a record: %*"):format(err)))
            end
        end,
        extend = function(a1, a2) -- Line: 89 -- upvalues: u15 (ref) -- types: a1: table, a2: table
            local v1 = {emit = a1.emit}
            local v2 = table.clone(a1.bindings)
            for i, j in a2 or {} do
                v2[i] = j
            end
            v1.bindings = v2
            v1.threshold = a1.threshold
            return (setmetatable(v1, u15))
        end,
        setLevel = function(a1, a2) -- Line: 99 -- upvalues: u5 (val) -- types: a1: table, a2: string
            if table.find(u5, a2) == nil then
                error((("%* is not a severity this logger knows"):format(a2)))
            end
            a1.threshold = a2
            return a1
        end,
    },
}

function v1.createLogger(a1, a2) -- Line: 112 -- upvalues: discard (val), u15 (ref) -- types: a1: function, a2: table?
    return (setmetatable({
        threshold = "info",
        emit = if typeof(a1) ~= "function" then discard else a1,
        bindings = a2 or {},
    }, u15))
end

function v1.createDefaultCallback(a1) -- Line: 119 -- upvalues: RunService (val), u12 (val)
    local u22
    if typeof(a1) == "Instance" then
        local Parent = a1.Parent
        u22 = ("%*/%*"):format(Parent and Parent.Name or "?", a1.Name)
    else
        u22 = if typeof(a1) ~= "string" then "UNKNOWN" else a1
    end
    local u26 = RunService:IsStudio()
    return function(a1) -- Line: 125 -- upvalues: u26 (val), u22 (val), u12 (upval) -- types: a1: table
        local v1 = if not u26 then ("[%*] %*"):format(u22, a1.message) else ("[%*][%*] %*"):format(u22, a1.level, a1.message)
        if u26 and a1.context then
            print(("[%*] bound context ->"):format(u22), a1.context)
        end
        local v2 = u12[a1.level]
        if v2 then
            warn(debug.traceback(v1 or "a record was escalated without a headline"))
        end
        if not v2 and u26 then
            (if a1.level ~= "warn" then print else warn)(v1)
            return
        end
    end
end

return v1