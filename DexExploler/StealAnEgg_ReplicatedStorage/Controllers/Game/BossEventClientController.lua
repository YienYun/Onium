-- Script path: ReplicatedStorage.Controllers.Game.BossEventClientController
-- Decompile time: 71.58 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local BossEvent = require(ReplicatedStorage.Data.BossEvent)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local Pads = require(ReplicatedStorage.Client.WorldFX.Pads)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local u92 = {
    ARENA_MODEL_NAME = "BossArena",
    PORTAL_MODEL_NAME = "BossArenaTeleport",
    FLOOR_NAME = "Floor",
    BOSS_MODEL_NAME = "Boss",
    OUTLINE_PART_NAME = "Cube.030",
    IN_ARENA_ATTRIBUTE = "InBossArena",
    ATTACKING_ATTRIBUTE = "Attacking",
    SPAWNING_ATTRIBUTE = "Spawning",
    LIGHTING_LAYER = "RiftBoss",
    LIGHTING_RANK = 150,
    LIGHTING_SPAN = 2,
}
u92.FLASH_COLOR = Color3.fromRGB(255, 0, 0)
u92.FLASH_INFO = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u92.BLACK_HOLE_COLOR = Color3.fromRGB(255, 40, 40)
u92.BLACK_HOLE_RADIUS = 20
u92.BLACK_HOLE_THICKNESS = 2
u92.BLACK_HOLE_HOVER = 0.15
u92.BLACK_HOLE_TRANSPARENCY = 0.3
u92.BLACK_HOLE_FADED_TRANSPARENCY = 0.8
u92.BLACK_HOLE_PULSE = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
u92.BLACK_HOLE_START_DELAY = 5
u92.BLACK_HOLE_WINDUP_SECONDS = 4
u92.BLACK_HOLE_RETRACT_SECONDS = 3
u92.BLACK_HOLE_FOLLOW_SPEED_FRACTION = 0.4
u92.BLACK_HOLE_HIT_INTERVAL = 1
u92.VFX_FOLDER_NAME = "BossFightVFX"
u92.DEBRIS_FOLDER_NAME = "Transient"
u92.BLACK_HOLE_VFX_NAME = "BlackholeVFX"
u92.BLACK_HOLE_VFX_ROTATION = CFrame.Angles(0, 0, -1.5707963267948966)
u92.BLACK_HOLE_SPAWN_SOUND_NAME = "Blackhole Spawn"
u92.BLACK_HOLE_LOOP_SOUND_NAME = "Black Hole Loop Sound"
u92.BLACK_HOLE_LOOP_VOLUME = 2.5
u92.GROUND_PROBE_HEIGHT = 50
u92.TURN_SPEED = 3
u92.MUSIC_NAME = "BossArenaMusic"
u92.MUSIC_VOLUME = 0.5
u92.MUSIC_FADE_INFO = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u92.MUSIC_DEFEAT_FADE_INFO = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
u92.UI_NAME = "BossFightUI"
u92.UI_WAIT_SECONDS = 5
u92.COUNTDOWN_UI_NAME = "BossSpawningCountdown"
u92.COUNTDOWN_TEXT_FORMAT = "%s is spawning in: <font color=\"#C500FF\">%d</font>"
u92.BAR_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u92.PHANTOM_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.35)
u92.UI_FLASH_COLOR = Color3.new(1, 1, 1)
u92.UI_FLASH_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u92.UI_SHAKE_SECONDS = 0.3
u92.UI_SHAKE_PIXELS = 6
u92.BOSS_SPAWN_NAME = "BossSpawn"
u92.PHASE_TWO_AT_ATTRIBUTE = "PhaseTwoAt"
u92.HAND_BONE_NAME = "UpperHand1.R"
u92.HEALTH_GUI_NAME = "Health"
u92.ARM_HITS_ATTRIBUTE = "BossArmHits"
u92.ARM_BEAM_HIT_LIMIT = 5
u92.EXTRA_FOLDER_NAME = "Extra"
u92.GUIDE_BEAM_NAME = "TutorialBeam"
u92.SHOP_STAND_NAME = "BossShopStand"
u92.SHOP_ZONE_NAME = "Zone"
u92.SHOP_TAB_NAME = "BossShop"
u92.SHOP_BEAM_LIFT = 4
u92.CRYSTAL_FOLDER_NAME = "CrystalTowers"
u92.CRYSTAL_HITBOX_NAME = "Hitbox"
u92.CRYSTAL_HEALTH_ATTRIBUTE = "Health"
u92.CRYSTAL_HITS_ATTRIBUTE = "BossCrystalHits"
u92.CRYSTAL_BEAM_HIT_LIMIT = 5
u92.CRYSTAL_HINT_DELAY = 60
u92.CRYSTAL_HINT_MESSAGE = "Use your bat to destroy the crystals!"
u92.CRYSTAL_HINT_SECONDS = 5
u92.CRYSTAL_HINT_COLOR = Color3.fromRGB(162, 0, 255)
u92.HAZARD_FOLDER_NAME = "BossHazards"
u92.HAZARD_COLOR = Color3.fromRGB(255, 40, 40)
u92.HAZARD_THICKNESS = 2
u92.HAZARD_HOVER = 0.15
u92.HAZARD_TRANSPARENCY = 0.2
u92.HAZARD_TOUCH_PADDING = 2
u92.HAZARD_JUMP_CLEARANCE = 4
u92.HAZARD_REPORT_INTERVAL = 1
u92.HAZARD_GAP_SECONDS = 2
u92.HAZARD_START_DELAY_SECONDS = 5
u92.HAZARD_INDICATOR_THICKNESS = 0.6
u92.HAZARD_INDICATOR_TRANSPARENCY = 0.7
u92.HAZARD_PULSE = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
u92.X_KIND = "RotatingX"
u92.X_BAR_COUNT = 2
u92.X_TELEGRAPH_SECONDS = 2
u92.X_GROW_SECONDS = 1
u92.X_ACTIVE_SECONDS = 15
u92.X_DEGREES_PER_SECOND = 20
u92.RING_KIND = "ExpandingRing"
u92.RING_SEGMENTS = 32
u92.RING_COUNT = 5
u92.RING_SPAWN_INTERVAL = 3
u92.RING_SPEED = 40
u92.RING_FADE_SECONDS = 0.75
u92.HAZARD_MIN_LENGTH = 0.05
u92.BLACK_HOLE_LOOP_RISE_INFO = TweenInfo.new(u92.BLACK_HOLE_WINDUP_SECONDS, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
u92.BLACK_HOLE_LOOP_DRAIN_INFO = TweenInfo.new(u92.BLACK_HOLE_RETRACT_SECONDS, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
return {
    Start = function() -- Line: 198
        -- upvalues: Players (val), u92 (val), ReplicatedStorage (val), Workspace (val), Trove (val), TweenService (val)
        -- upvalues: VFX (val), BossEvent (val), RunService (val), HiddenUIHandler (val), Remotes (val), Player (val)
        -- upvalues: Notifications (val), Pads (val), Tabs (val), LightingController (val), SoundService (val)
        -- upvalues: Save (val), BossEventFlags (val), RiftEligibility (val), RiftFlags (val)
        local LocalPlayer = Players.LocalPlayer
        local u8 = script:WaitForChild(u92.MUSIC_NAME, 10)
        local u9 = nil
        local u17 = ReplicatedStorage.Assets.Particles:WaitForChild(u92.VFX_FOLDER_NAME)
        local u23 = Workspace:WaitForChild(u92.DEBRIS_FOLDER_NAME)
        local u28 = u17:FindFirstChild(u92.BLACK_HOLE_VFX_NAME)
        local v1 = false
        if u28 ~= nil then
            v1 = u28:IsA("Attachment")
        end
        assert(v1, (("%* needs a %* Attachment"):format(u92.VFX_FOLDER_NAME, u92.BLACK_HOLE_VFX_NAME)))
        local u56 = (ReplicatedStorage.Assets:WaitForChild(u92.EXTRA_FOLDER_NAME)):FindFirstChild(u92.GUIDE_BEAM_NAME)
        local v2 = false
        if u56 ~= nil then
            v2 = u56:IsA("Beam")
        end
        assert(v2, (("%* needs a %* Beam"):format(u92.EXTRA_FOLDER_NAME, u92.GUIDE_BEAM_NAME)))
        local u75 = Trove.new()
        local u78 = Trove.new()
        local u81 = Trove.new()
        local u82 = nil
        local u83 = {}
        local u84 = nil
        local u85 = nil
        local u86 = nil
        local u87 = nil
        local u88 = nil
        local u89 = nil
        local u90 = nil
        local u91 = nil
        local u92_2 = nil
        local u93 = -1
        local u94 = {}
        local u95 = {}
        local u96 = {}
        local u97 = Vector3.new(0, 0, 0)
        local u98 = nil
        local u99 = nil
        local u100 = nil
        local u101 = nil
        local u102 = nil
        local u103 = nil
        local u104 = nil
        local u105 = false
        local u106 = nil
        local u107 = nil
        local u108 = nil
        local u109 = 0
        local u110 = false
        local u111 = false
        local u112 = 0
        local u113 = 0
        local u114 = 0
        local u115 = 0
        local u116 = 0
        local u117 = 0
        local u118 = nil
        local u119 = nil
        local u120 = (1 / 0)
        local u121 = 0
        local u122 = nil
        local u123 = nil
        local u124 = nil

        local function fadeMusic(a1, a2, a3) -- Line: 268
            -- upvalues: u9 (ref), TweenService (upval), u8 (val), u92 (upval)
            local v1 = u9
            if v1 ~= nil then
                v1:Cancel()
            end
            v1 = TweenService
            local MUSIC_FADE_INFO = a3 or u92.MUSIC_FADE_INFO
            v1 = v1:Create(u8, MUSIC_FADE_INFO, {Volume = a1})
            u9 = v1
            if a2 then
                v1.Completed:Once(function(a1) -- Line: 277 -- upvalues: u8 (upval)
                    if a1 == Enum.PlaybackState.Completed then
                        u8:Stop()
                    end
                end)
            end
            v1:Play()
        end

        local function startMusic() -- Line: 288 -- upvalues: u8 (val), u9 (ref), u92 (upval)
            if u8.IsPlaying then
                return
            end
            local v1 = u9
            if v1 ~= nil then
                v1:Cancel()
                u9 = nil
            end
            u8.Volume = u92.MUSIC_VOLUME
            u8:Play()
        end

        local function stopMusic() -- Line: 301 -- upvalues: u8 (val), fadeMusic (val)
            if not u8.IsPlaying then
                return
            end
            fadeMusic(0, true)
        end

        local function playVfx(a1, a2) -- Line: 311
            -- upvalues: u17 (val), u92 (upval), u23 (val), VFX (upval)
            local v1
            local v2 = u17:FindFirstChild(a1)
            local v3 = ("%* needs %*"):format(u92.VFX_FOLDER_NAME, a1)
            assert(v2 ~= nil, v3)
            local v4 = v2:Clone()
            for i, j in v4:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = false
                end
            end
            if v4:IsA("BasePart") then
                v1 = ("%* is a part and plays at a CFrame"):format(a1)
                assert(typeof(a2) == "CFrame", v1)
                v4.Anchored = true
                v4.CanCollide = false
                v4.CanQuery = false
                v4.CanTouch = false
                v4.CFrame = a2
                v4.Parent = u23
            elseif not v4:IsA("Attachment") then
                error((("%* must be a BasePart or an Attachment"):format(a1)))
            else
                v1 = ("%* is an attachment and plays on a part"):format(a1)
                assert(typeof(a2) == "Instance", v1)
                v4.Parent = a2
            end
            VFX.Discard(v4, VFX.EmitTree(v4, true))
        end

        local function uiChild(a1, a2, a3) -- Line: 339 -- types: a1: userdata, a2: string, a3: string
            local v1 = a1:FindFirstChild(a2)
            local v2 = false
            if v1 ~= nil then
                v2 = v1:IsA(a3)
            end
            assert(v2, (("%* is missing the %* %*"):format(a1:GetFullName(), a3, a2)))
            return v1
        end

        local function findUi() -- Line: 345 -- upvalues: LocalPlayer (val), u92 (upval), BossEvent (upval)
            local v1 = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild(u92.UI_NAME, u92.UI_WAIT_SECONDS)
            local v2 = false
            if v1 ~= nil then
                v2 = v1:IsA("ScreenGui")
            end
            assert(v2, (("PlayerGui is missing the %* ScreenGui"):format(u92.UI_NAME)))
            local v3 = v1:FindFirstChild("BossHPBar")
            v2 = false
            if v3 ~= nil then
                v2 = v3:IsA("Frame")
            end
            assert(v2, (("%* is missing the Frame BossHPBar"):format((v1:GetFullName()))))
            local BarHolder = v3:FindFirstChild("BarHolder")
            local v4 = false
            if BarHolder ~= nil then
                v4 = BarHolder:IsA("Frame")
            end
            assert(v4, (("%* is missing the Frame BarHolder"):format((v3:GetFullName()))))
            local BarBG = BarHolder:FindFirstChild("BarBG")
            local v5 = false
            if BarBG ~= nil then
                v5 = BarBG:IsA("CanvasGroup")
            end
            assert(v5, (("%* is missing the CanvasGroup BarBG"):format((BarHolder:GetFullName()))))
            local BossName = v3:FindFirstChild("BossName")
            local v6 = false
            if BossName ~= nil then
                v6 = BossName:IsA("TextLabel")
            end
            assert(v6, (("%* is missing the TextLabel BossName"):format((v3:GetFullName()))))
            BossName.Text = BossEvent.BossName
            v5 = {}
            v6 = {}
            for i, j in v1:GetDescendants() do
                if not j:IsA("UIStroke") then
                    if j:IsA("Frame") and j.Name == "Line" then
                        v6[j] = j.BackgroundColor3
                    end
                elseif j.Color == Color3.new(0, 0, 0) then
                    v5[j] = j.Color
                elseif j:IsA("Frame") and j.Name == "Line" then
                    v6[j] = j.BackgroundColor3
                end
            end
            local v7 = {Gui = v1}
            local Bar = BarBG:FindFirstChild("Bar")
            local v8 = false
            if Bar ~= nil then
                v8 = Bar:IsA("Frame")
            end
            assert(v8, (("%* is missing the Frame Bar"):format((BarBG:GetFullName()))))
            v7.Bar = Bar
            local PhantomBar = BarBG:FindFirstChild("PhantomBar")
            v8 = false
            if PhantomBar ~= nil then
                v8 = PhantomBar:IsA("Frame")
            end
            assert(v8, (("%* is missing the Frame PhantomBar"):format((BarBG:GetFullName()))))
            v7.PhantomBar = PhantomBar
            local HealthAmount = BarHolder:FindFirstChild("HealthAmount")
            v8 = false
            if HealthAmount ~= nil then
                v8 = HealthAmount:IsA("TextLabel")
            end
            assert(v8, (("%* is missing the TextLabel HealthAmount"):format((BarHolder:GetFullName()))))
            v7.HealthAmount = HealthAmount
            local Frame = v3:FindFirstChild("Frame")
            local v9 = false
            if Frame ~= nil then
                v9 = Frame:IsA("Frame")
            end
            assert(v9, (("%* is missing the Frame Frame"):format((v3:GetFullName()))))
            local v10 = Frame:FindFirstChild("TimerLabel")
            v9 = false
            if v10 ~= nil then
                v9 = v10:IsA("TextLabel")
            end
            assert(v9, (("%* is missing the TextLabel TimerLabel"):format((Frame:GetFullName()))))
            v7.TimerLabel = v10
            v10 = {}
            local BGDecor = v3:FindFirstChild("BGDecor")
            local v11 = false
            if BGDecor ~= nil then
                v11 = BGDecor:IsA("Frame")
            end
            assert(v11, (("%* is missing the Frame BGDecor"):format((v3:GetFullName()))))
            v10[1] = BarHolder
            v10[2] = BossName
            v10[3] = BGDecor
            v7.FightOnly = v10
            v7.Shaker = v3
            v7.ShakerPosition = v3.Position
            v7.Strokes = v5
            v7.Lines = v6
            return v7
        end

        local function setHealth(a1, a2, a3) -- Line: 386
            -- upvalues: u118 (ref), u120 (ref), u111 (ref), fadeMusic (val), u92 (upval), TweenService (upval)
            local v1 = u118
            if v1 ~= nil and not (a2 <= 0) then
                u120 = a1
                if a1 <= 0 and not u111 then
                    u111 = true
                    fadeMusic(0, true, u92.MUSIC_DEFEAT_FADE_INFO)
                end
                local v2 = UDim2.fromScale(math.clamp(a1 / a2, 0, 1), 1)
                v1.HealthAmount.Text = ("%* / %* HP"):format(math.max(math.ceil(a1), 0), (math.ceil(a2)))
                if not a3 then
                    v1.Bar.Size = v2
                    v1.PhantomBar.Size = v2
                    return
                end
                TweenService:Create(v1.Bar, u92.BAR_INFO, {Size = v2}):Play()
                TweenService:Create(v1.PhantomBar, u92.PHANTOM_INFO, {Size = v2}):Play()
                return
            end
        end

        local function flashUi() -- Line: 411
            -- upvalues: u118 (ref), u92 (upval), TweenService (upval), u119 (ref), RunService (upval)
            local UI_FLASH_INFO, UI_FLASH_INFO_2, v1
            local u0 = u118
            if u0 == nil then
                return
            end
            for i, j in u0.Strokes do
                i.Color = u92.UI_FLASH_COLOR
                v1 = TweenService
                UI_FLASH_INFO_2 = u92.UI_FLASH_INFO
                v1:Create(i, UI_FLASH_INFO_2, {Color = j}):Play()
            end
            for k, n in u0.Lines do
                k.BackgroundColor3 = u92.UI_FLASH_COLOR
                v1 = TweenService
                UI_FLASH_INFO = u92.UI_FLASH_INFO
                v1:Create(k, UI_FLASH_INFO, {BackgroundColor3 = n}):Play()
            end
            local v2 = u119
            if v2 ~= nil then
                v2:Disconnect()
            end
            local u26 = 0
            local u27 = nil
            u27 = RunService.Heartbeat:Connect(function(a1) -- Line: 431 -- upvalues: u26 (ref), u92 (upval), u27 (ref), u0 (val) -- types: a1: number
                u26 = math.min(u26 + a1, u92.UI_SHAKE_SECONDS)
                local v1 = u26
                if u92.UI_SHAKE_SECONDS <= v1 then
                    u27:Disconnect()
                    u0.Shaker.Position = u0.ShakerPosition
                    return
                end
                v1 = u92.UI_SHAKE_PIXELS * (1 - u26 / u92.UI_SHAKE_SECONDS)
                u0.Shaker.Position = u0.ShakerPosition + UDim2.fromOffset((math.random() - 0.5) * 2 * v1, (math.random() - 0.5) * 2 * v1)
            end)
            u119 = u27
        end

        local function findCountdownUi() -- Line: 447 -- upvalues: u124 (ref), LocalPlayer (val), u92 (upval)
            local v1 = u124
            if v1 ~= nil then
                return v1.Gui, v1.Content
            end
            local v2 = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild(u92.COUNTDOWN_UI_NAME, u92.UI_WAIT_SECONDS)
            local v3 = false
            if v2 ~= nil then
                v3 = v2:IsA("ScreenGui")
            end
            assert(v3, (("PlayerGui is missing the %* ScreenGui"):format(u92.COUNTDOWN_UI_NAME)))
            v1 = v2:FindFirstChild("Main")
            v3 = false
            if v1 ~= nil then
                v3 = v1:IsA("Frame")
            end
            assert(v3, (("%* is missing the Frame Main"):format((v2:GetFullName()))))
            local Content = v1:FindFirstChild("Content")
            local v4 = false
            if Content ~= nil then
                v4 = Content:IsA("TextLabel")
            end
            assert(v4, (("%* is missing the TextLabel Content"):format((v1:GetFullName()))))
            u124 = {Gui = v2, Content = Content}
            return v2, Content
        end

        local function stepCountdown() -- Line: 464
            -- upvalues: findCountdownUi (val), u122 (ref), Workspace (upval), u123 (ref), HiddenUIHandler (upval)
            -- upvalues: u92 (upval), BossEvent (upval)
            local v1, v2 = findCountdownUi()
            local v3 = u122
            local v4 = if v3 == nil then 0 else v3 - Workspace:GetServerTimeNow()
            if not (v4 <= 0) then
                if HiddenUIHandler.IsHidden() then
                    v1.Enabled = false
                    return
                end
                v2.Text = string.format(u92.COUNTDOWN_TEXT_FORMAT, BossEvent.BossName, (math.ceil(v4)))
                v1.Enabled = true
                return
            end
            v1.Enabled = false
            u122 = nil
            v3 = u123
            if v3 ~= nil then
                u123 = nil
                v3:Disconnect()
            end
        end

        local function setSpawnCountdown(a1) -- Line: 486
            -- upvalues: u122 (ref), u123 (ref), RunService (upval), stepCountdown (val)
            u122 = a1
            if a1 ~= nil and u123 == nil then
                RunService.Heartbeat:Connect(function() -- Line: 489 -- upvalues: stepCountdown (upval)
                    stepCountdown()
                end)
            end
            stepCountdown()
        end

        local function applySnapshot(a1) -- Line: 496
            -- upvalues: u121 (ref), u122 (ref), u123 (ref), RunService (upval), stepCountdown (val), u118 (ref)
            -- upvalues: u120 (ref), u111 (ref), fadeMusic (val), u92 (upval)
            u121 = a1.ClosesAt
            local BossSpawnsAt = a1.BossSpawnsAt
            u122 = BossSpawnsAt
            if BossSpawnsAt ~= nil and u123 == nil then
                RunService.Heartbeat:Connect(function() -- Line: 489 -- upvalues: stepCountdown (upval)
                    stepCountdown()
                end)
            end
            stepCountdown()
            local BossHealth = a1.BossHealth
            local BossMaxHealth = a1.BossMaxHealth
            if BossHealth ~= nil and BossMaxHealth ~= nil then
                local v1 = u118
                if v1 ~= nil then
                    if BossMaxHealth <= 0 then
                        return
                    end
                    u120 = BossHealth
                    if BossHealth <= 0 and not u111 then
                        u111 = true
                        fadeMusic(0, true, u92.MUSIC_DEFEAT_FADE_INFO)
                    end
                    local v2 = UDim2.fromScale(math.clamp(BossHealth / BossMaxHealth, 0, 1), 1)
                    v1.HealthAmount.Text = ("%* / %* HP"):format(math.max(math.ceil(BossHealth), 0), (math.ceil(BossMaxHealth)))
                    v1.Bar.Size = v2
                    v1.PhantomBar.Size = v2
                end
            end
        end

        local function stepUi() -- Line: 508
            -- upvalues: u118 (ref), u87 (ref), u111 (ref), u92 (upval), u8 (val), u9 (ref), u121 (ref)
            -- upvalues: Workspace (upval)
            local v1 = u118
            if v1 == nil then
                return
            end
            local v2 = u87
            local v3 = u111
            if not v3 then
                v3 = false
                if v2 ~= nil then
                    v3 = not v2.Model:GetAttribute(u92.SPAWNING_ATTRIBUTE)
                end
            end
            if v1.Gui.Enabled ~= v3 then
                v1.Gui.Enabled = v3
            end
            if not v3 then
                return
            end
            v3 = not u111
            for i, j in v1.FightOnly do
                if j.Visible ~= v3 then
                    j.Visible = v3
                end
            end
            if not u111 and not u8.IsPlaying then
                v3 = u9
                if v3 ~= nil then
                    v3:Cancel()
                    u9 = nil
                end
                u8.Volume = u92.MUSIC_VOLUME
                u8:Play()
            end
            v2 = math.max(math.floor(u121 - (Workspace:GetServerTimeNow())), 0)
            v1.TimerLabel.Text = string.format("%02d:%02d", v2 // 60, v2 % 60)
        end

        local function showUi() -- Line: 545
            -- upvalues: findUi (val), u118 (ref), u75 (val), u119 (ref), u120 (ref), Remotes (upval), u121 (ref)
            -- upvalues: u122 (ref), u123 (ref), RunService (upval), stepCountdown (val), u111 (ref), fadeMusic (val)
            -- upvalues: u92 (upval), stepUi (val), flashUi (val), setHealth (val), applySnapshot (val)
            local u1 = findUi()
            u118 = u1
            u75:Add(function() -- Line: 548 -- upvalues: u119 (upval), u118 (upval), u120 (upval), u1 (val)
                local v1 = u119
                if v1 ~= nil then
                    v1:Disconnect()
                    u119 = nil
                end
                u118 = nil
                u120 = (1 / 0)
                u1.Gui.Enabled = false
                for i, j in u1.FightOnly do
                    j.Visible = true
                end
            end)
            local v1 = Remotes.BossEvent.AskSnapshot:InvokeServer()
            u121 = v1.ClosesAt
            local BossSpawnsAt = v1.BossSpawnsAt
            u122 = BossSpawnsAt
            if BossSpawnsAt ~= nil and u123 == nil then
                RunService.Heartbeat:Connect(function() -- Line: 489 -- upvalues: stepCountdown (upval)
                    stepCountdown()
                end)
            end
            stepCountdown()
            local BossHealth = v1.BossHealth
            local BossMaxHealth = v1.BossMaxHealth
            if BossHealth ~= nil and BossMaxHealth ~= nil then
                local v2 = u118
                if v2 ~= nil and not (BossMaxHealth <= 0) then
                    u120 = BossHealth
                    if BossHealth <= 0 and not u111 then
                        u111 = true
                        fadeMusic(0, true, u92.MUSIC_DEFEAT_FADE_INFO)
                    end
                    local v3 = UDim2.fromScale(math.clamp(BossHealth / BossMaxHealth, 0, 1), 1)
                    v2.HealthAmount.Text = ("%* / %* HP"):format(math.max(math.ceil(BossHealth), 0), (math.ceil(BossMaxHealth)))
                    v2.Bar.Size = v3
                    v2.PhantomBar.Size = v3
                end
            end
            stepUi()
            u75:Connect(Remotes.BossEvent.HealthShifted.OnClientEvent, function(a1, a2) -- Line: 567
                -- upvalues: u120 (upval), flashUi (upval), setHealth (upval)
                if a1 < u120 then
                    flashUi()
                end
                setHealth(a1, a2, true)
            end)
            u75:Connect(Remotes.BossEvent.StateShifted.OnClientEvent, applySnapshot)
        end

        local function findBoss(a1) -- Line: 577 -- upvalues: u92 (upval) -- types: a1: userdata
            local v1 = a1:WaitForChild(u92.BOSS_MODEL_NAME, 10)
            if v1 ~= nil and v1:IsA("Model") then
                local v2 = v1:WaitForChild(u92.OUTLINE_PART_NAME, 10)
                local v3 = false
                if v2 ~= nil then
                    v3 = v2:IsA("BasePart")
                end
                assert(v3, (("%* needs its %* outline part"):format(u92.BOSS_MODEL_NAME, u92.OUTLINE_PART_NAME)))
                local PrimaryPart = v1.PrimaryPart
                local v4 = ("%* needs a PrimaryPart"):format(u92.BOSS_MODEL_NAME)
                assert(PrimaryPart ~= nil, v4)
                v3 = v1:FindFirstChild(u92.HAND_BONE_NAME, true)
                v4 = false
                if v3 ~= nil then
                    v4 = v3:IsA("Bone")
                end
                assert(v4, (("%* needs a %* bone"):format(u92.BOSS_MODEL_NAME, u92.HAND_BONE_NAME)))
                return {
                    Model = v1,
                    Root = PrimaryPart,
                    Outline = v2,
                    OutlineColor = v2.Color,
                    HandBone = v3,
                }
            end
            return nil
        end

        local function stopBlackHoleVfx() -- Line: 610
            -- upvalues: u88 (ref), u89 (ref), TweenService (upval), u92 (upval)
            local v1 = u88
            if v1 == nil then
                return
            end
            for i, j in v1:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    j.Enabled = false
                end
            end
            v1 = u89
            if v1 ~= nil then
                TweenService:Create(v1, u92.BLACK_HOLE_LOOP_DRAIN_INFO, {Volume = 0}):Play()
            end
        end

        local function clearBlackHole() -- Line: 627 -- upvalues: u88 (ref), u89 (ref), u90 (ref)
            local v1 = u88
            u88 = nil
            u89 = nil
            u90 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
        end

        local function groundBelow(a1) -- Line: 638
            -- upvalues: u86 (ref), Workspace (upval), u92 (upval)
            local v1 = u86
            if v1 == nil then
                return a1
            end
            local v2 = RaycastParams.new()
            v2.FilterType = Enum.RaycastFilterType.Include
            v2.FilterDescendantsInstances = {v1}
            local v3 = Workspace:Raycast(
                a1 + Vector3.new(0, 1, 0) * u92.GROUND_PROBE_HEIGHT,
                Vector3.new(0, 1, 0) * -(u92.GROUND_PROBE_HEIGHT * 4),
                v2
            )
            if v3 ~= nil then
                return v3.Position
            end
            return (Vector3.new(a1.X, v1.Position.Y + v1.Size.Y * 0.5, a1.Z))
        end

        local function chasePlayer(a1, a2, a3, a4, a5) -- Line: 661
            -- upvalues: u92 (upval)
            local Target = a1.Target
            local v1 = Vector3.new(a2.Position.X - Target.X, 0, a2.Position.Z - Target.Z)
            local v2 = a3.WalkSpeed * u92.BLACK_HOLE_FOLLOW_SPEED_FRACTION * a5 * a4
            if v2 < v1.Magnitude then
                a1.Target = Target + v1.Unit * v2
                return
            end
            a1.Target = Vector3.new(a2.Position.X, Target.Y, a2.Position.Z)
        end

        local function blackHolePart() -- Line: 679
            -- upvalues: u88 (ref), u92 (upval), u28 (val), Workspace (upval), TweenService (upval), BossEvent (upval)
            -- upvalues: u89 (ref)
            local v1 = u88
            if v1 ~= nil then
                return v1
            end
            local Part = Instance.new("Part")
            Part.Name = "BossBlackHole"
            Part.Shape = Enum.PartType.Cylinder
            Part.Material = Enum.Material.Neon
            Part.Color = u92.BLACK_HOLE_COLOR
            Part.Transparency = u92.BLACK_HOLE_TRANSPARENCY
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            local v2 = u28:Clone()
            v2.CFrame = u92.BLACK_HOLE_VFX_ROTATION * v2.CFrame
            v2.Parent = Part
            Part.Parent = Workspace
            u88 = Part
            TweenService:Create(Part, u92.BLACK_HOLE_PULSE, {Transparency = u92.BLACK_HOLE_FADED_TRANSPARENCY}):Play()
            BossEvent.PlaySound(u92.BLACK_HOLE_SPAWN_SOUND_NAME, Part)
            v2 = BossEvent.PlaySound(u92.BLACK_HOLE_LOOP_SOUND_NAME, Part, {Looped = true, Volume = 0})
            if v2 ~= nil then
                TweenService:Create(v2, u92.BLACK_HOLE_LOOP_RISE_INFO, {Volume = u92.BLACK_HOLE_LOOP_VOLUME}):Play()
                u89 = v2
            end
            return Part
        end

        local function faceTowards(a1, a2, a3) -- Line: 715
            -- upvalues: u92 (upval)
            local Pivot = a1.Model:GetPivot()
            local v1 = Vector3.new(a2.X, Pivot.Position.Y, a2.Z)
            if (v1 - Pivot.Position).Magnitude < 1 then
                return
            end
            a1.Model:PivotTo((Pivot:Lerp(CFrame.lookAt(Pivot.Position, v1), (math.min(a3 * u92.TURN_SPEED, 1)))))
        end

        local function stepBlackHole(a1) -- Line: 725
            -- upvalues: u87 (ref), Player (upval), LocalPlayer (val), Workspace (upval), u92 (upval), u116 (ref)
            -- upvalues: u88 (ref), u89 (ref), u90 (ref), u111 (ref), u115 (ref), stopBlackHoleVfx (val)
            -- upvalues: chasePlayer (val), faceTowards (val), groundBelow (val), blackHolePart (val), u117 (ref)
            -- upvalues: Remotes (upval)
            local v1
            local v2 = u87
            local v3 = Player.FindRootPart(LocalPlayer)
            local v4 = Player.FindHumanoid(LocalPlayer)
            local ServerTimeNow = Workspace:GetServerTimeNow()
            if v2 ~= nil and v2.Model:GetAttribute(u92.SPAWNING_ATTRIBUTE) then
                u116 = ServerTimeNow
            end
            if v4 ~= nil and v3 ~= nil and v3:IsA("BasePart") then
                local RetractingAt, Target, v5, v6, v7, v8
                v1 = false
                if v2 ~= nil then
                    v1 = not u111
                    if v1 then
                        v1 = not v2.Model:GetAttribute(u92.SPAWNING_ATTRIBUTE)
                        if v1 then
                            v1 = not v2.Model:GetAttribute(u92.ATTACKING_ATTRIBUTE)
                            if v1 then
                                v5 = ServerTimeNow - math.max(u115, u116)
                                v1 = u92.BLACK_HOLE_START_DELAY <= v5
                            end
                        end
                    end
                end
                v5 = u90
                if v5 == nil then
                    if not v1 then
                        return
                    end
                    v5 = {Target = v3.Position, StartedAt = ServerTimeNow}
                    u90 = v5
                    RetractingAt = v5.RetractingAt
                    v6 = 1
                    if RetractingAt ~= nil then
                        v6 = 1 - math.min((ServerTimeNow - RetractingAt) / u92.BLACK_HOLE_RETRACT_SECONDS, 1)
                        if v6 <= 0 then
                            v7 = u88
                            u88 = nil
                            u89 = nil
                            u90 = nil
                            if v7 ~= nil then
                                v7:Destroy()
                            end
                            return
                        end
                    end
                    v1 = math.min((ServerTimeNow - v5.StartedAt) / u92.BLACK_HOLE_WINDUP_SECONDS, 1)
                    if v1 >= 1 then
                        chasePlayer(v5, v3, v4, a1, v6)
                    end
                    Target = v5.Target
                    if v2 ~= nil and not v2.Model:GetAttribute(u92.ATTACKING_ATTRIBUTE) then
                        faceTowards(v2, Target, a1)
                    end
                    v5 = u92.BLACK_HOLE_RADIUS * v1 * v6
                    v6 = groundBelow((Vector3.new(Target.X, v3.Position.Y, Target.Z)))
                    v1 = blackHolePart()
                    v1.Size = Vector3.new(u92.BLACK_HOLE_THICKNESS, v5 * 2, v5 * 2)
                    v1.CFrame = (CFrame.new(v6 + Vector3.new(0, 1, 0) * u92.BLACK_HOLE_HOVER)) * CFrame.Angles(0, 0, 1.5707963267948966)
                    v8 = Vector3.new(v3.Position.X - v6.X, 0, v3.Position.Z - v6.Z)
                    if v7 and v8.Magnitude <= v5 then
                        v8 = ServerTimeNow - u117
                        if u92.BLACK_HOLE_HIT_INTERVAL <= v8 then
                            u117 = ServerTimeNow
                            Remotes.BossEvent.BlackHoleHit:FireServer()
                        end
                    end
                    return
                end
                if not v1 and v5.RetractingAt == nil then
                    v5.RetractingAt = ServerTimeNow
                    stopBlackHoleVfx()
                end
                RetractingAt = v5.RetractingAt
                v6 = 1
                if RetractingAt ~= nil then
                    v6 = 1 - math.min((ServerTimeNow - RetractingAt) / u92.BLACK_HOLE_RETRACT_SECONDS, 1)
                    if v6 <= 0 then
                        v7 = u88
                        u88 = nil
                        u89 = nil
                        u90 = nil
                        if v7 ~= nil then
                            v7:Destroy()
                        end
                        return
                    end
                end
                v1 = math.min((ServerTimeNow - v5.StartedAt) / u92.BLACK_HOLE_WINDUP_SECONDS, 1)
                if v1 >= 1 then
                    chasePlayer(v5, v3, v4, a1, v6)
                end
                Target = v5.Target
                if v2 ~= nil and not v2.Model:GetAttribute(u92.ATTACKING_ATTRIBUTE) then
                    faceTowards(v2, Target, a1)
                end
                v5 = u92.BLACK_HOLE_RADIUS * v1 * v6
                v6 = groundBelow((Vector3.new(Target.X, v3.Position.Y, Target.Z)))
                v1 = blackHolePart()
                v1.Size = Vector3.new(u92.BLACK_HOLE_THICKNESS, v5 * 2, v5 * 2)
                v1.CFrame = (CFrame.new(v6 + Vector3.new(0, 1, 0) * u92.BLACK_HOLE_HOVER)) * CFrame.Angles(0, 0, 1.5707963267948966)
                v8 = Vector3.new(v3.Position.X - v6.X, 0, v3.Position.Z - v6.Z)
                if v7 and v8.Magnitude <= v5 then
                    v8 = ServerTimeNow - u117
                    if u92.BLACK_HOLE_HIT_INTERVAL <= v8 then
                        u117 = ServerTimeNow
                        Remotes.BossEvent.BlackHoleHit:FireServer()
                    end
                end
                return
            end
            v1 = u88
            u88 = nil
            u89 = nil
            u90 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
        end

        local function measureHazardCycle(a1, a2) -- Line: 809
            -- upvalues: u112 (ref), u92 (upval), u113 (ref), u114 (ref)
            local Position
            local v1 = a1.Size * 0.5
            local v2 = 0
            local v3 = {-v1.X, v1.X}
            local v4 = nil
            local v5 = nil
            for i, j in v3, v4, v5 do
                for k, n in {-v1.Z, v1.Z} do
                    Position = (v6.CFrame * CFrame.new(j, 0, n)).Position
                    v2 = math.max(v2, (Vector3.new(Position.X - v7.X, 0, Position.Z - v7.Z)).Magnitude)
                end
            end
            u112 = v2 / u92.RING_SPEED
            u113 = (u92.RING_COUNT - 1) * u92.RING_SPAWN_INTERVAL + u112 + u92.RING_FADE_SECONDS
            u114 = u92.X_TELEGRAPH_SECONDS + u92.X_ACTIVE_SECONDS + u113 + u92.HAZARD_GAP_SECONDS * 2
        end

        local function hazardFolder() -- Line: 824 -- upvalues: u91 (ref), u92 (upval), Workspace (upval)
            local v1 = u91
            if v1 ~= nil then
                return v1
            end
            local Folder = Instance.new("Folder")
            Folder.Name = u92.HAZARD_FOLDER_NAME
            Folder.Parent = Workspace
            u91 = Folder
            return Folder
        end

        local function hazardPart(a1, a2, a3) -- Line: 836
            -- upvalues: u92 (upval), u91 (ref), Workspace (upval)
            local v1
            local Part = Instance.new("Part")
            Part.Name = a1
            Part.Size = a2
            Part.Material = Enum.Material.Neon
            Part.Color = u92.HAZARD_COLOR
            Part.Transparency = a3
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            local v2 = u91
            if v2 == nil then
                local Folder = Instance.new("Folder")
                Folder.Name = u92.HAZARD_FOLDER_NAME
                Folder.Parent = Workspace
                u91 = Folder
                v1 = Folder
            else
                v1 = v2
            end
            Part.Parent = v1
            return Part
        end

        local function clearHazards() -- Line: 852 -- upvalues: u91 (ref), u94 (ref), u95 (ref)
            local v1 = u91
            u91 = nil
            u94 = {}
            u95 = {}
            if v1 ~= nil then
                v1:Destroy()
            end
        end

        local function overFloor(a1) -- Line: 865 -- upvalues: u86 (ref) -- types: a1: vector
            local v1 = u86
            if v1 == nil then
                return false
            end
            local v2 = v1.CFrame:PointToObjectSpace(a1)
            local v3 = false
            if (math.abs(v2.X)) <= v1.Size.X * 0.5 then
                v3 = (math.abs(v2.Z)) <= v1.Size.Z * 0.5
            end
            return v3
        end

        local function withinHazardHeight(a1, a2) -- Line: 877
            -- upvalues: u92 (upval)
            return (math.abs(a1.Position.Y - a2)) <= u92.HAZARD_JUMP_CLEARANCE
        end

        local function reportHazardHit(a1) -- Line: 883
            -- upvalues: u96 (val), u92 (upval), Remotes (upval)
            local v1 = os.clock()
            if v1 - (u96[a1] or 0) < u92.HAZARD_REPORT_INTERVAL then
                return
            end
            u96[a1] = v1
            Remotes.BossEvent.HazardHit:FireServer(a1)
        end

        local function stepRotatingX(a1, a2, a3, a4, a5) -- Line: 895
            -- upvalues: u86 (ref), u94 (ref), u92 (upval), u91 (ref), Workspace (upval), TweenService (upval)
            -- upvalues: u96 (val), Remotes (upval)
            local Angles, X_2, X_KIND, Y, v1, v2, v3, v4
            local v5 = u86
            if v5 == nil then
                return
            end
            local v6 = math.max(v5.Size.X, v5.Size.Z)
            if #u94 == 0 then
                local Folder, HAZARD_INDICATOR_TRANSPARENCY, v7, v8
                local HAZARD_INDICATOR_THICKNESS = if not a1 then u92.HAZARD_THICKNESS else u92.HAZARD_INDICATOR_THICKNESS
                local X_BAR_COUNT = u92.X_BAR_COUNT
                for i = 1, X_BAR_COUNT do
                    v7 = Vector3.new(u92.HAZARD_THICKNESS, HAZARD_INDICATOR_THICKNESS, v6)
                    HAZARD_INDICATOR_TRANSPARENCY = if not a1 then u92.HAZARD_TRANSPARENCY else u92.HAZARD_INDICATOR_TRANSPARENCY
                    v1 = Instance.new("Part")
                    v1.Name = if not a1 then "XBar" else "XIndicator"
                    v1.Size = v7
                    v1.Material = Enum.Material.Neon
                    v1.Color = u92.HAZARD_COLOR
                    v1.Transparency = HAZARD_INDICATOR_TRANSPARENCY
                    v1.Anchored = true
                    v1.CanCollide = false
                    v1.CanQuery = false
                    v1.CanTouch = false
                    v1.CastShadow = false
                    v2 = u91
                    if v2 == nil then
                        Folder = Instance.new("Folder")
                        Folder.Name = u92.HAZARD_FOLDER_NAME
                        Folder.Parent = Workspace
                        u91 = Folder
                        v8 = Folder
                    else
                        v8 = v2
                    end
                    v1.Parent = v8
                    if a1 then
                        TweenService:Create(v1, u92.HAZARD_PULSE, {Transparency = u92.HAZARD_TRANSPARENCY}):Play()
                    end
                    table.insert(u94, v1)
                end
            end
            local v9 = if not a1 then v6 * math.clamp(a2 / u92.X_GROW_SECONDS, 0, 1) else v6
            local v10 = math.rad((if not a1 then math.max(a2 - u92.X_GROW_SECONDS, 0) else 0) * u92.X_DEGREES_PER_SECOND)
            v1 = nil
            local v11 = nil
            for j, k in u94, v1, v11 do
                X_2 = k.Size.X
                Y = k.Size.Y
                v3 = math.max(v9, u92.HAZARD_MIN_LENGTH)
                k.Size = Vector3.new(X_2, Y, v3)
                v2 = CFrame.new(a3.X, a4, a3.Z)
                Angles = CFrame.Angles
                v4 = v10 + (j - 1) * 3.141592653589793 * 0.5
                k.CFrame = v2 * Angles(0, v4, 0)
                if not a1 and a5 ~= nil and (math.abs(a5.Position.Y - a4)) <= u92.HAZARD_JUMP_CLEARANCE then
                    v6 = k.CFrame:PointToObjectSpace((Vector3.new(a5.Position.X, k.Position.Y, a5.Position.Z)))
                    if (math.abs(v6.X)) <= u92.HAZARD_THICKNESS * 0.5 + u92.HAZARD_TOUCH_PADDING
                        and (math.abs(v6.Z)) <= v9 * 0.5 then
                        X_KIND = u92.X_KIND
                        v2 = os.clock()
                        if not (v2 - (u96[X_KIND] or 0) < u92.HAZARD_REPORT_INTERVAL) then
                            u96[X_KIND] = v2
                            Remotes.BossEvent.HazardHit:FireServer(X_KIND)
                        end
                    end
                end
            end
        end

        local function newRing() -- Line: 945 -- upvalues: u92 (upval), u91 (ref), Workspace (upval)
            local Folder, HAZARD_TRANSPARENCY, v1, v2, v3, v4
            local v5 = {}
            local RING_SEGMENTS = u92.RING_SEGMENTS
            for i = 1, RING_SEGMENTS do
                v3 = Vector3.new(u92.HAZARD_THICKNESS, u92.HAZARD_THICKNESS, u92.HAZARD_MIN_LENGTH)
                HAZARD_TRANSPARENCY = u92.HAZARD_TRANSPARENCY
                v2 = Instance.new("Part")
                v2.Name = "RingSegment"
                v2.Size = v3
                v2.Material = Enum.Material.Neon
                v2.Color = u92.HAZARD_COLOR
                v2.Transparency = HAZARD_TRANSPARENCY
                v2.Anchored = true
                v2.CanCollide = false
                v2.CanQuery = false
                v2.CanTouch = false
                v2.CastShadow = false
                v1 = u91
                if v1 == nil then
                    Folder = Instance.new("Folder")
                    Folder.Name = u92.HAZARD_FOLDER_NAME
                    Folder.Parent = Workspace
                    u91 = Folder
                    v4 = Folder
                else
                    v4 = v1
                end
                v2.Parent = v4
                table.insert(v5, v2)
            end
            return v5
        end

        local function stepRings(a1, a2, a3, a4) -- Line: 959
            -- upvalues: u92 (upval), u95 (ref), newRing (val), u112 (ref), u86 (ref), u96 (val), Remotes (upval)
            local RING_KIND, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
            local v13 = u92.RING_COUNT - 1
            local v14, v15, v16, v17 = a1, a2, a3, a4
            for i = 0, v13 do
                v10 = v14 - i * u92.RING_SPAWN_INTERVAL
                if not (v10 < 0) then
                    v11 = u95[i] or newRing()
                    u95[i] = v11
                    v12 = (math.min(v10, u112)) * u92.RING_SPEED
                    v1 = math.clamp((v10 - u112) / u92.RING_FADE_SECONDS, 0, 1)
                    v10 = u92.HAZARD_TRANSPARENCY + (1 - u92.HAZARD_TRANSPARENCY) * v1
                    v2 = math.max(6.283185307179586 * v12 / u92.RING_SEGMENTS, u92.HAZARD_MIN_LENGTH)
                    v3 = v11
                    v4 = nil
                    v5 = nil
                    for j, k in v3, v4, v5 do
                        v6 = (j - 1) / u92.RING_SEGMENTS * 3.141592653589793 * 2
                        v7 = Vector3.new(v15.X + math.cos(v6) * v12, v16, v15.Z + (math.sin(v6)) * v12)
                        k.Size = Vector3.new(u92.HAZARD_THICKNESS, u92.HAZARD_THICKNESS, v2)
                        v8 = CFrame.new(v7)
                        k.CFrame = v8 * CFrame.Angles(0, -v6, 0)
                        v6 = u86
                        if v6 ~= nil then
                            v9 = v6.CFrame:PointToObjectSpace(v7)
                            v8 = false
                            if (math.abs(v9.X)) <= v6.Size.X * 0.5 then
                                v8 = (math.abs(v9.Z)) <= v6.Size.Z * 0.5
                            end
                        else
                            v8 = false
                        end
                        k.Transparency = if not v8 then 1 else v10
                    end
                    if v17 ~= nil and not (v1 >= 1) then
                        v3 = (math.abs(v17.Position.Y - v16)) <= u92.HAZARD_JUMP_CLEARANCE
                        if v3 then
                            v3 = math.abs((Vector3.new(v17.Position.X - v15.X, 0, v17.Position.Z - v15.Z)).Magnitude - v12)
                            if v3 <= u92.HAZARD_THICKNESS * 0.5 + u92.HAZARD_TOUCH_PADDING then
                                v1 = u86
                                if v1 ~= nil then
                                    v11 = v1.CFrame:PointToObjectSpace(v17.Position)
                                    v3 = false
                                    if (math.abs(v11.X)) <= v1.Size.X * 0.5 then
                                        v3 = (math.abs(v11.Z)) <= v1.Size.Z * 0.5
                                    end
                                else
                                    v3 = false
                                end
                                if v3 then
                                    RING_KIND = u92.RING_KIND
                                    v10 = os.clock()
                                    if not (v10 - (u96[RING_KIND] or 0) < u92.HAZARD_REPORT_INTERVAL) then
                                        u96[RING_KIND] = v10
                                        Remotes.BossEvent.HazardHit:FireServer(RING_KIND)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local function stepHazards() -- Line: 1004
            -- upvalues: u87 (ref), u86 (ref), u111 (ref), u92 (upval), u114 (ref), u92_2 (ref), u91 (ref), u94 (ref)
            -- upvalues: u95 (ref), Workspace (upval), u113 (ref), u93 (ref), Player (upval), LocalPlayer (val)
            -- upvalues: u97 (ref), stepRings (val), stepRotatingX (val)
            local v1
            local v2 = u87
            local v3 = u86
            local Attribute = if v2 == nil or u111 then nil else v2.Model:GetAttribute(u92.PHASE_TWO_AT_ATTRIBUTE)
            if v2 ~= nil and v3 ~= nil and typeof(Attribute) == "number" and not (u114 <= 0) then
                v2 = Workspace:GetServerTimeNow() - Attribute - u92.HAZARD_START_DELAY_SECONDS
                if v2 < 0 then
                    if u92_2 ~= nil then
                        u92_2 = nil
                        local v4 = u91
                        u91 = nil
                        u94 = {}
                        u95 = {}
                        if v4 ~= nil then
                            v4:Destroy()
                        end
                    end
                    return
                end
                v1 = math.floor(v2 / u114)
                local v5 = v2 - v1 * u114
                v2 = u92.X_TELEGRAPH_SECONDS + u92.X_ACTIVE_SECONDS
                local v6 = v2 + u92.HAZARD_GAP_SECONDS
                local v7 = nil
                if v5 < u92.X_TELEGRAPH_SECONDS then
                    v7 = "XTelegraph"
                elseif v5 < v2 then
                    v7 = "XActive"
                elseif v6 <= v5 and v5 < v6 + u113 then
                    v7 = "Rings"
                end
                if v7 ~= u92_2 or v1 ~= u93 then
                    v2 = u91
                    u91 = nil
                    u94 = {}
                    u95 = {}
                    if v2 ~= nil then
                        v2:Destroy()
                    end
                    u92_2 = v7
                    u93 = v1
                end
                if v7 == nil then
                    return
                end
                v1 = Player.FindRootPart(LocalPlayer)
                local v8 = Player.FindHumanoid(LocalPlayer)
                local v9 = nil
                if v1 ~= nil and v1:IsA("BasePart") and v8 ~= nil and 0 < v8.Health then
                    v9 = v1
                end
                v8 = u97
                v1 = v3.Position.Y + v3.Size.Y * 0.5 + u92.HAZARD_HOVER + u92.HAZARD_THICKNESS * 0.5
                if v7 == "Rings" then
                    stepRings(v5 - v6, v8, v1, v9)
                    return
                end
                if v7 == "XTelegraph" then
                    stepRotatingX(true, v5, v8, v1, v9)
                    return
                end
                stepRotatingX(false, v5 - u92.X_TELEGRAPH_SECONDS, v8, v1, v9)
                return
            end
            if u92_2 ~= nil then
                u92_2 = nil
                v1 = u91
                u91 = nil
                u94 = {}
                u95 = {}
                if v1 ~= nil then
                    v1:Destroy()
                end
            end
        end

        local function clearArmBeam() -- Line: 1071 -- upvalues: u98 (ref), u99 (ref)
            local v1 = u98
            local v2 = u99
            u98 = nil
            u99 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
            if v2 ~= nil then
                v2:Destroy()
            end
        end

        local function stepArmBeam() -- Line: 1088
            -- upvalues: u87 (ref), u92 (upval), u100 (ref), u98 (ref), u99 (ref), LocalPlayer (val), Player (upval)
            -- upvalues: u56 (val)
            local v1, v2
            local v3 = u87
            if v3 ~= nil and v3.HandBone:FindFirstChild(u92.HEALTH_GUI_NAME) ~= nil then
                local v4
                local Attribute = LocalPlayer:GetAttribute(u92.ARM_HITS_ATTRIBUTE)
                v2 = if type(Attribute) ~= "number" then 0 else Attribute
                v1 = u100 or v2
                u100 = v1
                local v5 = Player.FindRootPart(LocalPlayer)
                if v5 ~= nil and v5:IsA("BasePart") then
                    v4 = v2 - v1
                    if not (u92.ARM_BEAM_HIT_LIMIT <= v4) then
                        v2 = u98
                        v1 = u99
                        if v2 ~= nil and v1 ~= nil and v1.Parent == v5 and v2.Attachment1 == v3.HandBone then
                            return
                        end
                        v2 = u98
                        v1 = u99
                        u98 = nil
                        u99 = nil
                        if v2 ~= nil then
                            v2:Destroy()
                        end
                        if v1 ~= nil then
                            v1:Destroy()
                        end
                        local Attachment = Instance.new("Attachment")
                        Attachment.Name = "BossArmBeamOrigin"
                        Attachment.Parent = v5
                        u99 = Attachment
                        v5 = u56:Clone()
                        v5.Attachment0 = Attachment
                        v5.Attachment1 = v3.HandBone
                        v5.Parent = Attachment
                        u98 = v5
                        return
                    end
                end
                v4 = u98
                local v6 = u99
                u98 = nil
                u99 = nil
                if v4 ~= nil then
                    v4:Destroy()
                end
                if v6 ~= nil then
                    v6:Destroy()
                end
                return
            end
            u100 = nil
            v1 = u98
            v2 = u99
            u98 = nil
            u99 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
            if v2 ~= nil then
                v2:Destroy()
            end
        end

        local function clearCrystalBeam() -- Line: 1130 -- upvalues: u106 (ref), u107 (ref), u108 (ref)
            local v1 = u106
            local v2 = u107
            local v3 = u108
            u106 = nil
            u107 = nil
            u108 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
            if v2 ~= nil then
                v2:Destroy()
            end
            if v3 ~= nil then
                v3:Destroy()
            end
        end

        local function nearestCrystal(a1) -- Line: 1150 -- upvalues: u85 (ref), u92 (upval) -- types: a1: vector
            local Attribute, CRYSTAL_HITBOX_NAME, Magnitude, v1, v2
            local v3 = u85
            if (if v3 == nil then nil else v3:FindFirstChild(u92.CRYSTAL_FOLDER_NAME)) == nil then
                return nil
            end
            v3 = nil
            local v4 = (1 / 0)
            for i, j in v1:GetChildren() do
                CRYSTAL_HITBOX_NAME = u92.CRYSTAL_HITBOX_NAME
                v2 = j:FindFirstChild(CRYSTAL_HITBOX_NAME)
                if v2 ~= nil and v2:IsA("BasePart") then
                    Attribute = v2:GetAttribute(u92.CRYSTAL_HEALTH_ATTRIBUTE)
                    if type(Attribute) == "number" and not (Attribute <= 0) then
                        Magnitude = (v2.Position - a1).Magnitude
                        if Magnitude < v4 then
                            v3 = v2
                        end
                    end
                end
            end
            return v3
        end

        local function stepCrystalBeam() -- Line: 1179
            -- upvalues: u87 (ref), u111 (ref), u92 (upval), u109 (ref), u106 (ref), u107 (ref), u108 (ref)
            -- upvalues: Workspace (upval), LocalPlayer (val), u110 (ref), Notifications (upval), Player (upval)
            -- upvalues: nearestCrystal (val), u56 (val)
            local v1, v2, v3, v4
            local v5 = u87
            local v6 = false
            if v5 ~= nil then
                v6 = not u111 and not v5.Model:GetAttribute(u92.SPAWNING_ATTRIBUTE) and v5.Model:GetAttribute(u92.PHASE_TWO_AT_ATTRIBUTE) == nil
            end
            if not v6 then
                u109 = 0
                v5 = u106
                v1 = u107
                v2 = u108
                u106 = nil
                u107 = nil
                u108 = nil
                if v5 ~= nil then
                    v5:Destroy()
                end
                if v1 ~= nil then
                    v1:Destroy()
                end
                if v2 ~= nil then
                    v2:Destroy()
                end
                return
            end
            local ServerTimeNow = Workspace:GetServerTimeNow()
            if u109 == 0 then
                u109 = ServerTimeNow
            end
            local Attribute = LocalPlayer:GetAttribute(u92.CRYSTAL_HITS_ATTRIBUTE)
            v2 = if type(Attribute) ~= "number" then 0 else Attribute
            if u92.CRYSTAL_BEAM_HIT_LIMIT <= v2 then
                v2 = u106
                v3 = u107
                v4 = u108
                u106 = nil
                u107 = nil
                u108 = nil
                if v2 ~= nil then
                    v2:Destroy()
                end
                if v3 ~= nil then
                    v3:Destroy()
                end
                if v4 ~= nil then
                    v4:Destroy()
                end
                return
            end
            if not u110 then
                v2 = ServerTimeNow - u109
                if u92.CRYSTAL_HINT_DELAY <= v2 then
                    u110 = true
                    Notifications.Toast.Show({
                        Lane = "Banner",
                        Text = u92.CRYSTAL_HINT_MESSAGE,
                        Seconds = u92.CRYSTAL_HINT_SECONDS,
                        Color = u92.CRYSTAL_HINT_COLOR,
                    })
                end
            end
            v1 = Player.FindRootPart(LocalPlayer)
            v6 = if v1 == nil then nil else if not v1:IsA("BasePart") then nil else nearestCrystal(v1.Position)
            if v1 ~= nil and v1:IsA("BasePart") and v6 ~= nil then
                v2 = u107
                v3 = u108
                if v2 ~= nil and v3 ~= nil and v2.Parent == v1 then
                    if v3.Parent ~= v6 then
                        v3.Parent = v6
                    end
                    return
                end
                v3 = u106
                v2 = u107
                v4 = u108
                u106 = nil
                u107 = nil
                u108 = nil
                if v3 ~= nil then
                    v3:Destroy()
                end
                if v2 ~= nil then
                    v2:Destroy()
                end
                if v4 ~= nil then
                    v4:Destroy()
                end
                local Attachment = Instance.new("Attachment")
                Attachment.Name = "BossCrystalBeamOrigin"
                Attachment.Parent = v1
                u107 = Attachment
                v1 = Instance.new("Attachment")
                v1.Name = "BossCrystalBeamTarget"
                v1.Parent = v6
                u108 = v1
                v6 = u56:Clone()
                v6.Attachment0 = Attachment
                v6.Attachment1 = v1
                v6.Parent = Attachment
                u106 = v6
                return
            end
            v2 = u106
            v3 = u107
            v4 = u108
            u106 = nil
            u107 = nil
            u108 = nil
            if v2 ~= nil then
                v2:Destroy()
            end
            if v3 ~= nil then
                v3:Destroy()
            end
            if v4 ~= nil then
                v4:Destroy()
            end
        end

        local function clearShopBeam() -- Line: 1247 -- upvalues: u103 (ref), u104 (ref)
            local v1 = u103
            local v2 = u104
            u103 = nil
            u104 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
            if v2 ~= nil then
                v2:Destroy()
            end
        end

        local function bindShopStand(a1) -- Line: 1262
            -- upvalues: u92 (upval), u101 (ref), u102 (ref), u75 (val), Pads (upval), u105 (ref), u103 (ref)
            -- upvalues: u104 (ref), Tabs (upval)
            local v1 = a1:WaitForChild(u92.SHOP_ZONE_NAME, 5)
            local v2 = false
            if v1 ~= nil then
                v2 = v1:IsA("BasePart")
            end
            assert(v2, (("%* needs a %* part"):format(u92.SHOP_STAND_NAME, u92.SHOP_ZONE_NAME)))
            u101 = a1
            local Attachment = Instance.new("Attachment")
            Attachment.Name = "BossShopBeamTarget"
            Attachment.Position = Vector3.new(0, u92.SHOP_BEAM_LIFT, 0)
            Attachment.Parent = v1
            u102 = Attachment
            u75:Add(Attachment)
            u75:Add((Pads.Track(v1, {
                Entered = function() -- Line: 1275 -- upvalues: u105 (upval), u103 (upval), u104 (upval), Tabs (upval), u92 (upval)
                    u105 = true
                    local v1 = u103
                    local v2 = u104
                    u103 = nil
                    u104 = nil
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                    if v2 ~= nil then
                        v2:Destroy()
                    end
                    Tabs.Activate(u92.SHOP_TAB_NAME)
                end,
                Left = function() -- Line: 1281 -- upvalues: Tabs (upval), u92 (upval)
                    if Tabs.Active() == u92.SHOP_TAB_NAME then
                        Tabs.Deactivate({instant = true})
                    end
                end,
            })))
        end

        local function stepShopStand() -- Line: 1289
            -- upvalues: u85 (ref), u92 (upval), u101 (ref), bindShopStand (val), u102 (ref), Player (upval)
            -- upvalues: LocalPlayer (val), u105 (ref), u103 (ref), u104 (ref), u56 (val)
            local v1 = u85
            local v2 = if v1 == nil then nil else v1:FindFirstChild(u92.SHOP_STAND_NAME)
            if v2 ~= nil and v2:IsA("Model") then
                local v3, v4
                if u101 ~= v2 then
                    bindShopStand(v2)
                end
                v2 = u102
                v1 = Player.FindRootPart(LocalPlayer)
                if v2 ~= nil and v1 ~= nil and v1:IsA("BasePart") and not u105 then
                    v4 = u104
                    if u103 ~= nil and v4 ~= nil and v4.Parent == v1 then
                        return
                    end
                    v4 = u103
                    v3 = u104
                    u103 = nil
                    u104 = nil
                    if v4 ~= nil then
                        v4:Destroy()
                    end
                    if v3 ~= nil then
                        v3:Destroy()
                    end
                    local Attachment = Instance.new("Attachment")
                    Attachment.Name = "BossShopBeamOrigin"
                    Attachment.Parent = v1
                    u104 = Attachment
                    v1 = u56:Clone()
                    v1.Attachment0 = Attachment
                    v1.Attachment1 = v2
                    v1.Parent = Attachment
                    u103 = v1
                    return
                end
                v3 = u103
                v4 = u104
                u103 = nil
                u104 = nil
                if v3 ~= nil then
                    v3:Destroy()
                end
                if v4 ~= nil then
                    v4:Destroy()
                end
                return
            end
        end

        local function watchBoss(a1) -- Line: 1325
            -- upvalues: u78 (val), findBoss (val), u87 (ref), u88 (ref), u89 (ref), u90 (ref), u92 (upval)
            u78:Clean()

            local function bind() -- Line: 1327
                -- upvalues: findBoss (upval), a1 (val), u87 (upval), u78 (upval), u88 (upval), u89 (upval), u90 (upval)
                local v1 = findBoss(a1)
                if v1 == nil then
                    return
                end
                u87 = v1
                u78:Add(function() -- Line: 1333 -- upvalues: u87 (upval), u88 (upval), u89 (upval), u90 (upval)
                    u87 = nil
                    local v1 = u88
                    u88 = nil
                    u89 = nil
                    u90 = nil
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                end)
            end

            local v1 = findBoss(a1)
            if v1 ~= nil then
                u87 = v1
                u78:Add(function() -- Line: 1333 -- upvalues: u87 (upval), u88 (upval), u89 (upval), u90 (upval)
                    u87 = nil
                    local v1 = u88
                    u88 = nil
                    u89 = nil
                    u90 = nil
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                end)
            end
            if u87 == nil then
                u78:Connect(a1.ChildAdded, function(a1) -- Line: 1341 -- upvalues: u92 (upval), u87 (upval), bind (val)
                    if a1.Name == u92.BOSS_MODEL_NAME and u87 == nil then
                        task.defer(bind)
                    end
                end)
            end
        end

        local function onEnterArena() -- Line: 1349
            -- upvalues: u75 (val), u115 (ref), Workspace (upval), u116 (ref), u117 (ref), LightingController (upval)
            -- upvalues: u92 (upval), u78 (val), u88 (ref), u89 (ref), u90 (ref), u91 (ref), u94 (ref), u95 (ref)
            -- upvalues: u98 (ref), u99 (ref), u103 (ref), u104 (ref), u106 (ref), u107 (ref), u108 (ref), u109 (ref)
            -- upvalues: u110 (ref), u100 (ref), u101 (ref), u102 (ref), u105 (ref), u111 (ref), Tabs (upval)
            -- upvalues: u92_2 (ref), u93 (ref), u114 (ref), u85 (ref), u86 (ref), u9 (ref), TweenService (upval)
            -- upvalues: u8 (val), SoundService (upval), LocalPlayer (val), Remotes (upval), playVfx (val), u97 (ref)
            -- upvalues: measureHazardCycle (val), watchBoss (val), showUi (val), RunService (upval)
            -- upvalues: stepBlackHole (val), stepHazards (val), stepArmBeam (val), stepCrystalBeam (val)
            -- upvalues: stepShopStand (val), stepUi (val)
            local v1
            u75:Clean()
            u115 = Workspace:GetServerTimeNow()
            u116 = 0
            u117 = 0
            LightingController.SetLayer(u92.LIGHTING_LAYER, "RiftBoss", u92.LIGHTING_RANK, u92.LIGHTING_SPAN)
            u75:Add(function() -- Line: 1356
                -- upvalues: LightingController (upval), u92 (upval), u78 (upval), u88 (upval), u89 (upval), u90 (upval)
                -- upvalues: u91 (upval), u94 (upval), u95 (upval), u98 (upval), u99 (upval), u103 (upval), u104 (upval)
                -- upvalues: u106 (upval), u107 (upval), u108 (upval), u109 (upval), u110 (upval), u100 (upval)
                -- upvalues: u101 (upval), u102 (upval), u105 (upval), u111 (upval), Tabs (upval), u92_2 (upval)
                -- upvalues: u93 (upval), u114 (upval), u85 (upval), u86 (upval), u9 (upval), TweenService (upval)
                -- upvalues: u8 (upval), SoundService (upval)
                LightingController.ClearLayer(u92.LIGHTING_LAYER, u92.LIGHTING_SPAN)
                u78:Clean()
                local v1 = u88
                u88 = nil
                u89 = nil
                u90 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                v1 = u91
                u91 = nil
                u94 = {}
                u95 = {}
                if v1 ~= nil then
                    v1:Destroy()
                end
                v1 = u98
                local v2 = u99
                u98 = nil
                u99 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                if v2 ~= nil then
                    v2:Destroy()
                end
                v1 = u103
                v2 = u104
                u103 = nil
                u104 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                if v2 ~= nil then
                    v2:Destroy()
                end
                v1 = u106
                v2 = u107
                local v3 = u108
                u106 = nil
                u107 = nil
                u108 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                if v2 ~= nil then
                    v2:Destroy()
                end
                if v3 ~= nil then
                    v3:Destroy()
                end
                u109 = 0
                u110 = false
                u100 = nil
                u101 = nil
                u102 = nil
                u105 = false
                u111 = false
                if Tabs.Active() == u92.SHOP_TAB_NAME then
                    Tabs.Deactivate({instant = true})
                end
                u92_2 = nil
                u93 = -1
                u114 = 0
                u85 = nil
                u86 = nil
                v1 = u9
                if v1 ~= nil then
                    v1:Cancel()
                end
                v1 = TweenService:Create(u8, u92.MUSIC_FADE_INFO, {Volume = 0})
                u9 = v1
                v1:Play()
                SoundService.Music.GameMusic.Volume = 1
            end)
            if u8.IsPlaying then
                local MUSIC_VOLUME = u92.MUSIC_VOLUME
                v1 = u9
                if v1 ~= nil then
                    v1:Cancel()
                end
                v1 = TweenService:Create(u8, u92.MUSIC_FADE_INFO, {Volume = MUSIC_VOLUME})
                u9 = v1
                v1:Play()
            end
            SoundService.Music.GameMusic.Volume = 0
            u75:Connect(LocalPlayer.CharacterAdded, function() -- Line: 1393 -- upvalues: u115 (upval), Workspace (upval), u88 (upval), u89 (upval), u90 (upval)
                Workspace:GetServerTimeNow()
                local v1 = u88
                u88 = nil
                u89 = nil
                u90 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
            end)
            u75:Connect(Remotes.BossEvent.Vfx.OnClientEvent, playVfx)
            local v2 = Workspace:WaitForChild(u92.ARENA_MODEL_NAME, 5)
            local v3 = false
            if v2 ~= nil then
                v3 = v2:IsA("Model")
            end
            assert(v3, (("Entered the Boss World but Workspace.%* is missing"):format(u92.ARENA_MODEL_NAME)))
            if not LocalPlayer:GetAttribute(u92.IN_ARENA_ATTRIBUTE) then
                u75:Clean()
                return
            end
            v1 = v2:WaitForChild(u92.FLOOR_NAME, 5)
            local v4 = false
            if v1 ~= nil then
                v4 = v1:IsA("BasePart")
            end
            assert(v4, (("%* needs a %* part"):format(u92.ARENA_MODEL_NAME, u92.FLOOR_NAME)))
            v3 = v2:WaitForChild(u92.BOSS_SPAWN_NAME, 5)
            local v5 = false
            if v3 ~= nil then
                v5 = v3:IsA("BasePart")
            end
            assert(v5, (("%* needs a %* part"):format(u92.ARENA_MODEL_NAME, u92.BOSS_SPAWN_NAME)))
            u85 = v2
            u86 = v1
            u97 = v3.Position
            measureHazardCycle(v1, v3.Position)
            watchBoss(v2)
            showUi()
            if not LocalPlayer:GetAttribute(u92.IN_ARENA_ATTRIBUTE) then
                u75:Clean()
                return
            end
            u75:Connect(RunService.Heartbeat, function(a1) -- Line: 1423
                -- upvalues: stepBlackHole (upval), stepHazards (upval), stepArmBeam (upval), stepCrystalBeam (upval)
                -- upvalues: stepShopStand (upval), stepUi (upval)
                stepBlackHole(a1)
                stepHazards()
                stepArmBeam()
                stepCrystalBeam()
                stepShopStand()
                stepUi()
            end)
        end

        local function recordPortalPiece(a1) -- Line: 1441 -- upvalues: u83 (ref) -- types: a1: userdata
            if a1:IsA("BasePart") then
                u83[a1] = {
                    Solidity = {
                        CanCollide = a1.CanCollide,
                        CanQuery = a1.CanQuery,
                        CanTouch = a1.CanTouch,
                    },
                }
                return true
            end
            if not a1:IsA("ParticleEmitter")
                and not a1:IsA("Beam")
                and not a1:IsA("Light")
                and not a1:IsA("BillboardGui") then
                if not a1:IsA("Sound") then
                    return false
                end
                u83[a1] = {Volume = a1.Volume}
                return true
            end
            u83[a1] = {Effect = a1.Enabled}
            return true
        end

        local function applyPortalPiece(a1, a2, a3) -- Line: 1461 -- types: a1: userdata, a2: table, a3: boolean
            local Solidity = a2.Solidity
            if Solidity ~= nil then
                a1.LocalTransparencyModifier = if not a3 then 1 else 0
                a1.CanCollide = if not a3 then false else Solidity.CanCollide
                a1.CanQuery = if not a3 then false else Solidity.CanQuery
                a1.CanTouch = if not a3 then false else Solidity.CanTouch
                return
            end
            if a2.Effect ~= nil then
                a1.Enabled = if not a3 then false else a2.Effect
                return
            end
            if a2.Volume ~= nil then
                a1.Volume = if not a3 then 0 else a2.Volume
            end
        end

        local function refreshPortal() -- Line: 1476
            -- upvalues: u82 (ref), Save (upval), BossEventFlags (upval), RiftEligibility (upval), LocalPlayer (val)
            -- upvalues: u84 (ref), u83 (ref), applyPortalPiece (val)
            if u82 == nil then
                return
            end
            local v1 = Save.Await()
            local SpeedPower = if v1 == nil then 0 else v1.SpeedPower
            local LastLogout = if v1 == nil then 0 else v1.LastLogout
            v1 = BossEventFlags.ContentEnabled:Get() and RiftEligibility.IsRevealed(LocalPlayer, SpeedPower, LastLogout)
            if u84 == v1 then
                return
            end
            u84 = v1
            for i, j in u83 do
                applyPortalPiece(i, j, v1)
            end
        end

        local function adoptPortal(a1) -- Line: 1494
            -- upvalues: u81 (val), u82 (ref), u83 (ref), u84 (ref), recordPortalPiece (val), applyPortalPiece (val)
            -- upvalues: refreshPortal (val)
            u81:Clean()
            u82 = a1
            u83 = {}
            u84 = nil
            u81:Add(function() -- Line: 1499 -- upvalues: u82 (upval), u83 (upval), u84 (upval)
                u82 = nil
                u83 = {}
                u84 = nil
            end)
            for i, j in a1:GetDescendants() do
                recordPortalPiece(j)
            end
            u81:Connect(a1.DescendantAdded, function(a1) -- Line: 1507
                -- upvalues: recordPortalPiece (upval), u84 (upval), u83 (upval), applyPortalPiece (upval)
                if not recordPortalPiece(a1) then
                    return
                end
                local v1 = u84
                local v2 = u83[a1]
                if v1 ~= nil and v2 ~= nil then
                    applyPortalPiece(a1, v2, v1)
                end
            end)
            u81:Connect(a1.DescendantRemoving, function(a1) -- Line: 1517 -- upvalues: u83 (upval) -- types: a1: userdata
                u83[a1] = nil
            end)
            refreshPortal()
        end

        Remotes.BossEvent.BossDamaged.OnClientEvent:Connect(function() -- Line: 599 -- upvalues: u87 (ref), u92 (upval), TweenService (upval)
            local v1 = u87
            if v1 == nil then
                return
            end
            v1.Outline.Color = u92.FLASH_COLOR
            TweenService:Create(v1.Outline, u92.FLASH_INFO, {Color = v1.OutlineColor}):Play()
        end)
        Remotes.BossEvent.StateShifted.OnClientEvent:Connect(function(a1) -- Line: 1527
            -- upvalues: u122 (ref), u123 (ref), RunService (upval), stepCountdown (val), u8 (val), fadeMusic (val)
            local BossSpawnsAt = a1.BossSpawnsAt
            u122 = BossSpawnsAt
            if BossSpawnsAt ~= nil and u123 == nil then
                RunService.Heartbeat:Connect(function() -- Line: 489 -- upvalues: stepCountdown (upval)
                    stepCountdown()
                end)
            end
            stepCountdown()
            if not a1.Open then
                if not u8.IsPlaying then
                    return
                end
                fadeMusic(0, true)
            end
        end)
        ;(LocalPlayer:GetAttributeChangedSignal(u92.IN_ARENA_ATTRIBUTE)):Connect(function() -- Line: 1433 -- upvalues: LocalPlayer (val), u92 (upval), onEnterArena (val), u75 (val)
            if LocalPlayer:GetAttribute(u92.IN_ARENA_ATTRIBUTE) then
                onEnterArena()
                return
            end
            u75:Clean()
        end)
        if not LocalPlayer:GetAttribute(u92.IN_ARENA_ATTRIBUTE) then
            u75:Clean()
        else
            onEnterArena()
        end
        task.spawn(function() -- Line: 1536 -- upvalues: Remotes (upval), u122 (ref), u123 (ref), RunService (upval), stepCountdown (val)
            local BossSpawnsAt = Remotes.BossEvent.AskSnapshot:InvokeServer().BossSpawnsAt
            u122 = BossSpawnsAt
            if BossSpawnsAt ~= nil and u123 == nil then
                RunService.Heartbeat:Connect(function() -- Line: 489 -- upvalues: stepCountdown (upval)
                    stepCountdown()
                end)
            end
            stepCountdown()
        end)
        Workspace.ChildAdded:Connect(function(a1) -- Line: 1540 -- upvalues: u92 (upval), adoptPortal (val) -- types: a1: userdata
            if a1.Name == u92.PORTAL_MODEL_NAME and a1:IsA("Model") then
                adoptPortal(a1)
            end
        end)
        Workspace.ChildRemoved:Connect(function(a1) -- Line: 1545 -- upvalues: u82 (ref), u81 (val) -- types: a1: userdata
            if a1 == u82 then
                u81:Clean()
            end
        end)
        Save.WatchFields("SpeedPower", refreshPortal)
        RiftFlags.SpeedPowerRequirement.Changed:Connect(refreshPortal)
        BossEventFlags.ContentEnabled.Changed:Connect(refreshPortal)
        ;(Workspace:GetAttributeChangedSignal(RiftEligibility.OpenAttribute)):Connect(refreshPortal)
        ;(LocalPlayer:GetAttributeChangedSignal(RiftEligibility.CutsceneSeenAttribute)):Connect(refreshPortal)
        task.spawn(function() -- Line: 1555
            -- upvalues: Workspace (upval), u92 (upval), adoptPortal (val), Save (upval), refreshPortal (val)
            local v1 = Workspace:FindFirstChild(u92.PORTAL_MODEL_NAME)
            if v1 ~= nil and v1:IsA("Model") then
                adoptPortal(v1)
            end
            Save.Await()
            refreshPortal()
        end)
    end,
}