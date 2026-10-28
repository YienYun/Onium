-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.GreatBloom
-- Decompile time: 66.05 ms

local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CameraShakerDriver = require(ReplicatedStorage.Client.CameraShakerDriver)
local GUI = require(ReplicatedStorage.Client.GUI)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Lanes = require(ReplicatedStorage.Client.Notifications.Lanes)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local SakuraBloomVisibility = require(ReplicatedStorage.Client.SakuraBloomVisibility)
local SakuraFX = require(ReplicatedStorage.Client.SakuraFX)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
if not GameFlags.GreatBloomEnabled:Get() then
    return {
        StartEvent = function() end,
        StopEvent = function() end,
    }
end
local u865 = Color3.fromRGB(255, 120, 200)
local u1015 = Color3.fromRGB(120, 20, 70)
local u1025 = Color3.fromRGB(255, 170, 220)
local u1035 = Color3.fromRGB(120, 255, 140)
local u1045 = Color3.fromRGB(255, 90, 110)
local LocalPlayer = Players.LocalPlayer
local Sakura_2 = ReplicatedStorage.Assets.Models.Sakura
local BloomWaypoint = Sakura_2.BloomWaypoint
assert(BloomWaypoint:IsA("BillboardGui"), "Sakura.BloomWaypoint must be a BillboardGui")
local Sparkles = ReplicatedStorage.Assets.VFX.Sakura.Hit:FindFirstChild("Sparkles")
assert(Sparkles and Sparkles:IsA("ParticleEmitter"), "VFX.Sakura.Hit.Sparkles must be a ParticleEmitter")
local Crystal = Sakura_2.Crystal
assert(Crystal:IsA("Model") and Crystal.PrimaryPart, "Sakura.Crystal needs a PrimaryPart")
local Name = Crystal.PrimaryPart.Name
local u790 = (((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("CherryBlossom")):WaitForChild("Bounds")
assert(u790:IsA("BasePart"), "CherryBlossom.Bounds must be a BasePart")
local u1091 = GUI.SakuraEventTutorialFrame()
local SakuraEventTutorialFrame = u1091.SakuraEventTutorialFrame
assert(SakuraEventTutorialFrame:IsA("Frame"), "SakuraEventTutorialFrame.SakuraEventTutorialFrame must be a Frame")
local Ok = SakuraEventTutorialFrame.Ok
assert(Ok:IsA("ImageButton"), "SakuraEventTutorialFrame.Ok must be an ImageButton")
local u1099 = GUI.GreatBloomBanner()
local Banner = u1099:FindFirstChild("Banner")
assert(Banner and Banner:IsA("Frame"), "GreatBloomBanner needs a Banner Frame")
local Position = Banner.Position
local u1128 = 0
local u1134 = GUI.SakuraCrystalCounter()
local GuiObject = u1134:FindFirstChildWhichIsA("GuiObject")
assert(GuiObject, "SakuraCrystalCounter needs a root Frame")
local Count = u1134:FindFirstChild("Count", true)
assert(Count and Count:IsA("TextLabel"), "SakuraCrystalCounter needs a TextLabel named Count")
local Gain = u1134:FindFirstChild("Gain", true)
local UIScale = GuiObject:FindFirstChildOfClass("UIScale")
if not UIScale then
    UIScale = Instance.new("UIScale")
end
UIScale.Parent = GuiObject
local Position_2 = GuiObject.Position
local u1163 = false
local UIStroke = if not Gain then nil else Gain:FindFirstChildOfClass("UIStroke")
local Position_3 = if not Gain then UDim2.new() else Gain.Position
local u1175 = 0
local u1178 = false
local u749 = {}
for i, v in ipairs(GuiObject:GetDescendants()) do
    if not Gain or v ~= Gain and not v:IsDescendantOf(Gain) then
        if v:IsA("TextLabel") then
            table.insert(u749, {Property = "TextTransparency", Instance = v, Value = v.TextTransparency})
            table.insert(u749, {
                Property = "TextStrokeTransparency",
                Instance = v,
                Value = v.TextStrokeTransparency,
            })
        elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
            table.insert(u749, {Property = "ImageTransparency", Instance = v, Value = v.ImageTransparency})
        elseif v:IsA("UIStroke") then
            table.insert(u749, {Property = "Transparency", Instance = v, Value = v.Transparency})
        end
        if v:IsA("GuiObject") and v.BackgroundTransparency < 1 then
            table.insert(u749, {
                Property = "BackgroundTransparency",
                Instance = v,
                Value = v.BackgroundTransparency,
            })
        end
    end
end
if GuiObject.BackgroundTransparency < 1 then
    table.insert(u749, {
        Property = "BackgroundTransparency",
        Instance = GuiObject,
        Value = GuiObject.BackgroundTransparency,
    })
end
local u345 = 0
local u346 = nil
local u347 = 0
local u351 = Trove.new()
local u356 = CameraShaker.new()
local u357 = {}
local u358 = {}
local u359 = {}
local u360 = {}
local u361 = {}
local u362 = {}
local u363 = {}
local u364 = {}
local u365 = {}
local u366 = {}
local u367 = {}
local u368 = {}
local u369 = {}
local u370 = 0
local u371 = false
local u372 = false
local u373 = false
local u374 = nil
local u375 = nil
local u376 = nil
local u377 = false
local u378 = false
local u379 = false
local u380 = {}
local u381 = {}

local function isUnlocked() -- Line: 219 -- upvalues: Save (val), SakuraBloomPolicy (val)
    local v1 = Save.IsLoaded()
    return SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
end

local function shouldPresent() -- Line: 225 -- upvalues: Save (val), SakuraBloomPolicy (val), u371 (ref)
    local v1 = Save.IsLoaded()
    return SakuraBloomPolicy.CanShowBloom(u371, v1, if not v1 then nil else Save.Peek())
end

local function setBloomInstanceHidden(a1, a2) -- Line: 231
    -- upvalues: u380 (val), SakuraBloomVisibility (val)
    local v1 = u380[a1]
    if v1 then
        v1:Clean()
        u380[a1] = nil
    end
    if not a2 then
        return
    end
    u380[a1] = (SakuraBloomVisibility.Conceal(a1))
end

local function setWorldVFXEnabled(a1) -- Line: 243 -- upvalues: CollectionService (val) -- types: a1: boolean
    for i, j in CollectionService:GetTagged("GreatBloomVFX") do
        for k, n in j:GetDescendants() do
            if n:IsA("Beam") or n:IsA("ParticleEmitter") then
                n.Enabled = a1
            end
        end
    end
end

local function refreshReplicatedVisibility() -- Line: 253
    -- upvalues: Save (val), SakuraBloomPolicy (val), CollectionService (val), Sakura (val), u380 (val)
    -- upvalues: SakuraBloomVisibility (val), setWorldVFXEnabled (val), u371 (ref)
    local v1
    local v2 = Save.IsLoaded()
    local v3 = SakuraBloomPolicy.HasBloomUnlocked(v2, if not v2 then nil else Save.Peek())
    for i, j in CollectionService:GetTagged(Sakura.TreeTag) do
        v1 = u380[j]
        if v1 then
            v1:Clean()
            u380[j] = nil
        end
        if not v3 then
            u380[j] = (SakuraBloomVisibility.Conceal(j))
        end
    end
    for k, n in CollectionService:GetTagged(Sakura.CrystalTag) do
        v1 = u380[n]
        if v1 then
            v1:Clean()
            u380[n] = nil
        end
        if not v3 then
            u380[n] = (SakuraBloomVisibility.Conceal(n))
        end
    end
    setWorldVFXEnabled(u371 and v3)
end

local function distanceFromCharacter(a1) -- Line: 264 -- upvalues: Player (val), LocalPlayer (val) -- types: a1: vector
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    if v1 == nil then
        return (1 / 0)
    end
    return (v1.Position - a1).Magnitude
end

local function shakeIfNear(a1, a2, a3, a4) -- Line: 272
    -- upvalues: Player (val), LocalPlayer (val), u356 (val)
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    if (if v1 ~= nil then (v1.Position - a1).Magnitude else (1 / 0)) <= a2 then
        u356:ShakeOnce(a3, a4, 0.1, 0.6)
    end
end

local function notifyTop(a1, a2) -- Line: 278
    -- upvalues: Toast (val), u865 (val), u1015 (val)
    Toast.Show({
        Lane = "Banner",
        Text = a1,
        Color = u865,
        StrokeColor = u1015,
        Seconds = a2,
    })
end

local function showBanner() -- Line: 288
    -- upvalues: u1128 (ref), Lanes (val), Position (val), Banner (val), u1099 (val), TweenService (val)
    u1128 = u1128 + 1
    local u2 = u1128
    local u5 = Lanes.HoldBanner()
    task.spawn(function() -- Line: 292
        -- upvalues: Lanes (upval), u1128 (upval), u2 (val), u5 (val), Position (upval), Banner (upval), u1099 (upval)
        -- upvalues: TweenService (upval)
        while Lanes.IsBannerShowing() do
            if u1128 ~= u2 then
                break
            end
            task.wait(0.1)
        end
        if u1128 ~= u2 then
            u5()
            return
        end
        local v1 = Position - UDim2.fromScale(0, Position.Y.Scale + Banner.Size.Y.Scale)
        Banner.Position = v1
        u1099.Enabled = true
        TweenService:Create(Banner, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Position}):Play()
        task.wait(7)
        if u1128 ~= u2 then
            u5()
            return
        end
        local v2 = TweenService:Create(Banner, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = v1})
        v2.Completed:Once(function() -- Line: 319 -- upvalues: u1128 (upval), u2 (upval), u1099 (upval), u5 (upval)
            if u1128 == u2 then
                u1099.Enabled = false
            end
            u5()
        end)
        v2:Play()
    end)
end

local function showCrystalPopup(a1, a2) -- Line: 329
    -- upvalues: Workspace (val), u865 (val), Simple (val), TweenService (val), Debris (val)
    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.Position = a2 + Vector3.new(0, 4, 0)
    Part.Parent = Workspace
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Size = UDim2.fromOffset(140, 40)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = Part
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.Font = Enum.Font.GothamBlack
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = u865
    TextLabel.TextStrokeTransparency = 0.2
    TextLabel.Text = ("+%* Crystals"):format((Simple.FormatCompact(a1)))
    TextLabel.Parent = BillboardGui
    TweenService:Create(
        Part,
        TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = Part.Position + Vector3.new(0, 6, 0)}
    ):Play()
    TweenService:Create(
        TextLabel,
        TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {TextTransparency = 1, TextStrokeTransparency = 1}
    ):Play()
    Debris:AddItem(Part, 1.2000000000000002)
end

local function setCounterShown(a1, a2) -- Line: 374
    -- upvalues: u749 (val), TweenService (val), u1163 (ref), GuiObject (val), u1134 (val), Position_2 (val)
    -- upvalues: UIScale (val)
    local Instance, Property, v1
    local v2 = TweenInfo.new(a2, Enum.EasingStyle.Quad, if not a1 then Enum.EasingDirection.In else Enum.EasingDirection.Out)
    local v3 = nil
    local v4 = nil
    local v5, v6 = a1, a2
    for i, j in u749, v3, v4 do
        Instance = j.Instance
        v1 = {}
        Property = j.Property
        v1[Property] = if not v5 then 1 else j.Value
        TweenService:Create(Instance, v2, v1):Play()
    end
    if v5 == u1163 then
        return
    end
    u1163 = v5
    v2 = UDim2.fromScale(0, -GuiObject.Size.Y.Scale * 0.6)
    if not v5 then
        TweenService:Create(GuiObject, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = Position_2 + v2}):Play()
        TweenService:Create(UIScale, TweenInfo.new(v6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.85}):Play()
        task.delay(v6, function() -- Line: 419 -- upvalues: u1163 (upval), u1134 (upval)
            if not u1163 then
                u1134.Enabled = false
            end
        end)
        return
    end
    u1134.Enabled = true
    GuiObject.Position = Position_2 + v2
    UIScale.Scale = 0.8
    TweenService:Create(GuiObject, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Position_2}):Play()
    TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local function hideCounter() -- Line: 427 -- upvalues: setCounterShown (val), u347 (ref), u1178 (ref)
    setCounterShown(false, 0.5)
    u347 = 0
    u1178 = false
end

local function animateGain(a1) -- Line: 433
    -- upvalues: Gain (val), u1175 (ref), Simple (val), u1035 (val), u1045 (val), u1178 (ref), Position_3 (val)
    -- upvalues: TweenService (val), UIStroke (val)
    local u1 = Gain
    if u1 ~= nil and u1:IsA("TextLabel") then
        local v1
        u1175 = u1175 + 1
        local u8 = u1175
        local v2 = Simple.FormatCompact((math.abs(a1)))
        u1.Text = ("%*%*"):format(if not (a1 > 0) then "-" else "+", v2)
        u1.TextColor3 = if not v1 then u1045 else u1035
        local u39 = u1.Size.Y.Scale * 0.9
        local u42 = if not v1 then 1 else -1
        v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if not u1178 then
            u1.Position = Position_3 + UDim2.fromScale(0, -u42 * u39 * 0.5)
            u1.TextTransparency = 1
            if UIStroke then
                UIStroke.Transparency = 1
            end
            TweenService:Create(u1, v1, {TextTransparency = 0, Position = Position_3}):Play()
            if UIStroke then
                TweenService:Create(UIStroke, v1, {Transparency = 0}):Play()
            end
        else
            u1.Position = Position_3 + UDim2.fromScale(0, -u42 * u39 * 0.2)
            TweenService:Create(u1, v1, {TextTransparency = 0, Position = Position_3}):Play()
        end
        u1178 = true
        task.delay(1.8000000000000003, function() -- Line: 466
            -- upvalues: u1175 (upval), u8 (val), u1178 (upval), TweenService (upval), u1 (val), Position_3 (upval)
            -- upvalues: u42 (val), u39 (val), UIStroke (upval)
            if u1175 ~= u8 then
                return
            end
            u1178 = false
            local v1 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(u1, v1, {
                TextTransparency = 1,
                Position = Position_3 + UDim2.fromScale(0, u42 * u39),
            }):Play()
            if UIStroke then
                TweenService:Create(UIStroke, v1, {Transparency = 1}):Play()
            end
        end)
        return
    end
end

local function popCounter() -- Line: 483
    -- upvalues: Save (val), u346 (ref), Workspace (val), u345 (ref), u347 (ref), Count (val), Simple (val)
    -- upvalues: animateGain (val), u1163 (ref), setCounterShown (val), UIScale (val), TweenService (val), u1178 (ref)
    local v1 = Save.Await()
    if v1 == nil then
        return
    end
    local SakuraCrystals = v1.SakuraCrystals
    v1 = u346
    u346 = SakuraCrystals
    if v1 ~= nil and SakuraCrystals ~= v1 then
        local v2 = SakuraCrystals - v1
        local ServerTimeNow = Workspace:GetServerTimeNow()
        if u345 < ServerTimeNow or u347 > 0 ~= (v2 > 0) then
            u347 = 0
        end
        u347 = u347 + v2
        Count.Text = Simple.FormatCompact(SakuraCrystals)
        animateGain(u347)
        u345 = Workspace:GetServerTimeNow() + 2.2
        v2 = u1163
        setCounterShown(true, 0.15)
        if v2 then
            UIScale.Scale = 1.12
            TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
        task.delay(2.2, function() -- Line: 512
            -- upvalues: Workspace (upval), u345 (upval), setCounterShown (upval), u347 (upval), u1178 (upval)
            local ServerTimeNow = Workspace:GetServerTimeNow()
            if u345 - 0.05 <= ServerTimeNow then
                setCounterShown(false, 0.5)
                u347 = 0
                u1178 = false
            end
        end)
        return
    end
end

local function decorateTree(a1) -- Line: 519 -- upvalues: u1025 (val), u361 (val), Sparkles (val) -- types: a1: userdata
    local PrimaryPart = a1.PrimaryPart
    assert(PrimaryPart, (("%* needs a PrimaryPart"):format(a1.Name)))
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "BloomOutline"
    Highlight.FillColor = Color3.new(0, 0, 0)
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = u1025
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Enabled = false
    Highlight.Parent = a1
    u361[a1] = Highlight
    local v1 = Sparkles:Clone()
    v1.Name = "BloomSparkles"
    v1.Rate = 14
    v1.Enabled = true
    v1.Parent = PrimaryPart
end

local function damageFraction(a1) -- Line: 539 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Hits")
    local Attribute_2 = a1:GetAttribute("HitsRequired")
    if typeof(Attribute) == "number" and typeof(Attribute_2) == "number" and not (Attribute_2 <= 1) then
        return (math.clamp(Attribute / Attribute_2, 0, 1))
    end
    return 0
end

local function renderDamage(a1) -- Line: 548 -- upvalues: u361 (val), TweenService (val) -- types: a1: userdata
    local v1 = u361[a1]
    if v1 == nil then
        return
    end
    local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v3 = {}
    local Attribute = a1:GetAttribute("Hits")
    local Attribute_2 = a1:GetAttribute("HitsRequired")
    v3.FillTransparency = 1 - (if typeof(Attribute) ~= "number" or typeof(Attribute_2) ~= "number" then 0 else if not (Attribute_2 <= 1) then math.clamp(Attribute / Attribute_2, 0, 1) else 0) * 0.85
    TweenService:Create(v1, v2, v3):Play()
end

local function shakeTree(a1) -- Line: 560 -- upvalues: u358 (val), u360 (val), u359 (val) -- types: a1: userdata
    local u2 = u358[a1]
    if u2 ~= nil and not u360[a1] then
        local u8 = (u359[a1] or 0) + 1
        u359[a1] = u8
        local Attribute = a1:GetAttribute("Radius")
        local u25 = math.clamp((if typeof(Attribute) ~= "number" then 10 else Attribute) / 10, 0.8, 1.6) * 0.06981317007977318
        local u28 = math.random() * 100
        task.spawn(function() -- Line: 571 -- upvalues: a1 (val), u359 (upval), u8 (val), u28 (val), u25 (val), u2 (val)
            local v1, v2
            local v3 = 0
            while v3 < 0.7 do
                if not a1.Parent or u359[a1] ~= u8 then
                    break
                end
                v3 = v3 + task.wait()
                v1 = (1 - v3 / 0.7) ^ 2
                v2 = v3 * 9
                a1:PivotTo(u2 * (CFrame.Angles(math.noise(u28, v2) * 2 * u25 * v1, 0, math.noise(v2, u28) * 2 * u25 * v1)))
            end
            if a1.Parent and u359[a1] == u8 then
                a1:PivotTo(u2)
            end
        end)
        return
    end
end

local function clampTreeHeight(a1) -- Line: 593 -- types: a1: userdata
    local Y = a1:GetExtentsSize().Y
    if Y > 30 then
        a1:ScaleTo((a1:GetScale()) * (30 / Y))
    end
end

local function growTree(a1) -- Line: 602
    -- upvalues: u360 (val), TweenService (val), decorateTree (val), renderDamage (val)
    if a1 and not a1:GetAttribute("TreeLoaded") then
        a1:SetAttribute("TreeLoaded", true)
        u360[a1] = true
        local Scale = a1:GetScale()
        task.spawn(function() -- Line: 611
            -- upvalues: a1 (val), Scale (val), TweenService (upval), decorateTree (upval), renderDamage (upval)
            -- upvalues: u360 (upval)
            local Y, v1
            local v2 = 0
            a1:ScaleTo(Scale * 0.05)
            while v2 < 0.55 do
                if not a1.Parent then
                    break
                end
                v2 = v2 + task.wait()
                a1:ScaleTo(Scale * (math.max(0.05, (TweenService:GetValue(math.clamp(v2 / 0.55, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out)))))
                v1 = a1
                Y = v1:GetExtentsSize().Y
                if Y > 30 then
                    v1:ScaleTo((v1:GetScale()) * (30 / Y))
                end
            end
            if a1.Parent then
                a1:ScaleTo(Scale)
                local v3 = a1
                local Y_2 = v3:GetExtentsSize().Y
                if Y_2 > 30 then
                    v3:ScaleTo((v3:GetScale()) * (30 / Y_2))
                end
                decorateTree(a1)
                renderDamage(a1)
            end
            u360[a1] = nil
        end)
        return
    end
    warn(a1, "already loaded")
end

local function fallTree(a1, a2) -- Line: 634
    -- upvalues: Sakura (val), Workspace (val), TweenService (val)
    local u87 = a1:Clone()
    u87.Name = "SakuraTreeFalling"
    u87:RemoveTag(Sakura.TreeTag)
    for i, v in ipairs(u87:GetTags()) do
        u87:RemoveTag(v)
    end
    for i2, i3 in ipairs(u87:GetDescendants()) do
        if i3:IsA("BasePart") then
            i3.Anchored = true
            i3.CanCollide = false
            i3.CanQuery = false
            i3.CanTouch = false
        elseif i3:IsA("ProximityPrompt")
            or i3:IsA("BillboardGui")
            or i3:IsA("ParticleEmitter")
            or i3:IsA("Highlight") then
            i3:Destroy()
        end
    end
    u87.Parent = Workspace
    local Scale = u87:GetScale()
    local u52 = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0)
    task.spawn(function() -- Line: 659 -- upvalues: TweenService (upval), u87 (val), a2 (val), u52 (val), Scale (val)
        local v1, v2
        local v3 = 0
        while v3 < 0.6 do
            v3 = v3 + task.wait()
            v1 = math.clamp(v3 / 0.6, 0, 1)
            v2 = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In) * 0.6108652381980153
            u87:PivotTo(a2 * u52 * CFrame.Angles(v2, 0, 0) * (u52:Inverse()))
            u87:ScaleTo(Scale * (math.max(0.05, 1 - v1 * v1)))
        end
        u87:Destroy()
    end)
end

local function onTreeHit(a1) -- Line: 676
    -- upvalues: shakeTree (val), renderDamage (val), SakuraFX (val), Player (val), LocalPlayer (val), u356 (val)
    shakeTree(a1)
    renderDamage(a1)
    local Position = a1:GetPivot().Position
    local Attribute = a1:GetAttribute("Height")
    SakuraFX.EmitBurst("Hit", Position + Vector3.new(0, (if typeof(Attribute) ~= "number" then 20 else Attribute) * 0.6, 0), 30, 8)
    SakuraFX.PlayCue("TreeHit", Position, 0.9, 0.9 + math.random() * 0.2)
    local v1 = Player.FindPrimaryPart(LocalPlayer)
    if (if v1 ~= nil then (v1.Position - Position).Magnitude else (1 / 0)) <= 30 then
        u356:ShakeOnce(0.8, 6, 0.1, 0.6)
    end
end

local function updateHighlights() -- Line: 688 -- upvalues: Player (val), LocalPlayer (val), u361 (val)
    local Attribute, Attribute_2, Magnitude, v1
    local v2 = Player.FindPrimaryPart(LocalPlayer)
    local v3 = {}
    local v4 = nil
    local v5 = nil
    for i, j in u361, v4, v5 do
        if i.Parent ~= nil then
            Magnitude = if not v2 then (1 / 0) else (v2.Position - i:GetPivot().Position).Magnitude
            Attribute = i:GetAttribute("Hits")
            Attribute_2 = i:GetAttribute("HitsRequired")
            if (if typeof(Attribute) ~= "number" or typeof(Attribute_2) ~= "number" then 0 else if not (Attribute_2 <= 1) then math.clamp(Attribute / Attribute_2, 0, 1) else 0) > 0 then
                Magnitude = 0
            end
            if not (Magnitude <= 160) then
                j.Enabled = false
            else
                table.insert(v3, {Tree = i, Distance = Magnitude})
            end
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 707
        return a1.Distance < a2.Distance
    end)
    v4 = nil
    v5 = nil
    for k, n in v3, v4, v5 do
        v1 = u361[n.Tree]
        v1.Enabled = k <= 24
    end
end

local function onTreeAdded(a1) -- Line: 715
    -- upvalues: Save (val), SakuraBloomPolicy (val), u357 (val), u358 (val), Sakura (val), Player (val)
    -- upvalues: LocalPlayer (val), u356 (val), SakuraFX (val), growTree (val), u362 (val), onTreeHit (val)
    local v1 = Save.IsLoaded()
    if SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
        and a1:IsA("Model")
        and a1.Name ~= "SakuraTreeFalling" then
        local Position = a1:GetPivot().Position
        u357[a1] = Position
        u358[a1] = (a1:GetPivot())
        local SpawnShakeRadius = Sakura.Bloom.SpawnShakeRadius
        local v2 = Player.FindPrimaryPart(LocalPlayer)
        if (if v2 ~= nil then (v2.Position - Position).Magnitude else (1 / 0)) <= SpawnShakeRadius then
            u356:ShakeOnce(1.5, 8, 0.1, 0.6)
        end
        SakuraFX.EmitBurst("Spawn", Position + Vector3.new(0, 1, 0), 40, 10)
        SakuraFX.PlayCue("TreeSpawn", Position, 0.7, 0.75)
        growTree(a1)
        local v3 = u362[a1]
        if v3 then
            v3:Disconnect()
        end
        u362[a1] = ((a1:GetAttributeChangedSignal("Hits")):Connect(function() -- Line: 731 -- upvalues: onTreeHit (upval), a1 (val)
            onTreeHit(a1)
        end))
        return
    end
end

local function onTreeRemoved(a1) -- Line: 736
    -- upvalues: u357 (val), u358 (val), u359 (val), u360 (val), u361 (val), u362 (val), fallTree (val), Player (val)
    -- upvalues: LocalPlayer (val), u356 (val), SakuraFX (val)
    local v1 = u357[a1]
    local v2 = u358[a1]
    u357[a1] = nil
    u358[a1] = nil
    u359[a1] = nil
    u360[a1] = nil
    u361[a1] = nil
    local v3 = u362[a1]
    if v3 then
        v3:Disconnect()
        u362[a1] = nil
    end
    if v1 == nil then
        return
    end
    if a1:IsA("Model") and v2 then
        fallTree(a1, v2)
    end
    v3 = Player.FindPrimaryPart(LocalPlayer)
    if (if v3 ~= nil then (v3.Position - v1).Magnitude else (1 / 0)) <= 60 then
        u356:ShakeOnce(2, 10, 0.1, 0.6)
    end
    SakuraFX.EmitBurst("Break", v1 + Vector3.new(0, 8, 0), 90, 12)
    SakuraFX.PlayCue("TreeBreak", v1, 1, 1)
end

local function onCrystalAdded(a1) -- Line: 760
    -- upvalues: Save (val), SakuraBloomPolicy (val), Name (val), u364 (val), u865 (val), u365 (val), Players (val)
    -- upvalues: u366 (val), u367 (val), u368 (val)
    local v1 = Save.IsLoaded()
    if SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) and a1:IsA("Model") then
        local PrimaryPart = a1.PrimaryPart or a1:WaitForChild(Name, 5)
        if PrimaryPart ~= nil and a1.Parent ~= nil and not u364[a1] then
            u364[a1] = (a1:GetPivot())
            local PointLight = Instance.new("PointLight")
            PointLight.Color = u865
            PointLight.Brightness = 1.2
            PointLight.Range = 8
            PointLight.Parent = PrimaryPart
            u365[a1] = PointLight
            local Attribute = a1:GetAttribute("Owner")
            local v2 = if typeof(Attribute) ~= "number" then nil else Players:GetPlayerByUserId(Attribute)
            local Attribute_2 = a1:GetAttribute("Origin")
            if v2 and typeof(Attribute_2) == "Vector3" then
                u366[a1] = v2
                u367[a1] = Attribute_2
                u368[a1] = 0
                a1:PivotTo((CFrame.new(Attribute_2)))
            end
            return
        end
        return
    end
end

local function hideCrystal(a1) -- Line: 799 -- upvalues: u364 (val), u369 (val) -- types: a1: userdata
    u364[a1] = nil
    u369[a1] = nil
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("PointLight") then
            v.Enabled = false
        end
    end
end

local function requestCollect(a1, a2) -- Line: 811
    -- upvalues: Remotes (val), u363 (val), u364 (val), u369 (val)
    task.spawn(function() -- Line: 812 -- upvalues: Remotes (upval), a1 (val), u363 (upval), u364 (upval), a2 (val), u369 (upval)
        if not Remotes.Bloomery.AskGatherPetal:InvokeServer(a1) then
            task.wait(1)
            u363[a1] = nil
            if a1.Parent then
                u364[a1] = a2
                u369[a1] = 0
            end
        end
    end)
end

local function animateCrystals(a1, a2) -- Line: 825
    -- upvalues: Player (val), LocalPlayer (val), u364 (val), u368 (val), u367 (val), TweenService (val), u369 (val)
    -- upvalues: u363 (val), u366 (val), Sakura (val), Remotes (val), hideCrystal (val), u365 (val)
    local Angles_3, Value, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = Player.FindPrimaryPart(LocalPlayer)
    local v11 = u364
    local v12 = nil
    local v13 = nil
    local v14, v15 = a2, a1
    for i, j in v11, v12, v13 do
        if i.Parent ~= nil then
            v8 = u368[i]
            v9 = u367[i]
            if v8 == nil or not v9 then
                v9 = u366[i]
                v8 = if not v9 then nil else Player.FindPrimaryPart(v9)
                v1 = u369[i]
                if v1 == nil or not v8 then
                    v1 = false
                    if v10 ~= nil then
                        v1 = (v10.Position - j.Position).Magnitude <= 22
                    end
                    v9 = (math.sin(v15 * (if not v1 then 2 else 4) + j.Position.X)) * 0.35
                    v5 = j * CFrame.new(0, v9, 0)
                    Angles_3 = CFrame.Angles
                    v7 = v15 * 1.2
                    v4 = v5 * (Angles_3(0, v7 * (if not v1 then 1 else 2.5), 0))
                    i:PivotTo(v4)
                    v9 = u365[i]
                    if v9 then
                        v9.Brightness = if not v1 then 1.2 else math.sin(v15 * 6) * 0.8 + 2.5
                    end
                else
                    v1 = v1 + v14
                    u369[i] = v1
                    v2 = math.clamp(v1 / 0.7, 0, 1)
                    v3 = v2 * v2
                    v4 = v8.Position + Vector3.new(0, 1, 0)
                    v6 = (i:GetPivot()).Position:Lerp(v4, (math.min(1, v3 * 0.5 + v14 * 6)))
                    v7 = (CFrame.new(v6)) * (CFrame.Angles(0, v15 * 1.2 * 4, 0))
                    i:PivotTo(v7)
                    v7 = math.max(0.2, Sakura.Bloom.CrystalScale * (1 - v3 * 0.6))
                    i:ScaleTo(v7)
                    if v2 >= 1 or (v6 - v4).Magnitude < 1 then
                        if v9 ~= LocalPlayer then
                            hideCrystal(i)
                        else
                            u369[i] = nil
                            u364[i] = nil
                            task.spawn(function() -- Line: 812 -- upvalues: Remotes (upval), i (val), u363 (upval), u364 (upval), j (val), u369 (upval)
                                if not Remotes.Bloomery.AskGatherPetal:InvokeServer(i) then
                                    task.wait(1)
                                    u363[i] = nil
                                    if i.Parent then
                                        u364[i] = j
                                        u369[i] = 0
                                    end
                                end
                            end)
                        end
                    end
                end
            else
                v8 = v8 + v14
                u368[i] = v8
                v1 = math.clamp(v8 / 0.5, 0, 1)
                Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                v3 = math.sin(v1 * 3.141592653589793) * 6
                v6 = (CFrame.new((v9:Lerp(j.Position, Value)) + (Vector3.new(0, v3, 0)))) * (CFrame.Angles(0, v15 * 1.2 * 3, 0))
                i:PivotTo(v6)
                if v8 >= 0.7 then
                    u368[i] = nil
                    u369[i] = 0
                    u363[i] = true
                end
            end
        end
    end
end

local function findTreeInReach(a1) -- Line: 896 -- upvalues: u358 (val), u360 (val), Sakura (val) -- types: a1: userdata
    local Attribute, Magnitude, v1
    local v2 = nil
    local v3 = (1 / 0)
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in u358, v4, v5 do
        if i.Parent ~= nil and not u360[i] then
            Attribute = i:GetAttribute("Radius")
            v1 = ("%* needs a Radius attribute"):format(i.Name)
            assert(typeof(Attribute) == "number", v1)
            Magnitude = Vector3.new(v6.Position.X - j.Position.X, 0, v6.Position.Z - j.Position.Z).Magnitude
            if Magnitude <= Attribute + Sakura.Bloom.HitRange and Magnitude < v3 then
                v2 = i
            end
        end
    end
    return v2
end

local function tryAutoSwing() -- Line: 916
    -- upvalues: u378 (ref), Player (val), LocalPlayer (val), Sakura (val), findTreeInReach (val), Save (val)
    -- upvalues: SakuraBloomPolicy (val), Remotes (val)
    if u378 then
        return
    end
    local v1 = Player.FindCharacter(LocalPlayer)
    local v2 = Player.FindPrimaryPart(LocalPlayer)
    local v3 = Player.FindHumanoid(LocalPlayer)
    if v1 ~= nil and v2 ~= nil and v3 ~= nil and not (v3.Health <= 0) then
        local Tool = v1:FindFirstChildOfClass("Tool")
        if Tool ~= nil and Sakura.IsBatTool(Tool) then
            v1 = findTreeInReach(v2)
            if v1 == nil then
                return
            end
            v2 = Save.IsLoaded()
            if not SakuraBloomPolicy.HasBloomUnlocked(v2, if not v2 then nil else Save.Peek()) then
                return
            end
            local Animator = v3:FindFirstChildOfClass("Animator")
            v3 = Tool:FindFirstChild("HitAnim")
            local v4 = ("%* needs a HitAnim and the character an Animator"):format(Tool.Name)
            assert(Animator and v3 and v3:IsA("Animation"), v4)
            u378 = true
            local u76 = Animator:LoadAnimation(v3)
            u76.Priority = Enum.AnimationPriority.Action
            u76:Play()
            Remotes.Bloomery.AskStrikeTree:FireServer(v1)
            task.spawn(function() -- Line: 948 -- upvalues: u76 (val), u378 (upval)
                local v1 = os.clock() + 3
                repeat
                    task.wait()
                until not u76.IsPlaying or v1 <= os.clock()
                u76:Stop()
                u76:Destroy()
                u378 = false
            end)
            return
        end
        return
    end
end

local function isInsideBounds(a1) -- Line: 959 -- upvalues: u790 (val) -- types: a1: vector
    local v1 = u790.CFrame:PointToObjectSpace(a1)
    local v2 = false
    if (math.abs(v1.X)) <= u790.Size.X / 2 + 90 then
        v2 = (math.abs(v1.Z)) <= u790.Size.Z / 2 + 90
    end
    return v2
end

local function buildWaypoint() -- Line: 965
    -- upvalues: u790 (val), Workspace (val), BloomWaypoint (val), u376 (ref), u375 (ref), u377 (ref), u351 (val)
    local UIStroke
    local Part = Instance.new("Part")
    Part.Name = "BloomWaypointHost"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.Position = u790.Position + Vector3.new(0, 24, 0)
    Part.Parent = Workspace
    local v1 = BloomWaypoint:Clone()
    v1.Enabled = false
    for i, j in v1:GetChildren() do
        if j:IsA("TextLabel") then
            j.TextTransparency = 1
            UIStroke = j:FindFirstChildOfClass("UIStroke")
            if UIStroke then
                UIStroke.Transparency = 1
            end
        end
    end
    v1.Parent = Part
    u376 = Part
    u375 = v1
    u377 = false
    u351:Add(Part)
    u351:Add(function() -- Line: 992 -- upvalues: u375 (upval), u376 (upval), u377 (upval)
        u375 = nil
        u376 = nil
        u377 = false
    end)
end

local function setWaypointShown(a1, a2) -- Line: 999
    -- upvalues: u377 (ref), TweenService (val)
    local UIStroke
    if u377 == a2 then
        return
    end
    u377 = a2
    local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v2 = if not a2 then 1 else 0
    if a2 then
        a1.Enabled = true
    end
    for i, j in a1:GetChildren() do
        if j:IsA("TextLabel") then
            TweenService:Create(j, v1, {TextTransparency = v2}):Play()
            UIStroke = j:FindFirstChildOfClass("UIStroke")
            if UIStroke then
                TweenService:Create(UIStroke, v1, {Transparency = v2}):Play()
            end
        end
    end
    if not a2 then
        task.delay(0.5, function() -- Line: 1020 -- upvalues: u377 (upval), a1 (val)
            if not u377 and a1.Parent then
                a1.Enabled = false
            end
        end)
    end
end

local function renderWaypoint() -- Line: 1028
    -- upvalues: u375 (ref), u376 (ref), Player (val), LocalPlayer (val), u790 (val), setWaypointShown (val)
    local v1 = u375
    local v2 = u376
    if v1 ~= nil and v2 ~= nil then
        local v3 = Player.FindPrimaryPart(LocalPlayer)
        if v3 ~= nil then
            local v4 = u790.CFrame:PointToObjectSpace(v3.Position)
            local v5 = false
            if (math.abs(v4.X)) <= u790.Size.X / 2 + 90 then
                v5 = (math.abs(v4.Z)) <= u790.Size.Z / 2 + 90
            end
            if not v5 and LocalPlayer:GetAttribute("AreaId") == "Prehistoric" then
                setWaypointShown(v1, true)
                local Countdown = v1:FindFirstChild("Countdown")
                if Countdown and Countdown:IsA("TextLabel") then
                    Countdown.Text = ("%* studs"):format((math.floor((v3.Position - v2.Position).Magnitude)))
                end
                return
            end
        end
        setWaypointShown(v1, false)
        return
    end
end

local function toggleMusic(a1) -- Line: 1050 -- types: a1: boolean
    if a1 then
        script.SakuraEventMusic:Play()
        return
    end
    script.SakuraEventMusic:Stop()
end

local function hideTutorial() -- Line: 1058 -- upvalues: u1091 (val), u374 (ref)
    if not u1091.Enabled and u374 == nil then
        return
    end
    u1091.Enabled = false
    local v1 = u374
    u374 = nil
    if v1 ~= nil then
        v1()
    end
end

local function checkEndingWarning() -- Line: 1105
    -- upvalues: u372 (ref), u370 (ref), Workspace (val), Sakura (val), Toast (val), u865 (val), u1015 (val)
    if u372 then
        return
    end
    local v1 = u370 - Workspace:GetServerTimeNow()
    if v1 <= Sakura.Bloom.EndingWarningSeconds and v1 > 0 then
        u372 = true
        Toast.Show({
            Lane = "Banner",
            Seconds = 4,
            Text = ("🌸 The Great Bloom ends in %* seconds!"):format(Sakura.Bloom.EndingWarningSeconds),
            Color = u865,
            StrokeColor = u1015,
        })
    end
end

local function stopPresentation() -- Line: 1120
    -- upvalues: u351 (val), u379 (ref), u1128 (ref), u1099 (val), u1091 (val), u374 (ref), setCounterShown (val)
    -- upvalues: u347 (ref), u1178 (ref), u362 (val), u361 (val), u358 (val), u357 (val), u359 (val), u360 (val)
    -- upvalues: u378 (ref), Save (val), u346 (ref), setWorldVFXEnabled (val)
    local v1
    u351:Clean()
    u379 = false
    u1128 = u1128 + 1
    u1099.Enabled = false
    if u1091.Enabled or u374 ~= nil then
        u1091.Enabled = false
        v1 = u374
        u374 = nil
        if v1 ~= nil then
            v1()
        end
    end
    setCounterShown(false, 0.5)
    u347 = 0
    u1178 = false
    for i, j in u362 do
        j:Disconnect()
        u362[i] = nil
    end
    for k, n in u361 do
        if n.Parent then
            n:Destroy()
        end
    end
    local v2 = nil
    local v3 = nil
    for m in u358, v2, v3 do
        if m.Parent then
            m:SetAttribute("TreeLoaded", nil)
            for i5, i6 in m:GetDescendants() do
                if i6.Name == "BloomSparkles" then
                    i6:Destroy()
                end
            end
        end
    end
    table.clear(u357)
    table.clear(u358)
    table.clear(u359)
    table.clear(u360)
    table.clear(u361)
    u378 = false
    v1 = Save.Peek()
    u346 = if not v1 then nil else v1.SakuraCrystals
    setWorldVFXEnabled(false)
    script.SakuraEventMusic:Stop()
end

local function startPresentation() -- Line: 1158
    -- upvalues: u379 (ref), Save (val), SakuraBloomPolicy (val), u371 (ref), setWorldVFXEnabled (val)
    -- upvalues: CollectionService (val), Sakura (val), onTreeAdded (val), u351 (val), onTreeRemoved (val)
    -- upvalues: buildWaypoint (val), u346 (ref), RunService (val), animateCrystals (val), updateHighlights (val)
    -- upvalues: tryAutoSwing (val), renderWaypoint (val), u372 (ref), u370 (ref), Workspace (val), Toast (val)
    -- upvalues: u865 (val), u1015 (val), LocalPlayer (val), u790 (val), onCrystalAdded (val), u1128 (ref), Lanes (val)
    -- upvalues: Position (val), Banner (val), u1099 (val), TweenService (val)
    if not u379 then
        local v1 = Save.IsLoaded()
        local v2 = if not v1 then nil else Save.Peek()
        if SakuraBloomPolicy.CanShowBloom(u371, v1, v2) then
            u379 = true
            setWorldVFXEnabled(true)
            script.SakuraEventMusic:Play()
            for i, v in ipairs(CollectionService:GetTagged(Sakura.TreeTag)) do
                onTreeAdded(v)
            end
            u351:Add(((CollectionService:GetInstanceAddedSignal(Sakura.TreeTag)):Connect(onTreeAdded)))
            u351:Add(((CollectionService:GetInstanceRemovedSignal(Sakura.TreeTag)):Connect(onTreeRemoved)))
            buildWaypoint()
            u346 = if not Save.Await() then nil else Save.Await().SakuraCrystals
            local u82 = 0
            local u83 = 0
            u351:Add((RunService.Heartbeat:Connect(function(a1) -- Line: 1177
                -- upvalues: u83 (ref), u82 (ref), animateCrystals (upval), updateHighlights (upval)
                -- upvalues: tryAutoSwing (upval), renderWaypoint (upval), u372 (upval), u370 (upval), Workspace (upval)
                -- upvalues: Sakura (upval), Toast (upval), u865 (upval), u1015 (upval), LocalPlayer (upval)
                -- upvalues: u790 (upval)
                local v1
                u83 = u83 + a1
                u82 = u82 + a1
                animateCrystals(u83, a1)
                if u82 >= 0.15 then
                    u82 = 0
                    updateHighlights()
                    tryAutoSwing()
                    renderWaypoint()
                    if not u372 then
                        v1 = u370 - Workspace:GetServerTimeNow()
                        if v1 <= Sakura.Bloom.EndingWarningSeconds and v1 > 0 then
                            u372 = true
                            local v2 = ("🌸 The Great Bloom ends in %* seconds!"):format(Sakura.Bloom.EndingWarningSeconds)
                            Toast.Show({
                                Lane = "Banner",
                                Seconds = 4,
                                Text = v2,
                                Color = u865,
                                StrokeColor = u1015,
                            })
                        end
                    end
                end
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    local Position = HumanoidRootPart.Position
                    v1 = u790.CFrame:PointToObjectSpace(Position)
                    local v3 = false
                    if (math.abs(v1.X)) <= u790.Size.X / 2 + 90 then
                        v3 = (math.abs(v1.Z)) <= u790.Size.Z / 2 + 90
                    end
                    if v3 and Workspace:GetAttribute("AdminAbuseOnTop") ~= true then
                        script.SakuraEventMusic.Volume = 0.5
                        return
                    end
                end
                script.SakuraEventMusic.Volume = 0
            end)))
            for i2, j in CollectionService:GetTagged(Sakura.CrystalTag) do
                onCrystalAdded(j)
            end
            u1128 = u1128 + 1
            local u111 = u1128
            local u114 = Lanes.HoldBanner()
            task.spawn(function() -- Line: 292
                -- upvalues: Lanes (upval), u1128 (upval), u111 (val), u114 (val), Position (upval), Banner (upval)
                -- upvalues: u1099 (upval), TweenService (upval)
                while Lanes.IsBannerShowing() do
                    if u1128 ~= u111 then
                        break
                    end
                    task.wait(0.1)
                end
                if u1128 ~= u111 then
                    u114()
                    return
                end
                local v1 = Position - UDim2.fromScale(0, Position.Y.Scale + Banner.Size.Y.Scale)
                Banner.Position = v1
                u1099.Enabled = true
                TweenService:Create(Banner, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Position}):Play()
                task.wait(7)
                if u1128 ~= u111 then
                    u114()
                    return
                end
                local v2 = TweenService:Create(Banner, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = v1})
                v2.Completed:Once(function() -- Line: 319 -- upvalues: u1128 (upval), u111 (upval), u1099 (upval), u114 (upval)
                    if u1128 == u111 then
                        u1099.Enabled = false
                    end
                    u114()
                end)
                v2:Play()
            end)
            return
        end
    end
end

function u381.StartEvent(a1, a2, a3) -- Line: 1215
    -- upvalues: stopPresentation (val), u371 (ref), u372 (ref), u370 (ref), Workspace (val)
    -- upvalues: refreshReplicatedVisibility (val), Save (val), SakuraBloomPolicy (val), startPresentation (val)
    stopPresentation()
    u371 = true
    u372 = false
    u370 = Workspace:GetServerTimeNow() + a2
    refreshReplicatedVisibility()
    local v1 = Save.IsLoaded()
    local v2 = if not v1 then nil else Save.Peek()
    if SakuraBloomPolicy.CanShowBloom(u371, v1, v2) then
        startPresentation()
        return
    end
    stopPresentation()
end

function u381.StopEvent(a1) -- Line: 1223
    -- upvalues: u371 (ref), stopPresentation (val), refreshReplicatedVisibility (val)
    u371 = false
    stopPresentation()
    refreshReplicatedVisibility()
end

CameraShakerDriver.Start(u356, Enum.RenderPriority.Camera.Value + 2)
u1091.Enabled = false
u1099.Enabled = false
for i2, j in u749 do
    j.Instance[j.Property] = 1
end
if Gain and Gain:IsA("TextLabel") then
    Gain.TextTransparency = 1
    if UIStroke then
        UIStroke.Transparency = 1
    end
end
GUI.OnActivated(Ok, function() -- Line: 1080
    -- upvalues: u373 (ref), u1091 (val), u374 (ref), Save (val), Remotes (val), CollectionService (val)
    -- upvalues: LocalPlayer (val), Tabs (val)
    local v1
    if u373 then
        return
    end
    u373 = true
    if u1091.Enabled or u374 ~= nil then
        u1091.Enabled = false
        v1 = u374
        u374 = nil
        if v1 ~= nil then
            v1()
        end
    end
    v1 = Save.Await()
    if v1 and not v1.Sakura.TutorialSeen then
        Remotes.Bloomery.AskBriefingConfirm:InvokeServer()
    end
    u373 = false
    v1 = CollectionService:GetTagged("MainSakuraTree")[1]
    if v1 and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        local Magnitude = (LocalPlayer.Character.PrimaryPart.Position - (v1:GetPivot()).Position).Magnitude
        local v2 = Save.Await()
        if Magnitude < 100 and v2 and v2.Sakura.Unlocked then
            LocalPlayer:SetAttribute("SakuraTutorialSkip", true)
            Tabs.Activate("SakuraEggCharge")
        end
    end
end)
ButtonFX(Ok)
;(CollectionService:GetInstanceAddedSignal(Sakura.TreeTag)):Connect(function(a1) -- Line: 1248
    -- upvalues: Save (val), SakuraBloomPolicy (val), u380 (val), SakuraBloomVisibility (val)
    local v1 = Save.IsLoaded()
    local v2 = not SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
    local v3 = u380[a1]
    if v3 then
        v3:Clean()
        u380[a1] = nil
    end
    if not v2 then
        return
    end
    u380[a1] = (SakuraBloomVisibility.Conceal(a1))
end)
;(CollectionService:GetInstanceRemovedSignal(Sakura.TreeTag)):Connect(function(a1) -- Line: 1251 -- upvalues: u380 (val) -- types: a1: userdata
    local v1 = u380[a1]
    if v1 then
        v1:Clean()
        u380[a1] = nil
    end
end)
;(CollectionService:GetInstanceAddedSignal(Sakura.CrystalTag)):Connect(function(a1) -- Line: 1254
    -- upvalues: Save (val), SakuraBloomPolicy (val), u380 (val), SakuraBloomVisibility (val), onCrystalAdded (val)
    local v1 = Save.IsLoaded()
    local v2 = not SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
    local v3 = u380[a1]
    if v3 then
        v3:Clean()
        u380[a1] = nil
    end
    if v2 then
        u380[a1] = (SakuraBloomVisibility.Conceal(a1))
    end
    onCrystalAdded(a1)
end)
;(CollectionService:GetInstanceRemovedSignal(Sakura.CrystalTag)):Connect(function(a1) -- Line: 787
    -- upvalues: u364 (val), u365 (val), u366 (val), u367 (val), u368 (val), u369 (val), u363 (val)
    if a1:IsA("Model") then
        u364[a1] = nil
        u365[a1] = nil
        u366[a1] = nil
        u367[a1] = nil
        u368[a1] = nil
        u369[a1] = nil
    end
    u363[a1] = nil
end)
;(CollectionService:GetInstanceRemovedSignal(Sakura.CrystalTag)):Connect(function(a1) -- Line: 1259 -- upvalues: u380 (val) -- types: a1: userdata
    local v1 = u380[a1]
    if v1 then
        v1:Clean()
        u380[a1] = nil
    end
end)
;(CollectionService:GetInstanceAddedSignal("GreatBloomVFX")):Connect(function() -- Line: 1262 -- upvalues: refreshReplicatedVisibility (val)
    task.defer(refreshReplicatedVisibility)
end)
Remotes.Bloomery.PetalsGathered.OnClientEvent:Connect(function(a1, a2) -- Line: 1266
    -- upvalues: Save (val), SakuraBloomPolicy (val), showCrystalPopup (val), SakuraFX (val), LocalPlayer (val)
    local v1 = Save.IsLoaded()
    if not SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) then
        return
    end
    showCrystalPopup(a1, a2)
    SakuraFX.EmitBurst("Pickup", a2 + Vector3.new(0, 2, 0), 14, 3)
    SakuraFX.PlayCue("CrystalPickup", LocalPlayer, 0.6, 0.95 + math.random() * 0.15)
end)
Save.WatchFields("SakuraCrystals", function() -- Line: 1275
    -- upvalues: Save (val), SakuraBloomPolicy (val), popCounter (val), setCounterShown (val), u347 (ref), u1178 (ref)
    local v1 = Save.IsLoaded()
    if SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) then
        popCounter()
        return
    end
    setCounterShown(false, 0.5)
    u347 = 0
    u1178 = false
end)
Save.WatchFields("Sakura", function() -- Line: 1206
    -- upvalues: refreshReplicatedVisibility (val), Save (val), SakuraBloomPolicy (val), u371 (ref)
    -- upvalues: startPresentation (val), stopPresentation (val)
    refreshReplicatedVisibility()
    local v1 = Save.IsLoaded()
    local v2 = if not v1 then nil else Save.Peek()
    if SakuraBloomPolicy.CanShowBloom(u371, v1, v2) then
        startPresentation()
        return
    end
    stopPresentation()
end)
Save.Loaded:Connect(function(a1) -- Line: 1283
    -- upvalues: LocalPlayer (val), refreshReplicatedVisibility (val), Save (val), SakuraBloomPolicy (val), u371 (ref)
    -- upvalues: startPresentation (val), stopPresentation (val)
    if a1 == LocalPlayer then
        refreshReplicatedVisibility()
        local v1 = Save.IsLoaded()
        local v2 = if not v1 then nil else Save.Peek()
        if SakuraBloomPolicy.CanShowBloom(u371, v1, v2) then
            startPresentation()
            return
        end
        stopPresentation()
    end
end)
SakuraSignals.ShowTutorial:Connect(function() -- Line: 1070
    -- upvalues: Save (val), SakuraBloomPolicy (val), u1091 (val), Tabs (val), u374 (ref), HiddenUIHandler (val)
    -- upvalues: SakuraFX (val), LocalPlayer (val)
    local v1 = Save.IsLoaded()
    if SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek()) and not u1091.Enabled then
        Tabs.Deactivate({instant = true})
        HiddenUIHandler.Acquire()
        u1091.Enabled = true
        SakuraFX.PlayCue("TutorialOpen", LocalPlayer, 0.8)
        return
    end
end)
refreshReplicatedVisibility()
task.spawn(function() -- Line: 1292 -- upvalues: Remotes (val), Sakura (val), u381 (val)
    local v1 = Remotes.LiveEvents.FetchRunning:InvokeServer()
    local v2 = if typeof(v1) ~= "table" then nil else v1[Sakura.EventName]
    if typeof(v2) == "number" and 0 < v2 - os.time() then
        u381:StartEvent(v2 - (os.time()))
    end
end)
return u381