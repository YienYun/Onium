-- Script path: ReplicatedStorage.UserGenerated.IO.HTTP.URL
-- Decompile time: 4.96 ms

local HttpService = game:GetService("HttpService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local JSONEncoder = require(game.ReplicatedStorage.UserGenerated.IO.JSONEncoder)
local u26 = {http = 80, https = 443}
local v1 = Asserts.Optional(Asserts.Set(Keys(u26)))
local String = Asserts.String
local v2 = Asserts.Optional(Asserts.IntegerRange(0, 65535))

local function v3(a1) -- Line: 34 -- types: a1: string
    if type(a1) ~= "string" then
        error("string", 2)
    end
    if not utf8.len(a1) then
        error("UTF8", 2)
    end
    if #a1 > 0 and string.byte(a1, 1) ~= 47 then
        error("PathPrefix", 2)
    end
    return a1
end

local u47 = Asserts.Map(Asserts.String, Asserts.Any)
local u56 = Asserts.Table({
    Protocol = v1,
    Host = String,
    Port = v2,
    Path = v3,
    Params = Asserts.Optional(u47),
    Fragment = Asserts.Optional(Asserts.String),
})
local u57 = {
    AssertProtocol = v1,
    AssertHost = String,
    AssertPort = v2,
    AssertPath = v3,
    AssertEncodeParams = u47,
    AssertParams = u56,
}

function u57.EncodePath(a1) -- Line: 77 -- upvalues: Asserts (val), HttpService (val) -- types: a1: string
    Asserts.String(a1)
    return (a1:gsub("([^/]+)", function(a1) -- Line: 79 -- upvalues: HttpService (upval)
        return HttpService:UrlEncode(a1)
    end))
end

function u57.EncodeParams(a1) -- Line: 85
    -- upvalues: u47 (val), Keys (val), JSONEncoder (val), HttpService (val)
    local v1
    u47(a1)
    local v2 = Keys(a1)
    table.sort(v2)
    local v3 = {}
    for i, v in ipairs(v2) do
        v1 = JSONEncoder.Compact(a1[v])
        table.insert(v3, (HttpService:UrlEncode(v)) .. "=" .. (HttpService:UrlEncode(v1)))
    end
    return table.concat(v3, "&")
end

function u57.Build(a1) -- Line: 97 -- upvalues: u56 (val), u26 (val), u57 (val), HttpService (val) -- types: a1: table
    u56(a1)
    local v1 = a1.Protocol or "https"
    local v2 = u26[v1] or 80
    local v3 = a1.Port or v2
    local v4 = {}
    table.insert(v4, v1)
    table.insert(v4, "://")
    table.insert(v4, a1.Host)
    if v3 ~= v2 then
        table.insert(v4, ":")
        table.insert(v4, (tostring(v3)))
    end
    table.insert(v4, (u57.EncodePath(a1.Path)))
    local Params = a1.Params
    if Params and next(Params) ~= nil then
        table.insert(v4, "?")
        table.insert(v4, (u57.EncodeParams(Params)))
    end
    if a1.Fragment then
        table.insert(v4, "#")
        table.insert(v4, (HttpService:UrlEncode(a1.Fragment)))
    end
    return table.concat(v4)
end

return table.freeze(u57)