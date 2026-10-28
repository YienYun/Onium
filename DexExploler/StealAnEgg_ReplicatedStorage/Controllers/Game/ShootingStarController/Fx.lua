-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.Fx
-- Decompile time: 6.26 ms

local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local u48 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u49 = nil
local u50 = nil
local u51 = nil
local u52 = nil
local u53 = {}

function u53.Kit() -- Line: 33 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    if Assets then
        return (Assets:FindFirstChild("ShootingStar"))
    end
    return nil
end

function u53.KitReady() -- Line: 38 -- upvalues: u53 (val)
    local v1 = u53.Kit()
    local v2 = false
    if v1 ~= nil then
        v2 = false
        if v1:FindFirstChild("Meteor") ~= nil then
            v2 = v1:FindFirstChild("FallingStar") ~= nil
        end
    end
    return v2
end

function u53.ReducedMotion() -- Line: 45 -- upvalues: GuiService (val)
    return GuiService.ReducedMotionEnabled
end

function u53.Sound(a1, a2, a3, a4) -- Line: 49
    -- upvalues: u53 (val), Audio (val)
    local v1 = u53.Kit()
    local Sounds = v1 and v1:FindFirstChild("Sounds")
    v1 = Sounds and Sounds:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Sound") then
        return Audio.Play(v1, a2 or script, {
            Volume = a3 or v1.Volume,
            PlaybackSpeed = a4 or v1.PlaybackSpeed,
            MaxDistance = if not a2 then nil else v1.RollOffMaxDistance,
        })
    end
    return nil
end

function u53.Emit(a1, a2, a3) -- Line: 63 -- upvalues: u53 (val), VFX (val) -- types: a1: string, a3: number?
    local v1 = u53.Kit()
    local Vfx = v1 and v1:FindFirstChild("Vfx")
    v1 = Vfx and Vfx:FindFirstChild(a1)
    if v1 == nil then
        return
    end
    local v2 = {}
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v2, j)
        end
    end
    VFX.EmitAt(a2, v2, function(a1) -- Line: 76 -- upvalues: a3 (val), VFX (upval) -- types: a1: userdata
        if a3 and a3 ~= 1 then
            VFX.Rescale(a1, a3)
        end
    end)
end

function u53.Flash(a1, a2, a3) -- Line: 83 -- upvalues: Flash (val) -- types: a1: userdata, a2: number, a3: number?
    Flash.Play({Attack = 0.02, Decay = a3 or 0.3, Tint = a1, Opacity = a2})
end

function u53.Dip(a1, a2) -- Line: 87 -- upvalues: Flash (val) -- types: a1: number, a2: number?
    Flash.Play({Opacity = 1, Attack = a1, Decay = a2 or a1, Tint = Color3.new(0, 0, 0)})
end

function u53.Grade(a1, a2, a3) -- Line: 96
    -- upvalues: u49 (ref), Lighting (val), u50 (ref), TweenService (val)
    if u49 == nil or u49.Parent == nil then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        ColorCorrectionEffect.Name = "ShootingStarImpact"
        ColorCorrectionEffect.Parent = Lighting
        u49 = ColorCorrectionEffect
    end
    local v1 = u49
    if u50 then
        u50:Cancel()
    end
    v1.Brightness = a2 * 0.25
    v1.Contrast = a2 * 0.6
    v1.Saturation = a2 * -0.3
    v1.TintColor = (Color3.new(1, 1, 1)):Lerp(a1, 0.4)
    local v2 = TweenService:Create(
        v1,
        TweenInfo.new(a3, Enum.EasingStyle.Quad),
        {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)}
    )
    u50 = v2
    v2:Play()
end

function u53.FovPunch(a1, a2) -- Line: 120
    -- upvalues: Workspace (val), u53 (val), u51 (ref), u52 (ref), TweenService (val), u48 (val)
    local CurrentCamera = Workspace.CurrentCamera
    if not u53.ReducedMotion() and CurrentCamera ~= nil then
        if u51 ~= nil then
            u51:Cancel()
        else
            u52 = CurrentCamera.FieldOfView
        end
        local FieldOfView = u52
        if not FieldOfView then
            FieldOfView = CurrentCamera.FieldOfView
        end
        local u27 = TweenService:Create(CurrentCamera, u48, {FieldOfView = FieldOfView - a1})
        u51 = u27
        u27:Play()
        u27.Completed:Once(function(a1) -- Line: 134
            -- upvalues: u51 (upval), u27 (val), TweenService (upval), CurrentCamera (val), a2 (val), FieldOfView (val)
            -- upvalues: u52 (upval)
            if a1 == Enum.PlaybackState.Completed and u51 == u27 then
                local u15 = TweenService:Create(
                    CurrentCamera,
                    TweenInfo.new(a2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {FieldOfView = FieldOfView}
                )
                u51 = u15
                u15:Play()
                u15.Completed:Once(function() -- Line: 145 -- upvalues: u51 (upval), u15 (val), u52 (upval)
                    if u51 == u15 then
                        u51 = nil
                        u52 = nil
                    end
                end)
                return
            end
        end)
        return
    end
end

function u53.Shake(a1, a2, a3) -- Line: 154
    -- upvalues: u53 (val), Shake (val)
    if u53.ReducedMotion() then
        a2 = a2 * 0.3
    end
    Shake.Play({
        Shape = "Fade",
        Rumble = true,
        Seconds = a1,
        Magnitude = a2,
        Range = if not a3 then nil else {Near = 40, Far = 260, Center = a3},
    })
end

function u53.HitFlash(a1, a2) -- Line: 167 -- upvalues: TweenService (val), VFX (val) -- types: a1: userdata, a2: number
    local HitFlash = a1:FindFirstChild("HitFlash")
    if HitFlash then
        HitFlash:Destroy()
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "HitFlash"
    Highlight.FillColor = Color3.new(1, 1, 1)
    Highlight.FillTransparency = 0.05
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = a1
    Highlight.Parent = a1
    TweenService:Create(Highlight, TweenInfo.new(a2, Enum.EasingStyle.Quad), {FillTransparency = 1}):Play()
    VFX.Discard(Highlight, a2 + 0.05)
end

return u53