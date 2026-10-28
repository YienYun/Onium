-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Shine
-- Decompile time: 0.69 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 9 -- upvalues: Layers (val)
    local Host = a1.Host
    return Layers.Result({
        (Layers.Paint(Host, {
            Rotation = 60,
            Palette = Layers.ShinePalette(a1.Color or Layers.HostColor(Host), 0.417505),
            Drift = a1.Drift * 0.6,
        })),
    })
end