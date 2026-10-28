-- Script path: ReplicatedStorage.Data.TreadmillMediaCatalog
-- Decompile time: 0.39 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
return {
    BASELINE_RELEASE_VERSION = 1,
    BASELINE_MEDIA_COUNT = 246,
    CURRENT_RELEASE_VERSION = 3,
    ResolveEntryReleaseVersion = function(a1) -- Line: 22 -- upvalues: t (val) -- types: a1: number
        t.strict(t.intersection(t.integer, t.numberPositive))(a1)
        return a1
    end,
}