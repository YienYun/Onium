-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.RingSystem
-- Decompile time: 36.85 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BulkPartMotion = require(ReplicatedStorage.Client.BulkPartMotion)
local FallenPowerUp = require(ReplicatedStorage.Data.FallenPowerUp)
local LightVsDarkness = require(ReplicatedStorage.Data.LightVsDarkness)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.Parent.UISystem)
local LightVsDarknessSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("LightVsDarknessSounds")
local u78 = Color3.fromRGB(255, 214, 89)
local u93 = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.35),
    NumberSequenceKeypoint.new(0.7, 0.6),
    (NumberSequenceKeypoint.new(1, 1)),
})
local u98 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local Quad = Enum.EasingStyle.Quad
local InOut = Enum.EasingDirection.InOut
local u105 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local u107 = nil
local u108 = nil
local u109 = {}
local u110 = {}
local u111 = {}
local u112 = nil
local u113 = nil
local u114 = {}
local u115 = 0
local u116 = 0
local u117 = 0
local u118 = false
local u119 = 0
local Transient = Workspace:WaitForChild("Transient")
local RingCollect = (ReplicatedStorage.Assets.Particles:WaitForChild("LightVsDarknessVFX")):WaitForChild("RingCollect")
assert(RingCollect:IsA("Attachment"), "LightVsDarknessVFX.RingCollect must be an Attachment")
local u141 = {}
local u142 = nil
local u143 = 0
local u144 = 0

local function bucketOf(a1) -- Line: 139 -- types: a1: number
    return (math.floor(a1 / 100))
end

local function ringsFolder() -- Line: 143 -- upvalues: u112 (ref), Workspace (val), u107 (ref)
    local v1 = u112
    if v1 then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "LightVsDarknessRings"
    Folder.Parent = Workspace
    u107.AssetTrove:Add(Folder)
    u107.AssetTrove:Add(function() -- Line: 152 -- upvalues: u112 (upval)
        u112 = nil
    end)
    u112 = Folder
    return Folder
end

local function stopLoop(a1) -- Line: 159 -- upvalues: u114 (val) -- types: a1: table
    local v1 = u114[a1]
    if v1 then
        u114[a1] = nil
        v1:Stop()
    end
end

local function forgetRing(a1) -- Line: 168 -- upvalues: u111 (val), u114 (val) -- types: a1: table
    local v1 = u111[a1.Zone]
    if v1 then
        v1.Rings[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    v1 = u114[a1]
    if v1 then
        u114[a1] = nil
        v1:Stop()
    end
end

local function destroyRing(a1) -- Line: 180 -- upvalues: u111 (val), u114 (val) -- types: a1: table
    local v1 = u111[a1.Zone]
    if v1 then
        v1.Rings[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    v1 = u114[a1]
    if v1 then
        u114[a1] = nil
        v1:Stop()
    end
    a1.Handle:Destroy()
    a1.Part:Destroy()
end

local function stopRingVfx(a1) -- Line: 188 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
            j.Enabled = false
        end
    end
end

local function burstEmitters(a1) -- Line: 199 -- types: a1: userdata
    local Attribute_3, fire
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")

            function fire() -- Line: 207 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute > 0 then
                    j:Emit((math.max(1, (math.floor(Attribute + 0.5)))))
                end
                if type(Attribute_2) == "number" and Attribute_2 > 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 213 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end

            if type(Attribute_3) ~= "number" or not (Attribute_3 > 0) then
                fire()
            else
                task.delay(Attribute_3, fire)
            end
        end
    end
end

local function playCollectVfx(a1) -- Line: 228
    -- upvalues: RingCollect (val), Transient (val), burstEmitters (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "RingCollect"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    local v1 = RingCollect:Clone()
    v1.Parent = Part
    Part.Parent = Transient
    burstEmitters(v1)
    Debris:AddItem(Part, 2)
end

local function fadeRing(a1) -- Line: 247
    -- upvalues: u111 (val), u114 (val), stopRingVfx (val), TweenService (val), u105 (val), Debris (val)
    local v1 = u111[a1.Zone]
    if v1 then
        v1.Rings[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    v1 = u114[a1]
    if v1 then
        u114[a1] = nil
        v1:Stop()
    end
    a1.Handle:Destroy()
    local Part = a1.Part
    if Part.Parent == nil then
        return
    end
    stopRingVfx(Part)
    TweenService:Create(Part, u105, {Transparency = 1, CFrame = Part.CFrame + Vector3.new(0, 5, 0)}):Play()
    for i, j in Part:GetDescendants() do
        if j:IsA("BasePart") then
            TweenService:Create(j, u105, {Transparency = 1}):Play()
        end
    end
    Debris:AddItem(Part, 0.2)
end

local function fadeLoosePart(a1) -- Line: 269
    -- upvalues: TweenService (val), u105 (val), Debris (val)
    TweenService:Create(a1, u105, {Transparency = 1, CFrame = a1.CFrame + Vector3.new(0, 5, 0)}):Play()
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            TweenService:Create(j, u105, {Transparency = 1}):Play()
        end
    end
    Debris:AddItem(a1, 0.2)
end

local function pullRing(a1, a2, a3) -- Line: 284
    -- upvalues: u111 (val), u114 (val), stopRingVfx (val), LightVsDarkness (val), u78 (val), u93 (val), u141 (val)
    local v1 = u111[a1.Zone]
    if v1 then
        v1.Rings[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    v1 = u114[a1]
    if v1 then
        u114[a1] = nil
        v1:Stop()
    end
    a1.Handle:Destroy()
    local Part = a1.Part
    if Part.Parent == nil then
        return
    end
    stopRingVfx(Part)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Parent = a2
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.FaceCamera = true
    Beam.Width0 = math.max(LightVsDarkness.RARITIES[a1.Ring.Rarity].Radius * 0.5, 0.8)
    Beam.Width1 = 0.25
    Beam.Color = ColorSequence.new(u78)
    Beam.Transparency = u93
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Parent = Part
    u141[Part] = {
        Fading = false,
        Part = Part,
        From = Part.Position,
        StartedAt = os.clock(),
        Target = a2,
        Phase = a1.Phase,
        Rarity = a1.Ring.Rarity,
        Mine = a3,
        Beam = Beam,
        TargetAttachment = Attachment_2,
    }
end

local function dropPullBeam(a1) -- Line: 321 -- types: a1: table
    local Beam = a1.Beam
    if Beam then
        a1.Beam = nil
        Beam:Destroy()
    end
    local TargetAttachment = a1.TargetAttachment
    if TargetAttachment then
        a1.TargetAttachment = nil
        TargetAttachment:Destroy()
    end
end

local function stepPulls(a1) -- Line: 334
    -- upvalues: u141 (val), playCollectVfx (val), fadeLoosePart (val), FallenPowerUp (val), UISystem (val)
    -- upvalues: TweenService (val), u105 (val)
    local Angles, Beam, Beam_2, Beam_3, Target, TargetAttachment, TargetAttachment_2, TargetAttachment_3, v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in u141, v5, v6 do
        Target = j.Target
        if i.Parent == nil then
            u141[i] = nil
            Beam = j.Beam
            if Beam then
                j.Beam = nil
                Beam:Destroy()
            end
            TargetAttachment = j.TargetAttachment
            if TargetAttachment then
                j.TargetAttachment = nil
                TargetAttachment:Destroy()
            end
        elseif Target.Parent ~= nil then
            v3 = (v7 - j.StartedAt) / FallenPowerUp.MagnetPullSeconds
            if not (v3 >= 1) then
                v4 = v3 * v3
                v1 = CFrame.new((j.From:Lerp(Target.Position, v4)) + Vector3.new(0, math.sin(v3 * 3.141592653589793) * 1.5, 0))
                Angles = CFrame.Angles
                v2 = v7 * FallenPowerUp.MagnetPullSpinSpeed + j.Phase
                i.CFrame = v1 * Angles(0, v2, 1.5707963267948966)
                if v3 > 0.7 and not j.Fading then
                    j.Fading = true
                    for k, n in i:GetDescendants() do
                        if n:IsA("BasePart") then
                            TweenService:Create(n, u105, {Transparency = 1}):Play()
                        end
                    end
                    TweenService:Create(i, u105, {Transparency = 1}):Play()
                end
            else
                u141[i] = nil
                Beam_3 = j.Beam
                if Beam_3 then
                    j.Beam = nil
                    Beam_3:Destroy()
                end
                TargetAttachment_3 = j.TargetAttachment
                if TargetAttachment_3 then
                    j.TargetAttachment = nil
                    TargetAttachment_3:Destroy()
                end
                playCollectVfx(i.Position)
                if j.Mine then
                    UISystem.RingArrived(j.Rarity, i.Position)
                end
                i:Destroy()
            end
        else
            u141[i] = nil
            Beam_2 = j.Beam
            if Beam_2 then
                j.Beam = nil
                Beam_2:Destroy()
            end
            TargetAttachment_2 = j.TargetAttachment
            if TargetAttachment_2 then
                j.TargetAttachment = nil
                TargetAttachment_2:Destroy()
            end
            playCollectVfx(i.Position)
            fadeLoosePart(i)
        end
    end
end

local function buildRing(a1, a2, a3, a4) -- Line: 378
    -- upvalues: LightVsDarkness (val), u144 (ref), ringsFolder (val), BulkPartMotion (val)
    local v1 = LightVsDarkness.RARITIES[a4.Rarity]
    local v2 = LightVsDarkness.Template(a4.Rarity):Clone()
    v2.Name = v1.Id
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
    v2.CFrame = (CFrame.new(a4.X, a4.Y - u144, a4.Z)) * CFrame.Angles(0, 0, 1.5707963267948966)
    v2.Parent = ringsFolder()
    v1 = {
        Pending = false,
        Part = v2,
        Handle = BulkPartMotion.Register(v2),
        Ring = a4,
        Zone = a1,
        Id = a3,
        Bucket = math.floor(a4.X / 100),
        Phase = a3 % 7,
    }
    a2.Rings[a3] = v1
    v2 = a2.Buckets[v1.Bucket]
    if v2 == nil then
        a2.Buckets[v1.Bucket] = {}
    end
    v2[v1] = true
end

local function destroyZone(a1) -- Line: 416 -- upvalues: u111 (val), u114 (val) -- types: a1: number
    local v1, v2
    local v3 = u111[a1]
    if v3 == nil then
        return
    end
    u111[a1] = nil
    local v4 = nil
    local v5 = nil
    for i, j in v3.Rings, v4, v5 do
        v1 = u111[j.Zone]
        if v1 then
            v1.Rings[j.Id] = nil
            v2 = v1.Buckets[j.Bucket]
            if v2 then
                v2[j] = nil
            end
        end
        v1 = u114[j]
        if v1 then
            u114[j] = nil
            v1:Stop()
        end
        j.Handle:Destroy()
        j.Part:Destroy()
    end
end

local function stopClearing() -- Line: 428 -- upvalues: u119 (ref), u118 (ref)
    u119 = u119 + 1
    u118 = false
end

local function clearRings() -- Line: 433
    -- upvalues: u119 (ref), u118 (ref), u111 (val), u114 (val), u108 (ref), u109 (ref), u110 (ref), u113 (ref)
    -- upvalues: u142 (ref), u143 (ref), u144 (ref)
    local v1, v2, v3, v4, v5
    u119 = u119 + 1
    u118 = false
    local v6 = nil
    local v7 = nil
    for i in u111, v6, v7 do
        v3 = u111[i]
        if v3 ~= nil then
            u111[i] = nil
            v4 = nil
            v5 = nil
            for j, k in v3.Rings, v4, v5 do
                v1 = u111[k.Zone]
                if v1 then
                    v1.Rings[k.Id] = nil
                    v2 = v1.Buckets[k.Bucket]
                    if v2 then
                        v2[k] = nil
                    end
                end
                v1 = u114[k]
                if v1 then
                    u114[k] = nil
                    v1:Stop()
                end
                k.Handle:Destroy()
                k.Part:Destroy()
            end
        end
    end
    for n in u114 do
        v3 = u114[n]
        if v3 then
            u114[n] = nil
            v3:Stop()
        end
    end
    u108 = nil
    u109 = {}
    u110 = {}
    u113 = nil
    u142 = nil
    u143 = 0
    u144 = 0
end

local function spawnPoint() -- Line: 450 -- upvalues: Workspace (val)
    local SpawnLocation = Workspace:FindFirstChild("SpawnLocation")
    assert(SpawnLocation and SpawnLocation:IsA("BasePart"), "Workspace.SpawnLocation must be a BasePart")
    return SpawnLocation.Position
end

local function fadeOutWave() -- Line: 459
    -- upvalues: u111 (val), u108 (ref), u109 (ref), u110 (ref), u113 (ref), u142 (ref), clearRings (val)
    -- upvalues: Workspace (val), u119 (ref), u118 (ref), fadeRing (val)
    local v1 = {}
    local v2 = nil
    local v3 = nil
    for i, j in u111, v2, v3 do
        for k, n in j.Rings do
            table.insert(v1, n)
        end
    end
    u108 = nil
    u109 = {}
    u110 = {}
    u113 = nil
    u142 = nil
    if #v1 == 0 then
        clearRings()
        return
    end
    local SpawnLocation = Workspace:FindFirstChild("SpawnLocation")
    assert(SpawnLocation and SpawnLocation:IsA("BasePart"), "Workspace.SpawnLocation must be a BasePart")
    local Position = SpawnLocation.Position
    table.sort(v1, function(a1, a2) -- Line: 477 -- upvalues: Position (val) -- types: a1: table, a2: table
        local v1 = Vector3.new(a1.Ring.X, a1.Ring.Y, a1.Ring.Z)
        local v2 = Vector3.new(a2.Ring.X, a2.Ring.Y, a2.Ring.Z)
        local Magnitude = (v1 - Position).Magnitude
        return (v2 - Position).Magnitude < Magnitude
    end)
    u119 = u119 + 1
    u118 = true
    local u44 = u119
    for m, i5 in v1 do
        task.delay((m - 1) / #v1 * 5, function() -- Line: 487 -- upvalues: u119 (upval), u44 (val), fadeRing (upval), i5 (val)
            if u119 == u44 then
                fadeRing(i5)
            end
        end)
    end
    task.delay(5.2, function() -- Line: 493 -- upvalues: u119 (upval), u44 (val), clearRings (upval)
        if u119 == u44 then
            clearRings()
        end
    end)
end

local function retireBuilt(a1) -- Line: 500
    -- upvalues: u119 (ref), u118 (ref), u111 (val), u114 (val), stopRingVfx (val), TweenService (val), u98 (val)
    -- upvalues: Debris (val)
    local Part, v1, v2, v3, v4
    u119 = u119 + 1
    u118 = false
    local v5 = nil
    local v6 = nil
    for i, j in u111, v5, v6 do
        u111[i] = nil
        v3 = nil
        v4 = nil
        for k, n in j.Rings, v3, v4 do
            v1 = u114[n]
            if v1 then
                u114[n] = nil
                v1:Stop()
            end
            n.Handle:Destroy()
            Part = n.Part
            if Part.Parent ~= nil then
                stopRingVfx(Part)
                TweenService:Create(Part, u98, {
                    Transparency = 1,
                    CFrame = Part.CFrame + Vector3.new(0, a1 * 16, 0),
                }):Play()
                for m, i5 in Part:GetDescendants() do
                    if i5:IsA("BasePart") then
                        TweenService:Create(i5, u98, {Transparency = 1}):Play()
                    end
                end
                Debris:AddItem(Part, 0.45)
            end
        end
    end
    for i6 in u114 do
        v2 = u114[i6]
        if v2 then
            u114[i6] = nil
            v2:Stop()
        end
    end
end

local function updateRenderLift(a1) -- Line: 529
    -- upvalues: u143 (ref), u144 (ref), LightVsDarknessEventFlags (val), TweenService (val), Quad (val), InOut (val)
    if u143 <= 0 then
        u144 = 0
        return
    end
    local v1 = (a1 - u143) / 1.5
    if not (v1 >= 1) then
        u144 = (LightVsDarknessEventFlags.FlyHeightStuds:Get()) * (1 - TweenService:GetValue(math.max(v1, 0), Quad, InOut))
        return
    end
    u143 = 0
    u144 = 0
end

local function adoptWave(a1, a2, a3, a4) -- Line: 544
    -- upvalues: u142 (ref), retireBuilt (val), u108 (ref), u109 (ref), u110 (ref), u113 (ref), u143 (ref), u144 (ref)
    -- upvalues: LightVsDarknessEventFlags (val), TweenService (val), Quad (val), InOut (val)
    local v1 = u142
    retireBuilt(if v1 ~= "Sky" then 1 else if a2 ~= "Ground" then 1 else -1)
    u108 = a1
    u109 = a3
    u110 = {}
    u113 = nil
    u142 = a2
    u143 = if a2 ~= "Sky" then 0 else if v1 ~= "Ground" then 0 else os.clock()
    local v2 = os.clock()
    if not (u143 <= 0) then
        v1 = (v2 - u143) / 1.5
        if not (v1 >= 1) then
            u144 = (LightVsDarknessEventFlags.FlyHeightStuds:Get()) * (1 - TweenService:GetValue(math.max(v1, 0), Quad, InOut))
        else
            u143 = 0
            u144 = 0
        end
    else
        u144 = 0
    end
    if a4 then
        local v3
        local v4 = nil
        local v5 = nil
        for i, j in a4, v4, v5 do
            v3 = {}
            for k, n in j do
                v3[n] = true
            end
            u110[i] = v3
        end
    end
end

local function syncZones(a1) -- Line: 566
    -- upvalues: LightVsDarkness (val), u113 (ref), u111 (val), u114 (val), u109 (ref)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = LightVsDarkness.ZoneIndexAt(a1.Position)
    if v8 == u113 then
        return
    end
    u113 = v8
    local v9 = nil
    local v10 = nil
    for i in u111, v9, v10 do
        v6 = math.abs(i - v8)
        if v6 > 3 then
            v6 = u111[i]
            if v6 ~= nil then
                u111[i] = nil
                v7 = nil
                v1 = nil
                for j, k in v6.Rings, v7, v1 do
                    v2 = u111[k.Zone]
                    if v2 then
                        v2.Rings[k.Id] = nil
                        v3 = v2.Buckets[k.Bucket]
                        if v3 then
                            v3[k] = nil
                        end
                    end
                    v2 = u114[k]
                    if v2 then
                        u114[k] = nil
                        v2:Stop()
                    end
                    k.Handle:Destroy()
                    k.Part:Destroy()
                end
            end
        end
    end
    v10 = v8 - 3
    local v11 = v8 + 3
    for n = v10, v11 do
        v4 = u109[n]
        if v4 ~= nil and u111[n] == nil then
            v5 = u111
            v6 = {NextId = 1, Source = LightVsDarkness.DecodeRings(v4), Rings = {}, Buckets = {}}
            v5[n] = v6
        end
    end
end

local function continueBuilds() -- Line: 591 -- upvalues: u111 (val), u110 (ref), buildRing (val)
    local NextId, v1
    local v2 = 400
    local v3 = nil
    local v4 = nil
    for i, j in u111, v3, v4 do
        v1 = u110[i]
        while v2 > 0 do
            if not (j.NextId <= #j.Source) then
                break
            end
            NextId = j.NextId
            j.NextId = NextId + 1
            if v1 == nil or not v1[NextId] then
                buildRing(i, j, NextId, j.Source[NextId])
                v2 = v2 - 1
            end
        end
        if v2 <= 0 then
            return
        end
    end
end

local function spin(a1, a2) -- Line: 609
    -- upvalues: u111 (val), u117 (ref), LightVsDarkness (val), u144 (ref)
    local Ring, SpinSpeed, v1, v2, v3
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in u111, v4, v5 do
        v2 = nil
        v3 = nil
        for k, n in j.Buckets, v2, v3 do
            v1 = math.abs((k + 0.5) * 100 - v6.Position.X)
            if not (v1 > 800) then
                if not (v1 > 250) then
                    for m in n do
                        Ring = m.Ring
                        SpinSpeed = LightVsDarkness.RARITIES[Ring.Rarity].SpinSpeed
                        m.Handle:SetCFrame((CFrame.new(Ring.X, Ring.Y - u144, Ring.Z)) * (CFrame.Angles(0, v7 * SpinSpeed + m.Phase, 1.5707963267948966)))
                    end
                elseif (u117 + k) % 4 == 0 then
                    for i5 in n do
                        Ring = i5.Ring
                        SpinSpeed = LightVsDarkness.RARITIES[Ring.Rarity].SpinSpeed
                        i5.Handle:SetCFrame((CFrame.new(Ring.X, Ring.Y - u144, Ring.Z)) * (CFrame.Angles(0, v7 * SpinSpeed + i5.Phase, 1.5707963267948966)))
                    end
                end
            end
        end
    end
end

local function nearbyBuilt(a1, a2) -- Line: 632 -- upvalues: u111 (val) -- types: a1: userdata, a2: number
    local Ring, v1, v2, v3
    local v4 = {}
    local v5 = math.floor(a1.Position.X / 100)
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in u111, v6, v7 do
        v1 = v5 - 1
        v3 = v5 + 1
        for k = v1, v3 do
            v2 = j.Buckets[k]
            if v2 ~= nil then
                for n in v2 do
                    Ring = n.Ring
                    if ((Vector3.new(Ring.X, Ring.Y, Ring.Z)) - v8.Position).Magnitude <= v9 then
                        table.insert(v4, n)
                    end
                end
            end
        end
    end
    return v4
end

local function playCollectSound(a1, a2) -- Line: 653
    -- upvalues: u116 (ref), u115 (ref), LightVsDarkness (val), LightVsDarknessSounds (val)
    local v1 = os.clock()
    if 1.5 < v1 - u116 then
        u115 = 0
    end
    u115 = u115 + 1
    u116 = v1
    v1 = math.min(u115 - 1, 12)
    local v2 = LightVsDarknessSounds:FindFirstChild((("Collect%*Ring"):format(LightVsDarkness.RARITIES[a1].Id)))
    if v2 then
        local u33 = v2:Clone()
        u33.Parent = v2.Parent
        u33.PlayOnRemove = true
        u33.PlaybackSpeed = v1 * 0.06 + 1
        task.defer(function() -- Line: 671 -- upvalues: u33 (val)
            u33:Destroy()
        end)
    end
end

local function collect(a1, a2) -- Line: 677
    -- upvalues: u108 (ref), LocalPlayer (val), LightVsDarknessEventFlags (val), FallenPowerUp (val), Workspace (val)
    -- upvalues: nearbyBuilt (val), LightVsDarkness (val), Remotes (val), playCollectSound (val), pullRing (val)
    local Magnitude, Ring, v1
    local v2 = u108
    if v2 == nil or type((LocalPlayer:GetAttribute("LvdTeam"))) ~= "string" then
        return
    end
    local v3 = LightVsDarknessEventFlags.CollectRadiusPadding:Get()
    local v4 = (LightVsDarknessEventFlags.MagnetRadiusStuds:Get()) * (if not FallenPowerUp.IsActive(LocalPlayer, "Magnet", Workspace:GetServerTimeNow()) then 0.25 else 1)
    local v5 = a1
    for i, j in nearbyBuilt(a1, (math.max(40, v4))) do
        if not j.Pending then
            Ring = j.Ring
            v1 = LightVsDarkness.RARITIES[Ring.Rarity].Radius + v3
            Magnitude = ((Vector3.new(Ring.X, Ring.Y, Ring.Z)) - v5.Position).Magnitude
            if not (v1 < Magnitude) or not (v4 < Magnitude) then
                j.Pending = true
                Remotes.LightVsDarkness.AskCollectRing:FireServer(v2, j.Zone, j.Id)
                playCollectSound(j.Ring.Rarity, v5)
                pullRing(j, v5, true)
            end
        end
    end
end

local function playSound(a1, a2, a3) -- Line: 712
    -- upvalues: LightVsDarknessSounds (val), Audio (val)
    local v1
    local v2 = LightVsDarknessSounds:FindFirstChild(a1)
    local v3 = ("LightVsDarknessSounds.%* must be a Sound"):format(a1)
    assert(v2 and v2:IsA("Sound"), v3)
    local Volume = (if not a3 then {} else table.clone(a3)).Volume or v2.Volume
    v1.Volume = Volume
    local MaxDistance = v1.MaxDistance or v2.RollOffMaxDistance
    v1.MaxDistance = MaxDistance
    v1.SoundGroup = v1.SoundGroup or "SFX"
    return Audio.Play(v2, a2, v1)
end

local function updateNearby(a1) -- Line: 724
    -- upvalues: nearbyBuilt (val), u114 (val), LightVsDarkness (val), playSound (val)
    local v1
    local v2 = {}
    for i, j in nearbyBuilt(a1, 40) do
        if 1 < j.Ring.Rarity and not j.Pending then
            table.insert(v2, j)
        end
    end
    table.sort(v2, function(a1_2, a2) -- Line: 731 -- upvalues: a1 (val)
        local Ring = a1_2.Ring
        local Ring_2 = a2.Ring
        return ((Vector3.new(Ring.X, Ring.Y, Ring.Z)) - a1.Position).Magnitude < ((Vector3.new(Ring_2.X, Ring_2.Y, Ring_2.Z)) - a1.Position).Magnitude
    end)
    local v3 = {}
    for k = 1, (math.min(#v2, 3)) do
        v3[v2[k]] = true
    end
    for n in u114 do
        if not v3[n] then
            v2 = u114[n]
            if v2 then
                u114[n] = nil
                v2:Stop()
            end
        end
    end
    for m in v3 do
        if u114[m] == nil then
            v1 = playSound(("Nearby%*RingLooped"):format(LightVsDarkness.RARITIES[m.Ring.Rarity].Id), m.Part, {Looped = true})
            if v1 then
                u114[m] = v1
            end
        end
    end
end

local function onRingCollected(a1, a2, a3, a4) -- Line: 756
    -- upvalues: u108 (ref), u110 (ref), u111 (val), Players (val), Player (val), pullRing (val), playCollectVfx (val)
    -- upvalues: fadeRing (val)
    if a1 ~= u108 then
        return
    end
    local v1 = u110[a2]
    if v1 == nil then
        u110[a2] = {}
    end
    v1[a3] = true
    v1 = u111[a2]
    local v2 = if not v1 then nil else v1.Rings[a3]
    if v2 then
        v1 = Players:GetPlayerByUserId(a4)
        local v3 = if v1 == nil then nil else Player.FindRootPart(v1)
        if v3 ~= nil and v3:IsA("BasePart") then
            pullRing(v2, v3, false)
            return
        end
        playCollectVfx((Vector3.new(v2.Ring.X, v2.Ring.Y, v2.Ring.Z)))
        fadeRing(v2)
    end
end

local function onRingRespawned(a1, a2, a3) -- Line: 784
    -- upvalues: u108 (ref), u110 (ref), u111 (val), buildRing (val)
    if a1 ~= u108 then
        return
    end
    local v1 = u110[a2]
    if v1 then
        v1[a3] = nil
    end
    v1 = u111[a2]
    if v1 and v1.Rings[a3] == nil and a3 < v1.NextId then
        buildRing(a2, v1, a3, v1.Source[a3])
    end
end

local function step() -- Line: 798
    -- upvalues: stepPulls (val), u108 (ref), u118 (ref), Player (val), LocalPlayer (val), u117 (ref), u143 (ref)
    -- upvalues: u144 (ref), LightVsDarknessEventFlags (val), TweenService (val), Quad (val), InOut (val), spin (val)
    -- upvalues: syncZones (val), continueBuilds (val), collect (val), updateNearby (val)
    stepPulls(os.clock())
    if u108 == nil and not u118 then
        return
    end
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    if v1 == nil then
        return
    end
    u117 = u117 + 1
    local v2 = os.clock()
    if not (u143 <= 0) then
        local v3 = (v2 - u143) / 1.5
        if not (v3 >= 1) then
            u144 = (LightVsDarknessEventFlags.FlyHeightStuds:Get()) * (1 - TweenService:GetValue(math.max(v3, 0), Quad, InOut))
        else
            u143 = 0
            u144 = 0
        end
    else
        u144 = 0
    end
    spin(v1, v2)
    if u108 == nil then
        return
    end
    syncZones(v1)
    continueBuilds()
    collect(v1, v2)
    if u117 % 10 == 0 then
        updateNearby(v1)
    end
end

local function start() -- Line: 824
    -- upvalues: u107 (ref), clearRings (val), Remotes (val), u142 (ref), retireBuilt (val), u108 (ref), u109 (ref)
    -- upvalues: u110 (ref), u113 (ref), u143 (ref), u144 (ref), LightVsDarknessEventFlags (val), TweenService (val)
    -- upvalues: Quad (val), InOut (val), fadeOutWave (val), onRingCollected (val), onRingRespawned (val)
    -- upvalues: RunService (val), step (val), u141 (val), u115 (ref), adoptWave (val)
    local AssetTrove = u107.AssetTrove
    clearRings()
    AssetTrove:Connect(Remotes.LightVsDarkness.RingsSpawned.OnClientEvent, function(a1, a2, a3) -- Line: 827
        -- upvalues: u142 (upval), retireBuilt (upval), u108 (upval), u109 (upval), u110 (upval), u113 (upval)
        -- upvalues: u143 (upval), u144 (upval), LightVsDarknessEventFlags (upval), TweenService (upval), Quad (upval)
        -- upvalues: InOut (upval)
        local v1 = u142
        retireBuilt(if v1 ~= "Sky" then 1 else if a2 ~= "Ground" then 1 else -1)
        u108 = a1
        u109 = a3
        u110 = {}
        u113 = nil
        u142 = a2
        u143 = if a2 ~= "Sky" then 0 else if v1 ~= "Ground" then 0 else os.clock()
        local v2 = os.clock()
        if u143 <= 0 then
            u144 = 0
            return
        end
        v1 = (v2 - u143) / 1.5
        if not (v1 >= 1) then
            u144 = (LightVsDarknessEventFlags.FlyHeightStuds:Get()) * (1 - TweenService:GetValue(math.max(v1, 0), Quad, InOut))
            return
        end
        u143 = 0
        u144 = 0
    end)
    AssetTrove:Connect(Remotes.LightVsDarkness.RingsCleared.OnClientEvent, function(a1) -- Line: 830 -- upvalues: u108 (upval), fadeOutWave (upval) -- types: a1: number
        if a1 == u108 then
            fadeOutWave()
        end
    end)
    AssetTrove:Connect(Remotes.LightVsDarkness.RingCollected.OnClientEvent, onRingCollected)
    AssetTrove:Connect(Remotes.LightVsDarkness.RingRespawned.OnClientEvent, onRingRespawned)
    AssetTrove:Connect(RunService.Heartbeat, step)
    AssetTrove:Add(function() -- Line: 838 -- upvalues: clearRings (upval), u141 (upval), u115 (upval)
        local Beam, TargetAttachment
        clearRings()
        local v1 = nil
        local v2 = nil
        for i, j in u141, v1, v2 do
            Beam = j.Beam
            if Beam then
                j.Beam = nil
                Beam:Destroy()
            end
            TargetAttachment = j.TargetAttachment
            if TargetAttachment then
                j.TargetAttachment = nil
                TargetAttachment:Destroy()
            end
        end
        table.clear(u141)
        u115 = 0
    end)
    AssetTrove:Add((task.spawn(function() -- Line: 848 -- upvalues: Remotes (upval), u107 (upval), u108 (upval), adoptWave (upval)
        local v1, v2, v3, v4 = Remotes.LightVsDarkness.FetchRings:InvokeServer()
        if type(v1) == "number" and u107.IsEventActive() and u108 == nil then
            adoptWave(v1, v2, v3, v4)
        end
    end)))
end

return function(a1) -- Line: 858 -- upvalues: u107 (ref), start (val), clearRings (val) -- types: a1: table
    u107 = a1
    return {Start = start, Clear = clearRings}
end