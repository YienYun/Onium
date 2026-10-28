-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Silver
-- Decompile time: 0.34 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    return Layers.Result({
        (Layers.Paint(a1.Host, {Palette = "Silver", Rotation = -75, Drift = a1.Drift})),
    })
end