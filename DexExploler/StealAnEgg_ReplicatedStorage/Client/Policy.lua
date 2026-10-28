-- Script path: ReplicatedStorage.Client.Policy
-- Decompile time: 1.82 ms

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u25 = Log.new()
local u26 = nil
local u27 = {}
u27.Loaded = Signal.new()

function u27.Get() -- Line: 42 -- upvalues: u26 (ref)
    return u26
end

function u27.IsLoaded() -- Line: 46 -- upvalues: u26 (ref)
    return u26 ~= nil
end

function u27.GetAsync() -- Line: 50 -- upvalues: u26 (ref), u27 (val)
    local v1 = u26
    if v1 ~= nil then
        return v1
    end
    return u27.Loaded:Wait()
end

function u27.IsEndlessContentLoadAllowed() -- Line: 59 -- upvalues: u26 (ref)
    local v1 = u26
    if v1 == nil then
        return false
    end
    return v1.IsEndlessContentLoadAllowed ~= false
end

task.spawn(function() -- Line: 71 -- upvalues: u26 (ref), PolicyService (val), Players (val), u27 (val), u25 (val)
    local err, success, v1
    local v2 = 0
    while u26 == nil do
        success, err = pcall(function() -- Line: 74 -- upvalues: PolicyService (upval), Players (upval)
            return PolicyService:GetPolicyInfoForPlayerAsync(Players.LocalPlayer)
        end)
        if success and type(err) == "table" then
            v1 = table.freeze(err)
            u26 = v1
            u27.Loaded:Fire(v1)
            return
        end
        v2 = v2 + 1
        ;(u25:AtWarning()):Log((("Failed to fetch local player policy info (attempt %*): %*"):format(v2, err)))
        task.wait((math.min(2 ^ (v2 - 1) * 2, 30)))
    end
end)
return u27