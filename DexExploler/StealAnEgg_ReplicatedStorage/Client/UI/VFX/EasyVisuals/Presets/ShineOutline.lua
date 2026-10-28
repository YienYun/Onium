-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.ShineOutline
-- Decompile time: 0.86 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 8 -- upvalues: Layers (val)
    local Host = a1.Host
    local Color = a1.Color or Layers.HostColor(Host)
    local v1 = Layers.Edge(Host, a1.Width)
    local v2 = Layers.Paint(v1.outline, {Palette = Layers.ShinePalette(Color, 0.6)})
    return Layers.Result({v2, v1}, {(Layers.Turn(v2, v1.outline, 0.75, a1.Drift))})
end