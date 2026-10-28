-- Script path: ReplicatedStorage.Controllers.GUI.Shop.MainShopController
-- Decompile time: 10.23 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local Message = require(ReplicatedStorage.Client.Message)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local Gamepasses_2 = require(ReplicatedStorage.Client.Gamepasses)
local Gifting = require(ReplicatedStorage.Client.Gifting)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local Hud = require(ReplicatedStorage.Client.Hud)
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local ShopNavigation = require(ReplicatedStorage.Client.ShopNavigation)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local t = require(ReplicatedStorage.Packages.t)
local u89 = {Owned = "OWNED", Pending = "Loading..."}
return {
    Start = function() -- Line: 54
        -- upvalues: Players (val), GUI (val), TryLock (val), t (val), Products (val), Gamepasses (val), Save (val)
        -- upvalues: Price (val), Gamepasses_2 (val), u89 (val), CashPacks (val), Simple (val), ButtonFX (val)
        -- upvalues: Message (val), Storefront (val), Gifting (val), Hud (val), Tabs (val), ShopNavigation (val)
        -- upvalues: Remotes (val)
        local LocalPlayer = Players.LocalPlayer
        local ScrollingFrame = GUI.Shop().Frame.ScrollingFrame
        local Money = ScrollingFrame.Money
        local Passes = ScrollingFrame.Passes
        local u11 = TryLock()

        local function mapProductEntry(a1, a2) -- Line: 69 -- upvalues: t (upval) -- types: a1: userdata, a2: table
            t.strict(t.table)(a2)
            t.strict(t.number)(a2.ProductId)
            local Buy = a1.Btns.Buy
            local Price = Buy.Price
            assert(Buy and Buy:IsA("GuiButton"), "Expected Btns.Buy to be a GuiButton")
            assert(Price and Price:IsA("TextLabel"), "Expected Buy.Price to be a TextLabel")
            return {
                frame = a1,
                button = Buy,
                priceLabel = Price,
                productId = a2.ProductId,
                giftButton = a1.Btns.Gift,
            }
        end

        local u13 = {}
        local v1 = mapProductEntry(Money.c1, Products.Directory.CashPack1)
        local v2 = mapProductEntry(Money.c2, Products.Directory.CashPack2)
        local v3 = mapProductEntry(Money.c3, Products.Directory.CashPack3)
        local v4 = mapProductEntry(Money.c4, Products.Directory.CashPack4)
        u13[1] = v1
        u13[2] = v2
        u13[3] = v3
        u13[4] = v4
        u13[5] = (mapProductEntry(Money.c5, Products.Directory.CashPack5))

        local function mapGamepassEntry(a1, a2) -- Line: 105 -- upvalues: t (upval) -- types: a1: userdata
            local Buy = a1.Btns.Buy
            local Price = Buy.Price
            assert(a1 and a1:IsA("GuiObject"), "Expected a pass card GuiObject")
            assert(Price and Price:IsA("TextLabel"), "Expected card.Btns.Buy.Price to be a TextLabel")
            t.strict(t.table)(a2)
            t.strict(t.string)(a2.Name)
            t.strict(t.number)(a2.ProductId)
            return {
                card = a1,
                button = Buy,
                giftButton = a1.Btns.Gift,
                priceLabel = Price,
                gamepassId = a2.Name,
                productId = a2.ProductId,
            }
        end

        local u45 = {}
        u45[1] = (mapGamepassEntry(Passes.Money, Gamepasses.Directory.X2Money))
        u45[2] = (mapGamepassEntry(Passes.Growth, Gamepasses.Directory.X2Growth))

        local function ownsProduct(a1) -- Line: 143 -- upvalues: Save (upval) -- types: a1: number
            local v1 = Save.Await()
            local Products = if v1 == nil then nil else v1.Products
            local v2 = false
            if Products ~= nil then
                v2 = Products[tostring(a1)] == true
            end
            return v2
        end

        local function renderPrice(a1, a2, a3, a4) -- Line: 149
            -- upvalues: Price (upval)
            local v1 = Price(a2, a3)
            local v2 = "Loading..."
            if v1 ~= nil then
                v2 = if not a4() then "" .. tostring(v1) else "OWNED"
            end
            a1.Text = v2
        end

        local function updateGamepassPrice(a1) -- Line: 165
            -- upvalues: Gamepasses_2 (upval), Price (upval), u89 (upval)
            local priceLabel = a1.priceLabel
            local productId = a1.productId
            local GamePass = Enum.InfoType.GamePass

            local function v1() -- Line: 170 -- upvalues: Gamepasses_2 (upval), a1 (val)
                return Gamepasses_2.Owns(a1.gamepassId)
            end

            local v2 = Price(productId, GamePass)
            local Pending = u89.Pending
            if v2 ~= nil then
                Pending = if not Gamepasses_2.Owns(a1.gamepassId) then "" .. tostring(v2) else u89.Owned
            end
            priceLabel.Text = Pending
        end

        local function updatePrice(a1) -- Line: 176
            -- upvalues: CashPacks (upval), LocalPlayer (val), Simple (upval), Save (upval), Price (upval), u89 (upval)
            local v1 = CashPacks.FindSlot(a1.productId)
            if v1 then
                local v2 = CashPacks.GetShownAmount(LocalPlayer, v1)
                local Title = a1.frame:FindFirstChild("Title")
                if Title and Title:IsA("TextLabel") then
                    Title.Text = if not v2 then "Loading..." else "$" .. Simple.FormatCompact(v2, ".#")
                end
            end
            local priceLabel = a1.priceLabel
            local productId = a1.productId
            local Product = Enum.InfoType.Product

            local function v3() -- Line: 191 -- upvalues: a1 (val), Save (upval)
                local productId = a1.productId
                local v1 = Save.Await()
                local Products = if v1 == nil then nil else v1.Products
                local v2 = false
                if Products ~= nil then
                    v2 = Products[tostring(productId)] == true
                end
                return v2
            end

            v1 = Price(productId, Product)
            local Pending = u89.Pending
            if v1 ~= nil then
                local productId_2 = a1.productId
                local v4 = Save.Await()
                local Products = if v4 == nil then nil else v4.Products
                local v5 = false
                if Products ~= nil then
                    v5 = Products[tostring(productId_2)] == true
                end
                Pending = if not v5 then "" .. tostring(v1) else u89.Owned
            end
            priceLabel.Text = Pending
        end

        local function bindBuyButton(a1, a2, a3, a4) -- Line: 197
            -- upvalues: ButtonFX (upval), u11 (val), Message (upval), Storefront (upval)
            ButtonFX(a1, nil, function() -- Line: 203 -- upvalues: u11 (upval), a4 (val), Message (upval), Storefront (upval), a2 (val), a3 (val)
                u11(function() -- Line: 204 -- upvalues: a4 (upval), Message (upval), Storefront (upval), a2 (upval), a3 (upval)
                    if a4 ~= nil and a4() then
                        Message.Notice("You already own this item!")
                        return
                    end
                    Storefront.Prompt(a2, a3)
                end)
            end)
        end

        local function updateAllProducts() -- Line: 214 -- upvalues: u13 (val), updatePrice (val)
            for i, j in u13 do
                task.spawn(updatePrice, j)
            end
        end

        local function updateAllGamepasses() -- Line: 220 -- upvalues: u45 (val), updateGamepassPrice (val)
            for i, j in u45 do
                task.spawn(updateGamepassPrice, j)
            end
        end

        for i, j in u13 do
            Gifting.Bind(j.giftButton, "Product", j.productId)
            task.spawn(function() -- Line: 228
                -- upvalues: updatePrice (val), j (val), Save (upval), ButtonFX (upval), u11 (val), Message (upval)
                -- upvalues: Storefront (upval)
                updatePrice(j)
                local button = j.button
                local productId = j.productId

                local function u7() -- Line: 230 -- upvalues: j (upval), Save (upval)
                    local productId = j.productId
                    local v1 = Save.Await()
                    local Products = if v1 == nil then nil else v1.Products
                    local v2 = false
                    if Products ~= nil then
                        v2 = Products[tostring(productId)] == true
                    end
                    return v2
                end

                local v1 = ButtonFX
                local u11_2 = true
                v1(button, nil, function() -- Line: 203
                    -- upvalues: u11 (upval), u7 (val), Message (upval), Storefront (upval), productId (val)
                    -- upvalues: u11_2 (val)
                    u11(function() -- Line: 204 -- upvalues: u7 (upval), Message (upval), Storefront (upval), productId (upval), u11_2 (upval)
                        if u7 ~= nil and u7() then
                            Message.Notice("You already own this item!")
                            return
                        end
                        Storefront.Prompt(productId, u11_2)
                    end)
                end)
            end)
        end
        for k, n in u45 do
            Gifting.Bind(n.giftButton, "Gamepass", n.productId)
            task.spawn(function() -- Line: 238
                -- upvalues: n (val), Gamepasses_2 (upval), Price (upval), u89 (upval), ButtonFX (upval), u11 (val)
                -- upvalues: Message (upval), Storefront (upval)
                local u0 = n
                local priceLabel = u0.priceLabel
                local productId_2 = u0.productId
                local GamePass = Enum.InfoType.GamePass

                local function v1() -- Line: 170 -- upvalues: Gamepasses_2 (upval), u0 (val)
                    return Gamepasses_2.Owns(u0.gamepassId)
                end

                local v2 = Price(productId_2, GamePass)
                local Pending = u89.Pending
                if v2 ~= nil then
                    Pending = if not Gamepasses_2.Owns(u0.gamepassId) then "" .. tostring(v2) else u89.Owned
                end
                priceLabel.Text = Pending
                local button = n.button
                local productId = n.productId
                local v3 = ButtonFX
                local u31 = nil
                local u32 = false
                v3(button, nil, function() -- Line: 203
                    -- upvalues: u11 (upval), u31 (val), Message (upval), Storefront (upval), productId (val), u32 (val)
                    u11(function() -- Line: 204 -- upvalues: u31 (upval), Message (upval), Storefront (upval), productId (upval), u32 (upval)
                        if u31 ~= nil and u31() then
                            Message.Notice("You already own this item!")
                            return
                        end
                        Storefront.Prompt(productId, u32)
                    end)
                end)
            end)
        end
        for m, i5 in Hud.Every("ShopButton") do
            ButtonFX(i5, 1.08, function() -- Line: 245 -- upvalues: Tabs (upval), ShopNavigation (upval)
                if Tabs.IsActive("Shop") then
                    Tabs.Deactivate()
                    return
                end
                ShopNavigation.Open("Featured")
            end)
        end
        Tabs.Activated:Connect(function(a1) -- Line: 254
            -- upvalues: u13 (val), updatePrice (val), u45 (val), updateGamepassPrice (val)
            if a1 == "Shop" then
                for i, j in u13 do
                    task.spawn(updatePrice, j)
                end
                for k, n in u45 do
                    task.spawn(updateGamepassPrice, n)
                end
            end
        end)
        if Save.IsLoaded() then
            task.spawn(function() -- Line: 262 -- upvalues: u13 (val), updatePrice (val), u45 (val), updateGamepassPrice (val)
                for i, j in u13 do
                    task.spawn(updatePrice, j)
                end
                for k, n in u45 do
                    task.spawn(updateGamepassPrice, n)
                end
            end)
        end
        Save.Loaded:Connect(function(a1) -- Line: 268 -- upvalues: LocalPlayer (val), u13 (val), updatePrice (val) -- types: a1: userdata
            if a1 ~= LocalPlayer then
                return
            end
            for i, j in u13 do
                task.spawn(updatePrice, j)
            end
        end)
        ;(LocalPlayer:GetAttributeChangedSignal(CashPacks.RevisionAttribute)):Connect(updateAllProducts)
        Save.WatchFields("Products", updateAllProducts)
        Save.WatchFields("Gamepasses", updateAllGamepasses)
        Remotes.PassGrants.Awarded.OnClientEvent:Connect(updateAllGamepasses)
    end,
}