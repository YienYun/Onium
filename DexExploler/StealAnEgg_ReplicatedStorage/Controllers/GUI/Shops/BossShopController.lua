-- Script path: ReplicatedStorage.Controllers.GUI.Shops.BossShopController
-- Decompile time: 8.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local BossShopProductCard = require(script.BossShopProductCard)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u73 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u78 = Color3.fromRGB(255, 64, 64)
local u83 = Color3.fromRGB(80, 255, 120)
return {
    Start = function() -- Line: 29
        -- upvalues: GUI (val), Trove (val), ButtonFX (val), Tabs (val), GamepadBindings (val), Simple (val)
        -- upvalues: Numbers (val), Save (val), TweenService (val), u73 (val), Toast (val), BossMastery (val), u83 (val)
        -- upvalues: u78 (val), Remotes (val), BossShopProductCard (val), BossMasteryFlags (val)
        local Main = GUI.BossShop().Main
        local Main_2 = Main.Main
        local ScrollingFrame = Main_2.ScrollingFrame
        local BossShopItemTemplate = ScrollingFrame.BossShopItemTemplate
        local Amount = Main_2.Header.CurrencyHolder.Amount
        local Close = Main_2.Close
        local BossMasteryButton = Main.BossMasteryButton
        local GamepadGlyph = BossMasteryButton.GamepadGlyph
        local v1 = Trove.new()
        local u18 = Trove.new()
        local u21 = Trove.new()
        local u22 = {}
        local u80 = nil
        local u85 = nil
        local u25 = false
        v1:Add(u18)
        v1:Add(u21)
        v1:Add((ButtonFX(Close, 1.08, function() -- Line: 49 -- upvalues: Tabs (upval)
            Tabs.Deactivate()
        end)))
        GamepadGlyph:SetAttribute("GamepadKey", "ButtonX")
        GamepadBindings.Inspect(GamepadGlyph)
        v1:Add((ButtonFX(BossMasteryButton, 1.08, function() -- Line: 54 -- upvalues: Tabs (upval)
            Tabs.Activate("BossMastery")
        end)))

        local function formatTokens(a1) -- Line: 58 -- upvalues: Simple (upval), Numbers (upval) -- types: a1: number
            if 99999 < (math.abs(a1)) then
                return Simple.FormatCompact(math.round(a1), ".#")
            end
            return Numbers.AddCommas((math.round(a1)))
        end

        local function setTokenText(a1) -- Line: 65
            -- upvalues: Amount (val), Simple (upval), Numbers (upval)
            local v1 = if not (99999 < (math.abs(a1))) then Numbers.AddCommas((math.round(a1))) else Simple.FormatCompact(math.round(a1), ".#")
            Amount.Text = v1
        end

        local function refreshTokenBalance(a1) -- Line: 69
            -- upvalues: Save (upval), u85 (ref), u80 (ref), u18 (val), Amount (val), Simple (upval), Numbers (upval)
            -- upvalues: setTokenText (val), TweenService (upval), u73 (upval)
            local v1 = Save.Await()
            if v1 == nil then
                return
            end
            local BossTokens = v1.BossTokens
            local Value = if not u85 then u80 else u85.Value
            u80 = BossTokens
            u18:Clean()
            u85 = nil
            if not a1 and Value ~= nil and Value ~= BossTokens then
                local NumberValue = Instance.new("NumberValue")
                NumberValue.Value = Value
                u85 = NumberValue
                u18:Add(NumberValue)
                u18:Connect(NumberValue.Changed, setTokenText)
                local v2 = if not (99999 < (math.abs(Value))) then Numbers.AddCommas((math.round(Value))) else Simple.FormatCompact(math.round(Value), ".#")
                Amount.Text = v2
                v1 = TweenService:Create(NumberValue, u73, {Value = BossTokens})
                u18:Add(v1)
                v1:Play()
                return
            end
            local v3 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
            Amount.Text = v3
        end

        local function refreshCards() -- Line: 99 -- upvalues: u22 (val)
            for i, j in u22 do
                j.Refresh()
            end
        end

        local function setCardsPending(a1) -- Line: 105 -- upvalues: u25 (ref), u22 (val) -- types: a1: boolean
            u25 = a1
            for i, j in u22 do
                j.SetPending(a1)
            end
        end

        local function showResult(a1, a2, a3) -- Line: 112
            -- upvalues: Toast (upval), BossMastery (upval), u83 (upval), u78 (upval)
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Text = if not a2 then a3 or "Purchase failed" else ("Purchased %*!"):format((BossMastery.GetShopDisplayName(a1))),
                Color = if not a2 then u78 else u83,
                Image = a1.Icon,
            })
        end

        local function requestPurchase(a1, a2) -- Line: 128
            -- upvalues: u25 (ref), u22 (val), Remotes (upval), Toast (upval), u78 (upval), showResult (val)
            if u25 then
                return
            end
            u25 = true
            for i, j in u22 do
                j.SetPending(true)
            end
            local success, err, v1 = pcall(function() -- Line: 136 -- upvalues: Remotes (upval), a1 (val)
                return Remotes.BossMastery.AskBuyShopItem:InvokeServer(a1.Id)
            end)
            u25 = false
            for k, n in u22 do
                n.SetPending(false)
            end
            if not success then
                Toast.Show({
                    Text = "Something went wrong, please try again.",
                    Seconds = 2.5,
                    SingleLine = true,
                    Color = u78,
                    Image = a1.Icon,
                })
                return
            end
            showResult(a1, err, v1)
        end

        local function rebuildCards() -- Line: 149
            -- upvalues: u21 (val), u22 (val), BossMastery (upval), BossShopProductCard (upval)
            -- upvalues: BossShopItemTemplate (val), ScrollingFrame (val), requestPurchase (val), u25 (ref)
            local v1
            u21:Clean()
            table.clear(u22)
            for i, j in BossMastery.GetShopProducts() do
                v1 = BossShopProductCard.New(BossShopItemTemplate, ScrollingFrame, j, i, requestPurchase)
                u22[j.Id] = v1
                u21:Add(v1.Destroy)
                v1.SetPending(u25)
            end
        end

        BossShopItemTemplate.Visible = false
        rebuildCards()
        Save.Await()
        local v2 = Save.Await()
        if v2 ~= nil then
            local BossTokens = v2.BossTokens
            if u85 then
                local Value = u85.Value
            end
            u80 = BossTokens
            u18:Clean()
            u85 = nil
            local v3 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
            Amount.Text = v3
        end
        v1:Add((Save.WatchFields("BossTokens", function() -- Line: 172 -- upvalues: refreshTokenBalance (val)
            refreshTokenBalance()
        end)))
        v1:Add((BossMasteryFlags.ShopPriceOverrides.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.ShopProductIds.Changed:Connect(rebuildCards)))
        v1:Add((BossMasteryFlags.CashBoosterDurationSeconds.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.SpeedBoostDurationSeconds.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.TreadmillBoostDurationSeconds.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.MutationConsumableSuccessPercent.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.CashBoosterMultiplier.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.TreadmillBoostMultiplier.Changed:Connect(refreshCards)))
        v1:Add((BossMasteryFlags.SpeedBoostMultiplier.Changed:Connect(refreshCards)))
        v1:Add((Tabs.Activated:Connect(function(a1) -- Line: 200
            -- upvalues: Save (upval), u85 (ref), u80 (ref), u18 (val), Amount (val), Simple (upval), Numbers (upval)
            -- upvalues: u22 (val)
            if a1 == "BossShop" then
                local v1 = Save.Await()
                if v1 ~= nil then
                    local BossTokens = v1.BossTokens
                    if u85 then
                        local Value = u85.Value
                    end
                    u80 = BossTokens
                    u18:Clean()
                    u85 = nil
                    local v2 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
                    Amount.Text = v2
                end
                for i, j in u22 do
                    j.Refresh()
                end
            end
        end)))
        return v1
    end,
}