-- Script path: ReplicatedStorage.Controllers.GUI.TreadmillUpgradeController
-- Decompile time: 5.13 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Client.Types.GUI)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Products = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Client = require(script.Client)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u60 = Color3.new(0.760784, 0, 0)
local u61 = nil
local u62 = 0
return {
    Start = function() -- Line: 30
        -- upvalues: u62 (ref), u61 (ref), PlotState (val), Trove (val), Save (val), Client (val), u60 (val)
        -- upvalues: Simple (val), Products (val), CashPacks (val), Players (val), MonetizationEntitlements (val)
        -- upvalues: ButtonFX (val)
        local function bindLocalPlot() -- Line: 35
            -- upvalues: u62 (upval), u61 (upval), PlotState (upval), Trove (upval), Save (upval), Client (upval)
            -- upvalues: u60 (upval), Simple (upval), Products (upval), CashPacks (upval), Players (upval)
            -- upvalues: MonetizationEntitlements (upval), ButtonFX (upval)
            u62 = u62 + 1
            local u2 = u62
            if u61 ~= nil then
                u61:Destroy()
                u61 = nil
            end
            local v1 = PlotState.ResolvePlot()
            if v1 == nil then
                return
            end
            local PlotFolder = v1.PlotFolder
            assert(PlotFolder:IsA("Model"), "Local plot folder must be a Model")
            v1 = PlotFolder:WaitForChild("TreadmillUpgrade")
            assert(v1:IsA("Model"), "TreadmillUpgrade must be a Model")
            local Sign = v1.Sign
            assert(Sign:IsA("BasePart"), "TreadmillUpgrade.Sign must be a BasePart")
            local CanUpgrade = Sign.CanUpgrade
            assert(CanUpgrade:IsA("BillboardGui"), "TreadmillUpgrade.Sign.CanUpgrade must be a BillboardGui")
            local SurfaceGui = Sign.SurfaceGui
            assert(SurfaceGui:IsA("SurfaceGui"), "TreadmillUpgrade.Sign.SurfaceGui must be a SurfaceGui")
            local Level = SurfaceGui.Level
            assert(Level:IsA("TextLabel"), "TreadmillUpgrade.Sign.SurfaceGui.Level must be a TextLabel")
            local Frame = SurfaceGui.Frame
            assert(Frame:IsA("GuiObject"), "TreadmillUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")
            local Upgrade = Frame.Upgrade
            assert(Upgrade:IsA("GuiButton"), "Treadmill Upgrade must be a GuiButton")
            local RobuxUpgrade = Frame.RobuxUpgrade
            assert(RobuxUpgrade:IsA("GuiButton"), "Treadmill RobuxUpgrade must be a GuiButton")
            local Cost = Upgrade.Cost
            assert(Cost:IsA("TextLabel"), "Treadmill Upgrade.Cost must be a TextLabel")
            local Cost_2 = RobuxUpgrade.Cost
            assert(Cost_2:IsA("TextLabel"), "Treadmill RobuxUpgrade.Cost must be a TextLabel")
            local BackgroundColor3 = Upgrade.BackgroundColor3
            local UIGradient = Upgrade:FindFirstChildOfClass("UIGradient")
            local Enabled = false
            if UIGradient ~= nil then
                Enabled = UIGradient.Enabled
            end
            local u113 = Trove.new()
            u61 = u113
            u113:Add(function() -- Line: 101 -- upvalues: Upgrade (val), BackgroundColor3 (val), UIGradient (val), Enabled (val)
                Upgrade.BackgroundColor3 = BackgroundColor3
                if UIGradient ~= nil then
                    UIGradient.Enabled = Enabled
                end
            end)

            local function refresh() -- Line: 107
                -- upvalues: Save (upval), Client (upval), CanUpgrade (val), Upgrade (val), BackgroundColor3 (val)
                -- upvalues: u60 (upval), UIGradient (val), Enabled (val), Level (val), Cost (val), RobuxUpgrade (val)
                -- upvalues: Simple (upval), Products (upval), CashPacks (upval), Players (upval), Cost_2 (val)
                -- upvalues: MonetizationEntitlements (upval), u2 (val), u62 (upval), u61 (upval), u113 (val)
                local v1 = Save.Await()
                assert(v1 ~= nil, "Treadmill upgrade UI requires loaded data")
                local v2, v3 = Client.GetNextConfig(v1)
                local v4 = Client.CanAffordNext(v1)
                local v5 = false
                if 0 < v1.BaseUpgradeLevel then
                    v5 = v4
                end
                CanUpgrade.Enabled = v5
                Upgrade.BackgroundColor3 = if not v4 then u60 else BackgroundColor3
                if UIGradient ~= nil then
                    UIGradient.Enabled = v4 and Enabled
                end
                if v3 == nil then
                    Level.Text = "Level MAX"
                    Cost.Text = "MAX"
                    RobuxUpgrade.Visible = false
                    return
                end
                Level.Text = ("Level %* > Level %*"):format(v1.TreadmillUpgradeLevel, v2)
                Cost.Text = "$" .. Simple.FormatCompact(v3.Price, ".#")
                local ProductId = v3.ProductId
                v5 = false
                if ProductId ~= nil then
                    v5 = false
                    if Products.FromProductId(ProductId) ~= nil then
                        v5 = CashPacks.GetCanBuyProduct(CashPacks.GetPlayerGroup(Players.LocalPlayer), "Treadmill_" .. v3._id)
                    end
                end
                RobuxUpgrade.Visible = v5
                Cost_2.Text = ""
                if ProductId ~= nil and RobuxUpgrade.Visible then
                    task.spawn(function() -- Line: 141
                        -- upvalues: MonetizationEntitlements (upval), ProductId (val), u2 (upval), u62 (upval)
                        -- upvalues: u61 (upval), u113 (upval), Cost_2 (upval), Simple (upval)
                        local v1 = MonetizationEntitlements.ProductPrice(ProductId)
                        if u2 == u62 and u61 == u113 and v1 > 0 then
                            Cost_2.Text = (" %*"):format((Simple.FormatCompact(v1, ".#")))
                        end
                    end)
                end
            end

            u113:Add((ButtonFX(Upgrade, 1.05, Client.RequestCashUpgrade)))
            u113:Add((ButtonFX(RobuxUpgrade, 1.05, Client.PromptRobuxUpgrade)))
            u113:Add((Save.Watch("TreadmillUpgradeLevel"):Connect(refresh)))
            u113:Add((Save.Watch("BaseUpgradeLevel"):Connect(refresh)))
            u113:Add((Save.Watch("Money"):Connect(refresh)))
            u113:Connect(Players.LocalPlayer:GetAttributeChangedSignal(CashPacks.RevisionAttribute), refresh)
            refresh()
        end

        Save.Await()
        bindLocalPlot()
        PlotState.LocalPlotChanged:Connect(bindLocalPlot)
    end,
}