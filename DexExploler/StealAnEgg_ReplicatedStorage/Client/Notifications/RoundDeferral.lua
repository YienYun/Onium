-- Script path: ReplicatedStorage.Client.Notifications.RoundDeferral
-- Decompile time: 3.20 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u14 = {Loading = true, InProgress = true, RoundEnd = true}
local u15 = {}
local LocalPlayer = Players.LocalPlayer
local u17 = false

local function roundState() -- Line: 20 -- upvalues: LocalPlayer (val)
    return LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
end

local function recompute(a1) -- Line: 26 -- upvalues: LocalPlayer (val), u17 (ref) -- types: a1: boolean?
    local v1
    local v2 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if a1 == nil then
        v1 = false
        if LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil then
            v1 = v2 ~= "Waiting"
        end
    else
        v1 = a1
    end
    u17 = v1
end

function u15.HoldsBack(a1) -- Line: 33 -- upvalues: u17 (ref), u14 (val), LocalPlayer (val) -- types: a1: boolean?
    local v1 = false
    if a1 == true then
        v1 = u17 and u14[LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"] == true
    end
    return v1
end

function u15.TakeAdmissible(a1) -- Line: 37 -- upvalues: u15 (val) -- types: a1: table
    for i, j in a1 do
        if not u15.HoldsBack(j.config.DelayInRound) then
            return table.remove(a1, i)
        end
    end
    return nil
end

local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
local v2 = false
if LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil then
    v2 = v1 ~= "Waiting"
end
u17 = v2
;(LocalPlayer:GetAttributeChangedSignal("MurderMysteryRoundState")):Connect(function() -- Line: 51 -- upvalues: LocalPlayer (val), u17 (ref)
    local v1
    local v2 = if (LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting") ~= "Waiting" then nil else false
    local v3 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if v2 == nil then
        v1 = false
        if LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil then
            v1 = v3 ~= "Waiting"
        end
    else
        v1 = v2
    end
    u17 = v1
end)
;(LocalPlayer:GetAttributeChangedSignal("MurderMysteryRole")):Connect(function() -- Line: 53 -- upvalues: LocalPlayer (val), u17 (ref)
    local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    local v2 = false
    if LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil then
        v2 = v1 ~= "Waiting"
    end
    u17 = v2
end)
Remotes.Whodunnit.RoundShifted.OnClientEvent:Connect(function(a1) -- Line: 56 -- upvalues: LocalPlayer (val), u17 (ref)
    if typeof(a1) == "table" then
        local v1
        local isParticipant = a1.isParticipant
        local v2 = if typeof(isParticipant) ~= "boolean" then nil else isParticipant
        local v3 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
        if v2 == nil then
            v1 = false
            if LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil then
                v1 = v3 ~= "Waiting"
            end
        else
            v1 = v2
        end
        u17 = v1
    end
end)
return u15