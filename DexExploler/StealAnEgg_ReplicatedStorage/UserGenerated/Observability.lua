-- Script path: ReplicatedStorage.UserGenerated.Observability
-- Decompile time: 5.14 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local u10 = {Version = 11}
u10.RootId = table.freeze({PlayerGui = 0, Workspace = 1, Lighting = 2})
u10.FirstInstanceId = 3
u10.Op = table.freeze({
    Time = 0,
    Add = 1,
    Remove = 2,
    Reparent = 3,
    Rename = 4,
    Prop = 5,
    Viewport = 6,
    Pointer = 7,
    Selected = 8,
    SafeArea = 9,
    Defaults = 10,
    PropLerp = 11,
    SeqCopy = 12,
    SeqShift = 13,
    Camera = 14,
    CFramePos = 15,
    CFrameRot = 16,
    UDim2Part = 17,
    CFrameMotion = 18,
    Copy = 19,
    KeyDown = 20,
    KeyUp = 21,
    CameraFollow = 22,
    Keyframe = 23,
    ClockSync = 24,
    Emit = 25,
    PropMany = 26,
    DropTemplates = 27,
    TemplateNext = 28,
    Template = 29,
    CopyBase = 30,
    Start = 31,
    TimeDelta = 32,
    CFrameDelta = 33,
})
u10.TemplateNext = table.freeze({Add = 1, Keep = 2})
u10.ValueType = table.freeze({
    Bool = 1,
    Int32 = 2,
    Float32 = 3,
    Float64 = 4,
    String = 5,
    Enum = 6,
    UDim = 7,
    UDim2 = 8,
    Vector2 = 9,
    Vector3 = 10,
    Color3 = 11,
    Rect = 12,
    Font = 13,
    ColorSequence = 14,
    NumberSequence = 15,
    NumberRange = 16,
    Content = 17,
    CFrame = 18,
    Vector2int16 = 19,
    Int64 = 20,
    Ref = 21,
})
u10.PointerKind = table.freeze({Mouse = 1, Touch = 2, VirtualCursor = 3})
u10.PointerState = table.freeze({Move = 0, Down = 1, Up = 2})
u10.StopReason = table.freeze({Dropped = "dropped", Capped = "capped", Closed = "closed"})
u10.AssemblyRootProperty = "AssemblyRoot"
u10.SurfaceIdAttribute = "__UG_SurfaceId"
u10.SurfaceIdProperty = "SurfaceId"
u10.BakedTag = "UG_REPLAY_BAKED"
u10.BakedIdAttribute = "UG_REPLAY_BAKED_ID"
u10.BakedOriginAttribute = "UG_REPLAY_BAKED_ORIGIN"
u10.UnbakedTag = "UG_REPLAY_UNBAKED"
u10.UnbakedAttribute = "UG_REPLAY_UNBAKED"
u10.BakeIdProperty = "BakeId"
u10.PivotProperty = "Pivot"
u10.AudioSources = table.freeze({Sound = true, AudioPlayer = true, AudioTextToSpeech = true, AudioWindSynthesizer = true})
u10.AudioEffects = table.freeze({
    AudioFader = true,
    AudioEqualizer = true,
    AudioFilter = true,
    AudioReverb = true,
    AudioEcho = true,
    AudioCompressor = true,
    AudioLimiter = true,
    AudioGate = true,
    AudioPitchShifter = true,
    AudioChorus = true,
    AudioFlanger = true,
    AudioTremolo = true,
    AudioDistortion = true,
    AudioChannelMixer = true,
    AudioChannelSplitter = true,
})
u10.AudioClasses = table.freeze({
    Sound = true,
    SoundGroup = true,
    SoundService = true,
    AudioPlayer = true,
    AudioTextToSpeech = true,
    AudioWindSynthesizer = true,
    AudioEmitter = true,
    AudioListener = true,
    AudioDeviceOutput = true,
    Wire = true,
})
local u87 = {}

function u10.IsAudio(a1) -- Line: 542 -- upvalues: u87 (val), u10 (val) -- types: a1: userdata
    local ClassName = a1.ClassName
    local v1 = u87[ClassName]
    if v1 == nil then
        local v2 = true
        if u10.AudioClasses[ClassName] ~= true then
            v2 = true
            if u10.AudioEffects[ClassName] ~= true then
                v2 = a1:IsA("SoundEffect")
            end
        end
        u87[ClassName] = v2
    end
    return v1
end

u10.EmissionScaleProperty = "EmissionScale"
u10.WorldCFrameProperty = "WorldCFrame"
u10.OnCameraProperty = "OnCamera"
u10.DistanceAttenuationProperty = "DistanceAttenuation"
u10.AngleAttenuationProperty = "AngleAttenuation"
u10.MasterVolumeProperty = "MasterVolume"
u10.PolledProperties = table.freeze({})
u10.MaxMessageBytes = 131072
u10.MaxStringBytes = 16384
u10.Remotes = table.freeze({
    Start = script:WaitForChild("Start"),
    Data = script:WaitForChild("Data"),
    Stop = script:WaitForChild("Stop"),
    Teleport = script:WaitForChild("Teleport"),
    Emit = script:WaitForChild("Emit"),
})
local u129 = nil

function u10.RecordEmit(a1, a2) -- Line: 605 -- upvalues: u129 (ref) -- types: a1: userdata, a2: number?
    if typeof(a1) == "Instance" and a1:IsA("ParticleEmitter") then
        local v1 = math.floor((tonumber(a2)) or 16)
        local v2 = u129
        if v2 and v1 > 0 then
            v2(a1, v1)
        end
        return
    end
end

function u10.SetEmitSink(a1) -- Line: 617 -- upvalues: u129 (ref) -- types: a1: function?
    u129 = a1
end

u10.DefaultCaptureInterval = 0.05
u10.LocalCaptureInterval = 0.016666666666666666
u10.MinCaptureInterval = 0.016666666666666666
u10.MaxCaptureInterval = 0.25
u10.CaptureIntervalAttribute = "UG_REPLAY_CAPTURE_INTERVAL"
local u137 = nil
local u138 = nil

local function askCaptureRate(a1, a2) -- Line: 641 -- upvalues: u10 (val) -- types: a1: function, a2: userdata
    local success, err = pcall(a1, a2)
    if not success then
        warn("[UGUIReplay] capture rate callback:", err)
        return nil
    end
    local v1 = tonumber(err)
    if v1 and v1 == v1 then
        return (math.clamp(v1, u10.MinCaptureInterval, u10.MaxCaptureInterval))
    end
    return nil
end

local function refreshCaptureRates(a1) -- Line: 654 -- upvalues: Players (val), u10 (val) -- types: a1: function?
    local CaptureIntervalAttribute, CaptureIntervalAttribute_2, err, success, v1, v2
    local v3 = a1
    for i, j in Players:GetPlayers() do
        if not v3 then
            v1 = nil
        else
            success, err = pcall(v3, j)
            if success then
                v2 = tonumber(err)
                v1 = if not v2 then nil else if v2 == v2 then math.clamp(v2, u10.MinCaptureInterval, u10.MaxCaptureInterval) else nil
            else
                warn("[UGUIReplay] capture rate callback:", err)
                v1 = nil
            end
        end
        CaptureIntervalAttribute = u10.CaptureIntervalAttribute
        if j:GetAttribute(CaptureIntervalAttribute) ~= v1 then
            CaptureIntervalAttribute_2 = u10.CaptureIntervalAttribute
            j:SetAttribute(CaptureIntervalAttribute_2, v1)
        end
    end
end

function u10.SetCaptureRateCallback(a1) -- Line: 682
    -- upvalues: u137 (ref), RunService (val), u138 (ref), refreshCaptureRates (val)
    if a1 ~= nil and type(a1) ~= "function" then
        return
    end
    u137 = a1
    if not RunService:IsServer() then
        return
    end
    if u138 then
        task.cancel(u138)
        u138 = nil
    end
    refreshCaptureRates(a1)
    if a1 then
        task.spawn(function() -- Line: 696 -- upvalues: refreshCaptureRates (upval), a1 (val)
            while true do
                task.wait(0.25)
                refreshCaptureRates(a1)
            end
        end)
    end
end

function u10.CaptureIntervalOf(a1) -- Line: 706
    -- upvalues: u137 (ref), RunService (val), u10 (val), Players (val)
    local v1 = u137
    if v1 and not RunService:IsServer() then
        local v2
        local success, err = pcall(v1, a1)
        if success then
            local v3 = tonumber(err)
            v2 = if not v3 then nil else if v3 == v3 then math.clamp(v3, u10.MinCaptureInterval, u10.MaxCaptureInterval) else nil
        else
            warn("[UGUIReplay] capture rate callback:", err)
            v2 = nil
        end
        if v2 then
            return v2
        end
    end
    local Attribute = a1:GetAttribute(u10.CaptureIntervalAttribute)
    if type(Attribute) == "number" and Attribute == Attribute then
        return (math.clamp(Attribute, u10.MinCaptureInterval, u10.MaxCaptureInterval))
    end
    if a1 == Players.LocalPlayer then
        return u10.LocalCaptureInterval
    end
    return u10.DefaultCaptureInterval
end

return (table.freeze(u10))