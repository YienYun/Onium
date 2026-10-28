-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Cutscenes.OutroCutscene1
-- Decompile time: 23.70 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.Parent.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Tabs = require(ReplicatedStorage.Client.Tabs)
require(ReplicatedStorage.Packages.Trove)
local OutroCutscene1 = ReplicatedStorage.CutsceneAssets.ScrambleBossCutsceneAssets.OutroCutscene1
local u73 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu,
}
local u79 = {"Sky", "Atmosphere"}
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = {}

local function restoreCamera() -- Line: 50 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- Line: 60
    -- upvalues: u85 (ref), u86 (ref), Tabs (val), LocalPlayer (val), u73 (val), StarterGui (val), u87 (ref)
    if u85 ~= nil then
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
    u85 = v1
    pcall(function() -- Line: 75 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    v1 = {}
    for k, n in u73 do
        v1[n] = (StarterGui:GetCoreGuiEnabled(n))
        StarterGui:SetCoreGuiEnabled(n, false)
    end
    u87 = v1
end

local function restoreAllUi() -- Line: 85
    -- upvalues: u85 (ref), u86 (ref), LocalPlayer (val), u87 (ref), StarterGui (val)
    local v1 = u85
    local v2 = u86
    u85 = nil
    u86 = nil
    if v1 ~= nil then
        for i in v1 do
            if i.Parent ~= nil and i.Name ~= v2 then
                i.Enabled = true
            end
        end
    end
    pcall(function() -- Line: 98 -- upvalues: LocalPlayer (upval)
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    v1 = u87
    u87 = nil
    if v1 ~= nil then
        for j, k in v1 do
            StarterGui:SetCoreGuiEnabled(j, k)
        end
    end
    return v2
end

local function hideCutsceneUi() -- Line: 110 -- upvalues: u84 (ref), HiddenUIHandler (val), hideAllUi (val)
    if u84 == nil then
        HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- Line: 117 -- upvalues: restoreAllUi (val), u84 (ref), Tabs (val)
    local v1 = restoreAllUi()
    local v2 = u84
    u84 = nil
    if v2 ~= nil then
        v2()
    end
    if v1 ~= nil then
        Tabs.Activate(v1, {instant = true})
    end
end

local function setTransparency(a1, a2) -- Line: 129 -- types: a1: table, a2: number?
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

local function restoreGuard(a1, a2) -- Line: 142 -- upvalues: u88 (val) -- types: a1: userdata, a2: userdata
    u88[a1] = nil
    local Guard = a2:FindFirstChild("Guard")
    if Guard ~= nil and Guard ~= a1 then
        return
    end
    a1.Parent = a2
end

local function hideAllGuardsAndNests(a1) -- Line: 151 -- upvalues: u88 (val), setTransparency (val)
    local v1 = game.Workspace.World.Areas.GuardAreas:GetChildren()
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        local Guard = j.Guard
        u88[Guard] = j
        Guard.Parent = nil
        local Nests = j:FindFirstChild("Nests")
        local Descendants = Nests
        if Descendants then
            Descendants = Nests:GetDescendants()
        end
        if Descendants then
            setTransparency(Descendants, 1)
        end
        v4:Add(function() -- Line: 165
            -- upvalues: Guard (val), j (val), u88 (upval), Nests (val), setTransparency (upval), Descendants (val)
            local v1 = Guard
            local v2 = j
            u88[v1] = nil
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

local function restoreAllGuardsAndNests() -- Line: 174 -- upvalues: u88 (val), setTransparency (val)
    local Descendants, Guard, Nests
    local v1 = nil
    local v2 = nil
    for i, j in u88, v1, v2 do
        u88[i] = nil
        Guard = j:FindFirstChild("Guard")
        if Guard == nil or Guard == i then
            i.Parent = j
        end
        Nests = j:FindFirstChild("Nests")
        Descendants = Nests and Nests:GetDescendants()
        if Descendants then
            setTransparency(Descendants)
        end
    end
end

local function setEmitting(a1, a2) -- Line: 186 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emitBurst(a1) -- Line: 194 -- types: a1: userdata
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
                task.delay(Attribute_2, function() -- Line: 207 -- upvalues: j (val)
                    j.Enabled = false
                end)
            end
        end
    end
end

return function(a1) -- Line: 216
    -- upvalues: CutsceneHelperFunctions (val), LocalPlayer (val), setEmitting (val), emitBurst (val)
    -- upvalues: hideCutsceneUi (val), restoreAllUi (val), u84 (ref), Tabs (val), Workspace (val)
    -- upvalues: ReplicatedStorage (val), hideAllGuardsAndNests (val), LightingController (val), u79 (val)
    -- upvalues: Lighting (val), OutroCutscene1 (val), SoundService (val), TweenService (val), ContentProvider (val)
    -- upvalues: restoreCamera (val), RunService (val), CurrentCamera (val), restoreAllGuardsAndNests (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local u13 = nil
    local u14 = {}
    local v2 = {}
    local v3 = SetProperty(
        "Workspace.CurrentCamera.CFrame",
        CFrame.new(-5252.8594, -234.99, 2545.4341, 0.791, 0.1643, -0.5893, -0, 0.9633, 0.2685, 0.6118, -0.2124, 0.762)
    )
    local v4 = SetProperty("Workspace.CurrentCamera.FieldOfView", 25)
    local v5 = SetProperty("Workspace.ScrambleBossOutro1VFX.Flight.CFrame", CFrame.new(2491.416, 264.4008, 1463.5636, 0, 1, 0, 0, 0, -1, -1, 0, 0))
    local v6 = TweenProperty(
        "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
        TweenInfo.new(2.25, Enum.EasingStyle.Linear),
        CFrame.new(2491.416, 262.4489, 1466.665, 0, 1, 0, 0.5558, 0, -0.8313, -0.8313, 0, -0.5558)
    )
    local v7 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.Back.Transparency", 0)
    local v8 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.Body.Transparency", 0)
    local v9 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.Hair.Transparency", 0)
    local v10 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.HeadGrin.Transparency", 1)
    local v11 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.HeadLaugh.Transparency", 0)
    local v12 = SetProperty("Workspace.ScrambleBossOutro1Rigs.DrScramble.HeadSmile.Transparency", 1)
    local v13 = SetProperty("Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.LeftEye.Transparency", 0)
    local v14 = SetProperty("Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.RightEye.Transparency", 0)
    local v15 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)
    local v16 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", Color3.new(0, 0, 0))
    local v17 = TweenInfo.new(13.533333333333333, Enum.EasingStyle.Linear)
    v2[1] = v3
    v2[2] = v4

    v2[3] = function() -- Line: 232 -- upvalues: setEmitting (upval), u13 (ref)
        setEmitting(u13.Dizzy, false)
    end

    v2[4] = v5
    v2[5] = v6
    v2[6] = v7
    v2[7] = v8
    v2[8] = v9
    v2[9] = v10
    v2[10] = v11
    v2[11] = v12
    v2[12] = v13
    v2[13] = v14
    v2[14] = v15
    v2[15] = v16
    v2[16] = (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", v17, Color3.new(0.465771, 1, 0.223529)))
    v3 = SetProperty("Lighting.DepthOfField.Enabled", true)
    v4 = SetProperty("Lighting.DepthOfField.InFocusRadius", 10)
    local v18 = SetProperty("Lighting.DepthOfField.FocusDistance", 0.05)
    v5 = SetProperty("Lighting.DepthOfField.NearIntensity", 0.75)
    v6 = SetProperty(
        "Workspace.ScrambleBossOutro1VFX.Angry.AngryHead.CFrame",
        CFrame.new(2474.0251, 255.93, 1386.3206, -0.8877, 0, -0.4605, 0, 1, 0, 0.4605, 0, -0.8877)
    )
    v7 = SetProperty("Workspace.ScrambleBossOutro1VFX.Angry.AngryHead.Transparency", 0)
    v8 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    v9 = SetProperty("Lighting.CutsceneBlur.Size", 2)
    v10 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    v11 = SetProperty("PlayerGui.CutsceneUI.Vignette.Visible", true)
    v12 = SetProperty("Lighting.Brock.TintColor", Color3.new(1, 1, 1))
    v13 = SetProperty("Lighting.Brock.Enabled", true)
    v14 = SetProperty("Lighting.Brock.Saturation", 0)
    v2[17] = v3
    v2[18] = v4
    v2[19] = v18
    v2[20] = v5
    v2[21] = v6
    v2[22] = v7
    v2[23] = v8
    v2[24] = v9
    v2[25] = v10
    v2[26] = v11
    v2[27] = v12
    v2[28] = v13
    v2[29] = v14
    v2[30] = SetProperty("Lighting.Brock.Contrast", 0)
    u14[0] = v2
    u14[28] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 0)),
    }
    u14[108] = {
        function() -- Line: 269 -- upvalues: emitBurst (upval), u13 (ref)
            emitBurst(u13.BatHit)
        end,
    }
    u14[135] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(2498.4275, 284.1872, 1493.1517, -0, 0.9939, -0.1099, 0.7073, -0.0777, -0.7026, -0.7069, -0.0777, -0.703)
        )),
    }
    u14[136] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), 350)),
    }
    u14[142] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(2506.4163, 314.5122, 1526.4484, -0.0672, 0.9973, -0.0301, 0.2867, -0.0095, -0.958, -0.9557, -0.073, -0.2853)
        )),
    }
    u14[150] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(2513.6011, 347.2467, 1557.4293, -0.0884, 0.9943, 0.059, -0.1444, 0.0458, -0.9885, -0.9856, -0.0959, 0.1395)
        )),
    }
    u14[154] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear), 1)),
    }
    u14[157] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(2516.4177, 403.7317, 1583.1393, -0.1004, 0.9943, 0.035, 0.1082, 0.0458, -0.9931, -0.9891, -0.0959, -0.1121)
        )),
    }
    u14[162] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear),
            CFrame.new(2520.0452, 465.6886, 1612.6007, -0.1004, 0.9946, -0.0273, 0.1082, -0.0163, -0.994, -0.9891, -0.1027, -0.1059)
        )),
    }
    u14[167] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(2521.8628, 512.4241, 1635.2535, -0.1004, 0.9946, -0.0273, 0.1082, -0.0163, -0.994, -0.9891, -0.1027, -0.1059)
        )),
    }
    u14[171] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(2526.8145, 595.5174, 1673.1318, -0.1004, 0.9898, -0.1012, 0.1082, -0.0903, -0.99, -0.9891, -0.1103, -0.098)
        )),
    }
    u14[178] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.55, Enum.EasingStyle.Linear),
            CFrame.new(2546.7251, 980.5066, 1857.8026, -0.0898, 0.9898, -0.1107, 0.2065, -0.0903, -0.9743, -0.9743, -0.1103, -0.1963)
        )),
    }
    u14[198] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(1.7166666666666666, Enum.EasingStyle.Linear), 300)),
    }
    u14[211] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            CFrame.new(2556.2241, 1220.0552, 1979.5344, -0.0898, 0.9898, -0.1107, 0.2065, -0.0903, -0.9743, -0.9743, -0.1103, -0.1963)
        )),
    }
    u14[229] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Flight.CFrame",
            TweenInfo.new(1.2666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(2586.7708, 1301.2866, 2038.6105, -0.0898, 0.9898, -0.1107, 0.2065, -0.0903, -0.9743, -0.9743, -0.1103, -0.1963)
        )),
    }
    u14[230] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 15)),
    }
    u14[236] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 3)),
    }
    u14[243] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 2.98704)),
    }
    u14[269] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 15)),
    }
    u14[281] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 2)),
    }
    u14[301] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.75, Enum.EasingStyle.Linear), 206.78572)),
    }
    u14[308] = {
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.DrScramble.Back.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        ),
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.DrScramble.Body.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        ),
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.DrScramble.Hair.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        ),
        (TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.DrScramble.HeadLaugh.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        )),
    }
    u14[309] = {
        function() -- Line: 358 -- upvalues: emitBurst (upval), u13 (ref)
            emitBurst(u13.Star)
        end,
    }
    u14[346] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 10)),
    }
    u14[441] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 45)),
    }
    u14[453] = {
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u14[461] = {
        (TweenProperty("Lighting.DepthOfField.FocusDistance", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 15)),
    }
    u14[484] = {
        (TweenProperty("Lighting.DepthOfField.NearIntensity", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 1)),
    }
    u14[528] = {
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 5),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u14[529] = {
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(11.383333333333333, Enum.EasingStyle.Linear), 10),
        TweenProperty(
            "Lighting.Brock.TintColor",
            TweenInfo.new(1.9166666666666667, Enum.EasingStyle.Linear),
            Color3.new(0.658419, 1, 0.537255)
        ),
        TweenProperty("Lighting.Brock.Saturation", TweenInfo.new(1.9166666666666667, Enum.EasingStyle.Linear), 3),
        (TweenProperty("Lighting.Brock.Contrast", TweenInfo.new(1.9166666666666667, Enum.EasingStyle.Linear), 2)),
    }
    u14[615] = {
        (TweenProperty(
            "Workspace.ScrambleBossOutro1VFX.Angry.AngryHead.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            1
        )),
    }
    u14[670] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    u14[671] = {SetProperty("Lighting.Brock.Enabled", false)}
    u14[805] = {
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.LeftEye.Transparency",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            1
        ),
        (TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.RightEye.Transparency",
            TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear),
            1
        )),
    }
    u14[811] = {
        TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundTransparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            0.8
        ),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    u14[812] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(24.883333333333333, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    u14[849] = {
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.LeftEye.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            0
        ),
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.RightEye.Transparency",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            0
        ),
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1),
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    u14[860] = {
        function() -- Line: 429 -- upvalues: emitBurst (upval), u13 (ref), setEmitting (upval)
            emitBurst(u13.BatHit2)
            setEmitting(u13.Dizzy, true)
        end,
    }
    u14[895] = {
        TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.LeftEye.Transparency",
            TweenInfo.new(0.05, Enum.EasingStyle.Linear),
            1
        ),
        (TweenProperty(
            "Workspace.ScrambleBossOutro1Rigs.BrockkodileHeadRig.BrockHeads.Angry.RightEye.Transparency",
            TweenInfo.new(0.05, Enum.EasingStyle.Linear),
            1
        )),
    }
    u14[1212] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 45)),
    }
    u14[1393] = {
        function() -- Line: 445 -- upvalues: setEmitting (upval), u13 (ref)
            setEmitting(u13.Dizzy, false)
        end,
    }
    u14[1658] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 15)),
    }
    u14[1869] = {
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 35)),
    }
    u14[2242] = {
        function() -- Line: 459 -- upvalues: emitBurst (upval), u13 (ref)
            emitBurst(u13.Portal)
        end,
    }
    u14[2303] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 15)),
    }
    u14[2305] = {
        TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0),
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            Color3.new(0.515866, 1, 0.372549)
        )),
    }
    u14[2320] = {
        (TweenProperty(
            "PlayerGui.CutsceneUI.Black.BackgroundColor3",
            TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear),
            Color3.new(0, 0, 0)
        )),
    }
    return {
        Run = function() -- Line: 479
            -- upvalues: hideCutsceneUi (upval), a1 (val), restoreAllUi (upval), u84 (upval), Tabs (upval)
            -- upvalues: Workspace (upval), ReplicatedStorage (upval), hideAllGuardsAndNests (upval)
            -- upvalues: LightingController (upval), u79 (upval), Lighting (upval), OutroCutscene1 (upval)
            -- upvalues: CutsceneUI (val), Black (val), Vignette (val), u13 (ref), SoundService (upval)
            -- upvalues: TweenService (upval), ContentProvider (upval), LoadAnimationIntoRig (val)
            -- upvalues: restoreCamera (upval), RunService (upval), CurrentCamera (upval), LocalPlayer (upval)
            -- upvalues: u14 (val), restoreAllGuardsAndNests (upval)
            local Animation, Animation_2, v1
            local u0 = false
            xpcall(hideCutsceneUi, warn)
            a1:Add(function() -- Line: 484 -- upvalues: u0 (ref), restoreAllUi (upval), u84 (upval), Tabs (upval)
                if not u0 then
                    local v1 = restoreAllUi()
                    local v2 = u84
                    u84 = nil
                    if v2 ~= nil then
                        v2()
                    end
                    if v1 ~= nil then
                        Tabs.Activate(v1, {instant = true})
                    end
                    u0 = true
                end
            end)
            local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
            pcall(function() -- Line: 492 -- upvalues: AreaEggSlotsClient (val), ReplicatedStorage (upval), a1 (upval), Workspace (upval)
                AreaEggSlotsClient.Parent = ReplicatedStorage
                a1:Add(function() -- Line: 494 -- upvalues: AreaEggSlotsClient (upval), Workspace (upval)
                    AreaEggSlotsClient.Parent = Workspace
                end)
            end)
            hideAllGuardsAndNests(a1)
            LightingController.Settle()
            local u24 = {}
            local u25 = false
            for i, j in u79 do
                local u420 = Lighting:FindFirstChildOfClass(j)
                if u420 ~= nil then
                    u420.Parent = nil
                    table.insert(u24, u420)
                    a1:Add(function() -- Line: 513 -- upvalues: u420 (val), Lighting (upval)
                        u420.Parent = Lighting
                    end)
                end
            end
            a1:Add(function() -- Line: 517 -- upvalues: u25 (ref), LightingController (upval)
                if not u25 then
                    u25 = true
                    LightingController.Settle()
                end
            end)
            local u42 = {}
            for k, n in OutroCutscene1.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(n.Name) then
                    v1 = n:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u42, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            Vignette.Visible = false
            a1:Add(function() -- Line: 541 -- upvalues: Vignette (upval)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            local u74 = OutroCutscene1.ScrambleBossOutro1VFX:Clone()
            u74.Parent = Workspace
            u13 = u74
            a1:Add(u74)
            local u85 = OutroCutscene1.ScrambleBossOutro1WorkspaceAssets:Clone()
            u85.Parent = Workspace
            a1:Add(u85)
            local u96 = OutroCutscene1.CutsceneMusic:Clone()
            u96.Parent = SoundService
            a1:Add(u96)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 560 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.BackgroundColor3 = Color3.new(0, 0, 0)
                Black.Visible = false
            end)
            local u124 = OutroCutscene1.ScrambleBossOutro1Rigs:Clone()
            for m, i5 in u124:GetChildren() do
                if i5:IsA("Model") and i5.PrimaryPart then
                    i5.PrimaryPart.Anchored = true
                end
            end
            u124.Parent = Workspace
            a1:Add(u124)
            local v2 = {}
            for i6, i7 in u124:GetChildren() do
                Animation_2 = i7:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v2, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v2)
            local u163 = {}
            for i8, i9 in u124:GetChildren() do
                Animation = i9:FindFirstChildOfClass("Animation")
                if Animation then
                    u163[i9] = (LoadAnimationIntoRig(i9, Animation.AnimationId))
                end
            end
            local u177 = true
            a1:Add(function() -- Line: 596 -- upvalues: u177 (ref)
                u177 = false
            end)
            a1:Add(function() -- Line: 597 -- upvalues: u177 (ref), restoreCamera (upval)
                if not u177 then
                    return
                end
                restoreCamera()
            end)
            for i10, i11 in u163 do
                i11:Play(0)
            end
            local v3 = u163[u124.HumanoidCameraRig]
            assert(v3, "HumanoidCameraRig needs an Animation")
            local v4 = os.clock() + 2
            while u177 do
                if not (v3.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            u96:Play()
            local Torso = u124.HumanoidCameraRig.Torso
            local u233 = nil
            RunService.RenderStepped:Connect(function() -- Line: 623 -- upvalues: u177 (ref), u233 (ref), CurrentCamera (upval), LocalPlayer (upval), Torso (val)
                if not u177 then
                    u233:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Torso
                CurrentCamera.Focus = Torso.CFrame
                CurrentCamera.CFrame = Torso.CFrame
            end)
            local u242 = {}
            local u243 = 0
            local u244 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 637 -- upvalues: u243 (ref), u244 (ref), u163 (val), u96 (val), u14 (upval), u242 (val)
                local v1
                u243 = u243 + a1
                u244 = u244 - 0.1
                if u244 <= 0 then
                    u244 = 0.1
                    for i, j in u163 do
                        if j.IsPlaying and 0.4 <= (math.abs(u243 - j.TimePosition)) then
                            xpcall(function() -- Line: 649 -- upvalues: j (val), u243 (upval)
                                j.TimePosition = u243
                            end, warn)
                        end
                    end
                end
                if not (u96.TimePosition < u243 - 0.001) then
                    local TimePosition_2 = u96.TimePosition
                    if not (u243 + 0.001 < TimePosition_2) then
                        u96.PlaybackSpeed = 1
                    else
                        u96.PlaybackSpeed = 0.99
                    end
                else
                    u96.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u243 * 60 - k)
                    if u14[v1] and not u242[v1] then
                        u242[v1] = true
                        for n, m in u14[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            TweenService:Create(Black, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            task.wait(39.85)
            v5:Disconnect()
            xpcall(function() -- Line: 681 -- upvalues: u74 (val)
                u74:Destroy()
            end, warn)
            xpcall(function() -- Line: 682 -- upvalues: u85 (val)
                u85:Destroy()
            end, warn)
            xpcall(function() -- Line: 683 -- upvalues: u96 (val)
                u96:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 689 -- upvalues: u42 (val), u24 (val), Lighting (upval), u25 (ref), LightingController (upval)
                for i, j in u42 do
                    j:Destroy()
                end
                for k, n in u24 do
                    n.Parent = Lighting
                end
                u25 = true
                LightingController.Settle()
            end, warn)
            xpcall(function() -- Line: 700 -- upvalues: u124 (val)
                u124:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            task.wait(0.5)
            Vignette.Visible = false
            pcall(function() -- Line: 709 -- upvalues: AreaEggSlotsClient (val), Workspace (upval)
                AreaEggSlotsClient.Parent = Workspace
            end)
            xpcall(function() -- Line: 713 -- upvalues: restoreAllUi (upval), u84 (upval), Tabs (upval), u0 (ref)
                local v1 = restoreAllUi()
                local v2 = u84
                u84 = nil
                if v2 ~= nil then
                    v2()
                end
                if v1 ~= nil then
                    Tabs.Activate(v1, {instant = true})
                end
                u0 = true
            end, warn)
            restoreAllGuardsAndNests()
        end,
    }
end