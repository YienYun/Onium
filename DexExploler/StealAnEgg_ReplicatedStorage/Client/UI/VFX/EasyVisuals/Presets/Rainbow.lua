-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Rainbow
-- Decompile time: 0.34 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    return Layers.Result({
        (Layers.Paint(a1.Host, {Palette = "Rainbow", Rotation = 0, Drift = a1.Drift})),
    })
end