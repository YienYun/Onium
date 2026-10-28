-- Script path: ReplicatedStorage.Controllers.GUI.Shop.SpeedShopShortcutController
-- Decompile time: 0.53 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Hud = require(ReplicatedStorage.Client.Hud)
local ShopNavigation = require(ReplicatedStorage.Client.ShopNavigation)
return {
    Start = function() -- Line: 10 -- upvalues: Hud (val), ButtonFX (val), ShopNavigation (val)
        for i, j in Hud.Every("SpeedShopButton") do
            ButtonFX(j, 1.08, function() -- Line: 12 -- upvalues: ShopNavigation (upval)
                ShopNavigation.Open("SpeedProducts")
            end)
        end
    end,
}