-- Script path: ReplicatedStorage.Client.TreadmillVideoGate
-- Decompile time: 0.92 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Policy = require(ReplicatedStorage.Client.Policy)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local u18 = {}
u18.Changed = Signal.new()

function u18.IsVideoPlayerDisabled() -- Line: 22 -- upvalues: TreadmillFlags (val), Policy (val)
    if TreadmillFlags.VideoPlayerDisabled:Get() then
        return true
    end
    if not TreadmillFlags.PolicyServiceVideoEnabled:Get() then
        return false
    end
    return not Policy.IsEndlessContentLoadAllowed()
end

local u23 = u18.IsVideoPlayerDisabled()

local function update() -- Line: 38 -- upvalues: u18 (val), u23 (ref)
    local v1 = u18.IsVideoPlayerDisabled()
    if v1 == u23 then
        return
    end
    u23 = v1
    u18.Changed:Fire(v1)
end

TreadmillFlags.VideoPlayerDisabled.Changed:Connect(update)
TreadmillFlags.PolicyServiceVideoEnabled.Changed:Connect(update)
Policy.Loaded:Connect(update)
return u18