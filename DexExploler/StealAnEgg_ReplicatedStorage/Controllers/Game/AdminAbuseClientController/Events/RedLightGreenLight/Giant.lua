-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight.Giant
-- Decompile time: 7.71 ms

local Workspace = game:GetService("Workspace")
local u9 = Color3.fromRGB(255, 40, 40)
local u10 = {AwayYaw = 3.141592653589793}

local function newSpring(a1, a2, a3) -- Line: 51 -- types: a1: number, a2: number, a3: number
    return {
        Velocity = 0,
        Value = a1,
        Target = a1,
        Speed = a2,
        Damping = a3,
    }
end

local function stepSpring(a1, a2) -- Line: 61 -- types: a1: table, a2: number
    local Speed = a1.Speed
    local v1 = a1.Value - a1.Target
    a1.Velocity = a1.Velocity + (-Speed * Speed * v1 - a1.Damping * 2 * Speed * a1.Velocity) * a2
    a1.Value = a1.Value + a1.Velocity * a2
end

local function stepSprings(a1, a2) -- Line: 70 -- types: a1: table, a2: number
    local Speed, v1, v2
    local v3 = math.max(math.ceil(a2 / 0.008333333333333333), 1)
    local v4 = a2 / v3
    for i = 1, v3 do
        for j, k in a1 do
            Speed = k.Speed
            v1 = k.Value - k.Target
            v2 = -Speed * Speed * v1 - k.Damping * 2 * Speed * k.Velocity
            k.Velocity = k.Velocity + v2 * v4
            k.Value = k.Value + k.Velocity * v4
        end
    end
end

local function stripRig(a1, a2) -- Line: 81 -- types: a1: userdata, a2: userdata
    local v1
    local v2, v3 = a1, a2
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j == v3
            j.Anchored = v1
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = true
            v1 = j ~= v3
            j.Massless = v1
        elseif j:IsA("Script") or j:IsA("LocalScript") or j:IsA("Animator") or j:IsA("ForceField") then
            j:Destroy()
        end
    end
    local Humanoid = v2:FindFirstChildOfClass("Humanoid")
    if Humanoid ~= nil then
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.BreakJointsOnDeath = false
        Humanoid.AutoRotate = false
        Humanoid.PlatformStand = true
    end
end

local function standingHeight(a1, a2, a3) -- Line: 111 -- types: a1: userdata, a2: userdata, a3: userdata
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    local HipHeight = if Humanoid == nil then 2 else Humanoid.HipHeight
    local v1 = a2.Position.Y - a2.Size.Y * 0.5 - HipHeight
    return (math.max(a3.Position.Y + a3.Size.Y * 0.5 - v1, 1)), a2.Position.Y - v1
end

local function makeEye(a1, a2, a3) -- Line: 120 -- upvalues: u9 (val) -- types: a1: userdata, a2: number, a3: string
    local Part = Instance.new("Part")
    Part.Name = a3
    Part.Shape = Enum.PartType.Ball
    Part.Material = Enum.Material.Neon
    Part.Color = u9
    Part.Size = Vector3.new(1, 1, 1) * a1.Size.X * 0.16
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Massless = true
    Part.Anchored = false
    Part.CFrame = a1.CFrame * CFrame.new((Vector3.new(a1.Size.X * 0.17 * a2, a1.Size.Y * 0.08, -a1.Size.Z * 0.5)))
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = a1
    WeldConstraint.Part1 = Part
    WeldConstraint.Parent = Part
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u9
    PointLight.Range = 0
    PointLight.Brightness = 6
    PointLight.Parent = Part
    Part.Parent = a1
    return Part
end

function u10.new(a1, a2, a3) -- Line: 162
    -- upvalues: stripRig (val), standingHeight (val), makeEye (val), u10 (val), Workspace (val)
    a1.Archivable = true
    local v1 = a1:Clone()
    local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart", true)
    local Head = v1:FindFirstChild("Head")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and Head ~= nil and Head:IsA("BasePart") then
        v1.PrimaryPart = HumanoidRootPart
        stripRig(v1, HumanoidRootPart)
        local v2, v3 = standingHeight(v1, HumanoidRootPart, Head)
        local v4 = a3 / v2
        v2 = v3 * v4
        v1:ScaleTo((v1:GetScale()) * v4)
        local Neck = Head:FindFirstChild("Neck")
        v3 = v1:FindFirstChild("UpperTorso")
        local Waist = if v3 == nil then nil else v3:FindFirstChild("Waist")
        v3 = {
            Rise = 1,
            EyeGlow = 0,
            EyeTarget = 0,
            Clock = 0,
            Model = v1,
            Root = HumanoidRootPart,
            Head = Head,
        }
        v3.Neck = if Neck == nil then nil else if not Neck:IsA("Motor6D") then nil else Neck
        v3.Waist = if Waist == nil then nil else if not Waist:IsA("Motor6D") then nil else Waist
        v3.Ground = a2
        v3.Height = a3
        v3.RootLift = v2
        v3.Body = {
            Value = 0,
            Velocity = 0,
            Target = 0,
            Speed = 6,
            Damping = 0.9,
        }
        v3.Look = {
            Value = 0,
            Velocity = 0,
            Target = 0,
            Speed = 24,
            Damping = 0.42,
        }
        v3.Twitch = {
            Value = 0,
            Velocity = 0,
            Target = 0,
            Speed = 26,
            Damping = 0.35,
        }
        v3.Eyes = {}
        v3.Eyes = {makeEye(Head, -1, "EyeL"), (makeEye(Head, 1, "EyeR"))}
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "SeeThrough"
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillColor = Color3.fromRGB(255, 255, 255)
        Highlight.FillTransparency = 0.94
        Highlight.OutlineColor = Color3.fromRGB(255, 235, 235)
        Highlight.OutlineTransparency = 0.55
        Highlight.Adornee = v1
        Highlight.Parent = v1
        v1.Name = "RedLightGreenLightGiant"
        u10.Update(v3, 0)
        v1.Parent = Workspace
        return v3
    end
    v1:Destroy()
    return nil
end

function u10.Face(a1, a2, a3) -- Line: 233 -- types: a1: table, a2: boolean, a3: boolean?
    local v1 = if not a2 then 3.141592653589793 else 0
    a1.Body.Target = v1
    a1.Look.Target = v1
    if not a2 then
        a1.Look.Speed = 9
        a1.Look.Damping = 0.8
        a1.Body.Speed = 4.5
    else
        a1.Look.Speed = 26
        a1.Look.Damping = 0.38
        a1.Body.Speed = 7
    end
    if a3 then
        a1.Body.Value = v1
        a1.Body.Velocity = 0
        a1.Look.Value = v1
        a1.Look.Velocity = 0
    end
end

function u10.TwitchHead(a1, a2) -- Line: 257 -- types: a1: table, a2: number
    local Twitch = a1.Twitch
    Twitch.Velocity = Twitch.Velocity + a2 * 17.243853009703976
end

function u10.SetEyes(a1, a2, a3) -- Line: 261 -- types: a1: table, a2: number, a3: boolean?
    a1.EyeTarget = a2
    if a3 then
        a1.EyeGlow = a2
    end
end

function u10.FacingAmount(a1) -- Line: 269 -- types: a1: table
    return (math.cos(a1.Look.Value + a1.Twitch.Value) + 1) * 0.5
end

function u10.HeadYaw(a1) -- Line: 273 -- types: a1: table
    return a1.Look.Value + a1.Twitch.Value
end

function u10.BodyYaw(a1) -- Line: 277 -- types: a1: table
    return a1.Body.Value
end

function u10.EyePositions(a1) -- Line: 281 -- types: a1: table
    local v1 = {}
    for i, j in a1.Eyes do
        table.insert(v1, j.Position)
    end
    return v1
end

function u10.HeadPosition(a1) -- Line: 291 -- types: a1: table
    return a1.Head.Position
end

function u10.Update(a1, a2) -- Line: 295 -- upvalues: stepSprings (val) -- types: a1: table, a2: number
    a1.Clock = a1.Clock + a2
    stepSprings({a1.Body, a1.Look, a1.Twitch}, a2)
    a1.Twitch.Target = 0
    local v1 = (1 - a1.Rise) * (a1.Height + a1.RootLift)
    local v2 = math.sin(a1.Clock * 3.141592653589793 * 2 * 0.35)
    local v3 = a1.Ground * CFrame.new(0, a1.RootLift - v1, 0) * CFrame.Angles(0, a1.Body.Value, 0)
    a1.Root.CFrame = v3
    local Neck = a1.Neck
    if Neck ~= nil then
        Neck.Transform = CFrame.Angles(0, a1.Look.Value + a1.Twitch.Value - a1.Body.Value, 0)
    end
    local Waist = a1.Waist
    if Waist ~= nil then
        Waist.Transform = CFrame.Angles(v2 * 0.027925268031909273, 0, 0)
    end
    a1.EyeGlow = a1.EyeGlow + (a1.EyeTarget - a1.EyeGlow) * math.min(a2 * 14, 1)
    for i, j in a1.Eyes do
        j.Transparency = 1 - math.clamp(a1.EyeGlow, 0, 1)
        v3 = j:FindFirstChildOfClass("PointLight")
        if v3 ~= nil then
            v3.Range = math.clamp(a1.EyeGlow, 0, 1.5) * 40
        end
    end
end

function u10:Destroy() -- Line: 335 -- types: self: table
    self.Model:Destroy()
end

return u10