-- Script path: ReplicatedStorage.Client.GuardTutorialPresentation.TutorialTapIndicator
-- Decompile time: 2.44 ms

local TweenService = game:GetService("TweenService")
local TutorialProp = require(script.Parent.TutorialProp)
local u16 = TweenInfo.new(0.42, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
local v1 = {}

local function nudgeX(a1, a2) -- Line: 17 -- types: a1: Vector2, a2: number
    return UDim2.new(a2, a1.X.Offset, a1.Y.Scale, a1.Y.Offset)
end

local function placement(a1, a2, a3) -- Line: 23 -- types: a1: userdata, a2: boolean, a3: Vector2?
    if a2 then
        local zero = Vector2.zero
        return zero, (UDim2.fromScale(0, 0)), a3 or UDim2.fromScale(1, 1)
    end
    local AnchorPoint = a1.AnchorPoint
    local Position = a1.Position
    return AnchorPoint, Position, a3 or a1.Size
end

local function roundCorners(a1, a2) -- Line: 30 -- types: a1: userdata, a2: UDim2
    local UICorner
    local Frame = a1:FindFirstChild("Frame")
    assert(
        (if Frame == nil then nil else Frame:FindFirstChildWhichIsA("UICorner")) ~= nil,
        "the tap template needs Frame.UICorner to reshape"
    )
    UICorner.CornerRadius = a2
end

function v1.Attach(a1, a2, a3, a4) -- Line: 37
    -- upvalues: TutorialProp (val), TweenService (val), u16 (val)
    local Position, Size, v1, zero
    local v2 = false
    if typeof(a1) == "Instance" then
        v2 = a1:IsA("GuiButton")
    end
    assert(v2, "a tap hint needs a GuiButton")
    v2 = if not (a2 == true) then assert(a1.Parent, "a tap hint beside its button needs that button parented") else a1
    local v3, v4 = TutorialProp.Clone("TutorialTap", "TutorialTapHint")
    if not v1 then
        zero = a1.AnchorPoint
        Position = a1.Position
        Size = a4 or a1.Size
    else
        zero = Vector2.zero
        Position = UDim2.fromScale(0, 0)
        Size = a4 or UDim2.fromScale(1, 1)
    end
    v3.AnchorPoint = zero
    v3.Size = Size
    v3.Position = Position
    v3.Active = false
    v3.ZIndex = a1.ZIndex + 1
    if a3 ~= nil then
        local v5
        local Frame = v3:FindFirstChild("Frame")
        assert(
            (if Frame == nil then nil else Frame:FindFirstChildWhichIsA("UICorner")) ~= nil,
            "the tap template needs Frame.UICorner to reshape"
        )
        v5.CornerRadius = a3
    end
    v3.Parent = v2
    local v6 = v3:FindFirstChild("Chevron")
    local v7 = false
    if v6 ~= nil then
        v7 = v6:IsA("ImageLabel")
    end
    assert(v7, "the tap template needs a Chevron ImageLabel")
    local Position_2 = v6.Position
    v3 = UDim2.new(1, Position_2.X.Offset, Position_2.Y.Scale, Position_2.Y.Offset)
    v6.Position = v3
    v2 = TweenService:Create(v6, u16, {
        Position = UDim2.new(1.18, v3.X.Offset, v3.Y.Scale, v3.Y.Offset),
    })
    v2:Play()
    v4:Add(v2, "Cancel")
    return TutorialProp.Teardown("Removing the tutorial tap hint", v4)
end

return v1