-- Script path: ReplicatedStorage.Client.Functions.Storefront
-- Decompile time: 0.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseSession = require(ReplicatedStorage.Client.Functions.PurchaseSession)
return {
    Prompt = function(a1, a2, a3) -- Line: 11 -- upvalues: PurchaseSession (val) -- types: a1: number, a2: boolean?, a3: string?
        PurchaseSession.Request(a1, a2, a3)
    end,
}