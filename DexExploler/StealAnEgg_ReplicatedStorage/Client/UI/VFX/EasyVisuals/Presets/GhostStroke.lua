-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.GhostStroke
-- Decompile time: 0.73 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 8 -- upvalues: Layers (val)
    local Host = a1.Host
    local Ghost = Layers.AlphaStops("Ghost")
    local v1 = Layers.Paint(Host, {Palette = "Ghost", Alpha = Ghost, Drift = a1.Drift, AlphaDrift = a1.Drift * 0.9})
    local v2 = Layers.Edge(Host, a1.Width)
    return Layers.Result({
        v1,
        Layers.Paint(v2.outline, {
            Palette = "Ghost",
            Alpha = Ghost,
            Drift = -a1.Drift * 0.9,
            AlphaDrift = -a1.Drift * 0.9,
        }),
        v2,
    })
end