-- Script path: ReplicatedStorage.Client.ShopNavigation
-- Decompile time: 10.51 ms

local v1, v2
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
local ShopPreview = require(ReplicatedStorage.Client.ShopPreview)
local Promise = require(ReplicatedStorage.Packages.Promise)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v3 = GUI.Shop()
local ScrollingFrame = v3.Frame.ScrollingFrame
local ButtonsHolder = v3.Frame.ButtonsHolder
local v4 = Trove.new()
local u58 = v4:Extend()
local u59 = nil
local u64 = Color3.fromRGB(255, 230, 80)
local u70 = {
    Featured = ScrollingFrame.FeaturedSectionTitle,
    Speed = ScrollingFrame.SpeedSectionTitle,
    SpeedProducts = ScrollingFrame.Speed,
    Money = ScrollingFrame.Money,
}
local u75 = {}
local v5 = {
    section = "Featured",
    button = ButtonsHolder.Featured,
    anchor = u70.Featured,
    color = ButtonsHolder.Featured.SectionTitle.TextColor3,
}
local v6 = {
    section = "Speed",
    button = ButtonsHolder.Speed,
    anchor = u70.Speed,
    color = ButtonsHolder.Speed.SectionTitle.TextColor3,
}
local v7 = {
    section = "Money",
    button = ButtonsHolder.Money,
    anchor = u70.Money,
    color = ButtonsHolder.Money.SectionTitle.TextColor3,
}
u75[1] = v5
u75[2] = v6
u75[3] = v7
local StarsSectionTitle = ScrollingFrame:FindFirstChild("StarsSectionTitle")
local Stars = ButtonsHolder:FindFirstChild("Stars")
if StarsSectionTitle and StarsSectionTitle:IsA("GuiObject") and Stars and Stars:IsA("ImageButton") then
    u70.Stars = StarsSectionTitle
    table.insert(u75, 2, {
        section = "Stars",
        button = Stars,
        anchor = StarsSectionTitle,
        color = Stars.SectionTitle.TextColor3,
    })
end
local u117 = {}
for i, j in {"StarsSectionTitle", "DailyStockLabel", "Cards", "RestockTimer"} do
    v1 = ScrollingFrame:FindFirstChild(j)
    if v1 and v1:IsA("GuiObject") then
        u117[v1] = v1.LayoutOrder
    end
end
if Stars and Stars:IsA("GuiObject") then
    u117[Stars] = Stars.LayoutOrder
end

local function maximumScroll() -- Line: 90 -- upvalues: ScrollingFrame (val)
    return (math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y))
end

local function updateSection() -- Line: 97 -- upvalues: ScrollingFrame (val), u75 (val), u64 (val)
    local Y_4
    local section = "Featured"
    local v1 = ScrollingFrame.AbsolutePosition.Y + 12
    local v2 = math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y)
    local v3 = false
    if v2 > 0 then
        local Y_3 = ScrollingFrame.CanvasPosition.Y
        v3 = v2 - 2 <= Y_3
    end
    v2 = (-1 / 0)
    local v4 = nil
    local v5 = nil
    for i, j in u75, v4, v5 do
        Y_4 = j.anchor.AbsolutePosition.Y
        if j.anchor.Visible then
            if Y_4 <= v1 then
                if v2 <= Y_4 then
                    section = j.section
                end
            elseif v3 and v2 <= Y_4 then
                section = j.section
            end
        end
    end
    v4 = nil
    v5 = nil
    for k, n in u75, v4, v5 do
        v3 = n.section == section
        n.button.SectionTitle.TextColor3 = if not v3 then n.color else u64
        n.button:SetAttribute("SelectedSection", v3)
    end
end

local function placeStars() -- Line: 123 -- upvalues: ShopPreview (val), u117 (val), updateSection (val)
    local v1
    local v2 = ShopPreview.IsHalloween()
    local v3 = nil
    local v4 = nil
    for i, j in u117, v3, v4 do
        v1 = if not v2 then j else j + 9000
        i.LayoutOrder = v1
    end
    updateSection()
end

local function cancelTween() -- Line: 131 -- upvalues: u59 (ref)
    if u59 then
        u59:Cancel()
        u59 = nil
    end
end

local function scrollTo(a1) -- Line: 143
    -- upvalues: u70 (val), u59 (ref), ScrollingFrame (val), updateSection (val), TweenService (val)
    local v1 = u70[a1.section]
    if v1 ~= nil and v1.Visible then
        if u59 then
            u59:Cancel()
            u59 = nil
        end
        v1 = Vector2.new(0, (math.clamp(
            v1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y - 6,
            0,
            (math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y))
        )))
        if not a1.animated then
            ScrollingFrame.CanvasPosition = v1
            updateSection()
            return
        end
        u59 = TweenService:Create(ScrollingFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CanvasPosition = v1})
        u59:Play()
        return
    end
end

local v8 = {
    Open = function(a1) -- Line: 169
        -- upvalues: u58 (val), u59 (ref), ShopPreview (val), u117 (val), updateSection (val), Tabs (val)
        -- upvalues: scrollTo (val), Promise (val)
        local v1
        u58:Clean()
        if u59 then
            u59:Cancel()
            u59 = nil
        end
        local v2 = ShopPreview.IsHalloween()
        local v3 = nil
        local v4 = nil
        for i, j in u117, v3, v4 do
            v1 = if not v2 then j else j + 9000
            i.LayoutOrder = v1
        end
        updateSection()
        if not Tabs.Activate("Shop") then
            scrollTo({animated = false, section = a1})
            return
        end
        u58:AddPromise(((Promise.delay(0.22)):andThen(function() -- Line: 177 -- upvalues: Tabs (upval), scrollTo (upval), a1 (val)
            if Tabs.IsActive("Shop") then
                scrollTo({animated = false, section = a1})
            end
        end)))
    end,
}
v4:AttachToInstance(v3)
v4:Add(function() -- Line: 138 -- upvalues: u58 (val), u59 (ref)
    u58:Clean()
    if u59 then
        u59:Cancel()
        u59 = nil
    end
end)
for k, n in u75 do
    n.button.Active = true
    n.button.Selectable = true
    v4:Add((ButtonFX(n.button, 1.08, function() -- Line: 189 -- upvalues: u58 (val), u59 (ref), scrollTo (val), n (val)
        u58:Clean()
        if u59 then
            u59:Cancel()
            u59 = nil
        end
        scrollTo({animated = true, section = n.section})
    end)))
    v4:Add(((n.anchor:GetPropertyChangedSignal("Visible")):Connect(updateSection)))
end
v4:Add(((ScrollingFrame:GetPropertyChangedSignal("CanvasPosition")):Connect(updateSection)))
v4:Add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(updateSection)))
v4:Add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(updateSection)))
v4:Add((ScrollingFrame.InputBegan:Connect(function(a1) -- Line: 211 -- upvalues: u58 (val), u59 (ref) -- types: a1: userdata
    if a1.UserInputType == Enum.UserInputType.Touch or a1.UserInputType == Enum.UserInputType.MouseButton1 then
        u58:Clean()
        if u59 then
            u59:Cancel()
            u59 = nil
        end
    end
end)))
v4:Add((ScrollingFrame.InputChanged:Connect(function(a1) -- Line: 219 -- upvalues: u58 (val), u59 (ref) -- types: a1: userdata
    if a1.UserInputType == Enum.UserInputType.MouseWheel then
        u58:Clean()
        if u59 then
            u59:Cancel()
            u59 = nil
        end
    end
end)))
v4:Add((Tabs.Deactivated:Connect(function(a1) -- Line: 224 -- upvalues: u58 (val), u59 (ref) -- types: a1: string
    if a1 == "Shop" then
        u58:Clean()
        if u59 then
            u59:Cancel()
            u59 = nil
        end
    end
end)))
v4:Add((Tabs.Activated:Connect(function(a1) -- Line: 229 -- upvalues: ShopPreview (val), u117 (val), updateSection (val) -- types: a1: string
    if a1 == "Shop" then
        local v1
        local v2 = ShopPreview.IsHalloween()
        local v3 = nil
        local v4 = nil
        for i, j in u117, v3, v4 do
            v1 = if not v2 then j else j + 9000
            i.LayoutOrder = v1
        end
        updateSection()
    end
end)))
v4:Add((BalanceConfig.Changed:Connect(placeStars)))
v4:Add((ShopPreview.Changed:Connect(placeStars)))
for m, i5 in {"OldRobuxShop", "SpeedShop", "RobuxShopOLD"} do
    v4 = GUI.PlayerGui():FindFirstChild(i5)
    if v4 and v4:IsA("ScreenGui") then
        v4.Enabled = false
    end
end
v3.ResetOnSpawn = false
ScrollingFrame.CanvasPosition = Vector2.zero
local v9 = ShopPreview.IsHalloween()
local v10 = nil
local v11 = nil
for i6, i7 in u117, v10, v11 do
    v2 = if not v9 then i7 else i7 + 9000
    i6.LayoutOrder = v2
end
updateSection()
return (table.freeze(v8))