-- Script path: ReplicatedStorage.UserGenerated.Observability.WorldRecorder
-- Decompile time: 143.46 ms

local closeWatch, result
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies)
local Motion = require(ReplicatedStorage.UserGenerated.Observability.Motion)
require(ReplicatedStorage.UserGenerated.Observability.Registry)
local Sequences = require(ReplicatedStorage.UserGenerated.Observability.Sequences)
local Op = Observability.Op
local ValueType = Observability.ValueType
local RootId = Observability.RootId
local AssemblyRootProperty = Observability.AssemblyRootProperty
local SurfaceIdProperty = Observability.SurfaceIdProperty
local SurfaceIdAttribute = Observability.SurfaceIdAttribute
local BakedTag = Observability.BakedTag
local BakedIdAttribute = Observability.BakedIdAttribute
local BakedOriginAttribute = Observability.BakedOriginAttribute
local UnbakedTag = Observability.UnbakedTag
local UnbakedAttribute = Observability.UnbakedAttribute
local BakeIdProperty = Observability.BakeIdProperty
local PivotProperty = Observability.PivotProperty
local EmissionScaleProperty = Observability.EmissionScaleProperty
_, result = xpcall(function() -- Line: 126
    return workspace[nil]
end, function() -- Line: 128
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 132
        return a1[a2]
    end
end
local u77 = {Color = true, MeshId = true, TextureID = true}
local u78 = {
    [ValueType.Float32] = true,
    [ValueType.Vector3] = true,
    [ValueType.Color3] = true,
    [ValueType.CFrame] = true,
}
local u88 = {CFrame = true, Position = true, Orientation = true, Rotation = true}
local u89 = {"Part0", "Part1", "C0", "C1", "Enabled"}
local u95 = {RigidConstraint = true, AnimationConstraint = true}
local u96 = {
    Beam = true,
    Shirt = true,
    Pants = true,
    SpecialMesh = true,
    BlockMesh = true,
    CylinderMesh = true,
    FileMesh = true,
    Decal = true,
    Texture = true,
    SurfaceAppearance = true,
}
local u97 = {Color = true, Transparency = true, LocalTransparencyModifier = true}
local u101 = {
    [Enum.CameraType.Scriptable] = true,
    [Enum.CameraType.Fixed] = true,
    [Enum.CameraType.Watch] = true,
}
local u110 = Enum.RenderPriority.Camera.Value + 1
local u111 = {
    CFrame = true,
    Position = true,
    Orientation = true,
    Axis = true,
    SecondaryAxis = true,
}

local function sequenceKey(a1, a2, a3) -- Line: 266 -- upvalues: Sequences (val) -- types: a1: number, a2: number
    return (("%*:%*"):format(a1, (Sequences.key((Sequences.keypoints(a2, a3))))))
end

local function writeEncoded(a1, a2) -- Line: 271 -- types: a2: string
    local v1 = #a2
    a1:_ensure(v1)
    buffer.writestring(a1.buf, a1.len, a2)
    a1.len = a1.len + v1
end

local function predicts(a1, a2, a3) -- Line: 278 -- upvalues: Motion (val) -- types: a1: table, a2: number, a3: userdata
    if a2 < a1.T then
        return false
    end
    return not Motion.apart(Motion.at(a1.Base, a1.W, a1.V, a1.A, (a2 - a1.T) / 1000), a3, 0.2, 0.02)
end

local function newPollQueue() -- Line: 289
    return {Cursor = 1, Set = setmetatable({}, {__mode = "k"}), List = {}}
end

local function newWatch() -- Line: 304
    return {Connections = {}, Kids = {}, Names = {}}
end

local function cframeMoved(a1, a2) -- Line: 311 -- types: a1: userdata, a2: userdata
    if 0.02 < (a1.Position - a2.Position).Magnitude then
        return true
    end
    local XVector = a1.XVector
    local XVector_2 = a2.XVector
    local YVector_2 = a1.YVector
    local YVector = a2.YVector
    local v1 = true
    if not (0.003 < (math.abs(XVector.X - XVector_2.X))) then
        v1 = true
        if not (0.003 < (math.abs(XVector.Y - XVector_2.Y))) then
            v1 = true
            if not (0.003 < (math.abs(XVector.Z - XVector_2.Z))) then
                v1 = true
                if not (0.003 < (math.abs(YVector_2.X - YVector.X))) then
                    v1 = true
                    if not (0.003 < (math.abs(YVector_2.Y - YVector.Y))) then
                        v1 = 0.003 < (math.abs(YVector_2.Z - YVector.Z))
                    end
                end
            end
        end
    end
    return v1
end

local function rotationMoved(a1, a2) -- Line: 325 -- upvalues: cframeMoved (val) -- types: a1: userdata, a2: userdata
    return (cframeMoved(a1.Rotation, a2.Rotation))
end

local function subjectPart(a1) -- Line: 330 -- types: a1: userdata?
    if not a1 then
        return nil
    end
    if a1:IsA("Humanoid") then
        return a1.RootPart
    end
    if a1:IsA("BasePart") then
        return a1
    end
    if a1:IsA("Model") then
        return a1.PrimaryPart
    end
    return nil
end

local function isWorldGui(a1) -- Line: 346 -- types: a1: userdata
    return a1:IsA("BillboardGui") or a1:IsA("SurfaceGui")
end

local function inPlayerCharacter(a1) -- Line: 350 -- upvalues: Players (val) -- types: a1: userdata
    local Parent = a1.Parent
    while Parent do
        if Parent == workspace then
            break
        end
        if Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent) then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end

local function hasLocalTransparency(a1) -- Line: 361 -- types: a1: userdata
    return a1:IsA("BasePart") or a1:IsA("Decal")
end

local function particleHost(a1) -- Line: 367 -- types: a1: userdata
    local Parent = a1.Parent
    while Parent do
        if not Parent:IsA("Attachment") then
            break
        end
        Parent = Parent.Parent
    end
    if Parent and Parent:IsA("BasePart") and not Parent:IsA("Terrain") then
        return Parent
    end
    return nil
end

local function bakedId(a1) -- Line: 375
    -- upvalues: CollectionService (val), BakedTag (val), BakedIdAttribute (val)
    if not a1:IsA("Model") and not a1:IsA("Folder") and not a1:IsA("Configuration") then
        return nil
    end
    if not CollectionService:HasTag(a1, BakedTag) then
        return nil
    end
    local Attribute = a1:GetAttribute(BakedIdAttribute)
    if type(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    return nil
end

local function bakedPivot(a1) -- Line: 384 -- upvalues: BakedOriginAttribute (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(BakedOriginAttribute)
    local Pivot = a1:GetPivot()
    if typeof(Attribute) == "CFrame" then
        return Pivot * Attribute:Inverse()
    end
    return Pivot
end

local function seedKind(a1) -- Line: 391 -- upvalues: u95 (val), u96 (val), bakedId (val) -- types: a1: userdata
    if a1:IsA("BasePart") then
        if a1:IsA("Terrain") then
            return nil
        end
        return "part"
    end
    if a1:IsA("Bone") then
        return "visual"
    end
    local ClassName = a1.ClassName
    if not a1:IsA("JointInstance") and not a1:IsA("WeldConstraint") and not u95[ClassName] then
        if u96[ClassName] then
            return "visual"
        end
        local v1 = a1:IsA("BillboardGui") or a1:IsA("SurfaceGui")
        if v1 then
            return "gui"
        end
        if bakedId(a1) then
            return "baked"
        end
        return nil
    end
    return "joint"
end

local u134 = {}
u134.__index = u134

function u134.new(a1, a2, a3, a4, a5) -- Line: 421
    -- upvalues: newPollQueue (val), Codec (val), u134 (val), u97 (val), RunService (val), u110 (val)
    local v1 = a1:FilterRoot(workspace)
    local v2 = {
        Registry = a1,
        Stream = a1.Stream,
        Clock = a1.Clock,
        TrackGui = a2,
        WatchAnimator = a3,
        MaxInstances = a4,
        BakeModels = a5 == true,
        Filtered = v1 ~= nil,
    }
    local Include = false
    if v1 ~= nil then
        Include = v1.Include
    end
    v2.Scoped = Include
    v2.Count = 0
    v2.Watches = {}
    v2.CharacterScopes = {}
    v2.PinSignals = {}
    v2.Ids = a1.Ids
    v2.Kinds = setmetatable({}, {__mode = "k"})
    v2.Signals = setmetatable({}, {__mode = "k"})
    v2.AttachSignals = setmetatable({}, {__mode = "k"})
    v2.Kids = setmetatable({}, {__mode = "k"})
    v2.Roots = setmetatable({}, {__mode = "k"})
    v2.RootOf = setmetatable({}, {__mode = "k"})
    v2.JointParts = setmetatable({}, {__mode = "k"})
    v2.TerrainDriven = setmetatable({}, {__mode = "k"})
    v2.Held = setmetatable({}, {__mode = "k"})
    v2.InCharacter = setmetatable({}, {__mode = "k"})
    v2.Baked = setmetatable({}, {__mode = "k"})
    v2.BakedMemo = {}
    v2.Unbaked = {}
    v2.Particles = {}
    v2.ParticleHosts = {}
    v2.EmissionScale = nil
    v2.EmissionScaleDirty = false
    v2.LastCFrame = setmetatable({}, {__mode = "k"})
    v2.LastSent = setmetatable({}, {__mode = "k"})
    v2.SentCFrames = setmetatable({}, {__mode = "k"})
    v2.Motions = setmetatable({}, {__mode = "k"})
    v2.Samples = setmetatable({}, {__mode = "k"})
    v2.Candidates = setmetatable({}, {__mode = "k"})
    v2.Untrusted = setmetatable({}, {__mode = "k"})
    v2.Sampled = {}
    v2.WorldPoll = newPollQueue()
    v2.PlayerPolls = {}
    v2.PolledBy = setmetatable({}, {__mode = "k"})
    v2.SeqStates = setmetatable({}, {__mode = "k"})
    v2.SeqHolders = setmetatable({}, {__mode = "v"})
    v2.Groups = nil
    v2.GroupOrder = {}
    v2.GroupedProps = {}
    v2.ValueScratch = Codec.newWriter(256)
    v2.Pending = {}
    v2.DirtyStructure = {}
    v2.DirtyName = {}
    v2.DirtyProps = {}
    v2.RootCheck = {}
    v2.AnchorCheck = {}
    v2.CameraSample = nil
    v2.LastCamera = nil
    v2.LastFov = 0
    v2.Follow = nil
    v2.LastCameraTime = (-1 / 0)
    v2.Connections = {}
    v2.Destroyed = false
    local u186 = setmetatable(v2, u134)
    u186.ByName = a1.ClassPropsByName
    local v3 = nil
    local v4 = nil
    for i, j in a1.ClassProps, v3, v4 do
        for k, n in j do
            if u97[n.Name] then
                u186.GroupedProps[n.Id] = true
            end
        end
    end
    a1:AddResolver(function(a1, a2) -- Line: 541 -- upvalues: u186 (val) -- types: a1: userdata, a2: number?
        return u186:_track(a1, a2)
    end)
    RunService:BindToRenderStep("UGReplayCameraSample", u110, function() -- Line: 544 -- upvalues: u186 (val)
        u186.CameraSample = u186:_sampleCamera()
    end)
    return u186
end

function u134:_propId(a2, a3) -- Line: 550 -- types: self: table, a2: string, a3: string
    local v1 = self.ByName[a2]
    return v1 and v1[a3]
end

function u134:_kidsOf(a2) -- Line: 555 -- types: self: table, a2: userdata
    local v1 = self.Kids[a2]
    if not v1 then
        v1 = setmetatable({}, {__mode = "k"})
        self.Kids[a2] = v1
    end
    return v1
end

function u134:_markProp(a2, a3) -- Line: 564 -- types: self: table, a2: userdata, a3: number
    local v1 = self.DirtyProps[a2]
    if not v1 then
        self.DirtyProps[a2] = {}
    end
    v1[a3] = (self.Clock())
end

function u134:_isRecordedRoot(a2, a3) -- Line: 574 -- types: self: table, a2: userdata, a3: userdata?
    local v1 = true
    if a3 ~= a2 then
        v1 = false
        if self.TerrainDriven[a2] ~= nil then
            v1 = false
            if a3 ~= nil then
                v1 = a3:IsA("Terrain")
            end
        end
    end
    return v1
end

local function terrainDrivenPart(a1, a2, a3) -- Line: 579 -- types: a1: userdata, a2: userdata?, a3: userdata?
    if not a1:IsA("Motor6D") then
        return nil
    end
    if a2 and a2:IsA("Terrain") then
        if a3 and not a3:IsA("Terrain") then
            return a3
        end
        return nil
    end
    if a3 and a3:IsA("Terrain") then
        return a2
    end
    return nil
end

function u134:_setJointParts(a2, a3, a4) -- Line: 592
    -- upvalues: terrainDrivenPart (val)
    local v1 = self.JointParts[a2]
    local TerrainDriven = self.TerrainDriven
    local v2 = v1 and terrainDrivenPart(a2, v1[1], v1[2])
    if v2 then
        v1 = (TerrainDriven[v2] or 1) - 1
        TerrainDriven[v2] = if not (v1 > 0) then nil else v1
    end
    v2 = terrainDrivenPart(a2, a3, a4)
    if v2 then
        TerrainDriven[v2] = (TerrainDriven[v2] or 0) + 1
    end
    self.JointParts[a2] = {a3, a4}
end

local function attachmentOf(a1, a2) -- Line: 607 -- upvalues: result (ref) -- types: a1: userdata, a2: string
    local v1 = result(a1, a2)
    if v1 and v1:IsA("Attachment") then
        return v1
    end
    return nil
end

local function attachmentEnd(a1) -- Line: 613 -- upvalues: result (ref) -- types: a1: userdata?
    local v1 = a1 and result(a1, "Parent")
    if a1 and v1 and v1:IsA("BasePart") then
        return v1, result(a1, "CFrame")
    end
    return nil, CFrame.identity
end

local function readAttachmentJoint(a1, a2) -- Line: 622 -- upvalues: result (ref) -- types: a1: userdata, a2: string
    local identity, v1
    if a2 == "Enabled" then
        v1 = result(a1, "Enabled") and (not a1:IsA("AnimationConstraint") or result(a1, "IsKinematic"))
        return true, v1
    end
    local v2 = if a2 == "Part0" then "Attachment0" else if a2 ~= "C0" then "Attachment1" else "Attachment0"
    local v3 = result(a1, v2)
    local v4 = if not v3 then nil else if not v3:IsA("Attachment") then nil else v3
    v3 = v4 and result(v4, "Parent")
    if not v4 or not v3 or not v3:IsA("BasePart") then
        v1 = nil
        identity = CFrame.identity
    else
        v1 = v3
        identity = result(v4, "CFrame")
    end
    v4 = true
    if a2 ~= "Part0" and a2 ~= "Part1" then
        return v4, identity
    end
    return v4, v1
end

function u134:_jointEnds(a2) -- Line: 631 -- upvalues: result (ref) -- types: self: table, a2: userdata
    local v1
    if self.Kinds[a2] ~= "constraint" then
        return (result(a2, "Part0")), result(a2, "Part1")
    end
    local v2 = result(a2, "Attachment0")
    local v3 = if not v2 then nil else if not v2:IsA("Attachment") then nil else v2
    v2 = v3 and result(v3, "Parent")
    if not v3 or not v2 or not v2:IsA("BasePart") then
        v1 = nil
        local identity = CFrame.identity
    else
        v1 = v2
        result(v3, "CFrame")
    end
    local v4 = result(a2, "Attachment1")
    v2 = if not v4 then nil else if not v4:IsA("Attachment") then nil else v4
    v4 = v2 and result(v2, "Parent")
    if v2 and v4 and v4:IsA("BasePart") then
        result(v2, "CFrame")
        return v1, v4
    end
    local identity_2 = CFrame.identity
    return v1, nil
end

function u134:_read(a2, a3) -- Line: 641
    -- upvalues: AssemblyRootProperty (val), result (ref), readAttachmentJoint (val), SurfaceIdProperty (val)
    -- upvalues: SurfaceIdAttribute (val), BakeIdProperty (val), bakedId (val), PivotProperty (val)
    -- upvalues: BakedOriginAttribute (val)
    if a3 == AssemblyRootProperty then
        local success, err = pcall(result, a2, "AssemblyRootPart")
        return true, success and self:_isRecordedRoot(a2, err)
    end
    if self.Kinds[a2] == "constraint" then
        return readAttachmentJoint(a2, a3)
    end
    if a3 == SurfaceIdProperty then
        local Attribute = a2:GetAttribute(SurfaceIdAttribute)
        return type(Attribute) == "string", Attribute
    end
    if self.Kinds[a2] == "baked" then
        local v1
        if a3 == BakeIdProperty then
            v1 = bakedId(a2)
            return v1 ~= nil, v1
        end
        if a3 == PivotProperty then
            v1 = a2:IsA("Model")
            if not a2:IsA("Model") then
                return v1, nil
            end
            local Attribute_2 = a2:GetAttribute(BakedOriginAttribute)
            local Pivot = a2:GetPivot()
            if typeof(Attribute_2) == "CFrame" then
                return v1, Pivot * Attribute_2:Inverse()
            end
            return v1, Pivot
        end
    end
    if a3 == "C0" and a2:IsA("WeldConstraint") then
        local Part0 = a2.Part0
        local Part1 = a2.Part1
        if Part0 and Part1 then
            return true, Part0.CFrame:ToObjectSpace(Part1.CFrame)
        end
        return true, CFrame.identity
    end
    if a3 == "LocalTransparencyModifier" and not self.InCharacter[a2] and self.Kinds[a2] ~= "particle" then
        return false, nil
    end
    local success_2 = pcall(result, a2, a3)
    return success_2
end

function u134:_updateInCharacter(a2) -- Line: 677
    -- upvalues: inPlayerCharacter (val), result (ref)
    local v1 = a2:IsA("BasePart") or a2:IsA("Decal")
    if not v1 then
        return
    end
    v1 = inPlayerCharacter(a2)
    if v1 and not self.InCharacter[a2] and self.Ids[a2] then
        local v2 = self:_propId(result(a2, "ClassName"), "LocalTransparencyModifier")
        if v2 then
            self:_markProp(a2, v2)
        end
    end
    local v3 = if not v1 then nil else true
    self.InCharacter[a2] = v3
end

function u134:_parentIdOf(a2, a3, a4) -- Line: 691
    -- upvalues: RootId (val), Lighting (val)
    if a3 == nil then
        return nil
    end
    if a3 == workspace then
        return RootId.Workspace
    end
    if a3 == Lighting then
        if a2:IsA("Sky") then
            return RootId.Lighting
        end
        return nil
    end
    if a3:IsA("Terrain") then
        return RootId.Workspace
    end
    if not self:_inBaked(a3) then
        return self.Ids[a3] or self.Registry:Resolve(a3, a4)
    end
    if self:_isUnbaked(a2) then
        return RootId.Workspace
    end
    return nil
end

function u134._inDomain(a1, a2) -- Line: 711 -- upvalues: result (ref), Lighting (val) -- types: a1: table, a2: userdata
    if a2:IsA("Sky") then
        return (result(a2, "Parent")) == Lighting
    end
    if a2:IsDescendantOf(workspace) and not a2:IsA("Terrain") then
        local v1 = a2:IsA("BillboardGui") or a2:IsA("SurfaceGui")
        if not v1 then
            v1 = false
            if a2:FindFirstAncestorWhichIsA("LayerCollector") == nil then
                v1 = a2:FindFirstAncestorWhichIsA("ViewportFrame") == nil
            end
            return v1
        end
    end
    return false
end

function u134:_isBakedRoot(a2) -- Line: 724 -- upvalues: bakedId (val) -- types: self: table, a2: userdata
    if self.Baked[a2] then
        return true
    end
    local v1 = false
    if self.Ids[a2] == nil then
        v1 = bakedId(a2) ~= nil
    end
    return v1
end

function u134:_isUnbaked(a2) -- Line: 731 -- upvalues: UnbakedAttribute (val) -- types: self: table, a2: userdata
    local v1 = false
    if self.Unbaked[a2] ~= nil then
        v1 = a2:GetAttribute(UnbakedAttribute) == true
    end
    return v1
end

function u134:_inBaked(a2) -- Line: 738 -- upvalues: result (ref) -- types: self: table, a2: userdata?
    if self.BakeModels and a2 ~= nil and a2 ~= workspace then
        local BakedMemo = self.BakedMemo
        local v1 = BakedMemo[a2]
        if v1 ~= nil then
            return v1
        end
        v1 = not self:_isUnbaked(a2) and (self:_isBakedRoot(a2) or self:_inBaked((result(a2, "Parent"))))
        BakedMemo[a2] = v1
        return v1
    end
    return false
end

function u134:_hiddenByBake(a2, a3) -- Line: 754 -- types: self: table, a2: userdata, a3: userdata?
    return self:_inBaked(a3) and not self:_isUnbaked(a2)
end

function u134:_track(a2, a3) -- Line: 760
    -- upvalues: Observability (val), result (ref), bakedId (val), u95 (val), u96 (val), inPlayerCharacter (val)
    -- upvalues: u77 (val), AssemblyRootProperty (val), PivotProperty (val), ValueType (val), Copies (val), Codec (val)
    -- upvalues: Sequences (val)
    local v1 = self.Ids[a2]
    if v1 then
        return v1
    end
    if not (self.MaxInstances <= self.Count) and self:_inDomain(a2) and not Observability.IsAudio(a2) then
        local Name, Prop, Value, W, err, len, success, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17
        v1 = a2:IsA("ParticleEmitter")
        if v1 and not self.Particles[a2] then
            return nil
        end
        local Registry = self.Registry
        local v18 = result(a2, "Parent")
        if self:_hiddenByBake(a2, v18) then
            return nil
        end
        local v19 = self:_parentIdOf(a2, v18, a3)
        if v19 == nil then
            return nil
        end
        if Registry:MatchFilter(a2, v18) then
            self:_watchFiltered(a2)
            return nil
        end
        local v20 = result(a2, "ClassName")
        local v21 = "primitive"
        local v22 = Registry.ClassProps[v20]
        if v22 and #v22 > 0 then
            if not self.BakeModels then
                if a2:IsA("BasePart") then
                    v21 = "part"
                elseif a2:IsA("WeldConstraint") then
                    v21 = "weld"
                elseif a2:IsA("JointInstance") then
                    v21 = "joint"
                elseif u95[v20] then
                    v21 = "constraint"
                elseif v1 then
                    v21 = "particle"
                elseif u96[v20] or a2:IsA("Attachment") then
                    v21 = "visual"
                elseif a2:IsA("Sky") then
                    v21 = "sky"
                end
            elseif bakedId(a2) then
                v21 = "baked"
            elseif a2:IsA("BasePart") then
                v21 = "part"
            elseif a2:IsA("WeldConstraint") then
                v21 = "weld"
            elseif a2:IsA("JointInstance") then
                v21 = "joint"
            elseif u95[v20] then
                v21 = "constraint"
            elseif v1 then
                v21 = "particle"
            elseif u96[v20] or a2:IsA("Attachment") then
                v21 = "visual"
            elseif a2:IsA("Sky") then
                v21 = "sky"
            end
        end
        if v21 == "primitive" then
            v3, v2, v13 = a2, self, a3
            v4 = Registry:Allocate(v3, v19)
            v2.Count = v2.Count + 1
            v2.Kinds[v3] = v21
            if nil then
                v5 = v3:IsA("BasePart") or v3:IsA("Decal")
                if v5 and inPlayerCharacter(v3) then
                    v2.InCharacter[v3] = true
                end
            end
            if v18 then
                v5 = v2:_kidsOf(v18)
                v5[v3] = true
            end
            v18 = Registry:AddTime(v13)
            v5 = if not v22 then nil else if v21 == "baked" then nil else Registry:DefaultsFor(v20)
            v6 = false
            if v21 == "part" then
                v6 = 1 <= (result(v3, "Transparency"))
            end
            v7 = {}
            v8 = {}
            if v22 then
                v10 = nil
                v11 = nil
                for i16, i17 in v22, v10, v11 do
                    Name = i17.Name
                    if not v6 or not u77[Name] then
                        v15, v16 = v2:_read(v3, Name)
                        if v15 then
                            if Name == AssemblyRootProperty then
                                v2.Roots[v3] = v16
                            elseif Name ~= "CFrame" then
                                if Name == PivotProperty and v21 == "baked" then
                                    v2.LastCFrame[v3] = v16
                                end
                            elseif v21 == "part" or Name == PivotProperty and v21 == "baked" then
                                v2.LastCFrame[v3] = v16
                            end
                            v15 = if i17.Type ~= ValueType.Ref then v16 else Copies.refValue(if typeof(v16) ~= "Instance" then nil else v2.Ids[v16], v4)
                            table.insert(v7, {Prop = i17, Value = v16, Stored = v15})
                            v8[i17.Id] = v15
                        end
                    end
                end
            end
            W = v2.Stream.W
            v9, v10 = Registry.Copies:WriteHead(W, v4, v19, v22 and Registry.ClassIndex[v20] or Registry.UnknownClassId, result(v3, "Name"), true, v8)
            len = W.len
            W:u16(0)
            v19 = 0
            if v22 then
                v17 = {}
                v12 = nil
                v14 = nil
                for i18, i19 in v7, v12, v14 do
                    Prop = i19.Prop
                    Value = i19.Value
                    if Prop.Name ~= AssemblyRootProperty or Value or v9 then
                        if Copies.differs(v9, v10, v5, Prop.Id, Value, i19.Stored) then
                            Codec.varuint(W, Prop.Id)
                            Codec.writeValue(W, Prop.Type, Value)
                            v17[Prop.Id] = v18
                            v19 = v19 + 1
                        end
                        if Sequences.Types[Prop.Type] then
                            v2:_setSequence(
                                v3,
                                Prop.Id,
                                ("%*:%*"):format(Prop.Id, (Sequences.key((Sequences.keypoints(Prop.Type, Value))))),
                                v18
                            )
                        end
                    elseif v10 then
                        v10[Prop.Id] = false
                    end
                end
                v2.LastSent[v3] = v17
                if v6 then
                    v2.Held[v3] = true
                end
            end
            W:patchU16(len, v19)
            v2.Stream:EndRecord()
            v2:_connect(v3, v21, v20)
            if v21 == "baked" then
                v2.Baked[v3] = true
                v2.BakedMemo[v3] = true
                return v4
            end
            if v21 == "part" then
                success, err = pcall(result, v3, "AssemblyRootPart")
                if success and err then
                    v2.RootOf[v3] = err
                end
                if not v2.Roots[v3] then
                    return v4
                end
                v2:_updatePolling(v3)
                return v4
            end
            if v21 == "joint" or v21 == "weld" or v21 == "constraint" then
                v11, v12 = v2:_jointEnds(v3)
                v2:_setJointParts(v3, v11, v12)
                v2:_checkRoots(v11, v12, v18)
            end
            return v4
        end
        Registry:ResolveRefs(a2, v20, a3)
        if v21 ~= "constraint" then
            v2, v3, v13 = self, a2, a3
        else
            local identity, v23
            v4 = {"Attachment0", "Attachment1"}
            v5 = nil
            v6 = nil
            v3, v13, v2 = a2, a3, self
            for i10, i11 in v4, v5, v6 do
                v9 = result(v3, i11)
                v23 = if not v9 then nil else if not v9:IsA("Attachment") then nil else v9
                v9 = v23 and result(v23, "Parent")
                if not v23 or not v9 or not v9:IsA("BasePart") then
                    v1 = nil
                    identity = CFrame.identity
                else
                    v1 = v9
                    result(v23, "CFrame")
                end
                if v1 then
                    Registry:Resolve(v1, v13)
                end
            end
        end
        if v2.Ids[v3] then
            return v2.Ids[v3]
        end
        v4 = Registry:Allocate(v3, v19)
        v2.Count = v2.Count + 1
        v2.Kinds[v3] = v21
        if v22 then
            v5 = v3:IsA("BasePart") or v3:IsA("Decal")
            if v5 and inPlayerCharacter(v3) then
                v2.InCharacter[v3] = true
            end
        end
        if v18 then
            v5 = v2:_kidsOf(v18)
            v5[v3] = true
        end
        v18 = Registry:AddTime(v13)
        v5 = if not v22 then nil else if v21 == "baked" then nil else Registry:DefaultsFor(v20)
        v6 = false
        if v21 == "part" then
            v6 = 1 <= (result(v3, "Transparency"))
        end
        v7 = {}
        v8 = {}
        if v22 then
            v10 = nil
            v11 = nil
            for i12, i13 in v22, v10, v11 do
                Name = i13.Name
                if not v6 or not u77[Name] then
                    v15, v16 = v2:_read(v3, Name)
                    if v15 then
                        if Name == AssemblyRootProperty then
                            v2.Roots[v3] = v16
                        elseif Name ~= "CFrame" then
                            if Name == PivotProperty and v21 == "baked" then
                                v2.LastCFrame[v3] = v16
                            end
                        elseif v21 == "part" or Name == PivotProperty and v21 == "baked" then
                            v2.LastCFrame[v3] = v16
                        end
                        v15 = if i13.Type ~= ValueType.Ref then v16 else Copies.refValue(if typeof(v16) ~= "Instance" then nil else v2.Ids[v16], v4)
                        table.insert(v7, {Prop = i13, Value = v16, Stored = v15})
                        v8[i13.Id] = v15
                    end
                end
            end
        end
        W = v2.Stream.W
        v9, v10 = Registry.Copies:WriteHead(W, v4, v19, v22 and Registry.ClassIndex[v20] or Registry.UnknownClassId, result(v3, "Name"), true, v8)
        len = W.len
        W:u16(0)
        v19 = 0
        if v22 then
            v17 = {}
            v12 = nil
            v14 = nil
            for i14, i15 in v7, v12, v14 do
                Prop = i15.Prop
                Value = i15.Value
                if Prop.Name ~= AssemblyRootProperty or Value or v9 then
                    if Copies.differs(v9, v10, v5, Prop.Id, Value, i15.Stored) then
                        Codec.varuint(W, Prop.Id)
                        Codec.writeValue(W, Prop.Type, Value)
                        v17[Prop.Id] = v18
                        v19 = v19 + 1
                    end
                    if Sequences.Types[Prop.Type] then
                        v2:_setSequence(
                            v3,
                            Prop.Id,
                            ("%*:%*"):format(Prop.Id, (Sequences.key((Sequences.keypoints(Prop.Type, Value))))),
                            v18
                        )
                    end
                elseif v10 then
                    v10[Prop.Id] = false
                end
            end
            v2.LastSent[v3] = v17
            if v6 then
                v2.Held[v3] = true
            end
        end
        W:patchU16(len, v19)
        v2.Stream:EndRecord()
        v2:_connect(v3, v21, v20)
        if v21 == "baked" then
            v2.Baked[v3] = true
            v2.BakedMemo[v3] = true
            return v4
        end
        if v21 == "part" then
            success, err = pcall(result, v3, "AssemblyRootPart")
            if success and err then
                v2.RootOf[v3] = err
            end
            if not v2.Roots[v3] then
                return v4
            end
            v2:_updatePolling(v3)
            return v4
        end
        if v21 == "joint" or v21 == "weld" or v21 == "constraint" then
            v11, v12 = v2:_jointEnds(v3)
            v2:_setJointParts(v3, v11, v12)
            v2:_checkRoots(v11, v12, v18)
        end
        return v4
    end
    return nil
end

function u134:_connect(a2, a3, a4) -- Line: 933
    -- upvalues: u89 (val), result (ref), u88 (val), u111 (val)
    local v1 = {}
    self.Signals[a2] = v1

    local function structure() -- Line: 936 -- upvalues: self (val), a2 (val)
        self.DirtyStructure[a2] = (self.Clock())
    end

    local function rename() -- Line: 939 -- upvalues: self (val), a2 (val)
        self.DirtyName[a2] = (self.Clock())
        if self.Registry.FilterAny then
            self.DirtyStructure[a2] = (self.Clock())
        end
    end

    if a3 ~= "primitive" and a3 ~= "baked" then
        if a3 ~= "joint" and a3 ~= "weld" then
            local v2
            if a3 ~= "constraint" then
                local u116 = self.ByName[a4]
                if not u116 then
                    u116 = {}
                end
                local CFrame = u116.CFrame
                if a2:IsA("Bone") then
                    table.insert(v1, ((a2:GetPropertyChangedSignal("Parent")):Connect(structure)))
                    table.insert(v1, ((a2:GetPropertyChangedSignal("Name")):Connect(rename)))
                    if CFrame then
                        table.insert(v1, ((a2:GetPropertyChangedSignal("CFrame")):Connect(function() -- Line: 1025 -- upvalues: self (val), a2 (val), CFrame (val)
                            self:_markProp(a2, CFrame)
                        end)))
                    end
                    return
                end
                table.insert(v1, (a2.Changed:Connect(function(a1) -- Line: 1034
                    -- upvalues: self (val), a2 (val), a3 (val), u88 (upval), CFrame (val), u111 (upval), u116 (val)
                    if a1 == "Parent" then
                        self.DirtyStructure[a2] = (self.Clock())
                        return
                    end
                    if a1 == "Name" then
                        self.DirtyName[a2] = (self.Clock())
                        if not self.Registry.FilterAny then
                            return
                        end
                        self.DirtyStructure[a2] = (self.Clock())
                        return
                    end
                    if a3 == "part" and u88[a1] then
                        if CFrame and self.Roots[a2] then
                            self:_markProp(a2, CFrame)
                            return
                        end
                        return
                    end
                    if a3 == "part" and a1 == "Anchored" then
                        self.AnchorCheck[a2] = true
                        return
                    end
                    if CFrame and u111[a1] and a2:IsA("Attachment") then
                        self:_markProp(a2, CFrame)
                        return
                    end
                    local v1 = u116[a1]
                    if v1 then
                        self:_markProp(a2, v1)
                    end
                end)))
                return
            end
            table.insert(v1, ((a2:GetPropertyChangedSignal("Parent")):Connect(structure)))
            table.insert(v1, ((a2:GetPropertyChangedSignal("Name")):Connect(rename)))
            local u30 = {}
            for i, j in u89 do
                v2 = self:_propId(a4, j)
                if v2 then
                    table.insert(u30, v2)
                end
            end

            local function changed() -- Line: 978 -- upvalues: u30 (val), self (val), a2 (val)
                for i, j in u30 do
                    self:_markProp(a2, j)
                end
            end

            local function bindAttachments() -- Line: 983
                -- upvalues: self (val), a2 (val), result (upval), changed (val)
                local v1, v2
                local v3 = self.AttachSignals[a2]
                if v3 then
                    for i, j in v3 do
                        j:Disconnect()
                    end
                end
                v3 = {}
                local v4 = {"Attachment0", "Attachment1"}
                local v5 = nil
                local v6 = nil
                for k, n in v4, v5, v6 do
                    v2 = result(a2, n)
                    v1 = if not v2 then nil else if not v2:IsA("Attachment") then nil else v2
                    if v1 then
                        table.insert(v3, ((v1:GetPropertyChangedSignal("CFrame")):Connect(changed)))
                        table.insert(v3, ((v1:GetPropertyChangedSignal("Parent")):Connect(changed)))
                    end
                end
                self.AttachSignals[a2] = v3
            end

            bindAttachments()
            for k, n in {"Attachment0", "Attachment1"} do
                table.insert(v1, ((a2:GetPropertyChangedSignal(n)):Connect(function() -- Line: 1004 -- upvalues: bindAttachments (val), u30 (val), self (val), a2 (val)
                    bindAttachments()
                    for i, j in u30 do
                        self:_markProp(a2, j)
                    end
                end)))
            end
            table.insert(v1, ((a2:GetPropertyChangedSignal("Enabled")):Connect(changed)))
            if a2:IsA("AnimationConstraint") then
                table.insert(v1, ((a2:GetPropertyChangedSignal("IsKinematic")):Connect(changed)))
            end
            return
        end
        table.insert(v1, ((a2:GetPropertyChangedSignal("Parent")):Connect(structure)))
        table.insert(v1, ((a2:GetPropertyChangedSignal("Name")):Connect(rename)))
        local v3 = nil
        local v4 = nil
        for m, i5 in u89, v3, v4 do
            local u212 = self:_propId(a4, i5)
            if u212 then
                if a3 ~= "weld" or i5 ~= "C0" and i5 ~= "C1" then
                    table.insert(v1, ((a2:GetPropertyChangedSignal(i5)):Connect(function() -- Line: 961 -- upvalues: self (val), a2 (val), u212 (val)
                        self:_markProp(a2, u212)
                    end)))
                end
            end
        end
        return
    end
    table.insert(v1, ((a2:GetPropertyChangedSignal("Parent")):Connect(structure)))
    table.insert(v1, ((a2:GetPropertyChangedSignal("Name")):Connect(rename)))
end

local function setPolled(a1, a2, a3) -- Line: 1057 -- types: a1: table, a2: userdata, a3: boolean
    if a3 and not a1.Set[a2] then
        a1.Set[a2] = true
        table.insert(a1.List, a2)
        return
    end
    if not a3 then
        a1.Set[a2] = nil
    end
end

function u134:_updatePolling(a2) -- Line: 1068 -- upvalues: result (ref) -- types: self: table, a2: userdata
    local v1
    local v2 = false
    if self.Roots[a2] == true then
        v2 = false
        if self.Ids[a2] ~= nil then
            v2 = true
            if self.TerrainDriven[a2] == nil then
                v2 = not result(a2, "Anchored")
            end
        end
    end
    self:_setPlayerPolled(a2, if not v2 then nil else self:_characterPlayer(a2))
    local WorldPoll = self.WorldPoll
    local v3 = v2 and v1 == nil
    if v3 and not WorldPoll.Set[a2] then
        WorldPoll.Set[a2] = true
        table.insert(WorldPoll.List, a2)
        return
    end
    if not v3 then
        WorldPoll.Set[a2] = nil
    end
end

function u134:_setPlayerPolled(a2, a3) -- Line: 1078
    -- upvalues: newPollQueue (val)
    local v1 = self.PolledBy[a2]
    if v1 == a3 then
        return
    end
    if v1 then
        local v2 = self.PlayerPolls[v1]
        if v2 then
            v2.Queue.Set[a2] = nil
        end
    end
    self.PolledBy[a2] = a3
    if a3 then
        v1 = self.PlayerPolls[a3]
        if not v1 then
            v1 = {Queue = newPollQueue(), Next = os.clock()}
            self.PlayerPolls[a3] = v1
        end
        local Queue = v1.Queue
        if not Queue.Set[a2] then
            Queue.Set[a2] = true
            table.insert(Queue.List, a2)
            return
        end
    end
end

function u134:_checkRoots(a2, a3, a4) -- Line: 1102 -- types: self: table, a2: userdata?, a3: userdata?, a4: number
    local v1
    local RootCheck = self.RootCheck
    for i, j in {a2, a3} do
        if j and j:IsA("BasePart") then
            RootCheck[j] = a4
            v1 = self.RootOf[j]
            if v1 then
                RootCheck[v1] = a4
            end
        end
    end
end

function u134:_writeProp(a2, a3, a4, a5, a6, a7) -- Line: 1118
    -- upvalues: ValueType (val), Op (val), Codec (val), u78 (val)
    local v1
    local v2 = self.LastSent[a2]
    if not v2 then
        self.LastSent[a2] = {}
    end
    local v3 = self.Registry.PropTypes[a4]
    local v4 = v2[a4]
    local v5 = false
    if v3 == ValueType.CFrame then
        v5 = typeof(a5) == "CFrame"
    end
    local v6 = if not v5 then a6 else if not v4 then a6 else if not (a6 < v4) then a6 else v4
    local v7 = false
    if v5 and self.Kinds[a2] == "part" and not self:_isCharacterPart(a2) then
        local v8
        v8, v1 = self:_writeMotion(a2, a3, a4, a5, v6)
        if v8 then
            return
        end
        v7 = v1
    end
    local Prop = Op.Prop
    v1 = 0
    local v9 = 0
    local v10 = 0
    local v11 = 0
    local v12 = 0
    local v13 = 0
    local v14 = 0
    local K = 0
    local A = 0
    local B = 0
    local C = 0
    if v5 then
        local v15, v16, v17, v18 = Codec.quantizeRotation(a5)
        v1 = v15
        v9 = v16
        v10 = v17
        v11 = v18
        local Position = a5.Position
        v16 = self.SentCFrames[a2]
        if not v16 then
            self.SentCFrames[a2] = {}
        end
        v17 = v16[a4]
        if v17 then
            local Position_2 = v17.Position
            v12 = Codec.positionSteps(Position_2.X, Position.X)
            v13 = Codec.positionSteps(Position_2.Y, Position.Y)
            v14 = Codec.positionSteps(Position_2.Z, Position.Z)
            local MaxPositionSteps = Codec.MaxPositionSteps
            if math.abs(v12) <= MaxPositionSteps
                and math.abs(v13) <= MaxPositionSteps
                and math.abs(v14) <= MaxPositionSteps then
                local v19 = false
                if v17.K == v1 then
                    v19 = false
                    if v17.A == v9 then
                        v19 = false
                        if v17.B == v10 then
                            v19 = v17.C == v11
                        end
                    end
                end
                if v12 == 0 and v13 == 0 and v14 == 0 and v19 and not v7 then
                    if a7 then
                        v2[a4] = v6
                    end
                    return
                end
                Prop = Op.CFrameDelta
                K = v17.K
                A = v17.A
                B = v17.B
                C = v17.C
                Position = Vector3.new(
                    Codec.stepPosition(Position_2.X, v12),
                    Codec.stepPosition(Position_2.Y, v13),
                    (Codec.stepPosition(Position_2.Z, v14))
                )
            end
        end
        if not v17 then
            v16[a4] = {
                Position = Position,
                K = v1,
                A = v9,
                B = v10,
                C = v11,
            }
        else
            v17.Position = Position
            v17.K = v1
            v17.A = v9
            v17.B = v10
            v17.C = v11
        end
    end
    v7 = if not u78[v3] then nil else if a7 then if not v4 then nil else if not (v6 - v4 <= 300) then nil else if not (v4 < v6) then nil else v6 - v4 else if v3 == ValueType.CFrame then nil else if not v4 then nil else if not (v6 - v4 <= 300) then nil else if not (v4 < v6) then nil else v6 - v4
    v2[a4] = v6
    if v3 == ValueType.Ref and typeof(a5) == "Instance" then
        self.Registry:Resolve(a5, v6)
    end
    v4 = if not v7 then 0 else math.clamp(math.round(v7 / 10), 1, 255)
    if not v5 then
        self:_writeValue(a2, a3, a4, v3, a5, v6, v4)
        return
    end
    local Stream = self.Stream
    Stream:Time(v6)
    local W = Stream.W
    if Prop ~= Op.CFrameDelta then
        if not v7 then
            W:u8(Op.Prop)
            Codec.varuint(W, a3)
            Codec.varuint(W, a4)
        else
            W:u8(Op.PropLerp)
            Codec.varuint(W, a3)
            Codec.varuint(W, a4)
            W:u8(v4)
        end
        Codec.position(W, a5)
        Codec.rotation(W, v1, v9, v10, v11)
    else
        W:u8(Prop)
        Codec.varuint(W, a3)
        Codec.varuint(W, a4)
        W:u8(v4)
        Codec.cframeDelta(W, v12, v13, v14, K, A, B, C, v1, v9, v10, v11)
    end
    Stream:EndRecord()
end

function u134:_setSequence(a2, a3, a4, a5) -- Line: 1229
    -- upvalues: 
    local v1 = self.SeqStates[a2]
    if not v1 then
        self.SeqStates[a2] = {}
    end
    local v2 = v1[a3]
    if v2 and self.SeqHolders[v2.Key] == a2 then
        self.SeqHolders[v2.Key] = nil
    end
    v1[a3] = {Key = a4, Time = a5}
    self.SeqHolders[a4] = a2
end

function u134:_writeValue(a2, a3, a4, a5, a6, a7, a8) -- Line: 1245
    -- upvalues: Codec (val)
    local ValueScratch = self.ValueScratch
    ValueScratch.len = 0
    Codec.writeValue(ValueScratch, a5, a6)
    local v1 = buffer.readstring(ValueScratch.buf, 0, ValueScratch.len)
    local Groups = self.Groups
    if Groups and self.GroupedProps[a4] then
        local v2 = ("%*:%*:%*:%*"):format(a4, a8, math.floor(a7), v1)
        local v3 = Groups[v2]
        if v3 then
            table.insert(v3.Members, {Inst = a2, Id = a3})
            return
        end
        v3 = {
            PropId = a4,
            Type = a5,
            Value = a6,
            T = a7,
            LerpUnits = a8,
            Encoded = v1,
            Members = {{Inst = a2, Id = a3}},
        }
        Groups[v2] = v3
        table.insert(self.GroupOrder, v3)
        return
    end
    self:_writeSingle(a2, a3, a4, a5, a6, a7, a8, v1)
end

function u134:_writeSingle(a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 1285
    -- upvalues: Sequences (val), Op (val), Codec (val)
    local v1
    local Stream = self.Stream
    Stream:Time(a7)
    local W = Stream.W
    local v2 = if not Sequences.Types[a5] then nil else ("%*:%*"):format(a4, (Sequences.key((Sequences.keypoints(a5, a6)))))
    if v2 then
        v1 = self.SeqHolders[v2]
        local v3 = v1
        if v3 then
            v3 = false
            if v1 ~= a2 then
                v3 = self.Ids[v1]
            end
        end
        local v4 = v3 and self.SeqStates[v1]
        v1 = v4 and v4[a4]
        if v3 and v1 and v1.Time <= a7 then
            Sequences.writeCopy(W, a3, a4, a8, v3)
            Stream:EndRecord()
            self:_setSequence(a2, a4, v2, a7)
            return
        end
    end
    if not (a8 > 0) then
        W:u8(Op.Prop)
        Codec.varuint(W, a3)
        Codec.varuint(W, a4)
    else
        W:u8(Op.PropLerp)
        Codec.varuint(W, a3)
        Codec.varuint(W, a4)
        W:u8(a8)
    end
    v1 = #a9
    W:_ensure(v1)
    buffer.writestring(W.buf, W.len, a9)
    W.len = W.len + v1
    Stream:EndRecord()
    if v2 then
        self:_setSequence(a2, a4, v2, a7)
    end
end

function u134:_flushGroups() -- Line: 1330 -- upvalues: Op (val), Codec (val), Sequences (val)
    local Encoded_2, Id_2, Members, PropId, T, Type, W, v1, v2
    self.Groups = nil
    local GroupOrder = self.GroupOrder
    self.GroupOrder = {}
    local Stream = self.Stream
    local v3 = nil
    local v4 = nil
    local v5 = self
    for i, j in GroupOrder, v3, v4 do
        Members = j.Members
        PropId = j.PropId
        Type = j.Type
        T = j.T
        if #Members ~= 1 then
            table.sort(Members, function(a1, a2) -- Line: 1343
                return a1.Id < a2.Id
            end)
            Stream:Time(T)
            W = Stream.W
            W:u8(Op.PropMany)
            Codec.varuint(W, PropId)
            W:u8(j.LerpUnits)
            Codec.varuint(W, #Members)
            Id_2 = 0
            for k, n in Members do
                Codec.varuint(W, n.Id - Id_2)
                Id_2 = n.Id
            end
            Encoded_2 = j.Encoded
            v2 = #Encoded_2
            W:_ensure(v2)
            buffer.writestring(W.buf, W.len, Encoded_2)
            W.len = W.len + v2
            Stream:EndRecord()
            if Sequences.Types[Type] then
                v1 = ("%*:%*"):format(PropId, (Sequences.key((Sequences.keypoints(Type, j.Value)))))
                for m, i5 in Members do
                    v5:_setSequence(i5.Inst, PropId, v1, T)
                end
            end
        else
            v1 = Members[1]
            v5:_writeSingle(v1.Inst, v1.Id, PropId, Type, j.Value, T, j.LerpUnits, j.Encoded)
        end
    end
end

function u134:_writeMotion(a2, a3, a4, a5, a6) -- Line: 1372
    -- upvalues: Motion (val), Codec (val)
    self.Sampled[a2] = true
    local v1 = self.Samples[a2]
    local T = v1 and v1.T
    local CFrame = v1 and v1.CFrame
    local BeforeT = v1 and v1.BeforeT
    local Before = v1 and v1.Before
    if not v1 then
        self.Samples[a2] = {T = a6, CFrame = a5}
    else
        local T_2 = v1.T
        local CFrame_2 = v1.CFrame
        v1.BeforeT = T_2
        v1.Before = CFrame_2
        v1.T = a6
        v1.CFrame = a5
    end
    v1 = false
    local v2 = self.Motions[a2]
    if v2 then
        if if not (a6 < v2.T) then not Motion.apart(Motion.at(v2.Base, v2.W, v2.V, v2.A, (a6 - v2.T) / 1000), a5, 0.2, 0.02) else false then
            v2.Hits = v2.Hits + 1
            return true, false
        end
        self.Motions[a2] = nil
        v1 = true
        if v2.Hits == 0 then
            self.Untrusted[a2] = true
        end
    end
    if CFrame and T and not (a6 <= T) and not (250 < a6 - T) then
        local Stream, v3, v4, v5, v6, v7, v8
        local v9, v10 = Motion.between(CFrame, a5, (a6 - T) / 1000)
        if v9.Magnitude < 0.002 then
            v9 = Vector3.new(0, 0, 0)
        end
        if v10.Magnitude < 0.02 and v9 == Vector3.new(0, 0, 0) then
            self.Candidates[a2] = nil
            return false, v1
        end
        v2 = Vector3.new(0, 0, 0)
        if v9 == Vector3.new(0, 0, 0) and Before and BeforeT and BeforeT < T and T - BeforeT <= 250 then
            v3, v4 = Motion.accelerating(Before.Position, CFrame.Position, a5.Position, BeforeT / 1000, T / 1000, a6 / 1000)
            if 0.05 <= v4.Magnitude then
                v10 = v3
                v2 = v4
            end
        end
        local v11 = {
            Hits = 0,
            PropId = a4,
            T = a6,
            Base = a5,
            W = v9,
            V = v10,
            A = v2,
        }
        if not self.Untrusted[a2] then
            self.Motions[a2] = v11
            v3, v4, v5, v6 = Codec.quantizeRotation(a5)
            v11 = self.SentCFrames[a2]
            if not v11 then
                self.SentCFrames[a2] = {}
            end
            v8 = v11[a4]
            v7 = false
            if v8 ~= nil then
                v7 = false
                if v8.K == v3 then
                    v7 = false
                    if v8.A == v4 then
                        v7 = false
                        if v8.B == v5 then
                            v7 = v8.C == v6
                        end
                    end
                end
            end
            v11[a4] = {
                Position = a5.Position,
                K = v3,
                A = v4,
                B = v5,
                C = v6,
            }
            Stream = self.Stream
            Stream:Time(a6)
            Motion.write(Stream.W, a3, a4, a5, v9, v10, v2, v7)
            Stream:EndRecord()
            v7 = self.LastSent[a2]
            if v7 then
                v7[a4] = a6
            end
            return true, v1
        end
        local v12 = self.Candidates[a2]
        self.Candidates[a2] = v11
        if v12 then
            v3 = if not (a6 < v12.T) then not Motion.apart(Motion.at(v12.Base, v12.W, v12.V, v12.A, (a6 - v12.T) / 1000), a5, 0.2, 0.02) else false
            if v3 then
                self.Untrusted[a2] = nil
                self.Candidates[a2] = nil
                self.Motions[a2] = v11
                v3, v4, v5, v6 = Codec.quantizeRotation(a5)
                v11 = self.SentCFrames[a2]
                if not v11 then
                    self.SentCFrames[a2] = {}
                end
                v8 = v11[a4]
                v7 = false
                if v8 ~= nil then
                    v7 = false
                    if v8.K == v3 then
                        v7 = false
                        if v8.A == v4 then
                            v7 = false
                            if v8.B == v5 then
                                v7 = v8.C == v6
                            end
                        end
                    end
                end
                v11[a4] = {
                    Position = a5.Position,
                    K = v3,
                    A = v4,
                    B = v5,
                    C = v6,
                }
                Stream = self.Stream
                Stream:Time(a6)
                Motion.write(Stream.W, a3, a4, a5, v9, v10, v2, v7)
                Stream:EndRecord()
                v7 = self.LastSent[a2]
                if v7 then
                    v7[a4] = a6
                end
                return true, v1
            end
        end
        return false, v1
    end
    self.Candidates[a2] = nil
    return false, v1
end

function u134:_checkMotions() -- Line: 1469 -- upvalues: result (ref)
    local PropId, v1, v2, v3
    local v4 = self.Clock()
    local v5 = {}
    for i in self.Motions do
        if not self.Sampled[i] then
            table.insert(v5, i)
        end
    end
    for j, k in v5 do
        v2 = self.Motions[k]
        v3 = self.Ids[k]
        if v3 then
            v1 = result(k, "CFrame")
            self.LastCFrame[k] = v1
            PropId = v2.PropId
            self:_writeProp(k, v3, PropId, v1, v4)
        else
            self.Motions[k] = nil
        end
    end
    table.clear(self.Sampled)
end

function u134:_isCharacterPart(a2) -- Line: 1493 -- types: self: table, a2: userdata
    return self:_characterPlayer(a2) ~= nil
end

function u134._characterPlayer(a1, a2) -- Line: 1498
    -- upvalues: result (ref), Players (val)
    local v1 = result(a2, "Parent")
    if v1 then
        return (Players:GetPlayerFromCharacter(v1))
    end
    return nil
end

function u134:_untrack(a2) -- Line: 1503 -- types: self: table, a2: userdata
    local v1
    local v2 = self.Kinds[a2]
    if v2 == "joint" or v2 == "weld" or v2 == "constraint" then
        v1 = self.JointParts[a2]
        if v1 then
            self:_checkRoots(v1[1], v1[2], (self.Clock()))
        end
        self:_setJointParts(a2, nil, nil)
    end
    if self.Ids[a2] then
        self.Count = self.Count - 1
    end
    self.Registry:Free(a2)
    self.Registry:NotifyUntracked(a2)
    self.Kinds[a2] = nil
    self.Roots[a2] = nil
    self.RootOf[a2] = nil
    self.JointParts[a2] = nil
    self.Held[a2] = nil
    self.InCharacter[a2] = nil
    self.Baked[a2] = nil
    self.BakedMemo[a2] = nil
    self.LastCFrame[a2] = nil
    self.LastSent[a2] = nil
    self.SeqStates[a2] = nil
    self.SentCFrames[a2] = nil
    self.Motions[a2] = nil
    self.Samples[a2] = nil
    self.Candidates[a2] = nil
    self.Untrusted[a2] = nil
    self.WorldPoll.Set[a2] = nil
    self:_setPlayerPolled(a2, nil)
    self.DirtyProps[a2] = nil
    self.DirtyName[a2] = nil
    v1 = {}
    v1[1] = self.Signals
    v1[2] = self.AttachSignals
    local v3 = nil
    local v4 = nil
    for i, j in v1, v3, v4 do
        v2 = j[a2]
        if v2 then
            for k, n in v2 do
                n:Disconnect()
            end
            j[a2] = nil
        end
    end
end

function u134:_untrackTree(a2, a3) -- Line: 1550 -- types: self: table, a2: userdata, a3: userdata?
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

function u134:_watchFiltered(a2) -- Line: 1573 -- upvalues: seedKind (val) -- types: self: table, a2: userdata
    self.Registry:WatchFiltered(a2, function() -- Line: 1574 -- upvalues: self (val), a2 (val), seedKind (upval)
        if self.Destroyed then
            return
        end
        local v1 = self.Clock()
        self.DirtyStructure[a2] = v1
        for i, j in a2:GetDescendants() do
            if seedKind(j) then
                self.DirtyStructure[j] = v1
            end
        end
    end)
end

function u134:_discover(a2, a3) -- Line: 1588
    -- upvalues: seedKind (val), result (ref)
    local v1 = seedKind(a2)
    if v1 == "gui" then
        if self:_inBaked((result(a2, "Parent"))) then
            return
        end
        self.TrackGui(a2)
        return
    end
    if v1 == "baked" and not self.BakeModels then
        return
    end
    if v1 or self.Particles[a2] then
        self:_track(a2, a3)
    end
end

function u134:_mark(a2) -- Line: 1602 -- upvalues: seedKind (val), result (ref) -- types: self: table, a2: userdata
    local v1 = a2:IsA("Animator")
    if not v1 and not seedKind(a2) then
        return
    end
    if self:_hiddenByBake(a2, (result(a2, "Parent"))) then
        return
    end
    if v1 then
        self.WatchAnimator(a2)
        return
    end
    self.DirtyStructure[a2] = (self.Clock())
end

function u134:_walk(a2) -- Line: 1616 -- upvalues: result (ref) -- types: self: table, a2: number
    local v1, v2, v3
    local Registry = self.Registry
    local Pending = self.Pending
    local v4, v5 = a2, self
    while #Pending > 0 do
        if v4 <= os.clock() then
            return false
        end
        v1 = table.remove(Pending)
        v2 = result(v1, "Parent")
        if v2 ~= nil then
            if not Registry:MatchFilter(v1, v2) then
                v5:_discover(v1, (v5.Clock()))
                if v1:IsA("Animator") then
                    v5.WatchAnimator(v1)
                end
                v3 = v1:IsA("BillboardGui") or v1:IsA("SurfaceGui")
                if not v3 and not v5:_inBaked(v1) then
                    for i, j in v1:GetChildren() do
                        table.insert(Pending, j)
                    end
                end
            else
                v5:_watchFiltered(v1)
            end
        end
    end
    return true
end

function u134:_scope(a2) -- Line: 1650 -- upvalues: newWatch (val) -- types: self: table, a2: userdata
    local v1 = newWatch()
    if self.Scoped then
        table.insert(v1.Connections, (a2.DescendantAdded:Connect(function(a1) -- Line: 1655 -- upvalues: self (val)
            self:_mark(a1)
        end)))
    end
    table.insert(self.Pending, a2)
    return v1
end

function closeWatch(a1, a2, a3) -- Line: 1664 -- upvalues: closeWatch (val) -- types: a2: table, a3: userdata
    local v1 = a2[a3]
    if not v1 then
        return
    end
    a2[a3] = nil
    for i, j in v1.Connections do
        j:Disconnect()
    end
    for k, n in v1.Names do
        n:Disconnect()
    end
    for m in v1.Kids do
        closeWatch(a1, a1.Watches, m)
    end
end

function u134:_watchPath(a2, a3) -- Line: 1685
    -- upvalues: newWatch (val), closeWatch (val), result (ref)
    if next(a3.Children) == nil then
        return
    end
    local u7 = newWatch()
    self.Watches[a2] = u7

    local function check(a1) -- Line: 1691
        -- upvalues: u7 (val), closeWatch (upval), self (val), a3 (val), result (upval)
        if u7.Kids[a1] then
            u7.Kids[a1] = nil
            closeWatch(self, self.Watches, a1)
        end
        local v1 = a3.Children[result(a1, "Name")]
        if v1 ~= nil and not self.Destroyed then
            u7.Kids[a1] = true
            if v1.Marked then
                self.Watches[a1] = (self:_scope(a1))
                return
            end
            self:_watchPath(a1, v1)
            return
        end
    end

    local function added(a1) -- Line: 1707 -- upvalues: u7 (val), check (val) -- types: a1: userdata
        if u7.Names[a1] then
            return
        end
        u7.Names[a1] = ((a1:GetPropertyChangedSignal("Name")):Connect(function() -- Line: 1711 -- upvalues: check (upval), a1 (val)
            check(a1)
        end))
        check(a1)
    end

    table.insert(u7.Connections, (a2.ChildAdded:Connect(added)))
    table.insert(u7.Connections, (a2.ChildRemoved:Connect(function(a1) -- Line: 1719 -- upvalues: u7 (val), closeWatch (upval), self (val)
        local v1 = u7.Names[a1]
        if v1 then
            v1:Disconnect()
            u7.Names[a1] = nil
        end
        if u7.Kids[a1] then
            u7.Kids[a1] = nil
            closeWatch(self, self.Watches, a1)
        end
    end)))
    for i, j in a2:GetChildren() do
        added(j)
    end
end

function u134:_markAll(a2) -- Line: 1736 -- types: self: table, a2: table
    local v1 = self.Clock()
    for i, j in a2 do
        self.DirtyStructure[j] = v1
    end
end

function u134:_pin(a2) -- Line: 1744 -- types: self: table, a2: userdata
    if not self.PinSignals[a2] then
        self.PinSignals[a2] = (a2.AncestryChanged:Connect(function() -- Line: 1746 -- upvalues: self (val), a2 (val)
            if self.Registry.Pins[a2] then
                self:_markAll((self.Registry:Pin(a2)))
            end
        end))
    end
    self:_markAll((self.Registry:Pin(a2)))
end

function u134:_unpin(a2) -- Line: 1755 -- types: self: table, a2: userdata
    local v1 = self.PinSignals[a2]
    if v1 then
        v1:Disconnect()
        self.PinSignals[a2] = nil
    end
    self:_markAll((self.Registry:Unpin(a2)))
end

function u134:_characterAdded(a2) -- Line: 1764 -- types: self: table, a2: userdata
    if self.Destroyed then
        return
    end
    self:TrackCharacter(a2)
    if self.Filtered and not self.CharacterScopes[a2] then
        self:_pin(a2)
        self.CharacterScopes[a2] = (self:_scope(a2))
        return
    end
end

function u134:_characterRemoving(a2) -- Line: 1776 -- upvalues: closeWatch (val) -- types: self: table, a2: userdata
    if self.CharacterScopes[a2] then
        closeWatch(self, self.CharacterScopes, a2)
        self:_unpin(a2)
    end
end

function u134:_watchPlayers() -- Line: 1783 -- upvalues: Players (val)
    local function watch(a1) -- Line: 1784 -- upvalues: self (val) -- types: a1: userdata
        table.insert(self.Connections, (a1.CharacterAdded:Connect(function(a1) -- Line: 1787 -- upvalues: self (upval)
            self:_characterAdded(a1)
        end)))
        table.insert(self.Connections, (a1.CharacterRemoving:Connect(function(a1) -- Line: 1793 -- upvalues: self (upval)
            self:_characterRemoving(a1)
        end)))
        if a1.Character then
            self:_characterAdded(a1.Character)
        end
    end

    table.insert(self.Connections, (Players.PlayerAdded:Connect(watch)))
    table.insert(self.Connections, (Players.PlayerRemoving:Connect(function(a1) -- Line: 1804 -- upvalues: self (val)
        self.PlayerPolls[a1] = nil
    end)))
    for i, j in Players:GetPlayers() do
        watch(j)
    end
end

function u134:_watchBaked() -- Line: 1815 -- upvalues: CollectionService (val), BakedTag (val), bakedId (val)
    table.insert(self.Connections, ((CollectionService:GetInstanceAddedSignal(BakedTag)):Connect(function(a1) -- Line: 1818 -- upvalues: bakedId (upval), self (val)
        if bakedId(a1) then
            self:_pin(a1)
        end
    end)))
    table.insert(self.Connections, ((CollectionService:GetInstanceRemovedSignal(BakedTag)):Connect(function(a1) -- Line: 1826 -- upvalues: self (val)
        if self.PinSignals[a1] then
            self:_unpin(a1)
        end
    end)))
    for i, j in CollectionService:GetTagged(BakedTag) do
        if bakedId(j) then
            self:_pin(j)
            table.insert(self.Pending, j)
        end
    end
end

function u134:_watchUnbaked() -- Line: 1842 -- upvalues: CollectionService (val), UnbakedTag (val), closeWatch (val)
    local function added(a1) -- Line: 1843 -- upvalues: self (val) -- types: a1: userdata
        if not self.Unbaked[a1] and not self.Destroyed then
            local v1 = self:_scope(a1)
            self.Unbaked[a1] = v1
            table.insert(v1.Connections, (a1.AncestryChanged:Connect(function() -- Line: 1851 -- upvalues: self (upval), a1 (val)
                table.insert(self.Pending, a1)
            end)))
            table.clear(self.BakedMemo)
            if self.Filtered then
                self:_pin(a1)
            end
            return
        end
    end

    table.insert(self.Connections, ((CollectionService:GetInstanceAddedSignal(UnbakedTag)):Connect(added)))
    table.insert(self.Connections, ((CollectionService:GetInstanceRemovedSignal(UnbakedTag)):Connect(function(a1) -- Line: 1863 -- upvalues: self (val), closeWatch (upval)
        if not self.Unbaked[a1] then
            return
        end
        closeWatch(self, self.Unbaked, a1)
        table.clear(self.BakedMemo)
        if self.PinSignals[a1] then
            self:_unpin(a1)
        end
        self.DirtyStructure[a1] = (self.Clock())
    end)))
    for i, j in CollectionService:GetTagged(UnbakedTag) do
        added(j)
    end
end

function u134:_holdParticleHost(a2) -- Line: 1882 -- types: self: table, a2: userdata
    local v1 = self.ParticleHosts[a2]
    if v1 then
        v1.Count = v1.Count + 1
        return
    end
    v1 = {Count = 1}
    self.ParticleHosts[a2] = v1
    if self.Filtered then
        self:_pin(a2)
        v1.Watch = self:_scope(a2)
    end
end

function u134:_releaseParticleHost(a2) -- Line: 1896 -- types: self: table, a2: userdata
    local v1 = self.ParticleHosts[a2]
    if not v1 then
        return
    end
    v1.Count = v1.Count - 1
    if 0 < v1.Count then
        return
    end
    self.ParticleHosts[a2] = nil
    if v1.Watch then
        for i, j in v1.Watch.Connections do
            j:Disconnect()
        end
    end
    if self.PinSignals[a2] and not self.CharacterScopes[a2] and not self.Baked[a2] and not self.Unbaked[a2] then
        self:_unpin(a2)
    end
end

function u134:AddParticle(a2) -- Line: 1920 -- upvalues: particleHost (val) -- types: self: table, a2: userdata
    if not self.Destroyed and not self:_inBaked(a2) then
        local v1 = particleHost(a2) or a2
        local v2 = self.Particles[a2]
        if v2 == v1 then
            return
        end
        self.Particles[a2] = v1
        self:_holdParticleHost(v1)
        if v2 then
            self:_releaseParticleHost(v2)
        end
        self.DirtyStructure[a2] = (self.Clock())
        return
    end
end

function u134.SetEmissionScale(a1, a2) -- Line: 1939 -- types: a1: table, a2: number
    if a2 ~= a1.EmissionScale then
        a1.EmissionScale = a2
        a1.EmissionScaleDirty = true
    end
end

function u134:_flushEmissionScale() -- Line: 1946
    -- upvalues: EmissionScaleProperty (val), Op (val), Codec (val), RootId (val)
    local EmissionScale = self.EmissionScale
    local v1 = self:_propId("Workspace", EmissionScaleProperty)
    if self.EmissionScaleDirty and EmissionScale and v1 then
        self.EmissionScaleDirty = false
        local Stream = self.Stream
        Stream:Time((self.Clock()))
        local W = Stream.W
        W:u8(Op.Prop)
        Codec.varuint(W, RootId.Workspace)
        Codec.varuint(W, v1)
        W:f32(EmissionScale)
        Stream:EndRecord()
        return
    end
end

function u134.RemoveParticle(a1, a2) -- Line: 1964 -- types: a1: table, a2: userdata
    local v1 = a1.Particles[a2]
    if not v1 then
        return
    end
    a1.Particles[a2] = nil
    a1:_releaseParticleHost(v1)
    a1.DirtyStructure[a2] = (a1.Clock())
end

function u134.WriteEmit(a1, a2, a3, a4) -- Line: 1976
    -- upvalues: Op (val), Codec (val)
    if not a1.Destroyed and a1:_inDomain(a2) then
        local Stream, W, v1
        local Registry = a1.Registry
        local NextId = Registry.NextId
        local v2 = {}
        if not a1:_inBaked(a2) then
            a1:AddParticle(a2)
            if not (a1.Ids[a2] or a1:_track(a2, a4)) then
                return false
            end
            Stream = a1.Stream
            Stream:Time(if not (NextId <= v1) then a4 else math.max(a4, Registry.AddFloor))
            W = Stream.W
            W:u8(Op.Emit)
            Codec.varuint(W, v1)
            Codec.varuint(W, a3)
            Codec.varuint(W, #v2)
            for i, j in v2 do
                Codec.str(W, j)
            end
            Stream:EndRecord()
            return true
        end
        local Parent = a2
        while Parent do
            if Parent == workspace or a1:_isBakedRoot(Parent) then
                break
            end
            table.insert(v2, 1, Parent.Name)
            Parent = Parent.Parent
        end
        if Parent ~= nil and Parent ~= workspace then
            if not (a1.Ids[Parent] or a1:_track(Parent, a4)) then
                return false
            end
            Stream = a1.Stream
            Stream:Time(if not (NextId <= v1) then a4 else math.max(a4, Registry.AddFloor))
            W = Stream.W
            W:u8(Op.Emit)
            Codec.varuint(W, v1)
            Codec.varuint(W, a3)
            Codec.varuint(W, #v2)
            for k, n in v2 do
                Codec.str(W, n)
            end
            Stream:EndRecord()
            return true
        end
        return false
    end
    return false
end

function u134.Snapshot(a1) -- Line: 2023 -- upvalues: Lighting (val)
    local v1
    if not a1.Scoped then
        table.insert(a1.Connections, (workspace.DescendantAdded:Connect(function(a1_2) -- Line: 2032 -- upvalues: a1 (val)
            a1:_mark(a1_2)
        end)))
        for i, j in workspace:GetChildren() do
            table.insert(a1.Pending, j)
        end
    else
        v1 = a1.Registry:FilterRoot(workspace)
        if v1 then
            a1:_watchPath(workspace, v1)
        end
    end
    a1:_watchPlayers()
    if a1.BakeModels then
        a1:_watchUnbaked()
    end
    if a1.Filtered and a1.BakeModels then
        a1:_watchBaked()
    end

    local function markSky(a1_2) -- Line: 2048 -- upvalues: a1 (val) -- types: a1_2: userdata
        if a1_2:IsA("Sky") then
            a1.DirtyStructure[a1_2] = (a1.Clock())
        end
    end

    table.insert(a1.Connections, (Lighting.ChildAdded:Connect(markSky)))
    table.insert(a1.Connections, (Lighting.ChildRemoved:Connect(markSky)))
    v1 = a1.Clock()
    for k, n in Lighting:GetChildren() do
        if n:IsA("Sky") then
            a1:_track(n, v1)
        end
    end
    while true do
        if a1:_walk((os.clock()) + 0.002) then
            break
        end
        task.wait()
        if a1.Destroyed then
            return
        end
    end
end

function u134:_flushStructure() -- Line: 2071 -- upvalues: result (ref), Op (val), Codec (val)
    local DirtyStructure_2, Kids, W, W_2, W_3, v1, v2, v3, v4, v5, v6, v7
    local Stream = self.Stream
    local Ids = self.Ids
    local DirtyStructure = self.DirtyStructure
    self.DirtyStructure = {}
    local Registry = self.Registry
    local v8 = {}
    local v9 = {}
    local v10 = {}
    local v11 = {}
    local v12 = nil
    local v13 = nil
    local v14 = self
    for i in DirtyStructure, v12, v13 do
        v1 = Ids[i]
        if v1 and v14.Signals[i] then
            v2 = result(i, "Parent")
            if v2 == nil or not v14:_inDomain(i) or v14:_hiddenByBake(i, v2) then
                v8[v1] = true
                table.insert(v9, i)
            elseif v14.Kinds[i] ~= "particle" then
                if Registry.FilterAny then
                    v1 = {}
                    Kids = v14.Kids
                    if Registry:Rematch(i, v2, Kids, v1) then
                        table.insert(v1, i)
                    end
                    for j, k in v1 do
                        v11[k] = DirtyStructure[i]
                    end
                end
                if not v11[i] then
                    table.insert(v10, i)
                end
            elseif v14.Particles[i] then
                if Registry.FilterAny then
                    v1 = {}
                    Kids = v14.Kids
                    if Registry:Rematch(i, v2, Kids, v1) then
                        table.insert(v1, i)
                    end
                    for n, m in v1 do
                        v11[m] = DirtyStructure[i]
                    end
                end
                if not v11[i] then
                    table.insert(v10, i)
                end
            else
                v8[v1] = true
                table.insert(v9, i)
            end
        end
    end
    for i5 in v11 do
        v8[Ids[i5]] = true
        table.insert(v9, i5)
        v14:_watchFiltered(i5)
    end
    v12 = nil
    v13 = nil
    for i6, i7 in v9, v12, v13 do
        v7 = Ids[i7]
        if v7 then
            v1 = v14.Registry.ParentIds[i7]
            if not v8[v1] then
                Stream:Time(DirtyStructure[i7] or v11[i7])
                W_3 = Stream.W
                W_3:u8(Op.Remove)
                Codec.varuint(W_3, v7)
                Stream:EndRecord()
            end
            v5 = v14.Registry.ById[v1]
            v14:_untrackTree(i7, v5)
        end
    end
    v12 = nil
    v13 = nil
    for i8, i9 in v10, v12, v13 do
        v11 = Ids[i9]
        if v11 then
            v9 = DirtyStructure[i9]
            v8 = result(i9, "Parent")
            v1 = v14:_parentIdOf(i9, v8, v9)
            v2 = v14.Registry.ParentIds[i9]
            if v1 == nil then
                Stream:Time(v9)
                W = Stream.W
                W:u8(Op.Remove)
                Codec.varuint(W, v11)
                Stream:EndRecord()
                v6 = v14.Registry.ById[v2]
                v14:_untrackTree(i9, v6)
            elseif v1 ~= v2 then
                v14.Registry.ParentIds[i9] = v1
                v3 = v14.Registry.ById[v2]
                v4 = v3 and v14.Kids[v3]
                if v4 then
                    v4[i9] = nil
                end
                v5 = v14:_kidsOf(v8)
                v5[i9] = true
                Stream:Time((math.max(v9, v14.Registry.AddFloor)))
                W_2 = Stream.W
                W_2:u8(Op.Reparent)
                Codec.varuint(W_2, v11)
                Codec.varuint(W_2, v1)
                Stream:EndRecord()
                v14:_updateInCharacter(i9)
                if v14.Roots[i9] then
                    v14:_updatePolling(i9)
                end
            end
        end
    end
    v10 = {}
    for i10 in DirtyStructure do
        if not Ids[i10] then
            table.insert(v10, i10)
        end
    end
    table.sort(v10, function(a1, a2) -- Line: 2180 -- upvalues: DirtyStructure (val)
        return DirtyStructure[a1] < DirtyStructure[a2]
    end)
    local v15 = os.clock() + 0.0015
    for i11, i12 in v10 do
        if v15 <= os.clock() then
            DirtyStructure_2 = v14.DirtyStructure
            v1 = #v10
            for i13 = i11, v1 do
                v4 = v10[i13]
                if DirtyStructure_2[v4] == nil then
                    DirtyStructure_2[v4] = DirtyStructure[v4]
                end
            end
            return
        end
        if result(i12, "Parent") ~= nil then
            v4 = DirtyStructure[i12]
            v14:_discover(i12, v4)
        end
    end
end

function u134:_flushRoots() -- Line: 2201 -- upvalues: result (ref), AssemblyRootProperty (val)
    local err, success, v1, v2, v3, v4, v5, v6, v7, v8
    local RootCheck = self.RootCheck
    self.RootCheck = {}
    local v9 = self
    while next(RootCheck) do
        v5 = {}
        v6 = nil
        v7 = nil
        for i, j in RootCheck, v6, v7 do
            v8 = self.Ids[i]
            if v8 and v9.Kinds[i] == "part" then
                success, err = pcall(result, i, "AssemblyRootPart")
                if success then
                    if err then
                        if err ~= i and v9.RootOf[i] ~= err and not RootCheck[err] then
                            v5[err] = j
                        end
                        v9.RootOf[i] = err
                    end
                    v1 = v9:_isRecordedRoot(i, err)
                    v3 = v9.Roots[i] == true
                    if v1 ~= v3 then
                        v9.Roots[i] = v1
                        v2 = result(i, "ClassName")
                        v3 = v9:_propId(v2, AssemblyRootProperty)
                        if v3 then
                            v9:_writeProp(i, v8, v3, v1, j)
                        end
                        if v1 then
                            v3 = v9:_propId(v2, "CFrame")
                            v4 = result(i, "CFrame")
                            if v3 and v9.LastCFrame[i] ~= v4 then
                                v9.LastCFrame[i] = v4
                                v9:_writeProp(i, v8, v3, v4, j)
                            end
                        end
                        v9:_updatePolling(i)
                    end
                end
            end
        end
        RootCheck = v5
    end
end

function u134:_flushProps() -- Line: 2247 -- upvalues: result (ref), u77 (val), AssemblyRootProperty (val)
    local Id, Name, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local Ids = self.Ids
    local DirtyProps = self.DirtyProps
    self.DirtyProps = {}
    self.Groups = {}
    local ClassProps = self.Registry.ClassProps
    for i5 in self.AnchorCheck do
        if Ids[i5] and self.Roots[i5] then
            self:_updatePolling(i5)
        end
    end
    table.clear(self.AnchorCheck)
    local v15 = nil
    local v16 = nil
    local v17 = self
    for i6, i7 in DirtyProps, v15, v16 do
        v14 = Ids[i6]
        v1 = v17.Kinds[i6]
        if v14 and v1 then
            v2 = result(i6, "ClassName")
            v3 = v17.Held[i6]
            v4 = ClassProps[v2]
            if v4 then
                v5 = nil
                if v1 == "part" then
                    v6 = v17.ByName[v2] and i7[v17.ByName[v2].Transparency]
                    if v6 then
                        v7 = 1 <= (result(i6, "Transparency"))
                        if not v3 then
                            if v7 then
                                v17.Held[i6] = true
                                v3 = true
                            end
                        elseif not v7 then
                            v17.Held[i6] = nil
                            v3 = nil
                            v5 = v6
                        elseif v7 then
                            v17.Held[i6] = true
                            v3 = true
                        end
                    end
                end
                v6 = false
                v7 = v4
                v8 = nil
                v9 = nil
                for i8, i9 in v7, v8, v9 do
                    Id = i9.Id
                    Name = i9.Name
                    v11 = i7[Id]
                    if v11 or v5 and u77[Name] then
                        v11 = v11 or v5
                        if not v3 then
                            if Name ~= AssemblyRootProperty then
                                if v1 ~= "weld" or Name ~= "C0" then
                                    v12, v13 = v17:_read(i6, Name)
                                    if v12 then
                                        if v1 ~= "part" or Name ~= "CFrame" then
                                            if v1 == "joint" or v1 == "weld" or v1 == "constraint" then
                                                if Name == "Part0" or Name == "Part1" or Name == "Enabled" then
                                                    v6 = true
                                                end
                                            end
                                            v17:_writeProp(i6, v14, Id, v13, v11)
                                        elseif v17.Roots[i6] and v17.LastCFrame[i6] ~= v13 then
                                            v17.LastCFrame[i6] = v13
                                            if v1 == "joint" or v1 == "weld" or v1 == "constraint" then
                                                if Name == "Part0" or Name == "Part1" or Name == "Enabled" then
                                                    v6 = true
                                                end
                                            end
                                            v17:_writeProp(i6, v14, Id, v13, v11)
                                        end
                                    end
                                end
                            end
                        elseif not u77[Name] and Name ~= AssemblyRootProperty then
                            if v1 ~= "weld" or Name ~= "C0" then
                                v12, v13 = v17:_read(i6, Name)
                                if v12 then
                                    if v1 ~= "part" or Name ~= "CFrame" then
                                        if v1 == "joint" or v1 == "weld" or v1 == "constraint" then
                                            if Name == "Part0" or Name == "Part1" or Name == "Enabled" then
                                                v6 = true
                                            end
                                        end
                                        v17:_writeProp(i6, v14, Id, v13, v11)
                                    elseif v17.Roots[i6] and v17.LastCFrame[i6] ~= v13 then
                                        v17.LastCFrame[i6] = v13
                                        if v1 == "joint" or v1 == "weld" or v1 == "constraint" then
                                            if Name == "Part0" or Name == "Part1" or Name == "Enabled" then
                                                v6 = true
                                            end
                                        end
                                        v17:_writeProp(i6, v14, Id, v13, v11)
                                    end
                                end
                            end
                        end
                    end
                end
                if v6 then
                    v5 = v17.Clock()
                    v4 = v17.JointParts[i6]
                    if v4 then
                        v17:_checkRoots(v4[1], v4[2], v5)
                    end
                    v7, v8 = v17:_jointEnds(i6)
                    v17:_setJointParts(i6, v7, v8)
                    v17:_checkRoots(v7, v8, v5)
                    if v1 == "weld" then
                        v8 = v17:_propId(v2, "C0")
                        v9, v10 = v17:_read(i6, "C0")
                        if v8 and v9 then
                            v17:_writeProp(i6, v14, v8, v10, v5)
                        end
                    end
                end
            end
        end
    end
    v17:_flushGroups()
end

function u134:_flushNames() -- Line: 2344 -- upvalues: Op (val), Codec (val)
    local W, v1
    local DirtyName = self.DirtyName
    self.DirtyName = {}
    local Stream = self.Stream
    for i, j in DirtyName do
        v1 = self.Ids[i]
        if v1 and self.Signals[i] then
            Stream:Time(j)
            W = Stream.W
            W:u8(Op.Rename)
            Codec.varuint(W, v1)
            Codec.str(W, i.Name)
            Stream:EndRecord()
        end
    end
end

function u134:_poll(a2) -- Line: 2362 -- upvalues: result (ref), cframeMoved (val) -- types: self: table, a2: table
    local v1, v2, v3, v4, v5, v6
    local List = a2.List
    local Set = a2.Set
    local v7 = #List
    if v7 == 0 then
        return
    end
    local Ids = self.Ids
    local v8 = os.clock() + 0.001
    local v9 = 0
    local Cursor = a2.Cursor
    local v10 = self.Clock()
    while v9 < math.min(v7, 400) do
        if not (os.clock() < v8) then
            break
        end
        if #List < Cursor then
            Cursor = 1
        end
        v2 = List[Cursor]
        v9 = v9 + 1
        v3 = v2 and Ids[v2]
        if v2 and Set[v2] and v3 then
            Cursor = Cursor + 1
            v4 = result(v2, "CFrame")
            v5 = v1.LastCFrame[v2]
            if not v5 or cframeMoved(v5, v4) then
                v1.LastCFrame[v2] = v4
                v6 = v1:_propId(result(v2, "ClassName"), "CFrame")
                if v6 then
                    v1:_writeProp(v2, v3, v6, v4, v10, true)
                end
            end
            continue
        end
        List[Cursor] = List[#List]
        List[#List] = nil
        if #List == 0 then
            break
        end
    end
    a2.Cursor = Cursor
end

function u134:_followedRoot(a2) -- Line: 2406 -- upvalues: u101 (val), result (ref) -- types: self: table, a2: userdata
    local RootPart
    if u101[a2.CameraType] then
        return nil
    end
    local CameraSubject = a2.CameraSubject
    if not (if CameraSubject then if not CameraSubject:IsA("Humanoid") then if not CameraSubject:IsA("BasePart") then if not CameraSubject:IsA("Model") then nil else CameraSubject.PrimaryPart else CameraSubject else CameraSubject.RootPart else nil) then
        return nil
    end
    local v1 = if not self.Roots[RootPart] then result(RootPart, "AssemblyRootPart") else RootPart
    if v1 and self.Ids[v1] and self.Roots[v1] then
        return v1
    end
    return nil
end

function u134:_sampleCamera() -- Line: 2418 -- upvalues: result (ref)
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return nil
    end
    local v1 = self:_followedRoot(CurrentCamera)
    return {
        CFrame = CurrentCamera.CFrame,
        Fov = CurrentCamera.FieldOfView,
        Focus = CurrentCamera.Focus.Position,
        Root = v1,
        RootPosition = if not v1 then Vector3.new(0, 0, 0) else result(v1, "Position"),
    }
end

function u134:_lerpUnits(a2, a3) -- Line: 2433 -- types: self: table, a2: number, a3: boolean
    local v1 = a2 - self.LastCameraTime
    if a3 and v1 > 0 and v1 <= 300 then
        return (math.clamp(math.round(v1 / 10), 1, 255))
    end
    return 0
end

function u134:_flushCamera() -- Line: 2440 -- upvalues: cframeMoved (val), Op (val), Codec (val)
    local CameraSample = self.CameraSample or self:_sampleCamera()
    if not CameraSample then
        return
    end
    local Root = CameraSample.Root
    if Root and self.Ids[Root] and self.Roots[Root] then
        self:_flushFollow(CameraSample, Root)
        return
    end
    local CFrame = CameraSample.CFrame
    local Fov = CameraSample.Fov
    local LastCamera = self.LastCamera
    if LastCamera and not cframeMoved(LastCamera, CFrame) and (math.abs(Fov - self.LastFov)) < 0.05 then
        return
    end
    local v1 = self.Clock()
    local v2 = self:_lerpUnits(v1, LastCamera ~= nil)
    self.LastCamera = CFrame
    self.LastFov = Fov
    self.Follow = nil
    self.LastCameraTime = v1
    local Stream = self.Stream
    Stream:Time(v1)
    local W = Stream.W
    W:u8(Op.Camera)
    W:u8(v2)
    Codec.cframe(W, CFrame)
    W:f32(Fov)
    Stream:EndRecord()
end

function u134:_flushFollow(a2, a3) -- Line: 2473
    -- upvalues: cframeMoved (val), Op (val), Codec (val)
    local CFrame = a2.CFrame
    local Fov = a2.Fov
    local v1 = CFrame.Position - a2.RootPosition
    local Focus = a2.Focus - a2.RootPosition
    local Follow = self.Follow
    local v2 = 15
    local Rotation = CFrame.Rotation
    if Follow and Follow.Root == a3 then
        v2 = 0
        if not cframeMoved(Follow.Rotation.Rotation, Rotation.Rotation) then
            Rotation = Follow.Rotation
        else
            v2 = bit32.bor(v2, 4)
        end
        if 0.02 < (Follow.Focus + Rotation * Follow.Offset - v1).Magnitude then
            if not (0.02 < (Focus - Follow.Focus).Magnitude) then
                Focus = Follow.Focus
            else
                v2 = bit32.bor(v2, 1)
            end
            v2 = bit32.bor(v2, 2)
        end
        if 0.05 <= (math.abs(Fov - Follow.Fov)) then
            v2 = bit32.bor(v2, 8)
        end
        if v2 == 0 then
            return
        end
    end
    local Offset = if not bit32.btest(v2, 2) then Follow.Offset else Rotation:VectorToObjectSpace(v1 - Focus)
    v1 = self.Clock()
    local v3 = false
    if Follow ~= nil then
        v3 = Follow.Root == a3
    end
    local v4 = self:_lerpUnits(v1, v3)
    self.Follow = {
        Root = a3,
        Focus = Focus,
        Offset = Offset,
        Rotation = Rotation,
        Fov = if not bit32.btest(v2, 8) then Follow.Fov else Fov,
    }
    self.LastCamera = nil
    self.LastCameraTime = v1
    local Stream = self.Stream
    Stream:Time(v1)
    local W = Stream.W
    W:u8(Op.CameraFollow)
    W:u8(v4)
    Codec.varuint(W, self.Ids[a3])
    W:u8(v2)
    if bit32.btest(v2, 1) then
        W:f32(Focus.X)
        W:f32(Focus.Y)
        W:f32(Focus.Z)
    end
    if bit32.btest(v2, 2) then
        W:f32(Offset.X)
        W:f32(Offset.Y)
        W:f32(Offset.Z)
    end
    if bit32.btest(v2, 4) then
        Codec.rotation(W, Codec.quantizeRotation(Rotation))
    end
    if bit32.btest(v2, 8) then
        W:f32(Fov)
    end
    Stream:EndRecord()
end

function u134:TrackCharacter(a2) -- Line: 2546 -- types: self: table, a2: userdata
    for i, j in a2:GetDescendants() do
        if self.Ids[j] and self.Kinds[j] then
            self:_updateInCharacter(j)
            if self.Roots[j] then
                self:_updatePolling(j)
            end
        end
    end
end

function u134.WriteCamera(a1) -- Line: 2558
    a1.LastCamera = nil
    a1.Follow = nil
    a1.LastCameraTime = (-1 / 0)
    a1.CameraSample = nil
    a1:_flushCamera()
end

function u134:_pollBaked() -- Line: 2568
    -- upvalues: BakedOriginAttribute (val), cframeMoved (val), result (ref), PivotProperty (val)
    local Attribute, Pivot, v1, v2, v3
    local v4 = self.Clock()
    local v5 = nil
    local v6 = nil
    local v7 = self
    for i in self.Baked, v5, v6 do
        v1 = v7.Ids[i]
        if v1 and i:IsA("Model") then
            Attribute = i:GetAttribute(BakedOriginAttribute)
            Pivot = i:GetPivot()
            v2 = if typeof(Attribute) ~= "CFrame" then Pivot else Pivot * Attribute:Inverse()
            v3 = v7.LastCFrame[i]
            if not v3 or cframeMoved(v3, v2) then
                v7.LastCFrame[i] = v2
                v3 = v7:_propId(result(i, "ClassName"), PivotProperty)
                if v3 then
                    v7:_writeProp(i, v1, v3, v2, v4, true)
                end
            end
        end
    end
end

function u134.Flush(a1) -- Line: 2589
    table.clear(a1.BakedMemo)
    a1:_flushStructure()
    a1:_walk((os.clock()) + 0.001)
    a1:_flushNames()
    a1:_flushRoots()
    a1:_flushProps()
    a1:_flushRoots()
    a1:_pollBaked()
    a1:_poll(a1.WorldPoll)
    a1:_checkMotions()
    a1:_flushCamera()
    a1:_flushEmissionScale()
end

function u134.PollPlayers(a1) -- Line: 2609 -- upvalues: Observability (val)
    local v1
    local v2 = os.clock()
    local v3 = v2 + Observability.DefaultCaptureInterval
    local v4 = nil
    local v5 = nil
    for i, j in a1.PlayerPolls, v4, v5 do
        if next(j.Queue.Set) ~= nil then
            if j.Next <= v2 then
                v1 = Observability.CaptureIntervalOf(i)
                j.Next = j.Next + v1
                if j.Next <= v2 then
                    j.Next = v2 + v1
                end
                a1:_poll(j.Queue)
            end
            v3 = math.min(v3, j.Next)
        end
    end
    return v3
end

function u134.Destroy(a1) -- Line: 2630 -- upvalues: RunService (val), closeWatch (val), newPollQueue (val)
    local v1, v2
    a1.Destroyed = true
    RunService:UnbindFromRenderStep("UGReplayCameraSample")
    a1.CameraSample = nil
    a1.Follow = nil
    for i, j in a1.Connections do
        j:Disconnect()
    end
    table.clear(a1.Connections)
    local v3 = {a1.Signals, a1.AttachSignals}
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for k, n in v3, v4, v5 do
        v1 = nil
        v2 = nil
        for m, i5 in n, v1, v2 do
            for i6, i7 in i5 do
                i7:Disconnect()
            end
        end
        table.clear(n)
    end
    v3 = {v6.Watches, v6.CharacterScopes, v6.Unbaked}
    v4 = nil
    v5 = nil
    for i8, i9 in v3, v4, v5 do
        for i10 in i9 do
            closeWatch(v6, i9, i10)
        end
    end
    v4 = nil
    v5 = nil
    for i11, i12 in v6.ParticleHosts, v4, v5 do
        if i12.Watch then
            for i13, i14 in i12.Watch.Connections do
                i14:Disconnect()
            end
        end
    end
    table.clear(v6.ParticleHosts)
    table.clear(v6.Particles)
    for i15, i16 in v6.PinSignals do
        i16:Disconnect()
    end
    table.clear(v6.PinSignals)
    table.clear(v6.Kids)
    table.clear(v6.Kinds)
    table.clear(v6.Roots)
    table.clear(v6.RootOf)
    table.clear(v6.JointParts)
    table.clear(v6.TerrainDriven)
    table.clear(v6.Held)
    table.clear(v6.InCharacter)
    table.clear(v6.Baked)
    table.clear(v6.BakedMemo)
    table.clear(v6.LastCFrame)
    table.clear(v6.SentCFrames)
    table.clear(v6.LastSent)
    table.clear(v6.SeqStates)
    table.clear(v6.SeqHolders)
    v6.WorldPoll = newPollQueue()
    table.clear(v6.PlayerPolls)
    table.clear(v6.PolledBy)
    table.clear(v6.Pending)
    v6.DirtyStructure = {}
    v6.DirtyName = {}
    v6.DirtyProps = {}
    v6.RootCheck = {}
end

return u134