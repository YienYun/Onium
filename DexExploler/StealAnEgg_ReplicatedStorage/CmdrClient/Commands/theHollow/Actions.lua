-- Script path: ReplicatedStorage.CmdrClient.Commands.theHollow.Actions
-- Decompile time: 7.14 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CmdrToolkit = require(ReplicatedStorage.Shared.Utils.CmdrToolkit)
local TheHollowFlags = require(ReplicatedStorage.Shared.Flags.TheHollowFlags)
local TheHollow = require(ReplicatedStorage.Data.TheHollow)
local TheHollow_2 = require(ReplicatedStorage.Shared.Types.TheHollow)
local Arg = CmdrToolkit.Arg
local v1, v2 = CmdrToolkit.Manifest()
local v3 = Arg("players", "players", "Who; defaults to you", true)
local v4 = Arg(CmdrToolkit.Enum("hollowPrize", function() -- Line: 23 -- upvalues: TheHollow (val)
    local v1 = {"all"}
    for i in TheHollow.Prizes do
        table.insert(v1, i)
    end
    return v1
end, "prize"), "prize", "A prize id, or all")

local function clock(a1) -- Line: 34 -- types: a1: number
    local v1 = math.max(math.floor(a1), 0)
    return string.format("%dm %02ds", v1 // 60, v1 % 60)
end

local function claimed(a1) -- Line: 39 -- upvalues: TheHollow (val)
    local v1 = {}
    for i, j in TheHollow.OrderedPrizes() do
        if a1.Claimed[j.Id] then
            table.insert(v1, j.Id)
        end
    end
    if #v1 > 0 then
        return (table.concat(v1, ", "))
    end
    return "none"
end

local function describe(a1, a2) -- Line: 49 -- upvalues: claimed (val) -- types: a1: userdata
    return (("%*: %* Hollow wins | prizes claimed: %*"):format(a1.Name, a2.Wins, (claimed(a2))))
end

local function raceLine(a1) -- Line: 53 -- upvalues: TheHollowFlags (val), Workspace (val)
    if not TheHollowFlags.ContentEnabled:Get() then
        return "The Hollow: switched off (Game.TheHollow.ContentEnabled)"
    end
    local v1 = ("The Hollow: %*/%* races, %* queued"):format(#a1.Service.Races(), TheHollowFlags.MaxConcurrentRaces:Get(), (a1.Service.Queued()))
    local Attribute = Workspace:GetAttribute("TheHollowJoinEndsAt")
    if type(Attribute) == "number" then
        local v2 = Workspace:GetAttribute("TheHollowRacers") or 0
        local v3 = math.max(math.floor(Attribute - (Workspace:GetServerTimeNow())), 0)
        v1 = v1 .. (" | one filling, %* in, closes in %*"):format(v2, (string.format("%dm %02ds", v3 // 60, v3 % 60)))
    end
    return v1
end

local function targets(a1, a2) -- Line: 68 -- types: a2: table?
    return a2 or {a1.executor}
end

local function edit(a1, a2, a3) -- Line: 72 -- upvalues: claimed (val) -- types: a2: table?, a3: function
    local v1, v2, v3
    local v4 = {}
    local v5 = a2 or {a1.executor}
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a3
    for i, j in v5, v6, v7 do
        v3, v1, v2 = v8.Service.Write(j, v9)
        table.insert(
            v4,
            if not v3 or v2 == nil then ("%*: %*"):format(j.Name, v1) else ("%*: %* Hollow wins | prizes claimed: %*"):format(j.Name, v2.Wins, (claimed(v2)))
        )
    end
    return table.concat(v4, "\n")
end

v2("status", "Hollow progress and this server's Hollow races", {v3}, function(a1, a2) -- Line: 88 -- upvalues: raceLine (val), claimed (val)
    local v1
    local v2 = {(raceLine(a1))}
    local v3 = a2 or {a1.executor}
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = a1.Service.Get(j)
        table.insert(
            v2,
            if v1 == nil then ("%*: profile not loaded"):format(j.Name) else ("%*: %* Hollow wins | prizes claimed: %*"):format(j.Name, v1.Wins, (claimed(v1)))
        )
    end
    return table.concat(v2, "\n")
end)
v2("wins", "Add Hollow wins; negative takes them away. Run prizes to pay what they reach", {Arg("integer", "amount", "Wins to add"), v3}, function(a1, a2, a3) -- Line: 106 -- upvalues: edit (val) -- types: a2: number
    return edit(a1, a3, function(a1) -- Line: 107 -- upvalues: a2 (val)
        a1.Wins = math.max(a1.Wins + a2, 0)
    end)
end)
v2("prizes", "Pay every prize (and the badge) their Hollow wins have reached, like a win does", {v3}, function(a1, a2) -- Line: 116 -- upvalues: claimed (val)
    local v1
    local v2 = {}
    local v3 = a2 or {a1.executor}
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in v3, v4, v5 do
        v6.Service.GrantPrizes(j)
        v1 = v6.Service.Get(j)
        table.insert(
            v2,
            if v1 == nil then ("%*: profile not loaded"):format(j.Name) else ("%*: %* Hollow wins | prizes claimed: %*"):format(j.Name, v1.Wins, (claimed(v1)))
        )
    end
    return table.concat(v2, "\n")
end)
v2("unclaim", "Mark a prize unclaimed so it pays again; rewards already given stay", {v4, v3}, function(a1, a2, a3) -- Line: 136 -- upvalues: edit (val) -- types: a2: string
    return edit(a1, a3, function(a1) -- Line: 137 -- upvalues: a2 (val)
        if a2 == "all" then
            table.clear(a1.Claimed)
            return
        end
        a1.Claimed[a2] = nil
    end)
end)
v2("reset", "Wipe Hollow wins and claimed prizes back to a new player's; a badge already earned stays", {v3}, function(a1, a2) -- Line: 151 -- upvalues: edit (val), TheHollow_2 (val)
    return edit(a1, a2, function(a1) -- Line: 152 -- upvalues: TheHollow_2 (upval)
        for i, j in TheHollow_2.Blank() do
            a1[i] = j
        end
    end)
end)
v2("start", "Open a Hollow race at the start line on this server now", {
    Arg("integer", "joinSeconds", "How long it waits for racers; default Game.TheHollow.JoinSeconds", true),
    Arg("integer", "laps", "Default Game.TheHollow.Laps", true),
    (Arg("integer", "racers", "Bots fill the grid up to this many (1 = no bots); default Game.TheHollow.RacersWithBots", true)),
}, function(a1, a2, a3, a4) -- Line: 174 -- types: a2: number?, a3: number?, a4: number?
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
v2("stop", "End every Hollow race on this server and clear its queue", {}, function(a1) -- Line: 190
    local v1 = a1.Service.StopRaces()
    if v1 > 0 then
        return (("Stopped %* Hollow race(s)."):format(v1))
    end
    return "No Hollow race is running on this server."
end)
return v1