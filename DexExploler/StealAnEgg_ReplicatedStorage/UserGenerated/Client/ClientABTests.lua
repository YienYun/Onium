-- Script path: ReplicatedStorage.UserGenerated.Client.ClientABTests
-- Decompile time: 3.18 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedABTests = require(ReplicatedStorage.UserGenerated.ABTests.SharedABTests)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local LocalPlayer = Players.LocalPlayer
local u26 = false
local u29 = Bindable.new()
local u31 = nil

local function GetAssignmentsAsync(a1, a2) -- Line: 36
    -- upvalues: LocalPlayer (val), u31 (ref)
    local v1
    local v2 = false
    if typeof(a1) == "Instance" then
        v2 = a1:IsA("Player")
    end
    assert(v2)
    assert(type(a2) == "boolean")
    if a1 ~= LocalPlayer then
        return nil
    end
    while true do
        if u31 then
            break
        end
        if not a2 or not a1.Parent then
            return nil
        end
        task.wait()
    end
    return v1
end

local u33 = nil

local function GetAttribute(a1, a2, a3) -- Line: 65
    -- upvalues: LocalPlayer (val), u33 (ref)
    local v1
    assert(type(a2) == "string")
    if a1 == LocalPlayer then
        v1 = u33
    else
        local v2 = false
        if typeof(a1) == "Instance" then
            v2 = a1:IsA("Player")
        end
        assert(v2)
        v1 = nil
    end
    local v3 = v1 and v1[a2]
    if v3 == nil then
        return a3, false
    end
    return v3, true
end

local function GetAttributeAsync(a1, a2, a3) -- Line: 74
    -- upvalues: GetAssignmentsAsync (val), GetAttribute (val)
    assert(type(a2) == "string")
    if not GetAssignmentsAsync(a1, true) then
        return a3, false
    end
    return GetAttribute(a1, a2, a3)
end

local u43 = Bindable.new()
local u45 = Bindable.new()
SharedABTests.UpdateRemote.OnClientEvent:Connect(function(a1, a2) -- Line: 102
    -- upvalues: DeepFreezeUnsafe (val), u33 (ref), u31 (ref), u26 (ref), u29 (val), u43 (val), LocalPlayer (val)
    -- upvalues: u45 (val)
    DeepFreezeUnsafe(a1)
    DeepFreezeUnsafe(a2)
    u33 = a1
    u31 = a2
    u26 = true
    u29:Fire()
    u43:Fire(LocalPlayer)
    u45:Fire()
end)
return (table.freeze({
    GetAttributes = function(a1) -- Line: 58 -- upvalues: LocalPlayer (val), u33 (ref) -- types: a1: userdata
        if a1 == LocalPlayer then
            return u33
        end
        local v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("Player")
        end
        assert(v1)
        return nil
    end,
    GetAttribute = GetAttribute,
    GetAttributeAsync = GetAttributeAsync,
    GetAssignmentsAsync = GetAssignmentsAsync,
    GetJobAttributes = function() -- Line: 82 -- upvalues: LocalPlayer (val), u33 (ref)
        local v1 = LocalPlayer
        if v1 == LocalPlayer then
            return u33
        end
        local v2 = false
        if typeof(v1) == "Instance" then
            v2 = v1:IsA("Player")
        end
        assert(v2)
        return nil
    end,
    GetJobAttribute = function(a1, a2) -- Line: 85 -- upvalues: GetAttribute (val), LocalPlayer (val) -- types: a1: string
        return GetAttribute(LocalPlayer, a1, a2)
    end,
    GetJobAttributeAsync = function(a1, a2) -- Line: 88 -- upvalues: GetAttributeAsync (val), LocalPlayer (val) -- types: a1: string
        return GetAttributeAsync(LocalPlayer, a1, a2)
    end,
    GetJobAssignments = function() -- Line: 91 -- upvalues: u31 (ref)
        return u31
    end,
    GetJobAssignmentsAsync = function(a1) -- Line: 94 -- upvalues: GetAssignmentsAsync (val), LocalPlayer (val) -- types: a1: boolean
        return GetAssignmentsAsync(LocalPlayer, a1)
    end,
    IsLoaded = function() -- Line: 31 -- upvalues: u26 (ref)
        return u26
    end,
    Loaded = u29,
    PlayerUpdated = u43,
    JobUpdated = u45,
}))