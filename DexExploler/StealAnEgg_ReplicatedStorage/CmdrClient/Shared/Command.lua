-- Script path: ReplicatedStorage.CmdrClient.Shared.Command
-- Decompile time: 5.14 ms

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local u17 = RunService:IsServer()
local u18 = {}
u18.__index = u18

function u18.new(a1) -- Line: 12 -- upvalues: u18 (val)
    local v1 = {
        Dispatcher = a1.Dispatcher,
        Cmdr = a1.Dispatcher.Cmdr,
        Name = a1.CommandObject.Name,
        RawText = a1.Text,
        Object = a1.CommandObject,
        Group = a1.CommandObject.Group,
        State = {},
        Aliases = a1.CommandObject.Aliases,
        Alias = a1.Alias,
        Description = a1.CommandObject.Description,
        Executor = a1.Executor,
        ArgumentDefinitions = a1.CommandObject.Args,
        RawArguments = a1.Arguments,
        Arguments = {},
        Data = a1.Data,
    }
    setmetatable(v1, u18)
    return v1
end

function u18.Parse(a1, a2) -- Line: 40 -- upvalues: Argument (val)
    local Name_2, v1, v2
    local v3 = false
    local v4 = a1
    for i, v in ipairs(a1.ArgumentDefinitions) do
        if type(v) == "function" then
            v = v(v4)
            if v == nil then
                break
            end
        end
        v2 = false
        if v.Default == nil then
            v2 = v.Optional ~= true
        end
        if not v2 then
            if not v2 then end
        elseif v3 then
            error(("Command %q: Required arguments cannot occur after optional arguments."):format(v4.Name))
        elseif not v2 then
        end
        if v4.RawArguments[i] == nil and v2 and v1 ~= true then
            Name_2 = v.Name
            return false, ("Required argument #%d %s is missing."):format(i, Name_2)
        end
        if v4.RawArguments[i] or v1 then
            v4.Arguments[i] = (Argument.new(v4, v, v4.RawArguments[i] or ""))
        end
    end
    return true
end

function u18:Validate(a2) -- Line: 72
    local Name, v1, v2
    self._Validated = true
    local v3 = ""
    local v4 = true
    for k, v in pairs(self.Arguments) do
        v2, v1 = v:Validate(a2)
        if not v2 then
            v4 = false
            Name = v.Name
            v3 = ("%s; #%d %s: %s"):format(v3, k, Name, v1 or "error")
        end
    end
    return v4, v3:sub(3)
end

function u18.GetLastArgument(a1) -- Line: 91
    for i = #a1.Arguments, 1, -1 do
        if a1.Arguments[i].RawValue then
            return a1.Arguments[i]
        end
    end
end

function u18:GatherArgumentValues() -- Line: 100
    local v1
    local v2 = {}
    local v3 = #self.ArgumentDefinitions
    for i = 1, v3 do
        v1 = self.Arguments[i]
        if v1 then
            v2[i] = (v1:GetValue())
        elseif type(self.ArgumentDefinitions[i]) == "table" then
            v2[i] = self.ArgumentDefinitions[i].Default
        end
    end
    return v2, #self.ArgumentDefinitions
end

function u18.Run(a1) -- Line: 117 -- upvalues: u17 (val)
    local v1, v2
    if a1._Validated == nil then
        error("Must validate a command before running.")
    end
    local v3 = a1.Dispatcher:RunHooks("BeforeRun", a1)
    if v3 then
        return v3
    end
    if not u17 and a1.Object.Data and a1.Data == nil then
        v1, v2 = a1:GatherArgumentValues()
        a1.Data = a1.Object.Data(a1, unpack(v1, 1, v2))
    end
    if not u17 and a1.Object.ClientRun then
        v1, v2 = a1:GatherArgumentValues()
        a1.Response = a1.Object.ClientRun(a1, unpack(v1, 1, v2))
    end
    if a1.Response == nil then
        if a1.Object.Run then
            v1, v2 = a1:GatherArgumentValues()
            a1.Response = a1.Object.Run(a1, unpack(v1, 1, v2))
        elseif not u17 then
            a1.Response = a1.Dispatcher:Send(a1.RawText, a1.Data)
        else
            if not a1.Object.ClientRun then
                warn(a1.Name, "command has no implementation!")
            else
                warn(
                    a1.Name,
                    "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command."
                )
            end
            a1.Response = "No implementation."
        end
    end
    v3 = a1.Dispatcher:RunHooks("AfterRun", a1)
    if v3 then
        return v3
    end
    return a1.Response
end

function u18.GetArgument(a1, a2) -- Line: 164
    return a1.Arguments[a2]
end

function u18.GetData(a1) -- Line: 172 -- upvalues: u17 (val)
    if a1.Data then
        return a1.Data
    end
    if a1.Object.Data and not u17 then
        a1.Data = a1.Object.Data(a1)
    end
    return a1.Data
end

function u18:SendEvent(a2, a3, ...) -- Line: 185 -- upvalues: u17 (val), Players (val)
    assert(typeof(a2) == "Instance", "Argument #1 must be a Player")
    assert(a2:IsA("Player"), "Argument #1 must be a Player")
    assert(type(a3) == "string", "Argument #2 must be a string")
    if u17 then
        self.Dispatcher.Cmdr.RemoteEvent:FireClient(a2, a3, ...)
        return
    end
    if self.Dispatcher.Cmdr.Events[a3] then
        assert(a2 == Players.LocalPlayer, "Event messages can only be sent to the local player on the client.")
        self.Dispatcher.Cmdr.Events[a3](...)
    end
end

function u18.BroadcastEvent(a1, ...) -- Line: 199 -- upvalues: u17 (val)
    if not u17 then
        error("Can't broadcast event messages from the client.", 2)
    end
    a1.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end

function u18.Reply(a1, ...) -- Line: 208
    return a1:SendEvent(a1.Executor, "AddLine", ...)
end

function u18:GetStore(...) -- Line: 213
    return self.Dispatcher.Cmdr.Registry:GetStore(...)
end

function u18.HasImplementation(a1) -- Line: 218 -- upvalues: RunService (val)
    if RunService:IsClient() and a1.Object.ClientRun then
        return true
    end
    if a1.Object.Run then
        return true
    end
    return false
end

return u18