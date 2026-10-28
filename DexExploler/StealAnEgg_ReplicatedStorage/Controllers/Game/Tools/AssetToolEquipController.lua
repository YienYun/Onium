-- Script path: ReplicatedStorage.Controllers.Game.Tools.AssetToolEquipController
-- Decompile time: 6.33 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetPlacementHints = require(script.Parent.Parent.Plots.ActiveAssetsController.AssetPlacementHints)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u44 = Color3.fromRGB(85, 255, 85)
local u49 = Color3.fromRGB(255, 70, 70)
local LocalPlayer = Players.LocalPlayer
local u53 = Trove.new()
local u55 = Trove.new()
local u56 = nil
local u57 = nil
return {
    Start = function() -- Line: 31
        -- upvalues: Toast (val), u49 (val), Assets (val), u44 (val), u57 (ref), Player (val), LocalPlayer (val)
        -- upvalues: AssetRoster (val), AssetPlacementHints (val), u56 (ref), u55 (val), u53 (val)
        local function isAssetTool(a1) -- Line: 36 -- types: a1: userdata
            return a1:GetAttribute("ItemType") == "Asset"
        end

        local function getAssetToolUid(a1) -- Line: 38 -- types: a1: userdata
            local Attribute = a1:GetAttribute("UID")
            if typeof(Attribute) == "string" and Attribute ~= "" then
                return Attribute
            end
            return nil
        end

        local function getAssetToolCategory(a1) -- Line: 43 -- types: a1: userdata
            local Attribute = a1:GetAttribute("Category")
            if typeof(Attribute) == "string" and Attribute ~= "" then
                return Attribute
            end
            return nil
        end

        local function isNearPetAreaSurface(a1, a2) -- Line: 48 -- types: a1: userdata, a2: vector
            local v1 = a1.CFrame:PointToObjectSpace(a2)
            local v2 = a1.Size * 0.5
            return (a2 - a1.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))).Magnitude <= 20
        end

        local function showGetCloserNotification() -- Line: 61 -- upvalues: Toast (upval), u49 (upval)
            Toast.Show({Text = "Get closer to your Pen to place pets!", Seconds = 2, Color = u49})
        end

        local function showEquipSuccessNotification(a1) -- Line: 69
            -- upvalues: Assets (upval), Toast (upval), u44 (upval)
            local v1
            local Attribute = a1:GetAttribute("Category")
            if (if typeof(Attribute) ~= "string" then nil else if Attribute == "" then nil else Attribute) == nil then
                return
            end
            local v2 = Assets.Directory[v1]
            local DisplayName = if v2.DisplayName == "" then v1 else v2.DisplayName
            local Color = if not v2.Rarity then Color3.new(1, 1, 1) else v2.Rarity.Color
            Toast.Show({
                Seconds = 2,
                Text = ("Sucessfully equipped <font color=\"#%*\">%*!</font>"):format(Color:ToHex(), DisplayName),
                Color = u44,
            })
        end

        local function showEquipErrorNotification(a1) -- Line: 85
            -- upvalues: Toast (upval), u49 (upval)
            Toast.Show({Seconds = 2, Text = a1, Color = u49})
        end

        local function tryEquipToolAsset(a1) -- Line: 93
            -- upvalues: u57 (upval), Player (upval), LocalPlayer (upval), AssetRoster (upval)
            -- upvalues: isNearPetAreaSurface (val), Toast (upval), u49 (upval), AssetPlacementHints (upval)
            -- upvalues: u56 (upval), showEquipSuccessNotification (val), u55 (upval)
            local Attribute = a1:GetAttribute("UID")
            local v1 = if typeof(Attribute) ~= "string" then nil else if Attribute == "" then nil else Attribute
            if v1 ~= nil and u57 ~= v1 then
                local v2 = Player.FindRootPart(LocalPlayer)
                if v2 ~= nil and not v2:IsA("BasePart") then
                    return
                end
                local v3 = AssetRoster.FindPenArea(LocalPlayer)
                if v2 ~= nil and v3 ~= nil then
                    if not isNearPetAreaSurface(v3, v2.Position) then
                        Toast.Show({Text = "Get closer to your Pen to place pets!", Seconds = 2, Color = u49})
                        return
                    end
                    u57 = v1
                    AssetPlacementHints.SetFrontPlacement(v1, v2.CFrame)
                    local v4, v5 = AssetRoster.WearAsset(v1)
                    if u57 == v1 then
                        u57 = nil
                    end
                    if not v4 then
                        AssetPlacementHints.ClearFrontPlacement(v1)
                        if v5 ~= nil then
                            Toast.Show({Seconds = 2, Text = v5, Color = u49})
                        end
                    end
                    if v4 and u56 == a1 then
                        showEquipSuccessNotification(a1)
                        u55:Clean()
                        u56 = nil
                    end
                    return
                end
                return
            end
        end

        local function bindTool(a1) -- Line: 133
            -- upvalues: u55 (upval), u56 (upval), tryEquipToolAsset (val)
            u55:Clean()
            u56 = a1
            u55:Connect(a1.Activated, function() -- Line: 136 -- upvalues: tryEquipToolAsset (upval), a1 (val)
                tryEquipToolAsset(a1)
            end)
        end

        local function refreshCharacter(a1) -- Line: 139
            -- upvalues: u55 (upval), u56 (upval), tryEquipToolAsset (val)
            u55:Clean()
            u56 = nil
            local Tool = a1:FindFirstChildOfClass("Tool")
            if Tool ~= nil and Tool:GetAttribute("ItemType") == "Asset" then
                u55:Clean()
                u56 = Tool
                u55:Connect(Tool.Activated, function() -- Line: 136 -- upvalues: tryEquipToolAsset (upval), Tool (val)
                    tryEquipToolAsset(Tool)
                end)
            end
        end

        local function bindCharacter(a1) -- Line: 148
            -- upvalues: u53 (upval), u55 (upval), u56 (upval), tryEquipToolAsset (val)
            u53:Clean()
            u55:Clean()
            u56 = nil
            local Tool = a1:FindFirstChildOfClass("Tool")
            if Tool ~= nil and Tool:GetAttribute("ItemType") == "Asset" then
                u55:Clean()
                u56 = Tool
                u55:Connect(Tool.Activated, function() -- Line: 136 -- upvalues: tryEquipToolAsset (upval), Tool (val)
                    tryEquipToolAsset(Tool)
                end)
            end
            u53:Connect(a1.ChildAdded, function(a1) -- Line: 152 -- upvalues: u55 (upval), u56 (upval), tryEquipToolAsset (upval) -- types: a1: userdata
                if a1:IsA("Tool") and a1:GetAttribute("ItemType") == "Asset" then
                    u55:Clean()
                    u56 = a1
                    u55:Connect(a1.Activated, function() -- Line: 136 -- upvalues: tryEquipToolAsset (upval), a1 (val)
                        tryEquipToolAsset(a1)
                    end)
                end
            end)
            u53:Connect(a1.ChildRemoved, function(a1) -- Line: 158 -- upvalues: u56 (upval), u55 (upval) -- types: a1: userdata
                if a1 == u56 then
                    u55:Clean()
                    u56 = nil
                end
            end)
        end

        LocalPlayer.CharacterAdded:Connect(bindCharacter)
        LocalPlayer.CharacterRemoving:Connect(function() -- Line: 171 -- upvalues: u53 (upval), u55 (upval), u56 (upval), u57 (upval)
            u53:Clean()
            u55:Clean()
            u56 = nil
            u57 = nil
        end)
        if LocalPlayer.Character ~= nil then
            bindCharacter(LocalPlayer.Character)
        end
    end,
}