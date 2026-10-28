-- Script path: ReplicatedStorage.Shared.Modules.PetMountGeometry
-- Decompile time: 18.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u10 = {}
u10.AttachmentNames = table.freeze({"MountSeat", "MountLeftHand", "MountRightHand", "MountLeftFoot", "MountRightFoot"})
u10.DefaultGripOffsets = table.freeze({
    MountLeftHand = CFrame.new(-0.8, 0.5, -0.8),
    MountRightHand = CFrame.new(0.8, 0.5, -0.8),
    MountLeftFoot = CFrame.new(-0.75, -1.6, -0.65),
    MountRightFoot = CFrame.new(0.75, -1.6, -0.65),
})

local function finiteFrame(a1) -- Line: 18 -- upvalues: u10 (val)
    for i, j in {a1:GetComponents()} do
        if not u10.IsFinite(j) then
            return false
        end
    end
    return true
end

function u10.IsFinite(a1) -- Line: 27
    local v1 = false
    if typeof(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = false
            if a1 > (-1 / 0) then
                v1 = a1 < (1 / 0)
            end
        end
    end
    return v1
end

function u10.ResolveHeight(a1, a2) -- Line: 30 -- upvalues: u10 (val)
    assert(u10.IsFinite(a1) and a1 > 0, "Pet scale must be positive and finite")
    local MinimumPetScale = a2.MinimumPetScale
    local MaximumPetScale = a2.MaximumPetScale
    local v1 = a2.ReferenceCharacterHeight * a2.MinimumHeightRatio
    local v2 = a2.ReferenceCharacterHeight * a2.MaximumHeightRatio
    assert(
        u10.IsFinite(MinimumPetScale) and u10.IsFinite(MaximumPetScale) and MinimumPetScale < MaximumPetScale,
        "Invalid mount scale range"
    )
    local v3 = u10.IsFinite(v1)
    if v3 then
        v3 = u10.IsFinite(v2)
        if v3 then
            v3 = false
            if v1 > 0 then
                v3 = v1 <= v2
            end
        end
    end
    assert(v3, "Invalid mount height range")
    local v4 = math.clamp((a1 - MinimumPetScale) / (MaximumPetScale - MinimumPetScale), 0, 1)
    return v1 + (v2 - v1) * v4
end

function u10.FindAttachment(a1, a2) -- Line: 49
    local v1
    local v2 = nil
    local v3 = a2
    for i, j in a1:GetDescendants() do
        if j.Name == v3 and j:IsA("Attachment") and not j:IsA("Bone") then
            v1 = "Duplicate " .. v3 .. " attachments"
            assert(v2 == nil, v1)
            v2 = j
        end
    end
    return v2
end

function u10.AnimatedWorld(a1) -- Line: 59 -- upvalues: u10 (val)
    local Parent = a1.Parent
    if Parent and Parent:IsA("Bone") then
        return Parent.TransformedWorldCFrame * a1.CFrame
    end
    if Parent and Parent:IsA("Attachment") then
        return (u10.AnimatedWorld(Parent)) * a1.CFrame
    end
    return a1.WorldCFrame
end

function u10.ClampAnimatedSeat(a1, a2, a3, a4) -- Line: 70 -- upvalues: finiteFrame (val), u10 (val)
    local v1
    assert(finiteFrame(a1), "Invalid animated mount seat")
    assert(u10.IsFinite(a3) and a3 >= 0, "Invalid animation seat offset limit")
    local v2 = u10.IsFinite(a4)
    if v2 then
        v2 = false
        if a4 >= 0 then
            v2 = a4 <= 180
        end
    end
    assert(v2, "Invalid animation seat tilt limit")
    if not finiteFrame(a2) then
        return a1
    end
    local v3 = a2.Position - a1.Position
    if a3 < v3.Magnitude then
        v3 = v3.Unit * a3
    end
    v2, v1 = a1.Rotation:ToObjectSpace(a2.Rotation):Orthonormalize():ToAxisAngle()
    local Rotation_3 = a1.Rotation
    if 1e-06 < v2.Magnitude and v1 == v1 then
        Rotation_3 = a1.Rotation * CFrame.fromAxisAngle(v2.Unit, (math.min(v1, (math.rad(a4)))))
    end
    return Rotation_3 + a1.Position + v3
end

function u10.EnsureSeat(a1, a2) -- Line: 99 -- upvalues: u10 (val)
    local v1 = u10.FindAttachment(a1, "MountSeat")
    local v2 = a1.PrimaryPart.CFrame * a2
    local Parent = v1 and v1.Parent
    if not Parent then
        local v3 = {
            upperbody = 1,
            torso = 2,
            chest = 3,
            body = 4,
            lowerbody = 5,
            spine = 6,
        }
        local v4 = (1 / 0)
        for i, j in a1:GetDescendants() do
            if j:IsA("Bone") then
                if (v3[j.Name:lower()] or 100) < v4 then
                    Parent = j
                end
            end
        end
        if not Parent then
            for k, n in a1:GetDescendants() do
                if n:IsA("BasePart") and v3[n.Name:lower()] then
                    Parent = n
                    break
                end
            end
        end
        Parent = Parent or a1.PrimaryPart
    end
    if not Parent:IsA("Bone") then
        local Bone = Instance.new("Bone")
        Bone.Name = "MountSeatBone"
        Bone.Parent = Parent
        Parent = Bone
    end
    v1 = v1 or Instance.new("Attachment")
    v1.Name = "MountSeat"
    v1.CFrame = Parent.WorldCFrame:ToObjectSpace(v2)
    v1.Parent = Parent
    return v1
end

function u10.EnsureGrip(a1, a2, a3, a4) -- Line: 139 -- upvalues: u10 (val)
    local Attachment = u10.FindAttachment(a1, a2) or Instance.new("Attachment")
    Attachment.Name = a2
    Attachment.Parent = a4.Parent
    Attachment.CFrame = a4.Parent.WorldCFrame:ToObjectSpace(a1.PrimaryPart.CFrame * a3)
    return Attachment
end

function u10.LimbReach(a1, a2, a3, a4, a5) -- Line: 148
    local v1 = a4 .. (if a5 ~= "Arm" then "Knee" else "Elbow") .. "RigAttachment"
    local v2 = a4 .. (if a5 ~= "Arm" then "Ankle" else "Wrist") .. "RigAttachment"
    local v3 = a1:FindFirstChild(a4 .. (if a5 ~= "Arm" then "Hip" else "Shoulder") .. "RigAttachment")
    local v4 = a1:FindFirstChild(v1)
    local v5 = a2 and a2:FindFirstChild(v1)
    v1 = a2 and a2:FindFirstChild(v2)
    local v6 = a3:FindFirstChild(v2)
    if v3 and v4 and v5 and v1 and v6 then
        return v3, ((v4.Position - v3.Position).Magnitude + (v1.Position - v5.Position).Magnitude + v6.Position.Magnitude) * 0.95
    end
    local Y = a1.Size.Y
    return nil, (Y + (a2 and a2.Size.Y or 1) + a3.Size.Y * 0.5) * 0.95
end

function u10.Measure(a1, a2, a3) -- Line: 166 -- upvalues: ModelBounds (val), finiteFrame (val), u10 (val)
    local FlyingHeightStuds, Position_2, v1, v2, v3, v4, v5, v6, v7
    local Segment1 = a1:FindFirstChild("Segment1", true) or a1.PrimaryPart
    assert(Segment1 and Segment1:IsA("BasePart"), "Pet template has no root")
    local v8, v9 = ModelBounds(a1)
    local Attribute = a1:GetAttribute("MountBoundsCFrame")
    local Attribute_2 = a1:GetAttribute("MountBoundsSize")
    if Attribute ~= nil or Attribute_2 ~= nil then
        local Attribute_3 = a1:GetAttribute("MountBoundsReferenceScale")
        v1 = false
        if typeof(Attribute) == "CFrame" then
            v1 = finiteFrame(Attribute)
        end
        assert(v1, "Invalid MountBoundsCFrame")
        v1 = false
        if typeof(Attribute_2) == "Vector3" then
            v1 = u10.IsFinite(Attribute_2.X)
            if v1 then
                v1 = u10.IsFinite(Attribute_2.Y)
                if v1 then
                    v1 = u10.IsFinite(Attribute_2.Z)
                    if v1 then
                        v1 = false
                        if 0 < Attribute_2.X then
                            v1 = false
                            if 0 < Attribute_2.Y then
                                v1 = 0 < Attribute_2.Z
                            end
                        end
                    end
                end
            end
        end
        assert(v1, "Invalid MountBoundsSize")
        assert(u10.IsFinite(Attribute_3) and Attribute_3 > 0, "Invalid MountBoundsReferenceScale")
        v7 = a1:GetScale() / Attribute_3
        v8 = Segment1.CFrame * (Attribute.Rotation + Attribute.Position * v7)
        v9 = Attribute_2 * v7
    end
    assert(u10.IsFinite(v9.Y) and 0.01 < v9.Y, "Pet template has no visible height")
    local v10 = u10.ResolveHeight(a2, a3)
    local v11 = a3.SpeciesSizeMultipliers and a3.SpeciesSizeMultipliers[a1.Name] or 1
    v7 = u10.IsFinite(v11)
    if v7 then
        v7 = false
        if v11 >= 0.5 then
            v7 = v11 <= 4
        end
    end
    assert(v7, "Invalid species mount size multiplier")
    v10 = math.clamp(v10 * v11, a3.ReferenceCharacterHeight * a3.MinimumHeightRatio, a3.ReferenceCharacterHeight * a3.MaximumHeightRatio)
    v11 = v10 / v9.Y
    local v12 = Segment1.CFrame:PointToObjectSpace(v8.Position).Y - v9.Y * 0.5
    v7 = {}
    v1 = {}
    for i, j in u10.AttachmentNames do
        v2 = u10.FindAttachment(a1, j)
        if not v2 then
            table.insert(v7, j)
        else
            assert(finiteFrame(v2.WorldCFrame), j .. " has an invalid transform")
            v1[j] = v2
        end
    end
    local Attribute_4 = a1:GetAttribute("MountSetupVersion")
    local v13 = true
    if Attribute_4 == 1 then
        v13 = a1:GetAttribute("MountNeedsReview") ~= false
    end
    assert(not (#v7 ~= 0) and not v13 or a3.AllowPrototypeAttachments, "Mount attachments need setup or visual review: " .. a1.Name)
    local Attribute_5 = a1:GetAttribute("MountReferenceHeight")
    if Attribute_4 ~= 1 then
        Attribute_5 = Attribute_5 or v9.Y
    end
    local v14 = u10.IsFinite(Attribute_5) and Attribute_5 > 0
    assert(v14, "Invalid MountReferenceHeight")
    local MountSeat = v1.MountSeat
    local v15 = MountSeat and Segment1.CFrame:ToObjectSpace(MountSeat.WorldCFrame)
    local v16 = v15 and v15.Rotation + v15.Position * v11 or CFrame.new(0, v12 * v11 + v10 * 0.75, 0)
    if MountSeat then
        assert(MountSeat.Parent:IsA("Bone"), "MountSeat must be directly inside a body Bone")
        assert(0.9 < (v16.UpVector:Dot((Vector3.new(0, 1, 0)))), "MountSeat must be upright")
        v15 = v8:PointToObjectSpace(MountSeat.WorldPosition)
        v14 = v9.Y * 0.05
        v3 = false
        if (math.abs(v15.X)) <= v9.X * 0.5 + v14 then
            v3 = (math.abs(v15.Z)) <= v9.Z * 0.5 + v14
        end
        assert(v3, "MountSeat is outside the pet's horizontal bounds")
    end
    v8 = {}
    v8.MountSeat = v16
    local DefaultGripOffsets = u10.DefaultGripOffsets
    v2 = nil
    v3 = nil
    local v17, v18 = a3, a1
    for k, n in DefaultGripOffsets, v2, v3 do
        v4 = v1[k]
        v5 = n
        if v4 and MountSeat then
            assert(v4.Parent == MountSeat.Parent, k .. " must share the MountSeat body Bone")
            v6 = MountSeat.WorldCFrame:ToObjectSpace(v4.WorldCFrame)
            v5 = v6.Rotation + v6.Position * (Attribute_5 / v9.Y)
        end
        Position_2 = v5.Position
        if k:find("Hand") ~= nil then end
        if k:find("Left") ~= nil then end
        v8[k] = v16 * v5
    end
    local v19 = v16.Position.Y - v12 * v11
    v2 = u10.IsFinite(v19)
    if v2 then
        v2 = false
        if v19 > 0 then
            v2 = v19 <= v10 + 5
        end
    end
    assert(v2, "MountSeat is outside the pet bounds")
    local v20 = false
    if v17.FlyingPets ~= nil then
        v20 = v17.FlyingPets[v18.Name] == true
    end
    v2 = u10.IsFinite(if not v20 then 0 else v17.FlyingHeightStuds)
    if v2 then
        v2 = false
        if FlyingHeightStuds >= 0 then
            v2 = FlyingHeightStuds <= 12
        end
    end
    assert(v2, "Invalid mount flying height")
    v14 = {
        Flying = v20,
        FlyingHeight = FlyingHeightStuds,
        Height = v10,
        ModelScale = v18:GetScale() * v11,
        Seat = v16,
        LeftHand = v8.MountLeftHand,
        RightHand = v8.MountRightHand,
        LeftFoot = v8.MountLeftFoot,
        RightFoot = v8.MountRightFoot,
        SeatHeight = v19,
        Missing = v7,
        NeedsReview = v13,
    }
    v2 = true
    if not (#v7 > 0) then
        v2 = v13
    end
    v14.Prototype = v2
    return v14
end

return u10