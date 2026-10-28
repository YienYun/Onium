-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.MountAnimator
-- Decompile time: 9.63 ms

local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MountRace = require(ReplicatedStorage.Data.MountRace)
local TheHollowFlags = require(ReplicatedStorage.Shared.Flags.TheHollowFlags)
local u33 = NumberRange.new(0.6, 3)
local u34 = {}

local function findRider(a1, a2, a3) -- Line: 63 -- types: a1: userdata, a2: userdata, a3: userdata
    local Attachment0
    local v1, v2 = a3, a2
    for i, j in a1:GetDescendants() do
        if not j:IsDescendantOf(v1) then
            if j:IsA("Motor6D") and j.Part0 == v2 then
                return j
            end
            if j:IsA("AnimationConstraint") then
                Attachment0 = j.Attachment0
                if Attachment0 ~= nil and Attachment0.Parent == v2 then
                    return Attachment0
                end
            end
        end
    end
    return nil
end

local function riderFrame(a1) -- Line: 85 -- types: a1: userdata
    if a1:IsA("Motor6D") then
        return a1.C0
    end
    return a1.CFrame
end

local function setRiderFrame(a1, a2) -- Line: 92 -- types: a1: userdata, a2: userdata
    if a1:IsA("Motor6D") then
        a1.C0 = a2
        return
    end
    a1.CFrame = a2
end

local function findRiderBone(a1, a2, a3) -- Line: 100 -- types: a1: userdata, a2: userdata, a3: userdata
    local Attribute = a1:GetAttribute("RiderBone")
    if type(Attribute) ~= "string" then
        return nil
    end
    local v1 = a2:FindFirstChild(Attribute, true)
    if v1 ~= nil and v1:IsA("Bone") and v1:FindFirstAncestorWhichIsA("BasePart") == a3 then
        return v1
    end
    return nil
end

local function boneMotion(a1) -- Line: 116 -- types: a1: userdata
    local identity = CFrame.identity
    local identity_2 = CFrame.identity
    local Parent = a1
    while Parent ~= nil do
        if not Parent:IsA("Bone") then
            break
        end
        identity = Parent.CFrame * identity
        identity_2 = Parent.CFrame * Parent.Transform * identity_2
        Parent = Parent.Parent
    end
    return identity_2 * identity:Inverse()
end

local function setupLean(a1, a2) -- Line: 128
    -- upvalues: MountRace (val), findRider (val), findRiderBone (val)
    local Parent = a1.Parent
    local HumanoidRootPart = if Parent == nil then nil else Parent:FindFirstChild("HumanoidRootPart")
    local HumanoidRootPart_2 = a1:FindFirstChild("HumanoidRootPart")
    local Hitbox = a1:FindFirstChild("Hitbox")
    local PrimaryPart = a2.PrimaryPart
    if a1.Name == MountRace.MountName
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and HumanoidRootPart_2 ~= nil
        and HumanoidRootPart_2:IsA("BasePart")
        and Hitbox ~= nil
        and Hitbox:IsA("BasePart")
        and PrimaryPart ~= nil then
        local v1 = nil
        local v2, v3 = a1, a2
        for i, j in a1:GetDescendants() do
            if j:IsA("WeldConstraint") and j.Enabled then
                if j.Part0 == HumanoidRootPart_2 and j.Part1 == PrimaryPart then
                    v1 = j
                    break
                end
                if j.Part0 == PrimaryPart and j.Part1 == HumanoidRootPart_2 then
                    v1 = j
                    break
                end
            end
        end
        if v1 == nil then
            return nil
        end
        local v4 = findRider(Parent, HumanoidRootPart, v2)
        local v5 = Hitbox.CFrame:PointToWorldSpace((Vector3.new(0, -Hitbox.Size.Y / 2, 0)))
        local v6 = HumanoidRootPart_2.CFrame:ToObjectSpace(PrimaryPart.CFrame)
        local Weld = Instance.new("Weld")
        Weld.Name = "LeanWeld"
        Weld.Part0 = HumanoidRootPart_2
        Weld.Part1 = PrimaryPart
        Weld.C0 = v6
        Weld.Parent = HumanoidRootPart_2
        v1.Enabled = false
        return {
            Angle = 0,
            CharacterRoot = HumanoidRootPart,
            Asset = v1,
            Weld = Weld,
            MountOffset = v6,
            MountFrame = HumanoidRootPart.CFrame:ToObjectSpace(HumanoidRootPart_2.CFrame),
            MountPivot = HumanoidRootPart_2.CFrame:PointToObjectSpace(v5),
            MountAxis = HumanoidRootPart_2.CFrame:VectorToObjectSpace(HumanoidRootPart.CFrame.LookVector),
            Rider = v4,
            RiderRest = if v4 == nil then CFrame.identity else if not v4:IsA("Motor6D") then v4.CFrame else v4.C0,
            RiderPivot = HumanoidRootPart.CFrame:PointToObjectSpace(v5),
            RiderBone = findRiderBone(v2, v3, PrimaryPart),
            Look = HumanoidRootPart.CFrame.LookVector,
        }
    end
    return nil
end

local function releaseLean(a1) -- Line: 192 -- types: a1: table
    a1.Weld:Destroy()
    if a1.Asset.Parent ~= nil then
        a1.Asset.Enabled = true
    end
    local Rider = a1.Rider
    if Rider ~= nil and Rider.Parent ~= nil then
        local RiderRest = a1.RiderRest
        if Rider:IsA("Motor6D") then
            Rider.C0 = RiderRest
            return
        end
        Rider.CFrame = RiderRest
    end
end

local function stepLean(a1, a2) -- Line: 203
    -- upvalues: GuiService (val), TheHollowFlags (val), boneMotion (val)
    local CFrame_2 = a1.CharacterRoot.CFrame
    local UpVector = CFrame_2.UpVector
    local v1 = CFrame_2.LookVector - UpVector * CFrame_2.LookVector:Dot(UpVector)
    local v2 = a1.Look - UpVector * a1.Look:Dot(UpVector)
    if not (v1.Magnitude < 0.001) and not (v2.Magnitude < 0.001) then
        local Unit = v1.Unit
        local Unit_2 = v2.Unit
        a1.Look = Unit
        local v3 = (math.asin((math.clamp(UpVector:Dot((Unit_2:Cross(Unit))), -1, 1)))) / math.max(a2, 0.001)
        v1 = math.clamp(a1.CharacterRoot.AssemblyLinearVelocity.Magnitude / 50, 0, 1)
        local v4 = math.clamp(-v3 * 0.18, -0.2792526803190927, 0.2792526803190927) * v1
        if GuiService.ReducedMotionEnabled then
            v4 = v4 * 0.4
        end
        a1.Angle = a1.Angle + (v4 - a1.Angle) * math.min(1, a2 * 8)
        local MountPivot = a1.MountPivot
        a1.Weld.C0 = (CFrame.new(MountPivot)) * CFrame.fromAxisAngle(a1.MountAxis, a1.Angle) * CFrame.new(-MountPivot) * a1.MountOffset
        local Rider = a1.Rider
        if Rider ~= nil then
            local RiderPivot = a1.RiderPivot
            v4 = (CFrame.new(RiderPivot)) * CFrame.fromAxisAngle(Vector3.new(0, 0, -1), a1.Angle) * CFrame.new(-RiderPivot) * a1.RiderRest
            local RiderBone = a1.RiderBone
            if RiderBone ~= nil and TheHollowFlags.RiderFollowsDeck:Get() then
                v2 = a1.MountFrame * a1.Weld.C0
                v4 = v2 * boneMotion(RiderBone) * v2:Inverse() * v4
            end
            if Rider:IsA("Motor6D") then
                Rider.C0 = v4
                return
            end
            Rider.CFrame = v4
        end
        return
    end
end

local function addMount(a1) -- Line: 243 -- upvalues: u34 (val), setupLean (val) -- types: a1: userdata
    local Model = a1:WaitForChild("Model", 10)
    local Idle = a1:WaitForChild("Idle", 10)
    local Walk = a1:WaitForChild("Walk", 10)
    local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart", 10)
    if Model ~= nil and Idle ~= nil and Walk ~= nil and HumanoidRootPart ~= nil and a1.Parent ~= nil then
        local Animator = (Model:WaitForChild("AnimationController")):WaitForChild("Animator")
        local v1 = Animator:LoadAnimation(Idle)
        local v2 = Animator:LoadAnimation(Walk)
        v1.Looped = true
        v2.Looped = true
        v1:Play()
        u34[a1] = {
            Walking = false,
            Root = a1.HumanoidRootPart,
            Idle = v1,
            Walk = v2,
            Lean = setupLean(a1, Model),
        }
        return
    end
end

local function removeMount(a1) -- Line: 273 -- upvalues: u34 (val) -- types: a1: userdata
    local v1 = u34[a1]
    if v1 == nil then
        return
    end
    u34[a1] = nil
    v1.Idle:Stop(0)
    v1.Walk:Stop(0)
    local Lean = v1.Lean
    if Lean ~= nil then
        Lean.Weld:Destroy()
        if Lean.Asset.Parent ~= nil then
            Lean.Asset.Enabled = true
        end
        local Rider = Lean.Rider
        if Rider ~= nil and Rider.Parent ~= nil then
            local RiderRest = Lean.RiderRest
            if Rider:IsA("Motor6D") then
                Rider.C0 = RiderRest
                return
            end
            Rider.CFrame = RiderRest
        end
    end
end

local function step(a1) -- Line: 287 -- upvalues: u34 (val), stepLean (val), u33 (val) -- types: a1: number
    local Lean, Magnitude, v1
    local v2 = nil
    local v3 = nil
    for i, j in u34, v2, v3 do
        Lean = j.Lean
        if Lean ~= nil then
            stepLean(Lean, a1)
        end
        Magnitude = j.Root.AssemblyLinearVelocity.Magnitude
        v1 = Magnitude > 3
        if v1 ~= j.Walking then
            j.Walking = v1
            if not v1 then
                j.Walk:Stop(0.2)
                j.Idle:Play(0.2)
            else
                j.Idle:Stop(0.2)
                j.Walk:Play(0.2)
            end
        end
        if v1 then
            j.Walk:AdjustSpeed((math.clamp(Magnitude / 40, u33.Min, u33.Max)))
        end
    end
end

return {
    Start = function() -- Line: 317
        -- upvalues: CollectionService (val), MountRace (val), addMount (val), removeMount (val), RunService (val)
        -- upvalues: step (val)
        (CollectionService:GetInstanceAddedSignal(MountRace.MountTag)):Connect(addMount)
        ;(CollectionService:GetInstanceRemovedSignal(MountRace.MountTag)):Connect(removeMount)
        for i, j in CollectionService:GetTagged(MountRace.MountTag) do
            addMount(j)
        end
        RunService.Heartbeat:Connect(step)
    end,
}