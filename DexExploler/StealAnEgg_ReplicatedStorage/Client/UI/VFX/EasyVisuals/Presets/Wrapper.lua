-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Wrapper
-- Decompile time: 0.38 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 5 -- upvalues: Layers (val)
    local v1 = Layers.Paint(a1.Host, {Palette = a1.Color, Drift = a1.Drift})
    Layers.Replay(v1, a1.Chain)
    return Layers.Result({v1})
end