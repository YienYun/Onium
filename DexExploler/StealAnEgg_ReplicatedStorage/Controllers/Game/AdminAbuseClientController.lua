-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController
-- Decompile time: 2.07 ms

game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(game:GetService("ReplicatedStorage").Shared.Remotes)
return {
    Start = function() -- Line: 23 -- upvalues: Remotes (val), Workspace (val)
        local u0 = {}
        local u65 = {}
        for i, j in script.Events:GetChildren() do
            if j:IsA("ModuleScript") then
                xpcall(function() -- Line: 39 -- upvalues: u65 (val), j (val)
                    u65[j.Name] = (require(j))
                end, function(a1) -- Line: 40
                    warn((("[%*] %*"):format(script.Name, a1)))
                end)
            end
        end
        Remotes.LiveEvents.Began.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 45 -- upvalues: u0 (val), u65 (val) -- types: a1: string, a2: number
            local u5 = os.time() + a2
            u0[a1] = u5
            if not u65[a1] then
                return
            end
            u65[a1]:StartEvent(a2, a3)
            task.delay(a2, function() -- Line: 55 -- upvalues: u0 (upval), a1 (val), u5 (val), u65 (upval)
                if u0[a1] ~= u5 then
                    return
                end
                u65[a1]:StopEvent()
                u0[a1] = nil
            end)
        end)
        Remotes.LiveEvents.Ended.OnClientEvent:Connect(function(a1) -- Line: 65 -- upvalues: u0 (val), u65 (val) -- types: a1: string
            u0[a1] = nil
            if not u65[a1] then
                return
            end
            u65[a1]:StopEvent()
        end)
        local v1, v2 = Remotes.LiveEvents.FetchRunning:InvokeServer()
        local v3 = nil
        local v4 = nil
        for k, n in v1, v3, v4 do
            if u65[k] then
                local u55 = v2[k]
                if not u55 then
                    u55 = {}
                end
                local u61 = n - Workspace:GetServerTimeNow()
                task.spawn(function() -- Line: 80 -- upvalues: u55 (val), u65 (val), k (val), u61 (val)
                    u55.WasInProgress = true
                    u65[k]:StartEvent(u61, u55)
                end)
            end
        end
    end,
}