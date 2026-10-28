-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.RainbowOutline
-- Decompile time: 0.42 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    local v1 = Layers.Edge(a1.Host, a1.Width)
    local v2 = Layers.Paint(v1.outline, {Palette = "Rainbow"})
    return Layers.Result({v2, v1}, {(Layers.Turn(v2, v1.outline, 5, a1.Drift))})
end