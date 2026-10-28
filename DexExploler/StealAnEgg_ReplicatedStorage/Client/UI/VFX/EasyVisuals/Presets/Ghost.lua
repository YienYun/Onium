-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Ghost
-- Decompile time: 0.42 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    return Layers.Result({
        (Layers.Paint(a1.Host, {
            Palette = "Ghost",
            Alpha = Layers.AlphaStops("Ghost"),
            Drift = a1.Drift,
            AlphaDrift = a1.Drift * 0.9,
        })),
    })
end