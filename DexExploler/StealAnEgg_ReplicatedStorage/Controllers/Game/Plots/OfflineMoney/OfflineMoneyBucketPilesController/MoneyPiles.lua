-- Script path: ReplicatedStorage.Controllers.Game.Plots.OfflineMoney.OfflineMoneyBucketPilesController.MoneyPiles
-- Decompile time: 11.76 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local u21 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1 / 0)))
local EmitAt = require(ReplicatedStorage.Shared.Utils.VFX).EmitAt
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u40 = {}
u40.__index = u40
u40.__class = "OfflineGeneratedMoney"
local u46 = Color3.new(1, 1, 1)
local u48 = Log.new()
local BuckPiles = ReplicatedStorage.Assets.Models.BuckPiles
assert(BuckPiles:IsA("Folder"), "ReplicatedStorage.Assets.Models.BuckPiles must be a Folder")
local MoneyCollect = ReplicatedStorage.Assets.VFX.MoneyCollect
assert(MoneyCollect:IsA("Folder"), "ReplicatedStorage.Assets.VFX.MoneyCollect must be a Folder")

function u40.new(a1, a2) -- Line: 84
    -- upvalues: t (val), u40 (val), Trove (val), Signal (val), BuckPiles (val)
    local _stages, v1
    t.strict(t.instanceIsA("BasePart"))(a1)
    t.strict(t.Instance)(a2)
    local v2 = u40
    local u21 = setmetatable({}, v2)
    local Folder = Instance.new("Folder")
    Folder.Name = "LocalOfflineGeneratedMoneyPiles"
    Folder.Parent = a2
    v2 = Trove.new()
    u21._trove = v2
    u21._animationTrove = Trove.new()
    u21._bucketRoot = a1
    u21._runtimeFolder = Folder
    u21._stages = {}
    u21._currentStageIndex = 0
    u21._lastStageCenterCFrame = nil
    u21._destroyed = false
    u21._lastAdornee = nil
    u21.BillboardAdorneeChanged = Signal.new()
    v2:Add(Folder)
    v2:Add(u21._animationTrove)
    v2:Add(((a1:GetPropertyChangedSignal("CFrame")):Connect(function() -- Line: 111 -- upvalues: u21 (val), u40 (upval), a1 (val)
        for i, v in ipairs(u21._stages) do
            u40._pivotRootToBucket(v.model, v.rootPart, a1)
        end
    end)))
    v2 = {}
    for i, v in ipairs(BuckPiles:GetChildren()) do
        if v:IsA("Model") then
            v2[#v2 + 1] = v
        end
    end
    table.sort(v2, function(a1, a2) -- Line: 126 -- upvalues: u40 (upval) -- types: a1: userdata, a2: userdata
        return (u40._getStageSortIndex(a1)) < u40._getStageSortIndex(a2)
    end)
    assert(#v2 == 3, "BuckPiles must contain exactly three stage models")
    for i2, i3 in ipairs(v2) do
        _stages = u21._stages
        v1 = #u21._stages + 1
        _stages[v1] = (u21:_buildStage(i3))
    end
    u21:_hideAllStages()
    return u21
end

function u40._getStageSortIndex(a1) -- Line: 146 -- types: a1: userdata
    local v1 = tonumber(a1.Name)
    assert(v1, (("BuckPiles stage %* must be numerically named"):format(a1.Name)))
    return v1
end

function u40._readVector3Attribute(a1, a2) -- Line: 152 -- upvalues: t (val) -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    t.strict(t.Vector3)(Attribute)
    return Attribute
end

function u40._readCFrameAttribute(a1, a2) -- Line: 158 -- upvalues: t (val) -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    t.strict(t.CFrame)(Attribute)
    return Attribute
end

function u40._getVisibleTransparency(a1) -- Line: 164 -- types: a1: userdata
    if 1 <= a1.Transparency then
        return 0
    end
    return a1.Transparency
end

function u40._pivotRootToBucket(a1, a2, a3) -- Line: 168 -- types: a1: userdata, a2: userdata, a3: userdata
    local Pivot = a1:GetPivot()
    a1:PivotTo(a3.CFrame * (a2.CFrame:Inverse()) * Pivot)
end

function u40._createTopAttachment(a1) -- Line: 178 -- upvalues: t (val) -- types: a1: userdata
    local GeneratedMoneyTopAttachment = a1:FindFirstChild("GeneratedMoneyTopAttachment")
    if GeneratedMoneyTopAttachment then
        t.strict(t.instanceIsA("Attachment"))(GeneratedMoneyTopAttachment)
        return GeneratedMoneyTopAttachment
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "GeneratedMoneyTopAttachment"
    Attachment.Parent = a1
    return Attachment
end

function u40._createHighlight(a1) -- Line: 191 -- upvalues: u46 (val) -- types: a1: userdata
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "OfflineMoneyBucketHighlight"
    Highlight.Adornee = a1
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = u46
    Highlight.OutlineTransparency = 0
    Highlight.Enabled = false
    Highlight.Parent = a1
    return Highlight
end

function u40._syncTopAttachment(a1) -- Line: 204 -- types: a1: table
    local BoundingBox, BoundingBox_2 = a1.model:GetBoundingBox()
    local v1 = BoundingBox.Position + BoundingBox.UpVector * (BoundingBox_2.Y * 0.5)
    a1.topAttachment.Position = a1.mainPart.CFrame:PointToObjectSpace(v1)
end

function u40._collectAnimatedParts(a1, a2) -- Line: 211
    -- upvalues: u40 (val), u48 (val)
    local v1, v2, v3, v4
    local v5 = {}
    local v6, v7 = a1, a2
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") and v ~= v7 then
            v3 = v:GetAttribute("OriginalSize") ~= nil
            v4 = v:GetAttribute("TargetSize") ~= nil
            v1 = v:GetAttribute("OriginalCFrame") ~= nil
            v2 = v:GetAttribute("TargetCFrame") ~= nil
            if v3 or v4 or v1 or v2 then
                v5[#v5 + 1] = {
                    part = v,
                    originalSize = u40._readVector3Attribute(v, "OriginalSize"),
                    targetSize = u40._readVector3Attribute(v, "TargetSize"),
                    originalCFrame = u40._readCFrameAttribute(v, "OriginalCFrame"),
                    targetCFrame = u40._readCFrameAttribute(v, "TargetCFrame"),
                    visibleTransparency = u40._getVisibleTransparency(v),
                }
            end
        end
    end
    if #v5 == 0 then
        (u48:AtWarning()):Log((("BuckPiles stage %* has no animated part attributes"):format(v6.Name)))
    end
    return v5
end

function u40._setStageVisible(a1, a2) -- Line: 244 -- types: a1: table, a2: boolean
    local Attribute, v1
    local v2, v3 = a1, a2
    for i, v in ipairs(a1.model:GetDescendants()) do
        if v:IsA("BasePart") then
            if v ~= v2.rootPart then
                Attribute = v:GetAttribute("_OfflineGeneratedMoneyVisibleTransparency")
                v1 = if not v3 then 1 else if typeof(Attribute) ~= "number" then 1 else Attribute
                v.Transparency = v1
            else
                v.Transparency = 1
            end
        end
    end
    v2.highlight.Enabled = v3
end

function u40._resetStageParts(a1) -- Line: 262 -- upvalues: u40 (val) -- types: a1: table
    local CFrame = a1.rootPart.CFrame
    for i, v in ipairs(a1.animatedParts) do
        v.part.Size = v.originalSize
        v.part.CFrame = CFrame * v.originalCFrame
    end
    u40._syncTopAttachment(a1)
end

function u40._applyStageAlpha(a1, a2) -- Line: 272 -- upvalues: u40 (val) -- types: a1: table, a2: number
    local v1 = math.clamp(a2, 0, 1)
    local CFrame = a1.rootPart.CFrame
    for i, v in ipairs(a1.animatedParts) do
        v.part.Size = v.originalSize:Lerp(v.targetSize, v1)
        v.part.CFrame = CFrame * v.originalCFrame:Lerp(v.targetCFrame, v1)
        v.part.Transparency = v.visibleTransparency
    end
    u40._syncTopAttachment(a1)
end

function u40:_buildStage(a2) -- Line: 287 -- upvalues: t (val), u40 (val) -- types: a2: userdata
    local v1
    local v2 = a2:Clone()
    v2.Name = ("OfflineGeneratedMoneyStage%*"):format(a2.Name)
    v2.Parent = self._runtimeFolder
    local RootPart = v2:FindFirstChild("RootPart")
    t.strict(t.instanceIsA("BasePart"))(RootPart)
    local Main = v2:FindFirstChild("Main")
    t.strict(t.instanceIsA("BasePart"))(Main)
    v2.PrimaryPart = RootPart
    u40._pivotRootToBucket(v2, RootPart, self._bucketRoot)
    for i, v in ipairs(v2:GetDescendants()) do
        if v:IsA("BasePart") then
            v1 = u40._getVisibleTransparency(v)
            v:SetAttribute("_OfflineGeneratedMoneyVisibleTransparency", v1)
            if v == RootPart then
                v.Transparency = 1
            end
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
        end
    end
    local v3 = {
        index = u40._getStageSortIndex(a2),
        model = v2,
        rootPart = RootPart,
        mainPart = Main,
        highlight = u40._createHighlight(v2),
        topAttachment = u40._createTopAttachment(Main),
        animatedParts = u40._collectAnimatedParts(v2, RootPart),
    }
    u40._resetStageParts(v3)
    u40._setStageVisible(v3, false)
    return v3
end

function u40:_hideAllStages() -- Line: 333 -- upvalues: u40 (val)
    for i, v in ipairs(self._stages) do
        u40._resetStageParts(v)
        u40._setStageVisible(v, false)
    end
    self._currentStageIndex = 0
    if self._lastAdornee ~= nil then
        self._lastAdornee = nil
        self.BillboardAdorneeChanged:Fire(nil)
    end
end

function u40:_fadeOutStages(a2) -- Line: 346 -- upvalues: TweenService (val) -- types: a2: number
    local v1, v2
    local v3 = false
    for i, v in ipairs(self._stages) do
        v.highlight.Enabled = false
        for i2, i3 in ipairs(v.model:GetDescendants()) do
            if i3:IsA("BasePart") and i3 ~= v.rootPart and i3.Transparency < 1 then
                v3 = true
                v1 = TweenService
                v2 = TweenInfo.new(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                v1 = v1:Create(i3, v2, {Transparency = 1})
                v5._animationTrove:Add(v1)
                v1:Play()
            end
        end
    end
    return v3
end

function u40:_getCollectAllEffectCFrame() -- Line: 374
    local _currentStageIndex = if not (0 < self._currentStageIndex) then nil else self._currentStageIndex
    local v1 = if not _currentStageIndex then nil else self._stages[_currentStageIndex]
    if v1 then
        return v1.mainPart.CFrame
    end
    return self._lastStageCenterCFrame or self._bucketRoot.CFrame
end

function u40._emitCollectAllCash(a1) -- Line: 382 -- upvalues: EmitAt (val), MoneyCollect (val) -- types: a1: userdata
    EmitAt(a1, MoneyCollect:GetChildren())
end

function u40:_setProgress(a2) -- Line: 386 -- upvalues: u40 (val) -- types: a2: number
    local v1 = math.clamp(a2, 0, 1)
    local _stages = self._stages
    local v2 = #_stages
    if v2 <= 0 then
        return
    end
    if v1 <= 0 then
        self:_hideAllStages()
        return
    end
    local v3 = v1 * v2
    local v4 = math.clamp(math.floor(v3) + 1, 1, v2)
    v2 = if not (v1 >= 1) then v3 - (v4 - 1) else 1
    local v5 = self
    for i, v in ipairs(_stages) do
        v3 = i == v4
        u40._setStageVisible(v, v3)
        if not v3 then
            u40._resetStageParts(v)
        else
            u40._applyStageAlpha(v, v2)
        end
    end
    v5._currentStageIndex = v4
    v5._lastStageCenterCFrame = _stages[v4].mainPart.CFrame
    local topAttachment = _stages[v4].topAttachment
    if v5._lastAdornee ~= topAttachment then
        v5._lastAdornee = topAttachment
        v5.BillboardAdorneeChanged:Fire(topAttachment)
    end
end

function u40.UpdateInstant(a1, a2, a3) -- Line: 428 -- upvalues: t (val), u21 (val) -- types: a2: number, a3: boolean
    t.strict(u21)(a2)
    t.strict(t.boolean)(a3)
    if a3 and not (a2 <= 0) then
        a1:_setProgress((math.clamp((math.max(a2 - 1, 0)) / 999999999, 0, 1)))
        return
    end
    a1:_hideAllStages()
end

function u40.PlayCollectReset(a1) -- Line: 447 -- upvalues: Trove (val), u40 (val)
    a1._animationTrove:Destroy()
    a1._animationTrove = Trove.new()
    a1._trove:Add(a1._animationTrove)
    if a1:_fadeOutStages(0.3) then
        u40._emitCollectAllCash(a1:_getCollectAllEffectCFrame())
    end
    a1._animationTrove:Add((task.delay(0.3, function() -- Line: 457 -- upvalues: a1 (val)
        if a1._destroyed then
            return
        end
        a1:_hideAllStages()
    end)))
end

function u40.GetBillboardAdornee(a1) -- Line: 466
    return a1._lastAdornee
end

function u40:Destroy() -- Line: 470
    self._destroyed = true
    self._trove:Destroy()
end

return u40