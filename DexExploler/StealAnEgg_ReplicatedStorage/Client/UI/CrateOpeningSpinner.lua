-- Script path: ReplicatedStorage.Client.UI.CrateOpeningSpinner
-- Decompile time: 20.07 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u73 = Random.new()
local u77 = assert(Players.LocalPlayer, "Crate spinner requires a local player")
local u78 = false
local v1 = {}

local function waitForChild(a1, a2) -- Line: 74 -- types: a1: userdata, a2: string
    local v1 = a1:WaitForChild(a2, 5)
    local v2 = ("%*.%* did not load"):format(a1:GetFullName(), a2)
    assert(v1 ~= nil, v2)
    return v1
end

local function getView() -- Line: 80 -- upvalues: u77 (val)
    local v1 = u77
    local v2 = v1:WaitForChild("PlayerGui", 5)
    local v3 = ("%*.PlayerGui did not load"):format((v1:GetFullName()))
    assert(v2 ~= nil, v3)
    local CrateOpeningPopUpFrame = v2:WaitForChild("CrateOpeningPopUpFrame", 5)
    v3 = ("%*.CrateOpeningPopUpFrame did not load"):format((v2:GetFullName()))
    assert(CrateOpeningPopUpFrame ~= nil, v3)
    assert(CrateOpeningPopUpFrame:IsA("ScreenGui"), "CrateOpeningPopUpFrame must be a ScreenGui")
    v2 = CrateOpeningPopUpFrame:WaitForChild("CrateOpeningPopUp", 5)
    v3 = ("%*.CrateOpeningPopUp did not load"):format((CrateOpeningPopUpFrame:GetFullName()))
    assert(v2 ~= nil, v3)
    assert(v2:IsA("GuiObject"), "CrateOpeningPopUp must be a GuiObject")
    local Main = v2:WaitForChild("Main", 5)
    local v4 = ("%*.Main did not load"):format((v2:GetFullName()))
    assert(Main ~= nil, v4)
    assert(Main:IsA("Frame"), "CrateOpeningPopUp.Main must be a Frame")
    local Holder = Main:WaitForChild("Holder", 5)
    local v5 = ("%*.Holder did not load"):format((Main:GetFullName()))
    assert(Holder ~= nil, v5)
    assert(Holder:IsA("Frame"), "CrateOpeningPopUp.Main.Holder must be a Frame")
    local GenericFrameTemplate = Holder:WaitForChild("GenericFrameTemplate", 5)
    local v6 = ("%*.GenericFrameTemplate did not load"):format((Holder:GetFullName()))
    assert(GenericFrameTemplate ~= nil, v6)
    assert(GenericFrameTemplate:IsA("Frame"), "GenericFrameTemplate must be a Frame")
    local SpecialFrameTemplate = Holder:WaitForChild("SpecialFrameTemplate", 5)
    local v7 = ("%*.SpecialFrameTemplate did not load"):format((Holder:GetFullName()))
    assert(SpecialFrameTemplate ~= nil, v7)
    assert(SpecialFrameTemplate:IsA("Frame"), "SpecialFrameTemplate must be a Frame")
    local UIListLayout = Holder:WaitForChild("UIListLayout", 5)
    local v8 = ("%*.UIListLayout did not load"):format((Holder:GetFullName()))
    assert(UIListLayout ~= nil, v8)
    assert(UIListLayout:IsA("UIListLayout"), "Holder.UIListLayout must be a UIListLayout")
    local UIPadding = Holder:WaitForChild("UIPadding", 5)
    local v9 = ("%*.UIPadding did not load"):format((Holder:GetFullName()))
    assert(UIPadding ~= nil, v9)
    assert(UIPadding:IsA("UIPadding"), "Holder.UIPadding must be a UIPadding")
    local Skip = v2:WaitForChild("Skip", 5)
    local v10 = ("%*.Skip did not load"):format((v2:GetFullName()))
    assert(Skip ~= nil, v10)
    assert(Skip:IsA("ImageButton"), "CrateOpeningPopUp.Skip must be an ImageButton")
    local Arrow = v2:WaitForChild("Arrow", 5)
    local v11 = ("%*.Arrow did not load"):format((v2:GetFullName()))
    assert(Arrow ~= nil, v11)
    assert(Arrow:IsA("ImageLabel"), "CrateOpeningPopUp.Arrow must be an ImageLabel")
    local RewardTitleFrame = v2:WaitForChild("RewardTitleFrame", 5)
    local v12 = ("%*.RewardTitleFrame did not load"):format((v2:GetFullName()))
    assert(RewardTitleFrame ~= nil, v12)
    assert(RewardTitleFrame:IsA("Frame"), "RewardTitleFrame must be a Frame")
    local RewardName = RewardTitleFrame:WaitForChild("RewardName", 5)
    local v13 = ("%*.RewardName did not load"):format((RewardTitleFrame:GetFullName()))
    assert(RewardName ~= nil, v13)
    assert(RewardName:IsA("TextLabel"), "RewardTitleFrame.RewardName must be a TextLabel")
    v12 = false
    if UIListLayout.FillDirection == Enum.FillDirection.Horizontal then
        v12 = false
        if UIListLayout.SortOrder == Enum.SortOrder.LayoutOrder then
            v12 = not UIListLayout.Wraps
        end
    end
    assert(v12, "Holder.UIListLayout must be a single horizontal row sorted by LayoutOrder")
    return {
        Arrow = Arrow,
        GenericTemplate = GenericFrameTemplate,
        Holder = Holder,
        Layout = UIListLayout,
        Main = Main,
        Padding = UIPadding,
        Popup = v2,
        RewardName = RewardName,
        RewardTitle = RewardTitleFrame,
        Screen = CrateOpeningPopUpFrame,
        Skip = Skip,
        SpecialTemplate = SpecialFrameTemplate,
    }
end

local function pickRewardId() -- Line: 145 -- upvalues: u73 (val), MonsterParasite (val)
    local v1 = u73:NextNumber(0, 100)
    local v2 = 0
    for i, j in MonsterParasite.Rewards do
        v2 = v2 + j.Weight
        if v1 <= v2 then
            return j.Id
        end
    end
    return MonsterParasite.Rewards[#MonsterParasite.Rewards].Id
end

local function buildRewardIds(a1, a2) -- Line: 157 -- upvalues: pickRewardId (val) -- types: a2: number
    local v1
    local v2 = table.create(36)
    local v3, v4 = a2, a1
    for i = 1, 36 do
        v1 = if i ~= v3 then pickRewardId() else v4
        v2[i] = v1
    end
    return v2
end

local function ensureCardImage(a1, a2, a3, a4, a5) -- Line: 174
    -- upvalues: 
    local v1 = a1:FindFirstChild(a2)
    if v1 ~= nil and v1:IsA("ImageLabel") then
        return v1
    end
    if v1 ~= nil then
        v1:Destroy()
    end
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = a2
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.fromScale(0.5, 0.3)
    ImageLabel.ScaleType = a5
    ImageLabel.Size = UDim2.fromScale(a4, a4)
    ImageLabel.ZIndex = a3
    ImageLabel.Parent = a1
    return ImageLabel
end

local function setFrameText(a1, a2) -- Line: 201
    -- upvalues: MonsterParasite (val), MonsterParasite_2 (val), Rarities (val), SwapGradient (val)
    -- upvalues: ensureCardImage (val)
    local v1
    local ItemName = a1:FindFirstChild("ItemName")
    assert(ItemName and ItemName:IsA("TextLabel"), "Reward frame requires ItemName")
    local RarityLabel = a1:FindFirstChild("RarityLabel")
    assert(RarityLabel and RarityLabel:IsA("TextLabel"), "Reward frame requires RarityLabel")
    local v2 = MonsterParasite.GetReward(a2)
    ItemName.Text = MonsterParasite.RewardLabel(v2)
    local Rarity = v2.Rarity
    RarityLabel.Text = Rarity
    local v3 = assert(
        Rarities[if a2 ~= MonsterParasite_2.RewardIds.MonsterEgg then Rarity else "Prismatic"],
        (("Unknown Monster Chest rarity: %*"):format(v1))
    )
    SwapGradient(RarityLabel, v3.RarityGradient)
    local UIStroke = RarityLabel:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        SwapGradient(UIStroke, v3.RarityGradient)
    end
    v1 = ensureCardImage(a1, "Glow", 2, 0.5940000000000001, Enum.ScaleType.Stretch)
    v1.Image = "rbxassetid://109516122757226"
    v1.ImageTransparency = 0.45
    v1.ImageColor3 = v3.RarityGradient.Color.Keypoints[1].Value
    v1.Visible = true
    v1 = ensureCardImage(a1, "Icon", 3, 0.54, Enum.ScaleType.Fit)
    local v4 = a1:GetAttribute("FallbackIcon")
    local Icon = v2.Icon or (if typeof(v4) ~= "string" then "rbxassetid://116351329433541" else v4)
    v1.Image = Icon
    v1.Visible = true
end

local function buildFrames(a1, a2, a3, a4) -- Line: 257
    -- upvalues: MonsterParasite_2 (val), setFrameText (val)
    local Frame, SpecialTemplate, v1, v2
    local v3 = table.create(#a3)
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in a3, v4, v5 do
        SpecialTemplate = if j ~= MonsterParasite_2.RewardIds.MonsterEgg then v6.GenericTemplate else v6.SpecialTemplate
        Frame = Instance.new("Frame")
        Frame.Name = ("RewardSlot%*"):format(i)
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.LayoutOrder = i
        Frame.Size = UDim2.fromOffset(v7, v7)
        Frame.Parent = v6.Holder
        v8:Add(Frame)
        v2 = SpecialTemplate:Clone()
        v2.Name = ("RewardFrame%*"):format(i)
        v2.AnchorPoint = Vector2.new(0.5, 0.5)
        v2.Position = UDim2.fromScale(0.5, 0.5)
        v2.Size = UDim2.fromScale(1, 1)
        v2.Visible = true
        setFrameText(v2, j)
        v1 = v2:FindFirstChildOfClass("UIScale")
        assert(v1 ~= nil, "Reward frame requires UIScale")
        v1.Scale = 0.7
        v2.Parent = Frame
        v3[i] = {Scale = v1, Slot = Frame}
    end
    return v3
end

local function spinCurve(a1) -- Line: 298 -- types: a1: number
    if not (a1 < 0.055) then
        return (1 - (1 - (a1 - 0.055) / 0.945) ^ 4) * 0.92 + 0.08
    end
    local v1 = a1 / 0.055
    return v1 ^ 2 * (v1 * 0.6772486772486772 + 0.3227513227513228) * 0.08
end

local function formatReward(a1) -- Line: 320 -- upvalues: MonsterParasite_2 (val), Mutations (val)
    if a1.Id == MonsterParasite_2.RewardIds.MonsterEgg and a1.Egg ~= nil then
        return (("x1 %* %*"):format(Mutations.LabelOf(a1.Egg.Mutation), a1.Egg.AssetCategory))
    end
    return a1.DisplayName
end

local function playTween(a1, a2, a3) -- Line: 330
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, a2, a3)
    v1:Play()
    v1.Completed:Wait()
end

local function runPresentation(a1, a2, a3) -- Line: 340
    -- upvalues: RunService (val), u73 (val), buildRewardIds (val), buildFrames (val), GuiService (val)
    -- upvalues: MenuNavigation (val), TweenService (val), Spring (val), Audio (val), MonsterParasite_2 (val)
    -- upvalues: Mutations (val), Confetti (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = assert(a2.Reward, "Successful Monster Chest result requires a reward")
    a1.Screen.DisplayOrder = math.max(a1.Screen.DisplayOrder, 200)
    a1.Screen.ResetOnSpawn = false
    a1.Popup.Visible = false
    a1.Main.Visible = false
    a1.RewardTitle.Visible = false
    a1.Skip.Visible = true
    a1.Skip.Active = true
    a1.GenericTemplate.Visible = false
    a1.SpecialTemplate.Visible = false
    local UIScale = Instance.new("UIScale")
    UIScale.Name = "CrateOpeningRuntimeScale"
    UIScale.Scale = 1
    UIScale.Parent = a1.Popup
    a3:Add(UIScale)
    RunService.Heartbeat:Wait()
    local v8 = math.max(a1.Main.AbsoluteSize.X, 1)
    local v9 = math.max(a1.Main.AbsoluteSize.Y, 1)
    local v10 = v8 * 0.176
    local v11 = v8 * 0.01
    local v12 = math.max(8, v8 * 0.01)
    v8 = u73:NextInteger(29, 33)
    local v13 = buildRewardIds(v7.Id, v8)
    a1.Layout.Padding = UDim.new(0, v11)
    a1.Padding.PaddingLeft = UDim.new(0, v12)
    a1.Padding.PaddingRight = UDim.new(0, v12)
    a1.Holder.Size = UDim2.fromOffset(v12 * 2 + v10 * 36 + v11 * 35, v9)
    a1.Holder.Position = UDim2.fromOffset(0, 0)
    local u108 = buildFrames(a1, a3, v13, v10)
    RunService.Heartbeat:Wait()
    v13 = a1.Arrow.AbsolutePosition.X + a1.Arrow.AbsoluteSize.X * 0.5
    local Slot = u108[v8].Slot
    local v14 = v13 - (Slot.AbsolutePosition.X + Slot.AbsoluteSize.X * 0.5)
    local SelectedObject = GuiService.SelectedObject
    local Active = a1.Popup.Active
    local ZIndex = a1.Popup.ZIndex
    local SelectionGroup = a1.Popup.SelectionGroup
    local SelectionBehaviorDown = a1.Popup.SelectionBehaviorDown
    local SelectionBehaviorLeft = a1.Popup.SelectionBehaviorLeft
    local SelectionBehaviorRight = a1.Popup.SelectionBehaviorRight
    local SelectionBehaviorUp = a1.Popup.SelectionBehaviorUp
    local Active_2 = a1.Main.Active
    local Selectable = a1.RewardTitle.Selectable
    local Modal = a1.Skip.Modal
    local Selectable_2 = a1.Skip.Selectable
    a3:Add(function() -- Line: 404
        -- upvalues: GuiService (upval), a1 (val), SelectedObject (val), Active (val), ZIndex (val)
        -- upvalues: SelectionGroup (val), SelectionBehaviorDown (val), SelectionBehaviorLeft (val)
        -- upvalues: SelectionBehaviorRight (val), SelectionBehaviorUp (val), Active_2 (val), Selectable (val)
        -- upvalues: Modal (val), Selectable_2 (val)
        if GuiService.SelectedObject == a1.Skip then
            GuiService.SelectedObject = SelectedObject
        end
        a1.Popup.Active = Active
        a1.Popup.ZIndex = ZIndex
        a1.Popup.SelectionGroup = SelectionGroup
        a1.Popup.SelectionBehaviorDown = SelectionBehaviorDown
        a1.Popup.SelectionBehaviorLeft = SelectionBehaviorLeft
        a1.Popup.SelectionBehaviorRight = SelectionBehaviorRight
        a1.Popup.SelectionBehaviorUp = SelectionBehaviorUp
        a1.Main.Active = Active_2
        a1.RewardTitle.Selectable = Selectable
        a1.Skip.Modal = Modal
        a1.Skip.Selectable = Selectable_2
    end)
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "CrateOpeningInputBlocker"
    TextButton.Active = true
    TextButton.AutoButtonColor = false
    TextButton.BackgroundTransparency = 1
    TextButton.Modal = true
    TextButton.Selectable = false
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.Text = ""
    TextButton.ZIndex = 1
    TextButton.Parent = a1.Screen
    a3:Add(TextButton)
    a1.Popup.Active = true
    a1.Popup.ZIndex = math.max(2, ZIndex)
    a1.Popup.SelectionGroup = true
    a1.Popup.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    a1.Popup.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    a1.Popup.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    a1.Popup.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    a1.Main.Active = true
    a1.RewardTitle.Selectable = false
    a1.Skip.Modal = true
    a1.Skip.Selectable = true
    if not MenuNavigation.IsCursorActive() then
        GuiService.SelectedObject = a1.Skip
    end
    UIScale.Scale = 0.86
    a1.Popup.Visible = true
    a1.Main.Visible = true
    TweenService:Create(UIScale, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    local u397 = false
    MenuNavigation.SetOverride("CrateOpening", a1.Popup, a1.Skip, function() -- Line: 456 -- upvalues: u397 (ref), a1 (val)
        u397 = true
        a1.Skip.Active = false
    end, 2000, true)
    a3:Add(function() -- Line: 460 -- upvalues: MenuNavigation (upval)
        MenuNavigation.SetOverride("CrateOpening", nil)
    end)
    a3:Connect(a1.Skip.Activated, function() -- Line: 461 -- upvalues: u397 (ref), a1 (val)
        u397 = true
        a1.Skip.Active = false
    end)
    local Rotation = a1.Arrow.Rotation
    local u256 = Spring.new(0)
    u256.Speed = 19
    u256.Damper = 0.58
    local u262 = table.create(#u108)

    local function renderOffset(a1_2, a2) -- Line: 472
        -- upvalues: a1 (val), u108 (val), u262 (val), Audio (upval), u256 (val), Rotation (val)
        local v1, v2, v3, v4
        a1.Holder.Position = UDim2.fromOffset(a1_2, 0)
        local v5 = nil
        local v6 = nil
        for i, j in u108, v5, v6 do
            v2 = a1.Arrow.AbsolutePosition.X + a1.Arrow.AbsoluteSize.X * 0.5
            v3 = j.Slot.AbsolutePosition.X + j.Slot.AbsoluteSize.X * 0.5
            v1 = math.lerp(1, 0.7, (math.clamp((math.abs(v3 - v2)) / math.max(a1.Main.AbsoluteSize.X * 0.5, 1), 0, 1)))
            j.Scale.Scale = v1
            v4 = v3 - j.Slot.AbsoluteSize.X * v1 * 0.5
            if a2 then
                v1 = u262[i]
                if v1 and v2 < v1 and v4 <= v2 then
                    Audio.Play("rbxassetid://137872392480008", script, {Volume = 0.72, PlaybackSpeed = {0.97, 1.03}})
                    u256:Impulse(24 * u256.Speed)
                end
            end
            u262[i] = v4
        end
        a1.Arrow.Rotation = Rotation + math.clamp(u256.Position, -24, 24)
    end

    renderOffset(0, false)
    local v15 = if not ((u73:NextNumber()) < 0.5) then 1 else -1
    local v16 = v14 + v10 * u73:NextNumber(0.1, 0.19) * v15
    v15 = u73:NextNumber(3, 6)
    v14 = os.clock()
    v10 = nil
    local v17 = 0
    local v18 = 0
    while true do
        v2 = os.clock()
        if u397 and v10 == nil then
            v10 = v2
            v17 = v18
        end
        if not v10 then
            v4 = math.clamp((v2 - v14) / v15, 0, 1)
            if not (v4 < 0.055) then
                v5 = (1 - (1 - (v4 - 0.055) / 0.945) ^ 4) * 0.92 + 0.08
            else
                v6 = v4 / 0.055
                v5 = v6 ^ 2 * (v6 * 0.6772486772486772 + 0.3227513227513228) * 0.08
            end
            v18 = math.lerp(0, v16, v5)
        else
            v18 = math.lerp(v17, v16, 1 - (1 - (math.clamp((v2 - v10) / 0.55, 0, 1))) ^ 5)
        end
        v3 = v4 >= 1
        renderOffset(v18, true)
        if v3 then
            break
        end
        RunService.RenderStepped:Wait()
    end
    task.wait(0.1)
    v17 = a1.Arrow.AbsolutePosition.X + a1.Arrow.AbsoluteSize.X * 0.5
    v15 = Slot.AbsolutePosition.X + Slot.AbsoluteSize.X * 0.5
    v14 = v18 + v17 - v15
    v2 = os.clock()
    while true do
        v15 = math.clamp((os.clock() - v2) / 0.48, 0, 1)
        renderOffset(math.lerp(v16, v14, (TweenService:GetValue(v15, Enum.EasingStyle.Back, Enum.EasingDirection.Out))), false)
        if v15 >= 1 then
            break
        end
        RunService.RenderStepped:Wait()
    end
    renderOffset(v14, false)
    a1.Skip.Visible = false
    local RewardName = a1.RewardName
    local DisplayName = if v7.Id ~= MonsterParasite_2.RewardIds.MonsterEgg or v7.Egg == nil then v7.DisplayName else ("x1 %* %*"):format(Mutations.LabelOf(v7.Egg.Mutation), v7.Egg.AssetCategory)
    RewardName.Text = DisplayName
    a1.RewardTitle.Visible = true
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0.55
    UIScale_2.Parent = a1.RewardTitle
    v1:Add(UIScale_2)
    local Scale = u108[v8].Scale
    Scale.Scale = 1
    v16 = TweenService:Create(UIScale_2, TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    v16:Play()
    TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.16}):Play()
    v16.Completed:Wait()
    Confetti.Burst()
    v18 = TweenService:Create(Scale, TweenInfo.new(0.34, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.04})
    v18:Play()
    v18.Completed:Wait()
    task.wait(0.85)
    v17 = TweenService:Create(UIScale, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.9})
    v17:Play()
    v17.Completed:Wait()
    a1.Arrow.Rotation = Rotation
end

function v1:Play() -- Line: 610 -- upvalues: u78 (ref), Trove (val), getView (val), runPresentation (val)
    assert(self.Success and self.Reward ~= nil, "Crate spinner requires a successful reward")
    if u78 then
        return
    end
    u78 = true
    local u13 = Trove.new()
    local u14 = nil
    local u15 = nil
    local success, result = xpcall(function() -- Line: 623
        -- upvalues: getView (upval), u14 (ref), u15 (ref), runPresentation (upval), self (val), u13 (val)
        local v1 = getView()
        u14 = v1
        u15 = v1.Arrow.Rotation
        runPresentation(v1, self, u13)
    end, debug.traceback)
    if u14 ~= nil then
        u14.Popup.Visible = false
        u14.Main.Visible = false
        u14.RewardTitle.Visible = false
        u14.Skip.Active = false
        if u15 ~= nil then
            u14.Arrow.Rotation = u15
        end
    end
    u13:Destroy()
    u78 = false
    if not success then
        error(result, 2)
    end
end

return (table.freeze(v1))