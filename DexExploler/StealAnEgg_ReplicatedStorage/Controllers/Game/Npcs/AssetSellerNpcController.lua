-- Script path: ReplicatedStorage.Controllers.Game.Npcs.AssetSellerNpcController
-- Decompile time: 8.55 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Message = require(ReplicatedStorage.Client.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local Log = require(ReplicatedStorage.Packages.Log)
local u81 = Color3.fromRGB(0, 255, 8):ToHex()
local u89 = Color3.fromRGB(255, 170, 0):ToHex()
local u97 = Color3.fromRGB(207, 58, 255):ToHex()
return {
    Start = function() -- Line: 45
        -- upvalues: Workspace (val), Players (val), Log (val), Save (val), TryCall (val), AssetItems (val)
        -- upvalues: EggRecords (val), u81 (val), Simple (val), Message (val), Assets (val), u97 (val), Remotes (val)
        -- upvalues: Audio (val), u89 (val), Streamable (val)
        local Stands = Workspace.Stands
        assert(Stands:IsA("Folder"), "Workspace.Stands must be a Folder")
        local Prompts = Stands.Prompts
        assert(Prompts:IsA("Folder"), "Workspace.Stands.Prompts must be a Folder")
        local LocalPlayer = Players.LocalPlayer
        local u21 = Log.new()

        local function getInventoryItemData(a1) -- Line: 61
            -- upvalues: Save (upval), TryCall (upval), AssetItems (upval), u21 (val)
            local v1 = Save.Await()
            local Inventory = v1 and v1.Inventory
            if not Inventory then
                return nil
            end
            v1 = Inventory[a1]
            if not v1 then
                return nil
            end
            local v2, v3 = TryCall(AssetItems.Decode, v1)
            if v2 then
                return v3
            end
            ;(u21:AtDebug()):Log((("Skipped invalid seller inventory item %*"):format(a1)))
            return nil
        end

        local function isEquipped(a1) -- Line: 82 -- upvalues: Save (upval) -- types: a1: string
            local v1 = Save.Await()
            local v2 = false
            if v1 ~= nil then
                v2 = table.find(v1.EquippedAssets, a1) ~= nil
            end
            return v2
        end

        local function computeItemValue(a1) -- Line: 87 -- upvalues: AssetItems (upval), LocalPlayer (val)
            local v1 = AssetItems.SalePrice(a1)
            if LocalPlayer:GetAttribute("VIP") then
                v1 = v1 * 2
            end
            return v1
        end

        local function getEggItemData(a1) -- Line: 97 -- upvalues: Save (upval), EggRecords (upval) -- types: a1: string
            local v1 = Save.Await()
            local EggInventory = v1 and v1.EggInventory
            if EggInventory == nil then
                return nil, nil, nil
            end
            v1 = EggInventory[a1]
            if v1 ~= nil and v1.Placement == nil then
                local v2 = EggRecords.Decode(v1)
                return (EggRecords.ToAssetItemData(v2)), (EggRecords.SellPrice(v2)), EggRecords.DisplayNameWithWeight(v2)
            end
            return nil, nil, nil
        end

        local function formatPrice(a1) -- Line: 115 -- upvalues: u81 (upval), Simple (upval) -- types: a1: number
            return string.format("<font color='#%s'>$%s</font>", u81, Simple.FormatCompact(a1, "."))
        end

        local function promptSellHeld() -- Line: 123
            -- upvalues: LocalPlayer (val), Message (upval), getEggItemData (val), getInventoryItemData (val)
            -- upvalues: Save (upval), Assets (upval), AssetItems (upval), u97 (upval), formatPrice (val)
            -- upvalues: Remotes (upval), Audio (upval)
            local Character = LocalPlayer.Character
            if not Character then
                Message.Notice("No item equipped.")
                return
            end
            local Tool = Character:FindFirstChildWhichIsA("Tool")
            local v1 = if not Tool then nil else Tool:GetAttribute("UID")
            if Tool ~= nil and type(v1) == "string" then
                local v2, v3, v4
                local v5 = nil
                local Attribute = Tool:GetAttribute("ItemType")
                if Attribute == "AssetEgg" then
                    v2, v3, v4 = getEggItemData(v1)
                    if v2 ~= nil and v3 ~= nil and v4 ~= nil then
                        v5 = {
                            isFavorite = false,
                            kind = "egg",
                            displayName = v4,
                            itemData = v2,
                            price = v3,
                            uid = v1,
                        }
                    end
                elseif Attribute == "Asset" then
                    local v6 = getInventoryItemData(v1)
                    if v6 ~= nil then
                        v3 = Save.Await()
                        v2 = false
                        if v3 ~= nil then
                            v2 = table.find(v3.EquippedAssets, v1) ~= nil
                        end
                        if not v2 and not v6.InFuse then
                            v2 = Assets.Directory[v6.Category]
                            v3 = {kind = "pet"}
                            local DisplayName = v2.DisplayName or v6.Category
                            v3.displayName = DisplayName
                            v3.isFavorite = v6.IsFavorite == true
                            v3.itemData = v6
                            v4 = AssetItems.SalePrice(v6)
                            if LocalPlayer:GetAttribute("VIP") then
                                v4 = v4 * 2
                            end
                            v3.price = v4
                            v3.uid = v1
                            v5 = v3
                        end
                    end
                end
                if v5 == nil then
                    Message.Notice("No item equipped.")
                    return
                end
                if v5.isFavorite then
                    local v7 = string.format("<font color='#%s'>favorited</font>", u97)
                    Message.Notice(string.format("You can't sell %s items.", v7))
                    return
                end
                local itemData = v5.itemData
                v2 = string.format(
                    "Would you like to sell %s <font color='#%s'>%s</font> for %s?",
                    v5.kind,
                    Assets.Directory[itemData.Category].Rarity.Color:ToHex(),
                    v5.displayName,
                    formatPrice(v5.price)
                )
                if Message.Confirm(v2) then
                    Remotes.PetSatchel.SellPet:FireServer({v5.uid})
                    Audio.Chime("Prompt")
                end
                return
            end
            Message.Notice("No item equipped.")
        end

        local function getSellableInventory() -- Line: 195
            -- upvalues: Save (upval), TryCall (upval), AssetItems (upval)
            local v1, v2, v3
            local v4 = {}
            local v5 = Save.Await()
            local Inventory = v5 and v5.Inventory
            if not Inventory then
                return v4
            end
            for k, v in pairs(Inventory) do
                v2, v3 = TryCall(AssetItems.Decode, v)
                if v2 and v3.IsFavorite ~= true then
                    v5 = Save.Await()
                    v1 = false
                    if v5 ~= nil then
                        v1 = table.find(v5.EquippedAssets, k) ~= nil
                    end
                    if not v1 and not v3.InFuse then
                        table.insert(v4, {uid = k, itemData = v3})
                    end
                end
            end
            return v4
        end

        local function promptSellAll() -- Line: 213
            -- upvalues: getSellableInventory (val), Message (upval), AssetItems (upval), LocalPlayer (val), u89 (upval)
            -- upvalues: formatPrice (val), Remotes (upval), Audio (upval)
            local itemData, v1
            local v2 = getSellableInventory()
            if #v2 == 0 then
                Message.Notice("You don't have any pets in your inventory.")
                return
            end
            local v3 = 0
            local v4 = {}
            for i, v in ipairs(v2) do
                itemData = v.itemData
                v1 = AssetItems.SalePrice(itemData)
                if LocalPlayer:GetAttribute("VIP") then
                    v1 = v1 * 2
                end
                v3 = v3 + v1
                table.insert(v4, v.uid)
            end
            local v5 = string.format("Would you like to sell <font color='#%s'>%d pets</font> for %s?", u89, #v2, formatPrice(v3))
            if Message.Confirm(v5) then
                Remotes.PetSatchel.SellEveryPet:FireServer(v4)
                Audio.Chime("Prompt")
            end
        end

        local function bindPrompt(a1, a2) -- Line: 241
            -- upvalues: Streamable (upval), Prompts (val)
            (Streamable.new(Prompts, a1)):Observe(function(a1, a2) -- Line: 243 -- upvalues: Streamable (upval) -- types: a1: userdata
                local u6 = Streamable.new(a1, "ProximityPrompt")
                a2:Add(function() -- Line: 245 -- upvalues: u6 (val)
                    u6:Destroy()
                end)
                a2:Add((u6:Observe(function(a1, a2) -- Line: 246 -- types: a1: userdata
                    a1.Enabled = false
                end)))
            end)
        end

        ;(Streamable.new(Prompts, "SellHeldAsset")):Observe(function(a1, a2) -- Line: 243 -- upvalues: Streamable (upval) -- types: a1: userdata
            local u6 = Streamable.new(a1, "ProximityPrompt")
            a2:Add(function() -- Line: 245 -- upvalues: u6 (val)
                u6:Destroy()
            end)
            a2:Add((u6:Observe(function(a1, a2) -- Line: 246 -- types: a1: userdata
                a1.Enabled = false
            end)))
        end)
        ;(Streamable.new(Prompts, "SellAll")):Observe(function(a1, a2) -- Line: 243 -- upvalues: Streamable (upval) -- types: a1: userdata
            local u6 = Streamable.new(a1, "ProximityPrompt")
            a2:Add(function() -- Line: 245 -- upvalues: u6 (val)
                u6:Destroy()
            end)
            a2:Add((u6:Observe(function(a1, a2) -- Line: 246 -- types: a1: userdata
                a1.Enabled = false
            end)))
        end)
    end,
}