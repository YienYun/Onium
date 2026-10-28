-- Script path: ReplicatedStorage.Packages._Index.sleitnick_input@2.3.0.input.Mouse
-- Decompile time: 3.32 ms

local Signal = require(script.Parent.Parent.Signal)
local Trove = require(script.Parent.Parent.Trove)
local UserInputService = game:GetService("UserInputService")
local u17 = {}
u17.__index = u17

function u17.new() -- Line: 81 -- upvalues: u17 (val), Trove (val), Signal (val), UserInputService (val)
    local u3 = setmetatable({}, u17)
    u3._trove = Trove.new()
    u3.LeftDown = u3._trove:Construct(Signal)
    u3.LeftUp = u3._trove:Construct(Signal)
    u3.RightDown = u3._trove:Construct(Signal)
    u3.RightUp = u3._trove:Construct(Signal)
    u3.MiddleDown = u3._trove:Construct(Signal)
    u3.MiddleUp = u3._trove:Construct(Signal)
    u3.Scrolled = u3._trove:Construct(Signal)
    u3.Moved = u3._trove:Construct(Signal)
    u3._trove:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 95 -- upvalues: u3 (val)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton1 then
            u3.LeftDown:Fire()
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton2 then
            u3.RightDown:Fire()
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton3 then
            u3.MiddleDown:Fire()
        end
    end)
    u3._trove:Connect(UserInputService.InputEnded, function(a1, a2) -- Line: 108 -- upvalues: u3 (val)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton1 then
            u3.LeftUp:Fire()
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton2 then
            u3.RightUp:Fire()
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton3 then
            u3.MiddleUp:Fire()
        end
    end)
    u3._trove:Connect(UserInputService.InputChanged, function(a1, a2) -- Line: 121 -- upvalues: u3 (val)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseMovement then
            local Position = a1.Position
            u3.Moved:Fire((Vector2.new(Position.X, Position.Y)))
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseWheel then
            u3.Scrolled:Fire(a1.Position.Z)
        end
    end)
    return u3
end

function u17.IsLeftDown(a1) -- Line: 139 -- upvalues: UserInputService (val)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end

function u17.IsRightDown(a1) -- Line: 146 -- upvalues: UserInputService (val)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

function u17.IsMiddleDown(a1) -- Line: 153 -- upvalues: UserInputService (val)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
end

function u17.GetPosition(a1) -- Line: 160 -- upvalues: UserInputService (val)
    return UserInputService:GetMouseLocation()
end

function u17.GetDelta(a1) -- Line: 174 -- upvalues: UserInputService (val)
    return UserInputService:GetMouseDelta()
end

function u17.GetRay(a1, a2) -- Line: 182 -- upvalues: UserInputService (val) -- types: a1: table, a2: userdata?
    local MouseLocation = a2 or UserInputService:GetMouseLocation()
    return (workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y))
end

function u17:Raycast(a2, a3, a4) -- Line: 209 -- types: self: table, a2: userdata, a3: number?, a4: userdata?
    local Ray = self:GetRay(a4)
    return (workspace:Raycast(Ray.Origin, Ray.Direction * (a3 or 1000), a2))
end

function u17.Project(a1, a2, a3) -- Line: 241 -- types: a1: table, a2: number?, a3: userdata?
    local Ray = a1:GetRay(a3)
    return Ray.Origin + Ray.Direction.Unit * (a2 or 1000)
end

function u17.Lock(a1) -- Line: 255 -- upvalues: UserInputService (val)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
end

function u17.LockCenter(a1) -- Line: 266 -- upvalues: UserInputService (val)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

function u17.Unlock(a1) -- Line: 273 -- upvalues: UserInputService (val)
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

function u17:Destroy() -- Line: 280
    self._trove:Destroy()
end

return u17