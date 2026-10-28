-- Script path: ReplicatedStorage.Packages.Networking
-- Decompile time: 8.99 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Signal = require(ReplicatedStorage.Packages.Signal)
local environment = require(ReplicatedStorage.Shared.environment)
local u26 = RunService:IsServer()
assert(RunService:IsRunning(), "Networking should not be required outside of a runtime context (got Studio edit mode).")
local u34 = nil
local u35 = nil

local function ErrorSignal(a1) -- Line: 68 -- upvalues: Signal (val) -- types: a1: string
    local v1 = Signal.new()

    function v1.Connect() -- Line: 70 -- upvalues: a1 (val)
        error(a1)
    end

    return v1
end

local function WarnOnInvoked(a1) -- Line: 76 -- types: a1: string
    return function() -- Line: 77 -- upvalues: a1 (val)
        warn(a1)
    end
end

local function ErrorOnInvoked(a1) -- Line: 82 -- types: a1: string
    return function() -- Line: 83 -- upvalues: a1 (val)
        error(a1)
    end
end

local function WaitFor(a1, a2) -- Line: 88 -- types: a1: string, a2: number
    local u2 = false
    task.delay(3, function() -- Line: 90 -- upvalues: u2 (ref), a1 (val)
        if not u2 then
            warn((("Waited longer than %* second for Networking.%* to exist."):format(3, a1)))
        end
    end)
    return (script:WaitForChild(a1, a2))
end

local function ExtendRemoteEvent(a1) -- Line: 101 -- upvalues: Players (val)
    return {
        OnServerEvent = a1.OnServerEvent,
        OnClientEvent = a1.OnClientEvent,
        FireClient = function(a1_2, a2, ...) -- Line: 107 -- upvalues: a1 (val) -- types: a2: userdata
            a1:FireClient(a2, ...)
        end,
        FireAllClients = function(a1_2, ...) -- Line: 111 -- upvalues: a1 (val)
            a1:FireAllClients(...)
        end,
        FireServer = function(a1_2, ...) -- Line: 115 -- upvalues: a1 (val)
            a1:FireServer(...)
        end,
        FireAllExcept = function(a1_2, a2, ...) -- Line: 119 -- upvalues: Players (upval), a1 (val) -- types: a2: userdata
            local v1 = false
            if typeof(a2) == "Instance" then
                v1 = a2:IsA("Player")
            end
            assert(v1, (("invalid player to ignore \"%*\""):format(a2)))
            for i, j in Players:GetPlayers() do
                if j ~= a2 then
                    a1:FireClient(j, ...)
                end
            end
        end,
    }
end

local function AssertNamespaceOpen(a1, a2) -- Line: 132
    -- upvalues: u34 (ref), u35 (ref)
    local v1 = false
    if type(u34) == "string" then
        v1 = type(u35) == "string"
    end
    assert(
        v1,
        (("Networking.%*(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(a1, a2))
    )
end

return (table.freeze({
    namespace = function(a1) -- Line: 224 -- upvalues: u34 (ref), u35 (ref) -- types: a1: table
        u34 = a1.name
        u35 = a1.env
    end,
    close = function() -- Line: 228 -- upvalues: u34 (ref), u35 (ref)
        u34 = nil
        u35 = nil
    end,
    remoteEvent = function(a1) -- Line: 140
        -- upvalues: u34 (ref), u35 (ref), u26 (val), environment (val), ExtendRemoteEvent (val), Signal (val)
        local v1 = false
        if type(u34) == "string" then
            v1 = type(u35) == "string"
        end
        assert(
            v1,
            (("Networking.remoteEvent(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(a1))
        )
        local u24 = ("RE/%*/%*"):format(u34, a1)
        if not u26 then
            local u76 = false
            task.delay(3, function() -- Line: 90 -- upvalues: u76 (ref), u24 (val)
                if not u76 then
                    warn((("Waited longer than %* second for Networking.%* to exist."):format(3, u24)))
                end
            end)
            v1 = script:WaitForChild(u24, 10)
            assert(v1, (("Server did not create RemoteEvent \"%*\""):format(u24)))
            return v1
        end
        local RemoteEvent = Instance.new("RemoteEvent")
        RemoteEvent.Name = u24
        RemoteEvent.Parent = script
        if u35 ~= "all" and environment.placeType ~= u35 then
            local v2 = {}
            local u39 = ("tried to FireClient with mock remote %*"):format(u24)

            function v2.FireClient() -- Line: 77 -- upvalues: u39 (val)
                warn(u39)
            end

            local u45 = ("tried to FireAllClients with mock remote %*"):format(u24)

            function v2.FireAllClients() -- Line: 77 -- upvalues: u45 (val)
                warn(u45)
            end

            local u51 = ("tried to FireAllExcept with mock remote %*"):format(u24)

            function v2.FireAllExcept() -- Line: 77 -- upvalues: u51 (val)
                warn(u51)
            end

            v2.OnServerEvent = Signal.new()
            local v3 = Signal.new()
            local u59 = "tried to use OnClientEvent on the server on a mock remote."

            function v3.Connect() -- Line: 70 -- upvalues: u59 (val)
                error(u59)
            end

            v2.OnClientEvent = v3
            local u65 = ("tried to FireServer %* on the server"):format(u24)

            function v2.FireServer() -- Line: 83 -- upvalues: u65 (val)
                error(u65)
            end

            RemoteEvent.OnServerEvent:Connect(function(a1) -- Line: 163 -- upvalues: u24 (val)
                error((("Remote invocation from %* for remote %* was filtered."):format(a1, u24)))
            end)
            return v2
        end
        return (ExtendRemoteEvent(RemoteEvent))
    end,
    unreliableRemoteEvent = function(a1) -- Line: 175
        -- upvalues: u34 (ref), u35 (ref), u26 (val), environment (val), ExtendRemoteEvent (val)
        local v1 = false
        if type(u34) == "string" then
            v1 = type(u35) == "string"
        end
        assert(
            v1,
            (("Networking.unreliableRemoteEvent(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(a1))
        )
        local u24 = ("URE/%*/%*"):format(u34, a1)
        if not u26 then
            local u44 = false
            task.delay(3, function() -- Line: 90 -- upvalues: u44 (ref), u24 (val)
                if not u44 then
                    warn((("Waited longer than %* second for Networking.%* to exist."):format(3, u24)))
                end
            end)
            v1 = script:WaitForChild(u24, 10)
            assert(v1, (("Server did not create UnreliableRemoteEvent \"%*\""):format(u24)))
            return v1
        end
        local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent")
        UnreliableRemoteEvent.Name = u24
        UnreliableRemoteEvent.Parent = script
        if u35 ~= "all" and environment.placeType ~= u35 then
            local UnreliableRemoteEvent_2 = Instance.new("UnreliableRemoteEvent")
            UnreliableRemoteEvent_2.Name = u24
            return (ExtendRemoteEvent(UnreliableRemoteEvent_2))
        end
        return (ExtendRemoteEvent(UnreliableRemoteEvent))
    end,
    remoteFunction = function(a1) -- Line: 199 -- upvalues: u34 (ref), u35 (ref), u26 (val), environment (val) -- types: a1: string
        local v1 = false
        if type(u34) == "string" then
            v1 = type(u35) == "string"
        end
        assert(
            v1,
            (("Networking.remoteFunction(\"%*\") called outside of an open namespace -- did you forget Networking.namespace({{...}}) above?"):format(a1))
        )
        local u24 = ("RF/%*/%*"):format(u34, a1)
        if not u26 then
            local u38 = false
            task.delay(3, function() -- Line: 90 -- upvalues: u38 (ref), u24 (val)
                if not u38 then
                    warn((("Waited longer than %* second for Networking.%* to exist."):format(3, u24)))
                end
            end)
            v1 = script:WaitForChild(u24, 10)
            assert(v1, (("Server did not create RemoteFunction \"%*\""):format(u24)))
            return v1
        end
        local RemoteFunction = Instance.new("RemoteFunction")
        RemoteFunction.Name = u24
        RemoteFunction.Parent = script
        if u35 ~= "all" and environment.placeType ~= u35 then
            local RemoteFunction_2 = Instance.new("RemoteFunction")
            RemoteFunction_2.Name = u24
            return RemoteFunction_2
        end
        return RemoteFunction
    end,
}))