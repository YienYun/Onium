-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Npcs
-- Decompile time: 26.99 ms

local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Rig = require(script.Parent.Rig)
local Speech = require(script.Parent.Speech)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local GhostDogQuest_2 = ReplicatedStorage.Assets.GhostDogQuest
local u56 = {
    AgentRadius = 2.5,
    AgentHeight = 5,
    AgentCanJump = true,
    AgentCanClimb = false,
    WaypointSpacing = 6,
    Costs = {Water = (1 / 0)},
}
local BuddyChatter2 = ReplicatedStorage.Assets.ShootingStar.Sounds.BuddyChatter2
local u64 = Trove.new()
local u65 = nil
local u66 = nil
local u67 = nil
local u68 = nil
local u69 = false
local u70 = false
local u71 = 0
local u72 = {}

local function rootOf() -- Line: 63 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function makePrompt(a1, a2, a3, a4) -- Line: 69 -- types: a1: userdata, a2: string, a3: string, a4: number
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.ActionText = a2
    ProximityPrompt.ObjectText = a3
    ProximityPrompt.HoldDuration = 0
    ProximityPrompt.MaxActivationDistance = a4
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX
    ProximityPrompt.Parent = a1
    return ProximityPrompt
end

local function groundFilter() -- Line: 88 -- upvalues: Workspace (val), HalloweenDimension (val), GhostDogQuest (val)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    local v2 = {}
    if v1 then
        local v3
        for i, j in {"Ground", "Paths"} do
            v3 = v1:FindFirstChild(j)
            if v3 then
                table.insert(v2, v3)
            end
        end
        local v4 = v1:FindFirstChild(GhostDogQuest.FolderName)
        local Dock = v4 and v4:FindFirstChild("Dock")
        if Dock then
            table.insert(v2, Dock)
        end
    end
    return v2
end

local function groundBelow(a1, a2) -- Line: 107 -- upvalues: Workspace (val) -- types: a1: vector, a2: userdata
    local v1 = Workspace:Raycast(a1 + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), a2)
    if v1 then
        return v1.Position.Y
    end
    return nil
end

local function headOf(a1) -- Line: 112 -- types: a1: userdata
    local v1
    local Head = a1:FindFirstChild("Head")
    if Head and Head:IsA("BasePart") then
        return Head
    end
    local PrimaryPart = a1.PrimaryPart
    local v2 = (-1 / 0)
    for i, j in a1:GetDescendants() do
        if j:IsA("MeshPart") then
            v1 = j.Position.Y + j.Size.Y * 0.5
            if v2 < v1 then
                PrimaryPart = j
            end
        end
    end
    return PrimaryPart
end

local function voiceOf(a1) -- Line: 131 -- upvalues: BuddyChatter2 (val) -- types: a1: userdata
    local v1 = {}
    local Barks = a1:FindFirstChild("Barks")
    if Barks then
        for i, j in Barks:GetChildren() do
            if j:IsA("Sound") then
                table.insert(v1, j)
            end
        end
    end
    if #v1 == 0 then
        table.insert(v1, BuddyChatter2)
    end
    return v1
end

local function build(a1, a2, a3, a4) -- Line: 147
    -- upvalues: u64 (val), Workspace (val), Rig (val), headOf (val), GhostDogQuest (val), voiceOf (val)
    local v1 = u64:Clone(a1)
    v1:PivotTo(a2)
    v1.Parent = Workspace
    local v2 = Rig.new(v1, a3)
    v2:SetRoot(a2)
    local v3 = headOf(v1)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "PromptPoint"
    Attachment.Position = Vector3.new(0, 3, 0)
    Attachment.Parent = v1.PrimaryPart
    local TalkDistance = GhostDogQuest.TalkDistance
    local v4 = Instance.new("ProximityPrompt")
    v4.ActionText = "Talk"
    v4.ObjectText = a4
    v4.HoldDuration = 0
    v4.MaxActivationDistance = TalkDistance
    v4.RequiresLineOfSight = false
    v4.Style = Enum.ProximityPromptStyle.Custom
    v4.KeyboardKeyCode = Enum.KeyCode.E
    v4.GamepadKeyCode = Enum.KeyCode.ButtonX
    v4.Parent = Attachment
    local v5 = Instance.new("BillboardGui")
    v5.Name = "QuestMarker"
    v5.Size = UDim2.fromScale(2.4, 2.4)
    v5.StudsOffset = Vector3.new(0, 3.200000047683716, 0)
    v5.AlwaysOnTop = false
    v5.LightInfluence = 0
    v5.Brightness = 1.5
    v5.MaxDistance = 220
    v5.Enabled = false
    v5.Adornee = v3
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Mark"
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = Color3.fromRGB(255, 225, 90)
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 4
    UIStroke.Parent = TextLabel
    TextLabel.Parent = v5
    v5.Parent = v1
    return {
        Model = v1,
        Rig = v2,
        Head = v3,
        Prompt = v4,
        Home = a2,
        Voice = voiceOf(v1),
    }
end

local function holdTrack(a1) -- Line: 192 -- types: a1: table
    local Animations = a1.Model:FindFirstChild("Animations")
    local Hold = Animations and Animations:FindFirstChild("Hold")
    local v1 = a1.Model:FindFirstChildOfClass("Humanoid")
    local Animator = v1 and v1:FindFirstChildOfClass("Animator")
    if Hold ~= nil and Hold:IsA("Animation") and Animator ~= nil then
        local success, err = pcall(Animator.LoadAnimation, Animator, Hold)
        if success and err ~= nil then
            err.Priority = Enum.AnimationPriority.Movement
            err.Looped = true
            return err
        end
        return nil
    end
    return nil
end

local function planted(a1) -- Line: 209 -- upvalues: groundFilter (val), Workspace (val) -- types: a1: userdata
    local Y
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = groundFilter()
    local v2 = Workspace:Raycast(a1.Position + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v1)
    if (if not v2 then nil else v2.Position.Y) == nil then
        return a1
    end
    return a1.Rotation + Vector3.new(a1.X, Y, a1.Z)
end

function u72.Spawn(a1, a2, a3) -- Line: 220
    -- upvalues: u72 (val), u65 (ref), build (val), GhostDogQuest_2 (val), groundFilter (val), Workspace (val)
    -- upvalues: Rig (val), GhostDogQuest (val), u66 (ref), u67 (ref), holdTrack (val), u68 (ref), u69 (ref), u64 (val)
    -- upvalues: RunService (val), u70 (ref), Speech (val)
    u72.Clear()
    local CFrame = a1:FindFirstChild(if not a2 then "DogSpot" else "DogHome").CFrame
    local CFrame_2 = a1:FindFirstChild("FishermanSpot").CFrame
    local GhostDog = GhostDogQuest_2.GhostDog
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = groundFilter()
    local v2 = Workspace:Raycast(CFrame.Position + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v1)
    local Y = if not v2 then nil else v2.Position.Y
    u65 = build(GhostDog, if Y ~= nil then CFrame.Rotation + Vector3.new(CFrame.X, Y, CFrame.Z) else CFrame, Rig.Dog, GhostDogQuest.DogName)
    local GhostFisherman = GhostDogQuest_2.GhostFisherman
    v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = groundFilter()
    v2 = Workspace:Raycast(CFrame_2.Position + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v1)
    local Y_2 = if not v2 then nil else v2.Position.Y
    local v3 = build(
        GhostFisherman,
        if Y_2 ~= nil then CFrame_2.Rotation + Vector3.new(CFrame_2.X, Y_2, CFrame_2.Z) else CFrame_2,
        Rig.Fisherman,
        GhostDogQuest.FishermanName
    )
    u66 = v3
    holdTrack(v3)
    u72.SetRodVisible(true)
    u68 = nil
    u69 = false
    u64:Connect(RunService.RenderStepped, function(a1) -- Line: 238
        -- upvalues: u70 (upval), Speech (upval), GhostDogQuest (upval), u65 (upval), u68 (upval), u69 (upval)
        -- upvalues: u66 (upval)
        local TalkDistance = if u70 then 0 else if not Speech.IsTalking() then GhostDogQuest.TalkDistance else 0
        local v1 = u65
        if v1 then
            v1.Prompt.MaxActivationDistance = TalkDistance
            local v2 = u68
            if v2 and not u69 then
                local Root = v1.Rig.Root
                local v3 = Root.Rotation:Lerp(v2.Rotation, (math.min(a1 * 8, 1)))
                v1.Rig:SetRoot((CFrame.new(Root.Position)) * v3)
            end
            v1.Rig:Step(a1)
            local QuestMarker = v1.Model:FindFirstChild("QuestMarker")
            if QuestMarker and QuestMarker:IsA("BillboardGui") and QuestMarker.Enabled then
                QuestMarker.StudsOffset = Vector3.new(0, math.sin((os.clock()) * 4) * 0.35 + 3.2, 0)
            end
        end
        v1 = u66
        if v1 then
            v1.Prompt.MaxActivationDistance = TalkDistance
            v1.Rig:Step(a1)
        end
    end)
end

function u72.SetQuiet(a1) -- Line: 263 -- upvalues: u70 (ref) -- types: a1: boolean
    u70 = a1
end

function u72.Rod() -- Line: 267 -- upvalues: u66 (ref)
    local v1 = u66
    local Rod = v1 and v1.Model:FindFirstChild("Rod")
    if Rod and Rod:IsA("Model") then
        return Rod
    end
    return nil
end

function u72.SetRodVisible(a1) -- Line: 273 -- upvalues: u72 (val), u67 (ref) -- types: a1: boolean
    local v1 = u72.Rod()
    if v1 == nil then
        return
    end
    local v2 = u67
    if not v2 or not a1 then
        if v2 and not a1 and v2.IsPlaying then
            v2:Stop(0.2)
        end
    elseif not v2.IsPlaying then
        v2:Play(0.2)
    elseif v2 and not a1 and v2.IsPlaying then
        v2:Stop(0.2)
    end
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.LocalTransparencyModifier = if not a1 then 1 else 0
        elseif j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") or j:IsA("Trail") then
            j.Enabled = a1
        end
    end
end

function u72.SetMarker(a1, a2) -- Line: 298
    -- upvalues: u65 (ref), u66 (ref), Fx (val)
    local v1 = if a1 ~= "Dog" then u66 else u65
    local QuestMarker = v1 and v1.Model:FindFirstChild("QuestMarker")
    if QuestMarker ~= nil and QuestMarker:IsA("BillboardGui") then
        v1 = QuestMarker:FindFirstChild("Mark")
        local v2 = a2 ~= nil
        if not v2 then
            if not v2 then
                QuestMarker.Enabled = false
            end
            return
        end
        if QuestMarker.Enabled and v1.Text == a2 then
            if not v2 then
                QuestMarker.Enabled = false
            end
            return
        end
        v1.Text = a2
        QuestMarker.Enabled = true
        local UIScale = v1:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        UIScale.Parent = v1
        Fx.Punch(UIScale, 1.6, 0.35)
        return
    end
end

function u72.Clear() -- Line: 317 -- upvalues: u64 (val), u65 (ref), u66 (ref), u67 (ref), u68 (ref), u69 (ref)
    u64:Clean()
    u65 = nil
    u66 = nil
    u67 = nil
    u68 = nil
    u69 = false
end

function u72.Dog() -- Line: 326 -- upvalues: u65 (ref)
    return u65
end

function u72.Fisherman() -- Line: 330 -- upvalues: u66 (ref)
    return u66
end

function u72.FacePlayer(a1) -- Line: 334
    -- upvalues: LocalPlayer (val), u65 (ref), u68 (ref), Fx (val)
    local v1
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if (if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart) == nil then
        return
    end
    local Position = a1.Rig.Root.Position
    local v2 = Vector3.new(v1.Position.X, Position.Y, v1.Position.Z)
    if (v2 - Position).Magnitude < 0.5 then
        return
    end
    if a1 == u65 then
        CFrame.lookAt(Position, v2)
        return
    end
    local Root = a1.Rig.Root
    local u42 = CFrame.lookAt(Position, v2)
    task.spawn(function() -- Line: 349 -- upvalues: Fx (upval), a1 (val), Root (val), u42 (val)
        local v1 = os.clock()
        while true do
            if not (os.clock() - v1 < 0.35) then
                break
            end
            a1.Rig:SetRoot((Root:Lerp(u42, (Fx.Ease((os.clock() - v1) / 0.35)))))
            task.wait()
        end
        a1.Rig:SetRoot(u42)
    end)
end

function u72.SetDogMood(a1) -- Line: 361 -- upvalues: u65 (ref) -- types: a1: string
    if u65 then
        u65.Rig:SetMood(a1)
    end
end

function u72.SetFishermanMood(a1) -- Line: 367 -- upvalues: u66 (ref) -- types: a1: string
    if u66 then
        u66.Rig:SetMood(a1)
    end
end

local function yawOf(a1) -- Line: 373 -- types: a1: vector
    return (math.atan2(-a1.X, -a1.Z))
end

local function barkEcho() -- Line: 377
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = 1.1
    ReverbSoundEffect.Density = 0.8
    ReverbSoundEffect.Diffusion = 0.9
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -9
    return {ReverbSoundEffect}
end

local function bark(a1) -- Line: 387 -- upvalues: u71 (ref), Fx (val) -- types: a1: table
    local Voice = a1.Voice
    if #Voice == 0 then
        return
    end
    local v1 = math.random(1, #Voice)
    if #Voice > 1 and v1 == u71 then
        v1 = v1 % #Voice + 1
    end
    u71 = v1
    local PlayAt = Fx.PlayAt
    local v2 = Voice[v1]
    local Head = a1.Head
    local v3 = {
        Volume = 1,
        MaxDistance = 160,
        Looped = false,
        PlaybackSpeed = 1.08 + math.random() * 0.06,
    }
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = 1.1
    ReverbSoundEffect.Density = 0.8
    ReverbSoundEffect.Diffusion = 0.9
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -9
    v3.Effects = {ReverbSoundEffect}
    local v4 = PlayAt(v2, Head, v3)
    if v4 then
        v4.RollOffMode = Enum.RollOffMode.Inverse
        v4.RollOffMinDistance = 30
    end
end

local function turnToward(a1, a2, a3) -- Line: 410 -- types: a1: number, a2: number, a3: number
    return a1 + ((a2 - a1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * math.min(a3, 1)
end

local function pathLeg(a1, a2) -- Line: 415
    -- upvalues: PathfindingService (val), u56 (val)
    local u6 = PathfindingService:CreatePath(u56)
    local success = pcall(function() -- Line: 417 -- upvalues: u6 (val), a1 (val), a2 (val)
        u6:ComputeAsync(a1, a2)
    end)
    if success and u6.Status == Enum.PathStatus.Success then
        local v1 = {}
        for i, j in u6:GetWaypoints() do
            table.insert(v1, j.Position)
        end
        if #v1 == 0 then
            return {a2}
        end
        table.remove(v1, 1)
        if #v1 == 0 or 4 < (v1[#v1] - a2).Magnitude then
            table.insert(v1, a2)
        end
        return v1
    end
    return {a2}
end

local function pathRoute(a1, a2) -- Line: 437 -- upvalues: pathLeg (val) -- types: a1: vector, a2: table
    local v1 = {}
    local v2 = nil
    local v3 = nil
    for i, j in a2, v2, v3 do
        for k, n in pathLeg(a1, j) do
            table.insert(v1, n)
        end
    end
    return v1
end

function u72.Lead(a1, a2, a3) -- Line: 449
    -- upvalues: u65 (ref), u69 (ref), u68 (ref), groundFilter (val), Workspace (val), pathRoute (val)
    -- upvalues: LocalPlayer (val), u72 (val), bark (val), Fx (val)
    local Character, Character_2, HumanoidRootPart, Magnitude_2, Unit, WalkSpeed, Y_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local u553 = u65
    if u553 == nil then
        return false
    end
    u69 = true
    u68 = nil
    local v12 = a2
    local v13 = RaycastParams.new()
    v13.FilterType = Enum.RaycastFilterType.Include
    v13.FilterDescendantsInstances = groundFilter()
    local v14 = Workspace:Raycast(v12.Position + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v13)
    local Y = if not v14 then nil else v14.Position.Y
    local v15 = if Y ~= nil then v12.Rotation + Vector3.new(v12.X, Y, v12.Z) else v12
    v12 = RaycastParams.new()
    v12.FilterType = Enum.RaycastFilterType.Include
    v12.FilterDescendantsInstances = groundFilter()
    local Position_2 = u553.Rig.Root.Position
    local LookVector = u553.Rig.Root.LookVector
    local v16 = math.atan2(-LookVector.X, -LookVector.Z)
    local v17 = 0
    v14 = false
    local v18 = (-1 / 0)
    local u449 = ""

    local function setMood(a1) -- Line: 466 -- upvalues: u449 (ref), u553 (val) -- types: a1: string
        if u449 ~= a1 then
            u449 = a1
            u553.Rig:SetMood(a1)
        end
    end

    local v19 = pathRoute(Position_2, a1)
    local v20 = 1
    while v20 <= #v19 do
        if not a3() and u65 == u553 then
            v2 = math.min(task.wait(), 0.1)
            v3 = v19[v20]
            v4 = Vector3.new(v3.X - Position_2.X, 0, v3.Z - Position_2.Z)
            v6 = if not (v20 == #v19) then 2.5 else 1.5
            if not (v4.Magnitude < v6) then
                Character = LocalPlayer.Character
                HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                v5 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                Character_2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                WalkSpeed = if not Character_2 then 16 else Character_2.WalkSpeed
                Magnitude_2 = if not v5 then 0 else Vector3.new(v5.Position.X - Position_2.X, 0, v5.Position.Z - Position_2.Z).Magnitude
                if not v14 then
                    if not v14 and Magnitude_2 >= 96 then
                        v14 = true
                        u72.SetMarker("Dog", "!")
                        v18 = os.clock()
                        bark(u553)
                    end
                elseif Magnitude_2 <= 54 then
                    v14 = false
                    u72.SetMarker("Dog", nil)
                elseif not v14 and Magnitude_2 >= 96 then
                    v14 = true
                    u72.SetMarker("Dog", "!")
                    v18 = os.clock()
                    bark(u553)
                end
                v6 = math.clamp(WalkSpeed * (if not (Magnitude_2 < 54) then 0.55 else 1), 16, 90)
                if v3 then
                    v6 = math.min(v6, (math.max(v4.Magnitude * 3, 8)))
                end
                v7 = if not (v17 < (if not v14 then v6 else 0)) then 120 else 70
                v17 = v17 + math.clamp(v8 - v17, -v7 * v2, v7 * v2)
                Unit = v4.Unit
                if v14 and v5 then
                    v7 = Vector3.new(v5.Position.X - Position_2.X, 0, v5.Position.Z - Position_2.Z)
                    if 1 < v7.Magnitude then
                        Unit = v7.Unit
                    end
                end
                v9 = v16
                v11 = math.atan2(-Unit.X, -Unit.Z)
                v10 = v2 * 8
                v16 = v9 + ((v11 - v9 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * math.min(v10, 1)
                v5 = Position_2 + v4.Unit * math.min(v17 * v2, v4.Magnitude)
                v4 = Workspace:Raycast(v5 + Vector3.new(0, 30, 0), Vector3.new(0, -90, 0), v12)
                Y_2 = if not v4 then nil else v4.Position.Y
                Position_2 = Vector3.new(v5.X, Position_2.Y + ((if not Y_2 then Position_2.Y else Y_2) - Position_2.Y) * math.min(v2 * 12, 1), v5.Z)
                v9 = if not (v17 > 6) then if not v14 then "Idle" else "Happy" else "Run"
                if u449 ~= v9 then
                    u449 = v9
                    u553.Rig:SetMood(v9)
                end
                u553.Rig:SetPace(v17)
                v8 = (os.clock() - v18) / 0.3
                u553.Rig:SetRoot((CFrame.new(Position_2 + Vector3.new(0, if not (v8 < 1) then 0 else math.sin(v8 * 3.141592653589793) * 0.8, 0))) * (CFrame.Angles(0, v16, 0)))
            else
                v20 = v20 + 1
            end
            continue
        end
        u69 = false
        return false
    end
    u72.SetMarker("Dog", nil)
    local Root = u553.Rig.Root
    if u449 ~= "Happy" then
        u553.Rig:SetMood("Happy")
    end
    v19 = os.clock()
    while true do
        if not (os.clock() - v19 < 0.7) then
            break
        end
        v1 = (os.clock() - v19) / 0.7
        v18 = math.abs((math.sin(v1 * 3.141592653589793 * 2))) * 1.4 * (1 - v1)
        u553.Rig:SetRoot((Root:Lerp(v15, (Fx.Ease(v1)))) + (Vector3.new(0, v18, 0)))
        task.wait()
    end
    u553.Rig:SetRoot(v15)
    u553.Home = v15
    u68 = nil
    u69 = false
    return true
end

return (table.freeze(u72))