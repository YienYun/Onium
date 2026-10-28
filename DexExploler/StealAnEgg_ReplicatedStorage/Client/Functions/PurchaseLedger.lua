-- Script path: ReplicatedStorage.Client.Functions.PurchaseLedger
-- Decompile time: 3.00 ms

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local LocalPlayer = Players.LocalPlayer
local u33 = {}
local u34 = nil
local u35 = {}

function u35.OwnedPerProfile(a1) -- Line: 22 -- upvalues: Save (val) -- types: a1: number
    local v1 = Save.Peek()
    local Products = if v1 == nil then nil else v1.Products
    local v2 = false
    if type(Products) == "table" then
        v2 = Products[tostring(a1)] == true
    end
    return v2
end

function u35.AwaitingReceipt(a1) -- Line: 28 -- upvalues: u33 (val) -- types: a1: number
    return u33[a1] == true
end

function u35.HasOpenTicket() -- Line: 32 -- upvalues: u34 (ref)
    return u34 ~= nil
end

function u35.OpenTicket(a1) -- Line: 36 -- upvalues: u34 (ref) -- types: a1: number
    local u1 = {Live = true, SkuId = a1}
    u34 = u1
    task.delay(90, function() -- Line: 39 -- upvalues: u34 (upval), u1 (val)
        if u34 == u1 then
            u1.Live = false
            u34 = nil
        end
    end)
    return u1
end

function u35.CloseTicket(a1) -- Line: 48 -- upvalues: u34 (ref) -- types: a1: number
    local v1 = u34
    if v1 ~= nil and v1.SkuId == a1 then
        v1.Live = false
        u34 = nil
    end
end

local function settleReceipt(a1) -- Line: 56 -- upvalues: u33 (val), u35 (val) -- types: a1: number
    u33[a1] = nil
    u35.CloseTicket(a1)
end

if RunService:IsClient() then
    local Storefront = Remotes.Storefront
    Storefront.PurchaseRejected.OnClientEvent:Connect(function(a1) -- Line: 78 -- upvalues: u33 (val), u35 (val)
        local ProductId = a1.ProductId
        u33[ProductId] = nil
        u35.CloseTicket(ProductId)
    end)
    Storefront.PurchaseSettled.OnClientEvent:Connect(function(a1, a2) -- Line: 81 -- upvalues: u33 (val), u35 (val)
        local ProductId = a2.ProductId
        u33[ProductId] = nil
        u35.CloseTicket(ProductId)
    end)
    Storefront.ReceiptCleared.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 84 -- upvalues: u33 (val), u35 (val) -- types: a1: number, a2: string, a3: boolean?
        u33[a1] = nil
        u35.CloseTicket(a1)
    end)
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(a1, a2, a3) -- Line: 61
        -- upvalues: LocalPlayer (val), u35 (val), u33 (val), Products (val)
        if a1 == LocalPlayer.UserId and a2 ~= nil then
            u35.CloseTicket(a2)
            if not a3 then
                u33[a2] = nil
                return
            end
            local v1 = Products.FromProductId(a2)
            if v1 ~= nil and v1.OneTime and not u35.OwnedPerProfile(a2) then
                u33[a2] = true
            end
            return
        end
    end)
end
return (table.freeze(u35))