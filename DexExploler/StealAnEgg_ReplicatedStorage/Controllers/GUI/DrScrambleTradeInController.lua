-- Script path: ReplicatedStorage.Controllers.GUI.DrScrambleTradeInController
-- Decompile time: 67.62 ms

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Areas = require(ReplicatedStorage.Data.Areas)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ScrambleTradeIn = require(ReplicatedStorage.Data.ScrambleTradeIn)
local ScrambleTradeInRecipes = require(ReplicatedStorage.Shared.Modules.ScrambleTradeInRecipes)
local ScrambleLeaveTimer = require(ReplicatedStorage.Shared.Util.ScrambleLeaveTimer)
local DrScrambleSequence = require(script.Parent.DrScrambleSequence)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u110 = {"LeftBar", "MiddleBar", "RightBar"}
local u118 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u123 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u128 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u133 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u138 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u143 = Color3.fromRGB(255, 64, 64)
local u148 = Color3.fromRGB(164, 255, 61)
local u153 = Color3.fromRGB(166, 255, 228)
local u158 = Color3.new(0.25, 0.25, 0.3)
local u162 = UDim2.fromScale(0.012, 0.14)
local u166 = UDim2.fromScale(0.1, 0.55)
local u173 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local u178 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u179 = {"Purple", "Red", "Yellow"}
local u187 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u190 = utf8.char(57346)
local u191 = {}
u191.Verdant = Color3.fromRGB(126, 217, 130)
u191.Umbral = Color3.fromRGB(168, 122, 255)
u191.Radiant = Color3.fromRGB(255, 205, 84)
return {
    Start = function() -- Line: 79
        -- upvalues: GUI (val), Trove (val), u110 (val), TweenService (val), u118 (val), u123 (val), u128 (val)
        -- upvalues: u133 (val), u153 (val), Hud (val), u162 (val), u166 (val), EnsureUIScale (val), u173 (val)
        -- upvalues: ScrambleTradeIn (val), u187 (val), Assets (val), ScrambleTradeInRecipes (val), Areas (val)
        -- upvalues: u191 (val), u158 (val), ScrambleLeaveTimer (val), u179 (val), u178 (val), AssetEarnings (val)
        -- upvalues: Simple (val), HoverCard (val), u138 (val), u190 (val), Remotes (val), Save (val), EggRecords (val)
        -- upvalues: Toast (val), u143 (val), ButtonFX (val), Tabs (val), DrScrambleSequence (val), u148 (val)
        -- upvalues: Storefront (val), Products (val), MarketplaceService (val)
        local v1, v2, v3, v4, v5, v6, v7
        local u1298 = GUI.DrScrambleTradeIn()
        local DrScrambleTradeInMain = u1298:WaitForChild("DrScrambleTradeInMain")
        local DrScrambleTradeInInventory = u1298:WaitForChild("DrScrambleTradeInInventory")
        local CurrentEggInfoHolder = DrScrambleTradeInMain:WaitForChild("CurrentEggInfoHolder")
        local EggIcon = CurrentEggInfoHolder:WaitForChild("EggIcon")
        local EggName = CurrentEggInfoHolder:WaitForChild("EggName")
        local RotateTimer = CurrentEggInfoHolder:WaitForChild("RotateTimer")
        local LeaveTimer = (DrScrambleTradeInMain:WaitForChild("Header")):FindFirstChild("LeaveTimer")
        local ScrollingFrame = CurrentEggInfoHolder:WaitForChild("ScrollingFrame")
        local u1310 = DrScrambleTradeInMain:WaitForChild("EggChancesHolder")
        local RewardHolder = u1310:WaitForChild("RewardHolder")
        local Title = u1310:WaitForChild("Title")
        local PityHolder = u1310:FindFirstChild("PityHolder")
        if not PityHolder then
            PityHolder = DrScrambleTradeInMain:WaitForChild("PityHolder")
        end
        local PityLabel = PityHolder:WaitForChild("PityLabel")
        local ProgressBar = PityHolder:WaitForChild("ProgressBar")
        local Icon = PityHolder:WaitForChild("Icon")
        local SacrificeInputs = DrScrambleTradeInMain:WaitForChild("SacrificeInputs")
        local Sacrifice = DrScrambleTradeInMain:WaitForChild("Sacrifice")
        local Price = Sacrifice:WaitForChild("Price")
        local DesignBars = DrScrambleTradeInMain:WaitForChild("DesignBars")
        local Output = (DrScrambleTradeInMain:WaitForChild("SacrificeOutput")):WaitForChild("Output")
        local Fill = Output:WaitForChild("Fill")
        local OutputEgg = Output:WaitForChild("OutputEgg")
        local u1374 = DrScrambleTradeInInventory:WaitForChild("ScrollingFrame")
        local Close = DrScrambleTradeInInventory:WaitForChild("Close")
        local u1390 = Trove.new()
        local u1394 = Trove.new()
        u1390:Add(u1394)
        local u1398 = Trove.new()
        u1390:Add(u1398)
        local u1402 = nil
        local u1406 = {}
        local u1410 = false
        local u1414 = nil
        local u1418 = nil
        local u1422 = nil
        local v8 = nil
        for i, j in u1374:GetChildren() do
            if j.Name == "Pet" and j:IsA("ImageButton") then
                if not v8 then
                    v8 = j
                else
                    j:Destroy()
                end
            end
        end
        assert(v8, "DrScrambleTradeInInventory has no Pet template")
        local u1424 = v8
        u1424.Visible = false
        u1424.BackgroundColor3 = Color3.fromRGB(30, 49, 22)
        u1424.BackgroundTransparency = 0.1
        local UIStroke = u1424:FindFirstChildOfClass("UIStroke")
        if UIStroke then
            UIStroke.Enabled = false
        end
        u1424.BorderColor3 = Color3.fromRGB(137, 207, 73)
        u1424.BorderSizePixel = 2
        local PetDecal = u1424:FindFirstChild("PetDecal")
        if PetDecal and PetDecal:IsA("ImageLabel") then
            PetDecal.BackgroundTransparency = 1
            PetDecal.ScaleType = Enum.ScaleType.Fit
        end
        local u1287 = {}
        local u1290 = {}
        local u1292 = {}
        local u1425 = {}
        local v9 = nil
        local v10 = nil
        for k, n in u110, v9, v10 do
            v1 = DesignBars:FindFirstChild(n)
            v2 = v1 and v1:FindFirstChild("Fill")
            if v2 and v2:IsA("ImageLabel") then
                u1287[k] = v2
                u1290[k] = v2.ImageTransparency
                u1292[k] = false
                v2.ImageTransparency = 1
                v2.Visible = false
            end
        end
        local Size = Fill.Size
        local Position = Fill.Position
        local Y = Fill.AnchorPoint.Y
        local u213 = Position.Y.Scale + (1 - Y) * Size.Y.Scale
        local u220 = Position.Y.Offset + (1 - Y) * Size.Y.Offset
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "LaboratoryProgressScale"
        UIScale.Parent = OutputEgg
        OutputEgg.ZIndex = Fill.ZIndex + 1
        local u228 = nil
        local u229 = nil
        local u1111 = false

        local function setBarFilled(a1, a2, a3) -- Line: 195
            -- upvalues: u1287 (val), u1292 (val), u1425 (val), u1290 (val), TweenService (upval), u118 (upval)
            local u4 = u1287[a1]
            if u4 ~= nil and u1292[a1] ~= a2 then
                u1292[a1] = a2
                local v1 = u1425[a1]
                if v1 then
                    v1:Cancel()
                    u1425[a1] = nil
                end
                v1 = if not a2 then 1 else u1290[a1]
                if not a3 then
                    u4.ImageTransparency = v1
                    u4.Visible = a2
                    return
                end
                if a2 and not u4.Visible then
                    u4.ImageTransparency = 1
                end
                u4.Visible = true
                local v2 = TweenService:Create(u4, u118, {ImageTransparency = v1})
                u1425[a1] = v2
                v2.Completed:Connect(function(a1_2) -- Line: 218 -- upvalues: u4 (val), u1292 (upval), a1 (val)
                    if a1_2 == Enum.PlaybackState.Completed then
                        u4.Visible = u1292[a1]
                    end
                end)
                v2:Play()
                return
            end
        end

        local function setOutputProgress(a1, a2) -- Line: 226
            -- upvalues: Size (val), Position (val), u213 (val), Y (val), u220 (val), TweenService (upval), Fill (val)
            -- upvalues: u123 (upval), u228 (ref), u229 (ref), OutputEgg (val), UIScale (val), u128 (upval)
            -- upvalues: u133 (upval)
            local v1 = a1 / 3
            local v2 = UDim2.new(Size.X.Scale, Size.X.Offset, v1, 0)
            local v3 = UDim2.new(Position.X.Scale, Position.X.Offset, u213 - (1 - Y) * v1, u220)
            if not a2 then
                Fill.Size = v2
                Fill.Position = v3
            else
                TweenService:Create(Fill, u123, {Size = v2, Position = v3}):Play()
            end
            v3 = a1 >= 3
            v2 = u228
            u228 = v3
            if u229 then
                u229:Cancel()
                u229 = nil
            end
            if not v3 then
                OutputEgg.ImageTransparency = 0.1
                OutputEgg.ImageColor3 = Color3.new(0, 0, 0)
                UIScale.Scale = 1
                return
            end
            OutputEgg.ImageTransparency = 0
            OutputEgg.ImageColor3 = Color3.new(1, 1, 1)
            if a2 and v2 ~= true then
                UIScale.Scale = 0.8
                v1 = TweenService:Create(UIScale, u128, {Scale = 1.2})
                u229 = v1
                v1.Completed:Connect(function(a1) -- Line: 256 -- upvalues: u228 (upval), TweenService (upval), UIScale (upval), u133 (upval), u229 (upval)
                    if a1 == Enum.PlaybackState.Completed and u228 == true then
                        local v1 = TweenService:Create(UIScale, u133, {Scale = 1})
                        u229 = v1
                        v1:Play()
                    end
                end)
                v1:Play()
                return
            end
            UIScale.Scale = 1
        end

        local u760 = {}
        for m, i5 in ScrollingFrame:GetChildren() do
            if i5.Name == "Template" and i5:IsA("Frame") then
                table.insert(u760, i5)
            end
        end
        local u352 = {}
        local v11 = nil
        local v12 = nil
        for i6, i7 in u760, v11, v12 do
            v3 = Instance.new("Frame")
            v3.Name = "SelectFill"
            v3.BackgroundColor3 = u153
            v3.BackgroundTransparency = 1
            v3.BorderSizePixel = 0
            v3.Size = UDim2.fromScale(1, 1)
            v3.ZIndex = 0
            v4 = i7:FindFirstChildOfClass("UICorner")
            if v4 then
                v4:Clone().Parent = v3
            end
            v3.Parent = i7
            u1390:Add(v3)
            u352[i6] = v3
        end
        local u263 = {}
        local u337 = {}
        v12 = Hud.Every("IndexNotificationBadge")[1]
        if v12 ~= nil and v12:IsA("GuiObject") then
            local v13
            ScrollingFrame.ClipsDescendants = false
            local v14 = nil
            v3 = nil
            for i8, i9 in u760, v14, v3 do
                v13 = v12:Clone()
                v13.Name = "NowBadge"
                for i10, i11 in v13:GetDescendants() do
                    if i11:IsA("TextLabel") then
                        i11.Text = "!"
                    end
                end
                v13.AnchorPoint = Vector2.new(0.5, 0.5)
                v13.Position = u162
                v13.Size = u166
                v13.ZIndex = 25
                v13.Visible = false
                v13.Parent = i9
                u1390:Add(v13)
                u263[i8] = v13
            end
        end

        local function setNowBadge(a1, a2) -- Line: 325
            -- upvalues: u263 (val), u337 (val), EnsureUIScale (upval), TweenService (upval), u173 (upval)
            local v1
            local v2 = u263[a1]
            if v2 == nil then
                return
            end
            v2.Visible = a2
            local v3 = u337[a1]
            if not a2 then
                if v3 ~= nil then
                    v3:Cancel()
                    v3:Destroy()
                    u337[a1] = nil
                    v1 = EnsureUIScale(v2)
                    v1.Scale = 1
                end
                return
            end
            if v3 ~= nil then
                return
            end
            v1 = EnsureUIScale(v2)
            v1.Scale = 0.8
            v3 = TweenService:Create(v1, u173, {Scale = 1.2})
            u337[a1] = v3
            v3:Play()
        end

        function v12() -- Line: 348 -- upvalues: u1402 (ref), ScrambleTradeIn (upval)
            if u1402 and u1402.BannerId then
                return u1402.BannerId
            end
            return (ScrambleTradeIn.CurrentBannerId())
        end

        local function v15() -- Line: 352 -- upvalues: u1418 (ref), ScrambleTradeIn (upval), u1402 (ref)
            local v1 = u1418
            if v1 ~= nil then
                for i, j in ScrambleTradeIn.BannerIds() do
                    if j == v1 then
                        return v1
                    end
                end
                u1418 = nil
            end
            if u1402 and u1402.BannerId then
                return u1402.BannerId
            end
            return (ScrambleTradeIn.CurrentBannerId())
        end

        local function paintRow(a1, a2, a3) -- Line: 367
            -- upvalues: u352 (val), u1422 (ref), TweenService (upval), u187 (upval)
            local v1 = u352[a1]
            if v1 == nil then
                return
            end
            local v2 = if a2 then 1 else if u1422 ~= a1 then 1 else 0.9
            TweenService:Create(v1, u187, {BackgroundTransparency = v2}):Play()
        end

        function v3(a1) -- Line: 376 -- upvalues: Assets (upval) -- types: a1: string
            return Assets.Directory[a1]
        end

        local function pct(a1, a2) -- Line: 380 -- types: a1: number, a2: number
            if a2 <= 0 then
                return "?"
            end
            local v1 = a1 / a2 * 100
            if v1 >= 1 then
                return string.format("%.0f%%", v1)
            end
            if v1 >= 0.05 then
                return string.format("%.1f%%", v1)
            end
            return string.format("%.3f%%", v1)
        end

        local function petTitles(a1) -- Line: 393 -- types: a1: userdata
            local v1 = {}
            for i, j in a1:GetChildren() do
                if j:IsA("TextLabel") and j.Name == "Title" then
                    table.insert(v1, j)
                end
            end
            table.sort(v1, function(a1, a2) -- Line: 400
                return a1.Position.Y.Scale < a2.Position.Y.Scale
            end)
            return v1[1], v1[2]
        end

        local function foundInText(a1) -- Line: 409
            -- upvalues: ScrambleTradeInRecipes (upval), Areas (upval)
            local v1
            local v2 = if a1 == nil then nil else select(2, ScrambleTradeInRecipes.SpawnChanceOf(a1))
            if (if v2 == nil then nil else Areas.Directory[v2]) == nil then
                return "Found In [???]"
            end
            return (("Found In <font color=\"#%*\">[%*]</font>"):format(v1.Color:ToHex(), v1.DisplayName))
        end

        local function v16() -- Line: 418 -- upvalues: u1406 (val)
            local v1 = 0
            if u1406[1] then
                v1 = v1 + 1
            end
            if u1406[2] then
                v1 = v1 + 1
            end
            if u1406[3] then
                v1 = v1 + 1
            end
            return v1
        end

        local function renderBannerPanel() -- Line: 428
            -- upvalues: u1402 (ref), ScrambleTradeIn (upval), u1418 (ref), u191 (upval), EggName (val), EggIcon (val)
            -- upvalues: u760 (val), u158 (upval), pct (val), paintRow (val), setNowBadge (val)
            local BannerId_2, ChanceLabel, EggName_2, ImageLabel, v1, v2, v3, v4, v5, v6, v7, v8, v9
            local BannerId = if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId
            local v10 = u1418
            if v10 ~= nil then
                for i, j in ScrambleTradeIn.BannerIds() do
                    if j == v10 then
                        BannerId_2 = v10
                        v10 = ScrambleTradeIn.GetBannerEggIcon(BannerId)
                        v6 = v10 == nil and u191[BannerId] or Color3.new(1, 1, 1)
                        EggName.Text = ("%* Banner"):format((ScrambleTradeIn.GetBannerDisplayName(BannerId)))
                        if v10 ~= nil then
                            EggIcon.Image = v10
                        end
                        EggIcon.ImageColor3 = v6
                        v6 = ScrambleTradeIn.BannerIds()
                        v10 = 0
                        for k, n in v6 do
                            v10 = v10 + ScrambleTradeIn.GetBannerWeight(n)
                        end
                        v7 = nil
                        v8 = nil
                        for m, i5 in u760, v7, v8 do
                            v9 = v6[m]
                            if v9 ~= nil then
                                i5.Visible = true
                                ImageLabel = i5:FindFirstChild("ImageLabel")
                                ChanceLabel = i5:FindFirstChild("ChanceLabel")
                                EggName_2 = i5:FindFirstChild("EggName")
                                v1 = v9 == BannerId_2
                                v2 = v9 == BannerId
                                v3 = if not v1 then if not v2 then 0.55 else 0.2 else 0
                                v4 = if not v1 then if not v2 then 0.35 else 0.12 else 0
                                if ImageLabel then
                                    v5 = ScrambleTradeIn.GetBannerEggIcon(v9)
                                    if v5 ~= nil then
                                        ImageLabel.Image = v5
                                    end
                                    ImageLabel.ImageColor3 = (v5 == nil and u191[v9] or Color3.new(1, 1, 1)):Lerp(u158, v3)
                                end
                                if ChanceLabel then
                                    ChanceLabel.Text = pct(ScrambleTradeIn.GetBannerWeight(v9), v10)
                                    ChanceLabel.TextTransparency = v4
                                end
                                if EggName_2 then
                                    v3 = ScrambleTradeIn.GetBannerDisplayName(v9)
                                    EggName_2.Text = if not v2 then v3 else ("%* (Now)"):format(v3)
                                    EggName_2.TextTransparency = v4
                                end
                                paintRow(m, v1, v2)
                                setNowBadge(m, v2)
                            else
                                i5.Visible = false
                            end
                        end
                        return
                    end
                end
                u1418 = nil
            end
            BannerId_2 = if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId
            v10 = ScrambleTradeIn.GetBannerEggIcon(BannerId)
            v6 = v10 == nil and u191[BannerId] or Color3.new(1, 1, 1)
            EggName.Text = ("%* Banner"):format((ScrambleTradeIn.GetBannerDisplayName(BannerId)))
            if v10 ~= nil then
                EggIcon.Image = v10
            end
            EggIcon.ImageColor3 = v6
            v6 = ScrambleTradeIn.BannerIds()
            v10 = 0
            for i6, i7 in v6 do
                v10 = v10 + ScrambleTradeIn.GetBannerWeight(i7)
            end
            v7 = nil
            v8 = nil
            for i8, i9 in u760, v7, v8 do
                v9 = v6[i8]
                if v9 ~= nil then
                    i9.Visible = true
                    ImageLabel = i9:FindFirstChild("ImageLabel")
                    ChanceLabel = i9:FindFirstChild("ChanceLabel")
                    EggName_2 = i9:FindFirstChild("EggName")
                    v1 = v9 == BannerId_2
                    v2 = v9 == BannerId
                    v3 = if not v1 then if not v2 then 0.55 else 0.2 else 0
                    v4 = if not v1 then if not v2 then 0.35 else 0.12 else 0
                    if ImageLabel then
                        v5 = ScrambleTradeIn.GetBannerEggIcon(v9)
                        if v5 ~= nil then
                            ImageLabel.Image = v5
                        end
                        ImageLabel.ImageColor3 = (v5 == nil and u191[v9] or Color3.new(1, 1, 1)):Lerp(u158, v3)
                    end
                    if ChanceLabel then
                        ChanceLabel.Text = pct(ScrambleTradeIn.GetBannerWeight(v9), v10)
                        ChanceLabel.TextTransparency = v4
                    end
                    if EggName_2 then
                        v3 = ScrambleTradeIn.GetBannerDisplayName(v9)
                        EggName_2.Text = if not v2 then v3 else ("%* (Now)"):format(v3)
                        EggName_2.TextTransparency = v4
                    end
                    paintRow(i8, v1, v2)
                    setNowBadge(i8, v2)
                else
                    i9.Visible = false
                end
            end
        end

        local function renderTimer() -- Line: 484
            -- upvalues: ScrambleTradeIn (upval), RotateTimer (val), LeaveTimer (val), ScrambleLeaveTimer (upval)
            local v1 = math.max(math.floor((ScrambleTradeIn.SecondsUntilRotation())), 0)
            RotateTimer.RichText = true
            RotateTimer.Text = ("Rotates in: <font color=\"#FFBB10\">%*</font>"):format(if not (v1 >= 3600) then if not (v1 >= 60) then string.format("%ds", v1) else string.format("%dm %02ds", v1 // 60, v1 % 60) else string.format("%dh %02dm", v1 // 3600, v1 % 3600 // 60))
            if LeaveTimer then
                local v2 = ScrambleLeaveTimer.SecondsLeft()
                LeaveTimer.Visible = v2 > 0
                LeaveTimer.Text = ScrambleLeaveTimer.Text(v2)
            end
        end

        local ImageLabel = u1310:FindFirstChildWhichIsA("ImageLabel")
        local u1131 = nil
        local u1005 = nil
        local u998 = nil
        for i12, i13 in u1310:GetChildren() do
            if not i13:IsA("Frame") then
                if i13:IsA("UIStroke") then
                    v5 = i13:FindFirstChildOfClass("UIGradient")
                    if v5 ~= nil then
                        u998 = v5
                    elseif i13.Color ~= Color3.new(0, 0, 0) then
                        u1005 = i13
                    end
                end
            elseif i13.Name == "Frame" then
                u1131 = i13
            elseif i13:IsA("UIStroke") then
                v5 = i13:FindFirstChildOfClass("UIGradient")
                if v5 ~= nil then
                    u998 = v5
                elseif i13.Color ~= Color3.new(0, 0, 0) then
                    u1005 = i13
                end
            end
        end

        local function themeForRow(a1) -- Line: 524 -- upvalues: u760 (val) -- types: a1: number
            local v1 = u760[a1]
            if v1 == nil then
                return nil
            end
            local BackgroundColor3 = v1.BackgroundColor3
            local CanvasGroup = v1:FindFirstChildOfClass("CanvasGroup")
            if CanvasGroup ~= nil then
                for i, j in CanvasGroup:GetChildren() do
                    if j:IsA("UIStroke") and j.Color ~= Color3.new(0, 0, 0) then
                        BackgroundColor3 = j.Color
                        break
                    end
                end
            end
            return {Base = v1.BackgroundColor3, Accent = BackgroundColor3}
        end

        local function chancesArtNameFor(a1) -- Line: 542
            -- upvalues: ScrambleTradeIn (upval), u179 (upval)
            local v1 = table.clone(ScrambleTradeIn.BannerIds())
            table.sort(v1, function(a1, a2) -- Line: 544 -- upvalues: ScrambleTradeIn (upval)
                local v1 = ScrambleTradeIn.GetBannerWeight(a1)
                local v2 = ScrambleTradeIn.GetBannerWeight(a2)
                if v1 == v2 then
                    return a1 < a2
                end
                return v2 < v1
            end)
            local v2 = table.find(v1, a1) or #v1
            return u179[math.min(v2, #u179)]
        end

        local function applyChancesTheme(a1) -- Line: 555
            -- upvalues: ScrambleTradeIn (upval), themeForRow (val), TweenService (upval), u1310 (val), u178 (upval)
            -- upvalues: ImageLabel (val), chancesArtNameFor (val), RewardHolder (val), u1131 (ref), PityHolder (val)
            -- upvalues: u1005 (ref), Title (val), u998 (ref)
            local v1
            local v2 = table.find(ScrambleTradeIn.BannerIds(), a1)
            if (if v2 == nil then nil else themeForRow(v2)) == nil then
                return
            end
            v2 = Color3.new(0, 0, 0)
            local v3 = Color3.new(1, 1, 1)
            local v4 = v1.Base:Lerp(v2, 0.8)
            TweenService:Create(u1310, u178, {BackgroundColor3 = v4}):Play()
            if ImageLabel ~= nil then
                local Attribute = ImageLabel:GetAttribute((chancesArtNameFor(a1)))
                if typeof(Attribute) == "string" and Attribute ~= "" then
                    ImageLabel.Image = Attribute
                end
            end
            local v5 = v1.Base:Lerp(v2, 0.72)
            for i, j in RewardHolder:GetChildren() do
                if j:IsA("Frame") then
                    TweenService:Create(j, u178, {BackgroundColor3 = v5}):Play()
                end
            end
            if u1131 ~= nil then
                TweenService:Create(u1131, u178, {BackgroundColor3 = v1.Base:Lerp(v2, 0.88)}):Play()
            end
            TweenService:Create(PityHolder, u178, {BackgroundColor3 = v1.Base:Lerp(v2, 0.68)}):Play()
            if u1005 ~= nil then
                TweenService:Create(u1005, u178, {Color = v1.Accent:Lerp(v2, 0.35)}):Play()
            end
            TweenService:Create(Title, u178, {TextColor3 = v1.Accent:Lerp(v3, 0.45)}):Play()
            if u998 ~= nil then
                u998.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, v3),
                    ColorSequenceKeypoint.new(0.38, v1.Accent),
                    ColorSequenceKeypoint.new(0.54, v1.Accent:Lerp(v3, 0.75)),
                    ColorSequenceKeypoint.new(0.75, v1.Accent:Lerp(v3, 0.3)),
                    (ColorSequenceKeypoint.new(1, v1.Accent:Lerp(v2, 0.4))),
                })
            end
        end

        local function ratePerSecondFor(a1) -- Line: 596
            -- upvalues: AssetEarnings (upval), Assets (upval)
            local success, err = pcall(AssetEarnings.CatalogRatePerSecond, {
                Scale = 1,
                HasBeenFirstPlaced = true,
                Category = a1,
                Mutations = {},
                Personality = Assets.Personalities.Personalities.Normal,
            })
            if success and typeof(err) == "number" then
                return (math.round(err))
            end
            local v1 = Assets.Directory[a1]
            if v1 then
                return v1.EarningRate or 0
            end
            return 0
        end

        local function v17(a1) -- Line: 612 -- upvalues: ScrambleTradeIn (upval) -- types: a1: string
            return (("-- %* Chances --"):format((ScrambleTradeIn.GetBannerDisplayName(a1))))
        end

        local function renderPetOdds() -- Line: 616
            -- upvalues: u1418 (ref), ScrambleTradeIn (upval), u1402 (ref), Title (val), applyChancesTheme (val)
            -- upvalues: u1398 (val), RewardHolder (val), Assets (upval), pct (val), ratePerSecondFor (val)
            -- upvalues: Simple (upval), HoverCard (upval)
            local Amount, AssetId, Attach, BannerId, Cash, DisplayName, Icon, Icon2, v1, v2, v3, v4, v5, v6, v7
            local v8 = u1418
            if v8 ~= nil then
                for i, j in ScrambleTradeIn.BannerIds() do
                    if j == v8 then
                        Title.Text = ("-- %* Chances --"):format((ScrambleTradeIn.GetBannerDisplayName(v8)))
                        applyChancesTheme(BannerId)
                        v8 = ScrambleTradeIn.GetBanner(BannerId)
                        if v8 == nil then
                            return
                        end
                        v4 = table.clone(v8.Pets)
                        table.sort(v4, function(a1, a2) -- Line: 626 -- upvalues: ScrambleTradeIn (upval), BannerId (val)
                            local v1 = ScrambleTradeIn.GetPetWeight(BannerId, a1.AssetId)
                            return ScrambleTradeIn.GetPetWeight(BannerId, a2.AssetId) < v1
                        end)
                        v8 = 0
                        for k, n in v4 do
                            v8 = v8 + ScrambleTradeIn.GetPetWeight(BannerId, n.AssetId)
                        end
                        u1398:Clean()
                        for m = 1, 6 do
                            v5 = RewardHolder:FindFirstChild((tostring(m)))
                            if v5 ~= nil then
                                v6 = v4[m]
                                v5.Visible = v6 ~= nil
                                if v6 ~= nil then
                                    AssetId = v6.AssetId
                                    v7 = Assets.Directory[AssetId]
                                    Icon = v5:FindFirstChild("Icon")
                                    Icon2 = v5:FindFirstChild("Icon2")
                                    Amount = v5:FindFirstChild("Amount")
                                    if Icon and v7 then
                                        Icon.Image = v7.Icon or ""
                                    end
                                    if Icon2 and v7 then
                                        Icon2.Image = v7.Icon or ""
                                    end
                                    if Amount then
                                        Amount.Text = pct(ScrambleTradeIn.GetPetWeight(BannerId, v6.AssetId), v8)
                                    end
                                    Cash = v5:FindFirstChild("Cash")
                                    if Cash then
                                        Cash.Text = if not (0 < (ratePerSecondFor(v6.AssetId))) then "TBD" else ("$%*/s"):format((Simple.FormatCompact((ratePerSecondFor(v6.AssetId)))))
                                    end
                                    if v7 and v5:IsA("GuiObject") then
                                        Attach = HoverCard.Attach
                                        v1 = {}
                                        v2 = {kind = "heading"}
                                        DisplayName = if v7.DisplayName == "" then v6.AssetId else v7.DisplayName
                                        v2.text = DisplayName
                                        v3 = {kind = "tier", rarity = v7.Rarity._id}
                                        v1[1] = v2
                                        v1[2] = v3
                                        u1398:Add((Attach(v5, v1)))
                                    end
                                end
                            end
                        end
                        return
                    end
                end
                u1418 = nil
            end
            BannerId = if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId
            Title.Text = ("-- %* Chances --"):format((ScrambleTradeIn.GetBannerDisplayName(BannerId)))
            applyChancesTheme(BannerId)
            v8 = ScrambleTradeIn.GetBanner(BannerId)
            if v8 == nil then
                return
            end
            v4 = table.clone(v8.Pets)
            table.sort(v4, function(a1, a2) -- Line: 626 -- upvalues: ScrambleTradeIn (upval), BannerId (val)
                local v1 = ScrambleTradeIn.GetPetWeight(BannerId, a1.AssetId)
                return ScrambleTradeIn.GetPetWeight(BannerId, a2.AssetId) < v1
            end)
            v8 = 0
            for i5, i6 in v4 do
                v8 = v8 + ScrambleTradeIn.GetPetWeight(BannerId, i6.AssetId)
            end
            u1398:Clean()
            for i7 = 1, 6 do
                v5 = RewardHolder:FindFirstChild((tostring(i7)))
                if v5 ~= nil then
                    v6 = v4[i7]
                    v5.Visible = v6 ~= nil
                    if v6 ~= nil then
                        AssetId = v6.AssetId
                        v7 = Assets.Directory[AssetId]
                        Icon = v5:FindFirstChild("Icon")
                        Icon2 = v5:FindFirstChild("Icon2")
                        Amount = v5:FindFirstChild("Amount")
                        if Icon and v7 then
                            Icon.Image = v7.Icon or ""
                        end
                        if Icon2 and v7 then
                            Icon2.Image = v7.Icon or ""
                        end
                        if Amount then
                            Amount.Text = pct(ScrambleTradeIn.GetPetWeight(BannerId, v6.AssetId), v8)
                        end
                        Cash = v5:FindFirstChild("Cash")
                        if Cash then
                            Cash.Text = if not (0 < (ratePerSecondFor(v6.AssetId))) then "TBD" else ("$%*/s"):format((Simple.FormatCompact((ratePerSecondFor(v6.AssetId)))))
                        end
                        if v7 and v5:IsA("GuiObject") then
                            Attach = HoverCard.Attach
                            v1 = {}
                            v2 = {kind = "heading"}
                            DisplayName = if v7.DisplayName == "" then v6.AssetId else v7.DisplayName
                            v2.text = DisplayName
                            v3 = {kind = "tier", rarity = v7.Rarity._id}
                            v1[1] = v2
                            v1[2] = v3
                            u1398:Add((Attach(v5, v1)))
                        end
                    end
                end
            end
        end

        local function renderPity() -- Line: 671
            -- upvalues: u1402 (ref), ScrambleTradeIn (upval), Assets (upval), Icon (val), PityLabel (val)
            -- upvalues: TweenService (upval), ProgressBar (val), u138 (upval)
            local v1 = u1402 and u1402.PityCount or 0
            local v2 = u1402 and u1402.PityThreshold or 200
            local v3 = ScrambleTradeIn.ChasePetId(if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId)
            local v4 = if not v3 then nil else Assets.Directory[v3]
            Icon.Image = v4 and v4.Icon or ""
            PityLabel.Text = ("%*/%*"):format(v1, v2)
            v4 = if not (v2 > 0) then 0 else math.clamp(v1 / v2, 0, 1)
            TweenService:Create(ProgressBar, u138, {Size = UDim2.new(v4, 0, 1, 0)}):Play()
        end

        local function renderSlots() -- Line: 682
            -- upvalues: u1402 (ref), SacrificeInputs (val), u1406 (val), Assets (upval), foundInText (val), Price (val)
            -- upvalues: u1111 (ref), setBarFilled (val), setOutputProgress (val)
            local Amount, Color, Empty, FoundInWorld, Full, Name, Name_2, Pet, Pet_2, Rarity, v1, v2, v3, v4
            local Requirements = if not u1402 then nil else u1402.Requirements
            for i = 1, 3 do
                v1 = SacrificeInputs:FindFirstChild((("Input%*"):format(i)))
                if v1 ~= nil then
                    Full = v1:FindFirstChild("Full")
                    Empty = v1:FindFirstChild("Empty")
                    if Full and Empty then
                        v2 = Requirements and Requirements[i]
                        v3 = u1406[i]
                        if v3 and v2 and v3.Category ~= v2 then
                            u1406[i] = nil
                            v3 = nil
                        end
                        v4 = v2 and Assets.Directory[v2]
                        Full.Visible = v3 ~= nil
                        Empty.Visible = v3 == nil
                        FoundInWorld = v1:FindFirstChild("FoundInWorld")
                        if FoundInWorld then
                            FoundInWorld.RichText = true
                            FoundInWorld.Text = foundInText(v2)
                            FoundInWorld.Visible = v2 ~= nil
                        end
                        if not v3 or not v4 then
                            Name_2 = Empty:FindFirstChild("Name")
                            Rarity = Empty:FindFirstChild("Rarity")
                            Pet_2 = Empty:FindFirstChild("Pet")
                            Amount = Empty:FindFirstChild("Amount")
                            if Name_2 then
                                Name_2.Text = if not v4 then "???" else ("%* Egg"):format(not (v4.DisplayName == "") and v4.DisplayName or v2)
                            end
                            if Rarity then
                                Rarity.Text = if not v4 then "" else v4.Rarity.DisplayName
                                if v4 and v4.Rarity.Color then
                                    Rarity.TextColor3 = v4.Rarity.Color
                                end
                            end
                            if Pet_2 then
                                Pet_2.Image = v4 and v4.Egg.Icon or ""
                                Pet_2.ImageTransparency = 0.4
                            end
                            if Amount then
                                Amount.Text = "0/1"
                            end
                        else
                            Name = Full:FindFirstChild("Name")
                            v1 = Full:FindFirstChild("Rarity")
                            Pet = Full:FindFirstChild("Pet")
                            if Name then
                                Name.Text = ("%* Egg"):format(not (v4.DisplayName == "") and v4.DisplayName or v3.Category)
                            end
                            if v1 then
                                v1.Text = v4.Rarity.DisplayName
                                Color = v4.Rarity.Color or v1.TextColor3
                                v1.TextColor3 = Color
                            end
                            if Pet then
                                Pet.Image = v4.Egg.Icon or ""
                                Pet.ImageTransparency = 0
                            end
                        end
                    end
                end
            end
            local v5 = 0
            if u1406[1] then
                v5 = v5 + 1
            end
            if u1406[2] then
                v5 = v5 + 1
            end
            if u1406[3] then
                v5 = v5 + 1
            end
            local v6 = 3 - v5
            Price.Text = if v6 ~= 0 then if v6 ~= 1 then ("%* Eggs Left"):format(v6) else "1 Egg Left" else "SACRIFICE"
            v6 = u1111
            u1111 = true
            setBarFilled(1, u1406[1] ~= nil, v6)
            setBarFilled(2, u1406[2] ~= nil, v6)
            setBarFilled(3, u1406[3] ~= nil, v6)
            local v7 = 0
            if u1406[1] then
                v7 = v7 + 1
            end
            if u1406[2] then
                v7 = v7 + 1
            end
            if u1406[3] then
                v7 = v7 + 1
            end
            setOutputProgress(v7, v6)
        end

        local u442 = nil

        local function v18() -- Line: 767 -- upvalues: u1402 (ref), u442 (ref), u1414 (ref), u190 (upval)
            if u1402 == nil then
                u442.Text = "REROLL"
                return
            end
            local v1 = u1402.FreeRefreshesRemaining or 0
            if v1 > 0 then
                u442.Text = ("REROLL (%* free)"):format(v1)
                return
            end
            if u1414 then
                u442.Text = ("REROLL %*%*"):format(u190, u1414)
                return
            end
            u442.Text = "REROLL"
        end

        local function renderAll() -- Line: 782
            -- upvalues: renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val)
            -- upvalues: renderSlots (val), u1402 (ref), u442 (ref), u1414 (ref), u190 (upval)
            renderBannerPanel()
            renderTimer()
            renderPetOdds()
            renderPity()
            renderSlots()
            if u1402 == nil then
                u442.Text = "REROLL"
                return
            end
            local v1 = u1402.FreeRefreshesRemaining or 0
            if v1 > 0 then
                u442.Text = ("REROLL (%* free)"):format(v1)
                return
            end
            if u1414 then
                u442.Text = ("REROLL %*%*"):format(u190, u1414)
                return
            end
            u442.Text = "REROLL"
        end

        local function fetchState() -- Line: 791
            -- upvalues: Remotes (upval), u1402 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u442 (ref), u1414 (ref), u190 (upval)
            task.spawn(function() -- Line: 792
                -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval), u1414 (upval)
                -- upvalues: u190 (upval)
                local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                    return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1402 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1402 == nil then
                        u442.Text = "REROLL"
                        return
                    end
                    local v1 = u1402.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u442.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1414 then
                        u442.Text = ("REROLL %*%*"):format(u190, u1414)
                        return
                    end
                    u442.Text = "REROLL"
                end
            end)
        end

        local function showMain() -- Line: 803
            -- upvalues: DrScrambleTradeInInventory (val), DrScrambleTradeInMain (val)
            DrScrambleTradeInInventory.Visible = false
            DrScrambleTradeInMain.Visible = true
        end

        local function openPicker(a1) -- Line: 808
            -- upvalues: u1402 (ref), Save (upval), Assets (upval), u1406 (val), EggRecords (upval), Toast (upval)
            -- upvalues: u143 (upval), u1394 (val), u1424 (ref), petTitles (val), ButtonFX (upval)
            -- upvalues: DrScrambleTradeInInventory (val), DrScrambleTradeInMain (val), renderSlots (val), u1374 (val)
            local Requirements = u1402 and u1402.Requirements
            local u7 = Requirements
            if u7 then
                u7 = Requirements[a1]
            end
            local v1 = Save.Await()
            if u7 ~= nil and v1 ~= nil then
                local err, success, v2, v3
                local v4 = Assets.Directory[u7]
                local DisplayName = if not v4 then u7 else if v4.DisplayName == "" then u7 else v4.DisplayName
                v4 = {}
                local v5 = u1406[1]
                if v5 then
                    v4[v5.Uid] = true
                end
                v5 = u1406[2]
                if v5 then
                    v4[v5.Uid] = true
                end
                v5 = u1406[3]
                if v5 then
                    v4[v5.Uid] = true
                end
                v5 = {}
                for i, j in v1.EggInventory do
                    if not v4[i] and j.AssetCategory == u7 and j.Placement == nil then
                        success, err = pcall(EggRecords.Decode, j)
                        if success then
                            table.insert(v5, {Uid = i, Icon = EggRecords.EggIcon(err)})
                        end
                    end
                end
                if #v5 == 0 then
                    Toast.Show({
                        Seconds = 3,
                        SingleLine = true,
                        Text = ("You need an unplaced %* egg"):format(DisplayName),
                        Color = u143,
                    })
                    return
                end
                table.sort(v5, function(a1, a2) -- Line: 846
                    return a1.Uid < a2.Uid
                end)
                u1394:Clean()
                local v6 = nil
                local v7 = nil
                for k, n in v5, v6, v7 do
                    v4 = u1424:Clone()
                    v4.Name = ("Egg_%*"):format(n.Uid)
                    v4.LayoutOrder = k
                    v4.Visible = true
                    u1394:Add(v4)
                    v1 = v4:FindFirstChild("PetDecal")
                    if v1 then
                        v1.Image = n.Icon
                    end
                    v2, v3 = petTitles(v4)
                    if v2 then
                        v2.Text = ("%* Egg"):format(DisplayName)
                    end
                    if v3 then
                        v3.Text = "Unplaced"
                    end
                    u1394:Add((ButtonFX(v4, 1.06, function() -- Line: 870
                        -- upvalues: u1406 (upval), a1 (val), n (val), u7 (val), DrScrambleTradeInInventory (upval)
                        -- upvalues: DrScrambleTradeInMain (upval), renderSlots (upval)
                        u1406[a1] = {Uid = n.Uid, Category = u7}
                        DrScrambleTradeInInventory.Visible = false
                        DrScrambleTradeInMain.Visible = true
                        renderSlots()
                    end)))
                    v4.Parent = u1374
                end
                DrScrambleTradeInMain.Visible = false
                DrScrambleTradeInInventory.Visible = true
                return
            end
        end

        local function v19() -- Line: 882
            -- upvalues: u1410 (ref), u1402 (ref), u1406 (val), Toast (upval), u143 (upval), Save (upval)
            -- upvalues: renderSlots (val), EggRecords (upval), Price (val), Remotes (upval), Tabs (upval)
            -- upvalues: renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val), u442 (ref)
            -- upvalues: u1414 (ref), u190 (upval), DrScrambleSequence (upval), u148 (upval)
            if u1410 then
                return
            end
            local Requirements = u1402 and u1402.Requirements
            if Requirements ~= nil and not (#Requirements < 3) then
                local err, err_2, success, success_2, v1, v2, v3, v4
                local v5 = 0
                if u1406[1] then
                    v5 = v5 + 1
                end
                if u1406[2] then
                    v5 = v5 + 1
                end
                if u1406[3] then
                    v5 = v5 + 1
                end
                if v5 < 3 then
                    local Show = Toast.Show
                    v1 = {Seconds = 2, SingleLine = true}
                    v3 = 0
                    if u1406[1] then
                        v3 = v3 + 1
                    end
                    if u1406[2] then
                        v3 = v3 + 1
                    end
                    if u1406[3] then
                        v3 = v3 + 1
                    end
                    v1.Text = ("Choose %* more requested eggs"):format(3 - v3)
                    v1.Color = u143
                    Show(v1)
                    return
                end
                local v6 = Save.Await()
                if v6 == nil then
                    return
                end
                local u97 = {}
                v1 = {}
                for i = 1, 3 do
                    v3 = u1406[i]
                    v4 = v6.EggInventory[v3.Uid]
                    if v4 ~= nil and v4.Placement == nil and v4.AssetCategory == v3.Category then
                        table.insert(u97, v3.Uid)
                        success, err = pcall(EggRecords.Decode, v4)
                        if success then
                            table.insert(v1, err)
                        end
                        continue
                    end
                    u1406[i] = nil
                    renderSlots()
                    return
                end
                u1410 = true
                Price.Text = "..."
                success_2, err_2, v2, v3 = pcall(function() -- Line: 923 -- upvalues: Remotes (upval), u97 (val)
                    return Remotes.ScrambleTradeIn.AskTradeIn:InvokeServer(u97)
                end)
                u1410 = false
                if success_2 and err_2 == true then
                    u1406[1] = nil
                    u1406[2] = nil
                    u1406[3] = nil
                    Tabs.Deactivate()
                    task.spawn(function() -- Line: 792
                        -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                        -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval)
                        -- upvalues: u1414 (upval), u190 (upval)
                        local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                            return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                        end)
                        if success and typeof(err) == "table" then
                            u1402 = err
                            renderBannerPanel()
                            renderTimer()
                            renderPetOdds()
                            renderPity()
                            renderSlots()
                            if u1402 == nil then
                                u442.Text = "REROLL"
                                return
                            end
                            local v1 = u1402.FreeRefreshesRemaining or 0
                            if v1 > 0 then
                                u442.Text = ("REROLL (%* free)"):format(v1)
                                return
                            end
                            if u1414 then
                                u442.Text = ("REROLL %*%*"):format(u190, u1414)
                                return
                            end
                            u442.Text = "REROLL"
                        end
                    end)
                    local Play = DrScrambleSequence.Play
                    local Egg = if not v3 then nil else v3.Egg
                    Play(v1, function() -- Line: 945 -- upvalues: Remotes (upval), Toast (upval), u148 (upval)
                        pcall(function() -- Line: 946 -- upvalues: Remotes (upval)
                            Remotes.ScrambleTradeIn.AskFinishReveal:InvokeServer()
                        end)
                        Toast.Show({
                            Text = "A laboratory egg joins your eggs!",
                            Seconds = 3.5,
                            SingleLine = true,
                            Color = u148,
                        })
                    end, Egg)
                    return
                end
                Toast.Show({
                    Seconds = 3,
                    SingleLine = true,
                    Text = tostring((if not success_2 then "Something went wrong, please try again" else v2) or "The laboratory refused the trade"),
                    Color = u143,
                })
                renderSlots()
                return
            end
        end

        local function v20() -- Line: 958
            -- upvalues: u1410 (ref), u1402 (ref), Remotes (upval), renderSlots (val), u442 (ref), u1414 (ref)
            -- upvalues: u190 (upval), Toast (upval), u143 (upval), renderBannerPanel (val), renderTimer (val)
            -- upvalues: renderPetOdds (val), renderPity (val), Storefront (upval), Products (upval)
            if u1410 then
                return
            end
            if not ((u1402 and u1402.FreeRefreshesRemaining or 0) > 0) then
                Storefront.Prompt(Products.Directory.RiftRefresh.ProductId, true)
                return
            end
            u1410 = true
            local success, err, v1, v2 = pcall(function() -- Line: 965 -- upvalues: Remotes (upval)
                return Remotes.ScrambleTradeIn.AskRefresh:InvokeServer()
            end)
            u1410 = false
            if success and err == true then
                if u1402 and typeof(v2) == "table" then
                    local v3
                    u1402.Requirements = v2
                    u1402.FreeRefreshesRemaining = math.max(v3 - 1, 0)
                end
                renderSlots()
                if u1402 == nil then
                    u442.Text = "REROLL"
                    return
                end
                local v4 = u1402.FreeRefreshesRemaining or 0
                if v4 > 0 then
                    u442.Text = ("REROLL (%* free)"):format(v4)
                    return
                end
                if u1414 then
                    u442.Text = ("REROLL %*%*"):format(u190, u1414)
                    return
                end
                u442.Text = "REROLL"
                return
            end
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Text = tostring(if not success then "Refresh failed, try again" else v1),
                Color = u143,
            })
            task.spawn(function() -- Line: 792
                -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval), u1414 (upval)
                -- upvalues: u190 (upval)
                local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                    return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1402 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1402 == nil then
                        u442.Text = "REROLL"
                        return
                    end
                    local v1 = u1402.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u442.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1414 then
                        u442.Text = ("REROLL %*%*"):format(u190, u1414)
                        return
                    end
                    u442.Text = "REROLL"
                end
            end)
        end

        local v21 = SacrificeInputs:FindFirstChild("Input1")
        local v22 = v21 and v21:FindFirstChild("Full")
        v21 = v22 and v22:FindFirstChild("Return")
        local v23 = v21 and v21:IsA("ImageButton")
        assert(v23, "DrScrambleTradeIn Input1 has no Return button to clone")
        local v24 = v21:Clone()
        v24.Name = "Refresh"
        v24.AnchorPoint = Vector2.new(0, 0)
        v24.Position = UDim2.fromScale(1.0309, 0.839)
        v24.Size = UDim2.fromScale(0.3962, 0.062)
        v22 = v24:FindFirstChildWhichIsA("TextLabel")
        assert(v22, "Refresh clone lost its label")
        u442 = v22
        u442.Text = "REROLL"
        v24.Parent = DrScrambleTradeInMain
        for i14 = 1, 3 do
            v23 = SacrificeInputs:FindFirstChild((("Input%*"):format(i14)))
            if v23 ~= nil then
                v6 = v23:FindFirstChild("Empty")
                v7 = v23:FindFirstChild("Full")
                v23 = v6 and v6:FindFirstChild("Add")
                v6 = v7 and v7:FindFirstChild("Return")
                if v23 and v23:IsA("GuiButton") then
                    u1390:Add((ButtonFX(v23, 1.08, function() -- Line: 1017 -- upvalues: openPicker (val), i14 (val)
                        openPicker(i14)
                    end)))
                end
                if v6 and v6:IsA("GuiButton") then
                    u1390:Add((ButtonFX(v6, 1.08, function() -- Line: 1022 -- upvalues: u1406 (val), i14 (val), renderSlots (val)
                        u1406[i14] = nil
                        renderSlots()
                    end)))
                end
            end
        end
        u1390:Add((ButtonFX(Sacrifice, 1.05, v19)))
        u1390:Add((ButtonFX(v24, 1.08, v20)))
        u1390:Add((ButtonFX(Close, 1.08, showMain)))

        function v20(a1) -- Line: 1033
            -- upvalues: ScrambleTradeIn (upval), u1418 (ref), u1402 (ref), renderBannerPanel (val), renderPetOdds (val)
            local v1 = ScrambleTradeIn.BannerIds()[a1]
            if v1 == nil then
                return
            end
            local BannerId = if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId
            u1418 = if v1 ~= BannerId then v1 else nil
            renderBannerPanel()
            renderPetOdds()
        end

        for i15, i16 in u760 do
            v19 = Instance.new("TextButton")
            v19.Name = "SelectHit"
            v19.BackgroundTransparency = 1
            v19.Text = ""
            v19.AutoButtonColor = false
            v19.AnchorPoint = Vector2.new(0.5, 0.5)
            v19.Position = UDim2.fromScale(0.5, 0.5)
            v19.Size = UDim2.fromScale(1, 1)
            v19.ZIndex = 20
            v19.Parent = i16
            u1390:Add(v19)
            u1390:Add((v19.MouseEnter:Connect(function() -- Line: 1055
                -- upvalues: u1422 (ref), i15 (val), paintRow (val), ScrambleTradeIn (upval), u1418 (ref), u1402 (ref)
                u1422 = i15
                local v1 = paintRow
                local v2 = i15
                local v3 = ScrambleTradeIn.BannerIds()[i15]
                local v4 = u1418
                if v4 ~= nil then
                    for i, j in ScrambleTradeIn.BannerIds() do
                        if j == v4 then
                            v1(
                                v2,
                                v3 == v4,
                                ScrambleTradeIn.BannerIds()[i15] == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId)
                            )
                            return
                        end
                    end
                    u1418 = nil
                end
                v1(
                    v2,
                    v3 == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId),
                    ScrambleTradeIn.BannerIds()[i15] == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId)
                )
            end)))
            u1390:Add((v19.MouseLeave:Connect(function() -- Line: 1059
                -- upvalues: u1422 (ref), i15 (val), paintRow (val), ScrambleTradeIn (upval), u1418 (ref), u1402 (ref)
                if u1422 == i15 then
                    u1422 = nil
                end
                local v1 = paintRow
                local v2 = i15
                local v3 = ScrambleTradeIn.BannerIds()[i15]
                local v4 = u1418
                if v4 ~= nil then
                    for i, j in ScrambleTradeIn.BannerIds() do
                        if j == v4 then
                            v1(
                                v2,
                                v3 == v4,
                                ScrambleTradeIn.BannerIds()[i15] == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId)
                            )
                            return
                        end
                    end
                    u1418 = nil
                end
                v1(
                    v2,
                    v3 == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId),
                    ScrambleTradeIn.BannerIds()[i15] == (if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId)
                )
            end)))
            u1390:Add((ButtonFX(v19, 1, function() -- Line: 1065
                -- upvalues: i15 (val), ScrambleTradeIn (upval), u1418 (ref), u1402 (ref), renderBannerPanel (val)
                -- upvalues: renderPetOdds (val)
                local v1 = ScrambleTradeIn.BannerIds()[i15]
                if v1 == nil then
                    return
                end
                local BannerId = if not u1402 then ScrambleTradeIn.CurrentBannerId() else if not u1402.BannerId then ScrambleTradeIn.CurrentBannerId() else u1402.BannerId
                u1418 = if v1 ~= BannerId then v1 else nil
                renderBannerPanel()
                renderPetOdds()
            end)))
        end
        Title.TextScaled = true
        Title.TextWrapped = true
        u1390:Add((Tabs.Activated:Connect(function(a1) -- Line: 1073
            -- upvalues: ScrambleLeaveTimer (upval), Tabs (upval), u1418 (ref), u1422 (ref)
            -- upvalues: DrScrambleTradeInInventory (val), DrScrambleTradeInMain (val), Remotes (upval), u1402 (ref)
            -- upvalues: renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val)
            -- upvalues: renderSlots (val), u442 (ref), u1414 (ref), u190 (upval)
            if a1 == "DrScrambleTradeIn" then
                if ScrambleLeaveTimer.IsExpired() then
                    Tabs.Deactivate({instant = true})
                    return
                end
                u1418 = nil
                u1422 = nil
                DrScrambleTradeInInventory.Visible = false
                DrScrambleTradeInMain.Visible = true
                task.spawn(function() -- Line: 792
                    -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                    -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval)
                    -- upvalues: u1414 (upval), u190 (upval)
                    local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                        return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                    end)
                    if success and typeof(err) == "table" then
                        u1402 = err
                        renderBannerPanel()
                        renderTimer()
                        renderPetOdds()
                        renderPity()
                        renderSlots()
                        if u1402 == nil then
                            u442.Text = "REROLL"
                            return
                        end
                        local v1 = u1402.FreeRefreshesRemaining or 0
                        if v1 > 0 then
                            u442.Text = ("REROLL (%* free)"):format(v1)
                            return
                        end
                        if u1414 then
                            u442.Text = ("REROLL %*%*"):format(u190, u1414)
                            return
                        end
                        u442.Text = "REROLL"
                    end
                end)
            end
        end)))
        u1390:Add((Tabs.Deactivated:Connect(function(a1) -- Line: 1085
            -- upvalues: DrScrambleTradeInInventory (val), DrScrambleTradeInMain (val)
            if a1 == "DrScrambleTradeIn" then
                DrScrambleTradeInInventory.Visible = false
                DrScrambleTradeInMain.Visible = true
            end
        end)))
        Remotes.ScrambleTradeIn.BannerRotated.OnClientEvent:Connect(function() -- Line: 1091
            -- upvalues: Remotes (upval), u1402 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u442 (ref), u1414 (ref), u190 (upval)
            task.spawn(function() -- Line: 792
                -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval), u1414 (upval)
                -- upvalues: u190 (upval)
                local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                    return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1402 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1402 == nil then
                        u442.Text = "REROLL"
                        return
                    end
                    local v1 = u1402.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u442.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1414 then
                        u442.Text = ("REROLL %*%*"):format(u190, u1414)
                        return
                    end
                    u442.Text = "REROLL"
                end
            end)
        end)
        MarketplaceService.PromptProductPurchaseFinished:Connect(function(a1, a2, a3) -- Line: 1095 -- upvalues: Products (upval), fetchState (val) -- types: a2: number, a3: boolean
            if a3 and a2 == Products.Directory.RiftRefresh.ProductId then
                task.delay(1, fetchState)
            end
        end)
        task.spawn(function() -- Line: 1101
            -- upvalues: MarketplaceService (upval), Products (upval), u1414 (ref), u1402 (ref), u442 (ref)
            -- upvalues: u190 (upval)
            local success, err = pcall(function() -- Line: 1102 -- upvalues: MarketplaceService (upval), Products (upval)
                return MarketplaceService:GetProductInfo(Products.Directory.RiftRefresh.ProductId, Enum.InfoType.Product)
            end)
            if success and err and err.PriceInRobux then
                u1414 = err.PriceInRobux
                if u1402 == nil then
                    u442.Text = "REROLL"
                    return
                end
                local v1 = u1402.FreeRefreshesRemaining or 0
                if v1 > 0 then
                    u442.Text = ("REROLL (%* free)"):format(v1)
                    return
                end
                if u1414 then
                    u442.Text = ("REROLL %*%*"):format(u190, u1414)
                    return
                end
                u442.Text = "REROLL"
            end
        end)
        task.spawn(function() -- Line: 1111
            -- upvalues: ScrambleLeaveTimer (upval), Tabs (upval), u1298 (val), renderTimer (val)
            -- upvalues: ScrambleTradeIn (upval), u1402 (ref), Remotes (upval), renderBannerPanel (val)
            -- upvalues: renderPetOdds (val), renderPity (val), renderSlots (val), u442 (ref), u1414 (ref), u190 (upval)
            local v1
            while true do
                task.wait(1)
                if ScrambleLeaveTimer.IsExpired() then
                    if Tabs.IsActive("DrScrambleTradeIn") then
                        Tabs.Deactivate({instant = true})
                    end
                end
                if u1298.Enabled then
                    renderTimer()
                    v1 = ScrambleTradeIn.CurrentBannerId()
                    if u1402 and u1402.BannerId ~= v1 then
                        task.spawn(function() -- Line: 792
                            -- upvalues: Remotes (upval), u1402 (upval), renderBannerPanel (upval), renderTimer (upval)
                            -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u442 (upval)
                            -- upvalues: u1414 (upval), u190 (upval)
                            local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                                return Remotes.ScrambleTradeIn.AskState:InvokeServer()
                            end)
                            if success and typeof(err) == "table" then
                                u1402 = err
                                renderBannerPanel()
                                renderTimer()
                                renderPetOdds()
                                renderPity()
                                renderSlots()
                                if u1402 == nil then
                                    u442.Text = "REROLL"
                                    return
                                end
                                local v1 = u1402.FreeRefreshesRemaining or 0
                                if v1 > 0 then
                                    u442.Text = ("REROLL (%* free)"):format(v1)
                                    return
                                end
                                if u1414 then
                                    u442.Text = ("REROLL %*%*"):format(u190, u1414)
                                    return
                                end
                                u442.Text = "REROLL"
                            end
                        end)
                    end
                end
            end
        end)
        Save.Await()
        pcall(function() -- Line: 1128 -- upvalues: u1390 (val), Save (upval), fetchState (val)
            u1390:Add((Save.WatchFields("Rift", fetchState)))
        end)
        task.spawn(function() -- Line: 792
            -- upvalues: Remotes (upval), u1402 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u442 (ref), u1414 (ref), u190 (upval)
            local success, err = pcall(function() -- Line: 793 -- upvalues: Remotes (upval)
                return Remotes.ScrambleTradeIn.AskState:InvokeServer()
            end)
            if success and typeof(err) == "table" then
                u1402 = err
                renderBannerPanel()
                renderTimer()
                renderPetOdds()
                renderPity()
                renderSlots()
                if u1402 == nil then
                    u442.Text = "REROLL"
                    return
                end
                local v1 = u1402.FreeRefreshesRemaining or 0
                if v1 > 0 then
                    u442.Text = ("REROLL (%* free)"):format(v1)
                    return
                end
                if u1414 then
                    u442.Text = ("REROLL %*%*"):format(u190, u1414)
                    return
                end
                u442.Text = "REROLL"
            end
        end)
        return u1390
    end,
}