-- Script path: ReplicatedStorage.Packages._Index.sleitnick_input@2.3.0.input.Keyboard
-- Decompile time: 2.38 ms

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local u17 = {}
u17.__index = u17

function u17.new() -- Line: 55 -- upvalues: u17 (val), Trove (val), Signal (val)
    local v1 = setmetatable({}, u17)
    v1._trove = Trove.new()
    v1.KeyDown = v1._trove:Construct(Signal)
    v1.KeyUp = v1._trove:Construct(Signal)
    v1:_setup()
    return v1
end

function u17.IsKeyDown(a1, a2) -- Line: 72 -- upvalues: UserInputService (val)
    return UserInputService:IsKeyDown(a2)
end

function u17.AreKeysDown(a1, a2, a3) -- Line: 84
    return a1:IsKeyDown(a2) and a1:IsKeyDown(a3)
end

function u17.AreEitherKeysDown(a1, a2, a3) -- Line: 99
    return a1:IsKeyDown(a2) or a1:IsKeyDown(a3)
end

function u17:_setup() -- Line: 103 -- upvalues: UserInputService (val)
    self._trove:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 104 -- upvalues: self (val)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.Keyboard then
            self.KeyDown:Fire(a1.KeyCode)
        end
    end)
    self._trove:Connect(UserInputService.InputEnded, function(a1, a2) -- Line: 113 -- upvalues: self (val)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.Keyboard then
            self.KeyUp:Fire(a1.KeyCode)
        end
    end)
end

function u17:Destroy() -- Line: 126
    self._trove:Destroy()
end

return u17