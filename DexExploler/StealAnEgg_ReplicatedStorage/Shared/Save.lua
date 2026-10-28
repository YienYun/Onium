-- Script path: ReplicatedStorage.Shared.Save
-- Decompile time: 9.40 ms

local fetch, seal
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local OnboardingTiming = require(ReplicatedStorage.Shared.Util.OnboardingTiming)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u34 = {}
u34.Loaded = Signal.new()
u34.Changed = Signal.new()
u34.PeerLoaded = Signal.new()
u34.PeerChanged = Signal.new()
local LocalPlayer = Players.LocalPlayer
local u44 = {}
local u45 = {}
local u46 = {}

local function presentPlayer(a1) -- Line: 58 -- upvalues: LocalPlayer (val) -- types: a1: userdata?
    local v1 = a1 or LocalPlayer
    if v1 ~= nil and v1.Parent ~= nil then
        return v1
    end
    return nil
end

local function signalFor(a1) -- Line: 63 -- upvalues: u46 (val), Signal (val) -- types: a1: string
    local v1 = u46[a1]
    if v1 == nil then
        u46[a1] = (Signal.new())
    end
    return v1
end

function seal(a1, a2) -- Line: 73 -- upvalues: seal (val) -- types: a2: table
    if type(a1) == "table" and not a2[a1] then
        a2[a1] = true
        for i, j in a1 do
            seal(i, a2)
            seal(j, a2)
        end
        if not table.isfrozen(a1) then
            table.freeze(a1)
        end
        return
    end
end

local function store(a1, a2, a3) -- Line: 87 -- upvalues: seal (val) -- types: a1: table, a2: string
    if a2 ~= "Inventory" then
        seal(a3, {})
    end
    a1[a2] = a3
end

local function isInventoryPatch(a1, a2) -- Line: 94 -- types: a1: string
    local v1 = false
    if a1 == "Inventory" then
        v1 = false
        if type(a2) == "table" then
            v1 = a2.__patch == true
        end
    end
    return v1
end

local function foldInventory(a1, a2) -- Line: 99 -- types: a1: table, a2: table
    local Inventory = a1.Inventory or {}
    if type(a2.Remove) == "table" then
        for i in a2.Remove do
            Inventory[i] = nil
        end
    end
    if type(a2.Set) == "table" then
        for j, k in a2.Set do
            Inventory[j] = k
        end
    end
    return Inventory
end

local function publish(a1, a2) -- Line: 114
    -- upvalues: LocalPlayer (val), u34 (val), u46 (val)
    local v1
    if a1 ~= LocalPlayer then
        for k, n in a2 do
            u34.PeerChanged:Fire(a1, n.field)
        end
        return
    end
    for i, j in a2 do
        u34.Changed:Fire(j.field, j.value, j.previous)
        v1 = u46[j.field]
        if v1 ~= nil then
            v1:Fire(j.value, j.previous)
        end
    end
end

local function applyDelta(a1, a2, a3) -- Line: 132
    -- upvalues: u44 (val), foldInventory (val), seal (val), publish (val)
    local v1, v2
    local v3 = u44[a1]
    if v3 == nil then
        return
    end
    local v4 = {}
    local v5 = {}
    if a3 ~= nil then
        for i in a3 do
            table.insert(v5, {field = i, previous = v3[i]})
            v3[i] = nil
        end
    end
    local v6 = nil
    local v7 = nil
    for j, k in a2, v6, v7 do
        v2 = false
        if j == "Inventory" then
            v2 = false
            if type(k) == "table" then
                v2 = k.__patch == true
            end
        end
        v1 = if not v2 then k else foldInventory(v3, k)
        table.insert(v4, {field = j, value = v1, previous = v3[j]})
        if j ~= "Inventory" then
            seal(v1, {})
        end
        v3[j] = v1
    end
    table.move(v5, 1, #v5, #v4 + 1, v4)
    publish(a1, v4)
end

local function requestProfile(a1) -- Line: 155
    -- upvalues: LocalPlayer (val), OnboardingTiming (val), Remotes (val)
    if a1 == LocalPlayer then
        OnboardingTiming.Mark("OwnerProfileRequestSent")
    end
    local success, err = pcall(function() -- Line: 157 -- upvalues: Remotes (upval), a1 (val)
        return Remotes.ProfileMirror.FetchProfile:InvokeServer(a1)
    end)
    if not success then
        warn((("profile fetch for %* raised: %*"):format(a1.Name, (tostring(err)))))
        return nil
    end
    if type(err) == "table" then
        return err
    end
    return nil
end

local function adopt(a1, a2) -- Line: 168
    -- upvalues: seal (val), u44 (val), LocalPlayer (val), OnboardingTiming (val), u34 (val)
    for i, j in a2 do
        if i ~= "Inventory" then
            seal(j, {})
        end
    end
    u44[a1] = a2
    if a1 ~= LocalPlayer then
        u34.PeerLoaded:Fire(a1)
        return
    end
    OnboardingTiming.Mark("OwnerProfileReceived")
    u34.Loaded:Fire(a1)
end

function fetch(a1, a2) -- Line: 186
    -- upvalues: u44 (val), u45 (val), fetch (val), Signal (val), requestProfile (val), adopt (val)
    local v1, v2
    local v3 = u44[a1]
    if v3 ~= nil then
        return v3
    end
    v3 = u45[a1]
    if v3 ~= nil then
        v1 = v3:Wait()
        if v1 == nil and a2 and a1.Parent ~= nil then
            return fetch(a1, a2)
        end
        return v1
    end
    v3 = Signal.new()
    u45[a1] = v3
    v1 = 0.6
    while a1.Parent ~= nil do
        if u44[a1] ~= nil then
            break
        end
        v2 = requestProfile(a1)
        if a1.Parent == nil then
            break
        end
        if v2 ~= nil then
            if u44[a1] ~= nil then
                break
            end
            adopt(a1, v2)
            break
        end
        if not a2 then
            break
        end
        task.wait(v1)
        v1 = math.min(v1 * 1.5, 3)
    end
    u45[a1] = nil
    v1 = u44[a1]
    v3:Fire(v1)
    v3:Destroy()
    return v1
end

function u34.Peek(a1) -- Line: 235 -- upvalues: LocalPlayer (val), u44 (val) -- types: a1: userdata?
    local v1 = a1 or LocalPlayer
    local v2 = if v1 == nil then nil else if v1.Parent == nil then nil else v1
    if v2 ~= nil then
        return u44[v2]
    end
    return nil
end

function u34.Await(a1) -- Line: 242 -- upvalues: LocalPlayer (val), fetch (val) -- types: a1: userdata?
    local v1
    local v2 = a1 or LocalPlayer
    if (if v2 == nil then nil else if v2.Parent == nil then nil else v2) == nil then
        return nil
    end
    return fetch(v1, v1 == LocalPlayer)
end

function u34.IsLoaded(a1) -- Line: 250 -- upvalues: u34 (val) -- types: a1: userdata?
    return u34.Peek(a1) ~= nil
end

function u34.Watch(a1) -- Line: 255 -- upvalues: u46 (val), Signal (val) -- types: a1: string
    local v1 = u46[a1]
    if v1 == nil then
        u46[a1] = (Signal.new())
    end
    return v1
end

function u34.WatchFields(a1, a2) -- Line: 259 -- upvalues: Trove (val), u46 (val), Signal (val) -- types: a2: function
    local v1, v2
    local v3 = Trove.new()
    if type(a1) == "string" then
        v2 = u46[a1]
        if v2 == nil then
            u46[a1] = (Signal.new())
        end
        v3:Connect(v2, a2)
        return v3
    end
    local v4 = nil
    v2 = nil
    for i, j in a1, v4, v2 do
        v1 = u46[j]
        if v1 == nil then
            v1 = Signal.new()
            u46[j] = v1
        end
        v3:Connect(v1, v5)
    end
    return v3
end

function u34.Amend(a1, a2) -- Line: 274
    -- upvalues: u34 (val), applyDelta (val), LocalPlayer (val)
    local v1
    local v2 = u34.Peek()
    if type(if v2 == nil then nil else v2[a1]) ~= "table" then
        return
    end
    a2(if not table.isfrozen(v1) then v1 else table.clone(v1))
    applyDelta(LocalPlayer, {[a1] = v2})
end

Remotes.ProfileMirror.ProfileDelta.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 289 -- upvalues: LocalPlayer (val), applyDelta (val)
    local v1 = if typeof(a3) ~= "Instance" then LocalPlayer else if not a3:IsA("Player") then LocalPlayer else a3
    if v1 ~= nil and type(a1) == "table" then
        applyDelta(v1, a1, if type(a2) ~= "table" then nil else a2)
        return
    end
end)
Players.PlayerRemoving:Connect(function(a1) -- Line: 298 -- upvalues: u44 (val) -- types: a1: userdata
    task.defer(function() -- Line: 299 -- upvalues: u44 (upval), a1 (val)
        u44[a1] = nil
    end)
end)
Players.PlayerAdded:Connect(function(a1) -- Line: 304 -- upvalues: fetch (val) -- types: a1: userdata
    task.spawn(fetch, a1, true)
end)
for i, j in Players:GetPlayers() do
    task.spawn(fetch, j, true)
end
return u34