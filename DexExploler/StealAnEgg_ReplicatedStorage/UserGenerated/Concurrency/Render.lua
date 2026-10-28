-- Script path: ReplicatedStorage.UserGenerated.Concurrency.Render
-- Decompile time: 1.88 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Logging = require(ReplicatedStorage.UserGenerated.Logging)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local u28 = table.freeze({
    __index = table.freeze({
        Disconnect = function(self) -- Line: 51
            self.Connection:Disconnect()
            self:OnDisconnected()
        end,
        OnDisconnected = function(self) -- Line: 56
            if self.Vars.Disconnected then
                return
            end
            self.Vars.Disconnected = true
            for i, v in ipairs(self.Callbacks) do
                task.spawn(v)
            end
            table.clear(self.Callbacks)
        end,
        Then = function(a1, a2) -- Line: 67 -- upvalues: Asserts (val)
            Asserts.Function(a2)
            if a1.Vars.Disconnected then
                task.spawn(a2)
                return
            end
            table.insert(a1.Callbacks, a2)
        end,
    }),
})

function new(a1, a2) -- Line: 79
    -- upvalues: Asserts (val), u28 (val), RunService (val), Logging (val)
    Asserts.FiniteNonNegative(a1)
    Asserts.Function(a2)
    local u16 = setmetatable({Callbacks = {}, Vars = {Disconnected = false}}, u28)
    local u17 = 0
    local u18 = nil
    u18 = RunService.RenderStepped:Connect(function(a1_2) -- Line: 94 -- upvalues: u17 (ref), a1 (val), u18 (ref), a2 (val), Logging (upval), u16 (val)
        local v1 = false
        local v2 = u17
        u17 = u17 + a1_2
        if a1 <= u17 then
            u17 = a1
            u18:Disconnect()
            v1 = true
        end
        local v3 = u17
        local v4 = u17 - v2
        local success, err = pcall(a2, if not (a1 <= u17) then u17 / a1 else 1, v3, v4)
        if not success then
            Logging.Warn("RenderError", err)
        end
        if not success or err ~= nil then
            u18:Disconnect()
            v1 = true
        end
        if v1 then
            u16:OnDisconnected()
        end
    end)
    u16.Connection = u18
    table.freeze(u16)
    return u16
end

return new