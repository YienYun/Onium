-- Script path: ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.IntroCutscene.OriginalSequence
-- Decompile time: 29.89 ms

local v1 = {
    [0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(60.7566, 55.578, -22.9851, -0.9307, -0.1829, 0.3168, -0, 0.866, 0.5, -0.3658, 0.4653, -0.806)
        ),
        SetProperty("Workspace.CurrentCamera.AttachToPart", Head),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 50),
        SetProperty("Lighting.DepthOfField.Enabled", true),
        SetProperty("Lighting.DepthOfField.FarIntensity", 0.74),
        SetProperty("Lighting.DepthOfField.InFocusRadius", 10),
        TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(26.35, Enum.EasingStyle.Linear), 5),
        SetProperty("CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency", 0),
        TweenProperty(
            "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency",
            TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear),
            1
        ),
        SetProperty("CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundColor3", Color3.new(0, 0, 0)),
        SetProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageColor3", Color3.new(0, 0, 0)),
        SetProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", 1),
        SetProperty("Lighting.Black+White.Enabled", false),
        SetProperty("Lighting.White+Black.Enabled", false),
        SetProperty("Lighting.OrangeWhite.Enabled", false),
        SetProperty("Lighting.OrangeBlack.Enabled", false),
        SetProperty("Lighting.Moon.Enabled", false),
        SetProperty("Lighting.Moon.Saturation", 0.4),
        TweenProperty("Lighting.Moon.Saturation", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Moon.Contrast", -0.1),
        TweenProperty("Lighting.Moon.Contrast", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Moon.TintColor", Color3.new(1, 0.690196, 0.905882)),
        TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        SetProperty("Lighting.Moon.Brightness", 0.1),
        TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(37.43333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Gray.Enabled", false),
        SetProperty("Lighting.Gray.Saturation", -0.4),
        TweenProperty("Lighting.Gray.Saturation", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Gray.Contrast", 1),
        TweenProperty("Lighting.Gray.Contrast", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Gray.TintColor", Color3.new(1, 1, 1)),
        SetProperty("Lighting.Gray.Brightness", 0.1),
        TweenProperty("Lighting.Gray.Brightness", TweenInfo.new(46.6, Enum.EasingStyle.Linear), 0),
        SetProperty("Workspace.VFX.PumpkinLight.Attachment.SurfaceLight.Brightness", 0),
        SetProperty("Lighting.Pumpkin.Enabled", false),
        SetProperty("Lighting.Pumpkin.Saturation", 0.1),
        TweenProperty("Lighting.Pumpkin.Saturation", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Pumpkin.Contrast", 0.1),
        TweenProperty("Lighting.Pumpkin.Contrast", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Pumpkin.TintColor", Color3.new(1, 0.596078, 0.458824)),
        TweenProperty("Lighting.Pumpkin.TintColor", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
        SetProperty("Lighting.Pumpkin.Brightness", 0.2),
        TweenProperty("Lighting.Pumpkin.Brightness", TweenInfo.new(48.88333333333333, Enum.EasingStyle.Linear), 0),
        SetProperty("Lighting.Blur.Enabled", true),
        SetProperty("Lighting.Blur.Size", 15),
        SetProperty("Workspace.Animatables.pumpkinbossagain.Pumpkin Monster Neon.Color", Color3.new(0.0901961, 0.0408195, 0.0212226)),
        SetProperty("Lighting.Atmosphere.Color", Color3.new(0.501961, 0.305882, 1)),
        (SetProperty("Lighting.Atmosphere.Density", 0.5)),
    },
    [26] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), 2)),
    },
    [58] = {
        (TweenProperty(
            "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundColor3",
            TweenInfo.new(0.45, Enum.EasingStyle.Linear),
            Color3.new(0.113788, 0.0602099, 0.00981705)
        )),
    },
    [85] = {
        (TweenProperty(
            "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundColor3",
            TweenInfo.new(11.033333333333333, Enum.EasingStyle.Linear),
            Color3.new(1, 0.529139, 0.0862745)
        )),
    },
    [224] = {
        function() -- Line: 68
            local Attribute, Attribute_2
            local PumpkinPortal = workspace.Animatables.PumpkinPortal

            function check(a1) -- Line: 71 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(PumpkinPortal:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    Attribute = v:GetAttribute("EmitCount")
                    Attribute_2 = v:GetAttribute("EmitDuration")
                    if check(Attribute) then
                        v:Emit(Attribute)
                    end
                    if check(Attribute_2) then
                        v.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 86 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    },
    [256] = {
        function() -- Line: 95
            local Attribute, Attribute_2
            local Bats = workspace.VFX.Bats

            function check(a1) -- Line: 98 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Bats:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    Attribute = v:GetAttribute("EmitCount")
                    Attribute_2 = v:GetAttribute("EmitDuration")
                    if check(Attribute) then
                        v:Emit(Attribute)
                    end
                    if check(Attribute_2) then
                        v.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 113 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    },
    [274] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(1, Enum.EasingStyle.Linear), 0.1)),
    },
    [334] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 0.1)),
    },
    [361] = {
        (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.8)),
    },
}
local v2 = {}
local v3 = TweenProperty
local v4 = TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear)

v2[1] = function() -- Line: 134
    local Attribute, Attribute_2
    local PumpkinPortal = workspace.Animatables.PumpkinPortal

    function check(a1) -- Line: 137 -- types: a1: number?
        local v1 = false
        if a1 ~= nil then
            v1 = a1 ~= 0
        end
        return v1
    end

    for k, v in pairs(PumpkinPortal:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            Attribute = v:GetAttribute("EmitCount")
            Attribute_2 = v:GetAttribute("EmitDuration")
            if check(Attribute) then
                v:Emit(Attribute)
            end
            if check(Attribute_2) then
                v.Enabled = true
                task.delay(Attribute_2, function() -- Line: 152 -- upvalues: v (val)
                    v.Enabled = false
                end)
            end
        end
    end
end

v2[2] = v3("Lighting.DepthOfField.FarIntensity", v4, 0.6)
v1[362] = v2
v1[384] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), 0.2)),
}
v1[415] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(4.633333333333334, Enum.EasingStyle.Linear), 0.12626)),
}
v1[693] = {
    TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 60),
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.3)),
}
v2 = {}
v3 = TweenProperty
v4 = TweenInfo.new(1.6333333333333333, Enum.EasingStyle.Linear)

v2[1] = function() -- Line: 175
    local Attribute, Attribute_2
    local PumpkinPortal = workspace.Animatables.PumpkinPortal

    function check(a1) -- Line: 178 -- types: a1: number?
        local v1 = false
        if a1 ~= nil then
            v1 = a1 ~= 0
        end
        return v1
    end

    for k, v in pairs(PumpkinPortal:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            Attribute = v:GetAttribute("EmitCount")
            Attribute_2 = v:GetAttribute("EmitDuration")
            if check(Attribute) then
                v:Emit(Attribute)
            end
            if check(Attribute_2) then
                v.Enabled = true
                task.delay(Attribute_2, function() -- Line: 193 -- upvalues: v (val)
                    v.Enabled = false
                end)
            end
        end
    end
end

v2[2] = v3("Lighting.DepthOfField.FarIntensity", v4, 0.1)
v1[694] = v2
v1[747] = {
    (TweenProperty(
        "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency",
        TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear),
        0
    )),
}
v1[748] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 15)),
}
v1[780] = {
    (TweenProperty(
        "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency",
        TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
        1
    )),
}
v1[787] = {
    function() -- Line: 215
        local Attribute, Attribute_2
        local PumpkinPortal = workspace.Animatables.PumpkinPortal

        function check(a1) -- Line: 218 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(PumpkinPortal:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 233 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[792] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)),
}
v1[817] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Linear), 2)),
}
v1[917] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 8)),
}
v1[935] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 2)),
}
v1[1020] = {
    TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        50
    ),
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 10)),
}
v1[1021] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 4)),
}
v1[1047] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 6)),
}
v1[1070] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.7, Enum.EasingStyle.Linear), 2)),
}
v1[1103] = {
    (TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        15
    )),
}
v1[1106] = {
    (TweenProperty(
        "CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency",
        TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear),
        0.5
    )),
}
v1[1112] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 12)),
}
v1[1120] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 0.51735)),
}
v1[1121] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 2)),
}
v1[1141] = {
    function() -- Line: 295
        local Attribute, Attribute_2
        local Flip = workspace.VFX.Flip

        function check(a1) -- Line: 298 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Flip:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 313 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1149] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 7)),
}
v1[1162] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 2)),
}
v1[1183] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0)),
}
v1[1184] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 6)),
}
v1[1186] = {
    function() -- Line: 338
        local Attribute, Attribute_2
        local Leap = workspace.VFX.Leap

        function check(a1) -- Line: 341 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Leap:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 356 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1195] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 0.00172)),
}
v1[1198] = {
    TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        60
    ),
    TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1),
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2)),
}
v1[1289] = {
    (TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        50
    )),
}
v1[1311] = {
    function() -- Line: 379
        local Attribute, Attribute_2
        local Hit = workspace.VFX.Hit

        function check(a1) -- Line: 382 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Hit:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 397 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1335] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 14)),
}
v1[1336] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 2)),
}
v1[1413] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 12)),
}
v1[1414] = {
    function() -- Line: 418
        local Attribute, Attribute_2
        local PumpkinHit = workspace.VFX.PumpkinHit

        function check(a1) -- Line: 421 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(PumpkinHit:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 436 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
    SetProperty("Lighting.OrangeWhite.Enabled", true),
}
v1[1416] = {
    SetProperty("Lighting.OrangeWhite.Enabled", false),
    (SetProperty("Lighting.OrangeBlack.Enabled", true)),
}
v1[1418] = {SetProperty("Lighting.OrangeBlack.Enabled", false)}
v1[1419] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Linear), 2)),
}
v1[1476] = {
    function() -- Line: 459
        local Attribute, Attribute_2
        local Fall = workspace.VFX.Fall

        function check(a1) -- Line: 462 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Fall:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 477 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1598] = {
    (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 10)),
}
v1[1769] = {SetProperty("Lighting.OrangeWhite.Enabled", true)}
v1[1770] = {
    function() -- Line: 494
        local Attribute, Attribute_2
        local Kick1 = workspace.VFX.Kicks.Kick1

        function check(a1) -- Line: 497 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Kick1:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 512 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1771] = {SetProperty("Lighting.OrangeWhite.Enabled", false)}
v1[1810] = {
    function() -- Line: 525
        local Attribute, Attribute_2
        local Kick2 = workspace.VFX.Kicks.Kick2

        function check(a1) -- Line: 528 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Kick2:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 543 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
    SetProperty("Lighting.OrangeWhite.Enabled", true),
}
v1[1812] = {SetProperty("Lighting.OrangeWhite.Enabled", false)}
v1[1902] = {
    function() -- Line: 557
        local Attribute, Attribute_2
        local Kick3 = workspace.VFX.Kicks.Kick3

        function check(a1) -- Line: 560 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Kick3:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 575 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
    SetProperty("Lighting.OrangeWhite.Enabled", true),
}
v1[1904] = {
    SetProperty("Lighting.OrangeWhite.Enabled", false),
    (SetProperty("Lighting.OrangeBlack.Enabled", true)),
}
v1[1906] = {SetProperty("Lighting.OrangeBlack.Enabled", false)}
v1[1983] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 10)),
}
v1[1986] = {
    function() -- Line: 598
        local Attribute, Attribute_2
        local Jump = workspace.VFX.Jump

        function check(a1) -- Line: 601 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Jump:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 616 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[1990] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), 2)),
}
v1[2126] = {SetProperty("Lighting.OrangeWhite.Enabled", true)}
v1[2127] = {
    function() -- Line: 633
        local Attribute, Attribute_2
        local Kick4 = workspace.VFX.Kicks.Kick4

        function check(a1) -- Line: 636 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Kick4:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 651 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[2128] = {SetProperty("Lighting.OrangeWhite.Enabled", false)}
v1[2185] = {
    (TweenProperty(
        "Workspace.CurrentCamera.FieldOfView",
        TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        80
    )),
}
v1[2193] = {
    function() -- Line: 668
        local Attribute, v1

        local function check(a1) -- Line: 671
            local v1 = false
            if typeof(a1) == "number" then
                v1 = a1 > 0
            end
            return v1
        end

        local function play(a1) -- Line: 675 -- types: a1: userdata
            local Attribute = a1:GetAttribute("EmitCount")
            local Attribute_2 = a1:GetAttribute("EmitDuration")
            local v1 = false
            if typeof(Attribute) == "number" then
                v1 = Attribute > 0
            end
            if v1 then
                a1:Emit(Attribute)
            end
            v1 = false
            if typeof(Attribute_2) == "number" then
                v1 = Attribute_2 > 0
            end
            if v1 then
                a1.Enabled = true
                task.delay(Attribute_2, function() -- Line: 685 -- upvalues: a1 (val)
                    a1.Enabled = false
                end)
            end
        end

        for i, j in workspace.VFX.Kicks.Kick5:GetDescendants() do
            if j:IsA("ParticleEmitter") then
                Attribute = j:GetAttribute("EmitDelay")
                v1 = false
                if typeof(Attribute) == "number" then
                    v1 = Attribute > 0
                end
                if not v1 then
                    play(j)
                else
                    task.delay(Attribute, play, j)
                end
            end
        end
    end,
}
v1[2208] = {SetProperty("Lighting.OrangeBlack.Enabled", true)}
v1[2210] = {SetProperty("Lighting.OrangeBlack.Enabled", false)}
v1[2211] = {SetProperty("Lighting.OrangeWhite.Enabled", true)}
v1[2213] = {
    TweenProperty(
        "CoreGui.MoonAnimatorEffects.Vignette.ImageColor3",
        TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear),
        Color3.new(0.377869, 1, 0.337255)
    ),
    SetProperty("Lighting.OrangeWhite.Enabled", false),
    (SetProperty("Lighting.OrangeBlack.Enabled", true)),
}
v1[2215] = {
    SetProperty("Lighting.White+Black.Enabled", true),
    (SetProperty("Lighting.OrangeBlack.Enabled", false)),
}
v1[2217] = {
    SetProperty("Lighting.Black+White.Enabled", true),
    (SetProperty("Lighting.White+Black.Enabled", false)),
}
v1[2219] = {SetProperty("Lighting.Black+White.Enabled", false)}
v1[2222] = {SetProperty("Lighting.OrangeBlack.Enabled", true)}
v1[2224] = {
    SetProperty("Lighting.OrangeWhite.Enabled", true),
    (SetProperty("Lighting.OrangeBlack.Enabled", false)),
}
v1[2226] = {SetProperty("Lighting.OrangeWhite.Enabled", false)}
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
    TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), Color3.new(1, 0.690196, 0.905882)),
    (TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 0.1)),
}
v1[2253] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 0)),
}
v1[2263] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.2, Enum.EasingStyle.Linear), 0.75)),
}
v1[2329] = {
    TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 1),
    TweenProperty("Lighting.Moon.Saturation", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0),
    TweenProperty("Lighting.Moon.Contrast", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0),
    TweenProperty("Lighting.Moon.TintColor", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
    (TweenProperty("Lighting.Moon.Brightness", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0)),
}
v1[2333] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 1)),
}
v1[2335] = {
    (TweenProperty(
        "CoreGui.MoonAnimatorEffects.Vignette.ImageColor3",
        TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear),
        Color3.new(0, 0, 0)
    )),
}
v1[2345] = {
    SetProperty("Lighting.Moon.Enabled", false),
    (TweenProperty("Lighting.Atmosphere.Density", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)),
}
v1[2379] = {
    function() -- Line: 793
        local Attribute, Attribute_2
        local Head = workspace.VFX.Head

        function check(a1) -- Line: 796 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Head:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 811 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
    SetProperty("Lighting.OrangeBlack.Enabled", true),
}
v1[2381] = {SetProperty("Lighting.OrangeBlack.Enabled", false)}
v1[2384] = {
    (TweenProperty(
        "Workspace.Animatables.pumpkinbossagain.Pumpkin Monster Neon.Color",
        TweenInfo.new(0.2, Enum.EasingStyle.Linear),
        Color3.new(0.760784, 0.345098, 0.180392)
    )),
}
v1[2501] = {
    function() -- Line: 829
        for k, v in pairs(workspace.VFX.Rumble:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = true
            end
        end
    end,
}
v1[2534] = {
    function() -- Line: 838
        local Attribute, Attribute_2
        local Slam1 = workspace.VFX.Slam1

        function check(a1) -- Line: 841 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Slam1:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 856 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[2547] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 10)),
}
v1[2572] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 6)),
}
v1[2573] = {
    function() -- Line: 873
        local Attribute, Attribute_2
        local Slam2 = workspace.VFX.Slam2

        function check(a1) -- Line: 876 -- types: a1: number?
            local v1 = false
            if a1 ~= nil then
                v1 = a1 ~= 0
            end
            return v1
        end

        for k, v in pairs(Slam2:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                Attribute = v:GetAttribute("EmitCount")
                Attribute_2 = v:GetAttribute("EmitDuration")
                if check(Attribute) then
                    v:Emit(Attribute)
                end
                if check(Attribute_2) then
                    v.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 891 -- upvalues: v (val)
                        v.Enabled = false
                    end)
                end
            end
        end
    end,
}
v1[2595] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), 8)),
}
v1[2621] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), 3)),
}
v1[2650] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 7)),
}
v1[2677] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 2)),
}
v1[2703] = {
    (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), 20)),
}
v1[2729] = {
    function() -- Line: 920
        for k, v in pairs(workspace.VFX.Rumble:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
    end,
}
v1[2779] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 0.2)),
}
v1[2785] = {
    function() -- Line: 933
        for k, v in pairs(workspace.VFX.Roar:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = true
            end
        end
    end,
}
v1[2790] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(2.3666666666666667, Enum.EasingStyle.Linear), 0.2)),
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
v1[2882] = {SetProperty("Lighting.Gray.Enabled", false)}
v1[2889] = {
    function() -- Line: 975
        for k, v in pairs(workspace.VFX.Roar:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
    end,
}
v1[2932] = {
    (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 10)),
}
v1[2933] = {
    TweenProperty(
        "Workspace.VFX.PumpkinLight.Attachment.SurfaceLight.Brightness",
        TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
        2
    ),
    SetProperty("Lighting.Pumpkin.Enabled", true),
    TweenProperty("Lighting.Pumpkin.Saturation", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.1),
    TweenProperty("Lighting.Pumpkin.Contrast", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.1),
    TweenProperty(
        "Lighting.Pumpkin.TintColor",
        TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear),
        Color3.new(1, 0.596078, 0.458824)
    ),
    (TweenProperty("Lighting.Pumpkin.Brightness", TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), 0.2)),
}
v1[2936] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), 0)),
}