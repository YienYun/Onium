-- Script path: ReplicatedStorage.UserGenerated.Concurrency.Cache
-- Decompile time: 3.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local u17 = require(game.ReplicatedStorage.UserGenerated.Collections.DeepFreeze)
local Lock = require(game.ReplicatedStorage.UserGenerated.Concurrency.Lock)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)

local function ValueAge(a1, a2) -- Line: 38 -- types: a1: table, a2: number
    local RetrievedAt = a1.RetrievedAt
    if RetrievedAt then
        return a2 - RetrievedAt
    end
    return nil
end

local function AttemptAge(a1, a2) -- Line: 43 -- types: a1: table, a2: number
    local AttemptedAt = a1.AttemptedAt
    if AttemptedAt then
        return a2 - AttemptedAt
    end
    return (1 / 0)
end

local v1 = {
    RemoveUsedAt = function(a1, a2) end,
    InsertUsedAt = function(a1, a2) end,
    SetUsedAt = function(self, a2, a3) -- Line: 91 -- types: self: table, a2: table, a3: number
        self:RemoveUsedAt(a2)
        a2.UsedAt = a3
        self:InsertUsedAt(a2)
    end,
    Get = function(a1, a2) -- Line: 100
        local v1
        local v2 = a1.Cache[(a1.AssertKey(a2))]
        if not v2 then
            return nil
        end
        local v3 = os.clock()
        local RetrievedAt = v2.RetrievedAt
        if not (if not RetrievedAt then nil else v3 - RetrievedAt) then
            return nil
        end
        if a1.MaxAge <= v1 and not a1.ReturnStale then
            return nil
        end
        a1:SetUsedAt(v2, v3)
        return v2.Value
    end,
}

function AsyncCallback(a1, a2, a3, a4) -- Line: 115 -- upvalues: u17 (val) -- types: a2: table, a4: number
    local RetrievedAt = a2.RetrievedAt
    local v1 = if not RetrievedAt then nil else a4 - RetrievedAt
    if v1 and v1 < a1.MaxAge then
        return a2.Value
    end
    local AttemptedAt = a2.AttemptedAt
    if (if not AttemptedAt then (1 / 0) else a4 - AttemptedAt) < a1.FailureRetryDelay then
        if a1.ReturnStale then
            return a2.Value
        end
        return nil
    end
    a2.AttemptedAt = a4
    local success, err = pcall(a1.Callback, a3)
    local v2 = os.clock()
    a2.AttemptedAt = v2
    a1:SetUsedAt(a2, v2)
    if not success then
        if a1.ReturnStale then
            return a2.Value
        end
        return nil
    end
    if a1.Freeze then
        err = u17(err)
    end
    a2.Value = err
    a2.RetrievedAt = v2
    a1.Updated:Fire(a3)
    return err
end

function v1.GetAsync(a1, a2) -- Line: 142 -- upvalues: Lock (val)
    local v1 = os.clock()
    local v2 = a1.AssertKey(a2)
    local v3 = a1.Cache[v2]
    if v3 then
        a1:SetUsedAt(v3, v1)
    else
        local v4 = {Lock = Lock.new(), UsedAt = v1}
        a1.Cache[v2] = v4
        a1:InsertUsedAt(v4)
        v3 = v4
    end
    return v3.Lock:Call(AsyncCallback, a1, v3, a2, v1)
end

function v1.Delete(a1, a2) -- Line: 160
    local v1 = a1.AssertKey(a2)
    if a1.Cache[v1] then
        a1.Cache[v1] = nil
        a1.Deleted:Fire(a2)
    end
end

local u47 = table.freeze({__index = table.freeze(v1)})
local u65 = Asserts.Table({
    Callback = Asserts.Function,
    AssertKey = Asserts.Function,
    MaxAge = Asserts.Optional(Asserts.NonNegative),
    FailureRetryDelay = Asserts.Optional(Asserts.NonNegative),
    ReturnStale = Asserts.Optional(Asserts.Boolean),
    Freeze = Asserts.Optional(Asserts.Boolean),
})
return table.freeze({
    new = function(a1) -- Line: 196 -- upvalues: u65 (val), Bindable (val), u47 (val) -- types: a1: table
        u65(a1)
        local v1 = {
            Updated = Bindable.new(),
            Deleted = Bindable.new(),
            Callback = a1.Callback,
            AssertKey = a1.AssertKey,
            MaxAge = a1.MaxAge or (1 / 0),
            FailureRetryDelay = a1.FailureRetryDelay or 300,
            ReturnStale = if a1.ReturnStale == nil then true else a1.ReturnStale,
            Freeze = if a1.Freeze == nil then true else a1.Freeze,
            Cache = {},
        }
        local v2 = setmetatable(v1, u47)
        table.freeze(v2)
        return v2
    end,
})