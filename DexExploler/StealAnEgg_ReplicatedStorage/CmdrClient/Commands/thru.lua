-- Script path: ReplicatedStorage.CmdrClient.Commands.thru
-- Decompile time: 0.63 ms

return {
    Name = "thru",
    Description = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
    Group = "DefaultDebug",
    Aliases = {"t", "through"},
    Args = {
        {
            Type = "number",
            Name = "Extra distance",
            Description = "Go through the wall an additional X studs.",
            Default = 0,
        },
    },
    ClientRun = function(a1, a2) -- Line: 15
        local Mouse = a1.Executor:GetMouse()
        local Character = a1.Executor.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local Position = Character.HumanoidRootPart.Position
            local v1 = Mouse.Hit.p - Position
            Character:MoveTo(v1 * 2 + v1.unit * a2 + Position)
            return "Blinked!"
        end
        return "You don't have a character."
    end,
}