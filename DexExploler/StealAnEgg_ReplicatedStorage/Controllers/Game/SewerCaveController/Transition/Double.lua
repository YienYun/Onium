-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Double
-- Decompile time: 10.07 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Trove)
local u41 = table.freeze({
    Waist = {"Waist", "RootJoint"},
    Neck = {"Neck"},
    LShoulder = {"LeftShoulder", "Left Shoulder"},
    RShoulder = {"RightShoulder", "Right Shoulder"},
    LElbow = {"LeftElbow"},
    RElbow = {"RightElbow"},
    LHip = {"LeftHip", "Left Hip"},
    RHip = {"RightHip", "Right Hip"},
    LKnee = {"LeftKnee"},
    RKnee = {"RightKnee"},
})
local u53 = table.freeze({
    "LuaSourceContainer",
    "Sound",
    "ForceField",
    "BillboardGui",
    "ProximityPrompt",
    "Animator",
    "BodyMover",
    "Tool",
})
local v1 = {
    Poses = table.freeze({
        Rest = table.freeze({}),
        Trip = table.freeze({
            Waist = Vector3.new(25, 0, 0),
            Neck = Vector3.new(10, 0, 0),
            LShoulder = Vector3.new(20, 0, -130),
            RShoulder = Vector3.new(20, 0, 130),
            LElbow = Vector3.new(30, 0, 0),
            RElbow = Vector3.new(30, 0, 0),
            LHip = Vector3.new(35, 0, 0),
            RHip = Vector3.new(10, 0, 0),
            LKnee = Vector3.new(-20, 0, 0),
            RKnee = Vector3.new(-30, 0, 0),
        }),
        Surf = table.freeze({
            Waist = Vector3.new(-8, 12, 0),
            Neck = Vector3.new(-5, -12, 0),
            LShoulder = Vector3.new(0, 0, -88),
            RShoulder = Vector3.new(0, 0, 88),
            LElbow = Vector3.new(18, 0, 0),
            RElbow = Vector3.new(18, 0, 0),
            LHip = Vector3.new(18, 0, -8),
            RHip = Vector3.new(-14, 0, 8),
            LKnee = Vector3.new(-32, 0, 0),
            RKnee = Vector3.new(-28, 0, 0),
        }),
        Flail = table.freeze({
            Waist = Vector3.new(10, 0, 0),
            Neck = Vector3.new(18, 0, 0),
            LShoulder = Vector3.new(0, 0, -150),
            RShoulder = Vector3.new(0, 0, 150),
            LElbow = Vector3.new(35, 0, 0),
            RElbow = Vector3.new(35, 0, 0),
            LHip = Vector3.new(30, 0, 0),
            RHip = Vector3.new(-20, 0, 0),
            LKnee = Vector3.new(-40, 0, 0),
            RKnee = Vector3.new(-20, 0, 0),
        }),
        Teeter = table.freeze({
            Waist = Vector3.new(-22, 0, 0),
            Neck = Vector3.new(-20, 0, 0),
            LShoulder = Vector3.new(60, 0, -100),
            RShoulder = Vector3.new(-60, 0, 100),
            LHip = Vector3.new(-25, 0, 0),
            RHip = Vector3.new(5, 0, 0),
            LKnee = Vector3.new(-35, 0, 0),
        }),
        Grabbed = table.freeze({
            Waist = Vector3.new(8, 0, 0),
            Neck = Vector3.new(24, 0, 0),
            LShoulder = Vector3.new(15, 0, -168),
            RShoulder = Vector3.new(15, 0, 168),
            LElbow = Vector3.new(20, 0, 0),
            RElbow = Vector3.new(20, 0, 0),
            LHip = Vector3.new(0, 0, 4),
            RHip = Vector3.new(0, 0, -4),
        }),
        Dive = table.freeze({
            Neck = Vector3.new(30, 0, 0),
            LShoulder = Vector3.new(0, 0, -172),
            RShoulder = Vector3.new(0, 0, 172),
            LElbow = Vector3.new(8, 0, 0),
            RElbow = Vector3.new(8, 0, 0),
            LKnee = Vector3.new(-12, 0, 0),
            RKnee = Vector3.new(-12, 0, 0),
        }),
        Cannonball = table.freeze({
            Waist = Vector3.new(-28, 0, 0),
            Neck = Vector3.new(-18, 0, 0),
            LShoulder = Vector3.new(70, 0, -18),
            RShoulder = Vector3.new(70, 0, 18),
            LElbow = Vector3.new(85, 0, 0),
            RElbow = Vector3.new(85, 0, 0),
            LHip = Vector3.new(112, 0, -6),
            RHip = Vector3.new(112, 0, 6),
            LKnee = Vector3.new(-128, 0, 0),
            RKnee = Vector3.new(-128, 0, 0),
        }),
        Squash = table.freeze({
            Waist = Vector3.new(-18, 0, 0),
            Neck = Vector3.new(-6, 0, 0),
            LShoulder = Vector3.new(10, 0, -55),
            RShoulder = Vector3.new(10, 0, 55),
            LElbow = Vector3.new(30, 0, 0),
            RElbow = Vector3.new(30, 0, 0),
            LHip = Vector3.new(48, 0, -10),
            RHip = Vector3.new(48, 0, 10),
            LKnee = Vector3.new(-70, 0, 0),
            RKnee = Vector3.new(-70, 0, 0),
        }),
        Slide = table.freeze({
            Neck = Vector3.new(35, 0, 0),
            LShoulder = Vector3.new(0, 0, -165),
            RShoulder = Vector3.new(0, 0, 165),
            LKnee = Vector3.new(-25, 0, 0),
            RKnee = Vector3.new(-10, 0, 0),
        }),
    }),
}

local function strip(a1) -- Line: 166 -- upvalues: u53 (val) -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        for k, n in u53 do
            if j:IsA(n) then
                j:Destroy()
                break
            end
        end
    end
end

local function findMotor(a1, a2) -- Line: 177 -- types: a1: userdata, a2: table
    for i, j in a1:GetDescendants() do
        if j:IsA("Motor6D") and table.find(a2, j.Name) ~= nil then
            return j
        end
    end
    return nil
end

local function toRadians(a1) -- Line: 186 -- types: a1: vector
    return CFrame.Angles(math.rad(a1.X), math.rad(a1.Y), (math.rad(a1.Z)))
end

function v1.Build(a1, a2, a3) -- Line: 194
    -- upvalues: strip (val), u41 (val), findMotor (val)
    local Humanoid = a2:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart")
    if Humanoid ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local Archivable = a2.Archivable
        a2.Archivable = true
        local success, err = pcall(function() -- Line: 202 -- upvalues: a2 (val)
            return a2:Clone()
        end)
        a2.Archivable = Archivable
        if success and err ~= nil and err:IsA("Model") then
            local v1 = a1:Add(err)
            v1.Name = "SewerDrainDouble"
            strip(v1)
            local HumanoidRootPart_2 = v1:FindFirstChild("HumanoidRootPart")
            local v2 = v1:FindFirstChildOfClass("Humanoid")
            if HumanoidRootPart_2 ~= nil and v2 ~= nil then
                local v3, v4, v5
                v2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                v2.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                v2.BreakJointsOnDeath = false
                v2.RequiresNeck = false
                v2.EvaluateStateMachine = false
                v2 = {}
                for i, j in v1:GetDescendants() do
                    if j:IsA("BasePart") then
                        v3 = j == HumanoidRootPart_2
                        j.Anchored = v3
                        j.CanCollide = false
                        j.CanQuery = false
                        j.CanTouch = false
                        j.Massless = true
                        table.insert(v2, j)
                    elseif j:IsA("ParticleEmitter") or j:IsA("Trail") then
                        j.Enabled = false
                    end
                end
                HumanoidRootPart_2.Transparency = 1
                local v6 = {}
                for k, n in u41 do
                    v4 = findMotor(v1, n)
                    if v4 ~= nil then
                        v4.Transform = CFrame.identity
                        v5 = {Motor = v4, Rotation = v4.C0.Rotation}
                        v6[k] = v5
                    end
                end
                local Highlight = Instance.new("Highlight")
                Highlight.Name = "Grip"
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight.FillColor = Color3.fromRGB(80, 220, 190)
                Highlight.OutlineColor = Color3.fromRGB(200, 255, 240)
                Highlight.FillTransparency = 1
                Highlight.OutlineTransparency = 1
                Highlight.Adornee = v1
                Highlight.Parent = v1
                v1.Parent = a3
                HumanoidRootPart_2.CFrame = HumanoidRootPart.CFrame
                local Head = v1:FindFirstChild("Head")
                local v7 = {Model = v1, Root = HumanoidRootPart_2}
                v7.Head = if Head == nil then nil else if not Head:IsA("BasePart") then nil else Head
                v7.Joints = v6
                v7.Stance = if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2 else 3
                v7.Parts = v2
                v7.Glow = Highlight
                return v7
            end
            return nil
        end
        return nil
    end
    return nil
end

function v1.Blend(a1, a2, a3) -- Line: 269 -- upvalues: u41 (val) -- types: a1: table, a2: table, a3: number
    local v1, v2
    local v3 = {}
    for i in u41 do
        v2 = a1[i] or Vector3.new(0, 0, 0)
        v1 = a2[i]
        v3[i] = (v2:Lerp(v1 or Vector3.new(0, 0, 0), a3))
    end
    return v3
end

function v1.Pose(a1, a2, a3) -- Line: 279 -- types: a1: table, a2: table, a3: table?
    local Rotation, v1
    local Joints = a1.Joints
    local v2 = nil
    local v3 = nil
    local v4, v5 = a2, a3
    for i, j in Joints, v2, v3 do
        v1 = v4[i] or Vector3.new(0, 0, 0)
        if v5 and v5[i] then
            v1 = v1 + v5[i]
        end
        Rotation = j.Rotation
        j.Motor.Transform = (Rotation:Inverse()) * CFrame.Angles(math.rad(v1.X), math.rad(v1.Y), (math.rad(v1.Z))) * Rotation
    end
end

function v1.Place(a1, a2) -- Line: 290 -- types: a1: table, a2: userdata
    a1.Root.CFrame = a2
end

function v1.Visible(a1, a2) -- Line: 294 -- types: a1: table, a2: boolean
    local v1 = if not a2 then 1 else 0
    for i, j in a1.Parts do
        if j ~= a1.Root then
            j.LocalTransparencyModifier = v1
        end
    end
    for k, n in a1.Model:GetDescendants() do
        if n:IsA("Decal") then
            n.LocalTransparencyModifier = v1
        end
    end
end

function v1.Cloak(a1, a2) -- Line: 308 -- upvalues: Players (val) -- types: a2: userdata
    local u2 = {}
    local u3 = {}
    local u4 = {}
    for i, j in a2:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(u2, j)
        elseif j:IsA("Decal") then
            table.insert(u3, j)
        elseif j:IsA("BillboardGui") then
            u4[j] = j.Enabled
            j.Enabled = false
        end
    end
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PlayerGui ~= nil then
        local Adornee
        for k, n in PlayerGui:GetDescendants() do
            if n:IsA("BillboardGui") and n.Enabled then
                Adornee = n.Adornee
                if Adornee ~= nil and Adornee:IsDescendantOf(a2) then
                    u4[n] = true
                    n.Enabled = false
                end
            end
        end
    end
    local u51 = false

    local function step() -- Line: 335 -- upvalues: u51 (ref), u2 (val), u3 (val)
        if u51 then
            return
        end
        for i, j in u2 do
            j.LocalTransparencyModifier = 1
        end
        for k, n in u3 do
            n.LocalTransparencyModifier = 1
        end
    end

    local function lift() -- Line: 346 -- upvalues: u51 (ref), u2 (val), u3 (val), u4 (val)
        if u51 then
            return
        end
        u51 = true
        for i, j in u2 do
            j.LocalTransparencyModifier = 0
        end
        for k, n in u3 do
            n.LocalTransparencyModifier = 0
        end
        for m, i5 in u4 do
            if m.Parent ~= nil then
                m.Enabled = i5
            end
        end
    end

    a1:Add(lift)
    if not u51 then
        for m, i5 in u2 do
            i5.LocalTransparencyModifier = 1
        end
        for i6, i7 in u3 do
            i7.LocalTransparencyModifier = 1
        end
    end
    return {Step = step, Lift = lift}
end

return table.freeze(v1)