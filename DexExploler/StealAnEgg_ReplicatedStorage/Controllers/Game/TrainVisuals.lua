-- Script path: ReplicatedStorage.Controllers.Game.TrainVisuals
-- Decompile time: 14.93 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TrainRailPath = require(ReplicatedStorage.Shared.Modules.TrainRailPath)
local TrainWheels = require(ReplicatedStorage.Shared.Modules.TrainWheels)
local Audio = require(ReplicatedStorage.Shared.Audio)
local u29 = {}
local u30 = false
local u31 = {}
local u32 = nil
local u33 = {
    Departing = {Id = 129023065050025, Volume = 0.8, MaxDistance = 600},
    Whistle = {Id = 138461336141917, Volume = 0.6, MaxDistance = 1500},
}

local function playSound(a1, a2) -- Line: 20 -- upvalues: Audio (val)
    return Audio.Play(a1.Id, a2, {Volume = a1.Volume, MaxDistance = a1.MaxDistance})
end

function u29.EndRide(a1) -- Line: 24 -- upvalues: u32 (ref), RunService (val), u31 (val)
    local v1 = u32
    if not v1 then
        return
    end
    if a1 and a1 ~= v1.Id then
        return
    end
    u32 = nil
    RunService:UnbindFromRenderStep("TrainPrivateMotion")
    if u31[v1.Source] == v1.Id then
        u31[v1.Source] = nil
    end
    for i, j in v1.CharacterParts do
        if i.Parent then
            i.LocalTransparencyModifier = j
        end
    end
    v1.Clone:Destroy()
end

function u29.BeginRide(a1) -- Line: 42
    -- upvalues: u29 (val), Workspace (val), TrainRailPath (val), TrainWheels (val), u31 (val), u32 (ref), u33 (val)
    -- upvalues: Audio (val), RunService (val)
    u29.EndRide()
    local Train = a1.Train
    if typeof(Train) == "Instance" and Train:IsA("Model") then
        local v1 = Workspace
        if Train:IsDescendantOf(v1) and Train:GetAttribute("TrainVisualSource") == true then
            local RailPath = Train:FindFirstChild("RailPath")
            if not RailPath then
                return nil
            end
            local Children = RailPath:GetChildren()
            table.sort(Children, function(a1, a2) -- Line: 58
                return a1.Name < a2.Name
            end)
            local v2 = {}
            v1 = Children
            for i, j in v1 do
                if not j:IsA("Vector3Value") then
                    return nil
                end
                table.insert(v2, j.Value)
            end
            if not (#v2 < 2) then
                v1 = #v2
                if v1 == Train:GetAttribute("RailNodeCount") then
                    local Attribute_2, Attribute_3
                    local v3 = Train:Clone()
                    v3.Name = "PrivateTrain_" .. a1.Id
                    v3:SetAttribute("TrainVisualSource", nil)
                    v1 = 0
                    for k, n in v3:GetDescendants() do
                        if n:IsA("BasePart") then
                            v1 = v1 + 1
                            n.Anchored = true
                            n.CanCollide = false
                            n.CanTouch = false
                            n.CanQuery = false
                            n.LocalTransparencyModifier = 0
                            Attribute_2 = n:GetAttribute("RailAuthoredTransparency") or n.Transparency
                            n.Transparency = Attribute_2
                        elseif n:IsA("Decal") then
                            Attribute_3 = n:GetAttribute("RailAuthoredTransparency") or n.Transparency
                            n.Transparency = Attribute_3
                        elseif n:IsA("Light") or n:IsA("Beam") or n:IsA("ParticleEmitter") then
                            n.Enabled = true
                        end
                    end
                    if v1 ~= Train:GetAttribute("RailPartCount") then
                        v3:Destroy()
                        return nil
                    end
                    local u88 = {}
                    for m, i5 in v3:GetChildren() do
                        if i5:IsA("Model")
                            and i5.PrimaryPart
                            and type((i5:GetAttribute("TrainCarOffset"))) == "number" then
                            table.insert(u88, i5)
                        end
                    end
                    if #u88 == 0 then
                        v3:Destroy()
                        return nil
                    end
                    table.sort(u88, function(a1, a2) -- Line: 108
                        return (a1:GetAttribute("TrainCarIndex")) < a2:GetAttribute("TrainCarIndex")
                    end)
                    v3.PrimaryPart = u88[1].PrimaryPart
                    local u114 = {Id = a1.Id, Source = Train, Clone = v3}
                    u114.CharacterParts = {}
                    for i6, i7 in a1.Character:GetDescendants() do
                        if i7:IsA("BasePart") then
                            u114.CharacterParts[i7] = i7.LocalTransparencyModifier
                        end
                    end
                    local u136 = TrainRailPath.Prepare(v2)
                    local u142 = TrainWheels.Bind(u88)

                    local function draw() -- Line: 120
                        -- upvalues: TrainRailPath (upval), a1 (val), Workspace (upval), u88 (val), u136 (val)
                        -- upvalues: TrainWheels (upval), u142 (val), u114 (val)
                        local v1
                        local v2 = TrainRailPath.DistanceAt(a1.StartDistance, a1.EndDistance, a1.StartedAt, a1.Duration, Workspace:GetServerTimeNow())
                        for i, j in u88 do
                            v1 = TrainRailPath.Frame(u136, v2 - (j:GetAttribute("TrainCarOffset")))
                            j:PivotTo(v1)
                        end
                        TrainWheels.Update(u142, v2)
                        for k in u114.CharacterParts do
                            if k.Parent then
                                k.LocalTransparencyModifier = 1
                            end
                        end
                    end

                    draw()
                    local TrainEventVisuals = Workspace:FindFirstChild("TrainEventVisuals") or Workspace
                    v3.Parent = TrainEventVisuals
                    u31[Train] = a1.Id
                    u32 = u114
                    if a1.Mode == "Departure" then
                        local Departing = u33.Departing
                        Audio.Play(Departing.Id, v3.PrimaryPart, {Volume = Departing.Volume, MaxDistance = Departing.MaxDistance})
                    elseif a1.Mode == "Arrival" then
                        local Whistle = u33.Whistle
                        Audio.Play(Whistle.Id, v3.PrimaryPart, {Volume = Whistle.Volume, MaxDistance = Whistle.MaxDistance})
                    end
                    RunService:BindToRenderStep("TrainPrivateMotion", Enum.RenderPriority.Camera.Value, function() -- Line: 147
                        -- upvalues: u32 (upval), u114 (val), Train (val), a1 (val), Workspace (upval), u29 (upval)
                        -- upvalues: draw (val)
                        if u32 ~= u114 then
                            return
                        end
                        if Train.Parent and a1.Character.Parent then
                            local ServerTimeNow = Workspace:GetServerTimeNow()
                            if not (a1.StartedAt + a1.Duration + 10 < ServerTimeNow) then
                                draw()
                                return
                            end
                        end
                        u29.EndRide(u114.Id)
                    end)
                    return v3
                end
            end
            return nil
        end
    end
    return nil
end

function u29.Start() -- Line: 164
    -- upvalues: u30 (ref), Workspace (val), TrainRailPath (val), TrainWheels (val), RunService (val), u31 (val)
    -- upvalues: u33 (val), Audio (val), u29 (val)
    if u30 then
        return
    end
    u30 = true
    local Folder = Instance.new("Folder")
    Folder.Name = "TrainEventVisuals"
    Folder.Parent = Workspace
    local u7 = {}
    local u8 = 0

    local function add(a1) -- Line: 174 -- upvalues: u7 (val), Folder (val), TrainRailPath (upval), TrainWheels (upval)
        if not u7[a1] and a1:GetAttribute("TrainVisualSource") == true then
            local Attribute = a1:GetAttribute("RailPartCount")
            if not Attribute then
                return
            end
            local v1 = 0
            for i, v in ipairs(a1:GetDescendants()) do
                if v:IsA("BasePart") then
                    v1 = v1 + 1
                end
            end
            if v1 ~= Attribute then
                return
            end
            local RailPath = a1:FindFirstChild("RailPath")
            if RailPath then
                local v2 = #RailPath:GetChildren()
                if v2 == (a1:GetAttribute("RailNodeCount") or 0) then
                    local Attribute_2
                    local v3 = RailPath:GetChildren()
                    table.sort(v3, function(a1, a2) -- Line: 196
                        return a1.Name < a2.Name
                    end)
                    v1 = {}
                    for i2, i3 in ipairs(v3) do
                        table.insert(v1, i3.Value)
                    end
                    if #v1 < 2 then
                        return
                    end
                    v3 = a1:Clone()
                    v3.Name = a1.Name
                    v3:SetAttribute("TrainVisualSource", nil)
                    v2 = {}
                    local v4 = {}
                    local v5 = a1
                    for i4, j in ipairs(v3:GetDescendants()) do
                        if j:IsA("BasePart") then
                            j.LocalTransparencyModifier = 0
                            j.Anchored = true
                            j.CanCollide = false
                            j.CanTouch = false
                            j.CanQuery = false
                            table.insert(v2, {j, j.Transparency})
                        elseif j:IsA("Decal") then
                            table.insert(v2, {j, j.Transparency})
                        elseif j:IsA("Light") or j:IsA("Beam") or j:IsA("ParticleEmitter") then
                            table.insert(v4, j)
                        end
                    end
                    local v6 = {}
                    for i5, k in ipairs(v3:GetChildren()) do
                        if k:IsA("Model") and k.PrimaryPart then
                            table.insert(v6, k)
                        end
                    end
                    table.sort(v6, function(a1, a2) -- Line: 231
                        return (a1:GetAttribute("TrainCarIndex") or 0) < (a2:GetAttribute("TrainCarIndex") or 0)
                    end)
                    local v7 = {}
                    for i6, n in ipairs(v5:GetDescendants()) do
                        if n:IsA("BasePart")
                            or n:IsA("Decal")
                            or n:IsA("Light")
                            or n:IsA("Beam")
                            or n:IsA("ParticleEmitter") then
                            table.insert(v7, n)
                        end
                    end
                    for i7, m in ipairs(v2) do
                        Attribute_2 = m[1]:GetAttribute("RailAuthoredTransparency") or m[2]
                        m[2] = Attribute_2
                    end
                    v3.Parent = Folder
                    u7[v5] = {
                        Clone = v3,
                        Path = TrainRailPath.Prepare(v1),
                        Cars = v6,
                        Wheels = TrainWheels.Bind(v6),
                        Parts = v2,
                        Effects = v4,
                        Originals = v7,
                        Shown = v5:GetAttribute("RailVisible") == true,
                    }
                    return
                end
            end
            return
        end
    end

    RunService:BindToRenderStep("TrainVisualMotion", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 258
        -- upvalues: Workspace (upval), u8 (ref), add (val), u7 (val), u31 (upval), TrainRailPath (upval)
        -- upvalues: TrainWheels (upval), u33 (upval), Audio (upval)
        local DistanceAt, PrimaryPart, Whistle, v1, v2, v3, v4, v5, v6
        local ServerTimeNow = Workspace:GetServerTimeNow()
        if u8 <= ServerTimeNow then
            u8 = ServerTimeNow + 0.5
            local TrainEventRuntime = Workspace:FindFirstChild("TrainEventRuntime")
            if TrainEventRuntime then
                for i, v in ipairs(TrainEventRuntime:GetChildren()) do
                    if v:IsA("Model") then
                        add(v)
                    end
                end
            end
        end
        local v7 = nil
        local v8 = nil
        for i2, j in u7, v7, v8 do
            if i2.Parent then
                v5 = i2:GetAttribute("RailVisible") == true and not j.Shown and i2.Name == "GhostTrainHalloween"
                j.Shown = v4
                v6 = v4 and u31[i2] == nil
                for i3, k in ipairs(j.Originals) do
                    if k.Parent then
                        if not k:IsA("BasePart") then
                            if not k:IsA("Decal") then
                                if k.Enabled then
                                    k.Enabled = false
                                end
                            elseif k.Transparency ~= 1 then
                                k.Transparency = 1
                            end
                        elseif k.LocalTransparencyModifier ~= 1 then
                            k.LocalTransparencyModifier = 1
                        end
                    end
                end
                for i4, n in ipairs(j.Parts) do
                    v4 = if not v6 then 1 else n[2]
                    if n[1].Transparency ~= v4 then
                        n[1].Transparency = v4
                    end
                end
                for i5, m in ipairs(j.Effects) do
                    if m.Enabled ~= v6 then
                        m.Enabled = v6
                    end
                end
                v6 = i2:GetAttribute("RailTarget") or 0
                if i2:GetAttribute("RailMoving") then
                    DistanceAt = TrainRailPath.DistanceAt
                    v1 = i2:GetAttribute("RailStarted") or ServerTimeNow
                    v2 = i2:GetAttribute("RailDuration") or 0
                    v6 = DistanceAt(i2:GetAttribute("RailStart") or v6, v6, v1, v2, ServerTimeNow)
                end
                for i6, i52 in ipairs(j.Cars) do
                    v3 = TrainRailPath.Frame(j.Path, v6 - ((i52:GetAttribute("TrainCarOffset")) or 0))
                    i52:PivotTo(v3)
                end
                TrainWheels.Update(j.Wheels, v6)
                if v5 and j.Cars[1] then
                    Whistle = u33.Whistle
                    PrimaryPart = j.Cars[1].PrimaryPart
                    Audio.Play(Whistle.Id, PrimaryPart, {Volume = Whistle.Volume, MaxDistance = Whistle.MaxDistance})
                end
            else
                j.Clone:Destroy()
                u7[i2] = nil
            end
        end
    end)
    script.Destroying:Connect(function() -- Line: 331 -- upvalues: u29 (upval), RunService (upval), u7 (val), Folder (val)
        u29.EndRide()
        RunService:UnbindFromRenderStep("TrainVisualMotion")
        local v1 = nil
        local v2 = nil
        for i, j in u7, v1, v2 do
            j.Clone:Destroy()
            for i2, v in ipairs(j.Originals) do
                if v:IsA("BasePart") and v.Parent then
                    v.LocalTransparencyModifier = 0
                end
            end
        end
        Folder:Destroy()
    end)
end

return u29