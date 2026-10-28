-- Script path: ReplicatedStorage.Controllers.GUI.Shop.ShopAlertBadgeController
-- Decompile time: 1.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AlertBadge = require(ReplicatedStorage.Client.UI.AlertBadge)
local Hud = require(ReplicatedStorage.Client.Hud)
local Tabs = require(ReplicatedStorage.Client.Tabs)
return {
    Start = function() -- Line: 18 -- upvalues: Players (val), AlertBadge (val), Hud (val), Tabs (val), ReplicatedStorage (val)
        local LocalPlayer = Players.LocalPlayer
        local u8 = AlertBadge.Attach(Hud.Find("ShopButton"))
        local u9 = false
        Tabs.Activated:Connect(function(a1) -- Line: 34 -- upvalues: u9 (ref), u8 (val) -- types: a1: string
            if a1 == "Shop" then
                u9 = true
                u8:Dismiss()
            end
        end)
        ;(LocalPlayer:GetAttributeChangedSignal("ShopVersionChanged")):Connect(function() -- Line: 28 -- upvalues: u9 (ref), LocalPlayer (val), u8 (val)
            if not u9 and LocalPlayer:GetAttribute("ShopVersionChanged") == true then
                u8:Show()
            end
        end)
        ;(ReplicatedStorage:GetAttributeChangedSignal("ShopAlertNonce")):Connect(function() -- Line: 41 -- upvalues: Tabs (upval), u9 (ref), u8 (val)
            if Tabs.Active() == "Shop" then
                return
            end
            u9 = false
            u8:Show()
        end)
        if not u9 and LocalPlayer:GetAttribute("ShopVersionChanged") == true then
            u8:Show()
        end
    end,
}