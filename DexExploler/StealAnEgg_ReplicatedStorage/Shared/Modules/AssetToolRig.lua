-- Script path: ReplicatedStorage.Shared.Modules.AssetToolRig
-- Decompile time: 13.39 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetInfoBillboard = require(ReplicatedStorage.Shared.Modules.AssetInfoBillboard)
local Discard = require(ReplicatedStorage.Shared.Utils.VFX).Discard
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetInvertedModelPresentation = require(ReplicatedStorage.Shared.Modules.AssetInvertedModelPresentation)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local AssetRigFactory = require(ReplicatedStorage.Shared.Modules.AssetRigFactory)
local Physics = require(ReplicatedStorage.Shared.Utils.Physics)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local AssetSounds = require(ReplicatedStorage.Shared.Util.AssetSounds)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u89 = {
    Name = "Handle",
    Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
    Transparency = 1,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    Anchored = false,
    Massless = true,
}
local u90 = {
    ["Cave Dragon"] = "HumanoidRootPart",
    Warden = "HumanoidRootPart",
    ["Eternal Lunar Dragon"] = "HumanoidRootPart",
    Unicorn = "HumanoidRootPartXZBoundsBottomY",
}
local u95 = {}

function u95.HumanoidRootPartXZBoundsBottomY(a1, a2) -- Line: 52 -- upvalues: ModelBounds (val)
    local v1, v2 = ModelBounds(a1)
    return a2.CFrame.Rotation + Vector3.new(a2.Position.X, v1.Position.Y - v2.Y * 0.5, a2.Position.Z)
end

local v1 = {}

local function pinHandleContract(a1) -- Line: 61 -- types: a1: userdata
    a1.RequiresHandle = true
    a1.CanBeDropped = false
end

local function stamp(a1, a2) -- Line: 66 -- types: a1: userdata, a2: table
    for i, j in a2 do
        a1:SetAttribute(j[1], j[2])
    end
end

local function copyAttribute(a1, a2, a3) -- Line: 72 -- types: a1: userdata, a2: string
    if a1:GetAttribute(a2) ~= a3 then
        a1:SetAttribute(a2, a3)
    end
end

local function ensureGrip(a1) -- Line: 78 -- upvalues: u89 (val) -- types: a1: userdata
    local Handle = a1:FindFirstChild("Handle")
    if Handle and Handle:IsA("BasePart") then
        return Handle
    end
    local Part = Instance.new("Part")
    for i, j in u89 do
        Part[i] = j
    end
    Part.Parent = a1
    a1.RequiresHandle = true
    a1.CanBeDropped = false
    return Part
end

local function seatRigOnGrip(a1, a2, a3, a4) -- Line: 96
    -- upvalues: ensureGrip (val), u95 (val), ModelBounds (val)
    local CFrame_2, v1
    local v2 = a3 or 1
    assert(v2, "luau")
    local v3 = assert(a2.PrimaryPart, (("%* cannot be gripped without a root"):format((a2:GetFullName()))))
    local Pivot = a2:GetPivot()
    local v4 = ensureGrip(a1)
    if not a4 then
        local v5
        v5, v1 = ModelBounds(a2)
        CFrame_2 = v5 * CFrame.new(0, v1.Y * -0.5, v2 * (v1.Z * 0.1))
    else
        local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart", true)
        local v6 = false
        if HumanoidRootPart ~= nil then
            v6 = HumanoidRootPart:IsA("BasePart")
        end
        assert(v6, (("%* is missing the root its grip is anchored to"):format((a2:GetFullName()))))
        v1 = u95[a4]
        CFrame_2 = if not v1 then HumanoidRootPart.CFrame else v1(a2, HumanoidRootPart)
    end
    a2:PivotTo(v4.CFrame * (CFrame_2:ToObjectSpace(Pivot)))
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = v3
    WeldConstraint.Part1 = v4
    WeldConstraint.Parent = v3
    return v4
end

local function ownedGamepassesFor(a1) -- Line: 129 -- upvalues: Constants (val) -- types: a1: userdata
    if not Constants.IS_SERVER then
        return nil
    end
    local v1, v2 = require(game:GetService("ServerScriptService").Library.Database).UnsafeGetProfileAwait(a1)
    if v1 and v2 then
        return v2.Gamepasses
    end
    return nil
end

function v1.Build(a1, a2, a3) -- Line: 141
    -- upvalues: AssetItem (val), t (val), Assets (val), AssetPalette (val), AssetDisplayText (val)
    -- upvalues: AssetRigFactory (val), CollectionService (val), Constants (val), AssetEarnings (val), ensureGrip (val)
    -- upvalues: Discard (val), Personalities (val), Physics (val), seatRigOnGrip (val), u90 (val)
    -- upvalues: AssetInvertedModelPresentation (val), AssetSounds (val), AssetInfoBillboard (val), Simple (val)
    local Gamepasses
    assert((AssetItem.AssetItemData(a1)))
    t.strict(t.string)(a2)
    local Category = a1.Category
    local v1 = Assets.Directory[Category]
    local v2 = AssetPalette.SettleFields(Category, a1.EyeColor, a1.ColorSeed, a1.ColorIndex)
    local v3 = table.concat(a1.Mutations, ", ")
    local v4 = v1.DisplayName or Category
    local Tool = Instance.new("Tool")
    Tool.Name = AssetDisplayText.ForRecord(a1)
    Tool.RequiresHandle = true
    Tool.CanBeDropped = false
    local v5 = {}
    local v6 = {"BaseMutation", a1.BaseMutation}
    local v7 = {"Weight", AssetRigFactory.Mass(Category, a1.Scale)}
    local v8 = {"Scale", a1.Scale}
    local v9 = {"EyeColor", v2.EyeColor}
    local v10 = {"ColorSeed", v2.ColorSeed}
    local v11 = {"ColorIndex", v2.ColorIndex}
    local v12 = {"Category", v1._id}
    local v13 = {"Favorite", a1.IsFavorite or false}
    v5[1] = {"GuardTransparencyExcluded", true}
    v5[2] = {"UID", a2}
    v5[3] = {"Mutations", v3}
    v5[4] = v6
    v5[5] = {"DisplayName", v4}
    v5[6] = v7
    v5[7] = v8
    v5[8] = v9
    v5[9] = v10
    v5[10] = v11
    v5[11] = v12
    v5[12] = v13
    v5[13] = {"ItemType", "Asset"}
    for i, j in v5 do
        Tool:SetAttribute(j[1], j[2])
    end
    CollectionService:AddTag(Tool, "AssetTool")
    local Configuration = Instance.new("Configuration")
    Configuration.Name = "Configuration"
    Configuration.Parent = Tool
    local v14 = {}
    local v15 = {"baseMutation", a1.BaseMutation}
    local v16 = {"scale", a1.Scale}
    v7 = {"eyeColor", v2.EyeColor}
    v8 = {"colorSeed", v2.ColorSeed}
    v9 = {"colorIndex", v2.ColorIndex}
    v10 = {"rarity", v1.Rarity._id}
    v11 = {"money", a1.GeneratedMoney or 0}
    v14[1] = {"mutations", v3}
    v14[2] = v15
    v14[3] = {"displayName", v4}
    v14[4] = v16
    v14[5] = v7
    v14[6] = v8
    v14[7] = v9
    v14[8] = v10
    v14[9] = v11
    local v17 = v14
    for k, n in v17 do
        Configuration:SetAttribute(n[1], n[2])
    end
    if Constants.IS_SERVER then
        v14, v17 = require(game:GetService("ServerScriptService").Library.Database).UnsafeGetProfileAwait(a3)
        Gamepasses = if not v14 then nil else if not v17 then nil else v17.Gamepasses
    else
        Gamepasses = nil
    end
    for m, i5 in {
        {"perSecond", AssetEarnings.LiveRatePerSecond(a1, Gamepasses)},
        {"perSecondDisplay", AssetEarnings.RatePerSecond(a1, Gamepasses)},
    } do
        Configuration:SetAttribute(i5[1], i5[2])
    end
    local u205 = ensureGrip(Tool)
    local u206 = nil
    local u207 = nil
    local u208 = nil

    local function mirrorTags() -- Line: 199 -- upvalues: Tool (val), Configuration (val), u206 (ref)
        local Attribute = Tool:GetAttribute("Mutations")
        local Attribute_2 = Tool:GetAttribute("BaseMutation")
        local v1 = Configuration
        if v1:GetAttribute("mutations") ~= Attribute then
            v1:SetAttribute("mutations", Attribute)
        end
        v1 = Configuration
        if v1:GetAttribute("baseMutation") ~= Attribute_2 then
            v1:SetAttribute("baseMutation", Attribute_2)
        end
        if u206 then
            v1 = u206
            if v1:GetAttribute("Mutations") ~= Attribute then
                v1:SetAttribute("Mutations", Attribute)
            end
            v1 = u206
            if v1:GetAttribute("BaseMutation") ~= Attribute_2 then
                v1:SetAttribute("BaseMutation", Attribute_2)
            end
        end
    end

    local function dropCard() -- Line: 212 -- upvalues: u207 (ref), Discard (upval), u208 (ref)
        if u207 then
            Discard(u207, 0)
            u207 = nil
            u208 = nil
        end
    end

    local function ensureRig() -- Line: 229
        -- upvalues: u206 (ref), Tool (val), u205 (ref), u207 (ref), Discard (upval), u208 (ref), a1 (val)
        -- upvalues: Personalities (upval), AssetRigFactory (upval), a2 (val), Physics (upval), seatRigOnGrip (upval)
        -- upvalues: u90 (upval), Category (val), AssetInvertedModelPresentation (upval), mirrorTags (val)
        if u206 and u206.Parent == Tool and u205.Parent == Tool then
            return u206
        end
        if u207 then
            Discard(u207, 0)
            u207 = nil
            u208 = nil
        end
        if u206 then
            Discard(u206, 0)
            u206 = nil
        end
        local v1 = a1.Personality == Personalities.Personalities.InvertedModel
        local v2 = a1
        if v1 then
            v2 = table.clone(a1)
            v2.Mutations = table.clone(a1.Mutations)
            v2.Personality = Personalities.Personalities.Normal
        end
        local v3 = AssetRigFactory.BuildActive(a2, v2, true, true)
        Physics.DisableAllPhysics(v3)
        Physics.SetAnchored(v3, false)
        seatRigOnGrip(Tool, v3, nil, u90[Category])
        if v1 then
            AssetInvertedModelPresentation.Invert(v3)
            Physics.SetAnchored(v3, false)
        end
        for i, j in v3:GetDescendants() do
            if j:IsA("BasePart") then
                j:SetAttribute("KillPartIgnore", true)
            end
        end
        u206 = v3
        v3.Parent = Tool
        mirrorTags()
        return v3
    end

    local function refreshCaptions() -- Line: 267
        -- upvalues: Configuration (val), AssetRigFactory (upval), Category (val), AssetSounds (upval), Tool (val)
        -- upvalues: mirrorTags (val), AssetDisplayText (upval), u207 (ref), AssetInfoBillboard (upval), u208 (ref)
        -- upvalues: Simple (upval)
        local v1 = Configuration:GetAttribute("displayName") or ""
        local Attribute = Configuration:GetAttribute("scale")
        local v2 = if typeof(Attribute) ~= "number" then 1 else Attribute
        local v3 = AssetRigFactory.Mass(Category, v2)
        v2 = AssetSounds.ParseMutationList(Tool:GetAttribute("Mutations") or "")
        local Attribute_2 = Tool:GetAttribute("BaseMutation")
        mirrorTags()
        Tool:SetAttribute("Weight", v3)
        Tool.Name = AssetDisplayText.WithMass(v1, v2, Attribute_2, v3)
        if not u207 then
            return
        end
        AssetInfoBillboard.WriteTitle(u207, v1, v2, Attribute_2)
        if not u208 then
            return
        end
        local Attribute_3 = Configuration:GetAttribute("perSecondDisplay")
        if typeof(Attribute_3) ~= "number" then
            Attribute_3 = Configuration:GetAttribute("perSecond")
        end
        u208.Text = ("$%*/s"):format((Simple.FormatCompact(Attribute_3)))
    end

    local function ensureCard() -- Line: 295
        -- upvalues: ensureRig (val), u207 (ref), AssetInfoBillboard (upval), Category (val), a1 (val), a3 (val)
        -- upvalues: u205 (ref), u208 (ref), refreshCaptions (val)
        local v1, v2
        local v3 = ensureRig()
        if u207 then
            return
        end
        v1, _, v2 = AssetInfoBillboard.Attach(v3, Category, a1)
        if not v1 then
            return
        end
        u207 = v1
        v1.MaxDistance = math.max(v1.MaxDistance * 2.8, a3.CameraMaxZoomDistance + (v1.Adornee.Position - u205.Position).Magnitude)
        v1.Enabled = true
        u208 = v2
        refreshCaptions()
    end

    local function rebuildCard() -- Line: 318
        -- upvalues: mirrorTags (val), u207 (ref), Discard (upval), u208 (ref), ensureCard (val), refreshCaptions (val)
        mirrorTags()
        if u207 then
            if u207 then
                Discard(u207, 0)
                u207 = nil
                u208 = nil
            end
            ensureCard()
        end
        refreshCaptions()
    end

    local u221 = {}
    v11 = (Configuration:GetAttributeChangedSignal("perSecondDisplay")):Connect(refreshCaptions)
    v12 = (Configuration:GetAttributeChangedSignal("perSecond")):Connect(refreshCaptions)
    v13 = (Configuration:GetAttributeChangedSignal("displayName")):Connect(refreshCaptions)
    local v18 = (Configuration:GetAttributeChangedSignal("scale")):Connect(refreshCaptions)
    local v19 = (Tool:GetAttributeChangedSignal("Mutations")):Connect(rebuildCard)
    local v20 = (Tool:GetAttributeChangedSignal("BaseMutation")):Connect(rebuildCard)
    local v21 = Tool.Equipped:Connect(function() -- Line: 334 -- upvalues: ensureCard (val), refreshCaptions (val)
        ensureCard()
        refreshCaptions()
    end)
    u221[1] = v11
    u221[2] = v12
    u221[3] = v13
    u221[4] = v18
    u221[5] = v19
    u221[6] = v20
    u221[7] = v21
    u221[8] = Tool.Unequipped:Connect(function() -- Line: 220 -- upvalues: u207 (ref), Discard (upval), u208 (ref), u206 (ref)
        if u207 then
            Discard(u207, 0)
            u207 = nil
            u208 = nil
        end
        if u206 then
            Discard(u206, 0)
            u206 = nil
        end
    end)
    Tool.Destroying:Connect(function() -- Line: 341 -- upvalues: u221 (val), u207 (ref), Discard (upval), u208 (ref), u206 (ref)
        for i, j in u221 do
            j:Disconnect()
        end
        if u207 then
            Discard(u207, 0)
            u207 = nil
            u208 = nil
        end
        if u206 then
            Discard(u206, 0)
            u206 = nil
        end
    end)
    Tool.Parent = a3:WaitForChild("Backpack")
    return Tool
end

return v1