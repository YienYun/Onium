-- Script path: ReplicatedStorage.Shared.Modules.PetMountAttachmentAudit
-- Decompile time: 4.32 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetMountGeometry = require(ReplicatedStorage.Shared.Modules.PetMountGeometry)
local u10 = {}

function u10.CheckReach(a1, a2, a3) -- Line: 5 -- upvalues: PetMountGeometry (val)
    local Magnitude, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = {}
    local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart")
    assert(HumanoidRootPart, "Reference rider needs a HumanoidRootPart")
    local v11 = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
    local v12 = {"Left", "Right"}
    local v13 = nil
    local v14 = nil
    local v15, v16, v17 = a1, a2, a3
    for i, j in v12, v13, v14 do
        v1 = {"Arm", "Leg"}
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            v9 = if n ~= "Arm" then "Foot" else "Hand"
            v4 = v16:FindFirstChild(j .. "Upper" .. n)
            v5 = v16:FindFirstChild(j .. "Lower" .. n)
            v6 = v16:FindFirstChild(j .. v9)
            assert(v4 and v5 and v6, "Reference rider must be R15")
            v7, v8 = PetMountGeometry.LimbReach(v4, v5, v6, j, n)
            assert(v7, "Reference rider is missing joint attachments")
            v6 = v11:PointToObjectSpace(v7.WorldPosition)
            if n == "Arm" then
                v5 = v11:PointToObjectSpace(v16.UpperTorso.WaistRigAttachment.WorldPosition)
                v6 = v5 + (CFrame.Angles(-math.rad(v17), 0, 0)):VectorToWorldSpace(v6 - v5)
            end
            v4 = j .. v9
            Magnitude = (v15.Seat:PointToObjectSpace(v15[v4].Position) - v6).Magnitude
            v10[v4] = {
                Distance = Magnitude,
                Reach = v8,
                Ratio = Magnitude / v8,
                Pass = Magnitude <= v8,
            }
        end
    end
    return v10
end

function u10.Inspect(a1, a2, a3) -- Line: 33 -- upvalues: PetMountGeometry (val), u10 (val)
    local err, err_2, success, success_2
    local u3 = {Name = a1.Name}
    u3.Issues = {}
    u3.Warnings = {}
    u3.Sizes = {}
    if a1:GetAttribute("MountSetupVersion") ~= 1 then
        table.insert(u3.Issues, "MountSetupVersion must be 1")
    end
    if a1:GetAttribute("MountNeedsReview") ~= false then
        table.insert(u3.Warnings, "Seat and animations need visual review")
    end
    local u30 = table.clone(a2)
    u30.AllowPrototypeAttachments = true
    for i, j in PetMountGeometry.AttachmentNames do
        success_2, err_2 = pcall(PetMountGeometry.FindAttachment, a1, j)
        if not success_2 then
            table.insert(u3.Issues, (tostring(err_2)))
        elseif not err_2 then
            table.insert(u3.Issues, "Missing " .. j)
        end
    end
    for k, n in {
        a2.MinimumPetScale,
        1,
        (a2.MinimumPetScale + a2.MaximumPetScale) * 0.5,
        a2.MaximumPetScale,
    } do
        success, err = pcall(function() -- Line: 45
            -- upvalues: PetMountGeometry (upval), a1 (val), n (val), u30 (val), u10 (upval), a3 (val), a2 (val)
            -- upvalues: u3 (val)
            local Issues, v1
            local v2 = PetMountGeometry.Measure(a1, n, u30)
            local v3 = u10.CheckReach(v2, a3, a2.TorsoLeanDegrees or 25)
            for i, j in v3 do
                if not j.Pass then
                    Issues = u3.Issues
                    v1 = tostring(n)
                    table.insert(Issues, i .. " is out of reach at pet scale " .. v1)
                end
            end
            return {Scale = n, Height = v2.Height, Reach = v3}
        end)
        if not success then
            table.insert(u3.Issues, (tostring(err)))
            break
        else
            table.insert(u3.Sizes, err)
        end
    end
    u3.Pass = #u3.Issues == 0
    local Pass = u3.Pass and #u3.Warnings == 0
    u3.Ready = Pass
    return u3
end

return u10