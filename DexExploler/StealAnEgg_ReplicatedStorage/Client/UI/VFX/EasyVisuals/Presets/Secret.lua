-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Secret
-- Decompile time: 0.86 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 8 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Zebra", Rotation = 90, Drift = a1.Drift})
    local v2 = nil
    if Layers.AcceptsEdge(Host) then
        v2 = Layers.Paint((Layers.Edge(Host, a1.Width)).outline, {
            Palette = "Zebra",
            StartPhase = 0.5,
            Rotation = 90,
            PhaseGoal = 0.5,
            Drift = a1.Drift,
        })
    end
    return Layers.Result({v1, v2, nil})
end