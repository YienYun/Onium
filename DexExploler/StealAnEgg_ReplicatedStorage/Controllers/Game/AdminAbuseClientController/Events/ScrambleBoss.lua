-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss
-- Decompile time: 35.06 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ContentProvider = game:GetService("ContentProvider")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ScrambleBossFlags = require(ReplicatedStorage.Shared.Flags.ScrambleBossFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Cinematic = require(script.Cinematic)
local HazardView = require(script.HazardView)
local Kit = require(script.Kit)
local Music = require(script.Music)
local Presentation = require(script.Presentation)
local Rider = require(script.Rider)
local Rigs = require(script.Rigs)
local Transition = require(script.Transition)
local Vfx = require(script.Vfx)
local u89 = {[Enum.UserInputType.MouseButton1] = true, [Enum.UserInputType.Touch] = true}
local u94 = {
    [Enum.KeyCode.Space] = true,
    [Enum.KeyCode.ButtonA] = true,
    [Enum.KeyCode.ButtonX] = true,
    [Enum.KeyCode.ButtonR2] = true,
}
local u107 = Color3.new(1, 1, 1)
local u112 = Color3.fromRGB(120, 235, 255)
local u114 = Trove.new()
local u117 = Random.new()
local u118 = false
local LocalPlayer = Players.LocalPlayer
local u120 = false

local function coilBolts(a1, a2) -- Line: 100
    -- upvalues: Kit (val), Debris (val), u117 (val), u107 (val), u112 (val)
    local v1, v2, v3, v4, v5
    local Folder = Instance.new("Folder")
    Folder.Name = "CoilBolts"
    Folder.Parent = Kit.Debris()
    Debris:AddItem(Folder, 0.6)
    local v6, v7 = a1, a2
    for i = 1, 3 do
        v3 = {v6}
        for j = 1, 5 do
            table.insert(v3, (v6:Lerp(v7, j / 6)) + (u117:NextUnitVector()) * 3.5)
        end
        table.insert(v3, v7)
        v4 = if i ~= 1 then 0.3 else 0.5
        v5 = #v3 - 1
        for k = 1, v5 do
            v1 = v3[k]
            v2 = v3[k + 1]
            Kit.Part({
                Name = "Bolt",
                Color = if i ~= 1 then u112 else u107,
                Size = Vector3.new(v4, v4, (v2 - v1).Magnitude),
                CFrame = CFrame.lookAt((v1 + v2) / 2, v2),
                Parent = Folder,
            })
        end
    end
end

local function bindArena(a1) -- Line: 131
    -- upvalues: u114 (val), Workspace (val), Presentation (val), Music (val), HazardView (val), Rigs (val), Rider (val)
    -- upvalues: LocalPlayer (val), UserInputService (val), u89 (val), u94 (val), Remotes (val), Kit (val)
    -- upvalues: RunService (val), Vfx (val), Players (val), ScrambleBossFlags (val), coilBolts (val), u117 (val)
    -- upvalues: Cinematic (val)
    local u195 = u114:Extend()
    u195:Connect(a1.AncestryChanged, function() -- Line: 133 -- upvalues: a1 (val), Workspace (upval), u195 (val)
        if not a1:IsDescendantOf(Workspace) then
            u195:Destroy()
        end
    end)
    local u196 = Presentation.new(u195, a1)
    Music.new(u195, a1, u196)
    local u197 = HazardView.new(u195, a1)
    local u198 = nil
    local u199 = 0
    local u200 = nil
    local u201 = nil

    local function bindActor(a1_2) -- Line: 147
        -- upvalues: u195 (val), a1 (val), u198 (ref), Rigs (upval), Rider (upval)
        if not a1_2:IsA("Model") then
            return
        end
        local u8 = u195:Extend()
        u8:Connect(a1_2.AncestryChanged, function() -- Line: 153 -- upvalues: a1_2 (val), a1 (upval), u8 (val)
            if not a1_2:IsDescendantOf(a1) then
                u8:Destroy()
            end
        end)
        if a1_2.Name == "Mech" then
            Rigs.Mech(u8, a1_2)
            return
        end
        if a1_2.Name == "Croc" then
            Rider.Mount(u8, a1_2)
            return
        end
        if a1_2.Name == "Ball" then
            a1_2:WaitForChild("Root", 5)
            if a1_2.PrimaryPart then
                Rigs.Ball(u8, a1_2, a1)
            end
        end
    end

    local function bindDrone(a1) -- Line: 171
        -- upvalues: u195 (val), Workspace (upval), Rigs (upval)
        if not a1:IsA("Model") then
            return
        end
        local u8 = u195:Extend()
        u8:Connect(a1.AncestryChanged, function() -- Line: 177 -- upvalues: a1 (val), Workspace (upval), u8 (val)
            if not a1:IsDescendantOf(Workspace) then
                u8:Destroy()
            end
        end)
        Rigs.Drone(u8, a1)
    end

    local function watchDrones(a1) -- Line: 185 -- upvalues: u195 (val), bindDrone (val) -- types: a1: userdata
        u195:Connect(a1.ChildAdded, bindDrone)
        for i, j in a1:GetChildren() do
            bindDrone(j)
        end
    end

    for i, j in a1:GetChildren() do
        bindActor(j)
        if j.Name == "Drones" then
            u195:Connect(j.ChildAdded, bindDrone)
            for k, n in j:GetChildren() do
                bindDrone(n)
            end
        end
    end
    u195:Connect(a1.ChildAdded, function(a1) -- Line: 198 -- upvalues: bindActor (val), u195 (val), bindDrone (val) -- types: a1: userdata
        bindActor(a1)
        if a1.Name == "Drones" then
            u195:Connect(a1.ChildAdded, bindDrone)
            for i, j in a1:GetChildren() do
                bindDrone(j)
            end
        end
    end)

    local function syncHold() -- Line: 205 -- upvalues: LocalPlayer (upval)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            local v1 = true
            if LocalPlayer:GetAttribute("ScrambleGrabbed") ~= true then
                v1 = LocalPlayer:GetAttribute("ScrambleThrown") ~= nil
            end
            Humanoid.PlatformStand = v1
        end
    end

    u195:Connect(LocalPlayer:GetAttributeChangedSignal("ScrambleGrabbed"), syncHold)
    u195:Connect(LocalPlayer:GetAttributeChangedSignal("ScrambleThrown"), syncHold)
    u195:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 216
        -- upvalues: LocalPlayer (upval), u89 (upval), u94 (upval), u199 (ref), Remotes (upval), Kit (upval)
        if not LocalPlayer:GetAttribute("ScrambleGrabbed") then
            return
        end
        local v1 = true
        if u89[a1.UserInputType] ~= true then
            v1 = false
            if u94[a1.KeyCode] == true then
                v1 = not a2
            end
        end
        if v1 and not (os.clock() - u199 < 0.07) then
            os.clock()
            Remotes.ScrambleBoss.HazardHit:FireServer(-2)
            Kit.Sound("Tick", nil, 0.8, 1.3 + math.random() * 0.4)
            Kit.Shake(1.5, 30, 0.15)
            return
        end
    end)
    u195:Add(function() -- Line: 233 -- upvalues: u200 (ref), u201 (ref)
        if u200 then
            u200:Destroy()
        end
        u200 = nil
        u201 = nil
    end)
    u195:Connect(RunService.RenderStepped, function() -- Line: 242 -- upvalues: a1 (val), LocalPlayer (upval), u200 (ref), u201 (ref), Vfx (upval), Kit (upval)
        local v1 = a1:GetAttribute("GrabVictim") or 0
        local Mech = a1:FindFirstChild("Mech")
        local GrabRescue = Mech and Mech:FindFirstChild("GrabRescue")
        if v1 ~= 0 and v1 ~= LocalPlayer.UserId and GrabRescue ~= nil then
            local v2
            if u201 ~= GrabRescue then
                if u200 then
                    u200:Destroy()
                end
                u200 = nil
                u201 = nil
                local v3 = Instance.new("Folder")
                v3.Name = "ScrambleRescue"
                v1 = Vfx.Ground(GrabRescue.Position, a1:GetAttribute("FloorY"))
                Kit.Part({
                    Name = "Disc",
                    Transparency = 0.5,
                    Shape = Enum.PartType.Cylinder,
                    Color = Kit.Green,
                    Size = Vector3.new(0.3, GrabRescue.Size.X, GrabRescue.Size.Z),
                    CFrame = (CFrame.new(v1 + Vector3.new(0, 0.20000000298023224, 0))) * CFrame.Angles(0, 0, 1.5707963267948966),
                    Parent = v3,
                })
                Kit.Part({
                    Name = "Pillar",
                    Transparency = 0.6,
                    Shape = Enum.PartType.Cylinder,
                    Color = Kit.Green,
                    Size = Vector3.new(GrabRescue.Size.Y, 2.5, 2.5),
                    CFrame = (CFrame.new(v1 + Vector3.new(0, GrabRescue.Size.Y / 2, 0))) * CFrame.Angles(0, 0, 1.5707963267948966),
                    Parent = v3,
                })
                v3.Parent = Kit.Debris()
                u200 = v3
                u201 = GrabRescue
            end
            local v4 = (math.sin((os.clock()) * 8) + 1) / 2
            for i, j in u200:GetChildren() do
                if j:IsA("BasePart") then
                    v2 = if j.Name ~= "Disc" then v4 * 0.3 + 0.5 else v4 * 0.3 + 0.35
                    j.Transparency = v2
                end
            end
            return
        end
        if u200 then
            u200:Destroy()
        end
        u200 = nil
        u201 = nil
    end)
    u195:Connect(Remotes.ScrambleBoss.Hazard.OnClientEvent, function(a1) -- Line: 291 -- upvalues: u197 (val)
        u197:Add(a1)
    end)

    local function coilTop(a1_2) -- Line: 295 -- upvalues: a1 (val) -- types: a1_2: string
        local Coils = a1:FindFirstChild("Coils")
        local v1 = Coils and Coils:FindFirstChild(a1_2)
        if v1 == nil then
            return nil
        end
        local v2 = v1:FindFirstChild("Top")
        if v2 and v2:IsA("BasePart") then
            return v2.Position
        end
        if not v1:IsA("Model") then
            return nil
        end
        local BoundingBox, BoundingBox_2 = v1:GetBoundingBox()
        return BoundingBox.Position + Vector3.new(0, BoundingBox_2.Y / 2, 0)
    end

    local function coilBurst(a1_2) -- Line: 314 -- upvalues: a1 (val) -- types: a1_2: string
        local v1
        local Coils = a1:FindFirstChild("Coils")
        local v2 = Coils and Coils:FindFirstChild(a1_2)
        if v2 == nil then
            return
        end
        for i, j in v2:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                v1 = if j.Name ~= "AreaLightning" then 1 else 4
                j:Emit(v1)
            end
        end
    end

    local function floor(a1_2) -- Line: 328 -- upvalues: Vfx (upval), a1 (val) -- types: a1_2: vector
        return Vfx.Ground(a1_2, a1:GetAttribute("FloorY"))
    end

    local function slam(a1, a2) -- Line: 332 -- upvalues: Vfx (upval), floor (val) -- types: a1: vector, a2: number
        Vfx.Burst("Slam", CFrame.new(floor(a1)), a2)
    end

    local function hold(a1, a2) -- Line: 336 -- upvalues: u195 (val) -- types: a2: number
        if a1 == nil then
            return
        end
        u195:Add((task.delay(a2, function() -- Line: 341 -- upvalues: a1 (val)
            a1:Stop()
        end)))
        u195:Add(function() -- Line: 344 -- upvalues: a1 (val)
            a1:Stop()
        end)
    end

    local function zap(a1, a2, a3) -- Line: 349
        -- upvalues: Vfx (upval), RunService (upval), u195 (val)
        local WorldPosition
        local u191 = Vfx.Hold("LaserBeam", CFrame.new(a1))
        if u191 == nil then
            return
        end
        local u193 = {}
        local u195_2 = {}
        local v1 = nil
        local v2 = nil
        for i, j in u191.Root:GetDescendants() do
            if j:IsA("Beam") and j.Attachment0 and j.Attachment1 then
                v1 = v1 or j.Attachment0.WorldPosition
                v2 = v2 or j.Attachment1.WorldPosition
            end
        end
        for k, n in u191.Root:GetDescendants() do
            if n:IsA("Attachment") then
                WorldPosition = n.WorldPosition
                table.insert(
                    if not ((if not v2 then (1 / 0) else (WorldPosition - v2).Magnitude) < (if not v1 then 0 else (WorldPosition - v1).Magnitude)) then u193 else u195_2,
                    n
                )
            end
        end

        local function place() -- Line: 374 -- upvalues: a2 (val), u193 (val), a1 (val), u195_2 (val)
            local v1 = a2()
            for i, j in u193 do
                j.WorldPosition = a1
            end
            for k, n in u195_2 do
                n.WorldPosition = v1
            end
        end

        v1 = a2()
        for m, i5 in u193 do
            i5.WorldPosition = a1
        end
        for i6, i7 in u195_2 do
            i7.WorldPosition = v1
        end
        local u71 = os.clock()
        local u72 = nil
        u72 = RunService.RenderStepped:Connect(function() -- Line: 387
            -- upvalues: a2 (val), u193 (val), a1 (val), u195_2 (val), u71 (val), a3 (val), u72 (ref), u191 (val)
            local v1 = a2()
            for i, j in u193 do
                j.WorldPosition = a1
            end
            for k, n in u195_2 do
                n.WorldPosition = v1
            end
            if a3 <= os.clock() - u71 then
                if u72 then
                    u72:Disconnect()
                end
                u191:Stop()
            end
        end)
        u195:Add(function() -- Line: 396 -- upvalues: u72 (ref), u191 (val)
            if u72 then
                u72:Disconnect()
            end
            u191:Stop()
        end)
    end

    local function ballPosition(a1_2) -- Line: 404 -- upvalues: a1 (val) -- types: a1_2: vector
        local Ball = a1:FindFirstChild("Ball")
        if Ball ~= nil and Ball:IsA("Model") then
            local DrScrambleBall = Ball:FindFirstChild("DrScrambleBall", true)
            if DrScrambleBall and DrScrambleBall:IsA("Model") then
                return DrScrambleBall:GetBoundingBox().Position
            end
            if Ball.PrimaryPart then
                return Ball.PrimaryPart.Position
            end
            return a1_2
        end
        return a1_2
    end

    local u109 = {}

    function u109.MechIncoming(a1) -- Line: 419 -- upvalues: u196 (val), Kit (upval)
        u196:Say("INCOMING!", nil, 1.5)
        Kit.Sound("Charge", nil, 1.2, 0.7)
    end

    function u109.MechLand(a1) -- Line: 423 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.Shake(8, 14, 1.4)
        Kit.Sound("ShockwaveRing", a1.At, 1.2)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 1.1)
    end

    function u109.Stomp(a1) -- Line: 428 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        local v1
        local v2 = if not (a1.Kind == "Slam") then 8 else 11
        Kit.ShakeFrom(a1.At, v2, 520)
        local v3 = if not v1 then 1 else 1.2
        Kit.Sound("ShockwaveRing", a1.At, v3)
        local At_3 = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At_3)), if not v1 then 0.8 else 1)
    end

    function u109.Swipe(a1_2) -- Line: 434 -- upvalues: Kit (upval), Vfx (upval), a1 (val)
        local v1 = Kit.Flat(a1_2.Direction or Vector3.new(0, 0, 0))
        if v1.Magnitude < 0.1 then
            v1 = Vector3.new(0, 0, 1)
        end
        local Origin = a1_2.Origin or a1_2.At
        local v2 = Vfx.Ground(Origin, a1:GetAttribute("FloorY")) + Vector3.new(0, 9, 0)
        local v3 = Vfx.Frame("BossSwipe", v2, v1)
        if (a1_2.Side or 1) < 0 then
            v3 = (CFrame.new(v2)) * CFrame.fromAxisAngle(v1.Unit, 3.141592653589793) * v3.Rotation
        end
        v2 = Vfx.Template("BossSwipe")
        v1 = v2 and v2:GetAttribute("ReferenceRadius")
        v2 = if typeof(v1) ~= "number" then 21 else v1
        v1 = (a1_2.Radius or 46) * 0.85 / v2
        Vfx.Burst("BossSwipe", v3, v1, 0.3)
        Kit.Sound("WideArmSwipe", a1_2.At, 1.2)
        Kit.ShakeFrom(a1_2.At, 5, 180)
    end

    function u109.LaserCharge(a1) -- Line: 458 -- upvalues: Kit (upval)
        Kit.Sound("Charge", nil, 0.9, 1.1)
    end

    function u109.RushDash(a1_2) -- Line: 461
        -- upvalues: a1 (val), Kit (upval), Vfx (upval), RunService (upval), u195 (val)
        local Mech = a1:FindFirstChild("Mech")
        local PrimaryPart = Mech
        if PrimaryPart then
            PrimaryPart = Mech:IsA("Model")
            if PrimaryPart then
                PrimaryPart = Mech.PrimaryPart
            end
        end
        if PrimaryPart == nil then
            return
        end

        local function frame() -- Line: 468 -- upvalues: Kit (upval), PrimaryPart (val), Vfx (upval), a1 (upval)
            local v1 = Kit.Flat(PrimaryPart.CFrame.LookVector)
            local Unit = if not (0.1 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit
            return Vfx.Frame(
                "SpiderSlashes",
                Vfx.Ground(PrimaryPart.Position, a1:GetAttribute("FloorY")) + Unit * 34 + Vector3.new(0, 30, 0),
                Unit
            )
        end

        local Burst = Vfx.Burst
        local v1 = Kit.Flat(PrimaryPart.CFrame.LookVector)
        local Unit = if not (0.1 < v1.Magnitude) then Vector3.new(0, 0, 1) else v1.Unit
        local Position = PrimaryPart.Position
        local v2 = Vfx.Ground(Position, a1:GetAttribute("FloorY")) + Unit * 34 + Vector3.new(0, 30, 0)
        Burst("SpiderSlashes", Vfx.Frame("SpiderSlashes", v2, Unit), 1, 0.35)
        Kit.Sound("SpiderRush", PrimaryPart, 1)
        local u67 = Vfx.Hold("SpiderSlashes", frame())
        if u67 == nil then
            return
        end
        local u74 = os.clock() + (a1_2.Seconds or 0.5)
        local u75 = nil
        u75 = RunService.RenderStepped:Connect(function() -- Line: 487 -- upvalues: u74 (val), PrimaryPart (val), u75 (ref), u67 (val), frame (val)
            if not (u74 <= (os.clock())) and PrimaryPart.Parent ~= nil then
                u67:Move((frame()))
                return
            end
            if u75 then
                u75:Disconnect()
            end
            u67:Stop()
        end)
        u195:Add(function() -- Line: 497 -- upvalues: u75 (ref), u67 (val)
            if u75 then
                u75:Disconnect()
            end
            u67:Stop()
        end)
    end

    function u109.RushStop(a1) -- Line: 504 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.ShakeFrom(a1.At, 6, 250)
        Kit.Sound("HeavyLand", a1.At, 1.2)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.45)
    end

    function u109.GrabReach(a1) -- Line: 509 -- upvalues: Kit (upval)
        Kit.Sound("Swoosh", a1.At, 1.6, 0.55)
        Kit.Sound("Charge", a1.At, 0.8, 1.3)
    end

    function u109.GrabMiss(a1) -- Line: 513 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.Sound("HeavyLand", a1.At, 1, 1.2)
        Kit.ShakeFrom(a1.At, 4, 160)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.4)
    end

    function u109.Grab(a1) -- Line: 518 -- upvalues: Kit (upval), Players (upval), LocalPlayer (upval), u196 (val)
        Kit.Sound("Chomp", nil, 1.5, 0.6)
        Kit.Sound("Boom", nil, 0.8, 1.2)
        local PlayerByUserId = Players:GetPlayerByUserId(a1.UserId or 0)
        if a1.UserId ~= LocalPlayer.UserId then
            u196:Say(("SAVE %*!"):format((string.upper(PlayerByUserId and PlayerByUserId.DisplayName or "THEM"))), nil, 2.5)
            return
        end
        Kit.Shake(6, 18, 0.6)
        u196:FlashScreen(Kit.Red, 0.6, 0.4)
        u196:Say("YOU'VE BEEN GRABBED!", nil, 2)
    end

    function u109.GrabHit(a1_2) -- Line: 534 -- upvalues: a1 (val), Kit (upval)
        local v1 = a1:GetAttribute("GrabFree") or 0
        local v2 = math.max(a1:GetAttribute("GrabNeeded") or 1, 1)
        Kit.Sound("BatHit", nil, 1, 0.8 + v1 / v2 * 0.6)
        Kit.Shake(2, 20, 0.25)
    end

    function u109.GrabBreak(a1) -- Line: 540
        -- upvalues: Kit (upval), Vfx (upval), Players (upval), u196 (val), LocalPlayer (upval)
        Kit.Sound("Boom", a1.At, 1.2, 1.3)
        Kit.Sound("Pop", a1.At, 1.5)
        Kit.Shake(5, 16, 0.6)
        if a1.At then
            Vfx.Glitch(a1.At, 1.4, 0.35)
        end
        local PlayerByUserId = Players:GetPlayerByUserId(a1.UserId or 0)
        u196:Say(
            if a1.UserId ~= LocalPlayer.UserId then ("%* IS FREE!"):format((string.upper(PlayerByUserId and PlayerByUserId.DisplayName or "THEY"))) else "BROKE FREE!",
            nil,
            1.6
        )
    end

    function u109.Throw(a1) -- Line: 556 -- upvalues: Kit (upval), LocalPlayer (upval), u196 (val)
        Kit.Sound("Swoosh", nil, 2, 0.5)
        if a1.UserId == LocalPlayer.UserId then
            Kit.Shake(7, 14, 1)
            u196:FlashScreen(Color3.new(1, 1, 1), 0.35, 0.3)
        end
    end

    function u109.ThrowLand(a1) -- Line: 563 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.ShakeFrom(a1.At, 6, 180)
        Kit.Sound("HeavyLand", a1.At, 1.1)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.35)
    end

    function u109.MechHit(a1) -- Line: 568 -- upvalues: u198 (ref)
        if u198 then
            u198.Hit(a1.Overheated == true)
        end
    end

    function u109.Overheat(a1) -- Line: 573 -- upvalues: Kit (upval), u196 (val)
        Kit.Sound("DrScrambleOverheating", nil, 1)
        u196:Say("HE'S OVERHEATING! HIT HIM NOW!", nil, 3)
    end

    function u109.PhaseTwo(a1) -- Line: 577 -- upvalues: Kit (upval)
        Kit.Shake(5, 10, 1.5)
        Kit.Sound("Roar", nil, 1.2, 0.7)
    end

    function u109.Callout(a1) -- Line: 581 -- upvalues: u196 (val)
        u196:Say(a1.Text or "", a1.Speaker, a1.Seconds)
    end

    function u109.CrocWarn(a1) -- Line: 584 -- upvalues: u196 (val), Kit (upval)
        u196:Say("GET THEM!", "Dr. Scramble", 2)
        Kit.Sound("DrScrambleLaughing", nil, 1)
        for i = 0, 5 do
            task.delay(i * 0.3, function() -- Line: 588 -- upvalues: Kit (upval)
                Kit.Sound("Tick", nil, 1, 1.8)
            end)
        end
    end

    function u109.CrocLand(a1) -- Line: 593 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.ShakeFrom(a1.At, 8, 500)
        Kit.Sound("CrocShockwave", a1.At, 1.2)
        Vfx.Burst("CrocLeap", CFrame.new(floor(a1.At)), 1)
    end

    function u109:CrocTarget() -- Line: 598
        -- upvalues: LocalPlayer (upval), Kit (upval), u196 (val), ScrambleBossFlags (upval)
        if self.UserId == LocalPlayer.UserId then
            Kit.Sound("TargetLock", nil, 1)
        end
        u196:CrocTarget(self.UserId or 0, (ScrambleBossFlags.CrocChaseSeconds:Get()) + 0.6)
    end

    function u109.CrocBite(a1) -- Line: 607 -- upvalues: Kit (upval)
        Kit.Sound("ChaseBite", a1.At, 1.2)
        Kit.ShakeFrom(a1.At, 3.5, 140)
    end

    function u109.CrocSweep(a1_2) -- Line: 611 -- upvalues: Kit (upval), a1 (val), Vfx (upval)
        Kit.Sound("TailSweep", a1_2.At, 1.2)
        Kit.ShakeFrom(a1_2.At, 4, 200)
        local Croc = a1:FindFirstChild("Croc")
        local v1 = if not Croc then Vector3.new(0, 0, 1) else if not Croc:IsA("Model") then Vector3.new(0, 0, 1) else Kit.Flat(Croc:GetPivot().LookVector)
        local v2 = Vfx.CrocScale(a1)
        local At = a1_2.At
        local v3 = (Vfx.Ground(At, a1:GetAttribute("FloorY"))) + Vector3.new(0, 2.34 * v2, 0)
        Vfx.Burst("CrocTail", Vfx.Frame("CrocTail", v3, v1), v2 * 1.6)
    end

    function u109.CrocCharge(a1) -- Line: 622 -- upvalues: Kit (upval)
        Kit.Sound("Roar", a1.At, 1.2, 1.1)
    end

    function u109.CrocLeave(a1) -- Line: 625 -- upvalues: Vfx (upval), floor (val), Kit (upval), u196 (val)
        Vfx.Burst("CrocLeap", CFrame.new(floor(a1.At)), 0.6)
        Kit.Sound("DrScrambleLaughing", nil, 1)
        u196:Say("HAHAHA! GOOD BOY!", "Dr. Scramble", 2)
    end

    function u109.DroneSpawn(a1) -- Line: 630 -- upvalues: hold (val), Vfx (upval)
        hold(Vfx.Hold("DroneSummon", CFrame.new(a1.At)), 0.9)
    end

    function u109.DroneBoom(a1) -- Line: 633 -- upvalues: Vfx (upval), floor (val), Kit (upval)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.35)
        Kit.Sound("Boom", a1.At, 1)
        Kit.ShakeFrom(a1.At, 5, 80)
    end

    function u109.DroneHit(a1) -- Line: 638 -- upvalues: Kit (upval)
        Kit.Sound("BatHit", a1.At, 0.7, 1.25)
    end

    function u109.DronePop(a1) -- Line: 641 -- upvalues: Vfx (upval), Kit (upval)
        Vfx.Glitch(a1.At, 1.2, 0.3)
        Kit.Sound("BatHit", a1.At, 1)
    end

    function u109.EjectStart(a1) -- Line: 645 -- upvalues: u196 (val), Kit (upval), hold (val), Vfx (upval)
        u196:Say("SYSTEM FAILURE!", nil, 1.6)
        local v1 = a1.Open or 1.3
        Kit.Sound("DrScrambleEjecting", nil, 1)
        hold(Vfx.Hold("DroneSummon", CFrame.new(a1.At), 2.2), v1)
        Kit.Shake(2, 25, v1 + 0.4)
    end

    function u109.Eject(a1) -- Line: 652 -- upvalues: Vfx (upval), Kit (upval)
        Vfx.Glitch(a1.At, 2.2, 0.35)
        Kit.Shake(6, 16, 1.1)
    end

    function u109.MechWreck(a1_2) -- Line: 656 -- upvalues: a1 (val), hold (val), Vfx (upval)
        local Mech = a1:FindFirstChild("Mech")
        local v1 = 30
        if Mech and Mech:IsA("Model") then
            local BoundingBox_2
            _, BoundingBox_2 = Mech:GetBoundingBox()
            v1 = BoundingBox_2.Y * 0.45
        end
        local v2 = hold
        local Hold = Vfx.Hold
        local new = CFrame.new
        local At = a1_2.At
        v2(Hold("DroneSummon", new((Vfx.Ground(At, a1:GetAttribute("FloorY"))) + Vector3.new(0, v1, 0)), 3), a1_2.Seconds or 25)
    end

    function u109.MechDespawn(a1) -- Line: 672 -- upvalues: Vfx (upval), Kit (upval)
        Vfx.Glitch(a1.At, 3, 0.35)
        Kit.Sound("Pop", a1.At, 1.6)
    end

    function u109.SuitImpact(a1) -- Line: 676 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.Shake(12, 12, 2)
        Kit.Sound("HeavyLand", nil, 2)
        Kit.Sound("Boom", nil, 1.5)
        for i, j in a1.Points or {} do
            task.delay(i * 0.04, function() -- Line: 681 -- upvalues: j (val), Vfx (upval), floor (upval)
                Vfx.Burst("Slam", CFrame.new(floor(j)), 0.6)
            end)
        end
    end

    function u109.BallLand(a1) -- Line: 686 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        local v1 = if not a1.Big then 1 else 1.5
        Kit.ShakeFrom(a1.At, v1 * 10, 420)
        Kit.Sound("HeavyLand", a1.At, 1.6)
        Kit.Sound("Boom", a1.At, 1.1, 0.9)
        Vfx.Burst("CrocLeap", CFrame.new(floor(a1.At)), if not a1.Big then 0.5850000000000001 else 0.9)
    end

    function u109.BallBounce(a1) -- Line: 697 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.Sound("HeavyLand", a1.At, 0.7, 1.25)
        Kit.ShakeFrom(a1.At, 3, 200)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.3)
    end

    function u109.CoilsRise(a1_2) -- Line: 702 -- upvalues: Kit (upval), a1 (val), Vfx (upval), floor (val)
        local Attribute
        Kit.Sound("Rumble", nil, 1, 1.2)
        Kit.Shake(2, 20, 2.2)
        local Coils = a1:FindFirstChild("Coils")
        for i, j in if not Coils then {} else Coils:GetChildren() do
            Attribute = j:GetAttribute("Home")
            if typeof(Attribute) == "Vector3" then
                Vfx.Burst("CrocLeap", CFrame.new(floor(Attribute)), 0.45)
            end
        end
    end

    function u109.BallTarget(a1) -- Line: 713 -- upvalues: LocalPlayer (upval), Kit (upval), u196 (val)
        if a1.UserId == LocalPlayer.UserId then
            Kit.Sound("TargetLock", nil, 1)
            u196:FlashScreen(Kit.Red, 0.5, 0.35)
        end
    end

    function u109.BallBump(a1) -- Line: 719 -- upvalues: Kit (upval)
        Kit.ShakeFrom(a1.At, 5, 60)
        Kit.Sound("Boom", a1.At, 0.8, 1.3)
    end

    function u109.CoilZap(a1) -- Line: 723
        -- upvalues: coilTop (val), Kit (upval), zap (val), ballPosition (val), Vfx (upval), coilBurst (val), u195 (val)
        -- upvalues: coilBolts (upval), u117 (upval)
        local At = coilTop(a1.Coil or "")
        if not At then
            At = a1.At
        end
        Kit.Sound("Tesla", At, 1.5)
        Kit.ShakeFrom(At, 6, 300)
        zap(At, function() -- Line: 727 -- upvalues: ballPosition (upval), a1 (val)
            return (ballPosition(a1.At))
        end, 0.6)
        Vfx.Glitch(ballPosition(a1.At), 1.8, 0.6)
        coilBurst(a1.Coil or "")
        Vfx.Burst("LightningSurge", CFrame.new((ballPosition(a1.At))), 3)
        Vfx.Burst("LightningSurge", CFrame.new(At), 2)
        for i = 0, 5 do
            u195:Add((task.delay(i * 0.12, function() -- Line: 735 -- upvalues: coilBolts (upval), At (val), ballPosition (upval), a1 (val), u117 (upval)
                coilBolts(At, (ballPosition(a1.At)) + u117:NextUnitVector() * 3)
            end)))
        end
    end

    function u109.CoreHit(a1) -- Line: 743 -- upvalues: Kit (upval), Vfx (upval)
        Kit.Sound("BatHit", a1.At, 0.8, 0.8 + math.random() * 0.2)
        Kit.Sound("Zap", a1.At, 0.35, 1.3 + math.random() * 0.3)
        Vfx.Glitch(a1.At, 0.9, 0.2)
    end

    function u109.CoreCrack(a1) -- Line: 748 -- upvalues: Kit (upval), Vfx (upval), u196 (val)
        Kit.Sound("Zap", a1.At, 1.4, 0.8)
        Kit.Sound("HeavyLand", a1.At, 0.9, 1.3)
        Kit.Shake(4, 18, 0.8)
        Vfx.Glitch(a1.At, 1.8, 0.6)
        local v1 = a1.Stage or 1
        local v2 = a1.Needed or 3
        u196:Say(if v1 ~= 1 then if not (v1 < v2) then "CORE OVERLOADED!" else "CORE CRITICAL!" else "CORE DAMAGED!", nil, 1.8)
    end

    function u109.CoreBurst(a1) -- Line: 761 -- upvalues: Kit (upval), Vfx (upval), floor (val)
        Kit.Sound("Boom", a1.At, 1.2)
        Kit.Sound("Zap", a1.At, 2, 0.7)
        Kit.Shake(8, 16, 1.2)
        local At = a1.At
        Vfx.Burst("Slam", CFrame.new(floor(At)), 0.7)
        Vfx.Glitch(a1.At, 2.52, 0.7)
    end

    function u109.HumanHit(a1) -- Line: 768 -- upvalues: Kit (upval)
        Kit.Sound("BatHit", a1.At, 1.5)
        Kit.ShakeFrom(a1.At, 3, 80)
    end

    function u109.FinalHit(a1_2) -- Line: 772 -- upvalues: Cinematic (upval), u195 (val), a1 (val), u196 (val)
        task.spawn(Cinematic.FinalHit, u195, a1, u196, a1_2)
    end

    function u109.Defeated(a1) -- Line: 775 -- upvalues: u196 (val)
        u196:Say("DR. SCRAMBLE DEFEATED!", nil, 5)
    end

    u195:Connect(RunService.RenderStepped, Vfx.Sample)
    u195:Connect(Remotes.ScrambleBoss.Fx.OnClientEvent, function(a1, a2) -- Line: 781 -- upvalues: u109 (val) -- types: a1: string
        local v1 = u109[a1]
        if v1 then
            local success, err = pcall(v1, a2 or {})
            if not success then
                warn((("[ScrambleBoss] fx %* failed: %*"):format(a1, err)))
            end
        end
    end)
end

local function warmAssets() -- Line: 792 -- upvalues: ReplicatedStorage (val), ContentProvider (val)
    local v1
    local v2 = {ReplicatedStorage.CutsceneAssets.ScrambleBossCutsceneAssets}
    local v3 = {}
    local v4 = {
        MeshPart = true,
        Decal = true,
        Animation = true,
        ParticleEmitter = true,
        Beam = true,
        ImageLabel = true,
        Sound = true,
    }
    local v5 = nil
    local v6 = nil
    for i, j in v2, v5, v6 do
        for k, n in j:GetDescendants() do
            v1 = false
            for m in v4 do
                if n:IsA(m) then
                    v1 = true
                    break
                end
            end
            if v1 then
                table.insert(v3, n)
            end
        end
    end
    print((("[%*] Preloading %* assets"):format(script.Name, #v3)))
    ContentProvider:PreloadAsync(v3)
    print((("[%*] Preloading completed"):format(script.Name)))
end

task.spawn(function() -- Line: 832 -- upvalues: RunService (val), warmAssets (val)
    local v1 = os.time()
    if RunService:IsStudio() and v1 < 1790434800 then
        warmAssets()
        return
    end
    if v1 < 1790431200 then
        task.wait(1790431200 - v1)
        task.delay(math.random(180), warmAssets)
        return
    end
    if v1 < 1790434800 then
        task.delay(math.random(60), warmAssets)
    end
end)

local function joinAdminFight() -- Line: 849 -- upvalues: Transition (val), Remotes (val)
    Transition.Cover()
    local success, err = pcall(function() -- Line: 851 -- upvalues: Remotes (upval)
        return Remotes.ScrambleBoss.EnterArena:InvokeServer()
    end)
    if not success or err ~= true then
        Transition.Reveal()
    end
end

local v1 = {
    StartEvent = function(a1, a2, a3) -- Line: 861
        -- upvalues: Environment (val), ScrambleBossFlags (val), u114 (val), u120 (ref), u118 (ref), Workspace (val)
        -- upvalues: bindArena (val), joinAdminFight (val)
        local v1 = Environment.IsTestPlace()
        if v1 then
            v1 = false
            if a3 ~= nil then
                v1 = a3.Testing == true
            end
        end
        if not ScrambleBossFlags.ContentEnabled:Get() and not v1 then
            return
        end
        u114:Clean()
        u120 = false
        v1 = false
        if a3 ~= nil then
            v1 = type(a3.StarterUserId) == "number"
        end
        if v1 and a3 and not a3.SkipCutscenes then
            xpcall(function() -- Line: 872 -- upvalues: u114 (upval), u120 (upval)
                require(script.Cutscenes.IntroCutscene1)(u114).Run()
                require(script.Cutscenes.IntroCutscene2)(u114).Run()
                u114:Clean()
                u120 = true
            end, function(a1) -- Line: 881
                warn((("[%*] %*"):format(script.Name, a1)))
            end)
        end
        u118 = true
        local ScrambleArena = Workspace:FindFirstChild("ScrambleArena")
        if ScrambleArena and ScrambleArena:IsA("Model") then
            task.defer(bindArena, ScrambleArena)
        end
        u114:Connect(Workspace.ChildAdded, function(a1) -- Line: 893 -- upvalues: u118 (upval), bindArena (upval) -- types: a1: userdata
            if a1.Name == "ScrambleArena" and a1:IsA("Model") and u118 then
                task.defer(bindArena, a1)
            end
        end)
        if v1 then
            task.spawn(joinAdminFight)
        end
    end,
    StopEvent = function(a1) -- Line: 904 -- upvalues: u114 (val), u118 (ref), u120 (ref)
        u114:Clean()
        u118 = false
        if u120 then
            u120 = false
            xpcall(function() -- Line: 911 -- upvalues: u114 (upval)
                require(script.Cutscenes.OutroCutscene1)(u114).Run()
                require(script.Cutscenes.OutroCutscene2)(u114).Run()
                u114:Clean()
            end, function(a1) -- Line: 918
                warn((("[%*] %*"):format(script.Name, a1)))
            end)
        end
    end,
}
Transition.Listen()
return v1