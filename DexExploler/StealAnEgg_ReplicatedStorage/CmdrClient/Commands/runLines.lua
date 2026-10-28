-- Script path: ReplicatedStorage.CmdrClient.Commands.runLines
-- Decompile time: 1.33 ms

return {
    Name = "run-lines",
    Description = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {{Type = "string", Name = "Script", Description = "The script to parse.", Default = ""}},
    ClientRun = function(a1, a2) -- Line: 15
        local v1
        if #a2 == 0 then
            return ""
        end
        local v2 = a1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
        for i, v in ipairs(((a2:gsub("\n+", "\n")):split("\n"))) do
            if v:sub(1, 1) ~= "#" then
                v1 = a1.Dispatcher:EvaluateAndRun(v)
                if v2 then
                    a1:Reply(v1)
                end
            end
        end
        return ""
    end,
}