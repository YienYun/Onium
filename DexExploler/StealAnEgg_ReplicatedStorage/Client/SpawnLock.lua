-- Script path: ReplicatedStorage.Client.SpawnLock
-- Decompile time: 5.52 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u20 = {}
local u21 = nil
local u22 = false
local v1 = {}

local function anyClaims() -- Line: 19 -- upvalues: u20 (val)
    return next(u20) ~= nil
end

local function findTemplate() -- Line: 23 -- upvalues: ReplicatedStorage (val), u22 (ref)
    local SpawnLock
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    if (if Assets == nil then nil else Assets:FindFirstChild("SpawnLock")) == nil and not u22 then
        u22 = true
        warn("SpawnLock: ReplicatedStorage.Assets.SpawnLock does not exist, so the spawn barrier cannot be raised")
    end
    return SpawnLock
end

local function collidableParts(a1) -- Line: 35 -- types: a1: userdata
    local u1 = {}

    local function consider(a1) -- Line: 37 -- upvalues: u1 (val) -- types: a1: userdata
        if a1:IsA("BasePart") and a1.CanCollide then
            u1[#u1 + 1] = a1
        end
    end

    if a1:IsA("BasePart") and a1.CanCollide then
        u1[#u1 + 1] = a1
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.CanCollide then
            u1[#u1 + 1] = j
        end
    end
    return u1
end

local function touchesCharacter(a1, a2) -- Line: 49 -- upvalues: Workspace (val) -- types: a1: userdata, a2: userdata
    local v1 = OverlapParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = {a2}
    return #Workspace:GetPartsInPart(a1, v1) > 0
end

local function solidifyOnceClear(a1) -- Line: 59
    -- upvalues: collidableParts (val), RunService (val), Players (val), touchesCharacter (val)
    local u3 = collidableParts(a1)
    for i, j in u3 do
        j.CanCollide = false
    end
    if #u3 == 0 then
        return
    end
    task.spawn(function() -- Line: 67 -- upvalues: u3 (val), RunService (upval), a1 (val), Players (upval), touchesCharacter (upval)
        local Character, LocalPlayer, v1
        while true do
            if not (#u3 > 0) then
                break
            end
            RunService.Heartbeat:Wait()
            if a1.Parent == nil then
                return
            end
            LocalPlayer = Players.LocalPlayer
            Character = if LocalPlayer == nil then nil else LocalPlayer.Character
            for i = #u3, 1, -1 do
                v1 = u3[i]
                if Character == nil or not touchesCharacter(v1, Character) then
                    v1.CanCollide = true
                    table.remove(u3, i)
                end
            end
        end
    end)
end

local function raiseBarrier() -- Line: 86
    -- upvalues: ReplicatedStorage (val), u22 (ref), solidifyOnceClear (val), Workspace (val)
    local v1
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    if (if Assets == nil then nil else Assets:FindFirstChild("SpawnLock")) == nil and not u22 then
        u22 = true
        warn("SpawnLock: ReplicatedStorage.Assets.SpawnLock does not exist, so the spawn barrier cannot be raised")
    end
    if v1 == nil then
        return nil
    end
    local v2 = v1:Clone()
    solidifyOnceClear(v2)
    v2.Parent = Workspace
    return v2
end

local function syncBarrier() -- Line: 97
    -- upvalues: u21 (ref), u20 (val), ReplicatedStorage (val), u22 (ref), solidifyOnceClear (val), Workspace (val)
    local v1 = u21
    if not (next(u20) ~= nil) then
        u21 = nil
        if v1 ~= nil then
            v1:Destroy()
        end
        return
    end
    if v1 == nil or v1.Parent == nil then
        local v2, v3
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        if (if Assets == nil then nil else Assets:FindFirstChild("SpawnLock")) == nil and not u22 then
            u22 = true
            warn("SpawnLock: ReplicatedStorage.Assets.SpawnLock does not exist, so the spawn barrier cannot be raised")
        end
        if v3 ~= nil then
            local v4 = v3:Clone()
            solidifyOnceClear(v4)
            v4.Parent = Workspace
            v2 = v4
        else
            v2 = nil
        end
        u21 = v2
    end
end

function v1.ObtainLock() -- Line: 111
    -- upvalues: u20 (val), u21 (ref), ReplicatedStorage (val), u22 (ref), solidifyOnceClear (val), Workspace (val)
    local u2 = table.freeze({})
    u20[u2] = true
    local v1 = u21
    local v2 = next(u20) ~= nil
    if not v2 then
        u21 = nil
        if v1 ~= nil then
            v1:Destroy()
        end
    elseif v1 == nil or v1.Parent == nil then
        local v3
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        if (if Assets == nil then nil else Assets:FindFirstChild("SpawnLock")) == nil and not u22 then
            u22 = true
            warn("SpawnLock: ReplicatedStorage.Assets.SpawnLock does not exist, so the spawn barrier cannot be raised")
        end
        if v3 ~= nil then
            local v4 = v3:Clone()
            solidifyOnceClear(v4)
            v4.Parent = Workspace
            v2 = v4
        else
            v2 = nil
        end
        u21 = v2
    end
    return function() -- Line: 115
        -- upvalues: u20 (upval), u2 (val), u21 (upval), ReplicatedStorage (upval), u22 (upval)
        -- upvalues: solidifyOnceClear (upval), Workspace (upval)
        local v1, v2
        if u20[u2] == nil then
            return
        end
        u20[u2] = nil
        local v3 = u21
        if not (next(u20) ~= nil) then
            u21 = nil
            if v3 ~= nil then
                v3:Destroy()
            end
            return
        end
        if v3 ~= nil and v3.Parent ~= nil then
            return
        end
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        if (if Assets == nil then nil else Assets:FindFirstChild("SpawnLock")) == nil and not u22 then
            u22 = true
            warn("SpawnLock: ReplicatedStorage.Assets.SpawnLock does not exist, so the spawn barrier cannot be raised")
        end
        if v2 ~= nil then
            local v4 = v2:Clone()
            solidifyOnceClear(v4)
            v4.Parent = Workspace
            v1 = v4
        else
            v1 = nil
        end
        u21 = v1
    end
end

function v1.IsLocked() -- Line: 124 -- upvalues: u20 (val)
    return next(u20) ~= nil
end

return (table.freeze(v1))