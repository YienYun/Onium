-- Script path: ReplicatedStorage.Shared.Modules.FriendRoster
-- Decompile time: 4.50 ms

local sweep
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u20 = (require(ReplicatedStorage.Packages.Log)).new()
local u25 = {}
u25.RosterUpdated = require(ReplicatedStorage.Packages.Signal).new()
u25.FriendsInServerAttribute = "FriendsInServer"
local u29 = {}

local function pairKey(a1, a2) -- Line: 24 -- types: a1: number, a2: number
    if a1 < a2 then
        return (("%*:%*"):format(a1, a2))
    end
    return (("%*:%*"):format(a2, a1))
end

local function verdictFor(a1, a2) -- Line: 28 -- upvalues: u29 (val) -- types: a1: number, a2: number
    local v1 = if not (a1 < a2) then ("%*:%*"):format(a2, a1) else ("%*:%*"):format(a1, a2)
    return u29[v1]
end

local function dropVerdicts(a1) -- Line: 32 -- upvalues: u29 (val) -- types: a1: number
    local v1, v2
    local v3 = tostring(a1)
    local v4 = nil
    local v5 = nil
    for i in u29, v4, v5 do
        v1, v2 = string.match(i, "^(%d+):(%d+)$")
        if v1 == v3 or v2 == v3 then
            u29[i] = nil
        end
    end
end

local function resolvePair(a1, a2) -- Line: 44 -- upvalues: u29 (val), u20 (val) -- types: a1: userdata, a2: userdata
    local v1
    local UserId = a1.UserId
    local UserId_2 = a2.UserId
    if u29[if not (UserId < UserId_2) then ("%*:%*"):format(UserId_2, UserId) else ("%*:%*"):format(UserId, UserId_2)] ~= nil then
        return nil
    end
    u29[v1] = "asking"
    local success, err = pcall(a1.IsFriendsWith, a1, a2.UserId)
    if a1.Parent ~= nil and a2.Parent ~= nil then
        if success then
            u29[v1] = err == true
            return err == true
        end
        u29[v1] = nil
        ;(u20:AtWarning()):Log((("friendship check between %* and %* failed: %*"):format(a1.Name, a2.Name, err)))
        return nil
    end
    u29[v1] = nil
    return nil
end

function sweep(a1) -- Line: 67
    -- upvalues: Players (val), resolvePair (val), u29 (val), u25 (val), sweep (val)
    local UserId, UserId_2, v1, v2
    if a1.Parent == nil then
        return
    end
    local v3 = {a1}
    local v4 = false
    local v5 = a1
    for i, j in Players:GetPlayers() do
        if j ~= v5 then
            if resolvePair(v5, j) then
                table.insert(v3, j)
            end
            v2 = v4
            if not v2 then
                UserId_2 = v5.UserId
                UserId = j.UserId
                v1 = if not (UserId_2 < UserId) then ("%*:%*"):format(UserId, UserId_2) else ("%*:%*"):format(UserId_2, UserId)
                v2 = u29[v1] == nil
            end
            v4 = v2
        end
    end
    if v5.Parent == nil then
        return
    end
    for k, n in v3 do
        if n.Parent ~= nil then
            u25.RosterUpdated:Fire(n)
        end
    end
    if v4 then
        task.delay(45, sweep, v5)
    end
end

if RunService:IsServer() then
    Players.PlayerAdded:Connect(sweep)
    Players.PlayerRemoving:Connect(function(a1) -- Line: 99 -- upvalues: dropVerdicts (val) -- types: a1: userdata
        dropVerdicts(a1.UserId)
    end)
    for i, j in Players:GetPlayers() do
        task.spawn(sweep, j)
    end
end

local function friendsHere(a1) -- Line: 107 -- upvalues: Players (val), u29 (val) -- types: a1: userdata
    local UserId, UserId_2, v1
    local v2 = {}
    local v3 = a1
    for i, j in Players:GetPlayers() do
        if j ~= v3 then
            UserId = v3.UserId
            UserId_2 = j.UserId
            v1 = if not (UserId < UserId_2) then ("%*:%*"):format(UserId_2, UserId) else ("%*:%*"):format(UserId, UserId_2)
            if u29[v1] == true then
                table.insert(v2, j)
            end
        end
    end
    return v2
end

function u25.CountPresent(a1) -- Line: 117 -- upvalues: friendsHere (val) -- types: a1: userdata
    return #friendsHere(a1)
end

function u25.IdList(a1) -- Line: 121 -- upvalues: friendsHere (val) -- types: a1: userdata
    local v1 = {}
    for i, j in friendsHere(a1) do
        table.insert(v1, j.UserId)
    end
    return v1
end

return table.freeze(u25)