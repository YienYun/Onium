-- Script path: ReplicatedStorage.Client.UI.NotificationItemCard
-- Decompile time: 3.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local NotificationItem = require(ReplicatedStorage.Shared.NotificationItem)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Sparkles = require(ReplicatedStorage.Client.UI.VFX.Sparkles)
local u24 = {"Level", "Strength"}
local v1 = {}

local function child(a1, a2) -- Line: 25 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (("%* is missing %*"):format(a1:GetFullName(), a2)))
    return v1
end

local function countText(a1) -- Line: 31 -- upvalues: Simple (val) -- types: a1: number
    return (("%*x"):format((Simple.FormatCompact(a1))))
end

local function byPriority(a1, a2) -- Line: 35 -- types: a1: table, a2: table
    return a1.Priority < a2.Priority
end

local function describeItem(a1) -- Line: 39 -- upvalues: byPriority (val)
    local v1 = a1.Description ~= ""
    local v2 = {
        {Priority = 40, When = v1, Row = {kind = "body", text = a1.Description}},
        {Priority = 20, When = true, Row = {kind = "tier", rarity = a1.Rarity}},
        {Priority = 10, When = true, Row = {kind = "heading", text = a1.Name}},
        {Priority = 30, When = v1, Row = {kind = "rule"}},
    }
    table.sort(v2, byPriority)
    v1 = {}
    for i, j in v2 do
        if j.When then
            table.insert(v1, j.Row)
        end
    end
    return v1
end

local function applyPresentation(a1, a2, a3, a4) -- Line: 57
    -- upvalues: Simple (val), u24 (val)
    local v1
    local Icon = a1:FindFirstChild("Icon")
    assert(Icon, (("%* is missing Icon"):format((a1:GetFullName()))))
    local Quantity = a1:FindFirstChild("Quantity")
    assert(Quantity, (("%* is missing Quantity"):format((a1:GetFullName()))))
    Icon.Image = a3.Icon
    Quantity.Text = ("%*x"):format((Simple.FormatCompact(a2.Amount)))
    Quantity.Visible = a4.ShowCount ~= false
    for i, j in u24 do
        v1 = a1:FindFirstChild(j)
        if v1 and v1:IsA("GuiObject") then
            v1.Visible = false
        end
    end
end

local function sparkleWhenPlaced(a1) -- Line: 71 -- upvalues: Sparkles (val) -- types: a1: userdata
    (a1:GetPropertyChangedSignal("Parent")):Once(function() -- Line: 72 -- upvalues: a1 (val), Sparkles (upval)
        if a1.Parent ~= nil then
            task.defer(Sparkles, a1)
        end
    end)
end

function v1.Build(a1, a2) -- Line: 79
    -- upvalues: NotificationItem (val), applyPresentation (val), HoverCard (val), describeItem (val), Sparkles (val)
    assert(NotificationItem.Schema(a1), "invalid notification item card")
    local v1 = a2 or {}
    local v2 = NotificationItem.Describe(a1)
    local Rarity = v2.Rarity
    local u20 = Rarity.ItemTemplate:Clone()
    applyPresentation(u20, a1, v2, v1)
    HoverCard.Attach(u20, (describeItem(v2)))
    if v1.Sparkle ~= false then
        Sparkles(u20)
    end
    if 5 <= Rarity.Rank then
        (u20:GetPropertyChangedSignal("Parent")):Once(function() -- Line: 72 -- upvalues: u20 (val), Sparkles (upval)
            if u20.Parent ~= nil then
                task.defer(Sparkles, u20)
            end
        end)
    end
    return u20
end

return v1