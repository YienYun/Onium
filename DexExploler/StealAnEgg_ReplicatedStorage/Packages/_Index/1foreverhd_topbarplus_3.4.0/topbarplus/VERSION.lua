-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.VERSION
-- Decompile time: 1.09 ms

local u0 = {appVersion = "v3.4.0", latestVersion = nil}

function u0.getLatestVersion() -- Line: 14 -- upvalues: u0 (val)
    local err, success
    local latestVersion = u0.latestVersion
    if latestVersion then
        return latestVersion
    end
    while true do
        success, err = pcall(function() -- Line: 22
            return (game:GetService("MarketplaceService")):GetProductInfo(117501901079852)
        end)
        if not success then
            task.wait(1)
            continue
        end
        if err then
            break
        end
        task.wait(1)
    end
    local v1 = string.match(err.Name, "^TopbarPlus (.*)$")
    if v1 then
        v1 = v1:gsub("%s+", "")
    end
    u0.latestVersion = v1
    return v1
end

function u0.getAppVersion() -- Line: 39 -- upvalues: u0 (val)
    return u0.appVersion
end

function u0.isUpToDate() -- Line: 43 -- upvalues: u0 (val)
    local v1 = u0.getLatestVersion()
    local v2 = u0.getAppVersion()
    local v3 = false
    if v1 ~= nil then
        v3 = v1 == v2
    end
    return v3
end

return u0