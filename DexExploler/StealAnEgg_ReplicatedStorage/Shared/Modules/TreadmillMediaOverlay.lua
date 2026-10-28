-- Script path: ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay
-- Decompile time: 7.42 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)

local function typecheckAssertion(a1) -- Line: 14
    return function(a1_2) -- Line: 15 -- upvalues: a1 (val)
        local v1, v2 = a1(a1_2)
        assert(v1, v2)
        return a1_2
    end
end

local function typecheckChecker(a1) -- Line: 21
    return function(a1_2) -- Line: 22 -- upvalues: a1 (val)
        local success, err = pcall(a1, a1_2)
        local v1 = success
        if success then
            return v1, nil
        end
        return v1, (tostring(err))
    end
end

require(ReplicatedStorage.Shared.Globals.Constants)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillMediaCatalog = require(ReplicatedStorage.Data.TreadmillMediaCatalog)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Media = require(ReplicatedStorage.Shared.TreadmillVideoController.Media)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local u49 = {
    Brainrot = true,
    Funny = true,
    Satisfying = true,
    WeirdOrHorror = true,
    Music = true,
}
local Replicated = FastFlags.Replicated
local boolean = t.boolean
local u55 = Replicated("Game.TreadmillDynamicMedia.Enabled", function(a1) -- Line: 15 -- upvalues: boolean (val)
    local v1, v2 = boolean(a1)
    assert(v1, v2)
    return a1
end, true)
local u56 = 0
local u57 = {}
local u58 = {}
local u59 = {}
local u60 = {}
local u61 = nil
local u62 = {}
for i, v in ipairs(Media) do
    if v.Disabled == true then
        u62[(TreadmillMediaIdentity.GetMediaKey(v))] = true
    end
end
local u75 = {}
u75.Changed = Signal.new()

local function sanitizeAddition(a1) -- Line: 94 -- upvalues: u49 (val)
    if type(a1) ~= "table" then
        return nil
    end
    if a1.Kind == "Video" and type(a1.Video) == "string" then
        if type(a1.MediaKey) == "string" and a1.MediaKey ~= "" then
            if type(a1.BucketType) == "string" and u49[a1.BucketType] == true then
                if type(a1.Duration) == "number" and not (a1.Duration <= 0) then
                    if type(a1.AddedAt) == "number" and type(a1.AddedBy) == "number" then
                        if a1.CoverImage ~= nil and type(a1.CoverImage) ~= "string" then
                            return nil
                        end
                        return {
                            Kind = "Video",
                            MediaKey = a1.MediaKey,
                            Video = a1.Video,
                            CoverImage = a1.CoverImage,
                            BucketType = a1.BucketType,
                            Duration = a1.Duration,
                            AddedAt = a1.AddedAt,
                            AddedBy = a1.AddedBy,
                        }
                    end
                    return nil
                end
                return nil
            end
            return nil
        end
        return nil
    end
    return nil
end

local function compareAdditions(a1, a2) -- Line: 129 -- types: a1: table, a2: table
    if a1.AddedAt ~= a2.AddedAt then
        return a1.AddedAt < a2.AddedAt
    end
    return a1.MediaKey < a2.MediaKey
end

local function applySanitizedSnapshot(a1) -- Line: 136
    -- upvalues: u56 (ref), u57 (ref), u59 (ref), u58 (ref), TreadmillMediaCatalog (val), u60 (val), u75 (val)
    local v1, v2
    u56 = a1.Revision
    u57 = a1.Additions
    u59 = {}
    for k in pairs(a1.Exclusions) do
        u59[k] = true
    end
    u58 = {}
    for i, v in ipairs(u57) do
        u58[v.MediaKey] = v
    end
    for i2, i3 in ipairs(u57) do
        v1 = TreadmillMediaCatalog.CURRENT_RELEASE_VERSION + i2
        v2 = u60[i3.MediaKey]
        if v2 ~= nil then
            v2.ReleaseVersion = v1
        else
            u60[i3.MediaKey] = {
                Kind = "Video",
                ReleaseVersion = v1,
                BucketType = i3.BucketType,
                Video = i3.Video,
                CoverImage = i3.CoverImage,
                Duration = i3.Duration,
            }
        end
    end
    u75.Changed:Fire()
end

function u75.SanitizeSnapshot(a1) -- Line: 175 -- upvalues: sanitizeAddition (val), compareAdditions (val)
    if type(a1) ~= "table" then
        return nil
    end
    if type(a1.Revision) == "number" and not (a1.Revision < 0) then
        local v1
        local v2 = {}
        local v3 = {}
        if type(a1.Additions) == "table" then
            for i, v in ipairs(a1.Additions) do
                v1 = sanitizeAddition(v)
                if v1 ~= nil and not v3[v1.MediaKey] then
                    v3[v1.MediaKey] = true
                    table.insert(v2, v1)
                end
            end
        end
        table.sort(v2, compareAdditions)
        v3 = {}
        if type(a1.Exclusions) == "table" then
            for k, i2 in pairs(a1.Exclusions) do
                if type(k) == "string" and type(i2) == "table" then
                    v1 = {
                        At = if type(i2.At) ~= "number" then 0 else i2.At,
                        By = if type(i2.By) ~= "number" then 0 else i2.By,
                    }
                    v3[k] = v1
                end
            end
        end
        return {Revision = math.floor(a1.Revision), Additions = v2, Exclusions = v3}
    end
    return nil
end

function u75.ApplySnapshot(a1) -- Line: 217
    -- upvalues: u75 (val), u61 (ref), u55 (val), u56 (ref), applySanitizedSnapshot (val)
    local v1 = u75.SanitizeSnapshot(a1)
    if v1 == nil then
        return
    end
    u61 = v1
    if not u55:Get() or v1.Revision == u56 then
        return
    end
    applySanitizedSnapshot(v1)
end

function u75.ApplyTo(a1) -- Line: 236
    -- upvalues: u57 (ref), TreadmillMediaIdentity (val), u60 (val)
    if #u57 == 0 then
        return 0
    end
    local v1 = {}
    for i, v in ipairs(a1) do
        v1[(TreadmillMediaIdentity.GetMediaKey(v))] = true
    end
    local v2 = 0
    for i2, i3 in ipairs(u57) do
        if not v1[i3.MediaKey] then
            v1[i3.MediaKey] = true
            table.insert(a1, u60[i3.MediaKey])
            v2 = v2 + 1
        end
    end
    return v2
end

function u75.IsExcluded(a1) -- Line: 258 -- upvalues: u62 (val), u55 (val), u59 (ref) -- types: a1: string
    if u62[a1] then
        return true
    end
    if not u55:Get() then
        return false
    end
    return u59[a1] == true
end

function u75.GetCurrentReleaseVersion() -- Line: 270 -- upvalues: TreadmillMediaCatalog (val), u57 (ref)
    return TreadmillMediaCatalog.CURRENT_RELEASE_VERSION + #u57
end

function u75.GetRevision() -- Line: 274 -- upvalues: u56 (ref)
    return u56
end

function u75.GetAdditionByKey(a1) -- Line: 276 -- upvalues: u58 (ref) -- types: a1: string
    return u58[a1]
end

function u75.GetAdditions() -- Line: 280 -- upvalues: u57 (ref)
    return u57
end

function u75.GetEntryByKey(a1) -- Line: 282 -- upvalues: u60 (val) -- types: a1: string
    return u60[a1]
end

function u75.GetReplicationSnapshot() -- Line: 286 -- upvalues: u61 (ref)
    return u61
end

u55.Changed:Connect(function() -- Line: 288 -- upvalues: u61 (ref), u55 (val), u56 (ref), applySanitizedSnapshot (val)
    local v1 = u61
    if u55:Get() and v1 ~= nil and v1.Revision ~= u56 then
        applySanitizedSnapshot(v1)
    end
end)
if RunService:IsClient() then
    (require(ReplicatedStorage.Shared.Remotes)).Treadmill.OverlaySnapshot.OnClientEvent:Connect(function(a1) -- Line: 298 -- upvalues: u75 (val)
        u75.ApplySnapshot(a1)
    end)
end
return u75