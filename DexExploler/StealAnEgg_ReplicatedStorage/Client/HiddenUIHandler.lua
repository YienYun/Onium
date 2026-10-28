-- Script path: ReplicatedStorage.Client.HiddenUIHandler
-- Decompile time: 1.86 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local u17 = {}
u17.Changed = Signal.new()
local u20 = {}
u20[1] = (GUI.HUD())
u20[2] = (GUI.Backpack())
u20[3] = GUI.OfflineMoneyInPlot()
local u27 = 0
local u28 = nil

local function isHidden() -- Line: 21 -- upvalues: u27 (ref)
    return u27 > 0
end

local function update() -- Line: 25 -- upvalues: u28 (ref), u27 (ref), u20 (val), Tabs (val)
    u28 = nil
    local v1 = not (u27 > 0)
    for i, j in u20 do
        j.Enabled = v1
    end
    if not v1 then
        Tabs.Deactivate()
    end
end

local function scheduleUpdate() -- Line: 36 -- upvalues: u28 (ref), update (val)
    if u28 then
        task.cancel(u28)
    end
    task.defer(update)
end

function u17.IsHidden() -- Line: 43 -- upvalues: u27 (ref)
    return u27 > 0
end

function u17.Acquire() -- Line: 47 -- upvalues: u27 (ref), u28 (ref), update (val), u17 (val)
    u27 = u27 + 1
    if u28 then
        task.cancel(u28)
    end
    u28 = task.defer(update)
    u17.Changed:Fire(true)
    local u15 = false
    return function() -- Line: 53 -- upvalues: u15 (ref), u27 (upval), u28 (upval), update (upval), u17 (upval)
        if u15 then
            return
        end
        u15 = true
        u27 = u27 - 1
        assert(u27 >= 0, "hidden UI holder count became negative")
        if u28 then
            task.cancel(u28)
        end
        task.defer(update)
        u17.Changed:Fire(u27 > 0)
    end
end

return (table.freeze(u17))