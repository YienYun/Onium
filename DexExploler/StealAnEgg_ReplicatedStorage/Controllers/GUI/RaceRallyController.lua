-- Script path: ReplicatedStorage.Controllers.GUI.RaceRallyController
-- Decompile time: 26.16 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
local MilestoneCard = require(ReplicatedStorage.Controllers.GUI.BossMasteryController.MilestoneCard)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local RaceRally = require(ReplicatedStorage.Data.RaceRally)
local RaceRallyEligibility = require(ReplicatedStorage.Shared.Util.RaceRallyEligibility)
local RaceRallyRewards = require(ReplicatedStorage.Shared.Modules.RaceRallyRewards)
local RaceRally_2 = require(ReplicatedStorage.Shared.Types.RaceRally)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u95 = Color3.fromRGB(126, 255, 92)
local u100 = Color3.fromRGB(255, 80, 80)
local u105 = Color3.new(1, 1, 1)
local u117 = ColorSequence.new(Color3.fromRGB(161, 161, 161), Color3.fromRGB(91, 91, 91))
local u125 = ColorSequence.new(Color3.fromHex("ff2aff"), Color3.fromHex("b300ff"))
local u130 = ColorSequence.new(Color3.fromHex("d569ff"))
local UnixTimestamp = (DateTime.fromUniversalTime(2026, 10, 17, 15)).UnixTimestamp

local function countdown(a1) -- Line: 38 -- types: a1: number
    local v1 = a1 // 86400
    local v2 = a1 // 3600 % 24
    local v3 = a1 // 60 % 60
    if v1 > 0 then
        return (("%*d %*hr"):format(v1, v2))
    end
    if v2 > 0 then
        return (("%*hr %*m"):format(v2, v3))
    end
    return (("%*m %*s"):format(v3, a1 % 60))
end

local function blank() -- Line: 48 -- upvalues: RaceRally_2 (val)
    return RaceRally_2.Blank()
end

local function hideSamples(a1, a2) -- Line: 53 -- types: a1: userdata, a2: string
    for i, j in a1:GetChildren() do
        if j.Name == a2 and j:IsA("GuiObject") then
            j.Visible = false
        end
    end
end

local function rewardsPresentation(a1) -- Line: 62 -- upvalues: RaceRallyRewards (val) -- types: a1: table
    local v1
    local v2 = {}
    local v3 = {}
    local v4 = nil
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        v1 = RaceRallyRewards.Present(j)
        table.insert(v2, v1.Title)
        table.insert(v3, v1.Icon)
        v4 = v4 or v1.Rarity
    end
    return {
        HoverTitle = "Rewards",
        Title = table.concat(v2, " + "),
        Rarity = v4,
        Icon = v3[1],
        CycleIcons = v3,
        Amount = RaceRallyRewards.Present(a1[1]).Amount,
        HoverDescription = table.concat(v2, "\n"),
    }
end

local function rewardsSummary(a1) -- Line: 84 -- upvalues: RaceRallyRewards (val), Numbers (val) -- types: a1: table
    local Title
    local v1 = {}
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        Title = RaceRallyRewards.Present(j).Title
        table.insert(v1, if j.Kind ~= "Tokens" then Title else ("%* %*"):format(Numbers.AddCommas(j.Amount), Title))
    end
    return table.concat(v1, " + ")
end

local function claimRewards(a1) -- Line: 96 -- upvalues: RaceRally (val) -- types: a1: string
    if a1 == RaceRally.RepeatId then
        return RaceRally.Repeat.Rewards
    end
    return RaceRally.Milestones[a1].Rewards
end

local function hasRacer(a1) -- Line: 102
    for i, j in a1.Rewards do
        if j.Kind == "Racer" then
            return true
        end
    end
    return false
end

local function racerUnlocks() -- Line: 112 -- upvalues: RaceRally (val)
    local Racer, Wins_2, v1, v2, v3
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in RaceRally.Milestones, v5, v6 do
        v2 = nil
        v3 = nil
        for k, n in j.Rewards, v2, v3 do
            if n.Kind == "Racer" then
                v1 = v4[n.Racer]
                Racer = n.Racer
                Wins_2 = if v1 ~= nil then math.min(v1, j.Wins) else j.Wins
                v4[Racer] = Wins_2
            end
        end
    end
    return v4
end

return {
    Start = function() -- Line: 129
        -- upvalues: GUI (val), Trove (val), RaceRally_2 (val), RaceRally (val), Toast (val), u95 (val), u100 (val)
        -- upvalues: hideSamples (val), RaceRallyRewards (val), ButtonFX (val), Remotes (val), u125 (val), u130 (val)
        -- upvalues: Storefront (val), Marketplace (val), Numbers (val), Save (val), Workspace (val), u117 (val)
        -- upvalues: u105 (val), rewardsPresentation (val), rewardsSummary (val), MilestoneCard (val)
        -- upvalues: racerUnlocks (val), Hud (val), RaceRallyFlags (val), RaceRallyEligibility (val), Tabs (val)
        -- upvalues: UnixTimestamp (val)
        local Card_2, Card_3, v1, v2, v3, v4
        local Main = GUI.RaceRally().Main
        local QuantityLabel = Main.CurrencyHolder.QuantityLabel
        local v5 = Trove.new()
        local u597 = RaceRally_2.Blank()
        local u12 = false
        Main.CurrencyHolder.CurrencyIcon.Image = RaceRally.CurrencyIcon

        local function show(a1, a2, a3) -- Line: 139
            -- upvalues: Toast (upval), u95 (upval), u100 (upval)
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Text = a1,
                Color = if not a2 then u100 else u95,
                Image = a3,
            })
        end

        local function request(a1, a2, a3, a4, a5) -- Line: 150
            -- upvalues: u12 (ref), Toast (upval), u100 (upval), u95 (upval)
            if u12 then
                return
            end
            u12 = true
            local success, err, v1 = pcall(function() -- Line: 161 -- upvalues: a1 (val), a2 (val)
                return a1:InvokeServer(a2)
            end)
            u12 = false
            if a5 ~= nil then
                a5()
            end
            if not success then
                Toast.Show({
                    Text = "Something went wrong, please try again.",
                    Seconds = 2.5,
                    SingleLine = true,
                    Color = u100,
                })
                return
            end
            if err then
                Toast.Show({
                    Seconds = 2.5,
                    SingleLine = true,
                    Text = a3,
                    Color = u95,
                    Image = a4,
                })
                return
            end
            if v1 ~= nil then
                Toast.Show({Seconds = 2.5, SingleLine = true, Text = v1, Color = u100})
            end
        end

        local ScrollingFrame = Main.ShopTab.ScrollingFrame
        local ShopItem = ScrollingFrame.ShopItem
        hideSamples(ScrollingFrame, ShopItem.Name)
        local Color = ShopItem.Card.Buy.UIGradient.Color
        local u30 = {}
        for i, j in RaceRally.OrderedOffers() do
            local u676 = RaceRallyRewards.Present(j.Config.Reward)
            v1 = ShopItem:Clone()
            v1.Name = j.Id
            v1.LayoutOrder = i
            Card_3 = v1.Card
            Card_3.EggName.Text = u676.Title
            Card_3.ItemIcon.Image = u676.Icon
            Card_3.ItemIcon.QuantityLabel.Visible = false
            Card_3.Quantity.Visible = true
            Card_3.Buy.PriceHolder.Icon.Image = RaceRally.CurrencyIcon
            v1.Visible = true
            v1.Parent = ScrollingFrame
            u30[j.Id] = Card_3
            v5:Add((ButtonFX(Card_3.Buy, nil, function() -- Line: 197 -- upvalues: request (val), Remotes (upval), j (val), u676 (val)
                request(Remotes.RaceRally.AskBuy, j.Id, ("Bought %*!"):format(u676.Title), u676.Icon)
            end)))
        end
        local u45 = RaceRally.DoubleTrophiesProductId()
        local v6 = ShopItem:Clone()
        v6.Name = RaceRally.DoubleTrophies.Key
        v6.LayoutOrder = #RaceRally.OrderedOffers() + 1
        local Card = v6.Card
        Card.EggName.Text = "2x Trophies"
        Card.ItemIcon.Image = RaceRally.DoubleTrophies.Icon
        Card.ItemIcon.QuantityLabel.Visible = false
        Card.Quantity.Visible = false
        Card.Buy.PriceHolder.Icon.Image = "rbxassetid://106998913980785"
        Card.Buy.PriceHolder.Price.Text = ""
        Card.Buy.UIGradient.Color = u125
        Card.Buy.UIStrokeClr.UIGradient.Color = u130
        Card.SoldOut.Title.Text = "Owned"
        v6.Visible = true
        v6.Parent = ScrollingFrame
        v5:Add((ButtonFX(Card.Buy, nil, function() -- Line: 223 -- upvalues: Storefront (upval), u45 (val)
            Storefront.Prompt(u45, true)
        end)))
        v5:Add((task.spawn(function() -- Line: 226 -- upvalues: Marketplace (upval), u45 (val), Card (val), Numbers (upval)
            local v1 = Marketplace.Price(u45, Enum.InfoType.Product)
            if v1 ~= nil then
                Card.Buy.PriceHolder.Price.Text = Numbers.AddCommas(v1)
            end
        end)))

        local function refreshDoubleTrophies() -- Line: 233 -- upvalues: Save (upval), RaceRally (upval), Card (val)
            local v1 = Save.Peek()
            local v2 = RaceRally.OwnsDoubleTrophies(if v1 == nil then nil else v1.Products)
            Card.SoldOut.Visible = v2
            Card.Buy.Visible = not v2
        end

        local function refreshShop() -- Line: 241
            -- upvalues: Workspace (upval), u30 (val), RaceRally (upval), u597 (ref), Color (val), u117 (upval)
            -- upvalues: Numbers (upval), u105 (upval), u100 (upval), RaceRallyRewards (upval)
            local Amount, QuantityLabel, v1, v2, v3, v4, v5
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local v6 = nil
            local v7 = nil
            for i, j in u30, v6, v7 do
                v2 = RaceRally.Shop[i]
                v3 = RaceRally.PurchasedCount(u597.Purchases[i], v2, ServerTimeNow)
                v4 = false
                if 0 < v2.Limit then
                    v4 = v2.Limit <= v3
                end
                v5 = v2.Price <= u597.Tokens
                j.SoldOut.Visible = v4
                j.Buy.Visible = not v4
                v1 = if not v5 then u117 else Color
                j.Buy.UIGradient.Color = v1
                j.Buy.PriceHolder.Price.Text = Numbers.AddCommas(v2.Price)
                v1 = if not v5 then u100 else u105
                j.Buy.PriceHolder.Price.TextColor3 = v1
                QuantityLabel = j.Quantity.QuantityLabel
                Amount = if not (0 < v2.Limit) then RaceRallyRewards.Present(v2.Reward).Amount else ("%*/%* LEFT"):format(math.max(v2.Limit - v3, 0), v2.Limit)
                QuantityLabel.Text = Amount
            end
        end

        local MileStoneTab = Main.MileStoneTab
        local ScrollingFrame_2 = MileStoneTab.ScrollingFrame
        local v7 = {
            ScrollingFrame_2.MasteryRow,
            ScrollingFrame_2.MasteryRow_Purple,
            ScrollingFrame_2.MasteryRow_Gold,
            ScrollingFrame_2.MasteryRow_Red,
            ScrollingFrame_2.MasteryRow_Rainbow,
        }
        for k, n in v7 do
            n.Visible = false
        end
        local MasteryLabel = MileStoneTab.InfoHolder.MasteryLabel
        local NotMax = MileStoneTab.InfoHolder.NextRewardInfoHolder.NotMax
        local MasteryGoal = NotMax.MasteryGoal
        local Chip = NotMax.RewardHolder.Chip
        local Max = MileStoneTab.InfoHolder.NextRewardInfoHolder.Max
        local MasteryGoal_2 = Max.MasteryGoal
        local Chip_2 = Max.RewardHolder.Chip
        local u573 = {}

        local function claim(a1, a2) -- Line: 282
            -- upvalues: RaceRally (upval), rewardsPresentation (upval), request (val), Remotes (upval)
            -- upvalues: rewardsSummary (upval)
            local Rewards
            a2.SetPending(true)
            local Icon = (rewardsPresentation(if a1 ~= RaceRally.RepeatId then RaceRally.Milestones[a1].Rewards else RaceRally.Repeat.Rewards)).Icon
            request(Remotes.RaceRally.AskClaimMilestone, a1, ("Claimed %*!"):format((rewardsSummary(Rewards))), Icon, function() -- Line: 291 -- upvalues: a2 (val)
                a2.SetPending(false)
            end)
        end

        local u655 = RaceRally.OrderedMilestones()
        local v8 = 0
        local v9 = nil
        local v10 = nil
        for m, i5 in u655, v9, v10 do
            if m == 1 then
                v8 = math.min(v8 + 1, #v7)
            else
                for i6, i7 in i5.Config.Rewards do
                    if i7.Kind == "Racer" then
                        if true then
                            v8 = math.min(v8 + 1, #v7)
                        end
                        v2 = MilestoneCard.New(v7[v8], ScrollingFrame_2, i5.Id, claim, true)
                        u573[i5.Id] = {Card = v2, Order = m}
                        v5:Add(v2.Destroy)
                        break
                    end
                end
                if false then
                    v8 = math.min(v8 + 1, #v7)
                end
            end
            v2 = MilestoneCard.New(v7[v8], ScrollingFrame_2, i5.Id, claim, true)
            u573[i5.Id] = {Card = v2, Order = m}
            v5:Add(v2.Destroy)
        end
        local u173 = MilestoneCard.New(v7[#v7], ScrollingFrame_2, RaceRally.RepeatId, claim, true)
        v5:Add(u173.Destroy)

        local function writeChip(a1, a2) -- Line: 311
            a1.Icon.Image = a2.Icon
            a1.Amount.Text = a2.Amount
        end

        local function refreshMilestones() -- Line: 316
            -- upvalues: u573 (val), RaceRally (upval), u597 (ref), rewardsPresentation (upval), u173 (val), u655 (val)
            -- upvalues: MasteryLabel (val), Numbers (upval), NotMax (val), Max (val), MasteryGoal_2 (val), Chip_2 (val)
            -- upvalues: MasteryGoal (val), Chip (val)
            local v1, v2, v3
            local v4 = nil
            local v5 = nil
            local v6 = nil
            for i, j in u573, v5, v6 do
                v1 = RaceRally.Milestones[i]
                v3 = if not (u597.Milestones[i] == true) then if not (v1.Wins <= u597.Wins) then "Locked" else "Claimable" else "Claimed"
                j.Card.Refresh(v1.Wins, rewardsPresentation(v1.Rewards), v3, j.Order)
                if v3 == "Locked" then
                    if v4 == nil or v1.Wins < v4.Wins then
                        v4 = v1
                    end
                end
            end
            local Repeat = RaceRally.Repeat
            v6 = RaceRally.RepeatsEarned(u597.Wins)
            v5 = u597.Repeats < v6
            v6 = RaceRally.RepeatWins(u597.Repeats + 1)
            local v7 = rewardsPresentation(Repeat.Rewards)
            u173.Refresh(v6, v7, if not v5 then "Locked" else "Claimable", #u655 + 1)
            MasteryLabel.Text = Numbers.AddCommas(u597.Wins)
            local v8 = false
            if v4 == nil then
                v8 = Repeat.After <= u597.Wins
            end
            NotMax.Visible = not v8
            Max.Visible = v8
            if not v8 then
                v1 = v4
                MasteryGoal.Text = ("At %*"):format((Numbers.AddCommas(if v1 == nil then v6 else v1.Wins)))
                v2 = Chip
                v3 = if v1 == nil then v7 else rewardsPresentation(v1.Rewards)
                v2.Icon.Image = v3.Icon
                v2.Amount.Text = v3.Amount
                return
            end
            MasteryGoal_2.Text = ("%* / %*"):format(if not v5 then (u597.Wins - Repeat.After) % Repeat.Every else Repeat.Every, Repeat.Every)
            Chip_2.Visible = true
            v2 = Chip_2
            v2.Icon.Image = v7.Icon
            v2.Amount.Text = v7.Amount
        end

        local ScrollingFrame_3 = Main.PetTab.ScrollingFrame
        local PetItem = ScrollingFrame_3.PetItem
        hideSamples(ScrollingFrame_3, PetItem.Name)
        local Attribute = PetItem:GetAttribute("LockedText")
        local Attribute_2 = PetItem:GetAttribute("DimTransparency")
        local v11 = false
        if type(Attribute) == "string" then
            v11 = type(Attribute_2) == "number"
        end
        assert(v11, (("%* needs LockedText and DimTransparency"):format((PetItem:GetFullName()))))
        local ImageTransparency = PetItem.Card.ItemIcon.ImageTransparency
        local Color_2 = PetItem.Card.Equipped.UIGradient.Color
        local u234 = {}
        local u236 = racerUnlocks()

        local function isUnlocked(a1) -- Line: 385 -- upvalues: RaceRally (upval), u597 (ref) -- types: a1: string
            local v1 = true
            if a1 ~= RaceRally.DefaultRacer then
                v1 = u597.Racers[a1] == true
            end
            return v1
        end

        for i8, i9 in RaceRally.OrderedRacers() do
            local u473 = RaceRallyRewards.Present({Kind = "Racer", Racer = i9.Id})
            v3 = PetItem:Clone()
            v3.Name = i9.Id
            v3.LayoutOrder = i8
            Card_2 = v3.Card
            Card_2.EggName.Text = i9.Config.DisplayName
            Card_2.ItemIcon.Image = u473.Icon
            v3.Visible = true
            v3.Parent = ScrollingFrame_3
            u234[i9.Id] = Card_2
            v5:Add((ButtonFX(Card_2.Equipped, nil, function() -- Line: 400
                -- upvalues: i9 (val), RaceRally (upval), u597 (ref), u236 (val), Toast (upval), u100 (upval)
                -- upvalues: request (val), Remotes (upval), u473 (val)
                local Id = i9.Id
                local v1 = true
                if Id ~= RaceRally.DefaultRacer then
                    v1 = u597.Racers[Id] == true
                end
                if v1 then
                    if (RaceRally.ResolveRacer(u597.EquippedRacer, u597.Racers)) == i9.Id then
                        return
                    end
                    request(Remotes.RaceRally.AskEquipRacer, i9.Id, ("%* equipped!"):format(i9.Config.DisplayName), u473.Icon)
                    return
                end
                v1 = u236[i9.Id]
                local v2 = if v1 == nil then "Unlock this racer from the win milestones first!" else ("Win %* races to unlock the %*!"):format(v1, i9.Config.DisplayName)
                Toast.Show({Seconds = 2.5, SingleLine = true, Text = v2, Color = u100})
            end)))
        end

        local function refreshRacers() -- Line: 423
            -- upvalues: RaceRally (upval), u597 (ref), u234 (val), ImageTransparency (val), Attribute_2 (val)
            -- upvalues: Attribute (val), Color (val), Color_2 (val)
            local v1, v2, v3
            local v4 = RaceRally.ResolveRacer(u597.EquippedRacer, u597.Racers)
            local v5 = nil
            local v6 = nil
            for i, j in u234, v5, v6 do
                v1 = true
                if i ~= RaceRally.DefaultRacer then
                    v1 = u597.Racers[i] == true
                end
                v2 = i == v4
                v3 = if not v1 then Attribute_2 else ImageTransparency
                j.ItemIcon.ImageTransparency = v3
                v3 = if v1 then if not v2 then "Equip" else "Equipped" else Attribute
                j.Equipped.Title.Text = v3
                v3 = if not v1 then Color_2 else if v2 then Color_2 else Color
                j.Equipped.UIGradient.Color = v3
            end
        end

        local TabButtonsHolder = Main.TabButtonsHolder
        local u261 = {}
        u261.Shop = {Page = Main.ShopTab, Button = TabButtonsHolder.ShopSlot.Shop}
        u261.Milestones = {Page = Main.MileStoneTab, Button = TabButtonsHolder.Milestones.Milestones}
        u261.Racers = {Page = Main.PetTab, Button = TabButtonsHolder.Racers.Racers}

        local function select(a1) -- Line: 446 -- upvalues: u261 (val) -- types: a1: string
            local v1
            local v2 = nil
            local v3 = nil
            for i, j in u261, v2, v3 do
                v1 = i == a1
                j.Page.Visible = v1
                j.Button.BlackOverlay.Visible = not v1
            end
        end

        for i10, i11 in u261 do
            v5:Add((ButtonFX(i11.Button, 1.06, function() -- Line: 454 -- upvalues: i10 (val), u261 (val)
                local v1
                local v2 = nil
                local v3 = nil
                for i, j in u261, v2, v3 do
                    v1 = i == i10
                    j.Page.Visible = v1
                    j.Button.BlackOverlay.Visible = not v1
                end
            end)))
        end
        local RaceRallyButton = Hud.Every("RaceRallyButton")

        local function refresh() -- Line: 460
            -- upvalues: Save (upval), u597 (ref), RaceRally_2 (upval), QuantityLabel (val), Numbers (upval)
            -- upvalues: refreshShop (val), RaceRally (upval), Card (val), refreshMilestones (val), refreshRacers (val)
            -- upvalues: RaceRallyButton (val)
            local Badge, Wins
            local v1 = Save.Peek()
            local RaceRally_3 = if v1 == nil then nil else v1.RaceRally
            u597 = if RaceRally_3 == nil then RaceRally_2.Blank() else RaceRally_3
            QuantityLabel.Text = Numbers.AddCommas(u597.Tokens)
            refreshShop()
            local v2 = Save.Peek()
            v1 = RaceRally.OwnsDoubleTrophies(if v2 == nil then nil else v2.Products)
            Card.SoldOut.Visible = v1
            Card.Buy.Visible = not v1
            refreshMilestones()
            refreshRacers()
            local v3 = RaceRally.RepeatsEarned(u597.Wins)
            local v4 = u597.Repeats < v3
            for i, j in RaceRally.Milestones do
                if u597.Milestones[i] ~= true then
                    Wins = u597.Wins
                    if j.Wins <= Wins then
                        v4 = true
                    end
                end
            end
            for k, n in RaceRallyButton do
                Badge = n:FindFirstChild("Badge")
                if Badge ~= nil and Badge:IsA("GuiObject") then
                    Badge.Visible = v4
                end
            end
        end

        local function showHudButtons() -- Line: 484
            -- upvalues: Save (upval), RaceRallyFlags (upval), RaceRallyEligibility (upval), RaceRallyButton (val)
            local v1 = Save.Peek()
            local v2 = RaceRallyFlags.ContentEnabled:Get()
            if v2 then
                v2 = false
                if v1 ~= nil then
                    v2 = RaceRallyEligibility.IsEligible(v1.SpeedPower)
                end
            end
            for i, j in RaceRallyButton do
                j.Visible = v2
            end
        end

        for i12, i13 in RaceRallyButton do
            v5:Add((ButtonFX(i13, 1.08, function() -- Line: 495 -- upvalues: Tabs (upval)
                Tabs.Toggle("RaceRally")
            end)))
        end
        v5:Add((Save.WatchFields("RaceRally", refresh)))
        v5:Add((Save.WatchFields("Products", refreshDoubleTrophies)))
        v5:Add((Tabs.Activated:Connect(function(a1) -- Line: 501 -- upvalues: refresh (val) -- types: a1: string
            if a1 == "RaceRally" then
                refresh()
            end
        end)))
        v5:Add((RaceRallyFlags.ContentEnabled.Changed:Connect(showHudButtons)))
        v5:Add((Save.WatchFields("SpeedPower", showHudButtons)))
        v5:Add((RaceRallyEligibility.Changed:Connect(showHudButtons)))
        local GoesAwayTimer = Main:FindFirstChild("GoesAwayTimer")

        local function refreshGoesAway() -- Line: 511
            -- upvalues: GoesAwayTimer (val), UnixTimestamp (upval), Workspace (upval)
            if GoesAwayTimer ~= nil and GoesAwayTimer:IsA("TextLabel") then
                local v1 = math.floor(UnixTimestamp - (Workspace:GetServerTimeNow()))
                GoesAwayTimer.Visible = v1 > 0
                if v1 > 0 then
                    local v2 = v1 // 86400
                    local v3 = v1 // 3600 % 24
                    local v4 = v1 // 60 % 60
                    GoesAwayTimer.Text = ("Goes Away In: %*"):format(if v2 > 0 then ("%*d %*hr"):format(v2, v3) else if not (v3 > 0) then ("%*m %*s"):format(v4, v1 % 60) else ("%*hr %*m"):format(v3, v4))
                end
                return
            end
        end

        v5:Add((task.spawn(function() -- Line: 521 -- upvalues: refreshGoesAway (val)
            while true do
                refreshGoesAway()
                task.wait(1)
            end
        end)))
        v3 = nil
        local v12 = nil
        for i14, i15 in u261, v3, v12 do
            v4 = i14 == "Shop"
            i15.Page.Visible = v4
            i15.Button.BlackOverlay.Visible = not v4
        end
        local v13 = Save.Peek()
        v3 = RaceRallyFlags.ContentEnabled:Get()
        if v3 then
            v3 = false
            if v13 ~= nil then
                v3 = RaceRallyEligibility.IsEligible(v13.SpeedPower)
            end
        end
        for i16, i17 in RaceRallyButton do
            i17.Visible = v3
        end
        refresh()
        v5:Add((task.spawn(function() -- Line: 532
            -- upvalues: Save (upval), RaceRallyFlags (upval), RaceRallyEligibility (upval), RaceRallyButton (val)
            -- upvalues: refresh (val)
            Save.Await()
            local v1 = Save.Peek()
            local v2 = RaceRallyFlags.ContentEnabled:Get()
            if v2 then
                v2 = false
                if v1 ~= nil then
                    v2 = RaceRallyEligibility.IsEligible(v1.SpeedPower)
                end
            end
            for i, j in RaceRallyButton do
                j.Visible = v2
            end
            refresh()
        end)))
        return v5
    end,
}