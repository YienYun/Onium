-- Script path: ReplicatedStorage.Client.UI.TreadmillStaticCover
-- Decompile time: 1.10 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local u20 = GUI.StaticTreadmillImageSurfaceGui()
assert(u20:IsA("SurfaceGui"), "Static treadmill image GUI must be a SurfaceGui")
local u28 = {}

function u28.Create(a1, a2) -- Line: 23 -- upvalues: u20 (val) -- types: a1: string, a2: userdata
    local v1 = u20:Clone()
    v1.Name = a1
    v1.Adornee = a2
    v1.Enabled = true
    v1.Parent = u20.Parent
    return v1
end

function u28.SetEnabled(a1, a2) -- Line: 35 -- types: a2: boolean
    a1.Enabled = a2
end

function u28.ApplyMedia(a1, a2) -- Line: 42 -- upvalues: TreadmillVideoController (val)
    a1.VideoFrame.Image.Image = TreadmillVideoController.ResolveCoverImage(a2)
    a1.VideoFrame.StopPlay.Image = TreadmillVideoController.GetStoppedIconImage()
    a1.VideoFrame.StopPlay.Visible = true
end

function u28.ApplyFeed(a1, a2) -- Line: 51 -- upvalues: u28 (val), TreadmillVideoController (val)
    u28.ApplyMedia(a1, TreadmillVideoController.GetCurrentMediaEntry(a2))
end

return u28