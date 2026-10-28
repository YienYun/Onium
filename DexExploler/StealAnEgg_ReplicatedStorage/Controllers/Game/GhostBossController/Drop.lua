-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController.Drop
-- Decompile time: 24.47 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Burst = require(script.Parent.Burst)
local GhostBossFlags = require(ReplicatedStorage.Shared.Flags.GhostBossFlags)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local SoulsHud = require(script.Parent.SoulsHud)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local RuptureSeconds = Burst.RuptureSeconds
local u50 = {}
u50.__index = u50

local function sound(...) -- Line: 115 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    for i, j in {...} do
        Assets = if not Assets then nil else Assets:FindFirstChild(j)
    end
    if Assets and Assets:IsA("Sound") then
        return Assets
    end
    return nil
end

local function playAt(a1, a2, a3, a4) -- Line: 123
    -- upvalues: Audio (val)
    if a1 then
        Audio.Play(a1, a2, {MaxDistance = 160, Volume = a3, PlaybackSpeed = a4})
    end
end

local function arc(a1, a2, a3, a4) -- Line: 129 -- types: a1: vector, a2: vector, a3: number, a4: number
    return (a1:Lerp(a2, a4)) + Vector3.new(0, a3 * 4 * a4 * (1 - a4), 0)
end

local function assets() -- Line: 134 -- upvalues: ReplicatedStorage (val), GhostBoss (val)
    return ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
end

local function prepareMaster(a1) -- Line: 138
    -- upvalues: ReplicatedStorage (val), GhostBoss (val)
    local v1 = a1:Clone()
    local v2 = 0
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            v2 = math.max(v2, j.Size.Magnitude)
        end
    end
    local v3 = nil
    for k, n in v1:GetDescendants() do
        if n:IsA("LuaSourceContainer") then
            n:Destroy()
        elseif n:IsA("BasePart") then
            if not (n.Size.Magnitude < v2 * 0.4) then
                n.Anchored = true
                n.CanCollide = false
                n.CanTouch = false
                n.CanQuery = false
                n.CastShadow = false
                v3 = v3 or n
            else
                n:Destroy()
            end
        end
    end
    assert(v3, "Green fire has no parts")
    local BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
    v1.PrimaryPart = v3
    v3.PivotOffset = CFrame.new(v3.CFrame:PointToObjectSpace(BoundingBox.Position - Vector3.new(0, BoundingBox_2.Y / 2, 0)))
    local v4 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    v3 = v4 and v4:FindFirstChild("VFX")
    v4 = v3 and v3:FindFirstChild("Embers")
    v3 = v4 and v4:FindFirstChildWhichIsA("ParticleEmitter")
    v4 = nil
    if v3 then
        v4 = v3:Clone()
        v4.Rate = math.min(v4.Rate, 3)
        v4.Enabled = true
    end
    return v1, BoundingBox_2.Y, v4
end

local function rootPosition() -- Line: 181 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end
    return nil
end

local function orbCount(a1) -- Line: 187 -- upvalues: GhostBossFlags (val) -- types: a1: number
    local v1 = math.max(GhostBossFlags.SoulsPerOrb:Get(), 1)
    local v2 = GhostBossFlags.SoulOrbsMinimum:Get()
    return (math.min(math.clamp(math.ceil(a1 / v1), v2, (math.max(v2, (GhostBossFlags.SoulOrbsMaximum:Get())))), 150, a1))
end

local function groundParams(a1) -- Line: 194 -- upvalues: Players (val) -- types: a1: userdata
    local v1 = {a1}
    for i, j in Players:GetPlayers() do
        if j.Character then
            table.insert(v1, j.Character)
        end
    end
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = v1
    v2.RespectCanCollide = true
    return v2
end

local function groundAt(a1, a2, a3) -- Line: 208
    -- upvalues: Workspace (val)
    local v1 = Workspace:Raycast(a1 + Vector3.new(0, 20, 0), Vector3.new(0, -80, 0), a3)
    if v1 then
        return v1.Position
    end
    return (Vector3.new(a1.X, a2, a1.Z))
end

local function iconTarget(a1) -- Line: 217 -- upvalues: Workspace (val), SoulsHud (val) -- types: a1: vector
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = SoulsHud.IconViewportPoint()
    if CurrentCamera ~= nil and v1 ~= nil then
        local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
        return v2.Origin + v2.Direction * 4
    end
    return a1
end

function u50.new(a1, a2, a3) -- Line: 231
    -- upvalues: Trove (val), ReplicatedStorage (val), GhostBoss (val), prepareMaster (val), u50 (val)
    local v1 = Trove.new()
    local v2 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local GreenFire = v2 and v2:FindFirstChild("GreenFire")
    v2 = nil
    local v3 = nil
    local v4 = 4
    if GreenFire and GreenFire:IsA("Model") then
        local v5, v6, v7 = prepareMaster(GreenFire)
        v2 = v1:Add(v5)
        v4 = v6
        v3 = if not v7 then nil else v1:Add(v7)
    end
    return (setmetatable({
        Clock = 0,
        Done = false,
        PopCount = 0,
        Lights = 0,
        Trove = v1,
        Parent = a3,
        Master = v2,
        Ember = v3,
        Height = v4,
        From = a1,
        To = a2,
        Born = os.clock(),
        Spirits = {},
        Absorbing = {},
        Random = Random.new(),
    }, u50))
end

function u50.IsDone(a1) -- Line: 267
    return a1.Done
end

function u50:SpawnSpirits(a2) -- Line: 271 -- upvalues: groundParams (val), Workspace (val) -- types: a2: number
    local v1 = {}
    if self.Master ~= nil and not (a2 <= 0) then
        local Position, Y, v2, v3, v4, v5
        local v6 = math.min(a2, 150 - #self.Spirits)
        local Random = self.Random
        local v7 = groundParams(self.Parent)
        local v8 = os.clock()
        local v9 = Random:NextNumber(0, 6.283185307179586)
        local v10 = math.max(math.floor(v6 / 4), 1)
        local v11 = self
        for i = 1, v6 do
            v2 = v9 + i / v6 * 6.283185307179586 + Random:NextNumber(-0.3, 0.3)
            v3 = math.sqrt((Random:NextNumber())) * 22 + 8
            v4 = v11.To + Vector3.new(math.cos(v2) * v3, 0, (math.sin(v2)) * v3)
            Y = v11.To.Y
            v5 = Workspace:Raycast(v4 + Vector3.new(0, 20, 0), Vector3.new(0, -80, 0), v7)
            Position = if not v5 then Vector3.new(v4.X, Y, v4.Z) else v5.Position
            v3 = {
                Value = 0,
                Grown = false,
                Scale = Random:NextNumber(0.55, 0.8),
                From = v11.From,
                To = Position,
                Position = v11.From,
                Born = v8 + (i - 1) * 0.4 / math.max(v6 - 1, 1),
                Flight = Random:NextNumber(1.1, 1.6),
                Peak = Random:NextNumber(16, 28),
                Tumble = Vector3.new(
                    Random:NextNumber(-1, 1),
                    (Random:NextNumber(1, 2.5)) * (if not ((Random:NextNumber()) < 0.5) then 1 else -1),
                    (Random:NextNumber(-1, 1))
                ),
                Seed = Random:NextNumber(0, 100),
                Ember = i % 3 == 0,
            }
            v4 = true
            if i % v10 ~= 1 then
                v4 = v10 == 1
            end
            v3.Light = v4
            table.insert(v11.Spirits, v3)
            table.insert(v1, v3)
        end
        return v1
    end
    return v1
end

function u50:Materialize(a2) -- Line: 318 -- types: a2: table
    local Master = self.Master
    if Master == nil then
        return nil
    end
    local v1 = self.Trove:Add((Master:Clone()))
    local PrimaryPart = v1.PrimaryPart
    if PrimaryPart then
        local Ember = self.Ember
        if a2.Ember and Ember then
            Ember:Clone().Parent = PrimaryPart
        end
        if a2.Light and self.Lights < 4 then
            self.Lights = self.Lights + 1
            local PointLight = Instance.new("PointLight")
            PointLight.Name = "GreenFireLight"
            PointLight.Color = Color3.fromRGB(90, 255, 160)
            PointLight.Brightness = 1.6
            PointLight.Range = 14
            PointLight.Shadows = false
            PointLight.Parent = PrimaryPart
        end
    end
    v1:ScaleTo(a2.Scale * 0.3)
    v1:PivotTo((CFrame.new(a2.From)))
    v1.Parent = self.Parent
    a2.Model = v1
    return v1
end

function u50:Release(a2) -- Line: 348 -- types: a2: userdata?
    if a2 then
        self.Trove:Remove(a2)
    end
end

function u50:AddSouls(a2) -- Line: 354 -- upvalues: SoulsHud (val), GhostBossFlags (val), sound (val), Audio (val)
    if a2.Souls <= 0 then
        return
    end
    if not self.FadeAt and self.Master ~= nil then
        local v1, v2
        if self.SpawnedAt == nil then
            self.Queued = a2
            return
        end
        self.Queued = nil
        SoulsHud.Prime(a2.Balance - a2.Souls)
        local Souls = a2.Souls
        local v3 = math.max(GhostBossFlags.SoulsPerOrb:Get(), 1)
        local v4 = GhostBossFlags.SoulOrbsMinimum:Get()
        local v5 = math.max(v4, (GhostBossFlags.SoulOrbsMaximum:Get()))
        local v6 = math.min(math.clamp(math.ceil(Souls / v3), v4, v5), 150, Souls)
        local v7 = {}
        for i, j in self.Spirits do
            if j.Value == 0 then
                table.insert(v7, j)
            end
        end
        if #v7 < v6 then
            for k, n in self:SpawnSpirits(v6 - #v7) do
                table.insert(v7, n)
            end
        end
        v6 = math.min(v6, #v7)
        if v6 <= 0 then
            SoulsHud.Collect(self.To, a2.Souls)
            return
        end
        v3 = math.floor(a2.Souls / v6)
        v4 = a2.Souls - v3 * v6
        for m = 1, v6 do
            v2 = v7[m]
            v2.Value = v3 + (if not (m <= v4) then 0 else 1)
        end
        v5 = sound("Sounds", "LightVsDarknessSounds", "CollectRainbowRing")
        local To = v1.To
        if v5 then
            Audio.Play(v5, To, {Volume = 0.6, PlaybackSpeed = 0.9, MaxDistance = 160})
        end
        return
    end
    SoulsHud.Prime(a2.Balance - a2.Souls)
    SoulsHud.Collect(self.To, a2.Souls)
end

function u50:StartAbsorb(a2, a3, a4) -- Line: 394
    -- upvalues: GuiService (val), SoulsHud (val)
    local Model = a2.Model
    if Model ~= nil and not GuiService.ReducedMotionEnabled then
        table.insert(self.Absorbing, {
            Model = Model,
            Value = a2.Value,
            Scale = a3,
            From = a4,
            Born = os.clock(),
            Yaw = self.Clock * 0.9 + a2.Seed,
        })
        return
    end
    SoulsHud.Collect(a4 + Vector3.new(0, self.Height * a3 / 2, 0), a2.Value)
    self:Release(Model)
end

function u50:StepSpirits(a2) -- Line: 411
    -- upvalues: LocalPlayer (val), GhostBossFlags (val), sound (val), Audio (val), SoulsHud (val)
    local LandedAt, Magnitude, Model, To_2, v1, v2, v3, v4, v5
    local v6 = os.clock()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Position = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
    local v7 = GhostBossFlags.SoulAutoCollectSeconds:Get()
    local v8 = GhostBossFlags.SoulPickupRadiusStuds:Get()
    local v9 = self.SpawnedAt or v6
    local v10 = 1
    local FadeAt = self.FadeAt
    if FadeAt then
        v10 = 1 - math.clamp((v6 - FadeAt) / 0.8, 0, 1)
    end
    local v11 = self
    for i = #self.Spirits, 1, -1 do
        v1 = v11.Spirits[i]
        if not (v6 < v1.Born) then
            Model = v1.Model or v11:Materialize(v1)
            if Model ~= nil then
                LandedAt = v1.LandedAt
                if LandedAt == nil then
                    v3 = math.clamp((v6 - v1.Born) / v1.Flight, 0, 1)
                    v4 = v1.Tumble * (1 - v3) * 6.283185307179586
                    v1.Position = (v1.From:Lerp(v1.To, v3)) + Vector3.new(0, v1.Peak * 4 * v3 * (1 - v3), 0)
                    if not v1.Grown then
                        v5 = 1 - (1 - math.clamp(v3 / 0.3, 0, 1)) ^ 2
                        Model:ScaleTo(v1.Scale * (v5 * 0.7 + 0.3))
                        v1.Grown = v5 >= 1
                    end
                    Model:PivotTo((CFrame.new(v1.Position)) * (CFrame.Angles(v4.X * 0.15, v4.Y + v11.Clock * 0.9 + v1.Seed, v4.Z * 0.15)))
                    if v3 >= 1 then
                        v1.LandedAt = v6
                        if not v1.Grown then
                            v1.Grown = true
                            Model:ScaleTo(v1.Scale)
                        end
                        v11.PopCount = v11.PopCount + 1
                        if v11.PopCount % 6 == 1 then
                            v5 = sound("ShootingStar", "Sounds", "BuddyPop")
                            To_2 = v1.To
                            if v5 then
                                Audio.Play(v5, To_2, {Volume = 0.3, MaxDistance = 160, PlaybackSpeed = {1.1, 1.4}})
                            end
                        end
                    end
                elseif not (0 < v1.Value) or not (0.15 <= v6 - LandedAt) then
                    v3 = v6 - LandedAt
                    v2 = 0
                    if v3 < 0.45 then
                        v4 = v3 / 0.45
                        v2 = math.abs((math.sin(v4 * 3.141592653589793 * 2))) * 1.2 * (1 - v4)
                    end
                    if FadeAt then
                        Model:ScaleTo((math.max(v1.Scale * v10, 0.05)))
                    end
                    Model:PivotTo((CFrame.new(v1.Position + Vector3.new(0, (math.sin(v11.Clock * 2.6 + v1.Seed) * 0.5 + 0.5) * 0.35 + 0.25 + v2, 0))) * (CFrame.Angles(0, v11.Clock * 0.9 + v1.Seed, 0)))
                else
                    v3 = v1.Position + Vector3.new(0, v11.Height * v1.Scale / 2, 0)
                    Magnitude = if not Position then (1 / 0) else (Position - v3).Magnitude
                    if Magnitude <= v8 then
                        table.remove(v11.Spirits, i)
                        if not (Magnitude > 260) then
                            v11:StartAbsorb(v1, v1.Scale, (Model:GetPivot()).Position)
                        else
                            SoulsHud.Collect(v3, v1.Value)
                            v11:Release(Model)
                        end
                    elseif not (v7 <= v6 - v9) then
                        v3 = v6 - LandedAt
                        v2 = 0
                        if v3 < 0.45 then
                            v4 = v3 / 0.45
                            v2 = math.abs((math.sin(v4 * 3.141592653589793 * 2))) * 1.2 * (1 - v4)
                        end
                        if FadeAt then
                            Model:ScaleTo((math.max(v1.Scale * v10, 0.05)))
                        end
                        Model:PivotTo((CFrame.new(v1.Position + Vector3.new(0, (math.sin(v11.Clock * 2.6 + v1.Seed) * 0.5 + 0.5) * 0.35 + 0.25 + v2, 0))) * (CFrame.Angles(0, v11.Clock * 0.9 + v1.Seed, 0)))
                    else
                        table.remove(v11.Spirits, i)
                        if not (Magnitude > 260) then
                            v11:StartAbsorb(v1, v1.Scale, (Model:GetPivot()).Position)
                        else
                            SoulsHud.Collect(v3, v1.Value)
                            v11:Release(Model)
                        end
                    end
                end
            end
        end
    end
end

function u50:StepAbsorbing() -- Line: 499 -- upvalues: Workspace (val), SoulsHud (val)
    local CurrentCamera, From, From_2, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = os.clock()
    local v10 = self
    for i = #self.Absorbing, 1, -1 do
        v4 = v10.Absorbing[i]
        v5 = math.clamp((v9 - v4.Born) / 0.25, 0, 1)
        v6 = v5 * v5
        From = v4.From
        From_2 = v4.From
        CurrentCamera = Workspace.CurrentCamera
        v2 = SoulsHud.IconViewportPoint()
        if CurrentCamera == nil then
            v1 = From_2
        elseif v2 ~= nil then
            v3 = CurrentCamera:ViewportPointToRay(v2.X, v2.Y)
            v1 = v3.Origin + v3.Direction * 4
        else
            v1 = From_2
        end
        v7 = From:Lerp(v1, v6 * 0.7)
        v8 = v4.Scale * (1 - v6 * 0.8)
        v4.Model:ScaleTo(v8)
        v4.Model:PivotTo((CFrame.new(v7)) * (CFrame.Angles(0, v4.Yaw + v5 * 14, 0)))
        if v5 >= 1 then
            SoulsHud.Collect(v7 + Vector3.new(0, v10.Height * v8 / 2, 0), v4.Value)
            v10:Release(v4.Model)
            table.remove(v10.Absorbing, i)
        end
    end
end

function u50.Step(a1, a2) -- Line: 519
    -- upvalues: RuptureSeconds (val), GhostBossFlags (val), sound (val), Audio (val), SoulsHud (val)
    local v1, v2
    if a1.Done then
        return
    end
    a1.Clock = a1.Clock + a2
    local v3 = os.clock()
    if a1.SpawnedAt == nil then
        local Queued = a1.Queued
        if v3 - a1.Born < RuptureSeconds then
            return
        end
        if Queued == nil and v3 - a1.Born < 0.3 then
            return
        end
        a1.SpawnedAt = v3
        if not Queued then
            v2 = math.min(GhostBossFlags.SoulOrbsMinimum:Get(), 150)
        else
            local Souls = Queued.Souls
            local v4 = math.max(GhostBossFlags.SoulsPerOrb:Get(), 1)
            local v5 = GhostBossFlags.SoulOrbsMinimum:Get()
            local v6 = math.max(v5, (GhostBossFlags.SoulOrbsMaximum:Get()))
            v2 = math.min(math.clamp(math.ceil(Souls / v4), v5, v6), 150, Souls)
        end
        a1:SpawnSpirits(v2)
        v1 = sound("Sounds", "LightVsDarknessSounds", "CollectRainbowRing")
        local From = a1.From
        if v1 then
            Audio.Play(v1, From, {Volume = 0.5, PlaybackSpeed = 0.8, MaxDistance = 160})
        end
        if Queued then
            a1:AddSouls(Queued)
        end
    end
    a1:StepSpirits(a2)
    a1:StepAbsorbing()
    local SpawnedAt = a1.SpawnedAt
    if a1.FadeAt == nil then
        local Model
        v1 = 0
        for i, j in a1.Spirits do
            if 0 < j.Value then
                v1 = v1 + 1
            end
        end
        local v7 = v3 - SpawnedAt
        v2 = false
        if v1 == 0 then
            v2 = a1.Queued == nil
        end
        if not v2 then
            if v7 >= 40 then
                a1.FadeAt = v3
                for k = #a1.Spirits, 1, -1 do
                    v1 = a1.Spirits[k]
                    if 0 < v1.Value then
                        table.remove(a1.Spirits, k)
                        Model = v1.Model
                        SoulsHud.Collect(if not Model then v1.Position else Model:GetPivot().Position, v1.Value)
                        a1:Release(Model)
                    end
                end
            end
        elseif v7 >= 6 then
            a1.FadeAt = v3
            for n = #a1.Spirits, 1, -1 do
                v1 = a1.Spirits[n]
                if 0 < v1.Value then
                    table.remove(a1.Spirits, n)
                    Model = v1.Model
                    SoulsHud.Collect(if not Model then v1.Position else Model:GetPivot().Position, v1.Value)
                    a1:Release(Model)
                end
            end
        elseif v7 >= 40 then
            a1.FadeAt = v3
            for m = #a1.Spirits, 1, -1 do
                v1 = a1.Spirits[m]
                if 0 < v1.Value then
                    table.remove(a1.Spirits, m)
                    Model = v1.Model
                    SoulsHud.Collect(if not Model then v1.Position else Model:GetPivot().Position, v1.Value)
                    a1:Release(Model)
                end
            end
        end
    end
    local FadeAt = a1.FadeAt
    if FadeAt and 0.8 <= v3 - FadeAt and #a1.Absorbing == 0 then
        a1.Done = true
    end
end

function u50:Destroy() -- Line: 578
    self.Trove:Destroy()
end

return u50