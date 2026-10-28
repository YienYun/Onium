-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.MasteryInterface
-- Decompile time: 20.26 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local GUI = require(ReplicatedStorage.Client.GUI)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Trove = require(ReplicatedStorage.Packages.Trove)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local ScrambleMastery = require(ReplicatedStorage.Data.ScrambleMastery)
local Assets = require(ReplicatedStorage.Data.Assets)
local ScrambleBossFlags = require(ReplicatedStorage.Shared.Flags.ScrambleBossFlags)
local MilestoneCard = require(ReplicatedStorage.Controllers.GUI.BossMasteryController.MilestoneCard)
local u72 = Color3.fromRGB(80, 255, 120)
local u77 = Color3.fromRGB(255, 64, 64)
local u85 = table.freeze({
    [10] = "10KillsSkin",
    [25] = "25KillsSkin",
    [50] = "50KillsSkin",
    [75] = "75KillsSkin",
    [100] = "100KillsSkin",
})
local v1 = {}

local function toast(a1, a2, a3) -- Line: 29 -- upvalues: Toast (val) -- types: a1: string, a2: userdata, a3: string?
    Toast.Show({
        Seconds = 3,
        SingleLine = true,
        Unique = true,
        Text = a1,
        Color = a2,
        Image = a3,
    })
end

local function rewardOf(a1) -- Line: 32 -- upvalues: ScrambleMastery (val) -- types: a1: string
    local v1 = ScrambleMastery.GetMilestone(a1)
    if v1 then
        return v1.Reward
    end
    return ScrambleMastery.InfiniteReward
end

function v1.new(a1, a2) -- Line: 36
    -- upvalues: Trove (val), GUI (val), ScrambleMastery (val), Assets (val), TweenService (val), AddCommas (val)
    -- upvalues: ScrambleBossFlags (val), Tabs (val), u72 (val), Toast (val), u77 (val), u85 (val), MilestoneCard (val)
    -- upvalues: GamepadBindings (val), ButtonFX (val), GuiService (val)
    local Id, Parent, v1, v2
    local u317 = {}
    local u300 = Trove.new()
    local u321 = u300:Add((Trove.new()))
    local ScrambleBossMastery = GUI.Get("ScrambleBossMastery")
    local Frame = ScrambleBossMastery.Frame
    local BossShopButton = Frame.Header.BossShopButton
    local Amount = Frame.Header.CurrencyHolder.Amount
    local InfoHolder = Frame.InfoHolder
    local NotMax = InfoHolder.NextRewardInfoHolder.NotMax
    local Max = InfoHolder.NextRewardInfoHolder.Max
    local ScrollingFrame = Frame.ScrollingFrame
    local Template = ScrollingFrame.Template
    local NextRewardIcon = Frame.NextRewardIcon
    local u30 = nil
    local Icon = NextRewardIcon.Icon
    local u283 = {}
    local u33 = {}
    local u342 = nil
    local u345 = true
    local u36 = false

    local function available() -- Line: 56 -- upvalues: u342 (ref)
        local v1 = false
        if u342 ~= nil then
            v1 = false
            if u342.Ready == true then
                v1 = false
                if u342.Enabled == true then
                    v1 = false
                    if u342.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u342.EventEndsAt or 0)
                    end
                end
            end
        end
        return v1
    end

    local function refreshNextReward() -- Line: 64
        -- upvalues: NextRewardIcon (val), u30 (ref), u345 (ref), u342 (ref), ScrambleBossMastery (val), Frame (val)
        -- upvalues: ScrollingFrame (val), u321 (val), ScrambleMastery (upval), u283 (val), Icon (val), Assets (upval)
        NextRewardIcon.Visible = false
        u30 = nil
        if u345 then
            local v1 = false
            if u342 ~= nil then
                v1 = false
                if u342.Ready == true then
                    v1 = false
                    if u342.Enabled == true then
                        v1 = false
                        if u342.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u342.EventEndsAt or 0)
                        end
                    end
                end
            end
            if v1 and ScrambleBossMastery.Enabled and Frame.Visible and ScrollingFrame.Visible then
                local AbsolutePosition, AbsolutePosition_2, AbsoluteSize, AbsoluteWindowSize, Mastery, Parent, X, v2, v3
                local State = u342.State
                if not State then
                    return
                end
                for i, j in ScrambleMastery.Milestones do
                    if j.Reward.Kind == "Pet" and State.ClaimedMilestoneIds[j.Id] ~= true then
                        Mastery = State.Mastery
                        if not (j.Kills <= Mastery) then
                            Parent = u283[j.Id].Button.Parent
                            AbsolutePosition = Parent.AbsolutePosition
                            AbsoluteSize = Parent.AbsoluteSize
                            AbsolutePosition_2 = ScrollingFrame.AbsolutePosition
                            AbsoluteWindowSize = ScrollingFrame.AbsoluteWindowSize
                            if Parent.Visible
                                and not (AbsoluteSize.X <= 0)
                                and not (AbsoluteSize.Y <= 0)
                                and not (AbsoluteWindowSize.X <= 0)
                                and not (AbsoluteWindowSize.Y <= 0) then
                                X = AbsolutePosition.X
                                v2 = AbsolutePosition_2.X + AbsoluteWindowSize.X <= X
                                v3 = ScrollingFrame.CanvasPosition.X + AbsoluteWindowSize.X < ScrollingFrame.AbsoluteCanvasSize.X - 1
                                Icon.Image = Assets.Directory[j.Reward.Category].Icon
                                NextRewardIcon.Visible = v2 and v3
                                u30 = if not NextRewardIcon.Visible then nil else Parent
                                return
                            end
                            return
                        end
                    end
                end
                return
            end
        end
        u321:Clean()
    end

    local function scrollToNextReward() -- Line: 96
        -- upvalues: refreshNextReward (val), u30 (ref), u321 (val), ScrollingFrame (val), TweenService (upval)
        refreshNextReward()
        local v1 = u30
        if v1 == nil then
            return
        end
        u321:Clean()
        local X = ScrollingFrame.AbsoluteWindowSize.X
        local v2 = ScrollingFrame.CanvasPosition.X + v1.AbsolutePosition.X - ScrollingFrame.AbsolutePosition.X - (X - v1.AbsoluteSize.X) / 2
        v1 = math.max(0, ScrollingFrame.AbsoluteCanvasSize.X - X)
        local u54 = TweenService:Create(ScrollingFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(math.clamp(v2, 0, v1), ScrollingFrame.CanvasPosition.Y),
        })
        u321:Add(function() -- Line: 110 -- upvalues: u54 (val)
            u54:Cancel()
            u54:Destroy()
        end)
        u54:Play()
    end

    local function refreshCanvas() -- Line: 116 -- upvalues: ScrollingFrame (val), refreshNextReward (val)
        local UIListLayout = ScrollingFrame.UIListLayout
        ScrollingFrame.CanvasSize = UDim2.fromOffset(
            math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
            0
        )
        refreshNextReward()
    end

    local function writeChip(a1, a2) -- Line: 122 -- upvalues: ScrambleMastery (upval)
        local v1 = ScrambleMastery.Presentation(a2)
        a1.Visible = true
        a1.Icon.Image = v1.Icon
        a1.Amount.Text = v1.Amount
        a1.CompletedCheckmark.Visible = false
    end

    local function refresh() -- Line: 129
        -- upvalues: u342 (ref), u345 (ref), Amount (val), AddCommas (upval), InfoHolder (val), ScrambleMastery (upval)
        -- upvalues: u283 (val), NotMax (val), Max (val), refreshNextReward (val)
        local State = u342 and u342.State
        if u345 and State then
            local Mastery, v1, v2
            Amount.Text = AddCommas(State.Samples)
            InfoHolder.MasteryLabel.Text = AddCommas(State.Mastery)
            local v3 = nil
            local v4 = nil
            local v5 = nil
            for i, j in ScrambleMastery.Milestones, v4, v5 do
                if not (State.ClaimedMilestoneIds[j.Id] == true) then
                    Mastery = State.Mastery
                    v2 = if not (j.Kills <= Mastery) then "Locked" else "Claimable"
                else
                    v2 = "Claimed"
                end
                u283[j.Id].Refresh(j.Kills, ScrambleMastery.Presentation(j.Reward), v2, i)
                if v3 == nil and not v1 then
                    v3 = j
                end
            end
            local v6 = ScrambleMastery.FinalMilestone()
            v4 = State.ClaimedMilestoneIds[v6.Id] == true
            v5 = ScrambleMastery.ClaimableInfiniteCount(State)
            local v7 = u283[ScrambleMastery.InfiniteMilestoneId]
            v7.SetVisible(v4)
            v7.Refresh(
                v6.Kills + (State.InfiniteRewardsClaimed + 1) * ScrambleMastery.InfiniteEveryKills,
                ScrambleMastery.Presentation(ScrambleMastery.InfiniteReward),
                if not v4 then "Locked" else if not (v5 > 0) then "Locked" else "Claimable",
                #ScrambleMastery.Milestones + 1
            )
            v2 = v3 ~= nil
            local v8 = v3 == nil
            NotMax.Visible = v2
            Max.Visible = v8
            if not v3 then
                v4 = math.max(State.Mastery - v6.Kills, 0)
                local v9 = if not (v5 > 0) then ScrambleMastery.InfiniteEveryKills - v4 % ScrambleMastery.InfiniteEveryKills else 0
                Max.MasteryGoal.Text = if v9 ~= 0 then ("%* more"):format((AddCommas(v9))) else "Reward ready"
                local Chip_2 = Max.RewardHolder.Chip
                local InfiniteReward = ScrambleMastery.InfiniteReward
                v9 = ScrambleMastery.Presentation(InfiniteReward)
                Chip_2.Visible = true
                Chip_2.Icon.Image = v9.Icon
                Chip_2.Amount.Text = v9.Amount
                Chip_2.CompletedCheckmark.Visible = false
            else
                v7 = math.max(v3.Kills - State.Mastery, 0)
                NotMax.MasteryGoal.Text = if v7 ~= 0 then ("%* more"):format((AddCommas(v7))) else "Reward ready"
                local Chip = NotMax.RewardHolder.Chip
                local Reward = v3.Reward
                v7 = ScrambleMastery.Presentation(Reward)
                Chip.Visible = true
                Chip.Icon.Image = v7.Icon
                Chip.Amount.Text = v7.Amount
                Chip.CompletedCheckmark.Visible = false
            end
            refreshNextReward()
            return
        end
    end

    local function notifyReady() -- Line: 172
        -- upvalues: ScrambleBossFlags (upval), u342 (ref), ScrambleMastery (upval), u33 (val), Tabs (upval)
        -- upvalues: u72 (upval), Toast (upval)
        local Mastery
        if not ScrambleBossFlags.ContentEnabled:Get() then
            return
        end
        local State = u342 and u342.State
        if not State then
            return
        end
        local v1 = {}
        for i, j in ScrambleMastery.Milestones do
            Mastery = State.Mastery
            if j.Kills <= Mastery and not State.ClaimedMilestoneIds[j.Id] then
                table.insert(v1, j.Id)
            end
        end
        local v2 = State.InfiniteRewardsClaimed + 1
        local v3 = v2 + ScrambleMastery.ClaimableInfiniteCount(State) - 1
        for k = v2, v3 do
            table.insert(v1, (("%*:%*"):format(ScrambleMastery.InfiniteMilestoneId, k)))
        end
        v2 = nil
        v3 = v1
        local v4 = nil
        for n, m in v3, v4 do
            if not u33[m] then
                u33[m] = true
                v2 = v2 or m
            end
        end
        if v2 and not Tabs.IsActive("ScrambleBossMastery") then
            v3 = string.split(v2, ":")[1]
            v4 = ScrambleMastery.GetMilestone(v3)
            local Reward = if not v4 then ScrambleMastery.InfiniteReward else v4.Reward
            v3 = if #v1 ~= 1 then ("You have %* Scramble Mastery rewards ready to claim!"):format(#v1) else "You have a Scramble Mastery reward ready to claim!"
            v4 = u72
            local Icon = (ScrambleMastery.Presentation(Reward)).Icon
            Toast.Show({
                Seconds = 3,
                SingleLine = true,
                Unique = true,
                Text = v3,
                Color = v4,
                Image = Icon,
            })
        end
    end

    local function claim(a1_2, a2) -- Line: 206
        -- upvalues: u36 (ref), u342 (ref), a1 (val), u345 (ref), ScrambleMastery (upval), u77 (upval), Toast (upval)
        -- upvalues: u72 (upval), refresh (val)
        if not u36 then
            local v1 = false
            if u342 ~= nil then
                v1 = false
                if u342.Ready == true then
                    v1 = false
                    if u342.Enabled == true then
                        v1 = false
                        if u342.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u342.EventEndsAt or 0)
                        end
                    end
                end
            end
            if v1 then
                local v2
                u36 = true
                a2.SetPending(true)
                local success, err = pcall(a1, "Milestone", a1_2)
                u36 = false
                if not u345 then
                    return
                end
                a2.SetPending(false)
                local Presentation = ScrambleMastery.Presentation
                local v3 = ScrambleMastery.GetMilestone(a1_2)
                local Reward = if not v3 then ScrambleMastery.InfiniteReward else v3.Reward
                local Icon = Presentation(Reward).Icon
                if not success or not err then
                    v2 = u77
                    Toast.Show({
                        Text = "Could not confirm the claim. Try again.",
                        Seconds = 3,
                        SingleLine = true,
                        Unique = true,
                        Color = v2,
                        Image = Icon,
                    })
                elseif err.Ok then
                    v2 = u72
                    Toast.Show({
                        Text = "Scramble Mastery reward claimed!",
                        Seconds = 3,
                        SingleLine = true,
                        Unique = true,
                        Color = v2,
                        Image = Icon,
                    })
                elseif err.Reason == "Busy" or err.Reason == "ProfileUnavailable" then
                    v2 = u77
                    Toast.Show({
                        Text = "Please wait a moment and try again.",
                        Seconds = 3,
                        SingleLine = true,
                        Unique = true,
                        Color = v2,
                        Image = Icon,
                    })
                end
                refresh()
                return
            end
        end
    end

    Template.Visible = false
    NextRewardIcon.Visible = false
    for i, j in u85 do
        ScrollingFrame[j].Visible = false
    end
    local v3 = nil
    local v4 = nil
    for k, n in ScrambleMastery.Milestones, v3, v4 do
        v1 = u85[n.Kills]
        v2 = if not v1 then Template else ScrollingFrame[v1]
        Id = n.Id
        u283[Id] = (MilestoneCard.New(v2, ScrollingFrame, n.Id, claim, v1 ~= nil))
        if n.Reward.Kind == "Pet" then
            Parent = u283[n.Id].Button.Parent
            u300:Connect(Parent:GetPropertyChangedSignal("AbsolutePosition"), refreshNextReward)
            u300:Connect(Parent:GetPropertyChangedSignal("AbsoluteSize"), refreshNextReward)
        end
    end
    u283[ScrambleMastery.InfiniteMilestoneId] = (MilestoneCard.New(Template, ScrollingFrame, ScrambleMastery.InfiniteMilestoneId, claim))
    for m, i5 in u283 do
        u300:Add(i5.Destroy)
    end
    u300:Connect(ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"), refreshNextReward)
    u300:Connect(ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"), refreshCanvas)
    u300:Connect(ScrollingFrame:GetPropertyChangedSignal("AbsolutePosition"), refreshNextReward)
    u300:Connect(ScrollingFrame:GetPropertyChangedSignal("Visible"), refreshNextReward)
    u300:Connect(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), refreshCanvas)
    local UIListLayout = ScrollingFrame.UIListLayout
    ScrollingFrame.CanvasSize = UDim2.fromOffset(
        math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
        0
    )
    refreshNextReward()
    u300:Connect(ScrambleBossMastery:GetPropertyChangedSignal("Enabled"), refreshCanvas)
    u300:Connect(Frame:GetPropertyChangedSignal("Visible"), refreshNextReward)
    local ConsoleButton = BossShopButton.ConsoleButton
    ConsoleButton:SetAttribute("GamepadKey", "ButtonX")
    GamepadBindings.Inspect(ConsoleButton)
    u300:Add((ButtonFX(BossShopButton, 1.08, v5)))
    u300:Add((ButtonFX(NextRewardIcon, 1.05, scrollToNextReward)))
    u300:Add((Tabs.Activated:Connect(function(a1) -- Line: 262 -- upvalues: ScrollingFrame (val), refreshNextReward (val), refresh (val), notifyReady (val)
        if a1 == "ScrambleBossMastery" then
            local UIListLayout = ScrollingFrame.UIListLayout
            ScrollingFrame.CanvasSize = UDim2.fromOffset(
                math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
                0
            )
            refreshNextReward()
            refresh()
            notifyReady()
        end
    end)))

    local function refreshShopButtonPosition() -- Line: 271 -- upvalues: BossShopButton (val), GuiService (upval)
        if BossShopButton.AbsolutePosition.Y < GuiService:GetInsetArea(Enum.ScreenInsets.CoreUISafeInsets).Min.Y then
            BossShopButton.Position = UDim2.new(0, 0, 0, 0)
            BossShopButton.AnchorPoint = Vector2.new(1, 0)
            return
        end
        BossShopButton.Position = UDim2.new(0, 0, -0.275, 0)
        BossShopButton.AnchorPoint = Vector2.new(0, 1)
    end

    u300:Add(((Frame:GetPropertyChangedSignal("AbsolutePosition")):Connect(function() -- Line: 280 -- upvalues: refreshShopButtonPosition (val)
        refreshShopButtonPosition()
    end)))
    refreshShopButtonPosition()

    function u317.Update(a1) -- Line: 286 -- upvalues: u342 (ref), u317 (val), refresh (val), notifyReady (val)
        u342 = a1
        local v1 = false
        if u342 ~= nil then
            v1 = false
            if u342.Ready == true then
                v1 = false
                if u342.Enabled == true then
                    v1 = false
                    if u342.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u342.EventEndsAt or 0)
                    end
                end
            end
        end
        if not v1 then
            u317.Close()
        end
        refresh()
        notifyReady()
    end

    function u317.Toggle() -- Line: 294 -- upvalues: Tabs (upval), u317 (val), u342 (ref), refresh (val)
        if Tabs.IsActive("ScrambleBossMastery") then
            u317.Close()
            return
        end
        local v1 = false
        if u342 ~= nil then
            v1 = false
            if u342.Ready == true then
                v1 = false
                if u342.Enabled == true then
                    v1 = false
                    if u342.WorldReady == true then
                        v1 = (workspace:GetServerTimeNow()) < (u342.EventEndsAt or 0)
                    end
                end
            end
        end
        if v1 and u342.State then
            refresh()
            Tabs.Activate("ScrambleBossMastery")
        end
    end

    function u317.Close() -- Line: 302 -- upvalues: u321 (val), Tabs (upval)
        u321:Clean()
        if Tabs.IsActive("ScrambleBossMastery") then
            Tabs.Deactivate()
        end
    end

    function u317.Destroy() -- Line: 308 -- upvalues: u345 (ref), NextRewardIcon (val), u300 (val)
        u345 = false
        NextRewardIcon.Visible = false
        u300:Destroy()
    end

    return u317
end

return v1