-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.BossMastery
-- Decompile time: 17.53 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
require(ReplicatedStorage.Shared.Types.HalloweenDimension)
local Hud = require(ReplicatedStorage.Client.Hud)
local HalloweenBossMastery = require(ReplicatedStorage.Data.HalloweenBossMastery)
local MilestoneCard = require(ReplicatedStorage.Controllers.GUI.BossMasteryController.MilestoneCard)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Inside = HalloweenDimension.PlayerAttributes.Inside
local u87 = Color3.fromRGB(80, 255, 120)
local u93 = Color3.fromRGB(255, 64, 64)
local u103 = table.freeze({
    [3] = "MasteryRow_Purple",
    [10] = "MasteryRow_Purple",
    [17] = "MasteryRow_Gold",
    [30] = "MasteryRow_Gold",
    [45] = "MasteryRow_Gold",
    [52] = "MasteryRow_Gold",
    [65] = "MasteryRow_Rainbow",
})
local v1 = {}

local function toast(a1, a2, a3) -- Line: 49 -- upvalues: Toast (val) -- types: a1: string, a2: userdata, a3: string?
    Toast.Show({
        Seconds = 3,
        SingleLine = true,
        Unique = true,
        Text = a1,
        Color = a2,
        Image = a3,
    })
end

local function rewardOf(a1) -- Line: 53 -- upvalues: HalloweenBossMastery (val) -- types: a1: string
    return assert(HalloweenBossMastery.GetMilestone(a1), (("Unknown milestone %*"):format(a1))).Reward
end

local function available() -- Line: 57 -- upvalues: PumpkinBossFlags (val), LocalPlayer (val), Inside (val)
    return PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
end

local function savedState() -- Line: 61 -- upvalues: Save (val)
    local v1 = Save.Peek()
    if v1 ~= nil then
        return v1.HalloweenDimension.BossMastery
    end
    return nil
end

local function readyKeys(a1) -- Line: 67 -- upvalues: HalloweenBossMastery (val)
    local Mastery
    local v1 = {}
    for i, j in HalloweenBossMastery.Milestones do
        Mastery = a1.Mastery
        if j.Kills <= Mastery and not a1.ClaimedMilestoneIds[j.Id] then
            table.insert(v1, j.Id)
        end
    end
    return v1
end

function v1.Start(a1) -- Line: 81
    -- upvalues: GUI (val), Hud (val), Save (val), PumpkinBossFlags (val), LocalPlayer (val), Inside (val)
    -- upvalues: HalloweenBossMastery (val), Assets (val), readyKeys (val), Numbers (val), Tabs (val), u87 (val)
    -- upvalues: Toast (val), Remotes (val), u93 (val), u103 (val), MilestoneCard (val), ButtonFX (val)
    local Parent, v1, v2, v3
    local HalloweenBossMastery_2 = GUI.Get("HalloweenBossMastery")
    local Frame = HalloweenBossMastery_2.Frame
    local Main = GUI.Get("HalloweenDimensionEggUI").Main
    local Mastery = Main.TabButtonsHolder.Mastery
    local v4 = {
        {
            Tab = "HalloweenDimensionEggUI",
            Button = Frame.TabButtonsHolder.ShopSlot.Shop,
        },
        {Tab = "HalloweenBossMastery", Button = Frame.TabButtonsHolder.Mastery.Mastery},
        {Tab = "HalloweenDimensionEggUI", Button = Main.TabButtonsHolder.ShopSlot.Shop},
        {Tab = "HalloweenBossMastery", Button = Mastery.Mastery},
    }
    local Amount = Frame.Header.CurrencyHolder.Amount
    local InfoHolder = Frame.InfoHolder
    local NotMax = InfoHolder.NextRewardInfoHolder.NotMax
    local Max = InfoHolder.NextRewardInfoHolder.Max
    local ScrollingFrame = Frame.ScrollingFrame
    local NextRewardIcon = Frame.NextRewardIcon
    local Icon = Frame.NextRewardIcon.Icon
    local HalloweenMasteryButton = Hud.Every("HalloweenMasteryButton")
    local u319 = {}
    local u45 = {}
    local u46 = false

    local function refreshNextReward() -- Line: 103
        -- upvalues: NextRewardIcon (val), Save (upval), PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval)
        -- upvalues: HalloweenBossMastery_2 (val), Frame (val), ScrollingFrame (val), HalloweenBossMastery (upval)
        -- upvalues: u319 (val), Icon (val), Assets (upval)
        NextRewardIcon.Visible = false
        local v1 = Save.Peek()
        local BossMastery = if v1 == nil then nil else v1.HalloweenDimension.BossMastery
        if BossMastery ~= nil then
            v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
            if v1 and HalloweenBossMastery_2.Enabled and Frame.Visible and ScrollingFrame.Visible then
                local AbsolutePosition, AbsolutePosition_2, AbsoluteSize, AbsoluteWindowSize, Mastery, Parent, X, v2, v3
                for i, j in HalloweenBossMastery.Milestones do
                    if j.Reward.Kind == "Pet" and BossMastery.ClaimedMilestoneIds[j.Id] ~= true then
                        Mastery = BossMastery.Mastery
                        if not (j.Kills <= Mastery) then
                            Parent = u319[j.Id].Button.Parent
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
                                return
                            end
                            return
                        end
                    end
                end
                return
            end
        end
    end

    local function refreshCanvas() -- Line: 131 -- upvalues: ScrollingFrame (val), refreshNextReward (val)
        local UIListLayout = ScrollingFrame.UIListLayout
        ScrollingFrame.CanvasSize = UDim2.fromOffset(
            math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
            0
        )
        refreshNextReward()
    end

    local function writeChip(a1, a2) -- Line: 138 -- upvalues: HalloweenBossMastery (upval)
        local v1 = HalloweenBossMastery.Presentation(a2)
        a1.Visible = true
        a1.Icon.Image = v1.Icon
        a1.Amount.Text = v1.Amount
        a1.CompletedCheckmark.Visible = false
    end

    local function refreshHud(a1) -- Line: 146
        -- upvalues: PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval), readyKeys (upval), Mastery (val)
        -- upvalues: HalloweenMasteryButton (val)
        local Badge
        local v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
        local v2 = v1
        if v2 then
            v2 = false
            if a1 ~= nil then
                v2 = #readyKeys(a1) > 0
            end
        end
        Mastery.Visible = v1
        for i, j in HalloweenMasteryButton do
            j.Visible = v1
            Badge = j:FindFirstChild("Badge")
            if Badge ~= nil then
                Badge.Visible = v2
            end
        end
    end

    local function refresh() -- Line: 160
        -- upvalues: Save (upval), Amount (val), Numbers (upval), InfoHolder (val), HalloweenBossMastery (upval)
        -- upvalues: u319 (val), NotMax (val), Max (val), refreshNextReward (val)
        local Mastery, v1, v2
        local v3 = Save.Peek()
        local BossMastery = if v3 == nil then nil else v3.HalloweenDimension.BossMastery
        v3 = Save.Peek()
        Amount.Text = Numbers.AddCommas(if v3 == nil then 0 else v3.HalloweenTokens)
        if BossMastery == nil then
            return
        end
        InfoHolder.MasteryLabel.Text = Numbers.AddCommas(BossMastery.Mastery)
        v3 = nil
        local v4 = nil
        local v5 = nil
        for i, j in HalloweenBossMastery.Milestones, v4, v5 do
            if not (BossMastery.ClaimedMilestoneIds[j.Id] == true) then
                Mastery = BossMastery.Mastery
                v2 = if not (j.Kills <= Mastery) then "Locked" else "Claimable"
            else
                v2 = "Claimed"
            end
            u319[j.Id].Refresh(j.Kills, HalloweenBossMastery.Presentation(j.Reward), v2, i)
            if v3 == nil and not v1 then
                v3 = j
            end
        end
        local v6 = v3 == nil
        v4 = v3 or HalloweenBossMastery.Milestones[#HalloweenBossMastery.Milestones]
        v3 = math.max(v4.Kills - BossMastery.Mastery, 0)
        local v7 = Max
        NotMax.Visible = true
        v7.Visible = false
        NotMax.MasteryGoal.Text = if v6 then "All claimed" else if v3 ~= 0 then ("%* more"):format((Numbers.AddCommas(v3))) else "Reward ready"
        local Chip = NotMax.RewardHolder.Chip
        local Reward = v4.Reward
        v3 = HalloweenBossMastery.Presentation(Reward)
        Chip.Visible = true
        Chip.Icon.Image = v3.Icon
        Chip.Amount.Text = v3.Amount
        Chip.CompletedCheckmark.Visible = false
        NotMax.RewardHolder.Chip.CompletedCheckmark.Visible = v6
        refreshNextReward()
    end

    local function notifyReady(a1) -- Line: 194
        -- upvalues: PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval), readyKeys (upval), u45 (val)
        -- upvalues: Tabs (upval), HalloweenBossMastery (upval), u87 (upval), Toast (upval)
        if a1 ~= nil then
            local v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
            if v1 then
                v1 = readyKeys(a1)
                local v2 = nil
                local v3 = nil
                local v4 = nil
                for i, j in v1, v3, v4 do
                    if not u45[j] then
                        u45[j] = true
                        v2 = v2 or j
                    end
                end
                if v2 and not Tabs.IsActive("HalloweenBossMastery") then
                    local Reward = assert(HalloweenBossMastery.GetMilestone(v2), (("Unknown milestone %*"):format(v2))).Reward
                    v3 = if #v1 ~= 1 then ("You have %* Pumpkin King Mastery rewards ready to claim!"):format(#v1) else "You have a Pumpkin King Mastery reward ready to claim!"
                    v4 = u87
                    local Icon = (HalloweenBossMastery.Presentation(Reward)).Icon
                    Toast.Show({
                        Seconds = 3,
                        SingleLine = true,
                        Unique = true,
                        Text = v3,
                        Color = v4,
                        Image = Icon,
                    })
                end
                return
            end
        end
    end

    local function sync() -- Line: 218
        -- upvalues: Save (upval), PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval), Tabs (upval)
        -- upvalues: refreshHud (val), refresh (val), notifyReady (val)
        local v1 = Save.Peek()
        local BossMastery = if v1 == nil then nil else v1.HalloweenDimension.BossMastery
        v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
        if not v1 and Tabs.IsActive("HalloweenBossMastery") then
            Tabs.Deactivate()
        end
        refreshHud(BossMastery)
        refresh()
        notifyReady(BossMastery)
    end

    local function claim(a1, a2) -- Line: 228
        -- upvalues: u46 (ref), PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval), Remotes (upval)
        -- upvalues: HalloweenBossMastery (upval), u87 (upval), Toast (upval), u93 (upval), refresh (val)
        if not u46 then
            local v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
            if v1 then
                local v2
                u46 = true
                a2.SetPending(true)
                local success, err, v3 = pcall(function() -- Line: 234 -- upvalues: Remotes (upval), a1 (val)
                    return Remotes.HalloweenDimension.AskClaimMastery:InvokeServer(a1)
                end)
                u46 = false
                a2.SetPending(false)
                local Icon = HalloweenBossMastery.Presentation(assert(HalloweenBossMastery.GetMilestone(a1), (("Unknown milestone %*"):format(a1))).Reward).Icon
                if not success or err ~= true then
                    v2 = if not success then "Could not confirm the claim. Try again." else if typeof(v3) ~= "string" then "Could not confirm the claim. Try again." else v3
                    local v4 = u93
                    Toast.Show({
                        Seconds = 3,
                        SingleLine = true,
                        Unique = true,
                        Text = v2,
                        Color = v4,
                        Image = Icon,
                    })
                else
                    v2 = u87
                    Toast.Show({
                        Text = "Pumpkin King Mastery reward claimed!",
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

    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("GuiObject") and string.find(j.Name, "MasteryRow", 1, true) == 1 then
            j.Visible = false
        end
    end
    local v5 = nil
    local v6 = nil
    for k, n in HalloweenBossMastery.Milestones, v5, v6 do
        v2 = u103[n.Kills]
        v3 = MilestoneCard.New(ScrollingFrame[v2 or "MasteryRow"], ScrollingFrame, n.Id, claim, v2 ~= nil)
        u319[n.Id] = v3
        if n.Reward.Kind == "Pet" then
            Parent = v3.Button.Parent
            v1:Connect(Parent:GetPropertyChangedSignal("AbsolutePosition"), refreshNextReward)
            v1:Connect(Parent:GetPropertyChangedSignal("AbsoluteSize"), refreshNextReward)
        end
    end
    for m, i5 in u319 do
        v1:Add(i5.Destroy)
    end
    NextRewardIcon.Visible = false
    v1:Connect(ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"), refreshNextReward)
    v1:Connect(ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"), refreshCanvas)
    v1:Connect(ScrollingFrame:GetPropertyChangedSignal("AbsolutePosition"), refreshNextReward)
    v1:Connect(ScrollingFrame:GetPropertyChangedSignal("Visible"), refreshNextReward)
    v1:Connect(ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), refreshCanvas)
    v1:Connect(HalloweenBossMastery_2:GetPropertyChangedSignal("Enabled"), refreshCanvas)
    v1:Connect(Frame:GetPropertyChangedSignal("Visible"), refreshNextReward)
    local UIListLayout = ScrollingFrame.UIListLayout
    ScrollingFrame.CanvasSize = UDim2.fromOffset(
        math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
        0
    )
    refreshNextReward()
    for i6, i7 in v4 do
        v1:Add((ButtonFX(i7.Button, 1.06, function() -- Line: 283
            -- upvalues: i7 (val), Tabs (upval), PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval)
            -- upvalues: Save (upval), refresh (val)
            if i7.Tab == "HalloweenDimensionEggUI" then
                Tabs.Activate("HalloweenDimensionEggUI", {instant = true})
                return
            end
            local v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
            if v1 then
                local v2 = Save.Peek()
                if (if v2 == nil then nil else v2.HalloweenDimension.BossMastery) ~= nil then
                    refresh()
                    Tabs.Activate("HalloweenBossMastery", {instant = true})
                end
            end
        end)))
    end
    v5 = nil
    v6 = nil
    for i8, i9 in HalloweenMasteryButton, v5, v6 do
        v4 = i9:FindFirstChild("RemovalTimer")
        if v4 ~= nil then
            v4.Visible = false
        end
        v1:Add((ButtonFX(i9, 1.08, function() -- Line: 298
            -- upvalues: Tabs (upval), PumpkinBossFlags (upval), LocalPlayer (upval), Inside (upval), Save (upval)
            -- upvalues: refresh (val)
            if Tabs.IsActive("HalloweenBossMastery") then
                Tabs.Deactivate()
                return
            end
            local v1 = PumpkinBossFlags.ContentEnabled:Get() and LocalPlayer:GetAttribute(Inside) == true
            if v1 then
                local v2 = Save.Peek()
                if (if v2 == nil then nil else v2.HalloweenDimension.BossMastery) ~= nil then
                    refresh()
                    Tabs.Activate("HalloweenBossMastery")
                end
            end
        end)))
    end
    v1:Connect(Tabs.Activated, function(a1) -- Line: 308
        -- upvalues: ScrollingFrame (val), refreshNextReward (val), refresh (val), notifyReady (val), Save (upval)
        if a1 == "HalloweenBossMastery" then
            local UIListLayout = ScrollingFrame.UIListLayout
            ScrollingFrame.CanvasSize = UDim2.fromOffset(
                math.ceil(UIListLayout.AbsoluteContentSize.X + (UIListLayout.Padding.Scale * ScrollingFrame.AbsoluteSize.X + UIListLayout.Padding.Offset)),
                0
            )
            refreshNextReward()
            refresh()
            local v1 = Save.Peek()
            notifyReady(if v1 == nil then nil else v1.HalloweenDimension.BossMastery)
        end
    end)
    v1:Add((Save.WatchFields({"HalloweenDimension", "HalloweenTokens"}, sync)))
    v1:Connect(LocalPlayer:GetAttributeChangedSignal(Inside), sync)
    v1:Add((PumpkinBossFlags.ContentEnabled.Changed:Connect(sync)))
    sync()
end

return table.freeze(v1)