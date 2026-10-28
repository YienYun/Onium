-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Elements.Menu
-- Decompile time: 5.65 ms

return function(a1) -- Line: 1
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "Menu"
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Size = UDim2.fromScale(1, 1)
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.TopImage = ""
    ScrollingFrame.BottomImage = ""
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ZIndex = 20
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    local iconModule = require(a1.iconModule)
    local u46 = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
    u46.Name = "MenuUIListLayout"
    u46.VerticalAlignment = Enum.VerticalAlignment.Center
    u46.Parent = ScrollingFrame
    local Frame = Instance.new("Frame")
    Frame.Name = "MenuGap"
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.AnchorPoint = Vector2.new(0, 0.5)
    Frame.ZIndex = 5
    Frame.Parent = ScrollingFrame
    local u60 = false
    local u68 = require(script.Parent.Parent.Features.Themes)
    a1.menuChildAdded:Connect(function() -- Line: 39 -- upvalues: a1 (val), u60 (ref), ScrollingFrame (val), u68 (val), u46 (val)
        local u30
        local menuJanitor = a1.menuJanitor
        local v1 = #a1.menuIcons
        if u60 then
            if v1 <= 0 then
                menuJanitor:clean()
                u60 = false
            end
            return
        end
        u60 = true
        menuJanitor:add((a1.toggled:Connect(function() -- Line: 53 -- upvalues: a1 (upval)
            if #a1.menuIcons > 0 then
                a1.updateSize:Fire()
            end
        end)))
        _, u30 = a1:modifyTheme({{"Menu", "Active", true}})
        task.defer(function() -- Line: 63 -- upvalues: menuJanitor (val), a1 (upval), u30 (val)
            menuJanitor:add(function() -- Line: 64 -- upvalues: a1 (upval), u30 (upval)
                a1:removeModification(u30)
            end)
        end)
        local X = ScrollingFrame.AbsoluteCanvasSize.X

        local function rightAlignCanvas() -- Line: 73 -- upvalues: a1 (upval), ScrollingFrame (upval), X (ref)
            if a1.alignment == "Right" then
                local X_2 = ScrollingFrame.AbsoluteCanvasSize.X
                local v1 = X - X_2
                X = X_2
                ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v1, 0)
            end
        end

        menuJanitor:add((a1.selected:Connect(rightAlignCanvas)))
        menuJanitor:add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(rightAlignCanvas)))
        local v2 = a1:getStateGroup()
        if (u68.getThemeValue(v2, "IconImage", "Image", "Deselected")) == u68.getThemeValue(v2, "IconImage", "Image", "Selected") then
            v2 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
            a1:removeModificationWith("IconLabel", "Text", "Viewing")
            a1:removeModificationWith("IconLabel", "Image", "Viewing")
            a1:modifyTheme({
                {"IconLabel", "FontFace", v2, "Selected"},
                {"IconLabel", "Text", "X", "Selected"},
                {"IconLabel", "TextSize", 20, "Selected"},
                {"IconLabel", "TextStrokeTransparency", 0.8, "Selected"},
                {"IconImage", "Image", "", "Selected"},
            })
        end
        local u133 = a1:getInstance("MenuGap")
        menuJanitor:add((a1.alignmentChanged:Connect(function() -- Line: 104 -- upvalues: a1 (upval), u133 (val)
            local v1 = -99999
            local v2 = -99998
            if a1.alignment == "Right" then
                v1 = 99999
                v2 = 99998
            end
            a1:modifyTheme({"IconSpot", "LayoutOrder", v1})
            u133.LayoutOrder = v2
        end)))
        local v3 = -99999
        local v4 = -99998
        if a1.alignment == "Right" then
            v3 = 99999
            v4 = 99998
        end
        a1:modifyTheme({"IconSpot", "LayoutOrder", v3})
        u133.LayoutOrder = v4
        ;(ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth")):Connect(function() -- Line: 120 -- upvalues: ScrollingFrame (upval)
            local Attribute = ScrollingFrame:GetAttribute("MenuCanvasWidth")
            local Y = ScrollingFrame.CanvasSize.Y
            ScrollingFrame.CanvasSize = UDim2.new(0, Attribute, Y.Scale, Y.Offset)
        end)
        menuJanitor:add((a1.updateMenu:Connect(function() -- Line: 125 -- upvalues: ScrollingFrame (upval), u46 (upval)
            local v1
            local Attribute = ScrollingFrame:GetAttribute("MaxIcons")
            if not Attribute then
                return
            end
            local v2 = {}
            for k, v in pairs(ScrollingFrame:GetChildren()) do
                if v:GetAttribute("WidgetUID") and v.Visible then
                    table.insert(v2, {v, v.AbsolutePosition.X})
                end
            end
            table.sort(v2, function(a1, a2) -- Line: 137
                return a1[2] < a2[2]
            end)
            local v3 = 0
            for i = 1, Attribute do
                v1 = v2[i]
                if not v1 then
                    break
                end
                v3 = v3 + (v1[1].AbsoluteSize.X + u46.Padding.Offset)
            end
            ScrollingFrame:SetAttribute("MenuWidth", v3)
        end)))

        local function startMenuUpdate() -- Line: 152 -- upvalues: a1 (upval)
            task.delay(0.1, function() -- Line: 153 -- upvalues: a1 (upval)
                a1.startMenuUpdate:Fire()
            end)
        end

        menuJanitor:add((ScrollingFrame.ChildAdded:Connect(startMenuUpdate)))
        menuJanitor:add((ScrollingFrame.ChildRemoved:Connect(startMenuUpdate)))
        menuJanitor:add(((ScrollingFrame:GetAttributeChangedSignal("MaxIcons")):Connect(startMenuUpdate)))
        menuJanitor:add(((ScrollingFrame:GetAttributeChangedSignal("MaxWidth")):Connect(startMenuUpdate)))
        task.delay(0.1, function() -- Line: 153 -- upvalues: a1 (upval)
            a1.startMenuUpdate:Fire()
        end)
    end)
    a1.menuSet:Connect(function(a1_2) -- Line: 165 -- upvalues: a1 (val), iconModule (val)
        for k, v in pairs(a1.menuIcons) do
            iconModule.getIconByUID(v):destroy()
        end
        if type(a1_2) == "table" then
            for k2, i in pairs(a1_2) do
                i:joinMenu(a1)
            end
        end
    end)
    return ScrollingFrame
end