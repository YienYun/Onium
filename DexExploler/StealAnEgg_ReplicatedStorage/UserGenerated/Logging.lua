-- Script path: ReplicatedStorage.UserGenerated.Logging
-- Decompile time: 3.71 ms

local RunService = game:GetService("RunService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local u26 = {Pretty = true, IndentChar = " ", IndentSize = 2}

local function GetPrefix(a1) -- Line: 39 -- types: a1: number?
    local v1, v2, v3 = debug.info((a1 or 0) + 2, "sln")
    local v4 = ("%*:%*"):format(v1, v2)
    if v3 then
        v4 = v4 .. (" %*"):format(v3)
    end
    return (("[%*]"):format(v4))
end

local function Format(a1) -- Line: 49 -- upvalues: Stringify (val), u26 (val)
    if type(a1) == "string" then
        return a1
    end
    if typeof(a1) == "Instance" then
        return (("%*[%*]"):format(a1.ClassName, (a1:GetFullName())))
    end
    return Stringify.Serialize(a1, u26)
end

local function FormatArgs(...) -- Line: 59 -- upvalues: Stringify (val), u26 (val)
    local v1, v2
    local v3 = table.pack(...)
    local n = v3.n
    for i = 1, n do
        v2 = v3[i]
        v1 = if type(v2) == "string" then v2 else if typeof(v2) ~= "Instance" then Stringify.Serialize(v2, u26) else ("%*[%*]"):format(v2.ClassName, (v2:GetFullName()))
        v3[i] = v1
    end
    return table.unpack(v3)
end

local function v1(...) -- Line: 67 -- upvalues: FormatArgs (val)
    local spawn = task.spawn
    local v1, v2, v3 = debug.info(2, "sln")
    local v4 = ("%*:%*"):format(v1, v2)
    if v3 then
        v4 = v4 .. (" %*"):format(v3)
    end
    spawn(function(a1, ...) -- Line: 68 -- upvalues: FormatArgs (upval)
        print(a1, FormatArgs(...))
    end, ("[%*]"):format(v4), ...)
end

local function v2(...) -- Line: 72 -- upvalues: FormatArgs (val)
    local spawn = task.spawn
    local v1, v2, v3 = debug.info(2, "sln")
    local v4 = ("%*:%*"):format(v1, v2)
    if v3 then
        v4 = v4 .. (" %*"):format(v3)
    end
    spawn(function(a1, ...) -- Line: 73 -- upvalues: FormatArgs (upval)
        warn(a1, FormatArgs(...))
    end, ("[%*]"):format(v4), ...)
end

if RunService:IsStudio() then
    v1 = print
    v2 = warn
end

local function u37() end

local u38 = {
    Trace = 1,
    Debug = 2,
    Info = 3,
    Warn = 4,
    Error = 5,
    Critical = 6,
    Off = 7,
}
table.freeze(u38)
local u42 = {
    Trace = v1,
    Debug = v1,
    Info = v1,
    Warn = v2,
    Error = v2,
    Critical = v2,
    Off = u37,
}
table.freeze(u42)
v2 = Asserts.Set(Keys(u38))
local u59 = table.clone(u42)
local u60 = "Info"

local function SetLevel(a1, a2) -- Line: 113
    -- upvalues: u38 (val), u60 (ref), u59 (val), u42 (val), u37 (val)
    assert(u38[a1])
    local v1 = true
    if a2 ~= nil then
        v1 = type(a2) == "boolean"
    end
    assert(v1)
    if u60 == a1 and not a2 then
        return
    end
    u60 = a1
    local v2 = assert(u38[a1])
    for k, v in pairs(u38) do
        if not (v2 <= v) then
            u59[k] = u37
        else
            u59[k] = u42[k]
        end
    end
end

SetLevel(u60, true)
local v3 = {Levels = u38, AssertLevel = v2}
local v4 = {__index = u59}
setmetatable(v3, v4)

function v3.GetLevel() -- Line: 138 -- upvalues: u60 (ref)
    return u60
end

function v3.SetLevel(a1) -- Line: 142 -- upvalues: SetLevel (val) -- types: a1: string
    SetLevel(a1)
end

function v3.Sink(a1) -- Line: 146 -- upvalues: u59 (val) -- types: a1: string
    return assert(u59[a1])
end

return (table.freeze(v3))