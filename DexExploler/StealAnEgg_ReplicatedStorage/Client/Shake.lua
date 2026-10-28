-- Script path: ReplicatedStorage.Client.Shake
-- Decompile time: 13.08 ms

local GuiService = game:GetService("GuiService")
local HapticService = game:GetService("HapticService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PlatformController = require(ReplicatedStorage:WaitForChild("Client").PlatformController)
local Player = require(ReplicatedStorage.Shared.Player)
local u38 = Enum.RenderPriority.Camera.Value + 1
local u39 = {3.7, 41.2, 88.9}
local Gamepad1 = Enum.UserInputType.Gamepad1
local u44 = {[Enum.VibrationMotor.Large] = 1, [Enum.VibrationMotor.Small] = 0.5}
local u49 = {
    Fade = {
        1,
        0.9952,
        0.9808,
        0.9569,
        0.9239,
        0.8819,
        0.8315,
        0.773,
        0.7071,
        0.6344,
        0.5556,
        0.4714,
        0.3827,
        0.2903,
        0.1951,
        0.098,
        0,
    },
    Pulse = {
        0,
        0.1951,
        0.3827,
        0.5556,
        0.7071,
        0.8315,
        0.9239,
        0.9808,
        1,
        0.9808,
        0.9239,
        0.8315,
        0.7071,
        0.5556,
        0.3827,
        0.1951,
        0,
    },
}
local u87 = Random.new()
local u88 = nil
local v1 = {}

local function canShake() -- Line: 71 -- upvalues: Workspace (val), GuiService (val)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = false
    if CurrentCamera ~= nil then
        v1 = false
        if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            v1 = not GuiService.ReducedMotionEnabled
        end
    end
    return v1
end

local function smoothstep(a1, a2, a3) -- Line: 78 -- types: a1: number, a2: number, a3: number
    local v1 = math.clamp((a3 - a1) / (a2 - a1), 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function anchorPosition(a1) -- Line: 85 -- upvalues: Player (val)
    if typeof(a1) == "Vector3" then
        return a1
    end
    if a1:IsA("Player") then
        local v1 = Player.FindRootPart(a1)
        if v1 ~= nil then
            return v1.Position
        end
        return nil
    end
    if a1:IsA("PVInstance") then
        return a1:GetPivot().Position
    end
    if a1:IsA("Attachment") then
        return a1.WorldPosition
    end
    return nil
end

local function rangeGain(a1) -- Line: 104 -- upvalues: Player (val), anchorPosition (val) -- types: a1: table
    local v1 = Player.FindRootPart()
    local v2 = anchorPosition(a1.Center)
    if v1 ~= nil and v2 ~= nil then
        local Magnitude = (v2 - v1.Position).Magnitude
        if a1.Far < Magnitude then
            return nil
        end
        if a1.Far <= a1.Near then
            return 1
        end
        local Near = a1.Near
        local Far = a1.Far
        v1 = math.clamp((Magnitude - Near) / (Far - Near), 0, 1)
        v2 = 1 - v1 * v1 * (3 - v1 * 2)
        if v2 > 0 then
            return v2
        end
        return nil
    end
    return 1
end

local function envelopeAt(a1, a2) -- Line: 121 -- upvalues: u49 (val) -- types: a1: number, a2: string
    local v1 = u49[a2]
    local v2 = (math.clamp(a1, 0, 1)) * (#v1 - 1)
    local v3 = math.floor(v2) + 1
    return (math.lerp(v1[v3], v1[(math.min(v3 + 1, #v1))], v2 - (v3 - 1)))
end

local function sampleOffset(a1, a2) -- Line: 129 -- upvalues: u39 (val) -- types: a1: table, a2: number
    local v1 = a1.elapsed * 21 + a1.seed
    local v2 = table.create(#u39)
    for i, j in u39 do
        v2[i] = math.noise(v1, j, a1.seed) * 2.2 * a2
    end
    return (Vector3.new(v2[1], v2[2], v2[3]))
end

local function rumblePad(a1) -- Line: 139
    -- upvalues: PlatformController (val), HapticService (val), Gamepad1 (val)
    if not a1.rumble then
        return nil
    end
    if not PlatformController.IsConsole() and not PlatformController.IsMobile() then
        return nil
    end
    if HapticService:IsVibrationSupported(Gamepad1) then
        return Gamepad1
    end
    return nil
end

local function driveMotors(a1, a2) -- Line: 149 -- upvalues: u44 (val), HapticService (val) -- types: a2: number
    local v1, v2
    for i, j in u44 do
        v2 = HapticService
        v1 = a2 * j
        v2:SetMotor(a1, i, v1)
    end
end

local function rumble(a1, a2) -- Line: 155
    -- upvalues: PlatformController (val), HapticService (val), Gamepad1 (val), u44 (val)
    local v1 = if not a1.rumble then nil else if PlatformController.IsConsole() or PlatformController.IsMobile() then if not HapticService:IsVibrationSupported(Gamepad1) then nil else Gamepad1 else nil
    if v1 ~= nil then
        local v2, v3
        local v4 = math.sqrt((math.clamp(a1.reach, 0, 1))) * a2
        for i, j in u44 do
            v3 = HapticService
            v2 = v4 * j
            v3:SetMotor(v1, i, v2)
        end
    end
end

local function untouchedSinceLastWrite(a1, a2) -- Line: 164 -- types: a1: table, a2: userdata
    local lastWritten = a1.lastWritten
    local v1 = false
    if lastWritten ~= nil then
        v1 = a2.CFrame:FuzzyEq(lastWritten, 0.0001)
    end
    return v1
end

local function writeOffset(a1, a2, a3) -- Line: 169 -- types: a1: table, a2: userdata, a3: vector
    local CFrame_2 = a2.CFrame
    local lastWritten = a1.lastWritten
    local v1 = false
    if lastWritten ~= nil then
        v1 = a2.CFrame:FuzzyEq(lastWritten, 0.0001)
    end
    if v1 then
        CFrame_2 = CFrame_2 * CFrame.new(-a1.appliedOffset)
    end
    v1 = CFrame_2 * CFrame.new(a3)
    a2.CFrame = v1
    a1.lastWritten = v1
    a1.appliedOffset = a3
end

local function stopLive() -- Line: 180
    -- upvalues: u88 (ref), RunService (val), Workspace (val), PlatformController (val), HapticService (val)
    -- upvalues: Gamepad1 (val), u44 (val)
    local v1 = u88
    if v1 == nil then
        return
    end
    u88 = nil
    RunService:UnbindFromRenderStep("CameraShake.Offset")
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        local lastWritten = v1.lastWritten
        local v2 = false
        if lastWritten ~= nil then
            v2 = CurrentCamera.CFrame:FuzzyEq(lastWritten, 0.0001)
        end
        if v2 then
            CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(-v1.appliedOffset)
        end
    end
    local v3 = if not v1.rumble then nil else if PlatformController.IsConsole() or PlatformController.IsMobile() then if not HapticService:IsVibrationSupported(Gamepad1) then nil else Gamepad1 else nil
    if v3 ~= nil then
        local v4, v5
        for i, j in u44 do
            v5 = HapticService
            v4 = j * 0
            v5:SetMotor(v3, i, v4)
        end
    end
end

local function stepLive(a1) -- Line: 198
    -- upvalues: u88 (ref), Workspace (val), stopLive (val), u49 (val), sampleOffset (val), PlatformController (val)
    -- upvalues: HapticService (val), Gamepad1 (val), u44 (val)
    local v1 = u88
    local CurrentCamera = Workspace.CurrentCamera
    if v1 ~= nil and CurrentCamera ~= nil then
        local v2, v3, v4
        v1.elapsed = v1.elapsed + a1
        if v1.span <= v1.elapsed then
            stopLive()
            return
        end
        local v5 = v1.elapsed / v1.span
        local v6 = u49[v1.shape]
        local v7 = (math.clamp(v5, 0, 1)) * (#v6 - 1)
        local v8 = math.floor(v7) + 1
        local v9 = math.min(v8 + 1, #v6)
        local v10 = math.lerp(v6[v8], v6[v9], v7 - (v8 - 1))
        v1.sinceSample = v1.sinceSample + a1
        local offset = v1.offset
        if offset == nil then
            v1.sinceSample = 0
            v1.offset = (sampleOffset(v1, v10 * v1.reach))
            v4 = if not v1.rumble then nil else if PlatformController.IsConsole() or PlatformController.IsMobile() then if not HapticService:IsVibrationSupported(Gamepad1) then nil else Gamepad1 else nil
            if v4 ~= nil then
                v6 = math.sqrt((math.clamp(v1.reach, 0, 1))) * v10
                for i, j in u44 do
                    v2 = HapticService
                    v3 = v6 * j
                    v2:SetMotor(v4, i, v3)
                end
            end
        elseif v1.hold <= 0 then
            v1.sinceSample = 0
            v1.offset = (sampleOffset(v1, v10 * v1.reach))
            v4 = if not v1.rumble then nil else if PlatformController.IsConsole() or PlatformController.IsMobile() then if not HapticService:IsVibrationSupported(Gamepad1) then nil else Gamepad1 else nil
            if v4 ~= nil then
                v6 = math.sqrt((math.clamp(v1.reach, 0, 1))) * v10
                for k, n in u44 do
                    v2 = HapticService
                    v3 = v6 * n
                    v2:SetMotor(v4, k, v3)
                end
            end
        elseif v1.hold <= v1.sinceSample then
            v1.sinceSample = 0
            v1.offset = (sampleOffset(v1, v10 * v1.reach))
            v4 = if not v1.rumble then nil else if PlatformController.IsConsole() or PlatformController.IsMobile() then if not HapticService:IsVibrationSupported(Gamepad1) then nil else Gamepad1 else nil
            if v4 ~= nil then
                v6 = math.sqrt((math.clamp(v1.reach, 0, 1))) * v10
                for m, i5 in u44 do
                    v2 = HapticService
                    v3 = v6 * i5
                    v2:SetMotor(v4, m, v3)
                end
            end
        end
        local CFrame_2 = CurrentCamera.CFrame
        local lastWritten = v1.lastWritten
        v6 = false
        if lastWritten ~= nil then
            v6 = CurrentCamera.CFrame:FuzzyEq(lastWritten, 0.0001)
        end
        if v6 then
            CFrame_2 = CFrame_2 * CFrame.new(-v1.appliedOffset)
        end
        v6 = CFrame_2 * CFrame.new(offset)
        CurrentCamera.CFrame = v6
        v1.lastWritten = v6
        v1.appliedOffset = offset
        return
    end
    stopLive()
end

local function begin(a1) -- Line: 224
    -- upvalues: u88 (ref), RunService (val), u38 (val), stepLive (val)
    u88 = a1
    RunService:BindToRenderStep("CameraShake.Offset", u38, stepLive)
end

local function holdFor(a1) -- Line: 230 -- types: a1: number?
    if a1 ~= nil and not (a1 <= 0) then
        return 1 / a1
    end
    return 0
end

function v1.Play(a1) -- Line: 239
    -- upvalues: Workspace (val), GuiService (val), stopLive (val), rangeGain (val), u87 (val), u88 (ref)
    -- upvalues: RunService (val), u38 (val), stepLive (val)
    local v1
    local CurrentCamera = Workspace.CurrentCamera
    local v2 = false
    if CurrentCamera ~= nil then
        v2 = false
        if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            v2 = not GuiService.ReducedMotionEnabled
        end
    end
    if not v2 then
        return
    end
    stopLive()
    v2 = a1 or {}
    if (if not v2.Range then 1 else rangeGain(v2.Range)) == nil then
        return
    end
    local v3 = {elapsed = 0, sinceSample = 0, appliedOffset = Vector3.new(0, 0, 0)}
    v3.span = v2.Seconds or 1
    v3.reach = (v2.Magnitude or 1) * v1
    local SamplesPerSecond = v2.SamplesPerSecond
    v3.hold = if SamplesPerSecond == nil then 0 else if not (SamplesPerSecond <= 0) then 1 / SamplesPerSecond else 0
    v3.shape = if v2.Shape ~= "Pulse" then "Fade" else "Pulse"
    v3.rumble = v2.Rumble ~= false
    v3.seed = u87:NextNumber(0, 1000)
    u88 = v3
    RunService:BindToRenderStep("CameraShake.Offset", u38, stepLive)
end

function v1.Stop() -- Line: 266 -- upvalues: stopLive (val)
    stopLive()
end

return (table.freeze(v1))