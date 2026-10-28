-- Script path: ReplicatedStorage.Shared.Eggs.PlacedEggBillboard
-- Decompile time: 15.43 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local HoverHighlight = require(ReplicatedStorage.Client.WorldFX.HoverHighlight)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local SurfaceTracker = require(ReplicatedStorage.Client.SmartProximityPrompt.SurfaceTracker)
local MonsterParasite_2 = require(ReplicatedStorage.Data.MonsterParasite)
local Save = require(ReplicatedStorage.Shared.Save)
local t = require(ReplicatedStorage.Packages.t)
local u101 = {}
local u102 = {}
local u103 = nil
local u104 = nil
local u105 = ""
local u106 = nil
local u107 = 0
local u108 = nil
local u109 = nil
local v1 = {}

local function getKey(a1, a2) -- Line: 81 -- types: a1: number, a2: string
    return (("%*:%*"):format(a1, a2))
end

local function bindGui() -- Line: 83 -- upvalues: u104 (ref), GUI (val)
    local v1 = u104
    if v1 ~= nil then
        return v1
    end
    v1 = GUI.AssetEggData()
    assert(v1:IsA("ScreenGui"), "PlayerGui.AssetEggData must be a ScreenGui")
    local Frame = v1.Frame
    assert(Frame:IsA("GuiObject"), "AssetEggData.Frame must be a GuiObject")
    local CanvasGroup = Frame.CanvasGroup
    assert(CanvasGroup:IsA("GuiObject"), "AssetEggData.Frame.CanvasGroup must be a GuiObject")
    local DisplayName = CanvasGroup.DisplayName
    assert(DisplayName:IsA("TextLabel"), "AssetEggData.Frame.CanvasGroup.DisplayName must be a TextLabel")
    local RemainingHatchTime = CanvasGroup.RemainingHatchTime
    assert(RemainingHatchTime:IsA("TextLabel"), "AssetEggData.Frame.CanvasGroup.RemainingHatchTime must be a TextLabel")
    local v2 = {
        Root = v1,
        Frame = Frame,
        CanvasGroup = CanvasGroup,
        DisplayName = DisplayName,
        RemainingHatchTime = RemainingHatchTime,
    }
    u104 = v2
    Frame.Visible = false
    RemainingHatchTime.RichText = true
    return v2
end

local function getRemainingSeconds(a1) -- Line: 120 -- upvalues: EggRecords (val), ServerClock (val), Players (val)
    local Record = a1.Record
    local Placement = Record.Placement
    if Placement ~= nil and Placement.ReadyAt == nil then
        local TimeSkipSeconds = a1.TimeSkipSeconds
        return (math.max(
            0,
            (EggRecords.GrowthSecondsRemaining(Record, ServerClock.Now(), Record.GrowthSpeedMultiplier, nil, Players.LocalPlayer)) - (if TimeSkipSeconds == nil then 0 else TimeSkipSeconds.Value)
        ))
    end
    return 0
end

local function getEntryScreenPosition(a1) -- Line: 141 -- upvalues: Workspace (val), ModelBounds (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return false, Vector2.zero
    end
    local v1, v2 = CurrentCamera:WorldToViewportPoint((ModelBounds(a1.Model)).Position)
    if not v2 then
        return false, Vector2.zero
    end
    return true, Vector2.new(v1.X, v1.Y)
end

local function selectNearestEntry() -- Line: 157 -- upvalues: Players (val), u101 (val)
    local Character = Players.LocalPlayer.Character
    if Character ~= nil and Character.PrimaryPart ~= nil then
        local ClosestSurfacePoint_2
        local v1 = nil
        local v2 = (1 / 0)
        for k, v in pairs(u101) do
            if v.Model.Parent ~= nil then
                _, ClosestSurfacePoint_2 = v.Tracker:GetClosestSurfacePoint(Character.PrimaryPart.Position, 0, 7)
                if ClosestSurfacePoint_2 ~= nil and ClosestSurfacePoint_2 <= 7 and ClosestSurfacePoint_2 < v2 then
                    v1 = v
                end
            end
        end
        return v1
    end
    return nil
end

local function updateStaticContent(a1, a2) -- Line: 181
    -- upvalues: Assets (val), SwapGradient (val)
    local v1 = Assets.Directory[a2.Record.AssetCategory]
    local v2 = ("Missing asset config for category %*"):format(a2.Record.AssetCategory)
    assert(v1 ~= nil, v2)
    a1.DisplayName.Text = "Egg"
    SwapGradient(a1.DisplayName, if v1.Egg.HideRarity then nil else if a2.Record.PurchaseId == nil then v1.Rarity.RarityGradient else nil)
end

local function updateCountdown(a1, a2) -- Line: 194
    -- upvalues: Players (val), u105 (ref), EggRecords (val), ServerClock (val), Elapsed (val), Save (val)
    -- upvalues: MonsterParasite (val), MonsterParasite_2 (val)
    local v1 = a2.OwnerUserId == Players.LocalPlayer.UserId
    a1.RemainingHatchTime.Visible = v1
    if not v1 then
        u105 = ""
        return
    end
    local Record = a2.Record
    local Placement = Record.Placement
    if Placement == nil then
        v1 = 0
    elseif Placement.ReadyAt == nil then
        local TimeSkipSeconds = a2.TimeSkipSeconds
        local Value = if TimeSkipSeconds == nil then 0 else TimeSkipSeconds.Value
        v1 = math.max(
            0,
            (EggRecords.GrowthSecondsRemaining(Record, ServerClock.Now(), Record.GrowthSpeedMultiplier, nil, Players.LocalPlayer)) - Value
        )
    else
        v1 = 0
    end
    local v2 = if not (v1 <= 0) then Elapsed(v1) else "Ready!"
    local v3 = EggRecords.ServerGrowthBoostMultiplier()
    local v4 = Save.Await()
    local v5 = if v4 == nil then 0 else if not MonsterParasite.IsBoostActive(v4.MonsterParasite, MonsterParasite.BoostKinds.EggGrowth) then 0 else MonsterParasite_2.BoostMultiplier(MonsterParasite.BoostKinds.EggGrowth) - 1
    v4 = a2.Record.GrowthSpeedMultiplier + v3 + v5
    if v1 > 0 and v4 > 1 then
        v2 = v2 .. (" <font color=\"#FFD700\">(x%*)</font>"):format(v4)
    end
    if v2 == u105 then
        return
    end
    u105 = v2
    a1.RemainingHatchTime.Text = v2
end

local function clearActiveHighlight() -- Line: 235 -- upvalues: u106 (ref), HoverHighlight (val)
    local v1 = u106
    u106 = nil
    if v1 ~= nil then
        HoverHighlight.FadeOut(v1, 0.25)
    end
end

local function clearFadeTween() -- Line: 243 -- upvalues: u108 (ref), u109 (ref)
    local v1 = u108
    u108 = nil
    u109 = nil
    if v1 ~= nil then
        v1:Cancel()
        v1:Destroy()
    end
end

local function playCanvasFade(a1, a2, a3) -- Line: 253
    -- upvalues: u108 (ref), u109 (ref), u103 (ref), u107 (ref), TweenService (val)
    if u108 ~= nil and u109 == a2 then
        return
    end
    local v1 = u108
    u108 = nil
    u109 = nil
    if v1 ~= nil then
        v1:Cancel()
        v1:Destroy()
    end
    u109 = a2
    if a2 < 1 then
        a1.Frame.Visible = true
    end
    if not ((math.abs(a1.CanvasGroup.GroupTransparency - a2)) <= 0.001) then
        local u49 = TweenService:Create(a1.CanvasGroup, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = a2})
        u108 = u49
        u49.Completed:Once(function(a1_2) -- Line: 284
            -- upvalues: u108 (upval), u49 (val), u109 (upval), a1 (val), a2 (val), a3 (val), u103 (upval), u107 (upval)
            if u108 == u49 then
                u108 = nil
                u109 = nil
            end
            u49:Destroy()
            if a1_2 ~= Enum.PlaybackState.Completed then
                return
            end
            a1.CanvasGroup.GroupTransparency = a2
            if a2 >= 1 and a3 ~= nil and u103 == nil and u107 == a3 then
                a1.Frame.Visible = false
            end
        end)
        u49:Play()
        return
    end
    a1.CanvasGroup.GroupTransparency = a2
    u109 = nil
    if a2 >= 1 and a3 ~= nil and u103 == nil and u107 == a3 then
        a1.Frame.Visible = false
    end
end

local function setActiveEntry(a1) -- Line: 307
    -- upvalues: u103 (ref), bindGui (val), u105 (ref), u107 (ref), u106 (ref), HoverHighlight (val)
    -- upvalues: playCanvasFade (val), updateStaticContent (val), updateCountdown (val)
    local v1, v2, v3
    if a1 == nil then
        if u103 == nil then
            return
        end
        v1 = bindGui()
        u103 = nil
        u105 = ""
        u107 = u107 + 1
        v2 = u107
        v3 = u106
        u106 = nil
        if v3 ~= nil then
            HoverHighlight.FadeOut(v3, 0.25)
        end
        if v1.Frame.Visible then
            playCanvasFade(v1, 1, v2)
        end
        return
    end
    v1 = bindGui()
    u107 = u107 + 1
    if not v1.Frame.Visible then
        v1.CanvasGroup.GroupTransparency = 1
    end
    playCanvasFade(v1, 0, nil)
    v2 = ("%*:%*"):format(a1.OwnerUserId, a1.Uid)
    if u103 ~= v2 then
        u103 = v2
        u105 = ""
        v3 = u106
        u106 = nil
        if v3 ~= nil then
            HoverHighlight.FadeOut(v3, 0.25)
        end
        HoverHighlight.FadeIn(a1.Model, "EggHoverHighlight", 0.25)
        updateStaticContent(v1, a1)
    end
    updateCountdown(v1, a1)
    v1.Frame.Visible = true
end

function v1.SetEntry(a1) -- Line: 372
    -- upvalues: t (val), Eggs (val), u101 (val), SurfaceTracker (val)
    t.strict(t.number)(a1.OwnerUserId)
    t.strict(t.string)(a1.Uid)
    t.strict(t.instanceIsA("Model"))(a1.Model)
    assert(Eggs.SchemaValidation.RuntimeEggRecord(a1.Record), "Invalid runtime egg record")
    local v1 = ("%*:%*"):format(a1.OwnerUserId, a1.Uid)
    local v2 = u101[v1]
    local Tracker = if v2 == nil then SurfaceTracker.new(a1.Model) else if v2.Model ~= a1.Model then SurfaceTracker.new(a1.Model) else v2.Tracker
    if v2 ~= nil and v2.Model ~= a1.Model then
        v2.Tracker:Destroy()
    end
    u101[v1] = {
        OwnerUserId = a1.OwnerUserId,
        Uid = a1.Uid,
        Record = a1.Record,
        Model = a1.Model,
        TimeSkipSeconds = a1.TimeSkipSeconds,
        Tracker = Tracker,
    }
end

function v1.SetNightPresentationActive(a1, a2, a3) -- Line: 397
    -- upvalues: t (val), u102 (val), u103 (ref), bindGui (val), u105 (ref), u107 (ref), u106 (ref)
    -- upvalues: HoverHighlight (val), playCanvasFade (val)
    t.strict(t.number)(a1)
    t.strict(t.string)(a2)
    t.strict(t.boolean)(a3)
    local v1 = ("%*:%*"):format(a1, a2)
    if not a3 then
        u102[v1] = nil
        return
    end
    u102[v1] = a1
    if u103 == nil then
        return
    end
    local v2 = bindGui()
    u103 = nil
    u105 = ""
    u107 = u107 + 1
    local v3 = u106
    u106 = nil
    if v3 ~= nil then
        HoverHighlight.FadeOut(v3, 0.25)
    end
    if not v2.Frame.Visible then
        return
    end
    playCanvasFade(v2, 1, u107)
end

function v1.RemoveEntry(a1, a2) -- Line: 415
    -- upvalues: t (val), u101 (val), u102 (val), u103 (ref), bindGui (val), u105 (ref), u107 (ref), u106 (ref)
    -- upvalues: HoverHighlight (val), playCanvasFade (val)
    t.strict(t.number)(a1)
    t.strict(t.string)(a2)
    local v1 = ("%*:%*"):format(a1, a2)
    local v2 = u101[v1]
    if v2 ~= nil then
        v2.Tracker:Destroy()
    end
    u101[v1] = nil
    u102[v1] = nil
    if u103 == v1 then
        if u103 == nil then
            return
        end
        v2 = bindGui()
        u103 = nil
        u105 = ""
        u107 = u107 + 1
        local v3 = u107
        local v4 = u106
        u106 = nil
        if v4 ~= nil then
            HoverHighlight.FadeOut(v4, 0.25)
        end
        if v2.Frame.Visible then
            playCanvasFade(v2, 1, v3)
        end
    end
end

function v1.DestroyOwner(a1) -- Line: 431
    -- upvalues: t (val), u101 (val), u103 (ref), bindGui (val), u105 (ref), u107 (ref), u106 (ref)
    -- upvalues: HoverHighlight (val), playCanvasFade (val), u102 (val)
    local v1, v2, v3
    t.strict(t.number)(a1)
    local v4 = a1
    for k, v in pairs(u101) do
        if v.OwnerUserId == v4 then
            v.Tracker:Destroy()
            u101[k] = nil
            if u103 == k and u103 ~= nil then
                v1 = bindGui()
                u103 = nil
                u105 = ""
                u107 = u107 + 1
                v2 = u107
                v3 = u106
                u106 = nil
                if v3 ~= nil then
                    HoverHighlight.FadeOut(v3, 0.25)
                end
                if v1.Frame.Visible then
                    playCanvasFade(v1, 1, v2)
                end
            end
        end
    end
    for k2, i in pairs(u102) do
        if i == v4 then
            u102[k2] = nil
        end
    end
end

RunService:BindToRenderStep(("PlacedEggBillboard@%*"):format((HttpService:GenerateGUID(false))), Enum.RenderPriority.Last.Value, function() -- Line: 345
    -- upvalues: u102 (val), u103 (ref), bindGui (val), u105 (ref), u107 (ref), u106 (ref), HoverHighlight (val)
    -- upvalues: playCanvasFade (val), selectNearestEntry (val), Workspace (val), ModelBounds (val)
    -- upvalues: setActiveEntry (val)
    local v1, v2, v3, zero
    if next(u102) ~= nil then
        if u103 == nil then
            return
        end
        v1 = bindGui()
        u103 = nil
        u105 = ""
        u107 = u107 + 1
        v2 = u107
        v3 = u106
        u106 = nil
        if v3 ~= nil then
            HoverHighlight.FadeOut(v3, 0.25)
        end
        if v1.Frame.Visible then
            playCanvasFade(v1, 1, v2)
        end
        return
    end
    v1 = selectNearestEntry()
    if v1 == nil then
        if u103 == nil then
            return
        end
        v2 = bindGui()
        u103 = nil
        u105 = ""
        u107 = u107 + 1
        v3 = u107
        local v4 = u106
        u106 = nil
        if v4 ~= nil then
            HoverHighlight.FadeOut(v4, 0.25)
        end
        if v2.Frame.Visible then
            playCanvasFade(v2, 1, v3)
        end
        return
    end
    v2 = bindGui()
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        local v5, v6 = CurrentCamera:WorldToViewportPoint((ModelBounds(v1.Model)).Position)
        if v6 then
            v3 = true
            zero = Vector2.new(v5.X, v5.Y)
        else
            v3 = false
            zero = Vector2.zero
        end
    else
        v3 = false
        zero = Vector2.zero
    end
    if v3 then
        setActiveEntry(v1)
        v2.Frame.Position = UDim2.fromOffset(zero.X, zero.Y)
        return
    end
    if u103 == nil then
        return
    end
    local v7 = bindGui()
    u103 = nil
    u105 = ""
    u107 = u107 + 1
    local v8 = u107
    local v9 = u106
    u106 = nil
    if v9 ~= nil then
        HoverHighlight.FadeOut(v9, 0.25)
    end
    if v7.Frame.Visible then
        playCanvasFade(v7, 1, v8)
    end
end)
return v1