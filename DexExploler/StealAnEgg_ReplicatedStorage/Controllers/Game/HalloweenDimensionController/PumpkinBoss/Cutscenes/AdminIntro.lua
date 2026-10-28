-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cutscenes.AdminIntro
-- Decompile time: 23.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
require(ReplicatedStorage.Packages.Trove)
local MoonScene = require(script.Parent.MoonScene)
require(script.Parent.Parent.Scenes)
local IntroCutscene = ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.IntroCutscene
local u33 = {"DoorLeft", "DoorRight"}
local u40 = Color3.new(0, 0, 0)
local u45 = Color3.new(1, 1, 1)
local u50 = Color3.new(1, 0.690196, 0.905882)
local u55 = Color3.new(1, 0.596078, 0.458824)

local function linear(a1, a2) -- Line: 39 -- types: a1: number, a2: number
    return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Linear)
end

local function sine(a1, a2) -- Line: 43 -- types: a1: number, a2: number
    return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
end

local function build(a1) -- Line: 47 -- upvalues: u40 (val), u50 (val), u45 (val), u55 (val)
    local SetProperty = a1.SetProperty
    local TweenProperty = a1.TweenProperty
    local Emit = a1.Emit
    local SetEmitting = a1.SetEmitting
    local Rigs = a1.Rigs
    local Vfx = a1.Vfx

    local function burst(a1) -- Line: 55 -- upvalues: Emit (val) -- types: a1: userdata
        return function() -- Line: 56 -- upvalues: Emit (upval), a1 (val)
            Emit(a1)
        end
    end

    local function emitting(a1, a2) -- Line: 61 -- upvalues: SetEmitting (val) -- types: a1: userdata, a2: boolean
        return function() -- Line: 62 -- upvalues: SetEmitting (upval), a1 (val), a2 (val)
            SetEmitting(a1, a2)
        end
    end

    local function enabled(a1, a2) -- Line: 67 -- upvalues: SetProperty (val) -- types: a1: string, a2: boolean
        return SetProperty(("Lighting.%*.Enabled"):format(a1), a2)
    end

    local v1 = {
        [0] = {
            SetProperty("Workspace.CurrentCamera.FieldOfView", 50),
            SetProperty("Lighting.CutsceneDepthOfField.Enabled", true),
            SetProperty("Lighting.CutsceneDepthOfField.FarIntensity", 0.74),
            SetProperty("Lighting.CutsceneDepthOfField.InFocusRadius", 10),
            TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(26.35, Enum.EasingStyle.Linear), 5),
            SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0),
            TweenProperty(
                "PlayerGui.CutsceneUI.Black.BackgroundTransparency",
                TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear),
                1
            ),
            SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", u40),
            SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", u40),
            SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1),
            SetProperty("Lighting.Black+White.Enabled", false),
            SetProperty("Lighting.White+Black.Enabled", false),
            SetProperty("Lighting.OrangeWhite.Enabled", false),
            SetProperty("Lighting.OrangeBlack.Enabled", false),
            SetProperty("Lighting.Moon.Enabled", false),
            SetProperty("Lighting.Moon.Saturation", 0.4),
            TweenProperty("Lighting.Moon.Saturation", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Moon.Contrast", -0.1),
            TweenProperty("Lighting.Moon.Contrast", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Moon.TintColor", u50),
            TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), u45),
            SetProperty("Lighting.Moon.Brightness", 0.1),
            TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Gray.Enabled", false),
            SetProperty("Lighting.Gray.Saturation", -0.4),
            TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Gray.Contrast", 1),
            TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Gray.TintColor", u45),
            SetProperty("Lighting.Gray.Brightness", 0.1),
            TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
            SetProperty("Workspace.PumpkinIntroVFX.PumpkinLight.Attachment.SurfaceLight.Brightness", 0),
            SetProperty("Lighting.Pumpkin.Enabled", false),
            SetProperty("Lighting.Pumpkin.Saturation", 0.1),
            TweenProperty("Lighting.Pumpkin.Saturation", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Pumpkin.Contrast", 0.1),
            TweenProperty("Lighting.Pumpkin.Contrast", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.Pumpkin.TintColor", u55),
            TweenProperty("Lighting.Pumpkin.TintColor", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), u45),
            SetProperty("Lighting.Pumpkin.Brightness", 0.2),
            TweenProperty("Lighting.Pumpkin.Brightness", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
            SetProperty("Lighting.CutsceneBlur.Enabled", true),
            SetProperty("Lighting.CutsceneBlur.Size", 15),
            SetProperty(
                "Workspace.PumpkinIntroRigs.pumpkinbossagain.Pumpkin Monster Neon.Color",
                Color3.new(0.0901961, 0.0408195, 0.0212226)
            ),
            SetProperty("Lighting.Atmosphere.Color", Color3.new(0.501961, 0.305882, 1)),
            SetProperty("Lighting.Atmosphere.Density", 0.5),
            function() -- Line: 119
                local BossPortal = game.Workspace.HalloweenDimension.BossPortal
                BossPortal.Parent = nil
                task.delay(60, function() -- Line: 123 -- upvalues: BossPortal (val)
                    BossPortal.Parent = game.Workspace.HalloweenDimension
                end)
            end,
        },
        [26] = {
            (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), 2)),
        },
        [58] = {
            (TweenProperty(
                "PlayerGui.CutsceneUI.Black.BackgroundColor3",
                TweenInfo.new(0.45, Enum.EasingStyle.Linear),
                Color3.new(0.113788, 0.0602099, 0.00981705)
            )),
        },
        [85] = {
            (TweenProperty(
                "PlayerGui.CutsceneUI.Black.BackgroundColor3",
                TweenInfo.new(11.033333333333333, Enum.EasingStyle.Linear),
                Color3.new(1, 0.529139, 0.0862745)
            )),
        },
    }
    local v2 = {}
    local PumpkinPortal = Rigs.PumpkinPortal

    v2[1] = function() -- Line: 56 -- upvalues: Emit (val), PumpkinPortal (val)
        Emit(PumpkinPortal)
    end

    v1[224] = v2
    v2 = {}
    local Bats = Vfx.Bats

    v2[1] = function() -- Line: 56 -- upvalues: Emit (val), Bats (val)
        Emit(Bats)
    end

    v1[256] = v2
    v1[274] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(1, Enum.EasingStyle.Linear), 0.1)),
    }
    v1[334] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 0.1)),
    }
    v1[361] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.8)),
    }
    local v3 = {}
    local PumpkinPortal_2 = Rigs.PumpkinPortal
    local v4 = TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear)

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), PumpkinPortal_2 (val)
        Emit(PumpkinPortal_2)
    end

    v3[2] = TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", v4, 0.6)
    v1[362] = v3
    v1[384] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), 0.2)),
    }
    v1[415] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(4.633333333333334, Enum.EasingStyle.Linear), 0.12626)),
    }
    v1[693] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 60),
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.3)),
    }
    v3 = {}
    local PumpkinPortal_3 = Rigs.PumpkinPortal
    v4 = TweenInfo.new(1.6333333333333333, Enum.EasingStyle.Linear)

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), PumpkinPortal_3 (val)
        Emit(PumpkinPortal_3)
    end

    v3[2] = TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", v4, 0.1)
    v1[694] = v3
    v1[747] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 0)),
    }
    v1[748] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 15)),
    }
    v1[780] = {
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 1)),
    }
    v3 = {}
    local PumpkinPortal_4 = Rigs.PumpkinPortal

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), PumpkinPortal_4 (val)
        Emit(PumpkinPortal_4)
    end

    v1[787] = v3
    v1[792] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
    }
    v1[817] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Linear), 2)),
    }
    v1[917] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 8)),
    }
    v1[935] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 2)),
    }
    v1[1020] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            50
        ),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 10)),
    }
    v1[1021] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 4)),
    }
    v1[1047] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 6)),
    }
    v1[1070] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7, Enum.EasingStyle.Linear), 2)),
    }
    v1[1103] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            15
        )),
    }
    v1[1106] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 0.5)),
    }
    v1[1112] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 12)),
    }
    v1[1120] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 0.51735)),
    }
    v1[1121] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 2)),
    }
    v3 = {}
    local Flip = Vfx.Flip

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Flip (val)
        Emit(Flip)
    end

    v1[1141] = v3
    v1[1149] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 7)),
    }
    v1[1162] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 2)),
    }
    v1[1183] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0)),
    }
    v1[1184] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 6)),
    }
    v3 = {}
    local Leap = Vfx.Leap

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Leap (val)
        Emit(Leap)
    end

    v1[1186] = v3
    v1[1195] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 0.00172)),
    }
    v1[1198] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            60
        ),
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2)),
    }
    v1[1289] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            50
        )),
    }
    v3 = {}
    local Hit = Vfx.Hit

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Hit (val)
        Emit(Hit)
    end

    v1[1311] = v3
    v1[1335] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 14)),
    }
    v1[1336] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    v1[1413] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 12)),
    }
    v3 = {}
    local PumpkinHit = Vfx.PumpkinHit

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), PumpkinHit (val)
        Emit(PumpkinHit)
    end

    v3[2] = enabled("OrangeWhite", true)
    v1[1414] = v3
    v1[1416] = {SetProperty("Lighting.OrangeWhite.Enabled", false), (enabled("OrangeBlack", true))}
    v1[1418] = {enabled("OrangeBlack", false)}
    v1[1419] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 2)),
    }
    v3 = {}
    local Fall = Vfx.Fall

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Fall (val)
        Emit(Fall)
    end

    v1[1476] = v3
    v1[1598] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 10)),
    }
    v1[1769] = {enabled("OrangeWhite", true)}
    v3 = {}
    local Kick1 = Vfx.Kicks.Kick1

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Kick1 (val)
        Emit(Kick1)
    end

    v1[1770] = v3
    v1[1771] = {enabled("OrangeWhite", false)}
    v3 = {}
    local Kick2 = Vfx.Kicks.Kick2

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Kick2 (val)
        Emit(Kick2)
    end

    v3[2] = enabled("OrangeWhite", true)
    v1[1810] = v3
    v1[1812] = {enabled("OrangeWhite", false)}
    v3 = {}
    local Kick3 = Vfx.Kicks.Kick3

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Kick3 (val)
        Emit(Kick3)
    end

    v3[2] = enabled("OrangeWhite", true)
    v1[1902] = v3
    v1[1904] = {SetProperty("Lighting.OrangeWhite.Enabled", false), (enabled("OrangeBlack", true))}
    v1[1906] = {enabled("OrangeBlack", false)}
    v1[1983] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    v3 = {}
    local Jump = Vfx.Jump

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Jump (val)
        Emit(Jump)
    end

    v1[1986] = v3
    v1[1990] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 2)),
    }
    v1[2126] = {enabled("OrangeWhite", true)}
    v3 = {}
    local Kick4 = Vfx.Kicks.Kick4

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Kick4 (val)
        Emit(Kick4)
    end

    v1[2127] = v3
    v1[2128] = {enabled("OrangeWhite", false)}
    v1[2185] = {
        (TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            80
        )),
    }
    v3 = {}
    local Kick5 = Vfx.Kicks.Kick5

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Kick5 (val)
        Emit(Kick5)
    end

    v1[2193] = v3
    v1[2208] = {enabled("OrangeBlack", true)}
    v1[2210] = {enabled("OrangeBlack", false)}
    v1[2211] = {enabled("OrangeWhite", true)}
    v1[2213] = {
        TweenProperty(
            "PlayerGui.CutsceneUI.Vignette.ImageColor3",
            TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear),
            Color3.new(0.377869, 1, 0.337255)
        ),
        SetProperty("Lighting.OrangeWhite.Enabled", false),
        (enabled("OrangeBlack", true)),
    }
    v1[2215] = {SetProperty("Lighting.White+Black.Enabled", true), (enabled("OrangeBlack", false))}
    v1[2217] = {SetProperty("Lighting.Black+White.Enabled", true), (enabled("White+Black", false))}
    v1[2219] = {enabled("Black+White", false)}
    v1[2222] = {enabled("OrangeBlack", true)}
    v1[2224] = {SetProperty("Lighting.OrangeWhite.Enabled", true), (enabled("OrangeBlack", false))}
    v1[2226] = {enabled("OrangeWhite", false)}
    v1[2245] = {
        TweenProperty(
            "Workspace.CurrentCamera.FieldOfView",
            TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            50
        ),
        (TweenProperty("Lighting.Atmosphere.Density", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.27)),
    }
    v1[2246] = {
        SetProperty("Lighting.Moon.Enabled", true),
        TweenProperty("Lighting.Moon.Saturation", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 0.4),
        TweenProperty("Lighting.Moon.Contrast", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), -0.1),
        TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), u50),
        (TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 0.1)),
    }
    v1[2253] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
    }
    v1[2263] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0.75)),
    }
    v1[2329] = {
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.Moon.Saturation", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Moon.Contrast", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), u45),
        (TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0)),
    }
    v1[2333] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 1)),
    }
    v1[2335] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), u40)),
    }
    v1[2345] = {
        SetProperty("Lighting.Moon.Enabled", false),
        (TweenProperty("Lighting.Atmosphere.Density", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)),
    }
    v3 = {}
    local Head = Vfx.Head

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Head (val)
        Emit(Head)
    end

    v3[2] = enabled("OrangeBlack", true)
    v1[2379] = v3
    v1[2381] = {enabled("OrangeBlack", false)}
    v1[2384] = {
        (TweenProperty(
            "Workspace.PumpkinIntroRigs.pumpkinbossagain.Pumpkin Monster Neon.Color",
            TweenInfo.new(0.2, Enum.EasingStyle.Linear),
            Color3.new(0.760784, 0.345098, 0.180392)
        )),
    }
    v3 = {}
    local Rumble = Vfx.Rumble
    local u1129 = true

    v3[1] = function() -- Line: 62 -- upvalues: SetEmitting (val), Rumble (val), u1129 (val)
        SetEmitting(Rumble, u1129)
    end

    v1[2501] = v3
    v3 = {}
    local Slam1 = Vfx.Slam1

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Slam1 (val)
        Emit(Slam1)
    end

    v1[2534] = v3
    v1[2547] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 10)),
    }
    v1[2572] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 6)),
    }
    v3 = {}
    local Slam2 = Vfx.Slam2

    v3[1] = function() -- Line: 56 -- upvalues: Emit (val), Slam2 (val)
        Emit(Slam2)
    end

    v1[2573] = v3
    v1[2595] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 8)),
    }
    v1[2621] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 3)),
    }
    v1[2650] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 7)),
    }
    v1[2677] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    v1[2703] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 20)),
    }
    v3 = {}
    local Rumble_2 = Vfx.Rumble
    local u1212 = false

    v3[1] = function() -- Line: 62 -- upvalues: SetEmitting (val), Rumble_2 (val), u1212 (val)
        SetEmitting(Rumble_2, u1212)
    end

    v1[2729] = v3
    v1[2779] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 0.2)),
    }
    v3 = {}
    local Roar = Vfx.Roar
    local u1227 = true

    v3[1] = function() -- Line: 62 -- upvalues: SetEmitting (val), Roar (val), u1227 (val)
        SetEmitting(Roar, u1227)
    end

    v1[2785] = v3
    v1[2790] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(2.3666666666666667, Enum.EasingStyle.Linear), 0.2)),
    }
    v1[2796] = {
        SetProperty("Lighting.Gray.Enabled", true),
        TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), -0.4),
        TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 1),
        (TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0.1)),
    }
    v1[2813] = {
        TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 0)),
    }
    v1[2832] = {
        TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), -0.4),
        TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 1),
        (TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0.1)),
    }
    v1[2865] = {
        TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 0)),
    }
    v1[2882] = {enabled("Gray", false)}
    v3 = {}
    local Roar_2 = Vfx.Roar
    local u1356 = false

    v3[1] = function() -- Line: 62 -- upvalues: SetEmitting (val), Roar_2 (val), u1356 (val)
        SetEmitting(Roar_2, u1356)
    end

    v1[2889] = v3
    v1[2932] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.InFocusRadius", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 10)),
    }
    v1[2933] = {
        TweenProperty(
            "Workspace.PumpkinIntroVFX.PumpkinLight.Attachment.SurfaceLight.Brightness",
            TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
            2
        ),
        SetProperty("Lighting.Pumpkin.Enabled", true),
        TweenProperty("Lighting.Pumpkin.Saturation", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.1),
        TweenProperty("Lighting.Pumpkin.Contrast", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.1),
        TweenProperty("Lighting.Pumpkin.TintColor", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), u55),
        (TweenProperty("Lighting.Pumpkin.Brightness", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.2)),
    }
    v1[2936] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), 0)),
    }
    v1[2970] = {
        SetProperty("PlayerGui.CutsceneUI.Black.BackgroundColor3", u40),
        (TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 0)),
    }
    return v1
end

return table.freeze({
    Play = function(a1) -- Line: 307
        -- upvalues: Workspace (val), HalloweenDimension (val), u33 (val), MoonScene (val), IntroCutscene (val)
        -- upvalues: build (val)
        local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        assert(v1 ~= nil, "AdminIntro plays on the Halloween dimension map, which is not open")
        local CastleGate = v1.CastleGate
        local u65 = {}
        local v2 = nil
        local v3 = nil
        for i, j in u33, v2, v3 do
            for k, n in CastleGate[j]:GetDescendants() do
                if n:IsA("BasePart") or n:IsA("Decal") then
                    table.insert(u65, n)
                end
            end
        end
        return MoonScene.Play(a1, {
            Prefix = "PumpkinIntro",
            Frames = 3000,
            CameraPart = "Head",
            HoldBlack = true,
            Assets = IntroCutscene,
            Build = build,
            Setup = function(a1) -- Line: 327 -- upvalues: u65 (val)
                for i, j in u65 do
                    j.LocalTransparencyModifier = 1
                end
                a1:Add(function() -- Line: 331 -- upvalues: u65 (upval)
                    for i, j in u65 do
                        j.LocalTransparencyModifier = 0
                    end
                end)
            end,
        })
    end,
})