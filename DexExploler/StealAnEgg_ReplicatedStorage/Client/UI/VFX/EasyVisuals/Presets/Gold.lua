-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Gold
-- Decompile time: 0.39 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 7 -- upvalues: Layers (val)
    return Layers.Result({(Layers.Paint(a1.Host, {Palette = "Gold", Rotation = -75, Drift = a1.Drift}))})
end