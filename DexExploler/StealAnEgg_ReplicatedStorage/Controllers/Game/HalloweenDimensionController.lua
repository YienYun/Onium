-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController
-- Decompile time: 19.90 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaGuiController = require(ReplicatedStorage.Controllers.GUI.AreaGuiController)
local Audio = require(ReplicatedStorage.Shared.Audio)
local BossMastery = require(script.BossMastery)
local BossPortal = require(script.BossPortal)
local ChaseView = require(script.ChaseView)
local ChromaBeacon = require(script.ChromaBeacon)
local EggShop = require(script.EggShop)
local EggHighlights = require(script.EggHighlights)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local HalloweenDimensionEligibility = require(ReplicatedStorage.Shared.Util.HalloweenDimensionEligibility)
local HitFeedback = require(ReplicatedStorage.Controllers.Game.ScrambleClientController.HitFeedback)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local ManorGate = require(script.ManorGate)
local ManorGateTimer = require(script.ManorGateTimer)
local MonsterDeath = require(script.MonsterDeath)
local Music = require(script.Music)
local NightCycle = require(script.NightCycle)
local PumpkinBoss = require(script.PumpkinBoss)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Transition = require(script.Transition)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tutorial = require(script.Tutorial)
local WorldEvents = require(script.WorldEvents)
local LocalPlayer = Players.LocalPlayer
local u142 = Color3.fromRGB(255, 96, 96)
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u148 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u153 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u158 = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local ZoneGradients = ReplicatedStorage.Assets.HalloweenDimension:WaitForChild("ZoneGradients")
local LockedPortal = ReplicatedStorage.Assets.HalloweenDimension:WaitForChild("LockedPortal")
local Label = (ReplicatedStorage.Assets.UI:WaitForChild("Scramble")):WaitForChild("Label")
local v1 = {}

local function child(a1, a2) -- Line: 85 -- types: a1: userdata, a2: string
    local v1 = a1:WaitForChild(a2, 10)
    if v1 == nil then
        error((("HalloweenDimensionUI is missing %*.%*"):format(a1:GetFullName(), a2)))
    end
    return v1
end

local function bindUi(a1) -- Line: 93 -- types: a1: userdata
    local Chase = a1:WaitForChild("Chase", 10)
    if Chase == nil then
        error((("HalloweenDimensionUI is missing %*.Chase"):format((a1:GetFullName()))))
    end
    local Alert = a1:WaitForChild("Alert", 10)
    if Alert == nil then
        error((("HalloweenDimensionUI is missing %*.Alert"):format((a1:GetFullName()))))
    end
    local v1 = {Gui = a1, Chase = Chase}
    local Distance = Chase:WaitForChild("Distance", 10)
    if Distance == nil then
        error((("HalloweenDimensionUI is missing %*.Distance"):format((Chase:GetFullName()))))
    end
    v1.Distance = Distance
    local Vignette = a1:WaitForChild("Vignette", 10)
    if Vignette == nil then
        error((("HalloweenDimensionUI is missing %*.Vignette"):format((a1:GetFullName()))))
    end
    v1.Vignette = Vignette
    local Damage = a1:WaitForChild("Damage", 10)
    if Damage == nil then
        error((("HalloweenDimensionUI is missing %*.Damage"):format((a1:GetFullName()))))
    end
    v1.Damage = Damage
    local Fade = a1:WaitForChild("Fade", 10)
    if Fade == nil then
        error((("HalloweenDimensionUI is missing %*.Fade"):format((a1:GetFullName()))))
    end
    v1.Fade = Fade
    v1.Alert = Alert
    local UIScale = Alert:WaitForChild("UIScale", 10)
    if UIScale == nil then
        error((("HalloweenDimensionUI is missing %*.UIScale"):format((Alert:GetFullName()))))
    end
    v1.AlertScale = UIScale
    local SubAlert = Alert:WaitForChild("SubAlert", 10)
    if SubAlert == nil then
        error((("HalloweenDimensionUI is missing %*.SubAlert"):format((Alert:GetFullName()))))
    end
    v1.SubAlert = SubAlert
    return v1
end

local function isEligible() -- Line: 109 -- upvalues: Save (val), HalloweenDimensionEligibility (val)
    local v1 = Save.Peek()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if type(v1.SpeedPower) == "number" then
            v2 = HalloweenDimensionEligibility.IsEligible(v1.SpeedPower)
        end
    end
    return v2
end

local function finishedTutorial() -- Line: 116 -- upvalues: Save (val)
    local v1 = Save.Peek()
    local Completed = false
    if v1 ~= nil then
        Completed = v1.GuardTutorialProgress.Completed
    end
    return Completed
end

local function dimensionMap() -- Line: 121 -- upvalues: Workspace (val), HalloweenDimension (val)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function zoneAt(a1, a2) -- Line: 126 -- types: a1: userdata, a2: vector
    local v1, v2
    local Zones = a1:FindFirstChild("Zones")
    assert(Zones ~= nil, "Halloween map is missing Zones")
    for i, j in Zones:GetChildren() do
        if j:IsA("BasePart") then
            v1 = j.CFrame:PointToObjectSpace(a2)
            v2 = math.abs(v1.X)
            if not (j.Size.X * 0.5 < v2) then
                v2 = math.abs(v1.Z)
                if not (j.Size.Z * 0.5 < v2) then
                    if j.Name == "SafeZone" then
                        return 0
                    end
                    return (tonumber((string.match(j.Name, "^Zone(%d+)$"))))
                end
            end
        end
    end
    return nil
end

local function beaconOf(a1) -- Line: 144 -- types: a1: userdata?
    local Beacon = if a1 == nil then nil else a1:FindFirstChild("Beacon", true)
    if Beacon ~= nil and Beacon:IsA("Beam") then
        return Beacon
    end
    return nil
end

function v1.Start() -- Line: 153
    -- upvalues: Trove (val), EggHighlights (val), PumpkinBoss (val), LocalPlayer (val), bindUi (val), Workspace (val)
    -- upvalues: GuiService (val), TweenService (val), u148 (val), u153 (val), PlayerAttributes (val)
    -- upvalues: HalloweenDimension (val), ChaseView (val), u142 (val), u158 (val), Audio (val), GhostDogQuest (val)
    -- upvalues: zoneAt (val), ZoneGradients (val), AreaGuiController (val), LightingController (val), Save (val)
    -- upvalues: HalloweenDimensionEligibility (val), LockedPortal (val), HitFeedback (val), Label (val)
    -- upvalues: RunService (val), Remotes (val), Transition (val), ManorGate (val), ManorGateTimer (val)
    -- upvalues: BossPortal (val), EggShop (val), BossMastery (val), MonsterDeath (val), ChromaBeacon (val)
    -- upvalues: WorldEvents (val), Music (val), NightCycle (val), Tutorial (val)
    local u2 = Trove.new()
    local u5 = EggHighlights.new()
    u2:Add(u5.Destroy)
    PumpkinBoss.Start(u2)
    local HalloweenDimensionUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("HalloweenDimensionUI")
    local u25 = bindUi(HalloweenDimensionUI)
    local World = Workspace:WaitForChild("World")
    local u31 = nil
    local u32 = false
    local u33 = nil
    local u34 = false
    local u35 = 0
    local u36 = nil
    local u37 = 0

    local function alert(a1, a2, a3, a4) -- Line: 170
        -- upvalues: u37 (ref), u25 (val), GuiService (upval), TweenService (upval), u148 (upval), u153 (upval)
        local UIStroke
        u37 = u37 + 1
        local u6 = u37
        local u7 = {u25.Alert, u25.SubAlert}
        u25.Alert.Text = a1
        u25.Alert.TextColor3 = a2
        u25.SubAlert.Text = a4 or ""
        u25.Alert.Visible = true
        for i, j in u7 do
            j.TextTransparency = 0
            UIStroke = j:FindFirstChildOfClass("UIStroke")
            if UIStroke ~= nil then
                UIStroke.Transparency = 0
            end
        end
        if not GuiService.ReducedMotionEnabled then
            u25.AlertScale.Scale = 0.6
            TweenService:Create(u25.AlertScale, u148, {Scale = 1}):Play()
        else
            u25.AlertScale.Scale = 1
        end
        task.delay(a3 or 2, function() -- Line: 191 -- upvalues: u6 (val), u37 (upval), u7 (val), TweenService (upval), u153 (upval)
            local UIStroke
            if u6 ~= u37 then
                return
            end
            for i, j in u7 do
                TweenService:Create(j, u153, {TextTransparency = 1}):Play()
                UIStroke = j:FindFirstChildOfClass("UIStroke")
                if UIStroke ~= nil then
                    TweenService:Create(UIStroke, u153, {Transparency = 1}):Play()
                end
            end
        end)
    end

    local function syncChase() -- Line: 205
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), Workspace (upval), HalloweenDimension (upval)
        -- upvalues: u34 (ref), u33 (ref), ChaseView (upval), u25 (val), alert (val)
        if not (LocalPlayer:GetAttribute(PlayerAttributes.Carrying) == true) then
            local u68 = u33
            if u34 and u68 ~= nil then
                u34 = false
                local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.Delivered)
                task.delay(0.35, function() -- Line: 229
                    -- upvalues: u33 (upval), u68 (val), LocalPlayer (upval), PlayerAttributes (upval), Attribute (val)
                    if u33 ~= u68 then
                        return
                    end
                    u33 = nil
                    u68:Finish((LocalPlayer:GetAttribute(PlayerAttributes.Delivered)) ~= Attribute)
                end)
                return
            end
            return
        end
        local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        local v2 = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
        if not u34 and v2 ~= nil then
            u34 = true
            if u33 ~= nil then
                u33:Destroy()
            end
            local new = ChaseView.new
            local v3 = {Chase = u25.Chase, Distance = u25.Distance, Vignette = u25.Vignette}
            local Beacon = if v2 == nil then nil else v2:FindFirstChild("Beacon", true)
            new(v2, v3, alert, if Beacon == nil then nil else if not Beacon:IsA("Beam") then nil else Beacon)
            return
        end
    end

    local function ghostCaught(a1) -- Line: 238
        -- upvalues: alert (val), u142 (upval), u25 (val), TweenService (upval), u158 (upval), Audio (upval)
        alert(a1, u142, 2.2)
        u25.Damage.ImageTransparency = 0.15
        TweenService:Create(u25.Damage, u158, {ImageTransparency = 1}):Play()
        Audio.Play("rbxassetid://131844023775097", script, {Volume = 0.4, PlaybackSpeed = 0.8})
    end

    local function syncZone() -- Line: 245
        -- upvalues: Workspace (upval), HalloweenDimension (upval), LocalPlayer (upval), u32 (ref)
        -- upvalues: GhostDogQuest (upval), u36 (ref), zoneAt (upval), u35 (ref), ZoneGradients (upval)
        -- upvalues: AreaGuiController (upval)
        local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        local v2 = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
        local Character = LocalPlayer.Character
        local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
        if u32 and v2 ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
            if LocalPlayer:GetAttribute(GhostDogQuest.ChaseAttribute) ~= nil then
                u36 = nil
                return
            end
            v1 = zoneAt(v2, HumanoidRootPart.Position)
            if v1 == nil then
                return
            end
            if v1 < u35 then
                local v3 = os.clock()
                v2 = u36 or v3
                u36 = v2
                if 3 <= v3 - v2 then
                    u35 = v1
                    u36 = nil
                end
                return
            end
            u36 = nil
            if v1 == u35 then
                return
            end
            u35 = v1
            local v4 = HalloweenDimension.Zones[v1]
            local v5 = ZoneGradients:FindFirstChild((("Zone%*"):format(v1)))
            local v6 = false
            if v4 ~= nil then
                v6 = v5 ~= nil
            end
            assert(v6, (("Halloween zone %* has no display info"):format(v1)))
            AreaGuiController.Show(v4.DisplayName, v4.Emoji, v5)
            return
        end
    end

    local function syncInside() -- Line: 281
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), u32 (ref), LightingController (upval)
        -- upvalues: HalloweenDimension (upval), u25 (val), HalloweenDimensionUI (val), Workspace (upval), alert (val)
        -- upvalues: syncChase (val), u33 (ref), u34 (ref), u35 (ref)
        local v1
        if LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true == u32 then
            return
        end
        u32 = v1
        if not u32 then
            LightingController.ClearLayer("HalloweenDimension", 0.8)
            if u33 ~= nil then
                u33:Destroy()
                u33 = nil
            end
            u34 = false
            u35 = 0
            task.delay(1, function() -- Line: 320 -- upvalues: u32 (upval), HalloweenDimensionUI (upval)
                if not u32 then
                    HalloweenDimensionUI.Enabled = false
                end
            end)
            return
        end
        if LightingController.Presets[HalloweenDimension.LightingPreset] ~= nil then
            LightingController.SetLayer("HalloweenDimension", HalloweenDimension.LightingPreset, 150, 0.8)
        end
        u25.Chase.Visible = false
        u25.Vignette.ImageTransparency = 1
        u25.Damage.ImageTransparency = 1
        HalloweenDimensionUI.Enabled = true
        local Attribute = Workspace:GetAttribute(HalloweenDimension.Attributes.WorldEventText)
        if type(Attribute) ~= "string" then
            alert("THE CORRUPTED REALM", Color3.fromRGB(255, 150, 60), 2.4)
        else
            alert("THE CORRUPTED REALM", Color3.fromRGB(255, 150, 60), 5, Attribute)
        end
        syncChase()
    end

    local Folder = Instance.new("Folder")
    local u46 = nil

    local function bindPortal(a1) -- Line: 332
        -- upvalues: u31 (ref), u2 (val), World (val), Folder (val)
        u31 = {Model = a1}
        u2:Connect(a1.AncestryChanged, function() -- Line: 336 -- upvalues: u31 (upval), a1 (val), World (upval), Folder (upval)
            local v1 = u31
            if v1 ~= nil and v1.Model == a1 and a1.Parent ~= World and a1.Parent ~= Folder then
                u31 = nil
            end
        end)
    end

    local function refresh() -- Line: 350
        -- upvalues: u31 (ref), Save (upval), HalloweenDimensionEligibility (upval), World (val), Folder (val)
        -- upvalues: u46 (ref), LockedPortal (upval)
        local v1
        local v2 = u31
        local Completed = false
        if v2 ~= nil then
            v1 = Save.Peek()
            Completed = false
            if v1 ~= nil then
                Completed = v1.GuardTutorialProgress.Completed
            end
        end
        local v3 = Save.Peek()
        v1 = false
        if v3 ~= nil then
            v1 = false
            if type(v3.SpeedPower) == "number" then
                v1 = HalloweenDimensionEligibility.IsEligible(v3.SpeedPower)
            end
        end
        if v2 ~= nil then
            v3 = if not Completed then Folder else if not v1 then Folder else World
            if v2.Model.Parent ~= v3 then
                v2.Model.Parent = v3
            end
        end
        v2 = u46
        if Completed and not v1 then
            if v2 ~= nil then
                return
            end
            v3 = LockedPortal:Clone()
            local Status = v3:FindFirstChild("Status", true)
            Status.Text = ("Unlocks at %* speed"):format((HalloweenDimensionEligibility.RequirementText()))
            v3.Parent = World
            u46 = v3
            return
        end
        if v2 ~= nil then
            v2:Destroy()
            u46 = nil
        end
    end

    u2:Connect(World.ChildAdded, function(a1) -- Line: 375
        -- upvalues: u31 (ref), HalloweenDimension (upval), u2 (val), World (val), Folder (val), refresh (val)
        local v1 = u31
        if a1.Name == HalloweenDimension.PortalName and a1:IsA("Model") then
            if v1 == nil or v1.Model ~= a1 then
                u31 = {Model = a1}
                u2:Connect(a1.AncestryChanged, function() -- Line: 336 -- upvalues: u31 (upval), a1 (val), World (upval), Folder (upval)
                    local v1 = u31
                    if v1 ~= nil and v1.Model == a1 and a1.Parent ~= World and a1.Parent ~= Folder then
                        u31 = nil
                    end
                end)
                refresh()
            end
        end
    end)
    local u58 = World:FindFirstChild(HalloweenDimension.PortalName)
    if u58 ~= nil and u58:IsA("Model") then
        u31 = {Model = u58}
        u2:Connect(u58.AncestryChanged, function() -- Line: 336 -- upvalues: u31 (ref), u58 (val), World (val), Folder (val)
            local v1 = u31
            if v1 ~= nil and v1.Model == u58 and u58.Parent ~= World and u58.Parent ~= Folder then
                u31 = nil
            end
        end)
    end
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Inside), syncInside)
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Carrying), function() -- Line: 392 -- upvalues: syncChase (val)
        task.defer(syncChase)
    end)
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Lost), function() -- Line: 395 -- upvalues: alert (val), u142 (upval), Audio (upval)
        alert("YOU LOST YOUR EGG!", u142, 2.2)
        Audio.Play("rbxassetid://131844023775097", script, {Volume = 0.4, PlaybackSpeed = 0.8})
    end)
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Seized), function() -- Line: 399 -- upvalues: ghostCaught (val)
        ghostCaught("THE GHOST TOOK YOUR EGG BACK!")
    end)
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Dropped), function() -- Line: 402 -- upvalues: ghostCaught (val)
        ghostCaught("THE GHOST KNOCKED YOUR EGG AWAY!")
    end)
    u2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Knocked), function() -- Line: 405 -- upvalues: alert (val), u142 (upval), Audio (upval)
        alert("YOUR EGG WAS KNOCKED AWAY!", u142, 2.2)
        Audio.Play("rbxassetid://131844023775097", script, {Volume = 0.4, PlaybackSpeed = 0.8})
    end)
    local u143 = HitFeedback.new(LocalPlayer:WaitForChild("PlayerGui"), Label)
    u2:Add(u143.Destroy)
    u2:Connect(RunService.RenderStepped, u143.Step)
    u2:Connect(Remotes.HalloweenDimension.MonsterHit.OnClientEvent, function(a1, a2) -- Line: 415 -- upvalues: u143 (val) -- types: a1: userdata?, a2: number
        local Parent = if a1 == nil then nil else a1.Parent
        if a1 ~= nil and Parent ~= nil and Parent:IsA("Model") then
            u143.Hit(Parent, a1.Position + Vector3.new(0, a1.Size.Y / 2, 0), a2)
        end
    end)
    local u162 = 0.2
    u2:Connect(RunService.Heartbeat, function(a1) -- Line: 428
        -- upvalues: u162 (ref), refresh (val), syncZone (val), LocalPlayer (upval), u5 (val), Workspace (upval)
        -- upvalues: HalloweenDimension (upval), u32 (ref)
        u162 = u162 + a1
        if u162 >= 0.2 then
            u162 = 0
            refresh()
            syncZone()
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            local Step = u5.Step
            local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
            local v2 = u32
            local Position = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
            Step(if v1 == nil then nil else if not v1:IsA("Model") then nil else v1, v2, Position)
        end
    end)
    Transition.Start(u2)
    ManorGate.Start(u2)
    ManorGateTimer.Start(u2)
    BossPortal.Start(u2)
    EggShop.Start(u2)
    BossMastery.Start(u2)
    MonsterDeath.Start(u2)
    ChromaBeacon.Start(u2)
    WorldEvents.Start(u2)
    Music.Start(u2)
    NightCycle.Start(u2)
    Tutorial.Start(u2)
    syncInside()
    refresh()
    return u2
end

return v1