-- Script path: ReplicatedStorage.Data.Gamepasses
-- Decompile time: 1.52 ms

local v1, v2, v3
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v4 = t.interface({
    Name = t.string,
    DisplayName = t.string,
    Desc = t.string,
    Icon = t.string,
    ProductId = t.intersection(t.integer, t.numberPositive),
    Precheck = t.optional(t.callback),
})
local v5 = {}
local u105 = {}
for i, j in script.Configs:GetChildren() do
    if j:IsA("ModuleScript") then
        v2 = require(j)
        v3, v1 = v4(v2)
        if not v3 then
            error((("gamepass config %* is malformed: %*"):format(j.Name, v1)))
        end
        if v2.Name ~= j.Name then
            error((("gamepass config %* calls itself \"%*\""):format(j.Name, v2.Name)))
        end
        v1 = u105[v2.ProductId]
        if v1 ~= nil then
            error((("gamepasses \"%*\" and \"%*\" share ProductId %*"):format(v1.Name, v2.Name, v2.ProductId)))
        end
        v5[v2.Name] = v2
        u105[v2.ProductId] = v2
    end
end
table.freeze(v5)
table.freeze(u105)
return table.freeze({
    Directory = v5,
    FromProductId = function(a1) -- Line: 59 -- upvalues: u105 (val) -- types: a1: number
        return u105[a1]
    end,
})