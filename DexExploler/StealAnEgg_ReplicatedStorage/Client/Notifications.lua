-- Script path: ReplicatedStorage.Client.Notifications
-- Decompile time: 1.43 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u9 = {}
u9.Reward = require(script.Reward)
u9.RiftSpawn = require(script.RiftSpawn)
u9.Toast = require(script.Toast)

local function channelFor(a1) -- Line: 17 -- upvalues: u9 (val)
    local v1 = u9[a1]
    if typeof(v1) == "table" and typeof(v1.Show) == "function" then
        return v1
    end
    warn((("Alerts.Raise addressed an unknown notification channel: %*"):format((tostring(a1)))))
    return nil
end

Remotes.Alerts.Raise.OnClientEvent:Connect(function(a1) -- Line: 26 -- upvalues: u9 (val)
    local v1
    if typeof(a1) ~= "table" then
        warn((("Alerts.Raise expects a request table, got %*"):format((typeof(a1)))))
        return
    end
    local Type = a1.Type
    local v2 = u9[Type]
    if typeof(v2) ~= "table" then
        warn((("Alerts.Raise addressed an unknown notification channel: %*"):format((tostring(Type)))))
        v1 = nil
    elseif typeof(v2.Show) == "function" then
        v1 = v2
    else
        warn((("Alerts.Raise addressed an unknown notification channel: %*"):format((tostring(Type)))))
        v1 = nil
    end
    if v1 ~= nil then
        local v3 = table.clone(a1)
        v3.Type = nil
        v1.Show(v3)
    end
end)
return table.freeze(u9)