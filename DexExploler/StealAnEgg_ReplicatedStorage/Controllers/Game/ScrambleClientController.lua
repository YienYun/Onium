-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController
-- Decompile time: 89.88 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Emit = require(game.ReplicatedStorage.UserGenerated.VFX.Emit)
local Break = game.ReplicatedStorage.Assets.VFX.Sakura.Break
local Scramble = require(ReplicatedStorage.Shared.Remotes).Scramble
local ScrambleMotion = require(ReplicatedStorage.Shared.Util.ScrambleMotion)
local DroneVisual = require(script.DroneVisual)
local Hud = require(ReplicatedStorage.Client.Hud)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Save = require(ReplicatedStorage.Shared.Save)
local GameplayBalance = require(ReplicatedStorage.Shared.Flags.GameplayBalance)
local Gears = require(ReplicatedStorage.Data.Gears)
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local ScrambleBossFlags = require(ReplicatedStorage.Shared.Flags.ScrambleBossFlags)
local RaceRallySchedule = require(ReplicatedStorage.Shared.Util.RaceRallySchedule)
local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local ScramblePickupMotion = require(ReplicatedStorage.Shared.Util.ScramblePickupMotion)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
return {
    Start = function() -- Line: 29
        -- upvalues: ReplicatedStorage (val), Players (val), Constants (val), Hud (val), Save (val)
        -- upvalues: ScrambleBossFlags (val), RaceRallySchedule (val), RiftEligibility (val), BossEventFlags (val)
        -- upvalues: ButtonFX (val), Tabs (val), Gears (val), GameplayBalance (val), Scramble (val)
        -- upvalues: ScrambleMotion (val), DroneVisual (val), TweenService (val), Debris (val), Break (val), Emit (val)
        -- upvalues: CollectionService (val), RunService (val), ScramblePickupMotion (val), RiftFlags (val)
        local RemovalTimer_2
        local Scramble_2 = ReplicatedStorage.Assets.UI:WaitForChild("Scramble")
        local Audio = require(ReplicatedStorage.Shared.Audio)
        local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
        local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
        local LocalPlayer = Players.LocalPlayer
        local VaultSequence = require(script.VaultSequence)
        local Scramble_3 = ReplicatedStorage.Assets.Models:WaitForChild("Scramble")
        local Folder = Instance.new("Folder")
        Folder.Name = "ScrambleLocalVisuals"
        Folder.Parent = workspace
        local u41 = {}
        local u42 = {}
        local u43 = {}
        local u44 = {}
        local u55 = require(script.HitFeedback).new(LocalPlayer:WaitForChild("PlayerGui"), Scramble_2.Label)
        local u56 = 0
        local u57 = nil
        local u58 = -1
        local u59 = -1
        local u60 = nil
        local u61 = 0
        local u64 = nil
        local u65 = nil
        local u71 = require(script.SleepingBrock).new()
        local u76 = Color3.fromRGB(168, 244, 120)
        local u77 = 0
        local u89 = ColorSequence.new(Color3.fromRGB(126, 66, 196), Color3.fromRGB(198, 146, 255))
        local u101 = ColorSequence.new(Color3.fromRGB(60, 255, 0), Color3.fromRGB(136, 255, 0))
        local u106 = Color3.fromRGB(38, 12, 76)
        local u111 = Color3.fromRGB(228, 200, 255)
        local u116 = Color3.fromRGB(11, 72, 0)
        local u121 = Color3.fromRGB(190, 255, 180)

        local function questAvailable() -- Line: 65 -- upvalues: u57 (ref)
            local v1 = false
            if u57 ~= nil then
                v1 = false
                if u57.Ready == true then
                    v1 = false
                    if u57.Enabled == true then
                        v1 = false
                        if u57.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                        end
                    end
                end
            end
            return v1
        end

        local function updateLive() -- Line: 72 -- upvalues: Constants (upval)
            local ServerTimeNow = workspace:GetServerTimeNow()
            return Constants.UPDATE_LIVE_AT <= ServerTimeNow
        end

        local function make(a1, a2, a3) -- Line: 76 -- types: a1: string, a2: userdata?
            local v1 = Instance.new(a1)
            for i, j in a3 do
                v1[i] = j
            end
            v1.Parent = a2
            return v1
        end

        local function label(a1, a2, a3) -- Line: 84
            -- upvalues: Scramble_2 (val)
            local v1 = Scramble_2.Label:Clone()
            v1.AnchorPoint = Vector2.zero
            local v2 = UDim2.fromOffset(0, 0)
            local v3 = UDim2.new(1, 0, 0, a3)
            v1.Position = v2
            v1.Size = v3
            v1.Text = a2
            v1.TextScaled = true
            v1.TextWrapped = false
            v1.Parent = a1
            return v1
        end

        local ExperimentTimer = Hud.Every("ExperimentTimer")
        local ExperimentTimerValue = Hud.Every("ExperimentTimerValue")
        for i, j in ExperimentTimer do
            j.Visible = false
        end

        local function updateExperimentTimer(a1) -- Line: 97
            -- upvalues: u57 (ref), Save (upval), LocalPlayer (val), ScrambleBossFlags (upval)
            -- upvalues: RaceRallySchedule (upval), ExperimentTimerValue (val), ExperimentTimer (val)
            local Window = u57 and u57.Window
            local TimerMinSpeed = u57 and u57.TimerMinSpeed
            local v1 = Window and Window.Active == true
            local EndsAt = Window and (if not v1 then Window.NextAt else Window.EndsAt)
            local EventEndsAt = u57 and u57.EventEndsAt
            local v2 = Save.Peek()
            local SpeedPower = v2 and v2.SpeedPower
            v2 = if typeof(EndsAt) ~= "number" then 0 else EndsAt - a1
            local v3 = false
            if u57 ~= nil then
                v3 = false
                if u57.Enabled == true then
                    v3 = false
                    if u57.Ready == true then
                        v3 = false
                        if Window ~= nil then
                            v3 = false
                            if Window.Available == true then
                                v3 = false
                                if typeof(TimerMinSpeed) == "number" then
                                    v3 = false
                                    if TimerMinSpeed > 0 then
                                        v3 = false
                                        if TimerMinSpeed < (1 / 0) then
                                            v3 = false
                                            if typeof(SpeedPower) == "number" then
                                                v3 = false
                                                if TimerMinSpeed <= SpeedPower then
                                                    v3 = false
                                                    if SpeedPower < (1 / 0) then
                                                        v3 = false
                                                        if typeof(EndsAt) == "number" then
                                                            v3 = false
                                                            if typeof(EventEndsAt) == "number" then
                                                                if v1 then
                                                                    v3 = false
                                                                    if v2 > 0 then
                                                                        v3 = v1 or v2 <= 300
                                                                    end
                                                                else
                                                                    v3 = false
                                                                    if EndsAt < EventEndsAt then
                                                                        v3 = false
                                                                        if v2 > 0 then
                                                                            v3 = v1 or v2 <= 300
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            local v4 = 0
            if not v3
                and LocalPlayer:GetAttribute("ScrambleCountdownReturningPlayer") == true
                and ScrambleBossFlags.ContentEnabled:Get()
                and ScrambleBossFlags.ScheduleEnabled:Get()
                and workspace:GetAttribute("Event_ScrambleBoss") ~= true then
                local v5 = ScrambleBossFlags.ScheduleIntervalSeconds:Get()
                local v6 = (math.floor(a1 / v5) + 1) * v5
                if not RaceRallySchedule.ClaimsBoundary(v6) then
                    v4 = v6 - a1
                    local v7 = false
                    if v4 > 0 then
                        v7 = v4 <= 300
                    end
                    v3 = v7
                end
            end
            if v3 then
                local v8 = math.ceil(if not (v4 > 0) then v2 else v4)
                local v9 = string.format(
                    if not (v4 > 0) then if not v1 then "in %dm %ds" else "Event ends in %dm %ds" else "in %dm %ds",
                    v8 // 60,
                    v8 % 60
                )
                for i, j in ExperimentTimerValue do
                    if j.Text ~= v9 then
                        j.Text = v9
                    end
                end
            end
            for k, n in ExperimentTimer do
                if n.Visible ~= v3 then
                    n.Visible = v3
                end
            end
        end

        local u149 = {}
        for k, n in Hud.Every("QuestlineButton") do
            RemovalTimer_2 = n:FindFirstChild("RemovalTimer")
            if RemovalTimer_2 and RemovalTimer_2:IsA("TextLabel") then
                RemovalTimer_2.Visible = false
                table.insert(u149, {Prefix = "", Label = RemovalTimer_2})
            end
        end
        local RemovalTimer = require(ReplicatedStorage.Client.GUI).Get("ScrambleBossMastery").Frame.Header:FindFirstChild("RemovalTimer")
        if RemovalTimer and RemovalTimer:IsA("TextLabel") then
            RemovalTimer.Visible = false
            table.insert(u149, {Prefix = "Leaves in ", Label = RemovalTimer})
        end

        local function updateRemovalTimers(a1) -- Line: 176
            -- upvalues: ScrambleBossFlags (upval), u149 (val)
            local v1 = ScrambleBossFlags.RemovalAt:Get()
            local v2 = math.ceil(v1 - a1)
            local v3 = false
            if v1 > 0 then
                v3 = v2 > 0
            end
            v1 = if not v3 then "" else if not (v2 >= 86400) then string.format("%02d:%02d:%02d", v2 // 3600, v2 // 60 % 60, v2 % 60) else string.format("%dd %dh %dm", v2 // 86400, v2 // 3600 % 24, v2 // 60 % 60)
            local v4 = nil
            local v5 = nil
            for i, j in u149, v4, v5 do
                v2 = if not v3 then "" else j.Prefix .. v1
                if j.Label.Text ~= v2 then
                    j.Label.Text = v2
                end
                if j.Label.Visible ~= v3 then
                    j.Label.Visible = v3
                end
            end
        end

        local u197 = require(ReplicatedStorage.Client.GUI).Get("StolenVaultEvent")
        local u206 = (require(script.Interface)).new(function(a1, a2, a3) -- Line: 206 -- upvalues: u64 (ref)
            return u64(a1, a2, a3)
        end)
        local u213 = (require(script.ShopInterface)).new(function(a1, a2, a3) -- Line: 209 -- upvalues: u64 (ref)
            return u64(a1, a2, a3)
        end)
        local u221 = (require(script.MasteryInterface)).new(function(a1, a2, a3) -- Line: 212 -- upvalues: u64 (ref)
            return u64(a1, a2, a3)
        end, function() -- Line: 214 -- upvalues: u213 (val)
            u213.Show()
        end)
        local u227 = require(script.Dialogue).new()
        local u228 = false
        local QuestlineButton = Hud.Every("QuestlineButton")
        local RiftButton = Hud.Every("RiftButton")
        local u237 = {}

        local function applyEventButtonStyle(a1, a2) -- Line: 223
            -- upvalues: u101 (val), u89 (val), u116 (val), u106 (val), u121 (val), u111 (val)
            local ImageLabel = a1:FindFirstChild("ImageLabel")
            local UIGradient = a1:FindFirstChild("UIGradient")
            local UIStroke = a1:FindFirstChild("UIStroke")
            local UIStrokeClr = a1:FindFirstChild("UIStrokeClr")
            if ImageLabel and ImageLabel:IsA("ImageLabel") then
                ImageLabel.Image = if not a2 then "rbxassetid://84787104764975" else "rbxassetid://98847011195862"
            end
            if UIGradient and UIGradient:IsA("UIGradient") then
                UIGradient.Color = if not a2 then u89 else u101
            end
            if UIStroke and UIStroke:IsA("UIStroke") then
                UIStroke.Color = if not a2 then u106 else u116
            end
            if UIStrokeClr and UIStrokeClr:IsA("UIStroke") then
                UIStrokeClr.Color = if not a2 then u111 else u121
            end
        end

        local function scrambleHudRequested() -- Line: 242 -- upvalues: u57 (ref)
            if u57 ~= nil then
                return u57.ShowHUD == true
            end
            local v1 = false
            if workspace:GetAttribute("ScrambleHUDUnlocked") == true then
                v1 = workspace:GetAttribute("ScrambleHUDAwaitingSammyOutro") ~= true
            end
            return v1
        end

        local function volcanoSpeedReached() -- Line: 250 -- upvalues: Save (upval), RiftEligibility (upval)
            local v1 = Save.Peek()
            local v2 = false
            if v1 ~= nil then
                v2 = RiftEligibility.IsEligible(v1.SpeedPower)
            end
            return v2
        end

        local function riftHudAvailable() -- Line: 255
            -- upvalues: BossEventFlags (upval), Save (upval), RiftEligibility (upval)
            local v1 = BossEventFlags.ContentEnabled:Get()
            if v1 then
                local v2 = Save.Peek()
                v1 = false
                if v2 ~= nil then
                    v1 = RiftEligibility.IsEligible(v2.SpeedPower)
                end
            end
            return v1
        end

        local function updateEventButtons() -- Line: 259
            -- upvalues: u57 (ref), Save (upval), RiftEligibility (upval), BossEventFlags (upval), QuestlineButton (val)
            -- upvalues: RiftButton (val)
            local v1, v2
            if u57 == nil then
                v1 = false
                if workspace:GetAttribute("ScrambleHUDUnlocked") == true then
                    v1 = workspace:GetAttribute("ScrambleHUDAwaitingSammyOutro") ~= true
                end
            else
                v1 = u57.ShowHUD == true
            end
            if v1 then
                v1 = false
                if u57 ~= nil then
                    v1 = false
                    if u57.Ready == true then
                        v1 = false
                        if u57.Enabled == true then
                            v1 = false
                            if u57.WorldReady == true then
                                v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                if v1 then
                    v2 = Save.Peek()
                    v1 = false
                    if v2 ~= nil then
                        v1 = RiftEligibility.IsEligible(v2.SpeedPower)
                    end
                end
            end
            v2 = BossEventFlags.ContentEnabled:Get()
            if v2 then
                local v3 = Save.Peek()
                v2 = false
                if v3 ~= nil then
                    v2 = RiftEligibility.IsEligible(v3.SpeedPower)
                end
            end
            for i, j in QuestlineButton do
                j.Visible = v1
            end
            for k, n in RiftButton do
                n.Visible = v2
            end
        end

        local function bindEventButtons(a1, a2) -- Line: 272
            -- upvalues: applyEventButtonStyle (val), u237 (val), ButtonFX (upval), u57 (ref), Save (upval)
            -- upvalues: RiftEligibility (upval), Tabs (upval), u213 (val), Constants (upval), u221 (val)
            -- upvalues: BossEventFlags (upval)
            local Badge
            local v1 = nil
            local v2 = nil
            for i, j in a1, v1, v2 do
                j.Visible = false
                applyEventButtonStyle(j, a2)
                Badge = j:FindFirstChild("Badge")
                if Badge and Badge:IsA("GuiObject") then
                    Badge.Visible = false
                end
                table.insert(u237, (ButtonFX(j, 1.08, function() -- Line: 283
                    -- upvalues: a2 (val), u57 (upval), Save (upval), RiftEligibility (upval), Tabs (upval)
                    -- upvalues: u213 (upval), Constants (upval), u221 (upval), BossEventFlags (upval)
                    local v1, v2
                    if not a2 then
                        v1 = BossEventFlags.ContentEnabled:Get()
                        if v1 then
                            v2 = Save.Peek()
                            v1 = false
                            if v2 ~= nil then
                                v1 = RiftEligibility.IsEligible(v2.SpeedPower)
                            end
                        end
                        if v1 then
                            Tabs.Toggle("BossMastery")
                        end
                        return
                    end
                    if u57 == nil then
                        v1 = false
                        if workspace:GetAttribute("ScrambleHUDUnlocked") == true then
                            v1 = workspace:GetAttribute("ScrambleHUDAwaitingSammyOutro") ~= true
                        end
                    else
                        v1 = u57.ShowHUD == true
                    end
                    if v1 then
                        v1 = false
                        if u57 ~= nil then
                            v1 = false
                            if u57.Ready == true then
                                v1 = false
                                if u57.Enabled == true then
                                    v1 = false
                                    if u57.WorldReady == true then
                                        v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                                    end
                                end
                            end
                        end
                        if v1 then
                            v2 = Save.Peek()
                            v1 = false
                            if v2 ~= nil then
                                v1 = RiftEligibility.IsEligible(v2.SpeedPower)
                            end
                            if v1 then
                                if Tabs.IsActive("DrScrambleEvent") then
                                    u213.Close()
                                    return
                                end
                                local ServerTimeNow_2 = workspace:GetServerTimeNow()
                                if Constants.UPDATE_LIVE_AT <= ServerTimeNow_2 then
                                    u221.Toggle()
                                    return
                                end
                                u213.Show()
                                return
                            end
                        end
                    end
                end)))
            end
        end

        bindEventButtons(QuestlineButton, true)
        bindEventButtons(RiftButton, false)
        local Toast = require(ReplicatedStorage.Client.Notifications.Toast)

        local function toast(a1) -- Line: 310 -- upvalues: Toast (val), u76 (val) -- types: a1: string
            Toast.Show({
                Seconds = 2.5,
                SingleLine = true,
                Unique = true,
                Text = a1,
                Color = u76,
            })
        end

        local function playerRoot(a1) -- Line: 319 -- types: a1: userdata?
            local Character = a1 and a1.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and 0 < Humanoid.Health then
                return (Character:FindFirstChild("HumanoidRootPart"))
            end
            return nil
        end

        local function root() -- Line: 326 -- upvalues: LocalPlayer (val)
            local v1 = LocalPlayer
            local Character = v1 and v1.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and 0 < Humanoid.Health then
                return (Character:FindFirstChild("HumanoidRootPart"))
            end
            return nil
        end

        local function batIn(a1) -- Line: 329 -- upvalues: Gears (upval) -- types: a1: userdata
            local Attribute, v1
            for i, j in a1:GetChildren() do
                if j:IsA("Tool") then
                    if j:GetAttribute("IsBat") == true then
                        return j
                    end
                    Attribute = j:GetAttribute("GearName")
                    v1 = if typeof(Attribute) ~= "string" then nil else Gears.Directory[Attribute]
                    if v1 then
                        if v1.BatControllerData == nil and v1.ToolController ~= "Slap" then
                            continue
                        end
                        return j
                    end
                end
            end
            return nil
        end

        local function droneWithinAutoAttackRadius(a1) -- Line: 345 -- upvalues: u43 (val) -- types: a1: vector
            local Attribute, Hitbox
            local v1 = nil
            local v2 = nil
            for i in u43, v1, v2 do
                Hitbox = i:FindFirstChild("Hitbox")
                Attribute = Hitbox and Hitbox:GetAttribute("Health")
                if Hitbox
                    and Hitbox:IsA("BasePart")
                    and typeof(Attribute) == "number"
                    and Attribute > 0
                    and (Hitbox.Position - v3).Magnitude <= 12 then
                    return true
                end
            end
            return false
        end

        local function updateAutoAttack() -- Line: 361
            -- upvalues: VaultSequence (val), u57 (ref), LocalPlayer (val), droneWithinAutoAttackRadius (val)
            -- upvalues: batIn (val), u77 (ref), GameplayBalance (upval)
            if VaultSequence.IsPlaying() then
                return
            end
            if u57 and u57.Window and u57.Window.Active == true then
                local Character = LocalPlayer.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local v1 = LocalPlayer
                local Character_2 = v1 and v1.Character
                local Humanoid_2 = Character_2 and Character_2:FindFirstChildOfClass("Humanoid")
                local v2 = if not Humanoid_2 then nil else if not (0 < Humanoid_2.Health) then nil else Character_2:FindFirstChild("HumanoidRootPart")
                if Character and Humanoid and v2 and droneWithinAutoAttackRadius(v2.Position) then
                    v2 = batIn(Character)
                    if not v2 then
                        local v3 = LocalPlayer:FindFirstChildOfClass("Backpack")
                        if not (if not v3 then nil else batIn(v3)) then
                            return
                        end
                        Humanoid:EquipTool(v2)
                        u77 = math.max(u77, (workspace:GetServerTimeNow()) + 0.1)
                        return
                    end
                    local v4 = workspace:GetServerTimeNow()
                    local Attribute = v2:GetAttribute("CooldownEndTime")
                    if typeof(Attribute) == "number" then
                        u77 = math.max(u77, Attribute)
                    end
                    if not (v4 < u77) and v2:GetAttribute("CooldownActive") ~= true then
                        u77 = v4 + math.max(GameplayBalance.BatClient.CLIENT_COOLDOWN, GameplayBalance.BatServer.PLAYER_COOLDOWN)
                        v2:Activate()
                        return
                    end
                    return
                end
                return
            end
        end

        local function removeDrop(a1) -- Line: 405 -- upvalues: u41 (val), u56 (ref) -- types: a1: string
            local v1 = u41[a1]
            if not v1 then
                return
            end
            if v1.Observer then
                u56 = u56 - 1
            end
            v1.Model:Destroy()
            u41[a1] = nil
        end

        local function setHidden(a1, a2) -- Line: 416 -- types: a2: boolean
            if a1.Hidden == a2 then
                return
            end
            a1.Hidden = a2
            local Parts = a1.Parts
            local v1 = nil
            local v2 = nil
            local v3, v4 = a2, a1
            for i, j in Parts, v1, v2 do
                j.LocalTransparencyModifier = if not v3 then 0 else 1
            end
            if v3 and v4.Floating then
                v4.Model:PivotTo(v4.BasePivot)
            end
        end

        local function stopQuestView(a1) -- Line: 428
            if a1.IdleTrack then
                a1.IdleTrack:Stop(0)
                a1.IdleTrack:Destroy()
                a1.IdleTrack = nil
            end
            if a1.Prompt and not a1.Floating then
                a1.Prompt:Destroy()
            end
        end

        local function updateQuestIdle(a1) -- Line: 438 -- upvalues: u57 (ref)
            local IdleTrack = a1.IdleTrack
            if not IdleTrack then
                return
            end
            local CurrentCamera = workspace.CurrentCamera
            local v1 = false
            if u57 ~= nil then
                v1 = false
                if u57.Ready == true then
                    v1 = false
                    if u57.Enabled == true then
                        v1 = false
                        if u57.WorldReady == true then
                            v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                        end
                    end
                end
            end
            if v1 then
                v1 = not a1.Hidden
                if v1 then
                    v1 = false
                    if CurrentCamera ~= nil then
                        v1 = a1.Model:IsDescendantOf(workspace) and (CurrentCamera.CFrame.Position - a1.Model:GetPivot().Position).Magnitude <= 160
                    end
                end
            end
            if a1.IdlePlaying == v1 then
                return
            end
            a1.IdlePlaying = v1
            if v1 then
                IdleTrack:Play(0.2)
                return
            end
            IdleTrack:Stop(0.2)
        end

        local function loadQuestIdle(a1, a2) -- Line: 459
            -- upvalues: u42 (val), updateQuestIdle (val)
            local AnimationController = a1.Model:FindFirstChildOfClass("AnimationController")
            local Animator = AnimationController
            if Animator then
                Animator = AnimationController:FindFirstChildOfClass("Animator")
            end
            local ScrambleIdle = AnimationController
            if ScrambleIdle then
                ScrambleIdle = AnimationController:FindFirstChild("ScrambleIdle")
            end
            if Animator and ScrambleIdle and ScrambleIdle:IsA("Animation") then
                task.spawn(function() -- Line: 466
                    -- upvalues: Animator (val), ScrambleIdle (val), u42 (upval), a2 (val), a1 (val)
                    -- upvalues: updateQuestIdle (upval)
                    local success, err = pcall(function() -- Line: 467 -- upvalues: Animator (upval), ScrambleIdle (upval)
                        return Animator:LoadAnimation(ScrambleIdle)
                    end)
                    if not success then
                        warn("[Scramble] NPC idle could not load:", err)
                        return
                    end
                    if u42[a2] == a1 and a1.Model:IsDescendantOf(workspace) then
                        err.Looped = true
                        err.Priority = Enum.AnimationPriority.Idle
                        a1.IdleTrack = err
                        updateQuestIdle(a1)
                        return
                    end
                    err:Destroy()
                end)
                return
            end
        end

        local function syncQuest() -- Line: 484
            -- upvalues: u57 (ref), u42 (val), updateQuestIdle (val), u227 (val), VaultSequence (val)
            local Completed, v1, v2, v3, v4
            if not u57 then
                return
            end
            local v5 = nil
            local v6 = nil
            for i, j in u42, v5, v6 do
                v2 = false
                if u57 ~= nil then
                    v2 = false
                    if u57.Ready == true then
                        v2 = false
                        if u57.Enabled == true then
                            v2 = false
                            if u57.WorldReady == true then
                                v2 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                v1 = not v2
                if i == "LostPart1" or i == "LostPart2" then
                    v1 = v1 or u57.State and (u57.State.LostParts[i] or u57.State.Completed)
                end
                v2 = v1 == true
                if j.Hidden ~= v2 then
                    j.Hidden = v2
                    v3 = nil
                    v4 = nil
                    for k, n in j.Parts, v3, v4 do
                        n.LocalTransparencyModifier = if not v2 then 0 else 1
                    end
                    if v2 and j.Floating then
                        j.Model:PivotTo(j.BasePivot)
                    end
                end
                updateQuestIdle(j)
                if j.Prompt then
                    j.Prompt.Enabled = not v1 and u57.Ready and not u227.IsPlaying(j.Model) and not VaultSequence.IsPlaying()
                    if u57.Interactions and not j.Floating then
                        j.Prompt.MaxActivationDistance = u57.Interactions.NpcRadius
                    end
                end
                if i == "ExperimentVault" and u57.State then
                    Completed = u57.State.Completed
                    if j.Open ~= Completed and not VaultSequence.IsPlaying() then
                        VaultSequence.SetOpen(j.Model, Completed)
                        j.Open = Completed
                    end
                end
            end
        end

        local function registerQuest(a1) -- Line: 514
            -- upvalues: u197 (val), u42 (val), loadQuestIdle (val), u227 (val), VaultSequence (val), u57 (ref)
            -- upvalues: u64 (ref), u228 (ref), u206 (val), u213 (val), syncQuest (val)
            if u197.Parent and a1:IsA("Model") then
                local v1 = workspace
                if a1:IsDescendantOf(v1) then
                    local Attribute = a1:GetAttribute("ScrambleQuestId")
                    if type(Attribute) ~= "string" then
                        return
                    end
                    local v2 = true
                    if Attribute ~= "LostPart1" then
                        v2 = Attribute == "LostPart2"
                    end
                    local PrimaryPart = a1.PrimaryPart
                    local InteractionPoint = if Attribute ~= "EscapedExperiment" then nil else a1:FindFirstChild("InteractionPoint", true)
                    local ClaimLostPart = if not v2 then nil else if not PrimaryPart then nil else PrimaryPart:FindFirstChild("ClaimLostPart")
                    local v3 = u42[Attribute]
                    if v3 and v3.Model == a1 then
                        local Prompt = v3.Prompt
                        if Attribute ~= "EscapedExperiment" then
                            if not v2 or Prompt and Prompt == ClaimLostPart and Prompt:IsDescendantOf(a1) then
                                return
                            end
                        elseif Prompt and Prompt.Parent == InteractionPoint and Prompt:IsDescendantOf(a1) then
                            return
                        end
                    end
                    if v3 then
                        if v3.IdleTrack then
                            v3.IdleTrack:Stop(0)
                            v3.IdleTrack:Destroy()
                            v3.IdleTrack = nil
                        end
                        if v3.Prompt and not v3.Floating then
                            v3.Prompt:Destroy()
                        end
                        u42[Attribute] = nil
                    end
                    if PrimaryPart and PrimaryPart:IsDescendantOf(a1) then
                        local u171
                        if Attribute ~= "EscapedExperiment" then
                            if v2 then
                                if ClaimLostPart and ClaimLostPart:IsA("ProximityPrompt") then
                                    v3 = {}
                                    for i8, i9 in a1:GetDescendants() do
                                        if i9:IsA("BasePart") then
                                            table.insert(v3, i9)
                                        end
                                    end
                                    v1 = {
                                        Model = a1,
                                        Parts = v3,
                                        BasePivot = a1:GetPivot(),
                                        Floating = v2,
                                        Phase = if Attribute ~= "LostPart1" then 3.141592653589793 else 0,
                                        Prompt = ClaimLostPart,
                                    }
                                    u42[Attribute] = v1
                                    if Attribute == "EscapedExperiment" then
                                        loadQuestIdle(v1, Attribute)
                                    end
                                    if Attribute == "EscapedExperiment" and InteractionPoint then
                                        u171 = Instance.new("ProximityPrompt")
                                        for i10, i11 in {
                                            Name = "ScrambleTalk",
                                            ActionText = "Talk",
                                            ObjectText = "Escaped Experiment",
                                            HoldDuration = 0,
                                            Enabled = false,
                                            RequiresLineOfSight = true,
                                        } do
                                            u171[i10] = i11
                                        end
                                        u171.Parent = InteractionPoint
                                        v1.Prompt = u171
                                        u171.Triggered:Connect(function() -- Line: 595
                                            -- upvalues: u227 (upval), a1 (val), VaultSequence (upval), u57 (upval)
                                            -- upvalues: u64 (upval), u228 (upval), u206 (upval), u213 (upval)
                                            -- upvalues: u171 (val)
                                            if not u227.IsPlaying(a1) and not VaultSequence.IsPlaying() then
                                                local State = u57 and u57.State and u57.State.Discovered
                                                local Discover = u64("Discover")
                                                if Discover and Discover.Ok and u57 and u57.State then
                                                    if u57.State.TotalParts ~= 5 and not u57.State.Completed then
                                                        if State and not u228 then
                                                            u206.ShowVault()
                                                            return
                                                        end
                                                        u228 = true
                                                        u206.Close()
                                                        u213.Close()
                                                        u227.Start(a1, u171, function() -- Line: 612 -- upvalues: u228 (upval), u206 (upval)
                                                            u228 = false
                                                            u206.ShowVault()
                                                        end)
                                                        return
                                                    end
                                                    u206.ShowVault()
                                                    return
                                                end
                                                return
                                            end
                                        end)
                                    end
                                    syncQuest()
                                    return
                                end
                                return
                            end
                            v3 = {}
                            for i12, i13 in a1:GetDescendants() do
                                if i13:IsA("BasePart") then
                                    table.insert(v3, i13)
                                end
                            end
                            v1 = {
                                Model = a1,
                                Parts = v3,
                                BasePivot = a1:GetPivot(),
                                Floating = v2,
                                Phase = if Attribute ~= "LostPart1" then 3.141592653589793 else 0,
                                Prompt = ClaimLostPart,
                            }
                            u42[Attribute] = v1
                            if Attribute == "EscapedExperiment" then
                                loadQuestIdle(v1, Attribute)
                            end
                            if Attribute == "EscapedExperiment" and InteractionPoint then
                                u171 = Instance.new("ProximityPrompt")
                                for i14, i15 in {
                                    Name = "ScrambleTalk",
                                    ActionText = "Talk",
                                    ObjectText = "Escaped Experiment",
                                    HoldDuration = 0,
                                    Enabled = false,
                                    RequiresLineOfSight = true,
                                } do
                                    u171[i14] = i15
                                end
                                u171.Parent = InteractionPoint
                                v1.Prompt = u171
                                u171.Triggered:Connect(function() -- Line: 595
                                    -- upvalues: u227 (upval), a1 (val), VaultSequence (upval), u57 (upval), u64 (upval)
                                    -- upvalues: u228 (upval), u206 (upval), u213 (upval), u171 (val)
                                    if not u227.IsPlaying(a1) and not VaultSequence.IsPlaying() then
                                        local State = u57 and u57.State and u57.State.Discovered
                                        local Discover = u64("Discover")
                                        if Discover and Discover.Ok and u57 and u57.State then
                                            if u57.State.TotalParts ~= 5 and not u57.State.Completed then
                                                if State and not u228 then
                                                    u206.ShowVault()
                                                    return
                                                end
                                                u228 = true
                                                u206.Close()
                                                u213.Close()
                                                u227.Start(a1, u171, function() -- Line: 612 -- upvalues: u228 (upval), u206 (upval)
                                                    u228 = false
                                                    u206.ShowVault()
                                                end)
                                                return
                                            end
                                            u206.ShowVault()
                                            return
                                        end
                                        return
                                    end
                                end)
                            end
                            syncQuest()
                            return
                        end
                        if InteractionPoint
                            and InteractionPoint:IsA("Attachment")
                            and InteractionPoint.Parent
                            and InteractionPoint.Parent:IsA("BasePart") then
                            if not v2 then
                                v3 = {}
                                for m, i5 in a1:GetDescendants() do
                                    if i5:IsA("BasePart") then
                                        table.insert(v3, i5)
                                    end
                                end
                                v1 = {
                                    Model = a1,
                                    Parts = v3,
                                    BasePivot = a1:GetPivot(),
                                    Floating = v2,
                                    Phase = if Attribute ~= "LostPart1" then 3.141592653589793 else 0,
                                    Prompt = ClaimLostPart,
                                }
                                u42[Attribute] = v1
                                if Attribute == "EscapedExperiment" then
                                    loadQuestIdle(v1, Attribute)
                                end
                                if Attribute == "EscapedExperiment" and InteractionPoint then
                                    u171 = Instance.new("ProximityPrompt")
                                    for i6, i7 in {
                                        Name = "ScrambleTalk",
                                        ActionText = "Talk",
                                        ObjectText = "Escaped Experiment",
                                        HoldDuration = 0,
                                        Enabled = false,
                                        RequiresLineOfSight = true,
                                    } do
                                        u171[i6] = i7
                                    end
                                    u171.Parent = InteractionPoint
                                    v1.Prompt = u171
                                    u171.Triggered:Connect(function() -- Line: 595
                                        -- upvalues: u227 (upval), a1 (val), VaultSequence (upval), u57 (upval)
                                        -- upvalues: u64 (upval), u228 (upval), u206 (upval), u213 (upval), u171 (val)
                                        if not u227.IsPlaying(a1) and not VaultSequence.IsPlaying() then
                                            local State = u57 and u57.State and u57.State.Discovered
                                            local Discover = u64("Discover")
                                            if Discover and Discover.Ok and u57 and u57.State then
                                                if u57.State.TotalParts ~= 5 and not u57.State.Completed then
                                                    if State and not u228 then
                                                        u206.ShowVault()
                                                        return
                                                    end
                                                    u228 = true
                                                    u206.Close()
                                                    u213.Close()
                                                    u227.Start(a1, u171, function() -- Line: 612 -- upvalues: u228 (upval), u206 (upval)
                                                        u228 = false
                                                        u206.ShowVault()
                                                    end)
                                                    return
                                                end
                                                u206.ShowVault()
                                                return
                                            end
                                            return
                                        end
                                    end)
                                end
                                syncQuest()
                                return
                            end
                            if ClaimLostPart and ClaimLostPart:IsA("ProximityPrompt") then
                                v3 = {}
                                for i, j in a1:GetDescendants() do
                                    if j:IsA("BasePart") then
                                        table.insert(v3, j)
                                    end
                                end
                                v1 = {
                                    Model = a1,
                                    Parts = v3,
                                    BasePivot = a1:GetPivot(),
                                    Floating = v2,
                                    Phase = if Attribute ~= "LostPart1" then 3.141592653589793 else 0,
                                    Prompt = ClaimLostPart,
                                }
                                u42[Attribute] = v1
                                if Attribute == "EscapedExperiment" then
                                    loadQuestIdle(v1, Attribute)
                                end
                                if Attribute == "EscapedExperiment" and InteractionPoint then
                                    u171 = Instance.new("ProximityPrompt")
                                    for k, n in {
                                        Name = "ScrambleTalk",
                                        ActionText = "Talk",
                                        ObjectText = "Escaped Experiment",
                                        HoldDuration = 0,
                                        Enabled = false,
                                        RequiresLineOfSight = true,
                                    } do
                                        u171[k] = n
                                    end
                                    u171.Parent = InteractionPoint
                                    v1.Prompt = u171
                                    u171.Triggered:Connect(function() -- Line: 595
                                        -- upvalues: u227 (upval), a1 (val), VaultSequence (upval), u57 (upval)
                                        -- upvalues: u64 (upval), u228 (upval), u206 (upval), u213 (upval), u171 (val)
                                        if not u227.IsPlaying(a1) and not VaultSequence.IsPlaying() then
                                            local State = u57 and u57.State and u57.State.Discovered
                                            local Discover = u64("Discover")
                                            if Discover and Discover.Ok and u57 and u57.State then
                                                if u57.State.TotalParts ~= 5 and not u57.State.Completed then
                                                    if State and not u228 then
                                                        u206.ShowVault()
                                                        return
                                                    end
                                                    u228 = true
                                                    u206.Close()
                                                    u213.Close()
                                                    u227.Start(a1, u171, function() -- Line: 612 -- upvalues: u228 (upval), u206 (upval)
                                                        u228 = false
                                                        u206.ShowVault()
                                                    end)
                                                    return
                                                end
                                                u206.ShowVault()
                                                return
                                            end
                                            return
                                        end
                                    end)
                                end
                                syncQuest()
                                return
                            end
                            return
                        end
                        return
                    end
                    return
                end
            end
        end

        local u301 = false

        local function u302() -- Line: 625
            -- upvalues: u57 (ref), Save (upval), RiftEligibility (upval), BossEventFlags (upval), QuestlineButton (val)
            -- upvalues: RiftButton (val), updateExperimentTimer (val), updateRemovalTimers (val), u206 (val)
            -- upvalues: u213 (val), Constants (upval), u221 (val), u301 (ref)
            local v1, v2
            if u57 == nil then
                v1 = false
                if workspace:GetAttribute("ScrambleHUDUnlocked") == true then
                    v1 = workspace:GetAttribute("ScrambleHUDAwaitingSammyOutro") ~= true
                end
            else
                v1 = u57.ShowHUD == true
            end
            if v1 then
                v1 = false
                if u57 ~= nil then
                    v1 = false
                    if u57.Ready == true then
                        v1 = false
                        if u57.Enabled == true then
                            v1 = false
                            if u57.WorldReady == true then
                                v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                if v1 then
                    v2 = Save.Peek()
                    v1 = false
                    if v2 ~= nil then
                        v1 = RiftEligibility.IsEligible(v2.SpeedPower)
                    end
                end
            end
            v2 = BossEventFlags.ContentEnabled:Get()
            if v2 then
                local v3 = Save.Peek()
                v2 = false
                if v3 ~= nil then
                    v2 = RiftEligibility.IsEligible(v3.SpeedPower)
                end
            end
            for i, j in QuestlineButton do
                j.Visible = v1
            end
            for k, n in RiftButton do
                n.Visible = v2
            end
            local ServerTimeNow_2 = workspace:GetServerTimeNow()
            updateExperimentTimer(ServerTimeNow_2)
            updateRemovalTimers(ServerTimeNow_2)
            if u57 then
                u206.Update(u57)
                u213.Update(u57)
                local ServerTimeNow_3 = workspace:GetServerTimeNow()
                if Constants.UPDATE_LIVE_AT <= ServerTimeNow_3 then
                    u221.Update(u57)
                    u301 = true
                end
            end
        end

        local function addDrops(a1) -- Line: 640
            -- upvalues: u41 (val), LocalPlayer (val), u56 (ref), ReplicatedStorage (upval), Scramble_3 (val)
            -- upvalues: Folder (val), Players (upval), label (val)
            local CurrentCamera, PlayerByUserId, PrimaryPart, ScrambleCurrency, ServerTimeNow, Size, v1, v2, v3, v4, v5, v6, v7
            local v8 = nil
            local v9 = nil
            for i, j in a1, v8, v9 do
                if not u41[j.Id] then
                    ServerTimeNow = workspace:GetServerTimeNow()
                    if not (j.ExpiresAt <= ServerTimeNow) then
                        v4 = false
                        if j.OwnerUserId ~= nil then
                            v4 = j.OwnerUserId ~= LocalPlayer.UserId
                        end
                        CurrentCamera = workspace.CurrentCamera
                        if not v4 then
                            ScrambleCurrency = if j.Kind == "Samples" then ReplicatedStorage.Assets:FindFirstChild("ScrambleCurrency") else if j.Kind ~= "Part" then nil else Scramble_3.Parts:FindFirstChild(j.PartId)
                            if ScrambleCurrency then
                                v6 = ScrambleCurrency:Clone()
                                v5 = j.VisualScale or 1
                                v7 = {}
                                v1 = nil
                                if not v6:IsA("BasePart") then
                                    v6:ScaleTo((v6:GetScale()) * v5)
                                    for k, n in v6:GetDescendants() do
                                        if n:IsA("BasePart") then
                                            table.insert(v7, n)
                                        end
                                    end
                                    v3 = nil
                                    for m, i5 in v7, v3 do
                                        i5.Anchored = true
                                        i5.CanCollide = false
                                        i5.CanTouch = false
                                        i5.CanQuery = false
                                    end
                                    v6:PivotTo((CFrame.new(j.Origin)))
                                    v6.Parent = Folder
                                    v2 = os.clock()
                                    j.Model = v6
                                    j.SpawnedAt = v2
                                    j.NextTry = 0
                                    j.Parts = v7
                                    j.Observer = v4
                                    PlayerByUserId = if not v4 then LocalPlayer else Players:GetPlayerByUserId(j.OwnerUserId)
                                    j.Owner = PlayerByUserId
                                    if v4 then
                                        u56 = u56 + 1
                                    end
                                    v2 = if not j.MagnetAt then nil else j.MagnetAt - j.CreatedAt
                                    j.MagnetDelay = v2
                                    u41[j.Id] = j
                                    if j.Kind ~= "Samples" then
                                        PrimaryPart = v6.PrimaryPart
                                        v3 = {
                                            StudsOffset = Vector3.new(0, 2, 0),
                                            AlwaysOnTop = false,
                                            MaxDistance = 100,
                                            Size = UDim2.fromOffset(160, 32),
                                        }
                                        v5 = Instance.new("BillboardGui")
                                        for i6, i7 in v3 do
                                            v5[i6] = i7
                                        end
                                        v5.Parent = PrimaryPart
                                        j.Billboard = v5
                                        label(v5, "⚙️ DRONE PART", 32)
                                    else
                                        j.Billboard = v1
                                    end
                                    if j.Hidden then
                                        for i8, i9 in v7 do
                                            i9.LocalTransparencyModifier = 1
                                        end
                                        if j.Billboard then
                                            j.Billboard.Enabled = false
                                        end
                                        j.Arrived = true
                                    end
                                else
                                    v6.Size = v6.Size * v5
                                    v1 = v6:FindFirstChildWhichIsA("BillboardGui")
                                    if v1 then
                                        v1.Adornee = v6
                                        Size = v1.Size
                                        v1.Size = UDim2.new(Size.X.Scale * v5, Size.X.Offset * v5, Size.Y.Scale * v5, Size.Y.Offset * v5)
                                        table.insert(v7, v6)
                                        v3 = nil
                                        for i10, i11 in v7, v3 do
                                            i11.Anchored = true
                                            i11.CanCollide = false
                                            i11.CanTouch = false
                                            i11.CanQuery = false
                                        end
                                        v6:PivotTo((CFrame.new(j.Origin)))
                                        v6.Parent = Folder
                                        v2 = os.clock()
                                        j.Model = v6
                                        j.SpawnedAt = v2
                                        j.NextTry = 0
                                        j.Parts = v7
                                        j.Observer = v4
                                        PlayerByUserId = if not v4 then LocalPlayer else Players:GetPlayerByUserId(j.OwnerUserId)
                                        j.Owner = PlayerByUserId
                                        if v4 then
                                            u56 = u56 + 1
                                        end
                                        v2 = if not j.MagnetAt then nil else j.MagnetAt - j.CreatedAt
                                        j.MagnetDelay = v2
                                        u41[j.Id] = j
                                        if j.Kind ~= "Samples" then
                                            PrimaryPart = v6.PrimaryPart
                                            v3 = {
                                                StudsOffset = Vector3.new(0, 2, 0),
                                                AlwaysOnTop = false,
                                                MaxDistance = 100,
                                                Size = UDim2.fromOffset(160, 32),
                                            }
                                            v5 = Instance.new("BillboardGui")
                                            for i12, i13 in v3 do
                                                v5[i12] = i13
                                            end
                                            v5.Parent = PrimaryPart
                                            j.Billboard = v5
                                            label(v5, "⚙️ DRONE PART", 32)
                                        else
                                            j.Billboard = v1
                                        end
                                        if j.Hidden then
                                            for i14, i15 in v7 do
                                                i15.LocalTransparencyModifier = 1
                                            end
                                            if j.Billboard then
                                                j.Billboard.Enabled = false
                                            end
                                            j.Arrived = true
                                        end
                                    else
                                        v6:Destroy()
                                    end
                                end
                            end
                        elseif not (u56 >= 64)
                            and CurrentCamera
                            and not (180 < (CurrentCamera.CFrame.Position - j.Origin).Magnitude) then
                            ScrambleCurrency = if j.Kind == "Samples" then ReplicatedStorage.Assets:FindFirstChild("ScrambleCurrency") else if j.Kind ~= "Part" then nil else Scramble_3.Parts:FindFirstChild(j.PartId)
                            if ScrambleCurrency then
                                v6 = ScrambleCurrency:Clone()
                                v5 = j.VisualScale or 1
                                v7 = {}
                                v1 = nil
                                if not v6:IsA("BasePart") then
                                    v6:ScaleTo((v6:GetScale()) * v5)
                                    for i16, i17 in v6:GetDescendants() do
                                        if i17:IsA("BasePart") then
                                            table.insert(v7, i17)
                                        end
                                    end
                                    v3 = nil
                                    for i18, i19 in v7, v3 do
                                        i19.Anchored = true
                                        i19.CanCollide = false
                                        i19.CanTouch = false
                                        i19.CanQuery = false
                                    end
                                    v6:PivotTo((CFrame.new(j.Origin)))
                                    v6.Parent = Folder
                                    v2 = os.clock()
                                    j.Model = v6
                                    j.SpawnedAt = v2
                                    j.NextTry = 0
                                    j.Parts = v7
                                    j.Observer = v4
                                    PlayerByUserId = if not v4 then LocalPlayer else Players:GetPlayerByUserId(j.OwnerUserId)
                                    j.Owner = PlayerByUserId
                                    if v4 then
                                        u56 = u56 + 1
                                    end
                                    v2 = if not j.MagnetAt then nil else j.MagnetAt - j.CreatedAt
                                    j.MagnetDelay = v2
                                    u41[j.Id] = j
                                    if j.Kind ~= "Samples" then
                                        PrimaryPart = v6.PrimaryPart
                                        v3 = {
                                            StudsOffset = Vector3.new(0, 2, 0),
                                            AlwaysOnTop = false,
                                            MaxDistance = 100,
                                            Size = UDim2.fromOffset(160, 32),
                                        }
                                        v5 = Instance.new("BillboardGui")
                                        for i20, i21 in v3 do
                                            v5[i20] = i21
                                        end
                                        v5.Parent = PrimaryPart
                                        j.Billboard = v5
                                        label(v5, "⚙️ DRONE PART", 32)
                                    else
                                        j.Billboard = v1
                                    end
                                    if j.Hidden then
                                        for i22, i23 in v7 do
                                            i23.LocalTransparencyModifier = 1
                                        end
                                        if j.Billboard then
                                            j.Billboard.Enabled = false
                                        end
                                        j.Arrived = true
                                    end
                                else
                                    v6.Size = v6.Size * v5
                                    v1 = v6:FindFirstChildWhichIsA("BillboardGui")
                                    if v1 then
                                        v1.Adornee = v6
                                        Size = v1.Size
                                        v1.Size = UDim2.new(Size.X.Scale * v5, Size.X.Offset * v5, Size.Y.Scale * v5, Size.Y.Offset * v5)
                                        table.insert(v7, v6)
                                        v3 = nil
                                        for i24, i25 in v7, v3 do
                                            i25.Anchored = true
                                            i25.CanCollide = false
                                            i25.CanTouch = false
                                            i25.CanQuery = false
                                        end
                                        v6:PivotTo((CFrame.new(j.Origin)))
                                        v6.Parent = Folder
                                        v2 = os.clock()
                                        j.Model = v6
                                        j.SpawnedAt = v2
                                        j.NextTry = 0
                                        j.Parts = v7
                                        j.Observer = v4
                                        PlayerByUserId = if not v4 then LocalPlayer else Players:GetPlayerByUserId(j.OwnerUserId)
                                        j.Owner = PlayerByUserId
                                        if v4 then
                                            u56 = u56 + 1
                                        end
                                        v2 = if not j.MagnetAt then nil else j.MagnetAt - j.CreatedAt
                                        j.MagnetDelay = v2
                                        u41[j.Id] = j
                                        if j.Kind ~= "Samples" then
                                            PrimaryPart = v6.PrimaryPart
                                            v3 = {
                                                StudsOffset = Vector3.new(0, 2, 0),
                                                AlwaysOnTop = false,
                                                MaxDistance = 100,
                                                Size = UDim2.fromOffset(160, 32),
                                            }
                                            v5 = Instance.new("BillboardGui")
                                            for i26, i27 in v3 do
                                                v5[i26] = i27
                                            end
                                            v5.Parent = PrimaryPart
                                            j.Billboard = v5
                                            label(v5, "⚙️ DRONE PART", 32)
                                        else
                                            j.Billboard = v1
                                        end
                                        if j.Hidden then
                                            for i28, i29 in v7 do
                                                i29.LocalTransparencyModifier = 1
                                            end
                                            if j.Billboard then
                                                j.Billboard.Enabled = false
                                            end
                                            j.Arrived = true
                                        end
                                    else
                                        v6:Destroy()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local function u312(a1) -- Line: 732
            -- upvalues: u65 (ref), u58 (ref), u60 (ref), u59 (ref), u57 (ref), addDrops (val), VaultSequence (val)
            -- upvalues: u206 (val), u302 (ref), syncQuest (val)
            if not a1 then
                return
            end
            if a1.Drones and u65 then
                u65.Apply(a1.Drones)
            end
            local Revision = a1.Revision
            if typeof(Revision) ~= "number" then
                return
            end
            if u58 < Revision then
                u58 = Revision
                u60 = {State = a1.State, Ready = a1.Ready}
            end
            if not a1.Patch and u59 < Revision then
                u59 = Revision
                u57 = a1
                if a1.Drops then
                    addDrops(a1.Drops)
                end
            end
            if u57 and u60 then
                u57.State = u60.State
                u57.Ready = u60.Ready
                local v1 = false
                if u57 ~= nil then
                    v1 = false
                    if u57.Ready == true then
                        v1 = false
                        if u57.Enabled == true then
                            v1 = false
                            if u57.WorldReady == true then
                                v1 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                if not v1 then
                    VaultSequence.Stop(false)
                    u206.Close()
                end
                u302()
                syncQuest()
                return
            end
        end

        local u321 = false

        function u64(a1, a2, a3) -- Line: 767 -- upvalues: u321 (ref), Scramble (upval), u312 (ref) -- types: a1: string
            if u321 then
                return nil
            end
            u321 = true
            local success, err = pcall(function() -- Line: 772 -- upvalues: Scramble (upval), a1 (val), a2 (val), a3 (val)
                return Scramble.Request:InvokeServer(a1, a2, a3)
            end)
            u321 = false
            if success and err then
                u312(err.Snapshot)
                return err
            end
            return nil
        end

        local function burst(a1, a2, a3) -- Line: 874
            -- upvalues: Folder (val), Debris (upval)
            local v1 = {
                Anchored = true,
                CanCollide = false,
                CanTouch = false,
                CanQuery = false,
                Transparency = 1,
                Size = Vector3.new(1, 1, 1),
                Position = a1,
            }
            local v2 = Instance.new("Part")
            for i, j in v1 do
                v2[i] = j
            end
            v2.Parent = Folder
            v1 = {
                Texture = "rbxasset://textures/particles/sparkles_main.dds",
                Rate = 0,
                LightEmission = 0.6,
                Color = ColorSequence.new(a2),
                Lifetime = NumberRange.new(0.35, 0.9),
                Speed = NumberRange.new(5, 12),
                SpreadAngle = Vector2.new(180, 180),
                Size = NumberSequence.new(0.5),
            }
            local v3 = Instance.new("ParticleEmitter")
            for k, n in v1 do
                v3[k] = n
            end
            v3.Parent = v2
            v3:Emit(a3 or 24)
            Debris:AddItem(v2, 1.5)
        end

        local function droneBreakBurst(a1) -- Line: 897
            -- upvalues: Folder (val), Break (upval), u76 (val), Debris (upval), Emit (upval)
            local Attribute, v1
            local v2 = {
                Name = "ScrambleDroneBreak",
                Anchored = true,
                CanCollide = false,
                CanTouch = false,
                CanQuery = false,
                CastShadow = false,
                Transparency = 1,
                Size = Vector3.new(1, 1, 1),
                Position = a1,
            }
            local v3 = Instance.new("Part")
            for i, j in v2 do
                v3[i] = j
            end
            v3.Parent = Folder
            for k, n in Break:GetDescendants() do
                if n:IsA("ParticleEmitter") then
                    Attribute = n:GetAttribute("EmitCount")
                    if typeof(Attribute) ~= "number" then
                        Attribute = n.Rate
                    end
                    if Attribute > 0 then
                        v1 = n:Clone()
                        v1.Enabled = false
                        v1.Color = ColorSequence.new(u76, Color3.fromRGB(225, 255, 200))
                        v1.Parent = v3
                    end
                end
            end
            Debris:AddItem(v3, (Emit(v3)) + 0.1)
        end

        local v1 = u312
        Scramble.State.OnClientEvent:Connect(v1)
        Scramble.Drops.OnClientEvent:Connect(addDrops)
        Scramble.RemoveDrops.OnClientEvent:Connect(function(a1) -- Line: 966 -- upvalues: u41 (val), u56 (ref)
            local v1
            local v2 = nil
            local v3 = nil
            for i, j in a1, v2, v3 do
                v1 = u41[j]
                if v1 then
                    if v1.Observer then
                        u56 = u56 - 1
                    end
                    v1.Model:Destroy()
                    u41[j] = nil
                end
            end
        end)
        Scramble.Effect.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 925
            -- upvalues: u44 (val), u55 (val), droneBreakBurst (val), Audio (val), ReplicatedStorage (upval)
            -- upvalues: Toast (val), u76 (val), u206 (val), u213 (val), u227 (val), u42 (val), VaultSequence (val)
            -- upvalues: syncQuest (val)
            if a1 == "Hit" then
                local v1 = false
                if type(a3) == "table" then
                    v1 = u44[a3.DroneId]
                end
                if v1 and v1.Animated and type(a3.Amount) == "number" and 0 < a3.Amount then
                    v1.Animated:ReceiveHit(a3.Motion)
                    u55.Hit(v1.Animated.Rig, v1.Animated.Root.Position + Vector3.new(0, v1.DamageHeight, 0), a3.Amount)
                    return
                end
                return
            end
            if a1 == "Break" then
                droneBreakBurst(a2)
                Audio.Play(ReplicatedStorage.Assets.Sounds.LightVsDarknessSounds.CollectNormalRing, a2, {Volume = 0.55})
                return
            end
            if a1 == "Rare" then
                Toast.Show({
                    Text = "🚨 A FORBIDDEN EXPERIMENT HAS APPEARED!",
                    Seconds = 2.5,
                    SingleLine = true,
                    Unique = true,
                    Color = u76,
                })
                return
            end
            if a1 == "Samples" then
                Toast.Show({
                    Seconds = 2.5,
                    SingleLine = true,
                    Unique = true,
                    Text = "+" .. (tostring(a3.Amount)) .. " 🧪 Samples",
                    Color = u76,
                })
                return
            end
            if a1 ~= "VaultStart" then
                if a1 == "VaultFinish" then
                    VaultSequence.Finish(a3.Id, a3.Granted == true)
                    local ExperimentVault_2 = u42.ExperimentVault
                    if ExperimentVault_2 then
                        ExperimentVault_2.Open = nil
                    end
                end
                return
            end
            u206.Close()
            u213.Close()
            u227.Close()
            local ExperimentVault = u42.ExperimentVault
            if ExperimentVault then
                VaultSequence.Start(ExperimentVault.Model, a3)
            end
            syncQuest()
        end)
        ;(CollectionService:GetInstanceAddedSignal("ScrambleQuest")):Connect(registerQuest)
        ;(CollectionService:GetInstanceRemovedSignal("ScrambleQuest")):Connect(function(a1) -- Line: 973 -- upvalues: u42 (val)
            local v1 = nil
            local v2 = nil
            for i, j in u42, v1, v2 do
                if j.Model == a1 then
                    if j.IdleTrack then
                        j.IdleTrack:Stop(0)
                        j.IdleTrack:Destroy()
                        j.IdleTrack = nil
                    end
                    if j.Prompt and not j.Floating then
                        j.Prompt:Destroy()
                    end
                    u42[i] = nil
                end
            end
        end)
        u65 = require(script.PersonalDrones).new(Folder, function(a1) -- Line: 782
            -- upvalues: u43 (val), ScrambleMotion (upval), Scramble_3 (val), DroneVisual (upval), Folder (val)
            -- upvalues: label (val), Scramble_2 (val), TweenService (upval), u44 (val)
            if a1:IsA("Model") and not u43[a1] then
                local v1 = workspace
                if a1:IsDescendantOf(v1) then
                    local Hitbox = a1:FindFirstChild("Hitbox")
                    local v2 = ScrambleMotion.Read(a1)
                    if Hitbox and Hitbox:IsA("BasePart") and v2 then
                        v1 = {}
                        local v3 = {}
                        local v4 = nil
                        if a1:GetAttribute("ScrambleAnimatedRig") == true then
                            local v5 = Scramble_3.Drones:FindFirstChild((a1:GetAttribute("ScrambleTier")))
                            if not v5 then
                                return
                            end
                            v4 = DroneVisual.new(a1, v5, Folder)
                        end
                        local Root = if not v4 then Hitbox else v4.Root
                        for i, j in a1:GetDescendants() do
                            if j:IsA("BasePart") and j ~= Hitbox then
                                table.insert(v1, j)
                                table.insert(v3, (v2.Home:ToObjectSpace(j.CFrame)))
                                if j.Name == "Body" then
                                    Root = j
                                end
                            end
                        end
                        local BoundingBox, BoundingBox_2 = (if not v4 then a1 else v4.Rig):GetBoundingBox()
                        local v6 = BoundingBox.Position.Y + ((math.abs(BoundingBox.RightVector.Y)) * BoundingBox_2.X + (math.abs(BoundingBox.UpVector.Y)) * BoundingBox_2.Y + (math.abs(BoundingBox.LookVector.Y)) * BoundingBox_2.Z) / 2 - Root.Position.Y
                        local v7 = {
                            Name = "ScrambleHealth",
                            MaxDistance = 100,
                            AlwaysOnTop = true,
                            LightInfluence = 0,
                            Adornee = Root,
                            Size = UDim2.fromScale(10, 2.2),
                            StudsOffsetWorldSpace = Vector3.new(0, v6 + 2 + 1.1, 0),
                        }
                        local v8 = Instance.new("BillboardGui")
                        for k, n in v7 do
                            v8[k] = n
                        end
                        v8.Parent = Root
                        local v9 = label(v8, "DR. SCRAMBLE EXPERIMENT", 26)
                        v9.Size = UDim2.fromScale(1, 0.45)
                        v9.TextScaled = true
                        local u145 = Scramble_2.Progress:Clone()
                        local zero = Vector2.zero
                        u145.Name = "HealthProgress"
                        u145.AnchorPoint = zero
                        local v10 = UDim2.fromScale(0.05, 0.53)
                        v7 = UDim2.fromScale(0.9, 0.41)
                        u145.Position = v10
                        u145.Size = v7
                        u145.Parent = v8
                        local u156 = {
                            Billboard = v8,
                            Flight = v2,
                            Parts = v1,
                            Offsets = v3,
                            Animated = v4,
                        }

                        local function update(a1) -- Line: 843
                            -- upvalues: Hitbox (val), u145 (val), u156 (val), TweenService (upval)
                            local v1 = Hitbox:GetAttribute("Health") or 0
                            local v2 = Hitbox:GetAttribute("MaxHealth") or 1
                            local v3 = math.clamp(v1 / math.max(v2, 1), 0, 1)
                            u145.TextLabel.Text = string.format("%d / %d HP", math.max(0, (math.ceil(v1))), (math.max(1, (math.ceil(v2)))))
                            u145.Fill.Visible = v3 > 0
                            if u156.Tween then
                                u156.Tween:Cancel()
                            end
                            if a1 then
                                u145.Fill.Size = UDim2.fromScale(v3, 1)
                                return
                            end
                            u156.Tween = TweenService:Create(u145.Fill, TweenInfo.new(0.15), {Size = UDim2.fromScale(v3, 1)})
                            u156.Tween:Play()
                        end

                        u156.Connection = (Hitbox:GetAttributeChangedSignal("Health")):Connect(update)
                        u156.Id = a1:GetAttribute("ScrambleDroneId")
                        u156.DamageHeight = math.max(2, v6 * 0.85)
                        u43[a1] = u156
                        u44[u156.Id] = u156
                        update(true)
                        return
                    end
                    return
                end
            end
        end, function(a1) -- Line: 981 -- upvalues: u43 (val), u44 (val) -- types: a1: userdata
            local v1 = u43[a1]
            if v1 then
                v1.Connection:Disconnect()
                if v1.Tween then
                    v1.Tween:Cancel()
                end
                v1.Billboard:Destroy()
                if v1.Animated then
                    v1.Animated:Destroy()
                end
                u44[v1.Id] = nil
                u43[a1] = nil
            end
        end)
        local u398 = Scramble.Drones.OnClientEvent:Connect(u65.Apply)
        for m, i5 in CollectionService:GetTagged("ScrambleQuest") do
            registerQuest(i5)
        end
        local v2 = {
            Anchored = true,
            CanCollide = false,
            CanTouch = false,
            CanQuery = false,
            Transparency = 1,
            Size = Vector3.new(30, 8, 30),
            Position = Vector3.new(0, -10000, 0),
        }
        local u417 = Instance.new("Part")
        for i6, i7 in v2 do
            u417[i6] = i7
        end
        u417.Parent = Folder
        local v3 = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            Enabled = false,
            Rate = 8,
            Color = ColorSequence.new(u76),
            Lifetime = NumberRange.new(1, 2),
            Speed = NumberRange.new(0.1, 0.5),
            Size = NumberSequence.new(0.15),
            Transparency = NumberSequence.new(0.65),
            SpreadAngle = Vector2.new(180, 180),
        }
        local u456 = Instance.new("ParticleEmitter")
        for i8, i9 in v3 do
            u456[i8] = i9
        end
        u456.Parent = u417

        local function inEventBiome(a1) -- Line: 1023 -- upvalues: u57 (ref) -- types: a1: vector
            if u57 and u57.Window.Active then
                local Bounds, v1, v2, v3
                local World = workspace:FindFirstChild("World")
                local v4 = World and World:FindFirstChild("Areas")
                v4 = v4 and v4:FindFirstChild("GuardAreas")
                if not v4 then
                    return false
                end
                local Areas_2 = u57.Areas or {}
                local v5 = nil
                local v6 = nil
                for i, j in Areas_2, v5, v6 do
                    v2 = v4:FindFirstChild(j)
                    Bounds = v2 and v2:FindFirstChild("Bounds")
                    if Bounds and Bounds:IsA("BasePart") and v2:GetAttribute("ZoneHidden") ~= true then
                        v3 = Bounds.CFrame:PointToObjectSpace(v7)
                        v1 = Bounds.Size / 2
                        if (math.abs(v3.X)) < v1.X and (math.abs(v3.Z)) < v1.Z and (math.abs(v3.Y)) < 35 then
                            return true
                        end
                    end
                end
                return false
            end
            return false
        end

        local u471 = false
        local u472 = nil
        local u473 = nil

        local function updateOutbreakPresentation() -- Line: 1048
            -- upvalues: LocalPlayer (val), inEventBiome (val), Scramble_3 (val), u472 (ref), u473 (ref), Folder (val)
            -- upvalues: u471 (ref), MusicDirector (val), LightingController (val)
            local Attribute = workspace:GetAttribute("ScrambleOutbreakEndsAt")
            local v1 = LocalPlayer
            local Character = v1 and v1.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local v2 = if not Humanoid then nil else if not (0 < Humanoid.Health) then nil else Character:FindFirstChild("HumanoidRootPart")
            v1 = false
            if workspace:GetAttribute("ScrambleOutbreakActive") == true then
                v1 = false
                if type(Attribute) == "number" then
                    v1 = false
                    if workspace:GetServerTimeNow() < Attribute then
                        v1 = false
                        if v2 ~= nil then
                            v1 = inEventBiome(v2.Position)
                        end
                    end
                end
            end
            v2 = Scramble_3:FindFirstChild("DrScrambleVFX")
            if u472 then
                if not v1 or u473 ~= v2 then
                    u472:Destroy()
                    u472 = nil
                    u473 = nil
                end
            end
            if v1 and v2 and not u472 then
                u473 = v2
                u472 = v2:Clone()
                u472.Parent = Folder
            end
            if v1 == u471 then
                return
            end
            u471 = v1
            MusicDirector.SetScrambleActive(v1)
            if v1 and LightingController.Presets.DrScramble then
                LightingController.SetLayer("DrScrambleOutbreak", "DrScramble", 140, 1)
                return
            end
            LightingController.ClearLayer("DrScrambleOutbreak", 1)
        end

        local u480 = 0
        local u481 = 0
        local u482 = {}
        local u483 = {}
        local u497 = RunService.RenderStepped:Connect(function(a1) -- Line: 1079
            -- upvalues: u480 (ref), u55 (val), u482 (val), u483 (val), u43 (val), ScrambleMotion (upval), u42 (val)
            -- upvalues: u41 (val), ScramblePickupMotion (upval), u56 (ref), u481 (ref), burst (val), u76 (val)
            -- upvalues: Audio (val), ReplicatedStorage (upval)
            local Character, Humanoid, Owner, v1, v2, v3, v4
            u480 = u480 + a1
            local CurrentCamera = workspace.CurrentCamera
            local v5 = os.clock()
            local ServerTimeNow = workspace:GetServerTimeNow()
            u55.Step(a1)
            table.clear(u482)
            table.clear(u483)
            local v6 = nil
            local v7 = nil
            for i, j in u43, v6, v7 do
                v4 = false
                if i.Parent ~= nil then
                    v4 = false
                    if CurrentCamera ~= nil then
                        v4 = (CurrentCamera.CFrame.Position - i:GetPivot().Position).Magnitude < 180
                    end
                end
                if j.Animated then
                    v2 = j.Animated:Step(j.Flight, ServerTimeNow, v4)
                    j.Billboard.Enabled = v4 and (not j.Animated.State or j.Animated.State.Name ~= "Death")
                    if v4 then
                        if not j.Animated.State or j.Animated.State.Name ~= "Death" then
                            table.insert(u482, j.Animated.Root)
                            table.insert(u483, v2)
                        end
                    end
                elseif v4 then
                    v2 = ScrambleMotion.Pose(j.Flight, ServerTimeNow)
                    for k, n in j.Parts do
                        table.insert(u482, n)
                        table.insert(u483, v2 * j.Offsets[k])
                    end
                end
            end
            if #u482 > 0 then
                workspace:BulkMoveTo(u482, u483, Enum.BulkMoveMode.FireCFrameChanged)
            end
            if u480 >= 0.03333333333333333 then
                u480 = u480 % 0.03333333333333333
                for m, i5 in u42 do
                    if i5.Floating
                        and not i5.Hidden
                        and CurrentCamera
                        and (CurrentCamera.CFrame.Position - i5.BasePivot.Position).Magnitude < 100 then
                        i5.Model:PivotTo((CFrame.new(0, math.sin(v5 * 1.8 + i5.Phase) * 0.25 + 1.4, 0)) * i5.BasePivot * (CFrame.Angles(0, v5 * 0.5, 0)))
                    end
                end
            end
            v6 = nil
            v7 = nil
            for i6, i7 in u41, v6, v7 do
                if not i7.Arrived then
                    v3 = v5 - i7.SpawnedAt
                    Owner = i7.Owner
                    Character = Owner and Owner.Character
                    Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                    v1 = if not Humanoid then nil else if not (0 < Humanoid.Health) then nil else Character:FindFirstChild("HumanoidRootPart")
                    if not i7.MagnetDelay or not (i7.MagnetDelay <= v3) then
                        if not i7.Landed then
                            v4 = ScramblePickupMotion.GroundPosition(i7.Origin, i7.Position, v3)
                            i7.Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, math.min(v3, ScramblePickupMotion.MagnetDelay) * 4, 0)))
                            if ScramblePickupMotion.MagnetDelay <= v3 then
                                i7.Landed = true
                            end
                        end
                    elseif v1 then
                        i7.MagnetStarted = i7.MagnetStarted or v5
                        v4 = math.clamp((v5 - i7.MagnetStarted) / ScramblePickupMotion.MagnetSeconds, 0, 1)
                        v2 = ScramblePickupMotion.MagnetPosition(i7.Position, v1.Position, v4)
                        i7.Model:PivotTo((CFrame.new(v2)) * (CFrame.Angles(0, v3 * 8, 0)))
                        if v4 == 1 then
                            i7.Arrived = true
                            if not i7.Observer then
                                for i8, i9 in i7.Parts do
                                    i9.LocalTransparencyModifier = 1
                                end
                                if i7.Billboard then
                                    i7.Billboard.Enabled = false
                                end
                                if 0.09 < v5 - u481 then
                                    u481 = v5
                                    burst(v1.Position, u76, 6)
                                    Audio.Play(ReplicatedStorage.Assets.Sounds.LightVsDarknessSounds.CollectNormalRing, v1, {Volume = 0.35})
                                end
                            else
                                v2 = u41[i6]
                                if v2 then
                                    if v2.Observer then
                                        u56 = u56 - 1
                                    end
                                    v2.Model:Destroy()
                                    u41[i6] = nil
                                end
                            end
                        end
                    elseif not i7.Landed then
                        v4 = ScramblePickupMotion.GroundPosition(i7.Origin, i7.Position, v3)
                        i7.Model:PivotTo((CFrame.new(v4)) * (CFrame.Angles(0, math.min(v3, ScramblePickupMotion.MagnetDelay) * 4, 0)))
                        if ScramblePickupMotion.MagnetDelay <= v3 then
                            i7.Landed = true
                        end
                    end
                end
            end
        end)
        Save.WatchFields("SpeedPower", updateEventButtons)
        BossEventFlags.ContentEnabled.Changed:Connect(updateEventButtons)
        RiftFlags.SpeedPowerRequirement.Changed:Connect(updateEventButtons)
        ;(workspace:GetAttributeChangedSignal("ScrambleHUDUnlocked")):Connect(updateEventButtons)
        ;(workspace:GetAttributeChangedSignal("ScrambleHUDAwaitingSammyOutro")):Connect(updateEventButtons)
        task.spawn(function() -- Line: 1182
            -- upvalues: u61 (ref), u197 (val), LocalPlayer (val), u41 (val), u56 (ref), Scramble (upval)
            -- upvalues: inEventBiome (val), u417 (val), u456 (val), updateOutbreakPresentation (val), u65 (ref)
            -- upvalues: updateAutoAttack (val), u71 (val), u57 (ref), CollectionService (upval), registerQuest (val)
            -- upvalues: syncQuest (val), Save (upval), RiftEligibility (upval), BossEventFlags (upval)
            -- upvalues: QuestlineButton (val), RiftButton (val), u227 (val), u206 (val), u213 (val)
            -- upvalues: updateExperimentTimer (val), updateRemovalTimers (val), u301 (ref), Constants (upval)
            -- upvalues: u302 (ref)
            local Character, Humanoid, ServerTimeNow, ServerTimeNow_5, Tick, Tick_2, v1, v2, v3, v4, v5, v6, v7
            local v8 = u61
            while u197.Parent do
                if v8 ~= u61 then
                    break
                end
                v2 = LocalPlayer
                Character = v2 and v2.Character
                Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                v1 = if not Humanoid then nil else if not (0 < Humanoid.Health) then nil else Character:FindFirstChild("HumanoidRootPart")
                ServerTimeNow = workspace:GetServerTimeNow()
                v3 = {}
                v5 = nil
                v6 = nil
                for i, j in u41, v5, v6 do
                    if j.ExpiresAt <= ServerTimeNow then
                        v7 = u41[i]
                        if v7 then
                            if v7.Observer then
                                u56 = u56 - 1
                            end
                            v7.Model:Destroy()
                            u41[i] = nil
                        end
                    elseif j.Observer then
                        v7 = os.clock() - j.SpawnedAt
                        if v7 > 8 then
                            v7 = u41[i]
                            if v7 then
                                if v7.Observer then
                                    u56 = u56 - 1
                                end
                                v7.Model:Destroy()
                                u41[i] = nil
                            end
                        elseif not j.Observer and v1 and #v3 < 8 and j.CollectAfter <= ServerTimeNow then
                            v7 = os.clock()
                            if j.NextTry <= v7
                                and (if not j.MagnetAt then (v1.Position - j.Position).Magnitude <= (j.Radius or 0) else j.Arrived) then
                                j.NextTry = os.clock() + 1
                                table.insert(v3, i)
                            end
                        end
                    elseif not j.Observer and v1 and #v3 < 8 and j.CollectAfter <= ServerTimeNow then
                        v7 = os.clock()
                        if j.NextTry <= v7
                            and (if not j.MagnetAt then (v1.Position - j.Position).Magnitude <= (j.Radius or 0) else j.Arrived) then
                            j.NextTry = os.clock() + 1
                            table.insert(v3, i)
                        end
                    end
                end
                if #v3 > 0 then
                    Scramble.Collect:FireServer(v3)
                end
                if not v1 or not inEventBiome(v1.Position) then
                    u417.Position = Vector3.new(0, -10000, 0)
                    u456.Enabled = false
                else
                    u417.Position = v1.Position
                    u456.Enabled = true
                end
                updateOutbreakPresentation()
                u65.Tick()
                updateAutoAttack()
                Tick = u71.Tick
                v5 = false
                if u57 ~= nil then
                    v5 = false
                    if u57.Ready == true then
                        v5 = false
                        if u57.Enabled == true then
                            v5 = false
                            if u57.WorldReady == true then
                                v5 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                Tick(v5)
                for k, n in CollectionService:GetTagged("ScrambleQuest") do
                    registerQuest(n)
                end
                syncQuest()
                if u57 == nil then
                    v3 = false
                    if workspace:GetAttribute("ScrambleHUDUnlocked") == true then
                        v3 = workspace:GetAttribute("ScrambleHUDAwaitingSammyOutro") ~= true
                    end
                else
                    v3 = u57.ShowHUD == true
                end
                if v3 then
                    v3 = false
                    if u57 ~= nil then
                        v3 = false
                        if u57.Ready == true then
                            v3 = false
                            if u57.Enabled == true then
                                v3 = false
                                if u57.WorldReady == true then
                                    v3 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                                end
                            end
                        end
                    end
                    if v3 then
                        v1 = Save.Peek()
                        v3 = false
                        if v1 ~= nil then
                            v3 = RiftEligibility.IsEligible(v1.SpeedPower)
                        end
                    end
                end
                v4 = BossEventFlags.ContentEnabled:Get()
                if v4 then
                    v5 = Save.Peek()
                    v4 = false
                    if v5 ~= nil then
                        v4 = RiftEligibility.IsEligible(v5.SpeedPower)
                    end
                end
                for m, i5 in QuestlineButton do
                    i5.Visible = v3
                end
                for i6, i7 in RiftButton do
                    i7.Visible = v4
                end
                Tick_2 = u227.Tick
                v5 = false
                if u57 ~= nil then
                    v5 = false
                    if u57.Ready == true then
                        v5 = false
                        if u57.Enabled == true then
                            v5 = false
                            if u57.WorldReady == true then
                                v5 = (workspace:GetServerTimeNow()) < (u57.EventEndsAt or 0)
                            end
                        end
                    end
                end
                Tick_2(v5)
                u206.Tick(ServerTimeNow)
                u213.Tick(ServerTimeNow)
                updateExperimentTimer(ServerTimeNow)
                updateRemovalTimers(ServerTimeNow)
                if u57 and not u301 then
                    ServerTimeNow_5 = workspace:GetServerTimeNow()
                    if Constants.UPDATE_LIVE_AT <= ServerTimeNow_5 then
                        u302()
                    end
                end
                task.wait(0.2)
            end
        end)
        task.spawn(function() -- Line: 1240 -- upvalues: u197 (val), u57 (ref), u65 (ref), Scramble (upval), u312 (ref)
            local err, success
            while u197.Parent do
                if u57 and u57.Ready and u65.Ready() then
                    break
                end
                success, err = pcall(function() -- Line: 1242 -- upvalues: Scramble (upval)
                    return Scramble.Request:InvokeServer("Snapshot")
                end)
                if success then
                    u312(err)
                end
                if not u57 or not u57.Ready or not u65.Ready() then
                    task.wait(2)
                end
            end
        end)
        u197.Destroying:Connect(function() -- Line: 1253
            -- upvalues: VaultSequence (val), MusicDirector (val), LightingController (val), u237 (val)
            -- upvalues: QuestlineButton (val), RiftButton (val), u42 (val), ExperimentTimer (val), u149 (val)
            -- upvalues: u61 (ref), u227 (val), u206 (val), u213 (val), u221 (val), u71 (val), u398 (val), u65 (ref)
            -- upvalues: u497 (val), u55 (val), u43 (val), Folder (val)
            VaultSequence.Stop(false)
            MusicDirector.SetScrambleActive(false)
            LightingController.ClearLayer("DrScrambleOutbreak", 1)
            for i, j in u237 do
                j()
            end
            for k, n in QuestlineButton do
                n.Visible = false
            end
            for m, i5 in RiftButton do
                i5.Visible = false
            end
            local v1 = nil
            local v2 = nil
            for i6, i7 in u42, v1, v2 do
                if i7.IdleTrack then
                    i7.IdleTrack:Stop(0)
                    i7.IdleTrack:Destroy()
                    i7.IdleTrack = nil
                end
                if i7.Prompt and not i7.Floating then
                    i7.Prompt:Destroy()
                end
            end
            table.clear(u42)
            for i8, i9 in ExperimentTimer do
                i9.Visible = false
            end
            for i10, i11 in u149 do
                i11.Label.Visible = false
            end
            u61 = u61 + 1
            u227.Destroy()
            u206.Destroy()
            u213.Destroy()
            u221.Destroy()
            u71.Destroy()
            u398:Disconnect()
            u65.Destroy()
            u497:Disconnect()
            u55.Destroy()
            v1 = nil
            v2 = nil
            for i12, i13 in u43, v1, v2 do
                i13.Connection:Disconnect()
                if i13.Tween then
                    i13.Tween:Cancel()
                end
                i13.Billboard:Destroy()
                if i13.Animated then
                    i13.Animated:Destroy()
                end
            end
            Folder:Destroy()
        end)
    end,
}