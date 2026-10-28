-- Script path: ReplicatedStorage.Shared.Eggs.ParasiteVisual
-- Decompile time: 20.53 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasiteWindow = require(ReplicatedStorage.Shared.Util.MonsterParasiteWindow)
local PartBounds = require(ReplicatedStorage.Shared.Utils.PartBounds)
local u29 = {}
local u30 = nil
local u34 = setmetatable({}, {__mode = "k"})

local function resolveTemplate() -- Line: 67 -- upvalues: ReplicatedStorage (val), MonsterParasite (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Models = if not Assets then nil else Assets:FindFirstChild("Models")
    local v1 = if not Models then nil else Models:FindFirstChild(MonsterParasite.AssetsFolderName)
    local v2 = if not v1 then nil else v1:FindFirstChild(MonsterParasite.ParasiteModelName)
    if v2 and v2:IsA("Model") and v2.PrimaryPart then
        return v2
    end
    return nil
end

local function getIdleAnimation() -- Line: 83 -- upvalues: u30 (ref), MonsterParasite (val)
    local v1 = u30
    if v1 == nil then
        v1 = Instance.new("Animation")
        v1.Name = "ParasiteIdle"
        v1.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
        u30 = v1
    end
    return v1
end

local function stripEditorOnly(a1) -- Line: 95 -- types: a1: userdata
    local InitialPoses = a1:FindFirstChild("InitialPoses")
    if InitialPoses then
        InitialPoses:Destroy()
    end
    local AnimSaves = a1:FindFirstChild("AnimSaves")
    if AnimSaves then
        AnimSaves:Destroy()
    end
end

local function configureParts(a1, a2) -- Line: 106 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = a2
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.Massless = true
        end
    end
end

local function partInside(a1, a2) -- Line: 118 -- types: a1: userdata, a2: userdata?
    local v1 = false
    if a2 ~= nil then
        v1 = a2:IsDescendantOf(a1)
    end
    return v1
end

local function destroyIfExternalJoint(a1, a2, a3, a4) -- Line: 122
    -- upvalues: 
    if a1.Name == "ParasiteEggWeld" then
        a1:Destroy()
    else
        local v1 = false
        if a2 ~= nil then
            v1 = a2:IsDescendantOf(a4)
        end
        if not v1 then
            a1:Destroy()
        else
            v1 = false
            if a3 ~= nil then
                v1 = a3:IsDescendantOf(a4)
            end
            if not v1 then
                a1:Destroy()
            end
        end
    end
end

local function stripExternalJointsAndBillboards(a1) -- Line: 137 -- types: a1: userdata
    local Part0, Part1, v1
    local v2 = a1
    for i, j in a1:GetDescendants() do
        if j:IsA("BillboardGui") then
            j:Destroy()
        elseif not j:IsA("Attachment") then
            if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") then
                Part0 = j.Part0
                Part1 = j.Part1
                if j.Name == "ParasiteEggWeld" then
                    j:Destroy()
                else
                    v1 = false
                    if Part0 ~= nil then
                        v1 = Part0:IsDescendantOf(v2)
                    end
                    if not v1 then
                        j:Destroy()
                    else
                        v1 = false
                        if Part1 ~= nil then
                            v1 = Part1:IsDescendantOf(v2)
                        end
                        if not v1 then
                            j:Destroy()
                        end
                    end
                end
            end
        elseif j.Name == "MonsterParasiteIconAnchor" then
            j:Destroy()
        elseif j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") then
            Part0 = j.Part0
            Part1 = j.Part1
            if j.Name == "ParasiteEggWeld" then
                j:Destroy()
            else
                v1 = false
                if Part0 ~= nil then
                    v1 = Part0:IsDescendantOf(v2)
                end
                if not v1 then
                    j:Destroy()
                else
                    v1 = false
                    if Part1 ~= nil then
                        v1 = Part1:IsDescendantOf(v2)
                    end
                    if not v1 then
                        j:Destroy()
                    end
                end
            end
        end
    end
end

local function weldToEgg(a1, a2) -- Line: 157 -- types: a1: userdata, a2: userdata
    local ParasiteEggWeld = a2:FindFirstChild("ParasiteEggWeld")
    if ParasiteEggWeld then
        ParasiteEggWeld:Destroy()
    end
    local Motor6D = Instance.new("Motor6D")
    Motor6D.Name = "ParasiteEggWeld"
    Motor6D.Part0 = a1
    Motor6D.Part1 = a2
    Motor6D.C0 = (a1.CFrame:Inverse()) * a2.CFrame
    Motor6D.Parent = a2
    return Motor6D
end

local function poseDrift(a1) -- Line: 178 -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    local Bone = if not PrimaryPart then nil else PrimaryPart:FindFirstChildWhichIsA("Bone")
    if PrimaryPart ~= nil and Bone ~= nil then
        return Bone.TransformedWorldCFrame.Position - (PrimaryPart.CFrame * Bone.CFrame).Position
    end
    return (Vector3.new(0, 0, 0))
end

local function poseTransform(a1) -- Line: 193 -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    local Bone = if not PrimaryPart then nil else PrimaryPart:FindFirstChildWhichIsA("Bone")
    if PrimaryPart ~= nil and Bone ~= nil then
        return (PrimaryPart.CFrame:Inverse()) * Bone.TransformedWorldCFrame * Bone.CFrame:Inverse()
    end
    return CFrame.identity
end

local function poseMoved(a1, a2) -- Line: 205 -- types: a1: userdata?, a2: userdata
    if a1 == nil then
        return true
    end
    local v1 = (a1.RightVector - a2.RightVector).Magnitude + (a1.UpVector - a2.UpVector).Magnitude + (a1.LookVector - a2.LookVector).Magnitude
    local v2 = true
    if not (v1 > 0.001) then
        v2 = 0.001 < (a1.Position - a2.Position).Magnitude
    end
    return v2
end

local function visibleParts(a1) -- Line: 216 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j.Transparency < 1 then
            table.insert(v1, j)
        end
    end
    return v1
end

local function resolveSeat(a1, a2, a3) -- Line: 233
    -- upvalues: Workspace (val), visibleParts (val), PartBounds (val), MonsterParasite (val)
    local PrimaryPart = a3.PrimaryPart
    if PrimaryPart ~= nil and a1:IsDescendantOf(Workspace) then
        local v1 = visibleParts(a1)
        local v2 = visibleParts(a3)
        if #v1 ~= 0 and #v2 ~= 0 then
            local identity, v3
            local Rotation = a2.CFrame.Rotation
            local v4, v5 = PartBounds(v1, Rotation)
            if v5.Magnitude < 0.001 then
                return nil
            end
            local v6, v7 = PartBounds(v2, PrimaryPart.CFrame.Rotation)
            v2 = PrimaryPart.CFrame:PointToObjectSpace(v6.Position)
            local UpVector = Rotation.UpVector
            local RightVector = Rotation.RightVector
            local LookVector = Rotation.LookVector
            local u43 = RaycastParams.new()
            u43.FilterType = Enum.RaycastFilterType.Include
            u43.FilterDescendantsInstances = v1
            u43.RespectCanCollide = false
            local Magnitude = v5.Magnitude
            local ParasiteCrownOffset = MonsterParasite.ParasiteCrownOffset
            local u61 = v4.Position + RightVector * (ParasiteCrownOffset.X * v5.X) + LookVector * (ParasiteCrownOffset.Y * v5.Z) + UpVector * Magnitude
            local u63 = UpVector * -Magnitude

            local function probe(a1) -- Line: 283
                -- upvalues: Workspace (upval), u61 (val), u63 (val), u43 (val)
                return Workspace:Raycast(u61 + a1, u63, u43)
            end

            v4 = Workspace:Raycast(u61 + Vector3.new(0, 0, 0), u63, u43)
            if v4 == nil then
                return nil
            end
            v1 = (u61 - v4.Position):Dot(UpVector)
            v4 = math.min(v7.X, v7.Z) * 0.4
            for i, j in {
                RightVector * v4,
                RightVector * -v4,
                LookVector * v4,
                LookVector * -v4,
            } do
                v3 = Workspace:Raycast(u61 + j, u63, u43)
                if v3 then
                    v1 = math.min(v1, ((u61 + j - v3.Position):Dot(UpVector)))
                end
            end
            local fromMatrix = CFrame.fromMatrix
            local v8 = UpVector:Cross(-LookVector)
            v5 = fromMatrix(Vector3.new(0, 0, 0), v8, UpVector, -LookVector)
            local PrimaryPart_2 = a3.PrimaryPart
            local v9 = if not PrimaryPart_2 then nil else PrimaryPart_2:FindFirstChildWhichIsA("Bone")
            local v10 = v5 * (if PrimaryPart_2 == nil then CFrame.identity else if v9 ~= nil then (PrimaryPart_2.CFrame:Inverse()) * v9.TransformedWorldCFrame * v9.CFrame:Inverse() else CFrame.identity).Rotation:Inverse()
            return v10 + (u61 - UpVector * (v1 - v7.Y * 0.04999999999999999) - v10:VectorToWorldSpace(identity * v2))
        end
        return nil
    end
    return nil
end

local function removeIcon(a1) -- Line: 330 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BillboardGui") or j:IsA("Attachment") and j.Name == "MonsterParasiteIconAnchor" then
            j:Destroy()
        end
    end
end

local u52 = setmetatable({}, {__mode = "k"})

local function holdSeat(a1, a2, a3, a4) -- Line: 353
    -- upvalues: u52 (val), RunService (val), resolveSeat (val)
    if a4.PrimaryPart == nil then
        return
    end
    local u8 = (u52[a3] or 0) + 1
    u52[a3] = u8
    local u10 = nil
    local u11 = false
    local u12 = nil
    local u13 = false
    local u16 = os.clock() + 30
    local u17 = nil
    RunService.PostSimulation:Connect(function() -- Line: 373
        -- upvalues: u52 (upval), a3 (val), u8 (val), a2 (val), a4 (val), u17 (ref), u13 (ref), u10 (ref)
        -- upvalues: resolveSeat (upval), a1 (val), u11 (ref), u12 (ref), u16 (val)
        local v1 = u52[a3]
        if v1 == u8 and a3.Parent ~= nil and a2.Parent ~= nil and a4.Parent ~= nil then
            local v2
            if u13 then
                u17:Disconnect()
                return
            end
            local PrimaryPart = a4.PrimaryPart
            local Bone = if not PrimaryPart then nil else PrimaryPart:FindFirstChildWhichIsA("Bone")
            local identity = if PrimaryPart == nil then CFrame.identity else if Bone ~= nil then (PrimaryPart.CFrame:Inverse()) * Bone.TransformedWorldCFrame * Bone.CFrame:Inverse() else CFrame.identity
            local v3 = u10
            if v3 ~= nil then
                local v4 = (v3.RightVector - identity.RightVector).Magnitude + (v3.UpVector - identity.UpVector).Magnitude + (v3.LookVector - identity.LookVector).Magnitude
                v2 = true
                if not (v4 > 0.001) then
                    v2 = 0.001 < (v3.Position - identity.Position).Magnitude
                end
            else
                v2 = true
            end
            if v2 then
                v2 = resolveSeat(a1, a2, a4)
                if v2 then
                    u10 = identity
                    v3 = u11
                    if not v3 then
                        local identity_2 = CFrame.identity
                        if identity_2 ~= nil then
                            local v5 = (identity_2.RightVector - identity.RightVector).Magnitude + (identity_2.UpVector - identity.UpVector).Magnitude + (identity_2.LookVector - identity.LookVector).Magnitude
                            v3 = true
                            if not (v5 > 0.001) then
                                v3 = 0.001 < (identity_2.Position - identity.Position).Magnitude
                            end
                        else
                            v3 = true
                        end
                    end
                    u11 = v3
                    a3.C0 = a2.CFrame:Inverse() * v2
                end
            end
            v1 = os.clock()
            if u12 == nil and u11 then
                u12 = v1 + 0.35
            end
            if (u12 or u16) <= v1 then
                u13 = true
            end
            return
        end
        u17:Disconnect()
    end)
end

local function seatWhenReachable(a1, a2, a3, a4) -- Line: 411
    -- upvalues: resolveSeat (val), holdSeat (val)
    if a3.PrimaryPart == nil then
        return
    end
    local u5 = nil
    a1.AncestryChanged:Connect(function() -- Line: 422
        -- upvalues: a4 (val), a3 (val), a1 (val), u5 (ref), resolveSeat (upval), a2 (val), holdSeat (upval)
        if a4.Parent ~= nil and a3.Parent == a1 then
            local v1 = resolveSeat(a1, a2, a3)
            if v1 == nil then
                return
            end
            u5:Disconnect()
            a4.C0 = a2.CFrame:Inverse() * v1
            holdSeat(a1, a2, a4, a3)
            return
        end
        u5:Disconnect()
    end)
end

local function attachOutline(a1) -- Line: 443 -- upvalues: MonsterParasite (val) -- types: a1: userdata
    if a1:FindFirstChild(MonsterParasite.ParasiteHighlightName) then
        return
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = MonsterParasite.ParasiteHighlightName
    Highlight.Adornee = a1
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = MonsterParasite.ParasiteHighlightColor
    Highlight.FillTransparency = MonsterParasite.ParasiteHighlightFillTransparency
    Highlight.OutlineColor = MonsterParasite.ParasiteHighlightColor
    Highlight.OutlineTransparency = MonsterParasite.ParasiteHighlightTransparency
    Highlight.Parent = a1
end

local function playIdle(a1) -- Line: 459
    -- upvalues: Workspace (val), u30 (ref), MonsterParasite (val)
    local function tryPlay() -- Line: 460 -- upvalues: a1 (val), Workspace (upval), u30 (upval), MonsterParasite (upval)
        if a1.Parent ~= nil and a1:IsDescendantOf(Workspace) then
            local Animator = a1:FindFirstChildWhichIsA("Animator", true)
            if Animator ~= nil and Animator:IsA("Animator") then
                local Animation
                local v1 = u30
                if v1 == nil then
                    v1 = Instance.new("Animation")
                    v1.Name = "ParasiteIdle"
                    v1.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                    u30 = v1
                end
                local AnimationId = v1.AnimationId
                for i, j in Animator:GetPlayingAnimationTracks() do
                    Animation = j.Animation
                    if Animation and Animation.AnimationId == AnimationId then
                        return true
                    end
                end
                local success, err = pcall(function() -- Line: 481 -- upvalues: Animator (val), u30 (upval), MonsterParasite (upval)
                    local v1 = u30
                    if v1 == nil then
                        v1 = Instance.new("Animation")
                        v1.Name = "ParasiteIdle"
                        v1.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                        u30 = v1
                    end
                    return Animator:LoadAnimation(v1)
                end)
                if not success then
                    warn((("[MonsterParasite] Failed to load parasite idle: %*"):format(err)))
                    return true
                end
                err.Looped = true
                err.Priority = Enum.AnimationPriority.Idle
                err:Play()
                return true
            end
            warn((("[MonsterParasite] Missing Animator in %*"):format((a1:GetFullName()))))
            return true
        end
        return false
    end

    if tryPlay() then
        return
    end
    local u4 = nil
    a1.AncestryChanged:Connect(function() -- Line: 501 -- upvalues: tryPlay (val), u4 (ref)
        if tryPlay() then
            u4:Disconnect()
        end
    end)
end

local function decorate(a1) -- Line: 508
    -- upvalues: MonsterParasite (val), attachOutline (val), removeIcon (val), playIdle (val), resolveTemplate (val)
    -- upvalues: configureParts (val), resolveSeat (val), weldToEgg (val), holdSeat (val)
    local v1 = a1:FindFirstChild(MonsterParasite.ParasiteVisualName)
    if v1 and v1:IsA("Model") then
        attachOutline(v1)
        removeIcon(v1)
        playIdle(v1)
        return v1
    end
    v1 = resolveTemplate()
    local PrimaryPart = a1.PrimaryPart
    if v1 ~= nil and PrimaryPart ~= nil then
        local u25 = v1:Clone()
        u25.Name = MonsterParasite.ParasiteVisualName
        local InitialPoses = u25:FindFirstChild("InitialPoses")
        if InitialPoses then
            InitialPoses:Destroy()
        end
        local AnimSaves = u25:FindFirstChild("AnimSaves")
        if AnimSaves then
            AnimSaves:Destroy()
        end
        u25:ScaleTo((v1:GetScale()) * a1:GetScale() * MonsterParasite.ParasiteScaleMultiplier)
        configureParts(u25, true)
        local ParasiteCrownOffset = MonsterParasite.ParasiteCrownOffset
        local Size = PrimaryPart.Size
        u25:PivotTo(PrimaryPart.CFrame * (CFrame.new(ParasiteCrownOffset.X * Size.X, Size.Y * 0.5, ParasiteCrownOffset.Y * Size.Z)))
        local PrimaryPart_2 = u25.PrimaryPart
        assert(PrimaryPart_2 ~= nil, "Parasite template requires a PrimaryPart")
        v1 = resolveSeat(a1, PrimaryPart, u25)
        if v1 then
            u25:PivotTo(v1 * ((PrimaryPart_2.CFrame:Inverse()) * (u25:GetPivot())))
        end
        u25.Parent = a1
        local u121 = weldToEgg(PrimaryPart, PrimaryPart_2)
        holdSeat(a1, PrimaryPart, u121, u25)
        if v1 == nil and u25.PrimaryPart ~= nil then
            local u130 = nil
            a1.AncestryChanged:Connect(function() -- Line: 422
                -- upvalues: u121 (val), u25 (val), a1 (val), u130 (ref), resolveSeat (upval), PrimaryPart (val)
                -- upvalues: holdSeat (upval)
                if u121.Parent ~= nil and u25.Parent == a1 then
                    local v1 = resolveSeat(a1, PrimaryPart, u25)
                    if v1 == nil then
                        return
                    end
                    u130:Disconnect()
                    u121.C0 = PrimaryPart.CFrame:Inverse() * v1
                    holdSeat(a1, PrimaryPart, u121, u25)
                    return
                end
                u130:Disconnect()
            end)
        end
        configureParts(u25, false)
        attachOutline(u25)
        playIdle(u25)
        return u25
    end
    return nil
end

local function applyDecoration(a1) -- Line: 563
    -- upvalues: u34 (val), MonsterParasiteWindow (val), u29 (val), decorate (val)
    if u34[a1] == true and MonsterParasiteWindow.IsActive() then
        return (decorate(a1))
    end
    u29.Clear(a1)
    return nil
end

function u29.PoseDrift(a1) -- Line: 579 -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    local Bone = if not PrimaryPart then nil else PrimaryPart:FindFirstChildWhichIsA("Bone")
    if PrimaryPart ~= nil and Bone ~= nil then
        return Bone.TransformedWorldCFrame.Position - (PrimaryPart.CFrame * Bone.CFrame).Position
    end
    return (Vector3.new(0, 0, 0))
end

function u29.Clear(a1) -- Line: 583 -- upvalues: MonsterParasite (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
    if v1 then
        v1:Destroy()
    end
    for i, j in a1:GetDescendants() do
        if not j:IsA("BillboardGui") then
            if j:IsA("Highlight") and j.Name == MonsterParasite.ParasiteHighlightName then
                j:Destroy()
            end
        elseif j.Name == MonsterParasite.ParasiteBillboardName
            or j:IsA("Highlight") and j.Name == MonsterParasite.ParasiteHighlightName then
            j:Destroy()
        end
    end
end

function u29.PrepareYankClone(a1) -- Line: 604
    -- upvalues: stripExternalJointsAndBillboards (val), configureParts (val), Workspace (val), playIdle (val)
    if a1.PrimaryPart == nil then
        return nil
    end
    local Pivot = a1:GetPivot()
    local v1 = a1:Clone()
    local InitialPoses = v1:FindFirstChild("InitialPoses")
    if InitialPoses then
        InitialPoses:Destroy()
    end
    local AnimSaves = v1:FindFirstChild("AnimSaves")
    if AnimSaves then
        AnimSaves:Destroy()
    end
    stripExternalJointsAndBillboards(v1)
    configureParts(v1, true)
    v1.Parent = Workspace
    v1:PivotTo(Pivot)
    playIdle(v1)
    a1:Destroy()
    return v1
end

function u29.Attach(a1, a2) -- Line: 621
    -- upvalues: u34 (val), MonsterParasiteWindow (val), u29 (val), decorate (val)
    u34[a1] = if a2 ~= true then nil else true
    if u34[a1] == true and MonsterParasiteWindow.IsActive() then
        return (decorate(a1))
    end
    u29.Clear(a1)
    return nil
end

MonsterParasiteWindow.Changed:Connect(function() -- Line: 630 -- upvalues: u34 (val), MonsterParasiteWindow (val), u29 (val), decorate (val)
    local v1 = nil
    local v2 = nil
    for i in u34, v1, v2 do
        if i.Parent ~= nil then
            if u34[i] ~= true then
                u29.Clear(i)
            elseif MonsterParasiteWindow.IsActive() then
                decorate(i)
            else
                u29.Clear(i)
            end
        end
    end
end)
return (table.freeze(u29))