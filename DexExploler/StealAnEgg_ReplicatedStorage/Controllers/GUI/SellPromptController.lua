-- Script path: ReplicatedStorage.Controllers.GUI.SellPromptController
-- Decompile time: 101.93 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local GUI = require(ReplicatedStorage.Client.GUI)
local Message = require(ReplicatedStorage.Client.Message)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SellPayout = require(ReplicatedStorage.Client.UI.VFX.SellPayout)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Timer = require(ReplicatedStorage.Packages.Timer)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
return {
    Start = function() -- Line: 37
        -- upvalues: Players (val), GUI (val), Trove (val), Simple (val), Numbers (val), TweenService (val)
        -- upvalues: AssetItems (val), Save (val), TryCall (val), Assets (val), AssetEarnings (val), EggRecords (val)
        -- upvalues: TextService (val), RunService (val), UserInputService (val), PlatformController (val)
        -- upvalues: Workspace (val), AssetIconShape (val), ButtonFX (val), Audio (val), SellPayout (val), Message (val)
        -- upvalues: Remotes (val), ToolGameplayGuard (val), Tabs (val), Timer (val)
        local queueRefit
        local u0 = {}

        function u0.Calculate(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 52
            -- upvalues: 
            local v1 = math.max(1, a4 + a6)
            local v2 = math.max(1, a5 + a7)
            local v3 = math.max(1, (math.floor((a2 + a6) / v1)))
            local v4 = math.max(0, (math.ceil(a1 / v3)) * v2 - a7)
            v1 = math.clamp(a8, 0, (math.max(0, v4 - a3)))
            local v5 = math.floor(v1 / v2)
            local v6 = math.max(v5, (math.ceil((v1 + a3) / v2)) - 1)
            return {
                Columns = v3,
                First = if a1 ~= 0 then math.max(0, v5 - 1) * v3 + 1 else 1,
                Last = math.min(a1, (v6 + 2) * v3),
                VisibleFirst = v5 * v3 + 1,
                VisibleLast = math.min(a1, (v6 + 1) * v3),
                CanvasHeight = v4,
                ScrollY = v1,
            }
        end

        local u6 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local u11 = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local u16 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local u21 = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local u26 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local u31 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local u35 = UDim2.fromScale(0.72, 0.85)
        local u39 = UDim2.fromScale(0.31, 0.54)
        local u44 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local u49 = TweenInfo.new(0.098, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local u54 = TweenInfo.new(0.18200000000000002, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        local u59 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local u64 = Color3.fromRGB(190, 255, 180)
        local u69 = Color3.fromRGB(120, 120, 140)
        local u74 = Color3.fromRGB(4, 4, 4)
        local u93 = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 255, 0)),
            (ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 255, 0))),
        })
        local u112 = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 96, 116)),
            (ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 82))),
        })
        local u113 = {Eggs = "Sell Eggs", Pets = "Sell Pets"}
        local u121 = Color3.fromRGB(255, 170, 0):ToHex()
        local u129 = Color3.fromRGB(0, 255, 8):ToHex()
        local u130 = {Eggs = "rbxassetid://103094823152347", Pets = "rbxassetid://83736894896123"}
        local LocalPlayer = Players.LocalPlayer
        local u135 = GUI.SellPrompt()
        local Frame = u135:FindFirstChild("Frame")
        assert(Frame, "SellPrompt.Frame is missing")
        local Header = Frame.Header
        local ScrollingFrame = Frame.ScrollingFrame
        local UIGridLayout = ScrollingFrame:FindFirstChildOfClass("UIGridLayout")
        local TemplateHolder = ScrollingFrame.TemplateHolder
        local SortByHolder = Frame.SortByHolder
        local SellInfoHolder = Frame.SellInfoHolder
        local TabButtonHolder = Frame.TabButtonHolder
        local Backdrop = u135:FindFirstChild("Backdrop")
        local Sell = SellInfoHolder.Sell
        local Weight = SortByHolder.Weight
        local Value = SortByHolder.Value
        local SelectAll = SortByHolder.SelectAll
        local Clear = SortByHolder.Clear
        local PetsTab = TabButtonHolder.PetsTab
        local EggsTab = TabButtonHolder.EggsTab
        local v1 = Trove.new()
        local u171 = Trove.new()
        local u174 = Trove.new()
        local u175 = {}
        local u176 = {}
        local u177 = {}
        local u178 = {}
        local u179 = "Pets"
        local u180 = "Value"
        local u181 = true
        local u182 = {}
        local u183 = {}
        local u184 = {}
        local u185 = {}
        local u186 = false
        local u187 = 0
        local u188 = false
        local u189 = 0
        local u190 = nil
        local u191 = nil
        local u192 = {Selling = false, Confirming = false}
        local u193 = 0
        local u194 = 0
        local u195 = 0
        local u196 = false
        local u197 = nil
        local u198 = {}
        local u484 = false
        local u200 = 0
        local u201 = false
        local u202 = 0
        local Size = Frame.Size
        local CellSize = UIGridLayout.CellSize
        local u205 = {}
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "VisibleCards"
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        Frame_2.ClipsDescendants = false
        Frame_2.Parent = ScrollingFrame
        UIGridLayout.Parent = nil
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
        ScrollingFrame.ClipsDescendants = true
        v1:Add(UIGridLayout)
        v1:Add(Frame_2)

        local function money(a1) -- Line: 257 -- upvalues: Simple (upval), Numbers (upval) -- types: a1: number
            if a1 > 99999 then
                return "$" .. Simple.FormatCompact(math.round(a1), ".#")
            end
            return "$" .. Numbers.AddCommas((math.round(a1)))
        end

        local function captionOf(a1) -- Line: 264 -- types: a1: userdata
            return a1:FindFirstChildWhichIsA("TextLabel")
        end

        local function namedScale(a1, a2) -- Line: 268 -- types: a1: userdata, a2: string
            local v1 = a1:FindFirstChild(a2)
            if v1 and v1:IsA("UIScale") then
                return v1
            end
            local UIScale = Instance.new("UIScale")
            UIScale.Name = a2
            UIScale.Parent = a1
            return UIScale
        end

        local function captureFade(a1, a2) -- Line: 280 -- types: a1: userdata, a2: table?
            local walk
            local u2 = {}
            local u3 = {}
            local v1 = ipairs
            for i, v in v1(a2 or {}) do
                u3[v] = true
            end

            local function add(a1, a2) -- Line: 287 -- upvalues: u2 (val) -- types: a1: userdata, a2: string
                local v1 = a1[a2]
                if typeof(v1) == "number" then
                    table.insert(u2, {Host = a1, Property = a2, Base = v1})
                end
            end

            function walk(a1_2) -- Line: 294
                -- upvalues: a1 (val), u3 (val), u2 (val), walk (val)
                if a1_2 ~= a1 and u3[a1_2] then
                    return
                end
                if a1_2:IsA("CanvasGroup") then
                    local GroupTransparency = a1_2.GroupTransparency
                    if typeof(GroupTransparency) == "number" then
                        table.insert(u2, {Property = "GroupTransparency", Host = a1_2, Base = GroupTransparency})
                    end
                    return
                end
                if a1_2:IsA("GuiObject") then
                    local BackgroundTransparency = a1_2.BackgroundTransparency
                    if typeof(BackgroundTransparency) == "number" then
                        table.insert(u2, {
                            Property = "BackgroundTransparency",
                            Host = a1_2,
                            Base = BackgroundTransparency,
                        })
                    end
                    if a1_2:IsA("TextLabel") or a1_2:IsA("TextButton") or a1_2:IsA("TextBox") then
                        local TextTransparency = a1_2.TextTransparency
                        if typeof(TextTransparency) == "number" then
                            table.insert(u2, {Property = "TextTransparency", Host = a1_2, Base = TextTransparency})
                        end
                        local TextStrokeTransparency = a1_2.TextStrokeTransparency
                        if typeof(TextStrokeTransparency) == "number" then
                            table.insert(u2, {
                                Property = "TextStrokeTransparency",
                                Host = a1_2,
                                Base = TextStrokeTransparency,
                            })
                        end
                    end
                    if a1_2:IsA("ImageLabel") or a1_2:IsA("ImageButton") then
                        local ImageTransparency = a1_2.ImageTransparency
                        if typeof(ImageTransparency) == "number" then
                            table.insert(u2, {Property = "ImageTransparency", Host = a1_2, Base = ImageTransparency})
                        end
                    end
                elseif not a1_2:IsA("LuaSourceContainer") then
                    local success, err = pcall(function() -- Line: 318 -- upvalues: a1_2 (val)
                        return a1_2.Transparency
                    end)
                    if success and typeof(err) == "number" then
                        local Transparency = a1_2.Transparency
                        if typeof(Transparency) == "number" then
                            table.insert(u2, {Property = "Transparency", Host = a1_2, Base = Transparency})
                        end
                    end
                end
                for i, v in ipairs(a1_2:GetChildren()) do
                    walk(v)
                end
            end

            walk(a1)
            return u2
        end

        local function setFade(a1, a2) -- Line: 333 -- types: a1: table, a2: number
            local v1 = 1 - math.clamp(a2, 0, 1)
            for i, v in ipairs(a1) do
                v.Host[v.Property] = v.Base + (1 - v.Base) * v1
            end
        end

        local function fadeIn(a1, a2, a3, a4) -- Line: 340
            -- upvalues: setFade (val), TweenService (upval)
            setFade(a1, 0)
            local NumberValue = Instance.new("NumberValue")
            local u15 = NumberValue.Changed:Connect(function(a1_2) -- Line: 344 -- upvalues: setFade (upval), a1 (val) -- types: a1_2: number
                setFade(a1, a1_2)
            end)
            local u31 = TweenService:Create(
                NumberValue,
                TweenInfo.new(a2.Time, a2.EasingStyle, a2.EasingDirection, a2.RepeatCount, a2.Reverses, a2.DelayTime + (a3 or 0)),
                {Value = 1}
            )
            u31:Play()
            local u39 = u31.Completed:Once(function() -- Line: 354 -- upvalues: u15 (val), setFade (upval), a1 (val), NumberValue (val)
                u15:Disconnect()
                setFade(a1, 1)
                NumberValue:Destroy()
            end)
            if a4 then
                a4:Add(function() -- Line: 360 -- upvalues: u39 (val), u15 (val), u31 (val), setFade (upval), a1 (val), NumberValue (val)
                    u39:Disconnect()
                    u15:Disconnect()
                    u31:Cancel()
                    u31:Destroy()
                    setFade(a1, 1)
                    NumberValue:Destroy()
                end)
            end
            return u31
        end

        local function fadeOut(a1, a2, a3, a4) -- Line: 372
            -- upvalues: setFade (val), TweenService (upval)
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = 1
            local u12 = NumberValue.Changed:Connect(function(a1_2) -- Line: 375 -- upvalues: setFade (upval), a1 (val) -- types: a1_2: number
                setFade(a1, a1_2)
            end)
            local u28 = TweenService:Create(
                NumberValue,
                TweenInfo.new(a2.Time, a2.EasingStyle, a2.EasingDirection, a2.RepeatCount, a2.Reverses, a2.DelayTime + (a3 or 0)),
                {Value = 0}
            )
            u28:Play()
            if a4 then
                a4:Add(function() -- Line: 386 -- upvalues: u12 (val), u28 (val), NumberValue (val)
                    u12:Disconnect()
                    u28:Cancel()
                    u28:Destroy()
                    NumberValue:Destroy()
                end)
            end
            u28.Completed:Once(function() -- Line: 393 -- upvalues: u12 (val), NumberValue (val)
                u12:Disconnect()
                NumberValue:Destroy()
            end)
            return u28
        end

        local function paintButton(a1, a2) -- Line: 400
            -- upvalues: u93 (val), u112 (val), TweenService (upval), u16 (val), u64 (val), u69 (val), u74 (val)
            local UIGradient = a1:FindFirstChildOfClass("UIGradient")
            if UIGradient then
                UIGradient.Color = if not a2 then u112 else u93
            end
            local UIStrokeClr = a1:FindFirstChild("UIStrokeClr")
            if UIStrokeClr and UIStrokeClr:IsA("UIStroke") then
                local v1 = TweenService
                v1:Create(UIStrokeClr, u16, {Color = if not a2 then u69 else u64}):Play()
            end
            local UIStroke = a1:FindFirstChild("UIStroke")
            if UIStroke and UIStroke:IsA("UIStroke") then
                local Attribute = UIStroke:GetAttribute("RimRestColor")
                if typeof(Attribute) ~= "Color3" then
                    UIStroke:SetAttribute("RimRestColor", UIStroke.Color)
                end
                local v2 = TweenService
                v2:Create(UIStroke, u16, {Color = if not a2 then u74 else Attribute}):Play()
            end
        end

        local function twitch(a1, a2) -- Line: 422
            -- upvalues: TweenService (upval), u44 (val), u49 (val), u54 (val)
            local v1
            if a1 == nil then
                return
            end
            local Twitch = a1:FindFirstChild("Twitch")
            if not Twitch or not Twitch:IsA("UIScale") then
                local UIScale = Instance.new("UIScale")
                UIScale.Name = "Twitch"
                UIScale.Parent = a1
                v1 = UIScale
            else
                v1 = Twitch
            end
            local Attribute = a1:GetAttribute("TwitchRotation")
            if typeof(Attribute) ~= "number" then
                a1:SetAttribute("TwitchRotation", a1.Rotation)
            end
            local u32 = Attribute
            v1.Scale = 1.22
            a1.Rotation = u32 + a2
            TweenService:Create(v1, u44, {Scale = 1}):Play()
            local v2 = TweenService:Create(a1, u49, {Rotation = u32 - a2 * 0.45})
            v2:Play()
            v2.Completed:Once(function(a1_2) -- Line: 442 -- upvalues: TweenService (upval), a1 (val), u54 (upval), u32 (val)
                if a1_2 ~= Enum.PlaybackState.Completed then
                    return
                end
                TweenService:Create(a1, u54, {Rotation = u32}):Play()
            end)
        end

        local function paintTab(a1, a2) -- Line: 450
            -- upvalues: paintButton (val), TweenService (upval), u16 (val)
            local v1
            paintButton(a1, a2)
            local v2 = TweenService
            local TabSelect = a1:FindFirstChild("TabSelect")
            if not TabSelect or not TabSelect:IsA("UIScale") then
                local UIScale = Instance.new("UIScale")
                UIScale.Name = "TabSelect"
                UIScale.Parent = a1
                v1 = UIScale
            else
                v1 = TabSelect
            end
            v2:Create(v1, u16, {Scale = if not a2 then 1 else 1.05}):Play()
        end

        local function collectionCheckpoint(a1, a2) -- Line: 459
            -- upvalues: u195 (ref), u135 (val)
            if a2 <= os.clock() then
                task.wait()
                a2 = os.clock() + 0.002
            end
            local Enabled = false
            if a1 == u195 then
                Enabled = u135.Enabled
            end
            return Enabled, a2
        end

        local function petValue(a1) -- Line: 467 -- upvalues: AssetItems (upval), LocalPlayer (val)
            local v1 = AssetItems.SalePrice(a1)
            if LocalPlayer:GetAttribute("VIP") then
                v1 = v1 * 2
            end
            return v1
        end

        local function collectPets(a1) -- Line: 475
            -- upvalues: Save (upval), u195 (ref), u135 (val), TryCall (upval), AssetItems (upval), Assets (upval)
            -- upvalues: AssetEarnings (upval), LocalPlayer (val)
            local v1 = {}
            local v2 = Save.Await()
            if a1 == u195 and u135.Enabled then
                local Enabled, v3, v4, v5, v6, v7
                if v2 == nil then
                    return v1
                end
                local Inventory = v2.Inventory
                if Inventory == nil then
                    return v1
                end
                local v8 = {}
                for i, v in ipairs(v2.EquippedAssets) do
                    v8[v] = true
                end
                v2 = os.clock() + 0.002
                for k, i2 in pairs(Inventory) do
                    v5 = v2
                    if v5 <= os.clock() then
                        task.wait()
                        v5 = os.clock() + 0.002
                    end
                    Enabled = false
                    if v9 == u195 then
                        Enabled = u135.Enabled
                    end
                    if not Enabled then
                        return nil
                    end
                    v3, v4 = TryCall(AssetItems.Decode, i2)
                    if v3
                        and v4.IsFavorite ~= true
                        and v4.InFuse ~= true
                        and not v8[k]
                        and Assets.AssetNameExists(v4.Category) then
                        v6 = {
                            Kind = "Pets",
                            Icon = Assets.Directory[v4.Category].Icon or "",
                            ItemData = v4,
                            Rate = AssetEarnings.RatePerSecond(v4),
                            Uid = k,
                        }
                        v7 = AssetItems.SalePrice(v4)
                        if LocalPlayer:GetAttribute("VIP") then
                            v7 = v7 * 2
                        end
                        v6.Value = v7
                        v6.Weight = AssetItems.WeightKg(v4)
                        v6.WeightLabel = AssetItems.WeightLabel(v4)
                        table.insert(v1, v6)
                    end
                end
                return v1
            end
            return nil
        end

        local function collectEggs(a1) -- Line: 525
            -- upvalues: Save (upval), u195 (ref), u135 (val), TryCall (upval), EggRecords (upval), Assets (upval)
            -- upvalues: AssetEarnings (upval)
            local v1 = {}
            local v2 = Save.Await()
            if a1 == u195 and u135.Enabled then
                local Enabled, Icon, v3, v4, v5, v6, v7
                local EggInventory = v2 and v2.EggInventory
                if EggInventory == nil then
                    return v1
                end
                v2 = os.clock() + 0.002
                for k, v in pairs(EggInventory) do
                    v6 = v2
                    if v6 <= os.clock() then
                        task.wait()
                        v6 = os.clock() + 0.002
                    end
                    Enabled = false
                    if v3 == u195 then
                        Enabled = u135.Enabled
                    end
                    if not Enabled then
                        return nil
                    end
                    if v.Placement == nil then
                        v4, v5 = TryCall(EggRecords.Decode, v)
                        if v4 then
                            v4 = Assets.Directory[v5.AssetCategory]
                            if v4 ~= nil then
                                v7 = {Kind = "Eggs"}
                                Icon = v4.Egg and v4.Egg.Icon or v4.Icon or ""
                                v7.Icon = Icon
                                v7.Rate = AssetEarnings.RatePerSecond(EggRecords.ToAssetItemData(v5))
                                v7.Uid = k
                                v7.Value = EggRecords.SellPrice(v5)
                                v7.Weight = EggRecords.WeightKg(v5)
                                v7.WeightLabel = EggRecords.WeightLabel(v5)
                                table.insert(v1, v7)
                            end
                        end
                    end
                end
                return v1
            end
            return nil
        end

        local function sortEntries() -- Line: 571 -- upvalues: u182 (ref), u180 (ref), u181 (ref)
            table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                if Weight == Weight_2 then
                    return a1.Uid < a2.Uid
                end
                if u181 then
                    return Weight_2 < Weight
                end
                return Weight < Weight_2
            end)
        end

        local function selectionCount() -- Line: 582 -- upvalues: u183 (val)
            local v1 = 0
            for k in pairs(u183) do
                v1 = v1 + 1
            end
            return v1
        end

        local function popCard(a1, a2) -- Line: 590
            -- upvalues: TweenService (upval), u31 (val)
            local v1
            local Template = a1:FindFirstChild("Template")
            if Template == nil then
                return
            end
            local SelectPop = Template:FindFirstChild("SelectPop")
            if not SelectPop or not SelectPop:IsA("UIScale") then
                local UIScale = Instance.new("UIScale")
                UIScale.Name = "SelectPop"
                UIScale.Parent = Template
                v1 = UIScale
            else
                v1 = SelectPop
            end
            v1.Scale = if not a2 then 1.06 else 0.88
            TweenService:Create(v1, u31, {Scale = 1}):Play()
        end

        local function paintCard(a1, a2, a3) -- Line: 601
            -- upvalues: popCard (val)
            local SelectedOverlay = a1:FindFirstChild("SelectedOverlay")
            local SelectedIcon = a1:FindFirstChild("SelectedIcon")
            if SelectedOverlay and SelectedOverlay:IsA("GuiObject") then
                SelectedOverlay.Visible = a2
            end
            if SelectedIcon and SelectedIcon:IsA("GuiObject") then
                SelectedIcon.Visible = a2
            end
            if a3 then
                popCard(a1, a2)
            end
        end

        local function totalLabel() -- Line: 615 -- upvalues: SellInfoHolder (val)
            local Value = SellInfoHolder:FindFirstChild("Value")
            if Value and Value:IsA("TextLabel") then
                return Value
            end
            return nil
        end

        local function writeTotal(a1) -- Line: 623
            -- upvalues: SellInfoHolder (val), Simple (upval), Numbers (upval)
            local Value = SellInfoHolder:FindFirstChild("Value")
            local v1 = if not Value then nil else if not Value:IsA("TextLabel") then nil else Value
            if v1 then
                local v2 = if not (a1 > 99999) then "$" .. Numbers.AddCommas((math.round(a1))) else "$" .. Simple.FormatCompact(math.round(a1), ".#")
                v1.Text = v2
            end
        end

        local function clearTotalRoll() -- Line: 630 -- upvalues: u190 (ref), u191 (ref)
            if u190 then
                u190:Cancel()
                u190 = nil
            end
            if u191 then
                u191:Destroy()
                u191 = nil
            end
        end

        local function showTotal(a1, a2) -- Line: 641
            -- upvalues: u190 (ref), u191 (ref), u189 (ref), SellInfoHolder (val), Simple (upval), Numbers (upval)
            -- upvalues: writeTotal (val), TweenService (upval), u21 (val)
            if a2 then
                if u190 then
                    u190:Cancel()
                    u190 = nil
                end
                if u191 then
                    u191:Destroy()
                    u191 = nil
                end
                u189 = a1
                local Value = SellInfoHolder:FindFirstChild("Value")
                local v1 = if not Value then nil else if not Value:IsA("TextLabel") then nil else Value
                if v1 then
                    local v2 = if not (a1 > 99999) then "$" .. Numbers.AddCommas((math.round(a1))) else "$" .. Simple.FormatCompact(math.round(a1), ".#")
                    v1.Text = v2
                end
                return
            end
            if (math.round(a1)) == math.round(u189) then
                return
            end
            local Value_2 = if not u191 then u189 else u191.Value
            if u190 then
                u190:Cancel()
                u190 = nil
            end
            if u191 then
                u191:Destroy()
                u191 = nil
            end
            u189 = a1
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = Value_2
            u191 = NumberValue
            local Value_3 = SellInfoHolder:FindFirstChild("Value")
            local v3 = if not Value_3 then nil else if not Value_3:IsA("TextLabel") then nil else Value_3
            if v3 then
                local v4 = if not (Value_2 > 99999) then "$" .. Numbers.AddCommas((math.round(Value_2))) else "$" .. Simple.FormatCompact(math.round(Value_2), ".#")
                v3.Text = v4
            end
            NumberValue.Changed:Connect(writeTotal)
            local u135 = TweenService:Create(NumberValue, u21, {Value = a1})
            u135:Play()
            u190 = u135
            u135.Completed:Once(function(a1_2) -- Line: 666
                -- upvalues: u190 (upval), u135 (val), u191 (upval), a1 (val), SellInfoHolder (upval), Simple (upval)
                -- upvalues: Numbers (upval), NumberValue (val)
                if u190 ~= u135 then
                    return
                end
                u190 = nil
                u191 = nil
                if a1_2 == Enum.PlaybackState.Completed then
                    local v1 = a1
                    local Value = SellInfoHolder:FindFirstChild("Value")
                    local v2 = if not Value then nil else if not Value:IsA("TextLabel") then nil else Value
                    if v2 then
                        local v3 = if not (v1 > 99999) then "$" .. Numbers.AddCommas((math.round(v1))) else "$" .. Simple.FormatCompact(math.round(v1), ".#")
                        v2.Text = v3
                    end
                end
                NumberValue:Destroy()
            end)
        end

        local function setSellEnabled(a1) -- Line: 679 -- upvalues: Sell (val), paintButton (val) -- types: a1: boolean
            Sell.Active = a1
            Sell.AutoButtonColor = a1
            paintButton(Sell, a1)
        end

        local function refreshFooter() -- Line: 685
            -- upvalues: u182 (ref), u183 (val), Sell (val), u188 (ref), u192 (val), paintButton (val), showTotal (val)
            -- upvalues: SelectAll (val), Clear (val)
            local v1 = 0
            local v2 = 0
            for i, v in ipairs(u182) do
                if u183[v.Uid] then
                    v1 = v1 + 1
                    v2 = v2 + v.Value
                end
            end
            local v3 = false
            if #u182 > 0 then
                v3 = v1 == #u182
            end
            local v4 = Sell:FindFirstChildWhichIsA("TextLabel")
            if v4 then
                v4.Text = if v1 ~= 0 then if not v3 then ("Sell (%*)"):format(v1) else "Sell All" else "Sell"
            end
            local v5 = false
            if v1 > 0 then
                v5 = not u188 and not u192.Selling
            end
            Sell.Active = v5
            Sell.AutoButtonColor = v5
            paintButton(Sell, v5)
            showTotal(v2)
            SelectAll.Visible = not v3
            Clear.Visible = v3
        end

        local function setEverySelected(a1) -- Line: 712
            -- upvalues: u182 (ref), u188 (ref), u192 (val), u183 (val), u184 (val), u175 (val), paintCard (val)
            -- upvalues: refreshFooter (val)
            if #u182 ~= 0 and not u188 and not u192.Selling and not u192.Confirming then
                local v1, v2
                local v3 = 0
                for i, v in ipairs(u182) do
                    v2 = if not a1 then nil else true
                    u183[v.Uid] = v2
                    local u34 = u184[v.Uid]
                    if u34 ~= nil then
                        v1 = u175[v.Uid]
                        v3 = v3 + 1
                        v1:Add((task.delay((v3 - 1) * 0.012, function() -- Line: 727 -- upvalues: u34 (val), paintCard (upval), u183 (upval), v (val)
                            if u34.Parent then
                                paintCard(u34, u183[v.Uid] == true, true)
                            end
                        end)))
                    end
                end
                refreshFooter()
                return
            end
        end

        local function revealPanel() -- Line: 737
            -- upvalues: u171 (val), fadeIn (val), captureFade (val), Frame (val), ScrollingFrame (val), u26 (val)
            u171:Clean()
            fadeIn(captureFade(Frame, {ScrollingFrame}), u26, nil, u171)
        end

        local function showBackdrop(a1) -- Line: 742 -- upvalues: Backdrop (val) -- types: a1: boolean
            if Backdrop == nil then
                return
            end
            local v1 = Backdrop
            v1.BackgroundTransparency = 1
            v1.Visible = a1
        end

        local function labelScale(a1) -- Line: 752 -- upvalues: u135 (val) -- types: a1: userdata
            local UIScale
            local v1 = 1
            local Parent = a1.Parent
            while Parent do
                if Parent == u135 then
                    break
                end
                UIScale = Parent:FindFirstChildOfClass("UIScale")
                if UIScale then
                    v1 = v1 * UIScale.Scale
                end
                Parent = Parent.Parent
            end
            if v1 > 0 then
                return v1
            end
            return 1
        end

        local function widthPerPoint(a1, a2) -- Line: 765
            -- upvalues: u198 (val), TextService (upval), u201 (ref)
            local FontFace = a1.FontFace
            local v1 = ("%*|%*|%*|%*|%*"):format(FontFace.Family, FontFace.Weight.Name, FontFace.Style.Name, a1.RichText, a2)
            local v2 = u198[v1]
            if v2 then
                return v2
            end
            local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
            GetTextBoundsParams.Text = a2
            GetTextBoundsParams.Font = FontFace
            GetTextBoundsParams.Size = 100
            GetTextBoundsParams.RichText = a1.RichText
            local success, err = pcall(function() -- Line: 779 -- upvalues: TextService (upval), GetTextBoundsParams (val)
                return TextService:GetTextBoundsAsync(GetTextBoundsParams)
            end)
            GetTextBoundsParams:Destroy()
            if success and err ~= nil and not (err.X <= 0) then
                local v3 = err.X / 100
                u198[v1] = v3
                return v3
            end
            u201 = true
            local v4 = utf8.len(a2) or #a2
            return 0.55 * v4
        end

        local function fitSize(a1) -- Line: 793 -- upvalues: labelScale (val), widthPerPoint (val) -- types: a1: table
            local Label, v1, v2
            table.sort(a1, function(a1, a2) -- Line: 794 -- types: a1: table, a2: table
                local v1 = #a1.Text
                return #a2.Text < v1
            end)
            local v3 = (1 / 0)
            local v4 = 0
            for i, v in ipairs(a1) do
                Label = v.Label
                if Label.Parent ~= nil then
                    v2 = Label.AbsoluteSize / labelScale(Label)
                    if not (v2.X <= 0) and not (v2.Y <= 0) then
                        v3 = math.min(v3, v2.Y)
                        if v4 < 3 then
                            v1 = widthPerPoint(Label, v.Text)
                            if v1 > 0 then
                                v4 = v4 + 1
                                v3 = math.min(v3, v2.X / v1)
                            end
                        end
                    end
                end
            end
            if v3 == (1 / 0) then
                return 0
            end
            return v3
        end

        local function refitLabels(a1) -- Line: 826
            -- upvalues: u135 (val), Weight (val), Value (val), SelectAll (val), Clear (val), u205 (val), fitSize (val)
            -- upvalues: u195 (ref)
            local FitLimit, Label, TextLabel, UITextSizeConstraint, v1, v2
            if not u135.Enabled then
                return
            end
            local v3 = {Sort = {}}
            for i, v in ipairs({Weight, Value, SelectAll, Clear}) do
                TextLabel = v:FindFirstChildWhichIsA("TextLabel")
                if TextLabel then
                    table.insert(v3.Sort, {Label = TextLabel, Text = TextLabel.Text})
                end
            end
            for k, i2 in pairs(u205) do
                for i3, j in ipairs(i2) do
                    v1 = v3[j.Role]
                    if v1 == nil then
                        v3[j.Role] = {}
                    end
                    table.insert(v1, {Label = j.Label, Text = j.Text})
                end
            end
            for k2, k3 in pairs(v3) do
                v2 = math.floor((fitSize(k3)))
                if a1 == u195 and u135.Enabled then
                    if not (v2 <= 0) then
                        v2 = math.max(v2, 6)
                        for i4, n in ipairs(k3) do
                            Label = n.Label
                            if Label.Parent ~= nil then
                                FitLimit = Label:FindFirstChild("FitLimit")
                                if FitLimit == nil or not FitLimit:IsA("UITextSizeConstraint") then
                                    UITextSizeConstraint = Instance.new("UITextSizeConstraint")
                                    UITextSizeConstraint.Name = "FitLimit"
                                    UITextSizeConstraint.Parent = Label
                                    FitLimit = UITextSizeConstraint
                                end
                                FitLimit.MaxTextSize = v2
                                Label.TextWrapped = false
                                Label.TextScaled = true
                            end
                        end
                    end
                    continue
                end
                return
            end
        end

        function queueRefit() -- Line: 882
            -- upvalues: u200 (ref), u484 (ref), RunService (upval), u195 (ref), u201 (ref), refitLabels (val)
            -- upvalues: u135 (val), queueRefit (val), u202 (ref)
            u200 = u200 + 1
            if u484 then
                return
            end
            u484 = true
            task.defer(function() -- Line: 889
                -- upvalues: RunService (upval), u195 (upval), u200 (upval), u201 (upval), refitLabels (upval)
                -- upvalues: u484 (upval), u135 (upval), queueRefit (upval), u202 (upval)
                RunService.PreRender:Wait()
                local u5 = u195
                local v1 = u200
                u201 = false
                refitLabels(u5)
                u484 = false
                if u5 == u195 and u135.Enabled then
                    if v1 ~= u200 then
                        queueRefit()
                    end
                    if u201 and u202 < 5 then
                        u202 = u202 + 1
                        task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                            if u5 == u195 and u135.Enabled then
                                queueRefit()
                            end
                        end)
                    end
                    return
                end
            end)
        end

        local function isPhone() -- Line: 913
            -- upvalues: UserInputService (upval), PlatformController (upval), u135 (val), Workspace (upval)
            local TouchEnabled = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
            if not PlatformController.IsMobile() and not TouchEnabled then
                return false
            end
            local AbsoluteSize = u135.AbsoluteSize
            if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera then
                    AbsoluteSize = CurrentCamera.ViewportSize
                end
            end
            local v1 = math.min(AbsoluteSize.X, AbsoluteSize.Y)
            if v1 <= 0 then
                return false
            end
            if v1 <= 550 then
                return true
            end
            return 1.7 <= math.max(AbsoluteSize.X, AbsoluteSize.Y) / v1
        end

        local function applyPlatformLayout() -- Line: 935
            -- upvalues: isPhone (val), Frame (val), u35 (val), Size (val), UIGridLayout (val), u39 (val)
            -- upvalues: CellSize (val), u200 (ref), u484 (ref), RunService (upval), u195 (ref), u201 (ref)
            -- upvalues: refitLabels (val), u135 (val), queueRefit (val), u202 (ref)
            local v1 = isPhone()
            Frame.Size = if not v1 then Size else u35
            UIGridLayout.CellSize = if not v1 then CellSize else u39
            u200 = u200 + 1
            if u484 then
                return
            end
            u484 = true
            task.defer(function() -- Line: 889
                -- upvalues: RunService (upval), u195 (upval), u200 (upval), u201 (upval), refitLabels (upval)
                -- upvalues: u484 (upval), u135 (upval), queueRefit (upval), u202 (upval)
                RunService.PreRender:Wait()
                local u5 = u195
                local v1 = u200
                u201 = false
                refitLabels(u5)
                u484 = false
                if u5 == u195 and u135.Enabled then
                    if v1 ~= u200 then
                        queueRefit()
                    end
                    if u201 and u202 < 5 then
                        u202 = u202 + 1
                        task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                            if u5 == u195 and u135.Enabled then
                                queueRefit()
                            end
                        end)
                    end
                    return
                end
            end)
        end

        local function rollLabel(a1, a2, a3, a4, a5, a6) -- Line: 942
            -- upvalues: TweenService (upval), u11 (val)
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = 0
            a1.Text = a3(0)
            local u17 = NumberValue.Changed:Connect(function(a1_2) -- Line: 954 -- upvalues: a1 (val), a3 (val) -- types: a1_2: number
                a1.Text = a3(a1_2)
            end)
            a6:Add(u17)
            a6:Add(NumberValue)
            local u42 = TweenService:Create(NumberValue, TweenInfo.new(u11.Time, u11.EasingStyle, u11.EasingDirection, 0, false, a5), {Value = a2})
            u42:Play()
            a6:Add(function() -- Line: 966 -- upvalues: u42 (val)
                u42:Cancel()
                u42:Destroy()
            end)
            a6:Add((u42.Completed:Once(function(a1_2) -- Line: 967 -- upvalues: u17 (val), a1 (val), a4 (val), NumberValue (val)
                u17:Disconnect()
                if a1_2 == Enum.PlaybackState.Completed then
                    a1.Text = a4
                end
                NumberValue:Destroy()
            end)))
        end

        local function weightText(a1) -- Line: 976 -- upvalues: Numbers (upval) -- types: a1: number
            return (("(%*Kg)"):format((Numbers.AddCommas(a1))))
        end

        local function buildCard(a1, a2, a3) -- Line: 980
            -- upvalues: Trove (upval), u175 (val), u176 (val), u205 (val), u177 (val), TemplateHolder (val), u193 (ref)
            -- upvalues: AssetIconShape (upval), rollLabel (val), weightText (val), Simple (upval), Numbers (upval)
            -- upvalues: money (val), u183 (val), u178 (val), ButtonFX (upval), u188 (ref), u192 (val), Frame_2 (val)
            -- upvalues: paintCard (val), refreshFooter (val), u184 (val), u185 (val), TweenService (upval), u6 (val)
            -- upvalues: fadeIn (val), captureFade (val), u194 (ref), Audio (upval)
            local v1
            local v2 = Trove.new()
            u175[a1.Uid] = v2
            local v3 = Trove.new()
            v2:Add(v3)
            if a3 then
                u176[a1.Uid] = v3
            end
            v2 = {}
            u205[a1.Uid] = v2
            local u27 = table.remove(u177)
            if not u27 then
                u27 = TemplateHolder:Clone()
            end
            u27.Name = a1.Uid
            u27.LayoutOrder = a2
            u27.Visible = true
            local RevealScale = u27:FindFirstChild("RevealScale")
            if RevealScale and RevealScale:IsA("UIScale") then
                RevealScale.Scale = 1
            end
            local v4 = math.min((a2 - 1) * 0.03, 0.7)
            local v5 = math.min(u193 + (a2 - 1) * 0.03, 0.7)
            local Template = u27:FindFirstChild("Template")
            if Template then
                local v6
                local Icon = Template:FindFirstChild("Icon")
                if Icon and Icon:IsA("ImageLabel") then
                    Icon.Image = a1.Icon
                    if a1.ItemData == nil then
                        AssetIconShape.Strip(Icon)
                    else
                        AssetIconShape.Paint(Icon, a1.ItemData)
                    end
                end
                local Weight = Template:FindFirstChild("Weight")
                if Weight and Weight:IsA("TextLabel") then
                    v6 = ("(%*)"):format(a1.WeightLabel)
                    table.insert(v2, {Role = "Weight", Label = Weight, Text = v6})
                    if not a3 then
                        Weight.Text = v6
                    else
                        rollLabel(Weight, a1.Weight, weightText, v6, v4, v3)
                    end
                end
                local Amount = Template:FindFirstChild("Amount")
                if Amount and Amount:IsA("TextLabel") then
                    local Rate = a1.Rate
                    v6 = ("%*/s"):format(if not (Rate > 99999) then "$" .. Numbers.AddCommas((math.round(Rate))) else "$" .. Simple.FormatCompact(math.round(Rate), ".#"))
                    table.insert(v2, {Role = "Amount", Label = Amount, Text = v6})
                    if not a3 then
                        Amount.Text = v6
                    else
                        rollLabel(Amount, a1.Rate, function(a1) -- Line: 1034 -- upvalues: Simple (upval), Numbers (upval) -- types: a1: number
                            local v1 = if not (a1 > 99999) then "$" .. Numbers.AddCommas((math.round(a1))) else "$" .. Simple.FormatCompact(math.round(a1), ".#")
                            return (("%*/s"):format(v1))
                        end, v6, v4, v3)
                    end
                end
                local ValueHolder = Template:FindFirstChild("ValueHolder")
                local Value = ValueHolder and ValueHolder:FindFirstChild("Value")
                if Value and Value:IsA("TextLabel") then
                    local Value_2 = a1.Value
                    table.insert(v2, {
                        Role = "Value",
                        Label = Value,
                        Text = if not (Value_2 > 99999) then "$" .. Numbers.AddCommas((math.round(Value_2))) else "$" .. Simple.FormatCompact(math.round(Value_2), ".#"),
                    })
                    if not a3 then
                        Value.Text = v1
                    else
                        rollLabel(Value, a1.Value, money, v1, v4, v3)
                    end
                end
            end
            v1 = u183[a1.Uid] == true
            local v7 = u27:FindFirstChild("SelectedOverlay")
            v4 = u27:FindFirstChild("SelectedIcon")
            if v7 and v7:IsA("GuiObject") then
                v7.Visible = v1
            end
            if v4 and v4:IsA("GuiObject") then
                v4.Visible = v1
            end
            if u178[u27] == nil then
                v2 = Instance.new("TextButton")
                v2.BackgroundTransparency = 1
                v2.Text = ""
                v2.Name = "Hitbox"
                v2.Size = UDim2.fromScale(1, 1)
                v2.ZIndex = 100
                v2.Parent = u27
                u178[u27] = (ButtonFX(v2, 1.06, function() -- Line: 1071
                    -- upvalues: u188 (upval), u192 (upval), u27 (val), Frame_2 (upval), u183 (upval), paintCard (upval)
                    -- upvalues: refreshFooter (upval)
                    if not u188 and not u192.Selling and not u192.Confirming and u27.Parent == Frame_2 then
                        local Name = u27.Name
                        u183[Name] = if not u183[Name] then true else nil
                        paintCard(u27, u183[Name] == true, true)
                        refreshFooter()
                        return
                    end
                end))
            end
            u27.Parent = Frame_2
            u184[a1.Uid] = u27
            u185[a1.Uid] = a1
            if a3 then
                local RevealScale_2 = u27:FindFirstChild("RevealScale")
                if not RevealScale_2 or not RevealScale_2:IsA("UIScale") then
                    local UIScale = Instance.new("UIScale")
                    UIScale.Name = "RevealScale"
                    UIScale.Parent = u27
                    v1 = UIScale
                else
                    v1 = RevealScale_2
                end
                v1.Scale = 0.55
                local u359 = TweenService:Create(v1, TweenInfo.new(u6.Time, u6.EasingStyle, u6.EasingDirection, 0, false, v5), {Scale = 1})
                u359:Play()
                v3:Add(function() -- Line: 1094 -- upvalues: u359 (val)
                    u359:Cancel()
                    u359:Destroy()
                end)
                fadeIn(captureFade(u27), u6, v5, v3)
            end
            if a3 and u194 < 8 then
                u194 = u194 + 1
                v3:Add((task.delay(v5, function() -- Line: 1100 -- upvalues: u27 (val), Audio (upval)
                    if u27.Parent == nil then
                        return
                    end
                    Audio.Play("rbxassetid://139800881181209", script, {PlaybackSpeed = 1.55, Volume = 0.11199999999999999})
                end)))
            end
            return u27
        end

        local u261 = false

        local function finishOpeningReveal() -- Line: 1115 -- upvalues: u196 (ref), u176 (val), u184 (val), u205 (val)
            local RevealScale, UIScale, v1, v2, v3
            u196 = false
            for k, v in pairs(u176) do
                v:Clean()
                v1 = u184[k]
                if v1 then
                    RevealScale = v1:FindFirstChild("RevealScale")
                    if not RevealScale or not RevealScale:IsA("UIScale") then
                        UIScale = Instance.new("UIScale")
                        UIScale.Name = "RevealScale"
                        UIScale.Parent = v1
                        v2 = UIScale
                    else
                        v2 = RevealScale
                    end
                    v2.Scale = 1
                end
                v2 = ipairs
                v3 = u205[k] or {}
                for i, i2 in v2(v3) do
                    i2.Label.Text = i2.Text
                end
                u176[k] = nil
            end
        end

        local function destroyCard(a1) -- Line: 1130 -- upvalues: u178 (val) -- types: a1: userdata
            local v1 = u178[a1]
            if v1 then
                v1()
                u178[a1] = nil
            end
            a1:Destroy()
        end

        local function removeCard(a1, a2) -- Line: 1139
            -- upvalues: u184 (val), u175 (val), u177 (val), u178 (val), u205 (val), u176 (val), u185 (val)
            local v1 = u184[a1]
            local v2 = u175[a1]
            if v2 then
                v2:Destroy()
                u175[a1] = nil
            end
            if v1 then
                local v3
                u184[a1] = nil
                if not a2 then
                    v3 = u178[v1]
                    if v3 then
                        v3()
                        u178[v1] = nil
                    end
                    v1:Destroy()
                else
                    v3 = #u177
                    if not (v3 < 24) then
                        v3 = u178[v1]
                        if v3 then
                            v3()
                            u178[v1] = nil
                        end
                        v1:Destroy()
                    else
                        v1.Parent = nil
                        local Template = v1:FindFirstChild("Template")
                        local SelectPop = Template and Template:FindFirstChild("SelectPop")
                        if SelectPop then
                            SelectPop:Destroy()
                        end
                        table.insert(u177, v1)
                    end
                end
            end
            u205[a1] = nil
            u176[a1] = nil
            u185[a1] = nil
        end

        local function clearCards() -- Line: 1164
            -- upvalues: u184 (val), u175 (val), u178 (val), u205 (val), u176 (val), u185 (val), u177 (val)
            local v1, v2
            for k in pairs(u184) do
                v1 = u184[k]
                v2 = u175[k]
                if v2 then
                    v2:Destroy()
                    u175[k] = nil
                end
                if v1 then
                    u184[k] = nil
                    v2 = u178[v1]
                    if v2 then
                        v2()
                        u178[v1] = nil
                    end
                    v1:Destroy()
                end
                u205[k] = nil
                u176[k] = nil
                u185[k] = nil
            end
            for i, v in ipairs(u177) do
                v1 = u178[v]
                if v1 then
                    v1()
                    u178[v] = nil
                end
                v:Destroy()
            end
            table.clear(u177)
        end

        local function sameCardContent(a1, a2) -- Line: 1253
            -- upvalues: AssetIconShape (upval)
            if a1.Icon == a2.Icon
                and a1.Kind == a2.Kind
                and a1.Value == a2.Value
                and a1.Rate == a2.Rate
                and a1.Weight == a2.Weight
                and a1.WeightLabel == a2.WeightLabel then
                local ItemData = a1.ItemData
                local ItemData_2 = a2.ItemData
                if ItemData ~= nil and ItemData_2 ~= nil then
                    local v1 = AssetIconShape.ResolveImages(ItemData)
                    local v2 = AssetIconShape.ResolveImages(ItemData_2)
                    local v3 = false
                    if v1.Icon == v2.Icon then
                        v3 = v1.RainbowOverlay == v2.RainbowOverlay
                    end
                    return v3
                end
                return ItemData == ItemData_2
            end
            return false
        end

        local function rebuild(a1, a2) -- Line: 1269
            -- upvalues: u195 (ref), u187 (ref), u186 (ref), u196 (ref), u197 (ref), u188 (ref)
            -- upvalues: finishOpeningReveal (val), clearCards (val), u182 (ref), u194 (ref), u202 (ref)
            -- upvalues: ScrollingFrame (val), refreshFooter (val), u135 (val), u179 (ref), collectEggs (val)
            -- upvalues: collectPets (val), u180 (ref), u181 (ref), u184 (val), u185 (val), sameCardContent (val)
            -- upvalues: removeCard (val), u183 (val), u261 (ref)
            u195 = u195 + 1
            u187 = u187 + 1
            u186 = false
            local u7 = u195
            u196 = a1 == true
            u197 = nil
            u188 = true
            if not a2 then
                clearCards()
                u182 = {}
            else
                finishOpeningReveal()
            end
            u194 = 0
            u202 = 0
            if not a2 then
                ScrollingFrame.CanvasPosition = Vector2.zero
            end
            refreshFooter()
            task.defer(function() -- Line: 1291
                -- upvalues: u7 (val), u195 (upval), u135 (upval), u179 (upval), collectEggs (upval)
                -- upvalues: collectPets (upval), u182 (upval), u180 (upval), u181 (upval), u184 (upval), u185 (upval)
                -- upvalues: sameCardContent (upval), removeCard (upval), u183 (upval), u188 (upval), u261 (upval)
                -- upvalues: refreshFooter (upval)
                task.wait()
                if u7 == u195 and u135.Enabled then
                    local v1 = if u179 ~= "Eggs" then collectPets(u7) else collectEggs(u7)
                    if v1 ~= nil and u7 == u195 and u135.Enabled then
                        local Uid, v2, v3
                        u182 = v1
                        table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                            local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                            local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                            if Weight == Weight_2 then
                                return a1.Uid < a2.Uid
                            end
                            if u181 then
                                return Weight_2 < Weight
                            end
                            return Weight < Weight_2
                        end)
                        v1 = {}
                        for i, v in ipairs(u182) do
                            Uid = v.Uid
                            v1[Uid] = true
                            v2 = u184[Uid]
                            if v2 then
                                v3 = u185[Uid]
                                if not v3 or not sameCardContent(v3, v) then
                                    removeCard(Uid, true)
                                else
                                    v2.LayoutOrder = i
                                    u185[Uid] = v
                                end
                            end
                        end
                        for k in pairs(u184) do
                            if not v1[k] then
                                removeCard(k, true)
                            end
                        end
                        for k2 in pairs(u183) do
                            if not v1[k2] then
                                u183[k2] = nil
                            end
                        end
                        u188 = false
                        u261 = true
                        refreshFooter()
                        return
                    end
                    return
                end
            end)
        end

        local function setCategory(a1, a2) -- Line: 1355
            -- upvalues: u192 (val), u179 (ref), u183 (val), Header (val), u113 (val), u130 (val), paintTab (val)
            -- upvalues: PetsTab (val), EggsTab (val), twitch (val), u135 (val), rebuild (val)
            if not u192.Selling and not u192.Confirming and u179 ~= a1 then
                u179 = a1
                table.clear(u183)
                local Title = Header:FindFirstChild("Title")
                local Title2Stroke = Header:FindFirstChild("Title2Stroke")
                if Title and Title:IsA("TextLabel") then
                    Title.Text = u113[a1]
                end
                if Title2Stroke and Title2Stroke:IsA("TextLabel") then
                    Title2Stroke.Text = u113[a1]
                end
                local Icon = Header:FindFirstChild("Icon")
                if Icon and Icon:IsA("ImageLabel") then
                    Icon.Image = u130[a1]
                end
                paintTab(PetsTab, a1 == "Pets")
                paintTab(EggsTab, a1 == "Eggs")
                if a2 then
                    twitch(if not Icon then nil else if not Icon:IsA("ImageLabel") then nil else Icon, 10)
                    twitch((if a1 ~= "Pets" then EggsTab else PetsTab):FindFirstChildWhichIsA("ImageLabel"), -12)
                end
                if u135.Enabled then
                    rebuild()
                end
                return
            end
        end

        local function paintSortButtons() -- Line: 1390
            -- upvalues: Weight (val), Value (val), u180 (ref), paintButton (val), u181 (ref)
            local Icon, v1
            for i, v in ipairs({Weight, Value}) do
                v1 = v == Weight == (u180 == "Weight")
                paintButton(v, v1)
                Icon = v:FindFirstChild("Icon")
                if Icon and Icon:IsA("ImageLabel") then
                    Icon.Rotation = if not v1 then 90 else if u181 then 90 else -90
                end
            end
        end

        local function setSort(a1) -- Line: 1401
            -- upvalues: u192 (val), u180 (ref), u181 (ref), paintSortButtons (val), rebuild (val)
            if not u192.Selling and not u192.Confirming then
                if u180 ~= a1 then
                    u180 = a1
                    u181 = true
                else
                    u181 = not u181
                end
                paintSortButtons()
                rebuild()
                return
            end
        end

        local function flyPayout(a1) -- Line: 1416 -- upvalues: Save (upval), SellPayout (upval) -- types: a1: table
            local v1 = Save.Await()
            if v1 == nil then
                return
            end
            local Money = v1.Money
            local u5 = false
            local u6 = nil
            u6 = Save.Changed:Connect(function(a1_2) -- Line: 1426
                -- upvalues: u5 (ref), Save (upval), Money (val), u6 (ref), SellPayout (upval), a1 (val)
                if a1_2 == "Money" and not u5 then
                    local v1
                    local v2 = Save.Await()
                    if (if not v2 then 0 else v2.Money - Money) <= 0 then
                        return
                    end
                    u5 = true
                    if u6 then
                        u6:Disconnect()
                    end
                    SellPayout.Award(v1, a1)
                    return
                end
            end)
            task.delay(4, function() -- Line: 1445 -- upvalues: u5 (ref), u6 (ref)
                if not u5 and u6 then
                    u6:Disconnect()
                end
            end)
        end

        u135.Enabled = false
        TemplateHolder.Visible = false
        if Backdrop then
            Backdrop.Visible = false
        end
        v1:Add((ButtonFX(PetsTab, 1.06, function() -- Line: 1594 -- upvalues: setCategory (val)
            setCategory("Pets", true)
        end)))
        v1:Add((ButtonFX(EggsTab, 1.06, function() -- Line: 1595 -- upvalues: setCategory (val)
            setCategory("Eggs", true)
        end)))
        v1:Add((ButtonFX(Weight, 1.06, function() -- Line: 1596 -- upvalues: u192 (val), u180 (ref), u181 (ref), paintSortButtons (val), rebuild (val)
            if not u192.Selling then
                if u192.Confirming then
                    return
                end
                if u180 ~= "Weight" then
                    u180 = "Weight"
                    u181 = true
                else
                    u181 = not u181
                end
                paintSortButtons()
                rebuild()
            end
        end)))
        v1:Add((ButtonFX(Value, 1.06, function() -- Line: 1597 -- upvalues: u192 (val), u180 (ref), u181 (ref), paintSortButtons (val), rebuild (val)
            if not u192.Selling then
                if u192.Confirming then
                    return
                end
                if u180 ~= "Value" then
                    u180 = "Value"
                    u181 = true
                else
                    u181 = not u181
                end
                paintSortButtons()
                rebuild()
            end
        end)))
        v1:Add((ButtonFX(Sell, 1.08, function() -- Line: 1452
            -- upvalues: u188 (ref), u192 (val), u195 (ref), u183 (val), u182 (ref), u179 (ref), Message (upval)
            -- upvalues: u121 (val), u129 (val), Simple (upval), Numbers (upval), u186 (ref), u135 (val), u187 (ref)
            -- upvalues: u196 (ref), u197 (ref), finishOpeningReveal (val), u194 (ref), u202 (ref), refreshFooter (val)
            -- upvalues: collectEggs (val), collectPets (val), u180 (ref), u181 (ref), u184 (val), u185 (val)
            -- upvalues: sameCardContent (val), removeCard (val), u261 (ref), SellInfoHolder (val), flyPayout (val)
            -- upvalues: u174 (val), captureFade (val), TweenService (upval), u59 (val), fadeOut (val), setFade (val)
            -- upvalues: Remotes (upval), Audio (upval)
            if not u188 and not u192.Selling and not u192.Confirming then
                local Icon, RevealScale, UIScale, Value, sendBatches, v1
                local u279 = u195
                local v2 = {}
                local v3 = {}
                local v4 = 0
                for k in pairs(u183) do
                    v4 = v4 + 1
                end
                local v5 = 0
                if v4 == 0 then
                    return
                end
                for i, v in ipairs(u182) do
                    if u183[v.Uid] then
                        v5 = v5 + v.Value
                        if v.Kind ~= "Eggs" then
                            table.insert(v2, v.Uid)
                        else
                            table.insert(v3, v.Uid)
                        end
                    end
                end
                v4 = #v2 + #v3
                if v4 == 0 then
                    return
                end
                if v4 ~= #u182 then
                    v5 = {}
                    v4 = {}
                    for i5, k2 in ipairs(u182) do
                        v1 = u184[k2.Uid]
                        if v1 ~= nil and u183[k2.Uid] then
                            table.insert(v4, v1)
                            table.insert(v5, v1.AbsolutePosition + v1.AbsoluteSize / 2)
                        end
                    end
                    if #v5 == 0 then
                        Icon = SellInfoHolder:FindFirstChild("Icon")
                        if not Icon then
                            Value = SellInfoHolder:FindFirstChild("Value")
                            Icon = (if not Value then nil else if not Value:IsA("TextLabel") then nil else Value) or SellInfoHolder
                        end
                        table.insert(v5, Icon.AbsolutePosition + Icon.AbsoluteSize / 2)
                    end
                    flyPayout(v5)
                    finishOpeningReveal()
                    u192.Selling = true
                    u174:Clean()
                    for i6, n in ipairs(v4) do
                        v5 = math.min((i6 - 1) * 0.02, 0.2)
                        RevealScale = n:FindFirstChild("RevealScale")
                        if not RevealScale or not RevealScale:IsA("UIScale") then
                            UIScale = Instance.new("UIScale")
                            UIScale.Name = "RevealScale"
                            UIScale.Parent = n
                            u229 = UIScale
                        else
                            local u229 = RevealScale
                        end
                        local u233 = captureFade(n)
                        local u253 = TweenService:Create(
                            u229,
                            TweenInfo.new(u59.Time, u59.EasingStyle, u59.EasingDirection, 0, false, v5),
                            {Scale = 0.6}
                        )
                        u253:Play()
                        u174:Add(function() -- Line: 1538 -- upvalues: u253 (val)
                            u253:Cancel()
                            u253:Destroy()
                        end)
                        fadeOut(u233, u59, v5, u174)
                        u174:Add(function() -- Line: 1540 -- upvalues: u229 (val), setFade (upval), u233 (val)
                            u229.Scale = 1
                            setFade(u233, 1)
                        end)
                    end
                    task.delay(0.28, function() -- Line: 1548
                        -- upvalues: u279 (val), u195 (upval), u174 (upval), u192 (upval), u135 (upval), u187 (upval)
                        -- upvalues: u186 (upval), u196 (upval), u197 (upval), u188 (upval), finishOpeningReveal (upval)
                        -- upvalues: u194 (upval), u202 (upval), refreshFooter (upval), u179 (upval)
                        -- upvalues: collectEggs (upval), collectPets (upval), u182 (upval), u180 (upval), u181 (upval)
                        -- upvalues: u184 (upval), u185 (upval), sameCardContent (upval), removeCard (upval)
                        -- upvalues: u183 (upval), u261 (upval)
                        if u279 ~= u195 then
                            return
                        end
                        u174:Clean()
                        u192.Selling = false
                        if u135.Enabled then
                            u195 = u195 + 1
                            u187 = u187 + 1
                            u186 = false
                            local u15 = u195
                            u196 = false
                            u197 = nil
                            u188 = true
                            finishOpeningReveal()
                            u194 = 0
                            u202 = 0
                            refreshFooter()
                            task.defer(function() -- Line: 1291
                                -- upvalues: u15 (val), u195 (upval), u135 (upval), u179 (upval), collectEggs (upval)
                                -- upvalues: collectPets (upval), u182 (upval), u180 (upval), u181 (upval), u184 (upval)
                                -- upvalues: u185 (upval), sameCardContent (upval), removeCard (upval), u183 (upval)
                                -- upvalues: u188 (upval), u261 (upval), refreshFooter (upval)
                                task.wait()
                                if u15 == u195 and u135.Enabled then
                                    local v1 = if u179 ~= "Eggs" then collectPets(u15) else collectEggs(u15)
                                    if v1 ~= nil and u15 == u195 and u135.Enabled then
                                        local Uid, v2, v3
                                        u182 = v1
                                        table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                                            local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                                            local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                                            if Weight == Weight_2 then
                                                return a1.Uid < a2.Uid
                                            end
                                            if u181 then
                                                return Weight_2 < Weight
                                            end
                                            return Weight < Weight_2
                                        end)
                                        v1 = {}
                                        for i, v in ipairs(u182) do
                                            Uid = v.Uid
                                            v1[Uid] = true
                                            v2 = u184[Uid]
                                            if v2 then
                                                v3 = u185[Uid]
                                                if not v3 or not sameCardContent(v3, v) then
                                                    removeCard(Uid, true)
                                                else
                                                    v2.LayoutOrder = i
                                                    u185[Uid] = v
                                                end
                                            end
                                        end
                                        for k in pairs(u184) do
                                            if not v1[k] then
                                                removeCard(k, true)
                                            end
                                        end
                                        for k2 in pairs(u183) do
                                            if not v1[k2] then
                                                u183[k2] = nil
                                            end
                                        end
                                        u188 = false
                                        u261 = true
                                        refreshFooter()
                                        return
                                    end
                                    return
                                end
                            end)
                        end
                    end)

                    function sendBatches(a1, a2) -- Line: 1561
                        -- upvalues: Remotes (upval)
                        local move, v1, v2
                        local v3 = #a1
                        local v4, v5 = a1, a2
                        for i = 1, v3, 512 do
                            v1 = {}
                            move = table.move
                            v2 = math.min(i + 511, #v4)
                            move(v4, i, v2, 1, v1)
                            Remotes.PetSatchel.SellSelection:FireServer({
                                Assets = if not v5 then v1 else {},
                                Eggs = if not v5 then {} else v1,
                            })
                        end
                    end

                    sendBatches(v2, false)
                    sendBatches(v3, true)
                    Audio.Chime("Prompt")
                    table.clear(u183)
                    refreshFooter()
                    return
                end
                u192.Confirming = true
                local Confirm = Message.Confirm
                local format = string.format
                local v6 = if not (v5 > 99999) then "$" .. Numbers.AddCommas((math.round(v5))) else "$" .. Simple.FormatCompact(math.round(v5), ".#")
                local v7 = Confirm(format(
                    "Would you like to sell <font color='#%s'>%d %s</font> for <font color='#%s'>%s</font>?",
                    u121,
                    v4,
                    if u179 ~= "Eggs" then "pets" else "eggs",
                    u129,
                    v6
                ))
                u192.Confirming = false
                if not v7 then
                    if not u186 and not u192.Selling and not u192.Confirming then
                        if not u135.Enabled then
                            return
                        end
                        u186 = true
                        u187 = u187 + 1
                        local u98 = u187
                        task.delay(0.35, function() -- Line: 1344
                            -- upvalues: u98 (val), u187 (upval), u186 (upval), u135 (upval), u192 (upval), u195 (upval)
                            -- upvalues: u196 (upval), u197 (upval), u188 (upval), finishOpeningReveal (upval)
                            -- upvalues: u194 (upval), u202 (upval), refreshFooter (upval), u179 (upval)
                            -- upvalues: collectEggs (upval), collectPets (upval), u182 (upval), u180 (upval)
                            -- upvalues: u181 (upval), u184 (upval), u185 (upval), sameCardContent (upval)
                            -- upvalues: removeCard (upval), u183 (upval), u261 (upval)
                            if u98 ~= u187 then
                                return
                            end
                            u186 = false
                            if u135.Enabled and not u192.Selling and not u192.Confirming then
                                u195 = u195 + 1
                                u187 = u187 + 1
                                u186 = false
                                local u14 = u195
                                u196 = false
                                u197 = nil
                                u188 = true
                                finishOpeningReveal()
                                u194 = 0
                                u202 = 0
                                refreshFooter()
                                task.defer(function() -- Line: 1291
                                    -- upvalues: u14 (val), u195 (upval), u135 (upval), u179 (upval)
                                    -- upvalues: collectEggs (upval), collectPets (upval), u182 (upval), u180 (upval)
                                    -- upvalues: u181 (upval), u184 (upval), u185 (upval), sameCardContent (upval)
                                    -- upvalues: removeCard (upval), u183 (upval), u188 (upval), u261 (upval)
                                    -- upvalues: refreshFooter (upval)
                                    task.wait()
                                    if u14 == u195 and u135.Enabled then
                                        local v1 = if u179 ~= "Eggs" then collectPets(u14) else collectEggs(u14)
                                        if v1 ~= nil and u14 == u195 and u135.Enabled then
                                            local Uid, v2, v3
                                            u182 = v1
                                            table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                                                local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                                                local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                                                if Weight == Weight_2 then
                                                    return a1.Uid < a2.Uid
                                                end
                                                if u181 then
                                                    return Weight_2 < Weight
                                                end
                                                return Weight < Weight_2
                                            end)
                                            v1 = {}
                                            for i, v in ipairs(u182) do
                                                Uid = v.Uid
                                                v1[Uid] = true
                                                v2 = u184[Uid]
                                                if v2 then
                                                    v3 = u185[Uid]
                                                    if not v3 or not sameCardContent(v3, v) then
                                                        removeCard(Uid, true)
                                                    else
                                                        v2.LayoutOrder = i
                                                        u185[Uid] = v
                                                    end
                                                end
                                            end
                                            for k in pairs(u184) do
                                                if not v1[k] then
                                                    removeCard(k, true)
                                                end
                                            end
                                            for k2 in pairs(u183) do
                                                if not v1[k2] then
                                                    u183[k2] = nil
                                                end
                                            end
                                            u188 = false
                                            u261 = true
                                            refreshFooter()
                                            return
                                        end
                                        return
                                    end
                                end)
                            end
                        end)
                    end
                    return
                end
                if u279 == u195 and not u188 and not u192.Selling then
                    v5 = {}
                    v4 = {}
                    for i2, i3 in ipairs(u182) do
                        v1 = u184[i3.Uid]
                        if v1 ~= nil and u183[i3.Uid] then
                            table.insert(v4, v1)
                            table.insert(v5, v1.AbsolutePosition + v1.AbsoluteSize / 2)
                        end
                    end
                    if #v5 == 0 then
                        Icon = SellInfoHolder:FindFirstChild("Icon")
                        if not Icon then
                            Value = SellInfoHolder:FindFirstChild("Value")
                            Icon = (if not Value then nil else if not Value:IsA("TextLabel") then nil else Value) or SellInfoHolder
                        end
                        table.insert(v5, Icon.AbsolutePosition + Icon.AbsoluteSize / 2)
                    end
                    flyPayout(v5)
                    finishOpeningReveal()
                    u192.Selling = true
                    u174:Clean()
                    for i4, j in ipairs(v4) do
                        v5 = math.min((i4 - 1) * 0.02, 0.2)
                        RevealScale = j:FindFirstChild("RevealScale")
                        if not RevealScale or not RevealScale:IsA("UIScale") then
                            UIScale = Instance.new("UIScale")
                            UIScale.Name = "RevealScale"
                            UIScale.Parent = j
                            u229 = UIScale
                        else
                            local u229 = RevealScale
                        end
                        local u233 = captureFade(j)
                        local u253 = TweenService:Create(
                            u229,
                            TweenInfo.new(u59.Time, u59.EasingStyle, u59.EasingDirection, 0, false, v5),
                            {Scale = 0.6}
                        )
                        u253:Play()
                        u174:Add(function() -- Line: 1538 -- upvalues: u253 (val)
                            u253:Cancel()
                            u253:Destroy()
                        end)
                        fadeOut(u233, u59, v5, u174)
                        u174:Add(function() -- Line: 1540 -- upvalues: u229 (val), setFade (upval), u233 (val)
                            u229.Scale = 1
                            setFade(u233, 1)
                        end)
                    end
                    task.delay(0.28, function() -- Line: 1548
                        -- upvalues: u279 (val), u195 (upval), u174 (upval), u192 (upval), u135 (upval), u187 (upval)
                        -- upvalues: u186 (upval), u196 (upval), u197 (upval), u188 (upval), finishOpeningReveal (upval)
                        -- upvalues: u194 (upval), u202 (upval), refreshFooter (upval), u179 (upval)
                        -- upvalues: collectEggs (upval), collectPets (upval), u182 (upval), u180 (upval), u181 (upval)
                        -- upvalues: u184 (upval), u185 (upval), sameCardContent (upval), removeCard (upval)
                        -- upvalues: u183 (upval), u261 (upval)
                        if u279 ~= u195 then
                            return
                        end
                        u174:Clean()
                        u192.Selling = false
                        if u135.Enabled then
                            u195 = u195 + 1
                            u187 = u187 + 1
                            u186 = false
                            local u15 = u195
                            u196 = false
                            u197 = nil
                            u188 = true
                            finishOpeningReveal()
                            u194 = 0
                            u202 = 0
                            refreshFooter()
                            task.defer(function() -- Line: 1291
                                -- upvalues: u15 (val), u195 (upval), u135 (upval), u179 (upval), collectEggs (upval)
                                -- upvalues: collectPets (upval), u182 (upval), u180 (upval), u181 (upval), u184 (upval)
                                -- upvalues: u185 (upval), sameCardContent (upval), removeCard (upval), u183 (upval)
                                -- upvalues: u188 (upval), u261 (upval), refreshFooter (upval)
                                task.wait()
                                if u15 == u195 and u135.Enabled then
                                    local v1 = if u179 ~= "Eggs" then collectPets(u15) else collectEggs(u15)
                                    if v1 ~= nil and u15 == u195 and u135.Enabled then
                                        local Uid, v2, v3
                                        u182 = v1
                                        table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                                            local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                                            local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                                            if Weight == Weight_2 then
                                                return a1.Uid < a2.Uid
                                            end
                                            if u181 then
                                                return Weight_2 < Weight
                                            end
                                            return Weight < Weight_2
                                        end)
                                        v1 = {}
                                        for i, v in ipairs(u182) do
                                            Uid = v.Uid
                                            v1[Uid] = true
                                            v2 = u184[Uid]
                                            if v2 then
                                                v3 = u185[Uid]
                                                if not v3 or not sameCardContent(v3, v) then
                                                    removeCard(Uid, true)
                                                else
                                                    v2.LayoutOrder = i
                                                    u185[Uid] = v
                                                end
                                            end
                                        end
                                        for k in pairs(u184) do
                                            if not v1[k] then
                                                removeCard(k, true)
                                            end
                                        end
                                        for k2 in pairs(u183) do
                                            if not v1[k2] then
                                                u183[k2] = nil
                                            end
                                        end
                                        u188 = false
                                        u261 = true
                                        refreshFooter()
                                        return
                                    end
                                    return
                                end
                            end)
                        end
                    end)

                    function sendBatches(a1, a2) -- Line: 1561
                        -- upvalues: Remotes (upval)
                        local move, v1, v2
                        local v3 = #a1
                        local v4, v5 = a1, a2
                        for i = 1, v3, 512 do
                            v1 = {}
                            move = table.move
                            v2 = math.min(i + 511, #v4)
                            move(v4, i, v2, 1, v1)
                            Remotes.PetSatchel.SellSelection:FireServer({
                                Assets = if not v5 then v1 else {},
                                Eggs = if not v5 then {} else v1,
                            })
                        end
                    end

                    sendBatches(v2, false)
                    sendBatches(v3, true)
                    Audio.Chime("Prompt")
                    table.clear(u183)
                    refreshFooter()
                    return
                end
                return
            end
        end)))
        setCategory("Eggs")
        setCategory("Pets")
        paintSortButtons()
        v1:Add((ButtonFX(SelectAll, 1.06, function() -- Line: 1604 -- upvalues: setEverySelected (val)
            setEverySelected(true)
        end)))
        v1:Add((ButtonFX(Clear, 1.06, function() -- Line: 1605 -- upvalues: setEverySelected (val)
            setEverySelected(false)
        end)))
        v1:Add(((u135:GetPropertyChangedSignal("AbsoluteSize")):Connect(applyPlatformLayout)))
        v1:Add((PlatformController.Changed:Connect(applyPlatformLayout)))
        v1:Add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 1608 -- upvalues: u261 (ref)
            u261 = true
        end)))
        v1:Add(((ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 1609 -- upvalues: u261 (ref)
            u261 = true
        end)))
        v1:Add(((ScrollingFrame:GetPropertyChangedSignal("CanvasPosition")):Connect(function() -- Line: 1610 -- upvalues: ScrollingFrame (val), finishOpeningReveal (val), u261 (ref)
            if ScrollingFrame.CanvasPosition.Y ~= 0 then
                finishOpeningReveal()
            end
            u261 = true
        end)))
        v1:Add(((UIGridLayout:GetPropertyChangedSignal("CellSize")):Connect(function() -- Line: 1617 -- upvalues: u261 (ref)
            u261 = true
        end)))
        v1:Add((RunService.Heartbeat:Connect(function() -- Line: 1174
            -- upvalues: u261 (ref), u188 (ref), u182 (ref), u192 (val), u135 (val), labelScale (val)
            -- upvalues: ScrollingFrame (val), UIGridLayout (val), u0 (val), Frame_2 (val), u196 (ref), u197 (ref)
            -- upvalues: u184 (val), removeCard (val), buildCard (val), u193 (ref), u200 (ref), u484 (ref)
            -- upvalues: RunService (upval), u195 (ref), u201 (ref), refitLabels (val), queueRefit (val), u202 (ref)
            if u261 then
                if u188 and #u182 == 0 then
                    return
                end
                if not u192.Selling and u135.Enabled then
                    local v1 = labelScale(ScrollingFrame)
                    local v2 = ScrollingFrame.AbsoluteSize / v1
                    local v3 = ScrollingFrame.AbsoluteWindowSize / v1
                    if not (v2.X <= 0) and not (v2.Y <= 0) and not (v3.Y <= 0) then
                        local LayoutOrder
                        local CellSize = UIGridLayout.CellSize
                        local CellPadding = UIGridLayout.CellPadding
                        local u159 = v2.X * CellSize.X.Scale + CellSize.X.Offset
                        local u162 = v2.Y * CellSize.Y.Scale + CellSize.Y.Offset
                        local u154 = v2.X * CellPadding.X.Scale + CellPadding.X.Offset
                        local u165 = v2.Y * CellPadding.Y.Scale + CellPadding.Y.Offset
                        local u156 = u0.Calculate(#u182, v3.X, v3.Y, u159, u162, u154, u165, ScrollingFrame.CanvasPosition.Y / v1)
                        v3 = UDim2.fromOffset(v2.X, v2.Y)
                        local u79 = Frame_2.Size ~= v3
                        Frame_2.Size = v3
                        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, u156.CanvasHeight)
                        if u196 and u197 == nil then
                            u197 = u156.VisibleLast
                        end
                        for k, v in pairs(u184) do
                            LayoutOrder = v.LayoutOrder
                            if LayoutOrder < u156.First or u156.Last < LayoutOrder then
                                removeCard(k, true)
                                u79 = true
                            end
                        end
                        u261 = false
                        local u106 = os.clock() + 0.002
                        local u107 = 0

                        local function mountRange(a1, a2, a3) -- Line: 1215
                            -- upvalues: u182 (upval), u184 (upval), u107 (ref), u106 (val), u261 (upval), u196 (upval)
                            -- upvalues: u197 (upval), buildCard (upval), u79 (ref), u159 (val), u162 (val), u156 (val)
                            -- upvalues: u154 (val), u165 (val)
                            local v1, v2, v3
                            local v4 = a3
                            for i = a1, a2 do
                                v1 = u182[i]
                                v2 = u184[v1.Uid]
                                if v2 then
                                    v1 = i - 1
                                    v2.Size = UDim2.fromOffset(u159, u162)
                                    v2.Position = UDim2.fromOffset(v1 % u156.Columns * (u159 + u154), (math.floor(v1 / u156.Columns)) * (u162 + u165))
                                elseif v4 then
                                    v3 = u196
                                    if v3 then
                                        v3 = false
                                        if i <= 24 then
                                            v3 = false
                                            if i <= (u197 or 0) then
                                                v3 = v4
                                            end
                                        end
                                    end
                                    v2 = buildCard(v1, i, v3)
                                    u107 = u107 + 1
                                    u79 = true
                                    v1 = i - 1
                                    v2.Size = UDim2.fromOffset(u159, u162)
                                    v2.Position = UDim2.fromOffset(v1 % u156.Columns * (u159 + u154), (math.floor(v1 / u156.Columns)) * (u162 + u165))
                                elseif u107 >= 4 then
                                    u261 = true
                                else
                                    v3 = os.clock()
                                    if not (u106 <= v3) then
                                        v3 = u196
                                        if v3 then
                                            v3 = false
                                            if i <= 24 then
                                                v3 = false
                                                if i <= (u197 or 0) then
                                                    v3 = v4
                                                end
                                            end
                                        end
                                        v2 = buildCard(v1, i, v3)
                                        u107 = u107 + 1
                                        u79 = true
                                        v1 = i - 1
                                        v2.Size = UDim2.fromOffset(u159, u162)
                                        v2.Position = UDim2.fromOffset(v1 % u156.Columns * (u159 + u154), (math.floor(v1 / u156.Columns)) * (u162 + u165))
                                    else
                                        u261 = true
                                    end
                                end
                            end
                        end

                        mountRange(u156.VisibleFirst, u156.VisibleLast, true)
                        mountRange(u156.First, u156.VisibleFirst - 1, false)
                        mountRange(u156.VisibleLast + 1, u156.Last, false)
                        if not u261 then
                            u196 = false
                            u193 = 0
                        end
                        if u79 then
                            u200 = u200 + 1
                            if not u484 then
                                u484 = true
                                task.defer(function() -- Line: 889
                                    -- upvalues: RunService (upval), u195 (upval), u200 (upval), u201 (upval)
                                    -- upvalues: refitLabels (upval), u484 (upval), u135 (upval), queueRefit (upval)
                                    -- upvalues: u202 (upval)
                                    RunService.PreRender:Wait()
                                    local u5 = u195
                                    local v1 = u200
                                    u201 = false
                                    refitLabels(u5)
                                    u484 = false
                                    if u5 == u195 and u135.Enabled then
                                        if v1 ~= u200 then
                                            queueRefit()
                                        end
                                        if u201 and u202 < 5 then
                                            u202 = u202 + 1
                                            task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                                                if u5 == u195 and u135.Enabled then
                                                    queueRefit()
                                                end
                                            end)
                                        end
                                        return
                                    end
                                end)
                            end
                        end
                        return
                    end
                    return
                end
            end
        end)))
        v1:Add(u171)
        v1:Add(u174)
        v1:Add(function() -- Line: 1621 -- upvalues: u195 (ref), u187 (ref), u261 (ref), clearCards (val)
            u195 = u195 + 1
            u187 = u187 + 1
            u261 = false
            clearCards()
        end)
        local v2 = isPhone()
        Frame.Size = if not v2 then Size else u35
        UIGridLayout.CellSize = if not v2 then CellSize else u39
        u200 = u200 + 1
        if not u484 then
            u484 = true
            task.defer(function() -- Line: 889
                -- upvalues: RunService (upval), u195 (ref), u200 (ref), u201 (ref), refitLabels (val), u484 (ref)
                -- upvalues: u135 (val), queueRefit (val), u202 (ref)
                RunService.PreRender:Wait()
                local u5 = u195
                local v1 = u200
                u201 = false
                refitLabels(u5)
                u484 = false
                if u5 == u195 and u135.Enabled then
                    if v1 ~= u200 then
                        queueRefit()
                    end
                    if u201 and u202 < 5 then
                        u202 = u202 + 1
                        task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                            if u5 == u195 and u135.Enabled then
                                queueRefit()
                            end
                        end)
                    end
                    return
                end
            end)
        end
        if Backdrop then
            v1:Add((Backdrop.Activated:Connect(function() -- Line: 1630 -- upvalues: Tabs (upval)
                Tabs.Deactivate()
            end)))
        end
        v1:Add((Tabs.Activated:Connect(function(a1) -- Line: 1633
            -- upvalues: Backdrop (val), u192 (val), u200 (ref), u484 (ref), RunService (upval), u195 (ref), u201 (ref)
            -- upvalues: refitLabels (val), u135 (val), queueRefit (val), u202 (ref), u183 (val), u190 (ref), u191 (ref)
            -- upvalues: u189 (ref), SellInfoHolder (val), Numbers (upval), u171 (val), fadeIn (val), captureFade (val)
            -- upvalues: Frame (val), ScrollingFrame (val), u26 (val), u193 (ref), rebuild (val)
            local v1
            if a1 ~= "SellPrompt" then
                return
            end
            if Backdrop ~= nil then
                v1 = Backdrop
                v1.BackgroundTransparency = 1
                v1.Visible = true
            end
            if u192.Confirming then
                u200 = u200 + 1
                if u484 then
                    return
                end
                u484 = true
                task.defer(function() -- Line: 889
                    -- upvalues: RunService (upval), u195 (upval), u200 (upval), u201 (upval), refitLabels (upval)
                    -- upvalues: u484 (upval), u135 (upval), queueRefit (upval), u202 (upval)
                    RunService.PreRender:Wait()
                    local u5 = u195
                    local v1 = u200
                    u201 = false
                    refitLabels(u5)
                    u484 = false
                    if u5 == u195 and u135.Enabled then
                        if v1 ~= u200 then
                            queueRefit()
                        end
                        if u201 and u202 < 5 then
                            u202 = u202 + 1
                            task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                                if u5 == u195 and u135.Enabled then
                                    queueRefit()
                                end
                            end)
                        end
                        return
                    end
                end)
                return
            end
            table.clear(u183)
            u192.Selling = false
            if u190 then
                u190:Cancel()
                u190 = nil
            end
            if u191 then
                u191:Destroy()
                u191 = nil
            end
            u189 = 0
            local Value = SellInfoHolder:FindFirstChild("Value")
            v1 = if not Value then nil else if not Value:IsA("TextLabel") then nil else Value
            if v1 then
                v1.Text = "$" .. Numbers.AddCommas(0)
            end
            u200 = u200 + 1
            if not u484 then
                u484 = true
                task.defer(function() -- Line: 889
                    -- upvalues: RunService (upval), u195 (upval), u200 (upval), u201 (upval), refitLabels (upval)
                    -- upvalues: u484 (upval), u135 (upval), queueRefit (upval), u202 (upval)
                    RunService.PreRender:Wait()
                    local u5 = u195
                    local v1 = u200
                    u201 = false
                    refitLabels(u5)
                    u484 = false
                    if u5 == u195 and u135.Enabled then
                        if v1 ~= u200 then
                            queueRefit()
                        end
                        if u201 and u202 < 5 then
                            u202 = u202 + 1
                            task.delay(0.4, function() -- Line: 904 -- upvalues: u5 (val), u195 (upval), u135 (upval), queueRefit (upval)
                                if u5 == u195 and u135.Enabled then
                                    queueRefit()
                                end
                            end)
                        end
                        return
                    end
                end)
            end
            u171:Clean()
            fadeIn(captureFade(Frame, {ScrollingFrame}), u26, nil, u171)
            u193 = 0.08
            rebuild(true)
        end)))
        v1:Add((Tabs.Deactivated:Connect(function(a1, a2) -- Line: 1652
            -- upvalues: Backdrop (val), u192 (val), finishOpeningReveal (val), u195 (ref), u187 (ref), u186 (ref)
            -- upvalues: u188 (ref), u261 (ref), u171 (val), u174 (val), clearCards (val), u198 (val)
            if a1 == "SellPrompt" then
                if Backdrop ~= nil then
                    local v1 = Backdrop
                    v1.BackgroundTransparency = 1
                    v1.Visible = false
                end
                if u192.Confirming and a2.replacedBy == "Message" then
                    finishOpeningReveal()
                    return
                end
                u195 = u195 + 1
                u187 = u187 + 1
                u186 = false
                u188 = false
                u192.Selling = false
                u261 = false
                u171:Clean()
                u174:Clean()
                clearCards()
                table.clear(u198)
            end
        end)))
        v1:Add((Save.WatchFields({"Inventory", "EggInventory", "EquippedAssets"}, function() -- Line: 1337
            -- upvalues: u186 (ref), u192 (val), u135 (val), u187 (ref), u195 (ref), u196 (ref), u197 (ref), u188 (ref)
            -- upvalues: finishOpeningReveal (val), u194 (ref), u202 (ref), refreshFooter (val), u179 (ref)
            -- upvalues: collectEggs (val), collectPets (val), u182 (ref), u180 (ref), u181 (ref), u184 (val)
            -- upvalues: u185 (val), sameCardContent (val), removeCard (val), u183 (val), u261 (ref)
            if not u186 and not u192.Selling and not u192.Confirming and u135.Enabled then
                u186 = true
                u187 = u187 + 1
                local u10 = u187
                task.delay(0.35, function() -- Line: 1344
                    -- upvalues: u10 (val), u187 (upval), u186 (upval), u135 (upval), u192 (upval), u195 (upval)
                    -- upvalues: u196 (upval), u197 (upval), u188 (upval), finishOpeningReveal (upval), u194 (upval)
                    -- upvalues: u202 (upval), refreshFooter (upval), u179 (upval), collectEggs (upval)
                    -- upvalues: collectPets (upval), u182 (upval), u180 (upval), u181 (upval), u184 (upval)
                    -- upvalues: u185 (upval), sameCardContent (upval), removeCard (upval), u183 (upval), u261 (upval)
                    if u10 ~= u187 then
                        return
                    end
                    u186 = false
                    if u135.Enabled and not u192.Selling and not u192.Confirming then
                        u195 = u195 + 1
                        u187 = u187 + 1
                        u186 = false
                        local u14 = u195
                        u196 = false
                        u197 = nil
                        u188 = true
                        finishOpeningReveal()
                        u194 = 0
                        u202 = 0
                        refreshFooter()
                        task.defer(function() -- Line: 1291
                            -- upvalues: u14 (val), u195 (upval), u135 (upval), u179 (upval), collectEggs (upval)
                            -- upvalues: collectPets (upval), u182 (upval), u180 (upval), u181 (upval), u184 (upval)
                            -- upvalues: u185 (upval), sameCardContent (upval), removeCard (upval), u183 (upval)
                            -- upvalues: u188 (upval), u261 (upval), refreshFooter (upval)
                            task.wait()
                            if u14 == u195 and u135.Enabled then
                                local v1 = if u179 ~= "Eggs" then collectPets(u14) else collectEggs(u14)
                                if v1 ~= nil and u14 == u195 and u135.Enabled then
                                    local Uid, v2, v3
                                    u182 = v1
                                    table.sort(u182, function(a1, a2) -- Line: 572 -- upvalues: u180 (upval), u181 (upval)
                                        local Weight = if u180 ~= "Weight" then a1.Value else a1.Weight
                                        local Weight_2 = if u180 ~= "Weight" then a2.Value else a2.Weight
                                        if Weight == Weight_2 then
                                            return a1.Uid < a2.Uid
                                        end
                                        if u181 then
                                            return Weight_2 < Weight
                                        end
                                        return Weight < Weight_2
                                    end)
                                    v1 = {}
                                    for i, v in ipairs(u182) do
                                        Uid = v.Uid
                                        v1[Uid] = true
                                        v2 = u184[Uid]
                                        if v2 then
                                            v3 = u185[Uid]
                                            if not v3 or not sameCardContent(v3, v) then
                                                removeCard(Uid, true)
                                            else
                                                v2.LayoutOrder = i
                                                u185[Uid] = v
                                            end
                                        end
                                    end
                                    for k in pairs(u184) do
                                        if not v1[k] then
                                            removeCard(k, true)
                                        end
                                    end
                                    for k2 in pairs(u183) do
                                        if not v1[k2] then
                                            u183[k2] = nil
                                        end
                                    end
                                    u188 = false
                                    u261 = true
                                    refreshFooter()
                                    return
                                end
                                return
                            end
                        end)
                    end
                end)
                return
            end
        end)))
        v1:Add((Timer.Simple(0.1, function() -- Line: 1578 -- upvalues: ToolGameplayGuard (upval), Tabs (upval)
            if ToolGameplayGuard.IsLocalInsideArena() and Tabs.IsActive("SellPrompt") then
                Tabs.Deactivate()
            end
        end, true)))
        v1:AttachToInstance(script)
        if ToolGameplayGuard.IsLocalInsideArena() and Tabs.IsActive("SellPrompt") then
            Tabs.Deactivate()
        end
    end,
}