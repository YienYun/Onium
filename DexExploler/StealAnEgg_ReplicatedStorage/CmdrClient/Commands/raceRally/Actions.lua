-- Script path: ReplicatedStorage.CmdrClient.Commands.raceRally.Actions
-- Decompile time: 10.79 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CmdrToolkit = require(ReplicatedStorage.Shared.Utils.CmdrToolkit)
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local RaceRally = require(ReplicatedStorage.Data.RaceRally)
local RaceRallySchedule = require(ReplicatedStorage.Shared.Util.RaceRallySchedule)
local RaceRally_2 = require(ReplicatedStorage.Shared.Types.RaceRally)
local Arg = CmdrToolkit.Arg
local v1, v2 = CmdrToolkit.Manifest()

local function idsOrAll(a1) -- Line: 24 -- types: a1: table
    local v1 = {"all"}
    for i in a1 do
        table.insert(v1, i)
    end
    return v1
end

local v3 = Arg("players", "players", "Who; defaults to you", true)
local v4 = Arg(CmdrToolkit.Enum("raceRacer", function() -- Line: 34 -- upvalues: RaceRally (val)
    local v1 = {"all"}
    for i in RaceRally.Racers do
        table.insert(v1, i)
    end
    return v1
end, "racer"), "racer", "A racer id, or all")
local v5 = Arg(CmdrToolkit.Enum("raceMilestone", function() -- Line: 41 -- upvalues: RaceRally (val)
    local v1 = {"all"}
    for i in RaceRally.Milestones do
        table.insert(v1, i)
    end
    table.insert(v1, RaceRally.RepeatId)
    return v1
end, "milestone"), "milestone", "A milestone id, Repeat (the repeat rewards past the ladder), or all")

local function clock(a1) -- Line: 50 -- types: a1: number
    local v1 = math.max(math.floor(a1), 0)
    return string.format("%dm %02ds", v1 // 60, v1 % 60)
end

local function names(a1) -- Line: 55 -- types: a1: table
    local v1 = {}
    for i in a1 do
        table.insert(v1, i)
    end
    table.sort(v1)
    if #v1 > 0 then
        return (table.concat(v1, ", "))
    end
    return "none"
end

local function describe(a1, a2) -- Line: 64 -- upvalues: names (val), RaceRally (val) -- types: a1: userdata
    return (("%*: %* trophies, %* wins, %* races, %* nitro"):format(a1.Name, a2.Tokens, a2.Wins, a2.Races, a2.MutationConsumables)) .. ((" | claimed: %* + %* repeats | racers: %*"):format(names(a2.Milestones), a2.Repeats, (names(a2.Racers)))) .. (" | riding: %* | shop limits: %*"):format(RaceRally.ResolveRacer(a2.EquippedRacer, a2.Racers), (names(a2.Purchases)))
end

local function raceLine() -- Line: 74
    -- upvalues: Workspace (val), RaceRally (val), RaceRallyFlags (val), RaceRallySchedule (val)
    local v1
    local ServerTimeNow = Workspace:GetServerTimeNow()
    if Workspace:GetAttribute(RaceRally.Attributes.Running) == true then
        local Attribute = Workspace:GetAttribute(RaceRally.Attributes.JoinEndsAt)
        if type(Attribute) ~= "number" then
            return "Race: racing"
        end
        local v2 = math.max(math.floor(Attribute - ServerTimeNow), 0)
        return (("Race: portal open, closes in %*"):format((string.format("%dm %02ds", v2 // 60, v2 % 60))))
    end
    if not RaceRallyFlags.ContentEnabled:Get() then
        return "Race: switched off (Game.RaceRally.ContentEnabled)"
    end
    if not RaceRallyFlags.ScheduleEnabled:Get() then
        return "Race: idle, schedule off (Game.RaceRally.ScheduleEnabled)"
    end
    _, v1 = RaceRallySchedule.Window(ServerTimeNow)
    local v3 = math.max(math.floor(v1 + (RaceRallyFlags.ScheduleIntervalSeconds:Get()) - ServerTimeNow), 0)
    return (("Race: idle, next portal in %*"):format((string.format("%dm %02ds", v3 // 60, v3 % 60))))
end

local function targets(a1, a2) -- Line: 92 -- types: a2: table?
    return a2 or {a1.executor}
end

local function edit(a1, a2, a3) -- Line: 97 -- upvalues: describe (val) -- types: a2: table?, a3: function
    local v1, v2, v3
    local v4 = {}
    local v5 = a2 or {a1.executor}
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        v3, v1, v2 = a1.Profile.Write(j, function(a1) -- Line: 100 -- upvalues: a3 (val)
            a3(a1)
            return true
        end)
        table.insert(v4, if not v3 or v2 == nil then ("%*: %*"):format(j.Name, v1) else describe(j, v2))
    end
    return table.concat(v4, "\n")
end

v2("status", "Race progress and this server's race clock", {v3}, function(a1, a2) -- Line: 112 -- upvalues: raceLine (val), describe (val)
    local v1
    local v2 = {(raceLine())}
    local v3 = a2 or {a1.executor}
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = a1.Profile.Get(j)
        table.insert(v2, if v1 == nil then ("%*: profile not loaded"):format(j.Name) else describe(j, v1))
    end
    return table.concat(v2, "\n")
end)
v2("trophies", "Add Trophies; negative takes them away", {Arg("integer", "amount", "Trophies to add"), v3}, function(a1, a2, a3) -- Line: 127 -- upvalues: edit (val) -- types: a2: number
    return edit(a1, a3, function(a1) -- Line: 128 -- upvalues: a2 (val)
        a1.Tokens = math.max(a1.Tokens + a2, 0)
    end)
end)
v2("nitro", "Add Nitro mutation uses; negative takes them away", {Arg("integer", "amount", "Uses to add"), v3}, function(a1, a2, a3) -- Line: 136 -- upvalues: edit (val) -- types: a2: number
    local v1 = edit(a1, a3, function(a1) -- Line: 137 -- upvalues: a2 (val)
        a1.MutationConsumables = math.max(a1.MutationConsumables + a2, 0)
    end)
    for i, j in a3 or {a1.executor} do
        a1.Service.SyncNitro(j)
    end
    return v1
end)
v2("wins", "Add race wins toward the milestones; negative takes them away", {Arg("integer", "amount", "Wins to add"), v3}, function(a1, a2, a3) -- Line: 149 -- upvalues: edit (val) -- types: a2: number
    return edit(a1, a3, function(a1) -- Line: 150 -- upvalues: a2 (val)
        a1.Wins = math.max(a1.Wins + a2, 0)
    end)
end)
v2("unlock", "Unlock a racer without claiming its milestone", {v4, v3}, function(a1, a2, a3) -- Line: 159 -- upvalues: edit (val), RaceRally (val) -- types: a2: string
    return edit(a1, a3, function(a1) -- Line: 160 -- upvalues: RaceRally (upval), a2 (val)
        local v1 = nil
        local v2 = nil
        local v3 = a1
        for i in RaceRally.Racers, v1, v2 do
            if a2 == "all" then
                if i ~= RaceRally.DefaultRacer then
                    v3.Racers[i] = true
                end
            elseif i == a2 and i ~= RaceRally.DefaultRacer then
                v3.Racers[i] = true
            end
        end
    end)
end)
v2("lock", "Lock a racer again; riding it falls back to the default", {v4, v3}, function(a1, a2, a3) -- Line: 174 -- upvalues: edit (val), RaceRally (val) -- types: a2: string
    return edit(a1, a3, function(a1) -- Line: 175 -- upvalues: RaceRally (upval), a2 (val)
        local v1 = nil
        local v2 = nil
        local v3 = a1
        for i in RaceRally.Racers, v1, v2 do
            if a2 == "all" or i == a2 then
                v3.Racers[i] = nil
            end
        end
        if not v3.Racers[v3.EquippedRacer] then
            v3.EquippedRacer = ""
        end
    end)
end)
v2("unclaim", "Mark a milestone unclaimed so it can be claimed again; rewards already given stay", {v5, v3}, function(a1, a2, a3) -- Line: 192 -- upvalues: edit (val), RaceRally (val) -- types: a2: string
    return edit(a1, a3, function(a1) -- Line: 193 -- upvalues: a2 (val), RaceRally (upval)
        if a2 == "all" then
            table.clear(a1.Milestones)
            a1.Repeats = 0
            return
        end
        if a2 == RaceRally.RepeatId then
            a1.Repeats = 0
            return
        end
        a1.Milestones[a2] = nil
    end)
end)
v2("restock", "Clear the shop purchase limits", {v3}, function(a1, a2) -- Line: 206 -- upvalues: edit (val)
    return edit(a1, a2, function(a1) -- Line: 207
        table.clear(a1.Purchases)
    end)
end)
v2("reset", "Wipe race progress back to a new player's and let them race again this window", {v3}, function(a1, a2) -- Line: 216 -- upvalues: edit (val), RaceRally_2 (val)
    for i, j in a2 or {a1.executor} do
        a1.Service.ClearLockout(j)
    end
    return edit(a1, a2, function(a1) -- Line: 220 -- upvalues: RaceRally_2 (upval)
        for i, j in RaceRally_2.Blank() do
            a1[i] = j
        end
        a1.LastRacedWindow = nil
    end)
end)
v2("award", "Pay a race result as if they finished in that place; 0 = did not finish", {Arg("integer", "place", "1 = a win; 0 = did not finish"), v3}, function(a1, a2, a3) -- Line: 232 -- upvalues: describe (val) -- types: a2: number
    local Award, v1, v2, v3, v4
    if a2 < 0 then
        return "Place can't be negative."
    end
    local v5 = {}
    local v6 = a3 or {a1.executor}
    local v7 = nil
    local v8 = nil
    local v9, v10 = a1, a2
    for i, j in v6, v7, v8 do
        Award = v9.Service.Award
        v2 = math.max(v10, 1)
        v3 = v10 > 0
        v4, v1, v2 = Award(j, v2, v3)
        table.insert(
            v5,
            if v2 == nil then ("%*: the save failed"):format(j.Name) else ("+%* trophies, +%* wins -> %*"):format(v4, v1, (describe(j, v2)))
        )
    end
    return table.concat(v5, "\n")
end)
v2("start", "Open the race portal on this server now", {
    Arg("integer", "joinSeconds", "How long the portal stays open; default Game.RaceRally.JoinSeconds", true),
    Arg("integer", "laps", "Default Game.RaceRally.Laps", true),
    (Arg("integer", "racers", "Bots fill the grid up to this many (1 = no bots); default Game.RaceRally.RacersWithBots", true)),
}, function(a1, a2, a3, a4) -- Line: 263 -- types: a2: number?, a3: number?, a4: number?
    local v1
    if a2 == nil then
        if a3 ~= nil then
            if not (a3 < 1) and not (a3 > 10) then
                if a4 == nil then
                    _, v1 = a1.Service.StartRace(a2, a3, a4)
                    return v1
                end
                if not (a4 < 1) and not (a4 > 20) then
                    _, v1 = a1.Service.StartRace(a2, a3, a4)
                    return v1
                end
                return (("racers must be 1-%*."):format(20))
            end
            return (("laps must be 1-%*."):format(10))
        end
        if a4 ~= nil then
            if not (a4 < 1) and not (a4 > 20) then
                _, v1 = a1.Service.StartRace(a2, a3, a4)
                return v1
            end
            return (("racers must be 1-%*."):format(20))
        end
        _, v1 = a1.Service.StartRace(a2, a3, a4)
        return v1
    end
    if not (a2 < 5) and not (a2 > 600) then
        if a3 == nil then
            if a4 ~= nil then
                if not (a4 < 1) and not (a4 > 20) then
                    _, v1 = a1.Service.StartRace(a2, a3, a4)
                    return v1
                end
                return (("racers must be 1-%*."):format(20))
            end
            _, v1 = a1.Service.StartRace(a2, a3, a4)
            return v1
        end
        if not (a3 < 1) and not (a3 > 10) then
            if a4 == nil then
                _, v1 = a1.Service.StartRace(a2, a3, a4)
                return v1
            end
            if not (a4 < 1) and not (a4 > 20) then
                _, v1 = a1.Service.StartRace(a2, a3, a4)
                return v1
            end
            return (("racers must be 1-%*."):format(20))
        end
        return (("laps must be 1-%*."):format(10))
    end
    return (("joinSeconds must be %*-%*."):format(5, 600))
end)
v2("stop", "End the race on this server", {}, function(a1) -- Line: 279
    if a1.Service.StopRace() then
        return "Race stopped."
    end
    return "No race is running on this server."
end)
return v1