-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.RockFall
-- Decompile time: 10.18 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
require(ReplicatedStorage.Packages.Trove)
local Stage3 = ReplicatedStorage.Assets.BeanstalkEventAssets.Stage3
local u26 = Stage3.FallingIslands:GetChildren()
local RockBurst = Stage3.RockBurst
local u33 = Color3.fromRGB(255, 45, 70)

local function partsOf(a1) -- Line: 87 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function setFade(a1, a2) -- Line: 97 -- types: a1: table, a2: number
    for i, j in a1.Parts do
        j.LocalTransparencyModifier = a2
    end
end

local function place(a1, a2, a3) -- Line: 103 -- types: a1: table, a2: table, a3: number
    local v1 = a1.Path(a2.Distance)
    a2.Position = v1.Position + v1.RightVector * (a2.Lateral + (math.sin((a3 - a2.BornAt) * 0.7 * 2 * 3.141592653589793 + a2.Seed)) * 3) + Vector3.new(0, 1, 0) * a2.Height
    a2.Model:PivotTo((CFrame.new(a2.Position)) * a2.Turn)
end

local function chunksFrom(a1, a2) -- Line: 113 -- upvalues: Debris (val) -- types: a1: table, a2: table
    local v1, v2
    local v3 = nil
    local Parts = a2.Parts
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in Parts, v4, v5 do
        if v3 == nil or v3.Size.Magnitude < j.Size.Magnitude then
            v3 = j
        end
    end
    if v3 == nil then
        return
    end
    for k = 1, 8 do
        v1 = v3:Clone()
        for n, m in v1:GetChildren() do
            m:Destroy()
        end
        v1.Size = v3.Size * 0.16 * v6.Rng:NextNumber(0.6, 1.4)
        v1.Anchored = false
        v1.CanCollide = false
        v1.CanQuery = false
        v1.CanTouch = false
        v1.Massless = true
        v1.LocalTransparencyModifier = 0
        v2 = v6.Rng:NextUnitVector()
        v1.CFrame = (CFrame.new(v7.Position + v2 * v7.Radius * 0.5)) * CFrame.Angles(v6.Rng:NextNumber(0, 6.28), v6.Rng:NextNumber(0, 6.28), 0)
        v1.Parent = v6.Folder
        v1.AssemblyLinearVelocity = v2 * 70 * v6.Rng:NextNumber(0.6, 1.3)
        v1.AssemblyAngularVelocity = (v6.Rng:NextUnitVector()) * v6.Rng:NextNumber(4, 12)
        Debris:AddItem(v1, 1.4)
    end
end

local function remove(a1, a2) -- Line: 145 -- types: a1: table, a2: number
    local v1 = table.remove(a1.Rocks, a2)
    if v1 then
        v1.Model:Destroy()
    end
end

local u39 = {}

function u39.new(a1, a2, a3, a4) -- Line: 156 -- upvalues: u39 (val) -- types: a2: userdata, a3: function, a4: number
    local u4 = {
        Chain = 0,
        Open = 0,
        Trove = a1,
        Folder = a2,
        Path = a3,
        Width = a4,
    }
    u4.Rocks = {}
    u4.Rng = Random.new()
    a1:Add(function() -- Line: 172 -- upvalues: u39 (upval), u4 (val)
        u39.Clear(u4)
    end)
    return u4
end

function u39.Spawn(a1, a2, a3, a4, a5, a6) -- Line: 178
    -- upvalues: u26 (val), partsOf (val), place (val)
    local BoundingBox_2
    local v1 = u26[a1.Rng:NextInteger(1, #u26)]:Clone()
    local v2 = v1:FindFirstChildOfClass("Highlight")
    if v2 then
        v2.Enabled = false
    end
    _, BoundingBox_2 = v1:GetBoundingBox()
    local v3 = math.min(BoundingBox_2.X, BoundingBox_2.Z) * 0.5 * 0.58
    local v4 = partsOf(v1)
    local v5 = {}
    for i, j in v4 do
        v5[j] = j.Color
    end
    local v6 = {
        Tinted = false,
        Position = Vector3.new(0, 0, 0),
        Closest = (1 / 0),
        Hit = false,
        Passed = false,
        Model = v1,
        Warning = v2,
        Parts = v4,
        Colors = v5,
        Ratio = a6,
        Distance = a2,
        Lateral = a3,
        Height = a5,
        FallSpeed = a4,
        Radius = v3,
        Axis = (Vector3.new(0, 1, 0) + a1.Rng:NextUnitVector() * 0.3).Unit,
        Spin = (a1.Rng:NextNumber(0.4363323129985824, 1.2217304763960306)) * (if not ((a1.Rng:NextNumber()) < 0.5) then 1 else -1),
        Turn = CFrame.Angles(0, a1.Rng:NextNumber(0, 6.283185307179586), a1.Rng:NextNumber(-0.4, 0.4)),
        Seed = a1.Rng:NextNumber(0, 6.283185307179586),
        BornAt = os.clock(),
    }
    for k, n in v6.Parts do
        n.LocalTransparencyModifier = 1
    end
    place(a1, v6, v6.BornAt)
    v1.Parent = a1.Folder
    table.insert(a1.Rocks, v6)
end

function u39.Wave(a1, a2, a3, a4, a5, a6, a7) -- Line: 232
    -- upvalues: u39 (val)
    local v1, v2, v3
    if a1.Chain <= 0 then
        a1.Chain = (a1.Rng:NextInteger(3, 4)) + math.floor(a3 * 2)
    end
    local v4 = -a1.Open
    if v4 == 0 then
        v4 = if not ((a1.Rng:NextNumber()) < 0.5) then 1 else -1
    elseif v3 and (a1.Rng:NextNumber()) < 0.25 then
        v4 = 0
    end
    a1.Open = v4
    v3 = a1.Width * 0.66
    local v5, v6, v7, v8, v9 = a1, a2, a4, a5, a6
    for i = -1, 1 do
        if i ~= v4 then
            u39.Spawn(v5, v6, i * v3, v7, v8, v9)
        end
    end
    v5.Chain = v5.Chain - 1
    if v5.Chain <= 0 then
        return v2 * 1.3
    end
    return v2 * (v1 * -0.16999999999999993 + 0.82)
end

function u39.Step(a1, a2, a3, a4, a5) -- Line: 267
    -- upvalues: place (val), u33 (val)
    local Height_2, Warning, v1, v2, v3, v4, v5, v6, v7
    local v8 = os.clock()
    local v9 = nil
    local v10 = nil
    local v11, v12, v13 = a1, a3, a2
    for i = #a1.Rocks, 1, -1 do
        v1 = v11.Rocks[i]
        v2 = v1.Distance - v12
        if not (v2 > 0) then
            v1.Height = v1.Height - v1.FallSpeed * v13
        else
            v1.Height = math.min(v1.Height - v1.FallSpeed * v13 * 0.25, v2 * v1.Ratio)
        end
        v1.Turn = (CFrame.fromAxisAngle(v1.Axis, v1.Spin * v13)) * v1.Turn
        v2 = v8 - v1.BornAt
        if v2 < 0.8 then
            v3 = 1 - v2 / 0.8
            for n, m in v1.Parts do
                m.LocalTransparencyModifier = v3
            end
        elseif v2 - v13 < 0.8 then
            for j, k in v1.Parts do
                k.LocalTransparencyModifier = 0
            end
        end
        place(v11, v1, v8)
        v2 = math.abs(v1.Lateral - v6) - 9
        v3 = v1.Distance - v12
        v4 = math.abs(v1.Height)
        if (math.abs(v3)) < v1.Radius * 1.5 and v4 < v1.Radius * 1.5 then
            v1.Closest = math.min(v1.Closest, v2)
        end
        if not v1.Hit and (math.abs(v3)) < v1.Radius and v2 < v1.Radius and v4 < v1.Radius * 1.2 then
            v1.Hit = true
            if v7 and v9 == nil then
                v9 = v1
            end
        end
        v4 = not v1.Hit
        if v4 then
            v4 = not v1.Passed
            if v4 then
                v4 = false
                if -v1.Radius < v3 then
                    v4 = false
                    Height_2 = v1.Height
                    if -v1.Radius < Height_2 then
                        v4 = v2 < v1.Radius + 1.5
                    end
                end
            end
        end
        v2 = math.sin(v8 * 5 * 2 * 3.141592653589793) * 0.5 + 0.5
        Warning = v1.Warning
        if Warning then
            Warning.Enabled = v4
            if v4 then
                Warning.OutlineTransparency = v2 * 0.35 + 0.15
            end
        end
        if v4 then
            v1.Tinted = true
            v5 = v2 * 0.35000000000000003 + 0.45
            for i7, i8 in v1.Colors do
                i7.Color = i8:Lerp(u33, v5)
            end
        elseif v1.Tinted then
            v1.Tinted = false
            for i5, i6 in v1.Colors do
                i5.Color = i6
            end
        end
        if not v1.Passed then
            if v3 < -v1.Radius or v1.Height < -v1.Radius * 2 then
                v1.Passed = true
                if not v1.Hit and v1.Closest < v1.Radius * 2.1 then
                    v10 = v1
                end
            end
        end
        if v9 ~= v1 then
            if v3 < -170 or v1.Height < -300 then
                v4 = table.remove(v11.Rocks, i)
                if v4 then
                    v4.Model:Destroy()
                end
            end
        end
    end
    return v9, v10
end

function u39.Shatter(a1, a2) -- Line: 355
    -- upvalues: RockBurst (val), EmitOnce (val), Debris (val), chunksFrom (val)
    local v1 = RockBurst:Clone()
    v1.CFrame = CFrame.new(a2.Position)
    v1.Parent = a1.Folder
    local v2 = 0
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v2 = math.max(v2, (EmitOnce(j)))
        end
    end
    Debris:AddItem(v1, (math.max(v2, 0.5)) + 0.2)
    chunksFrom(a1, a2)
    v2 = table.find(a1.Rocks, a2)
    if not v2 then
        a2.Model:Destroy()
        return
    end
    v1 = table.remove(a1.Rocks, v2)
    if not v1 then
        return
    end
    v1.Model:Destroy()
end

function u39.Clear(a1) -- Line: 375 -- types: a1: table
    local v1
    for i = #a1.Rocks, 1, -1 do
        v1 = table.remove(a1.Rocks, i)
        if v1 then
            v1.Model:Destroy()
        end
    end
end

return u39