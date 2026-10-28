-- Script path: ReplicatedStorage.Packages._Index.sleitnick_ez_shake@unknown.CameraShaker
-- Decompile time: 6.90 ms

local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local t = require(((game:GetService("ReplicatedStorage")):WaitForChild("Packages")):WaitForChild("t"))
local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakePresets = require(script.CameraShakePresets)
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local u35 = 0
local new_2 = Vector3.new
local new = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local u41 = new_2()
local CameraShakeState = CameraShakeInstance.CameraShakeState
local Value = Enum.RenderPriority.Last.Value
local CurrentCamera = workspace.CurrentCamera
local u47 = {}
u47.__index = u47
u47.CameraShakeInstance = CameraShakeInstance
u47.Presets = CameraShakePresets

local function defaultCallback(a1) -- Line: 85 -- upvalues: CurrentCamera (val) -- types: a1: userdata
    local v1 = CurrentCamera
    v1.CFrame = v1.CFrame * a1
end

function u47.new(a1, a2, a3) -- Line: 121
    -- upvalues: t (val), u47 (val), Value (val), u41 (val), defaultCallback (val)
    t.strict(t.optional(t.number))(a1)
    t.strict(t.optional(t.callback))(a2)
    return (setmetatable({
        _running = false,
        _renderName = u47.NextRenderName(),
        _renderPriority = a1 or Value,
        _posAddShake = u41,
        _rotAddShake = u41,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = a2 or defaultCallback,
        _optimizeDrift = a3 or false,
        _renderBindings = {},
        _renderDriftConnections = {},
    }, u47))
end

function u47.NextRenderName() -- Line: 153 -- upvalues: u35 (ref)
    u35 = u35 + 1
    return ("__shake_%.4i__"):format(u35)
end

function u47.Start(a1, a2) -- Line: 158
    -- upvalues: t (val), RunService (val), CurrentCamera (val), profilebegin (val), profileend (val)
    if a1._running then
        return
    end
    t.strict(t.optional(t.string))(a2)
    a1._running = true
    local v1 = a2 or a1._renderName
    local _callback = a1._callback
    local u20 = nil
    RunService:BindToRenderStep(v1, a1._renderPriority, function(a1_2) -- Line: 170
        -- upvalues: u20 (ref), CurrentCamera (upval), profilebegin (upval), a1 (val), profileend (upval)
        -- upvalues: _callback (val)
        u20 = CurrentCamera.CFrame
        profilebegin("CameraShakerUpdate")
        local v1 = a1:Update(a1_2)
        profileend()
        _callback(v1)
    end)
    a1._renderBindings[v1] = true
    if not a1._optimizeDrift then
        return
    end
    a1._renderDriftConnections[v1] = (RunService.Heartbeat:Connect(function() -- Line: 186 -- upvalues: u20 (ref), CurrentCamera (upval)
        if not u20 then
            return
        end
        CurrentCamera.CFrame = u20
    end))
end

function u47:StopByRenderName(a2) -- Line: 194 -- upvalues: t (val), RunService (val) -- types: a2: string
    t.strict(t.string)(a2)
    assert(self._renderBindings[a2], (("Attempt to remove an unBinded render name: \"%*\""):format(a2)))
    local v1 = self._renderDriftConnections[a2]
    if v1 then
        v1:Disconnect()
        self._renderDriftConnections[a2] = nil
    end
    self._renderBindings[a2] = nil
    RunService:UnbindFromRenderStep(a2)
end

function u47.Stop(a1) -- Line: 208
    if not a1._running then
        return
    end
    a1._running = false
    for i in a1._renderBindings do
        a1:StopByRenderName(i)
    end
end

function u47.StopSustained(a1, a2) -- Line: 219 -- types: a2: number
    local fadeInDuration
    for k, v in pairs(a1._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            fadeInDuration = a2 or v.fadeInDuration
            v:StartFadeOut(fadeInDuration)
        end
    end
end

function u47:Update(a2) -- Line: 227
    -- upvalues: u41 (val), CameraShakeState (val), new (val), Angles (val), rad (val)
    local State, v1, v2
    local v3 = u41
    local v4 = u41
    local _camShakeInstances = self._camShakeInstances
    local v5 = #_camShakeInstances
    local v6 = a2
    for i = 1, v5 do
        v2 = _camShakeInstances[i]
        State = v2:GetState()
        if State ~= CameraShakeState.Inactive then
            if State ~= CameraShakeState.Inactive then
                v1 = v2:UpdateShake(v6)
                v3 = v3 + v1 * v2.PositionInfluence
                v4 = v4 + v1 * v2.RotationInfluence
            end
        elseif v2.DeleteOnInactive then
            self._removeInstances[#self._removeInstances + 1] = i
        elseif State ~= CameraShakeState.Inactive then
            v1 = v2:UpdateShake(v6)
            v3 = v3 + v1 * v2.PositionInfluence
            v4 = v4 + v1 * v2.RotationInfluence
        end
    end
    for j = #self._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, self._removeInstances[j])
        self._removeInstances[j] = nil
    end
    return (new(v3)) * Angles(0, rad(v4.Y), 0) * Angles(rad(v4.X), 0, (rad(v4.Z)))
end

function u47:Shake(a2) -- Line: 257
    local _camShakeInstance = false
    if type(a2) == "table" then
        _camShakeInstance = a2._camShakeInstance
    end
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    self._camShakeInstances[#self._camShakeInstances + 1] = a2
    return a2
end

function u47.ShakeFromPresetName(a1, a2) -- Line: 268 -- upvalues: t (val), CameraShakePresets (val)
    t.strict(t.string)(a2)
    return a1:Shake(CameraShakePresets[a2])
end

function u47.ShakeSustain(a1, a2) -- Line: 278
    local _camShakeInstance = false
    if type(a2) == "table" then
        _camShakeInstance = a2._camShakeInstance
    end
    assert(_camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    a1._camShakeInstances[#a1._camShakeInstances + 1] = a2
    a2:StartFadeIn(a2.fadeInDuration)
    return a2
end

function u47.ShakeOnce(a1, a2, a3, a4, a5, a6, a7) -- Line: 290
    -- upvalues: CameraShakeInstance (val)
    local v1 = CameraShakeInstance.new(a2, a3, a4, a5)
    v1.PositionInfluence = not (typeof(a6) ~= "Vector3") and a6 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.RotationInfluence = not (typeof(a7) ~= "Vector3") and a7 or Vector3.new(1, 1, 1)
    a1._camShakeInstances[#a1._camShakeInstances + 1] = v1
    return v1
end

function u47.StartShake(a1, a2, a3, a4, a5, a6) -- Line: 308
    -- upvalues: CameraShakeInstance (val)
    local v1 = CameraShakeInstance.new(a2, a3, a4)
    v1.PositionInfluence = not (typeof(a5) ~= "Vector3") and a5 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.RotationInfluence = not (typeof(a6) ~= "Vector3") and a6 or Vector3.new(1, 1, 1)
    v1:StartFadeIn(a4)
    a1._camShakeInstances[#a1._camShakeInstances + 1] = v1
    return v1
end

return u47