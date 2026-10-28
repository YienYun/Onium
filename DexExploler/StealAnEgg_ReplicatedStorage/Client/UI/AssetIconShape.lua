-- Script path: ReplicatedStorage.Client.UI.AssetIconShape
-- Decompile time: 11.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Assets = require(ReplicatedStorage.Data.Assets)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u44 = UDim2.fromScale(0.5, 0.5)
local u48 = Vector2.new(0.5, 0.5)
local u52 = UDim2.fromScale(1, 1)
local u56 = UDim2.fromScale(0.77, 0.77)
local u60 = UDim2.fromScale(0.85, 0.85)
local u64 = UDim2.fromScale(0, 0)
local u69 = Color3.fromRGB(0, 0, 0)
local u74 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u79 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u84 = t.strict(t.instanceIsA("ImageLabel"))
local u87 = t.strict(t.string)
local u90 = t.strict(t.Color3)
local u93 = t.strict(t.number)
local u98 = t.strict(t.instanceIsA("GuiObject"))
local u103 = t.strict(t.optional(t.callback))
local u104 = {}

local function carries(a1, a2) -- Line: 52 -- types: a2: string
    local v1 = true
    if a1.BaseMutation ~= a2 then
        v1 = table.find(a1.Mutations, a2) ~= nil
    end
    return v1
end

local function zoomFor(a1) -- Line: 58
    return 1, nil
end

local function iconFor(a1, a2) -- Line: 60 -- upvalues: Mutations (val)
    local v1
    local MutationIcons = a1.MutationIcons
    if MutationIcons == nil then
        return a1.Icon or ""
    end
    local v2 = Mutations.Ids()
    local v3 = {v2.Golden, v2.Silver}
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in v3, v4, v5 do
        v1 = true
        if v7.BaseMutation ~= j then
            v1 = table.find(v7.Mutations, j) ~= nil
        end
        if v1 and MutationIcons[j] ~= nil then
            return MutationIcons[j]
        end
    end
    return v6.Icon or ""
end

local function imagesFor(a1, a2) -- Line: 76 -- upvalues: iconFor (val), Mutations (val)
    local v1 = iconFor(a1, a2)
    local v2 = {Icon = v1}
    local Rainbow = Mutations.Ids().Rainbow
    local v3 = true
    if a2.BaseMutation ~= Rainbow then
        v3 = table.find(a2.Mutations, Rainbow) ~= nil
    end
    v2.RainbowOverlay = if not v3 then nil else a1.WhiteImage or v1
    return v2
end

local function stretchBy(a1, a2, a3) -- Line: 86 -- types: a1: userdata, a2: number, a3: number
    return UDim2.new(a1.X.Scale * a2, a1.X.Offset * a2, a1.Y.Scale * a3, a1.Y.Offset * a3)
end

local function makeCanvas(a1, a2, a3, a4) -- Line: 95
    -- upvalues: u44 (val), u48 (val)
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = a1
    CanvasGroup.Size = a2
    CanvasGroup.Position = u44
    CanvasGroup.AnchorPoint = u48
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.ClipsDescendants = true
    CanvasGroup.ZIndex = a3
    CanvasGroup.Parent = a4
    return CanvasGroup
end

local function makeZoomedImage(a1, a2, a3, a4, a5) -- Line: 109
    -- upvalues: u44 (val), u48 (val)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = a1
    ImageLabel.Image = a2
    ImageLabel.Size = UDim2.fromScale(a3, a3)
    ImageLabel.Position = u44 + a4
    ImageLabel.AnchorPoint = u48
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.ZIndex = a5
    return ImageLabel
end

function u104.OverlayRainbow(a1, a2) -- Line: 129
    -- upvalues: u84 (val), u87 (val), u52 (val), u44 (val), u48 (val), Rarity (val)
    u84(a1)
    u87(a2)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "RainbowOverlayImage"
    ImageLabel.Image = a2
    ImageLabel.ImageTransparency = 0.5
    ImageLabel.Size = u52
    ImageLabel.Position = u44
    ImageLabel.AnchorPoint = u48
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.ZIndex = a1.ZIndex + 1
    ImageLabel.Parent = a1
    Rarity.Rarities.Rainbow.RarityGradient:Clone().Parent = ImageLabel
    return ImageLabel
end

function u104.Strip(a1) -- Line: 150 -- upvalues: u84 (val) -- types: a1: userdata
    u84(a1)
    local RainbowOverlayImage = a1:FindFirstChild("RainbowOverlayImage")
    if RainbowOverlayImage and RainbowOverlayImage:IsA("ImageLabel") then
        RainbowOverlayImage:Destroy()
    end
    local AssetIconShapeLayer = a1:FindFirstChild("AssetIconShapeLayer")
    if AssetIconShapeLayer ~= nil then
        AssetIconShapeLayer:Destroy()
    end
    a1.ImageTransparency = 0
end

function u104.Tint(a1, a2, a3) -- Line: 166
    -- upvalues: u84 (val), u90 (val), u93 (val), u69 (val)
    local v1
    u84(a1)
    u90(a2)
    u93(a3)
    a1.ImageColor3 = a2
    a1.ImageTransparency = a3
    local AssetIconShapeLayer = a1:FindFirstChild("AssetIconShapeLayer")
    if AssetIconShapeLayer == nil then
        return
    end
    local v2 = if a2 == u69 then a2 else u69
    local v3, v4 = a3, a2
    for i, j in AssetIconShapeLayer:GetDescendants() do
        if j:IsA("ImageLabel") then
            j.ImageTransparency = v3
            v1 = if j.Name ~= "IconStrokeImage" then v4 else v2
            j.ImageColor3 = v1
        end
    end
end

function u104.ResolveImages(a1) -- Line: 192 -- upvalues: AssetItem (val), Assets (val), imagesFor (val)
    assert((AssetItem.AssetItemData(a1)))
    local v1 = Assets.Directory[a1.Category]
    local v2 = ("no asset directory entry for category %*"):format(a1.Category)
    assert(v1 ~= nil, v2)
    return (imagesFor(v1, a1))
end

function u104.Paint(a1, a2) -- Line: 200
    -- upvalues: u84 (val), AssetItem (val), Assets (val), imagesFor (val), u64 (val), u104 (val), u52 (val), u44 (val)
    -- upvalues: u48 (val), u60 (val), u69 (val), u56 (val)
    u84(a1)
    assert((AssetItem.AssetItemData(a2)))
    local v1 = Assets.Directory[a2.Category]
    local v2 = ("no asset directory entry for category %*"):format(a2.Category)
    assert(v1 ~= nil, v2)
    local v3 = imagesFor(v1, a2)
    local Icon = v3.Icon
    local v4 = 1
    v2 = u64
    assert(v2, "the icon zoom offset fell through its own default")
    u104.Strip(a1)
    a1.BackgroundTransparency = 1
    a1.ScaleType = Enum.ScaleType.Fit
    if v4 <= 1 then
        a1.Image = Icon
        a1.ImageTransparency = 0
        if v3.RainbowOverlay ~= nil then
            u104.OverlayRainbow(a1, v3.RainbowOverlay)
        end
        return
    end
    a1.Image = ""
    a1.ImageTransparency = 1
    local Frame = Instance.new("Frame")
    Frame.Name = "AssetIconShapeLayer"
    Frame.Size = u52
    Frame.Position = u44
    Frame.AnchorPoint = u48
    Frame.BackgroundTransparency = 1
    Frame.ZIndex = a1.ZIndex
    Frame.Parent = a1
    local v5 = u60
    local ZIndex = a1.ZIndex
    local v6 = Instance.new("CanvasGroup")
    v6.Name = "IconStrokeFrame"
    v6.Size = v5
    v6.Position = u44
    v6.AnchorPoint = u48
    v6.BackgroundTransparency = 1
    v6.ClipsDescendants = true
    v6.ZIndex = ZIndex
    v6.Parent = Frame
    local ZIndex_2 = a1.ZIndex
    v5 = Instance.new("ImageLabel")
    v5.Name = "IconStrokeImage"
    v5.Image = Icon
    v5.Size = UDim2.fromScale(v4, v4)
    v5.Position = u44 + v2
    v5.AnchorPoint = u48
    v5.BackgroundTransparency = 1
    v5.ScaleType = Enum.ScaleType.Fit
    v5.ZIndex = ZIndex_2
    v5.ImageColor3 = u69
    v5.Parent = v6
    local v7 = u56
    local v8 = a1.ZIndex + 1
    v5 = Instance.new("CanvasGroup")
    v5.Name = "IconClipFrame"
    v5.Size = v7
    v5.Position = u44
    v5.AnchorPoint = u48
    v5.BackgroundTransparency = 1
    v5.ClipsDescendants = true
    v5.ZIndex = v8
    v5.Parent = Frame
    v8 = a1.ZIndex + 1
    v6 = Instance.new("ImageLabel")
    v6.Name = "IconImage"
    v6.Image = Icon
    v6.Size = UDim2.fromScale(v4, v4)
    v6.Position = u44 + v2
    v6.AnchorPoint = u48
    v6.BackgroundTransparency = 1
    v6.ScaleType = Enum.ScaleType.Fit
    v6.ZIndex = v8
    v6.Parent = v5
    if v3.RainbowOverlay ~= nil then
        u104.OverlayRainbow(v6, v3.RainbowOverlay)
    end
end

function u104.WireHoverSquash(a1, a2, a3) -- Line: 254
    -- upvalues: u98 (val), u84 (val), u103 (val), Trove (val), TweenService (val), u79 (val), u74 (val)
    u98(a1)
    u84(a2)
    u103(a3)
    local Size = a2.Size
    local v1 = Trove.new()
    local u16 = nil

    local function applyScaleType(a1) -- Line: 276 -- upvalues: a2 (val)
        a2.ScaleType = a1
        for i, j in a2:GetDescendants() do
            if j:IsA("ImageLabel") then
                j.ScaleType = a1
            end
        end
    end

    local function snapTo(a1) -- Line: 285
        -- upvalues: u16 (ref), a2 (val), Size (val), applyScaleType (val)
        local v1 = u16
        if v1 then
            v1:Cancel()
            v1:Destroy()
            u16 = nil
        end
        if not a2 then
            return
        end
        v1 = a1 or Size
        if v1 then
            a2.Size = v1
        end
        applyScaleType(Enum.ScaleType.Fit)
    end

    local function relax(a1) -- Line: 298
        -- upvalues: a2 (val), Size (val), u16 (ref), applyScaleType (val), TweenService (upval), u79 (upval)
        local v1
        if a2 and Size then
            if a1 ~= false then
                v1 = u16
                if v1 then
                    v1:Cancel()
                    v1:Destroy()
                    u16 = nil
                end
                v1 = TweenService:Create(a2, u79, {Size = Size})
                u16 = v1
                v1.Completed:Once(function(a1) -- Line: 312 -- upvalues: applyScaleType (upval), u16 (upval)
                    if a1 == Enum.PlaybackState.Cancelled then
                        return
                    end
                    applyScaleType(Enum.ScaleType.Fit)
                    u16 = nil
                end)
                v1:Play()
                return
            end
            local v2 = u16
            if v2 then
                v2:Cancel()
                v2:Destroy()
                u16 = nil
            end
            if not a2 then
                return
            end
            v2 = Size or Size
            if v2 then
                a2.Size = v2
            end
            applyScaleType(Enum.ScaleType.Fit)
            return
        end
        v1 = u16
        if v1 then
            v1:Cancel()
            v1:Destroy()
            u16 = nil
        end
        if not a2 then
            return
        end
        v1 = Size
        if v1 then
            a2.Size = v1
        end
        applyScaleType(Enum.ScaleType.Fit)
    end

    v1:Add(function() -- Line: 267 -- upvalues: u16 (ref)
        local v1 = u16
        if v1 then
            v1:Cancel()
            v1:Destroy()
            u16 = nil
        end
    end)
    v1:Connect(a1.MouseEnter, function() -- Line: 322
        -- upvalues: a2 (val), a3 (val), u16 (ref), applyScaleType (val), TweenService (upval), u74 (upval), Size (val)
        if not a2 then
            return
        end
        if a3 and not a3() then
            return
        end
        local v1 = u16
        if v1 then
            v1:Cancel()
            v1:Destroy()
            u16 = nil
        end
        applyScaleType(Enum.ScaleType.Stretch)
        v1 = TweenService
        local v2 = a2
        local v3 = u74
        local v4 = {}
        local v5 = Size
        v4.Size = UDim2.new(v5.X.Scale * 1.2, v5.X.Offset * 1.2, v5.Y.Scale * 0.43, v5.Y.Offset * 0.43)
        v1 = v1:Create(v2, v3, v4)
        u16 = v1
        v1:Play()
    end)
    v1:Connect(a1.MouseLeave, relax)
    v1:Connect(a1.InputEnded, function(a1) -- Line: 340 -- upvalues: relax (val)
        local v1 = true
        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = a1.UserInputType == Enum.UserInputType.Touch
        end
        if v1 then
            relax()
        end
    end)
    return v1, relax
end

return u104