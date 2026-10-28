-- Script path: ReplicatedStorage.CmdrClient.Commands.currentTreadmillMedia
-- Decompile time: 2.02 ms

return {
    Name = "currentTreadmillMedia",
    Description = "Print the media key and asset IDs of the treadmill or phone media currently playing for you",
    Group = "Moderator",
    Aliases = {"curVid", "curVideo"},
    Args = {},
    ClientRun = function(a1) -- Line: 8
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
        local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)

        local function findPhoneVideoAssetId() -- Line: 19 -- upvalues: Players (val)
            local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local PhoneVideoUI = if PlayerGui == nil then nil else PlayerGui:FindFirstChild("PhoneVideoUI")
            if PhoneVideoUI ~= nil and PhoneVideoUI:IsA("ScreenGui") and PhoneVideoUI.Enabled then
                local v1 = PhoneVideoUI:FindFirstChild("Phone")
                local MainVideo = if v1 == nil then nil else v1:FindFirstChild("MainVideo", true)
                if MainVideo ~= nil and MainVideo:IsA("VideoFrame") and MainVideo.Video ~= "" then
                    return string.match(MainVideo.Video, "%d+")
                end
                return nil
            end
            return nil
        end

        local v1 = "Treadmill"
        local v2 = TreadmillVideoController.GetActiveMediaEntry()
        if v2 == nil then
            local v3 = findPhoneVideoAssetId()
            if v3 ~= nil then
                v1 = "Phone"
                if (TreadmillVideoController.GetMediaEntryByKey((("Video:%*"):format(v3)))) == nil then
                    local v4 = ("Video: %* (Phone, no matching media entry)"):format(v3)
                    print((("[currentTreadmillMedia] %*"):format(v4)))
                    return v4
                end
            end
        end
        if v2 == nil then
            return "No media is currently playing (run on a treadmill or open the phone first)"
        end
        local v5 = {
            ("Key: %* (%*)"):format(TreadmillMediaIdentity.GetMediaKey(v2), v1),
            (("Kind: %* | Bucket: %* | Release: %*"):format(v2.Kind, v2.BucketType, v2.ReleaseVersion)),
        }
        if v2.Kind ~= "Video" then
            table.insert(v5, (("Image: %*"):format(v2.Image)))
            table.insert(v5, (("Sound: %*"):format(v2.SoundId)))
        else
            table.insert(v5, (("Video: %*"):format(v2.Video)))
            table.insert(v5, (("Cover: %*"):format(v2.CoverImage or "(none)")))
            local Music = v2.Music
            if Music ~= nil then
                table.insert(v5, (("Music: %*"):format(Music.SoundId)))
            end
        end
        v2 = table.concat(v5, "\n")
        print((("[currentTreadmillMedia]\n%*"):format(v2)))
        return v2
    end,
}