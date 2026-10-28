-- Script path: ReplicatedStorage.Shared.Util.SpecialLuckyBlockAsset
-- Decompile time: 5.63 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local Rank = require(ReplicatedStorage.Data.Rarity).Rarities.Secret.Rank
local u21 = {}
local v1 = CFrame.new(-17.4227905, 1.14494324, -23.6600342)
local v2 = CFrame.new(-13.1647339, 1.14494324, -28.0780945)
local v3 = CFrame.new(-7.01275635, 1.14494324, -31.1100464)
local v4 = CFrame.new(7.54925537, 1.79094315, -31.1380615)
local v5 = CFrame.new(13.3172607, 1.14494324, -28.1280518)
u21[1] = v1
u21[2] = v2
u21[3] = v3
u21[4] = v4
u21[5] = v5
u21[6] = CFrame.new(17.959259, 1.14494324, -24.9380493)
local u52 = {}

local function qualifies(a1) -- Line: 38 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local LuckyBlockDropTable = v1 and v1.LuckyBlockDropTable or nil
    local v2 = false
    if typeof(LuckyBlockDropTable) == "table" then
        v2 = #LuckyBlockDropTable > 0
    end
    return v2
end

local function stampOf(a1, a2) -- Line: 46 -- types: a1: string
    local SpecialLuckyBlockCapturedAt = a2.SpecialLuckyBlockCapturedAt
    if typeof(SpecialLuckyBlockCapturedAt) == "number" then
        return SpecialLuckyBlockCapturedAt
    end
    return string.byte(a1, 1) or 0
end

local function shelfOf(a1) -- Line: 51
    local SpecialLuckyBlockColumn = a1.SpecialLuckyBlockColumn
    local v1 = false
    if typeof(SpecialLuckyBlockColumn) == "number" then
        v1 = false
        if SpecialLuckyBlockColumn >= 1 then
            v1 = SpecialLuckyBlockColumn <= 6
        end
    end
    if v1 then
        return SpecialLuckyBlockColumn
    end
    return nil
end

local function olderFirst(a1, a2) -- Line: 57 -- types: a1: table, a2: table
    local uid = a1.uid
    local SpecialLuckyBlockCapturedAt = a1.data.SpecialLuckyBlockCapturedAt
    local v1 = if typeof(SpecialLuckyBlockCapturedAt) ~= "number" then string.byte(uid, 1) or 0 else SpecialLuckyBlockCapturedAt
    local uid_2 = a2.uid
    local SpecialLuckyBlockCapturedAt_2 = a2.data.SpecialLuckyBlockCapturedAt
    local v2 = if typeof(SpecialLuckyBlockCapturedAt_2) ~= "number" then string.byte(uid_2, 1) or 0 else SpecialLuckyBlockCapturedAt_2
    if v1 ~= v2 then
        return v1 < v2
    end
    return a1.uid < a2.uid
end

function u52.MatchesCategory(a1) -- Line: 65 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local LuckyBlockDropTable = v1 and v1.LuckyBlockDropTable or nil
    local v2 = false
    if typeof(LuckyBlockDropTable) == "table" then
        v2 = #LuckyBlockDropTable > 0
    end
    return v2
end

function u52.Matches(a1) -- Line: 67 -- upvalues: Assets (val)
    local v1 = Assets.Directory[a1.Category]
    local LuckyBlockDropTable = v1 and v1.LuckyBlockDropTable or nil
    local v2 = false
    if typeof(LuckyBlockDropTable) == "table" then
        v2 = #LuckyBlockDropTable > 0
    end
    return v2
end

function u52.Capacity() -- Line: 69
    return 36
end

function u52.ProgressGoalForCategory(a1) -- Line: 71 -- upvalues: Assets (val), Rank (val) -- types: a1: string
    local Rarity = Assets.Directory[a1].Rarity
    local Rank_2 = Rarity and Rarity.Rank
    local v1 = ("Special lucky block \"%*\" has no rarity rank"):format(a1)
    assert(typeof(Rank_2) == "number", v1)
    if Rank_2 < Rank then
        return 1
    end
    if Rank_2 == Rank then
        return 2
    end
    return 3
end

function u52.ProgressGoalFor(a1) -- Line: 82 -- upvalues: u52 (val)
    return u52.ProgressGoalForCategory(a1.Category)
end

function u52.CountHeld(a1) -- Line: 86 -- upvalues: u52 (val) -- types: a1: table
    local v1 = 0
    for k, v in pairs(a1) do
        v1 = v1 + (if not u52.Matches(v) then 0 else 1)
    end
    return v1
end

function u52.NextOpenColumn(a1, a2) -- Line: 95 -- upvalues: u52 (val) -- types: a1: table, a2: string?
    local SpecialLuckyBlockColumn, v1, v2
    local v3 = {}
    for k, v in pairs(a1) do
        if k == a2 or not u52.Matches(v) then
            v2 = nil
        else
            SpecialLuckyBlockColumn = v.SpecialLuckyBlockColumn
            v1 = false
            if typeof(SpecialLuckyBlockColumn) == "number" then
                v1 = false
                if SpecialLuckyBlockColumn >= 1 then
                    v1 = SpecialLuckyBlockColumn <= 6
                end
            end
            v2 = if not v1 then nil else SpecialLuckyBlockColumn
        end
        if v2 ~= nil then
            v3[v2] = (v3[v2] or 0) + 1
        end
    end
    local v4 = nil
    local v5 = (1 / 0)
    for i = 1, 6 do
        v2 = v3[i] or 0
        if v2 < 6 and v2 < v5 then
            v4 = i
        end
    end
    return v4
end

function u52.BuildLayout(a1, a2) -- Line: 117
    -- upvalues: u52 (val), olderFirst (val), u21 (val)
    local SpecialLuckyBlockColumn, v1, v2, v3, v4, v5
    local v6 = {}
    for k, v in pairs(a1) do
        if not u52.Matches(v) then
            v4 = nil
        else
            SpecialLuckyBlockColumn = v.SpecialLuckyBlockColumn
            v1 = false
            if typeof(SpecialLuckyBlockColumn) == "number" then
                v1 = false
                if SpecialLuckyBlockColumn >= 1 then
                    v1 = SpecialLuckyBlockColumn <= 6
                end
            end
            v4 = if not v1 then nil else SpecialLuckyBlockColumn
        end
        if v4 ~= nil then
            v5 = v6[v4] or {}
            v6[v4] = v5
            v5[#v5 + 1] = {uid = k, data = v}
        end
    end
    local v7 = {}
    for i = 1, 6 do
        v3 = v6[i]
        if v3 ~= nil then
            table.sort(v3, olderFirst)
            for j = 1, (math.min(#v3, 6)) do
                v2 = Vector3.new(0, 1, 0) * ((j - 1) * 6)
                v7[#v7 + 1] = {
                    uid = v3[j].uid,
                    data = v3[j].data,
                    column = i,
                    row = j,
                    cframe = a2 * u21[i] + v2,
                }
            end
        end
    end
    return v7
end

return u52