-- Script path: ReplicatedStorage.CmdrClient.Types.BanDurationType
-- Decompile time: 1.26 ms

local u0 = {perm = true, permanent = true, forever = true}
local u1 = {
    s = 1,
    m = 60,
    h = 3600,
    d = 86400,
    w = 604800,
}

local function parseDuration(a1) -- Line: 17 -- upvalues: u0 (val), u1 (val)
    if a1 ~= nil and a1 ~= "" then
        local v1 = string.lower(a1)
        if u0[v1] then
            return -1
        end
        if string.gsub(v1, "(%d+)([smhdw])", "") ~= "" then
            return nil
        end
        local v2 = 0
        for i, j in string.gmatch(v1, "(%d+)([smhdw])") do
            v2 = v2 + (tonumber(i)) * u1[j]
        end
        if not (v2 <= 0) and not (v2 > 3153600000) then
            return v2
        end
        return nil
    end
    return nil
end

local u3 = {DisplayName = "Ban Duration"}

function u3.Transform(a1) -- Line: 47 -- upvalues: parseDuration (val)
    return a1, (parseDuration(a1))
end

function u3.Validate(a1, a2) -- Line: 51
    return a2 ~= nil, "Use a length like 30m, 12h, 7d, 2w, 1d12h, or perm."
end

function u3.Autocomplete(a1) -- Line: 55
    local v1 = string.lower(a1)
    if #v1 > 0 and string.sub("permanent", 1, #v1) == v1 then
        return {"perm"}
    end
    return {}
end

function u3.Parse(a1, a2) -- Line: 63
    return a2
end

return function(a1) -- Line: 68 -- upvalues: u3 (val)
    a1:RegisterType("banDuration", u3)
end