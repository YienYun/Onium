-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Mushrooms
-- Decompile time: 22.34 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local BanjoCricketFlags = require(ReplicatedStorage.Shared.Flags.BanjoCricketFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u48 = Color3.fromRGB(255, 255, 255)
local u53 = Color3.fromRGB(12, 10, 24)
local u58 = Color3.fromRGB(55, 55, 65)
local LocalPlayer = Players.LocalPlayer
local u60 = {}
local u61 = {}
local u62 = {}
local u63 = false
local u64 = 0
local u65 = false
local u66 = nil
local u67 = nil
local u68 = Vector3.new(0, 0, 0)
local u70 = OverlapParams.new()
u70.FilterType = Enum.RaycastFilterType.Include
local u72 = {}
u72.Bounce = {
    Seconds = 0.55,
    Sample = function(a1) -- Line: 97 -- types: a1: number
        return (math.sin(a1 * 3.141592653589793 * 3)) * (1 - a1) * 0.2, 0, 0, 0
    end,
}
u72.Hop = {
    Seconds = 0.45,
    Sample = function(a1) -- Line: 103 -- types: a1: number
        return (math.sin(a1 * 3.141592653589793 * 2)) * (1 - a1) * 0.08, math.sin(a1 * 3.141592653589793) * 0.9, 0, 0
    end,
}
u72.Squish = {
    Seconds = 0.3,
    Sample = function(a1) -- Line: 110 -- types: a1: number
        return -math.sin(a1 * 3.141592653589793) * 0.1, 0, 0, 0
    end,
}
u72.Breathe = {
    Seconds = 0.7,
    Sample = function(a1) -- Line: 116 -- types: a1: number
        return math.sin(a1 * 3.141592653589793) * 0.06, 0, 0, 0
    end,
}
u72.Droop = {
    Seconds = 0.9,
    Sample = function(a1) -- Line: 122 -- types: a1: number
        return -math.sin(a1 * 3.141592653589793) * 0.14, 0, 0, 0
    end,
}
u72.Shake = {
    Seconds = 0.55,
    Sample = function(a1) -- Line: 128 -- types: a1: number
        local v1 = (1 - a1) ^ 2 * 0.15707963267948966
        return 0, 0, math.sin(a1 * 38) * v1, math.cos(a1 * 31) * v1
    end,
}
local v1 = {}

local function refreshGlow(a1) -- Line: 137 -- upvalues: u48 (val), TweenService (val), u53 (val) -- types: a1: table
    local Glow = a1.Glow
    local v1 = TweenInfo.new(if Glow ~= "Off" then if Glow ~= "Dim" then 0.06 else 0.25 else 0.3, Enum.EasingStyle.Quad)
    local v2 = if Glow ~= "Lit" then if Glow ~= "Soft" then 0 else 1.2 else 4
    local v3 = if Glow ~= "Lit" then if Glow ~= "Soft" then if Glow ~= "Dim" then 1 else 0.35 else 0.75 else 0.35
    local v4 = if Glow ~= "Lit" then if Glow ~= "Soft" then if Glow ~= "Off" then 1 else if not a1.Aimed then 1 else 0.35 else 0.5 else 0
    a1.Highlight.OutlineColor = if Glow ~= "Off" then a1.Color else if not a1.Aimed then a1.Color else u48
    TweenService:Create(a1.Light, v1, {Brightness = v2}):Play()
    local v5 = {FillTransparency = v3, OutlineTransparency = v4}
    if Glow ~= "Off" then
        local Color_2 = if Glow ~= "Dim" then a1.Color else u53
        if not (0.95 <= a1.Highlight.FillTransparency) then
            v5.FillColor = Color_2
        else
            a1.Highlight.FillColor = Color_2
        end
    end
    TweenService:Create(a1.Highlight, v1, v5):Play()
end

local function setGlow(a1, a2, a3) -- Line: 180
    -- upvalues: refreshGlow (val), u63 (ref)
    a1.GlowId = a1.GlowId + 1
    a1.Glow = a2
    refreshGlow(a1)
    if a3 == nil then
        return
    end
    local GlowId = a1.GlowId
    task.delay(a3, function() -- Line: 188 -- upvalues: a1 (val), GlowId (val), u63 (upval), refreshGlow (upval)
        if a1.GlowId == GlowId and not u63 then
            a1.Glow = "Off"
            refreshGlow(a1)
        end
    end)
end

local function move(a1, a2) -- Line: 196 -- upvalues: u61 (val) -- types: a1: table, a2: string
    a1.Motions[a2] = (os.clock())
    u61[a1] = true
end

local function animate() -- Line: 201 -- upvalues: u61 (val), u72 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if next(u61) == nil then
        return
    end
    local v11 = os.clock()
    local v12 = nil
    local v13 = nil
    for i in u61, v12, v13 do
        v7 = 1
        v8 = 0
        v9 = 0
        v10 = 0
        for j, k in i.Motions do
            v1 = u72[j]
            v2 = (v11 - k) / v1.Seconds
            if not (v2 >= 1) then
                v3, v4, v5, v6 = v1.Sample(v2)
                v7 = v7 + v3
                v8 = v8 + v4
                v9 = v9 + v5
                v10 = v10 + v6
            else
                i.Motions[j] = nil
            end
        end
        if next(i.Motions) == nil then
            u61[i] = nil
        end
        if i.Model.Parent ~= nil then
            i.Model:ScaleTo(i.BaseScale * v7)
            i.Model:PivotTo(i.BasePivot * CFrame.new(0, v8, 0) * (CFrame.Angles(v9, 0, v10)))
        end
    end
end

local function beadFolder() -- Line: 234 -- upvalues: u66 (ref), Workspace (val)
    local v1 = u66
    if v1 and v1.Parent then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "BanjoCricketRings"
    Folder.Parent = Workspace
    u66 = Folder
    return Folder
end

local function makeBeads(a1, a2, a3) -- Line: 247
    -- upvalues: BanjoCricketFlags (val), u66 (ref), Workspace (val)
    local v1, v2
    local v3 = BanjoCricketFlags.Stages:Get()
    local v4 = math.max(a1.Size.X, a1.Size.Z) / 2 + 0.7
    local v5 = table.create(v3)
    local v6, v7 = a3, a2
    for i = 1, v3 do
        v2 = (i - 1) / v3 * 3.141592653589793 * 2
        v1 = v6:Add((Instance.new("Part")))
        v1.Name = "Bead"
        v1.Shape = Enum.PartType.Ball
        v1.Size = Vector3.new(0.550000011920929, 0.550000011920929, 0.550000011920929)
        v1.Anchored = true
        v1.CanCollide = false
        v1.CanQuery = false
        v1.CanTouch = false
        v1.CastShadow = false
        v1.Transparency = 1
        v1.CFrame = v7 * CFrame.new(math.cos(v2) * v4, 0.3, math.sin(v2) * v4)
        v2 = u66
        if not v2 or not v2.Parent then
            v2 = Instance.new("Folder")
            v2.Name = "BanjoCricketRings"
            v2.Parent = Workspace
            u66 = v2
        end
        v1.Parent = v2
        table.insert(v5, v1)
    end
    return v5
end

local function paintBeads(a1, a2) -- Line: 271
    -- upvalues: u64 (ref), u65 (ref), u58 (val), TweenService (val)
    local Color, Neon, v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    for i, j in a1.Beads, v5, v6 do
        v3 = i <= u64
        j.Transparency = if u65 then if not v3 then 0.55 else 0 else 1
        Color = if not v3 then u58 else v7.Color
        j.Color = Color
        Neon = if not v3 then Enum.Material.SmoothPlastic else Enum.Material.Neon
        j.Material = Neon
        if i == v8 and u65 then
            j.Size = Vector3.new(1.100000023841858, 1.100000023841858, 1.100000023841858)
            v4 = TweenService
            v1 = TweenInfo.new(0.35, Enum.EasingStyle.Back)
            v2 = {Size = Vector3.new(0.550000011920929, 0.550000011920929, 0.550000011920929)}
            v4:Create(j, v1, v2):Play()
        end
    end
end

local function isNear(a1, a2) -- Line: 288 -- upvalues: u70 (val), Workspace (val) -- types: a1: table, a2: userdata
    u70.FilterDescendantsInstances = {a2}
    local BoundingBox, BoundingBox_2 = a1.Model:GetBoundingBox()
    return #Workspace:GetPartBoundsInBox(BoundingBox, BoundingBox_2 + Vector3.new(2, 2, 2), u70) > 0
end

local function trackPlayer() -- Line: 298
    -- upvalues: LocalPlayer (val), u68 (ref), u60 (val), u70 (val), Workspace (val)
    local BoundingBox, BoundingBox_2, v1
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    u68 = if not HumanoidRootPart then Vector3.new(0, 0, 0) else if not HumanoidRootPart:IsA("BasePart") then Vector3.new(0, 0, 0) else HumanoidRootPart.AssemblyLinearVelocity
    local v2 = nil
    local v3 = nil
    for i, j in u60, v2, v3 do
        if j.Pressed then
            v1 = false
            if Character ~= nil then
                u70.FilterDescendantsInstances = {Character}
                BoundingBox, BoundingBox_2 = j.Model:GetBoundingBox()
                v1 = #Workspace:GetPartBoundsInBox(BoundingBox, BoundingBox_2 + Vector3.new(2, 2, 2), u70) > 0
            end
            j.Pressed = v1
        end
    end
end

local function approachSpeed(a1, a2) -- Line: 311 -- upvalues: u68 (ref) -- types: a1: table, a2: userdata
    local HumanoidRootPart = a2:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local v1 = (a1.Anchor.Position - HumanoidRootPart.Position) * Vector3.new(1, 0, 1)
        return (math.max(if not (0.001 < v1.Magnitude) then 0 else u68:Dot(v1.Unit), -u68.Y))
    end
    return 0
end

local function watchBumps(a1) -- Line: 321
    -- upvalues: LocalPlayer (val), approachSpeed (val), u67 (ref)
    for i, j in a1.Model:GetDescendants() do
        if j:IsA("BasePart") then
            a1.Trove:Connect(j.Touched, function(a1_2) -- Line: 326
                -- upvalues: LocalPlayer (upval), a1 (val), approachSpeed (upval), u67 (upval)
                local Character = LocalPlayer.Character
                local v1 = os.clock()
                if Character ~= nil
                    and not a1.Pressed
                    and a1_2:IsDescendantOf(Character)
                    and a1_2:FindFirstAncestorOfClass("Tool") == nil
                    and next(a1.Motions) == nil
                    and not (v1 - a1.BumpedAt < 0.6)
                    and not ((approachSpeed(a1, Character)) < 3) then
                    a1.BumpedAt = v1
                    a1.Pressed = true
                    v1 = u67
                    if v1 then
                        v1(a1.Index)
                    end
                    return
                end
            end)
        end
    end
end

local function anchorOf(a1) -- Line: 353 -- types: a1: userdata
    local Hitbox = a1:FindFirstChild("Hitbox")
    if Hitbox and Hitbox:IsA("BasePart") then
        return Hitbox
    end
    return a1.PrimaryPart
end

local function bind(a1) -- Line: 361
    -- upvalues: u60 (val), Workspace (val), BanjoCricket (val), Trove (val), makeBeads (val), paintBeads (val)
    -- upvalues: watchBumps (val), u62 (val)
    if not u60[a1] and a1:IsA("Model") then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) then
            local Attribute = a1:GetAttribute(BanjoCricket.Attributes.MushroomIndex)
            local Hitbox = a1:FindFirstChild("Hitbox")
            local PrimaryPart = if not Hitbox then a1.PrimaryPart else if not Hitbox:IsA("BasePart") then a1.PrimaryPart else Hitbox
            if PrimaryPart ~= nil and typeof(Attribute) == "number" then
                v1 = BanjoCricket.Mushrooms[Attribute]
                if v1 == nil then
                    return
                end
                local v2 = Trove.new()
                local v3 = v2:Add((Instance.new("PointLight")))
                v3.Brightness = 0
                v3.Range = 16
                v3.Color = v1.Color
                v3.Shadows = false
                v3.Parent = PrimaryPart
                local v4 = v2:Add((Instance.new("Highlight")))
                v4.Adornee = a1
                v4.DepthMode = Enum.HighlightDepthMode.Occluded
                v4.FillColor = v1.Color
                v4.OutlineColor = v1.Color
                v4.FillTransparency = 1
                v4.OutlineTransparency = 1
                v4.Parent = a1
                local Pivot = a1:GetPivot()
                local v5 = {
                    Glow = "Off",
                    GlowId = 0,
                    Aimed = false,
                    BumpedAt = 0,
                    Pressed = false,
                    Model = a1,
                    Anchor = PrimaryPart,
                    Index = Attribute,
                    Color = v1.Color,
                    Light = v3,
                    Highlight = v4,
                    Beads = makeBeads(PrimaryPart, Pivot, v2),
                    BasePivot = Pivot,
                    BaseScale = a1:GetScale(),
                    Motions = {},
                    Trove = v2,
                }
                paintBeads(v5)
                watchBumps(v5)
                u60[a1] = v5
                table.insert(u62, {Index = Attribute, Anchor = PrimaryPart})
                return
            end
            return
        end
    end
end

local function unbind(a1) -- Line: 418 -- upvalues: u60 (val), u61 (val), u62 (val) -- types: a1: userdata
    local v1 = u60[a1]
    if v1 == nil then
        return
    end
    u60[a1] = nil
    u61[v1] = nil
    for i, j in u62 do
        if j.Anchor == v1.Anchor then
            table.remove(u62, i)
            break
        end
    end
    v1.Trove:Destroy()
end

local function each(a1, a2) -- Line: 434 -- upvalues: u60 (val) -- types: a1: number, a2: function
    for i, j in u60 do
        if j.Index == a1 then
            a2(j)
        end
    end
end

function v1.Start(a1) -- Line: 442
    -- upvalues: u67 (ref), BanjoCricket (val), CollectionService (val), bind (val), unbind (val), RunService (val)
    -- upvalues: animate (val), trackPlayer (val)
    u67 = a1
    local Mushroom = BanjoCricket.Tags.Mushroom
    ;(CollectionService:GetInstanceAddedSignal(Mushroom)):Connect(bind)
    ;(CollectionService:GetInstanceRemovedSignal(Mushroom)):Connect(unbind)
    for i, j in CollectionService:GetTagged(Mushroom) do
        bind(j)
    end
    RunService.PreRender:Connect(animate)
    RunService.PreSimulation:Connect(trackPlayer)
end

function v1.Anchor(a1) -- Line: 454 -- upvalues: u62 (val) -- types: a1: number
    for i, j in u62 do
        if j.Index == a1 then
            return j.Anchor
        end
    end
    return nil
end

function v1.Targets() -- Line: 463 -- upvalues: u62 (val)
    return u62
end

function v1.DistanceFrom(a1) -- Line: 467 -- upvalues: u62 (val) -- types: a1: vector
    local v1 = (1 / 0)
    for i, j in u62 do
        v1 = math.min(v1, (j.Anchor.Position - a1).Magnitude)
    end
    return v1
end

function v1.RandomIndex(a1) -- Line: 476 -- upvalues: u62 (val) -- types: a1: userdata
    if #u62 == 0 then
        return nil
    end
    return u62[a1:NextInteger(1, #u62)].Index
end

function v1.Flash(a1, a2) -- Line: 483
    -- upvalues: refreshGlow (val), u63 (ref), u60 (val)
    local function v1(a1) -- Line: 484 -- upvalues: a2 (val), refreshGlow (upval), u63 (upval)
        local v1 = a2
        a1.GlowId = a1.GlowId + 1
        a1.Glow = "Lit"
        refreshGlow(a1)
        if v1 == nil then
            return
        end
        local GlowId = a1.GlowId
        task.delay(v1, function() -- Line: 188 -- upvalues: a1 (val), GlowId (val), u63 (upval), refreshGlow (upval)
            if a1.GlowId == GlowId and not u63 then
                a1.Glow = "Off"
                refreshGlow(a1)
            end
        end)
    end

    for i, j in u60 do
        if j.Index == a1 then
            j.GlowId = j.GlowId + 1
            j.Glow = "Lit"
            refreshGlow(j)
            if a2 ~= nil then
                local GlowId = j.GlowId
                task.delay(a2, function() -- Line: 188 -- upvalues: j (val), GlowId (val), u63 (upval), refreshGlow (upval)
                    if j.GlowId == GlowId and not u63 then
                        j.Glow = "Off"
                        refreshGlow(j)
                    end
                end)
            end
        end
    end
end

function v1.Move(a1, a2) -- Line: 489 -- upvalues: u61 (val), u60 (val) -- types: a1: number, a2: string
    local function v1(a1) -- Line: 490 -- upvalues: a2 (val), u61 (upval)
        a1.Motions[a2] = (os.clock())
        u61[a1] = true
    end

    for i, j in u60 do
        if j.Index == a1 then
            j.Motions[a2] = (os.clock())
            u61[j] = true
        end
    end
end

function v1.MoveAll(a1) -- Line: 495 -- upvalues: u60 (val), u61 (val) -- types: a1: string
    for i, j in u60 do
        j.Motions[a1] = (os.clock())
        u61[j] = true
    end
end

function v1.Squish(a1) -- Line: 502 -- upvalues: Workspace (val), u61 (val), u60 (val) -- types: a1: number
    local CurrentCamera = Workspace.CurrentCamera

    local function v1(a1) -- Line: 504 -- upvalues: CurrentCamera (val), u61 (upval)
        if CurrentCamera == nil or (CurrentCamera.CFrame.Position - a1.Anchor.Position).Magnitude <= 150 then
            a1.Motions.Squish = os.clock()
            u61[a1] = true
        end
    end

    local v2 = nil
    local v3 = nil
    for i, j in u60, v2, v3 do
        if j.Index == a1 then
            if CurrentCamera == nil or (CurrentCamera.CFrame.Position - j.Anchor.Position).Magnitude <= 150 then
                j.Motions.Squish = os.clock()
                u61[j] = true
            end
        end
    end
end

function v1.Pulse() -- Line: 515 -- upvalues: u60 (val), refreshGlow (val), u63 (ref), u61 (val)
    for i, j in u60 do
        j.GlowId = j.GlowId + 1
        j.Glow = "Soft"
        refreshGlow(j)
        local GlowId = j.GlowId
        task.delay(0.45, function() -- Line: 188 -- upvalues: j (val), GlowId (val), u63 (upval), refreshGlow (upval)
            if j.GlowId == GlowId and not u63 then
                j.Glow = "Off"
                refreshGlow(j)
            end
        end)
        j.Motions.Breathe = os.clock()
        u61[j] = true
    end
end

function v1.Dim() -- Line: 522 -- upvalues: u63 (ref), u60 (val), refreshGlow (val)
    u63 = false
    for i, j in u60 do
        j.GlowId = j.GlowId + 1
        j.Glow = "Dim"
        refreshGlow(j)
    end
end

function v1.Darken() -- Line: 529 -- upvalues: u63 (ref), u60 (val), refreshGlow (val)
    u63 = false
    for i, j in u60 do
        j.GlowId = j.GlowId + 1
        j.Glow = "Off"
        refreshGlow(j)
    end
end

function v1.SetAllLit(a1) -- Line: 537
    -- upvalues: u63 (ref), u60 (val), refreshGlow (val), u61 (val)
    u63 = a1
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for i, j in u60, v1, v2 do
        j.GlowId = j.GlowId + 1
        j.Glow = if not v3 then "Off" else "Lit"
        refreshGlow(j)
        if v3 then
            j.Motions.Bounce = os.clock()
            u61[j] = true
        end
    end
end

function v1.ShowAim(a1) -- Line: 547 -- upvalues: u60 (val), refreshGlow (val) -- types: a1: number?
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in u60, v2, v3 do
        v1 = j.Index == a1
        if j.Aimed ~= v1 then
            j.Aimed = v1
            refreshGlow(j)
        end
    end
end

function v1.SetProgress(a1, a2) -- Line: 557
    -- upvalues: u64 (ref), u65 (ref), u60 (val), paintBeads (val)
    local v1 = if not (u64 < a1) then nil else a1
    u64 = a1
    u65 = a2
    for i, j in u60 do
        paintBeads(j, v1)
    end
end

return (table.freeze(v1))