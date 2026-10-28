-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Features.Gamepad
-- Decompile time: 4.85 ms

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local DPadUp = Enum.KeyCode.DPadUp
local Gamepad = Enum.PreferredInput.Gamepad
local u17 = {}
local u18 = nil

function u17.start(a1) -- Line: 26
    -- upvalues: u18 (ref), DPadUp (val), GuiService (val), UserInputService (val), Gamepad (val), u17 (val)
    -- upvalues: GamepadService (val)
    u18 = a1
    u18.highlightKey = if u18.highlightKey == nil then DPadUp else u18.highlightKey
    u18.highlightIcon = false
    task.delay(1, function() -- Line: 35
        -- upvalues: u18 (upval), GuiService (upval), DPadUp (upval), UserInputService (upval), Gamepad (upval)
        -- upvalues: u17 (upval), GamepadService (upval)
        local iconsDictionary = u18.iconsDictionary

        local function getIconFromSelectedObject() -- Line: 38 -- upvalues: GuiService (upval), iconsDictionary (val)
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            return Attribute and iconsDictionary[Attribute]
        end

        local u3 = nil
        local u8 = DPadUp ~= u18.highlightKey
        local u13 = DPadUp ~= u18.highlightKey
        local Selection = require(script.Parent.Parent.Elements.Selection)

        local function updateSelectedObject() -- Line: 50
            -- upvalues: GuiService (upval), iconsDictionary (val), UserInputService (upval), Gamepad (upval)
            -- upvalues: Selection (val), u18 (upval), u3 (ref), u13 (ref), u8 (ref), u17 (upval)
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            local v1 = Attribute and iconsDictionary[Attribute]
            local v2 = UserInputService.PreferredInput == Gamepad
            if not v1 then
                local highlightKey = if not v2 then nil else if u8 then nil else u18.highlightKey
                if not u3 then
                    u3 = u17.getIconToHighlight()
                end
                if highlightKey == u18.highlightKey then
                    u8 = true
                end
                if u3 then
                    u3:setIndicator(highlightKey)
                end
                return
            end
            if v2 then
                local v3 = v1:getInstance("ClickRegion")
                local selection = v1.selection
                if not selection then
                    selection = v1.janitor:add((Selection(u18)))
                    selection:SetAttribute("IgnoreVisibilityUpdater", true)
                    selection.Parent = v1.widget
                    v1.selection = selection
                    v1:refreshAppearance(selection)
                end
                v3.SelectionImageObject = selection.Selection
            end
            if u3 and u3 ~= v1 then
                u3:setIndicator()
            end
            local ButtonB = if not v2 then nil else if u13 then nil else if v1.parentIconUID then nil else Enum.KeyCode.ButtonB
            u3 = v1
            u18.lastHighlightedIcon = v1
            v1:setIndicator(ButtonB)
        end

        ;(GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(updateSelectedObject)
        ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 93
            -- upvalues: UserInputService (upval), Gamepad (upval), u8 (ref), u13 (ref), updateSelectedObject (val)
            if not (UserInputService.PreferredInput == Gamepad) then
                u8 = false
                u13 = false
            end
            updateSelectedObject()
        end)
        if UserInputService.PreferredInput == Gamepad then end
        updateSelectedObject()
        UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 109
            -- upvalues: GuiService (upval), iconsDictionary (val), u18 (upval), u17 (upval), GamepadService (upval)
            if a1.UserInputType == Enum.UserInputType.MouseButton1 then
                local SelectedObject = GuiService.SelectedObject
                local Attribute = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
                if Attribute and iconsDictionary[Attribute] then
                    GuiService.SelectedObject = nil
                end
                return
            end
            if a1.KeyCode ~= u18.highlightKey then
                return
            end
            local v1 = u17.getIconToHighlight()
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

function u17.getIconToHighlight() -- Line: 136 -- upvalues: u18 (ref)
    local iconsDictionary = u18.iconsDictionary
    local highlightIcon = u18.highlightIcon or u18.lastHighlightedIcon
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

function u17.registerButton(a1) -- Line: 158 -- upvalues: UserInputService (val), GuiService (val), GamepadService (val)
    local u6 = UserInputService.InputBegan:Connect(function(a1_2) -- Line: 161 -- upvalues: GuiService (upval), a1 (val), GamepadService (upval)
        task.wait()
        local v1 = GuiService.SelectedObject == a1
        local Name = a1_2.KeyCode.Name
        if table.find({"ButtonB", "ButtonSelect"}, Name) and v1 then
            if Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled then
                GuiService.SelectedObject = nil
            end
        end
    end)
    a1.Destroying:Once(function() -- Line: 175 -- upvalues: u6 (val)
        u6:Disconnect()
    end)
end

return u17