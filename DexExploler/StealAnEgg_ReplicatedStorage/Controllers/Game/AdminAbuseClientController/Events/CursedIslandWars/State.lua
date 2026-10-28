-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.State
-- Decompile time: 1.87 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Data.CursedIslandWars)
local Signal_2 = require(ReplicatedStorage.Packages.Signal)
local LocalPlayer = Players.LocalPlayer
local u24 = {}
u24.Changed = Signal_2.new()

function u24.Now() -- Line: 20 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

function u24.Set(a1) -- Line: 24 -- upvalues: u24 (val)
    u24.Snapshot = a1
    u24.Changed:Fire(a1)
end

function u24.Entries() -- Line: 29 -- upvalues: u24 (val)
    local Snapshot = u24.Snapshot
    if Snapshot then
        return Snapshot.Entries
    end
    return {}
end

function u24.Entry(a1) -- Line: 34 -- upvalues: u24 (val) -- types: a1: string?
    if a1 == nil then
        return nil
    end
    for i, j in u24.Entries() do
        if j.Id == a1 then
            return j
        end
    end
    return nil
end

function u24.Me() -- Line: 46 -- upvalues: u24 (val), LocalPlayer (val)
    for i, j in u24.Entries() do
        if j.UserId == LocalPlayer.UserId then
            return j
        end
    end
    return nil
end

function u24.Root(a1) -- Line: 55
    local Model = if not a1 then nil else a1.Model
    if Model then
        return (Model:FindFirstChild("HumanoidRootPart"))
    end
    return nil
end

function u24.Phase() -- Line: 60 -- upvalues: u24 (val)
    local Snapshot = u24.Snapshot
    if Snapshot then
        return Snapshot.Phase
    end
    return nil
end

function u24.Island() -- Line: 65 -- upvalues: u24 (val)
    local Snapshot = u24.Snapshot
    if Snapshot then
        return Snapshot.Island
    end
    return nil
end

function u24.Fighting() -- Line: 70 -- upvalues: u24 (val)
    local v1 = u24.Phase()
    local v2 = true
    if v1 ~= "Match" then
        v2 = v1 == "SuddenDeath"
    end
    return v2
end

function u24.Armed() -- Line: 75 -- upvalues: u24 (val)
    local v1 = true
    if u24.Phase() ~= "Prep" then
        v1 = u24.Fighting()
    end
    return v1
end

return u24