-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.StarFeed
-- Decompile time: 43.22 ms

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Buddy = require(script.Parent.Buddy)
local Assets = require(ReplicatedStorage.Data.Assets)
local MountControls = require(script.Parent.MountControls)
local StarConfirmation = require(script.Parent.StarConfirmation)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Fx = require(script.Parent.Fx)
local GUI = require(ReplicatedStorage.Client.GUI)
local Lanes = require(ReplicatedStorage.Client.Notifications.Lanes)
local PetMountFlags = require(ReplicatedStorage.Shared.Flags.PetMountFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SmartProximityPrompt = require(ReplicatedStorage.Client.SmartProximityPrompt)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u101 = Color3.fromRGB(255, 216, 77)
local u106 = Color3.fromRGB(255, 170, 30)
local u111 = Color3.fromRGB(255, 100, 100)
local u116 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u121 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local LocalPlayer = Players.LocalPlayer
local u123 = nil
local u124 = {}
local u125 = {}
local u126 = {}
local u127 = {}
local u128 = {}
local u129 = false
local u130 = false
local u131 = false
local v1 = {}

local function activeAssets() -- Line: 77 -- upvalues: u123 (ref), ReplicatedStorage (val)
    if u123 == nil then
        u123 = require(ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController)
    end
    return u123
end

local function folder() -- Line: 84 -- upvalues: Workspace (val)
    local StarFeedClient = Workspace:FindFirstChild("StarFeedClient")
    if StarFeedClient then
        return StarFeedClient
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "StarFeedClient"
    Folder.Parent = Workspace
    return Folder
end

local function smooth(a1) -- Line: 95 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function holdingStar() -- Line: 100 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    if Character == nil then
        return false
    end
    for i, j in Character:GetChildren() do
        if j:IsA("Tool") and j:GetAttribute("ItemType") == "MountStar" then
            return true
        end
    end
    return false
end

local function mounted() -- Line: 113 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local v1 = false
    if Character ~= nil then
        v1 = Character:FindFirstChild("PetMountSession") ~= nil
    end
    return v1
end

local function eggPromptInView() -- Line: 118 -- upvalues: u125 (val)
    local v1 = nil
    local v2 = nil
    for i in u125, v1, v2 do
        if i.Parent ~= nil and i.Enabled then
            return true
        end
        u125[i] = nil
    end
    return false
end

local function syncRidePrompts() -- Line: 128 -- upvalues: u125 (val), u124 (val), MountControls (val)
    local v1
    local v2 = nil
    local v3 = nil
    for i in u125, v2, v3 do
        if i.Parent == nil or not i.Enabled then
            u125[i] = nil
            continue
        else
            v1 = true
        end
        for j, k in u124 do
            if k.Mode == "Ride" and k.Prompt.Enabled == v1 then
                k.Prompt.Enabled = not v1
            end
        end
        MountControls.Refresh()
        return
    end
    v1 = false
    for n, m in u124 do
        if m.Mode == "Ride" and m.Prompt.Enabled == v1 then
            m.Prompt.Enabled = not v1
        end
    end
    MountControls.Refresh()
end

local function currentMode() -- Line: 138
    -- upvalues: PetMountFlags (val), u129 (ref), Tabs (val), holdingStar (val), LocalPlayer (val)
    if PetMountFlags.Enabled:Get() and not u129 and Tabs.Active() == nil then
        if holdingStar() then
            return "Feed"
        end
        local Character = LocalPlayer.Character
        local v1 = false
        if Character ~= nil then
            v1 = Character:FindFirstChild("PetMountSession") ~= nil
        end
        if not v1 then
            return "Ride"
        end
        return "None"
    end
    return "None"
end

local function displayName(a1) -- Line: 151 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    if v1 and v1.DisplayName then
        return v1.DisplayName
    end
    return a1
end

local function rarityHex(a1) -- Line: 156 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local Color = if not v1 then nil else if not v1.Rarity then nil else v1.Rarity.Color
    if typeof(Color) == "Color3" then
        return (("#%*"):format((Color:ToHex())))
    end
    return "#FFD84D"
end

local function unbind(a1) -- Line: 162 -- upvalues: u124 (val) -- types: a1: string
    local v1 = u124[a1]
    if v1 == nil then
        return
    end
    u124[a1] = nil
    v1.Cleanup()
    v1.Prompt:Destroy()
end

local refresh = nil

local function ride(a1) -- Line: 174 -- upvalues: Remotes (val), Toast (val), u111 (val) -- types: a1: string
    local success, err, v1 = pcall(function() -- Line: 175 -- upvalues: Remotes (upval), a1 (val)
        return Remotes.PetMount.Request:InvokeServer("mount", a1)
    end)
    if success and err == false and typeof(v1) == "string" then
        Toast.Show({Seconds = 2.5, SingleLine = true, Text = v1, Color = u111})
    end
end

local function askToFeed(a1, a2) -- Line: 183
    -- upvalues: u129 (ref), u130 (ref), holdingStar (val), StarConfirmation (val), refresh (ref), Trove (val)
    -- upvalues: TweenService (val), u116 (val), Fx (val), u121 (val), u128 (val), Remotes (val), Toast (val)
    -- upvalues: u111 (val), GUI (val), Tabs (val), PetMountFlags (val), AssetRoster (val), LocalPlayer (val)
    -- upvalues: Save (val)
    if not u129 and not u130 and holdingStar() then
        local v1
        local u10, u11 = StarConfirmation.Resolve(a1, a2)
        u129 = true
        refresh()
        local u17 = Trove.new()
        local Pop = u11:FindFirstChild("Pop")
        Pop.Scale = 0.6
        u11.Visible = true
        u10.Enabled = true
        TweenService:Create(Pop, u116, {Scale = 1}):Play()
        Fx.Sound("BuddyNotice", nil, 0.6)
        local u41 = false

        local function close() -- Line: 200
            -- upvalues: u41 (ref), u17 (val), TweenService (upval), Pop (val), u121 (upval), u129 (upval), u11 (val)
            -- upvalues: u10 (val), refresh (upval)
            if u41 then
                return
            end
            u41 = true
            u17:Destroy()
            local v1 = TweenService:Create(Pop, u121, {Scale = 0.6})
            v1:Play()
            v1.Completed:Once(function() -- Line: 208 -- upvalues: u129 (upval), u11 (upval), u10 (upval)
                if not u129 then
                    u11.Visible = false
                    u10.Enabled = false
                end
            end)
            u129 = false
            refresh()
        end

        local function answer(a1_2) -- Line: 218
            -- upvalues: u41 (ref), u11 (val), close (val), u128 (upval), a1 (val), u130 (upval), Remotes (upval)
            -- upvalues: Toast (upval), u111 (upval)
            if u41 then
                return
            end
            local v1 = u11.AbsolutePosition + u11.AbsoluteSize / 2
            close()
            if not a1_2 then
                return
            end
            u128[a1] = v1
            u130 = true
            task.spawn(function() -- Line: 229
                -- upvalues: Remotes (upval), a1 (upval), u130 (upval), u128 (upval), Toast (upval), u111 (upval)
                local success, err, v1 = pcall(function() -- Line: 230 -- upvalues: Remotes (upval), a1 (upval)
                    local v1 = a1
                    return Remotes.ShootingStar.AskFeed:InvokeServer(v1)
                end)
                u130 = false
                if not success or err ~= true then
                    u128[a1] = nil
                    Toast.Show({
                        Seconds = 2.5,
                        SingleLine = true,
                        Text = if typeof(v1) ~= "string" then "Couldn't feed the Star. Try again." else v1,
                        Color = u111,
                    })
                end
            end)
        end

        for i, j in {Yes = true, No = false, Close = false} do
            v1 = u11.Content:FindFirstChild(i)
            if v1 and v1:IsA("GuiButton") then
                u17:Add((GUI.OnActivated(v1, function() -- Line: 251
                    -- upvalues: j (val), u41 (ref), u11 (val), close (val), u128 (upval), a1 (val), u130 (upval)
                    -- upvalues: Remotes (upval), Toast (upval), u111 (upval)
                    if u41 then
                        return
                    end
                    local v1 = u11.AbsolutePosition + u11.AbsoluteSize / 2
                    close()
                    if not j then
                        return
                    end
                    u128[a1] = v1
                    u130 = true
                    task.spawn(function() -- Line: 229
                        -- upvalues: Remotes (upval), a1 (upval), u130 (upval), u128 (upval), Toast (upval)
                        -- upvalues: u111 (upval)
                        local success, err, v1 = pcall(function() -- Line: 230 -- upvalues: Remotes (upval), a1 (upval)
                            local v1 = a1
                            return Remotes.ShootingStar.AskFeed:InvokeServer(v1)
                        end)
                        u130 = false
                        if not success or err ~= true then
                            u128[a1] = nil
                            Toast.Show({
                                Seconds = 2.5,
                                SingleLine = true,
                                Text = if typeof(v1) ~= "string" then "Couldn't feed the Star. Try again." else v1,
                                Color = u111,
                            })
                        end
                    end)
                end)))
            end
        end
        StarConfirmation.Bind(u10, u11, u17, close)
        u17:Connect(Tabs.Activated, close)
        u17:Connect(PetMountFlags.Enabled.Changed, function() -- Line: 258 -- upvalues: PetMountFlags (upval), close (val)
            if not PetMountFlags.Enabled:Get() then
                close()
            end
        end)
        u17:Connect(AssetRoster.OwnerRefreshed, function(a1_2) -- Line: 261 -- upvalues: LocalPlayer (upval), StarConfirmation (upval), a1 (val), a2 (val)
            if a1_2 == LocalPlayer.UserId then
                StarConfirmation.Resolve(a1, a2)
            end
        end)
        u17:Connect(LocalPlayer.CharacterRemoving, close)
        local Character = LocalPlayer.Character
        if Character then
            u17:Connect(Character.ChildRemoved, function() -- Line: 269 -- upvalues: holdingStar (upval), close (val)
                if not holdingStar() then
                    close()
                end
            end)
        end
        u17:Connect(Save.Watch("Inventory"), function() -- Line: 273 -- upvalues: Save (upval), a1 (val), close (val)
            local v1 = Save.Peek()
            local v2 = v1 and v1.Inventory[a1]
            if not v2 or v2.Rideable or v2.InFuse then
                close()
            end
        end)
        u17:Connect(Save.Watch("EquippedAssets"), function(a1_2) -- Line: 278 -- upvalues: a1 (val), close (val)
            if typeof(a1_2) ~= "table" or not table.find(a1_2, a1) then
                close()
            end
        end)
        return
    end
end

local function bind(a1, a2, a3, a4) -- Line: 283
    -- upvalues: Assets (val), u125 (val), SmartProximityPrompt (val), LocalPlayer (val), askToFeed (val), ride (val)
    -- upvalues: u124 (val)
    local v1
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Name = if a3 ~= "Feed" then "RideMount" else "FeedMountStar"
    ProximityPrompt.ActionText = if a3 ~= "Feed" then "Mount" else "Feed Star"
    local v2 = Assets.Directory[a4]
    local DisplayName = if not v2 then a4 else if not v2.DisplayName then a4 else v2.DisplayName
    ProximityPrompt.ObjectText = DisplayName
    ProximityPrompt.HoldDuration = if a3 ~= "Feed" then 0 else 0.35
    ProximityPrompt.KeyboardKeyCode = if a3 ~= "Feed" then Enum.KeyCode.F else Enum.KeyCode.E
    ProximityPrompt.GamepadKeyCode = if a3 ~= "Feed" then Enum.KeyCode.ButtonY else Enum.KeyCode.ButtonX
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    local v3 = true
    if a3 ~= "Ride" then
        v1 = a2
    else
        local v4 = nil
        local v5 = nil
        for i in u125, v4, v5 do
            if i.Parent == nil or not i.Enabled then
                u125[i] = nil
                continue
            else
                v2 = true
            end
            ProximityPrompt.Enabled = not v2
            v3 = SmartProximityPrompt.AttachToModel(ProximityPrompt, v1, {MaxActivationDistance = 10, TrackDistance = 10, SurfaceOffset = 0.75})
            ProximityPrompt.Triggered:Connect(function(a1_2) -- Line: 299
                -- upvalues: LocalPlayer (upval), a3 (val), askToFeed (upval), a1 (val), a4 (val), ride (upval)
                if a1_2 ~= LocalPlayer then
                    return
                end
                if a3 == "Feed" then
                    askToFeed(a1, a4)
                    return
                end
                ride(a1)
            end)
            u124[a1] = {Mode = a3, Model = v1, Prompt = ProximityPrompt, Cleanup = v3}
            return
        end
        v3 = true
    end
    ProximityPrompt.Enabled = v3
    v3 = SmartProximityPrompt.AttachToModel(ProximityPrompt, v1, {MaxActivationDistance = 10, TrackDistance = 10, SurfaceOffset = 0.75})
    ProximityPrompt.Triggered:Connect(function(a1_2) -- Line: 299
        -- upvalues: LocalPlayer (upval), a3 (val), askToFeed (upval), a1 (val), a4 (val), ride (upval)
        if a1_2 ~= LocalPlayer then
            return
        end
        if a3 == "Feed" then
            askToFeed(a1, a4)
            return
        end
        ride(a1)
    end)
    u124[a1] = {Mode = a3, Model = v1, Prompt = ProximityPrompt, Cleanup = v3}
end

function refresh() -- Line: 312
    -- upvalues: PetMountFlags (val), u129 (ref), Tabs (val), holdingStar (val), LocalPlayer (val), MountControls (val)
    -- upvalues: AssetRoster (val), Save (val), u127 (val), u123 (ref), ReplicatedStorage (val), u124 (val), bind (val)
    -- upvalues: syncRidePrompts (val)
    local v1, v2
    if not PetMountFlags.Enabled:Get() or u129 or Tabs.Active() ~= nil then
        v1 = "None"
    elseif not holdingStar() then
        local Character = LocalPlayer.Character
        v2 = false
        if Character ~= nil then
            v2 = Character:FindFirstChild("PetMountSession") ~= nil
        end
        v1 = if v2 then "None" else "Ride"
    else
        v1 = "Feed"
    end
    MountControls.Refresh()
    v2 = {}
    if v1 ~= "None" then
        local ItemData, v3, v4, v5
        local v6 = AssetRoster.ReadOwnerPen(LocalPlayer.UserId)
        local v7 = nil
        local v8 = nil
        for i, j in v6, v7, v8 do
            ItemData = j.ItemData
            v5 = Save.Peek()
            v3 = v5 and v5.Inventory[i]
            v5 = (v3 or ItemData).Rideable == true
            v4 = v1 == "Feed"
            if v4 ~= v5 and not u127[i] then
                if u123 == nil then
                    u123 = require(ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController)
                end
                v3 = u123.GetModelByUID(i)
                if v3 ~= nil and v3.Parent ~= nil then
                    v2[i] = true
                    v5 = u124[i]
                    if v5 then
                        if v5.Mode ~= v1 or v5.Model ~= v3 then
                            v4 = u124[i]
                            if v4 ~= nil then
                                u124[i] = nil
                                v4.Cleanup()
                                v4.Prompt:Destroy()
                            end
                            v5 = nil
                        end
                    end
                    if v5 == nil then
                        bind(i, v3, v1, ItemData.Category)
                    end
                end
            end
        end
    end
    for k in u124 do
        if not v2[k] then
            v1 = u124[k]
            if v1 ~= nil then
                u124[k] = nil
                v1.Cleanup()
                v1.Prompt:Destroy()
            end
        end
    end
    syncRidePrompts()
end

local function handPoint(a1) -- Line: 349 -- types: a1: userdata
    local v1
    for i, j in {"RightHand", "Right Arm", "Head", "HumanoidRootPart"} do
        v1 = a1:FindFirstChild(j)
        if v1 and v1:IsA("BasePart") then
            return v1.Position
        end
    end
    return nil
end

local function bezier(a1, a2, a3, a4) -- Line: 359 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function shockwave(a1, a2) -- Line: 364
    -- upvalues: u101 (val), Workspace (val), TweenService (val)
    local v1
    local Part = Instance.new("Part")
    Part.Name = "StarFeedShockwave"
    Part.Shape = Enum.PartType.Cylinder
    Part.Material = Enum.Material.Neon
    Part.Color = u101
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 0.15
    Part.Size = Vector3.new(0.25, a2 * 0.4, a2 * 0.4)
    Part.CFrame = (CFrame.new(a1)) * CFrame.Angles(0, 0, 1.5707963267948966)
    local StarFeedClient = Workspace:FindFirstChild("StarFeedClient")
    if not StarFeedClient then
        local Folder = Instance.new("Folder")
        Folder.Name = "StarFeedClient"
        Folder.Parent = Workspace
        v1 = Folder
    else
        v1 = StarFeedClient
    end
    Part.Parent = v1
    v1 = math.max(a2 * 3.2, 14)
    TweenService:Create(
        Part,
        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Transparency = 1, Size = Vector3.new(0.05, v1, v1)}
    ):Play()
    task.delay(0.6, function() -- Line: 385 -- upvalues: Part (val)
        Part:Destroy()
    end)
end

local function banner(a1) -- Line: 390
    -- upvalues: ReplicatedStorage (val), Assets (val), Lanes (val), Fx (val)
    local Assets_2 = ReplicatedStorage:FindFirstChild("Assets")
    local UI = Assets_2 and Assets_2:FindFirstChild("UI")
    local v1 = UI and UI:FindFirstChild("Notifs")
    local GoldenNotif = v1 and v1:FindFirstChild("GoldenNotif")
    if GoldenNotif == nil then
        return
    end
    v1 = GoldenNotif:Clone()
    local Main = v1:FindFirstChild("Main")
    local Content = Main and Main:FindFirstChild("Content")
    if Content and Content:IsA("TextLabel") then
        Content.RichText = true
        local v2 = Assets.Directory[a1]
        local Color = if not v2 then nil else if not v2.Rarity then nil else v2.Rarity.Color
        local v3 = Assets.Directory[a1]
        Content.Text = ("<font color=\"%*\">%*</font> is now a mount!"):format(
            if typeof(Color) ~= "Color3" then "#FFD84D" else ("#%*"):format((Color:ToHex())),
            if not v3 then a1 else if not v3.DisplayName then a1 else v3.DisplayName
        )
    end
    Lanes.Schedule({
        Lane = "Banner",
        Seconds = 4.5,
        UniqueKey = "MountStarFed",
        Frame = v1,
        OnShown = function() -- Line: 411 -- upvalues: Fx (upval)
            Fx.Sound("StarReward", nil, 0.85)
        end,
    })
end

local function play(a1, a2) -- Line: 417
    -- upvalues: u127 (val), u123 (ref), ReplicatedStorage (val), Fx (val), LocalPlayer (val), Workspace (val)
    -- upvalues: handPoint (val), u128 (val), AssetRoster (val), refresh (ref), Trove (val), Buddy (val), u101 (val)
    -- upvalues: shockwave (val), TweenService (val), RunService (val), u106 (val), banner (val)
    if u127[a2] then
        return
    end
    if u123 == nil then
        u123 = require(ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController)
    end
    local u16 = u123.GetModelByUID(a2)
    local Character = a1.Character
    if u16 ~= nil and Character ~= nil and Fx.KitReady() then
        local v1, v2
        local u24 = a1 == LocalPlayer
        local CurrentCamera = Workspace.CurrentCamera
        local BoundingBox, BoundingBox_2 = u16:GetBoundingBox()
        if not u24 and CurrentCamera and 320 < (CurrentCamera.CFrame.Position - BoundingBox.Position).Magnitude then
            return
        end
        local Position = handPoint(Character)
        if not Position then
            Position = BoundingBox.Position
        end
        local v3 = u128[a2]
        u128[a2] = nil
        if u24 and v3 and CurrentCamera then
            local v4 = CurrentCamera:ScreenPointToRay(v3.X, v3.Y)
            Position = v4.Origin + v4.Direction * 6
        end
        v3 = AssetRoster.ReadOwnerPen(a1.UserId)[a2]
        local Category = if not v3 then u16.Name else v3.ItemData.Category
        u127[a2] = true
        if u24 then
            refresh()
        end
        local u93 = Trove.new()
        local Scale = u16:GetScale()
        local u108 = math.max(BoundingBox_2.X, BoundingBox_2.Z, 2)
        local u114 = math.clamp(u108 / 6, 0.7, 2.4)
        u93:Add(function() -- Line: 455 -- upvalues: u16 (val), Scale (val), u127 (upval), a2 (val), u24 (val), refresh (upval)
            if u16.Parent then
                u16:ScaleTo(Scale)
            end
            u127[a2] = nil
            if u24 then
                refresh()
            end
        end)

        local function petCenter() -- Line: 465 -- upvalues: u16 (val)
            local BoundingBox, BoundingBox_2 = u16:GetBoundingBox()
            return BoundingBox.Position, BoundingBox_2
        end

        local Spawn = Buddy.Spawn
        local StarFeedClient = Workspace:FindFirstChild("StarFeedClient")
        if not StarFeedClient then
            local Folder = Instance.new("Folder")
            Folder.Name = "StarFeedClient"
            Folder.Parent = Workspace
            v1 = Folder
        else
            v1 = StarFeedClient
        end
        local u146 = Spawn(v1, CFrame.new(Position))
        u93:Add(u146)
        local PrimaryPart = u146.PrimaryPart
        PrimaryPart.Anchored = true
        local u158 = u146:GetAttribute("HeldScale") or 0.5
        u146:ScaleTo(u158)
        local u166 = Buddy.CalmIdle(u146)
        if u166 then
            u166:Play(0.05)
            u166:SetSpeed(1.6)
            u93:Add(function() -- Line: 480 -- upvalues: u166 (val)
                pcall(function() -- Line: 481 -- upvalues: u166 (upval)
                    u166:Stop(0)
                end)
            end)
        end
        Fx.Emit("Reveal", Position, 0.6)
        Fx.Sound("BuddyBoing", PrimaryPart, 0.75, 1.1)
        Fx.Sound("BuddyGiggle", PrimaryPart, 0.55, 1.2)
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "StarFeedGlow"
        Highlight.FillColor = u101
        Highlight.OutlineColor = Color3.new(1, 1, 1)
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 1
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.Adornee = u16
        local StarFeedClient_2 = Workspace:FindFirstChild("StarFeedClient")
        if not StarFeedClient_2 then
            local Folder_2 = Instance.new("Folder")
            Folder_2.Name = "StarFeedClient"
            Folder_2.Parent = Workspace
            v2 = Folder_2
        else
            v2 = StarFeedClient_2
        end
        Highlight.Parent = v2
        u93:Add(Highlight)
        local u237 = os.clock()
        local u238 = "Flight"
        local u239 = 0
        local u240 = 0
        local u241 = nil
        local u242 = false

        local function burst() -- Line: 508
            -- upvalues: u16 (val), Fx (upval), u114 (val), shockwave (upval), u108 (val), u241 (ref), Highlight (val)
            -- upvalues: u101 (upval), TweenService (upval), u24 (val)
            local BoundingBox, BoundingBox_2 = u16:GetBoundingBox()
            local Position = BoundingBox.Position
            local v1 = BoundingBox_2
            Fx.Sound("StarBurst", u16.PrimaryPart, 1)
            Fx.Emit("Burst", Position, u114)
            Fx.Emit("Impact", Position - Vector3.new(0, v1.Y * 0.45, 0), u114)
            shockwave(Position - Vector3.new(0, v1.Y * 0.45, 0), u108)
            Fx.HitFlash(u16, 0.35)
            if u241 then
                u241:Stop()
            end
            Highlight.FillTransparency = 0.15
            Highlight.OutlineColor = u101
            Highlight.OutlineTransparency = 0
            TweenService:Create(
                Highlight,
                TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {FillTransparency = 1, OutlineTransparency = 1}
            ):Play()
            if u24 then
                Fx.Flash(u101, 0.18, 0.4)
                Fx.FovPunch(8, 0.7)
                Fx.Shake(0.4, 0.7, Position)
                Fx.Grade(u101, 0.3, 1)
            end
        end

        u93:Connect(RunService.RenderStepped, function() -- Line: 534
            -- upvalues: u242 (ref), u16 (val), u93 (val), u237 (ref), u108 (val), u238 (ref), Position (ref)
            -- upvalues: u146 (val), u158 (val), Fx (upval), PrimaryPart (val), u239 (ref), Scale (val), u240 (ref)
            -- upvalues: u114 (val), u241 (ref), u24 (val), Highlight (val), u101 (upval), u106 (upval), burst (val)
            -- upvalues: banner (upval), Category (val)
            local v1, v2, v3, v4, v5, v6
            if u242 then
                return
            end
            if u16.Parent == nil then
                u242 = true
                u93:Destroy()
                return
            end
            local v7 = os.clock()
            local v8 = v7 - u237
            local BoundingBox, BoundingBox_2 = u16:GetBoundingBox()
            local Position_2 = BoundingBox.Position
            local v9 = BoundingBox_2
            local v10 = Position_2 + Vector3.new(0, v9.Y * 0.5 + 1.6, 0)
            local v11 = math.max(u108 * 0.7, 3)
            if u238 == "Flight" then
                v3 = math.clamp(v8 / 0.62, 0, 1)
                v4 = v10 + Vector3.new(v11, 0, 0)
                v5 = (Position + v4) / 2 + Vector3.new(0, 4 + v9.Y * 0.3, 0)
                v1 = Position
                local v12 = math.clamp(v3, 0, 1)
                v2 = v12 * v12 * (3 - v12 * 2)
                v12 = 1 - v2
                v6 = v1 * (v12 * v12) + v5 * (v12 * 2 * v2) + v4 * (v2 * v2)
                v5 = CFrame.Angles(0, v3 * 3.141592653589793 * 4, math.sin(v3 * 3.141592653589793) * 0.6)
                v1 = u146
                local v13 = u158
                v4 = math.clamp(v3 * 2, 0, 1)
                v1:ScaleTo(v13 * (v4 * v4 * (3 - v4 * 2) * 0.65 + 0.35))
                u146:PivotTo((CFrame.new(v6)) * v5)
                if not (v3 >= 1) then
                    return
                end
                u238 = "Swirl"
                u237 = v7
                Fx.Sound("BuddyNotice", PrimaryPart, 0.6, 1.15)
                Fx.Sound("BuddyOrbit", PrimaryPart, 0.7)
                return
            end
            if u238 == "Swirl" then
                v3 = math.clamp(v8 / 1.25, 0, 1)
                v4 = v3 * v3 * (1.6 - v3 * 0.6)
                u239 = v4 * 2.75 * 3.141592653589793 * 2
                v5 = v11 * (1 - v4)
                v6 = v10:Lerp(Position_2, v4)
                v5 = v6 + (Vector3.new(math.cos(u239), 0, (math.sin(u239)))) * v5 + Vector3.new(0, math.sin(u239 * 2) * 0.6 * (1 - v3), 0)
                v1 = if not (0.05 < (v6 - v5).Magnitude) then CFrame.new(v5) else (CFrame.lookAt(v5, v6)) * CFrame.Angles(0, 0, -0.5)
                u146:ScaleTo(u158 * (math.max(0.08, 1 - v4 * 0.85 * v4)))
                u146:PivotTo(v1)
                v2 = u16
                local v14 = Scale
                v1 = math.clamp(v3, 0, 1)
                v2:ScaleTo(v14 * (1 - v1 * v1 * (3 - v1 * 2) * 0.08))
                if u240 <= v7 then
                    u240 = v7 + 0.12
                    Fx.Emit("Collect", v5, 0.35)
                end
                if v3 >= 1 then
                    u238 = "Charge"
                    u237 = v7
                    u146.Parent = nil
                    Fx.Sound("StarHit1", u16.PrimaryPart, 0.9)
                    Fx.Sound("BuddyPop", u16.PrimaryPart, 0.7, 0.9)
                    Fx.Emit("Hit", Position_2, u114)
                    Fx.HitFlash(u16, 0.25)
                    u16:ScaleTo(Scale * 1.14)
                    Fx.Sound("StarCharge", u16.PrimaryPart, 0.85)
                    if u24 then
                        Fx.FovPunch(3, 0.4)
                        return
                    end
                end
                return
            end
            if u238 ~= "Charge" then
                if u238 == "Settle" then
                    v3 = math.clamp(v8 / 0.9, 0, 1)
                    u16:ScaleTo(Scale * ((math.exp(v3 * -6)) * math.cos(v3 * 22) * 0.24 + 1))
                    if v3 >= 1 then
                        u242 = true
                        if u24 then
                            banner(Category)
                        end
                        task.delay(0.6, function() -- Line: 626 -- upvalues: u93 (upval)
                            u93:Destroy()
                        end)
                    end
                end
                return
            end
            v3 = math.clamp(v8 / 1.35, 0, 1)
            v4 = math.max(0, 1 - v8 / 0.25) * 0.14
            v5 = v3 * 34 * v3 + 10
            v6 = (math.sin(v8 * v5)) * (v3 * 0.05 + 0.015)
            u16:ScaleTo(Scale * (v4 + 1 + v6 + v3 * 0.05))
            v1 = Highlight
            v6 = math.clamp(v3, 0, 1)
            v1.FillTransparency = 1 - v6 * v6 * (3 - v6 * 2) * 0.65
            v1 = Highlight
            v4 = math.clamp(v3, 0, 1)
            v1.OutlineTransparency = 1 - v4 * v4 * (3 - v4 * 2)
            Highlight.FillColor = u101:Lerp(u106, (math.sin(v8 * v5 * 0.5)) * 0.5 + 0.5)
            if u240 <= v7 then
                u240 = v7 + math.max(0.08, 0.28 - v3 * 0.2)
                v5 = math.random() * 3.141592653589793 * 2
                v1 = (Vector3.new(math.cos(v5), 0, (math.sin(v5)))) * (u108 * 0.6)
                Fx.Emit("Charge", Position_2 + v1, u114 * 0.6)
            end
            if not (v3 >= 1) then
                return
            end
            u238 = "Settle"
            u237 = v7
            burst()
        end)
        return
    end
end

local function onFed(a1, a2) -- Line: 634
    -- upvalues: LocalPlayer (val), u126 (val), play (val)
    if typeof(a2) ~= "string" then
        return
    end
    if a1 == LocalPlayer then
        u126[a2] = true
    end
    play(a1, a2)
end

local function watchCharacter(a1) -- Line: 644 -- upvalues: refresh (ref) -- types: a1: userdata?
    if a1 == nil then
        return
    end
    a1.ChildAdded:Connect(function(a1) -- Line: 648 -- upvalues: refresh (upval) -- types: a1: userdata
        if a1:IsA("Tool") or a1.Name == "PetMountSession" then
            task.defer(refresh)
        end
    end)
    a1.ChildRemoved:Connect(function(a1) -- Line: 653 -- upvalues: refresh (upval) -- types: a1: userdata
        if a1:IsA("Tool") or a1.Name == "PetMountSession" then
            task.defer(refresh)
        end
    end)
    task.defer(refresh)
end

function v1.Start() -- Line: 665
    -- upvalues: u131 (ref), MountControls (val), u124 (val), currentMode (val), ride (val), Save (val), refresh (ref)
    -- upvalues: Tabs (val), Remotes (val), onFed (val), LocalPlayer (val), watchCharacter (val), AssetRoster (val)
    -- upvalues: u123 (ref), ReplicatedStorage (val), PetMountFlags (val), ProximityPromptService (val), u125 (val)
    -- upvalues: syncRidePrompts (val)
    if u131 then
        return
    end
    u131 = true
    MountControls.Bind(function() -- Line: 670 -- upvalues: u124 (upval)
        return u124
    end, currentMode, ride)
    ;(Save.Watch("Inventory")):Connect(function() -- Line: 671 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    Tabs.Activated:Connect(function() -- Line: 672 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    Tabs.Deactivated:Connect(function() -- Line: 673 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    Remotes.ShootingStar.Fed.OnClientEvent:Connect(onFed)
    LocalPlayer.CharacterAdded:Connect(watchCharacter)
    watchCharacter(LocalPlayer.Character)
    AssetRoster.OwnerRefreshed:Connect(function(a1) -- Line: 677 -- upvalues: LocalPlayer (upval), refresh (upval) -- types: a1: number
        if a1 == LocalPlayer.UserId then
            task.defer(refresh)
        end
    end)
    AssetRoster.SnapshotRefreshed:Connect(function() -- Line: 682 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    task.defer(function() -- Line: 685 -- upvalues: u123 (upval), ReplicatedStorage (upval), refresh (upval)
        if u123 == nil then
            u123 = require(ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController)
        end
        u123.ItemAdded:Connect(function() -- Line: 686 -- upvalues: refresh (upval)
            task.defer(refresh)
        end)
        if u123 == nil then
            u123 = require(ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController)
        end
        u123.ItemRemoved:Connect(function() -- Line: 689 -- upvalues: refresh (upval)
            task.defer(refresh)
        end)
        refresh()
    end)
    PetMountFlags.Enabled.Changed:Connect(function() -- Line: 694 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    ProximityPromptService.PromptShown:Connect(function(a1) -- Line: 697 -- upvalues: u125 (upval), syncRidePrompts (upval) -- types: a1: userdata
        if a1:GetAttribute("PlacedEggPrompt") == true then
            u125[a1] = true
            syncRidePrompts()
        end
    end)
    ProximityPromptService.PromptHidden:Connect(function(a1) -- Line: 703 -- upvalues: u125 (upval), syncRidePrompts (upval) -- types: a1: userdata
        if u125[a1] then
            u125[a1] = nil
            syncRidePrompts()
        end
    end)
end

return v1