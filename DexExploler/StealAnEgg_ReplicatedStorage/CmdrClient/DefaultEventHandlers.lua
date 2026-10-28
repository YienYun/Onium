-- Script path: ReplicatedStorage.CmdrClient.DefaultEventHandlers
-- Decompile time: 0.52 ms

local StarterGui = game:GetService("StarterGui")
local Window = require(script.Parent.CmdrInterface.Window)
return function(a1) -- Line: 4 -- upvalues: StarterGui (val), Window (val)
    a1:HandleEvent("Message", function(a1) -- Line: 5 -- upvalues: StarterGui (upval)
        StarterGui:SetCore("ChatMakeSystemMessage", {Text = ("[Announcement] %s"):format(a1), Color = Color3.fromRGB(249, 217, 56)})
    end)
    a1:HandleEvent("AddLine", function(...) -- Line: 12 -- upvalues: Window (upval)
        Window:AddLine(...)
    end)
end