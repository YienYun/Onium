-- Script path: ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.OutroCutscene.OriginalSequence
-- Decompile time: 9.63 ms

local v1 = {
    [0] = {
        SetProperty(
            "Workspace.CurrentCamera.CFrame",
            CFrame.new(-81.0611, 138.7064, 994.4508, 0.03, 0.5169, -0.8556, 0, 0.8559, 0.5171, 0.9995, -0.0155, 0.0256)
        ),
        SetProperty("Workspace.CurrentCamera.AttachToPart", Cam),
        SetProperty("Workspace.CurrentCamera.FieldOfView", 35),
        SetProperty("Lighting.Blur.Enabled", true),
        SetProperty("Lighting.Blur.Size", 2),
        SetProperty("Lighting.DepthOfField.Enabled", true),
        SetProperty("Lighting.DepthOfField.InFocusRadius", 25),
        (SetProperty("CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency", 1)),
    },
    [14] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine), 45)),
    },
    [63] = {
        function() -- Line: 20
            for k, v in pairs(workspace.VFX.Rumble:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = true
                end
            end
        end,
    },
    [78] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(4.216666666666667, Enum.EasingStyle.Sine), 55)),
    },
    [84] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 15)),
    },
    [94] = {
        function() -- Line: 37
            local Attribute, Attribute_2
            local Slam1 = workspace.VFX.Slam1

            function check(a1) -- Line: 40 -- types: a1: number?
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
                        task.delay(Attribute_2, function() -- Line: 55 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    },
    [95] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), 4)),
    },
    [234] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 10)),
    },
    [240] = {
        function() -- Line: 72
            local Attribute, v1
            local TweenService = game:GetService("TweenService")
            local Slash = workspace.VFX.Slash
            local u8 = {}

            local function check(a1) -- Line: 86
                local v1 = false
                if typeof(a1) == "number" then
                    v1 = a1 > 0
                end
                return v1
            end

            local function enableFor(a1, a2) -- Line: 90 -- types: a1: userdata, a2: number
                a1.Enabled = true
                task.delay(a2, function() -- Line: 92 -- upvalues: a1 (val)
                    a1.Enabled = false
                end)
            end

            local function fadeBeam(a1, a2) -- Line: 97
                -- upvalues: u8 (val), TweenService (val)
                local u4 = u8[a1]
                if not u4 then
                    u4 = {
                        Transparency = a1.Transparency,
                        Width0 = a1.Width0,
                        Width1 = a1.Width1,
                    }
                end
                u8[a1] = u4
                local v1 = a2 * 0.2
                local v2 = a2 * 0.4
                local v3 = a2 * 0.75

                local function setFade(a1_2) -- Line: 111 -- upvalues: u4 (val), a1 (val) -- types: a1_2: number
                    local Time, new, v1
                    local v2 = {}
                    for i, j in u4.Transparency.Keypoints do
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
                local u27 = NumberValue.Changed:Connect(setFade)
                a1.Width0 = u4.Width0
                a1.Width1 = u4.Width1
                a1.Enabled = true
                local u42 = TweenService:Create(NumberValue, TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 0})
                local u54 = TweenService:Create(NumberValue, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Value = 1})
                local u65 = TweenService:Create(a1, TweenInfo.new(a2 - v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Width0 = 0, Width1 = 0})
                u42:Play()
                task.delay(a2 - v2, function() -- Line: 133 -- upvalues: u54 (val)
                    u54:Play()
                end)
                task.delay(v3, function() -- Line: 136 -- upvalues: u65 (val)
                    u65:Play()
                end)
                task.delay(a2, function() -- Line: 141 -- upvalues: u42 (val), u54 (val), u65 (val), u27 (val), NumberValue (val), a1 (val), u4 (val)
                    u42:Cancel()
                    u54:Cancel()
                    u65:Cancel()
                    u27:Disconnect()
                    NumberValue:Destroy()
                    a1.Enabled = false
                    a1.Transparency = u4.Transparency
                    a1.Width0 = u4.Width0
                    a1.Width1 = u4.Width1
                end)
            end

            local function play(a1) -- Line: 155 -- upvalues: fadeBeam (val) -- types: a1: userdata
                local v1
                local Attribute = a1:GetAttribute("EmitCount")
                local Attribute_2 = a1:GetAttribute("EmitDuration")
                if not a1:IsA("ParticleEmitter") then
                    if a1:IsA("Beam") then
                        v1 = false
                        if typeof(Attribute_2) == "number" then
                            v1 = Attribute_2 > 0
                        end
                        if v1 then
                            fadeBeam(a1, Attribute_2)
                        end
                    end
                    return
                end
                v1 = false
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
                if not v1 then
                    return
                end
                a1.Enabled = true
                task.delay(Attribute_2, function() -- Line: 92 -- upvalues: a1 (val)
                    a1.Enabled = false
                end)
            end

            for i, j in Slash:GetDescendants() do
                if j:IsA("ParticleEmitter") or j:IsA("Beam") then
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
    },
    [243] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 4)),
    },
    [283] = {
        function() -- Line: 192
            for k, v in pairs(workspace.VFX.Rumble:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end,
    },
    [331] = {
        (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 2)),
    },
    [332] = {
        (TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Back), 35)),
    },
    [443] = {
        function() -- Line: 209
            local Attribute, Attribute_2
            local Highfive = workspace.VFX.Highfive

            function check(a1) -- Line: 212 -- types: a1: number?
                local v1 = false
                if a1 ~= nil then
                    v1 = a1 ~= 0
                end
                return v1
            end

            for k, v in pairs(Highfive:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    Attribute = v:GetAttribute("EmitCount")
                    Attribute_2 = v:GetAttribute("EmitDuration")
                    if check(Attribute) then
                        v:Emit(Attribute)
                    end
                    if check(Attribute_2) then
                        v.Enabled = true
                        task.delay(Attribute_2, function() -- Line: 227 -- upvalues: v (val)
                            v.Enabled = false
                        end)
                    end
                end
            end
        end,
    },
    [556] = {
        TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 13),
        (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 5)),
    },
}
local v2 = {}
local v3 = TweenProperty
local v4 = TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear)

v2[1] = function() -- Line: 241
    local Attribute, Attribute_2
    local PumpkinPortal = workspace.PumpkinPortal

    function check(a1) -- Line: 244 -- types: a1: number?
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
                task.delay(Attribute_2, function() -- Line: 259 -- upvalues: v (val)
                    v.Enabled = false
                end)
            end
        end
    end
end

v2[2] = v3("Lighting.Blur.Size", v4, 2)
v1[557] = v2
v1[564] = {
    (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 25)),
}
v1[842] = {
    (TweenProperty("Lighting.DepthOfField.InFocusRadius", TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), 5)),
}
v1[915] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(1.05, Enum.EasingStyle.Linear), 25)),
}
v1[961] = {
    (TweenProperty(
        "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency",
        TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear),
        0
    )),
}