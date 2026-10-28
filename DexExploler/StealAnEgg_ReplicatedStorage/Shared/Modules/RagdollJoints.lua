-- Script path: ReplicatedStorage.Shared.Modules.RagdollJoints
-- Decompile time: 3.79 ms

local u0 = {Attachment = true}
local u1 = {BallSocketConstraint = true, HingeConstraint = true}
local u2 = {Root = true, Neck = true}
local v1 = {}

local function purgeTagged(a1, a2, a3, a4) -- Line: 19 -- types: a1: userdata?, a2: string, a3: table, a4: string?
    local Attribute
    local v1 = if not a1 then {} else a1:GetChildren()
    local v2 = nil
    local v3 = nil
    local v4, v5 = a3, a2
    for i, j in v1, v2, v3 do
        Attribute = v4[j.ClassName] and j:GetAttribute(v5)
        if Attribute then
            if not v6 or Attribute == v6 then
                j:Destroy()
            end
        end
    end
end

local function unrig(a1) -- Line: 33 -- upvalues: purgeTagged (val), u1 (val), u0 (val) -- types: a1: userdata
    purgeTagged(a1.Parent, "RagdollConstraint", u1, a1.Name)
    purgeTagged(a1.Part0, "RagdollAttachment", u0, a1.Name)
    purgeTagged(a1.Part1, "RagdollAttachment", u0, a1.Name)
end

local function anchorPoint(a1, a2, a3, a4) -- Line: 39 -- types: a1: userdata, a2: string, a3: string, a4: userdata
    local Attachment = Instance.new("Attachment")
    Attachment.Name = ("RagdollAttachment_%*_%*"):format(a2, a3)
    Attachment:SetAttribute("RagdollAttachment", a2)
    Attachment.Parent = a1
    Attachment.CFrame = a4
    return Attachment
end

local function rig(a1) -- Line: 48 -- upvalues: purgeTagged (val), u1 (val), u0 (val), u2 (val) -- types: a1: userdata
    local Part0 = a1.Part0
    local Part1 = a1.Part1
    if Part0 and Part1 then
        purgeTagged(a1.Parent, "RagdollConstraint", u1, a1.Name)
        purgeTagged(a1.Part0, "RagdollAttachment", u0, a1.Name)
        purgeTagged(a1.Part1, "RagdollAttachment", u0, a1.Name)
        local Name = a1.Name
        local BallSocketConstraint = Instance.new("BallSocketConstraint")
        local C0 = a1.C0
        local v1 = Instance.new("Attachment")
        v1.Name = ("RagdollAttachment_%*_A"):format(Name)
        v1:SetAttribute("RagdollAttachment", Name)
        v1.Parent = Part0
        v1.CFrame = C0
        local C1 = a1.C1
        local v2 = Instance.new("Attachment")
        v2.Name = ("RagdollAttachment_%*_B"):format(Name)
        v2:SetAttribute("RagdollAttachment", Name)
        v2.Parent = Part1
        v2.CFrame = C1
        BallSocketConstraint.Name = ("RagdollConstraint_%*"):format(Name)
        BallSocketConstraint:SetAttribute("RagdollConstraint", Name)
        BallSocketConstraint.Parent = a1.Parent
        BallSocketConstraint.Attachment0 = v1
        BallSocketConstraint.Attachment1 = v2
        BallSocketConstraint.LimitsEnabled = true
        BallSocketConstraint.TwistLimitsEnabled = true
        if not u2[Name] then
            return BallSocketConstraint
        end
        BallSocketConstraint:Destroy()
        local v3 = Instance.new("HingeConstraint")
        v3.Name = ("RagdollConstraint_%*"):format(Name)
        v3:SetAttribute("RagdollConstraint", Name)
        v3.Parent = a1.Parent
        v3.Attachment0 = v1
        v3.Attachment1 = v2
        v3.LimitsEnabled = true
        return v3
    end
    return nil
end

local function joinsTool(a1) -- Line: 89 -- types: a1: userdata
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

local function eachMotor(a1, a2) -- Line: 95 -- types: a1: userdata, a2: function
    local Part1, v1
    for i, j in a1:GetDescendants() do
        if j:IsA("Motor6D") then
            Part1 = j.Part1
            v1 = true
            if j:FindFirstAncestorOfClass("Tool") == nil then
                v1 = false
                if Part1 ~= nil then
                    v1 = Part1:FindFirstAncestorOfClass("Tool") ~= nil
                end
            end
            if not v1 then
                a2(j)
            end
        end
    end
end

function v1.Bind(a1) -- Line: 103 -- upvalues: eachMotor (val), rig (val) -- types: a1: userdata
    eachMotor(a1, function(a1) -- Line: 104 -- upvalues: rig (upval)
        rig(a1)
        a1.Enabled = false
    end)
end

function v1.Release(a1) -- Line: 110
    -- upvalues: eachMotor (val), purgeTagged (val), u1 (val), u0 (val)
    eachMotor(a1, function(a1) -- Line: 111 -- upvalues: purgeTagged (upval), u1 (upval), u0 (upval)
        if a1.Parent then
            purgeTagged(a1.Parent, "RagdollConstraint", u1, a1.Name)
            purgeTagged(a1.Part0, "RagdollAttachment", u0, a1.Name)
            purgeTagged(a1.Part1, "RagdollAttachment", u0, a1.Name)
            a1.Enabled = true
        end
    end)
end

return v1