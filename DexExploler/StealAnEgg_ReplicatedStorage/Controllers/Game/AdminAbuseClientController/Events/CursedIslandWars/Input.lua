-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Input
-- Decompile time: 35.86 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Cinema = require(script.Parent.Cinema)
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local CursedIslandWarsFlags = require(ReplicatedStorage.Shared.Flags.CursedIslandWarsFlags)
local Fx = require(script.Parent.Fx)
local Ragdoll = require(ReplicatedStorage.Shared.Modules.Ragdoll)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local State = require(script.Parent.State)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Controls = require((LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("PlayerModule")):GetControls()
local Tuning = CursedIslandWars.Tuning
local Animations = CursedIslandWars.Assets.Animations
local VFX = CursedIslandWars.Assets.VFX
local u91 = {
    [Enum.KeyCode.One] = 1,
    [Enum.KeyCode.Two] = 2,
    [Enum.KeyCode.Three] = 3,
    [Enum.KeyCode.Four] = 4,
    [Enum.KeyCode.Five] = 5,
}
local u103 = Trove.new()
local u105 = Trove.new()
local u106 = {}
local u107 = {}
local u108 = {}
local u109 = {}
local u113 = setmetatable({}, {__mode = "k"})
local u114 = nil
local u115 = false
local u116 = 0
local u117 = 0
local u118 = 0
local u119 = nil
local u120 = 0
local u121 = {}

local function character() -- Line: 54 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    if Character == nil then
        return nil, nil, nil
    end
    return Character, (Character:FindFirstChildOfClass("Humanoid")), (Character:FindFirstChild("HumanoidRootPart"))
end

local function flat(a1) -- Line: 62 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

function u121.Cooldown(a1) -- Line: 66 -- upvalues: u106 (val) -- types: a1: string
    return u106[a1] or 0
end

function u121.SetCooldown(a1, a2) -- Line: 70 -- upvalues: u106 (val) -- types: a1: string, a2: number
    u106[a1] = a2
end

function u121.Equipped() -- Line: 74 -- upvalues: LocalPlayer (val), CursedIslandWars (val)
    local v1
    local Character = LocalPlayer.Character
    if Character ~= nil then
        v1 = Character
        Character:FindFirstChildOfClass("Humanoid")
        Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
    end
    local Tool = if not v1 then nil else v1:FindFirstChildOfClass("Tool")
    if Tool and table.find(CursedIslandWars.Tools, Tool.Name) then
        return Tool.Name
    end
    return nil
end

local function ready(a1) -- Line: 80 -- upvalues: State (val), u121 (val) -- types: a1: string
    local v1 = State.Me()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if v1.State == "Alive" then
            v2 = State.Armed()
            if v2 then
                local v3 = State.Now()
                v2 = u121.Cooldown(a1) <= v3
            end
        end
    end
    return v2
end

local function spend(a1, a2) -- Line: 85 -- upvalues: u106 (val), State (val) -- types: a1: string, a2: number
    u106[a1] = State.Now() + a2
end

function u121.Equip(a1) -- Line: 89
    -- upvalues: CursedIslandWars (val), LocalPlayer (val), State (val)
    local v1, v2
    local v3 = CursedIslandWars.Tools[a1]
    local Character = LocalPlayer.Character
    if Character ~= nil then
        v1 = Character
        v2 = Character:FindFirstChildOfClass("Humanoid")
        Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
        v2 = nil
    end
    local v4 = State.Me()
    if v1 ~= nil and v2 ~= nil and v3 ~= nil and v4 ~= nil and v4.State == "Alive" then
        local Tool = v1:FindFirstChildOfClass("Tool")
        if Tool and Tool.Name == v3 then
            v2:UnequipTools()
            return
        end
        local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
        v1 = if not Backpack then nil else Backpack:FindFirstChild(v3)
        if v1 and v1:IsA("Tool") then
            v2:EquipTool(v1)
        end
        return
    end
end

local function aimPoint() -- Line: 108
    -- upvalues: Workspace (val), UserInputService (val), u119 (ref), LocalPlayer (val), State (val)
    local CurrentCamera = Workspace.CurrentCamera
    local LastInputType = UserInputService:GetLastInputType()
    local v1 = true
    if LastInputType ~= Enum.UserInputType.MouseMovement then
        v1 = true
        if LastInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = LastInputType == Enum.UserInputType.Keyboard
        end
    end
    local v2 = if LastInputType ~= Enum.UserInputType.Touch then nil else u119
    local v3 = if not v1 then CurrentCamera.ViewportSize / 2 else UserInputService:GetMouseLocation()
    v1 = if not v2 then CurrentCamera:ViewportPointToRay(v3.X, v3.Y) else CurrentCamera:ScreenPointToRay(v2.X, v2.Y)
    v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v3 = {}
    local Character = LocalPlayer.Character
    if Character then
        table.insert(v3, Character)
    end
    local v4 = Workspace:FindFirstChild("CursedIslandWarsFx")
    if v4 then
        table.insert(v3, v4)
    end
    v4 = State.Island()
    if v4 then
        table.insert(v3, v4.Bounds)
    end
    v2.FilterDescendantsInstances = v3
    v3 = Workspace:Raycast(v1.Origin, v1.Direction * 400, v2)
    if v3 then
        return v3.Position
    end
    return v1.Origin + v1.Direction * 400
end

local function clampedTarget(a1) -- Line: 138 -- upvalues: LocalPlayer (val), aimPoint (val) -- types: a1: number
    local v1
    local Character = LocalPlayer.Character
    if Character ~= nil then
        Character:FindFirstChildOfClass("Humanoid")
        v1 = Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
    end
    if v1 == nil then
        return nil
    end
    local v2 = aimPoint()
    local v3 = v2 - v1.Position
    local v4 = Vector3.new(v3.X, 0, v3.Z)
    if a1 < v4.Magnitude then
        v2 = v1.Position + v4.Unit * a1 + Vector3.new(0, 1, 0) * (v2.Y - v1.Position.Y)
    end
    return v2
end

local function onMarker(a1, a2, a3) -- Line: 151 -- upvalues: u108 (val) -- types: a1: string, a2: number, a3: function
    u108[a1] = a3
    task.delay(a2 + 0.25, function() -- Line: 153 -- upvalues: u108 (upval), a1 (val), a3 (val)
        if u108[a1] == a3 then
            u108[a1] = nil
            a3()
        end
    end)
end

local function rootBriefly() -- Line: 162 -- upvalues: u120 (ref), Controls (val)
    local u2 = os.clock() + 0.8
    u120 = u2
    Controls:Disable()
    task.delay(0.8, function() -- Line: 166 -- upvalues: u120 (upval), u2 (val), Controls (upval)
        if u120 == u2 then
            Controls:Enable()
        end
    end)
end

local function hideFor(a1, a2) -- Line: 174 -- types: a1: userdata, a2: number
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Transparency = 1
        end
    end
    task.delay(a2, function() -- Line: 180 -- upvalues: a1 (val)
        for i, j in a1:GetDescendants() do
            if j:IsA("BasePart") then
                j.Transparency = 0
            end
        end
    end)
end

local function play(a1, a2) -- Line: 189 -- upvalues: u107 (val) -- types: a1: string, a2: number?
    local v1 = u107[a1]
    if v1 then
        v1:Play(a2 or 0.1)
    end
end

local function fireLauncher(a1) -- Line: 196
    -- upvalues: State (val), u121 (val), aimPoint (val), CursedIslandWarsFlags (val), u106 (val), u117 (ref), Fx (val)
    -- upvalues: VFX (val), hideFor (val), TweenService (val), u107 (val), Cinema (val), Remotes (val)
    local v1 = State.Me()
    if v1 ~= nil then
        local v2 = State.Me()
        local v3 = false
        if v2 ~= nil then
            v3 = false
            if v2.State == "Alive" then
                v3 = State.Armed()
                if v3 then
                    local v4 = State.Now()
                    v3 = u121.Cooldown("PumpkinLauncher") <= v4
                end
            end
        end
        if v3 then
            local Handle = a1.Handle
            local Muzzle = Handle.Muzzle
            local WorldPosition = Muzzle.WorldPosition
            local v5 = aimPoint() - WorldPosition
            local Unit = if not (0.5 < v5.Magnitude) then Muzzle.WorldCFrame.LookVector else v5.Unit
            v5 = CursedIslandWarsFlags.LauncherCooldown:Get()
            u106.PumpkinLauncher = State.Now() + v5
            u117 = u117 + 1
            Fx.Launch(("%*:%*"):format(v1.Id, u117), WorldPosition, Unit * CursedIslandWarsFlags.LauncherSpeed:Get(), State.Now(), v1.Team)
            for i, j in {
                Muzzle.WorldCFrame,
                Handle.BackBlast.WorldCFrame * CFrame.Angles(0, 3.141592653589793, 0),
            } do
                local u153 = Fx.Welded(VFX.V4_LauncherMuzzle, Handle, j)
                Fx.Burst(u153, "MuzzleBurst")
                task.delay(0.8, function() -- Line: 214 -- upvalues: u153 (val)
                    u153:Destroy()
                end)
            end
            hideFor(a1.Pumpkin, v5)
            local BarrelWeld = a1.Barrel.BarrelWeld
            local C0 = BarrelWeld.C0
            BarrelWeld.C0 = C0 * CFrame.new(0, 0, 0.35)
            TweenService:Create(BarrelWeld, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {C0 = C0}):Play()
            local Fire = u107.Fire
            if Fire then
                Fire:Play(0.05)
            end
            Cinema.Shake(0.08)
            Remotes.IslandWars.Use:FireServer("Launch", u117, WorldPosition, Unit)
            return
        end
    end
end

local function plantMine(a1) -- Line: 229
    -- upvalues: State (val), u121 (val), CursedIslandWarsFlags (val), u106 (val), u107 (val), u120 (ref)
    -- upvalues: Controls (val), hideFor (val), Remotes (val), u108 (val)
    local v1 = State.Me()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if v1.State == "Alive" then
            v2 = State.Armed()
            if v2 then
                local v3 = State.Now()
                v2 = u121.Cooldown("Landmine") <= v3
            end
        end
    end
    if not v2 then
        return
    end
    local u25 = CursedIslandWarsFlags.MineCooldown:Get()
    u106.Landmine = State.Now() + u25
    local Mine = u107.Mine
    if Mine then
        Mine:Play(0.1)
    end
    local u39 = os.clock() + 0.8
    u120 = u39
    Controls:Disable()
    task.delay(0.8, function() -- Line: 166 -- upvalues: u120 (upval), u39 (val), Controls (upval)
        if u120 == u39 then
            Controls:Enable()
        end
    end)

    local function u48() -- Line: 237 -- upvalues: hideFor (upval), a1 (val), u25 (val), Remotes (upval)
        hideFor(a1, u25)
        Remotes.IslandWars.Use:FireServer("Mine")
    end

    u108.Place = u48
    local delay_2 = task.delay
    local u55 = "Place"
    delay_2(0.667, function() -- Line: 153 -- upvalues: u108 (upval), u55 (val), u48 (val)
        if u108[u55] == u48 then
            u108[u55] = nil
            u48()
        end
    end)
end

local function placeWall() -- Line: 244
    -- upvalues: u114 (ref), u115 (ref), State (val), u121 (val), CursedIslandWarsFlags (val), u106 (val), u107 (val)
    -- upvalues: u120 (ref), Controls (val), Remotes (val), u108 (val)
    local u0 = u114
    local u1 = u115
    if u0 ~= nil then
        local v1 = State.Me()
        local v2 = false
        if v1 ~= nil then
            v2 = false
            if v1.State == "Alive" then
                v2 = State.Armed()
                if v2 then
                    local v3 = State.Now()
                    v2 = u121.Cooldown("WallBuilder") <= v3
                end
            end
        end
        if v2 then
            v2 = CursedIslandWarsFlags.WallCooldown:Get()
            u106.WallBuilder = State.Now() + v2
            local Place = u107.Place
            if Place then
                Place:Play(0.1)
            end
            local u40 = os.clock() + 0.8
            u120 = u40
            Controls:Disable()
            task.delay(0.8, function() -- Line: 166 -- upvalues: u120 (upval), u40 (val), Controls (upval)
                if u120 == u40 then
                    Controls:Enable()
                end
            end)

            local function u49() -- Line: 253 -- upvalues: Remotes (upval), u0 (val), u1 (val)
                Remotes.IslandWars.Use:FireServer("Wall", u0, u1)
            end

            u108.Slam = u49
            local delay_2 = task.delay
            local u57 = "Slam"
            delay_2(0.583, function() -- Line: 153 -- upvalues: u108 (upval), u57 (val), u49 (val)
                if u108[u57] == u49 then
                    u108[u57] = nil
                    u49()
                end
            end)
            return
        end
    end
end

local function placePad() -- Line: 258
    -- upvalues: State (val), u121 (val), Tuning (val), LocalPlayer (val), aimPoint (val), CursedIslandWarsFlags (val)
    -- upvalues: u106 (val), u107 (val), u120 (ref), Controls (val), Remotes (val), u108 (val)
    local u66, v1, v2
    local v3 = State.Me()
    local v4 = false
    if v3 ~= nil then
        v4 = false
        if v3.State == "Alive" then
            v4 = State.Armed()
            if v4 then
                v1 = State.Now()
                v4 = u121.Cooldown("JumpPad") <= v1
            end
        end
    end
    if not v4 then
        return
    end
    local Range = Tuning.Pad.Range
    local Character = LocalPlayer.Character
    if Character ~= nil then
        Character:FindFirstChildOfClass("Humanoid")
        v2 = Character:FindFirstChild("HumanoidRootPart")
    else
        v2 = nil
    end
    if v2 ~= nil then
        local v5 = aimPoint()
        local v6 = v5 - v2.Position
        v1 = Vector3.new(v6.X, 0, v6.Z)
        if Range < v1.Magnitude then
            v5 = v2.Position + v1.Unit * Range + Vector3.new(0, 1, 0) * (v5.Y - v2.Position.Y)
        end
        u66 = v5
    else
        u66 = nil
    end
    if u66 == nil then
        return
    end
    v3 = CursedIslandWarsFlags.PadCooldown:Get()
    u106.JumpPad = State.Now() + v3
    local Pad = u107.Pad
    if Pad then
        Pad:Play(0.1)
    end
    local u86 = os.clock() + 0.8
    u120 = u86
    Controls:Disable()
    task.delay(0.8, function() -- Line: 166 -- upvalues: u120 (upval), u86 (val), Controls (upval)
        if u120 == u86 then
            Controls:Enable()
        end
    end)

    local function u95() -- Line: 269 -- upvalues: Remotes (upval), u66 (val)
        Remotes.IslandWars.Use:FireServer("Pad", u66)
    end

    u108.Place = u95
    local delay_2 = task.delay
    local u100 = "Place"
    delay_2(0.625, function() -- Line: 153 -- upvalues: u108 (upval), u100 (val), u95 (val)
        if u108[u100] == u95 then
            u108[u100] = nil
            u95()
        end
    end)
end

local function nearestEnemy(a1) -- Line: 274 -- upvalues: State (val) -- types: a1: userdata
    local v1 = State.Me()
    local Snapshot = State.Snapshot
    if v1 ~= nil and Snapshot ~= nil then
        local HumanoidRootPart, Model
        local v2 = nil
        local v3 = (1 / 0)
        local v4 = nil
        local v5 = nil
        for i, j in Snapshot.Entries, v4, v5 do
            Model = if j.Team == v1.Team then nil else if j.State ~= "Alive" then nil else j.Model
            HumanoidRootPart = if not Model then nil else Model:FindFirstChild("HumanoidRootPart")
            if (if not HumanoidRootPart then (1 / 0) else (HumanoidRootPart.Position - a1.Position).Magnitude) < v3 then
                v2 = HumanoidRootPart
            end
        end
        return v2
    end
    return nil
end

local function swingBat(a1) -- Line: 293
    -- upvalues: LocalPlayer (val), Ragdoll (val), State (val), u121 (val), CursedIslandWarsFlags (val), u106 (val)
    -- upvalues: u107 (val), Remotes (val), nearestEnemy (val)
    local v1, v2, v3
    local Character = LocalPlayer.Character
    if Character ~= nil then
        v1 = Character
        v2 = Character:FindFirstChildOfClass("Humanoid")
        v3 = Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
        v2 = nil
        v3 = nil
    end
    if v1 ~= nil and v2 ~= nil and v3 ~= nil and not Ragdoll.IsRagdolled(v1) then
        local v4 = State.Me()
        local v5 = false
        if v4 ~= nil then
            v5 = false
            if v4.State == "Alive" then
                v5 = State.Armed()
                if v5 then
                    local v6 = State.Now()
                    v5 = u121.Cooldown("Bat") <= v6
                end
            end
        end
        if v5 then
            v5 = CursedIslandWarsFlags.BatCooldown:Get()
            u106.Bat = State.Now() + v5
            local Swing = u107.Swing
            if Swing == nil then
                Swing = (v2:FindFirstChildOfClass("Animator")):LoadAnimation(a1.HitAnim)
                Swing.Priority = Enum.AnimationPriority.Action
                u107.Swing = Swing
            end
            Swing:Play(0.05)
            Remotes.IslandWars.Use:FireServer("Swing", (nearestEnemy(v3)))
            return
        end
    end
end

local function activate(a1) -- Line: 309
    -- upvalues: swingBat (val), fireLauncher (val), plantMine (val), placeWall (val), placePad (val)
    if a1.Name == "Bat" then
        swingBat(a1)
        return
    end
    if a1.Name == "PumpkinLauncher" then
        fireLauncher(a1)
        return
    end
    if a1.Name == "Landmine" then
        plantMine(a1)
        return
    end
    if a1.Name == "WallBuilder" then
        placeWall()
        return
    end
    if a1.Name == "JumpPad" then
        placePad()
    end
end

local function watchTool(a1) -- Line: 323
    -- upvalues: CursedIslandWars (val), u113 (val), u103 (ref), activate (val), u107 (val)
    if a1:IsA("Tool") and table.find(CursedIslandWars.Tools, a1.Name) and not u113[a1] then
        u113[a1] = true
        u103:Add((a1.Activated:Connect(function() -- Line: 328 -- upvalues: activate (upval), a1 (val)
            activate(a1)
        end)))
        if a1.Name == "PumpkinLauncher" then
            u103:Add((a1.Equipped:Connect(function() -- Line: 332 -- upvalues: u107 (upval)
                local Hold = u107.Hold
                if Hold then
                    Hold:Play(0.15)
                end
            end)))
            u103:Add((a1.Unequipped:Connect(function() -- Line: 335 -- upvalues: u107 (upval)
                local Hold = u107.Hold
                if Hold then
                    Hold:Stop(0.15)
                end
            end)))
        end
        return
    end
end

local function clearGhosts() -- Line: 344 -- upvalues: u109 (val), u114 (ref), u116 (ref)
    for i, j in u109 do
        j.Transparency = 1
    end
    u114 = nil
    u116 = 0
end

local function stepGhost() -- Line: 352
    -- upvalues: LocalPlayer (val), State (val), u121 (val), u109 (val), u114 (ref), u116 (ref), Players (val)
    -- upvalues: CursedIslandWars (val), aimPoint (val), u115 (ref), Tuning (val), Workspace (val)
    local v1
    local Character = LocalPlayer.Character
    if Character ~= nil then
        Character:FindFirstChildOfClass("Humanoid")
        v1 = Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
    end
    local v2 = State.Island()
    local v3 = State.Me()
    if u121.Equipped() == "WallBuilder" and v1 ~= nil and v2 ~= nil and v3 ~= nil and v3.State == "Alive" then
        if State.Now() < u121.Cooldown("WallBuilder") then
            for n, m in u109 do
                m.Transparency = 1
            end
            u114 = nil
            u116 = 0
            return
        end
        if os.clock() < u116 then
            return
        end
        u116 = os.clock() + 0.1
        local v4 = {v2.Parent}
        for i, j in Players:GetPlayers() do
            if j.Character then
                table.insert(v4, j.Character)
            end
        end
        local v5, v6, v7 = CursedIslandWars.WallSearch(v2, v4, v1.Position, (aimPoint()))
        u114 = v5
        u115 = v6
        local Color = CursedIslandWars.Teams[v3.Team].Color
        for k = 1, (math.max(#v7, #u109)) do
            v5 = u109[k]
            if v5 == nil then
                v5 = Instance.new("Part")
                v5.Anchored = true
                v5.CanCollide = false
                v5.CanQuery = false
                v5.CanTouch = false
                v5.CastShadow = false
                v5.Material = Enum.Material.ForceField
                v5.Size = Vector3.new(1, 1, 1) * Tuning.Brick.Size
                v5.Parent = Workspace.CurrentCamera
                u109[k] = v5
            end
            v4 = v7[k]
            v5.Transparency = if not v4 then 1 else 0.2
            if v4 then
                v5.CFrame = v4
                v5.Color = Color
            end
        end
        return
    end
    for i5, i6 in u109 do
        i6.Transparency = 1
    end
    u114 = nil
    u116 = 0
end

local function launch(a1, a2, a3, a4) -- Line: 401
    -- upvalues: u118 (ref), CursedIslandWarsFlags (val), Fx (val), LocalPlayer (val), Cinema (val), u107 (val)
    -- upvalues: u103 (ref), Remotes (val)
    local Unit
    os.clock()
    local MoveDirection = a3.MoveDirection
    if not (0.1 < MoveDirection.Magnitude) then
        local LookVector = a2.CFrame.LookVector
        Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
    else
        Unit = MoveDirection.Unit
    end
    a2.AssemblyLinearVelocity = Unit * CursedIslandWarsFlags.PadLaunchForward:Get() + Vector3.new(0, 1, 0) * CursedIslandWarsFlags.PadLaunchUp:Get()
    a3:ChangeState(Enum.HumanoidStateType.Freefall)
    Fx.PadLaunch(a1, LocalPlayer.Character, a4)
    Cinema.Kick(12)
    local Launch = u107.Launch
    if Launch then
        Launch:Play(0.1)
    end
    local u59 = nil
    u59 = a3.StateChanged:Connect(function(a1, a2_2) -- Line: 411 -- upvalues: u59 (ref), u107 (upval), Fx (upval), a2 (val)
        if a2_2 == Enum.HumanoidStateType.Landed then
            u59:Disconnect()
            local Launch = u107.Launch
            if Launch then
                Launch:Stop(0.2)
            end
            Fx.PadLand(a2.Position - Vector3.new(0, 3, 0))
        end
    end)
    u103:Add(u59)
    Remotes.IslandWars.Use:FireServer("Launched", a1)
end

local function stepPads() -- Line: 425 -- upvalues: LocalPlayer (val), State (val), u118 (ref), launch (val)
    local v1, v2
    local Character = LocalPlayer.Character
    if Character ~= nil then
        v1 = Character:FindFirstChildOfClass("Humanoid")
        v2 = Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
        v2 = nil
    end
    local v3 = State.Me()
    local v4 = State.Island()
    if v2 ~= nil
        and v1 ~= nil
        and v3 ~= nil
        and v3.State == "Alive"
        and v4 ~= nil
        and not (os.clock() - u118 < 0.8) then
        local v5
        local Parent = v4.Parent and v4.Parent:FindFirstChild("Pads")
        if Parent == nil then
            return
        end
        for i, j in Parent:GetChildren() do
            if j:IsA("Model") and (j:GetAttribute("Team")) == v3.Team then
                v5 = j.Trigger.CFrame:PointToObjectSpace(v2.Position)
                if (math.abs(v5.X)) <= 2.4 and (math.abs(v5.Z)) <= 2.4 and -2 < v5.Y and v5.Y < 4.5 then
                    launch(j, v2, v1, v3.Team)
                    return
                end
            end
        end
        return
    end
end

local function bindCharacter(a1) -- Line: 449
    -- upvalues: u105 (ref), u107 (val), Animations (val), u108 (val), watchTool (val)
    u105:Clean()
    table.clear(u107)
    local Animator = a1:WaitForChild("Humanoid"):WaitForChild("Animator")
    for i, j in {
        Hold = Animations.LauncherHold,
        Fire = Animations.LauncherFire,
        Place = Animations.WallPlace,
        Pad = Animations.PadPlace,
        Mine = Animations.MinePlace,
        Launch = Animations.PadLaunchPose,
    } do
        local u112 = Animator:LoadAnimation(j)
        u107[i] = u112
        u105:Add(function() -- Line: 464 -- upvalues: u112 (val)
            u112:Stop(0)
        end)
    end
    for k, n in {[u107.Place] = "Slam", [u107.Pad] = "Place", [u107.Mine] = "Place"} do
        u105:Add(((k:GetMarkerReachedSignal(n)):Connect(function() -- Line: 469 -- upvalues: u108 (upval), n (val)
            local v1 = u108[n]
            u108[n] = nil
            if v1 then
                v1()
            end
        end)))
    end
    u105:Add((a1.ChildAdded:Connect(watchTool)))
    for m, i5 in a1:GetChildren() do
        watchTool(i5)
    end
    local Tool = a1:FindFirstChildOfClass("Tool")
    if Tool and Tool.Name == "PumpkinLauncher" then
        local Hold = u107.Hold
        if Hold then
            Hold:Play(0.1)
        end
    end
end

local function passOwnBarrier(a1) -- Line: 488 -- upvalues: State (val)
    local v1 = State.Me()
    local v2 = if not a1 then nil else if not v1 then nil else a1.Barriers[v1.Team]
    if v2 and 0 < v2.Health then
        v2.Model.Hitbox.CanCollide = false
    end
end

function u121.Knock(a1) -- Line: 496 -- upvalues: LocalPlayer (val) -- types: a1: vector
    local v1, v2
    local Character = LocalPlayer.Character
    if Character ~= nil then
        v1 = Character:FindFirstChildOfClass("Humanoid")
        v2 = Character:FindFirstChild("HumanoidRootPart")
    else
        v1 = nil
        v2 = nil
    end
    if v2 and v1 then
        v2.AssemblyLinearVelocity = v2.AssemblyLinearVelocity * 0.25 + a1
        if 5 < a1.Y then
            v1:ChangeState(Enum.HumanoidStateType.Freefall)
        end
    end
end

function u121.Start(a1) -- Line: 506
    -- upvalues: u103 (ref), u105 (ref), u106 (val), u108 (val), u113 (val), StarterGui (val), u109 (val), u114 (ref)
    -- upvalues: LocalPlayer (val), watchTool (val), bindCharacter (val), State (val), passOwnBarrier (val)
    -- upvalues: UserInputService (val), u119 (ref), u91 (val), u121 (val), CursedIslandWars (val), RunService (val)
    -- upvalues: stepGhost (val), stepPads (val)
    u103 = a1:Extend()
    u103:Extend()
    table.clear(u106)
    table.clear(u108)
    table.clear(u113)
    local v1 = StarterGui
    pcall(StarterGui.SetCore, v1, "ResetButtonCallback", false)
    u103:Add(function() -- Line: 513 -- upvalues: StarterGui (upval), u109 (upval), u114 (upval)
        local v1 = StarterGui
        pcall(StarterGui.SetCore, v1, "ResetButtonCallback", true)
        for i, j in u109 do
            j:Destroy()
        end
        table.clear(u109)
        u114 = nil
    end)
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    u103:Add((LocalPlayer.ChildAdded:Connect(function(a1) -- Line: 522 -- upvalues: u103 (upval), watchTool (upval) -- types: a1: userdata
        if a1:IsA("Backpack") then
            u103:Add((a1.ChildAdded:Connect(watchTool)))
        end
    end)))
    u103:Add((Backpack.ChildAdded:Connect(watchTool)))
    for i, j in Backpack:GetChildren() do
        watchTool(j)
    end
    if LocalPlayer.Character then
        task.spawn(bindCharacter, LocalPlayer.Character)
    end
    u103:Add((LocalPlayer.CharacterAdded:Connect(bindCharacter)))
    u103:Add((State.Changed:Connect(passOwnBarrier)))
    local Snapshot = State.Snapshot
    local v2 = State.Me()
    v1 = if not Snapshot then nil else if not v2 then nil else Snapshot.Barriers[v2.Team]
    if v1 and 0 < v1.Health then
        v1.Model.Hitbox.CanCollide = false
    end
    u103:Add((UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 537
        -- upvalues: u119 (upval), u91 (upval), u121 (upval), CursedIslandWars (upval)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.Touch then
            u119 = a1.Position
        end
        local v1 = u91[a1.KeyCode]
        if v1 then
            u121.Equip(v1)
            return
        end
        if a1.KeyCode == Enum.KeyCode.ButtonR1 or a1.KeyCode == Enum.KeyCode.ButtonL1 then
            local v2 = table.find(CursedIslandWars.Tools, u121.Equipped() or "") or 0
            local v3 = if a1.KeyCode ~= Enum.KeyCode.ButtonR1 then -1 else 1
            u121.Equip((v2 - 1 + v3) % #CursedIslandWars.Tools + 1)
        end
    end)))
    u103:Add((RunService.RenderStepped:Connect(function() -- Line: 553 -- upvalues: stepGhost (upval), stepPads (upval)
        stepGhost()
        stepPads()
    end)))
end

return u121