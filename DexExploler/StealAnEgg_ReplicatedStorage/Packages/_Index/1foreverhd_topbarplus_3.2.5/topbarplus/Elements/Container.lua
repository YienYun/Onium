-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Elements.Container
-- Decompile time: 6.22 ms

local u0 = false
local u1 = 0
return function(a1) -- Line: 3 -- upvalues: u0 (ref), u1 (ref)
    local checkInset
    local GuiService = game:GetService("GuiService")
    local v1 = {}
    local u15 = require(script.Parent.Parent.Packages.GoodSignal).new()
    local u19 = GuiService:GetGuiInset()
    local u20 = 0
    local u21 = 0
    local u22 = 0
    local u23 = 0

    function checkInset(a1_2) -- Line: 15
        -- upvalues: GuiService (val), a1 (val), u23 (ref), checkInset (val), u0 (upval), u20 (ref), u19 (val)
        -- upvalues: u21 (ref), u22 (ref), u15 (val), u1 (upval)
        local Height = GuiService.TopbarInset.Height
        local v1 = Height <= 36
        local v2 = GuiService:IsTenFootInterface()
        a1.isOldTopbar = v1
        u23 = u23 + 1
        if Height ~= 0 then
            if u23 == 1 then
                task.delay(5, function() -- Line: 30 -- upvalues: u23 (upval), checkInset (upval)
                    if u23 == 1 then
                        checkInset()
                    end
                end)
            end
        elseif a1_2 == nil then
            task.delay(5, function() -- Line: 26 -- upvalues: checkInset (upval)
                checkInset("ForceConvertToOld")
            end)
        elseif u23 == 1 then
            task.delay(5, function() -- Line: 30 -- upvalues: u23 (upval), checkInset (upval)
                if u23 == 1 then
                    checkInset()
                end
            end)
        end
        if a1.isOldTopbar and not v2 and u0 == false then
            if Height ~= 0 or a1_2 == "ForceConvertToOld" then
                u0 = true
                task.defer(function() -- Line: 45 -- upvalues: a1 (upval), GuiService (upval)
                    local Themes = script.Parent.Parent.Features.Themes
                    local Classic = require(Themes.Classic)
                    a1.modifyBaseTheme(Classic)
                    ;(GuiService:GetPropertyChangedSignal("MenuIsOpen")):Connect(function() -- Line: 52 -- upvalues: GuiService (upval), a1 (upval)
                        if GuiService.MenuIsOpen then
                            a1.setTopbarEnabled(false, true)
                            return
                        end
                        a1.setTopbarEnabled()
                    end)
                    if GuiService.MenuIsOpen then
                        a1.setTopbarEnabled(false, true)
                        return
                    end
                    a1.setTopbarEnabled()
                end)
            end
        end
        u20 = if not v1 then u19.Y - 50 else 12
        u21 = if not v1 then 0 else 2
        u22 = -2
        if v2 then
            u20 = 10
            u21 = -9
        end
        if GuiService.TopbarInset.Height == 0 and not u0 then
            u21 = u21 + 13
            u22 = 50
        end
        u15:Fire(u19)
        local Y = u19.Y
        if Y ~= u1 then
            u1 = Y
            task.defer(function() -- Line: 82 -- upvalues: a1 (upval), Y (val)
                a1.insetHeightChanged:Fire(Y)
            end)
        end
    end

    ;(GuiService:GetPropertyChangedSignal("TopbarInset")):Connect(checkInset)
    checkInset("FirstTime")
    local ScreenGui = Instance.new("ScreenGui")
    u15:Connect(function() -- Line: 91 -- upvalues: ScreenGui (val), u20 (ref)
        ScreenGui:SetAttribute("StartInset", u20)
    end)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    v1[ScreenGui.Name] = ScreenGui
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 101 -- upvalues: ScreenGui (val), a1 (val)
        ScreenGui.DisplayOrder = a1.baseDisplayOrder
    end)
    local Frame = Instance.new("Frame")
    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    u15:Connect(function() -- Line: 108 -- upvalues: Frame (val), u21 (ref), u22 (ref)
        Frame.Position = UDim2.new(0, 0, 0, u21)
        Frame.Size = UDim2.new(1, 0, 1, u22)
    end)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    local u68 = ScreenGui:Clone()
    local Holders = u68.Holders
    u68.Name = "TopbarCentered"
    u68.ScreenInsets = Enum.ScreenInsets.None
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 123 -- upvalues: u68 (val), a1 (val)
        u68.DisplayOrder = a1.baseDisplayOrder
    end)
    v1[u68.Name] = u68
    u15:Connect(function() -- Line: 118 -- upvalues: Holders (val), GuiService (val), u22 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u22)
    end)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u22)
    local u93 = ScreenGui:Clone()
    u93.Name = u93.Name .. "Clipped"
    u93.DisplayOrder = u93.DisplayOrder + 1
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 134 -- upvalues: u93 (val), a1 (val)
        u93.DisplayOrder = a1.baseDisplayOrder + 1
    end)
    v1[u93.Name] = u93
    local u107 = u68:Clone()
    u107.Name = u107.Name .. "Clipped"
    u107.DisplayOrder = u107.DisplayOrder + 1
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 142 -- upvalues: u107 (val), a1 (val)
        u107.DisplayOrder = a1.baseDisplayOrder + 1
    end)
    v1[u107.Name] = u107
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    u15:Connect(function() -- Line: 151 -- upvalues: ScrollingFrame (val), u20 (ref)
        ScrollingFrame.Position = UDim2.fromOffset(u20, 0)
    end)
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Active = false
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ScrollBarThickness = 0
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    ScrollingFrame.ScrollingEnabled = false
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    ScrollingFrame.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    u15:Connect(function() -- Line: 172 -- upvalues: UIListLayout (val), u20 (ref)
        UIListLayout.Padding = UDim.new(0, u20)
    end)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame
    local u170 = ScrollingFrame:Clone()
    u15:Connect(function() -- Line: 182 -- upvalues: u170 (val), u20 (ref)
        u170.UIListLayout.Padding = UDim.new(0, u20)
    end)
    u170.ScrollingEnabled = false
    u170.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    u170.Name = "Center"
    u170.Parent = Holders
    local u181 = ScrollingFrame:Clone()
    u15:Connect(function() -- Line: 191 -- upvalues: u181 (val), u20 (ref)
        u181.UIListLayout.Padding = UDim.new(0, u20)
    end)
    u181.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    u181.Name = "Right"
    u181.AnchorPoint = Vector2.new(1, 0)
    u181.Position = UDim2.new(1, -12, 0, 0)
    u181.Parent = Frame
    u15:Fire(u19)
    return v1
end