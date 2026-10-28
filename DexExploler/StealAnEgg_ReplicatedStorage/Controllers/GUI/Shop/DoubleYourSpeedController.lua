-- Script path: ReplicatedStorage.Controllers.GUI.Shop.DoubleYourSpeedController
-- Decompile time: 17.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
require(ReplicatedStorage.Data.Products)
local Products_2 = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local u66 = {
    Products_2.Directory.SpeedBoostTier1,
    Products_2.Directory.SpeedBoostTier2,
    Products_2.Directory.SpeedBoostTier3,
    Products_2.Directory.SpeedBoostTier4,
    Products_2.Directory.SpeedBoostTier5,
    Products_2.Directory.SpeedBoostTier6,
    Products_2.Directory.SpeedBoostTier7,
    Products_2.Directory.SpeedBoostTier8,
    Products_2.Directory.SpeedBoostTier9,
    Products_2.Directory.SpeedBoostTier10,
    Products_2.Directory.SpeedBoostTier11,
    Products_2.Directory.SpeedBoostTier12,
}
local u96 = ("ONLY ?%*"):format(Constants.ROBUX_ICON_STR)
return {
    Start = function() -- Line: 58
        -- upvalues: GUI (val), Hud (val), TreadmillUtil (val), Save (val), u66 (val), t (val), Simple (val)
        -- upvalues: Price (val), Constants (val), u96 (val), ButtonFX (val), Storefront (val)
        local End, SpeedBoostMultiplier, SpeedBoostMultiplier_2, Start, v1, v2, v3, v4, v5, v6, v7
        local Spacer = GUI.Shop().Frame.ScrollingFrame.DoubleSpeed.Spacer
        local u262 = Hud.Get("SpeedMultiButton", "Treadmill")
        local v8 = {}
        for i, j in u262:GetChildren() do
            if j:IsA("TextLabel") then
                table.insert(v8, j)
            end
        end
        assert(#v8 >= 2, "TradmilHud SpeedMulti needs a multiplier label and a price label")
        local u266 = v8[1]
        local u270 = v8[2]
        local u38 = {}
        u38[1] = {Buy = Spacer.Buy, End = Spacer.NextAm, Start = Spacer.CurAm}
        local u274 = 0

        local function resolveOwnedSpeedBoostTierIndex() -- Line: 92 -- upvalues: TreadmillUtil (upval), Save (upval)
            return TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await())
        end

        local function resolveNextSpeedBoostProduct() -- Line: 96
            -- upvalues: u66 (upval), TreadmillUtil (upval), Save (upval)
            return u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
        end

        local function resolveSpeedBoostMultiplierForTierIndex(a1) -- Line: 100
            -- upvalues: u66 (upval)
            local v1 = u66[a1]
            if v1 == nil then
                return 1
            end
            return v1.SpeedBoostMultiplier
        end

        local function resolveCurrentAndNextSpeedBoostMultipliers() -- Line: 107
            -- upvalues: TreadmillUtil (upval), Save (upval), u66 (upval)
            local v1 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await())
            local v2 = u66[v1]
            local SpeedBoostMultiplier = if v2 ~= nil then v2.SpeedBoostMultiplier else 1
            v2 = u66[v1 + 1]
            return SpeedBoostMultiplier, if v2 ~= nil then v2.SpeedBoostMultiplier else SpeedBoostMultiplier, v2 == nil
        end

        local function formatSpeedBoostMultiplier(a1) -- Line: 123
            -- upvalues: t (upval), Simple (upval)
            t.strict(t.number)(a1)
            return (("x%*"):format((Simple.FormatCompact(a1, ".#"))))
        end

        local function hasProductCredit(a1) -- Line: 128 -- upvalues: Save (upval) -- types: a1: number
            local ProductCredits
            if not Save.IsLoaded() then
                return false
            end
            local v1 = Save.Await()
            if typeof(if v1 == nil then nil else v1.ProductCredits) ~= "table" then
                return false
            end
            v1 = ProductCredits[tostring(a1)]
            local v2 = false
            if typeof(v1) == "number" then
                v2 = v1 > 0
            end
            return v2
        end

        local function updateProductPrice(a1, a2) -- Line: 141
            -- upvalues: Save (upval), Price (upval), Constants (upval)
            local v1
            a1.Visible = true
            if a2 == nil then
                a1.Text = "MAX"
                a1.Visible = false
                return
            end
            local ProductId = a2.ProductId
            if ProductId <= 0 then
                a1.Text = "???"
                a1.Visible = false
                return
            end
            if Save.IsLoaded() then
                local v2 = Save.Await()
                local ProductCredits = if v2 == nil then nil else v2.ProductCredits
                if typeof(ProductCredits) == "table" then
                    v2 = ProductCredits[tostring(ProductId)]
                    v1 = false
                    if typeof(v2) == "number" then
                        v1 = v2 > 0
                    end
                else
                    v1 = false
                end
            else
                v1 = false
            end
            if v1 then
                a1.Text = "FREE!"
                return
            end
            task.spawn(function() -- Line: 164 -- upvalues: Price (upval), ProductId (val), a1 (val), Constants (upval)
                local v1 = Price(ProductId, Enum.InfoType.Product)
                a1.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v1 == nil then "???" else tostring(v1))
            end)
        end

        local function updateSideButtonPrice(a1) -- Line: 172
            -- upvalues: u274 (ref), u270 (val), Save (upval), u96 (upval), Price (upval), Constants (upval)
            local v1
            u274 = u274 + 1
            local u3 = u274
            if a1 == nil then
                u270.Text = "MAX"
                return
            end
            local ProductId = a1.ProductId
            if Save.IsLoaded() then
                local v2 = Save.Await()
                local ProductCredits = if v2 == nil then nil else v2.ProductCredits
                if typeof(ProductCredits) == "table" then
                    v2 = ProductCredits[tostring(ProductId)]
                    v1 = false
                    if typeof(v2) == "number" then
                        v1 = v2 > 0
                    end
                else
                    v1 = false
                end
            else
                v1 = false
            end
            if v1 then
                u270.Text = "FREE!"
                return
            end
            u270.Text = u96
            task.spawn(function() -- Line: 187
                -- upvalues: Price (upval), ProductId (val), u3 (val), u274 (upval), u270 (upval), Constants (upval)
                -- upvalues: u96 (upval)
                local v1 = Price(ProductId, Enum.InfoType.Product)
                if u3 ~= u274 then
                    return
                end
                u270.Text = if v1 == nil then u96 else ("ONLY %*%*"):format(v1, Constants.ROBUX_ICON_STR)
            end)
        end

        local function updateDoubleYourSpeedTool() -- Line: 199
            -- upvalues: u66 (upval), TreadmillUtil (upval), Save (upval), u262 (val), u270 (val), u266 (val)
            -- upvalues: u274 (ref), u96 (upval), Price (upval), Constants (upval)
            local v1, v2
            local v3 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
            u262.Interactable = v3 ~= nil
            u270.Visible = v1
            if v3 == nil then
                u266.Text = "MAX"
                u274 = u274 + 1
                u270.Text = "MAX"
                return
            end
            u266.Text = TreadmillUtil.FormatSpeedMultiplier(v3.SpeedBoostMultiplier)
            u274 = u274 + 1
            local u29 = u274
            if v3 == nil then
                u270.Text = "MAX"
                return
            end
            local ProductId = v3.ProductId
            if Save.IsLoaded() then
                local v4 = Save.Await()
                local ProductCredits = if v4 == nil then nil else v4.ProductCredits
                if typeof(ProductCredits) == "table" then
                    v4 = ProductCredits[tostring(ProductId)]
                    v2 = false
                    if typeof(v4) == "number" then
                        v2 = v4 > 0
                    end
                else
                    v2 = false
                end
            else
                v2 = false
            end
            if v2 then
                u270.Text = "FREE!"
                return
            end
            u270.Text = u96
            task.spawn(function() -- Line: 187
                -- upvalues: Price (upval), ProductId (val), u29 (val), u274 (upval), u270 (upval), Constants (upval)
                -- upvalues: u96 (upval)
                local v1 = Price(ProductId, Enum.InfoType.Product)
                if u29 ~= u274 then
                    return
                end
                u270.Text = if v1 == nil then u96 else ("ONLY %*%*"):format(v1, Constants.ROBUX_ICON_STR)
            end)
        end

        local function updateDoubleYourSpeedText(a1, a2, a3, a4) -- Line: 217
            -- upvalues: t (upval), Simple (upval)
            local v1
            local Start = a1.Start
            t.strict(t.number)(a2)
            Start.Text = ("x%*"):format((Simple.FormatCompact(a2, ".#")))
            local End = a1.End
            if not a4 then
                t.strict(t.number)(a3)
                v1 = ("x%*"):format((Simple.FormatCompact(a3, ".#")))
            else
                v1 = "MAX"
            end
            End.Text = v1
        end

        local function updateDoubleYourSpeedVisibility(a1, a2) -- Line: 230 -- types: a1: table, a2: boolean
            a1.Buy.Visible = not a2
            a1.Buy.Interactable = not a2
        end

        local function updateDoubleYourSpeedPack(a1) -- Line: 238
            -- upvalues: TreadmillUtil (upval), Save (upval), u66 (upval), updateProductPrice (val), t (upval)
            -- upvalues: Simple (upval)
            local v1
            local v2 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await())
            local v3 = u66[v2]
            local SpeedBoostMultiplier = if v3 ~= nil then v3.SpeedBoostMultiplier else 1
            v3 = u66[v2 + 1]
            local SpeedBoostMultiplier_2 = if v3 ~= nil then v3.SpeedBoostMultiplier else SpeedBoostMultiplier
            local v4 = SpeedBoostMultiplier
            local v5 = SpeedBoostMultiplier_2
            local v6 = v3 == nil
            a1.Buy.Visible = not v6
            a1.Buy.Interactable = not v6
            updateProductPrice(a1.Buy.Price, u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1])
            local Start = a1.Start
            t.strict(t.number)(v4)
            Start.Text = ("x%*"):format((Simple.FormatCompact(v4, ".#")))
            local End = a1.End
            if not v6 then
                t.strict(t.number)(v5)
                v1 = ("x%*"):format((Simple.FormatCompact(v5, ".#")))
            else
                v1 = "MAX"
            end
            End.Text = v1
        end

        local function bindDoubleYourSpeedButton(a1) -- Line: 251
            -- upvalues: ButtonFX (upval), u66 (upval), TreadmillUtil (upval), Save (upval), Storefront (upval)
            ButtonFX(a1.Buy, nil, function() -- Line: 252 -- upvalues: u66 (upval), TreadmillUtil (upval), Save (upval), Storefront (upval)
                local v1 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
                if v1 == nil then
                    return
                end
                Storefront.Prompt(v1.ProductId, true)
            end)
        end

        local function updateSpeedBoostProducts() -- Line: 262
            -- upvalues: u38 (val), TreadmillUtil (upval), Save (upval), u66 (upval), updateProductPrice (val)
            -- upvalues: t (upval), Simple (upval), u262 (val), u270 (val), u266 (val), u274 (ref), u96 (upval)
            -- upvalues: Price (upval), Constants (upval)
            local End, SpeedBoostMultiplier, SpeedBoostMultiplier_2, Start, v1, v2, v3, v4, v5, v6, v7, v8
            for i, v in ipairs(u38) do
                v7 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await())
                v2 = u66[v7]
                SpeedBoostMultiplier = if v2 ~= nil then v2.SpeedBoostMultiplier else 1
                v2 = u66[v7 + 1]
                SpeedBoostMultiplier_2 = if v2 ~= nil then v2.SpeedBoostMultiplier else SpeedBoostMultiplier
                v4 = SpeedBoostMultiplier
                v5 = SpeedBoostMultiplier_2
                v6 = v2 == nil
                v.Buy.Visible = not v6
                v.Buy.Interactable = not v6
                updateProductPrice(v.Buy.Price, u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1])
                Start = v.Start
                t.strict(t.number)(v4)
                Start.Text = ("x%*"):format((Simple.FormatCompact(v4, ".#")))
                End = v.End
                if not v6 then
                    t.strict(t.number)(v5)
                    v8 = ("x%*"):format((Simple.FormatCompact(v5, ".#")))
                else
                    v8 = "MAX"
                end
                End.Text = v8
            end
            local v9 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
            u262.Interactable = v9 ~= nil
            u270.Visible = v1
            if v9 == nil then
                u266.Text = "MAX"
                u274 = u274 + 1
                u270.Text = "MAX"
                return
            end
            u266.Text = TreadmillUtil.FormatSpeedMultiplier(v9.SpeedBoostMultiplier)
            u274 = u274 + 1
            local u41 = u274
            if v9 == nil then
                u270.Text = "MAX"
                return
            end
            local ProductId = v9.ProductId
            if Save.IsLoaded() then
                v4 = Save.Await()
                local ProductCredits = if v4 == nil then nil else v4.ProductCredits
                if typeof(ProductCredits) == "table" then
                    v4 = ProductCredits[tostring(ProductId)]
                    v3 = false
                    if typeof(v4) == "number" then
                        v3 = v4 > 0
                    end
                else
                    v3 = false
                end
            else
                v3 = false
            end
            if v3 then
                u270.Text = "FREE!"
                return
            end
            u270.Text = u96
            task.spawn(function() -- Line: 187
                -- upvalues: Price (upval), ProductId (val), u41 (val), u274 (upval), u270 (upval), Constants (upval)
                -- upvalues: u96 (upval)
                local v1 = Price(ProductId, Enum.InfoType.Product)
                if u41 ~= u274 then
                    return
                end
                u270.Text = if v1 == nil then u96 else ("ONLY %*%*"):format(v1, Constants.ROBUX_ICON_STR)
            end)
        end

        Save.Await()
        for i2, v in ipairs(u38) do
            ButtonFX(v.Buy, nil, function() -- Line: 252 -- upvalues: u66 (upval), TreadmillUtil (upval), Save (upval), Storefront (upval)
                local v1 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
                if v1 == nil then
                    return
                end
                Storefront.Prompt(v1.ProductId, true)
            end)
            v5 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await())
            v7 = u66[v5]
            SpeedBoostMultiplier = if v7 ~= nil then v7.SpeedBoostMultiplier else 1
            v7 = u66[v5 + 1]
            SpeedBoostMultiplier_2 = if v7 ~= nil then v7.SpeedBoostMultiplier else SpeedBoostMultiplier
            v2 = SpeedBoostMultiplier
            v3 = SpeedBoostMultiplier_2
            v4 = v7 == nil
            v.Buy.Visible = not v4
            v.Buy.Interactable = not v4
            updateProductPrice(v.Buy.Price, u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1])
            Start = v.Start
            t.strict(t.number)(v2)
            Start.Text = ("x%*"):format((Simple.FormatCompact(v2, ".#")))
            End = v.End
            if not v4 then
                t.strict(t.number)(v3)
                v6 = ("x%*"):format((Simple.FormatCompact(v3, ".#")))
            else
                v6 = "MAX"
            end
            End.Text = v6
        end
        ButtonFX(u262, 1.08, function() -- Line: 280 -- upvalues: u66 (upval), TreadmillUtil (upval), Save (upval), Storefront (upval)
            local v1 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
            if v1 == nil then
                return
            end
            Storefront.Prompt(v1.ProductId, true)
        end)
        local v9 = u66[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Await()) + 1]
        u262.Interactable = v9 ~= nil
        u270.Visible = v1
        if v9 ~= nil then
            u266.Text = TreadmillUtil.FormatSpeedMultiplier(v9.SpeedBoostMultiplier)
            u274 = u274 + 1
            local u112 = u274
            if v9 ~= nil then
                local v10
                local ProductId = v9.ProductId
                if Save.IsLoaded() then
                    local v11 = Save.Await()
                    local ProductCredits = if v11 == nil then nil else v11.ProductCredits
                    if typeof(ProductCredits) == "table" then
                        v11 = ProductCredits[tostring(ProductId)]
                        v10 = false
                        if typeof(v11) == "number" then
                            v10 = v11 > 0
                        end
                    else
                        v10 = false
                    end
                else
                    v10 = false
                end
                if not v10 then
                    u270.Text = u96
                    task.spawn(function() -- Line: 187
                        -- upvalues: Price (upval), ProductId (val), u112 (val), u274 (ref), u270 (val)
                        -- upvalues: Constants (upval), u96 (upval)
                        local v1 = Price(ProductId, Enum.InfoType.Product)
                        if u112 ~= u274 then
                            return
                        end
                        u270.Text = if v1 == nil then u96 else ("ONLY %*%*"):format(v1, Constants.ROBUX_ICON_STR)
                    end)
                else
                    u270.Text = "FREE!"
                end
            else
                u270.Text = "MAX"
            end
        else
            u266.Text = "MAX"
            u274 = u274 + 1
            u270.Text = "MAX"
        end
        Save.WatchFields({"SpeedBoostTierIndex", "ProductCredits"}, updateSpeedBoostProducts)
    end,
}