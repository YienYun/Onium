-- Script path: ReplicatedStorage.Client.Modules.ReplicatorClient
-- Decompile time: 12.94 ms

local deepCopy, disconnectAllSignals, fireInitialSignals
if _G.__ReplicatorClientReference then
    error("replicator has already been required on the client in another module.")
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u12 = utf8.char(0)
local u15 = utf8.char(1)
local u18 = utf8.char(2)
local u19 = {}
local u20 = {}
local u21 = {}
local u22 = {}
local u23 = {}
local ReplicatorSignal = require(script.ReplicatorSignal)
local Buff = require(script.Buff)
local u32 = {}
local u33 = {}
local u34 = {}

local function ensureDescendantPath(a1, a2) -- Line: 99 -- types: a2: table
    local v1, v2
    local v3 = a1
    local v4 = #a2
    for i = 1, v4 do
        v1 = a2[i]
        v2 = v3[v1]
        if not v2 then
            v3[v1] = {}
        end
        v3 = v2
    end
    return v3
end

function deepCopy(a1) -- Line: 113 -- upvalues: deepCopy (val)
    local v1 = table.clone(a1)
    for i, j in v1 do
        if type(j) == "table" then
            v1[i] = (deepCopy(j))
        end
    end
    return v1
end

local function makeDotCallsError(a1) -- Line: 123
    for i, j in a1 do
        if type(j) == "function" then
            a1[i] = function(...) -- Line: 126 -- upvalues: a1 (val), i (val), j (val)
                if (select(1, ...)) == a1 then
                    return j(...)
                end
                error((("called %* with .%*() instead of :%*()"):format(i, i, i)))
            end
        end
    end
end

function fireInitialSignals(a1, a2) -- Line: 137 -- upvalues: u21 (val), u22 (val), u23 (val), fireInitialSignals (val)
    local v1 = a1[u21]
    if v1 then
        v1.signal:Fire((a2:TryIndex(v1.path)))
    end
    v1 = a1[u22]
    if v1 then
        v1.signal:Fire(a2:TryIndex(v1.path), nil)
    end
    v1 = a1[u23]
    if v1 then
        local v2 = a2:TryIndex(v1.path)
        if v2 then
            for i, j in v2 do
                v1.signal:Fire(i, j)
            end
        end
    end
    for k, n in a1 do
        if type(k) == "string" then
            fireInitialSignals(n, a2)
        end
    end
end

function disconnectAllSignals(a1) -- Line: 162 -- upvalues: u21 (val), u22 (val), disconnectAllSignals (val)
    local v1 = a1[u21]
    if v1 then
        v1.signal:DisconnectAll()
    end
    v1 = a1[u22]
    if v1 then
        v1.signal:DisconnectAll()
    end
    for i, j in a1 do
        if type(i) == "string" then
            disconnectAllSignals(j)
        end
    end
end

local function handlePacket(a1) -- Line: 178
    -- upvalues: u12 (val), u32 (val), u34 (val), u33 (val), deepCopy (val), fireInitialSignals (val), u15 (val)
    -- upvalues: u23 (val), u19 (val), u21 (val), u22 (val), u18 (val), disconnectAllSignals (val)
    local apply, fireNilDescendants, v1, v2, v3, v4, v5
    local v6 = a1[1]
    local v7 = a1[2]
    if v6 == u12 then
        v4 = a1[3]
        v5 = a1[4]
        for k, n in u32 do
            if n == v4 and k ~= v7 then
                error((("client received 2 Replicators with the same Id \"%*\""):format(v4)))
            end
        end
        u32[v7] = v4
        u34.get(v4)
        local v8 = u33[v4]
        v8.Data = deepCopy(v5)
        fireInitialSignals(v8._signal_descendants, v8)
        v8._listen_raw_signal:Fire(v8.Data, v8.Data)
        return
    end
    if v6 ~= u15 then
        if v6 == u18 then
            v4 = u32[v7]
            v5 = u33[v4]
            if not v5 then
                return
            end
            if v5._destroyed == true then
                error("received 2 DESTROY_CMD for the same replicator")
            end
            v5.Destroying:Fire()
            disconnectAllSignals(v5._signal_descendants)
            table.clear(v5._signal_descendants)
            v5._destroyed = true
            u33[v4] = nil
        end
        return
    end
    v4 = u32[v7]
    if not v4 then
        return
    end
    v5 = u33[v4]
    if not v5 then
        return
    end
    local u51 = {}

    function fireNilDescendants(a1, a2) -- Line: 214
        -- upvalues: u23 (upval), u51 (val), u19 (upval), u21 (upval), u22 (upval), deepCopy (upval)
        -- upvalues: fireNilDescendants (val)
        local v1
        local v2 = a2[u23]
        if v2 and type(a1) == "table" then
            for i in a1 do
                table.insert(u51, {v2.signal, i, u19})
            end
        end
        local v3 = nil
        local v4 = nil
        for j, k in a2, v3, v4 do
            if type(j) == "string" then
                v2 = not (type(a1) ~= "table") and a1[j] or nil
                v1 = k[u21]
                if v1 then
                    table.insert(u51, {v1.signal, u19, nil})
                end
                v1 = k[u22]
                if v1 then
                    table.insert(u51, {
                        v1.signal,
                        u19,
                        if type(v2) ~= "table" then v2 else deepCopy(v2),
                    })
                end
                fireNilDescendants(v2, k)
            end
        end
    end

    local v9 = a1[3]

    function apply(a1, a2, a3) -- Line: 254
        -- upvalues: fireNilDescendants (val), u23 (upval), apply (val), u51 (val), u19 (upval), u21 (upval)
        -- upvalues: u22 (upval), deepCopy (upval)
        if type(a2) == "table" and a2.__none == "__none" then
            if a3 then
                fireNilDescendants(a1, a3)
            end
            return nil
        end
        if type(a1) == "table" and type(a2) == "table" then
            local signal, v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = a1[1] ~= nil
            local v10 = a3 and a3[u23]
            local v11 = next
            local v12 = nil
            local v13 = a1
            for k, v in v11, a2, v12 do
                if v9 and type(k) == "string" then
                    k = tonumber(k) or k
                end
                v2 = v8 and v8[tostring(k)]
                v4 = v13[k] or {}
                v3 = apply(v4, v, v2)
                if v10 and v13[k] == nil ~= (v3 == nil) then
                    v6 = {}
                    signal = v10.signal
                    v7 = if v3 ~= nil then v3 else u19
                    v6[1] = signal
                    v6[2] = k
                    v6[3] = v7
                    table.insert(u51, v6)
                end
                if v2 then
                    v4 = v2[u21]
                    if v4 then
                        table.insert(u51, {v4.signal, if v3 ~= nil then v3 else u19, v1})
                    end
                    v4 = v2[u22]
                    if v4 then
                        v5 = v13[k]
                        table.insert(u51, {
                            v4.signal,
                            if v3 ~= nil then v3 else u19,
                            if type(v5) ~= "table" then v5 else deepCopy(v5),
                        })
                    end
                end
                v13[k] = v3
            end
            return v13
        end
        return a2
    end

    local v10 = apply(v5.Data, v9, v5._signal_descendants)
    if v5.Data ~= v10 then
        v5.Data = v10
    end
    local v11 = nil
    local v12 = nil
    for i, j in u51, v11, v12 do
        v10 = j[1]
        v1, v2 = unpack(j, 2, 3)
        v3 = if v2 ~= u19 then v2 else nil
        v10:Fire(if v1 ~= u19 then v1 else nil, v3)
    end
    v5._listen_raw_signal:Fire(v5.Data, v9)
end

function u34.get(a1) -- Line: 370
    -- upvalues: u33 (val), ReplicatorSignal (val), u20 (val), ensureDescendantPath (val), u21 (val), u22 (val)
    -- upvalues: u23 (val), makeDotCallsError (val)
    local v1 = u33[a1]
    if v1 then
        return v1
    end
    local u3 = {Ready = false, _destroyed = false, Id = a1}
    u3.Destroying = ReplicatorSignal.new()
    u3._indices_signals = {}
    u3._listen_raw_signal = ReplicatorSignal.new()
    u3._signal_descendants = {}

    local function registerListener(a1, a2, a3) -- Line: 390
        -- upvalues: u20 (upval), ensureDescendantPath (upval), u3 (val), ReplicatorSignal (upval)
        if #a1 == 0 and a1 ~= u20 then
            warn("path:", a1)
            error("invalid path to register listener.")
        end
        local u17 = ensureDescendantPath(u3._signal_descendants, a1)
        local u24 = u17[a2]
        if not u24 then
            u24 = {connected = 0, signal = ReplicatorSignal.new(), path = a1}
            u17[a2] = u24
        end
        local u32 = u24.signal:Connect(a3)
        u24.connected = u24.connected + 1
        return function() -- Line: 415 -- upvalues: u32 (val), u24 (ref), u17 (val), a2 (val)
            u32:Disconnect()
            local v1 = u24
            v1.connected = v1.connected - 1
            if u24.connected == 0 then
                u17[a2] = nil
            end
        end
    end

    function u3.Listen(a1, a2, a3) -- Line: 452 -- upvalues: registerListener (val), u21 (upval)
        if type(a2[1]) ~= "table" then
            return (registerListener(a2, u21, a3))
        end
        local u6 = {}
        for i, j in a2 do
            table.insert(u6, (registerListener(j, u21, a3)))
        end
        return function() -- Line: 459 -- upvalues: u6 (val)
            for i, j in u6 do
                j()
            end
            table.clear(u6)
        end
    end

    function u3.ListenRaw(a1, a2) -- Line: 488 -- upvalues: u3 (val)
        return u3._listen_raw_signal:Connect(a2)
    end

    function u3.Observe(a1, a2, a3) -- Line: 510 -- upvalues: u3 (val), registerListener (val), u22 (upval)
        task.spawn(a3, u3:TryIndex(a2), nil)
        return (registerListener(a2, u22, a3))
    end

    function u3.ObserveKeys(a1, a2, a3) -- Line: 540 -- upvalues: u3 (val), registerListener (val), u23 (upval)
        local v1 = u3:TryIndex(a2)
        if v1 then
            for i, j in v1 do
                a3(i, j)
            end
        end
        return (registerListener(a2, u23, a3))
    end

    function u3.ListenKeys(a1, a2, a3) -- Line: 572 -- upvalues: registerListener (val), u23 (upval)
        return (registerListener(a2, u23, a3))
    end

    function u3.Index(a1, a2) -- Line: 591 -- upvalues: u3 (val)
        local Data = u3.Data
        if type(Data) ~= "table" then
            error("Replicator:Index() failed Data is not a table.")
        end
        local v1 = #a2
        for i, j in a2 do
            Data = Data[j]
            if i < v1 and type(Data) ~= "table" then
                error((("Replicator:Index() failed %* is not a table."):format((table.concat(a2, "/", 1, i)))))
            end
        end
        return Data
    end

    function u3.TryIndex(a1, a2) -- Line: 623 -- upvalues: u3 (val) -- types: a1: table, a2: table
        local Data = u3.Data
        if type(Data) ~= "table" then
            return nil
        end
        local v1 = #a2
        for i, j in a2 do
            Data = Data[j]
            if i < v1 and type(Data) ~= "table" then
                return nil
            end
        end
        return Data
    end

    function u3.Path(a1, a2) -- Line: 659
        local u7 = if type(a2) ~= "string" then a2 else {a2}
        return function(a1) -- Line: 662 -- upvalues: u7 (val)
            local v1 = table.clone(u7)
            if a1 == nil then
                return v1
            end
            if type(a1) == "string" then
                table.insert(v1, a1)
                return v1
            end
            table.move(a1, 1, #a1, #v1 + 1, v1)
            return v1
        end
    end

    function u3.WaitForLoaded(a1) -- Line: 690 -- upvalues: u3 (val)
        if not u3.Data then
            u3._listen_raw_signal:Wait()
        end
    end

    u33[a1] = u3
    makeDotCallsError(u3)
    return u3
end

local u42 = false

function u34.init() -- Line: 724 -- upvalues: u42 (ref), ReplicatedStorage (val), Buff (val), handlePacket (val)
    if u42 then
        return
    end
    u42 = true
    local u3 = coroutine.running()
    local u4 = false
    local RemoteEvent = (ReplicatedStorage:WaitForChild("__ReplicatorInternal", (1 / 0))):WaitForChild("RemoteEvent", (1 / 0))
    RemoteEvent.OnClientEvent:Connect(function(a1, a2) -- Line: 738 -- upvalues: Buff (upval), handlePacket (upval), u4 (ref), u3 (val)
        for i, j in (Buff.decode(a1, a2)) do
            debug.profilebegin((("replicator::handlepacket::%*"):format(i)))
            handlePacket(j)
            debug.profileend()
        end
        if u4 and coroutine.status(u3) == "suspended" then
            task.spawn(u3)
            u4 = false
        end
    end)
    RemoteEvent:FireServer()
    coroutine.yield()
end

_G.__ReplicatorClientReference = u34
return u34