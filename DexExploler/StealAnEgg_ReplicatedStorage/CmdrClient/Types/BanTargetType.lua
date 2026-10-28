-- Script path: ReplicatedStorage.CmdrClient.Types.BanTargetType
-- Decompile time: 2.67 ms

local Players = game:GetService("Players")

local function trim(a1) -- Line: 8
    return (string.gsub(a1, "^%s*(.-)%s*$", "%1"))
end

local function isValidToken(a1) -- Line: 12
    if string.match(a1, "^#?%d+$") then
        return true
    end
    local v1 = false
    if string.match(a1, "^[%w_]+$") ~= nil then
        v1 = false
        if #a1 >= 3 then
            v1 = #a1 <= 20
        end
    end
    return v1
end

local function matchOnline(a1) -- Line: 22 -- upvalues: Players (val)
    local v1 = string.lower(a1)
    local v2 = {}
    for i, j in Players:GetPlayers() do
        if v1 == "" or string.sub(string.lower(j.Name), 1, #v1) == v1 then
            table.insert(v2, j)
        end
    end
    return v2
end

local u8 = {DisplayName = "Username or #UserId", Listable = true}

function u8.Transform(a1) -- Line: 39 -- upvalues: matchOnline (val)
    return (string.gsub(a1, "^%s*(.-)%s*$", "%1")), (matchOnline((string.gsub(a1, "^%s*(.-)%s*$", "%1"))))
end

function u8.Validate(a1) -- Line: 43
    local v1
    if #a1 == 0 then
        return false, "Give a username, or a user id prefixed with #."
    end
    if not string.match(a1, "^#?%d+$") then
        v1 = false
        if string.match(a1, "^[%w_]+$") ~= nil then
            v1 = false
            if #a1 >= 3 then
                v1 = #a1 <= 20
            end
        end
    else
        v1 = true
    end
    return v1, (("\"%*\" is not a username or a #userid. Ids look like #3889785873."):format(a1))
end

function u8.Autocomplete(a1, a2) -- Line: 51
    local v1 = {}
    for i, j in a2 do
        table.insert(v1, j.Name)
    end
    return v1
end

function u8.Parse(a1, a2) -- Line: 59
    if #a2 == 1 and (string.lower(a2[1].Name)) == string.lower(a1) then
        return {a2[1].Name}
    end
    return {a1}
end

function u8.Default(a1) -- Line: 67
    return a1.Name
end

u8.ArgumentOperatorAliases = {me = ".", all = "*", others = "**"}
return function(a1) -- Line: 78 -- upvalues: u8 (val)
    a1:RegisterType("banTargets", u8)
end