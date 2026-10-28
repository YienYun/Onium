-- Script path: ReplicatedStorage.Shared.Modules.Environment
-- Decompile time: 2.15 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u5 = {[10563114921] = 107778070777162, [10650210095] = 135851379034158, [10737944401] = 121856883734174}
local u12 = {[10563114921] = 133470009013038, [10650210095] = 117867539925583, [10737944401] = 99280404043876}
local u19 = nil

local function inUniverse(a1) -- Line: 36 -- types: a1: number
    return game.GameId == a1
end

local function fillsRole(a1) -- Line: 40 -- upvalues: u19 (ref) -- types: a1: string
    local PlaceIds = u19.PlaceIds
    local v1 = false
    if PlaceIds ~= nil then
        v1 = PlaceIds[a1] == game.PlaceId
    end
    return v1
end

local function placesFor(a1) -- Line: 45 -- upvalues: u5 (val), u12 (val) -- types: a1: number
    local v1 = u5[a1]
    if v1 == nil then
        return nil
    end
    return {Default = v1, NewPlayerServer = u12[a1]}
end

local v1 = {}
local GameId = game.GameId
local v2 = u5[GameId]
v1.PlaceIds = if v2 ~= nil then {Default = v2, NewPlayerServer = u12[GameId]} else nil

function v1.GetPlaceIds() -- Line: 57 -- upvalues: u19 (ref)
    return u19.PlaceIds
end

function v1.IsDevPlace() -- Line: 59
    return game.GameId == 10650210095
end

function v1.IsTestPlace() -- Line: 61
    return game.GameId == 10737944401
end

function v1.IsDev3Place() -- Line: 63
    return game.GameId == 10767176144
end

function v1.IsRecordingPlace() -- Line: 65
    return game.GameId == 10771290130
end

function v1.IsQAPurchasesEnabled() -- Line: 70 -- upvalues: ReplicatedStorage (val)
    return if game.GameId == 10650210095 then ReplicatedStorage:GetAttribute("QA_PURCHASES") == true else if game.GameId == 10737944401 then ReplicatedStorage:GetAttribute("QA_PURCHASES") == true else game.GameId == 10767176144 and ReplicatedStorage:GetAttribute("QA_PURCHASES") == true
end

function v1.GetEnvironmentName() -- Line: 79
    if game.GameId == 10563114921 then
        return "prod"
    end
    if game.GameId == 10737944401 then
        return "test"
    end
    return "dev"
end

function v1.IsDefaultPlace() -- Line: 89 -- upvalues: u19 (ref)
    local PlaceIds = u19.PlaceIds
    local v1 = false
    if PlaceIds ~= nil then
        v1 = PlaceIds.Default == game.PlaceId
    end
    return v1
end

function v1.IsNewPlayerServer() -- Line: 91 -- upvalues: u19 (ref)
    local PlaceIds = u19.PlaceIds
    local v1 = false
    if PlaceIds ~= nil then
        v1 = PlaceIds.NewPlayerServer == game.PlaceId
    end
    return v1
end

return v1