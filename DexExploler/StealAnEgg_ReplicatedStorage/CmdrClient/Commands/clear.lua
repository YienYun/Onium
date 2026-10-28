-- Script path: ReplicatedStorage.CmdrClient.Commands.clear
-- Decompile time: 0.58 ms

local Players = game:GetService("Players")
return {
    Name = "clear",
    Description = "Clear all lines above the entry line of the Cmdr window.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {},
    ClientRun = function() -- Line: 9 -- upvalues: Players (val)
        local Cmdr = (Players.LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Cmdr")
        local v1 = Cmdr:WaitForChild("Frame")
        if Cmdr and v1 then
            for k, v in pairs(v1:GetChildren()) do
                if v.Name == "Line" and v:IsA("TextBox") then
                    v:Destroy()
                end
            end
        end
        return ""
    end,
}