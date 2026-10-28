-- Script path: ReplicatedStorage.Controllers.GUI.FuseMachineController.FuseMachineProgressPresentation
-- Decompile time: 7.86 ms

local Fusion = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Fusion
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u40 = Log.new()
local u41 = {}
u41.__index = u41
u41.__class = "FuseMachineProgressPresentation"
local u43 = {"LeftBar", "MiddleBar", "RightBar"}
local u51 = Color3.new(1, 1, 1)
local u56 = Color3.new(0, 0, 0)
local u61 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u66 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u71 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

function u41.new(a1, a2) -- Line: 80 -- upvalues: t (val), u41 (val), u43 (val), Trove (val)
    local Fill, v1, v2
    t.strict(t.instanceIsA("Frame"))(a1)
    t.strict(t.instanceIsA("Frame"))(a2)
    local v3 = setmetatable({}, u41)
    v3._barFills = {}
    v3._barFilled = {}
    v3._barLitTransparencies = {}
    v3._barOriginalVisible = {}
    v3._barTroves = {}
    v3._barTweenInfo = TweenInfo.new(a2:GetAttribute("FillFadeSeconds") or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v4, v5 = a1, a2
    for i, v in ipairs(u43) do
        v2 = v5:FindFirstChild(v)
        v1 = ("PetFuse.FuseMain.DesignBars.%* is missing"):format(v)
        assert(v2 ~= nil, v1)
        Fill = v2:FindFirstChild("Fill")
        v1 = false
        if Fill ~= nil then
            v1 = Fill:IsA("ImageLabel")
        end
        assert(v1, (("PetFuse.FuseMain.DesignBars.%*.Fill must be an ImageLabel"):format(v)))
        v3._barFills[i] = Fill
        v3._barLitTransparencies[i] = Fill.ImageTransparency
        v3._barOriginalVisible[i] = Fill.Visible
        v3._barTroves[i] = (Trove.new())
    end
    v3._icon = v4.OutputEgg
    t.strict(t.instanceIsA("ImageLabel"))(v3._icon)
    v3._iconOriginalBackgroundColor = v3._icon.BackgroundColor3
    v3._iconOriginalColor = v3._icon.ImageColor3
    v3._iconOriginalImage = v3._icon.Image
    v3._iconOriginalTransparency = v3._icon.ImageTransparency
    v3._iconScale = Instance.new("UIScale")
    v3._iconScale.Name = "FuseProgressScale"
    v3._iconScale.Parent = v3._icon
    v3._iconOriginalScale = v3._iconScale.Scale
    v3._iconTrove = Trove.new()
    v3._outputFill = v4.Fill
    t.strict(t.instanceIsA("Frame"))(v3._outputFill)
    v3._outputOriginalPosition = v3._outputFill.Position
    v3._outputOriginalSize = v3._outputFill.Size
    v3._outputAnchorY = v3._outputFill.AnchorPoint.Y
    v3._outputBottomScale = v3._outputOriginalPosition.Y.Scale + (1 - v3._outputAnchorY) * v3._outputOriginalSize.Y.Scale
    v3._outputBottomOffset = v3._outputOriginalPosition.Y.Offset + (1 - v3._outputAnchorY) * v3._outputOriginalSize.Y.Offset
    v3._outputTrove = Trove.new()
    v3._selectedCount = nil
    v3._trove = Trove.new()
    v3._trove:Add(v3._iconScale)
    v3._trove:Add(v3._iconTrove)
    v3._trove:Add(v3._outputTrove)
    for i2, i3 in ipairs(v3._barTroves) do
        v3._trove:Add(i3)
    end
    return v3
end

function u41:_setBarFilled(a2, a3, a4) -- Line: 156
    -- upvalues: TweenService (val)
    if self._barFilled[a2] == a3 then
        return
    end
    self._barFilled[a2] = a3
    local v1 = self._barTroves[a2]
    v1:Clean()
    local u13 = self._barFills[a2]
    local v2 = if not a3 then 1 else self._barLitTransparencies[a2]
    if not a4 then
        u13.ImageTransparency = v2
        u13.Visible = a3
        return
    end
    if a3 and not u13.Visible then
        u13.ImageTransparency = 1
        u13.Visible = true
    end
    local u34 = TweenService:Create(u13, self._barTweenInfo, {ImageTransparency = v2})
    v1:Add(function() -- Line: 190 -- upvalues: u34 (val)
        u34:Cancel()
        u34:Destroy()
    end)
    v1:Add((u34.Completed:Connect(function(a1) -- Line: 195 -- upvalues: u13 (val), self (val), a2 (val)
        if a1 ~= Enum.PlaybackState.Completed then
            return
        end
        u13.Visible = self._barFilled[a2]
    end)))
    u34:Play()
end

function u41:_setOutputProgress(a2, a3) -- Line: 205
    -- upvalues: Fusion (val), TweenService (val), u61 (val)
    self._outputTrove:Clean()
    local v1 = math.min(a2 / Fusion.INPUT_COUNT, 1)
    local v2 = UDim2.new(self._outputOriginalSize.X.Scale, self._outputOriginalSize.X.Offset, v1, 0)
    local v3 = UDim2.new(
        self._outputOriginalPosition.X.Scale,
        self._outputOriginalPosition.X.Offset,
        self._outputBottomScale - (1 - self._outputAnchorY) * v1,
        self._outputBottomOffset
    )
    if not a3 then
        self._outputFill.Size = v2
        self._outputFill.Position = v3
        return
    end
    local u46 = TweenService:Create(self._outputFill, u61, {Position = v3, Size = v2})
    self._outputTrove:Add(function() -- Line: 236 -- upvalues: u46 (val)
        u46:Cancel()
        u46:Destroy()
    end)
    u46:Play()
end

function u41:_setIncompleteIcon() -- Line: 244 -- upvalues: u56 (val)
    self._iconTrove:Clean()
    self._icon.ImageTransparency = 0.1
    self._icon.ImageColor3 = u56
    self._icon.BackgroundColor3 = u56
    self._iconScale.Scale = self._iconOriginalScale
end

function u41:_setReadyIcon(a2) -- Line: 254
    -- upvalues: u51 (val), TweenService (val), u66 (val), Fusion (val), u71 (val)
    self._iconTrove:Clean()
    self._icon.ImageTransparency = 0
    self._icon.ImageColor3 = u51
    self._icon.BackgroundColor3 = u51
    self._iconScale.Scale = self._iconOriginalScale
    if not a2 then
        return
    end
    self._iconScale.Scale = 0.8
    local u24 = TweenService:Create(self._iconScale, u66, {Scale = self._iconOriginalScale * 1.2})
    self._iconTrove:Add(function() -- Line: 272 -- upvalues: u24 (val)
        u24:Cancel()
        u24:Destroy()
    end)
    self._iconTrove:Add((u24.Completed:Connect(function(a1) -- Line: 277 -- upvalues: self (val), Fusion (upval), TweenService (upval), u71 (upval)
        if a1 == Enum.PlaybackState.Completed and self._selectedCount == Fusion.INPUT_COUNT then
            local u15 = TweenService:Create(self._iconScale, u71, {Scale = self._iconOriginalScale})
            self._iconTrove:Add(function() -- Line: 288 -- upvalues: u15 (val)
                u15:Cancel()
                u15:Destroy()
            end)
            u15:Play()
            return
        end
    end)))
    u24:Play()
end

function u41.Update(a1, a2, a3) -- Line: 302 -- upvalues: t (val), Fusion (val) -- types: a2: table, a3: string?
    t.strict(t.array(t.boolean))(a2)
    assert(#a2 == 3, "Fuse progress needs one flag per input slot")
    t.strict(t.optional(t.string))(a3)
    local v1 = 0
    for i, v in ipairs(a2) do
        if v then
            v1 = v1 + 1
        end
    end
    if v1 ~= 0 then
        local v2 = false
        if a3 ~= nil then
            v2 = a3 ~= ""
        end
        assert(v2, "Selected FuseMachine category requires an egg icon")
        a1._icon.Image = a3
    else
        a1._icon.Image = a1._iconOriginalImage
    end
    local _selectedCount = a1._selectedCount
    a1:_setBarFilled(1, a2[1], _selectedCount ~= nil)
    a1:_setBarFilled(2, a2[2], _selectedCount ~= nil)
    a1:_setBarFilled(3, a2[3], _selectedCount ~= nil)
    if _selectedCount == v1 then
        return
    end
    a1._selectedCount = v1
    if _selectedCount == nil then
        a1:_setOutputProgress(v1, false)
        if v1 == Fusion.INPUT_COUNT then
            a1:_setReadyIcon(false)
            return
        end
        a1:_setIncompleteIcon()
        return
    end
    a1:_setOutputProgress(v1, true)
    if v1 == Fusion.INPUT_COUNT then
        a1:_setReadyIcon(true)
        return
    end
    a1:_setIncompleteIcon()
end

function u41:Destroy() -- Line: 361 -- upvalues: u40 (val)
    self._trove:Destroy()
    for i, v in ipairs(self._barFills) do
        v.ImageTransparency = self._barLitTransparencies[i]
        v.Visible = self._barOriginalVisible[i]
    end
    self._outputFill.Position = self._outputOriginalPosition
    self._outputFill.Size = self._outputOriginalSize
    self._icon.Image = self._iconOriginalImage
    self._icon.ImageTransparency = self._iconOriginalTransparency
    self._icon.ImageColor3 = self._iconOriginalColor
    self._icon.BackgroundColor3 = self._iconOriginalBackgroundColor
    u40:AtTrace():Log("Destroyed FuseMachine progress presentation")
end

return u41