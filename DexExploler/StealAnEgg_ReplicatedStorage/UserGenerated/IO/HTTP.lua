-- Script path: ReplicatedStorage.UserGenerated.IO.HTTP
-- Decompile time: 1.29 ms

local HttpService = game:GetService("HttpService")
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Asserts.Set({"GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS", "TRACE", "PATCH"})
local v2 = Asserts.Optional(Asserts.Enum(Enum.HttpCompression))
local u43 = Asserts.Table({
    Url = Asserts.String,
    Method = v1,
    Headers = Asserts.Optional(Asserts.Map(Asserts.String, Asserts.String)),
    Body = Asserts.Optional(Asserts.RawString),
    Compress = v2,
    NoCache = Asserts.Optional(Asserts.Boolean),
})
return table.freeze({
    AssertCompress = v2,
    AssertMethod = v1,
    AssertParams = u43,
    Execute = function(a1) -- Line: 75 -- upvalues: u43 (val), HttpService (val) -- types: a1: table
        u43(a1)
        local Headers = a1.Headers or {}
        if a1.NoCache then
            Headers = table.clone(Headers)
            Headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
            Headers.Pragma = "no-cache"
            Headers.Expires = "0"
        end
        local success, err = pcall(HttpService.RequestAsync, HttpService, {
            Url = a1.Url,
            Method = a1.Method,
            Headers = Headers,
            Body = a1.Body,
            Compress = a1.Compress,
        })
        if not success then
            return {Success = false, StatusCode = 400, StatusMessage = tostring(err), Headers = {}}
        end
        return err
    end,
})