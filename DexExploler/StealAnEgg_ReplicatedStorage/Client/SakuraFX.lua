-- Script path: ReplicatedStorage.Client.SakuraFX
-- Decompile time: 2.11 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Sakura = require(ReplicatedStorage.Data.Sakura)
local Audio = require(ReplicatedStorage.Shared.Audio)
local v1 = {}
local Sakura_2 = ReplicatedStorage.Assets.VFX:WaitForChild("Sakura")

local function spawnAnchor(a1, a2) -- Line: 39
    -- upvalues: Workspace (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "SakuraFXHost"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1) * a2
    Part.Position = a1
    Part.Parent = Workspace
    Debris:AddItem(Part, 6)
    return Part
end

local function cue(a1, a2, a3, a4, a5, a6) -- Line: 54
    -- upvalues: Sakura (val), Audio (val)
    local v1 = Sakura.Sounds[a1]
    local v2 = ("no sound id catalogued under Sakura.Sounds.%*"):format(a1)
    assert(v1 ~= nil, v2)
    return Audio.Play(v1, a2, {PlaybackSpeed = a4 or 1, Volume = a3 or 1, MaxDistance = a5 or 120, Looped = a6})
end

function v1.EmitBurst(a1, a2, a3, a4) -- Line: 72
    -- upvalues: Sakura_2 (val), Workspace (val), Debris (val)
    local v1
    local v2 = Sakura_2:FindFirstChild(a1)
    local v3 = ("no burst prefab named %* under Assets.VFX.Sakura"):format(a1)
    assert(v2 ~= nil, v3)
    local v4 = Instance.new("Part")
    v4.Name = "SakuraFXHost"
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.Transparency = 1
    v4.Size = Vector3.new(1, 1, 1) * (a4 or 4)
    v4.Position = a2
    v4.Parent = Workspace
    Debris:AddItem(v4, 6)
    for i, j in v2:GetChildren() do
        if j:IsA("ParticleEmitter") then
            v1 = j:Clone()
            v1.Enabled = false
            v1.Parent = v4
            v1:Emit((math.max(1, (math.floor(a3 * (math.max(j.Rate, 1)) / 20)))))
        end
    end
    return v4
end

function v1.PlayCue(a1, a2, a3, a4, a5) -- Line: 98
    -- upvalues: cue (val)
    return cue(a1, a2, a3, a4, a5)
end

function v1.PlayLooped(a1, a2, a3, a4) -- Line: 108
    -- upvalues: cue (val)
    return cue(a1, a2, a3, a4, nil, true)
end

return v1