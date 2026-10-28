-- Script path: ReplicatedStorage.Controllers.GUI.Shop.LimitedEggController
-- Decompile time: 39.71 ms

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Gifting = require(ReplicatedStorage.Client.Gifting)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local ShopPreview = require(ReplicatedStorage.Client.ShopPreview)
require(ReplicatedStorage.Data.LimitedEgg.Types.Interface)
local Log = require(ReplicatedStorage.Packages.Log)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
return {
    Start = function() -- Line: 84
        -- upvalues: Log (val), TryLock (val), Players (val), GUI (val), LimitedEgg (val), ShopPreview (val)
        -- upvalues: TweenService (val), Timer (val), SwapGradient (val), Assets (val), HoverCard (val), TryCall (val)
        -- upvalues: PolicyService (val), t (val), Gifting (val), ButtonFX (val), Storefront (val), Price (val)
        -- upvalues: Trove (val), Products (val), Tabs (val)
        local openSession
        local u2 = Log.new()
        local u4 = TryLock()
        local u5 = nil
        local LocalPlayer = Players.LocalPlayer
        local ScrollingFrame = GUI.Shop().Frame.ScrollingFrame
        local u13 = true

        local function requireChild(a1, a2, a3, a4) -- Line: 100
            -- upvalues: 
            local v1 = a1:FindFirstChild(a2)
            local v2 = ("Shop is missing %*"):format(a4)
            assert(v1 ~= nil, v2)
            assert(v1:IsA(a3), (("Shop %* must be a %*"):format(a4, a3)))
            return v1
        end

        local function bindSlot(a1, a2, a3) -- Line: 112 -- types: a1: string, a2: userdata, a3: number
            local v1 = ("%*.Spacer.Frame.%*"):format(a1, a3)
            local v2 = a2:FindFirstChild((tostring(a3)))
            local v3 = ("Shop is missing %*"):format(v1)
            assert(v2 ~= nil, v3)
            assert(v2:IsA("GuiObject"), (("Shop %* must be a GuiObject"):format(v1)))
            local Glow = v2:FindFirstChild("Glow")
            local v4 = {Frame = v2}
            v3 = ("%*.Icon"):format(v1)
            local v5 = v2:FindFirstChild("Icon")
            local v6 = ("Shop is missing %*"):format(v3)
            assert(v5 ~= nil, v6)
            assert(v5:IsA("ImageLabel"), (("Shop %* must be a ImageLabel"):format(v3)))
            v4.Icon = v5
            v3 = ("%*.Amount"):format(v1)
            v5 = v2:FindFirstChild("Amount")
            v6 = ("Shop is missing %*"):format(v3)
            assert(v5 ~= nil, v6)
            assert(v5:IsA("TextLabel"), (("Shop %* must be a TextLabel"):format(v3)))
            v4.Amount = v5
            v4.Glow = if Glow == nil then nil else if not Glow:IsA("ImageLabel") then nil else Glow
            return v4
        end

        local function bindOfferUi(a1, a2, a3) -- Line: 125 -- types: a1: string, a2: userdata, a3: number
            local v1 = ("Buy%*"):format(a3)
            local v2 = ("%*.Spacer.Btns.%*"):format(a1, v1)
            local v3 = a2:FindFirstChild(v1)
            local v4 = ("Shop is missing %*"):format(v2)
            assert(v3 ~= nil, v4)
            assert(v3:IsA("GuiButton"), (("Shop %* must be a GuiButton"):format(v2)))
            v1 = v3:FindFirstChild("Amount")
            local v5 = {Button = v3}
            v4 = ("Gift%*"):format(a3)
            local v6 = ("%*.Spacer.Btns.Gift%*"):format(a1, a3)
            local v7 = a2:FindFirstChild(v4)
            local v8 = ("Shop is missing %*"):format(v6)
            assert(v7 ~= nil, v8)
            assert(v7:IsA("GuiButton"), (("Shop %* must be a GuiButton"):format(v6)))
            v5.Gift = v7
            v4 = ("%*.Price"):format(v2)
            v7 = v3:FindFirstChild("Price")
            local v9 = ("Shop is missing %*"):format(v4)
            assert(v7 ~= nil, v9)
            assert(v7:IsA("TextLabel"), (("Shop %* must be a TextLabel"):format(v4)))
            v5.Price = v7
            v5.Amount = if v1 == nil then nil else if not v1:IsA("TextLabel") then nil else v1
            return v5
        end

        local function formatCountdown(a1) -- Line: 145 -- types: a1: number
            local v1 = math.max(0, (math.ceil(a1)))
            local v2 = v1 // 86400
            local v3 = v1 % 86400 // 3600
            local v4 = v1 % 3600 // 60
            local v5 = v1 % 60
            if v2 > 0 then
                return string.format("%dd %02dh %02dm %02ds", v2, v3, v4, v5)
            end
            if v3 > 0 then
                return string.format("%02dh %02dm %02ds", v3, v4, v5)
            end
            if v4 > 0 then
                return string.format("%02dm %02ds", v4, v5)
            end
            return string.format("%02ds", v5)
        end

        local function formatChance(a1) -- Line: 170 -- types: a1: number
            local v1 = 0
            if a1 > 0 and a1 < 10 then
                v1 = math.clamp(math.ceil(-(math.log10(a1))) + 1, 0, 4)
            end
            local v2 = string.format(("%%.%*f"):format(v1), a1)
            if v1 > 0 then
                v2 = v2:gsub("0+$", ""):gsub("%.$", "")
            end
            return (("%*%%"):format(v2))
        end

        local function formatEggAmount(a1) -- Line: 188 -- types: a1: number
            if a1 == 1 then
                return "1 Egg"
            end
            return (("%* Eggs"):format(a1))
        end

        local function mechaLabelFor(a1) -- Line: 197 -- types: a1: table
            local MechanicalVersion = a1.Frame:FindFirstChild("MechanicalVersion") or a1.Frame:FindFirstChild("Icon2")
            if MechanicalVersion ~= nil and MechanicalVersion:IsA("ImageLabel") then
                return MechanicalVersion
            end
            return nil
        end

        local function bindPanel(a1, a2) -- Line: 206
            -- upvalues: ScrollingFrame (val), bindSlot (val), bindOfferUi (val)
            local v1 = ScrollingFrame:FindFirstChild(a1)
            local v2 = ("Shop is missing %*"):format(a1)
            assert(v1 ~= nil, v2)
            assert(v1:IsA("GuiObject"), (("Shop %* must be a GuiObject"):format(a1)))
            local v3 = ("%*.Spacer"):format(a1)
            local v4 = v1:FindFirstChild("Spacer")
            local v5 = ("Shop is missing %*"):format(v3)
            assert(v4 ~= nil, v5)
            assert(v4:IsA("GuiObject"), (("Shop %* must be a GuiObject"):format(v3)))
            local v6 = ("%*.Spacer.bg"):format(a1)
            v3 = v4:FindFirstChild("bg")
            local v7 = ("Shop is missing %*"):format(v6)
            assert(v3 ~= nil, v7)
            assert(v3:IsA("ImageLabel"), (("Shop %* must be a ImageLabel"):format(v6)))
            v2 = ("%*.Spacer.Frame"):format(a1)
            v6 = v4:FindFirstChild("Frame")
            local v8 = ("Shop is missing %*"):format(v2)
            assert(v6 ~= nil, v8)
            assert(v6:IsA("GuiObject"), (("Shop %* must be a GuiObject"):format(v2)))
            v5 = ("%*.Spacer.Btns"):format(a1)
            v2 = v4:FindFirstChild("Btns")
            local v9 = ("Shop is missing %*"):format(v5)
            assert(v2 ~= nil, v9)
            assert(v2:IsA("GuiObject"), (("Shop %* must be a GuiObject"):format(v5)))
            v5 = {}
            v7 = #a2.Entries
            for i = 1, v7 do
                table.insert(v5, (bindSlot(a1, v6, i)))
            end
            v7 = nil
            v8 = nil
            v9 = #a2.Entries + 1
            local v10 = v6:FindFirstChild((tostring(v9)))
            local Icon2 = if v10 == nil then nil else v10:FindFirstChild("Icon2")
            if v10 ~= nil and v10:IsA("GuiObject") and Icon2 ~= nil and Icon2:IsA("ImageLabel") then
                v7 = bindSlot(a1, v6, v9)
                v8 = Icon2
            end
            v6 = {}
            v9 = #a2.Offers
            for j = 1, v9 do
                table.insert(v6, (bindOfferUi(a1, v2, j)))
            end
            v9 = {Frame = v1, Config = a2}
            local v11 = ("%*.Spacer.Title"):format(a1)
            v10 = v4:FindFirstChild("Title")
            local v12 = ("Shop is missing %*"):format(v11)
            assert(v10 ~= nil, v12)
            assert(v10:IsA("TextLabel"), (("Shop %* must be a TextLabel"):format(v11)))
            v9.EndingTimer = v10
            v11 = ("%*.Spacer.bg.Icon"):format(a1)
            v10 = v3:FindFirstChild("Icon")
            v12 = ("Shop is missing %*"):format(v11)
            assert(v10 ~= nil, v12)
            assert(v10:IsA("ImageLabel"), (("Shop %* must be a ImageLabel"):format(v11)))
            v9.RegularIcon = v10
            v11 = ("%*.Spacer.bg.MechanicalVersion"):format(a1)
            v10 = v3:FindFirstChild("MechanicalVersion")
            v12 = ("Shop is missing %*"):format(v11)
            assert(v10 ~= nil, v12)
            assert(v10:IsA("ImageLabel"), (("Shop %* must be a ImageLabel"):format(v11)))
            v9.MechanicalIcon = v10
            v11 = ("%*.Spacer.Infos"):format(a1)
            v10 = v4:FindFirstChild("Infos")
            v12 = ("Shop is missing %*"):format(v11)
            assert(v10 ~= nil, v12)
            assert(v10:IsA("GuiButton"), (("Shop %* must be a GuiButton"):format(v11)))
            v9.InfoButton = v10
            v9.Slots = v5
            v9.MechaRerollSlot = v7
            v9.MechaRerollIncoming = v8
            v9.OfferUis = v6
            return v9
        end

        local u22 = {}
        u22.Luminous = bindPanel("OldLimitedEgg", LimitedEgg.Luminous)
        u22.Extinction = bindPanel("LimitedEgg", LimitedEgg.Extinction)
        u22.Halloween = bindPanel("HalloweenLimitedEgg", LimitedEgg.Halloween)

        local function activePanel() -- Line: 273 -- upvalues: ShopPreview (upval), u22 (val)
            local v1 = ShopPreview.Config()
            for i, j in u22 do
                if j.Config == v1 then
                    return j
                end
            end
            return nil
        end

        local function applyVisibility() -- Line: 279 -- upvalues: ShopPreview (upval), u22 (val), u13 (ref)
            local Frame, v1
            local v2 = ShopPreview.Config()
            local v3 = u22
            local v4 = nil
            for i, j in v3, v4 do
                if j.Config == v2 then
                    v3 = nil
                    v4 = nil
                    for k, n in u22, v3, v4 do
                        Frame = n.Frame
                        v1 = false
                        if n == j then
                            v1 = not u13
                        end
                        Frame.Visible = v1
                    end
                    return
                end
            end
            v3 = nil
            v4 = nil
            for m, i5 in u22, v3, v4 do
                Frame = i5.Frame
                v1 = false
                if i5 == nil then
                    v1 = not u13
                end
                Frame.Visible = v1
            end
        end

        local function bindIconAlternator(a1, a2) -- Line: 290 -- upvalues: TweenService (upval) -- types: a2: table
            local MechanicalVersion, v1
            local u6 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

            local function fadeTo(a1_2, a2) -- Line: 296
                -- upvalues: a1 (val), TweenService (upval), u6 (val)
                return a1:Add((TweenService:Create(a1_2, u6, {ImageTransparency = a2})))
            end

            local u64 = {}

            local function addSwap(a1_2, a2) -- Line: 308
                -- upvalues: u64 (val), a1 (val), TweenService (upval), u6 (val)
                a1_2.ImageTransparency = 0
                a2.ImageTransparency = 1
                table.insert(u64, {
                    RegularIn = a1:Add((TweenService:Create(a1_2, u6, {ImageTransparency = 0}))),
                    RegularOut = a1:Add((TweenService:Create(a1_2, u6, {ImageTransparency = 1}))),
                    MechaIn = a1:Add((TweenService:Create(a2, u6, {ImageTransparency = 0}))),
                    MechaOut = a1:Add((TweenService:Create(a2, u6, {ImageTransparency = 1}))),
                })
            end

            for i, v in ipairs(a2.Slots) do
                MechanicalVersion = v.Frame:FindFirstChild("MechanicalVersion") or v.Frame:FindFirstChild("Icon2")
                v1 = if MechanicalVersion == nil then nil else if not MechanicalVersion:IsA("ImageLabel") then nil else MechanicalVersion
                if v1 ~= nil then
                    addSwap(v.Icon, v1)
                end
            end
            a1:Add((task.spawn(function() -- Line: 327 -- upvalues: u64 (val)
                while true do
                    task.wait(1)
                    for i, j in u64 do
                        j.RegularOut:Play()
                        j.MechaIn:Play()
                    end
                    task.wait(4)
                    for k, n in u64 do
                        n.MechaOut:Play()
                        n.RegularIn:Play()
                    end
                    task.wait(1)
                end
            end)))
        end

        local function bindEndingTimer(a1, a2, a3) -- Line: 344
            -- upvalues: ShopPreview (upval), formatCountdown (val), Timer (upval)
            local v1 = a3 - ShopPreview.Time()
            if not (v1 <= 0) then
                a2.EndingTimer.Text = formatCountdown(v1)
            else
                a2.EndingTimer.Text = "Leaving Soon"
            end
            a1:Add((Timer.Simple(1, function() -- Line: 345 -- upvalues: a3 (val), ShopPreview (upval), a2 (val), formatCountdown (upval)
                local v1 = a3 - ShopPreview.Time()
                if v1 <= 0 then
                    a2.EndingTimer.Text = "Leaving Soon"
                    return
                end
                a2.EndingTimer.Text = formatCountdown(v1)
            end)))
        end

        local function bindRarityGlow(a1, a2, a3) -- Line: 359
            -- upvalues: SwapGradient (upval)
            local UIGradient = a2:FindFirstChildWhichIsA("UIGradient")
            local u10 = if UIGradient == nil then nil else UIGradient:Clone()
            SwapGradient(a2, a3)
            a1:Add(function() -- Line: 367 -- upvalues: SwapGradient (upval), a2 (val), u10 (val)
                SwapGradient(a2, u10)
                if u10 ~= nil then
                    u10:Destroy()
                end
            end)
        end

        local function bindSlots(a1, a2) -- Line: 375
            -- upvalues: Assets (upval), formatChance (val), bindRarityGlow (val), u2 (val)
            local Glow, MechaReroll, MechanicalVersion, v1, v2, v3, v4, v5
            local Config = a2.Config
            local v6 = 0
            for i, v in ipairs(Config.Entries) do
                assert(0 < v.Weight, "Limited egg drop weights must be positive")
                v6 = v6 + v.Weight
            end
            local v7 = 1 - (if Config.MechaReroll == nil then 0 else Config.MechaReroll.DisplayChance)
            for i2, i3 in ipairs(Config.Entries) do
                local u46 = v2.Slots[i2]
                v3 = Assets.Directory[i3.AssetId]
                v5 = ("Limited egg drop entry \"%*\" is not in the asset directory"):format(i3.AssetId)
                assert(v3 ~= nil, v5)
                local Image = u46.Icon.Image
                u46.Icon.Image = v3.Icon or Image
                v1:Add(function() -- Line: 398 -- upvalues: u46 (val), Image (val)
                    u46.Icon.Image = Image
                end)
                MechaReroll = Config.MechaReroll and Config.MechaReroll.Entries
                v5 = MechaReroll and MechaReroll[i2]
                v4 = v5 and Assets.Directory[v5.AssetId]
                MechanicalVersion = u46.Frame:FindFirstChild("MechanicalVersion") or u46.Frame:FindFirstChild("Icon2")
                if MechanicalVersion == nil or not MechanicalVersion:IsA("ImageLabel") then
                    u110 = nil
                else
                    local u110 = MechanicalVersion
                end
                if u110 ~= nil and v4 ~= nil then
                    local Image_2 = u110.Image
                    u110.Image = v4.Icon or Image_2
                    v1:Add(function() -- Line: 410 -- upvalues: u110 (val), Image_2 (val)
                        u110.Image = Image_2
                    end)
                end
                u46.Amount.Text = formatChance(v7 * (i3.Weight / v6) * 100)
                Glow = u46.Glow
                if Glow ~= nil then
                    bindRarityGlow(v1, Glow, v3.Rarity.RarityGradient)
                end
            end
            u2:AtTrace():Log("Limited egg slot session opened")
        end

        local function bindMechaRerollSlot(a1, a2) -- Line: 427
            -- upvalues: Assets (upval), formatChance (val), TweenService (upval), u2 (val)
            local MechaRerollSlot = a2.MechaRerollSlot
            local MechaRerollIncoming = a2.MechaRerollIncoming
            local MechaReroll = a2.Config.MechaReroll
            if MechaRerollSlot ~= nil and MechaRerollIncoming ~= nil and MechaReroll ~= nil then
                local v1, v2
                local u121 = {}
                local v3 = a1
                for i, v in ipairs(MechaReroll.Entries) do
                    v1 = Assets.Directory[v.AssetId]
                    v2 = ("Limited egg mecha entry \"%*\" is not in the asset directory"):format(v.AssetId)
                    assert(v1 ~= nil, v2)
                    table.insert(u121, v1.Icon)
                end
                if #u121 == 0 then
                    return
                end
                local Icon = MechaRerollSlot.Icon
                local Text = MechaRerollSlot.Amount.Text
                local Image = Icon.Image
                local Image_2 = MechaRerollIncoming.Image
                v3:Add(function() -- Line: 452
                    -- upvalues: MechaRerollSlot (val), Text (val), Icon (val), Image (val), MechaRerollIncoming (val)
                    -- upvalues: Image_2 (val)
                    MechaRerollSlot.Amount.Text = Text
                    Icon.Image = Image
                    Icon.ImageTransparency = 0
                    MechaRerollIncoming.Image = Image_2
                    MechaRerollIncoming.ImageTransparency = 1
                end)
                MechaRerollSlot.Amount.Text = formatChance(MechaReroll.DisplayChance * 100)
                Icon.Image = u121[1]
                Icon.ImageTransparency = 0
                MechaRerollIncoming.ImageTransparency = 1
                local v4 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                local u48 = {}
                u48[Icon] = (v3:Add((TweenService:Create(Icon, v4, {ImageTransparency = 0}))))
                u48[MechaRerollIncoming] = (v3:Add((TweenService:Create(MechaRerollIncoming, v4, {ImageTransparency = 0}))))
                local u69 = {}
                u69[Icon] = (v3:Add((TweenService:Create(Icon, v4, {ImageTransparency = 1}))))
                u69[MechaRerollIncoming] = (v3:Add((TweenService:Create(MechaRerollIncoming, v4, {ImageTransparency = 1}))))
                v3:Add((task.spawn(function() -- Line: 490 -- upvalues: Icon (val), MechaRerollIncoming (val), u121 (val), u69 (val), u48 (val)
                    local v1
                    local v2 = MechaRerollIncoming
                    local v3 = 1
                    while true do
                        task.wait(1)
                        v3 = v3 % #u121 + 1
                        v2.Image = u121[v3]
                        u69[Icon]:Play()
                        v1 = u48[v2]
                        v1:Play()
                        v1.Completed:Wait()
                    end
                end)))
                u2:AtTrace():Log("Limited egg mecha re-roll slot session opened")
                return
            end
        end

        local function bindHoverInfo(a1, a2) -- Line: 508
            -- upvalues: Assets (upval), HoverCard (upval), u2 (val)
            local v1, v2
            local Config = a2.Config
            for i, v in ipairs(Config.Entries) do
                v1 = a2.Slots[i]
                v2 = Assets.Directory[v.AssetId]
                a1:Add((HoverCard.Attach(v1.Frame, {
                    {kind = "heading", text = v2.DisplayName},
                    {kind = "tier", rarity = v2.Rarity._id},
                })))
            end
            local MechaRerollSlot = a2.MechaRerollSlot
            if MechaRerollSlot ~= nil then
                a1:Add((HoverCard.Attach(MechaRerollSlot.Frame, {{kind = "heading", text = Config.RerollName}})))
            end
            local InfoButton = a2.InfoButton
            local InfoText = Config.InfoText
            if InfoText ~= nil then
                a1:Add((HoverCard.Attach(InfoButton, {{kind = "body", text = InfoText}})))
                a1:Add((InfoButton.Activated:Connect(function() -- Line: 530 -- upvalues: HoverCard (upval), InfoButton (val), InfoText (val)
                    HoverCard.Show(InfoButton, {{kind = "body", text = InfoText}})
                end)))
            end
            a1:Add(function() -- Line: 534 -- upvalues: HoverCard (upval)
                HoverCard.Dismiss()
            end)
            u2:AtTrace():Log("Limited egg hover info session opened")
        end

        local function closeSession() -- Line: 558 -- upvalues: u5 (ref), u2 (val)
            local v1 = u5
            if v1 == nil then
                return
            end
            u5 = nil
            v1:Destroy()
            u2:AtTrace():Log("Limited egg shop session closed")
        end

        local function bindOffer(a1, a2) -- Line: 569
            -- upvalues: ShopPreview (upval), Gifting (upval), ButtonFX (upval), u4 (val), Storefront (upval)
            -- upvalues: Price (upval), u5 (ref)
            local v1 = ShopPreview.IsActive()
            if not v1 and a2.GiftProductId ~= 0 then
                a1:Add((Gifting.Bind(a2.Ui.Gift, "Product", a2.GiftProductId or a2.ProductId)))
            end
            a2.Ui.Gift.Active = not v1 and a2.GiftProductId ~= 0
            a2.Ui.Button.Active = not v1
            local Amount = a2.Ui.Amount
            if Amount ~= nil then
                local Amount_2 = a2.Amount
                Amount.Text = if Amount_2 ~= 1 then ("%* Eggs"):format(Amount_2) else "1 Egg"
            end
            a1:Add((ButtonFX(a2.Ui.Button, nil, function() -- Line: 579 -- upvalues: ShopPreview (upval), u4 (upval), Storefront (upval), a2 (val)
                if ShopPreview.IsActive() then
                    return
                end
                u4(function() -- Line: 581 -- upvalues: Storefront (upval), a2 (upval)
                    Storefront.Prompt(a2.ProductId, true)
                end)
            end)))
            a1:Add((task.spawn(function() -- Line: 586 -- upvalues: Price (upval), a2 (val), u5 (upval), a1 (val)
                local v1 = Price(a2.ProductId, Enum.InfoType.Product)
                if u5 ~= a1 then
                    return
                end
                if v1 ~= nil then
                    a2.Ui.Price.Text = "" .. tostring(v1)
                    return
                end
                a2.Ui.Price.Text = "Loading..."
            end)))
        end

        function openSession() -- Line: 600
            -- upvalues: u5 (ref), u2 (val), Trove (upval), ShopPreview (upval), u22 (val), u13 (ref), Timer (upval)
            -- upvalues: openSession (val), TryCall (upval), formatCountdown (val), bindSlots (val)
            -- upvalues: bindMechaRerollSlot (val), bindHoverInfo (val), bindIconAlternator (val), Products (upval)
            -- upvalues: t (upval), bindOffer (val)
            local Frame, u29, v1
            local v2 = u5
            if v2 ~= nil then
                u5 = nil
                v2:Destroy()
                u2:AtTrace():Log("Limited egg shop session closed")
            end
            local u110 = Trove.new()
            u5 = u110
            local v3 = ShopPreview.Config()
            local v4 = u22
            local v5 = nil
            local v6 = nil
            for i, j in v4, v5, v6 do
                if j.Config == v3 then
                    u29 = j
                    v4 = ShopPreview.Config()
                    v5 = u22
                    v6 = nil
                    for k, n in v5, v6 do
                        if n.Config == v4 then
                            v5 = nil
                            v6 = nil
                            for m, i5 in u22, v5, v6 do
                                Frame = i5.Frame
                                v1 = false
                                if i5 == n then
                                    v1 = not u13
                                end
                                Frame.Visible = v1
                            end
                            if u29 == nil then
                                u110:Add((Timer.Simple(1, function() -- Line: 608 -- upvalues: ShopPreview (upval), u22 (upval), openSession (upval)
                                    local v1 = ShopPreview.Config()
                                    for i, j in u22 do
                                        if j.Config == v1 then
                                            if j ~= nil then
                                                task.defer(openSession)
                                            end
                                            return
                                        end
                                    end
                                    if false then
                                        task.defer(openSession)
                                    end
                                end)))
                                return
                            end
                            v3, v4 = TryCall(function() -- Line: 611
                                -- upvalues: u29 (val), u110 (val), ShopPreview (upval), formatCountdown (upval)
                                -- upvalues: Timer (upval), bindSlots (upval), bindMechaRerollSlot (upval)
                                -- upvalues: bindHoverInfo (upval), bindIconAlternator (upval), u22 (upval)
                                -- upvalues: openSession (upval), Products (upval), t (upval), bindOffer (upval)
                                local v1, v2, v3
                                local EndsAt = u29.Config.EndsAt
                                u29.EndingTimer.Visible = EndsAt ~= nil
                                if EndsAt ~= nil then
                                    local u11 = u29
                                    local v4 = EndsAt - ShopPreview.Time()
                                    if not (v4 <= 0) then
                                        u11.EndingTimer.Text = formatCountdown(v4)
                                    else
                                        u11.EndingTimer.Text = "Leaving Soon"
                                    end
                                    u110:Add((Timer.Simple(1, function() -- Line: 345 -- upvalues: EndsAt (val), ShopPreview (upval), u11 (val), formatCountdown (upval)
                                        local v1 = EndsAt - ShopPreview.Time()
                                        if v1 <= 0 then
                                            u11.EndingTimer.Text = "Leaving Soon"
                                            return
                                        end
                                        u11.EndingTimer.Text = formatCountdown(v1)
                                    end)))
                                end
                                bindSlots(u110, u29)
                                bindMechaRerollSlot(u110, u29)
                                bindHoverInfo(u110, u29)
                                bindIconAlternator(u110, u29)
                                u110:Add((Timer.Simple(1, function() -- Line: 624 -- upvalues: ShopPreview (upval), u22 (upval), u29 (upval), openSession (upval)
                                    local v1 = ShopPreview.Config()
                                    for i, j in u22 do
                                        if j.Config == v1 then
                                            if j ~= u29 then
                                                task.defer(openSession)
                                            end
                                            return
                                        end
                                    end
                                    if u29 ~= nil then
                                        task.defer(openSession)
                                    end
                                end)))
                                for i, v in ipairs(u29.Config.Offers) do
                                    v1 = Products.Directory[v.ProductName]
                                    v2 = if not v.GiftProductName then v1 else Products.Directory[v.GiftProductName]
                                    if v1 ~= nil then
                                        u29.OfferUis[i].Button.Active = true
                                        u29.OfferUis[i].Gift.Active = true
                                        t.strict(t.number)(v1.ProductId)
                                        bindOffer(u110, {
                                            Ui = u29.OfferUis[i],
                                            Amount = v.Amount,
                                            ProductId = v1.ProductId,
                                            GiftProductId = if not v2 then 0 else v2.ProductId,
                                        })
                                    else
                                        v3 = u29.OfferUis[i]
                                        v3.Price.Text = "Unavailable"
                                        v3.Button.Active = false
                                        v3.Gift.Active = false
                                    end
                                end
                            end)
                            if not v3 then
                                v5 = u5
                                if v5 ~= nil then
                                    u5 = nil
                                    v5:Destroy()
                                    u2:AtTrace():Log("Limited egg shop session closed")
                                end
                                error(v4)
                            end
                            u2:AtTrace():Log("Limited egg shop session opened")
                            return
                        end
                    end
                    v5 = nil
                    v6 = nil
                    for i6, i7 in u22, v5, v6 do
                        Frame = i7.Frame
                        v1 = false
                        if i7 == nil then
                            v1 = not u13
                        end
                        Frame.Visible = v1
                    end
                    if u29 == nil then
                        u110:Add((Timer.Simple(1, function() -- Line: 608 -- upvalues: ShopPreview (upval), u22 (upval), openSession (upval)
                            local v1 = ShopPreview.Config()
                            for i, j in u22 do
                                if j.Config == v1 then
                                    if j ~= nil then
                                        task.defer(openSession)
                                    end
                                    return
                                end
                            end
                            if false then
                                task.defer(openSession)
                            end
                        end)))
                        return
                    end
                    v3, v4 = TryCall(function() -- Line: 611
                        -- upvalues: u29 (val), u110 (val), ShopPreview (upval), formatCountdown (upval), Timer (upval)
                        -- upvalues: bindSlots (upval), bindMechaRerollSlot (upval), bindHoverInfo (upval)
                        -- upvalues: bindIconAlternator (upval), u22 (upval), openSession (upval), Products (upval)
                        -- upvalues: t (upval), bindOffer (upval)
                        local v1, v2, v3
                        local EndsAt = u29.Config.EndsAt
                        u29.EndingTimer.Visible = EndsAt ~= nil
                        if EndsAt ~= nil then
                            local u11 = u29
                            local v4 = EndsAt - ShopPreview.Time()
                            if not (v4 <= 0) then
                                u11.EndingTimer.Text = formatCountdown(v4)
                            else
                                u11.EndingTimer.Text = "Leaving Soon"
                            end
                            u110:Add((Timer.Simple(1, function() -- Line: 345 -- upvalues: EndsAt (val), ShopPreview (upval), u11 (val), formatCountdown (upval)
                                local v1 = EndsAt - ShopPreview.Time()
                                if v1 <= 0 then
                                    u11.EndingTimer.Text = "Leaving Soon"
                                    return
                                end
                                u11.EndingTimer.Text = formatCountdown(v1)
                            end)))
                        end
                        bindSlots(u110, u29)
                        bindMechaRerollSlot(u110, u29)
                        bindHoverInfo(u110, u29)
                        bindIconAlternator(u110, u29)
                        u110:Add((Timer.Simple(1, function() -- Line: 624 -- upvalues: ShopPreview (upval), u22 (upval), u29 (upval), openSession (upval)
                            local v1 = ShopPreview.Config()
                            for i, j in u22 do
                                if j.Config == v1 then
                                    if j ~= u29 then
                                        task.defer(openSession)
                                    end
                                    return
                                end
                            end
                            if u29 ~= nil then
                                task.defer(openSession)
                            end
                        end)))
                        for i, v in ipairs(u29.Config.Offers) do
                            v1 = Products.Directory[v.ProductName]
                            v2 = if not v.GiftProductName then v1 else Products.Directory[v.GiftProductName]
                            if v1 ~= nil then
                                u29.OfferUis[i].Button.Active = true
                                u29.OfferUis[i].Gift.Active = true
                                t.strict(t.number)(v1.ProductId)
                                bindOffer(u110, {
                                    Ui = u29.OfferUis[i],
                                    Amount = v.Amount,
                                    ProductId = v1.ProductId,
                                    GiftProductId = if not v2 then 0 else v2.ProductId,
                                })
                            else
                                v3 = u29.OfferUis[i]
                                v3.Price.Text = "Unavailable"
                                v3.Button.Active = false
                                v3.Gift.Active = false
                            end
                        end
                    end)
                    if not v3 then
                        v5 = u5
                        if v5 ~= nil then
                            u5 = nil
                            v5:Destroy()
                            u2:AtTrace():Log("Limited egg shop session closed")
                        end
                        error(v4)
                    end
                    u2:AtTrace():Log("Limited egg shop session opened")
                    return
                end
            end
            u29 = nil
            v4 = ShopPreview.Config()
            v5 = u22
            v6 = nil
            for i8, i9 in v5, v6 do
                if i9.Config == v4 then
                    v5 = nil
                    v6 = nil
                    for i10, i11 in u22, v5, v6 do
                        Frame = i11.Frame
                        v1 = false
                        if i11 == i9 then
                            v1 = not u13
                        end
                        Frame.Visible = v1
                    end
                    if u29 == nil then
                        u110:Add((Timer.Simple(1, function() -- Line: 608 -- upvalues: ShopPreview (upval), u22 (upval), openSession (upval)
                            local v1 = ShopPreview.Config()
                            for i, j in u22 do
                                if j.Config == v1 then
                                    if j ~= nil then
                                        task.defer(openSession)
                                    end
                                    return
                                end
                            end
                            if false then
                                task.defer(openSession)
                            end
                        end)))
                        return
                    end
                    v3, v4 = TryCall(function() -- Line: 611
                        -- upvalues: u29 (val), u110 (val), ShopPreview (upval), formatCountdown (upval), Timer (upval)
                        -- upvalues: bindSlots (upval), bindMechaRerollSlot (upval), bindHoverInfo (upval)
                        -- upvalues: bindIconAlternator (upval), u22 (upval), openSession (upval), Products (upval)
                        -- upvalues: t (upval), bindOffer (upval)
                        local v1, v2, v3
                        local EndsAt = u29.Config.EndsAt
                        u29.EndingTimer.Visible = EndsAt ~= nil
                        if EndsAt ~= nil then
                            local u11 = u29
                            local v4 = EndsAt - ShopPreview.Time()
                            if not (v4 <= 0) then
                                u11.EndingTimer.Text = formatCountdown(v4)
                            else
                                u11.EndingTimer.Text = "Leaving Soon"
                            end
                            u110:Add((Timer.Simple(1, function() -- Line: 345 -- upvalues: EndsAt (val), ShopPreview (upval), u11 (val), formatCountdown (upval)
                                local v1 = EndsAt - ShopPreview.Time()
                                if v1 <= 0 then
                                    u11.EndingTimer.Text = "Leaving Soon"
                                    return
                                end
                                u11.EndingTimer.Text = formatCountdown(v1)
                            end)))
                        end
                        bindSlots(u110, u29)
                        bindMechaRerollSlot(u110, u29)
                        bindHoverInfo(u110, u29)
                        bindIconAlternator(u110, u29)
                        u110:Add((Timer.Simple(1, function() -- Line: 624 -- upvalues: ShopPreview (upval), u22 (upval), u29 (upval), openSession (upval)
                            local v1 = ShopPreview.Config()
                            for i, j in u22 do
                                if j.Config == v1 then
                                    if j ~= u29 then
                                        task.defer(openSession)
                                    end
                                    return
                                end
                            end
                            if u29 ~= nil then
                                task.defer(openSession)
                            end
                        end)))
                        for i, v in ipairs(u29.Config.Offers) do
                            v1 = Products.Directory[v.ProductName]
                            v2 = if not v.GiftProductName then v1 else Products.Directory[v.GiftProductName]
                            if v1 ~= nil then
                                u29.OfferUis[i].Button.Active = true
                                u29.OfferUis[i].Gift.Active = true
                                t.strict(t.number)(v1.ProductId)
                                bindOffer(u110, {
                                    Ui = u29.OfferUis[i],
                                    Amount = v.Amount,
                                    ProductId = v1.ProductId,
                                    GiftProductId = if not v2 then 0 else v2.ProductId,
                                })
                            else
                                v3 = u29.OfferUis[i]
                                v3.Price.Text = "Unavailable"
                                v3.Button.Active = false
                                v3.Gift.Active = false
                            end
                        end
                    end)
                    if not v3 then
                        v5 = u5
                        if v5 ~= nil then
                            u5 = nil
                            v5:Destroy()
                            u2:AtTrace():Log("Limited egg shop session closed")
                        end
                        error(v4)
                    end
                    u2:AtTrace():Log("Limited egg shop session opened")
                    return
                end
            end
            v5 = nil
            v6 = nil
            for i12, i13 in u22, v5, v6 do
                Frame = i13.Frame
                v1 = false
                if i13 == nil then
                    v1 = not u13
                end
                Frame.Visible = v1
            end
            if u29 == nil then
                u110:Add((Timer.Simple(1, function() -- Line: 608 -- upvalues: ShopPreview (upval), u22 (upval), openSession (upval)
                    local v1 = ShopPreview.Config()
                    for i, j in u22 do
                        if j.Config == v1 then
                            if j ~= nil then
                                task.defer(openSession)
                            end
                            return
                        end
                    end
                    if false then
                        task.defer(openSession)
                    end
                end)))
                return
            end
            v3, v4 = TryCall(function() -- Line: 611
                -- upvalues: u29 (val), u110 (val), ShopPreview (upval), formatCountdown (upval), Timer (upval)
                -- upvalues: bindSlots (upval), bindMechaRerollSlot (upval), bindHoverInfo (upval)
                -- upvalues: bindIconAlternator (upval), u22 (upval), openSession (upval), Products (upval), t (upval)
                -- upvalues: bindOffer (upval)
                local v1, v2, v3
                local EndsAt = u29.Config.EndsAt
                u29.EndingTimer.Visible = EndsAt ~= nil
                if EndsAt ~= nil then
                    local u11 = u29
                    local v4 = EndsAt - ShopPreview.Time()
                    if not (v4 <= 0) then
                        u11.EndingTimer.Text = formatCountdown(v4)
                    else
                        u11.EndingTimer.Text = "Leaving Soon"
                    end
                    u110:Add((Timer.Simple(1, function() -- Line: 345 -- upvalues: EndsAt (val), ShopPreview (upval), u11 (val), formatCountdown (upval)
                        local v1 = EndsAt - ShopPreview.Time()
                        if v1 <= 0 then
                            u11.EndingTimer.Text = "Leaving Soon"
                            return
                        end
                        u11.EndingTimer.Text = formatCountdown(v1)
                    end)))
                end
                bindSlots(u110, u29)
                bindMechaRerollSlot(u110, u29)
                bindHoverInfo(u110, u29)
                bindIconAlternator(u110, u29)
                u110:Add((Timer.Simple(1, function() -- Line: 624 -- upvalues: ShopPreview (upval), u22 (upval), u29 (upval), openSession (upval)
                    local v1 = ShopPreview.Config()
                    for i, j in u22 do
                        if j.Config == v1 then
                            if j ~= u29 then
                                task.defer(openSession)
                            end
                            return
                        end
                    end
                    if u29 ~= nil then
                        task.defer(openSession)
                    end
                end)))
                for i, v in ipairs(u29.Config.Offers) do
                    v1 = Products.Directory[v.ProductName]
                    v2 = if not v.GiftProductName then v1 else Products.Directory[v.GiftProductName]
                    if v1 ~= nil then
                        u29.OfferUis[i].Button.Active = true
                        u29.OfferUis[i].Gift.Active = true
                        t.strict(t.number)(v1.ProductId)
                        bindOffer(u110, {
                            Ui = u29.OfferUis[i],
                            Amount = v.Amount,
                            ProductId = v1.ProductId,
                            GiftProductId = if not v2 then 0 else v2.ProductId,
                        })
                    else
                        v3 = u29.OfferUis[i]
                        v3.Price.Text = "Unavailable"
                        v3.Button.Active = false
                        v3.Gift.Active = false
                    end
                end
            end)
            if not v3 then
                v5 = u5
                if v5 ~= nil then
                    u5 = nil
                    v5:Destroy()
                    u2:AtTrace():Log("Limited egg shop session closed")
                end
                error(v4)
            end
            u2:AtTrace():Log("Limited egg shop session opened")
        end

        ShopPreview.Changed:Connect(function() -- Line: 660 -- upvalues: Tabs (upval), openSession (val), ShopPreview (upval), u22 (val), u13 (ref)
            local Frame, v1
            if Tabs.IsActive("Shop") then
                openSession()
                return
            end
            local v2 = ShopPreview.Config()
            local v3 = u22
            local v4 = nil
            for i, j in v3, v4 do
                if j.Config == v2 then
                    v3 = nil
                    v4 = nil
                    for k, n in u22, v3, v4 do
                        Frame = n.Frame
                        v1 = false
                        if n == j then
                            v1 = not u13
                        end
                        Frame.Visible = v1
                    end
                    return
                end
            end
            v3 = nil
            v4 = nil
            for m, i5 in u22, v3, v4 do
                Frame = i5.Frame
                v1 = false
                if i5 == nil then
                    v1 = not u13
                end
                Frame.Visible = v1
            end
        end)
        task.spawn(function() -- Line: 541
            -- upvalues: ShopPreview (upval), u22 (val), u13 (ref), TryCall (upval), PolicyService (upval)
            -- upvalues: LocalPlayer (val), t (upval)
            local Frame, u30, v1, v2
            local v3 = ShopPreview.Config()
            local v4 = u22
            local v5 = nil
            for i, j in v4, v5 do
                if j.Config == v3 then
                    v4 = nil
                    v5 = nil
                    for k, n in u22, v4, v5 do
                        Frame = n.Frame
                        v2 = false
                        if n == j then
                            v2 = not u13
                        end
                        Frame.Visible = v2
                    end
                    v1, u30 = TryCall(function() -- Line: 544 -- upvalues: PolicyService (upval), LocalPlayer (upval)
                        return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer).ArePaidRandomItemsRestricted
                    end)
                    if v1 then
                        TryCall(function() -- Line: 550 -- upvalues: t (upval), u30 (val), u13 (upval), ShopPreview (upval), u22 (upval)
                            local Frame, v1
                            t.strict(t.boolean)(u30)
                            u13 = u30
                            local v2 = ShopPreview.Config()
                            local v3 = u22
                            local v4 = nil
                            for i, j in v3, v4 do
                                if j.Config == v2 then
                                    v3 = nil
                                    v4 = nil
                                    for k, n in u22, v3, v4 do
                                        Frame = n.Frame
                                        v1 = false
                                        if n == j then
                                            v1 = not u13
                                        end
                                        Frame.Visible = v1
                                    end
                                    return
                                end
                            end
                            v3 = nil
                            v4 = nil
                            for m, i5 in u22, v3, v4 do
                                Frame = i5.Frame
                                v1 = false
                                if i5 == nil then
                                    v1 = not u13
                                end
                                Frame.Visible = v1
                            end
                        end)
                    end
                    return
                end
            end
            v4 = nil
            v5 = nil
            for m, i5 in u22, v4, v5 do
                Frame = i5.Frame
                v2 = false
                if i5 == nil then
                    v2 = not u13
                end
                Frame.Visible = v2
            end
            v1, u30 = TryCall(function() -- Line: 544 -- upvalues: PolicyService (upval), LocalPlayer (upval)
                return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer).ArePaidRandomItemsRestricted
            end)
            if v1 then
                TryCall(function() -- Line: 550 -- upvalues: t (upval), u30 (val), u13 (upval), ShopPreview (upval), u22 (upval)
                    local Frame, v1
                    t.strict(t.boolean)(u30)
                    u13 = u30
                    local v2 = ShopPreview.Config()
                    local v3 = u22
                    local v4 = nil
                    for i, j in v3, v4 do
                        if j.Config == v2 then
                            v3 = nil
                            v4 = nil
                            for k, n in u22, v3, v4 do
                                Frame = n.Frame
                                v1 = false
                                if n == j then
                                    v1 = not u13
                                end
                                Frame.Visible = v1
                            end
                            return
                        end
                    end
                    v3 = nil
                    v4 = nil
                    for m, i5 in u22, v3, v4 do
                        Frame = i5.Frame
                        v1 = false
                        if i5 == nil then
                            v1 = not u13
                        end
                        Frame.Visible = v1
                    end
                end)
            end
        end)
        Tabs.Activated:Connect(function(a1) -- Line: 670 -- upvalues: openSession (val) -- types: a1: string
            if a1 == "Shop" then
                openSession()
            end
        end)
        Tabs.Deactivated:Connect(function(a1) -- Line: 676 -- upvalues: u5 (ref), u2 (val), Tabs (upval), ShopPreview (upval) -- types: a1: string?
            if a1 == "Shop" then
                local v1 = u5
                if v1 ~= nil then
                    u5 = nil
                    v1:Destroy()
                    u2:AtTrace():Log("Limited egg shop session closed")
                end
                task.defer(function() -- Line: 679 -- upvalues: Tabs (upval), ShopPreview (upval)
                    if not Tabs.IsActive("Shop") and ShopPreview.IsActive() then
                        ShopPreview.Set("off")
                    end
                end)
            end
        end)
        if Tabs.Active() == "Shop" then
            openSession()
        end
    end,
}