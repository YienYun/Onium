-- Script path: ReplicatedStorage.Controllers.GUI.RiftTradeInController
-- Decompile time: 67.55 ms

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Areas = require(ReplicatedStorage.Data.Areas)
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local FuseKernel = require(ReplicatedStorage.Shared.Util.FuseKernel)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Rift = require(ReplicatedStorage.Data.Rift)
local RiftRecipes = require(ReplicatedStorage.Shared.Modules.RiftRecipes)
local RiftSequence = require(script.RiftSequence)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u109 = {"LeftBar", "MiddleBar", "RightBar"}
local u117 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u122 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u127 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u132 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u137 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u142 = Color3.fromRGB(255, 64, 64)
local u147 = Color3.fromRGB(196, 130, 255)
local u152 = Color3.fromRGB(166, 255, 228)
local u157 = Color3.new(0.25, 0.25, 0.3)
local u161 = UDim2.fromScale(0.012, 0.14)
local u165 = UDim2.fromScale(0.1, 0.55)
local u172 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local u177 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u178 = {"Purple", "Red", "Yellow"}
local u186 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u189 = utf8.char(57346)
local u190 = {}
u190.Verdant = Color3.fromRGB(126, 217, 130)
u190.Umbral = Color3.fromRGB(168, 122, 255)
u190.Radiant = Color3.fromRGB(255, 205, 84)
return {
    Start = function() -- Line: 80
        -- upvalues: GUI (val), Trove (val), u109 (val), u147 (val), TweenService (val), u117 (val), u122 (val)
        -- upvalues: u127 (val), u132 (val), u152 (val), Hud (val), u161 (val), u165 (val), EnsureUIScale (val)
        -- upvalues: u172 (val), Rift (val), u186 (val), Assets (val), RiftRecipes (val), Areas (val), u190 (val)
        -- upvalues: u157 (val), u178 (val), u177 (val), AssetEarnings (val), Simple (val), HoverCard (val), u137 (val)
        -- upvalues: u189 (val), Remotes (val), Save (val), FuseKernel (val), AssetItems (val), Toast (val), u142 (val)
        -- upvalues: ButtonFX (val), Tabs (val), RiftSequence (val), Storefront (val), Products (val)
        -- upvalues: MarketplaceService (val)
        local v1, v2, v3, v4, v5, v6, v7
        local u1254 = GUI.RiftTradeIn()
        local RiftTradeInMain = u1254:WaitForChild("RiftTradeInMain")
        local RiftTradeInInventory = u1254:WaitForChild("RiftTradeInInventory")
        local CurrentEggInfoHolder = RiftTradeInMain:WaitForChild("CurrentEggInfoHolder")
        local EggIcon = CurrentEggInfoHolder:WaitForChild("EggIcon")
        local EggName = CurrentEggInfoHolder:WaitForChild("EggName")
        local RotateTimer = CurrentEggInfoHolder:WaitForChild("RotateTimer")
        local ScrollingFrame = CurrentEggInfoHolder:WaitForChild("ScrollingFrame")
        local u1263 = RiftTradeInMain:WaitForChild("EggChancesHolder")
        local RewardHolder = u1263:WaitForChild("RewardHolder")
        local Title = u1263:WaitForChild("Title")
        local PityHolder = u1263:FindFirstChild("PityHolder")
        if not PityHolder then
            PityHolder = RiftTradeInMain:WaitForChild("PityHolder")
        end
        local PityLabel = PityHolder:WaitForChild("PityLabel")
        local ProgressBar = PityHolder:WaitForChild("ProgressBar")
        local SacrificeInputs = RiftTradeInMain:WaitForChild("SacrificeInputs")
        local Sacrifice = RiftTradeInMain:WaitForChild("Sacrifice")
        local Price = Sacrifice:WaitForChild("Price")
        local DesignBars = RiftTradeInMain:WaitForChild("DesignBars")
        local Output = (RiftTradeInMain:WaitForChild("SacrificeOutput")):WaitForChild("Output")
        local Fill = Output:WaitForChild("Fill")
        local OutputEgg = Output:WaitForChild("OutputEgg")
        local u1305 = RiftTradeInInventory:WaitForChild("ScrollingFrame")
        local Close = RiftTradeInInventory:WaitForChild("Close")
        local u1317 = Trove.new()
        local u1320 = Trove.new()
        u1317:Add(u1320)
        local u1323 = Trove.new()
        u1317:Add(u1323)
        local u1326 = nil
        local u1329 = {}
        local u1332 = false
        local u1335 = nil
        local u1338 = nil
        local u1341 = nil
        local v8 = nil
        for i, j in u1305:GetChildren() do
            if j.Name == "Pet" and j:IsA("ImageButton") then
                if not v8 then
                    v8 = j
                else
                    j:Destroy()
                end
            end
        end
        assert(v8, "RiftTradeInInventory has no Pet template")
        local u1343 = v8
        u1343.Visible = false
        u1343.BackgroundTransparency = 1
        local PetDecal = u1343:FindFirstChild("PetDecal")
        if PetDecal and PetDecal:IsA("ImageLabel") then
            PetDecal.BackgroundTransparency = 1
            PetDecal.ScaleType = Enum.ScaleType.Fit
        end
        local u1244 = {}
        local u1247 = {}
        local u1249 = {}
        local u1344 = {}
        local v9 = nil
        local v10 = nil
        for k, n in u109, v9, v10 do
            v1 = DesignBars:FindFirstChild(n)
            v2 = v1 and v1:FindFirstChild("Fill")
            if v2 and v2:IsA("ImageLabel") then
                u1244[k] = v2
                u1247[k] = v2.ImageTransparency
                u1249[k] = false
                v2.ImageTransparency = 1
                v2.Visible = false
            end
        end
        local Size = Fill.Size
        local Position = Fill.Position
        local Y = Fill.AnchorPoint.Y
        local u184 = Position.Y.Scale + (1 - Y) * Size.Y.Scale
        local u191 = Position.Y.Offset + (1 - Y) * Size.Y.Offset
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "RiftProgressScale"
        UIScale.Parent = OutputEgg
        OutputEgg.ZIndex = Fill.ZIndex + 1
        Fill.BackgroundTransparency = 0.45
        Fill.BackgroundColor3 = u147
        local u201 = nil
        local u202 = nil
        local u1074 = false

        local function setBarFilled(a1, a2, a3) -- Line: 189
            -- upvalues: u1244 (val), u1249 (val), u1344 (val), u1247 (val), TweenService (upval), u117 (upval)
            local u4 = u1244[a1]
            if u4 ~= nil and u1249[a1] ~= a2 then
                u1249[a1] = a2
                local v1 = u1344[a1]
                if v1 then
                    v1:Cancel()
                    u1344[a1] = nil
                end
                v1 = if not a2 then 1 else u1247[a1]
                if not a3 then
                    u4.ImageTransparency = v1
                    u4.Visible = a2
                    return
                end
                if a2 and not u4.Visible then
                    u4.ImageTransparency = 1
                end
                u4.Visible = true
                local v2 = TweenService:Create(u4, u117, {ImageTransparency = v1})
                u1344[a1] = v2
                v2.Completed:Connect(function(a1_2) -- Line: 212 -- upvalues: u4 (val), u1249 (upval), a1 (val)
                    if a1_2 == Enum.PlaybackState.Completed then
                        u4.Visible = u1249[a1]
                    end
                end)
                v2:Play()
                return
            end
        end

        local function setOutputProgress(a1, a2) -- Line: 220
            -- upvalues: Size (val), Position (val), u184 (val), Y (val), u191 (val), TweenService (upval), Fill (val)
            -- upvalues: u122 (upval), u201 (ref), u202 (ref), OutputEgg (val), UIScale (val), u127 (upval)
            -- upvalues: u132 (upval)
            local v1 = a1 / 3
            local v2 = UDim2.new(Size.X.Scale, Size.X.Offset, v1, 0)
            local v3 = UDim2.new(Position.X.Scale, Position.X.Offset, u184 - (1 - Y) * v1, u191)
            if not a2 then
                Fill.Size = v2
                Fill.Position = v3
            else
                TweenService:Create(Fill, u122, {Size = v2, Position = v3}):Play()
            end
            v3 = a1 >= 3
            v2 = u201
            u201 = v3
            if u202 then
                u202:Cancel()
                u202 = nil
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
                v1 = TweenService:Create(UIScale, u127, {Scale = 1.2})
                u202 = v1
                v1.Completed:Connect(function(a1) -- Line: 250 -- upvalues: u201 (upval), TweenService (upval), UIScale (upval), u132 (upval), u202 (upval)
                    if a1 == Enum.PlaybackState.Completed and u201 == true then
                        local v1 = TweenService:Create(UIScale, u132, {Scale = 1})
                        u202 = v1
                        v1:Play()
                    end
                end)
                v1:Play()
                return
            end
            UIScale.Scale = 1
        end

        local u728 = {}
        for m, i5 in ScrollingFrame:GetChildren() do
            if i5.Name == "Template" and i5:IsA("Frame") then
                table.insert(u728, i5)
            end
        end
        local u325 = {}
        local v11 = nil
        local v12 = nil
        for i6, i7 in u728, v11, v12 do
            v3 = Instance.new("Frame")
            v3.Name = "SelectFill"
            v3.BackgroundColor3 = u152
            v3.BackgroundTransparency = 1
            v3.BorderSizePixel = 0
            v3.Size = UDim2.fromScale(1, 1)
            v3.ZIndex = 0
            v4 = i7:FindFirstChildOfClass("UICorner")
            if v4 then
                v4:Clone().Parent = v3
            end
            v3.Parent = i7
            u1317:Add(v3)
            u325[i6] = v3
        end
        local u236 = {}
        local u310 = {}
        v12 = Hud.Every("IndexNotificationBadge")[1]
        if v12 ~= nil and v12:IsA("GuiObject") then
            local v13
            ScrollingFrame.ClipsDescendants = false
            local v14 = nil
            v3 = nil
            for i8, i9 in u728, v14, v3 do
                v13 = v12:Clone()
                v13.Name = "NowBadge"
                for i10, i11 in v13:GetDescendants() do
                    if i11:IsA("TextLabel") then
                        i11.Text = "!"
                    end
                end
                v13.AnchorPoint = Vector2.new(0.5, 0.5)
                v13.Position = u161
                v13.Size = u165
                v13.ZIndex = 25
                v13.Visible = false
                v13.Parent = i9
                u1317:Add(v13)
                u236[i8] = v13
            end
        end

        local function setNowBadge(a1, a2) -- Line: 319
            -- upvalues: u236 (val), u310 (val), EnsureUIScale (upval), TweenService (upval), u172 (upval)
            local v1
            local v2 = u236[a1]
            if v2 == nil then
                return
            end
            v2.Visible = a2
            local v3 = u310[a1]
            if not a2 then
                if v3 ~= nil then
                    v3:Cancel()
                    v3:Destroy()
                    u310[a1] = nil
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
            v3 = TweenService:Create(v1, u172, {Scale = 1.2})
            u310[a1] = v3
            v3:Play()
        end

        local function currentBannerId() -- Line: 342 -- upvalues: u1326 (ref), Rift (upval)
            if u1326 and u1326.BannerId then
                return u1326.BannerId
            end
            return (Rift.CurrentBannerId())
        end

        local function viewedBannerId() -- Line: 346 -- upvalues: u1338 (ref), Rift (upval), u1326 (ref)
            local v1 = u1338
            if v1 ~= nil then
                for i, j in Rift.BannerIds() do
                    if j == v1 then
                        return v1
                    end
                end
                u1338 = nil
            end
            if u1326 and u1326.BannerId then
                return u1326.BannerId
            end
            return (Rift.CurrentBannerId())
        end

        local function paintRow(a1, a2, a3) -- Line: 361
            -- upvalues: u325 (val), u1341 (ref), TweenService (upval), u186 (upval)
            local v1 = u325[a1]
            if v1 == nil then
                return
            end
            local v2 = if a2 then 1 else if u1341 ~= a1 then 1 else 0.9
            TweenService:Create(v1, u186, {BackgroundTransparency = v2}):Play()
        end

        local function configFor(a1) -- Line: 370 -- upvalues: Assets (upval) -- types: a1: string
            return Assets.Directory[a1]
        end

        local function pct(a1, a2) -- Line: 374 -- types: a1: number, a2: number
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

        local function petTitles(a1) -- Line: 387 -- types: a1: userdata
            local v1 = {}
            for i, j in a1:GetChildren() do
                if j:IsA("TextLabel") and j.Name == "Title" then
                    table.insert(v1, j)
                end
            end
            table.sort(v1, function(a1, a2) -- Line: 394
                return a1.Position.Y.Scale < a2.Position.Y.Scale
            end)
            return v1[1], v1[2]
        end

        local function foundInText(a1) -- Line: 403
            -- upvalues: RiftRecipes (upval), Areas (upval)
            local v1
            local v2 = if a1 == nil then nil else select(2, RiftRecipes.SpawnChanceOf(a1))
            if (if v2 == nil then nil else Areas.Directory[v2]) == nil then
                return "Found In [???]"
            end
            return (("Found In <font color=\"#%*\">[%*]</font>"):format(v1.Color:ToHex(), v1.DisplayName))
        end

        local function v15() -- Line: 412 -- upvalues: u1329 (val)
            local v1 = 0
            if u1329[1] then
                v1 = v1 + 1
            end
            if u1329[2] then
                v1 = v1 + 1
            end
            if u1329[3] then
                v1 = v1 + 1
            end
            return v1
        end

        local function renderBannerPanel() -- Line: 422
            -- upvalues: u1326 (ref), Rift (upval), u1338 (ref), u190 (upval), EggName (val), EggIcon (val), u728 (val)
            -- upvalues: u157 (upval), pct (val), paintRow (val), setNowBadge (val)
            local BannerId_2, ChanceLabel, EggName_2, ImageLabel, v1, v2, v3, v4, v5, v6, v7, v8, v9
            local BannerId = if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId
            local v10 = u1338
            if v10 ~= nil then
                for i, j in Rift.BannerIds() do
                    if j == v10 then
                        BannerId_2 = v10
                        v10 = Rift.GetBannerEggIcon(BannerId)
                        v6 = v10 == nil and u190[BannerId] or Color3.new(1, 1, 1)
                        EggName.Text = ("%* Banner"):format((Rift.GetBannerDisplayName(BannerId)))
                        if v10 ~= nil then
                            EggIcon.Image = v10
                        end
                        EggIcon.ImageColor3 = v6
                        v6 = Rift.BannerIds()
                        v10 = 0
                        for k, n in v6 do
                            v10 = v10 + Rift.GetBannerWeight(n)
                        end
                        v7 = nil
                        v8 = nil
                        for m, i5 in u728, v7, v8 do
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
                                    v5 = Rift.GetBannerEggIcon(v9)
                                    if v5 ~= nil then
                                        ImageLabel.Image = v5
                                    end
                                    ImageLabel.ImageColor3 = (v5 == nil and u190[v9] or Color3.new(1, 1, 1)):Lerp(u157, v3)
                                end
                                if ChanceLabel then
                                    ChanceLabel.Text = pct(Rift.GetBannerWeight(v9), v10)
                                    ChanceLabel.TextTransparency = v4
                                end
                                if EggName_2 then
                                    v3 = Rift.GetBannerDisplayName(v9)
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
                u1338 = nil
            end
            BannerId_2 = if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId
            v10 = Rift.GetBannerEggIcon(BannerId)
            v6 = v10 == nil and u190[BannerId] or Color3.new(1, 1, 1)
            EggName.Text = ("%* Banner"):format((Rift.GetBannerDisplayName(BannerId)))
            if v10 ~= nil then
                EggIcon.Image = v10
            end
            EggIcon.ImageColor3 = v6
            v6 = Rift.BannerIds()
            v10 = 0
            for i6, i7 in v6 do
                v10 = v10 + Rift.GetBannerWeight(i7)
            end
            v7 = nil
            v8 = nil
            for i8, i9 in u728, v7, v8 do
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
                        v5 = Rift.GetBannerEggIcon(v9)
                        if v5 ~= nil then
                            ImageLabel.Image = v5
                        end
                        ImageLabel.ImageColor3 = (v5 == nil and u190[v9] or Color3.new(1, 1, 1)):Lerp(u157, v3)
                    end
                    if ChanceLabel then
                        ChanceLabel.Text = pct(Rift.GetBannerWeight(v9), v10)
                        ChanceLabel.TextTransparency = v4
                    end
                    if EggName_2 then
                        v3 = Rift.GetBannerDisplayName(v9)
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

        local function renderTimer() -- Line: 478 -- upvalues: Rift (upval), RotateTimer (val)
            local v1 = math.max(math.floor((Rift.SecondsUntilRotation())), 0)
            RotateTimer.RichText = true
            RotateTimer.Text = ("Rotates in: <font color=\"#FFBB10\">%*</font>"):format(if not (v1 >= 3600) then if not (v1 >= 60) then string.format("%ds", v1) else string.format("%dm %02ds", v1 // 60, v1 % 60) else string.format("%dh %02dm", v1 // 3600, v1 % 3600 // 60))
        end

        local ImageLabel = u1263:FindFirstChildWhichIsA("ImageLabel")
        local u1094 = nil
        local u973 = nil
        local u966 = nil
        for i12, i13 in u1263:GetChildren() do
            if not i13:IsA("Frame") then
                if i13:IsA("UIStroke") then
                    v5 = i13:FindFirstChildOfClass("UIGradient")
                    if v5 ~= nil then
                        u966 = v5
                    elseif i13.Color ~= Color3.new(0, 0, 0) then
                        u973 = i13
                    end
                end
            elseif i13.Name == "Frame" then
                u1094 = i13
            elseif i13:IsA("UIStroke") then
                v5 = i13:FindFirstChildOfClass("UIGradient")
                if v5 ~= nil then
                    u966 = v5
                elseif i13.Color ~= Color3.new(0, 0, 0) then
                    u973 = i13
                end
            end
        end

        local function themeForRow(a1) -- Line: 513 -- upvalues: u728 (val) -- types: a1: number
            local v1 = u728[a1]
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

        local function chancesArtNameFor(a1) -- Line: 531 -- upvalues: Rift (upval), u178 (upval) -- types: a1: string
            local v1 = table.clone(Rift.BannerIds())
            table.sort(v1, function(a1, a2) -- Line: 533 -- upvalues: Rift (upval)
                local v1 = Rift.GetBannerWeight(a1)
                local v2 = Rift.GetBannerWeight(a2)
                if v1 == v2 then
                    return a1 < a2
                end
                return v2 < v1
            end)
            local v2 = table.find(v1, a1) or #v1
            return u178[math.min(v2, #u178)]
        end

        local function applyChancesTheme(a1) -- Line: 544
            -- upvalues: Rift (upval), themeForRow (val), TweenService (upval), u1263 (val), u177 (upval)
            -- upvalues: ImageLabel (val), chancesArtNameFor (val), RewardHolder (val), u1094 (ref), PityHolder (val)
            -- upvalues: u973 (ref), Title (val), u966 (ref)
            local v1
            local v2 = table.find(Rift.BannerIds(), a1)
            if (if v2 == nil then nil else themeForRow(v2)) == nil then
                return
            end
            v2 = Color3.new(0, 0, 0)
            local v3 = Color3.new(1, 1, 1)
            local v4 = v1.Base:Lerp(v2, 0.8)
            TweenService:Create(u1263, u177, {BackgroundColor3 = v4}):Play()
            if ImageLabel ~= nil then
                local Attribute = ImageLabel:GetAttribute((chancesArtNameFor(a1)))
                if typeof(Attribute) == "string" and Attribute ~= "" then
                    ImageLabel.Image = Attribute
                end
            end
            local v5 = v1.Base:Lerp(v2, 0.72)
            for i, j in RewardHolder:GetChildren() do
                if j:IsA("Frame") then
                    TweenService:Create(j, u177, {BackgroundColor3 = v5}):Play()
                end
            end
            if u1094 ~= nil then
                TweenService:Create(u1094, u177, {BackgroundColor3 = v1.Base:Lerp(v2, 0.88)}):Play()
            end
            TweenService:Create(PityHolder, u177, {BackgroundColor3 = v1.Base:Lerp(v2, 0.68)}):Play()
            if u973 ~= nil then
                TweenService:Create(u973, u177, {Color = v1.Accent:Lerp(v2, 0.35)}):Play()
            end
            TweenService:Create(Title, u177, {TextColor3 = v1.Accent:Lerp(v3, 0.45)}):Play()
            if u966 ~= nil then
                u966.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, v3),
                    ColorSequenceKeypoint.new(0.38, v1.Accent),
                    ColorSequenceKeypoint.new(0.54, v1.Accent:Lerp(v3, 0.75)),
                    ColorSequenceKeypoint.new(0.75, v1.Accent:Lerp(v3, 0.3)),
                    (ColorSequenceKeypoint.new(1, v1.Accent:Lerp(v2, 0.4))),
                })
            end
        end

        local function ratePerSecondFor(a1) -- Line: 585
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

        local function v16(a1) -- Line: 601 -- upvalues: Rift (upval) -- types: a1: string
            return (("-- %* Chances --"):format((Rift.GetBannerDisplayName(a1))))
        end

        local function renderPetOdds() -- Line: 605
            -- upvalues: u1338 (ref), Rift (upval), u1326 (ref), Title (val), applyChancesTheme (val), u1323 (val)
            -- upvalues: RewardHolder (val), Assets (upval), pct (val), Simple (upval), ratePerSecondFor (val)
            -- upvalues: HoverCard (upval)
            local Amount, AssetId, Attach, BannerId, Cash, DisplayName, Icon, Icon2, v1, v2, v3, v4, v5, v6, v7
            local v8 = u1338
            if v8 ~= nil then
                for i, j in Rift.BannerIds() do
                    if j == v8 then
                        Title.Text = ("-- %* Chances --"):format((Rift.GetBannerDisplayName(v8)))
                        applyChancesTheme(BannerId)
                        v8 = Rift.GetBanner(BannerId)
                        if v8 == nil then
                            return
                        end
                        v4 = table.clone(v8.Pets)
                        table.sort(v4, function(a1, a2) -- Line: 615 -- upvalues: Rift (upval), BannerId (val)
                            local v1 = Rift.GetPetWeight(BannerId, a1.AssetId)
                            return Rift.GetPetWeight(BannerId, a2.AssetId) < v1
                        end)
                        v8 = 0
                        for k, n in v4 do
                            v8 = v8 + Rift.GetPetWeight(BannerId, n.AssetId)
                        end
                        u1323:Clean()
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
                                        Amount.Text = pct(Rift.GetPetWeight(BannerId, v6.AssetId), v8)
                                    end
                                    Cash = v5:FindFirstChild("Cash")
                                    if Cash then
                                        Cash.Text = ("$%*/s"):format((Simple.FormatCompact((ratePerSecondFor(v6.AssetId)))))
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
                                        u1323:Add((Attach(v5, v1)))
                                    end
                                end
                            end
                        end
                        return
                    end
                end
                u1338 = nil
            end
            BannerId = if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId
            Title.Text = ("-- %* Chances --"):format((Rift.GetBannerDisplayName(BannerId)))
            applyChancesTheme(BannerId)
            v8 = Rift.GetBanner(BannerId)
            if v8 == nil then
                return
            end
            v4 = table.clone(v8.Pets)
            table.sort(v4, function(a1, a2) -- Line: 615 -- upvalues: Rift (upval), BannerId (val)
                local v1 = Rift.GetPetWeight(BannerId, a1.AssetId)
                return Rift.GetPetWeight(BannerId, a2.AssetId) < v1
            end)
            v8 = 0
            for i5, i6 in v4 do
                v8 = v8 + Rift.GetPetWeight(BannerId, i6.AssetId)
            end
            u1323:Clean()
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
                            Amount.Text = pct(Rift.GetPetWeight(BannerId, v6.AssetId), v8)
                        end
                        Cash = v5:FindFirstChild("Cash")
                        if Cash then
                            Cash.Text = ("$%*/s"):format((Simple.FormatCompact((ratePerSecondFor(v6.AssetId)))))
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
                            u1323:Add((Attach(v5, v1)))
                        end
                    end
                end
            end
        end

        local function renderPity() -- Line: 660
            -- upvalues: u1326 (ref), PityLabel (val), TweenService (upval), ProgressBar (val), u137 (upval)
            local v1, v2
            PityLabel.Text = ("%*/%*"):format(u1326 and u1326.PityCount or 0, u1326 and u1326.PityThreshold or 50)
            local v3 = if not (v2 > 0) then 0 else math.clamp(v1 / v2, 0, 1)
            TweenService:Create(ProgressBar, u137, {Size = UDim2.new(math.max(v3 * 0.73, 0.012), 0, 1, 0)}):Play()
        end

        local function renderSlots() -- Line: 668
            -- upvalues: u1326 (ref), SacrificeInputs (val), u1329 (val), Assets (upval), foundInText (val), Price (val)
            -- upvalues: u1074 (ref), setBarFilled (val), setOutputProgress (val)
            local Amount, Color, DisplayName, Empty, FoundInWorld, Full, Name, Name_2, Pet, Pet_2, Rarity, v1, v2, v3, v4
            local Requirements = if not u1326 then nil else u1326.Requirements
            for i = 1, 3 do
                v1 = SacrificeInputs:FindFirstChild((("Input%*"):format(i)))
                if v1 ~= nil then
                    Full = v1:FindFirstChild("Full")
                    Empty = v1:FindFirstChild("Empty")
                    if Full and Empty then
                        v2 = Requirements and Requirements[i]
                        v3 = u1329[i]
                        if v3 and v2 and v3.Category ~= v2 then
                            u1329[i] = nil
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
                                Name_2.Text = if not v4 then "???" else not (v4.DisplayName == "") and v4.DisplayName or v2
                            end
                            if Rarity then
                                Rarity.Text = if not v4 then "" else v4.Rarity.DisplayName
                                if v4 and v4.Rarity.Color then
                                    Rarity.TextColor3 = v4.Rarity.Color
                                end
                            end
                            if Pet_2 then
                                Pet_2.Image = v4 and v4.Icon or ""
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
                                DisplayName = not (v4.DisplayName == "") and v4.DisplayName or v3.Category
                                Name.Text = DisplayName
                            end
                            if v1 then
                                v1.Text = v4.Rarity.DisplayName
                                Color = v4.Rarity.Color or v1.TextColor3
                                v1.TextColor3 = Color
                            end
                            if Pet then
                                Pet.Image = v4.Icon or ""
                                Pet.ImageTransparency = 0
                            end
                        end
                    end
                end
            end
            local v5 = 0
            if u1329[1] then
                v5 = v5 + 1
            end
            if u1329[2] then
                v5 = v5 + 1
            end
            if u1329[3] then
                v5 = v5 + 1
            end
            local v6 = 3 - v5
            Price.Text = if v6 ~= 0 then if v6 ~= 1 then ("%* Pets Left"):format(v6) else "1 Pet Left" else "SACRIFICE"
            v6 = u1074
            u1074 = true
            setBarFilled(1, u1329[1] ~= nil, v6)
            setBarFilled(2, u1329[2] ~= nil, v6)
            setBarFilled(3, u1329[3] ~= nil, v6)
            local v7 = 0
            if u1329[1] then
                v7 = v7 + 1
            end
            if u1329[2] then
                v7 = v7 + 1
            end
            if u1329[3] then
                v7 = v7 + 1
            end
            setOutputProgress(v7, v6)
        end

        local u410 = nil

        local function v17() -- Line: 753 -- upvalues: u1326 (ref), u410 (ref), u1335 (ref), u189 (upval)
            if u1326 == nil then
                u410.Text = "REROLL"
                return
            end
            local v1 = u1326.FreeRefreshesRemaining or 0
            if v1 > 0 then
                u410.Text = ("REROLL (%* free)"):format(v1)
                return
            end
            if u1335 then
                u410.Text = ("REROLL %*%*"):format(u189, u1335)
                return
            end
            u410.Text = "REROLL"
        end

        local function renderAll() -- Line: 768
            -- upvalues: renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val)
            -- upvalues: renderSlots (val), u1326 (ref), u410 (ref), u1335 (ref), u189 (upval)
            renderBannerPanel()
            renderTimer()
            renderPetOdds()
            renderPity()
            renderSlots()
            if u1326 == nil then
                u410.Text = "REROLL"
                return
            end
            local v1 = u1326.FreeRefreshesRemaining or 0
            if v1 > 0 then
                u410.Text = ("REROLL (%* free)"):format(v1)
                return
            end
            if u1335 then
                u410.Text = ("REROLL %*%*"):format(u189, u1335)
                return
            end
            u410.Text = "REROLL"
        end

        local function fetchState() -- Line: 777
            -- upvalues: Remotes (upval), u1326 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u410 (ref), u1335 (ref), u189 (upval)
            task.spawn(function() -- Line: 778
                -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval), u1335 (upval)
                -- upvalues: u189 (upval)
                local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                    return Remotes.Rift.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1326 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1326 == nil then
                        u410.Text = "REROLL"
                        return
                    end
                    local v1 = u1326.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u410.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1335 then
                        u410.Text = ("REROLL %*%*"):format(u189, u1335)
                        return
                    end
                    u410.Text = "REROLL"
                end
            end)
        end

        local function showMain() -- Line: 789 -- upvalues: RiftTradeInInventory (val), RiftTradeInMain (val)
            RiftTradeInInventory.Visible = false
            RiftTradeInMain.Visible = true
        end

        local function openPicker(a1) -- Line: 794
            -- upvalues: u1326 (ref), Save (upval), Assets (upval), u1329 (val), FuseKernel (upval), AssetItems (upval)
            -- upvalues: Toast (upval), u142 (upval), u1320 (val), u1343 (ref), petTitles (val), ButtonFX (upval)
            -- upvalues: RiftTradeInInventory (val), RiftTradeInMain (val), renderSlots (val), u1305 (val)
            local Requirements = u1326 and u1326.Requirements
            local u7 = Requirements
            if u7 then
                u7 = Requirements[a1]
            end
            local v1 = Save.Await()
            if u7 ~= nil and v1 ~= nil then
                local err, err_2, success, success_2, v2, v3
                local v4 = Assets.Directory[u7]
                local DisplayName = if not v4 then u7 else if v4.DisplayName == "" then u7 else v4.DisplayName
                local v5 = {}
                local v6 = u1329[1]
                if v6 then
                    v5[v6.Uid] = true
                end
                v6 = u1329[2]
                if v6 then
                    v5[v6.Uid] = true
                end
                v6 = u1329[3]
                if v6 then
                    v5[v6.Uid] = true
                end
                v6 = {}
                for i, j in v1.EquippedAssets do
                    v6[j] = true
                end
                local v7 = {}
                for k, n in v1.Inventory do
                    if not v5[k] and not v6[k] and n.Category == u7 then
                        success, err = pcall(FuseKernel.MayEnterRift, k, n)
                        if success and err == true then
                            success_2, err_2 = pcall(AssetItems.Decode, n)
                            if success_2 then
                                table.insert(v7, {
                                    Uid = k,
                                    Weight = AssetItems.WeightKg(err_2),
                                    Label = AssetItems.WeightLabel(err_2),
                                })
                            end
                        end
                    end
                end
                if #v7 == 0 then
                    Toast.Show({
                        Seconds = 2.5,
                        SingleLine = true,
                        Text = ("You have no spare %* to offer"):format(DisplayName),
                        Color = u142,
                    })
                    return
                end
                table.sort(v7, function(a1, a2) -- Line: 849
                    return a1.Weight < a2.Weight
                end)
                u1320:Clean()
                local v8 = nil
                local v9 = nil
                for m, i5 in v7, v8, v9 do
                    v6 = u1343:Clone()
                    v6.Name = ("Pet_%*"):format(i5.Uid)
                    v6.LayoutOrder = m
                    v6.Visible = true
                    u1320:Add(v6)
                    v5 = v6:FindFirstChild("PetDecal")
                    if v5 and v4 then
                        v5.Image = v4.Icon or ""
                    end
                    v2, v3 = petTitles(v6)
                    if v2 then
                        v2.Text = DisplayName
                    end
                    if v3 then
                        v3.Text = ("(%*)"):format(i5.Label)
                    end
                    u1320:Add((ButtonFX(v6, 1.06, function() -- Line: 873
                        -- upvalues: u1329 (upval), a1 (val), i5 (val), u7 (val), RiftTradeInInventory (upval)
                        -- upvalues: RiftTradeInMain (upval), renderSlots (upval)
                        u1329[a1] = {Uid = i5.Uid, Category = u7}
                        RiftTradeInInventory.Visible = false
                        RiftTradeInMain.Visible = true
                        renderSlots()
                    end)))
                    v6.Parent = u1305
                end
                RiftTradeInMain.Visible = false
                RiftTradeInInventory.Visible = true
                return
            end
        end

        local function v18() -- Line: 885
            -- upvalues: u1332 (ref), u1326 (ref), u1329 (val), Toast (upval), u142 (upval), Save (upval)
            -- upvalues: renderSlots (val), AssetItems (upval), Price (val), Remotes (upval), Tabs (upval)
            -- upvalues: renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val), u410 (ref)
            -- upvalues: u1335 (ref), u189 (upval), RiftSequence (upval), u147 (upval)
            if u1332 then
                return
            end
            local Requirements = u1326 and u1326.Requirements
            if Requirements ~= nil and not (#Requirements < 3) then
                local err, success, v1, v2, v3
                local v4 = 0
                if u1329[1] then
                    v4 = v4 + 1
                end
                if u1329[2] then
                    v4 = v4 + 1
                end
                if u1329[3] then
                    v4 = v4 + 1
                end
                if v4 < 3 then
                    local Show = Toast.Show
                    v1 = {Seconds = 2, SingleLine = true}
                    v2 = 0
                    if u1329[1] then
                        v2 = v2 + 1
                    end
                    if u1329[2] then
                        v2 = v2 + 1
                    end
                    if u1329[3] then
                        v2 = v2 + 1
                    end
                    v1.Text = ("The Rift demands %* more"):format(3 - v2)
                    v1.Color = u142
                    Show(v1)
                    return
                end
                local v5 = Save.Await()
                if v5 == nil then
                    return
                end
                local u98 = {}
                v1 = {}
                for i = 1, 3 do
                    v2 = u1329[i]
                    v3 = v5.Inventory[v2.Uid]
                    if v3 == nil then
                        u1329[i] = nil
                        renderSlots()
                        return
                    end
                    table.insert(u98, v2.Uid)
                    success, err = pcall(AssetItems.Decode, v3)
                    if success then
                        table.insert(v1, err)
                    end
                end
                u1332 = true
                Price.Text = "..."
                local success_2, err_2, v6 = pcall(function() -- Line: 926 -- upvalues: Remotes (upval), u98 (val)
                    return Remotes.Rift.AskTradeIn:InvokeServer(u98)
                end)
                u1332 = false
                if success_2 and err_2 == true then
                    u1329[1] = nil
                    u1329[2] = nil
                    u1329[3] = nil
                    Tabs.Deactivate()
                    task.spawn(function() -- Line: 778
                        -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                        -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval)
                        -- upvalues: u1335 (upval), u189 (upval)
                        local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                            return Remotes.Rift.AskState:InvokeServer()
                        end)
                        if success and typeof(err) == "table" then
                            u1326 = err
                            renderBannerPanel()
                            renderTimer()
                            renderPetOdds()
                            renderPity()
                            renderSlots()
                            if u1326 == nil then
                                u410.Text = "REROLL"
                                return
                            end
                            local v1 = u1326.FreeRefreshesRemaining or 0
                            if v1 > 0 then
                                u410.Text = ("REROLL (%* free)"):format(v1)
                                return
                            end
                            if u1335 then
                                u410.Text = ("REROLL %*%*"):format(u189, u1335)
                                return
                            end
                            u410.Text = "REROLL"
                        end
                    end)
                    RiftSequence.Play(v1, function() -- Line: 948 -- upvalues: Remotes (upval), Toast (upval), u147 (upval)
                        pcall(function() -- Line: 949 -- upvalues: Remotes (upval)
                            Remotes.Rift.AskFinishReveal:InvokeServer()
                        end)
                        Toast.Show({
                            Text = "A Rift Egg joins your eggs!",
                            Seconds = 3.5,
                            SingleLine = true,
                            Color = u147,
                        })
                    end)
                    return
                end
                Toast.Show({
                    Seconds = 3,
                    SingleLine = true,
                    Text = tostring((if not success_2 then "Something went wrong, please try again" else v6) or "The Rift refused the trade"),
                    Color = u142,
                })
                renderSlots()
                return
            end
        end

        local function v19() -- Line: 961
            -- upvalues: u1332 (ref), u1326 (ref), Remotes (upval), renderSlots (val), u410 (ref), u1335 (ref)
            -- upvalues: u189 (upval), Toast (upval), u142 (upval), renderBannerPanel (val), renderTimer (val)
            -- upvalues: renderPetOdds (val), renderPity (val), Storefront (upval), Products (upval)
            if u1332 then
                return
            end
            if not ((u1326 and u1326.FreeRefreshesRemaining or 0) > 0) then
                Storefront.Prompt(Products.Directory.RiftRefresh.ProductId, true)
                return
            end
            u1332 = true
            local success, err, v1, v2 = pcall(function() -- Line: 968 -- upvalues: Remotes (upval)
                return Remotes.Rift.AskRefresh:InvokeServer()
            end)
            u1332 = false
            if success and err == true then
                if u1326 and typeof(v2) == "table" then
                    local v3
                    u1326.Requirements = v2
                    u1326.FreeRefreshesRemaining = math.max(v3 - 1, 0)
                end
                renderSlots()
                if u1326 == nil then
                    u410.Text = "REROLL"
                    return
                end
                local v4 = u1326.FreeRefreshesRemaining or 0
                if v4 > 0 then
                    u410.Text = ("REROLL (%* free)"):format(v4)
                    return
                end
                if u1335 then
                    u410.Text = ("REROLL %*%*"):format(u189, u1335)
                    return
                end
                u410.Text = "REROLL"
                return
            end
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Text = tostring(if not success then "Refresh failed, try again" else v1),
                Color = u142,
            })
            task.spawn(function() -- Line: 778
                -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval), u1335 (upval)
                -- upvalues: u189 (upval)
                local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                    return Remotes.Rift.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1326 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1326 == nil then
                        u410.Text = "REROLL"
                        return
                    end
                    local v1 = u1326.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u410.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1335 then
                        u410.Text = ("REROLL %*%*"):format(u189, u1335)
                        return
                    end
                    u410.Text = "REROLL"
                end
            end)
        end

        local v20 = SacrificeInputs:FindFirstChild("Input1")
        local v21 = v20 and v20:FindFirstChild("Full")
        v20 = v21 and v21:FindFirstChild("Return")
        local v22 = v20 and v20:IsA("ImageButton")
        assert(v22, "RiftTradeIn Input1 has no Return button to clone")
        local v23 = v20:Clone()
        v23.Name = "Refresh"
        v23.AnchorPoint = Vector2.new(0, 0)
        v23.Position = UDim2.fromScale(1.0307, 0.75)
        v23.Size = UDim2.fromScale(0.3962, 0.062)
        v21 = v23:FindFirstChildWhichIsA("TextLabel")
        assert(v21, "Refresh clone lost its label")
        u410 = v21
        u410.Text = "REROLL"
        v23.Parent = RiftTradeInMain
        for i14 = 1, 3 do
            v22 = SacrificeInputs:FindFirstChild((("Input%*"):format(i14)))
            if v22 ~= nil then
                v6 = v22:FindFirstChild("Empty")
                v7 = v22:FindFirstChild("Full")
                v22 = v6 and v6:FindFirstChild("Add")
                v6 = v7 and v7:FindFirstChild("Return")
                if v22 and v22:IsA("GuiButton") then
                    u1317:Add((ButtonFX(v22, 1.08, function() -- Line: 1020 -- upvalues: openPicker (val), i14 (val)
                        openPicker(i14)
                    end)))
                end
                if v6 and v6:IsA("GuiButton") then
                    u1317:Add((ButtonFX(v6, 1.08, function() -- Line: 1025 -- upvalues: u1329 (val), i14 (val), renderSlots (val)
                        u1329[i14] = nil
                        renderSlots()
                    end)))
                end
            end
        end
        u1317:Add((ButtonFX(Sacrifice, 1.05, v18)))
        u1317:Add((ButtonFX(v23, 1.08, v19)))
        u1317:Add((ButtonFX(Close, 1.08, showMain)))

        function v19(a1) -- Line: 1036
            -- upvalues: Rift (upval), u1338 (ref), u1326 (ref), renderBannerPanel (val), renderPetOdds (val)
            local v1 = Rift.BannerIds()[a1]
            if v1 == nil then
                return
            end
            local BannerId = if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId
            u1338 = if v1 ~= BannerId then v1 else nil
            renderBannerPanel()
            renderPetOdds()
        end

        for i15, i16 in u728 do
            v18 = Instance.new("TextButton")
            v18.Name = "SelectHit"
            v18.BackgroundTransparency = 1
            v18.Text = ""
            v18.AutoButtonColor = false
            v18.AnchorPoint = Vector2.new(0.5, 0.5)
            v18.Position = UDim2.fromScale(0.5, 0.5)
            v18.Size = UDim2.fromScale(1, 1)
            v18.ZIndex = 20
            v18.Parent = i16
            u1317:Add(v18)
            u1317:Add((v18.MouseEnter:Connect(function() -- Line: 1058 -- upvalues: u1341 (ref), i15 (val), paintRow (val), Rift (upval), u1338 (ref), u1326 (ref)
                u1341 = i15
                local v1 = paintRow
                local v2 = i15
                local v3 = Rift.BannerIds()[i15]
                local v4 = u1338
                if v4 ~= nil then
                    for i, j in Rift.BannerIds() do
                        if j == v4 then
                            v1(
                                v2,
                                v3 == v4,
                                Rift.BannerIds()[i15] == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId)
                            )
                            return
                        end
                    end
                    u1338 = nil
                end
                v1(
                    v2,
                    v3 == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId),
                    Rift.BannerIds()[i15] == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId)
                )
            end)))
            u1317:Add((v18.MouseLeave:Connect(function() -- Line: 1062 -- upvalues: u1341 (ref), i15 (val), paintRow (val), Rift (upval), u1338 (ref), u1326 (ref)
                if u1341 == i15 then
                    u1341 = nil
                end
                local v1 = paintRow
                local v2 = i15
                local v3 = Rift.BannerIds()[i15]
                local v4 = u1338
                if v4 ~= nil then
                    for i, j in Rift.BannerIds() do
                        if j == v4 then
                            v1(
                                v2,
                                v3 == v4,
                                Rift.BannerIds()[i15] == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId)
                            )
                            return
                        end
                    end
                    u1338 = nil
                end
                v1(
                    v2,
                    v3 == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId),
                    Rift.BannerIds()[i15] == (if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId)
                )
            end)))
            u1317:Add((ButtonFX(v18, 1, function() -- Line: 1068
                -- upvalues: i15 (val), Rift (upval), u1338 (ref), u1326 (ref), renderBannerPanel (val)
                -- upvalues: renderPetOdds (val)
                local v1 = Rift.BannerIds()[i15]
                if v1 == nil then
                    return
                end
                local BannerId = if not u1326 then Rift.CurrentBannerId() else if not u1326.BannerId then Rift.CurrentBannerId() else u1326.BannerId
                u1338 = if v1 ~= BannerId then v1 else nil
                renderBannerPanel()
                renderPetOdds()
            end)))
        end
        Title.TextScaled = true
        Title.TextWrapped = true
        u1317:Add((Tabs.Activated:Connect(function(a1) -- Line: 1076
            -- upvalues: u1338 (ref), u1341 (ref), RiftTradeInInventory (val), RiftTradeInMain (val), Remotes (upval)
            -- upvalues: u1326 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val), renderPity (val)
            -- upvalues: renderSlots (val), u410 (ref), u1335 (ref), u189 (upval)
            if a1 == "RiftTradeIn" then
                u1338 = nil
                u1341 = nil
                RiftTradeInInventory.Visible = false
                RiftTradeInMain.Visible = true
                task.spawn(function() -- Line: 778
                    -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                    -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval)
                    -- upvalues: u1335 (upval), u189 (upval)
                    local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                        return Remotes.Rift.AskState:InvokeServer()
                    end)
                    if success and typeof(err) == "table" then
                        u1326 = err
                        renderBannerPanel()
                        renderTimer()
                        renderPetOdds()
                        renderPity()
                        renderSlots()
                        if u1326 == nil then
                            u410.Text = "REROLL"
                            return
                        end
                        local v1 = u1326.FreeRefreshesRemaining or 0
                        if v1 > 0 then
                            u410.Text = ("REROLL (%* free)"):format(v1)
                            return
                        end
                        if u1335 then
                            u410.Text = ("REROLL %*%*"):format(u189, u1335)
                            return
                        end
                        u410.Text = "REROLL"
                    end
                end)
            end
        end)))
        u1317:Add((Tabs.Deactivated:Connect(function(a1) -- Line: 1084 -- upvalues: RiftTradeInInventory (val), RiftTradeInMain (val) -- types: a1: string
            if a1 == "RiftTradeIn" then
                RiftTradeInInventory.Visible = false
                RiftTradeInMain.Visible = true
            end
        end)))
        Remotes.Rift.BannerRotated.OnClientEvent:Connect(function() -- Line: 1090
            -- upvalues: Remotes (upval), u1326 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u410 (ref), u1335 (ref), u189 (upval)
            task.spawn(function() -- Line: 778
                -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval), u1335 (upval)
                -- upvalues: u189 (upval)
                local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                    return Remotes.Rift.AskState:InvokeServer()
                end)
                if success and typeof(err) == "table" then
                    u1326 = err
                    renderBannerPanel()
                    renderTimer()
                    renderPetOdds()
                    renderPity()
                    renderSlots()
                    if u1326 == nil then
                        u410.Text = "REROLL"
                        return
                    end
                    local v1 = u1326.FreeRefreshesRemaining or 0
                    if v1 > 0 then
                        u410.Text = ("REROLL (%* free)"):format(v1)
                        return
                    end
                    if u1335 then
                        u410.Text = ("REROLL %*%*"):format(u189, u1335)
                        return
                    end
                    u410.Text = "REROLL"
                end
            end)
        end)
        MarketplaceService.PromptProductPurchaseFinished:Connect(function(a1, a2, a3) -- Line: 1094 -- upvalues: Products (upval), fetchState (val) -- types: a2: number, a3: boolean
            if a3 and a2 == Products.Directory.RiftRefresh.ProductId then
                task.delay(1, fetchState)
            end
        end)
        task.spawn(function() -- Line: 1100
            -- upvalues: MarketplaceService (upval), Products (upval), u1335 (ref), u1326 (ref), u410 (ref)
            -- upvalues: u189 (upval)
            local success, err = pcall(function() -- Line: 1101 -- upvalues: MarketplaceService (upval), Products (upval)
                return MarketplaceService:GetProductInfo(Products.Directory.RiftRefresh.ProductId, Enum.InfoType.Product)
            end)
            if success and err and err.PriceInRobux then
                u1335 = err.PriceInRobux
                if u1326 == nil then
                    u410.Text = "REROLL"
                    return
                end
                local v1 = u1326.FreeRefreshesRemaining or 0
                if v1 > 0 then
                    u410.Text = ("REROLL (%* free)"):format(v1)
                    return
                end
                if u1335 then
                    u410.Text = ("REROLL %*%*"):format(u189, u1335)
                    return
                end
                u410.Text = "REROLL"
            end
        end)
        task.spawn(function() -- Line: 1110
            -- upvalues: u1254 (val), renderTimer (val), Rift (upval), u1326 (ref), Remotes (upval)
            -- upvalues: renderBannerPanel (val), renderPetOdds (val), renderPity (val), renderSlots (val), u410 (ref)
            -- upvalues: u1335 (ref), u189 (upval)
            local v1
            while true do
                task.wait(1)
                if u1254.Enabled then
                    renderTimer()
                    v1 = Rift.CurrentBannerId()
                    if u1326 and u1326.BannerId ~= v1 then
                        task.spawn(function() -- Line: 778
                            -- upvalues: Remotes (upval), u1326 (upval), renderBannerPanel (upval), renderTimer (upval)
                            -- upvalues: renderPetOdds (upval), renderPity (upval), renderSlots (upval), u410 (upval)
                            -- upvalues: u1335 (upval), u189 (upval)
                            local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                                return Remotes.Rift.AskState:InvokeServer()
                            end)
                            if success and typeof(err) == "table" then
                                u1326 = err
                                renderBannerPanel()
                                renderTimer()
                                renderPetOdds()
                                renderPity()
                                renderSlots()
                                if u1326 == nil then
                                    u410.Text = "REROLL"
                                    return
                                end
                                local v1 = u1326.FreeRefreshesRemaining or 0
                                if v1 > 0 then
                                    u410.Text = ("REROLL (%* free)"):format(v1)
                                    return
                                end
                                if u1335 then
                                    u410.Text = ("REROLL %*%*"):format(u189, u1335)
                                    return
                                end
                                u410.Text = "REROLL"
                            end
                        end)
                    end
                end
            end
        end)
        Save.Await()
        pcall(function() -- Line: 1124 -- upvalues: u1317 (val), Save (upval), fetchState (val)
            u1317:Add((Save.WatchFields("Rift", fetchState)))
        end)
        task.spawn(function() -- Line: 778
            -- upvalues: Remotes (upval), u1326 (ref), renderBannerPanel (val), renderTimer (val), renderPetOdds (val)
            -- upvalues: renderPity (val), renderSlots (val), u410 (ref), u1335 (ref), u189 (upval)
            local success, err = pcall(function() -- Line: 779 -- upvalues: Remotes (upval)
                return Remotes.Rift.AskState:InvokeServer()
            end)
            if success and typeof(err) == "table" then
                u1326 = err
                renderBannerPanel()
                renderTimer()
                renderPetOdds()
                renderPity()
                renderSlots()
                if u1326 == nil then
                    u410.Text = "REROLL"
                    return
                end
                local v1 = u1326.FreeRefreshesRemaining or 0
                if v1 > 0 then
                    u410.Text = ("REROLL (%* free)"):format(v1)
                    return
                end
                if u1335 then
                    u410.Text = ("REROLL %*%*"):format(u189, u1335)
                    return
                end
                u410.Text = "REROLL"
            end
        end)
        return u1317
    end,
}