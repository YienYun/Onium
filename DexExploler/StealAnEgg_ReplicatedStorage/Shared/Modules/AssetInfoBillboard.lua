-- Script path: ReplicatedStorage.Shared.Modules.AssetInfoBillboard
-- Decompile time: 5.93 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local AssetSounds = require(ReplicatedStorage.Shared.Util.AssetSounds)
local t = require(ReplicatedStorage.Packages.t)
local Data = ReplicatedStorage.Assets.Extra.Data
local u55 = Vector2.new(70, 30)
local u56 = {"Mutations", "BaseMutation"}
local u59 = {}

local function dropGradients(a1) -- Line: 27 -- upvalues: SwapGradient (val) -- types: a1: userdata
    SwapGradient(a1, nil)
end

local function showRate(a1, a2) -- Line: 31 -- upvalues: Simple (val) -- types: a1: userdata, a2: number
    a1.Visible = a2 > 0
    a1.Text = if not (a2 > 0) then "" else ("$%*/s"):format((Simple.FormatCompact(a2)))
end

local function fitToAdornee(a1, a2) -- Line: 36 -- upvalues: u55 (val) -- types: a1: userdata, a2: userdata
    local Size = a1.Size
    a1.Size = UDim2.fromScale(
        math.min(u55.X, Size.X.Scale * (a2.Size.X / 0.8610000014305115)),
        (math.min(u55.Y, Size.Y.Scale * (a2.Size.Y / 0.7670000195503235)))
    )
end

local function dressRarity(a1, a2) -- Line: 44 -- upvalues: SwapGradient (val) -- types: a1: userdata
    local Rarity = a1:FindFirstChild("Rarity")
    if Rarity then
        SwapGradient(Rarity, nil)
        Rarity.Visible = false
        Rarity.Text = ""
    end
    local Odds = a1:FindFirstChild("Odds")
    if not Odds then
        return
    end
    SwapGradient(Odds, nil)
    local Rarity_2 = a2.Rarity
    if Rarity_2 and Rarity_2.RarityGradient then
        Rarity_2.RarityGradient:Clone().Parent = Odds
    end
    Odds.Text = a2.Rarity.DisplayName
    Odds.Visible = true
end

function u59.LiveMutations(a1, a2) -- Line: 70 -- upvalues: AssetSounds (val) -- types: a1: userdata
    local v1, v2 = AssetSounds.ReadMutationState(a1, "Mutations", "BaseMutation")
    if not (#v1 > 0) and not v2 then
        if not a2 then
            return {}, nil
        end
        local Mutations = a2.Mutations or {}
        return Mutations, a2.BaseMutation
    end
    return v1, v2
end

function u59.WriteTitle(a1, a2, a3, a4) -- Line: 86
    -- upvalues: AssetDisplayText (val)
    local DisplayName = a1:FindFirstChild("DisplayName")
    if DisplayName then
        DisplayName.RichText = true
        DisplayName.Text = AssetDisplayText.Compose(a2, a3, a4)
    end
    local Level = a1:FindFirstChild("Level")
    if Level then
        Level.Visible = false
        Level.Text = ""
    end
end

function u59.Range() -- Line: 105 -- upvalues: Data (val)
    return Data.MaxDistance
end

function u59.SetRate(a1, a2) -- Line: 107 -- upvalues: t (val), Simple (val) -- types: a1: userdata, a2: number
    t.strict(t.Instance)(a1)
    t.strict(t.number)(a2)
    local PerSecond = a1:FindFirstChild("PerSecond")
    local v1 = false
    if PerSecond ~= nil then
        v1 = PerSecond:IsA("TextLabel")
    end
    assert(v1, "an info card without a PerSecond label")
    PerSecond.Visible = a2 > 0
    PerSecond.Text = if not (a2 > 0) then "" else ("$%*/s"):format((Simple.FormatCompact(a2)))
end

function u59.Attach(a1, a2, a3, a4) -- Line: 117
    -- upvalues: t (val), AssetItem (val), Data (val), u56 (val), u55 (val), Assets (val), dressRarity (val), u59 (val)
    -- upvalues: AssetEarnings (val), Personalities (val), Simple (val)
    t.strict(t.string)(a2)
    if a4 ~= nil then
        t.strict(t.number)(a4)
    end
    local CENTER = a1:FindFirstChild("CENTER")
    if CENTER and CENTER:IsA("BasePart") then
        local v1
        if a3 then
            assert((AssetItem.AssetItemData(a3)))
        end
        local v2 = Data:Clone()
        local AssetInfoBillboardAnchor = a1:FindFirstChild("AssetInfoBillboardAnchor", true)
        v2.Adornee = if not AssetInfoBillboardAnchor then CENTER else if not AssetInfoBillboardAnchor:IsA("Attachment") then CENTER else if AssetInfoBillboardAnchor:IsA("Bone") then CENTER else AssetInfoBillboardAnchor
        for i, j in u56 do
            v1 = v2:FindFirstChild(j)
            if v1 then
                v1:Destroy()
            end
        end
        local Size = v2.Size
        v2.Size = UDim2.fromScale(
            math.min(u55.X, Size.X.Scale * (CENTER.Size.X / 0.8610000014305115)),
            (math.min(u55.Y, Size.Y.Scale * (CENTER.Size.Y / 0.7670000195503235)))
        )
        local v3 = Assets.Directory[a2]
        local DisplayName = v2.DisplayName
        local PerSecond = v2.PerSecond
        dressRarity(v2, v3)
        local v4, v5 = u59.LiveMutations(a1, a3)
        u59.WriteTitle(v2, v3.DisplayName, v4, v5)
        v5 = a4
        if v5 == nil then
            local LiveRatePerSecond = AssetEarnings.LiveRatePerSecond
            local v6 = a3
            if not v6 then
                v6 = {Scale = 1, HasBeenFirstPlaced = true, Category = a2}
                v6.Mutations = {}
                v6.Personality = Personalities.Personalities.Normal
            end
            local success, err = pcall(LiveRatePerSecond, v6, 0)
            v5 = if not success then 0 else err
        end
        if PerSecond then
            PerSecond.Visible = v5 > 0
            PerSecond.Text = if not (v5 > 0) then "" else ("$%*/s"):format((Simple.FormatCompact(v5)))
        end
        v2.Parent = a1
        return v2, DisplayName, PerSecond
    end
    return nil
end

return u59