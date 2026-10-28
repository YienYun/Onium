-- Script path: ReplicatedStorage.Shared.Util.AssetRollScaleWeights
-- Decompile time: 0.96 ms

return require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.AssetScaleBands", table.freeze({
    table.freeze({low = 1, high = 1.01, weight = 250}),
    table.freeze({low = 0.48, high = 0.5, weight = 45.17}),
    table.freeze({low = 0.24, high = 0.25, weight = 17.09}),
    table.freeze({low = 1.49, high = 1.5, weight = 4.27}),
    (table.freeze({low = 1.99, high = 2, weight = 0.1857})),
}), true, false, function(a1) -- Line: 25
    local high, v1
    local v2 = 0
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        v1 = false
        if 0 < j.low then
            high = j.high
            v1 = j.low <= high
        end
        assert(v1)
        v2 = v2 + j.weight
    end
    assert(v2 > 0)
end)