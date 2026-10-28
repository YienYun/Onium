-- Script path: ReplicatedStorage.Shared.Modules.TrainEventArt
-- Decompile time: 11.02 ms

local u0 = {
    Ghosts = {
        LostSpirit = {
            Model = "Ghost1",
            AnimationRoot = "Armature",
            Idle = 83195814978221,
            Walk = 110476420994709,
            Attack = 121163208323387,
        },
        HauntedSpirit = {
            Model = "Ghost2",
            AnimationRoot = "Armature.001",
            Idle = 96923738184871,
            Walk = 128935996676112,
            Attack = 110706809339821,
        },
        VengefulSpirit = {
            Model = "Ghost3",
            AnimationRoot = "Armature.002.R.R",
            Idle = 92799674822941,
            Walk = 83240968311331,
            Attack = 86700689938095,
        },
    },
}

local function clean(a1) -- Line: 9
    for i, j in a1:GetDescendants() do
        assert(not j:IsA("LuaSourceContainer"), "Train artwork must not contain scripts")
    end
end

function u0.Sources(a1) -- Line: 12 -- upvalues: u0 (val), clean (val)
    local v1
    assert(a1, "ServerStorage.TrainEventAssets.HalloweenEventAssets is missing")
    local Ghosts = a1:FindFirstChild("Ghosts")
    assert(Ghosts, "HalloweenEventAssets.Ghosts missing")
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5 = a1
    for i, j in u0.Ghosts, v3, v4 do
        v1 = Ghosts:FindFirstChild(j.Model)
        assert(
            v1 and v1:IsA("Model") and v1.PrimaryPart and v1:FindFirstChildWhichIsA("AnimationController", true),
            "Invalid ghost rig: " .. j.Model
        )
        clean(v1)
        v2[i] = v1
    end
    local v6 = v5:FindFirstChild("Ghost Vacuum")
    assert(v6 and v6:IsA("Tool") and v6:FindFirstChild("Handle") and v6.Handle:IsA("BasePart"), "Ghost Vacuum needs a Tool with Handle")
    local v7 = v5:FindFirstChild("Ghost Backpack")
    assert(v7 and v7:IsA("Model") and v7:FindFirstChildWhichIsA("BasePart", true), "Ghost Backpack model missing")
    clean(v6)
    clean(v7)
    v2.GhostVacuum = v6
    v2.GhostBackpack = v7
    return v2
end

local function visibleBounds(a1, a2) -- Line: 28
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = Vector3.new((1 / 0), (1 / 0), (1 / 0))
    local v9 = -v8
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            v7 = {-1, 1}
            v1 = nil
            v2 = nil
            for k, n in v7, v1, v2 do
                v3 = {-1, 1}
                v4 = nil
                v5 = nil
                for m, i5 in v3, v4, v5 do
                    for i6, i7 in {-1, 1} do
                        v6 = a2.CFrame:PointToObjectSpace((j.CFrame:PointToWorldSpace(j.Size * (Vector3.new(n, i5, i7)) / 2)))
                        v8 = Vector3.new(math.min(v8.X, v6.X), math.min(v8.Y, v6.Y), (math.min(v8.Z, v6.Z)))
                        v9 = Vector3.new(math.max(v9.X, v6.X), math.max(v9.Y, v6.Y), (math.max(v9.Z, v6.Z)))
                    end
                end
            end
        end
    end
    assert(v8.X < (1 / 0), "Artwork has no visible geometry")
    return (v8 + v9) / 2, v9 - v8
end

function u0.GhostTemplate(a1, a2) -- Line: 40 -- upvalues: u0 (val), visibleBounds (val)
    local v1, v2, v3
    local v4 = a1:Clone()
    v4.Name = a2
    local PrimaryPart = v4.PrimaryPart
    PrimaryPart.Name = u0.Ghosts[a2].AnimationRoot
    if a2 == "LostSpirit" then
        v2 = assert(PrimaryPart:FindFirstChild("Body"), "Lost Spirit body bone missing")
        assert(v2:IsA("Bone"), "Lost Spirit body must be a Bone")
        local Bone = Instance.new("Bone")
        Bone.Name = "Root"
        Bone.Parent = PrimaryPart
        v2.Parent = Bone
    end
    v2, v3 = visibleBounds(v4, PrimaryPart)
    PrimaryPart.PivotOffset = CFrame.new(v2)
    v4:SetAttribute("GhostHalfHeight", v3.Y / 2)
    for i, j in v4:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j == PrimaryPart
            j.Anchored = v1
            j.Massless = true
            j.CanCollide = false
            j.CanTouch = false
            j.CanQuery = false
        end
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "GhostAnimations"
    Folder.Parent = v4
    for k, n in {"Idle", "Walk", "Attack"} do
        v2 = Instance.new("Animation")
        v2.Name = n
        v2.AnimationId = "rbxassetid://" .. tostring(u0.Ghosts[a2][n])
        v2.Parent = Folder
    end
    local AnimationController = v4:FindFirstChildWhichIsA("AnimationController", true)
    if not AnimationController:FindFirstChildOfClass("Animator") then
        Instance.new("Animator", AnimationController)
    end
    v4:PivotTo(CFrame.identity)
    return v4
end

function u0.Tool(a1, a2, a3) -- Line: 65
    local v1 = a1:Clone()
    v1.Name = "Ghost Vacuum"
    v1.CanBeDropped = false
    v1:SetAttribute("GhostVacuum", true)
    v1:SetAttribute("TrainVacuumVisit", a3)
    v1:SetAttribute("DisplayName", "Ghost Vacuum")
    local Handle = v1.Handle
    local v2 = {}
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v2, {Part = j, Frame = a2 * Handle.CFrame:ToObjectSpace(j.CFrame)})
        end
    end
    for k, n in v2 do
        n.Part.Anchored = true
    end
    for m, i5 in v2 do
        i5.Part.CFrame = i5.Frame
    end
    local v3 = v2
    local v4 = nil
    local v5 = nil
    for i6, i7 in v3, v4, v5 do
        i7.Part.Anchored = false
        i7.Part.Massless = true
        i7.Part.CanCollide = false
        i7.Part.CanTouch = false
        i7.Part.CanQuery = false
    end
    if not v1:FindFirstChild("Nozzle", true) then
        local Part, v6, v7, v8, v9, v10, v11, v12
        v3 = (-1 / 0)
        v5 = nil
        local v13 = nil
        for i8, i9 in v2, v5, v13 do
            Part = i9.Part
            v6 = Handle.CFrame:ToObjectSpace(Part.CFrame)
            v7 = {-1, 1}
            v8 = nil
            v9 = nil
            for i10, i11 in v7, v8, v9 do
                v10 = {-1, 1}
                v11 = nil
                v12 = nil
                for i12, i13 in v10, v11, v12 do
                    for i14, i15 in {-1, 1} do
                        v3 = math.max(v3, (v6:PointToWorldSpace(Part.Size * (Vector3.new(i11, i13, i15)) / 2)).X)
                    end
                end
            end
        end
        local v14 = Instance.new("Attachment")
        v14.Name = "Nozzle"
        v4 = Vector3.new(v3, 0.27, 0)
        v14.CFrame = CFrame.lookAt(v4, v4 + Vector3.new(1, 0, 0))
        v14.Parent = Handle
    end
    return v1
end

function u0.Display(a1, a2) -- Line: 85
    local v1 = a1:Clone()
    local Model = Instance.new("Model")
    Model.Name = "GhostVacuum"
    for i, j in v1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
            j.CanCollide = false
            j.CanTouch = false
            j.CanQuery = false
        end
    end
    local Handle = v1.Handle
    for k, n in v1:GetChildren() do
        n.Parent = Model
    end
    v1:Destroy()
    Model.PrimaryPart = Handle
    Model:PivotTo(a2)
    return Model
end

function u0.Backpack(a1, a2, a3, a4) -- Line: 93
    local UpperTorso = a2:FindFirstChild("UpperTorso") or a2:FindFirstChild("Torso")
    if UpperTorso and UpperTorso:IsA("BasePart") then
        local BoundingBox_4, v1
        local v2 = a1:Clone()
        v2.Name = "TrainVacuumBackpack"
        v2:SetAttribute("TrainVacuumVisit", a4)
        local BasePart = v2:FindFirstChildWhichIsA("BasePart", true)
        v2.PrimaryPart = BasePart
        local BoundingBox, BoundingBox_2 = v2:GetBoundingBox()
        BasePart.PivotOffset = BasePart.CFrame:ToObjectSpace((CFrame.new(BoundingBox.Position)) * BasePart.CFrame.Rotation)
        local v3 = a2:FindFirstChildOfClass("Humanoid")
        local v4 = v3 and v3:FindFirstChild("BodyHeightScale")
        v2:ScaleTo(v2:GetScale() * a3 * (if not v4 then 1 else if not v4:IsA("NumberValue") then 1 else v4.Value) / BoundingBox_2.Y)
        _, BoundingBox_4 = v2:GetBoundingBox()
        v2:PivotTo(UpperTorso.CFrame * (CFrame.new(0, -0.15, (UpperTorso.Size.Z + BoundingBox_4.Z) / 2 + 0.12)))
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = false
                j.Massless = true
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = false
                v1 = Instance.new("WeldConstraint")
                v1.Part0 = UpperTorso
                v1.Part1 = j
                v1.Parent = j
            end
        end
        v2.Parent = a2
        return v2
    end
    return nil
end

function u0.Ticket(a1, a2) -- Line: 109 -- upvalues: clean (val)
    local BoundingBox_2, v1
    clean(a1)
    local v2 = a1:Clone()
    _, BoundingBox_2 = v2:GetBoundingBox()
    v2:ScaleTo(v2:GetScale() * 1.8 / BoundingBox_2.X)
    local PrimaryPart = v2.PrimaryPart or v2:FindFirstChildWhichIsA("BasePart", true)
    local CFrame_2 = PrimaryPart.CFrame
    local Tool = Instance.new("Tool")
    Tool.CanBeDropped = false
    Tool:SetAttribute("TrainTicketArtVersion", 1)
    local v3 = {}
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v3, {Part = j, Frame = a2 * CFrame_2:ToObjectSpace(j.CFrame)})
        end
    end
    for k, n in v3 do
        n.Part.Anchored = true
    end
    for m, i5 in v3 do
        i5.Part.CFrame = i5.Frame
        i5.Part.CanCollide = false
        i5.Part.CanTouch = false
        i5.Part.CanQuery = false
        i5.Part.Massless = true
        i5.Part.Parent = Tool
    end
    PrimaryPart.Name = "Handle"
    for i6, i7 in v3 do
        if i7.Part ~= PrimaryPart then
            v1 = Instance.new("WeldConstraint")
            v1.Part0 = PrimaryPart
            v1.Part1 = i7.Part
            v1.Parent = PrimaryPart
        end
    end
    for i8, i9 in v3 do
        i9.Part.Anchored = false
    end
    v2:Destroy()
    return Tool
end

return u0