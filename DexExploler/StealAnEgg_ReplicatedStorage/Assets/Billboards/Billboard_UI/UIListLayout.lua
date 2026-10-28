-- Script path: ReplicatedStorage.Assets.Billboards.Billboard_UI.UIListLayout
-- Decompile time: 1.07 ms

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local v1 = false
if UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
    v1 = true
end
if v1 then
    local Parent = script.Parent

    local function updateGamepad() -- Line: 16 -- upvalues: Parent (val), GamepadService (val)
        if #Parent:GetChildren() == 2 then
            GamepadService:DisableGamepadCursor()
            return
        end
        GamepadService:EnableGamepadCursor((Parent:FindFirstChildWhichIsA("Frame")))
    end

    Parent.ChildAdded:Connect(function() -- Line: 26 -- upvalues: Parent (val), GamepadService (val)
        if #Parent:GetChildren() == 2 then
            GamepadService:DisableGamepadCursor()
            return
        end
        GamepadService:EnableGamepadCursor((Parent:FindFirstChildWhichIsA("Frame")))
    end)
    Parent.ChildRemoved:Connect(function() -- Line: 28 -- upvalues: Parent (val), GamepadService (val)
        if #Parent:GetChildren() == 2 then
            GamepadService:DisableGamepadCursor()
            return
        end
        GamepadService:EnableGamepadCursor((Parent:FindFirstChildWhichIsA("Frame")))
    end)
end