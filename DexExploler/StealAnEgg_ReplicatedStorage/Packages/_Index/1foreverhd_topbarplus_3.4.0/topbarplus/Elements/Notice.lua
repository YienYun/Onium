-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Elements.Notice
-- Decompile time: 3.52 ms

return function(a1, a2) -- Line: 1
    local Frame = Instance.new("Frame")
    Frame.Name = "Notice"
    Frame.ZIndex = 25
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 0.1
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Visible = false
    Frame.Parent = a1.widget
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    Instance.new("UIStroke").Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "NoticeLabel"
    TextLabel.ZIndex = 26
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.FontSize = Enum.FontSize.Size14
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.Text = "1"
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.Font = Enum.Font.Arial
    TextLabel.Parent = Frame
    local Parent = script.Parent.Parent
    local Packages = Parent.Packages
    local Janitor = require(Packages.Janitor)
    local GoodSignal = require(Packages.GoodSignal)
    local u83 = require(Parent.Utility)
    a1.noticeChanged:Connect(function(a1_2) -- Line: 43 -- upvalues: TextLabel (val), a2 (val), a1 (val), u83 (val), Frame (val)
        local v1
        if not a1_2 then
            return
        end
        TextLabel.Text = if not (a1_2 > 99) then a1_2 else "99+"
        if v1 then
            TextLabel.TextSize = 11
        end
        local v2 = true
        if a1_2 < 1 then
            v2 = false
        end
        v1 = a2.getIconByUID(a1.parentIconUID)
        local v3 = true
        if not (#a1.dropdownIcons > 0) then
            v3 = #a1.menuIcons > 0
        end
        if not a1.isSelected then
            if v1 and not v1.isSelected then
                v2 = false
            end
        elseif v3 or v1 and not v1.isSelected then
            v2 = false
        end
        u83.setVisible(Frame, v2, "NoticeHandler")
    end)
    a1.noticeStarted:Connect(function(a1_2, a2_2) -- Line: 71 -- upvalues: a1 (val), a2 (val), Janitor (val), GoodSignal (val), u83 (val)
        if not a1_2 then
            a1_2 = a1.deselected
        end
        local v1 = a2.getIconByUID(a1.parentIconUID)
        if v1 then
            v1:notify(a1_2)
        end
        local u21 = a1.janitor:add((Janitor.new()))
        local u27 = u21:add((GoodSignal.new()))
        u21:add((a1.endNotices:Connect(function() -- Line: 83 -- upvalues: u27 (val)
            u27:Fire()
        end)))
        u21:add((a1_2:Connect(function() -- Line: 86 -- upvalues: u27 (val)
            u27:Fire()
        end)))
        local u52 = a2_2 or u83.generateUID()
        a1.notices[u52] = {completeSignal = u27, clearNoticeEvent = a1_2}

        local function updateNotice() -- Line: 94 -- upvalues: a1 (upval)
            a1.noticeChanged:Fire(a1.totalNotices)
        end

        local v2 = u52
        a1.notified:Fire(v2)
        local v3 = a1
        v3.totalNotices = v3.totalNotices + 1
        a1.noticeChanged:Fire(a1.totalNotices)
        u27:Once(function() -- Line: 100 -- upvalues: u21 (val), a1 (upval), u52 (ref)
            u21:destroy()
            local v1 = a1
            v1.totalNotices = v1.totalNotices - 1
            a1.notices[u52] = nil
            a1.noticeChanged:Fire(a1.totalNotices)
        end)
    end)
    Frame:SetAttribute("ClipToJoinedParent", true)
    a1:clipOutside(Frame)
    return Frame
end