-- Script path: ReplicatedStorage.CmdrClient.Commands.blink
-- Decompile time: 0.38 ms

return {
    Name = "blink",
    Description = "Teleports you to where your mouse is hovering.",
    Group = "DefaultDebug",
    Aliases = {"b"},
    Args = {},
    ClientRun = function(a1) -- Line: 8
        local Mouse = a1.Executor:GetMouse()
        local Character = a1.Executor.Character
        if not Character then
            return "You don't have a character."
        end
        Character:MoveTo(Mouse.Hit.p)
        return "Blinked!"
    end,
}