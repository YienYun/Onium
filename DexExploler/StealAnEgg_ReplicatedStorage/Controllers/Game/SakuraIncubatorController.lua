-- Script path: ReplicatedStorage.Controllers.Game.SakuraIncubatorController
-- Decompile time: 43.49 ms

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
require(ReplicatedStorage.Shared.Globals.Constants)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Message = require(ReplicatedStorage.Client.Message)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraFX = require(ReplicatedStorage.Client.SakuraFX)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Sakura_2 = require(ReplicatedStorage.Shared.Types.Sakura)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)
return {
    Start = function() -- Line: 35
        -- upvalues: GameFlags (val), Players (val), Workspace (val), ReplicatedStorage (val), Trove (val), Toast (val)
        -- upvalues: Save (val), Sakura (val), TweenService (val), Tabs (val), Remotes (val), Debris (val), Emit (val)
        -- upvalues: RunService (val), SoundService (val), ContentProvider (val), HiddenUIHandler (val)
        -- upvalues: EggRecords (val), Directory (val), Mutations (val), EggRenderer (val), SakuraFX (val)
        -- upvalues: Message (val), SakuraSignals (val), Sakura_2 (val)
        if not GameFlags.GreatBloomEnabled:Get() then
            return
        end
        local u9 = Color3.fromRGB(255, 120, 200)
        local u14 = Color3.fromRGB(255, 0, 0)
        local u15 = {1.5, 9}
        local u22 = Color3.fromRGB(235, 154, 200)
        local u27 = Color3.fromRGB(255, 200, 232)
        local u32 = Color3.fromRGB(255, 240, 248)
        local LocalPlayer = Players.LocalPlayer
        local CurrentCamera = Workspace.CurrentCamera
        local World = Workspace:WaitForChild("World")
        local Build = World:WaitForChild("Build")
        local u58 = (World:WaitForChild("Areas")):WaitForChild("CherryBlossom"):WaitForChild("IncubatorAnchor")
        assert(u58:IsA("BasePart"), "CherryBlossom.IncubatorAnchor must be a BasePart")
        local Sakura_3 = ReplicatedStorage.Assets.Models.Sakura
        local IncubatorDead = Sakura_3.IncubatorDead
        local IncubatorBloomed = Sakura_3.IncubatorBloomed
        local CraneSign = Sakura_3.CraneSign
        local Cutscene = Sakura_3.Cutscene
        local CameraRig = Cutscene.CameraRig
        local CraneRig = Cutscene.CraneRig
        local PlayerRig = Cutscene.PlayerRig
        local LeafCover = Cutscene.LeafCover
        local LeafRing = Cutscene.LeafRing
        local BlossomEffect = Cutscene.BlossomEffect
        local Floor = Cutscene.Floor
        local u86 = script:WaitForChild("Cutscene")
        assert(u86:IsA("Sound"), "SakuraIncubator.Cutscene must be a Sound")
        assert(BlossomEffect:IsA("BasePart") and Floor:IsA("BasePart"), "Sakura cutscene BlossomEffect and Floor must be BaseParts")
        assert(IncubatorDead.PrimaryPart and IncubatorBloomed.PrimaryPart, "Sakura incubator templates need PrimaryParts")
        assert(CraneSign:IsA("Model") and CraneSign.PrimaryPart, "Sakura.CraneSign must be a Model with a PrimaryPart")
        assert(CameraRig.PrimaryPart and CraneRig.PrimaryPart and PlayerRig.PrimaryPart, "Sakura cutscene rigs need PrimaryParts")
        assert(LeafCover.PrimaryPart, "Sakura cutscene LeafCover needs a PrimaryPart")
        assert(LeafRing.PrimaryPart, "Sakura cutscene LeafRing needs a PrimaryPart")
        local CameraAnimation = CameraRig.CameraAnimation
        local CraneAnimation = CraneRig.CraneAnimation
        local PlayerAnimation = PlayerRig.PlayerAnimation
        assert(
            CameraAnimation:IsA("Animation") and CraneAnimation:IsA("Animation") and PlayerAnimation:IsA("Animation"),
            "Sakura cutscene rigs need their Animation children"
        )
        local IncubatorBillboard = Sakura_3.IncubatorBillboard
        assert(IncubatorBillboard:IsA("BillboardGui"), "Sakura.IncubatorBillboard must be a BillboardGui")
        local u195 = Trove.new()
        local u196 = nil
        local u197 = nil
        local u198 = nil
        local u199 = nil
        local u200 = false
        local refresh = nil

        local function notifyError(a1) -- Line: 135 -- upvalues: Toast (upval), u14 (val) -- types: a1: string
            Toast.Show({Seconds = 3, Text = a1, Color = u14})
        end

        local function isUnlocked() -- Line: 143 -- upvalues: Save (upval)
            local v1 = Save.Await()
            local Unlocked = false
            if v1 ~= nil then
                Unlocked = v1.Sakura.Unlocked
            end
            return Unlocked
        end

        local function spawnVisual(a1, a2) -- Line: 148
            -- upvalues: Workspace (upval)
            local v1 = a1:Clone()
            v1:PivotTo(a2)
            v1.Parent = Workspace
            return v1
        end

        local function rigCFrame(a1) -- Line: 155 -- upvalues: u58 (val) -- types: a1: userdata
            local Attribute = a1:GetAttribute("RootOffset")
            local v1 = ("%* needs a RootOffset CFrame attribute"):format(a1.Name)
            assert(typeof(Attribute) == "CFrame", v1)
            return u58.CFrame * Attribute
        end

        local function makePrompt(a1, a2, a3, a4) -- Line: 161
            -- upvalues: 
            local Attachment = Instance.new("Attachment")
            Attachment.Name = "PromptAttachment"
            Attachment.Position = Vector3.new(0, 3, 0)
            Attachment.Parent = a1
            local ProximityPrompt = Instance.new("ProximityPrompt")
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
            ProximityPrompt.ActionText = a2
            ProximityPrompt.ObjectText = a3
            ProximityPrompt.HoldDuration = 0
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.MaxActivationDistance = a4
            ProximityPrompt.Parent = Attachment
            return ProximityPrompt
        end

        local function getChargePercent() -- Line: 182 -- upvalues: Save (upval), Sakura (upval)
            local v1 = Save.Await()
            if v1 ~= nil and v1.Sakura.Egg ~= false then
                return (Sakura.GetChargePercent(v1.Sakura.Deposited, Sakura.GetRequiredCrystals())), true
            end
            return 0, false
        end

        local function getNextBloomAt(a1) -- Line: 191 -- upvalues: Sakura (upval) -- types: a1: number
            local IntervalSeconds = Sakura.Bloom.IntervalSeconds
            return a1 + IntervalSeconds - (a1 + Sakura.Bloom.OffsetSeconds) % IntervalSeconds
        end

        local function getBloomStatusText() -- Line: 196 -- upvalues: Workspace (upval), Sakura (upval)
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local Attribute = Workspace:GetAttribute(Sakura.Bloom.EndsAtAttribute)
            if typeof(Attribute) == "number" and ServerTimeNow < Attribute then
                return "The Great Bloom is live!"
            end
            local IntervalSeconds = Sakura.Bloom.IntervalSeconds
            local v1 = math.max(0, ServerTimeNow + IntervalSeconds - (ServerTimeNow + Sakura.Bloom.OffsetSeconds) % IntervalSeconds - ServerTimeNow)
            return (("Next Great Bloom in %*:%*"):format(math.floor(v1 / 60), (string.format("%02d", (math.floor(v1 % 60))))))
        end

        local function syncBillboardEnabled() -- Line: 209 -- upvalues: u196 (ref), u200 (ref)
            local v1 = u196
            if v1 then
                v1.Enabled = not u200
            end
        end

        local function renderBillboard() -- Line: 216
            -- upvalues: u196 (ref), u200 (ref), Save (upval), Sakura (upval), getBloomStatusText (val)
            -- upvalues: TweenService (upval), u197 (ref)
            local v1
            local v2 = u196
            if v2 == nil then
                return
            end
            v2.Enabled = not u200
            local Countdown = v2.Countdown
            local Progress = v2.Progress
            assert(Countdown:IsA("TextLabel") and Progress:IsA("Frame"), "IncubatorBillboard needs Countdown and Progress")
            local Bar = Progress.Bar
            assert(Bar:IsA("Frame"), "IncubatorBillboard.Progress.Bar must be a Frame")
            local v3 = Save.Await()
            local Unlocked = false
            if v3 ~= nil then
                Unlocked = v3.Sakura.Unlocked
            end
            if not Unlocked then
                Countdown.Text = "Return a Crane pet to unlock Great Bloom"
                Progress.Visible = false
                return
            end
            local v4 = Save.Await()
            if v4 == nil then
                v1 = 0
                v3 = false
            elseif v4.Sakura.Egg ~= false then
                v1 = Sakura.GetChargePercent(v4.Sakura.Deposited, Sakura.GetRequiredCrystals())
                v3 = true
            else
                v1 = 0
                v3 = false
            end
            if not v3 then
                Countdown.Text = getBloomStatusText()
                Progress.Visible = false
                return
            end
            Countdown.Text = getBloomStatusText()
            Progress.Visible = true
            TweenService:Create(Bar, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(math.clamp(v1 / Sakura.Incubator.MaxChargePercent, 0, 1), 1),
            }):Play()
            v3 = u197
            if v3 then
                TweenService:Create(v3, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Brightness = math.clamp(v1 / Sakura.Incubator.MaxChargePercent, 0, 1) * 3,
                }):Play()
            end
        end

        local function buildTree(a1) -- Line: 257
            -- upvalues: u195 (val), IncubatorBloomed (val), IncubatorDead (val), u58 (val), Workspace (upval)
            -- upvalues: u198 (ref), u199 (ref), TweenService (upval), IncubatorBillboard (val), u200 (ref), u196 (ref)
            -- upvalues: u197 (ref), u9 (val), renderBillboard (val), Tabs (upval), CraneSign (val), Remotes (upval)
            -- upvalues: Toast (upval), u14 (val)
            local v1
            u195:Clean()
            local CFrame = u58.CFrame
            local v2 = (if not a1 then IncubatorDead else IncubatorBloomed):Clone()
            v2:PivotTo(CFrame)
            v2.Parent = Workspace
            u195:Add(v2)
            u198 = v2
            u199 = a1
            if a1 then
                local Door = v2:WaitForChild("Door")
                Door.CanCollide = false
                Door.CanTouch = false
                Door.CanQuery = false
                TweenService:Create(Door, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1}):Play()
            end
            local Attribute = v1:GetAttribute("Radius")
            local Attribute_2 = v1:GetAttribute("Height")
            local PrimaryPart = v2.PrimaryPart
            v2:AddTag("MainSakuraTree")
            v2 = IncubatorBillboard:Clone()
            v2.StudsOffsetWorldSpace = Vector3.new(0, Attribute_2 * 0.65, 0)
            v2.Enabled = not u200
            v2.Parent = PrimaryPart
            u196 = v2
            u197 = nil
            if a1 then
                v2 = Instance.new("Attachment")
                v2.Name = "ChargeGlow"
                v2.Position = Vector3.new(0, Attribute_2 * 0.6, 0)
                v2.Parent = PrimaryPart
                local PointLight = Instance.new("PointLight")
                PointLight.Color = u9
                PointLight.Brightness = 0
                PointLight.Range = 50
                PointLight.Parent = v2
                u197 = PointLight
            end
            u195:Add(function() -- Line: 301 -- upvalues: u196 (upval), u197 (upval)
                u196 = nil
                u197 = nil
            end)
            renderBillboard()
            if a1 then
                local v3 = Attribute + 8
                local Attachment = Instance.new("Attachment")
                Attachment.Name = "PromptAttachment"
                Attachment.Position = Vector3.new(0, 3, 0)
                Attachment.Parent = PrimaryPart
                local v4 = Instance.new("ProximityPrompt")
                v4.Style = Enum.ProximityPromptStyle.Custom
                v4.ActionText = "Open Incubator"
                v4.ObjectText = "Sakura Incubator"
                v4.HoldDuration = 0
                v4.RequiresLineOfSight = false
                v4.MaxActivationDistance = v3
                v4.Parent = Attachment
                u195:Add((v4.Triggered:Connect(function() -- Line: 308 -- upvalues: Tabs (upval)
                    Tabs.Activate("SakuraEggCharge")
                end)))
                return
            end
            if not u200 then
                local v5 = CraneSign
                local Attribute_3 = v5:GetAttribute("RootOffset")
                local v6 = ("%* needs a RootOffset CFrame attribute"):format(v5.Name)
                assert(typeof(Attribute_3) == "CFrame", v6)
                local v7 = u58.CFrame * Attribute_3
                local v8 = CraneSign:Clone()
                v8:PivotTo(v7)
                v8.Parent = Workspace
                u195:Add(v8)
                local v9 = Attribute + 8
                local Attachment_2 = Instance.new("Attachment")
                Attachment_2.Name = "PromptAttachment"
                Attachment_2.Position = Vector3.new(0, 3, 0)
                Attachment_2.Parent = PrimaryPart
                local u176 = Instance.new("ProximityPrompt")
                u176.Style = Enum.ProximityPromptStyle.Custom
                u176.ActionText = "Hatch and Return Crane pet"
                u176.ObjectText = "Dormant Sakura Tree"
                u176.HoldDuration = 0
                u176.RequiresLineOfSight = false
                u176.MaxActivationDistance = v9
                u176.Parent = Attachment_2
                u195:Add((u176.Triggered:Connect(function() -- Line: 312 -- upvalues: u176 (val), Remotes (upval), Toast (upval), u14 (upval)
                    u176.Enabled = false
                    local v1, v2 = Remotes.Bloomery.AskCraneReturn:InvokeServer()
                    if not v1 then
                        local v3 = if typeof(v2) ~= "string" then "The tree sleeps... bring it a Crane pet" else v2
                        Toast.Show({Seconds = 3, Text = v3, Color = u14})
                        u176.Enabled = true
                    end
                end)))
            end
        end

        local function emitPetals(a1, a2) -- Line: 327 -- types: a1: userdata, a2: number
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v:Emit(a2)
                end
            end
        end

        local function playTrack(a1, a2) -- Line: 335 -- types: a1: userdata, a2: userdata
            local v1 = a1:LoadAnimation(a2)
            v1.Priority = Enum.AnimationPriority.Action4
            v1.Looped = false
            v1:Play(0)
            return v1
        end

        local function getAnimator(a1) -- Line: 343 -- types: a1: userdata
            local Humanoid = a1:FindFirstChildOfClass("Humanoid") or a1:FindFirstChildOfClass("AnimationController")
            assert(Humanoid, (("%* needs a Humanoid or AnimationController"):format(a1.Name)))
            local Animator = Humanoid:FindFirstChildOfClass("Animator")
            assert(Animator, (("%* needs an Animator"):format(a1.Name)))
            return Animator
        end

        local function cloneCharacterRig() -- Line: 352
            -- upvalues: LocalPlayer (val), PlayerRig (val), u58 (val), Workspace (upval)
            local v1, v2
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Character ~= nil and Humanoid ~= nil and Character.PrimaryPart ~= nil then
                local v3
                local Archivable = Character.Archivable
                Character.Archivable = true
                v1 = Character:Clone()
                Character.Archivable = Archivable
                v1.Name = "SakuraCutscenePlayer"
                for i, v in ipairs(v1:GetChildren()) do
                    if v:IsA("LocalScript") or v:IsA("Script") or v:IsA("Tool") then
                        v:Destroy()
                    end
                end
                local v4 = v1:FindFirstChildOfClass("Humanoid")
                assert(v4, "Cloned character lost its Humanoid")
                v4.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                if v4:FindFirstChildOfClass("Animator") == nil then
                    Instance.new("Animator").Parent = v4
                end
                for i2, i3 in ipairs(v1:GetDescendants()) do
                    if i3:IsA("BasePart") then
                        v3 = i3 == v1.PrimaryPart
                        i3.Anchored = v3
                        i3.CanCollide = false
                        i3.CanQuery = false
                        i3.CanTouch = false
                        i3.LocalTransparencyModifier = 0
                    end
                end
                local v5 = PlayerRig
                v4 = v5:GetAttribute("RootOffset")
                v2 = ("%* needs a RootOffset CFrame attribute"):format(v5.Name)
                assert(typeof(v4) == "CFrame", v2)
                v1:PivotTo(u58.CFrame * v4)
                v1.Parent = Workspace
                return v1
            end
            local v6 = PlayerRig
            local Attribute = v6:GetAttribute("RootOffset")
            v2 = ("%* needs a RootOffset CFrame attribute"):format(v6.Name)
            assert(typeof(Attribute) == "CFrame", v2)
            local v7 = u58.CFrame * Attribute
            v1 = PlayerRig:Clone()
            v1:PivotTo(v7)
            v1.Parent = Workspace
            return v1
        end

        local function hideCharacter(a1) -- Line: 389 -- upvalues: LocalPlayer (val)
            local Character = LocalPlayer.Character
            if Character == nil then
                return
            end
            local u3 = {}
            for i, v in ipairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    u3[v] = v.LocalTransparencyModifier
                    v.LocalTransparencyModifier = 1
                elseif v:IsA("Decal") then
                    u3[v] = v.Transparency
                    v.Transparency = 1
                end
            end
            a1:Add(function() -- Line: 404 -- upvalues: u3 (val)
                for i, j in u3 do
                    if i.Parent then
                        if i:IsA("BasePart") then
                            i.LocalTransparencyModifier = j
                        elseif i:IsA("Decal") then
                            i.Transparency = j
                        end
                    end
                end
            end)
        end

        local function emitEffect(a1) -- Line: 417
            -- upvalues: u58 (val), Workspace (upval), Debris (upval), Emit (upval)
            local v1 = a1:Clone()
            local Attribute = a1:GetAttribute("RootOffset")
            local v2 = ("%* needs a RootOffset CFrame attribute"):format(a1.Name)
            assert(typeof(Attribute) == "CFrame", v2)
            v1.CFrame = u58.CFrame * Attribute
            v1.Parent = Workspace
            Debris:AddItem(v1, (Emit(v1)) + 1)
        end

        local function playBloom(a1) -- Line: 424
            -- upvalues: buildTree (val), u198 (ref), u9 (val), TweenService (upval), BlossomEffect (val), u58 (val)
            -- upvalues: Workspace (upval), Debris (upval), Emit (upval), Floor (val), emitPetals (val)
            buildTree(true)
            local v1 = u198
            local PointLight = Instance.new("PointLight")
            PointLight.Color = u9
            PointLight.Brightness = 6
            PointLight.Range = 60
            PointLight.Parent = v1.PrimaryPart
            a1:Add(PointLight)
            TweenService:Create(PointLight, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
            local v2 = BlossomEffect
            local v3 = v2:Clone()
            local Attribute = v2:GetAttribute("RootOffset")
            local v4 = ("%* needs a RootOffset CFrame attribute"):format(v2.Name)
            assert(typeof(Attribute) == "CFrame", v4)
            v3.CFrame = u58.CFrame * Attribute
            v3.Parent = Workspace
            Debris:AddItem(v3, (Emit(v3)) + 1)
            v2 = Floor
            local v5 = v2:Clone()
            local Attribute_2 = v2:GetAttribute("RootOffset")
            local v6 = ("%* needs a RootOffset CFrame attribute"):format(v2.Name)
            assert(typeof(Attribute_2) == "CFrame", v6)
            v5.CFrame = u58.CFrame * Attribute_2
            v5.Parent = Workspace
            Debris:AddItem(v5, (Emit(v5)) + 1)
            emitPetals(v1, 80)
        end

        local function partKeys(a1) -- Line: 444 -- types: a1: userdata
            local walk
            local u1 = {}

            function walk(a1, a2) -- Line: 446 -- upvalues: u1 (val), walk (val) -- types: a1: userdata, a2: string
                local v1, v2
                local v3 = {}
                for i, v in ipairs(a1:GetChildren()) do
                    v1 = (v3[v.Name] or 0) + 1
                    v3[v.Name] = v1
                    v2 = ("%*/%*#%*"):format(a2, v.Name, v1)
                    if v:IsA("BasePart") then
                        u1[v2] = v
                    end
                    walk(v, v2)
                end
            end

            walk(a1, "")
            return u1
        end

        local function tweenTreeToBloomed(a1) -- Line: 462
            -- upvalues: u198 (ref), u199 (ref), IncubatorBloomed (val), TweenService (upval)
            local v1 = u198
            if v1 ~= nil and not u199 then
                local v2, v3, v4, walk, walk_2
                local v5 = IncubatorBloomed
                local u4 = {}

                function walk(a1, a2) -- Line: 446 -- upvalues: u4 (val), walk (val) -- types: a1: userdata, a2: string
                    local v1, v2
                    local v3 = {}
                    for i, v in ipairs(a1:GetChildren()) do
                        v1 = (v3[v.Name] or 0) + 1
                        v3[v.Name] = v1
                        v2 = ("%*/%*#%*"):format(a2, v.Name, v1)
                        if v:IsA("BasePart") then
                            u4[v2] = v
                        end
                        walk(v, v2)
                    end
                end

                walk(v5, "")
                v5 = TweenInfo.new(a1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                local u15 = {}

                function walk_2(a1, a2) -- Line: 446
                    -- upvalues: u15 (val), walk_2 (val)
                    local v1, v2
                    local v3 = {}
                    for i, v in ipairs(a1:GetChildren()) do
                        v1 = (v3[v.Name] or 0) + 1
                        v3[v.Name] = v1
                        v2 = ("%*/%*#%*"):format(a2, v.Name, v1)
                        if v:IsA("BasePart") then
                            u15[v2] = v
                        end
                        walk_2(v, v2)
                    end
                end

                walk_2(v1, "")
                for i, j in u15 do
                    v4 = u4[i]
                    if v4 and v4.Color ~= j.Color then
                        v2 = TweenService
                        v3 = {Color = v4.Color}
                        v2:Create(j, v5, v3):Play()
                    end
                end
                return
            end
        end

        local function playLeafCover(a1) -- Line: 479
            -- upvalues: LeafCover (val), u58 (val), Workspace (upval), u22 (val), u27 (val), CurrentCamera (val)
            -- upvalues: tweenTreeToBloomed (val), TweenService (upval), RunService (upval), u15 (val), u32 (val)
            -- upvalues: LocalPlayer (val)
            local v1 = LeafCover
            local CFrame = u58.CFrame
            local u7 = v1:Clone()
            u7:PivotTo(CFrame)
            u7.Parent = Workspace
            a1:Add(u7)
            local u17 = {}
            for i, v in ipairs(u7:GetDescendants()) do
                if v:IsA("BasePart") and v ~= u7.PrimaryPart then
                    table.insert(u17, v)
                end
            end
            table.sort(u17, function(a1, a2) -- Line: 488
                return a1.Position.Y < a2.Position.Y
            end)
            local u37 = {}
            for i2, j in u17 do
                u37[j] = j.Size
                j.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
                j.Transparency = 1
            end
            local Highlight = Instance.new("Highlight")
            Highlight.FillColor = u22
            Highlight.OutlineColor = u27
            Highlight.FillTransparency = 1
            Highlight.OutlineTransparency = 1
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
            Highlight.Parent = u7
            local u57 = true
            local u58_2 = false
            a1:Add(function() -- Line: 505 -- upvalues: u57 (ref)
                u57 = false
            end)

            local function sweep(a1, a2, a3) -- Line: 507
                -- upvalues: u17 (val), u57 (ref), u7 (val)
                local v1
                local v2 = #u17
                local v3 = os.clock()
                local v4 = nil
                local v5 = nil
                local v6, v7 = a2, a1
                for i, j in u17, v4, v5 do
                    v1 = v7 * v6((i - 1) / math.max(v2 - 1, 1)) - (os.clock() - v3)
                    if v1 > 0 then
                        task.wait(v1)
                    end
                    if u57 and u7.Parent ~= nil then
                        v8(j)
                        continue
                    end
                    return
                end
            end

            local function accelerating(a1) -- Line: 522 -- types: a1: number
                return 1 - (1 - a1) ^ 2
            end

            local function linear(a1) -- Line: 523 -- types: a1: number
                return a1
            end

            local FieldOfView = CurrentCamera.FieldOfView
            a1:Add(function() -- Line: 526 -- upvalues: CurrentCamera (upval), FieldOfView (val)
                CurrentCamera.FieldOfView = FieldOfView
            end)
            local u74 = {}
            for k, n in u17 do
                u74[n] = n.Color
            end
            task.spawn(function() -- Line: 532
                -- upvalues: tweenTreeToBloomed (upval), sweep (val), accelerating (val), TweenService (upval)
                -- upvalues: u37 (val), u57 (ref), u58_2 (ref), Highlight (val), CurrentCamera (upval)
                -- upvalues: FieldOfView (val), linear (val), RunService (upval), u15 (upval), u17 (val), u74 (val)
                -- upvalues: u32 (upval), a1 (val)
                local u4 = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                tweenTreeToBloomed(3.669999999999998)
                sweep(3.069999999999998, accelerating, function(a1) -- Line: 536 -- upvalues: TweenService (upval), u4 (val), u37 (upval)
                    a1.Transparency = 0
                    TweenService:Create(a1, u4, {Size = u37[a1]}):Play()
                end)
                task.wait(0.6)
                if u57 and not u58_2 then
                    local u22 = TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                    TweenService:Create(
                        Highlight,
                        TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
                        {OutlineTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        CurrentCamera,
                        TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
                        {FieldOfView = FieldOfView - 12}
                    ):Play()
                    task.spawn(sweep, 1.25, linear, function(a1) -- Line: 562 -- upvalues: TweenService (upval), u22 (val), u37 (upval)
                        TweenService:Create(a1, u22, {Size = u37[a1] * 0.8}):Play()
                    end)
                    local u60 = os.clock()
                    local u61 = 0
                    local u62 = nil
                    u62 = RunService.Heartbeat:Connect(function(a1) -- Line: 569
                        -- upvalues: u57 (upval), u58_2 (upval), u62 (ref), u60 (val), u15 (upval), u61 (ref)
                        -- upvalues: Highlight (upval), u17 (upval), u74 (upval), u32 (upval)
                        if u57 and not u58_2 then
                            local v1
                            local v2 = math.clamp((os.clock() - u60) / 2.5, 0, 1)
                            local v3 = u15[1] + (u15[2] - u15[1]) * v2 ^ 2
                            u61 = u61 + a1 * v3 * 3.141592653589793 * 2
                            local v4 = (math.sin(u61) + 1) * 0.5 * (v2 * 0.65 + 0.35)
                            Highlight.FillTransparency = 1 - v4 * 0.85
                            for i, j in u17 do
                                v1 = u74[j]
                                j.Color = v1:Lerp(u32, v4)
                            end
                            return
                        end
                        u62:Disconnect()
                    end)
                    a1:Add(u62)
                    return
                end
            end)

            local function flashScreen() -- Line: 587
                -- upvalues: u32 (upval), LocalPlayer (upval), a1 (val), TweenService (upval)
                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "SakuraExplosionFlash"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 1000
                ScreenGui.ResetOnSpawn = false
                local Frame = Instance.new("Frame")
                Frame.Size = UDim2.fromScale(1, 1)
                Frame.BackgroundColor3 = u32
                Frame.BorderSizePixel = 0
                Frame.Parent = ScreenGui
                ScreenGui.Parent = LocalPlayer.PlayerGui
                a1:Add(ScreenGui)
                TweenService:Create(
                    Frame,
                    TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                task.delay(0.6, function() -- Line: 605 -- upvalues: ScreenGui (val)
                    ScreenGui:Destroy()
                end)
            end

            return {
                Model = u7,
                Explode = function() -- Line: 608
                    -- upvalues: u58_2 (ref), u57 (ref), flashScreen (val), TweenService (upval), Highlight (val)
                    -- upvalues: u32 (upval), CurrentCamera (upval), FieldOfView (val), sweep (val), linear (val)
                    -- upvalues: u37 (val), u7 (val)
                    if not u58_2 and u57 then
                        u58_2 = true
                        flashScreen()
                        local u9 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            FillTransparency = 1,
                            OutlineTransparency = 1,
                            FillColor = u32,
                            OutlineColor = u32,
                        }):Play()
                        local v1 = TweenService:Create(
                            CurrentCamera,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {FieldOfView = FieldOfView + 14}
                        )
                        v1.Completed:Once(function() -- Line: 632 -- upvalues: TweenService (upval), CurrentCamera (upval), FieldOfView (upval)
                            TweenService:Create(
                                CurrentCamera,
                                TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                                {FieldOfView = FieldOfView}
                            ):Play()
                        end)
                        v1:Play()
                        task.spawn(sweep, 0.25, linear, function(a1) -- Line: 651 -- upvalues: TweenService (upval), u9 (val), u37 (upval)
                            TweenService:Create(a1, u9, {Transparency = 1, Size = u37[a1] * 1.8}):Play()
                        end)
                        task.delay(0.55, function() -- Line: 657 -- upvalues: u7 (upval)
                            u7:Destroy()
                        end)
                        return
                    end
                end,
            }
        end

        local function setEmitters(a1, a2) -- Line: 662 -- types: a1: userdata, a2: boolean
            local v1 = 0
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = a2
                    v1 = math.max(v1, v.Lifetime.Max)
                end
            end
            return v1
        end

        local function playLeafRing(a1) -- Line: 673
            -- upvalues: LeafRing (val), u58 (val), Workspace (upval), setEmitters (val)
            local v1 = LeafRing
            local Attribute = v1:GetAttribute("RootOffset")
            local v2 = ("%* needs a RootOffset CFrame attribute"):format(v1.Name)
            assert(typeof(Attribute) == "CFrame", v2)
            local v3 = u58.CFrame * Attribute
            local u29 = LeafRing:Clone()
            u29:PivotTo(v3)
            u29.Parent = Workspace
            a1:Add(u29)
            setEmitters(u29, true)
            return function() -- Line: 677 -- upvalues: setEmitters (upval), u29 (val)
                task.delay(setEmitters(u29, false), function() -- Line: 679 -- upvalues: u29 (upval)
                    u29:Destroy()
                end)
            end
        end

        local function setTrails(a1, a2) -- Line: 683 -- types: a1: userdata, a2: boolean
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("Trail") then
                    v.Enabled = a2
                end
            end
        end

        local function playCutsceneSound(a1) -- Line: 691 -- upvalues: u86 (val), SoundService (upval)
            local v1 = u86:Clone()
            v1.Parent = SoundService
            a1:Add(v1)
            v1:Play()
        end

        local function runUnlockCutscene(a1) -- Line: 698
            -- upvalues: buildTree (val), CameraRig (val), u58 (val), Workspace (upval), CraneRig (val)
            -- upvalues: cloneCharacterRig (val), hideCharacter (val), ContentProvider (upval), CameraAnimation (val)
            -- upvalues: CraneAnimation (val), PlayerAnimation (val), getAnimator (val), playLeafCover (val)
            -- upvalues: playLeafRing (val), playBloom (val), setTrails (val), u86 (val), SoundService (upval)
            -- upvalues: CurrentCamera (val), RunService (upval)
            buildTree(false)
            local v1 = CameraRig
            local Attribute = v1:GetAttribute("RootOffset")
            local v2 = ("%* needs a RootOffset CFrame attribute"):format(v1.Name)
            assert(typeof(Attribute) == "CFrame", v2)
            local v3 = u58.CFrame * Attribute
            local v4 = CameraRig:Clone()
            v4:PivotTo(v3)
            v4.Parent = Workspace
            local v5 = CraneRig
            local Attribute_2 = v5:GetAttribute("RootOffset")
            local v6 = ("%* needs a RootOffset CFrame attribute"):format(v5.Name)
            assert(typeof(Attribute_2) == "CFrame", v6)
            v1 = u58.CFrame * Attribute_2
            local v7 = CraneRig:Clone()
            v7:PivotTo(v1)
            v7.Parent = Workspace
            a1:Add(v4)
            a1:Add(v7)
            local Torso = v4:FindFirstChild("Torso")
            assert(Torso and Torso:IsA("BasePart"), "CameraRig needs a Torso part")
            v1 = cloneCharacterRig()
            a1:Add(v1)
            hideCharacter(a1)
            ContentProvider:PreloadAsync({CameraAnimation, CraneAnimation, PlayerAnimation})
            v5 = (getAnimator(v4)):LoadAnimation(CameraAnimation)
            v5.Priority = Enum.AnimationPriority.Action4
            v5.Looped = false
            v5:Play(0)
            v4 = (getAnimator(v7)):LoadAnimation(CraneAnimation)
            v4.Priority = Enum.AnimationPriority.Action4
            v4.Looped = false
            v4:Play(0)
            local u146 = {}
            v6 = (getAnimator(v1)):LoadAnimation(PlayerAnimation)
            v6.Priority = Enum.AnimationPriority.Action4
            v6.Looped = false
            v6:Play(0)
            u146[1] = v5
            u146[2] = v4
            u146[3] = v6
            a1:Add(function() -- Line: 720 -- upvalues: u146 (val)
                for i, j in u146 do
                    j:Stop(0)
                    j:Destroy()
                end
            end)
            local u168 = nil
            local u170 = nil
            local u172 = false
            a1:Add(((v5:GetMarkerReachedSignal("Start")):Connect(function() -- Line: 728 -- upvalues: u168 (ref), playLeafCover (upval), a1 (val)
                if u168 then
                    return
                end
                playLeafCover(a1)
            end)))
            a1:Add(((v5:GetMarkerReachedSignal("Explosion")):Connect(function() -- Line: 742 -- upvalues: u172 (ref), u168 (ref), u170 (ref), playBloom (upval), a1 (val)
                if u172 then
                    return
                end
                u172 = true
                local v1 = u168
                if v1 then
                    v1.Explode()
                end
                v1 = u170
                if v1 then
                    v1()
                end
                task.spawn(playBloom, a1)
            end)))
            a1:Add(((v4:GetMarkerReachedSignal("Spell")):Connect(function() -- Line: 735 -- upvalues: u170 (ref), playLeafRing (upval), a1 (val)
                if u170 then
                    return
                end
                playLeafRing(a1)
            end)))
            setTrails(v7, true)
            v6 = u86:Clone()
            v6.Parent = SoundService
            a1:Add(v6)
            v6:Play()
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            a1:Add(function() -- Line: 764 -- upvalues: RunService (upval), CurrentCamera (upval)
                RunService:UnbindFromRenderStep("SakuraUnlockCamera")
                CurrentCamera.CameraType = Enum.CameraType.Custom
            end)
            RunService:BindToRenderStep("SakuraUnlockCamera", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 771 -- upvalues: CurrentCamera (upval), Torso (val)
                CurrentCamera.CFrame = Torso.CFrame
            end)
            task.wait(25)
            if not u172 then
                v5 = u168
                if v5 then
                    v5.Explode()
                end
                v5 = u170
                if v5 then
                    v5()
                end
                task.spawn(playBloom, a1)
            end
        end

        local function playUnlockCutscene() -- Line: 778
            -- upvalues: u200 (ref), u196 (ref), Tabs (upval), HiddenUIHandler (upval), Trove (upval)
            -- upvalues: runUnlockCutscene (val), refresh (ref)
            if u200 then
                return
            end
            u200 = true
            local v1 = u196
            if v1 then
                v1.Enabled = not u200
            end
            Tabs.Deactivate({instant = true})
            v1 = HiddenUIHandler.Acquire()
            local v2 = Trove.new()
            local success, err = pcall(runUnlockCutscene, v2)
            v2:Clean()
            v1()
            u200 = false
            refresh()
            if not success then
                error(err)
            end
        end

        local function runMutateReveal(a1, a2) -- Line: 798
            -- upvalues: EggRecords (upval), Directory (upval), Mutations (upval), u9 (val), u58 (val)
            -- upvalues: IncubatorBloomed (val), EggRenderer (upval), LocalPlayer (val), Workspace (upval)
            -- upvalues: CurrentCamera (val), RunService (upval), TweenService (upval), SakuraFX (upval)
            local v1 = EggRecords.Decode(a2.Egg)
            local v2 = Directory[v1.AssetCategory]
            local v3 = ("Missing asset config %*"):format(v1.AssetCategory)
            assert(v2 ~= nil, v3)
            local v4 = Mutations.Get(a2.Mutation)
            local Tint = if not v4 then u9 else v4.Tint
            local CFrame_2 = u58.CFrame
            local v5 = EggRenderer.RenderVisual({
                ModelName = "SakuraRevealEgg",
                OwnerUserId = LocalPlayer.UserId,
                UID = a2.Uid,
                Record = v1,
            }, Workspace)
            local Model = v5.Model
            a1:Add(Model)
            for i, v in ipairs(Model:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Anchored = true
                    v.CanCollide = false
                    v.CanQuery = false
                end
            end
            local Y = v5.Config and EggRenderer.GetVisibleBounds(v1).Y or 4
            local u95 = CFrame.new((CFrame_2 * CFrame.new(0, 0, -IncubatorBloomed:GetAttribute("Radius") - 4)).Position + Vector3.new(0, Y / 2 + 1.5, 0))
            Model:PivotTo(u95)
            local u106 = Model:GetScale()
            Model:ScaleTo((math.max(0.05, u106 * 0.05)))
            v1 = Instance.new("PointLight")
            v1.Color = Tint
            v1.Brightness = 0
            v1.Range = 30
            local PrimaryPart = Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart")
            v1.Parent = PrimaryPart
            a1:Add(v1)
            local v6 = math.max(Y * 2.2, 9)
            local LookVector = CFrame_2.LookVector
            local u161 = CFrame.lookAt(u95.Position + LookVector * v6 * 1.6 + Vector3.new(0, Y * 0.9, 0), u95.Position)
            local u178 = CFrame.lookAt(
                u95.Position + (LookVector * 0.85 + CFrame_2.RightVector * 0.5).Unit * v6 + Vector3.new(0, Y * 0.4, 0),
                u95.Position
            )
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            a1:Add(function() -- Line: 852 -- upvalues: RunService (upval), CurrentCamera (upval)
                RunService:UnbindFromRenderStep("SakuraMutateReveal")
                CurrentCamera.CameraType = Enum.CameraType.Custom
            end)
            local u185 = 0
            RunService:BindToRenderStep("SakuraMutateReveal", Enum.RenderPriority.Camera.Value + 1, function(a1) -- Line: 860
                -- upvalues: u185 (ref), TweenService (upval), CurrentCamera (upval), u161 (val), u178 (val)
                -- upvalues: Model (val), u106 (val), u95 (val)
                u185 = u185 + a1
                local Value = TweenService:GetValue(math.clamp(u185 / 3.2, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                CurrentCamera.CFrame = u161:Lerp(u178, Value)
                Model:ScaleTo((math.max(
                    0.05,
                    u106 * (TweenService:GetValue(math.clamp(u185 / 0.9, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out))
                )))
                Model:PivotTo(u95 * (CFrame.Angles(0, u185 * 1.2, 0)))
            end)
            SakuraFX.EmitBurst("Bloom", u95.Position, 80, Y * 2)
            SakuraFX.PlayCue("Bloom", LocalPlayer, 0.8, 1.15)
            TweenService:Create(v1, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 5}):Play()
            task.wait(0.9)
            SakuraFX.PlayCue("Mutate", LocalPlayer, 1)
            SakuraFX.EmitBurst("Pickup", u95.Position, 40, Y * 1.5)
            task.wait(2.3000000000000003)
            return v2.Egg.DisplayName, Tint, v2.Egg.Icon
        end

        local function playMutateReveal(a1) -- Line: 893
            -- upvalues: u200 (ref), u196 (ref), Tabs (upval), HiddenUIHandler (upval), Trove (upval)
            -- upvalues: runMutateReveal (val), refresh (ref), Message (upval), Mutations (upval)
            if u200 then
                return
            end
            u200 = true
            local v1 = u196
            if v1 then
                v1.Enabled = not u200
            end
            Tabs.Deactivate({instant = true})
            v1 = HiddenUIHandler.Acquire()
            local v2 = Trove.new()
            local success, err, v3, v4 = pcall(runMutateReveal, v2, a1)
            v2:Clean()
            v1()
            u200 = false
            refresh()
            if not success then
                error(err)
            end
            Message.Notice(
                ("Your %* is now <font color=\"#%*\">%*</font>!"):format(err, v3:ToHex(), (Mutations.LabelOf(a1.Mutation))),
                {LeaveClosed = true, Image = v4}
            )
        end

        function refresh() -- Line: 920
            -- upvalues: u200 (ref), Build (val), u195 (val), u198 (ref), u199 (ref), Save (upval), buildTree (val)
            -- upvalues: renderBillboard (val)
            if u200 then
                return
            end
            if Build:GetAttribute("DragonEventMap") ~= true
                and Build:GetAttribute("CherryBlossomZoneRevealed") == true then
                local v1 = Save.Await()
                local Unlocked = false
                if v1 ~= nil then
                    Unlocked = v1.Sakura.Unlocked
                end
                if u199 ~= Unlocked then
                    buildTree(Unlocked)
                end
                renderBillboard()
                return
            end
            u195:Clean()
            u198 = nil
            u199 = nil
        end

        Remotes.Bloomery.CutsceneOpened.OnClientEvent:Connect(function() -- Line: 944 -- upvalues: playUnlockCutscene (val)
            task.spawn(playUnlockCutscene)
        end)
        SakuraSignals.Reveal:Connect(function(a1) -- Line: 945 -- upvalues: Sakura_2 (upval), playMutateReveal (val)
            assert(Sakura_2.MutateResult(a1), "Sakura mutate reveal needs a valid result")
            task.spawn(playMutateReveal, a1)
        end)
        Save.WatchFields("Sakura", refresh)
        local v1 = refresh
        ;(Build:GetAttributeChangedSignal("DragonEventMap")):Connect(v1)
        v1 = refresh
        ;(Build:GetAttributeChangedSignal("CherryBlossomZoneRevealed")):Connect(v1)
        Save.Loaded:Connect(function(a1) -- Line: 953 -- upvalues: LocalPlayer (val), refresh (ref) -- types: a1: userdata
            if a1 == LocalPlayer then
                refresh()
            end
        end)
        if Save.IsLoaded() then
            refresh()
        end
        task.spawn(function() -- Line: 962 -- upvalues: u196 (ref), Save (upval), renderBillboard (val)
            local Unlocked, v1
            while true do
                task.wait(1)
                if u196 then
                    v1 = Save.Await()
                    Unlocked = false
                    if v1 ~= nil then
                        Unlocked = v1.Sakura.Unlocked
                    end
                    if Unlocked then
                        renderBillboard()
                    end
                end
            end
        end)
        task.spawn(function() -- Line: 972
            -- upvalues: ContentProvider (upval), CameraAnimation (val), CraneAnimation (val), PlayerAnimation (val)
            ContentProvider:PreloadAsync({CameraAnimation, CraneAnimation, PlayerAnimation})
        end)
    end,
}