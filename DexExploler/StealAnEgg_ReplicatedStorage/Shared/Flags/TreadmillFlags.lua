-- Script path: ReplicatedStorage.Shared.Flags.TreadmillFlags
-- Decompile time: 0.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    CommentsDisabled = FastFlags.Replicated("Game.Treadmill.CommentsDisabled", Asserts.Boolean, true),
    VideoPlayerDisabled = FastFlags.Replicated("Game.Treadmill.VideoPlayerDisabled", Asserts.Boolean, true),
    CameraAutoFrameDisabled = FastFlags.Replicated("Game.Treadmill.CameraAutoFrameDisabled", Asserts.Boolean, true),
    PolicyServiceVideoEnabled = FastFlags.Replicated("Game.Treadmill.PolicyServiceVideoEnabled", Asserts.Boolean, true),
    PhoneEnabled = FastFlags.Replicated("Game.Treadmill.PhoneEnabled", Asserts.Boolean, false),
})