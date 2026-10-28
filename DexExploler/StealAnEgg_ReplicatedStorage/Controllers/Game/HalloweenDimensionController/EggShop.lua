-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.EggShop
-- Decompile time: 4.86 ms

local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local HalloweenDimensionEgg = require(ReplicatedStorage.Data.HalloweenDimensionEgg)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
require(ReplicatedStorage.Packages.Trove)
local u63 = Color3.fromRGB(255, 64, 64)
local u69 = Color3.fromRGB(80, 255, 120)
local u70 = false
local v1 = {}

local function formatChance(a1) -- Line: 35 -- types: a1: number
    if a1 >= 1 then
        return (("%*%%"):format((math.round(a1 * 10)) / 10))
    end
    return (("%*%%"):format((tonumber((string.format("%.3g", a1))))))
end

local function populate(a1) -- Line: 42 -- upvalues: HalloweenDimensionEgg (val), Assets (val), Numbers (val)
    local Amount, v1, v2
    local HalloweenEgg = a1.Content.Cards.HalloweenEgg
    local Entries = HalloweenDimensionEgg.Entries
    local v3 = nil
    local v4 = nil
    for i, j in Entries, v3, v4 do
        v2 = HalloweenEgg.ItemChances:FindFirstChild((tostring(i)))
        v1 = ("ItemChances has no slot %*"):format(i)
        assert(v2 ~= nil, v1)
        v2.Icon.Image = Assets.Directory[j.AssetId].Icon
        Amount = v2.Amount
        v1 = HalloweenDimensionEgg.Chance(j)
        Amount.Text = if not (v1 >= 1) then ("%*%%"):format((tonumber((string.format("%.3g", v1))))) else ("%*%%"):format((math.round(v1 * 10)) / 10)
    end
    assert(HalloweenEgg.ItemChances:FindFirstChild((tostring(#Entries + 1))) == nil, "ItemChances has more slots than the egg has pets")
    HalloweenEgg.EggName.Text = string.upper(HalloweenDimensionEgg.DisplayName)
    v5.Content.Btns.Buy.PriceHolder.Price.Text = Numbers.AddCommas(HalloweenDimensionEgg.Price)
end

local function refreshTokens(a1) -- Line: 59 -- upvalues: Save (val), Numbers (val) -- types: a1: userdata
    local v1 = Save.Peek()
    a1.Text = Numbers.AddCommas(if v1 == nil then 0 else v1.HalloweenTokens)
end

local function buy() -- Line: 64
    -- upvalues: u70 (ref), Remotes (val), Toast (val), HalloweenDimensionEgg (val), u69 (val), u63 (val)
    if u70 then
        return
    end
    u70 = true
    local success, err, v1 = pcall(function() -- Line: 69 -- upvalues: Remotes (upval)
        return Remotes.HalloweenDimension.AskBuyEgg:InvokeServer()
    end)
    u70 = false
    local v2 = success and err == true
    Toast.Show({
        Seconds = 2.5,
        SingleLine = true,
        Text = if not v2 then if not success then "Something went wrong, please try again." else if typeof(v1) ~= "string" then "Something went wrong, please try again." else v1 else ("Purchased a %*!"):format(HalloweenDimensionEgg.DisplayName),
        Color = if not v2 then u63 else u69,
    })
end

function v1.Start(a1) -- Line: 89
    -- upvalues: GUI (val), populate (val), Save (val), Numbers (val), ButtonFX (val), buy (val), Tabs (val)
    -- upvalues: ProximityPromptService (val), HalloweenDimension (val)
    local Main = GUI.Get("HalloweenDimensionEggUI").Main
    local QuantityLabel = Main.CurrencyHolder.QuantityLabel
    populate(Main)
    local v1 = Save.Peek()
    QuantityLabel.Text = Numbers.AddCommas(if v1 == nil then 0 else v1.HalloweenTokens)
    a1:Add((ButtonFX(Main.Content.Btns.Buy, 1.08, function() -- Line: 95 -- upvalues: buy (upval)
        task.spawn(buy)
    end)))
    a1:Add((Save.WatchFields("HalloweenTokens", function() -- Line: 98 -- upvalues: QuantityLabel (val), Save (upval), Numbers (upval)
        local v1 = Save.Peek()
        QuantityLabel.Text = Numbers.AddCommas(if v1 == nil then 0 else v1.HalloweenTokens)
    end)))
    a1:Connect(Tabs.Activated, function(a1) -- Line: 101 -- upvalues: QuantityLabel (val), Save (upval), Numbers (upval) -- types: a1: string
        if a1 == "HalloweenDimensionEggUI" then
            local v1 = Save.Peek()
            QuantityLabel.Text = Numbers.AddCommas(if v1 == nil then 0 else v1.HalloweenTokens)
        end
    end)
    a1:Connect(ProximityPromptService.PromptTriggered, function(a1) -- Line: 106 -- upvalues: HalloweenDimension (upval), Tabs (upval) -- types: a1: userdata
        if a1:HasTag(HalloweenDimension.EggShopTag) then
            Tabs.Activate("HalloweenDimensionEggUI")
        end
    end)
end

return (table.freeze(v1))