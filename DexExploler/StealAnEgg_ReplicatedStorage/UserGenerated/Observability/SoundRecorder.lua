-- Script path: ReplicatedStorage.UserGenerated.Observability.SoundRecorder
-- Decompile time: 36.77 ms

local result
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local ValueType = Observability.ValueType
local RootId = Observability.RootId
_, result = xpcall(function() -- Line: 61
    return workspace[nil]
end, function() -- Line: 63
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 67
        return a1[a2]
    end
end
local WorldCFrameProperty = Observability.WorldCFrameProperty
local OnCameraProperty = Observability.OnCameraProperty
local DistanceAttenuationProperty = Observability.DistanceAttenuationProperty
local AngleAttenuationProperty = Observability.AngleAttenuationProperty
local MasterVolumeProperty = Observability.MasterVolumeProperty
local u42 = {CoreGui = true, CorePackages = true}
local u43 = {AudioPlayer = "IsPlaying", AudioTextToSpeech = "IsPlaying", AudioWindSynthesizer = "Enabled"}
local u44 = {Sound = true, AudioEmitter = true, AudioListener = true}

local function isPositionSource(a1) -- Line: 153 -- types: a1: userdata?
    local v1 = false
    if a1 ~= nil then
        v1 = a1:IsA("BasePart") or a1:IsA("Attachment")
    end
    return v1
end

local function worldCFrameOf(a1) -- Line: 159 -- types: a1: userdata?
    if a1 == nil then
        return nil
    end
    if a1 == workspace then
        return CFrame.identity
    end
    if a1:IsA("BasePart") then
        return a1.CFrame
    end
    if a1:IsA("Attachment") then
        return a1.WorldCFrame
    end
    if a1:IsA("Camera") then
        return a1.CFrame
    end
    if a1:IsA("PVInstance") then
        return a1:GetPivot()
    end
    return nil
end

local function serializeCurve(a1) -- Line: 178 -- types: a1: table?
    if type(a1) ~= "table" then
        return ""
    end
    local v1 = {}
    for i in a1 do
        if type(i) == "number" then
            table.insert(v1, i)
        end
    end
    table.sort(v1)
    local v2 = table.create(#v1)
    for j, k in v1 do
        v2[j] = (string.format("%.4g:%.4g", k, a1[k]))
    end
    return table.concat(v2, ",")
end

local function cframeMoved(a1, a2) -- Line: 196 -- types: a1: userdata, a2: userdata
    if 0.05 < (a1.Position - a2.Position).Magnitude then
        return true
    end
    local v1 = true
    if not (0.003 < (a1.XVector - a2.XVector).Magnitude) then
        v1 = 0.003 < (a1.YVector - a2.YVector).Magnitude
    end
    return v1
end

local function differs(a1, a2, a3) -- Line: 204 -- upvalues: ValueType (val) -- types: a1: number
    if a2 ~= nil and a3 ~= nil then
        if a1 ~= ValueType.Float32 and a1 ~= ValueType.Float64 then
            if a1 ~= ValueType.CFrame then
                return a2 ~= a3
            end
            if 0.05 < (a2.Position - a3.Position).Magnitude then
                return true
            end
            local v1 = true
            if not (0.003 < (a2.XVector - a3.XVector).Magnitude) then
                v1 = 0.003 < (a2.YVector - a3.YVector).Magnitude
            end
            return v1
        end
        local v2 = math.abs(a3 - a2)
        return math.max(1, (math.abs(a2))) * 0.001 < v2
    end
    return a2 ~= a3
end

local u51 = {}
u51.__index = u51

function u51.new(a1) -- Line: 219 -- upvalues: u51 (val) -- types: a1: function
    local v1 = {
        Destroyed = false,
        Walked = false,
        GraphDirty = true,
        GraphTime = (-1 / 0),
        MasterVolumeReadable = true,
        Clock = a1,
        Connections = {},
        WalkQueue = {},
        Seen = setmetatable({}, {__mode = "k"}),
        SoundSignals = setmetatable({}, {__mode = "k"}),
        RemovalWatched = setmetatable({}, {__mode = "k"}),
        Candidates = {},
        Ghosts = {},
        GraphSources = {},
        Wires = {},
        Listeners = {},
        ActiveSources = {},
        Graph = {},
        Wanted = {},
        Nodes = {},
    }
    local u27 = setmetatable(v1, u51)
    for i, j in game:GetChildren() do
        u27:_watchService(j)
    end
    table.insert(u27.Connections, (game.ChildAdded:Connect(function(a1) -- Line: 262 -- upvalues: u27 (val)
        u27:_watchService(a1)
    end)))
    return u27
end

function u51:_watchService(a2) -- Line: 269
    -- upvalues: result (ref), u42 (val), SoundService (val), Players (val)
    local success, err = pcall(result, a2, "ClassName")
    if success and not u42[err] then
        local success_2, err_2 = pcall(function() -- Line: 274 -- upvalues: a2 (val), self (val)
            return a2.DescendantAdded:Connect(function(a1) -- Line: 275 -- upvalues: self (upval)
                self:_see(a1)
            end)
        end)
        if not success_2 then
            return
        end
        table.insert(self.Connections, err_2)
        if a2 ~= SoundService and a2 ~= Players then
            table.insert(self.WalkQueue, 1, a2)
            return
        end
        table.insert(self.WalkQueue, a2)
        return
    end
end

function u51:_see(a2) -- Line: 293 -- upvalues: result (ref), u43 (val) -- types: self: table, a2: userdata
    if not self.Destroyed and not self.Seen[a2] then
        local success, err = pcall(result, a2, "ClassName")
        if not success then
            return
        end
        if err == "Sound" then
            self.Seen[a2] = true
            self:_watchSound(a2)
            return
        end
        local v1 = u43[err]
        if v1 then
            self.Seen[a2] = true
            self.GraphSources[a2] = v1
            self.GraphDirty = true
            return
        end
        if err == "Wire" then
            self.Seen[a2] = true
            self.Wires[a2] = true
            self.GraphDirty = true
            return
        end
        if err == "AudioListener" then
            self.Seen[a2] = true
            self.Listeners[a2] = true
            self.GraphDirty = true
        end
        return
    end
end

function u51:_watchSound(a2) -- Line: 322 -- types: self: table, a2: userdata
    local v1 = {
        a2.Played:Connect(function() -- Line: 323 -- upvalues: self (val), a2 (val)
            self.Candidates[a2] = true
        end),
        (a2.Changed:Connect(function(a1) -- Line: 328 -- upvalues: self (val), a2 (val) -- types: a1: string
            if a1 == "Playing" then
                self.Candidates[a2] = true
                return
            end
            if a1 == "PlayOnRemove" then
                self:_watchRemoval(a2)
            end
        end)),
    }
    self.SoundSignals[a2] = v1
    if a2.IsPlaying or a2.Playing then
        self.Candidates[a2] = true
    end
    if a2.PlayOnRemove then
        self:_watchRemoval(a2)
    end
end

function u51:_watchRemoval(a2) -- Line: 348 -- upvalues: worldCFrameOf (val) -- types: self: table, a2: userdata
    local v1 = self.SoundSignals[a2]
    if v1 and not self.RemovalWatched[a2] then
        self.RemovalWatched[a2] = true

        local function removed(a1) -- Line: 354 -- upvalues: a2 (val), self (val) -- types: a1: userdata?
            if a2.PlayOnRemove and not self.Ghosts[a2] and a2.SoundId ~= "" then
                local TimeLength = a2.TimeLength
                local TimePosition = a2.TimePosition
                local v1 = math.max(a2.PlaybackSpeed, 0.01)
                self.Ghosts[a2] = {
                    CFrame = a1,
                    Position = TimePosition,
                    EndsAt = (self.Clock()) + (if not (TimeLength > 0) then 10000 else math.max(0, TimeLength - TimePosition) / v1 * 1000),
                }
                return
            end
        end

        table.insert(v1, (a2.Destroying:Connect(function() -- Line: 369 -- upvalues: removed (val), a2 (val), worldCFrameOf (upval)
            local Parent = a2.Parent
            local v1 = false
            if Parent ~= nil then
                v1 = Parent:IsA("BasePart") or Parent:IsA("Attachment")
            end
            removed(if not v1 then nil else worldCFrameOf(a2.Parent))
        end)))
        table.insert(v1, (a2.AncestryChanged:Connect(function() -- Line: 375 -- upvalues: a2 (val), removed (val)
            if not a2:IsDescendantOf(game) then
                removed(nil)
            end
        end)))
        return
    end
end

function u51:_walk(a2) -- Line: 384 -- types: self: table, a2: number
    local err, success, v1
    local WalkQueue = self.WalkQueue
    local v2, v3 = a2, self
    while #WalkQueue > 0 do
        if not (os.clock() < v2) then
            break
        end
        v1 = table.remove(WalkQueue)
        v3:_see(v1)
        success, err = pcall(v1.GetChildren, v1)
        if success then
            table.move(err, 1, #err, #WalkQueue + 1, WalkQueue)
        end
    end
end

function u51.Bind(a1, a2) -- Line: 397
    a1.Registry = a2
    table.clear(a1.Nodes)
    a1.GraphDirty = true
    a1.Enabled = a2.ClassProps.Sound ~= nil
end

function u51._soundAudible(a1, a2) -- Line: 408 -- types: a1: table, a2: userdata
    return a2.IsPlaying and a2:IsDescendantOf(game)
end

function u51:_traceGraph() -- Line: 414 -- upvalues: Players (val), result (ref)
    local err, err_2, err_3, err_4, success, success_2, success_3, success_4, v1, v2, v3, v4
    local LocalPlayer = Players.LocalPlayer
    local u294 = {}
    local v5 = {self.Wires, self.Listeners}
    local v6 = nil
    local v7 = nil
    local v8 = self
    for i, j in v5, v6, v7 do
        for k in j do
            v3 = game
            if not k:IsDescendantOf(v3) then
                j[k] = nil
                v8.Seen[k] = nil
            end
        end
    end
    v6 = nil
    v7 = nil
    for n in v8.Wires, v6, v7 do
        success_3, err_3 = pcall(result, n, "SourceInstance")
        success_4, err_4 = pcall(result, n, "TargetInstance")
        if success_3 and success_4 and err_3 and err_4 then
            v2 = u294[err_3]
            if not v2 then
                u294[err_3] = {}
            end
            table.insert(v2, n)
        end
    end
    local u251 = {}
    v7 = nil
    local v9 = nil
    for m in v8.Listeners, v7, v9 do
        success_2, err_2 = pcall(result, m, "AudioInteractionGroup")
        if success_2 then
            v1 = u251[err_2]
            if not v1 then
                u251[err_2] = {}
            end
            table.insert(v1, m)
        end
    end

    local function nextOf(a1) -- Line: 450 -- upvalues: u294 (val), result (upval), u251 (val) -- types: a1: userdata
        local v1 = {}
        for i, j in u294[a1] or {} do
            table.insert(v1, (result(j, "TargetInstance")))
        end
        if result(a1, "ClassName") == "AudioEmitter" then
            local success, err = pcall(result, a1, "AudioInteractionGroup")
            for k, n in success and u251[err] or {} do
                table.insert(v1, n)
            end
        end
        return v1
    end

    v7 = {}
    v9 = {}
    local v10 = nil
    for i5 in v8.ActiveSources, v10 do
        table.insert(v9, i5)
    end
    while #v9 > 0 do
        v4 = table.remove(v9)
        if not v7[v4] then
            v10 = nextOf(v4)
            v7[v4] = v10
            for i6, i7 in v10 do
                if not v7[i7] then
                    table.insert(v9, i7)
                end
            end
        end
    end
    v9 = {}
    v10 = nil
    local v11 = nil
    for i8 in v7, v10, v11 do
        if result(i8, "ClassName") == "AudioDeviceOutput" then
            success, err = pcall(result, i8, "Player")
            if success then
                if err == nil or err == LocalPlayer then
                    v9[i8] = true
                end
            end
        end
    end
    v6 = true
    while v6 do
        v6 = false
        v10 = nil
        v11 = nil
        for i9, i10 in v7, v10, v11 do
            if not v9[i9] then
                for i11, i12 in i10 do
                    if v9[i12] then
                        v9[i9] = true
                        v6 = true
                        break
                    end
                end
            end
        end
    end
    v7 = {}
    v10 = nil
    v11 = nil
    for i13 in v9, v10, v11 do
        v7[i13] = true
        for i14, i15 in u294[i13] or {} do
            if v9[result(i15, "TargetInstance")] then
                v7[i15] = true
            end
        end
    end
    v8.Graph = v7
end

function u51:_serviceId(a2) -- Line: 524
    -- upvalues: RootId (val), SoundService (val)
    if a2 ~= nil and a2 ~= workspace then
        if a2 == SoundService then
            return self:_ensure(SoundService) or RootId.Workspace
        end
        return self.Registry:StandIn(a2)
    end
    return RootId.Workspace
end

function u51:_containerOf(a2) -- Line: 536
    -- upvalues: RootId (val), SoundService (val), Observability (val)
    if a2 == nil then
        return RootId.Workspace, nil, nil
    end
    local v1 = self.Nodes[a2]
    if v1 then
        return v1.Id, nil, v1
    end
    if a2 == SoundService then
        return (self:_serviceId(SoundService)), nil, nil
    end
    if not Observability.IsAudio(a2) then
        v1 = self.Registry:Resolve(a2)
        if v1 then
            return v1, a2, nil
        end
    end
    local Parent = a2
    while Parent.Parent do
        if Parent.Parent == game then
            break
        end
        Parent = Parent.Parent
    end
    return (self:_serviceId(if Parent.Parent ~= game then nil else Parent)), nil, nil
end

function u51:_placement(a2, a3) -- Line: 561
    -- upvalues: result (ref), SoundService (val), RootId (val), u44 (val)
    local v1, v2, v3, v4
    local v5 = result(a2, "Parent")
    if a2 == SoundService then
        return RootId.Workspace, nil, nil, "none"
    end
    local v6 = self.Ghosts[a2]
    if v6 then
        local Workspace = RootId.Workspace
        v2 = nil
        v3 = nil
        if v6.CFrame then
            return Workspace, v2, v3, "world"
        end
        return Workspace, v2, v3, "none"
    end
    if a3 == "SoundGroup" and v5 and v5:IsA("SoundGroup") then
        v6 = self.Nodes[v5] or self:_ensureNode(v5)
        if v6 then
            return v6.Id, nil, v6, "none"
        end
    end
    if not u44[a3] then
        v1, v2, v3 = self:_containerOf(v5)
        return v1, v2, v3, "none"
    end
    if a3 ~= "Sound" and v5 and v5 == workspace.CurrentCamera then
        v1, v2, v3 = self:_containerOf(v5)
        return v1, v2, v3, "camera"
    end
    v1 = false
    if v5 ~= nil then
        v1 = v5:IsA("BasePart") or v5:IsA("Attachment")
    end
    if not v1 then
        v1 = false
        if a3 ~= "Sound" then
            v1 = false
            if v5 ~= nil then
                v1 = v5:IsA("PVInstance")
            end
        end
    end
    if not v1 then
        v2, v3, v4 = self:_containerOf(v5)
        return v2, v3, v4, "none"
    end
    if v5 == v5 then
        v2 = false
        if v5 ~= nil then
            v2 = v5:IsA("BasePart") or v5:IsA("Attachment")
        end
        if v2 then
            v1 = self.Registry:Resolve(v5)
            if v1 then
                return v1, v5, nil, "parent"
            end
        end
    end
    v2, v3, v4 = self:_containerOf(v5)
    return v2, v3, v4, "world"
end

local function contentUri(a1) -- Line: 605 -- upvalues: result (ref) -- types: a1: userdata
    local success, err = pcall(result, a1, "AudioContent")
    if success and typeof(err) == "Content" then
        local Uri = err.Uri
        if type(Uri) == "string" then
            return Uri
        end
        return ""
    end
    return ""
end

function u51:_read(a2, a3) -- Line: 615
    -- upvalues: WorldCFrameProperty (val), worldCFrameOf (val), result (ref), OnCameraProperty (val)
    -- upvalues: DistanceAttenuationProperty (val), AngleAttenuationProperty (val), serializeCurve (val)
    -- upvalues: MasterVolumeProperty (val), SoundService (val)
    local Inst = a2.Inst
    local v1 = self.Ghosts[Inst]
    if a3 == WorldCFrameProperty then
        if a2.Mode ~= "world" then
            return false, nil
        end
        if v1 then
            return v1.CFrame ~= nil, v1.CFrame
        end
        local v2 = worldCFrameOf(result(Inst, "Parent"))
        return v2 ~= nil, v2
    end
    if a3 == OnCameraProperty then
        return a2.Mode == "camera", true
    end
    if a3 ~= DistanceAttenuationProperty and a3 ~= AngleAttenuationProperty then
        local Uri, err_2, err_3, success_2, success_3
        if a3 == MasterVolumeProperty then
            if not self.MasterVolumeReadable then
                return false, nil
            end
            local success, err = pcall(function() -- Line: 640
                return UserSettings():GetService("UserGameSettings").MasterVolume
            end)
            self.MasterVolumeReadable = success
            return success, err
        end
        if Inst ~= SoundService then
            success_2, err_2 = pcall(result, Inst, a3)
            if success_2 then
                if a3 ~= "SoundId" and a3 ~= "Asset" then
                    return success_2, err_2
                end
                if err_2 == "" then
                    success_3, err_3 = pcall(result, Inst, "AudioContent")
                    if success_3 and typeof(err_3) == "Content" then
                        Uri = err_3.Uri
                        if type(Uri) == "string" then
                            return success_2, Uri
                        end
                        return success_2, ""
                    end
                    err_2 = ""
                end
            end
            return success_2, err_2
        end
        if a3 ~= "ListenerType" and a3 ~= "ListenerCFrame" then
            success_2, err_2 = pcall(result, Inst, a3)
            if success_2 then
                if a3 ~= "SoundId" and a3 ~= "Asset" then
                    return success_2, err_2
                end
                if err_2 == "" then
                    success_3, err_3 = pcall(result, Inst, "AudioContent")
                    if success_3 and typeof(err_3) == "Content" then
                        Uri = err_3.Uri
                        if type(Uri) == "string" then
                            return success_2, Uri
                        end
                        return success_2, ""
                    end
                    err_2 = ""
                end
            end
            return success_2, err_2
        end
        local Listener, Listener_2 = SoundService:GetListener()
        if a3 == "ListenerType" then
            return true, Listener
        end
        if Listener == Enum.ListenerType.CFrame then
            return typeof(Listener_2) == "CFrame", Listener_2
        end
        if Listener ~= Enum.ListenerType.Camera and typeof(Listener_2) == "Instance" then
            local v3 = worldCFrameOf(Listener_2)
            return v3 ~= nil, v3
        end
        return false, nil
    end
    local success_4, err_4 = pcall(function() -- Line: 630 -- upvalues: a3 (val), DistanceAttenuationProperty (upval), Inst (val)
        if a3 == DistanceAttenuationProperty then
            return (Inst:GetDistanceAttenuation())
        end
        return (Inst:GetAngleAttenuation())
    end)
    return success_4, serializeCurve(if not success_4 then nil else err_4)
end

function u51:_stored(a2, a3) -- Line: 668 -- upvalues: ValueType (val) -- types: self: table, a2: number
    if a2 ~= ValueType.Ref then
        return a3
    end
    if typeof(a3) == "Instance" then
        return self.Registry.Ids[a3]
    end
    return nil
end

function u51:_writeProp(a2, a3, a4, a5, a6) -- Line: 675
    -- upvalues: Op (val), Codec (val)
    local Stream = self.Registry.Stream
    Stream:Time(a5)
    local W = Stream.W
    if not a6 then
        W:u8(Op.Prop)
        Codec.varuint(W, a2.Id)
        Codec.varuint(W, a3.Id)
    else
        W:u8(Op.PropLerp)
        Codec.varuint(W, a2.Id)
        Codec.varuint(W, a3.Id)
        W:u8((math.clamp(math.round(a6 / 10), 1, 255)))
    end
    Codec.writeValue(W, a3.Type, a4)
    Stream:EndRecord()
end

function u51:_ensureNode(a2) -- Line: 695 -- types: self: table, a2: userdata
    local v1 = self.Nodes[a2]
    if v1 then
        return v1
    end
    if not self.Wanted[a2] then
        return nil
    end
    return self:_ensure(a2) and self.Nodes[a2]
end

function u51:_ensure(a2) -- Line: 708 -- upvalues: result (ref), Codec (val) -- types: self: table, a2: userdata
    local v1 = self.Nodes[a2]
    if v1 then
        return v1.Id
    end
    local Registry = self.Registry
    local v2 = result(a2, "ClassName")
    local v3 = Registry.ClassIndex[v2]
    local v4 = Registry.ClassProps[v2]
    if v3 ~= nil and v4 ~= nil then
        local Id, Name, Position, W, err, len, success, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
        if v2 == "Sound" then
            v12 = result(a2, "SoundGroup")
            if v12 then
                self:_ensureNode(v12)
            end
        elseif v2 == "Wire" then
            for i, j in {"SourceInstance", "TargetInstance"} do
                v6 = result(a2, j)
                if v6 then
                    self:_ensureNode(v6)
                end
            end
        end
        if not a2:IsA("SoundEffect") then
            v5, v6, v7, v8 = self:_placement(a2, v2)
            Id = v5
            v13 = v7
            v14 = v8
            if self.Nodes[a2] then
                return self.Nodes[a2].Id
            end
            v5 = self.Clock()
            v6 = Registry:Allocate(a2, Id)
            v7 = Registry:AddTime(v5)
            v8 = {
                Position = 0,
                Speed = 0,
                Inst = a2,
                ClassName = v2,
                Id = v6,
                ParentId = Id,
                ParentInst = v6,
                ParentNode = v13,
            }
            v8.Children = {}
            v8.Mode = v14
            v8.Values = {}
            v8.PollTime = v7
            v8.CurveTime = v7
            v8.PositionTime = v7
            v8.WantedAt = v5
            if v13 then
                v13.Children[v8] = true
            end
            self.Nodes[a2] = v8
            v14 = Registry:DefaultsFor(v2) or {}
            W = Registry.Stream.W
            Registry.Copies:WriteHead(W, v6, Id, v3, result(a2, "Name"), false)
            len = W.len
            W:u16(0)
            v12 = 0
            v3 = self.Ghosts[a2]
            v9 = nil
            v10 = nil
            for k, n in v4, v9, v10 do
                Name = n.Name
                v11, Position = self:_read(v8, Name)
                if v11 then
                    if Name == "TimePosition" then
                        success, err = pcall(result, a2, "PlaybackSpeed")
                        v8.Speed = if not success then 1 else if type(err) ~= "number" then 1 else err
                        if v3 then
                            Position = v3.Position
                        end
                        Position = Position + (v7 - v5) / 1000 * v8.Speed
                        v8.Position = Position
                        v8.PositionTime = v7
                    end
                    v11 = self:_stored(n.Type, Position)
                    v8.Values[Name] = v11
                    if Name == "TimePosition" or v11 ~= nil and v14[n.Id] ~= Position then
                        Codec.varuint(W, n.Id)
                        Codec.writeValue(W, n.Type, Position)
                        v12 = v12 + 1
                    end
                end
            end
            W:patchU16(len, v12)
            Registry.Stream:EndRecord()
            return v6
        end
        v13 = self:_ensureNode((result(a2, "Parent")))
        if not v13 then
            return nil
        end
        Id = v13.Id
        if self.Nodes[a2] then
            return self.Nodes[a2].Id
        end
        v5 = self.Clock()
        v6 = Registry:Allocate(a2, Id)
        v7 = Registry:AddTime(v5)
        v8 = {
            Position = 0,
            Speed = 0,
            Inst = a2,
            ClassName = v2,
            Id = v6,
            ParentId = Id,
            ParentInst = nil,
            ParentNode = v13,
        }
        v8.Children = {}
        v8.Mode = "none"
        v8.Values = {}
        v8.PollTime = v7
        v8.CurveTime = v7
        v8.PositionTime = v7
        v8.WantedAt = v5
        if v13 then
            v13.Children[v8] = true
        end
        self.Nodes[a2] = v8
        v14 = Registry:DefaultsFor(v2) or {}
        W = Registry.Stream.W
        Registry.Copies:WriteHead(W, v6, Id, v3, result(a2, "Name"), false)
        len = W.len
        W:u16(0)
        v12 = 0
        v3 = self.Ghosts[a2]
        v9 = nil
        v10 = nil
        for m, i5 in v4, v9, v10 do
            Name = i5.Name
            v11, Position = self:_read(v8, Name)
            if v11 then
                if Name == "TimePosition" then
                    success, err = pcall(result, a2, "PlaybackSpeed")
                    v8.Speed = if not success then 1 else if type(err) ~= "number" then 1 else err
                    if v3 then
                        Position = v3.Position
                    end
                    Position = Position + (v7 - v5) / 1000 * v8.Speed
                    v8.Position = Position
                    v8.PositionTime = v7
                end
                v11 = self:_stored(i5.Type, Position)
                v8.Values[Name] = v11
                if Name == "TimePosition" or v11 ~= nil and v14[i5.Id] ~= Position then
                    Codec.varuint(W, i5.Id)
                    Codec.writeValue(W, i5.Type, Position)
                    v12 = v12 + 1
                end
            end
        end
        W:patchU16(len, v12)
        Registry.Stream:EndRecord()
        return v6
    end
    return nil
end

function u51:_forget(a2) -- Line: 813 -- types: self: table, a2: table
    for i in a2.Children do
        self:_forget(i)
    end
    if a2.ParentNode then
        a2.ParentNode.Children[a2] = nil
    end
    self.Nodes[a2.Inst] = nil
    self.Registry:Free(a2.Inst)
end

function u51:_remove(a2, a3) -- Line: 824
    -- upvalues: Op (val), Codec (val)
    local Stream = self.Registry.Stream
    Stream:Time((math.max(a3, a2.PollTime)))
    local W = Stream.W
    W:u8(Op.Remove)
    Codec.varuint(W, a2.Id)
    Stream:EndRecord()
    self:_forget(a2)
end

function u51._drifted(a1, a2, a3, a4) -- Line: 835
    -- upvalues: result (ref)
    local Inst = a2.Inst
    local v1 = a3 - (a2.Position + (a4 - a2.PositionTime) / 1000 * a2.Speed)
    local success, err = pcall(result, Inst, "TimeLength")
    local v2 = if a2.ClassName ~= "Sound" then "Looping" else "Looped"
    local success_2, err_2 = pcall(result, Inst, v2)
    if success and success_2 and err_2 and err > 0 then
        local v3 = err
        local success_3, err_3 = pcall(result, Inst, "LoopRegion")
        local v4 = true
        if a2.ClassName == "Sound" then
            v4 = result(Inst, "PlaybackRegionsEnabled")
        end
        if success_3 and v4 and typeof(err_3) == "NumberRange" and err_3.Min < err_3.Max then
            v3 = (math.min(err_3.Max, err)) - err_3.Min
        end
        if v3 > 0 then
            v1 = (v1 + v3 / 2) % v3 - v3 / 2
        end
    end
    return 0.05 < (math.abs(v1))
end

function u51:_poll(a2, a3) -- Line: 855
    -- upvalues: DistanceAttenuationProperty (val), AngleAttenuationProperty (val), differs (val), ValueType (val)
    -- upvalues: result (ref)
    local Name, v1, v2, v3
    local v4 = self.Registry.ClassProps[a2.ClassName]
    local v5 = a3 - a2.PollTime
    local v6 = if not (v5 > 0) then nil else if not (v5 <= 300) then nil else v5
    v5 = self.Ghosts[a2.Inst] ~= nil
    if 500 <= a3 - a2.CurveTime then
        a2.CurveTime = a3
    end
    local v7 = false
    local v8 = nil
    local v9 = nil
    for i, j in v4, v8, v9 do
        Name = j.Name
        if Name ~= "TimePosition" then
            if not v5 or Name == "Volume" then
                if Name == DistanceAttenuationProperty then
                    if v3 then
                        v1, v2 = self:_read(a2, Name)
                        if v1 then
                            v1 = self:_stored(j.Type, v2)
                            if differs(j.Type, a2.Values[Name], v1) then
                                a2.Values[Name] = v1
                                if j.Type == ValueType.Ref and v2 ~= nil and v1 == nil then
                                    v2 = nil
                                end
                                if Name == "PlaybackSpeed" or Name == "Looped" or Name == "Looping" then
                                    v7 = true
                                end
                                v1 = if j.Type == ValueType.Float32 then v6 else if j.Type ~= ValueType.CFrame then nil else v6
                                self:_writeProp(a2, j, v2, a3, v1)
                            end
                        end
                    end
                elseif Name ~= AngleAttenuationProperty or v3 then
                    v1, v2 = self:_read(a2, Name)
                    if v1 then
                        v1 = self:_stored(j.Type, v2)
                        if differs(j.Type, a2.Values[Name], v1) then
                            a2.Values[Name] = v1
                            if j.Type == ValueType.Ref and v2 ~= nil and v1 == nil then
                                v2 = nil
                            end
                            if Name == "PlaybackSpeed" or Name == "Looped" or Name == "Looping" then
                                v7 = true
                            end
                            v1 = if j.Type == ValueType.Float32 then v6 else if j.Type ~= ValueType.CFrame then nil else v6
                            self:_writeProp(a2, j, v2, a3, v1)
                        end
                    end
                end
            end
        end
    end
    local success, err = pcall(result, a2.Inst, "TimePosition")
    if success and not v5 and type(err) == "number" then
        if v7 then
            for k, n in v4 do
                if n.Name == "TimePosition" then
                    self:_writeProp(a2, n, err, a3)
                    break
                end
            end
            a2.Position = err
            a2.PositionTime = a3
        elseif self:_drifted(a2, err, a3) then
            for m, i5 in v4 do
                if i5.Name == "TimePosition" then
                    self:_writeProp(a2, i5, err, a3)
                    break
                end
            end
            a2.Position = err
            a2.PositionTime = a3
        end
        local success_2, err_2 = pcall(result, a2.Inst, "PlaybackSpeed")
        if success_2 and 0.001 < (math.abs(err_2 - a2.Speed)) then
            a2.Position = err
            a2.PositionTime = a3
            a2.Speed = err_2
        end
    end
    a2.PollTime = a3
end

function u51:_collect(a2) -- Line: 917 -- upvalues: SoundService (val), result (ref) -- types: self: table, a2: number
    local err, success, v1
    local u135 = {}
    self.Wanted = u135
    u135[SoundService] = true

    local function wantGroupChain(a1) -- Line: 922 -- upvalues: u135 (val) -- types: a1: userdata?
        local Parent
        while a1 do
            if not a1:IsA("SoundGroup") or u135[a1] then
                break
            end
            u135[a1] = true
            for i, j in a1:GetChildren() do
                if j:IsA("SoundEffect") then
                    u135[j] = true
                end
            end
            Parent = a1.Parent
        end
    end

    local function wantSound(a1) -- Line: 933 -- upvalues: u135 (val), wantGroupChain (val) -- types: a1: userdata
        u135[a1] = true
        for i, j in a1:GetChildren() do
            if j:IsA("SoundEffect") then
                u135[j] = true
            end
        end
        wantGroupChain(a1.SoundGroup)
    end

    for i in self.Candidates do
        if self:_soundAudible(i) then
            wantSound(i)
        elseif not i.Playing then
            self.Candidates[i] = nil
        end
    end
    for j, k in self.Ghosts do
        if not (k.EndsAt <= a2) then
            wantSound(j)
        else
            self.Ghosts[j] = nil
        end
    end
    local ActiveSources = self.ActiveSources
    local GraphSources = self.GraphSources
    local v2 = nil
    local v3 = nil
    local v4, v5 = self, a2
    for n, m in GraphSources, v2, v3 do
        v1 = game
        if n:IsDescendantOf(v1) then
            success, err = pcall(result, n, m)
            v1 = success and err == true
            if v1 ~= (ActiveSources[n] == true) then
                ActiveSources[n] = if not v1 then nil else true
                v4.GraphDirty = true
            end
        else
            v4.GraphSources[n] = nil
            v4.Seen[n] = nil
        end
    end
    for i5 in ActiveSources do
        if v4.GraphSources[i5] == nil then
            ActiveSources[i5] = nil
            v4.GraphDirty = true
        end
    end
    if v4.GraphDirty or 1000 <= v5 - v4.GraphTime then
        v4.GraphDirty = false
        v4.GraphTime = v5
        if next(ActiveSources) or next(v4.Graph) then
            v4:_traceGraph()
        end
    end
    for i6 in v4.Graph do
        u135[i6] = true
    end
end

function u51.Flush(a1) -- Line: 993 -- upvalues: SoundService (val)
    if not a1.Destroyed and a1.Registry and a1.Enabled then
        local ClassName, Wanted, v1, v2, v3, v4, v5
        local v6 = a1.Clock()
        a1:_walk((os.clock()) + (if not a1.Walked then 0.002 else 0.0005))
        if #a1.WalkQueue == 0 then
            a1.Walked = true
        end
        a1:_collect(v6)
        local v7 = a1
        for i, j in table.clone(a1.Nodes) do
            if v7.Nodes[i] == j then
                if j.ParentInst == nil then
                    v5 = false
                    if j.ParentNode ~= nil then
                        v5 = v7.Nodes[j.ParentNode.Inst] ~= j.ParentNode
                    end
                else
                    v5 = true
                    if a1.Registry.Ids[j.ParentInst] == j.ParentId then
                        v5 = false
                        if j.ParentNode ~= nil then
                            v5 = v7.Nodes[j.ParentNode.Inst] ~= j.ParentNode
                        end
                    end
                end
                if not v5 then
                    v5 = a1.Wanted[i] ~= nil
                    if v5 then
                        j.WantedAt = v6
                    elseif v7.GraphSources[i] == nil and i ~= SoundService and j.ClassName ~= "Sound" then
                        v1 = false
                        if v6 - j.WantedAt < 3000 then
                            v2 = game
                            v1 = i:IsDescendantOf(v2)
                        end
                        v5 = v1
                    end
                    if not v5 then
                        v7:_remove(j, v6)
                    elseif not i:IsA("SoundEffect") and i ~= SoundService and not v7.Ghosts[i] then
                        ClassName = j.ClassName
                        v1, _, _, v3 = v7:_placement(i, ClassName)
                        if v1 ~= j.ParentId or v3 ~= j.Mode then
                            v7:_remove(j, v6)
                        end
                    end
                else
                    v7:_forget(j)
                end
            end
        end
        local v8 = nil
        local v9 = nil
        for k in Wanted, v8, v9 do
            v4 = v7.Nodes[k]
            if v4 then
                v7:_poll(v4, v6)
            elseif k ~= SoundService or v7.Nodes[SoundService] == nil then
                v7:_ensure(k)
            end
        end
        for n, m in v7.Nodes do
            if not Wanted[n] and m.PollTime < v6 then
                v7:_poll(m, v6)
            end
        end
        return
    end
end

function u51.Destroy(a1) -- Line: 1054
    a1.Destroyed = true
    for i, j in a1.Connections do
        j:Disconnect()
    end
    table.clear(a1.Connections)
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for k, n in a1.SoundSignals, v1, v2 do
        for m, i5 in n do
            i5:Disconnect()
        end
    end
    table.clear(v3.SoundSignals)
    table.clear(v3.Nodes)
    table.clear(v3.Candidates)
    table.clear(v3.Ghosts)
end

return u51