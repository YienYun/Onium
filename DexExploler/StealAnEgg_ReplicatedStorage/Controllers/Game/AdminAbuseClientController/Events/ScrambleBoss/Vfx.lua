-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Vfx
-- Decompile time: 13.59 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local Kit = require(script.Parent.Kit)
local ScrambleBossVFX = ReplicatedStorage.Assets.Particles:WaitForChild("ScrambleBossVFX")
local u36 = {
    Slam = {"MechBoss", "Slam"},
    ToxicOrb = {"MechBoss", "ToxicOrb", "ToxicOrb"},
    ToxicSplat = {"MechBoss", "ToxicOrb", "ToxicOrbSplat"},
    ToxicPuddle = {"MechBoss", "ToxicPuddle"},
    SpiderLane = {"MechBoss", "SpiderRush", "SpiderRushIndicator"},
    SpiderSlashes = {"MechBoss", "SpiderRush", "SpiderRushSlashes"},
    BossSwipe = {"MechBoss", "BossSwipe"},
    LaserPillar = {"MechBoss", "LaserPillar"},
    LaserBeam = {"MechBoss", "LaserBeam"},
    LaserSweep = {"MechBoss", "LaserSweep"},
    DroneSummon = {"MechBoss", "DroneSummon"},
    CrocTarget = {"Croc", "Target"},
    CrocLeap = {"Croc", "LeapIn"},
    CrocBite = {"Croc", "BiteIndicator"},
    CrocTail = {"Croc", "TailSwipe"},
    BallTrail = {"BallTrail"},
    LightningSurge = {"LightningSurge", "Lightning Surge"},
}
local u91 = 0.016666666666666666
local u92 = {}

function u92.Template(a1) -- Line: 61 -- upvalues: ScrambleBossVFX (val), u36 (val) -- types: a1: string
    local v1 = ScrambleBossVFX
    local v2 = u36[a1] or {}
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    return v1
end

function u92.Frame(a1, a2, a3) -- Line: 70 -- upvalues: u92 (val) -- types: a1: string, a2: vector, a3: vector?
    local v1 = u92.Template(a1)
    local Rotation = if not v1 then CFrame.identity else if not v1:IsA("BasePart") then CFrame.identity else v1.CFrame.Rotation
    return (if not a3 then CFrame.new(a2) else if not (0.001 < a3.Magnitude) then CFrame.new(a2) else CFrame.lookAt(a2, a2 + a3.Unit)) * Rotation
end

function u92.Scale(a1, a2) -- Line: 82 -- upvalues: VFX (val) -- types: a1: userdata, a2: number
    local v1
    if a2 == 1 then
        return
    end
    if a1:IsA("BasePart") then
        a1.Size = a1.Size * a2
    end
    local v2 = a2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            VFX.Rescale(j, v2)
        elseif j:IsA("Beam") then
            j.Width0 = j.Width0 * v2
            j.Width1 = j.Width1 * v2
            j.CurveSize0 = j.CurveSize0 * v2
            j.CurveSize1 = j.CurveSize1 * v2
            if j.TextureMode ~= Enum.TextureMode.Stretch then
                j.TextureLength = j.TextureLength * v2
            end
        elseif j:IsA("Attachment") then
            j.Position = j.Position * v2
        elseif j:IsA("PointLight") or j:IsA("SpotLight") then
            v1 = j.Range * v2
            j.Range = math.min(v1, 60)
        end
    end
end

function u92.Sample(a1) -- Line: 110 -- upvalues: u91 (ref) -- types: a1: number
    u91 = u91 + ((math.min(a1, 0.25)) - u91) * 0.1
end

local function keepVisible(a1) -- Line: 114 -- upvalues: u91 (ref) -- types: a1: userdata
    local Lifetime, new, v1, v2
    local v3 = u91 * 4
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            Lifetime = j.Lifetime
            if Lifetime.Max < v3 then
                v2 = v3 / math.max(Lifetime.Max, 0.001)
                new = NumberRange.new
                v1 = Lifetime.Min * v2
                j.Lifetime = new(v1, v3)
            end
        end
    end
end

local function settleSeconds(a1) -- Line: 127 -- types: a1: userdata
    local v1 = 0
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = math.max(v1, j.Lifetime.Max / (math.max(j.TimeScale, 0.01)))
        elseif j:IsA("Trail") then
            v1 = math.max(v1, j.Lifetime)
        end
    end
    return v1 + 0.4
end

local function stage(a1, a2, a3, a4) -- Line: 140
    -- upvalues: u92 (val), Kit (val)
    local v1 = u92.Template(a1)
    if v1 == nil then
        return nil
    end
    local v2 = v1:Clone()
    if v2:IsA("BasePart") then
        v2.Anchored = true
        v2.CanCollide = false
        v2.CanQuery = false
        v2.CanTouch = false
        v2.CastShadow = false
        v2.Transparency = 1
        v2.CFrame = a2
    end
    u92.Scale(v2, a3 or 1)
    v2.Parent = a4 or Kit.Debris()
    return v2
end

local function authoredBeams(a1) -- Line: 163 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("Beam") then
            v1[j] = j.Transparency
        end
    end
    return v1
end

local function beamFade(a1, a2, a3, a4) -- Line: 174
    -- upvalues: RunService (val)
    local function apply(a1) -- Line: 180 -- upvalues: a2 (val) -- types: a1: number
        local Time, new, v1, v2
        local v3 = nil
        local v4 = nil
        for i, j in a2, v3, v4 do
            v2 = {}
            for k, n in j.Keypoints do
                new = NumberSequenceKeypoint.new
                Time = n.Time
                v1 = 1 - (1 - n.Value) * v5
                v2[k] = (new(Time, v1, n.Envelope))
            end
            i.Transparency = NumberSequence.new(v2)
        end
    end

    local u6 = os.clock()
    apply(if not a4 then 1 else 0)
    local u13 = nil
    RunService.RenderStepped:Connect(function() -- Line: 197 -- upvalues: u6 (val), a3 (val), a1 (val), a4 (val), u13 (ref), apply (val), a2 (val)
        local v1 = math.clamp((os.clock() - u6) / a3, 0, 1)
        local v2 = 1 - (1 - v1) ^ 2
        if a1.Parent ~= nil and (a1:GetAttribute("Fading")) == a4 then
            apply(if not a4 then 1 - v2 else v2)
            if v1 >= 1 then
                if u13 then
                    u13:Disconnect()
                end
                for i, j in a2 do
                    if not a4 then
                        i.Enabled = false
                    else
                        i.Transparency = j
                    end
                end
            end
            return
        end
        if u13 then
            u13:Disconnect()
        end
    end)
end

function u92.Burst(a1, a2, a3, a4, a5) -- Line: 223
    -- upvalues: stage (val), keepVisible (val), VFX (val), Debris (val), settleSeconds (val)
    local v1
    local v2 = stage(a1, a2, a3, a5)
    if v2 == nil then
        return nil
    end
    for i, j in v2:GetDescendants() do
        if not j:IsA("ParticleEmitter") then
            if j:IsA("Beam") or j:IsA("Trail") or j:IsA("Light") then
                j.Enabled = false
            end
        elseif j.Enabled then
            j.Enabled = false
            if j:GetAttribute("EmitCount") == nil then
                v1 = j.Rate * (a4 or 0.25)
                j:SetAttribute("EmitCount", v1)
            end
        end
    end
    keepVisible(v2)
    Debris:AddItem(v2, (math.max(VFX.EmitTree(v2, 0.5), (settleSeconds(v2)))) + 0.4)
    return v2
end

function u92.Hold(a1, a2, a3, a4, a5) -- Line: 257
    -- upvalues: stage (val), VFX (val), authoredBeams (val), beamFade (val), TweenService (val), Debris (val)
    -- upvalues: settleSeconds (val)
    local u10 = stage(a1, a2, a3, a4)
    if u10 == nil then
        return nil
    end
    local u12 = {}
    local u13 = {}
    for i, j in u10:GetDescendants() do
        if not j:IsA("ParticleEmitter") then
            if j:IsA("Light") then
                table.insert(u13, j)
            end
        elseif j.Enabled then
            table.insert(u12, j)
        elseif not a5 then
            VFX.EmitOne(j, 0.5)
        end
    end
    local u29 = authoredBeams(u10)
    u10:SetAttribute("Fading", true)
    beamFade(u10, u29, 0.12, true)
    local u41 = false
    return {
        Root = u10,
        Move = function(a1, a2) -- Line: 290 -- upvalues: u10 (val) -- types: a1: table, a2: userdata
            if u10:IsA("BasePart") then
                u10.CFrame = a2
            end
        end,
        Stop = function(a1) -- Line: 296
            -- upvalues: u41 (ref), u12 (val), u10 (val), u13 (val), TweenService (upval), beamFade (upval), u29 (val)
            -- upvalues: Debris (upval), settleSeconds (upval)
            local v1, v2
            if u41 then
                return
            end
            u41 = true
            for i, j in u12 do
                j.Enabled = false
            end
            for k, n in u10:GetDescendants() do
                if n:IsA("Trail") then
                    n.Enabled = false
                end
            end
            for m, i5 in u13 do
                v1 = TweenService
                v2 = TweenInfo.new(0.22)
                v1:Create(i5, v2, {Brightness = 0}):Play()
            end
            u10:SetAttribute("Fading", false)
            beamFade(u10, u29, 0.22, false)
            Debris:AddItem(u10, (settleSeconds(u10)))
        end,
    }
end

function u92.Stamp(a1, a2, a3, a4) -- Line: 321
    -- upvalues: u92 (val), Debris (val)
    local v1, v2
    local v3 = u92.Template(a1)
    if v3 == nil then
        return nil
    end
    local v4 = v3:Clone()
    v3 = {}
    if v4:IsA("Attachment") then
        table.insert(v3, v4)
    end
    for i, j in v4:GetDescendants() do
        if j:IsA("Attachment") and j.Parent == v4 then
            table.insert(v3, j)
        end
    end
    local v5 = nil
    local v6 = nil
    local v7, v8, v9 = a2, a3, a4
    for k, n in v3, v5, v6 do
        n.Parent = v7
        for m, i5 in n:GetDescendants() do
            if i5:IsA("ParticleEmitter") then
                i5.Enabled = false
                i5.Lifetime = NumberRange.new(v8)
                if v9 then
                    i5.LockedToPart = true
                end
                i5:Emit(1)
            end
        end
        v1 = Debris
        v2 = v8 + 0.4
        v1:AddItem(n, v2)
    end
    v4:Destroy()
    return v3[1]
end

function u92.Pulse(a1, a2) -- Line: 357 -- types: a1: userdata, a2: number
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") and not j.Enabled then
            j.Lifetime = NumberRange.new(a2)
            j:Emit(1)
        end
    end
end

function u92.Toggle(a1, a2) -- Line: 366 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

function u92.CrocScale(a1) -- Line: 374 -- upvalues: ScrambleBossVFX (val) -- types: a1: userdata
    local Croc = a1:FindFirstChild("Croc")
    local Croc_2 = ScrambleBossVFX:FindFirstChild("Croc")
    local Attribute = Croc_2 and Croc_2:GetAttribute("ReferenceLength")
    if Croc ~= nil and Croc:IsA("Model") and typeof(Attribute) == "number" then
        local BoundingBox_2
        _, BoundingBox_2 = Croc:GetBoundingBox()
        return math.max(BoundingBox_2.X, BoundingBox_2.Z) / Attribute
    end
    return 1
end

function u92.Trail(a1, a2) -- Line: 387 -- upvalues: u92 (val) -- types: a1: userdata, a2: number
    local BallTrail = u92.Template("BallTrail")
    local v1 = {}
    local Attribute = BallTrail and BallTrail:GetAttribute("ReferenceWidth")
    if BallTrail ~= nil and typeof(Attribute) == "number" then
        local v2 = BallTrail:Clone()
        u92.Scale(v2, a2 / Attribute)
        for i, j in v2:GetChildren() do
            if j:IsA("Attachment") then
                j.Parent = a1
                table.insert(v1, j)
            end
        end
        for k, n in v2:GetChildren() do
            if n:IsA("Trail") then
                n.Parent = a1
                table.insert(v1, n)
            end
        end
        v2:Destroy()
        return v1
    end
    return v1
end

function u92.Glitch(a1, a2, a3) -- Line: 414 -- upvalues: u92 (val) -- types: a1: vector, a2: number?, a3: number?
    local u10 = u92.Hold("DroneSummon", CFrame.new(a1), a2)
    if u10 then
        task.delay(a3 or 0.45, function() -- Line: 417 -- upvalues: u10 (val)
            u10:Stop()
        end)
    end
end

function u92.Ground(a1, a2) -- Line: 423 -- types: a1: vector, a2: number?
    return (Vector3.new(a1.X, a2 or a1.Y, a1.Z))
end

return u92