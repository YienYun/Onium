-- Script path: ReplicatedStorage.Shared.Flags.LiveEventFlags
-- Decompile time: 9.96 ms

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = {}

local function decodeJson(a1) -- Line: 40 -- upvalues: HttpService (val)
    if type(a1) ~= "string" then
        return false, nil
    end
    local success = pcall(HttpService.JSONDecode, HttpService, a1)
    return success
end

local function define(a1, a2, a3) -- Line: 47
    -- upvalues: Asserts (val), DeepFreezeUnsafe (val), DeepCopyPureUnsafe (val), Signal (val), HttpService (val)
    -- upvalues: DeepEqualsPureUnsafe (val)
    local v1
    Asserts.String(a1)
    local v2 = ("live event flag name %* must be alphanumeric"):format(a1)
    assert(string.match(a1, "^%w+$") ~= nil, v2)
    Asserts.Function(a2)
    a2(a3)
    Asserts.Storable(a3)
    local u39 = DeepFreezeUnsafe(DeepCopyPureUnsafe(a3))
    local u42 = "LiveEventFlag_" .. a1
    local u45 = u42 .. "_Steps"
    local u48 = Signal.new()

    local function decodeAttribute(a1_2) -- Line: 59
        -- upvalues: u39 (val), HttpService (upval), a1 (val), a2 (val), DeepFreezeUnsafe (upval)
        local v1, v2
        if a1_2 == nil then
            return false, u39
        end
        if type(a1_2) == "string" then
            local v3 = HttpService
            local success, err = pcall(HttpService.JSONDecode, v3, a1_2)
            v1 = success
            v2 = err
        else
            v1 = false
            v2 = nil
        end
        if not v1 then
            warn((("[LiveEventFlags] UndecodableValue '%*'"):format(a1)))
            return true, u39
        end
        local success_2, err_2 = pcall(a2, v2)
        if success_2 then
            return true, DeepFreezeUnsafe(v2)
        end
        warn(("[LiveEventFlags] InvalidStoredValue '%*':"):format(a1), err_2, v2)
        return true, u39
    end

    local u59 = nil
    local u64 = false
    local u65 = u39

    local function refreshFromAttribute() -- Line: 80
        -- upvalues: u42 (val), u59 (ref), u64 (ref), u65 (ref), decodeAttribute (val)
        local Attribute = workspace:GetAttribute(u42)
        if Attribute == u59 then
            return
        end
        u59 = Attribute
        local v1, v2 = decodeAttribute(Attribute)
        u64 = v1
        u65 = v2
    end

    local Attribute = workspace:GetAttribute(u42)
    if Attribute ~= u59 then
        local v3
        u59 = Attribute
        v1, v3 = decodeAttribute(Attribute)
        u64 = v1
        u65 = v3
    end
    local u67 = u65
    v1 = {
        Name = a1,
        AttributeName = u42,
        StepsAttributeName = u45,
        DefaultValue = u39,
        Assertion = a2,
        Changed = u48,
        Get = function(a1) -- Line: 98
            -- upvalues: u42 (val), u59 (ref), u64 (ref), u65 (ref), decodeAttribute (val)
            local Attribute = workspace:GetAttribute(u42)
            if Attribute ~= u59 then
                u59 = Attribute
                local v1, v2 = decodeAttribute(Attribute)
                u64 = v1
                u65 = v2
            end
            return u65
        end,
        IsSynced = function(a1) -- Line: 102
            -- upvalues: u42 (val), u59 (ref), u64 (ref), u65 (ref), decodeAttribute (val)
            local Attribute = workspace:GetAttribute(u42)
            if Attribute ~= u59 then
                u59 = Attribute
                local v1, v2 = decodeAttribute(Attribute)
                u64 = v1
                u65 = v2
            end
            return u64
        end,
        GetPendingSteps = function(a1) -- Line: 106
            -- upvalues: u45 (val), HttpService (upval), a2 (val), DeepFreezeUnsafe (upval)
            local v1, v2
            local v3 = {}
            local Attribute = workspace:GetAttribute(u45)
            if type(Attribute) == "string" then
                local v4 = HttpService
                local success, err = pcall(HttpService.JSONDecode, v4, Attribute)
                v1 = success
                v2 = err
            else
                v1 = false
                v2 = nil
            end
            if v1 and type(v2) == "table" then
                local success_2
                v1 = os.time()
                for i, j in v2 do
                    if type(j) == "table" and type(j.At) == "number" and not (j.At <= v1) then
                        success_2 = pcall(a2, j.Value)
                        if success_2 then
                            table.insert(v3, {At = j.At, Value = DeepFreezeUnsafe(j.Value)})
                        end
                    end
                end
                table.sort(v3, function(a1, a2) -- Line: 121
                    return a1.At < a2.At
                end)
                return v3
            end
            return v3
        end,
    }
    ;(workspace:GetAttributeChangedSignal(u42)):Connect(function() -- Line: 128
        -- upvalues: u42 (val), u59 (ref), u64 (ref), u65 (ref), decodeAttribute (val), DeepEqualsPureUnsafe (upval)
        -- upvalues: u67 (ref), u48 (val)
        local Attribute = workspace:GetAttribute(u42)
        if Attribute ~= u59 then
            u59 = Attribute
            local v1, v2 = decodeAttribute(Attribute)
            u64 = v1
            u65 = v2
        end
        if DeepEqualsPureUnsafe(u65, u67) then
            return
        end
        local v3 = u67
        u67 = u65
        u48:Fire(u65, v3)
    end)
    return (table.freeze(v1))
end

v1.Directory = table.freeze({
    TrainEventOpen = define("TrainEventOpen", function(a1) -- Line: 170 -- upvalues: Asserts (val)
        if a1 == false then
            return a1
        end
        assert(type(a1) == "table", "TrainEventOpen must be false or a table")
        Asserts.FinitePositive(a1.CutsceneEndedAt)
        return a1
    end, false),
    LightDarkReveal = define("LightDarkReveal", function(a1) -- Line: 148
        if a1 == false then
            return a1
        end
        assert(type(a1) == "table", "LightDarkReveal must be false or a table")
        local v1 = false
        if type(a1.RevealPeriod) == "number" then
            v1 = a1.RevealPeriod % 1 == 0
        end
        assert(v1, "LightDarkReveal.RevealPeriod must be an integer")
        v1 = true
        if a1.Winner ~= "Light" then
            v1 = a1.Winner == "Dark"
        end
        assert(v1, "LightDarkReveal.Winner must be Light or Dark")
        v1 = true
        if a1.WinnerPeriod ~= nil then
            v1 = false
            if type(a1.WinnerPeriod) == "number" then
                v1 = a1.WinnerPeriod % 1 == 0
            end
        end
        assert(v1, "LightDarkReveal.WinnerPeriod must be nil or an integer")
        return a1
    end, false),
    RiftOpen = define("RiftOpen", Asserts.Boolean, false),
    EnchantedForestOpen = define("EnchantedForestOpen", Asserts.Boolean, false),
    StarHandlerOpen = define("StarHandlerOpen", Asserts.Boolean, false),
    HalloweenDimensionContentEnabled = define("HalloweenDimensionContentEnabled", Asserts.Boolean, false),
    HalloweenManorGateOpen = define("HalloweenManorGateOpen", Asserts.Boolean, false),
})
local u77 = {}
local v2 = {}
for i, j in v1.Directory do
    u77[i] = j
    table.insert(v2, i)
end
table.sort(v2)
v1.Names = table.freeze(v2)

function v1.Get(a1) -- Line: 203 -- upvalues: u77 (val) -- types: a1: string
    local v1 = u77[a1]
    local v2 = ("unknown live event flag %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1
end

function v1.IsKnown(a1) -- Line: 209 -- upvalues: u77 (val)
    local v1 = false
    if type(a1) == "string" then
        v1 = u77[a1] ~= nil
    end
    return v1
end

return table.freeze(v1)