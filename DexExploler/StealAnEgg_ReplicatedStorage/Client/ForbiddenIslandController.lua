-- Script path: ReplicatedStorage.Client.ForbiddenIslandController
-- Decompile time: 23.78 ms

local AdService = game:GetService("AdService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local FullscreenPresentation = require(ReplicatedStorage.Client.FullscreenPresentation)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local LocalPlayer = Players.LocalPlayer
local u50 = {}
local u51 = {}
local u52 = {}

local function hideIneligible(a1) -- Line: 19 -- upvalues: u52 (val)
    if not u52[a1] then
        u52[a1] = (a1.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), a1 (val)
            u52[a1] = nil
        end))
    end
    a1.Parent = nil
end

local function dispose(a1) -- Line: 28 -- upvalues: u51 (val), u50 (val)
    if u51[a1] then
        u51[a1]:Disconnect()
        u51[a1] = nil
    end
    local v1 = u50[a1]
    if not v1 then
        return
    end
    u50[a1] = nil
    for i, j in v1.connections do
        j:Disconnect()
    end
    if v1.session then
        v1.session.Close()
    end
    for k, n in v1.tweens do
        n:Cancel()
        n:Destroy()
    end
    if v1.disclaimer then
        v1.disclaimer:Destroy()
    end
    if v1.video and v1.video.Parent then
        v1.video:Pause()
    end
end

local function bind(a1) -- Line: 56
    -- upvalues: u50 (val), u51 (val), Workspace (val), LocalizationService (val), LocalPlayer (val), u52 (val)
    -- upvalues: PolicyService (val), AdService (val), GameFlags (val), FullscreenPresentation (val), RunService (val)
    -- upvalues: dispose (val), TweenService (val)
    if a1.Name == "ForbiddenIsland" and a1:IsA("Model") and not u50[a1] then
        local Display = a1:FindFirstChild("Display")
        local AdGUI = Display
        if AdGUI then
            AdGUI = Display:FindFirstChild("AdGUI")
        end
        local VideoFrame = AdGUI
        if VideoFrame then
            VideoFrame = AdGUI:FindFirstChild("VideoFrame")
        end
        local ClickDetector = Display
        if ClickDetector then
            ClickDetector = Display:FindFirstChild("ClickDetector")
        end
        local WatchingGUI = a1:FindFirstChild("WatchingGUI")
        local DisclaimerGUI = a1:FindFirstChild("DisclaimerGUI")
        local AdDisclosure = DisclaimerGUI and DisclaimerGUI:FindFirstChild("AdDisclosure")
        if DisclaimerGUI then
            DisclaimerGUI.Enabled = false
        end
        local HintGUI = a1:FindFirstChild("HintGUI")
        local HintHighlight = a1:FindFirstChild("HintHighlight")
        local HintIcon = HintGUI and HintGUI:FindFirstChild("HintIcon")
        local UIScale = HintIcon
        if UIScale then
            UIScale = HintIcon:FindFirstChildOfClass("UIScale")
        end
        local u75 = a1:FindFirstChild("WatchStarted")
        local WatchEnded = a1:FindFirstChild("WatchEnded")
        local WatchLooped = a1:FindFirstChild("WatchLooped")
        local Watched = a1:FindFirstChild("Watched")
        if Display
            and AdGUI
            and VideoFrame
            and ClickDetector
            and WatchingGUI
            and DisclaimerGUI
            and AdDisclosure
            and HintGUI
            and HintHighlight
            and UIScale
            and u75
            and WatchEnded
            and WatchLooped
            and Watched then
            local u126 = {connections = {}, tweens = {}, video = VideoFrame}
            u50[a1] = u126
            if u51[a1] then
                u51[a1]:Disconnect()
                u51[a1] = nil
            end
            AdGUI.Enabled = false
            HintGUI.Enabled = false
            HintHighlight.Enabled = false
            VideoFrame:Pause()

            local function current() -- Line: 111 -- upvalues: u50 (upval), a1 (val), u126 (val), Workspace (upval)
                local v1 = false
                if u50[a1] == u126 then
                    v1 = a1:IsDescendantOf(Workspace)
                end
                return v1
            end

            task.spawn(function() -- Line: 115
                -- upvalues: LocalizationService (upval), LocalPlayer (upval), u50 (upval), a1 (val), u126 (val)
                -- upvalues: Workspace (upval), u52 (upval), PolicyService (upval), AdService (upval)
                -- upvalues: DisclaimerGUI (val), GameFlags (upval), VideoFrame (val), HintGUI (val)
                -- upvalues: HintHighlight (val), WatchEnded (val), ClickDetector (val), AdGUI (val)
                -- upvalues: FullscreenPresentation (upval), Display (val), WatchingGUI (val), u75 (val)
                -- upvalues: WatchLooped (val), Watched (val), RunService (upval), dispose (upval), TweenService (upval)
                -- upvalues: UIScale (val)
                local v1 = LocalPlayer
                local success, err = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, v1)
                local v2 = false
                if u50[a1] == u126 then
                    v2 = a1:IsDescendantOf(Workspace)
                end
                if not v2 then
                    return
                end
                v1 = table.find(tostring((a1:GetAttribute("RegionCodes")) or ""):split(), err) ~= nil
                v2 = if a1:GetAttribute("RegionFilterType") ~= "Whitelist" then not v1 else v1
                if success and v2 then
                    local v3 = LocalPlayer
                    local success_2, err_2 = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, v3)
                    local v4 = false
                    if u50[a1] == u126 then
                        v4 = a1:IsDescendantOf(Workspace)
                    end
                    if not v4 then
                        return
                    end
                    if success_2 and err_2 and err_2.AreAdsAllowed then
                        local err_4, finishWatch, success_4, u166, u193, u219, updateHints, v5, v6, v7
                        local Attribute_2 = a1:GetAttribute("CampaignID")
                        if Attribute_2 and Attribute_2 ~= "" then
                            v7 = AdService
                            local success_3, err_3 = pcall(AdService.GetCampaignEligibilityAsync, v7, Attribute_2)
                            v7 = false
                            if u50[a1] == u126 then
                                v7 = a1:IsDescendantOf(Workspace)
                            end
                            if not v7 then
                                return
                            end
                            if success_3 and err_3 and err_3.IsEligible then
                                v6 = tostring((a1:GetAttribute("PlacementID")) or "")
                                if v6 ~= "" then
                                    v5 = LocalPlayer:WaitForChild("PlayerGui")
                                    v4 = false
                                    if u50[a1] == u126 then
                                        v4 = a1:IsDescendantOf(Workspace)
                                    end
                                    if not v4 then
                                        return
                                    end
                                    v1 = DisclaimerGUI:Clone()
                                    u126.disclaimer = v1
                                    v1.ResetOnSpawn = false
                                    v1.Adornee = a1
                                    v1.Parent = v5
                                    success_4, err_4 = pcall(AdService.RegisterDisclosureButton, AdService, v1.AdDisclosure, v6)
                                    v7 = false
                                    if u50[a1] == u126 then
                                        v7 = a1:IsDescendantOf(Workspace)
                                    end
                                    if not v7 then
                                        return
                                    end
                                    if not success_4 then
                                        warn("ForbiddenIsland disclosure registration failed", err_4)
                                        u166 = a1
                                        if not u52[u166] then
                                            u52[u166] = (u166.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), u166 (val)
                                                u52[u166] = nil
                                            end))
                                        end
                                        u166.Parent = nil
                                        return
                                    end
                                    v1.Enabled = GameFlags.ForbiddenIslandEnabled:Get()
                                end
                                VideoFrame.Video = "rbxassetid://" .. tostring((a1:GetAttribute("VideoID")))
                                u193 = false

                                function updateHints() -- Line: 178
                                    -- upvalues: u193 (ref), u126 (upval), GameFlags (upval), HintGUI (upval)
                                    -- upvalues: HintHighlight (upval)
                                    local v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                    HintGUI.Enabled = v1
                                    HintHighlight.Enabled = v1
                                end

                                function finishWatch() -- Line: 184
                                    -- upvalues: u126 (upval), u50 (upval), a1 (upval), Workspace (upval)
                                    -- upvalues: WatchEnded (upval), u193 (ref), GameFlags (upval), HintGUI (upval)
                                    -- upvalues: HintHighlight (upval)
                                    if not u126.session then
                                        return
                                    end
                                    u126.session = nil
                                    if u126.loopConnection then
                                        u126.loopConnection:Disconnect()
                                        u126.loopConnection = nil
                                    end
                                    local v1 = false
                                    if u50[a1] == u126 then
                                        v1 = a1:IsDescendantOf(Workspace)
                                    end
                                    if v1 then
                                        v1 = WatchEnded
                                        if v1:IsDescendantOf(Workspace) then
                                            WatchEnded:FireServer()
                                            v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                            HintGUI.Enabled = v1
                                            HintHighlight.Enabled = v1
                                        end
                                    end
                                end

                                table.insert(u126.connections, (ClickDetector.MouseClick:Connect(function(a1_2) -- Line: 201
                                    -- upvalues: LocalPlayer (upval), u50 (upval), a1 (upval), u126 (upval)
                                    -- upvalues: Workspace (upval), u193 (ref), AdGUI (upval), GameFlags (upval)
                                    -- upvalues: FullscreenPresentation (upval), Display (upval), WatchingGUI (upval)
                                    -- upvalues: finishWatch (val), HintGUI (upval), HintHighlight (upval), u75 (upval)
                                    -- upvalues: VideoFrame (upval), WatchEnded (upval), WatchLooped (upval)
                                    -- upvalues: Watched (upval)
                                    if a1_2 == LocalPlayer then
                                        local v1 = false
                                        if u50[a1] == u126 then
                                            v1 = a1:IsDescendantOf(Workspace)
                                        end
                                        if v1
                                            and u193
                                            and AdGUI.Enabled
                                            and not u126.session
                                            and GameFlags.ForbiddenIslandEnabled:Get() then
                                            v1 = FullscreenPresentation.Open(a1, Display, WatchingGUI)
                                            if not v1 then
                                                return
                                            end
                                            u126.session = v1
                                            v1.Closed:Once(finishWatch)
                                            v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                            HintGUI.Enabled = v1
                                            HintHighlight.Enabled = v1
                                            u75:FireServer()
                                            u126.loopConnection = VideoFrame.DidLoop:Connect(function() -- Line: 220
                                                -- upvalues: u50 (upval), a1 (upval), u126 (upval), Workspace (upval)
                                                -- upvalues: WatchEnded (upval), u75 (upval), WatchLooped (upval)
                                                -- upvalues: Watched (upval)
                                                local v1 = false
                                                if u50[a1] == u126 then
                                                    v1 = a1:IsDescendantOf(Workspace)
                                                end
                                                if v1 and u126.session and not u126.session.IsClosed() then
                                                    WatchEnded:FireServer()
                                                    u75:FireServer()
                                                    WatchLooped:FireServer()
                                                    Watched:Fire()
                                                    return
                                                end
                                            end)
                                            return
                                        end
                                    end
                                end)))
                                table.insert(u126.connections, ((AdGUI:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 234 -- upvalues: AdGUI (upval), u126 (upval)
                                    if not AdGUI.Enabled and u126.session then
                                        u126.session.Close()
                                    end
                                end)))
                                u219 = 0
                                table.insert(u126.connections, (RunService.Heartbeat:Connect(function(a1_2) -- Line: 244
                                    -- upvalues: u219 (ref), u50 (upval), a1 (upval), u126 (upval), Workspace (upval)
                                    -- upvalues: dispose (upval), LocalPlayer (upval), GameFlags (upval), u193 (ref)
                                    -- upvalues: AdGUI (upval), HintGUI (upval), HintHighlight (upval)
                                    -- upvalues: VideoFrame (upval), TweenService (upval), UIScale (upval)
                                    local v1
                                    u219 = u219 + a1_2
                                    if u219 < 0.1 then
                                        return
                                    end
                                    u219 = 0
                                    local v2 = false
                                    if u50[a1] == u126 then
                                        v2 = a1:IsDescendantOf(Workspace)
                                    end
                                    if not v2 then
                                        dispose(a1)
                                        return
                                    end
                                    local Character = LocalPlayer.Character
                                    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                                    local v3 = false
                                    if Humanoid ~= nil then
                                        v3 = false
                                        if 0 < Humanoid.Health then
                                            v3 = false
                                            if (Character:GetPivot().Position - a1:GetPivot().Position).Magnitude <= 48 then
                                                v3 = GameFlags.ForbiddenIslandEnabled:Get()
                                            end
                                        end
                                    end
                                    if v3 == u193 then
                                        return
                                    end
                                    u193 = v3
                                    AdGUI.Enabled = u193
                                    if not u193 and u126.session then
                                        u126.session.Close()
                                    end
                                    v3 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                    HintGUI.Enabled = v3
                                    HintHighlight.Enabled = v3
                                    if not u193 then
                                        VideoFrame:Pause()
                                    else
                                        VideoFrame:Play()
                                    end
                                    for i, j in u126.tweens do
                                        j:Cancel()
                                        j:Destroy()
                                    end
                                    table.clear(u126.tweens)
                                    local v4 = {OutlineTransparency = if not u193 then 1 else 0}
                                    table.insert(u126.tweens, (TweenService:Create(
                                        HintHighlight,
                                        if not u193 then TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut) else TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, -1, true),
                                        v4
                                    )))
                                    table.insert(u126.tweens, (TweenService:Create(UIScale, v1, {Scale = if not u193 then 1 else 0.75})))
                                    for k, n in u126.tweens do
                                        n:Play()
                                    end
                                end)))
                                return
                            end
                            local u95 = a1
                            if not u52[u95] then
                                u52[u95] = (u95.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), u95 (val)
                                    u52[u95] = nil
                                end))
                            end
                            u95.Parent = nil
                            return
                        end
                        v6 = tostring((a1:GetAttribute("PlacementID")) or "")
                        if v6 ~= "" then
                            v5 = LocalPlayer:WaitForChild("PlayerGui")
                            v4 = false
                            if u50[a1] == u126 then
                                v4 = a1:IsDescendantOf(Workspace)
                            end
                            if not v4 then
                                return
                            end
                            v1 = DisclaimerGUI:Clone()
                            u126.disclaimer = v1
                            v1.ResetOnSpawn = false
                            v1.Adornee = a1
                            v1.Parent = v5
                            success_4, err_4 = pcall(AdService.RegisterDisclosureButton, AdService, v1.AdDisclosure, v6)
                            v7 = false
                            if u50[a1] == u126 then
                                v7 = a1:IsDescendantOf(Workspace)
                            end
                            if not v7 then
                                return
                            end
                            if not success_4 then
                                warn("ForbiddenIsland disclosure registration failed", err_4)
                                u166 = a1
                                if not u52[u166] then
                                    u52[u166] = (u166.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), u166 (val)
                                        u52[u166] = nil
                                    end))
                                end
                                u166.Parent = nil
                                return
                            end
                            v1.Enabled = GameFlags.ForbiddenIslandEnabled:Get()
                        end
                        VideoFrame.Video = "rbxassetid://" .. tostring((a1:GetAttribute("VideoID")))
                        u193 = false

                        function updateHints() -- Line: 178
                            -- upvalues: u193 (ref), u126 (upval), GameFlags (upval), HintGUI (upval)
                            -- upvalues: HintHighlight (upval)
                            local v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                            HintGUI.Enabled = v1
                            HintHighlight.Enabled = v1
                        end

                        function finishWatch() -- Line: 184
                            -- upvalues: u126 (upval), u50 (upval), a1 (upval), Workspace (upval), WatchEnded (upval)
                            -- upvalues: u193 (ref), GameFlags (upval), HintGUI (upval), HintHighlight (upval)
                            if not u126.session then
                                return
                            end
                            u126.session = nil
                            if u126.loopConnection then
                                u126.loopConnection:Disconnect()
                                u126.loopConnection = nil
                            end
                            local v1 = false
                            if u50[a1] == u126 then
                                v1 = a1:IsDescendantOf(Workspace)
                            end
                            if v1 then
                                v1 = WatchEnded
                                if v1:IsDescendantOf(Workspace) then
                                    WatchEnded:FireServer()
                                    v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                    HintGUI.Enabled = v1
                                    HintHighlight.Enabled = v1
                                end
                            end
                        end

                        table.insert(u126.connections, (ClickDetector.MouseClick:Connect(function(a1_2) -- Line: 201
                            -- upvalues: LocalPlayer (upval), u50 (upval), a1 (upval), u126 (upval), Workspace (upval)
                            -- upvalues: u193 (ref), AdGUI (upval), GameFlags (upval), FullscreenPresentation (upval)
                            -- upvalues: Display (upval), WatchingGUI (upval), finishWatch (val), HintGUI (upval)
                            -- upvalues: HintHighlight (upval), u75 (upval), VideoFrame (upval), WatchEnded (upval)
                            -- upvalues: WatchLooped (upval), Watched (upval)
                            if a1_2 == LocalPlayer then
                                local v1 = false
                                if u50[a1] == u126 then
                                    v1 = a1:IsDescendantOf(Workspace)
                                end
                                if v1
                                    and u193
                                    and AdGUI.Enabled
                                    and not u126.session
                                    and GameFlags.ForbiddenIslandEnabled:Get() then
                                    v1 = FullscreenPresentation.Open(a1, Display, WatchingGUI)
                                    if not v1 then
                                        return
                                    end
                                    u126.session = v1
                                    v1.Closed:Once(finishWatch)
                                    v1 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                                    HintGUI.Enabled = v1
                                    HintHighlight.Enabled = v1
                                    u75:FireServer()
                                    u126.loopConnection = VideoFrame.DidLoop:Connect(function() -- Line: 220
                                        -- upvalues: u50 (upval), a1 (upval), u126 (upval), Workspace (upval)
                                        -- upvalues: WatchEnded (upval), u75 (upval), WatchLooped (upval)
                                        -- upvalues: Watched (upval)
                                        local v1 = false
                                        if u50[a1] == u126 then
                                            v1 = a1:IsDescendantOf(Workspace)
                                        end
                                        if v1 and u126.session and not u126.session.IsClosed() then
                                            WatchEnded:FireServer()
                                            u75:FireServer()
                                            WatchLooped:FireServer()
                                            Watched:Fire()
                                            return
                                        end
                                    end)
                                    return
                                end
                            end
                        end)))
                        table.insert(u126.connections, ((AdGUI:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 234 -- upvalues: AdGUI (upval), u126 (upval)
                            if not AdGUI.Enabled and u126.session then
                                u126.session.Close()
                            end
                        end)))
                        u219 = 0
                        table.insert(u126.connections, (RunService.Heartbeat:Connect(function(a1_2) -- Line: 244
                            -- upvalues: u219 (ref), u50 (upval), a1 (upval), u126 (upval), Workspace (upval)
                            -- upvalues: dispose (upval), LocalPlayer (upval), GameFlags (upval), u193 (ref)
                            -- upvalues: AdGUI (upval), HintGUI (upval), HintHighlight (upval), VideoFrame (upval)
                            -- upvalues: TweenService (upval), UIScale (upval)
                            local v1
                            u219 = u219 + a1_2
                            if u219 < 0.1 then
                                return
                            end
                            u219 = 0
                            local v2 = false
                            if u50[a1] == u126 then
                                v2 = a1:IsDescendantOf(Workspace)
                            end
                            if not v2 then
                                dispose(a1)
                                return
                            end
                            local Character = LocalPlayer.Character
                            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                            local v3 = false
                            if Humanoid ~= nil then
                                v3 = false
                                if 0 < Humanoid.Health then
                                    v3 = false
                                    if (Character:GetPivot().Position - a1:GetPivot().Position).Magnitude <= 48 then
                                        v3 = GameFlags.ForbiddenIslandEnabled:Get()
                                    end
                                end
                            end
                            if v3 == u193 then
                                return
                            end
                            u193 = v3
                            AdGUI.Enabled = u193
                            if not u193 and u126.session then
                                u126.session.Close()
                            end
                            v3 = u193 and not u126.session and GameFlags.ForbiddenIslandEnabled:Get()
                            HintGUI.Enabled = v3
                            HintHighlight.Enabled = v3
                            if not u193 then
                                VideoFrame:Pause()
                            else
                                VideoFrame:Play()
                            end
                            for i, j in u126.tweens do
                                j:Cancel()
                                j:Destroy()
                            end
                            table.clear(u126.tweens)
                            local v4 = {OutlineTransparency = if not u193 then 1 else 0}
                            table.insert(u126.tweens, (TweenService:Create(
                                HintHighlight,
                                if not u193 then TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut) else TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, -1, true),
                                v4
                            )))
                            table.insert(u126.tweens, (TweenService:Create(UIScale, v1, {Scale = if not u193 then 1 else 0.75})))
                            for k, n in u126.tweens do
                                n:Play()
                            end
                        end)))
                        return
                    end
                    local u230 = a1
                    if not u52[u230] then
                        u52[u230] = (u230.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), u230 (val)
                            u52[u230] = nil
                        end))
                    end
                    u230.Parent = nil
                    return
                end
                local u241 = a1
                if not u52[u241] then
                    u52[u241] = (u241.Destroying:Once(function() -- Line: 21 -- upvalues: u52 (upval), u241 (val)
                        u52[u241] = nil
                    end))
                end
                u241.Parent = nil
            end)
            return
        end
        return
    end
end

local function observe(a1) -- Line: 302 -- upvalues: u52 (val), u50 (val), u51 (val), bind (val)
    if a1.Name == "ForbiddenIsland" and a1:IsA("Model") then
        if u52[a1] then
            u52[a1]:Disconnect()
            u52[a1] = nil
        end
        if not u50[a1] and not u51[a1] then
            u51[a1] = (a1.DescendantAdded:Connect(function() -- Line: 311 -- upvalues: bind (upval), a1 (val)
                bind(a1)
            end))
        end
        bind(a1)
        return
    end
end

Workspace.ChildAdded:Connect(observe)
Workspace.ChildRemoved:Connect(dispose)
GameFlags.ForbiddenIslandEnabled.Changed:Connect(function(a1) -- Line: 320 -- upvalues: u50 (val)
    for i, j in u50 do
        if j.disclaimer then
            j.disclaimer.Enabled = a1
        end
    end
    if not a1 then
        for k, n in u50 do
            if n.session then
                n.session.Close()
            end
        end
    end
end)
for i, j in Workspace:GetChildren() do
    observe(j)
end
return table.freeze({})