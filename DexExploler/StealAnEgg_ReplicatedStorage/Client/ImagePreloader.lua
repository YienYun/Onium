-- Script path: ReplicatedStorage.Client.ImagePreloader
-- Decompile time: 2.14 ms

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local u21 = t.strict(t.string)
local u24 = t.strict(t.table)
local u25 = {}
local u26 = {}
local u28 = Log.new()
local u29 = {}

local function preload(a1) -- Line: 33
    -- upvalues: ContentProvider (val), u25 (val), u26 (val), u28 (val)
    local err, success
    local v1 = "Unknown failure"
    for i = 1, 3 do
        local u7 = nil
        success, err = pcall(function() -- Line: 37 -- upvalues: ContentProvider (upval), a1 (val), u7 (ref)
            ContentProvider:PreloadAsync({a1}, function(a1, a2) -- Line: 40 -- upvalues: u7 (upval) -- types: a1: string
                u7 = a2
            end)
        end)
        if not success then
            v1 = tostring(err)
        else
            u7 = u7 or ContentProvider:GetAssetFetchStatus(a1)
            if u7 == Enum.AssetFetchStatus.Success then
                u25[a1] = true
                u26[a1] = nil
                return
            end
            v1 = tostring(u7)
            if u7 ~= Enum.AssetFetchStatus.TimedOut then
                break
            end
        end
        if i < 3 then
            task.wait(i * 0.5)
        end
    end
    u26[a1] = nil
    ;(u28:AtWarning()):Log((("Failed to preload image %*: %*"):format(a1, v1)))
end

function u29.Request(a1) -- Line: 76
    -- upvalues: u21 (val), u25 (val), u26 (val), ContentProvider (val), preload (val)
    u21(a1)
    if a1 ~= "" and not u25[a1] and not u26[a1] then
        if (ContentProvider:GetAssetFetchStatus(a1)) == Enum.AssetFetchStatus.Success then
            u25[a1] = true
            return false
        end
        u26[a1] = true
        task.spawn(preload, a1)
        return true
    end
    return false
end

function u29.RequestAll(a1) -- Line: 92 -- upvalues: u24 (val), u29 (val) -- types: a1: table
    u24(a1)
    local v1 = 0
    for i, j in a1 do
        if u29.Request(j) then
            v1 = v1 + 1
        end
    end
    return v1
end

return table.freeze(u29)