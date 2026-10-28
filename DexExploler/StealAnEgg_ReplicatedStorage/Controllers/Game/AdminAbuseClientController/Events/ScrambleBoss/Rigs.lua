-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Rigs
-- Decompile time: 37.04 ms

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ScrambleBossHazards = require(ReplicatedStorage.Shared.Util.ScrambleBossHazards)
local Kit = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local rad = math.rad
local u45 = Color3.fromRGB(30, 40, 30)
local u49 = NumberRange.new(0.35, 0.75)
local u54 = Color3.fromRGB(120, 220, 255)
local u59 = Color3.fromRGB(235, 250, 255)
local u63 = NumberRange.new(0.35, 0.8)
local u68 = Color3.fromRGB(80, 255, 60)
local u73 = Color3.fromRGB(255, 45, 45)
local u74 = {
    Idle = 120484795823977,
    Walk = 107270328959157,
    Spawn = 105745907093338,
    Summon = 95582559814590,
    SpikesAttack = 79479910863027,
    SpikesStrike = 79479910863027,
    SpikeSlam = 115149678962464,
    GrabThrow = 112978654814407,
    SlamDown = 140381763957066,
    Leap = 136703401677693,
    Overheat = 116934559155212,
    Eject = 108503440344107,
    Death = 73457528876079,
}
local u75 = {
    Idle = {},
    Recover = {Fade = 0.8},
    Walk = {Clip = "Walk", Loop = true, Walk = true},
    Rush = {Clip = "Walk", Loop = true, Walk = true, Speed = 1.8},
    SpawnDrop = {Clip = "Spawn", Speed = 2.3, HoldAt = 2.9},
    SpawnLand = {Clip = "Spawn", From = 2.9, Speed = 1.3, Hold = true},
    Drop = {Clip = "Leap", From = 0.7, Speed = 2, HoldAt = 2.85},
    Land = {Clip = "Leap", From = 2.85},
    SlamCharge = {Clip = "SlamDown", Speed = 0.6666666666666666, HoldAt = 1.43},
    Slam = {Clip = "SlamDown", From = 1.43},
    Pound = {Clip = "SpikeSlam"},
    Swipe = {Clip = "SpikesAttack", Speed = 0.5, HoldAt = 0.45},
    SwipeStrike = {Clip = "SpikesStrike", From = 0.73, Speed = 0.7, HoldAt = 1.6},
    Barrage = {Clip = "SpikesAttack", Loop = true},
    Grab = {Clip = "GrabThrow", Speed = 0.68, HoldAt = 1},
    Hold = {Clip = "GrabThrow", From = 1, Speed = 0.4, HoldAt = 1.75},
    Throw = {Clip = "GrabThrow", From = 1.75, Speed = 1.6},
    Summon = {Clip = "Summon", Hold = true},
    Laser = {Clip = "GrabThrow", Speed = 0.68, HoldAt = 1},
    Call = {Clip = "Summon", Hold = true},
    Laugh = {Clip = "Summon", Hold = true},
    Roar = {Clip = "Spawn", Speed = 2.2},
    Overheat = {Clip = "Overheat", Hold = true},
    Eject = {Clip = "Eject", Hold = true},
    Fall = {Clip = "Death", Hold = true},
    Dead = {Clip = "Death", From = (1 / 0), Hold = true},
}

local function a(a1, a2, a3) -- Line: 110 -- upvalues: rad (val) -- types: a1: number, a2: number?, a3: number?
    return CFrame.Angles(rad(a1), rad(a2 or 0), (rad(a3 or 0)))
end

local function clipAnimation(a1) -- Line: 114 -- types: a1: number
    local Animation = Instance.new("Animation")
    Animation.AnimationId = "rbxassetid://" .. a1
    return Animation
end

local function holdPoint(a1, a2) -- Line: 161 -- types: a1: table, a2: userdata
    if a1.HoldAt then
        return (math.min(a1.HoldAt, a2.Length - 0.04))
    end
    if a1.Hold then
        return (math.max(a2.Length - 0.04, 0))
    end
    return nil
end

local v1 = {
    Mech = function(a1, a2) -- Line: 173
        -- upvalues: Kit (val), u74 (val), u75 (val), u73 (val), Workspace (val), RunService (val), rad (val)
        -- upvalues: ScrambleBossHazards (val), u45 (val)
        local Attribute, v1, v2, v3, v4, v5
        local v6 = os.clock() + 5
        while a2:GetAttribute("AnimAt") == nil do
            if not (os.clock() < v6) then
                break
            end
            task.wait()
        end
        if a2.Parent == nil then
            return nil
        end
        local PrimaryPart = a2.PrimaryPart
        if not PrimaryPart then
            PrimaryPart = a2:WaitForChild("RootPart")
        end
        local v7 = {}
        for i, j in PrimaryPart:GetDescendants() do
            if j:IsA("Bone") then
                v7[j.Name] = j
            end
        end
        local UpperTorso1 = v7.UpperTorso1
        a1:Connect(a2:GetAttributeChangedSignal("Anim"), function() -- Line: 190 -- upvalues: a2 (val), Kit (upval), PrimaryPart (val)
            if a2:GetAttribute("Anim") == "Laugh" then
                Kit.Sound("DrScrambleLaughing", PrimaryPart, 1)
            end
        end)
        local AnimationController = a2:FindFirstChildWhichIsA("AnimationController")
        if not AnimationController then
            AnimationController = a2:WaitForChild("AnimationController", 5)
        end
        if AnimationController == nil then
            AnimationController = Instance.new("AnimationController")
            AnimationController.Parent = a2
            a1:Add(AnimationController)
        end
        a1:Connect(a2.ChildAdded, function(a1) -- Line: 203 -- upvalues: AnimationController (ref), a2 (val) -- types: a1: userdata
            if a1 ~= AnimationController and a1:IsA("AnimationController") then
                task.defer(function() -- Line: 205 -- upvalues: a1 (val), a2 (upval)
                    if a1.Parent == a2 then
                        a1.Parent = nil
                    end
                end)
            end
        end)
        local Animator = AnimationController:FindFirstChildWhichIsA("Animator")
        if Animator == nil then
            Animator = Instance.new("Animator")
            Animator.Parent = AnimationController
            a1:Add(Animator)
        end
        local u786 = {}
        local u787 = {}
        local u788 = {}
        local u789 = {}

        local function load(a1) -- Line: 223
            -- upvalues: u74 (upval), Animator (ref), u786 (val), u787 (val), u788 (val)
            local v1 = u74[a1]
            local v2 = Instance.new("Animation")
            v2.AnimationId = "rbxassetid://" .. v1
            v1 = Animator:LoadAnimation(v2)
            v2:Destroy()
            u786[a1] = v1
            u787[a1] = (os.clock())
            u788[a1] = (u788[a1] or 0) + 1
            return v1
        end

        local v8 = nil
        for k in u74, nil, v8 do
            v2 = u74[k]
            v1 = Instance.new("Animation")
            v1.AnimationId = "rbxassetid://" .. v2
            v2 = Animator:LoadAnimation(v1)
            v1:Destroy()
            u786[k] = v2
            u787[k] = (os.clock())
            u788[k] = (u788[k] or 0) + 1
        end
        u786.Idle.Looped = true
        u786.Idle:Play(0)
        a1:Add(function() -- Line: 238 -- upvalues: u786 (val)
            for i, j in u786 do
                j:Stop(0)
                j:Destroy()
            end
        end)
        local u790 = {}
        local u791 = nil
        local v9 = a1
        for n, m in a2:GetDescendants() do
            Attribute = m:GetAttribute("FollowBone")
            v4 = Attribute and v7[Attribute]
            if v4 ~= nil then
                if m:IsA("BasePart") then
                    v3 = m:FindFirstChild("Follow")
                    if v3 then
                        v5 = {
                            Motor = v3,
                            Bone = v4,
                            Offset = v4.WorldCFrame:ToObjectSpace(m.CFrame),
                        }
                        table.insert(u790, v5)
                        if m.Name == "ClawR" then
                            u791 = v5
                        end
                    end
                elseif m:IsA("Attachment") then
                    table.insert(u790, {
                        Attachment = m,
                        Bone = v4,
                        Offset = v4.WorldCFrame:ToObjectSpace(m.WorldCFrame),
                    })
                end
            end
        end
        local u378 = a2:WaitForChild("Pilot", 5)
        if u378 then
            local v10
            v8 = u378:GetAttribute("Parts") or 0
            local v11 = os.clock() + 5
            while os.clock() < v11 do
                v10 = 0
                for i5, i6 in u378:GetDescendants() do
                    if i6:IsA("BasePart") then
                        v10 = v10 + 1
                    end
                end
                if v8 <= v10 then
                    break
                end
                task.wait(0.1)
            end
        end
        local u792 = nil
        local identity = CFrame.identity
        if u378 and UpperTorso1 then
            local Attachment0, Attachment1, Motor6D, Parent, Parent_2, v12
            local u389 = u378:Clone()
            local PrimaryPart_2 = u389.PrimaryPart
            for i7, i8 in u389:GetDescendants() do
                if i8:IsA("BasePart") then
                    v12 = i8 == PrimaryPart_2
                    i8.Anchored = v12
                    i8.CanCollide = false
                    i8.CanQuery = false
                    i8.CanTouch = false
                    i8.Massless = true
                elseif not i8:IsA("WeldConstraint") then
                    if i8:IsA("BallSocketConstraint") then
                        i8.Enabled = false
                    elseif i8:IsA("Humanoid") then
                        i8.EvaluateStateMachine = false
                        i8.PlatformStand = true
                    end
                elseif not i8.Part0 then
                    if i8.Part1 and not i8.Part1:IsDescendantOf(u389) then
                        i8:Destroy()
                    end
                elseif not i8.Part0:IsDescendantOf(u389) or i8.Part1 and not i8.Part1:IsDescendantOf(u389) then
                    i8:Destroy()
                end
            end
            for i9, i10 in u389:GetDescendants() do
                if i10:IsA("AnimationConstraint") then
                    Attachment0 = i10.Attachment0
                    Attachment1 = i10.Attachment1
                    Parent = Attachment0 and Attachment0.Parent
                    Parent_2 = Attachment1 and Attachment1.Parent
                    if Attachment0
                        and Attachment1
                        and Parent
                        and Parent_2
                        and Parent:IsA("BasePart")
                        and Parent_2:IsA("BasePart") then
                        Motor6D = Instance.new("Motor6D")
                        Motor6D.Name = i10.Name
                        Motor6D.Part0 = Parent
                        Motor6D.Part1 = Parent_2
                        Motor6D.C0 = Attachment0.CFrame
                        Motor6D.C1 = Attachment1.CFrame
                        Motor6D.Parent = Parent_2
                    end
                    i10:Destroy()
                end
            end
            local Animations = u378:FindFirstChild("Animations") and u378.Animations:FindFirstChild("Drive")
            local Humanoid = u389:FindFirstChildWhichIsA("Humanoid") or u389:FindFirstChildWhichIsA("AnimationController")
            for i11, i12 in u378:GetDescendants() do
                if i12:IsA("BasePart") then
                    i12.LocalTransparencyModifier = 1
                end
            end
            identity = UpperTorso1.WorldCFrame:ToObjectSpace((u378:GetPivot()))
            u389.Name = "PilotView"
            u389.Parent = a2
            v9:Add(u389)
            if Animations and Animations:IsA("Animation") and Animations.AnimationId ~= "" and Humanoid then
                local Animator_2 = Humanoid:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")
                Animator_2.Parent = Humanoid
                v5 = Animator_2:LoadAnimation(Animations)
                v5.Looped = true
                v5:Play(0)
            end
            v9:Connect(u378.AncestryChanged, function() -- Line: 366 -- upvalues: u378 (val), a2 (val), u389 (val), u792 (ref)
                if not u378:IsDescendantOf(a2) then
                    u389:Destroy()
                    u792 = nil
                end
            end)
            u792 = u389
        end
        local u794 = {}
        local u776 = {}
        for i13, i14 in a2:GetDescendants() do
            if not i14:IsA("BasePart") then
                if i14:IsA("Attachment") and i14:GetAttribute("OverheatFx") then
                    for i15, i16 in i14:GetDescendants() do
                        if i16:IsA("ParticleEmitter") or i16:IsA("Light") then
                            i16.Enabled = false
                            table.insert(u776, i16)
                        end
                    end
                end
            elseif i14:GetAttribute("Eye") then
                u794[i14] = i14.Color
            elseif i14:IsA("Attachment") and i14:GetAttribute("OverheatFx") then
                for i17, i18 in i14:GetDescendants() do
                    if i18:IsA("ParticleEmitter") or i18:IsA("Light") then
                        i18.Enabled = false
                        table.insert(u776, i18)
                    end
                end
            end
        end
        local u496 = {
            Jiggle = 0,
            Key = "",
            StartedAt = 0,
            Pending = false,
            Overheated = false,
            WalkRate = 1,
            GrabFree = 0,
            GrabShake = 0,
            HitFlash = 0,
        }
        u496.Spec = u75.Idle
        u496.LastPosition = PrimaryPart.Position
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "HitFlash"
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.FillColor = u73
        Highlight.OutlineColor = u73
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 1
        Highlight.Enabled = false
        Highlight.Adornee = a2
        Highlight.Parent = a2
        v9:Add(Highlight)

        local function enter(a1, a2) -- Line: 418
            -- upvalues: u75 (upval), u786 (val), u496 (val)
            local Idle = u75[a1] or u75.Idle
            local v1 = if not Idle.Clip then nil else u786[Idle.Clip]
            local Track = u496.Track
            if Track and Track ~= v1 then
                Track:Stop(Idle.Fade or 0.25)
            end
            u496.Spec = Idle
            u496.Clip = Idle.Clip
            u496.Track = v1
            u496.StartedAt = a2
            u496.Pending = v1 ~= nil
            if v1 then
                v1.Looped = Idle.Loop == true
            end
        end

        local function start(a1, a2) -- Line: 436
            -- upvalues: Workspace (upval), u496 (val)
            local v1 = a2.Speed or 1
            local v2 = math.max((Workspace:GetServerTimeNow()) - u496.StartedAt, 0)
            local v3 = (a2.From or 0) + v2 * v1
            if a2.Loop then
                v3 = v3 % a1.Length
            end
            v3 = math.min(
                v3,
                (if a2.HoldAt then math.min(a2.HoldAt, a1.Length - 0.04) else if not a2.Hold then nil else math.max(a1.Length - 0.04, 0)) or a1.Length - 0.04
            )
            a1.Looped = a2.Loop == true
            if not a1.IsPlaying then
                a1:Play(0.25)
            end
            a1.TimePosition = math.max(v3, 0)
            a1:AdjustSpeed(if not v2 then v1 else if not (v2 <= v3) then v1 else 0)
        end

        local function retryMissing() -- Line: 453
            -- upvalues: u786 (val), u789 (val), u787 (val), u788 (val), u74 (upval), Animator (ref), u496 (val)
            local v1, v2, v3
            local v4 = os.clock()
            for i, j in u786 do
                if not (0 < j.Length) and not u789[i] then
                    v1 = v4 - u787[i]
                    if not (v1 < 4) then
                        v1 = u788[i]
                        if not (v1 >= 5) then
                            j:Destroy()
                            v3 = u74[i]
                            v2 = Instance.new("Animation")
                            v2.AnimationId = "rbxassetid://" .. v3
                            v1 = Animator:LoadAnimation(v2)
                            v2:Destroy()
                            u786[i] = v1
                            u787[i] = (os.clock())
                            u788[i] = (u788[i] or 0) + 1
                            if u496.Clip == i then
                                u496.Track = v1
                                u496.Pending = true
                            end
                        else
                            u789[i] = true
                            warn(string.format("[ScrambleBoss] mech clip %s (%d) never loaded", i, u74[i]))
                        end
                    end
                end
            end
        end

        local function keepIdle() -- Line: 481 -- upvalues: u786 (val)
            local Idle = u786.Idle
            if Idle.Length <= 0 then
                return
            end
            if not Idle.Looped then
                Idle.Looped = true
            end
            if not Idle.IsPlaying then
                Idle:Play(0.25)
            end
        end

        local function drive(a1) -- Line: 495
            -- upvalues: a2 (val), u496 (val), enter (val), retryMissing (val), u786 (val), PrimaryPart (val)
            -- upvalues: start (val)
            local v1 = a2:GetAttribute("Anim") or "Idle"
            local v2 = a2:GetAttribute("AnimAt") or 0
            local v3 = v1 .. "@" .. v2
            if v3 ~= u496.Key then
                u496.Key = v3
                enter(v1, v2)
            end
            retryMissing()
            local Idle = u786.Idle
            if not (Idle.Length <= 0) then
                if not Idle.Looped then
                    Idle.Looped = true
                end
                if not Idle.IsPlaying then
                    Idle:Play(0.25)
                end
            end
            local Position = PrimaryPart.Position
            v1 = Vector3.new(Position.X - u496.LastPosition.X, 0, Position.Z - u496.LastPosition.Z)
            u496.LastPosition = Position
            if a1 > 0 then
                local v4 = u496
                v4.WalkRate = v4.WalkRate + ((math.clamp(v1.Magnitude / a1 / 20, 0.4, 1.6)) - u496.WalkRate) * (1 - math.exp(-a1 * 2))
            end
            local Track = u496.Track
            local Spec = u496.Spec
            if Track ~= nil and not (Track.Length <= 0) then
                local v5
                if u496.Pending then
                    u496.Pending = false
                    start(Track, Spec)
                    return
                end
                if Spec.Loop and not Track.IsPlaying then
                    start(Track, Spec)
                    return
                end
                if Spec.Walk then
                    Track:AdjustSpeed((Spec.Speed or 1) * u496.WalkRate)
                    return
                end
                if (if Spec.HoldAt then math.min(Spec.HoldAt, Track.Length - 0.04) else if not Spec.Hold then nil else math.max(Track.Length - 0.04, 0)) == nil then
                    return
                end
                if not Track.IsPlaying then
                    Track:Play(0)
                    Track.TimePosition = v5
                    Track:AdjustSpeed(0)
                    return
                end
                if Track.Speed ~= 0 and v5 <= Track.TimePosition then
                    Track.TimePosition = v5
                    Track:AdjustSpeed(0)
                end
                return
            end
        end

        v9:Connect(RunService.PreAnimation, function(a1) -- Line: 552 -- upvalues: a2 (val), drive (val) -- types: a1: number
            if a2.Parent ~= nil then
                drive(a1)
            end
        end)
        v9:Connect(RunService.PreSimulation, function(a1) -- Line: 558
            -- upvalues: a2 (val), u496 (val), Highlight (val), UpperTorso1 (val), rad (upval), PrimaryPart (val)
            -- upvalues: u790 (val), u791 (ref), u792 (ref), identity (ref), ScrambleBossHazards (upval), u776 (val)
            -- upvalues: u794 (val), u45 (upval), Kit (upval)
            local Motor, v1, v2, v3, v4, v5
            if a2.Parent == nil then
                return
            end
            u496.Jiggle = math.max(0, u496.Jiggle - a1 * 5)
            u496.HitFlash = math.max(0, u496.HitFlash - a1 / 0.18)
            local HitFlash_2 = u496.HitFlash
            Highlight.Enabled = HitFlash_2 > 0
            Highlight.FillTransparency = 1 - 0.6 * HitFlash_2
            Highlight.OutlineTransparency = 1 - HitFlash_2
            local Jiggle_2 = u496.Jiggle
            if Jiggle_2 > 0 and UpperTorso1 then
                v1 = UpperTorso1
                local Transform = v1.Transform
                v2 = math.sin((os.clock()) * 70) * 3.5 * Jiggle_2
                v3 = math.cos((os.clock()) * 53) * 3 * Jiggle_2
                local v6 = math.sin((os.clock()) * 61) * 2.5 * Jiggle_2
                v1.Transform = Transform * CFrame.Angles(rad(v2), rad(v3 or 0), (rad(v6 or 0)))
            end
            v1 = nil
            local v7 = nil
            v2 = nil
            for i, j in u790, v7, v2 do
                v4 = j.Bone.TransformedWorldCFrame * j.Offset
                if j == u791 then
                    v1 = v4
                end
                if not j.Motor then
                    j.Attachment.WorldCFrame = v4
                else
                    Motor = j.Motor
                    Motor.Transform = (Motor.C0:Inverse()) * PrimaryPart.CFrame:ToObjectSpace(v4) * Motor.C1
                end
            end
            if u792 and UpperTorso1 then
                u792:PivotTo(UpperTorso1.TransformedWorldCFrame * identity)
            end
            local Attribute = a2.Parent and a2.Parent:GetAttribute("GrabFree") or 0
            if u496.GrabFree < Attribute then
                u496.GrabShake = 1
            end
            u496.GrabFree = Attribute
            u496.GrabShake = math.max(0, u496.GrabShake - v8 * 4)
            local ScrambleGrab = PrimaryPart:FindFirstChild("ScrambleGrab")
            if v1 and ScrambleGrab and ScrambleGrab:IsA("Weld") then
                local CFrame_2
                v7 = u496.GrabShake * 0.3
                ScrambleGrab.C0 = (ScrambleBossHazards.GripCFrame(CFrame_2:PointToObjectSpace(v1.Position))) * CFrame.Angles(math.sin((os.clock()) * 38) * v7, 0, math.cos((os.clock()) * 31) * v7)
            end
            local v9 = a2:GetAttribute("Overheated") == true
            if v9 ~= u496.Overheated then
                u496.Overheated = v9
                for k, n in u776 do
                    n.Enabled = v9
                end
            end
            v9 = a2:GetAttribute("Anim") or "Idle"
            v1 = (math.sin((os.clock()) * 14) + 1) / 2
            local v10 = true
            if v9 ~= "Fall" then
                v10 = true
                if v9 ~= "Dead" then
                    v10 = v9 == "Eject"
                end
            end
            v2 = nil
            v3 = nil
            for m, i5 in u794, v2, v3 do
                v5 = if not v10 then i5 else u45:Lerp(Kit.Red, if v9 ~= "Eject" then 0 else v1)
                m.Color = v5
            end
        end)
        return {
            Hit = function(a1) -- Line: 633 -- upvalues: u496 (val) -- types: a1: boolean
                u496.Jiggle = if not a1 then 0.6 else 1
                u496.HitFlash = 1
            end,
        }
    end,
    Ball = function(a1, a2, a3) -- Line: 640
        -- upvalues: Kit (val), Vfx (val), u54 (val), u68 (val), RunService (val), u63 (val), u59 (val)
        local BoundingBox_2
        local Animations = a2:FindFirstChild("Animations")
        local Humanoid = a2:FindFirstChildWhichIsA("Humanoid", true)
        local DrScrambleBall = a2:FindFirstChild("DrScrambleBall", true)
        local AnimationController = DrScrambleBall and DrScrambleBall:FindFirstChildWhichIsA("AnimationController", true)
        local u23 = {}
        if Animations and Humanoid then
            local Animator = Humanoid:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")
            Animator.Parent = Humanoid
            local PilotDrive = Animations:FindFirstChild("PilotDrive")
            if PilotDrive and PilotDrive:IsA("Animation") and PilotDrive.AnimationId ~= "" then
                table.insert(u23, (Animator:LoadAnimation(PilotDrive)))
            end
        end
        if Animations and AnimationController then
            local v1 = AnimationController:FindFirstChildWhichIsA("Animator") or Instance.new("Animator")
            v1.Parent = AnimationController
            local BallDrive = Animations:FindFirstChild("BallDrive")
            if BallDrive and BallDrive:IsA("Animation") and BallDrive.AnimationId ~= "" then
                table.insert(u23, (v1:LoadAnimation(BallDrive)))
            end
        end
        local v2 = nil
        for i, j in u23, nil, v2 do
            j.Looped = true
            j:Play(0)
        end
        a1:Add(function() -- Line: 666 -- upvalues: u23 (val)
            for i, j in u23 do
                j:Stop(0)
                j:Destroy()
            end
        end)
        local PrimaryPart = a2.PrimaryPart
        local u114 = nil
        local u115 = 0
        if PrimaryPart then
            local v3
            v2, v3 = Kit.Loop("BallDriving", PrimaryPart)
            u114 = v2
            u115 = v3
            if u114 then
                a1:Add(u114)
            end
        end
        local Position = if not PrimaryPart then Vector3.new(0, 0, 0) else PrimaryPart.Position
        local u130 = a2:GetAttribute("Stunned") == true
        local u388 = {}
        local u378 = {}
        local v4 = a1
        for k, n in a2:GetDescendants() do
            if not n:IsA("BasePart") then
                if n:IsA("ParticleEmitter") and n.Name == "DamageSmoke" then
                    n.Enabled = false
                    table.insert(u378, n)
                end
            elseif n:GetAttribute("DamageGlow") then
                u388[n] = n.Color
            elseif n:IsA("ParticleEmitter") and n.Name == "DamageSmoke" then
                n.Enabled = false
                table.insert(u378, n)
            end
        end
        local Visor = a2:FindFirstChild("Visor")
        local Glass = Visor and Visor:FindFirstChild("Glass")
        local VisorFollow = Glass
        if VisorFollow then
            VisorFollow = Glass:FindFirstChild("VisorFollow")
        end
        local u175 = if not Glass or not DrScrambleBall then nil else DrScrambleBall:FindFirstChild(Glass:GetAttribute("FollowBone") or "", true)
        local u183 = Glass
        if u183 then
            u183 = Glass:GetAttribute("FollowOffset")
        end
        local u184 = {}
        local u185 = -1
        if Visor then
            for m, i5 in Visor:GetDescendants() do
                if i5:IsA("BasePart") and i5:GetAttribute("CrackAt") then
                    table.insert(u184, i5)
                end
            end
        end
        local PrimaryPart_2 = a2.PrimaryPart
        _, BoundingBox_2 = a2:GetBoundingBox()
        for i6, i7 in Vfx.Trail(PrimaryPart_2, BoundingBox_2.X) do
            v4:Add(i7)
        end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "CoreHighlight"
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillColor = u54
        Highlight.OutlineColor = u68
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 0.3
        Highlight.Adornee = a2
        Highlight.Parent = a2
        v4:Add(Highlight)
        local u257 = 0
        local u258 = 0
        local u259 = 0
        v4:Connect(RunService.RenderStepped, function(a1) -- Line: 733
            -- upvalues: a2 (val), u388 (val), VisorFollow (val), u175 (val), u183 (val), u185 (ref), u184 (val)
            -- upvalues: u378 (val), u130 (ref), Kit (upval), PrimaryPart (val), u114 (ref), Position (ref), u115 (ref)
            -- upvalues: u257 (ref), u259 (ref), u258 (ref), u63 (upval), Highlight (val), u68 (upval), u59 (upval)
            local v1, v2, v3
            local v4 = math.clamp(a2:GetAttribute("DamageRatio") or 0, 0, 1)
            local v5 = a2:GetAttribute("Stunned") == true
            local v6 = (math.sin((os.clock()) * (v4 * 28 + 12)) + 1) * 0.5
            local v7 = (math.noise(os.clock() * (v4 * 18 + 8), 0, 0)) * 0.5 + 0.5
            local v8 = math.clamp(v4 * (v6 * 0.35 + 0.35 + v7 * 0.3), 0, 0.9)
            if v5 then
                v8 = math.max(v8, v6 * 0.8)
            end
            local v9 = nil
            local v10 = nil
            for i, j in u388, v9, v10 do
                v3 = Color3.fromRGB(8, 35, 12)
                i.Color = j:Lerp(v3, v8)
            end
            if VisorFollow and u175 and typeof(u183) == "CFrame" then
                v8 = u175.TransformedWorldCFrame * u183
                VisorFollow.Transform = (VisorFollow.C0:Inverse()) * VisorFollow.Part0.CFrame:ToObjectSpace(v8) * VisorFollow.C1
            end
            if v4 == u185 then
                v1 = a1
            else
                u185 = v4
                v9 = nil
                v10 = nil
                v1 = a1
                for k, n in u184, v9, v10 do
                    v2 = if not ((n:GetAttribute("CrackAt") or 2) <= v4) then 1 else 0.1
                    n.Transparency = v2
                end
            end
            local v11 = u378
            v9 = nil
            v10 = nil
            for m, i5 in v11, v9, v10 do
                v2 = v4 >= 0.28
                i5.Enabled = v2
                i5.Rate = v4 * 5 + 1
            end
            if v5 and not u130 then
                v10 = PrimaryPart or a2
                Kit.Sound("DrivingStunned", v10, 1)
            end
            u130 = v5
            if u114 and PrimaryPart then
                v6 = (PrimaryPart.Position - Position).Magnitude / math.max(v1, 0.004166666666666667)
                Position = PrimaryPart.Position
                v4 = if not v5 then math.clamp(v6 / 45, 0.25, 1) else 0
                v6 = math.min(1, v1 * 5)
                v11 = u114
                v11.Volume = v11.Volume + (v4 * u115 - u114.Volume) * v6
            end
            u257 = u257 + ((if not v5 then 0 else 1) - u257) * math.min(1, v1 * 6)
            v9 = os.clock()
            if u259 <= v9 then
                u259 = os.clock() + 0.05
                u258 = math.random()
            end
            Highlight.FillTransparency = 1 - (1 - (u63.Min + (u63.Max - u63.Min) * u258)) * u257
            Highlight.OutlineColor = u68:Lerp(u59, u257)
            Highlight.OutlineTransparency = (u258 * 0.6 - 0.3) * u257 + 0.3
        end)
    end,
}

local function waitForDroneParts(a1) -- Line: 793 -- types: a1: userdata
    local Hitbox = a1:WaitForChild("Hitbox", 10)
    local v1 = os.clock()
    while a1.PrimaryPart == nil do
        if a1.Parent == nil or not (os.clock() - v1 < 10) then
            break
        end
        task.wait()
    end
    return Hitbox, a1.PrimaryPart
end

local function attachDroneBar(a1, a2, a3) -- Line: 807
    -- upvalues: waitForDroneParts (val), Workspace (val), TweenService (val)
    local u5, v1 = waitForDroneParts(a2)
    if u5 ~= nil and v1 ~= nil and a2:IsDescendantOf(Workspace) then
        local Attribute = a2:GetAttribute("VisualSize")
        local Y = if typeof(Attribute) ~= "Vector3" then select(2, a2:GetBoundingBox()).Y else Attribute.Y
        local v2 = a3:Clone()
        v2.Adornee = v1
        v2.StudsOffsetWorldSpace = Vector3.new(0, Y / 2 + 2, 0)
        v2.Enabled = true
        v2.Parent = v1
        a1:Add(v2)
        local HealthProgress = v2:FindFirstChild("HealthProgress")
        local u54 = HealthProgress
        if u54 then
            u54 = HealthProgress:FindFirstChild("Fill")
        end
        local u61 = HealthProgress
        if u61 then
            u61 = HealthProgress:FindFirstChild("TextLabel")
        end

        local function refresh() -- Line: 828 -- upvalues: u5 (val), u61 (val), u54 (val), TweenService (upval)
            local v1 = u5:GetAttribute("Health") or 0
            local v2 = math.max(u5:GetAttribute("MaxHealth") or 1, 1)
            local v3 = math.clamp(v1 / v2, 0, 1)
            if u61 then
                u61.Text = string.format("%d / %d HP", math.max(0, (math.ceil(v1))), v2)
            end
            if u54 then
                u54.Visible = v3 > 0
                TweenService:Create(u54, TweenInfo.new(0.15), {Size = UDim2.fromScale(v3, 1)}):Play()
            end
        end

        a1:Connect(u5:GetAttributeChangedSignal("Health"), refresh)
        a1:Connect(u5:GetAttributeChangedSignal("MaxHealth"), refresh)
        refresh()
        return
    end
end

function v1.Drone(a1, a2) -- Line: 846
    -- upvalues: Kit (val), u49 (val), ReplicatedStorage (val), attachDroneBar (val), RunService (val)
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Kit.Red
    Highlight.OutlineColor = Kit.Red
    Highlight.FillTransparency = 0.9
    Highlight.OutlineTransparency = u49.Min
    Highlight.Adornee = a2
    Highlight.Parent = a2
    a1:Add(Highlight)
    local ScrambleBoss = ReplicatedStorage.Assets.UI:FindFirstChild("ScrambleBoss")
    local DroneHealth = ScrambleBoss and ScrambleBoss:FindFirstChild("DroneHealth")
    if DroneHealth then
        a1:Add((task.spawn(attachDroneBar, a1, a2, DroneHealth)))
    end
    local u40 = nil
    a1:Connect(RunService.RenderStepped, function() -- Line: 863 -- upvalues: a2 (val), u40 (ref), Kit (upval), Highlight (val), u49 (upval)
        local v1
        if a2.Parent == nil then
            return
        end
        if a2:GetAttribute("Armed") then
            if u40 == nil then
                u40 = os.clock()
                Kit.Sound("DroneFuse", a2.PrimaryPart, 1)
            end
            v1 = os.clock() - u40
            Highlight.FillTransparency = if not (math.floor(v1 * (if not (v1 < 1.86) then 11 else 2)) % 2 == 0) then 0.85 else 0.3
            Highlight.OutlineTransparency = 0
            return
        end
        if u40 then
            u40 = nil
            local PrimaryPart = a2.PrimaryPart and a2.PrimaryPart:FindFirstChild("DroneFuse")
            if PrimaryPart then
                PrimaryPart:Destroy()
            end
        end
        v1 = (math.sin((os.clock()) * 3) + 1) / 2
        Highlight.FillTransparency = 0.9
        Highlight.OutlineTransparency = u49.Min + (u49.Max - u49.Min) * v1
    end)
end

task.spawn(function() -- Line: 120 -- upvalues: u74 (val), ContentProvider (val)
    local Animation
    local v1 = table.clone(u74)
    for i = 1, 3 do
        local u8 = {}
        for j, k in v1 do
            Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://" .. k
            table.insert(u8, Animation)
        end
        local u20 = {}
        pcall(function() -- Line: 129 -- upvalues: ContentProvider (upval), u8 (val), u20 (val)
            ContentProvider:PreloadAsync(u8, function(a1, a2) -- Line: 132 -- upvalues: u20 (upval) -- types: a1: string
                local v1 = tonumber((string.match(a1, "(%d+)%D*$")))
                if v1 and a2 == Enum.AssetFetchStatus.Success then
                    u20[v1] = true
                end
            end)
        end)
        for n, m in u8 do
            m:Destroy()
        end
        for i5, i6 in v1 do
            if u20[i6] then
                v1[i5] = nil
            end
        end
        if next(v1) == nil then
            return
        end
        task.wait(i * 2)
    end
    for i7, i8 in v1 do
        warn(string.format("[ScrambleBoss] mech clip %s (%d) failed to preload", i7, i8))
    end
end)
return v1