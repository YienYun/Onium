-- Script path: ReplicatedStorage.Controllers.Game.ProximityPromptScriptController
-- Decompile time: 31.34 ms

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
return {
    Start = function() -- Line: 14
        -- upvalues: Players (val), Workspace (val), TweenService (val), InputIconsConfig (val), UserInputService (val)
        -- upvalues: TextService (val), RunService (val), ProximityPromptService (val)
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local u10 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local u11 = {}

        local function cleanupWildEggTween() -- Line: 37 -- upvalues: u11 (val)
            if u11.tween then
                u11.tween:Cancel()
                u11.tween = nil
            end
        end

        local function isWildEggPrompt(a1) -- Line: 44 -- types: a1: userdata
            if typeof((a1:GetAttribute("Progress"))) ~= "number" then
                return false
            end
            local Parent = a1.Parent
            if not Parent then
                return false
            end
            return Parent.Name == "WildAssetEgg"
        end

        local function applyWildEggZoom(a1, a2) -- Line: 57
            -- upvalues: Workspace (upval), u11 (val), TweenService (upval), u10 (val)
            local CurrentCamera = Workspace.CurrentCamera
            if not CurrentCamera then
                return
            end
            local v1 = math.clamp(a2, 0, 1)
            if v1 <= 0 then
                if u11.prompt == a1 and u11.baseFov then
                    if u11.tween then
                        u11.tween:Cancel()
                        u11.tween = nil
                    end
                    u11.tween = TweenService:Create(CurrentCamera, u10, {FieldOfView = u11.baseFov})
                    assert(u11.tween, "luau")
                    u11.tween:Play()
                    u11.prompt = nil
                    u11.baseFov = nil
                end
                return
            end
            if u11.prompt ~= a1 then
                u11.prompt = a1
                u11.baseFov = CurrentCamera.FieldOfView
            end
            local baseFov = u11.baseFov
            if not baseFov then
                return
            end
            local v2 = baseFov + (math.max(40, baseFov - 30) - baseFov) * v1
            if (math.abs(CurrentCamera.FieldOfView - v2)) < 0.001 then
                return
            end
            if u11.tween then
                u11.tween:Cancel()
                u11.tween = nil
            end
            u11.tween = TweenService:Create(CurrentCamera, u10, {FieldOfView = v2})
            assert(u11.tween, "luau")
            u11.tween:Play()
        end

        local function gamepadButtonImage(a1) -- Line: 104 -- upvalues: InputIconsConfig (upval)
            return InputIconsConfig.Image(a1)
        end

        local u16 = {
            [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
            [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
            [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
            [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
            [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png",
        }
        local u27 = {
            ["'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
            [","] = "rbxasset://textures/ui/Controls/comma.png",
            ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
            ["."] = "rbxasset://textures/ui/Controls/period.png",
            [" "] = "rbxasset://textures/ui/Controls/spacebar.png",
        }
        local u33 = {
            [Enum.KeyCode.LeftControl] = "Ctrl",
            [Enum.KeyCode.RightControl] = "Ctrl",
            [Enum.KeyCode.LeftAlt] = "Alt",
            [Enum.KeyCode.RightAlt] = "Alt",
            [Enum.KeyCode.F1] = "F1",
            [Enum.KeyCode.F2] = "F2",
            [Enum.KeyCode.F3] = "F3",
            [Enum.KeyCode.F4] = "F4",
            [Enum.KeyCode.F5] = "F5",
            [Enum.KeyCode.F6] = "F6",
            [Enum.KeyCode.F7] = "F7",
            [Enum.KeyCode.F8] = "F8",
            [Enum.KeyCode.F9] = "F9",
            [Enum.KeyCode.F10] = "F10",
            [Enum.KeyCode.F11] = "F11",
            [Enum.KeyCode.F12] = "F12",
        }

        local function getScreenGui() -- Line: 143 -- upvalues: PlayerGui (val)
            local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
            if ProximityPrompts == nil then
                ProximityPrompts = Instance.new("ScreenGui")
                ProximityPrompts.Name = "ProximityPrompts"
                ProximityPrompts.ResetOnSpawn = false
                ProximityPrompts.Parent = PlayerGui
            end
            return ProximityPrompts
        end

        local function setUpCircularProgressBar(a1) -- Line: 154
            local UIGradient = a1.LeftGradient.ProgressBarImage.UIGradient
            local UIGradient_2 = a1.RightGradient.ProgressBarImage.UIGradient
            a1.Progress.Changed:Connect(function(a1) -- Line: 159 -- upvalues: UIGradient (val), UIGradient_2 (val)
                local v1 = math.clamp(a1 * 360, 0, 360)
                UIGradient.Rotation = math.clamp(v1, 180, 360)
                UIGradient_2.Rotation = math.clamp(v1, 0, 180)
            end)
        end

        local function createPrompt(a1, a2, a3) -- Line: 166
            -- upvalues: TweenService (upval), InputIconsConfig (upval), UserInputService (upval), u16 (val), u27 (val)
            -- upvalues: u33 (val), LocalPlayer (val), applyWildEggZoom (val), Workspace (upval), u11 (val), u10 (val)
            -- upvalues: TextService (upval), RunService (upval)
            local setupUnexpectedChildTweens, u343
            local u487 = {}
            local u496 = {}
            local u515 = {}
            local u533 = {}
            local v1 = TweenInfo.new(a1.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local u677 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local u680 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local v2 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local u569 = nil
            local Attribute = a1:GetAttribute("Theme")
            if Attribute then
                local v3 = script:FindFirstChild(Attribute)
                if v3 then
                    u569 = v3:Clone()
                end
            end
            if u569 == nil then
                u569 = script.Default:Clone()
            end
            u569.Enabled = false
            local PromptFrame = u569.PromptFrame
            local InputFrame = PromptFrame.InputFrame
            local ActionText = PromptFrame.ActionText
            local ObjectText = PromptFrame.ObjectText
            local BackgroundTransparency = PromptFrame.BackgroundTransparency
            local ImageTransparency = PromptFrame.ImageTransparency
            PromptFrame.BackgroundTransparency = 1
            PromptFrame.ImageTransparency = 1
            table.insert(
                u487,
                (TweenService:Create(PromptFrame, u677, {
                    BackgroundTransparency = 1,
                    ImageTransparency = 1,
                    Size = UDim2.fromScale(0.5, 1),
                }))
            )
            table.insert(u496, (TweenService:Create(PromptFrame, u677, {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = BackgroundTransparency,
                ImageTransparency = ImageTransparency,
            })))
            table.insert(
                u515,
                (TweenService:Create(PromptFrame, u677, {
                    BackgroundTransparency = 1,
                    ImageTransparency = 1,
                    Size = UDim2.fromScale(0.5, 1),
                }))
            )
            table.insert(u533, (TweenService:Create(PromptFrame, u677, {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = BackgroundTransparency,
                ImageTransparency = ImageTransparency,
            })))

            local function setupUIStrokeTweens(a1) -- Line: 238
                -- upvalues: u487 (val), TweenService (upval), u677 (val), u496 (val), u515 (val), u533 (val)
                local Transparency = a1.Transparency
                a1.Transparency = 1
                table.insert(u487, (TweenService:Create(a1, u677, {Transparency = 1})))
                table.insert(u496, (TweenService:Create(a1, u677, {Transparency = Transparency})))
                table.insert(u515, (TweenService:Create(a1, u677, {Transparency = 1})))
                table.insert(u533, (TweenService:Create(a1, u677, {Transparency = Transparency})))
            end

            local function setupGUIObjectTweens(a1) -- Line: 259
                -- upvalues: u487 (val), TweenService (upval), u677 (val), u496 (val), u515 (val), u533 (val)
                local BackgroundTransparency = a1.BackgroundTransparency
                a1.BackgroundTransparency = 1
                table.insert(u487, (TweenService:Create(a1, u677, {BackgroundTransparency = 1})))
                table.insert(u496, (TweenService:Create(a1, u677, {BackgroundTransparency = BackgroundTransparency})))
                table.insert(u515, (TweenService:Create(a1, u677, {BackgroundTransparency = 1})))
                table.insert(u533, (TweenService:Create(a1, u677, {BackgroundTransparency = BackgroundTransparency})))
            end

            local function setupTextLabelTweens(a1) -- Line: 288
                -- upvalues: u487 (val), TweenService (upval), u677 (val), u496 (val), u515 (val), u533 (val)
                local TextTransparency = a1.TextTransparency
                local TextStrokeTransparency = a1.TextStrokeTransparency
                a1.TextTransparency = 1
                a1.TextStrokeTransparency = 1
                table.insert(u487, (TweenService:Create(a1, u677, {TextTransparency = 1, TextStrokeTransparency = 1})))
                table.insert(u496, (TweenService:Create(a1, u677, {
                    TextTransparency = TextTransparency,
                    TextStrokeTransparency = TextStrokeTransparency,
                })))
                table.insert(u515, (TweenService:Create(a1, u677, {TextTransparency = 1, TextStrokeTransparency = 1})))
                table.insert(u533, (TweenService:Create(a1, u677, {
                    TextTransparency = TextTransparency,
                    TextStrokeTransparency = TextStrokeTransparency,
                })))
            end

            local function setupImageLabelTweens(a1) -- Line: 327
                -- upvalues: u487 (val), TweenService (upval), u677 (val), u496 (val), u515 (val), u533 (val)
                local ImageTransparency = a1.ImageTransparency
                a1.ImageTransparency = 1
                table.insert(u487, (TweenService:Create(a1, u677, {ImageTransparency = 1})))
                table.insert(u496, (TweenService:Create(a1, u677, {ImageTransparency = ImageTransparency})))
                table.insert(u515, (TweenService:Create(a1, u677, {ImageTransparency = 1})))
                table.insert(u533, (TweenService:Create(a1, u677, {ImageTransparency = ImageTransparency})))
            end

            function setupUnexpectedChildTweens(a1) -- Line: 348
                -- upvalues: setupUIStrokeTweens (val), setupGUIObjectTweens (val), setupTextLabelTweens (val)
                -- upvalues: setupImageLabelTweens (val), setupUnexpectedChildTweens (val)
                if a1:IsA("UIStroke") then
                    setupUIStrokeTweens(a1)
                elseif not a1:IsA("UIGradient") and a1:IsA("GuiObject") then
                    setupGUIObjectTweens(a1)
                    if a1:IsA("TextLabel") then
                        setupTextLabelTweens(a1)
                    elseif a1:IsA("ImageLabel") then
                        setupImageLabelTweens(a1)
                    end
                end
                for k, v in pairs(a1:GetChildren()) do
                    setupUnexpectedChildTweens(v)
                end
            end

            local v4 = {[InputFrame] = false, [ActionText] = true, [ObjectText] = true}
            local v5, v6 = a2, a3
            for k, v in pairs(PromptFrame:GetChildren()) do
                if v4[v] == nil then
                    setupUnexpectedChildTweens(v)
                elseif v4[v] == true then
                    for k2, i in pairs(v:GetChildren()) do
                        setupUnexpectedChildTweens(i)
                    end
                end
            end
            local Frame = InputFrame.Frame
            local UIScale = Frame.UIScale
            local v7 = if v5 ~= Enum.ProximityPromptInputType.Touch then 1.33 else 1.6
            table.insert(u487, (TweenService:Create(UIScale, u677, {Scale = v7})))
            table.insert(u496, (TweenService:Create(UIScale, u677, {Scale = 1})))
            setupTextLabelTweens(ActionText)
            setupTextLabelTweens(ObjectText)
            local ButtonFrame = Frame.ButtonFrame
            ;(function() -- Line: 401 -- upvalues: ButtonFrame (val), u515 (val), TweenService (upval), u680 (val), u533 (val)
                local Transparency
                local BackgroundTransparency = ButtonFrame.BackgroundTransparency
                local ImageTransparency = ButtonFrame.ImageTransparency
                table.insert(u515, (TweenService:Create(ButtonFrame, u680, {BackgroundTransparency = 1, ImageTransparency = 1})))
                table.insert(u533, (TweenService:Create(ButtonFrame, u680, {
                    BackgroundTransparency = BackgroundTransparency,
                    ImageTransparency = ImageTransparency,
                })))
                for k, v in pairs(ButtonFrame:getChildren()) do
                    if v:IsA("UIStroke") then
                        Transparency = v.Transparency
                        table.insert(u515, (TweenService:Create(v, u680, {Transparency = 1})))
                        table.insert(u533, (TweenService:Create(v, u680, {Transparency = Transparency})))
                    end
                end
            end)()
            local ButtonImage = Frame.ButtonImage
            local ButtonText = Frame.ButtonText
            local ButtonTextImage = Frame.ButtonTextImage

            local function setupButtonTextTweens() -- Line: 442
                -- upvalues: ButtonText (val), u515 (val), TweenService (upval), u680 (val), u533 (val)
                local Transparency
                local TextTransparency = ButtonText.TextTransparency
                local TextStrokeTransparency = ButtonText.TextStrokeTransparency
                local BackgroundTransparency = ButtonText.BackgroundTransparency
                ButtonText.BackgroundTransparency = 1
                ButtonText.TextStrokeTransparency = 1
                ButtonText.TextTransparency = 1
                table.insert(
                    u515,
                    (TweenService:Create(ButtonText, u680, {TextTransparency = 1, TextStrokeTransparency = 1, BackgroundTransparency = 1}))
                )
                table.insert(u533, (TweenService:Create(ButtonText, u680, {
                    TextTransparency = TextTransparency,
                    TextStrokeTransparency = TextStrokeTransparency,
                    BackgroundTransparency = BackgroundTransparency,
                })))
                for k, v in pairs(ButtonText:getChildren()) do
                    if v:IsA("UIStroke") then
                        Transparency = v.Transparency
                        table.insert(u515, (TweenService:Create(v, u680, {Transparency = 1})))
                        table.insert(u533, (TweenService:Create(v, u680, {Transparency = Transparency})))
                    end
                end
            end

            local function setupButtonImageTweens() -- Line: 482
                -- upvalues: ButtonImage (val), u515 (val), TweenService (upval), u680 (val), u533 (val)
                local ImageTransparency = ButtonImage.ImageTransparency
                local BackgroundTransparency = ButtonImage.BackgroundTransparency
                ButtonImage.BackgroundTransparency = 1
                ButtonImage.ImageTransparency = 1
                table.insert(u515, (TweenService:Create(ButtonImage, u680, {ImageTransparency = 1, BackgroundTransparency = 1})))
                table.insert(u533, (TweenService:Create(ButtonImage, u680, {
                    ImageTransparency = ImageTransparency,
                    BackgroundTransparency = BackgroundTransparency,
                })))
            end

            local function setupIconTweens() -- Line: 504
                -- upvalues: ButtonTextImage (val), u515 (val), TweenService (upval), u680 (val), u533 (val)
                local BackgroundTransparency = ButtonTextImage.BackgroundTransparency
                local ImageTransparency = ButtonTextImage.ImageTransparency
                ButtonTextImage.BackgroundTransparency = 1
                ButtonTextImage.ImageTransparency = 1
                table.insert(u515, (TweenService:Create(ButtonTextImage, u680, {ImageTransparency = 1, BackgroundTransparency = 1})))
                table.insert(u533, (TweenService:Create(ButtonTextImage, u680, {
                    ImageTransparency = ImageTransparency,
                    BackgroundTransparency = BackgroundTransparency,
                })))
            end

            if v5 == Enum.ProximityPromptInputType.Gamepad then
                local GamepadKeyCode = a1.GamepadKeyCode
                local v8 = InputIconsConfig.Image(GamepadKeyCode)
                if v8 then
                    setupIconTweens()
                    ButtonTextImage.Image = v8
                    ButtonText.Visible = false
                    ButtonImage.Visible = false
                    ButtonTextImage.Visible = true
                end
            elseif v5 ~= Enum.ProximityPromptInputType.Touch then
                setupButtonImageTweens()
                ButtonImage.Visible = true
                local StringForKeyCode = UserInputService:GetStringForKeyCode(a1.KeyboardKeyCode)
                local v9 = u16[a1.KeyboardKeyCode]
                if v9 == nil then
                    v9 = u27[StringForKeyCode]
                end
                if v9 == nil then
                    local v10 = u33[a1.KeyboardKeyCode]
                    if v10 then
                        StringForKeyCode = v10
                    end
                end
                if v9 then
                    setupIconTweens()
                    ButtonTextImage.Image = v9
                    ButtonText.Visible = false
                    ButtonTextImage.Visible = true
                elseif StringForKeyCode == nil or StringForKeyCode == "" then
                    error("ProximityPrompt '" .. a1.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(a1.KeyboardKeyCode))
                else
                    if 2 < (string.len(StringForKeyCode)) then
                        ButtonText.TextSize = math.round(ButtonText.TextSize * 6 / 7)
                    end
                    setupButtonTextTweens()
                    ButtonText.Text = StringForKeyCode
                    ButtonTextImage.Visible = false
                    ButtonText.Visible = true
                end
            else
                setupButtonImageTweens()
                ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
                ButtonText.Visible = false
                ButtonTextImage.Visible = false
                ButtonImage.Visible = true
            end
            if v5 == Enum.ProximityPromptInputType.Touch or a1.ClickablePrompt then
                local TextButton = u569.TextButton
                local u318 = false
                TextButton.InputBegan:Connect(function(a1_2) -- Line: 597 -- upvalues: a1 (val), u318 (ref)
                    if a1_2.UserInputType == Enum.UserInputType.Touch then
                        if a1_2.UserInputState ~= Enum.UserInputState.Change then
                            a1:InputHoldBegin()
                            u318 = true
                        end
                    elseif a1_2.UserInputType == Enum.UserInputType.MouseButton1
                        and a1_2.UserInputState ~= Enum.UserInputState.Change then
                        a1:InputHoldBegin()
                        u318 = true
                    end
                end)
                TextButton.InputEnded:Connect(function(a1_2) -- Line: 608 -- upvalues: u318 (ref), a1 (val)
                    if a1_2.UserInputType == Enum.UserInputType.Touch then
                        if u318 then
                            u318 = false
                            a1:InputHoldEnd()
                        end
                    elseif a1_2.UserInputType == Enum.UserInputType.MouseButton1 and u318 then
                        u318 = false
                        a1:InputHoldEnd()
                    end
                end)
                u569.Active = true
            end
            if typeof((a1:GetAttribute("Progress"))) == "number" then
                local Parent = a1.Parent
                u343 = if Parent then Parent.Name == "WildAssetEgg" else false
            else
                u343 = false
            end
            local u412 = nil
            local u419 = nil
            if 0 < a1.HoldDuration then
                local ProgressBar = Frame.ProgressBar
                local UIGradient = ProgressBar.LeftGradient.ProgressBarImage.UIGradient
                local UIGradient_2 = ProgressBar.RightGradient.ProgressBarImage.UIGradient
                ProgressBar.Progress.Changed:Connect(function(a1) -- Line: 159 -- upvalues: UIGradient (val), UIGradient_2 (val)
                    local v1 = math.clamp(a1 * 360, 0, 360)
                    UIGradient.Rotation = math.clamp(v1, 180, 360)
                    UIGradient_2.Rotation = math.clamp(v1, 0, 180)
                end)
                local u373 = "Progress_" .. LocalPlayer.UserId
                if typeof((a1:GetAttribute("Progress"))) ~= "number" then
                    table.insert(u487, (TweenService:Create(ProgressBar.Progress, v1, {Value = 1})))
                    table.insert(u496, (TweenService:Create(ProgressBar.Progress, v2, {Value = 0})))
                else
                    local Attribute_4 = a1:GetAttribute(u373)
                    if typeof(Attribute_4) ~= "number" then
                        Attribute_4 = 0
                    end
                    ProgressBar.Progress.Value = Attribute_4
                    if u343 then
                        applyWildEggZoom(a1, Attribute_4)
                    end
                    u412 = (a1:GetAttributeChangedSignal(u373)):Connect(function() -- Line: 633 -- upvalues: a1 (val), u373 (val), ProgressBar (val), u343 (val), applyWildEggZoom (upval)
                        local Attribute = a1:GetAttribute(u373)
                        if typeof(Attribute) ~= "number" then
                            Attribute = 0
                        end
                        ProgressBar.Progress.Value = Attribute
                        if u343 then
                            applyWildEggZoom(a1, Attribute)
                        end
                    end)
                    if u343 then
                        u419 = a1.AncestryChanged:Connect(function(a1_2, a2) -- Line: 650 -- upvalues: a1 (val), Workspace (upval), u11 (upval), TweenService (upval), u10 (upval)
                            if a2 == nil then
                                local CurrentCamera = Workspace.CurrentCamera
                                if not CurrentCamera then
                                    return
                                end
                                if u11.prompt == a1 and u11.baseFov then
                                    if u11.tween then
                                        u11.tween:Cancel()
                                        u11.tween = nil
                                    end
                                    u11.tween = TweenService:Create(CurrentCamera, u10, {FieldOfView = u11.baseFov})
                                    assert(u11.tween, "luau")
                                    u11.tween:Play()
                                    u11.prompt = nil
                                    u11.baseFov = nil
                                end
                            end
                        end)
                    end
                end
            end
            local u491 = nil
            local u500 = nil
            if 0 < a1.HoldDuration then
                u491 = a1.PromptButtonHoldBegan:Connect(function() -- Line: 674 -- upvalues: u487 (val)
                    for i, v in ipairs(u487) do
                        v:Play()
                    end
                end)
                u500 = a1.PromptButtonHoldEnded:Connect(function() -- Line: 680 -- upvalues: u496 (val)
                    for i, v in ipairs(u496) do
                        v:Play()
                    end
                end)
            end
            local u519 = a1.Triggered:Connect(function() -- Line: 687 -- upvalues: u515 (val)
                for i, v in ipairs(u515) do
                    v:Play()
                end
            end)
            local u537 = a1.TriggerEnded:Connect(function() -- Line: 693 -- upvalues: u533 (val)
                for i, v in ipairs(u533) do
                    v:Play()
                end
            end)

            local function getTextBoundsForLabel(a1, a2) -- Line: 699 -- upvalues: TextService (upval)
                local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
                GetTextBoundsParams.Font = a1.FontFace
                GetTextBoundsParams.Size = a1.TextSize
                GetTextBoundsParams.Width = 1000
                local v1 = a2 or ""
                if a1.RichText then
                    v1 = v1:gsub("<[^>]->", "")
                end
                GetTextBoundsParams.Text = v1
                local TextBoundsAsync = TextService:GetTextBoundsAsync(GetTextBoundsParams)
                GetTextBoundsParams:Destroy()
                return TextBoundsAsync
            end

            local function updateUIFromPrompt() -- Line: 718
                -- upvalues: getTextBoundsForLabel (val), ActionText (val), a1 (val), ObjectText (val), u569 (ref)
                local v1 = math.max((getTextBoundsForLabel(ActionText, a1.ActionText)).X, (getTextBoundsForLabel(ObjectText, a1.ObjectText)).X)
                local v2 = 72
                if a1.ActionText == nil then
                    if a1.ObjectText ~= nil and a1.ObjectText ~= "" then
                        v2 = v1 + 72 + 24
                    end
                elseif a1.ActionText ~= "" or a1.ObjectText ~= nil and a1.ObjectText ~= "" then
                    v2 = v1 + 72 + 24
                end
                v1 = 0
                local v3 = -10
                if a1.ObjectText ~= nil and a1.ObjectText ~= "" then
                    local v4
                    v1 = if not (a1:GetAttribute("ObjectTextBelow") == true) then 9 else -9
                    v3 = if not v4 then -10 else 12
                end
                ActionText.Position = UDim2.new(0.5, 72 - v2 / 2, 0, v1)
                ObjectText.Position = UDim2.new(0.5, 72 - v2 / 2, 0, v3)
                ActionText.Text = a1.ActionText
                ObjectText.Text = a1.ObjectText
                ActionText.AutoLocalize = a1.AutoLocalize
                ActionText.RootLocalizationTable = a1.RootLocalizationTable
                ObjectText.AutoLocalize = a1.AutoLocalize
                ObjectText.RootLocalizationTable = a1.RootLocalizationTable
                u569.Size = UDim2.fromOffset(v2, 72)
                u569.SizeOffset = Vector2.new(a1.UIOffset.X / u569.Size.Width.Offset, a1.UIOffset.Y / u569.Size.Height.Offset)
            end

            local u575 = a1.Changed:Connect(updateUIFromPrompt)
            updateUIFromPrompt()
            u569.MaxDistance = 0

            local function syncDistance() -- Line: 764
                -- upvalues: a1 (val), u569 (ref), Workspace (upval), LocalPlayer (upval)
                local Parent = a1.Parent
                u569.Adornee = Parent
                local v1 = u569
                local Enabled = a1.Enabled and a1:IsDescendantOf(Workspace)
                v1.Enabled = Enabled
                if a1.Name ~= "RideMount" then
                    return
                end
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                local WorldPosition = if not Parent then if not Parent then if not Parent then nil else if not Parent:IsA("Model") then nil else Parent:GetPivot().Position else if not Parent:IsA("BasePart") then if not Parent then nil else if not Parent:IsA("Model") then nil else Parent:GetPivot().Position else Parent.Position else if not Parent:IsA("Attachment") then if not Parent then if not Parent then nil else if not Parent:IsA("Model") then nil else Parent:GetPivot().Position else if not Parent:IsA("BasePart") then if not Parent then nil else if not Parent:IsA("Model") then nil else Parent:GetPivot().Position else Parent.Position else Parent.WorldPosition
                local v2 = u569
                local Enabled_2 = u569.Enabled
                if Enabled_2 then
                    Enabled_2 = false
                    if HumanoidRootPart ~= nil then
                        Enabled_2 = HumanoidRootPart:IsA("BasePart")
                        if Enabled_2 then
                            Enabled_2 = false
                            if WorldPosition ~= nil then
                                Enabled_2 = (HumanoidRootPart.Position - WorldPosition).Magnitude <= a1.MaxActivationDistance
                            end
                        end
                    end
                end
                v2.Enabled = Enabled_2
            end

            syncDistance()
            local u587 = RunService.RenderStepped:Connect(syncDistance)
            u569.Parent = v6
            for i2, j in ipairs(u533) do
                j:Play()
            end
            return function() -- Line: 788
                -- upvalues: u587 (val), u569 (ref), u491 (ref), u500 (ref), u412 (ref), u419 (ref), u519 (ref)
                -- upvalues: u537 (ref), u575 (val), u515 (val), u343 (val), a1 (val), Workspace (upval), u11 (upval)
                -- upvalues: TweenService (upval), u10 (upval)
                u587:Disconnect()
                u569.Enabled = false
                if u491 then
                    u491:Disconnect()
                end
                if u500 then
                    u500:Disconnect()
                end
                if u412 then
                    u412:Disconnect()
                end
                if u419 then
                    u419:Disconnect()
                end
                u519:Disconnect()
                u537:Disconnect()
                u575:Disconnect()
                for i, v in ipairs(u515) do
                    v:Play()
                end
                if u343 then
                    local CurrentCamera = Workspace.CurrentCamera
                    if CurrentCamera and u11.prompt == a1 and u11.baseFov then
                        if u11.tween then
                            u11.tween:Cancel()
                            u11.tween = nil
                        end
                        u11.tween = TweenService:Create(CurrentCamera, u10, {FieldOfView = u11.baseFov})
                        assert(u11.tween, "luau")
                        u11.tween:Play()
                        u11.prompt = nil
                        u11.baseFov = nil
                    end
                end
                wait(0.2)
                u569:Destroy()
            end
        end

        local function onLoad() -- Line: 827
            -- upvalues: ProximityPromptService (upval), PlayerGui (val), createPrompt (val)
            ProximityPromptService.PromptShown:Connect(function(a1, a2) -- Line: 828 -- upvalues: PlayerGui (upval), createPrompt (upval)
                if a1.Style == Enum.ProximityPromptStyle.Default then
                    return
                end
                local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
                if ProximityPrompts == nil then
                    ProximityPrompts = Instance.new("ScreenGui")
                    ProximityPrompts.Name = "ProximityPrompts"
                    ProximityPrompts.ResetOnSpawn = false
                    ProximityPrompts.Parent = PlayerGui
                end
                local v1 = createPrompt(a1, a2, ProximityPrompts)
                a1.PromptHidden:Wait()
                v1()
            end)
        end

        ProximityPromptService.PromptShown:Connect(function(a1, a2) -- Line: 828 -- upvalues: PlayerGui (val), createPrompt (val)
            if a1.Style == Enum.ProximityPromptStyle.Default then
                return
            end
            local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
            if ProximityPrompts == nil then
                ProximityPrompts = Instance.new("ScreenGui")
                ProximityPrompts.Name = "ProximityPrompts"
                ProximityPrompts.ResetOnSpawn = false
                ProximityPrompts.Parent = PlayerGui
            end
            local v1 = createPrompt(a1, a2, ProximityPrompts)
            a1.PromptHidden:Wait()
            v1()
        end)
    end,
}