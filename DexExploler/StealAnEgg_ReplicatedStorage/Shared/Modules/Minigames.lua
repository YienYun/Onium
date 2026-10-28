-- Script path: ReplicatedStorage.Shared.Modules.Minigames
-- Decompile time: 2.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local u24 = table.freeze({"CaptureTheEgg", "RedLightGreenLight", "TrexRun"})
local u26 = Log.new()
return table.freeze({
    Names = u24,
    IsMinigame = function(a1) -- Line: 37 -- upvalues: u24 (val) -- types: a1: string
        return table.find(u24, a1) ~= nil
    end,
    ResolveEgg = function(a1, a2, a3) -- Line: 41
        -- upvalues: Assets (val), u26 (val), Mutations (val)
        local v1
        local v2 = {Carry = a2, Reward = a3}
        local EggCategory = (if type(a1) ~= "table" then {} else a1).EggCategory
        if type(EggCategory) == "string" and EggCategory ~= "" then
            local v3, v4 = Assets.AssetNameExists(EggCategory)
            if not v3 then
                (u26:AtWarning()):Log((("[Minigames] %*"):format(v4)))
            else
                v2.Carry = EggCategory
                v2.Reward = EggCategory
            end
        end
        local Mutation = v1.Mutation
        if type(Mutation) == "string" and Mutation ~= "" and Mutations.Get(Mutation) ~= nil then
            v2.Mutation = Mutation
        end
        return v2
    end,
    EggIcon = function(a1, a2) -- Line: 79 -- upvalues: Assets (val) -- types: a1: string, a2: string
        local v1 = Assets.Directory[a1]
        local Icon = if v1 == nil then nil else v1.Egg.Icon
        if Icon ~= nil and Icon ~= "" then
            return Icon
        end
        return a2
    end,
    EggLabel = function(a1, a2, a3) -- Line: 90
        -- upvalues: Assets (val), Mutations (val)
        local v1 = Assets.Directory[a1]
        if v1 == nil then
            return a3
        end
        local v2 = ("<font color=\"#%*\">%*</font>"):format(v1.Rarity.Color:ToHex(), v1.Egg.DisplayName)
        if a2 ~= nil then
            v1 = Mutations.Get(a2)
            if v1 ~= nil then
                v2 = ("<font color=\"#%*\">%*</font> %*"):format(v1.Tint:ToHex(), v1.Label, v2)
            end
        end
        return v2
    end,
    EscapeRichText = function(a1) -- Line: 112 -- types: a1: string
        return (((a1:gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;"))
    end,
})