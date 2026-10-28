-- Script path: ReplicatedStorage.Shared.Util.AssetGender
-- Decompile time: 0.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local u14 = {Male = "rbxassetid://88627876961976", Female = "rbxassetid://98782480225988"}
local u15 = {}

function u15.BadgeImage(a1) -- Line: 18 -- upvalues: u14 (val)
    return u14[a1] or "rbxassetid://98782480225988"
end

function u15.IsTag(a1) -- Line: 22
    local v1 = true
    if a1 ~= "Male" then
        v1 = a1 == "Female"
    end
    return v1
end

function u15.Draw(a1) -- Line: 26 -- types: a1: userdata?
    if (a1 or Random.new()):NextInteger(1, 2) == 1 then
        return "Male"
    end
    return "Female"
end

function u15.Settle(a1, a2, a3) -- Line: 31
    -- upvalues: u15 (val), Assets (val)
    if u15.IsTag(a2) then
        return a2
    end
    local GenderLocked = Assets.Directory[a1].GenderLocked
    if u15.IsTag(GenderLocked) then
        return GenderLocked
    end
    return (u15.Draw(a3))
end

return u15