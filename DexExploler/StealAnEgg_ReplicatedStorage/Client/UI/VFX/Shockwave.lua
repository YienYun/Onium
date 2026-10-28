-- Script path: ReplicatedStorage.Client.UI.VFX.Shockwave
-- Decompile time: 3.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local OverlayRoot = require(script.Parent.OverlayRoot)
local u15 = {
    seconds = 0.8,
    startTransparency = 0.1,
    coverage = 0.55,
    minPeak = 4,
    maxPeak = 200,
    fallbackScreenFactor = 16,
    template = ReplicatedStorage.Assets.UI.Misc.ShockSphere,
}
local u25 = TweenInfo.new(u15.seconds, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local u30 = TweenInfo.new(u15.seconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function midpoint(a1) -- Line: 22 -- types: a1: userdata
    local AbsolutePosition = a1.AbsolutePosition
    local AbsoluteSize = a1.AbsoluteSize
    return UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X * 0.5, AbsolutePosition.Y + AbsoluteSize.Y * 0.5)
end

local function peakScaleFor(a1, a2) -- Line: 27 -- upvalues: u15 (val) -- types: a1: userdata, a2: number
    local v1 = math.max(a1.AbsoluteSize.Magnitude, 1)
    local CurrentCamera = workspace.CurrentCamera
    return (math.clamp(
        (if not CurrentCamera then v1 * u15.fallbackScreenFactor else CurrentCamera.ViewportSize.Magnitude) / v1 * u15.coverage * a2,
        u15.minPeak,
        u15.maxPeak
    ))
end

local function timed(a1, a2) -- Line: 36 -- types: a1: userdata, a2: number
    if a2 == a1.Time then
        return a1
    end
    return (TweenInfo.new(a2, a1.EasingStyle, a1.EasingDirection))
end

local function pulseOf(a1) -- Line: 42 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale and UIScale:IsA("UIScale") then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Parent = a1
    return UIScale_2
end

return function(a1, a2, a3, a4) -- Line: 52
    -- upvalues: u15 (val), OverlayRoot (val), TweenService (val), u30 (val), u25 (val)
    local v1
    local seconds = a2 or u15.seconds
    local u11 = u15.template:Clone()
    local UIScale = u11:FindFirstChildOfClass("UIScale")
    if not UIScale or not UIScale:IsA("UIScale") then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = u11
        v1 = UIScale_2
    else
        v1 = UIScale
    end
    v1.Scale = 0
    u11.ImageTransparency = a3 or u15.startTransparency
    local AbsolutePosition = a1.AbsolutePosition
    local AbsoluteSize = a1.AbsoluteSize
    u11.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X * 0.5, AbsolutePosition.Y + AbsoluteSize.Y * 0.5)
    u11.Size = UDim2.fromOffset(a1.AbsoluteSize.X, a1.AbsoluteSize.Y)
    u11.Parent = OverlayRoot()

    local function recentre() -- Line: 68 -- upvalues: u11 (val), a1 (val)
        local v1 = u11
        local v2 = a1
        local AbsolutePosition = v2.AbsolutePosition
        local AbsoluteSize = v2.AbsoluteSize
        v1.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X * 0.5, AbsolutePosition.Y + AbsoluteSize.Y * 0.5)
    end

    local u63 = {}
    local v2 = (a1:GetPropertyChangedSignal("AbsolutePosition")):Connect(recentre)
    local PropertyChangedSignal_2 = a1:GetPropertyChangedSignal("AbsoluteSize")
    u63[1] = v2
    u63[2] = PropertyChangedSignal_2:Connect(recentre)
    u11.Destroying:Once(function() -- Line: 75 -- upvalues: u63 (val)
        for i, j in u63 do
            j:Disconnect()
        end
    end)
    local v3 = u30
    TweenService:Create(
        u11,
        if seconds ~= v3.Time then TweenInfo.new(seconds, v3.EasingStyle, v3.EasingDirection) else v3,
        {ImageTransparency = 1}
    ):Play()
    v3 = u25
    local v4 = if seconds ~= v3.Time then TweenInfo.new(seconds, v3.EasingStyle, v3.EasingDirection) else v3
    v3 = {}
    local v5 = math.max(a1.AbsoluteSize.Magnitude, 1)
    local CurrentCamera = workspace.CurrentCamera
    v3.Scale = math.clamp(
        (if not CurrentCamera then v5 * u15.fallbackScreenFactor else CurrentCamera.ViewportSize.Magnitude) / v5 * u15.coverage * (a4 or 1),
        u15.minPeak,
        u15.maxPeak
    )
    local v6 = TweenService:Create(v1, v4, v3)
    v6.Completed:Once(function() -- Line: 85 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    v6:Play()
    return u11
end