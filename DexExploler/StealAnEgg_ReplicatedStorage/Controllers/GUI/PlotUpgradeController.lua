-- Script path: ReplicatedStorage.Controllers.GUI.PlotUpgradeController
-- Decompile time: 6.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Client.Types.GUI)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local PlotUpgradeVisibility = require(ReplicatedStorage.Client.PlotUpgradeVisibility)
require(ReplicatedStorage.Data.Products)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u68 = Color3.new(0.760784, 0, 0)
local u75 = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
return {
    Start = function() -- Line: 36
        -- upvalues: ReplicatedStorage (val), Products (val), PlotUpgradeVisibility (val), PlotState (val), Trove (val)
        -- upvalues: EnsureUIScale (val), TweenService (val), u75 (val), Save (val), BaseUpgrade (val), u68 (val)
        -- upvalues: Simple (val), ButtonFX (val), Storefront (val)
        local PlotUpgrade = ReplicatedStorage.Assets.UI.PlotUpgrade
        local FirstUpgradeInfo = PlotUpgrade.FirstUpgradeInfo
        assert(FirstUpgradeInfo:IsA("Frame"), "PlotUpgrade.FirstUpgradeInfo template must be a Frame")
        local FirstUpgrade = PlotUpgrade.FirstUpgrade
        assert(FirstUpgrade:IsA("ImageButton"), "PlotUpgrade.FirstUpgrade template must be an ImageButton")
        local u20 = nil
        local u21 = nil
        local u22 = nil

        local function getProductForLevel(a1) -- Line: 57 -- upvalues: Products (upval) -- types: a1: number
            local v1 = ("BaseUpgradeTier%*"):format(a1)
            if Products.ProductNameExists(v1) then
                return Products.Directory[v1]
            end
            return nil
        end

        local function refreshPlotUpgradeVisibility() -- Line: 63 -- upvalues: PlotUpgradeVisibility (upval)
            PlotUpgradeVisibility.Apply("PlotUpgrade")
        end

        local function bindLocalPlot() -- Line: 65
            -- upvalues: u20 (ref), PlotState (upval), u21 (ref), u22 (ref), Trove (upval), FirstUpgradeInfo (val)
            -- upvalues: FirstUpgrade (val), EnsureUIScale (upval), TweenService (upval), u75 (upval), Save (upval)
            -- upvalues: BaseUpgrade (upval), u68 (upval), Simple (upval), ButtonFX (upval), Products (upval)
            -- upvalues: Storefront (upval)
            if u20 ~= nil then
                u20:Destroy()
                u20 = nil
            end
            local v1 = PlotState.ResolvePlot()
            if v1 == nil then
                return
            end
            local PlotFolder = v1.PlotFolder
            assert(PlotFolder:IsA("Model"), "Local plot folder must be a Model")
            v1 = PlotFolder:WaitForChild("PlotUpgrade")
            assert(v1:IsA("Model"), "PlotUpgrade must be a Model")
            local Sign = v1.Sign
            assert(Sign:IsA("BasePart"), "PlotUpgrade.Sign must be a BasePart")
            local CanUpgrade = Sign.CanUpgrade
            assert(CanUpgrade:IsA("BillboardGui"), "PlotUpgrade.Sign.CanUpgrade must be a BillboardGui")
            local SurfaceGui = Sign.SurfaceGui
            assert(SurfaceGui:IsA("SurfaceGui"), "PlotUpgrade.Sign.SurfaceGui must be a SurfaceGui")
            local Info = SurfaceGui.Info
            assert(Info:IsA("TextLabel"), "PlotUpgrade.Sign.SurfaceGui.Info must be a TextLabel")
            local Level = SurfaceGui.Level
            assert(Level:IsA("TextLabel"), "PlotUpgrade.Sign.SurfaceGui.Level must be a TextLabel")
            local Frame = SurfaceGui.Frame
            assert(Frame:IsA("GuiObject"), "PlotUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")
            local Upgrade = Frame.Upgrade
            assert(Upgrade:IsA("GuiButton"), "Plot Upgrade must be a GuiButton")
            local RobuxUpgrade = Frame.RobuxUpgrade
            assert(RobuxUpgrade:IsA("GuiButton"), "Plot RobuxUpgrade must be a GuiButton")
            local Cost = Upgrade.Cost
            assert(Cost:IsA("TextLabel"), "Plot Upgrade.Cost must be a TextLabel")
            local UIGradient = Upgrade:FindFirstChildOfClass("UIGradient")
            if u21 == nil then
                u21 = Upgrade.BackgroundColor3
            end
            if UIGradient ~= nil and u22 == nil then
                u22 = UIGradient.Enabled
            end
            local u113 = assert(u21, "Plot Upgrade authored background color must be initialized")
            Upgrade.AutoButtonColor = false
            local v2 = Trove.new()
            local u123 = FirstUpgradeInfo:Clone()
            local Icon = u123.Icon
            assert(Icon:IsA("ImageLabel"), "Plot FirstUpgradeInfo.Icon must be an ImageLabel")
            local u135 = FirstUpgrade:Clone()
            local Cost_2 = u135.Cost
            assert(Cost_2:IsA("TextLabel"), "Plot FirstUpgrade.Cost must be a TextLabel")
            local ProgressFill = u135.ProgressFill
            assert(ProgressFill:IsA("Frame"), "Plot FirstUpgrade.ProgressFill must be a Frame")
            local UIGradient_2 = u135.UIGradient
            assert(UIGradient_2:IsA("UIGradient"), "Plot FirstUpgrade button gradient must be a UIGradient")
            local BackgroundColor3 = u135.BackgroundColor3
            local Enabled = UIGradient_2.Enabled
            local Size = ProgressFill.Size
            u123.Visible = false
            u123.Parent = SurfaceGui
            v2:Add(u123)
            local v3 = EnsureUIScale(Icon)
            v3.Scale = 0.8
            local v4 = TweenService:Create(v3, u75, {Scale = 1.3})
            v2:Add(v4)
            v4:Play()
            u135.Visible = false
            u135.AutoButtonColor = false
            u135.Parent = Frame
            v2:Add(u135)
            u20 = v2

            local function refresh() -- Line: 145
                -- upvalues: Save (upval), Info (val), Level (val), u123 (val), Upgrade (val), u135 (val)
                -- upvalues: BaseUpgrade (upval), CanUpgrade (val), u113 (val), u68 (upval), UIGradient (val)
                -- upvalues: u22 (upval), BackgroundColor3 (val), UIGradient_2 (val), Enabled (val), Cost (val)
                -- upvalues: RobuxUpgrade (val), Simple (upval), Cost_2 (val), ProgressFill (val), Size (val)
                local v1
                local v2 = Save.Await()
                assert(v2 ~= nil, "Plot upgrade UI requires loaded data")
                Info.Visible = not (v2.BaseUpgradeLevel == 0)
                Level.Visible = not v1
                u123.Visible = v1
                Upgrade.Visible = not v1
                u135.Visible = v1
                local v3, v4 = BaseUpgrade.ResolveNextTier(v2)
                v1 = BaseUpgrade.IsNextTierAffordable(v2)
                CanUpgrade.Enabled = v1
                Upgrade.BackgroundColor3 = if not v1 then u68 else u113
                if UIGradient ~= nil then
                    UIGradient.Enabled = v1 and u22 == true
                end
                u135.BackgroundColor3 = if not v1 then u68 else BackgroundColor3
                UIGradient_2.Enabled = v1 and Enabled
                if v3 ~= nil and v4 ~= nil then
                    Level.Text = ("Level %* > Level %*"):format(v2.BaseUpgradeLevel, v3)
                    v3 = "$" .. Simple.FormatCompact(v4.Cost, ".#")
                    Cost.Text = v3
                    Cost_2.Text = v3
                    assert(0 < v4.Cost, "Plot upgrade cost must be positive")
                    ProgressFill.Size = UDim2.new(math.clamp(v2.Money / v4.Cost, 0, 1), Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
                    RobuxUpgrade.Visible = false
                    return
                end
                Level.Text = "Level MAX"
                Cost.Text = "MAX"
                RobuxUpgrade.Visible = false
            end

            v2:Add((ButtonFX(Upgrade, 1.05, BaseUpgrade.PurchaseNextTier)))
            v2:Add((ButtonFX(u135, 1.05, BaseUpgrade.PurchaseNextTier)))
            v2:Add((ButtonFX(RobuxUpgrade, 1.05, function() -- Line: 203 -- upvalues: Save (upval), BaseUpgrade (upval), Products (upval), Storefront (upval)
                local v1 = Save.Await()
                assert(v1 ~= nil, "Plot Robux upgrade requires loaded data")
                local v2, v3 = BaseUpgrade.ResolveNextTier(v1)
                if v2 ~= nil and v3 ~= nil then
                    v1 = ("BaseUpgradeTier%*"):format(v2)
                    v3 = if not Products.ProductNameExists(v1) then nil else Products.Directory[v1]
                    if v3 ~= nil then
                        Storefront.Prompt(v3.ProductId, true)
                    end
                    return
                end
            end)))
            v2:Add((Save.Watch("BaseUpgradeLevel"):Connect(refresh)))
            v2:Add((Save.Watch("Money"):Connect(refresh)))
            refresh()
        end

        Save.Await()
        bindLocalPlot()
        PlotUpgradeVisibility.Apply("PlotUpgrade")
        PlotState.LocalPlotChanged:Connect(function() -- Line: 227 -- upvalues: bindLocalPlot (val), PlotUpgradeVisibility (upval)
            bindLocalPlot()
            PlotUpgradeVisibility.Apply("PlotUpgrade")
        end)
        PlotState.PlotChanged:Connect(refreshPlotUpgradeVisibility)
        PlotState.FolderChanged:Connect(refreshPlotUpgradeVisibility)
    end,
}