-- Script path: ReplicatedStorage.Shared.Eggs.EggRenderer
-- Decompile time: 6.26 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Assets = require(ReplicatedStorage.Data.Assets)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local EggRarityVFX = ReplicatedStorage.Assets.Particles.EggRarityVFX
local u56 = {}

local function exceedsPlacedCollisionBounds(a1) -- Line: 36 -- types: a1: vector
    local v1 = true
    if not (20 < a1.X) then
        v1 = true
        if not (20 < a1.Y) then
            v1 = 20 < a1.Z
        end
    end
    return v1
end

local function rarityVfxSource(a1) -- Line: 44 -- upvalues: EggRarityVFX (val) -- types: a1: number
    local v1, v2, v3, v4, v5
    local v6 = nil
    local v7 = -1
    for i, j in EggRarityVFX:GetChildren() do
        v4, v5 = string.match(j.Name, "^RarityNumber(%d+)(%+?)$")
        v3 = ("EggRarityVFX child \"%*\" is not named RarityNumber<n>[+]"):format(j.Name)
        assert(v4 ~= nil, v3)
        v2 = tonumber(v4)
        if (if v5 ~= "+" then v1 == v2 else v2 <= v1) and v7 < v2 then
            v6 = j
        end
    end
    return v6
end

local function attachRarityVfx(a1, a2) -- Line: 63 -- upvalues: rarityVfxSource (val) -- types: a1: userdata, a2: number
    local v1 = rarityVfxSource(a2)
    if v1 == nil then
        return
    end
    local Hitbox = a1:FindFirstChild("Hitbox")
    local v2 = ("Egg model %* is missing its Hitbox"):format(a1.Name)
    assert(Hitbox ~= nil, v2)
    assert(Hitbox:IsA("BasePart"), (("Egg model %* Hitbox must be a BasePart"):format(a1.Name)))
    local v3 = math.max(v1:GetAttribute("HitboxSizeY") or 5, 1)
    local Model = Instance.new("Model")
    for i, j in v1:GetChildren() do
        j:Clone().Parent = Model
    end
    Model:ScaleTo(Hitbox.Size.Y / v3)
    for k, n in Model:GetChildren() do
        n.Parent = Hitbox
    end
    Model:Destroy()
end

function u56.GetTemplate(a1) -- Line: 94 -- upvalues: Eggs (val), EggRecords (val)
    assert(Eggs.SchemaValidation.SavedEgg(a1), "Invalid saved egg record")
    return EggRecords.EggModelTemplate(a1.AssetCategory, a1.Mutations, a1.BaseMutation, a1.EggSkin)
end

function u56.DisableCollisions(a1) -- Line: 105 -- upvalues: t (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Model"))(a1)
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
        end
    end
end

function u56.ApplyPlacedCollisionPolicy(a1) -- Line: 115 -- upvalues: t (val), ModelBounds (val) -- types: a1: userdata
    local v1, v2
    t.strict(t.instanceIsA("Model"))(a1)
    _, v1 = ModelBounds(a1)
    local Size = a1.PrimaryPart and a1.PrimaryPart.Size or v1
    local v3 = true
    if not (20 < Size.X) then
        v3 = true
        if not (20 < Size.Y) then
            v3 = 20 < Size.Z
        end
    end
    v1 = not v3
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            v2 = v1 and j.Transparency < 1
            j.CanCollide = v2
        end
    end
end

function u56.RenderVisual(a1, a2, a3) -- Line: 128
    -- upvalues: t (val), Eggs (val), Assets (val), u56 (val), attachRarityVfx (val), EggScaling (val), Mutations (val)
    -- upvalues: AssetPalette (val), ModelBounds (val), ParasiteVisual (val)
    local v1
    t.strict(t.Instance)(a2)
    t.strict(t.number)(a1.OwnerUserId)
    t.strict(t.string)(a1.UID)
    t.strict(t.string)(a1.ModelName)
    assert(Eggs.SchemaValidation.SavedEgg(a1.Record), "Invalid saved egg record")
    local v2 = Assets.Directory[a1.Record.AssetCategory]
    local v3 = ("Missing asset config for category %*"):format(a1.Record.AssetCategory)
    assert(v2 ~= nil, v3)
    local Egg = v2.Egg
    v3 = u56.GetTemplate(a1.Record):Clone()
    v3.Name = a1.ModelName
    attachRarityVfx(v3, v2.Rarity.Rank)
    local v4 = v3:GetScale()
    local AssetCategory_2 = a1.Record.AssetCategory
    v3:ScaleTo((EggScaling.LiftToFloor(
        v4,
        (if not a1.ScaleMultiplier then EggScaling.PreGrowthVisual(v4, a1.Record.AssetScale, AssetCategory_2) else EggScaling.LiftToFloor(v4, a1.ScaleMultiplier, AssetCategory_2)) * (math.clamp(a1.ScaleAlpha or 1, 0.5, 1)),
        AssetCategory_2
    )))
    if Mutations.EggModelName(a1.Record.Mutations, a1.Record.BaseMutation) == nil then
        AssetPalette.PaintModel(v3, a1.Record.AssetCategory, a1.Record.AssetEyeColor, a1.Record.AssetColorSeed, a1.Record.AssetColorIndex)
    end
    local PrimaryPart = v3.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local v5, v6 = ModelBounds(v3)
    PrimaryPart.PivotOffset = CFrame.new(0, v5.Position.Y - v6.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)
    local v7, v8, v9 = a3, a2, a1
    for i, j in v3:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            v1 = j.Transparency ~= 1
            j.CanQuery = v1
            j.CanTouch = false
            j.Massless = true
            v1 = not v8:IsA("Tool") and j == PrimaryPart
            j.Anchored = v1
        end
    end
    if v7 then
        u56.ApplyPlacedCollisionPolicy(v3)
    end
    v3.Parent = v8
    ParasiteVisual.Attach(v3, v9.Record.HasParasite)
    return {Model = v3, VisibleParts = {PrimaryPart}, Config = Egg}
end

function u56.GetAuthoredScale(a1) -- Line: 201 -- upvalues: Eggs (val), u56 (val)
    assert(Eggs.SchemaValidation.SavedEgg(a1), "Invalid saved egg record")
    local Scale = u56.GetTemplate(a1):GetScale()
    local v1 = ("Egg model %* scale must be greater than 0"):format(a1.AssetCategory)
    assert(Scale > 0, v1)
    return Scale
end

function u56.GetVisibleBounds(a1) -- Line: 211 -- upvalues: Eggs (val), Assets (val), u56 (val), ModelBounds (val)
    local v1
    assert(Eggs.SchemaValidation.SavedEgg(a1), "Invalid saved egg record")
    assert(Assets.Directory[a1.AssetCategory] ~= nil, (("Missing asset config for category %*"):format(a1.AssetCategory)))
    local v2 = u56.GetTemplate(a1)
    local v3 = u56.GetAuthoredScale(a1)
    _, v1 = ModelBounds(v2)
    return v1 / v3
end

return u56