-- Script path: ReplicatedStorage.CmdrClient.Commands.bind
-- Decompile time: 1.94 ms

local UserInputService = game:GetService("UserInputService")
return {
    Name = "bind",
    Description = "Binds a command string to a key or mouse input.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "userInput ! bindableResource @ player",
            Name = "Input",
            Description = "The key or input type you'd like to bind the command to.",
        },
        {Type = "command", Name = "Command", Description = "The command you want to run on this input"},
        {
            Type = "string",
            Name = "Arguments",
            Description = "The arguments for the command",
            Default = "",
        },
    },
    ClientRun = function(a1, a2, a3, a4) -- Line: 27 -- upvalues: UserInputService (val)
        local Store = a1:GetStore("CMDR_Binds")
        local u11 = a3 .. " " .. a4
        if Store[a2] then
            Store[a2]:Disconnect()
        end
        local Name = a1:GetArgument(1).Type.Name
        if Name == "userInput" then
            Store[a2] = (UserInputService.InputBegan:Connect(function(a1_2, a2_2) -- Line: 39 -- upvalues: a2 (val), a1 (val), u11 (ref)
                if a2_2 then
                    return
                end
                if a1_2.UserInputType == a2 or a1_2.KeyCode == a2 then
                    a1:Reply((a1.Dispatcher:EvaluateAndRun((a1.Cmdr.Util.RunEmbeddedCommands(a1.Dispatcher, u11)))))
                end
            end))
            return "Bound command to input."
        end
        if Name == "bindableResource" then
            return "Unimplemented..."
        end
        if Name == "player" then
            Store[a2] = (a2.Chatted:Connect(function(a1_2) -- Line: 51 -- upvalues: a1 (val), u11 (ref), a2 (val)
                local v1 = a1.Cmdr.Util.RunEmbeddedCommands(a1.Dispatcher, a1.Cmdr.Util.SubstituteArgs(u11, {a1_2}))
                a1:Reply(("%s $ %s : %s"):format(a2.Name, v1, (a1.Dispatcher:EvaluateAndRun(v1))), (Color3.fromRGB(244, 92, 66)))
            end))
        end
        return "Bound command to input."
    end,
}