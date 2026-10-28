-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.FireStroke
-- Decompile time: 0.65 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 9 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Fire", Rotation = -75, Drift = a1.Drift})
    local v2 = Layers.Turn(v1, v1.gradient, 0, a1.Drift)
    local v3 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v3.outline, {Palette = "Fire", Rotation = 75, Drift = -a1.Drift}),
        v3,
    }, {v2})
end