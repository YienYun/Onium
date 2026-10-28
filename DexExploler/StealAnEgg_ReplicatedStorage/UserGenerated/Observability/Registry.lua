-- Script path: ReplicatedStorage.UserGenerated.Observability.Registry
-- Decompile time: 12.74 ms

local result
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies)
local Op = Observability.Op
local ValueType = Observability.ValueType
_, result = xpcall(function() -- Line: 39
    return workspace[nil]
end, function() -- Line: 41
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 45
        return a1[a2]
    end
end
local u36 = table.freeze({Marked = false, Include = true, Children = table.freeze({})})

local function newFilterNode(a1) -- Line: 59 -- types: a1: boolean
    return {Marked = false, Children = {}, Include = a1}
end

local function buildFilter(a1) -- Line: 64
    local v1, v2, v3
    if a1.FilterType ~= "Include" and a1.FilterType ~= "Exclude" then
        return nil
    end
    local v4 = {Marked = false, Children = {}, Include = a1.FilterType == "Include"}
    local v5 = nil
    local v6 = nil
    for i, j in a1.Filter, v5, v6 do
        if type(j) == "string" then
            v3 = v4
            for k in string.gmatch(j, "[^%.]+") do
                v2 = v3.Children[k]
                if not v2 then
                    v2 = {Marked = false, Children = {}, Include = v1}
                    v3.Children[k] = v2
                end
                v3 = v2
            end
            if v3 ~= v4 then
                v3.Marked = true
            end
        end
    end
    if not v1 and next(v4.Children) == nil then
        return nil
    end
    return v4
end

local u39 = {}
u39.__index = u39
u39.BuildFilter = buildFilter

function u39.new(a1, a2, a3) -- Line: 100
    -- upvalues: Observability (val), ValueType (val), Copies (val), u39 (val), Codec (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = {}
    for i, j in a1.Classes do
        v9[j] = i - 1
    end
    local v10 = {}
    local v11 = {}
    local v12 = {}
    local v13 = {}
    local ClassProps = a1.ClassProps
    local v14 = nil
    local v15 = nil
    local v16, v17, v18 = a1, a2, a3
    for k, n in ClassProps, v14, v15 do
        v1 = {}
        v2 = {}
        v3 = {}
        v4 = {}
        v5 = nil
        v6 = nil
        for m, i5 in n, v5, v6 do
            v7 = v16.Props[i5 + 1]
            if v7 then
                v8 = {Id = i5, Name = v7.Name, Type = v7.Type}
                if not Observability.PolledProperties[v7.Name] then
                    table.insert(v1, v8)
                    v2[v7.Name] = i5
                else
                    table.insert(v3, v8)
                end
                if v7.Type == ValueType.Ref then
                    table.insert(v4, v8)
                end
            end
        end
        v10[k] = v1
        v11[k] = v2
        if #v3 > 0 then
            v12[k] = v3
        end
        if #v4 > 0 then
            v13[k] = v4
        end
    end
    local v19 = {}
    for i6, i7 in v16.Props do
        v19[i6 - 1] = i7.Type
    end
    v15 = {
        AddFloor = 0,
        FilterAny = false,
        Stream = v17,
        Clock = v18,
        NextId = Observability.FirstInstanceId,
        ClassIndex = v9,
        UnknownClassId = #v16.Classes,
        ClassProps = v10,
        ClassPropsByName = v11,
        ClassPolled = v12,
        ClassRefs = v13,
        PropTypes = v19,
        Ids = setmetatable({}, {__mode = "k"}),
        ById = setmetatable({}, {__mode = "v"}),
        ParentIds = setmetatable({}, {__mode = "k"}),
        Defaults = {},
        Copies = Copies.new(#v16.Classes),
        Resolvers = {},
        UntrackHandlers = {},
        FilterRoots = {},
        FilterNodes = setmetatable({}, {__mode = "k"}),
        FilteredSignals = setmetatable({}, {__mode = "k"}),
        Pins = {},
        PinCounts = setmetatable({}, {__mode = "k"}),
        StandIns = {},
    }
    local u92 = setmetatable(v15, u39)
    Codec.setRefLookup(function(a1) -- Line: 182 -- upvalues: u92 (val) -- types: a1: userdata
        return u92.Ids[a1]
    end)
    return u92
end

function u39.SetFilter(a1, a2, a3) -- Line: 189
    -- upvalues: buildFilter (val), u36 (val)
    local v1 = buildFilter(a3)
    a1.FilterRoots[a2] = v1
    if v1 then
        a1.FilterAny = true
    end
    local Terrain = if a2 ~= workspace then nil else workspace:FindFirstChildOfClass("Terrain")
    if Terrain and v1 then
        local Terrain_2 = v1.Children.Terrain
        if Terrain_2 == nil then
            a1.FilterRoots[Terrain] = if not v1.Include then nil else u36
            return
        end
        if Terrain_2.Marked then
            a1.FilterRoots[Terrain] = if not v1.Include then u36 else nil
            return
        end
        a1.FilterRoots[Terrain] = Terrain_2
    end
end

function u39.FilterRoot(a1, a2) -- Line: 210 -- types: a1: table, a2: userdata
    return a1.FilterRoots[a2]
end

function u39:MatchFilter(a2, a3) -- Line: 217
    -- upvalues: result (ref), u36 (val)
    if not self.FilterAny then
        return false, false
    end
    local v1 = a3 and (self.FilterRoots[a3] or self.FilterNodes[a3])
    local v2 = false
    local v3 = nil
    if v1 then
        local v4 = v1.Children[result(a2, "Name")]
        if not v1.Include then
            if v4 then
                if not v4.Marked then
                    v3 = v4
                else
                    v2 = true
                end
            end
        elseif v4 == nil then
            v2 = true
        elseif not v4.Marked then
            v3 = v4
        end
    end
    if self.Pins[a2] then
        v2 = false
        v3 = nil
    elseif v2 and self.PinCounts[a2] then
        v2 = false
        v3 = u36
    end
    v1 = self.FilterNodes[a2] ~= v3
    self.FilterNodes[a2] = v3
    return v2, v1
end

function u39.WatchFiltered(a1, a2, a3) -- Line: 250 -- types: a1: table, a2: userdata, a3: function
    if a1.FilteredSignals[a2] then
        return
    end
    a1.FilteredSignals[a2] = ((a2:GetPropertyChangedSignal("Name")):Connect(function() -- Line: 254 -- upvalues: a1 (val), a2 (val), a3 (val)
        local v1 = a1.FilteredSignals[a2]
        if v1 then
            v1:Disconnect()
            a1.FilteredSignals[a2] = nil
        end
        a3()
    end))
end

function u39.Rematch(a1, a2, a3, a4, a5) -- Line: 267
    -- upvalues: 
    local v1, v2, v3
    local v4, v5 = a1:MatchFilter(a2, a3)
    if v4 then
        return true
    end
    if not v5 then
        return false
    end
    v5 = {a2}
    local v6, v7, v8 = a4, a1, a5
    while #v5 > 0 do
        v4 = table.remove(v5)
        v3 = v6[v4]
        if v3 then
            for i in v3 do
                v1, v2 = v7:MatchFilter(i, v4)
                if v1 then
                    table.insert(v8, i)
                elseif v2 then
                    table.insert(v5, i)
                end
            end
        end
    end
    return false
end

local function unpinChain(a1, a2) -- Line: 298 -- types: a2: table
    local v1, v2
    local PinCounts = a1.PinCounts
    local v3 = nil
    local v4 = nil
    for i, j in a2, v3, v4 do
        v1 = (PinCounts[j] or 1) - 1
        v2 = if not (v1 > 0) then nil else v1
        PinCounts[j] = v2
    end
end

function u39.Pin(a1, a2) -- Line: 308 -- types: a1: table, a2: userdata
    local v1
    local v2 = a1.Pins[a2]
    if v2 then
        local v3, v4
        local PinCounts = a1.PinCounts
        v1 = nil
        local v5 = nil
        for i, j in v2, v1, v5 do
            v4 = (PinCounts[j] or 1) - 1
            v3 = if not (v4 > 0) then nil else v4
            PinCounts[j] = v3
        end
    end
    local v6 = {}
    local PinCounts_2 = a1.PinCounts
    local Parent = a2.Parent
    while Parent do
        if Parent == workspace or Parent == game then
            break
        end
        table.insert(v6, Parent)
        PinCounts_2[Parent] = (PinCounts_2[Parent] or 0) + 1
        Parent = Parent.Parent
    end
    a1.Pins[a2] = v6
    v1 = table.clone(v6)
    table.insert(v1, a2)
    if v2 then
        table.move(v2, 1, #v2, #v1 + 1, v1)
    end
    return v1
end

function u39.Unpin(a1, a2) -- Line: 331 -- types: a1: table, a2: userdata
    local v1, v2
    local v3 = a1.Pins[a2]
    if not v3 then
        return {}
    end
    local PinCounts = a1.PinCounts
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in v3, v4, v5 do
        v2 = (PinCounts[j] or 1) - 1
        v1 = if not (v2 > 0) then nil else v2
        PinCounts[j] = v1
    end
    v6.Pins[v7] = nil
    local v8 = table.clone(v3)
    table.insert(v8, v7)
    return v8
end

function u39.AddResolver(a1, a2) -- Line: 343 -- types: a1: table, a2: function
    table.insert(a1.Resolvers, a2)
end

function u39.OnUntracked(a1, a2) -- Line: 349 -- types: a1: table, a2: function
    table.insert(a1.UntrackHandlers, a2)
end

function u39.NotifyUntracked(a1, a2) -- Line: 353 -- types: a1: table, a2: userdata
    for i, j in a1.UntrackHandlers do
        j(a2)
    end
end

function u39:Resolve(a2, a3) -- Line: 360 -- types: self: table, a2: userdata, a3: number?
    local v1 = self.Ids[a2]
    if v1 then
        return v1
    end
    for i, j in self.Resolvers do
        v1 = j(a2, a3)
        if v1 then
            return v1
        end
    end
    return nil
end

function u39.ResolveRefs(a1, a2, a3, a4) -- Line: 376
    -- upvalues: result (ref)
    local err, success
    local v1 = a1.ClassRefs[a3]
    if not v1 then
        return
    end
    for i, j in v1 do
        success, err = pcall(result, a2, j.Name)
        if success and typeof(err) == "Instance" then
            a1:Resolve(err, a4)
        end
    end
end

function u39:Allocate(a2, a3) -- Line: 389 -- types: self: table, a2: userdata, a3: number
    local NextId = self.NextId
    self.NextId = self.NextId + 1
    self.Ids[a2] = NextId
    self.ById[NextId] = a2
    self.ParentIds[a2] = a3
    return NextId
end

function u39.Free(a1, a2) -- Line: 398 -- types: a1: table, a2: userdata
    local v1 = a1.Ids[a2]
    if v1 then
        a1.ById[v1] = nil
        a1.Copies:Forget(v1)
    end
    a1.Ids[a2] = nil
    a1.ParentIds[a2] = nil
end

function u39.StandIn(a1, a2) -- Line: 411 -- upvalues: Observability (val) -- types: a1: table, a2: userdata
    local Workspace = Observability.RootId.Workspace
    if a2 == workspace then
        return Workspace
    end
    local v1 = a1.StandIns[a2]
    if v1 then
        return v1
    end
    v1 = a1:Allocate(a2, Workspace)
    a1:AddTime((a1.Clock()))
    local W = a1.Stream.W
    a1.Copies:WriteHead(W, v1, Workspace, a1.UnknownClassId, a2.Name, false)
    W:u16(0)
    a1.Stream:EndRecord()
    a1.StandIns[a2] = v1
    return v1
end

function u39:AddTime(a2) -- Line: 432 -- types: self: table, a2: number?
    local AddFloor = self.AddFloor
    local v1 = math.max(a2 or self.Clock(), AddFloor)
    self.AddFloor = v1
    self.Stream:Time(v1)
    return v1
end

function u39.DefaultsFor(a1, a2) -- Line: 440
    -- upvalues: Op (val), Codec (val), result (ref), ValueType (val)
    local v1 = a1.Defaults[a2]
    if v1 ~= nil then
        return v1 or nil
    end
    v1 = a1.ClassIndex[a2]
    local v2 = a1.ClassProps[a2]
    local v3 = a1.ClassPolled[a2]
    local success, err = pcall(Instance.new, a2)
    if success and v1 then
        local err_2, success_2
        if not v2 and not v3 then
            if success then
                err:Destroy()
            end
            a1.Defaults[a2] = false
            return nil
        end
        local v4 = {}
        local W = a1.Stream.W
        W:u8(Op.Defaults)
        Codec.varuint(W, v1)
        local len = W.len
        W:u16(0)
        local v5 = 0
        local v6 = {v2 or {}, v3 or {}}
        local v7 = nil
        local v8 = nil
        local v9, v10 = a1, a2
        for i, j in v6, v7, v8 do
            for k, n in j do
                success_2, err_2 = pcall(result, err, n.Name)
                if success_2 and n.Type ~= ValueType.Ref then
                    v4[n.Id] = err_2
                    Codec.varuint(W, n.Id)
                    Codec.writeValue(W, n.Type, err_2)
                    v5 = v5 + 1
                end
            end
        end
        W:patchU16(len, v5)
        v9.Stream:EndRecord()
        err:Destroy()
        v9.Defaults[v10] = v4
        return v4
    end
    if success then
        err:Destroy()
    end
    a1.Defaults[a2] = false
    return nil
end

function u39:Destroy() -- Line: 483 -- upvalues: Codec (val)
    table.clear(self.Ids)
    table.clear(self.ById)
    table.clear(self.ParentIds)
    table.clear(self.Resolvers)
    table.clear(self.UntrackHandlers)
    for i, j in self.FilteredSignals do
        j:Disconnect()
    end
    table.clear(self.FilteredSignals)
    table.clear(self.FilterNodes)
    table.clear(self.FilterRoots)
    table.clear(self.Pins)
    table.clear(self.PinCounts)
    table.clear(self.StandIns)
    Codec.setRefLookup(function() -- Line: 498
        return nil
    end)
end

return u39