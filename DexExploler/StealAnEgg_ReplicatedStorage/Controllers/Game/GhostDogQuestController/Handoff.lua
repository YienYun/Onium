-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Handoff
-- Decompile time: 12.95 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local Npcs = require(script.Parent.Npcs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Sounds = ReplicatedStorage.Assets.Sounds
local Swoosh = Sounds.ScrambleBoss.Swoosh
local Pop = Sounds.ScrambleBoss.Pop
local CollectSecretRing = Sounds.LightVsDarknessSounds.CollectSecretRing
local u56 = Color3.fromRGB(120, 255, 175)
local u57 = false
local v1 = {}

local function playerRod(a1) -- Line: 34 -- upvalues: LocalPlayer (val), GhostDogQuest (val) -- types: a1: userdata?
    local RodAttribute
    local v1 = {a1, LocalPlayer:FindFirstChildOfClass("Backpack")}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j ~= nil then
            for k, n in j:GetChildren() do
                if n:IsA("Tool") then
                    RodAttribute = GhostDogQuest.RodAttribute
                    if n:GetAttribute(RodAttribute) == true then
                        return n
                    end
                end
            end
        end
    end
    return nil
end

local function setLocalAlpha(a1, a2) -- Line: 49 -- types: a1: userdata, a2: number
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.LocalTransparencyModifier = a2
        end
    end
end

local function isEffect(a1) -- Line: 57 -- types: a1: userdata
    return a1:IsA("ParticleEmitter") or a1:IsA("Beam") or a1:IsA("Light") or a1:IsA("Trail")
end

local function heldGrip(a1) -- Line: 64
    local Attribute = a1.Model:GetAttribute("Grip")
    if typeof(Attribute) == "CFrame" then
        return Attribute
    end
    local RightHand = a1.Model:FindFirstChild("RightHand")
    local RightGrip = RightHand and RightHand:FindFirstChild("RightGrip")
    if RightGrip and RightGrip:IsA("Motor6D") then
        return RightGrip.C1
    end
    return CFrame.identity
end

local function gripFrame(a1, a2) -- Line: 77 -- types: a1: userdata, a2: userdata
    local RightHand = a1:FindFirstChild("RightHand") or a1:FindFirstChild("Right Arm")
    if RightHand ~= nil and RightHand:IsA("BasePart") then
        local RightGripAttachment = RightHand:FindFirstChild("RightGripAttachment")
        local CFrame_2 = if not RightGripAttachment or not RightGripAttachment:IsA("Attachment") then (CFrame.new(0, -RightHand.Size.Y * 0.5, 0)) * CFrame.Angles(-1.5707963267948966, 0, 0) else RightGripAttachment.CFrame
        return RightHand.CFrame * CFrame_2 * a2:Inverse()
    end
    return nil
end

local function landingGrip(a1, a2) -- Line: 89 -- upvalues: playerRod (val) -- types: a1: userdata, a2: userdata
    local v1 = playerRod(a1)
    if v1 then
        return v1.Grip
    end
    return a2
end

function v1.HasRod() -- Line: 94 -- upvalues: playerRod (val), LocalPlayer (val)
    return playerRod(LocalPlayer.Character) ~= nil
end

function v1.IsRunning() -- Line: 98 -- upvalues: u57 (ref)
    return u57
end

function v1:Play() -- Line: 102
    -- upvalues: u57 (ref), LocalPlayer (val), Npcs (val), heldGrip (val), setLocalAlpha (val), Trove (val)
    -- upvalues: GhostDogQuest (val), Remotes (val), Workspace (val), Fx (val), Pop (val), u56 (val), Swoosh (val)
    -- upvalues: gripFrame (val), playerRod (val), CollectSecretRing (val), Toast (val)
    if u57 then
        return false
    end
    local Character = LocalPlayer.Character
    local v1 = Npcs.Rod()
    local PrimaryPart = v1 and v1.PrimaryPart
    if Character ~= nil and v1 ~= nil and PrimaryPart ~= nil then
        local RodAttribute, v2, v3, v4, v5, v6, v7, v8
        u57 = true
        local v9 = heldGrip(self)
        local u692 = {}

        local function conceal(a1) -- Line: 115 -- upvalues: u692 (val) -- types: a1: userdata
            local v1
            for i, j in a1:GetDescendants() do
                if not j:IsA("BasePart") then
                    v1 = j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") or j:IsA("Trail")
                    if v1 and u692[j] == nil then
                        u692[j] = j.Enabled
                        j.Enabled = false
                    end
                else
                    j.LocalTransparencyModifier = 1
                end
            end
        end

        local function reveal(a1) -- Line: 126 -- upvalues: setLocalAlpha (upval), u692 (val) -- types: a1: userdata?
            if a1 then
                setLocalAlpha(a1, 0)
            end
            for i, j in u692 do
                if i.Parent then
                    i.Enabled = j
                end
            end
            table.clear(u692)
        end

        local v10 = Trove.new()

        local function hideArrival(a1) -- Line: 139
            -- upvalues: GhostDogQuest (upval), conceal (val)
            if a1:IsA("Tool") and a1:GetAttribute(GhostDogQuest.RodAttribute) == true then
                conceal(a1)
            end
        end

        local v11 = {Character, LocalPlayer:FindFirstChildOfClass("Backpack")}
        local v12 = nil
        local v13 = nil
        local v14 = self
        for i, j in v11, v12, v13 do
            if j ~= nil then
                v10:Connect(j.ChildAdded, hideArrival)
                for k, n in j:GetChildren() do
                    if n:IsA("Tool") then
                        RodAttribute = GhostDogQuest.RodAttribute
                        if n:GetAttribute(RodAttribute) == true then
                            conceal(n)
                        end
                    end
                end
            end
        end
        local u665 = nil
        task.spawn(function() -- Line: 155 -- upvalues: Remotes (upval), u665 (ref)
            local success, err = pcall(function() -- Line: 156 -- upvalues: Remotes (upval)
                return Remotes.GhostDogQuest.Talk:InvokeServer("Rod")
            end)
            u665 = success and err == "RodGiven"
        end)
        v14.Rig:Play("Point", 0.2, 1.1)
        task.wait(0.45)
        local v15 = v1:Clone()
        v15.Name = "GhostDogRodHandoff"
        for m, i5 in v15:GetDescendants() do
            if i5:IsA("BasePart") then
                i5.Anchored = true
                i5.LocalTransparencyModifier = 0
            elseif i5:IsA("JointInstance") or i5:IsA("WeldConstraint") then
                i5:Destroy()
            end
        end
        local PrimaryPart_2 = v15.PrimaryPart
        local u428 = {}
        for i6, i7 in v15:GetDescendants() do
            if i7:IsA("BasePart") then
                u428[i7] = (PrimaryPart_2.CFrame:ToObjectSpace(i7.CFrame))
            end
        end

        local function place(a1) -- Line: 180 -- upvalues: u428 (val) -- types: a1: userdata
            for i, j in u428 do
                i.CFrame = a1 * j
            end
        end

        local LeftHand = v14.Model:FindFirstChild("LeftHand")
        v13 = (CFrame.new(if not LeftHand then PrimaryPart.Position + v14.Rig.Root.CFrame.RightVector * -2.5 else if not LeftHand:IsA("BasePart") then PrimaryPart.Position + v14.Rig.Root.CFrame.RightVector * -2.5 else LeftHand.Position + Vector3.new(0, 0.6000000238418579, 0))) * PrimaryPart.CFrame.Rotation
        for i8, i9 in u428 do
            i8.CFrame = v13 * i9
        end
        setLocalAlpha(v15, 1)
        v15.Parent = Workspace
        Fx.Play(Pop, {Volume = 0.5, PlaybackSpeed = 0.8})
        Fx.Burst(v2, u56, 18, 6, 0.5)
        v2 = os.clock()
        while true do
            if not (os.clock() - v2 < 0.35) then
                break
            end
            v8 = (os.clock() - v2) / 0.35
            setLocalAlpha(v15, 1 - Fx.Ease(v8))
            v3 = v13 * CFrame.new(0, v8 * 0.8, 0) * CFrame.Angles(0, v8 * 3.141592653589793, 0)
            for i10, i11 in u428 do
                i10.CFrame = v3 * i11
            end
            task.wait()
        end
        setLocalAlpha(v15, 0)
        v13 = v13 * CFrame.new(0, 0.8, 0) * CFrame.Angles(0, 3.141592653589793, 0)
        local v16 = u428
        local v17 = nil
        for i12, i13 in v16, nil, v17 do
            i12.CFrame = v13 * i13
        end
        Fx.Play(Swoosh, {Volume = 0.6, PlaybackSpeed = 1.15})
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = PrimaryPart_2
        local ParticleEmitter = Instance.new("ParticleEmitter")
        ParticleEmitter.Texture = Fx.Sparkle
        ParticleEmitter.Color = ColorSequence.new(u56)
        ParticleEmitter.LightEmission = 1
        ParticleEmitter.Size = NumberSequence.new(0.5, 0)
        ParticleEmitter.Lifetime = NumberRange.new(0.3, 0.6)
        ParticleEmitter.Speed = NumberRange.new(0.5, 2)
        ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
        ParticleEmitter.Rate = 60
        ParticleEmitter.Parent = Attachment
        v3 = os.clock()
        while true do
            v2 = math.min((os.clock() - v3) / 0.9, 1)
            v16 = Fx.Ease(v2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v7 = playerRod(Character)
            v4 = gripFrame(Character, if not v7 then v9 else v7.Grip) or v13
            v17 = (math.sin(v2 * 3.141592653589793)) * 3.5
            v5 = (v13.Position:Lerp(v4.Position, v16)) + Vector3.new(0, v17, 0)
            v17 = (v13.Rotation:Lerp(v4.Rotation, v16)) * CFrame.Angles(0, (1 - v16) * 3.141592653589793 * 2, 0)
            v6 = CFrame.new(v5) * v17
            for i14, i15 in u428 do
                i14.CFrame = v6 * i15
            end
            v5 = playerRod(Character)
            if v5 and v5.Parent == Character then
                conceal(v5)
            end
            if v2 >= 1 then
                break
            end
            task.wait()
        end
        v3 = os.clock()
        while true do
            if not (os.clock() - v3 < 2.5) then
                break
            end
            v13 = playerRod(Character)
            if u665 == false then
                break
            end
            if v13 and v13.Parent == Character then
                break
            end
            v5 = playerRod(Character)
            v13 = gripFrame(Character, if not v5 then v9 else v5.Grip)
            if v13 then
                for i16, i17 in u428 do
                    i16.CFrame = v13 * i17
                end
            end
            task.wait()
        end
        v3 = playerRod(Character)
        v10:Destroy()
        if v3 then
            setLocalAlpha(v3, 0)
        end
        for i18, i19 in u692 do
            if i18.Parent then
                i18.Enabled = i19
            end
        end
        table.clear(u692)
        local Position_3 = PrimaryPart_2.Position
        v15:Destroy()
        u57 = false
        if u665 ~= false and v3 ~= nil then
            Fx.Play(Pop, {Volume = 0.8, PlaybackSpeed = 1.2})
            Fx.Play(CollectSecretRing, {Volume = 0.6})
            Fx.Burst(Position_3, u56, 22, 10, 0.6)
            Toast.Show({
                Seconds = 3,
                Text = ("You got the %*!"):format(GhostDogQuest.RodName),
                Color = u56,
            })
            return true
        end
        return false
    end
    return false
end

return (table.freeze(v1))