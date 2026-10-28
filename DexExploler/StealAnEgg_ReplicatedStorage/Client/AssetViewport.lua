-- Script path: ReplicatedStorage.Client.AssetViewport
-- Decompile time: 7.23 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Trove = require(ReplicatedStorage.Packages.Trove)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u43 = (require(ReplicatedStorage.Packages.Log)).new()
local Unit = Vector3.new(-1, 0, -1).Unit
local u50 = Color3.fromRGB(300, 300, 300)
local u55 = t.strict(t.instanceIsA("GuiObject"))
local u60 = t.strict(t.instanceIsA("Model"))
local u63 = t.strict(t.Instance)
local u66 = t.strict(t.CFrame)
local u69 = t.strict(t.Vector3)
local u72 = t.strict(t.number)
local u75 = t.strict(t.string)
local u76 = {}

local function raise(a1, a2, a3, a4) -- Line: 40
    -- upvalues: Trove (val), u76 (val), ModelBounds (val), Unit (val)
    local v1 = Trove.new()
    v1:Add(a2)
    if not a4 then
        a2.Parent = a3
    else
        local WorldModel = Instance.new("WorldModel")
        WorldModel.Parent = a3
        v1:Add(WorldModel)
        a2.Parent = WorldModel
        local v2 = u76.LoopIdle(a1, a2)
        if v2 ~= nil then
            v1:Add(v2)
        end
    end
    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 50
    Camera.Parent = a3
    a3.CurrentCamera = Camera
    v1:Add(Camera)
    local v3, v4 = ModelBounds(a2)
    local v5 = math.max(v4.X, v4.Y, v4.Z)
    local v6 = v5 * 0.5 / 0.5773502691896257 * 0.75
    local v7 = v3.Position + Vector3.new(0, -0.15000000000000002 * v4.Y, 0)
    Camera.CFrame = CFrame.new((v3 * (CFrame.new(Unit * (v6 + v5 * 0.7)))).Position, v7)
    v1:AttachToInstance(a3)
    return v1, Camera, a2
end

function u76.Mount(a1) -- Line: 79 -- upvalues: u55 (val), u50 (val) -- types: a1: userdata
    u55(a1)
    local ViewportFrame = Instance.new("ViewportFrame")
    local v1 = a1.ZIndex + 1
    ViewportFrame.Name = "AssetViewport"
    ViewportFrame.ZIndex = v1
    ViewportFrame.AnchorPoint = (Vector2.new(0.5, 0.5))
    ViewportFrame.BackgroundTransparency = 1
    local v2 = UDim2.fromScale(0.5, 0.5)
    v1 = UDim2.fromScale(1, 1)
    ViewportFrame.Position = v2
    ViewportFrame.Size = v1
    ViewportFrame.Parent = a1
    v1 = u50
    ViewportFrame.LightColor = u50
    ViewportFrame.Ambient = v1
    return ViewportFrame
end

function u76.LoopIdle(a1, a2) -- Line: 92
    -- upvalues: u75 (val), u60 (val), Directory (val)
    u75(a1)
    u60(a2)
    local Idle = Directory[a1].Animations.Idle
    local Animator = a2:FindFirstChildWhichIsA("Animator", true)
    if Idle ~= nil and Animator ~= nil and a2:GetAttribute("AnimationsDisabled") ~= true then
        local v1 = Animator:LoadAnimation(Idle)
        v1.Looped = true
        v1:Play(0)
        return v1
    end
    return nil
end

function u76.ShowModel(a1, a2) -- Line: 110
    -- upvalues: u60 (val), raise (val), ModelBounds (val)
    local v1, v2, v3, v4
    u60(a1)
    assert(a2:IsA("ViewportFrame"), "ShowModel requires a ViewportFrame")
    local v5, v6, v7 = raise("", a1:Clone(), a2, false)
    local v8, v9 = ModelBounds(v7)
    local v10 = v8:VectorToWorldSpace(Vector3.new(-1, 0.25, -1).Unit)
    local v11 = CFrame.lookAt(Vector3.new(0, 0, 0), -v10)
    local AbsoluteSize = a2.AbsoluteSize
    local v12 = if not (0 < AbsoluteSize.X) then 1 else if not (0 < AbsoluteSize.Y) then 1 else AbsoluteSize.X / AbsoluteSize.Y
    local v13 = math.tan((math.rad(v6.FieldOfView * 0.5)))
    local v14 = v13 * v12
    v12 = 0
    local v15 = {-1, 1}
    local v16 = nil
    local v17 = nil
    for i, j in v15, v16, v17 do
        v1 = {-1, 1}
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            for m, i5 in {-1, 1} do
                v4 = v11:VectorToObjectSpace((v8:VectorToWorldSpace((Vector3.new(v9.X * j, v9.Y * n, v9.Z * i5)) * 0.5)))
                v12 = math.max(v12, v4.Z + math.abs(v4.X) / v14, v4.Z + (math.abs(v4.Y)) / v13)
            end
        end
    end
    v6.CFrame = CFrame.lookAt(v8.Position + v10 * math.max(0.5, v12 * 1.1), v8.Position)
    return v5, v6, v7
end

function u76.ShowAsset(a1, a2, a3) -- Line: 141
    -- upvalues: AssetModels (val), u43 (val), Trove (val), raise (val)
    local v1 = AssetModels.GetAssetModelIfReplicated(a1)
    if v1 then
        return raise(a1, v1:Clone(), a2, a3)
    end
    ;(u43:AtWarning()):Log("No replicated model to put in a viewport", {AssetId = a1})
    return Trove.new(), nil, nil
end

function u76.ShowItem(a1, a2, a3, a4) -- Line: 157
    -- upvalues: AssetItem (val), u63 (val), u72 (val), raise (val), ItemDisplay (val)
    assert((AssetItem.AssetItemData(a1)))
    u63(a2)
    u72(a3)
    local v1 = table.clone(a1)
    v1.Scale = 1
    local v2, v3, v4 = raise(a1.Category, ItemDisplay.CreateActiveModel(nil, v1, true, true), a2, a4)
    ItemDisplay.ApplyModelScale(v4, a1.Category, a3)
    return v2, v3, v4
end

function u76.Orbit(a1, a2, a3, a4) -- Line: 175
    -- upvalues: u66 (val), u69 (val), u72 (val)
    u66(a1)
    u69(a2)
    u72(a3)
    u72(a4)
    local v1 = CFrame.new(a2)
    return CFrame.lookAt((v1 * CFrame.Angles(a4, a3, 0) * v1:ToObjectSpace(a1)).Position, a2)
end

function u76.AimOrbit(a1, a2, a3, a4, a5) -- Line: 186
    -- upvalues: u63 (val), u76 (val)
    u63(a1)
    a1.CFrame = u76.Orbit(a2, a3, a4, a5)
end

function u76.AimLocalOrbit(a1, a2, a3, a4, a5, a6, a7) -- Line: 194
    -- upvalues: u63 (val), u66 (val), u69 (val), u72 (val)
    u63(a1)
    u66(a2)
    u69(a3)
    u72(a4)
    u72(a5)
    u72(a6)
    u72(a7)
    a1.CFrame = CFrame.lookAt(
        a3 + a2:VectorToWorldSpace(((CFrame.Angles(0, a6, 0)):VectorToWorldSpace((Vector3.new(0, 0, -a4)))) + (Vector3.new(0, a5 + math.tan(a7) * a4, 0))),
        a3,
        a2.UpVector
    )
end

return u76