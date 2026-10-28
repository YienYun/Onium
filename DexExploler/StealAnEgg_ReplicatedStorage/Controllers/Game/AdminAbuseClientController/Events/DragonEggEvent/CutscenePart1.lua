-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.DragonEggEvent.CutscenePart1
-- Decompile time: 43.14 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function restoreCamera() -- Line: 24 -- upvalues: TweenService (val), CurrentCamera (val), LocalPlayer (val)
    TweenService:Create(CurrentCamera, TweenInfo.new(0), {FieldOfView = 70}):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    LocalPlayer.ReplicationFocus = nil
end

local function cloneCharacterRig(a1) -- Line: 35 -- upvalues: LocalPlayer (val) -- types: a1: userdata
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character ~= nil and Humanoid ~= nil and Character.PrimaryPart ~= nil then
        local v1
        local Archivable = Character.Archivable
        Character.Archivable = true
        local v2 = Character:Clone()
        Character.Archivable = Archivable
        v2.Name = a1.Name
        local v3 = a1
        for i, v in ipairs(v2:GetChildren()) do
            if v:IsA("LocalScript") or v:IsA("Script") or v:IsA("Tool") then
                v:Destroy()
            end
        end
        local v4 = v2:FindFirstChildOfClass("Humanoid")
        assert(v4, "Cloned character lost its Humanoid")
        v4.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        if v4:FindFirstChildOfClass("Animator") == nil then
            Instance.new("Animator").Parent = v4
        end
        for i2, i3 in ipairs(v2:GetDescendants()) do
            if i3:IsA("BasePart") then
                v1 = i3 == v2.PrimaryPart
                i3.Anchored = v1
                i3.CanCollide = false
                i3.CanQuery = false
                i3.CanTouch = false
                i3.LocalTransparencyModifier = 0
            end
        end
        v4 = v3:FindFirstChildOfClass("Animation")
        assert(v4, (("%* needs an Animation child"):format(v3.Name)))
        v4:Clone().Parent = v2
        v2:PivotTo((v3:GetPivot()))
        return v2
    end
    return nil
end

local function hideCharacter(a1) -- Line: 74 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    if Character == nil then
        return function() end
    end
    local u4 = {}
    for i, v in ipairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            u4[v] = v.LocalTransparencyModifier
            v.LocalTransparencyModifier = 1
        elseif v:IsA("Decal") then
            u4[v] = v.Transparency
            v.Transparency = 1
        end
    end

    local function restore() -- Line: 89 -- upvalues: u4 (val)
        for i, j in u4 do
            if i.Parent then
                if i:IsA("BasePart") then
                    i.LocalTransparencyModifier = j
                elseif i:IsA("Decal") then
                    i.Transparency = j
                end
            end
        end
    end

    a1:Add(restore)
    return restore
end

return function(a1) -- Line: 106
    -- upvalues: CutsceneHelperFunctions (val), ReplicatedStorage (val), LocalPlayer (val), TweenService (val)
    -- upvalues: Workspace (val), Lighting (val), hideCharacter (val), ContentProvider (val), restoreCamera (val)
    -- upvalues: RunService (val), CurrentCamera (val)
    local v1 = CutsceneHelperFunctions.GetHelperFunctions(a1)
    local SetProperty = v1.SetProperty
    local TweenProperty = v1.TweenProperty
    local PlaySequenceAsync = v1.PlaySequenceAsync
    local LoadAnimationIntoRig = v1.LoadAnimationIntoRig
    local DragonEggEventCutscene1 = ReplicatedStorage.CutsceneAssets.DragonEggEvent.DragonEggEventCutscene1
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local u19 = nil
    local u20 = {}
    u20[0] = {
        SetProperty("Workspace.CurrentCamera.FieldOfView", 35),
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.2666666666666666, Enum.EasingStyle.Linear), 80.84581),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled2_Walls102.CFrame",
            CFrame.new(3526.5938, 86.4341, -373.0499, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled2_Walls102.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3514.3865, 86.4341, -383.3008, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls100 (2).CFrame",
            CFrame.new(3527.27, 90.0758, -374.963, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls100 (2).CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3516.3984, 90.0758, -383.037, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls103.CFrame",
            CFrame.new(3526.6228, 84.8732, -373.5785, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls103.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3514.9097, 84.8732, -383.3822, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls104.CFrame",
            CFrame.new(3526.4937, 86.4515, -369.8316, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls104.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3511.2178, 86.4515, -382.7296, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls105.CFrame",
            CFrame.new(3526.3276, 86.4762, -364.6917, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls105.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3506.1558, 86.4762, -381.8233, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls106.CFrame",
            CFrame.new(3526.365, 88.1662, -374.3624, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls106.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3515.6228, 88.1662, -383.7974, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls107.CFrame",
            CFrame.new(3526.3193, 89.4656, -369.1417, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls107.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3510.5066, 89.4656, -382.7566, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right1.CFrame",
            CFrame.new(3526.5938, 86.4341, -355.3767, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right1.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3514.4778, 86.4341, -345.5578, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right2.CFrame",
            CFrame.new(3527.27, 90.0758, -353.463, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right2.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3516.4983, 90.0758, -345.751, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right3.CFrame",
            CFrame.new(3526.6228, 84.8732, -354.8475, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right3.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3514.9985, 84.8732, -345.458, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right4.CFrame",
            CFrame.new(3526.4937, 86.4515, -358.5941, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right4.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3511.3318, 86.4515, -346.2393, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right5.CFrame",
            CFrame.new(3526.3276, 86.4762, -363.7342, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right5.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3506.3042, 86.4762, -347.3215, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right6.CFrame",
            CFrame.new(3526.365, 88.1662, -354.0636, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right6.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3515.6965, 88.1662, -345.0182, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        SetProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right7.CFrame",
            CFrame.new(3526.3193, 89.4657, -359.2843, -0, 0, 1, 0, 1, 0, -1, 0, -0)
        ),
        TweenProperty(
            "Workspace.World.Build.AAEventProps.DragonCave.Door.RightDoor.right7.CFrame",
            TweenInfo.new(5.35, Enum.EasingStyle.Linear),
            CFrame.new(3510.6201, 89.4657, -346.237, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703)
        ),
        function() -- Line: 256 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 259 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.DoorOpenSmoke:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 274 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
        SetProperty("Lighting.dragondepth.Enabled", false),
        SetProperty("Lighting.dragondepth.InFocusRadius", 20),
        SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", false),
        SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency", 0.5),
        TweenProperty(
            "Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency",
            TweenInfo.new(7.583333333333333, Enum.EasingStyle.Linear),
            1
        ),
        SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", 0),
        TweenProperty(
            "Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency",
            TweenInfo.new(7.583333333333333, Enum.EasingStyle.Linear),
            1
        ),
        SetProperty("Lighting.ThirdPoV.Enabled", false),
        SetProperty("Lighting.ThirdPoV.InFocusRadius", 50),
        SetProperty("Lighting.ThirdPoV.FocusDistance", 200),
        SetProperty("Lighting.1.Enabled", true),
        SetProperty("Lighting.1.InFocusRadius", 50),
        SetProperty("Lighting.1.FocusDistance", 25),
        SetProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            CFrame.new(3632.9419, 20.3041, -371.646, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736)
        ),
        SetProperty("Workspace.CutsceneVFX.Charge.CFrame", CFrame.new(3407.4592, 101.738, -375.0436, 1, 0, 0, 0, 1, 0, 0, 0, 1)),
        SetProperty("Workspace.CutsceneVFX.Wave.CFrame", CFrame.new(3395.644, -3.5316, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1)),
        SetProperty("Lighting.CutsceneBlur.Enabled", true),
        SetProperty("Lighting.CutsceneBlur.Size", 2),
        SetProperty("Lighting.BLACK.Enabled", false),
        SetProperty("Lighting.WHITE.Enabled", false),
        SetProperty("Lighting.Black+White.Enabled", false),
        SetProperty("Lighting.White+Black.Enabled", false),
        SetProperty("Lighting.red.Enabled", false),
        SetProperty("Lighting.Whitered.Enabled", false),
        SetProperty("Lighting.Whitered.Saturation", -1.1),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(49.38333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Whitered.Contrast", -1000000),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(49.38333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Whitered.TintColor", Color3.new(1, 1, 1)),
        (SetProperty("Lighting.Whitered.Brightness", 0)),
    }
    u20[76] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.64736)),
    }
    u20[82] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.46038)),
    }
    u20[88] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.22632)),
    }
    u20[94] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 79.80621)),
    }
    u20[100] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 78.99367)),
    }
    u20[106] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 77.62277)),
    }
    u20[112] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 75.68993)),
    }
    u20[118] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 73.3545)),
    }
    u20[124] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 70.81742)),
    }
    u20[130] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 68.21306)),
    }
    u20[136] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 65.59524)),
    }
    u20[142] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.2, Enum.EasingStyle.Linear), 34.16667)),
    }
    u20[214] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 31.56664)),
    }
    u20[220] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 29.09974)),
    }
    u20[226] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 27.03225)),
    }
    u20[232] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 25.63041)),
    }
    u20[238] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 25.26233)),
    }
    u20[241] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.72586)),
    }
    u20[247] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.47468)),
    }
    u20[253] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 24.3586)),
    }
    u20[256] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 24.26451)),
    }
    u20[259] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.07752)),
    }
    u20[265] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.94988)),
    }
    u20[271] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.84164)),
    }
    u20[277] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.7417)),
    }
    u20[283] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 23.61215)),
    }
    u20[291] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.50904)),
    }
    u20[297] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 23.45451)),
    }
    u20[300] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 23.39405)),
    }
    u20[303] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.16991)),
    }
    u20[309] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 22.78801)),
    }
    u20[315] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 22.7113)),
    }
    u20[316] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 22.47363)),
    }
    u20[319] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 21.96249)),
    }
    u20[325] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 21.60656)),
    }
    u20[329] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 20)),
    }
    u20[365] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            15.9003
        )),
    }
    u20[450] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 13.47454)),
    }
    u20[455] = {
        SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", true),
        TweenProperty(
            "Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            0.4
        ),
        (TweenProperty(
            "Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            0
        )),
    }
    u20[456] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 12.3416)),
    }
    u20[459] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 11.20867)),
    }
    u20[462] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 10.54439)),
    }
    local v2 = {}
    local v3 = TweenProperty(
        "Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency",
        TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear),
        1
    )
    local v4 = TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear)

    v2[1] = function() -- Line: 681 -- upvalues: u19 (ref)
        local Attribute, Attribute_2, v1

        local function check(a1) -- Line: 684 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for i, j in u19.Shimmer:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                Attribute = j:GetAttribute("EmitCount")
                Attribute_2 = j:GetAttribute("EmitDuration")
                v1 = false
                if Attribute ~= nil then
                    v1 = Attribute ~= 0
                end
                if v1 then
                    j:Emit(Attribute)
                end
                v1 = false
                if Attribute_2 ~= nil then
                    v1 = Attribute_2 ~= 0
                end
                if v1 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 699 -- upvalues: j (val)
                        j.Enabled = false
                    end)
                end
            end
        end
    end

    v2[2] = v3
    v2[3] = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", v4, 1)
    u20[464] = v2
    u20[465] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.65424)),
    }
    u20[471] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.47588)),
    }
    u20[474] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.19042)),
    }
    u20[477] = {SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", false)}
    u20[480] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9)),
    }
    u20[486] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), 8)),
    }
    u20[522] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            40
        )),
    }
    u20[523] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(2.216666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            45
        )),
    }
    u20[670] = {
        function() -- Line: 776 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("ZZZ")):GetChildren()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u20[721] = {SetProperty("Lighting.ThirdPoV.Enabled", true)}
    u20[780] = {
        (TweenProperty("Lighting.ThirdPoV.FocusDistance", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 0)),
    }
    u20[858] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            25
        )),
    }
    u20[859] = {SetProperty("Lighting.ThirdPoV.Enabled", false)}
    u20[1264] = {
        SetProperty("Lighting.dragondepth.Enabled", true),
        (SetProperty("Lighting.1.Enabled", false)),
    }
    u20[1376] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(2.033333333333333, Enum.EasingStyle.Linear), 13)),
    }
    u20[1571] = {
        function() -- Line: 825 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 828 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.Mud:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 843 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[1573] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), 0.5)),
    }
    u20[1576] = {
        function() -- Line: 858 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("ZZZ")):GetChildren()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u20[1590] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(0.7166666666666667, Enum.EasingStyle.Linear), 50)),
    }
    u20[1686] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(3.533333333333333, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            40
        )),
    }
    u20[1807] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.5333333333333334, Enum.EasingStyle.Linear), 0)),
    }
    u20[1898] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            15
        )),
    }
    u20[1899] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(4.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 25)),
    }
    u20[1929] = {
        function() -- Line: 910 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 913 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.Takeoff:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 928 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2120] = {
        function() -- Line: 935 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Fly")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = true
                end
            end
        end,
    }
    u20[2130] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(3632.9526, 76.9216, -371.6479, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736)
        )),
    }
    u20[2131] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear),
            CFrame.new(3610.0322, 76.9216, -367.6064, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736)
        )),
    }
    u20[2135] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            TweenInfo.new(0.05, Enum.EasingStyle.Linear),
            CFrame.new(3582.1382, 76.9216, -364.7979, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736)
        ),
        SetProperty("Lighting.White+Black.Enabled", true),
    }
    u20[2137] = {
        SetProperty("Lighting.Black+White.Enabled", true),
        (SetProperty("Lighting.White+Black.Enabled", false)),
    }
    u20[2138] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            TweenInfo.new(0.05, Enum.EasingStyle.Linear),
            CFrame.new(3554.259, 76.9216, -363.7752, -0.0367, 0, 0.9993, 0, 1, 0, -0.9993, 0, -0.0367)
        )),
    }
    u20[2139] = {
        SetProperty("Lighting.Black+White.Enabled", false),
        (SetProperty("Lighting.red.Enabled", true)),
    }
    u20[2141] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Fly.CFrame",
            TweenInfo.new(0.15, Enum.EasingStyle.Linear),
            CFrame.new(3535.5564, 76.9216, -363.0892, -0.0367, 0, 0.9993, 0, 1, 0, -0.9993, 0, -0.0367)
        ),
        SetProperty("Lighting.red.Enabled", false),
    }
    u20[2142] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(2.466666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            22
        ),
        function() -- Line: 1005 -- upvalues: u19 (ref)
            for i, v in ipairs((u19:WaitForChild("Fly")):GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
        end,
    }
    u20[2181] = {
        function() -- Line: 1017 -- upvalues: u19 (ref)
            local Attribute, Attribute_2, v1

            local function check(a1) -- Line: 1020 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for i, j in u19.EggDrop:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    Attribute = j:GetAttribute("EmitCount")
                    Attribute_2 = j:GetAttribute("EmitDuration")
                    v1 = false
                    if Attribute ~= nil then
                        v1 = Attribute ~= 0
                    end
                    if v1 then
                        j:Emit(Attribute)
                    end
                    v1 = false
                    if Attribute_2 ~= nil then
                        v1 = Attribute_2 ~= 0
                    end
                    if v1 then
                        j.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 1035 -- upvalues: j (val)
                            j.Enabled = false
                        end)
                    end
                end
            end
        end,
    }
    u20[2290] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(9.933333333333334, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            28
        )),
    }
    u20[2344] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.75, Enum.EasingStyle.Linear), 0.4)),
    }
    u20[2357] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1, Enum.EasingStyle.Linear), 250)),
    }
    u20[2389] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(5.933333333333334, Enum.EasingStyle.Linear), 0.4)),
    }
    u20[2417] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 20)),
    }
    u20[2568] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), 300)),
    }
    u20[2635] = {SetProperty("Lighting.White+Black.Enabled", true)}
    v2 = {}
    v3 = SetProperty("Lighting.Black+White.Enabled", true)

    v2[1] = function() -- Line: 1094 -- upvalues: u19 (ref)
        for i, v in ipairs((u19:WaitForChild("Charge")):GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true
            end
        end
    end

    v2[2] = v3
    v2[3] = SetProperty("Lighting.White+Black.Enabled", false)
    u20[2637] = v2
    u20[2639] = {
        SetProperty("Lighting.Black+White.Enabled", false),
        (SetProperty("Lighting.White+Black.Enabled", true)),
    }
    u20[2641] = {
        SetProperty("Lighting.White+Black.Enabled", false),
        (SetProperty("Lighting.red.Enabled", true)),
    }
    u20[2643] = {SetProperty("Lighting.red.Enabled", false)}
    u20[2647] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Charge.CFrame",
            TweenInfo.new(1.9666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(3403.1526, 101.738, -375.0436, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u20[2745] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.4333333333333333, Enum.EasingStyle.Linear), 1)),
    }
    u20[2766] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(3395.645, 87.3247, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u20[2767] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(1.9833333333333334, Enum.EasingStyle.Linear),
            CFrame.new(3305.9136, 87.3247, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    v2 = {}
    v3 = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)
    local v5 = TweenProperty(
        "Workspace.CutsceneVFX.Wave.CFrame",
        TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
        CFrame.new(3459.4167, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    )
    local v6 = TweenInfo.new(5.983333333333333, Enum.EasingStyle.Back, Enum.EasingDirection.In)

    v2[1] = function() -- Line: 1154 -- upvalues: u19 (ref)
        for i, v in ipairs((u19:WaitForChild("Charge")):GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false
            end
        end
    end

    v2[2] = v3
    v2[3] = v5
    v2[4] = TweenProperty("Workspace.CurrentCamera.FieldOfView", v6, 15)
    u20[2886] = v2
    u20[2887] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(1.5, Enum.EasingStyle.Linear),
            CFrame.new(3375.6699, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u20[2948] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            10
        )),
    }
    u20[2963] = {
        SetProperty("Lighting.Whitered.Enabled", true),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25),
        TweenProperty(
            "Lighting.Whitered.TintColor",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            Color3.new(1, 0.173412, 0.0980392)
        ),
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 2)),
    }
    u20[2969] = {
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u20[2977] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(2920.835, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            2
        ),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(1.8, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 0)),
    }
    u20[2978] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(2920.835, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        SetProperty("Lighting.Whitered.Enabled", false),
    }
    u20[2979] = {
        (TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            CFrame.new(2570.1248, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        )),
    }
    u20[3071] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            10
        )),
    }
    u20[3085] = {
        SetProperty("Lighting.Whitered.Enabled", true),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25),
        TweenProperty(
            "Lighting.Whitered.TintColor",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            Color3.new(1, 0.173412, 0.0980392)
        ),
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 2)),
    }
    u20[3091] = {
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    u20[3099] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear),
            CFrame.new(2512.0125, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            2
        ),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), 0)),
    }
    u20[3100] = {
        TweenProperty(
            "Workspace.CutsceneVFX.Wave.CFrame",
            TweenInfo.new(2.4, Enum.EasingStyle.Linear),
            CFrame.new(2172.207, 87.3247, -364.1021, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        ),
        SetProperty("Lighting.Whitered.Enabled", false),
    }
    u20[3106] = {
        (TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1.9333333333333333, Enum.EasingStyle.Linear), 13)),
    }
    u20[3200] = {
        function() -- Line: 1369 -- upvalues: Black (val), TweenService (upval)
            Black.Visible = true
            Black.BackgroundTransparency = 1
            TweenService:Create(Black, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 0}):Play()
            task.delay(2, function() -- Line: 1377 -- upvalues: TweenService (upval), Black (upval)
                TweenService:Create(Black, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1}):Play()
                task.wait(0.5)
                Black.Visible = false
            end)
        end,
    }
    u20[3229] = {
        SetProperty("Lighting.Whitered.Enabled", true),
        TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1),
        TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25),
        TweenProperty(
            "Lighting.Whitered.TintColor",
            TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
            Color3.new(1, 0.173412, 0.0980392)
        ),
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 2)),
    }
    u20[3234] = {
        (TweenProperty(
            "Lighting.CutsceneBlur.Size",
            TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            30
        )),
    }
    u20[3235] = {
        (TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)),
    }
    return {
        Run = function() -- Line: 1431
            -- upvalues: Workspace (upval), Lighting (upval), a1 (val), CutsceneUI (val), Black (val), u19 (ref)
            -- upvalues: TweenService (upval), DragonEggEventCutscene1 (val), hideCharacter (upval)
            -- upvalues: ContentProvider (upval), LoadAnimationIntoRig (val), restoreCamera (upval), RunService (upval)
            -- upvalues: CutsceneMusic (val), CurrentCamera (upval), LocalPlayer (upval), u20 (val)
            local Animation, Animation_2, v1
            Workspace.World.Build:WaitForChild("AAEventProps")
            local u7 = {}
            for i, j in script.LightingAssets:GetChildren() do
                v1 = Lighting
                if not v1:FindFirstChild(j.Name) then
                    v1 = j:Clone()
                    v1.Parent = Lighting
                    a1:Add(v1)
                    table.insert(u7, v1)
                end
            end
            CutsceneUI.Enabled = true
            Black.BackgroundTransparency = 1
            Black.Visible = true
            local u32 = script.CutsceneVFX:Clone()
            u32.Parent = Workspace
            u19 = u32
            a1:Add(u32)
            TweenService:Create(Black, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            a1:Add(function() -- Line: 1456 -- upvalues: Black (upval)
                Black.BackgroundTransparency = 1
                Black.Visible = false
            end)
            local u59 = DragonEggEventCutscene1:Clone()
            for k, n in u59:GetChildren() do
                if n:IsA("Model") and n.PrimaryPart then
                    n.PrimaryPart.Anchored = true
                end
            end
            local v2 = hideCharacter(a1)
            u59.Parent = workspace
            a1:Add(u59)
            local v3 = {}
            for m, i5 in u59:GetChildren() do
                Animation_2 = i5:FindFirstChildOfClass("Animation")
                if Animation_2 then
                    table.insert(v3, Animation_2)
                end
            end
            ContentProvider:PreloadAsync(v3)
            local u101 = {}
            for i6, i7 in u59:GetChildren() do
                Animation = i7:FindFirstChildOfClass("Animation")
                if Animation then
                    u101[i7] = (LoadAnimationIntoRig(i7, Animation.AnimationId))
                end
            end
            local u115 = true
            a1:Add(function() -- Line: 1496 -- upvalues: u115 (ref)
                u115 = false
            end)
            a1:Add(function() -- Line: 1497 -- upvalues: u115 (ref), restoreCamera (upval)
                if not u115 then
                    return
                end
                restoreCamera()
            end)
            for i8, i9 in u101 do
                i9:Play(0)
            end
            v1 = u101[u59["Camera Rig"]]
            assert(v1, "Camera Rig needs an Animation")
            local v4 = os.clock() + 2
            while u115 do
                if not (v1.TimePosition <= 0) or not (os.clock() < v4) then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            local Vignette = CutsceneUI.Vignette
            Vignette.Visible = true
            Vignette.ImageTransparency = 0.1
            TweenService:Create(Vignette, TweenInfo.new(10, Enum.EasingStyle.Linear), {ImageTransparency = 1}):Play()
            task.delay(10, function() end)
            a1:Add(function() -- Line: 1527 -- upvalues: Vignette (val)
                Vignette.Visible = false
                Vignette.ImageTransparency = 1
            end)
            TweenService:Create(Black, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.delay(0.3, function() -- Line: 1533 -- upvalues: Black (upval)
                Black.Visible = false
            end)
            CutsceneMusic:Play()
            local Cam = u59["Camera Rig"].Cam
            local u211 = nil
            RunService.RenderStepped:Connect(function() -- Line: 1542 -- upvalues: u115 (ref), u211 (ref), CurrentCamera (upval), LocalPlayer (upval), Cam (val)
                if not u115 then
                    u211:Disconnect()
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                LocalPlayer.ReplicationFocus = Cam
                CurrentCamera.Focus = Cam.CFrame
                CurrentCamera.CFrame = Cam.CFrame
            end)
            local u220 = {}
            local u221 = 0
            local u222 = 0.1
            local v5 = RunService.Heartbeat:Connect(function(a1) -- Line: 1556
                -- upvalues: u221 (ref), u222 (ref), u101 (val), CutsceneMusic (upval), u20 (upval), u220 (val)
                local v1
                u221 = u221 + a1
                u222 = u222 - 0.1
                if u222 <= 0 then
                    u222 = 0.1
                    for i, j in u101 do
                        if j.IsPlaying and 0.1 <= (math.abs(u221 - j.TimePosition)) then
                            xpcall(function() -- Line: 1568 -- upvalues: j (val), u221 (upval)
                                j.TimePosition = u221
                            end, warn)
                        end
                    end
                end
                if not (CutsceneMusic.TimePosition < u221 - 0.001) then
                    local TimePosition_2 = CutsceneMusic.TimePosition
                    if not (u221 + 0.001 < TimePosition_2) then
                        CutsceneMusic.PlaybackSpeed = 1
                    else
                        CutsceneMusic.PlaybackSpeed = 0.99
                    end
                else
                    CutsceneMusic.PlaybackSpeed = 1.01
                end
                for k = 0, 9 do
                    v1 = math.floor(u221 * 60 - k)
                    if u20[v1] and not u220[v1] then
                        u220[v1] = true
                        for n, m in u20[v1] do
                            task.spawn(m)
                        end
                    end
                end
            end)
            a1:Add(v5)
            task.wait(55.083333333333336)
            v5:Disconnect()
            xpcall(function() -- Line: 1598 -- upvalues: u32 (val)
                u32:Destroy()
            end, warn)
            Vignette.Visible = false
            xpcall(function() -- Line: 1604 -- upvalues: u7 (val)
                for i, j in u7 do
                    j:Destroy()
                end
            end, warn)
            xpcall(function() -- Line: 1610 -- upvalues: u59 (val)
                u59:Destroy()
            end, warn)
            xpcall(restoreCamera, warn)
            v2()
            pcall(function() -- Line: 1614 -- upvalues: Workspace (upval), TweenService (upval)
                task.spawn(function() -- Line: 1615 -- upvalues: Workspace (upval), TweenService (upval)
                    local DragonEggEventMusic = Workspace:WaitForChild("DragonEggEventMusic", 15)
                    TweenService:Create(DragonEggEventMusic, TweenInfo.new(1), {Volume = 0.5}):Play()
                end)
            end)
        end,
    }
end