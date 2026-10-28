-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Elements.Dropdown
-- Decompile time: 10.89 ms

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Themes = require(script.Parent.Parent.Features.Themes)
return function(a1) -- Line: 5 -- upvalues: Themes (val), TweenService (val), RunService (val)
    local updateMaxIconsListener
    local Frame = Instance.new("Frame")
    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = a1.widget
    local GuiService = game:GetService("GuiService")
    a1:setBehaviour("Dropdown", "BackgroundTransparency", function(a1) -- Line: 20 -- upvalues: GuiService (val)
        local v1 = a1 * GuiService.PreferredTransparency
        if a1 == 1 then
            return a1
        end
        return v1
    end)
    a1.janitor:add(((GuiService:GetPropertyChangedSignal("PreferredTransparency")):Connect(function() -- Line: 28 -- upvalues: a1 (val), Frame (val)
        a1:refreshAppearance(Frame, "BackgroundTransparency")
    end)))
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "DropdownCorner"
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "DropdownScroller"
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.ZIndex = -1
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.Visible = true
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    ScrollingFrame.Active = false
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Selectable = false
    ScrollingFrame.Active = true
    ScrollingFrame.Parent = Frame
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "DropdownSpeed"
    NumberValue.Value = 0.07
    NumberValue.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "DropdownPadding"
    UIPadding.PaddingTop = UDim.new(0, 0)
    UIPadding.PaddingBottom = UDim.new(0, 0)
    UIPadding.Parent = ScrollingFrame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "DropdownList"
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Parent = ScrollingFrame
    local dropdownJanitor = a1.dropdownJanitor
    local iconModule = require(a1.iconModule)
    a1.dropdownChildAdded:Connect(function(a1) -- Line: 81
        local u75
        _, u75 = a1:modifyTheme({
            {"Widget", "BorderSize", 0},
            {"IconCorners", "CornerRadius", UDim.new(0, 10)},
            {"Widget", "MinimumWidth", 190},
            {"Widget", "MinimumHeight", 58},
            {"IconLabel", "TextSize", 20},
            {"IconOverlay", "Size", UDim2.new(1, 0, 1, 0)},
            {"PaddingLeft", "Size", UDim2.fromOffset(25, 0)},
            {"Notice", "Position", UDim2.new(1, -24, 0, 5)},
            {"ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left},
            {"Selection", "Size", UDim2.new(1, -0, 1, -0)},
            {"Selection", "Position", UDim2.new(0, 0, 0, 0)},
        })
        task.defer(function() -- Line: 95 -- upvalues: a1 (val), u75 (val)
            a1.joinJanitor:add(function() -- Line: 96 -- upvalues: a1 (upval), u75 (upval)
                a1:removeModification(u75)
            end)
        end)
    end)
    a1.dropdownSet:Connect(function(a1_2) -- Line: 101 -- upvalues: a1 (val), iconModule (val)
        for k, v in pairs(a1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy()
        end
        if type(a1_2) == "table" then
            for k2, i in pairs(a1_2) do
                i:joinDropdown(a1)
            end
        end
    end)

    local function updateMaxIcons() -- Line: 113 -- upvalues: Frame (val), ScrollingFrame (val), UIPadding (val)
        local Y, v1
        local Attribute = Frame:GetAttribute("MaxIcons")
        if not Attribute then
            return 0
        end
        local v2 = {}
        for k, v in pairs(ScrollingFrame:GetChildren()) do
            if v:IsA("GuiObject") and v.Visible then
                table.insert(v2, v)
            end
        end
        table.sort(v2, function(a1, a2) -- Line: 124
            return a1.AbsolutePosition.Y < a2.AbsolutePosition.Y
        end)
        local v3 = 0
        local v4 = math.ceil(Attribute)
        for i = 1, v4 do
            v1 = v2[i]
            if not v1 then
                break
            end
            Y = v1.AbsoluteSize.Y
            v1 = false
            if i == v4 then
                v1 = v4 ~= Attribute
            end
            if v1 then
                Y = Y * (Attribute - v4 + 1)
            end
            v3 = v3 + Y
        end
        return v3 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
    end

    local u132 = nil
    local u133 = nil
    local u134 = nil
    local u135 = nil

    local function getTweenInfo() -- Line: 145
        -- upvalues: Themes (upval), Frame (val), u134 (ref), u135 (ref), NumberValue (val)
        local v1 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        if u134 and u134 == v1 and u135 then
            return u135
        end
        local v2 = TweenInfo.new(NumberValue.Value * v1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        u135 = v2
        u134 = v1
        return v2
    end

    local function updateVisibility() -- Line: 159
        -- upvalues: Themes (upval), Frame (val), u134 (ref), u135 (ref), NumberValue (val), u132 (ref), u133 (ref)
        -- upvalues: a1 (val), updateMaxIcons (val), TweenService (upval)
        local v1
        local v2 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        if not u134 or u134 ~= v2 or not u135 then
            local v3 = TweenInfo.new(NumberValue.Value * v2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            u135 = v3
            u134 = v2
            v1 = v3
        else
            v1 = u135
        end
        if u132 then
            u132:Cancel()
            u132 = nil
        end
        if u133 then
            u133:Cancel()
            u133 = nil
        end
        if not a1.isSelected then
            v2 = TweenInfo.new(0)
            u133 = TweenService:Create(Frame, v2, {Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)})
            u133:Play()
            u133.Completed:Connect(function() -- Line: 187 -- upvalues: u133 (upval)
                u133 = nil
            end)
            return
        end
        v2 = updateMaxIcons()
        Frame.Visible = true
        Frame.BackgroundTransparency = 0
        Frame.Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)
        u132 = TweenService:Create(Frame, v1, {Size = UDim2.new(0, Frame.Size.X.Offset, 0, v2)})
        u132:Play()
        u132.Completed:Connect(function() -- Line: 180 -- upvalues: u132 (upval)
            u132 = nil
        end)
    end

    dropdownJanitor:add((a1.toggled:Connect(updateVisibility)))
    updateVisibility()

    local function updateChildSize() -- Line: 197
        -- upvalues: Themes (upval), Frame (val), u134 (ref), u135 (ref), NumberValue (val), a1 (val), u132 (ref)
        -- upvalues: u133 (ref), RunService (upval), updateMaxIcons (val), TweenService (upval)
        local v1
        local v2 = Themes.getInstanceValue(Frame, "MaxIcons") or 1
        if not u134 or u134 ~= v2 or not u135 then
            local v3 = TweenInfo.new(NumberValue.Value * v2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            u135 = v3
            u134 = v2
            v1 = v3
        else
            v1 = u135
        end
        if not a1.isSelected then
            return
        end
        if u132 then
            u132:Cancel()
            u132 = nil
        end
        if u133 then
            u133:Cancel()
            u133 = nil
        end
        RunService.Heartbeat:Wait()
        v2 = updateMaxIcons()
        u132 = TweenService:Create(Frame, v1, {Size = UDim2.new(0, Frame.Size.X.Offset, 0, v2)})
        u132:Play()
        u132.Completed:Connect(function() -- Line: 215 -- upvalues: u132 (upval)
            u132 = nil
        end)
    end

    dropdownJanitor:add((a1.toggled:Connect(updateVisibility)))
    local u157 = 0
    local u158 = false

    function updateMaxIconsListener() -- Line: 228
        -- upvalues: u157 (ref), u158 (ref), updateMaxIconsListener (val), Frame (val), ScrollingFrame (val)
        -- upvalues: iconModule (val), a1 (val), UIPadding (val)
        local Attribute_2, Y, v1, v2, v3
        u157 = u157 + 1
        if u158 then
            return
        end
        local u3 = u157
        u158 = true
        task.defer(function() -- Line: 233 -- upvalues: u158 (upval), u157 (upval), u3 (val), updateMaxIconsListener (upval)
            u158 = false
            if u157 ~= u3 then
                updateMaxIconsListener()
            end
        end)
        local Attribute = Frame:GetAttribute("MaxIcons")
        if not Attribute then
            return
        end
        local v4 = {}
        for k, v in pairs(ScrollingFrame:GetChildren()) do
            if v:IsA("GuiObject") and v.Visible then
                table.insert(v4, {v, v.AbsolutePosition.Y})
            end
        end
        table.sort(v4, function(a1, a2) -- Line: 248
            return a1[2] < a2[2]
        end)
        local v5 = 0
        local v6 = false
        local v7 = math.ceil(Attribute)
        for i = 1, v7 do
            v3 = v4[i]
            if not v3 then
                break
            end
            v1 = v3[1]
            Y = v1.AbsoluteSize.Y
            v2 = false
            if i == v7 then
                v2 = v7 ~= Attribute
            end
            if v2 then
                Y = Y * (Attribute - v7 + 1)
            end
            v5 = v5 + Y
            if not v2 then
                Attribute_2 = v1:GetAttribute("WidgetUID")
                v1 = Attribute_2 and iconModule.getIconByUID(Attribute_2)
                if v1 then
                    v2 = nil
                    if not v6 then
                        v2 = a1:getInstance("ClickRegion")
                    end
                    v1:getInstance("ClickRegion").NextSelectionUp = v2
                end
            end
        end
        v5 = v5 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
        ScrollingFrame.Size = UDim2.fromOffset(0, v5)
    end

    dropdownJanitor:add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(updateMaxIconsListener)))
    dropdownJanitor:add((ScrollingFrame.ChildAdded:Connect(updateMaxIconsListener)))
    dropdownJanitor:add((ScrollingFrame.ChildRemoved:Connect(updateChildSize)))
    dropdownJanitor:add((ScrollingFrame.ChildRemoved:Connect(updateMaxIconsListener)))
    dropdownJanitor:add(((Frame:GetAttributeChangedSignal("MaxIcons")):Connect(updateMaxIconsListener)))
    dropdownJanitor:add(((Frame:GetAttributeChangedSignal("MaxIcons")):Connect(updateChildSize)))
    dropdownJanitor:add((a1.childThemeModified:Connect(updateMaxIconsListener)))
    updateMaxIconsListener()

    local function connectVisibilityListeners(a1) -- Line: 293 -- upvalues: updateChildSize (val)
        if a1:IsA("GuiObject") then
            (a1:GetPropertyChangedSignal("Visible")):Connect(updateChildSize)
            ;(a1:GetPropertyChangedSignal("Size")):Connect(updateChildSize)
        end
    end

    for k, v in pairs(ScrollingFrame:GetChildren()) do
        if v:IsA("GuiObject") then
            (v:GetPropertyChangedSignal("Visible")):Connect(updateChildSize)
            ;(v:GetPropertyChangedSignal("Size")):Connect(updateChildSize)
        end
    end
    ScrollingFrame.ChildAdded:Connect(function(a1) -- Line: 305 -- upvalues: RunService (upval), updateChildSize (val)
        RunService.Heartbeat:Wait()
        if a1:IsA("GuiObject") then
            (a1:GetPropertyChangedSignal("Visible")):Connect(updateChildSize)
            ;(a1:GetPropertyChangedSignal("Size")):Connect(updateChildSize)
        end
        updateChildSize()
    end)
    Frame.Visible = false
    return Frame
end