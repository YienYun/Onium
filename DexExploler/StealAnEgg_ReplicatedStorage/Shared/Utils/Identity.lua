-- Script path: ReplicatedStorage.Shared.Utils.Identity
-- Decompile time: 2.71 ms

local Players = game:GetService("Players")
local UserService = game:GetService("UserService")
local u10 = {}
local v1 = {}

local function recordOf(a1) -- Line: 22 -- upvalues: u10 (val) -- types: a1: number
    local v1 = u10[a1]
    if v1 == nil then
        u10[a1] = {Portraits = {}}
    end
    return v1
end

local function acceptName(a1, a2) -- Line: 31 -- types: a1: table
    if type(a2) == "string" and string.match(a2, "^[%w_]+$") ~= nil then
        a1.Name = a2
    end
end

local function acceptDisplayName(a1, a2) -- Line: 37 -- types: a1: table
    if type(a2) == "string" and a2 ~= "" then
        a1.DisplayName = a2
    end
end

local function learnNames(a1) -- Line: 44 -- upvalues: u10 (val), Players (val), UserService (val) -- types: a1: number
    local v1 = u10[a1]
    if v1 == nil then
        u10[a1] = {Portraits = {}}
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId ~= nil then
        v1.Name = PlayerByUserId.Name
        v1.DisplayName = PlayerByUserId.DisplayName
        return v1
    end
    local v2 = UserService:GetUserInfosByUserIdsAsync({a1})[1]
    if v2 ~= nil then
        local Username = v2.Username
        if type(Username) == "string" and string.match(Username, "^[%w_]+$") ~= nil then
            v1.Name = Username
        end
        local DisplayName = v2.DisplayName
        if type(DisplayName) == "string" and DisplayName ~= "" then
            v1.DisplayName = DisplayName
        end
    end
    return v1
end

function v1.Name(a1) -- Line: 60 -- upvalues: u10 (val), learnNames (val) -- types: a1: number
    local v1 = u10[a1]
    local Name = if v1 == nil then nil else v1.Name
    if Name == nil then
        Name = learnNames(a1).Name
    end
    return Name or error((("user %* resolved to an unusable username"):format(a1)))
end

function v1.DisplayName(a1) -- Line: 69 -- upvalues: u10 (val), learnNames (val) -- types: a1: number
    local v1 = u10[a1]
    local DisplayName = if v1 == nil then nil else v1.DisplayName
    if DisplayName == nil then
        DisplayName = learnNames(a1).DisplayName
    end
    return DisplayName or error((("no display name is available for user %*"):format(a1)))
end

function v1.Thumbnail(a1, a2, a3) -- Line: 78 -- upvalues: u10 (val), Players (val) -- types: a1: number
    local v1 = u10[a1]
    if v1 == nil then
        u10[a1] = {Portraits = {}}
    end
    local Portraits = v1.Portraits
    local v2 = Portraits[a2]
    local v3 = if v2 == nil then nil else v2[a3]
    if v3 ~= nil then
        return v3
    end
    local UserThumbnailAsync, UserThumbnailAsync_2 = Players:GetUserThumbnailAsync(a1, a2, a3)
    if type(UserThumbnailAsync) ~= "string" or string.match(UserThumbnailAsync, "^%a[%w+.-]*:") == nil then
        error((("thumbnail lookup for user %* returned no content uri"):format(a1)))
    end
    if UserThumbnailAsync_2 == true then
        if v2 == nil then
            Portraits[a2] = {}
        end
        v2[a3] = UserThumbnailAsync
    end
    return UserThumbnailAsync
end

return table.freeze(v1)