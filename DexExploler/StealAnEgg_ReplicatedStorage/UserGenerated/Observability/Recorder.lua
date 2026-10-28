-- Script path: ReplicatedStorage.UserGenerated.Observability.Recorder
-- Decompile time: 596.46 ms

local result
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies)
local Relevance = require(ReplicatedStorage.UserGenerated.Observability.Relevance)
local Sequences = require(ReplicatedStorage.UserGenerated.Observability.Sequences)
local Styles = require(ReplicatedStorage.UserGenerated.Observability.Styles)
local Op = Observability.Op
local ValueType = Observability.ValueType
local ShownBy = Relevance.ShownBy
_, result = xpcall(function() -- Line: 81
    return workspace[nil]
end, function() -- Line: 83
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 87
        return a1[a2]
    end
end
local u51 = {Image = true, ImageTransparency = true}
local u52 = {[ValueType.ColorSequence] = 250, [ValueType.NumberSequence] = 250}
local u58 = {
    BackgroundTransparency = true,
    TextTransparency = true,
    TextStrokeTransparency = true,
    ImageTransparency = true,
    GroupTransparency = true,
    Transparency = true,
    BackgroundColor3 = true,
    TextColor3 = true,
    ImageColor3 = true,
    Color = true,
    Visible = true,
}
local u59 = {
    [ValueType.Float32] = true,
    [ValueType.Float64] = true,
    [ValueType.UDim] = true,
    [ValueType.UDim2] = true,
    [ValueType.Vector2] = true,
    [ValueType.Vector3] = true,
    [ValueType.Color3] = true,
    [ValueType.Rect] = true,
    [ValueType.NumberRange] = true,
    [ValueType.ColorSequence] = true,
    [ValueType.NumberSequence] = true,
}
local u82 = {TextLabel = true, TextButton = true}

local function readProp(a1, a2, a3) -- Line: 157
    -- upvalues: u82 (val), result (ref), Styles (val)
    if a3 == "Text" and u82[a2] then
        local success = pcall(result, a1, "LocalizedText")
        return success
    end
    return Styles.Read(a1, a3)
end

local function isExcluded(a1) -- Line: 182 -- types: a1: userdata
    local v1 = a1:IsA("PVInstance")
    if not v1 then
        v1 = true
        if a1:FindFirstAncestorWhichIsA("PVInstance") == nil then
            v1 = a1:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil
        end
    end
    return v1
end

local function isWorldGui(a1) -- Line: 188 -- types: a1: userdata
    return a1:IsA("BillboardGui") or a1:IsA("SurfaceGui")
end

local u88 = {}
u88.__index = u88

function u88.new(a1, a2, a3) -- Line: 197
    -- upvalues: Players (val), Codec (val), u88 (val)
    local v1 = {
        PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui"),
        Registry = a1,
        RecordPlayerGui = a2,
        WorldGuis = a3,
        Stream = a1.Stream,
        ValueScratch = Codec.newWriter(256),
        Clock = a1.Clock,
        ClassIndex = a1.ClassIndex,
        UnknownClassId = a1.UnknownClassId,
        ClassProps = a1.ClassProps,
        ClassPropsByName = a1.ClassPropsByName,
        ClassPolled = a1.ClassPolled,
        PropTypes = a1.PropTypes,
        Ids = a1.Ids,
        ById = a1.ById,
        ParentIds = a1.ParentIds,
        Signals = setmetatable({}, {__mode = "k"}),
        Kids = setmetatable({}, {__mode = "k"}),
        Pending = {},
        PendingTime = {},
        PolledValues = setmetatable({}, {__mode = "k"}),
        Polling = setmetatable({}, {__mode = "k"}),
        PollNext = setmetatable({}, {__mode = "k"}),
        PollGap = setmetatable({}, {__mode = "k"}),
        PollSeen = setmetatable({}, {__mode = "k"}),
        PollHeld = setmetatable({}, {__mode = "k"}),
        Held = setmetatable({}, {__mode = "k"}),
        LastSent = setmetatable({}, {__mode = "k"}),
        Animating = setmetatable({}, {__mode = "k"}),
        SeqStates = setmetatable({}, {__mode = "k"}),
        SeqHolders = setmetatable({}, {__mode = "v"}),
        SentUDim2 = setmetatable({}, {__mode = "k"}),
        Defaults = a1.Defaults,
        DeferredParent = setmetatable({}, {__mode = "k"}),
        DeferredKids = setmetatable({}, {__mode = "k"}),
        DeferredSignals = setmetatable({}, {__mode = "k"}),
        WaitingRefs = setmetatable({}, {__mode = "k"}),
        OnChanged = setmetatable({}, {__mode = "k"}),
        StyledChecks = setmetatable({}, {__mode = "k"}),
        RicherRoots = setmetatable({}, {__mode = "k"}),
        RicherSignals = setmetatable({}, {__mode = "k"}),
        RicherQueued = setmetatable({}, {__mode = "k"}),
        DirtyStructure = {},
        DirtyName = {},
        DirtyProps = {},
        DirtyFirst = {},
        RecheckSubtree = {},
        RecheckChildren = {},
        Memo = nil,
        Connections = {},
        Destroyed = false,
    }
    local u165 = setmetatable(v1, u88)
    v1 = {}
    local v2 = nil
    local v3 = nil
    local v4 = a1
    for i, j in a1.ClassProps, v2, v3 do
        for k, n in j do
            v1[n.Id] = n
        end
    end
    u165.PropEntries = v1
    v4:AddResolver(function(a1, a2) -- Line: 296 -- upvalues: u165 (val) -- types: a1: userdata, a2: number?
        return u165:_track(a1, a2)
    end)
    v4:OnUntracked(function(a1) -- Line: 300 -- upvalues: u165 (val) -- types: a1: userdata
        local v1 = u165.Kids[a1]
        if v1 then
            for i in v1 do
                u165:_untrackTree(i, a1)
            end
        end
        u165:_undeferKids(a1)
    end)
    return u165
end

function u88:_inDomain(a2) -- Line: 314 -- types: self: table, a2: userdata
    local v1
    if a2:IsDescendantOf(self.PlayerGui) then
        local RecordPlayerGui = self.RecordPlayerGui
        if RecordPlayerGui then
            v1 = a2:IsA("PVInstance")
            if not v1 then
                v1 = true
                if a2:FindFirstAncestorWhichIsA("PVInstance") == nil then
                    v1 = a2:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil
                end
            end
            RecordPlayerGui = not v1
        end
        return RecordPlayerGui
    end
    if not self.WorldGuis then
        return false
    end
    v1 = a2:IsA("BillboardGui") or a2:IsA("SurfaceGui")
    local v2 = if not v1 then a2:FindFirstAncestorWhichIsA("LayerCollector") else a2
    v1 = false
    if v2 ~= nil then
        v1 = (v2:IsA("BillboardGui") or v2:IsA("SurfaceGui")) and not a2:IsA("PVInstance") and v2:IsDescendantOf(workspace) and a2:FindFirstAncestorWhichIsA("ViewportFrame") == nil
    end
    return v1
end

local function kidsOf(a1, a2) -- Line: 329 -- types: a2: userdata
    local v1 = a1.Kids[a2]
    if not v1 then
        v1 = setmetatable({}, {__mode = "k"})
        a1.Kids[a2] = v1
    end
    return v1
end

function u88._watchChildren(a1, a2, a3) -- Line: 339 -- types: a1: table, a2: userdata, a3: table
    local function mark(a1_2) -- Line: 340 -- upvalues: a1 (val) -- types: a1_2: userdata
        a1.DirtyStructure[a1_2] = (a1.Clock())
    end

    table.insert(a3, (a2.ChildAdded:Connect(mark)))
    table.insert(a3, (a2.ChildRemoved:Connect(mark)))
end

function u88:_queueChildren(a2, a3) -- Line: 349 -- types: self: table, a2: userdata, a3: number
    local Children = a2:GetChildren()
    local Pending = self.Pending
    local PendingTime = self.PendingTime
    for i = #Children, 1, -1 do
        table.insert(Pending, Children[i])
        table.insert(PendingTime, a3)
    end
end

function u88:_drain(a2) -- Line: 360 -- upvalues: Relevance (val) -- types: self: table, a2: number?
    local v1, v2, v3
    local Pending = self.Pending
    local PendingTime = self.PendingTime
    if #Pending == 0 then
        return true
    end
    if self.Memo == nil then
        self.Memo = Relevance.NewMemo()
    end
    local v4 = true
    local v5 = a2
    while #Pending > 0 do
        if v5 and v5 <= os.clock() then
            v4 = false
            break
        end
        v2 = table.remove(Pending)
        v3 = table.remove(PendingTime)
        v6:_track(v2, v3)
    end
    if v1 then
        v6.Memo = nil
    end
    return v4
end

function u88:_parentId(a2, a3) -- Line: 386 -- upvalues: result (ref) -- types: self: table, a2: userdata, a3: number?
    local v1 = result(a2, "Parent")
    if v1 == self.PlayerGui then
        return 0
    end
    if v1 == nil then
        return nil
    end
    return self.Ids[v1] or self.Registry:Resolve(v1, a3)
end

function u88:_track(a2, a3) -- Line: 401
    -- upvalues: result (ref), Observability (val), Relevance (val), kidsOf (val), ShownBy (val), u82 (val)
    -- upvalues: Styles (val), Sequences (val), ValueType (val), Copies (val), Codec (val), u51 (val)
    local v1, v2, v3, v4, v5
    local v6 = self.Ids[a2]
    if v6 then
        return v6
    end
    v6 = result(a2, "ClassName")
    if v6 == "StyleLink" then
        v4 = result(a2, "Parent")
        if v4 and self.Signals[v4] and result(v4, "ClassName") == "TextLabel" then
            self:_refreshRicher(v4)
        end
        return nil
    end
    if not self.ClassProps[v6] and not self.ClassPolled[v6] and v6 ~= "Folder" then
        return nil
    end
    if Observability.IsAudio(a2) or not self:_inDomain(a2) then
        return nil
    end
    v4 = self:_parentId(a2, a3)
    if v4 == nil then
        return nil
    end
    local v7 = result(a2, "Parent")
    if self.Registry:MatchFilter(a2, v7) then
        self:_watchFiltered(a2)
        return nil
    end
    self:_markRicher(a2, false)
    local Memo = self.Memo
    local v8 = Relevance.IsHidden(a2, self.PlayerGui, Memo)
    if v8 and Relevance.SubtreeHidden(a2, self.PlayerGui) then
        v5 = self.DeferredSignals[a2] ~= nil
        if self.DeferredParent[a2] ~= v7 or v5 ~= Relevance.HidesSubtree(a2) then
            self:_undefer(a2)
            self:_defer(a2, v7)
        end
        return nil
    end
    self:_undefer(a2)
    self.Registry:ResolveRefs(a2, v6, a3)
    if self.Ids[a2] then
        return self.Ids[a2]
    end
    v5 = self.Registry:Allocate(a2, v4)
    local v9 = kidsOf(self, v7)
    v9[a2] = true
    v7 = self.Registry:AddTime(a3)
    v9 = self.WaitingRefs[a2]
    if v9 then
        self.WaitingRefs[a2] = nil
        v1 = nil
        v2 = nil
        for i, j in v9, v1, v2 do
            if self.Ids[i] then
                for k in j do
                    self:_markDirty(i, k, v7)
                end
            end
        end
    end
    v9 = self.Registry:DefaultsFor(v6)
    local v10 = if not v8 then Relevance.Suppressed(a2, Memo) else nil
    local W = self.Stream.W
    v1, v2 = self.Registry.Copies:WriteHead(W, v5, v4, self.ClassIndex[v6] or self.UnknownClassId, result(a2, "Name"), not v8)
    local Ids = self.Ids
    local v11 = nil
    local v12 = self.ClassProps[v6]
    local u763 = self.ClassPolled[v6]
    local len = W.len
    W:u16(0)
    local v13 = 0
    if v12 then
        local Name, err, success, v14, v15, v16
        local v17 = nil
        local v18 = nil
        for n, m in v12, v17, v18 do
            Name = m.Name
            if not v8 or ShownBy[Name] then
                if not v10 or not v10[Name] then
                    if Name ~= "Text" or not u82[v6] then
                        v15, v16 = Styles.Read(a2, Name)
                        v3 = v15
                        v14 = v16
                    else
                        success, err = pcall(result, a2, "LocalizedText")
                        v3 = success
                        v14 = err
                    end
                    if v3 then
                        if Sequences.Types[m.Type] then
                            self:_setSequence(a2, m.Id, Sequences.keypoints(m.Type, v14), v7)
                        end
                        v3 = if m.Type ~= ValueType.Ref then v14 else Copies.refValue(if typeof(v14) ~= "Instance" then nil else Ids[v14], v5)
                        if m.Type == ValueType.Ref and typeof(v14) == "Instance" and not Ids[v14] then
                            self:_waitRef(v14, a2, m.Id)
                        end
                        if Copies.differs(v1, v2, v9, m.Id, v14, v3) then
                            Codec.varuint(W, m.Id)
                            Codec.writeValue(W, m.Type, v14)
                            v13 = v13 + 1
                        end
                    end
                else
                    v11 = v11 or {}
                    v11[m.Id] = true
                end
            end
        end
    end
    if u763 then
        local v19
        v12 = {}
        for i5, i6 in u763 do
            v19, v3 = Styles.Read(a2, i6.Name)
            if v19 then
                v12[i6.Id] = v3
                if Copies.differs(v1, v2, v9, i6.Id, v3, v3) then
                    Codec.varuint(W, i6.Id)
                    Codec.writeValue(W, i6.Type, v3)
                    v13 = v13 + 1
                end
            end
        end
        self.PolledValues[a2] = v12
        if v8 then
            self.PollHeld[a2] = true
        elseif not v10 or not v10.IsLoaded then
            self:_armPoll(a2)
        else
            self.PollHeld[a2] = true
        end
    end
    W:patchU16(len, v13)
    self.Stream:EndRecord()
    if v8 then
        self.Held[a2] = true
    elseif v11 then
        self.Held[a2] = v11
    end
    local u689 = Relevance.IsLayout(a2)
    if u689 and a2.Parent then
        self.RecheckChildren[a2.Parent] = v7
    end
    local u709 = self.ClassPropsByName[v6]
    local u728 = a2:IsA("BillboardGui")
    if not u728 then
        u728 = a2:IsA("SurfaceGui")
    end
    if u728 then
        u728 = not a2:IsDescendantOf(self.PlayerGui)
    end
    v2 = {}
    self.Signals[a2] = v2
    if v6 ~= "ViewportFrame" then
        self:_watchChildren(a2, v2)
        self:_queueChildren(a2, v7)
    end

    local function changed(a1) -- Line: 565
        -- upvalues: self (val), a2 (val), u728 (val), u709 (val), ShownBy (upval), u763 (val), u51 (upval), u689 (val)
        if a1 == "Name" then
            self.DirtyName[a2] = (self.Clock())
            if self.Registry.FilterAny then
                self.DirtyStructure[a2] = (self.Clock())
            end
            self:_renamedRicher(a2)
            return
        end
        if a1 == "Parent" and u728 then
            self.DirtyStructure[a2] = (self.Clock())
            return
        end
        if u709 then
            local v1 = if a1 ~= "LocalizedText" then a1 else "Text"
            local v2 = u709[v1]
            if v2 and not ShownBy[v1] and self.Held[a2] == true then
                if u763 and u51[v1] and not self.Polling[a2] then
                    self.PollHeld[a2] = true
                    return
                end
                return
            end
            if v2 then
                local v3 = self.Clock()
                local v4 = self.DirtyProps[a2]
                if not v4 then
                    self.DirtyProps[a2] = {}
                end
                v4[v2] = v3
                v4 = self.DirtyFirst[a2]
                if not v4 then
                    self.DirtyFirst[a2] = {}
                end
                if v4[v2] == nil then
                    v4[v2] = v3
                end
                if u763 and u51[v1] then
                    self:_armPoll(a2)
                end
                if ShownBy[v1] then
                    self.RecheckSubtree[a2] = v3
                    return
                end
                if u689 and v1 == "SortOrder" and a2.Parent then
                    self.RecheckChildren[a2.Parent] = v3
                end
            end
        end
    end

    table.insert(v2, (a2.Changed:Connect(changed)))
    self.OnChanged[a2] = changed
    self:_watchStyled(a2, v6, true)
    return v5
end

function u88:_watchStyled(a2, a3, a4) -- Line: 627
    -- upvalues: Styles (val), u82 (val), result (ref)
    local v1 = self.StyledChecks[a2]
    if v1 then
        return v1
    end
    local u64 = Styles.Affected[a2]
    local u71 = self.OnChanged[a2]
    local v2 = self.Signals[a2]
    if u64 and u71 and v2 then
        local u13 = {}
        if a4 then
            local err, success, v3, v4, v5, v6
            local v7 = nil
            local v8 = nil
            for i in u64, v7, v8 do
                if i ~= "Text" or not u82[a3] then
                    v5, v6 = Styles.Read(a2, i)
                    v3 = v5
                    v4 = v6
                else
                    success, err = pcall(result, a2, "LocalizedText")
                    v3 = success
                    v4 = err
                end
                if v3 then
                    u13[i] = v4
                end
            end
        end

        local function check() -- Line: 647
            -- upvalues: u64 (val), a2 (val), a3 (val), u82 (upval), result (upval), Styles (upval), u13 (val)
            -- upvalues: u71 (val)
            local err, success, v1, v2, v3, v4, v5
            local v6 = nil
            local v7 = nil
            for i in u64, v6, v7 do
                v4 = a2
                if i ~= "Text" or not u82[a3] then
                    v5, v1 = Styles.Read(v4, i)
                    v2 = v5
                    v3 = v1
                else
                    success, err = pcall(result, v4, "LocalizedText")
                    v2 = success
                    v3 = err
                end
                if v2 and v3 ~= u13[i] then
                    u13[i] = v3
                    u71(i)
                end
            end
        end

        self.StyledChecks[a2] = check
        table.insert(v2, (a2.StyledPropertiesChanged:Connect(function() -- Line: 659 -- upvalues: self (val), a2 (val), check (val)
            self:_markRicher(a2, false)
            check()
        end)))
        return check
    end
    return nil
end

function u88:_richerRoot(a2) -- Line: 669 -- upvalues: result (ref) -- types: self: table, a2: userdata
    local v1
    local RicherRoots = self.RicherRoots
    if next(RicherRoots) == nil then
        return nil, nil
    end
    local v2 = result(a2, "Parent")
    for i = 1, 3 do
        if v2 == nil then
            return nil, nil
        end
        v1 = RicherRoots[v2]
        if v1 then
            if v1.Depth < i then
                return nil, nil
            end
            return v2, v1
        end
        result(v2, "Parent")
    end
    return nil, nil
end

function u88:_markRicher(a2, a3) -- Line: 693 -- upvalues: Styles (val) -- types: self: table, a2: userdata, a3: boolean
    local v1, v2 = self:_richerRoot(a2)
    if v1 and Styles.MarkRicher(a2, v1, v2, self.ClassPropsByName) and a3 then
        self:_restyle(a2)
    end
end

function u88:_restyle(a2) -- Line: 702 -- upvalues: result (ref) -- types: self: table, a2: userdata
    local v1 = self:_watchStyled(a2, result(a2, "ClassName"), false)
    if v1 then
        v1()
    end
end

function u88:_markRicherBelow(a2, a3, a4, a5) -- Line: 710
    -- upvalues: Styles (val)
    local v1
    local v2 = self.Kids[a2]
    if not v2 then
        return
    end
    local v3 = nil
    local v4 = nil
    local v5, v6, v7 = a3, a4, self
    for i in v2, v3, v4 do
        if Styles.MarkRicher(i, v5, v6, v7.ClassPropsByName) then
            v7:_restyle(i)
        end
        if v8 > 1 then
            v1 = v8 - 1
            v7:_markRicherBelow(i, v5, v6, v1)
        end
    end
end

function u88:_renamedRicher(a2) -- Line: 727 -- types: self: table, a2: userdata
    local v1, v2 = self:_richerRoot(a2)
    if not v1 then
        return
    end
    self:_markRicher(a2, true)
    self:_markRicherBelow(a2, v1, v2, 2)
end

function u88:_refreshRicher(a2) -- Line: 739 -- upvalues: Styles (val) -- types: self: table, a2: userdata
    local v1 = self.RicherSignals[a2]
    if v1 then
        for i, j in v1 do
            j:Disconnect()
        end
    end
    v1 = {}
    self.RicherSignals[a2] = v1

    local function again() -- Line: 748 -- upvalues: self (val), a2 (val)
        self:_queueRicher(a2)
    end

    local StyleLink = a2:FindFirstChildWhichIsA("StyleLink")
    local v2 = nil
    if StyleLink then
        table.insert(v1, ((StyleLink:GetPropertyChangedSignal("StyleSheet")):Connect(again)))
        table.insert(v1, (StyleLink.AncestryChanged:Connect(again)))
        local StyleSheet = StyleLink.StyleSheet
        if StyleSheet then
            table.insert(v1, (StyleSheet.DescendantAdded:Connect(again)))
        end
        local v3, v4 = Styles.Richer(StyleLink)
        v2 = v3
        for k, n in v4 do
            table.insert(v1, ((n:GetPropertyChangedSignal("Selector")):Connect(again)))
        end
    end
    self.RicherRoots[a2] = v2
    if v2 then
        self:_markRicherBelow(a2, a2, v2, v2.Depth)
    end
end

function u88:_queueRicher(a2) -- Line: 774 -- types: self: table, a2: userdata
    if self.RicherQueued[a2] then
        return
    end
    self.RicherQueued[a2] = true
    task.defer(function() -- Line: 779 -- upvalues: self (val), a2 (val)
        self.RicherQueued[a2] = nil
        if not self.Destroyed and self.Signals[a2] then
            self:_refreshRicher(a2)
        end
    end)
end

function u88:_stopRicher(a2) -- Line: 787 -- types: self: table, a2: userdata
    self.RicherRoots[a2] = nil
    self.RicherQueued[a2] = nil
    local v1 = self.RicherSignals[a2]
    if v1 then
        for i, j in v1 do
            j:Disconnect()
        end
        self.RicherSignals[a2] = nil
    end
end

function u88:_watchFiltered(a2) -- Line: 800 -- types: self: table, a2: userdata
    self.Registry:WatchFiltered(a2, function() -- Line: 801 -- upvalues: self (val), a2 (val)
        if not self.Destroyed then
            self.DirtyStructure[a2] = (self.Clock())
        end
    end)
end

function u88:_defer(a2, a3) -- Line: 811
    -- upvalues: Relevance (val), Styles (val)
    self.DeferredParent[a2] = a3
    local v1 = self.DeferredKids[a3]
    if not v1 then
        v1 = setmetatable({}, {__mode = "k"})
        self.DeferredKids[a3] = v1
    end
    v1[a2] = true
    if not Relevance.HidesSubtree(a2) then
        return
    end

    local function retry() -- Line: 822 -- upvalues: self (val), a2 (val)
        if not self.Destroyed then
            self.DirtyStructure[a2] = (self.Clock())
        end
    end

    local v2 = {}
    local v3 = Styles.Affected[a2]
    for i, j in Relevance.ShownByOf(a2) do
        table.insert(v2, ((a2:GetPropertyChangedSignal(j)):Connect(retry)))
        if v3 and v3[j] then
            table.insert(v2, (a2.StyledPropertiesChanged:Connect(retry)))
        end
    end
    self.DeferredSignals[a2] = v2
end

function u88:_undefer(a2) -- Line: 839 -- types: self: table, a2: userdata
    local v1 = self.DeferredParent[a2]
    if v1 == nil then
        return
    end
    self.DeferredParent[a2] = nil
    local v2 = self.DeferredKids[v1]
    if v2 then
        v2[a2] = nil
    end
    v2 = self.DeferredSignals[a2]
    if v2 then
        for i, j in v2 do
            j:Disconnect()
        end
        self.DeferredSignals[a2] = nil
    end
end

function u88:_undeferKids(a2) -- Line: 858 -- types: self: table, a2: userdata
    local v1 = self.DeferredKids[a2]
    if v1 then
        for i in v1 do
            self:_undefer(i)
        end
        self.DeferredKids[a2] = nil
    end
end

function u88:_waitRef(a2, a3, a4) -- Line: 869 -- types: self: table, a2: userdata, a3: userdata, a4: number
    local v1 = self.WaitingRefs[a2]
    if not v1 then
        v1 = setmetatable({}, {__mode = "k"})
        self.WaitingRefs[a2] = v1
    end
    local v2 = v1[a3]
    if not v2 then
        v1[a3] = {}
    end
    v2[a4] = true
end

function u88:_markDirty(a2, a3, a4) -- Line: 883 -- types: self: table, a2: userdata, a3: number, a4: number
    local v1 = self.DirtyProps[a2]
    if not v1 then
        self.DirtyProps[a2] = {}
    end
    v1[a3] = a4
end

function u88:_armPoll(a2) -- Line: 893 -- types: self: table, a2: userdata
    self.Polling[a2] = os.clock() + 0.5
    self.PollNext[a2] = nil
    self.PollGap[a2] = nil
    self.PollSeen[a2] = nil
    self.PollHeld[a2] = nil
end

function u88:_stopPoll(a2) -- Line: 901 -- types: self: table, a2: userdata
    self.Polling[a2] = nil
    self.PollNext[a2] = nil
    self.PollGap[a2] = nil
    self.PollSeen[a2] = nil
end

function u88:_untrack(a2) -- Line: 908 -- types: self: table, a2: userdata
    self.Registry:Free(a2)
    self:_undeferKids(a2)
    self.DirtyProps[a2] = nil
    self.DirtyFirst[a2] = nil
    self.DirtyName[a2] = nil
    self.PolledValues[a2] = nil
    self:_stopPoll(a2)
    self.PollHeld[a2] = nil
    self.Held[a2] = nil
    self.LastSent[a2] = nil
    self.Animating[a2] = nil
    self.SentUDim2[a2] = nil
    self.OnChanged[a2] = nil
    self.StyledChecks[a2] = nil
    self:_stopRicher(a2)
    local v1 = self.SeqStates[a2]
    if v1 then
        for i, j in v1 do
            if self.SeqHolders[j.Key] == a2 then
                self.SeqHolders[j.Key] = nil
            end
        end
        self.SeqStates[a2] = nil
    end
    v1 = self.Signals[a2]
    if v1 then
        for k, n in v1 do
            n:Disconnect()
        end
        self.Signals[a2] = nil
    end
end

function u88:_untrackTree(a2, a3) -- Line: 944 -- types: self: table, a2: userdata, a3: userdata?
    local v1, v2, v3
    if a3 then
        v1 = self.Kids[a3]
        if v1 then
            v1[a2] = nil
        end
    end
    v1 = {}
    v1[1] = a2
    local v4 = self
    while #v1 > 0 do
        v2 = table.remove(v1)
        v3 = v4.Kids[v2]
        if v3 then
            for i in v3 do
                table.insert(v1, i)
            end
            v4.Kids[v2] = nil
        end
        v4:_untrack(v2)
    end
end

function u88:_setSequence(a2, a3, a4, a5) -- Line: 965
    -- upvalues: Sequences (val)
    local v1 = self.SeqStates[a2]
    if not v1 then
        self.SeqStates[a2] = {}
    end
    local v2 = v1[a3]
    if v2 and self.SeqHolders[v2.Key] == a2 then
        self.SeqHolders[v2.Key] = nil
    end
    v2 = ("%*:%*"):format(a3, (Sequences.key(a4)))
    v1[a3] = {Keypoints = a4, Key = v2, Time = a5}
    self.SeqHolders[v2] = a2
end

function u88:_writeSequence(a2) -- Line: 983
    -- upvalues: Sequences (val), Op (val), Codec (val)
    local Inst = a2.Inst
    local Id = a2.Id
    local PropId = a2.PropId
    local Type = a2.Type
    local T = a2.T
    local v1 = Sequences.keypoints(Type, a2.Value)
    local v2 = if not a2.LerpMs then 0 else math.clamp(math.round(a2.LerpMs / 10), 1, 255)
    local Stream = self.Stream
    Stream:Time(T)
    local W = Stream.W
    local v3 = self.SeqStates[Inst]
    local v4 = v3 and v3[PropId]
    local v5 = nil
    local v6 = nil
    if v4 then
        local v7, v8 = Sequences.findShift(v4.Keypoints, v1, Type)
        v5 = v7
        v6 = v8
    end
    if v5 and v6 then
        Sequences.writeShift(W, Id, PropId, v2, Type, v5, v6)
        Stream:EndRecord()
        self:_setSequence(Inst, PropId, v6, T)
        return
    end
    v6 = self.SeqHolders[("%*:%*"):format(PropId, (Sequences.key(v1)))]
    v5 = v6
    if v5 then
        v5 = false
        if v6 ~= Inst then
            v5 = self.Ids[v6]
        end
    end
    v4 = v5 and self.SeqStates[v6]
    v6 = v4 and v4[PropId]
    if v5 and v6 and v6.Time <= T then
        Sequences.writeCopy(W, Id, PropId, v2, v5)
        Stream:EndRecord()
        self:_setSequence(Inst, PropId, v6.Keypoints, T)
        return
    end
    if not a2.LerpMs then
        W:u8(Op.Prop)
        Codec.varuint(W, Id)
        Codec.varuint(W, PropId)
    else
        W:u8(Op.PropLerp)
        Codec.varuint(W, Id)
        Codec.varuint(W, PropId)
        W:u8(v2)
    end
    Codec.writeValue(W, Type, a2.Value)
    Stream:EndRecord()
    self:_setSequence(Inst, PropId, v1, T)
end

function u88:_layoutMoved(a2, a3, a4) -- Line: 1032
    -- upvalues: Relevance (val)
    if not Relevance.IsLayout(a2) then
        return
    end
    local v1 = a3 and self.ById[a3]
    if v1 then
        self.RecheckChildren[v1] = a4
    end
    if a2.Parent then
        self.RecheckChildren[a2.Parent] = a4
    end
end

function u88.IdOf(a1, a2) -- Line: 1045 -- types: a1: table, a2: userdata?
    if a2 == nil then
        return nil
    end
    return a1.Ids[a2] or a1:_track(a2)
end

function u88.StartWorld(a1) -- Line: 1055 -- upvalues: result (ref)
    local Name, err, success, v1, v2, v3, v4
    a1.WorldGuis = true
    local v5 = a1.Clock()
    local v6 = nil
    local v7 = nil
    local v8 = a1
    for i in a1.Signals, v6, v7 do
        v4 = a1.Registry.ClassRefs[result(i, "ClassName")]
        if v4 then
            v1 = nil
            v2 = nil
            for j, k in v4, v1, v2 do
                v3 = result
                Name = k.Name
                success, err = pcall(v3, i, Name)
                if success and typeof(err) == "Instance" and not v8.Ids[err] then
                    v3 = v8.DirtyProps[i]
                    if not v3 then
                        v8.DirtyProps[i] = {}
                    end
                    v3[k.Id] = v5
                end
            end
        end
    end
end

function u88.Snapshot(a1) -- Line: 1082
    if not a1.RecordPlayerGui then
        return
    end
    local PlayerGui = a1.PlayerGui
    a1:_watchChildren(PlayerGui, a1.Connections)
    a1:_queueChildren(PlayerGui, (a1.Clock()))
    while true do
        if a1:_drain((os.clock()) + 0.002) then
            break
        end
        task.wait()
        if a1.Destroyed then
            return
        end
    end
end

function u88.Flush(a1) -- Line: 1098
    -- upvalues: Relevance (val), result (ref), Op (val), Codec (val), kidsOf (val), ShownBy (val), u52 (val), u82 (val)
    -- upvalues: Styles (val), u59 (val), Sequences (val), ValueType (val), u58 (val)
    local Encoded, Id, Ids_2, Name, W_2, W_3, W_4, W_5, err, success, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42
    local Stream = a1.Stream
    local W = Stream.W
    local Ids = a1.Ids
    local PlayerGui = a1.PlayerGui
    local v43 = a1.Clock()
    local v44 = Relevance.NewMemo()
    a1.Memo = v44
    local DirtyStructure = a1.DirtyStructure
    a1.DirtyStructure = {}
    local v45 = {}
    local v46 = {}
    local Signals = a1.Signals
    local Registry = a1.Registry
    local v47 = {}
    local v48 = nil
    local v49 = nil
    for i28 in DirtyStructure, v48, v49 do
        v5 = a1.DeferredParent[i28]
        if v5 and v5 ~= result(i28, "Parent") then
            a1:_undefer(i28)
        end
        v5 = Ids[i28]
        if v5 and Signals[i28] then
            v7 = result(i28, "Parent")
            if v7 == nil then
                v45[v5] = true
                table.insert(v46, i28)
            elseif v7 == PlayerGui then
                if not a1:_inDomain(i28) then
                    v45[v5] = true
                    table.insert(v46, i28)
                elseif Registry.FilterAny then
                    v8 = {}
                    v12 = a1.Kids
                    if Registry:Rematch(i28, v7, v12, v8) then
                        table.insert(v8, i28)
                    end
                    for i29, i30 in v8 do
                        v47[i30] = DirtyStructure[i28]
                    end
                end
            elseif not Ids[v7] or not a1:_inDomain(i28) then
                v45[v5] = true
                table.insert(v46, i28)
            elseif Registry.FilterAny then
                v8 = {}
                v12 = a1.Kids
                if Registry:Rematch(i28, v7, v12, v8) then
                    table.insert(v8, i28)
                end
                for i31, i32 in v8 do
                    v47[i32] = DirtyStructure[i28]
                end
            end
        end
    end
    for i33 in v47 do
        v45[Ids[i33]] = true
        table.insert(v46, i33)
        a1:_watchFiltered(i33)
    end
    v48 = nil
    v49 = nil
    for i34, i35 in v46, v48, v49 do
        v2 = Ids[i35]
        if v2 then
            v1 = a1.ParentIds[i35]
            v5 = DirtyStructure[i35] or v47[i35]
            if not v45[v1] then
                Stream:Time(v5)
                v6 = Stream.W
                v6:u8(Op.Remove)
                Codec.varuint(v6, v2)
                Stream:EndRecord()
            end
            a1:_layoutMoved(i35, v1, v5)
            v10 = if v1 ~= 0 then a1.ById[v1] else PlayerGui
            a1:_untrackTree(i35, v10)
        end
    end
    v47 = {}
    v48 = nil
    v49 = nil
    for i36 in DirtyStructure, v48, v49 do
        if not Ids[i36] then
            if a1:_inDomain(i36) then
                table.insert(v47, i36)
            end
        elseif Signals[i36] and a1:_inDomain(i36) then
            table.insert(v47, i36)
        end
    end
    table.sort(v47, function(a1, a2) -- Line: 1173 -- upvalues: DirtyStructure (val)
        return DirtyStructure[a1] < DirtyStructure[a2]
    end)
    local v50 = os.clock() + 0.002
    a1:_drain(v50)
    v46 = {}
    v48 = nil
    v49 = nil
    for i37, i38 in v47, v48, v49 do
        v45 = DirtyStructure[i38]
        v5 = Ids[i38]
        if v5 then
            v7 = a1:_parentId(i38, v45)
            a1:_drain(v50)
            v8 = a1.ParentIds[i38]
            if v7 ~= nil and v7 ~= v8 then
                a1.ParentIds[i38] = v7
                v9 = if v8 ~= 0 then a1.ById[v8] else PlayerGui
                v10 = v9 and a1.Kids[v9]
                if v10 then
                    v10[i38] = nil
                end
                v11 = kidsOf(a1, result(i38, "Parent"))
                v11[i38] = true
                Stream:Time((math.max(v45, a1.Registry.AddFloor)))
                v6 = Stream.W
                v6:u8(Op.Reparent)
                Codec.varuint(v6, v5)
                Codec.varuint(v6, v7)
                Stream:EndRecord()
                a1.RecheckSubtree[i38] = v45
                a1:_layoutMoved(i38, v8, v45)
            end
        else
            if a1:_track(i38, v45) then
                v46[i38] = true
            end
            a1:_drain(v50)
        end
    end
    local DirtyName = a1.DirtyName
    a1.DirtyName = {}
    for i39, i40 in DirtyName do
        v50 = Ids[i39]
        if v50 and not v46[i39] then
            Stream:Time(i40)
            W_5 = Stream.W
            W_5:u8(Op.Rename)
            Codec.varuint(W_5, v50)
            Codec.str(W_5, i39.Name)
            Stream:EndRecord()
        end
    end
    local Held = a1.Held
    local PollHeld = a1.PollHeld
    local PollSeen = a1.PollSeen
    local u3208 = {}

    local function recheck(a1_2, a2) -- Line: 1232
        -- upvalues: PollHeld (val), a1 (val), PollSeen (val), Held (val), Ids (val), u3208 (val)
        if not PollHeld[a1_2] then
            PollSeen[a1_2] = nil
        else
            a1:_armPoll(a1_2)
        end
        if Held[a1_2] and Ids[a1_2] then
            if not a1.DirtyProps[a1_2] then
                a1.DirtyProps[a1_2] = {}
            end
            u3208[a1_2] = (math.max(u3208[a1_2] or 0, a2))
        end
    end

    local Kids = a1.Kids
    local DeferredKids = a1.DeferredKids
    local Pending = a1.Pending
    local PendingTime = a1.PendingTime
    v9 = {}
    local RecheckSubtree = a1.RecheckSubtree
    a1.RecheckSubtree = {}
    local v51 = nil
    v12 = nil
    for i41, i42 in RecheckSubtree, v51, v12 do
        if result(i41, "Parent") then
            table.insert(v9, i41)
            while #v9 > 0 do
                v13 = table.remove(v9)
                recheck(v13, i42)
                if not Relevance.HidesSubtree(v13) then
                    v14 = Kids[v13]
                    if v14 then
                        for i43 in v14 do
                            table.insert(v9, i43)
                        end
                    end
                    v14 = DeferredKids[v13]
                    if v14 then
                        for i44 in v14 do
                            table.insert(Pending, i44)
                            table.insert(PendingTime, i42)
                        end
                    end
                end
            end
        end
    end
    local RecheckChildren = a1.RecheckChildren
    a1.RecheckChildren = {}
    v51 = nil
    v12 = nil
    for i45, i46 in RecheckChildren, v51, v12 do
        for i47, i48 in i45:GetChildren() do
            recheck(i48, i46)
        end
    end
    local DirtyProps = a1.DirtyProps
    a1.DirtyProps = {}
    local DirtyFirst = a1.DirtyFirst
    a1.DirtyFirst = {}
    local PropTypes = a1.PropTypes
    local ClassProps = a1.ClassProps
    local LastSent = a1.LastSent
    local Animating = a1.Animating
    local SentUDim2 = a1.SentUDim2
    local PropEntries = a1.PropEntries
    v51 = {}
    v12 = {}
    local v52 = {}
    local v53 = {}
    local ValueScratch = a1.ValueScratch
    local v54 = nil
    local v55 = nil
    for i49, i50 in DirtyProps, v54, v55 do
        v15 = Ids[i49]
        if v15 and not v46[i49] then
            v16 = result(i49, "ClassName")
            v17 = ClassProps[v16]
            if v17 then
                v18 = Held[i49]
                v19 = v18 == true
                v20 = if type(v18) ~= "table" then nil else v18
                v21 = Relevance.IsHidden(i49, PlayerGui, v44)
                v22 = if not v21 then Relevance.Suppressed(i49, v44) else nil
                v23 = a1.Defaults[v16] or nil
                v24 = DirtyFirst[i49]
                v25 = Animating[i49]
                v26 = nil
                v27 = u3208[i49]
                if not v27 then
                    for i51, i52 in i50 do
                        v27 = math.max(v27 or 0, i52)
                    end
                end
                v28 = v17
                if v18 == nil then
                    table.clear(v51)
                    for i53 in i50 do
                        table.insert(v51, PropEntries[i53])
                    end
                    v28 = v51
                end
                v29 = v28
                v30 = nil
                v31 = nil
                for i54, i55 in v29, v30, v31 do
                    Id = i55.Id
                    Name = i55.Name
                    v32 = i50[Id]
                    v33 = v32 ~= nil
                    if not v19 then
                        v34 = false
                        if v20 ~= nil then
                            v34 = v20[Id] == true
                        end
                    else
                        v34 = not ShownBy[Name]
                    end
                    if v33 or v34 then
                        if not v21 then
                            if not v22 or not v22[Name] then
                                v35 = u52[i55.Type]
                                v36 = v35 and LastSent[i49]
                                if not v33 or not v36 or not v36[Id] or not (v43 - v36[Id] < v35) then
                                    if Name ~= "Text" or not u82[v16] then
                                        v39, v40 = Styles.Read(i49, Name)
                                        v37 = v39
                                        v38 = v40
                                    else
                                        success, err = pcall(result, i49, "LocalizedText")
                                        v37 = success
                                        v38 = err
                                    end
                                    if v37 then
                                        if v20 then
                                            v20[Id] = nil
                                        end
                                        if not v19 or v33 or not v23 or v23[Id] ~= v38 then
                                            v37 = v32 or v43
                                            if v34 then
                                                v37 = math.max(v37, v27 or v43)
                                            end
                                            v32 = nil
                                            if v33 and not v34 and u59[i55.Type] then
                                                v39 = v25 and v25[Id]
                                                v40 = v24 and v24[Id]
                                                if not v39 then
                                                    if v40 and v40 < v37 then
                                                        v32 = v37 - v40 + 16.666666666666668
                                                    end
                                                elseif v37 - v39 <= 300 + (v35 or 0) then
                                                    v32 = v37 - v39
                                                elseif v40 and v40 < v37 then
                                                    v32 = v37 - v40 + 16.666666666666668
                                                end
                                            end
                                            if not Sequences.Types[i55.Type] then
                                                if i55.Type == ValueType.Ref
                                                    and typeof(v38) == "Instance"
                                                    and not a1.Registry:Resolve(v38, v37) then
                                                    a1:_waitRef(v38, i49, Id)
                                                end
                                                v34 = 15
                                                if i55.Type == ValueType.UDim2 then
                                                    v33 = SentUDim2[i49]
                                                    if typeof(v38) == "UDim2" then
                                                        v39 = v33 and v33[Id]
                                                        if v39 then
                                                            v34 = Codec.udim2Mask(v39, v38)
                                                        end
                                                        if not v33 then
                                                            SentUDim2[i49] = {}
                                                        end
                                                        v33[Id] = v38
                                                    elseif v33 then
                                                        v33[Id] = nil
                                                    end
                                                end
                                                v39 = if not v32 then 0 else math.clamp(math.round(v32 / 10), 1, 255)
                                                if v34 ~= 15 or not u58[Name] then
                                                    if v34 ~= 0 then
                                                        Stream:Time(v37)
                                                        W_4 = Stream.W
                                                        if v34 == 15 then
                                                            if not v32 then
                                                                W_4:u8(Op.Prop)
                                                                Codec.varuint(W_4, v15)
                                                                Codec.varuint(W_4, Id)
                                                            else
                                                                W_4:u8(Op.PropLerp)
                                                                Codec.varuint(W_4, v15)
                                                                Codec.varuint(W_4, Id)
                                                                W_4:u8(v39)
                                                            end
                                                            Codec.writeValue(W_4, PropTypes[Id], v38)
                                                        else
                                                            W_4:u8(Op.UDim2Part)
                                                            Codec.varuint(W_4, v15)
                                                            Codec.varuint(W_4, Id)
                                                            W_4:u8(v39)
                                                            Codec.udim2Part(W_4, v34, v38)
                                                        end
                                                        Stream:EndRecord()
                                                    end
                                                elseif i55.Type ~= ValueType.UDim2 then
                                                    ValueScratch.len = 0
                                                    Codec.writeValue(ValueScratch, PropTypes[Id], v38)
                                                    v40 = buffer.readstring(ValueScratch.buf, 0, ValueScratch.len)
                                                    v41 = ("%*:%*:%*:%*"):format(Id, v39, math.floor(v37), v40)
                                                    v42 = v52[v41]
                                                    if not v42 then
                                                        v42 = {
                                                            PropId = Id,
                                                            LerpUnits = v39,
                                                            T = v37,
                                                            Encoded = v40,
                                                            Ids = {v15},
                                                        }
                                                        v52[v41] = v42
                                                        table.insert(v53, v42)
                                                    else
                                                        table.insert(v42.Ids, v15)
                                                    end
                                                elseif v34 ~= 0 then
                                                    Stream:Time(v37)
                                                    W_4 = Stream.W
                                                    if v34 == 15 then
                                                        if not v32 then
                                                            W_4:u8(Op.Prop)
                                                            Codec.varuint(W_4, v15)
                                                            Codec.varuint(W_4, Id)
                                                        else
                                                            W_4:u8(Op.PropLerp)
                                                            Codec.varuint(W_4, v15)
                                                            Codec.varuint(W_4, Id)
                                                            W_4:u8(v39)
                                                        end
                                                        Codec.writeValue(W_4, PropTypes[Id], v38)
                                                    else
                                                        W_4:u8(Op.UDim2Part)
                                                        Codec.varuint(W_4, v15)
                                                        Codec.varuint(W_4, Id)
                                                        W_4:u8(v39)
                                                        Codec.udim2Part(W_4, v34, v38)
                                                    end
                                                    Stream:EndRecord()
                                                end
                                            else
                                                table.insert(v12, {
                                                    Inst = i49,
                                                    Id = v15,
                                                    PropId = Id,
                                                    Type = i55.Type,
                                                    Value = v38,
                                                    LerpMs = v32,
                                                    T = v37,
                                                    Index = #v12 + 1,
                                                })
                                            end
                                            if v32 then
                                                v25 = v25 or {}
                                                v25[Id] = v37
                                                Animating[i49] = v25
                                            elseif v25 then
                                                v25[Id] = nil
                                            end
                                            if v35 then
                                                v36 = v36 or {}
                                                v36[Id] = v43
                                                LastSent[i49] = v36
                                            end
                                        end
                                    end
                                else
                                    v26 = v26 or {}
                                    v26[Id] = true
                                end
                            elseif not v19 or not v21 then
                                v20 = v20 or {}
                                v20[Id] = true
                            end
                        elseif not ShownBy[Name] then
                            if not v19 or not v21 then
                                v20 = v20 or {}
                                v20[Id] = true
                            end
                        elseif not v22 or not v22[Name] then
                            v35 = u52[i55.Type]
                            v36 = v35 and LastSent[i49]
                            if not v33 or not v36 or not v36[Id] or not (v43 - v36[Id] < v35) then
                                if Name ~= "Text" or not u82[v16] then
                                    v39, v40 = Styles.Read(i49, Name)
                                    v37 = v39
                                    v38 = v40
                                else
                                    success, err = pcall(result, i49, "LocalizedText")
                                    v37 = success
                                    v38 = err
                                end
                                if v37 then
                                    if v20 then
                                        v20[Id] = nil
                                    end
                                    if not v19 or v33 or not v23 or v23[Id] ~= v38 then
                                        v37 = v32 or v43
                                        if v34 then
                                            v37 = math.max(v37, v27 or v43)
                                        end
                                        v32 = nil
                                        if v33 and not v34 and u59[i55.Type] then
                                            v39 = v25 and v25[Id]
                                            v40 = v24 and v24[Id]
                                            if not v39 then
                                                if v40 and v40 < v37 then
                                                    v32 = v37 - v40 + 16.666666666666668
                                                end
                                            elseif v37 - v39 <= 300 + (v35 or 0) then
                                                v32 = v37 - v39
                                            elseif v40 and v40 < v37 then
                                                v32 = v37 - v40 + 16.666666666666668
                                            end
                                        end
                                        if not Sequences.Types[i55.Type] then
                                            if i55.Type == ValueType.Ref
                                                and typeof(v38) == "Instance"
                                                and not a1.Registry:Resolve(v38, v37) then
                                                a1:_waitRef(v38, i49, Id)
                                            end
                                            v34 = 15
                                            if i55.Type == ValueType.UDim2 then
                                                v33 = SentUDim2[i49]
                                                if typeof(v38) == "UDim2" then
                                                    v39 = v33 and v33[Id]
                                                    if v39 then
                                                        v34 = Codec.udim2Mask(v39, v38)
                                                    end
                                                    if not v33 then
                                                        SentUDim2[i49] = {}
                                                    end
                                                    v33[Id] = v38
                                                elseif v33 then
                                                    v33[Id] = nil
                                                end
                                            end
                                            v39 = if not v32 then 0 else math.clamp(math.round(v32 / 10), 1, 255)
                                            if v34 ~= 15 or not u58[Name] then
                                                if v34 ~= 0 then
                                                    Stream:Time(v37)
                                                    W_4 = Stream.W
                                                    if v34 == 15 then
                                                        if not v32 then
                                                            W_4:u8(Op.Prop)
                                                            Codec.varuint(W_4, v15)
                                                            Codec.varuint(W_4, Id)
                                                        else
                                                            W_4:u8(Op.PropLerp)
                                                            Codec.varuint(W_4, v15)
                                                            Codec.varuint(W_4, Id)
                                                            W_4:u8(v39)
                                                        end
                                                        Codec.writeValue(W_4, PropTypes[Id], v38)
                                                    else
                                                        W_4:u8(Op.UDim2Part)
                                                        Codec.varuint(W_4, v15)
                                                        Codec.varuint(W_4, Id)
                                                        W_4:u8(v39)
                                                        Codec.udim2Part(W_4, v34, v38)
                                                    end
                                                    Stream:EndRecord()
                                                end
                                            elseif i55.Type ~= ValueType.UDim2 then
                                                ValueScratch.len = 0
                                                Codec.writeValue(ValueScratch, PropTypes[Id], v38)
                                                v40 = buffer.readstring(ValueScratch.buf, 0, ValueScratch.len)
                                                v41 = ("%*:%*:%*:%*"):format(Id, v39, math.floor(v37), v40)
                                                v42 = v52[v41]
                                                if not v42 then
                                                    v42 = {
                                                        PropId = Id,
                                                        LerpUnits = v39,
                                                        T = v37,
                                                        Encoded = v40,
                                                        Ids = {v15},
                                                    }
                                                    v52[v41] = v42
                                                    table.insert(v53, v42)
                                                else
                                                    table.insert(v42.Ids, v15)
                                                end
                                            elseif v34 ~= 0 then
                                                Stream:Time(v37)
                                                W_4 = Stream.W
                                                if v34 == 15 then
                                                    if not v32 then
                                                        W_4:u8(Op.Prop)
                                                        Codec.varuint(W_4, v15)
                                                        Codec.varuint(W_4, Id)
                                                    else
                                                        W_4:u8(Op.PropLerp)
                                                        Codec.varuint(W_4, v15)
                                                        Codec.varuint(W_4, Id)
                                                        W_4:u8(v39)
                                                    end
                                                    Codec.writeValue(W_4, PropTypes[Id], v38)
                                                else
                                                    W_4:u8(Op.UDim2Part)
                                                    Codec.varuint(W_4, v15)
                                                    Codec.varuint(W_4, Id)
                                                    W_4:u8(v39)
                                                    Codec.udim2Part(W_4, v34, v38)
                                                end
                                                Stream:EndRecord()
                                            end
                                        else
                                            table.insert(v12, {
                                                Inst = i49,
                                                Id = v15,
                                                PropId = Id,
                                                Type = i55.Type,
                                                Value = v38,
                                                LerpMs = v32,
                                                T = v37,
                                                Index = #v12 + 1,
                                            })
                                        end
                                        if v32 then
                                            v25 = v25 or {}
                                            v25[Id] = v37
                                            Animating[i49] = v25
                                        elseif v25 then
                                            v25[Id] = nil
                                        end
                                        if v35 then
                                            v36 = v36 or {}
                                            v36[Id] = v43
                                            LastSent[i49] = v36
                                        end
                                    end
                                end
                            else
                                v26 = v26 or {}
                                v26[Id] = true
                            end
                        elseif not v19 or not v21 then
                            v20 = v20 or {}
                            v20[Id] = true
                        end
                    end
                end
                if not v19 or not v21 then
                    v29 = if not v20 then nil else if not next(v20) then nil else v20
                    Held[i49] = v29
                end
                if v26 then
                    v28 = a1.DirtyProps[i49]
                    if not v28 then
                        a1.DirtyProps[i49] = {}
                    end
                    v27 = a1.DirtyFirst[i49]
                    if not v27 then
                        a1.DirtyFirst[i49] = {}
                    end
                    v30 = nil
                    v31 = nil
                    for i56 in v26, v30, v31 do
                        v33 = v28[i56] or 0
                        v34 = i50[i56]
                        v28[i56] = (math.max(v33, v34))
                        v25 = v24 and v24[i56]
                        if v25 then
                            v33 = v27[i56] or v25
                            v27[i56] = (math.min(v33, v25))
                        end
                    end
                end
            end
        end
    end
    v54 = nil
    v55 = nil
    for i57, i58 in v53, v54, v55 do
        Ids_2 = i58.Ids
        Stream:Time(i58.T)
        W_3 = Stream.W
        if #Ids_2 ~= 1 then
            table.sort(Ids_2)
            W_3:u8(Op.PropMany)
            Codec.varuint(W_3, i58.PropId)
            W_3:u8(i58.LerpUnits)
            Codec.varuint(W_3, #Ids_2)
            v52 = 0
            for i59, i60 in Ids_2 do
                Codec.varuint(W_3, i60 - v52)
            end
        else
            W_3:u8(if not (0 < i58.LerpUnits) then Op.Prop else Op.PropLerp)
            Codec.varuint(W_3, Ids_2[1])
            Codec.varuint(W_3, i58.PropId)
            if 0 < i58.LerpUnits then
                W_3:u8(i58.LerpUnits)
            end
        end
        Encoded = i58.Encoded
        W_3:_ensure(#Encoded)
        buffer.writestring(W_3.buf, W_3.len, Encoded)
        W_3.len = W_3.len + #Encoded
        Stream:EndRecord()
    end
    table.sort(v12, function(a1, a2) -- Line: 1539
        if a1.T ~= a2.T then
            return a1.T < a2.T
        end
        return a1.Index < a2.Index
    end)
    for i61, i62 in v12 do
        a1:_writeSequence(i62)
    end
    local Polling = a1.Polling
    local PollNext = a1.PollNext
    local PollGap = a1.PollGap
    local PollSeen_2 = a1.PollSeen
    local PolledValues = a1.PolledValues
    local ClassPolled = a1.ClassPolled
    v7 = os.clock()
    Stream:Time(v43)
    v54 = nil
    v55 = nil
    for i63, i64 in Polling, v54, v55 do
        v5 = PollNext[i63]
        if not v5 then
            v5 = Ids[i63]
            v4 = PolledValues[i63]
            v3 = ClassPolled[result(i63, "ClassName")]
            if not v5 or not v4 then
                a1:_stopPoll(i63)
            elseif v3 then
                v46 = v7 < i64
                v43 = false
                v16 = nil
                v17 = nil
                for i65, i66 in v3, v16, v17 do
                    v20, v21 = Styles.Read(i63, i66.Name)
                    if v20 then
                        if v21 ~= v4[i66.Id] then
                            v4[i66.Id] = v21
                            W_2 = Stream.W
                            W_2:u8(Op.Prop)
                            Codec.varuint(W_2, v5)
                            Codec.varuint(W_2, i66.Id)
                            Codec.writeValue(W_2, PropTypes[i66.Id], v21)
                            Stream:EndRecord()
                        end
                        if not v21 then
                            v43 = true
                        end
                    end
                end
                if v43 then
                    v5 = PollSeen_2[i63]
                    if not v5 then
                        if not Relevance.PolledUnseen(i63, PlayerGui, v44) then
                            PollSeen_2[i63] = v7 + 5
                            if not v46 then
                                v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                                PollGap[i63] = v5
                                PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                            end
                        else
                            a1:_stopPoll(i63)
                            a1.PollHeld[i63] = true
                        end
                    elseif not (v5 <= v7) then
                        if not v46 then
                            v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                            PollGap[i63] = v5
                            PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                        end
                    elseif not Relevance.PolledUnseen(i63, PlayerGui, v44) then
                        PollSeen_2[i63] = v7 + 5
                        if not v46 then
                            v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                            PollGap[i63] = v5
                            PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                        end
                    else
                        a1:_stopPoll(i63)
                        a1.PollHeld[i63] = true
                    end
                elseif not v46 then
                    a1:_stopPoll(i63)
                end
            else
                a1:_stopPoll(i63)
            end
        elseif not (v7 < v5) then
            v5 = Ids[i63]
            v4 = PolledValues[i63]
            v3 = ClassPolled[result(i63, "ClassName")]
            if not v5 or not v4 then
                a1:_stopPoll(i63)
            elseif v3 then
                v46 = v7 < i64
                v43 = false
                v16 = nil
                v17 = nil
                for i67, i68 in v3, v16, v17 do
                    v20, v21 = Styles.Read(i63, i68.Name)
                    if v20 then
                        if v21 ~= v4[i68.Id] then
                            v4[i68.Id] = v21
                            W_2 = Stream.W
                            W_2:u8(Op.Prop)
                            Codec.varuint(W_2, v5)
                            Codec.varuint(W_2, i68.Id)
                            Codec.writeValue(W_2, PropTypes[i68.Id], v21)
                            Stream:EndRecord()
                        end
                        if not v21 then
                            v43 = true
                        end
                    end
                end
                if v43 then
                    v5 = PollSeen_2[i63]
                    if not v5 then
                        if not Relevance.PolledUnseen(i63, PlayerGui, v44) then
                            PollSeen_2[i63] = v7 + 5
                            if not v46 then
                                v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                                PollGap[i63] = v5
                                PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                            end
                        else
                            a1:_stopPoll(i63)
                            a1.PollHeld[i63] = true
                        end
                    elseif not (v5 <= v7) then
                        if not v46 then
                            v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                            PollGap[i63] = v5
                            PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                        end
                    elseif not Relevance.PolledUnseen(i63, PlayerGui, v44) then
                        PollSeen_2[i63] = v7 + 5
                        if not v46 then
                            v5 = math.min((PollGap[i63] or 0.05) * 2, 1)
                            PollGap[i63] = v5
                            PollNext[i63] = v7 + v5 * (0.75 + math.random() * 0.5)
                        end
                    else
                        a1:_stopPoll(i63)
                        a1.PollHeld[i63] = true
                    end
                elseif not v46 then
                    a1:_stopPoll(i63)
                end
            else
                a1:_stopPoll(i63)
            end
        end
    end
    a1.Memo = nil
end

function u88.Destroy(a1) -- Line: 1618
    a1.Destroyed = true
    for i, j in a1.Connections do
        j:Disconnect()
    end
    table.clear(a1.Connections)
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for k, n in a1.Signals, v1, v2 do
        for m, i5 in n do
            i5:Disconnect()
        end
    end
    table.clear(v3.Signals)
    v1 = nil
    v2 = nil
    for i6, i7 in v3.DeferredSignals, v1, v2 do
        for i8, i9 in i7 do
            i9:Disconnect()
        end
    end
    table.clear(v3.DeferredSignals)
    v1 = nil
    v2 = nil
    for i10, i11 in v3.RicherSignals, v1, v2 do
        for i12, i13 in i11 do
            i13:Disconnect()
        end
    end
    table.clear(v3.RicherSignals)
    table.clear(v3.RicherRoots)
    table.clear(v3.RicherQueued)
    table.clear(v3.OnChanged)
    table.clear(v3.StyledChecks)
    table.clear(v3.DeferredParent)
    table.clear(v3.DeferredKids)
    table.clear(v3.WaitingRefs)
    table.clear(v3.Kids)
    table.clear(v3.Pending)
    table.clear(v3.PendingTime)
    table.clear(v3.Ids)
    table.clear(v3.ById)
    table.clear(v3.ParentIds)
    table.clear(v3.PolledValues)
    table.clear(v3.Polling)
    table.clear(v3.PollNext)
    table.clear(v3.PollGap)
    table.clear(v3.PollSeen)
    table.clear(v3.PollHeld)
    table.clear(v3.Held)
    table.clear(v3.LastSent)
    table.clear(v3.Animating)
    table.clear(v3.SeqStates)
    table.clear(v3.SeqHolders)
    table.clear(v3.SentUDim2)
    v3.DirtyStructure = {}
    v3.DirtyName = {}
    v3.DirtyProps = {}
    v3.DirtyFirst = {}
    v3.RecheckSubtree = {}
    v3.RecheckChildren = {}
end

return u88