-- Script path: ReplicatedStorage.Controllers.Game.MonsterParasiteController
-- Decompile time: 155.24 ms

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local CrateOpeningSpinner = require(ReplicatedStorage.Client.UI.CrateOpeningSpinner)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Message = require(ReplicatedStorage.Client.Message)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
require(ReplicatedStorage.Packages.Networking)
local ParasiteVisual = require(ReplicatedStorage.Shared.Eggs.ParasiteVisual)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VisualTransform = require(ReplicatedStorage.Shared.Utils.VisualTransform)
return {
    Start = function() -- Line: 72
        -- upvalues: Remotes (val), VisualTransform (val), Players (val), Trove (val), MonsterParasite_2 (val)
        -- upvalues: CameraShaker (val), RunService (val), ReplicatedStorage (val), MonsterParasite (val), Audio (val)
        -- upvalues: ContentProvider (val), Timer (val), KeyframeSequenceProvider (val), EggToolDisplay (val)
        -- upvalues: Workspace (val), ParasiteVisual (val), EggScaling (val), TweenService (val), Emit (val)
        -- upvalues: PlayVFX (val), Debris (val), Save (val), Message (val), CrateOpeningSpinner (val)
        -- upvalues: HttpService (val), GUI (val), Rarities (val), ButtonFX (val), HiddenUIHandler (val), Tabs (val)
        -- upvalues: CameraShakerDriver (val)
        local MonsterParasite_3 = Remotes.MonsterParasite
        local Fader = VisualTransform.Fader
        local u5 = Random.new()
        local LocalPlayer = Players.LocalPlayer
        local u10 = Trove.new()
        local u13 = u10:Extend()
        local u14 = {}
        local u15 = {}
        local u16 = nil
        local u17 = nil
        local u18 = nil
        local u21 = MonsterParasite_2.DefaultState()
        local u22 = false
        local u23 = false
        local u24 = false
        local u25 = false
        local u26 = false
        local u27 = nil
        local u28 = nil
        local u29 = 0
        local u30 = 0
        local u31 = {}
        local u32 = nil
        local u33 = nil
        local u34 = nil
        local u35 = nil
        local u36 = nil
        local u39 = CameraShaker.new()

        local function runMotion(a1, a2) -- Line: 114 -- upvalues: RunService (upval) -- types: a1: number, a2: function
            local v1 = 0
            while v1 < a1 do
                v1 = math.min(v1 + (RunService.PreRender:Wait()), a1)
                if a2(v1 / a1) then
                    return false
                end
            end
            return true
        end

        local function playSound(a1, a2) -- Line: 129
            -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval), Audio (upval)
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Sounds = if not Assets then nil else Assets:FindFirstChild("Sounds")
            local v1 = if not Sounds then nil else Sounds:FindFirstChild(MonsterParasite.SoundFolderName)
            local v2 = if not v1 then nil else v1:FindFirstChild(a1)
            if v2 and v2:IsA("Sound") then
                Audio.Play(v2, a2)
            end
        end

        local function resolveChestTemplate() -- Line: 141
            -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval)
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Models = if not Assets then nil else Assets:FindFirstChild("Models")
            local v1 = if not Models then nil else Models:FindFirstChild(MonsterParasite.AssetsFolderName)
            local v2 = if not v1 then nil else v1:FindFirstChild(MonsterParasite.ChestModelName)
            if v2 and v2:IsA("Model") and v2.PrimaryPart then
                return v2
            end
            return nil
        end

        local function resolveVfxTemplate(a1) -- Line: 157
            -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval)
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local VFX = if not Assets then nil else Assets:FindFirstChild("VFX")
            local v1 = if not VFX then nil else VFX:FindFirstChild(MonsterParasite.VfxFolderName)
            local v2 = if not v1 then nil else v1:FindFirstChild(a1)
            if v2 and v2:IsA("Attachment") then
                return v2
            end
            return nil
        end

        local function resolveEnergyBurstTemplate() -- Line: 167
            -- upvalues: resolveVfxTemplate (val), MonsterParasite (upval)
            return (resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName))
        end

        local function resolveSwapPoofTemplate() -- Line: 171
            -- upvalues: resolveVfxTemplate (val), MonsterParasite (upval)
            return (resolveVfxTemplate(MonsterParasite.SwapPoofVfxName))
        end

        local function getMonsterModelIndex(a1) -- Line: 246 -- upvalues: MonsterParasite (upval) -- types: a1: userdata
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            if typeof(Attribute) ~= "number" then
                return nil
            end
            return Attribute
        end

        local function getMonsterAnimationIds(a1) -- Line: 255
            -- upvalues: MonsterParasite (upval)
            local v1
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            if (if typeof(Attribute) == "number" then Attribute else nil) == nil then
                return nil
            end
            return MonsterParasite.MonsterAnimationIdsByIndex[v1]
        end

        local function waitForAnimator(a1) -- Line: 270 -- types: a1: userdata
            local v1
            local Animator = a1:FindFirstChildWhichIsA("Animator", true)
            if Animator ~= nil then
                return Animator
            end
            local v2 = os.clock() + 5
            while true do
                task.wait()
                if a1.Parent == nil then
                    break
                end
                v1 = a1:FindFirstChildWhichIsA("Animator", true)
                if v1 == nil and not (v2 <= os.clock()) then
                    continue
                end
                if v1 == nil then
                    warn((("[MonsterParasite] Missing Animator in %*"):format((a1:GetFullName()))))
                end
                return v1
            end
            return nil
        end

        local function loadAnimationTrack(a1, a2) -- Line: 289
            -- upvalues: waitForAnimator (val)
            local u4 = waitForAnimator(a1)
            if u4 == nil then
                return nil
            end
            local Animation = Instance.new("Animation")
            Animation.AnimationId = ("rbxassetid://%*"):format(a2)
            local success, err = pcall(function() -- Line: 299 -- upvalues: u4 (val), Animation (val)
                return u4:LoadAnimation(Animation)
            end)
            Animation:Destroy()
            if success then
                return err
            end
            warn((("[MonsterParasite] Failed to load animation %*: %*"):format(a2, err)))
            return nil
        end

        local function playAnimationAndWait(a1, a2, a3) -- Line: 312
            -- upvalues: Trove (upval), Timer (upval)
            local u3 = false
            local BindableEvent = Instance.new("BindableEvent")
            local v1 = Trove.new()
            v1:Add(BindableEvent)

            local function finish() -- Line: 322 -- upvalues: u3 (ref), BindableEvent (val)
                if u3 then
                    return
                end
                u3 = true
                BindableEvent:Fire()
            end

            v1:Connect(a1.Ended, finish)
            v1:Connect(a1.Stopped, finish)
            v1:Connect(a2.Destroying, finish)
            a1:Play(0.1)
            v1:Add((Timer.Simple(math.max(a1.Length + 1, 5), finish)))
            if a3 then
                a3()
            end
            if not u3 then
                BindableEvent.Event:Wait()
            end
            v1:Destroy()
        end

        local function pauseIdle(a1) -- Line: 343 -- upvalues: u15 (val) -- types: a1: userdata
            local v1 = u15[a1]
            if v1 and v1.IsPlaying then
                v1:Stop(0.1)
            end
        end

        local function resumeIdle(a1) -- Line: 350 -- upvalues: u15 (val) -- types: a1: userdata
            local v1 = u15[a1]
            if v1 and a1.Parent and not v1.IsPlaying then
                v1:Play(0.1)
            end
        end

        local u54 = {[2] = {"Tongue3"}, [4] = {"root", "BackLeg1.L", "BackLeg1.R"}}
        local u61 = {}

        local function getPoseInfo(a1) -- Line: 409
            -- upvalues: u61 (val), KeyframeSequenceProvider (upval)
            local v1 = u61[a1]
            if v1 ~= nil then
                return v1
            end
            local success, err = pcall(function() -- Line: 414 -- upvalues: KeyframeSequenceProvider (upval), a1 (val)
                local scan, v1
                local KeyframeSequenceAsync = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(a1)))
                local u53 = {}
                local u54 = {}

                function scan(a1) -- Line: 420 -- upvalues: u53 (val), u54 (val), scan (val) -- types: a1: userdata
                    local Name = a1.Name
                    local v1 = u53[Name]
                    if v1 == nil then
                        u53[Name] = a1.CFrame
                    elseif not u54[Name] and not v1:FuzzyEq(a1.CFrame, 0.001) then
                        u54[Name] = true
                    end
                    for i, j in a1:GetSubPoses() do
                        scan(j)
                    end
                end

                for i, j in KeyframeSequenceAsync:GetKeyframes() do
                    for k, n in j:GetChildren() do
                        if n:IsA("Pose") then
                            scan(n)
                        end
                    end
                end
                local v2 = {}
                for m in u53 do
                    v1 = {constant = not u54[m]}
                    v2[m] = v1
                end
                return v2
            end)
            if not success then
                return nil
            end
            u61[a1] = err
            return err
        end

        local function collectStrayBones(a1, a2, a3) -- Line: 455
            -- upvalues: u61 (val), KeyframeSequenceProvider (upval), u54 (val)
            local err_2, success_2, v1, v2, v3, v4
            local Idle = a2.Idle
            local v5 = u61[Idle]
            if v5 == nil then
                local success, err = pcall(function() -- Line: 414 -- upvalues: KeyframeSequenceProvider (upval), Idle (val)
                    local scan, v1
                    local KeyframeSequenceAsync = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(Idle)))
                    local u53 = {}
                    local u54 = {}

                    function scan(a1) -- Line: 420 -- upvalues: u53 (val), u54 (val), scan (val) -- types: a1: userdata
                        local Name = a1.Name
                        local v1 = u53[Name]
                        if v1 == nil then
                            u53[Name] = a1.CFrame
                        elseif not u54[Name] and not v1:FuzzyEq(a1.CFrame, 0.001) then
                            u54[Name] = true
                        end
                        for i, j in a1:GetSubPoses() do
                            scan(j)
                        end
                    end

                    for i, j in KeyframeSequenceAsync:GetKeyframes() do
                        for k, n in j:GetChildren() do
                            if n:IsA("Pose") then
                                scan(n)
                            end
                        end
                    end
                    local v2 = {}
                    for m in u53 do
                        v1 = {constant = not u54[m]}
                        v2[m] = v1
                    end
                    return v2
                end)
                if success then
                    u61[Idle] = err
                    v4 = err
                else
                    v4 = nil
                end
            else
                v4 = v5
            end
            if v4 == nil then
                return {}
            end
            local v6 = {a2.Yank}
            local Burp = a2.Burp
            if Burp ~= nil then
                table.insert(v6, Burp)
            end
            v5 = {}
            local v7 = nil
            local v8 = nil
            for i, j in v6, v7, v8 do
                v3 = u61[j]
                if v3 == nil then
                    success_2, err_2 = pcall(function() -- Line: 414 -- upvalues: KeyframeSequenceProvider (upval), j (val)
                        local scan, v1
                        local KeyframeSequenceAsync = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(j)))
                        local u53 = {}
                        local u54 = {}

                        function scan(a1) -- Line: 420
                            -- upvalues: u53 (val), u54 (val), scan (val)
                            local Name = a1.Name
                            local v1 = u53[Name]
                            if v1 == nil then
                                u53[Name] = a1.CFrame
                            elseif not u54[Name] and not v1:FuzzyEq(a1.CFrame, 0.001) then
                                u54[Name] = true
                            end
                            for i, j in a1:GetSubPoses() do
                                scan(j)
                            end
                        end

                        for i, j2 in KeyframeSequenceAsync:GetKeyframes() do
                            for k, n in j2:GetChildren() do
                                if n:IsA("Pose") then
                                    scan(n)
                                end
                            end
                        end
                        local v2 = {}
                        for m in u53 do
                            v1 = {constant = not u54[m]}
                            v2[m] = v1
                        end
                        return v2
                    end)
                    if success_2 then
                        u61[j] = err_2
                        v2 = err_2
                    else
                        v2 = nil
                    end
                else
                    v2 = v3
                end
                if v2 ~= nil then
                    for k in v2 do
                        if v4[k] == nil then
                            v5[k] = true
                        end
                    end
                end
            end
            local v9 = u54[a3] or {}
            v7 = nil
            v8 = nil
            for n, m in v9, v7, v8 do
                v6 = v4[m]
                if v6 == nil or v6.constant then
                    v5[m] = true
                end
            end
            v4 = {}
            for i5 in v5 do
                v2 = v1:FindFirstChild(i5, true)
                if v2 and v2:IsA("Bone") then
                    table.insert(v4, v2)
                end
            end
            return v4
        end

        local function guardStrayBones(a1, a2, a3, a4, a5) -- Line: 497
            -- upvalues: collectStrayBones (val), RunService (upval)
            if a1.Parent == nil then
                return
            end
            local u10 = collectStrayBones(a1, a3, a4)
            if #u10 == 0 then
                return
            end
            local u12 = {}
            local u13 = 0
            a5:Connect(RunService.PostSimulation, function(a1) -- Line: 519 -- upvalues: a2 (val), u13 (ref), u12 (val), u10 (val) -- types: a1: number
                local identity_2, v1
                if not a2.IsPlaying then
                    u13 = 0
                    table.clear(u12)
                    return
                end
                if u13 <= 0 then
                    for i, j in u10 do
                        u12[j] = j.Transform
                    end
                end
                u13 = math.min(u13 + a1, 0.18)
                local v2 = u13 / 0.18
                local v3 = nil
                local v4 = nil
                for k, n in u10, v3, v4 do
                    v1 = u12[n]
                    identity_2 = if v1 == nil then CFrame.identity else if not (v2 >= 1) then v1:Lerp(CFrame.identity, v2) else CFrame.identity
                    n.Transform = identity_2
                end
            end)
        end

        local function startIdle(a1, a2) -- Line: 544
            -- upvalues: MonsterParasite (upval), loadAnimationTrack (val), u15 (val), guardStrayBones (val)
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            local v1 = if typeof(Attribute) == "number" then Attribute else nil
            local u16 = if v1 ~= nil then MonsterParasite.MonsterAnimationIdsByIndex[v1] else nil
            local Attribute_2 = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            local u28 = if typeof(Attribute_2) == "number" then Attribute_2 else nil
            if u16 ~= nil and u28 ~= nil then
                local u32 = false
                a2:Add(function() -- Line: 551 -- upvalues: u32 (ref)
                    u32 = true
                end)
                task.spawn(function() -- Line: 554
                    -- upvalues: loadAnimationTrack (upval), a1 (val), u16 (val), u32 (ref), u15 (upval), a2 (val)
                    -- upvalues: guardStrayBones (upval), u28 (val)
                    local v1 = loadAnimationTrack(a1, u16.Idle)
                    if v1 == nil then
                        return
                    end
                    if not u32 and a1.Parent ~= nil then
                        v1.Looped = true
                        v1.Priority = Enum.AnimationPriority.Idle
                        u15[a1] = v1
                        a2:Add(v1)
                        a2:Add(function() -- Line: 573 -- upvalues: u15 (upval), a1 (upval)
                            u15[a1] = nil
                        end)
                        v1:Play(0.1)
                        guardStrayBones(a1, v1, u16, u28, a2)
                        return
                    end
                    v1:Destroy()
                end)
                return
            end
        end

        local function getEquippedEggTool() -- Line: 581 -- upvalues: LocalPlayer (val), EggToolDisplay (upval)
            local Character = LocalPlayer.Character
            if Character == nil then
                return nil
            end
            for i, j in Character:GetChildren() do
                if j:IsA("Tool") and EggToolDisplay.IsEggTool(j) then
                    return j
                end
            end
            return nil
        end

        local function getEquippedEggHandle() -- Line: 594 -- upvalues: getEquippedEggTool (val)
            local v1 = getEquippedEggTool()
            local Handle = if not v1 then nil else v1:FindFirstChild("Handle")
            if Handle and Handle:IsA("BasePart") then
                return Handle
            end
            return nil
        end

        local function getEquippedEggModel() -- Line: 603
            -- upvalues: getEquippedEggTool (val), EggToolDisplay (upval), LocalPlayer (val)
            local v1 = getEquippedEggTool()
            if v1 == nil then
                return nil
            end
            local v2 = EggToolDisplay.GetToolUid(v1)
            local v3 = if not v2 then nil else v1:FindFirstChild((("%*_%*"):format(LocalPlayer.UserId, v2)))
            if v3 ~= nil and v3:IsA("Model") then
                return v3
            end
            return v1:FindFirstChildOfClass("Model")
        end

        local function getWorldCFrame(a1) -- Line: 618 -- types: a1: userdata?
            if a1 == nil then
                return nil
            end
            if a1:IsA("BasePart") then
                return a1.CFrame
            end
            if not a1:IsA("Attachment") and not a1:IsA("Bone") then
                return nil
            end
            return a1.WorldCFrame
        end

        local u70 = {
            ScaleTweenDelaySeconds = 0.2,
            PickupFadeStart = 0.55,
            PickupFadeEnd = 1,
            PickupMinScale = 0.001,
            PickupTargetHeight = 1.5,
            MouthBiteStuds = 2.2,
            SeizeSeconds = 0.1,
            MouthPull = 0.85,
            SwallowSeconds = 0.2,
            HandPoseName = "toolnone",
            HandPoseReleaseSeconds = 0.4,
            SwallowDepth = 0.9,
            SwallowScale = 0.05,
            MinScale = 0.001,
            MouthTargetNames = {"MouthCenter1", "ParasiteEatTarget", "Tongue3"},
        }

        local function getAnimatedWorldCFrame(a1) -- Line: 666 -- types: a1: userdata?
            if a1 == nil then
                return nil
            end
            if a1:IsA("Attachment") then
                local Parent = a1.Parent
                if Parent ~= nil and Parent:IsA("Bone") then
                    return Parent.TransformedWorldCFrame * a1.CFrame
                end
                return a1.WorldCFrame
            end
            if a1:IsA("Bone") then
                return a1.TransformedWorldCFrame
            end
            if a1 == nil then
                return nil
            end
            if a1:IsA("BasePart") then
                return a1.CFrame
            end
            if not a1:IsA("Attachment") and not a1:IsA("Bone") then
                return nil
            end
            return a1.WorldCFrame
        end

        local function resolveGrabTarget(a1) -- Line: 683 -- upvalues: MonsterParasite (upval) -- types: a1: userdata
            return a1:FindFirstChild("ParasiteGrabber", true) or a1:FindFirstChild(MonsterParasite.TongueTipName, true) or a1:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true)
        end

        local function resolveMouthTarget(a1) -- Line: 691 -- upvalues: u70 (val) -- types: a1: userdata
            local v1
            for i, j in u70.MouthTargetNames do
                v1 = a1:FindFirstChild(j, true)
                if v1 ~= nil then
                    return v1
                end
            end
            return a1.PrimaryPart
        end

        local function resolveChestOrigin(a1) -- Line: 701 -- upvalues: MonsterParasite (upval) -- types: a1: userdata
            local v1
            for i, j in MonsterParasite.ChestOriginNames do
                v1 = a1:FindFirstChild(j, true)
                if v1 ~= nil then
                    return v1
                end
            end
            return nil
        end

        local function buildGroundProbeParams(a1) -- Line: 711
            -- upvalues: u17 (ref), Workspace (upval), MonsterParasite (upval), Players (upval)
            local Character
            local v1 = RaycastParams.new()
            v1.FilterType = Enum.RaycastFilterType.Exclude
            v1.IgnoreWater = true
            local v2 = {a1}
            if u17 then
                table.insert(v2, u17)
            end
            local v3 = Workspace:FindFirstChild(MonsterParasite.MarkerFolderName, true)
            if v3 then
                table.insert(v2, v3)
            end
            for i, j in Players:GetPlayers() do
                Character = j.Character
                if Character then
                    table.insert(v2, Character)
                end
            end
            v1.FilterDescendantsInstances = v2
            return v1
        end

        local function monsterForward(a1, a2) -- Line: 738 -- types: a1: userdata, a2: userdata
            local v1 = a1:GetPivot().LookVector * Vector3.new(1, 0, 1)
            if v1.Magnitude < 0.05 then
                v1 = a2.LookVector * Vector3.new(1, 0, 1)
            end
            if 0.001 < v1.Magnitude then
                return v1.Unit
            end
            return (Vector3.new(0, 0, -1))
        end

        local function probeGround(a1, a2) -- Line: 749
            -- upvalues: Workspace (upval), MonsterParasite (upval)
            return Workspace:Raycast(
                a1 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight,
                Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth,
                a2
            )
        end

        local function resolveGroundLanding(a1, a2) -- Line: 772
            -- upvalues: buildGroundProbeParams (val), MonsterParasite (upval), u5 (val), Workspace (upval)
            local v1, v2, v3, v4
            local v5 = a1:GetPivot().LookVector * Vector3.new(1, 0, 1)
            if v5.Magnitude < 0.05 then
                v5 = a2.LookVector * Vector3.new(1, 0, 1)
            end
            local Unit = if not (0.001 < v5.Magnitude) then Vector3.new(0, 0, -1) else v5.Unit
            local Position = a2.Position
            local u144 = buildGroundProbeParams(a1)
            local ChestThrowDistanceMin = MonsterParasite.ChestThrowDistanceMin
            local u33 = math.max(MonsterParasite.ChestThrowDistanceMax - ChestThrowDistanceMin, 0)
            local v6 = math.rad(MonsterParasite.ChestThrowSpreadDegrees)
            local v7 = math.rad(MonsterParasite.ChestThrowStraightJitterDegrees)
            local v8 = math.max(MonsterParasite.ChestThrowAttempts, 1)
            local v9 = math.max(math.floor(v8 / 2), 1)

            local function candidate(a1) -- Line: 787
                -- upvalues: Position (val), ChestThrowDistanceMin (val), u5 (upval), u33 (val), Workspace (upval)
                -- upvalues: u144 (val), MonsterParasite (upval)
                local v1 = Position + a1 * (ChestThrowDistanceMin + (u5:NextNumber()) * u33)
                local v2 = Workspace:Raycast(Position, v1 - Position, u144)
                if v2 ~= nil then
                    v1 = v2.Position - a1 * 1.5
                    if ((v1 - Position) * Vector3.new(1, 0, 1)).Magnitude < ChestThrowDistanceMin then
                        return nil, nil
                    end
                end
                v2 = Workspace:Raycast(
                    v1 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight,
                    Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth,
                    u144
                )
                if v2 == nil then
                    return nil, nil
                end
                return (CFrame.new(v2.Position)) * CFrame.Angles(0, u5:NextNumber() * 3.141592653589793 * 2, 0), v2.Normal
            end

            for i = 1, v8 do
                v1 = math.floor(i / 2)
                v2 = if v1 ~= 0 then (if i % 2 ~= 0 then -1 else 1) * v6 * math.min(v1 / v9, 1) else (u5:NextNumber() * 2 - 1) * v7
                v3, v4 = candidate(CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v2) * Unit)
                if v3 ~= nil and v4 ~= nil then
                    return v3, v4
                end
            end
            local v10 = Position + Unit * ChestThrowDistanceMin
            v9 = Workspace:Raycast(Position, v10 - Position, u144)
            if v9 ~= nil then
                v10 = v9.Position - Unit * 1.5
            end
            v9 = Workspace:Raycast(
                v10 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight,
                Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth,
                u144
            )
            local v11 = (CFrame.new(if not v9 then Vector3.new(v10.X, (a1:GetPivot()).Position.Y, v10.Z) else v9.Position)) * CFrame.Angles(0, u5:NextNumber() * 3.141592653589793 * 2, 0)
            if v9 then
                return v11, v9.Normal
            end
            return v11, (Vector3.new(0, 1, 0))
        end

        local function resolveEffectParent() -- Line: 838 -- upvalues: Workspace (upval)
            local Transient = Workspace:FindFirstChild("Transient")
            if Transient and Transient:IsA("Folder") then
                return Transient
            end
            return Workspace
        end

        local function clearChest() -- Line: 845 -- upvalues: u17 (ref)
            if u17 then
                u17:Destroy()
                u17 = nil
            end
        end

        local function createChest(a1) -- Line: 852
            -- upvalues: resolveChestTemplate (val), u17 (ref), Workspace (upval)
            local v1 = resolveChestTemplate()
            if v1 == nil then
                return nil
            end
            if u17 then
                u17:Destroy()
                u17 = nil
            end
            local v2 = v1:Clone()
            for i, j in v2:GetDescendants() do
                if j:IsA("BasePart") then
                    j.Anchored = true
                    j.CanCollide = false
                    j.CanTouch = false
                end
            end
            v2:PivotTo(a1)
            v1 = Workspace:FindFirstChild("Transient")
            v2.Parent = if not v1 then Workspace else if not v1:IsA("Folder") then Workspace else v1
            u17 = v2
            return v2
        end

        local function stopPendingYankFollow() -- Line: 881 -- upvalues: u35 (ref)
            local v1 = u35
            u35 = nil
            if v1 ~= nil then
                v1:Disconnect()
            end
        end

        local function prepareEggYankClone(a1) -- Line: 901
            -- upvalues: Workspace (upval), MonsterParasite (upval), ParasiteVisual (upval)
            local Part0, Part1, v1
            if a1.PrimaryPart == nil then
                return nil
            end
            local u141 = a1:Clone()

            local function inside(a1) -- Line: 906 -- upvalues: u141 (val) -- types: a1: userdata?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1:IsDescendantOf(u141)
                end
                return v1
            end

            local v2 = a1
            for i, j in u141:GetDescendants() do
                if j:IsA("BasePart") then
                    j.Anchored = true
                    j.CanCollide = false
                    j.CanQuery = false
                    j.CanTouch = false
                    j.Massless = true
                elseif j:IsA("BillboardGui") then
                    j:Destroy()
                elseif j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") then
                    Part0 = j.Part0
                    v1 = false
                    if Part0 ~= nil then
                        v1 = Part0:IsDescendantOf(u141)
                    end
                    if not v1 then
                        j:Destroy()
                    else
                        Part1 = j.Part1
                        v1 = false
                        if Part1 ~= nil then
                            v1 = Part1:IsDescendantOf(u141)
                        end
                        if not v1 then
                            j:Destroy()
                        end
                    end
                end
            end
            local v3 = Workspace:FindFirstChild("Transient")
            u141.Parent = if not v3 then Workspace else if not v3:IsA("Folder") then Workspace else v3
            u141:PivotTo((v2:GetPivot()))
            local v4 = v2:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
            local v5 = u141:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
            if v4 ~= nil and v5 ~= nil and v4:IsA("Model") and v5:IsA("Model") then
                local v6 = (ParasiteVisual.PoseDrift(v4)) - ParasiteVisual.PoseDrift(v5)
                if 0.001 < v6.Magnitude then
                    v5:PivotTo((v5:GetPivot()) + v6)
                end
            end
            return u141
        end

        local function holdHandPose() -- Line: 960 -- upvalues: u36 (ref), LocalPlayer (val), u70 (val)
            local Animation
            if u36 ~= nil then
                return
            end
            local Character = LocalPlayer.Character
            if Character == nil then
                return
            end
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local Animator = if Humanoid == nil then nil else Humanoid:FindFirstChildOfClass("Animator")
            if Animator == nil then
                return
            end
            local v1 = Character:FindFirstChild("Animate")
            local v2 = if v1 == nil then nil else v1:FindFirstChild(u70.HandPoseName)
            local u32 = if v2 == nil then nil else v2:FindFirstChildOfClass("Animation")
            if u32 == nil then
                return
            end
            local Action = Enum.AnimationPriority.Action
            for i, j in Animator:GetPlayingAnimationTracks() do
                Animation = j.Animation
                if Animation ~= nil and Animation.AnimationId == u32.AnimationId then
                    Action = j.Priority
                    break
                end
            end
            local success, err = pcall(function() -- Line: 996 -- upvalues: Animator (val), u32 (val)
                return Animator:LoadAnimation(u32)
            end)
            if not success then
                warn((("[MonsterParasite] Failed to hold the egg pose: %*"):format(err)))
                return
            end
            err.Looped = true
            err.Priority = Action
            err:Play(0)
            u36 = err
        end

        local function releaseHandPose() -- Line: 1011 -- upvalues: u36 (ref), u70 (val)
            local u0 = u36
            u36 = nil
            if u0 == nil then
                return
            end
            u0:Stop(u70.HandPoseReleaseSeconds)
            task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u0 (val)
                u0:Destroy()
            end)
        end

        local function captureEquippedEgg() -- Line: 1032
            -- upvalues: u32 (ref), getEquippedEggModel (val), prepareEggYankClone (val), Fader (val), u34 (ref)
            -- upvalues: u33 (ref), holdHandPose (val), u35 (ref), RunService (upval), LocalPlayer (val)
            -- upvalues: Workspace (upval)
            if u32 ~= nil then
                return
            end
            local u2 = getEquippedEggModel()
            if u2 == nil then
                return
            end
            local u5 = prepareEggYankClone(u2)
            if u5 == nil then
                return
            end
            local u7 = Fader()
            u7:Hide(u5, 1)
            u32 = u5
            u34 = u7
            u33 = u2
            holdHandPose()
            local u15 = nil
            local u16 = false
            local v1 = u35
            u35 = nil
            if v1 ~= nil then
                v1:Disconnect()
            end
            RunService.RenderStepped:Connect(function() -- Line: 1056
                -- upvalues: u5 (val), LocalPlayer (upval), u2 (val), Workspace (upval), u15 (ref), u16 (ref), u7 (val)
                if u5.Parent == nil then
                    return
                end
                local Character = LocalPlayer.Character
                local RightHand = if Character == nil then nil else Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm") or Character:FindFirstChild("HumanoidRootPart")
                local v1 = if RightHand == nil then nil else if not RightHand:IsA("BasePart") then nil else RightHand
                if u2:IsDescendantOf(Workspace) then
                    if v1 ~= nil then
                        u15 = v1.CFrame:ToObjectSpace((u2:GetPivot()))
                    end
                    u5:PivotTo((u2:GetPivot()))
                    return
                end
                if not u16 then
                    u16 = true
                    u7:Hide(u5, 0)
                end
                if v1 ~= nil and u15 ~= nil then
                    u5:PivotTo(v1.CFrame * u15)
                end
            end)
        end

        local function takeCapturedEgg() -- Line: 1089
            -- upvalues: captureEquippedEgg (val), u35 (ref), u32 (ref), u34 (ref), u33 (ref), u36 (ref), u70 (val)
            -- upvalues: Workspace (upval), Fader (val), LocalPlayer (val), ParasiteVisual (upval)
            captureEquippedEgg()
            local v1 = u35
            u35 = nil
            if v1 ~= nil then
                v1:Disconnect()
            end
            v1 = u32
            local v2 = u34
            local v3 = u33
            u32 = nil
            u34 = nil
            u33 = nil
            if v1 ~= nil and v1.Parent ~= nil then
                if v3 ~= nil and v3:IsDescendantOf(Workspace) then
                    v1:PivotTo((v3:GetPivot()))
                    Fader():Hide(v3, 1)
                end
                if v2 ~= nil then
                    v2:Hide(v1, 0)
                end
                local Character = LocalPlayer.Character
                if Character ~= nil then
                    ParasiteVisual.Clear(Character)
                end
                local u44 = u36
                u36 = nil
                if u44 == nil then
                    return v1
                end
                u44:Stop(u70.HandPoseReleaseSeconds)
                task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u44 (val)
                    u44:Destroy()
                end)
                return v1
            end
            local u58 = u36
            u36 = nil
            if u58 ~= nil then
                u58:Stop(u70.HandPoseReleaseSeconds)
                task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u58 (val)
                    u58:Destroy()
                end)
            end
            return nil
        end

        local function discardPendingYank() -- Line: 1122
            -- upvalues: u35 (ref), u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref)
            local v1 = u35
            u35 = nil
            if v1 ~= nil then
                v1:Disconnect()
            end
            local u5 = u36
            u36 = nil
            if u5 ~= nil then
                u5:Stop(u70.HandPoseReleaseSeconds)
                task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u5 (val)
                    u5:Destroy()
                end)
            end
            if u32 ~= nil then
                u32:Destroy()
                u32 = nil
            end
            u34 = nil
            u33 = nil
        end

        local function carryEgg(a1, a2) -- Line: 1144
            -- upvalues: u70 (val), EggScaling (upval)
            local BoundingBox = a1:GetBoundingBox()
            local v1 = Vector3.new(1, 1, 1) * (u70.MouthBiteStuds * a2:GetScale())
            local Scale = a1:GetScale()
            return {
                Model = a1,
                StartScale = Scale,
                FitScale = math.min(Scale, (EggScaling.FitInside(a1, v1))),
                CenterOffset = (a1:GetPivot()):PointToObjectSpace(BoundingBox.Position),
            }
        end

        local function placeCarriedEgg(a1, a2, a3) -- Line: 1156 -- types: a1: table, a2: userdata, a3: number
            local Model = a1.Model
            Model:ScaleTo(a3)
            Model:PivotTo(a2 * (CFrame.new(-a1.CenterOffset * (a3 / a1.StartScale))))
        end

        local function swallowEgg(a1, a2, a3, a4, a5, a6) -- Line: 1173
            -- upvalues: RunService (upval), u70 (val), getAnimatedWorldCFrame (val), TweenService (upval)
            local Model = a1.Model
            local u7 = 0
            local u8 = nil
            RunService.PreRender:Connect(function(a1_2) -- Line: 1184
                -- upvalues: u7 (ref), u70 (upval), Model (val), a2 (val), getAnimatedWorldCFrame (upval), a3 (val)
                -- upvalues: a4 (val), a5 (val), TweenService (upval), a1 (val), a6 (val), u8 (ref)
                local v1
                u7 = math.min(u7 + a1_2, u70.SwallowSeconds)
                local v2 = true
                if Model.Parent ~= nil then
                    v2 = a2.Parent == nil
                end
                if not v2 then
                    v1 = getAnimatedWorldCFrame(a3)
                    local Position_2 = if v1 == nil then a5.Position else v1.Position + ((a2:GetPivot()):VectorToWorldSpace(a4)) * (u70.SwallowDepth * a2:GetScale())
                    v1 = TweenService:GetValue(u7 / u70.SwallowSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v3 = a1
                    local v4 = (CFrame.new(a5.Position:Lerp(Position_2, v1))) * a5.Rotation
                    local v5 = math.max(u70.MinScale, (math.lerp(a6, a6 * u70.SwallowScale, v1)))
                    local Model_2 = v3.Model
                    Model_2:ScaleTo(v5)
                    Model_2:PivotTo(v4 * (CFrame.new(-v3.CenterOffset * (v5 / v3.StartScale))))
                end
                if v2 then
                    u8:Disconnect()
                    Model:Destroy()
                else
                    v1 = u7
                    if u70.SwallowSeconds <= v1 then
                        u8:Disconnect()
                        Model:Destroy()
                    end
                end
            end)
        end

        local function animateEggYank(a1) -- Line: 1220
            -- upvalues: u35 (ref), u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref), takeCapturedEgg (val)
            -- upvalues: resolveMouthTarget (val), carryEgg (val), runMotion (val), MonsterParasite (upval)
            -- upvalues: getAnimatedWorldCFrame (val), TweenService (upval), RunService (upval)
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                local v1 = u35
                u35 = nil
                if v1 ~= nil then
                    v1:Disconnect()
                end
                local u7 = u36
                u36 = nil
                if u7 ~= nil then
                    u7:Stop(u70.HandPoseReleaseSeconds)
                    task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u7 (val)
                        u7:Destroy()
                    end)
                end
                if u32 ~= nil then
                    u32:Destroy()
                    u32 = nil
                end
                u34 = nil
                u33 = nil
                return
            end
            local u28 = takeCapturedEgg()
            if u28 == nil then
                return
            end
            local u31 = resolveMouthTarget(a1)
            local u35_2 = carryEgg(u28, a1)
            local u42 = (u28:GetPivot()) * CFrame.new(u35_2.CenterOffset)
            runMotion(MonsterParasite.YankDuration, function(a1_2) -- Line: 1233
                -- upvalues: u28 (val), a1 (val), getAnimatedWorldCFrame (upval), u31 (val), PrimaryPart (val)
                -- upvalues: TweenService (upval), u35_2 (val), u42 (val)
                if u28.Parent ~= nil and a1.Parent ~= nil then
                    local CFrame_2 = getAnimatedWorldCFrame(u31) or PrimaryPart.CFrame
                    local Value = TweenService:GetValue(a1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    local v1 = u35_2
                    local v2 = (CFrame.new(u42.Position:Lerp(CFrame_2.Position, Value))) * u42.Rotation
                    local v3 = math.lerp(u35_2.StartScale, u35_2.FitScale, Value)
                    local Model = v1.Model
                    Model:ScaleTo(v3)
                    Model:PivotTo(v2 * (CFrame.new(-v1.CenterOffset * (v3 / v1.StartScale))))
                    return nil
                end
                return true
            end)
            if u28.Parent ~= nil and a1.Parent ~= nil then
                local u60 = (u28:GetPivot()) * CFrame.new(u35_2.CenterOffset * (u35_2.FitScale / u35_2.StartScale))
                local FitScale = u35_2.FitScale
                local Model = u35_2.Model
                local u63 = 0
                local u64 = nil
                local PreRender = RunService.PreRender
                local u67 = Vector3.new(0, 0, 1)
                PreRender:Connect(function(a1_2) -- Line: 1184
                    -- upvalues: u63 (ref), u70 (upval), Model (val), a1 (val), getAnimatedWorldCFrame (upval)
                    -- upvalues: u31 (val), u67 (val), u60 (val), TweenService (upval), u35_2 (val), FitScale (val)
                    -- upvalues: u64 (ref)
                    local v1
                    u63 = math.min(u63 + a1_2, u70.SwallowSeconds)
                    local v2 = true
                    if Model.Parent ~= nil then
                        v2 = a1.Parent == nil
                    end
                    if not v2 then
                        v1 = getAnimatedWorldCFrame(u31)
                        local Position_2 = if v1 == nil then u60.Position else v1.Position + ((a1:GetPivot()):VectorToWorldSpace(u67)) * (u70.SwallowDepth * a1:GetScale())
                        v1 = TweenService:GetValue(u63 / u70.SwallowSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                        local v3 = u35_2
                        local v4 = (CFrame.new(u60.Position:Lerp(Position_2, v1))) * u60.Rotation
                        local v5 = math.max(u70.MinScale, (math.lerp(FitScale, FitScale * u70.SwallowScale, v1)))
                        local Model_2 = v3.Model
                        Model_2:ScaleTo(v5)
                        Model_2:PivotTo(v4 * (CFrame.new(-v3.CenterOffset * (v5 / v3.StartScale))))
                    end
                    if v2 then
                        u64:Disconnect()
                        Model:Destroy()
                    else
                        v1 = u63
                        if u70.SwallowSeconds <= v1 then
                            u64:Disconnect()
                            Model:Destroy()
                        end
                    end
                end)
                return
            end
            u28:Destroy()
        end

        local function animateEggGrab(a1, a2) -- Line: 1273
            -- upvalues: animateEggYank (val), takeCapturedEgg (val), MonsterParasite (upval), resolveMouthTarget (val)
            -- upvalues: getAnimatedWorldCFrame (val), carryEgg (val), RunService (upval), TweenService (upval)
            -- upvalues: u70 (val)
            if not a2.IsPlaying then
                animateEggYank(a1)
                return
            end
            local u7 = takeCapturedEgg()
            if u7 == nil then
                return
            end
            local ParasiteGrabber = a1:FindFirstChild("ParasiteGrabber", true)
            if not ParasiteGrabber then
                ParasiteGrabber = a1:FindFirstChild(MonsterParasite.TongueTipName, true)
                if not ParasiteGrabber then
                    ParasiteGrabber = a1:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true)
                end
            end
            local u28 = resolveMouthTarget(a1)
            local v1 = getAnimatedWorldCFrame(ParasiteGrabber)
            local v2 = getAnimatedWorldCFrame(u28)
            if v1 ~= nil and v2 ~= nil then
                local u40 = carryEgg(u7, a1)
                local v3 = (u7:GetPivot()) * CFrame.new(u40.CenterOffset)
                local Rotation = v3.Rotation
                local u51 = v3.Position - v1.Position
                v3 = v1.Position - v2.Position
                local Magnitude = v3.Magnitude
                local u66 = if not (Magnitude > 0.01) then Vector3.new(0, 0, 1) else (a1:GetPivot()):VectorToObjectSpace(-v3.Unit)
                local u67 = 0
                local u68 = 0
                local u69 = nil
                RunService.RenderStepped:Connect(function(a1_2) -- Line: 1310
                    -- upvalues: u7 (val), a1 (val), u69 (ref), getAnimatedWorldCFrame (upval), ParasiteGrabber (val)
                    -- upvalues: u28 (val), u67 (ref), Magnitude (val), MonsterParasite (upval), u68 (ref)
                    -- upvalues: TweenService (upval), u70 (upval), u51 (val), Rotation (val), u40 (val), a2 (val)
                    -- upvalues: u66 (val), RunService (upval)
                    if u7.Parent ~= nil and a1.Parent ~= nil then
                        local v1 = getAnimatedWorldCFrame(ParasiteGrabber)
                        local v2 = getAnimatedWorldCFrame(u28)
                        if v1 ~= nil and v2 ~= nil then
                            u67 = u67 + a1_2
                            u68 = math.clamp(math.max(
                                u68,
                                if not (Magnitude > 1) then u67 / MonsterParasite.YankDuration else 1 - (v1.Position - v2.Position).Magnitude / Magnitude
                            ), 0, 1)
                            local Value = TweenService:GetValue(math.clamp(u67 / u70.SeizeSeconds, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local u73 = (CFrame.new((v1.Position:Lerp(
                                v2.Position,
                                (TweenService:GetValue(u68, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)) * u70.MouthPull
                            )) + u51 * (1 - Value))) * Rotation
                            local u87 = math.lerp(
                                u40.StartScale,
                                u40.FitScale,
                                (TweenService:GetValue(u68, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                            )
                            local v3 = u40
                            local Model_2 = v3.Model
                            Model_2:ScaleTo(u87)
                            Model_2:PivotTo(u73 * (CFrame.new(-v3.CenterOffset * (u87 / v3.StartScale))))
                            if not a2.IsPlaying then
                                u69:Disconnect()
                                local u111 = u40
                                local u112 = a1
                                local u113 = u28
                                local u114 = u66
                                local Model = u111.Model
                                local u116 = 0
                                local u117 = nil
                                RunService.PreRender:Connect(function(a1) -- Line: 1184
                                    -- upvalues: u116 (ref), u70 (upval), Model (val), u112 (val)
                                    -- upvalues: getAnimatedWorldCFrame (upval), u113 (val), u114 (val), u73 (val)
                                    -- upvalues: TweenService (upval), u111 (val), u87 (val), u117 (ref)
                                    local v1
                                    u116 = math.min(u116 + a1, u70.SwallowSeconds)
                                    local v2 = true
                                    if Model.Parent ~= nil then
                                        v2 = u112.Parent == nil
                                    end
                                    if not v2 then
                                        v1 = getAnimatedWorldCFrame(u113)
                                        local Position_2 = if v1 == nil then u73.Position else v1.Position + ((u112:GetPivot()):VectorToWorldSpace(u114)) * (u70.SwallowDepth * u112:GetScale())
                                        v1 = TweenService:GetValue(u116 / u70.SwallowSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                                        local v3 = u111
                                        local v4 = (CFrame.new(u73.Position:Lerp(Position_2, v1))) * u73.Rotation
                                        local v5 = math.max(u70.MinScale, (math.lerp(u87, u87 * u70.SwallowScale, v1)))
                                        local Model_2 = v3.Model
                                        Model_2:ScaleTo(v5)
                                        Model_2:PivotTo(v4 * (CFrame.new(-v3.CenterOffset * (v5 / v3.StartScale))))
                                    end
                                    if v2 then
                                        u117:Disconnect()
                                        Model:Destroy()
                                    else
                                        v1 = u116
                                        if u70.SwallowSeconds <= v1 then
                                            u117:Disconnect()
                                            Model:Destroy()
                                        end
                                    end
                                end)
                            end
                            return
                        end
                        return
                    end
                    u69:Disconnect()
                    u7:Destroy()
                end)
                return
            end
            u7:Destroy()
        end

        local function pulseMonsterScale(a1) -- Line: 1369
            -- upvalues: runMotion (val), TweenService (upval)
            local Scale = a1:GetScale()
            runMotion(0.12, function(a1_2) -- Line: 1371 -- upvalues: a1 (val), TweenService (upval), Scale (val) -- types: a1_2: number
                if a1.Parent == nil then
                    return true
                end
                local Value = TweenService:GetValue(a1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                a1:ScaleTo((math.lerp(Scale, Scale * 1.08, Value)))
                return nil
            end)
            if a1.Parent == nil then
                return
            end
            runMotion(0.4, function(a1_2) -- Line: 1386 -- upvalues: a1 (val), TweenService (upval), Scale (val) -- types: a1_2: number
                if a1.Parent == nil then
                    return true
                end
                local Value = TweenService:GetValue(a1_2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
                a1:ScaleTo((math.lerp(Scale * 1.08, Scale, Value)))
                return nil
            end)
            if a1.Parent then
                a1:ScaleTo(Scale)
            end
        end

        local u99 = {}
        local u100 = 0
        local u101 = 0

        local function wrapAngle(a1) -- Line: 1427 -- types: a1: number
            return (a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
        end

        local function getMonsterRestCFrame(a1) -- Line: 1431 -- upvalues: u99 (val) -- types: a1: userdata
            local v1 = u99[a1]
            if v1 ~= nil then
                return v1
            end
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                return nil
            end
            u99[a1] = PrimaryPart.CFrame
            return PrimaryPart.CFrame
        end

        local function applyFacingYaw(a1, a2) -- Line: 1446 -- upvalues: u99 (val) -- types: a1: userdata, a2: number
            local CFrame_2
            local PrimaryPart = a1.PrimaryPart
            local v1 = u99[a1]
            if v1 == nil then
                local PrimaryPart_2 = a1.PrimaryPart
                if PrimaryPart_2 ~= nil then
                    u99[a1] = PrimaryPart_2.CFrame
                    CFrame_2 = PrimaryPart_2.CFrame
                else
                    CFrame_2 = nil
                end
            else
                CFrame_2 = v1
            end
            if PrimaryPart ~= nil and CFrame_2 ~= nil then
                PrimaryPart.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, a2, 0)
                return
            end
        end

        local function adoptMonsterFacing(a1) -- Line: 1456 -- upvalues: u99 (val), u100 (ref) -- types: a1: userdata
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                return
            end
            u99[a1] = PrimaryPart.CFrame
            local v1 = math.abs(u100)
            if v1 > 0.001 then
                local CFrame_2
                v1 = u100
                local PrimaryPart_2 = a1.PrimaryPart
                local v2 = u99[a1]
                if v2 == nil then
                    local PrimaryPart_3 = a1.PrimaryPart
                    if PrimaryPart_3 ~= nil then
                        u99[a1] = PrimaryPart_3.CFrame
                        CFrame_2 = PrimaryPart_3.CFrame
                    else
                        CFrame_2 = nil
                    end
                else
                    CFrame_2 = v2
                end
                if PrimaryPart_2 ~= nil then
                    if CFrame_2 == nil then
                        return
                    end
                    PrimaryPart_2.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, v1, 0)
                end
            end
        end

        local function holdMonsterFacing(a1, a2, a3) -- Line: 1467
            -- upvalues: u100 (ref), u99 (val)
            local CFrame_2
            local v1 = math.min(a3 * 16, 1)
            u100 = u100 + ((a2 - u100 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v1
            local v2 = u100
            local PrimaryPart = a1.PrimaryPart
            local v3 = u99[a1]
            if v3 == nil then
                local PrimaryPart_2 = a1.PrimaryPart
                if PrimaryPart_2 ~= nil then
                    u99[a1] = PrimaryPart_2.CFrame
                    CFrame_2 = PrimaryPart_2.CFrame
                else
                    CFrame_2 = nil
                end
            else
                CFrame_2 = v3
            end
            if PrimaryPart ~= nil then
                if CFrame_2 == nil then
                    return
                end
                PrimaryPart.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, v2, 0)
            end
        end

        local function releaseMonsterFacing() -- Line: 1477
            -- upvalues: u101 (ref), u100 (ref), runMotion (val), TweenService (upval), u16 (ref), u99 (val)
            u101 = u101 + 1
            local u2 = u101
            local u3 = u100
            if (math.abs(u3)) < 0.001 then
                u100 = 0
                return
            end
            runMotion(0.45, function(a1) -- Line: 1485
                -- upvalues: u101 (upval), u2 (val), TweenService (upval), u100 (upval), u3 (val), u16 (upval)
                -- upvalues: u99 (upval)
                if u101 ~= u2 then
                    return true
                end
                u100 = u3 * (1 - (TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))
                local v1 = u16
                if v1 ~= nil and v1.Parent ~= nil then
                    local CFrame_2
                    local v2 = u100
                    local PrimaryPart = v1.PrimaryPart
                    local v3 = u99[v1]
                    if v3 == nil then
                        local PrimaryPart_2 = v1.PrimaryPart
                        if PrimaryPart_2 ~= nil then
                            u99[v1] = PrimaryPart_2.CFrame
                            CFrame_2 = PrimaryPart_2.CFrame
                        else
                            CFrame_2 = nil
                        end
                    else
                        CFrame_2 = v3
                    end
                    if PrimaryPart ~= nil and CFrame_2 ~= nil then
                        PrimaryPart.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, v2, 0)
                    end
                end
                return nil
            end)
            if u101 ~= u2 then
                return
            end
            u100 = 0
            local v1 = u16
            if v1 ~= nil and v1.Parent ~= nil then
                local CFrame_2
                local PrimaryPart = v1.PrimaryPart
                local v2 = u99[v1]
                if v2 == nil then
                    local PrimaryPart_2 = v1.PrimaryPart
                    if PrimaryPart_2 ~= nil then
                        u99[v1] = PrimaryPart_2.CFrame
                        CFrame_2 = PrimaryPart_2.CFrame
                    else
                        CFrame_2 = nil
                    end
                else
                    CFrame_2 = v2
                end
                if PrimaryPart ~= nil then
                    if CFrame_2 == nil then
                        return
                    end
                    PrimaryPart.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, 0, 0)
                end
            end
        end

        local function playYankAnimation(a1) -- Line: 1512
            -- upvalues: u35 (ref), u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref), MonsterParasite (upval)
            -- upvalues: loadAnimationTrack (val), playSound (val), animateEggYank (val), Trove (upval), u15 (val)
            -- upvalues: u101 (ref), RunService (upval), getEquippedEggTool (val), u99 (val), u100 (ref)
            -- upvalues: animateEggGrab (val), playAnimationAndWait (val)
            local v1
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                v1 = u35
                u35 = nil
                if v1 ~= nil then
                    v1:Disconnect()
                end
                local u7 = u36
                u36 = nil
                if u7 ~= nil then
                    u7:Stop(u70.HandPoseReleaseSeconds)
                    task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u7 (val)
                        u7:Destroy()
                    end)
                end
                if u32 ~= nil then
                    u32:Destroy()
                    u32 = nil
                end
                u34 = nil
                u33 = nil
                return
            end
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            local v2 = if typeof(Attribute) == "number" then Attribute else nil
            v1 = if v2 ~= nil then MonsterParasite.MonsterAnimationIdsByIndex[v2] else nil
            local u49 = if not v1 then nil else loadAnimationTrack(a1, v1.Yank)
            if u49 == nil then
                playSound(MonsterParasite.YankSoundName, PrimaryPart)
                animateEggYank(a1)
                return
            end
            v1 = Trove.new()
            v1:Add(u49)
            v1:Add(function() -- Line: 1530 -- upvalues: a1 (val), u15 (upval)
                if a1.Parent then
                    local v1 = a1
                    local v2 = u15[v1]
                    if v2 and v1.Parent and not v2.IsPlaying then
                        v2:Play(0.1)
                    end
                end
            end)
            u101 = u101 + 1
            v1:Connect(RunService.RenderStepped, function(a1_2) -- Line: 1538
                -- upvalues: a1 (val), getEquippedEggTool (upval), u99 (upval), u100 (upval)
                local CFrame_2, CFrame_3, v1, v2, v3
                if a1.Parent == nil then
                    return
                end
                local v4 = getEquippedEggTool()
                local Handle = if not v4 then nil else v4:FindFirstChild("Handle")
                if (if not Handle then nil else if not Handle:IsA("BasePart") then nil else Handle) == nil then
                    return
                end
                local v5 = a1
                local v6 = u99[v5]
                if v6 == nil then
                    local PrimaryPart = v5.PrimaryPart
                    if PrimaryPart ~= nil then
                        u99[v5] = PrimaryPart.CFrame
                        CFrame_2 = PrimaryPart.CFrame
                    else
                        CFrame_2 = nil
                    end
                else
                    CFrame_2 = v6
                end
                if CFrame_2 == nil then
                    return
                end
                v5 = Vector3.new(v1.Position.X, CFrame_2.Position.Y, v1.Position.Z)
                if (v5 - CFrame_2.Position).Magnitude <= 0.001 then
                    return
                end
                _, v2 = CFrame_2:ToOrientation()
                _, v3 = CFrame.lookAt(CFrame_2.Position, v5):ToOrientation()
                local v7 = a1
                local v8 = (v3 - v2 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                local v9 = math.min(a1_2 * 16, 1)
                u100 = u100 + ((v8 - u100 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v9
                local v10 = u100
                local PrimaryPart_2 = v7.PrimaryPart
                v5 = u99[v7]
                if v5 == nil then
                    local PrimaryPart_3 = v7.PrimaryPart
                    if PrimaryPart_3 ~= nil then
                        u99[v7] = PrimaryPart_3.CFrame
                        CFrame_3 = PrimaryPart_3.CFrame
                    else
                        CFrame_3 = nil
                    end
                else
                    CFrame_3 = v5
                end
                if PrimaryPart_2 ~= nil then
                    if CFrame_3 == nil then
                        return
                    end
                    PrimaryPart_2.CFrame = CFrame_3 * CFrame.fromEulerAnglesYXZ(0, v10, 0)
                end
            end)
            local u83 = false
            v1:Connect(u49:GetMarkerReachedSignal(MonsterParasite.GrabMarkerName), function() -- Line: 1567 -- upvalues: u83 (ref), a1 (val), animateEggGrab (upval), u49 (val)
                if u83 then
                    return
                end
                u83 = true
                if a1.Parent ~= nil then
                    animateEggGrab(a1, u49)
                end
            end)
            local v3 = u15[a1]
            if v3 and v3.IsPlaying then
                v3:Stop(0.1)
            end
            playSound(MonsterParasite.YankSoundName, PrimaryPart)
            u49.Looped = false
            u49.Priority = Enum.AnimationPriority.Action4
            playAnimationAndWait(u49, a1, nil)
            if not u83 then
                warn((("[MonsterParasite] Yank animation did not reach the %* marker"):format(MonsterParasite.GrabMarkerName)))
                if not u83 and a1.Parent ~= nil then
                    animateEggGrab(a1, u49)
                end
            end
            v1:Destroy()
        end

        local function emitEnergyBurst(a1, a2) -- Line: 1599
            -- upvalues: resolveVfxTemplate (val), MonsterParasite (upval), Emit (upval)
            local v1 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
            if v1 == nil then
                return
            end
            local v2 = v1:Clone()
            v2.Parent = a1
            a2:Add(v2)
            Emit(v2)
        end

        local function animateMonsterRoar(a1, a2) -- Line: 1610
            -- upvalues: RunService (upval), MonsterParasite (upval)
            local Pivot = a1:GetPivot()
            local u5 = 0
            local u6 = nil
            u6 = (RunService.PreRender:Connect(function(a1_2) -- Line: 1614
                -- upvalues: a1 (val), u6 (ref), u5 (ref), MonsterParasite (upval), Pivot (val)
                if a1.Parent == nil then
                    u6:Disconnect()
                    return
                end
                u5 = math.min(u5 + a1_2, MonsterParasite.RoarDuration)
                local v1 = u5 / MonsterParasite.RoarDuration
                local v2 = math.sin(v1 * 3.141592653589793)
                local v3 = math.sin(v1 * 3.141592653589793 * 3) * 0.15707963267948966 * v2
                a1:PivotTo(Pivot * CFrame.new(0, math.sin(v1 * 3.141592653589793) * 0.4, 0) * (CFrame.Angles(v3, 0, v3 * -0.35)))
                if v1 >= 1 then
                    a1:PivotTo(Pivot)
                    u6:Disconnect()
                end
            end))
            a2:Add(u6)
        end

        local function upAlignedCFrame(a1, a2) -- Line: 1641 -- types: a1: vector, a2: vector
            local Unit, Unit_2
            local v1 = (if not (0.99 < (math.abs((if not (0.001 < a2.Magnitude) then Vector3.new(0, 1, 0) else a2.Unit).Y))) then Vector3.new(0, 1, 0) else Vector3.new(1, 0, 0)):Cross(Unit)
            return CFrame.fromMatrix(a1, Unit_2, Unit, -(Unit:Cross(if not (0.001 < v1.Magnitude) then Vector3.new(1, 0, 0) else v1.Unit)).Unit)
        end

        local function resolveImpactParticles() -- Line: 1655
            -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval)
            local v1
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Particles = if not Assets then nil else Assets:FindFirstChild("Particles")
            if (if not Particles then nil else Particles:FindFirstChild(MonsterParasite.GroundHitParticlesName)) == nil then
                return nil
            end
            local v2 = v1:IsA("ParticleEmitter") or v1:FindFirstChildWhichIsA("ParticleEmitter", true) ~= nil
            if v2 then
                return v1
            end
            return nil
        end

        local function emitGroundHit(a1) -- Line: 1669
            -- upvalues: resolveImpactParticles (val), Workspace (upval), PlayVFX (upval), Debris (upval)
            local v1 = resolveImpactParticles()
            if v1 == nil then
                return
            end
            local Part = Instance.new("Part")
            Part.Name = "MonsterChestGroundHit"
            Part.Size = Vector3.new(1, 1, 1)
            Part.CFrame = a1
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            Part.Transparency = 1
            local Transient = Workspace:FindFirstChild("Transient")
            Part.Parent = if not Transient then Workspace else if not Transient:IsA("Folder") then Workspace else Transient
            local v2 = v1:Clone()
            local success = pcall(PlayVFX, Part, a1, v2)
            if not success then
                v2:Destroy()
            end
            Debris:AddItem(Part, 3)
        end

        local function shakeCamera(a1, a2) -- Line: 1697
            -- upvalues: Workspace (upval), MonsterParasite (upval), u39 (val)
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera == nil then
                return
            end
            local ChestImpactShakeRange = MonsterParasite.ChestImpactShakeRange
            local Magnitude = (CurrentCamera.CFrame.Position - a1).Magnitude
            if ChestImpactShakeRange <= Magnitude then
                return
            end
            u39:ShakeOnce(
                a2 * (1 - Magnitude / ChestImpactShakeRange),
                MonsterParasite.ChestImpactShakeRoughness,
                MonsterParasite.ChestImpactShakeFadeIn,
                MonsterParasite.ChestImpactShakeFadeOut
            )
        end

        local function animateChestLaunch(a1, a2) -- Line: 1715
            -- upvalues: getAnimatedWorldCFrame (val), createChest (val), MonsterParasite (upval)
            -- upvalues: resolveGroundLanding (val), runMotion (val), TweenService (upval), playSound (val)
            -- upvalues: emitGroundHit (val), upAlignedCFrame (val), Workspace (upval), u39 (val), u17 (ref)
            local Unit_2, v1
            local PrimaryPart = a1.PrimaryPart
            assert(PrimaryPart ~= nil, "Monster model requires a PrimaryPart")
            local CFrame = getAnimatedWorldCFrame(a2) or PrimaryPart.CFrame
            local u18 = createChest(CFrame)
            if u18 == nil then
                return
            end
            local Scale = u18:GetScale()
            local u24 = Scale * MonsterParasite.ChestLaunchStartScale
            local v2, v3 = resolveGroundLanding(a1, CFrame)
            local Position_3 = v2.Position
            u18:PivotTo(v2)
            local BoundingBox, BoundingBox_2 = u18:GetBoundingBox()
            local v4 = v2 + Vector3.new(0, 1, 0) * (Position_3.Y - (BoundingBox.Position.Y - BoundingBox_2.Y * 0.5))
            u18:PivotTo(CFrame)
            u18:ScaleTo(u24)
            local Position = CFrame.Position
            local Position_2 = v4.Position
            v2 = (Position_2 - Position) * Vector3.new(1, 0, 1)
            if not (0.001 < v2.Magnitude) then
                v1 = a1:GetPivot().LookVector * Vector3.new(1, 0, 1)
                if v1.Magnitude < 0.05 then
                    v1 = CFrame.LookVector * Vector3.new(1, 0, 1)
                end
                Unit_2 = if not (0.001 < v1.Magnitude) then Vector3.new(0, 0, -1) else v1.Unit
            else
                Unit_2 = v2.Unit
            end
            v1 = (math.max(Position.Y, Position_2.Y)) + MonsterParasite.ChestLaunchHeight
            local v5 = v2.Magnitude * 0.55
            local u115 = (Vector3.new(Position.X + Unit_2.X * v5, v1 * 2 - (Position.Y + Position_2.Y) * 0.5, Position.Z + Unit_2.Z * v5))

            local function curve(a1) -- Line: 1757
                -- upvalues: Position (val), u115 (val), Position_2 (val)
                return (Position:Lerp(u115, a1)):Lerp(u115:Lerp(Position_2, a1), a1)
            end

            local v6 = Vector3.new(0, 1, 0):Cross(Unit_2)
            local Unit = if not (0.001 < v6.Magnitude) then Vector3.new(1, 0, 0) else v6.Unit
            local u129 = MonsterParasite.ChestLaunchSpins * 3.141592653589793 * 2
            local Rotation = CFrame.Rotation
            local Rotation_2 = v4.Rotation
            runMotion(MonsterParasite.ChestLaunchDuration, function(a1) -- Line: 1771
                -- upvalues: u18 (val), TweenService (upval), curve (val), Unit (ref), u129 (val), Rotation (val)
                -- upvalues: Rotation_2 (val), u24 (val), Scale (val)
                if u18.Parent == nil then
                    return true
                end
                local Value = TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                u18:PivotTo((CFrame.new(curve(a1))) * CFrame.fromAxisAngle(Unit, u129 * Value) * (Rotation:Lerp(Rotation_2, Value)))
                u18:ScaleTo((math.lerp(u24, Scale, a1)))
                return nil
            end)
            if u18.Parent == nil then
                return
            end
            u18:ScaleTo(Scale)
            u18:PivotTo(v4)
            local v7 = u18.PrimaryPart or PrimaryPart
            playSound(MonsterParasite.ChestLandingSoundName, v7)
            emitGroundHit(upAlignedCFrame(Position_3, v3))
            local ChestImpactShakeMagnitude = MonsterParasite.ChestImpactShakeMagnitude
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil then
                local ChestImpactShakeRange = MonsterParasite.ChestImpactShakeRange
                local Magnitude = (CurrentCamera.CFrame.Position - Position_3).Magnitude
                if not (ChestImpactShakeRange <= Magnitude) then
                    u39:ShakeOnce(
                        ChestImpactShakeMagnitude * (1 - Magnitude / ChestImpactShakeRange),
                        MonsterParasite.ChestImpactShakeRoughness,
                        MonsterParasite.ChestImpactShakeFadeIn,
                        MonsterParasite.ChestImpactShakeFadeOut
                    )
                end
            end
            runMotion(MonsterParasite.ChestBounceDuration, function(a1) -- Line: 1804
                -- upvalues: u17 (upval), u18 (val), MonsterParasite (upval), Position_2 (val), Rotation_2 (val)
                if u17 ~= u18 then
                    return true
                end
                local v1 = 1 - a1
                local v2 = math.sin(a1 * 3.141592653589793) * v1 * MonsterParasite.ChestBounceHeight
                local v3 = math.sin(a1 * 3.141592653589793 * 4) * v1 * 0.20943951023931956
                u18:PivotTo((CFrame.new(Position_2 + Vector3.new(0, 1, 0) * v2)) * Rotation_2 * (CFrame.Angles(0, 0, v3)))
                return nil
            end)
            if u18.Parent then
                u18:PivotTo(v4)
            end
            task.wait(MonsterParasite.ChestGroundRestDuration)
        end

        local function arcApex(a1, a2) -- Line: 1834
            -- upvalues: MonsterParasite (upval)
            local v1 = (math.clamp((a2 - a1).Magnitude * 0.6, 2, 36)) + MonsterParasite.ChestPickupRise
            return (a1:Lerp(a2, 0.5)) + Vector3.new(0, 1, 0) * v1
        end

        local function animateChestPickup(a1) -- Line: 1840
            -- upvalues: LocalPlayer (val), Fader (val), u70 (val), runMotion (val), MonsterParasite (upval)
            -- upvalues: TweenService (upval)
            local Character = LocalPlayer.Character
            local PrimaryPart = if not Character then nil else Character.PrimaryPart
            if PrimaryPart == nil then
                return
            end
            local u10 = a1:GetPivot()
            local Position = u10.Position
            local Scale = a1:GetScale()
            local u16 = Fader()
            local u24 = math.max(u70.PickupFadeEnd - u70.PickupFadeStart, 0.001)
            runMotion(MonsterParasite.ChestPickupDuration, function(a1_2) -- Line: 1853
                -- upvalues: a1 (val), PrimaryPart (val), u70 (upval), Position (val), MonsterParasite (upval)
                -- upvalues: TweenService (upval), u10 (val), u24 (val), u16 (val), Scale (val)
                if a1.Parent == nil then
                    return true
                end
                local v1 = PrimaryPart.Position + Vector3.new(0, 1, 0) * u70.PickupTargetHeight
                local v2 = Position
                local v3 = (math.clamp((v1 - v2).Magnitude * 0.6, 2, 36)) + MonsterParasite.ChestPickupRise
                local v4 = (v2:Lerp(v1, 0.5)) + Vector3.new(0, 1, 0) * v3
                local Value = TweenService:GetValue(a1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                v4 = (Position:Lerp(v4, Value)):Lerp(v4:Lerp(v1, Value), Value)
                v3 = Vector3.new(v1.X, v4.Y, v1.Z)
                a1:PivotTo(if not ((v4 - v3).Magnitude < 0.001) then CFrame.lookAt(v4, v3) else (CFrame.new(v4)) * u10.Rotation)
                local Value_2 = TweenService:GetValue(
                    math.clamp((a1_2 - u70.PickupFadeStart) / u24, 0, 1),
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.In
                )
                u16:Hide(a1, Value_2)
                a1:ScaleTo((math.max(u70.PickupMinScale, Scale * (1 - Value_2))))
                return nil
            end)
        end

        local function playBurpAnimation(a1, a2, a3) -- Line: 1894
            -- upvalues: MonsterParasite (upval), loadAnimationTrack (val), playSound (val), Trove (upval), u15 (val)
            -- upvalues: playAnimationAndWait (val), Timer (upval)
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            local v1 = if typeof(Attribute) == "number" then Attribute else nil
            local v2 = if v1 ~= nil then MonsterParasite.MonsterAnimationIdsByIndex[v1] else nil
            local Burp = if not v2 then nil else v2.Burp
            local u30 = if not Burp then nil else loadAnimationTrack(a1, Burp)
            local u31 = false
            if u30 == nil then
                if not u31 then
                    playSound(MonsterParasite.BurpSoundName, a2)
                    a3()
                end
                task.wait(MonsterParasite.BurpBeatDuration)
                return
            end
            local u56 = Trove.new()
            u56:Add(u30)
            u56:Add(function() -- Line: 1921 -- upvalues: a1 (val), u15 (upval)
                if a1.Parent then
                    local v1 = a1
                    local v2 = u15[v1]
                    if v2 and v1.Parent and not v2.IsPlaying then
                        v2:Play(0.1)
                    end
                end
            end)
            u56:Connect(u30:GetMarkerReachedSignal(MonsterParasite.BurpMarkerName), function() -- Line: 1905 -- upvalues: u31 (ref), playSound (upval), MonsterParasite (upval), a2 (val), a3 (val)
                if u31 then
                    return
                end
                u31 = true
                playSound(MonsterParasite.BurpSoundName, a2)
                a3()
            end)
            local v3 = u15[a1]
            if v3 and v3.IsPlaying then
                v3:Stop(0.1)
            end
            u30.Looped = false
            u30.Priority = Enum.AnimationPriority.Action3
            playAnimationAndWait(u30, a1, function() -- Line: 1939
                -- upvalues: MonsterParasite (upval), u30 (val), u56 (val), Timer (upval), u31 (ref), playSound (upval)
                -- upvalues: a2 (val), a3 (val)
                local ChestLaunchBeatFallback = MonsterParasite.ChestLaunchBeatFallback
                if 0 < u30.Length then
                    ChestLaunchBeatFallback = math.min(ChestLaunchBeatFallback, (math.max(u30.Length - 0.1, 0.05)))
                end
                u56:Add((Timer.Simple(ChestLaunchBeatFallback, function() -- Line: 1946 -- upvalues: u31 (upval), MonsterParasite (upval), playSound (upval), a2 (upval), a3 (upval)
                    if u31 then
                        return
                    end
                    warn((("[MonsterParasite] Burp animation did not reach the %* marker"):format(MonsterParasite.BurpMarkerName)))
                    if u31 then
                        return
                    end
                    u31 = true
                    playSound(MonsterParasite.BurpSoundName, a2)
                    a3()
                end)))
            end)
            if not u31 then
                playSound(MonsterParasite.BurpSoundName, a2)
                a3()
            end
            u56:Destroy()
        end

        local function animateFullCharge(a1) -- Line: 1961
            -- upvalues: resolveChestOrigin (val), Trove (upval), u18 (ref), MonsterParasite (upval)
            -- upvalues: animateChestLaunch (val), playSound (val), resolveVfxTemplate (val), Emit (upval)
            -- upvalues: RunService (upval), playBurpAnimation (val)
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                return false
            end
            local u6 = resolveChestOrigin(a1) or PrimaryPart
            local u9 = Trove.new()
            u18 = a1
            u9:Add(function() -- Line: 1969 -- upvalues: u18 (upval), a1 (val)
                if u18 == a1 then
                    u18 = nil
                end
            end)
            local u14 = nil
            local u15 = false
            playBurpAnimation(a1, u6, function() -- Line: 1976
                -- upvalues: u14 (ref), MonsterParasite (upval), animateChestLaunch (upval), a1 (val), u6 (val)
                -- upvalues: u15 (ref), playSound (upval), PrimaryPart (val), u9 (val), resolveVfxTemplate (upval)
                -- upvalues: Emit (upval), RunService (upval)
                task.spawn(function() -- Line: 1981
                    -- upvalues: MonsterParasite (upval), animateChestLaunch (upval), a1 (upval), u6 (upval)
                    -- upvalues: u15 (upval)
                    if 0 < MonsterParasite.ChestLaunchDelay then
                        task.wait(MonsterParasite.ChestLaunchDelay)
                    end
                    local success, err = pcall(animateChestLaunch, a1, u6)
                    u15 = true
                    if not success then
                        warn((("[MonsterParasite] Chest launch failed: %*"):format(err)))
                    end
                end)
                local success, err = pcall(function() -- Line: 1991
                    -- upvalues: playSound (upval), MonsterParasite (upval), PrimaryPart (upval), u6 (upval), u9 (upval)
                    -- upvalues: resolveVfxTemplate (upval), Emit (upval), a1 (upval), RunService (upval)
                    playSound(MonsterParasite.RoarSoundName, PrimaryPart)
                    playSound(MonsterParasite.EnergyBurstSoundName, u6)
                    local v1 = u6
                    local v2 = u9
                    local v3 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
                    if v3 ~= nil then
                        local v4 = v3:Clone()
                        v4.Parent = v1
                        v2:Add(v4)
                        Emit(v4)
                    end
                    local u26 = a1
                    v2 = u9
                    local Pivot = u26:GetPivot()
                    local u31 = 0
                    local u32 = nil
                    u32 = (RunService.PreRender:Connect(function(a1) -- Line: 1614
                        -- upvalues: u26 (val), u32 (ref), u31 (ref), MonsterParasite (upval), Pivot (val)
                        if u26.Parent == nil then
                            u32:Disconnect()
                            return
                        end
                        u31 = math.min(u31 + a1, MonsterParasite.RoarDuration)
                        local v1 = u31 / MonsterParasite.RoarDuration
                        local v2 = math.sin(v1 * 3.141592653589793)
                        local v3 = math.sin(v1 * 3.141592653589793 * 3) * 0.15707963267948966 * v2
                        u26:PivotTo(Pivot * CFrame.new(0, math.sin(v1 * 3.141592653589793) * 0.4, 0) * (CFrame.Angles(v3, 0, v3 * -0.35)))
                        if v1 >= 1 then
                            u26:PivotTo(Pivot)
                            u32:Disconnect()
                        end
                    end))
                    v2:Add(u32)
                end)
                if not success then
                    warn((("[MonsterParasite] Full charge dressing failed: %*"):format(err)))
                end
            end)
            while u14 ~= nil do
                if u15 or coroutine.status(u14) == "dead" then
                    break
                end
                task.wait()
            end
            u9:Destroy()
            return u15
        end

        local function getPrompt(a1) -- Line: 2015 -- upvalues: u16 (ref) -- types: a1: string
            local v1 = u16
            if v1 == nil then
                return nil
            end
            local v2 = v1:FindFirstChild(a1, true)
            if v2 and v2:IsA("ProximityPrompt") then
                return v2
            end
            return nil
        end

        local function setPromptEnabled(a1, a2) -- Line: 2024 -- types: a1: userdata?, a2: boolean
            if a1 and a1.Enabled ~= a2 then
                a1.Enabled = a2
            end
        end

        local function isHoldingParasiteEgg() -- Line: 2030
            -- upvalues: LocalPlayer (val), Save (upval), EggToolDisplay (upval)
            local Character = LocalPlayer.Character
            local v1 = Save.Await()
            if Character ~= nil and v1 ~= nil then
                local v2, v3
                for i, j in Character:GetChildren() do
                    if j:IsA("Tool") and EggToolDisplay.IsEggTool(j) then
                        v2 = EggToolDisplay.GetToolUid(j)
                        v3 = if not v2 then nil else v1.EggInventory[v2]
                        if v3 ~= nil and v3.HasParasite == true then
                            return true
                        end
                    end
                end
                return false
            end
            return false
        end

        local function refreshPrompts() -- Line: 2048
            -- upvalues: MonsterParasite (upval), u16 (ref), MonsterParasite_2 (upval), u25 (ref), u23 (ref), u24 (ref)
            -- upvalues: u26 (ref), u29 (ref), u22 (ref), isHoldingParasiteEgg (val)
            local v1, v2, v3, v4, v5, v6
            local v7 = u16
            if v7 ~= nil then
                v3 = v7:FindFirstChild(MonsterParasite.TalkPromptName, true)
                v1 = if not v3 then nil else if not v3:IsA("ProximityPrompt") then nil else v3
            else
                v1 = nil
            end
            v3 = u16
            if v3 ~= nil then
                v4 = v3:FindFirstChild(MonsterParasite.FeedPromptName, true)
                v2 = if not v4 then nil else if not v4:IsA("ProximityPrompt") then nil else v4
            else
                v2 = nil
            end
            v4 = u16
            if v4 ~= nil then
                v5 = v4:FindFirstChild(MonsterParasite.ChestPromptName, true)
                v7 = if not v5 then nil else if not v5:IsA("ProximityPrompt") then nil else v5
            else
                v7 = nil
            end
            v5 = u16
            if v5 ~= nil then
                v6 = v5:FindFirstChild(MonsterParasite_2.ViewRewardsPromptName, true)
                v3 = if not v6 then nil else if not v6:IsA("ProximityPrompt") then nil else v6
            else
                v3 = nil
            end
            v4 = u25 or u23 or u24 or u26 or u29 > 0
            v5 = u22 and not v4 and isHoldingParasiteEgg()
            v6 = not v5 and not v4
            if v2 and v2.Enabled ~= v5 then
                v2.Enabled = v5
            end
            if v7 and v7.Enabled ~= false then
                v7.Enabled = false
            end
            if v1 and v1.Enabled ~= v6 then
                v1.Enabled = v6
            end
            local v8 = not v4
            if v3 and v3.Enabled ~= v8 then
                v3.Enabled = v8
            end
        end

        local function renderState() -- Line: 2066 -- upvalues: u21 (ref), u29 (ref), u17 (ref), refreshPrompts (val)
            if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                u17:Destroy()
                u17 = nil
            end
            refreshPrompts()
        end

        local function storeState(a1) -- Line: 2073 -- upvalues: u21 (ref), u16 (ref)
            table.clone(a1)
            if u16 then
                u16:SetAttribute("Charge", a1.Charge)
                u16:SetAttribute("PendingChests", a1.PendingChests)
            end
        end

        local function applyState(a1) -- Line: 2083
            -- upvalues: u21 (ref), MonsterParasite (upval), u16 (ref), u29 (ref), u30 (ref), refreshPrompts (val)
            -- upvalues: u25 (ref), u26 (ref), u17 (ref)
            local v1 = false
            local PendingChests = a1.PendingChests
            if u21.PendingChests < PendingChests then
                v1 = false
                if a1.Charge < u21.Charge then
                    local v2 = u21.Charge + MonsterParasite.ChargePerFeed
                    v1 = MonsterParasite.MaxCharge <= v2
                end
            end
            u21 = table.clone(a1)
            if u16 then
                u16:SetAttribute("Charge", a1.Charge)
                u16:SetAttribute("PendingChests", a1.PendingChests)
            end
            if v1 then
                u29 = u29 + 1
                u30 = u30 + 1
                refreshPrompts()
                return
            end
            if not u25 and u29 <= 0 and not u26 then
                if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                    u17:Destroy()
                    u17 = nil
                end
                refreshPrompts()
            end
        end

        local function showError(a1) -- Line: 2105 -- upvalues: Message (upval) -- types: a1: string
            task.spawn(Message.Warn, a1)
        end

        local function acknowledgeChest(a1) -- Line: 2109
            -- upvalues: MonsterParasite_3 (val), MonsterParasite_2 (upval)
            local err, success
            local Message = nil
            for i = 1, 3 do
                success, err = pcall(function() -- Line: 2112 -- upvalues: MonsterParasite_3 (upval), a1 (val)
                    return MonsterParasite_3.AskChestRevealComplete:InvokeServer(a1)
                end)
                if success and MonsterParasite_2.RevealResultSchema(err) then
                    if err.Success then
                        return true, nil
                    end
                    Message = err.Message
                    if i < 3 then
                        task.wait(0.4)
                    end
                    continue
                end
                Message = if not success then tostring(err) else "The reward confirmation was invalid."
                if i < 3 then
                    task.wait(0.4)
                end
            end
            return false, Message
        end

        local function beginChestReveal(a1) -- Line: 2133
            -- upvalues: u26 (ref), u21 (ref), u29 (ref), u17 (ref), refreshPrompts (val), Message (upval), u27 (ref)
            -- upvalues: u28 (ref), LocalPlayer (val), u16 (ref), playSound (val), MonsterParasite (upval)
            -- upvalues: CrateOpeningSpinner (upval), acknowledgeChest (val)
            local OpeningId = a1.OpeningId
            if OpeningId ~= nil and a1.Reward ~= nil then
                if u27 ~= OpeningId and u28 ~= OpeningId then
                    if u27 ~= nil then
                        return
                    end
                    u27 = OpeningId
                    u26 = true
                    refreshPrompts()
                    local Character = LocalPlayer.Character
                    local PrimaryPart = if not Character then nil else Character.PrimaryPart
                    local v1 = u17
                    local v2 = u16
                    local PrimaryPart_2 = if not v1 then if not PrimaryPart then if not v2 then nil else v2.PrimaryPart else PrimaryPart else if not v1.PrimaryPart then if not PrimaryPart then if not v2 then nil else v2.PrimaryPart else PrimaryPart else v1.PrimaryPart
                    if PrimaryPart_2 then
                        playSound(MonsterParasite.ChestSoundName, PrimaryPart_2)
                    end
                    if u17 then
                        u17:Destroy()
                        u17 = nil
                    end
                    task.spawn(function() -- Line: 2166
                        -- upvalues: CrateOpeningSpinner (upval), a1 (val), acknowledgeChest (upval), OpeningId (val)
                        -- upvalues: Message (upval), u28 (upval), u27 (upval), u26 (upval), u21 (upval)
                        -- upvalues: refreshPrompts (upval), u29 (upval), u17 (upval)
                        local success, err = pcall(CrateOpeningSpinner.Play, a1)
                        if not success then
                            warn((("[MonsterParasite] Crate opening presentation failed: %*"):format(err)))
                        end
                        local v1, v2 = acknowledgeChest(OpeningId)
                        if not v1 then
                            task.spawn(Message.Warn, v2 or "The Monster Chest reveal is still finishing.")
                        end
                        u28 = OpeningId
                        u27 = nil
                        u26 = false
                        u21.PendingChests = a1.PendingChests or 0
                        refreshPrompts()
                        if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                            u17:Destroy()
                            u17 = nil
                        end
                        refreshPrompts()
                    end)
                    return
                end
                return
            end
            u26 = false
            if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                u17:Destroy()
                u17 = nil
            end
            refreshPrompts()
            task.spawn(Message.Warn, "The Monster Chest reward was invalid.")
        end

        local function requestFeed() -- Line: 2192
            -- upvalues: u22 (ref), Message (upval), u23 (ref), u25 (ref), u24 (ref), u29 (ref), u26 (ref), u27 (ref)
            -- upvalues: refreshPrompts (val), captureEquippedEgg (val), MonsterParasite_3 (val)
            -- upvalues: MonsterParasite_2 (upval), u35 (ref), u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref)
            if not u22 then
                task.spawn(Message.Warn, "The Monster Parasite event is not active.")
                return
            end
            if not u23 and not u25 and not u24 and not (u29 > 0) and not u26 and u27 == nil then
                u23 = true
                refreshPrompts()
                captureEquippedEgg()
                task.spawn(function() -- Line: 2213
                    -- upvalues: MonsterParasite_3 (upval), MonsterParasite_2 (upval), u23 (upval)
                    -- upvalues: refreshPrompts (upval), u35 (upval), u36 (upval), u70 (upval), u32 (upval), u34 (upval)
                    -- upvalues: u33 (upval), Message (upval)
                    local success, err = pcall(function() -- Line: 2214 -- upvalues: MonsterParasite_3 (upval)
                        return MonsterParasite_3.AskFeed:InvokeServer()
                    end)
                    if success and MonsterParasite_2.FeedResultSchema(err) then
                        if not err.Success then
                            u23 = false
                            refreshPrompts()
                            local v1 = u35
                            u35 = nil
                            if v1 ~= nil then
                                v1:Disconnect()
                            end
                            local u17 = u36
                            u36 = nil
                            if u17 ~= nil then
                                u17:Stop(u70.HandPoseReleaseSeconds)
                                task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u17 (val)
                                    u17:Destroy()
                                end)
                            end
                            if u32 ~= nil then
                                u32:Destroy()
                                u32 = nil
                            end
                            u34 = nil
                            u33 = nil
                            local Message_2 = err.Message
                            task.spawn(Message.Warn, Message_2)
                        end
                        return
                    end
                    u23 = false
                    refreshPrompts()
                    local v2 = u35
                    u35 = nil
                    if v2 ~= nil then
                        v2:Disconnect()
                    end
                    local u54 = u36
                    u36 = nil
                    if u54 ~= nil then
                        u54:Stop(u70.HandPoseReleaseSeconds)
                        task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u54 (val)
                            u54:Destroy()
                        end)
                    end
                    if u32 ~= nil then
                        u32:Destroy()
                        u32 = nil
                    end
                    u34 = nil
                    u33 = nil
                    v2 = if not success then tostring(err) else "The monster did not understand that request."
                    task.spawn(Message.Warn, v2)
                end)
                return
            end
        end

        local function requestChest() -- Line: 2238
            -- upvalues: u24 (ref), u23 (ref), u25 (ref), u29 (ref), u26 (ref), u27 (ref), refreshPrompts (val)
            -- upvalues: HttpService (upval), MonsterParasite_3 (val), MonsterParasite_2 (upval), u28 (ref), u21 (ref)
            -- upvalues: u17 (ref), Message (upval), beginChestReveal (val)
            if not u24 and not u23 and not u25 and not (u29 > 0) and not u26 and u27 == nil then
                u24 = true
                u26 = true
                refreshPrompts()
                local u15 = HttpService:GenerateGUID(false)
                task.spawn(function() -- Line: 2253
                    -- upvalues: MonsterParasite_3 (upval), u15 (val), MonsterParasite_2 (upval), u27 (upval)
                    -- upvalues: u28 (upval), u24 (upval), refreshPrompts (upval), u26 (upval), u21 (upval), u29 (upval)
                    -- upvalues: u17 (upval), Message (upval), beginChestReveal (upval)
                    local err, success
                    local v1 = nil
                    local v2 = nil
                    for i = 1, 3 do
                        success, err = pcall(function() -- Line: 2257 -- upvalues: MonsterParasite_3 (upval), u15 (upval)
                            local v1 = u15
                            return MonsterParasite_3.AskChestClaim:InvokeServer(v1)
                        end)
                        if success and MonsterParasite_2.ChestResultSchema(err) then
                            v1 = err
                            if err.Success
                                or err.Message ~= "Another Monster Parasite action is still finishing."
                                or u27 == u15
                                or u28 == u15 then
                                break
                            end
                            if i < 3 then
                                task.wait(0.4)
                            end
                            continue
                        end
                        v2 = if not success then tostring(err) else "The Monster Chest could not be opened."
                        if u27 == u15 or u28 == u15 then
                            break
                        end
                        if i < 3 then
                            task.wait(0.4)
                        end
                    end
                    u24 = false
                    refreshPrompts()
                    if u27 ~= u15 and u28 ~= u15 then
                        if v1 == nil then
                            u26 = false
                            if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                                u17:Destroy()
                                u17 = nil
                            end
                            refreshPrompts()
                            task.spawn(Message.Warn, v2 or "The Monster Chest could not be opened.")
                            return
                        end
                        v2 = v1
                        if v2.Success then
                            beginChestReveal(v2)
                            return
                        end
                        if u27 == nil then
                            u26 = false
                            if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                                u17:Destroy()
                                u17 = nil
                            end
                            refreshPrompts()
                            local Message_2 = v2.Message
                            task.spawn(Message.Warn, Message_2)
                        end
                        return
                    end
                end)
                return
            end
        end

        local function requestTakeChest() -- Line: 2312
            -- upvalues: MonsterParasite_3 (val), MonsterParasite_2 (upval), Message (upval), u17 (ref)
            local success, err = pcall(function() -- Line: 2313 -- upvalues: MonsterParasite_3 (upval)
                return MonsterParasite_3.AskChestTake:InvokeServer()
            end)
            if success and MonsterParasite_2.TakeResultSchema(err) then
                if not err.Success then
                    local Message_2 = err.Message
                    task.spawn(Message.Warn, Message_2)
                    return
                end
                if u17 then
                    u17:Destroy()
                    u17 = nil
                end
                return
            end
            local v1 = if not success then tostring(err) else "The Monster Chest could not be picked up."
            task.spawn(Message.Warn, v1)
        end

        local function deliverChestTool() -- Line: 2332
            -- upvalues: u17 (ref), animateChestPickup (val), requestTakeChest (val)
            local v1 = u17
            if v1 and v1.Parent then
                animateChestPickup(v1)
            end
            requestTakeChest()
        end

        local function isChestTool(a1) -- Line: 2340 -- upvalues: MonsterParasite (upval) -- types: a1: userdata
            return (a1:GetAttribute("ItemType")) == MonsterParasite.ChestToolItemType
        end

        local function bindChestTool(a1) -- Line: 2344 -- upvalues: u13 (val), requestChest (val) -- types: a1: userdata
            u13:Connect(a1.Activated, requestChest)
        end

        local u136 = {
            Accessor = "MonsterChestRewards",
            PlateDim = 0.36,
            PanelAspect = 1.18,
            MaxRowAspect = 6,
            MinRowHeight = 30,
            RowGapFraction = 0.09,
            PadXFraction = 0.012,
            PadYFraction = 0.012,
            RowPadFraction = 0.11,
            SlotGapFraction = 0.3,
            PillHeightFraction = 0.52,
            PillPadFraction = 0.34,
            GlowScale = 1.15,
            IconScale = 0.76,
            NameTextCap = 0.44,
            ChanceTextCap = 0.34,
            NoteTextCap = 0.28,
            PillCharWidth = 0.62,
            NoteCharWidth = 0.62,
            FlowSeconds = 6,
            RainbowHueSpan = 0.3,
            RarityGradients = {["BEST REWARD"] = "Prismatic"},
        }
        u136.ScrollerSize = Vector2.new(0.972, 0.862)
        u136.ScrollerCenter = Vector2.new(0.5, 0.5465)
        u136.Cards = {}
        u136.Flowing = {}

        local function dimColor(a1, a2) -- Line: 2433 -- types: a1: userdata, a2: number
            return Color3.new(a1.R * a2, a1.G * a2, a1.B * a2)
        end

        local function sampleStops(a1, a2) -- Line: 2439 -- types: a1: table, a2: number
            local Value, Value_2, v1, v2, v3
            local v4 = #a1 - 1
            local v5 = a2
            for i = 1, v4 do
                v1 = a1[i]
                v2 = a1[i + 1]
                if v1.Time <= v5 and v5 <= v2.Time then
                    v3 = v2.Time - v1.Time
                    Value_2 = v1.Value
                    Value = v2.Value
                    return Value_2:Lerp(Value, if not (v3 <= 0) then (v5 - v1.Time) / v3 else 0)
                end
            end
            return a1[#a1].Value
        end

        local function rolledPalette(a1, a2) -- Line: 2454
            -- upvalues: sampleStops (val)
            local v1
            local v2 = sampleStops(a1, -a2 % 1)
            local v3 = {ColorSequenceKeypoint.new(0, v2)}
            local v4 = #a1 - 1
            local v5, v6 = a1, a2
            for i = 1, v4 do
                v1 = (v5[i].Time + v6) % 1
                if v1 > 0 and v1 < 1 then
                    table.insert(v3, (ColorSequenceKeypoint.new(v1, v5[i].Value)))
                end
            end
            table.sort(v3, function(a1, a2) -- Line: 2465
                return a1.Time < a2.Time
            end)
            table.insert(v3, (ColorSequenceKeypoint.new(1, v2)))
            return ColorSequence.new(v3)
        end

        local function isRainbow(a1) -- Line: 2475 -- upvalues: u136 (val) -- types: a1: userdata
            local v1
            local Keypoints = a1.Color.Keypoints
            local Value = Keypoints[1].Value
            local Value_2 = Keypoints[#Keypoints].Value
            if (math.abs(Value.R - Value_2.R)) + math.abs(Value.G - Value_2.G) + math.abs(Value.B - Value_2.B) > 0.02 then
                return false
            end
            local v2 = 1
            local v3 = 0
            for i, j in Keypoints do
                v1 = Color3.toHSV(j.Value)
                v2 = math.min(v2, v1)
                v3 = math.max(v3, v1)
            end
            return u136.RainbowHueSpan <= v3 - v2
        end

        local function paintRewardCard(a1, a2) -- Line: 2494
            -- upvalues: dimColor (val), u136 (val), isRainbow (val)
            local Keypoints = a2.Color.Keypoints
            local v1 = table.create(#Keypoints)
            for i, j in Keypoints do
                v1[i] = (ColorSequenceKeypoint.new(j.Time, dimColor(j.Value, u136.PlateDim)))
            end
            local UIGradient = a1:FindFirstChildOfClass("UIGradient")
            if UIGradient ~= nil then
                UIGradient.Color = ColorSequence.new(v1)
                UIGradient.Rotation = if not isRainbow(a2) then 90 else 0
            end
            local Value = Keypoints[1].Value
            a1.UIStrokeClr.Color = Value
            a1.Glow.ImageColor3 = Value
            if UIGradient ~= nil and isRainbow(a2) then
                table.insert(u136.Flowing, {
                    Plate = UIGradient,
                    Rim = a1.UIStrokeClr,
                    Glow = a1.Glow,
                    Dimmed = v1,
                    Bright = Keypoints,
                })
            end
        end

        local function startRewardFlow(a1) -- Line: 2530
            -- upvalues: u136 (val), RunService (upval), rolledPalette (val), sampleStops (val)
            if u136.Motion ~= nil then
                u136.Motion:Disconnect()
                u136.Motion = nil
            end
            if #u136.Flowing == 0 then
                return
            end
            u136.Motion = RunService.RenderStepped:Connect(function() -- Line: 2539 -- upvalues: a1 (val), u136 (upval), rolledPalette (upval), sampleStops (upval)
                local v1
                if not a1.Enabled then
                    if u136.Motion ~= nil then
                        u136.Motion:Disconnect()
                        u136.Motion = nil
                    end
                    return
                end
                local v2 = os.clock() % u136.FlowSeconds / u136.FlowSeconds
                for i, j in u136.Flowing do
                    j.Plate.Color = rolledPalette(j.Dimmed, v2)
                    v1 = sampleStops(j.Bright, -v2 % 1)
                    j.Rim.Color = v1
                    j.Glow.ImageColor3 = v1
                end
            end)
        end

        local function buildRewardRow(a1) -- Line: 2563
            local Frame = Instance.new("Frame")
            Frame.Name = "Slot"
            Frame.AnchorPoint = Vector2.new(0, 0.5)
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BackgroundTransparency = 0.55
            Frame.ZIndex = 2
            Frame.Parent = a1
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0.16, 0)
            UICorner.Parent = Frame
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Color = Color3.fromHex("#131624")
            UIStroke.Thickness = 2
            UIStroke.Parent = Frame
            a1.Glow.AnchorPoint = Vector2.new(0.5, 0.5)
            a1.Glow.Position = UDim2.fromScale(0.5, 0.5)
            a1.Glow.ZIndex = 3
            a1.Glow.Parent = Frame
            a1.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
            a1.Icon.Position = UDim2.fromScale(0.5, 0.5)
            a1.Icon.ZIndex = 4
            a1.Icon.Parent = Frame
            a1.RewardName.AnchorPoint = Vector2.new(0, 0.5)
            a1.RewardName.TextXAlignment = Enum.TextXAlignment.Left
            a1.Note.AnchorPoint = Vector2.new(0, 0.5)
            a1.Note.TextXAlignment = Enum.TextXAlignment.Left
            a1.Chance.AnchorPoint = Vector2.new(0, 0.5)
            local UICorner_2 = a1.Chance:FindFirstChildOfClass("UICorner")
            if UICorner_2 == nil then
                UICorner_2 = Instance.new("UICorner")
                UICorner_2.Parent = a1.Chance
            end
            UICorner_2.CornerRadius = UDim.new(0.5, 0)
            a1.Chance.BackgroundColor3 = Color3.fromHex("#1B1B24")
            a1.Chance.BackgroundTransparency = 0
            a1.Chance.ZIndex = 2
            local UIStroke_2 = a1.Chance:FindFirstChildOfClass("UIStroke")
            if UIStroke_2 == nil then
                UIStroke_2 = Instance.new("UIStroke")
                UIStroke_2.Parent = a1.Chance
            end
            UIStroke_2.Color = Color3.fromHex("#131624")
            UIStroke_2.Thickness = 2
            a1.Chance.Value.TextColor3 = Color3.new(1, 1, 1)
            a1.Chance.Value.ZIndex = 3
        end

        local function layoutRewardCards(a1) -- Line: 2630 -- upvalues: u136 (val)
            local AbsoluteSize = a1.AbsoluteSize
            local v1 = #u136.Cards
            if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) and v1 ~= 0 then
                local Slot, v2, v3, v4
                local v5 = math.round(AbsoluteSize.X * u136.PadXFraction)
                local v6 = math.round(AbsoluteSize.Y * u136.PadYFraction)
                local v7 = AbsoluteSize.X - v5 * 2
                local v8 = AbsoluteSize.Y - v6 * 2
                local v9 = math.floor((math.clamp(v8 / (v1 + (v1 - 1) * u136.RowGapFraction), u136.MinRowHeight, v7 / u136.MaxRowAspect)))
                local v10 = math.round(v9 * u136.RowGapFraction)
                local v11 = v9 * v1 + v10 * (v1 - 1)
                a1.ScrollingEnabled = v8 < v11
                a1.AutomaticCanvasSize = Enum.AutomaticSize.None
                local v12 = if not v1 then UDim2.new() else UDim2.fromOffset(0, v11 + v6 * 2)
                a1.CanvasSize = v12
                v12 = if not v1 then v6 + (v8 - v11) / 2 else v6
                v11 = math.max(1, (math.round(v9 * u136.NameTextCap)))
                v8 = math.max(1, (math.round(v9 * u136.ChanceTextCap)))
                v6 = math.max(1, (math.round(v9 * u136.NoteTextCap)))
                local TextSize = a1.Template.Note.TextSize
                local v13 = math.round(v9 * u136.RowPadFraction)
                local v14 = v9 - v13 * 2
                local v15 = math.round(v14 * u136.GlowScale)
                local v16 = math.round(v14 * u136.IconScale)
                local v17 = math.round(v9 * u136.PillHeightFraction)
                local v18 = math.round(v9 * u136.PillPadFraction)
                local v19 = nil
                local v20 = nil
                for i, j in u136.Cards, v19, v20 do
                    j.AnchorPoint = Vector2.new(0, 0)
                    j.Size = UDim2.fromOffset(v7, v9)
                    j.Position = UDim2.fromOffset(v5, v12 + (i - 1) * (v9 + v10))
                    Slot = j.Slot
                    Slot.Size = UDim2.fromOffset(v14, v14)
                    Slot.Position = UDim2.fromOffset(v13, v9 / 2)
                    Slot.Glow.Size = UDim2.fromOffset(v15, v15)
                    Slot.Icon.Size = UDim2.fromOffset(v16, v16)
                    v2 = math.round(#j.Chance.Value.Text * v8 * u136.PillCharWidth + v18 * 2)
                    j.Chance.Size = UDim2.fromOffset(v2, v17)
                    j.Chance.Position = UDim2.fromOffset(v7 - v13 - v2, v9 / 2)
                    v3 = v13 + v14 + math.round(v9 * u136.SlotGapFraction)
                    v4 = v7 - v13 * 2 - v2 - v3
                    if not j.Note.Visible then
                        j.RewardName.Size = UDim2.fromOffset(v4, (math.round(v9 * 0.56)))
                        j.RewardName.Position = UDim2.fromOffset(v3, v9 / 2)
                    else
                        j.RewardName.Size = UDim2.fromOffset(v4, (math.round(v9 * 0.42)))
                        j.RewardName.Position = UDim2.fromOffset(v3, (math.round(v9 * 0.36)))
                        j.Note.Size = UDim2.fromOffset(v4, (math.round(v9 * 0.26)))
                        j.Note.Position = UDim2.fromOffset(v3, (math.round(v9 * 0.71)))
                        v2 = #j.Note.Text * TextSize * u136.NoteCharWidth
                        j.Note.TextSize = if not (v4 < v2) then TextSize else math.max(1, (math.floor(TextSize * v4 / v2)))
                    end
                    j.RewardName.UITextSizeConstraint.MaxTextSize = v11
                    j.Chance.Value.UITextSizeConstraint.MaxTextSize = v8
                    j.Note.UITextSizeConstraint.MaxTextSize = v6
                end
                return
            end
        end

        local function renderRewardsPanel() -- Line: 2724
            -- upvalues: GUI (upval), u136 (val), MonsterParasite (upval), Rarities (upval), paintRewardCard (val)
            -- upvalues: buildRewardRow (val), layoutRewardCards (val), startRewardFlow (val)
            local DisplayNote, Icon, Icon_2, Rarity, v1, v2, v3
            local v4 = GUI.Get(u136.Accessor)
            local ScrollingFrame = v4.Frame.ScrollingFrame
            local UIGridLayout = ScrollingFrame:FindFirstChildOfClass("UIGridLayout")
            if UIGridLayout ~= nil then
                UIGridLayout:Destroy()
            end
            local UIAspectRatioConstraint = v4.Frame:FindFirstChildOfClass("UIAspectRatioConstraint")
            if UIAspectRatioConstraint ~= nil then
                UIAspectRatioConstraint.AspectRatio = u136.PanelAspect
            end
            ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ScrollingFrame.Size = UDim2.fromScale(u136.ScrollerSize.X, u136.ScrollerSize.Y)
            ScrollingFrame.Position = UDim2.fromScale(u136.ScrollerCenter.X, u136.ScrollerCenter.Y)
            local Template = ScrollingFrame.Template
            for i, j in ScrollingFrame:GetChildren() do
                if j:IsA("GuiObject") and j ~= Template then
                    j:Destroy()
                end
            end
            table.clear(u136.Cards)
            table.clear(u136.Flowing)
            local v5 = 0
            for k, n in MonsterParasite.Rewards do
                v5 = v5 + MonsterParasite.GetRewardWeight(n.Id)
            end
            local v6 = nil
            local v7 = nil
            for m, i5 in MonsterParasite.Rewards, v6, v7 do
                v3 = Template:Clone()
                v3.Name = ("Reward_%*"):format(i5.Id)
                v3.LayoutOrder = m
                v3.Visible = true
                v3.RewardName.Text = string.upper(i5.DisplayName)
                Icon = v3.Icon
                Icon_2 = i5.Icon or Template:GetAttribute("FallbackIcon")
                Icon.Image = Icon_2
                DisplayNote = i5.DisplayNote
                v3.Note.Visible = DisplayNote ~= nil
                if DisplayNote ~= nil then
                    v3.Note.Text = string.upper(DisplayNote)
                end
                v1 = math.floor((MonsterParasite.GetRewardWeight(i5.Id)) / v5 * 100 * 10 + 0.5) / 10
                v3.Chance.Value.Text = ("%*%%"):format(v1)
                v2 = Rarities
                Rarity = u136.RarityGradients[i5.Rarity] or i5.Rarity
                v1 = v2[Rarity]
                if v1 ~= nil and v1.RarityGradient ~= nil then
                    paintRewardCard(v3, v1.RarityGradient)
                end
                buildRewardRow(v3)
                table.insert(u136.Cards, v3)
                v3.Parent = ScrollingFrame
            end
            if u136.Sizing ~= nil then
                u136.Sizing:Disconnect()
            end
            u136.Sizing = (ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 2800 -- upvalues: layoutRewardCards (upval), ScrollingFrame (val)
                layoutRewardCards(ScrollingFrame)
            end)
            layoutRewardCards(ScrollingFrame)
            startRewardFlow(v4)
        end

        local u158 = {}

        local function hideTutorial() -- Line: 2814 -- upvalues: u158 (val)
            local Gui = u158.Gui
            if Gui ~= nil and Gui.Enabled then
                Gui.Enabled = false
                local Release = u158.Release
                u158.Release = nil
                if Release ~= nil then
                    Release()
                end
                return
            end
        end

        local function showTutorial() -- Line: 2828
            -- upvalues: u158 (val), GUI (upval), hideTutorial (val), ButtonFX (upval), HiddenUIHandler (upval)
            local Gui = u158.Gui
            if Gui == nil then
                Gui = GUI.MonsterEventTutorialFrame()
                local MonsterEventTutorialFrame = Gui.MonsterEventTutorialFrame
                assert(MonsterEventTutorialFrame:IsA("Frame"), "MonsterEventTutorialFrame.MonsterEventTutorialFrame must be a Frame")
                local Ok = MonsterEventTutorialFrame.Ok
                assert(Ok:IsA("ImageButton"), "MonsterEventTutorialFrame.Ok must be an ImageButton")
                GUI.OnActivated(Ok, hideTutorial)
                ButtonFX(Ok)
                u158.Gui = Gui
            end
            if Gui.Enabled then
                return
            end
            u158.Release = HiddenUIHandler.Acquire()
            Gui.Enabled = true
        end

        local function bindPrompt(a1, a2) -- Line: 2852
            -- upvalues: MonsterParasite (upval), showTutorial (val), requestFeed (val), MonsterParasite_2 (upval)
            -- upvalues: renderRewardsPanel (val), Tabs (upval), u136 (val), refreshPrompts (val)
            if a2.Name == MonsterParasite.TalkPromptName then
                a1:Connect(a2.Triggered, showTutorial)
            elseif a2.Name == MonsterParasite.FeedPromptName then
                a1:Connect(a2.Triggered, requestFeed)
            elseif a2.Name == MonsterParasite_2.ViewRewardsPromptName then
                a1:Connect(a2.Triggered, function() -- Line: 2858 -- upvalues: renderRewardsPanel (upval), Tabs (upval), u136 (upval)
                    renderRewardsPanel()
                    Tabs.Toggle(u136.Accessor)
                end)
            end
            refreshPrompts()
        end

        local function hideModel(a1) -- Line: 2888 -- types: a1: userdata
            for i, j in a1:GetDescendants() do
                if j:IsA("BasePart") then
                    j.LocalTransparencyModifier = 1
                end
            end
        end

        local u163 = {CleanupSeconds = 2, ParticleScale = 2.6, EmitScale = 2.25, SuppressSeconds = 1}
        local u165 = (-1 / 0)

        local function scaleNumberSequence(a1, a2) -- Line: 2938 -- types: a1: userdata, a2: number
            local Time, new, v1
            local v2 = table.create(#a1.Keypoints)
            for i, j in a1.Keypoints do
                new = NumberSequenceKeypoint.new
                Time = j.Time
                v1 = j.Value * a2
                v2[i] = (new(Time, v1, j.Envelope * a2))
            end
            return NumberSequence.new(v2)
        end

        local function isSwapVeilActive() -- Line: 2953 -- upvalues: u165 (ref)
            return os.clock() - u165 < 1
        end

        local function playSwapVeil(a1) -- Line: 2957
            -- upvalues: Workspace (upval), Debris (upval), u165 (ref), resolveVfxTemplate (val)
            -- upvalues: MonsterParasite (upval), scaleNumberSequence (val), Emit (upval)
            if a1 ~= nil and a1.Parent ~= nil then
                local v1
                local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
                local Position = BoundingBox.Position
                local v2 = Instance.new("Part")
                v2.Name = "MonsterSwapVeil"
                v2.Size = Vector3.new(1, 1, 1)
                v2.CFrame = CFrame.new(Position)
                v2.Anchored = true
                v2.CanCollide = false
                v2.CanQuery = false
                v2.CanTouch = false
                v2.CastShadow = false
                v2.Transparency = 1
                local v3 = Workspace:FindFirstChild("Transient")
                v2.Parent = if not v3 then Workspace else if not v3:IsA("Folder") then Workspace else v3
                Debris:AddItem(v2, 2)
                os.clock()
                local v4 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
                if v4 ~= nil then
                    local Attribute, new, v5, v6
                    v1 = v4:Clone()
                    for i, j in v1:GetDescendants() do
                        if j:IsA("ParticleEmitter") then
                            j.Size = scaleNumberSequence(j.Size, 2.6)
                            new = NumberRange.new
                            v5 = j.Speed.Min * 2.6
                            j.Speed = new(v5, j.Speed.Max * 2.6)
                            Attribute = j:GetAttribute("EmitCount")
                            if type(Attribute) == "number" then
                                v6 = math.ceil(Attribute * 2.25)
                                j:SetAttribute("EmitCount", v6)
                            end
                        end
                    end
                    v1.CFrame = CFrame.identity
                    v1.Parent = v2
                    Emit(v1)
                end
                v4 = resolveVfxTemplate(MonsterParasite.SwapPoofVfxName)
                if v4 ~= nil then
                    local new_2, v7
                    v1 = v4:Clone()
                    local v8 = math.clamp(math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z) / 8.4, 0.7, 2.2)
                    for k, n in v1:GetDescendants() do
                        if n:IsA("ParticleEmitter") then
                            n.Size = scaleNumberSequence(n.Size, v8)
                            new_2 = NumberRange.new
                            v7 = n.Speed.Min * v8
                            n.Speed = new_2(v7, n.Speed.Max * v8)
                            n.Acceleration = n.Acceleration * v8
                            n.ZOffset = n.ZOffset * v8
                        end
                    end
                    v1.CFrame = CFrame.identity
                    v1.Parent = v2
                    Emit(v1)
                end
                return
            end
        end

        local function isRetiring(a1) -- Line: 3036 -- upvalues: MonsterParasite (upval) -- types: a1: userdata
            return a1:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true
        end

        local u170 = {FadeSeconds = 0.35, Alpha = 1, Lit = false}
        u170.Path = {"Stands", "Pads", MonsterParasite.PadName}
        local v1 = Workspace
        for i, j in u170.Path do
            v1 = if v1 == nil then nil else v1:FindFirstChild(j)
        end
        if v1 ~= nil then
            local v2 = Fader()
            v2:Hide(v1, 1)
            u170.Instance = v1
            u170.Dim = v2
        end

        local function refreshPad() -- Line: 3083
            -- upvalues: u170 (val), u16 (ref), MonsterParasite (upval), RunService (upval), TweenService (upval)
            local Instance = u170.Instance
            local Dim = u170.Dim
            if Instance ~= nil and Dim ~= nil then
                local v1
                local v2 = u16
                if v2 == nil then
                    v1 = false
                else
                    v1 = false
                    if v2.Parent ~= nil then
                        v1 = not (v2:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true)
                    end
                end
                if v1 == u170.Lit then
                    return
                end
                u170.Lit = v1
                local Step = u170.Step
                if Step ~= nil then
                    Step:Disconnect()
                    u170.Step = nil
                end
                local Alpha = u170.Alpha
                local u32 = if not v1 then 1 else 0
                local u33 = 0
                local u34 = nil
                u34 = RunService.PreRender:Connect(function(a1) -- Line: 3106
                    -- upvalues: u33 (ref), u170 (upval), TweenService (upval), Alpha (val), u32 (val), Dim (val)
                    -- upvalues: Instance (val), u34 (ref)
                    u33 = math.min(u33 + a1, u170.FadeSeconds)
                    local Value = TweenService:GetValue(u33 / u170.FadeSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    u170.Alpha = Alpha + (u32 - Alpha) * Value
                    Dim:Hide(Instance, u170.Alpha)
                    local v1 = u33
                    if u170.FadeSeconds <= v1 then
                        u34:Disconnect()
                        u170.Alpha = u32
                        Dim:Hide(Instance, u32)
                        u170.Step = nil
                    end
                end)
                u170.Step = u34
                return
            end
        end

        local u201 = {}
        u201.Arrow = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
        u201.Zones = require(ReplicatedStorage.Client.WorldFX.Pads)
        u201.Pointer = nil
        u201.Step = nil
        u201.Dim = nil
        u201.Surface = nil
        u201.Origin = nil
        u201.Alpha = 1
        u201.Fading = false
        u201.Shown = false
        u201.Retired = false
        u201.PollSeconds = 0.2
        u201.FadeSeconds = 0.35
        u201.Config = {
            ProximityThreshold = 5,
            Radius = 5,
            Amplitude = 2,
            Color = MonsterParasite.ParasiteHighlightColor,
        }

        function u201.Finished() -- Line: 3180 -- upvalues: u201 (val), Save (upval), u21 (ref)
            if u201.Retired then
                return true
            end
            local v1 = Save.Await()
            local MonsterParasite = if v1 == nil then nil else v1.MonsterParasite
            if 0 < (if MonsterParasite == nil then 0 else MonsterParasite.TotalFeeds) or 0 < u21.TotalFeeds then
                u201.Retired = true
            end
            return u201.Retired
        end

        function u201.Root() -- Line: 3193 -- upvalues: LocalPlayer (val)
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end

        function u201.Wanted() -- Line: 3201 -- upvalues: u170 (val), u201 (val), u25 (ref), isHoldingParasiteEgg (val)
            return u170.Lit and not u201.Shown and not u201.Finished() and not u25 and isHoldingParasiteEgg()
        end

        function u201.Ease(a1, a2) -- Line: 3211
            -- upvalues: u201 (val), RunService (upval), TweenService (upval)
            local Pointer = u201.Pointer
            local Dim = u201.Dim
            if Pointer ~= nil and Dim ~= nil then
                local Step = u201.Step
                if Step ~= nil then
                    Step:Disconnect()
                    u201.Step = nil
                end
                local model = Pointer.model
                local Alpha = u201.Alpha
                local u17 = 0
                local u18 = nil
                u18 = RunService.PreRender:Connect(function(a1_2) -- Line: 3226
                    -- upvalues: u17 (ref), u201 (upval), TweenService (upval), Alpha (val), a1 (val), Dim (val)
                    -- upvalues: model (val), u18 (ref), a2 (val)
                    u17 = math.min(u17 + a1_2, u201.FadeSeconds)
                    local Value = TweenService:GetValue(u17 / u201.FadeSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    u201.Alpha = Alpha + (a1 - Alpha) * Value
                    Dim:Hide(model, u201.Alpha)
                    local v1 = u17
                    if u201.FadeSeconds <= v1 then
                        u18:Disconnect()
                        u201.Alpha = a1
                        Dim:Hide(model, a1)
                        u201.Step = nil
                        if a2 ~= nil then
                            a2()
                        end
                    end
                end)
                u201.Step = u18
                return
            end
        end

        function u201.Raise(a1, a2) -- Line: 3248
            -- upvalues: u201 (val), Fader (val)
            local v1 = u201.Arrow.new(a1, a2, u201.Config)
            u201.Pointer = v1
            u201.Origin = a2
            u201.Dim = Fader()
            u201.Alpha = 1
            u201.Dim:Hide(v1.model, 1)
            v1:Start()
            u201.Ease(0)
        end

        function u201.Drop() -- Line: 3263 -- upvalues: u201 (val)
            local Pointer = u201.Pointer
            if Pointer ~= nil and not u201.Fading then
                u201.Fading = true
                u201.Ease(1, function() -- Line: 3269 -- upvalues: Pointer (val), u201 (upval)
                    Pointer:Destroy()
                    if u201.Pointer == Pointer then
                        u201.Pointer = nil
                        u201.Origin = nil
                        u201.Dim = nil
                    end
                    u201.Fading = false
                end)
                return
            end
        end

        function u201.Refresh() -- Line: 3281 -- upvalues: u201 (val)
            if u201.Fading then
                return
            end
            local v1 = u201.Root()
            local Surface = u201.Surface
            if Surface ~= nil and v1 ~= nil and u201.Wanted() then
                if u201.Pointer == nil then
                    u201.Raise(Surface, v1)
                    return
                end
                if u201.Origin ~= v1 then
                    local Pointer = u201.Pointer
                    Pointer:PointFrom(v1)
                    u201.Origin = v1
                    Pointer:Start()
                end
                return
            end
            u201.Drop()
        end

        function u201.Enter() -- Line: 3306 -- upvalues: u201 (val), showTutorial (val)
            if not u201.Wanted() then
                return
            end
            u201.Shown = true
            showTutorial()
            u201.Drop()
        end

        task.spawn(function() -- Line: 3315 -- upvalues: u170 (val), u201 (val), u10 (val)
            local Instance = u170.Instance
            if Instance ~= nil and Instance:IsA("BasePart") then
                u201.Surface = Instance
                u10:Add((u201.Zones.Track(Instance, {Entered = u201.Enter})))
            end
            while task.wait(u201.PollSeconds) do
                u201.Refresh()
                if u201.Finished() and u201.Pointer == nil and not u201.Fading then
                    break
                end
            end
        end)

        local function bindModel(a1) -- Line: 3335
            -- upvalues: u14 (val), LocalPlayer (val), MonsterParasite (upval), hideModel (val), Trove (upval)
            -- upvalues: u16 (ref), u18 (ref), refreshPad (val), u99 (val), u100 (ref), startIdle (val), u25 (ref)
            -- upvalues: u165 (ref), u163 (val), resolveVfxTemplate (val), Emit (upval), u17 (ref), bindPrompt (val)
            -- upvalues: applyState (val), u21 (ref)
            local v1
            if u14[a1] or a1:GetAttribute("OwnerUserId") == nil then
                return
            end
            if (a1:GetAttribute("OwnerUserId")) ~= LocalPlayer.UserId then
                a1:Destroy()
                return
            end
            if a1:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true then
                hideModel(a1)
                return
            end
            local u30 = Trove.new()
            local v2 = u16
            u14[a1] = u30
            u16 = a1
            if v2 ~= nil and v2 ~= a1 and v2.Parent ~= nil and u18 ~= v2 then
                hideModel(v2)
            end
            u30:Connect(a1:GetAttributeChangedSignal(MonsterParasite.MonsterRetiringAttributeName), function() -- Line: 3383
                -- upvalues: a1 (val), MonsterParasite (upval), refreshPad (upval), u18 (upval), hideModel (upval)
                if not (a1:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true) then
                    return
                end
                task.defer(refreshPad)
                if u18 ~= a1 then
                    hideModel(a1)
                    return
                end
                task.spawn(function() -- Line: 3400 -- upvalues: u18 (upval), a1 (upval), hideModel (upval)
                    while u18 == a1 do
                        if a1.Parent == nil then
                            break
                        end
                        task.wait()
                    end
                    if a1.Parent ~= nil then
                        hideModel(a1)
                    end
                end)
            end)
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart ~= nil then
                u99[a1] = PrimaryPart.CFrame
                local v3 = math.abs(u100)
                if v3 > 0.001 then
                    local CFrame_2
                    v3 = u100
                    local PrimaryPart_2 = a1.PrimaryPart
                    v1 = u99[a1]
                    if v1 == nil then
                        local PrimaryPart_3 = a1.PrimaryPart
                        if PrimaryPart_3 ~= nil then
                            u99[a1] = PrimaryPart_3.CFrame
                            CFrame_2 = PrimaryPart_3.CFrame
                        else
                            CFrame_2 = nil
                        end
                    else
                        CFrame_2 = v1
                    end
                    if PrimaryPart_2 ~= nil and CFrame_2 ~= nil then
                        PrimaryPart_2.CFrame = CFrame_2 * CFrame.fromEulerAnglesYXZ(0, v3, 0)
                    end
                end
            end
            startIdle(a1, u30)
            if u25 and a1.PrimaryPart ~= nil and not (os.clock() - u165 < u163.SuppressSeconds) then
                local PrimaryPart_4 = a1.PrimaryPart
                local v4 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
                if v4 ~= nil then
                    v1 = v4:Clone()
                    v1.Parent = PrimaryPart_4
                    u30:Add(v1)
                    Emit(v1)
                end
            end
            u30:Connect(a1.Destroying, function() -- Line: 3424
                -- upvalues: u14 (upval), a1 (val), u99 (upval), u16 (upval), u17 (upval), refreshPad (upval), u30 (val)
                u14[a1] = nil
                u99[a1] = nil
                if u16 == a1 then
                    u16 = nil
                    if u17 then
                        u17:Destroy()
                        u17 = nil
                    end
                    task.defer(refreshPad)
                end
                u30:Destroy()
            end)
            for i, j in a1:GetDescendants() do
                if j:IsA("ProximityPrompt") then
                    bindPrompt(u30, j)
                end
            end
            u30:Connect(a1.DescendantAdded, function(a1) -- Line: 3439 -- upvalues: bindPrompt (upval), u30 (val) -- types: a1: userdata
                if a1:IsA("ProximityPrompt") then
                    bindPrompt(u30, a1)
                end
            end)
            applyState(u21)
            refreshPad()
        end

        local function inspectInstance(a1) -- Line: 3448 -- upvalues: bindModel (val) -- types: a1: userdata
            if a1:IsA("Model") then
                bindModel(a1)
            end
        end

        local function bindWorldFolder(a1) -- Line: 3454
            -- upvalues: bindModel (val), u10 (val), inspectInstance (val)
            for i, j in a1:GetChildren() do
                if j:IsA("Model") then
                    bindModel(j)
                end
            end
            u10:Connect(a1.ChildAdded, inspectInstance)
        end

        local function markParasiteSwallowed() -- Line: 3473 -- upvalues: LocalPlayer (val), MonsterParasite_2 (upval)
            LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, (os.clock()))
        end

        local function releaseFullChargeModel(a1) -- Line: 3486
            -- upvalues: playSwapVeil (val), MonsterParasite_3 (val)
            playSwapVeil(a1)
            MonsterParasite_3.AskFullChargeReset:FireServer()
        end

        local function isFullChargeResult(a1) -- Line: 3495
            local v1 = a1.PreviousCharge or 0
            return (a1.Charge or 0) < v1
        end

        local function isSculptChange(a1) -- Line: 3507 -- upvalues: MonsterParasite (upval)
            local v1 = MonsterParasite.GetMonsterModelIndex(a1.PreviousCharge or 0)
            return MonsterParasite.GetMonsterModelIndex(a1.Charge or 0) ~= v1
        end

        local function waitForThread(a1) -- Line: 3519 -- types: a1: thread?
            while a1 ~= nil do
                if coroutine.status(a1) == "dead" then
                    break
                end
                task.wait()
            end
        end

        local function getFeedMonster() -- Line: 3527 -- upvalues: u16 (ref)
            local v1
            local v2 = os.clock() + 2
            while true do
                v1 = u16
                if v1 ~= nil then
                    if v1.PrimaryPart ~= nil then
                        return v1
                    end
                end
                task.wait()
                if v2 <= os.clock() then
                    return u16
                end
            end
        end

        local function playFeedSequence(a1) -- Line: 3539
            -- upvalues: getFeedMonster (val), u35 (ref), u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref)
            -- upvalues: LocalPlayer (val), MonsterParasite_2 (upval), MonsterParasite_3 (val), u17 (ref)
            -- upvalues: animateChestPickup (val), requestTakeChest (val), playYankAnimation (val)
            -- upvalues: MonsterParasite (upval), playSound (val), pulseMonsterScale (val), playSwapVeil (val)
            -- upvalues: releaseMonsterFacing (val), waitForThread (val), animateFullCharge (val)
            local v1, v2
            local v3 = getFeedMonster()
            local PrimaryPart = if not v3 then nil else v3.PrimaryPart
            if v3 ~= nil and PrimaryPart ~= nil then
                local v4
                playYankAnimation(v3)
                v1 = v3:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true) or v3:FindFirstChild(MonsterParasite.TongueTipName, true) or PrimaryPart
                playSound(MonsterParasite.ChompSoundName, v1)
                LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, (os.clock()))
                task.wait(u70.ScaleTweenDelaySeconds)
                v1 = nil
                if v3.Parent then
                    v1 = task.spawn(pulseMonsterScale, v3)
                    task.wait(0.12)
                end
                local v5 = MonsterParasite.GetMonsterModelIndex(a1.PreviousCharge or 0)
                if MonsterParasite.GetMonsterModelIndex(a1.Charge or 0) ~= v5 then
                    v4 = a1.PreviousCharge or 0
                    if not ((a1.Charge or 0) < v4) then
                        playSwapVeil(v3)
                    end
                end
                MonsterParasite_3.AskGrowthSwap:FireServer()
                v4 = a1.PreviousCharge or 0
                if not ((a1.Charge or 0) < v4) then
                    releaseMonsterFacing()
                    waitForThread(v1)
                    return
                end
                task.spawn(releaseMonsterFacing)
                task.wait(MonsterParasite.FullChargeHoldDuration)
                v1 = if v3.Parent == nil then getFeedMonster() else v3
                if v1 ~= nil and v1.Parent ~= nil then
                    v1:SetAttribute(MonsterParasite_2.ChargeDrainAttributeName, (os.clock()))
                    task.wait(MonsterParasite_2.ChargeDrainDuration)
                    v2 = if v1.Parent == nil then getFeedMonster() else v1
                    if v2 == nil or v2.Parent == nil then
                        warn("[MonsterParasite] Full charge lost its monster during the drain")
                    elseif not animateFullCharge(v2) then
                        warn("[MonsterParasite] Full charge ended without launching a chest")
                    end
                    playSwapVeil(v2)
                    MonsterParasite_3.AskFullChargeReset:FireServer()
                    v2 = u17
                    if v2 and v2.Parent then
                        animateChestPickup(v2)
                    end
                    requestTakeChest()
                    return
                end
                warn("[MonsterParasite] Full charge had no live monster to burp from")
                MonsterParasite_3.AskFullChargeReset:FireServer()
                v3 = u17
                if v3 and v3.Parent then
                    animateChestPickup(v3)
                end
                requestTakeChest()
                return
            end
            v1 = u35
            u35 = nil
            if v1 ~= nil then
                v1:Disconnect()
            end
            local u185 = u36
            u36 = nil
            if u185 ~= nil then
                u185:Stop(u70.HandPoseReleaseSeconds)
                task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u185 (val)
                    u185:Destroy()
                end)
            end
            if u32 ~= nil then
                u32:Destroy()
                u32 = nil
            end
            u34 = nil
            u33 = nil
            LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, (os.clock()))
            MonsterParasite_3.AskGrowthSwap:FireServer()
            v2 = a1.PreviousCharge or 0
            v1 = (a1.Charge or 0) < v2
            if v1 then
                MonsterParasite_3.AskFullChargeReset:FireServer()
                v1 = u17
                if v1 and v1.Parent then
                    animateChestPickup(v1)
                end
                requestTakeChest()
            end
        end

        local function startFeedSequence() -- Line: 3633
            -- upvalues: u25 (ref), refreshPrompts (val), u31 (val), playFeedSequence (val), u29 (ref), u35 (ref)
            -- upvalues: u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref), LocalPlayer (val)
            -- upvalues: MonsterParasite_2 (upval), releaseMonsterFacing (val), u18 (ref), u16 (ref), playSwapVeil (val)
            -- upvalues: MonsterParasite_3 (val), requestTakeChest (val), u21 (ref), u17 (ref)
            if u25 then
                return
            end
            u25 = true
            refreshPrompts()
            task.spawn(function() -- Line: 3639
                -- upvalues: u31 (upval), playFeedSequence (upval), u29 (upval), u35 (upval), u36 (upval), u70 (upval)
                -- upvalues: u32 (upval), u34 (upval), u33 (upval), LocalPlayer (upval), MonsterParasite_2 (upval)
                -- upvalues: releaseMonsterFacing (upval), u18 (upval), u16 (upval), playSwapVeil (upval)
                -- upvalues: MonsterParasite_3 (upval), requestTakeChest (upval), u25 (upval), u21 (upval), u17 (upval)
                -- upvalues: refreshPrompts (upval)
                local err, success, v1, v2, v3
                while true do
                    if not (#u31 > 0) then
                        break
                    end
                    local u6 = table.remove(u31, 1)
                    assert(u6 ~= nil, "Feed sequence queue changed unexpectedly")
                    v2 = u6.PreviousCharge or 0
                    v1 = (u6.Charge or 0) < v2
                    success, err = pcall(function() -- Line: 3644 -- upvalues: playFeedSequence (upval), u6 (val)
                        playFeedSequence(u6)
                        return true
                    end)
                    if v1 then
                        u29 = math.max(0, u29 - 1)
                    end
                    if not success then
                        v3 = u35
                        u35 = nil
                        if v3 ~= nil then
                            v3:Disconnect()
                        end
                        local u37 = u36
                        u36 = nil
                        if u37 ~= nil then
                            u37:Stop(u70.HandPoseReleaseSeconds)
                            task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u37 (val)
                                u37:Destroy()
                            end)
                        end
                        if u32 ~= nil then
                            u32:Destroy()
                            u32 = nil
                        end
                        u34 = nil
                        u33 = nil
                        LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, (os.clock()))
                        task.spawn(releaseMonsterFacing)
                        u18 = nil
                        warn((("[MonsterParasite] Feed sequence failed: %*"):format(err)))
                        if v1 then
                            playSwapVeil(u16)
                            MonsterParasite_3.AskFullChargeReset:FireServer()
                            requestTakeChest()
                        end
                    end
                end
                u25 = false
                if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                    u17:Destroy()
                    u17 = nil
                end
                refreshPrompts()
            end)
        end

        MonsterParasite_3.StateShifted.OnClientEvent:Connect(function(a1) -- Line: 3677 -- upvalues: MonsterParasite_2 (upval), applyState (val)
            if MonsterParasite_2.StateSchema(a1) then
                applyState(a1)
            end
        end)
        MonsterParasite_3.EventStateShifted.OnClientEvent:Connect(function(a1) -- Line: 3683 -- upvalues: MonsterParasite_2 (upval), u22 (ref), refreshPrompts (val)
            if MonsterParasite_2.EventStateSchema(a1) then
                u22 = a1.Active
                refreshPrompts()
            end
        end)
        MonsterParasite_3.FeedSettled.OnClientEvent:Connect(function(a1) -- Line: 3690
            -- upvalues: MonsterParasite_2 (upval), u23 (ref), captureEquippedEgg (val), u30 (ref), u29 (ref), u21 (ref)
            -- upvalues: u16 (ref), u31 (val), u25 (ref), refreshPrompts (val), playFeedSequence (val), u35 (ref)
            -- upvalues: u36 (ref), u70 (val), u32 (ref), u34 (ref), u33 (ref), LocalPlayer (val)
            -- upvalues: releaseMonsterFacing (val), u18 (ref), playSwapVeil (val), MonsterParasite_3 (val)
            -- upvalues: requestTakeChest (val), u17 (ref)
            if not MonsterParasite_2.FeedResultSchema(a1) then
                return
            end
            u23 = false
            captureEquippedEgg()
            local v1 = a1.PreviousCharge or 0
            if (a1.Charge or 0) < v1 then
                if not (u30 > 0) then
                    u29 = u29 + 1
                else
                    u30 = u30 - 1
                end
            end
            local v2 = {}
            local Charge = if a1.Charge == nil then u21.Charge else a1.Charge
            v2.Charge = Charge
            local PendingChests = if a1.PendingChests == nil then u21.PendingChests else a1.PendingChests
            v2.PendingChests = PendingChests
            v2.TotalFeeds = u21.TotalFeeds
            v2.PendingReward = u21.PendingReward
            u21 = table.clone(v2)
            if u16 then
                u16:SetAttribute("Charge", v2.Charge)
                u16:SetAttribute("PendingChests", v2.PendingChests)
            end
            table.insert(u31, a1)
            if u25 then
                return
            end
            u25 = true
            refreshPrompts()
            task.spawn(function() -- Line: 3639
                -- upvalues: u31 (upval), playFeedSequence (upval), u29 (upval), u35 (upval), u36 (upval), u70 (upval)
                -- upvalues: u32 (upval), u34 (upval), u33 (upval), LocalPlayer (upval), MonsterParasite_2 (upval)
                -- upvalues: releaseMonsterFacing (upval), u18 (upval), u16 (upval), playSwapVeil (upval)
                -- upvalues: MonsterParasite_3 (upval), requestTakeChest (upval), u25 (upval), u21 (upval), u17 (upval)
                -- upvalues: refreshPrompts (upval)
                local err, success, v1, v2, v3
                while true do
                    if not (#u31 > 0) then
                        break
                    end
                    local u6 = table.remove(u31, 1)
                    assert(u6 ~= nil, "Feed sequence queue changed unexpectedly")
                    v2 = u6.PreviousCharge or 0
                    v1 = (u6.Charge or 0) < v2
                    success, err = pcall(function() -- Line: 3644 -- upvalues: playFeedSequence (upval), u6 (val)
                        playFeedSequence(u6)
                        return true
                    end)
                    if v1 then
                        u29 = math.max(0, u29 - 1)
                    end
                    if not success then
                        v3 = u35
                        u35 = nil
                        if v3 ~= nil then
                            v3:Disconnect()
                        end
                        local u37 = u36
                        u36 = nil
                        if u37 ~= nil then
                            u37:Stop(u70.HandPoseReleaseSeconds)
                            task.delay(u70.HandPoseReleaseSeconds, function() -- Line: 1018 -- upvalues: u37 (val)
                                u37:Destroy()
                            end)
                        end
                        if u32 ~= nil then
                            u32:Destroy()
                            u32 = nil
                        end
                        u34 = nil
                        u33 = nil
                        LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, (os.clock()))
                        task.spawn(releaseMonsterFacing)
                        u18 = nil
                        warn((("[MonsterParasite] Feed sequence failed: %*"):format(err)))
                        if v1 then
                            playSwapVeil(u16)
                            MonsterParasite_3.AskFullChargeReset:FireServer()
                            requestTakeChest()
                        end
                    end
                end
                u25 = false
                if u21.PendingChests <= 0 and u29 <= 0 and u17 then
                    u17:Destroy()
                    u17 = nil
                end
                refreshPrompts()
            end)
        end)
        MonsterParasite_3.ChestOpened.OnClientEvent:Connect(function(a1) -- Line: 3718 -- upvalues: MonsterParasite_2 (upval), beginChestReveal (val)
            if not MonsterParasite_2.ChestResultSchema(a1) or not a1.Success then
                return
            end
            beginChestReveal(a1)
        end)
        CameraShakerDriver.Start(u39, Enum.RenderPriority.Camera.Value + 2)
        u10:Add(function() -- Line: 3730 -- upvalues: CameraShakerDriver (upval), u39 (val)
            CameraShakerDriver.Stop(u39)
        end)
        task.spawn(function() -- Line: 184 -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval), ContentProvider (upval)
            local Burp, v1, v2
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Models = if not Assets then nil else Assets:FindFirstChild("Models")
            local u16 = if not Models then nil else Models:FindFirstChild(MonsterParasite.AssetsFolderName)
            if u16 == nil then
                return
            end
            local u136 = {}

            local function enqueueModel(a1) -- Line: 194 -- upvalues: u16 (val), u136 (val) -- types: a1: string
                local v1 = u16:FindFirstChild(a1)
                if v1 == nil then
                    return
                end
                table.insert(u136, v1)
                for i, j in v1:GetDescendants() do
                    if j:IsA("MeshPart") then
                        table.insert(u136, j)
                    end
                end
            end

            for i, j in MonsterParasite.MonsterModelNames do
                enqueueModel(j)
            end
            enqueueModel(MonsterParasite.ChestModelName)
            local v3 = {}
            local v4 = nil
            local v5 = nil
            for k, n in MonsterParasite.MonsterAnimationIdsByIndex, v4, v5 do
                v2 = {n.Idle, n.Yank}
                Burp = n.Burp
                if Burp ~= nil then
                    table.insert(v2, Burp)
                end
                for m, i5 in v2 do
                    v1 = Instance.new("Animation")
                    v1.AnimationId = ("rbxassetid://%*"):format(i5)
                    table.insert(v3, v1)
                    table.insert(u136, v1)
                end
            end
            local Particles = if not Assets then nil else Assets:FindFirstChild("Particles")
            local v6 = if not Particles then nil else Particles:FindFirstChild(MonsterParasite.GroundHitParticlesName)
            if v6 ~= nil then
                table.insert(u136, v6)
            end
            pcall(function() -- Line: 238 -- upvalues: ContentProvider (upval), u136 (val)
                ContentProvider:PreloadAsync(u136)
            end)
            for i6, i7 in v3 do
                i7:Destroy()
            end
        end)
        u10:Connect(Workspace.ChildAdded, function(a1) -- Line: 3461
            -- upvalues: MonsterParasite (upval), bindModel (val), u10 (val), inspectInstance (val)
            if a1.Name == MonsterParasite.WorldFolderName and a1:IsA("Folder") then
                for i, j in a1:GetChildren() do
                    if j:IsA("Model") then
                        bindModel(j)
                    end
                end
                u10:Connect(a1.ChildAdded, inspectInstance)
            end
        end)
        local v3 = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)
        if v3 and v3:IsA("Folder") then
            bindWorldFolder(v3)
        end

        local function bindCharacter(a1) -- Line: 3740
            -- upvalues: u13 (val), refreshPrompts (val), MonsterParasite (upval), requestChest (val)
            local v1
            u13:Clean()
            u13:Connect(a1.ChildAdded, function(a1) -- Line: 3742
                -- upvalues: refreshPrompts (upval), MonsterParasite (upval), u13 (upval), requestChest (upval)
                if a1:IsA("Tool") then
                    refreshPrompts()
                    if (a1:GetAttribute("ItemType")) == MonsterParasite.ChestToolItemType then
                        u13:Connect(a1.Activated, requestChest)
                    end
                end
            end)
            u13:Connect(a1.ChildRemoved, function(a1) -- Line: 3750 -- upvalues: refreshPrompts (upval) -- types: a1: userdata
                if a1:IsA("Tool") then
                    refreshPrompts()
                end
            end)
            for i, j in a1:GetChildren() do
                if j:IsA("Tool") and (j:GetAttribute("ItemType")) == MonsterParasite.ChestToolItemType then
                    v1 = requestChest
                    u13:Connect(j.Activated, v1)
                end
            end
            refreshPrompts()
        end

        u10:Connect(LocalPlayer.CharacterAdded, bindCharacter)
        local Character = LocalPlayer.Character
        if Character then
            bindCharacter(Character)
        end
        u10:Connect(Save.Watch("EggInventory"), refreshPrompts)
        u10:Connect(Save.Watch("MonsterParasite"), refreshPrompts)
        task.spawn(function() -- Line: 3771
            -- upvalues: MonsterParasite_3 (val), MonsterParasite_2 (upval), u22 (ref), applyState (val), u27 (ref)
            -- upvalues: beginChestReveal (val), refreshPrompts (val)
            local success, err = pcall(function() -- Line: 3772 -- upvalues: MonsterParasite_3 (upval)
                return MonsterParasite_3.AskSnapshot:InvokeServer()
            end)
            if success and MonsterParasite_2.SnapshotSchema(err) then
                u22 = err.Event.Active
                applyState(err.State)
                local PendingReward = err.State.PendingReward
                if PendingReward ~= nil and u27 == nil then
                    beginChestReveal({
                        Success = true,
                        Message = ("You received %*!"):format(PendingReward.Reward.DisplayName),
                        OpeningId = PendingReward.OpeningId,
                        Reward = PendingReward.Reward,
                        PendingChests = err.State.PendingChests,
                    })
                end
                refreshPrompts()
                return
            end
        end)
    end,
}