-- Script path: ReplicatedStorage.Client.UI.VFX.SpeedGainPopup
-- Decompile time: 13.34 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local Player = require(ReplicatedStorage.Shared.Player)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local u42 = {popFromScale = 0.7, pulseSeconds = 0.25, pulsePeak = 1.06}
u42.popInfo = TweenInfo.new(0.28, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
u42.pulseOutInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u42.pulseInInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u58 = {
    fadeDelay = 0.5,
    clearDelay = 0.35,
    icon = "rbxassetid://78137530993637",
    sink = Vector3.new(0, -1, 0),
}
u58.growInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
u58.riseInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
u58.fadeInfo = TweenInfo.new(0.3)
u58.baseTint = Color3.fromRGB(178, 233, 255)
u58.tintLadder = {
    {from = 100, isInclusive = true, tint = Color3.fromRGB(255, 0, 0)},
    {from = 25, isInclusive = true, tint = Color3.fromRGB(255, 67, 199)},
    {from = 9, isInclusive = true, tint = Color3.fromRGB(0, 255, 255)},
    {from = 1, isInclusive = false, tint = Color3.fromRGB(255, 238, 0)},
}
local u102 = {
    seconds = 0.85,
    fadeStart = 0.72,
    startScale = 0.72,
    scaleWave = 0.18,
    touchDivisor = 2.5,
    launchXFraction = 0.25,
    cloneName = "SpeedGainPopup",
    playbackSpeed = 1,
}
u102.lift = NumberRange.new(100, 150)
u102.bend = NumberRange.new(90, 120)
local u111 = {TextLabel = "TextTransparency", ImageLabel = "ImageTransparency", UIStroke = "Transparency"}
local u112 = {}
local LocalPlayer = Players.LocalPlayer
local u116 = Random.new()
local u117 = {}

local function build(a1, a2, a3) -- Line: 72 -- types: a1: string, a2: table, a3: userdata?
    local v1 = Instance.new(a1)
    for i, j in a2 do
        v1[i] = j
    end
    v1.Parent = a3
    return v1
end

local function scaleFor(a1) -- Line: 81 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    UIScale.Parent = a1
    return UIScale
end

local function headlineScale(a1) -- Line: 87 -- types: a1: userdata
    local Parent = a1.Parent
    if Parent ~= nil and Parent:IsA("GuiObject") then
        local UIScale = Parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        UIScale.Parent = Parent
        return UIScale
    end
    return nil
end

local function popHeadline(a1) -- Line: 92 -- upvalues: u42 (val), TweenService (val) -- types: a1: userdata
    local v1
    local Parent = a1.Parent
    if Parent == nil or not Parent:IsA("GuiObject") then
        v1 = nil
    else
        v1 = Parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        v1.Parent = Parent
    end
    if v1 ~= nil then
        v1.Scale = u42.popFromScale
        TweenService:Create(v1, u42.popInfo, {Scale = 1}):Play()
    end
end

local function paintAlpha(a1, a2) -- Line: 100 -- upvalues: u111 (val) -- types: a1: userdata, a2: number
    local v1
    for i, j in a1:GetDescendants() do
        v1 = u111[j.ClassName]
        if v1 ~= nil then
            j[v1] = a2
        end
    end
end

local function ladderTint(a1) -- Line: 109 -- upvalues: u58 (val) -- types: a1: number
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for i, j in u58.tintLadder, v1, v2 do
        if j.isInclusive and j.from <= v3 then
            return j.tint
        end
        if j.from < v3 then
            return j.tint
        end
    end
    return u58.baseTint
end

local function spread(a1, a2) -- Line: 118 -- upvalues: u116 (val) -- types: a1: Color3, a2: number
    return u116:NextNumber(a1.Min * a2, a1.Max * a2)
end

local function arcSampler(a1, a2) -- Line: 122
    -- upvalues: UserInputService (val), u102 (val), u116 (val)
    local v1 = if not UserInputService.TouchEnabled then 1 else 1 / u102.touchDivisor
    local bend = u102.bend
    local v2 = (u116:NextNumber(bend.Min * v1, bend.Max * v1)) * (if not (a1.X <= a2.X) then 1 else -1)
    local lift = u102.lift
    local v3 = u116:NextNumber(lift.Min * v1, lift.Max * v1)
    local u49 = (a1 + a2) * 0.5 + Vector2.new(v2, -v3)
    return function(a1_2) -- Line: 128 -- upvalues: a1 (val), u49 (val), a2 (val) -- types: a1_2: number
        local v1 = 1 - a1_2
        return a1 * (v1 * v1) + u49 * (v1 * 2 * a1_2) + a2 * (a1_2 * a1_2)
    end
end

local function raiseBadge(a1, a2, a3, a4, a5) -- Line: 134
    -- upvalues: Player (val), LocalPlayer (val), GUI (val), u58 (val), ladderTint (val), u116 (val), TweenService (val)
    -- upvalues: popHeadline (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 == nil then
        return
    end
    local v2 = {
        AlwaysOnTop = true,
        Name = "PlusOne",
        StudsOffset = Vector3.new(0, 1, 0),
        Adornee = v1,
        Size = UDim2.new(4.5, 0, 1.5, 0),
    }
    local v3 = GUI.PlayerGui()
    local u22 = Instance.new("BillboardGui")
    for i, j in v2 do
        u22[i] = j
    end
    u22.Parent = v3
    v2 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
    }
    v1 = Instance.new("Frame")
    for k, n in v2 do
        v1[k] = n
    end
    v1.Parent = u22
    v2 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0.05, 0),
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }
    local UIListLayout = Instance.new("UIListLayout")
    for m, i5 in v2 do
        UIListLayout[m] = i5
    end
    UIListLayout.Parent = v1
    v3 = {BackgroundTransparency = 1, Image = u58.icon, Size = UDim2.new(0.3, 0, 0.8, 0)}
    local u103 = Instance.new("ImageLabel")
    for i6, i7 in v3 do
        u103[i6] = i7
    end
    u103.Parent = v1
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    for i8, i9 in {AspectRatio = 1} do
        UIAspectRatioConstraint[i8] = i9
    end
    UIAspectRatioConstraint.Parent = u103
    local v4 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Font = Enum.Font.GothamBlack,
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Text = a2,
        TextColor3 = a4 or ladderTint(a3 or 1),
    }
    local u152 = Instance.new("TextLabel")
    for i10, i11 in v4 do
        u152[i10] = i11
    end
    u152.Parent = v1
    local u169 = Instance.new("UIStroke")
    for i12, i13 in {Thickness = 2} do
        u169[i12] = i13
    end
    u169.Parent = u152
    local u201 = Vector3.new(u116:NextInteger(-4, 4), u116:NextInteger(3, 5), (u116:NextInteger(-2, 2)))
    TweenService:Create(v1, u58.growInfo, {Size = UDim2.new(1, 0, 1, 0)}):Play()
    TweenService:Create(u22, u58.riseInfo, {StudsOffset = u201}):Play()
    if a5 ~= nil then
        a5()
    end
    task.delay(u58.fadeDelay, function() -- Line: 194
        -- upvalues: u152 (val), u103 (val), u169 (val), u22 (val), u201 (val), u58 (upval), TweenService (upval)
        -- upvalues: popHeadline (upval), a1 (val)
        for i, j in {
            {u152, {TextTransparency = 1}},
            {u103, {ImageTransparency = 1}},
            {u169, {Transparency = 1}},
            {u22, {StudsOffset = u201 + u58.sink}},
        } do
            TweenService:Create(j[1], u58.fadeInfo, j[2]):Play()
        end
        task.delay(u58.clearDelay, function() -- Line: 205 -- upvalues: popHeadline (upval), a1 (upval), u22 (upval)
            popHeadline(a1)
            u22:Destroy()
        end)
    end)
end

local function flyToHeadline(a1, a2, a3, a4, a5) -- Line: 212
    -- upvalues: GUI (val), u102 (val), arcSampler (val), u111 (val), Audio (val), RunService (val), popHeadline (val)
    local function finish() -- Line: 219 -- upvalues: a5 (val)
        if a5 ~= nil then
            a5()
        end
    end

    local CurrentCamera = workspace.CurrentCamera
    if not (a2 <= 0) and CurrentCamera ~= nil then
        local v1, v2
        local v3 = GUI.SpeedGainAnimation()
        assert(v3:IsA("ScreenGui"), "speed gain host is not a ScreenGui")
        local Frame = v3.Frame
        assert(Frame:IsA("Frame"), "speed gain host is missing its Frame template")
        local v4 = Frame:Clone()
        v4.Name = u102.cloneName
        v4.Visible = true
        v4.AnchorPoint = Vector2.new(0.5, 0.5)
        local CurrentBoost = v4.CurrentBoost
        assert(CurrentBoost:IsA("TextLabel"), "speed gain template has no CurrentBoost label")
        local UIScale = CurrentBoost:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        UIScale.Parent = CurrentBoost
        CurrentBoost.Text = a3
        UIScale.Scale = u102.startScale
        local ViewportSize = CurrentCamera.ViewportSize
        local v5 = a4 or Vector2.new(ViewportSize.X * u102.launchXFraction, ViewportSize.Y)
        local v6 = arcSampler(v5, a1.AbsolutePosition + a1.AbsoluteSize * 0.5)
        v4.Position = UDim2.fromOffset(v5.X, v5.Y)
        v4.Parent = v3
        for i, j in v4:GetDescendants() do
            v3 = u111[j.ClassName]
            if v3 ~= nil then
                j[v3] = 0
            end
        end
        if u102.spawnSoundId then
            Audio.Play(u102.spawnSoundId, script, {PlaybackSpeed = u102.playbackSpeed})
        end
        v5 = os.clock()
        local v7 = 0
        while v7 < 1 do
            if v4.Parent == nil then
                break
            end
            v7 = math.min((os.clock() - v5) / u102.seconds, 1)
            v1 = v6(v7)
            v4.Position = UDim2.fromOffset(v1.X, v1.Y)
            UIScale.Scale = u102.startScale + (math.sin(v7 * 3.141592653589793)) * u102.scaleWave
            v2 = math.clamp((v7 - u102.fadeStart) / (1 - u102.fadeStart), 0, 1)
            for k, n in v4:GetDescendants() do
                v1 = u111[n.ClassName]
                if v1 ~= nil then
                    n[v1] = v2
                end
            end
            RunService.RenderStepped:Wait()
        end
        if v4.Parent == nil then
            if a5 ~= nil then
                a5()
            end
            return
        end
        if u102.landingSoundId then
            Audio.Play(u102.landingSoundId, script)
        end
        popHeadline(v8)
        v4:Destroy()
        if a5 ~= nil then
            a5()
        end
        return
    end
    if a5 ~= nil then
        a5()
    end
end

function u112.PlayWalk(a1, a2, a3, a4) -- Line: 285
    -- upvalues: u112 (val)
    u112.ShowGainBadge(a1, a2, a3, a4)
end

function u112.ShowGainBadge(a1, a2, a3, a4) -- Line: 294
    -- upvalues: TreadmillUtil (val), raiseBadge (val)
    if not (a2 <= 0) then
        raiseBadge(a1, "+" .. TreadmillUtil.FormatSpeedPower((math.round(a2))), a2, a3, a4)
        return
    end
    if a4 ~= nil then
        a4()
    end
end

function u112.Play(a1, a2, a3, a4) -- Line: 311
    -- upvalues: TreadmillUtil (val), flyToHeadline (val)
    flyToHeadline(a1, a2, "+" .. (TreadmillUtil.FormatSpeedPower(a2)) .. " Speed", a3, a4)
end

function u112.SetHeadlinePulsing(a1, a2) -- Line: 321
    -- upvalues: u117 (val), TweenService (val), u42 (val)
    local u18
    local Parent = a1.Parent
    if Parent == nil or not Parent:IsA("GuiObject") then
        u18 = nil
    else
        u18 = Parent:FindFirstChildOfClass("UIScale")
        if not u18 then
            u18 = Instance.new("UIScale")
        end
        u18.Parent = Parent
    end
    if u18 == nil then
        return
    end
    local v1 = u117[u18]
    if v1 ~= nil and v1.isActive == a2 then
        return
    end
    local u30 = (if not v1 then 0 else v1.token) + 1
    u117[u18] = {isActive = a2, token = u30}
    if not a2 then
        TweenService:Create(u18, u42.pulseInInfo, {Scale = 1}):Play()
        return
    end
    task.spawn(function() -- Line: 340 -- upvalues: u117 (upval), u18 (val), u30 (val), u42 (upval), TweenService (upval)
        local v1, v2, v3, v4, v5

        local function isStillOurs() -- Line: 341 -- upvalues: u117 (upval), u18 (upval), u30 (upval)
            local v1 = u117[u18]
            local v2 = false
            if v1 ~= nil then
                v2 = false
                if v1.token == u30 then
                    v2 = u18:IsDescendantOf(game)
                end
            end
            return v2
        end

        local v6 = {
            {info = u42.pulseOutInfo, scale = u42.pulsePeak},
            {scale = 1, info = u42.pulseInInfo},
        }
        while true do
            v2 = u117[u18]
            v1 = false
            if v2 ~= nil then
                v1 = false
                if v2.token == u30 then
                    v1 = u18:IsDescendantOf(game)
                end
            end
            if not v1 then
                return
            else
                v2 = nil
                v3 = nil
                for i, j in v6, v2, v3 do
                    v5 = u117[u18]
                    v4 = false
                    if v5 ~= nil then
                        v4 = false
                        if v5.token == u30 then
                            v4 = u18:IsDescendantOf(game)
                        end
                    end
                    if not v4 then
                        return
                    end
                    TweenService:Create(u18, j.info, {Scale = j.scale}):Play()
                    task.wait(u42.pulseSeconds)
                end
            end
        end
    end)
end

function u112.HideSource() -- Line: 363 -- upvalues: GUI (val)
    local v1 = GUI.SpeedGainAnimation()
    assert(v1:IsA("ScreenGui"), "speed gain host is not a ScreenGui")
    local Frame = v1.Frame
    assert(Frame:IsA("Frame"), "speed gain host is missing its Frame template")
    Frame.Visible = false
end

return u112