-- Script path: ReplicatedStorage.Client.StaffEntryHotkey
-- Decompile time: 0.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.Signal)
local RightBracket = Enum.KeyCode.RightBracket
local u15 = {}
u15.Changed = Signal.new()
local u18 = false

function u15.IsHidden() -- Line: 26 -- upvalues: u18 (ref)
    return u18
end

UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 15
    -- upvalues: UserInputService (val), RightBracket (val), u18 (ref), u15 (val)
    if not a2 and not UserInputService:GetFocusedTextBox() then
        if a1.KeyCode ~= RightBracket then
            return
        end
        u18 = not u18
        u15.Changed:Fire(u18)
        return
    end
end)
return u15