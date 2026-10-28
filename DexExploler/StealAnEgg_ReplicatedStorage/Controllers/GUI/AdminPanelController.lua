-- Script path: ReplicatedStorage.Controllers.GUI.AdminPanelController
-- Decompile time: 39.53 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AdminPanelEntry = require(ReplicatedStorage.Client.AdminPanelEntry)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Globals.Constants)
local Parse = require(ReplicatedStorage.Shared.Utils.Numbers).Parse
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Directory = Assets.Directory
local u53 = require(ReplicatedStorage.Shared.Util.AssetEarnings)
require(ReplicatedStorage.Shared.Types.AssetItem)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local u82 = UDim2.fromOffset(900, 600)
local u84 = Log.new()
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 83
        -- upvalues: LocalPlayer (val), Parse (val), Directory (val), Personalities (val), u53 (val), Mutations (val)
        -- upvalues: u82 (val), TreadmillUtil (val), Save (val), Simple (val), Remotes (val), UserInputService (val)
        -- upvalues: u84 (val), AdminPanelEntry (val)
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local u5 = nil
        local u6 = {}
        local u7 = "Assets"
        local u8 = false
        local u9 = false
        local u10 = false
        local u11 = false
        local u12 = false

        local function clearGradients(a1) -- Line: 95 -- types: a1: userdata
            for i, v in ipairs(a1:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
        end

        local function roundToStep(a1, a2) -- Line: 103 -- types: a1: number, a2: number
            return math.round(a1 / a2) * a2
        end

        local function formatWalkSpeedDisplay(a1) -- Line: 107 -- types: a1: number
            local v1 = string.format("%.1f", math.round(a1 / 0.1) * 0.1)
            if string.sub(v1, -2) == ".0" then
                return (string.sub(v1, 1, #v1 - 2))
            end
            return v1
        end

        local function formatSpeedPowerDisplay(a1) -- Line: 117 -- types: a1: number
            return string.format("%.0f", (math.round(a1)))
        end

        local function parseNumericInput(a1) -- Line: 121 -- upvalues: Parse (upval) -- types: a1: string
            local v1 = Parse(a1)
            if typeof(v1) == "number" then
                return v1
            end
            return (tonumber(a1))
        end

        local function trimText(a1) -- Line: 130 -- types: a1: string
            return string.match(a1, "^%s*(.-)%s*$") or ""
        end

        local function parseOptionalNumberInput(a1) -- Line: 132 -- upvalues: Parse (upval) -- types: a1: string
            local v1
            local v2 = string.match(a1, "^%s*(.-)%s*$") or ""
            if v2 == "" then
                return nil, true
            end
            local v3 = Parse(v2)
            return v1, (if typeof(v3) ~= "number" then tonumber(v2) else v3) ~= nil
        end

        local function updateSliderVisual(a1, a2) -- Line: 142 -- types: a1: table, a2: number
            local Step = a1.Step
            local v1 = math.clamp(math.round(a2 / Step) * Step, a1.MinValue, a1.MaxValue)
            local v2 = math.max(a1.MaxValue - a1.MinValue, 0.0001)
            local v3 = math.clamp((v1 - a1.MinValue) / v2, 0, 1)
            a1.CurrentValue = v1
            a1.Fill.Size = UDim2.fromScale(v3, 1)
            a1.Knob.Position = UDim2.fromScale(v3, 0.5)
            a1.ValueLabel.Text = a1.FormatDisplay(v1)
            a1.Input.Text = a1.FormatInput(v1)
        end

        local function createSliderControl(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 155
            -- upvalues: 
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = ("%*Label"):format(a2)
            TextLabel.Size = UDim2.fromOffset(190, 18)
            TextLabel.Position = UDim2.fromOffset(690, a4)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = a3
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 15
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Parent = a1
            local TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Name = ("%*Value"):format(a2)
            TextLabel_2.Size = UDim2.fromOffset(190, 16)
            TextLabel_2.Position = UDim2.fromOffset(690, a4 + 18)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.Text = "0"
            TextLabel_2.TextColor3 = Color3.fromRGB(145, 232, 181)
            TextLabel_2.TextSize = 13
            TextLabel_2.Font = Enum.Font.Gotham
            TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_2.Parent = a1
            local TextButton = Instance.new("TextButton")
            TextButton.Name = ("%*Track"):format(a2)
            TextButton.Size = UDim2.fromOffset(124, 16)
            TextButton.Position = UDim2.fromOffset(690, a4 + 40)
            TextButton.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextButton.BorderSizePixel = 0
            TextButton.Text = ""
            TextButton.AutoButtonColor = false
            TextButton.Parent = a1
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = TextButton
            local Frame = Instance.new("Frame")
            Frame.Name = "Fill"
            Frame.Size = UDim2.fromScale(0, 1)
            Frame.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
            Frame.BorderSizePixel = 0
            Frame.Parent = TextButton
            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(1, 0)
            UICorner_2.Parent = Frame
            local Frame_2 = Instance.new("Frame")
            Frame_2.Name = "Knob"
            Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame_2.Size = UDim2.fromOffset(14, 14)
            Frame_2.Position = UDim2.fromScale(0, 0.5)
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BorderSizePixel = 0
            Frame_2.Parent = TextButton
            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(1, 0)
            UICorner_3.Parent = Frame_2
            local TextBox = Instance.new("TextBox")
            TextBox.Name = ("%*Input"):format(a2)
            TextBox.Size = UDim2.fromOffset(58, 28)
            TextBox.Position = UDim2.fromOffset(822, a4 + 34)
            TextBox.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextBox.BorderSizePixel = 0
            TextBox.Text = "0"
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 15
            TextBox.Font = Enum.Font.Gotham
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = a1
            local UICorner_4 = Instance.new("UICorner")
            UICorner_4.CornerRadius = UDim.new(0, 6)
            UICorner_4.Parent = TextBox
            return {
                Label = TextLabel,
                TrackButton = TextButton,
                Fill = Frame,
                Knob = Frame_2,
                Input = TextBox,
                ValueLabel = TextLabel_2,
                MinValue = a5,
                MaxValue = a6,
                Step = a7,
                CurrentValue = a5,
                FormatDisplay = a8,
                FormatInput = a9,
            }
        end

        local function createLabelInput(a1, a2, a3, a4) -- Line: 257
            -- upvalues: 
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = ("%*Label"):format(a2)
            TextLabel.Size = UDim2.fromOffset(190, 18)
            TextLabel.Position = UDim2.fromOffset(690, a4)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = a3
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 14
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Parent = a1
            local TextBox = Instance.new("TextBox")
            TextBox.Name = ("%*Input"):format(a2)
            TextBox.Size = UDim2.fromOffset(190, 32)
            TextBox.Position = UDim2.fromOffset(690, a4 + 20)
            TextBox.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextBox.BorderSizePixel = 0
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.PlaceholderColor3 = Color3.fromRGB(156, 168, 188)
            TextBox.TextSize = 15
            TextBox.Font = Enum.Font.Gotham
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = a1
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = TextBox
            return TextLabel, TextBox
        end

        local function buildRarityChancePercentById() -- Line: 295
            return {}
        end

        local function buildAssetRows() -- Line: 308 -- upvalues: Directory (upval), Personalities (upval), u53 (upval)
            local DisplayName, Rarity, v1, v2, v3, v4
            local v5 = {}
            local v6 = {}
            local v7 = {}
            for k, v in pairs(Directory) do
                v4 = v.DropWeight or 0
                Rarity = v.Rarity
                if Rarity then
                    DisplayName = Rarity.DisplayName or Rarity._id or "Unknown"
                    v1 = Rarity._id or DisplayName
                    v2 = Personalities.CreateNewItemData({
                        Scale = 1,
                        Personality = "Normal",
                        HasBeenFirstPlaced = false,
                        Category = k,
                        Mutations = {},
                    })
                    v3 = u53.RatePerSecond(v2)
                    v6[v1] = (v6[v1] or 0) + v4
                    table.insert(v5, {
                        InRarityDropChancePercent = 0,
                        Id = k,
                        DisplayName = v.DisplayName or k,
                        Icon = v.Icon or "",
                        RarityId = v1,
                        RarityName = DisplayName,
                        Rank = Rarity.Rank or 0,
                        RarityGradient = Rarity.RarityGradient,
                        MoneyPerSecond = v3,
                        DropWeight = v4,
                    })
                end
            end
            for i, i2 in ipairs(v5) do
                v4 = v6[i2.RarityId] or 0
                if v4 > 0 then
                    i2.InRarityDropChancePercent = i2.DropWeight / v4 * 100
                end
            end
            table.sort(v5, function(a1, a2) -- Line: 349
                if a1.Rank ~= a2.Rank then
                    return a2.Rank < a1.Rank
                end
                if a1.MoneyPerSecond ~= a2.MoneyPerSecond then
                    return a2.MoneyPerSecond < a1.MoneyPerSecond
                end
                return a1.DisplayName < a2.DisplayName
            end)
            return v5, v7
        end

        local function buildMutationNames() -- Line: 364 -- upvalues: Mutations (upval)
            local v1 = {}
            for k in pairs(Mutations.All()) do
                table.insert(v1, k)
            end
            table.sort(v1)
            return v1
        end

        local function createAdminPanel() -- Line: 373
            -- upvalues: PlayerGui (val), u82 (upval), createLabelInput (val), createSliderControl (val)
            -- upvalues: formatWalkSpeedDisplay (val), TreadmillUtil (upval), formatSpeedPowerDisplay (val)
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "AdminPanel"
            ScreenGui.ResetOnSpawn = false
            ScreenGui.IgnoreGuiInset = true
            ScreenGui.Parent = PlayerGui
            local TextButton = Instance.new("TextButton")
            TextButton.Name = "Toggle"
            TextButton.Size = UDim2.fromScale(0.1, 0.05)
            TextButton.AnchorPoint = Vector2.new(0, 0.5)
            TextButton.Position = UDim2.new(0, 12, 0.75, 0)
            TextButton.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextButton.BorderSizePixel = 0
            TextButton.Text = "Admin"
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.TextSize = 20
            TextButton.Font = Enum.Font.GothamBold
            TextButton.Parent = ScreenGui
            local Frame = Instance.new("Frame")
            Frame.Name = "Panel"
            Frame.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame.Size = u82
            Frame.Position = UDim2.fromScale(0.5, 0.5)
            Frame.BackgroundColor3 = Color3.fromRGB(18, 24, 35)
            Frame.BorderSizePixel = 0
            Frame.Visible = false
            Frame.Parent = ScreenGui
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = Frame
            Instance.new("UIDragDetector").Parent = Frame
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = "Title"
            TextLabel.Size = UDim2.new(1, -60, 0, 42)
            TextLabel.Position = UDim2.fromOffset(18, 8)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = "Admin Asset Grant"
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 25
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Parent = Frame
            local TextButton_2 = Instance.new("TextButton")
            TextButton_2.Name = "CloseButton"
            TextButton_2.Size = UDim2.fromOffset(34, 34)
            TextButton_2.Position = UDim2.new(1, -42, 0, 8)
            TextButton_2.BackgroundColor3 = Color3.fromRGB(117, 38, 46)
            TextButton_2.BorderSizePixel = 0
            TextButton_2.Text = "X"
            TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_2.TextSize = 22
            TextButton_2.Font = Enum.Font.GothamBold
            TextButton_2.Parent = Frame
            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = TextButton_2
            local TextButton_3 = Instance.new("TextButton")
            TextButton_3.Name = "AssetTabButton"
            TextButton_3.Size = UDim2.fromOffset(94, 32)
            TextButton_3.Position = UDim2.fromOffset(456, 18)
            TextButton_3.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
            TextButton_3.BorderSizePixel = 0
            TextButton_3.Text = "Assets"
            TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_3.TextSize = 14
            TextButton_3.Font = Enum.Font.GothamBold
            TextButton_3.Parent = Frame
            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 7)
            UICorner_3.Parent = TextButton_3
            local TextButton_4 = Instance.new("TextButton")
            TextButton_4.Name = "EggTabButton"
            TextButton_4.Size = UDim2.fromOffset(94, 32)
            TextButton_4.Position = UDim2.fromOffset(558, 18)
            TextButton_4.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
            TextButton_4.BorderSizePixel = 0
            TextButton_4.Text = "Eggs"
            TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_4.TextSize = 14
            TextButton_4.Font = Enum.Font.GothamBold
            TextButton_4.Parent = Frame
            local UICorner_4 = Instance.new("UICorner")
            UICorner_4.CornerRadius = UDim.new(0, 7)
            UICorner_4.Parent = TextButton_4
            local TextBox = Instance.new("TextBox")
            TextBox.Name = "PetSearch"
            TextBox.Size = UDim2.fromOffset(430, 30)
            TextBox.Position = UDim2.fromOffset(16, 60)
            TextBox.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextBox.BorderSizePixel = 0
            TextBox.Text = ""
            TextBox.PlaceholderText = "Search pet name, asset id or rarity..."
            TextBox.PlaceholderColor3 = Color3.fromRGB(156, 168, 188)
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 15
            TextBox.Font = Enum.Font.Gotham
            TextBox.ClearTextOnFocus = false
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.Parent = Frame
            local UICorner_5 = Instance.new("UICorner")
            UICorner_5.CornerRadius = UDim.new(0, 6)
            UICorner_5.Parent = TextBox
            local UIPadding = Instance.new("UIPadding")
            UIPadding.PaddingLeft = UDim.new(0, 10)
            UIPadding.PaddingRight = UDim.new(0, 10)
            UIPadding.Parent = TextBox
            local ScrollingFrame = Instance.new("ScrollingFrame")
            ScrollingFrame.Name = "AssetList"
            ScrollingFrame.Size = UDim2.fromOffset(430, 482)
            ScrollingFrame.Position = UDim2.fromOffset(16, 98)
            ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 33, 47)
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.ScrollBarThickness = 7
            ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)
            ScrollingFrame.Parent = Frame
            local UICorner_6 = Instance.new("UICorner")
            UICorner_6.CornerRadius = UDim.new(0, 8)
            UICorner_6.Parent = ScrollingFrame
            local ScrollingFrame_2 = Instance.new("ScrollingFrame")
            ScrollingFrame_2.Name = "MutationList"
            ScrollingFrame_2.Size = UDim2.fromOffset(220, 300)
            ScrollingFrame_2.Position = UDim2.fromOffset(456, 60)
            ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(25, 33, 47)
            ScrollingFrame_2.BorderSizePixel = 0
            ScrollingFrame_2.ScrollBarThickness = 7
            ScrollingFrame_2.CanvasSize = UDim2.fromOffset(0, 0)
            ScrollingFrame_2.Parent = Frame
            local UICorner_7 = Instance.new("UICorner")
            UICorner_7.CornerRadius = UDim.new(0, 8)
            UICorner_7.Parent = ScrollingFrame_2
            local TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Name = "SelectedLabel"
            TextLabel_2.Size = UDim2.fromOffset(220, 50)
            TextLabel_2.Position = UDim2.fromOffset(456, 368)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.Text = "Selected: None"
            TextLabel_2.TextColor3 = Color3.fromRGB(226, 230, 236)
            TextLabel_2.TextSize = 16
            TextLabel_2.Font = Enum.Font.Gotham
            TextLabel_2.TextWrapped = true
            TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_2.Parent = Frame
            local TextLabel_3 = Instance.new("TextLabel")
            TextLabel_3.Name = "MutationSelectionLabel"
            TextLabel_3.Size = UDim2.fromOffset(220, 50)
            TextLabel_3.Position = UDim2.fromOffset(456, 420)
            TextLabel_3.BackgroundTransparency = 1
            TextLabel_3.Text = "Mutations: None"
            TextLabel_3.TextColor3 = Color3.fromRGB(226, 230, 236)
            TextLabel_3.TextSize = 16
            TextLabel_3.Font = Enum.Font.Gotham
            TextLabel_3.TextWrapped = true
            TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_3.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_3.Parent = Frame
            local TextLabel_4 = Instance.new("TextLabel")
            TextLabel_4.Name = "ScaleLabel"
            TextLabel_4.Size = UDim2.fromOffset(190, 20)
            TextLabel_4.Position = UDim2.fromOffset(690, 142)
            TextLabel_4.BackgroundTransparency = 1
            TextLabel_4.Text = "Size Scale"
            TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_4.TextSize = 15
            TextLabel_4.Font = Enum.Font.GothamBold
            TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_4.Parent = Frame
            local TextBox_2 = Instance.new("TextBox")
            TextBox_2.Name = "ScaleInput"
            TextBox_2.Size = UDim2.fromOffset(190, 34)
            TextBox_2.Position = UDim2.fromOffset(690, 166)
            TextBox_2.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
            TextBox_2.BorderSizePixel = 0
            TextBox_2.Text = ""
            TextBox_2.PlaceholderText = "blank = roll"
            TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_2.PlaceholderColor3 = Color3.fromRGB(156, 168, 188)
            TextBox_2.TextSize = 17
            TextBox_2.Font = Enum.Font.Gotham
            TextBox_2.ClearTextOnFocus = false
            TextBox_2.Parent = Frame
            local UICorner_8 = Instance.new("UICorner")
            UICorner_8.CornerRadius = UDim.new(0, 6)
            UICorner_8.Parent = TextBox_2
            local v1, v2 = createLabelInput(Frame, "ColorIndex", "Color Index Override", 218)
            v2.PlaceholderText = "blank = roll"
            local v3, v4 = createLabelInput(Frame, "ColorSeed", "Color Seed Override", 274)
            v4.PlaceholderText = "blank = roll"
            local v5, v6 = createLabelInput(Frame, "EyeColor", "Eye Hex Override", 330)
            v6.PlaceholderText = "blank = roll"
            local v7 = createSliderControl(Frame, "WalkSpeed", "Walk Speed", 220, 0, 1000, 0.1, formatWalkSpeedDisplay, formatWalkSpeedDisplay)
            local v8 = createSliderControl(
                Frame,
                "SpeedPower",
                "Speed Value",
                288,
                0,
                1e+18,
                1,
                TreadmillUtil.FormatSpeedPower,
                formatSpeedPowerDisplay
            )

            local function createMountCheckbox(a1, a2) -- Line: 606
                -- upvalues: Frame (val)
                local TextButton = Instance.new("TextButton")
                TextButton.Name = a1
                TextButton.Size = UDim2.fromOffset(190, 28)
                TextButton.Position = UDim2.fromOffset(690, a2)
                TextButton.BackgroundColor3 = Color3.fromRGB(31, 45, 71)
                TextButton.BorderSizePixel = 0
                TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextButton.TextSize = 15
                TextButton.Font = Enum.Font.GothamBold
                TextButton.TextXAlignment = Enum.TextXAlignment.Left
                TextButton.Parent = Frame
                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = TextButton
                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingLeft = UDim.new(0, 8)
                UIPadding.Parent = TextButton
                return TextButton
            end

            local v9 = createMountCheckbox("RideableCheckbox", 366)
            local v10 = createMountCheckbox("InstantMountCheckbox", 400)
            local v11 = Instance.new("TextButton")
            v11.Name = "GiveButton"
            v11.Size = UDim2.fromOffset(190, 46)
            v11.Position = UDim2.fromOffset(690, 446)
            v11.BackgroundColor3 = Color3.fromRGB(36, 114, 84)
            v11.BorderSizePixel = 0
            v11.Text = "Give Selected Asset"
            v11.TextColor3 = Color3.fromRGB(255, 255, 255)
            v11.TextSize = 17
            v11.Font = Enum.Font.GothamBold
            v11.Parent = Frame
            local UICorner_9 = Instance.new("UICorner")
            UICorner_9.CornerRadius = UDim.new(0, 8)
            UICorner_9.Parent = v11
            local TextLabel_5 = Instance.new("TextLabel")
            TextLabel_5.Name = "StatusLabel"
            TextLabel_5.Size = UDim2.fromOffset(190, 42)
            TextLabel_5.Position = UDim2.fromOffset(690, 498)
            TextLabel_5.BackgroundTransparency = 1
            TextLabel_5.Text = "Ready."
            TextLabel_5.TextWrapped = true
            TextLabel_5.TextColor3 = Color3.fromRGB(226, 230, 236)
            TextLabel_5.TextSize = 15
            TextLabel_5.Font = Enum.Font.Gotham
            TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_5.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_5.Parent = Frame
            local TextButton_5 = Instance.new("TextButton")
            TextButton_5.Name = "ResetDataButton"
            TextButton_5.Size = UDim2.fromOffset(190, 44)
            TextButton_5.Position = UDim2.fromOffset(690, 546)
            TextButton_5.BackgroundColor3 = Color3.fromRGB(134, 46, 46)
            TextButton_5.BorderSizePixel = 0
            TextButton_5.Text = "Reset Data"
            TextButton_5.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_5.TextSize = 17
            TextButton_5.Font = Enum.Font.GothamBold
            TextButton_5.Parent = Frame
            local UICorner_10 = Instance.new("UICorner")
            UICorner_10.CornerRadius = UDim.new(0, 8)
            UICorner_10.Parent = TextButton_5
            return {
                screenGui = ScreenGui,
                panel = Frame,
                title = TextLabel,
                toggleButton = TextButton,
                closeButton = TextButton_2,
                assetTabButton = TextButton_3,
                eggTabButton = TextButton_4,
                assetList = ScrollingFrame,
                petSearch = TextBox,
                rideableCheckbox = v9,
                instantMountCheckbox = v10,
                mutationList = ScrollingFrame_2,
                selectedLabel = TextLabel_2,
                mutationSelectionLabel = TextLabel_3,
                scaleLabel = TextLabel_4,
                scaleInput = TextBox_2,
                colorIndexLabel = v1,
                colorIndexInput = v2,
                colorSeedLabel = v3,
                colorSeedInput = v4,
                eyeColorLabel = v5,
                eyeColorInput = v6,
                walkSpeedControl = v7,
                speedPowerControl = v8,
                giveButton = v11,
                resetButton = TextButton_5,
                statusLabel = TextLabel_5,
            }
        end

        local function setupAdminPanel() -- Line: 705
            -- upvalues: createAdminPanel (val), u8 (ref), u9 (ref), u7 (ref), Save (upval), TreadmillUtil (upval)
            -- upvalues: updateSliderVisual (val), Parse (upval), u5 (ref), u6 (val), buildAssetRows (val)
            -- upvalues: clearGradients (val), Simple (upval), buildMutationNames (val), Remotes (upval)
            -- upvalues: UserInputService (upval)
            local ImageLabel, TextButton, TextButton_2, TextLabel_2, TextLabel_3, TextLabel_4, UICorner, UICorner_2, v1
            local u479 = createAdminPanel()
            local u476 = {}
            local u481 = {}
            local u483 = false
            local u485 = nil
            local u487 = nil
            local u489 = nil

            local function setStatus(a1, a2) -- Line: 714 -- upvalues: u479 (val) -- types: a1: string, a2: boolean?
                u479.statusLabel.Text = a1
                if a2 == nil then
                    u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                    return
                end
                if a2 then
                    u479.statusLabel.TextColor3 = Color3.fromRGB(145, 232, 181)
                    return
                end
                u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
            end

            local function setSliderControlVisible(a1, a2) -- Line: 725 -- types: a1: table, a2: boolean
                a1.Label.Visible = a2
                a1.ValueLabel.Visible = a2
                a1.TrackButton.Visible = a2
                a1.Input.Visible = a2
            end

            local function setEggOverrideControlsVisible(a1) -- Line: 732 -- upvalues: u479 (val) -- types: a1: boolean
                u479.colorIndexLabel.Visible = a1
                u479.colorIndexInput.Visible = a1
                u479.colorSeedLabel.Visible = a1
                u479.colorSeedInput.Visible = a1
                u479.eyeColorLabel.Visible = a1
                u479.eyeColorInput.Visible = a1
            end

            local function updateMountCheckboxes() -- Line: 741 -- upvalues: u479 (val), u8 (upval), u9 (upval)
                local v1 = if not u8 then "[ ] " else "[X] "
                u479.rideableCheckbox.Text = v1 .. "Rideable"
                v1 = if not u9 then "[ ] " else "[X] "
                u479.instantMountCheckbox.Text = v1 .. "Instant Mount"
                local rideableCheckbox_2 = u479.rideableCheckbox
                local v2 = if not u8 then Color3.fromRGB(31, 45, 71) else Color3.fromRGB(36, 114, 84)
                rideableCheckbox_2.BackgroundColor3 = v2
                local instantMountCheckbox_2 = u479.instantMountCheckbox
                v2 = if not u9 then Color3.fromRGB(31, 45, 71) else Color3.fromRGB(36, 114, 84)
                instantMountCheckbox_2.BackgroundColor3 = v2
            end

            u479.rideableCheckbox.Activated:Connect(function() -- Line: 748 -- upvalues: u8 (upval), u9 (upval), updateMountCheckboxes (val)
                u8 = not u8
                if not u8 then
                    u9 = false
                end
                updateMountCheckboxes()
            end)
            u479.instantMountCheckbox.Activated:Connect(function() -- Line: 753 -- upvalues: u9 (upval), u8 (upval), updateMountCheckboxes (val)
                u9 = not u9
                if u9 then
                    u8 = true
                end
                updateMountCheckboxes()
            end)
            updateMountCheckboxes()

            local function applyGrantTabState(a1) -- Line: 760 -- upvalues: u7 (upval), u479 (val) -- types: a1: string
                local v1
                u7 = a1
                local v2 = if not (a1 == "Eggs") then "Admin Asset Grant" else "Admin Egg Grant"
                u479.title.Text = v2
                local assetTabButton = u479.assetTabButton
                v2 = if not v1 then Color3.fromRGB(36, 114, 84) else Color3.fromRGB(37, 47, 66)
                assetTabButton.BackgroundColor3 = v2
                local eggTabButton = u479.eggTabButton
                v2 = if not v1 then Color3.fromRGB(37, 47, 66) else Color3.fromRGB(36, 114, 84)
                eggTabButton.BackgroundColor3 = v2
                v2 = if not v1 then "Size Scale" else "Egg Scale Override"
                u479.scaleLabel.Text = v2
                u479.scaleInput.PlaceholderText = "blank = roll"
                v2 = if not v1 then "Give Selected Asset" else "Give Selected Egg"
                u479.giveButton.Text = v2
                local walkSpeedControl = u479.walkSpeedControl
                v2 = not v1
                walkSpeedControl.Label.Visible = v2
                walkSpeedControl.ValueLabel.Visible = v2
                walkSpeedControl.TrackButton.Visible = v2
                walkSpeedControl.Input.Visible = v2
                local speedPowerControl = u479.speedPowerControl
                v2 = not v1
                speedPowerControl.Label.Visible = v2
                speedPowerControl.ValueLabel.Visible = v2
                speedPowerControl.TrackButton.Visible = v2
                speedPowerControl.Input.Visible = v2
                u479.colorIndexLabel.Visible = v1
                u479.colorIndexInput.Visible = v1
                u479.colorSeedLabel.Visible = v1
                u479.colorSeedInput.Visible = v1
                u479.eyeColorLabel.Visible = v1
                u479.eyeColorInput.Visible = v1
                u479.rideableCheckbox.Visible = not v1
                u479.instantMountCheckbox.Visible = not v1
                if v1 and u479.scaleInput.Text == "1" then
                    u479.scaleInput.Text = ""
                    return
                end
                if not v1 and (string.match(u479.scaleInput.Text, "^%s*(.-)%s*$") or "") == "1" then
                    u479.scaleInput.Text = ""
                end
            end

            local function syncSpeedControlsFromSave(a1) -- Line: 786
                -- upvalues: Save (upval), TreadmillUtil (upval), updateSliderVisual (upval), u479 (val)
                local v1 = Save.Await()
                if not v1 then
                    return
                end
                local v2 = TreadmillUtil.NormalizeSpeedPower(v1.SpeedPower)
                updateSliderVisual(u479.speedPowerControl, v2)
                if a1 then
                    v1 = TreadmillUtil.SpeedPowerToWalkSpeed(v2)
                    updateSliderVisual(u479.walkSpeedControl, v1)
                end
            end

            local function setSliderValueFromTrack(a1, a2) -- Line: 800
                -- upvalues: updateSliderVisual (upval)
                local v1 = math.clamp((a2 - a1.TrackButton.AbsolutePosition.X) / math.max(a1.TrackButton.AbsoluteSize.X, 1), 0, 1)
                local v2 = a1.MinValue + (a1.MaxValue - a1.MinValue) * v1
                updateSliderVisual(a1, v2)
            end

            local function attachSliderBehavior(a1, a2) -- Line: 807
                -- upvalues: u485 (ref), u487 (ref), updateSliderVisual (upval), Parse (upval), u479 (val)
                a1.TrackButton.MouseButton1Down:Connect(function(a1_2) -- Line: 808
                    -- upvalues: u485 (upval), a1 (val), u487 (upval), a2 (val), updateSliderVisual (upval)
                    u485 = a1
                    u487 = a2
                    local v1 = a1
                    local v2 = math.clamp((a1_2 - v1.TrackButton.AbsolutePosition.X) / math.max(v1.TrackButton.AbsoluteSize.X, 1), 0, 1)
                    local v3 = v1.MinValue + (v1.MaxValue - v1.MinValue) * v2
                    updateSliderVisual(v1, v3)
                end)
                a1.Input.FocusLost:Connect(function(a1_2) -- Line: 814
                    -- upvalues: a1 (val), Parse (upval), updateSliderVisual (upval), u479 (upval), a2 (val)
                    if not a1_2 and a1.Input.Text == a1.FormatInput(a1.CurrentValue) then
                        return
                    end
                    local Text = a1.Input.Text
                    local v1 = Parse(Text)
                    local v2 = if typeof(v1) ~= "number" then tonumber(Text) else v1
                    if v2 ~= nil then
                        updateSliderVisual(a1, v2)
                        a2(a1.CurrentValue)
                        return
                    end
                    updateSliderVisual(a1, a1.CurrentValue)
                    u479.statusLabel.Text = "Enter a valid number."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                end)
            end

            local function updateSelectedAssetState() -- Line: 831
                -- upvalues: u476 (val), u5 (upval), u479 (val), u7 (upval)
                local v1
                for k, v in pairs(u476) do
                    v1 = if u5 ~= k then Color3.fromRGB(37, 47, 66) else Color3.fromRGB(36, 114, 84)
                    v.BackgroundColor3 = v1
                end
                if not u5 then
                    u479.selectedLabel.Text = "Selected: None"
                    return
                end
                local selectedLabel = u479.selectedLabel
                local v2 = if u7 ~= "Eggs" then ("Selected asset: %*"):format(u5) else ("Selected egg: %*"):format(u5)
                selectedLabel.Text = v2
            end

            local function updateMutationState() -- Line: 847 -- upvalues: u6 (upval), u481 (val), u479 (val)
                local v1
                local v2 = {}
                for k, v in pairs(u6) do
                    if v then
                        table.insert(v2, k)
                    end
                end
                table.sort(v2)
                for k2, i in pairs(u481) do
                    v1 = if not u6[k2] then Color3.fromRGB(37, 47, 66) else Color3.fromRGB(126, 73, 153)
                    i.BackgroundColor3 = v1
                end
                if #v2 == 0 then
                    u479.mutationSelectionLabel.Text = "Mutations: None"
                    return
                end
                u479.mutationSelectionLabel.Text = ("Mutations: %*"):format((table.concat(v2, ", ")))
            end

            local u499, v2 = buildAssetRows()
            local u503 = {}
            local v3 = 8
            local RarityName_3 = nil
            for i, v in ipairs(u499) do
                if RarityName_3 ~= v.RarityName then
                    TextLabel_2 = Instance.new("TextLabel")
                    TextLabel_2.Name = ("Rarity_%*"):format(v.RarityName)
                    TextLabel_2.Size = UDim2.new(1, -14, 0, 22)
                    TextLabel_2.Position = UDim2.fromOffset(7, v3)
                    TextLabel_2.BackgroundTransparency = 1
                    v1 = v2[v.RarityId] or 0
                    TextLabel_2.Text = ("%* (%*)"):format(v.RarityName, (string.format("%.2f%%", v1)))
                    TextLabel_2.TextColor3 = Color3.fromRGB(193, 203, 219)
                    TextLabel_2.TextSize = 14
                    TextLabel_2.Font = Enum.Font.GothamBold
                    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel_2.Parent = u479.assetList
                    u503[v.RarityName] = TextLabel_2
                    v3 = v3 + 24
                    RarityName_3 = v.RarityName
                end
                TextButton_2 = Instance.new("TextButton")
                TextButton_2.Name = v.Id
                TextButton_2.Size = UDim2.new(1, -14, 0, 44)
                TextButton_2.Position = UDim2.fromOffset(7, v3)
                TextButton_2.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
                TextButton_2.BorderSizePixel = 0
                TextButton_2.Text = ""
                TextButton_2.Parent = u479.assetList
                UICorner_2 = Instance.new("UICorner")
                UICorner_2.CornerRadius = UDim.new(0, 7)
                UICorner_2.Parent = TextButton_2
                ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Name = "Icon"
                ImageLabel.Size = UDim2.fromOffset(34, 34)
                ImageLabel.ScaleType = Enum.ScaleType.Fit
                ImageLabel.Position = UDim2.fromOffset(5, 5)
                ImageLabel.BackgroundTransparency = 1
                ImageLabel.Image = v.Icon
                ImageLabel.Parent = TextButton_2
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Name = "Name"
                TextLabel_3.Size = UDim2.new(1, -220, 1, 0)
                TextLabel_3.Position = UDim2.fromOffset(44, 0)
                TextLabel_3.BackgroundTransparency = 1
                TextLabel_3.Text = v.DisplayName
                TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel_3.TextSize = 14
                TextLabel_3.Font = Enum.Font.GothamBold
                TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel_3.Parent = TextButton_2
                clearGradients(TextLabel_3)
                if v.RarityGradient then
                    v.RarityGradient:Clone().Parent = TextLabel_3
                end
                TextLabel_4 = Instance.new("TextLabel")
                TextLabel_4.Name = "MoneyPerSecond"
                TextLabel_4.Size = UDim2.fromOffset(170, 44)
                TextLabel_4.AnchorPoint = Vector2.new(1, 0)
                TextLabel_4.Position = UDim2.new(1, -6, 0, 0)
                TextLabel_4.BackgroundTransparency = 1
                TextLabel_4.Text = ("%*/s | %*"):format(Simple.FormatCompact(v.MoneyPerSecond, ".##"), (string.format("%.2f%%", v.InRarityDropChancePercent)))
                TextLabel_4.TextColor3 = Color3.fromRGB(145, 232, 181)
                TextLabel_4.TextSize = 13
                TextLabel_4.Font = Enum.Font.Gotham
                TextLabel_4.TextXAlignment = Enum.TextXAlignment.Right
                TextLabel_4.Parent = TextButton_2
                TextButton_2.MouseButton1Click:Connect(function() -- Line: 946 -- upvalues: u5 (upval), v (val), updateSelectedAssetState (val)
                    u5 = v.Id
                    updateSelectedAssetState()
                end)
                u476[v.Id] = TextButton_2
                v3 = v3 + 48
            end
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = "NoSearchResults"
            TextLabel.Size = UDim2.new(1, -14, 0, 32)
            TextLabel.Position = UDim2.fromOffset(7, 8)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = "No matching pets."
            TextLabel.TextColor3 = Color3.fromRGB(193, 203, 219)
            TextLabel.TextSize = 15
            TextLabel.Font = Enum.Font.Gotham
            TextLabel.Visible = false
            TextLabel.Parent = u479.assetList

            local function filterPetList() -- Line: 966
                -- upvalues: u479 (val), u503 (val), u499 (val), u476 (val), TextLabel (val)
                local v1, v2, v3
                local v4 = string.lower(string.match(u479.petSearch.Text, "^%s*(.-)%s*$") or "")
                local v5 = 8
                local RarityName = nil
                local v6 = 0
                for k, v in pairs(u503) do
                    v.Visible = false
                end
                for i, i2 in ipairs(u499) do
                    v3 = string.lower(i2.DisplayName .. " " .. i2.Id .. " " .. i2.RarityName)
                    v1 = true
                    if v4 ~= "" then
                        v1 = string.find(v3, v4, 1, true) ~= nil
                    end
                    v3 = u476[i2.Id]
                    v3.Visible = v1
                    if v1 then
                        if RarityName ~= i2.RarityName then
                            v2 = u503[i2.RarityName]
                            v2.Visible = true
                            v2.Position = UDim2.fromOffset(7, v5)
                            v5 = v5 + 24
                            RarityName = i2.RarityName
                        end
                        v3.Position = UDim2.fromOffset(7, v5)
                        v5 = v5 + 48
                        v6 = v6 + 1
                    end
                end
                TextLabel.Visible = v6 == 0
                u479.assetList.CanvasSize = UDim2.fromOffset(0, if v6 ~= 0 then v5 + 4 else 44)
                u479.assetList.CanvasPosition = Vector2.zero
            end

            ;(u479.petSearch:GetPropertyChangedSignal("Text")):Connect(filterPetList)
            filterPetList()
            v2 = 8
            for i2, i3 in ipairs((buildMutationNames())) do
                TextButton = Instance.new("TextButton")
                TextButton.Name = i3
                TextButton.Size = UDim2.new(1, -14, 0, 32)
                TextButton.Position = UDim2.fromOffset(7, v2)
                TextButton.BackgroundColor3 = Color3.fromRGB(37, 47, 66)
                TextButton.BorderSizePixel = 0
                TextButton.Text = i3
                TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextButton.TextSize = 14
                TextButton.Font = Enum.Font.Gotham
                TextButton.Parent = u479.mutationList
                UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 7)
                UICorner.Parent = TextButton
                TextButton.MouseButton1Click:Connect(function() -- Line: 1015 -- upvalues: u6 (upval), i3 (val), updateMutationState (val)
                    u6[i3] = not u6[i3]
                    updateMutationState()
                end)
                u481[i3] = TextButton
                v2 = v2 + 36
            end
            u479.mutationList.CanvasSize = UDim2.fromOffset(0, v2 + 4)
            u479.assetTabButton.MouseButton1Click:Connect(function() -- Line: 1025 -- upvalues: applyGrantTabState (val), updateSelectedAssetState (val)
                applyGrantTabState("Assets")
                updateSelectedAssetState()
            end)
            u479.eggTabButton.MouseButton1Click:Connect(function() -- Line: 1030 -- upvalues: applyGrantTabState (val), updateSelectedAssetState (val)
                applyGrantTabState("Eggs")
                updateSelectedAssetState()
            end)
            u479.giveButton.MouseButton1Click:Connect(function() -- Line: 1035
                -- upvalues: u5 (upval), u479 (val), u6 (upval), u7 (upval), Parse (upval), Remotes (upval), u8 (upval)
                -- upvalues: u9 (upval)
                local v1, v2, v3, v4, v5, v6
                if not u5 then
                    u479.statusLabel.Text = "Select an asset first."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                    return
                end
                local v7 = {}
                for k, v in pairs(u6) do
                    if v then
                        table.insert(v7, k)
                    end
                end
                table.sort(v7)
                if u7 ~= "Eggs" then
                    v4 = string.match(u479.scaleInput.Text, "^%s*(.-)%s*$") or ""
                    if v4 ~= "" then
                        v6 = Parse(v4)
                        v1 = if typeof(v6) ~= "number" then tonumber(v4) else v6
                        v2 = v5 ~= nil
                    else
                        v1 = nil
                        v2 = true
                    end
                    if not v2 then
                        u479.statusLabel.Text = "Enter a valid scale override."
                        u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                        return
                    end
                    u479.statusLabel.Text = "Granting asset..."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                    v2 = {assetId = u5, rideable = u8, instantMount = u9}
                    if v1 ~= nil then
                        v2.scale = v1
                    end
                    if #v7 > 0 then
                        v2.mutations = v7
                    end
                    Remotes.StaffConsole.GrantSelfPet:FireServer(v2)
                    return
                end
                v4 = string.match(u479.scaleInput.Text, "^%s*(.-)%s*$") or ""
                if v4 ~= "" then
                    v6 = Parse(v4)
                    v1 = if typeof(v6) ~= "number" then tonumber(v4) else v6
                    v2 = v5 ~= nil
                else
                    v1 = nil
                    v2 = true
                end
                if not v2 then
                    u479.statusLabel.Text = "Enter a valid scale override."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                    return
                end
                v2 = string.match(u479.colorSeedInput.Text, "^%s*(.-)%s*$") or ""
                if v2 ~= "" then
                    local v8 = Parse(v2)
                    v3 = if typeof(v8) ~= "number" then tonumber(v2) else v8
                    v4 = v6 ~= nil
                else
                    v3 = nil
                    v4 = true
                end
                if not v4 then
                    u479.statusLabel.Text = "Enter a valid color seed override."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                    return
                end
                v4 = string.match(u479.colorIndexInput.Text, "^%s*(.-)%s*$") or ""
                if v4 ~= "" then
                    local v9
                    local v10 = Parse(v4)
                    v5 = if typeof(v10) ~= "number" then tonumber(v4) else v10
                    v6 = v9 ~= nil
                else
                    v5 = nil
                    v6 = true
                end
                if not v6 then
                    u479.statusLabel.Text = "Enter a valid color index override."
                    u479.statusLabel.TextColor3 = Color3.fromRGB(255, 146, 146)
                    return
                end
                v6 = {assetId = u5}
                if v1 ~= nil then
                    v6.scale = v1
                end
                if v3 ~= nil then
                    v6.colorSeed = v3
                end
                if v5 ~= nil then
                    v6.colorIndex = v5
                end
                v5 = string.match(u479.eyeColorInput.Text, "^%s*(.-)%s*$") or ""
                if v5 ~= "" then
                    v6.eyeColor = v5
                end
                if #v7 > 0 then
                    v6.mutations = v7
                end
                u479.statusLabel.Text = "Granting egg..."
                u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                Remotes.StaffConsole.GrantSelfEgg:FireServer(v6)
            end)
            attachSliderBehavior(u479.walkSpeedControl, function(a1) -- Line: 1114 -- upvalues: u489 (ref), u479 (val), Remotes (upval) -- types: a1: number
                u489 = "WalkSpeed"
                local v1 = string.format("%.1f", math.round(a1 / 0.1) * 0.1)
                local v2 = ("Setting walk speed to %*..."):format(if string.sub(v1, -2) ~= ".0" then v1 else string.sub(v1, 1, #v1 - 2))
                u479.statusLabel.Text = v2
                u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                Remotes.StaffConsole.WriteWalkSpeed:FireServer(a1)
            end)
            attachSliderBehavior(u479.speedPowerControl, function(a1) -- Line: 1120 -- upvalues: u489 (ref), u479 (val), Remotes (upval) -- types: a1: number
                u489 = "SpeedPower"
                local v1 = ("Setting speed value to %*..."):format((string.format("%.0f", (math.round(a1)))))
                u479.statusLabel.Text = v1
                u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                Remotes.StaffConsole.WriteSpeedPower:FireServer(a1)
            end)
            u479.resetButton.MouseButton1Click:Connect(function() -- Line: 1126 -- upvalues: u479 (val), Remotes (upval)
                u479.statusLabel.Text = "Resetting your data..."
                u479.statusLabel.TextColor3 = Color3.fromRGB(226, 230, 236)
                Remotes.StaffConsole.WipeSelfProfile:FireServer()
            end)
            Remotes.StaffConsole.GrantVerdict.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 1132 -- upvalues: setStatus (val) -- types: a1: boolean, a2: string, a3: string?
                setStatus(if not a3 then a2 else if a3 == "" then a2 else ("%* UID: %*"):format(a2, a3), a1)
            end)
            Remotes.StaffConsole.WipeVerdict.OnClientEvent:Connect(function(a1, a2) -- Line: 1139 -- upvalues: setStatus (val) -- types: a1: boolean, a2: string
                setStatus(a2, a1)
            end)
            Remotes.StaffConsole.SpeedPowerVerdict.OnClientEvent:Connect(function(a1, a2) -- Line: 1143
                -- upvalues: setStatus (val), u489 (ref), Save (upval), TreadmillUtil (upval)
                -- upvalues: updateSliderVisual (upval), u479 (val)
                local v1, v2
                setStatus(a2, a1)
                if u489 == "SpeedPower" then
                    v1 = Save.Await()
                    if v1 then
                        v2 = TreadmillUtil.NormalizeSpeedPower(v1.SpeedPower)
                        updateSliderVisual(u479.speedPowerControl, v2)
                        v1 = TreadmillUtil.SpeedPowerToWalkSpeed(v2)
                        updateSliderVisual(u479.walkSpeedControl, v1)
                    end
                elseif u489 == "WalkSpeed" then
                    v1 = Save.Await()
                    if v1 then
                        v2 = TreadmillUtil.NormalizeSpeedPower(v1.SpeedPower)
                        updateSliderVisual(u479.speedPowerControl, v2)
                    end
                end
                u489 = nil
            end)

            local function togglePanel() -- Line: 1154 -- upvalues: u483 (ref), u479 (val)
                u483 = not u483
                u479.panel.Visible = u483
            end

            u479.toggleButton.MouseButton1Click:Connect(togglePanel)
            u479.closeButton.MouseButton1Click:Connect(togglePanel)
            UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 1162 -- upvalues: u483 (ref), u479 (val) -- types: a1: userdata, a2: boolean
                if a2 then
                    return
                end
                if a1.KeyCode == Enum.KeyCode.F9 then
                    u483 = not u483
                    u479.panel.Visible = u483
                end
            end)
            UserInputService.InputChanged:Connect(function(a1, a2) -- Line: 1171 -- upvalues: u485 (ref), updateSliderVisual (upval) -- types: a1: userdata, a2: boolean
                if u485 == nil then
                    return
                end
                if a1.UserInputType ~= Enum.UserInputType.MouseMovement
                    and a1.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end
                local v1 = u485
                local v2 = math.clamp((a1.Position.X - v1.TrackButton.AbsolutePosition.X) / math.max(v1.TrackButton.AbsoluteSize.X, 1), 0, 1)
                local v3 = v1.MinValue + (v1.MaxValue - v1.MinValue) * v2
                updateSliderVisual(v1, v3)
            end)
            UserInputService.InputEnded:Connect(function(a1, a2) -- Line: 1186 -- upvalues: u485 (ref), u487 (ref) -- types: a1: userdata, a2: boolean
                if u485 ~= nil and u487 ~= nil then
                    if a1.UserInputType ~= Enum.UserInputType.MouseButton1
                        and a1.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end
                    local v1 = u485
                    local v2 = u487
                    u485 = nil
                    u487 = nil
                    v2(v1.CurrentValue)
                    return
                end
            end)
            v2 = Save.Await()
            if v2 then
                local v4 = TreadmillUtil.NormalizeSpeedPower(v2.SpeedPower)
                updateSliderVisual(u479.speedPowerControl, v4)
                v2 = TreadmillUtil.SpeedPowerToWalkSpeed(v4)
                updateSliderVisual(u479.walkSpeedControl, v2)
            end
            Save.WatchFields("SpeedPower", function() -- Line: 1206 -- upvalues: Save (upval), TreadmillUtil (upval), updateSliderVisual (upval), u479 (val)
                local v1 = Save.Await()
                if not v1 then
                    return
                end
                local v2 = TreadmillUtil.NormalizeSpeedPower(v1.SpeedPower)
                updateSliderVisual(u479.speedPowerControl, v2)
            end)
            applyGrantTabState("Assets")
            updateSelectedAssetState()
            updateMutationState()
        end

        local function tryInitializeAdminPanel() -- Line: 1214
            -- upvalues: u10 (ref), u12 (ref), Save (upval), u84 (upval), setupAdminPanel (val)
            if not u10 and u12 and Save.Await() ~= nil then
                u10 = true
                u84:AtInfo():Log("Admin status confirmed, initializing admin panel")
                setupAdminPanel()
                return
            end
        end

        Remotes.StaffConsole.StaffVerdict.OnClientEvent:Connect(function(a1) -- Line: 1223
            -- upvalues: u11 (ref), u12 (ref), AdminPanelEntry (upval), u84 (upval), u10 (ref), Save (upval)
            -- upvalues: setupAdminPanel (val)
            u11 = true
            AdminPanelEntry.SetAdminStatus(a1)
            if not a1 then
                u84:AtInfo():Log("Admin panel unavailable for this user")
                return
            end
            if not u10 and a1 then
                if Save.Await() == nil then
                    return
                end
                u10 = true
                u84:AtInfo():Log("Admin status confirmed, initializing admin panel")
                setupAdminPanel()
            end
        end)
        task.spawn(function() -- Line: 1234 -- upvalues: u11 (ref), Remotes (upval)
            while not u11 do
                Remotes.StaffConsole.ProbeStaffStatus:FireServer()
                task.wait(2)
            end
        end)
        task.spawn(function() -- Line: 1241 -- upvalues: Save (upval), u10 (ref), u12 (ref), u84 (upval), setupAdminPanel (val)
            while Save.Await() == nil do
                task.wait(0.25)
            end
            if not u10 and u12 then
                if Save.Await() == nil then
                    return
                end
                u10 = true
                u84:AtInfo():Log("Admin status confirmed, initializing admin panel")
                setupAdminPanel()
            end
        end)
    end,
}