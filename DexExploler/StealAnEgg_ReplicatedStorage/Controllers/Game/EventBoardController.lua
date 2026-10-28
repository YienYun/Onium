-- Script path: ReplicatedStorage.Controllers.Game.EventBoardController
-- Decompile time: 9.85 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local EventBoardView = require(ReplicatedStorage.Shared.Modules.EventBoardView)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
return {
    Start = function() -- Line: 36
        -- upvalues: Players (val), Log (val), PlotState (val), Workspace (val), EventBoardView (val)
        -- upvalues: SocialService (val), SoundService (val), RunService (val)
        local LocalPlayer = Players.LocalPlayer
        local u4 = Log.new()
        local u5 = {}
        local u6 = false
        local u7 = nil
        local u8 = nil
        local u9 = nil
        local u10 = nil
        local u11 = nil
        local u12 = nil

        local function setShown(a1, a2) -- Line: 53 -- types: a1: userdata, a2: boolean
            local Attribute, v1
            local v2 = a2
            for i, j in a1:GetDescendants() do
                if j:IsA("BasePart") then
                    Attribute = j:GetAttribute("BoardClear")
                    v1 = if not v2 then 1 else if typeof(Attribute) ~= "number" then 0 else Attribute
                    j.Transparency = v1
                elseif j:IsA("SurfaceGui") or j:IsA("ProximityPrompt") then
                    j.Enabled = v2
                end
            end
        end

        local function getOwnBoard() -- Line: 66 -- upvalues: PlotState (upval), Workspace (upval)
            local v1 = PlotState.ResolveLocalSlot()
            if v1 == nil then
                return nil
            end
            local Plots = Workspace:FindFirstChild("Plots")
            local v2 = if Plots == nil then nil else Plots:FindFirstChild((tostring(v1)))
            local v3 = if v2 == nil then nil else v2:FindFirstChild("EventBoard")
            if v3 ~= nil and v3:IsA("Model") then
                return v3
            end
            return nil
        end

        local function formatTimer(a1) -- Line: 78 -- upvalues: EventBoardView (upval)
            return (("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(a1.StartsAt - (os.time())))))
        end

        local function takeDown() -- Line: 82
            -- upvalues: u5 (val), u9 (ref), u10 (ref), u7 (ref), setShown (val), u8 (ref)
            for i, j in u5 do
                j:Disconnect()
            end
            table.clear(u5)
            if u9 ~= nil then
                u9:Destroy()
                u9 = nil
            end
            if u10 ~= nil then
                u10:Destroy()
                u10 = nil
            end
            local v1 = u7
            if v1 ~= nil and v1.Parent ~= nil then
                setShown(v1, false)
            end
            u7 = nil
            u8 = nil
        end

        local function onTriggered(a1) -- Line: 106
            -- upvalues: u6 (ref), SocialService (upval), u4 (val), takeDown (val)
            if u6 then
                return
            end
            u6 = true
            local success, err = pcall(SocialService.PromptRsvpToEventAsync, SocialService, a1.Id)
            if not success then
                (u4:AtWarning()):Log((("EventBoard RSVP prompt failed: %*"):format(err)))
                u6 = false
                return
            end
            local success_2, err_2 = pcall(SocialService.GetEventRsvpStatusAsync, SocialService, a1.Id)
            if success_2 and err_2 == Enum.RsvpStatus.Going then
                takeDown()
            end
            u6 = false
        end

        local function mount(a1, a2) -- Line: 127
            -- upvalues: setShown (val), EventBoardView (upval), u9 (ref), u5 (val), LocalPlayer (val)
            -- upvalues: onTriggered (val), u4 (val), SoundService (upval), u10 (ref), RunService (upval), u7 (ref)
            -- upvalues: u8 (ref), u11 (ref)
            setShown(a2, true)
            local Display = a2:FindFirstChild("Display")
            local SurfaceGui = if Display == nil then nil else Display:FindFirstChildWhichIsA("SurfaceGui")
            if SurfaceGui ~= nil then
                local v1 = SurfaceGui:FindFirstChild("Frame") or SurfaceGui
                local EventCountdown = v1:FindFirstChild("EventCountdown")
                if EventCountdown ~= nil then
                    EventCountdown:Destroy()
                end
                local TextLabel = Instance.new("TextLabel")
                TextLabel.Name = "EventCountdown"
                TextLabel.BackgroundTransparency = 1
                TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                TextLabel.Position = UDim2.fromScale(0.5, 0.5)
                TextLabel.Size = UDim2.fromScale(0.9, 0.45)
                TextLabel.TextScaled = true
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.Text = ("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(a1.StartsAt - (os.time()))))
                TextLabel.ZIndex = 5
                local UIStroke = Instance.new("UIStroke")
                UIStroke.Thickness = 3
                UIStroke.Color = Color3.fromRGB(0, 0, 0)
                UIStroke.Parent = TextLabel
                TextLabel.Parent = v1
                u9 = TextLabel
            end
            local ProximityPrompt = a2:FindFirstChildWhichIsA("ProximityPrompt", true)
            if ProximityPrompt == nil then
                u4:AtWarning():Log("EventBoard has no ProximityPrompt, sign-up is display only")
            else
                ProximityPrompt.RequiresLineOfSight = false
                ProximityPrompt.MaxActivationDistance = EventBoardView.PromptDistance
                ProximityPrompt.HoldDuration = 0
                if a1.Title ~= "" then
                    ProximityPrompt.ObjectText = a1.Title
                end
                if ProximityPrompt.ActionText == "" then
                    ProximityPrompt.ActionText = "Follow Event"
                end
                table.insert(u5, (ProximityPrompt.Triggered:Connect(function(a1_2) -- Line: 171 -- upvalues: LocalPlayer (upval), onTriggered (upval), a1 (val) -- types: a1_2: userdata
                    if a1_2 == LocalPlayer then
                        task.spawn(onTriggered, a1)
                    end
                end)))
            end
            if Display ~= nil and Display:IsA("BasePart") then
                local Sound = Instance.new("Sound")
                Sound.Name = "EventBoardAmbience"
                Sound.SoundId = "rbxassetid://139717384302574"
                Sound.Looped = true
                Sound.Volume = 0.5
                Sound.RollOffMode = Enum.RollOffMode.Linear
                Sound.RollOffMinDistance = 4
                Sound.RollOffMaxDistance = 14
                Sound.SoundGroup = SoundService:FindFirstChild("Gameplay")
                Sound.Parent = Display
                u10 = Sound
                table.insert(u5, (RunService.Heartbeat:Connect(function() -- Line: 194 -- upvalues: LocalPlayer (upval), Display (val), Sound (val)
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
                    local v1 = false
                    if HumanoidRootPart ~= nil then
                        v1 = HumanoidRootPart:IsA("BasePart") and (HumanoidRootPart.Position - Display.Position).Magnitude <= 14
                    end
                    if v1 and not Sound.IsPlaying then
                        Sound:Play()
                        return
                    end
                    if not v1 and Sound.IsPlaying then
                        Sound:Stop()
                    end
                end)))
            end
            u7 = a2
            u8 = a1.Id
            u11 = nil
            ;(u4:AtInfo()):Log((("EventBoard mounted for event %*"):format(a1.Id)))
        end

        local function reportBail(a1) -- Line: 215 -- upvalues: u11 (ref), u4 (val) -- types: a1: string
            if u11 == a1 then
                return
            end
            u11 = a1
            ;(u4:AtInfo()):Log((("EventBoard hidden: %*"):format(a1)))
        end

        local function isVariantServer() -- Line: 223 -- upvalues: Workspace (upval)
            return Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant"
        end

        local function waitForVariantServer() -- Line: 227 -- upvalues: Workspace (upval)
            local v1 = os.clock() + 60
            while Workspace:GetAttribute("ExpandedLobbyServerGroup") == nil do
                if not (os.clock() < v1) then
                    break
                end
                task.wait(0.5)
            end
            return Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant"
        end

        local function apply() -- Line: 235
            -- upvalues: u6 (ref), u7 (ref), takeDown (val), u12 (ref), Workspace (upval), u11 (ref), u4 (val)
            -- upvalues: EventBoardView (upval), u8 (ref), getOwnBoard (val), PlotState (upval), mount (val)
            if u6 then
                return
            end
            if u7 ~= nil and u7.Parent == nil then
                takeDown()
            end
            local v1 = u12
            local v2 = Workspace:GetAttribute("ExpandedLobbyServerGroup") == "Variant"
            if not v2 then
                v2 = ("server group is %*, not Variant"):format((tostring((Workspace:GetAttribute("ExpandedLobbyServerGroup")))))
                if u11 ~= v2 then
                    u11 = v2
                    ;(u4:AtInfo()):Log((("EventBoard hidden: %*"):format(v2)))
                end
                takeDown()
                return
            end
            if v1 == nil then
                if u11 ~= "no upcoming event (none active and not yet started for this universe)" then
                    u11 = "no upcoming event (none active and not yet started for this universe)"
                    u4:AtInfo():Log("EventBoard hidden: no upcoming event (none active and not yet started for this universe)")
                end
                takeDown()
                return
            end
            if not EventBoardView.ShouldShow(v1) then
                v2 = ("event %* hidden: player is already going"):format(v1.Id)
                if u11 ~= v2 then
                    u11 = v2
                    ;(u4:AtInfo()):Log((("EventBoard hidden: %*"):format(v2)))
                end
                takeDown()
                return
            end
            if u7 ~= nil and u8 == v1.Id then
                return
            end
            v2 = getOwnBoard()
            if v2 ~= nil then
                takeDown()
                mount(v1, v2)
                return
            end
            local v3 = ("no EventBoard model found on plot %*"):format((tostring((PlotState.ResolveLocalSlot()))))
            if u11 == v3 then
                return
            end
            u11 = v3
            ;(u4:AtInfo()):Log((("EventBoard hidden: %*"):format(v3)))
        end

        local function refreshUpcoming() -- Line: 273
            -- upvalues: SocialService (upval), u4 (val), u12 (ref), EventBoardView (upval)
            local success, err = pcall(function() -- Line: 274 -- upvalues: SocialService (upval)
                return SocialService:GetUpcomingExperienceEventsAsync()
            end)
            if not success then
                (u4:AtWarning()):Log((("EventBoard failed to fetch experience events: %*"):format(err)))
                return false
            end
            EventBoardView.Pick(err, os.time())
            return true
        end

        task.spawn(function() -- Line: 290
            -- upvalues: waitForVariantServer (val), u4 (val), Workspace (upval), PlotState (upval), apply (val)
            -- upvalues: refreshUpcoming (val), EventBoardView (upval), u9 (ref), u12 (ref), u7 (ref)
            if not waitForVariantServer() then
                (u4:AtInfo()):Log((("EventBoard idle, server group is %*"):format((tostring((Workspace:GetAttribute("ExpandedLobbyServerGroup")))))))
                return
            end
            PlotState.LocalPlotChanged:Connect(function() -- Line: 297 -- upvalues: apply (upval)
                apply()
            end)
            task.spawn(function() -- Line: 301 -- upvalues: refreshUpcoming (upval), apply (upval), EventBoardView (upval)
                local v1, wait
                while true do
                    v1 = refreshUpcoming()
                    apply()
                    wait = task.wait
                    if not v1 then
                        wait(EventBoardView.RetryBackoffSeconds)
                    else
                        wait(EventBoardView.RefreshSeconds)
                    end
                end
            end)
            task.spawn(function() -- Line: 309 -- upvalues: EventBoardView (upval), u9 (upval), u12 (upval)
                local v1, v2
                while true do
                    task.wait(EventBoardView.TimerUpdateSeconds)
                    v1 = u9
                    v2 = u12
                    if v1 ~= nil and v1.Parent ~= nil and v2 ~= nil then
                        v1.Text = ("NEXT UPDATE\n%*"):format((EventBoardView.Countdown(v2.StartsAt - (os.time()))))
                    end
                end
            end)
            task.spawn(function() -- Line: 319 -- upvalues: u12 (upval), u7 (upval), apply (upval)
                while true do
                    task.wait(5)
                    if u12 ~= nil then
                        if u7 == nil or u7.Parent == nil then
                            apply()
                        end
                    end
                end
            end)
        end)
    end,
}