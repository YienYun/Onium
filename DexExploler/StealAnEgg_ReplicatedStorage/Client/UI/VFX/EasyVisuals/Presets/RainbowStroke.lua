-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.RainbowStroke
-- Decompile time: 0.39 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 5 -- upvalues: Layers (val)
    local v1 = Layers.Edge(a1.Host, a1.Width)
    return Layers.Result({Layers.Paint(v1.outline, {Palette = "Rainbow", Drift = -a1.Drift}), v1})
end