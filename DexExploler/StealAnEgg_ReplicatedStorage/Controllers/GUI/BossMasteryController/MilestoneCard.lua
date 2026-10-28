-- Script path: ReplicatedStorage.Controllers.GUI.BossMasteryController.MilestoneCard
-- Decompile time: 9.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

local function colorAttribute(a1, a2) -- Line: 46 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    local v1 = ("%* is missing %*"):format(a1:GetFullName(), a2)
    assert(typeof(Attribute) == "Color3", v1)
    return Attribute
end

local function numberAttribute(a1, a2) -- Line: 55 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    local v1 = ("%* is missing %*"):format(a1:GetFullName(), a2)
    assert(typeof(Attribute) == "number", v1)
    return Attribute
end

local function stringAttribute(a1, a2) -- Line: 64 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    local v1 = ("%* is missing %*"):format(a1:GetFullName(), a2)
    assert(typeof(Attribute) == "string", v1)
    return Attribute
end

function v1.New(a1, a2, a3, a4, a5) -- Line: 73
    -- upvalues: Trove (val), TweenService (val), Timer (val), ButtonFX (val), HoverCard (val), Numbers (val)
    -- upvalues: Rarity (val), SwapGradient (val)
    local u7 = a1:Clone()
    u7.Name = a3
    u7.Visible = true
    u7.Parent = a2
    local MasteryLabel = u7.MasteryLabel
    local Fill = u7.Fill
    local BGDecor = u7.BGDecor
    local AccentStroke = u7:FindFirstChild("AccentStroke")
    if not AccentStroke then
        AccentStroke = u7.StrokeHolder.AccentStroke
    end
    local UIShadow = u7:FindFirstChildOfClass("UIShadow")
    local Claim = u7.Claim
    Claim.Active = true
    Claim.Selectable = true
    Claim.Interactable = true
    local UIGradient = Claim:FindFirstChildOfClass("UIGradient")
    local UIStroke = Claim.UIStroke
    local UIStrokeClr = Claim.UIStrokeClr
    local Price = Claim.Price
    local RewardTitle = u7.RewardTitle
    local RewardHolder = u7.RewardHolder
    local Template = RewardHolder:FindFirstChild("Template") or RewardHolder.Chip
    local v1 = Template:Clone()
    local Icon = v1.Icon
    local Amount = v1.Amount
    local ItemName = v1:FindFirstChild("ItemName")
    local CompletedCheckmark = v1.CompletedCheckmark
    local u52 = "Locked"
    local u53 = false
    local u54 = nil
    local u55 = nil
    local u58 = Trove.new()
    local v2 = ("%* is missing UIShadow"):format((u7:GetFullName()))
    assert(UIShadow ~= nil, v2)
    v2 = ("%* is missing UIGradient"):format((Claim:GetFullName()))
    assert(UIGradient ~= nil, v2)
    Template.Visible = false
    v1.Name = "Reward"
    v1.Visible = true
    v1.Parent = RewardHolder

    local function refreshIcon(a1) -- Line: 127
        -- upvalues: u58 (val), Icon (val), TweenService (upval), Timer (upval)
        u58:Clean()
        Icon.Image = a1.Icon
        Icon.ImageTransparency = 0
        local CycleIcons = a1.CycleIcons
        if CycleIcons ~= nil and not (#CycleIcons <= 1) then
            local v1 = Icon:Clone()
            v1.Name = "IncomingIcon"
            v1.Active = false
            v1.Selectable = false
            v1.ImageTransparency = 1
            v1.Parent = Icon.Parent
            u58:Add(v1)
            local v2 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            local u32 = {}
            u32[Icon] = (u58:Add((TweenService:Create(Icon, v2, {ImageTransparency = 0}))))
            u32[v1] = (u58:Add((TweenService:Create(v1, v2, {ImageTransparency = 0}))))
            local u56 = {}
            u56[Icon] = (u58:Add((TweenService:Create(Icon, v2, {ImageTransparency = 1}))))
            u56[v1] = (u58:Add((TweenService:Create(v1, v2, {ImageTransparency = 1}))))
            local u80 = Icon
            local u81 = v1
            local u82 = 1
            v2 = u58:Add((Timer.new(1.35)))
            u58:Connect(v2.Tick, function() -- Line: 172 -- upvalues: u82 (ref), CycleIcons (val), u81 (ref), u56 (val), u80 (ref), u32 (val)
                u82 = u82 % #CycleIcons + 1
                u81.Image = CycleIcons[u82]
                u56[u80]:Play()
                u32[u81]:Play()
                local v1 = u80
                u80 = u81
                u81 = v1
            end)
            v2:Start()
            return
        end
    end

    local function applyState(a1) -- Line: 182
        -- upvalues: u52 (ref), a5 (val), Fill (val), u7 (val), UIShadow (val), AccentStroke (val), BGDecor (val)
        -- upvalues: UIGradient (val), Claim (val), UIStroke (val), UIStrokeClr (val), Price (val), u53 (ref)
        -- upvalues: CompletedCheckmark (val)
        local v1, v2, v3, v4
        u52 = a1
        local v5 = if a1 ~= "Claimable" then "Locked" else "Claimable"
        if not a5 then
            v2 = u7
            v3 = v5 .. "FillColor"
            v1 = v2:GetAttribute(v3)
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof(v1) == "Color3", v4)
            Fill.BackgroundColor3 = v1
            v2 = u7
            v3 = v5 .. "ShadowColor"
            v1 = v2:GetAttribute(v3)
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof(v1) == "Color3", v4)
            UIShadow.Color = v1
            v2 = u7
            v3 = v5 .. "AccentColor"
            v1 = v2:GetAttribute(v3)
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof(v1) == "Color3", v4)
            AccentStroke.Color = v1
            v2 = u7
            v3 = v5 .. "DecorColor"
            v1 = v2:GetAttribute(v3)
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof(v1) == "Color3", v4)
            BGDecor.ImageColor3 = v1
            v2 = u7
            v3 = v5 .. "DecorTransparency"
            v1 = v2:GetAttribute(v3)
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof(v1) == "number", v4)
            BGDecor.ImageTransparency = v1
        end
        local new = ColorSequence.new
        v3 = Claim
        local v6 = v5 .. "ColorStart"
        v2 = v3:GetAttribute(v6)
        local v7 = ("%* is missing %*"):format(v3:GetFullName(), v6)
        assert(typeof(v2) == "Color3", v7)
        v6 = Claim
        local v8 = v5 .. "ColorEnd"
        v3 = v6:GetAttribute(v8)
        local v9 = ("%* is missing %*"):format(v6:GetFullName(), v8)
        assert(typeof(v3) == "Color3", v9)
        UIGradient.Color = new(v2, v3)
        v2 = Claim
        v3 = v5 .. "BorderColor"
        v1 = v2:GetAttribute(v3)
        v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
        assert(typeof(v1) == "Color3", v4)
        UIStroke.Color = v1
        v2 = Claim
        v3 = v5 .. "HighlightColor"
        v1 = v2:GetAttribute(v3)
        v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
        assert(typeof(v1) == "Color3", v4)
        UIStrokeClr.Color = v1
        if u53 then
            v1 = "Claiming..."
        elseif a1 == "Claimed" then
            v2 = Claim
            v8 = ("%* is missing ClaimedText"):format((v2:GetFullName()))
            assert(typeof((v2:GetAttribute("ClaimedText"))) == "string", v8)
        elseif a1 ~= "Locked" then
            v2 = Claim
            v3 = v5 .. "Text"
            v4 = ("%* is missing %*"):format(v2:GetFullName(), v3)
            assert(typeof((v2:GetAttribute(v3))) == "string", v4)
        else
            v1 = "Locked"
        end
        Price.Text = v1
        CompletedCheckmark.Visible = a1 == "Claimed"
        v5 = false
        if a1 == "Claimable" then
            v5 = not u53
        end
        Claim.AutoButtonColor = v5
    end

    local u142 = nil
    local u156 = ButtonFX(Claim, 1.05, function() -- Line: 218 -- upvalues: u52 (ref), u53 (ref), a4 (val), a3 (val), u142 (ref)
        if u52 == "Claimable" and not u53 then
            a4(a3, u142)
        end
    end)
    Icon.Active = true
    local u166 = HoverCard.Attach(Icon, function() -- Line: 224 -- upvalues: u54 (ref), u55 (ref)
        if u54 ~= nil and u55 ~= nil then
            return {{kind = "heading", text = u54}, {kind = "rule"}, {kind = "heading", text = u55}}
        end
        return nil
    end)
    u142 = {
        Button = Claim,
        Refresh = function(a1, a2, a3, a4) -- Line: 237
            -- upvalues: u7 (val), MasteryLabel (val), Numbers (upval), RewardTitle (val), ItemName (val)
            -- upvalues: Rarity (upval), SwapGradient (upval), refreshIcon (val), Amount (val), u54 (ref), u55 (ref)
            -- upvalues: applyState (val)
            u7.LayoutOrder = a4
            MasteryLabel.Text = Numbers.AddCommas(a1)
            RewardTitle.Text = a2.Title
            if ItemName then
                local Label = a2.Label or a2.Rarity or a2.Title
                ItemName.Text = Label
                local v1 = if not a2.Rarity then nil else Rarity.Get(a2.Rarity)
                SwapGradient(ItemName, if not v1 then nil else v1.RarityGradient)
            end
            refreshIcon(a2)
            Amount.Text = a2.Amount
            u54 = a2.HoverTitle
            u55 = a2.HoverDescription
            applyState(a3)
        end,
        SetVisible = function(a1) -- Line: 257 -- upvalues: u7 (val) -- types: a1: boolean
            u7.Visible = a1
        end,
        SetPending = function(a1) -- Line: 260 -- upvalues: u53 (ref), applyState (val), u52 (ref) -- types: a1: boolean
            u53 = a1
            applyState(u52)
        end,
        Destroy = function() -- Line: 264 -- upvalues: u156 (val), u166 (val), u58 (val), u7 (val)
            u156()
            u166()
            u58:Destroy()
            u7:Destroy()
        end,
    }
    return u142
end

return table.freeze(v1)