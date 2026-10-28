-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Features.Gamepad
-- Decompile time: 4.97 ms

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local DPadUp = Enum.KeyCode.DPadUp
local u16 = {}
local u17 = nil

function u16.start(a1) -- Line: 19
    -- upvalues: u17 (ref), DPadUp (val), GuiService (val), UserInputService (val), u16 (val), GamepadService (val)
    u17 = a1
    u17.highlightKey = if u17.highlightKey == nil then DPadUp else u17.highlightKey
    u17.highlightIcon = false
    task.delay(1, function() -- Line: 27
        -- upvalues: u17 (upval), GuiService (upval), DPadUp (upval), UserInputService (upval), u16 (upval)
        -- upvalues: GamepadService (upval)
        local iconsDictionary = u17.iconsDictionary

        local function getIconFromSelectedObject() -- Line: 30 -- upvalues: GuiService (upval), iconsDictionary (val)
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            return Attribute and iconsDictionary[Attribute]
        end

        local u3 = nil
        local u8 = DPadUp ~= u17.highlightKey
        local u13 = DPadUp ~= u17.highlightKey
        local Selection = require(script.Parent.Parent.Elements.Selection)

        local function updateSelectedObject() -- Line: 42
            -- upvalues: GuiService (upval), iconsDictionary (val), UserInputService (upval), Selection (val)
            -- upvalues: u17 (upval), u3 (ref), u13 (ref), u8 (ref), u16 (upval)
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            local v1 = Attribute and iconsDictionary[Attribute]
            local GamepadEnabled = UserInputService.GamepadEnabled
            if not v1 then
                local highlightKey = if not GamepadEnabled then nil else if u8 then nil else u17.highlightKey
                if not u3 then
                    u3 = u16.getIconToHighlight()
                end
                if highlightKey == u17.highlightKey then
                    u8 = true
                end
                if u3 then
                    u3:setIndicator(highlightKey)
                end
                return
            end
            if GamepadEnabled then
                local v2 = v1:getInstance("ClickRegion")
                local selection = v1.selection
                if not selection then
                    selection = v1.janitor:add((Selection(u17)))
                    selection:SetAttribute("IgnoreVisibilityUpdater", true)
                    selection.Parent = v1.widget
                    v1.selection = selection
                    v1:refreshAppearance(selection)
                end
                v2.SelectionImageObject = selection.Selection
            end
            if u3 and u3 ~= v1 then
                u3:setIndicator()
            end
            local ButtonB = if not GamepadEnabled then nil else if u13 then nil else if v1.parentIconUID then nil else Enum.KeyCode.ButtonB
            u3 = v1
            u17.lastHighlightedIcon = v1
            v1:setIndicator(ButtonB)
        end

        ;(GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(updateSelectedObject)
        local Gamepad = Enum.PreferredInput.Gamepad
        ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 90
            -- upvalues: UserInputService (upval), Gamepad (val), u8 (ref), u13 (ref), updateSelectedObject (val)
            if not (UserInputService.PreferredInput == Gamepad) then
                u8 = false
                u13 = false
            end
            updateSelectedObject()
        end)
        if UserInputService.PreferredInput == Gamepad then end
        updateSelectedObject()
        UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 106
            -- upvalues: GuiService (upval), iconsDictionary (val), u17 (upval), u16 (upval), GamepadService (upval)
            if a1.UserInputType == Enum.UserInputType.MouseButton1 then
                local SelectedObject = GuiService.SelectedObject
                local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
                if Attribute and iconsDictionary[Attribute] then
                    GuiService.SelectedObject = nil
                end
                return
            end
            if a1.KeyCode ~= u17.highlightKey then
                return
            end
            local v1 = u16.getIconToHighlight()
            if v1 then
                if GamepadService.GamepadCursorEnabled then
                    task.wait(0.2)
                    GamepadService:DisableGamepadCursor()
                end
                local v2 = v1:getInstance("ClickRegion")
                GuiService.SelectedObject = v2
            end
        end)
    end)
end

function u16.getIconToHighlight() -- Line: 133 -- upvalues: u17 (ref)
    local iconsDictionary = u17.iconsDictionary
    local highlightIcon = u17.highlightIcon or u17.lastHighlightedIcon
    if not highlightIcon then
        local X
        local X_2 = nil
        for k, v in pairs(iconsDictionary) do
            if not v.parentIconUID then
                X = v.widget.AbsolutePosition.X
                if not X_2 or X < X_2 then
                    highlightIcon = v
                    X_2 = highlightIcon.widget.AbsolutePosition.X
                end
            end
        end
    end
    return highlightIcon
end

function u16.registerButton(a1) -- Line: 155 -- upvalues: UserInputService (val), GamepadService (val), GuiService (val)
    local u1 = false
    a1.InputBegan:Connect(function(a1) -- Line: 161 -- upvalues: u1 (ref)
        u1 = true
        task.wait()
        task.wait()
        u1 = false
    end)
    local u12 = UserInputService.InputBegan:Connect(function(a1_2) -- Line: 170 -- upvalues: u1 (ref), GamepadService (upval), GuiService (upval), a1 (val)
        task.wait()
        if a1_2.KeyCode == Enum.KeyCode.ButtonA and u1 then
            task.wait(0.2)
            GamepadService:DisableGamepadCursor()
            GuiService.SelectedObject = a1
            return
        end
        local v1 = GuiService.SelectedObject == a1
        local Name = a1_2.KeyCode.Name
        if table.find({"ButtonB", "ButtonSelect"}, Name) and v1 then
            if Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled then
                GuiService.SelectedObject = nil
            end
        end
    end)
    a1.Destroying:Once(function() -- Line: 191 -- upvalues: u12 (val)
        u12:Disconnect()
    end)
end

return u16