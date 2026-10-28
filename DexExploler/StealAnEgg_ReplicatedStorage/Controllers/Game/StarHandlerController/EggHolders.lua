-- Script path: ReplicatedStorage.Controllers.Game.StarHandlerController.EggHolders
-- Decompile time: 17.44 ms

local playIdle
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u41 = CFrame.lookAlong(Vector3.new(540, 67.58000183105469, -403.45001220703125), (Vector3.new(-0.6804999709129333, 0, 0.7328000068664551)))
local u42 = {"Assets", "Models", "Eggs", "Halloween Egg"}
local u47 = {}
local v1 = {
    part = "RightUpperArm",
    joint = "RightShoulder",
    pose = (CFrame.Angles(0, 0, 0.20943951023931956)) * CFrame.Angles(2.9321531433504737, 0, 0),
}
local v2 = {
    part = "LeftUpperArm",
    joint = "LeftShoulder",
    pose = (CFrame.Angles(0, 0, -0.20943951023931956)) * CFrame.Angles(2.9321531433504737, 0, 0),
}
local v3 = {part = "RightLowerArm", joint = "RightElbow", pose = CFrame.Angles(0.17453292519943295, 0, 0)}
local v4 = {part = "LeftLowerArm", joint = "LeftElbow", pose = CFrame.Angles(0.17453292519943295, 0, 0)}
local v5 = {part = "RightHand", joint = "RightWrist", pose = CFrame.identity}
local v6 = {part = "LeftHand", joint = "LeftWrist", pose = CFrame.identity}
u47[1] = v1
u47[2] = v2
u47[3] = v3
u47[4] = v4
u47[5] = v5
u47[6] = v6
local LocalPlayer = Players.LocalPlayer
local u89 = false
local u90 = 0
local u91 = nil
local u92 = {}
v6 = {}

local function onSale() -- Line: 66 -- upvalues: LimitedEgg (val)
    local success, err = pcall(function() -- Line: 67 -- upvalues: LimitedEgg (upval)
        return LimitedEgg.IsOnSale(LimitedEgg.Halloween)
    end)
    return success and err == true
end

local function eggTemplate() -- Line: 73 -- upvalues: ReplicatedStorage (val), u42 (val)
    local v1 = ReplicatedStorage
    local v2 = nil
    local v3 = nil
    for i, j in u42, v2, v3 do
        v1 = v1 and v1:FindFirstChild(j)
    end
    if v1 and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function starHandler() -- Line: 81 -- upvalues: CollectionService (val), Workspace (val)
    for i, j in CollectionService:GetTagged("StarHandlerNpc") do
        if j:IsA("Model") and j:IsDescendantOf(Workspace) then
            return j
        end
    end
    return nil
end

local function ring() -- Line: 90 -- upvalues: CollectionService (val), Workspace (val)
    for i, j in CollectionService:GetTagged("StarHandlerProp") do
        if j:IsA("BasePart") and j:IsDescendantOf(Workspace) then
            return j
        end
    end
    return nil
end

local function spot(a1) -- Line: 99
    -- upvalues: starHandler (val), u41 (val), ring (val), CollectionService (val), Players (val), Workspace (val)
    local v1
    local v2 = starHandler()
    local v3 = u41
    if v2 then
        local Pivot = v2:GetPivot()
        v1 = Pivot.LookVector * Vector3.new(1, 0, 1)
        v3 = if not (0.01 < v1.Magnitude) then (CFrame.new(Pivot.Position)) * u41.Rotation else CFrame.lookAlong(Pivot.Position, v1.Unit)
    end
    v2 = ring()
    if v2 then
        v3 = (CFrame.new(v2.Position.X, v3.Position.Y, v2.Position.Z)) * v3.Rotation
    end
    v2 = {a1}
    local v4 = {"StarHandlerNpc", "StarHandlerProp"}
    v1 = nil
    local v5 = nil
    for i, j in v4, v1, v5 do
        for k, n in CollectionService:GetTagged(j) do
            table.insert(v2, n)
        end
    end
    for m, i5 in Players:GetPlayers() do
        if i5.Character then
            table.insert(v2, i5.Character)
        end
    end
    v4 = RaycastParams.new()
    v4.FilterType = Enum.RaycastFilterType.Exclude
    v4.FilterDescendantsInstances = v2
    v2 = Workspace:Raycast(v3.Position + Vector3.new(0, 10, 0), Vector3.new(0, -60, 0), v4)
    return (CFrame.new(v3.Position.X, if not v2 then u41.Position.Y else v2.Position.Y, v3.Position.Z)) * v3.Rotation
end

local function description(a1) -- Line: 133 -- types: a1: userdata
    local Humanoid = (a1.Character or a1.CharacterAdded:Wait()):WaitForChild("Humanoid", 10)
    if Humanoid ~= nil and Humanoid:IsA("Humanoid") then
        local success, err = pcall(function() -- Line: 139 -- upvalues: Humanoid (val)
            return Humanoid:GetAppliedDescription()
        end)
        if success and err then
            return err
        end
        return nil
    end
    return nil
end

local function rigFor(a1) -- Line: 148 -- upvalues: Players (val) -- types: a1: userdata
    local success, err = pcall(function() -- Line: 149 -- upvalues: Players (upval), a1 (val)
        return Players:CreateHumanoidModelFromDescriptionAsync(a1, Enum.HumanoidRigType.R15)
    end)
    if success and err ~= nil then
        return err
    end
    return nil
end

local function freeze(a1) -- Line: 158 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = false
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.Massless = true
            ;(j:GetPropertyChangedSignal("CanCollide")):Connect(function() -- Line: 166 -- upvalues: j (val)
                if j.CanCollide then
                    j.CanCollide = false
                end
            end)
        elseif j:IsA("Script") or j:IsA("LocalScript") then
            j:Destroy()
        end
    end
end

local function settle(a1, a2) -- Line: 177 -- types: a1: userdata, a2: userdata
    local Part0, Part1, Transform, v1, v2, v3, v4
    local v5 = {}
    v5[a2] = a2.CFrame
    local v6 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("JointInstance") and j.Part0 and j.Part1 and j.Name ~= "EggGrip" then
            table.insert(v6, j)
        end
    end
    local v7 = true
    while v7 do
        v7 = false
        v3 = nil
        v4 = nil
        for k, n in v6, v3, v4 do
            Part0 = n.Part0
            Part1 = n.Part1
            Transform = if not n:IsA("Motor6D") then CFrame.identity else n.Transform
            v1 = v5[Part0]
            v2 = v5[Part1]
            if not v1 then
                if v2 and not v1 then
                    v5[Part0] = v2 * n.C1 * Transform:Inverse() * n.C0:Inverse()
                    v7 = true
                end
            elseif not v2 then
                v5[Part1] = v1 * n.C0 * Transform * n.C1:Inverse()
                v7 = true
            elseif v2 and not v1 then
                v5[Part0] = v2 * n.C1 * Transform:Inverse() * n.C0:Inverse()
                v7 = true
            end
        end
    end
    return v5
end

local function raise(a1) -- Line: 206 -- upvalues: u47 (val) -- types: a1: userdata
    local v1, v2
    local v3 = nil
    local v4 = nil
    for i, j in u47, v3, v4 do
        v1 = a1:FindFirstChild(j.part)
        v2 = v1 and v1:FindFirstChild(j.joint)
        if v2 and v2:IsA("Motor6D") then
            v2.Transform = j.pose
        end
    end
end

local function idleAnimation(a1) -- Line: 216 -- types: a1: userdata
    local Animate = a1:FindFirstChild("Animate")
    local idle = Animate and Animate:FindFirstChild("idle")
    local AnimationId = nil
    local v1 = (-1 / 0)
    if idle then
        local Weight
        for i, j in idle:GetChildren() do
            if j:IsA("Animation") and j.AnimationId ~= "" then
                Weight = j:FindFirstChild("Weight")
                if v1 < (if not Weight then 1 else if not Weight:IsA("NumberValue") then 1 else Weight.Value) then
                    AnimationId = j.AnimationId
                end
            end
        end
    end
    return AnimationId or "rbxassetid://507766388"
end

function playIdle(a1, a2) -- Line: 236 -- upvalues: playIdle (val) -- types: a1: userdata, a2: string
    local Animator = a1:FindFirstChildOfClass("Animator")
    if Animator == nil then
        local Animator_2 = Instance.new("Animator")
        Animator_2.Parent = a1
        Animator = Animator_2
    end
    local Animation = Instance.new("Animation")
    Animation.AnimationId = a2
    local success, err = pcall(function() -- Line: 245 -- upvalues: Animator (ref), Animation (val)
        return Animator:LoadAnimation(Animation)
    end)
    if success and err ~= nil then
        err.Priority = Enum.AnimationPriority.Idle
        err.Looped = true
        err:Play()
        return
    end
    if a2 ~= "rbxassetid://507766388" then
        playIdle(a1, "rbxassetid://507766388")
    end
end

local function clasp(a1, a2, a3, a4) -- Line: 259 -- types: a1: userdata, a2: userdata, a3: userdata, a4: table
    local Weld
    local UpperTorso = a1:FindFirstChild("UpperTorso")
    local v1 = if not UpperTorso then a3 else if not UpperTorso:IsA("BasePart") then a3 else if not a4[UpperTorso] then a3 else UpperTorso
    local CFrame_2 = a4[v1] or v1.CFrame
    for i, j in a2:GetDescendants() do
        if j:IsA("BasePart") then
            Weld = Instance.new("Weld")
            Weld.Name = "EggGrip"
            Weld.Part0 = v1
            Weld.Part1 = j
            Weld.C0 = CFrame_2:ToObjectSpace(j.CFrame)
            Weld.Parent = j
            j.Massless = true
            j.Anchored = false
        end
    end
end

local function release(a1) -- Line: 277 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if not j:IsA("Weld") then
            if j:IsA("BasePart") then
                j.Anchored = true
            end
        elseif j.Name == "EggGrip" then
            j:Destroy()
        elseif j:IsA("BasePart") then
            j.Anchored = true
        end
    end
end

local function hands(a1, a2) -- Line: 287 -- types: a1: userdata, a2: table
    local RightHand = a1:FindFirstChild("RightHand")
    local LeftHand = a1:FindFirstChild("LeftHand")
    if RightHand and LeftHand and RightHand:IsA("BasePart") and LeftHand:IsA("BasePart") then
        local CFrame = a2[RightHand] or RightHand.CFrame
        local CFrame_2 = a2[LeftHand] or LeftHand.CFrame
        return (CFrame.Position + CFrame_2.Position) / 2
    end
    return nil
end

local function egg(a1) -- Line: 298 -- types: a1: userdata
    local BoundingBox_2
    local v1 = a1:Clone()
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            if j.Name == "Hitbox" then
                j.Transparency = 1
            end
        end
    end
    _, BoundingBox_2 = v1:GetBoundingBox()
    if 0 < BoundingBox_2.Y then
        v1:ScaleTo(v1:GetScale() * 4.25 / BoundingBox_2.Y)
    end
    v1.Name = "Egg"
    return v1
end

local function lift(a1, a2, a3) -- Line: 319 -- upvalues: hands (val) -- types: a1: userdata, a2: userdata, a3: table
    local Head = a1:FindFirstChild("Head")
    local Position = hands(a1, a3) or (if not Head then a1:GetPivot().Position else if not Head:IsA("BasePart") then a1:GetPivot().Position else Head.Position + Vector3.new(0, 2, 0))
    local BoundingBox, BoundingBox_2 = a2:GetBoundingBox()
    a2:PivotTo((CFrame.new(Position + (Vector3.new(0, BoundingBox_2.Y / 2 + 0.3, 0)))) * a1:GetPivot().Rotation * (BoundingBox:ToObjectSpace((a2:GetPivot()))))
end

local function stand(a1, a2, a3) -- Line: 334
    -- upvalues: idleAnimation (val), freeze (val), egg (val), release (val), raise (val), settle (val), lift (val)
    -- upvalues: clasp (val), u47 (val), playIdle (val), RunService (val)
    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart")
    if Humanoid ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local v1, v2
        local v3 = idleAnimation(a1)
        freeze(a1)
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.EvaluateStateMachine = false
        Humanoid.BreakJointsOnDeath = false
        Humanoid.RequiresNeck = false
        HumanoidRootPart.Anchored = true
        HumanoidRootPart.Transparency = 1
        local u31 = if not a3 then nil else egg(a3)
        if u31 then
            u31.Parent = a1
        end
        local u123 = false

        local function refresh() -- Line: 354
            -- upvalues: u123 (ref), a1 (val), u31 (val), release (upval), a2 (val), Humanoid (val)
            -- upvalues: HumanoidRootPart (val), raise (upval), settle (upval), lift (upval), clasp (upval)
            u123 = false
            if a1.Parent == nil then
                return
            end
            if u31 then
                release(u31)
            end
            a1:PivotTo(a2 * (CFrame.new(0, Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2, 0)))
            raise(a1)
            local v1 = settle(a1, HumanoidRootPart)
            if u31 then
                lift(a1, u31, v1)
                clasp(a1, u31, HumanoidRootPart, v1)
            end
        end

        local function queue() -- Line: 370 -- upvalues: u123 (ref), refresh (val)
            if not u123 then
                u123 = true
                task.defer(refresh)
            end
        end

        local v4 = nil
        local v5 = nil
        for i, j in u47, v4, v5 do
            v1 = a1:FindFirstChild(j.part)
            v2 = v1 and v1:FindFirstChild(j.joint)
            if v2 and v2:IsA("Motor6D") then
                (v2:GetPropertyChangedSignal("C0")):Connect(queue)
            end
        end
        a1.DescendantAdded:Connect(function(a1) -- Line: 383 -- upvalues: u123 (ref), refresh (val)
            if a1:IsA("JointInstance") and a1.Name ~= "EggGrip" and not u123 then
                u123 = true
                task.defer(refresh)
            end
        end)
        ;(Humanoid:GetPropertyChangedSignal("HipHeight")):Connect(queue)
        refresh()
        playIdle(Humanoid, v3)
        local u80 = nil
        u80 = RunService.PreSimulation:Connect(function() -- Line: 392 -- upvalues: a1 (val), u80 (ref), raise (upval)
            if a1.Parent ~= nil then
                raise(a1)
                return
            end
            if u80 then
                u80:Disconnect()
            end
        end)
        a1.Destroying:Once(function() -- Line: 401 -- upvalues: u80 (ref)
            if u80 then
                u80:Disconnect()
            end
        end)
        return HumanoidRootPart
    end
    return nil
end

local function nameplate(a1, a2) -- Line: 409 -- types: a1: userdata, a2: userdata
    local Nameplate = script:FindFirstChild("Nameplate")
    if Nameplate ~= nil and Nameplate:IsA("BillboardGui") then
        local v1 = Nameplate:Clone()
        v1.Adornee = a1
        v1.StudsOffsetWorldSpace = Vector3.new(0, a1.Size.Y / 2 + 2.4, 0)
        local v2 = v1:FindFirstChild("Title")
        if v2 and v2:IsA("TextLabel") then
            v2.Text = "HALLOWEEN EGG"
        end
        v1.Enabled = true
        v1.Parent = a2
        return
    end
end

local function openShop() -- Line: 425 -- upvalues: ReplicatedStorage (val)
    require(ReplicatedStorage.Client.ShopNavigation).Open("Featured")
end

local function prompt(a1, a2) -- Line: 430 -- upvalues: openShop (val) -- types: a1: userdata, a2: userdata
    local Part = Instance.new("Part")
    Part.Name = "PromptPoint"
    Part.Size = Vector3.new(1, 1, 1)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CFrame = a1 * CFrame.new(0, 3, 0)
    Part.Parent = a2
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Name = "HalloweenEggPrompt"
    ProximityPrompt.ActionText = "Open"
    ProximityPrompt.ObjectText = "Halloween Egg"
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
    ProximityPrompt.HoldDuration = 0
    ProximityPrompt.MaxActivationDistance = 10
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.Parent = Part
    ProximityPrompt.Triggered:Connect(openShop)
end

local function assemble(a1, a2, a3) -- Line: 454
    -- upvalues: Players (val), Workspace (val), stand (val), eggTemplate (val), nameplate (val), prompt (val)
    local success, err = pcall(function() -- Line: 149 -- upvalues: Players (upval), a3 (val)
        return Players:CreateHumanoidModelFromDescriptionAsync(a3, Enum.HumanoidRigType.R15)
    end)
    local v1 = if not success then nil else if err ~= nil then err else nil
    if not a1:IsDescendantOf(Workspace) then
        if v1 then
            v1:Destroy()
        end
        return
    end
    if v1 == nil then
        return
    end
    v1.Name = "HalloweenEggHolder"
    v1.Parent = a1
    local v2 = stand(v1, a2, (eggTemplate()))
    local Egg = v1:FindFirstChild("Egg")
    local PrimaryPart = if not Egg then v2 else if not Egg:IsA("Model") then v2 else if not Egg.PrimaryPart then v2 else Egg.PrimaryPart
    if PrimaryPart then
        nameplate(PrimaryPart, a1)
    end
    prompt(a2, a1)
end

local function build(a1, a2) -- Line: 480
    -- upvalues: description (val), LocalPlayer (val), u90 (ref), spot (val), Workspace (val), assemble (val)
    local v1 = a2:Add((Instance.new("Folder")))
    v1.Name = "HalloweenEggHolders"
    local v2 = description(LocalPlayer)
    if a1 ~= u90 then
        return
    end
    local v3 = spot(v1)
    v1.Parent = Workspace
    assemble(v1, v3, v2 or Instance.new("HumanoidDescription"))
end

local function apply() -- Line: 492
    -- upvalues: LimitedEgg (val), u89 (ref), u90 (ref), u91 (ref), Trove (val), build (val), u92 (val)
    local success, err = pcall(function() -- Line: 67 -- upvalues: LimitedEgg (upval)
        return LimitedEgg.IsOnSale(LimitedEgg.Halloween)
    end)
    local v1 = success and err == true
    if v1 == u89 then
        return
    end
    u89 = v1
    u90 = u90 + 1
    if u91 then
        u91:Destroy()
        u91 = nil
    end
    if v1 then
        local v2 = Trove.new()
        u91 = v2
        task.spawn(build, u90, v2)
    end
    for i, j in u92 do
        task.spawn(j, v1)
    end
end

function v6.IsActive() -- Line: 517 -- upvalues: u89 (ref)
    return u89
end

function v6.Changed(a1) -- Line: 521 -- upvalues: u92 (val) -- types: a1: function
    table.insert(u92, a1)
end

function v6.Start() -- Line: 525 -- upvalues: apply (val), BalanceConfig (val)
    apply()
    BalanceConfig.Changed:Connect(apply)
    task.spawn(function() -- Line: 528 -- upvalues: apply (upval)
        while true do
            task.wait(5)
            apply()
        end
    end)
end

return v6