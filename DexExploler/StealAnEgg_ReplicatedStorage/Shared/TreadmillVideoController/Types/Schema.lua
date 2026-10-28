-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.Types.Schema
-- Decompile time: 1.23 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SchemaFields = require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.SchemaFields)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    TreadmillMediaBucketType = t.union(t.literal("Brainrot"), t.literal("Funny"), t.literal("Satisfying"), t.literal("WeirdOrHorror"), t.literal("Music")),
    VideoBackgroundMusic = t.strictInterface({SoundId = t.string, Volume = t.number}),
}
v1.VideoMediaEntry = t.strictInterface({
    Kind = t.literal("Video"),
    ReleaseVersion = t.number,
    BucketType = v1.TreadmillMediaBucketType,
    Video = t.string,
    CoverImage = t.optional(t.string),
    Music = t.optional(v1.VideoBackgroundMusic),
    Size = t.optional(t.UDim2),
    Volume = t.optional(t.number),
    Duration = t.optional(t.number),
    Disabled = t.optional(t.boolean),
})
v1.MusicImageMediaEntry = t.strictInterface({
    Kind = t.literal("MusicImage"),
    ReleaseVersion = t.number,
    BucketType = v1.TreadmillMediaBucketType,
    Image = t.string,
    SoundId = t.string,
    Volume = t.number,
    Duration = t.optional(t.number),
    Disabled = t.optional(t.boolean),
})
v1.TreadmillMediaEntry = t.union(v1.VideoMediaEntry, v1.MusicImageMediaEntry)
v1.TreadmillMediaEntries = t.array(v1.TreadmillMediaEntry)
v1.TreadmillMediaFeedState = SchemaFields.TreadmillMediaFeedState
return v1