-- Script path: ReplicatedStorage.CmdrClient
-- Decompile time: 2.88 ms

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = script:WaitForChild("Shared")
local Util = require(v1:WaitForChild("Util"))
if RunService:IsClient() == false then
    error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local v2 = {
    Enabled = true,
    MashToEnable = false,
    ActivationUnlocksMouse = false,
    HideOnLostFocus = true,
    PlaceName = "Cmdr",
    ReplicatedRoot = script,
    RemoteFunction = script:WaitForChild("CmdrFunction"),
    RemoteEvent = script:WaitForChild("CmdrEvent"),
    ActivationKeys = {},
    Util = Util,
    Events = {},
}
local v3 = {
    __index = function(a1, a2) -- Line: 28
        local u3 = a1.Dispatcher[a2]
        if u3 and type(u3) == "function" then
            return function(a1_2, ...) -- Line: 31 -- upvalues: u3 (val), a1 (val)
                return u3(a1.Dispatcher, ...)
            end
        end
    end,
}
local u54 = setmetatable(v2, v3)
local Registry = require(v1.Registry)
u54.Registry = Registry(u54)
local Dispatcher = require(v1.Dispatcher)
u54.Dispatcher = Dispatcher(u54)
if StarterGui:WaitForChild("Cmdr")
    and wait()
    and (LocalPlayer:WaitForChild("PlayerGui")):FindFirstChild("Cmdr") == nil then
    local v4 = StarterGui.Cmdr:Clone()
    v4.Parent = LocalPlayer.PlayerGui
end
local u94 = require(script.CmdrInterface)(u54)

function u54.SetActivationKeys(a1, a2) -- Line: 49 -- upvalues: Util (val)
    a1.ActivationKeys = Util.MakeDictionary(a2)
end

function u54.SetPlaceName(a1, a2) -- Line: 54 -- upvalues: u94 (val)
    a1.PlaceName = a2
    u94.Window:UpdateLabel()
end

function u54:SetEnabled(a2) -- Line: 60
    self.Enabled = a2
end

function u54.SetActivationUnlocksMouse(a1, a2) -- Line: 65
    a1.ActivationUnlocksMouse = a2
end

function u54:Show() -- Line: 70 -- upvalues: u94 (val)
    if not self.Enabled then
        return
    end
    u94.Window:Show()
end

function u54.Hide(a1) -- Line: 79 -- upvalues: u94 (val)
    u94.Window:Hide()
end

function u54.Toggle(a1) -- Line: 84 -- upvalues: u94 (val)
    if not a1.Enabled then
        return a1:Hide()
    end
    u94.Window:SetVisible(not (u94.Window:IsVisible()))
end

function u54.SetMashToEnable(a1, a2) -- Line: 93
    a1.MashToEnable = a2
    if a2 then
        a1:SetEnabled(false)
    end
end

function u54.SetHideOnLostFocus(a1, a2) -- Line: 102
    a1.HideOnLostFocus = a2
end

function u54.HandleEvent(a1, a2, a3) -- Line: 107
    a1.Events[a2] = a3
end

if RunService:IsServer() == false then
    u54.Registry:RegisterTypesIn((script:WaitForChild("Types")))
    u54.Registry:RegisterCommandsIn((script:WaitForChild("Commands")))
end
u54.RemoteEvent.OnClientEvent:Connect(function(a1, ...) -- Line: 118 -- upvalues: u54 (ref)
    if u54.Events[a1] then
        u54.Events[a1](...)
    end
end)
require(script.DefaultEventHandlers)(u54)
return u54