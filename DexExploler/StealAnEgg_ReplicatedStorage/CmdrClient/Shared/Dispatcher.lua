-- Script path: ReplicatedStorage.CmdrClient.Shared.Dispatcher
-- Decompile time: 3.98 ms

local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util = require(script.Parent.Util)
local Command = require(script.Parent.Command)
local u25 = false
local u26 = {}

function u26:Evaluate(a2, a3, a4, a5) -- Line: 21
    -- upvalues: RunService (val), Players (val), Util (val), Command (val)
    if RunService:IsClient() == true and a3 ~= Players.LocalPlayer then
        error("Can't evaluate a command that isn't sent by the local player.")
    end
    local v1 = Util.SplitString(a2)
    local v2 = table.remove(v1, 1)
    local Command_2 = self.Registry:GetCommand(v2)
    if not Command_2 then
        return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v2)))
    end
    v1 = Util.MashExcessArguments(v1, #Command_2.Args)
    local v3 = Command.new({
        Dispatcher = self,
        Text = a2,
        CommandObject = Command_2,
        Alias = v2,
        Executor = a3,
        Arguments = v1,
        Data = a5,
    })
    local v4, v5 = v3:Parse(a4)
    if v4 then
        return v3
    end
    return false, v5
end

function u26.EvaluateAndRun(a1, a2, a3, a4) -- Line: 58 -- upvalues: Players (val), RunService (val)
    local v1 = a3 or Players.LocalPlayer
    local v2 = a4 or {}
    if RunService:IsClient() and v2.IsHuman then
        a1:PushHistory(a2)
    end
    local u38, v3 = a1:Evaluate(a2, v1, nil, v2.Data)
    if not u38 then
        return v3
    end
    local success, result = xpcall(function() -- Line: 72 -- upvalues: u38 (val)
        local v1, v2 = u38:Validate(true)
        if not v1 then
            return v2
        end
        return u38:Run() or "Command executed."
    end, function(a1) -- Line: 80
        return debug.traceback((tostring(a1)))
    end)
    if not success then
        warn(("Error occurred while evaluating command string %q\n%s"):format(a2, (tostring(result))))
    end
    return success and result or "An error occurred while running this command. Check the console for more information."
end

function u26.Send(a1, a2, a3) -- Line: 92 -- upvalues: RunService (val)
    if RunService:IsClient() == false then
        error("Dispatcher:Send can only be called from the client.")
    end
    return a1.Cmdr.RemoteFunction:InvokeServer(a2, {Data = a3})
end

function u26:Run(...) -- Line: 104 -- upvalues: Players (val)
    local v1
    if not Players.LocalPlayer then
        error("Dispatcher:Run can only be called from the client.")
    end
    local v2 = {...}
    local v3 = v2[1]
    local v4 = #v2
    for i = 2, v4 do
        v3 = v3 .. " " .. tostring(v2[i])
    end
    v4, v1 = self:Evaluate(v3, Players.LocalPlayer)
    if not v4 then
        error(v1)
    end
    local v5, v6 = v4:Validate(true)
    if not v5 then
        error(v6)
    end
    return v4:Run()
end

function u26.RunHooks(a1, a2, a3, ...) -- Line: 132 -- upvalues: RunService (val), u25 (ref)
    local v1
    if not a1.Registry.Hooks[a2] then
        error(("Invalid hook name: %q"):format(a2), 2)
    end
    if a2 == "BeforeRun"
        and #a1.Registry.Hooks[a2] == 0
        and a3.Group ~= "DefaultUtil"
        and a3.Group ~= "UserAlias"
        and a3:HasImplementation() then
        if not RunService:IsStudio() then
            return "Command blocked for security as no BeforeRun hook is configured."
        elseif u25 == false then
            a3:Reply(
                (if not RunService:IsServer() then "<Client>" else "<Server>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html",
                (Color3.fromRGB(255, 228, 26))
            )
            u25 = true
        end
    end
    for i, v in ipairs(a1.Registry.Hooks[a2]) do
        v1 = v.callback(a3, ...)
        if v1 ~= nil then
            return (tostring(v1))
        end
    end
end

function u26:PushHistory(a2) -- Line: 164 -- upvalues: RunService (val), Util (val), TeleportService (val)
    assert(RunService:IsClient(), "PushHistory may only be used from the client.")
    local History = self:GetHistory()
    if Util.TrimString(a2) ~= "" and a2 ~= History[#History] then
        History[#History + 1] = a2
        TeleportService:SetTeleportSetting("CmdrCommandHistory", History)
        return
    end
end

function u26.GetHistory(a1) -- Line: 179 -- upvalues: RunService (val), TeleportService (val)
    assert(RunService:IsClient(), "GetHistory may only be used from the client.")
    return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
end

return function(a1) -- Line: 185 -- upvalues: u26 (val)
    u26.Cmdr = a1
    u26.Registry = a1.Registry
    return u26
end