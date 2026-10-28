-- Script path: ReplicatedStorage.Controllers.Game.IconController.Icons
-- Decompile time: 0.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local v1 = {
    Preload = {},
    Main = {
        ["boss-tokens"] = (require(ReplicatedStorage.Data.Currency.Configs.BossTokens)).Icon,
    },
}
v1.All = TableUtil.Reconcile(v1.Preload, v1.Main)
return v1