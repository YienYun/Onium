-- Script path: ReplicatedStorage.Client.SystemChat
-- Decompile time: 1.86 ms

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u19 = {}
local TextChannel = Instance.new("TextChannel")
TextChannel.Name = "GameSystem"
TextChannel.Parent = TextChatService

local function markup(a1) -- Line: 22
    local Color = a1.Color
    if Color == nil then
        return a1.Text
    end
    return (("<font color=\"#%*\">%*</font>"):format(Color:ToHex(), a1.Text))
end

local function metadata(a1) -- Line: 32 -- upvalues: HttpService (val)
    local Rarity = a1.Rarity
    if Rarity == nil then
        return ""
    end
    return HttpService:JSONEncode({rarity = Rarity})
end

local function accept(a1) -- Line: 41
    if typeof(a1) == "table" and typeof(a1.Text) == "string" then
        local Color = a1.Color
        local Rarity = a1.Rarity
        return {
            Text = a1.Text,
            Color = if typeof(Color) ~= "Color3" then nil else Color,
            Rarity = if typeof(Rarity) ~= "string" then nil else Rarity,
        }
    end
    return nil
end

function u19.Post(a1) -- Line: 54 -- upvalues: TextChannel (val), metadata (val)
    local Color = a1.Color
    TextChannel:DisplaySystemMessage(
        if Color ~= nil then ("<font color=\"#%*\">%*</font>"):format(Color:ToHex(), a1.Text) else a1.Text,
        (metadata(a1))
    )
end

Remotes.ChatFeed.Post.OnClientEvent:Connect(function(a1) -- Line: 58 -- upvalues: accept (val), u19 (val)
    local v1 = accept(a1)
    if v1 ~= nil then
        u19.Post(v1)
    end
end)
return table.freeze(u19)