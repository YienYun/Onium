-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.OceanicStroke
-- Decompile time: 0.64 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 8 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Oceanic", Rotation = -75, Spin = 0.1, Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {Palette = "Oceanic", Drift = -a1.Drift}),
        v2,
    })
end