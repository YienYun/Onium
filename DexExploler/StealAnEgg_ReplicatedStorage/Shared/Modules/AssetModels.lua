-- Script path: ReplicatedStorage.Shared.Modules.AssetModels
-- Decompile time: 6.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Heartbeat = game:GetService("RunService").Heartbeat
local Assets = require(ReplicatedStorage.Data.Assets)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local AssetModels = ReplicatedStorage.AssetModels
local u30 = {}
local u31 = {}
local u32 = {}

local function asModel(a1, a2) -- Line: 30 -- types: a1: userdata?, a2: string
    local v1 = assert(a1, (("the AssetModels folder holds nothing named %*"):format(a2)))
    assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a2, v1.ClassName)))
    return v1
end

local function present(a1) -- Line: 36 -- upvalues: AssetModels (val) -- types: a1: string
    local v1 = AssetModels:FindFirstChild(a1)
    local v2 = v1
    if v2 then
        v2 = assert(v1, (("the AssetModels folder holds nothing named %*"):format(a1)))
        assert(v2:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v2.ClassName)))
    end
    return v2
end

local function awaited(a1, a2) -- Line: 42 -- upvalues: AssetModels (val) -- types: a1: string, a2: number?
    local v1 = assert(AssetModels:WaitForChild(a1, a2 or 30), (("the AssetModels folder holds nothing named %*"):format(a1)))
    assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v1.ClassName)))
    return v1
end

function u32.Resolve(a1) -- Line: 47 -- upvalues: t (val), Constants (val), AssetModels (val) -- types: a1: string
    local v1
    t.strict(t.string)(a1)
    if Constants.IS_CLIENT then
        v1 = assert(AssetModels:WaitForChild(a1, 30), (("the AssetModels folder holds nothing named %*"):format(a1)))
        assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v1.ClassName)))
        return v1
    end
    local v2 = AssetModels:FindFirstChild(a1)
    v1 = v2
    if v1 then
        v1 = assert(v2, (("the AssetModels folder holds nothing named %*"):format(a1)))
        assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v1.ClassName)))
    end
    return v1
end

local function measure(a1) -- Line: 52 -- upvalues: t (val), u32 (val), ModelBounds (val) -- types: a1: string
    local v1
    t.strict(t.string)(a1)
    local v2 = assert(u32.Resolve(a1), (("no template replicated for %*"):format(a1)))
    local PrimaryPart = v2.PrimaryPart or v2:FindFirstChild("HumanoidRootPart")
    local v3 = false
    if PrimaryPart ~= nil then
        v3 = PrimaryPart:IsA("BasePart")
    end
    assert(v3, (("the %* template has no root part"):format(a1)))
    local Scale = v2:GetScale()
    local v4 = ("the %* template is scaled to %*, which is not usable"):format(a1, Scale)
    assert(Scale > 0, v4)
    v3, v1 = ModelBounds(v2)
    return {
        RelativeCFrame = (PrimaryPart.CFrame.Rotation + (v3.Position - Vector3.new(0, v1.Y * 0.5, 0))):ToObjectSpace(v3),
        Size = v1,
        TemplateScale = Scale,
    }
end

function u32.GetVisibleBoundsData(a1) -- Line: 72 -- upvalues: t (val), u30 (val), measure (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = u30[a1] or measure(a1)
    u30[a1] = v1
    return v1
end

function u32.Await(a1, a2) -- Line: 81 -- upvalues: t (val), AssetModels (val) -- types: a1: string, a2: number?
    t.strict(t.string)(a1)
    t.strict(t.optional(t.number))(a2)
    local v1 = assert(AssetModels:WaitForChild(a1, a2 or 30), (("the AssetModels folder holds nothing named %*"):format(a1)))
    assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v1.ClassName)))
    return v1
end

function u32.GetAssetModelIfReplicated(a1) -- Line: 88 -- upvalues: t (val), AssetModels (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = AssetModels:FindFirstChild(a1)
    local v2 = v1
    if v2 then
        v2 = assert(v1, (("the AssetModels folder holds nothing named %*"):format(a1)))
        assert(v2:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v2.ClassName)))
    end
    return v2
end

function u32.SyncScaleFor(a1) -- Line: 93
    -- upvalues: t (val), Assets (val), AssetModels (val), u31 (val)
    t.strict(t.string)(a1)
    local v1 = Assets.Directory[a1]
    if v1 then
        local v2 = AssetModels:FindFirstChild(a1)
        v1 = v2
        if v1 then
            v1 = assert(v2, (("the AssetModels folder holds nothing named %*"):format(a1)))
            assert(v1:IsA("Model"), (("AssetModels.%* is a %*, not a Model"):format(a1, v1.ClassName)))
        end
    end
    if v1 then
        u31[a1] = (v1:GetScale())
    end
end

function u32.GetBaseModelScale(a1) -- Line: 103 -- upvalues: t (val), Assets (val), u31 (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = assert(Assets.Directory[a1], (("unknown asset species %*"):format(a1)))
    return u31[a1] or v1.BaseModelScale
end

function u32.SyncAllScales() -- Line: 110 -- upvalues: Assets (val), u32 (val)
    for k in pairs(Assets.Directory) do
        u32.SyncScaleFor(k)
    end
end

function u32.GetAssetModelsFolder() -- Line: 116 -- upvalues: AssetModels (val)
    return AssetModels
end

local function clearQueryFlagsOverFrames(a1) -- Line: 123 -- upvalues: Heartbeat (val) -- types: a1: userdata
    task.spawn(function() -- Line: 124 -- upvalues: a1 (val), Heartbeat (upval)
        local v1
        local v2 = {a1}
        local v3 = 1
        local v4 = 0
        local v5 = os.clock() + 0.002
        while v3 <= #v2 do
            v1 = v2[v3]
            v2[v3] = nil
            v3 = v3 + 1
            if v1:IsA("BasePart") then
                v1.CanQuery = false
                v1.CanTouch = false
            end
            for i, j in v1:GetChildren() do
                v2[#v2 + 1] = j
            end
            v4 = v4 + 1
            if v4 >= 64 then
                if v5 <= os.clock() then
                    Heartbeat:Wait()
                    v5 = os.clock() + 0.002
                end
            end
        end
    end)
end

if Constants.IS_SERVER then
    task.spawn(function() -- Line: 124 -- upvalues: AssetModels (val), Heartbeat (val)
        local v1
        local v2 = {AssetModels}
        local v3 = 1
        local v4 = 0
        local v5 = os.clock() + 0.002
        while v3 <= #v2 do
            v1 = v2[v3]
            v2[v3] = nil
            v3 = v3 + 1
            if v1:IsA("BasePart") then
                v1.CanQuery = false
                v1.CanTouch = false
            end
            for i, j in v1:GetChildren() do
                v2[#v2 + 1] = j
            end
            v4 = v4 + 1
            if v4 >= 64 then
                if v5 <= os.clock() then
                    Heartbeat:Wait()
                    v5 = os.clock() + 0.002
                end
            end
        end
    end)
    u32.SyncAllScales()
end
return u32