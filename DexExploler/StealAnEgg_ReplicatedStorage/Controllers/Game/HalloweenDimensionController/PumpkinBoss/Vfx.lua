-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Vfx
-- Decompile time: 12.00 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local Kit = require(script.Parent.Kit)
local u30 = {}
local u31 = {PhaseOne = "Phase1VFX", PhaseTwo = "Phase2VFX", FireParticles = 1.5, FireDensity = 2}

function u31.Library() -- Line: 70 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
    return HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
end

function u31.PhaseOf(a1) -- Line: 77 -- upvalues: PumpkinBossState (val) -- types: a1: userdata
    if a1:GetAttribute(PumpkinBossState.Attributes.Boss) == "King" then
        return "Phase2VFX"
    end
    return "Phase1VFX"
end

function u31.Template(a1, a2) -- Line: 81 -- upvalues: u31 (val), u30 (val) -- types: a1: string, a2: table
    local v1 = u31.Library()
    v1 = v1 and v1:FindFirstChild(a1)
    local v2 = nil
    local v3 = nil
    for i, j in a2, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    if v1 and v1:IsA("BasePart") then
        return v1
    end
    v3 = table.concat(v4, "/")
    v1 = ("%*/%*"):format(v5, v3)
    if not u30[v1] then
        u30[v1] = true
        warn((("[PumpkinBoss] VFX %* is missing"):format(v1)))
    end
    return nil
end

local function settle(a1) -- Line: 99 -- types: a1: userdata
    a1.Anchored = true
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
    a1.CastShadow = false
    a1.Massless = true
    a1.Transparency = 1
end

function u31.Place(a1, a2, a3, a4) -- Line: 111
    -- upvalues: VFX (val), Kit (val)
    local v1
    local v2 = a3 or 1
    local v3 = a4 or v2
    local v4 = a1:Clone()
    local CFrame = v4.CFrame
    for i, j in v4:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = CFrame:ToObjectSpace(j.CFrame)
            j.Size = j.Size * v2
            j.CFrame = a2 * (v1.Rotation + v1.Position * v2)
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.CastShadow = false
            j.Massless = true
            j.Transparency = 1
        elseif not j:IsA("ParticleEmitter") then
            if v2 ~= 1 then
                if j:IsA("Beam") then
                    j.Width0 = j.Width0 * v2
                    j.Width1 = j.Width1 * v2
                    j.CurveSize0 = j.CurveSize0 * v2
                    j.CurveSize1 = j.CurveSize1 * v2
                elseif j:IsA("Attachment") then
                    j.Position = j.Position * v2
                end
            end
        elseif v3 ~= 1 then
            VFX.Rescale(j, v3)
        end
    end
    v4.Size = v4.Size * v2
    v4.CFrame = a2
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.CastShadow = false
    v4.Massless = true
    v4.Transparency = 1
    v4.Parent = Kit.Debris()
    return v4
end

local function emitters(a1) -- Line: 145 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function lifetimeOf(a1) -- Line: 155 -- types: a1: userdata
    return a1.Lifetime.Max / math.max(a1.TimeScale, 0.01)
end

function u31.Settle(a1) -- Line: 160 -- types: a1: userdata
    local v1 = 0
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = math.max(v1, j.Lifetime.Max / (math.max(j.TimeScale, 0.01)))
        elseif j:IsA("Trail") then
            v1 = math.max(v1, j.Lifetime)
        end
    end
    return v1 + 0.3
end

local function burst(a1) -- Line: 172 -- types: a1: table
    if 0 < a1.Count then
        a1.Emitter:Emit((math.max(math.round(a1.Count), 1)))
    end
end

function u31.Emit(a1, a2) -- Line: 181
    -- upvalues: emitters (val), Debris (val), RunService (val)
    local Attribute, Attribute_2, Attribute_3, Emitter_3, v1, v2, v3, v4, v5
    local u260 = {}
    local v6 = {}
    local v7 = 0
    local v8 = a2
    for i, j in emitters(a1) do
        Attribute = j:GetAttribute("EmitCount")
        j.Enabled = false
        if not (j.TimeScale <= 0) then
            Attribute_2 = j:GetAttribute("EmitDelay")
            Attribute_3 = j:GetAttribute("EmitDuration")
            v1 = false
            if type(Attribute_3) == "number" then
                v1 = Attribute_3 > 0
            end
            v2 = {
                Emitter = j,
                Delay = if type(Attribute_2) ~= "number" then 0 else math.max(Attribute_2, 0),
                Count = if type(Attribute) ~= "number" then if not v1 then j.Rate else 1 else Attribute,
                Duration = if not v1 then 0 else Attribute_3,
                Interval = 1 / math.max(j.Rate, 0.001),
            }
            if v2.Delay ~= (1 / 0) then
                v7 = math.max(v7, v2.Delay)
                table.insert(u260, v2)
                table.insert(v6, v2.Delay + j.Lifetime.Max / (math.max(j.TimeScale, 0.01)))
            end
        end
    end
    if v8 and v8 > 0 and v7 > 0 then
        local Emitter, v9
        v3 = v8 / v7
        v4 = nil
        v5 = nil
        for k, n in u260, v4, v5 do
            n.Delay = n.Delay * v3
            v9 = v8 - n.Delay
            if not (v9 <= 0.001) then
                Emitter = n.Emitter
                if v7 <= v6[k] or v9 < Emitter.Lifetime.Max / math.max(Emitter.TimeScale, 0.01) then
                    v1 = v9 * Emitter.TimeScale
                    Emitter.Lifetime = NumberRange.new(math.min(Emitter.Lifetime.Min, v1), v1)
                end
            end
        end
    end
    v3 = 0
    for m, i5 in u260 do
        v2 = i5.Delay + i5.Duration
        Emitter_3 = i5.Emitter
        v3 = math.max(v3, v2 + Emitter_3.Lifetime.Max / (math.max(Emitter_3.TimeScale, 0.01)))
    end
    local u153 = v3 + 0.3
    v7 = 0
    v4 = nil
    v5 = nil
    for i6, i7 in u260, v4, v5 do
        if i7.Delay <= 0 then
            if 0 < i7.Count then
                i7.Emitter:Emit((math.max(math.round(i7.Count), 1)))
            end
            i7.LastEmitted = 0
        end
        if 0 < i7.Delay or 0 < i7.Duration then
            v7 = v7 + 1
        end
    end
    if v7 == 0 then
        Debris:AddItem(a1, u153)
        return u153
    end
    local u110 = os.clock()
    local u111 = nil
    RunService.Heartbeat:Connect(function() -- Line: 250 -- upvalues: u110 (val), u153 (ref), a1 (val), u111 (ref), u260 (val)
        local v1 = os.clock() - u110
        if not (u153 <= v1) and a1.Parent ~= nil then
            local LastEmitted, v2
            local v3 = nil
            local v4 = nil
            for i, j in u260, v3, v4 do
                LastEmitted = j.LastEmitted
                if LastEmitted ~= nil then
                    if 0 < j.Duration and v1 <= j.Delay + j.Duration then
                        v2 = v1 - LastEmitted
                        if j.Interval <= v2 then
                            if 0 < j.Count then
                                j.Emitter:Emit((math.max(math.round(j.Count), 1)))
                            end
                            j.LastEmitted = LastEmitted + j.Interval
                        end
                    end
                elseif j.Delay <= v1 then
                    if 0 < j.Count then
                        j.Emitter:Emit((math.max(math.round(j.Count), 1)))
                    end
                    j.LastEmitted = j.Delay
                end
            end
            return
        end
        u111:Disconnect()
        a1:Destroy()
    end)
    return u153
end

function u31.Play(a1, a2, a3, a4, a5) -- Line: 275
    -- upvalues: u31 (val)
    local v1 = u31.Template(a1, a2)
    if v1 == nil then
        return false
    end
    u31.Emit(u31.Place(v1, a3, a4), a5)
    return true
end

function u31.Hold(a1) -- Line: 285 -- upvalues: Debris (val), u31 (val) -- types: a1: userdata
    local u1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            u1[j] = (a1.CFrame:ToObjectSpace(j.CFrame))
        end
    end
    local u14 = false
    return {
        Root = a1,
        Move = function(a1_2, a2) -- Line: 297 -- upvalues: a1 (val), u1 (val) -- types: a1_2: table, a2: userdata
            a1.CFrame = a2
            for i, j in u1 do
                i.CFrame = a2 * j
            end
        end,
        Stop = function(a1_2) -- Line: 304 -- upvalues: u14 (ref), a1 (val), Debris (upval), u31 (upval) -- types: a1_2: table
            if u14 then
                return
            end
            u14 = true
            for i, j in a1:GetDescendants() do
                if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
                    j.Enabled = false
                end
            end
            Debris:AddItem(a1, (u31.Settle(a1)))
        end,
    }
end

function u31.Strip(a1, a2, a3, a4) -- Line: 328
    -- upvalues: u31 (val), emitters (val), Kit (val), Debris (val)
    local v1 = a3 or 1
    local v2 = a4 or {}
    local u18 = u31.Place(a1, a2, v1, v2.Particles or 1)
    local Lift = v2.Lift
    if not Lift then
        Lift = a1.Position.Y * v1
    end
    local u32 = math.max(u18.Size.X * u18.Size.Z, 0.001)
    local u33 = {}
    for i, j in emitters(u18) do
        u33[j] = j.Rate * (v2.Density or 1)
    end
    local u46 = false
    return {
        Root = u18,
        Span = function(a1, a2_2, a3, a4) -- Line: 343
            -- upvalues: u46 (ref), Kit (upval), a2 (val), Lift (val), u18 (val), u32 (val), u33 (val)
            if u46 then
                return
            end
            local v1 = Kit.Flat(a3 - a2_2)
            local Magnitude = v1.Magnitude
            local Unit = if not (Magnitude > 0.001) then a2.XVector else v1.Unit
            v1 = (a2_2 + a3) / 2 + Vector3.new(0, Lift, 0)
            u18.Size = Vector3.new(math.max(Magnitude, 0.05), u18.Size.Y, a4)
            u18.CFrame = CFrame.fromMatrix(v1, Unit, (Vector3.new(0, 1, 0)))
            local v2 = Magnitude * a4 / u32
            for i, j in u33 do
                i.Rate = j * v2
            end
        end,
        Stop = function(a1) -- Line: 359 -- upvalues: u46 (ref), u33 (val), Debris (upval), u18 (val) -- types: a1: table
            if u46 then
                return
            end
            u46 = true
            for i in u33 do
                i.Enabled = false
            end
            Debris:AddItem(u18, 5)
        end,
    }
end

return u31