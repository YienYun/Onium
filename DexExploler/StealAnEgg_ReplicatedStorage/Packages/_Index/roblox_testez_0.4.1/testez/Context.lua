-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.Context
-- Decompile time: 0.62 ms

return {
    new = function(a1) -- Line: 7
        local v1 = {}
        local u2 = {}
        v1.__index = u2
        if a1 then
            for k, v in pairs(getmetatable(a1).__index) do
                u2[k] = v
            end
        end

        function v1.__newindex(a1, a2, a3) -- Line: 18 -- upvalues: u2 (val)
            assert(u2[a2] == nil, (string.format("Cannot reassign %s in context", (tostring(a2)))))
            u2[a2] = a3
        end

        return (setmetatable({}, v1))
    end,
}