-- Script path: ReplicatedStorage.Client.Notifications.Reward
-- Decompile time: 19.35 ms

local collectFades
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local Lanes = require(script.Parent.Lanes)
local NotificationItem = require(ReplicatedStorage.Shared.NotificationItem)
local NotificationItemCard = require(ReplicatedStorage.Client.UI.NotificationItemCard)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local Assets = ReplicatedStorage:WaitForChild("Assets")
local u45 = {
    Bloom = "Bloom",
    Halo = "Halo",
    Placeholder = "Placeholder",
    Portrait = "coreImage",
    Card = Assets.UI.Notifs.MainItem,
}
u45.HolderPath = {"Frame", "CardSlot"}
u45.Slot = Assets.UI.Notifs.MainItem.Slot
local NewItem = Assets.UI.Items.NewItem
local u59 = {}
u59[1] = {Sound = "rbxassetid://73352992887992", Rank = Rarity.Rarities.Cosmic.Rank}
u59[2] = {Gain = 1.6, Rank = (-1 / 0), Sound = "rbxassetid://103957546380416"}
local u70 = TweenInfo.new(0.34, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local u75 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local u80 = TweenInfo.new(1.05, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local u85 = TweenInfo.new(1.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local u91 = TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 1)
local u92 = {
    CanvasGroup = {"BackgroundTransparency", "GroupTransparency"},
    Frame = {"BackgroundTransparency"},
    ImageButton = {"BackgroundTransparency", "ImageTransparency"},
    ImageLabel = {"BackgroundTransparency", "ImageTransparency"},
    TextButton = {"BackgroundTransparency", "TextStrokeTransparency", "TextTransparency"},
    TextLabel = {"BackgroundTransparency", "TextStrokeTransparency", "TextTransparency"},
    UIStroke = {"Transparency"},
}
local u120 = {}
u120[1] = {
    key = "DelayInRound",
    accepts = function(a1) -- Line: 140
        return typeof(a1) == "boolean"
    end,
    fold = function(a1, a2) -- Line: 152
        local v1 = true
        if a1 ~= true then
            v1 = a2 == true
        end
        return v1
    end,
}
u120[2] = {
    key = "Seconds",
    accepts = function(a1) -- Line: 148
        local v1 = false
        if typeof(a1) == "number" then
            v1 = false
            if a1 > 0 then
                v1 = a1 < (1 / 0)
            end
        end
        return v1
    end,
    fold = function(a1, a2) -- Line: 160
        if a1 == nil then
            return a2
        end
        return (math.min(a1, a2))
    end,
}
u120[3] = {
    key = "UniqueKey",
    accepts = function(a1) -- Line: 144
        local v1 = false
        if typeof(a1) == "string" then
            v1 = a1 ~= ""
        end
        return v1
    end,
    fold = function(a1, a2) -- Line: 156
        if a1 == nil then
            return a2
        end
        return a1
    end,
}
local u124 = 0

local function cueFor(a1) -- Line: 172 -- upvalues: u59 (val)
    local Rank
    for i, j in u59 do
        Rank = a1.Rank
        if j.Rank <= Rank then
            return j
        end
    end
    return u59[#u59]
end

local function playCue(a1) -- Line: 181 -- upvalues: u124 (ref), u59 (val), Audio (val)
    local Rank
    local v1 = os.clock()
    if v1 < u124 then
        return
    end
    u124 = v1 + 0.2
    for i, j in u59 do
        Rank = a1.Rank
        if j.Rank <= Rank then
            Audio.Play(j.Sound, script, if not v1.Gain then nil else {Volume = v1.Gain})
            return
        end
    end
    v1 = u59[#u59]
    Audio.Play(v1.Sound, script, if not v1.Gain then nil else {Volume = v1.Gain})
end

local function descend(a1, a2) -- Line: 192 -- types: a1: userdata, a2: table
    local v1 = a1
    for i, j in a2 do
        v1 = assert(v1:FindFirstChild(j), (("reward card template lacks %*"):format(j)))
    end
    return v1
end

local function paintTier(a1, a2) -- Line: 200 -- upvalues: SwapGradient (val) -- types: a1: userdata, a2: userdata
    SwapGradient(a1, a2)
end

local function headline(a1) -- Line: 204 -- types: a1: number
    if a1 > 1 then
        return "Rewards claimed!"
    end
    return "Reward claimed!"
end

local function cardOptions(a1) -- Line: 208
    local v1 = {Sparkle = false}
    local v2 = true
    if a1.Kind ~= "Currency" then
        v2 = 1 < a1.Amount
    end
    v1.ShowCount = v2
    return v1
end

local function mountSquare(a1, a2) -- Line: 215 -- types: a1: userdata, a2: userdata
    a1.Size = UDim2.fromScale(1, 1)
    a1.Parent = a2
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.Parent = a1
end

function collectFades(a1, a2, a3) -- Line: 224
    -- upvalues: u92 (val), collectFades (val)
    if a1 == a2 then
        return
    end
    if a1:IsA("GuiObject") and not a1.Visible then
        return
    end
    if a1:IsA("UIStroke") and not a1.Enabled then
        return
    end
    local v1 = u92[a1.ClassName]
    if v1 then
        local v2
        for i, j in v1 do
            v2 = a1[j]
            if v2 < 1 then
                table.insert(a3, {instance = a1, property = j, resting = v2})
            end
        end
    end
    if a1:IsA("CanvasGroup") then
        return
    end
    for k, n in a1:GetChildren() do
        collectFades(n, a2, a3)
    end
end

local function conceal(a1, a2, a3, a4) -- Line: 257 -- types: a1: userdata, a2: Vector2, a3: table, a4: userdata?
    a1.Size = a2:Lerp(UDim2.new(), 0.44999999999999996)
    for i, j in a3 do
        j.instance[j.property] = 1
    end
    if a4 then
        a4.ImageTransparency = 1
    end
end

local function reveal(a1, a2, a3) -- Line: 268
    -- upvalues: TweenService (val), u70 (val), u75 (val)
    local instance, v1, v2, v3
    TweenService:Create(a1, u70, {Size = a2}):Play()
    for i, j in a3 do
        v3 = TweenService
        instance = j.instance
        v1 = u75
        v2 = {}
        v2[j.property] = j.resting
        v3:Create(instance, v1, v2):Play()
    end
end

local function bloomOut(a1, a2) -- Line: 275
    -- upvalues: TweenService (val), u85 (val), u80 (val)
    a1.ImageTransparency = a2
    TweenService:Create(a1, u85, {ImageTransparency = 1}):Play()
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale then
        UIScale.Scale = 0.4
        TweenService:Create(UIScale, u80, {Scale = 1.45}):Play()
    end
end

local function pulseRing(a1, a2) -- Line: 286
    -- upvalues: TweenService (val), u91 (val)
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")
    local UIStroke_2 = if not UIStroke then Instance.new("UIStroke") else UIStroke
    local u10 = {
        Color = UIStroke_2.Color,
        Enabled = UIStroke_2.Enabled,
        Thickness = UIStroke_2.Thickness,
        Transparency = UIStroke_2.Transparency,
    }
    local v1 = math.max(UIStroke_2.Thickness, 3) * 2.5
    UIStroke_2.Color = a2
    UIStroke_2.Enabled = true
    UIStroke_2.Thickness = 0
    UIStroke_2.Transparency = 0.1
    UIStroke_2.Parent = a1
    local v2 = TweenService:Create(UIStroke_2, u91, {Transparency = 1, Thickness = v1})
    v2.Completed:Once(function() -- Line: 304 -- upvalues: UIStroke (val), UIStroke_2 (val), u10 (val)
        if UIStroke == nil then
            UIStroke_2:Destroy()
            return
        end
        UIStroke_2.Color = u10.Color
        UIStroke_2.Enabled = u10.Enabled
        UIStroke_2.Thickness = u10.Thickness
        UIStroke_2.Transparency = u10.Transparency
    end)
    v2:Play()
end

local function createSlot(a1, a2) -- Line: 317
    -- upvalues: NotificationItem (val), descend (val), SwapGradient (val), NewItem (val), NotificationItemCard (val)
    -- upvalues: collectFades (val), reveal (val), bloomOut (val), pulseRing (val)
    local Rarity = NotificationItem.Describe(a2).Rarity
    local RarityGradient = Rarity.RarityGradient
    local u11 = a1.Slot:Clone()
    local u15 = descend(u11, a1.HolderPath)
    local u19 = u11:FindFirstChild(a1.Bloom)
    local v1 = u15:FindFirstChild(a1.Placeholder)
    if v1 then
        v1:Destroy()
    end
    SwapGradient(u15, RarityGradient)
    for i, j in {a1.Halo, a1.Portrait} do
        v1 = u15:FindFirstChild(j)
        if v1 then
            SwapGradient(v1, RarityGradient)
        end
    end
    local v2 = u11:FindFirstChild("TextLabel")
    if v2 and v2:IsA("TextLabel") then
        NewItem:Clone().Parent = v2
        v2.TextColor3 = Color3.new(1, 1, 1)
        v2.Text = if not (1 < a2.Amount) then "Reward claimed!" else "Rewards claimed!"
    end
    local Build = NotificationItemCard.Build
    local v3 = {Sparkle = false}
    local v4 = true
    if a2.Kind ~= "Currency" then
        v4 = 1 < a2.Amount
    end
    v3.ShowCount = v4
    local v5 = Build(a2, v3)
    v5.Size = UDim2.fromScale(1, 1)
    v5.Parent = u15
    v2 = Instance.new("UIAspectRatioConstraint")
    v2.AspectRatio = 1
    v2.Parent = v5
    local u102 = {}
    collectFades(u11, u19, u102)
    local Size = u11.Size
    local ImageTransparency = if not u19 then 1 else u19.ImageTransparency
    u11.Size = Size:Lerp(UDim2.new(), 0.44999999999999996)
    for k, n in u102 do
        n.instance[n.property] = 1
    end
    if u19 then
        u19.ImageTransparency = 1
    end
    return {
        frame = u11,
        play = function() -- Line: 356
            -- upvalues: reveal (upval), u11 (val), Size (val), u102 (val), u19 (val), bloomOut (upval)
            -- upvalues: ImageTransparency (val), pulseRing (upval), u15 (val), Rarity (val)
            reveal(u11, Size, u102)
            if u19 then
                bloomOut(u19, ImageTransparency)
            end
            pulseRing(u15, Rarity.Color)
        end,
        rarity = Rarity,
    }
end

local function laneArea() -- Line: 367 -- upvalues: GUI (val)
    local Notifications = GUI.Get("Notifications")
    local Feed = if not Notifications then nil else Notifications:FindFirstChild("Feed")
    if Feed and Feed:IsA("GuiObject") then
        return Feed.AbsoluteSize
    end
    return nil
end

local function slotCapacity(a1) -- Line: 374 -- upvalues: GUI (val) -- types: a1: table
    local AbsoluteSize
    local Notifications = GUI.Get("Notifications")
    local Feed = if not Notifications then nil else Notifications:FindFirstChild("Feed")
    if (if not Feed then nil else if not Feed:IsA("GuiObject") then nil else Feed.AbsoluteSize) == nil then
        return 6
    end
    local Size = a1.Card.Size
    local v1 = AbsoluteSize.X * Size.X.Scale + Size.X.Offset
    local v2 = AbsoluteSize.Y * Size.Y.Scale + Size.Y.Offset
    local v3 = a1.Card:FindFirstChildOfClass("UIListLayout")
    local v4 = if not v3 then 0 else v3.Padding.Scale * v1 + v3.Padding.Offset
    v3 = a1.Slot:FindFirstChildOfClass("UIAspectRatioConstraint")
    local v5 = math.min(v1, v2 * (if not v3 then 1 else v3.AspectRatio))
    if v5 <= 0 then
        return 1
    end
    return (math.clamp(math.floor((v1 + v4) / (v5 + v4)), 1, 6))
end

local function liveCards(a1) -- Line: 394 -- types: a1: table
    local shownAt, v1, v2
    local v3 = os.clock()
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in a1.cards, v5, v6 do
        shownAt = j.shownAt
        if shownAt ~= nil then
            v1 = v3 - shownAt
            v2 = j.lifetime + 2 < v1
        else
            v2 = 12 <= v3 - j.queuedAt
        end
        if not j.closed and not v2 then
            table.insert(v4, j)
        end
    end
    a1.cards = v4
    return v4
end

local function openCard(a1) -- Line: 412 -- upvalues: liveCards (val) -- types: a1: table
    local v1 = liveCards(a1)
    local v2 = v1[#v1]
    if v2 ~= nil and not (v2.capacity <= v2.filled) then
        local shownAt = v2.shownAt
        if shownAt == nil or 1.3 <= v2.lifetime - (os.clock() - shownAt) then
            return v2
        end
        return nil
    end
    return nil
end

local function placeSlot(a1, a2) -- Line: 427 -- upvalues: playCue (val) -- types: a1: table, a2: table
    a1.filled = a1.filled + 1
    a2.frame.LayoutOrder = a1.filled
    a2.frame.Parent = a1.frame
    if a1.shownAt ~= nil then
        playCue(a2.rarity)
        a2.play()
        return
    end
    table.insert(a1.deferredPlays, a2.play)
    local loudest = a1.loudest
    if loudest == nil or loudest.Rank < a2.rarity.Rank then
        a1.loudest = a2.rarity
    end
end

local function resolvePolicy(a1) -- Line: 445 -- upvalues: u120 (val) -- types: a1: table
    local v1, v2, v3
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        v2 = nil
        v3 = nil
        for k, n in j.hints, v2, v3 do
            for m, i5 in u120 do
                v1 = n[i5.key]
                if i5.accepts(v1) then
                    v4[i5.key] = (i5.fold(v4[i5.key], v1))
                end
            end
        end
    end
    if v4.Seconds == nil then
        v4.Seconds = 3.4
    end
    return v4
end

local function buildCard(a1, a2, a3) -- Line: 463
    -- upvalues: resolvePolicy (val), placeSlot (val), createSlot (val), Lanes (val), playCue (val)
    local v1 = resolvePolicy(a2)
    local v2 = a1.layout.Card:Clone()
    for i, j in v2:GetChildren() do
        if j:IsA("GuiObject") then
            j:Destroy()
        end
    end
    local u23 = {closed = false, filled = 0, capacity = a3}
    u23.deferredPlays = {}
    u23.frame = v2
    u23.lifetime = v1.Seconds or 3.4
    u23.queuedAt = os.clock()
    v2.Destroying:Once(function() -- Line: 483 -- upvalues: u23 (val)
        u23.closed = true
    end)
    table.insert(a1.cards, u23)
    for k, n in a2 do
        placeSlot(u23, (createSlot(a1.layout, n.item)))
    end
    Lanes.Schedule({
        Lane = "Feed",
        Frame = v2,
        Seconds = v1.Seconds,
        UniqueKey = v1.UniqueKey,
        DelayInRound = v1.DelayInRound,
        OnShown = function() -- Line: 498 -- upvalues: u23 (val), playCue (upval)
            u23.shownAt = os.clock()
            local loudest = u23.loudest
            if loudest then
                playCue(loudest)
            end
            local deferredPlays = u23.deferredPlays
            u23.deferredPlays = {}
            local v1 = nil
            local v2 = nil
            for i, j in deferredPlays, v1, v2 do
                if i > 1 then
                    task.wait(0.07)
                end
                if u23.closed then
                    break
                end
                j()
            end
        end,
    })
end

local function flush(a1) -- Line: 520 -- upvalues: slotCapacity (val), buildCard (val) -- types: a1: table
    local v1, v2
    a1.flushScheduled = false
    local v3 = slotCapacity(a1.layout)
    while true do
        if not (#a1.inbox > 0) then
            break
        end
        v1 = math.min(v3, #a1.inbox)
        v2 = table.move(a1.inbox, 1, v1, 1, {})
        a1.inbox = table.move(a1.inbox, v1 + 1, #a1.inbox, 1, {})
        buildCard(a1, v2, v3)
    end
end

local function stackKey(a1) -- Line: 532
    return (("%*/%*/%*"):format(a1.Kind, a1.Id or "", a1.Mutation or ""))
end

local function stage(a1, a2, a3) -- Line: 537 -- upvalues: flush (val) -- types: a1: table
    local v1
    local v2 = ("%*/%*/%*"):format(a2.Kind, a2.Id or "", a2.Mutation or "")
    for i, j in a1.inbox do
        if j.stack == v2 then
            v1 = table.clone(j.item)
            v1.Amount = v1.Amount + a2.Amount
            j.item = v1
            if a3 then
                table.insert(j.hints, a3)
            end
            return
        end
    end
    if #a1.inbox >= 18 then
        return
    end
    table.insert(a1.inbox, {hints = if not a3 then {} else {a3}, item = a2, stack = v2})
    if not a1.flushScheduled then
        a1.flushScheduled = true
        task.delay(0.12, flush, a1)
    end
end

local function acceptItem(a1) -- Line: 566 -- upvalues: NotificationItem (val) -- types: a1: table
    local Item
    local v1, v2 = NotificationItem.Schema(if typeof(a1) ~= "table" then nil else a1.Item)
    assert(v1, (("reward notification rejected: %*"):format(v2 or "malformed payload")))
    return Item
end

local function hintFrom(a1) -- Line: 574 -- upvalues: u120 (val) -- types: a1: table
    local v1
    local v2 = {}
    local v3 = false
    for i, j in u120 do
        v1 = a1[j.key]
        if v1 ~= nil then
            v2[j.key] = v1
            v3 = true
        end
    end
    if v3 then
        return v2
    end
    return nil
end

local function createChannel(a1) -- Line: 587
    -- upvalues: NotificationItem (val), liveCards (val), placeSlot (val), createSlot (val), stage (val), hintFrom (val)
    local u1 = {flushScheduled = false, cards = {}, inbox = {}, layout = a1}
    return {
        Show = function(a1_2) -- Line: 596
            -- upvalues: NotificationItem (upval), u1 (val), liveCards (upval), placeSlot (upval), createSlot (upval)
            -- upvalues: a1 (val), stage (upval), hintFrom (upval)
            local Item = if typeof(a1_2) ~= "table" then nil else a1_2.Item
            local v1, v2 = NotificationItem.Schema(Item)
            assert(v1, (("reward notification rejected: %*"):format(v2 or "malformed payload")))
            local v3 = liveCards(u1)
            local v4 = v3[#v3]
            if v4 == nil then
                v1 = nil
            elseif not (v4.capacity <= v4.filled) then
                local shownAt = v4.shownAt
                v1 = if shownAt ~= nil then if not (1.3 <= v4.lifetime - (os.clock() - shownAt)) then nil else v4 else v4
            else
                v1 = nil
            end
            if v1 then
                placeSlot(v1, (createSlot(a1, Item)))
                return
            end
            stage(u1, Item, (hintFrom(a1_2)))
        end,
    }
end

return {
    Show = (createChannel(u45)).Show,
    CreateChannel = function(a1) -- Line: 612 -- upvalues: createChannel (val), u45 (val) -- types: a1: table?
        return (createChannel(a1 or u45))
    end,
}