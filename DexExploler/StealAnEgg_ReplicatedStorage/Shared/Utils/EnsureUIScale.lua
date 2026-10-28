-- Script path: ReplicatedStorage.Shared.Utils.EnsureUIScale
-- Decompile time: 0.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return function(a1) -- Line: 8 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("GuiObject"))(a1)
    local UIScale = a1:FindFirstChildWhichIsA("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Parent = a1
    return UIScale_2
end