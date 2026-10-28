-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.BossPortal
-- Decompile time: 20.46 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenManor = require(ReplicatedStorage.Data.HalloweenManor)
local Log = require(ReplicatedStorage.Packages.Log)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
local PumpkinBossFlags = require(ReplicatedStorage.Shared.Flags.PumpkinBossFlags)
local PumpkinBossSchedule = require(ReplicatedStorage.Shared.Util.PumpkinBossSchedule)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VoidFusionSounds = require(ReplicatedStorage.Shared.Util.VoidFusionSounds)
local u64 = Color3.fromRGB(120, 52, 14)
local u69 = Color3.fromRGB(255, 140, 40)
local u77 = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.2)
local u82 = TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u89 = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u94 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Sounds = ManorInterior.Sounds
local BossPortal = HalloweenManor.BossPortal
local u98 = Log.new()
local u99 = {}
local Assets = ReplicatedStorage:WaitForChild("Assets")
local v1 = {}

local function clock(a1) -- Line: 93 -- types: a1: number
    if a1 >= 3600 then
        return string.format("%d:%02d:%02d", a1 // 3600, a1 % 3600 // 60, a1 % 60)
    end
    return string.format("%02d:%02d", a1 // 60, a1 % 60)
end

local function isOpen(a1) -- Line: 105 -- upvalues: ManorInterior (val), PumpkinBossSchedule (val) -- types: a1: number
    return ManorInterior.GateOpen() and PumpkinBossSchedule.IsOpen(a1)
end

local function statusText(a1) -- Line: 109
    -- upvalues: ManorInterior (val), BossPortal (val), clock (val), PumpkinBossSchedule (val)
    local v1
    if not ManorInterior.GateOpen() then
        v1 = ManorInterior.GateOpensAt(a1)
        if v1 == nil then
            return BossPortal.GateLocked, nil
        end
        return (string.format(BossPortal.GateCountdown, clock((math.max(0, (math.ceil(v1 - a1))))))), nil
    end
    if not PumpkinBossSchedule.Enabled() then
        return BossPortal.ScheduleOff, nil
    end
    if not PumpkinBossSchedule.IsOpen(a1) then
        return (string.format(BossPortal.Countdown, clock((math.max(0, (math.ceil((PumpkinBossSchedule.SecondsUntilOpen(a1))))))))), nil
    end
    v1 = math.max(0, (math.ceil((PumpkinBossSchedule.ClosesAt(a1)) - a1)))
    return BossPortal.Open, string.format(BossPortal.Closes, clock(v1))
end

local function tinted(a1, a2) -- Line: 131 -- upvalues: u69 (val) -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in a1.Keypoints do
        table.insert(v1, (ColorSequenceKeypoint.new(j.Time, (j.Value:Lerp(u69, a2)))))
    end
    return ColorSequence.new(v1)
end

local function captureSwirl(a1) -- Line: 142 -- types: a1: userdata
    local Emitters, Lights, v1
    local v2 = {Lights = {}, Emitters = {}, Color = a1.Color}
    for i, j in a1:GetDescendants() do
        if j:IsA("Light") then
            Lights = v2.Lights
            v1 = {Brightness = j.Brightness, Color = j.Color}
            Lights[j] = v1
        elseif j:IsA("ParticleEmitter") then
            Emitters = v2.Emitters
            v1 = {Rate = j.Rate, TimeScale = j.TimeScale, Color = j.Color}
            Emitters[j] = v1
        end
    end
    return v2
end

local function restoreSwirl(a1, a2) -- Line: 159 -- types: a1: userdata, a2: table
    a1.Color = a2.Color
    for i, j in a2.Lights do
        i.Brightness = j.Brightness
        i.Color = j.Color
    end
    for k, n in a2.Emitters do
        k.Rate = n.Rate
        k.TimeScale = n.TimeScale
        k.Color = n.Color
    end
end

local function paintSwirl(a1, a2) -- Line: 172
    -- upvalues: u64 (val), u69 (val), tinted (val)
    local v1
    local Swirl = a1.Swirl
    local v2 = math.clamp(a2, 0, 1)
    a1.Disc.Color = Swirl.Color:Lerp(u64, v2)
    for i, j in Swirl.Lights do
        v1 = j.Brightness * (v2 * -0.7 + 1)
        i.Brightness = v1 * (1 + a1.Flash.Value)
        i.Color = j.Color:Lerp(u69, v2)
    end
    for k, n in Swirl.Emitters do
        k.Rate = n.Rate * (v2 * -0.85 + 1)
        k.TimeScale = n.TimeScale * (v2 * -0.65 + 1)
        k.Color = tinted(n.Color, v2 * 0.8)
    end
end

local function paintSeal(a1) -- Line: 189 -- upvalues: paintSwirl (val) -- types: a1: table
    local v1
    local Value = a1.Alpha.Value
    local v2 = 1 - Value
    local v3 = math.clamp(Value, 0, 1)
    for i, j in a1.Pieces do
        v1 = (CFrame.new(j.Drop * v2)) * CFrame.Angles(j.Tilt * v2, 0, 0)
        j.Part.CFrame = a1.Disc.CFrame * v1 * j.Rest
        j.Part.Transparency = 1 - (1 - j.Transparency) * v3
    end
    local Barrier = a1.Barrier
    if Barrier ~= nil then
        Barrier.Transparency = 1 - (1 - math.min(a1.BarrierTransparency + 0.3 * a1.Pulse.Value, 1)) * v3
    end
    local Glow = a1.Glow
    if Glow ~= nil then
        Glow.Brightness = a1.GlowBrightness * (1 - 0.5 * a1.Pulse.Value) * v3 + 9 * a1.Flash.Value
    end
    paintSwirl(a1, Value)
end

local function burst(a1) -- Line: 212 -- types: a1: table
    for i in a1.Swirl.Emitters do
        i:Emit(24)
    end
end

local function feedback(a1, a2) -- Line: 218
    -- upvalues: TweenService (val), u94 (val), Audio (val), Sounds (val), u82 (val), Shake (val), u77 (val)
    -- upvalues: VoidFusionSounds (val)
    local Position = a1.Disc.Position
    local u10 = TweenService:Create(a1.Flash, u94, {Value = 0})
    a1.Motion:Add(function() -- Line: 221 -- upvalues: u10 (val)
        u10:Cancel()
    end)
    if a2 then
        Audio.Play(Sounds.ChainRattle, Position, {Volume = 0.9, MaxDistance = 260})
        a1.Motion:Add((task.delay(u82.Time * 0.6, function() -- Line: 226 -- upvalues: Audio (upval), Sounds (upval), Position (val), a1 (val), u10 (val), Shake (upval)
            Audio.Play(Sounds.PadlockClunk, Position, {Volume = 1.1, MaxDistance = 260})
            a1.Flash.Value = 0.6
            u10:Play()
            Shake.Play({Seconds = 0.4, Magnitude = 0.4, Range = {Near = 40, Far = 110, Center = Position}})
        end)))
        return
    end
    Audio.Play(Sounds.PadlockClunk, Position, {Volume = 1.2, MaxDistance = 260})
    a1.Motion:Add((task.delay(u77.DelayTime, function() -- Line: 239 -- upvalues: Audio (upval), Sounds (upval), Position (val)
        Audio.Play(Sounds.ChainRattle, Position, {Volume = 1, MaxDistance = 260})
    end)))
    a1.Motion:Add((task.delay(u77.DelayTime + u77.Time * 0.7, function() -- Line: 242
        -- upvalues: VoidFusionSounds (upval), Audio (upval), Position (val), a1 (val), u10 (val), Shake (upval)
        local RiftOpen = VoidFusionSounds.RiftOpen
        Audio.Play(RiftOpen.Id, Position, {MaxDistance = 260, Volume = RiftOpen.Volume})
        a1.Flash.Value = 1
        u10:Play()
        for i in a1.Swirl.Emitters do
            i:Emit(24)
        end
        Shake.Play({
            Seconds = 0.9,
            Magnitude = 0.6,
            Shape = "Pulse",
            Range = {Near = 40, Far = 110, Center = Position},
        })
    end)))
end

local function setSealed(a1, a2, a3) -- Line: 257
    -- upvalues: paintSeal (val), TweenService (val), u82 (val), u77 (val), feedback (val)
    if a1.Sealed == a2 then
        return
    end
    a1.Sealed = a2
    a1.Motion:Clean()
    a1.Flash.Value = 0
    local v1 = if not a2 then 0 else 1
    if not a3 then
        a1.Alpha.Value = v1
        paintSeal(a1)
        return
    end
    local u31 = TweenService:Create(a1.Alpha, if not a2 then u77 else u82, {Value = v1})
    a1.Motion:Add(function() -- Line: 275 -- upvalues: u31 (val)
        u31:Cancel()
    end)
    u31:Play()
    feedback(a1, a2)
end

local function piecesOf(a1) -- Line: 282 -- types: a1: userdata
    local v1, v2, v3
    local v4 = {}
    local v5 = nil
    local Transparency = 0
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            if j.Name ~= "Barrier" then
                v1 = a1.WorldPivot:ToObjectSpace(j.CFrame)
                v2 = j.Parent ~= a1
                v3 = if not (v1.Position.Z < 0) then 1 else -1
                table.insert(v4, {
                    Part = j,
                    Rest = v1,
                    Transparency = j.Transparency,
                    Drop = if not v2 then Vector3.new(0, -9, 0) else Vector3.new(0, -6, 7) * Vector3.new(1, 1, v3),
                    Tilt = if not v2 then 0 else v3 * -0.9599310885968813,
                })
            else
                v5 = j
                Transparency = j.Transparency
            end
        end
    end
    return v4, v5, Transparency
end

local function forget(a1) -- Line: 314 -- upvalues: u99 (val), restoreSwirl (val) -- types: a1: userdata
    local v1 = u99[a1]
    if v1 == nil then
        return
    end
    u99[a1] = nil
    v1.Motion:Destroy()
    v1.Trove:Destroy()
    if v1.Disc.Parent ~= nil then
        restoreSwirl(v1.Disc, v1.Swirl)
    end
end

local function track(a1) -- Line: 327
    -- upvalues: Workspace (val), u99 (val), Assets (val), u98 (val), Trove (val), piecesOf (val), BossPortal (val)
    -- upvalues: captureSwirl (val), paintSeal (val), TweenService (val), u89 (val), restoreSwirl (val)
    -- upvalues: ManorInterior (val), PumpkinBossSchedule (val)
    if a1:IsA("Model") then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) then
            if u99[a1] ~= nil then
                return
            end
            local v2 = a1:FindFirstChild("Cylinder.001")
            local HalloweenDimension = Assets:FindFirstChild("HalloweenDimension") and Assets.HalloweenDimension:FindFirstChild("BossPortalSeal")
            local Billboards = Assets:FindFirstChild("Billboards") and Assets.Billboards:FindFirstChild("BossPortalBillboard")
            if v2 ~= nil and v2:IsA("BasePart") then
                if HalloweenDimension ~= nil and HalloweenDimension:IsA("Model") then
                    if Billboards ~= nil and Billboards:IsA("BillboardGui") then
                        local v3 = Trove.new()
                        local v4 = v3:Clone(HalloweenDimension)
                        local v5, v6, v7 = piecesOf(v4)
                        local v8 = if v6 == nil then nil else v6:FindFirstChildWhichIsA("PointLight")
                        local v9 = v3:Clone(Billboards)
                        v1 = v9:FindFirstChild("Title")
                        local Status = v9:FindFirstChild("Status")
                        local Sub = v9:FindFirstChild("Sub")
                        if Status and Status:IsA("TextLabel") and Sub and Sub:IsA("TextLabel") then
                            if v1 ~= nil and v1:IsA("TextLabel") then
                                v1.Text = BossPortal.Title
                            end
                            local u105 = {Trove = v3}
                            u105.Motion = Trove.new()
                            u105.Disc = v2
                            u105.Swirl = captureSwirl(v2)
                            u105.Pieces = v5
                            u105.Barrier = v6
                            u105.BarrierTransparency = v7
                            u105.Glow = v8
                            u105.GlowBrightness = if v8 == nil then 0 else v8.Brightness
                            u105.Board = v9
                            u105.Status = Status
                            u105.Sub = Sub
                            u105.Alpha = v3:Add((Instance.new("NumberValue")))
                            u105.Pulse = v3:Add((Instance.new("NumberValue")))
                            u105.Flash = v3:Add((Instance.new("NumberValue")))
                            u99[a1] = u105
                            v3:Connect(u105.Alpha.Changed, function() -- Line: 387 -- upvalues: paintSeal (upval), u105 (val)
                                paintSeal(u105)
                            end)
                            v3:Connect(u105.Pulse.Changed, function() -- Line: 390 -- upvalues: u105 (val), paintSeal (upval)
                                if 0 < u105.Alpha.Value then
                                    paintSeal(u105)
                                end
                            end)
                            v3:Connect(u105.Flash.Changed, function() -- Line: 395 -- upvalues: paintSeal (upval), u105 (val)
                                paintSeal(u105)
                            end)
                            local u182 = TweenService:Create(u105.Pulse, u89, {Value = 1})
                            v3:Add(function() -- Line: 399 -- upvalues: u182 (val)
                                u182:Cancel()
                            end)
                            v3:Connect(a1.AncestryChanged, function() -- Line: 402 -- upvalues: a1 (val), Workspace (upval), u99 (upval), restoreSwirl (upval)
                                local v1 = a1
                                if not v1:IsDescendantOf(Workspace) then
                                    v1 = a1
                                    local v2 = u99[v1]
                                    if v2 == nil then
                                        return
                                    end
                                    u99[v1] = nil
                                    v2.Motion:Destroy()
                                    v2.Trove:Destroy()
                                    if v2.Disc.Parent ~= nil then
                                        restoreSwirl(v2.Disc, v2.Swirl)
                                    end
                                end
                            end)
                            v4.Parent = a1
                            v9.Adornee = v2
                            v9.Parent = v2
                            local ServerTimeNow = Workspace:GetServerTimeNow()
                            local v10 = not (ManorInterior.GateOpen() and PumpkinBossSchedule.IsOpen(ServerTimeNow))
                            if u105.Sealed ~= v10 then
                                u105.Sealed = v10
                                u105.Motion:Clean()
                                u105.Flash.Value = 0
                                local v11 = if not v10 then 0 else 1
                                u105.Alpha.Value = v11
                                paintSeal(u105)
                            end
                            u182:Play()
                            return
                        end
                        u98:AtWarning():Log("BossPortalBillboard is missing Status/Sub; skipping")
                        v3:Destroy()
                        return
                    end
                    u98:AtWarning():Log("Assets.Billboards.BossPortalBillboard is missing")
                    return
                end
                u98:AtWarning():Log("Assets.HalloweenDimension.BossPortalSeal is missing")
                return
            end
            ;(u98:AtWarning()):Log((("%* has no Cylinder.001; skipping its seal"):format((a1:GetFullName()))))
            return
        end
    end
end

local function refresh(a1) -- Line: 414
    -- upvalues: PumpkinBossFlags (val), u99 (val), restoreSwirl (val), CollectionService (val), track (val)
    -- upvalues: Workspace (val), ManorInterior (val), PumpkinBossSchedule (val), statusText (val), setSealed (val)
    local v1, v2
    if not PumpkinBossFlags.ContentEnabled:Get() then
        for m in u99 do
            v2 = u99[m]
            if v2 ~= nil then
                u99[m] = nil
                v2.Motion:Destroy()
                v2.Trove:Destroy()
                if v2.Disc.Parent ~= nil then
                    restoreSwirl(v2.Disc, v2.Swirl)
                end
            end
        end
        return
    end
    for i, j in CollectionService:GetTagged(a1) do
        track(j)
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v3 = ManorInterior.GateOpen() and PumpkinBossSchedule.IsOpen(ServerTimeNow)
    local v4 = not v3
    v3, v1 = statusText(ServerTimeNow)
    v2 = nil
    local v5 = nil
    for k, n in u99, v2, v5 do
        setSealed(n, v4, true)
        if n.Status.Text ~= v3 then
            n.Status.Text = v3
        end
        n.Sub.Visible = v1 ~= nil
        if v1 ~= nil and n.Sub.Text ~= v1 then
            n.Sub.Text = v1
        end
    end
end

function v1.Start(a1) -- Line: 443
    -- upvalues: HalloweenManor (val), BossPortal (val), u98 (val), CollectionService (val), refresh (val), u99 (val)
    -- upvalues: restoreSwirl (val)
    local Portal = HalloweenManor.Tags.Portal
    if Portal ~= nil and BossPortal ~= nil then
        a1:Connect(CollectionService:GetInstanceAddedSignal(Portal), function() -- Line: 450 -- upvalues: refresh (upval), Portal (val)
            refresh(Portal)
        end)
        a1:Connect(CollectionService:GetInstanceRemovedSignal(Portal), function(a1) -- Line: 453 -- upvalues: u99 (upval), restoreSwirl (upval) -- types: a1: userdata
            if a1:IsA("Model") then
                local v1 = u99[a1]
                if v1 == nil then
                    return
                end
                u99[a1] = nil
                v1.Motion:Destroy()
                v1.Trove:Destroy()
                if v1.Disc.Parent ~= nil then
                    restoreSwirl(v1.Disc, v1.Swirl)
                end
            end
        end)
        a1:Add(function() -- Line: 458 -- upvalues: u99 (upval), restoreSwirl (upval)
            local v1
            for i in u99 do
                v1 = u99[i]
                if v1 ~= nil then
                    u99[i] = nil
                    v1.Motion:Destroy()
                    v1.Trove:Destroy()
                    if v1.Disc.Parent ~= nil then
                        restoreSwirl(v1.Disc, v1.Swirl)
                    end
                end
            end
        end)
        a1:Add((task.spawn(function() -- Line: 463 -- upvalues: refresh (upval), Portal (val)
            while true do
                refresh(Portal)
                task.wait(1)
            end
        end)))
        return
    end
    u98:AtWarning():Log("HalloweenManor.Tags.Portal or .BossPortal is missing; no portal seal")
end

return table.freeze(v1)