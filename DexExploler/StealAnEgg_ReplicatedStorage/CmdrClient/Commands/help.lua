-- Script path: ReplicatedStorage.CmdrClient.Commands.help
-- Decompile time: 1.99 ms

return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help",
    Args = {
        {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true,
        },
    },
    ClientRun = function(a1, a2) -- Line: 31
        local v1
        if not a2 then
            a1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n")
            a1:Reply("Tips\n----\n• Utilize the Tab key to automatically complete commands\n• Easily select and copy command output\n")
            local Commands = a1.Cmdr.Registry:GetCommands()
            table.sort(Commands, function(a1, a2) -- Line: 49
                if a1.Group and a2.Group then
                    return a1.Group < a2.Group
                end
                return a1.Group
            end)
            local Group_3 = nil
            v1 = a1
            for i, v in ipairs(Commands) do
                v.Group = v.Group or "No Group"
                if Group_3 ~= v.Group then
                    v1:Reply((("\n%*\n%*"):format(v.Group, (string.rep("-", #v.Group)))))
                    Group_3 = v.Group
                end
                v1:Reply(if not v.Description then v.Name else ("%* - %*"):format(v.Name, v.Description))
            end
        else
            local Description_2, Name_2, Type, v2
            local Command = a1.Cmdr.Registry:GetCommand(a2)
            a1:Reply(("Command: %*"):format(Command.Name), (Color3.fromRGB(230, 126, 34)))
            if Command.Aliases and #Command.Aliases > 0 then
                a1:Reply(("Aliases: %*"):format((table.concat(Command.Aliases, ", "))), (Color3.fromRGB(230, 230, 230)))
            end
            a1:Reply(Command.Description, (Color3.fromRGB(230, 230, 230)))
            for i2, i3 in ipairs(Command.Args) do
                Name_2 = i3.Name
                v2 = if i3.Optional ~= true then "" else "?"
                Type = i3.Type
                Description_2 = i3.Description
                v1:Reply((("#%* %*%*: %* - %*"):format(i2, Name_2, v2, Type, Description_2)))
            end
        end
        return ""
    end,
}