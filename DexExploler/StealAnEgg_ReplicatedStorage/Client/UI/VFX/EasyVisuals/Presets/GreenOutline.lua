-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.GreenOutline
-- Decompile time: 0.58 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    local v1 = Layers.Edge(a1.Host, a1.Width)
    local v2 = Layers.Paint(v1.outline, {Palette = "Green", Alpha = Layers.AlphaStops("Green")})
    return Layers.Result({v2, v1}, {(Layers.Turn(v2, v1.outline, 5, a1.Drift))})
end