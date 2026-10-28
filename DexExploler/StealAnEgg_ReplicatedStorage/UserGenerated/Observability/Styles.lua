-- Script path: ReplicatedStorage.UserGenerated.Observability.Styles
-- Decompile time: 12.44 ms

local collect, result, sheetRules
_, result = xpcall(function() -- Line: 42
    return workspace[nil]
end, function() -- Line: 44
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 48
        return a1[a2]
    end
end
local v2 = {}
local u13 = setmetatable({}, {__mode = "k"})
v2.Affected = u13
local u14 = {
    BackgroundColor = "BackgroundColor3",
    BorderColor = "BorderColor3",
    TextColor = "TextColor3",
    Font = "FontFace",
}

function v2.Read(a1, a2) -- Line: 70 -- upvalues: u13 (val), result (ref) -- types: a1: userdata, a2: string
    local v1 = u13[a1]
    if v1 and v1[a2] then
        local success = pcall(a1.GetStyled, a1, a2)
        return success
    end
    local success_2 = pcall(result, a1, a2)
    return success_2
end

function v2.Get(a1, a2) -- Line: 79 -- upvalues: u13 (val), result (ref) -- types: a1: userdata, a2: string
    local v1 = u13[a1]
    if v1 and v1[a2] then
        local success, err = pcall(a1.GetStyled, a1, a2)
        if success then
            return err
        end
    end
    return result(a1, a2)
end

local function recordedName(a1, a2, a3) -- Line: 92
    -- upvalues: u14 (val)
    if not a3 then
        return nil
    end
    local v1 = u14[a2] or (if a2 ~= "Transparency" then if not (#a2 > 7) then a2 else if string.sub(a2, -7) ~= "Content" then a2 else string.sub(a2, 1, -8) else if not a1:IsA("GuiObject") then if not (#a2 > 7) then a2 else if string.sub(a2, -7) ~= "Content" then a2 else string.sub(a2, 1, -8) else "BackgroundTransparency")
    if a3[v1] then
        return v1
    end
    return nil
end

local function runnable(a1) -- Line: 111 -- types: a1: string
    local v1, v2
    if string.find(a1, "::", 1, true) then
        return nil
    end
    local u109 = {}
    local u111 = {}
    local u113 = false

    local function endCompound() -- Line: 118 -- upvalues: u111 (val), u109 (val), u113 (ref)
        if #u111 > 0 then
            table.insert(u109, (table.concat(u111, " ")))
        elseif u113 then
            table.insert(u109, "GuiObject")
        end
        table.clear(u111)
        u113 = false
    end

    local v3 = 1
    local v4 = #a1
    local v5 = a1
    while v3 <= v4 do
        v1 = string.sub(v5, v3, v3)
        if string.match(v1, "%s") then
            v3 = v3 + 1
        elseif v1 ~= ">" then
            if v1 ~= ":" and v1 ~= "@" then
                if v1 ~= "." and v1 ~= "#" then
                    v2 = string.match(v5, "^[%w_%-]+", v3)
                    if not v2 then
                        return v5
                    end
                    table.insert(u111, v2)
                    v3 = v3 + #v2
                    continue
                end
                v2 = string.match(v5, "^[%w_%-]*", v3 + 1)
                table.insert(u111, v1 .. v2)
                v3 = v3 + (#v2 + 1)
                continue
            end
            v3 = v3 + (#string.match(v5, "^[%w_%-]*", v3 + 1) + 1)
            u113 = true
        else
            if #u111 > 0 then
                table.insert(u109, (table.concat(u111, " ")))
            elseif u113 then
                table.insert(u109, "GuiObject")
            end
            table.clear(u111)
            u113 = false
            if string.sub(v5, v3 + 1, v3 + 1) ~= ">" then
                table.insert(u109, ">")
                v3 = v3 + 1
            else
                table.insert(u109, ">>")
                v3 = v3 + 2
            end
        end
    end
    if #u111 > 0 then
        table.insert(u109, (table.concat(u111, " ")))
    elseif u113 then
        table.insert(u109, "GuiObject")
    end
    table.clear(u111)
    return (table.concat(u109, " "))
end

local function list(a1) -- Line: 165 -- types: a1: string
    local v1
    local v2 = {}
    for i in string.gmatch(a1, "[^,]+") do
        v1 = string.match(i, "^%s*(.-)%s*$")
        if v1 ~= "" then
            table.insert(v2, v1)
        end
    end
    return v2
end

function collect(a1, a2, a3) -- Line: 180
    -- upvalues: list (val), collect (val)
    local v1, v2, v3, v4
    local v5, v6 = a2, a3
    for i, j in a1:GetChildren() do
        if j:IsA("StyleRule") then
            v3 = list(j.Selector)
            v4 = {}
            if not v5 then
                v4 = v3
            else
                v1 = nil
                v2 = nil
                for k, n in v5, v1, v2 do
                    for m, i5 in v3 do
                        table.insert(v4, n .. " " .. i5)
                    end
                end
            end
            table.insert(v6, {Rule = j, Selectors = v4})
            collect(j, v4, v6)
        elseif j:IsA("Folder") then
            collect(j, v5, v6)
        end
    end
end

function sheetRules(a1, a2, a3) -- Line: 203
    -- upvalues: sheetRules (val), collect (val)
    local StyleSheet
    if a2[a1] then
        return
    end
    a2[a1] = true
    for i, j in a1:GetChildren() do
        if j:IsA("StyleDerive") then
            StyleSheet = j.StyleSheet
            if StyleSheet then
                sheetRules(StyleSheet, a2, a3)
            end
        end
    end
    collect(a1, nil, a3)
end

local function linksIn(a1) -- Line: 219 -- types: a1: userdata
    local success, err = pcall(a1.QueryDescendants, a1, "StyleLink")
    if success then
        return err
    end
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("StyleLink") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function markNames(a1, a2, a3) -- Line: 235
    -- upvalues: result (ref), u13 (val), recordedName (val)
    local v1
    local v2 = a3[result(a1, "ClassName")]
    local v3 = u13[a1]
    local v4 = false
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in a2, v5, v6 do
        v1 = recordedName(v7, j, v2)
        if v1 then
            if not v3 or not v3[v1] then
                if not v3 then
                    u13[v7] = {}
                end
                v3[v1] = true
                v4 = true
            end
        end
    end
    return v4
end

function v2.Build(a1, a2) -- Line: 260
    -- upvalues: u13 (val), markNames (val), linksIn (val), sheetRules (val), runnable (val)
    local Parent, StyleSheet, err, err_2, success, success_2, v1, v2, v3, v4, v5, v6, v7, v8
    table.clear(u13)

    local function mark(a1, a2_2) -- Line: 262
        -- upvalues: markNames (upval), a2 (val)
        markNames(a1, a2_2, a2)
    end

    local v9 = nil
    local v10 = nil
    for i, j in a1, v9, v10 do
        for k, n in linksIn(j) do
            StyleSheet = n.StyleSheet
            Parent = n.Parent
            if StyleSheet and Parent then
                v2 = {}
                sheetRules(StyleSheet, {}, v2)
                v1 = Parent:IsA("GuiObject")
                v3 = nil
                v4 = nil
                for m, i5 in v2, v3, v4 do
                    success, err = pcall(i5.Rule.GetProperties, i5.Rule)
                    if success and type(err) == "table" and next(err) ~= nil then
                        v5 = {}
                        for i6 in err do
                            table.insert(v5, i6)
                        end
                        if v1 then
                            markNames(Parent, v5, a2)
                        end
                        v7 = nil
                        v8 = nil
                        for i7, i8 in i5.Selectors, v7, v8 do
                            v6 = runnable(i8)
                            if v6 and v6 ~= "" then
                                success_2, err_2 = pcall(Parent.QueryDescendants, Parent, v6)
                                if success_2 then
                                    for i9, i10 in err_2 do
                                        markNames(i10, v5, a2)
                                    end
                                else
                                    warn((("[UGUIReplay] style rule %* not recorded: %*"):format(i5.Rule:GetFullName(), err_2)))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function chain(a1) -- Line: 317 -- types: a1: string
    local v1, v2
    local v3 = {}
    for i in string.gmatch(a1 .. ">", "([^>]*)>") do
        v1 = string.match(i, "^%s*(.-)%s*$")
        if v1 ~= "" and string.match(v1, "^[%w_%-#%.]+$") then
            v2 = {}
            for j in string.gmatch(v1, "[#%.]?[%w_%-]+") do
                table.insert(v2, j)
            end
            table.insert(v3, v2)
            continue
        end
        return nil
    end
    if #v3 > 0 then
        return v3
    end
    return nil
end

local function ruleNames(a1) -- Line: 333 -- types: a1: userdata
    local v1 = {}
    local success, err = pcall(a1.GetProperties, a1)
    if success and type(err) == "table" then
        for i in err do
            table.insert(v1, i)
        end
    end
    return v1
end

function v2.Richer(a1) -- Line: 347 -- upvalues: sheetRules (val), chain (val) -- types: a1: userdata
    local v1, v2
    local StyleSheet = a1.StyleSheet
    if not StyleSheet then
        return nil, {}
    end
    local v3 = {}
    sheetRules(StyleSheet, {}, v3)
    local v4 = {}
    local v5 = false
    local v6 = {}
    local v7 = 0
    local v8 = nil
    local v9 = nil
    for i, j in v3, v8, v9 do
        table.insert(v4, j.Rule)
        if string.gsub(j.Rule.Selector, "%s", "") == "TextLabel>TextLabel" then
            v5 = true
        end
        v1 = {}
        for k, n in j.Selectors do
            v2 = chain(n)
            if v2 then
                table.insert(v1, v2)
                v7 = math.max(v7, #v2 - 1)
            end
        end
        if #v1 > 0 then
            table.insert(v6, {Rule = j.Rule, Paths = v1})
        end
    end
    if not v5 then
        return nil, v4
    end
    return {Rules = v6, Depth = v7}, v4
end

local function compoundMatches(a1, a2) -- Line: 381 -- upvalues: result (ref) -- types: a1: userdata, a2: table
    local v1
    local v2 = nil
    local v3 = nil
    local v4 = a1
    for i, j in a2, v2, v3 do
        v1 = string.sub(j, 1, 1)
        if v1 ~= "#" then
            if v1 ~= "." then
                if not v4:IsA(j) then
                    return false
                end
            elseif not v4:HasTag((string.sub(j, 2))) then
                return false
            end
        elseif (result(v4, "Name")) ~= string.sub(j, 2) then
            return false
        end
    end
    return true
end

local function pathMatches(a1, a2, a3) -- Line: 400
    -- upvalues: compoundMatches (val), result (ref)
    local v1 = a1
    for i = #a3, 2, -1 do
        if v1 and compoundMatches(v1, a3[i]) then
            continue
        end
        return false
    end
    local v2 = false
    if v1 == a2 then
        v2 = compoundMatches(a2, a3[1])
    end
    return v2
end

function v2.MarkRicher(a1, a2, a3, a4) -- Line: 417
    -- upvalues: pathMatches (val), u13 (val), markNames (val), ruleNames (val)
    local v1, v2
    local v3 = false
    local v4 = nil
    local v5 = nil
    for i, j in a3.Rules, v4, v5 do
        for k, n in j.Paths do
            if pathMatches(v6, v7, n) then
                if not u13[v6] then
                    u13[v6] = {}
                    v3 = true
                end
                v1 = markNames
                v2 = ruleNames(j.Rule)
                if not v1(v6, v2, v8) then
                    break
                end
                v3 = true
                break
            end
        end
    end
    return v3
end

function v2.Clear() -- Line: 441 -- upvalues: u13 (val)
    table.clear(u13)
end

return (table.freeze(v2))