-- Script path: ReplicatedStorage.Controllers.GUI.SettingsController
-- Decompile time: 18.01 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TopBarPlus = require(ReplicatedStorage.Packages.TopBarPlus)
return {
    Start = function() -- Line: 14
        -- upvalues: TopBarPlus (val), ReplicatedStorage (val), TweenService (val), UserInputService (val)
        -- upvalues: Players (val)
        local u2 = TopBarPlus.new()
        ;(((u2:setName("Settings")):setImage(101403250204482)):modifyTheme({"IconImage", "ScaleType", Enum.ScaleType.Fit})):setImageScale(0.8)
        u2:bindEvent("toggled", function() -- Line: 21 -- upvalues: ReplicatedStorage (upval)
            local Audio = require(ReplicatedStorage.Shared.Audio)
            local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
            local Tabs = require(ReplicatedStorage.Client.Tabs)
            Audio.Play(Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND, script, {Volume = 1.8, PlaybackSpeed = math.random(95, 105) / 100})
            Tabs.Toggle("Settings")
        end)
        local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
        local GUI = require(ReplicatedStorage.Client.GUI)
        local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
        local Preferences = require(ReplicatedStorage.Shared.Preferences)
        local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
        local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
        local AudioSettingsController = require(ReplicatedStorage.Controllers.Game.AudioSettingsController)
        local u69 = UDim2.fromScale(0.75, 0.5)
        local u73 = UDim2.fromScale(0.25, 0.5)
        local u85 = ColorSequence.new(Color3.fromRGB(212, 255, 0), Color3.fromRGB(0, 255, 8))
        local u97 = ColorSequence.new(Color3.fromRGB(255, 58, 61), Color3.fromRGB(255, 2, 6))
        local u102 = TweenInfo.new(0.15, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        HiddenUIHandler.Changed:Connect(function() -- Line: 72 -- upvalues: u2 (val), HiddenUIHandler (val)
            u2:setEnabled(not (HiddenUIHandler.IsHidden()))
        end)
        u2:setEnabled(not (HiddenUIHandler.IsHidden()))
        local ScrollingFrame = GUI.Settings().Frame.ScrollingFrame
        assert(ScrollingFrame:IsA("ScrollingFrame"), "Settings scrolling frame must be a ScrollingFrame")
        local u126 = {}
        local u127 = {}
        local v1 = {}

        local function displayedState(a1, a2) -- Line: 92 -- upvalues: Preferences (val) -- types: a2: boolean
            local v1 = Preferences.IsOn(a1)
            if a2 then
                return not v1
            end
            return v1
        end

        local function applyToggleVisuals(a1, a2, a3) -- Line: 97
            -- upvalues: u85 (val), u97 (val), u69 (val), u73 (val), TweenService (upval), u102 (val)
            local v1 = if not a2 then "OFF" else "ON"
            a1.Status.Text = v1
            v1 = if not a2 then u97 else u85
            a1.KnobGradient.Color = v1
            local v2 = if not a2 then u73 else u69
            if a3 then
                a1.Knob.Position = v2
                return
            end
            TweenService:Create(a1.Knob, u102, {Position = v2}):Play()
        end

        local function refreshToggle(a1) -- Line: 108
            -- upvalues: u127 (val), applyToggleVisuals (val), Preferences (val)
            local v1 = u127[a1]
            if v1 then
                local Inverted = v1.Inverted
                local v2 = Preferences.IsOn(a1)
                applyToggleVisuals(v1, if not Inverted then v2 else not v2)
            end
        end

        local function attemptToggle(a1) -- Line: 115
            -- upvalues: u126 (val), Preferences (val), u127 (val), applyToggleVisuals (val)
            if u126[a1] then
                return
            end
            u126[a1] = true
            local v1 = Preferences.Toggle(a1)
            u126[a1] = nil
            if not v1 then
                local v2 = u127[a1]
                if v2 then
                    local Inverted = v2.Inverted
                    local v3 = Preferences.IsOn(a1)
                    applyToggleVisuals(v2, if not Inverted then v3 else not v3)
                end
            end
        end

        local function registerToggleRow(a1, a2) -- Line: 129
            -- upvalues: ScrollingFrame (val), u127 (val), ButtonFX (val), u126 (val), Preferences (val)
            -- upvalues: applyToggleVisuals (val), u85 (val), u97 (val), u69 (val), u73 (val)
            local v1 = ScrollingFrame:FindFirstChild(a1)
            if v1 and v1:IsA("GuiObject") then
                local ControlBar = v1:FindFirstChild("ControlBar")
                local Btn = if not ControlBar then nil else ControlBar:FindFirstChild("Btn")
                local v2 = v1:FindFirstChild("Description")
                if Btn and Btn:IsA("ImageButton") and v2 and v2:IsA("TextLabel") then
                    local v3
                    local UIGradient = Btn:FindFirstChildOfClass("UIGradient")
                    if not UIGradient then
                        return
                    end
                    local v4 = {
                        Row = v1,
                        Knob = Btn,
                        KnobGradient = UIGradient,
                        Status = v2,
                        Inverted = a2,
                    }
                    u127[a1] = v4
                    ButtonFX(Btn, nil, function() -- Line: 156
                        -- upvalues: a1 (val), u126 (upval), Preferences (upval), u127 (upval)
                        -- upvalues: applyToggleVisuals (upval)
                        local v1 = a1
                        if u126[v1] then
                            return
                        end
                        u126[v1] = true
                        local v2 = Preferences.Toggle(v1)
                        u126[v1] = nil
                        if not v2 then
                            local v3 = u127[v1]
                            if v3 then
                                local v4 = applyToggleVisuals
                                local Inverted = v3.Inverted
                                local v5 = Preferences.IsOn(v1)
                                v4(v3, if not Inverted then v5 else not v5)
                            end
                        end
                    end)
                    local v5 = Preferences.IsOn(a1)
                    v4.Status.Text = if not (if not a2 then v5 else not v5) then "OFF" else "ON"
                    local v6 = if not v3 then u97 else u85
                    v4.KnobGradient.Color = v6
                    local v7 = if not v3 then u73 else u69
                    v4.Knob.Position = v7
                    return
                end
                return
            end
        end

        local function applySliderVisuals(a1, a2) -- Line: 160 -- types: a1: table, a2: number
            a1.Fill.Size = UDim2.new(a2, 0, 1, 0)
            a1.Fill.Position = UDim2.new(a2 / 2, 0, 0.5, 0)
            a1.Stick.Position = UDim2.new(a2, 0, 0.4887853, 0)
            a1.Handle.Position = a1.Stick.Position
        end

        local function settleSliderBoolean(a1, a2) -- Line: 169
            -- upvalues: Preferences (val), u126 (val), u127 (val), applyToggleVisuals (val)
            local v1 = a2 > 0
            if Preferences.IsOn(a1) ~= v1 then
                if u126[a1] then
                    return
                end
                u126[a1] = true
                local v2 = Preferences.Toggle(a1)
                u126[a1] = nil
                if not v2 then
                    local v3 = u127[a1]
                    if v3 then
                        local Inverted = v3.Inverted
                        local v4 = Preferences.IsOn(a1)
                        applyToggleVisuals(v3, if not Inverted then v4 else not v4)
                    end
                end
            end
        end

        local function registerSliderRow(a1, a2) -- Line: 176
            -- upvalues: ScrollingFrame (val), applySliderVisuals (val), AudioSettingsController (val)
            -- upvalues: Preferences (val), u126 (val), u127 (val), applyToggleVisuals (val), UserInputService (upval)
            local v1 = ScrollingFrame:FindFirstChild(a1)
            if v1 and v1:IsA("GuiObject") then
                local ControlBar = v1:FindFirstChild("ControlBar")
                local Fill = if not ControlBar then nil else ControlBar:FindFirstChild("Fill")
                local Stick = if not ControlBar then nil else ControlBar:FindFirstChild("Stick")
                if ControlBar
                    and ControlBar:IsA("GuiObject")
                    and Fill
                    and Fill:IsA("Frame")
                    and Stick
                    and Stick:IsA("Frame") then
                    local TextButton = Instance.new("TextButton")
                    TextButton.Name = "VolumeDragHandle"
                    TextButton.Text = ""
                    TextButton.BackgroundTransparency = 1
                    TextButton.AnchorPoint = Stick.AnchorPoint
                    TextButton.Size = Stick.Size
                    TextButton.ZIndex = Stick.ZIndex + 1
                    TextButton.Active = true
                    TextButton.Selectable = true
                    TextButton.Parent = ControlBar
                    local u54 = {
                        Row = v1,
                        Bar = ControlBar,
                        Fill = Fill,
                        Stick = Stick,
                        Handle = TextButton,
                        Category = a2,
                    }
                    local u59 = false
                    v1 = Instance.new("UIDragDetector")
                    v1.Name = "VolumeDragDetector"
                    v1.DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine
                    v1.DragAxis = Vector2.new(1, 0)
                    v1.ResponseStyle = Enum.UIDragDetectorResponseStyle.Scale
                    v1.BoundingUI = ControlBar
                    v1.BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.HitPoint
                    v1.SelectionModeDragSpeed = UDim2.fromScale(0.15, 0)
                    v1.Parent = TextButton
                    v1.DragStart:Connect(function() -- Line: 226 -- upvalues: u59 (ref)
                        u59 = true
                    end)
                    ;(TextButton:GetPropertyChangedSignal("Position")):Connect(function() -- Line: 229
                        -- upvalues: u59 (ref), TextButton (val), ControlBar (val), applySliderVisuals (upval)
                        -- upvalues: u54 (val), AudioSettingsController (upval), a2 (val)
                        if not u59 then
                            return
                        end
                        local v1 = math.clamp(
                            TextButton.Position.X.Scale + TextButton.Position.X.Offset / math.max(ControlBar.AbsoluteSize.X, 1),
                            0,
                            1
                        )
                        applySliderVisuals(u54, v1)
                        AudioSettingsController.Set(a2, v1)
                    end)
                    v1.DragEnd:Connect(function() -- Line: 238
                        -- upvalues: u59 (ref), a1 (val), AudioSettingsController (upval), a2 (val), Preferences (upval)
                        -- upvalues: u126 (upval), u127 (upval), applyToggleVisuals (upval)
                        u59 = false
                        local v1 = a1
                        local v2 = 0 < AudioSettingsController.Get(a2)
                        if Preferences.IsOn(v1) ~= v2 then
                            if u126[v1] then
                                return
                            end
                            u126[v1] = true
                            local v3 = Preferences.Toggle(v1)
                            u126[v1] = nil
                            if not v3 then
                                local v4 = u127[v1]
                                if v4 then
                                    local v5 = applyToggleVisuals
                                    local Inverted = v4.Inverted
                                    local v6 = Preferences.IsOn(v1)
                                    v5(v4, if not Inverted then v6 else not v6)
                                end
                            end
                        end
                    end)
                    v1 = Instance.new("Frame")
                    v1.Name = "VolumeTrackInput"
                    v1.BackgroundTransparency = 1
                    v1.Size = UDim2.fromScale(1, 1)
                    v1.ZIndex = math.max(Fill.ZIndex, Stick.ZIndex) + 1
                    v1.Active = true
                    v1.Selectable = false
                    v1.Parent = ControlBar
                    TextButton.ZIndex = v1.ZIndex + 1
                    local u115 = nil
                    local u116 = Vector3.new(0, 0, 0)
                    local u117 = false

                    local function setFromPointer(a1) -- Line: 259
                        -- upvalues: ControlBar (val), applySliderVisuals (upval), u54 (val)
                        -- upvalues: AudioSettingsController (upval), a2 (val)
                        local v1 = math.clamp((a1.X - ControlBar.AbsolutePosition.X) / math.max(ControlBar.AbsoluteSize.X, 1), 0, 1)
                        applySliderVisuals(u54, v1)
                        AudioSettingsController.Set(a2, v1)
                    end

                    v1.InputBegan:Connect(function(a1) -- Line: 265
                        -- upvalues: u115 (ref), u59 (ref), u116 (ref), u117 (ref), ControlBar (val)
                        -- upvalues: applySliderVisuals (upval), u54 (val), AudioSettingsController (upval), a2 (val)
                        if not u115 and not u59 then
                            if a1.UserInputType ~= Enum.UserInputType.MouseButton1
                                and a1.UserInputType ~= Enum.UserInputType.Touch then
                                return
                            end
                            u115 = a1
                            u116 = a1.Position
                            u117 = false
                            if a1.UserInputType == Enum.UserInputType.MouseButton1 then
                                local v1 = math.clamp((a1.Position.X - ControlBar.AbsolutePosition.X) / math.max(ControlBar.AbsoluteSize.X, 1), 0, 1)
                                applySliderVisuals(u54, v1)
                                AudioSettingsController.Set(a2, v1)
                            end
                            return
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(a1) -- Line: 277
                        -- upvalues: u115 (ref), ControlBar (val), applySliderVisuals (upval), u54 (val)
                        -- upvalues: AudioSettingsController (upval), a2 (val), u117 (ref), u116 (ref)
                        local v1
                        local v2 = u115
                        if not v2 then
                            return
                        end
                        if v2.UserInputType == Enum.UserInputType.MouseButton1 then
                            if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
                                return
                            end
                            v1 = math.clamp((a1.Position.X - ControlBar.AbsolutePosition.X) / math.max(ControlBar.AbsoluteSize.X, 1), 0, 1)
                            applySliderVisuals(u54, v1)
                            AudioSettingsController.Set(a2, v1)
                            return
                        end
                        if a1 == v2 then
                            if not u117 then
                                local v3 = a1.Position - u116
                                if v3.Magnitude < 8 then
                                    return
                                end
                                v1 = math.abs(v3.Y)
                                if math.abs(v3.X) <= v1 then
                                    u115 = nil
                                    return
                                end
                                u117 = true
                            end
                            v1 = math.clamp((a1.Position.X - ControlBar.AbsolutePosition.X) / math.max(ControlBar.AbsoluteSize.X, 1), 0, 1)
                            applySliderVisuals(u54, v1)
                            AudioSettingsController.Set(a2, v1)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(a1_2) -- Line: 298
                        -- upvalues: u115 (ref), ControlBar (val), applySliderVisuals (upval), u54 (val)
                        -- upvalues: AudioSettingsController (upval), a2 (val), a1 (val), Preferences (upval)
                        -- upvalues: u126 (upval), u127 (upval), applyToggleVisuals (upval)
                        if a1_2 ~= u115 then
                            return
                        end
                        u115 = nil
                        if a1_2.UserInputState == Enum.UserInputState.Cancel then
                            return
                        end
                        if a1_2.UserInputType == Enum.UserInputType.Touch then
                            local v1 = math.clamp((a1_2.Position.X - ControlBar.AbsolutePosition.X) / math.max(ControlBar.AbsoluteSize.X, 1), 0, 1)
                            applySliderVisuals(u54, v1)
                            AudioSettingsController.Set(a2, v1)
                        end
                        local v2 = a1
                        local v3 = 0 < AudioSettingsController.Get(a2)
                        if Preferences.IsOn(v2) ~= v3 then
                            if u126[v2] then
                                return
                            end
                            u126[v2] = true
                            local v4 = Preferences.Toggle(v2)
                            u126[v2] = nil
                            if not v4 then
                                local v5 = u127[v2]
                                if v5 then
                                    local v6 = applyToggleVisuals
                                    local Inverted = v5.Inverted
                                    local v7 = Preferences.IsOn(v2)
                                    v6(v5, if not Inverted then v7 else not v7)
                                end
                            end
                        end
                    end)
                    Preferences.Observe(a1, function(a1) -- Line: 310
                        -- upvalues: u59 (ref), u115 (ref), applySliderVisuals (upval), u54 (val)
                        -- upvalues: AudioSettingsController (upval), a2 (val)
                        if not u59 and not u115 then
                            if not a1 then
                                applySliderVisuals(u54, 0)
                                return
                            end
                            if AudioSettingsController.Get(a2) == 0 then
                                AudioSettingsController.Set(a2, 1)
                            end
                            applySliderVisuals(u54, AudioSettingsController.Get(a2))
                            return
                        end
                    end)
                    return
                end
                return
            end
        end

        local function applyCreatorSettingVisibility() -- Line: 326
            -- upvalues: ScrollingFrame (val), Players (upval), UserInputService (upval)
            local CreatorPanel = ScrollingFrame:FindFirstChild("CreatorPanel")
            if CreatorPanel and CreatorPanel:IsA("GuiObject") then
                local v1 = false
                if Players.LocalPlayer:GetAttribute("CreatorPanelAccess") == true then
                    v1 = not UserInputService.KeyboardEnabled
                end
                CreatorPanel.Visible = v1
            end
        end

        local function applyVideoSettingVisibility() -- Line: 336
            -- upvalues: ScrollingFrame (val), TreadmillVideoGate (val)
            local DisableVideos = ScrollingFrame:FindFirstChild("DisableVideos")
            if DisableVideos and DisableVideos:IsA("GuiObject") then
                DisableVideos.Visible = not TreadmillVideoGate.IsVideoPlayerDisabled()
            end
        end

        local function registerNavigationRow() -- Line: 347
            -- upvalues: ScrollingFrame (val), UserInputService (upval), MenuNavigation (val), ButtonFX (val)
            local MenuNavigation_2 = ScrollingFrame:WaitForChild("MenuNavigation")
            local Buttons = MenuNavigation_2:WaitForChild("Buttons")
            local Cursor = MenuNavigation_2:WaitForChild("Cursor")

            local function refresh() -- Line: 351
                -- upvalues: MenuNavigation_2 (val), UserInputService (upval), MenuNavigation (upval), Buttons (val)
                -- upvalues: Cursor (val)
                local Caption, v1, v2, v3
                MenuNavigation_2.Visible = UserInputService.GamepadEnabled
                local v4 = MenuNavigation.PrefersCursor()
                local v5 = {Buttons, Cursor}
                local v6 = nil
                local v7 = nil
                for i, j in v5, v6, v7 do
                    v3 = if not (j == Cursor == v4) then Color3.fromRGB(68, 68, 86) else Color3.fromRGB(112, 255, 24)
                    j.BackgroundColor3 = v3
                    Caption = j:FindFirstChild("Caption")
                    v1 = if not v2 then "" else " (Selected)"
                    Caption.Text = j.Name .. v1
                end
            end

            ButtonFX(Buttons, nil, function() -- Line: 361 -- upvalues: MenuNavigation (upval)
                MenuNavigation.SetPreference(false)
            end)
            ButtonFX(Cursor, nil, function() -- Line: 362 -- upvalues: MenuNavigation (upval)
                MenuNavigation.SetPreference(true)
            end)
            MenuNavigation.Changed:Connect(refresh)
            UserInputService.GamepadConnected:Connect(refresh)
            UserInputService.GamepadDisconnected:Connect(refresh)
            refresh()
        end

        function v1.Init() -- Line: 369
            -- upvalues: registerNavigationRow (val), registerSliderRow (val), registerToggleRow (val)
            -- upvalues: Preferences (val), u127 (val), applyToggleVisuals (val), TreadmillVideoGate (val)
            -- upvalues: applyVideoSettingVisibility (val), ScrollingFrame (val), Players (upval)
            -- upvalues: applyCreatorSettingVisibility (val), UserInputService (upval)
            registerNavigationRow()
            registerSliderRow("Music", "Music")
            registerSliderRow("SFX", "SFX")
            registerToggleRow("HideOtherPets", true)
            registerToggleRow("HideSelfPets", true)
            registerToggleRow("DisableVideos", true)
            registerToggleRow("CreatorPanel", false)
            local v1 = nil
            for i, j in {"HideOtherPets", "HideSelfPets", "DisableVideos", "CreatorPanel"}, v1 do
                Preferences.Observe(j, function() -- Line: 380 -- upvalues: j (val), u127 (upval), applyToggleVisuals (upval), Preferences (upval)
                    local v1 = j
                    local v2 = u127[v1]
                    if v2 then
                        local v3 = applyToggleVisuals
                        local Inverted = v2.Inverted
                        local v4 = Preferences.IsOn(v1)
                        v3(v2, if not Inverted then v4 else not v4)
                    end
                end)
            end
            TreadmillVideoGate.Changed:Connect(applyVideoSettingVisibility)
            local DisableVideos = ScrollingFrame:FindFirstChild("DisableVideos")
            if DisableVideos and DisableVideos:IsA("GuiObject") then
                DisableVideos.Visible = not TreadmillVideoGate.IsVideoPlayerDisabled()
            end
            ;(Players.LocalPlayer:GetAttributeChangedSignal("CreatorPanelAccess")):Connect(applyCreatorSettingVisibility)
            local CreatorPanel = ScrollingFrame:FindFirstChild("CreatorPanel")
            if CreatorPanel and CreatorPanel:IsA("GuiObject") then
                v1 = false
                if Players.LocalPlayer:GetAttribute("CreatorPanelAccess") == true then
                    v1 = not UserInputService.KeyboardEnabled
                end
                CreatorPanel.Visible = v1
            end
        end

        v1.Init()
    end,
}