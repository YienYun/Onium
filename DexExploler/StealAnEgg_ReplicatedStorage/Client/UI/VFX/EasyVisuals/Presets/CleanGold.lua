-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.CleanGold
-- Decompile time: 0.41 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    return Layers.Result({
        (Layers.Paint(a1.Host, {Palette = "CleanGold", Rotation = 45, Drift = a1.Drift})),
    })
end