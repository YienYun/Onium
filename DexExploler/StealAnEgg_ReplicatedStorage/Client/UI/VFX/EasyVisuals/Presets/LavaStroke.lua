-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.LavaStroke
-- Decompile time: 0.62 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 5 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Lava", Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {Palette = "Lava", Drift = -a1.Drift}),
        v2,
    })
end