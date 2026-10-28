-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.ChromeStroke
-- Decompile time: 0.75 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 9 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Chrome", Rotation = -90, Drift = a1.Drift})
    local v2 = nil
    if Layers.AcceptsEdge(Host) then
        v2 = Layers.Paint((Layers.Edge(Host, a1.Width)).outline, {Palette = "Chrome", Rotation = -89, Drift = a1.Drift * 0.58})
    end
    return Layers.Result({v1, v2, nil})
end