-- Script path: ReplicatedStorage.Controllers.GUI.ResetStartTimerController
-- Decompile time: 11.19 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local Audio = require(ReplicatedStorage.Shared.Audio)
local SystemChat = require(ReplicatedStorage.Client.SystemChat)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Log = require(ReplicatedStorage.Packages.Log)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local WarmSounds = require(ReplicatedStorage.Shared.Utils.Preload).WarmSounds
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
local u92 = TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local TeleportFadeSeconds = AreaEggResetCycle.TeleportFadeSeconds
local TeleportFadeHoldSeconds = AreaEggResetCycle.TeleportFadeHoldSeconds
local u98 = TweenInfo.new(TeleportFadeSeconds, Enum.EasingStyle.Linear)
local u103 = TweenInfo.new(AreaEggResetCycle.SleepIconFadeSeconds, Enum.EasingStyle.Quad)
local u107 = TweenInfo.new(AreaEggResetCycle.NightIconFadeOutSeconds, Enum.EasingStyle.Quad)
local u118 = table.freeze({
    [Rarity.Rarities.Eternal._id] = true,
    [Rarity.Rarities.Divine._id] = true,
})
local LocalPlayer = Players.LocalPlayer
local u122 = Log.new()
return {
    Start = function() -- Line: 66
        -- upvalues: GUI (val), AreaEggResetWall (val), WarmSounds (val), TweenService (val), u98 (val)
        -- upvalues: TeleportFadeHoldSeconds (val), u107 (val), u103 (val), u92 (val), LocalPlayer (val)
        -- upvalues: HalloweenDimension (val), u118 (val), SystemChat (val), Notifications (val), EggState (val)
        -- upvalues: u122 (val), ServerClock (val), AreaEggResetCycle (val), Audio (val), Workspace (val)
        -- upvalues: AreaEggCycle (val)
        local requestJoinRareSpawnPresentations
        local u2 = GUI.FadeFrame()
        local u5 = GUI.ResetStartTimer()
        local TextLabel = u5.Frame.TextLabel
        local NightTimer = u5.Frame.NightTimer
        local UIStroke = NightTimer.UIStroke
        local SleepIcon = u5.Frame.SleepIcon
        local u15 = GUI.ResetStartTimerLabelScale()
        local u16 = 0
        local u17 = nil
        local u18 = 0
        local u19 = nil
        local u20 = nil
        local u21 = nil
        local u22 = nil
        local DayStartsAt = nil
        local u24 = (-1 / 0)
        local u25 = -1
        u5.Adornee = AreaEggResetWall.ResolveWallPart()
        task.spawn(WarmSounds, 117751546358455, 136029417452204)

        local function stopActiveTween() -- Line: 93 -- upvalues: u17 (ref)
            if u17 ~= nil then
                u17:Cancel()
                u17 = nil
            end
        end

        local function stopActiveFadeTween() -- Line: 100 -- upvalues: u19 (ref)
            if u19 ~= nil then
                u19:Cancel()
                u19 = nil
            end
        end

        local function stopActiveNightVisualTweens() -- Line: 107 -- upvalues: u20 (ref), u21 (ref), u22 (ref)
            if u20 ~= nil then
                u20:Cancel()
                u20 = nil
            end
            if u21 ~= nil then
                u21:Cancel()
                u21 = nil
            end
            if u22 ~= nil then
                u22:Cancel()
                u22 = nil
            end
        end

        local function tweenFadeFrame(a1, a2) -- Line: 122
            -- upvalues: u19 (ref), TweenService (upval), u2 (val), u98 (upval), u18 (ref)
            if u19 ~= nil then
                u19:Cancel()
                u19 = nil
            end
            local v1 = TweenService:Create(u2, u98, {BackgroundTransparency = a2})
            u19 = v1
            v1:Play()
            v1.Completed:Wait()
            if a1 ~= u18 then
                return false
            end
            u19 = nil
            return true
        end

        local function runTeleportFade(a1) -- Line: 137
            -- upvalues: tweenFadeFrame (val), TeleportFadeHoldSeconds (upval), u18 (ref)
            if not tweenFadeFrame(a1, 0) then
                return
            end
            task.wait(TeleportFadeHoldSeconds)
            if a1 ~= u18 then
                return
            end
            tweenFadeFrame(a1, 1)
        end

        local function setCountdownVisible(a1) -- Line: 148 -- upvalues: TextLabel (val) -- types: a1: boolean
            TextLabel.Visible = a1
        end

        local function tweenNightVisuals(a1, a2) -- Line: 150
            -- upvalues: u20 (ref), u21 (ref), u22 (ref), u107 (upval), u103 (upval), TweenService (upval)
            -- upvalues: SleepIcon (val), NightTimer (val), UIStroke (val), u16 (ref)
            local v1
            if u20 ~= nil then
                u20:Cancel()
                u20 = nil
            end
            if u21 ~= nil then
                u21:Cancel()
                u21 = nil
            end
            if u22 ~= nil then
                u22:Cancel()
                u22 = nil
            end
            local v2 = {ImageTransparency = a2}
            local v3 = TweenService:Create(SleepIcon, if a2 ~= 1 then u103 else u107, v2)
            local v4 = TweenService:Create(NightTimer, v1, {TextTransparency = a2})
            local v5 = TweenService:Create(UIStroke, v1, {Transparency = a2})
            u20 = v3
            u21 = v4
            u22 = v5
            v3:Play()
            v4:Play()
            v5:Play()
            v3.Completed:Wait()
            if a1 ~= u16 then
                return false
            end
            u20 = nil
            u21 = nil
            u22 = nil
            return true
        end

        local function animateCount(a1) -- Line: 180
            -- upvalues: u17 (ref), TextLabel (val), u15 (val), TweenService (upval), u92 (upval)
            if u17 ~= nil then
                u17:Cancel()
                u17 = nil
            end
            TextLabel.Text = tostring(a1)
            u15.Scale = 1.3
            local v1 = TweenService:Create(u15, u92, {Scale = 1})
            u17 = v1
            v1:Play()
        end

        local function isHiddenInDimension(a1) -- Line: 191
            -- upvalues: LocalPlayer (upval), HalloweenDimension (upval), u118 (upval)
            local v1 = false
            if LocalPlayer:GetAttribute(HalloweenDimension.PlayerAttributes.Inside) == true then
                v1 = u118[a1] == nil
            end
            return v1
        end

        local function announceRareSpawns(a1) -- Line: 196
            -- upvalues: LocalPlayer (upval), HalloweenDimension (upval), u118 (upval), SystemChat (upval)
            -- upvalues: Notifications (upval), EggState (upval)
            local v1
            for i, v in ipairs(a1) do
                v1 = false
                if LocalPlayer:GetAttribute(HalloweenDimension.PlayerAttributes.Inside) == true then
                    v1 = u118[v.RarityId] == nil
                end
                if not v1 then
                    SystemChat.Post({Text = v.Message})
                    Notifications.Toast.Show({
                        Lane = "Banner",
                        Seconds = 4,
                        Text = v.Message,
                        Color = Color3.new(1, 1, 1),
                        Sound = v.SoundId,
                    })
                end
            end
            EggState.RarityPresented:Fire(a1)
        end

        function requestJoinRareSpawnPresentations(a1) -- Line: 221
            -- upvalues: EggState (upval), u25 (ref), announceRareSpawns (val), u122 (upval)
            -- upvalues: requestJoinRareSpawnPresentations (val)
            local v1, v2 = EggState.FetchRarityShows()
            if not v1 then
                if a1 >= 30 then
                    u122:AtError():Log("Area egg rare spawn join presentation request exhausted profile-readiness retries")
                    return
                end
                task.delay(1, function() -- Line: 236 -- upvalues: requestJoinRareSpawnPresentations (upval), a1 (val)
                    requestJoinRareSpawnPresentations(a1 + 1)
                end)
                return
            end
            if v2 ~= nil then
                if v2.PeriodIndex <= u25 then
                    return
                end
                u25 = v2.PeriodIndex
                announceRareSpawns(v2.RareSpawns)
            end
        end

        local function runCountdown(a1, a2) -- Line: 240
            -- upvalues: AreaEggResetWall (upval), u5 (val), TextLabel (val), NightTimer (val), ServerClock (upval)
            -- upvalues: tweenNightVisuals (val), u16 (ref), AreaEggResetCycle (upval), Notifications (upval)
            -- upvalues: Audio (upval), animateCount (val), u17 (ref), u15 (val), u24 (ref), DayStartsAt (ref)
            local v1, v2, v3
            AreaEggResetWall.ArmReveal()
            u5.Enabled = true
            TextLabel.Visible = false
            task.spawn(AreaEggResetWall.RaiseWall)
            NightTimer.Text = ("%*s"):format((math.max(math.ceil(a2.DayStartsAt - (ServerClock.Now())), 1)))
            if not tweenNightVisuals(a1, 0) then
                return
            end
            while true do
                v1 = ServerClock.Now()
                v2 = a2.DayStartsAt - v1
                if v2 <= 0 then
                    break
                end
                v3 = math.ceil(v2)
                NightTimer.Text = ("%*s"):format(v3)
                task.wait((math.max(a2.DayStartsAt - (v3 - 1) - v1, 0.05)))
                if a1 ~= u16 then
                    return
                end
            end
            if not tweenNightVisuals(a1, 1) then
                return
            end
            task.wait((math.max(a2.DayStartsAt + AreaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds - ServerClock.Now(), 0)))
            if a1 ~= u16 then
                return
            end
            Notifications.Toast.Show({Lane = "Banner", Text = "ALL EGG RESET!", Seconds = 3.5})
            v1 = AreaEggResetWall.ResolveWallPart()
            v2 = v1.Position + v1.CFrame.LookVector * (v1.Size.Z / 2)
            local v4 = a1
            for i = AreaEggResetCycle.WallCountdownSeconds, 1, -1 do
                if v4 ~= u16 then
                    return
                end
                Audio.Play(117751546358455, v2, {Volume = 2, MaxDistance = 220})
                animateCount(i)
                if i == AreaEggResetCycle.WallCountdownSeconds then
                    TextLabel.Visible = true
                end
                task.wait(1)
            end
            if v4 == u16 then
                if u17 ~= nil then
                    u17:Cancel()
                    u17 = nil
                end
                u15.Scale = 1
                Audio.Play(136029417452204, v2, {Volume = 1.5, MaxDistance = 220})
                TextLabel.Visible = false
                AreaEggResetWall.DropWall()
                if v4 ~= u16 then
                    return
                end
                u5.Enabled = false
                u24 = v5.DayStartsAt
                DayStartsAt = nil
            end
        end

        u122:AtDebug():Log("Reset start timer controller initialized")
        u5.Enabled = false
        TextLabel.Visible = false
        SleepIcon.ImageTransparency = 1
        NightTimer.TextTransparency = 1
        UIStroke.Transparency = 1
        AreaEggResetWall.ClearWall()
        EggState.ResetFade:Connect(function() -- Line: 342 -- upvalues: u18 (ref), runTeleportFade (val)
            u18 = u18 + 1
            task.spawn(runTeleportFade, u18)
        end)
        EggState.ResetCountdown:Connect(function(a1) -- Line: 312 -- upvalues: u24 (ref), DayStartsAt (ref), u16 (ref), runCountdown (val)
            if a1.DayStartsAt <= u24 then
                return
            end
            local v1 = DayStartsAt
            if v1 ~= nil and a1.DayStartsAt < v1 then
                return
            end
            if a1.DayStartsAt == v1 then
                return
            end
            DayStartsAt = a1.DayStartsAt
            u16 = u16 + 1
            task.spawn(runCountdown, u16, a1)
        end)
        EggState.RarityRevealed:Connect(function(a1) -- Line: 213 -- upvalues: u25 (ref), announceRareSpawns (val)
            if a1.PeriodIndex <= u25 then
                return
            end
            u25 = a1.PeriodIndex
            announceRareSpawns(a1.RareSpawns)
        end)
        task.spawn(requestJoinRareSpawnPresentations, 1)
        ;(Workspace:GetAttributeChangedSignal("NightIconOverride")):Connect(function() -- Line: 353 -- upvalues: SleepIcon (val), Workspace (upval)
            SleepIcon.Image = Workspace:GetAttribute("NightIconOverride") or "rbxassetid://123238464128459"
        end)
        SleepIcon.Image = Workspace:GetAttribute("NightIconOverride") or "rbxassetid://123238464128459"
        if AreaEggCycle.IsNightPhase(ServerClock.Now()) then
            local v1 = {DayStartsAt = AreaEggCycle.NextResetTime(ServerClock.Now())}
            if not (v1.DayStartsAt <= u24) then
                local v2 = DayStartsAt
                if v2 == nil then
                    if v1.DayStartsAt ~= v2 then
                        DayStartsAt = v1.DayStartsAt
                        u16 = u16 + 1
                        task.spawn(runCountdown, u16, v1)
                    end
                elseif not (v1.DayStartsAt < v2) and v1.DayStartsAt ~= v2 then
                    DayStartsAt = v1.DayStartsAt
                    u16 = u16 + 1
                    task.spawn(runCountdown, u16, v1)
                end
            end
        end
    end,
}