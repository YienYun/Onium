-- Script path: ReplicatedStorage.Shared.Utils.Marketplace
-- Decompile time: 1.99 ms

local MarketplaceService = game:GetService("MarketplaceService")
local u5 = {[true] = 600, [false] = 300}
local u10 = {}
local u11 = {}

local function slotFor(a1, a2) -- Line: 23 -- upvalues: u10 (val) -- types: a1: number
    local v1 = ("marketplace id must be a number, got %*"):format((typeof(a1)))
    assert(type(a1) == "number", v1)
    local v2 = ("%*:%*"):format(a2.Value, a1)
    local v3 = u10[v2]
    if v3 == nil then
        u10[v2] = {Answered = false, HoldUntil = 0}
    end
    return v3
end

local function ask(a1, a2, a3) -- Line: 34
    -- upvalues: MarketplaceService (val), u5 (val)
    local success, err = pcall(MarketplaceService.GetProductInfo, MarketplaceService, a2, a3)
    a1.Answered = success
    a1.HoldUntil = os.clock() + u5[success]
    if success then
        a1.Value = err
        return
    end
    warn((("marketplace info unavailable for %* %*: %*"):format(a3.Name, a2, err)))
end

local function trusted(a1, a2, a3) -- Line: 45 -- upvalues: ask (val) -- types: a1: table, a2: number
    if a1.HoldUntil <= (os.clock()) then
        ask(a1, a2, a3)
    end
    return a1.Answered
end

function u11.Info(a1, a2) -- Line: 53 -- upvalues: slotFor (val), ask (val) -- types: a1: number
    local Product = a2 or Enum.InfoType.Product
    local v1 = slotFor(a1, Product)
    if v1.HoldUntil <= (os.clock()) then
        ask(v1, a1, Product)
    end
    local Answered = v1.Answered
    return v1.Value
end

function u11.Current(a1, a2) -- Line: 61 -- upvalues: slotFor (val), ask (val) -- types: a1: number
    local Product = a2 or Enum.InfoType.Product
    local v1 = slotFor(a1, Product)
    if v1.HoldUntil <= (os.clock()) then
        ask(v1, a1, Product)
    end
    if v1.Answered then
        return v1.Value
    end
    return nil
end

function u11.Price(a1, a2) -- Line: 67 -- upvalues: u11 (val) -- types: a1: number
    local v1 = u11.Info(a1, a2)
    if type(v1) == "table" and v1.IsForSale == true then
        local PriceInRobux = v1.PriceInRobux
        if type(PriceInRobux) == "number" then
            return PriceInRobux
        end
        return nil
    end
    return nil
end

return table.freeze(u11)