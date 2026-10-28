-- Script path: ReplicatedStorage.Packages._Index.sleitnick_input@2.3.0.input.Gamepad
-- Decompile time: 11.86 ms

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local HapticService = game:GetService("HapticService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function ApplyDeadzone(a1, a2) -- Line: 13 -- types: a1: number, a2: number
    if math.abs(a1) < a2 then
        return 0
    end
    return (math.abs(a1) - a2) / (1 - a2) * math.sign(a1)
end

local function GetActiveGamepad() -- Line: 20 -- upvalues: UserInputService (val)
    local v1 = nil
    local NavigationGamepads = UserInputService:GetNavigationGamepads()
    if not (#NavigationGamepads > 1) then
        for i, v in ipairs((UserInputService:GetConnectedGamepads())) do
            if v1 == nil or v.Value < v1.Value then
                v1 = v
            end
        end
    else
        for i2, i3 in ipairs(NavigationGamepads) do
            if v1 == nil or i3.Value < v1.Value then
                v1 = i3
            end
        end
    end
    if v1 and not UserInputService:GetGamepadConnected(v1) then
        v1 = nil
    end
    return v1
end

local function HeartbeatDelay(a1, a2) -- Line: 43 -- upvalues: RunService (val) -- types: a1: number, a2: function
    local u3 = time()
    local u4 = nil
    u4 = (RunService.Heartbeat:Connect(function() -- Line: 46 -- upvalues: u3 (val), a1 (val), u4 (ref), a2 (val)
        if a1 <= time() - u3 then
            u4:Disconnect()
            a2()
        end
    end))
    return u4
end

local u35 = {}
u35.__index = u35

function u35.new(a1) -- Line: 232 -- upvalues: u35 (val), Trove (val), Signal (val)
    local v1 = setmetatable({}, u35)
    v1._trove = Trove.new()
    v1._gamepadTrove = v1._trove:Construct(Trove)
    v1.ButtonDown = v1._trove:Construct(Signal)
    v1.ButtonUp = v1._trove:Construct(Signal)
    v1.Connected = v1._trove:Construct(Signal)
    v1.Disconnected = v1._trove:Construct(Signal)
    v1.GamepadChanged = v1._trove:Construct(Signal)
    v1.DefaultDeadzone = 0.05
    v1.SupportsVibration = false
    v1.State = {}
    v1:_setupGamepad(a1)
    v1:_setupMotors()
    return v1
end

function u35:_setupActiveGamepad(a2) -- Line: 249 -- upvalues: HapticService (val), UserInputService (val)
    local _gamepad = self._gamepad
    if a2 == _gamepad then
        return
    end
    self._gamepadTrove:Clean()
    table.clear(self.State)
    self.SupportsVibration = if not a2 then false else HapticService:IsVibrationSupported(a2)
    self._gamepad = a2
    if not a2 then
        self.Disconnected:Fire()
        self.GamepadChanged:Fire(nil)
        return
    end
    for i, v in ipairs(UserInputService:GetGamepadState(a2)) do
        self.State[v.KeyCode] = v
    end
    self._gamepadTrove:Add(self, "StopMotors")
    self._gamepadTrove:Connect(UserInputService.InputBegan, function(a1, a2_2) -- Line: 274 -- upvalues: a2 (val), self (val)
        if a1.UserInputType == a2 then
            self.ButtonDown:Fire(a1.KeyCode, a2_2)
        end
    end)
    self._gamepadTrove:Connect(UserInputService.InputEnded, function(a1, a2_2) -- Line: 280 -- upvalues: a2 (val), self (val)
        if a1.UserInputType == a2 then
            self.ButtonUp:Fire(a1.KeyCode, a2_2)
        end
    end)
    if _gamepad == nil then
        self.Connected:Fire()
    end
    self.GamepadChanged:Fire(a2)
end

function u35:_setupGamepad(a2) -- Line: 292 -- upvalues: UserInputService (val), GetActiveGamepad (val)
    if not a2 then
        local function CheckToSetupActive() -- Line: 314 -- upvalues: GetActiveGamepad (upval), self (val)
            local v1 = GetActiveGamepad()
            if v1 ~= self._gamepad then
                self:_setupActiveGamepad(v1)
            end
        end

        self._trove:Connect(UserInputService.GamepadConnected, CheckToSetupActive)
        self._trove:Connect(UserInputService.GamepadDisconnected, CheckToSetupActive)
        self:_setupActiveGamepad((GetActiveGamepad()))
        return
    end
    self._trove:Connect(UserInputService.GamepadConnected, function(a1) -- Line: 296 -- upvalues: a2 (val), self (val)
        if a1 == a2 then
            self:_setupActiveGamepad(a2)
        end
    end)
    self._trove:Connect(UserInputService.GamepadDisconnected, function(a1) -- Line: 302 -- upvalues: a2 (val), self (val)
        if a1 == a2 then
            self:_setupActiveGamepad(nil)
        end
    end)
    if not UserInputService:GetGamepadConnected(a2) then
        return
    end
    self:_setupActiveGamepad(a2)
end

function u35:_setupMotors() -- Line: 327
    self._setMotorIds = {}
    for i, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        self._setMotorIds[v] = 0
    end
end

function u35.GetThumbstick(a1, a2, a3) -- Line: 349 -- types: a1: table, a3: number?
    local Position = a1.State[a2].Position
    local DefaultDeadzone = a3 or a1.DefaultDeadzone
    local new = Vector2.new
    local X = Position.X
    local v1 = if not (math.abs(X) < DefaultDeadzone) then (math.abs(X) - DefaultDeadzone) / (1 - DefaultDeadzone) * math.sign(X) else 0
    local Y = Position.Y
    return new(v1, if not (math.abs(Y) < DefaultDeadzone) then (math.abs(Y) - DefaultDeadzone) / (1 - DefaultDeadzone) * math.sign(Y) else 0)
end

function u35.GetTrigger(a1, a2, a3) -- Line: 371 -- types: a1: table, a3: number?
    local Z = a1.State[a2].Position.Z
    local DefaultDeadzone = a3 or a1.DefaultDeadzone
    if math.abs(Z) < DefaultDeadzone then
        return 0
    end
    return (math.abs(Z) - DefaultDeadzone) / (1 - DefaultDeadzone) * math.sign(Z)
end

function u35.IsButtonDown(a1, a2) -- Line: 389 -- upvalues: UserInputService (val)
    return UserInputService:IsGamepadButtonDown(a1._gamepad, a2)
end

function u35:IsMotorSupported(a2) -- Line: 408 -- upvalues: HapticService (val)
    return HapticService:IsMotorSupported(self._gamepad, a2)
end

function u35:SetMotor(a2, a3) -- Line: 422 -- upvalues: HapticService (val) -- types: self: table, a3: number
    local _setMotorIds = self._setMotorIds
    _setMotorIds[a2] = _setMotorIds[a2] + 1
    local v1 = self._setMotorIds[a2]
    HapticService:SetMotor(self._gamepad, a2, a3)
    return v1
end

function u35.PulseMotor(a1, a2, a3, a4) -- Line: 454
    -- upvalues: RunService (val)
    local u8 = a1:SetMotor(a2, a3)

    local function u9() -- Line: 456 -- upvalues: a1 (val), a2 (val), u8 (val)
        if a1._setMotorIds[a2] ~= u8 then
            return
        end
        a1:StopMotor(a2)
    end

    local u11 = time()
    local u12 = nil
    u12 = (RunService.Heartbeat:Connect(function() -- Line: 46 -- upvalues: u11 (val), a4 (val), u12 (ref), u9 (val)
        if a4 <= time() - u11 then
            u12:Disconnect()
            u9()
        end
    end))
    a1._gamepadTrove:Add(u12)
end

function u35:StopMotor(a2) -- Line: 476
    self:SetMotor(a2, 0)
end

function u35.StopMotors(a1) -- Line: 490
    for i, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        if a1:IsMotorSupported(v) then
            a1:StopMotor(v)
        end
    end
end

function u35.IsConnected(a1) -- Line: 502 -- upvalues: UserInputService (val)
    if a1._gamepad then
        return (UserInputService:GetGamepadConnected(a1._gamepad))
    end
    return false
end

function u35.GetUserInputType(a1) -- Line: 511
    return a1._gamepad
end

function u35.SetAutoSelectGui(a1, a2) -- Line: 533 -- upvalues: GuiService (val) -- types: a1: table, a2: boolean
    GuiService.AutoSelectGuiEnabled = a2
end

function u35.IsAutoSelectGuiEnabled(a1) -- Line: 542 -- upvalues: GuiService (val)
    return GuiService.AutoSelectGuiEnabled
end

function u35:Destroy() -- Line: 549
    self._trove:Destroy()
end

return u35