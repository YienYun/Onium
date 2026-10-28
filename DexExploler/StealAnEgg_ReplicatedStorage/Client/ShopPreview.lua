-- Script path: ReplicatedStorage.Client.ShopPreview
-- Decompile time: 2.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local HalloweenEggSettings = require(ReplicatedStorage.Data.HalloweenEggSettings)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u32 = "off"
local u33 = {}
u33.Changed = Signal.new()

function u33.IsActive() -- Line: 12 -- upvalues: u32 (ref)
    return u32 ~= "off"
end

function u33.Mode() -- Line: 16 -- upvalues: u32 (ref)
    return u32
end

function u33.Config() -- Line: 20 -- upvalues: LimitedEgg (val), u32 (ref)
    local v1 = LimitedEgg.Active()
    if u32 == "before" then
        return LimitedEgg.Extinction
    end
    if u32 == "after" then
        return LimitedEgg.Halloween
    end
    return v1
end

function u33.Time() -- Line: 30 -- upvalues: u32 (ref), HalloweenEggSettings (val), Workspace (val)
    if u32 == "before" then
        return HalloweenEggSettings.StartsAt - 1
    end
    if u32 == "after" then
        return HalloweenEggSettings.StartsAt
    end
    return Workspace:GetServerTimeNow()
end

function u33.IsHalloween() -- Line: 39 -- upvalues: u33 (val), LimitedEgg (val)
    return u33.Config() == LimitedEgg.Halloween
end

function u33.Set(a1) -- Line: 43
    -- upvalues: RunService (val), Environment (val), u32 (ref), u33 (val), HalloweenEggSettings (val)
    if not RunService:IsStudio() and not Environment.IsDevPlace() and not Environment.IsTestPlace() then
        return false, "Shop preview is available only in DEV, TEST or Studio."
    end
    local v1 = string.lower(a1)
    local v2 = {old = "before", new = "after", live = "off"}
    v1 = v2[v1] or v1
    if v1 ~= "before" and v1 ~= "after" and v1 ~= "off" then
        return false, "Use shopPreview before, after or off."
    end
    if v1 ~= u32 then
        u32 = v1
        u33.Changed:Fire()
    end
    if u32 == "off" then
        return true, "Normal automatic shop restored."
    end
    v1 = DateTime.fromUnixTimestamp(HalloweenEggSettings.StartsAt):FormatUniversalTime("YYYY-MM-DD HH:mm", "en-us")
    return true, string.format(
        "%s preview (%s the %s UTC switch). Egg purchases disabled. Close the shop or use shopPreview off to restore.",
        u33.Config().DisplayName,
        u32,
        v1
    )
end

return u33