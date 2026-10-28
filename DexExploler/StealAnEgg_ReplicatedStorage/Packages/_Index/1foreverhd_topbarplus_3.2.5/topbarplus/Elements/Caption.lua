-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Elements.Caption
-- Decompile time: 9.52 ms

local u4 = Color3.fromRGB(39, 41, 48)
return function(a1) -- Line: 3 -- upvalues: u4 (val)
    local KeyboardEnabled, u262, v1, v2
    local u4_2 = a1:getInstance("ClickRegion")
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = "Caption"
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.BorderSizePixel = 0
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Position = UDim2.fromOffset(0, 0)
    CanvasGroup.Visible = true
    CanvasGroup.ZIndex = 30
    CanvasGroup.Parent = u4_2
    local Frame = Instance.new("Frame")
    Frame.Name = "Box"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundColor3 = u4
    Frame.Position = UDim2.fromOffset(4, 7)
    Frame.ZIndex = 12
    Frame.Parent = CanvasGroup
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Header"
    TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel_2.Text = "Caption"
    TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.TextSize = 15
    TextLabel_2.TextTruncate = Enum.TextTruncate.None
    TextLabel_2.TextWrapped = false
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.LayoutOrder = 1
    TextLabel_2.Size = UDim2.fromOffset(0, 16)
    TextLabel_2.ZIndex = 18
    TextLabel_2.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "Layout"
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "CaptionCorner"
    UICorner.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "Padding"
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingTop = UDim.new(0, 12)
    UIPadding.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Hotkeys"
    Frame_2.AutomaticSize = Enum.AutomaticSize.Y
    Frame_2.BackgroundTransparency = 1
    Frame_2.LayoutOrder = 3
    Frame_2.Size = UDim2.fromScale(1, 0)
    Frame_2.Visible = false
    Frame_2.Parent = Frame
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Name = "Layout1"
    UIListLayout_2.Padding = UDim.new(0, 6)
    UIListLayout_2.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Parent = Frame_2
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Key1"
    ImageLabel_2.Image = "rbxasset://textures/ui/Controls/key_single.png"
    ImageLabel_2.ImageTransparency = 0.7
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(5, 5, 23, 24)
    ImageLabel_2.AutomaticSize = Enum.AutomaticSize.X
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.LayoutOrder = 1
    ImageLabel_2.Size = UDim2.fromOffset(0, 30)
    ImageLabel_2.ZIndex = 15
    ImageLabel_2.Parent = Frame_2
    local UIPadding_2 = Instance.new("UIPadding")
    UIPadding_2.Name = "Inset"
    UIPadding_2.PaddingLeft = UDim.new(0, 8)
    UIPadding_2.PaddingRight = UDim.new(0, 8)
    UIPadding_2.Parent = ImageLabel_2
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AutoLocalize = false
    TextLabel.Name = "LabelContent"
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel.Text = ""
    TextLabel.TextColor3 = Color3.fromRGB(189, 190, 190)
    TextLabel.TextSize = 15
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromOffset(0, -1)
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.ZIndex = 16
    TextLabel.Parent = ImageLabel_2
    local u183 = Instance.new("ImageLabel")
    u183.Name = "Caret"
    u183.Image = "rbxasset://LuaPackages/Packages/_Index/FoundationImages/FoundationImages/SpriteSheets/img_set_2x_1.png"
    u183.ImageColor3 = u4
    u183.ImageRectOffset = Vector2.new(0, 494)
    u183.ImageRectSize = Vector2.new(32, 16)
    u183.AnchorPoint = Vector2.new(0, 0.5)
    u183.BackgroundTransparency = 1
    u183.Position = UDim2.new(0, 0, 0, 4)
    u183.Rotation = 180
    u183.Size = UDim2.fromOffset(16, 8)
    u183.ZIndex = 12
    u183.Parent = CanvasGroup
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "DropShadow"
    ImageLabel.Image = "rbxasset://LuaPackages/Packages/_Index/FoundationImages/FoundationImages/SpriteSheets/img_set_2x_5.png"
    ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.ImageRectOffset = Vector2.new(52, 460)
    ImageLabel.ImageRectSize = Vector2.new(50, 50)
    ImageLabel.ImageTransparency = 0.45
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(12, 12, 13, 13)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.fromOffset(0, 5)
    ImageLabel.Size = UDim2.new(1, 0, 0, 48)
    ImageLabel.Parent = CanvasGroup
    ;(Frame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 144 -- upvalues: ImageLabel (val), Frame (val)
        ImageLabel.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8)
    end)
    local captionJanitor = a1.captionJanitor
    _, u262 = a1:clipOutside(CanvasGroup)
    u262.AutomaticSize = Enum.AutomaticSize.None
    captionJanitor:add(((CanvasGroup:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 154 -- upvalues: CanvasGroup (val), u262 (val)
        local AbsoluteSize = CanvasGroup.AbsoluteSize
        u262.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    end)))
    local AbsoluteSize = CanvasGroup.AbsoluteSize
    u262.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    local u281 = false
    local Header = CanvasGroup.Box.Header
    local UserInputService = game:GetService("UserInputService")

    local function updateHotkey(a1_2) -- Line: 165
        -- upvalues: UserInputService (val), CanvasGroup (val), a1 (val), Header (val), TextLabel (val), Frame_2 (val)
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v1 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v2 = v1 == "_hotkey_"
        if not KeyboardEnabled and v2 then
            a1:setCaption()
            return
        end
        Header.Text = v1
        Header.Visible = not v2
        if a1_2 then
            TextLabel.Text = a1_2.Name
            Frame_2.Visible = true
        end
        if not KeyboardEnabled then
            Frame_2.Visible = false
        end
    end

    ;(CanvasGroup:GetAttributeChangedSignal("CaptionText")):Connect(updateHotkey)
    local Quad = Enum.EasingStyle.Quad
    local u303 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
    local u308 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
    local u314 = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local function getCaptionPosition(a1) -- Line: 191 -- upvalues: u281 (ref)
        return UDim2.new(0.5, 0, 1, if not (if a1 == nil then u281 else a1) then 2 else 10)
    end

    local function updatePosition(a1) -- Line: 198
        -- upvalues: u281 (ref), u183 (val), CanvasGroup (val), u4_2 (val), u262 (val), u303 (val), u308 (val)
        -- upvalues: u314 (val), RunService (val)
        local v1
        if not u281 then
            return
        end
        local v2 = not (if a1 == nil then u281 else a1)
        local v3 = UDim2.new(0.5, 0, 1, if not (if v2 == nil then u281 else v2) then 2 else 10)
        v2 = UDim2.new(0.5, 0, 1, if not (if v1 == nil then u281 else v1) then 2 else 10)
        if not v1 then
            local AbsoluteSize = CanvasGroup.AbsoluteSize
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        else
            u183.Position = UDim2.fromOffset(0, u183.Position.Y.Offset)
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
            CanvasGroup.Size = UDim2.fromOffset(32, 53)
        end
        local u61 = nil

        local function updateCaret() -- Line: 226
            -- upvalues: u4_2 (upval), CanvasGroup (upval), u183 (upval), u61 (ref)
            local v1 = u4_2.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + u4_2.AbsoluteSize.X / 2 - u183.AbsoluteSize.X / 2
            local Offset = u183.Position.Y.Offset
            local v2 = UDim2.fromOffset(v1, Offset)
            if u61 ~= v1 then
                u61 = v1
                u183.Position = UDim2.fromOffset(0, Offset)
                task.wait()
            end
            u183.Position = v2
        end

        u262.Position = v3
        updateCaret()
        v1 = u314:Create(u262, v1 and u303 or u308, {Position = v2})
        local u92 = RunService.Heartbeat:Connect(updateCaret)
        v1:Play()
        v1.Completed:Once(function() -- Line: 252 -- upvalues: u92 (val)
            u92:Disconnect()
        end)
    end

    captionJanitor:add(((u4_2:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 256 -- upvalues: updatePosition (val)
        updatePosition()
    end)))
    updatePosition(false)
    captionJanitor:add((a1.toggleKeyAdded:Connect(updateHotkey)))
    for k, v in pairs(a1.bindedToggleKeys) do
        KeyboardEnabled = UserInputService.KeyboardEnabled
        v1 = CanvasGroup:GetAttribute("CaptionText") or ""
        v2 = v1 == "_hotkey_"
        if not KeyboardEnabled and v2 then
            a1:setCaption()
            break
        end
        Header.Text = v1
        Header.Visible = not v2
        if k then
            TextLabel.Text = k.Name
            Frame_2.Visible = true
        end
        if KeyboardEnabled then
            break
        end
        Frame_2.Visible = false
        break
    end
    captionJanitor:add((a1.fakeToggleKeyChanged:Connect(updateHotkey)))
    local fakeToggleKey = a1.fakeToggleKey
    if fakeToggleKey then
        local KeyboardEnabled_2 = UserInputService.KeyboardEnabled
        local v3 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v4 = v3 == "_hotkey_"
        if KeyboardEnabled_2 or not v4 then
            Header.Text = v3
            Header.Visible = not v4
            if fakeToggleKey then
                TextLabel.Text = fakeToggleKey.Name
                Frame_2.Visible = true
            end
            if not KeyboardEnabled_2 then
                Frame_2.Visible = false
            end
        else
            a1:setCaption()
        end
    end

    local function setCaptionEnabled(a1_2) -- Line: 272
        -- upvalues: u281 (ref), a1 (val), u303 (val), u308 (val), u314 (val), CanvasGroup (val), u262 (val)
        -- upvalues: updatePosition (val), UserInputService (val), Header (val), Frame_2 (val)
        if u281 == a1_2 then
            return
        end
        local joinedFrame = a1.joinedFrame
        if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
            a1_2 = false
        end
        u281 = a1_2
        u314:Create(CanvasGroup, a1_2 and u303 or u308, {GroupTransparency = if not a1_2 then 1 else 0}):Play()
        if a1_2 then
            u262:SetAttribute("ForceUpdate", true)
        end
        updatePosition()
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v1 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v2 = v1 == "_hotkey_"
        if not KeyboardEnabled and v2 then
            a1:setCaption()
            return
        end
        Header.Text = v1
        Header.Visible = not v2
        if not KeyboardEnabled then
            Frame_2.Visible = false
        end
    end

    local iconModule = require(a1.iconModule)
    captionJanitor:add((a1.stateChanged:Connect(function(a1_2) -- Line: 297 -- upvalues: iconModule (val), a1 (val), setCaptionEnabled (val)
        if a1_2 == "Viewing" then
            local captionLastClosedClock = iconModule.captionLastClosedClock
            task.delay(if not ((captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3) then 0.5 else 0, function() -- Line: 302 -- upvalues: a1 (upval), setCaptionEnabled (upval)
                if a1.activeState == "Viewing" then
                    setCaptionEnabled(true)
                end
            end)
            return
        end
        iconModule.captionLastClosedClock = os.clock()
        setCaptionEnabled(false)
    end)))
    return CanvasGroup
end