-- Script path: ReplicatedStorage.Controllers.Game.TreadmillAdPopupController.AdEggBoostClient
-- Decompile time: 2.10 ms

local AdService = game:GetService("AdService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)

local function dbg(a1) -- Line: 10 -- types: a1: string
    print("[AdEggBoostClient]", a1)
end

local AdEggBoostRemotes = ReplicatedStorage:WaitForChild("AdEggBoostRemotes", 30)
assert(AdEggBoostRemotes ~= nil, "AdEggBoostRemotes folder not found — is AdEggBoostServer running?")
local u31 = AdEggBoostRemotes:WaitForChild("AskAdGrowthBoost")
local AdGrowthBoostResult = AdEggBoostRemotes:WaitForChild("AdGrowthBoostResult")
local AdEggBoostConfigResult = AdEggBoostRemotes:WaitForChild("AdEggBoostConfigResult")
local u40 = {}
u40.AdCompleted = Signal.new()
local u44 = false
AdEggBoostConfigResult.OnClientEvent:Connect(function(a1) -- Line: 29 -- upvalues: u44 (ref)
    if a1 and a1.gated then
        u44 = true
    end
end)

function u40.IsGated() -- Line: 35 -- upvalues: u44 (ref)
    return u44
end

function u40.CheckAdAvailable() -- Line: 39 -- upvalues: AdService (val)
    local v1
    print("[AdEggBoostClient]", "CheckAdAvailable called")
    local success, err = pcall(function() -- Line: 41 -- upvalues: AdService (upval)
        return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo)
    end)
    if not success then
        v1 = "CheckAdAvailable pcall failed: " .. tostring(err)
        print("[AdEggBoostClient]", v1)
        return false
    end
    local v2 = err.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
    v1 = "CheckAdAvailable result: " .. (tostring(err.AdAvailabilityResult)) .. " -> " .. tostring(v2)
    print("[AdEggBoostClient]", v1)
    return v2
end

function u40.RequestAd() -- Line: 53 -- upvalues: u31 (val)
    print("[AdEggBoostClient]", "RequestAd called — invoking server")
    local v1, v2 = u31:InvokeServer()
    local v3 = "RequestAd server returned: ok=" .. (tostring(v1)) .. ", err=" .. tostring(v2)
    print("[AdEggBoostClient]", v3)
end

AdGrowthBoostResult.OnClientEvent:Connect(function(a1) -- Line: 60 -- upvalues: u40 (val) -- types: a1: table
    local v1 = "AdGrowthBoostResult received: completed=" .. tostring(a1.completed)
    print("[AdEggBoostClient]", v1)
    u40.AdCompleted:Fire(a1.completed == true)
end)
return u40