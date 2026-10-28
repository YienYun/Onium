-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Kit
-- Decompile time: 3.10 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local ScrambleBoss = ReplicatedStorage.Assets.Sounds:WaitForChild("ScrambleBoss")
local v1 = Color3.fromRGB(80, 255, 60)
local u41 = CameraShaker.new()
CameraShakerDriver.Start(u41, Enum.RenderPriority.Last.Value)
local u47 = {Green = v1}
u47.Red = Color3.fromRGB(255, 50, 50)

function u47.Debris() -- Line: 31 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("Transient") or Workspace
end

function u47.Anchor(a1, a2) -- Line: 35 -- upvalues: u47 (val), Debris (val) -- types: a2: number
    local Part = Instance.new("Part")
    Part.Name = "ScrambleFx"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = if typeof(a1) ~= "CFrame" then CFrame.new(a1) else a1
    Part.Parent = u47.Debris()
    Debris:AddItem(Part, a2)
    return Part
end

function u47.Shake(a1, a2, a3) -- Line: 52 -- upvalues: u41 (val) -- types: a1: number, a2: number?, a3: number?
    u41:ShakeOnce(a1, a2 or 12, 0.05, a3 or 0.8)
end

function u47.ShakeFrom(a1, a2, a3) -- Line: 56
    -- upvalues: Workspace (val), u47 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local v1 = math.clamp(1 - (CurrentCamera.CFrame.Position - a1).Magnitude / a3, 0, 1)
    if v1 > 0.05 then
        u47.Shake(a2 * v1, 14, 0.9)
    end
end

function u47.Sound(a1, a2, a3, a4) -- Line: 69
    -- upvalues: ScrambleBoss (val), u47 (val), Debris (val), SoundService (val)
    local v1 = ScrambleBoss:FindFirstChild(a1)
    if v1 == nil then
        return
    end
    local v2 = v1:Clone()
    v2.Volume = v2.Volume * (a3 or 1)
    v2.PlaybackSpeed = v2.PlaybackSpeed * (a4 or 1)
    if typeof(a2) == "Vector3" then
        v2.Parent = u47.Anchor(a2, math.max(v2.TimeLength, 3) + 1)
    else
        if typeof(a2) ~= "Instance" then
            v2.Parent = SoundService
        else
            v2.Parent = a2
        end
        Debris:AddItem(v2, (math.max(v2.TimeLength, 3)) + 1)
    end
    v2:Play()
end

function u47.Loop(a1, a2) -- Line: 93 -- upvalues: ScrambleBoss (val) -- types: a1: string, a2: userdata
    local v1 = ScrambleBoss:FindFirstChild(a1)
    if v1 == nil then
        return nil, 0
    end
    local v2 = v1:Clone()
    local Volume = v2.Volume
    v2.Looped = true
    v2.Volume = 0
    v2.Parent = a2
    v2:Play()
    return v2, Volume
end

function u47.Part(a1) -- Line: 109 -- types: a1: table
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Material = Enum.Material.Neon
    for i, j in a1 do
        Part[i] = j
    end
    return Part
end

function u47.Flat(a1) -- Line: 126 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

return u47