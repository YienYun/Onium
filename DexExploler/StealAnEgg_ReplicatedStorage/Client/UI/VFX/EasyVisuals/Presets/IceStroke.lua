-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.IceStroke
-- Decompile time: 0.61 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 9 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Ice", Rotation = -65, Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {Palette = "Ice", Rotation = -61, Drift = a1.Drift * 0.23}),
        v2,
    })
end