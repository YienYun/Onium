-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Lava
-- Decompile time: 0.39 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 5 -- upvalues: Layers (val)
    return Layers.Result({(Layers.Paint(a1.Host, {Palette = "Lava", Drift = a1.Drift}))})
end