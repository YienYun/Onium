-- Script path: ReplicatedStorage.Packages._Index.sleitnick_input@2.3.0.input.PreferredInput
-- Decompile time: 1.90 ms

local UserInputService = game:GetService("UserInputService")
local Touch = Enum.UserInputType.Touch
local Keyboard = Enum.UserInputType.Keyboard
local u7 = nil
local u8 = {}
u7 = {
    Current = "MouseKeyboard",
    Observe = function(a1) -- Line: 83 -- upvalues: u8 (val), u7 (ref) -- types: a1: function
        if table.find(u8, a1) then
            error("function already subscribed", 2)
        end
        table.insert(u8, a1)
        task.spawn(a1, u7.Current)
        return function() -- Line: 91 -- upvalues: u8 (upval), a1 (val)
            local v1 = table.find(u8, a1)
            if v1 then
                local v2 = #u8
                local v3 = u8
                u8[v1] = u8[v2]
                v3[v2] = nil
            end
        end
    end,
}

local function SetPreferred(a1) -- Line: 101 -- upvalues: u7 (ref), u8 (val) -- types: a1: string
    if a1 == u7.Current then
        return
    end
    u7.Current = a1
    for i, j in u8 do
        task.spawn(j, a1)
    end
end

local function DeterminePreferred(a1) -- Line: 112 -- upvalues: Touch (val), SetPreferred (val), Keyboard (val)
    if a1 == Touch then
        SetPreferred("Touch")
        return
    end
    if a1 ~= Keyboard and string.sub(a1.Name, 1, 5) ~= "Mouse" then
        if string.sub(a1.Name, 1, 7) == "Gamepad" then
            SetPreferred("Gamepad")
        end
        return
    end
    SetPreferred("MouseKeyboard")
end

local LastInputType = UserInputService:GetLastInputType()
if LastInputType == Touch then
    SetPreferred("Touch")
elseif LastInputType == Keyboard or string.sub(LastInputType.Name, 1, 5) == "Mouse" then
    SetPreferred("MouseKeyboard")
elseif string.sub(LastInputType.Name, 1, 7) == "Gamepad" then
    SetPreferred("Gamepad")
end
UserInputService.LastInputTypeChanged:Connect(DeterminePreferred)
return u7