-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CaptureTheEgg
-- Decompile time: 65.88 ms

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Audio = require(ReplicatedStorage.Shared.Audio)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local EggState = require(ReplicatedStorage.Client.EggState)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SpawnLock = require(ReplicatedStorage.Client.SpawnLock)
local Trove = require(ReplicatedStorage.Packages.Trove)
local EggUidAttribute = CaptureTheEgg.EggUidAttribute
local u96 = {"Leader", "Second", "Third"}
local u100 = {"Leader", "Second", "Third", "You"}
local u105 = {}
local v1 = Color3.fromRGB(255, 214, 89)
local v2 = Color3.fromRGB(213, 213, 213)
u105[1] = v1
u105[2] = v2
u105[3] = Color3.fromRGB(204, 141, 96)
local u124 = UDim2.fromScale(0.5, 0.085)
local u128 = UDim2.fromScale(0.5, 0.2)
local u132 = UDim2.fromScale(0.5, -0.35)
local LocalPlayer = Players.LocalPlayer
local u134 = nil
local u135 = {}
local u136 = {}
local u137 = 0
local u138 = 0
local u139 = nil
local u140 = nil
local u141 = nil
local u142 = false
local u143 = nil
local u144 = nil
local u145 = false
local u146 = false
local u149 = not AreaEggResetWall.IsSealed()
local u150 = 0
local u151 = nil
local u152 = 0
local u153 = 0
local u154 = false
local u155 = false
local u156 = false
local u157 = 0
local u158 = false
local u159 = nil
local u160 = nil
local u161 = nil
local u162 = nil
local u163 = {}
local u164 = {}
local u165 = {}
local v3 = {}

local function cancelTween(a1) -- Line: 168 -- types: a1: userdata?
    if a1 ~= nil then
        a1:Cancel()
    end
end

local function formatSeconds(a1) -- Line: 174 -- types: a1: number
    return string.format("%.1f", math.floor((math.max(a1, 0)) * 10) / 10)
end

local function easeOutQuint(a1) -- Line: 178 -- types: a1: number
    return 1 - (1 - a1) ^ 5
end

local function easeInOutCubic(a1) -- Line: 182 -- types: a1: number
    if a1 < 0.5 then
        return a1 * 4 * a1 * a1
    end
    return 1 - (a1 * -2 + 2) ^ 3 / 2
end

local function warnMissingAssetOnce(a1, a2) -- Line: 186 -- upvalues: u165 (val) -- types: a1: string, a2: string
    if u165[a1] then
        return
    end
    u165[a1] = true
    warn(a2)
end

local function getScoreboardUi() -- Line: 198 -- upvalues: u134 (ref), LocalPlayer (val), u156 (ref), u100 (val)
    local v1 = u134
    if v1 ~= nil and v1.Gui.Parent ~= nil then
        return v1
    end
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local CaptureTheEggUI = PlayerGui and PlayerGui:FindFirstChild("CaptureTheEggUI")
    if CaptureTheEggUI ~= nil and CaptureTheEggUI:IsA("ScreenGui") then
        v1 = CaptureTheEggUI:FindFirstChild("Board")
        local Rows = v1 and v1:FindFirstChild("Rows")
        if v1 ~= nil and v1:IsA("Frame") and Rows ~= nil and Rows:IsA("Frame") then
            local Avatar, Timer, UIScale, v2
            local UIListLayout = Rows:FindFirstChildOfClass("UIListLayout")
            if UIListLayout ~= nil then
                UIListLayout:Destroy()
            end
            local v3 = {}
            local v4 = nil
            local v5 = nil
            for i, j in u100, v4, v5 do
                v2 = Rows:FindFirstChild(j)
                Avatar = v2 and v2:FindFirstChild("Avatar")
                Timer = Avatar and Avatar:FindFirstChild("Timer")
                if v2 ~= nil
                    and v2:IsA("Frame")
                    and Avatar ~= nil
                    and Avatar:IsA("ImageLabel")
                    and Timer ~= nil
                    and Timer:IsA("TextLabel") then
                    UIScale = v2:FindFirstChildOfClass("UIScale")
                    if UIScale == nil then
                        UIScale = Instance.new("UIScale")
                        UIScale.Name = "UIScale"
                        UIScale.Parent = v2
                    end
                    v2.AnchorPoint = Vector2.new(0.5, 0.5)
                    v2.Position = UDim2.fromScale(0.5, 0.5)
                    v2.Visible = false
                    UIScale.Scale = 0.72
                    v3[j] = {
                        Token = 0,
                        Name = j,
                        Frame = v2,
                        Avatar = Avatar,
                        Timer = Timer,
                        Scale = UIScale,
                    }
                    continue
                end
                if not u156 then
                    u156 = true
                    warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(j)))
                end
                return nil
            end
            local v6 = {Gui = CaptureTheEggUI, Board = v1, Rows = Rows, Cards = v3}
            u134 = v6
            u156 = false
            return v6
        end
        if not u156 then
            u156 = true
            warn("[CaptureTheEgg] CaptureTheEggUI is stale; it needs a Board frame with a Rows frame.")
        end
        return nil
    end
    if not u156 then
        u156 = true
        warn("[CaptureTheEgg] CaptureTheEggUI is missing from StarterGui.")
    end
    return nil
end

local function applyBoardVisibility(a1) -- Line: 288
    -- upvalues: getScoreboardUi (val), u145 (ref), u149 (ref), u146 (ref), u152 (ref), u151 (ref), u142 (ref)
    -- upvalues: u128 (val), u124 (val), u132 (val), TweenService (val)
    local v1 = getScoreboardUi()
    if v1 == nil then
        return
    end
    local Gui = v1.Gui
    local Board = v1.Board
    v1 = u145 and u149
    if v1 == u146 and not a1 then
        if v1 then
            Gui.Enabled = true
        end
        return
    end
    u152 = u152 + 1
    local u14 = u152
    local v2 = u151
    if v2 ~= nil then
        v2:Cancel()
    end
    u151 = nil
    if v1 then
        v2 = if not u142 then u124 else u128
        Gui.Enabled = true
        if not u146 then
            Board.Position = u132
        end
        u146 = true
        if a1 then
            Board.Position = v2
            return
        end
        u151 = TweenService:Create(Board, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = v2})
        u151:Play()
        return
    end
    u146 = false
    if a1 then
        Board.Position = u132
        Gui.Enabled = false
        return
    end
    if not Gui.Enabled then
        Board.Position = u132
        return
    end
    u151 = TweenService:Create(Board, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = u132})
    u151:Play()
    u151.Completed:Once(function() -- Line: 345 -- upvalues: u14 (val), u152 (upval), u146 (upval), Gui (val)
        if u14 == u152 and not u146 then
            Gui.Enabled = false
        end
    end)
end

local function setBoardShown(a1, a2) -- Line: 352
    -- upvalues: u145 (ref), applyBoardVisibility (val)
    u145 = a1
    applyBoardVisibility(a2)
end

local function setWallIsDown(a1) -- Line: 357 -- upvalues: u149 (ref), applyBoardVisibility (val) -- types: a1: boolean
    if u149 == a1 then
        return
    end
    u149 = a1
    applyBoardVisibility()
end

local function setLocalPlayerCarryingEgg(a1) -- Line: 365
    -- upvalues: u142 (ref), u146 (ref), getScoreboardUi (val), u152 (ref), u151 (ref), TweenService (val), u128 (val)
    -- upvalues: u124 (val)
    if u142 == a1 then
        return
    end
    u142 = a1
    if not u146 then
        return
    end
    local v1 = getScoreboardUi()
    if v1 ~= nil and v1.Gui.Enabled then
        u152 = u152 + 1
        local v2 = u151
        if v2 ~= nil then
            v2:Cancel()
        end
        u151 = TweenService:Create(
            v1.Board,
            TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = if not a1 then u124 else u128}
        )
        u151:Play()
        return
    end
end

local function cancelCardTweens(a1) -- Line: 402 -- types: a1: table
    local MoveTween = a1.MoveTween
    if MoveTween ~= nil then
        MoveTween:Cancel()
    end
    local ScaleTween = a1.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    local AvatarTween = a1.AvatarTween
    if AvatarTween ~= nil then
        AvatarTween:Cancel()
    end
    local TimerTween = a1.TimerTween
    if TimerTween ~= nil then
        TimerTween:Cancel()
    end
    a1.MoveTween = nil
    a1.ScaleTween = nil
    a1.AvatarTween = nil
    a1.TimerTween = nil
end

local function removeTransferGhost(a1) -- Line: 413 -- upvalues: u135 (val) -- types: a1: userdata
    local v1 = table.find(u135, a1)
    if v1 ~= nil then
        table.remove(u135, v1)
    end
    a1:Destroy()
end

local function clearTransferGhosts() -- Line: 421 -- upvalues: u135 (val)
    for i, j in u135 do
        j:Destroy()
    end
    table.clear(u135)
end

local function cardWidthScale(a1, a2) -- Line: 428 -- types: a1: table, a2: table
    local AbsoluteSize = a1.Rows.AbsoluteSize
    if 0 < AbsoluteSize.X and 0 < AbsoluteSize.Y then
        return a2.Frame.Size.Y.Scale * AbsoluteSize.Y / AbsoluteSize.X
    end
    return a2.Frame.Size.X.Scale
end

local function calculateCardPositions(a1, a2) -- Line: 436 -- types: a1: table, a2: table
    local AbsoluteSize, AbsoluteSize_2, Scale, Scale_2, State, State_3
    local v1 = {}
    local v2 = math.max(#a2 - 1, 0) * 0.025
    local v3 = nil
    local v4 = nil
    local v5, v6 = a2, a1
    for i, j in a2, v3, v4 do
        State_3 = j.State
        AbsoluteSize_2 = v6.Rows.AbsoluteSize
        Scale_2 = if not (0 < AbsoluteSize_2.X) or not (0 < AbsoluteSize_2.Y) then State_3.Frame.Size.X.Scale else State_3.Frame.Size.Y.Scale * AbsoluteSize_2.Y / AbsoluteSize_2.X
        v2 = v2 + Scale_2
    end
    local v7 = 0.5 - v2 * 0.5
    v4 = nil
    local v8 = nil
    for k, n in v5, v4, v8 do
        State = n.State
        AbsoluteSize = v6.Rows.AbsoluteSize
        Scale = if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then State.Frame.Size.X.Scale else State.Frame.Size.Y.Scale * AbsoluteSize.Y / AbsoluteSize.X
        v1[n.State.Name] = (UDim2.fromScale(v7 + Scale * 0.5, 0.5))
        v7 = v7 + (Scale + 0.025)
    end
    return v1
end

local function createTransferGhost(a1, a2, a3, a4) -- Line: 452
    -- upvalues: u135 (val), TweenService (val)
    local AbsoluteSize = a1.Rows.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) and not (a2.Avatar.AbsoluteSize.X <= 0) then
        local v1 = a2.Avatar.AbsolutePosition + a2.Avatar.AbsoluteSize * 0.5 - a1.Rows.AbsolutePosition
        local u26 = a2.Avatar:Clone()
        u26.Name = ("Transfer_%*"):format(a2.UserId or 0)
        for i, j in u26:GetDescendants() do
            if j:IsA("TextLabel") then
                j:Destroy()
            end
        end
        u26.AnchorPoint = Vector2.new(0.5, 0.5)
        u26.Position = UDim2.fromScale(v1.X / AbsoluteSize.X, v1.Y / AbsoluteSize.Y)
        u26.Size = UDim2.fromScale(a2.Avatar.AbsoluteSize.X / AbsoluteSize.X, a2.Avatar.AbsoluteSize.Y / AbsoluteSize.Y)
        u26.ZIndex = 30
        u26.Parent = a1.Rows
        table.insert(u135, u26)
        local fromScale_3 = UDim2.fromScale
        local AbsoluteSize_2 = a1.Rows.AbsoluteSize
        v1 = fromScale_3(
            if not (0 < AbsoluteSize_2.X) or not (0 < AbsoluteSize_2.Y) then a3.Frame.Size.X.Scale else a3.Frame.Size.Y.Scale * AbsoluteSize_2.Y / AbsoluteSize_2.X,
            a3.Frame.Size.Y.Scale
        )
        local v2 = TweenService:Create(
            u26,
            TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {ImageTransparency = 0.35, Position = a4, Size = v1}
        )
        v2:Play()
        v2.Completed:Once(function() -- Line: 489 -- upvalues: u26 (val), u135 (upval)
            local v1 = u26
            local v2 = table.find(u135, v1)
            if v2 ~= nil then
                table.remove(u135, v2)
            end
            v1:Destroy()
        end)
        return true
    end
    return false
end

local function showCard(a1, a2) -- Line: 495 -- upvalues: TweenService (val) -- types: a1: table, a2: CFrame
    local Visible = a1.Frame.Visible and a1.UserId ~= nil
    a1.Token = a1.Token + 1
    local MoveTween = a1.MoveTween
    if MoveTween ~= nil then
        MoveTween:Cancel()
    end
    local ScaleTween = a1.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    if not Visible then
        a1.Frame.Position = a2 + UDim2.fromScale(0, -0.32)
        a1.Scale.Scale = 0.72
    end
    a1.Frame.Visible = true
    a1.MoveTween = TweenService:Create(a1.Frame, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = a2})
    a1.ScaleTween = TweenService:Create(
        a1.Scale,
        TweenInfo.new(if not Visible then 0.46 else 0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Scale = 1}
    )
    a1.MoveTween:Play()
    a1.ScaleTween:Play()
end

local function hideCard(a1, a2) -- Line: 519 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean?
    if not a1.Frame.Visible and a1.UserId == nil then
        return
    end
    a1.Token = a1.Token + 1
    local Token = a1.Token
    local MoveTween = a1.MoveTween
    if MoveTween ~= nil then
        MoveTween:Cancel()
    end
    local ScaleTween = a1.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    local AvatarTween = a1.AvatarTween
    if AvatarTween ~= nil then
        AvatarTween:Cancel()
    end
    local TimerTween = a1.TimerTween
    if TimerTween ~= nil then
        TimerTween:Cancel()
    end
    a1.MoveTween = nil
    a1.ScaleTween = nil
    a1.AvatarTween = nil
    a1.TimerTween = nil
    a1.UserId = nil
    a1.Rank = nil
    if a2 then
        a1.Frame.Visible = false
        a1.Frame.Position = UDim2.fromScale(0.5, 0.5)
        a1.Scale.Scale = 0.72
        a1.Avatar.ImageTransparency = 0
        a1.Timer.TextTransparency = 0
        return
    end
    a1.MoveTween = TweenService:Create(
        a1.Frame,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = a1.Frame.Position + UDim2.fromScale(0, 0.18)}
    )
    a1.ScaleTween = TweenService:Create(a1.Scale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.72})
    a1.MoveTween:Play()
    a1.ScaleTween:Play()
    a1.ScaleTween.Completed:Once(function() -- Line: 550 -- upvalues: a1 (val), Token (val)
        if a1.Token == Token and a1.UserId == nil then
            a1.Frame.Visible = false
        end
    end)
end

local function setCardEntry(a1, a2, a3, a4) -- Line: 557
    -- upvalues: u105 (val), TweenService (val)
    local v1 = a1.UserId ~= a2.UserId
    local v2 = string.format("%.1f", math.floor((math.max(a2.Seconds, 0)) * 10) / 10)
    local v3 = a1.Timer.Text ~= v2
    a1.Token = a1.Token + 1
    local Token = a1.Token
    local AvatarTween = a1.AvatarTween
    if AvatarTween ~= nil then
        AvatarTween:Cancel()
    end
    local TimerTween = a1.TimerTween
    if TimerTween ~= nil then
        TimerTween:Cancel()
    end
    a1.UserId = a2.UserId
    a1.Rank = a3
    a1.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a2.UserId)
    a1.Timer.Text = v2
    v2 = a1.Avatar:FindFirstChildOfClass("UIStroke")
    if v2 ~= nil then
        local BackgroundColor3 = if a3 == nil then a1.Frame.BackgroundColor3 else u105[a3]
        v2.Color = BackgroundColor3
    end
    if v1 then
        local v4 = if not a4 then 0.52 else 1
        a1.Avatar.ImageTransparency = v4
        a1.Timer.TextTransparency = 1
        task.delay(if not a4 then 0 else 0.2356, function() -- Line: 579 -- upvalues: a1 (val), Token (val), a2 (val), TweenService (upval)
            if a1.Token == Token and a1.UserId == a2.UserId then
                a1.AvatarTween = TweenService:Create(a1.Avatar, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0})
                a1.TimerTween = TweenService:Create(a1.Timer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
                a1.AvatarTween:Play()
                a1.TimerTween:Play()
                return
            end
        end)
        return
    end
    if 0 < a1.Avatar.ImageTransparency then
        a1.AvatarTween = TweenService:Create(a1.Avatar, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0})
        a1.AvatarTween:Play()
    end
    if v3 or 0 < a1.Timer.TextTransparency then
        a1.Timer.TextTransparency = math.max(a1.Timer.TextTransparency, 0.28)
        a1.TimerTween = TweenService:Create(a1.Timer, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0})
        a1.TimerTween:Play()
    end
end

local function pulseLeader(a1) -- Line: 617 -- upvalues: TweenService (val), u105 (val) -- types: a1: table
    local ScaleTween = a1.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    a1.Scale.Scale = 1.16
    a1.ScaleTween = TweenService:Create(a1.Scale, TweenInfo.new(0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale = 1})
    a1.ScaleTween:Play()
    local UIStroke = a1.Avatar:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        UIStroke.Color = Color3.new(1, 1, 1)
        UIStroke.Thickness = 4
        TweenService:Create(
            UIStroke,
            TweenInfo.new(0.62, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Thickness = 2, Color = u105[1]}
        ):Play()
    end
end

local function buildCardAssignments(a1, a2) -- Line: 639
    -- upvalues: u96 (val), LocalPlayer (val)
    local v1 = {}
    local v2 = false
    for i = 1, (math.min(#a2, #u96)) do
        v2 = v2 or a2[i].UserId == LocalPlayer.UserId
        table.insert(v1, {State = a1.Cards[u96[i]], Entry = a2[i], Rank = i})
    end
    if not v2 then
        local v3 = nil
        for j, k in a2 do
            if k.UserId == LocalPlayer.UserId then
                v3 = k
                break
            end
        end
        if v3 == nil then
            v3 = {Seconds = 0, UserId = LocalPlayer.UserId, Name = LocalPlayer.DisplayName}
        end
        table.insert(v1, {State = a1.Cards.You, Entry = v3})
    end
    return v1
end

local function reconcileScoreboard(a1) -- Line: 676
    -- upvalues: getScoreboardUi (val), buildCardAssignments (val), calculateCardPositions (val), u146 (ref)
    -- upvalues: createTransferGhost (val), showCard (val), setCardEntry (val), hideCard (val), u141 (ref)
    -- upvalues: pulseLeader (val)
    local State
    local v1 = getScoreboardUi()
    if v1 == nil then
        return
    end
    local v2 = buildCardAssignments(v1, a1)
    local v3 = calculateCardPositions(v1, v2)
    local v4 = {}
    for i, j in v1.Cards do
        if j.Frame.Visible and j.UserId ~= nil then
            v4[j.UserId] = j
        end
    end
    local v5 = {}
    if u146 and v1.Gui.Enabled then
        local v6
        for k, n in v2 do
            v6 = v4[n.Entry.UserId]
            if v6 ~= nil and v6 ~= n.State then
                v5[n.State.Name] = (createTransferGhost(v1, v6, n.State, v3[n.State.Name]))
            end
        end
    end
    v4 = {}
    local v7 = nil
    local v8 = nil
    for m, i5 in v2, v7, v8 do
        State = i5.State
        v4[State.Name] = true
        showCard(State, v3[State.Name])
        setCardEntry(State, i5.Entry, i5.Rank, v5[State.Name] == true)
    end
    for i6, i7 in v1.Cards do
        if not v4[i6] then
            hideCard(i7)
        end
    end
    local UserId = if not (#v9 > 0) then nil else v9[1].UserId
    if u141 ~= nil and UserId ~= nil and u141 ~= UserId then
        pulseLeader(v1.Cards.Leader)
    end
    u141 = UserId
end

local function sanitizeEntries(a1) -- Line: 722 -- types: a1: table
    local v1 = {}
    local v2 = {}
    for i, j in a1 do
        if type(j) == "table"
            and type(j.UserId) == "number"
            and type(j.Name) == "string"
            and type(j.Seconds) == "number"
            and j.Seconds == j.Seconds
            and j.Seconds < (1 / 0)
            and not v2[j.UserId] then
            v2[j.UserId] = true
            table.insert(v1, {
                UserId = j.UserId,
                Name = j.Name,
                Seconds = math.max(j.Seconds, 0),
            })
        end
    end
    return v1
end

local function buildLiveEntries() -- Line: 748
    -- upvalues: u136 (ref), u139 (ref), u154 (ref), u155 (ref), Workspace (val), EggUidAttribute (val), EggState (val)
    -- upvalues: u137 (ref)
    local v1 = table.clone(u136)
    local v2 = u139
    local v3 = 0
    if v2 ~= nil and u154 and u155 and Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true then
        local Attribute = Workspace:GetAttribute(EggUidAttribute)
        local v4 = if type(Attribute) ~= "string" then nil else EggState.ReadFieldEgg(Attribute)
        if v4 ~= nil and v4.CarrierUserId == v2 then
            v3 = math.clamp((Workspace:GetServerTimeNow()) - u137, 0, 2)
        end
    end
    if v3 > 0 then
        local v5
        for i, j in v1 do
            if j.UserId == v2 then
                v5 = table.clone(j)
                v5.Seconds = v5.Seconds + v3
                v1[i] = v5
                break
            end
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 784 -- types: a1: table, a2: table
        if a1.Seconds == a2.Seconds then
            return a1.UserId < a2.UserId
        end
        return a2.Seconds < a1.Seconds
    end)
    return v1
end

local function refreshScoreboardCards(a1) -- Line: 794
    -- upvalues: getScoreboardUi (val), u140 (ref), reconcileScoreboard (val), buildCardAssignments (val)
    local State, Timer
    local v1 = getScoreboardUi()
    if v1 == nil then
        return
    end
    local AbsoluteSize = v1.Rows.AbsoluteSize
    if u140 ~= AbsoluteSize then
        u140 = AbsoluteSize
        reconcileScoreboard(a1)
        return
    end
    local v2 = buildCardAssignments(v1, a1)
    local v3 = {}
    for i, j in v2 do
        State = j.State
        v3[State.Name] = true
        if State.Frame.Visible and State.UserId == j.Entry.UserId and State.Rank == j.Rank then
            continue
        end
        reconcileScoreboard(a1)
        return
    end
    for k, n in v1.Cards do
        if n.UserId ~= nil and not v3[k] then
            reconcileScoreboard(a1)
            return
        end
    end
    for m, i5 in v2 do
        Timer = i5.State.Timer
        v1 = string.format("%.1f", math.floor((math.max(i5.Entry.Seconds, 0)) * 10) / 10)
        if Timer.Text ~= v1 then
            Timer.Text = v1
        end
    end
end

local function renderScoreboard(a1, a2) -- Line: 836
    -- upvalues: u138 (ref), u136 (ref), sanitizeEntries (val), u137 (ref), u139 (ref), u154 (ref), Workspace (val)
    -- upvalues: u155 (ref), refreshScoreboardCards (val), buildLiveEntries (val), u158 (ref), u145 (ref)
    -- upvalues: applyBoardVisibility (val)
    if type(a2) == "table"
        and type(a2.Revision) == "number"
        and a2.Revision == a2.Revision
        and not ((1 / 0) <= a2.Revision)
        and not (a2.Revision <= u138)
        and type(a2.SampledAt) == "number"
        and a2.SampledAt == a2.SampledAt
        and math.abs(a2.SampledAt) ~= (1 / 0) then
        u138 = a2.Revision
        sanitizeEntries(a1)
        u137 = a2.SampledAt
        u139 = if type(a2.CarrierUserId) ~= "number" then nil else a2.CarrierUserId
        if not u154 and Workspace:GetAttribute("Event_CaptureTheEgg") == true then
            u154 = true
        end
        if not u154 then
            return
        end
        u155 = Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
        refreshScoreboardCards((buildLiveEntries()))
        if u154 and u155 and not u158 then
            u145 = true
            applyBoardVisibility(nil)
            return
        end
        u145 = false
        applyBoardVisibility(nil)
        return
    end
end

local function updateLiveTimers() -- Line: 875
    -- upvalues: u134 (ref), u146 (ref), refreshScoreboardCards (val), buildLiveEntries (val)
    local v1 = u134
    if v1 ~= nil and u146 and v1.Gui.Enabled then
        refreshScoreboardCards((buildLiveEntries()))
        return
    end
end

local function resetScoreboardCards() -- Line: 883
    -- upvalues: u135 (val), getScoreboardUi (val), u141 (ref), u136 (ref), u137 (ref), u139 (ref), u140 (ref)
    local v1 = nil
    for i, j in u135, nil, v1 do
        j:Destroy()
    end
    table.clear(u135)
    local v2 = getScoreboardUi()
    if v2 ~= nil then
        local AvatarTween, MoveTween, ScaleTween, TimerTween, Token
        v1 = nil
        local v3 = nil
        for k, n in v2.Cards, v1, v3 do
            if n.Frame.Visible or n.UserId ~= nil then
                n.Token = n.Token + 1
                Token = n.Token
                MoveTween = n.MoveTween
                if MoveTween ~= nil then
                    MoveTween:Cancel()
                end
                ScaleTween = n.ScaleTween
                if ScaleTween ~= nil then
                    ScaleTween:Cancel()
                end
                AvatarTween = n.AvatarTween
                if AvatarTween ~= nil then
                    AvatarTween:Cancel()
                end
                TimerTween = n.TimerTween
                if TimerTween ~= nil then
                    TimerTween:Cancel()
                end
                n.MoveTween = nil
                n.ScaleTween = nil
                n.AvatarTween = nil
                n.TimerTween = nil
                n.UserId = nil
                n.Rank = nil
                n.Frame.Visible = false
                n.Frame.Position = UDim2.fromScale(0.5, 0.5)
                n.Scale.Scale = 0.72
                n.Avatar.ImageTransparency = 0
                n.Timer.TextTransparency = 0
            end
        end
    end
    u141 = nil
    u136 = {}
    u137 = 0
    u139 = nil
    u140 = nil
end

local function refreshScoreboardAvailability() -- Line: 898
    -- upvalues: u154 (ref), Workspace (val), u155 (ref), u158 (ref), refreshScoreboardCards (val)
    -- upvalues: buildLiveEntries (val), u145 (ref), applyBoardVisibility (val)
    if not u154 and Workspace:GetAttribute("Event_CaptureTheEgg") == true then
        u154 = true
    end
    u155 = u154 and Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
    if u155 and not u158 then
        refreshScoreboardCards((buildLiveEntries()))
        u145 = true
        applyBoardVisibility(nil)
        return
    end
    u145 = false
    applyBoardVisibility(nil)
end

local function resolveAsset(a1, a2) -- Line: 916 -- upvalues: ReplicatedStorage (val) -- types: a1: string, a2: string
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v1 = Assets and Assets:FindFirstChild(a1)
    return v1 and v1:FindFirstChild(a2)
end

local function playSound(a1, a2, a3) -- Line: 922
    -- upvalues: ReplicatedStorage (val), u165 (val), Audio (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Sounds = Assets and Assets:FindFirstChild("Sounds")
    local v1 = Sounds and Sounds:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        local success, err = pcall(Audio.Play, v1, a3 or script)
        if not success then
            warn((("[CaptureTheEgg] %* failed to play: %*"):format(a1, err)))
            return nil
        end
        if err ~= nil and err.Parent ~= nil then
            if a3 == nil then
                a2:Add(err)
            end
            return err
        end
        return nil
    end
    local v2 = ("[CaptureTheEgg] Missing ReplicatedStorage.Assets.Sounds.%*; the cinematic will continue without it."):format(a1)
    if not u165[a1] then
        u165[a1] = true
        warn(v2)
    end
    return nil
end

local function emitImpactVfx(a1) -- Line: 948
    -- upvalues: ReplicatedStorage (val), u165 (val), Workspace (val), Debris (val), PlayVFX (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Particles = Assets and Assets:FindFirstChild("Particles")
    local v1 = Particles and Particles:FindFirstChild("BigHitGroundAttach")
    if v1 == nil then
        if u165.BigHitGroundAttach then
            return
        end
        u165.BigHitGroundAttach = true
        warn("[CaptureTheEgg] Missing ReplicatedStorage.Assets.Particles.BigHitGroundAttach; impact VFX was skipped.")
        return
    end
    if not v1:IsA("ParticleEmitter") and v1:FindFirstChildWhichIsA("ParticleEmitter", true) == nil then
        if u165.BigHitGroundAttachEmitter then
            return
        end
        u165.BigHitGroundAttachEmitter = true
        warn("[CaptureTheEgg] BigHitGroundAttach has no ParticleEmitter descendants; impact VFX was skipped.")
        return
    end
    local Part = Instance.new("Part")
    Part.Name = "CaptureTheEggImpactVFX"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.CFrame = a1
    Part.Parent = Workspace:FindFirstChild("Transient") or Workspace
    Debris:AddItem(Part, 10)
    local v2 = v1:Clone()
    local success, err = pcall(PlayVFX, Part, a1, v2)
    if not success then
        v2:Destroy()
        warn((("[CaptureTheEgg] BigHitGroundAttach failed to play: %*"):format(err)))
    end
end

local function preloadCutsceneAssets(a1) -- Line: 988
    -- upvalues: u164 (val), ReplicatedStorage (val), EggRenderer (val), EggRecords (val), CaptureTheEgg (val)
    -- upvalues: ContentProvider (val)
    if u164[a1] then
        return
    end
    u164[a1] = true
    task.spawn(function() -- Line: 994
        -- upvalues: ReplicatedStorage (upval), EggRenderer (upval), EggRecords (upval), a1 (val), CaptureTheEgg (upval)
        -- upvalues: ContentProvider (upval)
        local Assets, v1, v2, v3, v4
        local v5 = {}
        local v6 = {}
        local v7 = {
            {"Sounds", "CinematicRiser"},
            {"Sounds", "CinematicBoom"},
            {"Sounds", "ImpactBoom"},
            {"Particles", "BigHitGroundAttach"},
        }
        local v8 = nil
        local v9 = nil
        for i, j in v7, v8, v9 do
            v3 = j[1]
            v4 = j[2]
            Assets = ReplicatedStorage:FindFirstChild("Assets")
            v1 = Assets and Assets:FindFirstChild(v3)
            v2 = v1 and v1:FindFirstChild(v4)
            if v2 ~= nil then
                table.insert(v5, v2)
            end
        end
        local success, err = pcall(function() -- Line: 1011 -- upvalues: EggRenderer (upval), EggRecords (upval), a1 (upval)
            return EggRenderer.GetTemplate(EggRecords.NewEgg(a1))
        end)
        if success and typeof(err) == "Instance" then
            table.insert(v5, err)
        end
        v9 = {CaptureTheEgg.DanceAnimationId, CaptureTheEgg.R6DanceAnimationId}
        local v10 = nil
        for k, n in v9, nil, v10 do
            v8 = Instance.new("Animation")
            v8.AnimationId = n
            table.insert(v5, v8)
            table.insert(v6, v8)
        end
        if #v5 > 0 then
            v10 = ContentProvider
            pcall(ContentProvider.PreloadAsync, v10, v5)
        end
        for m, i5 in v6 do
            i5:Destroy()
        end
    end)
end

local function resolvePreloadCategory(a1) -- Line: 1034 -- upvalues: CaptureTheEgg (val)
    if type(a1) == "table" and type(a1.EggCategory) == "string" and a1.EggCategory ~= "" then
        return a1.EggCategory
    end
    return CaptureTheEgg.CarryCategory
end

local function ensureOverlay() -- Line: 1041 -- upvalues: u162 (ref), LocalPlayer (val)
    local v1 = u162
    if v1 ~= nil and v1.Gui.Parent ~= nil then
        return v1
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CaptureTheEggCinematic"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 50
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Vignette"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://104574024062008"
    ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
    ImageLabel.ImageTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.ZIndex = 1
    ImageLabel.Parent = ScreenGui

    local function createBar(a1, a2) -- Line: 1065 -- upvalues: ScreenGui (val) -- types: a1: string, a2: CFrame
        local Frame = Instance.new("Frame")
        Frame.Name = a1
        Frame.BackgroundColor3 = Color3.new(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Position = a2
        Frame.Size = UDim2.fromScale(1, 0.11)
        Frame.ZIndex = 2
        Frame.Parent = ScreenGui
        return Frame
    end

    local v2 = createBar("Top", UDim2.fromScale(0, -0.11))
    local v3 = createBar("Bottom", UDim2.fromScale(0, 1))
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v4 = {Gui = ScreenGui, Top = v2, Bottom = v3, Vignette = ImageLabel}
    u162 = v4
    return v4
end

local function setOverlayShown(a1) -- Line: 1091
    -- upvalues: u163 (ref), ensureOverlay (val), TweenService (val)
    for i, j in u163 do
        j:Cancel()
    end
    table.clear(u163)
    local v1 = ensureOverlay()
    local v2 = TweenInfo.new(0.9, Enum.EasingStyle.Quint, if not a1 then Enum.EasingDirection.In else Enum.EasingDirection.Out)
    local v3 = {}
    local Top = v1.Top
    local v4 = {}
    local v5 = if not a1 then UDim2.fromScale(0, -0.11) else UDim2.fromScale(0, 0)
    v4.Position = v5
    local v6 = TweenService:Create(Top, v2, v4)
    local Bottom = v1.Bottom
    v5 = {}
    local v7 = if not a1 then UDim2.fromScale(0, 1) else UDim2.fromScale(0, 0.89)
    v5.Position = v7
    local v8 = TweenService:Create(Bottom, v2, v5)
    local Vignette = v1.Vignette
    v3[1] = v6
    v3[2] = v8
    v3[3] = TweenService:Create(Vignette, v2, {ImageTransparency = if not a1 then 1 else 0.3})
    v3 = v3
    for k, n in v3 do
        n:Play()
    end
end

local function cloneStarterCharacter(a1) -- Line: 1125
    -- upvalues: ReplicatedStorage (val), CaptureTheEgg (val), Players (val), u165 (val)
    local PrimaryPart, v1
    local v2 = nil
    local v3 = ReplicatedStorage:FindFirstChild(CaptureTheEgg.StarterRigName)
    if v3 ~= nil and v3:IsA("Model") then
        v2 = v3
    end
    if v2 == nil then
        local PlayerByUserId = Players:GetPlayerByUserId(a1)
        v2 = PlayerByUserId and PlayerByUserId.Character
    end
    if v2 == nil then
        return nil
    end
    v2.Archivable = true
    local v4 = v2:Clone()
    v2.Archivable = false
    v2 = v4:FindFirstChild("HumanoidRootPart", true)
    if (if v2 == nil then v4.PrimaryPart else if not v2:IsA("BasePart") then v4.PrimaryPart else v2) == nil then
        v4:Destroy()
        if not u165.DanceRigRoot then
            u165.DanceRigRoot = true
            warn("[CaptureTheEgg] The starter's cloned character has no root part.")
        end
        return nil
    end
    v4.PrimaryPart = PrimaryPart
    for i, j in v4:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j == PrimaryPart
            j.Anchored = v1
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            v1 = j ~= PrimaryPart
            j.Massless = v1
        elseif j:IsA("Script") or j:IsA("LocalScript") then
            j:Destroy()
        end
    end
    local Humanoid = v4:FindFirstChildOfClass("Humanoid")
    if Humanoid ~= nil then
        Humanoid.AutoRotate = false
        Humanoid.BreakJointsOnDeath = false
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
    return v4
end

local function playDance(a1) -- Line: 1176 -- upvalues: u165 (val), CaptureTheEgg (val) -- types: a1: userdata
    local v1
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    if Humanoid == nil then
        if u165.DanceHumanoid then
            return
        end
        u165.DanceHumanoid = true
        warn("[CaptureTheEgg] The starter's dancer rig has no Humanoid.")
        return
    end
    local Animator = Humanoid:FindFirstChildOfClass("Animator")
    if Animator == nil then
        v1 = Instance.new("Animator")
        v1.Parent = Humanoid
    else
        v1 = Animator
    end
    for i, j in v1:GetPlayingAnimationTracks() do
        j:Stop(0)
    end
    local v2 = Instance.new("Animation")
    local R6DanceAnimationId = if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then CaptureTheEgg.DanceAnimationId else CaptureTheEgg.R6DanceAnimationId
    v2.AnimationId = R6DanceAnimationId
    v2.Parent = a1
    local success, err = pcall(v1.LoadAnimation, v1, v2)
    if not success then
        warn((("[CaptureTheEgg] Could not load the starter dance: %*"):format(err)))
        return
    end
    err.Priority = Enum.AnimationPriority.Action
    err.Looped = true
    err:Play(0.1, 1, 1)
end

local function getModelTopOffset(a1) -- Line: 1212 -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return BoundingBox.Position.Y + BoundingBox_2.Y * 0.5 - a1:GetPivot().Position.Y
end

local function getModelBottomToPivot(a1) -- Line: 1217 -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return a1:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y * 0.5)
end

local function handheldNoise(a1, a2) -- Line: 1222 -- types: a1: number, a2: number
    return ((math.noise(a1 * 0.25, a2 * 7.31, 0.5)) + math.noise(a1 * 1.25, a2 * 7.31 + 3.17, 9.5) * 0.2) / 1.2 * 2
end

local function handheldOffset(a1, a2) -- Line: 1228 -- types: a1: number, a2: number
    local v1 = ((math.noise(a1 * 0.25, 7.31, 0.5)) + math.noise(a1 * 1.25, 10.48, 9.5) * 0.2) / 1.2 * 2 * 0.02007128639793479 * a2
    local v2 = ((math.noise(a1 * 0.25, 14.62, 0.5)) + math.noise(a1 * 1.25, 17.79, 9.5) * 0.2) / 1.2 * 2 * 0.014835298641951801 * a2
    local v3 = ((math.noise(a1 * 0.25, 21.93, 0.5)) + math.noise(a1 * 1.25, 25.1, 9.5) * 0.2) / 1.2 * 2 * 0.007853981633974483 * a2
    return (CFrame.new((Vector3.new(
        ((math.noise(a1 * 0.25, 29.24, 0.5)) + math.noise(a1 * 1.25, 32.41, 9.5) * 0.2) / 1.2 * 2 * 0.1599999964237213,
        ((math.noise(a1 * 0.25, 36.55, 0.5)) + math.noise(a1 * 1.25, 39.72, 9.5) * 0.2) / 1.2 * 2 * 0.12999999523162842,
        ((math.noise(a1 * 0.25, 43.86, 0.5)) + (math.noise(a1 * 1.25, 47.03, 9.5)) * 0.2) / 1.2 * 2 * 0.07999999821186066
    )) * a2)) * CFrame.Angles(0, v1, 0) * CFrame.Angles(v2, 0, v3)
end

local function resolveShotDirection(a1, a2) -- Line: 1240 -- types: a1: Vector2, a2: vector
    local v1 = a1.Position - a2
    local v2 = Vector3.new(v1.X, 0, v1.Z)
    if v2.Magnitude < 1 then
        return Vector3.new(1, 0, 1).Unit
    end
    return v2.Unit
end

local function resolveEggShot(a1, a2, a3) -- Line: 1249 -- types: a1: vector, a2: vector, a3: number
    return CFrame.lookAt(a1 + a2 * (a3 * 0.55 + 45) + Vector3.new(0, a3 * 0.18 + 11, 0), a1 + Vector3.new(0, a3 * 0.5, 0))
end

local function restoreCutsceneCamera() -- Line: 1256 -- upvalues: Workspace (val), u160 (ref)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = u160
    u160 = nil
    if CurrentCamera ~= nil and v1 ~= nil then
        CurrentCamera.CFrame = v1.CFrame
        CurrentCamera.FieldOfView = v1.FieldOfView
        CurrentCamera.CameraType = v1.CameraType
        if v1.CameraSubject ~= nil and v1.CameraSubject.Parent ~= nil then
            CurrentCamera.CameraSubject = v1.CameraSubject
        end
        return
    end
end

local function revealScoreboardAfterCutscene() -- Line: 1272
    -- upvalues: u154 (ref), refreshScoreboardAvailability (val)
    if not u154 then
        return
    end
    refreshScoreboardAvailability()
end

local function stopCutscene(a1) -- Line: 1279
    -- upvalues: u158 (ref), u157 (ref), RunService (val), u159 (ref), setOverlayShown (val), Workspace (val)
    -- upvalues: u160 (ref), u161 (ref), u154 (ref), refreshScoreboardAvailability (val)
    if not u158 then
        return
    end
    u157 = u157 + 1
    u158 = false
    pcall(RunService.UnbindFromRenderStep, RunService, "CaptureTheEggCutsceneCamera")
    local v1 = u159
    u159 = nil
    if v1 ~= nil then
        v1:Clean()
    end
    setOverlayShown(false)
    local CurrentCamera = Workspace.CurrentCamera
    local v2 = u160
    u160 = nil
    if CurrentCamera ~= nil and v2 ~= nil then
        CurrentCamera.CFrame = v2.CFrame
        CurrentCamera.FieldOfView = v2.FieldOfView
        CurrentCamera.CameraType = v2.CameraType
        if v2.CameraSubject ~= nil and v2.CameraSubject.Parent ~= nil then
            CurrentCamera.CameraSubject = v2.CameraSubject
        end
    end
    if u161 ~= nil then
        v2 = u161
        u161 = nil
        v2()
    end
    if a1 then
        if not u154 then
            return
        end
        refreshScoreboardAvailability()
    end
end

local function buildCutsceneRecord(a1, a2) -- Line: 1305 -- upvalues: EggRecords (val) -- types: a1: string, a2: table?
    local v1 = EggRecords.NewEgg(a1)
    if a2 ~= nil and #a2 > 0 then
        v1.Mutations = table.clone(a2)
        v1.BaseMutation = a2[1]
    end
    return v1
end

local function playCutscene(a1, a2, a3, a4, a5, a6) -- Line: 1314
    -- upvalues: u158 (ref), Workspace (val), u154 (ref), refreshScoreboardAvailability (val), EggRenderer (val)
    -- upvalues: EggRecords (val), CaptureTheEgg (val), u157 (ref), Trove (val), u159 (ref), CameraShaker (val)
    -- upvalues: cloneStarterCharacter (val), playDance (val), playSound (val), u160 (ref), u145 (ref)
    -- upvalues: getScoreboardUi (val), u149 (ref), u146 (ref), u152 (ref), u151 (ref), u142 (ref), u128 (val)
    -- upvalues: u124 (val), u132 (val), u161 (ref), HiddenUIHandler (val), setOverlayShown (val), TweenService (val)
    -- upvalues: emitImpactVfx (val), handheldOffset (val), CameraShakerDriver (val), stopCutscene (val)
    -- upvalues: RunService (val)
    if u158 then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        if not u154 then
            return
        end
        refreshScoreboardAvailability()
        return
    end
    local success, err = pcall(function() -- Line: 1332
        -- upvalues: EggRenderer (upval), a5 (val), a6 (val), EggRecords (upval), CaptureTheEgg (upval)
        -- upvalues: Workspace (upval)
        local RenderVisual = EggRenderer.RenderVisual
        local v1 = {OwnerUserId = 0, UID = "CaptureTheEggCutscene", ModelName = "CaptureTheEggCutsceneEgg"}
        local v2 = a6
        local v3 = EggRecords.NewEgg(a5)
        if v2 ~= nil and #v2 > 0 then
            v3.Mutations = table.clone(v2)
            v3.BaseMutation = v2[1]
        end
        v1.Record = v3
        v1.ScaleMultiplier = CaptureTheEgg.EggScale
        return RenderVisual(v1, Workspace)
    end)
    if not success then
        warn((("[CaptureTheEgg] Could not render the falling egg: %*"):format(err)))
        if not u154 then
            return
        end
        refreshScoreboardAvailability()
        return
    end
    local success_2, result = xpcall(function() -- Line: 1347
        -- upvalues: u157 (upval), u158 (upval), Trove (upval), u159 (upval), CameraShaker (upval), err (val), a2 (val)
        -- upvalues: CurrentCamera (val), a3 (val), cloneStarterCharacter (upval), a1 (val), Workspace (upval)
        -- upvalues: playDance (upval), playSound (upval), u160 (upval), u145 (upval), getScoreboardUi (upval)
        -- upvalues: u149 (upval), u146 (upval), u152 (upval), u151 (upval), u142 (upval), u128 (upval), u124 (upval)
        -- upvalues: u132 (upval), u161 (upval), HiddenUIHandler (upval), setOverlayShown (upval), a4 (val)
        -- upvalues: CaptureTheEgg (upval), TweenService (upval), emitImpactVfx (upval), handheldOffset (upval)
        -- upvalues: CameraShakerDriver (upval), stopCutscene (upval), RunService (upval)
        local u79
        u157 = u157 + 1
        local u2 = u157
        u158 = true
        local u6 = Trove.new()
        u159 = u6
        local u9 = CameraShaker.new()
        local Model = err.Model
        u6:Add(Model)
        local BoundingBox, BoundingBox_2 = Model:GetBoundingBox()
        local u30 = BoundingBox.Position.Y + BoundingBox_2.Y * 0.5 - Model:GetPivot().Position.Y
        local u34 = a2.Position + Vector3.new(0, 260, 0)
        local v1 = (CFrame.new(u34)) * a2.Rotation
        Model:PivotTo(v1)
        local v2 = CurrentCamera.CFrame.Position - a3.Position
        local v3 = Vector3.new(v2.X, 0, v2.Z)
        local Unit = if not (v3.Magnitude < 1) then v3.Unit else Vector3.new(1, 0, 1).Unit
        local u63 = cloneStarterCharacter(a1)
        if u63 == nil then
            u79 = 0
        else
            local BoundingBox_3, BoundingBox_4 = u63:GetBoundingBox()
            u79 = u63:GetPivot().Position.Y - (BoundingBox_3.Position.Y - BoundingBox_4.Y * 0.5)
        end
        local Rotation = CFrame.lookAt(Vector3.new(0, 0, 0), Unit).Rotation
        if u63 ~= nil then
            u63:PivotTo((CFrame.new(v1.Position + v1.UpVector * u30 + (Vector3.new(0, u79 + 0.25, 0)))) * Rotation)
            u63.Parent = Workspace
            u6:Add(u63)
            playDance(u63)
        end
        local u122 = os.clock()
        local u123 = false
        local u124_2 = false
        local u125 = true
        local u126 = false
        local u132_2 = playSound("CinematicRiser", u6, nil)
        u160 = {
            CFrame = CurrentCamera.CFrame,
            FieldOfView = CurrentCamera.FieldOfView,
            CameraType = CurrentCamera.CameraType,
            CameraSubject = CurrentCamera.CameraSubject,
        }
        local u142_2 = u160
        u145 = false
        local v4 = getScoreboardUi()
        if v4 ~= nil then
            local Gui = v4.Gui
            local Board = v4.Board
            v4 = u145 and u149
            if v4 == u146 then end
            u152 = u152 + 1
            local v5 = u151
            if v5 ~= nil then
                v5:Cancel()
            end
            u151 = nil
            if not v4 then
                u146 = false
                Board.Position = u132
                Gui.Enabled = false
            else
                Gui.Enabled = true
                if not u146 then
                    Board.Position = u132
                end
                u146 = true
                Board.Position = if not u142 then u124 else u128
            end
        end
        HiddenUIHandler.Acquire()
        setOverlayShown(true)
        CurrentCamera.CameraType = Enum.CameraType.Scriptable

        local function stepCutscene(a1) -- Line: 1397
            -- upvalues: u2 (val), u157 (upval), u158 (upval), CurrentCamera (upval), Workspace (upval), a4 (upval)
            -- upvalues: CaptureTheEgg (upval), u34 (val), a2 (upval), u125 (ref), Model (val), u63 (val), u30 (val)
            -- upvalues: u79 (val), Rotation (val), u123 (ref), u132_2 (val), TweenService (upval), u6 (val)
            -- upvalues: playSound (upval), a3 (upval), emitImpactVfx (upval), u9 (val), u122 (val), Unit (val)
            -- upvalues: u142_2 (val), u124_2 (ref), setOverlayShown (upval), handheldOffset (upval)
            -- upvalues: CameraShakerDriver (upval), u126 (ref), stopCutscene (upval)
            if u2 == u157 and u158 then
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                local ServerTimeNow = Workspace:GetServerTimeNow()
                local v1 = math.clamp((ServerTimeNow - (a4 - CaptureTheEgg.CutsceneFallSeconds)) / CaptureTheEgg.CutsceneFallSeconds, 0, 1)
                local v2 = v1 * 0.08 + v1 ^ 2.65 * 0.92
                local v3 = u34:Lerp(a2.Position, v2)
                v2 = math.sin(3.141592653589793 * v1)
                local v4 = math.sin(15.707963267948966 * v1) * 0.19198621771937624 * v2
                local v5 = math.sin(21.991148575128552 * v1) * 0.13962634015954636 * v2
                v2 = CFrame.Angles(v4, 25.132741228718345 * v1, v5)
                v5 = (CFrame.new(v3)) * a2.Rotation * v2
                if u125 then
                    Model:PivotTo(v5)
                end
                if u63 ~= nil then
                    u63:PivotTo((CFrame.new(v5.Position + v5.UpVector * u30 + Vector3.new(0, u79 + 0.25, 0))) * Rotation)
                end
                if v1 >= 1 and not u123 then
                    u123 = true
                    if u125 then
                        u125 = false
                        Model:PivotTo(a2)
                        Model:Destroy()
                    end
                    if u63 ~= nil then
                        u63:PivotTo((CFrame.new(a2.Position + a2.UpVector * u30 + Vector3.new(0, u79 + 0.25, 0))) * Rotation)
                    end
                    if u132_2 ~= nil and u132_2.Parent ~= nil then
                        v2 = TweenService:Create(u132_2, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Volume = 0})
                        u6:Add(v2)
                        v2:Play()
                    end
                    playSound("CinematicBoom", u6, nil)
                    playSound("ImpactBoom", u6, a3)
                    emitImpactVfx(a3)
                    u9:ShakeOnce(8.5, 12, 0, 1.35)
                end
                v1 = os.clock() - u122
                local v6 = 1 - (1 - math.clamp(v1 / 0.95, 0, 1)) ^ 5
                local v7 = Unit
                local v8 = u30
                local v9 = v3 + Vector3.new(0, v8 * 0.5, 0)
                local v10 = CFrame.lookAt(v3 + v7 * (v8 * 0.55 + 45) + Vector3.new(0, v8 * 0.18 + 11, 0), v9)
                local Position_2 = a2.Position
                v8 = Unit
                v9 = u30
                local v11 = Position_2 + Vector3.new(0, v9 * 0.5, 0)
                v3 = CFrame.lookAt(Position_2 + v8 * (v9 * 0.55 + 45) + Vector3.new(0, v9 * 0.18 + 11, 0), v11)
                v7 = u142_2.CFrame:Lerp(v10, v6)
                v10 = u142_2.FieldOfView + (50 - u142_2.FieldOfView) * v6
                v8 = math.max(ServerTimeNow - a4, 0)
                local v12 = 0
                if u123 then
                    v7 = u142_2.CFrame:Lerp(v3, v6)
                    v10 = v10 + math.exp(-v8 * 6) * 9
                    if v8 >= 1.5 then
                        v12 = math.clamp((v8 - 1.5) / 1.15, 0, 1)
                        v7 = v3:Lerp(u142_2.CFrame, if not (v12 < 0.5) then 1 - (v12 * -2 + 2) ^ 3 / 2 else v12 * 4 * v12 * v12)
                        v10 = (u142_2.FieldOfView - 50) * v9 + 50
                        if not u124_2 then
                            u124_2 = true
                            setOverlayShown(false)
                        end
                    end
                end
                v8 = math.clamp(v1 / 1.1, 0, 1)
                if u123 then
                    v8 = v8 * 0.55
                end
                v8 = v8 * (1 - v12)
                CurrentCamera.FieldOfView = v10
                CurrentCamera.CFrame = v7 * handheldOffset(v1, v8) * CameraShakerDriver.Advance(u9, a1)
                if v12 >= 1 and not u126 then
                    u126 = true
                    task.defer(function() -- Line: 1487 -- upvalues: u2 (upval), u157 (upval), stopCutscene (upval)
                        if u2 == u157 then
                            stopCutscene(true)
                        end
                    end)
                end
                return
            end
        end

        RunService:BindToRenderStep("CaptureTheEggCutsceneCamera", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 1495
            -- upvalues: stepCutscene (val), u126 (ref), u2 (val), u157 (upval), stopCutscene (upval)
            local success, result = xpcall(stepCutscene, debug.traceback, a1)
            if not success and not u126 then
                u126 = true
                warn((("[CaptureTheEgg] Cutscene frame failed: %*"):format(result)))
                task.defer(function() -- Line: 1500 -- upvalues: u2 (upval), u157 (upval), stopCutscene (upval)
                    if u2 == u157 then
                        stopCutscene(true)
                    end
                end)
            end
        end)
    end, debug.traceback)
    if not success_2 then
        warn((("[CaptureTheEgg] Cutscene setup failed: %*"):format(result)))
        if u158 then
            stopCutscene(true)
            return
        end
        if not u154 then
            return
        end
        refreshScoreboardAvailability()
    end
end

function v3.StartEvent(a1, a2, a3) -- Line: 1522
    -- upvalues: u153 (ref), u154 (ref), u155 (ref), Workspace (val), resetScoreboardCards (val), u145 (ref)
    -- upvalues: getScoreboardUi (val), u149 (ref), u146 (ref), u152 (ref), u151 (ref), u142 (ref), u128 (val)
    -- upvalues: u124 (val), u132 (val), CaptureTheEgg (val), u164 (val), ReplicatedStorage (val), EggRenderer (val)
    -- upvalues: EggRecords (val), ContentProvider (val), refreshScoreboardAvailability (val)
    u153 = u153 + 1
    u154 = true
    u155 = Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
    resetScoreboardCards()
    u145 = false
    local v1 = getScoreboardUi()
    if v1 ~= nil then
        local Gui = v1.Gui
        local Board = v1.Board
        v1 = u145 and u149
        if v1 == u146 then end
        u152 = u152 + 1
        local v2 = u151
        if v2 ~= nil then
            v2:Cancel()
        end
        u151 = nil
        if not v1 then
            u146 = false
            Board.Position = u132
            Gui.Enabled = false
        else
            Gui.Enabled = true
            if not u146 then
                Board.Position = u132
            end
            u146 = true
            Board.Position = if not u142 then u124 else u128
        end
    end
    local EggCategory = if type(a3) ~= "table" then CaptureTheEgg.CarryCategory else if type(a3.EggCategory) ~= "string" then CaptureTheEgg.CarryCategory else if a3.EggCategory == "" then CaptureTheEgg.CarryCategory else a3.EggCategory
    if not u164[EggCategory] then
        u164[EggCategory] = true
        task.spawn(function() -- Line: 994
            -- upvalues: ReplicatedStorage (upval), EggRenderer (upval), EggRecords (upval), EggCategory (val)
            -- upvalues: CaptureTheEgg (upval), ContentProvider (upval)
            local Assets, v1, v2, v3, v4
            local v5 = {}
            local v6 = {}
            local v7 = {
                {"Sounds", "CinematicRiser"},
                {"Sounds", "CinematicBoom"},
                {"Sounds", "ImpactBoom"},
                {"Particles", "BigHitGroundAttach"},
            }
            local v8 = nil
            local v9 = nil
            for i, j in v7, v8, v9 do
                v3 = j[1]
                v4 = j[2]
                Assets = ReplicatedStorage:FindFirstChild("Assets")
                v1 = Assets and Assets:FindFirstChild(v3)
                v2 = v1 and v1:FindFirstChild(v4)
                if v2 ~= nil then
                    table.insert(v5, v2)
                end
            end
            local success, err = pcall(function() -- Line: 1011 -- upvalues: EggRenderer (upval), EggRecords (upval), EggCategory (upval)
                return EggRenderer.GetTemplate(EggRecords.NewEgg(EggCategory))
            end)
            if success and typeof(err) == "Instance" then
                table.insert(v5, err)
            end
            v9 = {CaptureTheEgg.DanceAnimationId, CaptureTheEgg.R6DanceAnimationId}
            local v10 = nil
            for k, n in v9, nil, v10 do
                v8 = Instance.new("Animation")
                v8.AnimationId = n
                table.insert(v5, v8)
                table.insert(v6, v8)
            end
            if #v5 > 0 then
                v10 = ContentProvider
                pcall(ContentProvider.PreloadAsync, v10, v5)
            end
            for m, i5 in v6 do
                i5:Destroy()
            end
        end)
    end
    refreshScoreboardAvailability()
end

function v3.StopEvent(a1) -- Line: 1532
    -- upvalues: u153 (ref), u154 (ref), u155 (ref), stopCutscene (val), u145 (ref), applyBoardVisibility (val)
    -- upvalues: getScoreboardUi (val), hideCard (val), resetScoreboardCards (val), u149 (ref), u146 (ref), u152 (ref)
    -- upvalues: u151 (ref), u142 (ref), u128 (val), u124 (val), u132 (val)
    u153 = u153 + 1
    local u3 = u153
    u154 = false
    u155 = false
    stopCutscene(false)
    u145 = false
    applyBoardVisibility(nil)
    local v1 = getScoreboardUi()
    if v1 ~= nil then
        for i, j in v1.Cards do
            hideCard(j)
        end
    end
    task.delay(0.26, function() -- Line: 1545
        -- upvalues: u3 (val), u153 (upval), resetScoreboardCards (upval), u145 (upval), getScoreboardUi (upval)
        -- upvalues: u149 (upval), u146 (upval), u152 (upval), u151 (upval), u142 (upval), u128 (upval), u124 (upval)
        -- upvalues: u132 (upval)
        if u3 == u153 then
            resetScoreboardCards()
            u145 = false
            local v1 = getScoreboardUi()
            if v1 == nil then
                return
            end
            local Gui = v1.Gui
            local Board = v1.Board
            v1 = u145 and u149
            if v1 == u146 then end
            u152 = u152 + 1
            local v2 = u151
            if v2 ~= nil then
                v2:Cancel()
            end
            u151 = nil
            if v1 then
                Gui.Enabled = true
                if not u146 then
                    Board.Position = u132
                end
                u146 = true
                Board.Position = if not u142 then u124 else u128
                return
            end
            u146 = false
            Board.Position = u132
            Gui.Enabled = false
        end
    end)
end

Remotes.EggCapture.StandingsRefreshed.OnClientEvent:Connect(function(a1, a2) -- Line: 1559 -- upvalues: renderScoreboard (val) -- types: a1: table, a2: table
    if type(a1) ~= "table" then
        return
    end
    renderScoreboard(a1, a2)
end)
Remotes.EggCapture.CutsceneBegan.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6) -- Line: 1568
    -- upvalues: playCutscene (val)
    if type(a1) == "number"
        and typeof(a2) == "CFrame"
        and typeof(a3) == "CFrame"
        and type(a4) == "number"
        and a4 == a4
        and type(a5) == "string" then
        playCutscene(a1, a2, a3, a4, a5, if type(a6) ~= "table" then nil else a6)
        return
    end
end)
AreaEggResetWall.Changed:Connect(function(a1) -- Line: 1599
    -- upvalues: u150 (ref), u149 (ref), applyBoardVisibility (val), AreaEggResetWall (val)
    u150 = u150 + 1
    if not a1 then
        local u7 = u150
        task.delay(AreaEggResetWall.CollapseSeconds, function() -- Line: 1606
            -- upvalues: u7 (val), u150 (upval), AreaEggResetWall (upval), u149 (upval), applyBoardVisibility (upval)
            if u7 == u150 and not AreaEggResetWall.IsSealed() then
                if u149 == true then
                    return
                end
                u149 = true
                applyBoardVisibility()
            end
        end)
        return
    end
    if u149 == false then
        return
    end
    u149 = false
    applyBoardVisibility()
end)
EggState.CarryChanged:Connect(function(a1) -- Line: 1613
    -- upvalues: setLocalPlayerCarryingEgg (val), u143 (ref), Workspace (val), EggUidAttribute (val), u144 (ref)
    -- upvalues: SpawnLock (val)
    setLocalPlayerCarryingEgg(a1.IsCarrying)
    u143 = if not a1.IsCarrying then nil else a1.Uid
    local v1 = false
    if u143 ~= nil then
        v1 = u143 == Workspace:GetAttribute(EggUidAttribute)
    end
    if v1 and u144 == nil then
        u144 = SpawnLock.ObtainLock()
        return
    end
    if not v1 and u144 ~= nil then
        local v2 = u144
        u144 = nil
        v2()
    end
end)
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 1619
    -- upvalues: setLocalPlayerCarryingEgg (val), u143 (ref), Workspace (val), EggUidAttribute (val), u144 (ref)
    -- upvalues: SpawnLock (val)
    setLocalPlayerCarryingEgg(false)
    u143 = nil
    local v1 = false
    if u143 ~= nil then
        v1 = u143 == Workspace:GetAttribute(EggUidAttribute)
    end
    if v1 and u144 == nil then
        u144 = SpawnLock.ObtainLock()
        return
    end
    if not v1 and u144 ~= nil then
        local v2 = u144
        u144 = nil
        v2()
    end
end)
;(Workspace:GetAttributeChangedSignal(EggUidAttribute)):Connect(function() -- Line: 391 -- upvalues: u143 (ref), Workspace (val), EggUidAttribute (val), u144 (ref), SpawnLock (val)
    local v1 = false
    if u143 ~= nil then
        v1 = u143 == Workspace:GetAttribute(EggUidAttribute)
    end
    if v1 and u144 == nil then
        u144 = SpawnLock.ObtainLock()
        return
    end
    if not v1 and u144 ~= nil then
        local v2 = u144
        u144 = nil
        v2()
    end
end)
;(Workspace:GetAttributeChangedSignal("Event_CaptureTheEggGameplay")):Connect(refreshScoreboardAvailability)
RunService.RenderStepped:Connect(function() -- Line: 1629 -- upvalues: u134 (ref), u146 (ref), refreshScoreboardCards (val), buildLiveEntries (val)
    local v1 = u134
    if v1 ~= nil and u146 then
        if not v1.Gui.Enabled then
            return
        end
        refreshScoreboardCards((buildLiveEntries()))
    end
end)
task.defer(function() -- Line: 1635
    -- upvalues: Workspace (val), u154 (ref), refreshScoreboardAvailability (val), resetScoreboardCards (val)
    -- upvalues: u145 (ref), getScoreboardUi (val), u149 (ref), u146 (ref), u152 (ref), u151 (ref), u142 (ref)
    -- upvalues: u128 (val), u124 (val), u132 (val)
    if Workspace:GetAttribute("Event_CaptureTheEgg") == true then
        u154 = true
        refreshScoreboardAvailability()
        return
    end
    resetScoreboardCards()
    u145 = false
    local v1 = getScoreboardUi()
    if v1 == nil then
        return
    end
    local Gui = v1.Gui
    local Board = v1.Board
    v1 = u145 and u149
    if v1 == u146 then end
    u152 = u152 + 1
    local v2 = u151
    if v2 ~= nil then
        v2:Cancel()
    end
    u151 = nil
    if not v1 then
        u146 = false
        Board.Position = u132
        Gui.Enabled = false
        return
    end
    Gui.Enabled = true
    if not u146 then
        Board.Position = u132
    end
    u146 = true
    Board.Position = if not u142 then u124 else u128
end)
return v3