-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Elements.Container
-- Decompile time: 6.77 ms

local u0 = false
local u1 = 0
return function(a1) -- Line: 3 -- upvalues: u0 (ref), u1 (ref)
    local checkInset
    local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local v1 = {}
    local u25 = require(script.Parent.Parent.Packages.GoodSignal).new()
    local GuiInset = GuiService:GetGuiInset()
    local u29 = 0
    local u30 = 0
    local u31 = 0
    local u32 = 0
    local u33 = false
    local u34 = false

    function checkInset(a1_2) -- Line: 20
        -- upvalues: GuiService (val), u33 (ref), u34 (ref), UserInputService (val), a1 (val), u32 (ref)
        -- upvalues: checkInset (val), Players (val), u0 (upval), GuiInset (ref), u29 (ref), u30 (ref), u31 (ref)
        -- upvalues: u25 (val), u1 (upval)
        local Height = GuiService.TopbarInset.Height
        local v1 = Height <= 36
        u33 = GuiService:IsTenFootInterface()
        u34 = UserInputService.VREnabled
        a1.isOldTopbar = v1
        u32 = u32 + 1
        if Height ~= 0 then
            if u32 == 1 then
                task.delay(5, function() -- Line: 38 -- upvalues: Players (upval), u32 (upval), checkInset (upval)
                    Players.LocalPlayer:WaitForChild("PlayerGui")
                    if u32 == 1 then
                        checkInset()
                    end
                end)
            end
        elseif a1_2 == nil then
            task.defer(function() -- Line: 33 -- upvalues: checkInset (upval)
                task.wait(8)
                checkInset("ForceConvertToOld")
            end)
        elseif u32 == 1 then
            task.delay(5, function() -- Line: 38 -- upvalues: Players (upval), u32 (upval), checkInset (upval)
                Players.LocalPlayer:WaitForChild("PlayerGui")
                if u32 == 1 then
                    checkInset()
                end
            end)
        end
        if a1.isOldTopbar and not u33 and not u34 and u0 == false then
            if Height ~= 0 or a1_2 == "ForceConvertToOld" then
                u0 = true
                task.defer(function() -- Line: 50 -- upvalues: a1 (upval), GuiService (upval)
                    local Themes = script.Parent.Parent.Features.Themes
                    local Classic = require(Themes.Classic)
                    a1.modifyBaseTheme(Classic)
                    ;(GuiService:GetPropertyChangedSignal("MenuIsOpen")):Connect(function() -- Line: 57 -- upvalues: GuiService (upval), a1 (upval)
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
        GuiInset = GuiService:GetGuiInset()
        u29 = if not v1 then GuiInset.Y - 50 else 12
        u30 = if not v1 then 0 else 2
        u31 = -2
        if u33 then
            u29 = 10
            u30 = 0
        end
        if GuiService.TopbarInset.Height == 0 and not u0 then
            u30 = u30 + 13
            u31 = 50
        end
        u25:Fire(GuiInset)
        local Y = GuiInset.Y
        if Y ~= u1 then
            u1 = Y
            task.defer(function() -- Line: 88 -- upvalues: a1 (upval), Y (val)
                a1.insetHeightChanged:Fire(Y)
            end)
        end
    end

    ;(GuiService:GetPropertyChangedSignal("TopbarInset")):Connect(checkInset)
    checkInset("FirstTime")
    local ScreenGui = Instance.new("ScreenGui")
    u25:Connect(function() -- Line: 98 -- upvalues: ScreenGui (val), u29 (ref)
        ScreenGui:SetAttribute("StartInset", u29)
    end)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.DisplayOrder = a1.baseDisplayOrder
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    v1[ScreenGui.Name] = ScreenGui
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 109 -- upvalues: ScreenGui (val), a1 (val)
        ScreenGui.DisplayOrder = a1.baseDisplayOrder
    end)
    local Frame = Instance.new("Frame")
    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    u25:Connect(function() -- Line: 116 -- upvalues: u34 (ref), u33 (ref), u31 (ref), Frame (val), u30 (ref)
        local v1 = if not u33 then UDim2.new(1, 0, 1, u31) else UDim2.new(1, 0, 0, if not u34 then 56 else 36)
        Frame.Position = UDim2.new(0, 0, 0, u30)
        Frame.Size = v1
    end)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    local u80 = ScreenGui:Clone()
    local Holders = u80.Holders
    u80.Name = "TopbarCentered"
    u80.DisplayOrder = a1.baseDisplayOrder
    u80.ScreenInsets = Enum.ScreenInsets.None
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 134 -- upvalues: u80 (val), a1 (val)
        u80.DisplayOrder = a1.baseDisplayOrder
    end)
    v1[u80.Name] = u80
    u25:Connect(function() -- Line: 128 -- upvalues: Holders (val), GuiService (val), u31 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u31)
    end)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u31)
    local u106 = ScreenGui:Clone()
    u106.Name = u106.Name .. "Clipped"
    u106.DisplayOrder = a1.baseDisplayOrder + 1
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 145 -- upvalues: u106 (val), a1 (val)
        u106.DisplayOrder = a1.baseDisplayOrder + 1
    end)
    v1[u106.Name] = u106
    local u120 = u80:Clone()
    u120.Name = u120.Name .. "Clipped"
    u120.DisplayOrder = a1.baseDisplayOrder + 1
    a1.baseDisplayOrderChanged:Connect(function() -- Line: 153 -- upvalues: u120 (val), a1 (val)
        u120.DisplayOrder = a1.baseDisplayOrder + 1
    end)
    v1[u120.Name] = u120
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    u25:Connect(function() -- Line: 162 -- upvalues: ScrollingFrame (val), u29 (ref)
        ScrollingFrame.Position = UDim2.fromOffset(u29, 0)
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
    u25:Connect(function() -- Line: 183 -- upvalues: UIListLayout (val), u29 (ref)
        UIListLayout.Padding = UDim.new(0, u29)
    end)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame
    local u183 = ScrollingFrame:Clone()
    u25:Connect(function() -- Line: 193 -- upvalues: u183 (val), u29 (ref)
        u183.UIListLayout.Padding = UDim.new(0, u29)
    end)
    u183.ScrollingEnabled = false
    u183.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    u183.Name = "Center"
    u183.Parent = Holders
    local u194 = ScrollingFrame:Clone()
    u25:Connect(function() -- Line: 202 -- upvalues: u194 (val), u29 (ref)
        u194.UIListLayout.Padding = UDim.new(0, u29)
    end)
    u194.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    u194.Name = "Right"
    u194.AnchorPoint = Vector2.new(1, 0)
    u194.Position = UDim2.new(1, -12, 0, 0)
    u194.Parent = Frame
    u25:Fire(GuiInset)
    return v1
end