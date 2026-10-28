-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.GradientTemplates
-- Decompile time: 0.31 ms

return ((function() -- Line: 11
    local v1 = {}
    for i, j in script:GetDescendants() do
        if j:IsA("ModuleScript") then
            v1[j.Name] = (require(j))
        end
    end
    return v1
end)())