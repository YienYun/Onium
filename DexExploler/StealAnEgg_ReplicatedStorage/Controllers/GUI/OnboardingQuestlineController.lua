-- Script path: ReplicatedStorage.Controllers.GUI.OnboardingQuestlineController
-- Decompile time: 27.06 ms

local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetViewport = require(ReplicatedStorage.Client.AssetViewport)
local GUI = require(ReplicatedStorage.Client.GUI)
return {
    Start = function() -- Line: 22
        -- upvalues: ReplicatedStorage (val), GUI (val), Workspace (val), TweenService (val), Assets (val)
        -- upvalues: AssetViewport (val), ProximityPromptService (val)
        local v1, v2
        local OnboardingQuestline_2 = ReplicatedStorage.Data:FindFirstChild("OnboardingQuestline")
        if OnboardingQuestline_2 == nil then
            return
        end
        local u8 = require(OnboardingQuestline_2)
        local v3 = require(ReplicatedStorage.Shared.Flags.OnboardingQuestlineFlags)
        local OnboardingQuestline = require(ReplicatedStorage.Shared.Types.OnboardingQuestline)
        local Remotes = require(ReplicatedStorage.Shared.Remotes)
        local Save = require(ReplicatedStorage.Shared.Save)
        local Audio = require(ReplicatedStorage.Shared.Audio)
        local Tabs = require(ReplicatedStorage.Client.Tabs)
        local Time = require(ReplicatedStorage.Shared.Utils.Time)
        local ProfileKey = u8.ProfileKey
        local u53 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v4 = GUI.Get(u8.ScreenName)
        local u61 = v4:WaitForChild(u8.ApiFolderName)
        local FTUEQuestMain = v4:WaitForChild("FTUEQuestMain")
        v4 = FTUEQuestMain:WaitForChild("Content")
        local Info1 = v4:WaitForChild("Info1")
        local Info2 = v4:WaitForChild("Info2")
        local Text = Info1.Text
        local Text_2 = Info2.Text

        local function apiEvent(a1) -- Line: 69 -- upvalues: u61 (val) -- types: a1: string
            local v1 = u61:WaitForChild(a1)
            assert(v1:IsA("BindableEvent"), (("RescueDragonAPI.%* must be a BindableEvent"):format(a1)))
            return v1
        end

        local Open = u61:WaitForChild("Open")
        assert(Open:IsA("BindableEvent"), "RescueDragonAPI.Open must be a BindableEvent")
        local Close = u61:WaitForChild("Close")
        assert(Close:IsA("BindableEvent"), "RescueDragonAPI.Close must be a BindableEvent")
        local LoadQuestSet = u61:WaitForChild("LoadQuestSet")
        assert(LoadQuestSet:IsA("BindableEvent"), "RescueDragonAPI.LoadQuestSet must be a BindableEvent")
        local SetQuest = u61:WaitForChild("SetQuest")
        assert(SetQuest:IsA("BindableEvent"), "RescueDragonAPI.SetQuest must be a BindableEvent")
        local ClaimQuest = u61:WaitForChild("ClaimQuest")
        assert(ClaimQuest:IsA("BindableEvent"), "RescueDragonAPI.ClaimQuest must be a BindableEvent")
        local UnlockNextLock = u61:WaitForChild("UnlockNextLock")
        assert(UnlockNextLock:IsA("BindableEvent"), "RescueDragonAPI.UnlockNextLock must be a BindableEvent")
        local ResetAll = u61:WaitForChild("ResetAll")
        assert(ResetAll:IsA("BindableEvent"), "RescueDragonAPI.ResetAll must be a BindableEvent")
        local ClaimClicked = u61:WaitForChild("ClaimClicked")
        assert(ClaimClicked:IsA("BindableEvent"), "RescueDragonAPI.ClaimClicked must be a BindableEvent")
        local GoNowClicked = u61:WaitForChild("GoNowClicked")
        assert(GoNowClicked:IsA("BindableEvent"), "RescueDragonAPI.GoNowClicked must be a BindableEvent")
        local CloseClicked = u61:WaitForChild("CloseClicked")
        assert(CloseClicked:IsA("BindableEvent"), "RescueDragonAPI.CloseClicked must be a BindableEvent")
        local LockUnlocked = u61:WaitForChild("LockUnlocked")
        assert(LockUnlocked:IsA("BindableEvent"), "RescueDragonAPI.LockUnlocked must be a BindableEvent")
        local AllLocksUnlocked = u61:WaitForChild("AllLocksUnlocked")
        assert(AllLocksUnlocked:IsA("BindableEvent"), "RescueDragonAPI.AllLocksUnlocked must be a BindableEvent")
        local u364 = nil
        local u215 = 0
        local u216 = {}
        local u217 = {}
        local u379 = true
        local u382 = false
        local u220 = 0
        local u335 = false
        local u222 = nil
        local u223 = false
        local u349 = nil
        local u370 = nil
        local u404 = nil
        local u227 = {}

        local function now() -- Line: 107 -- upvalues: Workspace (upval)
            return Workspace:GetServerTimeNow()
        end

        local function currentState() -- Line: 111 -- upvalues: Save (val), OnboardingQuestline (val), ProfileKey (val)
            local v1 = Save.Await()
            if v1 then
                return (OnboardingQuestline.Reconcile(v1[ProfileKey]))
            end
            return nil
        end

        local function acknowledge(a1) -- Line: 116 -- upvalues: Remotes (val) -- types: a1: table
            task.spawn(function() -- Line: 117 -- upvalues: Remotes (upval), a1 (val)
                pcall(function() -- Line: 118 -- upvalues: Remotes (upval), a1 (upval)
                    local v1 = a1
                    Remotes.OnboardingQuestline.AskAcknowledge:InvokeServer(v1)
                end)
            end)
        end

        local function renderTimer(a1) -- Line: 126 -- upvalues: u404 (ref), u8 (val), Workspace (upval), Time (val)
            local v1 = u404
            if v1 == nil then
                return
            end
            if a1.RewardGranted then
                v1.Text = "RESCUED!"
                return
            end
            local v2 = (u8.ExpiresAt(a1)) - Workspace:GetServerTimeNow()
            v1.Text = if not (v2 <= 0) then ("%* LEFT"):format((Time.Elapsed(v2))) else "EXPIRED"
        end

        local function playCue(a1, a2, a3) -- Line: 143 -- upvalues: u8 (val), Audio (val) -- types: a2: userdata?
            local v1 = u8.Sounds[a1]
            local v2 = ("no sound slot named %* in OnboardingQuestline.Sounds"):format(a1)
            assert(v1 ~= nil, v2)
            if v1 == 0 then
                return nil
            end
            return Audio.Play(v1, a2 or script, a3 or {})
        end

        local function applyCageLocks(a1, a2) -- Line: 156
            -- upvalues: u227 (ref), TweenService (upval), u53 (val)
            local v1, v2
            local v3 = nil
            local v4 = nil
            for i, j in u227, v3, v4 do
                v2 = i <= a1
                if not v2 or not v1 or not (j.LocalTransparencyModifier < 1) then
                    j.LocalTransparencyModifier = if not v2 then 0 else 1
                else
                    TweenService:Create(j, u53, {LocalTransparencyModifier = 1}):Play()
                end
                j.CanCollide = not v2
            end
        end

        local function showRewardScreen() -- Line: 171 -- upvalues: GUI (upval), Assets (upval), u8 (val), Tabs (val)
            local GenericRewardScreen2 = GUI.PlayerGui():FindFirstChild("GenericRewardScreen2")
            assert(GenericRewardScreen2 ~= nil, "PlayerGui is missing GenericRewardScreen2")
            local ShowReward = GenericRewardScreen2:FindFirstChild("ShowReward")
            local v1 = false
            if ShowReward ~= nil then
                v1 = ShowReward:IsA("BindableEvent")
            end
            assert(v1, "GenericRewardScreen2 has no ShowReward event; its RewardController did not start")
            local v2 = Assets.Directory[u8.RewardAssetId]
            local v3 = ("no asset config for %*"):format(u8.RewardAssetId)
            assert(v2 ~= nil, v3)
            Tabs.Deactivate({instant = true})
            ShowReward:Fire({
                autoClose = 0,
                title = u8.TitleComplete,
                item = v2.DisplayName,
                rarity = v2.Rarity._id,
                image = v2.Icon,
            })
        end

        local function setRescuedPresentation(a1) -- Line: 194
            -- upvalues: Info1 (val), u8 (val), Text (val), Info2 (val), Text_2 (val)
            Info1.Text = if not a1 then Text else u8.TitleComplete
            Info2.Text = if not a1 then Text_2 else u8.SubtitleComplete
        end

        local function renderEntryPoints(a1) -- Line: 199 -- upvalues: u8 (val), now (val), u349 (ref), u370 (ref)
            local v1 = u8.ShouldShowEntryPoint(a1, now())
            local v2 = u349
            if v2 ~= nil then
                v2.Enabled = v1 and not a1.RewardGranted
            end
            v2 = u370
            if v2 ~= nil then
                v2.Enabled = v1
            end
        end

        local function loadSet(a1) -- Line: 213
            -- upvalues: u8 (val), u215 (ref), u216 (ref), u217 (ref), LoadQuestSet (val)
            local v1 = u8.BuildQuestRows(a1)
            u215 = a1.SetIndex
            u216 = v1
            u217 = {}
            for i, j in u8.GetActiveQuests(a1) or {} do
                u217[i] = j.Id
            end
            LoadQuestSet:Fire(v1)
        end

        local function everyRowClaimed() -- Line: 226 -- upvalues: u216 (ref)
            if #u216 == 0 then
                return false
            end
            for i, j in u216 do
                if j.State ~= "Claimed" then
                    return false
                end
            end
            return true
        end

        local function claimRow(a1, a2) -- Line: 241
            -- upvalues: u216 (ref), u8 (val), Audio (val), ClaimQuest (val), u382 (ref)
            local KeyEarned, v1
            u216[a1] = a2
            local QuestClaimed = u8.Sounds.QuestClaimed
            assert(QuestClaimed ~= nil, "no sound slot named QuestClaimed in OnboardingQuestline.Sounds")
            if QuestClaimed ~= 0 then
                Audio.Play(QuestClaimed, script, {})
            end
            ClaimQuest:Fire(a1)
            if #u216 ~= 0 then
                for i, j in u216 do
                    if j.State ~= "Claimed" then
                        if false then
                            u382 = true
                            KeyEarned = u8.Sounds.KeyEarned
                            assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                            if KeyEarned == 0 then
                                return
                            end
                            Audio.Play(KeyEarned, script, {})
                        end
                        return
                    end
                end
                v1 = true
            else
                v1 = false
            end
            if v1 then
                u382 = true
                KeyEarned = u8.Sounds.KeyEarned
                assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                if KeyEarned == 0 then
                    return
                end
                Audio.Play(KeyEarned, script, {})
            end
        end

        local function pushRows(a1) -- Line: 252
            -- upvalues: u216 (ref), u8 (val), Audio (val), ClaimQuest (val), u382 (ref), SetQuest (val)
            local KeyEarned, QuestClaimed, v1, v2
            local v3 = nil
            local v4 = nil
            for i, j in a1, v3, v4 do
                v1 = u216[i]
                if v1 ~= nil then
                    if j.State ~= "Claimed" then
                        if v1.Current ~= j.Current or v1.State ~= j.State or v1.ProgressText ~= j.ProgressText then
                            v2 = {
                                Current = j.Current,
                                Goal = j.Goal,
                                ProgressText = j.ProgressText,
                            }
                            if v1.State ~= j.State then
                                v2.State = j.State
                            end
                            u216[i] = j
                            SetQuest:Fire(i, v2)
                        end
                    elseif v1.State ~= "Claimed" then
                        u216[i] = j
                        QuestClaimed = u8.Sounds.QuestClaimed
                        assert(QuestClaimed ~= nil, "no sound slot named QuestClaimed in OnboardingQuestline.Sounds")
                        if QuestClaimed ~= 0 then
                            Audio.Play(QuestClaimed, script, {})
                        end
                        ClaimQuest:Fire(i)
                        if #u216 ~= 0 then
                            for k, n in u216 do
                                if n.State ~= "Claimed" then
                                    if false then
                                        u382 = true
                                        KeyEarned = u8.Sounds.KeyEarned
                                        assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                                        if KeyEarned ~= 0 then
                                            Audio.Play(KeyEarned, script, {})
                                        end
                                    end
                                    break
                                end
                            end
                            v2 = true
                        else
                            v2 = false
                        end
                        if v2 then
                            u382 = true
                            KeyEarned = u8.Sounds.KeyEarned
                            assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                            if KeyEarned ~= 0 then
                                Audio.Play(KeyEarned, script, {})
                            end
                        end
                    elseif v1.Current ~= j.Current or v1.State ~= j.State or v1.ProgressText ~= j.ProgressText then
                        v2 = {
                            Current = j.Current,
                            Goal = j.Goal,
                            ProgressText = j.ProgressText,
                        }
                        if v1.State ~= j.State then
                            v2.State = j.State
                        end
                        u216[i] = j
                        SetQuest:Fire(i, v2)
                    end
                end
            end
        end

        local function reconcile(a1) -- Line: 283
            -- upvalues: u364 (ref), u8 (val), now (val), u349 (ref), u370 (ref), u404 (ref), Workspace (upval)
            -- upvalues: Time (val), u379 (ref), u382 (ref), u215 (ref), u216 (ref), Audio (val), ClaimQuest (val)
            -- upvalues: u222 (ref), u220 (ref), pushRows (val)
            u364 = a1
            local v1 = u8.ShouldShowEntryPoint(a1, now())
            local v2 = u349
            if v2 ~= nil then
                v2.Enabled = v1 and not a1.RewardGranted
            end
            v2 = u370
            if v2 ~= nil then
                v2.Enabled = v1
            end
            v1 = u404
            if v1 ~= nil then
                if not a1.RewardGranted then
                    v2 = (u8.ExpiresAt(a1)) - Workspace:GetServerTimeNow()
                    v1.Text = if not (v2 <= 0) then ("%* LEFT"):format((Time.Elapsed(v2))) else "EXPIRED"
                else
                    v1.Text = "RESCUED!"
                end
            end
            if not u379 and not u382 then
                if a1.SetIndex == u215 then
                    if u220 ~= math.min(a1.UnlockedPadlocks, u8.PadlockCount) then
                        u222(a1)
                        return
                    end
                    if not u8.IsComplete(a1) then
                        pushRows(u8.BuildQuestRows(a1))
                    end
                    return
                end
                if a1.SetIndex == u215 + 1 then
                    local KeyEarned, QuestClaimed, v3, v4
                    v1 = false
                    local v5 = nil
                    local v6 = nil
                    for i, j in u216, v5, v6 do
                        if j.State ~= "Claimed" then
                            v3 = table.clone(j)
                            v3.State = "Claimed"
                            v3.Current = v3.Goal
                            v3.ProgressText = j.ProgressText
                            u216[i] = v3
                            QuestClaimed = u8.Sounds.QuestClaimed
                            assert(QuestClaimed ~= nil, "no sound slot named QuestClaimed in OnboardingQuestline.Sounds")
                            if QuestClaimed ~= 0 then
                                Audio.Play(QuestClaimed, script, {})
                            end
                            ClaimQuest:Fire(i)
                            if #u216 ~= 0 then
                                for k, n in u216 do
                                    if n.State ~= "Claimed" then
                                        if false then
                                            u382 = true
                                            KeyEarned = u8.Sounds.KeyEarned
                                            assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                                            if KeyEarned ~= 0 then
                                                Audio.Play(KeyEarned, script, {})
                                            end
                                        end
                                        v1 = true
                                        break
                                    end
                                end
                                v4 = true
                            else
                                v4 = false
                            end
                            if v4 then
                                u382 = true
                                KeyEarned = u8.Sounds.KeyEarned
                                assert(KeyEarned ~= nil, "no sound slot named KeyEarned in OnboardingQuestline.Sounds")
                                if KeyEarned ~= 0 then
                                    Audio.Play(KeyEarned, script, {})
                                end
                            end
                            v1 = true
                        end
                    end
                    if v1 then
                        return
                    end
                end
                u222(a1)
                return
            end
        end

        function u222(a1) -- Line: 334
            -- upvalues: u379 (ref), u382 (ref), u223 (ref), Info1 (val), u8 (val), Text (val), Info2 (val)
            -- upvalues: Text_2 (val), ResetAll (val), u220 (ref), UnlockNextLock (val), applyCageLocks (val)
            -- upvalues: loadSet (val), u215 (ref), reconcile (val)
            u379 = true
            u382 = false
            u223 = a1.RewardGranted
            local v1 = u223
            Info1.Text = if not v1 then Text else u8.TitleComplete
            Info2.Text = if not v1 then Text_2 else u8.SubtitleComplete
            ResetAll:Fire()
            u220 = math.min(a1.UnlockedPadlocks, u8.PadlockCount)
            v1 = u220
            for i = 1, v1 do
                UnlockNextLock:Fire()
            end
            applyCageLocks(u220, false)
            if u8.IsComplete(a1) then
                u215 = a1.SetIndex
            else
                loadSet(a1)
            end
            u379 = false
            reconcile(a1)
        end

        local function openMenu() -- Line: 359
            -- upvalues: u364 (ref), u8 (val), now (val), u382 (ref), u220 (ref), u222 (ref), Tabs (val), u335 (ref)
            -- upvalues: Open (val)
            local v1 = u364
            if v1 ~= nil and u8.ShouldShowEntryPoint(v1, now()) then
                if not u382 and u220 ~= math.min(v1.UnlockedPadlocks, u8.PadlockCount) then
                    u222(v1)
                end
                Tabs.Deactivate({instant = true})
                u335 = true
                Open:Fire()
                return
            end
        end

        local function closeMenu() -- Line: 379 -- upvalues: u335 (ref), Close (val), u8 (val), Audio (val)
            if not u335 then
                return
            end
            u335 = false
            Close:Fire()
            local CloseFrame = u8.Sounds.CloseFrame
            assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
            if CloseFrame == 0 then
                return
            end
            Audio.Play(CloseFrame, script, {})
        end

        local function bindCagePrompt() -- Line: 409
            -- upvalues: Workspace (upval), u8 (val), u349 (ref), u370 (ref), u404 (ref), AssetViewport (upval)
            -- upvalues: u227 (ref), applyCageLocks (val), u220 (ref), u364 (ref), now (val), Time (val)
            local v1, v2
            local v3 = Workspace:FindFirstChild(u8.CageModelName)
            if v3 == nil then
                return
            end
            local RescueDragonPrompt = v3:FindFirstChild("RescueDragonPrompt", true)
            local v4 = false
            if RescueDragonPrompt ~= nil then
                v4 = RescueDragonPrompt:IsA("ProximityPrompt")
            end
            assert(v4, (("Workspace.%* needs a ProximityPrompt named RescueDragonPrompt"):format(u8.CageModelName)))
            RescueDragonPrompt.Enabled = false
            local RescueDragonTimer = v3:FindFirstChild("RescueDragonTimer", true)
            v4 = false
            if RescueDragonTimer ~= nil then
                v4 = RescueDragonTimer:IsA("BillboardGui")
            end
            assert(v4, (("Workspace.%* needs a BillboardGui named RescueDragonTimer"):format(u8.CageModelName)))
            local Countdown = RescueDragonTimer:FindFirstChild("Countdown", true)
            local v5 = false
            if Countdown ~= nil then
                v5 = Countdown:IsA("TextLabel")
            end
            assert(v5, "RescueDragonTimer needs a TextLabel named Countdown")
            RescueDragonTimer.Enabled = false
            local CagedDragon = v3:FindFirstChild("CagedDragon")
            v5 = false
            if CagedDragon ~= nil then
                v5 = CagedDragon:IsA("Model")
            end
            assert(v5, (("Workspace.%* needs a Model named CagedDragon"):format(u8.CageModelName)))
            AssetViewport.LoopIdle(u8.RewardAssetId, CagedDragon)
            u227 = {}
            local PadlockCount = u8.PadlockCount
            for i = 1, PadlockCount do
                v1 = v3:FindFirstChild("Lock" .. i)
                v2 = false
                if v1 ~= nil then
                    v2 = v1:IsA("BasePart")
                end
                assert(v2, (("Workspace.%* needs a padlock part named Lock%*"):format(u8.CageModelName, i)))
                u227[i] = v1
            end
            applyCageLocks(u220, false)
            local v6 = u364
            if v6 ~= nil then
                v3 = u8.ShouldShowEntryPoint(v6, now())
                v4 = RescueDragonPrompt
                if v4 ~= nil then
                    v4.Enabled = v3 and not v6.RewardGranted
                end
                v4 = RescueDragonTimer
                if v4 ~= nil then
                    v4.Enabled = v3
                end
                v4 = Countdown
                if v4 == nil then
                    return
                end
                if v6.RewardGranted then
                    v4.Text = "RESCUED!"
                    return
                end
                v5 = (u8.ExpiresAt(v6)) - Workspace:GetServerTimeNow()
                v4.Text = if not (v5 <= 0) then ("%* LEFT"):format((Time.Elapsed(v5))) else "EXPIRED"
            end
        end

        ClaimClicked.Event:Connect(function(a1) -- Line: 388 -- upvalues: u217 (ref), Remotes (val), u8 (val), Audio (val) -- types: a1: number
            local u2 = u217[a1]
            if u2 == nil then
                return
            end
            task.spawn(function() -- Line: 394 -- upvalues: Remotes (upval), u2 (val), u8 (upval), Audio (upval)
                local success, err, v1 = pcall(function() -- Line: 395 -- upvalues: Remotes (upval), u2 (upval)
                    local v1 = u2
                    return Remotes.OnboardingQuestline.AskClaim:InvokeServer(v1)
                end)
                if not success then
                    warn((("[OnboardingQuestline] claim request failed: %*"):format(err)))
                    return
                end
                if not err then
                    local Warning = u8.Sounds.Warning
                    assert(Warning ~= nil, "no sound slot named Warning in OnboardingQuestline.Sounds")
                    if Warning ~= 0 then
                        Audio.Play(Warning, script, {})
                    end
                    warn((("[OnboardingQuestline] claim rejected: %*"):format((tostring(v1)))))
                end
            end)
        end)
        GoNowClicked.Event:Connect(function() -- Line: 467 -- upvalues: u335 (ref), Close (val), u8 (val), Audio (val)
            if not u335 then
                return
            end
            u335 = false
            Close:Fire()
            local CloseFrame = u8.Sounds.CloseFrame
            assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
            if CloseFrame == 0 then
                return
            end
            Audio.Play(CloseFrame, script, {})
        end)
        CloseClicked.Event:Connect(function() -- Line: 473 -- upvalues: u335 (ref), u8 (val), Audio (val)
            u335 = false
            local CloseFrame = u8.Sounds.CloseFrame
            assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
            if CloseFrame == 0 then
                return
            end
            Audio.Play(CloseFrame, script, {})
        end)
        LockUnlocked.Event:Connect(function() -- Line: 478
            -- upvalues: u379 (ref), u220 (ref), applyCageLocks (val), u364 (ref), u8 (val), u215 (ref), loadSet (val)
            -- upvalues: u382 (ref), reconcile (val)
            if u379 then
                return
            end
            u220 = u220 + 1
            applyCageLocks(u220, true)
            task.wait(0.4)
            local v1 = u364
            if v1 ~= nil then
                if not u8.IsComplete(v1) then
                    loadSet(v1)
                else
                    u215 = v1.SetIndex
                end
            end
            u382 = false
            if v1 ~= nil then
                reconcile(v1)
            end
        end)
        AllLocksUnlocked.Event:Connect(function() -- Line: 503
            -- upvalues: u379 (ref), u223 (ref), Info1 (val), u8 (val), Info2 (val), u335 (ref), Close (val)
            -- upvalues: Audio (val), showRewardScreen (val), Remotes (val)
            if not u379 and not u223 then
                u223 = true
                Info1.Text = u8.TitleComplete
                Info2.Text = u8.SubtitleComplete
                if u335 then
                    u335 = false
                    Close:Fire()
                    local CloseFrame = u8.Sounds.CloseFrame
                    assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
                    if CloseFrame ~= 0 then
                        Audio.Play(CloseFrame, script, {})
                    end
                end
                showRewardScreen()
                local u33 = {Reward = true}
                task.spawn(function() -- Line: 117 -- upvalues: Remotes (upval), u33 (val)
                    pcall(function() -- Line: 118 -- upvalues: Remotes (upval), u33 (upval)
                        local v1 = u33
                        Remotes.OnboardingQuestline.AskAcknowledge:InvokeServer(v1)
                    end)
                end)
                return
            end
        end)
        FTUEQuestMain.ChildAdded:Connect(function(a1) -- Line: 517 -- upvalues: u8 (val), Audio (val) -- types: a1: userdata
            if a1.Name == "FlyingKey" then
                local KeyFlight = u8.Sounds.KeyFlight
                assert(KeyFlight ~= nil, "no sound slot named KeyFlight in OnboardingQuestline.Sounds")
                if KeyFlight == 0 then
                    return
                end
                Audio.Play(KeyFlight, script, {})
            end
        end)
        FTUEQuestMain.ChildRemoved:Connect(function(a1) -- Line: 525 -- upvalues: u8 (val), Audio (val) -- types: a1: userdata
            if a1.Name == "FlyingKey" then
                local KeyTurn = u8.Sounds.KeyTurn
                assert(KeyTurn ~= nil, "no sound slot named KeyTurn in OnboardingQuestline.Sounds")
                if KeyTurn == 0 then
                    return
                end
                Audio.Play(KeyTurn, script, {})
            end
        end)
        local PadlockCount = u8.PadlockCount
        for i = 1, PadlockCount do
            v1 = FTUEQuestMain:FindFirstChild("Lock" .. i)
            v2 = ("FTUEQuestMain needs a Lock%* frame"):format(i)
            assert(v1 ~= nil, v2)
            v1.ChildAdded:Connect(function(a1) -- Line: 534
                -- upvalues: u8 (val), Audio (val), u227 (ref), i (val), applyCageLocks (val)
                if a1.Name ~= "LockUnlockedAnim" then
                    return
                end
                local LockBreak = u8.Sounds.LockBreak
                assert(LockBreak ~= nil, "no sound slot named LockBreak in OnboardingQuestline.Sounds")
                if LockBreak ~= 0 then
                    Audio.Play(LockBreak, script, {})
                end
                local v1 = u227[i]
                if v1 ~= nil then
                    local LockBreak_2 = u8.Sounds.LockBreak
                    assert(LockBreak_2 ~= nil, "no sound slot named LockBreak in OnboardingQuestline.Sounds")
                    if LockBreak_2 ~= 0 then
                        Audio.Play(LockBreak_2, v1 or script, {MaxDistance = 90} or {})
                    end
                end
                applyCageLocks(i, true)
            end)
        end
        Tabs.Activated:Connect(function() -- Line: 552 -- upvalues: u335 (ref), Close (val), u8 (val), Audio (val)
            if not u335 then
                return
            end
            u335 = false
            Close:Fire()
            local CloseFrame = u8.Sounds.CloseFrame
            assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
            if CloseFrame == 0 then
                return
            end
            Audio.Play(CloseFrame, script, {})
        end)
        ProximityPromptService.PromptTriggered:Connect(function(a1) -- Line: 556 -- upvalues: u349 (ref), openMenu (val) -- types: a1: userdata
            if a1 == u349 then
                openMenu()
            end
        end)
        v3.Enabled.Changed:Connect(function(a1) -- Line: 563
            -- upvalues: u335 (ref), Close (val), u8 (val), Audio (val), u364 (ref), now (val), u349 (ref), u370 (ref)
            if not a1 and u335 then
                u335 = false
                Close:Fire()
                local CloseFrame = u8.Sounds.CloseFrame
                assert(CloseFrame ~= nil, "no sound slot named CloseFrame in OnboardingQuestline.Sounds")
                if CloseFrame ~= 0 then
                    Audio.Play(CloseFrame, script, {})
                end
            end
            local v1 = u364
            if v1 ~= nil then
                local v2 = u8.ShouldShowEntryPoint(v1, now())
                local v3 = u349
                if v3 ~= nil then
                    v3.Enabled = v2 and not v1.RewardGranted
                end
                v3 = u370
                if v3 ~= nil then
                    v3.Enabled = v2
                end
            end
        end)
        v3.QuestTargets.Changed:Connect(function() -- Line: 574 -- upvalues: u364 (ref), u379 (ref), u382 (ref), u222 (ref)
            local v1 = u364
            if v1 ~= nil and not u379 and not u382 then
                u222(v1)
            end
        end)
        Workspace.ChildAdded:Connect(function(a1) -- Line: 581 -- upvalues: u8 (val), bindCagePrompt (val) -- types: a1: userdata
            if a1.Name == u8.CageModelName then
                task.defer(bindCagePrompt)
            end
        end)
        bindCagePrompt()
        task.spawn(function() -- Line: 588
            -- upvalues: u364 (ref), u404 (ref), u8 (val), Workspace (upval), Time (val), now (val), u349 (ref)
            -- upvalues: u370 (ref)
            local v1, v2, v3
            while true do
                v1 = u364
                if v1 ~= nil then
                    v2 = u404
                    if v2 ~= nil then
                        if not v1.RewardGranted then
                            v3 = (u8.ExpiresAt(v1)) - Workspace:GetServerTimeNow()
                            v2.Text = if not (v3 <= 0) then ("%* LEFT"):format((Time.Elapsed(v3))) else "EXPIRED"
                        else
                            v2.Text = "RESCUED!"
                        end
                    end
                    v2 = u8.ShouldShowEntryPoint(v1, now())
                    v3 = u349
                    if v3 ~= nil then
                        v3.Enabled = v2 and not v1.RewardGranted
                    end
                    v3 = u370
                    if v3 ~= nil then
                        v3.Enabled = v2
                    end
                end
                task.wait(1)
            end
        end)
        local v5 = Save.Await()
        local v6 = if not v5 then nil else OnboardingQuestline.Reconcile(v5[ProfileKey])
        if v6 ~= nil then
            u222(v6)
            if v3.AutoOpenEnabled:Get() and u8.ShouldShowEntryPoint(v6, now()) and u8.HasClaimable(v6) then
                task.delay(1.25, function() -- Line: 607 -- upvalues: Tabs (val), openMenu (val)
                    if not Tabs.IsActive() then
                        openMenu()
                    end
                end)
            end
        end
        Save.WatchFields(ProfileKey, function() -- Line: 615
            -- upvalues: Save (val), OnboardingQuestline (val), ProfileKey (val), u364 (ref), u222 (ref)
            -- upvalues: reconcile (val)
            local v1
            local v2 = Save.Await()
            if (if not v2 then nil else OnboardingQuestline.Reconcile(v2[ProfileKey])) == nil then
                return
            end
            if u364 == nil then
                u222(v1)
                return
            end
            reconcile(v1)
        end)
    end,
}