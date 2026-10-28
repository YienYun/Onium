-- Script path: ReplicatedStorage.Controllers.Game.StarHandlerController.Shop
-- Decompile time: 9.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Marketplace = require(ReplicatedStorage.Shared.Utils.Marketplace)
local Save = require(ReplicatedStorage.Shared.Save)
local StarBundles = require(ReplicatedStorage.Data.StarBundles)
local StarHandlerFlags = require(ReplicatedStorage.Shared.Flags.StarHandlerFlags)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local u52 = {"StarsSectionTitle", "DailyStockLabel", "Cards", "RestockTimer"}
local u57 = false
local u58 = nil
local u59 = {}

local function frame() -- Line: 37 -- upvalues: GUI (val)
    return GUI.Shop():FindFirstChild("Frame")
end

local function list() -- Line: 41 -- upvalues: GUI (val)
    local Frame = GUI.Shop():FindFirstChild("Frame")
    return Frame and Frame:FindFirstChild("ScrollingFrame")
end

local function cards() -- Line: 46 -- upvalues: GUI (val)
    local Frame = GUI.Shop():FindFirstChild("Frame")
    local v1 = Frame and Frame:FindFirstChild("ScrollingFrame")
    local Cards = v1 and v1:FindFirstChild("Cards")
    v1 = {}
    if Cards then
        for i, j in Cards:GetChildren() do
            if j:IsA("GuiObject") and j:GetAttribute("Bundle") ~= nil then
                table.insert(v1, j)
            end
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 57
        return a1.LayoutOrder < a2.LayoutOrder
    end)
    return v1
end

local function bundleFor(a1) -- Line: 63 -- upvalues: StarBundles (val)
    for i, j in StarBundles.Bundles do
        if j.Key == a1 then
            return j
        end
    end
    return nil
end

local function priceLabel(a1) -- Line: 72 -- types: a1: userdata
    local Btns = a1:FindFirstChild("Btns")
    local Buy = Btns and Btns:FindFirstChild("Buy")
    local v1 = Buy and Buy:FindFirstChild("Price")
    if v1 and v1:IsA("TextLabel") then
        return v1
    end
    return nil
end

local function refreshPrices() -- Line: 79 -- upvalues: cards (val), StarBundles (val), Marketplace (val)
    local Attribute, Btns, Buy, v1
    for i, j in cards() do
        Attribute = j:GetAttribute("Bundle")
        for k, n in StarBundles.Bundles do
            if n.Key == Attribute then
                local u26 = n
                Btns = j:FindFirstChild("Btns")
                Buy = Btns and Btns:FindFirstChild("Buy")
                v1 = Buy and Buy:FindFirstChild("Price")
                if not v1 or not v1:IsA("TextLabel") then
                    u54 = nil
                else
                    local u54 = v1
                end
                if u26 and u54 then
                    u54.Text = "..."
                    task.spawn(function() -- Line: 85 -- upvalues: Marketplace (upval), StarBundles (upval), u26 (val), u54 (val)
                        local v1 = Marketplace.Price(StarBundles.ProductIdFor(u26), Enum.InfoType.Product)
                        if v1 ~= nil then
                            u54.Text = "" .. tostring(v1)
                        end
                    end)
                end
                break
            end
        end
        u26 = nil
        Btns = j:FindFirstChild("Btns")
        Buy = Btns and Btns:FindFirstChild("Buy")
        v1 = Buy and Buy:FindFirstChild("Price")
        if not v1 or not v1:IsA("TextLabel") then
            u54 = nil
        else
            local u54 = v1
        end
        if u26 and u54 then
            u54.Text = "..."
            task.spawn(function() -- Line: 85 -- upvalues: Marketplace (upval), StarBundles (upval), u26 (val), u54 (val)
                local v1 = Marketplace.Price(StarBundles.ProductIdFor(u26), Enum.InfoType.Product)
                if v1 ~= nil then
                    u54.Text = "" .. tostring(v1)
                end
            end)
        end
    end
end

local function clock(a1) -- Line: 96 -- types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    local v2 = v1 // 86400
    local v3 = v1 // 3600 % 24
    local v4 = v1 // 60 % 60
    local v5 = v1 % 60
    if v2 > 0 then
        return (("%*d %*hr"):format(v2, v3))
    end
    if v3 > 0 then
        return (("%*hr %*m"):format(v3, v4))
    end
    if v4 > 0 then
        return (("%*m %*s"):format(v4, v5))
    end
    return (("%*s"):format(v5))
end

local function refreshStock() -- Line: 110
    -- upvalues: GUI (val), Workspace (val), Save (val), StarBundles (val), clock (val)
    local Frame = GUI.Shop():FindFirstChild("Frame")
    local v1 = Frame and Frame:FindFirstChild("ScrollingFrame")
    if v1 == nil then
        return
    end
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v2 = Save.Peek()
    local v3 = StarBundles.Remaining(if not v2 then nil else v2.MountStarStock, ServerTimeNow)
    v2 = v1:FindFirstChild("DailyStockLabel")
    if v2 and v2:IsA("TextLabel") then
        v2.Text = ("Weekly Stock: %*/%*"):format(v3, (StarBundles.WeeklyLimit()))
    end
    local RestockTimer = v1:FindFirstChild("RestockTimer")
    if RestockTimer and RestockTimer:IsA("TextLabel") then
        RestockTimer.Text = ("Restocks in %*"):format((clock((StarBundles.NextRestockAt(ServerTimeNow)) - ServerTimeNow)))
    end
end

local function tick() -- Line: 128 -- upvalues: u58 (ref), RunService (val), Tabs (val), refreshStock (val)
    if u58 then
        return
    end
    local u1 = 1
    RunService.Heartbeat:Connect(function(a1) -- Line: 133 -- upvalues: Tabs (upval), u58 (upval), u1 (ref), refreshStock (upval) -- types: a1: number
        if not Tabs.IsActive("Shop") then
            if u58 then
                u58:Disconnect()
                u58 = nil
            end
            return
        end
        u1 = u1 + a1
        if u1 < 1 then
            return
        end
        u1 = 0
        refreshStock()
    end)
end

local function present() -- Line: 150 -- upvalues: StarHandlerFlags (val), GUI (val), u52 (val)
    local v1 = StarHandlerFlags.ShouldReveal()
    local Frame = GUI.Shop():FindFirstChild("Frame")
    local v2 = Frame and Frame:FindFirstChild("ScrollingFrame")
    if v2 then
        local v3
        for i, j in u52 do
            v3 = v2:FindFirstChild(j)
            if v3 and v3:IsA("GuiObject") then
                v3.Visible = v1
            end
        end
    end
    local Frame_2 = GUI.Shop():FindFirstChild("Frame")
    local ButtonsHolder = Frame_2 and Frame_2:FindFirstChild("ButtonsHolder")
    v2 = ButtonsHolder and ButtonsHolder:FindFirstChild("Stars")
    if v2 and v2:IsA("GuiObject") then
        v2.Visible = v1
    end
end

local function wire() -- Line: 169 -- upvalues: cards (val), StarBundles (val), ButtonFX (val), Storefront (val)
    local Attribute, Btns, Buy, Title, v1
    for i, j in cards() do
        Attribute = j:GetAttribute("Bundle")
        for k, n in StarBundles.Bundles do
            if n.Key == Attribute then
                v1 = n
                Title = j:FindFirstChild("Title")
                if v1 and Title and Title:IsA("TextLabel") then
                    Title.Text = if v1.Count ~= 1 then ("%* STARS"):format(v1.Count) else "1 STAR"
                end
                Btns = j:FindFirstChild("Btns")
                Buy = Btns and Btns:FindFirstChild("Buy")
                if v1 and Buy and Buy:IsA("GuiButton") then
                    local u73 = StarBundles.ProductIdFor(v1)
                    ButtonFX(Buy, nil, function() -- Line: 180 -- upvalues: Storefront (upval), u73 (val)
                        Storefront.Prompt(u73, true)
                    end)
                end
                break
            end
        end
        v1 = nil
        Title = j:FindFirstChild("Title")
        if v1 and Title and Title:IsA("TextLabel") then
            Title.Text = if v1.Count ~= 1 then ("%* STARS"):format(v1.Count) else "1 STAR"
        end
        Btns = j:FindFirstChild("Btns")
        Buy = Btns and Btns:FindFirstChild("Buy")
        if v1 and Buy and Buy:IsA("GuiButton") then
            local u73 = StarBundles.ProductIdFor(v1)
            ButtonFX(Buy, nil, function() -- Line: 180 -- upvalues: Storefront (upval), u73 (val)
                Storefront.Prompt(u73, true)
            end)
        end
    end
end

function u59.Initialize() -- Line: 191
    -- upvalues: u57 (ref), wire (val), present (val), refreshStock (val), StarHandlerFlags (val), Tabs (val)
    -- upvalues: refreshPrices (val), u58 (ref), RunService (val), Save (val)
    if u57 then
        return
    end
    u57 = true
    wire()
    present()
    refreshStock()
    StarHandlerFlags.Open.Changed:Connect(present)
    StarHandlerFlags.ForceRevealed.Changed:Connect(present)
    StarHandlerFlags.WeeklyLimit.Changed:Connect(refreshStock)
    Tabs.Activated:Connect(function(a1) -- Line: 202
        -- upvalues: refreshPrices (upval), refreshStock (upval), u58 (upval), RunService (upval), Tabs (upval)
        if a1 == "Shop" then
            refreshPrices()
            refreshStock()
            if u58 then
                return
            end
            local u6 = 1
            RunService.Heartbeat:Connect(function(a1) -- Line: 133 -- upvalues: Tabs (upval), u58 (upval), u6 (ref), refreshStock (upval) -- types: a1: number
                if not Tabs.IsActive("Shop") then
                    if u58 then
                        u58:Disconnect()
                        u58 = nil
                    end
                    return
                end
                u6 = u6 + a1
                if u6 < 1 then
                    return
                end
                u6 = 0
                refreshStock()
            end)
        end
    end)
    ;(Save.Watch("MountStarStock")):Connect(function() -- Line: 209 -- upvalues: refreshStock (upval)
        refreshStock()
    end)
    task.spawn(function() -- Line: 212 -- upvalues: Save (upval), refreshStock (upval)
        Save.Await()
        refreshStock()
    end)
end

function u59.Open() -- Line: 218 -- upvalues: u59 (val), ReplicatedStorage (val)
    u59.Initialize()
    require(ReplicatedStorage.Client.ShopNavigation).Open("Stars")
end

function u59.Close() -- Line: 224 -- upvalues: Tabs (val)
    if Tabs.IsActive("Shop") then
        Tabs.Deactivate()
    end
end

return u59