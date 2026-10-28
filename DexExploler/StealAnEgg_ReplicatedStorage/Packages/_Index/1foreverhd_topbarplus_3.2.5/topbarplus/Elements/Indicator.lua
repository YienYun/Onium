-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Elements.Indicator
-- Decompile time: 2.76 ms

return function(a1, a2) -- Line: 1
    local widget = a1.widget
    local v1 = a1:getInstance("Contents")
    local Frame = Instance.new("Frame")
    Frame.Name = "Indicator"
    Frame.LayoutOrder = 9999999
    Frame.ZIndex = 6
    Frame.Size = UDim2.new(0, 42, 0, 42)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(1, 0, 0.5, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Parent = v1
    local u40 = Instance.new("Frame")
    u40.Name = "IndicatorButton"
    u40.BorderColor3 = Color3.fromRGB(0, 0, 0)
    u40.AnchorPoint = Vector2.new(0.5, 0.5)
    u40.BorderSizePixel = 0
    u40.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    u40.Parent = Frame
    local GuiService = game:GetService("GuiService")
    local GamepadService = game:GetService("GamepadService")
    local u70 = a1:getInstance("ClickRegion")

    local function selectionChanged() -- Line: 27 -- upvalues: GuiService (val), u70 (val), u40 (val)
        if GuiService.SelectedObject == u70 then
            u40.BackgroundTransparency = 1
            u40.Position = UDim2.new(0.5, -2, 0.5, 0)
            u40.Size = UDim2.fromScale(1.2, 1.2)
            return
        end
        u40.BackgroundTransparency = 0.75
        u40.Position = UDim2.new(0.5, 2, 0.5, 0)
        u40.Size = UDim2.fromScale(1, 1)
    end

    a1.janitor:add(((GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(selectionChanged)))
    selectionChanged()
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
    ImageLabel.Parent = u40
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = u40
    local UserInputService = game:GetService("UserInputService")

    local function setIndicatorVisible(a1_2) -- Line: 57 -- upvalues: Frame (val), GamepadService (val), a1 (val)
        if a1_2 == nil then
            a1_2 = Frame.Visible
        end
        if GamepadService.GamepadCursorEnabled then
            a1_2 = false
        end
        if a1_2 then
            a1:modifyTheme({"PaddingRight", "Size", UDim2.new(0, 0, 1, 0)}, "IndicatorPadding")
        elseif Frame.Visible then
            a1:removeModification("IndicatorPadding")
        end
        a1:modifyTheme({"Indicator", "Visible", a1_2})
        a1.updateSize:Fire()
    end

    a1.janitor:add(((GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled")):Connect(setIndicatorVisible)))
    a1.indicatorSet:Connect(function(a1) -- Line: 73 -- upvalues: ImageLabel (val), UserInputService (val), setIndicatorVisible (val)
        local v1 = false
        if a1 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode(a1)
            v1 = true
        end
        setIndicatorVisible(v1)
    end)
    ;(widget:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 82 -- upvalues: widget (val), Frame (val)
        local v1 = widget.AbsoluteSize.Y * 0.96
        Frame.Size = UDim2.new(0, v1, 0, v1)
    end)
    local v2 = widget.AbsoluteSize.Y * 0.96
    Frame.Size = UDim2.new(0, v2, 0, v2)
    return Frame
end