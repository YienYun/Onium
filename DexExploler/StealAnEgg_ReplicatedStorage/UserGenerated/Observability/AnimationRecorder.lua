-- Script path: ReplicatedStorage.UserGenerated.Observability.AnimationRecorder
-- Decompile time: 7.86 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local u15 = {}
u15.__index = u15

function u15.new(a1) -- Line: 65 -- upvalues: u15 (val)
    local v1 = {
        Destroyed = false,
        Registry = a1,
        Stream = a1.Stream,
        Clock = a1.Clock,
        ClassId = a1.ClassIndex.AnimationTrack,
    }
    local AnimationTrack = a1.ClassProps.AnimationTrack or {}
    v1.Props = AnimationTrack
    local AnimationTrack_2 = a1.ClassPropsByName.AnimationTrack or {}
    v1.PropIds = AnimationTrack_2
    v1.Tracks = {}
    v1.Animators = setmetatable({}, {__mode = "k"})
    return (setmetatable(v1, u15))
end

function u15.Watch(a1, a2) -- Line: 82 -- types: a1: table, a2: userdata
    if a1.ClassId ~= nil and a1.PropIds.TimePosition ~= nil then
        if not a1.Destroyed and not a1.Animators[a2] then
            a1.Animators[a2] = (a2.AnimationPlayed:Connect(function(a1_2) -- Line: 90 -- upvalues: a1 (val), a2 (val)
                a1:_started(a2, a1_2)
            end))
            for i, j in a2:GetPlayingAnimationTracks() do
                a1:_started(a2, j)
            end
            return
        end
        return
    end
end

function u15:_started(a2, a3) -- Line: 98 -- types: self: table, a2: userdata, a3: userdata
    local Parent = a2.Parent
    if not self.Destroyed and not self.Tracks[a3] and Parent ~= nil then
        local v1 = self.Clock()
        local Animation = a3.Animation
        local u10 = {Owner = Parent, AddAt = v1}
        u10.AnimationId = if not Animation then "" else Animation.AnimationId
        u10.Priority = a3.Priority
        u10.Looped = a3.Looped
        u10.Speed = a3.Speed
        u10.Weight = a3.WeightCurrent
        u10.Position = a3.TimePosition
        u10.PositionTime = v1
        u10.PollTime = v1
        u10.Connections = {}

        local function ended() -- Line: 120 -- upvalues: u10 (val), self (val)
            local Ended = u10.Ended or self.Clock()
            u10.Ended = Ended
        end

        u10.Connections = {a3.Ended:Connect(ended), (a3.Destroying:Connect(ended))}
        self.Tracks[a3] = u10
        return
    end
end

function u15:_writeProp(a2, a3, a4, a5, a6) -- Line: 129
    -- upvalues: Op (val), Codec (val)
    local v1 = self.PropIds[a3]
    if v1 == nil then
        return
    end
    local Stream = self.Stream
    Stream:Time(a5)
    local W = Stream.W
    if not a6 then
        W:u8(Op.Prop)
        Codec.varuint(W, a2)
        Codec.varuint(W, v1)
    else
        W:u8(Op.PropLerp)
        Codec.varuint(W, a2)
        Codec.varuint(W, v1)
        W:u8((math.clamp(math.round(a6 / 10), 1, 255)))
    end
    Codec.writeValue(W, self.Registry.PropTypes[v1], a4)
    Stream:EndRecord()
end

function u15:_add(a2, a3) -- Line: 152 -- upvalues: Codec (val) -- types: self: table, a2: userdata, a3: table
    local Registry = self.Registry
    local v1 = Registry:Resolve(a3.Owner, a3.AddAt)
    if v1 == nil then
        return false
    end
    local v2 = Registry:Allocate(a2, v1)
    a3.Id = v2
    local v3 = Registry:AddTime(a3.AddAt)
    a3.Position = a3.Position + (v3 - a3.PositionTime) / 1000 * a3.Speed
    a3.PositionTime = v3
    a3.PollTime = v3
    v3 = {
        AnimationId = a3.AnimationId,
        Priority = a3.Priority,
        Looped = a3.Looped,
        Speed = a3.Speed,
        WeightCurrent = a3.Weight,
        TimePosition = a3.Position,
    }
    local W = self.Stream.W
    Registry.Copies:WriteHead(W, v2, v1, self.ClassId, a2.Name, false)
    W:u16(#self.Props)
    for i, j in self.Props do
        Codec.varuint(W, j.Id)
        Codec.writeValue(W, j.Type, v3[j.Name])
    end
    self.Stream:EndRecord()
    return true
end

function u15:_poll(a2, a3, a4) -- Line: 186 -- types: self: table, a2: userdata, a3: table, a4: number
    local Id = a3.Id
    local Priority = a2.Priority
    if Priority ~= a3.Priority then
        a3.Priority = Priority
        self:_writeProp(Id, "Priority", Priority, a4)
    end
    local Speed = a2.Speed
    local Looped = a2.Looped
    local TimePosition = a2.TimePosition
    local Length = a2.Length
    local v1 = false
    if Looped ~= a3.Looped then
        a3.Looped = Looped
        v1 = true
        self:_writeProp(Id, "Looped", Looped, a4)
    end
    if 0.001 < (math.abs(Speed - a3.Speed)) then
        v1 = true
        self:_writeProp(Id, "Speed", Speed, a4)
    end
    if not v1 then
        local v2 = a3.Position + (a4 - a3.PositionTime) / 1000 * a3.Speed
        local v3 = TimePosition - v2
        if Length > 0 then
            if Looped then
                v3 = (v3 + Length / 2) % Length - Length / 2
            elseif Length <= v2 and Length - 0.05 <= TimePosition then
                v3 = 0
            end
        end
        v1 = 0.05 < (math.abs(v3))
    end
    a3.Speed = Speed
    if v1 then
        a3.Position = TimePosition
        a3.PositionTime = a4
        self:_writeProp(Id, "TimePosition", TimePosition, a4)
    end
    local WeightCurrent = a2.WeightCurrent
    local v4 = true
    if WeightCurrent ~= 0 then
        v4 = WeightCurrent == 1
    end
    if 0.02 < (math.abs(WeightCurrent - a3.Weight)) or v4 and WeightCurrent ~= a3.Weight then
        a3.Weight = WeightCurrent
        local v5 = a4 - a3.PollTime
        self:_writeProp(Id, "WeightCurrent", WeightCurrent, a4, if not (v5 > 0) then nil else if not (v5 <= 300) then nil else v5)
    end
    a3.PollTime = a4
end

function u15:_forget(a2, a3) -- Line: 238 -- types: self: table, a2: userdata, a3: table
    for i, j in a3.Connections do
        j:Disconnect()
    end
    self.Tracks[a2] = nil
    if a3.Id then
        self.Registry:Free(a2)
    end
end

function u15.Flush(a1) -- Line: 250 -- upvalues: Op (val), Codec (val)
    local Id, Stream, W
    local v1 = a1.Clock()
    local v2 = nil
    local v3 = nil
    local v4 = a1
    for i, j in a1.Tracks, v2, v3 do
        Id = j.Id
        if Id and a1.Registry.Ids[j.Owner] == nil then
            v4.Registry:Free(i)
            j.Id = nil
            j.AddAt = v1
            j.Position = i.TimePosition
            j.PositionTime = v1
            Id = nil
        end
        if j.Ended then
            if not j.Ended and not i.IsPlaying and i.WeightCurrent <= 0 then
                j.Ended = v1
            end
        elseif not j.Owner:IsDescendantOf(game) or not j.Ended and not i.IsPlaying and i.WeightCurrent <= 0 then
            j.Ended = v1
        end
        if j.Ended then
            if Id then
                Stream = v4.Stream
                Stream:Time((math.max(j.Ended, j.PollTime)))
                W = Stream.W
                W:u8(Op.Remove)
                Codec.varuint(W, Id)
                Stream:EndRecord()
            end
            v4:_forget(i, j)
        elseif Id then
            v4:_poll(i, j, v1)
        elseif not v4:_add(i, j) then
            j.AddAt = v1
            j.Position = i.TimePosition
            j.PositionTime = v1
        end
    end
end

function u15.Destroy(a1) -- Line: 293
    a1.Destroyed = true
    for i, j in a1.Animators do
        j:Disconnect()
    end
    table.clear(a1.Animators)
    local v1 = nil
    local v2 = nil
    for k, n in a1.Tracks, v1, v2 do
        for m, i5 in n.Connections do
            i5:Disconnect()
        end
    end
    table.clear(a1.Tracks)
end

return u15