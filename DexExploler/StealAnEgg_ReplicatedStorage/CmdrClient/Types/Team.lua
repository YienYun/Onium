-- Script path: ReplicatedStorage.CmdrClient.Types.Team
-- Decompile time: 1.14 ms

local Teams = game:GetService("Teams")
local Util = require(script.Parent.Parent.Shared.Util)
local u12 = {}

function u12.Transform(a1) -- Line: 5 -- upvalues: Util (val), Teams (val)
    return Util.MakeFuzzyFinder(Teams:GetTeams())(a1)
end

function u12.Validate(a1) -- Line: 11
    return #a1 > 0, "No team with that name could be found."
end

function u12.Autocomplete(a1) -- Line: 15 -- upvalues: Util (val)
    return Util.GetNames(a1)
end

function u12.Parse(a1) -- Line: 19
    return a1[1]
end

local u17 = {
    Listable = true,
    Transform = u12.Transform,
    Validate = u12.Validate,
    Autocomplete = u12.Autocomplete,
}

function u17.Parse(a1) -- Line: 30
    return a1[1]:GetPlayers()
end

local u22 = {
    Transform = u12.Transform,
    Validate = u12.Validate,
    Autocomplete = u12.Autocomplete,
}

function u22.Parse(a1) -- Line: 40
    return a1[1].TeamColor
end

return function(a1) -- Line: 45 -- upvalues: u12 (val), Util (val), u17 (val), u22 (val)
    a1:RegisterType("team", u12)
    a1:RegisterType("teams", (Util.MakeListableType(u12)))
    a1:RegisterType("teamPlayers", u17)
    a1:RegisterType("teamColor", u22)
    a1:RegisterType("teamColors", (Util.MakeListableType(u22)))
end