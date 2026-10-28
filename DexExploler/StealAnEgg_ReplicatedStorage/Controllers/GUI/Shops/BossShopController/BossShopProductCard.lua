-- Script path: ReplicatedStorage.Controllers.GUI.Shops.BossShopController.BossShopProductCard
-- Decompile time: 2.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
return table.freeze({
    New = function(a1, a2, a3, a4, a5) -- Line: 17
        -- upvalues: BossMastery (val), Simple (val), ButtonFX (val)
        local u7 = a1:Clone()
        u7.Name = a3.Id
        u7.LayoutOrder = a4
        u7.Visible = true
        u7.Parent = a2
        local Frame = u7.Frame
        local EggName = Frame.EggName
        local OutputEgg = Frame.OutputEgg
        local QuantityLabel = Frame.Quantity.QuantityLabel
        local Buy = Frame.Buy
        local Price = Buy.PriceHolder.Price
        local u18 = false
        OutputEgg.Image = a3.Icon
        local u20 = nil
        local u27 = ButtonFX(Buy, 1.05, function() -- Line: 61 -- upvalues: u18 (ref), a5 (val), a3 (val), u20 (ref)
            if not u18 then
                a5(a3, u20)
            end
        end)
        u20 = {
            Refresh = function() -- Line: 45
                -- upvalues: EggName (val), BossMastery (upval), a3 (val), Price (val), Simple (upval)
                -- upvalues: QuantityLabel (val)
                EggName.Text = BossMastery.GetShopDisplayName(a3)
                Price.Text = Simple.FormatCompact(BossMastery.GetShopPrice(a3), ".#")
                QuantityLabel.Text = BossMastery.GetShopQuantityText(a3)
            end,
            SetPending = function(a1) -- Line: 54 -- upvalues: u18 (ref), Buy (val) -- types: a1: boolean
                u18 = a1
                Buy.Active = not a1
                Buy.Interactable = not a1
                Buy.AutoButtonColor = not a1
            end,
            Destroy = function() -- Line: 70 -- upvalues: u27 (val), u7 (val)
                u27()
                u7:Destroy()
            end,
        }
        EggName.Text = BossMastery.GetShopDisplayName(a3)
        Price.Text = Simple.FormatCompact(BossMastery.GetShopPrice(a3), ".#")
        QuantityLabel.Text = BossMastery.GetShopQuantityText(a3)
        return u20
    end,
})