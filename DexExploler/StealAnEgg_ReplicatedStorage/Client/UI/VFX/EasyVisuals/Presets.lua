-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Presets
-- Decompile time: 0.35 ms

require(script.Parent.Layers)
return ((function() -- Line: 7
    local v1 = {}
    for i, j in script:GetDescendants() do
        if j:IsA("ModuleScript") then
            v1[j.Name] = (require(j))
        end
    end
    return v1
end)())