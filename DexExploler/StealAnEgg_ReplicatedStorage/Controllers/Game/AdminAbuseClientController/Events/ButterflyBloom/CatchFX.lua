-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom.CatchFX
-- Decompile time: 14.65 ms

local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local GoldenButterfly = require(ReplicatedStorage.Client.Notifications.GoldenButterfly)
local Shake = require(ReplicatedStorage.Client.Shake)
local Swarm = require(script.Parent.Swarm)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local u68 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u73 = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u78 = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local CurrentCamera = Workspace.CurrentCamera
local Butterflies = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("VFX")):WaitForChild("Butterflies")
local u92 = nil
local u93 = nil
local u94 = nil
local u95 = nil
local v1 = {}

local function article(a1) -- Line: 55 -- types: a1: string
    if string.match(a1, "^[AEIOUaeiou]") then
        return "an"
    end
    return "a"
end

local function reducedMotion() -- Line: 59 -- upvalues: GuiService (val)
    return GuiService.ReducedMotionEnabled
end

local function emittersOf(a1) -- Line: 63 -- upvalues: Butterflies (val) -- types: a1: string
    local v1 = Butterflies:FindFirstChild(a1)
    if v1 == nil then
        return {}
    end
    local v2 = {}
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v2, j)
        end
    end
    return v2
end

local function emit(a1, a2, a3) -- Line: 77
    -- upvalues: VFX (val), emittersOf (val)
    VFX.EmitAt(a2, emittersOf(a1), function(a1) -- Line: 78 -- upvalues: a3 (val) -- types: a1: userdata
        if a3 and a1:GetAttribute("TierTint") == true then
            a1.Color = ColorSequence.new(a3:Lerp(Color3.new(1, 1, 1), 0.35), a3)
        end
    end)
end

local function impactGrade() -- Line: 85 -- upvalues: u92 (ref), Butterflies (val), Lighting (val)
    if u92 and u92.Parent then
        return u92
    end
    local Impact = Butterflies:FindFirstChild("Impact")
    local ColorCorrectionEffect = if not Impact then Instance.new("ColorCorrectionEffect") else if not Impact:IsA("ColorCorrectionEffect") then Instance.new("ColorCorrectionEffect") else Impact:Clone()
    ColorCorrectionEffect.Name = "ButterflyImpact"
    ColorCorrectionEffect.Enabled = true
    ColorCorrectionEffect.Brightness = 0
    ColorCorrectionEffect.Contrast = 0
    ColorCorrectionEffect.Saturation = 0
    ColorCorrectionEffect.TintColor = Color3.new(1, 1, 1)
    ColorCorrectionEffect.Parent = Lighting
    u92 = ColorCorrectionEffect
    return ColorCorrectionEffect
end

local function impactFrame(a1, a2) -- Line: 104
    -- upvalues: impactGrade (val), u93 (ref), TweenService (val), Flash (val)
    local v1 = impactGrade()
    if u93 then
        u93:Cancel()
    end
    v1.Brightness = if not a2 then 0.18 else 0.28
    v1.Contrast = if not a2 then 0.45 else 0.7
    v1.Saturation = -0.35
    v1.TintColor = (Color3.new(1, 1, 1)):Lerp(a1.Color, 0.35)
    local v2 = TweenService:Create(
        v1,
        TweenInfo.new(if not a2 then 0.22 else 0.4, Enum.EasingStyle.Quad),
        {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)}
    )
    u93 = v2
    v2:Play()
    Flash.Play({
        Attack = 0.02,
        Decay = if not a2 then 0.25 else 0.45,
        Tint = a1.Color,
        Opacity = if not a2 then 0.22 else 0.4,
    })
end

local function fovPulse(a1) -- Line: 131
    -- upvalues: GuiService (val), CurrentCamera (val), u94 (ref), u95 (ref), TweenService (val), u68 (val), u78 (val)
    -- upvalues: u73 (val)
    if not GuiService.ReducedMotionEnabled and CurrentCamera ~= nil then
        local u4 = CurrentCamera
        if u94 ~= nil then
            u94:Cancel()
        else
            u95 = u4.FieldOfView
        end
        local FieldOfView = u95
        if not FieldOfView then
            FieldOfView = u4.FieldOfView
        end
        local u33 = TweenService:Create(u4, u68, {FieldOfView = FieldOfView - (if not a1 then 7 else 12)})
        u94 = u33
        u33:Play()
        u33.Completed:Once(function(a1_2) -- Line: 147
            -- upvalues: u94 (upval), u33 (val), TweenService (upval), u4 (val), a1 (val), u78 (upval), u73 (upval)
            -- upvalues: FieldOfView (val), u95 (upval)
            if a1_2 == Enum.PlaybackState.Completed and u94 == u33 then
                local u16 = TweenService:Create(u4, if not a1 then u73 else u78, {FieldOfView = FieldOfView})
                u94 = u16
                u16:Play()
                u16.Completed:Once(function() -- Line: 156 -- upvalues: u94 (upval), u16 (val), u95 (upval)
                    if u94 == u16 then
                        u94 = nil
                        u95 = nil
                    end
                end)
                return
            end
        end)
        return
    end
end

local function popup(a1, a2, a3, a4) -- Line: 165
    -- upvalues: Butterflies (val), Workspace (val), TweenService (val), VFX (val)
    local Popup = Butterflies:FindFirstChild("Popup")
    if Popup ~= nil and Popup:IsA("BillboardGui") then
        local Part = Instance.new("Part")
        Part.Name = "ButterflyPopup"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Transparency = 1
        Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        Part.CFrame = CFrame.new(a1)
        Part.Parent = Workspace
        local v1 = Popup:Clone()
        v1.Adornee = Part
        v1.Parent = Part
        local v2 = v1:FindFirstChild("Label", true)
        if v2 and v2:IsA("TextLabel") then
            v2.Text = a2
            v2.TextColor3 = a3
            local UIStroke = v2:FindFirstChildOfClass("UIStroke")
            if UIStroke then
                UIStroke.Color = a4
            end
            v2.TextTransparency = 0
            TweenService:Create(
                v2,
                TweenInfo.new(0.36000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.54),
                {TextTransparency = 1}
            ):Play()
            if UIStroke then
                TweenService:Create(
                    UIStroke,
                    TweenInfo.new(0.36000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.54),
                    {Transparency = 1}
                ):Play()
            end
        end
        v2 = v1:FindFirstChildOfClass("UIScale")
        if v2 == nil then
            local GuiObject = v1:FindFirstChildWhichIsA("GuiObject")
            v2 = GuiObject and GuiObject:FindFirstChildOfClass("UIScale")
        end
        if v2 then
            v2.Scale = 0.4
            TweenService:Create(v2, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
        TweenService:Create(
            Part,
            TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {CFrame = CFrame.new(a1 + Vector3.new(0, 3.5, 0))}
        ):Play()
        VFX.Discard(Part, 1)
        return
    end
end

local function flashWhite(a1) -- Line: 248 -- upvalues: TweenService (val), VFX (val)
    local HitFlash = a1.Model:FindFirstChild("HitFlash")
    if HitFlash then
        HitFlash:Destroy()
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "HitFlash"
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 0.1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = a1.Model
    Highlight.Parent = a1.Model
    TweenService:Create(Highlight, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {FillTransparency = 1}):Play()
    VFX.Discard(Highlight, 0.16999999999999998)
end

local function chaseGlow(a1, a2) -- Line: 267 -- upvalues: TweenService (val), VFX (val)
    local ChaseGlow = a1.Model:FindFirstChild("ChaseGlow")
    if ChaseGlow then
        ChaseGlow:Destroy()
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ChaseGlow"
    Highlight.FillColor = a2.Color
    Highlight.FillTransparency = 0.55
    Highlight.OutlineColor = a2.Color:Lerp(Color3.new(1, 1, 1), 0.5)
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Adornee = a1.Model
    Highlight.Parent = a1.Model
    TweenService:Create(
        Highlight,
        TweenInfo.new(2.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {FillTransparency = 1, OutlineTransparency = 1}
    ):Play()
    VFX.Discard(Highlight, 2.65)
end

local function suckInto(a1, a2) -- Line: 289 -- types: a2: vector?
    local Model = a1.Model
    local Position = a1.Position
    local u6 = a2
    if not u6 then
        u6 = Position + Vector3.new(0, -1, 0)
    end
    local u8 = os.clock()
    local Scale = Model:GetScale()
    task.spawn(function() -- Line: 295 -- upvalues: Model (val), u8 (val), Scale (val), Position (val), u6 (val)
        local v1, v2
        while Model.Parent do
            v1 = math.clamp((os.clock() - u8) / 0.18, 0, 1)
            v2 = v1 * v1
            Model:ScaleTo((math.max(0.05, Scale * (1 - v2 * 0.95))))
            Model:PivotTo((CFrame.new(Position:Lerp(u6, v2))) * (CFrame.Angles(0, v1 * 3.141592653589793 * 3, 0)))
            if v1 >= 1 then
                break
            end
            task.wait()
        end
        Model:Destroy()
    end)
end

function v1.Swing(a1) -- Line: 316 -- upvalues: Audio (val), ButterflyCatalog (val) -- types: a1: userdata
    Audio.Play(ButterflyCatalog.Sounds.Swing, a1, {Volume = 0.55, MaxDistance = 60, PlaybackSpeed = {0.92, 1.12}})
end

function v1.Contact(a1) -- Line: 324 -- upvalues: Swarm (val), flashWhite (val)
    Swarm.Hold(a1.Flight.Id, 0.08)
    flashWhite(a1)
end

function v1.Snag(a1, a2, a3, a4) -- Line: 329
    -- upvalues: ButterflyCatalog (val), Audio (val), GuiService (val), Shake (val), flashWhite (val), chaseGlow (val)
    -- upvalues: Swarm (val)
    local v1 = ButterflyCatalog.Get(a2)
    Audio.Play(ButterflyCatalog.Sounds.Snag, a3 or script, {Volume = 0.7, MaxDistance = 60, PlaybackSpeed = {0.97, 1.05}})
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({Magnitude = 0.12, Shape = "Fade", Seconds = ButterflyCatalog.SnagSeconds + 0.04})
    end
    if a1 == nil then
        return
    end
    flashWhite(a1)
    chaseGlow(a1, v1)
    if a4 and a3 ~= nil then
        Swarm.PlayTrack(a1, "Struggle", 1)
        local Model = a1.Model
        local u55 = os.clock()
        task.spawn(function() -- Line: 359 -- upvalues: Model (val), u55 (val), ButterflyCatalog (upval), a1 (val), a3 (val)
            while Model.Parent do
                if not (os.clock() - u55 < ButterflyCatalog.SnagSeconds) then
                    break
                end
                a1.Position = a3.Position
                Model:PivotTo((CFrame.lookAt(a3.Position, a3.Position + a1.Heading)))
                task.wait()
            end
        end)
        return
    end
end

function v1.Caught(a1, a2, a3, a4, a5) -- Line: 368
    -- upvalues: ButterflyCatalog (val), impactFrame (val), fovPulse (val), GuiService (val), Shake (val), Audio (val)
    -- upvalues: VFX (val), emittersOf (val), suckInto (val), popup (val), Toast (val)
    local v1 = ButterflyCatalog.Get(a2)
    local v2 = a2 == "Golden"
    local Position = if not a1 then if not a5 then Vector3.new(0, 0, 0) else a5.Position else a1.Position
    if a4 and a4.IsPlaying then
        a4:AdjustSpeed(0)
        task.delay(if not v2 then 0.07 else 0.16, function() -- Line: 382 -- upvalues: a4 (val)
            if a4.IsPlaying then
                a4:AdjustSpeed(1)
            end
        end)
    end
    impactFrame(v1, v2)
    fovPulse(v2)
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({
            Shape = "Fade",
            Seconds = if not v2 then 0.22 else 0.45,
            Magnitude = if not v2 then 0.35 else 0.9,
        })
    end
    Audio.Play(v1.CatchSound, script, {Volume = if not v2 then 0.75 else 0.95})
    local Color = v1.Color
    VFX.EmitAt(Position, emittersOf("Catch"), function(a1) -- Line: 78 -- upvalues: Color (val) -- types: a1: userdata
        if Color and a1:GetAttribute("TierTint") == true then
            a1.Color = ColorSequence.new(Color:Lerp(Color3.new(1, 1, 1), 0.35), Color)
        end
    end)
    if v2 then
        local Color_2 = v1.Color
        VFX.EmitAt(Position, emittersOf("CatchGolden"), function(a1) -- Line: 78 -- upvalues: Color_2 (val) -- types: a1: userdata
            if Color_2 and a1:GetAttribute("TierTint") == true then
                a1.Color = ColorSequence.new(Color_2:Lerp(Color3.new(1, 1, 1), 0.35), Color_2)
            end
        end)
    end
    if a1 then
        suckInto(a1, if not a5 then nil else a5.Position)
    end
    popup(Position + Vector3.new(0, 1.2000000476837158, 0), ("+1 %*"):format(v1.DisplayName), v1.Color, v1.StrokeColor)
    Toast.Show({
        ShowShadow = true,
        Lane = if not v2 then "Feed" else "Banner",
        Text = ("Caught %* %*!%*"):format(
            if not string.match(v1.DisplayName, "^[AEIOUaeiou]") then "a" else "an",
            v1.DisplayName,
            if not a3 then "" else (" (%* owned)"):format(a3)
        ),
        Seconds = if not v2 then 2.5 else 4,
        Color = v1.Color,
        StrokeColor = v1.StrokeColor,
        Image = v1.Icon,
    })
end

function v1.Escaped(a1, a2) -- Line: 418
    -- upvalues: ButterflyCatalog (val), flashWhite (val), chaseGlow (val), Audio (val), VFX (val), emittersOf (val)
    -- upvalues: popup (val), GuiService (val), Shake (val)
    local v1 = ButterflyCatalog.Get(a2)
    local Position = if not a1 then nil else a1.Position
    if a1 then
        flashWhite(a1)
        chaseGlow(a1, v1)
    end
    Audio.Play(
        ButterflyCatalog.Sounds.Escape,
        if not Position then script else Position,
        {Volume = 0.6, MaxDistance = 80, PlaybackSpeed = {0.95, 1.1}}
    )
    if Position then
        local Color = v1.Color
        VFX.EmitAt(Position, emittersOf("Escape"), function(a1) -- Line: 78 -- upvalues: Color (val) -- types: a1: userdata
            if Color and a1:GetAttribute("TierTint") == true then
                a1.Color = ColorSequence.new(Color:Lerp(Color3.new(1, 1, 1), 0.35), Color)
            end
        end)
        popup(Position + Vector3.new(0, 1.2000000476837158, 0), "Escaped!", Color3.new(1, 1, 1), v1.StrokeColor)
    end
    if not GuiService.ReducedMotionEnabled then
        Shake.Play({Seconds = 0.12, Magnitude = 0.15, Shape = "Fade"})
    end
end

function v1.Announce(a1) -- Line: 439
    -- upvalues: Audio (val), ButterflyCatalog (val), Toast (val), GoldenButterfly (val)
    if a1 == "Start" then
        Audio.Play(ButterflyCatalog.Sounds.BloomStart, script, {Volume = 0.8})
        Toast.Show({
            Lane = "Banner",
            Text = "THE BUTTERFLY BLOOM HAS BEGUN!\nGrab your net and catch butterflies in the Enchanted Forest!",
            Seconds = 5,
            ShowShadow = true,
            Color = Color3.fromRGB(255, 180, 255),
            StrokeColor = Color3.fromRGB(80, 20, 90),
            Image = ButterflyCatalog.Tiers.Blue.Icon,
            Size = UDim2.fromScale(1.5, 0.45),
        })
        return
    end
    if a1 == "Golden" then
        GoldenButterfly.Show()
        return
    end
    if a1 == "Ending" then
        Toast.Show({
            Lane = "Feed",
            Text = "The butterflies are leaving in 30 seconds!",
            Seconds = 3,
            Color = Color3.fromRGB(255, 200, 255),
        })
        return
    end
    if a1 == "End" then
        Toast.Show({
            Lane = "Feed",
            Text = "The Butterfly Bloom has ended",
            Seconds = 3,
            Color = Color3.fromRGB(255, 200, 255),
        })
    end
end

return v1