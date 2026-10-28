-- Script path: ReplicatedStorage.Controllers.GUI.CheckResetOnSpawnController
-- Decompile time: 0.44 ms

local StarterGui = game:GetService("StarterGui")
local u5 = {"OverlayUI", "ScreenGui", "ShiftLockButton"}
return {
    Start = function() -- Line: 16 -- upvalues: StarterGui (val), u5 (val)
        task.wait(3)
        for i, j in StarterGui:GetChildren() do
            if not table.find(u5, j.Name) and j:IsA("ScreenGui") and j.ResetOnSpawn then
                error("ScreenGui '" .. j.Name .. "' has ResetOnSpawn enabled, which is not allowed.")
            end
        end
    end,
}