-- Script path: ReplicatedStorage.Controllers.Game.PetMountController
-- Decompile time: 62.60 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local PetMountFlags = require(ReplicatedStorage.Shared.Flags.PetMountFlags)
local PetMountGeometry = require(ReplicatedStorage.Shared.Modules.PetMountGeometry)
local NightFangHeight = require(ReplicatedStorage.Shared.Modules.NightFangHeight)
local u35 = nil
local u36 = nil
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u41 = nil
local u42 = nil
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local v1 = {}
local u49 = false
local u50 = {}
local u51 = {}
local u52 = {}
local u53 = {}
local u54 = nil
local u55 = 0
local u56 = nil

local function basePets() -- Line: 24 -- upvalues: u41 (ref)
    if u41 == nil then
        u41 = require(script.Parent.Plots.ActiveAssetsController)
    end
    return u41
end

local function acknowledge(a1, a2, a3) -- Line: 28 -- upvalues: Players (val), Remotes (val)
    if a1 ~= Players.LocalPlayer then
        return
    end
    local Attribute = a2:GetAttribute("Token")
    task.spawn(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), a3 (val)
        local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), a3 (upval)
            Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = a3})
        end)
        if not success then
            warn("Pet mount acknowledgement failed: " .. tostring(err))
        end
    end)
end

local function playTransition(a1, a2) -- Line: 39
    -- upvalues: ModelBounds (val), PetMountFlags (val), u42 (ref), ReplicatedStorage (val), Players (val)
    if a1.Parent and a1.Character == a2.Character and not (a2.Humanoid.Health <= 0) then
        local success, err, u12, u13 = pcall(function() -- Line: 41 -- upvalues: ModelBounds (upval), a2 (val), PetMountFlags (upval)
            local v1, v2 = ModelBounds(a2.Rig)
            return v1, v2, PetMountFlags.IKDistance:Get()
        end)
        if not success then
            return
        end
        task.defer(function() -- Line: 46
            -- upvalues: u42 (upval), ReplicatedStorage (upval), err (val), u12 (val), u13 (val), a1 (val)
            -- upvalues: Players (upval)
            local success, err_2 = pcall(function() -- Line: 47
                -- upvalues: u42 (upval), ReplicatedStorage (upval), err (upval), u12 (upval), u13 (upval), a1 (upval)
                -- upvalues: Players (upval)
                if u42 == nil then
                    u42 = require(ReplicatedStorage.Shared.Modules.PetMountEffects)
                end
                local Play = u42.Play
                local v1 = a1 == Players.LocalPlayer
                Play(err, u12, u13, v1)
            end)
            if not success then
                warn("Pet mount effect skipped: " .. tostring(err_2))
            end
        end)
        return
    end
end

local function cleanup(a1, a2) -- Line: 55 -- upvalues: u51 (val), NightFangHeight (val), playTransition (val)
    local v1 = u51[a1]
    if not v1 then
        return
    end
    u51[a1] = nil
    NightFangHeight.Reset(v1.AnimationHeight)
    if v1.JumpGated and v1.Humanoid.Parent then
        v1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
    if a2 then
        playTransition(a1, v1)
    end
    for i, j in v1.IKs do
        j.Enabled = false
        j:Destroy()
    end
    for k, n in v1.Targets do
        n:Destroy()
    end
    for m, i5 in v1.Tracks do
        i5:Stop(0)
        i5:Destroy()
    end
    for i6, i7 in v1.PoseJoints do
        if i7.Parent then
            i7.Transform = CFrame.identity
        end
    end
    if v1.RootMotor and v1.RootMotor.Parent and v1.LastC0 and v1.RootMotor.C0 == v1.LastC0 then
        v1.RootMotor.C0 = v1.OriginalC0
    end
    if v1.RootAttachment and v1.RootAttachment.Parent and v1.LastC0 and v1.RootAttachment.CFrame == v1.LastC0 then
        v1.RootAttachment.CFrame = v1.OriginalC0
    end
    if v1.SeatFollower then
        v1.SeatFollower:Destroy()
    end
    v1.Rig:Destroy()
end

local function clearTarget(a1) -- Line: 80 -- upvalues: cleanup (val), u50 (val), u41 (ref)
    cleanup(a1, true)
    local v1 = u50[a1]
    if v1 and v1.UID then
        if u41 == nil then
            u41 = require(script.Parent.Plots.ActiveAssetsController)
        end
        u41.SetMountedPet(a1.UserId, v1.UID, false)
    end
    u50[a1] = nil
end

local function suppressBase(a1, a2) -- Line: 86 -- upvalues: u41 (ref)
    local Attribute = a2.Model:GetAttribute("UID")
    if typeof(Attribute) == "string" and Attribute ~= a2.UID then
        if a2.UID then
            if u41 == nil then
                u41 = require(script.Parent.Plots.ActiveAssetsController)
            end
            u41.SetMountedPet(a1.UserId, a2.UID, false)
        end
        a2.UID = Attribute
        if u41 == nil then
            u41 = require(script.Parent.Plots.ActiveAssetsController)
        end
        u41.SetMountedPet(a1.UserId, Attribute, true)
    end
end

local function newTarget(a1, a2) -- Line: 94 -- upvalues: u50 (val), cleanup (val), u41 (ref), suppressBase (val)
    if u50[a1] and u50[a1].Model == a2 then
        return
    end
    cleanup(a1, true)
    local v1 = u50[a1]
    if v1 and v1.UID then
        if u41 == nil then
            u41 = require(script.Parent.Plots.ActiveAssetsController)
        end
        u41.SetMountedPet(a1.UserId, v1.UID, false)
    end
    u50[a1] = nil
    u50[a1] = {Model = a2, AddedAt = os.clock()}
    suppressBase(a1, u50[a1])
end

local function loadTrack(a1, a2, a3) -- Line: 100
    if not a2 then
        return nil
    end
    local success, err = pcall(function() -- Line: 102 -- upvalues: a1 (val), a2 (val), a3 (val)
        local v1 = a1:LoadAnimation(a2)
        v1.Priority = a3
        v1.Looped = true
        return v1
    end)
    return success and err or nil
end

local function build(a1, a2) -- Line: 110
    -- upvalues: u35 (ref), ReplicatedStorage (val), u36 (ref), HttpService (val), u54 (ref), PetMountGeometry (val)
    -- upvalues: NightFangHeight (val), PetMountFlags (val), u51 (val), cleanup (val)
    if u35 == nil then
        u35 = require(ReplicatedStorage.Shared.Modules.AssetRigFactory)
    end
    if u36 == nil then
        u36 = require(ReplicatedStorage.Data.Assets)
    end
    local Character = a1.Character
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    local Carrier = a2:FindFirstChild("Carrier")
    local RiderSeat = a2:FindFirstChild("RiderSeat")
    local PetRecord = a2:FindFirstChild("PetRecord")
    local Attribute = a2:GetAttribute("ModelScale")
    local Attribute_2 = a2:GetAttribute("Seat")
    if Humanoid and HumanoidRootPart and Carrier and RiderSeat and PetRecord and Attribute and Attribute_2 then
        local u60 = HttpService:JSONDecode(PetRecord.Value)
        if not ReplicatedStorage.AssetModels:FindFirstChild(u60.Category) then
            return nil
        end
        u60.Scale = 1
        local u69 = nil
        local u70 = nil
        local success, result = xpcall(function() -- Line: 128
            -- upvalues: u69 (ref), u35 (upval), u60 (val), Attribute (val), a1 (val), a2 (val), Attribute_2 (val)
            -- upvalues: HumanoidRootPart (val), u54 (upval), u70 (ref), Carrier (val), RiderSeat (val), Character (val)
            -- upvalues: Humanoid (val), PetMountGeometry (upval), NightFangHeight (upval), PetMountFlags (upval)
            -- upvalues: u36 (upval)
            u69 = u35.Build(u60, true)
            u69:ScaleTo(Attribute)
            u69.Name = "MountedPet_" .. a1.UserId
            u69:SetAttribute("UID", (a2:GetAttribute("UID")))
            u69:SetAttribute("OwnerUserId", a1.UserId)
            for i, j in u69:GetDescendants() do
                if j:IsA("LuaSourceContainer")
                    or j:IsA("Humanoid")
                    or j:IsA("Tool")
                    or j:IsA("ProximityPrompt")
                    or j:IsA("ClickDetector")
                    or j:IsA("BillboardGui") then
                    j:Destroy()
                elseif j:IsA("BasePart") then
                    j.CanCollide = false
                    j.CanTouch = false
                    j.CanQuery = false
                    j.Massless = true
                    j.Anchored = false
                elseif j:IsA("Sound") then
                    j:Stop()
                end
            end
            u69.PrimaryPart.Anchored = true
            u69.PrimaryPart.PivotOffset = CFrame.identity
            local v1 = u69.PrimaryPart.CFrame:ToObjectSpace((u69:GetPivot()))
            local v2 = (CFrame.new(0, -1, 0)) * Attribute_2:Inverse()
            u69:PivotTo(HumanoidRootPart.CFrame * v2 * v1)
            u69:SetAttribute("MountOwnsAnimationHeight", true)
            u69.Parent = u54
            local v3 = {[u69.PrimaryPart] = true}
            for k, n in u69.PrimaryPart:GetConnectedParts(true) do
                v3[n] = true
            end
            for m, i5 in u69:GetDescendants() do
                if i5:IsA("BasePart") and not v3[i5] then
                    i5.Anchored = true
                end
            end
            u70 = {
                Rig = u69,
                Root = HumanoidRootPart,
                Carrier = Carrier,
                RiderSeat = RiderSeat,
                Model = a2,
                Character = Character,
                Humanoid = Humanoid,
                RootToPivot = v1,
                RiderToPet = v2,
                IKs = {},
                Targets = {},
                Tracks = {},
                Grips = {},
                PoseJoints = {},
                Seat = PetMountGeometry.EnsureSeat(u69, Attribute_2),
                RestSeat = Attribute_2,
                SeatLocal = Attribute_2,
            }
            u70.AnimationHeight = NightFangHeight.New(u69)
            u70.AuthoredSeat = u70.Seat.CFrame
            local Attribute_4 = u69:GetAttribute("MountMaximumAnimationSeatOffset")
            u70.SeatTravelLimit = if typeof(Attribute_4) ~= "number" then nil else if not PetMountGeometry.IsFinite(Attribute_4) then nil else math.clamp(Attribute_4, 0, 32)
            local Attribute_5 = u69:GetAttribute("MountMaximumSeatTiltDegrees")
            u70.SeatTiltLimit = if typeof(Attribute_5) ~= "number" then 180 else if not PetMountGeometry.IsFinite(Attribute_5) then 180 else math.clamp(Attribute_5, 0, 180)
            for i6, i7 in Character:GetDescendants() do
                if i7:IsA("Motor6D")
                    and i7.Part0
                    and i7.Part1
                    and i7.Part0.Parent == Character
                    and i7.Part1.Parent == Character then
                    table.insert(u70.PoseJoints, i7)
                end
            end
            local Part = Instance.new("Part")
            u70.SeatFollower = Part
            Part.Name = "MountedSeat_" .. a1.UserId
            Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
            Part.Transparency = 1
            Part.Anchored = false
            Part.Massless = true
            Part.CanCollide = false
            Part.CanTouch = false
            Part.CanQuery = false
            Part.CFrame = PetMountGeometry.AnimatedWorld(u70.Seat)
            v2 = Instance.new("Attachment")
            v2.Name = "RiderSeatAttachment"
            v2.Parent = Part
            v1 = Instance.new("RigidConstraint")
            v1.Name = "MountSeatConstraint"
            v1.Attachment0 = u70.Seat
            v1.Attachment1 = v2
            v1.Parent = Part
            Part.Parent = u54
            local LowerTorso = Character:FindFirstChild("LowerTorso")
            local v4 = nil
            local v5 = nil
            local v6 = LowerTorso and LowerTorso:GetChildren() or {}
            local v7 = nil
            local v8 = nil
            for i8, i9 in v6, v7, v8 do
                if i9.Name == "Root" and i9:IsA("Motor6D") then
                    v4 = i9
                end
                if i9.Name == "Root" and i9:IsA("AnimationConstraint") and i9.Attachment0 then
                    v5 = i9
                end
            end
            if v4 then
                u70.RootMotor = v4
                u70.OriginalC0 = v4.C0
            elseif v5 then
                u70.RootAttachment = v5.Attachment0
                u70.OriginalC0 = v5.Attachment0.CFrame
            end
            local UpperTorso = Character:FindFirstChild("UpperTorso")
            if LowerTorso and UpperTorso then
                v4 = Instance.new("Attachment")
                v4.Name = "PetMountTorsoTarget"
                v4.CFrame = CFrame.Angles(-math.rad((PetMountFlags.TorsoLeanDegrees:Get())), 0, 0)
                v4.Parent = HumanoidRootPart
                v2 = Instance.new("IKControl")
                v2.Name = "PetMountTorso"
                v2.Type = Enum.IKControlType.Rotation
                v2.ChainRoot = LowerTorso
                v2.EndEffector = UpperTorso
                v2.Target = v4
                v2.Priority = 0
                v2.SmoothTime = 0
                v2.Enabled = false
                v2.Parent = Humanoid
                u70.TorsoIK = v2
                u70.TorsoTarget = v4
                table.insert(u70.IKs, v2)
                table.insert(u70.Targets, v4)
            end

            local function grip(a1, a2, a3, a4, a5) -- Line: 237
                -- upvalues: PetMountGeometry (upval), u69 (upval), u70 (upval), Character (upval)
                -- upvalues: HumanoidRootPart (upval), Humanoid (upval)
                local v1 = PetMountGeometry.EnsureGrip(u69, a4, a5, u70.Seat)
                local v2 = Character:FindFirstChild(a1 .. "Upper" .. a2)
                local v3 = Character:FindFirstChild(a1 .. "Lower" .. a2)
                local v4 = Character:FindFirstChild(a1 .. a3)
                if v2 and v4 then
                    local Attachment = Instance.new("Attachment")
                    Attachment.Name = "PetMount" .. a1 .. a2 .. "Target"
                    Attachment.Parent = HumanoidRootPart
                    local IKControl = Instance.new("IKControl")
                    IKControl.Name = "PetMount" .. a1 .. a2
                    IKControl.Type = Enum.IKControlType.Position
                    IKControl.Priority = 1
                    IKControl.ChainRoot = v2
                    IKControl.EndEffector = v4
                    IKControl.Target = Attachment
                    IKControl.SmoothTime = 0
                    if a2 == "Leg" then
                        local Attachment_2 = Instance.new("Attachment")
                        Attachment_2.Name = "PetMount" .. a1 .. "KneePole"
                        Attachment_2.CFrame = CFrame.new(if a1 ~= "Left" then 1 else -1, -1, -3)
                        Attachment_2.Parent = HumanoidRootPart
                        IKControl.Pole = Attachment_2
                        table.insert(u70.Targets, Attachment_2)
                    end
                    IKControl.Enabled = false
                    IKControl.Parent = Humanoid
                    table.insert(u70.IKs, IKControl)
                    table.insert(u70.Targets, Attachment)
                    local v5, v6 = PetMountGeometry.LimbReach(v2, v3, v4, a1, a2)
                    table.insert(u70.Grips, {
                        Attachment = v1,
                        Target = Attachment,
                        IK = IKControl,
                        Upper = v2,
                        Origin = v5,
                        Reach = v6,
                        SeatOffset = u70.Seat.CFrame:ToObjectSpace(v1.CFrame),
                    })
                end
            end

            grip(
                "Left",
                "Arm",
                "Hand",
                "MountLeftHand",
                a2:GetAttribute("LeftHand") or Attribute_2 * PetMountGeometry.DefaultGripOffsets.MountLeftHand
            )
            grip(
                "Right",
                "Arm",
                "Hand",
                "MountRightHand",
                a2:GetAttribute("RightHand") or Attribute_2 * PetMountGeometry.DefaultGripOffsets.MountRightHand
            )
            grip(
                "Left",
                "Leg",
                "Foot",
                "MountLeftFoot",
                a2:GetAttribute("LeftFoot") or Attribute_2 * PetMountGeometry.DefaultGripOffsets.MountLeftFoot
            )
            grip(
                "Right",
                "Leg",
                "Foot",
                "MountRightFoot",
                a2:GetAttribute("RightFoot") or Attribute_2 * PetMountGeometry.DefaultGripOffsets.MountRightFoot
            )
            local AnimationController = u69:FindFirstChildWhichIsA("AnimationController", true)
            if not AnimationController then
                AnimationController = Instance.new("AnimationController")
                AnimationController.Parent = u69
            end
            local u431 = AnimationController:FindFirstChildOfClass("Animator")
            if not u431 then
                u431 = Instance.new("Animator")
                u431.Parent = AnimationController
            end
            v5 = u36.Directory[u60.Category]
            u70.WalkReferenceSpeed = v5.WalkAnimationReferenceSpeed
            u70.AnimationSpeed = 0
            v6 = u70
            local Idle = v5.Animations.Idle
            local Idle_2 = Enum.AnimationPriority.Idle
            if Idle then
                local success, err = pcall(function() -- Line: 102 -- upvalues: u431 (val), Idle (val), Idle_2 (val)
                    local v1 = u431:LoadAnimation(Idle)
                    v1.Priority = Idle_2
                    v1.Looped = true
                    return v1
                end)
                v7 = success and err or nil
            else
                v7 = nil
            end
            v6.Idle = v7
            v6 = u70
            local Walk = v5.Animations.Walk
            local Movement = Enum.AnimationPriority.Movement
            if Walk then
                local success_2, err_2 = pcall(function() -- Line: 102 -- upvalues: u431 (val), Walk (val), Movement (val)
                    local v1 = u431:LoadAnimation(Walk)
                    v1.Priority = Movement
                    v1.Looped = true
                    return v1
                end)
                v7 = success_2 and err_2 or nil
            else
                v7 = nil
            end
            v6.Walk = v7
            v6 = {u70.Idle, u70.Walk}
            for i10, i11 in v6 do
                if i11 then
                    table.insert(u70.Tracks, i11)
                end
            end
            if u70.Idle then
                u70.Idle:Play(0.15)
            end
            local Animator = Humanoid:FindFirstChildOfClass("Animator")
            if Animator then
                v3 = Character:FindFirstChild("Animate")
                v1 = v3 and v3:FindFirstChild("sit")
                local u527 = v1
                if u527 then
                    u527 = v1:FindFirstChildWhichIsA("Animation")
                end
                v6 = nil
                if not u527 then
                    v6 = Instance.new("Animation")
                    v6.AnimationId = "rbxassetid://507768133"
                    u527 = v6
                end
                local Action = Enum.AnimationPriority.Action
                if u527 then
                    local success_3, err_3 = pcall(function() -- Line: 102 -- upvalues: Animator (val), u527 (val), Action (val)
                        local v1 = Animator:LoadAnimation(u527)
                        v1.Priority = Action
                        v1.Looped = true
                        return v1
                    end)
                    v1 = success_3 and err_3 or nil
                else
                    v1 = nil
                end
                if v6 then
                    v6:Destroy()
                end
                if v1 then
                    v1:Play(0.15)
                    table.insert(u70.Tracks, v1)
                end
            end
        end, debug.traceback)
        if not success then
            if u70 then
                u51[a1] = u70
                cleanup(a1)
            elseif u69 then
                u69:Destroy()
            end
            error(result)
        end
        return u70
    end
    return nil
end

local function distanceTo(a1, a2) -- Line: 308 -- upvalues: Players (val)
    local Character = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Carrier = a2:FindFirstChild("Carrier")
    return Character and Carrier and (Character.Position - Carrier.Position).Magnitude or (1 / 0)
end

local function maintain() -- Line: 313
    -- upvalues: Players (val), u56 (ref), Remotes (val), u50 (val), cleanup (val), u41 (ref), suppressBase (val)
    -- upvalues: PetMountFlags (val), u51 (val), u53 (val), build (val), playTransition (val)
    local Attribute_2, Carrier, Character_2, Magnitude, Model, err, spawn_2, spawn_3, success, v1, v2
    local Character = Players.LocalPlayer.Character
    if Character
        and Character ~= u56
        and Character:FindFirstChildOfClass("Humanoid")
        and Character:FindFirstChild("HumanoidRootPart") then
        u56 = Character
        task.spawn(function() -- Line: 317 -- upvalues: Remotes (upval), Character (val), u56 (upval)
            local success, err = pcall(function() -- Line: 318 -- upvalues: Remotes (upval), Character (upval)
                local v1 = Character
                return Remotes.PetMount.Request:InvokeServer("prepare", v1)
            end)
            if not success then
                if u56 == Character then
                    u56 = nil
                end
            elseif not err and u56 == Character then
                u56 = nil
            end
        end)
    end
    local v3 = false
    local v4 = nil
    local v5 = nil
    for i, j in u50, v4, v5 do
        Model = j.Model
        if not i.Parent or not i.Character then
            cleanup(i, true)
            v2 = u50[i]
            if v2 and v2.UID then
                if u41 == nil then
                    u41 = require(script.Parent.Plots.ActiveAssetsController)
                end
                u41.SetMountedPet(i.UserId, v2.UID, false)
            end
            u50[i] = nil
        elseif Model.Parent == i.Character then
            suppressBase(i, j)
            Attribute_2 = Model:GetAttribute("Token")
            Character_2 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            Carrier = Model:FindFirstChild("Carrier")
            Magnitude = Character_2 and Carrier and (Character_2.Position - Carrier.Position).Magnitude or (1 / 0)
            if i == Players.LocalPlayer then
                if u51[i] == nil and not v3 and Attribute_2 and u53[i] ~= Attribute_2 then
                    success, err = pcall(build, i, Model)
                    if not success then
                        if not success then
                            u53[i] = Attribute_2
                            if i == Players.LocalPlayer then
                                local Attribute = Model:GetAttribute("Token")
                                spawn_3 = task.spawn
                                local u149 = false
                                spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                    local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                        Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                    end)
                                    if not success then
                                        warn("Pet mount acknowledgement failed: " .. tostring(err))
                                    end
                                end)
                            end
                            if not success then
                                warn("Pet mount render failed: " .. tostring(err))
                            end
                        else
                            v1 = os.clock() - j.AddedAt
                            if PetMountFlags.ClientBuildTimeout:Get() - 1 < v1 then
                                u53[i] = Attribute_2
                                if i == Players.LocalPlayer then
                                    local Attribute = Model:GetAttribute("Token")
                                    spawn_3 = task.spawn
                                    local u149 = false
                                    spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                        local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                            Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                        end)
                                        if not success then
                                            warn("Pet mount acknowledgement failed: " .. tostring(err))
                                        end
                                    end)
                                end
                                if not success then
                                    warn("Pet mount render failed: " .. tostring(err))
                                end
                            end
                        end
                    elseif err then
                        u51[i] = err
                        if i == Players.LocalPlayer then
                            local u105 = Model:GetAttribute("Token")
                            spawn_2 = task.spawn
                            local u107 = true
                            spawn_2(function() -- Line: 31 -- upvalues: Remotes (upval), u105 (val), u107 (val)
                                local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), u105 (upval), u107 (upval)
                                    Remotes.PetMount.Request:InvokeServer("ready", {Token = u105, Success = u107})
                                end)
                                if not success then
                                    warn("Pet mount acknowledgement failed: " .. tostring(err))
                                end
                            end)
                        end
                        if not j.PoofPlayed then
                            j.PoofPlayed = true
                            playTransition(i, err)
                        end
                    elseif not success then
                        u53[i] = Attribute_2
                        if i == Players.LocalPlayer then
                            local Attribute = Model:GetAttribute("Token")
                            spawn_3 = task.spawn
                            local u149 = false
                            spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                    Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                end)
                                if not success then
                                    warn("Pet mount acknowledgement failed: " .. tostring(err))
                                end
                            end)
                        end
                        if not success then
                            warn("Pet mount render failed: " .. tostring(err))
                        end
                    else
                        v1 = os.clock() - j.AddedAt
                        if PetMountFlags.ClientBuildTimeout:Get() - 1 < v1 then
                            u53[i] = Attribute_2
                            if i == Players.LocalPlayer then
                                local Attribute = Model:GetAttribute("Token")
                                spawn_3 = task.spawn
                                local u149 = false
                                spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                    local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                        Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                    end)
                                    if not success then
                                        warn("Pet mount acknowledgement failed: " .. tostring(err))
                                    end
                                end)
                            end
                            if not success then
                                warn("Pet mount render failed: " .. tostring(err))
                            end
                        end
                    end
                end
            elseif PetMountFlags.RenderDistance:Get() < Magnitude then
                cleanup(i)
            elseif u51[i] == nil and not v3 and Attribute_2 and u53[i] ~= Attribute_2 then
                success, err = pcall(build, i, Model)
                if not success then
                    if not success then
                        u53[i] = Attribute_2
                        if i == Players.LocalPlayer then
                            local Attribute = Model:GetAttribute("Token")
                            spawn_3 = task.spawn
                            local u149 = false
                            spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                    Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                end)
                                if not success then
                                    warn("Pet mount acknowledgement failed: " .. tostring(err))
                                end
                            end)
                        end
                        if not success then
                            warn("Pet mount render failed: " .. tostring(err))
                        end
                    else
                        v1 = os.clock() - j.AddedAt
                        if PetMountFlags.ClientBuildTimeout:Get() - 1 < v1 then
                            u53[i] = Attribute_2
                            if i == Players.LocalPlayer then
                                local Attribute = Model:GetAttribute("Token")
                                spawn_3 = task.spawn
                                local u149 = false
                                spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                    local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                        Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                    end)
                                    if not success then
                                        warn("Pet mount acknowledgement failed: " .. tostring(err))
                                    end
                                end)
                            end
                            if not success then
                                warn("Pet mount render failed: " .. tostring(err))
                            end
                        end
                    end
                elseif err then
                    u51[i] = err
                    if i == Players.LocalPlayer then
                        local u105 = Model:GetAttribute("Token")
                        spawn_2 = task.spawn
                        local u107 = true
                        spawn_2(function() -- Line: 31 -- upvalues: Remotes (upval), u105 (val), u107 (val)
                            local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), u105 (upval), u107 (upval)
                                Remotes.PetMount.Request:InvokeServer("ready", {Token = u105, Success = u107})
                            end)
                            if not success then
                                warn("Pet mount acknowledgement failed: " .. tostring(err))
                            end
                        end)
                    end
                    if not j.PoofPlayed then
                        j.PoofPlayed = true
                        playTransition(i, err)
                    end
                elseif not success then
                    u53[i] = Attribute_2
                    if i == Players.LocalPlayer then
                        local Attribute = Model:GetAttribute("Token")
                        spawn_3 = task.spawn
                        local u149 = false
                        spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                            local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                            end)
                            if not success then
                                warn("Pet mount acknowledgement failed: " .. tostring(err))
                            end
                        end)
                    end
                    if not success then
                        warn("Pet mount render failed: " .. tostring(err))
                    end
                else
                    v1 = os.clock() - j.AddedAt
                    if PetMountFlags.ClientBuildTimeout:Get() - 1 < v1 then
                        u53[i] = Attribute_2
                        if i == Players.LocalPlayer then
                            local Attribute = Model:GetAttribute("Token")
                            spawn_3 = task.spawn
                            local u149 = false
                            spawn_3(function() -- Line: 31 -- upvalues: Remotes (upval), Attribute (val), u149 (val)
                                local success, err = pcall(function() -- Line: 32 -- upvalues: Remotes (upval), Attribute (upval), u149 (upval)
                                    Remotes.PetMount.Request:InvokeServer("ready", {Token = Attribute, Success = u149})
                                end)
                                if not success then
                                    warn("Pet mount acknowledgement failed: " .. tostring(err))
                                end
                            end)
                        end
                        if not success then
                            warn("Pet mount render failed: " .. tostring(err))
                        end
                    end
                end
            end
        else
            cleanup(i, true)
            v2 = u50[i]
            if v2 and v2.UID then
                if u41 == nil then
                    u41 = require(script.Parent.Plots.ActiveAssetsController)
                end
                u41.SetMountedPet(i.UserId, v2.UID, false)
            end
            u50[i] = nil
        end
    end
end

local function applySeatPose(a1) -- Line: 351 -- upvalues: PetMountFlags (val), PetMountGeometry (val)
    local RootMotor = a1.RootMotor or a1.RootAttachment
    if RootMotor and RootMotor.Parent then
        if PetMountFlags.StabilizeSeat:Get() then
            a1.SeatLocal = PetMountGeometry.ClampAnimatedSeat(
                a1.RestSeat,
                a1.SeatLocal,
                a1.SeatTravelLimit or PetMountFlags.MaximumAnimationSeatOffset:Get(),
                (math.min(PetMountFlags.MaximumSeatTiltDegrees:Get(), a1.SeatTiltLimit))
            )
        end
        a1.LastC0 = (a1.Root.CFrame:ToObjectSpace(a1.Root.CFrame * a1.RiderToPet * a1.SeatLocal * (CFrame.new(0, 1, 0)))) * a1.OriginalC0
        if a1.RootMotor then
            a1.RootMotor.C0 = a1.LastC0
            a1.LastC0 = a1.RootMotor.C0
            return
        end
        a1.RootAttachment.CFrame = a1.LastC0
        a1.LastC0 = a1.RootAttachment.CFrame
    end
end

local function stabilizeSeat(a1) -- Line: 371 -- upvalues: PetMountFlags (val), PetMountGeometry (val)
    local TransformedWorldCFrame = a1.Seat.Parent.TransformedWorldCFrame
    local CFrame = a1.Rig.PrimaryPart.CFrame
    local v1 = CFrame:ToObjectSpace(TransformedWorldCFrame * a1.AuthoredSeat)
    local v2 = v1
    if PetMountFlags.StabilizeSeat:Get() then
        v2 = PetMountGeometry.ClampAnimatedSeat(
            a1.RestSeat,
            v1,
            a1.SeatTravelLimit or PetMountFlags.MaximumAnimationSeatOffset:Get(),
            (math.min(PetMountFlags.MaximumSeatTiltDegrees:Get(), a1.SeatTiltLimit))
        )
    end
    a1.Seat.CFrame = TransformedWorldCFrame:ToObjectSpace(CFrame * v2)
    for i, j in a1.Grips do
        j.Attachment.CFrame = a1.Seat.CFrame * j.SeatOffset
    end
    a1.SeatLocal = v2
end

local function stabilizeAnimatedSeats() -- Line: 386 -- upvalues: u51 (val), NightFangHeight (val), stabilizeSeat (val)
    for i, j in u51 do
        if j.Model.Parent == j.Character and i.Character == j.Character then
            NightFangHeight.Apply(j.AnimationHeight)
            stabilizeSeat(j)
        end
    end
end

local function followSeatBones() -- Line: 394 -- upvalues: u51 (val), applySeatPose (val)
    for i, j in u51 do
        if j.Model.Parent == j.Character and i.Character == j.Character then
            j.SeatLocal = j.Rig.PrimaryPart.CFrame:ToObjectSpace(j.SeatFollower.CFrame)
            applySeatPose(j)
        end
    end
end

local function followRiders() -- Line: 403 -- upvalues: u51 (val), applySeatPose (val)
    for i, j in u51 do
        if j.Model.Parent == j.Character and i.Character == j.Character then
            j.Rig:PivotTo(j.Root.CFrame * j.RiderToPet * j.RootToPivot)
            applySeatPose(j)
        end
    end
end

local u74 = RaycastParams.new()
u74.FilterType = Enum.RaycastFilterType.Exclude

local function gateJump(a1) -- Line: 415 -- upvalues: u74 (val), u54 (ref)
    local v1
    local Humanoid = a1.Humanoid
    u74.FilterDescendantsInstances = {a1.Character, u54}
    local v2 = Humanoid.HipHeight + a1.Root.Size.Y / 2 - 1 + 1
    if not (workspace:Spherecast(a1.Root.Position, 1, Vector3.new(0, -v2, 0), u74) ~= nil)
        and not a1.JumpGated
        and Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        a1.JumpGated = true
        return
    end
    if v1 and a1.JumpGated then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        a1.JumpGated = false
    end
end

local function updatePose(a1) -- Line: 428
    -- upvalues: u51 (val), cleanup (val), stabilizeSeat (val), Players (val), gateJump (val), PetMountFlags (val)
    -- upvalues: PetMountGeometry (val), applySeatPose (val)
    local AnimationSpeed, AssemblyLinearVelocity, Carrier, Character, Magnitude, Magnitude_2, Model, Reach, WalkReferenceSpeed, WorldPosition, v1, v2, v3, v4, v5, v6, v7
    local v8 = nil
    local v9 = nil
    for i, j in u51, v8, v9 do
        if j.Model.Parent ~= j.Character then
            cleanup(i, true)
        elseif i.Character == j.Character then
            v6 = j.Root.CFrame * j.RiderToPet
            j.Rig:PivotTo(v6 * j.RootToPivot)
            stabilizeSeat(j)
            if i == Players.LocalPlayer then
                gateJump(j)
            end
            Model = j.Model
            Character = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            Carrier = Model:FindFirstChild("Carrier")
            Magnitude = Character and Carrier and (Character.Position - Carrier.Position).Magnitude or (1 / 0)
            v7 = true
            if i ~= Players.LocalPlayer then
                v7 = Magnitude <= PetMountFlags.IKDistance:Get()
            end
            AssemblyLinearVelocity = j.Root.AssemblyLinearVelocity
            Magnitude_2 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude
            AnimationSpeed = j.AnimationSpeed
            v3 = Magnitude_2 - j.AnimationSpeed
            v4 = -(math.max(v1, 0)) / 0.1
            j.AnimationSpeed = AnimationSpeed + v3 * (1 - math.exp(v4))
            v6 = Magnitude_2 > 0.5
            if j.Walk and j.Moving ~= v6 then
                if not v6 then
                    j.Walk:Stop(0.15)
                    if j.Idle then
                        j.Idle:Play(0.15)
                    end
                else
                    if j.Idle then
                        j.Idle:Stop(0.15)
                    end
                    j.Walk:Play(0.15)
                end
            end
            j.Moving = v6
            if j.Walk and v6 then
                WalkReferenceSpeed = j.WalkReferenceSpeed or PetMountFlags.WalkAnimationReferenceSpeed:Get()
                if not PetMountGeometry.IsFinite(WalkReferenceSpeed) or WalkReferenceSpeed <= 0 then
                    WalkReferenceSpeed = PetMountFlags.WalkAnimationReferenceSpeed:Get()
                end
                j.Walk:AdjustSpeed((math.clamp(
                    j.AnimationSpeed / WalkReferenceSpeed,
                    PetMountFlags.WalkAnimationMinRate:Get(),
                    (PetMountFlags.WalkAnimationMaxRate:Get())
                )))
            end
            if j.TorsoIK then
                j.TorsoTarget.CFrame = (j.RiderToPet * j.SeatLocal).Rotation * CFrame.Angles(-math.rad((PetMountFlags.TorsoLeanDegrees:Get())), 0, 0)
                j.TorsoIK.Enabled = v7
            end
            applySeatPose(j)
            v2 = nil
            v3 = nil
            for k, n in j.Grips, v2, v3 do
                n.IK.Enabled = v7
                if v7 then
                    v6 = PetMountGeometry.AnimatedWorld(n.Attachment)
                    WorldPosition = n.Origin and n.Origin.WorldPosition or n.Upper.Position
                    v5 = v6.Position - WorldPosition
                    Reach = n.Reach
                    if Reach < v5.Magnitude then
                        v6 = v6.Rotation + WorldPosition + v5.Unit * Reach
                    end
                    n.Target.WorldCFrame = v6
                end
            end
        else
            cleanup(i, true)
        end
    end
end

local function bindCharacter(a1, a2) -- Line: 475
    -- upvalues: u52 (val), cleanup (val), u50 (val), u41 (ref), newTarget (val)
    local v1 = u52[a1]
    if v1 and v1.Child then
        v1.Child:Disconnect()
    end
    if v1 and v1.Removing then
        v1.Removing:Disconnect()
    end
    cleanup(a1, true)
    local v2 = u50[a1]
    if v2 and v2.UID then
        if u41 == nil then
            u41 = require(script.Parent.Plots.ActiveAssetsController)
        end
        u41.SetMountedPet(a1.UserId, v2.UID, false)
    end
    u50[a1] = nil
    if not a2 then
        return
    end
    v1.Child = a2.ChildAdded:Connect(function(a1_2) -- Line: 481 -- upvalues: newTarget (upval), a1 (val)
        if a1_2.Name == "PetMountSession" and a1_2:IsA("Model") then
            newTarget(a1, a1_2)
        end
    end)
    v1.Removing = a2.ChildRemoved:Connect(function(a1_2) -- Line: 485 -- upvalues: u50 (upval), a1 (val), cleanup (upval), u41 (upval)
        if u50[a1] and u50[a1].Model == a1_2 then
            local v1 = a1
            cleanup(v1, true)
            local v2 = u50[v1]
            if v2 and v2.UID then
                if u41 == nil then
                    u41 = require(script.Parent.Plots.ActiveAssetsController)
                end
                u41.SetMountedPet(v1.UserId, v2.UID, false)
            end
            u50[v1] = nil
        end
    end)
    for i, j in a2:GetChildren() do
        if j.Name == "PetMountSession" and j:IsA("Model") then
            newTarget(a1, j)
        end
    end
end

local function bindPlayer(a1) -- Line: 490 -- upvalues: u52 (val), bindCharacter (val)
    u52[a1] = {}
    local v1 = u52[a1]
    v1.Added = a1.CharacterAdded:Connect(function(a1_2) -- Line: 492 -- upvalues: bindCharacter (upval), a1 (val)
        bindCharacter(a1, a1_2)
    end)
    bindCharacter(a1, a1.Character)
end

function v1.Start() -- Line: 495
    -- upvalues: u49 (ref), u54 (ref), Players (val), bindPlayer (val), cleanup (val), u50 (val), u41 (ref), u52 (val)
    -- upvalues: u53 (val), RunService (val), u55 (ref), maintain (val), updatePose (val), u51 (val)
    -- upvalues: NightFangHeight (val), stabilizeAnimatedSeats (val), followSeatBones (val), followRiders (val)
    if u49 then
        return
    end
    u49 = true
    u54 = Instance.new("Folder")
    u54.Name = "ClientMountedPets"
    u54.Parent = workspace
    Players.PlayerAdded:Connect(bindPlayer)
    Players.PlayerRemoving:Connect(function(a1) -- Line: 502 -- upvalues: cleanup (upval), u50 (upval), u41 (upval), u52 (upval), u53 (upval)
        cleanup(a1, true)
        local v1 = u50[a1]
        if v1 and v1.UID then
            if u41 == nil then
                u41 = require(script.Parent.Plots.ActiveAssetsController)
            end
            u41.SetMountedPet(a1.UserId, v1.UID, false)
        end
        u50[a1] = nil
        for i, j in u52[a1] or {} do
            j:Disconnect()
        end
        u52[a1] = nil
        u53[a1] = nil
    end)
    for i, j in Players:GetPlayers() do
        bindPlayer(j)
    end
    RunService.Heartbeat:Connect(function(a1) -- Line: 509 -- upvalues: u55 (upval), maintain (upval)
        u55 = u55 + a1
        if u55 >= 0.1 then
            u55 = 0
            maintain()
        end
    end)
    RunService.PreAnimation:Connect(function(a1) -- Line: 513 -- upvalues: updatePose (upval), u51 (upval), NightFangHeight (upval)
        updatePose(a1)
        for i, j in u51 do
            NightFangHeight.Reset(j.AnimationHeight)
        end
    end)
    RunService.PreSimulation:Connect(stabilizeAnimatedSeats)
    RunService.PostSimulation:Connect(followSeatBones)
    RunService:BindToRenderStep("PetMountFollow", Enum.RenderPriority.Character.Value + 1, followRiders)
end

return v1