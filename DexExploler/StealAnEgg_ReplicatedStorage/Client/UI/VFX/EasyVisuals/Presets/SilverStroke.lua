-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.SilverStroke
-- Decompile time: 0.57 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 9 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Silver", Rotation = -80, Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {Palette = "Silver", Rotation = -79, Drift = a1.Drift * 0.56}),
        v2,
    })
end