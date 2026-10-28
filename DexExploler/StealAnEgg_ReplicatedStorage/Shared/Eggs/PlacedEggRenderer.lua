-- Script path: ReplicatedStorage.Shared.Eggs.PlacedEggRenderer
-- Decompile time: 54.49 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local Catalog = require(ReplicatedStorage.Shared.Modules.Mutations.Catalog)
local ScrambleMutationFlags = require(ReplicatedStorage.Shared.Flags.ScrambleMutationFlags)
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local TrainEventFlags = require(ReplicatedStorage.Shared.Flags.TrainEventFlags)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggGrowthAnimation = require(script.Parent.EggGrowthAnimation)
local EggHatchAnimation = require(script.Parent.EggHatchAnimation)
local EggMechaUpgradeAnimation = require(script.Parent.EggMechaUpgradeAnimation)
local EggPlaceAnimation = require(script.Parent.EggPlaceAnimation)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(script.Parent.EggRenderer)
local EggSkipAnimation = require(script.Parent.EggSkipAnimation)
local EggState = require(ReplicatedStorage.Client.EggState)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Log = require(ReplicatedStorage.Packages.Log)
local ModelCameraOcclusion = require(ReplicatedStorage.Client.ModelCameraOcclusion)
local MutationConsumableFeedback = require(script.Parent.MutationConsumableFeedback)
local NightEggTimeSkipAnimation = require(script.Parent.NightEggTimeSkipAnimation)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local PlacedEggBillboard = require(script.Parent.PlacedEggBillboard)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local PlacedEggReadyPulse = require(script.Parent.PlacedEggReadyPulse)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(ReplicatedStorage.Shared.Types.Plots)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local SmartProximityPrompt = require(ReplicatedStorage.Client.SmartProximityPrompt)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local u214 = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local u219 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u224 = Color3.fromRGB(255, 64, 64)
local u229 = Color3.fromRGB(255, 196, 80)
local u234 = Color3.fromRGB(80, 255, 120)
local u235 = {}
local u236 = 0
local u238 = Random.new()
local u240 = Random.new()
local u241 = nil
local u242 = false
local u243 = false
local u244 = "Boss"
local u245 = false
local u246 = 0
local u248 = Trove.new()
local Folder = Instance.new("Folder")
Folder.Name = "PlacedEggRenders"
Folder.Parent = workspace
local u255 = Log.new()
local u256 = {}
u256.LocalEggHatchStarted = Signal.new()
local GetDirectGrowthTweenRemainingSeconds = PlacedEggGrowthPresentationPolicy.GetDirectGrowthTweenRemainingSeconds
local GetStartScale = PlacedEggGrowthPresentationPolicy.GetStartScale
local GetTargetScale = PlacedEggGrowthPresentationPolicy.GetTargetScale
local GetVisualScale = PlacedEggGrowthPresentationPolicy.GetVisualScale
local IsReady = PlacedEggGrowthPresentationPolicy.IsReady
local GetRemainingGrowthSeconds = PlacedEggGrowthPresentationPolicy.GetRemainingGrowthSeconds

local function getKey(a1, a2) -- Line: 154 -- types: a1: number, a2: string
    return (("%*:%*"):format(a1, a2))
end

local function getOwnerPlayer(a1) -- Line: 158 -- upvalues: Players (val) -- types: a1: number
    return Players:GetPlayerByUserId(a1)
end

local function readOwnerPlotData(a1) -- Line: 162 -- upvalues: Players (val), PlotState (val) -- types: a1: number
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId == nil then
        return nil
    end
    return PlotState.ResolvePlot(PlayerByUserId)
end

local function isLocalOwner(a1) -- Line: 171 -- upvalues: Players (val) -- types: a1: number
    return a1 == Players.LocalPlayer.UserId
end

local function getNextReadyPulseAt(a1) -- Line: 175 -- upvalues: u238 (val) -- types: a1: number
    return a1 + u238:NextNumber(5, 10)
end

local function getNextGrowthPulseAt(a1) -- Line: 183 -- upvalues: u240 (val) -- types: a1: number
    return a1 + u240:NextNumber(27, 65)
end

local function getInitialGrowthUpdateAt(a1) -- Line: 191 -- upvalues: u236 (ref) -- types: a1: number
    local v1 = a1 + u236 * 0.2
    u236 = (u236 + 1) % 25
    return v1
end

local function getNightTimeSkipSecondsValue(a1) -- Line: 197 -- types: a1: table
    local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
    if NightTimeSkipAnimation ~= nil then
        return (NightTimeSkipAnimation:GetAppliedSecondsValue())
    end
    return nil
end

local function getNightTimeSkipSeconds(a1) -- Line: 202 -- types: a1: table
    local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
    local v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
    if v1 ~= nil then
        return v1.Value
    end
    return 0
end

local function isNightTimeSkipControllingPresentation(a1) -- Line: 207 -- types: a1: table
    local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
    local v1 = false
    if NightTimeSkipAnimation ~= nil then
        v1 = not NightTimeSkipAnimation:IsComplete()
    end
    return v1
end

local function clearNightTimeSkipAnimation(a1) -- Line: 214 -- upvalues: PlacedEggBillboard (val) -- types: a1: table
    local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
    if NightTimeSkipAnimation == nil then
        return
    end
    a1.NightTimeSkipAnimation = nil
    if a1.NightBillboardSuppressed then
        a1.NightBillboardSuppressed = false
        PlacedEggBillboard.SetNightPresentationActive(a1.OwnerUserId, a1.Uid, false)
    end
    NightTimeSkipAnimation:Destroy()
    local ScaleValue = a1.ScaleValue
    if ScaleValue ~= nil and a1.Result.Model.Parent ~= nil then
        ScaleValue.Value = a1.Result.Model:GetScale()
    end
end

local function startNightTimeSkipForState(a1, a2) -- Line: 236
    -- upvalues: Players (val), AreaEggCycle (val), EggRecords (val), Workspace (val), NightEggTimeSkipAnimation (val)
    -- upvalues: PlacedEggBillboard (val)
    local v1 = a1.OwnerUserId == Players.LocalPlayer.UserId
    if v1 and not a1.IsHatching and a1.Result.Model.Parent ~= nil and a1.NightTimeSkipAnimation == nil then
        local Placement = a1.Record.Placement
        local v2 = a2 - AreaEggCycle.NightLengthSeconds()
        if Placement ~= nil and Placement.ReadyAt == nil and not (v2 < Placement.PlacedAt) then
            if EggRecords.IsGrown(a1.Record, v2, a1.Record.GrowthSpeedMultiplier, nil, Players:GetPlayerByUserId(a1.OwnerUserId))
                or a2 <= Workspace:GetServerTimeNow() then
                return
            end
            local GrowthAnimation = a1.GrowthAnimation
            if GrowthAnimation ~= nil then
                GrowthAnimation:Cancel()
            end
            local ReadyPulse = a1.ReadyPulse
            if ReadyPulse ~= nil then
                ReadyPulse:Cancel()
            end
            local ScaleTween = a1.ScaleTween
            if ScaleTween ~= nil then
                ScaleTween:Cancel()
                a1.ScaleTween = nil
                a1.DirectGrowthTweenActive = false
            end
            v1 = NightEggTimeSkipAnimation.new(a1.Result.Model, a1.Uid, a1.Record, a1.BasePivot, a1.StartScale, a1.TargetScale, v2, a2)
            a1.NightTimeSkipAnimation = v1
            PlacedEggBillboard.SetEntry({
                OwnerUserId = a1.OwnerUserId,
                Uid = a1.Uid,
                Record = a1.Record,
                Model = a1.Result.Model,
                TimeSkipSeconds = v1:GetAppliedSecondsValue(),
            })
            a1.NightBillboardSuppressed = true
            PlacedEggBillboard.SetNightPresentationActive(a1.OwnerUserId, a1.Uid, true)
            return
        end
        return
    end
end

local function setStateScale(a1, a2, a3, a4, a5) -- Line: 323
    -- upvalues: Players (val), EggRenderer (val), TweenService (val), u214 (val)
    if not (a1.OwnerUserId == Players.LocalPlayer.UserId) then
        a1.Result.Model:ScaleTo(a2)
        EggRenderer.DisableCollisions(a1.Result.Model)
        return false
    end
    local ScaleValue = a1.ScaleValue
    if ScaleValue == nil then
        a1.Result.Model:ScaleTo(a2)
        EggRenderer.DisableCollisions(a1.Result.Model)
        return false
    end
    local ScaleTween = a1.ScaleTween
    local v1 = ScaleTween ~= nil
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
        a1.ScaleTween = nil
        a1.DirectGrowthTweenActive = false
    end
    if a4 == false then
        local v2
        if a5 == true then
            a1.DirectGrowthTweenActive = true
        end
        if 0.001 < (math.abs(ScaleValue.Value - a2)) then
            ScaleValue.Value = a2
        end
        return v1 or v2
    end
    if (math.abs(ScaleValue.Value - a2)) <= 0.001 then
        if a5 == true then
            a1.DirectGrowthTweenActive = true
        end
        return false
    end
    local u101 = TweenService:Create(ScaleValue, a3 or u214, {Value = a2})
    a1.ScaleTween = u101
    a1.DirectGrowthTweenActive = a5 == true
    u101.Completed:Once(function() -- Line: 375 -- upvalues: a1 (val), u101 (val), a5 (val)
        if a1.ScaleTween == u101 then
            a1.ScaleTween = nil
            if a5 == true then
                a1.DirectGrowthTweenActive = false
            end
        end
    end)
    u101:Play()
    return false
end

local function startDirectGrowthTween(a1, a2) -- Line: 387
    -- upvalues: setStateScale (val)
    setStateScale(a1, a1.TargetScale, TweenInfo.new(math.max(a2, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), true, true)
end

local function hasSkipGrowthCredit(a1) -- Line: 399 -- upvalues: ReplicatedStorage (val) -- types: a1: number
    local ProductCredits
    local Save = require(ReplicatedStorage.Shared.Save)
    if not Save.IsLoaded() then
        return false
    end
    local v1 = Save.Await()
    if typeof(if v1 == nil then nil else v1.ProductCredits) ~= "table" then
        return false
    end
    v1 = ProductCredits[tostring(a1)]
    local v2 = false
    if typeof(v1) == "number" then
        v2 = v1 > 0
    end
    return v2
end

local function updatePrompt(a1) -- Line: 413
    -- upvalues: u245 (ref), Players (val), u243 (ref), u242 (ref), u244 (ref), RaceRallyFlags (val)
    -- upvalues: TrainEventFlags (val), ScrambleMutationFlags (val), BossMasteryFlags (val), IsReady (val)
    -- upvalues: Products (val), GetRemainingGrowthSeconds (val), hasSkipGrowthCredit (val)
    local Prompt = a1.Prompt
    if Prompt == nil then
        return
    end
    if not u245 and not a1.MutationPresenting then
        local v1, v2
        if not (a1.OwnerUserId == Players.LocalPlayer.UserId) then
            Prompt.Enabled = u243 and not u242 and not u245 and not a1.IsHatching
            Prompt.HoldDuration = 1
            Prompt.ActionText = "Apply Mutation"
            Prompt.ObjectText = "Egg"
            return
        end
        if not u243 then
            local Value
            local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
            local v3 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
            v3 = IsReady(a1.Record, if v3 == nil then 0 else v3.Value)
            v2 = if not v3 then Products.GetEggSkipGrowthProduct(GetRemainingGrowthSeconds(a1.Record, Value)) else nil
            v1 = false
            if v2 ~= nil then
                v1 = hasSkipGrowthCredit(v2.ProductId)
            end
            local v4 = if not v3 then if not v1 then "Skip Growth!" else "Skip Growth (FREE!)" else "Hatch!"
            v1 = v3 or v2 ~= nil
            Prompt.Enabled = not u242 and not a1.IsHatching and v1
            Prompt.HoldDuration = 0
            Prompt.ActionText = v4
            Prompt.ObjectText = v4
            return
        end
        v1 = true
        local find = table.find
        local Mutations = a1.Record.Mutations or {}
        if find(Mutations, u244) == nil then
            v1 = a1.Record.BaseMutation == u244
        end
        Prompt.Enabled = not u242 and not a1.IsHatching and not v1
        Prompt.HoldDuration = 1
        Prompt.ActionText = "Apply Mutation"
        if u244 == "Enchanted" then
            v2 = "Enchanted · 100% Success Chance"
        elseif u244 == "Nitro" then
            v2 = ("Nitro · %*%% Success Chance"):format((RaceRallyFlags.NitroSuccessPercent:Get()))
        elseif u244 ~= "Spectral" then
            local v5 = if u244 ~= "Scrambled" then BossMasteryFlags.MutationConsumableSuccessPercent:Get() else ScrambleMutationFlags.SuccessPercent:Get()
            v2 = ("%* · %*%% Success Chance"):format(if u244 ~= "Scrambled" then "Fractured" else "Scrambled", v5)
        else
            v2 = ("Spectral · %*%% Success Chance"):format((TrainEventFlags.SpectralSuccessPercent:Get()))
        end
        Prompt.ObjectText = v2
        return
    end
    Prompt.Enabled = false
end

local function updateAllPrompts() -- Line: 476 -- upvalues: u235 (val), updatePrompt (val)
    for k, v in pairs(u235) do
        updatePrompt(v)
    end
end

local function notifyMutation(a1, a2, a3) -- Line: 482
    -- upvalues: BossMastery (val), Catalog (val), ButterflyCatalog (val), u234 (val), Toast (val)
    local Tint
    local MutationConsumable = BossMastery.GetShopProduct("MutationConsumable")
    local Icon = if not MutationConsumable then nil else MutationConsumable.Icon
    local v1 = if a3 == "Boss" then nil else Catalog[a3]
    if v1 and v1.IconAssetId ~= nil then
        Icon = "rbxassetid://" .. tostring(v1.IconAssetId)
    end
    if a3 ~= "Enchanted" then
        Tint = a2
    else
        Icon = ButterflyCatalog.Icons.Essence
        Tint = if not v1 then a2 else if a2 ~= u234 then a2 else v1.Tint
    end
    Toast.Show({
        Seconds = 2.5,
        SingleLine = true,
        Text = a1,
        Color = Tint,
        Image = Icon,
    })
end

local u284 = nil
local u285 = nil

local function applyMutation(a1) -- Line: 511
    -- upvalues: Players (val), u246 (ref), notifyMutation (val), u244 (ref), u245 (ref), u235 (val), updatePrompt (val)
    -- upvalues: Remotes (val), u285 (ref), u224 (val), Catalog (val), u234 (val), MutationConsumableFeedback (val)
    -- upvalues: u284 (ref), u229 (val)
    local v1 = a1.OwnerUserId == Players.LocalPlayer.UserId
    if not v1 then
        v1 = os.clock()
        if u246 <= v1 then
            u246 = v1 + 2.5
            notifyMutation("can only be used on your own eggs", Color3.fromRGB(255, 100, 100), u244)
        end
        return
    end
    if u245 then
        return
    end
    local u31 = ("%*:%*"):format(a1.OwnerUserId, a1.Uid)
    local OwnerUserId = a1.OwnerUserId
    local v2 = u244
    u245 = true
    a1.MutationPresenting = true
    for k, v in pairs(u235) do
        updatePrompt(v)
    end
    local success, err = pcall(function() -- Line: 537 -- upvalues: Remotes (upval), a1 (val)
        return Remotes.BossMastery.AskUseMutationConsumable:InvokeServer(a1.Uid)
    end)
    u245 = false
    local Success = success
    if Success then
        Success = false
        if type(err) == "table" then
            Success = err.Success and err.Mutated
        end
    end
    local Success_2 = success
    if Success_2 then
        Success_2 = false
        if type(err) == "table" then
            Success_2 = err.Success and not err.Mutated
        end
    end
    if not Success and not Success_2 then
        a1.MutationPresenting = false
        for k2, i in pairs(u235) do
            updatePrompt(i)
        end
        if u235[u31] == a1 then
            u285(OwnerUserId)
        end
    end
    if success and type(err) == "table" then
        if not err.Success then
            notifyMutation(err.Message or "The consumable could not be used.", u224, v2)
            return
        end
        local u128 = err.MutationId or v2
        local v3 = Catalog[u128]
        local Label = if not v3 then u128 else v3.Label

        local function getCurrentModel() -- Line: 580 -- upvalues: u235 (upval), u31 (val)
            local v1 = u235[u31]
            if v1 ~= nil then
                return v1.Result.Model
            end
            return nil
        end

        if not Success then
            MutationConsumableFeedback.PlayFailure({
                MutationId = u128,
                Pivot = a1.BasePivot,
                GetModel = getCurrentModel,
                OnVerdict = function() -- Line: 623 -- upvalues: notifyMutation (upval), err (val), u128 (ref), u229 (upval)
                    notifyMutation(
                        err.Message or (if u128 ~= "Scrambled" then "The mutation failed..." else "The mutation failed..."),
                        u229,
                        u128
                    )
                end,
                OnFinished = function() -- Line: 631 -- upvalues: u235 (upval), u31 (val), u285 (upval), OwnerUserId (val), updatePrompt (upval)
                    local v1 = u235[u31]
                    if v1 ~= nil then
                        v1.MutationPresenting = false
                    end
                    u285(OwnerUserId)
                    for k, v in pairs(u235) do
                        updatePrompt(v)
                    end
                end,
            })
            return
        end
        if u235[u31] == a1 then
            MutationConsumableFeedback.PlaySuccess({
                MutationId = u128,
                Pivot = a1.BasePivot,
                GetModel = getCurrentModel,
                OnReveal = function() -- Line: 599 -- upvalues: notifyMutation (upval), Label (val), u234 (upval), u128 (ref)
                    notifyMutation(("%* mutation applied!"):format(Label), u234, u128)
                end,
                OnFinished = function() -- Line: 606
                    -- upvalues: u235 (upval), u31 (val), a1 (val), u284 (upval), u285 (upval), OwnerUserId (val)
                    -- upvalues: updatePrompt (upval)
                    local v1 = u235[u31]
                    if v1 ~= nil then
                        v1.MutationPresenting = false
                    end
                    if u235[u31] == a1 then
                        u284(u31)
                    end
                    u285(OwnerUserId)
                    for k, v in pairs(u235) do
                        updatePrompt(v)
                    end
                end,
            })
            return
        end
        u285(OwnerUserId)
        notifyMutation(("%* mutation applied!"):format(Label), u234, u128)
        return
    end
    notifyMutation("Something went wrong, please try again.", u224, v2)
end

local function trackOcclusion(a1) -- Line: 643 -- upvalues: ModelCameraOcclusion (val) -- types: a1: table
    assert(not a1.OcclusionTracked, (("Placed egg %* occlusion is already tracked"):format(a1.Uid)))
    ModelCameraOcclusion.Register(a1.Result.Model, 1)
    a1.OcclusionTracked = true
end

local function untrackOcclusion(a1) -- Line: 655 -- upvalues: ModelCameraOcclusion (val) -- types: a1: table
    if not a1.OcclusionTracked then
        return
    end
    ModelCameraOcclusion.Forget(a1.Result.Model)
    a1.OcclusionTracked = false
end

local function runHatchPresentation(a1, a2) -- Line: 665
    -- upvalues: Players (val), u256 (val), EggHatchAnimation (val), EggState (val), u255 (val), u284 (ref), u285 (ref)
    if a1.OwnerUserId == Players.LocalPlayer.UserId then
        u256.LocalEggHatchStarted:Fire(a1.Uid)
    end
    local v1 = EggHatchAnimation.Play(a1.OwnerUserId, a1.Uid, a1.Record, a1.Result.Model, a2)
    local v2, v3, v4 = EggState.FinishHatch(a1.Uid)
    if v2 then
        if v1 ~= nil then
            EggHatchAnimation.FadeSoundWhenGrantedToolUnequips(
                v1,
                (assert(v4, "Successful hatch completion must return the granted asset UID"))
            )
        end
        return
    end
    ;(u255:AtWarning()):Log((("Failed to complete hatch for egg %*: %*"):format(a1.Uid, v3 or "unknown")))
    u284((("%*:%*"):format(a1.OwnerUserId, a1.Uid)))
    u285(a1.OwnerUserId)
end

local function activatePrompt(a1) -- Line: 700
    -- upvalues: IsReady (val), ModelCameraOcclusion (val), updatePrompt (val), EggState (val), u255 (val)
    -- upvalues: MutationConsumableFeedback (val), Eggs (val), EggMechaUpgradeAnimation (val), u284 (ref), u285 (ref)
    -- upvalues: u235 (val), runHatchPresentation (val), Storefront (val)
    local v1, v2
    local ReadyPulse = a1.ReadyPulse
    if ReadyPulse == nil then
        return false, "Egg is not owned by the local player"
    end
    local Record = a1.Record
    local NightTimeSkipAnimation = a1.NightTimeSkipAnimation
    local v3 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
    if IsReady(Record, if v3 == nil then 0 else v3.Value) then
        if a1.HatchLock(function() -- Line: 708
            -- upvalues: a1 (val), ModelCameraOcclusion (upval), ReadyPulse (val), updatePrompt (upval)
            -- upvalues: EggState (upval), u255 (upval), MutationConsumableFeedback (upval), Eggs (upval)
            -- upvalues: EggMechaUpgradeAnimation (upval), u284 (upval), u285 (upval), u235 (upval)
            -- upvalues: runHatchPresentation (upval)
            local Model, OwnerUserId, OwnerUserId_2, Play, Result, Uid, Uid_2, Uid_3, u80, v0, v1, v2, v3, v4, v5, v6, v7
            a1.IsHatching = true
            v0 = a1
            if v0.OcclusionTracked then
                ModelCameraOcclusion.Forget(v0.Result.Model)
                v0.OcclusionTracked = false
            end
            a1.NextReadyPulseAt = nil
            ReadyPulse:Cancel()
            updatePrompt(a1)
            v0, v1, v2 = EggState.BeginHatch(a1.Uid)
            if v0 then
                MutationConsumableFeedback.ClearAfterglow(a1.Result.Model)
                if v2 ~= Eggs.HATCH_RESULT_MECHA_UPGRADED then
                    runHatchPresentation(a1, false)
                    return
                else
                    v3 = a1
                    OwnerUserId_2 = v3.OwnerUserId
                    v4 = a1
                    Uid_3 = v4.Uid
                    u80 = ("%*:%*"):format(OwnerUserId_2, Uid_3)
                    OwnerUserId = a1.OwnerUserId
                    v3 = EggMechaUpgradeAnimation
                    Play = v3.Play
                    v5 = a1
                    Result = v5.Result
                    Model = Result.Model
                    Play(OwnerUserId, Model, function() -- Line: 734
                        -- upvalues: u284 (upval), u80 (val), u285 (upval), OwnerUserId (val), u235 (upval)
                        -- upvalues: MutationConsumableFeedback (upval), ModelCameraOcclusion (upval)
                        -- upvalues: updatePrompt (upval)
                        local ReadyPulse, v0, v1, v2, v3
                        u284(u80)
                        u285(OwnerUserId)
                        v0 = u235[u80]
                        if v0 ~= nil then
                            v0.IsHatching = true
                            MutationConsumableFeedback.ClearAfterglow(v0.Result.Model)
                            if v0.OcclusionTracked then
                                ModelCameraOcclusion.Forget(v0.Result.Model)
                                v0.OcclusionTracked = false
                            end
                            v0.NextReadyPulseAt = nil
                            ReadyPulse = v0.ReadyPulse
                            if ReadyPulse ~= nil then
                                ReadyPulse:Cancel()
                            end
                            updatePrompt(v0)
                            return v0.Result.Model
                        else
                            return nil
                        end
                    end)
                    v3 = u235[u80]
                    if v3 == nil then
                        EggState.FinishHatch(a1.Uid)
                        return
                    else
                        runHatchPresentation(v3, true)
                        return
                    end
                end
            else
                a1.IsHatching = false
                v3 = a1
                v5 = not v3.OcclusionTracked
                Uid = v3.Uid
                v6 = ("Placed egg %* occlusion is already tracked"):format(Uid)
                assert(v5, v6)
                ModelCameraOcclusion.Register(v3.Result.Model, 1)
                v3.OcclusionTracked = true
                updatePrompt(a1)
                v3 = u255:AtWarning()
                v7 = a1
                Uid_2 = v7.Uid
                v5 = ("Failed to hatch egg %*: %*"):format(Uid_2, v1 or "unknown")
                v3:Log(v5)
                return
            end
        end) then
            return true
        end
        ;(u255:AtDebug()):Log((("Ignored duplicate hatch prompt for egg %*"):format(a1.Uid)))
        return false, "Egg is already hatching"
    end
    v1, v2, v3 = EggState.BeginSkipGrowth(a1.Uid)
    if v1 and v3 then
        Storefront.Prompt(v3, true)
        return true
    end
    ;(u255:AtWarning()):Log((("Failed to request skip growth for egg %*: %*"):format(a1.Uid, v2 or "unknown")))
    return false, v2
end

function u284(a1) -- Line: 790
    -- upvalues: u235 (val), ModelCameraOcclusion (val), clearNightTimeSkipAnimation (val), PlacedEggBillboard (val)
    local v1 = u235[a1]
    if v1 == nil then
        return
    end
    if v1.OcclusionTracked then
        ModelCameraOcclusion.Forget(v1.Result.Model)
        v1.OcclusionTracked = false
    end
    u235[a1] = nil
    clearNightTimeSkipAnimation(v1)
    PlacedEggBillboard.RemoveEntry(v1.OwnerUserId, v1.Uid)
    v1.Trove:Destroy()
end

local function destroyOwnerStates(a1) -- Line: 803 -- upvalues: u235 (val), u284 (ref) -- types: a1: number
    for k, v in pairs(u235) do
        if v.OwnerUserId == a1 then
            u284(k)
        end
    end
end

local function addPlacedEggRenderState(a1, a2, a3) -- Line: 811
    -- upvalues: Players (val), PlotState (val), Trove (val), GetStartScale (val), GetTargetScale (val)
    -- upvalues: GetVisualScale (val), EggRenderer (val), Folder (val), MutationConsumableFeedback (val)
    -- upvalues: EggActionMovement (val), EggState (val), EggPlaceAnimation (val), SmartProximityPrompt (val)
    -- upvalues: EggGrowthAnimation (val), PlacedEggReadyPulse (val), Workspace (val), u236 (ref), TryLock (val)
    -- upvalues: u241 (ref), startNightTimeSkipForState (val), u235 (val), ModelCameraOcclusion (val)
    -- upvalues: PlacedEggBillboard (val), updatePrompt (val), u243 (ref), applyMutation (val), activatePrompt (val)
    -- upvalues: GetDirectGrowthTweenRemainingSeconds (val), setStateScale (val), u255 (val)
    local v1
    local Placement = a3.Placement
    if Placement == nil then
        return
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if (if PlayerByUserId ~= nil then PlotState.ResolvePlot(PlayerByUserId) else nil) == nil then
        return
    end
    local v2 = Trove.new()
    local v3 = GetStartScale(a3)
    local v4 = GetTargetScale(a3)
    local v5 = GetVisualScale(a3, v3, v4)
    local v6 = v1.CenterPoint.CFrame * Placement.LocalCFrame
    local u50 = EggRenderer.RenderVisual({
        OwnerUserId = a1,
        UID = a2,
        ModelName = ("%*_%*"):format(a1, a2),
        Record = a3,
        ScaleMultiplier = v5,
    }, Folder, false)
    v2:Add(u50.Model)
    MutationConsumableFeedback.AttachAfterglow(u50.Model, a3.Mutations, a3.BaseMutation)
    EggActionMovement.SetPivot(u50.Model, v6)
    if a1 == Players.LocalPlayer.UserId and EggState.TakePlantCue(a2) then
        EggPlaceAnimation.Play(u50.Model, v6, Folder)
    end
    local v7 = nil
    if a1 == Players.LocalPlayer.UserId then
        local NumberValue = Instance.new("NumberValue")
        NumberValue.Value = v5
        v7 = NumberValue
        v2:Add(NumberValue)
        v2:Add((NumberValue.Changed:Connect(function(a1) -- Line: 859 -- upvalues: u50 (val), EggRenderer (upval) -- types: a1: number
            u50.Model:ScaleTo(a1)
            EggRenderer.DisableCollisions(u50.Model)
        end)))
    end
    v5 = a1 == Players.LocalPlayer.UserId
    local u166 = nil
    local u178 = nil
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.MaxActivationDistance = 7
    ProximityPrompt:SetAttribute("PlacedEggPrompt", true)
    ProximityPrompt.HoldDuration = 0
    v2:Add((SmartProximityPrompt.AttachToModel(ProximityPrompt, u50.Model, {
        SurfaceOffset = 0.75,
        TrackDistance = 7,
        MaxActivationDistance = ProximityPrompt.MaxActivationDistance,
    })))
    local v8 = ProximityPrompt
    if v5 then
        u166 = EggGrowthAnimation.new(u50.Model, v6, 1)
        u178 = PlacedEggReadyPulse.new(u50.Model, v6, v4)
    end
    local u179 = {
        DirectGrowthTweenActive = false,
        NightBillboardSuppressed = false,
        IsHatching = false,
        MutationPresenting = false,
        OcclusionTracked = false,
        OwnerUserId = a1,
        Uid = a2,
        Record = a3,
        Result = u50,
        BasePivot = v6,
        StartScale = v3,
        TargetScale = v4,
        ScaleValue = v7,
        GrowthAnimation = u166,
    }
    local v9 = (Workspace:GetServerTimeNow()) + u236 * 0.2
    u236 = (u236 + 1) % 25
    u179.NextGrowthUpdateAt = v9
    u179.ReadyPulse = u178
    u179.Prompt = v8
    u179.Trove = v2
    u179.HatchLock = TryLock()
    v6 = u241
    if v6 ~= nil then
        startNightTimeSkipForState(u179, v6)
    end
    if u178 ~= nil then
        v2:Add(function() -- Line: 921 -- upvalues: u178 (ref)
            u178:Destroy()
        end)
    end
    if u166 ~= nil then
        v2:Add(function() -- Line: 926 -- upvalues: u166 (ref)
            u166:Destroy()
        end)
    end
    v2:Add(function() -- Line: 930 -- upvalues: u179 (val)
        local ScaleTween = u179.ScaleTween
        if ScaleTween ~= nil then
            ScaleTween:Cancel()
            u179.ScaleTween = nil
            u179.DirectGrowthTweenActive = false
        end
    end)
    u235[("%*:%*"):format(a1, a2)] = u179
    assert(not u179.OcclusionTracked, (("Placed egg %* occlusion is already tracked"):format(u179.Uid)))
    ModelCameraOcclusion.Register(u179.Result.Model, 1)
    u179.OcclusionTracked = true
    local SetEntry = PlacedEggBillboard.SetEntry
    local v10 = {OwnerUserId = a1, Uid = a2, Record = a3, Model = u50.Model}
    local NightTimeSkipAnimation = u179.NightTimeSkipAnimation
    v10.TimeSkipSeconds = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
    SetEntry(v10)
    updatePrompt(u179)
    if v8 ~= nil then
        v2:Add((v8.Triggered:Connect(function(a1) -- Line: 949
            -- upvalues: Players (upval), u243 (upval), applyMutation (upval), u179 (val), activatePrompt (upval)
            if a1 ~= Players.LocalPlayer then
                return
            end
            if u243 then
                applyMutation(u179)
                return
            end
            if u179.OwnerUserId == Players.LocalPlayer.UserId then
                activatePrompt(u179)
            end
        end)))
    end
    v4 = GetDirectGrowthTweenRemainingSeconds(a3, (Workspace:GetServerTimeNow()))
    if v5 and v4 > 0 then
        local NightTimeSkipAnimation_2 = u179.NightTimeSkipAnimation
        v9 = false
        if NightTimeSkipAnimation_2 ~= nil then
            v9 = not NightTimeSkipAnimation_2:IsComplete()
        end
        if not v9 then
            setStateScale(
                u179,
                u179.TargetScale,
                TweenInfo.new(math.max(v4, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                true,
                true
            )
        end
    end
    ;(u255:AtDebug()):Log((("Rendered placed egg %* for owner %*"):format(a2, a1)))
end

function u285(a1) -- Line: 973
    -- upvalues: EggState (val), Players (val), PlotState (val), u235 (val), EggRecords (val), u284 (ref), IsReady (val)
    -- upvalues: ParasiteVisual (val), MutationConsumableFeedback (val), GetStartScale (val), GetTargetScale (val)
    -- upvalues: EggActionMovement (val), clearNightTimeSkipAnimation (val), PlacedEggBillboard (val)
    -- upvalues: setStateScale (val), u219 (val), EggSkipAnimation (val), PlacedEggGrowthPresentationPolicy (val)
    -- upvalues: updatePrompt (val), addPlacedEggRenderState (val)
    local GrowthAnimation, HasParasite, NightTimeSkipAnimation, NightTimeSkipAnimation_2, NightTimeSkipAnimation_3, NightTimeSkipAnimation_4, NightTimeSkipAnimation_5, ReadyPulse, SetEntry, TargetScale_3, Value, v1, v2, v3, v4, v5, v6
    local v7 = EggState.ReadOwnerEggs(a1)
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if (if PlayerByUserId ~= nil then PlotState.ResolvePlot(PlayerByUserId) else nil) == nil then
        return
    end
    local v8 = {}
    local v9 = a1
    for k, v in pairs(v7) do
        if v.Placement ~= nil then
            v6 = ("%*:%*"):format(v9, k)
            v8[v6] = true
            v1 = u235[v6]
            if v1 == nil then
                if v1 == nil then
                    addPlacedEggRenderState(v9, k, v)
                else
                    NightTimeSkipAnimation = v1.NightTimeSkipAnimation
                    v3 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
                    v2 = IsReady(v1.Record, if v3 == nil then 0 else v3.Value)
                    v3 = IsReady(v, Value)
                    HasParasite = v1.Record.HasParasite
                    v1.Record = v
                    if v.HasParasite ~= HasParasite then
                        ParasiteVisual.Attach(v1.Result.Model, v.HasParasite)
                    end
                    MutationConsumableFeedback.AttachAfterglow(v1.Result.Model, v.Mutations, v.BaseMutation)
                    v1.StartScale = GetStartScale(v)
                    v1.TargetScale = GetTargetScale(v)
                    if v.Placement ~= nil then
                        v1.BasePivot = v5.CenterPoint.CFrame * v.Placement.LocalCFrame
                        ReadyPulse = v1.ReadyPulse
                        if ReadyPulse ~= nil then
                            ReadyPulse:SetTransform(v1.BasePivot, v1.TargetScale)
                        end
                        GrowthAnimation = v1.GrowthAnimation
                        if GrowthAnimation ~= nil then
                            GrowthAnimation:SetBasePivot(v1.BasePivot)
                        end
                        NightTimeSkipAnimation_2 = v1.NightTimeSkipAnimation
                        if NightTimeSkipAnimation_2 ~= nil then
                            NightTimeSkipAnimation_2:SetTransform(v1.BasePivot, v1.StartScale, v1.TargetScale)
                            NightTimeSkipAnimation_2:AcknowledgeRecord(v)
                            if v3 then
                                NightTimeSkipAnimation_2:CancelVisual()
                            end
                        end
                        NightTimeSkipAnimation_3 = v1.NightTimeSkipAnimation
                        v4 = false
                        if NightTimeSkipAnimation_3 ~= nil then
                            v4 = not NightTimeSkipAnimation_3:IsComplete()
                        end
                        if not v4 then
                            if ReadyPulse == nil or not ReadyPulse:IsPlaying() then
                                if GrowthAnimation == nil or not GrowthAnimation:IsPlaying() then
                                    EggActionMovement.SetPivot(v1.Result.Model, v1.BasePivot)
                                end
                            end
                        end
                    end
                    NightTimeSkipAnimation_4 = v1.NightTimeSkipAnimation
                    if NightTimeSkipAnimation_4 ~= nil and NightTimeSkipAnimation_4:IsComplete() then
                        clearNightTimeSkipAnimation(v1)
                    end
                    SetEntry = PlacedEggBillboard.SetEntry
                    v4 = {OwnerUserId = v9, Uid = k, Record = v, Model = v1.Result.Model}
                    NightTimeSkipAnimation_5 = v1.NightTimeSkipAnimation
                    v4.TimeSkipSeconds = if NightTimeSkipAnimation_5 == nil then nil else NightTimeSkipAnimation_5:GetAppliedSecondsValue()
                    SetEntry(v4)
                    if v9 == Players.LocalPlayer.UserId and not v2 and v3 and v1.NightTimeSkipAnimation == nil then
                        if EggState.ReadChosenSkipUid() ~= k then
                            v4 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v1.Result.Model)
                            TargetScale_3 = v1.TargetScale
                            if setStateScale(v1, TargetScale_3, nil, v4 == nil) then
                                PlacedEggGrowthPresentationPolicy.LogSkipped(
                                    v1.Uid,
                                    "natural completion",
                                    (assert(v4, "Skipped natural completion requires a presentation reason"))
                                )
                            end
                        else
                            setStateScale(v1, v1.TargetScale, u219)
                            task.spawn(EggSkipAnimation.Play, v1.Result.Model)
                        end
                    end
                    updatePrompt(v1)
                end
            elseif not v1.IsHatching and not v1.MutationPresenting then
                if (EggRecords.EggModelName(v.AssetCategory, v.Mutations, v.BaseMutation)) ~= EggRecords.EggModelName(v1.Record.AssetCategory, v1.Record.Mutations, v1.Record.BaseMutation) then
                    u284(v6)
                    v1 = nil
                end
                if v1 == nil then
                    addPlacedEggRenderState(v9, k, v)
                else
                    NightTimeSkipAnimation = v1.NightTimeSkipAnimation
                    v3 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
                    v2 = IsReady(v1.Record, if v3 == nil then 0 else v3.Value)
                    v3 = IsReady(v, Value)
                    HasParasite = v1.Record.HasParasite
                    v1.Record = v
                    if v.HasParasite ~= HasParasite then
                        ParasiteVisual.Attach(v1.Result.Model, v.HasParasite)
                    end
                    MutationConsumableFeedback.AttachAfterglow(v1.Result.Model, v.Mutations, v.BaseMutation)
                    v1.StartScale = GetStartScale(v)
                    v1.TargetScale = GetTargetScale(v)
                    if v.Placement ~= nil then
                        v1.BasePivot = v5.CenterPoint.CFrame * v.Placement.LocalCFrame
                        ReadyPulse = v1.ReadyPulse
                        if ReadyPulse ~= nil then
                            ReadyPulse:SetTransform(v1.BasePivot, v1.TargetScale)
                        end
                        GrowthAnimation = v1.GrowthAnimation
                        if GrowthAnimation ~= nil then
                            GrowthAnimation:SetBasePivot(v1.BasePivot)
                        end
                        NightTimeSkipAnimation_2 = v1.NightTimeSkipAnimation
                        if NightTimeSkipAnimation_2 ~= nil then
                            NightTimeSkipAnimation_2:SetTransform(v1.BasePivot, v1.StartScale, v1.TargetScale)
                            NightTimeSkipAnimation_2:AcknowledgeRecord(v)
                            if v3 then
                                NightTimeSkipAnimation_2:CancelVisual()
                            end
                        end
                        NightTimeSkipAnimation_3 = v1.NightTimeSkipAnimation
                        v4 = false
                        if NightTimeSkipAnimation_3 ~= nil then
                            v4 = not NightTimeSkipAnimation_3:IsComplete()
                        end
                        if not v4 then
                            if ReadyPulse == nil or not ReadyPulse:IsPlaying() then
                                if GrowthAnimation == nil or not GrowthAnimation:IsPlaying() then
                                    EggActionMovement.SetPivot(v1.Result.Model, v1.BasePivot)
                                end
                            end
                        end
                    end
                    NightTimeSkipAnimation_4 = v1.NightTimeSkipAnimation
                    if NightTimeSkipAnimation_4 ~= nil and NightTimeSkipAnimation_4:IsComplete() then
                        clearNightTimeSkipAnimation(v1)
                    end
                    SetEntry = PlacedEggBillboard.SetEntry
                    v4 = {OwnerUserId = v9, Uid = k, Record = v, Model = v1.Result.Model}
                    NightTimeSkipAnimation_5 = v1.NightTimeSkipAnimation
                    v4.TimeSkipSeconds = if NightTimeSkipAnimation_5 == nil then nil else NightTimeSkipAnimation_5:GetAppliedSecondsValue()
                    SetEntry(v4)
                    if v9 == Players.LocalPlayer.UserId and not v2 and v3 and v1.NightTimeSkipAnimation == nil then
                        if EggState.ReadChosenSkipUid() ~= k then
                            v4 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v1.Result.Model)
                            TargetScale_3 = v1.TargetScale
                            if setStateScale(v1, TargetScale_3, nil, v4 == nil) then
                                PlacedEggGrowthPresentationPolicy.LogSkipped(
                                    v1.Uid,
                                    "natural completion",
                                    (assert(v4, "Skipped natural completion requires a presentation reason"))
                                )
                            end
                        else
                            setStateScale(v1, v1.TargetScale, u219)
                            task.spawn(EggSkipAnimation.Play, v1.Result.Model)
                        end
                    end
                    updatePrompt(v1)
                end
            end
        end
    end
    for k2, i in pairs(u235) do
        if i.OwnerUserId == v9 and not v8[k2] then
            u284(k2)
        end
    end
end

local function refreshAll() -- Line: 1132 -- upvalues: EggState (val), u285 (ref), u235 (val), u284 (ref)
    local v1 = {}
    for i, v in ipairs((EggState.ReadOwnedEggs())) do
        v1[v.OwnerUserId] = true
        u285(v.OwnerUserId)
    end
    for k, i2 in pairs(u235) do
        if not v1[i2.OwnerUserId] then
            u284(k)
        end
    end
end

local function updateReadyPulses(a1) -- Line: 1147
    -- upvalues: u235 (val), IsReady (val), PlacedEggGrowthPresentationPolicy (val), u238 (val)
    local NextReadyPulseAt, NightTimeSkipAnimation, NightTimeSkipAnimation_2, ReadyPulse, Record, v1, v2, v3
    local v4 = a1
    for k, v in pairs(u235) do
        ReadyPulse = v.ReadyPulse
        if ReadyPulse ~= nil then
            if v.IsHatching or v.Result.Model.Parent == nil then
                v.NextReadyPulseAt = nil
                ReadyPulse:Cancel()
            else
                v2 = IsReady
                Record = v.Record
                NightTimeSkipAnimation = v.NightTimeSkipAnimation
                v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
                if not v2(Record, if v1 == nil then 0 else v1.Value) then
                    v.NextReadyPulseAt = nil
                    ReadyPulse:Cancel()
                else
                    NightTimeSkipAnimation_2 = v.NightTimeSkipAnimation
                    v2 = false
                    if NightTimeSkipAnimation_2 ~= nil then
                        v2 = not NightTimeSkipAnimation_2:IsComplete()
                    end
                    if not v2 then
                        NextReadyPulseAt = v.NextReadyPulseAt
                        if ReadyPulse:IsPlaying() then
                            v3 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)
                            if v3 ~= nil then
                                ReadyPulse:Cancel()
                                v.NextReadyPulseAt = v4 + u238:NextNumber(5, 10)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "ready pulse cancellation", v3)
                            elseif NextReadyPulseAt == nil then
                                v.NextReadyPulseAt = v4 + u238:NextNumber(5, 10)
                            end
                        elseif NextReadyPulseAt == nil then
                            v.NextReadyPulseAt = v4 + u238:NextNumber(5, 10)
                        elseif NextReadyPulseAt <= v4 then
                            v3 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)
                            if v3 ~= nil then
                                v.NextReadyPulseAt = v4 + u238:NextNumber(5, 10)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "ready pulse", v3)
                            elseif ReadyPulse:Play() then
                                v.NextReadyPulseAt = nil
                            end
                        end
                    else
                        v.NextReadyPulseAt = nil
                        ReadyPulse:Cancel()
                    end
                end
            end
        end
    end
end

local function updateGrowthPulses(a1) -- Line: 1202
    -- upvalues: u235 (val), GetDirectGrowthTweenRemainingSeconds (val), IsReady (val)
    -- upvalues: PlacedEggGrowthPresentationPolicy (val), u240 (val)
    local GrowthAnimation, NextGrowthPulseAt, NightTimeSkipAnimation, NightTimeSkipAnimation_2, Record, v1, v2, v3
    local v4 = a1
    for k, v in pairs(u235) do
        GrowthAnimation = v.GrowthAnimation
        if GrowthAnimation ~= nil then
            v2 = GetDirectGrowthTweenRemainingSeconds(v.Record, v4)
            if v.IsHatching or v.Result.Model.Parent == nil then
                v.NextGrowthPulseAt = nil
                GrowthAnimation:Cancel()
            else
                v3 = IsReady
                Record = v.Record
                NightTimeSkipAnimation = v.NightTimeSkipAnimation
                v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
                if v3(Record, if v1 == nil then 0 else v1.Value) or v2 > 0 then
                    v.NextGrowthPulseAt = nil
                    GrowthAnimation:Cancel()
                else
                    NightTimeSkipAnimation_2 = v.NightTimeSkipAnimation
                    v3 = false
                    if NightTimeSkipAnimation_2 ~= nil then
                        v3 = not NightTimeSkipAnimation_2:IsComplete()
                    end
                    if not v3 then
                        NextGrowthPulseAt = v.NextGrowthPulseAt
                        if GrowthAnimation:IsPlaying() then
                            v3 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)
                            if v3 ~= nil then
                                GrowthAnimation:Cancel()
                                v.NextGrowthPulseAt = v4 + u240:NextNumber(27, 65)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "random growth jump cancellation", v3)
                            end
                        elseif NextGrowthPulseAt == nil then
                            v.NextGrowthPulseAt = v4 + u240:NextNumber(27, 65)
                        elseif NextGrowthPulseAt <= v4 then
                            v.NextGrowthPulseAt = v4 + u240:NextNumber(27, 65)
                            v3 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)
                            if v3 ~= nil then
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "random growth jump", v3)
                            else
                                GrowthAnimation:Play()
                            end
                        end
                    else
                        v.NextGrowthPulseAt = nil
                        GrowthAnimation:Cancel()
                    end
                end
            end
        end
    end
end

local function updateGrowth(a1) -- Line: 1256
    -- upvalues: u235 (val), GetDirectGrowthTweenRemainingSeconds (val), Players (val), updatePrompt (val)
    -- upvalues: setStateScale (val), GetVisualScale (val), PlacedEggGrowthPresentationPolicy (val)
    local NextGrowthUpdateAt, NightTimeSkipAnimation, v1, v2, v3, v4, v5
    local v6 = a1
    for k, v in pairs(u235) do
        if not v.IsHatching and not v.MutationPresenting and v.Result.Model.Parent ~= nil then
            NightTimeSkipAnimation = v.NightTimeSkipAnimation
            v2 = false
            if NightTimeSkipAnimation ~= nil then
                v2 = not NightTimeSkipAnimation:IsComplete()
            end
            if not v2 then
                v2 = GetDirectGrowthTweenRemainingSeconds(v.Record, v6)
                v3 = v.OwnerUserId == Players.LocalPlayer.UserId
                if not v3 or not (v2 > 0) then
                    NextGrowthUpdateAt = v.NextGrowthUpdateAt
                    if not (v6 < NextGrowthUpdateAt) then
                        v5 = (v6 - NextGrowthUpdateAt) / 5
                        v.NextGrowthUpdateAt = NextGrowthUpdateAt + (math.floor(v5) + 1) * 5
                        updatePrompt(v)
                        v3 = GetVisualScale(v.Record, v.StartScale, v.TargetScale)
                        v2 = PlacedEggGrowthPresentationPolicy.GetNaturalGrowthSkipReason(v.Result.Model, v3)
                        v4 = setStateScale
                        v1 = v2 == nil
                        if v4(v, v3, nil, v1) then
                            v4 = assert(v2, "Skipped natural growth requires a presentation reason")
                            PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "natural growth", v4)
                        end
                    end
                elseif not v.DirectGrowthTweenActive then
                    updatePrompt(v)
                    v3 = TweenInfo.new(math.max(v2, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                    setStateScale(v, v.TargetScale, v3, true, true)
                end
            end
        end
    end
end

local function updateNightTimeSkips() -- Line: 1309
    -- upvalues: u235 (val), clearNightTimeSkipAnimation (val), updatePrompt (val), PlacedEggBillboard (val)
    local NightTimeSkipAnimation
    for k, v in pairs(u235) do
        NightTimeSkipAnimation = v.NightTimeSkipAnimation
        if NightTimeSkipAnimation ~= nil then
            if v.IsHatching then
                clearNightTimeSkipAnimation(v)
            elseif v.Result.Model.Parent ~= nil then
                updatePrompt(v)
                if v.NightBillboardSuppressed and NightTimeSkipAnimation:IsBillboardFadeFinished() then
                    v.NightBillboardSuppressed = false
                    PlacedEggBillboard.SetNightPresentationActive(v.OwnerUserId, v.Uid, false)
                end
                if NightTimeSkipAnimation:IsComplete() then
                    clearNightTimeSkipAnimation(v)
                    PlacedEggBillboard.SetEntry({
                        OwnerUserId = v.OwnerUserId,
                        Uid = v.Uid,
                        Record = v.Record,
                        Model = v.Result.Model,
                    })
                end
            else
                clearNightTimeSkipAnimation(v)
            end
        end
    end
end

function u256.GetRenderFolder() -- Line: 1357 -- upvalues: Folder (val)
    return Folder
end

function u256.Refresh() -- Line: 1361 -- upvalues: refreshAll (val)
    refreshAll()
end

function u256.SetPromptsSuppressed(a1) -- Line: 1365
    -- upvalues: t (val), u242 (ref), u235 (val), updatePrompt (val)
    t.strict(t.boolean)(a1)
    u242 = a1
    for k, v in pairs(u235) do
        updatePrompt(v)
    end
end

function u256.ActivateLocalEgg(a1) -- Line: 1374
    -- upvalues: t (val), u235 (val), Players (val), activatePrompt (val)
    t.strict(t.string)(a1)
    local v1 = u235[("%*:%*"):format(Players.LocalPlayer.UserId, a1)]
    if v1 == nil then
        return false, "Egg is not rendered"
    end
    return activatePrompt(v1)
end

function u256.RequestSkipGrowthForLocalEgg(a1) -- Line: 1385
    -- upvalues: t (val), u235 (val), Players (val), IsReady (val), activatePrompt (val)
    t.strict(t.string)(a1)
    local v1 = u235[("%*:%*"):format(Players.LocalPlayer.UserId, a1)]
    if v1 == nil then
        return false, "Egg is not rendered"
    end
    local Record = v1.Record
    local NightTimeSkipAnimation = v1.NightTimeSkipAnimation
    local v2 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
    if IsReady(Record, if v2 == nil then 0 else v2.Value) then
        return false, "Egg is already ready"
    end
    return activatePrompt(v1)
end

function u256.AppendRaycastTargets(a1, a2) -- Line: 1401
    -- upvalues: t (val), u235 (val)
    t.strict(t.number)(a2)
    for k, v in pairs(u235) do
        if v.OwnerUserId == a2 and v.Result.Model.Parent ~= nil then
            table.insert(a1, v.Result.Model)
        end
    end
end

function u256.DestroyOwner(a1) -- Line: 1417
    -- upvalues: t (val), destroyOwnerStates (val), PlacedEggBillboard (val)
    t.strict(t.number)(a1)
    destroyOwnerStates(a1)
    PlacedEggBillboard.DestroyOwner(a1)
end

function u256.SetAllHidden(a1) -- Line: 1424 -- upvalues: t (val), Folder (val), u256 (val) -- types: a1: boolean
    t.strict(t.boolean)(a1)
    Folder.Parent = if not a1 then workspace else nil
    u256.SetPromptsSuppressed(a1)
end

local function refreshMutationConsumableEquipped(a1) -- Line: 1430
    -- upvalues: u243 (ref), u244 (ref), u235 (val), updatePrompt (val)
    local v1
    local v2 = false
    local v3 = "Boss"
    for i, j in a1:GetChildren() do
        if j:IsA("Tool") and j:GetAttribute("ItemType") == "MutationConsumable" then
            v1 = j:GetAttribute("MutationId") or "Boss"
            if v1 ~= "Boss" and v1 ~= "Scrambled" and v1 ~= "Enchanted" and v1 ~= "Nitro" and v1 ~= "Spectral" then
                continue
            end
            v2 = true
            v3 = v1
            break
        end
    end
    if u243 == v2 and u244 == v3 then
        return
    end
    u243 = v2
    u244 = v3
    for k, v in pairs(u235) do
        updatePrompt(v)
    end
end

local function bindCharacter(a1) -- Line: 1453
    -- upvalues: u248 (val), refreshMutationConsumableEquipped (val)
    u248:Clean()
    u248:Connect(a1.ChildAdded, function() -- Line: 1455 -- upvalues: refreshMutationConsumableEquipped (upval), a1 (val)
        refreshMutationConsumableEquipped(a1)
    end)
    u248:Connect(a1.ChildRemoved, function() -- Line: 1458 -- upvalues: refreshMutationConsumableEquipped (upval), a1 (val)
        refreshMutationConsumableEquipped(a1)
    end)
    refreshMutationConsumableEquipped(a1)
end

EggState.SnapshotRefreshed:Connect(refreshAll)
EggState.OwnerRefreshed:Connect(u285)
EggState.OwnerCleared:Connect(u256.DestroyOwner)
EggState.ResetCountdown:Connect(function(a1) -- Line: 314 -- upvalues: u241 (ref), u235 (val), startNightTimeSkipForState (val)
    u241 = a1.DayStartsAt
    for k, v in pairs(u235) do
        startNightTimeSkipForState(v, a1.DayStartsAt)
    end
end)
PlotState.PlotChanged:Connect(refreshAll)
RunService.Heartbeat:Connect(function() -- Line: 1345
    -- upvalues: Workspace (val), updateNightTimeSkips (val), updateGrowthPulses (val), updateReadyPulses (val)
    -- upvalues: updateGrowth (val)
    local ServerTimeNow = Workspace:GetServerTimeNow()
    updateNightTimeSkips()
    updateGrowthPulses(ServerTimeNow)
    updateReadyPulses(ServerTimeNow)
    updateGrowth(ServerTimeNow)
end)
Players.LocalPlayer.CharacterAdded:Connect(bindCharacter)
if Players.LocalPlayer.Character ~= nil then
    bindCharacter(Players.LocalPlayer.Character)
end
ScrambleMutationFlags.SuccessPercent.Changed:Connect(updateAllPrompts)
RaceRallyFlags.NitroSuccessPercent.Changed:Connect(updateAllPrompts)
TrainEventFlags.SpectralSuccessPercent.Changed:Connect(updateAllPrompts)
BossMasteryFlags.MutationConsumableSuccessPercent.Changed:Connect(updateAllPrompts)
task.defer(function() -- Line: 1484
    -- upvalues: refreshAll (val), Workspace (val), AreaEggCycle (val), u241 (ref), u235 (val)
    -- upvalues: startNightTimeSkipForState (val)
    refreshAll()
    local ServerTimeNow = Workspace:GetServerTimeNow()
    if AreaEggCycle.IsNightPhase(ServerTimeNow) then
        local v1 = {DayStartsAt = AreaEggCycle.NextResetTime(ServerTimeNow)}
        u241 = v1.DayStartsAt
        for k, v in pairs(u235) do
            startNightTimeSkipForState(v, v1.DayStartsAt)
        end
    end
end)
return u256