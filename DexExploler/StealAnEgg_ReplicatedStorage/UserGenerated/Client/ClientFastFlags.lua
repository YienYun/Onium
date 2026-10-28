-- Script path: ReplicatedStorage.UserGenerated.Client.ClientFastFlags
-- Decompile time: 5.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("Players")
assert((RunService:IsClient()))
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local v1 = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local ObjectPaths = require(ReplicatedStorage.UserGenerated.Strings.ObjectPaths)
local v2 = {}
local u59 = table.freeze({__index = v2})

function v2.Get(a1) -- Line: 45
    return a1.Value
end

function v2.GetAsync(a1) -- Line: 48
    if a1.ValueLoaded then
        return a1.Value
    end
    local u4 = coroutine.running()
    local v1 = a1.Loaded:Connect(function() -- Line: 53 -- upvalues: u4 (val)
        task.spawn(u4)
    end)
    coroutine.yield()
    v1:Disconnect()
    return a1.Value
end

function v2.IsLoaded(a1) -- Line: 60
    return a1.ValueLoaded
end

table.freeze(v2)
local NullValue = v1.NullValue
local UpdateRemote = v1.UpdateRemote
local u70 = {}
local u71 = false
local u72 = {}
local u74 = Bindable.new()

local function DecodeValue(a1) -- Line: 86 -- upvalues: NullValue (val)
    if a1 ~= NullValue then
        return a1
    end
    return nil
end

local function Create(a1, a2, a3) -- Line: 141
    -- upvalues: Asserts (val), DeepCopyPureUnsafe (val), DeepFreezeUnsafe (val), u70 (val), ObjectPaths (val)
    -- upvalues: u72 (ref), NullValue (val), u71 (ref), Bindable (val), u59 (val)
    Asserts.String(a1)
    Asserts.Function(a2)
    a2(a3)
    Asserts.Optional(Asserts.Storable)(a3)
    local v1 = DeepCopyPureUnsafe(a3)
    DeepFreezeUnsafe(v1)
    assert(not u70[a1], (("ConflictingKeys: %*, %*"):format(a1, a1)))
    for k, v in pairs(u70) do
        if ObjectPaths.HasHierarchicalOverlap(a1, k) then
            error((("ConflictingKeys: %*, %*"):format(a1, k)))
        end
    end
    local v2 = false
    local v3 = v1
    local v4 = u72[a1]
    if v4 ~= nil then
        v3 = if v4 == NullValue then nil else v4
        v2 = u71
    end
    v4 = {
        Replicated = true,
        Changed = Bindable.new(),
        Loaded = Bindable.new(),
        Key = a1,
        DefaultValue = v1,
        Assertion = a2,
        ValueLoaded = v2,
        Value = v3,
    }
    v3 = setmetatable(v4, u59)
    u70[a1] = v3
    return v3
end

local v3 = {
    Loaded = u74,
    IsA = function(a1) -- Line: 64 -- upvalues: u59 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u59
        end
        return v1
    end,
    Assert = function(a1) -- Line: 68 -- upvalues: u59 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u59
        end
        if not v1 then
            error("FastFlag", 2)
        end
        return a1
    end,
    Replicated = function(a1, a2, a3) -- Line: 193 -- upvalues: Create (val) -- types: a1: string, a2: function
        return (Create(a1, a2, a3))
    end,
    Private = function(a1, a2, a3) -- Line: 197 -- types: a1: string, a2: function
        error("ServerOnly")
    end,
    Get = function(a1) -- Line: 201 -- upvalues: u70 (val), Asserts (val) -- types: a1: string
        local v1 = u70[a1]
        if v1 then
            return v1
        end
        Asserts.String(a1)
        error((("UnknownKey: '%*'"):format(a1)))
    end,
    IsLoaded = function() -- Line: 210 -- upvalues: u71 (ref)
        return u71
    end,
}
UpdateRemote.OnClientEvent:Connect(function(a1, a2) -- Line: 90
    -- upvalues: u72 (ref), DeepFreezeUnsafe (val), u70 (val), NullValue (val), DeepEqualsPureUnsafe (val), u71 (ref)
    -- upvalues: u74 (val)
    local Value, v1, v2
    local v3 = table.clone(u72)
    for k, v in pairs(a1) do
        v3[k] = v
    end
    DeepFreezeUnsafe(v3)
    u72 = v3
    v3 = {}
    local v4 = {}
    local v5 = a2
    for k2, i in pairs(a1) do
        v2 = u70[k2]
        if v2 then
            v1 = if i == NullValue then nil else i
            Value = v2.Value
            if not DeepEqualsPureUnsafe(v1, Value) then
                v2.Value = v1
                table.insert(v4, {instance = v2, value = v1, prevValue = Value})
            end
            if v5 and not v2.ValueLoaded then
                v2.ValueLoaded = true
                table.insert(v3, v2)
            end
        end
    end
    local v6 = v5 and not u71
    if v6 then
        u71 = true
    end
    for i2, j in ipairs(v3) do
        j.Loaded:Fire()
    end
    if v6 then
        u74:Fire()
    end
    for i3, k3 in ipairs(v4) do
        k3.instance.Changed:Fire(k3.value, k3.prevValue)
    end
end)
table.freeze(v3)
return v3