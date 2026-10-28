-- Script path: ReplicatedStorage.Controllers.GUI.ConsoleController
-- Decompile time: 40.87 ms

local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Hud = require(ReplicatedStorage.Client.Hud)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local u71 = table.freeze({"Message", "ActivePets", "GrowingEggs"})
local u74 = table.freeze({
    BackpackGui = true,
    Treadmill = true,
    TreadmillScreenButtonSwapLeft = true,
    TreadmillScreenButtonSwapRight = true,
    TreadmillScreenComments = true,
    TreadmillUI = true,
})
local ButtonL3 = Enum.KeyCode.ButtonL3
local ButtonB = Enum.KeyCode.ButtonB
local u79 = table.freeze({
    BackpackGui = true,
    TopbarCentered = true,
    TopbarCenteredClipped = true,
    TopbarStandard = true,
    TopbarStandardClipped = true,
})
return {
    Start = function() -- Line: 53
        -- upvalues: Log (val), GUI (val), GamepadBindings (val), GuiService (val), u71 (val), Tabs (val)
        -- upvalues: ButtonL3 (val), u79 (val), ButtonHintStrip (val), MenuNavigation (val), Preferences (val)
        -- upvalues: Toast (val), InputIconsConfig (val), PlatformController (val), UserInputService (val), u74 (val)
        -- upvalues: Hud (val), ButtonB (val), ContextActionService (val)
        local GamepadGlyph, v1, v2
        local u271 = Log.new()
        local u272 = GUI.PlayerGui()
        local u6 = {}
        local u7 = {}
        local u273 = {}
        local u9 = {}
        local u274 = nil
        local u275 = nil
        local u12 = nil
        local u276 = nil
        local u14 = {}
        local u15 = false
        local u277 = false
        local u278 = false
        local u279 = false

        local function isVisible(a1) -- Line: 76 -- upvalues: GamepadBindings (upval) -- types: a1: userdata
            return GamepadBindings.IsOnScreen(a1)
        end

        local function isModalDialog(a1) -- Line: 78 -- types: a1: userdata?
            local v1 = false
            if a1 ~= nil then
                v1 = a1:GetAttribute("ModalDialog") == true
            end
            return v1
        end

        local function settleSelection(a1) -- Line: 82 -- upvalues: GuiService (upval) -- types: a1: userdata?
            if GuiService.SelectedObject ~= a1 then
                GuiService.SelectedObject = a1
            end
            GuiService.GuiNavigationEnabled = a1 ~= nil
        end

        local function priorityScreen() -- Line: 89 -- upvalues: u71 (upval), GUI (upval), Tabs (upval), u279 (ref)
            local v1
            local v2 = nil
            for i, j in u71, v2 do
                v1 = GUI.Get(j)
                assert(v1:IsA("ScreenGui"), (("%* must be a ScreenGui"):format(j)))
                if v1.Enabled then
                    return v1
                end
            end
            local v3 = Tabs.Active()
            if v3 ~= nil then
                v2 = GUI.Get(v3)
                assert(v2:IsA("ScreenGui"), (("Tab %* must be a ScreenGui"):format(v3)))
                if v2.Enabled then
                    return v2
                end
            end
            if u279 then
                v3 = GUI.HUD()
                assert(v3:IsA("ScreenGui"), "HUD must be a ScreenGui")
                if v3.Enabled then
                    return v3
                end
            end
            return nil
        end

        local function setHudNavigation(a1, a2) -- Line: 118
            -- upvalues: u279 (ref), GamepadBindings (upval), u271 (val), ButtonL3 (upval)
            if u279 == a1 then
                return
            end
            u279 = a1
            GamepadBindings.EnableMarkers(not a1)
            ;(u271:AtDebug()):Log((("HUD navigation %* (%*); toggle key is %*"):format(if not a1 then "OFF" else "ON", a2, ButtonL3.Name)))
        end

        local function isCursorScopeMember(a1, a2) -- Line: 129
            -- upvalues: u274 (ref), u276 (ref), u272 (val), u79 (upval)
            if a1 ~= a2 and not a1:IsDescendantOf(a2) then
                local v1 = u274
                local v2 = false
                if v1 ~= nil then
                    v2 = v1:GetAttribute("ModalDialog") == true
                end
                if v2 then
                    return false
                end
                if u276 and u276.Modal then
                    return false
                end
                v2 = if not a1:IsA("ScreenGui") then a1:FindFirstAncestorOfClass("ScreenGui") else a1
                v1 = false
                if v2 ~= nil then
                    v1 = v2:IsDescendantOf(u272)
                    if v1 then
                        v1 = true
                        if v2.Name ~= "HUD" then
                            v1 = u79[v2.Name] == true
                        end
                    end
                end
                return v1
            end
            return true
        end

        local function restoreSelectableButtons(a1, a2) -- Line: 137
            -- upvalues: u7 (val), isCursorScopeMember (val), u6 (val)
            local v1 = nil
            local v2 = nil
            local v3, v4 = a1, a2
            for i in u7, v1, v2 do
                if not v3 then
                    if i.Parent ~= nil then
                        i.Selectable = u6[i]
                    end
                    u7[i] = nil
                    u6[i] = nil
                elseif i ~= v3 and not i:IsDescendantOf(v3) then
                    if not v4 or not isCursorScopeMember(i, v3) then
                        if i.Parent ~= nil then
                            i.Selectable = u6[i]
                        end
                        u7[i] = nil
                        u6[i] = nil
                    end
                end
            end
        end

        local function focusRank(a1) -- Line: 153 -- types: a1: userdata
            local v1 = if a1:GetAttribute("DefaultFocus") ~= true then 2 else 0
            local v2 = if a1.Name ~= "Close" then 0 else 1
            local AbsolutePosition = a1.AbsolutePosition
            return v1 + v2, a1.LayoutOrder, AbsolutePosition.Y, AbsolutePosition.X
        end

        local function outranks(a1, a2) -- Line: 160 -- types: a1: userdata, a2: userdata
            local v1 = if a1:GetAttribute("DefaultFocus") ~= true then 2 else 0
            local v2 = if a1.Name ~= "Close" then 0 else 1
            local AbsolutePosition = a1.AbsolutePosition
            local v3 = v1 + v2
            local LayoutOrder = a1.LayoutOrder
            local Y = AbsolutePosition.Y
            local X = AbsolutePosition.X
            local v4 = if a2:GetAttribute("DefaultFocus") ~= true then 2 else 0
            local v5 = if a2.Name ~= "Close" then 0 else 1
            local AbsolutePosition_2 = a2.AbsolutePosition
            v1 = v4 + v5
            local LayoutOrder_2 = a2.LayoutOrder
            local Y_2 = AbsolutePosition_2.Y
            local X_2 = AbsolutePosition_2.X
            if v3 ~= v1 then
                return v3 < v1
            end
            if LayoutOrder ~= LayoutOrder_2 then
                return LayoutOrder < LayoutOrder_2
            end
            if Y ~= Y_2 then
                return Y < Y_2
            end
            return X < X_2
        end

        local function projectSelectableButtons(a1) -- Line: 169
            -- upvalues: GamepadBindings (upval), u6 (val), u7 (val)
            local AbsolutePosition, AbsolutePosition_2, Active, LayoutOrder, LayoutOrder_2, X, X_2, Y, Y_2, v1, v2, v3, v4, v5
            local v6 = nil
            for i, j in a1:GetDescendants() do
                if j:IsA("GuiButton") then
                    Active = j.Active and j.Interactable and GamepadBindings.IsOnScreen(j) and j:GetAttribute("ConsoleNavigationDisabled") ~= true
                    if u6[j] == nil then
                        u6[j] = j.Selectable
                    end
                    if j.Selectable ~= Active then
                        j.Selectable = Active
                    end
                    u7[j] = true
                    if Active then
                        if v6 == nil then
                            v6 = j
                        else
                            v2 = if j:GetAttribute("DefaultFocus") ~= true then 2 else 0
                            v3 = if j.Name ~= "Close" then 0 else 1
                            AbsolutePosition = j.AbsolutePosition
                            v1 = v2 + v3
                            LayoutOrder = j.LayoutOrder
                            Y = AbsolutePosition.Y
                            X = AbsolutePosition.X
                            v4 = if v6:GetAttribute("DefaultFocus") ~= true then 2 else 0
                            v5 = if v6.Name ~= "Close" then 0 else 1
                            AbsolutePosition_2 = v6.AbsolutePosition
                            v2 = v4 + v5
                            LayoutOrder_2 = v6.LayoutOrder
                            Y_2 = AbsolutePosition_2.Y
                            X_2 = AbsolutePosition_2.X
                            if if v1 == v2 then if LayoutOrder == LayoutOrder_2 then if Y == Y_2 then X < X_2 else Y < Y_2 else LayoutOrder < LayoutOrder_2 else v1 < v2 then
                                v6 = j
                            end
                        end
                    end
                end
            end
            return v6
        end

        local function projectSelectionContainers(a1, a2) -- Line: 191
            -- upvalues: u6 (val), u7 (val)
            local function project(a1) -- Line: 192 -- upvalues: u6 (upval), a2 (val), u7 (upval) -- types: a1: userdata
                if a1:IsA("GuiObject") and not a1:IsA("GuiButton") and not a1:IsA("TextBox") then
                    if u6[a1] == nil then
                        if not a1.Selectable then
                            return
                        end
                        u6[a1] = a1.Selectable
                    end
                    local v1 = not a2 and u6[a1]
                    if a1.Selectable ~= v1 then
                        a1.Selectable = v1
                    end
                    u7[a1] = true
                    return
                end
            end

            project(a1)
            for i, j in a1:GetDescendants() do
                project(j)
            end
        end

        local function isEligibleSelection(a1, a2) -- Line: 209
            -- upvalues: GamepadBindings (upval)
            local Selectable = false
            if a2 ~= nil then
                Selectable = a2:IsDescendantOf(a1)
                if Selectable then
                    if a2:IsA("GuiButton") then
                        Selectable = a2.Selectable
                        if Selectable then
                            Selectable = a2.Active
                            if Selectable then
                                Selectable = a2.Interactable
                                if Selectable then
                                    Selectable = false
                                    if a2:GetAttribute("ConsoleNavigationDisabled") ~= true then
                                        Selectable = GamepadBindings.IsOnScreen(a2)
                                    end
                                end
                            end
                        end
                    else
                        Selectable = a2:IsA("TextBox")
                        if Selectable then
                            Selectable = a2.Selectable
                            if Selectable then
                                Selectable = a2.Active
                                if Selectable then
                                    Selectable = a2.Interactable
                                    if Selectable then
                                        Selectable = false
                                        if a2:GetAttribute("ConsoleNavigationDisabled") ~= true then
                                            Selectable = GamepadBindings.IsOnScreen(a2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            return Selectable
        end

        local function scrollTarget(a1, a2, a3, a4, a5) -- Line: 224
            -- upvalues: 
            local v1 = a1 + a2 + a3 - a4
            local v2 = a1 + a2
            return (math.clamp(if not (v2 < v1) then math.clamp(a1, v1, v2) else v2, 0, (math.max(a5, 0))))
        end

        local function revealSelection(a1) -- Line: 231 -- types: a1: userdata
            local AbsoluteSize, AbsoluteWindowSize, CanvasPosition, ScrollingDirection, X, X_2, X_3, X_4, X_5, X_6, Y, Y_2, Y_3, Y_4, Y_5, Y_6, new, v1, v2, v3, v4, v5, v6, v7, v8
            local Parent = a1.Parent
            local v9 = a1
            while Parent do
                if Parent:IsA("ScrollingFrame") and Parent.ScrollingEnabled then
                    v4 = v9.AbsolutePosition - Parent.AbsolutePosition
                    AbsoluteSize = v9.AbsoluteSize
                    AbsoluteWindowSize = Parent.AbsoluteWindowSize
                    CanvasPosition = Parent.CanvasPosition
                    v7 = Parent.AbsoluteCanvasSize - AbsoluteWindowSize
                    ScrollingDirection = Parent.ScrollingDirection
                    new = Vector2.new
                    if ScrollingDirection ~= Enum.ScrollingDirection.Y then
                        X_2 = CanvasPosition.X
                        X_3 = v4.X
                        X_4 = AbsoluteSize.X
                        X_5 = AbsoluteWindowSize.X
                        X_6 = v7.X
                        v1 = X_2 + X_3 + X_4 - X_5
                        v2 = X_2 + X_3
                        v5 = math.max(X_6, 0)
                        X = math.clamp(if not (v2 < v1) then math.clamp(X_2, v1, v2) else v2, 0, v5)
                    else
                        X = CanvasPosition.X
                    end
                    if ScrollingDirection ~= Enum.ScrollingDirection.X then
                        Y_2 = CanvasPosition.Y
                        Y_3 = v4.Y
                        Y_4 = AbsoluteSize.Y
                        Y_5 = AbsoluteWindowSize.Y
                        Y_6 = v7.Y
                        v2 = Y_2 + Y_3 + Y_4 - Y_5
                        v3 = Y_2 + Y_3
                        v6 = math.max(Y_6, 0)
                        Y = math.clamp(if not (v3 < v2) then math.clamp(Y_2, v2, v3) else v3, 0, v6)
                    else
                        Y = CanvasPosition.Y
                    end
                    v8 = new(X, Y)
                    if v8 ~= CanvasPosition then
                        Parent.CanvasPosition = v8
                    end
                end
                Parent = Parent.Parent
            end
        end

        local function isExternalNavigationSelection(a1) -- Line: 251 -- upvalues: u79 (upval) -- types: a1: userdata?
            if a1 == nil then
                return false
            end
            local v1 = a1:FindFirstAncestorWhichIsA("LayerCollector")
            local v2 = false
            if v1 ~= nil then
                v2 = u79[v1.Name] == true
            end
            return v2
        end

        local function restorePointerButtons(a1) -- Line: 259
            -- upvalues: u14 (val), isCursorScopeMember (val)
            local v1 = nil
            local v2 = nil
            local v3 = a1
            for i, j in u14, v1, v2 do
                if not v3 or not i.Parent or isCursorScopeMember(i, v3) then
                    if i.Parent and i.Interactable ~= j then
                        i.Interactable = j
                    end
                    u14[i] = nil
                end
            end
        end

        local function scopePointerButtons(a1) -- Line: 267
            -- upvalues: u272 (val), isCursorScopeMember (val), u14 (val)
            for i, j in u272:GetDescendants() do
                if j:IsA("GuiButton") and not isCursorScopeMember(j, a1) and j.Interactable then
                    u14[j] = true
                    j.Interactable = false
                end
            end
        end

        local function updateNavigationHints(a1) -- Line: 276
            -- upvalues: ButtonHintStrip (upval), MenuNavigation (upval), u15 (ref), Preferences (upval), Toast (upval)
            -- upvalues: InputIconsConfig (upval)
            if a1 == nil then
                ButtonHintStrip.Retract("NavigationSwitch")
                ButtonHintStrip.Retract("NavigationMode")
                ButtonHintStrip.SetNavigationLayer(nil)
                return
            end
            local v1 = MenuNavigation.IsCursorActive()
            ButtonHintStrip.SetNavigationLayer(if not a1:IsA("ScreenGui") then 50 else a1.DisplayOrder)
            local v2 = if not v1 then "Navigation: Buttons" else "Navigation: Cursor"
            ButtonHintStrip.PresentStatus("NavigationMode", v2)
            local v3 = if not v1 then "Use Cursor" else "Use Button Navigation"
            ButtonHintStrip.Present("NavigationSwitch", MenuNavigation.SwitchKey, v3)
            if not u15 and not Preferences.IsOn("SeenNavigationHint") then
                u15 = true
                Toast.Show({
                    Text = "Prefer a cursor in menus? Press the right stick to switch. Your choice is saved.",
                    Seconds = 12,
                    WrapText = true,
                    Image = InputIconsConfig.Image(MenuNavigation.SwitchKey),
                })
                task.delay(12, function() -- Line: 295 -- upvalues: Preferences (upval)
                    Preferences.Set("SeenNavigationHint", true)
                end)
            end
        end

        local function reconcile() -- Line: 299
            -- upvalues: u278 (ref), u12 (ref), MenuNavigation (upval), u7 (val), u6 (val), u14 (val)
            -- upvalues: ButtonHintStrip (upval), PlatformController (upval), UserInputService (upval), u279 (ref)
            -- upvalues: GamepadBindings (upval), u271 (val), ButtonL3 (upval), u274 (ref), u275 (ref), u276 (ref)
            -- upvalues: GuiService (upval), priorityScreen (val), restoreSelectableButtons (val)
            -- upvalues: restorePointerButtons (val), u79 (upval), projectSelectableButtons (val), u273 (val)
            -- upvalues: isEligibleSelection (val), projectSelectionContainers (val), u272 (val)
            -- upvalues: isCursorScopeMember (val), scopePointerButtons (val), updateNavigationHints (val)
            -- upvalues: revealSelection (val)
            local v1, v2, v3, v4, v5
            if u278 then
                return
            end
            u278 = true
            local v6 = u12
            u12 = nil
            if MenuNavigation.IsSuspended() then
                v1 = nil
                v2 = nil
                for i5 in u7, v1, v2 do
                    if i5.Parent ~= nil then
                        i5.Selectable = u6[i5]
                    end
                    u7[i5] = nil
                    u6[i5] = nil
                end
                v1 = nil
                v2 = nil
                for i6, i7 in u14, v1, v2 do
                    if i6.Parent and i6.Interactable ~= i7 then
                        i6.Interactable = i7
                    end
                    u14[i6] = nil
                end
                MenuNavigation.Release()
                ButtonHintStrip.Retract("NavigationSwitch")
                ButtonHintStrip.Retract("NavigationMode")
                ButtonHintStrip.SetNavigationLayer(nil)
                ButtonHintStrip.Retract("HudNavigation")
                if not PlatformController.IsConsole() then
                    if u279 ~= false then
                        u279 = false
                        GamepadBindings.EnableMarkers(true)
                        ;(u271:AtDebug()):Log((("HUD navigation OFF (left console platform); toggle key is %*"):format(ButtonL3.Name)))
                    end
                elseif not UserInputService.GamepadEnabled and u279 ~= false then
                    u279 = false
                    GamepadBindings.EnableMarkers(true)
                    ;(u271:AtDebug()):Log((("HUD navigation OFF (left console platform); toggle key is %*"):format(ButtonL3.Name)))
                end
                u274 = nil
                u275 = nil
                u276 = nil
                GamepadBindings.FocusScreen(nil)
                if not GuiService.MenuIsOpen then
                    if GuiService.SelectedObject ~= nil then
                        GuiService.SelectedObject = nil
                    end
                    GuiService.GuiNavigationEnabled = false
                end
                u278 = false
                return
            end
            local v7 = priorityScreen()
            v1 = MenuNavigation.TopOverride()
            if not v1 then
                v1 = nil
            elseif v7 == nil or v7.Name == "HUD" then
                if v7 == nil then
                    v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
                else
                    v2 = false
                    if v7 ~= nil then
                        v2 = v7:GetAttribute("ModalDialog") == true
                    end
                    if not v2 then
                        v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
                    elseif not (2000 <= v1.Priority) then
                        v1 = nil
                    else
                        v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
                    end
                end
            elseif not (1000 <= v1.Priority) then
                v1 = nil
            elseif v7 == nil then
                v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
            else
                v2 = false
                if v7 ~= nil then
                    v2 = v7:GetAttribute("ModalDialog") == true
                end
                if not v2 then
                    v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
                elseif not (2000 <= v1.Priority) then
                    v1 = nil
                else
                    v7 = v1.Root:FindFirstAncestorWhichIsA("LayerCollector")
                end
            end
            local Root = if not v1 then v7 else v1.Root
            u276 = v1
            u275 = Root
            u274 = v7
            restoreSelectableButtons(Root, MenuNavigation.PrefersCursor())
            restorePointerButtons(if not MenuNavigation.PrefersCursor() then nil else Root)
            if v7 ~= nil and v7.Name ~= "HUD" then
                v3 = ("%* took focus"):format(v7.Name)
                if u279 ~= false then
                    u279 = false
                    GamepadBindings.EnableMarkers(true)
                    ;(u271:AtDebug()):Log((("HUD navigation OFF (%*); toggle key is %*"):format(v3, ButtonL3.Name)))
                end
            end
            if v7 == nil then
                v5 = if not u279 then "Menus" else "Close Menus"
                ButtonHintStrip.Present("HudNavigation", ButtonL3, v5)
            elseif v7.Name ~= "HUD" then
                ButtonHintStrip.Retract("HudNavigation")
            else
                v5 = if not u279 then "Menus" else "Close Menus"
                ButtonHintStrip.Present("HudNavigation", ButtonL3, v5)
            end
            u274 = v7
            GamepadBindings.FocusScreen(v7, Root)
            if v7 == nil then
                MenuNavigation.SetContext(nil, nil)
                ButtonHintStrip.Retract("NavigationSwitch")
                ButtonHintStrip.Retract("NavigationMode")
                ButtonHintStrip.SetNavigationLayer(nil)
                local SelectedObject = GuiService.SelectedObject
                if SelectedObject ~= nil then
                    v4 = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")
                    v3 = false
                    if v4 ~= nil then
                        v3 = u79[v4.Name] == true
                    end
                else
                    v3 = false
                end
                if not v3 then
                    if GuiService.SelectedObject ~= nil then
                        GuiService.SelectedObject = nil
                    end
                    GuiService.GuiNavigationEnabled = false
                else
                    GuiService.GuiNavigationEnabled = true
                end
                u278 = false
                return
            end
            assert(Root)
            v3 = projectSelectableButtons(Root)
            local SelectedObject_2 = if not v6 then GuiService.SelectedObject else u273[Root]
            if not isEligibleSelection(Root, SelectedObject_2) then
                v4 = u273[Root]
                SelectedObject_2 = if not isEligibleSelection(Root, v4) then if not v1 then v3 else if not isEligibleSelection(Root, v1.Initial) then v3 else v1.Initial else v4
            end
            if MenuNavigation.PrefersCursor() then
                if v6 ~= Root then
                    if SelectedObject_2 then
                        u273[Root] = SelectedObject_2
                    end
                    GuiService.SelectedObject = nil
                end
                GuiService.GuiNavigationEnabled = true
            end
            if MenuNavigation.SetContext(Root, SelectedObject_2) then
                u12 = Root
                projectSelectionContainers(Root, false)
                for n, m in u272:GetChildren() do
                    if m:IsA("ScreenGui") and m.Enabled and m ~= Root and isCursorScopeMember(m, Root) then
                        projectSelectableButtons(m)
                    end
                end
                scopePointerButtons(Root)
                updateNavigationHints(v7)
                u278 = false
                return
            end
            v5 = nil
            local v8 = nil
            for i, j in u14, v5, v8 do
                if i.Parent and i.Interactable ~= j then
                    i.Interactable = j
                end
                u14[i] = nil
            end
            v5 = nil
            v8 = nil
            for k in u7, v5, v8 do
                if not Root or k ~= Root and not k:IsDescendantOf(Root) then
                    if k.Parent ~= nil then
                        k.Selectable = u6[k]
                    end
                    u7[k] = nil
                    u6[k] = nil
                end
            end
            projectSelectionContainers(Root, true)
            updateNavigationHints(v7)
            v4 = false
            if v7 ~= nil then
                v4 = v7:GetAttribute("ModalDialog") == true
            end
            v3 = if not v4 then SelectedObject_2 else nil
            if v3 then
                u273[Root] = v3
                revealSelection(v3)
            end
            if GuiService.SelectedObject ~= v3 then
                GuiService.SelectedObject = v3
            end
            GuiService.GuiNavigationEnabled = v3 ~= nil
            u278 = false
        end

        local function requestReconcile() -- Line: 417 -- upvalues: u277 (ref), reconcile (val)
            if u277 then
                return
            end
            u277 = true
            task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                u277 = false
                reconcile()
            end)
        end

        local function observe(a1) -- Line: 426
            -- upvalues: u9 (val), u74 (upval), GamepadBindings (upval), requestReconcile (val), MenuNavigation (upval)
            -- upvalues: u278 (ref), u277 (ref), reconcile (val), GuiService (upval), u273 (val), u6 (val), u7 (val)
            -- upvalues: u14 (val)
            if u9[a1] then
                return
            end
            u9[a1] = true
            local v1 = if not a1:IsA("ScreenGui") then a1:FindFirstAncestorOfClass("ScreenGui") else a1
            if v1 == nil or not u74[v1.Name] then
                GamepadBindings.Inspect(a1)
            end
            if a1:IsA("LayerCollector") then
                (a1:GetPropertyChangedSignal("Enabled")):Connect(requestReconcile)
                if a1.Name == "PendingPurchase" then
                    (a1:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 440 -- upvalues: MenuNavigation (upval), a1 (val)
                        MenuNavigation.Suspend("Purchase", a1.Enabled)
                    end)
                    MenuNavigation.Suspend("Purchase", a1.Enabled)
                end
            elseif a1:IsA("GuiObject") then
                (a1:GetPropertyChangedSignal("Visible")):Connect(requestReconcile)
                if a1:IsA("GuiButton") or a1:IsA("TextBox") then
                    (a1:GetPropertyChangedSignal("Active")):Connect(requestReconcile)
                    ;(a1:GetPropertyChangedSignal("Interactable")):Connect(function() -- Line: 448 -- upvalues: u278 (upval), u277 (upval), reconcile (upval)
                        if not u278 then
                            if u277 then
                                return
                            end
                            u277 = true
                            task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                                u277 = false
                                reconcile()
                            end)
                        end
                    end)
                    ;(a1:GetAttributeChangedSignal("ConsoleNavigationDisabled")):Connect(requestReconcile)
                end
                ;(a1:GetPropertyChangedSignal("Selectable")):Connect(function() -- Line: 454 -- upvalues: u278 (upval), u277 (upval), reconcile (upval)
                    if not u278 then
                        if u277 then
                            return
                        end
                        u277 = true
                        task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                            u277 = false
                            reconcile()
                        end)
                    end
                end)
                ;(a1:GetPropertyChangedSignal("AbsolutePosition")):Connect(function() -- Line: 457
                    -- upvalues: GuiService (upval), a1 (val), MenuNavigation (upval), u277 (upval), reconcile (upval)
                    if GuiService.SelectedObject == a1 and not MenuNavigation.IsCursorActive() then
                        if u277 then
                            return
                        end
                        u277 = true
                        task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                            u277 = false
                            reconcile()
                        end)
                    end
                end)
            end
            a1.Destroying:Once(function() -- Line: 461
                -- upvalues: u9 (upval), a1 (val), u273 (upval), u6 (upval), u7 (upval), u14 (upval), u277 (upval)
                -- upvalues: reconcile (upval)
                u9[a1] = nil
                if a1:IsA("ScreenGui") then
                    u273[a1] = nil
                elseif a1:IsA("GuiObject") then
                    u6[a1] = nil
                    u7[a1] = nil
                    if a1:IsA("GuiButton") then
                        u14[a1] = nil
                    end
                end
                if a1:IsA("GuiObject") then
                    for i, j in u273 do
                        if j == a1 then
                            u273[i] = nil
                        end
                    end
                end
                if u277 then
                    return
                end
                u277 = true
                task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                    u277 = false
                    reconcile()
                end)
            end)
        end

        local v3 = {"ShopButton", "IndexButton", "EggsButton", "PetsButton"}
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = Hud.Find(j, "Game")
            v2 = Hud.Find(j, "Treadmill")
            GamepadGlyph = if not v1 then nil else v1:FindFirstChild("GamepadGlyph")
            if GamepadGlyph and v2 and not v2:FindFirstChild("GamepadGlyph") then
                GamepadGlyph:Clone().Parent = v2
            end
        end
        for k, n in u272:GetDescendants() do
            observe(n)
        end
        for m, i5 in u272:GetChildren() do
            observe(i5)
        end
        u272.DescendantAdded:Connect(function(a1) -- Line: 503 -- upvalues: observe (val), u277 (ref), reconcile (val) -- types: a1: userdata
            observe(a1)
            if u277 then
                return
            end
            u277 = true
            task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                u277 = false
                reconcile()
            end)
        end)
        u272.DescendantRemoving:Connect(requestReconcile)
        ;(GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(function() -- Line: 508
            -- upvalues: u278 (ref), MenuNavigation (upval), u275 (ref), GuiService (upval), isCursorScopeMember (val)
            -- upvalues: GamepadBindings (upval), isEligibleSelection (val), u273 (val), revealSelection (val)
            -- upvalues: u274 (ref), u277 (ref), reconcile (val), PlatformController (upval), u79 (upval)
            if not u278 and not MenuNavigation.IsSuspended() then
                local v1, v2
                local v3 = u275
                local SelectedObject = GuiService.SelectedObject
                if MenuNavigation.IsCursorActive() then
                    if SelectedObject then
                        if v3 == nil
                            or not isCursorScopeMember(SelectedObject, v3)
                            or not SelectedObject.Selectable
                            or not SelectedObject.Interactable
                            or not GamepadBindings.IsOnScreen(SelectedObject)
                            or SelectedObject:GetAttribute("ConsoleNavigationDisabled") == true
                            or SelectedObject:IsA("GuiButton") and not SelectedObject.Active then
                            GuiService.SelectedObject = nil
                        end
                    end
                    GuiService.GuiNavigationEnabled = true
                    return
                end
                if v3 ~= nil and isEligibleSelection(v3, SelectedObject) then
                    u273[v3] = SelectedObject
                    revealSelection(SelectedObject)
                    return
                end
                if v3 ~= nil then
                    v2 = u274
                    v1 = false
                    if v2 ~= nil then
                        v1 = v2:GetAttribute("ModalDialog") == true
                    end
                    if not v1 then
                        if u277 then
                            return
                        end
                        u277 = true
                        task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                            u277 = false
                            reconcile()
                        end)
                        return
                    end
                end
                if PlatformController.IsConsole() and v3 == nil then
                    v1 = GuiService
                    if SelectedObject ~= nil then
                        local v4 = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")
                        v2 = false
                        if v4 ~= nil then
                            v2 = u79[v4.Name] == true
                        end
                    else
                        v2 = false
                    end
                    v1.GuiNavigationEnabled = v2
                end
                return
            end
        end)
        MenuNavigation.Changed:Connect(requestReconcile)
        MenuNavigation.SaveFailed:Connect(function() -- Line: 534 -- upvalues: Toast (upval)
            Toast.Show({
                Text = "Navigation changed for this session, but could not be saved. Please try again in Settings.",
                Seconds = 6,
                WrapText = true,
            })
        end)
        MenuNavigation.CursorFailed:Connect(function() -- Line: 537 -- upvalues: Toast (upval)
            Toast.Show({Text = "Cursor unavailable. Button navigation is still available.", Seconds = 5})
        end)
        PlatformController.Changed:Connect(requestReconcile)
        Tabs.Activated:Connect(requestReconcile)
        Tabs.Deactivated:Connect(requestReconcile)
        UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 544
            -- upvalues: MenuNavigation (upval), ButtonL3 (upval), u279 (ref), GamepadBindings (upval), u271 (val)
            -- upvalues: u277 (ref), reconcile (val), ButtonB (upval)
            if not MenuNavigation.IsSuspended() and not a2 then
                local v1
                if a1.KeyCode == ButtonL3 then
                    v1 = not u279
                    local v2 = ("pressed %*"):format(a1.KeyCode.Name)
                    if u279 ~= v1 then
                        u279 = v1
                        GamepadBindings.EnableMarkers(not v1)
                        ;(u271:AtDebug()):Log((("HUD navigation %* (%*); toggle key is %*"):format(if not v1 then "OFF" else "ON", v2, ButtonL3.Name)))
                    end
                    if u277 then
                        return
                    end
                    u277 = true
                    task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                        u277 = false
                        reconcile()
                    end)
                    return
                end
                if a1.KeyCode == ButtonB and u279 then
                    v1 = ("pressed %*"):format(a1.KeyCode.Name)
                    if u279 ~= false then
                        u279 = false
                        GamepadBindings.EnableMarkers(true)
                        ;(u271:AtDebug()):Log((("HUD navigation OFF (%*); toggle key is %*"):format(v1, ButtonL3.Name)))
                    end
                    if u277 then
                        return
                    end
                    u277 = true
                    task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                        u277 = false
                        reconcile()
                    end)
                end
                return
            end
        end)
        local u155 = {}
        local u156 = {}

        local function switchNavigation(a1) -- Line: 564
            -- upvalues: MenuNavigation (upval), u275 (ref), u156 (val)
            if a1.KeyCode == MenuNavigation.SwitchKey and u275 ~= nil and not MenuNavigation.IsSuspended() then
                local UserInputType = a1.UserInputType
                if not u156[UserInputType] then
                    u156[UserInputType] = true
                    MenuNavigation.Toggle()
                end
                return true
            end
            return false
        end

        UserInputService.InputBegan:Connect(function(a1) -- Line: 577 -- upvalues: MenuNavigation (upval), u275 (ref), u156 (val) -- types: a1: userdata
            if a1.KeyCode == MenuNavigation.SwitchKey and u275 ~= nil then
                if MenuNavigation.IsSuspended() then
                    return
                end
                local UserInputType = a1.UserInputType
                if not u156[UserInputType] then
                    u156[UserInputType] = true
                    MenuNavigation.Toggle()
                end
            end
        end)
        UserInputService.InputEnded:Connect(function(a1) -- Line: 581 -- upvalues: MenuNavigation (upval), u156 (val) -- types: a1: userdata
            if a1.KeyCode == MenuNavigation.SwitchKey then
                u156[a1.UserInputType] = nil
            end
        end)
        UserInputService.GamepadDisconnected:Connect(function(a1) -- Line: 586 -- upvalues: u156 (val)
            u156[a1] = nil
        end)
        UserInputService.WindowFocusReleased:Connect(function() -- Line: 589 -- upvalues: u156 (val), u155 (val)
            table.clear(u156)
            table.clear(u155)
        end)
        local v6 = ContextActionService
        local v7 = Enum.ContextActionPriority.High.Value + 250
        local SwitchKey = MenuNavigation.SwitchKey
        local ButtonB_2 = Enum.KeyCode.ButtonB
        v6:BindActionAtPriority("MenuNavigationSwitch", function(a1, a2, a3) -- Line: 596
            -- upvalues: u155 (val), u156 (val), MenuNavigation (upval), u275 (ref), u276 (ref), u279 (ref)
            -- upvalues: GamepadBindings (upval), u271 (val), ButtonL3 (upval), u277 (ref), reconcile (val)
            local v1
            local KeyCode = a3.KeyCode
            if a2 == Enum.UserInputState.Cancel then
                v1 = next(u155) ~= nil
                table.clear(u155)
                table.clear(u156)
                if v1 then
                    return Enum.ContextActionResult.Sink
                end
                return Enum.ContextActionResult.Pass
            end
            if a2 ~= Enum.UserInputState.Begin then
                v1 = u155[KeyCode]
                if a2 == Enum.UserInputState.End then
                    u155[KeyCode] = nil
                    if KeyCode == MenuNavigation.SwitchKey then
                        u156[a3.UserInputType] = nil
                    end
                end
                if v1 then
                    return Enum.ContextActionResult.Sink
                end
                return Enum.ContextActionResult.Pass
            end
            if u275 ~= nil and not MenuNavigation.IsSuspended() then
                if KeyCode == MenuNavigation.SwitchKey then
                    u155[KeyCode] = true
                    if a3.KeyCode == MenuNavigation.SwitchKey
                        and u275 ~= nil
                        and not MenuNavigation.IsSuspended() then
                        local UserInputType = a3.UserInputType
                        if not u156[UserInputType] then
                            u156[UserInputType] = true
                            MenuNavigation.Toggle()
                        end
                    end
                    return Enum.ContextActionResult.Sink
                end
                if KeyCode == Enum.KeyCode.ButtonB then
                    if u276 and u276.Back then
                        if not MenuNavigation.IsCursorActive() and not u276.BackInButtons then
                            if not u279 then
                                return Enum.ContextActionResult.Pass
                            end
                            u155[KeyCode] = true
                            if u279 ~= false then
                                u279 = false
                                GamepadBindings.EnableMarkers(true)
                                ;(u271:AtDebug()):Log((("HUD navigation OFF (Back); toggle key is %*"):format(ButtonL3.Name)))
                            end
                            if not u277 then
                                u277 = true
                                task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                                    u277 = false
                                    reconcile()
                                end)
                            end
                            return Enum.ContextActionResult.Sink
                        end
                        u155[KeyCode] = true
                        u276.Back()
                        return Enum.ContextActionResult.Sink
                    end
                    if u279 then
                        u155[KeyCode] = true
                        if u279 ~= false then
                            u279 = false
                            GamepadBindings.EnableMarkers(true)
                            ;(u271:AtDebug()):Log((("HUD navigation OFF (Back); toggle key is %*"):format(ButtonL3.Name)))
                        end
                        if not u277 then
                            u277 = true
                            task.defer(function() -- Line: 420 -- upvalues: u277 (upval), reconcile (upval)
                                u277 = false
                                reconcile()
                            end)
                        end
                        return Enum.ContextActionResult.Sink
                    end
                end
                return Enum.ContextActionResult.Pass
            end
            return Enum.ContextActionResult.Pass
        end, false, v7, SwitchKey, ButtonB_2)
        GuiService.AutoSelectGuiEnabled = false
        GamepadBindings.Rescan(PlatformController.Platform())
        reconcile()
        u271:AtInfo():Log("Console navigation initialized")
    end,
}