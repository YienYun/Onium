-- Script path: ReplicatedStorage.CmdrClient.CmdrInterface.AutoComplete
-- Decompile time: 6.96 ms

local LocalPlayer = game:GetService("Players").LocalPlayer
return function(a1) -- Line: 5 -- upvalues: LocalPlayer (val)
    local u1 = {SelectedItem = 0, Items = {}, ItemOptions = {}}
    local Util = a1.Util
    local Autocomplete = ((LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Cmdr")):WaitForChild("Autocomplete")
    local TextButton = Autocomplete:WaitForChild("TextButton")
    local Title = Autocomplete:WaitForChild("Title")
    local Description = Autocomplete:WaitForChild("Description")
    local Entry = (Autocomplete.Parent:WaitForChild("Frame")):WaitForChild("Entry")
    TextButton.Parent = nil
    local ScrollBarThickness = Autocomplete.ScrollBarThickness

    local function SetText(a1, a2, a3, a4) -- Line: 24 -- upvalues: Util (val)
        a1.Visible = a3 ~= nil
        a2.Text = a3 or ""
        if a4 then
            a2.Size = UDim2.new(0, Util.GetTextSize(a3 or "", a2, Vector2.new(1000, 1000), 1, 0).X, a1.Size.Y.Scale, a1.Size.Y.Offset)
        end
    end

    local function UpdateContainerSize() -- Line: 38 -- upvalues: Autocomplete (val), Title (val)
        Autocomplete.Size = UDim2.new(
            0,
            math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X, Autocomplete.Size.X.Offset),
            0,
            (math.min(
                Autocomplete.UIListLayout.AbsoluteContentSize.Y,
                Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10
            ))
        )
    end

    local function UpdateInfoDisplay(a1) -- Line: 48
        -- upvalues: SetText (val), Title (val), Description (val), Autocomplete (val), UpdateContainerSize (val)
        -- upvalues: ScrollBarThickness (val)
        SetText(Title, Title.Field, a1.name, true)
        local Type = Title.Field.Type
        local Type_2 = Title.Field.Type
        local type = a1.type and ": " .. (a1.type:sub(1, 1):upper()) .. a1.type:sub(2)
        Type.Visible = type ~= nil
        Type_2.Text = type or ""
        local Label = Description.Label
        local description = a1.description
        Description.Visible = description ~= nil
        Label.Text = description or ""
        local Label_2 = Description.Label
        local v1 = a1.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
        Label_2.TextColor3 = v1
        Description.Size = UDim2.new(1, 0, 0, 40)
        while not Description.Label.TextFits do
            Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)
            if 500 < Description.Size.Y.Offset then
                break
            end
        end
        task.wait()
        Autocomplete.UIListLayout:ApplyLayout()
        UpdateContainerSize()
        Autocomplete.ScrollBarThickness = ScrollBarThickness
    end

    function u1.Show(a1, a2, a3) -- Line: 88
        -- upvalues: Autocomplete (val), TextButton (val), Entry (val), Util (val), UpdateInfoDisplay (val)
        local v1, v2, v3, v4, v5
        local v6 = a3 or {}
        for k, v in pairs(a1.Items) do
            if v.gui then
                v.gui:Destroy()
            end
        end
        a1.SelectedItem = 1
        a1.Items = a2
        a1.Prefix = v6.prefix or ""
        a1.LastItem = v6.isLast or false
        a1.Command = v6.command
        a1.Arg = v6.arg
        a1.NumArgs = v6.numArgs
        a1.IsPartial = v6.isPartial
        local v7 = 200
        Autocomplete.ScrollBarThickness = 0
        local v8 = a1
        for k2, i in pairs(a1.Items) do
            v5 = i[1]
            v1 = i[2]
            v2 = TextButton:Clone()
            v2.Name = v5 .. v1
            v2.BackgroundTransparency = if k2 ~= v8.SelectedItem then 1 else 0.5
            v3, v4 = string.find(v1:lower(), v5:lower(), 1, true)
            v2.Typed.Text = (string.rep(" ", v3 - 1)) .. v5
            v2.Suggest.Text = (string.sub(v1, 0, v3 - 1)) .. (string.rep(" ", #v5)) .. string.sub(v1, v4 + 1)
            v2.Parent = Autocomplete
            v2.LayoutOrder = k2
            v4 = math.max(v2.Typed.TextBounds.X, v2.Suggest.TextBounds.X) + 20
            if v7 < v4 then
                v7 = v4
            end
            i.gui = v2
        end
        Autocomplete.UIListLayout:ApplyLayout()
        local Text = Entry.TextBox.Text
        local v9 = Util.SplitString(Text)
        if Text:sub(#Text, #Text) == " " and not v6.at then
            v9[#v9 + 1] = "e"
        end
        table.remove(v9, #v9)
        local at = v6.at and v6.at or #table.concat(v9, " ") + 1
        local v10 = at * 7
        Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + v10, 0, Entry.TextBox.AbsolutePosition.Y + 30)
        Autocomplete.Size = UDim2.new(0, v7, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
        Autocomplete.Visible = true
        UpdateInfoDisplay(v8.Items[1] and v8.Items[1].options or v6)
    end

    function u1.GetSelectedItem(a1) -- Line: 161 -- upvalues: Autocomplete (val), u1 (val)
        if Autocomplete.Visible == false then
            return nil
        end
        return u1.Items[u1.SelectedItem]
    end

    function u1.Hide(a1) -- Line: 170 -- upvalues: Autocomplete (val)
        Autocomplete.Visible = false
    end

    function u1.IsVisible(a1) -- Line: 175 -- upvalues: Autocomplete (val)
        return Autocomplete.Visible
    end

    function u1.Select(a1, a2) -- Line: 180
        -- upvalues: Autocomplete (val), Title (val), Description (val), TextButton (val), UpdateInfoDisplay (val)
        if not Autocomplete.Visible then
            return
        end
        a1.SelectedItem = a1.SelectedItem + a2
        local SelectedItem = a1.SelectedItem
        if #a1.Items < SelectedItem then
            a1.SelectedItem = 1
        elseif a1.SelectedItem < 1 then
            a1.SelectedItem = #a1.Items
        end
        local v1 = a1
        for k, v in pairs(a1.Items) do
            v.gui.BackgroundTransparency = if k ~= v1.SelectedItem then 1 else 0.5
        end
        Autocomplete.CanvasPosition = Vector2.new(0, (math.max(
            0,
            Title.Size.Y.Offset + Description.Size.Y.Offset + v1.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset
        )))
        if v1.Items[v1.SelectedItem] and v1.Items[v1.SelectedItem].options then
            UpdateInfoDisplay(v1.Items[v1.SelectedItem].options or {})
        end
    end

    ;(Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize")):Connect(UpdateContainerSize)
    return u1
end