-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Bubblegum
-- Decompile time: 0.79 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 11 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Bubblegum", Rotation = -90, Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {Palette = "Bubblegum", Rotation = -45, Drift = a1.Drift * 0.9}),
        v2,
    }, {(Layers.Breathe(v2, a1.Width, a1.Width * 3, a1.Drift, 0.055))})
end