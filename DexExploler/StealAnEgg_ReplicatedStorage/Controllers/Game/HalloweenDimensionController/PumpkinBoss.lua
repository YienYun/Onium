-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss
-- Decompile time: 40.42 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u42 = require(script.Cannon)
local Drops = require(script.Drops)
local HazardView = require(script.HazardView)
local HeadSwap = require(script.HeadSwap)
local Kit = require(script.Kit)
local Markers = require(script.Markers)
local MonsterDeath = require(script.Parent.MonsterDeath)
local Presentation = require(script.Presentation)
local Rigs = require(script.Rigs)
local Scenes = require(script.Scenes)
local Transition = require(script.Transition)
local Vfx = require(script.Vfx)
local ArenaName = PumpkinBossState.ArenaName
local Fx = PumpkinBossState.Fx
local Phases = PumpkinBossState.Phases
local u93 = table.freeze({BruteRise = true})
local Attributes = PumpkinBossState.Attributes
local ModelAttributes = PumpkinBossState.ModelAttributes
local u100 = CFrame.Angles(0, 3.141592653589793, 0)
local u108 = ("rbxassetid://%*"):format(PumpkinBossState.Clips.Brute.Walk.Id)
local u109 = {0.55, 1.35, 2.15, 2.95}
local u114 = {King = {ShadowDash = "KingShadowDash", SummonMinions = "KingSummonMinions"}}
local LocalPlayer = Players.LocalPlayer

local function vector(a1) -- Line: 84
    if typeof(a1) == "Vector3" then
        return a1
    end
    return nil
end

local function number(a1) -- Line: 88
    if type(a1) == "number" then
        return a1
    end
    return nil
end

local function bossRig(a1, a2) -- Line: 92 -- types: a2: string
    local Boss = a1.Boss
    if Boss and Boss.Parent and Boss.Name == a2 then
        return Boss
    end
    return nil
end

local function rigScale(a1) -- Line: 97 -- types: a1: userdata?
    if a1 then
        return (a1:GetScale())
    end
    return 1
end

local function rigRoot(a1) -- Line: 101 -- types: a1: userdata?
    if a1 then
        return a1.PrimaryPart
    end
    return nil
end

local function walkTrack(a1) -- Line: 105 -- upvalues: u108 (val) -- types: a1: userdata
    local Animator = a1:FindFirstChildWhichIsA("Animator", true)
    if Animator == nil then
        return nil
    end
    for i, j in Animator:GetPlayingAnimationTracks() do
        if j.Animation and j.Animation.AnimationId == u108 then
            return j
        end
    end
    return nil
end

local function crossed(a1, a2, a3) -- Line: 120 -- types: a1: number, a2: number, a3: number
    local v1
    if a3 < a2 then
        v1 = true
        if not (a2 < a1) then
            v1 = a1 <= a3
        end
        return v1
    end
    v1 = false
    if a2 < a1 then
        v1 = a1 <= a3
    end
    return v1
end

local function alongFrame(a1, a2, a3) -- Line: 129
    -- upvalues: Kit (val)
    local v1 = Kit.Flat(a2)
    return (CFrame.fromMatrix(a1, if not (0.001 < v1.Magnitude) then Vector3.new(1, 0, 0) else v1.Unit, (Vector3.new(0, 1, 0)))) * (a3 or CFrame.identity)
end

local function dashFx(a1, a2, a3, a4, a5, a6) -- Line: 157
    -- upvalues: Kit (val), Vfx (val), RunService (val), Debris (val)
    local u282 = Kit.Flat(a4 - a3)
    local Magnitude = u282.Magnitude
    if not (Magnitude < 0.001) and not (a5 <= 0) then
        local u322, u401, v1
        local Y = a3.Y
        local Scale = if not a2 then 1 else a2:GetScale()
        local PrimaryPart = if not a2 then nil else a2.PrimaryPart
        local Y_2 = if not PrimaryPart then 0 else PrimaryPart.Position.Y
        local v2 = Vfx.Template(a1, {"PumpkinCharge", "Wind"})
        local v3 = if not a6.Ride then nil else Vfx.Template(a1, {"PumpkinCharge", "ChargeRun"})
        local u611 = a6.Linger or 0
        local u340 = a6.Width or 0
        local v4 = if not a6.Strip or not (u611 > 0) or not (u340 > 0) then nil else Vfx.Template(a1, {"PumpkinCharge", a6.Strip})
        local u558 = if not v2 then 0 else v2.Position.Y * Scale
        local WindTurn = a6.WindTurn
        if not v2 then
            v1 = nil
        else
            local Place = Vfx.Place
            local v5 = Kit.Flat(u282)
            local Unit = if not (0.001 < v5.Magnitude) then Vector3.new(1, 0, 0) else v5.Unit
            v1 = Place(
                v2,
                (CFrame.fromMatrix(a3 + Vector3.new(0, u558, 0), Unit, (Vector3.new(0, 1, 0)))) * (WindTurn or CFrame.identity),
                a6.WindScale or Scale
            )
        end
        if v1 and a6.FitWind then
            local new, v6, v7
            for i, j in v1:GetDescendants() do
                if j:IsA("ParticleEmitter") then
                    v2 = j.Speed.Max * j.Lifetime.Max
                    v6 = if not (v2 > 0.001) then 1 else math.min(1, Magnitude / v2)
                    new = NumberRange.new
                    v7 = j.Speed.Min * v6
                    j.Speed = new(v7, j.Speed.Max * v6)
                end
            end
        end
        local u202 = if not v1 then nil else Vfx.Hold(v1)
        v1 = table.clone(a6.StripLook or {})
        if a6.StripAtRig and PrimaryPart then
            v1.Lift = Y_2 - Y
        end
        if not v4 then
            u322 = nil
        else
            local Strip = Vfx.Strip
            local v8 = Kit.Flat(u282)
            u322 = Strip(
                v4,
                (CFrame.fromMatrix(a3, if not (0.001 < v8.Magnitude) then Vector3.new(1, 0, 0) else v8.Unit, (Vector3.new(0, 1, 0)))) * CFrame.identity,
                Scale,
                v1
            )
        end
        if u322 then
            u322:Span(a3, a3, u340)
        end
        if not v3 then
            u401 = nil
        else
            local Place_2 = Vfx.Place
            v4 = Kit.Flat(u282)
            u401 = Place_2(
                v3,
                (CFrame.fromMatrix(a3, if not (0.001 < v4.Magnitude) then Vector3.new(1, 0, 0) else v4.Unit, (Vector3.new(0, 1, 0)))) * CFrame.identity,
                Scale,
                a6.RideParticles or 1
            )
        end
        local u402 = {}
        local u403 = {}
        if u401 then
            local v9 = Magnitude / a5
            for k, n in u401:GetDescendants() do
                if n:IsA("ParticleEmitter") then
                    n.Enabled = false
                    u402[n] = n.Rate / v9
                    u403[n] = 0
                end
            end
        end
        if u202 == nil and u401 == nil and u322 == nil then
            return
        end
        local u478 = os.clock()
        local u483 = a3
        local u484 = nil
        RunService.Heartbeat:Connect(function() -- Line: 239
            -- upvalues: u478 (val), a5 (val), PrimaryPart (val), a4 (val), Y (val), a3 (val), u202 (val), Y_2 (val)
            -- upvalues: u558 (val), u282 (val), WindTurn (val), Kit (upval), u322 (val), u340 (val), u401 (val)
            -- upvalues: u483 (ref), u402 (val), u403 (val), u484 (ref), Debris (upval), Vfx (upval), u611 (val)
            -- upvalues: a6 (val)
            local v1
            local v2 = math.clamp((os.clock() - u478) / a5, 0, 1)
            local v3 = false
            if v2 < 1 then
                v3 = false
                if PrimaryPart ~= nil then
                    v3 = PrimaryPart.Parent ~= nil
                end
            end
            local v4 = if v2 >= 1 then Vector3.new(a4.X, Y, a4.Z) else if not PrimaryPart or not v3 then a3:Lerp(a4, 1 - (1 - v2) ^ 2) else Vector3.new(PrimaryPart.Position.X, Y, PrimaryPart.Position.Z)
            if u202 then
                v1 = Kit.Flat(u282)
                local Unit = if not (0.001 < v1.Magnitude) then Vector3.new(1, 0, 0) else v1.Unit
                u202:Move((CFrame.fromMatrix(
                    v4 + Vector3.new(0, u558 + (if not PrimaryPart then 0 else if not v3 then 0 else PrimaryPart.Position.Y - Y_2), 0),
                    Unit,
                    (Vector3.new(0, 1, 0))
                )) * (WindTurn or CFrame.identity))
            end
            if u322 then
                u322:Span(a3, v4, u340)
            end
            if u401 then
                local v5
                v3 = Kit.Flat(u282)
                u401.CFrame = (CFrame.fromMatrix(v4, if not (0.001 < v3.Magnitude) then Vector3.new(1, 0, 0) else v3.Unit, (Vector3.new(0, 1, 0)))) * CFrame.identity
                local Magnitude = Kit.Flat(v4 - u483).Magnitude
                local v6 = nil
                local v7 = nil
                for i, j in u402, v6, v7 do
                    v5 = u403[i] + Magnitude * j
                    v1 = math.floor(v5)
                    if v1 > 0 then
                        i:Emit(v1)
                    end
                    u403[i] = v5 - v1
                end
            end
            u483 = v4
            if v2 >= 1 then
                u484:Disconnect()
                if u202 then
                    u202:Stop()
                end
                if u401 then
                    Debris:AddItem(u401, (Vfx.Settle(u401)))
                end
                if u322 then
                    task.delay(math.max(u611 - (a6.StopLead or 0), 0), function() -- Line: 277 -- upvalues: u322 (upval)
                        u322:Stop()
                    end)
                end
            end
        end)
        return
    end
end

local function lockControls(a1) -- Line: 285 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChildOfClass("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        local success, err = pcall(require, PlayerModule)
        if success and type(err) == "table" then
            local u27 = err:GetControls()
            if u27 ~= nil and u27.controlsEnabled ~= false then
                u27:Disable()
                local Character = LocalPlayer.Character
                local v1 = Character and Character:FindFirstChildOfClass("Humanoid")
                if v1 then
                    v1:Move((Vector3.new(0, 0, 0)))
                    v1.Jump = false
                end
                a1:Add(function() -- Line: 307 -- upvalues: u27 (val)
                    if u27.controlsEnabled == false then
                        u27:Enable()
                    end
                end)
                return
            end
            return
        end
        return
    end
end

local function bindArena(a1, a2) -- Line: 314
    -- upvalues: Workspace (val), Attributes (val), Presentation (val), HazardView (val), Rigs (val), u42 (val)
    -- upvalues: Drops (val), Markers (val), Scenes (val), RunService (val), LocalPlayer (val), PumpkinBossState (val)
    -- upvalues: ModelAttributes (val), u114 (val), Kit (val), walkTrack (val), u109 (val), Trove (val)
    -- upvalues: lockControls (val), u93 (val), MonsterDeath (val), Remotes (val), Fx (val), Vfx (val), dashFx (val)
    -- upvalues: HeadSwap (val), u100 (val), Phases (val)
    local u4 = a1:Extend()
    u4:Connect(a2.AncestryChanged, function() -- Line: 316 -- upvalues: a2 (val), Workspace (upval), a1 (val), u4 (val)
        if not a2:IsDescendantOf(Workspace) then
            a1:Remove(u4)
        end
    end)
    local u16 = a2:GetAttribute(Attributes.SkipCutscenes) == true
    local u23 = Presentation.new(u4, a2)
    local u28 = HazardView.new(u4, a2)
    local u33 = Rigs.new(u4, a2)
    local u38 = u42.new(u4, a2)
    Drops.new(u4)
    Markers.Start(u4)
    u4:Add(Scenes.StopAll)

    local function say(a1, a2, a3) -- Line: 331 -- upvalues: u23 (val) -- types: a1: string, a2: string?, a3: number
        u23:Say(a1, a2, a3)
    end

    local function bossSource(a1, a2) -- Line: 335 -- upvalues: u33 (val) -- types: a1: string, a2: vector?
        local Boss = u33.Boss
        local v1 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= a1 then nil else Boss
        return (if not v1 then nil else v1.PrimaryPart) or a2
    end

    local u54 = nil
    local u55 = nil
    local u56 = 0
    u4:Connect(RunService.Heartbeat, function() -- Line: 343
        -- upvalues: u33 (val), u54 (ref), u55 (ref), LocalPlayer (upval), PumpkinBossState (upval)
        -- upvalues: ModelAttributes (upval), u114 (upval), Workspace (upval), Kit (upval), walkTrack (upval), u56 (ref)
        -- upvalues: u109 (upval)
        local Boss = u33.Boss
        if Boss ~= nil and Boss.Parent ~= nil then
            local v1
            local v2 = LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true
            local Attribute = Boss:GetAttribute(ModelAttributes.Anim)
            local Attribute_2 = Boss:GetAttribute(ModelAttributes.AnimAt)
            local v3 = ("%*:%*@%*"):format(Boss.Name, Attribute, Attribute_2)
            if v3 ~= u54 then
                u54 = v3
                u55 = nil
                local v4 = u114[Boss.Name]
                v1 = if not v4 then nil else if type(Attribute) ~= "string" then nil else v4[Attribute]
                if v2
                    and v1
                    and type(Attribute_2) == "number"
                    and Workspace:GetServerTimeNow() - Attribute_2 < 0.5 then
                    Kit.Sound(v1, if not Boss then nil else Boss.PrimaryPart)
                end
            end
            if Boss.Name == "Brute" and Attribute == "Walk" then
                v3 = u55
                if v3 ~= nil and v3.IsPlaying then
                    local v5
                    local TimePosition = v3.TimePosition
                    v3 = u56
                    u56 = TimePosition
                    v1 = nil
                    local v6 = nil
                    for i, j in u109, v1, v6 do
                        if v2 then
                            if not (TimePosition < v3) then
                                v5 = false
                                if v3 < j then
                                    v5 = j <= TimePosition
                                end
                            else
                                v5 = true
                                if not (v3 < j) then
                                    v5 = j <= TimePosition
                                end
                            end
                            if v5 then
                                Kit.Sound("BruteStep", if not Boss then nil else Boss.PrimaryPart)
                                return
                            end
                        end
                    end
                    return
                end
                u55 = walkTrack(Boss)
                u56 = if not u55 then 0 else u55.TimePosition
                return
            end
            return
        end
        u54 = nil
        u55 = nil
    end)
    local u63 = (-1 / 0)
    local u64 = nil

    local function unlockScene() -- Line: 395 -- upvalues: u64 (ref)
        local v1 = u64
        u64 = nil
        if v1 then
            v1:Destroy()
        end
    end

    u4:Add(unlockScene)

    local function lockScene(a1, a2_2) -- Line: 404
        -- upvalues: u64 (ref), Trove (upval), unlockScene (val), a2 (val), Attributes (upval), LocalPlayer (upval)
        -- upvalues: PumpkinBossState (upval), lockControls (upval)
        local v1 = u64
        u64 = nil
        if v1 then
            v1:Destroy()
        end
        if a2_2 <= 0 then
            return
        end
        v1 = Trove.new()
        u64 = v1
        v1:Add((task.delay(a2_2, unlockScene)))
        v1:Connect(a2:GetAttributeChangedSignal(Attributes.Scene), function() -- Line: 413 -- upvalues: a2 (upval), Attributes (upval), a1 (val), u64 (upval)
            local v1 = a2
            if (v1:GetAttribute(Attributes.Scene)) ~= a1 then
                v1 = u64
                u64 = nil
                if v1 then
                    v1:Destroy()
                end
            end
        end)
        v1:Connect(LocalPlayer:GetAttributeChangedSignal(PumpkinBossState.MemberAttribute), function() -- Line: 420 -- upvalues: LocalPlayer (upval), PumpkinBossState (upval), u64 (upval)
            local v1 = LocalPlayer
            if v1:GetAttribute(PumpkinBossState.MemberAttribute) ~= true then
                v1 = u64
                u64 = nil
                if v1 then
                    v1:Destroy()
                end
            end
        end)
        v1:Connect(LocalPlayer.CharacterAdded, unlockScene)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid ~= nil and not (Humanoid.Health <= 0) then
            v1:Connect(Humanoid.Died, unlockScene)
            lockControls(v1)
            return
        end
        local v2 = u64
        u64 = nil
        if v2 then
            v2:Destroy()
        end
    end

    local u71 = nil

    local function playScene(a1, a2_2, a3) -- Line: 438
        -- upvalues: u71 (ref), Scenes (upval), a2 (val), say (val), u93 (upval), lockScene (val), Workspace (upval)
        local v1 = ("%*@%*"):format(a1, a3)
        if v1 == u71 then
            return
        end
        u71 = v1
        Scenes.Play(a1, a2, a2_2, a3, say)
        if u93[a1] then
            lockScene(a1, a2_2 - (Workspace:GetServerTimeNow() - a3))
        end
    end

    local function catchUp() -- Line: 451
        -- upvalues: u16 (val), LocalPlayer (upval), PumpkinBossState (upval), a2 (val), Attributes (upval)
        -- upvalues: Workspace (upval), u71 (ref), Scenes (upval), say (val), u93 (upval), lockScene (val)
        if not u16 and LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true then
            local Attribute = a2:GetAttribute(Attributes.Scene)
            local Attribute_2 = a2:GetAttribute(Attributes.SceneAt)
            local Attribute_3 = a2:GetAttribute(Attributes.SceneEnds)
            if type(Attribute) == "string" and type(Attribute_2) == "number" and type(Attribute_3) == "number" then
                if Attribute_3 - Workspace:GetServerTimeNow() < 1 then
                    return
                end
                local v1 = Attribute_3 - Attribute_2
                local v2 = ("%*@%*"):format(Attribute, Attribute_2)
                if v2 == u71 then
                    return
                end
                u71 = v2
                Scenes.Play(Attribute, a2, v1, Attribute_2, say)
                if u93[Attribute] then
                    lockScene(Attribute, v1 - (Workspace:GetServerTimeNow() - Attribute_2))
                end
                return
            end
            return
        end
    end

    u4:Connect(LocalPlayer:GetAttributeChangedSignal(PumpkinBossState.MemberAttribute), catchUp)

    local function minionAt(a1) -- Line: 468
        -- upvalues: MonsterDeath (upval), a2 (val), PumpkinBossState (upval)
        return MonsterDeath.NearestModel(a2:FindFirstChild(PumpkinBossState.MinionFolder), a1, 10)
    end

    u4:Connect(Remotes.PumpkinBoss.Hazard.OnClientEvent, function(a1) -- Line: 476 -- upvalues: u28 (val), u63 (ref), u33 (val), Kit (upval)
        if type(a1) == "table" and typeof(a1.Origin) == "Vector3" and type(a1.Id) == "number" then
            u28:Add(a1)
            if a1.Kind == "Missile" and a1.Style == "Bomb" then
                local v1 = os.clock()
                local v2 = v1 - u63
                if v2 > 0.4 then
                    local Boss_2 = u33.Boss
                    v2 = if not Boss_2 then nil else if not Boss_2.Parent then nil else if Boss_2.Name ~= "Brute" then nil else Boss_2
                    if not v2 then
                        local Sound_2 = Kit.Sound
                        local Origin_2 = a1.Origin
                        local Boss = u33.Boss
                        local v3 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
                        Sound_2("KingBarrageShoot", (if not v3 then nil else v3.PrimaryPart) or Origin_2)
                    else
                        local Sound = Kit.Sound
                        local PrimaryPart = if not v2 then nil else v2.PrimaryPart
                        if not PrimaryPart then
                            local From = a1.From
                            PrimaryPart = if typeof(From) ~= "Vector3" then nil else From
                        end
                        Sound("BruteBombThrow", PrimaryPart)
                    end
                end
                u63 = v1
            end
        end
    end)
    local u94 = {}

    u94[Fx.Callout] = function(a1) -- Line: 499 -- upvalues: u23 (val)
        if type(a1.Text) == "string" then
            u23:Say(a1.Text, a1.Speaker, a1.Seconds or 2.5)
        end
    end

    u94[Fx.Scene] = function(a1) -- Line: 504
        -- upvalues: u16 (val), Workspace (upval), u71 (ref), Scenes (upval), a2 (val), say (val), u93 (upval)
        -- upvalues: lockScene (val)
        if type(a1.Name) == "string" and not u16 then
            local At_2 = if type(a1.At) ~= "number" then Workspace:GetServerTimeNow() else a1.At
            if 1 < Workspace:GetServerTimeNow() - At_2 then
                return
            end
            local Name_2 = a1.Name
            local v1 = a1.Seconds or 2
            local v2 = ("%*@%*"):format(Name_2, At_2)
            if v2 == u71 then
                return
            end
            u71 = v2
            Scenes.Play(Name_2, a2, v1, At_2, say)
            if u93[Name_2] then
                lockScene(Name_2, v1 - (Workspace:GetServerTimeNow() - At_2))
            end
            return
        end
    end

    u94[Fx.BossHit] = function(a1) -- Line: 516 -- upvalues: Kit (upval), u33 (val)
        Kit.Sound("Hit", nil, 0.5, if not a1.Stunned then 1 else 1.2)
        u33:Flash()
    end

    u94[Fx.BossSpawn] = function(a1) -- Line: 520 -- upvalues: Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.ShakeFrom(v1, 6, 250)
        end
        Kit.Sound("Roar", nil, 0.8)
    end

    u94[Fx.Stomp] = function(a1) -- Line: 527 -- upvalues: Kit (upval), Vfx (upval), u33 (val)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            local v2
            Kit.ShakeFrom(v1, if not (150 < (a1.Radius or 0)) then 4 else 8, 300)
            local v3 = if not (a1.Kind == "Slam") then 0.75 else 1
            local v4 = if not v2 then 1.08 else 1
            Kit.Sound("BruteSlam", v1, v3, v4)
            local v5 = {"PumpkinSlam", "PumpkinSlam"}
            v2 = Vfx.Template(Vfx.PhaseOne, v5)
            if v2 then
                local v6 = if a1.Kind ~= "Slam" then 1 else 1.4
                local Boss = u33.Boss
                v3 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "Brute" then nil else Boss
                v5 = (if not v3 then 1 else v3:GetScale()) * v6
                Vfx.Emit(Vfx.Place(v2, (CFrame.new(v1)) * v2.CFrame.Rotation, v5))
            end
        end
    end

    u94[Fx.Swipe] = function(a1) -- Line: 546 -- upvalues: Kit (upval), u33 (val), Vfx (upval)
        local v1
        local Origin = a1.Origin
        if (if typeof(Origin) ~= "Vector3" then nil else Origin) == nil then
            return
        end
        local Sound = Kit.Sound
        local Boss = u33.Boss
        local v2 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "Brute" then nil else Boss
        Sound("BruteSwipe", (if not v2 then nil else v2.PrimaryPart) or v1)
        local v3 = {"PumpkinSwipe", if a1.Side ~= "Left" then "BossSwipeRight" else "BossSwipeLeft"}
        local v4 = Vfx.Template(Vfx.PhaseOne, v3)
        local Flat = Kit.Flat
        local Direction = a1.Direction
        local v5 = Flat((if typeof(Direction) ~= "Vector3" then nil else Direction) or Vector3.new(0, 0, 0))
        if v4 and 0.001 < v5.Magnitude then
            local Boss_2 = u33.Boss
            v3 = if not Boss_2 then nil else if not Boss_2.Parent then nil else if Boss_2.Name ~= "Brute" then nil else Boss_2
            local v6 = if not v3 then 1 else v3:GetScale()
            v3 = CFrame.lookAt(v1, v1 + v5)
            Vfx.Emit(Vfx.Place(v4, v3 * CFrame.new(Vector3.new(0, 5.360000133514404, -4) * v6) * v4.CFrame.Rotation, v6))
        end
    end

    u94[Fx.Charge] = function(a1) -- Line: 567 -- upvalues: Kit (upval), u33 (val), dashFx (upval), Vfx (upval)
        local From = a1.From
        local v1 = if typeof(From) ~= "Vector3" then nil else From
        local To = a1.To
        local v2 = if typeof(To) ~= "Vector3" then nil else To
        if v1 then
            Kit.ShakeFrom(v1, 3, 200)
        end
        local Sound = Kit.Sound
        local Boss = u33.Boss
        local v3 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "Brute" then nil else Boss
        Sound("BruteCharge", (if not v3 then nil else v3.PrimaryPart) or v1)
        if v1 and v2 then
            local v4 = dashFx
            local PhaseOne = Vfx.PhaseOne
            local Boss_2 = u33.Boss
            local v5 = if not Boss_2 then nil else if not Boss_2.Parent then nil else if Boss_2.Name ~= "Brute" then nil else Boss_2
            local v6 = a1.Seconds or 0.6
            local v7 = {Ride = true, Strip = "ChargeRun", WindScale = 1, RideParticles = Vfx.FireParticles}
            local Linger = a1.Linger
            v7.Linger = if type(Linger) ~= "number" then nil else Linger
            local Width = a1.Width
            v7.Width = if type(Width) ~= "number" then nil else Width
            v7.StripLook = {Particles = Vfx.FireParticles, Density = Vfx.FireDensity}
            v4(PhaseOne, v5, v1, v2, v6, v7)
        end
    end

    u94[Fx.BruteDown] = function(a1) -- Line: 586 -- upvalues: Kit (upval), u33 (val)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.ShakeFrom(v1, 7, 300)
        end
        local Sound = Kit.Sound
        local v2 = v1
        if not v2 then
            local Boss = u33.Boss
            local v3 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "Brute" then nil else Boss
            v2 = (if not v3 then nil else v3.PrimaryPart) or nil
        end
        Sound("BruteDeath", v2)
    end

    u94[Fx.BruteHead] = function(a1) -- Line: 593 -- upvalues: HeadSwap (upval), u33 (val), Workspace (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            local Play = HeadSwap.Play
            local Boss = u33.Boss
            local v2 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "Brute" then nil else Boss
            local Facing = a1.Facing
            local Drop_2 = if type(a1.Drop) ~= "number" then 0.8 else a1.Drop
            local Sit_2 = if type(a1.Sit) ~= "number" then 0 else a1.Sit
            local StartedAt_2 = if type(a1.StartedAt) ~= "number" then Workspace:GetServerTimeNow() else a1.StartedAt
            Play(v2, v1, (if typeof(Facing) ~= "Vector3" then nil else Facing) or Vector3.new(-0, -0, -1), Drop_2, Sit_2, StartedAt_2)
        end
    end

    u94[Fx.KingRise] = function(a1) -- Line: 608 -- upvalues: Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.ShakeFrom(v1, 5, 300)
        end
    end

    u94[Fx.ShadowDash] = function(a1) -- Line: 614 -- upvalues: Kit (upval), u33 (val), dashFx (upval), Vfx (upval), u100 (upval)
        local From = a1.From
        local v1 = if typeof(From) ~= "Vector3" then nil else From
        local To = a1.To
        local v2 = if typeof(To) ~= "Vector3" then nil else To
        local Sound = Kit.Sound
        local v3 = "KingDash"
        local Boss = u33.Boss
        local v4 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
        Sound(v3, (if not v4 then nil else v4.PrimaryPart) or v1)
        if v1 and v2 then
            local Boss_2 = u33.Boss
            local v5 = if not Boss_2 then nil else if not Boss_2.Parent then nil else if Boss_2.Name ~= "King" then nil else Boss_2
            v3 = dashFx
            local PhaseTwo = Vfx.PhaseTwo
            local v6 = a1.Seconds or 0.45
            local v7 = {
                Strip = "Toxic",
                StopLead = 3,
                StripAtRig = true,
                WindScale = 1,
                FitWind = true,
            }
            local Linger = a1.Linger
            v7.Linger = if type(Linger) ~= "number" then nil else Linger
            local Width = a1.Width
            v7.Width = if type(Width) ~= "number" then nil else Width
            v7.StripLook = {Density = 6, Particles = if not v5 then 1 else v5:GetScale()}
            v7.WindTurn = u100
            v3(PhaseTwo, v5, v1, v2, v6, v7)
        end
    end

    u94[Fx.VineTrap] = function(a1) -- Line: 633 -- upvalues: LocalPlayer (upval), u23 (val), Kit (upval)
        if a1.UserId == LocalPlayer.UserId then
            u23:FlashScreen(Kit.Red, 0.55, 0.4)
            Kit.Shake(3, 14, 0.4)
        end
    end

    u94[Fx.VineHit] = function(a1) -- Line: 639 -- upvalues: Kit (upval)
        Kit.Sound("Hit", nil, 0.35, 1.3)
    end

    u94[Fx.VineBreak] = function(a1) -- Line: 642 -- upvalues: Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.Burst(v1, 8, Kit.Green, 0.35)
        end
    end

    u94[Fx.MinionSpawn] = function(a1) -- Line: 648 -- upvalues: Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.Burst(v1, 6, Kit.Orange, 0.35)
        end
    end

    u94[Fx.MinionHit] = function(a1) -- Line: 654 -- upvalues: Kit (upval)
        Kit.Sound("Hit", nil, 0.35, 1.4)
    end

    u94[Fx.MinionPop] = function(a1) -- Line: 657 -- upvalues: Kit (upval), MonsterDeath (upval), minionAt (val)
        local v1
        local At = a1.At
        if (if typeof(At) ~= "Vector3" then nil else At) == nil then
            return
        end
        if a1.Despawn == true then
            Kit.Burst(v1, 4, Kit.Orange, 0.3)
            return
        end
        MonsterDeath.Play(v1, 1, minionAt(v1))
    end

    u94[Fx.MinionBoom] = function(a1) -- Line: 669 -- upvalues: Vfx (upval), Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            if not Vfx.Play(Vfx.PhaseTwo, {"HeadExplode"}, CFrame.new(v1), 0.5) then
                local Radius_2 = if type(a1.Radius) ~= "number" then 14 else a1.Radius
                Kit.Burst(v1, Radius_2, Kit.Orange, 0.45)
                Kit.Burst(v1, Radius_2 * 0.5, Color3.new(1, 1, 1), 0.2)
            end
            Kit.ShakeFrom(v1, 4, 80)
            Kit.Sound("Explosion", v1, 0.7)
        end
    end

    u94[Fx.MinionArm] = function(a1) end

    u94[Fx.ShieldUp] = function(a1) -- Line: 684 -- upvalues: Kit (upval), u33 (val), u23 (val)
        local Sound = Kit.Sound
        local Boss = u33.Boss
        local v1 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
        Sound("KingShieldCast", (if not v1 then nil else v1.PrimaryPart) or nil)
        u23:FlashScreen(Kit.Purple, 0.6, 0.6)
    end

    u94[Fx.ShieldHit] = function(a1) -- Line: 688 -- upvalues: Kit (upval)
        Kit.Sound("Hit", nil, 0.5, 0.8)
    end

    u94[Fx.ShieldBreak] = function(a1) -- Line: 691 -- upvalues: u33 (val), Vfx (upval), Kit (upval), u23 (val)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            local v2 = u33:ShieldSize()
            Vfx.Play(Vfx.PhaseTwo, {"Shield", "ShieldBreak"}, CFrame.new(v1), if not v2 then 1 else v2 / 15)
            Kit.ShakeFrom(v1, 6, 300)
        end
        local Sound = Kit.Sound
        local v3 = v1
        if not v3 then
            local Boss = u33.Boss
            local v4 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
            v3 = (if not v4 then nil else v4.PrimaryPart) or nil
        end
        Sound("KingShieldBreak", v3)
        u23:FlashScreen(Color3.new(1, 1, 1), 0.4, 0.5)
    end

    u94[Fx.RootHit] = function(a1) -- Line: 702 -- upvalues: Kit (upval), a2 (val), PumpkinBossState (upval), u33 (val), u38 (val)
        Kit.Sound("Hit", nil, 0.35, 1.1)
        local v1 = a2:FindFirstChild(PumpkinBossState.CannonFolder)
        if v1 ~= nil and type(a1.CannonId) == "number" then
            local At, CannonId_2, v2
            for i, j in v1:GetChildren() do
                if j:IsA("Model") then
                    CannonId_2 = PumpkinBossState.CannonAttributes.CannonId
                    if (j:GetAttribute(CannonId_2)) == a1.CannonId then
                        u33:FlashCannon(j)
                        At = a1.At
                        v2 = if typeof(At) ~= "Vector3" then nil else At
                        u38:Jolt(j, v2)
                        return
                    end
                end
            end
            return
        end
    end

    u94[Fx.RootBreak] = function(a1) -- Line: 720 -- upvalues: Kit (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if v1 then
            Kit.Burst(v1, 10, Kit.Green, 0.4)
        end
    end

    u94[Fx.CannonShot] = function(a1) -- Line: 726 -- upvalues: u38 (val)
        u38:OnShot(a1)
    end

    u94[Fx.CannonImpact] = function(a1) -- Line: 729 -- upvalues: Vfx (upval), Kit (upval), a2 (val), Attributes (upval), Phases (upval), u33 (val)
        local v1
        local At = a1.At
        if not (if typeof(At) ~= "Vector3" then nil else At) then
            return
        end
        Vfx.Play(Vfx.PhaseTwo, {"Cannon", "CannonballImpact"}, CFrame.new(v1))
        Kit.Sound("Explosion", v1, 0.5)
        local Attribute = a2:GetAttribute(Attributes.Phase)
        if Attribute ~= Phases.Stunned and Attribute ~= Phases.Shield then
            Kit.ShakeFrom(v1, 2, 200)
            return
        end
        local Boss = u33.Boss
        local PrimaryPart = Boss and Boss.PrimaryPart
        local v2 = if not PrimaryPart then nil else PrimaryPart.Position - v1
        if Attribute ~= Phases.Shield or a2:GetAttribute(Attributes.ShieldActive) ~= true then
            u33:Flash(v2, 2.2)
        else
            u33:FlashShield(v2, 2.2)
        end
        Kit.ShakeFrom(v1, 3.5, 260)
        Kit.Sound("Hit", v1, 0.6, if Attribute ~= Phases.Stunned then 0.9 else 1.2)
    end

    u94[Fx.Stun] = function(a1) -- Line: 754 -- upvalues: Kit (upval), u33 (val), u23 (val)
        local Sound = Kit.Sound
        local Boss = u33.Boss
        local v1 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
        Sound("KingStun", (if not v1 then nil else v1.PrimaryPart) or nil)
        u23:Say(("The King is STUNNED for %*s! Keep shooting at him!"):format(a1.Seconds or 7), nil, 2.5)
    end

    u94[Fx.Defeated] = function(a1) -- Line: 758 -- upvalues: Kit (upval), u33 (val), Vfx (upval)
        local At = a1.At
        local v1 = if typeof(At) ~= "Vector3" then nil else At
        if a1.Stage == nil then
            local Sound = Kit.Sound
            local v2 = v1
            if not v2 then
                local Boss = u33.Boss
                local v3 = if not Boss then nil else if not Boss.Parent then nil else if Boss.Name ~= "King" then nil else Boss
                v2 = (if not v3 then nil else v3.PrimaryPart) or nil
            end
            Sound("KingDeath", v2)
            return
        end
        if a1.Stage ~= "Landed" then
            return
        end
        if v1 then
            local Boss_2 = u33.Boss
            local v4 = if not Boss_2 then nil else if not Boss_2.Parent then nil else if Boss_2.Name ~= "King" then nil else Boss_2
            local Attribute = v4 and v4:GetAttribute("BodyHeight")
            v4 = if type(Attribute) ~= "number" then v1 else v1 + Vector3.new(0, Attribute * 0.2, 0)
            Kit.Poof(v1, 3)
            Vfx.Play(Vfx.PhaseTwo, {"DieFinal"}, CFrame.new(v4))
            Kit.ShakeFrom(v1, 10, 400)
        end
    end

    u94[Fx.Currency] = function(a1) -- Line: 778 -- upvalues: Drops (upval)
        if type(a1.Amount) == "number" and 0 < a1.Amount then
            Drops.ShowCurrency(a1.Amount)
        end
    end

    u4:Connect(Remotes.PumpkinBoss.Fx.OnClientEvent, function(a1, a2) -- Line: 785 -- upvalues: u94 (val) -- types: a1: string
        local v1 = u94[a1]
        if v1 then
            local success, err = pcall(v1, if type(a2) ~= "table" then {} else a2)
            if not success then
                warn((("[PumpkinBoss] fx %* failed: %*"):format(a1, err)))
            end
        end
    end)
    catchUp()
end

local v1 = {
    Start = function(a1) -- Line: 800 -- upvalues: Workspace (val), ArenaName (val), bindArena (val), Scenes (val)
        local v1 = Workspace:FindFirstChild(ArenaName)
        if v1 and v1:IsA("Model") then
            task.defer(bindArena, a1, v1)
        end
        a1:Connect(Workspace.ChildAdded, function(a1_2) -- Line: 806 -- upvalues: ArenaName (upval), bindArena (upval), a1 (val) -- types: a1_2: userdata
            if a1_2.Name == ArenaName and a1_2:IsA("Model") then
                task.defer(bindArena, a1, a1_2)
            end
        end)
        a1:Add(Scenes.StopAll)
    end,
}
Transition.Listen()
return v1