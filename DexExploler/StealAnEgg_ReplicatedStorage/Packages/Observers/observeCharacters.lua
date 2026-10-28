-- Script path: ReplicatedStorage.Packages.Observers.observeCharacters
-- Decompile time: 0.30 ms

local observePlayer = require(script.Parent.observePlayer)
local observeCharacter = require(script.Parent.observeCharacter)
return function(a1) -- Line: 22 -- upvalues: observePlayer (val), observeCharacter (val) -- types: a1: function
    return observePlayer(function(a1_2) -- Line: 23 -- upvalues: observeCharacter (upval), a1 (val)
        return observeCharacter(a1_2, a1)
    end)
end