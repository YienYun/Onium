-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.WaveStroke
-- Decompile time: 0.94 ms

local Layers = require(script.Parent.Parent.Layers)
local u25 = (function(a1) -- Line: 10 -- types: a1: table
    local v1 = table.create(#a1)
    for i, j in a1 do
        v1[i] = (NumberSequenceKeypoint.new(j[1], j[2]))
    end
    return NumberSequence.new(v1)
end)({{0, 0}, {0.25, 1}, {0.5, 1}, {0.75, 1}, {1, 0}})
return function(a1) -- Line: 20 -- upvalues: Layers (val), u25 (val)
    local Color = a1.Color
    local v1 = Layers.Edge(a1.Host, a1.Width)
    return Layers.Result({
        Layers.Paint(v1.outline, {
            Palette = Layers.FlatPalette(Color),
            Alpha = u25,
            Drift = a1.Drift,
            AlphaDrift = a1.Drift * 0.9,
        }),
        v1,
    })
end