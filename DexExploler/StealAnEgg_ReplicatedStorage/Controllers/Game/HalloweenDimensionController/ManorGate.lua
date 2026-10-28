-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.ManorGate
-- Decompile time: 16.72 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimensionFlags = require(ReplicatedStorage.Shared.Flags.HalloweenDimensionFlags)
local HalloweenManor = require(ReplicatedStorage.Data.HalloweenManor)
local Log = require(ReplicatedStorage.Packages.Log)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u60 = {DoorLeft = 1.5707963267948966, DoorRight = -1.5707963267948966}
local u68 = TweenInfo.new(1.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.15)
local u73 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local Sounds = ManorInterior.Sounds
local u79 = Color3.fromRGB(122, 108, 96)
local u81 = Log.new()
local u82 = {}
local u83 = {}
local u84 = false
local u85 = false
local u86 = nil
local v1 = {}

local function isOpen() -- Line: 61 -- upvalues: PumpkinBossFlags (val), ManorInterior (val)
    return PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
end

local function base(a1) -- Line: 65 -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    return BoundingBox.Position - Vector3.new(0, BoundingBox_2.Y / 2 - 1, 0)
end

local function dust(a1) -- Line: 70 -- upvalues: u79 (val), Workspace (val) -- types: a1: userdata
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local Part = Instance.new("Part")
    Part.Name = "ManorGateDust"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(BoundingBox_2.X, 1, BoundingBox_2.Z)
    local new = CFrame.new
    local BoundingBox_3, BoundingBox_4 = a1:GetBoundingBox()
    Part.CFrame = (new(BoundingBox_3.Position - Vector3.new(0, BoundingBox_4.Y / 2 - 1, 0))) * BoundingBox.Rotation
    local v1 = Instance.new("ParticleEmitter")
    v1.Texture = "rbxasset://textures/particles/smoke_main.dds"
    v1.Color = ColorSequence.new(u79)
    v1.LightEmission = 0
    v1.LightInfluence = 1
    v1.Lifetime = NumberRange.new(1.44, 2.4)
    v1.Speed = NumberRange.new(6, 16)
    v1.SpreadAngle = Vector2.new(80, 20)
    v1.Acceleration = Vector3.new(0, 2, 0)
    v1.Drag = 2.5
    v1.Rotation = NumberRange.new(0, 360)
    v1.RotSpeed = NumberRange.new(-40, 40)
    v1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 11))})
    v1.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 0.55),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    v1.EmissionDirection = Enum.NormalId.Top
    v1.Enabled = false
    v1.Parent = Part
    Part.Parent = Workspace
    v1:Emit(60)
    task.delay(2.9, function() -- Line: 107 -- upvalues: Part (val)
        Part:Destroy()
    end)
end

local function feedback(a1, a2) -- Line: 112
    -- upvalues: Audio (val), Sounds (val), dust (val), Shake (val), u73 (val)
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local v1 = BoundingBox.Position - Vector3.new(0, BoundingBox_2.Y / 2 - 1, 0)
    Audio.Play(Sounds.GateClank, v1, {Volume = 1.1, MaxDistance = 260})
    if not a2 then
        task.delay(u73.Time, function() -- Line: 129 -- upvalues: a1 (val), Audio (upval), Sounds (upval), Shake (upval)
            if a1.Parent ~= nil then
                local Play = Audio.Play
                local GateClank = Sounds.GateClank
                local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
                Play(GateClank, BoundingBox.Position - Vector3.new(0, BoundingBox_2.Y / 2 - 1, 0), {Volume = 1.2, MaxDistance = 260})
                local Play_2 = Shake.Play
                local v1 = {Seconds = 0.5, Magnitude = 0.5}
                local v2 = {Near = 45, Far = 120}
                local BoundingBox_3, BoundingBox_4 = a1:GetBoundingBox()
                v2.Center = BoundingBox_3.Position - Vector3.new(0, BoundingBox_4.Y / 2 - 1, 0)
                v1.Range = v2
                Play_2(v1)
            end
        end)
        return
    end
    Audio.Play(Sounds.Creak, v1, {Volume = 0.9, PlaybackSpeed = 0.7, MaxDistance = 260})
    dust(a1)
    Shake.Play({Seconds = 1.4, Magnitude = 0.7, Shape = "Pulse", Range = {Near = 45, Far = 120, Center = v1}})
end

local function track(a1) -- Line: 146 -- upvalues: u82 (val), Trove (val), u60 (val), u81 (val) -- types: a1: userdata
    local v1 = u82[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = Trove.new()
    local v2 = v1:Add((Instance.new("NumberValue")))
    local v3 = {Open = false, Trove = v1, Alpha = v2, Center = (a1:GetBoundingBox()).Position}
    u82[a1] = v3
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in u60, v4, v5 do
        local u34 = v6:FindFirstChild(i)
        if u34 == nil then
            (u81:AtWarning()):Log((("%* is missing %*; skipping its swing"):format(v6:GetFullName(), i)))
        elseif u34:IsA("Model") then
            local Pivot = u34:GetPivot()
            v1:Connect(v2.Changed, function(a1) -- Line: 163 -- upvalues: u34 (val), Pivot (val), j (val) -- types: a1: number
                u34:PivotTo((CFrame.new(Pivot.Position)) * CFrame.Angles(0, j * a1, 0) * Pivot.Rotation)
            end)
            v1:Add(function() -- Line: 168 -- upvalues: u34 (val), Pivot (val)
                if u34.Parent ~= nil then
                    u34:PivotTo(Pivot)
                end
            end)
        else
            (u81:AtWarning()):Log((("%* is missing %*; skipping its swing"):format(v6:GetFullName(), i)))
        end
    end
    return v3
end

local function setOpen(a1, a2, a3) -- Line: 177
    -- upvalues: track (val), TweenService (val), u68 (val), u73 (val), feedback (val)
    local v1 = track(a1)
    if v1.Open == a2 then
        return
    end
    v1.Open = a2
    local Tween = v1.Tween
    if Tween ~= nil then
        Tween:Cancel()
        v1.Tween = nil
    end
    local v2 = if not a2 then 0 else 1
    if not a3 then
        v1.Alpha.Value = v2
        return
    end
    local v3 = TweenService:Create(v1.Alpha, if not a2 then u73 else u68, {Value = v2})
    v1.Tween = v3
    v3:Play()
    feedback(a1, a2)
end

local function forget(a1) -- Line: 200 -- upvalues: u82 (val) -- types: a1: userdata
    local v1 = u82[a1]
    if v1 ~= nil then
        u82[a1] = nil
        if v1.Tween ~= nil then
            v1.Tween:Cancel()
        end
        v1.Trove:Destroy()
    end
end

local function shown(a1) -- Line: 212 -- upvalues: u82 (val) -- types: a1: userdata
    local v1 = u82[a1]
    local Open = false
    if v1 ~= nil then
        Open = v1.Open
    end
    return Open
end

local function applyBlocker(a1, a2) -- Line: 217 -- upvalues: u82 (val) -- types: a1: userdata, a2: userdata
    if a2.Name == "Blocker" and a2:IsA("BasePart") then
        local v1 = u82[a1]
        local Open = false
        if v1 ~= nil then
            Open = v1.Open
        end
        a2.CanCollide = not Open
    end
end

local function watchBlocker(a1) -- Line: 223 -- upvalues: u83 (val), Trove (val), u82 (val) -- types: a1: userdata
    if u83[a1] ~= nil then
        return
    end
    local u5 = Trove.new()
    u83[a1] = u5

    local function watch(a1_2) -- Line: 229 -- upvalues: a1 (val), u82 (upval), u5 (val) -- types: a1_2: userdata
        if a1_2.Name == "Blocker" and a1_2:IsA("BasePart") then
            local v1 = a1
            if a1_2.Name == "Blocker" and a1_2:IsA("BasePart") then
                local v2 = u82[v1]
                local Open = false
                if v2 ~= nil then
                    Open = v2.Open
                end
                a1_2.CanCollide = not Open
            end
            u5:Connect(a1_2:GetPropertyChangedSignal("CanCollide"), function() -- Line: 234 -- upvalues: a1 (upval), a1_2 (val), u82 (upval)
                local v1 = a1_2
                if v1.Name == "Blocker" and v1:IsA("BasePart") then
                    local v2 = u82[a1]
                    local Open = false
                    if v2 ~= nil then
                        Open = v2.Open
                    end
                    v1.CanCollide = not Open
                end
            end)
            return
        end
    end

    u5:Connect(a1.ChildAdded, watch)
    for i, j in a1:GetChildren() do
        watch(j)
    end
end

local function unwatch(a1) -- Line: 244 -- upvalues: u82 (val), u83 (val) -- types: a1: userdata
    local v1 = u82[a1]
    if v1 ~= nil then
        u82[a1] = nil
        if v1.Tween ~= nil then
            v1.Tween:Cancel()
        end
        v1.Trove:Destroy()
    end
    v1 = u83[a1]
    if v1 ~= nil then
        u83[a1] = nil
        v1:Destroy()
    end
end

local function sync(a1) -- Line: 254
    -- upvalues: HalloweenManor (val), PumpkinBossFlags (val), ManorInterior (val), u85 (ref), CollectionService (val)
    -- upvalues: Workspace (val), watchBlocker (val), setOpen (val), u82 (val)
    local Blocker, Open, v1
    local Gate = HalloweenManor.Tags.Gate
    if Gate == nil then
        return
    end
    local v2 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
    if not v2 then
        u85 = false
    end
    v2 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen() and u85
    for i, j in CollectionService:GetTagged(Gate) do
        if j:IsA("Model") and j:IsDescendantOf(Workspace) then
            watchBlocker(j)
            setOpen(j, v2, a1)
            Blocker = j:FindFirstChild("Blocker")
            if Blocker ~= nil and Blocker.Name == "Blocker" and Blocker:IsA("BasePart") then
                v1 = u82[j]
                Open = false
                if v1 ~= nil then
                    Open = v1.Open
                end
                Blocker.CanCollide = not Open
            end
        end
    end
end

local function near() -- Line: 277 -- upvalues: Players (val), u82 (val)
    local Character = Players.LocalPlayer.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local v1
        for i, j in u82 do
            if i.Parent ~= nil then
                v1 = HumanoidRootPart.Position - j.Center
                if Vector2.new(v1.X, v1.Z).Magnitude <= 140 then
                    return true
                end
            end
        end
        return false
    end
    return false
end

local function reveal() -- Line: 296
    -- upvalues: u85 (ref), PumpkinBossFlags (val), ManorInterior (val), near (val), sync (val)
    if not u85 then
        local v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
        if v1 and near() then
            u85 = true
            sync(true)
            return
        end
    end
end

local function watchApproach() -- Line: 304
    -- upvalues: u86 (ref), u85 (ref), PumpkinBossFlags (val), ManorInterior (val), near (val), sync (val)
    if u86 == nil and not u85 then
        local v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
        if v1 then
            task.spawn(function() -- Line: 308
                -- upvalues: u85 (upval), PumpkinBossFlags (upval), ManorInterior (upval), near (upval), sync (upval)
                -- upvalues: u86 (upval)
                local v1
                while not u85 do
                    v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                    if not v1 then
                        break
                    end
                    if not u85 then
                        v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                        if v1 and near() then
                            u85 = true
                            sync(true)
                        end
                    end
                    task.wait(0.2)
                end
                u86 = nil
            end)
            return
        end
    end
end

function v1.Start(a1) -- Line: 321
    -- upvalues: PumpkinBossFlags (val), HalloweenManor (val), u81 (val), u84 (ref), HalloweenDimensionFlags (val)
    -- upvalues: CollectionService (val), sync (val), u86 (ref), u85 (ref), ManorInterior (val), near (val)
    -- upvalues: unwatch (val), u82 (val), u83 (val)
    if not PumpkinBossFlags.ContentEnabled:Get() then
        return
    end
    local Gate = HalloweenManor.Tags.Gate
    if Gate == nil then
        u81:AtWarning():Log("HalloweenManor.Tags.Gate is missing; the manor gate won't swing open")
        return
    end
    u84 = HalloweenDimensionFlags.ManorGateOpen:IsSynced()
    a1:Connect(CollectionService:GetInstanceAddedSignal(Gate), function() -- Line: 332
        -- upvalues: sync (upval), u86 (upval), u85 (upval), PumpkinBossFlags (upval), ManorInterior (upval)
        -- upvalues: near (upval)
        sync(false)
        if u86 == nil and not u85 then
            local v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
            if not v1 then
                return
            end
            task.spawn(function() -- Line: 308
                -- upvalues: u85 (upval), PumpkinBossFlags (upval), ManorInterior (upval), near (upval), sync (upval)
                -- upvalues: u86 (upval)
                local v1
                while not u85 do
                    v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                    if not v1 then
                        break
                    end
                    if not u85 then
                        v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                        if v1 and near() then
                            u85 = true
                            sync(true)
                        end
                    end
                    task.wait(0.2)
                end
                u86 = nil
            end)
        end
    end)
    a1:Connect(CollectionService:GetInstanceRemovedSignal(Gate), unwatch)
    a1:Connect(HalloweenDimensionFlags.ManorGateOpen.Changed, function() -- Line: 337
        -- upvalues: u84 (upval), sync (upval), u86 (upval), u85 (upval), PumpkinBossFlags (upval)
        -- upvalues: ManorInterior (upval), near (upval)
        local v1 = u84
        u84 = true
        sync(v1)
        if u86 == nil and not u85 then
            local v2 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
            if not v2 then
                return
            end
            task.spawn(function() -- Line: 308
                -- upvalues: u85 (upval), PumpkinBossFlags (upval), ManorInterior (upval), near (upval), sync (upval)
                -- upvalues: u86 (upval)
                local v1
                while not u85 do
                    v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                    if not v1 then
                        break
                    end
                    if not u85 then
                        v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                        if v1 and near() then
                            u85 = true
                            sync(true)
                        end
                    end
                    task.wait(0.2)
                end
                u86 = nil
            end)
        end
    end)
    a1:Add(function() -- Line: 343 -- upvalues: u86 (upval), u82 (upval), u83 (upval)
        local v1
        local v2 = u86
        if v2 ~= nil then
            u86 = nil
            task.cancel(v2)
        end
        local v3 = nil
        local v4 = nil
        for i in u82, v3, v4 do
            v2 = u82[i]
            if v2 ~= nil then
                u82[i] = nil
                if v2.Tween ~= nil then
                    v2.Tween:Cancel()
                end
                v2.Trove:Destroy()
            end
        end
        v3 = nil
        v4 = nil
        for j in u83, v3, v4 do
            v1 = u82[j]
            if v1 ~= nil then
                u82[j] = nil
                if v1.Tween ~= nil then
                    v1.Tween:Cancel()
                end
                v1.Trove:Destroy()
            end
            v1 = u83[j]
            if v1 ~= nil then
                u83[j] = nil
                v1:Destroy()
            end
        end
    end)
    sync(false)
    if u86 == nil and not u85 then
        local v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
        if not v1 then
            return
        end
        task.spawn(function() -- Line: 308
            -- upvalues: u85 (upval), PumpkinBossFlags (upval), ManorInterior (upval), near (upval), sync (upval)
            -- upvalues: u86 (upval)
            local v1
            while not u85 do
                v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                if not v1 then
                    break
                end
                if not u85 then
                    v1 = PumpkinBossFlags.ContentEnabled:Get() and ManorInterior.GateOpen()
                    if v1 and near() then
                        u85 = true
                        sync(true)
                    end
                end
                task.wait(0.2)
            end
            u86 = nil
        end)
    end
end

return (table.freeze(v1))