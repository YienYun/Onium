-- Script path: ReplicatedStorage.Shared.Util.OnboardingTiming
-- Decompile time: 0.99 ms

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u10 = {}
local u14 = setmetatable({}, {__mode = "k"})
return {
    Mark = function(a1, a2, a3) -- Line: 9
        -- upvalues: RunService (val), Workspace (val), u10 (val), u14 (val)
        if not RunService:IsStudio() and Workspace:GetAttribute("TraceOnboarding") ~= true then
            return
        end
        local v1 = u10
        if a2 then
            if u14[a2] == nil then
                u14[a2] = {}
            end
            v1 = u14[a2]
        end
        if v1[a1] then
            return
        end
        v1[a1] = true
        local v2 = if not a3 then "" else string.format(" duration=%.3fs", a3)
        local v3 = print
        local format = string.format
        local ServerTimeNow = Workspace:GetServerTimeNow()
        v3(format(
            "[OnboardingTiming][%s] %s serverTime=%.3f%s",
            if not RunService:IsServer() then "Client" else "Server",
            a1,
            ServerTimeNow,
            v2
        ))
    end,
}