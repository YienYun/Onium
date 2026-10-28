-- Script path: ReplicatedStorage.Controllers.GUI.Shops.TrailShopController
-- Decompile time: 8.16 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Trails = require(ReplicatedStorage.Data.Trails)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local u70 = Color3.fromRGB(9, 255, 0)
return {
    Start = function() -- Line: 49
        -- upvalues: GUI (val), Save (val), Simple (val), Trails (val), Products (val), CashPacks (val), Players (val)
        -- upvalues: Toast (val), Remotes (val), u70 (val), TreadmillUtil (val), ButtonFX (val), Storefront (val)
        -- upvalues: MonetizationEntitlements (val)
        local ScrollingFrame = GUI.TrailShop().Frame.ScrollingFrame
        local u9 = ScrollingFrame:FindFirstChildOfClass("UIListLayout")
        assert(u9 ~= nil, "TrailShop.Frame.ScrollingFrame needs a UIListLayout")
        local Frame = Instance.new("Frame")
        Frame.Name = "TrailingGap"
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.LayoutOrder = 1000000
        Frame.Size = UDim2.new()
        Frame.Parent = ScrollingFrame
        local u26 = {}
        local u27 = {}

        local function refreshEntry(a1, a2) -- Line: 86
            -- upvalues: Save (upval), Simple (upval), Trails (upval), Products (upval), CashPacks (upval)
            -- upvalues: Players (upval)
            local v1 = Save.Await()
            assert(v1 ~= nil, "Expected local save data")
            local v2 = v1.TrailInventory[a2] == true
            local v3 = v1.EquippedTrail == a2
            a1.LockedControls.Visible = not v2
            a1.OwnedControls.Visible = v2
            local v4 = v2 and not v3
            a1.OwnedControls.Equip.Visible = v4
            a1.OwnedControls.Unequip.Visible = v2 and v3
            if not v2 then
                a1.LockedControls.BuyCash.Price.Text = ("$%*"):format((Simple.FormatCompact(Trails.Directory[a2].Price, ".#")))
                local ProductId = Trails.Directory[a2].ProductId
                local BuyRbx = a1.LockedControls.BuyRbx
                v4 = false
                if ProductId ~= nil then
                    v4 = false
                    if Products.FromProductId(ProductId) ~= nil then
                        v4 = CashPacks.GetCanBuyProduct(CashPacks.GetPlayerGroup(Players.LocalPlayer), "Trail_" .. a2)
                    end
                end
                BuyRbx.Visible = v4
            end
        end

        local function showFailure(a1) -- Line: 113 -- upvalues: Toast (upval) -- types: a1: string
            Toast.Show({Seconds = 3, Text = a1, Color = Color3.fromRGB(255, 64, 64)})
        end

        local function requestPurchase(a1, a2) -- Line: 121
            -- upvalues: Remotes (upval), Toast (upval), refreshEntry (val)
            local v1, v2 = Remotes.Trailwear.AskPurchase:InvokeServer(a1)
            if not v1 then
                Toast.Show({
                    Seconds = 3,
                    Text = v2 or "Trail request failed",
                    Color = Color3.fromRGB(255, 64, 64),
                })
            end
            refreshEntry(a2, a1)
        end

        local function requestWear(a1, a2, a3) -- Line: 129
            -- upvalues: Remotes (upval), Toast (upval), refreshEntry (val)
            local v1, v2
            if not a3 then
                v1, v2 = Remotes.Trailwear.AskDoff:InvokeServer()
            else
                v1, v2 = Remotes.Trailwear.AskChoose:InvokeServer(a1)
            end
            if not v1 then
                Toast.Show({
                    Seconds = 3,
                    Text = v2 or "Trail request failed",
                    Color = Color3.fromRGB(255, 64, 64),
                })
            end
            refreshEntry(a2, a1)
        end

        local function bindShopEntry(a1, a2) -- Line: 147
            -- upvalues: Trails (upval), ScrollingFrame (val), u70 (upval), TreadmillUtil (upval), u26 (val)
            -- upvalues: ButtonFX (upval), Remotes (upval), Toast (upval), refreshEntry (val), Products (upval)
            -- upvalues: Storefront (upval), u27 (val), MonetizationEntitlements (upval), Simple (upval)
            local u4 = Trails.Directory[a1]
            local u9 = ScrollingFrame:FindFirstChild(a1)
            local v1 = false
            if u9 ~= nil then
                v1 = u9:IsA("ImageLabel")
            end
            assert(v1, (("TrailShop has no card for \"%*\""):format(a1)))
            u9.LayoutOrder = a2
            u9.TrailName.Text = u4.DisplayName
            u9.TrailRarity.Text = u4.Rarity.DisplayName
            u9.Icon.Image = u4.Icon
            u9.Multi.Value.RichText = true
            u9.Multi.Value.Text = ("<font color=\"#%*\">%*</font> <font color=\"#FFFFFF\">Speed</font>"):format(
                u70:ToHex(),
                (TreadmillUtil.FormatSpeedMultiplierValue(u4.SpeedMultiplier))
            )
            u26[a1] = {Card = u9}
            ButtonFX(u9.LockedControls.BuyCash, 1.05, function() -- Line: 167 -- upvalues: a1 (val), u9 (val), Remotes (upval), Toast (upval), refreshEntry (upval)
                local v1 = a1
                local v2, v3 = Remotes.Trailwear.AskPurchase:InvokeServer(v1)
                if not v2 then
                    Toast.Show({
                        Seconds = 3,
                        Text = v3 or "Trail request failed",
                        Color = Color3.fromRGB(255, 64, 64),
                    })
                end
                refreshEntry(u9, v1)
            end)
            ButtonFX(u9.OwnedControls.Equip, 1.05, function() -- Line: 170 -- upvalues: a1 (val), u9 (val), Remotes (upval), Toast (upval), refreshEntry (upval)
                local v1 = a1
                local v2, v3 = Remotes.Trailwear.AskChoose:InvokeServer(v1)
                if not v2 then
                    Toast.Show({
                        Seconds = 3,
                        Text = v3 or "Trail request failed",
                        Color = Color3.fromRGB(255, 64, 64),
                    })
                end
                refreshEntry(u9, v1)
            end)
            ButtonFX(u9.OwnedControls.Unequip, 1.05, function() -- Line: 173 -- upvalues: a1 (val), u9 (val), Remotes (upval), Toast (upval), refreshEntry (upval)
                local v1, v2 = Remotes.Trailwear.AskDoff:InvokeServer()
                if not v1 then
                    Toast.Show({
                        Seconds = 3,
                        Text = v2 or "Trail request failed",
                        Color = Color3.fromRGB(255, 64, 64),
                    })
                end
                refreshEntry(u9, a1)
            end)
            ButtonFX(u9.LockedControls.BuyRbx, 1.05, function() -- Line: 176 -- upvalues: u4 (val), Products (upval), Toast (upval), Storefront (upval)
                local ProductId = u4.ProductId
                if ProductId ~= nil and Products.FromProductId(ProductId) ~= nil then
                    Storefront.Prompt(ProductId, true)
                    return
                end
                Toast.Show({
                    Text = "This trail Robux product is not configured yet",
                    Seconds = 3,
                    Color = Color3.fromRGB(255, 64, 64),
                })
            end)
            if u4.ProductId ~= nil and Products.FromProductId(u4.ProductId) ~= nil then
                u9.LockedControls.BuyRbx.Price.Text = ""
                if not u27[u4.ProductId] then
                    u27[u4.ProductId] = true
                    task.spawn(function() -- Line: 191
                        -- upvalues: MonetizationEntitlements (upval), u4 (val), u26 (upval), a1 (val), u9 (val)
                        -- upvalues: Simple (upval)
                        local v1 = MonetizationEntitlements.ProductPrice(u4.ProductId)
                        local v2 = u26[a1]
                        if v2 ~= nil and v1 > 0 then
                            v2.RobuxPrice = v1
                            u9.LockedControls.BuyRbx.Price.Text = Simple.FormatCompact(v1, ".#")
                        end
                    end)
                end
            end
            refreshEntry(u9, a1)
        end

        Save.Await()
        local u39 = {}
        for k, v in pairs(Trails.Directory) do
            if v.DisplayInShop then
                u39[#u39 + 1] = k
            end
        end
        table.sort(u39, function(a1, a2) -- Line: 219 -- upvalues: Trails (upval) -- types: a1: string, a2: string
            return Trails.Directory[a1].Price < Trails.Directory[a2].Price
        end)
        for i, i2 in ipairs(u39) do
            bindShopEntry(i2, i)
        end
        ;(ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 80 -- upvalues: u9 (val), ScrollingFrame (val), Frame (val)
            local Padding = u9.Padding
            Frame.Size = UDim2.fromOffset(math.ceil(Padding.Scale * ScrollingFrame.AbsoluteSize.X + Padding.Offset), 0)
        end)
        local Padding = u9.Padding
        Frame.Size = UDim2.fromOffset(math.ceil(Padding.Scale * ScrollingFrame.AbsoluteSize.X + Padding.Offset), 0)
        Save.WatchFields({"TrailInventory", "EquippedTrail"}, function() -- Line: 230 -- upvalues: u39 (val), u26 (val), refreshEntry (val)
            local v1, v2
            for i, v in ipairs(u39) do
                v1 = u26[v]
                v2 = ("Missing trail shop entry \"%*\""):format(v)
                assert(v1 ~= nil, v2)
                refreshEntry(v1.Card, v)
            end
        end)
        ;(Players.LocalPlayer:GetAttributeChangedSignal(CashPacks.RevisionAttribute)):Connect(function() -- Line: 240 -- upvalues: u26 (val), refreshEntry (val)
            for i, j in u26 do
                refreshEntry(j.Card, i)
            end
        end)
        return {}
    end,
}