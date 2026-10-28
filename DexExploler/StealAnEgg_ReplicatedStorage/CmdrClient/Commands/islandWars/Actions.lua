-- Script path: ReplicatedStorage.CmdrClient.Commands.islandWars.Actions
-- Decompile time: 8.42 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CmdrToolkit = require(ReplicatedStorage.Shared.Utils.CmdrToolkit)
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local CursedIslandWarsFlags = require(ReplicatedStorage.Shared.Flags.CursedIslandWarsFlags)
local Arg = CmdrToolkit.Arg
local v1, v2 = CmdrToolkit.Manifest()
local u28 = {red = "Red", blue = "Blue"}
local u29 = {mine = "Landmine", pad = "JumpPad"}

local function words(a1) -- Line: 23 -- types: a1: table
    local v1 = {}
    for i in a1 do
        table.insert(v1, i)
    end
    return v1
end

local v3 = Arg("players", "players", "Who; defaults to you", true)
local Enum = CmdrToolkit.Enum
local v4 = {}
for i in u28 do
    table.insert(v4, i)
end
local v5 = Arg(Enum("islandTeam", v4, "team"), "team", "red or blue")
local Enum_2 = CmdrToolkit.Enum
local v6 = {}
for j in u29 do
    table.insert(v6, j)
end
local v7 = Arg(Enum_2("islandPickup", v6, "pickup"), "pickup", "mine (landmine) or pad (jump pad)")
local v8 = Arg(CmdrToolkit.Enum("islandSwitch", {"on", "off"}, "setting"), "setting", "on or off")

local function clock(a1) -- Line: 36 -- types: a1: number
    local v1 = math.max(math.floor(a1), 0)
    return string.format("%dm %02ds", v1 // 60, v1 % 60)
end

local function onOff(a1) -- Line: 41 -- types: a1: boolean
    if a1 then
        return "on"
    end
    return "off"
end

v2("status", "Phase, clock, walls, crystals and both rosters", {}, function(a1) -- Line: 45 -- upvalues: Workspace (val), CursedIslandWars (val)
    local Health_2, Health_3, v1, v2, v3, v4
    local v5 = ("bots %*"):format(if not a1.Service.BotsOn() then "off" else "on")
    local v6 = a1.Service.Current()
    if v6 == nil then
        return (("Cursed Island Wars isn't running on this server. (%*)"):format(v5))
    end
    local v7 = if not v6.Winner then "" else ", " .. v6.Winner .. " won"
    local v8 = {}
    local v9 = math.max(math.floor(v6.PhaseEndsAt - (Workspace:GetServerTimeNow())), 0)
    v8[1] = (("%*, %* left%* | %*"):format(v6.Phase, string.format("%dm %02ds", v9 // 60, v9 % 60), v7, v5))
    local v10 = nil
    local v11 = nil
    for i, j in CursedIslandWars.TeamIds, v10, v11 do
        v9 = v6.Barriers[j]
        v1 = v6.Crystals[j]
        v7 = {}
        v2 = nil
        v3 = nil
        for k, n in v6.Entries, v2, v3 do
            if n.Team == j then
                v5 = false
                if n.Player ~= nil then
                    v5 = a1.Combat.Invincible[n.Player] == true
                end
                v4 = if not v5 then "" else " god"
                table.insert(v7, (("%*%* %* %*hp%*"):format(n.Name, if not n.Player then " (bot)" else "", n.State, n.Health, v4)))
            end
        end
        Health_2 = if not v9 then "-" else v9.Health
        Health_3 = if not v1 then "-" else v1.Health
        table.insert(v8, (("%*: wall %*, crystal %*"):format(j, Health_2, Health_3)) .. ((" | %*"):format((table.concat(v7, ", ")))))
    end
    return table.concat(v8, "\n")
end)
v2("start", "Start the event on this server", {
    Arg(CmdrToolkit.Enum("islandIntro", {"skip"}, "option"), "intro", "skip: start without the intro cutscene", true),
}, function(a1, a2) -- Line: 78 -- types: a2: string?
    if a1.Service.Current() then
        return "Already running; `iw stop` first."
    end
    a1.Events.StartEvent("CursedIslandWars", 1800, {SkipCutscenes = a2 == "skip"})
    if a2 == "skip" then
        return "Started without the intro."
    end
    return "Started."
end)
v2("stop", "End the event on this server and send everyone home", {}, function(a1) -- Line: 86
    if a1.Service.Current() == nil then
        return "Cursed Island Wars isn't running on this server."
    end
    a1.Events.StopEvent("CursedIslandWars")
    return "Stopped."
end)
v2("skip", "End the current phase now; in Sudden Death the tiebreak picks the winner", {}, function(a1) -- Line: 94
    return a1.Service.Skip()
end)
v2("win", "End the fight now with this team winning", {v5}, function(a1, a2) -- Line: 98 -- upvalues: u28 (val) -- types: a2: string
    return a1.Service.Win(u28[a2])
end)
v2("bots", "Bots fill empty slots at the start and replace players who leave", {v8}, function(a1, a2) -- Line: 104 -- types: a2: string
    local v1
    a1.Service.SetBots(a2 == "on")
    return (("Bots %*; this applies from the next start and to players who leave."):format(if not v1 then "off" else "on"))
end)
v2("god", "Immune to event damage, or vulnerable again", {v8, v3}, function(a1, a2, a3) -- Line: 113 -- types: a2: string, a3: table?
    local v1
    local v2 = a2 == "on"
    local v3 = {}
    local v4 = a3 or {a1.executor}
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = if not v2 then nil else true
        a1.Combat.Invincible[j] = v1
        table.insert(v3, j.Name)
    end
    return (("God mode %*: %*"):format(if not v2 then "off" else "on", (table.concat(v3, ", "))))
end)
local v9 = {}
local v10 = Arg("integer", "uses", "How many; default one pickup's worth", true)
v9[1] = v7
v9[2] = v10
v9[3] = v3
v2("give", "Give pickup uses, past the carry cap", v9, function(a1, a2, a3, a4) -- Line: 127
    -- upvalues: u29 (val), CursedIslandWarsFlags (val)
    local v1
    local v2 = a1.Service.Current()
    if v2 == nil then
        return "Cursed Island Wars isn't running on this server."
    end
    local v3 = u29[a2]
    local v4 = a3 or (if v3 ~= "Landmine" then CursedIslandWarsFlags.PadPickupUses:Get() else CursedIslandWarsFlags.MinePickupUses:Get())
    if v4 < 1 then
        return "uses must be at least 1."
    end
    local v5 = {}
    for i, j in a4 or {a1.executor} do
        v1 = a1.Match.EntryForPlayer(v2, j)
        if v1 == nil then
            table.insert(v5, (("%*: not in the match"):format(j.Name)))
        elseif not a1.Tools.Grant(v2, v1, v3, v4, (a1.Tools.Ammo(v1, v3)) + v4) then
            table.insert(v5, (("%*: not alive"):format(j.Name)))
        else
            table.insert(v5, (("%*: %* x%*"):format(j.Name, v3, (a1.Tools.Ammo(v1, v3)))))
        end
    end
    return table.concat(v5, "\n")
end)
v2("wall", "Lower a team's wall health; 0 breaks it", {v5, Arg("integer", "health", "New health")}, function(a1, a2, a3) -- Line: 157 -- upvalues: u28 (val) -- types: a2: string, a3: number
    local v1 = a1.Service.Current()
    if v1 == nil then
        return "Cursed Island Wars isn't running on this server."
    end
    if not a1.Match.IsFighting(v1) then
        return "Only during the match or Sudden Death."
    end
    local v2 = u28[a2]
    local v3 = v1.Barriers[v2]
    if v3.Health <= a3 then
        return (("The %* wall is at %*; set it lower."):format(v2, v3.Health))
    end
    a1.Structures.DamageBarrier(v1, v2, v3.Health - math.max(a3, 0), v3.Hitbox.Position, nil)
    return (("%* wall now %*."):format(v2, v3.Health))
end)
v2("crystal", "Lower a team's crystal health, even behind its wall; 0 shatters it", {v5, Arg("integer", "health", "New health")}, function(a1, a2, a3) -- Line: 177 -- upvalues: u28 (val) -- types: a2: string, a3: number
    local v1 = a1.Service.Current()
    if v1 == nil then
        return "Cursed Island Wars isn't running on this server."
    end
    if not a1.Match.IsFighting(v1) then
        return "Only during the match or Sudden Death."
    end
    local v2 = u28[a2]
    local v3 = v1.Crystals[v2]
    if v3.Health <= a3 then
        return (("The %* crystal is at %*; set it lower."):format(v2, v3.Health))
    end
    a1.Structures.DamageCrystal(v1, v2, v3.Health - math.max(a3, 0), nil)
    return (("%* crystal now %*."):format(v2, v3.Health))
end)
return v1