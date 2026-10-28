-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.SammyGuardSystem
-- Decompile time: 13.37 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SammyEventFlags = require(ReplicatedStorage.Shared.Flags.SammyEventFlags)
require(ReplicatedStorage.Packages.Trove)
local ExplosionVFX = (ReplicatedStorage.Assets.Particles:WaitForChild("SammyEventVFX")):WaitForChild("ExplosionVFX")
local Explosion = ReplicatedStorage.Assets.Sounds:WaitForChild("Explosion")
local u70 = Color3.fromRGB(255, 40, 40)
local u77 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u86 = (ReplicatedStorage.Assets:WaitForChild("SammyEventVisuals")):WaitForChild("Strawberry Elephant Attacker")
local u92 = CFrame.Angles(0, -1.5707963267948966, 0)
local u94 = CameraShaker.new()
local u95 = nil
local u96 = 0
local u97 = 0
assert(Explosion:IsA("Sound"), "Assets.Sounds.Explosion must be a Sound")
assert(u86:IsA("Model"), "Strawberry Elephant Attacker must be a Model")
assert(u86.Rig.RootPart.Anchored, "Strawberry Elephant Attacker.Rig.RootPart must be anchored")
local u120 = RaycastParams.new()
u120.FilterType = Enum.RaycastFilterType.Include
u120.RespectCanCollide = true

local function sammyRoot() -- Line: 88 -- upvalues: u95 (ref)
    local v1 = u95
    if v1 ~= nil and v1.Parent ~= nil then
        if v1:GetAttribute("Chasing") == true and v1:GetAttribute("Stunned") ~= true then
            local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end
        return nil
    end
    return nil
end

local function step() -- Line: 101
    -- upvalues: sammyRoot (val), u96 (ref), Player (val), SammyEventFlags (val), u94 (val)
    local v1 = sammyRoot()
    if v1 == nil then
        return
    end
    local v2 = os.clock()
    if v2 < u96 then
        return
    end
    local v3 = Player.FindPrimaryPart()
    if v3 == nil then
        return
    end
    local v4 = SammyEventFlags.SammyShakeRadiusStuds:Get()
    local Magnitude = (v3.Position - v1.Position).Magnitude
    if v4 <= Magnitude then
        return
    end
    u96 = v2 + 0.35
    u94:ShakeOnce(3.5 * (1 - Magnitude / v4), 8, 0.1, 0.6)
end

local function spawnBombIndicator(a1, a2) -- Line: 129
    -- upvalues: u70 (val), Workspace (val), TweenService (val), u77 (val)
    local Part = Instance.new("Part")
    Part.Name = "SammyBombIndicator"
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(0.4, a2 * 2, a2 * 2)
    Part.CFrame = (CFrame.new(a1 + Vector3.new(0, 0.15000000596046448, 0))) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Material = Enum.Material.Neon
    Part.Color = u70
    Part.Transparency = 0.3
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Workspace
    TweenService:Create(Part, u77, {Transparency = 0.8}):Play()
    return Part
end

local function burstEmitters(a1) -- Line: 150 -- types: a1: userdata
    local Attribute_3, fire
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")

            function fire() -- Line: 158 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute > 0 then
                    j:Emit((math.max(1, (math.floor(Attribute + 0.5)))))
                end
                if type(Attribute_2) == "number" and Attribute_2 > 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 164 -- upvalues: j (upval)
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

local function playExplosion(a1) -- Line: 177
    -- upvalues: ExplosionVFX (val), Workspace (val), burstEmitters (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = "SammyBombExplosion"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(a1)
    local v1 = ExplosionVFX:Clone()
    v1.Parent = Part
    Part.Parent = Workspace
    burstEmitters(v1)
    Debris:AddItem(Part, 3)
end

local function playExplosionSound(a1) -- Line: 195
    -- upvalues: Player (val), u97 (ref), Explosion (val), Workspace (val), Debris (val)
    local v1 = os.clock()
    local v2 = Player.FindPrimaryPart()
    if not (v1 < u97) and v2 ~= nil then
        u97 = v1 + 0.3
        v1 = a1[1]
        for i, j in a1 do
            if (j - v2.Position).Magnitude < (v1 - v2.Position).Magnitude then
                v1 = j
            end
        end
        local Part = Instance.new("Part")
        Part.Name = "SammyBombSound"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Transparency = 1
        Part.Size = Vector3.new(1, 1, 1)
        Part.CFrame = CFrame.new(v1)
        v1 = Explosion:Clone()
        v1.Parent = Part
        Part.Parent = Workspace
        v1:Play()
        Debris:AddItem(Part, 8)
        return
    end
end

local function shakeFromBlasts(a1, a2) -- Line: 225 -- upvalues: Player (val), u94 (val) -- types: a1: table, a2: number
    local v1 = Player.FindPrimaryPart()
    if v1 == nil then
        return
    end
    local v2 = a2 * 3
    local v3 = (1 / 0)
    for i, j in a1 do
        v3 = math.min(v3, (v1.Position - j).Magnitude)
    end
    if v2 <= v3 then
        return
    end
    u94:ShakeOnce(5 * (1 - v3 / v2), 10, 0, 1.5, Vector3.new(0.25, 0.25, 0.25), (Vector3.new(4, 1, 1)))
end

local function dropBombRow(a1, a2, a3, a4) -- Line: 249
    -- upvalues: Player (val), spawnBombIndicator (val), Workspace (val), playExplosion (val), shakeFromBlasts (val)
    -- upvalues: playExplosionSound (val)
    local v1 = Player.FindPrimaryPart()
    if v1 == nil then
        return
    end
    local u7 = {}
    for i, j in a2 do
        if (j - v1.Position).Magnitude <= 670 then
            table.insert(u7, j)
        end
    end
    if #u7 == 0 then
        return
    end
    local u20 = {}
    for k, n in u7 do
        table.insert(u20, (a1:Add((spawnBombIndicator(n, a3)))))
    end
    a1:Add((task.delay(math.max(a4 - Workspace:GetServerTimeNow(), 0), function() -- Line: 267
        -- upvalues: u20 (val), a1 (val), u7 (val), playExplosion (upval), shakeFromBlasts (upval), a3 (val)
        -- upvalues: playExplosionSound (upval)
        for i, j in u20 do
            a1:Remove(j)
        end
        for k, n in u7 do
            playExplosion(n)
        end
        shakeFromBlasts(u7, a3)
        playExplosionSound(u7)
    end)))
end

local function elephantGround(a1) -- Line: 279 -- upvalues: Workspace (val), u120 (val) -- types: a1: vector
    local v1 = Workspace:Raycast(a1 + Vector3.new(0, 60, 0), Vector3.new(0, -200, 0), u120)
    if v1 ~= nil then
        return v1.Position.Y
    end
    return nil
end

local function spawnElephantWarning(a1) -- Line: 289
    -- upvalues: u70 (val), Workspace (val), TweenService (val), u77 (val)
    local Part = Instance.new("Part")
    Part.Name = "SammyElephantWarning"
    Part.Size = Vector3.new(a1, 0.4, 50)
    Part.Material = Enum.Material.Neon
    Part.Color = u70
    Part.Transparency = 0.3
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Parent = Workspace
    TweenService:Create(Part, u77, {Transparency = 0.8}):Play()
    return Part
end

local function runElephants(a1, a2, a3, a4, a5, a6, a7) -- Line: 310
    -- upvalues: Workspace (val), u120 (val), u86 (val), spawnElephantWarning (val), RunService (val), u92 (val)
    local v1, v2
    local v3 = {Workspace.World.Build, Workspace.Terrain}
    local SABMap = Workspace:FindFirstChild("SABMap")
    if SABMap ~= nil then
        table.insert(v3, SABMap)
    end
    u120.FilterDescendantsInstances = v3
    local Hitbox = u86.Hitbox
    local u28 = Hitbox.Size.Y * 0.5
    local u31 = Hitbox.Size.X * 0.5
    local Z = Hitbox.Size.Z
    local u41 = Vector3.new(-a4.Z, 0, a4.X)
    local u42 = {}
    for i, j in a7 do
        v1 = a1:Add((u86:Clone()))
        v1.Parent = Workspace
        v2 = v1.Rig.AnimationController.Animator:LoadAnimation(v1.Animation)
        v2.Looped = true
        v2:Play()
        table.insert(u42, {
            Model = v1,
            Warning = a1:Add((spawnElephantWarning(Z))),
            Offset = j,
            Y = a3.Y,
        })
    end
    local u54 = nil
    a1:Add((RunService.Heartbeat:Connect(function(a1_2) -- Line: 352
        -- upvalues: Workspace (upval), a2 (val), a5 (val), a6 (val), u42 (val), a1 (val), u54 (ref), a3 (val), a4 (val)
        -- upvalues: u41 (val), u120 (upval), u28 (val), u92 (upval), u31 (val), Z (val)
        local Y, Y_2, v1, v2, v3, v4, v5
        local v6 = ((Workspace:GetServerTimeNow()) - a2) * a5
        if a6 <= v6 then
            for k, n in u42 do
                a1:Remove(n.Model)
                a1:Remove(n.Warning)
            end
            a1:Remove(u54)
            return
        end
        local v7 = math.min(1, a1_2 * 10)
        local v8 = math.min(50, a6 - v6)
        local v9 = nil
        local v10 = nil
        for i, j in u42, v9, v10 do
            v5 = a3 + a4 * math.max(v6, 0) + u41 * j.Offset
            Y = j.Y
            v2 = Workspace
            v3 = v5 + Vector3.new(0, 60, 0)
            v4 = u120
            v2 = v2:Raycast(v3, Vector3.new(0, -200, 0), v4)
            Y_2 = (if v2 == nil then nil else v2.Position.Y) or j.Y
            j.Y = Y + (Y_2 - j.Y) * v7
            v1 = Vector3.new(v5.X, j.Y + u28, v5.Z)
            j.Model:PivotTo((CFrame.lookAt(v1, v1 + a4)) * u92)
            v1 = (Vector3.new(v5.X, j.Y + 0.15, v5.Z)) + a4 * (u31 + v8 * 0.5)
            j.Warning.Size = Vector3.new(Z, 0.4, v8)
            j.Warning.CFrame = CFrame.lookAt(v1, v1 + a4)
        end
    end)))
end

local function watchMap(a1, a2) -- Line: 378 -- upvalues: u95 (ref) -- types: a2: userdata
    u95 = a2:FindFirstChild("Sammy")
    a1:Connect(a2.ChildAdded, function(a1) -- Line: 380 -- upvalues: u95 (upval) -- types: a1: userdata
        if a1.Name == "Sammy" and a1:IsA("Model") then
            u95 = a1
        end
    end)
    a1:Connect(a2.ChildRemoved, function(a1) -- Line: 385 -- upvalues: u95 (upval) -- types: a1: userdata
        if a1 == u95 then
            u95 = nil
        end
    end)
end

return {
    Start = function(a1) -- Line: 392
        -- upvalues: u95 (ref), u96 (ref), CameraShakerDriver (val), u94 (val), Workspace (val), watchMap (val)
        -- upvalues: Remotes (val), runElephants (val), dropBombRow (val), RunService (val), step (val)
        u95 = nil
        u96 = 0
        CameraShakerDriver.Start(u94, Enum.RenderPriority.Camera.Value + 2)
        local SammyEventMap = Workspace:FindFirstChild("SammyEventMap")
        if SammyEventMap == nil then
            a1:Connect(Workspace.ChildAdded, function(a1_2) -- Line: 403 -- upvalues: watchMap (upval), a1 (val) -- types: a1_2: userdata
                if a1_2.Name == "SammyEventMap" then
                    watchMap(a1, a1_2)
                end
            end)
        else
            watchMap(a1, SammyEventMap)
        end
        a1:Connect(Remotes.SammyEvent.ElephantCharge.OnClientEvent, function(a1_2, a2, a3, a4, a5, a6) -- Line: 412
            -- upvalues: runElephants (upval), a1 (val)
            runElephants(a1, a1_2, a2, a3, a4, a5, a6)
        end)
        a1:Connect(Remotes.SammyEvent.BomberRow.OnClientEvent, function(a1_2, a2, a3) -- Line: 418
            -- upvalues: dropBombRow (upval), a1 (val)
            dropBombRow(a1, a1_2, a2, a3)
        end)
        a1:Connect(RunService.Heartbeat, step)
        a1:Add(function() -- Line: 423 -- upvalues: u95 (upval), CameraShakerDriver (upval), u94 (upval)
            u95 = nil
            CameraShakerDriver.Stop(u94)
        end)
    end,
}