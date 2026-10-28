-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Elements.Widget
-- Decompile time: 16.73 ms

return function(a1, a2) -- Line: 6
    local Frame = Instance.new("Frame")
    Frame:SetAttribute("WidgetUID", a1.UID)
    Frame.Name = "Widget"
    Frame.BackgroundTransparency = 1
    Frame.Visible = true
    Frame.ZIndex = 20
    Frame.Active = false
    Frame.ClipsDescendants = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IconButton"
    Frame_2.Visible = true
    Frame_2.ZIndex = 2
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = Frame
    Frame_2.ClipsDescendants = true
    Frame_2.Active = false
    a1.deselected:Connect(function() -- Line: 25 -- upvalues: Frame_2 (val), a1 (val)
        Frame_2.ClipsDescendants = true
        task.delay(0.2, function() -- Line: 27 -- upvalues: a1 (upval), Frame_2 (upval)
            if a1.isSelected then
                Frame_2.ClipsDescendants = false
            end
        end)
    end)
    local GuiService = game:GetService("GuiService")
    a1:setBehaviour("IconButton", "BackgroundTransparency", function(a1) -- Line: 36 -- upvalues: GuiService (val)
        local v1 = a1 * GuiService.PreferredTransparency
        if a1 == 1 then
            return a1
        end
        return v1
    end)
    a1.janitor:add(((GuiService:GetPropertyChangedSignal("PreferredTransparency")):Connect(function() -- Line: 44 -- upvalues: a1 (val), Frame_2 (val)
        a1:refreshAppearance(Frame_2, "BackgroundTransparency")
    end)))
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Name = "UICorner"
    UICorner.Parent = Frame_2
    local u68 = require(script.Parent.Menu)(a1)
    local MenuUIListLayout = u68.MenuUIListLayout
    local MenuGap = u68.MenuGap
    u68.Parent = Frame_2
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "IconSpot"
    Frame_3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    Frame_3.BackgroundTransparency = 0.9
    Frame_3.Visible = true
    Frame_3.AnchorPoint = Vector2.new(0, 0.5)
    Frame_3.ZIndex = 5
    Frame_3.Parent = u68
    UICorner:Clone().Parent = Frame_3
    local v1 = Frame_3:Clone()
    v1.UICorner.Name = "OverlayUICorner"
    v1.Name = "IconOverlay"
    v1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v1.ZIndex = Frame_3.ZIndex + 1
    v1.Size = UDim2.new(1, 0, 1, 0)
    v1.Position = UDim2.new(0, 0, 0, 0)
    v1.AnchorPoint = Vector2.new(0, 0)
    v1.Visible = false
    v1.Parent = Frame_3
    local TextButton = Instance.new("TextButton")
    TextButton:SetAttribute("CorrespondingIconUID", a1.UID)
    TextButton.Name = "ClickRegion"
    TextButton.BackgroundTransparency = 1
    TextButton.Visible = true
    TextButton.Text = ""
    TextButton.ZIndex = 20
    TextButton.Selectable = true
    TextButton.SelectionGroup = true
    TextButton.Parent = Frame_3
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton)
    UICorner:Clone().Parent = TextButton
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "Contents"
    Frame_4.BackgroundTransparency = 1
    Frame_4.Size = UDim2.fromScale(1, 1)
    Frame_4.Parent = Frame_3
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "ContentsList"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = Frame_4
    local Frame_5 = Instance.new("Frame")
    Frame_5.Name = "PaddingLeft"
    Frame_5.LayoutOrder = 1
    Frame_5.ZIndex = 5
    Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.BackgroundTransparency = 1
    Frame_5.BorderSizePixel = 0
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.Parent = Frame_4
    local Frame_6 = Instance.new("Frame")
    Frame_6.Name = "PaddingCenter"
    Frame_6.LayoutOrder = 3
    Frame_6.ZIndex = 5
    Frame_6.Size = UDim2.new(0, 0, 1, 0)
    Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_6.BackgroundTransparency = 1
    Frame_6.BorderSizePixel = 0
    Frame_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_6.Parent = Frame_4
    local Frame_7 = Instance.new("Frame")
    Frame_7.Name = "PaddingRight"
    Frame_7.LayoutOrder = 5
    Frame_7.ZIndex = 5
    Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_7.BackgroundTransparency = 1
    Frame_7.BorderSizePixel = 0
    Frame_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_7.Parent = Frame_4
    local Frame_8 = Instance.new("Frame")
    Frame_8.Name = "IconLabelContainer"
    Frame_8.LayoutOrder = 4
    Frame_8.ZIndex = 3
    Frame_8.AnchorPoint = Vector2.new(0, 0.5)
    Frame_8.Size = UDim2.new(0, 0, 0.5, 0)
    Frame_8.BackgroundTransparency = 1
    Frame_8.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame_8.Parent = Frame_4
    local TextLabel = Instance.new("TextLabel")
    local u259 = workspace.CurrentCamera.ViewportSize.X + 200
    TextLabel.Name = "IconLabel"
    TextLabel.LayoutOrder = 4
    TextLabel.ZIndex = 15
    TextLabel.AnchorPoint = Vector2.new(0, 0)
    TextLabel.Size = UDim2.new(0, u259, 1, 0)
    TextLabel.ClipsDescendants = false
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale(0, 0)
    TextLabel.RichText = true
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.TextScaled = false
    TextLabel.Active = false
    TextLabel.AutoLocalize = true
    TextLabel.Parent = Frame_8
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "IconImage"
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Active = false
    ImageLabel.Parent = Frame_4
    local v2 = UICorner:Clone()
    v2:SetAttribute("Collective", nil)
    v2.CornerRadius = UDim.new(0, 0)
    v2.Name = "IconImageCorner"
    v2.Parent = ImageLabel
    local TweenService = game:GetService("TweenService")
    local u335 = 0
    local u346 = require(script.Parent.Parent.Utility).createStagger(0.01, function(a1_2) -- Line: 195
        -- upvalues: a1 (val), TextLabel (val), ImageLabel (val), Frame_8 (val), Frame_5 (val), Frame_6 (val)
        -- upvalues: Frame_7 (val), Frame_2 (val), UIListLayout (val), Frame_4 (val), Frame (val), u259 (val), u68 (val)
        -- upvalues: Frame_3 (val), MenuUIListLayout (val), MenuGap (val), TweenService (val), TextButton (val)
        -- upvalues: u335 (ref), a2 (val)
        task.defer(function() -- Line: 202
            -- upvalues: a1 (upval), TextLabel (upval), ImageLabel (upval), Frame_8 (upval), Frame_5 (upval)
            -- upvalues: Frame_6 (upval), Frame_7 (upval), Frame_2 (upval), UIListLayout (upval), Frame_4 (upval)
            -- upvalues: Frame (upval), u259 (upval), u68 (upval), Frame_3 (upval), MenuUIListLayout (upval)
            -- upvalues: MenuGap (upval), TweenService (upval), TextButton (upval), u335 (upval), a2 (upval)
            local Left, v1
            local indicator = a1.indicator
            local Visible = indicator and indicator.Visible
            local v2 = Visible or TextLabel.Text ~= ""
            local v3 = false
            if ImageLabel.Image ~= "" then
                v3 = ImageLabel.Image ~= nil
            end
            local Center = Enum.HorizontalAlignment.Center
            local v4 = UDim2.fromScale(1, 1)
            if not v3 then
                if v3 then
                    if v3 and v2 then
                        Frame_8.Visible = true
                        ImageLabel.Visible = true
                        Frame_5.Visible = true
                        Frame_6.Visible = not Visible
                        Frame_7.Visible = not Visible
                        Left = Enum.HorizontalAlignment.Left
                    end
                elseif v2 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = false
                    Frame_5.Visible = true
                    Frame_6.Visible = false
                    Frame_7.Visible = true
                elseif v3 and v2 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = true
                    Frame_5.Visible = true
                    Frame_6.Visible = not Visible
                    Frame_7.Visible = not Visible
                    Left = Enum.HorizontalAlignment.Left
                end
            elseif not v2 then
                Frame_8.Visible = false
                ImageLabel.Visible = true
                Frame_5.Visible = false
                Frame_6.Visible = false
                Frame_7.Visible = false
            elseif v3 then
                if v3 and v2 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = true
                    Frame_5.Visible = true
                    Frame_6.Visible = not Visible
                    Frame_7.Visible = not Visible
                    Left = Enum.HorizontalAlignment.Left
                end
            elseif v2 then
                Frame_8.Visible = true
                ImageLabel.Visible = false
                Frame_5.Visible = true
                Frame_6.Visible = false
                Frame_7.Visible = true
            elseif v3 and v2 then
                Frame_8.Visible = true
                ImageLabel.Visible = true
                Frame_5.Visible = true
                Frame_6.Visible = not Visible
                Frame_7.Visible = not Visible
                Left = Enum.HorizontalAlignment.Left
            end
            Frame_2.Size = v4

            local function getItemWidth(a1) -- Line: 232
                return a1:GetAttribute("TargetWidth") or a1.AbsoluteSize.X
            end

            local Offset = UIListLayout.Padding.Offset
            v3 = Offset
            Frame_8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0)
            for k, v in pairs(Frame_4:GetChildren()) do
                if v:IsA("GuiObject") and v.Visible == true then
                    v3 = v3 + ((v:GetAttribute("TargetWidth") or v.AbsoluteSize.X) + Offset)
                end
            end
            local v5 = Frame:GetAttribute("MinimumWidth")
            v2 = Frame:GetAttribute("MinimumHeight")
            local Attribute = Frame:GetAttribute("BorderSize")
            local v6 = math.clamp(v3, v5, u259)
            local v7 = 0
            local isSelected = #a1.menuIcons > 0 and a1.isSelected
            if isSelected then
                local Attribute_2
                for k2, i in pairs(u68:GetChildren()) do
                    if i ~= Frame_3 and i:IsA("GuiObject") and i.Visible then
                        Attribute_2 = i:GetAttribute("TargetWidth") or i.AbsoluteSize.X
                        v7 = v7 + (Attribute_2 + MenuUIListLayout.Padding.Offset)
                    end
                end
                if not Frame_3.Visible then
                    v1 = Frame_3
                    v6 = v6 - ((v1:GetAttribute("TargetWidth") or v1.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + Attribute)
                end
                v7 = v7 - Attribute * 0.5
                v6 = v6 + (v7 - Attribute * 0.75)
            end
            MenuGap.Visible = isSelected and Frame_3.Visible
            local Attribute_3 = Frame:GetAttribute("DesiredWidth")
            if Attribute_3 and v6 < Attribute_3 then
                v6 = Attribute_3
            end
            a1.updateMenu:Fire()
            v7 = (math.max(v6 - v7, v5)) - Attribute * 2
            local Attribute_4 = u68:GetAttribute("MenuWidth")
            v3 = Attribute_4 and Attribute_4 + v7 + MenuUIListLayout.Padding.Offset + 10
            if v3 then
                local Attribute_5 = u68:GetAttribute("MaxWidth")
                if Attribute_5 then
                    v3 = math.max(Attribute_5, v5)
                end
                u68:SetAttribute("MenuCanvasWidth", v6)
                if v3 < v6 then
                    v6 = v3
                end
            end
            local Quint = Enum.EasingStyle.Quint
            local Out = Enum.EasingDirection.Out
            v1 = Frame_3
            local v8 = math.max(v7, v1:GetAttribute("TargetWidth") or v1.AbsoluteSize.X, Frame_3.AbsoluteSize.X)
            local v9 = Frame
            local v10 = math.max(v6, v9:GetAttribute("TargetWidth") or v9.AbsoluteSize.X, Frame.AbsoluteSize.X)
            v4 = TweenInfo.new(v8 / 750, Quint, Out)
            v8 = TweenInfo.new(v10 / 750, Quint, Out)
            TweenService:Create(Frame_3, v4, {
                Position = UDim2.new(0, Attribute, 0.5, 0),
                Size = UDim2.new(0, v7, 1, -Attribute * 2),
            }):Play()
            TweenService:Create(TextButton, v4, {Size = UDim2.new(0, v7, 1, 0)}):Play()
            v10 = UDim2.fromOffset(v6, v2)
            if Frame.Size.Y.Offset ~= v2 then
                Frame.Size = v10
            end
            Frame:SetAttribute("TargetWidth", v10.X.Offset)
            TweenService:Create(Frame, v8, {Size = v10}):Play()
            u335 = u335 + 1
            local v11 = v8.Time * 100
            for j = 1, v11 do
                task.delay(j / 100, function() -- Line: 314 -- upvalues: a2 (upval), a1 (upval)
                    local v1 = a1
                    a2.iconChanged:Fire(v1)
                end)
            end
            task.delay(v8.Time - 0.2, function() -- Line: 318 -- upvalues: u335 (upval), a1 (upval)
                u335 = u335 - 1
                task.defer(function() -- Line: 320 -- upvalues: u335 (upval), a1 (upval)
                    if u335 == 0 then
                        a1.resizingComplete:Fire()
                    end
                end)
            end)
            a1:updateParent()
        end)
    end)
    local u347 = true
    a1:setBehaviour("IconLabel", "Text", u346)
    a1:setBehaviour("IconLabel", "FontFace", function(a1) -- Line: 333 -- upvalues: TextLabel (val), u346 (val), u347 (ref)
        if TextLabel.FontFace == a1 then
            return
        end
        task.spawn(function() -- Line: 338 -- upvalues: u346 (upval), u347 (upval)
            u346()
            if u347 then
                u347 = false
                for i = 1, 10 do
                    task.wait(1)
                    u346()
                end
            end
        end)
    end)

    local function updateBorderSize() -- Line: 360
        -- upvalues: Frame (val), a1 (val), Frame_3 (val), u68 (val), MenuGap (val), MenuUIListLayout (val), u346 (val)
        task.defer(function() -- Line: 361
            -- upvalues: Frame (upval), a1 (upval), Frame_3 (upval), u68 (upval), MenuGap (upval)
            -- upvalues: MenuUIListLayout (upval), u346 (upval)
            local Attribute = Frame:GetAttribute("BorderSize")
            local alignment = a1.alignment
            local v1 = if Frame_3.Visible ~= false then not (alignment ~= "Right") and -Attribute or Attribute else 0
            u68.Position = UDim2.new(0, v1, 0, 0)
            MenuGap.Size = UDim2.fromOffset(Attribute, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            u346()
        end)
    end

    a1:setBehaviour("Widget", "BorderSize", updateBorderSize)
    a1:setBehaviour("IconSpot", "Visible", updateBorderSize)
    a1.startMenuUpdate:Connect(u346)
    a1.updateSize:Connect(u346)
    a1:setBehaviour("ContentsList", "HorizontalAlignment", u346)
    a1:setBehaviour("Widget", "Visible", u346)
    a1:setBehaviour("Widget", "DesiredWidth", u346)
    a1:setBehaviour("Widget", "MinimumWidth", u346)
    a1:setBehaviour("Widget", "MinimumHeight", u346)
    a1:setBehaviour("Indicator", "Visible", u346)
    a1:setBehaviour("IconImageRatio", "AspectRatio", u346)
    a1:setBehaviour("IconImage", "Image", function(a1) -- Line: 382 -- upvalues: ImageLabel (val), u346 (val)
        local v1 = tonumber(a1) and "http://www.roblox.com/asset/?id=" .. a1 or a1 or ""
        if ImageLabel.Image ~= v1 then
            u346()
        end
        return v1
    end)
    a1.alignmentChanged:Connect(function(a1_2) -- Line: 389
        -- upvalues: MenuUIListLayout (val), Frame (val), a1 (val), Frame_3 (val), u68 (val), MenuGap (val), u346 (val)
        if a1_2 == "Center" then
            a1_2 = "Left"
        end
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[a1_2]
        task.defer(function() -- Line: 361
            -- upvalues: Frame (upval), a1 (upval), Frame_3 (upval), u68 (upval), MenuGap (upval)
            -- upvalues: MenuUIListLayout (upval), u346 (upval)
            local Attribute = Frame:GetAttribute("BorderSize")
            local alignment = a1.alignment
            local v1 = if Frame_3.Visible ~= false then not (alignment ~= "Right") and -Attribute or Attribute else 0
            u68.Position = UDim2.new(0, v1, 0, 0)
            MenuGap.Size = UDim2.fromOffset(Attribute, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            u346()
        end)
    end)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local LocaleId = LocalPlayer.LocaleId
    a1.janitor:add(((LocalPlayer:GetPropertyChangedSignal("LocaleId")):Connect(function() -- Line: 401 -- upvalues: LocalPlayer (val), LocaleId (ref), a1 (val)
        task.delay(0.2, function() -- Line: 402 -- upvalues: LocalPlayer (upval), LocaleId (upval), a1 (upval)
            local LocaleId_2 = LocalPlayer.LocaleId
            if LocaleId_2 ~= LocaleId then
                LocaleId = LocaleId_2
                a1:refresh()
                task.wait(0.5)
                a1:refresh()
            end
        end)
    end)))
    local u459 = Instance.new("NumberValue")
    u459.Name = "IconImageScale"
    u459.Parent = ImageLabel
    ;(u459:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 416 -- upvalues: ImageLabel (val), u459 (val)
        ImageLabel.Size = UDim2.new(u459.Value, 0, u459.Value, 0)
    end)
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Name = "IconImageRatio"
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = ImageLabel
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Name = "IconGradient"
    UIGradient.Enabled = true
    UIGradient.Parent = Frame_2
    local UIGradient_2 = Instance.new("UIGradient")
    UIGradient_2.Name = "IconSpotGradient"
    UIGradient_2.Enabled = true
    UIGradient_2.Parent = Frame_3
    return Frame
end