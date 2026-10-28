-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController
-- Decompile time: 58.23 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Artifacts = require(script.Artifacts)
local Cast = require(script.Cast)
local Catch = require(script.Catch)
local Chase = require(script.Chase)
local Cine = require(script.Cine)
local Finale = require(script.Finale)
local GhostDogQuestFlags = require(ReplicatedStorage.Shared.Flags.GhostDogQuestFlags)
local Fx = require(script.Fx)
local Handoff = require(script.Handoff)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local GhostDogQuest_2 = require(ReplicatedStorage.Shared.Types.GhostDogQuest)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Hud = require(script.Hud)
local Memories = require(script.Memories)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Npcs = require(script.Npcs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Speech = require(script.Speech)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local LocalPlayer = Players.LocalPlayer
local Stage = GhostDogQuest.Stage
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u120 = Color3.fromRGB(255, 85, 85)
local u125 = Color3.fromRGB(120, 255, 175)
local u126 = nil
local u127 = nil
local u128 = false
local u129 = false
local u130 = nil
local u131 = nil
local u132 = false
local u133 = -1
local u134 = false
local syncWorld = nil
local u136 = 0
local v1 = {}

local function stateOf() -- Line: 68 -- upvalues: Save (val), GhostDogQuest_2 (val)
    local v1 = Save.Peek()
    if v1 == nil then
        return nil
    end
    return v1.GhostDogQuest or GhostDogQuest_2.Blank()
end

local function markersOf() -- Line: 76 -- upvalues: Workspace (val), HalloweenDimension (val), GhostDogQuest (val)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    local v2 = v1 and v1:FindFirstChild(GhostDogQuest.FolderName)
    v1 = v2 and v2:FindFirstChild(GhostDogQuest.MarkersName)
    if v1 ~= nil and v1:IsA("Folder") then
        return v1
    end
    return nil
end

local function marker(a1) -- Line: 83 -- upvalues: u127 (ref) -- types: a1: string
    local v1 = u127
    local v2 = v1 and v1:FindFirstChild(a1)
    if v2 and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

local function rootOf() -- Line: 89 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function setGuide(a1) -- Line: 95 -- upvalues: u131 (ref), u130 (ref), TutorialBeam (val) -- types: a1: userdata?
    if a1 == u131 then
        return
    end
    u131 = a1
    if u130 then
        TutorialBeam.Destroy(u130)
        u130 = nil
    end
    if a1 then
        TutorialBeam.Attach(a1, {BeamName = "GhostDogGuide"})
    end
end

local function isActive() -- Line: 109
    -- upvalues: GhostDogQuestFlags (val), LocalPlayer (val), PlayerAttributes (val), Workspace (val)
    -- upvalues: HalloweenDimension (val), GhostDogQuest (val), Save (val)
    local v1 = GhostDogQuestFlags.Enabled:Get()
    if v1 then
        v1 = false
        if LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true then
            v1 = false
            local v2 = Workspace:FindFirstChild(HalloweenDimension.MapName)
            local v3 = v2 and v2:FindFirstChild(GhostDogQuest.FolderName)
            v2 = v3 and v3:FindFirstChild(GhostDogQuest.MarkersName)
            if (if v2 == nil then nil else if not v2:IsA("Folder") then nil else v2) ~= nil then
                v1 = Save.IsLoaded()
            end
        end
    end
    return v1
end

local function allFound(a1) -- Line: 116 -- upvalues: GhostDogQuest_2 (val), GhostDogQuest (val)
    local v1 = GhostDogQuest_2.CountFound(a1)
    return #GhostDogQuest.Artifacts <= v1
end

local function objectiveFor(a1) -- Line: 120
    -- upvalues: u129 (ref), GhostDogQuest (val), Stage (val), GhostDogQuest_2 (val), u136 (ref)
    if u129 then
        return GhostDogQuest.Objectives.Follow
    end
    if a1.Stage == Stage.Collecting then
        local v1 = GhostDogQuest_2.CountFound(a1)
        if #GhostDogQuest.Artifacts <= v1 then
            return GhostDogQuest.Objectives.Return
        end
        return (("%* (%*/%*)"):format(GhostDogQuest.Objectives.Collecting, GhostDogQuest_2.CountFound(a1), #GhostDogQuest.Artifacts))
    end
    if a1.Stage == Stage.Reunion then
        return GhostDogQuest.Objectives.Reunion
    end
    if a1.Stage == Stage.HasRod then
        return GhostDogQuest.Objectives.Cast
    end
    if a1.Stage == Stage.Done and os.clock() < u136 then
        return GhostDogQuest.Captions.AfterQuest
    end
    return nil
end

local function toggleMemories() -- Line: 142 -- upvalues: Memories (val)
    if Memories.IsOpen() then
        Memories.Close()
        return
    end
    Memories.Open()
end

local function dogMood(a1) -- Line: 150 -- upvalues: Stage (val), GhostDogQuest_2 (val), GhostDogQuest (val)
    if a1.Stage == Stage.NotMet then
        return "Sad"
    end
    if a1.Stage ~= Stage.Collecting then
        return "Happy"
    end
    local v1 = GhostDogQuest_2.CountFound(a1)
    if #GhostDogQuest.Artifacts <= v1 then
        return "Happy"
    end
    return "Idle"
end

local function castLive() -- Line: 160
    -- upvalues: Save (val), GhostDogQuest_2 (val), Stage (val), u128 (ref), u132 (ref)
    local v1 = Save.Peek()
    local GhostDogQuest = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
    v1 = false
    if GhostDogQuest ~= nil then
        v1 = false
        if GhostDogQuest.Stage == Stage.HasRod then
            v1 = not u128 and u132
        end
    end
    return v1
end

local function buildCastRing(a1) -- Line: 165
    -- upvalues: u127 (ref), Fx (val), u125 (val), Workspace (val), RunService (val), Save (val), GhostDogQuest_2 (val)
    -- upvalues: Stage (val), u128 (ref), u132 (ref)
    local v1
    local v2 = u127
    local CastTarget = v2 and v2:FindFirstChild("CastTarget")
    if (if not CastTarget then nil else if not CastTarget:IsA("BasePart") then nil else CastTarget) == nil then
        return
    end
    v2 = a1:Add((Instance.new("Part")))
    v2.Name = "GhostDogCastRipples"
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Transparency = 1
    v2.Size = Vector3.new(1, 1, 1)
    v2.CFrame = CFrame.new(v1.Position + Vector3.new(0, 0.25, 0))
    v1 = Instance.new("Attachment")
    v1.Parent = v2
    local u46 = Fx.RippleEmitter(v1, 0, 0.8)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = Fx.Sparkle
    ParticleEmitter.Color = ColorSequence.new(u125)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Rate = 0
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4)
    ParticleEmitter.Speed = NumberRange.new(1, 3)
    ParticleEmitter.SpreadAngle = Vector2.new(30, 30)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Size = NumberSequence.new(0.5, 0)
    ParticleEmitter.Parent = v1
    local u77 = Instance.new("PointLight")
    u77.Color = u125
    u77.Range = 14
    u77.Brightness = 0
    u77.Parent = v2
    v2.Parent = Workspace
    a1:Connect(RunService.Heartbeat, function() -- Line: 200
        -- upvalues: Save (upval), GhostDogQuest_2 (upval), Stage (upval), u128 (upval), u132 (upval), u46 (val)
        -- upvalues: ParticleEmitter (val), u77 (val)
        local v1 = Save.Peek()
        local GhostDogQuest = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
        local v2 = false
        if GhostDogQuest ~= nil then
            v2 = false
            if GhostDogQuest.Stage == Stage.HasRod then
                v2 = not u128 and u132
            end
        end
        u46.Rate = if not v2 then 0 else 1.6
        ParticleEmitter.Rate = if not v2 then 0 else 8
        u77.Brightness = if not v2 then 0 else math.sin((os.clock()) * 4) * 0.5 + 1
    end)
end

local function buildCastSpot(a1) -- Line: 208
    -- upvalues: u127 (ref), LocalPlayer (val), Workspace (val), u125 (val), RunService (val), Save (val)
    -- upvalues: GhostDogQuest_2 (val), Stage (val), u128 (ref), u132 (ref)
    local v1
    local v2 = u127
    local CastSpot = v2 and v2:FindFirstChild("CastSpot")
    if (if not CastSpot then nil else if not CastSpot:IsA("BasePart") then nil else CastSpot) == nil then
        return
    end
    v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = {v1, LocalPlayer.Character}
    local v3 = Workspace:Raycast(v1.Position + Vector3.new(0, 4, 0), Vector3.new(0, -12, 0), v2)
    local Position = if not v3 then v1.Position else v3.Position
    local u42 = a1:Add((Instance.new("Model")))
    u42.Name = "GhostDogCastSpot"

    local function disc(a1, a2, a3) -- Line: 221
        -- upvalues: u125 (upval), Position (val), u42 (val)
        local Part = Instance.new("Part")
        Part.Name = a1
        Part.Shape = Enum.PartType.Cylinder
        Part.Material = Enum.Material.Neon
        Part.Color = u125
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Transparency = a3
        Part.Size = Vector3.new(0.08, a2, a2)
        Part.CFrame = (CFrame.new(Position + Vector3.new(0, 0.05999999865889549, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
        Part.Parent = u42
        return Part
    end

    local u50 = disc("Pad", 6, 0.55)
    local u55 = disc("Pulse", 6, 0.3)
    v1 = Instance.new("Attachment")
    v1.Parent = u50
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(26, 0, 0)
    Attachment.Parent = u50
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = v1
    Beam.Attachment1 = Attachment
    Beam.Width0 = 5
    Beam.Width1 = 5
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Color = ColorSequence.new(u125)
    Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), (NumberSequenceKeypoint.new(1, 1))})
    Beam.Parent = u50
    local u88 = Instance.new("PointLight")
    u88.Color = u125
    u88.Range = 16
    u88.Brightness = 2
    u88.Parent = u50
    v1 = Instance.new("Attachment")
    v1.Name = "FishHerePoint"
    v1.WorldPosition = Position + Vector3.new(0, 7.5, 0)
    v1.Parent = u50
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "FishHere"
    BillboardGui.Adornee = v1
    BillboardGui.Size = UDim2.fromScale(10, 3.4)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 0
    BillboardGui.MaxDistance = 900
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Size = UDim2.fromScale(1, 0.62)
    v1.TextScaled = true
    v1.Text = "FISH HERE"
    v1.TextColor3 = u125
    v1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 3
    UIStroke.Color = Color3.fromRGB(10, 40, 30)
    UIStroke.Parent = v1
    v1.Parent = BillboardGui
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Arrow"
    TextLabel.BackgroundTransparency = 1
    TextLabel.AnchorPoint = Vector2.new(0.5, 0)
    TextLabel.Position = UDim2.fromScale(0.5, 0.6)
    TextLabel.Size = UDim2.fromScale(0.3, 0.4)
    TextLabel.TextScaled = true
    TextLabel.Text = "▼"
    TextLabel.TextColor3 = u125
    TextLabel.FontFace = v1.FontFace
    UIStroke:Clone().Parent = TextLabel
    TextLabel.Parent = BillboardGui
    BillboardGui.Parent = u42
    u42.Parent = Workspace
    a1:Connect(RunService.Heartbeat, function() -- Line: 302
        -- upvalues: Save (upval), GhostDogQuest_2 (upval), Stage (upval), u128 (upval), u132 (upval)
        -- upvalues: LocalPlayer (upval), Position (val), u50 (val), u55 (val), Beam (val), u88 (val)
        -- upvalues: BillboardGui (val), TextLabel (val)
        local v1 = Save.Peek()
        local GhostDogQuest = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
        local v2 = false
        if GhostDogQuest ~= nil then
            v2 = false
            if GhostDogQuest.Stage == Stage.HasRod then
                v2 = not u128 and u132
            end
        end
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local v3 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
        v1 = false
        if v3 ~= nil then
            v1 = (v3.Position - Position).Magnitude <= 36
        end
        v3 = os.clock()
        local v4 = v3 * 0.8 % 1
        u50.Transparency = if not v2 then 1 else 0.55
        u55.Transparency = if not v2 then 1 else 0.3 + v4 * 0.7
        u55.Size = Vector3.new(0.08, 6 + v4 * 7, 6 + v4 * 7)
        Beam.Enabled = v2
        u88.Enabled = v2
        BillboardGui.Enabled = v2 and v1
        TextLabel.Position = UDim2.fromScale(0.5, math.abs((math.sin(v3 * 4))) * 0.1 + 0.6)
    end)
end

local function abortSession() -- Line: 318 -- upvalues: Remotes (val)
    pcall(function() -- Line: 319 -- upvalues: Remotes (upval)
        Remotes.GhostDogQuest.Abort:InvokeServer()
    end)
end

local function runCast(a1) -- Line: 324
    -- upvalues: u128 (ref), u127 (ref), u126 (ref), Speech (val), Memories (val), Handoff (val), Npcs (val), u131 (ref)
    -- upvalues: u130 (ref), TutorialBeam (val), Hud (val), Remotes (val), Toast (val), u120 (val), Cine (val)
    -- upvalues: Cast (val), MusicDirector (val), LocalPlayer (val), PlayerAttributes (val), Chase (val)
    -- upvalues: GhostDogQuest (val), Finale (val), abortSession (val)
    if u128 then
        return false
    end
    local u3 = u127
    local v1 = u126
    if u3 ~= nil and v1 ~= nil then
        u128 = true
        Speech.Stop()
        Memories.Close()
        while Handoff.IsRunning() do
            task.wait()
        end
        if u126 ~= v1 then
            u128 = false
            return false
        end
        Npcs.SetQuiet(true)
        if u131 ~= nil then
            u131 = nil
            if u130 then
                TutorialBeam.Destroy(u130)
                u130 = nil
            end
        end
        Hud.SetObjective(nil)
        Hud.Cinematic(true)
        local success, err, v2 = pcall(function() -- Line: 347 -- upvalues: Remotes (upval)
            return Remotes.GhostDogQuest.Cast:InvokeServer()
        end)
        if success and typeof(err) == "number" then
            Cine.Hold()
            local u55 = v1:Extend()
            local success_2, err_2 = pcall(Cast.Play, u55, u3, a1)
            local v3 = false
            if success_2 and err_2 then
                local success_3, err_3 = pcall(function() -- Line: 362 -- upvalues: Remotes (upval)
                    return Remotes.GhostDogQuest.Dive:InvokeServer()
                end)
                v3 = success_3 and err_3 == true
            end
            if not success_2 then
                warn((("[GhostDogQuest] cast failed: %*"):format(err_2)))
            end
            if not v3 then
                pcall(function() -- Line: 319 -- upvalues: Remotes (upval)
                    Remotes.GhostDogQuest.Abort:InvokeServer()
                end)
                u55:Clean()
                Cine.Settle(0.4)
                Hud.Fade(0, 0.4)
                u128 = false
                return false
            end
            local v4 = v1:Extend()
            v4:Add((MusicDirector.Suppress()))
            local u126_2 = v1:Extend()
            local u127_2 = false
            local Character = LocalPlayer.Character

            local function stillHere() -- Line: 383
                -- upvalues: LocalPlayer (upval), Character (val), PlayerAttributes (upval)
                local v1 = false
                if LocalPlayer.Character == Character then
                    v1 = false
                    if Character ~= nil then
                        v1 = false
                        if Character.Parent ~= nil then
                            v1 = LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true
                        end
                    end
                end
                return v1
            end

            local success_5, err_4 = pcall(function() -- Line: 389
                -- upvalues: Chase (upval), u126_2 (val), err (val), LocalPlayer (upval), Character (val)
                -- upvalues: PlayerAttributes (upval), GhostDogQuest (upval), u55 (val), u127_2 (ref), Finale (upval)
                -- upvalues: u3 (val), stillHere (val)
                local v1, v2, v3
                v1, v2, _, v3 = Chase.Run(u126_2, err, function() -- Line: 390
                    -- upvalues: LocalPlayer (upval), Character (upval), PlayerAttributes (upval), GhostDogQuest (upval)
                    local v1 = false
                    if LocalPlayer.Character == Character then
                        v1 = false
                        if Character ~= nil then
                            v1 = false
                            if Character.Parent ~= nil then
                                v1 = LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true
                            end
                        end
                    end
                    if v1 then
                        v1 = LocalPlayer:GetAttribute(GhostDogQuest.ChaseAttribute) ~= nil
                    end
                    return v1
                end, u55)
                if v1 == "Won" and v2 then
                    Finale.Play(u126_2, err, v2, u3, stillHere, v3)
                end
            end)
            if not success_5 then
                warn((("[GhostDogQuest] chase failed: %*"):format(err_4)))
            end
            u55:Clean()
            if not u127_2 then
                local v5 = false
                if LocalPlayer.Character == Character then
                    v5 = false
                    if Character ~= nil then
                        v5 = false
                        if Character.Parent ~= nil then
                            v5 = LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true
                        end
                    end
                end
                if v5 then
                    pcall(function() -- Line: 319 -- upvalues: Remotes (upval)
                        Remotes.GhostDogQuest.Abort:InvokeServer()
                    end)
                end
            end
            u126_2:Clean()
            if u127_2 and u126 == v1 then
                local v6 = v1:Extend()
                local success_7, err_5 = pcall(Finale.Rescue, v6, u3, stillHere)
                if not success_7 then
                    warn((("[GhostDogQuest] rescue failed: %*"):format(err_5)))
                end
                v6:Clean()
                task.spawn(abortSession)
            end
            v4:Clean()
            Cine.Settle(0.4)
            Hud.Fade(0, 0.4)
            u128 = false
            return u127_2
        end
        u128 = false
        if success and typeof(v2) == "string" then
            Toast.Show({Seconds = 2.5, Text = v2, Color = u120})
        end
        return false
    end
    return false
end

local function runGhostFish(a1) -- Line: 421
    -- upvalues: LocalPlayer (val), u128 (ref), Speech (val), Memories (val), Handoff (val), Hud (val), u126 (ref)
    -- upvalues: Npcs (val), u131 (ref), u130 (ref), TutorialBeam (val), Remotes (val), Toast (val), u120 (val)
    -- upvalues: Trove (val), Cine (val), Cast (val), u127 (ref), MusicDirector (val), Chase (val), GhostDogQuest (val)
    -- upvalues: Catch (val), abortSession (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not u128 and Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        u128 = true
        Speech.Stop()
        Memories.Close()
        while Handoff.IsRunning() do
            task.wait()
        end
        local u31 = Hud.Get() == nil
        if u31 then
            Hud.Mount()
        end
        if u126 ~= nil then
            Npcs.SetQuiet(true)
            if u131 ~= nil then
                u131 = nil
                if u130 then
                    TutorialBeam.Destroy(u130)
                    u130 = nil
                end
            end
        end
        Hud.SetObjective(nil)
        Hud.Cinematic(true)

        local function release() -- Line: 443 -- upvalues: u31 (val), u126 (upval), Hud (upval), u128 (upval)
            if u31 and u126 == nil then
                Hud.Unmount()
            end
            u128 = false
        end

        local success, err, v1, v2 = pcall(function() -- Line: 449 -- upvalues: Remotes (upval), a1 (val)
            return Remotes.GhostDogQuest.Cast:InvokeServer(a1.Id)
        end)
        if success and typeof(err) == "number" and type(v2) == "table" then
            local Target = a1.Target
            local v3 = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Target.X, HumanoidRootPart.Position.Y, Target.Z)))

            local function stillHere() -- Line: 461 -- upvalues: LocalPlayer (upval), Character (val)
                local v1 = false
                if LocalPlayer.Character == Character then
                    v1 = Character.Parent ~= nil
                end
                return v1
            end

            local v4 = Trove.new()
            Cine.Hold()
            local u105 = v4:Extend()
            local success_2, err_2 = pcall(Cast.Play, u105, u127, a1)
            if not success_2 then
                warn((("[GhostDogQuest] ghost fish cast failed: %*"):format(err_2)))
            end
            local v5 = false
            if success_2 and err_2 then
                local success_3, err_3 = pcall(function() -- Line: 473 -- upvalues: Remotes (upval)
                    return Remotes.GhostDogQuest.Dive:InvokeServer()
                end)
                v5 = success_3 and err_3 == true
            end
            local u133 = false
            if not v5 then
                pcall(function() -- Line: 319 -- upvalues: Remotes (upval)
                    Remotes.GhostDogQuest.Abort:InvokeServer()
                end)
                u105:Clean()
            else
                v4:Add((MusicDirector.Suppress()))
                local u147 = v4:Extend()
                local success_4, err_4 = pcall(function() -- Line: 482
                    -- upvalues: Chase (upval), u147 (val), err (val), LocalPlayer (upval), Character (val)
                    -- upvalues: GhostDogQuest (upval), u105 (val), u133 (ref), Catch (upval), stillHere (val)
                    local v1, v2, v3
                    v1, _, _, v2, v3 = Chase.Run(u147, err, function() -- Line: 483 -- upvalues: LocalPlayer (upval), Character (upval), GhostDogQuest (upval)
                        local v1 = false
                        if LocalPlayer.Character == Character then
                            v1 = Character.Parent ~= nil
                        end
                        if v1 then
                            v1 = LocalPlayer:GetAttribute(GhostDogQuest.ChaseAttribute) ~= nil
                        end
                        return v1
                    end, u105, {Ending = "Catch"})
                    if v1 == "Won" and v2 then
                        Catch.Play(u147, err, v2, v3, stillHere)
                    end
                end)
                if not success_4 then
                    warn((("[GhostDogQuest] ghost fish chase failed: %*"):format(err_4)))
                end
                u105:Clean()
                if not u133 then
                    local v6 = false
                    if LocalPlayer.Character == Character then
                        v6 = Character.Parent ~= nil
                    end
                    if v6 then
                        pcall(function() -- Line: 319 -- upvalues: Remotes (upval)
                            Remotes.GhostDogQuest.Abort:InvokeServer()
                        end)
                    end
                end
                u147:Clean()
            end
            if v5 then
                local v7 = false
                if LocalPlayer.Character == Character then
                    v7 = Character.Parent ~= nil
                end
                if v7 then
                    local v8 = v4:Extend()
                    local success_7, err_5 = pcall(Catch.Breach, v8, Target, v3, stillHere)
                    if not success_7 then
                        warn((("[GhostDogQuest] ghost fish breach failed: %*"):format(err_5)))
                    end
                    v8:Clean()
                end
            end
            v4:Destroy()
            task.spawn(abortSession)
            Cine.Settle(0.4)
            Hud.Fade(0, 0.4)
            if u31 and u126 == nil then
                Hud.Unmount()
            end
            u128 = false
            return v2
        end
        if success and typeof(v1) == "string" then
            Toast.Show({Seconds = 2.5, Text = v1, Color = u120})
        end
        if u31 and u126 == nil then
            Hud.Unmount()
        end
        u128 = false
        return nil
    end
    return nil
end

local function openCast() -- Line: 519
    -- upvalues: Save (val), GhostDogQuest_2 (val), u128 (ref), u126 (ref), Stage (val), u132 (ref), Hud (val)
    -- upvalues: objectiveFor (val), u127 (ref), LocalPlayer (val), u131 (ref), u130 (ref), TutorialBeam (val)
    local v1 = Save.Peek()
    local GhostDogQuest = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
    if not u128 and GhostDogQuest ~= nil and u126 ~= nil and GhostDogQuest.Stage == Stage.HasRod then
        u132 = true
        Hud.SetObjective((objectiveFor(GhostDogQuest)))
        v1 = u127
        local CastSpot = v1 and v1:FindFirstChild("CastSpot")
        local v2 = if not CastSpot then nil else if not CastSpot:IsA("BasePart") then nil else CastSpot
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
        if v2 and v1 and 18 <= (v1.Position - v2.Position).Magnitude then
            if v2 == u131 then
                return
            end
            u131 = v2
            if u130 then
                TutorialBeam.Destroy(u130)
                u130 = nil
            end
            if v2 then
                TutorialBeam.Attach(v2, {BeamName = "GhostDogGuide"})
            end
        end
        return
    end
end

local function linesFor(a1, a2) -- Line: 533
    -- upvalues: GhostDogQuest (val), GhostDogQuest_2 (val)
    local v1 = GhostDogQuest.Lines[a1]
    if v1 == nil then
        return nil
    end
    if a1 == "DogWaiting" and a2 ~= nil then
        local v2 = GhostDogQuest_2.CountFound(a2)
        local v3 = #GhostDogQuest.Artifacts - v2
        local v4 = {}
        for i, j in v1 do
            table.insert(v4, (string.gsub(string.gsub(j, "{found}", (tostring(v2))), "{left}", (tostring(v3)))))
        end
        return v4
    end
    return v1
end

local talkBody = nil

local function talkTo(a1) -- Line: 554
    -- upvalues: u128 (ref), u134 (ref), talkBody (ref), u129 (ref), Workspace (val), LocalPlayer (val)
    if not u128 and not u134 then
        local success, err = pcall(talkBody, a1)
        if not success then
            warn((("[GhostDogQuest] talk failed: %*"):format(err)))
            u134 = false
            u129 = false
            local CurrentCamera = Workspace.CurrentCamera
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = Humanoid
            end
        end
        return
    end
end

function talkBody(a1) -- Line: 573
    -- upvalues: u128 (ref), u134 (ref), Npcs (val), u126 (ref), u131 (ref), u130 (ref), TutorialBeam (val)
    -- upvalues: Memories (val), Remotes (val), Toast (val), u120 (val), linesFor (val), Save (val)
    -- upvalues: GhostDogQuest_2 (val), Handoff (val), Speech (val), openCast (val), u129 (ref), Stage (val)
    -- upvalues: GhostDogQuest (val), syncWorld (ref), u127 (ref), Hud (val), LocalPlayer (val), talkTo (val)
    if not u128 and not u134 then
        local u8 = if a1 ~= "Dog" then Npcs.Fisherman() else Npcs.Dog()
        local u397 = u126
        if u8 ~= nil and u397 ~= nil then
            u134 = true
            if u131 ~= nil then
                u131 = nil
                if u130 then
                    TutorialBeam.Destroy(u130)
                    u130 = nil
                end
            end
            Memories.Close()
            local success, err, v1 = pcall(function() -- Line: 585 -- upvalues: Remotes (upval), a1 (val)
                return Remotes.GhostDogQuest.Talk:InvokeServer(a1)
            end)
            if success and typeof(err) == "string" then
                local v2
                local v3 = Save.Peek()
                v1 = linesFor(err, if v3 ~= nil then v3.GhostDogQuest or GhostDogQuest_2.Blank() else nil)
                if v1 == nil then
                    u134 = false
                    return
                end
                Npcs.FacePlayer(u8)
                Npcs.SetMarker(a1, nil)
                u8.Prompt.Enabled = false
                u8.Rig:SetMood("Talk")
                if err == "FisherReunion" then
                    u8.Rig:SetMood("Pet")
                    Npcs.SetDogMood("Happy")
                end
                local u84 = if err ~= "FisherReunion" then if err ~= "FisherHint" then nil else if Handoff.HasRod() then nil else 1 else 3
                local u89 = if err ~= "FisherReunion" then if err ~= "FisherHint" then nil else 1 else 4
                local Say = Speech.Say
                local Model = u8.Model
                local Head = u8.Head
                local v4 = {
                    WalkAway = 40,
                    Voice = u8.Voice,
                    Clicks = a1 ~= "Dog",
                    OnLine = function(a1_2) -- Line: 620
                        -- upvalues: u89 (val), openCast (upval), u84 (val), Handoff (upval), u8 (val), a1 (val)
                        -- upvalues: err (val)
                        if a1_2 == u89 then
                            openCast()
                        end
                        if a1_2 == u84 then
                            Handoff.Play(u8)
                            return
                        end
                        if a1 == "Fisherman" then
                            if err ~= "FisherReunion" or a1_2 ~= 1 then
                                u8.Rig:SetMood("Talk")
                            end
                        end
                    end,
                }
                Say(Model, Head, v1, v4)
                u8.Prompt.Enabled = true
                if err == "DogRemembers" then
                    u129 = true
                end
                u134 = false
                local v5 = Save.Peek()
                local GhostDogQuest_4 = if v5 ~= nil then v5.GhostDogQuest or GhostDogQuest_2.Blank() else nil
                if a1 ~= "Dog" then
                    u8.Rig:SetMood("Idle")
                else
                    local Rig = u8.Rig
                    if not GhostDogQuest_4 then
                        v2 = "Idle"
                    elseif GhostDogQuest_4.Stage == Stage.NotMet then
                        v2 = "Sad"
                    elseif GhostDogQuest_4.Stage ~= Stage.Collecting then
                        v2 = "Happy"
                    else
                        v4 = GhostDogQuest_2.CountFound(GhostDogQuest_4)
                        v2 = if not (#GhostDogQuest.Artifacts <= v4) then "Idle" else "Happy"
                    end
                    Rig:SetMood(v2)
                end
                if err == "DogFirst" or err == "DogWaiting" then
                    Memories.Open(u8.Model.PrimaryPart)
                end
                task.delay(if err ~= "DogFirst" then 0.4 else 0.9, function() -- Line: 645 -- upvalues: u126 (upval), u397 (val), syncWorld (upval)
                    if u126 == u397 then
                        syncWorld()
                    end
                end)
                if err ~= "DogRemembers" then
                    return
                end
                v5 = u127
                local DogHome = v5 and v5:FindFirstChild("DogHome")
                v1 = if not DogHome then nil else if not DogHome:IsA("BasePart") then nil else DogHome
                local v6 = u127
                local DockEntrance = v6 and v6:FindFirstChild("DockEntrance")
                v5 = if not DockEntrance then nil else if not DockEntrance:IsA("BasePart") then nil else DockEntrance
                if v1 ~= nil and v5 ~= nil then
                    u8.Prompt.Enabled = false
                    v6 = Npcs.Dog()
                    if v6 then
                        local PrimaryPart = v6.Model.PrimaryPart
                        if PrimaryPart ~= u131 then
                            u131 = PrimaryPart
                            if u130 then
                                TutorialBeam.Destroy(u130)
                                u130 = nil
                            end
                            if PrimaryPart then
                                u130 = TutorialBeam.Attach(PrimaryPart, {BeamName = "GhostDogGuide"})
                            end
                        end
                    end
                    Hud.SetObjective(GhostDogQuest.Objectives.Follow)
                    v2 = Npcs.Lead({v5.Position, v1.Position}, v1.CFrame, function() -- Line: 666 -- upvalues: u126 (upval), u397 (val)
                        return u126 ~= u397
                    end)
                    u129 = false
                    if v6 then
                        v6.Prompt.Enabled = true
                    end
                    if u131 ~= nil then
                        u131 = nil
                        if u130 then
                            TutorialBeam.Destroy(u130)
                            u130 = nil
                        end
                    end
                    if v2 then
                        v6 = Npcs.Fisherman()
                        if v6 then
                            local Character, HumanoidRootPart
                            v6.Prompt.Enabled = true
                            local PrimaryPart_2 = v6.Model.PrimaryPart
                            if PrimaryPart_2 ~= u131 then
                                u131 = PrimaryPart_2
                                if u130 then
                                    TutorialBeam.Destroy(u130)
                                    u130 = nil
                                end
                                if PrimaryPart_2 then
                                    u130 = TutorialBeam.Attach(PrimaryPart_2, {BeamName = "GhostDogGuide"})
                                end
                            end
                            v5 = os.clock()
                            while u126 == u397 do
                                if not (os.clock() - v5 < 90) then
                                    break
                                end
                                Character = LocalPlayer.Character
                                HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                                v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                                if v1 and (v1.Position - v6.Rig.Root.Position).Magnitude <= 16 then
                                    if u131 ~= nil then
                                        u131 = nil
                                        if u130 then
                                            TutorialBeam.Destroy(u130)
                                            u130 = nil
                                        end
                                    end
                                    task.spawn(talkTo, "Fisherman")
                                    return
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                    return
                end
                u129 = false
                return
            end
            u134 = false
            if success and typeof(v1) == "string" then
                Toast.Show({Seconds = 2.5, Text = v1, Color = u120})
            end
            return
        end
        return
    end
end

function syncWorld() -- Line: 699
    -- upvalues: Save (val), GhostDogQuest_2 (val), u126 (ref), u134 (ref), Stage (val), Memories (val), Artifacts (val)
    -- upvalues: u127 (ref), u128 (ref), Hud (val), objectiveFor (val), toggleMemories (val), GhostDogQuest (val)
    -- upvalues: u129 (ref), Npcs (val), u132 (ref), LocalPlayer (val), u131 (ref), u130 (ref), TutorialBeam (val)
    -- upvalues: u133 (ref), u136 (ref)
    local v1 = Save.Peek()
    local GhostDogQuest_3 = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
    v1 = u126
    if GhostDogQuest_3 ~= nil and v1 ~= nil and not u134 then
        local v2
        v1 = GhostDogQuest_3.Stage == Stage.Collecting
        Memories.Sync(GhostDogQuest_3.Artifacts, GhostDogQuest_3.Stage <= Stage.Collecting)
        local v3 = v1 and not u128
        Artifacts.Sync(u127, GhostDogQuest_3.Artifacts, v3)
        if not u128 then
            v2 = if not v1 then nil else toggleMemories
            Hud.SetObjective(objectiveFor(GhostDogQuest_3), v2)
        end
        v1 = nil
        if GhostDogQuest_3.Stage == Stage.NotMet then
            v1 = "!"
        elseif GhostDogQuest_3.Stage == Stage.Collecting then
            local v4 = GhostDogQuest_2.CountFound(GhostDogQuest_3)
            if #GhostDogQuest.Artifacts <= v4 then
                v1 = "?"
            end
        end
        if not u129 then
            Npcs.SetMarker("Dog", v1)
        end
        Npcs.SetMarker("Fisherman", if GhostDogQuest_3.Stage ~= Stage.Reunion then nil else if u129 then nil else "!")
        Npcs.SetQuiet(u128 or u129)
        if not u128 then
            Npcs.SetRodVisible(true)
        end
        v1 = Npcs.Dog()
        if v1 and not u129 and not u134 and not u128 then
            local Rig = v1.Rig
            if GhostDogQuest_3.Stage == Stage.NotMet then
                v2 = "Sad"
            elseif GhostDogQuest_3.Stage ~= Stage.Collecting then
                v2 = "Happy"
            else
                local v5 = GhostDogQuest_2.CountFound(GhostDogQuest_3)
                v2 = if not (#GhostDogQuest.Artifacts <= v5) then "Idle" else "Happy"
            end
            Rig:SetMood(v2)
            v1.Prompt.ObjectText = GhostDogQuest.DogName
        end
        local v6 = false
        if GhostDogQuest_3.Stage == Stage.HasRod then
            v6 = not u128
        end
        u132 = v6
        if not u128 and not u129 and not u134 then
            local CastSpot
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            v6 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
            local PrimaryPart = nil
            if GhostDogQuest_3.Stage == Stage.Collecting then
                v3 = GhostDogQuest_2.CountFound(GhostDogQuest_3)
                v2 = #GhostDogQuest.Artifacts <= v3
                if not v2 then
                    if GhostDogQuest_3.Stage == Stage.Reunion then
                        v2 = Npcs.Fisherman()
                        PrimaryPart = v2 and v2.Model.PrimaryPart
                    elseif GhostDogQuest_3.Stage == Stage.HasRod then
                        v2 = u127
                        CastSpot = v2 and v2:FindFirstChild("CastSpot")
                        PrimaryPart = if not CastSpot then nil else if not CastSpot:IsA("BasePart") then nil else CastSpot
                    end
                elseif v1 then
                    PrimaryPart = v1.Model.PrimaryPart
                elseif GhostDogQuest_3.Stage == Stage.Reunion then
                    v2 = Npcs.Fisherman()
                    PrimaryPart = v2 and v2.Model.PrimaryPart
                elseif GhostDogQuest_3.Stage == Stage.HasRod then
                    v2 = u127
                    CastSpot = v2 and v2:FindFirstChild("CastSpot")
                    PrimaryPart = if not CastSpot then nil else if not CastSpot:IsA("BasePart") then nil else CastSpot
                end
            elseif GhostDogQuest_3.Stage == Stage.Reunion then
                v2 = Npcs.Fisherman()
                PrimaryPart = v2 and v2.Model.PrimaryPart
            elseif GhostDogQuest_3.Stage == Stage.HasRod then
                v2 = u127
                CastSpot = v2 and v2:FindFirstChild("CastSpot")
                PrimaryPart = if not CastSpot then nil else if not CastSpot:IsA("BasePart") then nil else CastSpot
            end
            if PrimaryPart and v6 and (v6.Position - PrimaryPart.Position).Magnitude < 18 then
                PrimaryPart = nil
            end
            if PrimaryPart ~= u131 then
                u131 = PrimaryPart
                if u130 then
                    TutorialBeam.Destroy(u130)
                    u130 = nil
                end
                if PrimaryPart then
                    TutorialBeam.Attach(PrimaryPart, {BeamName = "GhostDogGuide"})
                end
            end
        end
        if u133 ~= GhostDogQuest_3.Stage then
            v1 = u133
            u133 = GhostDogQuest_3.Stage
            if v1 == Stage.HasRod and GhostDogQuest_3.Stage == Stage.Done then
                u136 = os.clock() + 20
            end
        end
        return
    end
end

local function mountWorld() -- Line: 756
    -- upvalues: Workspace (val), HalloweenDimension (val), GhostDogQuest (val), Save (val), GhostDogQuest_2 (val)
    -- upvalues: u127 (ref), Trove (val), u126 (ref), Hud (val), Memories (val), Npcs (val), Stage (val), Handoff (val)
    -- upvalues: Artifacts (val), Speech (val), u131 (ref), u130 (ref), TutorialBeam (val), u132 (ref), talkTo (val)
    -- upvalues: buildCastRing (val), buildCastSpot (val), u133 (ref), syncWorld (ref)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    local v2 = v1 and v1:FindFirstChild(GhostDogQuest.FolderName)
    v1 = v2 and v2:FindFirstChild(GhostDogQuest.MarkersName)
    local v3 = if v1 == nil then nil else if not v1:IsA("Folder") then nil else v1
    v2 = Save.Peek()
    local GhostDogQuest_3 = if v2 ~= nil then v2.GhostDogQuest or GhostDogQuest_2.Blank() else nil
    if v3 ~= nil and GhostDogQuest_3 ~= nil then
        u127 = v3
        v2 = Trove.new()
        u126 = v2
        Hud.Mount()
        v2:Add(Hud.Unmount)
        v2:Add(Memories.Reset)
        local Spawn = Npcs.Spawn
        local v4 = Stage.Reunion <= GhostDogQuest_3.Stage
        local v5 = false
        if GhostDogQuest_3.Stage == Stage.HasRod then
            v5 = Handoff.HasRod()
        end
        Spawn(v3, v4, v5)
        v2:Add(Npcs.Clear)
        v2:Add(Artifacts.Clear)
        v2:Add(Speech.Stop)
        v2:Add(function() -- Line: 776 -- upvalues: u131 (upval), u130 (upval), TutorialBeam (upval), u132 (upval)
            if u131 ~= nil then
                u131 = nil
                if u130 then
                    TutorialBeam.Destroy(u130)
                    u130 = nil
                end
            end
            u132 = false
        end)
        v3 = Npcs.Dog()
        local v6 = Npcs.Fisherman()
        if v3 then
            v2:Connect(v3.Prompt.Triggered, function() -- Line: 783 -- upvalues: talkTo (upval)
                task.spawn(talkTo, "Dog")
            end)
        end
        if v6 then
            v2:Connect(v6.Prompt.Triggered, function() -- Line: 788 -- upvalues: talkTo (upval)
                task.spawn(talkTo, "Fisherman")
            end)
        end
        buildCastRing(v2)
        buildCastSpot(v2)
        u133 = GhostDogQuest_3.Stage
        syncWorld()
        return
    end
end

local function unmountWorld() -- Line: 798 -- upvalues: u126 (ref), u127 (ref), u129 (ref), u134 (ref)
    local v1 = u126
    u126 = nil
    u127 = nil
    u129 = false
    u134 = false
    if v1 then
        v1:Destroy()
    end
end

local function syncRunning() -- Line: 809
    -- upvalues: LocalPlayer (val), PlayerAttributes (val), Hud (val), Memories (val)
    local v1
    Hud.SetHidden(LocalPlayer:GetAttribute(PlayerAttributes.Carrying) == true)
    if v1 and Memories.IsOpen() then
        Memories.Close()
    end
end

local function refresh() -- Line: 817
    -- upvalues: GhostDogQuestFlags (val), LocalPlayer (val), PlayerAttributes (val), Workspace (val)
    -- upvalues: HalloweenDimension (val), GhostDogQuest (val), Save (val), u126 (ref), mountWorld (val), u128 (ref)
    -- upvalues: u127 (ref), u129 (ref), u134 (ref), syncWorld (ref)
    local v1, v2
    local v3 = GhostDogQuestFlags.Enabled:Get()
    if v3 then
        v3 = false
        if LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true then
            v3 = false
            v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
            v2 = v1 and v1:FindFirstChild(GhostDogQuest.FolderName)
            v1 = v2 and v2:FindFirstChild(GhostDogQuest.MarkersName)
            if (if v1 == nil then nil else if not v1:IsA("Folder") then nil else v1) ~= nil then
                v3 = Save.IsLoaded()
            end
        end
    end
    if v3 and u126 == nil then
        mountWorld()
        return
    end
    if not v3 and u126 ~= nil and not u128 then
        local v4 = u126
        u126 = nil
        u127 = nil
        u129 = false
        u134 = false
        if not v4 then
            return
        end
        v4:Destroy()
        return
    end
    if v3 then
        v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        v2 = v1 and v1:FindFirstChild(GhostDogQuest.FolderName)
        v1 = v2 and v2:FindFirstChild(GhostDogQuest.MarkersName)
        if (if v1 == nil then nil else if not v1:IsA("Folder") then nil else v1) ~= u127 and not u128 then
            v1 = u126
            u126 = nil
            u127 = nil
            u129 = false
            u134 = false
            if v1 then
                v1:Destroy()
            end
            mountWorld()
            return
        end
        syncWorld()
    end
end

function v1.PrepareCast() -- Line: 834
    -- upvalues: Save (val), GhostDogQuest_2 (val), Stage (val), u126 (ref), u128 (ref), Handoff (val), u134 (ref)
    -- upvalues: Speech (val), Memories (val)
    local v1 = Save.Peek()
    local GhostDogQuest = if v1 ~= nil then v1.GhostDogQuest or GhostDogQuest_2.Blank() else nil
    if GhostDogQuest ~= nil and GhostDogQuest.Stage == Stage.HasRod and u126 ~= nil then
        if not u128 and not Handoff.IsRunning() then
            if u134 then
                Speech.Stop()
            end
            Memories.Close()
            return true
        end
        return false
    end
    return true
end

function v1.Hooked(a1) -- Line: 849 -- upvalues: runCast (val)
    return (runCast(a1))
end

function v1.GhostFish(a1) -- Line: 853 -- upvalues: runGhostFish (val) -- types: a1: table
    return (runGhostFish(a1))
end

function v1.Start() -- Line: 857
    -- upvalues: Trove (val), Save (val), refresh (val), LocalPlayer (val), PlayerAttributes (val)
    -- upvalues: GhostDogQuestFlags (val), syncRunning (val), Hud (val), Memories (val), RunService (val)
    -- upvalues: unmountWorld (val)
    local v1
    local v2 = Trove.new()
    v2:Connect(Save.Watch("GhostDogQuest"), function() -- Line: 859 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    v2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Inside), function() -- Line: 862 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    v2:Connect(GhostDogQuestFlags.Enabled.Changed, function() -- Line: 865 -- upvalues: refresh (upval)
        task.defer(refresh)
    end)
    v2:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Carrying), syncRunning)
    Hud.SetHidden(LocalPlayer:GetAttribute(PlayerAttributes.Carrying) == true)
    if v1 and Memories.IsOpen() then
        Memories.Close()
    end
    local u57 = 0
    v2:Connect(RunService.Heartbeat, function(a1) -- Line: 874 -- upvalues: u57 (ref), refresh (upval) -- types: a1: number
        u57 = u57 + a1
        if u57 >= 0.5 then
            u57 = 0
            refresh()
        end
    end)
    v2:Add(unmountWorld)
    task.spawn(function() -- Line: 882 -- upvalues: Save (upval), refresh (upval)
        Save.Await()
        refresh()
    end)
    return v2
end

return v1