-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight.Laser
-- Decompile time: 13.30 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Fx = require(script.Parent.Fx)
local Giant = require(script.Parent.Giant)
local Player = require(ReplicatedStorage.Shared.Player)
local Shake = require(ReplicatedStorage.Client.Shake)
local u75 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 235)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 70, 50)),
    (ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 40))),
})
local u87 = ColorSequence.new(Color3.fromRGB(60, 52, 52), Color3.fromRGB(25, 22, 22))
local u88 = {
    {"Particles", "ScrambleBossVFX", "MechBoss", "LaserBeam", "Beam"},
    {"Particles", "ScrambleBossVFX", "MechBoss", "LaserPillar", "Beam"},
}
local u101 = {"Particles", "ScrambleBossVFX", "Blast", "Blast", "Start"}
local u107 = {"Particles", "ScrambleBossVFX", "Blast", "Blast", "End"}
local u113 = {"Particles", "ScrambleBossVFX", "SmokePuff", "SmokeVFX"}
local u118 = {"Particles", "ScrambleBossVFX", "MechBoss", "Slam"}
local v1 = {}

local function copyEmitters(a1, a2, a3) -- Line: 59 -- upvalues: Fx (val) -- types: a1: table, a2: userdata, a3: number
    local v1
    local v2 = Fx.Resolve(a1)
    local v3 = {}
    if v2 == nil then
        return v3
    end
    for i, j in v2:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            v1 = j:Clone()
            v1.Enabled = false
            Fx.ScaleEmitter(v1, a3)
            v1.Parent = a2
            table.insert(v3, v1)
        end
    end
    return v3
end

local function copyBeams(a1, a2, a3) -- Line: 85
    -- upvalues: u88 (val), Fx (val), u75 (val)
    local v1, v2
    local v3 = {}
    local v4 = nil
    local v5 = nil
    local v6, v7, v8 = a1, a2, a3
    for i, j in u88, v4, v5 do
        v2 = Fx.Resolve(j)
        if v2 ~= nil then
            for k, n in v2:GetDescendants() do
                if n:IsA("Beam") then
                    v1 = n:Clone()
                    v1.Attachment0 = v6
                    v1.Attachment1 = v7
                    v1.FaceCamera = true
                    v1.Color = u75
                    v1.LightEmission = 1
                    v1.Width0 = n.Width0 * 2.6
                    v1.Width1 = n.Width1 * 1.15
                    v1.Parent = v8
                    table.insert(v3, v1)
                end
            end
        end
    end
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = v6
    Beam.Attachment1 = v7
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Brightness = 4
    Beam.Color = ColorSequence.new(Color3.fromRGB(255, 235, 225))
    Beam.Transparency = NumberSequence.new(0.05)
    Beam.Width0 = 9
    Beam.Width1 = 2.4
    Beam.Segments = 1
    Beam.Parent = v8
    table.insert(v3, Beam)
    return v3
end

local function setEmitting(a1, a2) -- Line: 130 -- types: a1: table, a2: boolean
    for i, j in a1 do
        j.Enabled = a2
    end
end

local function reticle(a1, a2) -- Line: 136
    -- upvalues: Fx (val), TweenService (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "Reticle"
    Part.Shape = Enum.PartType.Cylinder
    Part.Material = Enum.Material.Neon
    Part.Color = Color3.fromRGB(255, 40, 50)
    Part.Transparency = 0.35
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Size = Vector3.new(0.30000001192092896, 22, 22)
    Part.CFrame = (CFrame.new(a1)) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Parent = Fx.Folder()
    TweenService:Create(
        Part,
        TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = Vector3.new(0.30000001192092896, 6, 6), Transparency = 0.05}
    ):Play()
    Debris:AddItem(Part, a2 + 0.05)
    return Part
end

local function scorch(a1, a2) -- Line: 163
    -- upvalues: Fx (val), TweenService (val), Debris (val)
    local Part = Instance.new("Part")
    local v1 = if not a2 then 20 else 30
    Part.Name = "Scorch"
    Part.Shape = Enum.PartType.Cylinder
    Part.Material = Enum.Material.SmoothPlastic
    Part.Color = Color3.fromRGB(24, 18, 18)
    Part.Transparency = 0.2
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Size = Vector3.new(0.12, v1, v1)
    Part.CFrame = (CFrame.new(a1 + Vector3.new(0, 0.07999999821186066, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Parent = Fx.Folder()
    local v2 = Part:Clone()
    v2.Material = Enum.Material.Neon
    v2.Color = Color3.fromRGB(255, 90, 30)
    v2.Transparency = 0.1
    v2.Size = Vector3.new(0.14, v1 * 0.45, v1 * 0.45)
    v2.CFrame = Part.CFrame + Vector3.new(0, 0.019999999552965164, 0)
    v2.Parent = Fx.Folder()
    TweenService:Create(v2, TweenInfo.new(1.4), {Transparency = 1}):Play()
    TweenService:Create(Part, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
    Debris:AddItem(v2, 1.5)
    Debris:AddItem(Part, 5.1)
end

local function groundUnder(a1, a2) -- Line: 204 -- upvalues: Workspace (val) -- types: a1: vector, a2: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a2
    v1.RespectCanCollide = true
    local v2 = Workspace:Raycast(a1 + Vector3.new(0, 6, 0), Vector3.new(0, -60, 0), v1)
    if v2 ~= nil then
        return v2.Position
    end
    return a1 - Vector3.new(0, 3, 0)
end

local function impact(a1, a2, a3) -- Line: 216
    -- upvalues: Fx (val), u118 (val), Debris (val), scorch (val), Shake (val)
    local v1 = Fx.Resolve(u118)
    if v1 ~= nil then
        local v2 = v1:Clone()
        if v2:IsA("BasePart") then
            v2.Anchored = true
            v2.CanCollide = false
            v2.CanQuery = false
            v2.CanTouch = false
            v2.Transparency = 1
            v2.CFrame = CFrame.new(a1)
        end
        Fx.Scale(v2, if not a2 then 2.2 else 3.4)
        v2.Parent = Fx.Folder()
        Fx.Burst(v2)
        Debris:AddItem(v2, 4)
    end
    scorch(a1, a2)
    Fx.Sound({"Sounds", "ImpactBoom"}, a1, 1.4, 1.05, 1600)
    Fx.Sound({"Sounds", "ScrambleBoss", "Strike"}, a1, 1, 0.9, 900)
    if a2 then
        Fx.Sound({"Sounds", "Explosion"}, a1, 1.1, 1.1, 1600)
    end
    Shake.Play({
        Shape = "Fade",
        Seconds = if not a3 then 0.75 else 1,
        Magnitude = if not a3 then if not a2 then 2.2 else 3 else 4.5,
        Range = {Near = 30, Far = 320, Center = a1},
        Rumble = a3,
    })
end

function v1.Fire(a1, a2, a3, a4, a5, a6) -- Line: 258
    -- upvalues: Players (val), Workspace (val), Player (val), Giant (val), Fx (val), reticle (val), copyEmitters (val)
    -- upvalues: u113 (val), u107 (val), u87 (val), u101 (val), u75 (val), RunService (val), Debris (val)
    -- upvalues: copyBeams (val), impact (val)
    local Attachment_2
    local PlayerByUserId = Players:GetPlayerByUserId(a2)
    local u276 = PlayerByUserId == Players.LocalPlayer
    local u278 = a4 - 0.14
    local v1 = math.max(u278 - Workspace:GetServerTimeNow(), 0.05)

    local function targetPosition() -- Line: 271 -- upvalues: PlayerByUserId (val), Player (upval), a3 (val)
        local v1 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
        if v1 ~= nil then
            return v1.Position
        end
        return a3
    end

    Giant.SetEyes(a1, 2.4)
    local v2 = {Fx.Folder()}
    if PlayerByUserId ~= nil and PlayerByUserId.Character ~= nil then
        table.insert(v2, PlayerByUserId.Character)
    end
    local v3 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
    local Position = if v3 == nil then a3 else v3.Position
    v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    v3.FilterDescendantsInstances = v2
    v3.RespectCanCollide = true
    local v4 = Workspace:Raycast(Position + Vector3.new(0, 6, 0), Vector3.new(0, -60, 0), v3)
    reticle((if v4 == nil then Position - Vector3.new(0, 3, 0) else v4.Position) + Vector3.new(0, 0.20000000298023224, 0), v1)
    local Sound = Fx.Sound
    v2 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
    Sound({"Sounds", "ScrambleBoss", "Charge"}, if v2 == nil then a3 else v2.Position, 1.2, 0.8, 700)
    if u276 then
        Fx.Sound({"Sounds", "ScrambleBoss", "TargetLock"}, nil, 1.3)
    end
    local Holder = Fx.Holder
    local v5 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
    local u280 = Holder(if v5 == nil then a3 else v5.Position, "LaserEnd")
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = u280
    local u283 = copyEmitters(u113, Attachment, 7)
    local u285 = copyEmitters(u107, Attachment, 1.6)
    for i, j in u283 do
        j.Color = u87
        j.LightEmission = 0
    end
    local u281 = {}
    local u286 = {}
    local u287 = {}
    local v6 = nil
    local v7 = nil
    for k, n in a1.Eyes, v6, v7 do
        Attachment_2 = Instance.new("Attachment")
        Attachment_2.Name = "LaserEye"
        Attachment_2.Parent = n
        table.insert(u281, Attachment_2)
        for m, i5 in copyEmitters(u101, Attachment_2, 7) do
            i5.Color = u75
            table.insert(u286, i5)
        end
    end
    for i6, i7 in u286 do
        i7.Enabled = true
    end
    local u202 = false
    local u203 = false
    local u205 = a4 + 0.38
    local u206 = nil

    local function cleanup() -- Line: 328
        -- upvalues: u206 (ref), u286 (val), u283 (val), u285 (val), u287 (val), RunService (upval), u281 (val)
        -- upvalues: Debris (upval), u280 (val), Giant (upval), a1 (val), a6 (val)
        if u206 ~= nil then
            u206:Disconnect()
            u206 = nil
        end
        for i, j in u286 do
            j.Enabled = false
        end
        for k, n in u283 do
            n.Enabled = false
        end
        for m, i5 in u285 do
            i5.Enabled = false
        end
        for i6, i7 in u287 do
            local Width0 = i7.Width0
            local Width1 = i7.Width1
            local u85 = os.clock()
            task.spawn(function() -- Line: 343 -- upvalues: i7 (val), u85 (val), Width0 (val), Width1 (val), RunService (upval)
                local v1
                while i7.Parent ~= nil do
                    if not (os.clock() - u85 < 0.3) then
                        break
                    end
                    v1 = 1 - (os.clock() - u85) / 0.3
                    i7.Width0 = Width0 * v1
                    i7.Width1 = Width1 * v1
                    RunService.RenderStepped:Wait()
                end
                i7:Destroy()
            end)
        end
        for i8, i9 in u281 do
            Debris:AddItem(i9, 3)
        end
        Debris:AddItem(u280, 4)
        Giant.SetEyes(a1, if not a6() then 0 else 0.75)
    end

    RunService.RenderStepped:Connect(function() -- Line: 364
        -- upvalues: Workspace (upval), PlayerByUserId (val), Player (upval), a3 (val), u280 (val), u278 (val)
        -- upvalues: u202 (ref), u281 (val), copyBeams (upval), u287 (val), Fx (upval), u276 (val), a4 (val), u203 (ref)
        -- upvalues: u283 (val), u285 (val), impact (upval), a5 (val), u205 (val), cleanup (val)
        local Position, v1
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v2 = if PlayerByUserId == nil then nil else Player.FindRootPart(PlayerByUserId)
        u280.CFrame = CFrame.new(if v2 == nil then a3 else v2.Position)
        if u278 <= ServerTimeNow and not u202 then
            local Attachment
            u202 = true
            v1 = nil
            local v3 = nil
            for i, j in u281, v1, v3 do
                Attachment = Instance.new("Attachment")
                Attachment.Name = ("LaserTip%*"):format(i)
                Attachment.Parent = u280
                Attachment.WorldPosition = j.WorldPosition
                for k, n in copyBeams(j, Attachment, u280) do
                    table.insert(u287, n)
                end
            end
            Fx.Sound({"Sounds", "ScrambleBoss", "LaserBeam"}, Position, 1.6, 1, 1400)
            if u276 then
                Fx.Sound({"Sounds", "ScrambleBoss", "LaserBeam"}, nil, 0.7)
            end
        end
        if u202 then
            local v4
            v2 = math.clamp((ServerTimeNow - u278) / 0.14, 0, 1)
            for m, i5 in u281 do
                v4 = u280:FindFirstChild((("LaserTip%*"):format(m)))
                if v4 ~= nil and v4:IsA("Attachment") then
                    v4.WorldPosition = i5.WorldPosition:Lerp(Position, v2)
                end
            end
        end
        if a4 <= ServerTimeNow and not u203 then
            u203 = true
            for i6, i7 in u283 do
                i7.Enabled = true
            end
            for i8, i9 in u285 do
                i9.Enabled = true
            end
            v2 = {}
            if PlayerByUserId ~= nil and PlayerByUserId.Character ~= nil then
                table.insert(v2, PlayerByUserId.Character)
            end
            v1 = impact
            local v5 = RaycastParams.new()
            v5.FilterType = Enum.RaycastFilterType.Exclude
            v5.FilterDescendantsInstances = v2
            v5.RespectCanCollide = true
            local v6 = Workspace:Raycast(Position + Vector3.new(0, 6, 0), Vector3.new(0, -60, 0), v5)
            v1(if v6 == nil then Position - Vector3.new(0, 3, 0) else v6.Position, a5, u276)
        end
        if u205 <= ServerTimeNow then
            cleanup()
        end
    end)
end

return v1