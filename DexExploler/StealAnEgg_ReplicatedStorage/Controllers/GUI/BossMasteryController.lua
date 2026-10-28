-- Script path: ReplicatedStorage.Controllers.GUI.BossMasteryController
-- Decompile time: 20.42 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local MilestoneCard = require(script.MilestoneCard)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u87 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u92 = Color3.fromRGB(255, 64, 64)
local u97 = Color3.fromRGB(80, 255, 120)
return {
    Start = function() -- Line: 32
        -- upvalues: GUI (val), Trove (val), GamepadBindings (val), ButtonFX (val), Tabs (val), BossMastery (val)
        -- upvalues: Simple (val), Numbers (val), GuiService (val), MenuNavigation (val), Save (val), TweenService (val)
        -- upvalues: u87 (val), BossEventFlags (val), BossMasteryFlags (val), Toast (val), u97 (val), u92 (val)
        -- upvalues: Remotes (val), MilestoneCard (val)
        local Frame = GUI.BossMastery().Frame
        local Close = Frame.Close
        local Header = Frame.Header
        local BossShopButton = Header.BossShopButton
        local GamepadGlyph = BossShopButton.GamepadGlyph
        local Amount = Header.CurrencyHolder.Amount
        local InfoHolder = Frame.InfoHolder
        local MasteryLabel = InfoHolder.MasteryLabel
        local NextRewardInfoHolder = InfoHolder.NextRewardInfoHolder
        local NotMax = NextRewardInfoHolder.NotMax
        local Max = NextRewardInfoHolder.Max
        local ScrollingFrame = Frame.ScrollingFrame
        local Template = ScrollingFrame.Template
        local v1 = Trove.new()
        local u22 = Trove.new()
        local u23 = {}
        local u24 = {}
        local u25 = {}
        local u128 = nil
        local u134 = nil
        local u28 = nil
        v1:Add(u22)
        ScrollingFrame.Selectable = false
        GamepadGlyph:SetAttribute("GamepadKey", "ButtonX")
        GamepadBindings.Inspect(GamepadGlyph)
        v1:Add((ButtonFX(BossShopButton, 1.08, function() -- Line: 67 -- upvalues: Tabs (upval)
            Tabs.Activate("BossShop")
        end)))

        local function rewardPresentation(a1, a2, a3) -- Line: 70 -- upvalues: BossMastery (upval) -- types: a3: number?
            return BossMastery.GetRewardPresentation(a1, a2, a3)
        end

        local function milestonePresentation(a1, a2) -- Line: 78 -- upvalues: BossMastery (upval)
            return BossMastery.GetMilestonePresentation(a1, a2)
        end

        local function nextInfinitePresentation(a1, a2, a3) -- Line: 85
            -- upvalues: rewardPresentation (val), BossMastery (upval)
            return rewardPresentation(BossMastery.GetInfiniteReward(), a2[BossMastery.InfiniteRevealKey(a1 + 1)], a3)
        end

        local function revealsOf(a1) -- Line: 99 -- types: a1: table
            return a1.RevealedRewards or {}
        end

        local function writeRewardCell(a1, a2, a3) -- Line: 105 -- types: a1: userdata, a3: boolean
            local Icon = a1.Icon
            local Amount = a1.Amount
            local CompletedCheckmark = a1.CompletedCheckmark
            Icon.Image = a2.Icon
            Amount.Text = a2.Amount
            CompletedCheckmark.Visible = a3
        end

        local function orderedMilestones() -- Line: 118 -- upvalues: BossMastery (upval)
            local v1 = table.clone(BossMastery.Milestones)
            table.sort(v1, function(a1, a2) -- Line: 122 -- upvalues: BossMastery (upval)
                local v1 = BossMastery.GetMilestoneKills(a1)
                local v2 = BossMastery.GetMilestoneKills(a2)
                if v1 == v2 then
                    return a1.Id < a2.Id
                end
                return v1 < v2
            end)
            return v1
        end

        local function formatTokens(a1) -- Line: 137 -- upvalues: Simple (upval), Numbers (upval) -- types: a1: number
            if 99999 < (math.abs(a1)) then
                return Simple.FormatCompact(math.round(a1), ".#")
            end
            return Numbers.AddCommas((math.round(a1)))
        end

        local function rememberMilestone(a1) -- Line: 144
            -- upvalues: u28 (ref), BossShopButton (val), Close (val)
            u28 = a1
            BossShopButton.NextSelectionDown = a1
            Close.NextSelectionDown = a1
        end

        local function refreshNavigation(a1, a2) -- Line: 150
            -- upvalues: u23 (val), BossMastery (upval), BossShopButton (val), Close (val), u28 (ref)
            -- upvalues: GuiService (upval), Tabs (upval), MenuNavigation (upval)
            local v1, v2
            local v3 = {}
            for i, j in a1 do
                table.insert(v3, u23[j.Id].Button)
            end
            local Button = u23[BossMastery.InfiniteMilestoneId].Button
            if a2 then
                table.insert(v3, Button)
            end
            local v4 = nil
            local v5 = nil
            for k, n in v3, v4, v5 do
                v1 = k == 1
                n:SetAttribute("DefaultFocus", v1)
                v2 = v3[k - 1] or BossShopButton
                n.NextSelectionLeft = v2
                v2 = v3[k + 1] or Close
                n.NextSelectionRight = v2
                n.NextSelectionUp = BossShopButton
                n.NextSelectionDown = n
            end
            local v6 = u28
            if v6 == nil or table.find(v3, v6) == nil then
                v6 = if u28 ~= Button then v3[1] else v3[#v3]
            end
            if v6 then
                u28 = v6
                BossShopButton.NextSelectionDown = v6
                Close.NextSelectionDown = v6
            end
            BossShopButton.NextSelectionLeft = BossShopButton
            BossShopButton.NextSelectionRight = Close
            BossShopButton.NextSelectionUp = BossShopButton
            Close.NextSelectionLeft = BossShopButton
            Close.NextSelectionRight = Close
            Close.NextSelectionUp = Close
            if not a2
                and GuiService.SelectedObject == Button
                and Tabs.IsActive("BossMastery")
                and not MenuNavigation.IsCursorActive()
                and not MenuNavigation.IsSuspended() then
                GuiService.SelectedObject = v6
            end
        end

        local function setTokenText(a1) -- Line: 199
            -- upvalues: Amount (val), Simple (upval), Numbers (upval)
            local v1 = if not (99999 < (math.abs(a1))) then Numbers.AddCommas((math.round(a1))) else Simple.FormatCompact(math.round(a1), ".#")
            Amount.Text = v1
        end

        local function refreshTokenBalance(a1) -- Line: 203
            -- upvalues: Save (upval), u134 (ref), u128 (ref), u22 (val), Amount (val), Simple (upval), Numbers (upval)
            -- upvalues: setTokenText (val), TweenService (upval), u87 (upval)
            local v1 = Save.Await()
            if v1 == nil then
                return
            end
            local BossTokens = v1.BossTokens
            local Value = if not u134 then u128 else u134.Value
            u128 = BossTokens
            u22:Clean()
            u134 = nil
            if not a1 and Value ~= nil and Value ~= BossTokens then
                local NumberValue = Instance.new("NumberValue")
                NumberValue.Value = Value
                u134 = NumberValue
                u22:Add(NumberValue)
                u22:Connect(NumberValue.Changed, setTokenText)
                local v2 = if not (99999 < (math.abs(Value))) then Numbers.AddCommas((math.round(Value))) else Simple.FormatCompact(math.round(Value), ".#")
                Amount.Text = v2
                v1 = TweenService:Create(NumberValue, u87, {Value = BossTokens})
                u22:Add(v1)
                v1:Play()
                return
            end
            local v3 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
            Amount.Text = v3
        end

        local function refresh() -- Line: 233
            -- upvalues: BossEventFlags (upval), Save (upval), BossMastery (upval), MasteryLabel (val), Numbers (upval)
            -- upvalues: u23 (val), BossMasteryFlags (upval), refreshNavigation (val), NotMax (val), Max (val)
            local Refresh, v1, v2, v3, v4, v5
            if not BossEventFlags.ContentEnabled:Get() then
                return
            end
            local v6 = Save.Await()
            if v6 == nil then
                return
            end
            local BossMastery_2 = v6.BossMastery
            local RevealedRewards = BossMastery_2.RevealedRewards or {}
            local v7 = table.clone(BossMastery.Milestones)
            table.sort(v7, function(a1, a2) -- Line: 122 -- upvalues: BossMastery (upval)
                local v1 = BossMastery.GetMilestoneKills(a1)
                local v2 = BossMastery.GetMilestoneKills(a2)
                if v1 == v2 then
                    return a1.Id < a2.Id
                end
                return v1 < v2
            end)
            local v8 = BossMastery.FinalMilestone()
            local v9 = BossMastery_2.ClaimedMilestoneIds[v8.Id] == true
            local v10 = nil
            local v11 = nil
            MasteryLabel.Text = Numbers.AddCommas((math.round(BossMastery_2.Mastery)))
            local v12 = nil
            local v13 = nil
            for i, j in v7, v12, v13 do
                v1 = BossMastery.GetMilestoneKills(j)
                v2 = BossMastery_2.ClaimedMilestoneIds[j.Id] == true
                v3 = assert(u23[j.Id], (("Missing Boss Mastery card %*"):format(j.Id)))
                v4 = if not v2 then if not (v1 <= BossMastery_2.Mastery) then "Locked" else "Claimable" else "Claimed"
                Refresh = v3.Refresh
                v5 = RevealedRewards[j.Id]
                Refresh(v1, BossMastery.GetMilestonePresentation(j, v5), v4, i)
                if v2 or not (v1 <= BossMastery_2.Mastery) then
                    if BossMastery_2.Mastery < v1 and v11 == nil then
                        v11 = j
                    end
                elseif v10 == nil then
                    v10 = j
                elseif BossMastery_2.Mastery < v1 and v11 == nil then
                    v11 = j
                end
            end
            local v14 = BossMasteryFlags.InfiniteRewardEveryKills:Get()
            v12 = BossMastery.GetMilestoneKills(v8)
            v8 = BossMastery.ClaimableInfiniteCount(BossMastery_2)
            v13 = v12 + (BossMastery_2.InfiniteRewardsClaimed + 1) * v14
            local v15 = assert(u23[BossMastery.InfiniteMilestoneId], "Missing infinite Boss Mastery card")
            local InfiniteRewardsClaimed = BossMastery_2.InfiniteRewardsClaimed
            v3 = BossMastery.GetInfiniteReward()
            v4 = RevealedRewards[BossMastery.InfiniteRevealKey(InfiniteRewardsClaimed + 1)]
            v1 = BossMastery.GetRewardPresentation(v3, v4, 1)
            refreshNavigation(v7, v9)
            v15.SetVisible(v9)
            v15.Refresh(v13, v1, if not v9 then "Locked" else if not (v8 > 0) then "Locked" else "Claimable", #v7 + 1)
            local v16 = v10 or v11
            if v16 == nil then
                v10 = math.max(BossMastery_2.Mastery - v12, 0)
                v9 = if not (v8 > 0) then v10 % v14 else v14
                v10 = if not (v8 > 0) then v14 - v9 else 0
                local MasteryGoal_2 = Max.MasteryGoal
                NotMax.Visible = false
                Max.Visible = true
                MasteryGoal_2.Text = if v10 ~= 0 then ("%* more"):format((Numbers.AddCommas(v10))) else "Reward ready"
                local Template_2 = Max.Template
                local Icon_2 = Template_2.Icon
                local Amount_2 = Template_2.Amount
                local CompletedCheckmark_2 = Template_2.CompletedCheckmark
                Icon_2.Image = v1.Icon
                Amount_2.Text = v1.Amount
                CompletedCheckmark_2.Visible = false
                return
            end
            local MasteryGoal = NotMax.MasteryGoal
            v11 = math.max(BossMastery.GetMilestoneKills(v16) - BossMastery_2.Mastery, 0)
            NotMax.Visible = true
            Max.Visible = false
            MasteryGoal.Text = if v11 ~= 0 then ("%* more"):format((Numbers.AddCommas(v11))) else "Reward ready"
            local Template = NotMax.Template
            v4 = RevealedRewards[v16.Id]
            v3 = BossMastery.GetMilestonePresentation(v16, v4)
            v4 = BossMastery_2.ClaimedMilestoneIds[v16.Id] == true
            local Icon = Template.Icon
            local Amount = Template.Amount
            local CompletedCheckmark = Template.CompletedCheckmark
            Icon.Image = v3.Icon
            Amount.Text = v3.Amount
            CompletedCheckmark.Visible = v4
        end

        local function readyRewards() -- Line: 335 -- upvalues: Save (upval), BossMastery (upval)
            local Mastery, v1, v2, v3, v4
            local v5 = Save.Await()
            if v5 == nil then
                return {}
            end
            local BossMastery_2 = v5.BossMastery
            local RevealedRewards = BossMastery_2.RevealedRewards or {}
            local v6 = {}
            for i, j in BossMastery.Milestones do
                Mastery = BossMastery_2.Mastery
                if BossMastery.GetMilestoneKills(j) <= Mastery and not BossMastery_2.ClaimedMilestoneIds[j.Id] then
                    v1 = {Key = j.Id}
                    v3 = RevealedRewards[j.Id]
                    v1.Icon = BossMastery.GetMilestonePresentation(j, v3).Icon
                    table.insert(v6, v1)
                end
            end
            local v7 = BossMastery.ClaimableInfiniteCount(BossMastery_2)
            local v8 = BossMastery_2.InfiniteRewardsClaimed + 1
            local v9 = BossMastery_2.InfiniteRewardsClaimed + v7
            for k = v8, v9 do
                v4 = {Key = ("%*:%*"):format(BossMastery.InfiniteMilestoneId, k)}
                v2 = BossMastery.GetInfiniteReward()
                v3 = RevealedRewards[BossMastery.InfiniteRevealKey(k)]
                v4.Icon = BossMastery.GetRewardPresentation(v2, v3, nil).Icon
                table.insert(v6, v4)
            end
            return v6
        end

        local function updateReadyRewardNotification() -- Line: 375
            -- upvalues: BossEventFlags (upval), readyRewards (val), Tabs (upval), u25 (val), Toast (upval), u97 (upval)
            if not BossEventFlags.ContentEnabled:Get() then
                return
            end
            local v1 = readyRewards()
            if Tabs.IsActive("BossMastery") then
                for k, n in v1 do
                    u25[n.Key] = true
                end
                return
            end
            local v2 = {}
            for i, j in v1 do
                if not u25[j.Key] then
                    u25[j.Key] = true
                    table.insert(v2, j)
                end
            end
            if #v2 == 0 then
                return
            end
            local v3 = #v1
            Toast.Show({
                Seconds = 3,
                SingleLine = true,
                Text = if v3 ~= 1 then ("You have %* Boss Mastery rewards ready to claim!"):format(v3) else "You have a Boss Mastery reward ready to claim!",
                Color = u97,
                Image = v2[1].Icon,
            })
        end

        local function showClaimResult(a1, a2, a3, a4) -- Line: 409
            -- upvalues: Save (upval), BossMastery (upval), Toast (upval), u97 (upval), u92 (upval)
            local v1, v2
            local v3 = Save.Await()
            local BossMastery_2 = if not v3 then nil else v3.BossMastery
            local RevealedRewards = BossMastery_2 and BossMastery_2.RevealedRewards or {}
            local v4 = BossMastery.GetMilestone(a1)
            if v4 == nil then
                v2 = a4 or (if not BossMastery_2 then 1 else BossMastery_2.InfiniteRewardsClaimed + 1)
                local v5 = BossMastery.GetInfiniteReward()
                local v6 = RevealedRewards[BossMastery.InfiniteRevealKey(v2)]
                v1 = BossMastery.GetRewardPresentation(v5, v6, nil)
            else
                v2 = RevealedRewards[v4.Id]
                v1 = BossMastery.GetMilestonePresentation(v4, v2)
            end
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Text = if not a2 then a3 or "Claim failed" else "Boss Mastery reward claimed!",
                Color = if not a2 then u92 else u97,
                Image = v1.Icon,
            })
        end

        local function requestClaim(a1, a2) -- Line: 442
            -- upvalues: u24 (val), Save (upval), BossMastery (upval), Remotes (upval), showClaimResult (val)
            -- upvalues: refresh (val)
            local err, success, v1
            if u24[a1] then
                return
            end
            local v2 = Save.Await()
            if v2 == nil then
                return
            end
            local BossMastery_2 = v2.BossMastery
            local v3 = BossMastery.GetMilestone(a1)
            if v3 then
                if not BossMastery_2.ClaimedMilestoneIds[a1]
                    and not (BossMastery_2.Mastery < BossMastery.GetMilestoneKills(v3)) then
                    u24[a1] = {
                        Controller = a2,
                        RewardIndex = if a1 ~= BossMastery.InfiniteMilestoneId then nil else v2.BossMastery.InfiniteRewardsClaimed + 1,
                    }
                    a2.SetPending(true)
                    success, err, v1 = pcall(function() -- Line: 484 -- upvalues: Remotes (upval), a1 (val)
                        return Remotes.BossMastery.AskClaimMilestone:InvokeServer(a1)
                    end)
                    u24[a1] = nil
                    a2.SetPending(false)
                    if success and err then
                        refresh()
                        showClaimResult(a1, true, v1, v3)
                        return
                    end
                    if not success then
                        showClaimResult(a1, false, "Something went wrong, please try again.", v3)
                        return
                    end
                    showClaimResult(a1, false, v1, v3)
                    return
                end
                return
            end
            if a1 == BossMastery.InfiniteMilestoneId
                and BossMastery_2.ClaimedMilestoneIds[BossMastery.FinalMilestone().Id]
                and not ((BossMastery.ClaimableInfiniteCount(BossMastery_2)) <= 0) then
                u24[a1] = {
                    Controller = a2,
                    RewardIndex = if a1 ~= BossMastery.InfiniteMilestoneId then nil else v2.BossMastery.InfiniteRewardsClaimed + 1,
                }
                a2.SetPending(true)
                success, err, v1 = pcall(function() -- Line: 484 -- upvalues: Remotes (upval), a1 (val)
                    return Remotes.BossMastery.AskClaimMilestone:InvokeServer(a1)
                end)
                u24[a1] = nil
                a2.SetPending(false)
                if success and err then
                    refresh()
                    showClaimResult(a1, true, v1, v3)
                    return
                end
                if not success then
                    showClaimResult(a1, false, "Something went wrong, please try again.", v3)
                    return
                end
                showClaimResult(a1, false, v1, v3)
                return
            end
        end

        Template.Visible = false
        local v2 = nil
        for i, j in BossMastery.Milestones, v2 do
            local u272 = MilestoneCard.New(Template, ScrollingFrame, j.Id, requestClaim)
            u23[j.Id] = u272
            v1:Add((u272.Button.SelectionGained:Connect(function() -- Line: 514 -- upvalues: MenuNavigation (upval), u272 (val), u28 (ref), BossShopButton (val), Close (val)
                if not MenuNavigation.IsCursorActive() then
                    local Button = u272.Button
                    u28 = Button
                    BossShopButton.NextSelectionDown = Button
                    Close.NextSelectionDown = Button
                end
            end)))
            v1:Add(u272.Destroy)
        end
        local u89 = MilestoneCard.New(Template, ScrollingFrame, BossMastery.InfiniteMilestoneId, requestClaim)
        u23[BossMastery.InfiniteMilestoneId] = u89
        v1:Add((u89.Button.SelectionGained:Connect(function() -- Line: 529 -- upvalues: MenuNavigation (upval), u89 (val), u28 (ref), BossShopButton (val), Close (val)
            if not MenuNavigation.IsCursorActive() then
                local Button = u89.Button
                u28 = Button
                BossShopButton.NextSelectionDown = Button
                Close.NextSelectionDown = Button
            end
        end)))
        v1:Add(u89.Destroy)
        Save.Await()

        local function onCatalogChanged() -- Line: 538 -- upvalues: refresh (val), updateReadyRewardNotification (val)
            refresh()
            updateReadyRewardNotification()
        end

        refresh()
        local v3 = Save.Await()
        if v3 ~= nil then
            local BossTokens = v3.BossTokens
            if u134 then
                local Value = u134.Value
            end
            u128 = BossTokens
            u22:Clean()
            u134 = nil
            v2 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
            Amount.Text = v2
        end
        updateReadyRewardNotification()
        v1:Add((Save.WatchFields("BossMastery", function() -- Line: 546 -- upvalues: refresh (val), updateReadyRewardNotification (val)
            refresh()
            updateReadyRewardNotification()
        end)))
        v1:Add((Save.WatchFields("BossTokens", function() -- Line: 550 -- upvalues: refreshTokenBalance (val)
            refreshTokenBalance()
        end)))
        v1:Add((BossMasteryFlags.MilestoneKillOverrides.Changed:Connect(onCatalogChanged)))
        v1:Add((BossMasteryFlags.MilestoneRewardIdOverrides.Changed:Connect(onCatalogChanged)))
        v1:Add((BossMasteryFlags.TokenBoostPercentOverrides.Changed:Connect(onCatalogChanged)))
        v1:Add((BossMasteryFlags.InfiniteRewardEveryKills.Changed:Connect(onCatalogChanged)))
        v1:Add((BossMasteryFlags.InfiniteRewardId.Changed:Connect(onCatalogChanged)))
        v1:Add((BossMasteryFlags.InfiniteBannerWeights.Changed:Connect(onCatalogChanged)))
        v1:Add((Tabs.Activated:Connect(function(a1) -- Line: 575
            -- upvalues: refresh (val), Save (upval), u134 (ref), u128 (ref), u22 (val), Amount (val), Simple (upval)
            -- upvalues: Numbers (upval), updateReadyRewardNotification (val)
            if a1 == "BossMastery" then
                refresh()
                local v1 = Save.Await()
                if v1 ~= nil then
                    local BossTokens = v1.BossTokens
                    if u134 then
                        local Value = u134.Value
                    end
                    u128 = BossTokens
                    u22:Clean()
                    u134 = nil
                    local v2 = if not (99999 < (math.abs(BossTokens))) then Numbers.AddCommas((math.round(BossTokens))) else Simple.FormatCompact(math.round(BossTokens), ".#")
                    Amount.Text = v2
                end
                updateReadyRewardNotification()
            end
        end)))
        return v1
    end,
}