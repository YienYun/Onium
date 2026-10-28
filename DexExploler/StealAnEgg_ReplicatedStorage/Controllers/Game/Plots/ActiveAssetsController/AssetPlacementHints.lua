-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetPlacementHints
-- Decompile time: 1.95 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {}
local v1 = {}

local function cframeInFrontOfRootClampedToArea(a1, a2) -- Line: 31 -- types: a1: userdata, a2: userdata
    local LookVector = a1.LookVector
    local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)
    assert(0 < v1.Magnitude, "Asset front placement requires a horizontal root facing direction")
    local Unit = v1.Unit
    local Size = a2.Size
    local v2 = math.max(Size.X * 0.5 - 1.75, 0)
    local v3 = math.max(Size.Z * 0.5 - 1.75, 0)
    local v4 = a2.CFrame:PointToObjectSpace(a1.Position + Unit * 6)
    local Position = (a2.CFrame * CFrame.new((Vector3.new(math.clamp(v4.X, -v2, v2), 0, (math.clamp(v4.Z, -v3, v3)))))).Position
    return CFrame.lookAt(Position, Position + Unit)
end

function v1.SetFrontPlacement(a1, a2) -- Line: 59 -- upvalues: t (val), u9 (val) -- types: a1: string, a2: userdata
    t.strict(t.string)(a1)
    t.strict(t.CFrame)(a2)
    u9[a1] = {RootCFrame = a2, ExpiresAt = os.clock() + 10}
end

function v1.ConsumeFrontPlacement(a1, a2) -- Line: 69
    -- upvalues: t (val), u9 (val), cframeInFrontOfRootClampedToArea (val)
    t.strict(t.string)(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    local v1 = u9[a1]
    u9[a1] = nil
    if v1 ~= nil and not (v1.ExpiresAt < os.clock()) then
        return cframeInFrontOfRootClampedToArea(v1.RootCFrame, a2)
    end
    return nil
end

function v1.ClearFrontPlacement(a1) -- Line: 82 -- upvalues: t (val), u9 (val) -- types: a1: string
    t.strict(t.string)(a1)
    u9[a1] = nil
end

return v1