-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Scenes
-- Decompile time: 2.91 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Callouts = require(ReplicatedStorage.Shared.Util.PumpkinBossState).Callouts
local u21 = {}
u21.BruteRise = {Speaker = "Pumpkin Brute", Text = Callouts.SceneBruteRise}
u21.BruteDecay = {Text = Callouts.SceneBruteDecay}
u21.KingEmerge = {Speaker = "Pumpkin King", Text = Callouts.SceneKingEmerge}
u21.ShieldUp = {Speaker = "Pumpkin King", Text = Callouts.SceneShieldUp}
u21.ShieldBreak = {Text = Callouts.SceneShieldBreak}
u21.KingDefeat = {Speaker = "Pumpkin King", Text = Callouts.SceneKingDefeat}
local LocalPlayer = Players.LocalPlayer
local u41 = script.Parent:FindFirstChild("Cutscenes")
local u42 = {}
local u43 = {}

local function load(a1) -- Line: 55 -- upvalues: u43 (val), u41 (val) -- types: a1: string
    local v1 = u43[a1]
    if v1 == false then
        return nil
    end
    if v1 ~= nil then
        return v1
    end
    v1 = u41 and u41:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("ModuleScript") then
        local success, result = xpcall(require, debug.traceback, v1)
        if success and type(result) == "table" and type(result.Play) == "function" then
            u43[a1] = result
            return result
        end
        warn((("[PumpkinBoss] Cutscene %* failed to load: %*"):format(a1, result)))
        u43[a1] = false
        return nil
    end
    u43[a1] = false
    return nil
end

local u45 = {}
u45.Slots = table.freeze({
    "AdminIntro",
    "BruteRise",
    "BruteDecay",
    "KingEmerge",
    "ShieldUp",
    "ShieldBreak",
    "KingDefeat",
    "AdminOutro",
    "AdminOutro2",
})

function u45.Play(a1, a2, a3, a4, a5) -- Line: 95
    -- upvalues: u45 (val), Workspace (val), load (val), u21 (val), LocalPlayer (val), u42 (val)
    u45.Stop(a1)
    local v1 = math.max(a3 - (Workspace:GetServerTimeNow() - a4), 0)
    local v2 = load(a1)
    if v2 == nil then
        local v3 = u21[a1]
        if v3 and v1 > 0.2 then
            a5(v3.Text, v3.Speaker, (math.min(v1, 3.5)))
        end
        return
    end
    local success, result = xpcall(v2.Play, debug.traceback, {
        Name = a1,
        Arena = a2,
        Seconds = a3,
        At = a4,
        Player = LocalPlayer,
    })
    if not success then
        warn((("[PumpkinBoss] Cutscene %* errored: %*"):format(a1, result)))
        return
    end
    if type(result) == "table" and type(result.Stop) == "function" then
        u42[a1] = result
    end
end

function u45.Stop(a1) -- Line: 131 -- upvalues: u42 (val) -- types: a1: string
    local v1 = u42[a1]
    u42[a1] = nil
    if v1 then
        local success, result = xpcall(v1.Stop, debug.traceback)
        if not success then
            warn((("[PumpkinBoss] Cutscene %* failed to stop: %*"):format(a1, result)))
        end
    end
end

function u45.StopAll() -- Line: 142 -- upvalues: u42 (val), u45 (val)
    for i in u42 do
        u45.Stop(i)
    end
end

return u45