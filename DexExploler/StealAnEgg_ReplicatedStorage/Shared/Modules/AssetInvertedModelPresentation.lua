-- Script path: ReplicatedStorage.Shared.Modules.AssetInvertedModelPresentation
-- Decompile time: 5.11 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u19 = CFrame.Angles(0, 0, 3.141592653589793)
local u20 = {"Size", "CFrame", "PivotOffset", "RootPriority", "CollisionGroup"}
local u26 = {
    Transparency = 1,
    CastShadow = false,
    Anchored = true,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    Massless = true,
}
local v1 = {}

local function childOfClass(a1, a2, a3) -- Line: 39 -- types: a1: userdata, a2: string, a3: string
    local v1 = assert(a1:FindFirstChild(a2), (("%* lacks %*"):format(a1:GetFullName(), a2)))
    assert(v1:IsA(a3), (("%* should have been a %*"):format(v1:GetFullName(), a3)))
    return v1
end

local function parkWelds(a1) -- Line: 45 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("WeldConstraint") then
            v1[j] = j.Enabled
            j.Enabled = false
        end
    end
    return v1
end

local function unparkWelds(a1) -- Line: 58 -- types: a1: table
    for i, j in a1 do
        i.Enabled = j
    end
end

local function assertStill(a1, a2, a3) -- Line: 64 -- types: a1: userdata, a2: userdata, a3: string
    local v1 = a1.XVector:Dot(a2.XVector)
    local v2 = a1.YVector:Dot(a2.YVector)
    local v3 = a1.ZVector:Dot(a2.ZVector)
    local v4 = true
    if not (1e-05 < (a1.Position - a2.Position).Magnitude) then
        v4 = true
        if not (v1 < 0.99999) then
            v4 = true
            if not (v2 < 0.99999) then
                v4 = v3 < 0.99999
            end
        end
    end
    assert(not v4, (("%* shifted during the flip"):format(a3)))
end

local function standInFor(a1, a2) -- Line: 77 -- upvalues: u20 (val), u26 (val) -- types: a1: userdata, a2: userdata
    local Part = Instance.new("Part")
    Part.Name = "HumanoidRootPart"
    for i, j in u20 do
        Part[j] = a1[j]
    end
    for k, n in u26 do
        Part[k] = n
    end
    Part.Parent = a2
    return Part
end

function v1.Invert(a1) -- Line: 92
    -- upvalues: t (val), childOfClass (val), ModelBounds (val), parkWelds (val), u19 (val), u20 (val), u26 (val)
    -- upvalues: assertStill (val)
    t.strict(t.instanceIsA("Model"))(a1)
    local v1 = childOfClass(a1, "HumanoidRootPart", "BasePart")
    local v2 = childOfClass(a1, "CENTER", "BasePart")
    local v3 = childOfClass(a1, "Model", "Model")
    local v4 = childOfClass(v1, "AssetWeld", "WeldConstraint")
    local v5 = childOfClass(v2, "CenterWeld", "WeldConstraint")
    local CFrame = v1.CFrame
    local CFrame_2 = v2.CFrame
    local v6 = ModelBounds(a1)
    local v7 = v6:ToObjectSpace((v3:GetPivot()))
    local v8 = parkWelds(a1)
    assert(v8[v4] ~= nil, "AssetWeld escaped the parking sweep")
    assert(v8[v5] ~= nil, "CenterWeld escaped the parking sweep")
    v3:PivotTo(v6 * u19 * v7)
    v1.Name = "InvertedModelOriginalRoot"
    v7 = Instance.new("Part")
    v7.Name = "HumanoidRootPart"
    for i, j in u20 do
        v7[j] = v1[j]
    end
    for k, n in u26 do
        v7[k] = n
    end
    v7.Parent = a1
    v1.Anchored = false
    v6 = Instance.new("WeldConstraint")
    v6.Name = "InvertedModelRootWeld"
    v6.Part0 = v7
    v6.Part1 = v1
    v6.Parent = v7
    a1.PrimaryPart = v7
    for m, i5 in v8 do
        m.Enabled = i5
    end
    assertStill(v7.CFrame, CFrame, "the stand-in HumanoidRootPart")
    assertStill(v2.CFrame, CFrame_2, "CENTER")
end

return v1