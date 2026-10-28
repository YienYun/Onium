-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Rigs
-- Decompile time: 39.74 ms

local findAnimation
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Kit = require(script.Parent.Kit)
local ModelAttributes = PumpkinBossState.ModelAttributes
local Attributes = PumpkinBossState.Attributes
local CannonAttributes = PumpkinBossState.CannonAttributes
local TrapAttributes = PumpkinBossState.TrapAttributes
local Phases = PumpkinBossState.Phases
local u40 = {Brute = true, King = true}
local u45 = Color3.fromRGB(255, 230, 80)
local u50 = Color3.fromRGB(255, 40, 40)
local u55 = Color3.fromRGB(255, 235, 90)
local Clips = PumpkinBossState.Clips
local Anims = PumpkinBossState.Anims
local u58 = {SwipeLeft = "Swipe", SwipeRight = "Swipe"}
local u59 = false
local u60 = {}
local u61 = {}

local function vineTemplate(a1) -- Line: 79
    -- upvalues: u60 (val), u61 (val), ReplicatedStorage (val)
    local v1 = u60[a1]
    if v1 == nil and not u61[a1] then
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
        v1 = HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
        local v2 = v1 and v1:FindFirstChild(a1)
        if v2 ~= nil and v2:IsA("Model") then
            local BoundingBox_2
            v1 = v2:Clone()
            for i, j in v1:GetDescendants() do
                if j:IsA("BasePart") then
                    j.Anchored = true
                    j.CanCollide = false
                    j.CanQuery = false
                    j.CanTouch = false
                end
            end
            _, BoundingBox_2 = v1:GetBoundingBox()
            if 0.001 < BoundingBox_2.Y then
                v1:ScaleTo(v1:GetScale() * 6.6 / BoundingBox_2.Y)
            end
            local BoundingBox_3, BoundingBox_4 = v1:GetBoundingBox()
            local v3 = {
                Model = v1,
                Offset = (CFrame.new(BoundingBox_3.Position - (Vector3.new(0, BoundingBox_4.Y / 2, 0)))):ToObjectSpace((v1:GetPivot())),
            }
            u60[a1] = v3
            return v3
        end
        u61[a1] = true
        return nil
    end
    return v1
end

local function vineShield(a1) -- Line: 116 -- upvalues: ReplicatedStorage (val) -- types: a1: number
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local HalloweenDimension = Assets and Assets:FindFirstChild("HalloweenDimension")
    local v1 = HalloweenDimension and HalloweenDimension:FindFirstChild("PumpkinBoss")
    local VineShield = v1 and v1:FindFirstChild("VineShield")
    if VineShield ~= nil and VineShield:IsA("Model") then
        local BoundingBox_2
        v1 = VineShield:Clone()
        for i, j in v1:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
                j.CastShadow = false
            end
        end
        _, BoundingBox_2 = v1:GetBoundingBox()
        local v2 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
        if v2 > 0.001 then
            v1:ScaleTo((v1:GetScale()) * a1 / v2)
        end
        return v1, (v1:GetBoundingBox()):ToObjectSpace((v1:GetPivot()))
    end
    return nil, CFrame.identity
end

local function now() -- Line: 144 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function setFade(a1, a2, a3) -- Line: 148 -- types: a1: userdata, a2: number, a3: boolean?
    local v1, v2 = a3, a2
    for i, j in a1:GetDescendants() do
        if not j:IsA("BasePart") then
            if j:IsA("Decal") then
                j.LocalTransparencyModifier = v2
            end
        elseif not v1 or j:GetAttribute("Head") ~= true then
            j.LocalTransparencyModifier = v2
        end
    end
end

local function findAnimator(a1) -- Line: 161 -- types: a1: userdata
    local Animator = a1:FindFirstChildWhichIsA("Animator", true)
    if Animator then
        return Animator
    end
    local Humanoid = a1:FindFirstChildWhichIsA("Humanoid", true) or a1:FindFirstChildWhichIsA("AnimationController", true)
    if Humanoid == nil then
        return nil
    end
    local Animator_2 = Instance.new("Animator")
    Animator_2.Parent = Humanoid
    return Animator_2
end

function findAnimation(a1, a2) -- Line: 178
    -- upvalues: ReplicatedStorage (val), u58 (val), findAnimation (val)
    local Animations = a1:FindFirstChild("Animations")
    local v1 = Animations and Animations:FindFirstChild(a2)
    if v1 and v1:IsA("Animation") then
        return v1
    end
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v2 = Assets and Assets:FindFirstChild("Animations")
    local PumpkinBoss = v2 and v2:FindFirstChild("PumpkinBoss")
    v2 = PumpkinBoss and PumpkinBoss:FindFirstChild(a1.Name)
    local v3 = v2 and v2:FindFirstChild(a2) or PumpkinBoss and PumpkinBoss:FindFirstChild(a2)
    if v3 and v3:IsA("Animation") then
        return v3
    end
    v3 = u58[a2]
    if v3 then
        return (findAnimation(a1, v3))
    end
    return nil
end

local function clipAnimation(a1) -- Line: 199 -- types: a1: number
    local Animation = Instance.new("Animation")
    Animation.AnimationId = "rbxassetid://" .. a1
    return Animation
end

local function holdPoint(a1, a2) -- Line: 205 -- types: a2: number
    if a1.HoldAt then
        return (math.min(a1.HoldAt, a2 - 0.05))
    end
    if a1.Hold then
        return (math.max(a2 - 0.05, 0))
    end
    return nil
end

local function preloadClips() -- Line: 214 -- upvalues: u59 (ref), Clips (val), ContentProvider (val)
    local Id, v1
    if u59 then
        return
    end
    u59 = true
    local u40 = {}
    local v2 = nil
    local v3 = nil
    for i, j in Clips, v2, v3 do
        for k, n in j do
            Id = n.Id
            v1 = Instance.new("Animation")
            v1.AnimationId = "rbxassetid://" .. Id
            table.insert(u40, v1)
        end
    end
    pcall(function() -- Line: 225 -- upvalues: ContentProvider (upval), u40 (val)
        ContentProvider:PreloadAsync(u40)
    end)
    for m, i5 in u40 do
        i5:Destroy()
    end
end

local function billboard(a1, a2, a3, a4, a5) -- Line: 234
    -- upvalues: ReplicatedStorage (val), Kit (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v1 = Assets and Assets:FindFirstChild("HalloweenDimension")
    v1 = v1 and v1:FindFirstChild("MonsterBillboard")
    local v2 = if not v1 then nil else if not v1:IsA("BillboardGui") then nil else v1:Clone()
    v1 = v2 and v2:FindFirstChild("Health")
    local Fill = v1 and v1:FindFirstChild("Fill")
    local TextLabel = v1 and v1:FindFirstChild("TextLabel")
    if v2 and Fill and Fill:IsA("GuiObject") and TextLabel and TextLabel:IsA("TextLabel") then
        v1 = v2:FindFirstChild("Title")
        if v1 and v1:IsA("TextLabel") then
            v1.Text = a3
        end
        v2.Name = "PumpkinHealth"
        v2.Adornee = a2
        v2.StudsOffsetWorldSpace = Vector3.new(0, a2.Size.Y / 2 + a5 + v2.Size.Y.Scale / 2, 0)
        v2.Parent = Kit.Debris()
        a1:Add(v2)
        local u128 = Fill
        local u130 = TextLabel
        return v2, function(a1, a2) -- Line: 268 -- upvalues: u130 (val), u128 (val) -- types: a1: number, a2: number
            local v1 = math.clamp(a1 / a2, 0, 1)
            u130.Text = string.format("%d / %d HP", math.max(0, (math.ceil(a1))), a2)
            u128.Size = UDim2.fromScale(v1, 1)
            u128.Visible = v1 > 0
        end
    end
    if v2 then
        v2:Destroy()
    end
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "PumpkinHealth"
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.fromOffset(90, 12)
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, a2.Size.Y / 2 + a5, 0)
    BillboardGui.MaxDistance = 160
    BillboardGui.Adornee = a2
    local v3 = Instance.new("Frame")
    v3.Size = UDim2.fromScale(1, 1)
    v3.BackgroundColor3 = Color3.fromRGB(20, 10, 0)
    v3.BorderSizePixel = 0
    v3.Parent = BillboardGui
    local u176 = Instance.new("Frame")
    u176.Name = "Fill"
    u176.Size = UDim2.fromScale(1, 1)
    u176.BackgroundColor3 = a4
    u176.BorderSizePixel = 0
    u176.Parent = v3
    BillboardGui.Parent = Kit.Debris()
    a1:Add(BillboardGui)
    return BillboardGui, function(a1, a2) -- Line: 303 -- upvalues: u176 (val) -- types: a1: number, a2: number
        u176.Size = UDim2.fromScale(math.clamp(a1 / a2, 0, 1), 1)
    end
end

local function trackHealth(a1, a2, a3, a4, a5, a6, a7) -- Line: 308
    -- upvalues: billboard (val)
    local u13, u14 = billboard(a1, a7 or a2, a3, a4, a5)

    local function refresh() -- Line: 318 -- upvalues: a2 (val), u13 (val), a6 (val), u14 (val)
        local Attribute = a2:GetAttribute("Health")
        local Attribute_2 = a2:GetAttribute("MaxHealth")
        if typeof(Attribute) == "number" and typeof(Attribute_2) == "number" and not (Attribute_2 <= 0) then
            local v1 = true
            if a6 ~= nil then
                v1 = a6()
            end
            u13.Enabled = v1
            u14(Attribute, Attribute_2)
            return
        end
        u13.Enabled = false
    end

    a1:Connect(a2:GetAttributeChangedSignal("Health"), refresh)
    a1:Connect(a2:GetAttributeChangedSignal("MaxHealth"), refresh)
    refresh()
end

local function trappedRoot(a1) -- Line: 335 -- upvalues: TrapAttributes (val), Players (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(TrapAttributes.TrapUserId)
    local PlayerByUserId = if typeof(Attribute) ~= "number" then nil else Players:GetPlayerByUserId(Attribute)
    local Character = PlayerByUserId and PlayerByUserId.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local u74 = {}
u74.__index = u74

function u74.new(a1, a2) -- Line: 346
    -- upvalues: u74 (val), u40 (val), PumpkinBossState (val), preloadClips (val), RunService (val)
    local v1 = {
        HitFlash = 0,
        ShieldFlash = 0,
        Bump = 0,
        BumpStrength = 1,
        BumpDirection = Vector3.new(1, 0, 0),
        Trove = a1,
        Arena = a2,
        ShieldOffset = CFrame.identity,
        CannonFlashes = {},
        Bound = setmetatable({}, {__mode = "k"}),
    }
    local u11 = setmetatable(v1, u74)

    local function onChild(a1) -- Line: 366
        -- upvalues: u40 (upval), u11 (val), PumpkinBossState (upval)
        if u40[a1.Name] and a1:IsA("Model") then
            u11:BindBoss(a1)
            return
        end
        if a1.Name == PumpkinBossState.VineFolder then
            u11:WatchFolder(a1, function(a1, a2) -- Line: 370 -- upvalues: u11 (upval) -- types: a1: userdata
                u11:BindVine(a1, a2)
            end)
            return
        end
        if a1.Name == PumpkinBossState.CannonFolder then
            u11:WatchFolder(a1, function(a1, a2) -- Line: 374 -- upvalues: u11 (upval) -- types: a1: userdata
                u11:BindCannon(a1, a2)
            end)
            return
        end
        if a1.Name == PumpkinBossState.MinionFolder then
            u11:WatchFolder(a1, function(a1, a2) -- Line: 378 -- upvalues: u11 (upval) -- types: a1: userdata
                u11:BindMinion(a1, a2)
            end)
        end
    end

    task.spawn(preloadClips)
    a1:Connect(a2.ChildAdded, onChild)
    for i, j in a2:GetChildren() do
        task.spawn(onChild, j)
    end
    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 390 -- upvalues: u11 (val) -- types: a1: number
        u11:Step(a1)
    end)
    a1:Add(function() -- Line: 393 -- upvalues: u11 (val)
        if u11.Bubble then
            u11.Bubble:Destroy()
        end
    end)
    return u11
end

function u74:WatchFolder(a2, a3) -- Line: 402 -- types: a2: userdata, a3: function
    local v1
    if self.Bound[a2] then
        return
    end
    self.Bound[a2] = true
    local u7 = {}
    self.Trove:Connect(a2.ChildAdded, function(a1) -- Line: 409 -- upvalues: u7 (val), self (val), a3 (val) -- types: a1: userdata
        if u7[a1] then
            return
        end
        local v1 = self.Trove:Extend()
        u7[a1] = v1
        task.spawn(a3, a1, v1)
    end)
    self.Trove:Connect(a2.ChildRemoved, function(a1) -- Line: 419 -- upvalues: u7 (val) -- types: a1: userdata
        local v1 = u7[a1]
        u7[a1] = nil
        if v1 then
            v1:Destroy()
        end
    end)
    for i, j in a2:GetChildren() do
        if not u7[j] then
            v1 = self.Trove:Extend()
            u7[j] = v1
            task.spawn(a3, j, v1)
        end
    end
end

function u74:BindBoss(a2) -- Line: 431
    -- upvalues: Clips (val), ModelAttributes (val), Workspace (val), findAnimator (val), Anims (val)
    -- upvalues: findAnimation (val), RunService (val), setFade (val), Kit (val), u45 (val), u50 (val), u55 (val)
    if self.Bound[a2] then
        return
    end
    self.Bound[a2] = true
    local u126 = self.Trove:Extend()
    u126:Connect(a2.AncestryChanged, function() -- Line: 438 -- upvalues: a2 (val), u126 (val)
        if a2.Parent == nil then
            u126:Destroy()
        end
    end)
    self.Boss = a2
    local u15 = nil
    local u16 = {}
    local u17 = nil
    local u18 = 0

    local function stopTrack() -- Line: 450 -- upvalues: u15 (ref), u17 (ref)
        if u15 then
            u15:Stop(0.15)
            u15 = nil
        end
        u17 = nil
    end

    local function loadClip(a1, a2, a3) -- Line: 458
        -- upvalues: u16 (val), Clips (upval), u126 (val)
        local v1 = u16[a3]
        if v1 then
            return v1
        end
        v1 = Clips[a2]
        local v2 = v1 and v1[a3]
        if v2 == nil then
            return nil
        end
        local v3 = u126
        local Id = v2.Id
        local v4 = Instance.new("Animation")
        v4.AnimationId = "rbxassetid://" .. Id
        v3 = v3:Add(v4)
        local u23 = v3
        local success, err = pcall(function() -- Line: 469 -- upvalues: a1 (val), u23 (val)
            return a1:LoadAnimation(u23)
        end)
        if success and err ~= nil then
            u16[a3] = err
            return err
        end
        return nil
    end

    local function playClip(a1, a2_2, a3) -- Line: 479
        -- upvalues: loadClip (val), u15 (ref), u17 (ref), Clips (upval), u18 (ref), a2 (val), ModelAttributes (upval)
        -- upvalues: Workspace (upval)
        local v1 = loadClip(a1, a2_2, a3.Clip)
        if v1 == nil then
            return
        end
        if u15 ~= v1 then
            if u15 then
                u15:Stop(0.15)
                u15 = nil
            end
            u17 = nil
        end
        u15 = v1
        u17 = a3
        local v2 = Clips[a2_2][a3.Clip]
        u18 = if not (0 < v1.Length) then v2.Length else v1.Length
        local Attribute = a2:GetAttribute(ModelAttributes.AnimAt)
        local v3 = if typeof(Attribute) ~= "number" then 0 else math.max(Workspace:GetServerTimeNow() - Attribute, 0)
        v2 = a3.Speed or 1
        local v4 = (a3.From or 0) + v3 * v2
        if a3.Loop then
            v4 = v4 % u18
        end
        local v5 = u18
        v4 = math.min(
            v4,
            (if a3.HoldAt then math.min(a3.HoldAt, v5 - 0.05) else if not a3.Hold then nil else math.max(v5 - 0.05, 0)) or u18 - 0.05
        )
        v1.Looped = a3.Loop == true
        if not v1.IsPlaying then
            v1:Play(0.15)
        end
        v1.TimePosition = math.max(v4, 0)
        v1:AdjustSpeed(if not v3 then v2 else if not (v3 <= v4) then v2 else 0)
    end

    local function playAnim() -- Line: 509
        -- upvalues: a2 (val), ModelAttributes (upval), findAnimator (upval), Anims (upval), playClip (val)
        -- upvalues: findAnimation (upval), u15 (ref), u17 (ref), Workspace (upval)
        local Attribute = a2:GetAttribute(ModelAttributes.Anim)
        if typeof(Attribute) ~= "string" then
            return
        end
        local v1 = findAnimator(a2)
        if v1 == nil then
            return
        end
        local Name = a2.Name
        local v2 = Anims[Name]
        local v3 = v2 and v2[Attribute]
        if v3 then
            playClip(v1, Name, v3)
            return
        end
        v3 = findAnimation(a2, Attribute)
        if v3 == nil then
            return
        end
        if u15 then
            u15:Stop(0.15)
            u15 = nil
        end
        u17 = nil
        v2 = v1:LoadAnimation(v3)
        u15 = v2
        v2:Play(0.15)
        local Attribute_2 = a2:GetAttribute(ModelAttributes.AnimAt)
        if typeof(Attribute_2) == "number" and 0 < v2.Length and not v2.Looped then
            local v4 = Workspace:GetServerTimeNow() - Attribute_2
            if v4 > 0.1 and v4 < v2.Length then
                v2.TimePosition = v4
            end
        end
    end

    u126:Connect(a2:GetAttributeChangedSignal(ModelAttributes.Anim), playAnim)
    u126:Connect(a2:GetAttributeChangedSignal(ModelAttributes.AnimAt), playAnim)
    u126:Connect(RunService.PreAnimation, function() -- Line: 545 -- upvalues: u17 (ref), u15 (ref), u18 (ref)
        local v1 = u17
        local v2 = u15
        if v1 ~= nil and v2 ~= nil then
            local v3
            if 0 < v2.Length then
                u18 = v2.Length
            end
            local v4 = u18
            if (if v1.HoldAt then math.min(v1.HoldAt, v4 - 0.05) else if not v1.Hold then nil else math.max(v4 - 0.05, 0)) == nil then
                return
            end
            if not v2.IsPlaying then
                v2:Play(0)
                v2.TimePosition = v3
                v2:AdjustSpeed(0)
                return
            end
            if v2.Speed ~= 0 and v3 <= v2.TimePosition then
                v2.TimePosition = v3
                v2:AdjustSpeed(0)
            end
            return
        end
    end)
    playAnim()

    local function refreshDecay() -- Line: 570
        -- upvalues: a2 (val), ModelAttributes (upval), u126 (val), RunService (upval), setFade (upval)
        local Attribute = a2:GetAttribute(ModelAttributes.Decaying)
        if Attribute ~= nil and Attribute ~= false then
            local u11 = if type(Attribute) ~= "number" then 0.8 else if not (Attribute > 0) then 0.8 else Attribute
            local u14 = os.clock()
            local u15 = nil
            u126:Connect(RunService.RenderStepped, function() -- Line: 580 -- upvalues: u14 (val), u11 (val), setFade (upval), a2 (upval), u15 (ref)
                local v1 = math.clamp((os.clock() - u14) / u11, 0, 1)
                setFade(a2, v1, true)
                if v1 >= 1 then
                    u15:Disconnect()
                end
            end)
            return
        end
    end

    u126:Connect(a2:GetAttributeChangedSignal(ModelAttributes.Decaying), refreshDecay)
    refreshDecay()
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "PumpkinHighlight"
    Highlight.Enabled = false
    Highlight.Adornee = a2
    Highlight.Parent = Kit.Debris()
    u126:Add(Highlight)
    u126:Connect(RunService.RenderStepped, function() -- Line: 599
        -- upvalues: self (val), a2 (val), ModelAttributes (upval), Highlight (val), u45 (upval), u50 (upval)
        local v1
        local HitFlash = if self.Boss ~= a2 then 0 else self.HitFlash
        Highlight.Enabled = a2:GetAttribute(ModelAttributes.Stunned) == true or HitFlash > 0
        if not Highlight.Enabled then
            return
        end
        local v2 = (if not v1 then u50 else u45):Lerp(u50, HitFlash)
        Highlight.FillColor = v2
        Highlight.OutlineColor = v2
        if v1 then
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.FillTransparency = 0.6 + -0.44999999999999996 * HitFlash
            Highlight.OutlineTransparency = 0
            return
        end
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.FillTransparency = 1 - 0.85 * HitFlash
        Highlight.OutlineTransparency = 1 - HitFlash
    end)
    local PrimaryPart = a2.PrimaryPart
    local u111 = {}
    if PrimaryPart then
        for i, j in a2:GetDescendants() do
            if not j:IsA("Motor6D") then
                if j:IsA("Bone") and j.Parent == PrimaryPart then
                    table.insert(u111, j)
                end
            elseif j.Part0 == PrimaryPart or j:IsA("Bone") and j.Parent == PrimaryPart then
                table.insert(u111, j)
            end
        end
    end
    local u119 = {}

    local function restore() -- Line: 633 -- upvalues: u119 (val)
        for i, j in u119 do
            i.Transform = j
        end
        table.clear(u119)
    end

    u126:Connect(RunService.PreAnimation, restore)
    u126:Connect(RunService.PreSimulation, function() -- Line: 640 -- upvalues: self (val), a2 (val), u111 (val), u119 (val)
        local C0, Transform, v1
        if (if self.Boss ~= a2 then nil else self:BumpOffset(a2)) == nil then
            return
        end
        local v2 = nil
        local v3 = nil
        for i, j in u111, v2, v3 do
            if j.Parent ~= nil and not u119[j] then
                C0 = if not j:IsA("Motor6D") then j.CFrame else j.C0
                Transform = j.Transform
                u119[j] = Transform
                j.Transform = C0:Inverse() * v1 * C0 * Transform
            end
        end
    end)
    u126:Add(restore)
    local u147 = {}
    u126:Add(function() -- Line: 658 -- upvalues: u147 (val)
        for i, j in u147 do
            j:Destroy()
        end
        table.clear(u147)
    end)
    u126:Connect(RunService.RenderStepped, function() -- Line: 665 -- upvalues: a2 (val), ModelAttributes (upval), u147 (val), Kit (upval), u55 (upval)
        local Hitbox = a2:FindFirstChild("Hitbox")
        local v1 = a2
        if v1:GetAttribute(ModelAttributes.Stunned) == true and Hitbox ~= nil and Hitbox:IsA("BasePart") then
            local v2, v3, v4
            local Attribute = a2:GetAttribute("BodyHeight")
            local Y = if type(Attribute) ~= "number" then Hitbox.Size.Y else Attribute
            if #u147 == 0 then
                for i = 1, 5 do
                    v1 = Kit.Part({
                        Name = "PumpkinStunStar",
                        Color = u55,
                        Size = Vector3.new(1, 1, 1) * Y * 0.07,
                    })
                    v1.Parent = Kit.Debris()
                    u147[i] = v1
                end
            end
            local v5 = Hitbox.CFrame:PointToWorldSpace((Vector3.new(0, Hitbox.Size.Y / 2, 0)))
            local v6 = os.clock()
            for j, k in u147 do
                v4 = v6 * 3.490658503988659 + j / 5 * 3.141592653589793 * 2
                v2 = math.sin(v6 * 4 + j) * Y * 0.04
                v3 = CFrame.new(v5 + (Vector3.new(math.cos(v4), 0, (math.sin(v4)))) * Y * 0.3 + Vector3.new(0, v2, 0))
                k.CFrame = v3 * CFrame.Angles(v4, v4 * 2, 0.7853981633974483)
            end
            return
        end
        if #u147 > 0 then
            for n, m in u147 do
                m:Destroy()
            end
            table.clear(u147)
        end
    end)
end

function u74:Flash(a2, a3) -- Line: 704 -- upvalues: Workspace (val), Kit (val) -- types: a2: vector?, a3: number?
    local v1 = a3 or 1
    self.BumpStrength = if not (0.5 < self.Bump) then v1 else math.max(self.BumpStrength, v1)
    self.HitFlash = 1
    self.Bump = 1
    local CurrentCamera = Workspace.CurrentCamera
    local v2 = Kit.Flat(a2 or (if not CurrentCamera then Vector3.new(1, 0, 0) else CurrentCamera.CFrame.LookVector))
    self.BumpDirection = if not (0.001 < v2.Magnitude) then Vector3.new(1, 0, 0) else v2.Unit
end

function u74.FlashShield(a1, a2, a3) -- Line: 714 -- types: a2: vector?, a3: number?
    a1.ShieldFlash = 1
    a1:Flash(a2, a3)
end

function u74.FlashCannon(a1, a2) -- Line: 719 -- types: a2: userdata
    if a1.CannonFlashes[a2] ~= nil then
        a1.CannonFlashes[a2] = 1
    end
end

function u74:BumpOffset(a2) -- Line: 725 -- types: a2: userdata
    local Bump = self.Bump
    local PrimaryPart = a2.PrimaryPart
    if not (Bump <= 0) and PrimaryPart ~= nil then
        local Attribute = a2:GetAttribute("BodyHeight")
        local Y = if type(Attribute) ~= "number" then PrimaryPart.Size.Y else Attribute
        local v1 = math.sin((1 - Bump) * 3.141592653589793 * 2.5) * Bump * Bump * self.BumpStrength
        local v2 = PrimaryPart.CFrame:VectorToObjectSpace(self.BumpDirection)
        local v3 = Vector3.new(0, 1, 0):Cross(v2)
        local identity = if not (0.001 < v3.Magnitude) then CFrame.identity else CFrame.fromAxisAngle(v3.Unit, 0.08726646259971647 * v1)
        return CFrame.new(v2 * Y * 0.035 * v1) * identity
    end
    return nil
end

function u74.BindVine(a1, a2, a3) -- Line: 743
    -- upvalues: Kit (val), trappedRoot (val), vineTemplate (val), trackHealth (val)
    local u187
    if not a2:IsA("BasePart") then
        return
    end
    local Attribute = a2:GetAttribute("Style")
    local Green = if Attribute ~= "King" then Color3.fromRGB(150, 40, 20) else Kit.Green
    local Folder = Instance.new("Folder")
    Folder.Name = "PumpkinVineCage"
    Folder.Parent = Kit.Debris()
    a3:Add(Folder)
    local Y = a2.Size.Y
    local u36 = a2.Position.Y - Y / 2
    local u39 = trappedRoot(a2)

    local function base() -- Line: 758 -- upvalues: u39 (val), a2 (val), u36 (val)
        local Position = if not u39 then a2.Position else if not u39.Parent then a2.Position else u39.Position
        return (Vector3.new(Position.X, u36, Position.Z))
    end

    local Position = if not u39 then a2.Position else if not u39.Parent then a2.Position else u39.Position
    local v1 = Vector3.new(Position.X, u36, Position.Z)
    local u71 = Kit.Part({
        Name = "VineAnchor",
        Transparency = 1,
        Size = a2.Size,
        CFrame = CFrame.new(v1 + Vector3.new(0, Y / 2, 0)),
        Parent = Folder,
    })
    local v2 = vineTemplate(if Attribute ~= "King" then "OrangeVines" else "GreenVines")
    if not v2 then
        local v3, v4, v5
        local Model = Instance.new("Model")
        Model.Name = "VineCage"
        local v6 = math.max(a2.Size.X, a2.Size.Z) / 2
        for i = 1, 6 do
            v3 = i / 6 * 3.141592653589793 * 2
            v4 = v1 + Vector3.new(math.cos(v3), 0, (math.sin(v3))) * v6
            v5 = v1 + Vector3.new(0, Y, 0) + Vector3.new(math.cos(v3 + 1), 0, (math.sin(v3 + 1))) * v6 * 0.35
            v3 = v5 - v4
            Kit.Part({
                Name = "Vine",
                Material = Enum.Material.Grass,
                Color = Green,
                Size = Vector3.new(0.9, 0.9, v3.Magnitude),
                CFrame = CFrame.lookAt(v4 + v3 / 2, v5),
                Parent = Model,
            })
        end
        u187 = Model
    else
        local v7 = v2.Model:Clone()
        local v8 = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0)
        v7:PivotTo(CFrame.new(v1) * v8 * v2.Offset)
        u187 = v7
    end
    u187.Parent = Folder
    if u39 then
        local u201 = v1
        a3:Connect(u39:GetPropertyChangedSignal("Anchored"), function() -- Line: 806 -- upvalues: u39 (val), a2 (val), u36 (val), u71 (val), Y (val), u187 (ref), u201 (ref)
            local Position = if not u39 then a2.Position else if not u39.Parent then a2.Position else u39.Position
            local v1 = Vector3.new(Position.X, u36, Position.Z)
            u71.CFrame = CFrame.new(v1 + Vector3.new(0, Y / 2, 0))
            u187:PivotTo((u187:GetPivot()) + (v1 - u201))
            u201 = v1
        end)
    end
    trackHealth(a3, a2, "Vines", Green, 1, nil, u71)
end

local function standVisuals(a1) -- Line: 818 -- types: a1: userdata
    local v1 = {}
    local OperatorPad = a1:FindFirstChild("OperatorPad")
    if not OperatorPad then
        local OperatorZone = a1:FindFirstChild("OperatorZone")
        if OperatorZone and OperatorZone:IsA("BasePart") then
            v1[OperatorZone] = OperatorZone.Transparency
        end
        return v1
    end
    for i, j in OperatorPad:GetDescendants() do
        if j:IsA("BasePart") or j:IsA("Decal") then
            v1[j] = j.Transparency
        end
    end
    return v1
end

function u74:BindCannon(a2, a3) -- Line: 836
    -- upvalues: CannonAttributes (val), trackHealth (val), Kit (val), u50 (val), RunService (val), standVisuals (val)
    -- upvalues: Players (val), Attributes (val), Phases (val), TrapAttributes (val)
    local RootHitbox = a2:FindFirstChild("RootHitbox") or a2:WaitForChild("RootHitbox", 5)
    if RootHitbox ~= nil and RootHitbox:IsA("BasePart") and a2.Parent ~= nil then
        trackHealth(a3, RootHitbox, "Roots", Kit.Green, 2, function() -- Line: 842 -- upvalues: a2 (val), CannonAttributes (upval)
            return a2:GetAttribute(CannonAttributes.Ready) ~= true
        end)
        local u33 = Instance.new("Highlight")
        u33.Name = "PumpkinCannonFlash"
        u33.Enabled = false
        u33.FillColor = u50
        u33.OutlineColor = u50
        u33.DepthMode = Enum.HighlightDepthMode.Occluded
        u33.Adornee = a2
        u33.Parent = Kit.Debris()
        a3:Add(u33)
        self.CannonFlashes[a2] = 0
        a3:Add(function() -- Line: 857 -- upvalues: self (val), a2 (val)
            self.CannonFlashes[a2] = nil
        end)
        a3:Connect(RunService.RenderStepped, function(a1) -- Line: 860 -- upvalues: self (val), a2 (val), u33 (val) -- types: a1: number
            local v1 = self.CannonFlashes[a2]
            if v1 == nil then
                return
            end
            v1 = math.max(0, v1 - a1 / 0.15)
            self.CannonFlashes[a2] = v1
            u33.Enabled = v1 > 0
            if v1 > 0 then
                u33.FillTransparency = 1 - 0.85 * v1
                u33.OutlineTransparency = 1 - v1
            end
        end)
        local u61 = standVisuals(a2)
        local u62 = nil
        local u63 = 0
        local LocalPlayer = Players.LocalPlayer

        local function usable() -- Line: 880
            -- upvalues: self (val), Attributes (upval), a2 (val), CannonAttributes (upval), Phases (upval)
            -- upvalues: LocalPlayer (val), TrapAttributes (upval)
            local Attribute = self.Arena:GetAttribute(Attributes.Phase)
            if a2:GetAttribute(CannonAttributes.Ready) ~= true then
                return false
            end
            if Attribute ~= Phases.Shield and Attribute ~= Phases.Stunned then
                return false
            end
            local Attribute_2 = a2:GetAttribute(CannonAttributes.OwnerUserId)
            if Attribute_2 ~= LocalPlayer.UserId and Attribute_2 ~= 0 then
                return false
            end
            local Character = LocalPlayer.Character
            if Character ~= nil and Character:GetAttribute(TrapAttributes.Trapped) ~= true then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                local v1 = false
                if Humanoid ~= nil then
                    v1 = 0 < Humanoid.Health
                end
                return v1
            end
            return false
        end

        local function refresh() -- Line: 896 -- upvalues: u63 (ref), usable (val), u62 (ref), u61 (val)
            u63 = os.clock() + 0.1
            local v1 = usable()
            if not v1 then
                if not v1 then
                    for i in u61 do
                        if i.Transparency ~= 1 then
                            i.Transparency = 1
                        end
                    end
                end
            elseif v1 ~= u62 then
                for k, n in u61 do
                    k.Transparency = n
                end
            elseif not v1 then
                for j in u61 do
                    if j.Transparency ~= 1 then
                        j.Transparency = 1
                    end
                end
            end
            u62 = v1
        end

        a3:Connect(a2:GetAttributeChangedSignal(CannonAttributes.Ready), refresh)
        a3:Connect(a2:GetAttributeChangedSignal(CannonAttributes.OwnerUserId), refresh)
        a3:Connect(self.Arena:GetAttributeChangedSignal(Attributes.Phase), refresh)
        a3:Connect(RunService.Heartbeat, function() -- Line: 915 -- upvalues: u63 (ref), refresh (val)
            local v1 = os.clock()
            if u63 <= v1 then
                refresh()
            end
        end)
        refresh()
        a3:Add(function() -- Line: 922 -- upvalues: u61 (val)
            for i, j in u61 do
                i.Transparency = j
            end
        end)
        return
    end
end

function u74.BindMinion(a1, a2, a3) -- Line: 929
    -- upvalues: trackHealth (val), Kit (val), RunService (val), Workspace (val)
    local Hitbox = a2:FindFirstChild("Hitbox") or a2:WaitForChild("Hitbox", 5)
    if Hitbox ~= nil and Hitbox:IsA("BasePart") and a2.Parent ~= nil then
        trackHealth(a3, Hitbox, "Pumpkin Minion", Kit.Orange, 1)
        if not a2:IsA("Model") then
            return
        end
        local u32 = nil
        local u33 = nil
        local u34 = 0
        a3:Add(function() -- Line: 942 -- upvalues: u33 (ref), u32 (ref), a2 (val)
            u33 = nil
            if u32 then
                u32:Destroy()
                u32 = nil
            end
            local PrimaryPart = a2.PrimaryPart and a2.PrimaryPart:FindFirstChild("DroneFuse")
            if PrimaryPart then
                PrimaryPart:Destroy()
            end
        end)
        a3:Connect(RunService.RenderStepped, function(a1) -- Line: 954
            -- upvalues: a2 (val), u33 (ref), u32 (ref), Workspace (upval), u34 (ref), Kit (upval)
            if a2:GetAttribute("Armed") ~= true then
                if u33 then
                    u33 = nil
                    if u32 then
                        u32:Destroy()
                        u32 = nil
                    end
                    local PrimaryPart = a2.PrimaryPart and a2.PrimaryPart:FindFirstChild("DroneFuse")
                    if PrimaryPart then
                        PrimaryPart:Destroy()
                    end
                end
                return
            end
            local ServerTimeNow = Workspace:GetServerTimeNow()
            if u33 == nil then
                u33 = ServerTimeNow
                u34 = 0
                local Highlight = Instance.new("Highlight")
                Highlight.Name = "PumpkinFuse"
                Highlight.Adornee = a2
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight.OutlineTransparency = 0
                Highlight.Parent = Kit.Debris()
                u32 = Highlight
                if a2.PrimaryPart then
                    Kit.Sound("DroneFuse", a2.PrimaryPart, 0.8)
                end
            end
            local v1 = u33
            local Attribute = a2:GetAttribute("FuseEnds")
            local v2 = if type(Attribute) ~= "number" then 2.5 else if not (v1 < Attribute) then 2.5 else Attribute - v1
            local v3 = math.clamp((ServerTimeNow - v1) / v2, 0, 1)
            u34 = u34 + a1 * (v3 * 13 * v3 + 3)
            v2 = u34 % 1 < 0.5
            v3 = u32
            local Red = if not v2 then Kit.Red else Color3.new(1, 1, 1)
            v3.FillColor = Red
            local Red_2 = if not v2 then Color3.new(1, 1, 1) else Kit.Red
            v3.OutlineColor = Red_2
            v3.FillTransparency = if not v2 then 0.6 else 0.05
        end)
        return
    end
end

function u74:Step(a2) -- Line: 993
    -- upvalues: Attributes (val), vineShield (val), Kit (val), u50 (val)
    self.HitFlash = math.max(0, self.HitFlash - a2 / 0.15)
    self.ShieldFlash = math.max(0, self.ShieldFlash - a2 / 0.15)
    self.Bump = math.max(0, self.Bump - a2 / 0.22)
    local Boss = self.Boss
    local v1 = self.Arena:GetAttribute(Attributes.ShieldActive) == true
    local Hitbox = if not Boss then nil else if not Boss.Parent then nil else Boss:FindFirstChild("Hitbox")
    local v2 = if not Hitbox then nil else if not Hitbox:IsA("BasePart") then nil else Hitbox
    if v1 and v2 ~= nil then
        local Bubble = self.Bubble
        if Bubble == nil then
            v1 = math.max(v2.Size.X, v2.Size.Y, v2.Size.Z) + 6
            local v3, v4 = vineShield(v1)
            Bubble = v3 or Kit.Part({
                Name = "PumpkinShield",
                Shape = Enum.PartType.Ball,
                Material = Enum.Material.ForceField,
                Color = Kit.Purple,
                Size = Vector3.new(1, 1, 1) * v1,
            })
            Bubble.Parent = Kit.Debris()
            self.Bubble = Bubble
            v3 = Instance.new("Highlight")
            v3.Name = "PumpkinShieldFlash"
            v3.Enabled = false
            v3.FillColor = u50
            v3.OutlineColor = u50
            v3.DepthMode = Enum.HighlightDepthMode.Occluded
            v3.Parent = Bubble
            self.ShieldGlow = v3
            self.ShieldOffset = v4
            self.ShieldSpan = v1
            self.ShieldAt = nil
            local Spine = Boss and Boss:FindFirstChild("Spine", true)
            self.ShieldBone = if not Spine then nil else if not Spine:IsA("Bone") then nil else Spine
        end
        local ShieldBone = self.ShieldBone
        local v5 = v2.CFrame + (if not ShieldBone then Vector3.new(0, 0, 0) else if not ShieldBone.Parent then Vector3.new(0, 0, 0) else ShieldBone.TransformedWorldCFrame.Position - ShieldBone.WorldCFrame.Position)
        if self.ShieldAt ~= v5 then
            self.ShieldAt = v5
            Bubble:PivotTo(v5 * self.ShieldOffset)
        end
        local ShieldGlow = self.ShieldGlow
        if ShieldGlow and ShieldGlow.Parent then
            local ShieldFlash_2 = self.ShieldFlash
            ShieldGlow.Enabled = ShieldFlash_2 > 0
            ShieldGlow.FillTransparency = 1 - 0.85 * ShieldFlash_2
            ShieldGlow.OutlineTransparency = 1 - ShieldFlash_2
        end
        return
    end
    if self.Bubble then
        self.Bubble:Destroy()
        self.Bubble = nil
    end
end

function u74.ShieldSize(a1) -- Line: 1060
    return a1.ShieldSpan
end

return u74