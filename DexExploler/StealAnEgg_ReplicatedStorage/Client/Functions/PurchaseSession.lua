-- Script path: ReplicatedStorage.Client.Functions.PurchaseSession
-- Decompile time: 10.63 ms

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local SpeedPacks = require(ReplicatedStorage.Data.SpeedPacks)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local PurchaseLedger = require(ReplicatedStorage.Client.Functions.PurchaseLedger)
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u50 = {
    Busy = "Wrap up the purchase window that's already open before starting another one.",
    Disabled = "Purchases are paused for a moment while Roblox catches up. Please try again shortly.",
    Owned = "You already own this!",
    Pending = "Roblox is still confirming your last attempt to buy this. If it never arrives, rejoin and it will sync.",
    Screened = "This item isn't available to buy right now.",
    Settled = "This one-time item already went through on your account. Rejoin if it hasn't shown up yet.",
    Unavailable = "The shop couldn't open that purchase. Please try again in a moment.",
    UnknownSku = "We couldn't find that item in the shop. If this keeps happening, let our support team know.",
}
local u51 = {Owned = true}
local u52 = {Silent = true}
local LocalPlayer = Players.LocalPlayer
local v1 = {}

local function refusal(a1, a2) -- Line: 43 -- types: a1: string, a2: string?
    return {Refusal = a1, Note = a2}
end

local function refuse(a1, a2) -- Line: 47
    -- upvalues: ReplicatedStorage (val), u50 (val), u51 (val)
    local Message = require(ReplicatedStorage.Client.Message)
    local v1 = a2 or u50[a1]
    if u51[a1] then
        Message.Notice(v1)
        return
    end
    Message.Warn(v1)
end

local function chime() -- Line: 57 -- upvalues: ReplicatedStorage (val)
    require(ReplicatedStorage.Shared.Audio).Play(129627240635324, script, {PlaybackSpeed = 1.3, Volume = 0.6})
end

local function askServer(a1, a2, a3, a4) -- Line: 62 -- types: a2: number, a3: string?, a4: number?
    local success, err, v1 = pcall(function() -- Line: 63 -- upvalues: a1 (val), a2 (val), a3 (val), a4 (val)
        return a1:InvokeServer(a2, a3, a4)
    end)
    local v2 = success and err == true
    if success and type(v1) == "string" then
        return v2, v1
    end
    return v2, nil
end

local function storefrontOpen(a1) -- Line: 71 -- upvalues: GameFlags (val) -- types: a1: table
    if GameFlags.StorefrontOpen:Get() then
        return nil
    end
    return {Refusal = "Disabled"}
end

local function knownSku(a1) -- Line: 75 -- types: a1: table
    if a1.Config == nil then
        return {Refusal = "UnknownSku"}
    end
    return nil
end

local function configVeto(a1) -- Line: 79 -- types: a1: table
    local Precheck = a1.Config.Precheck
    if Precheck == nil then
        return nil
    end
    local success, err, v1 = pcall(Precheck)
    if not success then
        warn((("purchase precheck raised an error: %*"):format(err)))
        return {Refusal = "Screened"}
    end
    if err == true then
        return nil
    end
    return {Refusal = "Screened", Note = if type(v1) ~= "string" then nil else v1}
end

local function playCue(a1) -- Line: 95 -- upvalues: ReplicatedStorage (val) -- types: a1: table
    require(ReplicatedStorage.Shared.Audio).Play(129627240635324, script, {PlaybackSpeed = 1.3, Volume = 0.6})
    return nil
end

local function promptFromClient(a1) -- Line: 133
    -- upvalues: MarketplaceService (val), LocalPlayer (val), u52 (val), PurchaseLedger (val)
    local Ticket = a1.Ticket
    local success = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, a1.SkuId)
    if not success and Ticket.Live then
        PurchaseLedger.CloseTicket(a1.SkuId)
        return {Refusal = "Unavailable"}
    end
    return u52
end

local function promptFromServer(a1) -- Line: 143
    -- upvalues: Remotes (val), u52 (val), PurchaseLedger (val)
    local Ticket = a1.Ticket
    local AskPurchaseOffer = Remotes.Storefront.AskPurchaseOffer
    local SkuId = a1.SkuId
    local Source = a1.Source
    local SpeedRevision = a1.SpeedRevision
    local success, err, v1 = pcall(function() -- Line: 63 -- upvalues: AskPurchaseOffer (val), SkuId (val), Source (val), SpeedRevision (val)
        return AskPurchaseOffer:InvokeServer(SkuId, Source, SpeedRevision)
    end)
    local v2 = success and err == true
    local v3 = if not success then nil else if type(v1) ~= "string" then nil else v1
    if not Ticket.Live then
        return u52
    end
    if v2 then
        return nil
    end
    PurchaseLedger.CloseTicket(a1.SkuId)
    return {Refusal = "Unavailable", Note = v3}
end

local u71 = {storefrontOpen, knownSku}

u71[3] = function(a1) -- Line: 102 -- upvalues: PurchaseLedger (val) -- types: a1: table
    if PurchaseLedger.HasOpenTicket() then
        return {Refusal = "Busy"}
    end
    return nil
end

u71[4] = function(a1) -- Line: 106 -- upvalues: GameFlags (val), PurchaseLedger (val) -- types: a1: table
    if a1.Config.OneTime and GameFlags.OneTimeRepeatGuard:Get() then
        if PurchaseLedger.OwnedPerProfile(a1.SkuId) then
            return {Refusal = "Settled"}
        end
        if PurchaseLedger.AwaitingReceipt(a1.SkuId) then
            return {Refusal = "Pending"}
        end
        return nil
    end
    return nil
end

u71[5] = configVeto

u71[6] = function(a1) -- Line: 116
    -- upvalues: PurchaseLedger (val), CashPacks (val), Remotes (val), u52 (val)
    local v1 = PurchaseLedger.OpenTicket(a1.SkuId)
    a1.Ticket = v1
    if CashPacks.FindSlot(a1.SkuId) then
        return nil
    end
    local AskServerProbe = Remotes.Storefront.AskServerProbe
    local SkuId = a1.SkuId
    local u14 = nil
    local u15 = nil
    local success, err, v2 = pcall(function() -- Line: 63 -- upvalues: AskServerProbe (val), SkuId (val), u14 (val), u15 (val)
        return AskServerProbe:InvokeServer(SkuId, u14, u15)
    end)
    local v3 = success and err == true
    local v4 = if not success then nil else if type(v2) ~= "string" then nil else v2
    if not v1.Live then
        return u52
    end
    if v3 then
        return nil
    end
    PurchaseLedger.CloseTicket(a1.SkuId)
    return {Refusal = "Unavailable", Note = v4}
end

u71[7] = playCue

u71[8] = function(a1) -- Line: 157
    -- upvalues: CashPacks (val), SpeedPacks (val), GameFlags (val), Remotes (val), u52 (val), PurchaseLedger (val)
    -- upvalues: MarketplaceService (val), LocalPlayer (val)
    if CashPacks.FindSlot(a1.SkuId) == nil
        and SpeedPacks.FindSlot(a1.SkuId) == nil
        and GameFlags.ClientSidePrompts:Get() then
        local Ticket = a1.Ticket
        local success = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, a1.SkuId)
        if not success and Ticket.Live then
            PurchaseLedger.CloseTicket(a1.SkuId)
            return {Refusal = "Unavailable"}
        end
        return u52
    end
    local Ticket_2 = a1.Ticket
    local AskPurchaseOffer = Remotes.Storefront.AskPurchaseOffer
    local SkuId = a1.SkuId
    local Source = a1.Source
    local SpeedRevision = a1.SpeedRevision
    local success_2, err, v1 = pcall(function() -- Line: 63 -- upvalues: AskPurchaseOffer (val), SkuId (val), Source (val), SpeedRevision (val)
        return AskPurchaseOffer:InvokeServer(SkuId, Source, SpeedRevision)
    end)
    local v2 = success_2 and err == true
    local v3 = if not success_2 then nil else if type(v1) ~= "string" then nil else v1
    if not Ticket_2.Live then
        return u52
    end
    if v2 then
        return nil
    end
    PurchaseLedger.CloseTicket(a1.SkuId)
    return {Refusal = "Unavailable", Note = v3}
end

local u80 = {storefrontOpen, knownSku}

u80[3] = function(a1) -- Line: 169 -- upvalues: ReplicatedStorage (val) -- types: a1: table
    if require(ReplicatedStorage.Client.Gamepasses).Owns(a1.Config.Name) then
        return {Refusal = "Owned"}
    end
    return nil
end

u80[4] = configVeto
u80[5] = playCue

u80[6] = function(a1) -- Line: 174 -- upvalues: MarketplaceService (val), LocalPlayer (val) -- types: a1: table
    MarketplaceService:PromptGamePassPurchase(LocalPlayer, a1.SkuId)
    return nil
end

local function run(a1, a2) -- Line: 201
    -- upvalues: ReplicatedStorage (val), u50 (val), u51 (val)
    local Message, Note, Refusal, v1, v2
    for i, j in a1 do
        v2 = j(a2)
        if v2 ~= nil then
            if v2.Refusal ~= nil then
                Refusal = v2.Refusal
                Note = v2.Note
                Message = require(ReplicatedStorage.Client.Message)
                v1 = Note or u50[Refusal]
                if u51[Refusal] then
                    Message.Notice(v1)
                    return
                end
                Message.Warn(v1)
            end
            return
        end
    end
end

function v1.Request(a1, a2, a3) -- Line: 214
    -- upvalues: RunService (val), run (val), u71 (val), SpeedPacks (val), Players (val), Products (val), u80 (val)
    -- upvalues: Gamepasses (val)
    assert(RunService:IsClient(), "purchases are requested from the client")
    assert(type(a1) == "number", "PurchaseSession.Request needs a numeric SKU id")
    if not a2 then
        run(u80, {SkuId = a1, Config = Gamepasses.FromProductId(a1)})
        return
    end
    run(u71, {
        Source = a3,
        SpeedRevision = if not SpeedPacks.FindSlot(a1) then nil else Players.LocalPlayer:GetAttribute(SpeedPacks.RevisionAttribute),
        SkuId = a1,
        Config = Products.FromProductId(a1),
    })
end

return table.freeze(v1)