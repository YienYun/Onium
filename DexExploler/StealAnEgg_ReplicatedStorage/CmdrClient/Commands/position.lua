-- Script path: ReplicatedStorage.CmdrClient.Commands.position
-- Decompile time: 0.47 ms

return {
    Name = "position",
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Aliases = {"pos"},
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "The player to report the position of. Omit for your own position.",
            Default = (game:GetService("Players")).LocalPlayer,
        },
    },
    ClientRun = function(a1, a2) -- Line: 17
        local Character = a2.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            return tostring(Character.HumanoidRootPart.Position):gsub("%s", "")
        end
        return ""
    end,
}