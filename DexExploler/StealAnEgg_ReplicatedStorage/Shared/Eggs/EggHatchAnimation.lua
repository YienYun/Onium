-- Script path: ReplicatedStorage.Shared.Eggs.EggHatchAnimation
-- Decompile time: 23.19 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Player = require(ReplicatedStorage.Shared.Player)
local SfxRework = require(ReplicatedStorage.Data.SfxRework)
local VisualTransform = require(ReplicatedStorage.Shared.Utils.VisualTransform)
local t = require(ReplicatedStorage.Packages.t)
local u100 = Color3.fromRGB(248, 248, 248)
local Assets_2 = ReplicatedStorage.Assets
local Transient = Workspace.Transient
local PlacedEggOpen = Assets_2.Particles["Egg Open"].PlacedEggOpen
local EggExplode = PlacedEggOpen.EggExplode
local Trail = PlacedEggOpen.Trail
local EggPoof = Assets_2.EggPoof
assert(Transient:IsA("Folder"), "Workspace.Transient must be a Folder")
assert(EggExplode:IsA("Model"), "PlacedEggOpen.EggExplode must be a Model")
assert(Trail:IsA("Trail"), "PlacedEggOpen.Trail must be a Trail")
assert(EggPoof:IsA("BasePart"), "Assets.EggPoof must be a BasePart")
for i, j in EggExplode:GetDescendants() do
    if j:IsA("BasePart") then
        j.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
    end
end
local v1 = {}

local function buildAssetItemData(a1, a2) -- Line: 90 -- types: a2: number?
    local v1 = {
        HasBeenFirstPlaced = false,
        Category = a1.AssetCategory,
        Scale = a2 or a1.AssetScale,
        EyeColor = a1.AssetEyeColor,
        ColorSeed = a1.AssetColorSeed,
        ColorIndex = a1.AssetColorIndex,
    }
    local Mutations = a1.Mutations or {}
    v1.Mutations = Mutations
    v1.BaseMutation = a1.BaseMutation
    return v1
end

local function playPoofSound() -- Line: 106 -- upvalues: Audio (val)
    Audio.Play("rbxassetid://102267539121951", script)
end

local function playAssetRevealSound(a1, a2) -- Line: 108
    -- upvalues: SfxRework (val), Assets (val), Audio (val)
    local v1 = SfxRework.Resolve(a1.AssetCategory, "Idle", Assets.Directory[a1.AssetCategory].RandomIdleSound)
    if v1 == nil then
        return nil
    end
    return Audio.PlayFile(v1, a2)
end

local function arcApex(a1, a2) -- Line: 117 -- types: a1: vector, a2: vector
    local v1 = math.clamp((a2 - a1).Magnitude * 0.6, 2, 36)
    return (a1:Lerp(a2, 0.5)) + Vector3.new(0, 1, 0) * v1
end

local function arcPosition(a1, a2, a3) -- Line: 127 -- types: a1: vector, a2: vector, a3: number
    local v1 = math.clamp((a2 - a1).Magnitude * 0.6, 2, 36)
    local v2 = (a1:Lerp(a2, 0.5)) + Vector3.new(0, 1, 0) * v1
    return (a1:Lerp(v2, a3)):Lerp(v2:Lerp(a2, a3), a3)
end

local function getPlayerBodyPosition(a1, a2) -- Line: 132 -- upvalues: Player (val) -- types: a1: userdata, a2: vector
    local v1 = Player.FindPrimaryPart(a1)
    if v1 then
        return v1:GetPivot().Position
    end
    return a2
end

local function getBottomCFrameFacingPlayer(a1, a2, a3) -- Line: 137
    -- upvalues: Players (val), Player (val)
    local Position
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId == nil then
        return CFrame.new(a2) * a3
    end
    local v1 = Player.FindPrimaryPart(PlayerByUserId)
    local v2 = Vector3.new((if not v1 then a2 else v1:GetPivot().Position).X, a2.Y, Position.Z)
    if (a2 - v2).Magnitude < 0.001 then
        return CFrame.new(a2) * a3
    end
    return CFrame.lookAt(a2, v2)
end

local function shakeEggPass(a1, a2, a3) -- Line: 156
    -- upvalues: RunService (val), EggActionMovement (val)
    local v1 = 0
    while v1 < 0.5 do
        v1 = v1 + RunService.Heartbeat:Wait()
        EggActionMovement.SetPivot(a1, a2 * CFrame.Angles(0, 0, (math.rad((1 - v1 / 0.5) * math.sin((tick()) * 90) * a3))))
    end
end

local function shakeEgg(a1, a2) -- Line: 165 -- upvalues: shakeEggPass (val) -- types: a1: userdata, a2: userdata
    shakeEggPass(a1, a2, 7)
    task.wait(0.3)
    shakeEggPass(a1, a2, 9)
    task.wait(0.3)
    shakeEggPass(a1, a2, 13)
end

local function pivotAssetToEggBottom(a1, a2) -- Line: 173
    -- upvalues: ModelBounds (val)
    local Pivot = a1:GetPivot()
    local v1, v2 = ModelBounds(a1)
    v2 = v1.Position - Vector3.new(0, 1, 0) * (v2.Y * 0.5) - Pivot.Position
    local v3 = a2.Position - v2
    v2 = a2 - a2.Position
    a1:PivotTo((CFrame.new(v3)) * v2)
end

local u168 = 0

local function runHatchMotion(a1, a2) -- Line: 190
    -- upvalues: u168 (ref), RunService (val)
    u168 = u168 + 1
    local v1 = ("EggHatchAnimation.%*"):format(u168)
    local u9 = 0
    local u10 = false
    RunService:BindToRenderStep(v1, Enum.RenderPriority.Last.Value, function(a1_2) -- Line: 195 -- upvalues: u10 (ref), u9 (ref), a1 (val), a2 (val) -- types: a1_2: number
        if u10 then
            return
        end
        u9 = math.min(u9 + a1_2, a1)
        local success, err = pcall(a2, u9 / a1)
        if not success then
            warn((("EggHatchAnimation motion step failed: %*"):format(err)))
        end
        if not success or err or a1 <= u9 then
            u10 = true
        end
    end)
    while not u10 do
        task.wait()
    end
    RunService:UnbindFromRenderStep(v1)
end

local function growAsset(a1, a2, a3) -- Line: 215
    -- upvalues: runHatchMotion (val), TweenService (val), pivotAssetToEggBottom (val)
    local u3 = a3 * 0.5
    runHatchMotion(1.3, function(a1_2) -- Line: 217
        -- upvalues: a1 (val), TweenService (upval), u3 (val), a3 (val), pivotAssetToEggBottom (upval), a2 (val)
        if a1.Parent == nil then
            return true
        end
        local Value = TweenService:GetValue(a1_2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        a1:ScaleTo(u3 + (a3 - u3) * Value)
        pivotAssetToEggBottom(a1, a2)
        return nil
    end)
    if a1.Parent ~= nil then
        a1:ScaleTo(a3)
        pivotAssetToEggBottom(a1, a2)
    end
end

local function lookAtPlayer(a1, a2) -- Line: 236
    -- upvalues: runHatchMotion (val), Player (val), TweenService (val)
    local Pivot = a1:GetPivot()
    runHatchMotion(3, function(a1_2) -- Line: 238
        -- upvalues: a1 (val), Pivot (val), a2 (val), Player (upval), TweenService (upval)
        local Position_2
        if a1.Parent == nil then
            return true
        end
        local v1 = Pivot + Vector3.new(0, math.sin(6.283185307179586 * a1_2 * 0.5) * 1, 0)
        local v2 = a2
        local Position = Pivot.Position
        local v3 = Player.FindPrimaryPart(v2)
        local v4 = Vector3.new((if not v3 then Position else v3:GetPivot().Position).X, v1.Y, Position_2.Z)
        a1:PivotTo((v1:Lerp(
            if not ((v1.Position - v4).Magnitude < 0.001) then CFrame.lookAt(v1.Position, v4) else v1,
            (TweenService:GetValue(a1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        )))
        return nil
    end)
end

local function flyAssetIntoPlayer(a1, a2) -- Line: 262
    -- upvalues: VisualTransform (val), runHatchMotion (val), Player (val), TweenService (val)
    local Scale = a1:GetScale()
    local Pivot = a1:GetPivot()
    local u10 = VisualTransform.Fader()
    task.spawn(function() -- Line: 268
        -- upvalues: runHatchMotion (upval), a1 (val), a2 (val), Pivot (val), Player (upval), TweenService (upval)
        -- upvalues: u10 (val), Scale (val)
        runHatchMotion(0.7, function(a1_2) -- Line: 269
            -- upvalues: a1 (upval), a2 (upval), Pivot (upval), Player (upval), TweenService (upval), u10 (upval)
            -- upvalues: Scale (upval)
            if a1.Parent == nil then
                return true
            end
            local v1 = a2
            local Position = Pivot.Position
            local v2 = Player.FindPrimaryPart(v1)
            local Position_2 = if not v2 then Position else v2:GetPivot().Position
            local Position_3 = Pivot.Position
            local v3 = math.clamp((Position_2 - Position_3).Magnitude * 0.6, 2, 36)
            v2 = (Position_3:Lerp(Position_2, 0.5)) + Vector3.new(0, 1, 0) * v3
            v2 = CFrame.new(((Position_3:Lerp(v2, a1_2)):Lerp(v2:Lerp(Position_2, a1_2), a1_2)))
            local v4 = v2 * Pivot.Rotation
            v1 = Vector3.new(Position_2.X, v4.Y, Position_2.Z)
            local v5 = if not ((v4.Position - v1).Magnitude < 0.001) then CFrame.lookAt(v4.Position, v1) else v4
            v4 = math.clamp((a1_2 - 0.6) / 0.4, 0, 1)
            v1 = TweenService:GetValue(v4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
            u10:Hide(a1, v1)
            a1:ScaleTo((math.max(0.001, Scale * (1 - v1))))
            a1:PivotTo(v5)
            return nil
        end)
        if a1.Parent ~= nil then
            u10:Hide(a1, 1)
            a1:ScaleTo(0.001)
            a1:Destroy()
        end
    end)
    task.wait(0.3)
end

local function playAssetClaimSequence(a1, a2) -- Line: 303
    -- upvalues: Players (val), runHatchMotion (val), Player (val), TweenService (val), flyAssetIntoPlayer (val)
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId == nil then
        a2:Destroy()
        return
    end
    local Pivot = a2:GetPivot()
    runHatchMotion(3, function(a1) -- Line: 238
        -- upvalues: a2 (val), Pivot (val), PlayerByUserId (val), Player (upval), TweenService (upval)
        local Position_2
        if a2.Parent == nil then
            return true
        end
        local v1 = Pivot + Vector3.new(0, math.sin(6.283185307179586 * a1 * 0.5) * 1, 0)
        local v2 = PlayerByUserId
        local Position = Pivot.Position
        local v3 = Player.FindPrimaryPart(v2)
        local v4 = Vector3.new((if not v3 then Position else v3:GetPivot().Position).X, v1.Y, Position_2.Z)
        a2:PivotTo((v1:Lerp(
            if not ((v1.Position - v4).Magnitude < 0.001) then CFrame.lookAt(v1.Position, v4) else v1,
            (TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        )))
        return nil
    end)
    flyAssetIntoPlayer(a2, PlayerByUserId)
end

local function revealAsset(a1, a2, a3, a4) -- Line: 314
    -- upvalues: ItemDisplay (val), buildAssetItemData (val), Transient (val), t (val), ModelBounds (val)
    -- upvalues: pivotAssetToEggBottom (val), growAsset (val), TweenService (val)
    local u13 = ItemDisplay.CreateActiveModel(a2, buildAssetItemData(a3, 1), true, true)
    u13.Name = ("%*_%*"):format(a1, a2)
    u13.Parent = Transient
    local PrimaryPart = u13.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    PrimaryPart.Anchored = true
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 0
    Highlight.OutlineTransparency = 1
    Highlight.Adornee = u13
    Highlight.Parent = u13
    u13:ScaleTo(a3.AssetScale * 0.5)
    local v1, v2 = ModelBounds(u13)
    PrimaryPart.PivotOffset = CFrame.new(0, v1.Position.Y - v2.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)
    pivotAssetToEggBottom(u13, a4)
    task.spawn(function() -- Line: 340 -- upvalues: growAsset (upval), u13 (val), a4 (val), a3 (val)
        growAsset(u13, a4, a3.AssetScale)
    end)
    for i, v in ipairs(u13:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.CanQuery = false
        end
    end
    TweenService:Create(Highlight, TweenInfo.new(0.5), {FillTransparency = 1}):Play()
    return u13
end

function v1.Play(a1, a2, a3, a4, a5) -- Line: 360
    -- upvalues: t (val), Eggs (val), EggRenderer (val), EggExplode (val), Transient (val), Debris (val)
    -- upvalues: ReplicatedStorage (val), Audio (val), ModelBounds (val), getBottomCFrameFacingPlayer (val)
    -- upvalues: shakeEgg (val), u100 (val), revealAsset (val), SfxRework (val), Assets (val), Trail (val)
    -- upvalues: TweenService (val), EmitTree (val), EggPoof (val), Players (val), runHatchMotion (val), Player (val)
    -- upvalues: flyAssetIntoPlayer (val)
    local BoundingBox, BoundingBox_2, Color, Part, PrimaryPart_2, v1, v2, v3
    t.strict(t.number)(a1)
    t.strict(t.string)(a2)
    assert(Eggs.SchemaValidation.SavedEgg(a3), "Invalid saved egg record")
    t.strict(t.instanceIsA("Model"))(a4)
    t.strict(t.optional(t.boolean))(a5)
    EggRenderer.DisableCollisions(a4)
    local u53 = EggExplode:Clone()
    u53:ScaleTo((a4:GetScale()) / 3)
    u53:PivotTo((a4:GetPivot()))
    local Core = u53.Core
    assert(Core:IsA("BasePart"), "Egg explosion Core must be a BasePart")
    Core.Parent = Transient
    Debris:AddItem(Core, 60)
    u53.Parent = ReplicatedStorage
    if not a5 then
        task.wait(0.4)
        Audio.Play("rbxassetid://125937767292519", script, {Volume = 2.8})
    end
    local Pivot_2 = a4:GetPivot()
    local v4, v5 = ModelBounds(a4)
    v5 = v4.Position - Vector3.new(0, 1, 0) * (v5.Y * 0.5) + Vector3.new(0, 0.20000000298023224, 0)
    local v6 = getBottomCFrameFacingPlayer(a1, v5, Pivot_2 - Pivot_2.Position)
    if not a5 then
        shakeEgg(a4, Pivot_2)
    end
    v5 = 0
    v4 = 0
    local v7 = 0
    local v8 = 0
    local Transparency = 0
    for i, v in ipairs(a4:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 1 then
            Color = v.Color
            v5 = v5 + Color.R
            v4 = v4 + Color.G
            v7 = v7 + Color.B
            v8 = v8 + 1
            if 0.3 < v.Transparency then
                Transparency = v.Transparency
            end
        end
    end
    local v9 = if not (v8 > 0) then u100 else Color3.new(v5 / v8, v4 / v8, v7 / v8)
    local PrimaryPart = a4.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    v7 = {
        Color = v9,
        Material = PrimaryPart.Material,
        MaterialVariant = PrimaryPart.MaterialVariant,
        Transparency = PrimaryPart.Transparency,
    }
    a4:Destroy()
    u53.Parent = Transient
    for i2, i3 in ipairs(u53:GetDescendants()) do
        if i3 ~= Core and i3.Name ~= "RootPart" and i3:IsA("BasePart") then
            i3.Anchored = false
        end
    end
    local u198 = revealAsset(a1, a2, a3, v6)
    v4 = SfxRework.Resolve(a3.AssetCategory, "Idle", Assets.Directory[a3.AssetCategory].RandomIdleSound)
    v5 = if v4 ~= nil then Audio.PlayFile(v4, v6) else nil
    for i4, j in ipairs(u53:GetChildren()) do
        if not j:IsA("BasePart") then
            assert(j:IsA("Model"), (("Explosion child %* must be a Model"):format((j:GetFullName()))))
            PrimaryPart_2 = j.PrimaryPart
            t.strict(t.instanceIsA("BasePart"))(PrimaryPart_2)
            BoundingBox, BoundingBox_2 = j:GetBoundingBox()
            Part = Instance.new("Part")
            Part.Transparency = 1
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CFrame = BoundingBox
            Part.Size = BoundingBox_2
            v1 = Instance.new("WeldConstraint")
            v1.Part0 = Part
            v1.Part1 = PrimaryPart_2
            v1.Parent = Part
            Part.Parent = j
            v1 = Instance.new("Attachment")
            v6 = Instance.new("Attachment")
            v1.Parent = Part
            v6.Parent = Part
            v1.Position = Vector3.new(0, BoundingBox_2.Y / 2, 0)
            v6.Position = Vector3.new(0, -BoundingBox_2.Y / 2, 0)
            v2 = Trail:Clone()
            v2.Attachment0 = v1
            v2.Attachment1 = v6
            v2.Color = ColorSequence.new(v7.Color)
            v2.Parent = v1
            v2.Enabled = true
        end
    end
    if not a5 then
        Audio.Play("rbxassetid://102267539121951", script)
    end
    for i5, k in ipairs(u53:GetDescendants()) do
        if k ~= Core and k.Name ~= "RootPart" and k:IsA("BasePart") then
            v1 = CFrame.new(Core.Position, k.Position).LookVector * 16 + Vector3.new(0, 24, 0)
            k.Transparency = Transparency
            k.Color = v9
            k.Material = v7.Material
            k.MaterialVariant = v7.MaterialVariant
            v3 = v1 * k.AssemblyMass
            k:ApplyImpulse(v3)
        end
    end
    task.delay(3, function() -- Line: 498 -- upvalues: u53 (val), TweenService (upval), Debris (upval)
        local v1, v2
        for i, v in ipairs(u53:GetChildren()) do
            for i2, i3 in ipairs(v:GetDescendants()) do
                if i3:IsA("BasePart") then
                    v1 = TweenService
                    v2 = TweenInfo.new(1)
                    v1:Create(i3, v2, {Transparency = 1}):Play()
                end
            end
        end
        Debris:AddItem(u53, 1)
    end)
    local Attachment = Core.Attachment
    assert(Attachment:IsA("Attachment"), "Egg explosion core Attachment must be an Attachment")
    for i6, n in ipairs(Attachment:GetDescendants()) do
        if n:IsA("ParticleEmitter") and n.Name == "ColorMe" then
            n.Color = ColorSequence.new(v7.Color)
        end
    end
    EmitTree(Attachment)
    local Rare = Core.Rare
    assert(Rare:IsA("Attachment"), "Egg explosion core Rare must be an Attachment")
    for i7, m in ipairs(Rare:GetDescendants()) do
        if m:IsA("ParticleEmitter") then
            m.Color = ColorSequence.new(v7.Color)
        end
    end
    EmitTree(Rare)
    v9 = EggPoof:Clone()
    v9.CFrame = Pivot_2
    v9.Parent = Transient
    EmitTree(v9)
    Debris:AddItem(v9, 6)
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId == nil then
        u198:Destroy()
        return v5
    end
    local u343 = u198:GetPivot()
    runHatchMotion(3, function(a1) -- Line: 238
        -- upvalues: u198 (val), u343 (val), PlayerByUserId (val), Player (upval), TweenService (upval)
        local Position_2
        if u198.Parent == nil then
            return true
        end
        local v1 = u343 + Vector3.new(0, math.sin(6.283185307179586 * a1 * 0.5) * 1, 0)
        local v2 = PlayerByUserId
        local Position = u343.Position
        local v3 = Player.FindPrimaryPart(v2)
        local v4 = Vector3.new((if not v3 then Position else v3:GetPivot().Position).X, v1.Y, Position_2.Z)
        u198:PivotTo((v1:Lerp(
            if not ((v1.Position - v4).Magnitude < 0.001) then CFrame.lookAt(v1.Position, v4) else v1,
            (TweenService:GetValue(a1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        )))
        return nil
    end)
    flyAssetIntoPlayer(u198, PlayerByUserId)
    return v5
end

function v1.FadeSoundWhenGrantedToolUnequips(a1, a2) -- Line: 538
    -- upvalues: t (val), Players (val), Audio (val)
    t.strict(t.instanceIsA("Sound"))(a1)
    t.strict(t.string)(a2)
    if not a1:IsDescendantOf(game) then
        return
    end
    local LocalPlayer = Players.LocalPlayer
    local u24 = nil
    local u25 = nil
    local u26 = nil
    local u27 = nil
    local u28 = false

    local function disconnectLifecycle() -- Line: 555 -- upvalues: u24 (ref), u25 (ref), u26 (ref), u27 (ref)
        if u24 ~= nil then
            u24:Disconnect()
            u24 = nil
        end
        if u25 ~= nil then
            u25:Disconnect()
            u25 = nil
        end
        if u26 ~= nil then
            u26:Disconnect()
            u26 = nil
        end
        if u27 ~= nil then
            u27:Disconnect()
            u27 = nil
        end
    end

    local function fadeAndStop() -- Line: 574 -- upvalues: disconnectLifecycle (val), a1 (val), Audio (upval)
        disconnectLifecycle()
        if not a1:IsDescendantOf(game) then
            return
        end
        local v1 = a1
        ;(Audio.FadeTo(v1, {Volume = 0, Seconds = 0.35})).Completed:Once(function() -- Line: 581 -- upvalues: a1 (upval)
            if a1:IsDescendantOf(game) then
                a1:Stop()
            end
        end)
    end

    local function tryBindTool(a1) -- Line: 588
        -- upvalues: u28 (ref), a2 (val), u24 (ref), u27 (ref), fadeAndStop (val)
        if not u28 and a1:IsA("Tool") and (a1:GetAttribute("UID")) == a2 then
            u28 = true
            if u24 ~= nil then
                u24:Disconnect()
                u24 = nil
            end
            a1.Unequipped:Once(fadeAndStop)
            return
        end
    end

    a1.Ended:Once(disconnectLifecycle)
    a1.Stopped:Once(disconnectLifecycle)
    LocalPlayer.DescendantAdded:Connect(tryBindTool)
    for i, j in LocalPlayer:GetDescendants() do
        tryBindTool(j)
        if u28 then
            break
        end
    end
end

return v1