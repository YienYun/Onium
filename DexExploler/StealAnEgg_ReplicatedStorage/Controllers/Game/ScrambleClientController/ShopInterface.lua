-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.ShopInterface
-- Decompile time: 15.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Trove = require(ReplicatedStorage.Packages.Trove)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local v1 = {}

local function toast(a1) -- Line: 14 -- upvalues: Toast (val) -- types: a1: string
    Toast.Show({Seconds = 3, SingleLine = true, Unique = true, Text = a1})
end

function v1.new(a1) -- Line: 17
    -- upvalues: Trove (val), GUI (val), Toast (val), AddCommas (val), ButtonFX (val), Tabs (val)
    local u1 = {}
    local u5 = Trove.new()
    local u8 = Trove.new()
    u5:Add(u8)
    local DrScrambleEvent = GUI.Get("DrScrambleEvent")
    local DRScrambleEventUIMain = DrScrambleEvent.DRScrambleEventUIMain
    local ScrollingFrame = DRScrambleEventUIMain.ContentFrame.ScrollingFrame
    local u24 = ScrollingFrame:WaitForChild("ShopItem")
    local ShopItem_Rare = ScrollingFrame:WaitForChild("ShopItem_Rare")
    local ShopItemLeavesTimer = ScrollingFrame:WaitForChild("ShopItemLeavesTimer")
    local CurrencyHolder = DRScrambleEventUIMain.CurrencyHolder
    local BuyMore = CurrencyHolder:FindFirstChild("BuyMore")
    if BuyMore then
        BuyMore:Destroy()
    end
    local u41 = {}
    local u42 = nil
    local u43 = ""
    local u44 = true
    local u45 = false
    local u46 = false
    local u47 = nil
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("GuiObject") then
            j.Visible = false
        end
    end
    DrScrambleEvent:SetAttribute("ImmediateClose", true)
    DrScrambleEvent.Enabled = false

    local function available() -- Line: 42 -- upvalues: u42 (ref)
        local v1 = false
        if u42 ~= nil then
            v1 = false
            if u42.Ready == true then
                v1 = false
                if u42.Enabled == true then
                    v1 = false
                    if u42.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                    end
                end
            end
        end
        return v1
    end

    local function purchased(a1) -- Line: 49 -- upvalues: u42 (ref)
        if u42 then
            local ServerTimeNow = workspace:GetServerTimeNow()
            if not ((u42.ShopRestockAt or 0) <= ServerTimeNow) then
                local State = u42.State
                if State then
                    local ShopPurchases = u42.State.ShopPurchases or {}
                    State = ShopPurchases[a1.Id]
                end
                if State and State.Period == u42.ShopPeriod then
                    return State.Count
                end
                return 0
            end
        end
        return 0
    end

    local function send(a1_2, a2, a3) -- Line: 54
        -- upvalues: u45 (ref), u42 (ref), u47 (ref), a1 (val), u44 (ref), Toast (upval)
        if not u45 then
            local v1 = false
            if u42 ~= nil then
                v1 = false
                if u42.Ready == true then
                    v1 = false
                    if u42.Enabled == true then
                        v1 = false
                        if u42.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                        end
                    end
                end
            end
            if v1 then
                u45 = true
                u47()
                local success, err = pcall(a1, a1_2, a2, a3)
                u45 = false
                if not u44 then
                    return
                end
                u47()
                if success and err then
                    if not err.Ok then
                        if err.Reason == "Busy" or err.Reason == "ProfileUnavailable" then
                            Toast.Show({
                                Text = "Please wait a moment and try again.",
                                Seconds = 3,
                                SingleLine = true,
                                Unique = true,
                            })
                        end
                    end
                    return
                end
                Toast.Show({
                    Text = "Could not confirm the request. Reopen the shop to refresh.",
                    Seconds = 3,
                    SingleLine = true,
                    Unique = true,
                })
                return
            end
        end
    end

    local function clearCards() -- Line: 72 -- upvalues: u8 (val), u41 (val)
        u8:Clean()
        table.clear(u41)
    end

    local function u80() -- Line: 76
        -- upvalues: u42 (ref), u43 (ref), u8 (val), u41 (val), ShopItem_Rare (val), ShopItemLeavesTimer (val)
        -- upvalues: u24 (val), AddCommas (upval), CurrencyHolder (val), ScrollingFrame (val), ButtonFX (upval)
        -- upvalues: u45 (ref), purchased (val), Toast (upval), send (val)
        local Card, QuantityLabel, QuantityText, v1
        local Shop = u42.Shop or {}
        local v2 = {"Shop"}
        for i, j in Shop do
            table.insert(v2, j.Quote .. ":" .. (tostring(j.LeavesAtEventEnd)))
        end
        local v3 = table.concat(v2, "\n")
        if v3 == u43 then
            return
        end
        u43 = v3
        u8:Clean()
        table.clear(u41)
        local v4 = nil
        local v5 = nil
        for k, n in Shop, v4, v5 do
            v2 = (if not n.Rare then if not n.LeavesAtEventEnd then u24 else ShopItemLeavesTimer else ShopItem_Rare):Clone()
            v2.Name = "Offer_" .. n.Id
            v2.LayoutOrder = k
            Card = v2.Card
            local ImageButton = Instance.new("ImageButton")
            for m, i5 in {
                "Name",
                "AnchorPoint",
                "Position",
                "Size",
                "Rotation",
                "BackgroundColor3",
                "BackgroundTransparency",
                "BorderColor3",
                "BorderSizePixel",
                "BorderMode",
                "ClipsDescendants",
                "LayoutOrder",
                "ZIndex",
                "Visible",
                "SizeConstraint",
                "AutomaticSize",
            } do
                ImageButton[i5] = Card[i5]
            end
            ImageButton.ImageTransparency = 1
            ImageButton.AutoButtonColor = false
            ImageButton.Selectable = false
            for i6, i7 in Card:GetChildren() do
                i7.Parent = ImageButton
            end
            Card:Destroy()
            ImageButton.Parent = v2
            ImageButton.EggName.Text = n.Label
            ImageButton.EggName.RichText = false
            v3 = ImageButton:FindFirstChild("ItemIcon") or ImageButton:FindFirstChild("OutputEgg")
            assert(v3 and v3:IsA("ImageLabel"), "Scramble shop card requires ItemIcon or OutputEgg")
            v3.Image = n.Icon
            QuantityLabel = ImageButton.Quantity.QuantityLabel
            QuantityText = n.QuantityText or "x" .. AddCommas(n.Quantity)
            QuantityLabel.Text = QuantityText
            ImageButton.Buy.PriceHolder.Icon.Visible = true
            ImageButton.Buy.PriceHolder.Icon:RemoveTag("ICON")
            ImageButton.Buy.PriceHolder.Icon:SetAttribute("IconId", nil)
            ImageButton.Buy.PriceHolder.Icon.Image = CurrencyHolder.CurrencyIcon.Image
            ImageButton.SoldOut.Visible = false
            ImageButton.Buy.Visible = true
            v1 = ScrollingFrame
            v2.Visible = true
            v2.Parent = v1
            u8:Add(v2)
            v3 = v2:FindFirstChild("LeaveTimer", true)
            if n.LeavesAtEventEnd then
                assert(v3 and v3:IsA("TextLabel"), "Limited Scramble shop card requires LeaveTimer")
            end
            v2 = {Offer = n, Card = ImageButton}
            v2.LeaveTimer = if not v3 then nil else if not v3:IsA("TextLabel") then nil else v3
            table.insert(u41, v2)
            u8:Add((ButtonFX(ImageButton, 1.04, nil, true)))
            u8:Add((ButtonFX(ImageButton.Buy, nil, function() -- Line: 132
                -- upvalues: ImageButton (val), u45 (upval), u42 (upval), n (val), purchased (upval), Toast (upval)
                -- upvalues: send (upval)
                if ImageButton.Buy.Interactable and not u45 then
                    local v1 = false
                    if u42 ~= nil then
                        v1 = false
                        if u42.Ready == true then
                            v1 = false
                            if u42.Enabled == true then
                                v1 = false
                                if u42.WorldReady == true then
                                    v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                                end
                            end
                        end
                    end
                    if v1 then
                        if n.PurchaseLimit and n.PurchaseLimit < (purchased(n)) + n.Quantity then
                            Toast.Show({
                                Text = "Sold out for today. Check the restock timer!",
                                Seconds = 3,
                                SingleLine = true,
                                Unique = true,
                            })
                            return
                        end
                        if u42.State and not (u42.State.Samples < n.Price) then
                            send("Shop", n.Id, {Quote = n.Quote, Sequence = u42.State.ShopSequence})
                            return
                        end
                        Toast.Show({
                            Text = "Not enough Samples. Defeat Dr. Scramble to earn more.",
                            Seconds = 3,
                            SingleLine = true,
                            Unique = true,
                        })
                        return
                    end
                end
            end)))
        end
    end

    function u47() -- Line: 159
        -- upvalues: u44 (ref), u42 (ref), CurrencyHolder (val), AddCommas (upval), u46 (ref), u80 (ref), u41 (val)
        -- upvalues: purchased (val), u45 (ref)
        if not u44 then
            return
        end
        if not u42 or not u42.State then
            CurrencyHolder.QuantityLabel.Text = "0"
        else
            CurrencyHolder.QuantityLabel.Text = AddCommas(u42.State.Samples)
        end
        local v1 = math.max(0, (math.floor((u42 and u42.EventEndsAt or 0) - (workspace:GetServerTimeNow())))) // 3600
        local v2 = string.format("LEAVES IN: %dD %dHR", v1 // 24, v1 % 24)
        if u46 and u42 then
            local Buy, Buy_2, Buy_3, Buy_4, Card, Offer, Price, StocksInLabel, v3, v4, v5, v6
            u80()
            local v7 = nil
            local v8 = nil
            for i, j in u41, v7, v8 do
                Offer = j.Offer
                Card = j.Card
                if j.LeaveTimer then
                    j.LeaveTimer.Text = v2
                end
                v1 = purchased(Offer)
                v6 = false
                if Offer.PurchaseLimit ~= nil then
                    v6 = Offer.PurchaseLimit < v1 + Offer.Quantity
                end
                Card.SoldOut.Visible = v6
                Card.Buy.Visible = not v6
                if Offer.PurchaseLimit then
                    Card.Quantity.QuantityLabel.Text = (tostring((math.max(0, Offer.PurchaseLimit - v1)))) .. "/" .. Offer.PurchaseLimit .. " LEFT"
                end
                StocksInLabel = Card:FindFirstChild("StocksInLabel")
                if StocksInLabel and StocksInLabel:IsA("TextLabel") then
                    v4 = false
                    if Offer.PurchaseLimit ~= nil then
                        v4 = v1 > 0
                    end
                    StocksInLabel.Visible = v4
                    if StocksInLabel.Visible then
                        v4 = math.max(1, (math.ceil(((u42.ShopRestockAt or 0) - (workspace:GetServerTimeNow())) / 60)))
                        StocksInLabel.Text = string.format("Stocks In:\n%dhr %dm", v4 // 60, v4 % 60)
                    end
                end
                v3 = false
                if u42 ~= nil then
                    v3 = false
                    if u42.Ready == true then
                        v3 = false
                        if u42.Enabled == true then
                            v3 = false
                            if u42.WorldReady == true then
                                v3 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                            end
                        end
                    end
                end
                if v3 then
                    v3 = not u45
                    if v3 then
                        v3 = false
                        if u42.State ~= nil then
                            v3 = not v6
                        end
                    end
                end
                v6 = v3 and Offer.Price <= u42.State.Samples
                Card.Buy.PriceHolder.Price.Text = AddCommas(Offer.Price)
                Card.Active = v3
                Card.Interactable = v3
                Buy = Card.Buy
                Buy_2 = Card.Buy
                Buy_3 = Card.Buy
                Buy.Active = v3
                Buy_2.Interactable = v3
                Buy_3.Selectable = v3
                Buy_4 = Card.Buy
                v5 = if not v6 then Color3.fromRGB(140, 140, 140) else Color3.new(1, 1, 1)
                Buy_4.ImageColor3 = v5
                Price = Card.Buy.PriceHolder.Price
                v5 = if not v6 then Color3.fromRGB(255, 64, 64) else Color3.new(1, 1, 1)
                Price.TextColor3 = v5
            end
            return
        end
    end

    u5:Add(((DrScrambleEvent:GetAttributeChangedSignal("Open")):Connect(function() -- Line: 207 -- upvalues: DrScrambleEvent (val), Tabs (upval)
        if DrScrambleEvent:GetAttribute("Open") == false and Tabs.IsActive("DrScrambleEvent") then
            Tabs.Deactivate()
        end
    end)))
    u5:Add((Tabs.Activated:Connect(function(a1) -- Line: 212 -- upvalues: DRScrambleEventUIMain (val), u47 (ref)
        if a1 == "DrScrambleEvent" then
            local CurrentCamera = workspace.CurrentCamera
            if CurrentCamera then
                local ViewportSize = CurrentCamera.ViewportSize
                local AspectRatio = DRScrambleEventUIMain.UIAspectRatioConstraint.AspectRatio
                local v1 = math.min(ViewportSize.X * 0.6, ViewportSize.Y * 0.74 * AspectRatio)
                DRScrambleEventUIMain.UISizeConstraint.MinSize = Vector2.zero
                DRScrambleEventUIMain.Size = UDim2.fromOffset(v1, v1 / AspectRatio)
            end
            u47()
        end
    end)))
    if ScrollingFrame:IsA("ScrollingFrame") then
        local UIGridLayout = ScrollingFrame.UIGridLayout
        u5:Add(((UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function() -- Line: 220 -- upvalues: ScrollingFrame (val), UIGridLayout (val)
            ScrollingFrame.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y)
        end)))
        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y)
    end
    if workspace.CurrentCamera then
        u5:Add(((workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 148 -- upvalues: DRScrambleEventUIMain (val)
            local CurrentCamera = workspace.CurrentCamera
            if not CurrentCamera then
                return
            end
            local ViewportSize = CurrentCamera.ViewportSize
            local AspectRatio = DRScrambleEventUIMain.UIAspectRatioConstraint.AspectRatio
            local v1 = math.min(ViewportSize.X * 0.6, ViewportSize.Y * 0.74 * AspectRatio)
            DRScrambleEventUIMain.UISizeConstraint.MinSize = Vector2.zero
            DRScrambleEventUIMain.Size = UDim2.fromOffset(v1, v1 / AspectRatio)
        end)))
    end
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera then
        local ViewportSize = CurrentCamera.ViewportSize
        local AspectRatio = DRScrambleEventUIMain.UIAspectRatioConstraint.AspectRatio
        local v1 = math.min(ViewportSize.X * 0.6, ViewportSize.Y * 0.74 * AspectRatio)
        DRScrambleEventUIMain.UISizeConstraint.MinSize = Vector2.zero
        DRScrambleEventUIMain.Size = UDim2.fromOffset(v1, v1 / AspectRatio)
    end

    function u1.Update(a1) -- Line: 230 -- upvalues: u42 (ref), u1 (val), u47 (ref)
        u42 = a1
        local v1 = false
        if u42 ~= nil then
            v1 = false
            if u42.Ready == true then
                v1 = false
                if u42.Enabled == true then
                    v1 = false
                    if u42.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                    end
                end
            end
        end
        if not v1 then
            u1.Close()
        end
        u47()
    end

    function u1.Show() -- Line: 237
        -- upvalues: u42 (ref), u46 (ref), u47 (ref), u41 (val), Toast (upval), ScrollingFrame (val), Tabs (upval)
        local v1 = false
        if u42 ~= nil then
            v1 = false
            if u42.Ready == true then
                v1 = false
                if u42.Enabled == true then
                    v1 = false
                    if u42.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                    end
                end
            end
        end
        if not v1 then
            return
        end
        u46 = true
        u47()
        if #u41 == 0 then
            Toast.Show({
                Text = "The Sample shop has no available offers yet.",
                Seconds = 3,
                SingleLine = true,
                Unique = true,
            })
            return
        end
        if ScrollingFrame:IsA("ScrollingFrame") then
            ScrollingFrame.CanvasPosition = Vector2.zero
        end
        Tabs.Activate("DrScrambleEvent")
    end

    function u1.Close() -- Line: 252 -- upvalues: Tabs (upval)
        if Tabs.IsActive("DrScrambleEvent") then
            Tabs.Deactivate()
        end
    end

    local u193 = -1

    function u1.Tick(a1) -- Line: 258
        -- upvalues: Tabs (upval), u42 (ref), u1 (val), u193 (ref), u47 (ref)
        if Tabs.IsActive("DrScrambleEvent") then
            local v1 = false
            if u42 ~= nil then
                v1 = false
                if u42.Ready == true then
                    v1 = false
                    if u42.Enabled == true then
                        v1 = false
                        if u42.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u42.EventEndsAt or 0)
                        end
                    end
                end
            end
            if not v1 then
                u1.Close()
                return
            end
            if (math.floor(a1)) ~= u193 then
                math.floor(a1)
                u47()
            end
        end
    end

    function u1.Destroy() -- Line: 267 -- upvalues: u44 (ref), u5 (val)
        u44 = false
        u5:Destroy()
    end

    return u1
end

return v1