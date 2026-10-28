-- Script path: ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity
-- Decompile time: 1.99 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local u22 = {}

local function extractAssetId(a1) -- Line: 23 -- types: a1: string
    local v1 = string.match(a1, "%d+")
    local v2 = false
    if v1 ~= nil then
        v2 = v1 ~= ""
    end
    assert(v2, (("Invalid treadmill media asset id \"%*\""):format(a1)))
    return v1
end

function u22.GetMediaKey(a1) -- Line: 33 -- upvalues: t (val)
    local v1, v2
    t.strict(t.table)(a1)
    if a1.Kind == "Video" then
        local Video = a1.Video
        v1 = string.match(Video, "%d+")
        v2 = false
        if v1 ~= nil then
            v2 = v1 ~= ""
        end
        assert(v2, (("Invalid treadmill media asset id \"%*\""):format(Video)))
        return (("Video:%*"):format(v1))
    end
    local Image = a1.Image
    v1 = string.match(Image, "%d+")
    v2 = false
    if v1 ~= nil then
        v2 = v1 ~= ""
    end
    assert(v2, (("Invalid treadmill media asset id \"%*\""):format(Image)))
    return (("Image:%*"):format(v1))
end

function u22.BuildMediaKeys(a1) -- Line: 43 -- upvalues: t (val), u22 (val) -- types: a1: table
    local v1
    t.strict(t.table)(a1)
    local v2 = {}
    local v3 = {}
    for i, v in ipairs(a1) do
        v1 = u22.GetMediaKey(v)
        if not v3[v1] then
            v3[v1] = true
            table.insert(v2, v1)
        end
    end
    return v2, v3
end

function u22.GetMediaKeyShardIndex(a1, a2) -- Line: 64 -- upvalues: t (val) -- types: a2: number
    t.strict(t.string)(a1)
    t.strict(t.intersection(t.integer, t.numberPositive))(a2)
    local v1 = 0
    local v2 = #a1
    for i = 1, v2 do
        v1 = (v1 * 33 + string.byte(a1, i)) % a2
    end
    return v1
end

return u22