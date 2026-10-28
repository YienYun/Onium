-- Script path: ReplicatedStorage.CmdrClient.Types.Player
-- Decompile time: 1.19 ms

local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local u12 = {}

function u12.Transform(a1) -- Line: 5 -- upvalues: Util (val), Players (val)
    return Util.MakeFuzzyFinder(Players:GetPlayers())(a1)
end

function u12.Validate(a1) -- Line: 11
    return #a1 > 0, "No player with that name could be found."
end

function u12.Autocomplete(a1) -- Line: 15 -- upvalues: Util (val)
    return Util.GetNames(a1)
end

function u12.Parse(a1) -- Line: 19
    return a1[1]
end

function u12.Default(a1) -- Line: 23
    return a1.Name
end

u12.ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"}
return function(a1) -- Line: 35 -- upvalues: u12 (val), Util (val)
    a1:RegisterType("player", u12)
    a1:RegisterType("players", (Util.MakeListableType(u12, {Prefixes = "% teamPlayers"})))
end