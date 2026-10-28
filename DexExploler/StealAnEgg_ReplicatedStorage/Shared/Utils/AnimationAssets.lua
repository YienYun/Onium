-- Script path: ReplicatedStorage.Shared.Utils.AnimationAssets
-- Decompile time: 1.64 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetIds = require(ReplicatedStorage.Shared.Utils.AssetIds)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
local v1 = {}
local u16 = {}
local u17 = {}
local u18 = false

local function schedulePreload(a1) -- Line: 13 -- upvalues: u17 (ref), u18 (ref), Preload (val) -- types: a1: userdata
    table.insert(u17, a1)
    if u18 then
        return
    end
    u18 = true
    task.defer(function() -- Line: 20 -- upvalues: u17 (upval), Preload (upval), u18 (upval)
        local v1
        repeat
            v1 = u17
            u17 = {}
            if #v1 > 0 then
                Preload.WarmAssets(v1)
            end
        until #u17 == 0
        u18 = false
    end)
end

function v1.Get(a1) -- Line: 32 -- upvalues: AssetIds (val), u16 (val), u17 (ref), u18 (ref), Preload (val)
    local v1 = AssetIds.Parse(a1)
    local v2 = ("invalid animation asset id %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = u16[v1]
    if v3 then
        return v3
    end
    local Animation = Instance.new("Animation")
    Animation.Name = ("Animation_%*"):format(v1)
    Animation.AnimationId = ("rbxassetid://%*"):format(v1)
    u16[v1] = Animation
    table.insert(u17, Animation)
    if u18 then
        return Animation
    end
    u18 = true
    task.defer(function() -- Line: 20 -- upvalues: u17 (upval), Preload (upval), u18 (upval)
        local v1
        repeat
            v1 = u17
            u17 = {}
            if #v1 > 0 then
                Preload.WarmAssets(v1)
            end
        until #u17 == 0
        u18 = false
    end)
    return Animation
end

return (table.freeze(v1))