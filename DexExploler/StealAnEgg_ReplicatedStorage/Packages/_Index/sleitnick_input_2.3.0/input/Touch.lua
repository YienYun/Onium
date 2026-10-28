-- Script path: ReplicatedStorage.Packages._Index.sleitnick_input@2.3.0.input.Touch
-- Decompile time: 1.64 ms

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local u17 = {}
u17.__index = u17

function u17.new() -- Line: 87 -- upvalues: u17 (val), Trove (val), Signal (val), UserInputService (val)
    local v1 = setmetatable({}, u17)
    v1._trove = Trove.new()
    v1.TouchTap = v1._trove:Construct(Signal.Wrap, UserInputService.TouchTap)
    v1.TouchTapInWorld = v1._trove:Construct(Signal.Wrap, UserInputService.TouchTapInWorld)
    v1.TouchMoved = v1._trove:Construct(Signal.Wrap, UserInputService.TouchMoved)
    v1.TouchLongPress = v1._trove:Construct(Signal.Wrap, UserInputService.TouchLongPress)
    v1.TouchPan = v1._trove:Construct(Signal.Wrap, UserInputService.TouchPan)
    v1.TouchPinch = v1._trove:Construct(Signal.Wrap, UserInputService.TouchPinch)
    v1.TouchRotate = v1._trove:Construct(Signal.Wrap, UserInputService.TouchRotate)
    v1.TouchSwipe = v1._trove:Construct(Signal.Wrap, UserInputService.TouchSwipe)
    v1.TouchStarted = v1._trove:Construct(Signal.Wrap, UserInputService.TouchStarted)
    v1.TouchEnded = v1._trove:Construct(Signal.Wrap, UserInputService.TouchEnded)
    return v1
end

function u17.IsTouchEnabled(a1) -- Line: 109 -- upvalues: UserInputService (val)
    return UserInputService.TouchEnabled
end

function u17:Destroy() -- Line: 116
    self._trove:Destroy()
end

return u17