-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Elements.Dropdown
-- Decompile time: 5.47 ms

return function(a1) -- Line: 2
    local updateMaxIcons
    local Frame = Instance.new("Frame")
    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = a1.widget
    local GuiService = game:GetService("GuiService")
    a1:setBehaviour("Dropdown", "BackgroundTransparency", function(a1) -- Line: 16 -- upvalues: GuiService (val)
        local v1 = a1 * GuiService.PreferredTransparency
        if a1 == 1 then
            return a1
        end
        return v1
    end)
    a1.janitor:add(((GuiService:GetPropertyChangedSignal("PreferredTransparency")):Connect(function() -- Line: 24 -- upvalues: a1 (val), Frame (val)
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
    a1.dropdownChildAdded:Connect(function(a1) -- Line: 72
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
        task.defer(function() -- Line: 87 -- upvalues: a1 (val), u75 (val)
            a1.joinJanitor:add(function() -- Line: 88 -- upvalues: a1 (upval), u75 (upval)
                a1:removeModification(u75)
            end)
        end)
    end)
    a1.dropdownSet:Connect(function(a1_2) -- Line: 93 -- upvalues: a1 (val), iconModule (val)
        for k, v in pairs(a1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy()
        end
        if type(a1_2) == "table" then
            for k2, i in pairs(a1_2) do
                i:joinDropdown(a1)
            end
        end
    end)
    local Utility = require(script.Parent.Parent.Utility)
    dropdownJanitor:add((a1.toggled:Connect(function() -- Line: 109 -- upvalues: Utility (val), Frame (val), a1 (val)
        Utility.setVisible(Frame, a1.isSelected, "InternalDropdown")
    end)))
    Utility.setVisible(Frame, a1.isSelected, "InternalDropdown")
    local u146 = 0
    local u147 = false

    function updateMaxIcons() -- Line: 121
        -- upvalues: u146 (ref), u147 (ref), updateMaxIcons (val), Frame (val), ScrollingFrame (val), iconModule (val)
        -- upvalues: a1 (val), UIPadding (val)
        local Attribute_2, Y, v1, v2, v3
        u146 = u146 + 1
        if u147 then
            return
        end
        local u3 = u146
        u147 = true
        task.defer(function() -- Line: 129 -- upvalues: u147 (upval), u146 (upval), u3 (val), updateMaxIcons (upval)
            u147 = false
            if u146 ~= u3 then
                updateMaxIcons()
            end
        end)
        local Attribute = Frame:GetAttribute("MaxIcons")
        if not Attribute then
            return
        end
        local v4 = {}
        for k, v in pairs(ScrollingFrame:GetChildren()) do
            if v:IsA("GuiObject") then
                table.insert(v4, {v, v.AbsolutePosition.Y})
            end
        end
        table.sort(v4, function(a1, a2) -- Line: 146
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
        v5 = v5 + UIPadding.PaddingTop.Offset
        v5 = v5 + UIPadding.PaddingBottom.Offset
        ScrollingFrame.Size = UDim2.fromOffset(0, v5)
    end

    dropdownJanitor:add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(updateMaxIcons)))
    dropdownJanitor:add((ScrollingFrame.ChildAdded:Connect(updateMaxIcons)))
    dropdownJanitor:add((ScrollingFrame.ChildRemoved:Connect(updateMaxIcons)))
    dropdownJanitor:add(((Frame:GetAttributeChangedSignal("MaxIcons")):Connect(updateMaxIcons)))
    dropdownJanitor:add((a1.childThemeModified:Connect(updateMaxIcons)))
    updateMaxIcons()
    return Frame
end