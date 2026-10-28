-- Script path: ReplicatedStorage.CmdrClient.Types.PlayerId
-- Decompile time: 2.36 ms

local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local u12 = {}

local function getUserId(a1) -- Line: 5 -- upvalues: u12 (val), Players (val)
    if u12[a1] then
        return u12[a1]
    end
    if Players:FindFirstChild(a1) then
        u12[a1] = Players[a1].UserId
        return Players[a1].UserId
    end
    local success, err = pcall(Players.GetUserIdFromNameAsync, Players, a1)
    if not success then
        return nil
    end
    u12[a1] = err
    return err
end

local u14 = {DisplayName = "Full Player Name", Prefixes = "# integer"}

function u14.Transform(a1) -- Line: 27 -- upvalues: Util (val), Players (val)
    return a1, Util.MakeFuzzyFinder(Players:GetPlayers())(a1)
end

function u14.ValidateOnce(a1) -- Line: 33 -- upvalues: u12 (val), Players (val)
    local UserId
    if u12[a1] then
        UserId = u12[a1]
    elseif not Players:FindFirstChild(a1) then
        local success, err = pcall(Players.GetUserIdFromNameAsync, Players, a1)
        if success then
            u12[a1] = err
            UserId = err
        else
            UserId = nil
        end
    else
        u12[a1] = Players[a1].UserId
        UserId = Players[a1].UserId
    end
    return UserId ~= nil, "No player with that name could be found."
end

function u14.Autocomplete(a1, a2) -- Line: 37 -- upvalues: Util (val)
    return Util.GetNames(a2)
end

function u14.Parse(a1) -- Line: 41 -- upvalues: u12 (val), Players (val)
    if u12[a1] then
        return u12[a1]
    end
    if Players:FindFirstChild(a1) then
        u12[a1] = Players[a1].UserId
        return Players[a1].UserId
    end
    local success, err = pcall(Players.GetUserIdFromNameAsync, Players, a1)
    if not success then
        return nil
    end
    u12[a1] = err
    return err
end

function u14.Default(a1) -- Line: 45
    return a1.Name
end

u14.ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"}
return function(a1) -- Line: 57 -- upvalues: u14 (val), Util (val)
    a1:RegisterType("playerId", u14)
    a1:RegisterType("playerIds", (Util.MakeListableType(u14, {Prefixes = "# integers"})))
end