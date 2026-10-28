-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Artifacts
-- Decompile time: 8.58 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Memories = require(script.Parent.Memories)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local GhostDogQuest_2 = ReplicatedStorage.Assets.GhostDogQuest
local CollectFirefly = ReplicatedStorage.Assets.Sounds.BeanstalkEvent.CollectFirefly
local u53 = Color3.fromRGB(255, 85, 85)
local u58 = Color3.fromRGB(150, 225, 255)
local u59 = {}
local u60 = false
local u61 = {}
local v1 = {}

local function pillar(a1, a2) -- Line: 43 -- upvalues: Fx (val) -- types: a2: vector
    local v1 = a1:Add((Instance.new("Part")))
    v1.Name = "GhostDogPillar"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.Transparency = 1
    v1.Size = Vector3.new(1, 1, 1)
    v1.CFrame = CFrame.new(a2)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = v1
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = Fx.Sparkle
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(190, 245, 255))
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Rate = 6
    ParticleEmitter.Lifetime = NumberRange.new(1.5, 2.5)
    ParticleEmitter.Speed = NumberRange.new(4, 8)
    ParticleEmitter.SpreadAngle = Vector2.new(12, 12)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Size = NumberSequence.new(0.5, 0)
    ParticleEmitter.Parent = Attachment
    local PointLight = Instance.new("PointLight")
    PointLight.Color = Color3.fromRGB(150, 235, 255)
    PointLight.Range = 14
    PointLight.Brightness = 1.2
    PointLight.Parent = v1
    v1.Parent = workspace
    return v1
end

local function take(a1) -- Line: 75
    -- upvalues: u60 (ref), Remotes (val), Toast (val), u53 (val), u61 (val), Fx (val), CollectFirefly (val), u59 (val)
    -- upvalues: GhostDogQuest (val), u58 (val), Memories (val)
    if not a1.Taken and not u60 then
        u60 = true
        local success, err, v1 = pcall(function() -- Line: 80 -- upvalues: Remotes (upval), a1 (val)
            return Remotes.GhostDogQuest.Collect:InvokeServer(a1.Artifact.Id)
        end)
        u60 = false
        if success and err == true then
            local v2
            a1.Taken = true
            u61[a1.Artifact.Id] = true
            a1.Prompt.Enabled = false
            local Model = a1.Model
            local v3 = Model:GetPivot()
            Fx.Play(CollectFirefly, {Volume = 0.7})
            Fx.Burst(v3.Position, Color3.fromRGB(190, 245, 255), 28, 18, 0.9)
            Fx.Ring(CFrame.new(v3.Position - Vector3.new(0, 2.9000000953674316, 0)), Color3.fromRGB(150, 235, 255), 2, 18, 0.6)
            local v4 = os.clock()
            while true do
                if not (os.clock() - v4 < 0.45) then
                    break
                end
                v2 = (os.clock() - v4) / 0.45
                Model:PivotTo((CFrame.new(v3.Position + Vector3.new(0, (Fx.Ease(v2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)) * 4, 0))) * (CFrame.Angles(0, v2 * 12, 0)))
                Model:ScaleTo((math.max(math.sin(v2 * 3.141592653589793) * 0.6 + 1 - v2 * 0.9, 0.05)))
                task.wait()
            end
            a1.Trove:Destroy()
            u59[a1.Artifact.Id] = nil
            Toast.Show({
                Seconds = 3,
                Text = ("%*: \"%*\""):format(GhostDogQuest.DogName, a1.Artifact.Found),
                Color = u58,
            })
            Memories.Celebrate(a1.Artifact.Id)
            return
        end
        if success and typeof(v1) == "string" then
            Toast.Show({Seconds = 2.5, Text = v1, Color = u53})
        end
        return
    end
end

local function spawnPickup(a1, a2) -- Line: 124
    -- upvalues: GhostDogQuest_2 (val), Trove (val), pillar (val), GhostDogQuest (val), take (val), RunService (val)
    -- upvalues: Players (val), u59 (val)
    local v1 = GhostDogQuest_2.Artifacts:FindFirstChild(a1.Model)
    if v1 ~= nil and v1:IsA("Model") then
        local v2 = Trove.new()
        local u18 = v2:Clone(v1)
        for i, j in u18:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = false
            end
        end
        u18.WorldPivot = u18:GetBoundingBox()
        u18:ScaleTo(1.4)
        local u46 = CFrame.new(a2.Position + Vector3.new(0, 3.200000047683716, 0))
        u18:PivotTo(u46)
        local Highlight = Instance.new("Highlight")
        Highlight.FillColor = Color3.fromRGB(150, 235, 255)
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = Color3.fromRGB(200, 250, 255)
        Highlight.OutlineTransparency = 1
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Parent = u18
        u18.Parent = workspace
        local v3 = pillar(v2, a2.Position + Vector3.new(0, 0.20000000298023224, 0))
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.ActionText = "Pick up"
        ProximityPrompt.ObjectText = a1.DisplayName
        ProximityPrompt.HoldDuration = 0.2
        ProximityPrompt.MaxActivationDistance = GhostDogQuest.PickupDistance
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
        ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX
        ProximityPrompt.Parent = v3
        local u88 = {
            Taken = false,
            Artifact = a1,
            Model = u18,
            Base = u46,
            Prompt = ProximityPrompt,
            Trove = v2,
        }
        v2:Connect(ProximityPrompt.Triggered, function() -- Line: 171 -- upvalues: take (upval), u88 (val)
            task.spawn(take, u88)
        end)
        local u96 = math.random() * 6
        local u97 = 0
        v2:Connect(RunService.RenderStepped, function(a1) -- Line: 176
            -- upvalues: u88 (val), u96 (val), u18 (val), u46 (val), Players (upval), u97 (ref), Highlight (val)
            if u88.Taken then
                return
            end
            local v1 = os.clock() + u96
            u18:PivotTo(u46 * CFrame.new(0, math.sin(v1 * 2) * 0.5, 0) * (CFrame.Angles(0, v1 * 1.2, (math.sin(v1 * 1.5)) * 0.15)))
            local Character = Players.LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            v1 = false
            if HumanoidRootPart ~= nil then
                v1 = HumanoidRootPart:IsA("BasePart") and (HumanoidRootPart.Position - u46.Position).Magnitude <= 10
            end
            local v2 = if not v1 then 0 else 1
            if u97 ~= v2 then
                v1 = a1 / 0.3
                u97 = if not (u97 < v2) then math.max(u97 - v1, v2) else math.min(u97 + v1, v2)
                Highlight.FillTransparency = u97 * -0.25 + 1
                Highlight.OutlineTransparency = u97 * -0.9 + 1
            end
        end)
        u59[a1.Id] = u88
        return
    end
end

function v1.Sync(a1, a2, a3) -- Line: 204
    -- upvalues: u59 (val), GhostDogQuest (val), u61 (val), spawnPickup (val)
    local v1
    local v2 = nil
    local v3 = nil
    local v4, v5, v6 = a3, a1, a2
    for i, j in u59, v2, v3 do
        v1 = v4
        if v1 then
            v1 = false
            if v5 ~= nil then
                v1 = false
                if v6 ~= nil then
                    v1 = v6[i] ~= true
                end
            end
        end
        if not v1 and not j.Taken then
            j.Trove:Destroy()
            u59[i] = nil
        end
    end
    if v4 and v5 ~= nil and v6 ~= nil then
        v2 = nil
        v3 = nil
        for k, n in GhostDogQuest.Artifacts, v2, v3 do
            if v6[n.Id] then
                u61[n.Id] = nil
            end
            if not v6[n.Id] and not u59[n.Id] and not u61[n.Id] then
                v1 = v5:FindFirstChild(n.Marker)
                if v1 and v1:IsA("BasePart") then
                    spawnPickup(n, v1)
                end
            end
        end
        return
    end
end

function v1.Clear() -- Line: 229 -- upvalues: u59 (val)
    for i, j in u59 do
        j.Trove:Destroy()
        u59[i] = nil
    end
end

return (table.freeze(v1))