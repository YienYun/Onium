-- Script path: ReplicatedStorage.Shared.Eggs.EggMechaUpgradeAnimation
-- Decompile time: 16.36 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Shake = require(ReplicatedStorage.Client.Shake)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggEnergyOrbField = require(script.Parent.EggEnergyOrbField)
local EggRenderer = require(script.Parent.EggRenderer)
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local Log = require(ReplicatedStorage.Packages.Log)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local t = require(ReplicatedStorage.Packages.t)
local VisibleBounds = require(ReplicatedStorage.Shared.Utils.VisibleBounds)
local u82 = {"AssetAnimation", "Part"}
local u89 = Color3.fromRGB(80, 190, 220)
local u91 = Log.new()
local u96 = Workspace:FindFirstChild("Transient") or Workspace
local u99 = Random.new()
local v1 = {}

local function applyShake(a1, a2, a3, a4) -- Line: 76
    -- upvalues: EggActionMovement (val), u99 (val)
    EggActionMovement.SetPivot(
        a1,
        a2 * CFrame.new(u99:NextNumber(-1, 1) * 0.55 * a3, u99:NextNumber(-1, 1) * 0.55 * a3, u99:NextNumber(-1, 1) * 0.55 * a3) * CFrame.Angles(0, math.rad(a4), 0) * CFrame.Angles(math.rad((u99:NextNumber(-1, 1)) * 24 * a3), 0, (math.rad((u99:NextNumber(-1, 1)) * 24 * a3)))
    )
end

local function playNamedSound(a1, a2) -- Line: 99
    -- upvalues: ReplicatedStorage (val), u91 (val), Audio (val)
    local Sounds = ReplicatedStorage.Assets:FindFirstChild("Sounds")
    local v1 = Sounds and Sounds:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        Audio.Play(v1, a2)
        return
    end
    ;(u91:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Sounds.%*; sound skipped"):format(a1)))
end

local function findParticleAsset(a1) -- Line: 109 -- upvalues: ReplicatedStorage (val) -- types: a1: table
    local Particles = ReplicatedStorage.Assets:FindFirstChild("Particles")
    for i, j in a1 do
        if Particles == nil then
            return nil
        end
        Particles = Particles:FindFirstChild(j)
    end
    return Particles
end

local function setEmittersEnabled(a1, a2) -- Line: 120 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            j.Enabled = a2
        end
    end
end

local function createHostPart(a1, a2, a3) -- Line: 128
    -- upvalues: u96 (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Name = a1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.CFrame = a2
    Part.Parent = u96
    Debris:AddItem(Part, a3)
    return Part
end

local function attachToEgg(a1, a2) -- Line: 144 -- upvalues: VisibleBounds (val) -- types: a1: userdata, a2: userdata
    local PrimaryPart = a2.PrimaryPart
    if PrimaryPart == nil then
        return
    end
    a1.CFrame = PrimaryPart.CFrame:ToObjectSpace((CFrame.new((VisibleBounds(a2)).Position)))
    a1.Parent = PrimaryPart
end

local function createChargeParticles(a1) -- Line: 155
    -- upvalues: findParticleAsset (val), u82 (val), u91 (val), VisibleBounds (val), setEmittersEnabled (val)
    local v1 = findParticleAsset(u82)
    if v1 == nil then
        (u91:AtWarning()):Log((("Missing ReplicatedStorage.Assets.Particles.%*; charge VFX skipped"):format((table.concat(u82, ".")))))
        return nil
    end
    local Emit = v1:FindFirstChild("Emit")
    local Enable = v1:FindFirstChild("Enable")
    if Emit ~= nil and Emit:IsA("Attachment") then
        if Enable ~= nil and Enable:IsA("Attachment") then
            v1 = {Emit = Emit:Clone(), Enable = Enable:Clone()}
            local Emit_2 = v1.Emit
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart ~= nil then
                Emit_2.CFrame = PrimaryPart.CFrame:ToObjectSpace((CFrame.new((VisibleBounds(a1)).Position)))
                Emit_2.Parent = PrimaryPart
            end
            local Enable_2 = v1.Enable
            local PrimaryPart_2 = a1.PrimaryPart
            if PrimaryPart_2 ~= nil then
                Enable_2.CFrame = PrimaryPart_2.CFrame:ToObjectSpace((CFrame.new((VisibleBounds(a1)).Position)))
                Enable_2.Parent = PrimaryPart_2
            end
            setEmittersEnabled(v1.Enable, true)
            return v1
        end
        u91:AtWarning():Log("Charge VFX is missing its Enable attachment")
        return nil
    end
    u91:AtWarning():Log("Charge VFX is missing its Emit attachment")
    return nil
end

local function detachParticles(a1, a2) -- Line: 186 -- upvalues: u96 (val), Debris (val) -- types: a1: table, a2: vector
    local v1 = CFrame.new(a2)
    local v2 = Instance.new("Part")
    v2.Name = "MechaUpgradeParticleKeeper"
    v2.Anchored = true
    v2.CanCollide = false
    v2.CanQuery = false
    v2.CanTouch = false
    v2.CastShadow = false
    v2.Transparency = 1
    v2.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    v2.CFrame = v1
    v2.Parent = u96
    Debris:AddItem(v2, 8)
    a1.Emit.CFrame = CFrame.new()
    a1.Emit.Parent = v2
    a1.Enable.CFrame = CFrame.new()
    a1.Enable.Parent = v2
    return v2
end

local function releaseParticles(a1) -- Line: 196 -- upvalues: setEmittersEnabled (val), Debris (val) -- types: a1: table
    setEmittersEnabled(a1.Enable, false)
    Debris:AddItem(a1.Emit, 8)
    Debris:AddItem(a1.Enable, 8)
end

local function emitImpactVfx(a1) -- Line: 202
    -- upvalues: findParticleAsset (val), u91 (val), u96 (val), Debris (val), TryCall (val), PlayVFX (val)
    local v1 = findParticleAsset({"HitGroundAttach"})
    if v1 == nil then
        u91:AtWarning():Log("Missing ReplicatedStorage.Assets.Particles.HitGroundAttach; impact VFX skipped")
        return
    end
    local Part = Instance.new("Part")
    Part.Name = "MechaUpgradeImpactVFX"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.CFrame = a1
    Part.Parent = u96
    Debris:AddItem(Part, 10)
    local v2 = v1:Clone()
    if not TryCall(PlayVFX, Part, a1, v2) then
        v2:Destroy()
    end
end

local function playChargeLift(a1, a2, a3, a4, a5, a6) -- Line: 218
    -- upvalues: RunService (val), TweenService (val), applyShake (val)
    local Value_2, v1, v2, v3, v4
    local v5 = 0
    while v5 < 5 do
        v2 = RunService.Heartbeat:Wait()
        v5 = v5 + v2
        if a1.Parent == nil then
            return false
        end
        v3 = math.min(v5 / 5, 1)
        v4 = math.min(v3 / 0.62, 1)
        v1 = a2:Lerp(a3, (TweenService:GetValue(v4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)))
        Value_2 = TweenService:GetValue(v4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
        a6.Spin = a6.Spin + 216 * v2
        applyShake(a1, v1, Value_2, a6.Spin)
        a5:Step(v1.Position + a4, v3, v2)
    end
    return true
end

local function playShakeSettle(a1, a2, a3) -- Line: 256
    -- upvalues: RunService (val), TweenService (val), applyShake (val), EggActionMovement (val)
    local Value, v1
    local Spin = a3.Spin
    local v2 = math.ceil(Spin / 360) * 360
    local v3 = 0
    while v3 < 0.5 do
        v3 = v3 + RunService.Heartbeat:Wait()
        if a1.Parent == nil then
            return
        end
        v1 = math.min(v3 / 0.5, 1)
        Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        a3.Spin = Spin + (v2 - Spin) * Value
        applyShake(a1, a2, 1 - v1, a3.Spin)
    end
    EggActionMovement.SetPivot(a1, a2)
end

local function playDrop(a1, a2, a3, a4) -- Line: 277
    -- upvalues: RunService (val), TweenService (val), EggActionMovement (val)
    local Value, v1
    local v2 = 0
    local v3 = false
    local v4, v5, v6 = a1, a4, a3
    while v2 < 0.26 do
        v1 = RunService.Heartbeat:Wait()
        v2 = v2 + v1
        if v4.Parent == nil then
            return
        end
        if not v3 and 0.26 <= v2 + v1 * 1 then
            v3 = true
            v5()
        end
        Value = TweenService:GetValue(math.min(v2 / 0.26, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        EggActionMovement.SetPivot(v4, v7:Lerp(v6, Value))
    end
    EggActionMovement.SetPivot(v4, v6)
    if not v3 then
        v5()
    end
end

local function triggerImpact(a1, a2) -- Line: 306
    -- upvalues: emitImpactVfx (val), Shake (val), playNamedSound (val)
    emitImpactVfx(a1)
    if a2 then
        Shake.Play({Seconds = 0.45, Magnitude = 1.6})
    end
    playNamedSound("MechaHatch", a1)
end

local function playSettle(a1, a2) -- Line: 316
    -- upvalues: RunService (val), EggActionMovement (val), TweenService (val)
    local v1, v2
    local Scale = a1:GetScale()
    local v3 = 0
    while v3 < 0.22 do
        v3 = v3 + RunService.Heartbeat:Wait()
        if a1.Parent == nil then
            return
        end
        v1 = math.min(v3 / 0.22, 1)
        v2 = (1 - v1) * (1 - v1)
        EggActionMovement.SetPivot(a1, a2 * CFrame.new(0, math.abs((math.sin(6.283185307179586 * v1))) * 0.9 * v2, 0))
        a1:ScaleTo(Scale * (0.88 + 0.12 * (TweenService:GetValue(v1, Enum.EasingStyle.Back, Enum.EasingDirection.Out))))
    end
    if a1.Parent ~= nil then
        a1:ScaleTo(Scale)
        EggActionMovement.SetPivot(a1, a2)
    end
end

function v1.Play(a1, a2, a3) -- Line: 345
    -- upvalues: t (val), EggRenderer (val), VisibleBounds (val), Players (val), playNamedSound (val)
    -- upvalues: createChargeParticles (val), EggEnergyOrbField (val), u96 (val), u89 (val), playChargeLift (val)
    -- upvalues: applyShake (val), detachParticles (val), u91 (val), setEmittersEnabled (val), Debris (val)
    -- upvalues: EmitTree (val), playShakeSettle (val), playDrop (val), emitImpactVfx (val), Shake (val)
    -- upvalues: playSettle (val)
    t.strict(t.number)(a1)
    t.strict(t.instanceIsA("Model"))(a2)
    t.strict(t.callback)(a3)
    EggRenderer.DisableCollisions(a2)
    local Pivot = a2:GetPivot()
    local u38 = Pivot * CFrame.new(0, 7, 0)
    local v1, v2 = VisibleBounds(a2)
    local v3 = v1.Position - Pivot.Position
    local u53 = CFrame.new(v1.Position - Vector3.new(0, 1, 0) * (v2.Y * 0.5))
    local u58 = a1 == Players.LocalPlayer.UserId
    playNamedSound("MechaShake", Pivot)
    v1 = createChargeParticles(a2)
    local v4 = EggEnergyOrbField.new(u96, u89)
    local u74 = {Spin = 0}
    if not playChargeLift(a2, Pivot, u38, v3, v4, u74) then
        v4:Destroy()
    else
        v4:Absorb(u38.Position + v3, 0.6, function(a1) -- Line: 366 -- upvalues: a2 (val), u74 (val), applyShake (upval), u38 (val) -- types: a1: number
            if a2.Parent == nil then
                return
            end
            local v1 = u74
            v1.Spin = v1.Spin + a1 * 216
            applyShake(a2, u38, 1, u74.Spin)
        end)
    end
    v4 = if v1 == nil then nil else detachParticles(v1, u38.Position + v3)
    v3 = a3()
    if v3 == nil then
        u91:AtWarning():Log("Mecha upgrade swap did not produce a replacement egg model")
        if v1 ~= nil then
            setEmittersEnabled(v1.Enable, false)
            Debris:AddItem(v1.Emit, 8)
            Debris:AddItem(v1.Enable, 8)
        end
        return
    end
    EggRenderer.DisableCollisions(v3)
    applyShake(v3, u38, 1, u74.Spin)
    if v1 ~= nil and v4 ~= nil then
        local Emit_2 = v1.Emit
        local PrimaryPart = v3.PrimaryPart
        if PrimaryPart ~= nil then
            Emit_2.CFrame = PrimaryPart.CFrame:ToObjectSpace((CFrame.new((VisibleBounds(v3)).Position)))
            Emit_2.Parent = PrimaryPart
        end
        local Enable_2 = v1.Enable
        local PrimaryPart_2 = v3.PrimaryPart
        if PrimaryPart_2 ~= nil then
            Enable_2.CFrame = PrimaryPart_2.CFrame:ToObjectSpace((CFrame.new((VisibleBounds(v3)).Position)))
            Enable_2.Parent = PrimaryPart_2
        end
        v4:Destroy()
        EmitTree(v1.Emit)
    end
    playShakeSettle(v3, u38, u74)
    playDrop(v3, u38, Pivot, function() -- Line: 404 -- upvalues: u53 (val), u58 (val), emitImpactVfx (upval), Shake (upval), playNamedSound (upval)
        local v1 = u53
        local v2 = u58
        emitImpactVfx(v1)
        if v2 then
            Shake.Play({Seconds = 0.45, Magnitude = 1.6})
        end
        playNamedSound("MechaHatch", v1)
    end)
    playSettle(v3, Pivot)
    if v1 ~= nil then
        setEmittersEnabled(v1.Enable, false)
        Debris:AddItem(v1.Emit, 8)
        Debris:AddItem(v1.Enable, 8)
    end
end

return v1