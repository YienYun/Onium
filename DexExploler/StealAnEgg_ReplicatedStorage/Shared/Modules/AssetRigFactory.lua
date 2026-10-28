-- Script path: ReplicatedStorage.Shared.Modules.AssetRigFactory
-- Decompile time: 10.95 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetInvertedModelPresentation = require(ReplicatedStorage.Shared.Modules.AssetInvertedModelPresentation)
local SpecialLuckyBlockAsset = require(ReplicatedStorage.Shared.Util.SpecialLuckyBlockAsset)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Retry = require(ReplicatedStorage.Shared.Utils.Retry)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u68 = require(ReplicatedStorage.Packages.Log).new()

local function markReplayOrigin(a1, a2) -- Line: 29 -- types: a1: userdata, a2: userdata
    a1:SetAttribute("UG_REPLAY_BAKED_ORIGIN", (a2:GetPivot():Inverse()) * (a1:GetPivot()))
end

local u70 = {}

function u70.Scale(a1) -- Line: 35 -- types: a1: number
    if typeof(a1) == "number" then
        return (math.max(a1, 0))
    end
    return 1
end

function u70.RigScale(a1, a2) -- Line: 39 -- upvalues: u70 (val), AssetModels (val) -- types: a1: string, a2: number
    return (u70.Scale(a2)) * AssetModels.GetBaseModelScale(a1)
end

function u70.Mass(a1, a2) -- Line: 43 -- upvalues: Assets (val), u70 (val) -- types: a1: string, a2: number
    return (tonumber(Assets.Directory[a1].ModelWeight) or 1) * u70.Scale(a2)
end

function u70.Resize(a1, a2, a3) -- Line: 48 -- upvalues: u70 (val) -- types: a1: userdata, a2: string, a3: number
    local v1 = u70.RigScale(a2, a3)
    a1:ScaleTo(v1)
    return v1
end

function u70.Extents(a1) -- Line: 54 -- upvalues: AssetItem (val), AssetModels (val)
    assert((AssetItem.AssetItemData(a1)))
    local v1 = AssetModels.GetVisibleBoundsData(a1.Category)
    assert(0 < v1.TemplateScale, (("template scale for %* is not above zero"):format(a1.Category)))
    return v1.Size / v1.TemplateScale
end

function u70.Build(a1, a2) -- Line: 63
    -- upvalues: AssetItem (val), AssetModels (val), AssetPalette (val), Mutations (val), u70 (val), Personalities (val)
    -- upvalues: AssetInvertedModelPresentation (val)
    assert((AssetItem.AssetItemData(a1)))
    local Category = a1.Category
    local v1 = assert(AssetModels.Resolve(Category), (("%* has no rig template"):format(Category)))
    local v2 = v1:Clone()
    local Segment1 = v2:FindFirstChild("Segment1", true) or v2.PrimaryPart
    v2.PrimaryPart = Segment1
    assert(v2.PrimaryPart, (("the %* rig template names no primary part"):format(Category)))
    v2:SetAttribute("UG_REPLAY_BAKED_ORIGIN", (v1:GetPivot():Inverse()) * (v2:GetPivot()))
    local v3, v4 = a1, a2
    for i, v in ipairs(v2:GetDescendants()) do
        if v:IsA("BasePart") then
            v1 = v.Transparency == 1
            v.Anchored = false
            v.CanQuery = not v1
            if v1 or v4 then
                v.CanCollide = false
            end
        end
    end
    local v5 = AssetPalette.SettleFields(Category, v3.EyeColor, v3.ColorSeed, v3.ColorIndex)
    AssetPalette.PaintModel(v2, Category, v5.EyeColor, v5.ColorSeed, v5.ColorIndex)
    for i2, j in Mutations.Sanitize(v3.Mutations) do
        Mutations.ApplyTo(v2, j, v5.ColorSeed)
    end
    u70.Resize(v2, Category, v3.Scale)
    if v3.Personality == Personalities.Personalities.InvertedModel then
        AssetInvertedModelPresentation.Invert(v2)
    end
    return v2
end

function u70.Strip(a1, a2, a3) -- Line: 102 -- upvalues: t (val) -- types: a1: userdata, a2: boolean?, a3: boolean?
    local v1, v2, v3, v4
    t.strict(t.instanceIsA("Model"))(a1)
    local PrimaryPart = a1.PrimaryPart or a1:FindFirstChild("HumanoidRootPart", true)
    local v5 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        v2 = v:IsA("AnimationController") or v:IsA("Animator")
        v3 = v:IsA("Bone")
        if v2 and not v4 or v3 and not v1 or v:IsA("Humanoid") then
            v5[#v5 + 1] = v
        end
    end
    local v6 = os.clock()
    for i2, i3 in ipairs(v5) do
        i3:Destroy()
        if i2 < #v5 and 0.002 <= os.clock() - v6 then
            task.wait()
            os.clock()
        end
    end
    if PrimaryPart and PrimaryPart:IsA("BasePart") then
        local v7
        v7.PrimaryPart = PrimaryPart
    end
end

local function playIdleOnceInWorld(a1, a2, a3) -- Line: 135
    -- upvalues: Retry (val), u68 (val)
    local u3 = nil
    a1.AncestryChanged:Connect(function(a1_2, a2_2) -- Line: 137 -- upvalues: u3 (ref), Retry (upval), a2 (val), a3 (val), u68 (upval), a1 (val)
        local v1, v2
        if a2_2 and a2_2:IsDescendantOf(workspace) then
            u3:Disconnect()
            v1, v2 = Retry(function() -- Line: 144 -- upvalues: a2 (upval), a3 (upval)
                return a2:LoadAnimation(a3)
            end):await()
            if not v1 then
                (u68:AtError()):Log((("idle track refused to load on %*: %*"):format(a1.Name, v2)))
                return
            end
            v2.Looped = true
            v2.Priority = Enum.AnimationPriority.Idle
            v2:Play()
            return
        end
        if a2_2 ~= workspace then
            return
        end
        u3:Disconnect()
        v1, v2 = Retry(function() -- Line: 144 -- upvalues: a2 (upval), a3 (upval)
            return a2:LoadAnimation(a3)
        end):await()
        if not v1 then
            (u68:AtError()):Log((("idle track refused to load on %*: %*"):format(a1.Name, v2)))
            return
        end
        v2.Looped = true
        v2.Priority = Enum.AnimationPriority.Idle
        v2:Play()
    end)
end

local function replaceRigController(a1, a2) -- Line: 158 -- upvalues: Constants (val) -- types: a1: userdata
    local AnimationController = a1:FindFirstChildWhichIsA("AnimationController", true)
    if AnimationController then
        local Animator = AnimationController:FindFirstChildWhichIsA("Animator")
        if Animator then
            Animator:Destroy()
        end
        AnimationController:Destroy()
    end
    local AnimationController_2 = Instance.new("AnimationController")
    AnimationController_2.Name = "AnimationController"
    AnimationController_2.Parent = a1:WaitForChild("Model")
    local Animator_2 = Instance.new("Animator")
    if Constants.IS_SERVER then
        Animator_2:SetAttribute("ActiveAssetRarity", a2)
    end
    Animator_2.Parent = AnimationController_2
    return Animator_2
end

function u70.BuildActive(a1, a2, a3, a4, a5) -- Line: 181
    -- upvalues: t (val), u70 (val), SpecialLuckyBlockAsset (val), Assets (val), replaceRigController (val), Retry (val)
    -- upvalues: u68 (val)
    t.strict(t.optional(t.string))(a1)
    local u19 = u70.Build(a2, true)
    local v1 = assert(u19.PrimaryPart, "a freshly built rig lost its primary part")
    v1.Anchored = true
    u19:SetAttribute("SpecialLuckyBlockAsset", (SpecialLuckyBlockAsset.Matches(a2)))
    v1 = Assets.Directory[a2.Category]
    local Idle = v1.Animations.Idle
    if a3 and Idle and u19:GetAttribute("AnimationsDisabled") ~= true then
        assert(Idle, (("%* was asked to animate without an idle track"):format(a2.Category)))
        local u55 = replaceRigController(u19, v1.Rarity._id)
        local u56 = nil
        u19.AncestryChanged:Connect(function(a1, a2) -- Line: 137 -- upvalues: u56 (ref), Retry (upval), u55 (val), Idle (val), u68 (upval), u19 (val)
            local v1, v2
            if a2 and a2:IsDescendantOf(workspace) then
                u56:Disconnect()
                v1, v2 = Retry(function() -- Line: 144 -- upvalues: u55 (upval), Idle (upval)
                    return u55:LoadAnimation(Idle)
                end):await()
                if not v1 then
                    (u68:AtError()):Log((("idle track refused to load on %*: %*"):format(u19.Name, v2)))
                    return
                end
                v2.Looped = true
                v2.Priority = Enum.AnimationPriority.Idle
                v2:Play()
                return
            end
            if a2 ~= workspace then
                return
            end
            u56:Disconnect()
            v1, v2 = Retry(function() -- Line: 144 -- upvalues: u55 (upval), Idle (upval)
                return u55:LoadAnimation(Idle)
            end):await()
            if not v1 then
                (u68:AtError()):Log((("idle track refused to load on %*: %*"):format(u19.Name, v2)))
                return
            end
            v2.Looped = true
            v2.Priority = Enum.AnimationPriority.Idle
            v2:Play()
        end)
        if a1 then
            u19:SetAttribute("UID", a1)
        end
        return u19
    end
    u70.Strip(u19, u19:GetAttribute("DontRemoveBones") or a4, a5)
    if a1 then
        u19:SetAttribute("UID", a1)
    end
    return u19
end

function u70.BuildWandering(a1, a2, a3, a4) -- Line: 216
    -- upvalues: t (val), AssetItem (val), u70 (val), ModelBounds (val), AssetModels (val)
    local v1
    t.strict(t.number)(a1)
    t.strict(t.string)(a2)
    t.strict(t.Instance)(a4)
    assert((AssetItem.AssetItemData(a3)))
    local v2 = u70.Build(a3, true)
    v2.Name = ("%*_%*"):format(a1, a2)
    local v3 = assert(v2.PrimaryPart, (("the %* rig has no primary part"):format(a3.Category)))
    local v4, v5 = ModelBounds(v2)
    v3.PivotOffset = CFrame.new(0, v4.Position.Y - v5.Y * 0.5 - v3.Position.Y, 0)
    v2:SetAttribute(
        "UG_REPLAY_BAKED_ORIGIN",
        (assert(AssetModels.Resolve(a3.Category), (("%* has no rig template"):format(a3.Category))):GetPivot():Inverse()) * (v2:GetPivot())
    )
    local v6, v7, v8 = a2, a1, a4
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            v1 = j.Transparency ~= 1
            j.CanQuery = v1
            j.CanTouch = false
            j.Massless = true
            j.Anchored = false
        end
    end
    v3.Anchored = true
    v2:SetAttribute("UID", v6)
    v2:SetAttribute("OwnerUserId", v7)
    v2.Parent = v8
    return v2
end

return u70