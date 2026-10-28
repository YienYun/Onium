-- Script path: ReplicatedStorage.Controllers.Game.RagdollLimpController
-- Decompile time: 6.57 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Ragdoll = require(ReplicatedStorage.Shared.Flags.GameplayBalance).Ragdoll
local Physics = Enum.HumanoidStateType.Physics
local u22 = {Root = true, Neck = true}
local u23 = {"HumanoidRootPart", "LowerTorso", "UpperTorso", "Torso"}
local LocalPlayer = Players.LocalPlayer
local v1 = {}

local function joinsTool(a1) -- Line: 21 -- types: a1: userdata
    local Part1 = a1.Part1
    local v1 = true
    if a1:FindFirstAncestorOfClass("Tool") == nil then
        v1 = false
        if Part1 ~= nil then
            v1 = Part1:FindFirstAncestorOfClass("Tool") ~= nil
        end
    end
    return v1
end

local function pin(a1, a2, a3) -- Line: 27 -- types: a1: userdata, a2: userdata, a3: table
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "RagdollLocalLimp"
    Attachment.Parent = a1
    Attachment.CFrame = a2
    table.insert(a3, Attachment)
    return Attachment
end

local function limp(a1) -- Line: 36 -- upvalues: u22 (val) -- types: a1: userdata
    local BallSocketConstraint, C0, C1, Created, Created_2, HingeConstraint, Part0, Part1, Part1_2, v1, v2, v3, v4
    local v5 = {Created = {}, Disabled = {}}
    for i, j in a1:GetDescendants() do
        if j:IsA("Motor6D") and j.Enabled then
            Part1 = j.Part1
            v3 = true
            if j:FindFirstAncestorOfClass("Tool") == nil then
                v3 = false
                if Part1 ~= nil then
                    v3 = Part1:FindFirstAncestorOfClass("Tool") ~= nil
                end
            end
            if not v3 then
                Part0 = j.Part0
                Part1_2 = j.Part1
                if Part0 and Part1_2 then
                    C0 = j.C0
                    Created = v5.Created
                    v4 = Instance.new("Attachment")
                    v4.Name = "RagdollLocalLimp"
                    v4.Parent = Part0
                    v4.CFrame = C0
                    table.insert(Created, v4)
                    C1 = j.C1
                    Created_2 = v5.Created
                    v1 = Instance.new("Attachment")
                    v1.Name = "RagdollLocalLimp"
                    v1.Parent = Part1_2
                    v1.CFrame = C1
                    table.insert(Created_2, v1)
                    if not u22[j.Name] then
                        BallSocketConstraint = Instance.new("BallSocketConstraint")
                        BallSocketConstraint.LimitsEnabled = true
                        BallSocketConstraint.TwistLimitsEnabled = true
                        v2 = BallSocketConstraint
                    else
                        HingeConstraint = Instance.new("HingeConstraint")
                        HingeConstraint.LimitsEnabled = true
                        v2 = HingeConstraint
                    end
                    v2.Name = "RagdollLocalLimp"
                    v2.Parent = j.Parent
                    v2.Attachment0 = v4
                    v2.Attachment1 = v1
                    table.insert(v5.Created, v2)
                    j.Enabled = false
                    table.insert(v5.Disabled, j)
                end
            end
        end
    end
    return v5
end

local function tumble(a1, a2) -- Line: 68 -- upvalues: Ragdoll (val), u23 (val) -- types: a1: userdata, a2: table
    local v1 = tonumber(Ragdoll.LOCAL_LIMP_TUMBLE) or 0
    local v2 = tonumber(Ragdoll.LOCAL_LIMP_FLAIL) or 0
    local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart")
    if v1 == v1 and v2 == v2 and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local Part1, v3
        v1 = math.clamp(v1, 0, 30)
        v2 = math.clamp(v2, 0, 30)
        if v1 <= 0 and v2 <= 0 then
            return
        end
        local v4 = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
        local Unit = if not (1 < v4.Magnitude) then -HumanoidRootPart.CFrame.LookVector else v4.Unit
        v4 = Vector3.new(0, 1, 0):Cross(Unit)
        if v4.Magnitude < 0.001 then
            return
        end
        local v5 = v4.Unit * v1
        v4 = {}
        for i, j in u23 do
            v3 = a1:FindFirstChild(j)
            if v3 and v3:IsA("BasePart") then
                v3.AssemblyAngularVelocity = v5
                v4[v3] = true
            end
        end
        if v2 <= 0 then
            return
        end
        v1 = Random.new()
        for k, n in a2.Disabled do
            Part1 = n.Part1
            if Part1 and not v4[Part1] then
                Part1.AssemblyAngularVelocity = v5 + v1:NextUnitVector() * v2
            end
        end
        return
    end
end

local function restore(a1) -- Line: 107 -- types: a1: table
    for i, j in a1.Created do
        j:Destroy()
    end
    for k, n in a1.Disabled do
        if n.Parent then
            n.Enabled = true
        end
    end
end

local function watch(a1) -- Line: 118
    -- upvalues: restore (val), Physics (val), Ragdoll (val), RunService (val), limp (val), tumble (val)
    local Humanoid = a1:WaitForChild("Humanoid", 10)
    if Humanoid ~= nil and Humanoid:IsA("Humanoid") then
        local u10 = nil
        local u11 = 0

        local function settle() -- Line: 125 -- upvalues: u11 (ref), u10 (ref), restore (upval)
            u11 = u11 + 1
            if u10 then
                restore(u10)
                u10 = nil
            end
        end

        Humanoid.StateChanged:Connect(function(a1_2, a2) -- Line: 132
            -- upvalues: Physics (upval), u11 (ref), u10 (ref), restore (upval), Ragdoll (upval), RunService (upval)
            -- upvalues: a1 (val), Humanoid (val), limp (upval), tumble (upval)
            if a2 ~= Physics then
                u11 = u11 + 1
                if u10 then
                    restore(u10)
                    u10 = nil
                end
                return
            end
            u11 = u11 + 1
            local u12 = u11
            local u20 = math.clamp(math.floor(Ragdoll.LOCAL_LIMP_FRAMES), 0, 30)
            if not (u20 <= 0) and not u10 then
                task.spawn(function() -- Line: 143
                    -- upvalues: u20 (val), RunService (upval), u12 (val), u11 (upval), u10 (upval), a1 (upval)
                    -- upvalues: Humanoid (upval), Physics (upval), limp (upval), tumble (upval)
                    local v1 = u20
                    for i = 1, v1 do
                        RunService.PostSimulation:Wait()
                    end
                    if u12 == u11 and not u10 and a1.Parent ~= nil and (Humanoid:GetState()) == Physics then
                        v1 = limp(a1)
                        u10 = v1
                        tumble(a1, v1)
                        return
                    end
                end)
                return
            end
        end)
        a1.AncestryChanged:Connect(function() -- Line: 155 -- upvalues: a1 (val), u11 (ref), u10 (ref), restore (upval)
            if a1.Parent == nil then
                u11 = u11 + 1
                if u10 then
                    restore(u10)
                    u10 = nil
                end
            end
        end)
        return
    end
end

function v1.Start() -- Line: 162 -- upvalues: LocalPlayer (val), watch (val)
    LocalPlayer.CharacterAdded:Connect(watch)
    if LocalPlayer.Character then
        task.spawn(watch, LocalPlayer.Character)
    end
end

return v1