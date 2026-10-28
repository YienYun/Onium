-- Script path: ReplicatedStorage.Controllers.Game.FishingController.Line
-- Decompile time: 5.06 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local u21 = Color3.fromRGB(120, 255, 175)
local u22 = {}

local function template() -- Line: 20 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local GhostDogQuest = Assets and Assets:FindFirstChild("GhostDogQuest")
    local v1 = GhostDogQuest and GhostDogQuest:FindFirstChild("Bobber")
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

function u22.Spawn(a1, a2) -- Line: 27
    -- upvalues: ReplicatedStorage (val), u21 (val), Workspace (val)
    local v1
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local GhostDogQuest = Assets and Assets:FindFirstChild("GhostDogQuest")
    local v2 = GhostDogQuest and GhostDogQuest:FindFirstChild("Bobber")
    if (if v2 == nil then nil else if not v2:IsA("Model") then nil else v2) == nil then
        warn("[Fishing] ReplicatedStorage.Assets.GhostDogQuest.Bobber is missing")
        return nil
    end
    local u33 = v1:Clone()
    u33.Name = "FishingBobber"
    pcall(function() -- Line: 35 -- upvalues: u33 (val)
        u33:ScaleTo(1.1)
    end)
    u33:PivotTo((CFrame.new(a2)))
    v1 = u33:FindFirstChild("Line", true)
    if a1 and v1 and v1:IsA("Attachment") then
        local Beam = Instance.new("Beam")
        Beam.Name = "FishingLine"
        Beam.Attachment0 = a1
        Beam.Attachment1 = v1
        Beam.Width0 = 0.07
        Beam.Width1 = 0.07
        Beam.LightEmission = 1
        Beam.FaceCamera = true
        Beam.Segments = 16
        Beam.Color = ColorSequence.new(u21)
        Beam.Parent = u33
    end
    u33.Parent = Workspace
    return u33
end

function u22.Beam(a1) -- Line: 57 -- types: a1: userdata
    local FishingLine = a1:FindFirstChild("FishingLine")
    if FishingLine ~= nil and FishingLine:IsA("Beam") then
        return FishingLine
    end
    return nil
end

function u22.Fly(a1, a2, a3, a4, a5) -- Line: 62
    -- upvalues: u22 (val)
    local v1
    local v2 = math.clamp((a3 - a2).Magnitude * 0.32, 4, 14)
    local v3 = u22.Beam(a1)
    local v4 = os.clock()
    local v5, v6, v7, v8, v9 = a5, a1, a4, a3, a2
    while v5() do
        if v6.Parent == nil then
            break
        end
        v1 = math.min((os.clock() - v4) / v7, 1)
        v6:PivotTo((CFrame.new((v9:Lerp(v8, v1)) + (Vector3.new(0, (math.sin(v1 * 3.141592653589793)) * v2 + v1 * -0.33, 0)))))
        if v3 then
            v3.CurveSize0 = (1 - v1) * 3
        end
        if v1 >= 1 then
            break
        end
        task.wait()
    end
end

function u22.Float(a1, a2, a3, a4) -- Line: 82
    -- upvalues: u22 (val)
    local v1 = a4 or 0
    a1:PivotTo((CFrame.new(a2 + Vector3.new(0, math.sin(a3 * 3.2) * 0.12 + -0.33 - v1, 0))) * (CFrame.Angles(math.sin(a3 * 2.1) * 0.08, 0, (math.cos(a3 * 1.7)) * 0.08)))
    local v2 = u22.Beam(a1)
    if v2 then
        v2.CurveSize0 = 2.5 - math.min(v1, 1) * 2.5
    end
end

function u22.Thrash(a1, a2, a3) -- Line: 95 -- upvalues: u22 (val) -- types: a1: userdata, a2: vector, a3: number
    local v1 = Vector3.new((math.random() - 0.5) * 0.5 * a3, -0.35 - math.random() * 0.4 * a3, ((math.random()) - 0.5) * 0.5 * a3)
    a1:PivotTo((CFrame.new(a2 + Vector3.new(0, -0.33000001311302185, 0) + v1)) * (CFrame.Angles((math.random() - 0.5) * 0.5, 0, ((math.random()) - 0.5) * 0.5)))
    v1 = u22.Beam(a1)
    if v1 then
        v1.CurveSize0 = 0
    end
end

function u22.Return(a1, a2, a3) -- Line: 111
    -- upvalues: LocalPlayer (val)
    local Character, v1
    local Position = a1:GetPivot().Position
    local v2 = os.clock()
    local v3, v4, v5 = a1, a3, a2
    while v3.Parent ~= nil do
        v1 = math.min((os.clock() - v2) / v4, 1)
        Character = LocalPlayer.Character
        v3:PivotTo((CFrame.new((Position:Lerp(
            if not v5 then if not Character then Position else Character:GetPivot().Position else if v5.Parent == nil then if not Character then Position else Character:GetPivot().Position else v5.WorldPosition,
            v1 * v1
        )) + (Vector3.new(0, math.sin(v1 * 3.141592653589793) * 2, 0)))))
        if v1 >= 1 then
            break
        end
        task.wait()
    end
end

return table.freeze(u22)