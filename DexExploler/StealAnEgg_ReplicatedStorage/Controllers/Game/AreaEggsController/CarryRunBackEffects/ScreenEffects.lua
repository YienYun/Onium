-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.CarryRunBackEffects.ScreenEffects
-- Decompile time: 3.23 ms

local Players = game:GetService("Players")
game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(script.Types.Interface)
local u24 = Color3.fromRGB(191, 0, 3)
local u29 = TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local u35 = Players.LocalPlayer:WaitForChild("PlayerGui")
local u36 = {}
u36.__index = u36
u36.__class = "GuardRunBackEffects"

function u36.new() -- Line: 45 -- upvalues: u36 (val), u35 (val)
    local v1 = setmetatable({}, u36)
    local RunBackEffects = u35:WaitForChild("RunBackEffects")
    assert(RunBackEffects:IsA("ScreenGui"), "PlayerGui.RunBackEffects must be a ScreenGui")
    local Run = RunBackEffects:WaitForChild("Run")
    assert(Run:IsA("GuiObject"), "RunBackEffects.Run must be a GuiObject")
    local Blur = RunBackEffects:WaitForChild("Blur")
    assert(Blur:IsA("ImageLabel"), "RunBackEffects.Blur must be an ImageLabel")
    v1._activeSerial = 0
    v1._blurOriginalTransparency = Blur.ImageTransparency
    v1._blurTween = nil
    v1._running = false
    v1._runOriginalColor = Run.BackgroundColor3
    v1._runTween = nil
    v1._widgets = {Blur = Blur, Run = Run, ScreenGui = RunBackEffects}
    v1:_init()
    return v1
end

function u36:_cancelTweens() -- Line: 76
    local _blurTween = self._blurTween
    if _blurTween ~= nil then
        _blurTween:Cancel()
        _blurTween:Destroy()
    end
    self._blurTween = nil
    local _runTween = self._runTween
    if _runTween ~= nil then
        _runTween:Cancel()
        _runTween:Destroy()
    end
    self._runTween = nil
end

function u36:_resetVisualState() -- Line: 92
    local _widgets = self._widgets
    _widgets.Blur.Visible = true
    _widgets.Blur.ImageTransparency = self._blurOriginalTransparency
    _widgets.Run.BackgroundColor3 = self._runOriginalColor
    _widgets.ScreenGui.Enabled = false
end

function u36:_playCycle(a2, a3) -- Line: 100
    -- upvalues: u24 (val), TweenService (val), u29 (val)
    if a2 ~= self._activeSerial then
        return
    end
    local _widgets = self._widgets
    local _blurOriginalTransparency = if not a3 then self._blurOriginalTransparency else 1
    local _runOriginalColor = if not a3 then self._runOriginalColor else u24
    self:_cancelTweens()
    local u25 = TweenService:Create(_widgets.Blur, u29, {ImageTransparency = _blurOriginalTransparency})
    local u34 = TweenService:Create(_widgets.Run, u29, {BackgroundColor3 = _runOriginalColor})
    u25.Completed:Once(function() -- Line: 120 -- upvalues: u25 (val)
        u25:Destroy()
    end)
    u34.Completed:Once(function() -- Line: 123 -- upvalues: u34 (val)
        u34:Destroy()
    end)
    self._blurTween = u25
    self._runTween = u34
    u25:Play()
    u34:Play()
    task.spawn(function() -- Line: 131 -- upvalues: u25 (val), a2 (val), self (val), a3 (val)
        u25.Completed:Wait()
        if a2 ~= self._activeSerial then
            return
        end
        self:_playCycle(a2, not a3)
    end)
end

function u36.Start(a1, a2) -- Line: 146 -- types: a2: boolean?
    a1._activeSerial = a1._activeSerial + 1
    a1._running = true
    local _widgets = a1._widgets
    _widgets.ScreenGui.Enabled = true
    _widgets.Blur.Visible = a2 ~= true
    _widgets.Blur.ImageTransparency = a1._blurOriginalTransparency
    _widgets.Run.BackgroundColor3 = a1._runOriginalColor
    a1:_playCycle(a1._activeSerial, true)
end

function u36:Stop() -- Line: 157
    self._activeSerial = self._activeSerial + 1
    self._running = false
    self:_cancelTweens()
    self:_resetVisualState()
end

function u36:_init() -- Line: 169
    local ScreenGui = self._widgets.ScreenGui
    ;(ScreenGui:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 171 -- upvalues: ScreenGui (val), self (val)
        if ScreenGui.Enabled and not self._running then
            ScreenGui.Enabled = false
        end
    end)
    self:Stop()
end

return u36