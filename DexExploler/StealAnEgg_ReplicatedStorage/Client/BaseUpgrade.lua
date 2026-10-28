-- Script path: ReplicatedStorage.Client.BaseUpgrade
-- Decompile time: 3.90 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bases = require(ReplicatedStorage.Data.Bases)
local QueueLock = require(ReplicatedStorage.Shared.Modules.QueueLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Audio = require(ReplicatedStorage.Shared.Audio)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u58 = Color3.fromRGB(255, 64, 64)
local u59 = {soundId = 119855061490364, volume = 1.5, pitchRange = {0.9, 1.1}}
local LocalPlayer = Players.LocalPlayer
local u66 = Log.new()
local u69 = QueueLock.new()
local u72 = Signal.new()
local u73 = false
local v1 = {}
local u75 = {Completed = u72}

function u75.Begin() -- Line: 52 -- upvalues: u73 (ref)
    assert(not u73, "nested base upgrade transitions are not supported")
    u73 = true
end

function u75.Complete() -- Line: 57 -- upvalues: u73 (ref), u72 (val)
    assert(u73, "no base upgrade transition is in flight to finish")
    u73 = false
    u72:Fire()
end

function u75.IsPlaying() -- Line: 63 -- upvalues: u73 (ref)
    return u73
end

function u75.Play(a1) -- Line: 65 -- upvalues: u75 (val), Audio (val), u59 (val) -- types: a1: function
    assert(workspace.CurrentCamera ~= nil, "no render camera is bound on this client")
    u75.Begin()
    Audio.Play(u59.soundId, script, {PlaybackSpeed = u59.pitchRange, Volume = u59.volume})
    task.spawn(a1)
    u75.Complete()
end

v1.Transition = u75

local function tierAbove(a1) -- Line: 83 -- upvalues: t (val), Bases (val)
    t.strict(t.intersection(t.integer, t.numberMin(0)))(a1.BaseUpgradeLevel)
    local v1 = a1.BaseUpgradeLevel + 1
    return v1, Bases.BASES[v1]
end

local function isWithinBudget(a1, a2) -- Line: 91
    local v1 = false
    if a2 ~= nil then
        v1 = a2.Cost <= a1.Money
    end
    return v1
end

local function blockingNotice(a1, a2) -- Line: 96 -- upvalues: u58 (val)
    if a2 == nil then
        return {Text = "Max base upgrade reached", Seconds = 2}
    end
    if a1.Money < a2.Cost then
        return {Text = "Not enough money", Seconds = 2, Color = u58}
    end
    return nil
end

local function playThenAsk() -- Line: 109 -- upvalues: u75 (val), Remotes (val)
    u75.Play(function() -- Line: 110 -- upvalues: Remotes (upval)
        Remotes.Homestead.AskBaseTierRaise:FireServer()
    end)
end

function v1.PurchaseNextTier() -- Line: 117
    -- upvalues: Save (val), LocalPlayer (val), t (val), Bases (val), blockingNotice (val), Toast (val), u69 (val)
    -- upvalues: TryCall (val), playThenAsk (val), u66 (val)
    local v1 = Save.Await(LocalPlayer)
    assert(v1 ~= nil, "local save data has not arrived yet")
    t.strict(t.intersection(t.integer, t.numberMin(0)))(v1.BaseUpgradeLevel)
    local v2 = blockingNotice(v1, Bases.BASES[v1.BaseUpgradeLevel + 1])
    if v2 ~= nil then
        Toast.Show(v2)
    end
    local u45 = if v2 ~= nil then nil else u69:TryTake()
    if u45 == nil then
        return false
    end
    task.spawn(function() -- Line: 132 -- upvalues: TryCall (upval), playThenAsk (upval), u45 (val), u66 (upval)
        local v1, v2 = TryCall(playThenAsk)
        u45:GiveBack()
        if not v1 then
            (u66:AtError()):Log((("upgrade transition aborted before firing: %*"):format(v2)))
        end
    end)
    return true
end

function v1.ResolveNextTier(a1) -- Line: 142 -- upvalues: tierAbove (val)
    return tierAbove(a1)
end

function v1.IsNextTierAffordable(a1) -- Line: 146 -- upvalues: t (val), Bases (val)
    t.strict(t.intersection(t.integer, t.numberMin(0)))(a1.BaseUpgradeLevel)
    local v1 = a1.BaseUpgradeLevel + 1
    local v2 = Bases.BASES[v1]
    v1 = false
    if v2 ~= nil then
        v1 = v2.Cost <= a1.Money
    end
    return v1
end

return v1