-- Script path: ReplicatedStorage.Shared.Util.ScrambleBossDrop
-- Decompile time: 0.55 ms

return table.freeze({
    HasObtained = function(a1) -- Line: 3
        if a1.MechaScramblerObtained == true then
            return true
        end
        if a1.Index and a1.Index["Mecha Scrambler"] == true then
            return true
        end
        for i, j in a1.Inventory or {} do
            if j.Category == "Mecha Scrambler" and j.CreatorTemporary ~= true then
                return true
            end
        end
        for k, n in a1.EggInventory or {} do
            if n.AssetCategory == "Mecha Scrambler" and n.CreatorTemporary ~= true then
                return true
            end
        end
        return false
    end,
})