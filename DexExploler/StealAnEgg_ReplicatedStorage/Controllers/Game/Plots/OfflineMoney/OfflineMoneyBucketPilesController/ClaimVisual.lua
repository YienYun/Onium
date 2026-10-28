-- Script path: ReplicatedStorage.Controllers.Game.Plots.OfflineMoney.OfflineMoneyBucketPilesController.ClaimVisual
-- Decompile time: 5.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local u21 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1 / 0)))
local MoneyPiles = require(script.Parent.MoneyPiles)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u36 = {}
u36.__index = u36
u36.__class = "OfflineMoneyClaimVisual"
local u42 = Color3.new(1, 1, 1)
local Assets = ReplicatedStorage.Assets
local ClaimArea = Assets.Models.ClaimArea
assert(ClaimArea:IsA("BasePart"), "ReplicatedStorage.Assets.Models.ClaimArea must be a BasePart")
local OfflineCash = Assets.Billboards.OfflineCash
assert(OfflineCash:IsA("BillboardGui"), "ReplicatedStorage.Assets.Billboards.OfflineCash must be a BillboardGui")

function u36.new(a1, a2, a3) -- Line: 67
    -- upvalues: t (val), u21 (val), u36 (val), Trove (val), ClaimArea (val), MoneyPiles (val), OfflineCash (val)
    t.strict(u21)(a1)
    t.strict(t.instanceIsA("BasePart"))(a2)
    t.strict(t.Instance)(a3)
    local u28 = setmetatable({}, u36)
    local v1 = Trove.new()
    local Model = Instance.new("Model")
    Model.Name = "LocalOfflineMoneyClaim"
    Model.Parent = a3
    local v2 = ClaimArea:Clone()
    v2.Name = "OfflineMoneyClaimArea"
    v2.CFrame = a2.CFrame + Vector3.new(0, 0.20000000298023224, 0)
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanTouch = false
    v2.CanQuery = false
    v2.Parent = Model
    local u52 = MoneyPiles.new(v2, Model)
    local v3 = OfflineCash:Clone()
    v3.Name = "OfflineMoneyClaimBillboard"
    v3.AlwaysOnTop = true
    v3.Parent = v2
    v3.Enabled = true
    local Money = v3.Money
    assert(Money and Money:IsA("TextLabel"), "OfflineCash.Money must be a TextLabel")
    u28._trove = v1
    u28._amount = a1
    u28._rootModel = Model
    u28._claimArea = v2
    u28._generatedMoney = u52
    u28._billboard = v3
    u28._billboardBaseSize = v3.Size
    u28._billboardPulseTween = nil
    u28._billboardTextBlinkTween = nil
    u28._billboardPulseActive = false
    u28._moneyLabel = Money
    u28._moneyLabelBaseTextColor = u28._moneyLabel.TextColor3
    v1:Add(Model)
    v1:Add(function() -- Line: 118 -- upvalues: u52 (val)
        u52:Destroy()
    end)
    v1:Add((u52.BillboardAdorneeChanged:Connect(function() -- Line: 120 -- upvalues: u28 (val)
        u28:_syncBillboardAdornee()
    end)))
    u28:Update(a1, a2)
    return u28
end

function u36._formatMoney(a1) -- Line: 132 -- upvalues: Simple (val) -- types: a1: number
    return "$" .. Simple.FormatCompact(math.max(a1, 0), "precision-integer")
end

function u36._scaleBillboardSize(a1, a2) -- Line: 136 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale * a2, math.round(a1.X.Offset * a2), a1.Y.Scale * a2, (math.round(a1.Y.Offset * a2)))
end

function u36:_stopBillboardPulse() -- Line: 145
    self._billboardPulseActive = false
    local _billboardPulseTween = self._billboardPulseTween
    if _billboardPulseTween then
        _billboardPulseTween:Cancel()
        self._billboardPulseTween = nil
    end
    local _billboardTextBlinkTween = self._billboardTextBlinkTween
    if _billboardTextBlinkTween then
        _billboardTextBlinkTween:Cancel()
        self._billboardTextBlinkTween = nil
    end
    self._billboard.Size = self._billboardBaseSize
    self._moneyLabel.TextColor3 = self._moneyLabelBaseTextColor
end

function u36:_syncBillboardPulse() -- Line: 162 -- upvalues: TweenService (val), u36 (val), u42 (val)
    local Enabled = self._billboard.Enabled and 0 < self._amount
    if not Enabled then
        self:_stopBillboardPulse()
        return
    end
    if self._billboardPulseActive then
        return
    end
    self._billboardPulseActive = true
    self._billboard.Size = self._billboardBaseSize
    self._moneyLabel.TextColor3 = self._moneyLabelBaseTextColor
    local v1 = TweenService:Create(
        self._billboard,
        TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true),
        {Size = u36._scaleBillboardSize(self._billboardBaseSize, 1.75)}
    )
    local v2 = TweenService:Create(
        self._moneyLabel,
        TweenInfo.new(0.6400000000000001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true),
        {TextColor3 = u42}
    )
    self._billboardPulseTween = v1
    self._billboardTextBlinkTween = v2
    v1:Play()
    v2:Play()
end

function u36:_syncBillboardAdornee() -- Line: 212 -- upvalues: OfflineCash (val)
    self._billboard.AlwaysOnTop = true
    local BillboardAdornee = self._generatedMoney:GetBillboardAdornee()
    if BillboardAdornee then
        self._billboard.Adornee = BillboardAdornee
        self._billboard.StudsOffset = OfflineCash.StudsOffset
        return
    end
    self._billboard.Adornee = self._claimArea
    self._billboard.StudsOffset = Vector3.new(0, 6, 0)
end

function u36:_syncBillboardText() -- Line: 224 -- upvalues: u36 (val)
    self._moneyLabel.RichText = true
    self._moneyLabel.Text = ("OFFLINE CLAIM! <br/>%*"):format((u36._formatMoney(self._amount)))
end

function u36:Update(a2, a3) -- Line: 233 -- upvalues: t (val), u21 (val) -- types: a2: number, a3: userdata
    t.strict(u21)(a2)
    t.strict(t.instanceIsA("BasePart"))(a3)
    self._amount = a2
    self._claimArea.CFrame = a3.CFrame + Vector3.new(0, 0.20000000298023224, 0)
    self._generatedMoney:UpdateInstant(a2, true)
    self:_syncBillboardText()
    self:_syncBillboardAdornee()
    self._billboard.Enabled = a2 > 0
    self:_syncBillboardPulse()
end

function u36.SetBillboardEnabled(a1, a2) -- Line: 250 -- upvalues: t (val) -- types: a2: boolean
    t.strict(t.boolean)(a2)
    a1._billboard.Enabled = a2 and 0 < a1._amount
    a1:_syncBillboardPulse()
end

function u36.ContainsWorldPosition(a1, a2) -- Line: 259 -- upvalues: t (val) -- types: a2: vector
    local v1
    t.strict(t.Vector3)(a2)
    local v2 = a1._claimArea.CFrame:PointToObjectSpace(a2)
    local v3 = a1._claimArea.Size * 0.5
    if a1._claimArea:IsA("Part") and a1._claimArea.Shape == Enum.PartType.Cylinder then
        v1 = (math.abs(v2.X)) < v3.X
        local v4 = math.min(v3.Y, v3.Z)
        local v5 = v2.Y * v2.Y + v2.Z * v2.Z
        return v1 and v5 < v4 * v4
    end
    v1 = false
    if (math.abs(v2.X)) < v3.X then
        v1 = (math.abs(v2.Z)) < v3.Z
    end
    return v1
end

function u36.PlayClaim(a1) -- Line: 280
    a1._billboard.Enabled = false
    a1:_stopBillboardPulse()
    a1._generatedMoney:PlayCollectReset()
end

function u36:Destroy() -- Line: 286
    self:_stopBillboardPulse()
    self._trove:Destroy()
end

return u36