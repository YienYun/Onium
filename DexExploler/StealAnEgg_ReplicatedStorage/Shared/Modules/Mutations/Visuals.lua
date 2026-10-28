-- Script path: ReplicatedStorage.Shared.Modules.Mutations.Visuals
-- Decompile time: 33.57 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartBounds = require(ReplicatedStorage.Shared.Utils.PartBounds)
local Checksum = require(ReplicatedStorage.Shared.Utils.Checksum)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local u25 = (require(ReplicatedStorage.Packages.Log)).new()
local t = require(ReplicatedStorage.Packages.t)
local u30 = {}
u30.Darker = Color3.fromRGB(216, 158, 0)
u30.Lighter = Color3.fromRGB(251, 255, 0)
local u41 = {}
u41.Darker = Color3.fromRGB(134, 134, 134)
u41.Lighter = Color3.fromRGB(192, 192, 192)
local v1 = {Darker = Color3.fromRGB(25, 0, 38), Lighter = Color3.fromRGB(47, 0, 70)}
local u64 = Random.new()
local u65 = nil
local u66 = {}

local function getFxContainer(a1) -- Line: 105 -- upvalues: ReplicatedStorage (val) -- types: a1: string
    local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
    assert(Mutations, "Mutations folder is missing from ReplicatedStorage")
    local v1 = Mutations:FindFirstChild(a1)
    assert(v1, (("Mutation FX container \"%*\" not found in Mutations"):format(a1)))
    return v1
end

local function shouldSkipColoring(a1) -- Line: 113 -- types: a1: userdata
    local v1 = true
    if a1:GetAttribute("MutationsDontModify") ~= true then
        v1 = true
        if a1:GetAttribute("DontAddTexture") ~= true then
            v1 = true
            if a1:GetAttribute("IsEye") ~= true then
                v1 = a1:GetAttribute("MutationFXDontRender") == true
            end
        end
    end
    return v1
end

local function ensureUnionUsePartColor(a1) -- Line: 120 -- types: a1: userdata
    if not a1:IsA("UnionOperation") then
        return
    end
    if a1:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
        a1:SetAttribute("Cleanup_OriginalUserPartColor", a1.UsePartColor)
    end
    a1.UsePartColor = true
end

local function restoreUnionUsePartColor(a1) -- Line: 132 -- types: a1: userdata
    if not a1:IsA("UnionOperation") then
        return
    end
    local Attribute = a1:GetAttribute("Cleanup_OriginalUserPartColor")
    if typeof(Attribute) ~= "boolean" then
        return
    end
    a1.UsePartColor = Attribute
    a1:SetAttribute("Cleanup_OriginalUserPartColor", nil)
end

local function rollColor(a1, a2) -- Line: 146 -- types: a1: userdata, a2: table
    return a2.Darker:Lerp(a2.Lighter, (a1:NextNumber()))
end

local function applyPaletteColor(a1, a2) -- Line: 150
    -- upvalues: u65 (ref), u64 (val)
    if a1:IsA("UnionOperation") then
        if a1:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
            a1:SetAttribute("Cleanup_OriginalUserPartColor", a1.UsePartColor)
        end
        a1.UsePartColor = true
    end
    a1.Color = a2.Darker:Lerp(a2.Lighter, ((u65 or u64):NextNumber()))
end

local function getMaterialByName(a1) -- Line: 155 -- types: a1: string
    for i, j in Enum.Material:GetEnumItems() do
        if j.Name == a1 then
            return j
        end
    end
    return nil
end

local function getStoredOriginalMaterial(a1) -- Line: 166 -- types: a1: userdata
    local Attribute, v1
    local v2 = {"Mutation_OriginalMaterial", "OriginalMaterial", "Original_Material"}
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        Attribute = a1:GetAttribute(j)
        if typeof(Attribute) == "string" then
            for k, n in Enum.Material:GetEnumItems() do
                if n.Name == Attribute then
                    v1 = n
                    if v1 then
                        return v1
                    end
                    break
                end
            end
            v1 = nil
            if v1 then
                return v1
            end
        elseif typeof(Attribute) == "EnumItem" and Attribute.EnumType == Enum.Material then
            return Attribute
        end
    end
    return nil
end

local function getStoredOriginalMaterialVariant(a1) -- Line: 182 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Mutation_OriginalMaterialVariant")
    if typeof(Attribute) == "string" then
        return Attribute
    end
    return nil
end

local function setAndSaveMaterial(a1, a2) -- Line: 191 -- types: a1: userdata
    if not a1:GetAttribute("Mutation_OriginalMaterial") then
        a1:SetAttribute("Mutation_OriginalMaterial", a1.Material.Name)
    end
    a1.Material = a2
end

local function setAndSaveMaterialVariant(a1, a2) -- Line: 199 -- types: a1: userdata, a2: string
    if not a1:GetAttribute("Mutation_OriginalMaterialVariant") then
        a1:SetAttribute("Mutation_OriginalMaterialVariant", a1.MaterialVariant)
    end
    a1.MaterialVariant = a2
end

local function hasMetalVisual(a1) -- Line: 207 -- types: a1: userdata
    return a1:HasTag("GoldenVisual") or a1:HasTag("SilverVisual")
end

local function setMetalMaterialVariant(a1) -- Line: 211 -- types: a1: userdata
    if not a1:GetAttribute("Mutation_OriginalMaterialVariant") then
        a1:SetAttribute("Mutation_OriginalMaterialVariant", a1.MaterialVariant)
    end
    a1.MaterialVariant = "StudsMetallic"
end

local function getPartVolume(a1) -- Line: 215 -- types: a1: userdata
    local Size = a1.Size
    return Size.X * Size.Y * Size.Z
end

local function collectMetalSizeGroups(a1) -- Line: 220 -- types: a1: userdata
    local Size, v1, v2, v3
    local v4 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 and not j:HasTag("Effect") then
            v2 = true
            if j:GetAttribute("MutationsDontModify") ~= true then
                v2 = true
                if j:GetAttribute("DontAddTexture") ~= true then
                    v2 = true
                    if j:GetAttribute("IsEye") ~= true then
                        v2 = j:GetAttribute("MutationFXDontRender") == true
                    end
                end
            end
            if not v2 then
                table.insert(v4, j)
            end
        end
    end
    table.sort(v4, function(a1, a2) -- Line: 235 -- types: a1: userdata, a2: userdata
        local Size = a1.Size
        local v1 = Size.X * Size.Y * Size.Z
        local Size_2 = a2.Size
        return Size_2.X * Size_2.Y * Size_2.Z < v1
    end)
    local v5 = {}
    local v6 = 0
    local v7 = nil
    local v8 = nil
    for k, n in v4, v7, v8 do
        Size = n.Size
        v3 = Size.X * Size.Y * Size.Z
        v1 = v5[#v5]
        if not v1 or not ((math.abs(v1.PartVolume - v3)) <= 0.001) then
            table.insert(v5, {Parts = {n}, PartVolume = v3, Weight = v3})
        else
            table.insert(v1.Parts, n)
            v1.Weight = v1.Weight + v3
        end
        v6 = v6 + v3
    end
    table.sort(v5, function(a1, a2) -- Line: 260 -- types: a1: table, a2: table
        return a2.Weight < a1.Weight
    end)
    return v5, v6
end

local function getSilverComboParts(a1, a2) -- Line: 267
    -- upvalues: collectMetalSizeGroups (val), u66 (val)
    local v1, v2 = collectMetalSizeGroups(a1)
    local v3 = Random.new(u66.SeedFor(a2, "GoldenSilverPartition"))
    local v4 = v2 / 2
    local v5 = v2 / 2
    v2 = {}
    local v6 = nil
    local v7 = nil
    for i, j in v1, v6, v7 do
        if not (if not ((math.abs(v4 - v5)) <= 0.001) then v5 < v4 else (v3:NextNumber()) < 0.5) then
            v5 = v5 - j.Weight
        else
            for k, n in j.Parts do
                v2[n] = true
            end
            v4 = v4 - j.Weight
        end
    end
    return v2
end

local function getNamedSurfaceAppearance(a1, a2) -- Line: 295 -- types: a1: userdata, a2: string
    local v1
    local v2 = nil
    local v3, v4 = a1, a2
    for i, j in a1:GetDescendants() do
        if j:IsA("SurfaceAppearance") and j.Name == v4 then
            v1 = ("%* contains multiple %* SurfaceAppearances"):format(v3:GetFullName(), v4)
            assert(v2 == nil, v1)
            v2 = j
        end
    end
    local v5 = ("%* must contain a %* SurfaceAppearance"):format(v3:GetFullName(), v4)
    assert(v2 ~= nil, v5)
    return v2
end

local function getTextureOverrideVisualModel(a1) -- Line: 307 -- types: a1: userdata
    if a1.Name == "Model" then
        return a1
    end
    local Model = a1:FindFirstChild("Model")
    local v1 = false
    if Model ~= nil then
        v1 = Model:IsA("Model")
    end
    assert(v1, (("%* enables TexturesOverride but has no direct Model child"):format((a1:GetFullName()))))
    return Model
end

local function getOriginalSurfaceAppearance(a1, a2, a3, a4, a5) -- Line: 320
    -- upvalues: 
    local v1
    local v2 = nil
    local v3, v4, v5, v6, v7 = a2, a3, a4, a5, a1
    for i, j in a1:GetDescendants() do
        if j:IsA("SurfaceAppearance") and j:GetAttribute("Mutation_OriginalSurfaceAppearance") == true then
            v1 = ("%* contains multiple original SurfaceAppearances"):format((v7:GetFullName()))
            assert(v2 == nil, v1)
            v2 = j
        end
    end
    if v2 == nil then
        for k, n in v3:GetChildren() do
            if n:IsA("SurfaceAppearance") and n ~= v4 and n ~= v5 and n ~= v6 then
                v1 = ("%* contains multiple original SurfaceAppearances"):format((v3:GetFullName()))
                assert(v2 == nil, v1)
                v2 = n
            end
        end
    end
    local v8 = ("%* must contain its original SurfaceAppearance"):format((v3:GetFullName()))
    assert(v2 ~= nil, v8)
    v2:SetAttribute("Mutation_OriginalSurfaceAppearance", true)
    return v2
end

local function getTextureOverrideBindings(a1) -- Line: 364
    -- upvalues: getNamedSurfaceAppearance (val), getOriginalSurfaceAppearance (val)
    local MeshPart, Model, v1, v2, v3, v4
    local v5 = {}
    if a1:IsA("Model") and a1:GetAttribute("TexturesOverride") == true then
        table.insert(v5, a1)
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("Model") and j:GetAttribute("TexturesOverride") == true then
            table.insert(v5, j)
        end
    end
    if #v5 == 0 then
        return nil
    end
    local v6 = {}
    local v7 = {}
    local v8 = nil
    local v9 = nil
    for k, n in v5, v8, v9 do
        if n.Name ~= "Model" then
            Model = n:FindFirstChild("Model")
            v2 = false
            if Model ~= nil then
                v2 = Model:IsA("Model")
            end
            assert(v2, (("%* enables TexturesOverride but has no direct Model child"):format((n:GetFullName()))))
            v4 = Model
        else
            v4 = n
        end
        if not v7[v4] then
            v7[v4] = true
            MeshPart = v4:FindFirstChildWhichIsA("MeshPart", true)
            v3 = ("%* must contain a MeshPart for texture overrides"):format((v4:GetFullName()))
            assert(MeshPart ~= nil, v3)
            v1 = getNamedSurfaceAppearance(v4, "GoldTextureOverride")
            v2 = getNamedSurfaceAppearance(v4, "SilverTextureOverride")
            v3 = getNamedSurfaceAppearance(v4, "GoldSilverTextureOverride")
            table.insert(v6, {
                VisualModel = v4,
                TargetMesh = MeshPart,
                Original = getOriginalSurfaceAppearance(v4, MeshPart, v1, v2, v3),
                Golden = v1,
                Silver = v2,
                GoldenSilver = v3,
            })
        end
    end
    assert(#v6 > 0, (("%* enables TexturesOverride but has no texture override bindings"):format((a1:GetFullName()))))
    return v6
end

local function getActiveSurfaceAppearance(a1) -- Line: 414 -- types: a1: table
    local v1
    local v2 = nil
    local v3 = a1
    for i, j in a1.TargetMesh:GetChildren() do
        if j:IsA("SurfaceAppearance") then
            v1 = ("%* contains multiple active SurfaceAppearances"):format((v3.TargetMesh:GetFullName()))
            assert(v2 == nil, v1)
            v2 = j
        end
    end
    local v4 = ("%* must contain one active SurfaceAppearance"):format((v3.TargetMesh:GetFullName()))
    assert(v2 ~= nil, v4)
    return v2
end

local function setActiveSurfaceAppearance(a1, a2) -- Line: 432
    -- upvalues: getActiveSurfaceAppearance (val)
    local v1 = getActiveSurfaceAppearance(a1)
    if v1 == a2 then
        return
    end
    local v2 = v1:HasTag("Cleanup_Rainbow")
    if v2 then
        v1:RemoveTag("RainbowPart")
        v1:RemoveTag("Cleanup_Rainbow")
    end
    v1.Parent = a1.VisualModel
    a2.Parent = a1.TargetMesh
    if v2 then
        a2:AddTag("RainbowPart")
        a2:AddTag("Cleanup_Rainbow")
    end
end

local function applyMetalTextureOverride(a1, a2, a3, a4) -- Line: 456
    -- upvalues: setActiveSurfaceAppearance (val)
    local v1, v2
    local v3 = nil
    local v4 = nil
    local v5, v6 = a2, a3
    for i, j in a1, v3, v4 do
        v2 = v5(j)
        if v6 ~= nil then
            v2:AddTag(v6)
        end
        if v1 ~= nil then
            if v2:GetAttribute("Metal_OriginalSurfaceColor") == nil then
                v2:SetAttribute("Metal_OriginalSurfaceColor", v2.Color)
            end
            v2.Color = v1
        end
        setActiveSurfaceAppearance(j, v2)
    end
end

local function removeMetalTextureOverride(a1, a2, a3, a4, a5) -- Line: 477
    -- upvalues: setActiveSurfaceAppearance (val)
    local Attribute, v1, v2
    local v3 = nil
    local v4 = nil
    local v5, v6, v7, v8 = a2, a4, a3, a5
    for i, j in a1, v3, v4 do
        v1 = v5(j)
        if v1:HasTag(v6) then
            v1:RemoveTag(v6)
            Attribute = v1:GetAttribute("Metal_OriginalSurfaceColor")
            if typeof(Attribute) == "Color3" then
                v1.Color = Attribute
                v1:SetAttribute("Metal_OriginalSurfaceColor", nil)
            end
            v2 = v7(j)
            if not v2:HasTag(v8) then
                setActiveSurfaceAppearance(j, j.Original)
            else
                setActiveSurfaceAppearance(j, v2)
            end
        end
    end
end

local function hasVisualTag(a1, a2) -- Line: 505 -- types: a1: userdata, a2: string
    for i, j in a1:GetDescendants() do
        if j:HasTag(a2) then
            return true
        end
    end
    return false
end

local function getStoredOriginalColor(a1) -- Line: 514 -- types: a1: userdata
    local Attribute = a1:GetAttribute("OriginalColor")
    if typeof(Attribute) == "Color3" then
        return Attribute
    end
    return nil
end

local function cloneFxInto(a1, a2, a3, a4, a5) -- Line: 523
    -- upvalues: t (val), ReplicatedStorage (val)
    local v1, v2
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.string)(a2)
    t.strict(t.string)(a3)
    local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
    assert(Mutations, "Mutations folder is missing from ReplicatedStorage")
    local v3 = Mutations:FindFirstChild(a2)
    assert(v3, (("Mutation FX container \"%*\" not found in Mutations"):format(a2)))
    local v4, v5, v6, v7 = a5, a1, a4, a3
    for i, j in v3:GetChildren() do
        v1 = j:Clone()
        if v4 ~= nil and v1:IsA("ParticleEmitter") then
            v2 = {}
            for k, n in v1.Size.Keypoints do
                table.insert(v2, (NumberSequenceKeypoint.new(n.Time, n.Value * v4, n.Envelope * v4)))
            end
            v1.Size = NumberSequence.new(v2)
            v1.Speed = NumberRange.new(v1.Speed.Min * v4, v1.Speed.Max * v4)
            v1.Acceleration = v1.Acceleration * v4
        end
        v1.Parent = v5
        if v6 then
            v1.Enabled = true
        end
        v1:AddTag(v7)
        v1:AddTag("Effect")
    end
end

local function destroyTagged(a1, a2, a3) -- Line: 559 -- types: a1: userdata, a2: string, a3: boolean?
    for i, j in if not a3 then a1:GetChildren() else a1:GetDescendants() do
        if j:HasTag(a2) then
            j:Destroy()
        end
    end
end

local u95 = {
    FxFolder = "Golden",
    CleanupTag = "Cleanup_GoldenFX",
    VisualTag = "GoldenVisual",
    PartnerVisualTag = "SilverVisual",
    Palette = u30,
}

function u95.SelectAppearance(a1) -- Line: 575 -- types: a1: table
    return a1.Golden
end

function u95.SelectPartnerAppearance(a1) -- Line: 578 -- types: a1: table
    return a1.Silver
end

local u98 = {
    FxFolder = "Silver",
    CleanupTag = "Cleanup_SilverFX",
    VisualTag = "SilverVisual",
    PartnerVisualTag = "GoldenVisual",
    Palette = u41,
}

function u98.SelectAppearance(a1) -- Line: 590 -- types: a1: table
    return a1.Silver
end

function u98.SelectPartnerAppearance(a1) -- Line: 593 -- types: a1: table
    return a1.Golden
end

local u101 = {
    FxFolder = "Golden",
    CleanupTag = "Cleanup_BlackFX",
    VisualTag = "BlackVisual",
    PartnerVisualTag = "GoldenVisual",
    Palette = v1,
    AppearanceColor = v1.Lighter,
}

function u101.SelectAppearance(a1) -- Line: 605 -- types: a1: table
    return a1.Golden
end

function u101.SelectPartnerAppearance(a1) -- Line: 608 -- types: a1: table
    return a1.Golden
end

local function clearMetal(a1, a2, a3) -- Line: 613
    -- upvalues: destroyTagged (val), getTextureOverrideBindings (val), removeMetalTextureOverride (val)
    -- upvalues: getStoredOriginalMaterial (val)
    local Attribute, VisualTag, VisualTag_2
    if a2 then
        destroyTagged(a2, a3.CleanupTag)
    end
    local v1 = getTextureOverrideBindings(a1)
    if v1 ~= nil then
        removeMetalTextureOverride(v1, a3.SelectAppearance, a3.SelectPartnerAppearance, a3.VisualTag, a3.PartnerVisualTag)
        return
    end
    local v2 = a3
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            VisualTag = v2.VisualTag
            if j:HasTag(VisualTag) then
                VisualTag_2 = v2.VisualTag
                j:RemoveTag(VisualTag_2)
                v1 = j:GetAttribute("Mutation_OriginalColor")
                if typeof(v1) == "Color3" then
                    j.Color = v1
                end
                v1 = getStoredOriginalMaterial(j)
                if v1 then
                    j.Material = v1
                end
                Attribute = j:GetAttribute("Mutation_OriginalMaterialVariant")
                v1 = if typeof(Attribute) ~= "string" then nil else Attribute
                if v1 then
                    j.MaterialVariant = v1
                end
                if j:IsA("UnionOperation") then
                    v1 = j:GetAttribute("Cleanup_OriginalUserPartColor")
                    if typeof(v1) == "boolean" then
                        j.UsePartColor = v1
                        j:SetAttribute("Cleanup_OriginalUserPartColor", nil)
                    end
                end
            end
        end
    end
end

local function applyMetal(a1, a2, a3, a4, a5) -- Line: 656
    -- upvalues: clearMetal (val), cloneFxInto (val), getTextureOverrideBindings (val), applyMetalTextureOverride (val)
    -- upvalues: u65 (ref), u64 (val), ReplicatedStorage (val)
    local Darker, Lighter, MaterialVariant, Name, Palette, Parent, Plastic, UsePartColor, VisualTag, v1, v2
    clearMetal(a1, a2, a3)
    if a2 then
        cloneFxInto(a2, a3.FxFolder, a3.CleanupTag)
    end
    local v3 = getTextureOverrideBindings(a1)
    if v3 ~= nil then
        applyMetalTextureOverride(v3, a3.SelectAppearance, a3.VisualTag, a3.AppearanceColor)
        return
    end
    local v4, v5, v6, v7 = a2, a4, a5, a3
    for i, j in a1:GetDescendants() do
        if not j:IsA("BasePart") then
            if j:IsA("SurfaceAppearance") then
                Parent = j.Parent
                if Parent then
                    v1 = true
                    if Parent:GetAttribute("MutationsDontModify") ~= true then
                        v1 = true
                        if Parent:GetAttribute("DontAddTexture") ~= true then
                            v1 = true
                            if Parent:GetAttribute("IsEye") ~= true then
                                v1 = Parent:GetAttribute("MutationFXDontRender") == true
                            end
                        end
                    end
                    if not v1 then
                        j:Destroy()
                    end
                end
            end
        elseif not j:HasTag("Effect") then
            v1 = true
            if j:GetAttribute("MutationsDontModify") ~= true then
                v1 = true
                if j:GetAttribute("DontAddTexture") ~= true then
                    v1 = true
                    if j:GetAttribute("IsEye") ~= true then
                        v1 = j:GetAttribute("MutationFXDontRender") == true
                    end
                end
            end
            if not v1 then
                Palette = v7.Palette
                if j:IsA("UnionOperation") then
                    if j:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                        UsePartColor = j.UsePartColor
                        j:SetAttribute("Cleanup_OriginalUserPartColor", UsePartColor)
                    end
                    j.UsePartColor = true
                end
                Darker = Palette.Darker
                Lighter = Palette.Lighter
                v2 = (u65 or u64):NextNumber()
                j.Color = Darker:Lerp(Lighter, v2)
                Plastic = Enum.Material.Plastic
                if not j:GetAttribute("Mutation_OriginalMaterial") then
                    Name = j.Material.Name
                    j:SetAttribute("Mutation_OriginalMaterial", Name)
                end
                j.Material = Plastic
                if not j:GetAttribute("Mutation_OriginalMaterialVariant") then
                    MaterialVariant = j.MaterialVariant
                    j:SetAttribute("Mutation_OriginalMaterialVariant", MaterialVariant)
                end
                j.MaterialVariant = "StudsMetallic"
                VisualTag = v7.VisualTag
                j:AddTag(VisualTag)
                if j:IsA("MeshPart") then
                    j.TextureID = ""
                end
            elseif j:IsA("SurfaceAppearance") then
                Parent = j.Parent
                if Parent then
                    v1 = true
                    if Parent:GetAttribute("MutationsDontModify") ~= true then
                        v1 = true
                        if Parent:GetAttribute("DontAddTexture") ~= true then
                            v1 = true
                            if Parent:GetAttribute("IsEye") ~= true then
                                v1 = Parent:GetAttribute("MutationFXDontRender") == true
                            end
                        end
                    end
                    if not v1 then
                        j:Destroy()
                    end
                end
            end
        elseif j:IsA("SurfaceAppearance") then
            Parent = j.Parent
            if Parent then
                v1 = true
                if Parent:GetAttribute("MutationsDontModify") ~= true then
                    v1 = true
                    if Parent:GetAttribute("DontAddTexture") ~= true then
                        v1 = true
                        if Parent:GetAttribute("IsEye") ~= true then
                            v1 = Parent:GetAttribute("MutationFXDontRender") == true
                        end
                    end
                end
                if not v1 then
                    j:Destroy()
                end
            end
        end
    end
    if v4 and v5 and v6 then
        local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
        if Mutations and Mutations:FindFirstChild(v5) then
            cloneFxInto(v4, v5, v6, true)
        end
    end
end

local function tintModel(a1, a2, a3) -- Line: 703 -- types: a1: userdata, a2: CFrame, a3: number
    local Attribute, Color, SurfaceAppearance, TextureID, v1
    local v2, v3 = a2, a3
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and not j:HasTag("NoTint") then
            Attribute = j:GetAttribute("OriginalColor")
            if not (if typeof(Attribute) ~= "Color3" then nil else Attribute) then
                Color = j.Color
                j:SetAttribute("OriginalColor", Color)
            end
            j.Color = (v1 or j.Color):Lerp(v2, v3)
            SurfaceAppearance = j:FindFirstChildOfClass("SurfaceAppearance")
            if SurfaceAppearance then
                if SurfaceAppearance:GetAttribute("Tint_OriginalSurfaceColor") == nil then
                    SurfaceAppearance:SetAttribute("Tint_OriginalSurfaceColor", SurfaceAppearance.Color)
                end
                SurfaceAppearance.Color = v2
            elseif j:IsA("MeshPart") and j.TextureID ~= "" then
                TextureID = j.TextureID
                j:SetAttribute("Tint_OriginalTextureId", TextureID)
                j.TextureID = ""
            end
        end
    end
end

local function clearTint(a1) -- Line: 729 -- types: a1: userdata
    local Attribute, Attribute_2, Attribute_3, SurfaceAppearance, v1
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and not j:HasTag("NoTint") then
            Attribute = j:GetAttribute("OriginalColor")
            v1 = if typeof(Attribute) ~= "Color3" then nil else Attribute
            if v1 then
                j:SetAttribute("OriginalColor", nil)
                j.Color = v1
            end
            SurfaceAppearance = j:FindFirstChildOfClass("SurfaceAppearance")
            Attribute_2 = if not SurfaceAppearance then nil else SurfaceAppearance:GetAttribute("Tint_OriginalSurfaceColor")
            if SurfaceAppearance and typeof(Attribute_2) == "Color3" then
                SurfaceAppearance.Color = Attribute_2
                SurfaceAppearance:SetAttribute("Tint_OriginalSurfaceColor", nil)
            end
            Attribute_3 = j:GetAttribute("Tint_OriginalTextureId")
            if j:IsA("MeshPart") and typeof(Attribute_3) == "string" then
                j.TextureID = Attribute_3
                j:SetAttribute("Tint_OriginalTextureId", nil)
            end
        end
    end
end

function u66.SeedFor(a1, a2) -- Line: 763 -- upvalues: Checksum (val) -- types: a1: number, a2: string
    return (math.max(Checksum.PathSeed("MutationVisual", a1, a2) % 2147483647, 1))
end

function u66.WithVisualRandom(a1, a2) -- Line: 767 -- upvalues: u65 (ref) -- types: a1: userdata?, a2: function
    local v1 = u65
    if a1 ~= nil then
        u65 = a1
    end
    local success, err = pcall(a2)
    u65 = v1
    if not success then
        error(err, 0)
    end
end

function u66.GetFXPart(a1) -- Line: 780 -- upvalues: Constants (val), u25 (val), PartBounds (val) -- types: a1: userdata
    local v1, v2, v3
    if not a1 then
        warn("Mutations.Visuals.GetFXPart | No item given")
        return nil
    end
    local FXPart = a1:FindFirstChild("FXPart")
    if FXPart and FXPart:IsA("BasePart") then
        return FXPart
    end
    local PrimaryPart = nil
    if a1:IsA("Tool") then
        PrimaryPart = a1:FindFirstChild("Handle") or a1:FindFirstChild("Segment1")
    elseif a1:IsA("Model") then
        PrimaryPart = a1.PrimaryPart
    end
    if not PrimaryPart then
        v1 = ("Mutations.Visuals.GetFXPart | No primary part found for item '%*'"):format(a1.Name)
        if not Constants.IS_STUDIO then
            u25:AtError():Log(v1)
        else
            error(v1)
        end
        return nil
    end
    v1 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 1 and v:GetAttribute("MutationFXDontRender") ~= true then
            table.insert(v1, v)
        end
    end
    if not (#v1 > 0) then
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        v2 = BoundingBox
        v3 = BoundingBox_2
    else
        local v4, v5 = PartBounds(v1)
        v2 = v4
        v3 = v5
    end
    v1 = Instance.new("Part")
    v1.Name = "FXPart"
    v1.CFrame = v2
    v1.Size = v3
    v1.Transparency = 1
    v1.CanCollide = false
    v1.CanTouch = false
    v1.CanQuery = false
    v1.Anchored = false
    v1.Massless = true
    v1.Parent = a1
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = v1
    WeldConstraint.Part1 = PrimaryPart
    WeldConstraint.Parent = v1
    return v1
end

function u66.ApplyGolden(a1, a2) -- Line: 846
    -- upvalues: applyMetal (val), u95 (val)
    applyMetal(a1, a2, u95)
end

function u66.ClearGolden(a1, a2) -- Line: 850
    -- upvalues: clearMetal (val), u95 (val)
    clearMetal(a1, a2, u95)
end

function u66.ApplyBlack(a1, a2, a3, a4) -- Line: 854
    -- upvalues: applyMetal (val), u101 (val)
    applyMetal(a1, a2, u101, a3, a4)
end

function u66.ClearBlack(a1, a2) -- Line: 858
    -- upvalues: clearMetal (val), u101 (val)
    clearMetal(a1, a2, u101)
end

function u66.ApplySilver(a1, a2) -- Line: 862
    -- upvalues: applyMetal (val), u98 (val)
    applyMetal(a1, a2, u98)
end

function u66.ClearSilver(a1, a2) -- Line: 866
    -- upvalues: clearMetal (val), u98 (val)
    clearMetal(a1, a2, u98)
end

function u66.ShouldApplyMetalCombo(a1, a2) -- Line: 870 -- types: a1: userdata, a2: string
    if a2 == "Golden" then
        for k, n in a1:GetDescendants() do
            if n:HasTag("SilverVisual") then
                return true
            end
        end
        return false
    end
    if a2 ~= "Silver" then
        return false
    end
    for i, j in a1:GetDescendants() do
        if j:HasTag("GoldenVisual") then
            return true
        end
    end
    return false
end

function u66.ApplyMetalCombo(a1, a2) -- Line: 879
    -- upvalues: getTextureOverrideBindings (val), setActiveSurfaceAppearance (val), getSilverComboParts (val)
    -- upvalues: u66 (val), u95 (val), u98 (val), u41 (val), u30 (val)
    local UsePartColor, v1, v2, v3
    local v4 = getTextureOverrideBindings(a1)
    if v4 ~= nil then
        local GoldenSilver

        function v3(a1) -- Line: 884 -- types: a1: table
            return a1.GoldenSilver
        end

        for k, n in v4 do
            GoldenSilver = n.GoldenSilver
            setActiveSurfaceAppearance(n, GoldenSilver)
        end
        return
    end
    v4 = getSilverComboParts(a1, a2)
    v3 = Random.new(u66.SeedFor(a2, u95.FxFolder))
    local v5 = Random.new(u66.SeedFor(a2, u98.FxFolder))
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and not j:HasTag("Effect") then
            v1 = true
            if j:GetAttribute("MutationsDontModify") ~= true then
                v1 = true
                if j:GetAttribute("DontAddTexture") ~= true then
                    v1 = true
                    if j:GetAttribute("IsEye") ~= true then
                        v1 = j:GetAttribute("MutationFXDontRender") == true
                    end
                end
            end
            if not v1 then
                if j:IsA("UnionOperation") then
                    if j:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                        UsePartColor = j.UsePartColor
                        j:SetAttribute("Cleanup_OriginalUserPartColor", UsePartColor)
                    end
                    j.UsePartColor = true
                end
                if not v4[j] then
                    v2 = u30
                    v1 = v2.Darker:Lerp(v2.Lighter, (v3:NextNumber()))
                else
                    v2 = u41
                    v1 = v2.Darker:Lerp(v2.Lighter, (v5:NextNumber()))
                end
                j.Color = v1
            end
        end
    end
end

function u66.ApplyRainbow(a1, a2) -- Line: 905
    -- upvalues: u66 (val), cloneFxInto (val), getTextureOverrideBindings (val), getActiveSurfaceAppearance (val)
    local MaterialVariant, UsePartColor, v1
    u66.ClearRainbow(a1, a2)
    if a2 then
        cloneFxInto(a2, "Rainbow", "Cleanup_RainbowFX")
    end
    local v2 = getTextureOverrideBindings(a1)
    if v2 ~= nil then
        for k, n in v2 do
            v1 = getActiveSurfaceAppearance(n)
            v1:AddTag("RainbowPart")
            v1:AddTag("Cleanup_Rainbow")
        end
        return
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j:GetAttribute("DontAddTexture") ~= true then
            if j:IsA("UnionOperation") then
                if j:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                    UsePartColor = j.UsePartColor
                    j:SetAttribute("Cleanup_OriginalUserPartColor", UsePartColor)
                end
                j.UsePartColor = true
            end
            j:AddTag("RainbowPart")
            j:AddTag("Cleanup_Rainbow")
            v1 = j:HasTag("GoldenVisual") or j:HasTag("SilverVisual")
            if v1 then
                if not j:GetAttribute("Mutation_OriginalMaterialVariant") then
                    MaterialVariant = j.MaterialVariant
                    j:SetAttribute("Mutation_OriginalMaterialVariant", MaterialVariant)
                end
                j.MaterialVariant = "StudsMetallic"
            end
        end
    end
end

function u66.ClearRainbow(a1, a2) -- Line: 934
    -- upvalues: destroyTagged (val), getTextureOverrideBindings (val)
    local MaterialVariant, v1
    if a2 then
        destroyTagged(a2, "Cleanup_RainbowFX")
    end
    local v2 = getTextureOverrideBindings(a1)
    if v2 ~= nil then
        local v3 = nil
        local v4 = nil
        for k, n in v2, v3, v4 do
            for m, i5 in {n.Original, n.Golden, n.Silver, n.GoldenSilver} do
                if i5:HasTag("Cleanup_Rainbow") then
                    i5:RemoveTag("RainbowPart")
                    i5:RemoveTag("Cleanup_Rainbow")
                end
            end
        end
        return
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j:HasTag("Cleanup_Rainbow") then
            if j:IsA("UnionOperation") then
                v2 = j:GetAttribute("Cleanup_OriginalUserPartColor")
                if typeof(v2) == "boolean" then
                    j.UsePartColor = v2
                    j:SetAttribute("Cleanup_OriginalUserPartColor", nil)
                end
            end
            j:RemoveTag("RainbowPart")
            j:RemoveTag("Cleanup_Rainbow")
            v1 = j:HasTag("GoldenVisual") or j:HasTag("SilverVisual")
            if v1 then
                if not j:GetAttribute("Mutation_OriginalMaterialVariant") then
                    MaterialVariant = j.MaterialVariant
                    j:SetAttribute("Mutation_OriginalMaterialVariant", MaterialVariant)
                end
                j.MaterialVariant = "StudsMetallic"
            end
        end
    end
end

function u66.ApplyTint(a1, a2, a3) -- Line: 966
    -- upvalues: tintModel (val)
    tintModel(a1, a2, a3)
end

function u66.ClearTint(a1) -- Line: 970 -- upvalues: clearTint (val) -- types: a1: userdata
    clearTint(a1)
end

function u66.ApplyBloom(a1, a2, a3, a4, a5, a6, a7) -- Line: 974
    -- upvalues: u66 (val), ReplicatedStorage (val), cloneFxInto (val), tintModel (val)
    u66.ClearBloom(a1, a2, a4)
    if a2 then
        local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
        if Mutations and Mutations:FindFirstChild(a3) then
            cloneFxInto(a2, a3, a4, true, a7)
        end
    end
    tintModel(a1, a5, a6 or 0.65)
end

function u66.ClearBloom(a1, a2, a3) -- Line: 997
    -- upvalues: clearTint (val), destroyTagged (val)
    clearTint(a1)
    if a2 then
        destroyTagged(a2, a3, true)
    end
    destroyTagged(a1, a3, true)
end

return u66