-- Script path: ReplicatedStorage.Shared.Modules.ProfileDefaults
-- Decompile time: 0.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = require(script.Defaults)
local Schema = require(script.Types.Schema)

local function verifyAuthoredProfile(a1) -- Line: 9 -- upvalues: Schema (val)
    local v1, v2 = Schema(a1)
    if not v1 then
        error(("ProfileDefaults.Defaults violates the profile schema: %*"):format(v2), 0)
    end
end

if Constants.IS_STUDIO then
    local v2, v3 = Schema(v1)
    if not v2 then
        error(("ProfileDefaults.Defaults violates the profile schema: %*"):format(v3), 0)
    end
end
return v1