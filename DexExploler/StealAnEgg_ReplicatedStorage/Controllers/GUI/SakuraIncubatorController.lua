-- Script path: ReplicatedStorage.Controllers.GUI.SakuraIncubatorController
-- Decompile time: 44.90 ms

local ContextActionService = game:GetService("ContextActionService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
require(ReplicatedStorage.Shared.Globals.Constants)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
require(ReplicatedStorage.Shared.Types.Eggs)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Sakura_2 = require(ReplicatedStorage.Shared.Types.Sakura)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u141 = utf8.char(57346)
local u146 = Color3.fromRGB(255, 0, 0)
local u148 = Log.new()
local u151 = TryLock()
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 65
        -- upvalues: GUI (val), ReplicatedStorage (val), TweenService (val), Trove (val), Toast (val), u146 (val)
        -- upvalues: Save (val), SakuraBloomPolicy (val), Directory (val), Sakura (val), Products (val)
        -- upvalues: MarketplaceService (val), Mutations (val), Simple (val), u141 (val), u151 (val), Remotes (val)
        -- upvalues: EggRecords (val), ButtonFX (val), Message (val), Sakura_2 (val), u148 (val), SakuraSignals (val)
        -- upvalues: Storefront (val), UserInputService (val), Tabs (val), ContextActionService (val), Players (val)
        -- upvalues: PlatformController (val), ButtonHintStrip (val)
        local SakuraEggCharge = GUI.SakuraEggCharge().SakuraEggCharge
        assert(SakuraEggCharge:IsA("Frame"), "SakuraEggCharge.SakuraEggCharge must be a Frame")
        local Content = SakuraEggCharge.Content
        assert(Content:IsA("Frame"), "SakuraEggCharge.Content must be a Frame")
        local EggIconHolder = Content.EggIconHolder
        local Icon = EggIconHolder.Icon
        assert(Icon:IsA("ImageLabel"), "SakuraEggCharge EggIconHolder.Icon must be an ImageLabel")
        local Title = Icon.Title
        assert(Title:IsA("TextLabel"), "SakuraEggCharge EggIconHolder.Icon.Title must be a TextLabel")
        local Mutate = Content.Mutate
        assert(Mutate:IsA("ImageButton"), "SakuraEggCharge.Content.Mutate must be an ImageButton")
        local Deposit = Content.Deposit
        assert(Deposit:IsA("ImageButton"), "SakuraEggCharge.Content.Deposit must be an ImageButton")

        local function optionalGui(a1, a2, a3) -- Line: 80 -- types: a1: userdata, a2: string, a3: string
            local v1 = a1:FindFirstChild(a2, true)
            if v1 and v1:IsA(a3) then
                return v1
            end
            return nil
        end

        local RemoveEgg = SakuraEggCharge:FindFirstChild("RemoveEgg", true)
        local u63 = if not RemoveEgg then nil else if not RemoveEgg:IsA("GuiButton") then nil else RemoveEgg
        local Help = SakuraEggCharge:FindFirstChild("Help", true)
        local v1 = if not Help then nil else if not Help:IsA("GuiButton") then nil else Help
        local CostLabel = SakuraEggCharge:FindFirstChild("CostLabel", true)
        local u89 = if not CostLabel then nil else if not CostLabel:IsA("TextLabel") then nil else CostLabel
        local CrystalBalance = SakuraEggCharge:FindFirstChild("CrystalBalance", true)
        local u102 = if not CrystalBalance then nil else if not CrystalBalance:IsA("TextLabel") then nil else CrystalBalance
        local SliderBar = Content.SliderBar
        local Fill = SliderBar.Progress.Fill
        assert(Fill:IsA("Frame"), "SakuraEggCharge SliderBar.Progress.Fill must be a Frame")
        local SliderButton = SliderBar.SliderButton
        assert(SliderButton:IsA("ImageButton"), "SakuraEggCharge SliderBar.SliderButton must be an ImageButton")
        local ProgressBar = Content.ProgressBar
        local ImageLabel = ProgressBar.Frame1.ImageLabel
        assert(ImageLabel:IsA("ImageLabel"), "SakuraEggCharge ProgressBar.Frame1.ImageLabel must be an ImageLabel")
        local UIGradient = ImageLabel.UIGradient
        assert(UIGradient:IsA("UIGradient"), "SakuraEggCharge ProgressBar.Frame1.ImageLabel.UIGradient must be a UIGradient")
        local ImageLabel_2 = ProgressBar.Frame2.ImageLabel
        assert(ImageLabel_2:IsA("ImageLabel"), "SakuraEggCharge ProgressBar.Frame2.ImageLabel must be an ImageLabel")
        local UIGradient_2 = ImageLabel_2.UIGradient
        assert(UIGradient_2:IsA("UIGradient"), "SakuraEggCharge ProgressBar.Frame2.ImageLabel.UIGradient must be a UIGradient")
        UIGradient.Enabled = true
        UIGradient_2.Enabled = true
        local SliderButton_2 = ProgressBar.SliderButton
        assert(SliderButton_2:IsA("ImageButton"), "SakuraEggCharge ProgressBar.SliderButton must be an ImageButton")
        local CurrentChargeLabel = Content.CurrentChargeHolder.CurrentChargeLabel
        assert(CurrentChargeLabel:IsA("TextLabel"), "SakuraEggCharge CurrentChargeLabel must be a TextLabel")
        local SidePopUp = SakuraEggCharge.SidePopUp
        local MutationList = SidePopUp.MutationList
        assert(MutationList:IsA("ScrollingFrame"), "SakuraEggCharge SidePopUp.MutationList must be a ScrollingFrame")
        local BuyLuck = SidePopUp.BuyLuck
        assert(BuyLuck:IsA("ImageButton"), "SakuraEggCharge SidePopUp.BuyLuck must be an ImageButton")
        local Price = BuyLuck.Price
        assert(Price:IsA("TextLabel"), "SakuraEggCharge BuyLuck.Price must be a TextLabel")
        local TextLabel = BuyLuck.TextLabel
        assert(TextLabel:IsA("TextLabel"), "SakuraEggCharge BuyLuck.TextLabel must be a TextLabel")
        local EggPicker = SakuraEggCharge.EggPicker
        assert(EggPicker:IsA("Frame"), "SakuraEggCharge.EggPicker must be a Frame")
        local Eggs = EggPicker.Eggs
        assert(Eggs:IsA("ScrollingFrame"), "SakuraEggCharge EggPicker.Eggs must be a ScrollingFrame")
        local InventoryTemplate = (((ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("GUI")):WaitForChild("BackpackController")):WaitForChild("Main")):WaitForChild("InventoryTemplate")
        assert(InventoryTemplate:IsA("GuiButton"), "BackpackController.Main.InventoryTemplate must be a GuiButton")
        local u745 = nil
        local u746 = nil
        for i, v in ipairs(Deposit:GetChildren()) do
            if v:IsA("TextLabel") then
                if not v.Text:find("Deposit") then
                    u746 = v
                else
                    u745 = v
                end
            end
        end
        assert(u745 and u746, "SakuraEggCharge Deposit button needs its two TextLabels")
        local LockedOverlay = Mutate.LockedOverlay
        assert(LockedOverlay:IsA("Frame"), "SakuraEggCharge Mutate.LockedOverlay must be a Frame")
        local TextLabel_2 = Mutate:FindFirstChildOfClass("TextLabel")
        assert(TextLabel_2, "SakuraEggCharge Mutate button needs its ready TextLabel")
        local u709 = nil
        for i2, i3 in ipairs(LockedOverlay:GetChildren()) do
            if i3:IsA("TextLabel") and i3.Text ~= "Mutate" then
                u709 = i3
            end
        end
        assert(u709, "SakuraEggCharge Mutate.LockedOverlay needs its unlock TextLabel")
        local u329 = {}
        for i4, j in ipairs(MutationList:GetChildren()) do
            if j:IsA("Frame") and j:FindFirstChild("MutationName") then
                table.insert(u329, j)
            end
        end
        table.sort(u329, function(a1, a2) -- Line: 192
            return a1.AbsolutePosition.Y < a2.AbsolutePosition.Y
        end)
        assert(#u329 >= 2, "SakuraEggCharge MutationList needs two mutation rows")
        local ImageColor3 = Icon.ImageColor3
        local ImageLabel_3 = Instance.new("ImageLabel")
        ImageLabel_3.Name = "ClickIndicator"
        ImageLabel_3.Image = "rbxassetid://96606025304766"
        ImageLabel_3.BackgroundTransparency = 1
        ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel_3.Position = UDim2.fromScale(0.8, 0.8)
        ImageLabel_3.Size = UDim2.fromScale(0.45, 0.45)
        ImageLabel_3.ZIndex = Icon.ZIndex + 2
        ImageLabel_3.Visible = false
        Instance.new("UIAspectRatioConstraint").Parent = ImageLabel_3
        local UIScale = Instance.new("UIScale")
        UIScale.Parent = ImageLabel_3
        ImageLabel_3.Parent = Icon
        local u400 = TweenService:Create(UIScale, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {Scale = 1.3})

        local function setClickIndicator(a1) -- Line: 222
            -- upvalues: ImageLabel_3 (val), UIScale (val), u400 (val)
            if ImageLabel_3.Visible == a1 then
                return
            end
            ImageLabel_3.Visible = a1
            if not a1 then
                u400:Cancel()
                return
            end
            UIScale.Scale = 1
            u400:Play()
        end

        local BackgroundColor3 = Mutate.BackgroundColor3
        local u413 = BackgroundColor3:Lerp(Color3.new(0, 0, 0), 0.45)
        local BackgroundColor3_2 = Deposit.BackgroundColor3
        local u425 = BackgroundColor3_2:Lerp(Color3.new(0, 0, 0), 0.45)
        local u428 = Trove.new()
        local u429 = 1
        local u430 = false
        local u431 = false
        local u432 = true
        local u433 = {}

        local function notifyError(a1) -- Line: 250 -- upvalues: Toast (upval), u146 (upval) -- types: a1: string
            Toast.Show({Seconds = 3, Text = a1, Color = u146})
        end

        local function getState() -- Line: 258 -- upvalues: Save (upval)
            local v1 = Save.Await()
            if v1 == nil then
                return nil, 0
            end
            return v1.Sakura, v1.SakuraCrystals
        end

        local function isUnlocked() -- Line: 266 -- upvalues: Save (upval), SakuraBloomPolicy (upval)
            local v1 = Save.IsLoaded()
            return SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
        end

        local function getRarityNumber(a1) -- Line: 272 -- upvalues: Directory (upval) -- types: a1: string
            local v1 = Directory[a1]
            local v2 = ("Missing asset config %*"):format(a1)
            assert(v1 ~= nil, v2)
            return v1.Rarity.Rank
        end

        local function getRequired(a1) -- Line: 278 -- upvalues: Sakura (upval)
            if a1.Egg == false then
                return 0
            end
            return Sakura.GetRequiredCrystals()
        end

        local function getDepositCapacity(a1, a2) -- Line: 285 -- upvalues: Sakura (upval) -- types: a2: number
            local v1
            if (if a1.Egg ~= false then Sakura.GetRequiredCrystals() else 0) <= 0 then
                return 0
            end
            return (math.max(0, (math.min(a2, (Sakura.GetFreeChargeCap(v1)) - a1.Deposited))))
        end

        local function getSliderAmount(a1, a2) -- Line: 293 -- upvalues: Sakura (upval), u429 (ref) -- types: a2: number
            local v1
            local v2 = if a1.Egg ~= false then Sakura.GetRequiredCrystals() else 0
            if (if not (v2 <= 0) then math.max(0, (math.min(a2, (Sakura.GetFreeChargeCap(v2)) - a1.Deposited))) else 0) <= 0 then
                return 0
            end
            return (math.max(1, (math.floor(v1 * u429 + 0.5))))
        end

        local u443 = NumberSequence.new(1)
        local u446 = NumberSequence.new(0)

        local function applyArcCut(a1, a2, a3, a4) -- Line: 305
            -- upvalues: u443 (val), u446 (val)
            local AbsoluteSize = a2.AbsoluteSize
            local v1 = Vector2.new(math.cos((math.rad(a4))), (math.sin((math.rad(a4)))))
            local v2 = AbsoluteSize.X * math.abs(v1.X) + AbsoluteSize.Y * math.abs(v1.Y)
            if v2 <= 0 then
                return
            end
            local v3 = 0.5 + (a3 - (a2.AbsolutePosition + AbsoluteSize / 2)):Dot(v1) / v2
            a1.Rotation = a4
            if v3 <= 0.001 then
                a1.Transparency = u443
                return
            end
            if v3 >= 1 then
                a1.Transparency = u446
                return
            end
            a1.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(v3 - 0.001, 0),
                NumberSequenceKeypoint.new(v3, 1),
                (NumberSequenceKeypoint.new(1, 1)),
            })
        end

        local function setArc(a1) -- Line: 333
            -- upvalues: Sakura (upval), SliderButton_2 (val), ProgressBar (val), UIGradient (val), u443 (val)
            -- upvalues: applyArcCut (val), ImageLabel (val), UIGradient_2 (val), u446 (val), ImageLabel_2 (val)
            local v1 = math.clamp(a1 / Sakura.Incubator.MaxChargePercent, 0, 1)
            local v2 = 3.4173546754048973 - v1 * 3.693116697220001
            SliderButton_2.Position = UDim2.fromScale(math.cos(v2) * 0.473 + 0.5, 0.7587 - math.sin(v2) * 0.7207)
            local AbsoluteSize = ProgressBar.AbsoluteSize
            local v3 = math.deg((math.atan2(0.7207 * AbsoluteSize.Y * math.sin(v2), 0.473 * AbsoluteSize.X * (math.cos(v2)))))
            if v3 < -90 then
                v3 = v3 + 360
            end
            v2 = 90 - v3
            v3 = ProgressBar.AbsolutePosition + Vector2.new(0.5 * AbsoluteSize.X, 0.7587 * AbsoluteSize.Y)
            if not (v1 <= 0) then
                applyArcCut(UIGradient, ImageLabel, v3, (math.clamp(v2, -180, 0)))
            else
                UIGradient.Transparency = u443
            end
            if v1 >= 1 then
                UIGradient_2.Transparency = u446
                return
            end
            applyArcCut(UIGradient_2, ImageLabel_2, v3, (math.clamp(v2, 0, 180)))
        end

        local NumberValue = Instance.new("NumberValue")
        local u464 = nil
        NumberValue.Changed:Connect(function(a1) -- Line: 365 -- upvalues: setArc (val), CurrentChargeLabel (val) -- types: a1: number
            setArc(a1)
            CurrentChargeLabel.Text = ("%*%%"):format((math.floor(a1 + 0.5)))
        end)

        local function showCharge(a1, a2) -- Line: 370
            -- upvalues: u464 (ref), NumberValue (val), setArc (val), CurrentChargeLabel (val), TweenService (upval)
            if u464 then
                u464:Cancel()
                u464 = nil
            end
            if not a2 then
                local v1 = math.abs(NumberValue.Value - a1)
                if not (v1 < 0.01) then
                    v1 = TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Value = a1})
                    u464 = v1
                    v1:Play()
                    return
                end
            end
            NumberValue.Value = a1
            setArc(a1)
            CurrentChargeLabel.Text = ("%*%%"):format((math.floor(a1 + 0.5)))
        end

        local function setSlider(a1) -- Line: 390
            -- upvalues: u429 (ref), Fill (val), SliderButton (val)
            u429 = math.clamp(a1, 0, 1)
            Fill.Size = UDim2.fromScale(u429, 1)
            SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
        end

        local scheduleRender = nil

        local function getProductPrice(a1) -- Line: 398
            -- upvalues: Products (upval), u433 (val), MarketplaceService (upval), scheduleRender (ref)
            local u3 = Products.Directory[a1]
            local v1 = u433[u3.ProductId]
            if v1 then
                return v1
            end
            task.spawn(function() -- Line: 404 -- upvalues: MarketplaceService (upval), u3 (val), u433 (upval), scheduleRender (upval)
                local success, err = pcall(MarketplaceService.GetProductInfo, MarketplaceService, u3.ProductId, Enum.InfoType.Product)
                if success and err and err.PriceInRobux then
                    u433[u3.ProductId] = err.PriceInRobux
                    scheduleRender()
                end
            end)
            return nil
        end

        local function renderEggIcon(a1) -- Line: 419
            -- upvalues: Icon (val), ImageColor3 (val), Title (val), ImageLabel_3 (val), UIScale (val), u400 (val)
            -- upvalues: Directory (upval)
            local Egg = a1.Egg
            if Egg == false then
                Icon.Image = "rbxassetid://111633736515788"
                Icon.ImageColor3 = ImageColor3
                Title.Visible = true
                if ImageLabel_3.Visible == true then
                    return
                end
                ImageLabel_3.Visible = true
                UIScale.Scale = 1
                u400:Play()
                return
            end
            local v1 = Directory[Egg.Egg.AssetCategory]
            local v2 = ("Missing asset config %*"):format(Egg.Egg.AssetCategory)
            assert(v1 ~= nil, v2)
            Icon.Image = v1.Egg.Icon
            Icon.ImageColor3 = Color3.new(1, 1, 1)
            Title.Visible = false
            if ImageLabel_3.Visible == false then
                return
            end
            ImageLabel_3.Visible = false
            u400:Cancel()
        end

        local function renderMutationRows(a1, a2) -- Line: 436
            -- upvalues: Sakura (upval), u329 (val), Mutations (upval)
            local ChanceLabel, MutationName, v1
            for i, v in ipairs({
                {
                    Name = Sakura.MutationName,
                    Chance = Sakura.GetEffectiveMutationChance(a1, a2),
                },
                {
                    Name = Sakura.SpecialMutationName,
                    Chance = Sakura.GetSpecialChance(a1, a2),
                },
            }) do
                v1 = u329[i]
                MutationName = v1.MutationName
                ChanceLabel = v1.ChanceLabel
                assert(MutationName:IsA("TextLabel") and ChanceLabel:IsA("TextLabel"), "Mutation row needs MutationName and ChanceLabel")
                v1 = Mutations.Get(v.Name)
                MutationName.Text = Mutations.LabelOf(v.Name)
                if v1 then
                    MutationName.TextColor3 = v1.Tint
                end
                ChanceLabel.Text = (string.format("%.1f%%", v.Chance)):gsub("%.0%%", "%%")
            end
        end

        local function renderCost() -- Line: 464 -- upvalues: Simple (upval), Sakura (upval), u89 (val)
            local v1 = ("Mutation Cost: <font color=\"#FF69B4\">%* crystals</font>"):format((Simple.FormatCompact((Sakura.GetRequiredCrystals()))))
            if u89 then
                u89.Text = v1
            end
        end

        local function render() -- Line: 473
            -- upvalues: Save (upval), Sakura (upval), renderEggIcon (val), showCharge (val), u432 (ref), u102 (val)
            -- upvalues: Simple (upval), u63 (val), u89 (val), renderMutationRows (val), u429 (ref), SliderBar (val)
            -- upvalues: Deposit (val), BackgroundColor3_2 (val), u745 (ref), u746 (ref), u425 (val), Mutate (val)
            -- upvalues: BackgroundColor3 (val), u413 (val), LockedOverlay (val), TextLabel_2 (val), u709 (ref)
            -- upvalues: BuyLuck (val), TextLabel (val), Products (upval), u433 (val), MarketplaceService (upval)
            -- upvalues: scheduleRender (ref), Price (val), u141 (upval)
            local SakuraCrystals, Sakura_2
            local v1 = Save.Await()
            if v1 ~= nil then
                Sakura_2 = v1.Sakura
                SakuraCrystals = v1.SakuraCrystals
            else
                Sakura_2 = nil
                SakuraCrystals = 0
            end
            if Sakura_2 == nil then
                return
            end
            local Egg = Sakura_2.Egg
            local v2 = if Sakura_2.Egg ~= false then Sakura.GetRequiredCrystals() else 0
            local v3 = Sakura.GetChargePercent(Sakura_2.Deposited, v2)
            local v4 = Egg ~= false
            v1 = v3 >= 100
            local v5 = if Sakura_2.Egg ~= false then Sakura.GetRequiredCrystals() else 0
            local v6 = if not (v5 <= 0) then math.max(0, (math.min(SakuraCrystals, (Sakura.GetFreeChargeCap(v5)) - Sakura_2.Deposited))) else 0
            v5 = v4
            if v5 then
                local Deposited_2 = Sakura_2.Deposited
                v5 = Sakura.GetFreeChargeCap(v2) <= Deposited_2
            end
            renderEggIcon(Sakura_2)
            showCharge(v3, u432)
            u432 = false
            if u102 then
                u102.Text = ("You have <font color=\"#FF69B4\">%*</font> crystals"):format((Simple.FormatCompact(SakuraCrystals)))
            end
            if u63 then
                u63.Visible = v4
            end
            local v7 = ("Mutation Cost: <font color=\"#FF69B4\">%* crystals</font>"):format((Simple.FormatCompact((Sakura.GetRequiredCrystals()))))
            if u89 then
                u89.Text = v7
            end
            renderMutationRows(v3, Sakura_2.LuckBoost)
            local v8 = if Sakura_2.Egg ~= false then Sakura.GetRequiredCrystals() else 0
            v7 = if not (v8 <= 0) then math.max(0, (math.min(SakuraCrystals, (Sakura.GetFreeChargeCap(v8)) - Sakura_2.Deposited))) else 0
            v3 = if not (v7 <= 0) then math.max(1, (math.floor(v7 * u429 + 0.5))) else 0
            SliderBar.Visible = v4 and v6 > 0
            if not v4 then
                if v4 then
                    Deposit.Active = false
                    Deposit.BackgroundColor3 = u425
                    u745.Text = if not v5 then "No Crystals" else "Fully Charged"
                    u746.Text = ""
                else
                    Deposit.Active = true
                    Deposit.BackgroundColor3 = BackgroundColor3_2
                    u745.Text = "Place Egg"
                    u746.Text = "Choose an egg to mutate"
                end
            elseif v3 > 0 then
                Deposit.Active = true
                Deposit.BackgroundColor3 = BackgroundColor3_2
                u745.Text = ("Deposit %*"):format((Simple.FormatCompact(v3)))
                u746.Text = ("+%*%% Charge"):format((math.floor(v3 / v2 * 100 + 0.5)))
            elseif v4 then
                Deposit.Active = false
                Deposit.BackgroundColor3 = u425
                u745.Text = if not v5 then "No Crystals" else "Fully Charged"
                u746.Text = ""
            else
                Deposit.Active = true
                Deposit.BackgroundColor3 = BackgroundColor3_2
                u745.Text = "Place Egg"
                u746.Text = "Choose an egg to mutate"
            end
            Mutate.Active = v1
            Mutate.BackgroundColor3 = if not v1 then u413 else BackgroundColor3
            LockedOverlay.Visible = not v1
            TextLabel_2.Visible = v1
            u709.Text = "(Unlocks at 100%)"
            local MaxLuckBoosts = Sakura.Incubator.MaxLuckBoosts
            BuyLuck.Visible = v4 and Sakura_2.LuckBoost < MaxLuckBoosts
            TextLabel.Text = ("<font color=\"#FF69B4\">%*x</font> Great Bloom Odds (%*/%*)"):format(
                Sakura.GetLuckMultiplier(Sakura_2.LuckBoost + 1),
                Sakura_2.LuckBoost,
                MaxLuckBoosts
            )
            v5 = Sakura.Incubator.LuckBoostProductNames[Sakura_2.LuckBoost + 1]
            if not v5 then
                v6 = nil
            else
                local u315 = Products.Directory[v5]
                v3 = u433[u315.ProductId]
                if not v3 then
                    task.spawn(function() -- Line: 404 -- upvalues: MarketplaceService (upval), u315 (val), u433 (upval), scheduleRender (upval)
                        local success, err = pcall(MarketplaceService.GetProductInfo, MarketplaceService, u315.ProductId, Enum.InfoType.Product)
                        if success and err and err.PriceInRobux then
                            u433[u315.ProductId] = err.PriceInRobux
                            scheduleRender()
                        end
                    end)
                    v6 = nil
                else
                    v6 = v3
                end
            end
            Price.Text = if not v6 then "" else ("%*%*"):format(u141, v6)
        end

        function scheduleRender() -- Line: 535 -- upvalues: u431 (ref), render (val)
            if u431 then
                return
            end
            u431 = true
            task.defer(function() -- Line: 540 -- upvalues: u431 (upval), render (upval)
                u431 = false
                render()
            end)
        end

        local function closePicker() -- Line: 546 -- upvalues: u428 (val), EggPicker (val)
            u428:Clean()
            EggPicker.Visible = false
        end

        local function requestInsert(a1) -- Line: 551
            -- upvalues: u151 (upval), Remotes (upval), Toast (upval), u146 (upval), u428 (val), EggPicker (val)
            -- upvalues: u429 (ref), Fill (val), SliderButton (val), scheduleRender (ref)
            u151(function() -- Line: 552
                -- upvalues: Remotes (upval), a1 (val), Toast (upval), u146 (upval), u428 (upval), EggPicker (upval)
                -- upvalues: u429 (upval), Fill (upval), SliderButton (upval), scheduleRender (upval)
                local v1, v2 = Remotes.Bloomery.AskLoadEgg:InvokeServer(a1)
                if not v1 then
                    local v3 = if typeof(v2) ~= "string" then "Failed to place egg" else v2
                    Toast.Show({Seconds = 3, Text = v3, Color = u146})
                    return
                end
                u428:Clean()
                EggPicker.Visible = false
                u429 = 1
                Fill.Size = UDim2.fromScale(u429, 1)
                SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
                scheduleRender()
            end)
        end

        local function buildPickerRow(a1, a2, a3) -- Line: 564
            -- upvalues: EggRecords (upval), Directory (upval), InventoryTemplate (val), Eggs (val), u428 (val)
            -- upvalues: u151 (upval), Remotes (upval), Toast (upval), u146 (upval), EggPicker (val), u429 (ref)
            -- upvalues: Fill (val), SliderButton (val), scheduleRender (ref), ButtonFX (upval)
            local v1
            local v2 = EggRecords.Decode(a2)
            local v3 = Directory[v2.AssetCategory]
            local v4 = ("Missing asset config %*"):format(v2.AssetCategory)
            assert(v3 ~= nil, v4)
            local v5 = InventoryTemplate:Clone()
            v5.Name = ("SakuraEgg.%*"):format(a1)
            v5.LayoutOrder = a3
            v5.Active = true
            v5.AutoButtonColor = false
            v5.BackgroundColor3 = Color3.new(0, 0, 0)
            v5.BackgroundTransparency = 0.5
            v5.Visible = true
            local UIStroke = v5:FindFirstChild("UIStroke")
            if UIStroke and UIStroke:IsA("UIStroke") then
                UIStroke.Thickness = 0
            end
            local Icon = v5.Icon
            assert(Icon:IsA("ImageLabel"), "Inventory row Icon must be an ImageLabel")
            Icon.Image = v3.Egg.Icon
            Icon.ImageColor3 = Color3.new(1, 1, 1)
            local ToolName = v5.ToolName
            assert(ToolName:IsA("TextLabel"), "Inventory row ToolName must be a TextLabel")
            for i, v in ipairs(ToolName:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
            v3.Rarity.RarityGradient:Clone().Parent = ToolName
            ToolName.Text = EggRecords.DisplayNameWithWeight(v2)
            ToolName.Visible = true
            for i2, i3 in ipairs({"FavIcon", "Weight", "Shadow", "Shadow_2"}) do
                v1 = v5:FindFirstChild(i3)
                if v1 and v1:IsA("GuiObject") then
                    v1.Visible = false
                end
            end
            v3 = v5:FindFirstChild("BaseTemplate")
            if v3 then
                for i4, j in ipairs(v3:GetChildren()) do
                    if j:IsA("GuiObject") then
                        j.Visible = false
                    end
                end
            end
            v5.Parent = Eggs
            u428:Add(v5)
            u428:Add((v5.Activated:Connect(function() -- Line: 615
                -- upvalues: a1 (val), u151 (upval), Remotes (upval), Toast (upval), u146 (upval), u428 (upval)
                -- upvalues: EggPicker (upval), u429 (upval), Fill (upval), SliderButton (upval), scheduleRender (upval)
                local u0 = a1
                u151(function() -- Line: 552
                    -- upvalues: Remotes (upval), u0 (val), Toast (upval), u146 (upval), u428 (upval), EggPicker (upval)
                    -- upvalues: u429 (upval), Fill (upval), SliderButton (upval), scheduleRender (upval)
                    local v1, v2 = Remotes.Bloomery.AskLoadEgg:InvokeServer(u0)
                    if not v1 then
                        local v3 = if typeof(v2) ~= "string" then "Failed to place egg" else v2
                        Toast.Show({Seconds = 3, Text = v3, Color = u146})
                        return
                    end
                    u428:Clean()
                    EggPicker.Visible = false
                    u429 = 1
                    Fill.Size = UDim2.fromScale(u429, 1)
                    SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
                    scheduleRender()
                end)
            end)))
            ButtonFX(v5)
        end

        local function openPicker() -- Line: 619
            -- upvalues: Save (upval), Toast (upval), u146 (upval), u428 (val), Sakura (upval), Directory (upval)
            -- upvalues: buildPickerRow (val), Eggs (val), EggPicker (val)
            local Sakura_2
            local u2 = Save.Await()
            local v1 = Save.Await()
            if v1 ~= nil then
                Sakura_2 = v1.Sakura
                local SakuraCrystals = v1.SakuraCrystals
            else
                Sakura_2 = nil
            end
            if u2 ~= nil and Sakura_2 ~= nil then
                if not Sakura_2.Unlocked then
                    Toast.Show({Text = "The Sakura Incubator is still sealed", Seconds = 3, Color = u146})
                    return
                end
                if Sakura_2.Egg ~= false then
                    return
                end
                u428:Clean()
                local v2 = {}
                for k, v in pairs(u2.EggInventory) do
                    if v.Placement == nil and not Sakura.HasSakuraMutation(v.Mutations) then
                        table.insert(v2, k)
                    end
                end
                if #v2 ~= 0 then
                    local v3, v4
                    table.sort(v2, function(a1, a2) -- Line: 654 -- upvalues: u2 (val), Directory (upval)
                        local AssetCategory = u2.EggInventory[a1].AssetCategory
                        local v1 = Directory[AssetCategory]
                        local v2 = ("Missing asset config %*"):format(AssetCategory)
                        assert(v1 ~= nil, v2)
                        local Rank = v1.Rarity.Rank
                        local AssetCategory_2 = u2.EggInventory[a2].AssetCategory
                        local v3 = Directory[AssetCategory_2]
                        local v4 = ("Missing asset config %*"):format(AssetCategory_2)
                        assert(v3 ~= nil, v4)
                        local Rank_2 = v3.Rarity.Rank
                        if Rank ~= Rank_2 then
                            return Rank_2 < Rank
                        end
                        return a1 < a2
                    end)
                    for i, i2 in ipairs(v2) do
                        v3 = buildPickerRow
                        v4 = u2.EggInventory[i2]
                        v3(i2, v4, i)
                    end
                    Eggs.CanvasPosition = Vector2.zero
                    EggPicker.Visible = true
                    return
                end
                v1 = 0
                for k2, j in pairs(u2.EggInventory) do
                    if j.Placement ~= nil then
                        v1 = v1 + 1
                    end
                end
                if v1 > 0 then
                    Toast.Show({
                        Text = "All your eggs are placed - pick one up from your pen first!",
                        Seconds = 3,
                        Color = u146,
                    })
                    return
                end
                Toast.Show({
                    Text = "You have no eggs to mutate - steal or hatch one first!",
                    Seconds = 3,
                    Color = u146,
                })
                return
            end
        end

        local function playDepositFlyIn() -- Line: 669
            -- upvalues: EggIconHolder (val), Deposit (val), Content (val), TweenService (upval)
            local u0 = EggIconHolder
            for i = 1, 6 do
                task.delay((i - 1) * 0.05, function() -- Line: 672 -- upvalues: Deposit (upval), Content (upval), TweenService (upval), u0 (val)
                    local ImageLabel = Instance.new("ImageLabel")
                    ImageLabel.BackgroundTransparency = 1
                    ImageLabel.Image = "rbxassetid://71612969542341"
                    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    ImageLabel.Size = UDim2.fromScale(0.05, 0.08)
                    ImageLabel.Position = UDim2.fromScale(Deposit.Position.X.Scale + (math.random() - 0.5) * 0.1, Deposit.Position.Y.Scale)
                    ImageLabel.ZIndex = 20
                    ImageLabel.Parent = Content
                    local v1 = TweenService:Create(ImageLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Position = UDim2.fromScale(u0.Position.X.Scale, u0.Position.Y.Scale),
                        Size = UDim2.fromScale(0.02, 0.03),
                    })
                    v1.Completed:Once(function() -- Line: 692 -- upvalues: ImageLabel (val)
                        ImageLabel:Destroy()
                    end)
                    v1:Play()
                end)
            end
            task.wait(0.75)
        end

        local function updateSliderFromInput(a1) -- Line: 771
            -- upvalues: SliderBar (val), u429 (ref), Fill (val), SliderButton (val), render (val)
            local X = SliderBar.AbsolutePosition.X
            local X_2 = SliderBar.AbsoluteSize.X
            if X_2 <= 0 then
                return
            end
            u429 = math.clamp((a1.X - X) / X_2, 0, 1)
            Fill.Size = UDim2.fromScale(u429, 1)
            SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
            render()
        end

        EggPicker.Visible = false
        u429 = 1
        Fill.Size = UDim2.fromScale(u429, 1)
        SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
        GUI.OnActivated(Deposit, function() -- Line: 699
            -- upvalues: Save (upval), openPicker (val), u151 (upval), Sakura (upval), u429 (ref), Toast (upval)
            -- upvalues: u146 (upval), playDepositFlyIn (val), Remotes (upval), scheduleRender (ref)
            local Sakura_2
            local v1 = Save.Await()
            if v1 ~= nil then
                Sakura_2 = v1.Sakura
                local SakuraCrystals = v1.SakuraCrystals
            else
                Sakura_2 = nil
            end
            if Sakura_2 ~= nil and Sakura_2.Egg == false then
                openPicker()
                return
            end
            u151(function() -- Line: 705
                -- upvalues: Save (upval), Sakura (upval), u429 (upval), Toast (upval), u146 (upval)
                -- upvalues: playDepositFlyIn (upval), Remotes (upval), scheduleRender (upval)
                local SakuraCrystals, Sakura_2
                local v1 = Save.Await()
                if v1 ~= nil then
                    Sakura_2 = v1.Sakura
                    SakuraCrystals = v1.SakuraCrystals
                else
                    Sakura_2 = nil
                    SakuraCrystals = 0
                end
                if Sakura_2 ~= nil and Sakura_2.Egg ~= false then
                    local v2 = if Sakura_2.Egg ~= false then Sakura.GetRequiredCrystals() else 0
                    local v3 = if not (v2 <= 0) then math.max(0, (math.min(SakuraCrystals, (Sakura.GetFreeChargeCap(v2)) - Sakura_2.Deposited))) else 0
                    if (if not (v3 <= 0) then math.max(1, (math.floor(v3 * u429 + 0.5))) else 0) <= 0 then
                        Toast.Show({Text = "You have no Sakura Crystals to deposit", Seconds = 3, Color = u146})
                        return
                    end
                    playDepositFlyIn()
                    v3, v2 = Remotes.Bloomery.AskHandoff:InvokeServer(v1)
                    if v3 then
                        scheduleRender()
                        return
                    end
                    local v4 = if typeof(v2) ~= "string" then "Failed to deposit" else v2
                    Toast.Show({Seconds = 3, Text = v4, Color = u146})
                    return
                end
            end)
        end)
        ButtonFX(Deposit)
        GUI.OnActivated(Mutate, function() -- Line: 745
            -- upvalues: u151 (upval), Remotes (upval), Toast (upval), u146 (upval), Sakura_2 (upval), u148 (upval)
            -- upvalues: SakuraSignals (upval), scheduleRender (ref)
            u151(function() -- Line: 746
                -- upvalues: Remotes (upval), Toast (upval), u146 (upval), Sakura_2 (upval), u148 (upval)
                -- upvalues: SakuraSignals (upval), scheduleRender (upval)
                local v1, v2, v3 = Remotes.Bloomery.AskMutate:InvokeServer()
                if not v1 then
                    local v4 = if typeof(v2) ~= "string" then "Failed to mutate" else v2
                    Toast.Show({Seconds = 3, Text = v4, Color = u146})
                    return
                end
                if not Sakura_2.MutateResult(v3) then
                    u148:AtError():Log("Sakura mutate returned an invalid result")
                    return
                end
                SakuraSignals.Reveal:Fire(v3)
                scheduleRender()
            end)
        end)
        ButtonFX(Mutate)
        if u63 then
            u63.Visible = false
            GUI.OnActivated(u63, function() -- Line: 725
                -- upvalues: Save (upval), Message (upval), u151 (upval), Remotes (upval), Toast (upval), u146 (upval)
                -- upvalues: scheduleRender (ref)
                local Sakura
                local v1 = Save.Await()
                if v1 ~= nil then
                    Sakura = v1.Sakura
                    local SakuraCrystals = v1.SakuraCrystals
                else
                    Sakura = nil
                end
                if Sakura ~= nil and Sakura.Egg ~= false then
                    if not (0 < Sakura.Deposited) and not (0 < Sakura.LuckBoost) then
                        u151(function() -- Line: 735 -- upvalues: Remotes (upval), Toast (upval), u146 (upval), scheduleRender (upval)
                            local v1, v2 = Remotes.Bloomery.AskEjectEgg:InvokeServer()
                            if v1 then
                                scheduleRender()
                                return
                            end
                            local v3 = if typeof(v2) ~= "string" then "Failed to remove egg" else v2
                            Toast.Show({Seconds = 3, Text = v3, Color = u146})
                        end)
                        return
                    end
                    if not Message.Confirm("Remove this egg? Its charge and luck will be lost.") then
                        return
                    end
                    u151(function() -- Line: 735 -- upvalues: Remotes (upval), Toast (upval), u146 (upval), scheduleRender (upval)
                        local v1, v2 = Remotes.Bloomery.AskEjectEgg:InvokeServer()
                        if v1 then
                            scheduleRender()
                            return
                        end
                        local v3 = if typeof(v2) ~= "string" then "Failed to remove egg" else v2
                        Toast.Show({Seconds = 3, Text = v3, Color = u146})
                    end)
                    return
                end
            end)
            ButtonFX(u63)
        end
        GUI.OnActivated(BuyLuck, function() -- Line: 761 -- upvalues: Save (upval), Sakura (upval), Storefront (upval), Products (upval)
            local v1 = Save.Await()
            local v2 = v1 and Sakura.Incubator.LuckBoostProductNames[v1.Sakura.LuckBoost + 1]
            if not v2 then
                return
            end
            Storefront.Prompt(Products.Directory[v2].ProductId, true)
        end)
        ButtonFX(BuyLuck)
        Icon.Active = true
        Icon.InputBegan:Connect(function(a1) -- Line: 800 -- upvalues: openPicker (val) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.MouseButton1
                or a1.UserInputType == Enum.UserInputType.Touch then
                openPicker()
            end
        end)
        SliderButton.InputBegan:Connect(function(a1) -- Line: 809 -- upvalues: u430 (ref) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.MouseButton1
                or a1.UserInputType == Enum.UserInputType.Touch then
                u430 = true
            end
        end)
        SliderBar.InputBegan:Connect(function(a1) -- Line: 817
            -- upvalues: u430 (ref), SliderBar (val), u429 (ref), Fill (val), SliderButton (val), render (val)
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1
                and a1.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            u430 = true
            local v1 = Vector2.new(a1.Position.X, a1.Position.Y)
            local X = SliderBar.AbsolutePosition.X
            local X_2 = SliderBar.AbsoluteSize.X
            if X_2 <= 0 then
                return
            end
            u429 = math.clamp((v1.X - X) / X_2, 0, 1)
            Fill.Size = UDim2.fromScale(u429, 1)
            SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
            render()
        end)
        UserInputService.InputChanged:Connect(function(a1) -- Line: 826
            -- upvalues: u430 (ref), SliderBar (val), u429 (ref), Fill (val), SliderButton (val), render (val)
            if not u430 then
                return
            end
            if a1.UserInputType ~= Enum.UserInputType.MouseMovement
                and a1.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            local v1 = Vector2.new(a1.Position.X, a1.Position.Y)
            local X = SliderBar.AbsolutePosition.X
            local X_2 = SliderBar.AbsoluteSize.X
            if X_2 <= 0 then
                return
            end
            u429 = math.clamp((v1.X - X) / X_2, 0, 1)
            Fill.Size = UDim2.fromScale(u429, 1)
            SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
            render()
        end)
        UserInputService.InputEnded:Connect(function(a1) -- Line: 837 -- upvalues: u430 (ref) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.MouseButton1
                or a1.UserInputType == Enum.UserInputType.Touch then
                u430 = false
            end
        end)
        Save.WatchFields({"Sakura", "SakuraCrystals", "EggInventory"}, function() -- Line: 846 -- upvalues: Tabs (upval), Save (upval), SakuraBloomPolicy (upval), scheduleRender (ref)
            if Tabs.IsActive("SakuraEggCharge") then
                local v1 = Save.IsLoaded()
                local v2 = if not v1 then nil else Save.Peek()
                if SakuraBloomPolicy.HasBloomUnlocked(v1, v2) then
                    scheduleRender()
                    return
                end
                Tabs.Deactivate({instant = true})
            end
        end)

        local function bindGamepadSlider() -- Line: 855
            -- upvalues: ContextActionService (upval), u429 (ref), Fill (val), SliderButton (val), render (val)
            local v1 = ContextActionService
            local Value = Enum.ContextActionPriority.High.Value
            local ButtonL1 = Enum.KeyCode.ButtonL1
            local ButtonR1 = Enum.KeyCode.ButtonR1
            v1:BindActionAtPriority("SakuraDepositSlider", function(a1, a2, a3) -- Line: 858
                -- upvalues: u429 (upval), Fill (upval), SliderButton (upval), render (upval)
                if a2 ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end
                local v1 = if a3.KeyCode ~= Enum.KeyCode.ButtonR1 then -0.1 else 0.1
                u429 = math.clamp(u429 + v1, 0, 1)
                Fill.Size = UDim2.fromScale(u429, 1)
                SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
                render()
                return Enum.ContextActionResult.Sink
            end, false, Value, ButtonL1, ButtonR1)
        end

        local function unbindGamepadSlider() -- Line: 876 -- upvalues: ContextActionService (upval)
            ContextActionService:UnbindAction("SakuraDepositSlider")
        end

        if v1 then
            GUI.OnActivated(v1, function() -- Line: 879 -- upvalues: Save (upval), SakuraBloomPolicy (upval), Tabs (upval), SakuraSignals (upval)
                local v1 = Save.IsLoaded()
                local v2 = if not v1 then nil else Save.Peek()
                if not SakuraBloomPolicy.HasBloomUnlocked(v1, v2) then
                    return
                end
                Tabs.Deactivate({instant = true})
                SakuraSignals.ShowTutorial:Fire()
            end)
            ButtonFX(v1)
        end
        Tabs.Activated:Connect(function(a1) -- Line: 889
            -- upvalues: Save (upval), SakuraBloomPolicy (upval), Tabs (upval), Players (upval), SakuraSignals (upval)
            -- upvalues: u429 (ref), Fill (val), SliderButton (val), u432 (ref), scheduleRender (ref)
            -- upvalues: ContextActionService (upval), render (val), PlatformController (upval), ButtonHintStrip (upval)
            if a1 == "SakuraEggCharge" then
                local v1 = Save.IsLoaded()
                local v2 = if not v1 then nil else Save.Peek()
                if not SakuraBloomPolicy.HasBloomUnlocked(v1, v2) then
                    Tabs.Deactivate({instant = true})
                    return
                end
                local v3 = Save.Await()
                if not Players.LocalPlayer:GetAttribute("SakuraTutorialSkip")
                    and v3 ~= nil
                    and not v3.Sakura.TutorialSeen then
                    Tabs.Deactivate({instant = true})
                    SakuraSignals.ShowTutorial:Fire()
                    return
                end
                u429 = 1
                Fill.Size = UDim2.fromScale(u429, 1)
                SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
                u432 = true
                scheduleRender()
                v1 = ContextActionService
                local Value = Enum.ContextActionPriority.High.Value
                local ButtonL1 = Enum.KeyCode.ButtonL1
                local ButtonR1 = Enum.KeyCode.ButtonR1
                v1:BindActionAtPriority("SakuraDepositSlider", function(a1, a2, a3) -- Line: 858
                    -- upvalues: u429 (upval), Fill (upval), SliderButton (upval), render (upval)
                    if a2 ~= Enum.UserInputState.Begin then
                        return Enum.ContextActionResult.Pass
                    end
                    local v1 = if a3.KeyCode ~= Enum.KeyCode.ButtonR1 then -0.1 else 0.1
                    u429 = math.clamp(u429 + v1, 0, 1)
                    Fill.Size = UDim2.fromScale(u429, 1)
                    SliderButton.Position = UDim2.fromScale(u429, SliderButton.Position.Y.Scale)
                    render()
                    return Enum.ContextActionResult.Sink
                end, false, Value, ButtonL1, ButtonR1)
                if PlatformController.IsConsole() then
                    ButtonHintStrip.Present("SakuraDepositSlider", Enum.KeyCode.ButtonR1, "Deposit Amount")
                end
            end
        end)
        Tabs.Deactivated:Connect(function(a1) -- Line: 916
            -- upvalues: u428 (val), EggPicker (val), ContextActionService (upval), ButtonHintStrip (upval)
            if a1 == "SakuraEggCharge" then
                u428:Clean()
                EggPicker.Visible = false
                ContextActionService:UnbindAction("SakuraDepositSlider")
                ButtonHintStrip.Retract("SakuraDepositSlider")
            end
        end)
        render()
    end,
}