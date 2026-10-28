-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Hands
-- Decompile time: 7.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Kit = require(script.Parent.Kit)
require(ReplicatedStorage.Packages.Trove)
local u14 = {"Reach", "Grab", "Wave"}
local u23 = Color3.fromRGB(52, 191, 112)
local u28 = Color3.fromRGB(120, 235, 205)
local u34 = table.freeze({-0.55, 0, 0.55})
local u35 = {}

local function ellipsoid(a1, a2, a3) -- Line: 59 -- upvalues: Kit (val) -- types: a1: vector, a2: CFrame
    local v1 = Kit.Part({Size = a1, Color = a2, Material = a3})
    local SpecialMesh = Instance.new("SpecialMesh")
    SpecialMesh.MeshType = Enum.MeshType.Sphere
    SpecialMesh.Parent = v1
    return v1
end

local function fingerOffsets(a1) -- Line: 71 -- upvalues: u34 (val) -- types: a1: number
    local v1 = u34[a1]
    local v2 = CFrame.new(v1, 0.6509999799728393, 0)
    local v3 = math.rad(-v1 * 22)
    return {
        Reach = v2 * CFrame.Angles(0, 0, v3) * CFrame.new(0, 0.6075000107288361, 0),
        Grab = v2 * CFrame.Angles(-1.8325957145940461, 0, v3 * 0.3) * CFrame.new(0, 0.5670000100135802, 0),
        Wave = v2 * CFrame.Angles(0.24434609527920614, 0, v3 * 0.5) * CFrame.new(0, 0.6345000112056732, 0),
    }
end

local function thumbOffsets() -- Line: 85
    local v1 = CFrame.new(0.875, -0.05, -0.1)
    return {
        Reach = v1 * CFrame.Angles(0, 0, -0.9599310885968813) * CFrame.new(0, 0.4199999809265137, 0),
        Grab = v1 * CFrame.Angles(-1.2217304763960306, 0, -0.3490658503988659) * CFrame.new(0, 0.4199999809265137, 0),
        Wave = v1 * CFrame.Angles(0, 0, -0.6981317007977318) * CFrame.new(0, 0.44099997997283935, 0),
    }
end

local function buildDrawn(a1) -- Line: 96
    -- upvalues: ellipsoid (val), u23 (val), u28 (val), u34 (val), fingerOffsets (val), thumbOffsets (val)
    local v1 = {}
    local v2 = ellipsoid(Vector3.new(1.75, 1.5499999523162842, 0.800000011920929), u23, Enum.Material.Neon)
    v2.Name = "Palm"
    v2.Parent = a1
    table.insert(v1, {Part = v2, Offsets = {}, Shared = CFrame.identity})
    v2 = ellipsoid(Vector3.new(1.0499999523162842, 3.799999952316284, 1.0499999523162842), u23, Enum.Material.Neon)
    v2.Name = "Arm"
    v2.Parent = a1
    table.insert(v1, {Part = v2, Offsets = {}, Shared = CFrame.new(0, -2.1384999632835386, 0)})
    v2 = ellipsoid(Vector3.new(0.6000000238418579, 2.4000000953674316, 0.6000000238418579), u28, Enum.Material.Neon)
    v2.Name = "Tail"
    v2.Transparency = 0.25
    v2.Parent = a1
    table.insert(v1, {
        Part = v2,
        Offsets = {},
        Shared = (CFrame.new(0.25, -4.15249993801117, 0)) * CFrame.Angles(0, 0, -0.4886921905584123) * CFrame.new(0, -0.9600000381469727, 0),
    })
    local v3 = #u34
    for i = 1, v3 do
        v2 = ellipsoid(Vector3.new(0.5, 1.350000023841858, 0.5), u23, Enum.Material.Neon)
        v2.Name = ("Finger%*"):format(i)
        v2.Parent = a1
        table.insert(v1, {Part = v2, Offsets = fingerOffsets(i)})
    end
    v3 = ellipsoid(Vector3.new(0.550000011920929, 1.0499999523162842, 0.550000011920929), u23, Enum.Material.Neon)
    v3.Name = "Thumb"
    v3.Parent = a1
    table.insert(v1, {Part = v3, Offsets = thumbOffsets()})
    v3 = ellipsoid(Vector3.new(2.06499981880188, 1.8289998769760132, 0.9439999461174011), u28, Enum.Material.ForceField)
    v3.Name = "Shimmer"
    v3.Parent = a1
    table.insert(v1, {Part = v3, Offsets = {}, Shared = CFrame.identity})
    return v1
end

local function buildMeshed(a1, a2) -- Line: 138
    -- upvalues: u14 (val), u23 (val), Kit (val), u28 (val)
    local Attribute, Attribute_2, v1, v2, v3
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in u14, v5, v6 do
        v3 = a2:FindFirstChild(j)
        if v3 ~= nil and v3:IsA("BasePart") then
            Attribute = v3:GetAttribute("Palm")
            Attribute_2 = v3:GetAttribute("Turn")
            v2 = (if typeof(Attribute) ~= "Vector3" then CFrame.identity else CFrame.new(-Attribute)) * (if typeof(Attribute_2) ~= "CFrame" then CFrame.identity else Attribute_2)
            v1 = v3:Clone()
            v1.Name = j
            v1.Material = Enum.Material.Neon
            v1.Color = u23
            Kit.Quiet(v1)
            v1.Anchored = true
            v1.Parent = v7
            table.insert(v4, {Part = v1, Offsets = {[j] = v2}})
            v1 = v3:Clone()
            v1.Name = j .. "Shimmer"
            v1.Material = Enum.Material.ForceField
            v1.Color = u28
            v1.Size = v3.Size * 1.06
            v1.Anchored = true
            v1.Parent = v7
            table.insert(v4, {Part = v1, Offsets = {[j] = v2}})
            continue
        end
        return nil
    end
    return v4
end

local function scaleOf(a1, a2) -- Line: 173 -- types: a1: table, a2: userdata
    if a1.Scale == 1 then
        return a2
    end
    return a2.Rotation + a2.Position * a1.Scale
end

function u35.Build(a1, a2, a3, a4) -- Line: 184
    -- upvalues: buildMeshed (val), buildDrawn (val), Kit (val), u28 (val), u23 (val), u35 (val)
    local Attachment, Model_2, Part, Part_2, v1, v2, v3, v4, v5
    local v6 = a1:Add((Instance.new("Model")))
    v6.Name = "SewerDrainHands"
    local Assets = script.Parent:FindFirstChild("Assets")
    local Hands = Assets and Assets:FindFirstChild("Hands")
    local v7 = {}
    for i = 1, a3 do
        Model_2 = Instance.new("Model")
        Model_2.Name = ("Hand%*"):format(i)
        v3 = (if Hands == nil then nil else buildMeshed(Model_2, Hands)) ~= nil
        if v2 == nil then
            v2 = buildDrawn(Model_2)
        end
        v4 = v2
        v3 = v8 / (if not v3 then 5.349999904632568 else 5.4)
        for j, k in v4 do
            Part_2 = k.Part
            Part_2.Size = Part_2.Size * v3
        end
        Part = v4[1].Part
        Attachment = Instance.new("Attachment")
        Attachment.Name = "Wrist"
        Attachment.Parent = Part
        v2 = Kit.Emitter({
            Name = "Wisps",
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            LightEmission = 0.8,
            LightInfluence = 0,
            Drag = 3,
            Color = ColorSequence.new(u28, u23),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.55),
                NumberSequenceKeypoint.new(0.6, 0.75),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, v3 * 0.6),
                (NumberSequenceKeypoint.new(1, v3 * 2.2)),
            }),
            Lifetime = NumberRange.new(0.5, 0.9),
            Speed = NumberRange.new(2, 5),
            SpreadAngle = Vector2.new(60, 60),
            RotSpeed = NumberRange.new(-60, 60),
            Rotation = NumberRange.new(0, 360),
        })
        v2.Parent = Attachment
        Model_2.Parent = v6
        v5 = {
            Shown = "Reach",
            Visible = true,
            Model = Model_2,
            Pieces = v4,
            Scale = v3,
            Frame = CFrame.identity,
            Anchor = Attachment,
            Wisps = v2,
        }
        table.insert(v7, v5)
        u35.Visible(v5, false)
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "Outline"
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = Color3.fromRGB(205, 255, 240)
    Highlight.OutlineTransparency = 0.15
    Highlight.Adornee = v6
    Highlight.Parent = v6
    local v9 = Kit.Part({
        Name = "Glow",
        Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
        Transparency = 1,
    })
    v9.Parent = v6
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u28
    PointLight.Range = 14
    PointLight.Brightness = 0
    PointLight.Shadows = false
    PointLight.Parent = v9
    v6.Parent = v1
    return {
        Model = v6,
        Hands = v7,
        Outline = Highlight,
        Light = PointLight,
        LightPart = v9,
    }
end

function u35.Show(a1, a2) -- Line: 271 -- upvalues: u35 (val) -- types: a1: table, a2: string
    a1.Shown = a2
    u35.Place(a1, a1.Frame)
end

function u35.Visible(a1, a2) -- Line: 276 -- upvalues: u35 (val) -- types: a1: table, a2: boolean
    a1.Visible = a2
    u35.Place(a1, a1.Frame)
end

function u35.Place(a1, a2, a3) -- Line: 281 -- types: a1: table, a2: userdata, a3: number?
    local Part, Shared, v1
    a1.Frame = a2
    local v2 = a3 or 1
    local v3 = nil
    local v4 = nil
    local v5 = a1
    for i, j in a1.Pieces, v3, v4 do
        Shared = j.Shared or j.Offsets[v5.Shown]
        Part = j.Part
        if Shared == nil or not v5.Visible then
            Part.Transparency = 1
            Part.CFrame = v6
        elseif not (v2 <= 0.01) then
            Part.Transparency = if Part.Name ~= "Tail" then 0 else 0.25
            v1 = if v5.Scale ~= 1 then Shared.Rotation + Shared.Position * v5.Scale else Shared
            Part.CFrame = v6 * (v1.Rotation + v1.Position * v2)
        else
            Part.Transparency = 1
            Part.CFrame = v6
        end
    end
end

function u35.Puff(a1, a2) -- Line: 298 -- types: a1: table, a2: number
    a1.Wisps:Emit(a2)
end

return table.freeze(u35)