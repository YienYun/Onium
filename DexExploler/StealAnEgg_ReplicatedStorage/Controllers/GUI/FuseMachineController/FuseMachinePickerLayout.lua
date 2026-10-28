-- Script path: ReplicatedStorage.Controllers.GUI.FuseMachineController.FuseMachinePickerLayout
-- Decompile time: 1.60 ms

local u0 = {}

function u0.Measure(a1) -- Line: 5 -- types: a1: userdata
    local v1 = a1.X * 0.5271577
    local v2 = v1 / 1.2553575
    local v3 = if not (v2 < 400) then 64 else 48
    return {Width = v1, Height = v2, Header = v3, GridTop = v3 + 90}
end

function u0.Apply(a1, a2) -- Line: 17 -- upvalues: u0 (val) -- types: a1: userdata, a2: userdata
    local v1 = u0.Measure(a2)
    a1.Size = UDim2.fromOffset(v1.Width, v1.Height)
    local UIAspectRatioConstraint = a1:FindFirstChildOfClass("UIAspectRatioConstraint")
    if UIAspectRatioConstraint then
        UIAspectRatioConstraint.AspectRatio = v1.Width / v1.Height
    end
    local Header = a1:FindFirstChild("Header")
    Header.AnchorPoint = Vector2.new(0.5, 0)
    Header.Position = UDim2.fromScale(0.5, 0)
    Header.Size = UDim2.new(1, 0, 0, v1.Header)
    local Close = a1:FindFirstChild("Close")
    Close.AnchorPoint = Vector2.new(1, 0)
    Close.Position = UDim2.new(1, -8, 0, (v1.Header - 44) / 2)
    Close.Size = UDim2.fromOffset(44, 44)
    local Title = a1:FindFirstChild("Title")
    Title.AnchorPoint = Vector2.zero
    Title.Position = UDim2.fromOffset(16, v1.Header + 6)
    Title.Size = UDim2.new(1, -32, 0, 26)
    local IncludeEquipped = a1:FindFirstChild("IncludeEquipped")
    IncludeEquipped.AnchorPoint = Vector2.zero
    IncludeEquipped.Position = UDim2.fromOffset(16, v1.Header + 36)
    IncludeEquipped.Size = UDim2.new(1, -32, 0, 44)
    local ScrollingFrame = a1:FindFirstChild("ScrollingFrame")
    ScrollingFrame.AnchorPoint = Vector2.zero
    ScrollingFrame.Position = UDim2.fromOffset(12, v1.GridTop)
    ScrollingFrame.Size = UDim2.new(1, -24, 1, -v1.GridTop - 12)
    local EmptyState = a1:FindFirstChild("EmptyState")
    EmptyState.AnchorPoint = Vector2.zero
    EmptyState.Position = UDim2.fromOffset(24, v1.GridTop)
    EmptyState.Size = UDim2.new(1, -48, 1, -v1.GridTop - 12)
    local Frame = a1:FindFirstChild("Frame")
    Frame.AnchorPoint = Vector2.zero
    Frame.Position = UDim2.fromOffset(8, v1.Header)
    Frame.Size = UDim2.new(1, -16, 1, -v1.Header - 8)
end

return table.freeze(u0)