-- Script path: ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.OutroCutscene2.OriginalSequence
-- Decompile time: 4.17 ms

local v1 = {}
local v2 = {}
local v3 = SetProperty(
    "Workspace.CurrentCamera.CFrame",
    CFrame.new(3748.5474, 85.5723, -360.1614, -0.0513, -0.9347, 0.3516, 0, 0.3521, 0.936, -0.9987, 0.048, -0.0181)
)
local v4 = SetProperty("Workspace.CurrentCamera.AttachToPart", Cam)
local v5 = SetProperty("Workspace.CurrentCamera.FieldOfView", 35)
local v6 = SetProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageColor3", Color3.new(1, 0.588978, 0.25098))
local v7 = SetProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", 1)
local v8 = SetProperty("Lighting.Gold.TintColor", Color3.new(1, 1, 1))
local v9 = SetProperty("Lighting.Gold.Brightness", 0)
local v10 = SetProperty("Lighting.Gold.Saturation", 0)
local v11 = SetProperty("Lighting.Gold.Contrast", 0)
local v12 = SetProperty("Lighting.DepthOfField.Enabled", true)
local v13 = SetProperty("Lighting.DepthOfField.FarIntensity", 0.09)
local v14 = SetProperty("Lighting.Blur.Enabled", true)
local v15 = SetProperty("Lighting.Blur.Size", 15)
local v16 = TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 2)
v2[1] = v3
v2[2] = v4
v2[3] = v5

v2[4] = function() -- Line: 8
    for k, v in pairs(workspace.EnvelopeRig.GoldenEnvelope.Decor:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled = true
        end
    end
end

v2[5] = v6
v2[6] = v7
v2[7] = v8
v2[8] = v9
v2[9] = v10
v2[10] = v11
v2[11] = v12
v2[12] = v13
v2[13] = v14
v2[14] = v15
v2[15] = v16
v2[16] = (SetProperty("CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency", 0))
v2[17] = TweenProperty(
    "CoreGui.MoonAnimatorEffects.Screen Cover.BackgroundTransparency",
    TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear),
    1
)
v1[0] = v2
v1[180] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 15)),
}
v1[197] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(1, Enum.EasingStyle.Linear), 4)),
}
v1[240] = {
    TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0),
    TweenProperty("Lighting.Gold.TintColor", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), Color3.new(1, 0.784314, 0.415686)),
    TweenProperty("Lighting.Gold.Brightness", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.3),
    TweenProperty("Lighting.Gold.Saturation", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.5),
    (TweenProperty("Lighting.Gold.Contrast", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.7)),
}
v1[307] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 10)),
}
v1[322] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 4)),
}
v1[390] = {
    TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 1),
    TweenProperty("Lighting.Gold.TintColor", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), Color3.new(1, 1, 1)),
    TweenProperty("Lighting.Gold.Brightness", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0),
    TweenProperty("Lighting.Gold.Saturation", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0),
    (TweenProperty("Lighting.Gold.Contrast", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0)),
}
v1[402] = {
    function() -- Line: 62
        for k, v in pairs(workspace.EnvelopeRig.GoldenEnvelope.Decor:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
    end,
}
v1[421] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 10)),
}
v1[424] = {
    (TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)),
}
v1[425] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 2)),
}
v1[645] = {
    TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 32),
    TweenProperty("Lighting.DepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 100),
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 7)),
}
v1[646] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 4)),
}
v1[769] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 0)),
}
v1[796] = {
    (TweenProperty("CoreGui.MoonAnimatorEffects.Vignette.ImageTransparency", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 1)),
}
v1[1147] = {
    (TweenProperty("Lighting.Blur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 10)),
}