-- Script path: ReplicatedStorage.CmdrClient.Types.ManorKeyActionType
-- Decompile time: 0.27 ms

local u0 = {"grant", "unlock", "reset"}
return function(a1) -- Line: 7 -- upvalues: u0 (val)
    a1:RegisterType("manorKeyAction", (a1.Cmdr.Util.MakeEnumType("ManorKeyAction", u0)))
end