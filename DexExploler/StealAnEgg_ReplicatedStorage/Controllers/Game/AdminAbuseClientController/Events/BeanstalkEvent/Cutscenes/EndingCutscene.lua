-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Cutscenes.EndingCutscene
-- Decompile time: 19.85 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local EndingCutscene = ReplicatedStorage.CutsceneAssets.BeanstalkEventCutsceneAssets.EndingCutscene
local u82 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u88 = {"Sky", "Atmosphere"}
local EndingCutsceneSeconds = BeanstalkEvent.EndingCutsceneSeconds
local EndingHandBackSeconds = BeanstalkEvent.EndingHandBackSeconds
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u95 = nil
local u96 = nil
local u97 = nil
local u98 = nil
local u99 = {}

local function restoreCamera() -- Line: 59 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 68
    -- upvalues: u96 (ref), u97 (ref), Tabs (val), LocalPlayer (val), u82 (val), StarterGui (val), u98 (ref)
    if u96 ~= nil then
        return
    end
    local v1 = {}
    Tabs.Active()
    for i, j in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if j:IsA("ScreenGui") and j.Name ~= "CutsceneUI" and j.Enabled then
            v1[j] = true
            j.Enabled = false
        end
    end
    u96 = v1
    pcall(function() -- Line: 83 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u82 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u98 = v1
end

local function restoreAllUi() -- Line: 93
    -- upvalues: u96 (ref), u97 (ref), LocalPlayer (val), u98 (ref), StarterGui (val)
    local v1 = u96
    local v2 = u97
    u96 = nil
    u97 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 106 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u98
    u98 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 118 -- upvalues: u95 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u95 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 125 -- upvalues: restoreAllUi (val), u95 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u95
    u95 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 137 -- types: a1: table, a2: number?
    local Attribute, Transparency
    local v1 = nil
    local v2 = nil
    for i, j in a1, v1, v2 do
        if j:IsA("BasePart") then
            if not j:GetAttribute("OriginalTransparency") then
                Transparency = j.Transparency
                j:SetAttribute("OriginalTransparency", Transparency)
            end
            Attribute = a2 or j:GetAttribute("OriginalTransparency")
            j.Transparency = Attribute
        end
    end
end

local function restoreGuard(a1, a2) -- Line: 150 -- upvalues: u99 (val) -- types: a1: userdata, a2: userdata
    u99[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 159 -- upvalues: u99 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u99[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 173
            -- upvalues: Guard (val), j (val), u99 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u99[v1] = nil
            local Guard_2 = v2:FindFirstChild("Guard")
            if Guard_2 == nil or Guard_2 == v1 then
                v1.Parent = v2
            end
            if Nests then
                setTransparency(Descendants)
            end
        end)
    end
end

local function hideLiveForest(a1) -- Line: 184 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Build = if World == nil then nil else World:FindFirstChild("Build")
    if Build == nil then
        return
    end
    local u12 = {}
    local u13 = true
    a1:Add(function() -- Line: 192 -- upvalues: u13 (ref), u12 (val), Build (val)
        local Name
        u13 = false
        for i, j in u12 do
            if j.Parent == Build then
                Name = i.Name
                if j:FindFirstChild(Name) == nil then
                    i.Parent = j
                end
            end
        end
    end)
    a1:Connect(Build.DescendantAdded, function(a1) -- Line: 200 -- upvalues: u13 (ref), u12 (val), Build (val) -- types: a1: userdata
        local Parent = a1.Parent
        if u13
            and not u12[a1]
            and a1.Name == "Zone13Props"
            and Parent ~= nil
            and Parent.Name == "EnchantedForestZone"
            and Parent.Parent == Build then
            u12[a1] = Parent
            a1.Parent = nil
            return
        end
    end)
    local EnchantedForestZone = Build:FindFirstChild("EnchantedForestZone")
    local Zone13Props = if EnchantedForestZone == nil then nil else EnchantedForestZone:FindFirstChild("Zone13Props")
    if Zone13Props ~= nil then
        local Parent = Zone13Props.Parent
        if u13
            and not u12[Zone13Props]
            and Zone13Props.Name == "Zone13Props"
            and Parent ~= nil
            and Parent.Name == "EnchantedForestZone"
            and Parent.Parent == Build then
            u12[Zone13Props] = Parent
            Zone13Props.Parent = nil
        end
    end
end

local function emitBurst(a1) -- Line: 221 -- types: a1: userdata
    local Attribute, Attribute_2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            Attribute = j:GetAttribute("EmitCount")
            Attribute_2 = j:GetAttribute("EmitDuration")
            if type(Attribute) == "number" and Attribute ~= 0 then
                j:Emit(Attribute)
            end
            if type(Attribute_2) == "number" and Attribute_2 ~= 0 then
                j.Enabled = true
                task.delay(Attribute_2, function() -- Line: 234 -- upvalues: j (val)
                    j.Enabled = false
                end)
            end
        end
    end
end

return function(a1) -- Line: 243
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), TweenService (val), emitBurst (val)
    -- upvalues: hideCutsceneUi (val), restoreCutsceneUi (val), Workspace (val), ReplicatedStorage (val)
    -- upvalues: hideAllGuardsAndNests (val), hideLiveForest (val), LightingController (val), u88 (val), Lighting (val)
    -- upvalues: EndingCutscene (val), SoundService (val), ContentProvider (val), restoreCamera (val), RunService (val)
    -- upvalues: CurrentCamera (val), EndingCutsceneSeconds (val), BulkFade (val), EndingHandBackSeconds (val)
    local u3 = a1:Extend()
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(u3)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local Letterbox = CutsceneUI.Letterbox
    local u17 = nil

    local function tweenLetterbox(a1, a2) -- Line: 257
        -- upvalues: Letterbox (val), TweenService (upval)
        return function() -- Line: 258 -- upvalues: Letterbox (upval), TweenService (upval), a1 (val), a2 (val)
            for i, j in Letterbox:GetChildren() do
                if j:IsA("Frame") then
                    TweenService:Create(j, a1, {BackgroundTransparency = a2}):Play()
                end
            end
        end
    end

    local u19 = {}
    local v2 = {}
    local v3 = SetProperty(
        "Workspace.CurrentCamera.CFrame",
        CFrame.new(6998.7129, 121.5715, -423.1443, -0.9049, -0.299, 0.3027, -0, 0.7114, 0.7028, -0.4255, 0.636, -0.6438)
    )
    local v4 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v5 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v6 = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 1)
    local v7 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v8 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    local u65 = TweenInfo.new(0)
    local u66 = 1
    local v9 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v10 = SetProperty("Lighting.CutsceneBlur.Size", 15)
    local v11 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 4)
    local v12 = SetProperty("Lighting.CutsceneDepthOfField.Enabled", true)
    local v13 = SetProperty("Lighting.CutsceneDepthOfField.FarIntensity", 0.26)
    local v14 = SetProperty("Lighting.CutsceneDepthOfField.FocusDistance", 0)
    local v15 = TweenProperty("Lighting.CutsceneDepthOfField.FocusDistance", TweenInfo.new(30.516666666666666, Enum.EasingStyle.Linear), 23.95343)
    local v16 = SetProperty("Lighting.CutsceneDepthOfField.InFocusRadius", 50)
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5
    v2[4] = v6
    v2[5] = v7
    v2[6] = v8

    v2[7] = function() -- Line: 258 -- upvalues: Letterbox (val), TweenService (upval), u65 (val), u66 (val)
        for i, j in Letterbox:GetChildren() do
            if j:IsA("Frame") then
                TweenService:Create(j, u65, {BackgroundTransparency = u66}):Play()
            end
        end
    end

    v2[8] = v9
    v2[9] = v10
    v2[10] = v11
    v2[11] = v12
    v2[12] = v13
    v2[13] = v14
    v2[14] = v15
    v2[15] = v16
    v2[16] = (SetProperty("Lighting.CutsceneDepthOfField.NearIntensity", 0.75))
    v2[17] = TweenProperty("Lighting.CutsceneDepthOfField.NearIntensity", TweenInfo.new(30.516666666666666, Enum.EasingStyle.Linear), 0.36675)
    u19[0] = v2
    u19[47] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u19[49] = {
        function() -- Line: 293 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.EggSlam)
        end,
    }
    u19[51] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 2)),
    }
    u19[698] = {
        function() -- Line: 303 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Knock)
        end,
    }
    u19[723] = {
        function() -- Line: 309 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Knock)
        end,
    }
    u19[905] = {
        function() -- Line: 315 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Shake)
        end,
    }
    u19[1046] = {
        function() -- Line: 321 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Shake)
        end,
    }
    u19[1096] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.6166666666666667, Enum.EasingStyle.Linear), 0)),
    }
    u19[1213] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u19[1215] = {
        function() -- Line: 335 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.EggBreak)
        end,
    }
    u19[1218] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 4)),
    }
    u19[1277] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 15)),
    }
    u19[1284] = {
        function() -- Line: 349 -- upvalues: emitBurst (upval), u17 (ref)
            emitBurst(u17.Smoke)
        end,
    }
    u19[1292] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 3)),
    }
    u19[1639] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.8666666666666667, Enum.EasingStyle.Linear), 1)),
    }
    u19[1831] = {
        TweenProperty("Lighting.CutsceneDepthOfField.FocusDistance", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 23.96651),
        TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2.06698),
        (TweenProperty("Lighting.CutsceneDepthOfField.NearIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.36654)),
    }
    u19[1832] = {
        TweenProperty("Lighting.CutsceneDepthOfField.FocusDistance", TweenInfo.new(1.3166666666666667, Enum.EasingStyle.Linear), 25),
        TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(1.3166666666666667, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.CutsceneDepthOfField.NearIntensity", TweenInfo.new(1.3166666666666667, Enum.EasingStyle.Linear), 0.35)),
    }
    u19[1972] = {
        TweenProperty("Lighting.CutsceneDepthOfField.FocusDistance", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 50)),
    }
    v2 = {}
    local u293 = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear)
    local u294 = 0

    v2[1] = function() -- Line: 258 -- upvalues: Letterbox (val), TweenService (upval), u293 (val), u294 (val)
        for i, j in Letterbox:GetChildren() do
            if j:IsA("Frame") then
                TweenService:Create(j, u293, {BackgroundTransparency = u294}):Play()
            end
        end
    end

    u19[2100] = v2
    u19[2251] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 10)),
    }
    u19[2271] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0)),
    }
    return {
        Run = function() -- Line: 395
            -- upvalues: hideCutsceneUi (upval), u3 (val), restoreCutsceneUi (upval), Workspace (upval)
            -- upvalues: ReplicatedStorage (upval), hideAllGuardsAndNests (upval), hideLiveForest (upval)
            -- upvalues: LightingController (upval), u88 (upval), Lighting (upval), EndingCutscene (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), Letterbox (val), a1 (val), u17 (ref)
            -- upvalues: SoundService (upval), TweenService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), LocalPlayer (upval)
            -- upvalues: u19 (val), EndingCutsceneSeconds (upval), BulkFade (upval), EndingHandBackSeconds (upval)
            local Animation, v1
            xpcall(hideCutsceneUi, warn)
            u3:Add(restoreCutsceneUi)
            local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
            if AreaEggSlotsClient ~= nil then
                AreaEggSlotsClient.Parent = ReplicatedStorage
                u3:Add(function() -- Line: 402 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end
            hideAllGuardsAndNests(u3)
            hideLiveForest(u3)
            LightingController.Settle()
            for i, j in u88 do
                local u397 = Lighting:FindFirstChildOfClass(j)
                if u397 ~= nil then
                    u397.Parent = nil
                    u3:Add(function() -- Line: 417 -- upvalues: u397 (val), Lighting (upval)
                        u397.Parent = Lighting
                    end)
                end
            end
            u3:Add(function() -- Line: 421 -- upvalues: LightingController (upval)
                LightingController.Settle()
            end)
            for k, n in EndingCutscene.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(n.Name) then
                    v1 = n:Clone()
                    v1.Parent = Lighting
                    u3:Add(v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            Letterbox.Visible = true
            u3:Add(function() -- Line: 438 -- upvalues: Vignette (upval), Letterbox (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
                Letterbox.Visible = false
            end)
            a1:Add(function() -- Line: 444 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local v2 = EndingCutscene.BeanstalkEndingVFX:Clone()
            v2.Parent = Workspace
            u17 = v2
            u3:Add(v2)
            v2 = EndingCutscene.BeanstalkEndingWorkspaceAssets:Clone()
            v2.Parent = Workspace
            u3:Add(v2)
            local u104 = EndingCutscene.CutsceneMusic:Clone()
            u104.Parent = SoundService
            u3:Add(u104)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            local v3 = EndingCutscene.BeanstalkEndingRigs:Clone()
            u3:Add(v3)
            for m, i5 in v3:GetChildren() do
                if i5:IsA("Model") and i5.PrimaryPart then
                    i5.PrimaryPart.Anchored = true
                end
            end
            v3.Parent = Workspace
            local v4 = {}
            for i6, i7 in v3:GetChildren() do
                table.insert(v4, (i7:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v4)
            local u166 = {}
            for i8, i9 in v3:GetChildren() do
                Animation = i9:FindFirstChild("Animation")
                u166[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
            end
            local u180 = true
            u3:Add(function() -- Line: 487 -- upvalues: u180 (ref), restoreCamera (upval)
                u180 = false
                restoreCamera()
            end)
            for i10, i11 in u166 do
                i11:Play(0)
            end
            local v5 = u166[v3.CamRe]
            v1 = os.clock() + 2
            while u180 do
                if not (v5.TimePosition <= 0) or not (os.clock() < v1) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u104:Play()
            local Cam = v3.CamRe.Cam
            u3:Connect(RunService.RenderStepped, function() -- Line: 509 -- upvalues: u180 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u180 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u235 = {}
            local u236 = 0
            local u237 = 0.1
            v3 = u3:Connect(RunService.Heartbeat, function(a1) -- Line: 522
                -- upvalues: u236 (ref), u237 (ref), u166 (val), u104 (val), u19 (upval), u235 (val)
                local v1
                u236 = u236 + a1
                u237 = u237 - 0.1
                if u237 <= 0 then
                    u237 = 0.1
                    for i, j in u166 do
                        if j.IsPlaying and 0.4 <= (math.abs(u236 - j.TimePosition)) then
                            xpcall(function() -- Line: 534 -- upvalues: j (val), u236 (upval)
                                j.TimePosition = u236
                            end, warn)
                        end
                    end
                end
                if not (u104.TimePosition < u236 - 0.001) then
                    local TimePosition_2 = u104.TimePosition
                    if not (u236 + 0.001 < TimePosition_2) then
                        u104.PlaybackSpeed = 1
                    else
                        u104.PlaybackSpeed = 0.99
                    end
                else
                    u104.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u236 * 60 - k)
                    if u19[v1] and not u235[v1] then
                        u235[v1] = true
                        for n, m in u19[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(EndingCutsceneSeconds)
            v3:Disconnect()
            local u274 = BulkFade.new(CutsceneUI.Mounts, TweenInfo.new(1))
            u274:FadeOutInstant()
            task.wait()
            u274:FadeIn()
            CutsceneUI.Mounts.Visible = true
            task.spawn(function() -- Line: 569 -- upvalues: CutsceneUI (upval)
                local function toDHMS(a1) -- Line: 570 -- types: a1: number
                    return string.format("%02i:%02i:%02i:%02i", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
                end

                local v1 = 604799
                while CutsceneUI.Mounts.Visible do
                    CutsceneUI.Mounts.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v1 / 86400, v1 / 3600 % 24, v1 / 60 % 60, v1 % 60)
                    script.ClockTick:Play()
                    task.wait(1)
                    v1 = v1 - 1
                end
            end)
            task.wait(5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            u274:FadeOut()
            task.delay(1, function() -- Line: 595 -- upvalues: CutsceneUI (upval), u274 (val)
                CutsceneUI.Mounts.Visible = false
                u274:FadeIn()
            end)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Black.BackgroundTransparency = 0
            u3:Clean()
            TweenService:Create(Black, TweenInfo.new(EndingHandBackSeconds), {BackgroundTransparency = 1}):Play()
            task.wait(EndingHandBackSeconds)
            Black.Visible = false
        end,
    }
end