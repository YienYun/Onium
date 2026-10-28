-- Script path: ReplicatedStorage.Client.PlatformController
-- Decompile time: 1.92 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u18 = {
    [Enum.PreferredInput.Gamepad] = "Console",
    [Enum.PreferredInput.KeyboardAndMouse] = "Desktop",
    [Enum.PreferredInput.Touch] = "Mobile",
}
local u25 = {}
u25.Changed = Signal.new()
local u30 = Log.new()

local function detect() -- Line: 33 -- upvalues: u18 (val), UserInputService (val)
    return u18[UserInputService.PreferredInput] or "Desktop"
end

local u34 = u18[UserInputService.PreferredInput] or "Desktop"

function u25.Platform() -- Line: 39 -- upvalues: u34 (ref)
    return u34
end

function u25.IsConsole() -- Line: 43 -- upvalues: u34 (ref)
    return u34 == "Console"
end

function u25.IsDesktop() -- Line: 47 -- upvalues: u34 (ref)
    return u34 == "Desktop"
end

function u25.IsMobile() -- Line: 51 -- upvalues: u34 (ref)
    return u34 == "Mobile"
end

function u25.Observe(a1) -- Line: 57 -- upvalues: u25 (val), u34 (ref) -- types: a1: function
    local u6 = u25.Changed:Connect(a1)
    a1(u34)
    return function() -- Line: 60 -- upvalues: u6 (val)
        u6:Disconnect()
    end
end

local function announce(a1) -- Line: 65 -- upvalues: u30 (val) -- types: a1: string
    (u30:AtInfo()):Log((("client now presents as %*"):format(a1)))
end

;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 69 -- upvalues: u18 (val), UserInputService (val), u34 (ref), u25 (val), u30 (val)
    local v1 = u18[UserInputService.PreferredInput] or "Desktop"
    if v1 == u34 then
        return
    end
    u34 = v1
    u25.Changed:Fire(v1)
    ;(u30:AtInfo()):Log((("client now presents as %*"):format(v1)))
end)
;(u30:AtInfo()):Log((("client now presents as %*"):format(u34)))
return (table.freeze(u25))