-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents.PumpkinDeposit
-- Decompile time: 11.05 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local HalloweenDimension = (ReplicatedStorage:WaitForChild("Assets")):WaitForChild("HalloweenDimension")
local v1 = HalloweenDimension:WaitForChild("PumpkinDeposit")
local Pumpkin = v1:WaitForChild("Pumpkin")
local Flail = v1:WaitForChild("Flail")
local Burst = v1:WaitForChild("Burst")
local u66 = (HalloweenDimension:WaitForChild("Sounds")):WaitForChild("PumpkinDeposit")
local u72 = Color3.fromRGB(255, 150, 45)
local u77 = Color3.fromRGB(255, 205, 80)
local u82 = Color3.fromRGB(255, 170, 60)
local u87 = Color3.fromRGB(255, 160, 50)
local u94 = TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local BoundingBox, BoundingBox_2 = Pumpkin:GetBoundingBox()
local u111 = (Pumpkin:GetScale()) * math.min(1, 8 / (math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)))
local u127 = (Pumpkin:GetPivot().Position.Y - (BoundingBox.Position.Y - BoundingBox_2.Y * 0.5)) * u111 / Pumpkin:GetScale()
local v2 = {}

local function stage() -- Line: 78 -- upvalues: Workspace (val)
    return Workspace:FindFirstChild("Transient") or Workspace
end

local function bezier(a1, a2, a3, a4) -- Line: 82 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function ease(a1, a2, a3) -- Line: 87 -- upvalues: TweenService (val) -- types: a1: number
    return TweenService:GetValue(math.clamp(a1, 0, 1), a2, a3)
end

local function quiet(a1) -- Line: 91 -- types: a1: userdata
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
end

local function shell(a1) -- Line: 97 -- types: a1: userdata
    local Archivable = a1.Archivable
    a1.Archivable = true
    local v1 = a1:Clone()
    a1.Archivable = Archivable
    v1:ClearAllChildren()
    v1.Anchored = true
    v1.CastShadow = false
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    return v1
end

local function pumpkin(a1, a2, a3) -- Line: 109
    -- upvalues: Pumpkin (val), u111 (val), Flail (val)
    local v1 = a1:Add((Pumpkin:Clone()))
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
    v1:ScaleTo(u111)
    v1:PivotTo(a2)
    v1.Parent = a3
    local Animator = v1:FindFirstChildWhichIsA("Animator", true)
    if Animator ~= nil then
        local v2 = a1:Add((Animator:LoadAnimation(Flail)))
        v2.Looped = true
        v2:Play(0, 1, 2.6)
    end
    return v1
end

local function anchor(a1, a2) -- Line: 128 -- upvalues: Workspace (val) -- types: a2: vector
    local v1 = a1:Add((Instance.new("Part")))
    v1.Name = "PumpkinDepositBurst"
    v1.Anchored = true
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    v1.CFrame = CFrame.new(a2)
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    v1.Parent = Transient
    return v1
end

local function flash(a1, a2) -- Line: 141 -- upvalues: u72 (val), TweenService (val) -- types: a2: userdata
    local v1 = a1:Add((Instance.new("PointLight")))
    v1.Color = u72
    v1.Brightness = 9
    v1.Range = 26
    v1.Shadows = false
    v1.Parent = a2
    a1:Add((TweenService:Create(v1, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0, Range = 7.8}))):Play()
end

local function pulse(a1, a2) -- Line: 159
    -- upvalues: u77 (val), Workspace (val), TweenService (val)
    local Archivable = a2.Archivable
    a2.Archivable = true
    local v1 = a2:Clone()
    a2.Archivable = Archivable
    v1:ClearAllChildren()
    v1.Anchored = true
    v1.CastShadow = false
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    local v2 = a1:Add(v1)
    v2.Name = "PumpkinDepositGlow"
    v2.Material = Enum.Material.Neon
    v2.Color = u77
    v2.Transparency = 0.05
    v2.Size = a2.Size + Vector3.new(0, 0.20000000298023224, 0)
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    v2.Parent = Transient
    a1:Add((TweenService:Create(v2, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(a2.Size.X * 1.35, a2.Size.Y + 0.2, a2.Size.Z * 1.35),
    }))):Play()
end

local function pillar(a1, a2) -- Line: 185
    -- upvalues: u82 (val), Workspace (val), TweenService (val)
    local v1 = a1:Add((Instance.new("Part")))
    v1.Name = "PumpkinDepositPillar"
    v1.Shape = Enum.PartType.Cylinder
    v1.Material = Enum.Material.Neon
    v1.Color = u82
    v1.Anchored = true
    v1.CastShadow = false
    v1.Transparency = 0.15
    v1.Size = Vector3.new(0.20000000298023224, 7, 7)
    v1.CFrame = (CFrame.new(a2 + Vector3.new(0, 0.10000000149011612, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    local Transient = Workspace:FindFirstChild("Transient") or Workspace
    v1.Parent = Transient
    a1:Add((TweenService:Create(v1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(13, 1.75, 1.75),
        CFrame = (CFrame.new(a2 + Vector3.new(0, 6.5, 0))) * CFrame.Angles(0, 0, 1.5707963267948966),
    }))):Play()
end

local function burst(a1, a2) -- Line: 214
    -- upvalues: anchor (val), VFX (val), Burst (val), flash (val), pillar (val), pulse (val), Audio (val), u66 (val)
    local WorldPosition = a2.Target.WorldPosition
    local v1 = anchor(a1, WorldPosition + Vector3.new(0, 0.30000001192092896, 0))
    local v2 = VFX.EmitAt(v1, Burst:GetChildren())
    flash(a1, v1)
    pillar(a1, WorldPosition)
    if a2.Plate ~= nil and a2.Plate.Parent ~= nil then
        pulse(a1, a2.Plate)
    end
    Audio.Play(u66, WorldPosition, {MaxDistance = 180})
    return (math.max(v2.settleSeconds, 0.7, 0.55, 0.6))
end

function v2:Play(a2, a3, a4, a5) -- Line: 231
    -- upvalues: Workspace (val), pumpkin (val), u127 (val), u111 (val), RunService (val), TweenService (val)
    -- upvalues: burst (val)
    local WorldPosition = a3.Target.WorldPosition
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and 450 < (CurrentCamera.CFrame.Position - WorldPosition).Magnitude then
        if a5 ~= nil then
            a5()
        end
        return
    end
    local u19 = self:Extend()
    local u21 = a5
    u19:Add(function() -- Line: 249 -- upvalues: u21 (ref)
        local v1 = u21
        u21 = nil
        if v1 ~= nil then
            v1()
        end
    end)
    local u43 = pumpkin(u19, a2, a4 or Workspace:FindFirstChild("Transient") or Workspace)
    local Position = a2.Position
    local Rotation = a2.Rotation
    local u53 = WorldPosition + Vector3.new(0, 1, 0) * (u127 + 0.6)
    local u55 = WorldPosition - Vector3.new(0, 0.800000011920929, 0)
    local v1 = math.clamp((u53 - Position).Magnitude * 0.45, 5, 16)
    local v2 = (Position + u53) * 0.5
    local v3 = math.max(Position.Y, u53.Y)
    local u78 = v2 + Vector3.new(0, 1, 0) * (v3 - (Position.Y + u53.Y) * 0.5 + v1)
    local u79 = u111
    local u80 = nil
    local u81 = 0
    local u84 = os.clock()

    local function pose(a1, a2, a3, a4) -- Line: 270
        -- upvalues: u79 (ref), u43 (val), Rotation (val)
        if 0.002 < (math.abs(a4 - u79)) then
            u79 = a4
            u43:ScaleTo(a4)
        end
        u43:PivotTo((CFrame.new(a1)) * CFrame.Angles(0, a2, 0) * Rotation * (CFrame.Angles(a3, 0, 0)))
    end

    u19:Connect(RunService.RenderStepped, function() -- Line: 280
        -- upvalues: u84 (val), TweenService (upval), pose (val), Position (val), u78 (val), u53 (val), u111 (upval)
        -- upvalues: u55 (val), u80 (ref), u19 (val), u43 (val), u81 (ref), burst (upval), a3 (val), u21 (ref)
        -- upvalues: self (val)
        local v1, v2
        local v3 = os.clock() - u84
        if v3 < 0.6 then
            v1 = v3 / 0.6
            local Sine = Enum.EasingStyle.Sine
            local InOut = Enum.EasingDirection.InOut
            v2 = TweenService:GetValue(math.clamp(v1, 0, 1), Sine, InOut)
            v1 = math.sin(3.141592653589793 * v2)
            local v4 = pose
            local v5 = Position
            local v6 = u78
            local v7 = u53
            local v8 = 1 - v2
            v4(v5 * (v8 * v8) + v6 * (v8 * 2 * v2) + v7 * (v2 * v2), 4.71238898038469 * v2, v1 * 0.3141592653589793, u111 * (v1 * 0.12 + 1))
            return
        end
        if v3 < 0.82 then
            v1 = (v3 - 0.6) / 0.22
            local Quad = Enum.EasingStyle.Quad
            local In = Enum.EasingDirection.In
            v2 = TweenService:GetValue(math.clamp(v1, 0, 1), Quad, In)
            pose(u53:Lerp(u55, v2), (v2 * 0.5 + 0.75) * 3.141592653589793 * 2, 0, u111 * (v2 * -0.96 + 1))
            return
        end
        if u80 ~= nil then
            v1 = v3 - u80
            if u81 <= v1 then
                self:Remove(u19)
            end
            return
        end
        u80 = v3
        u19:Remove(u43)
        burst(u19, a3)
        v1 = u21
        u21 = nil
        if v1 == nil then
            return
        end
        v1()
    end)
end

function v2.Beacon(a1, a2) -- Line: 312
    -- upvalues: Workspace (val), u87 (val), TweenService (val), u94 (val)
    local v1 = a1:Add((Instance.new("Attachment")))
    v1.Name = "PumpkinDepositBeacon"
    v1.Parent = Workspace.Terrain
    v1.WorldPosition = a2.Target.WorldPosition + Vector3.new(0, 2, 0)
    local v2 = a1:Add((Instance.new("PointLight")))
    v2.Color = u87
    v2.Brightness = 1.2
    v2.Range = 16
    v2.Shadows = false
    v2.Parent = v1
    a1:Add((TweenService:Create(v2, u94, {Brightness = 3.5}))):Play()
end

return v2