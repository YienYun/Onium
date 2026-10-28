-- Script path: ReplicatedStorage.Client.Notifications.RareSpawnText
-- Decompile time: 4.20 ms

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.Promise)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local u27 = require(script.Translations)
local en = u27.en
local u35 = Promise.try(function() -- Line: 20 -- upvalues: LocalizationService (val), Players (val)
    return LocalizationService:GetTranslatorForPlayerAsync(Players.LocalPlayer)
end):catch(function() -- Line: 22
    return nil
end)
local u36 = {}

local function Escape(a1) -- Line: 28 -- types: a1: string
    return (string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

local function TranslateName(a1, a2) -- Line: 35 -- upvalues: Rarity (val) -- types: a1: string, a2: function
    local v1 = a2(a1)
    if v1 ~= a1 then
        return v1
    end
    for i, j in Rarity.Rarities do
        v1 = j.DisplayName .. " "
        if string.sub(a1, 1, #v1) == v1 then
            return (a2(j.DisplayName)) .. " " .. a2((string.sub(a1, #v1 + 1)))
        end
    end
    return a1
end

local function TranslateSpan(a1, a2) -- Line: 51 -- upvalues: TranslateName (val) -- types: a1: string, a2: function
    return (string.gsub(a1, "(<font color=\"#%x+\">.-</font>)", function(a1) -- Line: 55 -- upvalues: TranslateName (upval), a2 (val) -- types: a1: string
        local v1, v2 = string.match(a1, "^(<font color=\"#%x+\">)(.-)</font>$")
        assert(v1 and v2)
        return v1 .. string.gsub(string.gsub(string.gsub(TranslateName(v2, a2), "&", "&amp;"), "<", "&lt;"), ">", "&gt;") .. "</font>"
    end))
end

function u36.Parse(a1) -- Line: 67 -- types: a1: string
    local v1, v2, v3 = string.match(a1, "^A (.+) spawned in (<font color=\"#%x+\">.-</font>)(.-)!$")
    if v1 ~= nil and v2 ~= nil and v3 ~= nil then
        return {Egg = v1, Area = v2, Emoji = v3}
    end
    return nil
end

function u36.Render(a1, a2, a3) -- Line: 78
    -- upvalues: en (val), u27 (val), TranslateName (val)
    local v1 = a3(en)
    if v1 == en
        or not string.find(v1, "{Egg}", 1, true)
        or not string.find(v1, "{Area}", 1, true)
        or not string.find(v1, "{Emoji}", 1, true) then
        local v2 = string.lower(a2)
        local v3 = string.match(v2, "^[^-]+")
        v1 = u27[v2] or v3 and u27[v3] or en
    end
    return (string.gsub(v1, "{(%w+)}", {
        Egg = string.gsub(a1.Egg, "(<font color=\"#%x+\">.-</font>)", function(a1) -- Line: 55 -- upvalues: TranslateName (upval), a3 (val) -- types: a1: string
            local v1, v2 = string.match(a1, "^(<font color=\"#%x+\">)(.-)</font>$")
            assert(v1 and v2)
            return v1 .. string.gsub(string.gsub(string.gsub(TranslateName(v2, a3), "&", "&amp;"), "<", "&lt;"), ">", "&gt;") .. "</font>"
        end),
        Area = string.gsub(a1.Area, "(<font color=\"#%x+\">.-</font>)", function(a1) -- Line: 55 -- upvalues: TranslateName (upval), a3 (val) -- types: a1: string
            local v1, v2 = string.match(a1, "^(<font color=\"#%x+\">)(.-)</font>$")
            assert(v1 and v2)
            return v1 .. string.gsub(string.gsub(string.gsub(TranslateName(v2, a3), "&", "&amp;"), "<", "&lt;"), ">", "&gt;") .. "</font>"
        end),
        Emoji = string.gsub(string.gsub(string.gsub(a1.Emoji, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"),
    }))
end

function u36.Localize(a1, a2, a3) -- Line: 104
    -- upvalues: u35 (val), LocalizationService (val), u36 (val)
    local u3 = true
    u35:andThen(function(a1_2) -- Line: 110
        -- upvalues: u3 (ref), LocalizationService (upval), a2 (val), a3 (val), u36 (upval), a1 (val)
        if not u3 then
            return
        end
        local LocaleId = if not a1_2 then LocalizationService.RobloxLocaleId else a1_2.LocaleId
        a3(u36.Render(a1, LocaleId, function(a1) -- Line: 117 -- upvalues: a1_2 (val), a2 (upval) -- types: a1: string
            if a1_2 == nil then
                return a1
            end
            local success, err = pcall(a1_2.Translate, a1_2, a2, a1)
            if success then
                return err
            end
            return a1
        end))
    end)
    return function() -- Line: 127 -- upvalues: u3 (ref)
        u3 = false
    end
end

return table.freeze(u36)