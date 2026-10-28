-- Script path: ReplicatedStorage.Controllers.GUI.IndexController
-- Decompile time: 44.13 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local AreaIndexProgressComponent = require(script.AreaIndexProgressComponent)
local Areas = require(ReplicatedStorage.Data.Areas)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetOddsDisplay = require(ReplicatedStorage.Client.Util.AssetOddsDisplay)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ClaimRewardPanel = require(script.ClaimRewardPanel)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
require(script.Types.Interface)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local BrainrotEgg = require(ReplicatedStorage.Data.BrainrotEgg)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local HalloweenIndex = require(ReplicatedStorage.Data.HalloweenIndex)
local Extinction = require(ReplicatedStorage.Data.LimitedEgg).Extinction
local Log = require(ReplicatedStorage.Packages.Log)
local LuminousEgg = require(ReplicatedStorage.Data.LuminousEgg)
local MonsterEgg = require(ReplicatedStorage.Data.MonsterEgg)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Rift = require(ReplicatedStorage.Data.Rift)
local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
local RiftMachineSchedule = require(ReplicatedStorage.Shared.Util.RiftMachineSchedule)
local ScrambleTradeIn = require(ReplicatedStorage.Data.ScrambleTradeIn)
local Save = require(ReplicatedStorage.Shared.Save)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local u160 = {}
u160.__index = u160
u160.__class = "IndexController"
local u162 = {"World", "Limited"}
local u169 = Color3.fromRGB(255, 55, 55)
local u174 = Color3.fromRGB(255, 255, 255)
local u179 = Color3.fromRGB(0, 0, 0)
local u184 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u191 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local u196 = Color3.fromRGB(104, 111, 122)
local u201 = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function updateLive() -- Line: 92 -- upvalues: Constants (val)
    return Constants.UPDATE_LIVE_AT <= (workspace:GetServerTimeNow())
end

return {
    Start = function() -- Line: 98
        -- upvalues: Log (val), TryLock (val), GUI (val), Hud (val), Players (val), Save (val), RiftEligibility (val)
        -- upvalues: u162 (val), u160 (val), Trove (val), Constants (val), RiftMachineSchedule (val), Areas (val)
        -- upvalues: Assets (val), Personalities (val), Extinction (val), LuminousEgg (val), BrainrotEgg (val)
        -- upvalues: MonsterEgg (val), Rift (val), ScrambleTradeIn (val), HalloweenIndex (val), ItemDisplay (val)
        -- upvalues: u179 (val), AreaIndexProgressComponent (val), SurfaceButton (val), u174 (val), u169 (val)
        -- upvalues: AssetOddsDisplay (val), Simple (val), AssetItems (val), ClaimRewardPanel (val), EnsureUIScale (val)
        -- upvalues: TweenService (val), u191 (val), u184 (val), u201 (val), u196 (val), Remotes (val), ButtonFX (val)
        -- upvalues: Tabs (val)
        local Icon_2, StrokeHolder, UIStroke, v1, v2, v3
        local u484 = Log.new()
        local u499 = TryLock()
        local Frame = GUI.Index().Frame
        local u514 = Hud.Every("IndexButton")
        local IndexNotificationBadge = Hud.Every("IndexNotificationBadge")
        local ClaimAll = Frame:FindFirstChild("ClaimAll")
        local u555 = if ClaimAll == nil then nil else if not ClaimAll:IsA("GuiObject") then nil else ClaimAll
        local u542 = if u555 == nil then nil else u555:FindFirstChild("NotificationBadge")

        local function renderNotificationBadge(a1, a2) -- Line: 120 -- types: a1: userdata?, a2: number
            if a1 ~= nil and a1:IsA("GuiObject") then
                a1.Visible = a2 > 0
                if a2 == 0 then
                    return
                end
                for i, j in a1:GetDescendants() do
                    if j:IsA("TextLabel") then
                        j.Text = tostring(a2)
                    end
                end
                return
            end
        end

        local function seesTheRift() -- Line: 134 -- upvalues: Players (upval), Save (upval), RiftEligibility (upval)
            local LocalPlayer = Players.LocalPlayer
            if LocalPlayer == nil then
                return false
            end
            local v1 = Save.Await()
            return RiftEligibility.IsRevealed(LocalPlayer, if v1 == nil then 0 else v1.SpeedPower, if v1 == nil then 0 else v1.LastLogout)
        end

        local ScrollingFrame = Frame.List.ScrollingFrame
        local Section = ScrollingFrame:FindFirstChild("Section")
        assert(Section ~= nil, "Index list is missing its Section template")
        local Viewing = Frame.Side.Viewing
        local Icon = Viewing.Icon
        local PetName = Viewing.PetName
        local PetRarity = Viewing.PetRarity
        local PetOdds = Viewing.PetOdds
        local Rewards = Frame.Side.Rewards
        local Claim = Rewards.Claim
        local Unlocked = Frame.Unlocked
        local Fill = Unlocked.Fill
        local TextLabel = Unlocked.TextLabel
        local TabButtons = Frame:FindFirstChild("TabButtons")
        local u458 = {}
        for i, v in ipairs(u162) do
            v1 = if TabButtons == nil then nil else TabButtons:FindFirstChild(v)
            if v1 ~= nil and v1:IsA("GuiButton") then
                v1.LayoutOrder = i
                StrokeHolder = v1:FindFirstChild("StrokeHolder")
                UIStroke = if StrokeHolder == nil then nil else StrokeHolder:FindFirstChildOfClass("UIStroke")
                v2 = v1:FindFirstChild("TextLabel")
                Icon_2 = v1:FindFirstChild("Icon")
                v3 = {Button = v1, Stroke = UIStroke}
                v3.Label = if v2 == nil then nil else if not v2:IsA("TextLabel") then nil else v2
                v3.Icon = if Icon_2 == nil then nil else if not Icon_2:IsA("ImageLabel") then nil else Icon_2
                v3.Tint = v1.BackgroundColor3
                v3.StrokeTransparency = if UIStroke == nil then 0 else UIStroke.Transparency
                v3.TextTransparency = if v2 == nil then 0 else if not v2:IsA("TextLabel") then 0 else v2.TextTransparency
                v3.IconTransparency = if Icon_2 == nil then 0 else if not Icon_2:IsA("ImageLabel") then 0 else Icon_2.ImageTransparency
                u458[v] = v3
            end
        end
        local u82 = {}
        local u337 = 0
        for i2, j in Section.Pets:GetChildren() do
            v2 = tonumber((string.match(j.Name, "^Clr(%d+)$")))
            if v2 ~= nil and j:IsA("ImageLabel") then
                u82[v2] = j
                u337 = math.max(u337, v2)
            end
        end
        assert(u337 > 0, "Index Section.Pets has no Clr cell templates")

        local function variantForRarity(a1) -- Line: 205 -- upvalues: u337 (ref) -- types: a1: number
            return (math.clamp(a1, 1, u337))
        end

        local function dressWithRarityGradient(a1, a2) -- Line: 209 -- types: a2: userdata
            local UIGradient = a1:FindFirstChildOfClass("UIGradient")
            if UIGradient ~= nil then
                UIGradient:Destroy()
            end
            a1.BackgroundColor3 = Color3.new(1, 1, 1)
            a2:Clone().Parent = a1
        end

        local UIGridLayout = Section.Pets:FindFirstChildOfClass("UIGridLayout")
        assert(UIGridLayout ~= nil, "Index Section.Pets needs a UIGridLayout")
        local Scale = Section.Size.Y.Scale
        local Scale_2 = Section.Pets.Size.Y.Scale
        local Scale_3 = UIGridLayout.CellSize.Y.Scale
        local Scale_4 = UIGridLayout.CellPadding.Y.Scale
        local Scale_5 = UIGridLayout.CellSize.X.Scale
        local Scale_6 = UIGridLayout.CellPadding.X.Scale
        local v4 = math.max(1, (math.floor((1 + Scale_6) / (Scale_5 + Scale_6))))
        local v5 = Scale_2 * Scale
        v3 = Scale_3 * v5
        local v6 = Scale_4 * v5
        v5 = Section.BgFrame.Position.Y.Scale * Scale
        local v7 = Section.Unlocked.Position.Y.Scale * Scale
        v2 = Section.Unlocked.Size.Y.Scale * Scale
        local u170 = {PerRow = v4}
        u170.PetsPosAbs = Section.Pets.Position.Y.Scale * Scale
        u170.BgPosAbs = v5
        u170.BarSizeAbs = v2
        u170.BottomAbs = math.max(0, Scale - v7 - v2)
        u170.CellAbs = v3
        u170.PadAbs = v6

        function u160._build() -- Line: 279 -- upvalues: u160 (upval), Trove (upval)
            local v1 = u160
            local v2 = setmetatable({}, v1)
            v2._trove = Trove.new()
            v2._openTrove = nil
            v2._sections = {}
            v2._sectionsByPage = {}
            v2._currentPage = "World"
            v2._selectedCategory = nil
            v2._isOpen = false
            v2._claimAllArmed = false
            v2._builtLive = false
            v2._builtLaboratory = false
            v2._badgePulseTweens = {}
            v2:_buildEntries()
            v2:_init()
            return v2
        end

        function u160:_buildEntries() -- Line: 303
            -- upvalues: Constants (upval), RiftMachineSchedule (upval), u162 (upval), Areas (upval), Assets (upval)
            -- upvalues: Personalities (upval), Extinction (upval), LuminousEgg (upval), BrainrotEgg (upval)
            -- upvalues: MonsterEgg (upval), RiftEligibility (upval), Players (upval), Save (upval), Rift (upval)
            -- upvalues: ScrambleTradeIn (upval), HalloweenIndex (upval)
            local IndexBackgroundImage, World, ZoneGradient, v1, v2, v3, v4, v5, v6, v7
            local ServerTimeNow = workspace:GetServerTimeNow()
            self._builtLive = Constants.UPDATE_LIVE_AT <= ServerTimeNow
            self._builtLaboratory = RiftMachineSchedule.IsLaboratoryTime()
            for i, v in ipairs(u162) do
                self._sectionsByPage[v] = {}
            end
            local v8 = nil
            local v9 = nil
            local v10 = self
            for i2, j in Areas.Directory, v8, v9 do
                v5 = {}
                v6 = nil
                v7 = nil
                for k, n in j.DropTable, v6, v7 do
                    v2 = n[1]
                    v3 = n[2]
                    v4 = Assets.Directory[v2]
                    if not (v3 <= 0) then
                        if v4.DontRoll ~= true or j.IndexIncludeDontRoll == true then
                            table.insert(v5, {
                                Category = v2,
                                Config = v4,
                                ItemData = {
                                    Scale = 1,
                                    HasBeenFirstPlaced = true,
                                    Category = v2,
                                    Mutations = {},
                                    Personality = Personalities.Personalities.Normal,
                                },
                            })
                        end
                    end
                end
                table.sort(v5, function(a1, a2) -- Line: 341
                    local Rank = a1.Config.Rarity.Rank
                    local Rank_2 = a2.Config.Rarity.Rank
                    if Rank ~= Rank_2 then
                        return Rank < Rank_2
                    end
                    if a1.Config.DropWeight ~= a2.Config.DropWeight then
                        return a2.Config.DropWeight < a1.Config.DropWeight
                    end
                    return a1.Category < a2.Category
                end)
                if #v5 > 0 then
                    World = v10._sectionsByPage.World
                    v7 = {RewardKind = "AreaBat", SectionId = i2, DisplayName = j.DisplayName}
                    IndexBackgroundImage = j.IndexBackgroundImage or j.Icon
                    v7.Icon = IndexBackgroundImage
                    ZoneGradient = j.ZoneGradient or j.Rarity.RarityGradient
                    v7.HeaderGradient = ZoneGradient
                    v7.SortOrder = Areas.GetProgressionOrder(j)
                    v7.RewardGearId = j.IndexBatGearId
                    v7.Entries = v5
                    table.insert(World, v7)
                end
            end

            local function limitedEntryOrder(a1, a2) -- Line: 370
                if a1.Config.Rarity.Rank ~= a2.Config.Rarity.Rank then
                    return a1.Config.Rarity.Rank < a2.Config.Rarity.Rank
                end
                local v1 = a1.Config.EarningRate or 0
                local v2 = a2.Config.EarningRate or 0
                if v1 ~= v2 then
                    return v1 < v2
                end
                return a1.Category < a2.Category
            end

            local function collectLimitedEntries(a1) -- Line: 387
                -- upvalues: Assets (upval), Personalities (upval), limitedEntryOrder (val)
                local AssetId, v1
                local v2 = {}
                for i, v in ipairs(a1) do
                    AssetId = v.AssetId
                    v1 = Assets.Directory[AssetId]
                    if v1 ~= nil then
                        table.insert(v2, {
                            Category = AssetId,
                            Config = v1,
                            ItemData = {
                                Scale = 1,
                                HasBeenFirstPlaced = true,
                                Category = AssetId,
                                Mutations = {},
                                Personality = Personalities.Personalities.Normal,
                            },
                        })
                    end
                end
                table.sort(v2, limitedEntryOrder)
                return v2
            end

            v9 = collectLimitedEntries(Extinction.Entries)
            local MechaReroll = Extinction.MechaReroll
            if MechaReroll ~= nil then
                for i3, m in ipairs((collectLimitedEntries(MechaReroll.Entries))) do
                    table.insert(v9, m)
                end
            end
            table.sort(v9, limitedEntryOrder)
            table.insert(v10._sectionsByPage.Limited, {
                SectionId = "LimitedEgg",
                SortOrder = 1000000,
                RewardKind = "GearClaim",
                RewardGearId = "GravityDisruptor",
                DisplayName = Extinction.DisplayName,
                Icon = if not v10._builtLive then "rbxassetid://108209625322017" else "rbxassetid://97935712077919",
                Entries = v9,
            })
            if v10._builtLive then
                local v11 = collectLimitedEntries(LuminousEgg.Entries)
                for i4, i5 in ipairs((collectLimitedEntries(LuminousEgg.MechaEntries))) do
                    table.insert(v11, i5)
                end
                table.sort(v11, limitedEntryOrder)
                table.insert(v10._sectionsByPage.Limited, {
                    SectionId = "LuminousEgg",
                    SortOrder = 1500000,
                    RewardKind = "GearClaim",
                    RewardGearId = "GravityDisruptor",
                    DisplayName = LuminousEgg.DisplayName,
                    Icon = LuminousEgg.BackgroundImage,
                    Entries = v11,
                })
            end
            local v12 = collectLimitedEntries(BrainrotEgg.Entries)
            table.insert(v10._sectionsByPage.Limited, {
                SectionId = "BrainrotEgg",
                SortOrder = (1 / 0),
                RewardKind = "GearClaim",
                RewardGearId = "BeeLauncher",
                DisplayName = BrainrotEgg.DisplayName,
                Icon = BrainrotEgg.BackgroundImage,
                Entries = v12,
            })
            v9 = collectLimitedEntries(MonsterEgg.Entries)
            for i6, i62 in ipairs((collectLimitedEntries(MonsterEgg.MechaEntries))) do
                table.insert(v9, i62)
            end
            table.sort(v9, limitedEntryOrder)
            table.insert(v10._sectionsByPage.Limited, {
                SectionId = "MonsterEgg",
                SortOrder = 3000000,
                RewardKind = "GearClaim",
                RewardGearId = "BeeLauncher",
                DisplayName = MonsterEgg.DisplayName,
                Icon = MonsterEgg.BackgroundImage,
                Entries = v9,
            })
            if not RiftEligibility.IsFeatureLive() then
                v12 = {}
                for i7, i72 in ipairs(Rift.Banners) do
                    for i8, i82 in ipairs(i72.Pets) do
                        table.insert(v12, i82)
                    end
                end
                v5 = collectLimitedEntries(v12)
                if #v5 > 0 then
                    table.insert(v10._sectionsByPage.Limited, {
                        SectionId = "Rift",
                        DisplayName = "Rift",
                        Icon = "rbxassetid://137708974138911",
                        SortOrder = 2000000,
                        RewardKind = "Collection",
                        RewardGearId = "",
                        RewardIcon = "",
                        Entries = v5,
                    })
                end
            else
                local LocalPlayer = Players.LocalPlayer
                if LocalPlayer ~= nil then
                    v5 = Save.Await()
                    local SpeedPower = if v5 == nil then 0 else v5.SpeedPower
                    local LastLogout = if v5 == nil then 0 else v5.LastLogout
                    v12 = RiftEligibility.IsRevealed(LocalPlayer, SpeedPower, LastLogout)
                else
                    v12 = false
                end
                if v12 then
                    v12 = {}
                    for i9, i92 in ipairs(Rift.Banners) do
                        for i10, i102 in ipairs(i92.Pets) do
                            table.insert(v12, i102)
                        end
                    end
                    v5 = collectLimitedEntries(v12)
                    if #v5 > 0 then
                        table.insert(v10._sectionsByPage.Limited, {
                            SectionId = "Rift",
                            DisplayName = "Rift",
                            Icon = "rbxassetid://137708974138911",
                            SortOrder = 2000000,
                            RewardKind = "Collection",
                            RewardGearId = "",
                            RewardIcon = "",
                            Entries = v5,
                        })
                    end
                end
            end
            if v10._builtLaboratory then
                v12 = {}
                for i11, i112 in ipairs(ScrambleTradeIn.Banners) do
                    for i12, i122 in ipairs(i112.Pets) do
                        table.insert(v12, i122)
                    end
                end
                v5 = collectLimitedEntries(v12)
                if #v5 > 0 then
                    table.insert(v10._sectionsByPage.Limited, {
                        SectionId = "DrScramble",
                        DisplayName = "Dr. Scramble",
                        Icon = "rbxassetid://86377465284767",
                        SortOrder = 500000,
                        RewardKind = "GearClaim",
                        RewardGearId = "Scramble Sword",
                        Entries = v5,
                    })
                end
            end
            for i13, i132 in ipairs(HalloweenIndex.GetSections()) do
                v1 = collectLimitedEntries(i132.Entries)
                if #v1 > 0 then
                    table.insert(v10._sectionsByPage.Limited, {
                        RewardKind = "Collection",
                        RewardGearId = "",
                        RewardIcon = "",
                        SectionId = i132.Category,
                        DisplayName = i132.DisplayName,
                        Icon = i132.BackgroundImage,
                        SortOrder = 400000 + i13,
                        Entries = v1,
                    })
                end
            end
            for i14, i142 in ipairs(u162) do
                table.sort(v10._sectionsByPage[i142], function(a1, a2) -- Line: 553
                    if a1.SortOrder ~= a2.SortOrder then
                        return a1.SortOrder < a2.SortOrder
                    end
                    return a1.SectionId < a2.SectionId
                end)
            end
        end

        function u160._getSave(a1) -- Line: 564 -- upvalues: Save (upval)
            return Save.Await()
        end

        function u160:_isDiscovered(a2) -- Line: 568
            local v1 = self:_getSave()
            if v1 == nil then
                return false
            end
            return v1.Index[a2.Category] == true
        end

        function u160:_isClaimed(a2) -- Line: 580
            local v1 = self:_getSave()
            local v2 = false
            if v1 ~= nil then
                v2 = v1.IndexClaimedCategories[a2.Category] == true
            end
            return v2
        end

        function u160:_isClaimable(a2) -- Line: 585
            return self:_isDiscovered(a2) and not self:_isClaimed(a2)
        end

        function u160._getEntryDisplayName(a1, a2) -- Line: 592 -- upvalues: ItemDisplay (upval)
            return ItemDisplay.GetNameFromItemData(a2.ItemData)
        end

        function u160:_getEntryByCategory(a2) -- Line: 599 -- types: a2: string?
            if a2 == nil then
                return nil
            end
            for i, v in ipairs(self._sectionsByPage[self._currentPage]) do
                for i2, i3 in ipairs(v.Entries) do
                    if i3.Category == v1 then
                        return i3
                    end
                end
            end
            return nil
        end

        function u160._renderHiddenIcon(a1, a2) -- Line: 618 -- upvalues: u179 (upval) -- types: a2: userdata
            a2.ImageColor3 = u179
            a2.ImageTransparency = 0.35
        end

        function u160._renderVisibleIcon(a1, a2) -- Line: 623 -- types: a2: userdata
            a2.ImageColor3 = Color3.fromRGB(255, 255, 255)
            a2.ImageTransparency = 0
        end

        function u160:_renderEntryIcon(a2, a3, a4) -- Line: 628
            -- upvalues: Assets (upval)
            a2.Image = Assets.Directory[a3.Category].Icon or ""
            a2.ScaleType = Enum.ScaleType.Fit
            if a4 then
                self:_renderVisibleIcon(a2)
                return
            end
            self:_renderHiddenIcon(a2)
        end

        function u160._sizeSection(a1, a2, a3) -- Line: 647 -- upvalues: u170 (val) -- types: a3: number
            local v1 = math.max(1, (math.ceil(a3 / u170.PerRow)))
            local v2 = v1 * u170.CellAbs + (v1 - 1) * u170.PadAbs
            v1 = u170.PetsPosAbs + v2 + 0.04
            local v3 = v1 + u170.BarSizeAbs
            local v4 = v3 + u170.BottomAbs
            local v5 = math.max(0, v3 - u170.BgPosAbs)
            a2.Size = UDim2.new(a2.Size.X.Scale, a2.Size.X.Offset, v4, 0)
            a2.BgFrame.Size = UDim2.new(a2.BgFrame.Size.X.Scale, 0, v5 / v4, 0)
            a2.BgFrame.Position = UDim2.new(a2.BgFrame.Position.X.Scale, 0, u170.BgPosAbs / v4, 0)
            a2.Unlocked.Size = UDim2.new(a2.Unlocked.Size.X.Scale, 0, u170.BarSizeAbs / v4, 0)
            a2.Unlocked.Position = UDim2.new(a2.Unlocked.Position.X.Scale, 0, (v1 + u170.BarSizeAbs * a2.Unlocked.AnchorPoint.Y) / v4, 0)
            a2.Pets.Position = UDim2.new(a2.Pets.Position.X.Scale, 0, u170.PetsPosAbs / v4, 0)
            a2.Pets.Size = UDim2.new(a2.Pets.Size.X.Scale, 0, v2 / v4, 0)
            local UIGridLayout = a2.Pets:FindFirstChildOfClass("UIGridLayout")
            if UIGridLayout ~= nil then
                UIGridLayout.CellSize = UDim2.new(UIGridLayout.CellSize.X.Scale, 0, u170.CellAbs / v2, 0)
                UIGridLayout.CellPadding = UDim2.new(UIGridLayout.CellPadding.X.Scale, 0, u170.PadAbs / v2, 0)
            end
        end

        function u160:_ensureSectionPool(a2) -- Line: 682
            -- upvalues: Section (val), ScrollingFrame (val), AreaIndexProgressComponent (upval), u499 (val)
            local v1
            if self._openTrove == nil then
                return
            end
            while #self._sections < a2 do
                v1 = Section:Clone()
                v1.Name = ("IndexArea%*"):format(#self._sections + 1)
                v1.Visible = false
                v1.Parent = ScrollingFrame
                local u20 = {Frame = v1}
                u20.Slots = {}
                u20.ProgressComponent = AreaIndexProgressComponent.new(v1.Unlocked, function(a1) -- Line: 701 -- upvalues: u499 (upval), self (val) -- types: a1: string
                    u499(function() -- Line: 702 -- upvalues: a1 (val), self (upval)
                        if a1 ~= "LimitedEgg"
                            and a1 ~= "BrainrotEgg"
                            and a1 ~= "MonsterEgg"
                            and a1 ~= "LuminousEgg"
                            and a1 ~= "DrScramble" then
                            self:_equipAreaBat(a1)
                            return
                        end
                        self:_claimLimitedEggReward(a1)
                    end)
                end)
                table.insert(self._sections, u20)
                self._openTrove:Add(v1)
                self._openTrove:Add(function() -- Line: 720 -- upvalues: u20 (val)
                    u20.ProgressComponent:Destroy()
                end)
            end
        end

        function u160:_ensureSlotPool(a2, a3) -- Line: 726 -- upvalues: u337 (ref), SurfaceButton (upval)
            local Rarity, RarityGradient, v1, v2, v3, v4, v5, v6, v7
            if self._openTrove == nil then
                return
            end
            for i, v in ipairs(a3.Entries) do
                Rarity = v.Config.Rarity
                v7 = math.clamp(Rarity.Rank, 1, u337)
                v2 = ("Clr%*"):format(v7)
                v7 = if (if not (v7 < Rarity.Rank) then nil else Rarity.RarityGradient) == nil then v2 else ("%*:%*"):format(v2, Rarity._id)
                v6 = v1.Slots[i]
                if v6 ~= nil and v6.Variant ~= v7 then
                    v6.Teardown()
                    v6.Frame:Destroy()
                    v6 = nil
                end
                if v6 == nil then
                    v3 = v1.Frame.Pets:FindFirstChild(v2)
                    v5 = false
                    if v3 ~= nil then
                        v5 = v3:IsA("ImageLabel")
                    end
                    assert(v5, (("Index section lost its %* template"):format(v2)))
                    v4 = v3:Clone()
                    v4.Name = ("IndexEntry%*"):format(i)
                    v4.Visible = false
                    v4.LayoutOrder = i
                    v4.Parent = v1.Frame.Pets
                    if RarityGradient ~= nil then
                        v3 = v4:FindFirstChildOfClass("UIGradient")
                        if v3 ~= nil then
                            v3:Destroy()
                        end
                        v4.BackgroundColor3 = Color3.new(1, 1, 1)
                        RarityGradient:Clone().Parent = v4
                    end
                    local u121 = {Frame = v4, Variant = v7}

                    function u121.Teardown() end

                    u121.Teardown = SurfaceButton(v4, 1.08, function() -- Line: 774 -- upvalues: u121 (val), self (val)
                        local Entry = u121.Entry
                        if Entry ~= nil and self._selectedCategory ~= Entry.Category then
                            self:_selectEntry(Entry.Category)
                            return
                        end
                    end)
                    v1.Slots[i] = u121
                    self._openTrove:Add(function() -- Line: 783 -- upvalues: u121 (val)
                        u121.Teardown()
                    end)
                    self._openTrove:Add(v4)
                end
            end
        end

        function u160:_renderSlot(a2, a3) -- Line: 791 -- upvalues: u174 (upval), u169 (upval)
            local Frame = a2.Frame
            a2.Entry = a3
            if a3 == nil then
                Frame.Visible = false
                return
            end
            local v1 = self:_isDiscovered(a3)
            local v2 = self:_isClaimed(a3)
            local v3 = self._selectedCategory == a3.Category
            Frame.Visible = true
            if not v1 then
                Frame.TextLabel.Text = "???"
            else
                Frame.TextLabel.Text = self:_getEntryDisplayName(a3)
            end
            self:_renderEntryIcon(Frame.Icon, a3, v1)
            local UIStroke = Frame:FindFirstChildOfClass("UIStroke")
            if UIStroke ~= nil then
                UIStroke.Color = if not v3 then if not v1 or v2 then Color3.fromRGB(0, 0, 0) else u169 else u174
            end
        end

        function u160:_renderSlots() -- Line: 827
            local v1, v2, v3, v4, v5, v6, v7
            local v8 = self._sectionsByPage[self._currentPage]
            self:_ensureSectionPool(#v8)
            for i, v in ipairs(self._sections) do
                v5 = v8[i]
                v.Section = v5
                if v5 ~= nil then
                    v.Frame.Visible = true
                    v.Frame.Name = v5.SectionId
                    v.Frame.LayoutOrder = i
                    v.Frame.BgFrame.TextLabel.Text = v5.DisplayName
                    v.Frame.BgFrame.Image = v5.Icon
                    v.Frame.BgFrame.ScaleType = Enum.ScaleType.Crop
                    v6 = 0
                    v3 = nil
                    for i2, j in v5.Entries, nil, v3 do
                        if v1:_isDiscovered(j) then
                            v6 = v6 + 1
                        end
                    end
                    v7 = v1:_getSave()
                    v2 = false
                    if v7 ~= nil then
                        v2 = 0 < (v7.GearInventory[v5.RewardGearId] or 0)
                    end
                    if v5.RewardKind == "AreaBat" then
                        v3 = false
                        if v7 ~= nil then
                            v3 = v7.VisitedGears[v5.RewardGearId] == true
                        end
                        v.ProgressComponent:RenderAreaBat(v5.SectionId, v5.RewardGearId, v6, #v5.Entries, v3, v2)
                    elseif v5.RewardKind ~= "Collection" then
                        v.ProgressComponent:RenderGearClaim(v5.SectionId, v5.RewardGearId, v6, #v5.Entries, v2)
                    else
                        v.ProgressComponent:RenderCollection(v5.SectionId, v5.RewardIcon or "", v6, #v5.Entries)
                    end
                    v1:_sizeSection(v.Frame, #v5.Entries)
                    v1:_ensureSlotPool(v, v5)
                    for i3, k in ipairs(v.Slots) do
                        v4 = v5.Entries[i3]
                        v1:_renderSlot(k, v4)
                    end
                else
                    v.Frame.Visible = false
                    for i4, n in ipairs(v.Slots) do
                        v1:_renderSlot(n, nil)
                    end
                end
            end
        end

        function u160:_selectEntry(a2) -- Line: 892 -- types: a2: string
            self._selectedCategory = a2
            self:_renderSlots()
            self:_renderInfo()
            self:_renderRewards()
        end

        function u160:_selectDefaultEntry() -- Line: 899
            local v1
            if self:_getEntryByCategory(self._selectedCategory) ~= nil then
                return
            end
            for i, v in ipairs(self._sectionsByPage[self._currentPage]) do
                v1 = v.Entries[1]
                if v1 ~= nil then
                    self._selectedCategory = v1.Category
                    return
                end
            end
        end

        function u160:_renderInfo() -- Line: 914
            -- upvalues: Icon (val), PetRarity (val), PetOdds (val), Viewing (val), AssetOddsDisplay (upval)
            -- upvalues: PetName (val), Simple (upval), AssetItems (upval)
            local v1 = self:_getEntryByCategory(self._selectedCategory)
            if v1 == nil then
                return
            end
            local v2 = self:_isDiscovered(v1)
            self:_renderEntryIcon(Icon, v1, v2)
            PetRarity.Text = v1.Config.Rarity._id
            local UIGradient = PetOdds:FindFirstChildOfClass("UIGradient")
            if UIGradient then
                UIGradient:Destroy()
            end
            if v1.Config.Rarity.RarityGradient then
                Viewing.BackgroundColor3 = v1.Config.Rarity.Color
                Viewing.UIStroke.Color = v1.Config.Rarity.Color:Lerp(Color3.new(0, 0, 0), 0.5)
            end
            AssetOddsDisplay.DescribeItem(v1.Config, v1.ItemData, false)
            if not v2 then
                PetName.Text = "???"
                PetOdds.Text = "???"
                return
            end
            PetName.Text = self:_getEntryDisplayName(v1)
            PetOdds.Text = ("$%*/s"):format((Simple.FormatCompact(AssetItems.IndexMoneyReward(v1.Category) / 100, ".#")))
        end

        function u160:_renderRewards() -- Line: 954 -- upvalues: ClaimRewardPanel (upval), Rewards (val)
            local v1 = self:_getEntryByCategory(self._selectedCategory)
            local v2 = false
            if v1 ~= nil then
                v2 = self:_isClaimed(v1)
            end
            local v3 = false
            if v1 ~= nil then
                v3 = self:_isClaimable(v1)
            end
            ClaimRewardPanel.Render(Rewards, v1, v2, v3)
        end

        function u160:_countUnclaimedByPage(a2) -- Line: 961 -- types: a2: string
            local v1 = 0
            for i, v in ipairs(self._sectionsByPage[a2]) do
                for i2, i3 in ipairs(v.Entries) do
                    if v2:_isClaimable(i3) then
                        v1 = v1 + 1
                    end
                end
            end
            return v1
        end

        function u160:_countDiscoveredByPage(a2) -- Line: 974 -- types: a2: string
            local v1 = 0
            for i, v in ipairs(self._sectionsByPage[a2]) do
                for i2, i3 in ipairs(v.Entries) do
                    if v2:_isDiscovered(i3) then
                        v1 = v1 + 1
                    end
                end
            end
            return v1
        end

        function u160:_countEntriesByPage(a2) -- Line: 987 -- types: a2: string
            local v1 = 0
            for i, v in ipairs(self._sectionsByPage[a2]) do
                v1 = v1 + #v.Entries
            end
            return v1
        end

        function u160:_startBadgePulse() -- Line: 997
            -- upvalues: IndexNotificationBadge (val), EnsureUIScale (upval), TweenService (upval), u191 (upval)
            local v1, v2
            if #self._badgePulseTweens > 0 then
                return
            end
            for i, v in ipairs(IndexNotificationBadge) do
                if v:IsA("GuiObject") then
                    v1 = EnsureUIScale(v)
                    v1.Scale = 0.8
                    v2 = TweenService:Create(v1, u191, {Scale = 1.2})
                    table.insert(self._badgePulseTweens, v2)
                    v2:Play()
                end
            end
        end

        function u160:_stopBadgePulse() -- Line: 1016 -- upvalues: IndexNotificationBadge (val), EnsureUIScale (upval)
            local v1
            if #self._badgePulseTweens == 0 then
                return
            end
            for i, v in ipairs(self._badgePulseTweens) do
                v:Cancel()
                v:Destroy()
            end
            table.clear(self._badgePulseTweens)
            for i2, i3 in ipairs(IndexNotificationBadge) do
                if i3:IsA("GuiObject") then
                    v1 = EnsureUIScale(i3)
                    v1.Scale = 1
                end
            end
        end

        function u160:_renderNotificationBadges(a2) -- Line: 1033
            -- upvalues: IndexNotificationBadge (val), renderNotificationBadge (val), u542 (val)
            for i, v in ipairs(IndexNotificationBadge) do
                renderNotificationBadge(v, a2)
            end
            renderNotificationBadge(u542, a2)
            if a2 > 0 then
                self:_startBadgePulse()
                return
            end
            self:_stopBadgePulse()
        end

        function u160:_renderProgress() -- Line: 1048
            -- upvalues: u162 (upval), u555 (val), Unlocked (val), TextLabel (val), TweenService (upval), Fill (val)
            -- upvalues: u184 (upval)
            local v1 = self:_countEntriesByPage(self._currentPage)
            local v2 = self:_countDiscoveredByPage(self._currentPage)
            local v3 = 0
            for i, v in ipairs(u162) do
                v3 = v3 + self:_countUnclaimedByPage(v)
            end
            self._claimAllArmed = v3 > 0
            self:_renderNotificationBadges(v3)
            if u555 ~= nil then
                u555.Visible = self._claimAllArmed
                Unlocked.Visible = not self._claimAllArmed
                Unlocked.Active = false
                TextLabel.Text = ("Unlocked: %*/%*"):format(v2, v1)
                v3 = if v1 ~= 0 then math.clamp(v2 / v1, 0, 1) else 0
                TweenService:Create(Fill, u184, {Size = UDim2.fromScale(v3, 1)}):Play()
                return
            end
            Unlocked.Visible = true
            Unlocked.Active = self._claimAllArmed
            if self._claimAllArmed then
                TextLabel.Text = ("CLAIM ALL (%*)!"):format(v3)
                TweenService:Create(Fill, u184, {Size = UDim2.fromScale(1, 1)}):Play()
                return
            end
            TextLabel.Text = ("Unlocked: %*/%*"):format(v2, v1)
            v3 = if v1 ~= 0 then math.clamp(v2 / v1, 0, 1) else 0
            TweenService:Create(Fill, u184, {Size = UDim2.fromScale(v3, 1)}):Play()
        end

        function u160:_renderTabs() -- Line: 1083
            -- upvalues: u458 (val), TweenService (upval), u201 (upval), u196 (upval)
            local v1, v2
            local v3 = nil
            local v4 = nil
            for i, j in u458, v3, v4 do
                v2 = i == self._currentPage
                v1 = u201
                TweenService:Create(j.Button, v1, {BackgroundColor3 = if not v2 then u196 else j.Tint}):Play()
                if j.Stroke ~= nil then
                    v1 = u201
                    TweenService:Create(j.Stroke, v1, {Transparency = if not v2 then 1 else j.StrokeTransparency}):Play()
                end
                if j.Label ~= nil then
                    v1 = u201
                    TweenService:Create(j.Label, v1, {TextTransparency = if not v2 then 0.3 else j.TextTransparency}):Play()
                end
                if j.Icon ~= nil then
                    v1 = u201
                    TweenService:Create(j.Icon, v1, {ImageTransparency = if not v2 then 0.8 else j.IconTransparency}):Play()
                end
            end
        end

        function u160:_selectPage(a2) -- Line: 1113 -- upvalues: ScrollingFrame (val) -- types: a2: string
            if self._currentPage ~= a2 and self._sectionsByPage[a2] ~= nil then
                self._currentPage = a2
                self._selectedCategory = nil
                ScrollingFrame.CanvasPosition = Vector2.zero
                self:_render()
                return
            end
        end

        function u160:_render() -- Line: 1124 -- upvalues: Constants (upval), RiftMachineSchedule (upval)
            local _builtLive = self._builtLive
            local ServerTimeNow = workspace:GetServerTimeNow()
            if _builtLive ~= (Constants.UPDATE_LIVE_AT <= ServerTimeNow)
                or self._builtLaboratory ~= RiftMachineSchedule.IsLaboratoryTime() then
                self:_buildEntries()
                self._selectedCategory = nil
            end
            if not self._isOpen then
                self:_renderProgress()
                return
            end
            self:_renderTabs()
            self:_selectDefaultEntry()
            self:_renderSlots()
            self:_renderInfo()
            self:_renderRewards()
            self:_renderProgress()
        end

        function u160:_open() -- Line: 1145 -- upvalues: Trove (upval)
            if self._isOpen then
                return
            end
            self._isOpen = true
            self._currentPage = "World"
            self._selectedCategory = nil
            self._openTrove = Trove.new()
            self:_buildEntries()
            self:_render()
        end

        function u160:_close() -- Line: 1158
            self._isOpen = false
            self._currentPage = "World"
            self._selectedCategory = nil
            if self._openTrove ~= nil then
                self._openTrove:Destroy()
                self._openTrove = nil
            end
            table.clear(self._sections)
            self:_render()
        end

        function u160._processClaimResults(a1, a2) -- Line: 1170 -- upvalues: Save (upval) -- types: a2: table?
            if a2 == nil then
                return
            end
            for i, v in ipairs(a2) do
                Save.Amend("IndexClaimedCategories", function(a1) -- Line: 1179 -- upvalues: v (val)
                    a1[v.Category] = true
                end)
            end
        end

        function u160:_claimSelected() -- Line: 1185 -- upvalues: Remotes (upval), u484 (val)
            local v1 = self:_getEntryByCategory(self._selectedCategory)
            if v1 ~= nil and self:_isClaimable(v1) then
                local v2, v3, v4 = Remotes.Codex.AskRedeem:InvokeServer(v1.Category)
                if not v2 then
                    (u484:AtWarning()):Log((("[Index] Claim failed: %*"):format(v3)))
                    return
                end
                self:_processClaimResults(v4)
                self:Refresh()
                return
            end
        end

        function u160:_claimAll() -- Line: 1201 -- upvalues: Remotes (upval), u484 (val)
            local v1, v2, v3 = Remotes.Codex.AskRedeemAll:InvokeServer()
            if not v1 then
                (u484:AtWarning()):Log((("[Index] Claim all failed: %*"):format(v2)))
                return
            end
            self:_processClaimResults(v3)
            self:Refresh()
        end

        function u160:_equipAreaBat(a2) -- Line: 1212 -- upvalues: Remotes (upval), u484 (val) -- types: a2: string
            local v1, v2 = Remotes.Codex.AskWearFieldBat:InvokeServer(a2)
            if not v1 then
                (u484:AtWarning()):Log((("[Index] Equip area bat failed: %*"):format(v2)))
                return
            end
            self:Refresh()
        end

        function u160:_claimLimitedEggReward(a2) -- Line: 1222
            -- upvalues: Remotes (upval), u484 (val)
            local v1, v2 = Remotes.Codex.AskRedeemLimitedEgg:InvokeServer(a2)
            if not v1 then
                (u484:AtWarning()):Log((("[Index] Limited Egg reward claim failed: %*"):format(v2)))
                return
            end
            self:Refresh()
        end

        function u160:Refresh() -- Line: 1236
            self:_render()
        end

        function u160:_init() -- Line: 1244
            -- upvalues: Section (val), u82 (val), u514 (val), ButtonFX (upval), Tabs (upval), u458 (val), Claim (val)
            -- upvalues: u499 (val), SurfaceButton (upval), Unlocked (val), u555 (val), Save (upval)
            Section.Visible = false
            for i, j in u82 do
                j.Visible = false
            end
            for k, n in u514 do
                self._trove:Add((ButtonFX(n, 1.08, function() -- Line: 1250 -- upvalues: Tabs (upval)
                    Tabs.Toggle("Index")
                end)))
            end
            for m, i5 in u458 do
                self._trove:Add((ButtonFX(i5.Button, 1.06, function() -- Line: 1255 -- upvalues: self (val), m (val)
                    self:_selectPage(m)
                end)))
            end
            self._trove:Add((ButtonFX(Claim, nil, function() -- Line: 1259 -- upvalues: u499 (upval), self (val)
                u499(function() -- Line: 1260 -- upvalues: self (upval)
                    self:_claimSelected()
                end)
            end)))

            local function v1() -- Line: 1264 -- upvalues: self (val), u499 (upval)
                if self._claimAllArmed then
                    u499(function() -- Line: 1266 -- upvalues: self (upval)
                        self:_claimAll()
                    end)
                end
            end

            self._trove:Add((SurfaceButton(Unlocked, 1.04, v1)))
            if u555 ~= nil then
                self._trove:Add(if not u555:IsA("GuiButton") then SurfaceButton(u555, 1.04, v1) else ButtonFX(u555, 1.04, v1))
            end
            self._trove:Add((Save.WatchFields({"Index", "IndexClaimedCategories", "VisitedGears", "GearInventory"}, function() -- Line: 1283 -- upvalues: self (val)
                self:Refresh()
            end)))
            self._trove:Connect(Tabs.Activated, function(a1) -- Line: 1288 -- upvalues: self (val) -- types: a1: string
                if a1 == "Index" then
                    self:_open()
                end
            end)
            self._trove:Connect(Tabs.Deactivated, function(a1) -- Line: 1293 -- upvalues: self (val) -- types: a1: string
                if a1 == "Index" then
                    self:_close()
                end
            end)
            self:_render()
        end

        return (u160._build())
    end,
}