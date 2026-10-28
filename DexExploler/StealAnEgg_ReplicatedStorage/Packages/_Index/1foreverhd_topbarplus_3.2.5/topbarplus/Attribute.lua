-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Attribute
-- Decompile time: 0.57 ms

task.defer(function() -- Line: 21
    local RunService = game:GetService("RunService")
    local VERSION = require(script.Parent.VERSION)
    local v1 = VERSION.getAppVersion()
    local v2 = VERSION.getLatestVersion()
    local v3 = not VERSION.isUpToDate()
    if not RunService:IsStudio() then
        print((("🍍 Running TopbarPlus %* by @ForeverHD & HD Admin"):format(v1)))
    end
    if v3 then
        warn((("A new version of TopbarPlus (%*) is available: https://devforum.roblox.com/t/topbarplus/1017485"):format(v2)))
    end
end)
return {}