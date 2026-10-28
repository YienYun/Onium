-- Script path: ReplicatedStorage.CmdrClient.CmdrInterface.Window
-- Decompile time: 9.25 ms

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local u21 = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.Touch,
}
local u25 = {Valid = true}
local Frame = ((LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Cmdr")):WaitForChild("Frame")
local Line = Frame:WaitForChild("Line")
local Entry = Frame:WaitForChild("Entry")
Line.Parent = nil

function u25.UpdateLabel(a1) -- Line: 29 -- upvalues: Entry (val), LocalPlayer (val)
    Entry.TextLabel.Text = LocalPlayer.Name .. "@" .. a1.Cmdr.PlaceName .. "$"
end

function u25.GetLabel(a1) -- Line: 34 -- upvalues: Entry (val)
    return Entry.TextLabel.Text
end

function u25.UpdateWindowHeight(a1) -- Line: 39 -- upvalues: Frame (val)
    local v1 = Frame.UIListLayout.AbsoluteContentSize.Y + Frame.UIPadding.PaddingTop.Offset + Frame.UIPadding.PaddingBottom.Offset
    Frame.Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, (math.clamp(v1, 0, 300)))
    Frame.CanvasPosition = Vector2.new(0, v1)
end

function u25:AddLine(a2, a3) -- Line: 48 -- upvalues: u25 (val), Line (val), Frame (val)
    local v1 = a3 or {}
    local v2 = tostring(a2)
    if typeof(v1) == "Color3" then
        v1 = {Color = v1}
    end
    if #v2 == 0 then
        u25:UpdateWindowHeight()
        return
    end
    local v3 = self.Cmdr.Util.EmulateTabstops(v2 or "nil", 8)
    local v4 = Line:Clone()
    v4.Text = v3
    local Color = v1.Color or v4.TextColor3
    v4.TextColor3 = Color
    v4.RichText = v1.RichText or false
    v4.Parent = Frame
end

function u25.IsVisible(a1) -- Line: 71 -- upvalues: Frame (val)
    return Frame.Visible
end

function u25:SetVisible(a2) -- Line: 76
    -- upvalues: Frame (val), TextChatService (val), Entry (val), UserInputService (val)
    Frame.Visible = a2
    if not a2 then
        TextChatService.ChatWindowConfiguration.Enabled = if self.PreviousChatWindowConfigurationEnabled == nil then true else self.PreviousChatWindowConfigurationEnabled
        TextChatService.ChatInputBarConfiguration.Enabled = if self.PreviousChatInputBarConfigurationEnabled == nil then true else self.PreviousChatInputBarConfigurationEnabled
        Entry.TextBox:ReleaseFocus()
        self.AutoComplete:Hide()
        if self.PreviousMouseBehavior then
            UserInputService.MouseBehavior = self.PreviousMouseBehavior
            self.PreviousMouseBehavior = nil
        end
        return
    end
    self.PreviousChatWindowConfigurationEnabled = TextChatService.ChatWindowConfiguration.Enabled
    self.PreviousChatInputBarConfigurationEnabled = TextChatService.ChatInputBarConfiguration.Enabled
    TextChatService.ChatWindowConfiguration.Enabled = false
    TextChatService.ChatInputBarConfiguration.Enabled = false
    Entry.TextBox:CaptureFocus()
    self:SetEntryText("")
    if not self.Cmdr.ActivationUnlocksMouse then
        return
    end
    self.PreviousMouseBehavior = UserInputService.MouseBehavior
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

function u25:Hide() -- Line: 109
    return self:SetVisible(false)
end

function u25.Show(a1) -- Line: 114
    return a1:SetVisible(true)
end

function u25:SetEntryText(a2) -- Line: 119 -- upvalues: Entry (val), u25 (val)
    Entry.TextBox.Text = a2
    if self:IsVisible() then
        Entry.TextBox:CaptureFocus()
        Entry.TextBox.CursorPosition = #a2 + 1
        u25:UpdateWindowHeight()
    end
end

function u25.GetEntryText(a1) -- Line: 130 -- upvalues: Entry (val)
    return Entry.TextBox.Text:gsub("\t", "")
end

function u25.SetIsValidInput(a1, a2, a3) -- Line: 136 -- upvalues: Entry (val)
    local TextBox = Entry.TextBox
    local v1 = a2 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
    TextBox.TextColor3 = v1
    a1.Valid = a2
    a1._errorText = a3
end

function u25.HideInvalidState(a1) -- Line: 142 -- upvalues: Entry (val)
    Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end

function u25:LoseFocus(a2) -- Line: 147 -- upvalues: Entry (val), Frame (val), GuiService (val)
    local Text = Entry.TextBox.Text
    self:ClearHistoryState()
    if not Frame.Visible then
        if GuiService.MenuIsOpen and Frame.Visible then
            self:Hide()
        end
    elseif not GuiService.MenuIsOpen then
        Entry.TextBox:CaptureFocus()
    elseif GuiService.MenuIsOpen and Frame.Visible then
        self:Hide()
    end
    if a2 and self.Valid then
        wait()
        self:SetEntryText("")
        self.ProcessEntry(Text)
        return
    end
    if a2 then
        self:AddLine(self._errorText, (Color3.fromRGB(255, 153, 153)))
    end
end

function u25:TraverseHistory(a2) -- Line: 168
    local History = self.Cmdr.Dispatcher:GetHistory()
    if self.HistoryState == nil then
        self.HistoryState = {Position = #History + 1, InitialText = self:GetEntryText()}
    end
    self.HistoryState.Position = math.clamp(self.HistoryState.Position + a2, 1, #History + 1)
    self:SetEntryText(not (self.HistoryState.Position ~= #History + 1) and self.HistoryState.InitialText or History[self.HistoryState.Position])
end

function u25:ClearHistoryState() -- Line: 186
    self.HistoryState = nil
end

function u25:SelectVertical(a2) -- Line: 190
    if self.AutoComplete:IsVisible() and not self.HistoryState then
        self.AutoComplete:Select(a2)
        return
    end
    self:TraverseHistory(a2)
end

local u63 = 0
local u64 = 0

function u25:BeginInput(a2, a3) -- Line: 201 -- upvalues: GuiService (val), u63 (ref), u64 (ref), u21 (val), Frame (val)
    if GuiService.MenuIsOpen then
        self:Hide()
    end
    if a3 and self:IsVisible() == false then
        return
    end
    if self.Cmdr.ActivationKeys[a2.KeyCode] then
        if self.Cmdr.MashToEnable and not self.Cmdr.Enabled then
            if not (tick() - u63 < 1) then
                u64 = 1
                tick()
                return
            end
            if u64 >= 5 then
                return self.Cmdr:SetEnabled(true)
            end
            u64 = u64 + 1
            tick()
            return
        end
        if self.Cmdr.Enabled then
            self:SetVisible(not (self:IsVisible()))
            wait()
            self:SetEntryText("")
            if GuiService.MenuIsOpen then
                self:Hide()
            end
        end
        return
    end
    if self.Cmdr.Enabled ~= false and self:IsVisible() then
        local Alias, v1
        if self.Cmdr.HideOnLostFocus and table.find(u21, a2.UserInputType) then
            local Position = a2.Position
            local AbsolutePosition = Frame.AbsolutePosition
            local AbsoluteSize = Frame.AbsoluteSize
            if not (Position.X < AbsolutePosition.X) then
                local X = Position.X
                if not (AbsolutePosition.X + AbsoluteSize.X < X) and not (Position.Y < AbsolutePosition.Y) then
                    local Y = Position.Y
                    if not (AbsolutePosition.Y + AbsoluteSize.Y < Y) then
                        return
                    end
                end
            end
            self:Hide()
            return
        end
        if a2.KeyCode == Enum.KeyCode.Down then
            self:SelectVertical(1)
            return
        end
        if a2.KeyCode == Enum.KeyCode.Up then
            self:SelectVertical(-1)
            return
        end
        if a2.KeyCode == Enum.KeyCode.Return then
            wait()
            self:SetEntryText(((self:GetEntryText():gsub("\n", "")):gsub("\r", "")))
            return
        end
        if a2.KeyCode ~= Enum.KeyCode.Tab then
            self:ClearHistoryState()
            return
        end
        local SelectedItem = self.AutoComplete:GetSelectedItem()
        local EntryText = self:GetEntryText()
        if not SelectedItem then
            wait()
            self:SetEntryText((self:GetEntryText()))
            return
        end
        if (EntryText:sub(#EntryText, #EntryText)):match("%s") and self.AutoComplete.LastItem then
            wait()
            self:SetEntryText((self:GetEntryText()))
            return
        end
        local v2 = SelectedItem[2]
        local Command = self.AutoComplete.Command
        if not Command then
            Alias = v2
        else
            local RawSegments, v3, v4
            local Arg = self.AutoComplete.Arg
            Alias = Command.Alias
            local v5 = false
            if self.AutoComplete.NumArgs ~= #Command.ArgumentDefinitions then
                v5 = self.AutoComplete.IsPartial == false
            end
            local Arguments = Command.Arguments
            local v6 = #Arguments
            for i = 1, v6 do
                v3 = Arguments[i]
                RawSegments = v3.RawSegments
                if v3 == Arg then
                    RawSegments[#RawSegments] = v2
                end
                v4 = v3.Prefix .. table.concat(RawSegments, ",")
                if v4:find(" ") or v4 == "" then
                    v4 = ("%q"):format(v4)
                end
                Alias = ("%s %s"):format(Alias, v4)
                if v3 == Arg then
                    wait()
                    v1:SetEntryText(Alias .. (if not v5 then "" else " "))
                    return
                end
            end
        end
        wait()
        v1:SetEntryText(Alias .. " ")
        return
    end
    if self:IsVisible() then
        self:Hide()
    end
end

Entry.TextBox.FocusLost:Connect(function(a1) -- Line: 312 -- upvalues: u25 (val)
    return u25:LoseFocus(a1)
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 316 -- upvalues: u25 (val)
    return u25:BeginInput(a1, a2)
end)
;(Entry.TextBox:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 320 -- upvalues: Frame (val), Entry (val), u25 (val)
    Frame.CanvasPosition = Vector2.new(0, Frame.AbsoluteCanvasSize.Y)
    if Entry.TextBox.Text:match("\t") then
        Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "")
        return
    end
    if u25.OnTextChanged then
        return u25.OnTextChanged(Entry.TextBox.Text)
    end
end)
Frame.ChildAdded:Connect(function() -- Line: 332 -- upvalues: u25 (val)
    task.defer(u25.UpdateWindowHeight)
end)
return u25