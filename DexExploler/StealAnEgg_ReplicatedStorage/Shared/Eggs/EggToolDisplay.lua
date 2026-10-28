-- Script path: ReplicatedStorage.Shared.Eggs.EggToolDisplay
-- Decompile time: 2.87 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local EggRenderer = require(script.Parent.EggRenderer)
local Log = require(ReplicatedStorage.Packages.Log)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local u40 = Log.new()
local u41 = {}
u41.__index = u41
u41.__class = "EggToolDisplay"

function u41.new(a1, a2) -- Line: 40
    -- upvalues: t (val), u41 (val), Trove (val), EggRenderer (val), u40 (val)
    t.strict(t.instanceIsA("Tool"))(a1)
    local v1 = setmetatable({}, u41)
    v1._trove = Trove.new()
    v1._tool = a1
    v1._renderResult = EggRenderer.RenderVisual(a2, a1)
    v1:_init()
    ;(u40:AtDebug()):Log((("Attached egg tool display for %*"):format(a2.UID)))
    return v1
end

local function getStringAttribute(a1, a2) -- Line: 57 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    if typeof(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    return nil
end

local function positionModel(a1, a2) -- Line: 62 -- upvalues: ModelBounds (val) -- types: a1: userdata
    local Handle = a1:WaitForChild("Handle")
    assert(Handle:IsA("BasePart"), (("Missing egg tool handle for %*"):format((a1:GetFullName()))))
    local Model = a2.Model
    local Pivot = Model:GetPivot()
    local v1, v2 = ModelBounds(Model)
    Model:PivotTo(Handle.CFrame * ((v1 * CFrame.new(0, v2.Y * -0.5, v2.Z * 0.1)):ToObjectSpace(Pivot)))
    return Handle
end

function u41.IsEggTool(a1) -- Line: 81 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Tool"))(a1)
    return a1:GetAttribute("ItemType") == "AssetEgg"
end

function u41.GetToolUid(a1) -- Line: 86 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Tool"))(a1)
    local Attribute = a1:GetAttribute("UID")
    if typeof(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    return nil
end

function u41:Destroy() -- Line: 91
    self._trove:Destroy()
end

function u41.SyncParasite(a1, a2) -- Line: 93 -- upvalues: ParasiteVisual (val) -- types: a2: boolean?
    ParasiteVisual.Attach(a1._renderResult.Model, a2)
end

function u41:_init() -- Line: 101 -- upvalues: positionModel (val)
    local v1
    self._trove:Add(self._renderResult.Model)
    local v2 = positionModel(self._tool, self._renderResult)
    local v3 = self._renderResult.VisibleParts[1]
    if not v2.Anchored then
        v1 = Instance.new("WeldConstraint")
    else
        local Motor6D = Instance.new("Motor6D")
        Motor6D.C0 = v3.CFrame:ToObjectSpace(v2.CFrame)
        v1 = Motor6D
    end
    v1.Part0 = v3
    v1.Part1 = v2
    v1.Parent = v3
    self._trove:Add(v1)
end

return u41