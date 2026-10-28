-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Features.Themes
-- Decompile time: 9.88 ms

local u0 = {}
local Utility = require(script.Parent.Parent.Utility)
local Default = require(script.Default)

function u0.getThemeValue(a1, a2, a3, a4) -- Line: 16
    if a1 then
        local v1, v2, v3
        for k, v in pairs(a1) do
            v3, v1, v2 = unpack(v)
            if a2 == v3 and a3 == v1 then
                return v2
            end
        end
    end
    return nil
end

function u0.getInstanceValue(a1, a2) -- Line: 28
    local success, err = pcall(function() -- Line: 29 -- upvalues: a1 (val), a2 (val)
        return a1[a2]
    end)
    if not success then
        err = a1:GetAttribute(a2)
    end
    return err
end

function u0.getRealInstance(a1) -- Line: 38
    if not a1:GetAttribute("IsAClippedClone") then
        return
    end
    local OriginalInstance = a1:FindFirstChild("OriginalInstance")
    if not OriginalInstance then
        return
    end
    return OriginalInstance.Value
end

function u0.getClippedClone(a1) -- Line: 49
    if not a1:GetAttribute("HasAClippedClone") then
        return
    end
    local ClippedClone = a1:FindFirstChild("ClippedClone")
    if not ClippedClone then
        return
    end
    return ClippedClone.Value
end

function u0.refresh(a1, a2, a3) -- Line: 60 -- upvalues: u0 (val)
    local Attribute, v1, v2, v3, v4
    if a3 then
        u0.apply(a1, a2, a3, u0.getThemeValue(a1:getStateGroup(), a2.Name, a3) or u0.getInstanceValue(a2, a3), true)
        return
    end
    local v5 = a1:getStateGroup()
    if not v5 then
        return
    end
    local v6 = {[a2.Name] = a2}
    for k, v in pairs(a2:GetDescendants()) do
        Attribute = v:GetAttribute("Collective")
        if Attribute then
            v6[Attribute] = v
        end
        v6[v.Name] = v
    end
    for k2, i in pairs(v5) do
        v1, v2, v3 = unpack(i)
        v4 = v6[v1]
        if v4 then
            u0.apply(v7, v4.Name, v2, v3, true)
        end
    end
end

function u0.apply(a1, a2, a3, a4, a5) -- Line: 93 -- upvalues: u0 (val)
    local success, v1, v2, v3
    if a1.isDestroyed then
        return
    end
    local Name = a2
    if typeof(a2) ~= "Instance" then
        v2 = a1:getInstanceOrCollective(a2)
    else
        v2 = {a2}
        Name = a2.Name
    end
    local v4 = a1.customBehaviours[Name .. "-" .. a3]
    for k, v in pairs(v2) do
        v3 = u0.getClippedClone(v)
        if v3 then
            table.insert(v2, v3)
        end
    end
    for k2, i in pairs(v2) do
        if a3 ~= "Position" or not u0.getClippedClone(i) then
            if a3 ~= "Size" or not u0.getRealInstance(i) then
                v1 = u0.getInstanceValue(i, a3)
                if a5 or a4 ~= v1 then
                    if v4 then
                        v1 = v4(a4, i, a3)
                        if v1 ~= nil then
                            a4 = v1
                        end
                    end
                    success = pcall(function() -- Line: 139 -- upvalues: i (val), a3 (val), a4 (ref)
                        i[a3] = a4
                    end)
                    if not success then
                        i:SetAttribute(a3, a4)
                    end
                end
            end
        end
    end
end

function u0.getModifications(a1) -- Line: 153
    if typeof(a1[1]) ~= "table" then
        a1 = {a1}
    end
    return a1
end

function u0.merge(a1, a2, a3) -- Line: 162 -- upvalues: u0 (val)
    local v1, v2, v3
    local v4, v5, v6, v7 = table.unpack(a2)
    v2, v3, _, v1 = table.unpack(a1)
    if v4 == v2 and v5 == v3 and u0.statesMatch(v7, v1) then
        a1[3] = v6
        if a3 then
            a3(a1)
        end
        return true
    end
    return false
end

function u0.modify(a1, a2, a3) -- Line: 175 -- upvalues: Utility (val), u0 (val)
    task.spawn(function() -- Line: 183 -- upvalues: a3 (ref), Utility (upval), a2 (ref), u0 (upval), a1 (val)
        local nowSetIt, v1
        a3 = a3 or Utility.generateUID()
        a2 = u0.getModifications(a2)
        for k, v in pairs(a2) do
            u23, u24, u25, v1 = table.unpack(v)
            if v1 == nil then
                u0.modify(a1, {u23, u24, u25, "Selected"}, a3)
                u0.modify(a1, {u23, u24, u25, "Viewing"}, a3)
            end
            local u51 = Utility.formatStateName(v1 or "Deselected")
            local u57 = a1:getStateGroup(u51)

            function nowSetIt() -- Line: 195
                -- upvalues: u51 (val), a1 (upval), u0 (upval), u23 (val), u24 (val), u25 (val)
                if u51 == a1.activeState then
                    u0.apply(a1, u23, u24, u25)
                end
            end

            ;(function() -- Line: 200
                -- upvalues: u57 (val), u0 (upval), v (val), a3 (upval), u51 (val), a1 (upval), u23 (val), u24 (val)
                -- upvalues: u25 (val)
                for k, i in pairs(u57) do
                    if u0.merge(i, v, function(a1_2) -- Line: 202
                        -- upvalues: a3 (upval), u51 (upval), a1 (upval), u0 (upval), u23 (upval), u24 (upval)
                        -- upvalues: u25 (upval)
                        local v1
                        a1_2[5] = a3
                        if u51 == a1.activeState then
                            u0.apply(a1, u23, u24, u25)
                        end
                        return
                    end) then
                        return
                    end
                end
                table.insert(u57, {u23, u24, u25, u51, a3})
                if u51 == a1.activeState then
                    u0.apply(a1, u23, u24, u25)
                end
            end)()
        end
    end)
    return a3
end

function u0.remove(a1, a2) -- Line: 220 -- upvalues: u0 (val)
    local v1, v2 = a1, a2
    for k, v in pairs(a1.appearance) do
        for i = #v, 1, -1 do
            if v[i][5] == v2 then
                table.remove(v, i)
            end
        end
    end
    u0.rebuild(v1)
end

function u0.removeWith(a1, a2, a3, a4) -- Line: 233 -- upvalues: u0 (val)
    local v1, v2, v3
    local v4, v5, v6, v7 = a1, a4, a2, a3
    for k, v in pairs(a1.appearance) do
        if v5 == k then
            for i = #v, 1, -1 do
                v1 = v[i]
                v2 = v1[1]
                v3 = v1[2]
                if v2 == v6 and v3 == v7 then
                    table.remove(v, i)
                end
            end
        elseif not v5 then
            for j = #v, 1, -1 do
                v1 = v[j]
                v2 = v1[1]
                v3 = v1[2]
                if v2 == v6 and v3 == v7 then
                    table.remove(v, j)
                end
            end
        end
    end
    u0.rebuild(v4)
end

function u0.change(a1) -- Line: 249 -- upvalues: u0 (val)
    local v1, v2, v3
    for k, v in pairs((a1:getStateGroup())) do
        v1, v2, v3 = unpack(v)
        u0.apply(a1, v1, v2, v3)
    end
end

function u0.set(a1, a2) -- Line: 259 -- upvalues: u0 (val)
    local themesJanitor = a1.themesJanitor
    themesJanitor:clean()
    themesJanitor:add((a1.stateChanged:Connect(function() -- Line: 265 -- upvalues: u0 (upval), a1 (val)
        u0.change(a1)
    end)))
    if typeof(a2) == "Instance" and a2:IsA("ModuleScript") then
        a2 = require(a2)
    end
    a1.appliedTheme = a2
    u0.rebuild(a1)
end

function u0.statesMatch(a1, a2) -- Line: 275
    local v1 = a1 and string.lower(a1)
    local v2 = a2 and string.lower(a2)
    local v3 = true
    if v1 ~= v2 then
        v3 = not a1 or not a2
    end
    return v3
end

function u0.rebuild(a1) -- Line: 282 -- upvalues: u0 (val), Utility (val), Default (val)
    local appliedTheme = a1.appliedTheme
    local u2 = {"Deselected", "Selected", "Viewing"}
    ;(function() -- Line: 289
        -- upvalues: u2 (val), u0 (upval), Utility (upval), Default (upval), appliedTheme (val), a1 (val)
        local updateDetails, v1, v2, v3
        for k, v in pairs(u2) do
            local u16 = {}

            function updateDetails(a1, a2) -- Line: 295 -- upvalues: u0 (upval), Utility (upval), u16 (val)
                local v1, v2, v3, v4
                if not a1 then
                    return
                end
                for k, v in pairs(a1) do
                    v2 = v[5]
                    v3 = v[4]
                    if u0.statesMatch(a2, v3) then
                        v4 = v[1] .. "-" .. v[2]
                        v1 = Utility.copyTable(v)
                        v1[5] = v2
                        u16[v4] = v1
                    end
                end
            end

            if v == "Selected" then
                updateDetails(Default, "Deselected")
            end
            updateDetails(Default, "Empty")
            updateDetails(Default, v)
            if appliedTheme ~= Default then
                if v == "Selected" then
                    updateDetails(appliedTheme, "Deselected")
                end
                updateDetails(Default, "Empty")
                updateDetails(appliedTheme, v)
            end
            v2 = {}
            v3 = a1.appearance[v]
            if v3 then
                for k2, i in pairs(v3) do
                    v1 = i[5]
                    if v1 ~= nil then
                        table.insert(v2, {i[1], i[2], i[3], v, v1})
                    end
                end
            end
            updateDetails(v2, v)
            v3 = {}
            for k3, j in pairs(u16) do
                table.insert(v3, j)
            end
            a1.appearance[v] = v3
        end
        u0.change(a1)
    end)()
end

return u0