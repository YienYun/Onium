-- Script path: ReplicatedStorage.UserGenerated.Analytics.MicroProfilerConfig
-- Decompile time: 0.50 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
return table.freeze({
    ModuleName = "__UG_EXPOSED_LibMP",
    ContainerName = "__UG_EXPOSED_LibMPGui",
    ClientEventName = "UG.ClientMicroprofileFrame",
    ServerEventName = "UG.ServerMicroprofileFrame",
    LaggyFrameMs = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerLaggyFrameMs", Asserts.FinitePositive, 50),
    MaxFramesPerSession = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerMaxFramesPerSession", Asserts.IntegerPositive, 20),
    MinFrameInterval = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerMinFrameInterval", Asserts.FiniteNonNegative, 5),
    FramesBefore = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerFramesBefore", Asserts.IntegerNonNegative, 4),
    FramesAfter = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerFramesAfter", Asserts.IntegerNonNegative, 4),
    MaxDumpBytes = FastFlags.Replicated("UserGenerated.Analytics.MicroprofilerMaxDumpBytes", Asserts.IntegerPositive, 4194304),
})