-- Script path: ReplicatedStorage.Controllers.Game.Plots.OfflineMoney.OfflineMoneyInPlotUIController
-- Decompile time: 4.78 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local OFFLINE_ASSETS = Constants.OFFLINE_ASSETS
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 31
        -- upvalues: LocalPlayer (val), Trove (val), Simple (val), OFFLINE_ASSETS (val), AssetRoster (val), Save (val)
        -- upvalues: AssetItems (val), Player (val), HiddenUIHandler (val), AdminBoosts (val), PlotState (val)
        -- upvalues: RunService (val)
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        assert(PlayerGui:IsA("PlayerGui"), "Expected PlayerGui")
        local OfflineMoneyInPlot = PlayerGui:WaitForChild("OfflineMoneyInPlot")
        assert(OfflineMoneyInPlot:IsA("ScreenGui"), "OfflineMoneyInPlot must be a ScreenGui")
        local v1 = OfflineMoneyInPlot:WaitForChild("TopBar")
        assert(v1:IsA("GuiObject"), "OfflineMoneyInPlot.TopBar must be a GuiObject")
        local InPlot = v1:WaitForChild("InPlot")
        assert(InPlot:IsA("GuiObject"), "OfflineMoneyInPlot.TopBar.InPlot must be a GuiObject")
        local u50 = InPlot:WaitForChild("TextLabel")
        assert(u50:IsA("TextLabel"), "OfflineMoneyInPlot.TopBar.InPlot.TextLabel must be a TextLabel")
        local v2 = Trove.new()
        local u61 = 0
        local updateVisibility = nil

        local function formatOfflineAmount(a1) -- Line: 52 -- upvalues: Simple (upval) -- types: a1: number
            return Simple.FormatCompact((math.max(a1, 0)))
        end

        local function getOfflinePreviewAmountFromTotalRate(a1) -- Line: 56
            -- upvalues: OFFLINE_ASSETS (upval)
            return (math.max(a1, 0)) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER
        end

        local function updateText() -- Line: 62
            -- upvalues: u50 (val), formatOfflineAmount (val), u61 (ref), OFFLINE_ASSETS (upval)
            u50.RichText = true
            u50.Text = string.format(
                "You earn <font color = \"#00ff00\">$%s</font>/Day offline! 😈",
                formatOfflineAmount((math.max(u61, 0)) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER)
            )
        end

        local function isWorldPositionInsideScaledPetAreaXZ(a1) -- Line: 70
            -- upvalues: AssetRoster (upval), LocalPlayer (upval)
            local v1 = AssetRoster.FindPenArea(LocalPlayer)
            if v1 == nil then
                return false
            end
            local v2 = v1.CFrame:PointToObjectSpace(a1)
            local v3 = v1.Size.X * 0.74 * 0.5
            local v4 = v1.Size.Z * 0.74 * 0.5
            local v5 = false
            if math.abs(v2.X) <= v3 then
                v5 = math.abs(v2.Z) <= v4
            end
            return v5
        end

        local function refreshRateFromSave() -- Line: 83
            -- upvalues: Save (upval), u61 (ref), AssetItems (upval), LocalPlayer (upval), u50 (val)
            -- upvalues: formatOfflineAmount (val), OFFLINE_ASSETS (upval), updateVisibility (ref)
            local v1 = Save.Await()
            u61 = if v1 == nil then 0 else AssetItems.ProfileIncomePerSecond(LocalPlayer, v1)
            u50.RichText = true
            u50.Text = string.format(
                "You earn <font color = \"#00ff00\">$%s</font>/Day offline! 😈",
                formatOfflineAmount((math.max(u61, 0)) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER)
            )
            updateVisibility()
        end

        function updateVisibility() -- Line: 92
            -- upvalues: Player (upval), LocalPlayer (upval), HiddenUIHandler (upval), u61 (ref)
            -- upvalues: isWorldPositionInsideScaledPetAreaXZ (val), OfflineMoneyInPlot (val)
            local v1 = Player.FindRootPart(LocalPlayer)
            local v2 = not HiddenUIHandler.IsHidden()
            if v2 then
                v2 = false
                if u61 > 1000 then
                    v2 = false
                    if v1 ~= nil then
                        v2 = isWorldPositionInsideScaledPetAreaXZ(v1.Position)
                    end
                end
            end
            OfflineMoneyInPlot.Enabled = v2
        end

        u50.RichText = true
        OfflineMoneyInPlot.Enabled = false
        local v3 = Save.Await()
        u61 = if v3 == nil then 0 else AssetItems.ProfileIncomePerSecond(LocalPlayer, v3)
        u50.RichText = true
        u50.Text = string.format(
            "You earn <font color = \"#00ff00\">$%s</font>/Day offline! 😈",
            formatOfflineAmount((math.max(u61, 0)) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER)
        )
        updateVisibility()
        updateVisibility()
        v2:Add((Save.WatchFields({"EquippedAssets", "Inventory", "Gamepasses", "Products"}, refreshRateFromSave)))
        v2:Add((AdminBoosts.Observe(AdminBoosts.EARNINGS):Connect(refreshRateFromSave)))
        v2:Add((Save.Loaded:Connect(function(a1) -- Line: 117
            -- upvalues: LocalPlayer (upval), Save (upval), u61 (ref), AssetItems (upval), u50 (val)
            -- upvalues: formatOfflineAmount (val), OFFLINE_ASSETS (upval), updateVisibility (ref)
            if a1 == LocalPlayer then
                local v1 = Save.Await()
                u61 = if v1 == nil then 0 else AssetItems.ProfileIncomePerSecond(LocalPlayer, v1)
                u50.RichText = true
                u50.Text = string.format(
                    "You earn <font color = \"#00ff00\">$%s</font>/Day offline! 😈",
                    formatOfflineAmount((math.max(u61, 0)) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER)
                )
                updateVisibility()
            end
        end)))
        v2:Add((PlotState.LocalPlotChanged:Connect(updateVisibility)))
        v2:Connect(RunService.Heartbeat, updateVisibility)
    end,
}