-- Script path: ReplicatedStorage.Shared.Eggs.NightEggTimeSkipAnimation
-- Decompile time: 17.27 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local u41 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Assets = require(ReplicatedStorage.Data.Assets)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local VisualTransform = require(ReplicatedStorage.Shared.Utils.VisualTransform)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u91 = {}
u91.__index = u91
u91.__class = "NightEggTimeSkipAnimation"
local u97 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u102 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u107 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local NightEggTimeSkip = ReplicatedStorage.Assets.Billboards.NightEggTimeSkip
assert(NightEggTimeSkip:IsA("BillboardGui"), "ReplicatedStorage.Assets.Billboards.NightEggTimeSkip must be a BillboardGui")

function u91.new(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 117
    -- upvalues: t (val), Eggs (val), u41 (val), Assets (val), AreaEggCycle (val), EggRecords (val), u91 (val)
    -- upvalues: VisualTransform (val), Trove (val)
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.string)(a2)
    assert(Eggs.SchemaValidation.RuntimeEggRecord(a3), "Invalid runtime egg record")
    t.strict(t.CFrame)(a4)
    t.strict(u41)(a5)
    t.strict(u41)(a6)
    t.strict(u41)(a7)
    t.strict(u41)(a8)
    local v1 = false
    if a5 > 0 then
        v1 = a6 > 0
    end
    assert(v1, "Egg time skip scales must be positive")
    assert(a7 < a8, "Egg time skip day start must follow night start")
    assert(a3.Placement, "Night egg time skip requires a placed egg")
    local v2 = Assets.Directory[a3.AssetCategory]
    local v3 = ("Missing asset config for category %*"):format(a3.AssetCategory)
    assert(v2 ~= nil, v3)
    local GrowthSpeedMultiplier = a3.GrowthSpeedMultiplier
    local v4 = AreaEggCycle.PeriodIndexAt(a8)
    v3 = EggRecords.CommittedNightCredit(a3, v4)
    local v5 = EggRecords.GrowthSecondsRemaining(a3, a7, GrowthSpeedMultiplier) + v3
    local v6 = math.min(AreaEggCycle.NightGrowthSkipSeconds, v5)
    local v7 = setmetatable({}, u91)
    v7._model = a1
    v7._uid = a2
    v7._record = a3
    v7._basePivot = a4
    v7._startScale = a5
    v7._targetScale = a6
    v7._growthSpeedMultiplier = GrowthSpeedMultiplier
    v7._nightStartsAt = a7
    v7._dayStartsAt = a8
    v7._nightPeriodIndex = v4
    v7._nightTargetCreditSeconds = v6
    v7._committedNightCreditSeconds = v3
    v7._skipSeconds = math.max(0, v6 - v3)
    v7._remainingAtNightfall = v5
    v7._nightScaleStart = a5
    v7._nightScaleEnd = a6
    v7._snappedGrowthScale = nil
    assert(0 < v7._skipSeconds, "Night egg time skip requires remaining growth time")
    v7._appliedSeconds = Instance.new("NumberValue")
    v7._billboardFader = VisualTransform.Fader()
    v7._lifecycleTrove = Trove.new()
    v7._visualTrove = Trove.new()
    v7._animation = nil
    v7._visualFinishing = false
    v7._visualFinished = false
    v7._billboardFadeFinished = false
    v7._pendingCommit = true
    v7._destroyed = false
    v7._lastTimerSecond = -1
    v7._lastShakeElapsed = 0
    v7._lastShakeAlpha = 0
    v7._lastShakePitch = 0
    v7._lastShakeRoll = 0
    v7._billboard = nil
    v7._timerLabel = nil
    v7._textScale = nil
    v7._originalTextColor = nil
    v7._rarityGradient = if v2.Egg.HideRarity then nil else if a3.PurchaseId == nil then v2.Rarity.RarityGradient else nil
    v7:_refreshNightScaleRange()
    v7._lifecycleTrove:Add(v7._appliedSeconds)
    v7:_init()
    return v7
end

local function stepPresentation(a1) -- Line: 204 -- upvalues: RunService (val) -- types: a1: function
    local u1 = 0
    local u2 = nil
    u2 = (RunService.PreRender:Connect(function(a1_2) -- Line: 207 -- upvalues: u1 (ref), a1 (val), u2 (ref) -- types: a1_2: number
        u1 = u1 + a1_2
        if a1(u1) then
            u2:Disconnect()
        end
    end))
    return u2
end

local function easeOutQuad(a1) -- Line: 216 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end

function u91:_getAppliedSecondsAt(a2) -- Line: 220 -- upvalues: EggRecords (val) -- types: a2: number
    return EggRecords.NightCreditAt(self._record, a2, self._growthSpeedMultiplier, self._nightStartsAt, self._nightPeriodIndex)
end

function u91:_getGrowthScaleAt(a2) -- Line: 233 -- upvalues: EggRecords (val) -- types: a2: number
    return (math.lerp(
        self._startScale,
        self._targetScale,
        (EggRecords.GrowthAlpha(self._record, a2, self._growthSpeedMultiplier, self:_getAppliedSecondsAt(a2)))
    ))
end

function u91:_refreshNightScaleRange() -- Line: 246
    local v1 = self:_getGrowthScaleAt(self._nightStartsAt)
    local v2 = self:_getGrowthScaleAt(self._dayStartsAt)
    local v3 = true
    if not (0.001 < (math.abs(self._nightScaleStart - v1))) then
        v3 = 0.001 < (math.abs(self._nightScaleEnd - v2))
    end
    self._nightScaleStart = v1
    self._nightScaleEnd = v2
    if v3 then
        self._snappedGrowthScale = nil
    end
end

function u91:_createPresentation() -- Line: 258
    -- upvalues: t (val), NightEggTimeSkip (val), SwapGradient (val), Elapsed (val), AreaEggCycle (val)
    local PrimaryPart = self._model.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local v1 = math.min(5, (math.max(
        0.1,
        (PrimaryPart.Size.X / 6.388999938964844 * (PrimaryPart.Size.Y / 7.507999897003174) * (PrimaryPart.Size.Z / 6.367000102996826)) ^ 0.3333333333333333 * 0.9
    )))
    local v2 = Instance.new("Attachment")
    v2.Name = "NightEggTimeSkipAttachment"
    v2.Parent = PrimaryPart
    self._visualTrove:Add(v2)
    local u195 = NightEggTimeSkip:Clone()
    local Main = u195.Main
    assert(Main:IsA("Frame"), "NightEggTimeSkip.Main must be a Frame")
    local v3 = nil
    local v4 = self
    for i, j in Main:GetChildren() do
        if j:IsA("Frame") then
            assert(v3 == nil, "NightEggTimeSkip.Main must contain exactly one content Frame")
            v3 = j
        end
    end
    local v5 = assert(v3, "NightEggTimeSkip.Main must contain a content Frame")
    local Timer = v5.Timer
    assert(Timer:IsA("Frame"), "NightEggTimeSkip.Main.Frame.Timer must be a Frame")
    local Timer_2 = Timer.Timer
    assert(Timer_2:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.Timer.Timer must be a TextLabel")
    local Multiplier = Timer.Multiplier
    assert(Multiplier:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.Timer.Multiplier must be a TextLabel")
    local DisplayName = v5.DisplayName
    assert(DisplayName:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.DisplayName must be a TextLabel")
    DisplayName.Text = "Egg"
    SwapGradient(DisplayName, v4._rarityGradient)
    local Size_2 = u195.Size
    u195.Size = UDim2.new(Size_2.X.Scale * v1, Size_2.X.Offset * v1, Size_2.Y.Scale * v1, Size_2.Y.Offset * v1)
    u195.StudsOffsetWorldSpace = Vector3.new(0, -2, 0)
    u195.Adornee = v2
    u195.Parent = v2
    v4._billboard = u195
    v4._timerLabel = Timer_2
    v4._originalTextColor = Timer_2.TextColor3
    v4._visualTrove:Add(u195)
    v3 = Instance.new("UIScale")
    v3.Name = "NightEggTimeSkipScale"
    v3.Scale = 1
    v3.Parent = Timer_2
    v4._textScale = v3
    local _billboardFader = v4._billboardFader
    v4._visualTrove:Add(function() -- Line: 328 -- upvalues: _billboardFader (val), u195 (val)
        _billboardFader:Hide(u195, 0)
    end)
    _billboardFader:Hide(u195, 1)
    v5 = math.max(0, (math.floor(v4._remainingAtNightfall - v4._committedNightCreditSeconds + 0.5)))
    Timer_2.Text = if v5 ~= 0 then Elapsed(v5) else "READY!"
    Multiplier.Text = ("(x%*)"):format((math.round((AreaEggCycle.NightGrowthRate()) * 10)) / 10)
end

function u91:_setAppliedSeconds(a2) -- Line: 338 -- upvalues: Elapsed (val) -- types: a2: number
    local v1 = math.clamp(a2, 0, self._skipSeconds)
    self._appliedSeconds.Value = v1
    local v2 = math.max(0, (math.floor(self._remainingAtNightfall - self._committedNightCreditSeconds - v1 + 0.5)))
    if v2 == self._lastTimerSecond then
        return
    end
    self._lastTimerSecond = v2
    local _timerLabel = self._timerLabel
    if _timerLabel ~= nil then
        _timerLabel.Text = if v2 ~= 0 then Elapsed(v2) else "READY!"
    end
end

function u91:_applyShake(a2, a3) -- Line: 363 -- upvalues: EggActionMovement (val) -- types: a2: number, a3: number
    local v1 = math.sin(a2 * 3.141592653589793 * 2 * 1.75) * 0.039269908169872414 * a3
    local v2 = math.cos(a2 * 3.141592653589793 * 2 * 2.25) * 0.05672320068981571 * a3
    self._lastShakeElapsed = a2
    self._lastShakeAlpha = a3
    self._lastShakePitch = v1
    self._lastShakeRoll = v2
    EggActionMovement.SetPivot(self._model, self._basePivot * CFrame.Angles(v1, 0, v2))
end

function u91:_updateModel(a2) -- Line: 381
    -- upvalues: PlacedEggGrowthPresentationPolicy (val), TweenService (val)
    local _model = self._model
    self:_setAppliedSeconds((self:_getAppliedSecondsAt(a2)))
    local v1 = PlacedEggGrowthPresentationPolicy.GetGrowthScaleDeltaSkipReason(self._nightScaleStart, self._nightScaleEnd)
    if v1 == nil then
        self._snappedGrowthScale = nil
        _model:ScaleTo((self:_getGrowthScaleAt(a2)))
    elseif self._snappedGrowthScale ~= self._nightScaleEnd then
        _model:ScaleTo(self._nightScaleEnd)
        self._snappedGrowthScale = self._nightScaleEnd
        PlacedEggGrowthPresentationPolicy.LogSkipped(self._uid, "night growth scale channel", v1)
    end
    v1 = math.max(0, a2 - self._nightStartsAt)
    self:_applyShake(v1, (TweenService:GetValue(math.clamp(v1 / 5, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
    local _billboard = self._billboard
    if _billboard == nil then
        self._billboardFadeFinished = true
        return
    end
    v1 = TweenService:GetValue(math.clamp(v1 / 1, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    _billboard.StudsOffsetWorldSpace = Vector3.new(0, -2, 0):Lerp(Vector3.new(0, 0, 0), v1)
    self._billboardFader:Hide(_billboard, 1 - v1)
end

function u91:_fadeVisuals() -- Line: 421 -- upvalues: RunService (val), TweenService (val)
    local Value, v1, v2
    local _billboard = self._billboard
    if _billboard == nil then
        self._billboardFadeFinished = true
        return
    end
    local v3 = 0
    local v4 = self
    while v3 < 5 do
        v1 = RunService.PreRender:Wait()
        if v4._destroyed then
            break
        end
        v3 = math.min(v3 + v1, 5)
        v1 = math.clamp(v3 / 1, 0, 1)
        Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v2 = TweenService:GetValue(v3 / 5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        self._billboardFader:Hide(_billboard, Value)
        if v1 >= 1 then
            v4._billboardFadeFinished = true
        end
        v4:_applyShake(self._lastShakeElapsed + v3, self._lastShakeAlpha * (1 - v2))
    end
end

function u91:_playTextFinish() -- Line: 448 -- upvalues: TweenService (val), u97 (val), u107 (val), u102 (val)
    local _timerLabel = self._timerLabel
    local _textScale = self._textScale
    local _originalTextColor = self._originalTextColor
    if _timerLabel ~= nil and _textScale ~= nil and _originalTextColor ~= nil then
        local v1 = TweenService:Create(_textScale, u97, {Scale = 1.5})
        local v2 = TweenService:Create(_timerLabel, u107, {TextColor3 = Color3.new(1, 1, 1)})
        self._visualTrove:Add(v1)
        self._visualTrove:Add(v2)
        v1:Play()
        v2:Play()
        v1.Completed:Wait()
        if self._destroyed then
            return
        end
        v2 = TweenService:Create(_textScale, u102, {Scale = 1})
        v1 = TweenService:Create(_timerLabel, u107, {TextColor3 = _originalTextColor})
        self._visualTrove:Add(v2)
        self._visualTrove:Add(v1)
        v2:Play()
        v1:Play()
        v2.Completed:Wait()
        if not self._destroyed then
            _timerLabel.TextColor3 = _originalTextColor
        end
        return
    end
end

function u91._finishVisuals(a1, a2) -- Line: 481
    -- upvalues: ServerClock (val), RunService (val), EggActionMovement (val)
    if not a1._visualFinishing and not a1._visualFinished and not a1._destroyed then
        a1._visualFinishing = true
        local _animation = a1._animation
        if _animation ~= nil then
            _animation:Disconnect()
            a1._animation = nil
        end
        a1:_setAppliedSeconds(if not a2 then a1:_getAppliedSecondsAt((ServerClock.Now())) else a1._skipSeconds)
        if a2 then
            local _lastShakeElapsed = a1._lastShakeElapsed
            local _lastShakeAlpha = a1._lastShakeAlpha

            local function u28(a1_2) -- Line: 503
                -- upvalues: a1 (val), _lastShakeElapsed (val), _lastShakeAlpha (val)
                if a1._destroyed then
                    return true
                end
                a1:_applyShake(_lastShakeElapsed + a1_2, _lastShakeAlpha)
                return nil
            end

            local u29 = 0
            local u30 = nil
            u30 = RunService.PreRender:Connect(function(a1) -- Line: 207 -- upvalues: u29 (ref), u28 (val), u30 (ref) -- types: a1: number
                u29 = u29 + a1
                if u28(u29) then
                    u30:Disconnect()
                end
            end)
            local v1 = u30
            a1._animation = v1
            a1:_playTextFinish()
            v1:Disconnect()
            if a1._animation == v1 then
                a1._animation = nil
            end
        end
        if not a1._destroyed then
            a1:_fadeVisuals()
        end
        if a1._destroyed then
            return
        end
        a1._lastShakeAlpha = 0
        a1._lastShakePitch = 0
        a1._lastShakeRoll = 0
        EggActionMovement.SetPivot(a1._model, a1._basePivot)
        a1._visualTrove:Clean()
        a1._billboard = nil
        a1._timerLabel = nil
        a1._textScale = nil
        a1._visualFinishing = false
        a1._visualFinished = true
        return
    end
end

function u91:_start() -- Line: 536 -- upvalues: ServerClock (val), EggRecords (val), RunService (val)
    self:_createPresentation()

    local function u4(a1) -- Line: 538
        -- upvalues: self (val), ServerClock (upval), EggRecords (upval)
        if not self._destroyed and self._model.Parent ~= nil then
            local v1 = ServerClock.Now()
            self:_updateModel(v1)
            if (EggRecords.GrowthSecondsRemaining(self._record, v1, self._growthSpeedMultiplier, self._appliedSeconds.Value)) <= 0
                and v1 < self._dayStartsAt then
                task.spawn(self._finishVisuals, self, false)
                return true
            end
            if not (self._dayStartsAt <= v1) then
                return nil
            end
            task.spawn(self._finishVisuals, self, true)
            return true
        end
        return true
    end

    local u5 = 0
    local u6 = nil
    u6 = (RunService.PreRender:Connect(function(a1) -- Line: 207 -- upvalues: u5 (ref), u4 (val), u6 (ref) -- types: a1: number
        u5 = u5 + a1
        if u4(u5) then
            u6:Disconnect()
        end
    end))
    self._animation = u6
end

function u91:_init() -- Line: 563
    self:_start()
end

function u91.GetAppliedSecondsValue(a1) -- Line: 569
    return a1._appliedSeconds
end

function u91.IsComplete(a1) -- Line: 575
    return a1._visualFinished and not a1._pendingCommit
end

function u91.IsBillboardFadeFinished(a1) -- Line: 579
    return a1._billboardFadeFinished
end

function u91.SetTransform(a1, a2, a3, a4) -- Line: 585
    -- upvalues: t (val), u41 (val)
    t.strict(t.CFrame)(a2)
    t.strict(u41)(a3)
    t.strict(u41)(a4)
    a1._basePivot = a2
    a1._startScale = a3
    a1._targetScale = a4
    a1:_refreshNightScaleRange()
end

function u91.AcknowledgeRecord(a1, a2) -- Line: 600
    -- upvalues: Eggs (val), EggRecords (val), AreaEggCycle (val), ServerClock (val)
    assert(Eggs.SchemaValidation.RuntimeEggRecord(a2), "Invalid runtime egg record")
    a1._record = a2
    a1._growthSpeedMultiplier = a2.GrowthSpeedMultiplier
    local Placement = a2.Placement
    if Placement ~= nil and Placement.ReadyAt == nil then
        local v1 = EggRecords.CommittedNightCredit(a2, a1._nightPeriodIndex)
        a1._committedNightCreditSeconds = v1
        local v2 = EggRecords.GrowthSecondsRemaining(a2, a1._nightStartsAt, a1._growthSpeedMultiplier) + v1
        a1._remainingAtNightfall = v2
        a1._nightTargetCreditSeconds = math.min(AreaEggCycle.NightGrowthSkipSeconds, v2)
        a1._skipSeconds = math.max(0, a1._nightTargetCreditSeconds - v1)
        a1:_refreshNightScaleRange()
        a1:_setAppliedSeconds((a1:_getAppliedSecondsAt((ServerClock.Now()))))
        if a1._nightTargetCreditSeconds - 0.05 <= v1 then
            a1._pendingCommit = false
        end
        return
    end
    a1:_setAppliedSeconds(0)
    a1._pendingCommit = false
end

function u91.CancelVisual(a1) -- Line: 633
    if not a1._visualFinished and not a1._visualFinishing then
        task.spawn(a1._finishVisuals, a1, false)
        return
    end
end

function u91:Destroy() -- Line: 640 -- upvalues: EggActionMovement (val)
    if self._destroyed then
        return
    end
    self._destroyed = true
    local _animation = self._animation
    if _animation ~= nil then
        _animation:Disconnect()
        self._animation = nil
    end
    self._visualTrove:Destroy()
    self._lifecycleTrove:Destroy()
    if self._model.Parent ~= nil then
        EggActionMovement.SetPivot(self._model, self._basePivot)
    end
end

return u91