-- Script path: ReplicatedStorage.Shared.Flags.BalanceConfig
-- Decompile time: 5.83 ms

local apply, cloneSelected, copy, selectFields, storable, validate
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local v1 = {}
local BindableEvent = Instance.new("BindableEvent")
v1.Changed = BindableEvent.Event
local u14 = {}
local u19 = FastFlags.Replicated("Game.Balance.Enabled", function(a1) -- Line: 12
    assert(type(a1) == "boolean")
    return a1
end, true)

function copy(a1) -- Line: 18 -- upvalues: copy (val)
    if type(a1) ~= "table" then
        return a1
    end
    local v1 = {}
    for i, j in a1 do
        v1[i] = (copy(j))
    end
    return v1
end

function storable(a1) -- Line: 32 -- upvalues: storable (val)
    local v1
    if type(a1) ~= "table" then
        return a1
    end
    local v2 = 0
    local v3 = true
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i in a1, v4, v5 do
        v2 = v2 + 1
        if type(i) ~= "number" or i % 1 ~= 0 or i < 1 then
            v3 = false
        end
    end
    v3 = v3 and v2 == #v6
    v2 = {}
    v4 = nil
    v5 = nil
    for j, k in v6, v4, v5 do
        v1 = if not v3 then tostring(j) else j
        v2[v1] = (storable(k))
    end
    return v2
end

function validate(a1, a2, a3) -- Line: 58 -- upvalues: validate (val)
    local v1, v2, v3, v4
    local v5 = a3 .. " has the wrong type"
    assert((type(a1)) == type(a2), v5)
    if type(a2) == "number" then
        v3 = false
        if a1 == a1 then
            v3 = (math.abs(a1)) < (1 / 0)
        end
        assert(v3, a3 .. " must be finite")
        v3 = true
        if not (a2 < 0) then
            v3 = a1 >= 0
        end
        assert(v3, a3 .. " must be nonnegative")
        return
    end
    if type(a2) ~= "table" then
        if type(a2) == "string" then
            v5 = a3 .. " identifies content and cannot be renamed"
            assert(a1 == a2, v5)
        end
        return
    end
    v3 = nil
    v5 = nil
    local v6 = a2
    for i, j in a1, v3, v5 do
        v1 = v6[v6[i] == nil and tonumber(i) or i] ~= nil
        v2 = tostring(i)
        assert(v1, v7 .. " has an unknown key " .. v2)
        validate(j, v6[v4], v7 .. "." .. tostring(i))
    end
end

function selectFields(a1, a2) -- Line: 76 -- upvalues: selectFields (val)
    local v1
    if a2 ~= true then
        v1 = {}
        for i, j in a2 do
            if a1[i] ~= nil then
                v1[i] = (selectFields(a1[i], j))
            end
        end
        return v1
    end
    if type(a1) ~= "table" then
        return a1
    end
    v1 = {}
    local v2 = nil
    local v3 = nil
    for k, n in a1, v2, v3 do
        if type(n) == "number" or type(n) == "table" or type(n) == "string" then
            v1[k] = (selectFields(n, true))
        end
    end
    return v1
end

function cloneSelected(a1, a2) -- Line: 104 -- upvalues: cloneSelected (val)
    local v1 = table.clone(a1)
    for i, j in a2 do
        if type(j) == "table" then
            v1[i] = (cloneSelected(a1[i], j))
        end
    end
    return v1
end

function apply(a1, a2, a3) -- Line: 116 -- upvalues: apply (val)
    local v1, v2, v3
    local v4 = nil
    local v5 = nil
    local v6 = a3
    for i, j in a2, v4, v5 do
        v2 = v6[i]
        if v2 == nil then
            v2 = v6[tostring(i)]
        end
        if type(j) ~= "table" then
            v3 = if v2 ~= nil then v2 else j
            v7[i] = v3
        else
            v1 = v2 or {}
            apply(v7[i], j, v1)
        end
    end
end

function v1.Bind(a1, a2, a3, a4, a5) -- Line: 132
    -- upvalues: u14 (val), selectFields (val), cloneSelected (val), validate (val), copy (val), apply (val)
    -- upvalues: FastFlags (val), storable (val), u19 (val), BindableEvent (val)
    assert(u14[a1] == nil, "Duplicate balance key " .. a1)
    local u40 = {}
    if not a4 then
        u40 = selectFields(a2, a3)
    else
        for i, j in a2 do
            u40[i] = (selectFields(j, a3))
        end
    end
    local u47 = cloneSelected(a2, u40)
    local u61 = FastFlags.Replicated(a1, function(a1_2) -- Line: 146 -- upvalues: validate (upval), u40 (ref), a1 (val), a5 (val), copy (upval), apply (upval)
        validate(a1_2, u40, a1)
        if a5 then
            local v1 = copy(u40)
            apply(v1, u40, a1_2)
            a5(v1)
        end
        return a1_2
    end, (storable(u40)))
    u14[a1] = u61

    local function refresh() -- Line: 163
        -- upvalues: apply (upval), u47 (val), u40 (ref), u19 (upval), u61 (val), BindableEvent (upval), a1 (val)
        local v1 = apply
        local v2 = if not u19:Get() then {} else u61:Get()
        v1(u47, u40, v2)
        BindableEvent:Fire(a1)
    end

    u61.Changed:Connect(refresh)
    u19.Changed:Connect(refresh)
    refresh()
    return u47
end

return table.freeze(v1)