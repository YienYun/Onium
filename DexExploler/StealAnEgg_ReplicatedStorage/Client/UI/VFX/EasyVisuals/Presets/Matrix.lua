-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets.Matrix
-- Decompile time: 1.03 ms

local Layers = require(script.Parent.Parent.Layers)
return function(a1) -- Line: 10 -- upvalues: Layers (val)
    local Host = a1.Host
    local v1 = Layers.Paint(Host, {Palette = "Matrix", Rotation = 90, Drift = a1.Drift})
    local v2 = Layers.Edge(Host, a1.Width)
    local u18 = Layers.Paint(v2.outline, {Palette = "Matrix", Rotation = 90, PhaseGoal = 0.5})
    task.delay(0.1, function() -- Line: 27 -- upvalues: u18 (val), a1 (val)
        u18:Drift(a1.Drift, 1)
    end)
    return Layers.Result({v1, u18, v2})
end