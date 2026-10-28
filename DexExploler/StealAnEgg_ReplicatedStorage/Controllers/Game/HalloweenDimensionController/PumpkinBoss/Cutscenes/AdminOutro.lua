-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cutscenes.AdminOutro
-- Decompile time: 7.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local MoonScene = require(script.Parent.MoonScene)
require(script.Parent.Parent.Scenes)
local OutroCutscene = ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.OutroCutscene

local function linear(a1, a2) -- Line: 35 -- types: a1: number, a2: number
    return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Linear)
end

local function fadeBeam(a1, a2) -- Line: 39 -- upvalues: TweenService (val) -- types: a1: userdata, a2: number
    local Transparency = a1.Transparency
    local Width0 = a1.Width0
    local Width1 = a1.Width1
    local v1 = a2 * 0.2
    local v2 = a2 * 0.4
    local v3 = a2 * 0.75

    local function setFade(a1_2) -- Line: 47 -- upvalues: Transparency (val), a1 (val) -- types: a1_2: number
        local Time, new, v1
        local v2 = {}
        for i, j in Transparency.Keypoints do
            new = NumberSequenceKeypoint.new
            Time = j.Time
            v1 = j.Value + (1 - j.Value) * a1_2
            v2[i] = (new(Time, v1, j.Envelope))
        end
        a1.Transparency = NumberSequence.new(v2)
    end

    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = 1
    setFade(1)
    local u20 = NumberValue.Changed:Connect(setFade)
    a1.Enabled = true
    local u33 = TweenService:Create(NumberValue, TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 0})
    local u45 = TweenService:Create(NumberValue, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Value = 1})
    local u56 = TweenService:Create(a1, TweenInfo.new(a2 - v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Width0 = 0, Width1 = 0})
    u33:Play()
    task.delay(a2 - v2, function() -- Line: 73 -- upvalues: u45 (val)
        u45:Play()
    end)
    task.delay(v3, function() -- Line: 76 -- upvalues: u56 (val)
        u56:Play()
    end)
    task.delay(a2, function() -- Line: 79
        -- upvalues: u33 (val), u45 (val), u56 (val), u20 (val), NumberValue (val), a1 (val), Transparency (val)
        -- upvalues: Width0 (val), Width1 (val)
        u33:Cancel()
        u45:Cancel()
        u56:Cancel()
        u20:Disconnect()
        NumberValue:Destroy()
        a1.Enabled = false
        a1.Transparency = Transparency
        a1.Width0 = Width0
        a1.Width1 = Width1
    end)
end

local function slash(a1) -- Line: 93 -- upvalues: fadeBeam (val) -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Beam") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 102 -- upvalues: j (val), Attribute (val), Attribute_2 (val), fadeBeam (upval)
                if not j:IsA("ParticleEmitter") then
                    if j:IsA("Beam") and type(Attribute_2) == "number" and Attribute_2 > 0 then
                        fadeBeam(j, Attribute_2)
                    end
                    return
                end
                if type(Attribute) == "number" and Attribute > 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 > 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 109 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                    return
                end
            end)
        end
    end
end

local function build(a1) -- Line: 120 -- upvalues: slash (val)
    local SetProperty = a1.SetProperty
    local TweenProperty = a1.TweenProperty
    local Emit = a1.Emit
    local SetEmitting = a1.SetEmitting
    local Vfx = a1.Vfx
    local Set = a1.Set
    local v1 = {
        [0] = {
            SetProperty("Workspace.CurrentCamera.FieldOfView", 35),
            SetProperty("Lighting.CutsceneBlur.Enabled", true),
            SetProperty("Lighting.CutsceneBlur.Size", 2),
            SetProperty("Lighting.CutsceneDepthOfField.Enabled", true),
            SetProperty("Lighting.CutsceneDepthOfField.InFocusRadius", 25),
            (SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 1)),
        },
        [14] = {
            (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine), 45)),
        },
        [63] = {
            function() -- Line: 139 -- upvalues: SetEmitting (val), Vfx (val)
                SetEmitting(Vfx.Rumble, true)
            end,
        },
        [78] = {
            (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(4.216666666666667, Enum.EasingStyle.Sine), 55)),
        },
        [84] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 15)),
        },
        [94] = {
            function() -- Line: 146 -- upvalues: Emit (val), Vfx (val)
                Emit(Vfx.Slam1)
            end,
        },
        [95] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 4)),
        },
        [234] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 10)),
        },
        [240] = {
            function() -- Line: 153 -- upvalues: slash (upval), Vfx (val)
                slash(Vfx.Slash)
            end,
        },
        [243] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 4)),
        },
        [283] = {
            function() -- Line: 159 -- upvalues: SetEmitting (val), Vfx (val)
                SetEmitting(Vfx.Rumble, false)
            end,
        },
        [331] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2)),
        },
        [332] = {
            (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Back), 35)),
        },
        [443] = {
            function() -- Line: 166 -- upvalues: Emit (val), Vfx (val)
                Emit(Vfx.Highfive)
            end,
        },
        [556] = {
            TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 13),
            (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 5)),
        },
    }
    local v2 = {}
    local v3 = TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear)

    v2[1] = function() -- Line: 175 -- upvalues: Emit (val), Set (val)
        Emit(Set.PumpkinPortal)
    end

    v2[2] = TweenProperty("Lighting.CutsceneBlur.Size", v3, 2)
    v1[557] = v2
    v1[564] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 25)),
    }
    v1[842] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 5)),
    }
    v1[915] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 25)),
    }
    v1[961] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 0)),
    }
    return v1
end

return table.freeze({
    Play = function(self) -- Line: 187 -- upvalues: PumpkinBossState (val), MoonScene (val), OutroCutscene (val), build (val)
        local Attribute = self.Arena:GetAttribute(PumpkinBossState.Attributes.Center)
        local v1 = false
        if typeof(Attribute) == "Vector3" then
            v1 = (Attribute - Vector3.new(-133552.140625, 476.239990234375, 980.7000122070312)).Magnitude < 0.5
        end
        assert(v1, "AdminOutro assets were baked for another arena position; re-bake them")
        return MoonScene.Play(self, {
            Prefix = "PumpkinOutro",
            Frames = 1044,
            CameraPart = "Cam",
            HoldBlack = true,
            Assets = OutroCutscene,
            Build = build,
        })
    end,
})