-- Script path: ReplicatedStorage.Controllers.GUI.Shop.TreadmillSpeedShopController
-- Decompile time: 6.15 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local Products = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Client = require(script.Parent.Parent.TreadmillUpgradeController.Client)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local u87 = ColorSequence.new(Color3.fromRGB(214, 17, 17), Color3.fromRGB(253, 20, 20))
local u92 = Color3.fromRGB(72, 0, 0)
local u97 = Color3.fromRGB(255, 103, 103)
return {
    Start = function() -- Line: 39
        -- upvalues: GUI (val), Save (val), Constants (val), Price (val), Simple (val), u87 (val), u92 (val), u97 (val)
        -- upvalues: Treadmills (val), Client (val), Products (val), CashPacks (val), Players (val), ButtonFX (val)
        -- upvalues: Tabs (val)
        local UpgradeTreadmil = GUI.Shop().Frame.ScrollingFrame.UpgradeTreadmil
        local Spacer = UpgradeTreadmil.Spacer
        local Btns = Spacer.Btns
        local Cash = Btns.Cash
        local Robux = Btns.Robux
        local u14 = Cash:FindFirstChildOfClass("UIGradient")
        local UIStroke = Cash:FindFirstChild("UIStroke")
        local UIStrokeClr = Cash:FindFirstChild("UIStrokeClr")
        local Color = if u14 == nil then nil else u14.Color
        local Color_2 = if UIStroke == nil then nil else UIStroke.Color
        local Color_3 = if UIStrokeClr == nil then nil else UIStrokeClr.Color
        local u32 = 0

        local function getLoadedData() -- Line: 70 -- upvalues: Save (upval)
            local v1 = Save.Await()
            assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
            return v1
        end

        local function updateRobuxUpgradePrice(a1, a2) -- Line: 76
            -- upvalues: Robux (val), Constants (upval), Price (upval), u32 (ref), Simple (upval)
            Robux.Price.Text = Constants.ROBUX_ICON_STR
            task.spawn(function() -- Line: 81
                -- upvalues: Price (upval), a1 (val), a2 (val), u32 (upval), Robux (upval), Constants (upval)
                -- upvalues: Simple (upval)
                local v1 = Price(a1, Enum.InfoType.Product)
                if a2 ~= u32 then
                    return
                end
                Robux.Price.Text = ("%* %*"):format(Constants.ROBUX_ICON_STR, if v1 == nil then "???" else Simple.FormatCompact(v1, ".#"))
            end)
        end

        local function applyMoneyAffordability(a1) -- Line: 93
            -- upvalues: u14 (val), Color (val), u87 (upval), UIStroke (val), Color_2 (val), u92 (upval)
            -- upvalues: UIStrokeClr (val), Color_3 (val), u97 (upval)
            if u14 ~= nil then
                u14.Color = if not a1 then u87 else Color
            end
            if UIStroke ~= nil then
                UIStroke.Color = if not a1 then u92 else Color_2
            end
            if UIStrokeClr ~= nil then
                UIStrokeClr.Color = if not a1 then u97 else Color_3
            end
        end

        local function refreshUpgrade(a1, a2) -- Line: 111
            -- upvalues: Treadmills (upval), Spacer (val), Client (upval), UpgradeTreadmil (val), Cash (val)
            -- upvalues: Simple (upval), u14 (val), Color (val), u87 (upval), UIStroke (val), Color_2 (val), u92 (upval)
            -- upvalues: UIStrokeClr (val), Color_3 (val), u97 (upval), Robux (val), Products (upval), CashPacks (upval)
            -- upvalues: Players (upval), Constants (upval), Price (upval), u32 (ref)
            local v1
            local v2 = Treadmills.GetByUpgradeLevel(a1.TreadmillUpgradeLevel)
            local v3 = ("Invalid current treadmill level %*"):format(a1.TreadmillUpgradeLevel)
            assert(v2 ~= nil, v3)
            Spacer.CurrentTreadmill.Image = v2.Icon
            _, v1 = Client.GetNextConfig(a1)
            if v1 == nil then
                UpgradeTreadmil.Visible = false
                return
            end
            UpgradeTreadmil.Visible = true
            Spacer.NextTreadmill.Image = v1.Icon
            Cash.Price.Text = "$" .. Simple.FormatCompact(v1.Price, ".#")
            v3 = Client.CanAffordNext(a1)
            if u14 ~= nil then
                u14.Color = if not v3 then u87 else Color
            end
            if UIStroke ~= nil then
                UIStroke.Color = if not v3 then u92 else Color_2
            end
            if UIStrokeClr ~= nil then
                UIStrokeClr.Color = if not v3 then u97 else Color_3
            end
            local ProductId = v1.ProductId
            v3 = Robux
            local v4 = false
            if ProductId ~= nil then
                v4 = false
                if Products.FromProductId(ProductId) ~= nil then
                    v4 = CashPacks.GetCanBuyProduct(CashPacks.GetPlayerGroup(Players.LocalPlayer), "Treadmill_" .. v1._id)
                end
            end
            v3.Visible = v4
            if ProductId ~= nil and Robux.Visible then
                Robux.Price.Text = Constants.ROBUX_ICON_STR
                task.spawn(function() -- Line: 81
                    -- upvalues: Price (upval), ProductId (val), a2 (val), u32 (upval), Robux (upval), Constants (upval)
                    -- upvalues: Simple (upval)
                    local v1 = Price(ProductId, Enum.InfoType.Product)
                    if a2 ~= u32 then
                        return
                    end
                    Robux.Price.Text = ("%* %*"):format(Constants.ROBUX_ICON_STR, if v1 == nil then "???" else Simple.FormatCompact(v1, ".#"))
                end)
            end
        end

        Save.Await()
        ButtonFX(Cash, nil, Client.RequestCashUpgrade)
        ButtonFX(Robux, nil, Client.PromptRobuxUpgrade)
        Tabs.Activated:Connect(function(a1) -- Line: 161 -- upvalues: u32 (ref), Save (upval), refreshUpgrade (val) -- types: a1: string
            if a1 == "Shop" then
                u32 = u32 + 1
                local v1 = Save.Await()
                assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
                refreshUpgrade(v1, u32)
            end
        end)
        ;(Save.Watch("TreadmillUpgradeLevel")):Connect(function() -- Line: 167 -- upvalues: Tabs (upval), u32 (ref), Save (upval), refreshUpgrade (val)
            if Tabs.IsActive("Shop") then
                u32 = u32 + 1
                local v1 = Save.Await()
                assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
                refreshUpgrade(v1, u32)
            end
        end)
        ;(Save.Watch("Money")):Connect(function() -- Line: 173 -- upvalues: Tabs (upval), u32 (ref), Save (upval), refreshUpgrade (val)
            if Tabs.IsActive("Shop") then
                u32 = u32 + 1
                local v1 = Save.Await()
                assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
                refreshUpgrade(v1, u32)
            end
        end)
        ;(Players.LocalPlayer:GetAttributeChangedSignal(CashPacks.RevisionAttribute)):Connect(function() -- Line: 144 -- upvalues: u32 (ref), Save (upval), refreshUpgrade (val)
            u32 = u32 + 1
            local v1 = Save.Await()
            assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
            refreshUpgrade(v1, u32)
        end)
        u32 = u32 + 1
        local v1 = Save.Await()
        assert(v1 ~= nil, "Treadmill speed shop requires loaded player data")
        refreshUpgrade(v1, u32)
    end,
}