-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.CollectSystem
-- Decompile time: 32.60 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BulkPartMotion = require(ReplicatedStorage.Client.BulkPartMotion)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SammyEvent = require(ReplicatedStorage.Data.SammyEvent)
local SammyEventFlags = require(ReplicatedStorage.Shared.Flags.SammyEventFlags)
require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.Parent.UISystem)
local LightVsDarknessSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("LightVsDarknessSounds")
local u75 = Color3.fromRGB(255, 214, 89)
local u90 = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.35),
    NumberSequenceKeypoint.new(0.7, 0.6),
    (NumberSequenceKeypoint.new(1, 1)),
})
local u95 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u100 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local u102 = nil
local u103 = nil
local u104 = {}
local u105 = {}
local u106 = {}
local u107 = nil
local u108 = nil
local u109 = 0
local u110 = 0
local u111 = 0
local u112 = false
local u113 = 0
local Transient = Workspace:WaitForChild("Transient")
local RingCollect = (ReplicatedStorage.Assets.Particles:WaitForChild("LightVsDarknessVFX")):WaitForChild("RingCollect")
assert(RingCollect:IsA("Attachment"), "LightVsDarknessVFX.RingCollect must be an Attachment")
local u135 = {}
local DischargePulse = (ReplicatedStorage.Assets:WaitForChild("SammyEventVisuals")):WaitForChild("DischargePulse")
assert(DischargePulse:IsA("BasePart"), "SammyEventVisuals.DischargePulse must be a BasePart")
local u164 = ((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("SeparationLine")
assert(u164:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")
local u172 = false
local u174 = RaycastParams.new()
u174.FilterType = Enum.RaycastFilterType.Include
u174.RespectCanCollide = true

local function bucketOf(a1) -- Line: 150 -- types: a1: number
    return (math.floor(a1 / 100))
end

local function pickupsFolder() -- Line: 154 -- upvalues: u107 (ref), Workspace (val), u102 (ref)
    local v1 = u107
    if v1 then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "SammyEmpPickups"
    Folder.Parent = Workspace
    u102.AssetTrove:Add(Folder)
    u102.AssetTrove:Add(function() -- Line: 163 -- upvalues: u107 (upval)
        u107 = nil
    end)
    u107 = Folder
    return Folder
end

local function forgetPickup(a1) -- Line: 171 -- upvalues: u106 (val) -- types: a1: table
    local v1 = u106[a1.Zone]
    if v1 then
        v1.Pickups[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
end

local function destroyPickup(a1) -- Line: 182 -- upvalues: u106 (val) -- types: a1: table
    local v1 = u106[a1.Zone]
    if v1 then
        v1.Pickups[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    a1.Handle:Destroy()
    a1.Part:Destroy()
end

local function stopPickupVfx(a1) -- Line: 190 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
            j.Enabled = false
        end
    end
end

local function burstEmitters(a1) -- Line: 201 -- types: a1: userdata
    local Attribute_3, fire
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")

            function fire() -- Line: 209 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute > 0 then
                    j:Emit((math.max(1, (math.floor(Attribute + 0.5)))))
                end
                if type(Attribute_2) == "number" and Attribute_2 > 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 215 -- upvalues: j (upval)
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

local function playCollectVfx(a1) -- Line: 230
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

local function fadePickup(a1) -- Line: 249
    -- upvalues: u106 (val), stopPickupVfx (val), TweenService (val), u100 (val), Debris (val)
    local v1 = u106[a1.Zone]
    if v1 then
        v1.Pickups[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    a1.Handle:Destroy()
    local Part = a1.Part
    if Part.Parent == nil then
        return
    end
    stopPickupVfx(Part)
    TweenService:Create(Part, u100, {Transparency = 1, CFrame = Part.CFrame + Vector3.new(0, 5, 0)}):Play()
    for i, j in Part:GetDescendants() do
        if j:IsA("BasePart") then
            TweenService:Create(j, u100, {Transparency = 1}):Play()
        end
    end
    Debris:AddItem(Part, 0.2)
end

local function fadeLoosePart(a1) -- Line: 271
    -- upvalues: TweenService (val), u100 (val), Debris (val)
    TweenService:Create(a1, u100, {Transparency = 1, CFrame = a1.CFrame + Vector3.new(0, 5, 0)}):Play()
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            TweenService:Create(j, u100, {Transparency = 1}):Play()
        end
    end
    Debris:AddItem(a1, 0.2)
end

local function pullPickup(a1, a2, a3) -- Line: 286
    -- upvalues: u106 (val), stopPickupVfx (val), SammyEvent (val), u75 (val), u90 (val), u135 (val)
    local v1 = u106[a1.Zone]
    if v1 then
        v1.Pickups[a1.Id] = nil
        local v2 = v1.Buckets[a1.Bucket]
        if v2 then
            v2[a1] = nil
        end
    end
    a1.Handle:Destroy()
    local Part = a1.Part
    if Part.Parent == nil then
        return
    end
    stopPickupVfx(Part)
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Parent = a2
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_2
    Beam.FaceCamera = true
    Beam.Width0 = math.max(SammyEvent.PickupRadius * 0.5, 0.8)
    Beam.Width1 = 0.25
    Beam.Color = ColorSequence.new(u75)
    Beam.Transparency = u90
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Parent = Part
    u135[Part] = {
        Fading = false,
        Part = Part,
        From = Part.Position,
        StartedAt = os.clock(),
        Target = a2,
        Phase = a1.Phase,
        Mine = a3,
        Beam = Beam,
        TargetAttachment = Attachment_2,
    }
end

local function dropPullBeam(a1) -- Line: 322 -- types: a1: table
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

local function stepPulls(a1) -- Line: 335
    -- upvalues: u135 (val), playCollectVfx (val), fadeLoosePart (val), UISystem (val), TweenService (val), u100 (val)
    local Angles, Beam, Beam_2, Beam_3, Target, TargetAttachment, TargetAttachment_2, TargetAttachment_3, v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in u135, v5, v6 do
        Target = j.Target
        if i.Parent == nil then
            u135[i] = nil
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
            v3 = (v7 - j.StartedAt) / 0.35
            if not (v3 >= 1) then
                v4 = v3 * v3
                v1 = CFrame.new((j.From:Lerp(Target.Position, v4)) + Vector3.new(0, math.sin(v3 * 3.141592653589793) * 1.5, 0))
                Angles = CFrame.Angles
                v2 = v7 * 12 + j.Phase
                i.CFrame = v1 * Angles(0, v2, 1.5707963267948966)
                if v3 > 0.7 and not j.Fading then
                    j.Fading = true
                    for k, n in i:GetDescendants() do
                        if n:IsA("BasePart") then
                            TweenService:Create(n, u100, {Transparency = 1}):Play()
                        end
                    end
                    TweenService:Create(i, u100, {Transparency = 1}):Play()
                end
            else
                u135[i] = nil
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
                    UISystem.PickupArrived(i.Position)
                end
                i:Destroy()
            end
        else
            u135[i] = nil
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

local function buildPickup(a1, a2, a3, a4) -- Line: 379
    -- upvalues: SammyEvent (val), pickupsFolder (val), BulkPartMotion (val)
    local v1 = SammyEvent.PickupTemplate():Clone()
    v1.Name = "EmpCharge"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
        end
    end
    v1.CFrame = (CFrame.new(a4.X, a4.Y, a4.Z)) * CFrame.Angles(0, 0, 1.5707963267948966)
    v1.Parent = pickupsFolder()
    local v2 = {
        Pending = false,
        Part = v1,
        Handle = BulkPartMotion.Register(v1),
        Pickup = a4,
        Zone = a1,
        Id = a3,
        Bucket = math.floor(a4.X / 100),
        Phase = a3 % 7,
    }
    a2.Pickups[a3] = v2
    v1 = a2.Buckets[v2.Bucket]
    if v1 == nil then
        a2.Buckets[v2.Bucket] = {}
    end
    v1[v2] = true
end

local function destroyZone(a1) -- Line: 416 -- upvalues: u106 (val) -- types: a1: number
    local v1, v2
    local v3 = u106[a1]
    if v3 == nil then
        return
    end
    u106[a1] = nil
    local v4 = nil
    local v5 = nil
    for i, j in v3.Pickups, v4, v5 do
        v1 = u106[j.Zone]
        if v1 then
            v1.Pickups[j.Id] = nil
            v2 = v1.Buckets[j.Bucket]
            if v2 then
                v2[j] = nil
            end
        end
        j.Handle:Destroy()
        j.Part:Destroy()
    end
end

local function stopClearing() -- Line: 428 -- upvalues: u113 (ref), u112 (ref)
    u113 = u113 + 1
    u112 = false
end

local function clearPickups() -- Line: 433
    -- upvalues: u113 (ref), u112 (ref), u106 (val), u103 (ref), u104 (ref), u105 (ref), u108 (ref)
    local v1, v2, v3, v4, v5
    u113 = u113 + 1
    u112 = false
    local v6 = nil
    local v7 = nil
    for i in u106, v6, v7 do
        v3 = u106[i]
        if v3 ~= nil then
            u106[i] = nil
            v4 = nil
            v5 = nil
            for j, k in v3.Pickups, v4, v5 do
                v1 = u106[k.Zone]
                if v1 then
                    v1.Pickups[k.Id] = nil
                    v2 = v1.Buckets[k.Bucket]
                    if v2 then
                        v2[k] = nil
                    end
                end
                k.Handle:Destroy()
                k.Part:Destroy()
            end
        end
    end
    u103 = nil
    u104 = {}
    u105 = {}
    u108 = nil
end

local function spawnPoint() -- Line: 444 -- upvalues: Workspace (val)
    local SpawnLocation = Workspace:FindFirstChild("SpawnLocation")
    assert(SpawnLocation and SpawnLocation:IsA("BasePart"), "Workspace.SpawnLocation must be a BasePart")
    return SpawnLocation.Position
end

local function fadeOutWave() -- Line: 453
    -- upvalues: u106 (val), u103 (ref), u104 (ref), u105 (ref), u108 (ref), clearPickups (val), Workspace (val)
    -- upvalues: u113 (ref), u112 (ref), fadePickup (val)
    local v1 = {}
    local v2 = nil
    local v3 = nil
    for i, j in u106, v2, v3 do
        for k, n in j.Pickups do
            table.insert(v1, n)
        end
    end
    u103 = nil
    u104 = {}
    u105 = {}
    u108 = nil
    if #v1 == 0 then
        clearPickups()
        return
    end
    local SpawnLocation = Workspace:FindFirstChild("SpawnLocation")
    assert(SpawnLocation and SpawnLocation:IsA("BasePart"), "Workspace.SpawnLocation must be a BasePart")
    local Position = SpawnLocation.Position
    table.sort(v1, function(a1, a2) -- Line: 470 -- upvalues: Position (val) -- types: a1: table, a2: table
        local v1 = Vector3.new(a1.Pickup.X, a1.Pickup.Y, a1.Pickup.Z)
        local v2 = Vector3.new(a2.Pickup.X, a2.Pickup.Y, a2.Pickup.Z)
        local Magnitude = (v1 - Position).Magnitude
        return (v2 - Position).Magnitude < Magnitude
    end)
    u113 = u113 + 1
    u112 = true
    local u43 = u113
    for m, i5 in v1 do
        task.delay((m - 1) / #v1 * 5, function() -- Line: 480 -- upvalues: u113 (upval), u43 (val), fadePickup (upval), i5 (val)
            if u113 == u43 then
                fadePickup(i5)
            end
        end)
    end
    task.delay(5.2, function() -- Line: 486 -- upvalues: u113 (upval), u43 (val), clearPickups (upval)
        if u113 == u43 then
            clearPickups()
        end
    end)
end

local function retireBuilt() -- Line: 495
    -- upvalues: u113 (ref), u112 (ref), u106 (val), stopPickupVfx (val), TweenService (val), u95 (val), Debris (val)
    local Part, v1, v2
    u113 = u113 + 1
    u112 = false
    local v3 = nil
    local v4 = nil
    for i, j in u106, v3, v4 do
        u106[i] = nil
        v1 = nil
        v2 = nil
        for k, n in j.Pickups, v1, v2 do
            n.Handle:Destroy()
            Part = n.Part
            if Part.Parent ~= nil then
                stopPickupVfx(Part)
                TweenService:Create(Part, u95, {Transparency = 1, CFrame = Part.CFrame + Vector3.new(0, 16, 0)}):Play()
                for m, i5 in Part:GetDescendants() do
                    if i5:IsA("BasePart") then
                        TweenService:Create(i5, u95, {Transparency = 1}):Play()
                    end
                end
                Debris:AddItem(Part, 0.45)
            end
        end
    end
end

local function adoptWave(a1, a2, a3) -- Line: 520
    -- upvalues: retireBuilt (val), u103 (ref), u104 (ref), u105 (ref), u108 (ref)
    retireBuilt()
    u103 = a1
    u104 = a2
    u105 = {}
    u108 = nil
    if a3 then
        local v1
        local v2 = nil
        local v3 = nil
        for i, j in a3, v2, v3 do
            v1 = {}
            for k, n in j do
                v1[n] = true
            end
            u105[i] = v1
        end
    end
end

local function syncZones(a1) -- Line: 538
    -- upvalues: SammyEvent (val), u108 (ref), u106 (val), u104 (ref)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = SammyEvent.ZoneIndexAt(a1.Position)
    if v8 == u108 then
        return
    end
    u108 = v8
    local v9 = nil
    local v10 = nil
    for i in u106, v9, v10 do
        v6 = math.abs(i - v8)
        if v6 > 3 then
            v6 = u106[i]
            if v6 ~= nil then
                u106[i] = nil
                v7 = nil
                v1 = nil
                for j, k in v6.Pickups, v7, v1 do
                    v2 = u106[k.Zone]
                    if v2 then
                        v2.Pickups[k.Id] = nil
                        v3 = v2.Buckets[k.Bucket]
                        if v3 then
                            v3[k] = nil
                        end
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
        v4 = u104[n]
        if v4 ~= nil and u106[n] == nil then
            v5 = u106
            v6 = {NextId = 1, Source = SammyEvent.DecodePickups(v4), Pickups = {}, Buckets = {}}
            v5[n] = v6
        end
    end
end

local function continueBuilds() -- Line: 563 -- upvalues: u106 (val), u105 (ref), buildPickup (val)
    local NextId, v1
    local v2 = 400
    local v3 = nil
    local v4 = nil
    for i, j in u106, v3, v4 do
        v1 = u105[i]
        while v2 > 0 do
            if not (j.NextId <= #j.Source) then
                break
            end
            NextId = j.NextId
            j.NextId = NextId + 1
            if v1 == nil or not v1[NextId] then
                buildPickup(i, j, NextId, j.Source[NextId])
                v2 = v2 - 1
            end
        end
        if v2 <= 0 then
            return
        end
    end
end

local function spin(a1, a2) -- Line: 581
    -- upvalues: SammyEvent (val), u106 (val), u111 (ref)
    local Pickup, v1, v2, v3
    local SpinSpeed = SammyEvent.SpinSpeed
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a2
    for i, j in u106, v4, v5 do
        v3 = nil
        v1 = nil
        for k, n in j.Buckets, v3, v1 do
            v2 = math.abs((k + 0.5) * 100 - v6.Position.X)
            if not (v2 > 800) then
                if not (v2 > 250) then
                    for m in n do
                        Pickup = m.Pickup
                        m.Handle:SetCFrame((CFrame.new(Pickup.X, Pickup.Y, Pickup.Z)) * (CFrame.Angles(0, v7 * SpinSpeed + m.Phase, 1.5707963267948966)))
                    end
                elseif (u111 + k) % 4 == 0 then
                    for i5 in n do
                        Pickup = i5.Pickup
                        i5.Handle:SetCFrame((CFrame.new(Pickup.X, Pickup.Y, Pickup.Z)) * (CFrame.Angles(0, v7 * SpinSpeed + i5.Phase, 1.5707963267948966)))
                    end
                end
            end
        end
    end
end

local function nearbyBuilt(a1, a2) -- Line: 604 -- upvalues: u106 (val) -- types: a1: userdata, a2: number
    local Pickup, v1, v2, v3
    local v4 = {}
    local v5 = math.floor(a1.Position.X / 100)
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in u106, v6, v7 do
        v1 = v5 - 1
        v3 = v5 + 1
        for k = v1, v3 do
            v2 = j.Buckets[k]
            if v2 ~= nil then
                for n in v2 do
                    Pickup = n.Pickup
                    if ((Vector3.new(Pickup.X, Pickup.Y, Pickup.Z)) - v8.Position).Magnitude <= v9 then
                        table.insert(v4, n)
                    end
                end
            end
        end
    end
    return v4
end

local function playCollectSound() -- Line: 625 -- upvalues: u110 (ref), u109 (ref), LightVsDarknessSounds (val)
    local v1 = os.clock()
    if 1.5 < v1 - u110 then
        u109 = 0
    end
    u109 = u109 + 1
    u110 = v1
    v1 = math.min(u109 - 1, 12)
    local CollectNormalRing = LightVsDarknessSounds:FindFirstChild("CollectNormalRing")
    assert(CollectNormalRing and CollectNormalRing:IsA("Sound"), "LightVsDarknessSounds.CollectNormalRing must be a Sound")
    local u31 = CollectNormalRing:Clone()
    u31.Parent = CollectNormalRing.Parent
    u31.PlayOnRemove = true
    u31.PlaybackSpeed = v1 * 0.06 + 1
    task.defer(function() -- Line: 639 -- upvalues: u31 (val)
        u31:Destroy()
    end)
end

local function collect(a1) -- Line: 644
    -- upvalues: u103 (ref), SammyEvent (val), SammyEventFlags (val), nearbyBuilt (val), Remotes (val)
    -- upvalues: playCollectSound (val), pullPickup (val)
    local Magnitude, Pickup
    local v1 = u103
    if v1 == nil then
        return
    end
    local v2 = SammyEvent.PickupRadius + SammyEventFlags.CollectRadiusPadding:Get()
    local v3 = SammyEventFlags.MagnetRadiusStuds:Get()
    local v4 = a1
    for i, j in nearbyBuilt(a1, (math.max(v2, v3))) do
        if not j.Pending then
            Pickup = j.Pickup
            Magnitude = ((Vector3.new(Pickup.X, Pickup.Y, Pickup.Z)) - v4.Position).Magnitude
            if not (v2 < Magnitude) or not (v3 < Magnitude) then
                j.Pending = true
                Remotes.SammyEvent.AskCollectPickup:FireServer(v1, j.Zone, j.Id)
                playCollectSound()
                pullPickup(j, v4, true)
            end
        end
    end
end

local function onPickupCollected(a1, a2, a3, a4) -- Line: 671
    -- upvalues: u103 (ref), u105 (ref), u106 (val), Players (val), Player (val), pullPickup (val), playCollectVfx (val)
    -- upvalues: fadePickup (val)
    if a1 ~= u103 then
        return
    end
    local v1 = u105[a2]
    if v1 == nil then
        u105[a2] = {}
    end
    v1[a3] = true
    v1 = u106[a2]
    local v2 = if not v1 then nil else v1.Pickups[a3]
    if v2 then
        v1 = Players:GetPlayerByUserId(a4)
        local v3 = if v1 == nil then nil else Player.FindRootPart(v1)
        if v3 ~= nil and v3:IsA("BasePart") then
            pullPickup(v2, v3, false)
            return
        end
        playCollectVfx((Vector3.new(v2.Pickup.X, v2.Pickup.Y, v2.Pickup.Z)))
        fadePickup(v2)
    end
end

local function onPickupRespawned(a1, a2, a3) -- Line: 699
    -- upvalues: u103 (ref), u105 (ref), u106 (val), buildPickup (val)
    if a1 ~= u103 then
        return
    end
    local v1 = u105[a2]
    if v1 then
        v1[a3] = nil
    end
    v1 = u106[a2]
    if v1 and v1.Pickups[a3] == nil and a3 < v1.NextId then
        buildPickup(a2, v1, a3, v1.Source[a3])
    end
end

local function step() -- Line: 713
    -- upvalues: stepPulls (val), u103 (ref), u112 (ref), Player (val), LocalPlayer (val), u111 (ref), spin (val)
    -- upvalues: syncZones (val), continueBuilds (val), collect (val)
    stepPulls(os.clock())
    if u103 == nil and not u112 then
        return
    end
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    if v1 == nil then
        return
    end
    u111 = u111 + 1
    spin(v1, (os.clock()))
    if u103 == nil then
        return
    end
    syncZones(v1)
    continueBuilds()
    collect(v1)
end

local function dischargeGround(a1) -- Line: 734 -- upvalues: Workspace (val), u174 (val) -- types: a1: vector
    local v1 = Workspace:Raycast(a1 + Vector3.new(0, 60, 0), Vector3.new(0, -200, 0), u174)
    if v1 ~= nil then
        return v1.Position.Y
    end
    return nil
end

local function sweepDischarge(a1, a2, a3) -- Line: 745
    -- upvalues: SammyEvent (val), DischargePulse (val), Transient (val), RunService (val), Workspace (val), u174 (val)
    local u5 = SammyEvent.Zones()
    local Bounds = u5[1].Bounds
    local Bounds_2 = u5[#u5].Bounds
    local u23 = if not (a3 < 0) then Bounds_2.Position.X + Bounds_2.Size.X * 0.5 else Bounds.Position.X - Bounds.Size.X * 0.5
    local Rotation = DischargePulse.CFrame.Rotation
    local X = a2.X
    local Y = a2.Y
    local Z = a2.Z
    local u39 = a1:Add((DischargePulse:Clone()))
    u39.CFrame = CFrame.new(X, Y, Z) * Rotation
    u39.Parent = Transient
    local u47 = nil
    a1:Add((RunService.Heartbeat:Connect(function(a1_2) -- Line: 760
        -- upvalues: X (ref), a3 (val), u23 (val), a1 (val), u39 (val), u47 (ref), u5 (val), SammyEvent (upval), Y (ref)
        -- upvalues: Z (ref), Workspace (upval), u174 (upval), Rotation (val)
        X = X + a3 * 350 * a1_2
        if (u23 - X) * a3 <= 0 then
            a1:Remove(u39)
            a1:Remove(u47)
            return
        end
        local v1 = Z
        local Bounds = u5[SammyEvent.ZoneIndexAt((Vector3.new(X, Y, v1)))].Bounds
        local v2 = Vector3.new(X, Bounds.Position.Y, Bounds.Position.Z)
        local v3 = Workspace
        local v4 = v2 + Vector3.new(0, 60, 0)
        local v5 = u174
        v3 = v3:Raycast(v4, Vector3.new(0, -200, 0), v5)
        local Y_3 = (if v3 == nil then nil else v3.Position.Y) or Bounds.Position.Y
        v2 = math.min(1, a1_2 * 10)
        Y = Y + (Y_3 - Y) * v2
        Z = Z + (Bounds.Position.Z - Z) * v2
        u39.CFrame = (CFrame.new(X, Y, Z)) * Rotation
    end)))
end

local function discharge(a1) -- Line: 776
    -- upvalues: Player (val), LocalPlayer (val), DischargePulse (val), Transient (val), Debris (val)
    -- upvalues: GuardAreaGeometry (val), u164 (val), Workspace (val), u174 (val), sweepDischarge (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil and v1:IsA("BasePart") then
        local v2 = DischargePulse:Clone()
        v2.CFrame = (CFrame.new(v1.Position)) * DischargePulse.CFrame.Rotation
        v2.Parent = Transient
        Debris:AddItem(v2, 1)
        if not GuardAreaGeometry.IsPastLine(u164, v1.Position) then
            return
        end
        script.DischargeSFX:Play()
        v2 = {Workspace.World.Build, Workspace.Terrain}
        local SABMap = Workspace:FindFirstChild("SABMap")
        if SABMap ~= nil then
            table.insert(v2, SABMap)
        end
        u174.FilterDescendantsInstances = v2
        sweepDischarge(a1, v1.Position, -1)
        sweepDischarge(a1, v1.Position, 1)
        return
    end
end

local function start() -- Line: 802
    -- upvalues: u102 (ref), clearPickups (val), Remotes (val), retireBuilt (val), u103 (ref), u104 (ref), u105 (ref)
    -- upvalues: u108 (ref), fadeOutWave (val), onPickupCollected (val), onPickupRespawned (val), Workspace (val)
    -- upvalues: u172 (ref), SammyEvent (val), discharge (val), RunService (val), step (val), u135 (val), u109 (ref)
    -- upvalues: adoptWave (val)
    local AssetTrove = u102.AssetTrove
    clearPickups()
    AssetTrove:Connect(Remotes.SammyEvent.PickupsSpawned.OnClientEvent, function(a1, a2) -- Line: 805
        -- upvalues: retireBuilt (upval), u103 (upval), u104 (upval), u105 (upval), u108 (upval)
        retireBuilt()
        u103 = a1
        u104 = a2
        u105 = {}
        u108 = nil
    end)
    AssetTrove:Connect(Remotes.SammyEvent.PickupsCleared.OnClientEvent, function(a1) -- Line: 808 -- upvalues: u103 (upval), fadeOutWave (upval) -- types: a1: number
        if a1 == u103 then
            fadeOutWave()
        end
    end)
    AssetTrove:Connect(Remotes.SammyEvent.PickupCollected.OnClientEvent, onPickupCollected)
    AssetTrove:Connect(Remotes.SammyEvent.PickupRespawned.OnClientEvent, onPickupRespawned)
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    local v1 = false
    if type(Attribute) == "number" then
        v1 = Attribute < SammyEvent.ChargeMax
    end
    u172 = v1
    AssetTrove:Connect(Workspace:GetAttributeChangedSignal("SammyEmpCharge"), function() -- Line: 818
        -- upvalues: Workspace (upval), SammyEvent (upval), u172 (upval), discharge (upval), AssetTrove (val)
        local Attribute = Workspace:GetAttribute("SammyEmpCharge")
        if type(Attribute) ~= "number" then
            return
        end
        if Attribute < SammyEvent.ChargeMax then
            u172 = true
            return
        end
        if u172 then
            u172 = false
            discharge(AssetTrove)
        end
    end)
    AssetTrove:Connect(RunService.Heartbeat, step)
    AssetTrove:Add(function() -- Line: 831 -- upvalues: clearPickups (upval), u135 (upval), u109 (upval)
        local Beam, TargetAttachment
        clearPickups()
        local v1 = nil
        local v2 = nil
        for i, j in u135, v1, v2 do
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
        table.clear(u135)
        u109 = 0
    end)
    AssetTrove:Add((task.spawn(function() -- Line: 841 -- upvalues: Remotes (upval), u102 (upval), u103 (upval), adoptWave (upval)
        local v1, v2, v3 = Remotes.SammyEvent.FetchPickups:InvokeServer()
        if type(v1) == "number" and u102.IsEventActive() and u103 == nil then
            adoptWave(v1, v2, v3)
        end
    end)))
end

return function(a1) -- Line: 851 -- upvalues: u102 (ref), start (val), clearPickups (val) -- types: a1: table
    u102 = a1
    return {Start = start, Clear = clearPickups}
end