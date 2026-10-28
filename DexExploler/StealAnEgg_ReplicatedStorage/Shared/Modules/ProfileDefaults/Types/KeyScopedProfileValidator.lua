-- Script path: ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.KeyScopedProfileValidator
-- Decompile time: 1.01 ms

local SchemaFields = require(script.Parent.SchemaFields)
return function(a1, a2) -- Line: 13 -- upvalues: SchemaFields (val)
    local v1, v2, v3, v4, v5
    if typeof(a1) ~= "table" then
        return false, "a profile update has to be a table"
    end
    local v6 = typeof(a2) ~= "table"
    local v7 = nil
    local v8 = nil
    local v9, v10 = a1, a2
    for i in SchemaFields, v7, v8 do
        v4 = SchemaFields[i]
        v5 = v9[i]
        v1 = true
        if v4 ~= nil then
            v1 = not v6 and v5 == v10[i]
        end
        if not v1 then
            v2, v3 = v4(v5)
            if not v2 then
                return false, (("profile field %* was refused: %*"):format(i, v3 or "shape does not match"))
            end
        end
    end
    return true
end