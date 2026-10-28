-- Script path: ReplicatedStorage.Client.ChatDecorations
-- Decompile time: 3.97 ms

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Staff = require(ReplicatedStorage.Shared.Modules.Staff)
local u32 = Color3.fromHex("FFC700")
local u37 = Color3.new(1, 1, 1)
local u38 = {Divine = true, Eternal = true, Secret = true}

local function tinted(a1, a2) -- Line: 27 -- types: a1: string, a2: userdata
    return (("<font color=\"#%*\">%*</font>"):format(a2:ToHex(), a1))
end

local function freshProperties() -- Line: 31 -- upvalues: TextChatService (val)
    return TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
end

local function badgesFor(a1) -- Line: 36 -- upvalues: Players (val), Staff (val), u32 (val) -- types: a1: userdata?
    local PlayerByUserId
    local v1 = {}
    if (if a1 == nil then nil else Players:GetPlayerByUserId(a1.UserId)) == nil then
        return v1
    end
    local Attribute = PlayerByUserId:GetAttribute("CreatorDisguiseUserId")
    local v2 = Staff.ChatTag(if typeof(Attribute) ~= "number" then PlayerByUserId.UserId else Attribute)
    if v2 ~= nil then
        table.insert(v1, v2)
    end
    if Attribute == nil and PlayerByUserId:GetAttribute("MonetizationVipProductOwned") == true then
        table.insert(v1, (("<font color=\"#%*\">[VIP-OG]</font>"):format((u32:ToHex()))))
    end
    return v1
end

local function speakerName(a1) -- Line: 55 -- upvalues: Players (val) -- types: a1: userdata
    local TextSource = a1.TextSource
    local PlayerByUserId = if TextSource == nil then nil else Players:GetPlayerByUserId(TextSource.UserId)
    local v1 = if PlayerByUserId == nil then nil else PlayerByUserId:GetAttribute("CreatorDisguiseName")
    if PlayerByUserId ~= nil and typeof(v1) == "string" then
        return (string.gsub(a1.PrefixText, string.gsub(PlayerByUserId.DisplayName, "%p", "%%%0"), string.gsub(v1, "%%", "%%%%"), 1))
    end
    return nil
end

local function rarityIn(a1) -- Line: 68 -- upvalues: HttpService (val) -- types: a1: string
    if a1 == "" then
        return nil
    end
    local success, err = pcall(HttpService.JSONDecode, HttpService, a1)
    if success and typeof(err) == "table" then
        return err.rarity
    end
    return nil
end

local function shineFor(a1) -- Line: 76 -- upvalues: HttpService (val), u38 (val), Rarity (val) -- types: a1: string
    local rarity
    if a1 ~= "" then
        local success, err = pcall(HttpService.JSONDecode, HttpService, a1)
        rarity = if not success then nil else if typeof(err) ~= "table" then nil else err.rarity
    else
        rarity = nil
    end
    local v1 = if rarity == nil then nil else if not u38[rarity] then nil else Rarity.Rarities[rarity]
    if v1 ~= nil then
        return v1.RarityGradient
    end
    return nil
end

function TextChatService.OnIncomingMessage(a1) -- Line: 82
    -- upvalues: badgesFor (val), HttpService (val), u38 (val), Rarity (val), speakerName (val), TextChatService (val)
    -- upvalues: u37 (val)
    local RarityGradient, rarity, v1, v2
    local v3 = badgesFor(a1.TextSource)
    local Metadata = a1.Metadata
    if Metadata ~= "" then
        local success, err = pcall(HttpService.JSONDecode, HttpService, Metadata)
        rarity = if not success then nil else if typeof(err) ~= "table" then nil else err.rarity
    else
        rarity = nil
    end
    local v4 = if rarity == nil then nil else if not u38[rarity] then nil else Rarity.Rarities[rarity]
    if (if v4 == nil then nil else v4.RarityGradient) == nil then
        v1 = speakerName(a1)
        if #v3 == 0 and v1 == nil then
            return nil
        end
        v2 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
        v2.PrefixText = if not (#v3 > 0) then v1 or a1.PrefixText else ("%* %*"):format(table.concat(v3, " "), v1 or a1.PrefixText)
        return v2
    end
    v1 = string.gsub(a1.Text, "!", "")
    if #v3 > 0 then
        v1 = ("%* %*"):format(table.concat(v3, " "), v1)
    end
    v3 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
    v3.TextColor3 = u37
    v2 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
    v2.PrefixText = v1
    v2.PrefixTextProperties = v3
    v2.Text = "!"
    v2.TextColor3 = u37
    local u110 = RarityGradient:Clone()
    u110.Parent = v3
    a1.ChatWindowMessageProperties = v2
    task.delay(10, function() -- Line: 117 -- upvalues: u110 (val)
        u110.Enabled = false
    end)
    return v2
end

return table.freeze({})