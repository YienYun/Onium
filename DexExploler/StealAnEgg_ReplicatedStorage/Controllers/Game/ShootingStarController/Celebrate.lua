-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Celebrate
-- Decompile time: 30.49 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Buddy = require(script.Parent.Buddy)
require(script.Parent.CalmLoop)
local Fx = require(script.Parent.Fx)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u49 = {
    Catch = {Seconds = 5.4, Turns = 6, Sound = "StarOrbitCatch"},
    Gift = {Seconds = 4.8, Turns = 5, Sound = "StarOrbitGift"},
}
local LocalPlayer = Players.LocalPlayer
local u53 = {}
local v1 = {}

local function folder() -- Line: 72 -- upvalues: Workspace (val)
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if ShootingStarClient then
        return ShootingStarClient
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "ShootingStarClient"
    Folder.Parent = Workspace
    return Folder
end

local function smooth(a1) -- Line: 83 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function kitChild(a1) -- Line: 88 -- upvalues: Fx (val) -- types: a1: string
    local v1 = Fx.Kit()
    if v1 then
        return (v1:FindFirstChild(a1))
    end
    return nil
end

local function holdPoint(a1, a2) -- Line: 93 -- types: a1: userdata, a2: number
    local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart == nil then
        return nil
    end
    local LeftHand = a1:FindFirstChild("LeftHand")
    local RightHand = a1:FindFirstChild("RightHand")
    local Head = a1:FindFirstChild("Head")
    local Rotation = HumanoidRootPart.CFrame.Rotation
    if LeftHand and RightHand then
        return CFrame.new((LeftHand.Position + RightHand.Position) / 2 + Vector3.new(0, a2, 0)) * Rotation
    end
    if Head then
        return CFrame.new(Head.Position + Vector3.new(0, Head.Size.Y / 2 + a2 + 1, 0)) * Rotation
    end
    return CFrame.new(HumanoidRootPart.Position + Vector3.new(0, a2 + 4.5, 0)) * Rotation
end

local function emitterRate(a1, a2, a3) -- Line: 111 -- types: a1: userdata, a2: string, a3: number
    local PrimaryPart = a1.PrimaryPart
    local Core = PrimaryPart and PrimaryPart:FindFirstChild("Core")
    local v1 = Core and Core:FindFirstChild(a2)
    if v1 and v1:IsA("ParticleEmitter") then
        v1.Rate = a3
    end
end

local function playerTracks(a1) -- Line: 120 -- upvalues: Fx (val) -- types: a1: userdata
    local v1 = {}
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    local Animator = Humanoid
    if Animator then
        Animator = Humanoid:FindFirstChildOfClass("Animator")
    end
    local v2 = Fx.Kit()
    local v3 = if not v2 then nil else v2:FindFirstChild("PlayerAnimations")
    if Animator ~= nil and v3 ~= nil then
        local err, success
        for i, j in v3:GetChildren() do
            if j:IsA("Animation") then
                success, err = pcall(function() -- Line: 130 -- upvalues: Animator (val), j (val)
                    return Animator:LoadAnimation(j)
                end)
                if success and err then
                    err.Priority = Enum.AnimationPriority.Action
                    v1[j.Name] = err
                end
            end
        end
        return v1
    end
    return v1
end

local function speak(a1, a2, a3) -- Line: 142
    -- upvalues: LocalPlayer (val), ReplicatedStorage (val), MessageTyper (val)
    local PrimaryPart = a1.PrimaryPart
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local UI = Assets and Assets:FindFirstChild("UI")
    local v1 = UI and UI:FindFirstChild("Npcs")
    local Talk_UI = v1 and v1:FindFirstChild("Talk_UI")
    if PrimaryPart ~= nil and PlayerGui ~= nil and Talk_UI ~= nil and Talk_UI:IsA("BillboardGui") then
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        v1 = a3:Add((Instance.new("Attachment")))
        v1.Name = "StarGuySpeech"
        v1.Position = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
        v1.Parent = PrimaryPart
        local v2 = a3:Add((Talk_UI:Clone()))
        v2.Name = "StarGuySpeech"
        v2.Adornee = v1
        v2.MaxDistance = 45
        v2.Enabled = true
        v2.Parent = PlayerGui
        local v3 = v2:FindFirstChildOfClass("TextLabel")
        if v3 == nil then
            return
        end
        v3.Text = ""
        local u94 = MessageTyper.new(v3, nil, 0.06, false)
        a3:Add(function() -- Line: 170 -- upvalues: u94 (val)
            u94:Halt()
        end)
        u94:Type(a2, v3.TextColor3)
        return
    end
end

local function lobbyHandler(a1) -- Line: 176 -- upvalues: CollectionService (val) -- types: a1: userdata
    for i, j in CollectionService:GetTagged("StarHandlerNpc") do
        if j:IsA("Model")
            and j.PrimaryPart ~= nil
            and j:GetAttribute("StarHandlerLocallyHidden") ~= true
            and (j:GetPivot().Position - a1.Position).Magnitude <= 40 then
            return j
        end
    end
    return nil
end

local function giftIntro(a1, a2) -- Line: 190
    -- upvalues: Fx (val), lobbyHandler (val), speak (val), Workspace (val), Buddy (val), RunService (val)
    local v1 = Fx.Kit()
    local v2 = if not v1 then nil else v1:FindFirstChild("StarGuy")
    local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart")
    if v2 ~= nil and v2:IsA("Model") and HumanoidRootPart ~= nil then
        local v3, v4
        local v5 = lobbyHandler(HumanoidRootPart)
        if v5 then
            local Pivot = v5:GetPivot()
            local Scale = v5:GetScale()
            Fx.Emit("Reveal", Pivot.Position + Vector3.new(0, 4 * Scale / 0.62, 0), 0.6)
            Fx.Sound("BuddyGiggle", v5.PrimaryPart, 0.6, 0.9)
            speak(v5, "A little star, just for you!", a2)
            v3 = (HumanoidRootPart.Position - Pivot.Position) * Vector3.new(1, 0, 1)
            local Unit = if not (0.1 < v3.Magnitude) then Pivot.LookVector else v3.Unit
            return v5, Pivot.Position + Vector3.new(0, 4 * Scale / 0.62, 0) + Unit * 1.5, true
        end
        local u85 = v2:Clone()
        v2 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
        if v2.Magnitude < 0.001 then
            v2 = Vector3.new(0, 0, -1)
        end
        local v6 = HumanoidRootPart.Position + v2.Unit * 8
        v2 = RaycastParams.new()
        v2.FilterType = Enum.RaycastFilterType.Exclude
        local v7 = {}
        local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
        if not ShootingStarClient then
            local Folder = Instance.new("Folder")
            Folder.Name = "ShootingStarClient"
            Folder.Parent = Workspace
            v4 = Folder
        else
            v4 = ShootingStarClient
        end
        v7[1] = a1
        v7[2] = v4
        v2.FilterDescendantsInstances = v7
        v7 = Workspace:Raycast(v6 + Vector3.new(0, 20, 0), Vector3.new(0, -60, 0), v2)
        local Position_3 = if not v7 then v6 - Vector3.new(0, 3, 0) else v7.Position
        local u146 = CFrame.lookAt(Position_3, (Vector3.new(HumanoidRootPart.Position.X, Position_3.Y, HumanoidRootPart.Position.Z)))
        local u153 = u85:GetScale()
        u85:ScaleTo(u153 * 0.05)
        u85:PivotTo(u146)
        v1 = Workspace:FindFirstChild("ShootingStarClient")
        if not v1 then
            v1 = Instance.new("Folder")
            v1.Name = "ShootingStarClient"
            v1.Parent = Workspace
        end
        u85.Parent = v1
        a2:Add(u85)
        v3 = Buddy.Tracks(u85)
        if v3.Idle then
            v3.Idle:Play(0)
        end
        Fx.Emit("Reveal", Position_3 + Vector3.new(0, 3, 0), 1)
        Fx.Sound("BuddyPop", Position_3, 0.8, 0.85)
        local u213 = os.clock()
        local u214 = nil
        a2:Connect(RunService.RenderStepped, function() -- Line: 232 -- upvalues: u213 (val), u85 (val), u153 (val), u146 (val), u214 (ref)
            local v1 = math.clamp((os.clock() - u213) / 0.4, 0, 1)
            u85:ScaleTo((math.max(u153 * ((v1 - 1) ^ 3 * 2.70158 + 1 + (v1 - 1) ^ 2 * 1.70158), u153 * 0.05)))
            u85:PivotTo(u146)
            if v1 >= 1 then
                u214:Disconnect()
            end
        end)
        task.delay(0.45, function() -- Line: 242 -- upvalues: u85 (val), speak (upval), a2 (val)
            if u85.Parent then
                speak(u85, "A little star, just for you!", a2)
            end
        end)
        return u85, Position_3 + Vector3.new(0, 4 * u153 / 0.62, 0) + u146.LookVector * 1.5, false
    end
    return nil, nil, false
end

local function giftOutro(a1, a2) -- Line: 250 -- upvalues: Fx (val), RunService (val) -- types: a1: userdata
    local Scale = a1:GetScale()
    local Pivot = a1:GetPivot()
    local u9 = os.clock()
    Fx.Sound("BuddyGiggle", a1.PrimaryPart, 0.6, 0.85)
    local u17 = nil
    a2:Connect(RunService.RenderStepped, function() -- Line: 256 -- upvalues: u9 (val), a1 (val), Scale (val), Pivot (val), u17 (ref), Fx (upval)
        local v1 = math.clamp((os.clock() - u9) / 0.35, 0, 1)
        a1:ScaleTo((math.max(Scale * (1 - v1), 0.02)))
        a1:PivotTo(Pivot)
        if v1 >= 1 then
            u17:Disconnect()
            Fx.Emit("Collect", Pivot.Position + Vector3.new(0, 3, 0), 1)
            a1:Destroy()
        end
    end)
end

function v1:Play(a2) -- Line: 272
    -- upvalues: u53 (val), Workspace (val), LocalPlayer (val), Fx (val), Trove (val), giftIntro (val), Buddy (val)
    -- upvalues: u49 (val), playerTracks (val), RunService (val), holdPoint (val), giftOutro (val)
    local Character = self.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    if Character ~= nil and HumanoidRootPart ~= nil and not u53[self] then
        local CurrentCamera = Workspace.CurrentCamera
        if self ~= LocalPlayer
            and CurrentCamera
            and 320 < (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude then
            return
        end
        if Fx.KitReady() then
            local v1 = Fx.Kit()
            if (if not v1 then nil else v1:FindFirstChild("Buddy")) ~= nil then
                local v2
                u53[self] = true
                local u41 = Trove.new()
                u41:Add(function() -- Line: 300 -- upvalues: u53 (upval), self (val), a2 (val)
                    u53[self] = nil
                    if a2.OnDone then
                        task.spawn(a2.OnDone)
                    end
                end)
                u41:Connect(self.CharacterRemoving, function() -- Line: 306 -- upvalues: u41 (val)
                    u41:Destroy()
                end)
                local u56 = self == LocalPlayer
                local v3 = Fx.Kit()
                local u71 = (if not v3 then nil else v3:FindFirstChild("Buddy")):GetAttribute("HeldScale") or 0.42
                local u76 = v2:GetAttribute("HeldLift") or -0.7
                task.spawn(function() -- Line: 315
                    -- upvalues: a2 (val), giftIntro (upval), Character (val), u41 (val), HumanoidRootPart (val)
                    -- upvalues: Buddy (upval), Workspace (upval), u71 (val), Fx (upval), u49 (upval), u56 (val)
                    -- upvalues: playerTracks (upval), RunService (upval), holdPoint (upval), u76 (val)
                    -- upvalues: giftOutro (upval)
                    local Core_3, Core_4, Folder_2, PrimaryPart_4, PrimaryPart_5, PrimaryPart_6, ShootingStarClient_2, Spawn_2, u359, v1, v2, v3, v4, v5, v6
                    local u550 = nil
                    local From = a2.From
                    if a2.Kind == "Gift" then
                        local v7
                        v5, v7, v6 = giftIntro(Character, u41)
                        u550 = if not v6 then v5 else nil
                        From = v7
                        task.wait(2.2)
                        if HumanoidRootPart.Parent == nil then
                            u41:Destroy()
                            return
                        end
                    end
                    local Model = a2.Model
                    if not Model then
                        local v8
                        local Spawn = Buddy.Spawn
                        local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
                        if not ShootingStarClient then
                            local Folder = Instance.new("Folder")
                            Folder.Name = "ShootingStarClient"
                            Folder.Parent = Workspace
                            v8 = Folder
                        else
                            v8 = ShootingStarClient
                        end
                        v6 = Spawn(v8, CFrame.new(From or HumanoidRootPart.Position + Vector3.new(0, 3, 0)))
                        u359 = if a2.Kind ~= "Gift" then v6:GetScale() else u71 * 0.5
                        v6:ScaleTo(u359)
                        Fx.Emit("Reveal", v6:GetPivot().Position, 0.7)
                        Model = v6
                    else
                        u359 = Model:GetScale()
                    end
                    local u504 = Model
                    v5 = Workspace:FindFirstChild("ShootingStarClient")
                    if not v5 then
                        v5 = Instance.new("Folder")
                        v5.Name = "ShootingStarClient"
                        v5.Parent = Workspace
                    end
                    u504.Parent = v5
                    u41:Add(u504)
                    local PrimaryPart = u504.PrimaryPart
                    PrimaryPart.Anchored = true
                    local u478 = Buddy.CalmIdle(u504)
                    if u478 then
                        u478:Play(0.1)
                        u478:SetSpeed(1.4)
                    end
                    u41:Add(function() -- Line: 351 -- upvalues: u478 (val)
                        if u478 then
                            u478:Stop(0)
                        end
                    end)
                    local PrimaryPart_2 = u504.PrimaryPart
                    local Core = PrimaryPart_2 and PrimaryPart_2:FindFirstChild("Core")
                    local v9 = Core and Core:FindFirstChild("Twinkles")
                    if v9 and v9:IsA("ParticleEmitter") then
                        v9.Rate = 55
                    end
                    local PrimaryPart_3 = u504.PrimaryPart
                    local Core_2 = PrimaryPart_3 and PrimaryPart_3:FindFirstChild("Core")
                    v9 = Core_2 and Core_2:FindFirstChild("Stardust")
                    if v9 and v9:IsA("ParticleEmitter") then
                        v9.Rate = 18
                    end
                    v9 = math.clamp(math.floor(a2.Count or 1), 1, 10)
                    local u179 = {}
                    for i = 2, v9 do
                        Spawn_2 = Buddy.Spawn
                        ShootingStarClient_2 = Workspace:FindFirstChild("ShootingStarClient")
                        if not ShootingStarClient_2 then
                            Folder_2 = Instance.new("Folder")
                            Folder_2.Name = "ShootingStarClient"
                            Folder_2.Parent = Workspace
                            v2 = Folder_2
                        else
                            v2 = ShootingStarClient_2
                        end
                        v1 = Spawn_2(v2, PrimaryPart.CFrame)
                        v1:ScaleTo(u359 * 0.8)
                        u41:Add(v1)
                        PrimaryPart_4 = v1.PrimaryPart
                        PrimaryPart_4.Anchored = true
                        v3 = Buddy.CalmIdle(v1)
                        if v3 then
                            v3:Play(0.1)
                            v3:Seek(i * 0.37)
                        end
                        PrimaryPart_5 = v1.PrimaryPart
                        Core_3 = PrimaryPart_5 and PrimaryPart_5:FindFirstChild("Core")
                        v4 = Core_3 and Core_3:FindFirstChild("Twinkles")
                        if v4 and v4:IsA("ParticleEmitter") then
                            v4.Rate = 20
                        end
                        PrimaryPart_6 = v1.PrimaryPart
                        Core_4 = PrimaryPart_6 and PrimaryPart_6:FindFirstChild("Core")
                        v4 = Core_4 and Core_4:FindFirstChild("Stardust")
                        if v4 and v4:IsA("ParticleEmitter") then
                            v4.Rate = 6
                        end
                        table.insert(u179, {
                            Model = v1,
                            Idle = v3,
                            Root = PrimaryPart_4,
                            Offset = (i - 1) / v9 * 3.141592653589793 * 2,
                            Index = i,
                        })
                    end

                    local function haloFrame(a1, a2, a3) -- Line: 383 -- types: a1: table, a2: userdata, a3: number
                        local v1 = a1.Offset + a3 * 2.2
                        local v2 = Vector3.new(math.cos(v1), 0, (math.sin(v1))) * 1.7
                        return (CFrame.new(a2.Position + Vector3.new(0, (math.sin(a3 * 3 + a1.Index)) * 0.15 + 1.5, 0) + v2)) * a2.Rotation * CFrame.Angles(0, 0, math.sin(a3 * 5 + a1.Index) * 0.2)
                    end

                    local Position = PrimaryPart.Position
                    local v10 = Position - HumanoidRootPart.Position
                    local u383 = math.atan2(v10.Z, v10.X)
                    local u393 = math.clamp((Vector3.new(v10.X, 0, v10.Z)).Magnitude, 3, 9)
                    local Y = v10.Y
                    Fx.Sound("BuddyCaught", PrimaryPart, 0.75)
                    Fx.Sound("BuddyGiggle", PrimaryPart, 0.6, 1.25)
                    Fx.Emit("Collect", Position, 0.6)
                    local Catch = u49[a2.Kind] or u49.Catch
                    local Seconds = Catch.Seconds
                    local Turns = Catch.Turns
                    local u423 = 0
                    local u428 = if not u56 then {} else playerTracks(Character)
                    local u430 = os.clock()
                    if not u56 then
                        Fx.Sound(("%*Mono"):format(Catch.Sound), PrimaryPart, 0.7)
                    else
                        Fx.Sound(Catch.Sound, nil, 0.85)
                    end
                    local u451 = false
                    local u452 = false
                    local u453 = 0
                    local u454 = 0
                    u41:Connect(RunService.RenderStepped, function() -- Line: 418
                        -- upvalues: u451 (ref), HumanoidRootPart (upval), u430 (val), u478 (val), u179 (val)
                        -- upvalues: Seconds (val), Turns (val), u423 (ref), a2 (upval), u504 (val), u383 (val)
                        -- upvalues: u393 (val), holdPoint (upval), Character (upval), u76 (upval), Y (val), u359 (ref)
                        -- upvalues: u71 (upval), PrimaryPart (val), haloFrame (val), u452 (ref), u453 (ref), Fx (upval)
                        -- upvalues: u428 (val), u550 (ref), giftOutro (upval), u41 (upval), u454 (ref)
                        if not u451 and HumanoidRootPart.Parent ~= nil then
                            local Model, v1, v2, v3, v4, v5, v6
                            local v7 = os.clock() - u430
                            if u478 then
                                u478:Step(true)
                            end
                            local v8 = u179
                            local v9 = nil
                            local v10 = nil
                            for i, j in v8, v9, v10 do
                                if j.Idle then
                                    j.Idle:Step(true)
                                end
                            end
                            if not (v7 < Seconds) then
                                if not u452 then
                                    u452 = true
                                    u453 = os.clock()
                                    u504:ScaleTo(u71)
                                    local PrimaryPart_4 = u504.PrimaryPart
                                    local Core_3 = PrimaryPart_4 and PrimaryPart_4:FindFirstChild("Core")
                                    v7 = Core_3 and Core_3:FindFirstChild("Twinkles")
                                    if v7 and v7:IsA("ParticleEmitter") then
                                        v7.Rate = 22
                                    end
                                    local PrimaryPart_5 = u504.PrimaryPart
                                    local Core_4 = PrimaryPart_5 and PrimaryPart_5:FindFirstChild("Core")
                                    v9 = Core_4 and Core_4:FindFirstChild("Stardust")
                                    if v9 and v9:IsA("ParticleEmitter") then
                                        v9.Rate = 6
                                    end
                                    Fx.Emit("Reveal", PrimaryPart.Position, 0.35)
                                    if u428.Raise then
                                        u428.Raise:Play(0.08)
                                    end
                                    if u428.Hold then
                                        task.delay(0.3, function() -- Line: 503 -- upvalues: u451 (upval), u428 (upval)
                                            if not u451 then
                                                u428.Hold:Play(0.15)
                                            end
                                        end)
                                    end
                                    if a2.OnRaised then
                                        task.spawn(a2.OnRaised)
                                    end
                                    if u550 then
                                        task.delay(0.8, function() -- Line: 513 -- upvalues: u550 (upval), giftOutro (upval), u41 (upval)
                                            if u550.Parent then
                                                giftOutro(u550, u41)
                                            end
                                        end)
                                    end
                                end
                                v8 = os.clock() - u453
                                v9 = holdPoint(Character, u76)
                                if v8 < 2.8 then
                                    v10 = math.sin(v8 * 4) * 0.12
                                    v6 = math.sin(v8 * 7) * 0.10471975511965978
                                    PrimaryPart.CFrame = v9 * CFrame.new(0, v10, 0) * CFrame.Angles(0, 0, v6)
                                    v6 = os.clock()
                                    for i6, i7 in u179 do
                                        i7.Root.CFrame = haloFrame(i7, v9, v6)
                                    end
                                    return
                                end
                                if u454 == 0 then
                                    u454 = os.clock()
                                    Fx.Sound("BuddyStow", HumanoidRootPart, 0.7)
                                    for k, n in u428 do
                                        n:Stop(0.3)
                                    end
                                end
                                v8 = math.clamp((os.clock() - u454) / 0.45, 0, 1)
                                v10 = v8 * v8
                                v6 = v9.Position:Lerp(HumanoidRootPart.Position, v10)
                                u504:ScaleTo((math.max(u71 * (1 - v10), 0.02)))
                                PrimaryPart.CFrame = (CFrame.new(v6)) * v9.Rotation * CFrame.Angles(0, v8 * 8, 0)
                                v6 = os.clock()
                                for m, i5 in u179 do
                                    v1 = haloFrame(i5, v9, v6)
                                    i5.Root.CFrame = (CFrame.new(v1.Position:Lerp(HumanoidRootPart.Position, v10))) * CFrame.Angles(0, v8 * 8, 0)
                                    i5.Model:ScaleTo((math.max(u71 * 0.55 * (1 - v10), 0.02)))
                                end
                                if v8 >= 1 then
                                    u451 = true
                                    Fx.Emit("Collect", HumanoidRootPart.Position, 0.8)
                                    u41:Destroy()
                                end
                                return
                            end
                            v8 = v7 / Seconds
                            v10 = v8 ^ 1.9 * Turns
                            v6 = math.floor(v10)
                            if u423 < v6 then
                                u423 = math.floor(v10)
                                if a2.OnLap then
                                    task.spawn(a2.OnLap, u423)
                                end
                            end
                            v9 = math.clamp(1.9 * v8 ^ 0.8999999999999999, 0.2, 2.4)
                            v6 = u504
                            local v11 = v9 * 40 + 25
                            local PrimaryPart_2 = v6.PrimaryPart
                            local Core = PrimaryPart_2 and PrimaryPart_2:FindFirstChild("Core")
                            local v12 = Core and Core:FindFirstChild("Twinkles")
                            if v12 and v12:IsA("ParticleEmitter") then
                                v12.Rate = v11
                            end
                            v6 = u504
                            v11 = v9 * 10 + 6
                            local PrimaryPart_3 = v6.PrimaryPart
                            local Core_2 = PrimaryPart_3 and PrimaryPart_3:FindFirstChild("Core")
                            v12 = Core_2 and Core_2:FindFirstChild("Stardust")
                            if v12 and v12:IsA("ParticleEmitter") then
                                v12.Rate = v11
                            end
                            v9 = u383 + v10 * 3.141592653589793 * 2
                            v11 = math.clamp(v8 / 0.25, 0, 1)
                            v6 = v11 * v11 * (3 - v11 * 2)
                            v12 = math.clamp((v8 - 0.7) / 0.3, 0, 1)
                            v11 = v12 * v12 * (3 - v12 * 2)
                            v12 = u393 + (4.2 - u393) * v6
                            v12 = v12 + (2.4 - v12) * v11
                            local v13 = holdPoint(Character, u76)
                            local v14 = v13.Position.Y - HumanoidRootPart.Position.Y
                            local v15 = Y + (1.2 - Y) * v6
                            v6 = v15 + (v14 + 0.6 - v15) * v11 + math.sin(v10 * 3.141592653589793) * 0.6 * (1 - v11)
                            local Position = HumanoidRootPart.Position
                            v14 = Position + Vector3.new(math.cos(v9) * v12, v6, (math.sin(v9)) * v12)
                            v10 = Vector3.new(-math.sin(v9), 0, (math.cos(v9)))
                            v1 = math.clamp((v8 - 0.88) / 0.12, 0, 1)
                            v9 = v1 * v1 * (3 - v1 * 2)
                            v14 = v14:Lerp(v13.Position, v9)
                            v1 = u504
                            local v16 = u359
                            local v17 = u71 - u359
                            local v18 = math.clamp(v8, 0, 1)
                            v1:ScaleTo(v16 + v17 * (v18 * v18 * (3 - v18 * 2)))
                            PrimaryPart.CFrame = ((CFrame.lookAt(v14, v14 + v10)):Lerp((CFrame.new(v14)) * v13.Rotation, v9)) * CFrame.Angles(0, 0, math.sin(v7 * 9) * 0.25 * (1 - v9))
                            v1 = os.clock()
                            for i8, i9 in u179 do
                                v14 = u383 + ((math.clamp(v7 - i9.Index * 0.08, 0, Seconds)) / Seconds) ^ 1.9 * Turns * 3.141592653589793 * 2 + i9.Offset
                                v10 = v12 * (math.sin(i9.Index * 1.7) * 0.12 + 0.9)
                                v2 = v6 + math.sin(i9.Index * 2.3) * 0.7 * (1 - v11)
                                v18 = Position + Vector3.new(math.cos(v14) * v10, v2, (math.sin(v14)) * v10)
                                v2 = haloFrame(i9, v13, v1)
                                v14 = CFrame.lookAt(v18, v18 + (Vector3.new(-math.sin(v14), 0, (math.cos(v14)))))
                                i9.Root.CFrame = v14:Lerp(v2, v9)
                                Model = i9.Model
                                v3 = u359 * 0.8
                                v4 = u71 * 0.55 - u359 * 0.8
                                v5 = math.clamp(v8, 0, 1)
                                Model:ScaleTo(v3 + v4 * (v5 * v5 * (3 - v5 * 2)))
                            end
                            return
                        end
                    end)
                end)
                return
            end
        end
        if a2.OnDone then
            task.spawn(a2.OnDone)
        end
        return
    end
    if a2.Model then
        a2.Model:Destroy()
    end
    if a2.OnDone then
        task.spawn(a2.OnDone)
    end
end

function v1.IsPlaying(a1) -- Line: 560 -- upvalues: u53 (val) -- types: a1: userdata
    return u53[a1] == true
end

return v1