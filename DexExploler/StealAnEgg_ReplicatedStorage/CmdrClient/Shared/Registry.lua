-- Script path: ReplicatedStorage.CmdrClient.Shared.Registry
-- Decompile time: 7.10 ms

local RunService = game:GetService("RunService")
local Util = require(script.Parent.Util)
local u10 = {}
u10.TypeMethods = Util.MakeDictionary({
    "Transform",
    "Validate",
    "Autocomplete",
    "Parse",
    "DisplayName",
    "Listable",
    "ValidateOnce",
    "Prefixes",
    "Default",
    "ArgumentOperatorAliases",
})
u10.CommandMethods = Util.MakeDictionary({"Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group"})
u10.CommandArgProps = Util.MakeDictionary({"Name", "Type", "Description", "Optional", "Default"})
u10.Types = {}
u10.TypeAliases = {}
u10.Commands = {}
u10.CommandsArray = {}
u10.Hooks = {BeforeRun = {}, AfterRun = {}}
local v1 = {
    __index = function(a1, a2) -- Line: 20
        a1[a2] = {}
        return a1[a2]
    end,
}
u10.Stores = setmetatable({}, v1)
u10.AutoExecBuffer = {}

function u10.RegisterType(a1, a2, a3) -- Line: 30
    if not a2 or typeof(a2) ~= "string" then
        error("Invalid type name provided: nil")
    end
    if not a2:find("^[%d%l]%w*$") then
        error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(a2))
    end
    for k in pairs(a3) do
        if a1.TypeMethods[k] == nil then
            error("Unknown key/method in type \"" .. a2 .. "\": " .. k)
        end
    end
    if a1.Types[a2] ~= nil then
        error(("Type \"%s\" has already been registered."):format(a2))
    end
    a3.Name = a2
    a3.DisplayName = a3.DisplayName or a2
    a1.Types[a2] = a3
    if a3.Prefixes then
        a1:RegisterTypePrefix(a2, a3.Prefixes)
    end
end

function u10:RegisterTypePrefix(a2, a3) -- Line: 59
    if not self.TypeAliases[a2] then
        self.TypeAliases[a2] = a2
    end
    self.TypeAliases[a2] = (("%s %s"):format(self.TypeAliases[a2], a3))
end

function u10.RegisterTypeAlias(a1, a2, a3) -- Line: 67
    assert(a1.TypeAliases[a2] == nil, (("Type alias %s already exists!"):format(a3)))
    a1.TypeAliases[a2] = a3
end

function u10:RegisterTypesIn(a2) -- Line: 73
    for k, v in pairs(a2:GetChildren()) do
        if not v:IsA("ModuleScript") then
            self:RegisterTypesIn(v)
        else
            v.Parent = self.Cmdr.ReplicatedRoot.Types
            xpcall(function() -- Line: 78 -- upvalues: v (val), self (val)
                require(v)(self)
            end, function(a1) -- Line: 80 -- upvalues: v (val)
                warn(("[CMDR] Type Init Error for %*:"):format(v.Name), a1)
            end)
        end
    end
end

u10.RegisterHooksIn = u10.RegisterTypesIn

function u10:RegisterCommandObject(a2, a3) -- Line: 94 -- upvalues: RunService (val)
    local v1, v2
    for k in pairs(a2) do
        if self.CommandMethods[k] == nil then
            error("Unknown key/method in command " .. (a2.Name or "unknown command") .. ": " .. k)
        end
    end
    if not a2.Args then
        v2, v1 = a2, self
    else
        v1, v2 = self, a2
        for k2, v in pairs(a2.Args) do
            if type(v) == "table" then
                for k3 in pairs(v) do
                    if v1.CommandArgProps[k3] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(v2.Name or "unknown", k2, k3))
                    end
                end
            end
        end
    end
    if v2.AutoExec and RunService:IsClient() then
        table.insert(v1.AutoExecBuffer, v2.AutoExec)
        v1:FlushAutoExecBufferDeferred()
    end
    local v3 = v1.Commands[v2.Name:lower()]
    if not v3 then
        if not v3 then
            table.insert(v1.CommandsArray, v2)
        end
    elseif v3.Aliases then
        for k4, i in pairs(v3.Aliases) do
            v1.Commands[(i:lower())] = nil
        end
    elseif not v3 then
        table.insert(v1.CommandsArray, v2)
    end
    v1.Commands[v2.Name:lower()] = v2
    if v2.Aliases then
        for k5, j in pairs(v2.Aliases) do
            v1.Commands[j:lower()] = v2
        end
    end
end

function u10:RegisterCommand(a2, a3, a4) -- Line: 139 -- upvalues: RunService (val)
    local v1 = require(a2)
    local v2 = ("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(a2.Name, (typeof(v1)))
    assert(typeof(v1) == "table", v2)
    if a3 then
        assert(RunService:IsServer(), "The commandServerScript parameter is not valid for client usage.")
        v1.Run = require(a3)
    end
    if a4 and not a4(v1) then
        return
    end
    self:RegisterCommandObject(v1)
    a2.Parent = self.Cmdr.ReplicatedRoot.Commands
end

function u10:RegisterCommandsIn(a2, a3) -- Line: 161
    local v1 = {}
    local v2 = {}
    for k, v in pairs(a2:GetChildren()) do
        if not v:IsA("ModuleScript") then
            self:RegisterCommandsIn(v, a3)
        elseif v.Name:find("Server") then
            v1[v] = true
        else
            local u55 = a2:FindFirstChild(v.Name .. "Server")
            if u55 then
                v2[u55] = true
            end
            xpcall(function() -- Line: 174 -- upvalues: self (val), v (val), u55 (val), a3 (val)
                self:RegisterCommand(v, u55, a3)
            end, function(a1) -- Line: 176 -- upvalues: v (val)
                warn(("[CMDR] Command Init Error for %*:"):format(v.Name), a1)
            end)
        end
    end
    for k2 in pairs(v1) do
        if not v2[k2] then
            warn("Command script " .. k2.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.")
        end
    end
end

function u10.RegisterDefaultCommands(a1, a2) -- Line: 195 -- upvalues: RunService (val), Util (val)
    local v1
    assert(RunService:IsServer(), "RegisterDefaultCommands cannot be called from the client.")
    local v2 = a2
    if type(v2) == "table" then
        a2 = Util.MakeDictionary(a2)
    end
    a1:RegisterCommandsIn(a1.Cmdr.DefaultCommandsFolder, v1 and function(a1) -- Line: 204 -- upvalues: a2 (ref)
        return a2[a1.Group] or false
    end or a2)
end

function u10.GetCommand(a1, a2) -- Line: 210
    return a1.Commands[(a2 or ""):lower()]
end

function u10.GetCommands(a1) -- Line: 216
    return a1.CommandsArray
end

function u10.GetCommandNames(a1) -- Line: 221
    local v1 = {}
    for k, v in pairs(a1.CommandsArray) do
        table.insert(v1, v.Name)
    end
    return v1
end

u10.GetCommandsAsStrings = u10.GetCommandNames

function u10.GetTypeNames(a1) -- Line: 234
    local v1 = {}
    for k in pairs(a1.Types) do
        table.insert(v1, k)
    end
    return v1
end

function u10.GetType(a1, a2) -- Line: 246
    return a1.Types[a2]
end

function u10.GetTypeName(a1, a2) -- Line: 251
    return a1.TypeAliases[a2] or a2
end

function u10.RegisterHook(a1, a2, a3, a4) -- Line: 256
    if not a1.Hooks[a2] then
        error(("Invalid hook name: %q"):format(a2), 2)
    end
    table.insert(a1.Hooks[a2], {callback = a3, priority = a4 or 0})
    table.sort(a1.Hooks[a2], function(a1, a2) -- Line: 262
        return a1.priority < a2.priority
    end)
end

u10.AddHook = u10.RegisterHook

function u10.GetStore(a1, a2) -- Line: 270
    return a1.Stores[a2]
end

function u10:FlushAutoExecBufferDeferred() -- Line: 275 -- upvalues: RunService (val)
    if self.AutoExecFlushConnection then
        return
    end
    self.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() -- Line: 280 -- upvalues: self (val)
        self.AutoExecFlushConnection:Disconnect()
        self.AutoExecFlushConnection = nil
        self:FlushAutoExecBuffer()
    end)
end

function u10:FlushAutoExecBuffer() -- Line: 288
    local v1 = self
    for i, v in ipairs(self.AutoExecBuffer) do
        for i2, i3 in ipairs(v) do
            v1.Cmdr.Dispatcher:EvaluateAndRun(i3)
        end
    end
    v1.AutoExecBuffer = {}
end

return function(a1) -- Line: 298 -- upvalues: u10 (val)
    u10.Cmdr = a1
    return u10
end