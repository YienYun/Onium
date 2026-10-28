-- Script path: ReplicatedStorage.CmdrClient.Commands.resolve
-- Decompile time: 0.44 ms

return {
    Name = "resolve",
    Description = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {"alias \"me|Displays your username\" resolve players ."},
    Args = {
        {Type = "type", Name = "Type", Description = "The type for which to resolve"},
        function(a1) -- Line: 15
            if a1:GetArgument(1):Validate() == false then
                return
            end
            return {
                Name = "Argument Value Operator",
                Description = "The value operator to resolve. One of: * ** . ? ?N",
                Optional = true,
                Type = a1:GetArgument(1):GetValue(),
            }
        end,
    },
    Run = function(a1) -- Line: 29
        return table.concat(a1:GetArgument(2).RawSegments, ",")
    end,
}