-- Script path: ReplicatedStorage.Shared.Modules.CoreProfileManager
-- Decompile time: 7.68 ms

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.Promise)
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local t = require(ReplicatedStorage.Packages.t)
local u28 = Log.new()
local u29 = nil

local function defaultKeyOf(a1) -- Line: 35 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Player"))(a1)
    return a1.UserId
end

local function locate(a1, a2) -- Line: 40 -- types: a2: userdata
    local v1 = assert(a1.keyOf(a2), "the key parser produced nothing for this player")
    return a1.store[v1], v1
end

u29 = {
    ProfileRemoving = Signal.new(),
    ProfileAdded = Signal.new(),
    is = function(a1) -- Line: 49 -- upvalues: u29 (ref)
        return typeof(a1) == "table" and (getmetatable(a1)) == u29
    end,
    new = function(a1, a2) -- Line: 54
        -- upvalues: t (val), HttpService (val), defaultKeyOf (val), u29 (ref)
        t.strict(t.optional(t.callback))(a2)
        t.strict(t.optional(t.table))(a1)
        return (setmetatable({
            id = (HttpService:GenerateGUID(false)):gsub("-", ""):lower(),
            store = a1 or {},
            keyOf = a2 or defaultKeyOf,
        }, u29))
    end,
    Get = function(self, a2) -- Line: 62 -- upvalues: Promise (val) -- types: a2: userdata
        local v1 = self.store[(assert(self.keyOf(a2), "the key parser produced nothing for this player"))]
        if v1 == nil then
            return (Promise.reject("no profile is registered under that lookup")), false
        end
        return (Promise.resolve(v1)), true
    end,
    GetAll = function(a1) -- Line: 71
        return table.clone(a1.store)
    end,
    GetAssert = function(a1, a2) -- Line: 73 -- types: a2: userdata
        return a1:Get(a2):expect()
    end,
    GetAsync = function(a1, a2) -- Line: 75 -- upvalues: locate (val), Promise (val), u29 (ref) -- types: a2: userdata
        local v1 = a1.store[(assert(a1.keyOf(a2), "the key parser produced nothing for this player"))]
        if v1 then
            return v1
        end
        local u16 = select(2, locate(a1, a2))

        local function mine(a1_2, a2, a3) -- Line: 86
            -- upvalues: a1 (val), u16 (val)
            local v1 = false
            if a1_2 == a1.id then
                v1 = a2 == u16
            end
            return v1
        end

        local v2 = (Promise.fromEvent(u29.ProfileAdded, mine)):andThen(function(a1, a2, a3) -- Line: 91 -- types: a3: userdata
            return a3
        end)
        local v3 = (Promise.fromEvent(u29.ProfileRemoving, mine)):andThen(function() -- Line: 93 -- upvalues: Promise (upval), u16 (val)
            return Promise.reject((("player %* left before a profile arrived"):format(u16)))
        end)
        return Promise.race({v2, v3}):expect()
    end,
    IsProfileRegistered = function(a1, a2) -- Line: 99 -- types: a2: userdata
        return not not a1.store[(assert(a1.keyOf(a2), "the key parser produced nothing for this player"))]
    end,
    Set = function(a1, a2, ...) -- Line: 103 -- upvalues: u29 (ref) -- types: a2: userdata
        local v1 = assert(a1.keyOf(a2), "the key parser produced nothing for this player")
        local v2 = a1.store[v1]
        local v3 = v1
        a1.store[v3] = (...)
        if not v2 then
            u29.ProfileAdded:Fire(a1.id, v3, ...)
        end
    end,
    Remove = function(a1, a2) -- Line: 112 -- upvalues: u28 (val), u29 (ref) -- types: a2: userdata
        local v1 = assert(a1.keyOf(a2), "the key parser produced nothing for this player")
        local v2 = a1.store[v1]
        local v3 = v1
        if v2 == nil then
            return false, (u28:AtWarning()):Log((("nothing to remove for an unloaded player: %*"):format(v3)))
        end
        u29.ProfileRemoving:Fire(a1.id, v3, v2)
        a1.store[v3] = nil
        return true
    end,
}
u29.__index = u29
return u29