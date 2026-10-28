-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Elements.Selection
-- Decompile time: 1.07 ms

return function(a1) -- Line: 1
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "SelectionContainer"
    Frame_2.Visible = false
    local Frame = Instance.new("Frame")
    Frame.Name = "Selection"
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Parent = Frame_2
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 3
    UIStroke.Parent = Frame
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Name = "SelectionGradient"
    UIGradient.Parent = UIStroke
    local v1 = Instance.new("UICorner")
    v1:SetAttribute("Collective", "IconCorners")
    v1.Name = "UICorner"
    v1.CornerRadius = UDim.new(1, 0)
    v1.Parent = Frame
    v1 = game:GetService("RunService")
    local GuiService = game:GetService("GuiService")
    local u62 = 1
    ;(Frame:GetAttributeChangedSignal("RotationSpeed")):Connect(function() -- Line: 36 -- upvalues: u62 (ref), Frame (val)
        Frame:GetAttribute("RotationSpeed")
    end)
    v1.Heartbeat:Connect(function() -- Line: 39 -- upvalues: GuiService (val), UIGradient (val), u62 (ref)
        if not GuiService.SelectedObject then
            return
        end
        UIGradient.Rotation = os.clock() * u62 * 100 % 360
    end)
    return Frame_2
end